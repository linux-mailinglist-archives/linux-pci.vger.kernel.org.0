Return-Path: <linux-pci+bounces-23973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67112A65B9A
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 18:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B23189CE51
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 17:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19CA1AF0C1;
	Mon, 17 Mar 2025 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukDa8iYB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812FD1A3A8A;
	Mon, 17 Mar 2025 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234061; cv=none; b=BzShN5JRWZXnL05dpkKHcV1jXAvKEo+/EgjoeD7oWM3PXxzKJZnGOd8RVa5qPS2gFS19y/EBvqN+R9duCFSxzqqRpG4M2O02pyCNj7e0xm+FNLoP82zAiANEpqtSOLbKd9XHxCQqTHNNPWWMWYfdiomVC04XhMWWJPqnb+rU9rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234061; c=relaxed/simple;
	bh=kX4VuRRRWx+u1lJbW0uI3jrw3LlGVRsJGxWxvXqbY9s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SO8+CCY/Lo7MDA6Yhnb4m/qUXR3XQb2KWeiGZPi89SGlmMR6B+ncNzhFSdsuPd/+l8uzYx8Y6ROZG1Wobw9kC+aNtvlyMrZe9uRGuRsOp8iP1EG1aosT9+195Xw8lKN9PuKoXHhO3Swlp57Ycg9SI/0dCgsJzjK/Q43fLCr9FIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukDa8iYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CB6C4CEE3;
	Mon, 17 Mar 2025 17:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742234061;
	bh=kX4VuRRRWx+u1lJbW0uI3jrw3LlGVRsJGxWxvXqbY9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ukDa8iYBIhP30GZ42RJLzH8fnhhlTZzUm1vruh0qbIY+q3O5i9O8Nqqd1nfbnaUgx
	 pPejfkBo1EqKO9T05Wr+aKG+QMnFRlSUF0NwUTcefjUx/JeUES3LLoNFH7c9Hgzz4N
	 Wod5yDqNs+vDpkesPoPkwar4Qzv5lOOLmNP0lcH7JnXyGV0WtaDqy8VdZJUtY4+kUN
	 WAGvECKL4Z2zJx0r9tzKK7WSYPjPiuqrpa2wRIfdYnsbUPqk6WtnEBcXGG859jFrdX
	 JhdRe6rQnZKw8tLFujTRLlvf/ZlldBPO8r/WKGKKCI3fy3W+9w45jxmqizOg13r6v1
	 H54jqE/FuffrA==
Date: Mon, 17 Mar 2025 12:54:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Frank Li <Frank.Li@nxp.com>, Lars Persson <lars.persson@axis.com>,
	Rob Herring <robh@kernel.org>,
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
Message-ID: <20250317175419.GA933527@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z88Xh75G6Wabwl2O@axis.com>

