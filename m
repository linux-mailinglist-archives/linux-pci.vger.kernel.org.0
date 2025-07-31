Return-Path: <linux-pci+bounces-33222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3D9B169E8
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 03:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007B318C75E2
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 01:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2464672637;
	Thu, 31 Jul 2025 01:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajSLNEDS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDC06F073;
	Thu, 31 Jul 2025 01:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753924270; cv=none; b=eZgBqy1ywGuJtiebtzHS36FB02PzOJu3JejqOxr7ABj1Cw3hF4wgF/RCROiSQeerPpYBT4PtD74gUmpjYmusXSe0d/5S8bpPYfJwwpUdVMsZ91hus+ODSxYt0oEBZBCPaecXGaZzd3UjuYrlwUTyd5JxlHEye4FdtOa/X7huxIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753924270; c=relaxed/simple;
	bh=n8iDS1RpoPyRX/SV8PZbQm2pUtZk45w8CetxLYbszh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZmSsxAogsfLjoZyFCH7V7brhn/KS+xhuwQebQK7BwBUx5RKu0xlHpjab6AjBQ6apOGtjnI3oSLlkqU5H5l+KvdXhqxGT9hqUSayZjiQcNmnGESGvtOeh72/aV+Vri4G9ztFVxaUju0HJfFjzkQ0YuxxXojonLIa9QVLgPkCFbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajSLNEDS; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso2366255e9.2;
        Wed, 30 Jul 2025 18:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753924267; x=1754529067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kXpCg7fFUSCjtaBdVRkAIltng+73iOIw95qBFbgU4OY=;
        b=ajSLNEDS+GTT7mxHvyF8DFhqmNbkhtWN90IEksUoOs+FHdxrEjAoN1wjt3hNfZbp4O
         I9wVoo9HPruxSYXyCtNuEks6bxslEaoctggcIdCdnveUdZcHm85yaJBkqBnVw53ti8GC
         wKPbXNkJKOFaZNyRC2Itz+wON09PS0DzUIeqLAg6FOC6t3ntVRC6D8S/GZ65Z+Iglcj9
         cwkIcALVVjZF3Q/LGA8REepf7UQZt/t31UCS+/Tp/H4ti0C49Yv9hvLX/yj7BiaWLOXt
         fTMFpaN3HAINS7/OMOOlOzKS5u158NBvO7aFUmfQ2UjpmdewjzrmSXxs9d08e8CiXZQL
         Wq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753924267; x=1754529067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kXpCg7fFUSCjtaBdVRkAIltng+73iOIw95qBFbgU4OY=;
        b=GQeNqvJof0cLkTyaYD5xo+/fdtXjDDrL9IGeElraFoc+AWdDM3gKyFc4j2/nhenVxO
         kzkol7XWek5cz4D2667OruKw5bRXDSFJLtHoGIriqi1V5uvGtXz94pFNKoX7bIZYj55t
         sgV1rEA/grQuZf0Xrp6eaWVoHirSCLHMR67QaeqGOmtKmZAdov4ylnkZ+btFTWzt5GIq
         IhvQAhGF0N4sB2YJFqzIJgP7O5DQy+7B/uxc3lqrwB3RE0CwayRtfl0C/lVjrTM/oO04
         8qK+2K5EjQJbsJZgE4VONpphgv8e9mf8ZF5/SL1SABhn6xbE5RgESyuO3fLhAV7PyMc+
         mqEg==
X-Forwarded-Encrypted: i=1; AJvYcCV+Z0dtqNQAIlHvK81/HuGOCK+cG+4DJ+QBC/bxIksbZ9hhPKpJhkukgxVtC1xX8KpuHuCioJ2PKOHJtFrC@vger.kernel.org, AJvYcCVcXNkcQSp/4gHRsfeoPXULJODS5iIvFycaLxfmJTcgLanxpBl5eZqkaLmUkf54L6gKkbMcoVo3fbq+@vger.kernel.org, AJvYcCVgJToITwmq7dhShAkwxYT5hSpv3nv0HrAQd679hRehebN0gzGxgaVcWlBeiUgmBPZ9voaNy0YPUGEM@vger.kernel.org
X-Gm-Message-State: AOJu0YyPWxwmGICdUPvbUkEplXUDEnV+nXeVBwL5ui2fQSnJZ1D5quO2
	OU38qVBUhxk4kH+BiZcpn+rPbUko7uwKDzY5an+dYwH/MipOqshsz0id
