Return-Path: <linux-pci+bounces-32619-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB142B0BCC5
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 08:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241CF3BDC11
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 06:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F9627EFFF;
	Mon, 21 Jul 2025 06:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ym9uHm76";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cTJ5n08O"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB34927E05A;
	Mon, 21 Jul 2025 06:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753079799; cv=none; b=lRL3bJJV8QkBxAtMNTdMmF81b7ecZIv8DbE4AUO3rQdh1XcNLFATadN7Z4AReg9XXImES/x/E41GNaWv4Ir/rMf4Jlau8dCOxjHzysosD/KZgxANonuFCkHBUtKPoa2wMsWpDNZsNMFKO/CIXIFN7fymUgTXZ8Cq1Jo19bps/6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753079799; c=relaxed/simple;
	bh=sO8N87llMhBAL46D0UNi35hXqRL1hKXNp2gY1ICdGG0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hl15tiUQO3HuzprlrrXSOXX6lgrs94zZno6Y1zkSR8QA1E7dJON7Bz641W4medmnnGzlwZvPlUkFo3UKhK9PWRVsnl/JJV1mAzUcMP9x/J+F5DcWubMKTMqvhVdWq6ytHhyEvrY3/85dalL3dNk2M6PV3eIDfvHyWaD6VS0cxvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ym9uHm76; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cTJ5n08O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753079795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kSko5Mokq1Ol99CoaRoUYWqbWi4K0PtMwj7NAm8d1cs=;
	b=Ym9uHm76Uv59xz/SUdCTMNX6vws0v60/R8itMuF8thUScaGLv996OPAMaQ+QLdoS6JkyFM
	Bh2Z84u9fEcFBYQVRCPJ7z8kdyWqsq5UYkIdYvkPsC2GedhBQ0sWDoW9LBvWzlBTS0m3uu
	N6DeJW/UKOb6Dyk//l8hTNdDjw2YiH+ShHDD4qvMeOBmiH6aHRSnKadJdLqUmV4r37Od+8
	VdqJzf7om66gmNf0M8Z7PBtvmDG45Eq0me9c5YmyPC9N2YEYAJhkV5oRi9GIwactnKVMlU
	yTOsoP3AVPL9qGx3nr3Rnzey5WsF4IQtbBj4uiTkGbSQCgqLLbA2H02/w4x9Vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753079795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kSko5Mokq1Ol99CoaRoUYWqbWi4K0PtMwj7NAm8d1cs=;
	b=cTJ5n08O+zyJneTiHARPrVeRnzSIETpnKGswjjNfnTxddrXzyUsHy9mCfrzgBXpm9mm2ew
	GTM6OPQD5HMNRsDg==
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH] PCI/MSI: Delete pci_msi_create_irq_domain()
Date: Mon, 21 Jul 2025 08:36:26 +0200
Message-Id: <20250721063626.3026756-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

pci_msi_create_irq_domain() is unused. Delete it.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
This is the final step in converting to the new MSI interrupt domain setup:
deleting the old setup.

This patch depends on the driver conversion patches listed below. Most
patches have been applied somewhere, except for the first one.

https://lore.kernel.org/lkml/cover.1752868165.git.namcao@linutronix.de/
   -> has not been applied anywhere

https://lore.kernel.org/lkml/cover.1750861319.git.namcao@linutronix.de/
   -> applied to powerpc/next-test

https://lore.kernel.org/linux-um/cover.1751266049.git.namcao@linutronix.de/
   -> applied to uml/next

https://lore.kernel.org/lkml/cover.1750858083.git.namcao@linutronix.de/
   -> applied to pci/next

https://lore.kernel.org/lkml/cover.1751875853.git.namcao@linutronix.de/
   -> applied to netdev/net-next

https://lore.kernel.org/lkml/cover.1750860131.git.namcao@linutronix.de/
   -> applied to tip/irq/drivers
---
 drivers/pci/msi/irqdomain.c | 90 -------------------------------------
 include/linux/msi.h         |  3 --
 2 files changed, 93 deletions(-)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index c05152733993..926a16e80192 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -49,96 +49,6 @@ static void pci_msi_domain_write_msg(struct irq_data *ir=
q_data, struct msi_msg *
 		__pci_write_msi_msg(desc, msg);
 }
