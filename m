Return-Path: <linux-pci+bounces-31006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2CAAEC964
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 19:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7199D1716E9
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 17:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F0F220F4F;
	Sat, 28 Jun 2025 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQVeRKAn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE58201004;
	Sat, 28 Jun 2025 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751131828; cv=none; b=PAPS4XvFrWj7pMEgdKwd+hXXZJWaooL+gekjjt40KXqkCzMB+Od+7VV6WC2Yr1wmkMVahvGALjMhWWufeXfyloXurIx8DhNrtVsGj2QajGoF8QOY0sLLh5j7bnO5727K7l0IuVxTufeIYAitAuBCR5rTXknj6vkcjbZDPMrUk2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751131828; c=relaxed/simple;
	bh=7Tfu+k4kIYM3+mGdV3aDYku43jcInJ/3Gr78P/OtksU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QFjasE3q2chchwgidftFfbZ6XdjzqD3KjBM2WBfHnDF77SxPtTvTHqGU3lWkj0qZ0TjM1PK+l9sL4q2d25eAjdeLjTrD91szM+uxeAOgX015bE/+AxQw5mvXfGjW1WpBeNX8Bq6AeYFZ5nZtHPkmXEa8dXacFZ7H9fnd+yKhmgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQVeRKAn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD10C4CEEF;
	Sat, 28 Jun 2025 17:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751131827;
	bh=7Tfu+k4kIYM3+mGdV3aDYku43jcInJ/3Gr78P/OtksU=;
	h=From:To:Cc:Subject:Date:From;
	b=GQVeRKAngXUahmHWE9Xnnvma9G05vv5+5TTjXXAHH62wBldayNswjO3l7MxkXUzqD
	 5rMkcnV2sPgyDNHZmRBGeSkZMDRT4smYyqAwzM4Sz1JtldMQCqF1jhi+QZcAPvzDF4
	 dAV19Cr9LUj1Rs3iOrP6GFf4X5hUes3jggleQ4H26iFMNMIRxsnqsx1ql+zBHrW+Q+
	 ynTlqQG0SN1NK1u9tfSGJv2GrI0kILeSAkiS3NGB0sjTfB8+H4eAqrugKRZitmTjTT
	 kyKonglJ0n0Mvk7Nf8H9lqHdSdwAFr3pJXOhRTOX7khAGJVLQqHOXRKiPmqpqJYu7+
	 MN9dW0YwLC7iw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uVZNh-00AqZC-En;
	Sat, 28 Jun 2025 18:30:25 +0100
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
Subject: [PATCH 00/12] PCI: xgene: Fix and simplify the MSI driver
Date: Sat, 28 Jun 2025 18:29:53 +0100
Message-Id: <20250628173005.445013-1-maz@kernel.org>
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
of -rc3, tested on a Mustang board.

Marc Zyngier (12):
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

 drivers/pci/controller/pci-xgene-msi.c | 418 +++++++++----------------
 drivers/pci/controller/pci-xgene.c     |  33 +-
 kernel/irq/chip.c                      |   8 +-
 3 files changed, 176 insertions(+), 283 deletions(-)

-- 
2.39.2


