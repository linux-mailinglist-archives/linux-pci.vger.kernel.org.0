Return-Path: <linux-pci+bounces-44040-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 479EECF4D5A
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 17:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B34BD300A51D
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 16:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988C93358D1;
	Mon,  5 Jan 2026 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlwskDj9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4095A306D36;
	Mon,  5 Jan 2026 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767632135; cv=none; b=goSoCUlyMN3PvC1ZmF2fWJkjtjV/oXAR28NBbU/sOdPZVfi41sWsdU/A0fl0DJlix5fecJsz3JDI7gEIPNdOJCj4Tn8tUY7OzWpO1NrN/7vH2wD4xogs18FPphsInAnOfLA/K+LpdGiapqV/Z6wg/68Uhc11u3RaA4DIXXGRo+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767632135; c=relaxed/simple;
	bh=19T6fxz6mE75PtXY5IdipsLtMHkkhxHva4HG1axddtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIk7QfVRvhD+ozOMnpfI+9PEyCJwE0qHxuOxDSmMiwI3OxTeF/K1eQEPS6r9FEISSP0yN3ZCLSKWZx1HvbPNytAjoZlmVP97uEtmxgLuQRobri4IElMfhHQZbDaiilEO7XV5lWBfyKLUsRipLCkSgCSlMqSW7rIt/4u2oJoJqJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlwskDj9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3689C116D0;
	Mon,  5 Jan 2026 16:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767632134;
	bh=19T6fxz6mE75PtXY5IdipsLtMHkkhxHva4HG1axddtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NlwskDj9hjzIsuHafM9aq1WzmLN4kjMvT4VRb+Z/k6kcXwM1oBambCnxof7ARAuYE
	 QPKvLezDovqQFzfVKZXuwODIEEaoErqH5lUJVcG6T0SupYfpwLAfnDnoxLtyQHwC6h
	 3FDjFC1Qv62r7zS3ZcUTpGsI6r3E2t2Fu5W5I6H+vy7xslXDatT2vZnXngt219Cazt
	 SJVy0qw1IzyhLOhgU+QMbYVjV7Ko4AHNEmweHkZk2v5pPDVXolm3GwZveS3O8RpN7K
	 +cvuHreQckYqqPygRrAWARDfYrwRqlF1otRtbSBI3xGJYhqi4DwbH7igYyeYdJEczk
	 kfeQ0hZmED2Ww==
Date: Mon, 5 Jan 2026 17:55:30 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	Frank.Li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: endpoint: BAR subrange mapping support
Message-ID: <aVvtAkEcg6Qg7K3C@ryzen>
References: <20260105080214.1254325-1-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105080214.1254325-1-den@valinux.co.jp>

Hello Koichiro,

On Mon, Jan 05, 2026 at 05:02:12PM +0900, Koichiro Den wrote:
> This series proposes support for mapping subranges within a PCIe endpoint
> BAR and enables controllers to program inbound address translation for
> those subranges.
> 
> The first patch introduces generic BAR subrange mapping support in the
> PCI endpoint core. The second patch adds an implementation for the
> DesignWare PCIe endpoint controller using Address Match Mode IB iATU.
> 
> This series is a spin-off from a larger RFC series posted earlier:
> https://lore.kernel.org/all/20251217151609.3162665-4-den@valinux.co.jp/
> 
> Base:
>   git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
>   branch: controller/dwc
>   commit: 68ac85fb42cf ("PCI: dwc: Use cfg0_base as iMSI-RX target address
>                          to support 32-bit MSI devices")
> 
> Thank you for reviewing,
> 
> Koichiro Den (2):
>   PCI: endpoint: Add BAR subrange mapping support
>   PCI: dwc: ep: Support BAR subrange inbound mapping via address-match
>     iATU

I have nothing against this feature, but the big question here is:
where is the user?

Usually, we don't add a new feature without having a single user of said
feature.


One thing that I would like to see though:
stricter verification of the pci_epf_bar_submap array.

For DWC, we know that the minimum size that an iATU can map is stored in:
(struct dw_pcie *pci) pci->region_align.

Thus, each element in the pci_epf_bar_submap array has to have a size that
is a multiple of pci->region_align.

I don't see that you ever verify this anywhere.

You should also verify that the sum of all the sizes in the pci_epf_bar_submap
array adds up to exactly pci_epf_bar->size.


Also, we currently have code in dw_pcie_prog_inbound_atu() that verifies
that the physical memory address is aligned to the size of the BAR, as that
is a requirement in BAR match mode, see:
129f6af747b2 ("PCI: dwc: ep: Add 'address' alignment to 'size' check in dw_pcie_prog_ep_inbound_atu()")

This is not a requirement in address match mode, so you probably don't
want to do that check in address match mode.
(You will want to keep the check that the physical memory address is
aligned to pci->region_align though.)


Kind regards,
Niklas

