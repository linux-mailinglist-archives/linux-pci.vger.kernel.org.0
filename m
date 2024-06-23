Return-Path: <linux-pci+bounces-9134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AADF9913C0D
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 17:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66900281CDD
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 15:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7189F17F51A;
	Sun, 23 Jun 2024 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kSBtklkR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a9w2SopR"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB99F15E83;
	Sun, 23 Jun 2024 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719155915; cv=none; b=GBYzv2GTVdq2baH6bcdN/NSVeLyRdR2ce/ANuPTLirnWCecOTurGSq4nfQ7jH+fIZMoAlgx8BaK37xiAPdVmop9YP1dX51ERSDs0L87HSp9HaKNv3BdDdooQ7fHik2WcKU7d/deBqzP0BagHLRyzNxWIhfMp6Fwrlg0kdlGot90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719155915; c=relaxed/simple;
	bh=4W6vdAgBdDsl94Af+7SzvZtwgU0C251XKuRjn/IF2Y0=;
	h=Message-ID:From:To:Cc:Subject:Date; b=iyA1dYqDHvernsxeofknhYCOiZy/hJwb4QuM8a0N8ohBPrtgyl5UYklZ/edAXIaTbeVKFxUFWSa+U0H2NYK3rPBT/S0+zT3ap45XRAVvueXOFoRRvjFklBaQIL5wmMPn1dxryQuK4iWGjTK59uXO9NGNDQsOkBFSaxydO9Lb6+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kSBtklkR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a9w2SopR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240623142137.448898081@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719155911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=q10A9DWqiyptuaW4Rf+dYljBY7wq73II4IxfKeIflRc=;
	b=kSBtklkRyIjyLwyeJ3tfP16k5aJV3XtOxMpKxnzYrvFKoGiGNhOCS01404vg7e0FrXBshM
	KuVq64uK2WlBDqvLQD+rvqWX5RrlasNRp6f8sl6R+qO7UN85m3BqU89hBS3JyLhS7qlbVg
	IxB5LWG9grfuTQglZF+r3iCxMduJ05Fp8ejPqasrbyly7EmspkMeE4vRPPpWtisnWc9BRF
	CabkgIwTZ04G18/kEBC3vcRqAyS1zlws1YQnu55rR3f2V3V0tHCCX1oaHrFiJVQGCnqhet
	Ydv0L1951t6CH5KYnIWaWly4Az6z7hQoaScR828UzzdSzKQru9mkhcP//x+vMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719155911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=q10A9DWqiyptuaW4Rf+dYljBY7wq73II4IxfKeIflRc=;
	b=a9w2SopRGLgqagbABXHibYKOVyGMyUccKrtPr7rAK2CmLaQKG6XtzbZrmrqfVDd4z6Eq7v
	K9ViLlxfqRpwn4AQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
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
Subject: [patch V4 00/21] genirq,
 irqchip: Convert ARM MSI handling to per device MSI domains
Date: Sun, 23 Jun 2024 17:18:31 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

This is version 4 of the series to convert ARM MSI handling over to
per device MSI domains. Version 3 can be found here:

  https://lore.kernel.org/lkml/20240614102403.13610-1-shivamurthy.shastri@linutronix.de

The conversion aims to replace the existing platform MSI mechanism and
enables ARM to support the future PCI/IMS mechanism.

The infrastructure to replace the platform MSI mechanism is already
upstream and in use by RISC-V and has been tested on various ARM platforms
during the V2 development.

Changes vs. V3:

    - Fix the conversion of the GIC V3 MBI driver - Marc

    - Dropped a few stray MSI_FLAG_PCI_MSI_MASK_PARENT flags

    - Dropped the trivial cleanup patches as they have been merged

    - Picked up tags

The series is only lightly tested due to lack of hardware, so we rely on
the people who have access to affected machines to help with testing.

If there are no major objections raised or testing fallout reported, I'm
aiming this series for the next merge window.

The series is also available from git:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-arm-v4

Thanks,

	tglx
---
 b/drivers/base/platform-msi.c                 |  350 --------------------------
 b/drivers/irqchip/Kconfig                     |    8 
 b/drivers/irqchip/Makefile                    |    4 
 b/drivers/irqchip/irq-gic-common.h            |    3 
 b/drivers/irqchip/irq-gic-v2m.c               |   80 +----
 b/drivers/irqchip/irq-gic-v3-its-msi-parent.c |  210 +++++++++++++++
 b/drivers/irqchip/irq-gic-v3-its.c            |    5 
 b/drivers/irqchip/irq-gic-v3-mbi.c            |  130 +++------
 b/drivers/irqchip/irq-imx-mu-msi.c            |   48 +--
 b/drivers/irqchip/irq-mbigen.c                |   96 ++-----
 b/drivers/irqchip/irq-msi-lib.c               |  135 ++++++++++
 b/drivers/irqchip/irq-msi-lib.h               |   27 ++
 b/drivers/irqchip/irq-mvebu-gicp.c            |   44 +--
 b/drivers/irqchip/irq-mvebu-icu.c             |  275 ++++++++------------
 b/drivers/irqchip/irq-mvebu-odmi.c            |   37 +-
 b/drivers/irqchip/irq-mvebu-sei.c             |   52 +--
 b/drivers/pci/msi/irqdomain.c                 |   21 +
 b/include/linux/msi.h                         |   52 ---
 b/kernel/irq/msi.c                            |   95 +------
 drivers/irqchip/irq-gic-v3-its-pci-msi.c      |  202 ---------------
 drivers/irqchip/irq-gic-v3-its-platform-msi.c |  163 ------------
 21 files changed, 738 insertions(+), 1299 deletions(-)

