Return-Path: <linux-pci+bounces-23670-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975DDA5FCB9
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 17:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D5E3BE445
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 16:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B60C26A0B4;
	Thu, 13 Mar 2025 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RW5ZPE6z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A50268FEF
	for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884802; cv=none; b=rSFmePZzugl4VqLb5jdeeu5yZv10ga+WDv/L9guRWVDhKq+wiNqR1Uk0Os6ciu5Vmcbhze/5uY3ddphvC0jboBkVzkRPYVndS/IDLFmrudgA3hemBEilX8og6Zibz1elNRdWSf9wN4jAFEkx6yxeWr19ugnxKFtbx/2o/gctaTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884802; c=relaxed/simple;
	bh=vwhTZJRxz/U4j6Fnzkv92NNO3NpiYFquEmYKurAYKUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A39seXcW6w9OsSCkFBGAVRGxpopuROaMxrR/wvQvy+DMxc90rQ+6lfJFX6jkm0R5iUWTorGNVQnabbox9rkT02b31/1MI4P2798t9QXx3XXxnvUjz/uFAqMrfy9gqUV3z0QEsuftxX5RCkuyfI7pPAfyyQn23hxMah/BP33hZaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RW5ZPE6z; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-224341bbc1dso25820205ad.3
        for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 09:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741884799; x=1742489599; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RVvf10Ck2ho127r39h3riZTqgWY3zjYMF5s83hBhWK4=;
        b=RW5ZPE6z8irH1KoF0hnYQffpHs8m/c/ALM2SXyC3OntO6Ij67BzGys14gUSuwPKR7D
         XLA+zmh6D0mYfX7wb2XtThnWEg/PFtgE3CAIoHJIP8kR5ZklubksuQ84GkY8O/TC9NaX
         dBi7eIG3fOKXtS1zhM8qtV61POjJGYWjyR3/YJ2q16SJ5JuLcO3ekE3Y7xEN3zekijMj
         3jQb34FnJIUTvwuV4Sur01NY8x2ww/8HmDhjNGsF3or+BKzW9v2GpHRrjWmGB2okKZf3
         dgmJ2Ira8+Uf+U9hXkJwtmdua1twkpkSBO7WTumh1P6fq591HFtOj6Xs8WpsH9PiSkQX
         C9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741884799; x=1742489599;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RVvf10Ck2ho127r39h3riZTqgWY3zjYMF5s83hBhWK4=;
        b=VENVUtEzhvrDTJB4Mp3LuhPAjhlKfLyf3A/Rh80+jGz5LNWAdnXr+gHV5wlCsKjXLN
         f7ARJMXHSm1wldEUpvWGGIcwqajOLUsoThN9unCXSvjCh9aEjtNIEErLxOHCQJf6+RPX
         IZYqv1IElab+aUE3WwnK9j3EMyU10dFC1wd1eCKhL7NQndLjZFjz0I6mohCWUxZeTR1m
         qGApbD9L9TnFuIH6q5xwz/SvuZAjIRT89BYPmFi117hMs1tfcag/LHMGPbiBItZXzN9W
         n6l9nN0px9B0FLmf+/u77D18s4FGJYvD9a00I3MPHJ5eF9x/pzig+ZHSaMjJVqo4tsEm
         sGNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9JAe7MLrrUfkvwHegx+LkayF5o+ykcKz59OE/PqnI9UKNt2o4/YlOXAUJrnQSyjgs5kqM2jMC5/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0arRNDkRpQmF6Mvjzela6vnqTrNU/9GUed6Jwiq9z/X/ooSq4
	LFOMxRqsIZEftV5VESVfxJKE2eOKiq1reIq6IdrUcWFjZ3cB70zhqhpEMz19Kg==
