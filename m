Return-Path: <linux-pci+bounces-36756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C28CAB95948
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 13:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42D403B9BD8
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 11:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959523218C4;
	Tue, 23 Sep 2025 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmrbaONM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26922F6184
	for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625847; cv=none; b=W+QX2SaX/i9pMYlMbvxIfv1P0r3XCQrmQMUtb1/ccbG6HuMmAdh71X/ZAGKsA9dIbfiPS4cU5QsrD8dgMHjv7+d/8TUPQb6dqs7dRQAAQW3oO5w77LD7mHE0R+Ib8AjEhZuK1ijz08So8cdCB11uvwaogYp4vhL9g02x9qh3Jsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625847; c=relaxed/simple;
	bh=L8If8mhhgNYtNxzT0sBTVnoIcsxkhNehSrPzVwevgF0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYbxRayZROLMKpJDMyOvhx19lfD7i/gt0+to87kSiJJcsPQv1nyV/g4nixcYf+dqe+oq2ge8rDgxBC80xNVr6EiU52gJhaePIcvlaziVcSxG4Df7+gn1Dyzog0i8mNphSRfgmgC3ib9C6TZ8jY9bIOo2IELEUdNAppREIUeQQyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmrbaONM; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46256e402fdso8026305e9.2
        for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 04:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758625844; x=1759230644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/M4chbTCwJie6GL25HuGRFhPc1V63zKjOJLKGItv6qU=;
        b=GmrbaONMY567lYbR6vFpTH7gDvClnvBS96L6i7cxNJQyNpbldeX/PEB3xls2N49FEK
         BMNuOctp1084ZTlxDwzeIsmyFRnvmWEj1fYBJ2UspJaYUxvrwMoZXRxfT0r1SFKeUr0r
         ZiFWvMeUS/UCGkzIKbs24gOwhL681sh/wvvZY4qUZt7Q+AxzA6iPRCOof4pB2i5XAKNK
         WAj9Y2AE5TvbsXVm4iZt+JzxERe9qLmvbZazZZo7+rYCy+DChCD8WctOTbtYD3ucCzng
         4X2BR/6uqBd9Hq5VAZgRfr9oR90y2HqAIwJlLG4J1aq95N6oT0G6vZ++KJvqsUsFW0Nj
         0+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758625844; x=1759230644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/M4chbTCwJie6GL25HuGRFhPc1V63zKjOJLKGItv6qU=;
        b=gGtY0IOPIM1DCHrOauroTA9+B965bxMEgPWPjZZCxKbTiuftputeJNeV02MWwkAseP
         jJBK5C07OHgeQ9vAHAT4SVAUch0F9TabScT09JcNjOuSmr52PMidHABSpoEZTrKo/r+j
         UjMbWLNUePqi44vA2I7AUZu6iPbJx5ZdO4o6IetvVBni/Rp/gH7inbKq82jWaiT8eSyA
         33xMY1Ik1ilsBd32Sm8h5HjR5FXtlMRJtlM5DTc5t40J7W1fuJON4SyxJgy5i3HiNm1n
         90VXf7yZ1C7M2zccpQiz8h9U+NP59rjmYWcZRrWmWMuj54ibq8/jHcImVzcHixSkUeWU
         ftig==
X-Forwarded-Encrypted: i=1; AJvYcCW8H+wMhlTHJrPpAh59vGVd25NnrA7iBhcDRDIjHG0KF7TL+z8YhY1A0CYmUq47L533mCmeo7TDA2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZQaCh/Omdj/ywVnFq4vzZLFi6AQpmNv+2G9fj+rlEYVLV6PLS
	R9bQTNZqpFNew2J4QfALcFk7huQm/uR8pBL+AFj+ze+PL4ljrdGAg5eJ
