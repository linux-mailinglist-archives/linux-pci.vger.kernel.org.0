Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC6C728CE4
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2019 00:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388446AbfEWWZS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 May 2019 18:25:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36415 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388217AbfEWWZS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 May 2019 18:25:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id a3so3861294pgb.3
        for <linux-pci@vger.kernel.org>; Thu, 23 May 2019 15:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=e+gzea4mq6Lhz8t38uCHFgu0PdBdL9sAfjlAhdiA0rw=;
        b=N98c3a+lXL3ZVWFVNZovcooRdeOwqUhq7kqiGvUyQSZnEu9u3y5kP5Vz2KwopHVyU4
         jhh5rV//XAesCvXRhfAOkL+LxccA1MCNlR30rmobh+JreK8hN0x8tHhJr6RZrm2/NjGD
         mw0PhDDLgJatbMCRYhzgdsVVRKkz+VYbzB16BaaacnJrJekANLeNLiC5G7ku9hgOn5XG
         3z8w5JZjBwgjCqivttUddEHrEnvnZEXYbUqAN+e/WqCF6ZCiH61xYcW9ZoGCsKu8voeL
         BPBHaUwITJFzCTBPq6qBStaCE9hNYBhWP+TJK7HgdMNdnCbp7+hLF32hIIsMblmyNeAQ
         BkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e+gzea4mq6Lhz8t38uCHFgu0PdBdL9sAfjlAhdiA0rw=;
        b=OeFiDk5249FJEXzGh1O0YcwBtWgdU+i4l/dkA3HOcxApmNbPwJ74KV3yviD1yUPXb2
         DmiqzPLejEDg1yEQ6yq0fI8NwcualhcvFzWKZSV7wC7U3N4VeyyYF0sSShixbXIhtfBz
         PZQVlwjHoa6PjQDLEuyinum/eiWECH+lSqWt1L7YrgBnNof/dEE+WfMwULaVvraJ2fSQ
         1bwlZES6hXH5rtEuPRn85Fi4Whe5NmR+FPRCGPdhJcWxhoeFwUzo0Ix6KTbvexsK4CwJ
         klRxrXOPG0b2vM4i5E+GgZKyv2J7IcLkYyddyB6N8hd81sXz3ACyjecErgUq2whp7JjE
         9BXg==
X-Gm-Message-State: APjAAAVeMaagDD73C90151bU13eBlR12vqaygEImqK9GyImXq976NxOc
        HZQCfW4LcgFBv6LExK7D4r9XBkA+LeY=
X-Google-Smtp-Source: APXvYqzm/aKuJ85YoDR19v3jXPIuNT7ACvM8TOjRc9sgztVo+LG0zPx8Gl2eD9F3e7zZ9G8I26whEA==
X-Received: by 2002:a17:90a:b890:: with SMTP id o16mr4803595pjr.60.1558650315902;
        Thu, 23 May 2019 15:25:15 -0700 (PDT)
Received: from nuc7.sifive.com ([12.206.222.2])
        by smtp.gmail.com with ESMTPSA id t2sm414113pfh.166.2019.05.23.15.25.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 May 2019 15:25:15 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, bhelgaas@google.com,
        wen.yang99@zte.com.cn, kjlu@umn.edu,
        linux-riscv@lists.infradead.org, palmer@sifive.com,
        paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH] PCI: endpoint: Add DMA to Linux PCI EP Framework
Date:   Thu, 23 May 2019 15:24:18 -0700
Message-Id: <1558650258-15050-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch depends on patch the following patches:
[PATCH v2 1/2] tools: PCI: Fix broken pcitest compilation
[PATCH v2 2/2] tools: PCI: Fix compiler warning in pcitest

The Linux PCI Endpoint Framework currently does not support initiation of
DMA read and write operations. This patch extends the Linux PCI Endpoint
Framework by adding support for the user of pcitest to inititate DMA
read and write operations via PCIe endpoint controller drivers. This patch
provides the means but leaves it up to individual PCIe endpoint controller
drivers to implement DMA support, if desired.

