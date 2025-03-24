Return-Path: <linux-pci+bounces-24486-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871E6A6D4FF
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 08:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4ECD3A43A8
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 07:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66105192D97;
	Mon, 24 Mar 2025 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AcfwUvPn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2F7192B95
	for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 07:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742800995; cv=none; b=nR5Ov5Zm11DoOXiciHqEGBL2h2VRaPR2UrdFvcarD1RuwCnfPseQp9G3XXZUb+TWWfIrWFdqEmLLVqBiQ7p0ncV5euM0jZizzCWsgrsw9ylEHuqA7GcuperZTG1fphEdlE/hozFPHsbNb//ovYRM0Y2+wvDp9tkM2r7hAkaKluM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742800995; c=relaxed/simple;
	bh=Rq5Qsj+vtD9TgfS3gUgFhd0FdKFXn64WXTOxKmO6hBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvFybDunhqAC2X09H+26qTnEsO4BIYl3QNu97eCyX39LBLxlbvtluavc3tX+vjGckFo9+xCQfyEhumm+1jRNxsecQR588NjVmRfnfN7tnGy71WS/eJUaGz6FxrpH0tw66u4gELNQ0CTup4gLPkRQTfzmFmPwvNEq77j0LFfIzXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AcfwUvPn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223fb0f619dso77937995ad.1
        for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 00:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742800993; x=1743405793; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qe/MCCvdJLYJ3g+QnwJQUU6NC2SI4IaMPwysTrJxuV0=;
        b=AcfwUvPnzD8feBoFMYcGQDZr8gNGhElE2P9+5TlfXfzozRkql5+6bPoYp6tG7dBJH/
         tARAKzEXxuxrn49DEGkksvFJtgk0cXjWq4O9/ZIOKEoHlENv1NzM6+PL2eWATFdh6x+i
         NpwqxgWRndt5AITQs6ml/xpxPGQYpLnBGdgnUaNOs5MJmqoA2+QJn0C+PyyoqBRsw/FY
         yH5PqmuT5QIsaDh7kjEvsNlBrhUIyN/sBzk0X6b/B8M/mhL00QIkxQzZ3UZRWTw+NblC
         Rmo2+2cu9/VOOSVVjCqjAStp81GNNP9fYEE8NmZQ9FJ/fId/YYj5kNJGBBi9tlH280h7
         qvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742800993; x=1743405793;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qe/MCCvdJLYJ3g+QnwJQUU6NC2SI4IaMPwysTrJxuV0=;
        b=J+HB2DbSJod0mDW72DUZxEbQ8Fhd8Jp9H44eWecDI290bfrrcudWv3ErmxicVJOg9O
         RFVaxouAYwjTWKwMfxgHSLEaDWVdtjA2ObqzpUAz610zIjfCxws96FjRhobBF+qnmyfi
         8LBQNmRAicAt9wOxDL5IOF9M+Owzdt/brrajdk1wII2kykYdCkhrCqGQXxc58ikad9sk
         X5k4PIq8LkYCiHtu/ShqJxyIsLdGzT/mrYEs9hxXhV9B2YBL9SY9fPw8lo9Dd97vPemt
         y3+YRXjPr+y27tIlPlpxNWFsgZcJ5eLVjNY4Z/ZkdyA2pRJDX46YrsLQ3J3yuOXxBK2c
         XpyA==
X-Forwarded-Encrypted: i=1; AJvYcCWA7Ph/pp+uTADyX98tgT5NRurHAOLN4ah2dfjf6GuBYO5CZcEsI31mtSc1pE3oTlZB1prsRfdl6/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwevtJda9VXB2M4NtDp1njTCjcZDZQxE4l4StigdDW7heMTzrdH
	aDV1c2Bc2v6u3fK8rNhYlaipyJtD+3N7iB9iG7myN83RBkGageN5F3fMK8DIZQ==
