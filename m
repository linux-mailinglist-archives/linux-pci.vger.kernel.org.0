Return-Path: <linux-pci+bounces-38433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8E4BE7472
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 10:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B0375092E4
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 08:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3702D7D3A;
	Fri, 17 Oct 2025 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjMj1K9c"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922D8293C42;
	Fri, 17 Oct 2025 08:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760690880; cv=none; b=tGZl5noHrifNirvbz1QAE4Dkbjnn0HuVLu5bGDV33F9vs9ukJIeI1k7+29H+ciz6aeJFS+WDvolaH9YRWu/0KDPtK8a85Dbqou6lHegL77lz2/uxk1yh9QbjYxsnCZBJKIqMubQw1e83j9WwV5gn6P67zXFNCX2poUveaUtdxOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760690880; c=relaxed/simple;
	bh=qb2lOaLu7mGcTG3Wb+zCcqzvBbzN9049OIe/kjq4vec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sgWzgwd0I6tne/TJLpmK6bcezuxWgy62GAinecZAcaE/shOPhVxBNamLgf5XtOiWkc6DwtjwZIOKyf/xJLk9tFNc/SC6fOLVMeLCw2eehIwkGeo65Fzl9w87qyhx0suaF5BhztsqWBrJrq9FFHWCcqXoQtnpcnB8IQw0I4lJ2Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjMj1K9c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73406C4CEF9;
	Fri, 17 Oct 2025 08:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760690879;
	bh=qb2lOaLu7mGcTG3Wb+zCcqzvBbzN9049OIe/kjq4vec=;
	h=From:To:Cc:Subject:Date:From;
	b=mjMj1K9cHqbpV+gjMypV+bRUcvPMZ9BKVZBEpKJ1P/8vLpHODrvqNDSm1WcVrXvkl
	 KroqecCGou1+PpVskK0zTVJqH4/x0xvmPGD2jvAz8uIzaV9pVz7a7WDw9YXH/g3C2Z
	 A6Zl5W7rxj+HwHov+lLmZ4xvhnijtNPt9V8WXxpFqCg8AdiORVpwGETZ1CPTcGhNJY
	 vUZMkfC3qB3ux7d/W1ZHmI16tmjAYTAR493dmjcmdpmEpml1mlGXI1jjs/hjq/vYm0
	 43V9mg3DlTidj5aTaEpfFmh0a7GIh64O1vwVmwS2y3ds5AWqg+WPlHWO3R8ILSM2Cf
	 MCXbtiL9ZjbVA==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
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
Subject: [PATCH v3 0/5] of/irq: Misc msi-parent handling fixes/clean-ups
Date: Fri, 17 Oct 2025 10:47:47 +0200
Message-ID: <20251017084752.1590264-1-lpieralisi@kernel.org>
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

v2 -> v3:
	- Added additional patch to export of_msi_xlate()
	- Merged Marc's ITS parent diff
	- Added trailers, fixed commit logs

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
 drivers/of/irq.c                         | 43 +++++++++--
 drivers/pci/controller/pcie-iproc.c      | 22 ++----
 3 files changed, 67 insertions(+), 89 deletions(-)

-- 
2.50.1


