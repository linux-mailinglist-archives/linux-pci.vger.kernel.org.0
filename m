Return-Path: <linux-pci+bounces-31705-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2E4AFD560
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 19:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F653AE899
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 17:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819212E5B08;
	Tue,  8 Jul 2025 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjvNesQF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3631F91C8;
	Tue,  8 Jul 2025 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751996051; cv=none; b=FpBi6vyRkjcbECYPIUhY+I+QP+0MePepLF/OuS4ltPRqWfgD8TrozW+dGX/90OvYQ7H8n+nOguQ/YstLmaFaZQj5H1eqedczBDdrsRLBhICo9UAXzlqbtxiO6pbp/wT607JGlJdDrkw2YlVXOiHoV8NXHAQw079CpOVkpRfGsdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751996051; c=relaxed/simple;
	bh=m7DhdVicmrqrIoSMYirW5qjPjKd3MmBXE15EmI0rxmU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jPmKUo0dXe4/+gCa+oztWd3TvMHdeeIaTryzcD+OPAS+O//pYPk1uySl+jNfvR7yIrQVEM9lk9bQQEkVnyXTC2HAQZr0i1ZQDj38jkH+lWoU4WIRhf4m3bVQ6Pc5mkIZlnysOeyqybknjhuo3F8ZebtIMLT5mNRfe+OAjFeDIlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjvNesQF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0444C4CEF8;
	Tue,  8 Jul 2025 17:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751996050;
	bh=m7DhdVicmrqrIoSMYirW5qjPjKd3MmBXE15EmI0rxmU=;
	h=From:To:Cc:Subject:Date:From;
	b=pjvNesQFtUHsoqucRDlqkQJRe9QTRvdPe/0GzwFpDrHWUeeAJldyp7guUKnYbBv4j
	 YbdSNrmLEyn+lqDYGiqkV1b5yIt5QO0mvNhdTTYW5lor/4CGhuaAyXrqZ4/74tNZei
	 K+yLy1O4jYCoQoSGKSgVZYLf3ribvJei7Nyh93OjdonsDlIKSWiefv8VR5Wxv5m6Xc
	 uehp3ZdrsA66pa7OYqBM3vaasBApR2Bp8jk6jjNton4+Tsk9bIuk4DAG4PIeztUu/y
	 br1KRAJ4y5KtVO7EdCTcCt249R2QyRBPgyRsXhhz48NRdRchAfwQEM/e95ViOcprg2
	 SzZbM+eCdxgaA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uZCCm-00Dqhw-Id;
	Tue, 08 Jul 2025 18:34:08 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Toan Le <toan@os.amperecomputing.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 00/13] PCI: xgene: Fix and simplify the MSI driver
Date: Tue,  8 Jul 2025 18:33:51 +0100
Message-Id: <20250708173404.1278635-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, toan@os.amperecomputing.com, lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, bhelgaas@google.com, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Having recently dipped into the xgene-msi driver to bring it to use
the MSI-parent concept, I have realised that some of it was slightly
sub-par (read: downright broken).

The driver is playing horrible tricks behind the core code, missing
proper affinity management, is terribly over-designed for no good
reason, and despite what MAINTAINERS says, completely unmaintained.

This series is an attempt to fix most of the issues, and effectively
results more or less in a full rewrite of the driver, removing a lot
of cruft and fixing the interactions with the PCI host driver in the
process (there really isn't any reason to rely on initcall ordering
anymore).

I've stopped short of repainting the MAINTAINERS file, but given how
reactive Toan Le has been, maybe that's on the cards. Patches on top
of -rc3, tested on a Mustang board. I'd really like this to hit 6.17!

* From v1:

  - Killed CPUHP_PCI_XGENE_DEAD altogether

  - Added a couple of definitions and helpers to make the hwirq/frame/group
    mapping a bit less awkward

  - More comments about the weird and wonderful behaviour of MSInIRx
    registerse

  - Collected RB from tglx, with thanks

Marc Zyngier (13):
  genirq: Teach handle_simple_irq() to resend an in-progress interrupt
  PCI: xgene: Defer probing if the MSI widget driver hasn't probed yet
  PCI: xgene: Drop useless conditional compilation
  PCI: xgene: Drop XGENE_PCIE_IP_VER_UNKN
  PCI: xgene-msi: Make per-CPU interrupt setup robust
  PCI: xgene-msi: Drop superfluous fields from xgene_msi structure
  PCI: xgene-msi: Use device-managed memory allocations
  PCI: xgene-msi: Get rid of intermediate tracking structure
  PCI: xgene-msi: Sanitise MSI allocation and affinity setting
  PCI: xgene-msi: Resend an MSI racing with itself on a different CPU
  PCI: xgene-msi: Probe as a standard platform driver
  PCI: xgene-msi: Restructure handler setup/teardown
  cpu/hotplug: Remove unused cpuhp_state CPUHP_PCI_XGENE_DEAD

 drivers/pci/controller/pci-xgene-msi.c | 428 +++++++++----------------
 drivers/pci/controller/pci-xgene.c     |  33 +-
 include/linux/cpuhotplug.h             |   1 -
 kernel/irq/chip.c                      |   8 +-
 4 files changed, 187 insertions(+), 283 deletions(-)

-- 
2.39.2


