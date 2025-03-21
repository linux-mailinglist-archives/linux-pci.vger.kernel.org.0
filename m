Return-Path: <linux-pci+bounces-24386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A588FA6C1EE
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 18:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70394642B6
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 17:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEC122E412;
	Fri, 21 Mar 2025 17:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyX+Bp5w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E28C22A4C9;
	Fri, 21 Mar 2025 17:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742579657; cv=none; b=CS3X+Q2cdQPxRcRs3Aze+KDlkhlectA42Idg4pIVkXCie8SUOKOcXJerSvAmQ2WtP0FvHOqQx1o2ruRdSOG1+3mDmg2f1dKXiJW/hCSiVNK4Dz5JuE2BhEZWE5swCDQax6HpnUGJToakc6mAO5NjBFDghaY2MpCz+772xv/3h4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742579657; c=relaxed/simple;
	bh=gKedzw4liLSwVmSnogIR9b155XLkCctysKV/UrrfMtU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QVE1YUzqxHDiXEA9CPdW0ZV44b0KfibcczuL+aFPhreohrMTuCnS48PVHcIYK/f7mQCw5zF3eO3fzN7GEJ6s9iGunmLRoU/teJXTzDxxmFxo52u4YSQs78POHVdIYRnJZ7vR9qCo4b16yJi+Ry1pQBpSI3qb0m/kskj9E4ee6RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyX+Bp5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAD7C4CEE3;
	Fri, 21 Mar 2025 17:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742579657;
	bh=gKedzw4liLSwVmSnogIR9b155XLkCctysKV/UrrfMtU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SyX+Bp5wqggD+Z8sARhajEpYUpC5IH8nfPIWoAWu6FG+CjkuAnRlnuumwltEC5gpf
	 k4VEiR+tjVmS+MLXUIXLQ1NZwshuFPzySzV7Qqx7F2jhRbB3DsR4Px5j3/w4Kl0fZy
	 3IyTTHqgQzV2OhMVS1hDFJB0A/98f8lbTH/XjE426FysDNbuBxRSHxfM+Fwod7Ltjv
	 OhUQYMM4GPqnFHvJ1UDlpTl6ZQC1uiGBRN8Qtgt06oepc/+l7UNIXTZW3uzymiSEGD
	 3nvuuD5l3vHQq/w5HJrjgtj2jYHRxgsknRolwdVSXeH9l5ffokfoRKKOOF8+nDZBCT
	 qGhtkyxzX/qEQ==
Date: Fri, 21 Mar 2025 12:54:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Lars Persson <lars.persson@axis.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@axis.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC NOT TESTED 0/2] PCI: artpec6: Try to clean up
 artpec6_pcie_cpu_addr_fixup()
Message-ID: <20250321175415.GA1133870@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z92fNs31ybMO2Y1+@axis.com>

