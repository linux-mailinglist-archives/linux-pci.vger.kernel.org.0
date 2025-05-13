Return-Path: <linux-pci+bounces-27652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E74C1AB5B38
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 19:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878A6188A6E7
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 17:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD49F28F514;
	Tue, 13 May 2025 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxmIkhrr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852651E51E1;
	Tue, 13 May 2025 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747157310; cv=none; b=WRU8dypOF8ZZu4Wf2NMcy9h/dcRlG9a3uxKsZE+uBPfRW3ssB2rERfBmNoVllaCv+QNRAzC/g+ux+GQbRNalwpDGXyJ0Wwl7Nqf3p+W8lGgYyeg/mYzTpOSmDrUHYImGYc5qFr5VaadUa0Ajp7ep6zpZj/hYwT725lVNSV/9RD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747157310; c=relaxed/simple;
	bh=hzuO87JdBmymswNxonEC6nbrBc0MKykTjXnKUUy51wU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jVCKoKOgigoSWtS3+gwwAQjBYtSjuC5cYqmenAIF0vJ+9uxz7Py/djrthxlZa/aPaELgUV0nMxw1heLaXNCzxx7DmlcU5y37tUxCVrLgAAZiO+VcQ8Cpr2V43U1akKZ/P4x19GyFb8fLA1PmWUrm88KHe6fiLS26yoJeEn1WmbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxmIkhrr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CF0C4CEE4;
	Tue, 13 May 2025 17:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747157310;
	bh=hzuO87JdBmymswNxonEC6nbrBc0MKykTjXnKUUy51wU=;
	h=From:To:Cc:Subject:Date:From;
	b=CxmIkhrrzIanydOQkOVr339gNDRjirbo0ae6JNHeShS3ieQNlEiqBfbr+dCu3tdGb
	 35Y5GX9j0yq1T1OUblyUVXZ1X7EOeUGMnpnZ4nEGZ5yp255OqRDivX32045jI/pV8p
	 ub/0fqDM1MWYYSF7+PfzuPGqxhXlNWkCm3a3XAxzJzlYEUfH9aFnXtWakaVg6r+K5O
	 d3llmzL43BJsPNNvujxMlVHXwLK/HvlLGUMCMmbR2beSb7VtkhJ7Z6ELSzAZxyp3pS
	 pBVNxUDZNfTRdSxm3LGg7k904c1w2FeuPpcjEGsxDWxiaJx6ulSEX7P5Oz1QRv7X+c
	 wdo6CbXjDQxOw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uEtQZ-00EbRz-Qu;
	Tue, 13 May 2025 18:28:27 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Toan Le <toan@os.amperecomputing.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH v2 0/9] irqchip: MSI parent cleanup and PCI host driver conversion
Date: Tue, 13 May 2025 18:28:10 +0100
Message-Id: <20250513172819.2216709-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, tglx@linutronix.de, andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, bhelgaas@google.com, toan@os.amperecomputing.com, alyssa@rosenzweig.io, thierry.reding@gmail.com, jonathanh@nvidia.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

This is v2 of a series I posted[1] a few months back before running
out of time, energy, and interest. I have now reduced it to the stuff
I actually care about, and got rid of all things non-arm64.

I've become annoyed by the couple of machines I have around that
haven't been converted to the per-device MSI infrastructure.  At the
same time, I've also moaned at the amount of boilerplate code required
to make use of this infrastructure.

This series therefore does a number of things:

- make irq-msi-lib.h globally available, so that PCI (and other
  subsystems) may make use of it

- add a new helper (msi_create_parent_irq_domain()) that encapsulates
  most of the magic required to create an MSI-parent domain

- convert the arm64 I have access to (and *only* that)

- convert the Apple, XGene and Tegra MSI drivers to the MSI-parent
  infrastructure, which is why I came here the first place.

* From v1 [1]:

  - use irq_domain_info as an the holder of most information required
    to instantiate the domain. I decided against using a specific
    structure, because they would mostly have the same fields.

  - added a patch to convert the Tegra driver, which required dealing
    with the MSI_FLAG_NO_AFFINITY flag

  - got rid of x86 and riscv patches (life is too short).

[1] https://lore.kernel.org/all/20241204124549.607054-1-maz@kernel.org

Marc Zyngier (9):
  irqchip: Make irq-msi-lib.h globally available
  genirq/msi: Add helper for creating MSI-parent irq domains
  irqchip/gic: Convert to msi_create_parent_irq_domain() helper
  irqchip/mvebu: Convert to msi_create_parent_irq_domain() helper
  irqchip: Drop MSI_CHIP_FLAG_SET_ACK from unsuspecting MSI drivers
  irqchip/msi-lib: Honour the MSI_FLAG_NO_AFFINITY flag
  PCI: apple: Convert to MSI parent infrastructure
  PCI: xgene: Convert to MSI parent infrastructure
  PCI: tegra: Convert to MSI parent infrastructure

 drivers/irqchip/irq-bcm2712-mip.c             |  2 +-
 drivers/irqchip/irq-gic-v2m.c                 | 16 ++---
 drivers/irqchip/irq-gic-v3-its-msi-parent.c   |  4 +-
 drivers/irqchip/irq-gic-v3-its.c              | 21 +++----
 drivers/irqchip/irq-gic-v3-mbi.c              | 15 ++---
 drivers/irqchip/irq-imx-mu-msi.c              |  2 +-
 drivers/irqchip/irq-loongarch-avec.c          |  2 +-
 drivers/irqchip/irq-loongson-pch-msi.c        |  2 +-
 drivers/irqchip/irq-msi-lib.c                 |  9 ++-
 drivers/irqchip/irq-mvebu-gicp.c              | 18 +++---
 drivers/irqchip/irq-mvebu-icu.c               |  2 +-
 drivers/irqchip/irq-mvebu-odmi.c              | 18 +++---
 drivers/irqchip/irq-mvebu-sei.c               | 18 +++---
 drivers/irqchip/irq-riscv-imsic-platform.c    |  2 +-
 drivers/irqchip/irq-sg2042-msi.c              |  2 +-
 drivers/pci/controller/Kconfig                |  3 +
 drivers/pci/controller/pci-tegra.c            | 60 ++++++------------
 drivers/pci/controller/pci-xgene-msi.c        | 46 +++++---------
 drivers/pci/controller/pcie-apple.c           | 62 +++++++------------
 .../linux}/irqchip/irq-msi-lib.h              |  6 +-
 include/linux/msi.h                           |  4 ++
 kernel/irq/msi.c                              | 26 ++++++++
 22 files changed, 160 insertions(+), 180 deletions(-)
 rename {drivers => include/linux}/irqchip/irq-msi-lib.h (84%)

-- 
2.39.2


