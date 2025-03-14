Return-Path: <linux-pci+bounces-23709-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA3FA60949
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 07:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE213A23D9
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 06:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FA713D26B;
	Fri, 14 Mar 2025 06:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QBExZSDE"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D1622339;
	Fri, 14 Mar 2025 06:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741934838; cv=none; b=VhjtpZtEZKtOcZzDttBlNT9AKVtdgdlJ7tlRoEu9dUHEYCSNStynAqBHjOSMAMHHMYuHNQsBQD5HcjEy6HaOySOXc66VPDLFwEV9e4nSWqNtj6UNfL3Y41vhoQnE2m6ctjLKcqA1uOdaqEMMhfrL8VusM+t1MxuPJ2GUFkwWB9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741934838; c=relaxed/simple;
	bh=vjRo8A/nl0MNPlHLRqdBMTEDNlFgWMnGlQWCZBpMdxc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdVZyEsqRo/wS0vip4uRjTIkqT3TkETG+bzFc1h8Qy6pkRC8bBGNfvObqhJ32o2wI8FO7Rk0dELfPRjTo9iKGKsy+H4XW/AzI6ZD/Cuyartbljw+JIB9HHRXiu+28qsHmYhPhxCBO7X1VsOl9/RTvpBMLGvO3WtABcUFeQ4IuVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QBExZSDE; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52E6kiWC2063154
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 01:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741934804;
	bh=sdv4Yo9ucrKy29fcoJrxnRwdBQqji21FxYro7lytlc4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=QBExZSDEGmPHLzA6qsuMdsZ87CEhH9UuDdJqw8tIQ8kGUBYsBbWc1N3cliSogzmvO
	 N2qYjaClgK7sXf35eZ2kg3naoyhq8X84YJtLCEf1iSCMjhVyqQcXKjksGHbd3wt1EW
	 KQRypMsLx8Y2DJtGqXwZPVcifxJIefmf6uA6El6Q=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52E6ki2E108138
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Mar 2025 01:46:44 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Mar 2025 01:46:43 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Mar 2025 01:46:43 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52E6kgOi032405;
	Fri, 14 Mar 2025 01:46:43 -0500
Date: Fri, 14 Mar 2025 12:16:42 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Frank Li <Frank.Li@nxp.com>, Tony Lindgren <tony@atomide.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Siddharth
 Vadapalli <s-vadapalli@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas
	<bhelgaas@google.com>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH PATCH RFC NOT TESTED 1/2] ARM: dts: ti: dra7: Correct
 ranges for PCIe and parent bus nodes
Message-ID: <20250314064642.fyf3jqylmc6meft7@uda0492258>
References: <20250305-dra-v1-0-8dc6d9a0e1c0@nxp.com>
 <20250305-dra-v1-1-8dc6d9a0e1c0@nxp.com>
 <20250313165311.2fj7aus3pcsg4m2c@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313165311.2fj7aus3pcsg4m2c@thinkpad>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Thu, Mar 13, 2025 at 10:23:11PM +0530, Manivannan Sadhasivam wrote:

Hello Mani,

