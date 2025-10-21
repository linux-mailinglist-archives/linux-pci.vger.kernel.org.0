Return-Path: <linux-pci+bounces-38920-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D853BF7843
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 17:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F233A5FA9
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 15:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917A915A86D;
	Tue, 21 Oct 2025 15:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbOMLWdg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEC535505E
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 15:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062029; cv=none; b=J0tZEkXsgP9keJdcC9pfLTvqG6UGSjQKrQLP/m+iqTi/M6U6J0ufemygx16jSihrKjd2HYZyP8C23URaOfmAV558wWMCKFibO86OsP91Jkh90vDHWeyolWuqxqkikC69gIjc5MwGUX/LxRo8ZiiSM6Pn2tvYyi3wc8ylUqZ6ob0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062029; c=relaxed/simple;
	bh=XtiTyT0WaRZdOd9bEdHwHnMfDUvsJRo7FwjyUx9FJl8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tjd4bp/1aqNxsJD2OmtoyUdbMd1XpZsz/b5NftAOIJvGomXEI3P4e/2cKwS1wDZMkrdf7oF7mxKrkj+rUAlKpWhu/0VHo5QgAlKGB5/r2CklTyicO7AvNo0SQpOobkqzOqiE8aeaIXD6G2DY5xkiMfyWFLfNwrMsfk2Z5fSyICU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbOMLWdg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DDEC4CEF7;
	Tue, 21 Oct 2025 15:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761062028;
	bh=XtiTyT0WaRZdOd9bEdHwHnMfDUvsJRo7FwjyUx9FJl8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KbOMLWdgpASVqRklByiJ7XvGEguRHhXEonAq7wny2+MRyNLhn/zgCSqBt0Lkz0zLu
	 W1E2UgA6ZVmB82IpxxGh2SAmq7hdzo5LKDamzVvsSoIsz5/NQXVfVfPNFtOZUf2UFS
	 sVVjUVmWsQ76l2fZJlO9FSZqAlqOzb0GDOLdCL3lOGpsQOiwM+XMJLGVdcVTcYKX5j
	 k7Kho4sjHxwVL5Gnp/WFoxy3FjcMe3gIxMbqoi+X0hoxQ6tM9tFXxYLQEE3ea1Armt
	 vvl7kIhZ81cbizvHHYJMU6sEJnlzmGHv9nG0rONC9uOxGvyAFiaXPxnF6LUjkPPZ6k
	 h6E4lnSLFn6bg==
Date: Tue, 21 Oct 2025 10:53:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stefan Roese <stefan.roese@mailbox.org>
Cc: linux-pci@vger.kernel.org, Sean Anderson <sean.anderson@linux.dev>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Ravi Kumar Bandi <ravib@amazon.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] PCI: pcie-xilinx-dma-pl: Fix off-by-one INTx IRQ
 handling
Message-ID: <20251021155347.GA1191808@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021154322.973640-1-stefan.roese@mailbox.org>

On Tue, Oct 21, 2025 at 05:43:22PM +0200, Stefan Roese wrote:
> While testing with NVMe drives connected to the Versal QDMA PL PCIe RP
> on our platform I noticed that with MSI disabled (e.g. via pci=nomsi)
> the NVMe interrupts are not delivered to the host CPU resulting in
> timeouts while probing.
> 
> Debugging has shown, that the hwirq numbers passed to this device driver
> (1...4, 1=INTA etc) need to get adjusted to match the numbers in the
> controller registers bits (0...3).
> 
> This patch now adds pci_irqd_intx_xlate to the INTx IRQ domain ops,
> handling this IRQ number translation correctly.

s/pcie-xilinx-dma-pl:/xilinx-xdma:/  # in subject
s/has shown, that/has shown that/
s/This patch now adds/Add/
s/pci_irqd_intx_xlate/pci_irqd_intx_xlate()/

We'll do this when applying, no need to repost for this.

I wonder how many other drivers have this issue.
pci_irqd_intx_xlate() is used only by:

  dwc/pci-dra7xx.c
  pcie-altera.c
  pcie-xilinx-nwl.c
  pcie-xilinx.c
  pcie-xilinx-dma-pl.c   # this patch

Is there something different about these drivers that means they need
it when all the others don't?

> Signed-off-by: Stefan Roese <stefan.roese@mailbox.org>
> Cc: Sean Anderson <sean.anderson@linux.dev>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Ravi Kumar Bandi <ravib@amazon.com>
> Cc: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> ---
> v2:
> - Use pci_irqd_intx_xlate to handle this IRQ number translation as suggested
>   by Sean (thanks again)
> 
>  drivers/pci/controller/pcie-xilinx-dma-pl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/controller/pcie-xilinx-dma-pl.c
> index 84888eda990b2..80095457ec531 100644
> --- a/drivers/pci/controller/pcie-xilinx-dma-pl.c
> +++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
> @@ -370,6 +370,7 @@ static int xilinx_pl_dma_pcie_intx_map(struct irq_domain *domain,
>  /* INTx IRQ Domain operations */
>  static const struct irq_domain_ops intx_domain_ops = {
>  	.map = xilinx_pl_dma_pcie_intx_map,
> +	.xlate = pci_irqd_intx_xlate,
>  };
>  
>  static irqreturn_t xilinx_pl_dma_pcie_msi_handler_high(int irq, void *args)
> -- 
> 2.51.1
> 

