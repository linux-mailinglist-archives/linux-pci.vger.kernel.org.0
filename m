Return-Path: <linux-pci+bounces-38885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E885BF67C6
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 14:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71283188C6EF
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 12:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F1032ED42;
	Tue, 21 Oct 2025 12:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gnrk9jKg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863DC32E6A4;
	Tue, 21 Oct 2025 12:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761050470; cv=none; b=h3D2ROgmnA9dcMvYxLr9ik3Ihh4D98f/SjV0e/fHkgvThqKnYv1TMl+NR5vHCEb2cwjFWTB8ocfzeRMglGmE7uvNHPR/Xgye+xhDMUSCXSmbqMzfTffEUoSzx0klsAGQheUx/n3wAUTSgYDIyR9A58aiRFBVLPNIfAaQRkPrkws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761050470; c=relaxed/simple;
	bh=uAhf200dsvIo89TJRuvH8/3+8lhJkw1+gk7dnaDCeJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g6MSmqgCSn6UFny1uZuYaULb5W1pgXRllpz0aBpC3WlQ8jaFWZPYumzH3rZ37fsO/NkXx0/3S6/ngEdu3I3se1QJLcbM/ssvFHwjej6gWLuxtm8Hy8EU+B5eViBxD+RhtO7Z+cwD2YjbaLDMUkm8Hy9yasWitBeijrJ08GX3tiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gnrk9jKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE154C4CEF1;
	Tue, 21 Oct 2025 12:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761050470;
	bh=uAhf200dsvIo89TJRuvH8/3+8lhJkw1+gk7dnaDCeJg=;
	h=From:To:Cc:Subject:Date:From;
	b=Gnrk9jKgRAeBg5owfO6OldAN0DipPYh+Ou55m/NtzHfLkYGr38AaBczwOHZHpfMQn
	 jHuNoA8pxwtmnzpFUmugivMeFY1V40OglVJ9OQ43DcG8infqwxJrM9hFGnceAdSdaI
	 Lby0VFOMBeUZO7yVYYq/zsQCmeYNXMZFgjNQNTLWMbDoGSXlEgfUV4x5uS+NNTZ0Pm
	 IMWO8UEgEIix1brXfb+uRtlj+nTmoj3gBO2MzUW3u0+RXvM4vd+96pKMbUBfOnMNzx
	 mTLos9q3rK0o1dF4I3FoeKFEdPDN2hPubu9mU4hVnYfeKafaUy0pZOSN7sRZGF7kGF
	 4lG3b1W9CHyhw==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Scott Branden <sbranden@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Frank Li <Frank.Li@nxp.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH v4 0/5] of/irq: Misc msi-parent handling fixes/clean-ups
Date: Tue, 21 Oct 2025 14:40:58 +0200
Message-ID: <20251021124103.198419-1-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is series is a follow up to [1] - with additional patches that are
addressing Rob's feedback (pcie-layerscape-gen4 was removed from the
kernel, Yay !) and other bits and bobs I noticed while staring at the code.

Patch (1) is a fix and technically we would like to get it in v6.18 please.

Patch (4) is compile-tested only, I can not run it on HW, I do not have it,
Scott, Ray please test it if you can.

v3 -> v4:
	- Addressed Rob's review
	- Added trailers
	- Rebased against v6.18-rc2

v2 -> v3:
	- Added additional patch to export of_msi_xlate()
	- Addressed review feedback

v3: https://lore.kernel.org/lkml/20251017084752.1590264-1-lpieralisi@kernel.org/
v2: https://lore.kernel.org/lkml/20251014095845.1310624-1-lpieralisi@kernel.org/
v1: https://lore.kernel.org/lkml/20250916091858.257868-1-lpieralisi@kernel.org/

[1] https://lore.kernel.org/lkml/20250916091858.257868-1-lpieralisi@kernel.org/

Cc: Sascha Bischoff <sascha.bischoff@arm.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>

Lorenzo Pieralisi (5):
  of/irq: Add msi-parent check to of_msi_xlate()
  of/irq: Fix OF node refcount in of_msi_get_domain()
  of/irq: Export of_msi_xlate() for module usage
  PCI: iproc: Implement MSI controller node detection with
    of_msi_xlate()
  irqchip/gic-its: Rework platform MSI deviceID detection

 drivers/irqchip/irq-gic-its-msi-parent.c | 91 ++++++------------------
 drivers/of/irq.c                         | 44 ++++++++++--
 drivers/pci/controller/pcie-iproc.c      | 22 ++----
 3 files changed, 68 insertions(+), 89 deletions(-)

-- 
2.50.1