This patch provides support for the pcitest user to instruct the endpoint
to initiate local DMA transfers consisting of single or linked-list blocks
into endpoint buffers using the endpoint DMA controller. It anticipates
that future patches would add support for the pcitest user to instruct
the endpoint to participate in remote DMA transfers initiated from the
root complex into endpoint buffers using the endpoint DMA controller.

This patch depends on the first two patches in its patchset to resolve
a pre-existing pcitest compilation error.

* Add -d flag to pcitest command line options so user can specify
that a read or write command should execute using local DMA to be
initiated by endpoint.

* Add -L flag to pcitest command line options so user can specify
that DMA operation should execute in linked-list mode.

* Add struct pcitest_dma for pcitest to communicate DMA options
from host userspace to pci_endpoint_test driver in host kernel
via two new ioctls PCITEST_WRITE_DMA and PCITEST_READ_DMA.

* Add command flags so pci_endpoint_test driver running on host
can communicate DMA read and write options across the PCI bus 
to pci-epf-test driver running on endpoint.

* Add struct pci_epc_dma so pci-epf-test driver can create DMA
read and write descriptors for single or linked-list DMA operations
and pass such descriptors to pci-epc-core via new functions
pci_epc_dma_read() and pci_epc_dma_write().

* Add four new functions in pci-epf-test driver to implement
new DMA read and write tests by initiating local DMA transfers
in linked-list and single modes via PCIe endpoint controller
drivers: pci_epf_test_read_dma(), pci_epf_test_read_dma_list(),
pci_epf_test_write_dma(), and pci_epf_test_write_dma_list().

* Add dma_read and dma_write functions to struct pci_epc_ops
so pci_epc_dma_read() and pci_epc_dma_write() functions can
pass DMA descriptors down the stack to pcie-designware-ep layer.

* Add dma_read and dma_write functions to struct dw_pcie_ep_ops
so pcie-designware-ep layer can communicate DMA descriptors down
the stack to vendor PCIe endpoint controller drivers.

* Add dma_base pointer to struct dw_pcie for vendor PCIe endpoint
controller driver to set if it implements DMA operations.

* Add two common pcie-designware functions dw_pcie_writel_dma()
and dw_pcie_readl_dma() for use by vendor PCIe endpoint
controllers to access DMA registers via the dma_base pointer.

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
---
 drivers/misc/pci_endpoint_test.c                |  72 +++++++-
 drivers/pci/controller/dwc/pcie-designware-ep.c |  22 +++
 drivers/pci/controller/dwc/pcie-designware.h    |  13 ++
 drivers/pci/endpoint/functions/pci-epf-test.c   | 211 +++++++++++++++++++++++-
 drivers/pci/endpoint/pci-epc-core.c             |  46 ++++++
 include/linux/pci-epc.h                         |  45 +++++
 include/uapi/linux/pcitest.h                    |   7 +
 tools/pci/pcitest.c                             |  29 +++-
 8 files changed, 432 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 7b015f2a1c6f..63b86d81a6b5 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -34,6 +34,7 @@
 #include <linux/pci_regs.h>
 
 #include <uapi/linux/pcitest.h>
+#include <linux/uaccess.h>
 
 #define DRV_MODULE_NAME				"pci-endpoint-test"
 
@@ -51,6 +52,25 @@
 #define COMMAND_READ				BIT(3)
 #define COMMAND_WRITE				BIT(4)
 #define COMMAND_COPY				BIT(5)
+#define COMMAND_FLAG2				BIT(30)
+#define COMMAND_FLAG1				BIT(31)
+
+#define COMMAND_FLAGS				(COMMAND_FLAG1 | \
+						 COMMAND_FLAG2)
+
+#define COMMAND_FLAG_NONE			0
+#define COMMAND_FLAG_DMA			COMMAND_FLAG1
+#define COMMAND_FLAG_DMA_LIST			COMMAND_FLAG2
+
+#define COMMAND_READ_DMA			(COMMAND_READ | \
+						 COMMAND_FLAG_DMA)
+#define COMMAND_READ_DMA_LIST			(COMMAND_READ_DMA | \
+						 COMMAND_FLAG_DMA_LIST)
+
+#define COMMAND_WRITE_DMA			(COMMAND_WRITE | \
+						 COMMAND_FLAG_DMA)
+#define COMMAND_WRITE_DMA_LIST			(COMMAND_WRITE_DMA | \
+						 COMMAND_FLAG_DMA_LIST)
 
 #define PCI_ENDPOINT_TEST_STATUS		0x8
 #define STATUS_READ_SUCCESS			BIT(0)
