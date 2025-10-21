Return-Path: <linux-pci+bounces-38931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D849EBF7E7C
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 19:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945401885A61
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 17:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6944134B66B;
	Tue, 21 Oct 2025 17:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WPk/ggQi"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2787A229B38
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 17:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067817; cv=none; b=tnyDQpRtwtsjTQjsp6o9WfoG4ovTQlQZ6PyJt3k0bfBA0GElz/pq6TM5W4rVbV4cFT0tOxfg1aaIkQtwbe2oXjngOTEiP/ajse1dBuxfby+b8IN9dMSUKzyXoIe/ewgOcfl2JOk6DV1ENFUZLEdJ75FHLceZ5lcdedUAVpNrWZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067817; c=relaxed/simple;
	bh=Cx3wXl8Sbh3saUIZvSNdo2sAZJhVpMyZYIBZ+E7bFeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STQ+NiRyhPdLMMqz2SQD8LCr1KYracBn6gwi79Iwyga3geMJRM2EZiNtB30suMkkyw0JvrAblbNpF1ECSQ3oTeOMIsIhZGeT3ysS6doFp3/6HVSXvvz6HEjW78LdPyMPD3DUZeQf1jLKTP6wzmX4UEymqI7tDC1npc+CM3MOl4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WPk/ggQi; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3191d3b5-2319-4cd4-b5b0-8fb6413e2c73@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761067811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=daSNURvAZs6Hw2eLkKXlbvLSCGcIPcuoh7yB+EjKrCU=;
	b=WPk/ggQiTnx0y6wt66fusC9AGhgfxsAYeQe9JpccAvJh5FpzTgaCa5f0imbUq5PeNR8m6h
	orM7O+5n2VRjSFdqusz5XKm86vZ4R/WrtZJvmx9UiHp0o+eEkFl0g+mMCHSiV7mg90HvTf
	yxA2KEY15w1Gv1tzJ+FyU/e6lBw+7KM=
Date: Tue, 21 Oct 2025 13:30:07 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] PCI: pcie-xilinx-dma-pl: Fix off-by-one INTx IRQ
 handling
To: Stefan Roese <stefan.roese@mailbox.org>, linux-pci@vger.kernel.org
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Ravi Kumar Bandi <ravib@amazon.com>,
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
 Michal Simek <michal.simek@amd.com>, Bjorn Helgaas <bhelgaas@google.com>
References: <20251021154322.973640-1-stefan.roese@mailbox.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20251021154322.973640-1-stefan.roese@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/21/25 11:43, Stefan Roese wrote:
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
> 
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

Reviewed-by: Sean Anderson <sean.anderson@linux.dev>

