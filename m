Return-Path: <linux-pci+bounces-33025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B601B136A8
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 10:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D72174677
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 08:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498B0266B52;
	Mon, 28 Jul 2025 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mz29zVDR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5C2266581;
	Mon, 28 Jul 2025 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691104; cv=none; b=WdCvvAgMo2NEWx8IwVUYFFK9J5h+b3pz8oL7FMJGdBDF8FxeZNnzJ7NYRYEPfEKqDPzCoZrXmdEvjI7uehfd43L//yExMgx2UvT4SakCtuN42y0NRlnP6xuOUcNShBTqELu8kSZ1h11BnkuIVt4TIXs6lWnFuJX3XMekAxIcZVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691104; c=relaxed/simple;
	bh=3vcIBee/NbsvEu80GFPtvaNBMX//h7roLKyHUYZ6P1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UszJr5q479JR7mVqs7RNQ07kz4hp/+ZPxF7w/z9lp1cSNoakOhOkVXoChojImFU7BBYnSzjlm8bmGttW4r8uQZSGgOtAR5RSaBYDBkCBtVxHxPNOhhke5j7Mc8sLgTZ7wqp8L68MuKmKrLHkyglZLnhWRNfFb4TRIefXl542euk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mz29zVDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D1BC4CEE7;
	Mon, 28 Jul 2025 08:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753691104;
	bh=3vcIBee/NbsvEu80GFPtvaNBMX//h7roLKyHUYZ6P1c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mz29zVDRT8liVIK8t1ESFDAN2IRTTIukTWs75GH8BWCt2F2vEfkPVXkwiIe51qLbh
	 w4WPMdfQfuBndExKcVFjpoOkMJCZG7WsfeluFPGwYZoDfT9j876pLJSbxji/1zNsd9
	 U5g9pgg4K/aNFsngP3s7pZI3fZixnZ5zIvA/a1T0P+XssZBoCasqk2oR7iFWTmyB8d
	 TS0BZQEat3oRiMwx0T2J4cnlxNxTZBufZKYaxtQIuI07SlXsFD/qy73Y/aFzqufFh+
	 60k8+YVDowgzieP3HJgDvNj1odFWrVwaLM9Lq0XobcypLlE7gdF17NNhc5pBYy8GNi
	 ptC54BXElc+5A==
From: chrisl@kernel.org
Date: Mon, 28 Jul 2025 01:24:55 -0700
Subject: [PATCH RFC 25/25] PCI/LUO: Clean up PCI_SER_GET()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-luo-pci-v1-25-955b078dd653@kernel.org>
References: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
In-Reply-To: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>, 
 Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
 Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
 Mike Rapoport <rppt@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
X-Mailer: b4 0.14.2

From: David Matlack <dmatlack@google.com>

Refactor PCI_SER_GET() to be more readable by storing the pointer
to struct pci_dev_ser in an intermediate variable and adding a helper
function to_pci_dev_ser().

Change pci_lu_adopt() to return a boolean since it is only used to check
if a device has preserved state.

Opportunistically fix the formatting on the static inline prototype of
pci_liveupdate_reclaim_resource() as well.

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Chris Li <chrisl@kernel.org>
---
 drivers/pci/pci.h | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 7af32edb128faef9c5e2665ca5055374f7fd30ea..d092cea96dc22cca5d3526c720cfb8b330c47683 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1196,27 +1196,37 @@ static inline int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int inde
 	 PCI_CONF1_EXT_REG(reg))
 
 #ifdef CONFIG_LIVEUPDATE
-#define PCI_SER_GET(__pci_dev, __var, __def)			\
-	(__pci_dev->dev.lu.dev_state) ?				\
-	((struct pci_dev_ser *)__pci_dev->dev.lu.dev_state)->__var : __def
-
 void pci_liveupdate_restore(struct pci_dev *dev);
 void pci_liveupdate_override_driver(struct pci_dev *dev);
-static inline struct pci_dev_ser *pci_lu_adopt(struct pci_dev *dev)
+static inline struct pci_dev_ser *to_pci_dev_ser(struct pci_dev *dev)
+{
+	return dev->dev.lu.dev_state;
+}
+static inline bool pci_lu_adopt(struct pci_dev *dev)
 {
-	return dev->dev.lu.requested ? dev->dev.lu.dev_state : NULL;
+	return dev->dev.lu.requested && to_pci_dev_ser(dev);
 }
 int pci_liveupdate_reclaim_resource(struct pci_dev *dev);
 #else
-#define PCI_SER_GET(__dev, __var, __def) __def
-
 static inline void pci_liveupdate_restore(struct pci_dev *dev) {}
 static inline void pci_liveupdate_override_driver(struct pci_dev *dev) {}
-static inline struct pci_dev_ser *pci_lu_adopt(struct pci_dev *dev)
+static inline struct pci_dev_ser *to_pci_dev_ser(struct pci_dev *dev)
 {
 	return NULL;
 }
-static inline int pci_liveupdate_reclaim_resource(
-	struct pci_dev *dev) { return -ENXIO; }
+static inline bool pci_lu_adopt(struct pci_dev *dev)
+{
+	return false;
+}
+static inline int pci_liveupdate_reclaim_resource(struct pci_dev *dev)
+{
+	return -ENXIO;
+}
 #endif
+
+#define PCI_SER_GET(__pci_dev, __field, __default) ({			\
+	struct pci_dev_ser *__ser = to_pci_dev_ser(__pci_dev);		\
+									\
+	__ser ? __ser->__field : __default;				\
+})
 #endif /* DRIVERS_PCI_H */

-- 
2.50.1.487.gc89ff58d15-goog


