Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D0945DA64
	for <lists+linux-pci@lfdr.de>; Thu, 25 Nov 2021 13:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348643AbhKYMxT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Nov 2021 07:53:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:45580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353415AbhKYMvp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Nov 2021 07:51:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFF5D6113D;
        Thu, 25 Nov 2021 12:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637844399;
        bh=G2rKjdlzxb1XNs2lbCrBQXhcMuLp67aIGgdoCkybPjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eEq9SR3JH7/OWh15A1+wZOPKWoTqJbLSnrH+8yz3ixHgFXG37Tq+W1uFKWpszTXRq
         XlP4+1v9Q7gzV9LE9RXylQmGsaWIVLcxLg63XATtmj430LS1g4o4EDWAcGuwgYKCKK
         BpyzTsP4MMoujXGVuohFEClGOtXEsHizpDRIJuRm6RbyS9ILXJXPHyum4FH/zmvnNy
         5/G6MlhCqrSE5fREYPd7Xqxy/ciNCzznS+GxQq9G8PEO2QVWJ3WV8w3djJNE8mcfd6
         /G5Dx4JntuZvmVP6Wtj9vWJvBKnhkAqtdAYaQ9gUAidalAqqTSaOH5im36C3HPVcrC
         y7fTtPZz9q7Fg==
Received: by pali.im (Postfix)
        id 6EA43EDE; Thu, 25 Nov 2021 13:46:38 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/15] PCI: mvebu: Propagate errors when updating PCI_IO_BASE and PCI_MEM_BASE registers
Date:   Thu, 25 Nov 2021 13:45:58 +0100
Message-Id: <20211125124605.25915-9-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211125124605.25915-1-pali@kernel.org>
References: <20211125124605.25915-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Properly propagate failure from mvebu_pcie_add_windows() function back to
the caller mvebu_pci_bridge_emul_base_conf_write() and correctly updates
PCI_IO_BASE, PCI_MEM_BASE and PCI_IO_BASE_UPPER16 registers on error.
On error set base value higher than limit value which indicates that
address range is disabled. When IO is unsupported then let IO registers
zeroed as required by PCIe base specification.

Signed-off-by: Pali Rohár <pali@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-mvebu.c | 82 ++++++++++++++++++++----------
 1 file changed, 55 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index a0b661972436..12afa565bfcf 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -315,7 +315,7 @@ static void mvebu_pcie_del_windows(struct mvebu_pcie_port *port,
  * areas each having a power of two size. We start from the largest
  * one (i.e highest order bit set in the size).
  */
-static void mvebu_pcie_add_windows(struct mvebu_pcie_port *port,
+static int mvebu_pcie_add_windows(struct mvebu_pcie_port *port,
 				   unsigned int target, unsigned int attribute,
 				   phys_addr_t base, size_t size,
 				   phys_addr_t remap)
@@ -336,7 +336,7 @@ static void mvebu_pcie_add_windows(struct mvebu_pcie_port *port,
 				&base, &end, ret);
 			mvebu_pcie_del_windows(port, base - size_mapped,
 					       size_mapped);
-			return;
+			return ret;
 		}
 
 		size -= sz;
@@ -345,16 +345,20 @@ static void mvebu_pcie_add_windows(struct mvebu_pcie_port *port,
 		if (remap != MVEBU_MBUS_NO_REMAP)
 			remap += sz;
 	}
+
+	return 0;
 }
 