On Fri, Mar 21, 2025 at 06:17:42PM +0100, Jesper Nilsson wrote:
> On Thu, Mar 20, 2025 at 04:54:05PM -0500, Bjorn Helgaas wrote:
> > On Tue, Mar 18, 2025 at 10:01:48AM +0100, Niklas Cassel wrote:
> > > On Mon, Mar 17, 2025 at 12:54:19PM -0500, Bjorn Helgaas wrote:
> > > > On Mon, Mar 10, 2025 at 05:47:03PM +0100, Jesper Nilsson wrote:
> > > > > I've now tested this patch-set together with your v9 on-top of the
> > > > > next-branch of the pci tree, and seems to be working good on my
> > > > > ARTPEC-6 set as RC:
> > > > > 
> > > > > # lspci
> > > > > 00:00.0 PCI bridge: Renesas Technology Corp. Device 0024
> > > > > 01:00.0 PCI bridge: Pericom Semiconductor PI7C9X2G304 EL/SL PCIe2 3-Port/4-Lane Packet Switch (rev 05)
> > > > > 02:01.0 PCI bridge: Pericom Semiconductor PI7C9X2G304 EL/SL PCIe2 3-Port/4-Lane Packet Switch (rev 05)
> > > > > 02:02.0 PCI bridge: Pericom Semiconductor PI7C9X2G304 EL/SL PCIe2 3-Port/4-Lane Packet Switch (rev 05)
> > > > > 03:00.0 Non-Volatile memory controller: Phison Electronics Corporation E18 PCIe4 NVMe Controller (rev 01)
> > > > > 
> > > > > However, when running as EP, I found that the DT setup for pcie_ep
> > > > > wasn't correct:
> > > > > 
> > > > > diff --git a/arch/arm/boot/dts/axis/artpec6.dtsi b/arch/arm/boot/dts/axis/artpec6.dtsi
> > > > > index 399e87f72865..6d52f60d402d 100644
> > > > > --- a/arch/arm/boot/dts/axis/artpec6.dtsi
> > > > > +++ b/arch/arm/boot/dts/axis/artpec6.dtsi
> > > > > @@ -195,8 +195,8 @@ pcie: pcie@f8050000 {
> > > > >  
> > > > >                 pcie_ep: pcie_ep@f8050000 {
> > > > >                         compatible = "axis,artpec6-pcie-ep", "snps,dw-pcie";
> > > > > -                       reg = <0xf8050000 0x2000
> > > > > -                              0xf8051000 0x2000
> > > > > +                       reg = <0xf8050000 0x1000
> > > > > +                              0xf8051000 0x1000
> > > > >                                0xf8040000 0x1000
> > > > >                                0x00000000 0x20000000>;
> > > > >                         reg-names = "dbi", "dbi2", "phy", "addr_space";
> > > > > 
> > > > > Even with this fix, I get a panic in dw_pcie_read_dbi() in EP-setup,
> > > > > both with and without:
> > > 
> > > Your fix looks correct to me.
> > > 
> > > You should even be able keep dbi as 0x2000, and simply remove the dbi2
> > > from "reg" and "reg-names", as the driver should be able to infer dbi2
> > > automatically:
> > > https://github.com/torvalds/linux/blob/v6.14-rc7/drivers/pci/controller/dwc/pcie-designware.c#L119-L128
> > > 
> > > But your fix seems more correct.
> > > You should probably also change the size of "dbi" to 0x1000 in the RC node.
> > 
> > Just a ping to see if there's any chance of getting this into v6.15?
> > 
> > To do that, I think we'd need to confirm that:
> > 
> >   - the endpoint issue is fixed
> 
> Unfortunately, I've been unable to get any resolution to this problem.
> 
> - Tested on units without the PCIe switch - still fail
> - Tested on another units - still fail
> - Tested with 6.12-rc7 - fail
> - Tested with 6.6-rc6 - fail
> - Tested with 6.1 - fail
> - Older kernels fail with toolchain or boot problems due to my hacky
>   tools for booting upstream kernels so I can't easily test
> - Tested with original bringup kernel 4.19 - no crash, but endpoint is
>   not enumerated from RC. This contains lots of hacked around code
>   which could also come into play, and there is an untested hardware
>   adapter in between the two boards.

So it sounds like current kernels are already broken for endpoints,
regardless of Frank's series?

If that's the case, I'd be open to merging the removal of
artpec6_pcie_cpu_addr_fixup() because we wouldn't be breaking a
currently-working configuration

And if we don't have artpec6_pcie_cpu_addr_fixup() in the mix, we'll
have a better chance of fixing it nicely, by deriving intermediate
addresses from the devicetree instead of forcing them with
.cpu_addr_fixup().

> The panic looks like this (with some minor variations due to kernel version)

If you had Frank's series included, it should log some useful debug
about the intermediate address offset it derives.  But I don't think
you're getting far enough for this to be the problem.

> =============
> [   16.601883] 8<--- cut here ---
> [   16.604937] Unhandled fault: external abort on non-linefetch (0x008) at 0xf0bdd00e

My guess is:

  artpec6_pcie_probe
    dw_pcie_ep_init
      dw_pcie_ep_get_resources
        dw_pcie_get_resources
          res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi")
          pci->dbi_base = devm_pci_remap_cfg_resource(pci->dev, res)
      dw_pcie_ep_init_registers
        dw_pcie_readb_dbi(PCI_HEADER_TYPE)    # 0x0e
          dw_pcie_read_dbi
            dw_pcie_read(addr = pci->dbi_base + PCI_HEADER_TYPE)
              readb(addr)

It looks like pci->dbi_base *should* be initialized by this time.  I
assume the hardware does support single-byte, non-aligned reads?

> [   16.612502] [f0bdd00e] *pgd=029d6811, *pte=f8050243, *ppte=f8050013
> [   16.618775] Internal error: : 8 [#1] SMP ARM
> [   16.623041] Modules linked in:
> [   16.626092] CPU: 0 UID: 0 PID: 1 Comm: sh Not tainted 6.14.0-rc4-g98c0bcfef512-dirty #26
> [   16.634181] Hardware name: Axis ARTPEC-6 Platform
> [   16.638877] PC is at dw_pcie_read_dbi+0x60/0xa4
> [   16.643414] LR is at 0x0
> [   16.645942] pc : [<c05d9e64>]    lr : [<00000000>]    psr: 60000013
> [   16.652203] sp : f0819bc0  ip : c1e2b840  fp : 00000000
> [   16.657420] r10: c1d9f000  r9 : c1efdbc0  r8 : c1e2b930
> [   16.662638] r7 : c0d2f188  r6 : c1e2b840  r5 : c1e2b930  r4 : 00000000
> [   16.669159] r3 : 00000001  r2 : 00000000  r1 : f0bdd00e  r0 : c1e2b840
> [   16.675679] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [   16.682810] Control: 10c5387d  Table: 02bec04a  DAC: 00000051
> ...

> [   17.073818] Call trace:
> [   17.073828]  dw_pcie_read_dbi from dw_pcie_ep_init_registers+0x2c/0x3bc
> [   17.082978]  dw_pcie_ep_init_registers from artpec6_pcie_probe+0x164/0x1dc
> [   17.089867]  artpec6_pcie_probe from platform_probe+0x5c/0xb0
> [   17.095621]  platform_probe from really_probe+0xe0/0x3cc

