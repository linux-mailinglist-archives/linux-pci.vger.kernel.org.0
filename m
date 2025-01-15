Return-Path: <linux-pci+bounces-19879-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2716CA1229D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 12:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4631A16BD3F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 11:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8BB1E7C16;
	Wed, 15 Jan 2025 11:35:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04DD248BB5;
	Wed, 15 Jan 2025 11:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736940911; cv=none; b=gJfMkuKyHeIbDYYxID5gc8iveF7FcIUKhwpelK8cBnXmDIZJD3E6a5dU6KMuupwMpqytzU8lipx2P4uP7IcaT28cP3pDlPQewPTxW+8XaOaJ4VjRQWB6GNCy6nTxmDlAbJP4WCEsoF9gzz2sKVtHXNKICuvRMSj8C/+cTOzqbT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736940911; c=relaxed/simple;
	bh=wfx3JgQvEtAlDYyfO3Dkqkz8H8Nt+l+fznBQ6qkLPiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soSg4hPqK3OSl/two7xtrvmmIWUVqIItfTJMWy/ucCMCGiISgl5d0tNVGwKxpuhZjLnZppFxotjJcuwYQOaynwdxpfsBM5+A4OaWt53218A9LMF6GgvQNpVbTwnkoPUxbDMPS6P+QE9G2L6wG6Bn3U4fhkIsaYd5XZJnYt9I+6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2165448243fso144227345ad.1;
        Wed, 15 Jan 2025 03:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736940908; x=1737545708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkkB4BIMbKkZ0KmrWAf3BaqZndMd7BUpph0XZ45yvX4=;
        b=eRFoaJLWGrMe/KxyReD4W5zyP0a9jgSSOqVDtIvw/LD0TyFVWmSS6OmNsN9OZ3EvNf
         bsU/3DucVLLzo/S7NlM25xLdLZyJajix9HgfycZDMcfhSCt3QofaFNn2JwzIFaW4LX3C
         3VdthM85rmW2UEa6pkKmvx1LAFwUsCesgPY/Ytk57NjKRG7M2wLVlF1VjqQgIch3QH4u
         1P43YAq35VRmJ6NoIDdJ/OIxxxzzC8YmPTxsORWPWKYk5VyRW7t5tev/UJQMKNS305bl
         jD5s0S7anS5s8OnxCoEDRzTLn2PTkONySQzPxDEBiJyKDxQfKW7MelYGj3Ox3PKiE9Hv
         Pxng==
X-Forwarded-Encrypted: i=1; AJvYcCUhNhM8LfKK6jxX2RLMvRN+gHBZbUuaeA+lVxspmAU7/Lduoacqauy29+5uG8PWVCKKSicvljXLh6dI@vger.kernel.org, AJvYcCX+FgqGCqeEGRyaiktK+5b2rXKCNApwWDaBayZ8BRaOX//UChQyZa9tlrPuuyqSCQjfKMlPp57pg0klBdBA@vger.kernel.org, AJvYcCX0YCTtgpiOcqiYMshNZeW7kOZ62YW6xtCGir5LmRQ81F773MFCuqN0u4rjoH1kpx2tXNFquzkfN6BrBdFR3g==@vger.kernel.org, AJvYcCXkqFOYRDxj+WMo3mOxJYiDz+RWWiFMlliZdRYNuzODd7C+l37tbHIO8ecn9kw/ZNrTrAAx89/ga+HX@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf8oQEQey9FincfY0kKqoNykMjtPgkkohEX2ljutHjEjrr/ZAL
	JEuEhOFh3p8yZEAnHxFLzlP/U1zvbP5KTAladSfhrNn9Bp7IxlYt
X-Gm-Gg: ASbGnctcDRD/C+M9vAgiKNckipYfYfgB/zYy67RXC08oIuLv0GIVkS3NowXqePnCgzB
	IRTSIkUZVr3eMfgqfx6iY6XFeGgESwIYBsim9lwYiAzHjeBJAliCZNkl7RCxSGXA3dcTtj9r4+0
	JKAvKwH1yk1zktHnHI0CaA21DLd/rbjKDiLPrhbGNojNuSWMkVQbpl24T+mD+elGApxUbqeIl7H
	YqizeErcaoRZmIX7eDmxza/n15tQqlm8BgbsGcXCUszMoDRWfJ5oyPbCh7Z/PtneCKHSGbBjH/b
	MdQHKK3VYTlNCX8=
X-Google-Smtp-Source: AGHT+IF6rJSoS/v5enpIOoVkN0spwX/9NTrSguhcHfnBBSKsbpcSrWe35R8XcyFdySfo9fqgIOFPKg==
X-Received: by 2002:a17:902:e950:b0:216:4853:4c0b with SMTP id d9443c01a7336-21a83f92f64mr401679715ad.33.1736940907683;
        Wed, 15 Jan 2025 03:35:07 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f256fe3sm81337695ad.243.2025.01.15.03.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 03:35:07 -0800 (PST)
Date: Wed, 15 Jan 2025 20:35:05 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: PCI: qcom,pcie-sm8550: document
 'global' interrupt
Message-ID: <20250115113505.GM4176564@rocinante>
References: <20241126-topic-sm8x50-pcie-global-irq-v1-0-4049cfccd073@linaro.org>
 <20241126-topic-sm8x50-pcie-global-irq-v1-1-4049cfccd073@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126-topic-sm8x50-pcie-global-irq-v1-1-4049cfccd073@linaro.org>

Hello,

> Qcom PCIe RC controllers are capable of generating 'global' SPI interrupt
> to the host CPU. This interrupt can be used by the device driver to handle
> PCIe link specific events such as Link up and Link down, which give the
> driver a chance to start bus enumeration on its own when link is up and
> initiate link training if link goes to a bad state. The PCIe driver can
> still work without this interrupt but it will provide a nice user
> experience when device gets plugged and removed.
> 
> Document the interrupt as optional for SM8550 and SM8650 platforms.

Applied to dt-bindings for v6.14, thank you!

	Krzysztof