> On Wed, Mar 05, 2025 at 11:20:22AM -0500, Frank Li wrote:
> 
> If you want a specific patch to be tested, you can add [PATCH RFT] tag.C
> 
> > According to code in drivers/pci/controller/dwc/pci-dra7xx.c
> > 
> > dra7xx_pcie_cpu_addr_fixup()
> > {
> > 	return cpu_addr & DRA7XX_CPU_TO_BUS_ADDR;  //0x0FFFFFFF
> > }
> > 
> > PCI parent bus trim high 4 bits address to 0. Correct ranges in
> > target-module@51000000 to algin hardware behavior, which translate PCIe
> > outbound address 0..0x0fff_ffff to 0x2000_0000..0x2fff_ffff.
> > 
> > Set 'config' and 'addr_space' reg values to 0.
> > Change parent bus address of downstream I/O and non-prefetchable memory to
> > 0.
> > 
> > Ensure no functional impact on the final address translation result.
> > 
> > Prepare for the removal of the driver’s cpu_addr_fixup().
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  arch/arm/boot/dts/ti/omap/dra7.dtsi | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/ti/omap/dra7.dtsi b/arch/arm/boot/dts/ti/omap/dra7.dtsi
> > index b709703f6c0d4..9213fdd25330b 100644
> > --- a/arch/arm/boot/dts/ti/omap/dra7.dtsi
> > +++ b/arch/arm/boot/dts/ti/omap/dra7.dtsi
> > @@ -196,7 +196,7 @@ axi0: target-module@51000000 {
> >  			#size-cells = <1>;
> >  			#address-cells = <1>;
> >  			ranges = <0x51000000 0x51000000 0x3000>,
> > -				 <0x20000000 0x20000000 0x10000000>;
> > +				 <0x00000000 0x20000000 0x10000000>;
> 
> I'm not able to interpret this properly. So this essentially means that the
> parent address 0x20000000 is mapped to child address 0x00000000. And the child
> address is same for other controller as well.
> 
> Also, the cpu_addr_fixup() is doing the same by masking out the upper 4 bits. I
> tried looking into the DRA7 TRM, but it says (ECAM_Param_Base_Addr +
> 0x20000000) where ECAM_Param_Base_Addr = 0x0000_0000 to 0x0FFF_F000.
> 
> I couldn't relate TRM with the cpu_addr_fixup() callback. Can someone from TI
> shed light on this?

A "git blame" on the line being modified in dra7.dtsi gives the
following commit:
https://github.com/torvalds/linux/commit/c761028ef5e2
prior to which the ranges is exactly the same as the one being added by
this patch.

The cpu_addr_fixup() function was introduced by the following commit:
https://github.com/torvalds/linux/commit/2ed6cc71e6f7
with the reason described in
Section 24.9.4.3.2 PCIe Controller Slave Port
of the T.R.M. at:
https://www.ti.com/lit/ug/spruic2d/spruic2d.pdf
---------------------------------------------------------------------------
NOTE:
The PCIe controller remains fully functional, and able to send transactions
to, for example, anywhere within the 64-bit PCIe memory space, with the
appropriate remapping of the 28-bit address by the outbound address
translation unit (iATU). The limitation is that the total size of addressed
PCIe regions (in config, memory, IO spaces) must be less than 2^28 bytes.
---------------------------------------------------------------------------

The entire sequence is:
0) dra7.dtsi had ranges which match the ranges in the current patch.
1) cpu_addr_fixup() was added by
https://github.com/torvalds/linux/commit/2ed6cc71e6f7
2) ranges was updated to <0x20000000 0x20000000 0x10000000> by:
https://github.com/torvalds/linux/commit/c761028ef5e2
3) ranges is being changed back to its original state of "0)" above.

cpu_addr_fixup() was introduced to remove the following:
	pp->io_base &= DRA7XX_CPU_TO_BUS_ADDR;
	pp->mem_base &= DRA7XX_CPU_TO_BUS_ADDR;
	pp->cfg0_base &= DRA7XX_CPU_TO_BUS_ADDR;
	pp->cfg1_base &= DRA7XX_CPU_TO_BUS_ADDR;
in dra7xx_pcie_host_init(). The reason for the above is mentioned in the
"NOTE" as:
---------------------------------------------------------------------------
The limitation is that the total size of addressed PCIe regions
(in config, memory, IO spaces) must be less than 2^28 bytes.
---------------------------------------------------------------------------

I am not sure if Frank is accounting for all of this in the current patch
as well as the dependent patch series associated with removing
cpu_addr_fixup().

Regarding testing the series, I unfortunately don't have the hardware so
I cannot test it.

Regards,
Siddharth.

