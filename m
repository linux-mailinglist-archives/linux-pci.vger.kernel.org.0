Return-Path: <linux-pci+bounces-20157-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39248A16F32
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 16:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4650A3A6569
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BF61E503D;
	Mon, 20 Jan 2025 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="lkMGZRFd"
X-Original-To: linux-pci@vger.kernel.org
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFC51E3DE4;
	Mon, 20 Jan 2025 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737386834; cv=none; b=sDl3m6apha/yW/Ys+aE3H6Qvx/1A2ocZCsvri+mgeHUV9SMwmy7mWpsHizQ4cZxrDvHl9OVXNeDBUOinzXQyDWFwFDdRuBX0XgjqmnprSwJG0Mo7hP75XzDoXwNHXC2rNpoi+nOM9+K7Hl3uyLgJrzzVm7Ew87eHt1gUJjfDdZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737386834; c=relaxed/simple;
	bh=VQvynbnRGrRMUEwbl6fkENt2Vyq/b6Pmd6EvkFbEB5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VExtbT+AKobGzzIMa0muTPoX7sEosIvBmTZ6B4ugfvP4sCYHoQaGLnilPTF4UoMwGFLuMiEEZoBAcLvZNL9CSaZC1zxbFlkfutdpU/Mb5xCYjKyc8OlLPG9YYFApXxN+W4apXTxWsQdzaAaSQydocAbRgioWEZl5va9vUVev7as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=lkMGZRFd; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1737386805; bh=1MFYJXZDNbBZjRNoGJC7eXt7K5pGRQV0zdRhzsdQzbc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lkMGZRFdLu+ZnK1x3Hwz2ChaZAPLDFdFOdHMjHnepc32pgmEf24OnM23/nvhT7ftT
	 bQUEhSfn5NJw9Si87zFhxzGGeYmZQq8JtQG8BekvlmjOlbMDLtIpONa+qwbzv1ce0u
	 XDi4Alz8X8TfZN6QbP9Nd0IOF9jQZybDU2tJ3vBc=
Received: from [IPV6:2409:8a00:78e3:4720:c022:5e89:361b:6a74] ([2409:8a00:78e3:4720:c022:5e89:361b:6a74])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 51B25E85; Mon, 20 Jan 2025 23:20:27 +0800
X-QQ-mid: xmsmtpt1737386427tz6ynmbea
Message-ID: <tencent_F1DFC27AA8603E10FDB0017CA1C4EF27D107@qq.com>
X-QQ-XMAILINFO: NgEKQrOzHIjOdCXBmvyZNM7/BJfXzT9UvuNYyOwaxQGrUiqxaVus15JI5QuUJU
	 8BEk9Lhtt/GCmytOwpr85OrlQwSsTc/pk/YS7yMdBR/v4fXuFfFxA0atuTzc7tUas6qpa4yhN+Mg
	 COmi/Bt9YJLBPWnSjLUIEMghYIq/QilJyx3iZQkV9AlJ3gAXAvtnJ1lEL/Uhnqg8Kvileb17Hpnc
	 TSsPUc89YjsVLdfKQh44BJsvMejMR08wtTcvP795lfbp6FlxrNkAGrLMBg5ClOScr+trWLEyuBkD
	 nnb8E0YMq0V4ea75wjFmqq2/Hajlbyue9W/L+ddkdrwF5/BMXUQPyHtAoUEC4ItKtEpPBGRYTvtq
	 ZIoHWuVBm7p4V4ZEkNVqTpKSdn8KHjVb3CFTfKF51ejmfBO/NX9YQ12gjl7NqLGZF2d/2zHfiKpu
	 SjXAttZH0BDhz+doeKnvgvRXk5n5kBbR/IyTqEMM66Tuiz8OBXh0bqOGR7VBXho1rl884oKs2lE5
	 bUBaiCLpeZ1dPZzGEpKV/c/R6Wvm0esUcdl2FZUak3b0KdJEJskjXKCEd867u2QJilgavGMsUVLo
	 JknpAB0lY2QioCJx09+a9pa/jJ6jBqLe2KgG0Re4mBy3vaHZoHCNA/vzM8j0xb0ijte/m4dERBEH
	 KFB/jpEShKHqZymARmLWgEQQkiUdQcQD28PE2uQ0wYWPmy3CCCH0Q2ZQrhduCLjQFLukHbHN7kgk
	 aP8T/6XusmO25x4JqwFmtdaPthqywE92C62/IG5kHslpgPeJEgGTukVT7B3hIX8LuDNwICFzNwo2
	 flaCQw9SETPjWsRoXpR+8zZVozKRh1vOdngXgmdj/tZ3ZO3DH2TNbazRkaoxXfPdz/0+aQDeVYe+
	 ywPYUcO7UXy7g31Amw0Zcfv+8QJaQX34vnT6qeHu2/fLONYZsvBlKbFTegRao7Ali/SqBUDglCeZ
	 KNIHgrWhe8spJ31WH/udeL3ekuvUYf9G/7Z7PWP4ZvWlnlqSwAVl9IuO7wpEQ2cWLv5xAg0Vj0z8
	 2W9HIsog==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-OQ-MSGID: <8092312d-5031-4a69-abc6-7d6d454d7d3b@qq.com>
