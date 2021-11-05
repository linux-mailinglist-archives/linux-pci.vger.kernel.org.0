Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EFB4469C0
	for <lists+linux-pci@lfdr.de>; Fri,  5 Nov 2021 21:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhKEUbz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Nov 2021 16:31:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233647AbhKEUby (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Nov 2021 16:31:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90E27611C0;
        Fri,  5 Nov 2021 20:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636144154;
        bh=v24JrlUtPh/fIqVwA0XqHebX4ahl48yzolKYIo3a7w8=;
        h=Date:From:To:Cc:Subject:From;
        b=hmXXB12pRp8nJ8CDaRLHr+/l6u5E6lgh5EvW7od/phJ5rkBkrPkX3d7+CCUFL05he
         csk4snElIBQC5dy4bqzW1ymJZIyChAuONcdSBWlY8RdszkeExGT8Abn6zrUjil+NcW
         2hv+f7aMiy4JUZ0JaINtAdYEOKbT9JwYg+JYt8jLO/5NWWA/bW5hWxyfuSMmiBGWVA
         s0GY8gfg7WReDUu4RXDDurkyL0UQTKSPiD+PgXl1oK4Fa90tI7mg4uuuAjn96N24v/
         YO0Y4YG9uvDYEHVP1MW4KOSPqrkvmaWjBuExPy/cikv+dST2viif+9qNIOqSvFHrJA
         nCyGnvXBkNYlA==
Date:   Fri, 5 Nov 2021 15:29:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Fan Fei <ffclaire1224@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Distinguish mediatek drivers
Message-ID: <20211105202913.GA944432@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We have two MediaTek drivers: pcie-mediatek.c, which claims:

  .compatible = "mediatek,mt2701-pcie"
  .compatible = "mediatek,mt7623-pcie"
  .compatible = "mediatek,mt2712-pcie"
  .compatible = "mediatek,mt7622-pcie"
  .compatible = "mediatek,mt7629-pcie"

and pcie-mediatek-gen3.c, which claims:

  .compatible = "mediatek,mt8192-pcie"

The Kconfig text does not distinguish them.  Can somebody update these
entries so they do?  It's nice if we can mention model numbers or
product names that a user would recognize.

  config PCIE_MEDIATEK
        tristate "MediaTek PCIe controller"
        depends on ARCH_MEDIATEK || COMPILE_TEST
        depends on OF
        depends on PCI_MSI_IRQ_DOMAIN
        help
          Say Y here if you want to enable PCIe controller support on
          MediaTek SoCs.

  config PCIE_MEDIATEK_GEN3
        tristate "MediaTek Gen3 PCIe controller"
        depends on ARCH_MEDIATEK || COMPILE_TEST
        depends on PCI_MSI_IRQ_DOMAIN
        help
          Adds support for PCIe Gen3 MAC controller for MediaTek SoCs.
          This PCIe controller is compatible with Gen3, Gen2 and Gen1 speed,
          and support up to 256 MSI interrupt numbers for
          multi-function devices.

          Say Y here if you want to enable Gen3 PCIe controller support on
          MediaTek SoCs.

Both drivers are also named "mtk-pcie" and use the same internal
"mtk_" prefix on structs and functions.  Not a *huge* problem, but not
really ideal either.

Bjorn
