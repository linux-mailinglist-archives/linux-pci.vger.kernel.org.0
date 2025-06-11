Return-Path: <linux-pci+bounces-29496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A09CAD60E4
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 23:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C565C3AA5B8
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 21:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B062BD5B0;
	Wed, 11 Jun 2025 21:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLuJmhWi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1281EB39
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 21:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749676498; cv=none; b=IqdvMWhEkmL35/B1engBvlJ6QJaqBKaYdN1D7spcjtsXWY5NYNYh/1s8Kh4aocHBmPX+bH0EQFJaNgubH9YwFay14BZA+2DZ56OAcn8QWtvPPUUijMooJvt2qN115G7hZINFKGaGhf7v/258zvrkB0o+f0ZYAIaUAW1wCR9gZss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749676498; c=relaxed/simple;
	bh=rzGnHBq3q590xLCbFEMjq52KGw0cqgfhq4h1W1pnXmo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NgoQ832/M1slVOCmQtbfDbyxjKjcgcfv0FVc6QLbhrQlnh2Pdqgf/WMyOdZI1HT6ezq0edpYOBq84rv7xlTunwN1/H4oicTRIEAUdV1CWfnSBnZOjnox5Iu4txMy2KhN1bJd+BVl6ntZKJvcbxjPqndfRzdLNlyKGaXSBCt673M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLuJmhWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1EF3C4CEE3;
	Wed, 11 Jun 2025 21:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749676498;
	bh=rzGnHBq3q590xLCbFEMjq52KGw0cqgfhq4h1W1pnXmo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cLuJmhWiSA+SUB9IKwBOBYkKtWD2pUR8aNEnIyJ/vV00KzrMsSYxVbGxuffGL9ivF
	 EQdHhIaV3Oa9gxz4qr17bku5aKLPEegq5EjBrBQ4/AvkyHYZHGH+iLtPxNG871pbQU
	 gULKcV0XgAEO32DRJosLowzK8zMQ/8Qk0Vl2xltfb1BAd1BrNXNkzqjjeMaIVGfiOg
	 MTrmH/ri8nbkxtdQHmrN1uKIUqQeMPrg+Urg3o8nSRchpv0wVdTSszB2Pt5JPMFomi
	 4I+FwxLJNelb/8BDzfn0gmXKKhv4kV51sUd7ywnnsqJBZWp8EAhX3CCjUShKOX61R3
	 7lmgLdZ4FYXxQ==
Date: Wed, 11 Jun 2025 16:14:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/4] PCI: dw-rockchip: Do not enumerate bus before
 endpoint devices are ready
Message-ID: <20250611211456.GA869983@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611105140.1639031-7-cassel@kernel.org>

On Wed, Jun 11, 2025 at 12:51:42PM +0200, Niklas Cassel wrote:
> Commit ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can
> detect Link Up") changed so that we no longer call dw_pcie_wait_for_link(),
> and instead enumerate the bus directly after receiving the Link Up IRQ.
> 
> This means that there is no longer any delay between link up and the bus
> getting enumerated.

Minor quibble about "no longer any delay": dw_pcie_wait_for_link()
doesn't contain any explicit delay *after* we notice the link is up,
so we didn't guarantee sufficient delay even before ec9fd499b9c6.

If the link came up before the first check, dw_pcie_wait_for_link()
didn't delay at all.  Otherwise, it delayed 90ms * N, and we have no
idea when in the 90ms period the link came up, so the post link-up
delay was effectively some random amount between 0 and 90ms.

I would propose something like:

  PCI: dw-rockchip: Wait PCIE_T_RRS_READY_MS after link-up IRQ

  Per PCIe r6.0, sec 6.6.1, software must generally wait a minimum of
  100ms (PCIE_T_RRS_READY_MS) after Link training completes before
  sending a Configuration Request.

  Prior to ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since
  we can detect Link Up"), dw-rockchip used dw_pcie_wait_for_link(),
  which waited between 0 and 90ms after the link came up before we
  enumerate the bus, and this was apparently enough for most devices.

  After ec9fd499b9c6, rockchip_pcie_rc_sys_irq_thread() started
  enumeration immediately when handling the link-up IRQ, and devices
  (e.g., Laszlo Fiat's PLEXTOR PX-256M8PeGN NVMe SSD) may not be ready
  to handle config requests yet.

  Delay PCIE_T_RRS_READY_MS after the link-up IRQ before starting
  enumeration.

> As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link speeds
> greater than 5.0 GT/s, software must wait a minimum of 100 ms after Link
> training completes before sending a Configuration Request.
> 
> Add this delay in the threaded link up IRQ handler in order to satisfy
> the requirements of the PCIe spec.
> 
> Laszlo Fiat reported (off-list) that his PLEXTOR PX-256M8PeGN NVMe SSD is
> no longer functional, and simply reverting commit ec9fd499b9c6 ("PCI:
> dw-rockchip: Don't wait for link since we can detect Link Up") makes his
> SSD functional again. Adding the 100 ms delay as required by the spec also
> makes the SSD functional again.
> 
> Cc: Laszlo Fiat <laszlo.fiat@proton.me>
> Fixes: ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can detect Link Up")

I would argue that 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip
RK356X host controller driver") is the right Fixes: commit here
because dw_pcie_wait_for_link() *never* waited the required time, and
it's quite possible that other devices don't work correctly.  The
delay was about 90ms - <time required for link training>, so could be
significantly less than 100ms.

> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 93171a392879..a941a239cbfc 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -459,6 +459,13 @@ static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
>  	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
>  		if (rockchip_pcie_link_up(pci)) {
>  			dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
> +			/*
> +			 * As per PCIe r6.0, sec 6.6.1, a Downstream Port that
> +			 * supports Link speeds greater than 5.0 GT/s, software
> +			 * must wait a minimum of 100 ms after Link training
> +			 * completes before sending a Configuration Request.
> +			 */

I think the comment at the PCIE_T_RRS_READY_MS definition should be
enough (although it might need to be updated to mention link-up).
This delay is going to be a standard piece of every driver, so it
won't require special notice.

> +			msleep(PCIE_T_RRS_READY_MS);
>  			/* Rescan the bus to enumerate endpoint devices */
>  			pci_lock_rescan_remove();
>  			pci_rescan_bus(pp->bridge->bus);
> -- 
> 2.49.0
> 