X-Gm-Gg: ASbGnctadR8HOBouo6QKL/gG7KAIeN+OCD3sPyONmq5ven7aHKtOJC0x7ZzX4gFmwz9
	j4U2cL50G92gqmkXH03GUyJJQidaEfhmqKN2807Q4za6WfHQtN5ZJN9FHDbSHtBdQEmG0s+vBzz
	mdTB3B67VFeC6rTwwVqmzgAYqMljgwKIsIJFwFnPpdJ1hRw0qkdHUjdfq+mDS7+VZdWZMy5M5ZM
	+wxeitAfrTIfROUYZdqFouYznl7tMuRFBOmqmj0Ad+48ZPo1lJfFpOCsn4zG1hnlRFUy2e4n+CQ
	P3+ppn1FVQHZP0haxV5bdeUcOkbgOWri3PUluak243wCppQ/XcJ8HZJMXQZSAEOUnx0=
X-Google-Smtp-Source: AGHT+IEVDoBTCHOODzvBGMAnc/Iok1j6AhaExydrGDQgnCUirKAYBNkCKwG2t70sQoq1tMM3o02m1Q==
X-Received: by 2002:a17:903:230d:b0:220:e9ac:e746 with SMTP id d9443c01a7336-22780e46648mr200826765ad.53.1742800992590;
        Mon, 24 Mar 2025 00:23:12 -0700 (PDT)
Received: from thinkpad ([220.158.156.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22781208966sm63304325ad.254.2025.03.24.00.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 00:23:12 -0700 (PDT)
Date: Mon, 24 Mar 2025 12:53:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Frank Li <Frank.Li@nxp.com>, Tony Lindgren <tony@atomide.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH PATCH RFC NOT TESTED 1/2] ARM: dts: ti: dra7: Correct
 ranges for PCIe and parent bus nodes
Message-ID: <hhvst2uvlymcyir5sb5vwd4ezko7yawwp5cnosluaz2hkabcna@ywr4thtjpdps>
References: <20250305-dra-v1-0-8dc6d9a0e1c0@nxp.com>
 <20250305-dra-v1-1-8dc6d9a0e1c0@nxp.com>
 <20250313165311.2fj7aus3pcsg4m2c@thinkpad>
 <20250314064642.fyf3jqylmc6meft7@uda0492258>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250314064642.fyf3jqylmc6meft7@uda0492258>

On Fri, Mar 14, 2025 at 12:16:42PM +0530, Siddharth Vadapalli wrote:
> On Thu, Mar 13, 2025 at 10:23:11PM +0530, Manivannan Sadhasivam wrote:
> 
> Hello Mani,
> 
> > On Wed, Mar 05, 2025 at 11:20:22AM -0500, Frank Li wrote:
> > 
> > If you want a specific patch to be tested, you can add [PATCH RFT] tag.C
> > 
> > > According to code in drivers/pci/controller/dwc/pci-dra7xx.c
> > > 
> > > dra7xx_pcie_cpu_addr_fixup()
> > > {
> > > 	return cpu_addr & DRA7XX_CPU_TO_BUS_ADDR;  //0x0FFFFFFF
> > > }
> > > 
> > > PCI parent bus trim high 4 bits address to 0. Correct ranges in
> > > target-module@51000000 to algin hardware behavior, which translate PCIe
> > > outbound address 0..0x0fff_ffff to 0x2000_0000..0x2fff_ffff.
> > > 
> > > Set 'config' and 'addr_space' reg values to 0.
> > > Change parent bus address of downstream I/O and non-prefetchable memory to
> > > 0.
> > > 
> > > Ensure no functional impact on the final address translation result.
> > > 
> > > Prepare for the removal of the driver’s cpu_addr_fixup().
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  arch/arm/boot/dts/ti/omap/dra7.dtsi | 18 +++++++++---------
> > >  1 file changed, 9 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/ti/omap/dra7.dtsi b/arch/arm/boot/dts/ti/omap/dra7.dtsi
> > > index b709703f6c0d4..9213fdd25330b 100644
> > > --- a/arch/arm/boot/dts/ti/omap/dra7.dtsi
> > > +++ b/arch/arm/boot/dts/ti/omap/dra7.dtsi
> > > @@ -196,7 +196,7 @@ axi0: target-module@51000000 {
> > >  			#size-cells = <1>;
> > >  			#address-cells = <1>;
> > >  			ranges = <0x51000000 0x51000000 0x3000>,
> > > -				 <0x20000000 0x20000000 0x10000000>;
> > > +				 <0x00000000 0x20000000 0x10000000>;
> > 
> > I'm not able to interpret this properly. So this essentially means that the
> > parent address 0x20000000 is mapped to child address 0x00000000. And the child
> > address is same for other controller as well.
> > 
> > Also, the cpu_addr_fixup() is doing the same by masking out the upper 4 bits. I
> > tried looking into the DRA7 TRM, but it says (ECAM_Param_Base_Addr +
> > 0x20000000) where ECAM_Param_Base_Addr = 0x0000_0000 to 0x0FFF_F000.
> > 
> > I couldn't relate TRM with the cpu_addr_fixup() callback. Can someone from TI
> > shed light on this?
> 
> A "git blame" on the line being modified in dra7.dtsi gives the
> following commit:
> https://github.com/torvalds/linux/commit/c761028ef5e2
> prior to which the ranges is exactly the same as the one being added by
> this patch.
> 
> The cpu_addr_fixup() function was introduced by the following commit:
> https://github.com/torvalds/linux/commit/2ed6cc71e6f7
> with the reason described in
> Section 24.9.4.3.2 PCIe Controller Slave Port
> of the T.R.M. at:
> https://www.ti.com/lit/ug/spruic2d/spruic2d.pdf
> ---------------------------------------------------------------------------
> NOTE:
> The PCIe controller remains fully functional, and able to send transactions
> to, for example, anywhere within the 64-bit PCIe memory space, with the
> appropriate remapping of the 28-bit address by the outbound address
> translation unit (iATU). The limitation is that the total size of addressed
> PCIe regions (in config, memory, IO spaces) must be less than 2^28 bytes.
> ---------------------------------------------------------------------------
> 
> The entire sequence is:
> 0) dra7.dtsi had ranges which match the ranges in the current patch.
> 1) cpu_addr_fixup() was added by
> https://github.com/torvalds/linux/commit/2ed6cc71e6f7
> 2) ranges was updated to <0x20000000 0x20000000 0x10000000> by:
> https://github.com/torvalds/linux/commit/c761028ef5e2
> 3) ranges is being changed back to its original state of "0)" above.
> 

