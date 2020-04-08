Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B65101A1E7A
	for <lists+linux-pci@lfdr.de>; Wed,  8 Apr 2020 12:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgDHKDW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Apr 2020 06:03:22 -0400
Received: from foss.arm.com ([217.140.110.172]:36458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgDHKDW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Apr 2020 06:03:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8FF131B;
        Wed,  8 Apr 2020 03:03:21 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 681F43F73D;
        Wed,  8 Apr 2020 03:03:19 -0700 (PDT)
Subject: Re: [PATCH v6 1/2] ACPI / APEI: Add support to notify the vendor
 specific HW errors
To:     Borislav Petkov <bp@alien8.de>, Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        helgaas@kernel.org, lenb@kernel.org, tony.luck@intel.com,
        gregkh@linuxfoundation.org, zhangliguang@linux.alibaba.com,
        tglx@linutronix.de, linuxarm@huawei.com,
        jonathan.cameron@huawei.com, tanxiaofei@huawei.com,
        yangyicong@hisilicon.com
References: <ShijuJose> <20200325164223.650-1-shiju.jose@huawei.com>
 <20200325164223.650-2-shiju.jose@huawei.com> <20200327182214.GD8015@zn.tnic>
From:   James Morse <james.morse@arm.com>
Message-ID: <c73bb18b-02ef-6c35-f4cf-1738c17a96e5@arm.com>
Date:   Wed, 8 Apr 2020 11:03:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200327182214.GD8015@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Boris, Shiju,

Sorry for not spotting this reply earlier: Its in-reply to v1, so gets buried.

On 27/03/2020 18:22, Borislav Petkov wrote:
> On Wed, Mar 25, 2020 at 04:42:22PM +0000, Shiju Jose wrote:
>> Presently APEI does not support reporting the vendor specific
>> HW errors, received in the vendor defined table entries, to the
>> vendor drivers for any recovery.
>>
>> This patch adds the support to register and unregister the
> 
> Avoid having "This patch" or "This commit" in the commit message. It is
> tautologically useless.
> 
> Also, do
> 
> $ git grep 'This patch' Documentation/process
> 
> for more details.
> 
>> error handling function for the vendor specific HW errors and
>> notify the registered kernel driver.

>> @@ -526,10 +552,17 @@ static void ghes_do_proc(struct ghes *ghes,
>>  			log_arm_hw_error(err);
>>  		} else {
>>  			void *err = acpi_hest_get_payload(gdata);
>> +			u8 error_handled = false;
>> +			int ret;
>> +
>> +			ret = atomic_notifier_call_chain(&ghes_event_notify_list, 0, gdata);
> 
> Well, this is a notifier with standard name for a non-standard event.
> Not optimal.
> 
> Why does only this event need a notifier? Because your driver is
> interested in only those events?

Its the 'else' catch-all for stuff drivers/acpi/apei  doesn't know to handle.

In this case its because its a vendor specific GUID that only the vendor driver knows how
to parse.


>> +			if (ret & NOTIFY_OK)
>> +				error_handled = true;
>>  
>>  			log_non_standard_event(sec_type, fru_id, fru_text,
>>  					       sec_sev, err,
>> -					       gdata->error_data_length);
>> +					       gdata->error_data_length,
>> +					       error_handled);
> 
> What's that error_handled thing for? That's just silly.
> 
> Your notifier returns NOTIFY_STOP when it has queued the error. If you
> don't want to log it, just test == NOTIFY_STOP and do not log it then.

My thinking for this being needed was so user-space consumers of those tracepoints keep
working. Otherwise you upgrade, get this feature, and your user-space counters stop working.

You'd need to know this error source was now managed by an in-kernel driver, which may
report the errors somewhere else...


> Then your notifier callback is queuing the error into a kfifo for
> whatever reason and then scheduling a workqueue to handle it in user
> context...
> 
> So I'm thinking that it would be better if you:
> 
> * make that kfifo generic and part of ghes.c and queue all types of
> error records into it in ghes_do_proc() - not just the non-standard
> ones.

Move the drop to process context into ghes.c? This should result in less code.

I asked for this hooking to only be for the 'catch all' don't-know case so that we don't
get drivers trying to hook and handle memory errors. (if we ever wanted that, it should be
from part of memory_failure() so it catches all the ways of reporting memory-failure)
32bit arm has prior in this area.


> * then, when you're done queuing, you kick a workqueue.
> 
> * that workqueue runs a normal, blocking notifier to which drivers
> register.
> 
> Your driver can register to that notifier too and do the normal handling
> then and not have this ad-hoc, semi-generic, semi-vendor-specific thing.

As long as we don't walk a list of things that might handle a memory-error, and have some
random driver try and NOTIFY_STOP it....

aer_recover_queue() would be replaced by this. memory_failure_queue() has one additional
caller in drivers/ras/cec.c.


Thanks,

James
