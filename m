Return-Path: <linux-pci+bounces-38751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33197BF169C
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 15:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC1C64F8086
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 13:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B546320CAF;
	Mon, 20 Oct 2025 12:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gAhw3Fhf"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9A9313E1A;
	Mon, 20 Oct 2025 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965155; cv=none; b=mDPhqcrh3BO5eW1PNkZYh6KjC4UzQOIOtz8OP9B/8mhWJNshIjvoqsBdtWF6ZUzflseGE/I/XHifXIHyjmk7myj7HdVRFumgGtt52G1alkQAMrrad2KEIfmWIR++b6Uc2c97dkGb474/x7yaG+F107IWUOgK7pztOpJjt7csTd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965155; c=relaxed/simple;
	bh=hJGwDdy/cVGoByAo6t8ZfN/VwGD2JYemnH0/dl2RWSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aXRYm0lRth3sDBP6PmUoeb93OIKwKkKjsGHyL7ZSZl9Fn+b4Vz+d86ru7ZIgM1z0yjZTyKtinW2j7FGBxoscPKod7RoZjskk0sesQrWxo719TR6s7dHftIfUSolDyB6BegYT0vUI5qFqHa56MXId9YygE8S/7mMBlrUGDq2l3ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gAhw3Fhf; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760965142; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NUZ4OFbIPKN0hupA12avsNJ58g3zFU3PpdC+1cMmplk=;
	b=gAhw3Fhfv0sFNXUyobN6etJJVNKVp4EYW/PTJmBdIqySWSE010g5wXrwRGFoXMVRVLgMfoarxY0VMyyB0GvOY+aH1qvlQzpvTEg1/Dtz2K5Hb7bxIFYMETFgNrRPKSKDNHcKgB6UHD5xVatTCQIbdcq3JjWjXX3qV545xKRcd+M=
Received: from 30.246.161.241(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WqcKlem_1760965140 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 20 Oct 2025 20:59:01 +0800
Message-ID: <6d7143a3-196f-49f8-8e71-a5abc81ae84b@linux.alibaba.com>
Date: Mon, 20 Oct 2025 20:58:55 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] PCI/AER: Report fatal errors of RCiEP and EP if
 link recoverd
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Jonathan.Cameron@huawei.com, terry.bowman@amd.com,
 tianruidong@linux.alibaba.com
References: <20251015024159.56414-1-xueshuai@linux.alibaba.com>
 <20251015024159.56414-4-xueshuai@linux.alibaba.com>
 <aPYKe1UKKkR7qrt1@wunner.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aPYKe1UKKkR7qrt1@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/20 18:10, Lukas Wunner 写道:
> On Wed, Oct 15, 2025 at 10:41:57AM +0800, Shuai Xue wrote:
>> +++ b/drivers/pci/pcie/err.c
>> @@ -253,6 +254,16 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>   			pci_warn(bridge, "subordinate device reset failed\n");
>>   			goto failed;
>>   		}
>> +
>> +		/* Link recovered, report fatal errors of RCiEP or EP */
>> +		if (state == pci_channel_io_frozen &&
>> +		    (type == PCI_EXP_TYPE_ENDPOINT || type == PCI_EXP_TYPE_RC_END)) {
>> +			aer_add_error_device(&info, dev);
>> +			info.severity = AER_FATAL;
>> +			if (aer_get_device_error_info(&info, 0, true))
>> +				aer_print_error(&info, 0);
>> +			pci_dev_put(dev);
>> +		}
>>   	}

Hi, Lukas,

> 
> Where is the the pci_dev_get() to balance the pci_dev_put() here?

The corresponding pci_dev_get() is called in add_error_device(). Please
refer to commit 60271ab044a5 ("PCI/AER: Take reference on error
devices") which introduced this reference counting mechanism.

> 
> It feels awkward to leak AER-specific details into pcie_do_recovery().
> That function is supposed to implement the flow described in
> Documentation/PCI/pci-error-recovery.rst in a platform-agnostic way
> so that powerpc (EEH) and s390 could conceivably take advantage of it.
> 
> Can you find a way to avoid this, e.g. report errors after
> pcie_do_recovery() has concluded?

I understand your concern about keeping pcie_do_recovery()
platform-agnostic. I explored the possibility of reporting errors after
recovery concludes, but unfortunately, this approach isn't feasible due
to the recovery sequence. The issue is that most drivers'
pci_error_handlers implement .slot_reset() which internally calls
pci_restore_state() to restore the device's configuration space and
state. This function also clears the device's AER status registers:

   .slot_reset()
     => pci_restore_state()
       => pci_aer_clear_status()

Therefore, the only window to capture and report the original error
information is between link recovery (after reset_subordinates()) and
before .slot_reset() is called. Once .slot_reset() executes, the error
status is cleared and lost forever.

> 
> I'm also worried that errors are reported *during* recovery.
> I imagine this looks confusing to a user.  The logged messages
> should make it clear that these are errors that occurred *earlier*
> and are reported belatedly.

You raise an excellent point about potential user confusion. The current
aer_print_error() interface doesn't indicate that these are historical
errors being reported belatedly. Would it be acceptable to add a
clarifying message before calling aer_print_error()? For example:

   pci_err(dev, "Reporting error that occurred before recovery:\n");

Alternatively, if you have suggestions for a better approach to make
this timing clear to users, I'd be happy to implement them.

> 
> Thanks,
> 
> Lukas

Thanks for valuable comments.

Best Regards,
Shuai