-static void mvebu_pcie_set_window(struct mvebu_pcie_port *port,
+static int mvebu_pcie_set_window(struct mvebu_pcie_port *port,
 				  unsigned int target, unsigned int attribute,
 				  const struct mvebu_pcie_window *desired,
 				  struct mvebu_pcie_window *cur)
 {
+	int ret;
+
 	if (desired->base == cur->base && desired->remap == cur->remap &&
 	    desired->size == cur->size)
-		return;
+		return 0;
 
 	if (cur->size != 0) {
 		mvebu_pcie_del_windows(port, cur->base, cur->size);
@@ -369,30 +373,35 @@ static void mvebu_pcie_set_window(struct mvebu_pcie_port *port,
 	}
 
 	if (desired->size == 0)
-		return;
+		return 0;
+
+	ret = mvebu_pcie_add_windows(port, target, attribute, desired->base,
+				     desired->size, desired->remap);
+	if (ret) {
+		cur->size = 0;
+		cur->base = 0;
+		return ret;
+	}
 
-	mvebu_pcie_add_windows(port, target, attribute, desired->base,
-			       desired->size, desired->remap);
 	*cur = *desired;
+	return 0;
 }
 
-static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
+static int mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
 {
 	struct mvebu_pcie_window desired = {};
 	struct pci_bridge_emul_conf *conf = &port->bridge.conf;
 
 	/* Are the new iobase/iolimit values invalid? */
 	if (conf->iolimit < conf->iobase ||
-	    conf->iolimitupper < conf->iobaseupper) {
-		mvebu_pcie_set_window(port, port->io_target, port->io_attr,
-				      &desired, &port->iowin);
-		return;
-	}
+	    conf->iolimitupper < conf->iobaseupper)
+		return mvebu_pcie_set_window(port, port->io_target, port->io_attr,
+					     &desired, &port->iowin);
 
 	if (!mvebu_has_ioport(port)) {
 		dev_WARN(&port->pcie->pdev->dev,
 			 "Attempt to set IO when IO is disabled\n");
-		return;
+		return -EOPNOTSUPP;
 	}
 
 	/*
@@ -410,21 +419,19 @@ static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
 			desired.remap) +
 		       1;
 
-	mvebu_pcie_set_window(port, port->io_target, port->io_attr, &desired,
-			      &port->iowin);
+	return mvebu_pcie_set_window(port, port->io_target, port->io_attr, &desired,
+				     &port->iowin);
 }
 
-static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
+static int mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
 {
 	struct mvebu_pcie_window desired = {.remap = MVEBU_MBUS_NO_REMAP};
 	struct pci_bridge_emul_conf *conf = &port->bridge.conf;
 
 	/* Are the new membase/memlimit values invalid? */
-	if (conf->memlimit < conf->membase) {
-		mvebu_pcie_set_window(port, port->mem_target, port->mem_attr,
-				      &desired, &port->memwin);
-		return;
-	}
+	if (conf->memlimit < conf->membase)
+		return mvebu_pcie_set_window(port, port->mem_target, port->mem_attr,
+					     &desired, &port->memwin);
 
 	/*
 	 * We read the PCI-to-PCI bridge emulated registers, and
@@ -436,8 +443,8 @@ static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
 	desired.size = (((conf->memlimit & 0xFFF0) << 16) | 0xFFFFF) -
 		       desired.base + 1;
 
-	mvebu_pcie_set_window(port, port->mem_target, port->mem_attr, &desired,
-			      &port->memwin);
+	return mvebu_pcie_set_window(port, port->mem_target, port->mem_attr, &desired,
+				     &port->memwin);
 }
 
 static pci_bridge_emul_read_status_t
@@ -522,15 +529,36 @@ mvebu_pci_bridge_emul_base_conf_write(struct pci_bridge_emul *bridge,
 		break;
 
 	case PCI_IO_BASE:
-		mvebu_pcie_handle_iobase_change(port);
+		if ((mask & 0xffff) && mvebu_pcie_handle_iobase_change(port)) {
+			/* On error disable IO range */
+			conf->iobase &= ~0xf0;
+			conf->iolimit &= ~0xf0;
+			conf->iobaseupper = cpu_to_le16(0x0000);
+			conf->iolimitupper = cpu_to_le16(0x0000);
+			if (mvebu_has_ioport(port))
+				conf->iobase |= 0xf0;
+		}
 		break;
 
 	case PCI_MEMORY_BASE:
-		mvebu_pcie_handle_membase_change(port);
+		if (mvebu_pcie_handle_membase_change(port)) {
+			/* On error disable mem range */
+			conf->membase = cpu_to_le16(le16_to_cpu(conf->membase) & ~0xfff0);
+			conf->memlimit = cpu_to_le16(le16_to_cpu(conf->memlimit) & ~0xfff0);
+			conf->membase = cpu_to_le16(le16_to_cpu(conf->membase) | 0xfff0);
+		}
 		break;
 
 	case PCI_IO_BASE_UPPER16:
-		mvebu_pcie_handle_iobase_change(port);
+		if (mvebu_pcie_handle_iobase_change(port)) {
+			/* On error disable IO range */
+			conf->iobase &= ~0xf0;
+			conf->iolimit &= ~0xf0;
+			conf->iobaseupper = cpu_to_le16(0x0000);
+			conf->iolimitupper = cpu_to_le16(0x0000);
+			if (mvebu_has_ioport(port))
+				conf->iobase |= 0xf0;
+		}
 		break;
 
 	case PCI_PRIMARY_BUS:
-- 
2.20.1

