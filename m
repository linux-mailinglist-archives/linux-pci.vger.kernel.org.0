Return-Path: <linux-pci+bounces-35209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21080B3D601
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 01:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718E318945A4
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 23:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E4727AC43;
	Sun, 31 Aug 2025 23:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OKKAfkN4"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3AB274FDB;
	Sun, 31 Aug 2025 23:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756683200; cv=fail; b=THx+zEVdLWac6q0PDqVZgFsrRcKTf+0mYkt2gwaKDRga+v8NT0Tb/9kfEfWNwsHfLzFKz5NOr4T51zsxUoqsQU2O2R1vLnfBlQLQU4n9lwGV/zDjACeGMtO0fbPzmkgmmjD4e6KaIIZfPn6icxOD5bLyy9MleyeDrhSz8qBcKt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756683200; c=relaxed/simple;
	bh=Jp9sAvHL6CX98353pWEllyNpXDMmNK8irA/KH0Z2yZg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/Na+wvBX67LNjTswPIns2LNN1mUWP67EE0eVwoq1Wo5dx5TlWvobMC0sLnOdQVhYwMA3ivj1jBQn2aV7ueX5GhI7a7IR8qHJDFAdhvk7FnAvKzuKOGPwxmokRlFam8NvsvxMQ4rAQFFUMUUl5t32zQTucMod/xx01exN6n4GAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OKKAfkN4; arc=fail smtp.client-ip=40.107.102.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFcGyiEh9noqs9S0RlRu87ofpYInhqitxRYb3u4tFi7rkDbmJSwX5utrMbcibCaX8WarAd8HyioN3f4xVsWugoDXsMOe46MiGto2BWKORJWEoDQjLJxyoT/S9a5U1v4KeWvcRbF21JHn6YlyKh05wbXDw1xfmUh3Qg8Dv8qxcy39yPHY7k6LU+Tus2wKIXkUFAwRqlfD7HlkUQ7qnikgk6EPS6MiMZxdlITojbBKjxzpCKhDzog30Y9jUFqZefhndWA3bIjE/IoSDt3umcklE+ELUaSbFT6N8fNt+L0dlE8WWU3lCRWJN+rFblgn5VZ0/fl2sCVY3QPOBnEP+iHPYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7XAfQegnIapW7HTU9nrmLiGfFWJaStkTZMtYA/OKR8=;
 b=wmj6xEUWvErqOB2MfLaSqZbs5fwBSMH94zqcPaGu5w9IZQi1ttIsf49qxneLbk+xn+cKFBNI9IySbSTQk0yniwRgMRFaq4kZ8Ob2QrTwmWvo4HAYF85dcak+nFxfFEqu6B+PSyXVUYW6yZzKnA3/eK+JBHvqjgppTkqM2YbPieADZi57f5wOXVLdYIiEpmEFaMQIqcs66flcUurYccSStdQAuecyA4XbNzPHX5bKYtSIVGUF3AM5yKeULQGLgr6lRZr7sFofLeE8W6DttCBWz/VF7ZXq/MqgvFH3zuvMfTs6qp1AJbNjVUzxZWgRN2CdujwgzV+C4snhGXo6C+lUCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7XAfQegnIapW7HTU9nrmLiGfFWJaStkTZMtYA/OKR8=;
 b=OKKAfkN4gYh7FYE13VwyUVlwLzOP7IXwdcMlonZjMqpUr90U0lRinAnLswM2kAfGt/Og1YrcOjn0AI0sqUhzJY6MFjS9zW0lmfTQKJk/MtjVy7I0tr8HufOhIKzFljUS9tUsLCt0arW3cree9/75IlRaOl+ZrK83MQpkJRpck7R7SqumRX4MzkDubY62EJ7R+RSxw7PLJRu2pbGJO6JexS2oquWZ7N5GX2r5vUem2HWuCGkraLsnA3PgOMBGK4zssmlAta93xCoY/oHXxtBRyV/wwSwmD0KqeLmYTh68e7t8DULugvH619Hpn6YnUFfaaNUpOA6DCaqle3VxFwlrdQ==