X-Gm-Gg: ASbGnctnzvjUL8XQMDhY+Onx2C22UrSNeeyuquKaanZmOWeq7Xu1wRRTnJv3QQwGcoV
	7hrFqkIa4JLufSKCFEnNqdSE/nsQ2c77Q3t2nfXgi1/Yy+uX672eyy/IxHtwimJhKZUnREdxvcI
	esk/Y6bToc8HiRugftEJXUI0V1UDzga12TyKNtRdnzjK6gO8d4CFuiOmz7YdCRBj043YQFGlAEa
	3UyoVUXbKZbAd3qUVUibHFEUhAj0f4CjFJuKG8i31YTQmgaEvb/qO2sCOOjAbeJepZ38lLqlcNV
	OZ0sSH/vQux9njlTjPAt05VsYSoXYmKPV0mKE7y6ZbkQ02ELWxxqzmaf2/hsicY9cqKVubY9iaw
	yXT0YArfI70d7rqwIDxhe/bs=
X-Google-Smtp-Source: AGHT+IHhlp7t8Mif75guovtxrXuNcYEIzhCdfujdY3LaIWfy1jJmzn6mmtcb1ThUszzhbFiPUhqUdw==
X-Received: by 2002:a05:600c:4ed3:b0:45f:2919:5e8d with SMTP id 5b1f17b1804b1-46e1d98c40bmr12841095e9.1.1758625842783;
        Tue, 23 Sep 2025 04:10:42 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:2e0a:df05:253e:8b85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e23adcce3sm3208595e9.11.2025.09.23.04.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:10:41 -0700 (PDT)
From: Vladimir Oltean <olteanv@gmail.com>
X-Google-Original-From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 23 Sep 2025 14:10:38 +0300
To: Shawn Guo <shawnguo@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Olof Johansson <olof@lixom.net>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 3/3] arm64: dts: fsl-lx2160a: include rev2 chip's dts
Message-ID: <20250923111038.qluh2kjmc534ytig@skbuf>
References: <20240826-2160r2-v1-0-106340d538d6@nxp.com>
 <20240826-2160r2-v1-3-106340d538d6@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826-2160r2-v1-3-106340d538d6@nxp.com>

Hi Shawn,

On Mon, Aug 26, 2024 at 05:38:34PM -0400, Frank Li wrote:
> The mass production lx2160 rev2 use designware PCIe Controller. Old Rev1
> which use mobivel PCIe controller was not supported. Although uboot
> fixup can change compatible string fsl,lx2160a-pcie to fsl,ls2088a-pcie
> since 2019, it is quite confused and should correctly reflect hardware
> status in dtb. Change freescale's board to use rev2's dtsi firstly.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts | 2 +-
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 2 +-
>  arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> index 4d721197d837e..71d0d6745e44a 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> @@ -6,7 +6,7 @@
>  
>  /dts-v1/;
>  
> -#include "fsl-lx2160a.dtsi"
> +#include "fsl-lx2160a-rev2.dtsi"
>  
>  / {
>  	model = "NXP Layerscape LX2160AQDS";
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> index 0c44b3cbef773..2373e1c371e8c 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> @@ -6,7 +6,7 @@
>  
>  /dts-v1/;
>  
> -#include "fsl-lx2160a.dtsi"
> +#include "fsl-lx2160a-rev2.dtsi"
>  
>  / {
>  	model = "NXP Layerscape LX2160ARDB";
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
> index 9f5ff1ffe7d5e..7a595fddc0273 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
> @@ -6,7 +6,7 @@
>  
>  /dts-v1/;
>  
> -#include "fsl-lx2160a.dtsi"
> +#include "fsl-lx2160a-rev2.dtsi"
>  
>  / {
>  	model = "NXP Layerscape LX2162AQDS";
> 
> -- 
> 2.34.1
> 
> 

Sorry for digging up an old thread, but I'm curious why you applied
patch 2/3 but not this one? Currently,
arch/arm64/boot/dts/freescale/fsl-lx2160a-rev2.dtsi has no user.

Thread here.
https://lore.kernel.org/lkml/20240826-2160r2-v1-0-106340d538d6@nxp.com/