@@ -425,7 +445,9 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
 	return ret;
 }
 
-static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
+static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
+				    size_t size,
+				    u32 flags)
 {
 	bool ret = false;
 	u32 reg;
@@ -480,7 +502,7 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
-				 COMMAND_READ);
+				 COMMAND_READ | flags);
 
 	wait_for_completion(&test->irq_raised);
 
@@ -494,7 +516,24 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
 	return ret;
 }
 
-static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
+static bool pci_endpoint_test_write_dma(struct pci_endpoint_test *test,
+					unsigned long arg)
+{
+	u32 flags = COMMAND_FLAG_DMA;
+	struct pcitest_dma dma;
+
+	if (copy_from_user(&dma, (void *)arg, sizeof(struct pcitest_dma)))
+		return -EACCES;
+
+	if (dma.list)
+		flags |= COMMAND_FLAG_DMA_LIST;
+
+	return pci_endpoint_test_write(test, dma.size, flags);
+}
+
+static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
+				   size_t size,
+				   u32 flags)
 {
 	bool ret = false;
 	void *addr;
@@ -542,7 +581,7 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
-				 COMMAND_WRITE);
+				 COMMAND_WRITE | flags);
 
 	wait_for_completion(&test->irq_raised);
 
@@ -555,6 +594,21 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
 	return ret;
 }
 
+static bool pci_endpoint_test_read_dma(struct pci_endpoint_test *test,
+				       unsigned long arg)
+{
+	u32 flags = COMMAND_FLAG_DMA;
+	struct pcitest_dma dma;
+
+	if (copy_from_user(&dma, (void *)arg, sizeof(struct pcitest_dma)))
+		return -EACCES;
+
+	if (dma.list)
+		flags |= COMMAND_FLAG_DMA_LIST;
+
+	return pci_endpoint_test_read(test, dma.size, flags);
+}
+
 static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 				      int req_irq_type)
 {
@@ -612,11 +666,17 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	case PCITEST_MSIX:
 		ret = pci_endpoint_test_msi_irq(test, arg, cmd == PCITEST_MSIX);
 		break;
+	case PCITEST_WRITE_DMA:
+		ret = pci_endpoint_test_write_dma(test, arg);
+		break;
+	case PCITEST_READ_DMA:
+		ret = pci_endpoint_test_read_dma(test, arg);
+		break;
 	case PCITEST_WRITE:
-		ret = pci_endpoint_test_write(test, arg);
+		ret = pci_endpoint_test_write(test, arg, COMMAND_FLAG_NONE);
 		break;
 	case PCITEST_READ:
-		ret = pci_endpoint_test_read(test, arg);
+		ret = pci_endpoint_test_read(test, arg, COMMAND_FLAG_NONE);
 		break;
 	case PCITEST_COPY:
 		ret = pci_endpoint_test_copy(test, arg);
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 2bf5a35c0570..7e25c0f5edf1 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -366,6 +366,26 @@ dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no)
 	return ep->ops->get_features(ep);
 }
 
