Return-Path: <linux-pci+bounces-24488-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F6DA6D510
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 08:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497463A7721
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 07:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6BE2505A5;
	Mon, 24 Mar 2025 07:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ALjmta4R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA0A17BEBF
	for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 07:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742801251; cv=none; b=BhaA73vvgToFkC6P0gFtXJHcLtwYnXuR1mvzX0/AwsIen2+pvRKrwWmvgt5L3YCL2siRQe+PDQCrV763UNhZMmDr2Hb63QZAD3tnDshzlv3tDwma8oEOdJUE49Aov1V1WIs+zsjj7sIvWWTqkzbHDXJiRJUyaQOMcDk7/FqInZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742801251; c=relaxed/simple;
	bh=JrLE3vI/wDvuR4k6vGhF+iP4fIYrS1WCPX+1G+vy8mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmFnX66h/fX6x6NdyHFSpW883JY03X8/3s8MNQDtB/RgknU1DgwIB1ArdfVCEcW0AfrDWapx2yXPf9vKx+gxzfGcF1GWuboXIQdbQrZF7zM3tIl377dBOiK3UB+o0EKcSOdK+E6I+D0iOap1RlJwoWGP8PiYByUchct2iS/ryTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ALjmta4R; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223fd89d036so72847265ad.1
        for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 00:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742801249; x=1743406049; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t4Jk0LIldEE4o6suSfIbfBeNG/DNl11H9LcTF8uhDEw=;
        b=ALjmta4R2Pm6TW2XabTBQFjPnRPaWJBZoNyGCkYszkwCoa0epahsBJDq4hJ2hudoli
         FYIFPV4XhmD7URLUlwOWYwq5nZ0KJxUzh6FH+b/+KDw0FQVO/+waa6Fcih/kFn1xVG9s
         A9IHEwH8birOR00SdCsjYVmrs16a08Erah8nadOf0ycZZQgczG4v0qB0ib5uzMsAqauQ
         eGs6Oa1hi2Fy63G8LKZsTgZLtaBfatUYF3DYiaMObnGL2vLFpHnVNT8SKSqy/qB8i4bO
         LvdJopZ5CRgVqwA9r2FZQI+nd31JOWw9xiGuAs4B+qtsH9UQ7G/AZHePhpX2F+3U/mXJ
         792Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742801249; x=1743406049;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t4Jk0LIldEE4o6suSfIbfBeNG/DNl11H9LcTF8uhDEw=;
        b=QzWL4twHeleiCoWGi986xZOYunwmqD/Gw9G4uSkFUYaET4xELjKZ1Rvamsj/gfbSH6
         FJZG5S8AxIhtXBq+mMdZUN5UPEFDq7NfOCsPCAWp7pU6EOTTRjih/ekg06mVpjynpK83
         hp4c5zcRXg/PKEl4RovYp2D5cGO9etbrXc5WwAsp8CRtTfti+uqhMU/LA/B1i0n/njNg
         6civPKO0L+pPedfKoYI2yGOebhJpZRikTVHdsKaz5LgDxeB2iF4NU1cG+4qG+ZrRsHTi
         NmcfPRskN2z1lfBarIgUND8wbr6vAdxA1ADh2Et/o+cJ/OcdOSnqAZKOLfMwTCQ73SLo
         7tfA==
X-Forwarded-Encrypted: i=1; AJvYcCUQPk48nI1TbqXSlX1Lu/JUeWJ9smJ7NduolooQKXW2tQWc0lNzuj3y9cHic2SPgxJ2t2Pol0Zsqi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFWNZdaZOKRZXnlsuVPLmmfTuFnWrjXBx2/D4io4Hg756xo+Io
	OQQ27Qo/BFEaPbI1D2C6tf5urQpV6eNma5kavpkpDr3cP3E/dQD/HzX3JOJX+w==
X-Gm-Gg: ASbGncuUkxrnPjT7Mc6bIer3hyoB10uubpPd86kTuJzt6UwUvh3zXwEQvBqdD1ABJvO
	WjIAv5rPtF88OvPk+xV8wiEKG7Vdfs4LPKZEKdCNwD5AtblmGb6Nqc0IR4AfrOdrorHUtxz9X6K
	64NzgJYapqNdg9V4M0G1UEH68E6OmrT1oMO+sXy9o1EevvtjgAT/jqvioAMMnhwrfg0ybRyLY5b
	scd/p0Bhf7XRAs1va6HdsI5BeLX623YO8i6tlRXbM1V0RY3TJjU5LByect81wEon4RFhx9+9sbT
	ln0vzdBaY+lWSau0ajteYEu6SM4NIpuXEZJiA2rEkRlPCd2MuL3my5rMQbiP3Dfbcr8=
