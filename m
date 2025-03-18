Return-Path: <linux-pci+bounces-24022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25095A66F39
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 10:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0396019A2D96
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 09:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE361DE4DC;
	Tue, 18 Mar 2025 09:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxQhgSWE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B254042AB4;
	Tue, 18 Mar 2025 09:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742288513; cv=none; b=NWBAFJtyBJHqnamPZFwEnHaye+lMt2VHYt5fV7yyyfLmOkBoxgGfnNzoflMI4919141UUh2m7CEW8SXfQj1o5/ZBL0scY58yn1yLKhtgb32MeNgwCHqKiqqbPhIG53luFMuxFOr+BrI2/+x70htew6D91f4YZShpuL1bqbJZhPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742288513; c=relaxed/simple;
	bh=m7HEapZAycbQjtvmrxMb/Siih8OzNWBK9rT29ShBgc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWTZyUmcOJw5PTY/Ny35gatpDDIvmj4NgZLQagPcsq8SROhBxitEHue0wjQwhjCkOCEMQKG0I8ZeOFJsNvSHJXtvjM0TFZGhTEb4TWSXsf+TOpgxQFgxvZamviMkcvce8Tn7GlKg6NszXZ02jg6mMgNmz7EntiuT10/0HBuZDLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxQhgSWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89565C4CEDD;
	Tue, 18 Mar 2025 09:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742288513;
	bh=m7HEapZAycbQjtvmrxMb/Siih8OzNWBK9rT29ShBgc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gxQhgSWEp4OaFDIiFosNNc8DKTsjsRuVdNt+Y0DPos09ML9jBmq6yxk0WsB00HHk9
	 o6shLp+2SLD2NI6/88bynEHpZ99prjUcHjnKDfLzA73ErPZuN40aF7zwTLcBqBxhi9
	 zRsiP0G1rxSrFF62RmMlfNmK8IaJMjZRdMArrFFHTQOOsrlZ12AYb3NIyDXdOljK3T
	 7llK1ufzWqzmSuGb/x1X9aSQKFqDl8Jk0Dr25obfKOQH85WsNO07FX7WWwl5wMDG92
	 n1eRxhmhDi6YcPsmHlvPqn9qfZ5XnIEAfOVERHj0sntiHWRTNm88xC8peZ/abX5iw7
	 7g9Rw5hRsLOJQ==
Date: Tue, 18 Mar 2025 10:01:48 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>, Frank Li <Frank.Li@nxp.com>,
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
Message-ID: <Z9k2fLFU3UCubK97@ryzen>
References: <Z88Xh75G6Wabwl2O@axis.com>
 <20250317175419.GA933527@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317175419.GA933527@bhelgaas>

Hello Bjorn, Jesper,

On Mon, Mar 17, 2025 at 12:54:19PM -0500, Bjorn Helgaas wrote:
> On Mon, Mar 10, 2025 at 05:47:03PM +0100, Jesper Nilsson wrote:
> > I've now tested this patch-set together with your v9 on-top of the
> > next-branch of the pci tree, and seems to be working good on my
> > ARTPEC-6 set as RC:
> > 
> > # lspci
> > 00:00.0 PCI bridge: Renesas Technology Corp. Device 0024
> > 01:00.0 PCI bridge: Pericom Semiconductor PI7C9X2G304 EL/SL PCIe2 3-Port/4-Lane Packet Switch (rev 05)
> > 02:01.0 PCI bridge: Pericom Semiconductor PI7C9X2G304 EL/SL PCIe2 3-Port/4-Lane Packet Switch (rev 05)
> > 02:02.0 PCI bridge: Pericom Semiconductor PI7C9X2G304 EL/SL PCIe2 3-Port/4-Lane Packet Switch (rev 05)
> > 03:00.0 Non-Volatile memory controller: Phison Electronics Corporation E18 PCIe4 NVMe Controller (rev 01)
> > 
> > However, when running as EP, I found that the DT setup for pcie_ep
> > wasn't correct:
> > 
> > diff --git a/arch/arm/boot/dts/axis/artpec6.dtsi b/arch/arm/boot/dts/axis/artpec6.dtsi
> > index 399e87f72865..6d52f60d402d 100644
> > --- a/arch/arm/boot/dts/axis/artpec6.dtsi
> > +++ b/arch/arm/boot/dts/axis/artpec6.dtsi
> > @@ -195,8 +195,8 @@ pcie: pcie@f8050000 {
> >  
> >                 pcie_ep: pcie_ep@f8050000 {
> >                         compatible = "axis,artpec6-pcie-ep", "snps,dw-pcie";
> > -                       reg = <0xf8050000 0x2000
> > -                              0xf8051000 0x2000
> > +                       reg = <0xf8050000 0x1000
> > +                              0xf8051000 0x1000
> >                                0xf8040000 0x1000
> >                                0x00000000 0x20000000>;
> >                         reg-names = "dbi", "dbi2", "phy", "addr_space";
> > 
> > Even with this fix, I get a panic in dw_pcie_read_dbi() in EP-setup,
> > both with and without:

Your fix looks correct to me.

You should even be able keep dbi as 0x2000, and simply remove the dbi2
from "reg" and "reg-names", as the driver should be able to infer dbi2
automatically:
https://github.com/torvalds/linux/blob/v6.14-rc7/drivers/pci/controller/dwc/pcie-designware.c#L119-L128

But your fix seems more correct.
You should probably also change the size of "dbi" to 0x1000 in the RC node.


For the panic, could you please share the stack trace?
(Perhaps we can help)


> > 
> > "PCI: artpec6: Use use_parent_dt_ranges and clean up artpec6_pcie_cpu_addr_fixup()"
> > 
> > so it looks like the ARTPEC-6 EP functionality wasn't completely tested
> > with this config.
> > 
> > The ARTPEC-7 variant does work as EP with our local config, I'll try
> > to see what I can do to correct ARTPEC-6 using the setup for ARTPEC-7,
> > and test your patchset on the ARTPEC-7.
> 
> Where are we at with this?

My recommendation would be to:
1) Get artpec6 EP mode working with v6.14-rc7
2) Try v6.14-rc7 + v12 of Frank's series
3) Try v6.14-rc7 + v12 of Frank's series + this series


> 
> First priority: I plan to merge v12 of Frank's series [1] for v6.15.
> I hope this works with existing DTs on artpec6, both for RC and EP.
> If not, we need to figure it out ASAP.
> 
> Second priority: For this series of:
> 
>   ARM: dts: artpec6: Move PCIe nodes under bus@c0000000
>   PCI: artpec6: Use use_parent_dt_ranges and clean up artpec6_pcie_cpu_addr_fixup()
> 
> it looks like there's an open issue with the dts patch that Rob
> noticed [2].  It would be great if we could fix that issue and get it
> queued up if it's safe to merge independently of Frank's v12 series.

Rob's bot is simply complaining that there is no DT schema.

This is because the DT schema for axis,artpec6-pcie has not been
converted to YAML.

It would be nice to convert it, but I don't think it should stop
other improvements for this driver.


> It looks like the artpec6_pcie_cpu_addr_fixup() removal probably needs
> to be delayed until we know all DTs in the field are fixed?  This
> might mean that we can *never* remove artpec6_pcie_cpu_addr_fixup()
> unless we can identify and work around the broken DTs in the kernel.

Jesper should be able to answer this, but as far as I know, artpec6 is only
used in-house, so they have full control of the DTBs.

(i.e. artpec6_pcie_cpu_addr_fixup() can probably be killed quite quickly,
once "v6.14-rc7 + v12 of Frank's series + this series" gets working.)


Kind regards,
Niklas

