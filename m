Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE423885C5
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 05:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236824AbhESDzZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 May 2021 23:55:25 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:37136 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353174AbhESDzY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 May 2021 23:55:24 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210519035404epoutp025064e8a88d2523e40e889c6c13f6e106~AW3mtwcn71878618786epoutp02Q
        for <linux-pci@vger.kernel.org>; Wed, 19 May 2021 03:54:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210519035404epoutp025064e8a88d2523e40e889c6c13f6e106~AW3mtwcn71878618786epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1621396444;
        bh=SkbiFRHW8yCUv/TVir6YyCzJvg8s8/ivcHFkiZbXSRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZZcbvbOLmHS+x/DFhbSRp1dGPxngCTTqMNM1yGRn1JvrWFJBdNdtsIvdSsY4YXPlN
         df74KpbtsDjp95/AW5FZjwps5/N0M2wQ5jD9Pe9HAx+RIFZnPHEIfiF8uzc0uUH2JM
         dJw2t6SnJyVDIUye2O+PjNh2QtOzZL3un6xRFzYs=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210519035402epcas5p3b1d8065395056eb87c1161c6c196af0b~AW3lq8xOq0487104871epcas5p3Q;
        Wed, 19 May 2021 03:54:02 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CF.D6.09835.ADB84A06; Wed, 19 May 2021 12:54:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20210518173823epcas5p1cb9f93e209ca4055365048287ec43ee8~AOeC2gVlb1003110031epcas5p1U;
        Tue, 18 May 2021 17:38:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210518173823epsmtrp2e02b82e9a7d4d0f2cdd125217247c13d~AOeC1rxIt1121711217epsmtrp2g;
        Tue, 18 May 2021 17:38:23 +0000 (GMT)
X-AuditID: b6c32a4b-7dfff7000000266b-77-60a48bdae2e2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.D8.08637.E8BF3A06; Wed, 19 May 2021 02:38:22 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210518173821epsmtip1b3f2812ac2a875cffe83965e4ca15494~AOeA-RBEL1826518265epsmtip1r;
        Tue, 18 May 2021 17:38:21 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        pankaj.dubey@samsung.com, p.rajanbabu@samsung.com,
        hari.tv@samsung.com, niyas.ahmed@samsung.com, l.mehra@samsung.com,
        Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH 2/3] PCI: debugfs: Add support for RAS framework in DWC
