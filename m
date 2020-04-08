Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4314D1A2C95
	for <lists+linux-pci@lfdr.de>; Thu,  9 Apr 2020 01:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgDHXvg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Apr 2020 19:51:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbgDHXvf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Apr 2020 19:51:35 -0400
Received: from localhost (mobile-166-175-188-68.mycingular.net [166.175.188.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 050E02082F;
        Wed,  8 Apr 2020 23:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586389895;
        bh=ohD59jkDFB/7GbrNwOr+RvtEO78AppOEta0uYKkJaOk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=i243TA3iZ14gJyfzqpJx5lW6qxa0I0TWRjoCNJ1pTyAMoKpRNGO9XGXe4feq2IHKZ
         /N0BFAPMBXb2oHHt5BczVvgIHnz9by1j5vnTFnMQHgRR+xhuiQqEnffDgEQ9BBv+iT
         0IpSHFoe/PMaOm3RmcfLSyKA8M4gx9tSc9h2n7QQ=
Date:   Wed, 8 Apr 2020 18:51:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-rockchip@lists.infradead.org,
        Lad Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH v7 6/8] PCI: rcar: Add support for R-Car PCIe controller
 in endpoint mode
Message-ID: <20200408235133.GA151858@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586360280-10956-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Maybe:

  PCI: rcar: Add endpoint mode support

so the important "endpoint mode" part is early and doesn't get chopped
off or wrapped.  We already know it's PCIe and rcar-related.

On Wed, Apr 08, 2020 at 04:37:58PM +0100, Lad Prabhakar wrote:
> This patch adds support for R-Car PCIe controller to work in endpoint mode.

s/This patch adds/Add/

> +static int rcar_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no,
> +				struct pci_epf_bar *epf_bar)
> +{
> +	int flags = epf_bar->flags | LAR_ENABLE | LAM_64BIT;
> +	struct rcar_pcie_endpoint *ep = epc_get_drvdata(epc);
> +	u64 size = 1ULL << fls64(epf_bar->size - 1);
> +	dma_addr_t cpu_addr = epf_bar->phys_addr;
> +	enum pci_barno bar = epf_bar->barno;
> +	struct rcar_pcie *pcie = &ep->pcie;
> +	u32 mask;
> +	int idx;
> +	int err;
> +
> +	idx = find_first_zero_bit(ep->ib_window_map, ep->num_ib_windows);
> +	if (idx >= ep->num_ib_windows) {
> +		dev_err(pcie->dev, "no free inbound window\n");
> +		return -EINVAL;
> +	}
> +
> +	if ((flags & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_IO)
> +		flags |= IO_SPACE;
> +
> +	ep->bar_to_atu[bar] = idx;
> +	/* use 64 bit bars */

s/64 bit bars/64-bit BARs/

> +static const struct pci_epc_features rcar_pcie_epc_features = {
> +	.linkup_notifier = false,
> +	.msi_capable = true,
> +	.msix_capable = false,
> +	/* use 64-bit bars so mark bar1/3/5 as reserved */

s/bar/BAR/g
