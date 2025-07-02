Return-Path: <linux-pci+bounces-31319-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C11AF6560
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 00:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1819524F79
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 22:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADB624EA81;
	Wed,  2 Jul 2025 22:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgwxpzHf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334CE24E019;
	Wed,  2 Jul 2025 22:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751495923; cv=none; b=H/MTuWFa9OgzBjKR/9p8Qp4an2eoid7JM5zT5YmYlcJ0PkcPkm17d0oQGkGdazc53lJTYI+T7kCVf37rQk1BdIASfxurY9RmE1GMM4ZCuhV3x6vXsG4TueU5Z+xyhqdpiP5llWfYrjNAzPCbJViJTyGoR4fbdu+jF/Ss4VYKRl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751495923; c=relaxed/simple;
	bh=yx2d4aBTclOwNRGeNrTRxErm2vCDz/EIKwKSz/rcBto=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VH4wjJrwbM5/kGlzV+bDdQJfBmUw2tsTW7OT+Z7dRqn9oRuOZ0c28eDEbtADYeMjpzYAxFa0maVAxyXY3/CZV/4E6WCR9UgXstKNMrm3BettArIt4ZDGp0nP520SXvw5URZXlQtoehm0omuLEH5Ngam4Y54yT/OqwBUyHhFtgwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgwxpzHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0B8C4CEE7;
	Wed,  2 Jul 2025 22:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751495922;
	bh=yx2d4aBTclOwNRGeNrTRxErm2vCDz/EIKwKSz/rcBto=;
	h=Date:From:To:Cc:Subject:From;
	b=EgwxpzHftC91wGvTOUVDQ72sFVPldAp9or/WyfxdZVzw+9VE6dWs7k762NdyCLJbF
	 CzRQr2n5g/85+CJi7BEFI4fNqt4IbtdKFJEdwpHMAezu3qD/9zlRZVqQl2geMCs6D1
	 YP5evZWmCSrChx/jeoaprYGx/3OWuaqTs3EekcaPobdoiYQYnLzx9CDzydUVrRPaZN
	 y08O3GQMyycQZ3GRfGkeMikNRs2fh2DcmVeNlWIMO2uGj6Ovg2rnwmnxvLSrRxgV/T
	 op54cZlKrP8cLuWwuy4P2V1Ejp+XIY62X9357OWNN34fOVsk8b5igNbMSyA4+u9APU
	 X9ylIcu2dv8cQ==
Date: Wed, 2 Jul 2025 17:38:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
	Roy Zang <roy.zang@nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Rob Herring <robh+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Does dwc/pci-layerscape.c support AER?
Message-ID: <20250702223841.GA1905230@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I see "aer" mentioned in layerscape DT 'interrupt-names':

  $ git grep "interrupt-names.*aer" Documentation/devicetree/bindings/pci/ arch
  Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml: interrupt-names = "aer";
  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi: interrupt-names = "pme", "aer";
  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi: interrupt-names = "pme", "aer";
  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi: interrupt-names = "pme", "aer";
  ...

But I don't know whether or how these are connected to the AER driver
(drivers/pci/pcie/aer.c).

Does the AER driver actually work on these platforms?

Is there some magic that connects the 'interrupt-names'/'interrupts'
DT properties to the pcie_device.irq that aer_probe() requests and
hooks up with the aer_irq() handler?

The pcie_device.irq for AER was assigned by portdrv in this path:

  pcie_portdrv_probe
    pcie_port_device_register(pci_dev *dev)
      int irqs[PCIE_PORT_DEVICE_MAXSERVICES]
      pcie_init_service_irqs(dev, irqs, ...)
        # try MSI/MSI-X first:
        pcie_port_enable_irq_vec(dev, irqs, ...)
          pci_alloc_irq_vectors(PCI_IRQ_MSIX | PCI_IRQ_MSI)
          pcie_message_numbers(dev, mask, &pme, &aer, &dpc)
          irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pci_irq_vector(dev, aer)
        # fall back to INTx if no MSI/MSI-X
        pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_INTX);
      for (i = 0; ...; i++)
        pcie_device_init(pdev, irqs[i])
          pcie = kzalloc()            # struct pcie_device
          pcie->irq = irq             # <-- pcie_device.irq

but I only see attempts to use MSI/MSI-X/INTx, which we discover and
configure based on the MSI or MSI-X Capability or the INTx pin
advertised at PCI_INTERRUPT_PIN.

I don't see anything related to DT or platform IRQs that I can connect
with the DT 'interrupts' property.

Bjorn