+static int dw_pcie_ep_dma_read(struct pci_epc *epc, struct pci_epc_dma *dma)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+
+	if (!ep->ops->dma_read)
+		return -EINVAL;
+
+	return ep->ops->dma_read(ep, dma);
+}
+
+static int dw_pcie_ep_dma_write(struct pci_epc *epc, struct pci_epc_dma *dma)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+
+	if (!ep->ops->dma_write)
+		return -EINVAL;
+
+	return ep->ops->dma_write(ep, dma);
+}
+
 static const struct pci_epc_ops epc_ops = {
 	.write_header		= dw_pcie_ep_write_header,
 	.set_bar		= dw_pcie_ep_set_bar,
@@ -380,6 +400,8 @@ static const struct pci_epc_ops epc_ops = {
 	.start			= dw_pcie_ep_start,
 	.stop			= dw_pcie_ep_stop,
 	.get_features		= dw_pcie_ep_get_features,
+	.dma_read		= dw_pcie_ep_dma_read,
+	.dma_write		= dw_pcie_ep_dma_write
 };
 
 int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index b8993f2b78df..11d44ec8acc7 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -197,6 +197,8 @@ struct dw_pcie_ep_ops {
 	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
 			     enum pci_epc_irq_type type, u16 interrupt_num);
 	const struct pci_epc_features* (*get_features)(struct dw_pcie_ep *ep);
+	int	(*dma_read)(struct dw_pcie_ep *ep, struct pci_epc_dma *dma);
+	int	(*dma_write)(struct dw_pcie_ep *ep, struct pci_epc_dma *dma);
 };
 
 struct dw_pcie_ep {
@@ -238,6 +240,7 @@ struct dw_pcie {
 	void __iomem		*dbi_base2;
 	/* Used when iatu_unroll_enabled is true */
 	void __iomem		*atu_base;
+	void __iomem		*dma_base;
 	u32			num_viewport;
 	u8			iatu_unroll_enabled;
 	struct pcie_port	pp;
@@ -323,6 +326,16 @@ static inline u32 dw_pcie_readl_atu(struct dw_pcie *pci, u32 reg)
 	return __dw_pcie_read_dbi(pci, pci->atu_base, reg, 0x4);
 }
 
+static inline void dw_pcie_writel_dma(struct dw_pcie *pci, u32 reg, u32 val)
+{
+	__dw_pcie_write_dbi(pci, pci->dma_base, reg, 0x4, val);
+}
+
+static inline u32 dw_pcie_readl_dma(struct dw_pcie *pci, u32 reg)
+{
+	return __dw_pcie_read_dbi(pci, pci->dma_base, reg, 0x4);
+}
+
 static inline void dw_pcie_dbi_ro_wr_en(struct dw_pcie *pci)
 {
 	u32 reg;
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 27806987e93b..3910073712e9 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -28,6 +28,25 @@
 #define COMMAND_READ			BIT(3)
 #define COMMAND_WRITE			BIT(4)
 #define COMMAND_COPY			BIT(5)
+#define COMMAND_FLAG2			BIT(30)
+#define COMMAND_FLAG1			BIT(31)
+
+#define COMMAND_FLAGS			(COMMAND_FLAG1 | \
+					 COMMAND_FLAG2)
+
+#define COMMAND_FLAG_NONE		0
+#define COMMAND_FLAG_DMA		COMMAND_FLAG1
+#define COMMAND_FLAG_DMA_LIST		COMMAND_FLAG2
+
+#define COMMAND_READ_DMA		(COMMAND_READ | \
+					 COMMAND_FLAG_DMA)
+#define COMMAND_READ_DMA_LIST		(COMMAND_READ_DMA | \
+					 COMMAND_FLAG_DMA_LIST)
+
+#define COMMAND_WRITE_DMA		(COMMAND_WRITE | \
+					 COMMAND_FLAG_DMA)
+#define COMMAND_WRITE_DMA_LIST		(COMMAND_WRITE_DMA | \
+					 COMMAND_FLAG_DMA_LIST)
 
 #define STATUS_READ_SUCCESS		BIT(0)
 #define STATUS_READ_FAIL		BIT(1)
@@ -187,6 +206,93 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 	return ret;
 }
 