Date:   Tue, 18 May 2021 23:16:17 +0530
Message-Id: <20210518174618.42089-3-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210518174618.42089-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZdlhTXfdW95IEgzsn9C2WNGVY7LrbwW7x
        cdpKJosVX2ayW9x5foPR4vKuOWwWZ+cdZ7N48/sFu8WTKY9YLY5uDLZYtPULu8X/PTvYLXoP
        1zrweqyZt4bRY+esu+weCzaVemxa1cnm0bdlFaPHlv2fGT0+b5ILYI/isklJzcksSy3St0vg
        yljdtICx4PRGxooTx3pYGhgXTWTsYuTgkBAwkdhzOKiLkYtDSGA3o8TV2xcYIZxPjBLLJh9j
        hnC+MUqsvrGVqYuRE6zj3q0jUIm9jBILv05lg3BamCQ619xjBqliE9CSaPzaBWaLCFhLNLxa
        xQpSxCwwh0ni/7FFLCDLhQXcJU5MDwWpYRFQldiy+xTYBl4BK4mN3/4yQ2yTl1i94QCYzQk0
        Z3XbDrDNEgKtHBKvV81jhyhykdi+7QfUecISr45vgYpLSXx+t5cNws6XmHrhKQvE0xUSy3vq
        IML2EgeuzAELMwtoSqzfpQ8RlpWYemod2ERmAT6J3t9PoKbzSuyYB2MrS3z5u4cFwpaUmHfs
        MiuE7SExe/1LFkiY9DFKTL7VwjiBUW4WwooFjIyrGCVTC4pz01OLTQuM81LL9YoTc4tL89L1
        kvNzNzGCk4uW9w7GRw8+6B1iZOJgPMQowcGsJMK73XtxghBvSmJlVWpRfnxRaU5q8SFGaQ4W
        JXHeFQ8nJwgJpCeWpGanphakFsFkmTg4pRqYTN7s03b6O+UFG0uWyxRfl7Xy126mTFK9VcZ6
        JNTJuiLrhesqHrOzzOa3RdeI5LOzbE2sz3RY0N266EgVz/LCeb8nXk4wigiT91y96IXWXoYe
        x7e2v7xa/8+5kLG0u7+z6kbA26s+v9cUd7rrfLOzDhaKshOwYzN26u8O5hJSP3M169ujkycX
        bJyft1jEf5/XXfemN+HBBRedLNtNbmpqzuhIf/E5W6B9037/+miWaAk/E/H4TKtiwUsPHmjs
        sz+0aIbX5nw/LTerF8+XzAvOURAX73acEGj4YjPXn5ZN0kX5Toxfe6/81BPROiZ5buZef24F
        FtcA1eMTLqkm2JpNXC0tenzKjG3FSTMuliuxFGckGmoxFxUnAgDvZip2nQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsWy7bCSnG7f78UJBjPe2Vgsacqw2HW3g93i
        47SVTBYrvsxkt7jz/AajxeVdc9gszs47zmbx5vcLdosnUx6xWhzdGGyxaOsXdov/e3awW/Qe
        rnXg9Vgzbw2jx85Zd9k9Fmwq9di0qpPNo2/LKkaPLfs/M3p83iQXwB7FZZOSmpNZllqkb5fA
        lbG6aQFjwemNjBUnjvWwNDAumsjYxcjJISFgInHv1hHmLkYuDiGB3YwSW1Z1sUIkJCU+X1zH
        BGELS6z895wdoqiJSWLujmXsIAk2AS2Jxq9dzCC2iICtRMPfDrBJzAIrmCTazkxm6WLk4BAW
        cJc4MT0UpIZFQFViy+5TYEN5BawkNn77ywyxQF5i9YYDYDangLXE6rYdzCCtQkA1/++UTWDk
        W8DIsIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIziAtTR3MG5f9UHvECMTB+MhRgkO
        ZiUR3u3eixOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRq
        YMq/3LP0ya2LO68oS5xd6q9+2JTTRPmAgxxrZvsJ926pM86yCaJ1r09875Ocw+eS9ERU6CjH
        NPXuYzfnXzpiYpbbrp69+ofz+49nO7q1m9cfdO6akvX2dWd1/pr0IJUtV9pCZ3H8VOavPbVd
        zd5PhLFC6VPCgZJbBrmTS9Tev7rW5rdFY822Tt4b+zx+/CmXjQ699HND81pxyXwH/b/Htm5u
        XlhdPEnRnKX6wwUF2zcxNf31rGustN8ubvhQ7L77lmXe8vtXPR5uYLtVOffnPLMT3XwLO+2e
        /V0oZJl2nCma9/KNW2dudWyWkF63aN+LP2Lvpsyoz/9m1LT/ja8WC+On2d6290/mekuvWeR1
        qUSJpTgj0VCLuag4EQBknz2nzwIAAA==
X-CMS-MailID: 20210518173823epcas5p1cb9f93e209ca4055365048287ec43ee8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210518173823epcas5p1cb9f93e209ca4055365048287ec43ee8
References: <20210518174618.42089-1-shradha.t@samsung.com>
        <CGME20210518173823epcas5p1cb9f93e209ca4055365048287ec43ee8@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RAS is a vendor specific extended PCIe capability which which helps to read
hardware internal state.

This framework support provides debugfs entries to use these features for
DesignWare controller. Following primary features of DesignWare controllers
are provided to userspace via debugfs:
 - Debug registers
 - Error injection
 - Statistical counters

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/Kconfig            |   9 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 .../controller/dwc/pcie-designware-debugfs.c  | 544 ++++++++++++++++++
 .../controller/dwc/pcie-designware-debugfs.h  | 133 +++++
 drivers/pci/controller/dwc/pcie-designware.h  |   1 +
 5 files changed, 688 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.c
 create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.h

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 423d35872ce4..2d0a18cb9418 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -6,6 +6,15 @@ menu "DesignWare PCI Core Support"
 config PCIE_DW
 	bool
 
