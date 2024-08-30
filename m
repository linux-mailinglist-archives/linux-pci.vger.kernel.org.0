Return-Path: <linux-pci+bounces-12526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9F39666A3
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 18:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57C7B1C2113F
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 16:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC2F26ADD;
	Fri, 30 Aug 2024 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1othAMB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B3B2905
	for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725034558; cv=none; b=pBbQArVoP7wg/yFZOK0YlhPfZXj/oXZXlLS9VDZ5TnCaVLbIMOkY19O1iekDDkydIhQB2X+d+OWb2+sC7I/5uOf3HXEwpWw2YkyupMkEtPQWYODMk+nMJOyeI2RN3DsYWwXB3CLiPSIpxjN5oRh2Jx9Cc4uauZo7j4hbcKAjraQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725034558; c=relaxed/simple;
	bh=loNlOzoAkPrJyTb17bMFr1bf4icTTs6R8vjO5ABHNpU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ErWB2x0lWkokt3aAyCCPA5/Q+s5LlDRBub4/At0j21Zv3u+jgmeMtO4b54G/HfLaTkCwKsT4Yi3wenObQyudohetXC9Hs//KT4ZUGbJwobZ2cAXoAH5c5FvuThGSAmkDF/lXEoinpndeIMIeHuzEafWwcovmhrVm5axA4ImB+Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1othAMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD2BC4CEC5;
	Fri, 30 Aug 2024 16:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725034557;
	bh=loNlOzoAkPrJyTb17bMFr1bf4icTTs6R8vjO5ABHNpU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=U1othAMB0O1cA5q261tdqzIzI8BV+whKIHZtQx2pBmhm5xpvgxyevoecAYR99WYOB
	 LLzZgAHUHFyHAf2TySpO84X3ruat6sZQAchDet8aYzq6W2hGxp9yUNFP0Xcx4J2Lqm
	 Tu/vA/hWwX+ZT7nleLxSCwiY0v/pFCS6VihnMxfUSsZ58Dv5IrAK65vLqTHRKOYqBk
	 v3xncmQWI0zBLHsRrnjzFVOqc1PuuXMA361cxmz7XMi9S9dQFSboCqxbL4wMhExUcc
	 dcI7Vr/eHRtX8b0OIDM67v3W1s4Q2pW7C13cyVo/mMCuZFwhECwPazcXOtRv5+n+Km
	 zv8+2VZ+UyblQ==
Date: Fri, 30 Aug 2024 11:15:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>, linux-pci@vger.kernel.org
Subject: Re: legacy PCI device behind a bridge not getting a valid IRQ on imx
 host controller
Message-ID: <20240830161555.GA104439@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtHqExOsk2/tl69w@lizhi-Precision-Tower-5810>

On Fri, Aug 30, 2024 at 11:49:39AM -0400, Frank Li wrote:
> On Thu, Aug 29, 2024 at 05:00:05PM -0500, Bjorn Helgaas wrote:
> > On Thu, Aug 29, 2024 at 05:43:42PM -0400, Frank Li wrote:
> > > On Thu, Aug 29, 2024 at 04:22:35PM -0500, Bjorn Helgaas wrote:
> > > > On Wed, Aug 28, 2024 at 02:40:33PM -0700, Tim Harvey wrote:
> > > > > Greetings,
> > > > >
> > > > > I have a user that is using an IMX8MM SoC (dwc controller) with a
> > > > > miniPCIe card that has a PEX8112 PCI-to-PCIe bridge to a legacy PCI
> > > > > device and the device is not getting a valid interrupt.
> > > >
> > > > Does pci-imx6.c support INTx at all?
> > >
> > > Yes, dwc controller map INTx message to 4 irq lines, which connect to GIC.
> > > we tested it by add nomsi in kernel command line.
> >
> > Thanks, Frank.  Can you point me to the dwc code where this happens?
> > Maybe I can remember this for next time or add a comment to help
> > people find it.
> 
> I think it needn't special code to handle this. in dts
> 
>  interrupt-map = <0 0 0 1 &gic GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
>                  <0 0 0 2 &gic GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
>                  <0 0 0 3 &gic GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
>                  <0 0 0 4 &gic GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
> 
> It map INT(A,B,C,D) to 4 GIC irq.

OK, thanks!  I guess this happens in the of_irq_parse_pci() path, e.g.:

  imx6_pcie_probe
    dw_pcie_host_init
      devm_pci_alloc_host_bridge
        devm_of_pci_bridge_init
          bridge->map_irq = of_irq_parse_and_map_pci

  pci_device_probe                    # pci_bus_type.probe
    pci_assign_irq
      bridge->map_irq()
        of_irq_parse_and_map_pci
          of_irq_parse_pci
            of_irq_parse_one
              of_irq_parse_raw
                of_get_property(ipar, "interrupt-map", &imaplen)

So there really isn't any mention of INTx directly in imx6 or the dwc
core.

I suppose something like:

  - Set CONFIG_DYNAMIC_DEBUG=y

  - Boot with kernel parameters:

      ignore_loglevel dyndbg="file drivers/pci/* +p; file drivers/of/* +p"

should enable some debug output related to this.

Bjorn

