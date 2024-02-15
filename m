Return-Path: <linux-pci+bounces-3530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BFF8568B1
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 17:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1890290E97
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 16:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21481133993;
	Thu, 15 Feb 2024 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaUOWjhk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AFC1350F6;
	Thu, 15 Feb 2024 16:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708012920; cv=none; b=MJ8MU6M0n5Wxlmt6UUvUTABPvgCi/F1Bcp3OOFYlgvPniA4zBPJwNqEnJDcW6XWnGdsQM7KJL+vh3myyLonowEB4PpxReRXwY7/BIFDRxrKPW7W++uLe7Xnv3R4cJGzOyuQIe1yvMZyAP+7apuLFhOH09caz3ZvNRMhD36Da65o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708012920; c=relaxed/simple;
	bh=pWw8ohlMdJOBYl5mwsS+UEZnUOAY6rOv2BrZBdYFroE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=USUcjXD+WiDPJzbUNOzxK45vLe0Y7YhW/Kbf71ZrX6tu9j9x6GLtrJsj45z2suFZxT4rr+HEL7/eThEyVJa+1+SfBLxKZc+Vwv7k9dE4Vg6cp2K4kxuwVbPnM4/Go6V5ZKo2nqpOAd476wibCQ95Ls/4hQM3hDE4iB417CjS3Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaUOWjhk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DF5C433C7;
	Thu, 15 Feb 2024 16:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708012919;
	bh=pWw8ohlMdJOBYl5mwsS+UEZnUOAY6rOv2BrZBdYFroE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TaUOWjhkb5mM0/BsHOScRRcw1Loz1te9kYIoI82lkP56F49Uzy9oG+HgmRR2cD0S0
	 jYP3vTctJ84N23BibErGY4gMhi7ULXq3jshaOuJdvl13WzszMz9M3spY8VwUwSG1DP
	 ATEIWlZ/hwegkwSNt3tPKxboCw5MkCRORCdUtTlPr/Na6ow4v2f0fvJbJPNKLAvjwu
	 x3ouW88CaQfG/+ghH2q+QBA0mN37y77UO6x0DzXFu3kDWWKS9aiQpeIzbHjtU2raFk
	 9J19JecmfXkwoKtOcoUcqHEYV5WF4iwo9vxzepup41U18GaLxltBu//PsWHna/zubC
	 0tEepQWrESd4Q==
Date: Thu, 15 Feb 2024 10:01:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, bhelgaas@google.com,
	robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
	jonathanh@nvidia.com, Kishon Vijay Abraham I <kishon@kernel.org>,
	catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
	jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
	digetx@gmail.com, mperttunen@nvidia.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V16 13/13] PCI: tegra: Add Tegra194 PCIe support
Message-ID: <20240215160157.GA1291755@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17dadf66-055c-4796-a905-44e37b6fcfe3@nvidia.com>

On Thu, Feb 15, 2024 at 04:55:47PM +0530, Vidya Sagar wrote:
> On 15-02-2024 00:42, Bjorn Helgaas wrote:
> > Hi Vidya, question about ancient history:
> > 
> > On Tue, Aug 13, 2019 at 05:06:27PM +0530, Vidya Sagar wrote:
> > > Add support for Synopsys DesignWare core IP based PCIe host controller
> > > present in Tegra194 SoC.
> > > ...
> > > +static int tegra_pcie_dw_host_init(struct pcie_port *pp)
> > > +{
> > > +     struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > +     struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
> > > +     u32 val, tmp, offset, speed;
> > > +
> > > +     tegra_pcie_prepare_host(pp);
> > > +
> > > +     if (dw_pcie_wait_for_link(pci)) {
> > > +             /*
> > > +              * There are some endpoints which can't get the link up if
> > > +              * root port has Data Link Feature (DLF) enabled.
> > > +              * Refer Spec rev 4.0 ver 1.0 sec 3.4.2 & 7.7.4 for more info
> > > +              * on Scaled Flow Control and DLF.
> > > +              * So, need to confirm that is indeed the case here and attempt
> > > +              * link up once again with DLF disabled.
> >
> > This comment suggests that there's an issue with *Endpoints*, not an
> > issue with the Root Port.  If so, it seems like this problem could
> > occur with all Root Ports, not just Tegra194.  Do you remember any
> > details about this?
> > 
> > I don't remember hearing about any similar issues, and this driver is
> > the only place PCI_EXT_CAP_ID_DLF is referenced, so maybe it is
> > actually something related to Tegra194?
>
> We noticed PCIe link-up issues with some endpoints. link-up at the physical
> layer level but NOT at the Data link layer level precisely. We further
> figured out that it is the DLFE DLLPs that the root port sends during the
> link up process which are causing the endpoints get confused and preventing
> them from sending the InitFC DLLPs leading to the link not being up at
> Data Link Layer level.

Do you happen to remember any of the endpoints that have issues?

Could save some painful debugging if we trip over this issue on other
systems.  We have seen a few cases where links wouldn't train at full
speed unless they trained at a lower speed first, e.g.,
imx6_pcie_start_link(), fu740_pcie_start_link().  I guess there are
probably lots of edge cases that can cause link failures.

Bjorn