+static int pci_epf_test_read_dma(struct pci_epf_test *epf_test)
+{
+	int ret = -ENOMEM;
+	struct pci_epf *epf = epf_test->epf;
+	struct device *dev = &epf->dev;
+	struct pci_epc *epc = epf->epc;
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+	struct pci_epc_dma dma;
+	u32 crc32;
+	void *buf;
+
+	buf = kzalloc(reg->size, GFP_KERNEL);
+	if (buf) {
+		dma.control = PCI_EPC_DMA_CONTROL_LIE;
+		dma.size = reg->size;
+		dma.sar = reg->src_addr;
+		dma.dar = virt_to_phys(buf);
+
+		ret = pci_epc_dma_read(epc, &dma);
+		if (ret) {
+			dev_err(dev, "pci_epc_dma_read %d\n", ret);
+		} else {
+			crc32 = crc32_le(~0, buf, reg->size);
+			if (crc32 != reg->checksum)
+				ret = -EIO;
+		}
+
+		kfree(buf);
+	}
+
+	return ret;
+}
+
+static int pci_epf_test_read_dma_list(struct pci_epf_test *epf_test)
+{
+	int ret = -ENOMEM;
+	struct pci_epf *epf = epf_test->epf;
+	struct device *dev = &epf->dev;
+	struct pci_epc *epc = epf->epc;
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+	struct pci_epc_dma *dma;
+	u32 crc32;
+	void *buf;
+
+	dma = kcalloc(3, sizeof(*dma), GFP_KERNEL);
+	if (dma) {
+		buf = kzalloc(reg->size, GFP_KERNEL);
+		if (buf) {
+			int half_size = reg->size >> 1;
+			phys_addr_t phys_addr = virt_to_phys(buf);
+
+			dma[0].control = PCI_EPC_DMA_CONTROL_CB;
+			dma[0].size = half_size ? half_size : 1;
+			dma[0].sar = reg->src_addr;
+			dma[0].dar = phys_addr;
+
+			dma[1].control = PCI_EPC_DMA_CONTROL_CB |
+					 PCI_EPC_DMA_CONTROL_LIE;
+			dma[1].size = reg->size - half_size;
+			dma[1].sar = reg->src_addr + half_size;
+			dma[1].dar = phys_addr + half_size;
+
+			dma[2].control = PCI_EPC_DMA_CONTROL_EOL;
+			dma[2].size = 0;
+			dma[2].sar = virt_to_phys(dma);
+			dma[2].dar = 0;
+
+			ret = pci_epc_dma_read(epc, dma);
+			if (ret) {
+				dev_err(dev, "pci_epc_dma_read %d\n", ret);
+			} else {
+				crc32 = crc32_le(~0, buf, reg->size);
+				if (crc32 != reg->checksum)
+					ret = -EIO;
+			}
+
+			kfree(buf);
+		}
+
+		kfree(dma);
+	}
+
+	return ret;
+}
+
 static int pci_epf_test_write(struct pci_epf_test *epf_test)
 {
 	int ret;
@@ -244,6 +350,87 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	return ret;
 }
 
