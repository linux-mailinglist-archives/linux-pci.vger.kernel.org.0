Return-Path: <linux-pci+bounces-20526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B78A21ACD
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 11:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9351888C87
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 10:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBFC1A9B40;
	Wed, 29 Jan 2025 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaQKGXun"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC7D16C854;
	Wed, 29 Jan 2025 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738145629; cv=none; b=jUpBUmzoE+E9T3/ZK3fuMT9OfZItHRbasjzT8lR1nPuV/plj8G651LlgOYA9zGc4OxAVbHhwHpLGtqKX6/AOFTJL4Tv9MnZya0IqsQyGfV9E09fkp/8oS9As06jvZ9oq9pZ7aFDeDJl69AY8dS9cPuDF0lijdXKQSE+gSOQokMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738145629; c=relaxed/simple;
	bh=h+J5mA+WmvhsE8mIU9p7eCMpAO/Myt/o9nAE8zizNZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOESfpW9ezTfSkOhCOix7vBDjnQDbkYNjTlswhu/NYAbVfvTixNLCgFS3a7d6odXj6bAuz6AWaZkRN97fmem/HLAFWZRKYDDGxDHm9lOX8CwjvBXIwob/exsN8YhoBWFuqybe742tMozQVKB9qCZc0q0QJCmtk9L3ZFIQRa1R1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaQKGXun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D92FC4CEE4;
	Wed, 29 Jan 2025 10:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738145629;
	bh=h+J5mA+WmvhsE8mIU9p7eCMpAO/Myt/o9nAE8zizNZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OaQKGXuncS+9M95nztFSZNUpOV/3xkX1UIn8ndUKBemW5eEaO9TD1i0DV60imXHOv
	 /RD5qK8IbnevUYj2u2/clYCmOF20OBp8XC57IjvKh6nCMqMIRlPBEaSSwKcMQV3ld4
	 +yeEwdtCsJ/zWz3naxUTsCivcDuAFXJ6bcgg5Z2+aiXH/eguM2bl9tiwiQNuFpvPOl
	 dO4kBbiljuDVaak1TvmjTwsZmALIu4yRpGMaWhFqK1o497PpG+O654aT3oRGduWm4v
	 UGJyOScDxBfu/lW67/i8zfOOK3NUfqGIbrJVgo7bDGH7kSxgzmXTR7FFZ5GHDu8Fic
	 oP6HHKeTWuaCQ==
Date: Wed, 29 Jan 2025 11:13:42 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v9 0/7] PCI: dwc: opitimaze RC Host/EP pci_fixup_addr()
Message-ID: <Z5n_VrN8HUmdVPUq@ryzen>
References: <20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com>

Hello Frank,

Typo in subject:
s/opitimaze/optimize/


On Tue, Jan 28, 2025 at 05:07:33PM -0500, Frank Li wrote:
> 
> Bjorn's comments in https://lore.kernel.org/imx/20250123190900.GA650360@bhelgaas/
> 
> > After all cpu_address_fixup() removed, we can remove use_parent_dt_ranges
> > in one clean up patches.
> >
> >
>   ...
> >  dw_pcie_rd_other_conf
> >  dw_pcie_wr_other_conf
> >    dw_pcie_prog_outbound_atu() only called if pp->cfg0_io_shared,
> >    after an ECAM map via dw_pcie_other_conf_map_bus() and subsequent
> >    successful access; atu.cpu_addr came from pp->io_base, set by
> >    dw_pcie_host_init() from pci_pio_to_address(), which I'm pretty
> >    sure returns a CPU address.
> 
> io_base is parent_bus_address
> 
> >    So this still looks wrong to me.  In addition, I think doing the
> >    ATU setup in *_map() and restore in *rd/wr_other_conf() is ugly
> >    and looks unreliable.
> 
> ....
> 
> >  dw_pcie_pme_turn_off
> >    atu.cpu_addr came from pp.msg_res, set by
> >    dw_pcie_host_request_msg_tlp_res() to a CPU address at the end of
> >    the first MMIO bridge window.  This one also looks wrong to me.
> 
> Fixed at this version.


I feel like it would have been easier if you replied to Bjorn's comments
directly in the thread instead of pasting them here (to a cover letter).


Please don't shoot the messenger, but I don't see any reply to (what I
assume is the biggest reason why Bjorn did not merge this series):

""
.cpu_addr_fixup() is a generic problem that affects dwc (dra7xx, imx6,
artpec6, intel-gw, visconti), cadence (cadence-plat), and now
apparently microchip.

I deferred these because I'm hoping we can come up with a more generic
solution that's easier to apply across all these cases.  I don't
really want to merge something that immediately needs to be reworked
for other drivers.
""

It should probably state in the cover letter how v9 addresses Bjorn's
concern when it comes to other PCI controller drivers, especially those
that are not DWC based.


Kind regards,
Niklas

