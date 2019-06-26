Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96C725692D
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2019 14:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfFZM3P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jun 2019 08:29:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42744 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbfFZM1w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jun 2019 08:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jJLN4PQyh+NiJMk0GjPmnktfOIwnazdB1WyLd+EwQBI=; b=AoPkQ1Ya+GVeIiAkwNrcOY3WXy
        sAhllTHY9EgHAAks54i/wuled6yq4/SYKn1NbwYo04wuJLkW52WmxaNmHyzJwOIaCd1GOvXiEtOFh
        ThHQsj3EyWPwSyeHernbRDYWFXPuc50UnHzB/Ux1T9z32tWTuakN3Zxrkm+83YlNJ6VlyDhXoVpV0
        swGfUgPd+voS9n+3QCOoIUtQgxulHB6VDtuaVG04iQieR5ANlKAx/Sb/w9GgYjty+E8OOcprpShvj
        UdtX/dRdsOG235kDLoTkXHXo33rFg+7/1zOnF3ap3zxhTo4sRT+LAOqrSL+ve8dTmWYfKoZdPNkJ2
        oG9lwaoA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hg71g-0001O4-Pe; Wed, 26 Jun 2019 12:27:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/25] memremap: validate the pagemap type passed to devm_memremap_pages
Date:   Wed, 26 Jun 2019 14:27:07 +0200
Message-Id: <20190626122724.13313-9-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626122724.13313-1-hch@lst.de>
References: <20190626122724.13313-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Most pgmap types are only supported when certain config options are
enabled.  Check for a type that is valid for the current configuration
before setting up the pagemap.  For this the usage of the 0 type for
device dax gets replaced with an explicit MEMORY_DEVICE_DEVDAX type.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/dax/device.c     |  1 +
 include/linux/memremap.h |  8 ++++++++
 kernel/memremap.c        | 22 ++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 8465d12fecba..79014baa782d 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -468,6 +468,7 @@ int dev_dax_probe(struct device *dev)
 	dev_dax->pgmap.ref = &dev_dax->ref;
 	dev_dax->pgmap.kill = dev_dax_percpu_kill;
 	dev_dax->pgmap.cleanup = dev_dax_percpu_exit;
+	dev_dax->pgmap.type = MEMORY_DEVICE_DEVDAX;
 	addr = devm_memremap_pages(dev, &dev_dax->pgmap);
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 995c62c5a48b..0c86f2c5ac9c 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -45,13 +45,21 @@ struct vmem_altmap {
  * wakeup is used to coordinate physical address space management (ex:
  * fs truncate/hole punch) vs pinned pages (ex: device dma).
  *
+ * MEMORY_DEVICE_DEVDAX:
+ * Host memory that has similar access semantics as System RAM i.e. DMA
+ * coherent and supports page pinning. In contrast to
+ * MEMORY_DEVICE_FS_DAX, this memory is access via a device-dax
+ * character device.
+ *
  * MEMORY_DEVICE_PCI_P2PDMA:
  * Device memory residing in a PCI BAR intended for use with Peer-to-Peer
  * transactions.
  */
 enum memory_type {
+	/* 0 is reserved to catch uninitialized type fields */
 	MEMORY_DEVICE_PRIVATE = 1,
 	MEMORY_DEVICE_FS_DAX,
+	MEMORY_DEVICE_DEVDAX,
 	MEMORY_DEVICE_PCI_P2PDMA,
 };
 
diff --git a/kernel/memremap.c b/kernel/memremap.c
index 6e1970719dc2..abda62d1e5a3 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -157,6 +157,28 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 	pgprot_t pgprot = PAGE_KERNEL;
 	int error, nid, is_ram;
 
+	switch (pgmap->type) {
+	case MEMORY_DEVICE_PRIVATE:
+		if (!IS_ENABLED(CONFIG_DEVICE_PRIVATE)) {
+			WARN(1, "Device private memory not supported\n");
+			return ERR_PTR(-EINVAL);
+		}
+		break;
+	case MEMORY_DEVICE_FS_DAX:
+		if (!IS_ENABLED(CONFIG_ZONE_DEVICE) ||
+		    IS_ENABLED(CONFIG_FS_DAX_LIMITED)) {
+			WARN(1, "File system DAX not supported\n");
+			return ERR_PTR(-EINVAL);
+		}
+		break;
+	case MEMORY_DEVICE_DEVDAX:
+	case MEMORY_DEVICE_PCI_P2PDMA:
+		break;
+	default:
+		WARN(1, "Invalid pgmap type %d\n", pgmap->type);
+		break;
+	}
+
 	if (!pgmap->ref || !pgmap->kill || !pgmap->cleanup) {
 		WARN(1, "Missing reference count teardown definition\n");
 		return ERR_PTR(-EINVAL);
-- 
2.20.1

