Return-Path: <linux-pci+bounces-12644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFB19691A6
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 05:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08FB3B20F2C
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 03:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE58D1CCED3;
	Tue,  3 Sep 2024 03:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="MouyVDgm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E762C2AD02;
	Tue,  3 Sep 2024 03:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725332707; cv=none; b=OvnTV88b5fqu3sztmap7Nq8xz+EQvk0aPdyV2eKfqAdiWFibvnLk6IOwt15Iv2QOneu+DM2DQDBLDXoIr9SkW0DOr7BtXVLceu2eDgMQTC4NAJBMVdAa7UJDddbkgA9qFi3l3ONlaYX80fN0FJQBSCfCL5D6p6DBExzaCPs8WIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725332707; c=relaxed/simple;
	bh=xDWnm992v5491wL8vjSVQL2pr5JbS0Y9QE2G+5QdfL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gh5um4vG7cr8l+yRHw9SqsX0ZUJAOhfUAK4N6aaywLLH5SO3HZO2UCgs1aMoD2Qwni0R7jgeUO0XoLvTHLLzazw1lc+cY2+vwzxBIhOrtbJhAnfNPiVx1Yhd9NWyPgzyPHnTnynK+Oq/MiHk/mYywRg5+dBo3M9KodixrlITv8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=MouyVDgm; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (unknown [10.101.196.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 3BF2D3F815;
	Tue,  3 Sep 2024 02:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725332168;
	bh=ju/3DT/96Rz/Meyl3hFHlGrVpwLzX4tHG0xUmw5imBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=MouyVDgm/IaNjs865bzLleq+sK9uWco94O5X0QMwFHvyeLUojFYxOPQStB/rNr89c
	 agfS+54/cGlK5uGIol5x82pbMNYiELd8/67M1mqXyN7WOlBOU3hIoHamXAoKBQbnI6
	 Chuh8j5fJv67nGQiorLtQDIxA0vsrsT/UxbLOkIg2oYtaMZ/U5KlxuNO4VGlaZ3VOH
	 D/oTRAA4+zfOJ0ICPh75Q5SofjTVxsRIM2IiRb6tqMaafmkTgWS4caYdReyAVOdnoo
	 trsBs5acrRXP/9yONeF7VkUxtwAxIzWTuWezb/JHXMbxfVam1eZOiJP7L3M9M5cgAT
	 KxoRQrkQiv8Iw==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: nirmal.patel@linux.intel.com,
	jonathan.derrick@linux.dev
Cc: acelan.kao@canonical.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] PCI: vmd: Delay interrupt handling on MTL VMD controller
Date: Tue,  3 Sep 2024 10:55:44 +0800
Message-ID: <20240903025544.286223-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Meteor Lake VMD has a bug that the IRQ raises before the DMA region is
ready, so the requested IO is considered never completed:
[   97.343423] nvme nvme0: I/O 259 QID 2 timeout, completion polled
[   97.343446] nvme nvme0: I/O 384 QID 3 timeout, completion polled
[   97.343459] nvme nvme0: I/O 320 QID 4 timeout, completion polled
[   97.343470] nvme nvme0: I/O 707 QID 5 timeout, completion polled

The is documented as erratum MTL016 [0]. The suggested workaround is to
"The VMD MSI interrupt-handler should initially perform a dummy register
read to the MSI initiator device prior to any writes to ensure proper
PCIe ordering." which essentially is adding a delay before the interrupt
handling.

Hence add a delay before handle interrupt to workaround the erratum.

[0] https://edc.intel.com/content/www/us/en/design/products/platforms/details/meteor-lake-u-p/core-ultra-processor-specification-update/errata-details/#MTL016

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217871
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/controller/vmd.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index a726de0af011..3433b3730f9c 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -16,6 +16,7 @@
 #include <linux/srcu.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
+#include <linux/delay.h>
 
 #include <asm/irqdomain.h>
 
@@ -74,6 +75,9 @@ enum vmd_features {
 	 * proper power management of the SoC.
 	 */
 	VMD_FEAT_BIOS_PM_QUIRK		= (1 << 5),
+
+	/* Erratum MTL016 */
+	VMD_FEAT_INTERRUPT_QUIRK	= (1 << 6),
 };
 
 #define VMD_BIOS_PM_QUIRK_LTR	0x1003	/* 3145728 ns */
@@ -90,6 +94,8 @@ static DEFINE_IDA(vmd_instance_ida);
  */
 static DEFINE_RAW_SPINLOCK(list_lock);
 
+static bool interrupt_delay;
+
 /**
  * struct vmd_irq - private data to map driver IRQ to the VMD shared vector
  * @node:	list item for parent traversal.
@@ -105,6 +111,7 @@ struct vmd_irq {
 	struct vmd_irq_list	*irq;
 	bool			enabled;
 	unsigned int		virq;
+	bool			delay_irq;
 };
 
 /**
@@ -680,8 +687,11 @@ static irqreturn_t vmd_irq(int irq, void *data)
 	int idx;
 
 	idx = srcu_read_lock(&irqs->srcu);
-	list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node)
+	list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node) {
+		if (interrupt_delay)
+			udelay(4);
 		generic_handle_irq(vmdirq->virq);
+	}
 	srcu_read_unlock(&irqs->srcu, idx);
 
 	return IRQ_HANDLED;
@@ -1015,6 +1025,9 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
 		vmd->first_vec = 1;
 
+	if (features & VMD_FEAT_INTERRUPT_QUIRK)
+		interrupt_delay = true;
+
 	spin_lock_init(&vmd->cfg_lock);
 	pci_set_drvdata(dev, vmd);
 	err = vmd_enable_domain(vmd, features);
@@ -1106,7 +1119,8 @@ static const struct pci_device_id vmd_ids[] = {
 	{PCI_VDEVICE(INTEL, 0xa77f),
 		.driver_data = VMD_FEATS_CLIENT,},
 	{PCI_VDEVICE(INTEL, 0x7d0b),
-		.driver_data = VMD_FEATS_CLIENT,},
+		.driver_data = VMD_FEATS_CLIENT |
+			       VMD_FEAT_INTERRUPT_QUIRK,},
 	{PCI_VDEVICE(INTEL, 0xad0b),
 		.driver_data = VMD_FEATS_CLIENT,},
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
-- 
2.43.0


