Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB11A49E10
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 12:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfFRKIx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 06:08:53 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8936 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfFRKIw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2019 06:08:52 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d08b8330000>; Tue, 18 Jun 2019 03:08:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 18 Jun 2019 03:08:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 18 Jun 2019 03:08:50 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 10:08:49 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 18 Jun 2019 10:08:50 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d08b82f0000>; Tue, 18 Jun 2019 03:08:49 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH] PCI: tegra: Add debugfs support to dump LTSSM trace
Date:   Tue, 18 Jun 2019 15:38:44 +0530
Message-ID: <20190618100844.21683-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560852531; bh=msjFxfVLBSoW68UpCX8ivBwlsFbD8bSS8aWPEK3LNOA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=jd/JNT+WyAXkytSVDTfWrnxyfm06nKdflWe47L0ccx6mJlzPMr7A6uR4p3wV0ervg
         vCCB3N0u5Sqn8LGn6GBJ4Sccdu9qmj+4PN4Md4iBm4zEPefpN6BtwR+jHHEjbdsnvW
         yfSqfZ6NJBsUoNLeOShOE9MrOB97zwR7phRa74jJWJoDXKqpy38QAK9toYJO/+PB+H
         jlnsm2tVra+XLVqDHzJA7LwKlgs+kWLYr/al+uBEhAm3T7p50cUYar4ufm0HBeOq3R
         83/eb+BbYK7ctI5+dJdiuhBot4/01QiqFYXmoLP49n6IqPikf9TIIwqKzP1JKDiB6F
         woHMIyR7oHL7w==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to dump LTSSM trace through a port specific debugfs entry
'ltssm_trace'. This is particular useful to debug link up issues and
speed change issues. Trace is dumped in the following format.

[root@alarm ~]# cat /sys/kernel/debug/pcie/0/ltssm_trace
Trace Reg Val   Major      Minor-Tx      Minor-Rx
----------------------------------------------------
[0x00090824]    detect     active        active
[0x001b0864]    detect     wait          wait
[0x001208a4]    detect     retry         retry
[0x000018e4]    polling    active        active
[0x00091924]    polling    config        config
[0x00002964]    config     link start    link start
[0x000929a4]    config     link accept   link accept
[0x001b29e4]    config     lane wait     lane wait
[0x00122a24]    config     lane accept   lane accept
[0x00362a64]    config     complete      complete
[0x00242aa4]    config     idle          idle
[0x00004ae4]    l0         normal        normal
[0x00054b24]    l0         pwrup         normal
[0x00387b64]    recovery   rcvrlock      finish pkt
[0x00007ba4]    recovery   rcvrlock      rcvrlock
[0x00097be4]    recovery   rcvrcfg       rcvrcfg
[0x001b7c24]    recovery   idle          idle
[0x00004c64]    l0         normal        normal

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/pci-tegra.c | 201 +++++++++++++++++++++++++++++
 1 file changed, 201 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 464ba2538d52..2b5b43e09ced 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -177,6 +177,26 @@
 
 #define AFI_PEXBIAS_CTRL_0		0x168
 
+#define RP_LTSSM_DBGREG			0xe44
+#define  RP_LTSSM_DBGREG_LINKFSM16	BIT(16)
+
+#define RP_LTSSM_TRACE_CTRL				0xe50
+#define  LTSSM_TRACE_CTRL_CLEAR_STORE_EN		BIT(0)
+#define  LTSSM_TRACE_CTRL_CLEAR_RAM			BIT(2)
+#define  LTSSM_TRACE_CTRL_TRIG_ON_EVENT			BIT(3)
+#define  LTSSM_TRACE_CTRL_TRIG_LTSSM_MAJOR_OFFSET	4
+#define  LTSSM_TRACE_CTRL_TRIG_PTX_LTSSM_MINOR_OFFSET	8
+#define  LTSSM_TRACE_CTRL_TRIG_PRX_LTSSM_MAJOR_OFFSET	11
+
+#define RP_LTSSM_TRACE_STS			0xe54
+#define  LTSSM_TRACE_STS_PRX_MINOR(reg)		(((reg) >> 19) & 0x7)
+#define  LTSSM_TRACE_STS_PTX_MINOR(reg)		(((reg) >> 16) & 0x7)
+#define  LTSSM_TRACE_STS_MAJOR(reg)		(((reg) >> 12) & 0xf)
+#define  LTSSM_TRACE_STS_READ_DATA_VALID(reg)	(((reg) >> 11) & 0x1)
+#define  LTSSM_TRACE_STS_READ_ADDR(reg)		((reg) << 6)
+#define  LTSSM_TRACE_STS_WRITE_POINTER(reg)	(((reg) >> 1) & 0x1f)
+#define  LTSSM_TRACE_STS_RAM_FULL(reg)		((reg) & 0x1)
+
 #define RP_VEND_XP	0x00000f00
 #define  RP_VEND_XP_DL_UP	(1 << 30)
 
@@ -321,6 +341,7 @@ struct tegra_pcie_port {
 	unsigned int lanes;
 
 	struct phy **phys;
+	struct dentry *debugfs;
 };
 
 struct tegra_pcie_bus {
@@ -2348,9 +2369,184 @@ static void tegra_pcie_debugfs_exit(struct tegra_pcie *pcie)
 	pcie->debugfs = NULL;
 }
 