X-Gm-Gg: ASbGncu0ZK5mEmrnO6PIrEAeS6ihjg71jPnDELX7PjrzaUELTAwdVYHFQZdIb29ZEUI
	1Vv4q2/rygwN0koZh00lTf8BVhkE7RITZIHNrQIZL/J+1CwnI6EqZZIvZL+ntoIRYOga5chBeA0
	RbRa3ArtT7sG0GkUR0lC0nOEcKrjEvPeQjycNIcUm3rsUJXNDdX0k1USBXFEqSfC2NNLDZV4NRy
	LNPQn9/H0gdlwYUtviG/P/6iJjm7q9wSG5Om1WuLvGUD6814/DfB8BEByWV8n/lu8FeiQvIxtHI
	S9ME4JRE3p+nqN2o76xixWnxUdgxkkybTOdjfTukzsD3iKowtpJfJg==
X-Google-Smtp-Source: AGHT+IFfcfuSPGO2mr5Ih54HzoCrJnTgSB49gCqwRuzftDvua6QaTJh101E/NjM3KLYPx8ydFXU52A==
X-Received: by 2002:a05:6a21:3a93:b0:1f5:7b6f:f8e8 with SMTP id adf61e73a8af0-1f58cad4b2amr19998674637.6.1741884799320;
        Thu, 13 Mar 2025 09:53:19 -0700 (PDT)
Received: from thinkpad ([120.60.60.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737115511dasm1605770b3a.60.2025.03.13.09.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:53:18 -0700 (PDT)
Date: Thu, 13 Mar 2025 22:23:11 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH PATCH RFC NOT TESTED 1/2] ARM: dts: ti: dra7: Correct
 ranges for PCIe and parent bus nodes
Message-ID: <20250313165311.2fj7aus3pcsg4m2c@thinkpad>
References: <20250305-dra-v1-0-8dc6d9a0e1c0@nxp.com>
 <20250305-dra-v1-1-8dc6d9a0e1c0@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250305-dra-v1-1-8dc6d9a0e1c0@nxp.com>

On Wed, Mar 05, 2025 at 11:20:22AM -0500, Frank Li wrote:

If you want a specific patch to be tested, you can add [PATCH RFT] tag.C

> According to code in drivers/pci/controller/dwc/pci-dra7xx.c
> 
> dra7xx_pcie_cpu_addr_fixup()
> {
> 	return cpu_addr & DRA7XX_CPU_TO_BUS_ADDR;  //0x0FFFFFFF
> }
> 
> PCI parent bus trim high 4 bits address to 0. Correct ranges in
> target-module@51000000 to algin hardware behavior, which translate PCIe
> outbound address 0..0x0fff_ffff to 0x2000_0000..0x2fff_ffff.
> 
> Set 'config' and 'addr_space' reg values to 0.
> Change parent bus address of downstream I/O and non-prefetchable memory to
> 0.
> 
> Ensure no functional impact on the final address translation result.
> 
> Prepare for the removal of the driver’s cpu_addr_fixup().
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm/boot/dts/ti/omap/dra7.dtsi | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ti/omap/dra7.dtsi b/arch/arm/boot/dts/ti/omap/dra7.dtsi
> index b709703f6c0d4..9213fdd25330b 100644
> --- a/arch/arm/boot/dts/ti/omap/dra7.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/dra7.dtsi
> @@ -196,7 +196,7 @@ axi0: target-module@51000000 {
>  			#size-cells = <1>;
>  			#address-cells = <1>;
>  			ranges = <0x51000000 0x51000000 0x3000>,
> -				 <0x20000000 0x20000000 0x10000000>;
> +				 <0x00000000 0x20000000 0x10000000>;

I'm not able to interpret this properly. So this essentially means that the
parent address 0x20000000 is mapped to child address 0x00000000. And the child
address is same for other controller as well.

Also, the cpu_addr_fixup() is doing the same by masking out the upper 4 bits. I
tried looking into the DRA7 TRM, but it says (ECAM_Param_Base_Addr +
0x20000000) where ECAM_Param_Base_Addr = 0x0000_0000 to 0x0FFF_F000.

I couldn't relate TRM with the cpu_addr_fixup() callback. Can someone from TI
shed light on this?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

