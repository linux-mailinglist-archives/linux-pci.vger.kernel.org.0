Return-Path: <linux-pci+bounces-33090-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC93B1480F
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 08:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E5E1AA01DA
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 06:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63280194A65;
	Tue, 29 Jul 2025 06:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oie9yO+K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B08186A;
	Tue, 29 Jul 2025 06:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753769813; cv=none; b=Zvh6BhHWUdATaghoIexMdunzHd1NLX24qWCnIAw8p/2mHtty+YJ9hJtIRETzeQAiby8ebjTFAjXGnbttNZbT0k7sri/3XsizorA+jTFD1O3Jmbu5EeUeD8lNrgq8l/u6Z43ZX9ESkmpFwvL1M94bop+nuD8qbxdw0IRaF3mgAl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753769813; c=relaxed/simple;
	bh=wTnoAzg5SgQHuoVQdRdLoINjYsqmiKdXxCqy4IBJh4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f6H3vbWYN7iIWZj5sTJjWCedoHB7qMhVr4XQ1qrhP+7Fbi/xDdKuMYxn0bvw8FQEJilxdGYu05JrKRzeTv3H86aAzf/CCBCZJjQDEoA6oLDWvUs4ATt4B2cLGsdaQwwYUcRHjsFbZVUl6ET6Hhq3D3//3eKCfSlKt7bdVCj/Mps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oie9yO+K; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3a4ef2c2ef3so4304797f8f.2;
        Mon, 28 Jul 2025 23:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753769810; x=1754374610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EuJHExjp9oNluHLopPDQOcmTjqGBwTBeOtcBmZlA+3w=;
        b=Oie9yO+KkyKmTglZQSGVVGO2HFBK4exipXk+aRvFOVejlZEqbgRyobZAHL2jpB8oAR
         G8f81J7Lc3zuhzQ9GYQmjstR6gIurR0Itxi0cIYy3kfHnm8qjlWSchoDxWis0TXG9RPb
         9KwjRLqMEpaY9FnWW5Iq6yYjAlenmpBuwcw2Ez0afIY4xvcYHIrIZGWEtHL3x8h9l3fw
         vHZhQc+r5bC/99i+g8vFR4TrFiMfiApFO9K3jsVSN0sRgCUufLwsf5ZY7FlpDm0ZUUJ6
         yWdgkt2vNhLtrETjxKZ915mPYrMFpt+f/6BK9y4zICPMZuMco1AZ/9jkzcaGnEkVE2QI
         RrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753769810; x=1754374610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EuJHExjp9oNluHLopPDQOcmTjqGBwTBeOtcBmZlA+3w=;
        b=PKTD1ERq20kcTtN+jmkI875lufAe0al2Rl+r0GIrUXryc32LEHr839R716ECmLGM2F
         q0koqbQDwYXjNQMcXodq7f/008iqxqHTpDaE873uHe709Mhbn6oCRAiXvRKifpFz0sI8
         YIAfP/0r/+aIMdGxGzVCEPSUOURLuM25GwHJtpD8oHXWYDBiZ9hz7IZp05CgHeXDnTrh
         kODbC80s1/jfUYtieuiLD3nFph/5GAajFmLiVTM5jV82W3DjAMjgK1H5rbvYxekqpnpf
         IECrzrRlR30xdxQDKD4KX5cQjZrIFsmIw02SYrbUBB9FvM2rOH62v1sM+OdzVt0eK4iF
         tAvg==
