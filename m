Return-Path: <linux-pci+bounces-35259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49F5B3DE55
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 11:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2CC97A8289
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 09:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE6A31DD89;
	Mon,  1 Sep 2025 09:21:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023092.outbound.protection.outlook.com [40.107.44.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04865317700;
	Mon,  1 Sep 2025 09:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718479; cv=fail; b=GL0uYXd/KcCjQduy3kBuEKGMdsn0k2Vm2JQe4pvuo8YxiCDNs9m4nsMvivu9j4P5cESop2JpTjWEn0fp9c9FBssmJBawPbdZj5cXxzmLxfPudKJOr3lZ6eCM67dpawYaa2lm8LWG50TAVoBJYrBN7ZPP/+30uvk4EaGqkxFzTWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718479; c=relaxed/simple;
	bh=sy03r0ZnUx9+L1xQUMfyqOvl0HPrm1333WJ82J7/MRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gW//19uAxRzXACHvyAGaSPUtbllCA0tsIbceFrz1ugV8r+VX9QtV8wiNkfFP0DZup6ggEzS+kup3ZTtny7bEPPIHtnC/SmaC6AAlYOL0B/3+ZJMD4gg4tZdUTI55CcSg0F79xJJreNsuluEbhheVxiGqWyyjf1uzRgiD60EScDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCqrUoF6MruHKverd6Cy/QCEmwo/erIceJJqIs0I24jNhLnwC1c3MwLXEHJYVmEpVYIpoiZxGtEhPQ9fqkdgj0c53i1rwIsAP/NYYgjYBty1goiM7/DTtqLl0SrnrM/SPVA2rXCAU+bDFh0rlBVOPlclJmjakRA9VuvmXJkLoxWGl0/f0GgPJiTYtYAi9bMJBl1nWFZoZCYYyKDGF61ab6yNBaB7d7MxpR+xq5IwqhLZ2HnvZ4SWpc7x2EjcOA7ogsw6ZbPhjVUUGHbrS2nbhkM2SGqyC5J0P0Yw3ZjMX2ZGws37PBfBAR30mC6J0JELK9rYNLUcU6oyFaRXTMvYLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeJcbqnbNNhhoLlQLlLXsirpzkiz7IM6zOOjPRvdL2g=;
 b=bLXuUrEVu5mYAtqZZAQOm+ZfMH9O/08TOQjTFaJjDsUEiHMryLqYHIbKYUAtnbO+ZqrkYOSPW7hbW2ZI6ZuG4z6Nyf8tjljHTiZU0CwQpSasPqr9RGZH834M8lE6rtgMQT26LvU/bNeuZ2+dC6FvcwUIraVAExSlAanlUsv2V9UW7hHGGEgfTC83cl6SbBxvdtMm4Z+RalLhcST9kBpbQb/drJB70Ct5z/xbi5dC7Rq1E1zwFV+p5vfP0noTwryhrxEsmQrb+gZ+OOsuDx/WfWKF9NMV/BYgE0EATId97PJkLq6axFpWW6OXAp62X0c4GAi2yMQCTUGkTUSOa+84tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2P153CA0034.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::17) by
 SEZPR06MB6764.apcprd06.prod.outlook.com (2603:1096:101:17f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Mon, 1 Sep
 2025 09:21:10 +0000
Received: from SG2PEPF000B66C9.apcprd03.prod.outlook.com
 (2603:1096:4:190:cafe::14) by SI2P153CA0034.outlook.office365.com
 (2603:1096:4:190::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.4 via Frontend Transport; Mon, 1
 Sep 2025 09:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66C9.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 09:21:08 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 2AE0D41C0156;
	Mon,  1 Sep 2025 17:21:05 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	mani@kernel.org,
	robh@kernel.org,
	kwilczynski@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mpillai@cadence.com,
	fugang.duan@cixtech.com,
	guoyin.chen@cixtech.com,
	peter.chen@cixtech.com,
	cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH v9 06/14] PCI: cadence: Move PCIe RP common functions to a separate file
Date: Mon,  1 Sep 2025 17:20:44 +0800
Message-ID: <20250901092052.4051018-7-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250901092052.4051018-1-hans.zhang@cixtech.com>
References: <20250901092052.4051018-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66C9:EE_|SEZPR06MB6764:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 57fdd4bd-4bd2-4c91-5d5d-08dde938e2ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RQmFrTPgjKwrXc1/4pN2N0Q2aiXR0eSKF0f10R5NWl52+pDyymXV+enG2MKm?=
 =?us-ascii?Q?sRysrOB5LG3TC1KaS46WknfQoxVceoVjizhGR0/fCEfyU1UlEfYSjY6Z7sRK?=
 =?us-ascii?Q?s8ZVaEaUAFW51ohJf/bgca1LZd6VD6K58HN33x1oV+229pQeMQScWzdWJPfC?=
 =?us-ascii?Q?s4xEf55F0mExFjYdv/bLBGLALst7sHhHCLVwryKh5KVRhdmRjgnacFNk/G+5?=
 =?us-ascii?Q?h2uQY10K4vTcYrD/nyCtpiJAfXinZiGwpjOGqYtl7q9bOb5sxwkSdElYMiIY?=
 =?us-ascii?Q?aRhxPen4ZfhF103djsQE0HhQf1ghsYNuFgyCxpMmv2BPHQRyU3E63cfZH9nx?=
 =?us-ascii?Q?UntqxmJ0Q+/bExzEdm30KXSgzXCMJe84zPZ9cduFG/W4yG/cSWTWLFfBApCO?=
 =?us-ascii?Q?wKfGRCajudG3dPBw3MQxhVyAePRRJRadLg01nXSi+M/HPihE0ua0iFA0hGiq?=
 =?us-ascii?Q?ZXWO90UfTGMFmuub+Vi6zKgwOegSKWBfbeFu+JQkym+tGFKfeRpokL+exS+5?=
 =?us-ascii?Q?/FMgLoIuxL9HJA3YXqkuSa6xWemB9o/8OKZrHV3guKKVNoaX1cs2farQlnEj?=
 =?us-ascii?Q?ouNy52Z7YkuPMkQkeNEYtgGANavuPDMlTRMehqIkzbGm112/B1Ef3QnD9Lj5?=
 =?us-ascii?Q?AlXgWUQseRjL0jOwugO8hUw/c6AFYtzQefXp6+uvUPi3kocWcXpKNLXMZIvd?=
 =?us-ascii?Q?qPR8ZYyTEn/5jUIyfm/rxvcy63q49/WgNmpCRBHj3Zn0YzXlsZDqERT3wCQB?=
 =?us-ascii?Q?BGHgm7FOQtyMTx7T6sdv7atXCVfKYdTM8MhEQP6RCxkfXPhz/XKDReRj+Eos?=
 =?us-ascii?Q?YpfihMeysPOJtwYBojtWSMa/m7uiK2s9iW0nASf2Ck2PPSdDsX9Ge1XMKozc?=
 =?us-ascii?Q?eULtD5xopdQJstcGVCZsYD7jh31AsdN7w2Rz9gYYNCITEhMSpKCsOCbKrZW+?=
 =?us-ascii?Q?Fp6OIIdWvEYzZNacVKU4TYvAqgaNcXzGTXmv9lJfuskgswocaocJHmHS7mMM?=
 =?us-ascii?Q?WEfUOK745T5QI/S3w4hKBtl2Gf2B0ilV5oTC0Zq5/3+ltkTatSfn3cJlqOPE?=
 =?us-ascii?Q?uNAvQ4KHC/LnH/Xn9jCz87U71n6DiWWQVXwV6rgelcb4yUPMS/hGgdOS1uJm?=
 =?us-ascii?Q?lMQcyNIXeZ+W6l5wa9d3f6ubhGXLekkIFo6fJg2xuD407TJfwnGcSfU2lDIf?=
 =?us-ascii?Q?uXybMpVHdeh0AYdY2C0BAGAnbmWv7wA3qt5qhpEpGlDFU/Z+k7RLViaQOCFC?=
 =?us-ascii?Q?aSESpLDJPCIV5xKueVplOQw0CsUTt3ghJJU70TrBEG4WZjx9HA3ofCmB0Q7B?=
 =?us-ascii?Q?MWG7B18wfN2noZ6Jo+jC9XupIfG++5VbFD2yWez/QfqiW3ifkntLCMlAdxPe?=
 =?us-ascii?Q?Qg1lH8J1yXpqJUmUAVQ4lJksr2qFUP0qV35NVMqvJT+zdIfEZxseeugst5PQ?=
 =?us-ascii?Q?oJsme+OXiz4uKHcipTn7wIl9KnBh1y1jnGmIDnagXoo105ovBd0ub1Hpur4B?=
 =?us-ascii?Q?F9xshnktxN+FwSfjnQ0TGcwUyxAF8KEvbCq8?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 09:21:08.9550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fdd4bd-4bd2-4c91-5d5d-08dde938e2ee
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66C9.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6764

From: Manikandan K Pillai <mpillai@cadence.com>

Move the Cadence PCIe controller RP common functions into a separate
file. The common library functions are split from legacy PCIe RP
controller functions to a separate file.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/controller/cadence/Makefile       |   2 +-
 .../cadence/pcie-cadence-host-common.c        | 182 ++++++++++++++++++
 .../cadence/pcie-cadence-host-common.h        |  26 +++
 .../controller/cadence/pcie-cadence-host.c    | 156 +--------------
 4 files changed, 210 insertions(+), 156 deletions(-)
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-common.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-common.h

diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
index 80c1c4be7e80..e45f72388bbb 100644
--- a/drivers/pci/controller/cadence/Makefile
+++ b/drivers/pci/controller/cadence/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
-obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
+obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host-common.o pcie-cadence-host.o
 obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep-common.o pcie-cadence-ep.o
 obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
 obj-$(CONFIG_PCI_J721E) += pci-j721e.o
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-common.c b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
new file mode 100644
index 000000000000..e72af6949992
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence PCIe host controller library.
+ *
+ * Copyright (c) 2017 Cadence
+ * Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
+ */
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/list_sort.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/platform_device.h>
+
+#include "pcie-cadence.h"
+#include "pcie-cadence-host-common.h"
+
+#define LINK_RETRAIN_TIMEOUT HZ
+
+u64 bar_max_size[] = {
+	[RP_BAR0] = _ULL(128 * SZ_2G),
+	[RP_BAR1] = SZ_2G,
+	[RP_NO_BAR] = _BITULL(63),
+};
+EXPORT_SYMBOL_GPL(bar_max_size);
+
+int cdns_pcie_host_training_complete(struct cdns_pcie *pcie)
+{
+	u32 pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
+	unsigned long end_jiffies;
+	u16 lnk_stat;
+
+	/* Wait for link training to complete. Exit after timeout. */
+	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
+	do {
+		lnk_stat = cdns_pcie_rp_readw(pcie, pcie_cap_off + PCI_EXP_LNKSTA);
+		if (!(lnk_stat & PCI_EXP_LNKSTA_LT))
+			break;
+		usleep_range(0, 1000);
+	} while (time_before(jiffies, end_jiffies));
+
+	if (!(lnk_stat & PCI_EXP_LNKSTA_LT))
+		return 0;
+
+	return -ETIMEDOUT;
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_host_training_complete);
+
+int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+	int retries;
+
+	/* Check if the link is up or not */
+	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+		if (cdns_pcie_link_up(pcie)) {
+			dev_info(dev, "Link up\n");
+			return 0;
+		}
+		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
+	}
+
+	return -ETIMEDOUT;
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_host_wait_for_link);
+
+int cdns_pcie_retrain(struct cdns_pcie *pcie)
+{
+	u32 lnk_cap_sls, pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
+	u16 lnk_stat, lnk_ctl;
+	int ret = 0;
+
+	/*
+	 * Set retrain bit if current speed is 2.5 GB/s,
+	 * but the PCIe root port support is > 2.5 GB/s.
+	 */
+
+	lnk_cap_sls = cdns_pcie_readl(pcie, (CDNS_PCIE_RP_BASE + pcie_cap_off +
+					     PCI_EXP_LNKCAP));
+	if ((lnk_cap_sls & PCI_EXP_LNKCAP_SLS) <= PCI_EXP_LNKCAP_SLS_2_5GB)
+		return ret;
+
+	lnk_stat = cdns_pcie_rp_readw(pcie, pcie_cap_off + PCI_EXP_LNKSTA);
+	if ((lnk_stat & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB) {
+		lnk_ctl = cdns_pcie_rp_readw(pcie,
+					     pcie_cap_off + PCI_EXP_LNKCTL);
+		lnk_ctl |= PCI_EXP_LNKCTL_RL;
+		cdns_pcie_rp_writew(pcie, pcie_cap_off + PCI_EXP_LNKCTL,
+				    lnk_ctl);
+
+		ret = cdns_pcie_host_training_complete(pcie);
+		if (ret)
+			return ret;
+
+		ret = cdns_pcie_host_wait_for_link(pcie);
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_retrain);
+
+int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc)
+{
+	struct cdns_pcie *pcie = &rc->pcie;
+	int ret;
+
+	ret = cdns_pcie_host_wait_for_link(pcie);
+
+	/*
+	 * Retrain link for Gen2 training defect
+	 * if quirk flag is set.
+	 */
+	if (!ret && rc->quirk_retrain_flag)
+		ret = cdns_pcie_retrain(pcie);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_host_start_link);
+
+enum cdns_pcie_rp_bar
+cdns_pcie_host_find_min_bar(struct cdns_pcie_rc *rc, u64 size)
+{
+	enum cdns_pcie_rp_bar bar, sel_bar;
+
+	sel_bar = RP_BAR_UNDEFINED;
+	for (bar = RP_BAR0; bar <= RP_NO_BAR; bar++) {
+		if (!rc->avail_ib_bar[bar])
+			continue;
+
+		if (size <= bar_max_size[bar]) {
+			if (sel_bar == RP_BAR_UNDEFINED) {
+				sel_bar = bar;
+				continue;
+			}
+
+			if (bar_max_size[bar] < bar_max_size[sel_bar])
+				sel_bar = bar;
+		}
+	}
+
+	return sel_bar;
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_host_find_min_bar);
+
+enum cdns_pcie_rp_bar
+cdns_pcie_host_find_max_bar(struct cdns_pcie_rc *rc, u64 size)
+{
+	enum cdns_pcie_rp_bar bar, sel_bar;
+
+	sel_bar = RP_BAR_UNDEFINED;
+	for (bar = RP_BAR0; bar <= RP_NO_BAR; bar++) {
+		if (!rc->avail_ib_bar[bar])
+			continue;
+
+		if (size >= bar_max_size[bar]) {
+			if (sel_bar == RP_BAR_UNDEFINED) {
+				sel_bar = bar;
+				continue;
+			}
+
+			if (bar_max_size[bar] > bar_max_size[sel_bar])
+				sel_bar = bar;
+		}
+	}
+
+	return sel_bar;
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_host_find_max_bar);
+
+int cdns_pcie_host_dma_ranges_cmp(void *priv, const struct list_head *a,
+				  const struct list_head *b)
+{
+	struct resource_entry *entry1, *entry2;
+
+	entry1 = container_of(a, struct resource_entry, node);
+	entry2 = container_of(b, struct resource_entry, node);
+
+	return resource_size(entry2->res) - resource_size(entry1->res);
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_host_dma_ranges_cmp);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cadence PCIe host controller driver");
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-common.h b/drivers/pci/controller/cadence/pcie-cadence-host-common.h
new file mode 100644
index 000000000000..dabf77986cca
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Cadence PCIe Host controller driver.
+ *
+ * Copyright (c) 2017 Cadence
+ * Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
+ */
+#ifndef _PCIE_CADENCE_HOST_COMMON_H
+#define _PCIE_CADENCE_HOST_COMMON_H
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+
+extern u64 bar_max_size[];
+
+int cdns_pcie_host_training_complete(struct cdns_pcie *pcie);
+int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie);
+int cdns_pcie_retrain(struct cdns_pcie *pcie);
+int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc);
+enum cdns_pcie_rp_bar
+cdns_pcie_host_find_min_bar(struct cdns_pcie_rc *rc, u64 size);
+enum cdns_pcie_rp_bar
+cdns_pcie_host_find_max_bar(struct cdns_pcie_rc *rc, u64 size);
+int cdns_pcie_host_dma_ranges_cmp(void *priv, const struct list_head *a,
+				  const struct list_head *b);
+#endif /* _PCIE_CADENCE_HOST_COMMON_H */
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 59a4631de79f..bfdd0f200cfb 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -12,14 +12,7 @@
 #include <linux/platform_device.h>
 
 #include "pcie-cadence.h"
