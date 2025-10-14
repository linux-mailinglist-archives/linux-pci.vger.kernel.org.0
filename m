Return-Path: <linux-pci+bounces-38024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBA9BD899D
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 11:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070BE1923C84
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 09:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442A92DEA76;
	Tue, 14 Oct 2025 09:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9HH7T+M"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179261EEA5F;
	Tue, 14 Oct 2025 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435932; cv=none; b=dMnwvVXiCW8QZgmsoZK5PyGGI1URDqgGAxG9+frGUC6cBU0hoDXNJCtMtXTWtxY5rJh9TjMEoKHwJz8X7bIzjVAEbWaSYps5ojiH70iMTVEdr6sfvoLixTpvlMySdzR/uhwZy0rviz0AyfSxcB3m19iapkNVcCf5+9UOJ2Q8ZXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435932; c=relaxed/simple;
	bh=z4NC7gBEwYaG1YOUUIGK9XXB3J4aw0TajwAMPUKYIM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MRj6v1PD7iCpjzjHdMks3DJqXnS9TJ8DeRvA8Kz1bs9fgML2jk1RaTOXyLNzfSLmfjp/Pj9g/bJFCbyRDx3huWG95QSmYmHDCdCJPjmhvjVkGiLst2i0wOSfQvu6bCUXIHIDMUtNupPn45dJFA1TQTRbUbu/I/bOmWW5mdlTtiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9HH7T+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0011AC4CEE7;
	Tue, 14 Oct 2025 09:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760435931;
	bh=z4NC7gBEwYaG1YOUUIGK9XXB3J4aw0TajwAMPUKYIM4=;
	h=From:To:Cc:Subject:Date:From;
	b=W9HH7T+M4igPd4fD6kxus7phc9ehkqL1GNsCEcaVOH7zhODJUSjftFg8LWbmWyyec
	 bw/qk1Ch1jdd0qcP7tD5qeIKHDEYdeuse8VooY7XJYocPIj6NKfZOMc9o438cJd7kW
	 5n6ZSXgKIt0RtEBFI3pGxBSTRyMZR12/suvOswZmoIsd/dow1J69GDfFt7To0zWqZA
	 YxaJ+wjRftdNW1oHfW1uqgEqv/mbPAm3MfxlmBWIBNJsu8LL+peUE4gtNSAJQ1UzOu
	 6mYCodxD0KZDWXawxLDf8hQUeS8XVNrTECg1tkuk7AgUTGf2+k8qJUkmGDQAjfhTVB
	 4txgZHDBOTLMw==
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
Subject: [PATCH v2 0/4] of/irq: Misc msi-parent handling fixes/clean-ups
Date: Tue, 14 Oct 2025 11:58:41 +0200
Message-ID: <20251014095845.1310624-1-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is a follow up to [1] - with additional patches that are addressing
Rob's feedback (pcie-layerscape-gen4 was removed from the kernel, Yay !)
and other bits and bobs I noticed while staring at the code.

Patch (1) is a fix and technically we would like to get it in v6.18 please.

Patch (3) is compile-tested only, I can not run it on HW, I do not have it,
Scott, Ray please test it if you can.

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

Lorenzo Pieralisi (4):
  of/irq: Add msi-parent check to of_msi_xlate()
  of/irq: Fix OF node refcount in of_msi_get_domain()
  PCI: iproc: Implement MSI controller node detection with
    of_msi_xlate()
  irqchip/gic-its: Rework platform MSI deviceID detection

 drivers/irqchip/irq-gic-its-msi-parent.c | 98 ++++++++----------------
 drivers/of/irq.c                         | 42 +++++++++-
 drivers/pci/controller/pcie-iproc.c      | 22 ++----
 3 files changed, 76 insertions(+), 86 deletions(-)

-- 
2.50.1


