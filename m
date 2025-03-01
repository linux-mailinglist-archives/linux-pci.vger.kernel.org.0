Return-Path: <linux-pci+bounces-22699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBCBA4AAEF
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 13:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B7B171C3E
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 12:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717681E519;
	Sat,  1 Mar 2025 12:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LvYGjVPW"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8871DC9B8;
	Sat,  1 Mar 2025 12:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740832422; cv=none; b=SOpl5gj+fQaaO0sl+qxYTCeGK1z5iBPNINdHQsz7ZMvyDrjsA02wEhVkIKX0578hdsvMEceXde31HFrTHfxP/K9PkHW5w0fPD2HD+c70/pk4vvs8pXUSIpCVCjwP6HItKWwyDV7S5f7NqOmZwz/3MSjOGLUbIMzNryAygjmvKEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740832422; c=relaxed/simple;
	bh=hoGNaw66zY8elanyRVHpxhV8nLjZzs6d48q/6IGCYRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qz+Pk3F7f9lG3i0YCewAtE2smvxDUxKIt1gIOQulKbPVDL4mYefYs92gPBbGOGY97fsvoFk3rWlb43SjUCdKjAxk0rx7So/dQbcjZSUEua7Z+jJ7TyK5P/hA0hsaATlvDqspldn5b3UR9jbArN7OSZmeH+8ienh2sCfPrER8elc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LvYGjVPW; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=wBylOp52gRDZlcE3b5o2vywR841Y7DslpTMCW7/aVEk=;
	b=LvYGjVPW9LxIRoxeVoY9wsd01P6g598BBDfreqgXLE7RunTIFuwMPRdjVqHOz3
	siFgPwmUzFR2EVmn59FLzgsdUevma6xFuIUx7ZicQ56PSCZP4CZs00nsNep2OvVm
	hAUz5aOFqi4GiXGdh7RzfDuJtvCWpeEL2DSClMwJxK2R8=
Received: from [192.168.71.45] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDHb0p8_sJnWOTyOw--.24838S2;
	Sat, 01 Mar 2025 20:33:01 +0800 (CST)
Message-ID: <1f4b46a9-e71f-4201-a55f-41cc26d3ba66@163.com>
Date: Sat, 1 Mar 2025 20:33:01 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] genirq/msi: Add the address and data that show MSI/MSIX
To: Thomas Gleixner <tglx@linutronix.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: kw@linux.com, kwilczynski@kernel.org, bhelgaas@google.com,
 cassel@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250227162821.253020-1-18255117159@163.com>
 <20250227163937.wv4hsucatyandde3@thinkpad> <877c5be0no.ffs@tglx>
 <251ce5c0-8c10-4b29-9ffb-592e908187fd@163.com> <874j0ee2ds.ffs@tglx>
 <86d23e69-e6e5-476b-9582-28352852ea94@163.com> <87v7suc4yb.ffs@tglx>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <87v7suc4yb.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDHb0p8_sJnWOTyOw--.24838S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrKF43Gw1rJr47uF1xZFW7XFb_yoW8JF1UpF
	Z8JFsrGrW7X3WjvF4Ig3WDX34akFs8tr1jy345KF13Aw4kA3sakF10ga17CF9xZF1akr1U
	A3W5WwnrWrs8CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U_hLnUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwkDo2fC+MxS1QAAsw



On 2025/3/1 02:14, Thomas Gleixner wrote:
> On Fri, Feb 28 2025 at 23:17, Hans Zhang wrote:
>> I'm very sorry that I didn't understand what you meant at the
>> beginning.
> 
> No problem.
> 
>>
>> +static void msi_domain_debug_show(struct seq_file *m, struct irq_domain *d,
>> +                                 struct irq_data *irqd, int ind)
>> +{
>> +       struct msi_desc *desc;
>> +       bool is_msix;
>> +
>> +       desc = irq_get_msi_desc(irqd->irq);
>> +       if (!desc)
>> +               return;
>> +
>> +       is_msix = desc->pci.msi_attrib.is_msix;
>> +       seq_printf(m, "%*s%s:", ind, "", is_msix ? "msix" : "msi");
>> +       seq_printf(m, "\n%*saddress_hi: 0x%08x", ind + 1, "",
>> +                  desc->msg.address_hi);
> 
> No need for these line breaks. You have 100 characters available.
> 

Will change.

Best regards
Hans

>> +       seq_printf(m, "\n%*saddress_lo: 0x%08x", ind + 1, "",
>> +                  desc->msg.address_lo);
>> +       seq_printf(m, "\n%*smsg_data:   0x%08x\n", ind + 1, "",
>> +                  desc->msg.data);
>> +}
>> +
>>    static const struct irq_domain_ops msi_domain_ops = {
>>           .alloc          = msi_domain_alloc,
>>           .free           = msi_domain_free,
>>           .activate       = msi_domain_activate,
>>           .deactivate     = msi_domain_deactivate,
>>           .translate      = msi_domain_translate,
>> +       .debug_show     = msi_domain_debug_show,
>>    };
> 
> Looks about right.
> 
> Thanks,
> 
>          tglx