-
-#define LINK_RETRAIN_TIMEOUT HZ
-
-static u64 bar_max_size[] = {
-	[RP_BAR0] = _ULL(128 * SZ_2G),
-	[RP_BAR1] = SZ_2G,
-	[RP_NO_BAR] = _BITULL(63),
-};
+#include "pcie-cadence-host-common.h"
 
 static u8 bar_aperture_mask[] = {
 	[RP_BAR0] = 0x1F,
@@ -81,77 +74,6 @@ static struct pci_ops cdns_pcie_host_ops = {
 	.write		= pci_generic_config_write,
 };
 
-static int cdns_pcie_host_training_complete(struct cdns_pcie *pcie)
-{
-	u32 pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
-	unsigned long end_jiffies;
-	u16 lnk_stat;
-
-	/* Wait for link training to complete. Exit after timeout. */
-	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
-	do {
-		lnk_stat = cdns_pcie_rp_readw(pcie, pcie_cap_off + PCI_EXP_LNKSTA);
-		if (!(lnk_stat & PCI_EXP_LNKSTA_LT))
-			break;
-		usleep_range(0, 1000);
-	} while (time_before(jiffies, end_jiffies));
-
-	if (!(lnk_stat & PCI_EXP_LNKSTA_LT))
-		return 0;
-
-	return -ETIMEDOUT;
-}
-
-static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
-{
-	struct device *dev = pcie->dev;
-	int retries;
-
-	/* Check if the link is up or not */
-	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
-		if (cdns_pcie_link_up(pcie)) {
-			dev_info(dev, "Link up\n");
-			return 0;
-		}
-		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
-	}
-
-	return -ETIMEDOUT;
-}
-
-static int cdns_pcie_retrain(struct cdns_pcie *pcie)
-{
-	u32 lnk_cap_sls, pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
-	u16 lnk_stat, lnk_ctl;
-	int ret = 0;
-
-	/*
-	 * Set retrain bit if current speed is 2.5 GB/s,
-	 * but the PCIe root port support is > 2.5 GB/s.
-	 */
-
-	lnk_cap_sls = cdns_pcie_readl(pcie, (CDNS_PCIE_RP_BASE + pcie_cap_off +
-					     PCI_EXP_LNKCAP));
-	if ((lnk_cap_sls & PCI_EXP_LNKCAP_SLS) <= PCI_EXP_LNKCAP_SLS_2_5GB)
-		return ret;
-
-	lnk_stat = cdns_pcie_rp_readw(pcie, pcie_cap_off + PCI_EXP_LNKSTA);
-	if ((lnk_stat & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB) {
-		lnk_ctl = cdns_pcie_rp_readw(pcie,
-					     pcie_cap_off + PCI_EXP_LNKCTL);
-		lnk_ctl |= PCI_EXP_LNKCTL_RL;
-		cdns_pcie_rp_writew(pcie, pcie_cap_off + PCI_EXP_LNKCTL,
-				    lnk_ctl);
-
-		ret = cdns_pcie_host_training_complete(pcie);
-		if (ret)
-			return ret;
-
-		ret = cdns_pcie_host_wait_for_link(pcie);
-	}
-	return ret;
-}
-
 static void cdns_pcie_host_disable_ptm_response(struct cdns_pcie *pcie)
 {
 	u32 val;
@@ -168,23 +90,6 @@ static void cdns_pcie_host_enable_ptm_response(struct cdns_pcie *pcie)
 	cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val | CDNS_PCIE_LM_TPM_CTRL_PTMRSEN);
 }
 