X-Gm-Gg: ASbGncuTozlAoYJAIfjS4JPoH4MGA6iSxnhKJ/kqG2K79H48uaJWUC4NU1NLnY9Jiq/
	3GtBXU+nL4HEF8hpWQEAzartOsHEs5q9wsfEXANkLwfXHmW+JqXeY673wR8OvLs2GC5XT7dLUxt
	DmmLlOlXEOAdlq5bt7/m1PmFAoM1Oa1f+cTHFXR6U9xelpXVjPXwbcktOP3ux00ePGZg9zoUwK5
	OiKmL4wGjkE92mgV3lbPY93sJBMf4V0xE8NQD22xEqJtjfTmze8zLDAf4S8mv94oZATgKWprUMm
	mD8nsebz20l3eSOiu4XU4Xy5vjwQhBFMN9uyPIBMMYbOtqtEa/Uyfp9VRGzDz4puVSFXsOcVK66
	0FvETwkGMxn+19IKazf19Acg1QgMTxu2xS+MuLMtKJMNJRg2GduPEozQN/V0otiVlAAKKPZQdb/
	aUNgzJxcvSNL03j4yO+KeXop5LeVgv6A==
X-Google-Smtp-Source: AGHT+IGeOhsBMERvvbOw6f+hFFGfN4gChqdxVvN8hhQLKCb/w62XE3iGf0rhBUe+NyG0AtkhK5k1Tw==
X-Received: by 2002:a05:600c:3b16:b0:456:19b2:6aa8 with SMTP id 5b1f17b1804b1-45892bc5940mr47464205e9.19.1753924266281;
        Wed, 30 Jul 2025 18:11:06 -0700 (PDT)
Received: from [26.26.26.1] (ec2-3-75-144-20.eu-central-1.compute.amazonaws.com. [3.75.144.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589edfcdc3sm7151015e9.12.2025.07.30.18.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 18:11:05 -0700 (PDT)
Message-ID: <f6fedc6c-9f3a-4ffe-adb1-38b4f1632647@gmail.com>
Date: Thu, 31 Jul 2025 09:10:59 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 0/4] Disable ATS via iommu during PCI resets
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, rafael@kernel.org, lenb@kernel.org,
 bhelgaas@google.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
 patches@lists.linux.dev, pjaroszynski@nvidia.com, vsethi@nvidia.com,
 helgaas@kernel.org, baolu.lu@linux.intel.com
References: <cover.1751096303.git.nicolinc@nvidia.com>
 <4f7e4bfb-1bc7-4c87-a9f1-8c8b6ee9a336@gmail.com>
 <aIOz1bzgfK9q0n4b@Asurada-Nvidia>
 <606f65e1-ccfc-4492-a32f-90343be654e7@gmail.com>
 <20250727162041.GC7551@nvidia.com>
 <d7543795-b172-4452-8789-e1c810d8075a@gmail.com>
 <20250729125953.GH36037@nvidia.com>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <20250729125953.GH36037@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/29/2025 8:59 PM, Jason Gunthorpe wrote:
> On Tue, Jul 29, 2025 at 02:16:43PM +0800, Ethan Zhao wrote:
>>
>>
>> On 7/28/2025 12:20 AM, Jason Gunthorpe wrote:
>>> On Sun, Jul 27, 2025 at 08:48:26PM +0800, Ethan Zhao wrote:
>>>
>>>> At least, we can do some attempt in DPC and Hot-plug driver, and then
>>>> push the hardware specification update to provide pre-reset notification for
>>>> DPC & hotplug. does it make sense ?
>>>
>>> I think DPC is a different case..
>> More complex and practical case.
> 
> I'm not sure about that, we do FLRs all the time as a normal part of
> VFIO and VMM operations. DPC is pretty rare, IMHO.
DPC reset could be triggered by simply accessing its control bit, that 
is boring, while data corruption hardware issue is really rare.  >
>>> If we get a DPC we should also push the iommu into blocking, disable
>>> ATS and abandon any outstanding ATC invalidations as part of
>>> recovering from the DPC. Once everythings is cleaned up we can set the
>> Yup, even pure software resets, there might be ATC invalidation pending
>>   (in software queue or HW queue).
> 
> The design of this patch series will require the iommu driver to wait
> for the in-flight ATC invalidations during the blocking domain
I see there is pci_wait_for_pending_transaction() before the blocking
domain attachment.> attach. So for the SW initiated resets there should 
not be pending ATC
> invalidations when the FLR is triggered.
> 
> We have been talking about DPC internally, and I think it will need a
> related, but different flow since DPC can unavoidably trigger ATC
> invalidation timeouts/failures and we must sensibly handle them in the
There is race window for software to handle.
And for DPC containing data corruption as priority, seems not rational 
to issue notification to software and then do resetting. alternative
way might be async modal support in iommu ATC invalidation path ?

Thanks,
Ethan   > driver.
> 
> Jason


