Return-Path: <linux-pci+bounces-44086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5254DCF7862
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 10:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 525E030DFBD0
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 09:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7A030FC00;
	Tue,  6 Jan 2026 09:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnrEQDQt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1392857C1;
	Tue,  6 Jan 2026 09:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767690981; cv=none; b=EokvZeVQx4xXoDKMT5kcRXN9waV4R8J2ouNsUXGQOVnPrX/XTE5srjmdDeR/WFm/DbgLi9U1sgIO5l6C35THHT/ToNt+VgJIJsDe/dq+7c72Rebpu7zcmhoOwpeaBGT1kScq+fN2MBmSJfonTBPhMlzqZzgGJQfZ40crv/jSbVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767690981; c=relaxed/simple;
	bh=cynLGl5RlxS7Xu40g+HTevna25fZXxq+QHg/HSuAPM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yl3ubDRSEQrE/BRqK5ijSu+fZ0DFi+764rznIeWJW0BSgFmnHU3kACUdhD/Pl39dYkmOM7BJ6BSAShBK2rGeGgG2CN0L9YvHHCV3hKrhDAwnGwpLUp8IiAWW6qt7JGYaBvYrszZvOfxm4kTERRa9HneqO01M094xh13j1OeliJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnrEQDQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7588C19424;
	Tue,  6 Jan 2026 09:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767690981;
	bh=cynLGl5RlxS7Xu40g+HTevna25fZXxq+QHg/HSuAPM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TnrEQDQt4e1hvZugzUohnrjFUNExJ5FxrqUffTKdvbV/TG45H99PW7NA7+kDqsvVQ
	 zeQCeq/4AE/kXXyHEMCJ0jGiCZTfbRUM4kAIIn3sL7s6DMaE2Pzen0Q6zep6SzVDHN
	 R8G2f49yuhqS9qEYLaZMQd/QPfndKnn5IK1zBj9rMMZYqSpNcrvXppE7F42kl75YwX
	 DY+F2yPMsGD1KqMNvTiwFTcVeuuxyKyp2xEDe24IFYbNmCwLM1muIhuRWSVGx64108
	 aIF98IPgDYX8Jt3GdA5mi1HBFcG+U4CKDxux86xew3Kv/YqDPTRUeJw1xZMmkOmH/C
	 e8lErTlz5zcwA==
Date: Tue, 6 Jan 2026 10:16:15 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	Frank.Li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: endpoint: BAR subrange mapping support
Message-ID: <aVzS3_Vx8hXZte1Z@fedora>
References: <20260105080214.1254325-1-den@valinux.co.jp>
 <aVvtAkEcg6Qg7K3C@ryzen>
 <gb3mr7onokhufasxaeoxiqft22incwxxlf43m6jcrhrem3477j@63oi3ztvbqku>
 <o6swnuf4aplcyd5jpgbyhslxcxuhzt4j6a4oq773eujva6ynqj@wmkorp4mavul>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <o6swnuf4aplcyd5jpgbyhslxcxuhzt4j6a4oq773eujva6ynqj@wmkorp4mavul>

On Tue, Jan 06, 2026 at 12:09:24PM +0900, Koichiro Den wrote:
> On Tue, Jan 06, 2026 at 10:52:54AM +0900, Koichiro Den wrote:
> > On Mon, Jan 05, 2026 at 05:55:30PM +0100, Niklas Cassel wrote:
> > > Hello Koichiro,
> > > 
> > > On Mon, Jan 05, 2026 at 05:02:12PM +0900, Koichiro Den wrote:
> > > > This series proposes support for mapping subranges within a PCIe endpoint
> > > > BAR and enables controllers to program inbound address translation for
> > > > those subranges.
> > > > 
> > > > The first patch introduces generic BAR subrange mapping support in the
> > > > PCI endpoint core. The second patch adds an implementation for the
> > > > DesignWare PCIe endpoint controller using Address Match Mode IB iATU.
> > > > 
> > > > This series is a spin-off from a larger RFC series posted earlier:
> > > > https://lore.kernel.org/all/20251217151609.3162665-4-den@valinux.co.jp/
> > > > 
> > > > Base:
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> > > >   branch: controller/dwc
> > > >   commit: 68ac85fb42cf ("PCI: dwc: Use cfg0_base as iMSI-RX target address
> > > >                          to support 32-bit MSI devices")
> > > > 
> > > > Thank you for reviewing,
> > > > 
> > > > Koichiro Den (2):
> > > >   PCI: endpoint: Add BAR subrange mapping support
> > > >   PCI: dwc: ep: Support BAR subrange inbound mapping via address-match
> > > >     iATU
> > > 
> > > I have nothing against this feature, but the big question here is:
> > > where is the user?
> > > 
> > > Usually, we don't add a new feature without having a single user of said
> > > feature.
> > > 
> > 
> > The first user will likely be Remote eDMA-backed NTB transport. An RFC
> > series,
> > https://lore.kernel.org/all/20251217151609.3162665-4-den@valinux.co.jp/
> > referenced in the cover letter relies on Address Match Mode support.
> > In that sense, this split series is prerequisite work, and if this gets
> > acked, I will post another patch series that utilizes this in the NTB code.
> > 
> > At least for Renesas R-Car S4, where 64-bit BAR0/BAR2 and 32-bit BAR4 are
> > available, exposing the eDMA regsister and LL regions to the host requires
> > at least two mappings (one for register and another for a contiguous LL
> > memory). Address Match Mode allows a flexible and extensible layout for the
> > required regions.
> > 
> > > 
> > > One thing that I would like to see though:
> > > stricter verification of the pci_epf_bar_submap array.
> > > 
> > > For DWC, we know that the minimum size that an iATU can map is stored in:
> > > (struct dw_pcie *pci) pci->region_align.
> > > 
> > > Thus, each element in the pci_epf_bar_submap array has to have a size that
> > > is a multiple of pci->region_align.
> > > 
> > > I don't see that you ever verify this anywhere.
> > 
> > I missed it, will add the check.
> 
> My reply above was wrong, the region_align-related validation is already
> handled in dw_pcie_prog_inbound_atu(). I don't think we need to duplicate
> the same check at (A) (see below) in dw_pcie_ep_ib_atu_addr(), and would
> prefer to keep the code simple as possible since this is not a fast path.

The region align check in dw_pcie_prog_inbound_atu() validates that the
addresses (pci_addr and parent_bus_addr) are aligned to region_align
(min iATU size).

You also need to check that the size of the region mapped is aligned to
region_align (min iATU size).


Kind regards,
Niklas