Thanks a lot for the reference.

> cpu_addr_fixup() was introduced to remove the following:
> 	pp->io_base &= DRA7XX_CPU_TO_BUS_ADDR;
> 	pp->mem_base &= DRA7XX_CPU_TO_BUS_ADDR;
> 	pp->cfg0_base &= DRA7XX_CPU_TO_BUS_ADDR;
> 	pp->cfg1_base &= DRA7XX_CPU_TO_BUS_ADDR;
> in dra7xx_pcie_host_init(). The reason for the above is mentioned in the
> "NOTE" as:
> ---------------------------------------------------------------------------
> The limitation is that the total size of addressed PCIe regions
> (in config, memory, IO spaces) must be less than 2^28 bytes.
> ---------------------------------------------------------------------------
> 

I don't think so. This note is for the *size* of the addressed regions. The
fixup corresponds to the sentence in your above note from TRM:

"able to send transactions to, for example, anywhere within the 64-bit PCIe
memory space, with the appropriate remapping of the 28-bit address by the
outbound address translation unit (iATU)"

I think the limitation is due to the 29-bit address bus width of the PCIe
controller slave port as mentionend in section, 24.9.4.3.2. And that correlates
to the truncation of the upper 4 bits of the IO/CFG/MEM addresses. So even if
the CPU passes address range relative to offset 0, PCIe controller converts it
to 0x20000000/0x30000000 based on the instance.

If my understanding is correct, then commit, c761028ef5e2 should be reverted and
this patch can be applied.

> I am not sure if Frank is accounting for all of this in the current patch
> as well as the dependent patch series associated with removing
> cpu_addr_fixup().
> 
> Regarding testing the series, I unfortunately don't have the hardware so
> I cannot test it.
> 

That's a pity. If TI employee doesn't have access to an upstream supported
platform, then I'm not sure whom we should ask for testing.

Could you please ask around and see if you can get access to one? I'm sure that
the hardware will be available somewhere :)

- Mani

-- 
மணிவண்ணன் சதாசிவம்

