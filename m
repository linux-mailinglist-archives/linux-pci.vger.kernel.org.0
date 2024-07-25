Return-Path: <linux-pci+bounces-10755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDDC93BBD2
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 06:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0776285A0A
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 04:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A886318633;
	Thu, 25 Jul 2024 04:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FyJH0Amf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C951DF6C
	for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 04:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721882632; cv=none; b=piGW5oJk15W+QFxn29IwZPjgOWbNROQwjmkJgjHU+bzYXVxbEemK9Yqb63QkD6QVOg2QwDC5t0cJIK0ntleeu5/nV1XwyoRovpcmEZ0IzaF2YMQPIKF1zthqXF2Kuc52OPOLZhp6dTfDKxNYYnzIhtr5f9cYCYS7owlFDla4bh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721882632; c=relaxed/simple;
	bh=guKMdJDh2Dsp0ZvO0y2p2rkfeU5PbBBaTqPQnUlwHec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srtR0rEoWQSj2K373LscuG5lYjqsJe1pZ3gS8Ebh3NwtbfYnHSciLDj/+gA5EE4FNv9Ts/gTJEYtbc9iBCctT77fxt/+j+P+VsKPoSUz8u3QdAnVS7WbufDKgGQOLGfccpMJp5hMaMhxonAgtJH2YZp0urQ55CU5jVWTtGajE48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FyJH0Amf; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7a264a24ea7so338559a12.3
        for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 21:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721882630; x=1722487430; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2wEKpUv4fMwfLgYNRd8DtitOmSI092BkaurqEG/TeoI=;
        b=FyJH0AmfjHHew3GLu9iNP4+UFwiNClsWdNdd1/j6RIewAEiuPRsgSZaQvMQYrutj8T
         ari3+ZlIIMGOA/c6lF2QNQbUatrB4L9znLl6yKN74FVnlKv26MpV4b8sOd/wyhLWZr3a
         ptUpQ++9q8J8JliQgIXc+ZooKUSkyLcM8WNIeGXf46HV3PGp6zn3JUfkPcTBK6IVP9DA
         rsfeYbYovNLtevunOU/Wrjs9kgG69RK6njhb94FILuyc//6sy+qHWQXvESf9VbyQ8Us3
         e4waR049q+Gl9IoHszYs29TGgGIkQmy6kN6v/SrIIty1SgkpEtFjof4voDFDt4kDWHdi
         JlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721882630; x=1722487430;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wEKpUv4fMwfLgYNRd8DtitOmSI092BkaurqEG/TeoI=;
        b=IUrg9L9Pok6XggfizKqRUI61kLgudluSb91W40uVDYJJYT3h1cIl/79a5ZVz7Upigq
         8A2ehPry15ocWx3tfIwYG6A4Pjp0084UwktPCErnGl1u6SeGDgxFrBOelLVhbtnJNj0e
         fQF9pD7BXShEIW68zRshdRf/FA4fgzwHz6borXTRbJDyl75pnIphaHCicHrbSZK0Rgzu
         sn5gvLTAFY8mN1spUHyPSHajwaPLFnKZHmGqCTd6FLi9W83mwF1vEDWeqEBgvSXZzVLD
         uFxXEodOJNM+KZBMDTip0OTtJt/nDFUY9IXwwoTW0B3N8iE+hY4tAdfkM5jldi6f2bu8
         NfSA==
X-Gm-Message-State: AOJu0YxcHst17ki7iSwLos4H7yIPYUFLzOakfkLUIm6Xb4HkiB308dua
	qlU9Ung629SNsowG37xNMOS/93TnI7h8GNexAx2oBZAFRwbyOjFpyfY+oZ9QroSXpYQio4HO3YI
	=
X-Google-Smtp-Source: AGHT+IGWryDYkmYqfGQhtlkQZyoWV2+MeYYkU6VgJs8IspKUBX7yQT5hHKvRN20Mhn96afsnACiolw==
X-Received: by 2002:a17:90a:1fc8:b0:2c8:bf72:5389 with SMTP id 98e67ed59e1d1-2cf2e9d200cmr698468a91.9.1721882630473;
        Wed, 24 Jul 2024 21:43:50 -0700 (PDT)
Received: from thinkpad ([103.244.168.26])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73f00cesm2519947a91.34.2024.07.24.21.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 21:43:50 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:13:44 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 07/12] PCI: brcmstb: Remove two unused constants from
 driver
Message-ID: <20240725044344.GH2317@thinkpad>
References: <20240716213131.6036-1-james.quinlan@broadcom.com>
 <20240716213131.6036-8-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716213131.6036-8-james.quinlan@broadcom.com>

On Tue, Jul 16, 2024 at 05:31:22PM -0400, Jim Quinlan wrote:
> Two constants in the driver, RGR1_SW_INIT_1_INIT_MASK and
> RGR1_SW_INIT_1_INIT_SHIFT are no longer used and are removed.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 073d790d97b7..dfb404748ad8 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -210,11 +210,6 @@ enum {
>  	PCIE_INTR2_CPU_BASE,
>  };
>  
> -enum {
> -	RGR1_SW_INIT_1_INIT_MASK,
> -	RGR1_SW_INIT_1_INIT_SHIFT,
> -};
> -
>  enum pcie_type {
>  	GENERIC,
>  	BCM7425,
> -- 
> 2.17.1
> 



-- 
மணிவண்ணன் சதாசிவம்