-static int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc)
-{
-	struct cdns_pcie *pcie = &rc->pcie;
-	int ret;
-
-	ret = cdns_pcie_host_wait_for_link(pcie);
-
-	/*
-	 * Retrain link for Gen2 training defect
-	 * if quirk flag is set.
-	 */
-	if (!ret && rc->quirk_retrain_flag)
-		ret = cdns_pcie_retrain(pcie);
-
-	return ret;
-}
-
 static void cdns_pcie_host_deinit_root_port(struct cdns_pcie_rc *rc)
 {
 	struct cdns_pcie *pcie = &rc->pcie;
@@ -290,54 +195,6 @@ static int cdns_pcie_host_bar_ib_config(struct cdns_pcie_rc *rc,
 	return 0;
 }
 
-static enum cdns_pcie_rp_bar
-cdns_pcie_host_find_min_bar(struct cdns_pcie_rc *rc, u64 size)
-{
-	enum cdns_pcie_rp_bar bar, sel_bar;
-
-	sel_bar = RP_BAR_UNDEFINED;
-	for (bar = RP_BAR0; bar <= RP_NO_BAR; bar++) {
-		if (!rc->avail_ib_bar[bar])
-			continue;
-
-		if (size <= bar_max_size[bar]) {
-			if (sel_bar == RP_BAR_UNDEFINED) {
-				sel_bar = bar;
-				continue;
-			}
-
-			if (bar_max_size[bar] < bar_max_size[sel_bar])
-				sel_bar = bar;
-		}
-	}
-
-	return sel_bar;
-}
-
-static enum cdns_pcie_rp_bar
-cdns_pcie_host_find_max_bar(struct cdns_pcie_rc *rc, u64 size)
-{
-	enum cdns_pcie_rp_bar bar, sel_bar;
-
-	sel_bar = RP_BAR_UNDEFINED;
-	for (bar = RP_BAR0; bar <= RP_NO_BAR; bar++) {
-		if (!rc->avail_ib_bar[bar])
-			continue;
-
-		if (size >= bar_max_size[bar]) {
-			if (sel_bar == RP_BAR_UNDEFINED) {
-				sel_bar = bar;
-				continue;
-			}
-
-			if (bar_max_size[bar] > bar_max_size[sel_bar])
-				sel_bar = bar;
-		}
-	}
-
-	return sel_bar;
-}
-
 static int cdns_pcie_host_bar_config(struct cdns_pcie_rc *rc,
 				     struct resource_entry *entry)
 {
@@ -410,17 +267,6 @@ static int cdns_pcie_host_bar_config(struct cdns_pcie_rc *rc,
 	return 0;
 }
 
-static int cdns_pcie_host_dma_ranges_cmp(void *priv, const struct list_head *a,
-					 const struct list_head *b)
-{
-	struct resource_entry *entry1, *entry2;
-
-        entry1 = container_of(a, struct resource_entry, node);
-        entry2 = container_of(b, struct resource_entry, node);
-
-        return resource_size(entry2->res) - resource_size(entry1->res);
-}
-
 static void cdns_pcie_host_unmap_dma_ranges(struct cdns_pcie_rc *rc)
 {
 	struct cdns_pcie *pcie = &rc->pcie;
-- 
2.49.0


