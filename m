Return-Path: <linux-pci+bounces-8799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C0C9089B7
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 12:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545DE1F23919
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 10:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DC31946D9;
	Fri, 14 Jun 2024 10:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vpd6vXKR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IeNqrQ5Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09431946C6;
	Fri, 14 Jun 2024 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360698; cv=none; b=k83h5eRO7sysfOnY21CJRQboM19kV/49Ia9+CoL9UbsBSegy8CHVZ8xWG5FQ3b4jKkg2ipS8U9VEDdxK+m6fYNwt3fRy/rfPdoIBWbcJespEfVjsfPXGluM23R85bzI465vl4+PoEvvsbvSIrN1PGTfXpxutK9zYgDgXdLoyU74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360698; c=relaxed/simple;
	bh=t628uZCXvzpn9Hqufa4fiujJW4HeynQAG1dQyADXcL8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iRYRV6QG3rfH/9tL6w7ja0XfcVBp5pnPbtEHva5T3Jf6Uy9spCBNUwG+pTXs37erQyu63BFukJiW+kETxNWTngB0imi5CRN2HJj5n0yQ0l9we1n8RUGHOr1v16RfTOFb3L3pjLo4Sw0uDMQF+tAu/BwXc48vtZTFhogKjhUkmg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vpd6vXKR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IeNqrQ5Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718360694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s68fQBK9wDRAof8qtE9wT5IeF7ndzjeOnCTcx/kbRBY=;
	b=vpd6vXKRYzyMpH2oIOn2ZauUgMX9iIkVyn1hWyX3NcqRw55ndZmWtjPMlQDdTP8h9voA8L
	tql8/pvSRNDu4EPn+vjM0FUL798JkR49SRuMML3x247e0mbuQRSrZMNCnJAXnE5mnj2fDq
	knlK+grsEGTLPGABg2CTiI3+vD0/LRrXe7+tGsGKkxhV8YGyvajrpbvJ4MjxhCUu2MlxLQ
	pSCZ4KKTE5wniPxOkmYyci6KaULaN1LLOsnITi/WauO4Rxg5bmyDtIhX2NMAYr8AGBGQsV
	a0tHAhx2DzuP8vUqiEjQFFlO5fzEuARoBsuRRyCba6l2DUWKzfYpZvAaTc9jvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718360694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s68fQBK9wDRAof8qtE9wT5IeF7ndzjeOnCTcx/kbRBY=;
	b=IeNqrQ5ZiBomMAD30p0W7cP6G9MU7dX0v9mgEqLINn5kMM3SOoz/l0LTviGJQpjvM6f2ml
	c7XQbH/I3M/B+5Dw==
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	maz@kernel.org,
	tglx@linutronix.de,
	anna-maria@linutronix.de,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	bhelgaas@google.com,
	rdunlap@infradead.org,
	vidyas@nvidia.com,
	ilpo.jarvinen@linux.intel.com,
	apatel@ventanamicro.com,
	kevin.tian@intel.com,
	nipun.gupta@amd.com,
	den@valinux.co.jp,
	andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	alex.williamson@redhat.com,
	will@kernel.org,
	lorenzo.pieralisi@arm.com,
	jgg@mellanox.com,
	ammarfaizi2@gnuweeb.org,
	robin.murphy@arm.com,
	lpieralisi@kernel.org,
	nm@ti.com,
	kristo@kernel.org,
	vkoul@kernel.org,
	okaya@kernel.org,
	agross@kernel.org,
	andersson@kernel.org,
	mark.rutland@arm.com,
	shameerali.kolothum.thodi@huawei.com,
	yuzenghui@huawei.com,
	shivamurthy.shastri@linutronix.de
Subject: [PATCH v3 00/24] genirq, irqchip: Convert ARM MSI handling to
Date: Fri, 14 Jun 2024 12:23:39 +0200
Message-Id: <20240614102403.13610-1-shivamurthy.shastri@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

This is version 3 of the series to convert ARM MSI handling over to
per device MSI domains. Version 2 can be found here:

  https://lore.kernel.org/lkml/20221121135653.208611233@linutronix.de/

The conversion aims to replace the existing platform MSI mechanism
and enables ARM to support the future PCI/IMS mechanism.

The infrastructure to replace the platform MSI mechanism is already
upstream and in use by RISC-V and has been tested on various ARM
platforms during the V2 development.