Received: from BY5PR13CA0014.namprd13.prod.outlook.com (2603:10b6:a03:180::27)
 by IA1PR12MB7520.namprd12.prod.outlook.com (2603:10b6:208:42f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Sun, 31 Aug
 2025 23:33:13 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::3) by BY5PR13CA0014.outlook.office365.com
 (2603:10b6:a03:180::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.15 via Frontend Transport; Sun,
 31 Aug 2025 23:33:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Sun, 31 Aug 2025 23:33:12 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 16:32:51 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 16:32:50 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 31 Aug 2025 16:32:46 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, <jgg@nvidia.com>, <bhelgaas@google.com>
CC: <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <sven@kernel.org>, <j@jannau.net>,
	<alyssa@rosenzweig.io>, <neal@gompa.dev>, <robin.clark@oss.qualcomm.com>,
	<m.szyprowski@samsung.com>, <krzk@kernel.org>, <alim.akhtar@samsung.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<yong.wu@mediatek.com>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <tjeznach@rivosinc.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <heiko@sntech.de>, <schnelle@linux.ibm.com>,
	<mjrosato@linux.ibm.com>, <gerald.schaefer@linux.ibm.com>,
	<orsonzhai@gmail.com>, <baolin.wang@linux.alibaba.com>,
	<zhang.lyra@gmail.com>, <wens@csie.org>, <jernej.skrabec@gmail.com>,
	<samuel@sholland.org>, <jean-philippe@linaro.org>, <rafael@kernel.org>,
	<lenb@kernel.org>, <yi.l.liu@intel.com>, <cwabbott0@gmail.com>,
	<quic_pbrahma@quicinc.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <asahi@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-samsung-soc@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <linux-rockchip@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-sunxi@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<patches@lists.linux.dev>, <vsethi@nvidia.com>, <helgaas@kernel.org>,
	<etzhao1900@gmail.com>
Subject: [PATCH v4 7/7] pci: Suspend iommu function prior to resetting a device
Date: Sun, 31 Aug 2025 16:31:59 -0700
Message-ID: <cbceeb65dd248fd06e5665dbcb6df4484b2d8958.1756682135.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756682135.git.nicolinc@nvidia.com>
References: <cover.1756682135.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|IA1PR12MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: e96c6974-ef33-4031-2b67-08dde8e6c061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sJNl4fQixJTM+mpj0B9nZbfPWHbarYkGcbAg4fePGMtvlMyFYdi5LMDtrQ6r?=
 =?us-ascii?Q?OiiUhNJ7IgLYGG4e+VvMs7ABpEf4pt2CHt6VFbcnGEz0hLOuZklOr82DP6EF?=
 =?us-ascii?Q?HKYhuQX1THvnoeD2ssE3YLiXOVNEAun6CxYMwZZuuNbfPdyPyt+oBWTr4FSc?=
 =?us-ascii?Q?95qLDJy726RxaejX7D2P3SMolhz1Dd7bXt8LSlRPdsEkGPcYT1YOG/8sPjZ8?=
 =?us-ascii?Q?zTwY+CigYrzuZoqJmZkjovqX5WTu/M4YQmS1xUijyhd2Nf4diWpd6cnNRoHO?=
 =?us-ascii?Q?Y2Riv82hW/KkqLlqnihwtZuDffZOF4KBRCAr6eqOqLLNS+LCE1bx3cOqYn12?=
 =?us-ascii?Q?OqeI0IppOrKOBDT/AVj9mVZ+l5GqVBLvcg2M0JptNjiaedmqeDk8N058Iihg?=
 =?us-ascii?Q?cx9SKjoBdTFZbgVEoeYXUNAGtXP47ORBDgLlVJi2Z7xKrFQ6yWQPme19NRey?=
 =?us-ascii?Q?7w8khm355UpENIFWb/LTy09X9BIDWaX+WNRgWvoCr/0PyUrrKww/MM8MpBfq?=
 =?us-ascii?Q?uJdG3/iwumwMrI58nnR7fgJ3jc/qPQJdv2DxFS8EY1rhmMSpKbT8joM05NaY?=
 =?us-ascii?Q?/yqEdhez79nl1Q3pq7d20fs/eSLnV2QXlDgWWEOuTJ+gbGRvDQocP0hR0LDC?=
 =?us-ascii?Q?gmYbnCj4CqjtUGUoSXN++sWNqCVjU7IAGzq6BOqC3RloMLHv9EglC5ovaSfN?=
 =?us-ascii?Q?GHFtLm3xnZNIN8oFERplH41XaVx7gpSd/6MNWRHSIMMN6jOsAjxgxDTxW51D?=
 =?us-ascii?Q?SlXE41oNEKtsr0+mrUks/go1zoxWoLsdYG797rqpENn2sIW76eJSZr74BGmT?=
 =?us-ascii?Q?nCZiKnpGQdW42u5KiH5hocm7hYX1fNZndwLrXEDfc5ANewGZYXSCkU2TDX1G?=
 =?us-ascii?Q?GORrbdz/O8PyS7XX61Aa/QLhTU72oBmHVlAbkz83g8ofmYO8G1uoIQypIrSD?=
 =?us-ascii?Q?5vu0DBkpgBwasjZnRSSu+4zrik61dbnUGe9CsOg1HdAanXfIkjOLhHrjs7OX?=
 =?us-ascii?Q?s5DymIIhw3+n47USZkBIwkAxfoJto2JsDo/2x+5hzHLKeOys/Z5sHRA0z1/O?=
 =?us-ascii?Q?UAgH3YECNmtpUZwALX9uG5mxSu1ctcYsmizFbSUjuZTJy1PAHi893BZPEGeT?=
 =?us-ascii?Q?jeRX7RStkbfPwRepw8vD9hJenjj89wTr18riXWh5BV8rOrlNMTA7MOSsivTi?=
 =?us-ascii?Q?IkaiIPFNgpxZ5d+jQcqJoNjgYjQ4hPtjwGUwz9c7WbQoEAMEnHvglKMhLdWB?=
 =?us-ascii?Q?KrKMgU/WzNrZfqRZ6YErB8F7hxxNmOYKHYl1IbBtgDoEEGCq+v0EjVTu9jdN?=
 =?us-ascii?Q?M1BkX47OXHzmZnv/HID0mBylnGAH3PiBBiaAG7ZZ922Ai3BWL/Pr8X07wFub?=
 =?us-ascii?Q?uIDgeGtbFNO9ChVMO5ISnqKbGye+njJnviJVE4ZG+su2LlYetM6KqezRLHvu?=
 =?us-ascii?Q?EJ00yySqzxzPjOjHCfK/V4QWi1hjH2LqQBXztx0Cy+OePobj28Xh66qmeTKS?=
 =?us-ascii?Q?E9bywo03XOa031v3EBWHt6c7Xf+l9LdlpKre?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 23:33:12.2393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e96c6974-ef33-4031-2b67-08dde8e6c061
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520

PCIe permits a device to ignore ATS invalidation TLPs, while processing a
reset. This creates a problem visible to the OS where an ATS invalidation
command will time out: e.g. an SVA domain will have no coordination with a
reset event and can racily issue ATS invalidations to a resetting device.

The PCIe spec in sec 10.3.1 IMPLEMENTATION NOTE recommends to disable and
block ATS before initiating a Function Level Reset. It also mentions that
other reset methods could have the same vulnerability as well.

Now iommu_dev_reset_prepare/done() helpers are introduced for this matter.
Use them in all the existing reset functions, which will attach the device
to an IOMMU_DOMAIN_BLOCKED during a reset, so as to allow IOMMU driver to:
 - invoke pci_disable_ats() and pci_enable_ats(), if necessary
 - wait for all ATS invalidations to complete
 - stop issuing new ATS invalidations
 - fence any incoming ATS queries

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/pci/pci.h      |  2 ++
 drivers/pci/pci-acpi.c | 12 ++++++--
 drivers/pci/pci.c      | 68 ++++++++++++++++++++++++++++++++++++++----
 drivers/pci/quirks.c   | 18 ++++++++++-
 4 files changed, 92 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 34f65d69662e9..9700ebca55771 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -106,6 +106,8 @@ void pci_init_reset_methods(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
 int __pci_reset_bus(struct pci_bus *bus);
+int pci_reset_iommu_prepare(struct pci_dev *dev);
+void pci_reset_iommu_done(struct pci_dev *dev);
 
 struct pci_cap_saved_data {
 	u16		cap_nr;
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index ddb25960ea47d..3291424730824 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -969,6 +969,7 @@ void pci_set_acpi_fwnode(struct pci_dev *dev)
 int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
 {
 	acpi_handle handle = ACPI_HANDLE(&dev->dev);
+	int ret = 0;
 
 	if (!handle || !acpi_has_method(handle, "_RST"))
 		return -ENOTTY;
@@ -976,12 +977,19 @@ int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
 	if (probe)
 		return 0;
 
+	ret = pci_reset_iommu_prepare(dev);
+	if (ret) {
+		pci_err(dev, "failed to stop IOMMU\n");
+		return ret;
+	}
+
 	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_RST", NULL, NULL))) {
 		pci_warn(dev, "ACPI _RST failed\n");
-		return -ENOTTY;
+		ret = -ENOTTY;
 	}
 
-	return 0;
+	pci_reset_iommu_done(dev);
+	return ret;
 }
 
 bool acpi_pci_power_manageable(struct pci_dev *dev)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b0f4d98036cdd..b4ca44ea6f494 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/init.h>
+#include <linux/iommu.h>
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/pci.h>
@@ -25,6 +26,7 @@
 #include <linux/logic_pio.h>
 #include <linux/device.h>
 #include <linux/pm_runtime.h>
+#include <linux/pci-ats.h>
 #include <linux/pci_hotplug.h>
 #include <linux/vmalloc.h>
 #include <asm/dma.h>
@@ -95,6 +97,23 @@ bool pci_reset_supported(struct pci_dev *dev)
 	return dev->reset_methods[0] != 0;
 }
 
+/*
+ * Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software disables ATS before
+ * initiating a reset. Notify the iommu driver that enabled ATS.
+ */
+int pci_reset_iommu_prepare(struct pci_dev *dev)
+{
+	if (pci_ats_supported(dev))
+		return iommu_dev_reset_prepare(&dev->dev);
+	return 0;
+}
+
+void pci_reset_iommu_done(struct pci_dev *dev)
+{
+	if (pci_ats_supported(dev))
+		iommu_dev_reset_done(&dev->dev);
+}
+
 #ifdef CONFIG_PCI_DOMAINS
 int pci_domains_supported = 1;
 #endif
@@ -4529,13 +4548,22 @@ EXPORT_SYMBOL(pci_wait_for_pending_transaction);
  */
 int pcie_flr(struct pci_dev *dev)
 {
+	int ret = 0;
+
 	if (!pci_wait_for_pending_transaction(dev))
 		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
 
+	/* Have to call it after waiting for pending DMA transaction */
+	ret = pci_reset_iommu_prepare(dev);
+	if (ret) {
+		pci_err(dev, "failed to stop IOMMU\n");
+		return ret;
+	}
+
 	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
 
 	if (dev->imm_ready)
-		return 0;
+		goto done;
 
 	/*
 	 * Per PCIe r4.0, sec 6.6.2, a device must complete an FLR within
@@ -4544,7 +4572,10 @@ int pcie_flr(struct pci_dev *dev)
 	 */
 	msleep(100);
 
-	return pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
+	ret = pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
+done:
+	pci_reset_iommu_done(dev);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pcie_flr);
 
@@ -4572,6 +4603,7 @@ EXPORT_SYMBOL_GPL(pcie_reset_flr);
 
 static int pci_af_flr(struct pci_dev *dev, bool probe)
 {
+	int ret = 0;
 	int pos;
 	u8 cap;
 
@@ -4598,10 +4630,17 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
 				 PCI_AF_STATUS_TP << 8))
 		pci_err(dev, "timed out waiting for pending transaction; performing AF function level reset anyway\n");
 
