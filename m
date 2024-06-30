Return-Path: <linux-pci+bounces-9477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4D291D3D8
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 22:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0C62815F3
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 20:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B5A1527A2;
	Sun, 30 Jun 2024 20:22:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E764F2110F;
	Sun, 30 Jun 2024 20:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719778938; cv=none; b=GY/M3WKsA8JM20Llyfcejv/stl1kkoGUJOYixSWCq1amhRupNHJleNIsDFilu0g8022t4C5cw6NPS/Dh5Wg/dIpf2j+lmC6VQw7cv/7fj/YNb4TrgIW+L97LyB+SOwUONgcvtCyet2xj+veWpku+Y/mudg0iPiDUsQAe+O5OhUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719778938; c=relaxed/simple;
	bh=lzpL2nzugDaFwZeF1pKIbjNiSVOzGTqrC31zFTfkAIg=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=k5sRdDtPsjKTbWwv5punNVH4QfS+Qp3vXXLfQcOjWSCg+KpHtXrXPXe4m+sCBoDqPs6trXDKBbc4pLFlgXMAq4F5TLvCiGb29nY351UUJw1vBRbVhLS0GpsWbwG6z5MzGkIbCaAJ8qyRAsaszD+juBQMi1tRZAKbAG41Bvj6qNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 385C010190FA3;
	Sun, 30 Jun 2024 22:22:15 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 0DE6C61DA805;
	Sun, 30 Jun 2024 22:22:15 +0200 (CEST)
X-Mailbox-Line: From bd850e8257552d47433bdb2e10fa9b0a49659a4e Mon Sep 17 00:00:00 2001
Message-ID: <bd850e8257552d47433bdb2e10fa9b0a49659a4e.1719771133.git.lukas@wunner.de>
In-Reply-To: <cover.1719771133.git.lukas@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 30 Jun 2024 21:45:00 +0200
Subject: [PATCH v2 10/18] PCI/CMA: Reauthenticate devices on reset and resume
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>, <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Cc: <linuxarm@huawei.com>, David Box <david.e.box@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Li, Ming" <ming4.li@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Alistair Francis <alistair.francis@wdc.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, "Damien Le Moal" <dlemoal@kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>, Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>, Jerome Glisse <jglisse@google.com>, Sean Christopherson <seanjc@google.com>, Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

CMA-SPDM state is lost when a device undergoes a Conventional Reset.
(But not a Function Level Reset, PCIe r6.2 sec 6.6.2.)  A D3cold to D0
transition implies a Conventional Reset (PCIe r6.2 sec 5.8).

Thus, reauthenticate devices on resume from D3cold and on recovery from
a Secondary Bus Reset or DPC-induced Hot Reset.

The requirement to reauthenticate devices on resume from system sleep
(and in the future reestablish IDE encryption) is the reason why SPDM
needs to be in-kernel:  During ->resume_noirq, which is the first phase
after system sleep, the PCI core walks down the hierarchy, puts each
device in D0, restores its config space and invokes the driver's
->resume_noirq callback.  The driver is afforded the right to access the
device already during this phase.

To retain this usage model in the face of authentication and encryption,
CMA-SPDM reauthentication and IDE reestablishment must happen during the
->resume_noirq phase, before the driver's first access to the device.
The driver is thus afforded seamless authenticated and encrypted access
until the last moment before suspend and from the first moment after
resume.

During the ->resume_noirq phase, device interrupts are not yet enabled.
It is thus impossible to defer CMA-SPDM reauthentication to a user space
component on an attached disk or on the network, making an in-kernel
SPDM implementation mandatory.

The same catch-22 exists on recovery from a Conventional Reset:  A user
space SPDM implementation might live on a device which underwent reset,
rendering its execution impossible.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/cma.c        | 15 +++++++++++++++
 drivers/pci/pci-driver.c |  1 +
 drivers/pci/pci.c        | 12 ++++++++++--
 drivers/pci/pci.h        |  2 ++
 drivers/pci/pcie/err.c   |  3 +++
 5 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
index e974d489c7a2..f2c435b04b92 100644
--- a/drivers/pci/cma.c
+++ b/drivers/pci/cma.c
@@ -195,6 +195,21 @@ void pci_cma_init(struct pci_dev *pdev)
 	spdm_authenticate(pdev->spdm_state);
 }
 
+/**
+ * pci_cma_reauthenticate() - Perform CMA-SPDM authentication again
+ * @pdev: Device to reauthenticate
+ *
+ * Can be called by drivers after device identity has mutated,
+ * e.g. after downloading firmware to an FPGA device.
+ */
+void pci_cma_reauthenticate(struct pci_dev *pdev)
+{
+	if (!pdev->spdm_state)
+		return;
+
+	spdm_authenticate(pdev->spdm_state);
+}
+
 void pci_cma_destroy(struct pci_dev *pdev)
 {
 	if (!pdev->spdm_state)
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index af2996d0d17f..89571f94debc 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -566,6 +566,7 @@ static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
 	pci_pm_power_up_and_verify_state(pci_dev);
 	pci_restore_state(pci_dev);
 	pci_pme_restore(pci_dev);
+	pci_cma_reauthenticate(pci_dev);
 }
 
 static void pci_pm_bridge_power_up_actions(struct pci_dev *pci_dev)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 59e0949fb079..2a8063e7f2e0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4980,8 +4980,16 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 
 	rc = pci_dev_reset_slot_function(dev, probe);
 	if (rc != -ENOTTY)
-		return rc;
-	return pci_parent_bus_reset(dev, probe);
+		goto done;
+
+	rc = pci_parent_bus_reset(dev, probe);
+
+done:
+	/* CMA-SPDM state is lost upon a Conventional Reset */
+	if (!probe)
+		pci_cma_reauthenticate(dev);
+
+	return rc;
 }
 
 static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fc90845caf83..b4c2ce5fd070 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -336,9 +336,11 @@ static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
 #ifdef CONFIG_PCI_CMA
 void pci_cma_init(struct pci_dev *pdev);
 void pci_cma_destroy(struct pci_dev *pdev);
+void pci_cma_reauthenticate(struct pci_dev *pdev);
 #else
 static inline void pci_cma_init(struct pci_dev *pdev) { }
 static inline void pci_cma_destroy(struct pci_dev *pdev) { }
+static inline void pci_cma_reauthenticate(struct pci_dev *pdev) { }
 #endif
 
 /**
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 31090770fffc..0028582f0590 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -133,6 +133,9 @@ static int report_slot_reset(struct pci_dev *dev, void *data)
 	pci_ers_result_t vote, *result = data;
 	const struct pci_error_handlers *err_handler;
 
+	/* CMA-SPDM state is lost upon a Conventional Reset */
+	pci_cma_reauthenticate(dev);
+
 	device_lock(&dev->dev);
 	pdrv = dev->driver;
 	if (!pdrv || !pdrv->err_handler || !pdrv->err_handler->slot_reset)
-- 
2.43.0