Changes vs. V2:

    - Replace the static key to control [un]masking the parent chip
      from pci_msi_[un]mask() with a domain feature flag so it can be
      decided per MSI parent domain - Marc

    - Forwarded to v6.10-rc3

    - Minor cleanups and polishing according to review feedback

The series is only lightly tested due to lack of hardware, so we ask
the people who have access to affected machines to help with testing.

The series is also available from git:

  git://git.kernel.org/pub/scm/linux/kernel/git/anna-maria/linux-devel.git devmsi-arm

Thanks,
Shiva

Anna-Maria Behnsen (2):
  irqdomain: Fix formatting irq_find_matching_fwspec() kerneldoc comment
  irqchip/imx-mu-msi: Fix codingstyle in imx_mu_msi_domains_init()

Shivamurthy Shastri (1):
  PCI/MSI: Provide MSI_FLAG_PCI_MSI_MASK_PARENT

Thomas Gleixner (21):
  irqchip: Provide irq-msi-lib
  irqchip/gic-v3-its: Provide MSI parent infrastructure
  irqchip/irq-msi-lib: Prepare for PCI MSI/MSIX
  irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]
  irqchip/irq-msi-lib: Prepare for DEVICE MSI to replace platform MSI
  irqchip/mbigen: Prepare for real per device MSI
  irqchip/irq-msi-lib: Prepare for DOMAIN_BUS_WIRED_TO_MSI
  irqchip/gic-v3-its: Switch platform MSI to MSI parent
  irqchip/mbigen: Remove platform_msi_create_device_domain() fallback
  genirq/msi: Remove platform_msi_create_device_domain()
  genirq/gic-v3-mbi: Remove unused wired MSI mechanics
  genirq/gic-v3-mbi: Switch to MSI parent
  irqchip/gic-v2m: Switch to device MSI
  irqchip/imx-mu-msi: Switch to MSI parent
  irqchip/irq-mvebu-icu: Prepare for real per device MSI
  irqchip/mvebu-gicp: Switch to MSI parent
  irqchip/mvebu-odmi: Switch to parent MSI
  irqchip/irq-mvebu-sei: Switch to MSI parent
  irqchip/irq-mvebu-icu: Remove platform MSI leftovers
  genirq/msi: Remove platform MSI leftovers
  genirq/msi: Move msi_device_data to core

 drivers/base/platform-msi.c                   | 350 +-----------------
 drivers/irqchip/Kconfig                       |   8 +
 drivers/irqchip/Makefile                      |   4 +-
 drivers/irqchip/irq-gic-common.h              |   3 +
 drivers/irqchip/irq-gic-v2m.c                 |  80 ++--
 drivers/irqchip/irq-gic-v3-its-msi-parent.c   | 210 +++++++++++
 drivers/irqchip/irq-gic-v3-its-pci-msi.c      | 202 ----------
 drivers/irqchip/irq-gic-v3-its-platform-msi.c | 163 --------
 drivers/irqchip/irq-gic-v3-its.c              |   5 +
 drivers/irqchip/irq-gic-v3-mbi.c              | 142 ++-----
 drivers/irqchip/irq-imx-mu-msi.c              |  55 ++-
 drivers/irqchip/irq-mbigen.c                  |  96 ++---
 drivers/irqchip/irq-msi-lib.c                 | 135 +++++++
 drivers/irqchip/irq-msi-lib.h                 |  27 ++
 drivers/irqchip/irq-mvebu-gicp.c              |  45 +--
 drivers/irqchip/irq-mvebu-icu.c               | 275 ++++++--------
 drivers/irqchip/irq-mvebu-odmi.c              |  38 +-
 drivers/irqchip/irq-mvebu-sei.c               |  53 ++-
 drivers/pci/msi/irqdomain.c                   |  21 ++
 include/linux/msi.h                           |  52 +--
 kernel/irq/irqdomain.c                        |   3 +-
 kernel/irq/msi.c                              |  95 +----
 22 files changed, 734 insertions(+), 1328 deletions(-)
 create mode 100644 drivers/irqchip/irq-gic-v3-its-msi-parent.c
 delete mode 100644 drivers/irqchip/irq-gic-v3-its-pci-msi.c
 delete mode 100644 drivers/irqchip/irq-gic-v3-its-platform-msi.c
 create mode 100644 drivers/irqchip/irq-msi-lib.c
 create mode 100644 drivers/irqchip/irq-msi-lib.h

-- 
2.34.1


