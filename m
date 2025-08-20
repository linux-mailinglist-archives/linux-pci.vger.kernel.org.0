Return-Path: <linux-pci+bounces-34336-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6562B2D284
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 05:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC981C237F4
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 03:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0FA276031;
	Wed, 20 Aug 2025 03:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6jzAC/o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD112258ECA;
	Wed, 20 Aug 2025 03:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755659945; cv=none; b=Y5Bm/5PdcZfyLcoBaIURYB/GCf37H7Mg5YJQ4L4kqtsfItDJr/RjTfVSdG7YcxX/sAiEAJNAKvtbbE0hybcS9I5GeWopkzuQ9iNtOd0cghPrKr4lrs63r9UCS2U2cCnjja4hU7mLN7ElCS4Mu2tdUCmYzJbkqSIM1hNghACqUOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755659945; c=relaxed/simple;
	bh=VxNrcNs0+HcvFMuKWSGBXGXSfd8y+whfhfnRdUacxr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UB+38Bj8pvPAsUsS6i3UMOkPdz15syJV0Ixn9abCZKGZbdOp+56DYgA0gn7+6eSTGneNV6U16hqSQi0xZifEuUtrwWrvm8ktv+XxD3NfJPpupbN8FdAF5NM1F+TODQL6kkLahzWrYzu6E7M9dyrkLCczlb3DuyUErsDeSfuvo7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6jzAC/o; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-afcb7ae31caso1081678366b.3;
        Tue, 19 Aug 2025 20:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755659942; x=1756264742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/vdg4dKKl5Y5qxmdvIci/v8EsYo7STve3t3ZtY/n9Z0=;
        b=b6jzAC/opmUJPUfGAVuh6XzUJAPB7oZdCzXoUlPSIy3WaldeEwyosPA8HRkf5MhjPy
         2zA2ThOFECkdqkIiJaafpjpC6uSFj8zID/JBz1lwPgrMLly07Q6rBX5Qxe2PZww+cR/S
         l8iz9KW3rExt19lhxQcV52D9fx0jST1c8q3tg8XTR/nAuCXJ8x3PvQ9UfZ2yVUgR4dbp
         bXvIQ6+/d1eGcQqltqApzlBUIDzyNzUuRW4UGI6TAGoH/jJ3uHap/8PtS3vhi8EV57ca
         xGrEqu46A9X+lBruB0LpudcwrX76i2MKBinHvkVt69vB1OKfS/mS+C/uFd1cIcR6V2iG
         +piA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755659942; x=1756264742;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vdg4dKKl5Y5qxmdvIci/v8EsYo7STve3t3ZtY/n9Z0=;
        b=iO41GXjJHLVLA1z897Jn3JAgQU5epAPz2Y0u/1sYOsqAtgmA3miCFM1M+c9XTPLbpk
         khHK5G6PJQX7hKTogxjp80T4iXAOuNT+krxTiTgccI9BuF3FjiCvadEca+kbZzJ4Zs3z
         /g8V35z4F9Q0+LWOU7ZU87UPQ3sQVXNsiOtpsEYptY0fob5cfFJU6FOeSE4zTJQZgPx8
         dTxfX4/b3KggpisCNYcF4hIk92xZMgvBDQrHt3fIdNjCIDFE9wOBPiUwbgHRe0p5uf5y
         /rAUK6b8EqXp2uq43F3+LEgsiXxwgdnuxiK+lJTNjKH4vOZqhl55TAjycXSpKd3tEvuO
         sshQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0g9dM055bnx4miV3vX2CYRgdDrfUtLGkHVCZ5vuKzu45ecLEzimY8V6UOmMG/BBDcyZkiYawIZesm@vger.kernel.org, AJvYcCWddljnhT/L32fSrJJy+oDBSD+YaJq5jEhdQwnwCb/3Q9jEK2YXDOeCJxYJ8ryaNxoE/1kky9NncPf9Qu4=@vger.kernel.org, AJvYcCXXqdjYbUiIO47CfRwss/LnzPQJHfFBVq3bwLQquy1FAESDkVjaABJzVCACOOzpNMbbetFGe4D0g75fheBO@vger.kernel.org, AJvYcCXapww5zxkXMyX7TzVlDUvAp62BSWQG3jvtCWSPzkuDcw2en2PSnkOkOhv9H220XpEPMEef9fjxseUrDJNvwQ==@vger.kernel.org, AJvYcCXdo5GeByoA61dZ3Ps64BI8An78zAB6auQhJF0n0EYoxLVpEkXIu0bNF8yvt7AcgNEYGZlQjr0n46JM@vger.kernel.org
X-Gm-Message-State: AOJu0YxaSQld2T9/uVvT7e3qAvt68qr3tK1nFl14rwp7ewLEMVYumaYc
	xlIjQhtpf96QSaBymm4a366TKXMAyZg6GvvziKvS6GsP8KNzlAxPlD6D
X-Gm-Gg: ASbGncsm1WER2baOi+0hI8MND45eJC5lNVNcYeOQlk5aCFFAjmcZ7QDhCuCcNjQEeYT
	237mjm1+bRr3v52wKJSAbPoD5FuCeqho0mlvzKTG19NRvvtTFiUWCZw4su/cig7Mv+LIaNxcOy1
	xcF4i5HggcbzsE/lXcI3h8j4kwKi6KgyUhZmE1xG+rEMjvm9Kuvz7Sx2qpnUEtQZWIf7fhpCS6B
	9/NhhJsl2RMsDjYwPQ4TeD/pgOF33hwLiuTWmS5ageW7FedOBrvKEu9BR93wciTQ+4tWjii359A
	g7sDH415qwdYWOGlyRQj7KvB5jnMrK3l2+8sCLUlPCC3DaXwKBfbnvkAntOYc2+rvkl6YbC911U
	VC9OzoYCdqoSnBxerihEMNeKTr/uoyU6wpVKarQACg/DGQpV+7HzMIPwlA9kiWP/bujd+nOXt/s
	TMMP6rXpyXkYkSOyjrsEmyv7+4MCrLQlgPkA==