On Mon, Mar 10, 2025 at 05:47:03PM +0100, Jesper Nilsson wrote:
> Hi again Frank!
> 
> I've now tested this patch-set together with your v9 on-top of the
> next-branch of the pci tree, and seems to be working good on my
> ARTPEC-6 set as RC:
> 
> # lspci
> 00:00.0 PCI bridge: Renesas Technology Corp. Device 0024
> 01:00.0 PCI bridge: Pericom Semiconductor PI7C9X2G304 EL/SL PCIe2 3-Port/4-Lane Packet Switch (rev 05)
> 02:01.0 PCI bridge: Pericom Semiconductor PI7C9X2G304 EL/SL PCIe2 3-Port/4-Lane Packet Switch (rev 05)
> 02:02.0 PCI bridge: Pericom Semiconductor PI7C9X2G304 EL/SL PCIe2 3-Port/4-Lane Packet Switch (rev 05)
> 03:00.0 Non-Volatile memory controller: Phison Electronics Corporation E18 PCIe4 NVMe Controller (rev 01)
> 
> However, when running as EP, I found that the DT setup for pcie_ep
> wasn't correct:
> 
> diff --git a/arch/arm/boot/dts/axis/artpec6.dtsi b/arch/arm/boot/dts/axis/artpec6.dtsi
> index 399e87f72865..6d52f60d402d 100644
> --- a/arch/arm/boot/dts/axis/artpec6.dtsi
> +++ b/arch/arm/boot/dts/axis/artpec6.dtsi
> @@ -195,8 +195,8 @@ pcie: pcie@f8050000 {
>  
>                 pcie_ep: pcie_ep@f8050000 {
>                         compatible = "axis,artpec6-pcie-ep", "snps,dw-pcie";
> -                       reg = <0xf8050000 0x2000
> -                              0xf8051000 0x2000
> +                       reg = <0xf8050000 0x1000
> +                              0xf8051000 0x1000
>                                0xf8040000 0x1000
>                                0x00000000 0x20000000>;
>                         reg-names = "dbi", "dbi2", "phy", "addr_space";
> 
> Even with this fix, I get a panic in dw_pcie_read_dbi() in EP-setup,
> both with and without:
> 
> "PCI: artpec6: Use use_parent_dt_ranges and clean up artpec6_pcie_cpu_addr_fixup()"
> 
> so it looks like the ARTPEC-6 EP functionality wasn't completely tested
> with this config.
> 
> The ARTPEC-7 variant does work as EP with our local config, I'll try
> to see what I can do to correct ARTPEC-6 using the setup for ARTPEC-7,
> and test your patchset on the ARTPEC-7.

Where are we at with this?

First priority: I plan to merge v12 of Frank's series [1] for v6.15.
I hope this works with existing DTs on artpec6, both for RC and EP.
If not, we need to figure it out ASAP.

Second priority: For this series of:

  ARM: dts: artpec6: Move PCIe nodes under bus@c0000000
  PCI: artpec6: Use use_parent_dt_ranges and clean up artpec6_pcie_cpu_addr_fixup()

it looks like there's an open issue with the dts patch that Rob
noticed [2].  It would be great if we could fix that issue and get it
queued up if it's safe to merge independently of Frank's v12 series.

It looks like the artpec6_pcie_cpu_addr_fixup() removal probably needs
to be delayed until we know all DTs in the field are fixed?  This
might mean that we can *never* remove artpec6_pcie_cpu_addr_fixup()
unless we can identify and work around the broken DTs in the kernel.

[1] https://lore.kernel.org/r/20250315201548.858189-1-helgaas@kernel.org
[2] https://lore.kernel.org/r/174170613961.3566466.13045709851799071104.robh@kernel.org

> On Wed, Mar 05, 2025 at 04:33:18PM +0100, Jesper Nilsson wrote:
> > Hi Frank,
> > 
> > I'm the current maintainer of this driver. As Niklas Cassel wrote in
> > another email, artpec-7 was supposed to be upstreamed, as it is in most
> > parts identical to the artpec-6, but reality got in the way. I don't
> > think there is very much left to support it at the same level as artpec-6,
> > but give me some time to see if the best thing is to drop the artpec-7
> > support as Niklas suggested.
> > 
> > Unfortunately, I'm travelling right now and don't have access to any
> > of my boards. I'll perform some testing next week when I'm back and
> > help to clean this up.
> > 
> > Best regards,
> > 
> > /Jesper
> > 
> > 
> > On Tue, Mar 04, 2025 at 12:49:34PM -0500, Frank Li wrote:
> > > This patches basic on
> > > https://lore.kernel.org/imx/20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com/
> > > 
> > > I have not hardware to test and there are not axis,artpec7-pcie in kernel
> > > tree.
> > > 
> > > Look for driver owner, who help test this and start move forward to remove
> > > cpu_addr_fixup() work.
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > Frank Li (2):
> > >       ARM: dts: artpec6: Move PCIe nodes under bus@c0000000
> > >       PCI: artpec6: Use use_parent_dt_ranges and clean up artpec6_pcie_cpu_addr_fixup()
> > > 
> > >  arch/arm/boot/dts/axis/artpec6.dtsi       | 92 +++++++++++++++++--------------
> > >  drivers/pci/controller/dwc/pcie-artpec6.c | 20 +------
> > >  2 files changed, 52 insertions(+), 60 deletions(-)
> > > ---
> > > base-commit: 1552be4855dacca5ea39b15b1ef0b96c91dbea0d
> > > change-id: 20250304-axis-6d12970976b4
> > > 
> > > Best regards,
> > > ---
> > > Frank Li <Frank.Li@nxp.com>
> > 
> > /^JN - Jesper Nilsson
> > -- 
> >                Jesper Nilsson -- jesper.nilsson@axis.com
> 
> /^JN - Jesper Nilsson
> -- 
>                Jesper Nilsson -- jesper.nilsson@axis.com