+static int pci_epf_test_write_dma(struct pci_epf_test *epf_test)
+{
+	int ret = -ENOMEM;
+	struct pci_epf *epf = epf_test->epf;
+	struct device *dev = &epf->dev;
+	struct pci_epc *epc = epf->epc;
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+	struct pci_epc_dma dma;
+	void *buf;
+
+	buf = kzalloc(reg->size, GFP_KERNEL);
+	if (buf) {
+		get_random_bytes(buf, reg->size);
+		reg->checksum = crc32_le(~0, buf, reg->size);
+
+		dma.control = PCI_EPC_DMA_CONTROL_LIE;
+		dma.size = reg->size;
+		dma.sar = virt_to_phys(buf);
+		dma.dar = reg->dst_addr;
+
+		ret = pci_epc_dma_write(epc, &dma);
+		if (ret)
+			dev_err(dev, "pci_epc_dma_write %d\n", ret);
+
+		kfree(buf);
+	}
+
+	return ret;
+}
+
+static int pci_epf_test_write_dma_list(struct pci_epf_test *epf_test)
+{
+	int ret = -ENOMEM;
+	struct pci_epf *epf = epf_test->epf;
+	struct device *dev = &epf->dev;
+	struct pci_epc *epc = epf->epc;
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+	struct pci_epc_dma *dma;
+	void *buf;
+
+	dma = kcalloc(3, sizeof(*dma), GFP_KERNEL);
+	if (dma) {
+		buf = kzalloc(reg->size, GFP_KERNEL);
+		if (buf) {
+			int half_size = reg->size >> 1;
+			phys_addr_t phys_addr = virt_to_phys(buf);
+
+			get_random_bytes(buf, reg->size);
+			reg->checksum = crc32_le(~0, buf, reg->size);
+
+			dma[0].control = PCI_EPC_DMA_CONTROL_CB;
+			dma[0].size = half_size ? half_size : 1;
+			dma[0].sar = phys_addr;
+			dma[0].dar = reg->dst_addr;
+
+			dma[1].control = PCI_EPC_DMA_CONTROL_CB |
+					 PCI_EPC_DMA_CONTROL_LIE;
+			dma[1].size = reg->size - half_size;
+			dma[1].sar = phys_addr + half_size;
+			dma[1].dar = reg->dst_addr + half_size;
+
+			dma[2].control = PCI_EPC_DMA_CONTROL_EOL;
+			dma[2].size = 0;
+			dma[2].sar = virt_to_phys(dma);
+			dma[2].dar = 0;
+
+			ret = pci_epc_dma_write(epc, dma);
+			if (ret)
+				dev_err(dev, "pci_epc_dma_write %d\n", ret);
+
+			kfree(buf);
+		}
+
+		kfree(dma);
+	}
+
+	return ret;
+}
+
 static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test, u8 irq_type,
 				   u16 irq)
 {
@@ -303,18 +490,34 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 	}
 
 	if (command & COMMAND_WRITE) {
-		ret = pci_epf_test_write(epf_test);
-		if (ret)
-			reg->status |= STATUS_WRITE_FAIL;
+		command &= (COMMAND_WRITE | COMMAND_FLAGS);
+		if (command == COMMAND_WRITE)
+			ret = pci_epf_test_write(epf_test);
+		else if (command == COMMAND_WRITE_DMA)
+			ret = pci_epf_test_write_dma(epf_test);
+		else if (command == COMMAND_WRITE_DMA_LIST)
+			ret = pci_epf_test_write_dma_list(epf_test);
 		else
+			ret = -EINVAL;
+		if (!ret)
 			reg->status |= STATUS_WRITE_SUCCESS;
+		else
+			reg->status |= STATUS_WRITE_FAIL;
 		pci_epf_test_raise_irq(epf_test, reg->irq_type,
 				       reg->irq_number);
 		goto reset_handler;
 	}
 
 	if (command & COMMAND_READ) {
-		ret = pci_epf_test_read(epf_test);
+		command &= (COMMAND_READ | COMMAND_FLAGS);
+		if (command == COMMAND_READ)
+			ret = pci_epf_test_read(epf_test);
+		else if (command == COMMAND_READ_DMA)
+			ret = pci_epf_test_read_dma(epf_test);
+		else if (command == COMMAND_READ_DMA_LIST)
+			ret = pci_epf_test_read_dma_list(epf_test);
+		else
+			ret = -EINVAL;
 		if (!ret)
 			reg->status |= STATUS_READ_SUCCESS;
 		else
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index e4712a0f249c..a57e501d4abc 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -107,6 +107,52 @@ unsigned int pci_epc_get_first_free_bar(const struct pci_epc_features
 EXPORT_SYMBOL_GPL(pci_epc_get_first_free_bar);
 
 /**
+ * pci_epc_dma_write() - DMA a block of memory to remote address
+ * @epc: the EPC device on which to perform DMA transfer
+ * @dma: DMA descriptors array
+ *
+ * Write contents of local memory to remote memory by DMA.
+ */
+int pci_epc_dma_write(struct pci_epc *epc, struct pci_epc_dma *dma)
+{
+	int ret;
+	unsigned long flags;
+
+	if (IS_ERR(epc) || !epc->ops->dma_write)
+		return -EINVAL;
+
+	spin_lock_irqsave(&epc->lock, flags);
+	ret = epc->ops->dma_write(epc, dma);
+	spin_unlock_irqrestore(&epc->lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epc_dma_write);
+
+/**
+ * pci_epc_dma_read() - DMA a block of memory from remote address
+ * @epc: the EPC device on which to perform DMA transfer
+ * @dma: DMA descriptors array
+ *
+ * Read contents of remote memory into local memory by DMA.
+ */
+int pci_epc_dma_read(struct pci_epc *epc, struct pci_epc_dma *dma)
+{
+	int ret;
+	unsigned long flags;
+
+	if (IS_ERR(epc) || !epc->ops->dma_read)
+		return -EINVAL;
+
+	spin_lock_irqsave(&epc->lock, flags);
+	ret = epc->ops->dma_read(epc, dma);
+	spin_unlock_irqrestore(&epc->lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epc_dma_read);
+
+/**
  * pci_epc_get_features() - get the features supported by EPC
  * @epc: the features supported by *this* EPC device will be returned
  * @func_no: the features supported by the EPC device specific to the
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index f641badc2c61..d845f13d0baf 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -21,6 +21,45 @@ enum pci_epc_irq_type {
 };
 
 /**
+ * struct pci_epc_dma - descriptor for a DMA transfer element
+ * @control: DMA channel control bits for read or write transfer
+ * @size: size of DMA transfer element
+ * @sar: source addrees for DMA transfer element
+ * @dar: destination address for DMA transfer element
+ */
+
+struct pci_epc_dma {
+	u32	control;
+	u32	size;
+	u64	sar;
+	u64	dar;
+};
+
+#define PCI_EPC_DMA_CONTROL_CB          (BIT(0))
+#define PCI_EPC_DMA_CONTROL_TCB         (BIT(1))
+#define PCI_EPC_DMA_CONTROL_LLP         (BIT(2))
+#define PCI_EPC_DMA_CONTROL_LIE         (BIT(3))
+#define PCI_EPC_DMA_CONTROL_RIE         (BIT(4))
+#define PCI_EPC_DMA_CONTROL_CS          (BIT(5) | BIT(6))
+#define PCI_EPC_DMA_CONTROL_CCS         (BIT(8))
+#define PCI_EPC_DMA_CONTROL_LLE         (BIT(9))
+#define PCI_EPC_DMA_CONTROL_FUNC        (BIT(12) | BIT(13) | BIT(14) | \
+					 BIT(15) | BIT(16))
+#define PCI_EPC_DMA_CONTROL_NS_DST      (BIT(23))
+#define PCI_EPC_DMA_CONTROL_NS_SRC      (BIT(24))
+#define PCI_EPC_DMA_CONTROL_RO          (BIT(25))
+#define PCI_EPC_DMA_CONTROL_TC          (BIT(27) | BIT(28) | BIT(29))
+#define PCI_EPC_DMA_CONTROL_AT          (BIT(30) | BIT(31))
+
+#define PCI_EPC_DMA_CONTROL_EOL         (PCI_EPC_DMA_CONTROL_TCB | \
+					 PCI_EPC_DMA_CONTROL_LLP)
+
+#define PCI_EPC_DMA_CONTROL_LIST        (PCI_EPC_DMA_CONTROL_CB | \
+					 PCI_EPC_DMA_CONTROL_EOL| \
+					 PCI_EPC_DMA_CONTROL_CCS | \
+					 PCI_EPC_DMA_CONTROL_LLE)
+
+/**
  * struct pci_epc_ops - set of function pointers for performing EPC operations
  * @write_header: ops to populate configuration space header
  * @set_bar: ops to configure the BAR
@@ -38,6 +77,8 @@ enum pci_epc_irq_type {
  * @raise_irq: ops to raise a legacy, MSI or MSI-X interrupt
  * @start: ops to start the PCI link
  * @stop: ops to stop the PCI link
+ * @dma_read: ops to read remote memory into local memory by DMA
+ * @dma_write: ops to write local memory to remote memory by DMA
  * @owner: the module owner containing the ops
  */
 struct pci_epc_ops {
@@ -61,6 +102,8 @@ struct pci_epc_ops {
 	void	(*stop)(struct pci_epc *epc);
 	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
 						       u8 func_no);
+	int	(*dma_read)(struct pci_epc *epc, struct pci_epc_dma *dma);
+	int	(*dma_write)(struct pci_epc *epc, struct pci_epc_dma *dma);
 	struct module *owner;
 };
 
@@ -152,6 +195,8 @@ void pci_epc_destroy(struct pci_epc *epc);
 int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf);
 void pci_epc_linkup(struct pci_epc *epc);
 void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf);
