Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4754B6894BE
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 11:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjBCKFB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 05:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbjBCKEx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 05:04:53 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3ED2202E
        for <linux-pci@vger.kernel.org>; Fri,  3 Feb 2023 02:04:38 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id z1so3168143pfg.12
        for <linux-pci@vger.kernel.org>; Fri, 03 Feb 2023 02:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjcd+Oav0UBf7mF+MYUjzAhzd7Tic9squ8cey9gaJ5E=;
        b=ThLyZEMs5MpZFZwPqY0NLPfCasQMJUPGmqHeF2lg8Zxyk9eydG5QL1/19biFSQMuNh
         cwJaViWMh/eInwndgugBtyEb2HXciI6TDZoSOZsLdlhnbkAigQe68tzq196AyyQnvwtQ
         ERabOd6Ot5Z3u8MqoFkVg2eksuQbknF+NYybq3A+ZGXHmbC0t2RwZdFjmmPuQqH9BBdn
         4t2SoDke11SXIjKJMtbY/J7nnOQpfyDboE8NHeORDNdfvm//dO7iUxbWGVle5wfjdWmm
         lV9DsvV4xCcksTJoLkrhEt9y+gisJQGs/Tf/tTXl4TsYa1YBkYegOm292cpEZfTkY4vK
         uHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjcd+Oav0UBf7mF+MYUjzAhzd7Tic9squ8cey9gaJ5E=;
        b=XbeDCr17Vi/37K9bw3KVITIIMkC9/4WycoJhBjbqcHp5dUEuC5lFCz9L621TAHEjuB
         //zFWlUODhEyEmrZ3dOzVPx7ZpajR+KJXKx3p+xwc6DrLuht/p/CHUVD7WOKwTDj8Ixd
         aIUIAZJvHWUeLsO8qYQU2nVG7L0MaWaBMcXvVBgJxLiZJHJ+qYhPsXXsSywreQFZBiyu
         5W3pdOdRLBqn2pyCqlUBHUvMVj6SCAT7nuSppcWcFVss2ppQGx0gHUPTtJOAwCW9yssH
         YH+HZRwE4nCNB5VgheFqRU2pLFWrHbUT6krFTXz1B1laEe0EY6GkeZC0yhtOMJJ1gGZj
         MOgQ==
X-Gm-Message-State: AO0yUKVTpyEVkNmHiOThY20tlaumXyBzJ2mUKvAQnDjAKIjP/y/vauMJ
        vW3UVTEd3KPu8F8NMQuiXZVMkw==
X-Google-Smtp-Source: AK7set/Kj4wCo73JmugdcJhI0++p/hgbNoSnL0M6LUdA+Sx2OQD9zznOb3QIA6X99aX3bEGaycb6qA==
X-Received: by 2002:aa7:88c8:0:b0:594:1769:e9a0 with SMTP id k8-20020aa788c8000000b005941769e9a0mr12315216pff.17.1675418678084;
        Fri, 03 Feb 2023 02:04:38 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id d3-20020aa797a3000000b0058d8f23af26sm1278885pfq.157.2023.02.03.02.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 02:04:37 -0800 (PST)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Shunsuke Mie <mie@igel.co.jp>, Frank Li <Frank.Li@nxp.com>,
        Jon Mason <jdmason@kudzu.us>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Takanari Hayama <taki@igel.co.jp>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 3/4] PCI: endpoint: Introduce virtio library for EP functions
Date:   Fri,  3 Feb 2023 19:04:17 +0900
Message-Id: <20230203100418.2981144-4-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230203100418.2981144-1-mie@igel.co.jp>
References: <20230203100418.2981144-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a new library to access a virtio ring located on PCIe host memory. The
library generates struct pci_epf_vringh that is introduced in this patch.
The struct has a vringh member, so vringh APIs can be used to access the
virtio ring.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
Signed-off-by: Takanari Hayama <taki@igel.co.jp>
---
 drivers/pci/endpoint/Kconfig          |   7 ++
 drivers/pci/endpoint/Makefile         |   1 +
 drivers/pci/endpoint/pci-epf-virtio.c | 113 ++++++++++++++++++++++++++
 include/linux/pci-epf-virtio.h        |  25 ++++++
 4 files changed, 146 insertions(+)
 create mode 100644 drivers/pci/endpoint/pci-epf-virtio.c
 create mode 100644 include/linux/pci-epf-virtio.h

diff --git a/drivers/pci/endpoint/Kconfig b/drivers/pci/endpoint/Kconfig
index 17bbdc9bbde0..07276dcc43c8 100644
--- a/drivers/pci/endpoint/Kconfig
+++ b/drivers/pci/endpoint/Kconfig
@@ -28,6 +28,13 @@ config PCI_ENDPOINT_CONFIGFS
 	   configure the endpoint function and used to bind the
 	   function with a endpoint controller.
 
+config PCI_ENDPOINT_VIRTIO
+	tristate
+	depends on PCI_ENDPOINT
+	select VHOST_IOMEM
+	help
+	  TODO update this comment
+
 source "drivers/pci/endpoint/functions/Kconfig"
 
 endmenu
diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
index 95b2fe47e3b0..95712f0a13d1 100644
--- a/drivers/pci/endpoint/Makefile
+++ b/drivers/pci/endpoint/Makefile
@@ -4,5 +4,6 @@
 #
 
 obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
+obj-$(CONFIG_PCI_ENDPOINT_VIRTIO)	+= pci-epf-virtio.o
 obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
 					   pci-epc-mem.o functions/
