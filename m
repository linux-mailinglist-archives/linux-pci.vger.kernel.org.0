Return-Path: <linux-pci+bounces-34041-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75220B264CE
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 14:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77DD42A144E
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 12:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672852FC868;
	Thu, 14 Aug 2025 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="roAPRZVu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985982FB97E
	for <linux-pci@vger.kernel.org>; Thu, 14 Aug 2025 11:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755172798; cv=none; b=tG+Cv8k5DLtk68x87mk34ZyCOdgNdJvyYSIwavUf4FKU3Rih+ai6RyELAkCyRTD+Cs5gQk9vrWJzKcdEzzzNRomeFE+JCQWKwPCYdNsKsqxrvrIJn0V6GZe9n3imEwQNZavoXM/hCpIpdKOB5jfMs3KR7vcv2zEsaYoVgAU5DNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755172798; c=relaxed/simple;
	bh=HFX/Qwld+Sh0z4QKTMLIPR1Ye4VR7lyGLk0gc7fQ85w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KnrHOLtD9txW4/E7DVS7+7TZDyKUc79ag13TVokuO8L56LgNyOJ3ESdsb9i46MKQQipa4uXSFDZNFZdv3BajtbBULcJ4cJ4l2DvJ1rj1Hx+wDSOT7sqnlDd76q58JuhJxPIfw+HN4Th7SPH37xS1G1szI18j9NP2AvP1uMB3pA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=roAPRZVu; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-88432cbf3fbso64255139f.0
        for <linux-pci@vger.kernel.org>; Thu, 14 Aug 2025 04:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755172796; x=1755777596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VkZ6MdXAK8oUuFYjzHuswEeWUTNOi4hs6qI/H9CSMKA=;
        b=roAPRZVumjhXSJMNbOOKCt7VTy16wBXw0WVHlLt6mdtIXZk83X5YibLjoUe14l+prN
         fW7d/bas93KoNHsatXcMhgWsAmvc2gQi5fOyxQEkfxfbXovmCDkk/YtBEcrkWhV0bkCM
         qY3abYbLqOZduAZGRLzhY7TDIdI2Bg+suk2QK5iQ0bHOF/DTSwTBEef4pDTXc3TsrVL1
         Cpt+bwgopxNd5MFDyjknyD7TfduO5QpRTVQlyIbTi5mHq2gIjp9BTNf9kbs7Gu0gLgom
         wv+NR7SEMY/a4IaEOILN9/Zvg/spwkdsSNDSCGdpMoCJkjfsHJP3f+JNpmYBOxM8lEgt
         S7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755172796; x=1755777596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VkZ6MdXAK8oUuFYjzHuswEeWUTNOi4hs6qI/H9CSMKA=;
        b=TrLJJi10hExiBkkihKyZVaMYeOrI6OloU7xadBchGbVVGLJcyHXRDxEmDw07ffaUFW
         2YEBsidiMoPj60x9pVOABGlcO+6//FamsB52fKgDFFjAkx7oYu3vdeUw0Lbb97gbFIQE
         /fQIp69svs7a37TOdjC99YXZeaA1v2uwTSozNcpOYiPJwkb8oe95ELXoL5KdV4ASXe/R
         0REggv9aAotBCsGXZE3t6TPzEG4EGitqROnLV6hjiW9E4w1J15r3syPzcffdNQiBhqzZ
         dmxsFlkhOuCiY+w9/tK+hec01cMto6LLtmHICU/ogFQJ2tWwLOtELbf0crPgc2Wfe2zC
         mUVg==
X-Forwarded-Encrypted: i=1; AJvYcCXP81yiNkSCrKRDKtqvJURVn/zTdtEW8qba2Fn4yyj1Mwm8InqQbLn3hgWorotCr801tjGgVE7/G38=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBf6KaNzqTpndyAk4lVz9Air0evxLM+189qBcxTJxKnJta/2KL
	HuLxGuu9l35TkDU7Wz8xYSKFhoYAMdMn6CDIt4wbw1ChbcJ9ar/3UK0HD2ZZYDEA3W8=
X-Gm-Gg: ASbGncsk/sG3rIIjzk25ns8WCT2GT0OTqDcP+zhKtPbxO1lLhY2NcDpFHcvkHBEkpce
	xEY3/8qpzDEjRMSW2eYmdpg/DMP1WMgh8ZWL9+elju4jW5fbV3VOY6a0v3y27bfZi1CkvWHL9/x
	Oy/vzAqcpoFPyNeYOnYaHz5T2jhnGz9rBSX5KUokqVT+cW3g8yLtT4xqisS3+BPvj2vCkybF5Ot
	lRBWPZ8qzJbteWSX1IuPukx2gZO+GYAqSlYfQ7pebByzoSCrzIq4dDlO7KN/zMpVZRbPDwuA/8k
	VRGlEYq0aCzArQV3J5cuzsKV86+pMDoQauOoUznEe4Tw4B0W5tA0/fQRdPVegNm4jkFZ/H54jX8
	wq0mosjrhC0XJxcBy0j5MuCZUJk0LUVi2T+34SxGXFGcABAd6t7a7QIRRCkqD4Q==
X-Google-Smtp-Source: AGHT+IE3y11zxXdSZ7xsXLUpghewNnJCpWK8G2mFkAzcKjVS5vSn5G3dmjKvLqQoKez3LPNe1hHEcQ==
X-Received: by 2002:a05:6e02:184c:b0:3e5:6daf:ddfe with SMTP id e9e14a558f8ab-3e57084ff05mr51337105ab.10.1755172795698;
        Thu, 14 Aug 2025 04:59:55 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae9cbb659sm4480210173.93.2025.08.14.04.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 04:59:55 -0700 (PDT)
Message-ID: <86174012-fd87-41d7-9568-f9c0b544c1c4@riscstar.com>
Date: Thu, 14 Aug 2025 06:59:53 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: phy: spacemit: add SpacemiT PCIe/combo
 PHY
To: Krzysztof Kozlowski <krzk@kernel.org>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, bhelgaas@google.com,
 vkoul@kernel.org, kishon@kernel.org
Cc: dlan@gentoo.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
 tglx@linutronix.de, johan+linaro@kernel.org, thippeswamy.havalige@amd.com,
 namcao@linutronix.de, mayank.rana@oss.qualcomm.com, shradha.t@samsung.com,
 inochiama@gmail.com, quic_schintav@quicinc.com, fan.ni@samsung.com,
 devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-pci@vger.kernel.org, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250813184701.2444372-1-elder@riscstar.com>
 <20250813184701.2444372-2-elder@riscstar.com>
 <22bd5b5b-ca06-4499-b21f-22c2ff202167@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <22bd5b5b-ca06-4499-b21f-22c2ff202167@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 1:11 AM, Krzysztof Kozlowski wrote:
> On 13/08/2025 20:46, Alex Elder wrote:
>> +                      "mstr",
>> +                      "slv",
>> +                      "global";
>> +        spacemit,syscon-pmu = <&syscon_apmu>;
>> +        #phy-cells = <1>;
>> +        status = "disabled";
> 
> You cannot have disabled examples. This also means it could not be
> checked/tested.
> 
>> +    };
> 
> 
> Best regards,
> Krzysztof

OK I'll fix that in both places.  I think I just copied in the
actual DTS content, but I now understand the problem.

Thanks.

					-Alex

