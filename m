Return-Path: <linux-pci+bounces-38761-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499A4BF1CAE
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 16:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5CF84275D4
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 14:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03BB25A328;
	Mon, 20 Oct 2025 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LaE1wh8T"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D908324B2D;
	Mon, 20 Oct 2025 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969847; cv=none; b=J0E56v4MhBJyY/VDA0l5ap85VSWW4Iv4i+z4tgYQ/RhoS9aTk9/7E5k7gvItNCXRaJs6RXIAZGGs3dfEZTBm4DFmpas7vAcoZiXXvXN2V/7ptpLlSe+TdLZUkXx81Et8K2JwUTz9JEWjzf/9sB8knEnesdF5U7irMzx/uUMLx8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969847; c=relaxed/simple;
	bh=QB9CdOa26Kz2J9F8apkOMprzYuZ5f+UZb4ivDOAmhds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DRHsdyfI0PrQ31gn7trPMdEYkhKf03SV9Sh0bNt2fJDBDLh79StIazb9ZtErh0Z+vVkWoEBUWhJKuryyrLhLRlsoVSvD5aCsyRi8LQRteHXd0b8B7Zdn90m2mJmklGqXZ5M15dhwhEulPsVzKAyQGFttgh6dI+gCOWh7C4RD/b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LaE1wh8T; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760969836; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=L9u+mE9dC3rDy2AZuVZ/h7CRM8UL4x5A0aYpGW6XD4U=;
	b=LaE1wh8TjB0RTHvxm6t7SxN38y+genp/TeFv+LyGO9THTtGq4mMEEYKt1Bze6n0ZuSLpAmOJLyvr9KmqZEyQq7eU/UuZ+gbu35lXox+DhJTM9VLiSmmnU77FOPlknopmpWd5w2oxNB+118I0FKUhyXGROammWaJnpMyOCIyfTLc=
Received: from 30.246.161.241(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WqchTRM_1760969834 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 20 Oct 2025 22:17:15 +0800
Message-ID: <43390d36-147f-482c-b31a-d02c2624061f@linux.alibaba.com>
Date: Mon, 20 Oct 2025 22:17:10 +0800
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
 <6d7143a3-196f-49f8-8e71-a5abc81ae84b@linux.alibaba.com>
 <aPY--DJnNam9ejpT@wunner.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aPY--DJnNam9ejpT@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Lukas,

在 2025/10/20 21:54, Lukas Wunner 写道:
> On Mon, Oct 20, 2025 at 08:58:55PM +0800, Shuai Xue wrote:
>> ??? 2025/10/20 18:10, Lukas Wunner ??????:
>>> On Wed, Oct 15, 2025 at 10:41:57AM +0800, Shuai Xue wrote:
>>>> +++ b/drivers/pci/pcie/err.c
>>>> @@ -253,6 +254,16 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>>>    			pci_warn(bridge, "subordinate device reset failed\n");
>>>>    			goto failed;
>>>>    		}
>>>> +
>>>> +		/* Link recovered, report fatal errors of RCiEP or EP */
>>>> +		if (state == pci_channel_io_frozen &&
>>>> +		    (type == PCI_EXP_TYPE_ENDPOINT || type == PCI_EXP_TYPE_RC_END)) {
>>>> +			aer_add_error_device(&info, dev);
>>>> +			info.severity = AER_FATAL;
>>>> +			if (aer_get_device_error_info(&info, 0, true))
>>>> +				aer_print_error(&info, 0);
>>>> +			pci_dev_put(dev);
>>>> +		}
>>>
>>> Where is the the pci_dev_get() to balance the pci_dev_put() here?
>>
>> The corresponding pci_dev_get() is called in add_error_device(). Please
>> refer to commit 60271ab044a5 ("PCI/AER: Take reference on error
>> devices") which introduced this reference counting mechanism.
> 
> That is non-obvious and needs a code comment.

Agreed. I'll add a comment to clarify the reference counting relationship.

> 
>>> It feels awkward to leak AER-specific details into pcie_do_recovery().
>>> That function is supposed to implement the flow described in
>>> Documentation/PCI/pci-error-recovery.rst in a platform-agnostic way
>>> so that powerpc (EEH) and s390 could conceivably take advantage of it.
>>>
>>> Can you find a way to avoid this, e.g. report errors after
>>> pcie_do_recovery() has concluded?
>>
>> I understand your concern about keeping pcie_do_recovery()
>> platform-agnostic.
> 
> The code you're adding above, with the exception of the check for
> pci_channel_io_frozen, should live in a helper in aer.c.
> Then you also don't need to rename add_error_device().

Good point.

That's a much cleaner approach. I'll create a helper function in aer.c,
something like:

void aer_report_frozen_error(struct pci_dev *dev)
{
     struct aer_err_info info;

     if (dev->pci_type != PCI_EXP_TYPE_ENDPOINT &&
         dev->pci_type != PCI_EXP_TYPE_RC_END)
         return;

     aer_info_init(&info);
     aer_add_error_device(&info, dev);
     info.severity = AER_FATAL;
     if (aer_get_device_error_info(&info, 0, true))
         aer_print_error(&info, 0);

     /* pci_dev_put() pairs with pci_dev_get() in aer_add_error_device() */
     pci_dev_put(dev);
}

>> I explored the possibility of reporting errors after
>> recovery concludes, but unfortunately, this approach isn't feasible due
>> to the recovery sequence. The issue is that most drivers'
>> pci_error_handlers implement .slot_reset() which internally calls
>> pci_restore_state() to restore the device's configuration space and
>> state. This function also clears the device's AER status registers:
>>
>>    .slot_reset()
>>      => pci_restore_state()
>>        => pci_aer_clear_status()
> 
> This was added in 2015 by b07461a8e45b.  The commit claims that
> the errors are stale and can be ignored.  It turns out they cannot.
> 
> So maybe pci_restore_state() should print information about the
> errors before clearing them?

While that could work, we would lose the error severity information at
that point, which could lead to duplicate or less informative error
messages compared to what the AER driver provides. The helper function
approach preserves all error details for proper reporting.

> 
> Actually pci_restore_state() is only supposed to restore state,
> as the name implies, and not clear errors.  It seems questionable
> that the commit amended it to do that.
> 
>>> I'm also worried that errors are reported *during* recovery.
>>> I imagine this looks confusing to a user.  The logged messages
>>> should make it clear that these are errors that occurred *earlier*
>>> and are reported belatedly.
>>
>> You raise an excellent point about potential user confusion. The current
>> aer_print_error() interface doesn't indicate that these are historical
>> errors being reported belatedly. Would it be acceptable to add a
>> clarifying message before calling aer_print_error()? For example:
>>
>>    pci_err(dev, "Reporting error that occurred before recovery:\n");
> 
> Yes, something like that.  "Errors reported prior to reset"?  Dunno.

I'll use "Errors reported prior to reset" - it's clear and concise.

> 
> Thanks,
> 
> Lukas

Thanks.
Shuai

