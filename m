Return-Path: <linux-pci+bounces-18088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D589EC491
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 07:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC27D284D83
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 06:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82221C07DB;
	Wed, 11 Dec 2024 06:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OcgFTAhd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEA986338
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 06:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733897074; cv=none; b=jpo/ssqhBhreUZbD6BlNsFGNPiiaBSvN6eHbCz7hcvATHpV6vd09TH2sjT7dZYyNatwYLgFWsZ/zku6VTQpy20lBPE29YR3Tdv3Iav0R+h3x+/0pisf8IqQqMCpkTrBUPey662vDIBVzerJeMsD78Pi9SqzUaPDv5Jg7K7Gkj4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733897074; c=relaxed/simple;
	bh=+JcUvL8TdkGifcwu1FSpMcUqqJLBbCSXJvpOAQ7m7p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocLQowiyWjjob5zIDgpBAjBBK4geMGzTPKgldMEC1dWF5PSeHtfD8oekMSgSpxnqzIvrw1eBn/AdHX60GP5kd0T/yryGJBSd7udEBmrkVhpIKIiRlYa9py9hTJAcVPT2bPaZZdabCfgEFEfq40gj6FQV4pmIjO5yPVCgo/ePrd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OcgFTAhd; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21683192bf9so9242755ad.3
        for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 22:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733897072; x=1734501872; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s8IoPSQMtEEL6HOp9R3MHt1lyYtmF6QVYbrckRmNW8I=;
        b=OcgFTAhdmR9ZoIBLr9C9iLoPKQfLiEVM9DfWyeyDKz6gTbtqhgsAuJnv4D6+AkVWFW
         IM8mPXXJQH3YV6zD48URahUaNVg87zO5ZUnHTjuaKnrIfKTEvmztGPPnfWkOiHn4ohCB
         ShBe3xwQrAtxzrEnPNUbF1RYRIE7XMuszH4zo4WM4UiETSC5iqkrwWj00tCP0RxotQre
         BIA+BLzUWZvheHGJM5r1IPBMuoFPrQeIp/A9LU1VsXRFn9Xl7ycwJTrmTQ7idhQbn74Y
         8nrquv5BtzQbAUJgXybcUkvuY3vbRZYlObCb0lPdcJkbLpIqwHFiWYlKDDE0Qeqz1Ahk
         wLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733897072; x=1734501872;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s8IoPSQMtEEL6HOp9R3MHt1lyYtmF6QVYbrckRmNW8I=;
        b=vEoJLrCeZvIqs6B7nGaR0MVwfBjXidAOxk1QyV/P0hzor6Q1pTHbgr9wlLscJUTaYU
         +Bh45ZFEqvfarRKumPtKKHOSeXBpGqKI0iQXEvyBxn0r/MCfIPhmiVPd7vH8MIegngTY
         PK8TlayX0eLb9i2n1t0o+kxH2nMg6bSQT25VNbjn9VH2X84aOJyoh2QhcEgYB7kV/hHd
         FEdO8zLh23F98goOfNngPQxo/E+AsbV2mZXgUKxr3yxSlhTAvoM2Og9CFZOCxorHgdOX
         kKA7lnXZp9XnFZdteQc7yD37nomNgclat3+bArgRrSlB44023qyDQ3xBrRsr2q2VF+ph
         BJew==
X-Gm-Message-State: AOJu0YzAmr8+z57qOGkMy93aOhHqajqgVfm8fS2fvLb/6KIJAGSPjziN
	uZgxi496W++5dSxxFps1EphciOtSpELCooVVM4OKirXJ2iRO4E4kRO3oRYFWLg==
X-Gm-Gg: ASbGnctE5Fw9CmR6Z00vgJdKsgC9STSXMCqA7pnSzrSkpkdF/Uw+wxBJ250OCJrqeBF
	MGb4GoaeRLLMHXpqk+H02faqDuJBy+BuPCFX9fA2DtLJohqm3HqMK9chEYclT9c1xhOFUdXEMD/
	rSa/CfmJ9lF1GgeZCSvAni4/2uMADPeEI0t6ehmuD90ZmelrhqX2yFXEOY7AKl/mjDEJf62rTxJ
	ccjdaFIQIzgSObmooSFYbWOefVTMz+F1NPhh/6I+iNJfS9UF05CjZHSCJpmgis=
X-Google-Smtp-Source: AGHT+IGMQiw9EMReovhZtxJ046XhcMh5S83+xfJNwDeGQ8QcJ07MPY4YZJkgMpDk8inAJw3ApdVzrA==
X-Received: by 2002:a17:902:e74e:b0:215:9d29:9724 with SMTP id d9443c01a7336-21778590f41mr29160785ad.38.1733897071869;
        Tue, 10 Dec 2024 22:04:31 -0800 (PST)
Received: from thinkpad ([120.60.55.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21618d9beafsm81832105ad.6.2024.12.10.22.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 22:04:31 -0800 (PST)
Date: Wed, 11 Dec 2024 11:34:18 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 0/2] PCI: Convert the Apple controller to host bridge
 hooks
Message-ID: <20241211060418.gpepptv6wlbv7fwt@thinkpad>
References: <20241204150145.800408-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241204150145.800408-1-maz@kernel.org>

On Wed, Dec 04, 2024 at 03:01:43PM +0000, Marc Zyngier wrote:
> The Apple PCIe controller requires some additional attention when
> enabling an endpoint device, so that the RID gets correctly mapped to
> a SID on its way to the IOMMU.
> 
> So far, we have need relying on a custom bus notifier to perform this
> task, but Frank Li's series [1] is a better approach as it puts the
> complexity in the core code instead of the host controller driver, and
> this series builds on that:
> 
> - allow the new {en,dis}able_device() to be provided via pci_ecam_ops
> 
> - convert the Apple PCIe driver to that infrastructure
> 
> Patches on top of 6.13-rc1, plus Frank's v7 series.
> 
> [1] https://lore.kernel.org/r/20241203-imx95_lut-v7-0-d0cd6293225e@nxp.com
> 

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Marc Zyngier (2):
>   PCI: host-generic: Allow {en,dis}able_device() to be provided via
>     pci_ecam_ops
>   PCI: apple: Convert to {en,dis}able_device() callbacks
> 
>  drivers/pci/controller/pci-host-common.c |  2 +
>  drivers/pci/controller/pcie-apple.c      | 75 +++++-------------------
>  include/linux/pci-ecam.h                 |  4 ++
>  3 files changed, 21 insertions(+), 60 deletions(-)
> 
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்