=20
-/**
- * pci_msi_domain_calc_hwirq - Generate a unique ID for an MSI source
- * @desc:	Pointer to the MSI descriptor
- *
- * The ID number is only used within the irqdomain.
- */
-static irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
-{
-	struct pci_dev *dev =3D msi_desc_to_pci_dev(desc);
-
-	return (irq_hw_number_t)desc->msi_index |
-		pci_dev_id(dev) << 11 |
-		((irq_hw_number_t)(pci_domain_nr(dev->bus) & 0xFFFFFFFF)) << 27;
-}
-
-static void pci_msi_domain_set_desc(msi_alloc_info_t *arg,
-				    struct msi_desc *desc)
-{
-	arg->desc =3D desc;
-	arg->hwirq =3D pci_msi_domain_calc_hwirq(desc);
-}
-
-static struct msi_domain_ops pci_msi_domain_ops_default =3D {
-	.set_desc	=3D pci_msi_domain_set_desc,
-};
-
-static void pci_msi_domain_update_dom_ops(struct msi_domain_info *info)
-{
-	struct msi_domain_ops *ops =3D info->ops;
-
-	if (ops =3D=3D NULL) {
-		info->ops =3D &pci_msi_domain_ops_default;
-	} else {
-		if (ops->set_desc =3D=3D NULL)
-			ops->set_desc =3D pci_msi_domain_set_desc;
-	}
-}
-
-static void pci_msi_domain_update_chip_ops(struct msi_domain_info *info)
-{
-	struct irq_chip *chip =3D info->chip;
-
-	BUG_ON(!chip);
-	if (!chip->irq_write_msi_msg)
-		chip->irq_write_msi_msg =3D pci_msi_domain_write_msg;
-	if (!chip->irq_mask)
-		chip->irq_mask =3D pci_msi_mask_irq;
-	if (!chip->irq_unmask)
-		chip->irq_unmask =3D pci_msi_unmask_irq;
-}
-
-/**
- * pci_msi_create_irq_domain - Create a MSI interrupt domain
- * @fwnode:	Optional fwnode of the interrupt controller
- * @info:	MSI domain info
- * @parent:	Parent irq domain
- *
- * Updates the domain and chip ops and creates a MSI interrupt domain.
- *
- * Returns:
- * A domain pointer or NULL in case of failure.
- */
-struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
-					     struct msi_domain_info *info,
-					     struct irq_domain *parent)
-{
-	if (WARN_ON(info->flags & MSI_FLAG_LEVEL_CAPABLE))
-		info->flags &=3D ~MSI_FLAG_LEVEL_CAPABLE;
-
-	if (info->flags & MSI_FLAG_USE_DEF_DOM_OPS)
-		pci_msi_domain_update_dom_ops(info);
-	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
-		pci_msi_domain_update_chip_ops(info);
-
-	/* Let the core code free MSI descriptors when freeing interrupts */
-	info->flags |=3D MSI_FLAG_FREE_MSI_DESCS;
-
-	info->flags |=3D MSI_FLAG_ACTIVATE_EARLY | MSI_FLAG_DEV_SYSFS;
-	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
-		info->flags |=3D MSI_FLAG_MUST_REACTIVATE;
-
-	/* PCI-MSI is oneshot-safe */
-	info->chip->flags |=3D IRQCHIP_ONESHOT_SAFE;
-	/* Let the core update the bus token */
-	info->bus_token =3D DOMAIN_BUS_PCI_MSI;
-
-	return msi_create_irq_domain(fwnode, info, parent);
-}
-EXPORT_SYMBOL_GPL(pci_msi_create_irq_domain);
-
 /*
  * Per device MSI[-X] domain functionality
  */
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 77227d23ea84..0c0e59af043c 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -703,9 +703,6 @@ void __pci_read_msi_msg(struct msi_desc *entry, struct =
msi_msg *msg);
 void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void pci_msi_mask_irq(struct irq_data *data);
 void pci_msi_unmask_irq(struct irq_data *data);
-struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
-					     struct msi_domain_info *info,
-					     struct irq_domain *parent);
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *=
pdev);
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
 #else /* CONFIG_PCI_MSI */
--=20
2.39.5


