Return-Path: <linux-pci+bounces-31047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B5CAED35F
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 06:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78981173714
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 04:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA4820101F;
	Mon, 30 Jun 2025 04:16:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022096.outbound.protection.outlook.com [40.107.75.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278472905;
	Mon, 30 Jun 2025 04:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751256980; cv=fail; b=lV0CN50XafREaX+oXIewS+VlyIeVRbRPNL2ETs5/WJ42lcnBY0JRpHaNMfj1XJvnHyqAt/tP1p7j6jPWxnx2W1ZWPVmrM5J7o7nqUfTuSx4gIhjX7AAa+DTlbja38CjQCwYPDg7jp2trFmz8AQ+lWcZAVDIulBW0pw980OQku+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751256980; c=relaxed/simple;
	bh=asH9lSAAQe9RdRC4sni5KD8YW5yZwnPgIY4yjcBa600=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NTdKeN/wV5cKZP6tXgsVu+veekOWrYDA8oG1R+pt9TlIXa7ghW1Nwuj6zePuxIrZYYg4EU/LY9qCzsa8IlRKabE4sfZWcBq8z1POk5znilkwV2mwsIbEWSnyeuaqpDQkm8aKJsvlhTJCdp9gxxJD151BrEuzKCjW9mgQY0UHKXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikO6URBe+6dZ+o1i9l4qCG2qGFkR/0eAxsUk6L7Seili5kx0LjipbDUeT8J1p72LJ9OSbRWdkMNukchyEk6tglKi0sNgMSurAKKRrzJVRBAW96mwIkrXRcEUmdBu1T/9F4cnFla6e6G6srAsvCGoTtzPvKJMC6HIMGe1J/uIRHp7zk4eeGsx+VKva56qk4MEUm++aKTVoER4QV840s8kaFUi9uSk4/3TBbzDBAHe6qWVIqVyNIX9RKUpvrrRBOArq37w0sD6FGWvuoFWUVnVCcV3Gi4EFsAn/D88wrPRUlrjq3326i31G1kUw0PAN/BdSGs/VM9T34C5/3XDVawbug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vg71rlGmOqvj/sq4bXKJPBoPOHjSMlz3fhX0aEbxICc=;
 b=nR+rP1s/phirIr1xnIgCYy4oTnLCSsWlIG4qCc2g2bgLlHtI8eqZveyiQ26nsq3V5ujiZEzsnAA5S8aBIkga+mNLOzJMKmawbvgHmdUs+T6MEHps/HmngMJdJlGprKTs88W/OO5jKPE98DE+31kL2xJZEAstv5TO5fdKLXHqZ1ErYKdP4ieYRZrjWnCbDnwvXQBlLPvSTklLi0inJz02dE/lQj4PXZRI1/WmftzDabRlNrGG5J5VjBCbNifs8yOeOOOfH+wcfQsk97I5v5xwufF8Ttz6O9NkHQDI4yQXI+JccEg32yuinc8q1RI33+2qjYaciOhbkLsDil4vCvfiKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCPR01CA0121.jpnprd01.prod.outlook.com (2603:1096:400:26d::8)
 by KUZPR06MB8027.apcprd06.prod.outlook.com (2603:1096:d10:48::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Mon, 30 Jun
 2025 04:16:11 +0000
Received: from TY2PEPF0000AB8A.apcprd03.prod.outlook.com
 (2603:1096:400:26d:cafe::e6) by TYCPR01CA0121.outlook.office365.com
 (2603:1096:400:26d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.30 via Frontend Transport; Mon,
 30 Jun 2025 04:16:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB8A.mail.protection.outlook.com (10.167.253.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 04:16:10 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id D4D184160500;
	Mon, 30 Jun 2025 12:16:06 +0800 (CST)
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
Subject: [PATCH v5 11/14] PCI: sky1: Add PCIe host support for CIX Sky1
Date: Mon, 30 Jun 2025 12:15:58 +0800
Message-ID: <20250630041601.399921-12-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630041601.399921-1-hans.zhang@cixtech.com>
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB8A:EE_|KUZPR06MB8027:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8f0f57b0-c4ef-4205-c207-08ddb78cd83e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XVubkCsTbvrO3oU/IwffK+gr4CkRiw/26o4AbQf76QSPjuVC1+OTo5hRkdK4?=
 =?us-ascii?Q?UkJejv9JwVRSquVWB0agIxV46OwciF5NCnwpyfPtokQKP8fdMmmazCiOtdal?=
 =?us-ascii?Q?6zGl/ddq7G2zFWM6XcqydnNUYxCSVgJo3EM2qFYwEqFEBNMEf4ctigkPW1bz?=
 =?us-ascii?Q?C73LP3vDw+AwF10GHYjFtV9aFzUsLkEFR57fIeZR+8DBc8rlxczk9obV4ueg?=
 =?us-ascii?Q?+K47SL39H430Kf91PSvlBWw2oHQ+bjLTzRWjLqQHKsnSt3ajGGzOfiGS69JE?=
 =?us-ascii?Q?kUF0vsHtXlormdKbOAedy0IgqSgGThM4WMwKoN/WJlBkOIPdeiMJA3zKjJWr?=
 =?us-ascii?Q?kqOFUiFBF7dgGmuUqzgGqv8uB/zmhdZAJZFHa56eMEniBkPZ1nnApDLVp2XY?=
 =?us-ascii?Q?0BE/F+reERSbaHFmyBILxfbnWs7pOgi1CV3EsxmvDLxa4loID/zQsWD6ONFS?=
 =?us-ascii?Q?heftSvdW8nBl6lUScBPXYcQXHUu7i/6a2x4X8pcxYjk5H/3zigcNjLzENBeX?=
 =?us-ascii?Q?qcdLGZ61GtcR2JJEZ9qGz36dbinQXoJZY1AkxCeMY55E8ze3eBSjQdUbx0uQ?=
 =?us-ascii?Q?v5ym7NAvpMpdXSGYJwZpNTBgc9itgBD/L6MbNjVMzHOFQI+qk4x3m1QfXIY7?=
 =?us-ascii?Q?HzHI6yszKMOf62gx+rBsxUahqJjGKh4I+4HP1cNqnHY85DUXdp5B+tOmHR3v?=
 =?us-ascii?Q?0d3acE0PWasJjFpb1wB9h7JC12MoLt1QGwooAwXEou3nKq8GXrlIfr2otGeJ?=
 =?us-ascii?Q?ddXrt5Y07X+8m/ZkINpuWwp200QHtnAa6rN74M29rHCLCN+8WwrA6qmbFxAC?=
 =?us-ascii?Q?zqHjoe6n71Qj98oAWC01fT1v5gY1yr9qUt7eUkFp9IN17Vu+m/RdI2nRKUqX?=
 =?us-ascii?Q?K/xyEtyEMZ9g8Tw6HIQTakHQMWAO9RBC4uZVIUj9WVHsut4Vggc5KKNumEky?=
 =?us-ascii?Q?ORAKU1Z0wSuqj/qHSoeC10Z+vhyCqDbhSYHeecR+pvMVrK1mdQBPVNgjpXg0?=
 =?us-ascii?Q?J7q0Z+SJBIHbqfKT+Db4NTQ8aS6CACFs32cvoPZkDXCtcm47VNlb9ZxZaajc?=
 =?us-ascii?Q?1Wkcr6tCRfcP63tv0lPTai4vfASEbK2JfbO4+tWsE6cDDarTOrs0sGoqlw59?=
 =?us-ascii?Q?lpIM8TEtxoguPyzHx5hGIIlnPCyJvZgVZTejkbuWFm5laNlBjMG9tORzT1J0?=
 =?us-ascii?Q?Oj0QwmoWMLB2U5B4nmsWb7tJQ3XkKb0Iu07Eg9bJPkLYG/QPJ1ZkMD9JIGEo?=
 =?us-ascii?Q?wXa79ciw8ifLvTRxxFjWFYWmq/68o32cjQhGhpmWgTsyza+TfXIgCNtpgywB?=
 =?us-ascii?Q?SSOVF2VT1FXhUm/UOisCjzgkSmjYxsGARzRSJXu44/3uiOAVhhyBXhuI9lHo?=
 =?us-ascii?Q?7uU5+2/1Y5mUV00anfhHBlTLVsRFe4B04evfqlTkeKfgMIELNrbFV2AC7D9n?=
 =?us-ascii?Q?CUGclyFnKqI4BohgqRcASW4pP8kUxFZP+1FQdBWNjipW2naobnmJdqGTK9Np?=
 =?us-ascii?Q?cB/Wu3rqJDy1gq0dVNXPrc4FFh9jqx4xRcEV?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 04:16:10.5392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0f57b0-c4ef-4205-c207-08ddb78cd83e
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB8A.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8027

From: Hans Zhang <hans.zhang@cixtech.com>

Add driver for the CIX Sky1 SoC PCIe Gen4 16 GT/s controller based
on the Cadence PCIe core.

Supports MSI/MSI-x via GICv3, Single Virtual Channel, Single Function.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
Reviewed-by: Peter Chen <peter.chen@cixtech.com>
Reviewed-by: Manikandan K Pillai <mpillai@cadence.com>
---
 drivers/pci/controller/cadence/Kconfig    |  16 +
 drivers/pci/controller/cadence/Makefile   |   1 +
 drivers/pci/controller/cadence/pci-sky1.c | 435 ++++++++++++++++++++++
 3 files changed, 452 insertions(+)
 create mode 100644 drivers/pci/controller/cadence/pci-sky1.c

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index 427aa9beca22..63993495b20d 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -80,4 +80,20 @@ config PCI_J721E_EP
 	  Say Y here if you want to support the TI J721E PCIe platform
 	  controller in endpoint mode. TI J721E PCIe controller uses Cadence PCIe
 	  core.
+
+config PCI_SKY1
+	bool
+
+config PCI_SKY1_HOST
+	tristate "CIX SKY1 PCIe controller (host mode)"
+	depends on OF
+	select PCIE_CADENCE_HOST
+	select PCI_SKY1
+	help
+	  Say Y here if you want to support the CIX SKY1 PCIe platform
+	  controller in host mode. CIX SKY1 PCIe controller uses Cadence HPA(High
+	  Performance Architecture IP[Second generation of cadence PCIe IP])
+
+	  This driver requires Cadence PCIe core infrastructure (PCIE_CADENCE_HOST)
+	  and hardware platform adaptation layer to function.
 endmenu
diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
index f8575a0eee2d..cfe8c89c0427 100644
--- a/drivers/pci/controller/cadence/Makefile
+++ b/drivers/pci/controller/cadence/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o pcie-cadence-ep-hpa.o
 obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
 obj-$(CONFIG_PCIE_CADENCE_PLAT_HPA) += pcie-cadence-plat-hpa.o
 obj-$(CONFIG_PCI_J721E) += pci-j721e.o
+obj-$(CONFIG_PCI_SKY1) += pci-sky1.o
diff --git a/drivers/pci/controller/cadence/pci-sky1.c b/drivers/pci/controller/cadence/pci-sky1.c
new file mode 100644
index 000000000000..a4828b92159e
--- /dev/null
+++ b/drivers/pci/controller/cadence/pci-sky1.c
@@ -0,0 +1,435 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pci-sky1 - PCIe controller driver for CIX's sky1 SoCs
+ *
+ * Author: Hans Zhang <hans.zhang@cixtech.com>
+ */
+
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pci.h>
+#include <linux/pci-ecam.h>
+
+#include "../../pci.h"
+#include "pcie-cadence.h"
+#include "pcie-cadence-host-common.h"
+
+#define STRAP_REG(n) ((n) * 0x04)
+#define STATUS_REG(n) ((n) * 0x04)
+
+#define RCSU_STRAP_REG 0x300
+#define RCSU_STATUS_REG 0x400
+
+#define RCSU_STRAP_STATUS_SUBREG_X2 0x40
+#define RCSU_STRAP_STATUS_SUBREG_X10 0x60
+#define RCSU_STRAP_STATUS_SUBREG_X11 0x80
+
+#define SKY1_IP_REG_BANK_OFFSET 0x1000
+#define SKY1_IP_CFG_CTRL_REG_BANK_OFFSET 0x4c00
+#define SKY1_IP_AXI_MASTER_COMMON_OFFSET 0xf000
+#define SKY1_AXI_SLAVE_OFFSET 0x9000
+#define SKY1_AXI_MASTER_OFFSET 0xb000
+#define SKY1_AXI_HLS_REGISTERS_OFFSET 0xc000
+#define SKY1_AXI_RAS_REGISTERS_OFFSET 0xe000
+#define SKY1_DTI_REGISTERS_OFFSET 0xd000
+
+#define IP_REG_I_DBG_STS_0 0x420
+
+#define LINK_TRAINING_ENABLE BIT(0)
+#define LINK_COMPLETE BIT(0)
+#define SKY1_MAX_LANES 8
+
+#define BYPASS_PHASE23_MASK BIT(26)
+#define BYPASS_REMOTE_TX_EQ_MASK BIT(25)
+#define DC_MAX_EVAL_ITERATION_MASK GENMASK(24, 18)
+#define LANE_COUNT_IN_MASK GENMASK(17, 15)
+#define PCIE_RATE_MAX_MASK GENMASK(14, 12)
+#define SUPPORTED_PRESET_MASK GENMASK(10, 0)
+
+enum sky1_pcie_id {
+	PCIE_ID_x8,
+	PCIE_ID_x4,
+	PCIE_ID_x2,
+	PCIE_ID_x1_1,
+	PCIE_ID_x1_0,
+};
+
+struct sky1_def_speed_lane {
+	u32 link_speed;
+	u32 max_lanes;
+};
+
+struct sky1_pcie_data {
+	const struct sky1_def_speed_lane *speed_lane;
+	struct cdns_plat_pcie_of_data reg_off;
+};
+
+struct sky1_pcie {
+	struct device *dev;
+	const struct sky1_pcie_data *data;
+	const struct sky1_def_speed_lane *speed_lane;
+	struct cdns_pcie *cdns_pcie;
+	struct cdns_pcie_rc *cdns_pcie_rc;
+
+	struct resource *cfg_res;
+	struct resource *msg_res;
+	struct pci_config_window *cfg;
+	void __iomem *rcsu_base;
+	void __iomem *strap_base;
+	void __iomem *status_base;
+	void __iomem *reg_base;
+	void __iomem *cfg_base;
+	void __iomem *msg_base;
+
+	u32 id;
+	u32 link_speed;
+	u32 num_lanes;
+};
+
+static const struct sky1_def_speed_lane def_speed_lane[] = {
+	[PCIE_ID_x8] = { 4, 8 },
+	[PCIE_ID_x4] = { 4, 4 },
+	[PCIE_ID_x2] = { 4, 2 },
+	[PCIE_ID_x1_1] = { 4, 1 },
+	[PCIE_ID_x1_0] = { 4, 1 },
+};
+
+static void sky1_pcie_clear_and_set_dword(void __iomem *addr, u32 clear,
+					  u32 set)
+{
+	u32 val;
+
+	val = readl(addr);
+	val &= ~clear;
+	val |= set;
+	writel(val, addr);
+}
+
+static void sky1_pcie_init_bases(struct sky1_pcie *pcie)
+{
+	u32 strap = 0, status = 0;
+
+	switch (pcie->id) {
+	case PCIE_ID_x1_1:
+		strap = status = RCSU_STRAP_STATUS_SUBREG_X11;
+		break;
+	case PCIE_ID_x1_0:
+		strap = status = RCSU_STRAP_STATUS_SUBREG_X10;
+		break;
+	case PCIE_ID_x2:
+		strap = status = RCSU_STRAP_STATUS_SUBREG_X2;
+		break;
+	case PCIE_ID_x8:
+	case PCIE_ID_x4:
+	default:
+		break;
+	}
+
+	pcie->strap_base = pcie->rcsu_base + RCSU_STRAP_REG + strap;
+	pcie->status_base = pcie->rcsu_base + RCSU_STATUS_REG + status;
+}
+
+static int sky1_pcie_parse_mem(struct sky1_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct resource *res;
+	void __iomem *base;
+	int ret = 0;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rcsu");
+	if (!res) {
+		dev_err(dev, "Parse \"rcsu\" resource err\n");
+		return -ENXIO;
+	}
+	pcie->rcsu_base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!pcie->rcsu_base) {
+		dev_err(dev, "ioremap failed for resource %pR\n", res);
+		return -ENOMEM;
+	}
+
+	base = devm_platform_ioremap_resource_byname(pdev, "reg");
+	if (IS_ERR(base)) {
+		dev_err(dev, "Parse \"reg\" resource err\n");
+		return PTR_ERR(base);
+	}
+	pcie->reg_base = base;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "msg");
+	if (!res) {
+		dev_err(dev, "Parse \"msg\" resource err\n");
+		return -ENXIO;
+	}
+	pcie->msg_res = res;
+	pcie->msg_base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!pcie->msg_base) {
+		dev_err(dev, "ioremap failed for resource %pR\n", res);
+		return -ENOMEM;
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
+	if (!res) {
+		dev_err(dev, "Parse \"cfg\" resource err\n");
+		return -ENXIO;
+	}
+	pcie->cfg_res = res;
+
+	return ret;
+}
+
+static int sky1_pcie_parse_ctrl_id(struct sky1_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+	int id, ret = 0;
+
+	ret = of_property_read_u32(dev->of_node, "sky1,pcie-ctrl-id", &id);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read sky1,pcie-ctrl-id: %d\n", ret);
+		return ret;
+	}
+
+	if ((id < PCIE_ID_x8) || (id > PCIE_ID_x1_0)) {
+		dev_err(dev, "get illegal pcie-ctrl-id %d\n", id);
+		return -EINVAL;
+	}
+	pcie->id = id;
+	pcie->speed_lane = &def_speed_lane[id];
+
+	return ret;
+}
+
+static void sky1_pcie_parse_link_speed(struct sky1_pcie *pcie)
+{
+	int link_speed;
+
+	link_speed = of_pci_get_max_link_speed(pcie->dev->of_node);
+	if (link_speed < 0)
+		link_speed = pcie->speed_lane->link_speed;
+	pcie->link_speed = link_speed;
+}
+
+static int sky1_pcie_parse_num_lanes(struct sky1_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+	int ret = 0;
+	u32 lanes;
+
+	ret = of_property_read_u32(dev->of_node, "num-lanes", &lanes);
+	if (ret) {
+		dev_err(dev, "error:%x, lane number:%d\n", ret, lanes);
+		ret = -EINVAL;
+		return ret;
+	}
+
+	if ((lanes < 1) || (lanes > pcie->speed_lane->max_lanes))
+		lanes = pcie->speed_lane->max_lanes;
+	pcie->num_lanes = lanes;
+
+	return ret;
+}
+
+static int sky1_pcie_get_max_lane_count(struct sky1_pcie *pcie)
+{
+	if (is_power_of_2(pcie->num_lanes) && pcie->num_lanes <= SKY1_MAX_LANES)
+		return ilog2(pcie->num_lanes);
+
+	pcie->num_lanes = 1;
+	return pcie->num_lanes;
+}
+
+static void sky1_pcie_set_strap_pin0(struct sky1_pcie *pcie)
+{
+	u32 val;
+
+	val = readl(pcie->strap_base + STRAP_REG(0));
+
+	/* clear bypass_phase23 and bypass_remote_eq */
+	val &= ~(BYPASS_PHASE23_MASK | BYPASS_REMOTE_TX_EQ_MASK);
+
+	/* set iteration timeout */
+	val &= ~DC_MAX_EVAL_ITERATION_MASK;
+	val |= FIELD_PREP(DC_MAX_EVAL_ITERATION_MASK, 0x2);
+
+	/* set support preset val */
+	val &= ~SUPPORTED_PRESET_MASK;
+	val |= FIELD_PREP(SUPPORTED_PRESET_MASK, 0x7ff);
+
+	/* Set link speed */
+	val &= ~PCIE_RATE_MAX_MASK;
+	val |= FIELD_PREP(PCIE_RATE_MAX_MASK, pcie->link_speed - 1);
+
+	/* Set lane number */
+	val &= ~LANE_COUNT_IN_MASK;
+	val |= FIELD_PREP(LANE_COUNT_IN_MASK,
+		sky1_pcie_get_max_lane_count(pcie));
+
+	writel(val, pcie->strap_base + STRAP_REG(0));
+}
+
+static int sky1_pcie_parse_property(struct platform_device *pdev,
+				    struct sky1_pcie *pcie)
+{
+	int ret = 0;
+
+	ret = sky1_pcie_parse_ctrl_id(pcie);
+	if (ret < 0)
+		return ret;
+
+	sky1_pcie_parse_link_speed(pcie);
+
+	ret = sky1_pcie_parse_num_lanes(pcie);
+	if (ret < 0)
+		return ret;
+
+	ret = sky1_pcie_parse_mem(pcie);
+	if (ret < 0)
+		return ret;
+
+	sky1_pcie_init_bases(pcie);
+
+	return ret;
+}
+
+static int sky1_pcie_start_link(struct cdns_pcie *cdns_pcie)
+{
+	struct sky1_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
+
+	sky1_pcie_clear_and_set_dword(pcie->strap_base + STRAP_REG(1),
+				      0, LINK_TRAINING_ENABLE);
+
+	return 0;
+}
+
+static void sky1_pcie_stop_link(struct cdns_pcie *cdns_pcie)
+{
+	struct sky1_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
+
+	sky1_pcie_clear_and_set_dword(pcie->strap_base + STRAP_REG(1),
+				      LINK_TRAINING_ENABLE, 0);
+}
+
+
+static bool sky1_pcie_link_up(struct cdns_pcie *cdns_pcie)
+{
+	u32 val;
+
+	val = cdns_pcie_hpa_readl(cdns_pcie, REG_BANK_IP_REG,
+				  IP_REG_I_DBG_STS_0);
+	return val & LINK_COMPLETE;
+}
+
+static const struct cdns_pcie_ops sky1_pcie_ops = {
+	.start_link = sky1_pcie_start_link,
+	.stop_link = sky1_pcie_stop_link,
+	.link_up = sky1_pcie_link_up,
+};
+
+static int sky1_pcie_probe(struct platform_device *pdev)
+{
+	const struct sky1_pcie_data *data;
+	struct device *dev = &pdev->dev;
+	struct pci_host_bridge *bridge;
+	struct cdns_pcie *cdns_pcie;
+	struct resource_entry *bus;
+	struct cdns_pcie_rc *rc;
+	struct sky1_pcie *pcie;
+	int ret;
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -EINVAL;
+
+	pcie->data = data;
+	pcie->dev = dev;
+	dev_set_drvdata(dev, pcie);
+
+	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
+	if (!bridge)
+		return -ENOMEM;
+
+	bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
+	if (!bus)
+		return -ENODEV;
+
+	ret = sky1_pcie_parse_property(pdev, pcie);
+	if (ret < 0)
+		return -ENXIO;
+
+	sky1_pcie_set_strap_pin0(pcie);
+
+	pcie->cfg = pci_ecam_create(dev, pcie->cfg_res, bus->res,
+				    &pci_generic_ecam_ops);
+	if (IS_ERR(pcie->cfg))
+		return PTR_ERR(pcie->cfg);
+
+	bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
+	rc = pci_host_bridge_priv(bridge);
+	rc->ecam_support_flag = 1;
+	rc->cfg_base = pcie->cfg->win;
+	rc->cfg_res = &pcie->cfg->res;
+
+	cdns_pcie = &rc->pcie;
+	cdns_pcie->dev = dev;
+	cdns_pcie->ops = &sky1_pcie_ops;
+	cdns_pcie->reg_base = pcie->reg_base;
+	cdns_pcie->msg_res = pcie->msg_res;
+	cdns_pcie->cdns_pcie_reg_offsets = &data->reg_off;
+	cdns_pcie->is_rc = data->reg_off.is_rc;
+
+	pcie->cdns_pcie = cdns_pcie;
+	pcie->cdns_pcie_rc = rc;
+	pcie->cfg_base = rc->cfg_base;
+	bridge->sysdata = pcie->cfg;
+
+	ret = cdns_pcie_hpa_host_setup(rc);
+	if (ret < 0) {
+		pci_ecam_free(pcie->cfg);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct sky1_pcie_data sky1_pcie_rc_data = {
+	.speed_lane = &def_speed_lane[0],
+	.reg_off = {
+		.is_rc = true,
+		.ip_reg_bank_offset = SKY1_IP_REG_BANK_OFFSET,
+		.ip_cfg_ctrl_reg_offset = SKY1_IP_CFG_CTRL_REG_BANK_OFFSET,
+		.axi_mstr_common_offset = SKY1_IP_AXI_MASTER_COMMON_OFFSET,
+		.axi_slave_offset = SKY1_AXI_SLAVE_OFFSET,
+		.axi_master_offset = SKY1_AXI_MASTER_OFFSET,
+		.axi_hls_offset = SKY1_AXI_HLS_REGISTERS_OFFSET,
+		.axi_ras_offset = SKY1_AXI_RAS_REGISTERS_OFFSET,
+		.axi_dti_offset = SKY1_DTI_REGISTERS_OFFSET,
+	},
+};
+
+static const struct of_device_id of_sky1_pcie_match[] = {
+	{
+		.compatible = "cix,sky1-pcie-host",
+		.data = &sky1_pcie_rc_data,
+	},
+	{},
+};
+
+static void sky1_pcie_remove(struct platform_device *pdev)
+{
+	struct sky1_pcie *pcie = platform_get_drvdata(pdev);
+
+	pci_ecam_free(pcie->cfg);
+}
+
+static struct platform_driver sky1_pcie_driver = {
+	.probe  = sky1_pcie_probe,
+	.remove = sky1_pcie_remove,
+	.driver = {
+		.name = "sky1-pcie",
+		.of_match_table = of_sky1_pcie_match,
+	},
+};
+module_platform_driver(sky1_pcie_driver);
-- 
2.49.0