+int pci_epc_dma_read(struct pci_epc *epc, struct pci_epc_dma *dma);
+int pci_epc_dma_write(struct pci_epc *epc, struct pci_epc_dma *dma);
 int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
 			 struct pci_epf_header *hdr);
 int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index cbf422e56696..505f4a3811c2 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -10,11 +10,18 @@
 #ifndef __UAPI_LINUX_PCITEST_H
 #define __UAPI_LINUX_PCITEST_H
 
+struct pcitest_dma {
+	size_t	size;
+	bool	list;
+};
+
 #define PCITEST_BAR		_IO('P', 0x1)
 #define PCITEST_LEGACY_IRQ	_IO('P', 0x2)
 #define PCITEST_MSI		_IOW('P', 0x3, int)
 #define PCITEST_WRITE		_IOW('P', 0x4, unsigned long)
+#define PCITEST_WRITE_DMA	_IOW('P', 0x4, struct pcitest_dma)
 #define PCITEST_READ		_IOW('P', 0x5, unsigned long)
+#define PCITEST_READ_DMA	_IOW('P', 0x5, struct pcitest_dma)
 #define PCITEST_COPY		_IOW('P', 0x6, unsigned long)
 #define PCITEST_MSIX		_IOW('P', 0x7, int)
 #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 6f1303104d84..66cd19acf18c 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -44,11 +44,14 @@ struct pci_test {
 	bool		read;
 	bool		write;
 	bool		copy;
