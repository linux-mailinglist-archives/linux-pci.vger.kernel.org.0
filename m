Return-Path: <linux-pci+bounces-44605-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF282D1925C
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 14:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADD3B3062167
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 13:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4014310777;
	Tue, 13 Jan 2026 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="XVeS78f+"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-o90.zoho.com (sender4-pp-o90.zoho.com [136.143.188.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A548838BF87;
	Tue, 13 Jan 2026 13:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768311893; cv=pass; b=UQ+VtQL843MdQ9E2EM/lzOr3IKRp58Z9nmfMGq3N9A+iGTWeHfjISj7W6P9CH4GmnwUNNr+sRID4Tf4uixmCZkB+HwS+x1N0C5kdyUVrK1V0vV8+hnCRTyGJKmz7wYgk0zegQJ1N724cZ/ZCxS2LqTQDJWYZa1ATQ8QsE28AUR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768311893; c=relaxed/simple;
	bh=4Gt/84Q+V5euNC7bgqpKx6HdoPNXpstkSBpwu9PaaZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMSY6lLVyM2NX1nfmLMeozBe/rF/5mRxEvMy2DHHuY3nEUIX8jsqMQRrlEorxfWtQANsbiGFwJwPlIlcPZlLBsjpYbm6w0JyljpIyyeZ7sbY8khfEkOEbYv3KCvDcNxvG18JbU5JKQMoLGwk3HnpAq6FFUSUHOU+RN6m7cfhV34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=XVeS78f+; arc=pass smtp.client-ip=136.143.188.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1768311883; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=i1WLLgWF506AlbMBXiCAv/2t9VEffnz1Hz2110h0ISMTbdS3KluoTs0eahQoL2mBFiNHVDoOY0IJEf/VNq3vV9k6QKGqEq5OVE/HjO+5ax0RIyqfIYRtqyqROAeScu6OMvexcU8hWmakTJByzoX1MwpMp0cHmhCds0/4ZU+VZik=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768311883; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IOYFfwbNhRu26SipoEbEjskn3DVZyhOKMh76jzWEV2A=; 
	b=Dx5JnK3rRM0WbfmxmnJlzqiyGHcDb8NER0tRMPpzsYXvPBB0LKk7gJ7Yd5p4SZE/Cr5ZNRJHqsUQKZ3oYqyl8se3dTBkgQZ9O/tHcZrZzVc7Anyjzy7hRZAJZrB28PBA2dgrEcCojuPsEVSdJ+Cr3W1EBu6VFjwGOITUha7hfh0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768311883;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=IOYFfwbNhRu26SipoEbEjskn3DVZyhOKMh76jzWEV2A=;
	b=XVeS78f+o8y1Ka26k8E2/iB4slfQsjc60BJP+pS0ZIgmeh87ezXCT66r9Wfrxmba
	/NSFDQEsKvnaL58Zy2i0tTaGemOsiB0dpnySgiu64ARWYpfF1VBgOLlzDdeLamumt+M
	Nh1uPrR4eyHWrABEJ4xzJvaZyOR2Wb4JVf561pHs=
Received: by mx.zohomail.com with SMTPS id 1768311882285304.78439700796616;
	Tue, 13 Jan 2026 05:44:42 -0800 (PST)
Message-ID: <b5a2d815-7389-4bf1-9750-a2243cc1ffd2@zohomail.com>
Date: Tue, 13 Jan 2026 21:44:38 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] PCI/IDE: Fix using wrong VF ID for RID range
 calculation
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: dan.j.williams@intel.com, linux-pci@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260111080631.506487-1-ming.li@zohomail.com>
 <aWRctnwjEXvUyayb@yilunxu-OptiPlex-7050>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <aWRctnwjEXvUyayb@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112270578d1b8937d401e7e418a1f0000f11a1ad9d7fbd0ecdb4ef5799db54b0609d60c9a21441c95cf:zu08011227ae3811fbab9d3b660a75aa5a000071c90fc83e6eb4bd1589b5450004d2b0c66f0b549d75ef3727:rf080112326d311bc55c967f7ebcf7e82c000009d3c1dc8d59f3b4651200410d89272560c088c21c2ae178bed880c29303cc17de607440:ZohoMail
X-ZohoMailClient: External


在 2026/1/12 10:30, Xu Yilun 写道:
> On Sun, Jan 11, 2026 at 04:06:31PM +0800, Li Ming wrote:
>> When allocate a new IDE stream for a pci device in SR-IOV case, the RID
>> range of the new IDE stream should cover all VFs of the device. VF id
>> range of a pci device is [0 - (num_VFs - 1)], so should use (num_VFs - )
>> as the last VF's ID.
>>
>> Fixes: 1e4d2ff3ae45 ("PCI/IDE: Add IDE establishment helpers")
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>> ---
>>   drivers/pci/ide.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
>> index 26f7cc94ec31..9629f3ceb213 100644
>> --- a/drivers/pci/ide.c
>> +++ b/drivers/pci/ide.c
>> @@ -283,8 +283,8 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
>>   	/* for SR-IOV case, cover all VFs */
>>   	num_vf = pci_num_vf(pdev);
>>   	if (num_vf)
>> -		rid_end = PCI_DEVID(pci_iov_virtfn_bus(pdev, num_vf),
>> -				    pci_iov_virtfn_devfn(pdev, num_vf));
>> +		rid_end = PCI_DEVID(pci_iov_virtfn_bus(pdev, num_vf - 1),
>> +				    pci_iov_virtfn_devfn(pdev, num_vf - 1));
> I don't have VF for test but I believe the change is correct.
>
> The calculated rid_end will be passed to IDE RID association register values,
> which is inclusive according to IDE SPEC.
>
>    void pci_ide_stream_to_regs(...)
>    {
> 	...
> 	regs->rid1 = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT, settings->rid_end);
> 	...
>    }
>
> Is it better we clarify the kernel-doc a little bit:
>
> --------8<--------
>
> diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> index 2521a2914294..f0c6975fd429 100644
> --- a/include/linux/pci-ide.h
> +++ b/include/linux/pci-ide.h
> @@ -26,7 +26,7 @@ enum pci_ide_partner_select {
>   /**
>    * struct pci_ide_partner - Per port pair Selective IDE Stream settings
>    * @rid_start: Partner Port Requester ID range start
> - * @rid_end: Partner Port Requester ID range end
> + * @rid_end: Partner Port Requester ID range end (inclusive)
>    * @stream_index: Selective IDE Stream Register Block selection
>    * @mem_assoc: PCI bus memory address association for targeting peer partner
>    * @pref_assoc: PCI bus prefetchable memory address association for

Sure, will do that in V2, thanks for review.


Ming