X-Google-Smtp-Source: AGHT+IHB65h48pA/PuuIX4VGQx/BccbBSG+++EkqxSdIHlt8LtP0CEKu1UjMquapa/+391yz2zz6zQ==
X-Received: by 2002:aa7:9317:0:b0:736:a682:deb8 with SMTP id d2e1a72fcca58-7390596685bmr22890137b3a.8.1742801248596;
        Mon, 24 Mar 2025 00:27:28 -0700 (PDT)
Received: from thinkpad ([220.158.156.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd67c1sm7406411b3a.60.2025.03.24.00.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 00:27:27 -0700 (PDT)
Date: Mon, 24 Mar 2025 12:57:21 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH PATCH RFC NOT TESTED 1/2] ARM: dts: ti: dra7: Correct
 ranges for PCIe and parent bus nodes
Message-ID: <ahkgq7aujrluhuqbdv2mbn5gjcu6hn4bi3jw4xar52ximyx5pi@mw4v4lzrvtky>
References: <20250305-dra-v1-0-8dc6d9a0e1c0@nxp.com>
 <20250305-dra-v1-1-8dc6d9a0e1c0@nxp.com>
 <20250313165311.2fj7aus3pcsg4m2c@thinkpad>
 <20250314064642.fyf3jqylmc6meft7@uda0492258>
 <Z9RFJDdnoU+aKwF7@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9RFJDdnoU+aKwF7@lizhi-Precision-Tower-5810>

On Fri, Mar 14, 2025 at 11:03:00AM -0400, Frank Li wrote:
> On Fri, Mar 14, 2025 at 12:16:42PM +0530, Siddharth Vadapalli wrote:
> > On Thu, Mar 13, 2025 at 10:23:11PM +0530, Manivannan Sadhasivam wrote:
> >
> > Hello Mani,
> >
> > > On Wed, Mar 05, 2025 at 11:20:22AM -0500, Frank Li wrote:
> > >
> > > If you want a specific patch to be tested, you can add [PATCH RFT] tag.C
> > >
> > > > According to code in drivers/pci/controller/dwc/pci-dra7xx.c
> > > >
> > > > dra7xx_pcie_cpu_addr_fixup()
> > > > {
> > > > 	return cpu_addr & DRA7XX_CPU_TO_BUS_ADDR;  //0x0FFFFFFF
> > > > }
> > > >
> > > > PCI parent bus trim high 4 bits address to 0. Correct ranges in
> > > > target-module@51000000 to algin hardware behavior, which translate PCIe
> > > > outbound address 0..0x0fff_ffff to 0x2000_0000..0x2fff_ffff.
> > > >
> > > > Set 'config' and 'addr_space' reg values to 0.
> > > > Change parent bus address of downstream I/O and non-prefetchable memory to
> > > > 0.
> > > >
> > > > Ensure no functional impact on the final address translation result.
> > > >
> > > > Prepare for the removal of the driver’s cpu_addr_fixup().
> > > >
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  arch/arm/boot/dts/ti/omap/dra7.dtsi | 18 +++++++++---------
> > > >  1 file changed, 9 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/arch/arm/boot/dts/ti/omap/dra7.dtsi b/arch/arm/boot/dts/ti/omap/dra7.dtsi
> > > > index b709703f6c0d4..9213fdd25330b 100644
> > > > --- a/arch/arm/boot/dts/ti/omap/dra7.dtsi
> > > > +++ b/arch/arm/boot/dts/ti/omap/dra7.dtsi
> > > > @@ -196,7 +196,7 @@ axi0: target-module@51000000 {
> > > >  			#size-cells = <1>;
> > > >  			#address-cells = <1>;
> > > >  			ranges = <0x51000000 0x51000000 0x3000>,
> > > > -				 <0x20000000 0x20000000 0x10000000>;
> > > > +				 <0x00000000 0x20000000 0x10000000>;
> > >
> > > I'm not able to interpret this properly. So this essentially means that the
> > > parent address 0x20000000 is mapped to child address 0x00000000. And the child
> > > address is same for other controller as well.
> > >
> > > Also, the cpu_addr_fixup() is doing the same by masking out the upper 4 bits. I
> > > tried looking into the DRA7 TRM, but it says (ECAM_Param_Base_Addr +
> > > 0x20000000) where ECAM_Param_Base_Addr = 0x0000_0000 to 0x0FFF_F000.
> > >
> > > I couldn't relate TRM with the cpu_addr_fixup() callback. Can someone from TI
> > > shed light on this?
> >
> > A "git blame" on the line being modified in dra7.dtsi gives the
> > following commit:
> > https://github.com/torvalds/linux/commit/c761028ef5e2
> > prior to which the ranges is exactly the same as the one being added by
> > this patch.
> 
> Okay, original one correct reflect hardware behavior.
> 
> >
> > The cpu_addr_fixup() function was introduced by the following commit:
> > https://github.com/torvalds/linux/commit/2ed6cc71e6f7
> > with the reason described in
> > Section 24.9.4.3.2 PCIe Controller Slave Port
> > of the T.R.M. at:
> > https://www.ti.com/lit/ug/spruic2d/spruic2d.pdf
> > ---------------------------------------------------------------------------
> > NOTE:
> > The PCIe controller remains fully functional, and able to send transactions
> > to, for example, anywhere within the 64-bit PCIe memory space, with the
> > appropriate remapping of the 28-bit address by the outbound address
> > translation unit (iATU). The limitation is that the total size of addressed
> > PCIe regions (in config, memory, IO spaces) must be less than 2^28 bytes.
> > ---------------------------------------------------------------------------
> >
> > The entire sequence is:
> > 0) dra7.dtsi had ranges which match the ranges in the current patch.
> > 1) cpu_addr_fixup() was added by
> > https://github.com/torvalds/linux/commit/2ed6cc71e6f7
> > 2) ranges was updated to <0x20000000 0x20000000 0x10000000> by:
> > https://github.com/torvalds/linux/commit/c761028ef5e2
> 
> Actually this patch is not necessary, with cpu_addr_fixup(), it should
> work with/without c761028ef5e2 change because it just the use CPU physical
> address, the finial result is exact same.
> 
> > 3) ranges is being changed back to its original state of "0)" above.
> >
> > cpu_addr_fixup() was introduced to remove the following:
> > 	pp->io_base &= DRA7XX_CPU_TO_BUS_ADDR;
> > 	pp->mem_base &= DRA7XX_CPU_TO_BUS_ADDR;
> > 	pp->cfg0_base &= DRA7XX_CPU_TO_BUS_ADDR;
> > 	pp->cfg1_base &= DRA7XX_CPU_TO_BUS_ADDR;
> > in dra7xx_pcie_host_init(). The reason for the above is mentioned in the
> > "NOTE" as:
> > ---------------------------------------------------------------------------
> > The limitation is that the total size of addressed PCIe regions
> > (in config, memory, IO spaces) must be less than 2^28 bytes.
> > ---------------------------------------------------------------------------
> >
> 
> That is functional equal.
> 
> > I am not sure if Frank is accounting for all of this in the current patch
> > as well as the dependent patch series associated with removing
> > cpu_addr_fixup().
> 
> I have not track back the history. I think before
> https://github.com/torvalds/linux/commit/c761028ef5e2 is correct reflect
> hardware behavor. axi@0 trim down 4 bits before send to PCI controller.
> 
> The commit message of c761028ef5e2
> 
> "In order to update pcie to probe with ti-sysc and genpd, let's update the
> pcie ranges to not use address 0 for 0x20000000 and 0x30000000. The range
> for 0 is typically used for child devices as the offset from the module
> base. In the following patches, we will update pcie to probe with ti-sysc,
> and the patches become a bit confusing to read compared to other similar
> modules unless we update the ranges first. So let's just use the full
> addresses for ranges for the 0x20000000 and 0x30000000 ranges."
> 
> I think maybe only ti's bus fabric do address translation at that time, and
> DT team and dwc pci driver never consider that before. Now more vendor bus
> fabric do address translation. So needn't every platform driver consider it
> but it require DTB reflect hardware behavor correctly.
> 
> We may revert patch c761028ef5e2 firstly, after some time later, we can
> cleanup cpu_addr_fixup().
> 

I agree. Commit, c761028ef5e2 is not going to break anything afaik (even the
cpu_addr_fixup), but it would be good to get it tested.

> It will be wondful, if someone help test it.
> 

Let's see if Siddharth can come up with some good news.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