+	bool		dma;
+	bool		dma_list;
 	unsigned long	size;
 };
 
 static int run_test(struct pci_test *test)
 {
+	struct pcitest_dma dma;
 	int ret = -EINVAL;
 	int fd;
 
@@ -113,7 +116,13 @@ static int run_test(struct pci_test *test)
 	}
 
 	if (test->write) {
-		ret = ioctl(fd, PCITEST_WRITE, test->size);
+		if (test->dma) {
+			dma.size = test->size;
+			dma.list = test->dma_list;
+			ret = ioctl(fd, PCITEST_WRITE_DMA, &dma);
+		} else {
+			ret = ioctl(fd, PCITEST_WRITE, test->size);
+		}
 		fprintf(stdout, "WRITE (%7ld bytes):\t\t", test->size);
 		if (ret < 0)
 			fprintf(stdout, "TEST FAILED\n");
@@ -122,7 +131,13 @@ static int run_test(struct pci_test *test)
 	}
 
 	if (test->read) {
-		ret = ioctl(fd, PCITEST_READ, test->size);
+		if (test->dma) {
+			dma.size = test->size;
+			dma.list = test->dma_list;
+			ret = ioctl(fd, PCITEST_READ_DMA, &dma);
+		} else {
+			ret = ioctl(fd, PCITEST_READ, test->size);
+		}
 		fprintf(stdout, "READ (%7ld bytes):\t\t", test->size);
 		if (ret < 0)
 			fprintf(stdout, "TEST FAILED\n");
@@ -163,7 +178,7 @@ int main(int argc, char **argv)
 	/* set default endpoint device */
 	test->device = "/dev/pci-endpoint-test.0";
 
-	while ((c = getopt(argc, argv, "D:b:m:x:i:Ilhrwcs:")) != EOF)
+	while ((c = getopt(argc, argv, "D:b:m:x:i:IlhrwcdLs:")) != EOF)
 	switch (c) {
 	case 'D':
 		test->device = optarg;
@@ -204,6 +219,12 @@ int main(int argc, char **argv)
 	case 'c':
 		test->copy = true;
 		continue;
+	case 'd':
+		test->dma = true;
+		continue;
+	case 'L':
+		test->dma_list = true;
+		continue;
 	case 's':
 		test->size = strtoul(optarg, NULL, 0);
 		continue;
@@ -223,6 +244,8 @@ int main(int argc, char **argv)
 			"\t-r			Read buffer test\n"
 			"\t-w			Write buffer test\n"
 			"\t-c			Copy buffer test\n"
+			"\t-d			DMA mode for read or write test\n"
+			"\t-L			Linked-List DMA flag for DMA mode\n"
 			"\t-s <size>		Size of buffer {default: 100KB}\n"
 			"\t-h			Print this help message\n",
 			argv[0]);
-- 
2.7.4