X-Forwarded-Encrypted: i=1; AJvYcCVaWzgp82XuK36NpLUduqpWvvfZfa2P9TLPlKVB3JsEvpC2T2wSt2sS/0J5YkfF8klC8KFbg2KTuVHQ@vger.kernel.org, AJvYcCWYnYzAa8zLrqj7uPkUO7rOlZCvtMOrXEWHc2NVXqv/STI1YHrc9862haYutZ/46iC1CWB1hbv4wtpW02Jh@vger.kernel.org, AJvYcCWbOgT3ydWRGKLOkEXnWrn9j18lp/NkF7rdmjszly5ZmS2xfPTbQiJ93WE/KzMPILHmsCTBosOhkikB@vger.kernel.org
X-Gm-Message-State: AOJu0YxTFUZoQsY+YFx8enJPjWIPvxq0QL5qx98wJTfwW93bx0MGqhkj
	rbokuRRfTBL65goQlmKlcK1//5jxwk3rzpXa/LHifPQoYNJsBKbDwjWZ
X-Gm-Gg: ASbGnctP3doTgDq2HIgj5uClb3mrdL95FA/axmxMWTWOmW9en8m6X1dsgz4xviKc3Fd
	VsEx2fklZlgdyeIe/2GJw8zE+6g5V1cXOfDvYMDHVWOW2nhEec8q22c616aICOsBY5CSozfX3U/
	Rs9O+BUbeTCyQrZBgu3V/vOy0ZMeGuifg5YlbruV7nkCldFySS3kh9ehM7+InORTxnUiN576u+W
	V+wV1kudSk14HDYAYAC3AYp4zJqMZnlLTLDvFj7xOhNlIwijtlVTp0JTq4HmdiNQdXesU3PsZ3V
	Fn3DcUNrrO7Jx8J9zEXcT8ah9y7mD374qB8oIUvv/EcRgXNycDEg8/8KaCDd6/u3jHO5RV31fkH
	LyvSOI9rypvb9sYjMzYg6pJMZa+gavq3DvRoV31N7YXeuJENDSkUuuSRHOXK8LSeybMwJwhx1KG
	cQH65iKC1MW9Ivy90LRyJvmk1TerGPiZDJkcQ=
X-Google-Smtp-Source: AGHT+IFZiUcA4w11LB+vPoG9+WgvjzJn2Lg7goJvqZWvIHe8uQeH2yzKGxTThZpRNn9MQWBJHoc45w==
X-Received: by 2002:a5d:588b:0:b0:3b7:8473:312c with SMTP id ffacd0b85a97d-3b78473319dmr5207539f8f.0.1753769809715;
        Mon, 28 Jul 2025 23:16:49 -0700 (PDT)
Received: from [26.26.26.1] (ec2-63-178-178-86.eu-central-1.compute.amazonaws.com. [63.178.178.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588d89c50fsm10876755e9.0.2025.07.28.23.16.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 23:16:49 -0700 (PDT)
Message-ID: <d7543795-b172-4452-8789-e1c810d8075a@gmail.com>
Date: Tue, 29 Jul 2025 14:16:43 +0800
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
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <20250727162041.GC7551@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/28/2025 12:20 AM, Jason Gunthorpe wrote:
> On Sun, Jul 27, 2025 at 08:48:26PM +0800, Ethan Zhao wrote:
> 
>> At least, we can do some attempt in DPC and Hot-plug driver, and then
>> push the hardware specification update to provide pre-reset notification for
>> DPC & hotplug. does it make sense ?
> 
> I think DPC is a different case..
More complex and practical case.
> 
> If we get a DPC we should also push the iommu into blocking, disable
> ATS and abandon any outstanding ATC invalidations as part of
> recovering from the DPC. Once everythings is cleaned up we can set the
Yup, even pure software resets, there might be ATC invalidation pending
  (in software queue or HW queue).
> iommu back up again and allow the driver to recover the device.
> 
> I think the current series is a good step along that path, but we'd
> also need to improve the drivers to handle abandonding/aborting the
> ATC invalidations.
Also aborting ATC invalidation works as per-condition for DPC or 
Hot-plug cases. agree, such improvement seems necessary.
> 
> IMHO DPC and SW initiated reset are separate projects.
Of Course, Rome wasn't built in a day; I endorse the success philosophy 
of restricting project scope. The discussion is purely focused on 
technical methodology.

Thanks,
Ethan

> 
> Jason


