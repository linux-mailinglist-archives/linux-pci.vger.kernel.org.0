Return-Path: <linux-pci+bounces-43517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1289CD5C55
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 12:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 567FB3021E4E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 11:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D6E31618F;
	Mon, 22 Dec 2025 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYuj5z8S"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2C431618C
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766401872; cv=none; b=dunr8vGNVxTbkBPGxqYwdBXeYbrW2CDFse/eJOxn5H0QMPY+8sApIfLp9xnBUj3+0aUSXMPlWDeZDDaNFopjzOi75L3wyt9qmkoPN6PxXDy9eDzjMNYwsm5hILqx+YFk571ZqvU5owCRLONU1K8mQh4bT9lbN1kiacFDLFhDVtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766401872; c=relaxed/simple;
	bh=5fv/I6MGfBzu3znoiY7BzU5L2/Tel/UzNWX3R39xDl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7l5xjh4tGFvFqZmOVbFaOhZS1eJPrVxlHoPOXsePp1hrSf+OD119UNyewp5/WsHXjSDx3CMKCa72hN0s7OqquCiGo7m6YDPZgLCTw0pBnHmPImbb6EFPnGIcFCeyWi+i+knhcmv5q4j5r/agagxnZTGD9cLyyrAVkBrNiWF1gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYuj5z8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7B8C116C6;
	Mon, 22 Dec 2025 11:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766401872;
	bh=5fv/I6MGfBzu3znoiY7BzU5L2/Tel/UzNWX3R39xDl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rYuj5z8SvmrYrwiRTKBdi8Tq8haqLVXf5/C3Tsfvxzmk3FeNWutSzF4rCp8N74mQY
	 4jp7aGXClKPT7qprKpD31d0oN3HBg/7cP1q86FlbjNnPK6lmK7RInP5qrl29xugFZ9
	 Dr23KphZcqBW5gs8PlHRd+cFLYKRF5Gp16fYEa/nvkXwxr0Tyym45CtHODT7Lr8K2e
	 mOfUw6aHYmm6gkJYK5mpQo/g4SqDWVybeL0m6JCjKij086ayKmzsMuywjtSylPLXL2
	 bP0D7vwD3h6T/YB0neISX2Hg7ZuMCiidhD9vUNJUYUOcNxYisf5uxDagdsOt8K6HL7
	 DwSom64YjBIlg==
Date: Mon, 22 Dec 2025 12:11:07 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>, Damien Le Moal <dlemoal@kernel.org>,
	Koichiro Den <den@valinux.co.jp>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Cache MSI outbound iATU mapping
Message-ID: <aUknSzSpNxLeEN5o@ryzen>
References: <20251210071358.2267494-2-cassel@kernel.org>
 <8e00bd1c-29ae-43fd-90e8-ea0943cb02b6@oss.qualcomm.com>
 <s5mbvhnummcegksauc7kyb2442ao27dwc63gyryetuvxojnxfj@a67nopel52tx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5mbvhnummcegksauc7kyb2442ao27dwc63gyryetuvxojnxfj@a67nopel52tx>

On Mon, Dec 22, 2025 at 03:28:30PM +0530, Manivannan Sadhasivam wrote:
> 
> > Use the MSIX doorbell method which will not use iATU at all,
> > dw_pcie_ep_raise_msix_irq_doorbell().
> > 
> 
> I think this is the safe bet since this feature doesn't seem like an optional
> one.
> 
> Niklas, if you can just fix MSI in this patch and leave out MSI-X for the vendor
> drivers to transition to doorbell, I'm OK to merge it. Otherwise, I don't know
> how you can reliably fix MSI-X generation with AXI slave interface.

FWIW, I did try to simply change:

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 8f2cc1ef25e3..00770f9786e3 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -319,7 +319,8 @@ static int rockchip_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
        case PCI_IRQ_MSI:
                return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
        case PCI_IRQ_MSIX:
-               return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
+               return dw_pcie_ep_raise_msix_irq_doorbell(ep, func_no,
+                                                         interrupt_num);
        default:
                dev_err(pci->dev, "UNKNOWN IRQ type\n");
        }


For the pcie-dw-rockchip driver, but it is not working:
[  130.042849] nvme nvme0: I/O tag 0 (1000) QID 0 timeout, completion polled

Without this change, things work.

Perhaps this feature is not an optional one, but at least we will require
more changes than a simple one liner.


Kind regards,
Niklas