X-Google-Smtp-Source: AGHT+IEIwwlIwoTIiNuhUQ07/bBrVkoWwe0s7LnQYSy2POy+c888AvHzKbMqqWN1VrmqgpQIHAF1pA==
X-Received: by 2002:a17:906:6a1d:b0:af9:237c:bb35 with SMTP id a640c23a62f3a-afdf00e2e81mr95410766b.22.1755659941758;
        Tue, 19 Aug 2025 20:19:01 -0700 (PDT)
Received: from [26.26.26.1] (ec2-3-75-144-20.eu-central-1.compute.amazonaws.com. [3.75.144.20])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded52ea4asm96482666b.101.2025.08.19.20.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 20:19:01 -0700 (PDT)
Message-ID: <d6b852bc-328a-41af-b125-e250c72c0d22@gmail.com>
Date: Wed, 20 Aug 2025 11:18:52 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] pci: Suspend iommu function prior to resetting a
 device
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, bhelgaas@google.com,
 jgg@nvidia.com, will@kernel.org, robin.clark@oss.qualcomm.com,
 yong.wu@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, thierry.reding@gmail.com,
 vdumpa@nvidia.com, jonathanh@nvidia.com, rafael@kernel.org, lenb@kernel.org,
 kevin.tian@intel.com, yi.l.liu@intel.com, baolu.lu@linux.intel.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
 patches@lists.linux.dev, pjaroszynski@nvidia.com, vsethi@nvidia.com,
 helgaas@kernel.org
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <3749cd6a1430ac36d1af1fadaa4d90ceffef9c62.1754952762.git.nicolinc@nvidia.com>
 <550635db-00ce-410e-add0-77c1a75adb11@gmail.com>
 <aKTzq6SLGB22Xq5b@Asurada-Nvidia>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <aKTzq6SLGB22Xq5b@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/20/2025 5:59 AM, Nicolin Chen wrote:
> On Tue, Aug 19, 2025 at 10:12:41PM +0800, Ethan Zhao wrote:
>> On 8/12/2025 6:59 AM, Nicolin Chen wrote:
>>> @@ -4529,13 +4530,26 @@ EXPORT_SYMBOL(pci_wait_for_pending_transaction);
>>>     */
>>>    int pcie_flr(struct pci_dev *dev)
>>>    {
>>> +	int ret = 0;
>>> +
>>>    	if (!pci_wait_for_pending_transaction(dev))
>>>    		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
>>> +	/*
>>> +	 * Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software disables ATS
>>> +	 * before initiating a reset. Notify the iommu driver that enabled ATS.
>>> +	 * Have to call it after waiting for pending DMA transaction.
>>> +	 */
>>> +	ret = iommu_dev_reset_prepare(&dev->dev);
> 
>> If we dont' consider the association between IOMMU and devices in FLR(),
>> it can be understood that more complex processing logic resides outside
>> this function. However, if the FLR() function already synchironizes and
>> handles the association with IOMMU like this (disabling ATS by attaching
>> device to blocking domain), then how would the following scenarios
>> behave ?
> 
> That's a good point. The iommu-level reset is per struct device.
> So, basically it'll match with the FLR per pci_dev. Yet, the RID
> isolation between siblings might be a concern:
> 
>> 1. Reset one of PCIe alias devices.
> 
> IIRC, an alias device might have:
> 
>   a) one pci_dev; multiple RIDs
> 
>      In this case, neither FLR nor IOMMU isolates between RIDs.
>      So, both FLR and IOMMU blocking will reset all RIDs. There
>      should be no issue resulted from the IOMMU blocking.
> 
>   b) multiple pci_devs; single RID
> 
>      In this case, FLR only resets one device, while the IOMMU-
>      level reset will block the entire RID (i.e. all devices),
>      since they share the single translation tunnel. This could
>      break the siblings, if they aren't also being reset along.
Yup, such alias devices might not have ATS cap. because of they
are PCI devices or they share the RID(BDF), so checking ATS cap
condition might be useful here to skip the prepare()/done() .>
>> 2. Reset PF when its VFs are actvie.
> 
>   c) multiple pci_devs with their own RIDs
> 
>      In this case, either FLR or IOMMU only resets the PF. That
>      being said, VFs might be affected since PF is resetting?
>      If there is an issue, I don't see it coming from the IOMMU-
>      level reset..
Each of the PF and its VFs has it owns RID(BDF), but the VFs' life
depends on the living of PF, resetting PF, means all its VFs are
lost.

There is no processing logic about PF and its VFs in FLR() yet.
my understanding the upper layer callers should consider the
complexity of such case.

While we introducing the connection of IOMMU & device in FLR(),
seems we brought some of the logic from the outside to the inside
part.

One method might we don't handle PF either by explicit checking its
VF configuration existing to skip prepare()/done() ? till we have
much clearer handling logic about it.

Thanks,
Ethan
   > d
> Thus, case b might be breaking. So, perhaps we should add a few
> conditions when calling iommu_dev_reset_prepare/done():
>   + Make sure that the pci_dev has ATS capability
>   + Make sure no sibling pci_dev(s) sharing the same RID
>   + Any others?
> 
> Thanks
> Nicolin


