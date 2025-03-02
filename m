Return-Path: <linux-pci+bounces-22719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2A8A4B255
	for <lists+linux-pci@lfdr.de>; Sun,  2 Mar 2025 15:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8297C188B28A
	for <lists+linux-pci@lfdr.de>; Sun,  2 Mar 2025 14:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994A12AD0C;
	Sun,  2 Mar 2025 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SYmdZs9B"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132EC9461;
	Sun,  2 Mar 2025 14:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740926808; cv=none; b=WWER33PNGcjZtoTSawXU9Gh42hW9rtRrreXSrU118QuW7Twb74zQJyhn5b6/fOm726QO9C08RbfLzCl9qbApElF8DPZe+OxNpCHWUMWd3t+A2Hbl1zcqrtJV8x3IzbNK7e21PK0AC8QRai4o2Zsq5H0pkZwYVN+KJEdPNSQWqvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740926808; c=relaxed/simple;
	bh=hvmcuVauw0uLTPvM7e8Ma3E4SsGjODwsUwW7YyONMWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDb348ujKikMcuM3BrbFLpcPF17eut/dwoby+M2pq3SgyljjDB2zBLY/k45CGt4Q09/iSeoyvHOX7lqYwIUXXp0NJ3kveGrNPfUn7PvAzuakG96Z3GfoK95hWUJqiAEIthYYNX8QF0OLOCZFwbYVPS/085oXriSqul9prmsr8sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SYmdZs9B; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=Gb1K8XhuGi63V1c2N4AFQvfyqlwoNjG9VvY3sMS0MV8=;
	b=SYmdZs9Bop218lMsnAMil/IrmIpYAKmMA+NEQJ+jf8toR7RMQOnNu++W5HGjO5
	4d2kt2hfJbWNwwdVIZoGrSDvYrK/2fQqKVwqRPOnaD1c8Hv+mD1rhQT4pgP/m28v
	yYG609QI5vojB/c2JH9gySRf20yL64vRL4+HwQrjxFLAU=
Received: from [192.168.71.45] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3ny0Tb8Rn_kEePw--.7406S2;
	Sun, 02 Mar 2025 22:45:39 +0800 (CST)
Message-ID: <c7956816-7744-436c-94f6-fec4fe9d5635@163.com>
Date: Sun, 2 Mar 2025 22:45:39 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] genirq/msi: Add the address and data that show MSI/MSIX
To: Thomas Gleixner <tglx@linutronix.de>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kwilczynski@kernel.org,
 bhelgaas@google.com, Frank.Li@nxp.com, cassel@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250301123953.291675-1-18255117159@163.com>
 <87plizdcxd.ffs@tglx>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <87plizdcxd.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3ny0Tb8Rn_kEePw--.7406S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF45Gw1kZF47Gr15Ar15CFg_yoWruw17pa
	4UGF47G397Xr1Utr47Gw1UX345Ja4qyF1Utr18JFy3Crn8X3s2kry8t3y7WFy3Kr1Y9w1Y
	k3WUXa4Fqr9xCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U9jjgUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWw8Eo2fEbEsnVgABsH

Hi Thomas(tglx),

On 2025/3/2 17:01, Thomas Gleixner wrote:
> Hans!
> 
> On Sat, Mar 01 2025 at 20:39, Hans Zhang wrote:
>> The debug_show() callback function is implemented in the MSI core code.
>> And assign it to the domain ops::debug_show() creation.
>>
>> cat /sys/kernel/debug/irq/irqs/msi_irq_num, the address and data stored
>> in the MSI capability or the address and data stored in the MSIX vector
>> table will be displayed.
> 
> So this explains what the patch is doing and what the output is. But it
> fails to explain the _why_. Documentation gives proper guidance:
> 
>   https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog
>   https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-changes

Is the following explanation OK?

Displaying the address and data of the MSI/MSIX interrupt in the debugfs 
helps with debugging.