+config PCIE_DW_DEBUGFS
+	bool "DWC PCIe debugfs entries"
+	default n
+	help
+	  Enables debugfs entries for the DWC PCIe Controller.
+	  These entries make use of the RAS DES features in the DW
+	  controller to help in debug, error injection and statistical
+	  counters
+
 config PCIE_DW_HOST
 	bool
 	depends on PCI_MSI_IRQ_DOMAIN
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index eca805c1a023..6ad12638f793 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PCIE_DW) += pcie-designware.o
+obj-$(CONFIG_PCIE_DW_DEBUGFS) += pcie-designware-debugfs.o
 obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
 obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
 obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
new file mode 100644
index 000000000000..84bf196df240
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -0,0 +1,544 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Synopsys DesignWare PCIe controller debugfs driver
+ *
+ * Copyright (C) 2021 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Author: Shradha Todi <shradha.t@samsung.com>
+ */
+
+#include <linux/fs.h>
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+
+#include "pcie-designware.h"
+#include "pcie-designware-debugfs.h"
+
+#define DEBUGFS_BUF_MAX_SIZE	100
+
+static char debugfs_buf[DEBUGFS_BUF_MAX_SIZE];
+
+static struct dentry *dir;
+static struct dentry *sub_dir;
+
+static struct event_counters ras_events[] = {
+	{"ebuf_overflow",		ebuf_overflow},
+	{"ebuf_underrun",		ebuf_underrun},
+	{"decode_error",		decode_error},
+	{"sync_header_error",		sync_header_error},
+	{"receiver_error",		receiver_error},
+	{"framing_error",		framing_error},
+	{"lcrc_error",			lcrc_error},
+	{"ecrc_error",			ecrc_error},
+	{"unsupp_req_error",		unsupp_req_error},
+	{"cmpltr_abort_error",		cmpltr_abort_error},
+	{"cmpltn_timeout_error",	cmpltn_timeout_error},
+	{"tx_l0s_entry",		tx_l0s_entry},
+	{"rx_l0s_entry",		rx_l0s_entry},
+	{"l1_entry",			l1_entry},
+	{"l1_1_entry",			l1_1_entry},
+	{"l1_2_entry",			l1_2_entry},
+	{"l2_entry",			l2_entry},
+	{"speed_change",		speed_change},
+	{"width_chage",			width_chage},
+	{0, 0},
+};
+
+static struct error_injections error_list[] = {
+	{"tx_lcrc",		tx_lcrc},
+	{"tx_ecrc",		tx_ecrc},
+	{"rx_lcrc",		rx_lcrc},
+	{"rx_ecrc",		rx_ecrc},
+	{0, 0},
+};
+
+static int open(struct inode *inode, struct file *file)
+{
+	file->private_data = inode->i_private;
+
+	return 0;
+}
+
+/*
+ * set_event_number: Function to set event number based on filename
+ *
+ * This function is called from the common read and write function
+ * written for all event counters. Using the debugfs filname, the
+ * group number and event number for the counter is extracted and
+ * then programmed into the control register.
+ *
+ * @file: file pointer to the debugfs entry
+ *
+ * Return: void
+ */
+static void set_event_number(struct file *file)
+{
+	int i;
+	u32 val;
+	struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
+	u32 max_size = sizeof(ras_events) / sizeof(struct event_counters);
+
+	for (i = 0; i < max_size; i++) {
+		if (strcmp(ras_events[i].name,
+			   file->f_path.dentry->d_parent->d_iname) == 0) {
+			val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset +
+					RAS_DES_EVENT_COUNTER_CTRL_REG);
+			val &= ~(EVENT_COUNTER_ENABLE);
+			val &= ~(0xFFF << 16);
+			val |= (ras_events[i].event_num << 16);
+			dw_pcie_writel_dbi(pci, pci->ras_cap_offset +
+					RAS_DES_EVENT_COUNTER_CTRL_REG, val);
+			break;
+		}
+	}
+}
+/*
+ * get_error_inj_number: Function to get error number based on filename
+ *
+ * This function is called from the common read and write function
+ * written for all error injection debugfs entries. Using the debugfs
+ * filname, the error group and type of error to be injected is extracted.
+ *
+ * @file: file pointer to the debugfs entry
+ *
+ * Return: u32
+ * [31:8]: Type of error to be injected
+ * [7:0]: Group of error it belongs to
+ */
+
+static u32 get_error_inj_number(struct file *file)
+{
+	int i;
+	u32 max_size = sizeof(error_list) / sizeof(struct error_injections);
+
+	for (i = 0; i < max_size; i++) {
+		if (strcmp(error_list[i].name,
+			   file->f_path.dentry->d_iname) == 0) {
+			return error_list[i].type_of_err;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ras_event_counter_en_read: Function to get if counter is enable
+ *
+ * This function is invoked when the following command is made:
+ * cat /sys/kernel/debug/dwc_pcie_plat/ras_des_counter/<name>/counter_enable
+ * It returns whether the counter is enabled or not
+ */
+static ssize_t ras_event_counter_en_read(struct file *file, char __user *buf,
+					 size_t count, loff_t *ppos)
+{
+	u32 ret;
+	u32 val;
+	struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
+
+	set_event_number(file);
+
+	val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset +
+				RAS_DES_EVENT_COUNTER_CTRL_REG);
+	val = (val >> EVENT_COUNTER_STATUS_SHIFT) & EVENT_COUNTER_STATUS_MASK;
+	if (val)
+		sprintf(debugfs_buf, "Enabled\n");
+	else
+		sprintf(debugfs_buf, "Disabled\n");
+
+	ret = simple_read_from_buffer(buf, count, ppos, debugfs_buf,
+				      strlen(debugfs_buf));
+
+	return ret;
+}
+
+/*
+ * ras_event_counter_lane_sel_read: Function to get lane number selected
+ *
+ * This function is invoked when the following command is made:
+ * cat /sys/kernel/debug/dwc_pcie_plat/ras_des_counter/<name>/lane_select
+ * It returns for which lane the counter configurations are done
+ */
+static ssize_t ras_event_counter_lane_sel_read(struct file *file,
+					       char __user *buf, size_t count,
+					       loff_t *ppos)
+{
+	u32 ret;
+	u32 val;
+	struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
+
+	set_event_number(file);
+
+	val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset +
+			RAS_DES_EVENT_COUNTER_CTRL_REG);
+	val = (val >> LANE_SELECT_SHIFT) & LANE_SELECT_MASK;
+	sprintf(debugfs_buf, "0x%x\n", val);
+	ret = simple_read_from_buffer(buf, count, ppos, debugfs_buf,
+				      strlen(debugfs_buf));
+
+	return ret;
+}
+
+/*
+ * ras_event_counter_value_read: Function to get counter value
+ *
+ * This function is invoked when the following command is made:
+ * cat /sys/kernel/debug/dwc_pcie_plat/ras_des_counter/<name>/counter_value
+ * It returns the number of time the selected event has happened if enabled
+ */
+
+static ssize_t ras_event_counter_value_read(struct file *file, char __user *buf,
+					    size_t count, loff_t *ppos)
+{
+	u32 ret;
+	u32 val;
+	struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
+
+	set_event_number(file);
+
+	val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset +
+				RAS_DES_EVENT_COUNTER_DATA_REG);
+	sprintf(debugfs_buf, "0x%x\n", val);
+	ret = simple_read_from_buffer(buf, count, ppos, debugfs_buf,
+				      strlen(debugfs_buf));
+
+	return ret;
+}
+
+/*
+ * ras_event_counter_en_write: Function to set if counter is enable
+ *
+ * This function is invoked when the following command is made:
+ * echo n > /sys/kernel/debug/dwc_pcie_plat/
+ *		ras_des_counter/<name>/counter_enable
+ * Here n can be 1 to enable and 0 to disable
+ */
+static ssize_t ras_event_counter_en_write(struct file *file,
+					  const char __user *buf,
+					  size_t count, loff_t *ppos)
+{
+	u32 ret;
+	u32 val;
+	u32 enable;
+	struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
+
+	ret = kstrtou32_from_user(buf, count, 0, &enable);
+	if (ret)
+		return ret;
+
+	set_event_number(file);
+
+	val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset +
+				RAS_DES_EVENT_COUNTER_CTRL_REG);
+	if (enable)
+		val |= PER_EVENT_ON;
+	else
+		val |= PER_EVENT_OFF;
+
+	dw_pcie_writel_dbi(pci, pci->ras_cap_offset +
+			   RAS_DES_EVENT_COUNTER_CTRL_REG, val);
+
+	return count;
+}
+
+/*
+ * ras_event_counter_lane_sel_write: Function to set lane number
+ *
+ * This function is invoked when the following command is made:
+ * echo n > /sys/kernel/debug/dwc_pcie_plat/ras_des_counter/<name>/lane_select
+ * Here n is the lane that we want to select for counter configuration
+ */
+static ssize_t ras_event_counter_lane_sel_write(struct file *file,
+						const char __user *buf,
+						size_t count, loff_t *ppos)
+{
+	u32 ret;
+	u32 val;
+	u32 lane;
+	struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
+
+	ret = kstrtou32_from_user(buf, count, 0, &lane);
+	if (ret)
+		return ret;
+
+	set_event_number(file);
+	val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset +
+				RAS_DES_EVENT_COUNTER_CTRL_REG);
+	val &= ~(LANE_SELECT_MASK << LANE_SELECT_SHIFT);
+	val |= (lane << LANE_SELECT_SHIFT);
+	dw_pcie_writel_dbi(pci, pci->ras_cap_offset +
+			   RAS_DES_EVENT_COUNTER_CTRL_REG, val);
+
+	return count;
+}
+
+/*
+ * ras_error_inj_read: Function to read number of errors left to be injected
+ *
+ * This function is invoked when the following command is made:
+ * cat /sys/kernel/debug/dwc_pcie_plat/ras_des_error_inj/<name of error>
+ * This returns the number of errors left to be injected which will
+ * keep reducing as we make pcie transactions to inject error.
+ */
+static ssize_t ras_error_inj_read(struct file *file, char __user *buf,
+				  size_t count, loff_t *ppos)
+{
+	u32 ret;
+	u32 val, err_num, inj_num;
+	struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
+
+	err_num = get_error_inj_number(file);
+	inj_num = (err_num & 0xFF);
+
+	val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset + ERR_INJ0_OFF +
+				(0x4 * inj_num));
+	sprintf(debugfs_buf, "0x%x\n", (val & EINJ_COUNT_MASK));
+	ret = simple_read_from_buffer(buf, count, ppos, debugfs_buf,
+				      strlen(debugfs_buf));
+
+	return ret;
+}
+
+/*
+ * ras_error_inj_write: Function to set number of errors to be injected
+ *
+ * This function is invoked when the following command is made:
+ * echo n > /sys/kernel/debug/dwc_pcie_plat/ras_des_error_inj/<name of error>
+ * Here n is the number of errors we want to inject
+ */
+static ssize_t ras_error_inj_write(struct file *file, const char __user *buf,
+				   size_t count, loff_t *ppos)
+{
+	u32 ret;
+	u32 val, err_num, inj_num;
+	u32 counter;
+	struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
+
+	if (count > DEBUGFS_BUF_MAX_SIZE)
+		return -EINVAL;
+
+	ret = kstrtou32_from_user(buf, count, 0, &counter);
+	if (ret)
+		return ret;
+
+	err_num = get_error_inj_number(file);
+	inj_num = (err_num & 0xFF);
+	err_num = (err_num >> 8);
+
+	val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset + ERR_INJ0_OFF +
+				(0x4 * inj_num));
+	val &= ~(EINJ_TYPE_MASK << EINJ_TYPE_SHIFT);
+	val |= (err_num << EINJ_TYPE_SHIFT);
+	val &= ~(EINJ_COUNT_MASK);
+	val |= counter;
+	dw_pcie_writel_dbi(pci, pci->ras_cap_offset + ERR_INJ0_OFF +
+			   (0x4 * inj_num), val);
+	dw_pcie_writel_dbi(pci, pci->ras_cap_offset +
+			   ERR_INJ_ENABLE_REG, (0x1 << inj_num));
+
+	return count;
+}
+
+static ssize_t lane_detection_read(struct file *file, char __user *buf,
+				   size_t count, loff_t *ppos)
+{
+	u32 ret;
+	u32 val;
+	struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
+
+	val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset +
+				SD_STATUS_L1LANE_REG);
+	val = (val >> LANE_DETECT_SHIFT) & LANE_DETECT_MASK;
+	sprintf(debugfs_buf, "0x%x\n", val);
+
+	ret = simple_read_from_buffer(buf, count, ppos, debugfs_buf,
+				      strlen(debugfs_buf));
+
+	return ret;
+}
+
+static ssize_t rx_valid_read(struct file *file, char __user *buf,
+			     size_t count, loff_t *ppos)
+{
+	u32 ret;
+	u32 val;
+	struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
+
+	val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset +
+				SD_STATUS_L1LANE_REG);
+	val = (val >> PIPE_RXVALID_SHIFT) & PIPE_RXVALID_MASK;
+	sprintf(debugfs_buf, "0x%x\n", val);
+
+	ret = simple_read_from_buffer(buf, count, ppos, debugfs_buf,
+				      strlen(debugfs_buf));
+
+	return ret;
+}
+
+static ssize_t lane_selection_write(struct file *file, const char __user *buf,
+				    size_t count, loff_t *ppos)
+{
+	u32 ret;
+	u32 val;
+	u32 lane;
+	struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
+
+	if (count > DEBUGFS_BUF_MAX_SIZE)
+		return -EINVAL;
+
+	ret = kstrtou32_from_user(buf, count, 0, &lane);
+	if (ret)
+		return ret;
+
+	val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset +
+				SD_STATUS_L1LANE_REG);
+	val &= ~(LANE_SELECT_MASK);
+	val |= lane;
+	dw_pcie_writel_dbi(pci, pci->ras_cap_offset +
+			   SD_STATUS_L1LANE_REG, val);
+
+	return count;
+}
+
+static const struct file_operations lane_detection_fops = {
+	.open = open,
+	.read = lane_detection_read,
+	.write = lane_selection_write
+};
+
+static const struct file_operations rx_valid_fops = {
+	.open = open,
+	.read = rx_valid_read,
+	.write = lane_selection_write
+};
+
+static const struct file_operations cnt_en_ops = {
+	.read = ras_event_counter_en_read,
+	.write = ras_event_counter_en_write,
+	.open = simple_open,
+};
+
+static const struct file_operations lane_sel_ops = {
+	.read = ras_event_counter_lane_sel_read,
+	.write = ras_event_counter_lane_sel_write,
+	.open = simple_open,
+};
+
+static const struct file_operations cnt_val_ops = {
+	.read = ras_event_counter_value_read,
+	.open = simple_open,
+};
+
+static const struct file_operations inj_ops = {
+	.read = ras_error_inj_read,
+	.write = ras_error_inj_write,
+	.open = simple_open,
+};
+
+int create_debugfs_files(struct dw_pcie *pci)
+{
+	int ret = 0;
+	char dirname[32];
+	struct device *dev;
+
+	struct dentry *ras_des_debug_regs;
+	struct dentry *ras_des_error_inj;
+	struct dentry *ras_des_event_counter;
+	struct dentry *lane_detection;
+	struct dentry *rx_valid;
+
+	if (!pci) {
+		pr_err("pcie struct is NULL\n");
+		return -ENODEV;
+	}
+
+	dev = pci->dev;
+	sprintf(dirname, "pcie_dwc_%s", dev_name(dev));
+
+	pci->ras_cap_offset = dw_pcie_find_vsec_capability(pci,
+							   DW_PCIE_RAS_CAP_ID);
+	if (!pci->ras_cap_offset) {
+		pr_err("No RAS capability available\n");
+		return -ENODEV;
+	}
+
+	/* Create main directory for each platform driver */
+	dir = debugfs_create_dir(dirname, NULL);
+	if (dir == NULL) {
+		pr_err("error creating directory: %s\n", dirname);
+		return -ENODEV;
+	}
+
+	/* Create sub dirs for Debug, Error injection, Statistics */
+	ras_des_debug_regs = debugfs_create_dir("ras_des_debug_regs", dir);
+	if (ras_des_debug_regs == NULL) {
+		pr_err("error creating directory: %s\n", dirname);
+		ret = -ENODEV;
+		goto remove_debug_file;
+	}
+
+	ras_des_error_inj = debugfs_create_dir("ras_des_error_inj", dir);
+	if (ras_des_error_inj == NULL) {
+		pr_err("error creating directory: %s\n", dirname);
+		ret = -ENODEV;
+		goto remove_debug_file;
+	}
+
+	ras_des_event_counter = debugfs_create_dir("ras_des_counter", dir);
+	if (ras_des_event_counter == NULL) {
+		pr_err("error creating directory: %s\n", dirname);
+		ret = -ENODEV;
+		goto remove_debug_file;
+	}
+
+	/* Create debugfs files for Debug subdirectory */
+	lane_detection = debugfs_create_file("lane_detection", 0644,
+					     ras_des_debug_regs, pci,
+					     &lane_detection_fops);
+
+	rx_valid = debugfs_create_file("rx_valid", 0644,
+					     ras_des_debug_regs, pci,
+					     &lane_detection_fops);
+
+	/* Create debugfs files for Error injection sub dir */
+	CREATE_RAS_ERROR_INJECTION_DEBUGFS(tx_ecrc);
+	CREATE_RAS_ERROR_INJECTION_DEBUGFS(rx_ecrc);
+	CREATE_RAS_ERROR_INJECTION_DEBUGFS(tx_lcrc);
+	CREATE_RAS_ERROR_INJECTION_DEBUGFS(rx_lcrc);
+
+	/* Create debugfs files for Statistical counter sub dir */
+	CREATE_RAS_EVENT_COUNTER_DEBUGFS(ebuf_overflow);
+	CREATE_RAS_EVENT_COUNTER_DEBUGFS(ebuf_underrun);
+	CREATE_RAS_EVENT_COUNTER_DEBUGFS(decode_error);
+	CREATE_RAS_EVENT_COUNTER_DEBUGFS(receiver_error);
+	CREATE_RAS_EVENT_COUNTER_DEBUGFS(framing_error);
+	CREATE_RAS_EVENT_COUNTER_DEBUGFS(lcrc_error);
+	CREATE_RAS_EVENT_COUNTER_DEBUGFS(ecrc_error);
+	CREATE_RAS_EVENT_COUNTER_DEBUGFS(unsupp_req_error);
+	CREATE_RAS_EVENT_COUNTER_DEBUGFS(cmpltr_abort_error);
+	CREATE_RAS_EVENT_COUNTER_DEBUGFS(cmpltn_timeout_error);
+	CREATE_RAS_EVENT_COUNTER_DEBUGFS(tx_l0s_entry);
+	CREATE_RAS_EVENT_COUNTER_DEBUGFS(rx_l0s_entry);
+	CREATE_RAS_EVENT_COUNTER_DEBUGFS(l1_entry);
+	CREATE_RAS_EVENT_COUNTER_DEBUGFS(l1_1_entry);
+	CREATE_RAS_EVENT_COUNTER_DEBUGFS(l1_2_entry);
+	CREATE_RAS_EVENT_COUNTER_DEBUGFS(l2_entry);
+	CREATE_RAS_EVENT_COUNTER_DEBUGFS(speed_change);
+	CREATE_RAS_EVENT_COUNTER_DEBUGFS(width_chage);
+
+	return ret;
+
+remove_debug_file:
+	remove_debugfs_files();
+	return ret;
+}
+
+void remove_debugfs_files(void)
+{
+	debugfs_remove_recursive(dir);
+}
diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.h b/drivers/pci/controller/dwc/pcie-designware-debugfs.h
new file mode 100644
index 000000000000..3dc3cf696a04
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.h
@@ -0,0 +1,133 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Synopsys DesignWare PCIe controller debugfs driver
+ *
+ * Copyright (C) 2021 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Author: Shradha Todi <shradha.t@samsung.com>
+ */
+
+#ifndef _PCIE_DESIGNWARE_DEBUGFS_H
+#define _PCIE_DESIGNWARE_DEBUGFS_H
+
+#include "pcie-designware.h"
+
+#define RAS_DES_EVENT_COUNTER_CTRL_REG	0x8
+#define RAS_DES_EVENT_COUNTER_DATA_REG	0xC
+#define SD_STATUS_L1LANE_REG		0xB0
+#define ERR_INJ_ENABLE_REG		0x30
+#define ERR_INJ0_OFF			0x34
+
+#define LANE_DETECT_SHIFT		17
+#define LANE_DETECT_MASK		0x1
+#define PIPE_RXVALID_SHIFT		18
+#define PIPE_RXVALID_MASK		0x1
+
+#define LANE_SELECT_SHIFT		8
+#define LANE_SELECT_MASK		0xF
+#define EVENT_COUNTER_STATUS_SHIFT	7
+#define EVENT_COUNTER_STATUS_MASK	0x1
+#define EVENT_COUNTER_ENABLE		(0x7 << 2)
+#define PER_EVENT_OFF			(0x1 << 2)
+#define PER_EVENT_ON			(0x3 << 2)
+
+#define EINJ_COUNT_MASK			0xFF
+#define EINJ_TYPE_MASK			0xFFFFFF
+#define EINJ_TYPE_SHIFT			8
+
+enum event_numbers {
+	ebuf_overflow		= 0x0,
+	ebuf_underrun		= 0x1,
+	decode_error		= 0x2,
+	sync_header_error	= 0x5,
+	receiver_error		= 0x106,
+	framing_error		= 0x109,
+	lcrc_error		= 0x201,
+	ecrc_error		= 0x302,
+	unsupp_req_error	= 0x303,
+	cmpltr_abort_error	= 0x304,
+	cmpltn_timeout_error	= 0x305,
+	tx_l0s_entry		= 0x502,
+	rx_l0s_entry		= 0x503,
+	l1_entry		= 0x505,
+	l1_1_entry		= 0x507,
+	l1_2_entry		= 0x508,
+	l2_entry		= 0x50B,
+	speed_change		= 0x50C,
+	width_chage		= 0x50D,
+};
+
+/*
+ * struct event_counters: Struct to store event number
+ *
+ * @name: name of the event counter
+ *        eg: ecrc_err count, l1 entry count
+ * @event_num: Event number and group number
+ * [16:8]: Group number
+ * [7:0]: Event number
+ */
+struct event_counters {
+	const char *name;
+	u32 event_num;
+};
+
+enum error_inj_code {
+	tx_lcrc			= 0x000,
+	tx_ecrc			= 0x300,
+	rx_lcrc			= 0x800,
+	rx_ecrc			= 0xB00,
+};
+
+/*
+ * struct error_injectionss: Struct to store error numbers
+ *
+ * @name: name of the error to be injected
+ *        eg: ecrc_err, lcrc_err
+ * @event_num: Error number and group number
+ * [31:8]: Error type. This should be same as bits [31:8]
+ *         in the EINJn_REG where n is group number
+ * [7:0]: Error injection group
+ *        0 - CRC
+ *        1 - seq num
+ *        2 - DLLP error
+ *        3 - symbol error
+ *        4 - FC error
+ */
+struct error_injections {
+	const char *name;
+	u32 type_of_err;
+};
+
+#define CREATE_RAS_EVENT_COUNTER_DEBUGFS(name)				\
+do {									\
+	sub_dir = debugfs_create_dir(#name, ras_des_event_counter);	\
+	debugfs_create_file("counter_enable", 0644, sub_dir, pci,	\
+				&cnt_en_ops);				\
+	debugfs_create_file("lane_select", 0644, sub_dir, pci,		\
+				&lane_sel_ops);				\
+	debugfs_create_file("counter_value", 0444, sub_dir, pci,	\
+				&cnt_val_ops);				\
+} while (0)
+
+#define CREATE_RAS_ERROR_INJECTION_DEBUGFS(name)			\
+	debugfs_create_file(#name, 0644, ras_des_error_inj, pci,	\
+				&inj_ops);
+
+#ifdef CONFIG_PCIE_DW_DEBUGFS
+int create_debugfs_files(struct dw_pcie *pci);
+void remove_debugfs_files(void);
+#else
+int create_debugfs_files(struct dw_pcie *pci)
+{
+	/* No OP */
+	return 0;
+}
+
+void remove_debugfs_files(void)
+{
+	/* No OP */
+}
+#endif
+
+#endif
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 307525aaa063..031fdafe0a3e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -278,6 +278,7 @@ struct dw_pcie {
 	u8			n_fts[2];
 	bool			iatu_unroll_enabled: 1;
 	bool			io_cfg_atu_shared: 1;
+	u32			ras_cap_offset;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
-- 
2.17.1