+struct ltssm_major_state {
+	const char *name;
+	const char *minor[8];
+};
+
+struct ltssm_state {
+	struct ltssm_major_state major[12];
+};
+
+static const struct ltssm_state ltssm_state = {
+	.major = {
+		{
+			.name = "detect",
+			.minor = {"quiet",
+				  "active",
+				  "retry",
+				  "wait",
+				  "entry"}
+		}, {
+			.name = "polling",
+			.minor = {"active",
+				  "config",
+				  "idle",
+				  NULL,
+				  "compliance",
+				  "cspeed"}
+		}, {
+			.name = "config",
+			.minor = {"link start",
+				  "link accept",
+				  "lane accept",
+				  "lane wait",
+				  "idle",
+				  "pwrup",
+				  "complete"}
+		}, {
+			.name = NULL,
+			.minor = {NULL}
+		}, {
+			.name = "l0",
+			.minor = {"normal",
+				  "l0s entry",
+				  "l0s idle",
+				  "l0s wait",
+				  "l0s fts",
+				  "pwrup"}
+		}, {
+			.name = "l1",
+			.minor = {"entry",
+				  "waitrx",
+				  "idle",
+				  "wait",
+				  "pwrup",
+				  "beacon entry",
+				  "beacon exit"}
+		}, {
+			.name = "l2",
+			.minor = {"entry",
+				  "waitrx",
+				  "transmitwake",
+				  "idle"}
+		}, {
+			.name = "recovery",
+			.minor = {"rcvrlock",
+				  "rcvrcfg",
+				  "speed",
+				  "idle",
+				  NULL,
+				  NULL,
+				  NULL,
+				  "finish pkt"}
+		}, {
+			.name = "loopback",
+			.minor = {"entry",
+				  "active",
+				  "idle",
+				  "exit",
+				  "speed",
+				  "pre speed"}
+		}, {
+			.name = "hotreset",
+			.minor = {NULL}
+		}, {
+			.name = "disabled",
+			.minor = {NULL}
+		}, {
+			.name = "txchar",
+			.minor = {NULL}
+		}
+	}
+};
+
+static const char *ltssm_get_major(unsigned int major)
+{
+	const char *state;
+
+	state = ltssm_state.major[major].name;
+	if (!state)
+		return "unknown";
+
+	return state;
+}
+
+static const char *ltssm_get_minor(unsigned int major, unsigned int minor)
+{
+	const char *state;
+
+	state = ltssm_state.major[major].minor[minor];
+	if (!state)
+		return "unknown";
+
+	return state;
+}
+
+static int ltssm_trace_show(struct seq_file *s, void *what)
+{
+	struct tegra_pcie_port *port = s->private;
+	unsigned int ridx, widx, entries;
+	u32 value;
+
+	value = readl(port->base + RP_LTSSM_TRACE_STS);
+	widx = LTSSM_TRACE_STS_WRITE_POINTER(value);
+	entries = LTSSM_TRACE_STS_RAM_FULL(value) ? 32 : widx;
+
+	seq_puts(s, "Trace Reg Val   Major      Minor-Tx      Minor-Rx\n");
+	seq_puts(s, "----------------------------------------------------\n");
+	for (ridx = 0; ridx < entries; ridx++) {
+		value = LTSSM_TRACE_STS_READ_ADDR(ridx);
+		writel(value, port->base + RP_LTSSM_TRACE_STS);
+		value = readl(port->base + RP_LTSSM_TRACE_STS);
+
+		seq_printf(s, "[0x%08x]    %-10s %-13s %s\n", value,
+			   ltssm_get_major(LTSSM_TRACE_STS_MAJOR(value)),
+			   ltssm_get_minor(LTSSM_TRACE_STS_MAJOR(value),
+					   LTSSM_TRACE_STS_PTX_MINOR(value)),
+			   ltssm_get_minor(LTSSM_TRACE_STS_MAJOR(value),
+					   LTSSM_TRACE_STS_PRX_MINOR(value)));
+	}
+
+	/* Clear Trace RAM */
+	value = readl(port->base + RP_LTSSM_TRACE_CTRL);
+	value |= LTSSM_TRACE_CTRL_CLEAR_RAM;
+	writel(value, port->base + RP_LTSSM_TRACE_CTRL);
+	value &= ~LTSSM_TRACE_CTRL_CLEAR_RAM;
+	writel(value, port->base + RP_LTSSM_TRACE_CTRL);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ltssm_trace);
+
+static int tegra_pcie_port_debugfs_init(struct tegra_pcie_port *port)
+{
+	struct dentry *d;
+	char port_name[2] = {0};
+
+	snprintf(port_name, sizeof(port_name), "%d", port->index);
+	port->debugfs = debugfs_create_dir(port_name,
+					   port->pcie->debugfs);
+	if (!port->debugfs)
+		return -ENOMEM;
+
+	d = debugfs_create_file("ltssm_trace", 0444, port->debugfs, port,
+				&ltssm_trace_fops);
+	if (!d)
+		goto remove;
+
+	return 0;
+
+remove:
+	debugfs_remove_recursive(port->debugfs);
+	port->debugfs = NULL;
+	return -ENOMEM;
+}
+
 static int tegra_pcie_debugfs_init(struct tegra_pcie *pcie)
 {
 	struct dentry *file;
+	struct tegra_pcie_port *port;
 
 	pcie->debugfs = debugfs_create_dir("pcie", NULL);
 	if (!pcie->debugfs)
@@ -2361,6 +2557,11 @@ static int tegra_pcie_debugfs_init(struct tegra_pcie *pcie)
 	if (!file)
 		goto remove;
 
+	list_for_each_entry(port, &pcie->ports, list) {
+		if (tegra_pcie_port_debugfs_init(port))
+			goto remove;
+	}
+
 	return 0;
 
 remove:
-- 
2.17.1