+	/* Have to call it after waiting for pending DMA transaction */
+	ret = pci_reset_iommu_prepare(dev);
+	if (ret) {
+		pci_err(dev, "failed to stop IOMMU\n");
+		return ret;
+	}
+
 	pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
 
 	if (dev->imm_ready)
-		return 0;
+		goto done;
 
 	/*
 	 * Per Advanced Capabilities for Conventional PCI ECN, 13 April 2006,
@@ -4611,7 +4650,10 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
 	 */
 	msleep(100);
 
-	return pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
+	ret = pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
+done:
+	pci_reset_iommu_done(dev);
+	return ret;
 }
 
 /**
@@ -4632,6 +4674,7 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
 static int pci_pm_reset(struct pci_dev *dev, bool probe)
 {
 	u16 csr;
+	int ret;
 
 	if (!dev->pm_cap || dev->dev_flags & PCI_DEV_FLAGS_NO_PM_RESET)
 		return -ENOTTY;
@@ -4646,6 +4689,12 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
 	if (dev->current_state != PCI_D0)
 		return -EINVAL;
 
+	ret = pci_reset_iommu_prepare(dev);
+	if (ret) {
+		pci_err(dev, "failed to stop IOMMU\n");
+		return ret;
+	}
+
 	csr &= ~PCI_PM_CTRL_STATE_MASK;
 	csr |= PCI_D3hot;
 	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
@@ -4656,7 +4705,9 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
 	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
 	pci_dev_d3_sleep(dev);
 
-	return pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
+	ret = pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
+	pci_reset_iommu_done(dev);
+	return ret;
 }
 
 /**
@@ -5111,6 +5162,12 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 	if (rc)
 		return -ENOTTY;
 
+	rc = pci_reset_iommu_prepare(dev);
+	if (rc) {
+		pci_err(dev, "failed to stop IOMMU\n");
+		return rc;
+	}
+
 	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR) {
 		val = reg;
 	} else {
@@ -5125,6 +5182,7 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
 				      reg);
 
+	pci_reset_iommu_done(dev);
 	return rc;
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d97335a401930..c1c32e57fe267 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4225,6 +4225,22 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 	{ 0 }
 };
 
+static int __pci_dev_specific_reset(struct pci_dev *dev, bool probe,
+				    const struct pci_dev_reset_methods *i)
+{
+	int ret;
+
+	ret = pci_reset_iommu_prepare(dev);
+	if (ret) {
+		pci_err(dev, "failed to stop IOMMU\n");
+		return ret;
+	}
+
+	ret = i->reset(dev, probe);
+	pci_reset_iommu_done(dev);
+	return ret;
+}
+
 /*
  * These device-specific reset methods are here rather than in a driver
  * because when a host assigns a device to a guest VM, the host may need
@@ -4239,7 +4255,7 @@ int pci_dev_specific_reset(struct pci_dev *dev, bool probe)
 		     i->vendor == (u16)PCI_ANY_ID) &&
 		    (i->device == dev->device ||
 		     i->device == (u16)PCI_ANY_ID))
-			return i->reset(dev, probe);
+			return __pci_dev_specific_reset(dev, probe, i);
 	}
 
 	return -ENOTTY;
-- 
2.43.0