diff --git a/drivers/pci/endpoint/pci-epf-virtio.c b/drivers/pci/endpoint/pci-epf-virtio.c
new file mode 100644
index 000000000000..7134ca407a03
--- /dev/null
+++ b/drivers/pci/endpoint/pci-epf-virtio.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Virtio library for PCI Endpoint function
+ */
+#include <linux/kernel.h>
+#include <linux/pci-epf-virtio.h>
+#include <linux/pci-epc.h>
+#include <linux/virtio_pci.h>
+
+static void __iomem *epf_virtio_map_vq(struct pci_epf *epf, u32 pfn,
+				       size_t size, phys_addr_t *vq_phys)
+{
+	int err;
+	phys_addr_t vq_addr;
+	size_t vq_size;
+	void __iomem *vq_virt;
+
+	vq_addr = (phys_addr_t)pfn << VIRTIO_PCI_QUEUE_ADDR_SHIFT;
+
+	vq_size = vring_size(size, VIRTIO_PCI_VRING_ALIGN) + 100;
+
+	vq_virt = pci_epc_mem_alloc_addr(epf->epc, vq_phys, vq_size);
+	if (!vq_virt) {
+		pr_err("Failed to allocate epc memory\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	err = pci_epc_map_addr(epf->epc, epf->func_no, epf->vfunc_no, *vq_phys,
+			       vq_addr, vq_size);
+	if (err) {
+		pr_err("Failed to map virtuqueue to local");
+		goto err_free;
+	}
+
+	return vq_virt;
+
+err_free:
+	pci_epc_mem_free_addr(epf->epc, *vq_phys, vq_virt, vq_size);
+
+	return ERR_PTR(err);
+}
+
+static void epf_virtio_unmap_vq(struct pci_epf *epf, void __iomem *vq_virt,
+				phys_addr_t vq_phys, size_t size)
+{
+	pci_epc_unmap_addr(epf->epc, epf->func_no, epf->vfunc_no, vq_phys);
+	pci_epc_mem_free_addr(epf->epc, vq_phys, vq_virt,
+			      vring_size(size, VIRTIO_PCI_VRING_ALIGN));
+}
+
+/**
+ * pci_epf_virtio_alloc_vringh() - allocate epf vringh from @pfn
+ * @epf: the EPF device that communicates to host virtio dirver
+ * @features: the virtio features of device
+ * @pfn: page frame number of virtqueue located on host memory. It is
+ *		passed during virtqueue negotiation.
+ * @size: a length of virtqueue
+ */
+struct pci_epf_vringh *pci_epf_virtio_alloc_vringh(struct pci_epf *epf,
+						   u64 features, u32 pfn,
+						   size_t size)
+{
+	int err;
+	struct vring vring;
+	struct pci_epf_vringh *evrh;
+
+	evrh = kmalloc(sizeof(*evrh), GFP_KERNEL);
+	if (!evrh) {
+		err = -ENOMEM;
+		goto err_unmap_vq;
+	}
+
+	evrh->size = size;
+
+	evrh->virt = epf_virtio_map_vq(epf, pfn, size, &evrh->phys);
+	if (IS_ERR(evrh->virt))
+		return evrh->virt;
+
+	vring_init(&vring, size, evrh->virt, VIRTIO_PCI_VRING_ALIGN);
+
+	err = vringh_init_iomem(&evrh->vrh, features, size, false, GFP_KERNEL,
+				vring.desc, vring.avail, vring.used);
+	if (err)
+		goto err_free_epf_vq;
+
+	return evrh;
+
+err_free_epf_vq:
+	kfree(evrh);
+
+err_unmap_vq:
+	epf_virtio_unmap_vq(epf, evrh->virt, evrh->phys, evrh->size);
+
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL_GPL(pci_epf_virtio_alloc_vringh);
+
+/**
+ * pci_epf_virtio_free_vringh() - release allocated epf vring
+ * @epf: the EPF device that communicates to host virtio dirver
+ * @evrh: epf vringh to free
+ */
+void pci_epf_virtio_free_vringh(struct pci_epf *epf,
+				struct pci_epf_vringh *evrh)
+{
+	epf_virtio_unmap_vq(epf, evrh->virt, evrh->phys, evrh->size);
+	kfree(evrh);
+}
+EXPORT_SYMBOL_GPL(pci_epf_virtio_free_vringh);
+
+MODULE_DESCRIPTION("PCI EP Virtio Library");
+MODULE_AUTHOR("Shunsuke Mie <mie@igel.co.jp>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/pci-epf-virtio.h b/include/linux/pci-epf-virtio.h
new file mode 100644
index 000000000000..ae09087919a9
--- /dev/null
+++ b/include/linux/pci-epf-virtio.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PCI Endpoint Function (EPF) for virtio definitions
+ */
+#ifndef __LINUX_PCI_EPF_VIRTIO_H
+#define __LINUX_PCI_EPF_VIRTIO_H
+
+#include <linux/types.h>
+#include <linux/vringh.h>
+#include <linux/pci-epf.h>
+
+struct pci_epf_vringh {
+	struct vringh vrh;
+	void __iomem *virt;
+	phys_addr_t phys;
+	size_t size;
+};
+
+struct pci_epf_vringh *pci_epf_virtio_alloc_vringh(struct pci_epf *epf,
+						   u64 features, u32 pfn,
+						   size_t size);
+void pci_epf_virtio_free_vringh(struct pci_epf *epf,
+				struct pci_epf_vringh *evrh);
+
+#endif // __LINUX_PCI_EPF_VIRTIO_H
-- 
2.25.1