Date: Mon, 20 Jan 2025 23:20:27 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: reread the Link Control 2 Register before
 using
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Jiwei Sun <sjiwei@163.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 helgaas@kernel.org, Lukas Wunner <lukas@wunner.de>, ahuang12@lenovo.com,
 sunjw10@lenovo.com, sunjw10@outlook.com
References: <20250115134154.9220-1-sjiwei@163.com>
 <20250115134154.9220-3-sjiwei@163.com>
 <4df1849e-c56e-b889-8807-437aab637112@linux.intel.com>
 <417720e7-c793-4c36-a542-a7e937e5a3cf@163.com>
 <alpine.DEB.2.21.2501180101360.27432@angie.orcam.me.uk>
 <tencent_DBC0851ABE9B45D70B4BA098F876F5F10609@qq.com>
 <alpine.DEB.2.21.2501201441590.27432@angie.orcam.me.uk>
Content-Language: en-US
From: Jiwei <jiwei.sun.bj@qq.com>
In-Reply-To: <alpine.DEB.2.21.2501201441590.27432@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/20/25 23:05, Maciej W. Rozycki wrote:
> On Mon, 20 Jan 2025, Jiwei wrote:
> 
>>>> However, within this section of code, lnkctl2 is not modified (after 
>>>> reading from register on line 111) at all and remains 0x5. This results 
>>>> in the condition on line 130 evaluating to 0 (false), which in turn 
>>>> prevents the code from line 132 onward from being executed. The removing
>>>> 2.5GT/s downstream link speed restriction work can not be done.
>>>
>>>  It seems like a regression from my original code indeed.
>>
>> Sorry, I am confused by this sentence.
> 
>  Sorry to be unclear, it refers to the paragraph quoted.
> 
>> IIUC, there is no regression regarding the lifting 2.5GT/s restriction in
>> the commit a89c82249c37 ("PCI: Work around PCIe link training failures").
> 
>  That's my original code we have regressed from.
> 
>> However, since commit de9a6c8d5dbf ("PCI/bwctrl: Add 
>> pcie_set_target_speed() to set PCIe Link Speed"), the code to lift the 
>> restriction is no longer executed. Therefore, commit de9a6c8d5dbf 
>> ("PCI/bwctrl: Add pcie_set_target_speed() to set PCIe Link Speed") can be
>> considered a regression of commit a a89c82249c37 ("PCI: Work around PCIe
>> link training failures").
> 
>  Yes, that accurately reflects the intent of what I wrote above.
> 
>> So, this fix patch(PCI: reread the Link Control 2 Register before using) 
>> is required, right?
> 
>  Original code just fiddled with `lnkctl2' already retrieved.  With that 
> replaced by a call to `pcie_set_target_speed' I think rereading from Link 
> Control 2 is probably the best fix, however I'd suggest to clean up all 
> the leftovers from old code on this occasion, along the lines of the diff 
> below (untested).
> 
>   Maciej
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 76f4df75b08a..84267d7f847d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -108,13 +108,13 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>  	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
>  		return ret;
>  
> -	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
>  	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
>  	if (!(lnksta & PCI_EXP_LNKSTA_DLLLA) && pcie_lbms_seen(dev, lnksta)) {
> -		u16 oldlnkctl2 = lnkctl2;
> +		u16 oldlnkctl2;
>  
>  		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
>  
> +		pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &oldlnkctl2);
>  		ret = pcie_set_target_speed(dev, PCIE_SPEED_2_5GT, false);
>  		if (ret) {
>  			pci_info(dev, "retraining failed\n");
> @@ -126,6 +126,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>  		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
>  	}
>  
> +	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
>  	if ((lnksta & PCI_EXP_LNKSTA_DLLLA) &&
>  	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
>  	    pci_match_id(ids, dev)) {

Thanks for your suggestion. The patch that you modified is better; I will
do some tests tomorrow and send the v3 patch.

Thanks,
Regards,
Jiwei