>> e.g.
>> root@root:/sys/kernel/debug/irq/irqs# cat /proc/interrupts | grep ITS
>>   85:          0          0          0          0          0          0          0          0          0          0          0          0   ITS-MSI 75497472 Edge      PCIe PME, aerdrv
>>   86:          0         30          0          0          0          0          0          0          0          0          0          0   ITS-MSI 76021760 Edge      nvme0q0
>>   87:        287          0          0          0          0          0          0          0          0          0          0          0   ITS-MSI 76021761 Edge      nvme0q1
>>   88:          0        265          0          0          0          0          0          0          0          0          0          0   ITS-MSI 76021762 Edge      nvme0q2
>>   89:          0          0        177          0          0          0          0          0          0          0          0          0   ITS-MSI 76021763 Edge      nvme0q3
>>   90:          0          0          0         76          0          0          0          0          0          0          0          0   ITS-MSI 76021764 Edge      nvme0q4
>>   91:          0          0          0          0        161          0          0          0          0          0          0          0   ITS-MSI 76021765 Edge      nvme0q5
>>   92:          0          0          0          0          0        991          0          0          0          0          0          0   ITS-MSI 76021766 Edge      nvme0q6
>>   93:          0          0          0          0          0          0        194          0          0          0          0          0   ITS-MSI 76021767 Edge      nvme0q7
>>   94:          0          0          0          0          0          0          0         94          0          0          0          0   ITS-MSI 76021768 Edge      nvme0q8
>>   95:          0          0          0          0          0          0          0          0        148          0          0          0   ITS-MSI 76021769 Edge      nvme0q9
>>   96:          0          0          0          0          0          0          0          0          0        261          0          0   ITS-MSI 76021770 Edge      nvme0q10
>>   97:          0          0          0          0          0          0          0          0          0          0        127          0   ITS-MSI 76021771 Edge      nvme0q11
>>   98:          0          0          0          0          0          0          0          0          0          0          0        317   ITS-MSI 76021772 Edge      nvme0q12
> 
> How is this relevant to describe the patch?

The preceding information will be deleted in v4 patch.

> 
>> root@root:/sys/kernel/debug/irq/irqs#
>> root@root:/sys/kernel/debug/irq/irqs# cat 87
>> handler:  handle_fasteoi_irq
>> device:   0000:91:00.0
>> status:   0x00000000
>> istate:   0x00004000
>> ddepth:   0
>> wdepth:   0
>> dstate:   0x31600200
>>              IRQD_ACTIVATED
>>              IRQD_IRQ_STARTED
>>              IRQD_SINGLE_TARGET
>>              IRQD_AFFINITY_MANAGED
>>              IRQD_AFFINITY_ON_ACTIVATE
>>              IRQD_HANDLE_ENFORCE_IRQCTX
>> node:     0
>> affinity: 0
>> effectiv: 0
>> domain:  :soc@0:interrupt-controller@0e001000:its@0e050000-3
>>   hwirq:   0x4880001
>>   chip:    ITS-MSI
> 
> This output is from a pre 6.11 kernel...

I will delete all other information except for what my patch will display.

> 
>>    flags:   0x20
>>               IRQCHIP_ONESHOT_SAFE
>>   msix:
>>    address_hi: 0x00000000
>>    address_lo: 0x0e060040
>>    msg_data:   0x00000001
> 
> For demonstration it's enough to stop here, no?

Yes, I will change it to the following:

    msix:
     address_hi: 0x00000000
     address_lo: 0x0e060040
     msg_data:   0x00000001

>    
>> +static void msi_domain_debug_show(struct seq_file *m, struct irq_domain *d,
>> +				  struct irq_data *irqd, int ind)
>> +{
>> +	struct msi_desc *desc;
>> +	bool is_msix;
>> +
>> +	desc = irq_get_msi_desc(irqd->irq);
> 
> Move this up to the declaration.
> 
>> +	if (!desc)
>> +		return;
>> +
>> +	is_msix = desc->pci.msi_attrib.is_msix;
> 
> That's not valid for non PCI MSI interrupts.

Do you mean to remove the following two lines of code?

is_msix = desc->pci.msi_attrib.is_msix;
seq_printf(m, "%*s%s:", ind, "", is_msix ? "msix" : "msi");

> This function is used for all types of MSI interrupts. So for non PCI
> MSI interrupts this will output random garbage. Just print the address
> and be done with it. The MSI variant is visible from the chip name on
> current kernels. It's either ITS-PCI-MSI or ITS-PCI-MSIX and not
> ITS-MSI.
> 
>> +	seq_printf(m, "%*s%s:", ind, "", is_msix ? "msix" : "msi");
>> +	seq_printf(m, "\n%*saddress_hi: 0x%08x", ind + 1, "", desc->msg.address_hi);
>> +	seq_printf(m, "\n%*saddress_lo: 0x%08x", ind + 1, "", desc->msg.address_lo);
>> +	seq_printf(m, "\n%*smsg_data:   0x%08x\n", ind + 1, "", desc->msg.data);
>> +}
>> +
>>   static const struct irq_domain_ops msi_domain_ops = {
>>   	.alloc		= msi_domain_alloc,
>>   	.free		= msi_domain_free,
>>   	.activate	= msi_domain_activate,
>>   	.deactivate	= msi_domain_deactivate,
>>   	.translate	= msi_domain_translate,
>> +	.debug_show     = msi_domain_debug_show,
> 
> This does not build when CONFIG_GENERIC_IRQ_DEBUGFS=n.
>
Kernel test robot has reported a compilation error, and I have submitted 
v3 patch to solve this problem. I will fix all your questions in v4 patch.

Finally, thank you very much for all your comments.

Best regards
Hans


