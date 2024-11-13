Return-Path: <linux-pci+bounces-16712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F6D9C7E01
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 22:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C83CB2A302
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 21:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2028718C019;
	Wed, 13 Nov 2024 21:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vkiFJvzT"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739BC18C003;
	Wed, 13 Nov 2024 21:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731535040; cv=fail; b=U7CE1PaH6QxAn/fmKJvIwWnr2P9nbw3jH4OzbkTnKB0FsY1mFBd7KvMTOcmyD5Ymg+MfRZg6zSsSzx7XVa/G/E1lapZT/S3S3SOyGNB/JAg5AuDgabvmjBkW4D6YhkDDiaRG1uVbU8bFBZ9LGsRmOthlsgnjETKaqsDLOMFqzUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731535040; c=relaxed/simple;
	bh=VdE1Y8XM8h4NpVTvuPbZtpm9gi4c9TrTstsoGbCg10s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aq6fcWUepmrDLxJeyp2NFHLlCgPw29v+SEGWvUrOhv5+H13Iup192haEN36I/5djcMgipIsRRx3+FhPvlB6wBr6PlJDn/YxKVa53K79vcc151LFkEMSfW9q/a72Lnxqc/B3kIZIYyyuwQA32rL5Px/YPLzUCdoWcsYl3FaY23bI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vkiFJvzT; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6DznVSdmPRB9ybCTj2ToND8HAd1o3HBhBKq19elLf3qi/9iN2uTZgm9CjX/AAlfJTA6fK7THSZd5KJxj6N8TW5KzA5h5cJ1aWkR+bANzkbWUgZnfgV3Dg2oHHvKbQxd76B6RU6XJH0Ql63iS2K6HKys8s4lLLT6ETAearYrZFA47D7o7hXcD13O+uUrTmFhRNDwVHyuaTn0UYoRK0q3DKOpQE/jkYEmfma9jt4xB0YPzENuJAM7Vmeo4VnmLQBsWGZjtKvhyPQxl+l2fY2/UV4N1yjI4283JcWDhQBNdCgUhpphow3ony141dfj49C1Eva/2gqjxIbnPpogkvxHaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DS8lmeSuSsZzptklhyKeGJq4CUhuB26vI6mTnPlE1I=;
 b=mOosbOi+yLVyWG9s7652VYtokgceAzzIAlj/UO0bf4AIrsx0THCe/fxKmpijO8y5wpUFfvTpH83z+QnostdA5e272t/GePKix9o4MlXIPR4KpNEnlL1/opYxonWksGVibijwm4W7isJogbSHy4V2HzoGoQXMu7t2omjheIrH6s0MVhnFAvXKER3/no1R/DsYULLLdz/zEd0JABGlK6AdCxKf0Jz/Dzn4OoHVViY0ESoULgKIBSvnq/lVSTDbE+BPT3z17MMq2IMvaTgdTXQgChs7XiXw96YsCv+ibRX/i6chmSaQQvz9GEDabNbiXr+YxjQoSztYYkQR3un+dAEhUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DS8lmeSuSsZzptklhyKeGJq4CUhuB26vI6mTnPlE1I=;
 b=vkiFJvzT8V+J/uImzNe6aZNF7Wo+qotmovmpfISuoLBknNDhd3D2opg7Iji+If4lyTpAlD8e28NrL0WPoy+K6k/CE8cj9YmdE64BL87/OEtpc1tSgcXbIkayENu0xT652ySL7TUL9IKkkmFiaevAkNSbdpqK1Rcl8YjNQMAVY+I=
Received: from DM6PR04CA0015.namprd04.prod.outlook.com (2603:10b6:5:334::20)
 by SA1PR12MB8842.namprd12.prod.outlook.com (2603:10b6:806:378::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 21:57:14 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::d3) by DM6PR04CA0015.outlook.office365.com
 (2603:10b6:5:334::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Wed, 13 Nov 2024 21:57:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 21:57:14 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 15:57:11 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>
Subject: [PATCH v3 14/15] cxl/pci: Add support to assign and clear pci_driver::cxl_err_handlers
Date: Wed, 13 Nov 2024 15:54:28 -0600
Message-ID: <20241113215429.3177981-15-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113215429.3177981-1-terry.bowman@amd.com>
References: <20241113215429.3177981-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|SA1PR12MB8842:EE_
X-MS-Office365-Filtering-Correlation-Id: 721cafc5-3614-4431-1209-08dd042e220e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j2l+cYz3GFPP76NAHQ60Zr2lcm6Kz7fMoObW1GW5orO/Wp0OczHCdUvnqoFV?=
 =?us-ascii?Q?RgZGWZBxqckCnSj4IiWswNROaCWCjzu0wAsyJrvqv5sEXUjolzUbCeKa8j7t?=
 =?us-ascii?Q?3ni9I1ROufE0okTaMNkHUd9O2xyB2unxT2IUCY9rA7vQMb9IsXS5VrfqinSa?=
 =?us-ascii?Q?MqZUEXlEgzCcl7lyYTj+0nIZWbHDfuKIGssfOmvxHoOPZNix5GcQ2MOet8Zw?=
 =?us-ascii?Q?xIl26iCe61VJwRznTX0SWyIl6ayjI7eL3+JBesSBy/HJhqd2lQ0NCqI9y7Kz?=
 =?us-ascii?Q?1JgwRNB08Kbuns2h+lzoLR4ebOoxR8OYBs+2WB5xSzKsD5SPtVwqwTVsyCge?=
 =?us-ascii?Q?zUdWiGjg0bsklr24aM+YiJOflL0vEiH404rkfVFD8X/e2InM6D0J8AGzvU9B?=
 =?us-ascii?Q?lVb+QuqrNs7NWAU63rXzo4qJ9FkGv1Seq0V97srrxBkhH3yiZNccvAAv6qJx?=
 =?us-ascii?Q?0nrGl+wjq72QXACi3LL1nF23xdPVQuR9Fv8GRn1qcvYfGLZPeDoeKPLKdP7f?=
 =?us-ascii?Q?3VfZfGrPn6+IY/ZsKmCHAyisfrLOuuuBmvZu7nOuZRyQATm3mPCMwkUbJjTc?=
 =?us-ascii?Q?JTDEpgUA9skmBnptYwK/vUdBfMDr0e4o1urDG1D54HuRuv9u5qWpfP6a/NwM?=
 =?us-ascii?Q?/zCCr8aQh9Mb5u4wXV6sQgt1kwyDwxN/lBpxyldelyaC0Xo7fwC7V2Vjd+Zw?=
 =?us-ascii?Q?XAwbl3MfFpMXKmYqGyW/aToFHE0n29z9aSTYBerbKPP6oyrC0HDauA+i3iOg?=
 =?us-ascii?Q?5MWBzK2l1S5rLUVpRXabQEwnNRfdfQSvFE2h/M2OwZB9J2Vtjd/If23WmLrd?=
 =?us-ascii?Q?IlxYNCS5Fo0AOqea24isMb9RDGfFAJ1cNuprBL8a+IdROORW9mn4oYpSgwUn?=
 =?us-ascii?Q?R6BMl4OqjxwSuPIxH0O84qmDfOOO0LrpHSjUymiqoPpcohzNEt5wRQw8L9pe?=
 =?us-ascii?Q?eJgfnnySbk7R+/+e1LhphR6fEe963Z6gaEBG3LLBl928LGS3BUfkXcLEwSJ0?=
 =?us-ascii?Q?Ot4+y+jOpF8uYVre9A21QQR7aGnZU2DeCBtwfISGiQIVRCuveqEFdwLYeYk1?=
 =?us-ascii?Q?UaKXLJemYF3if3LM6LJNWmLe4BE1TuXHc7ztV8anR0vFo+kW53i8grtsw3oX?=
 =?us-ascii?Q?+vGdkfk9YplbjKvicMNWp/ywTveDKEyNRU/EUdIeOdlmSTBXi8Et+9RijEJN?=
 =?us-ascii?Q?anXGQU5t0wWXO1g+5fq7aqvCqbpfSxVspA4L5op7GvPG3Qrx7iYZ+gx0H7Fa?=
 =?us-ascii?Q?GR/pwN0cVs5/psJxuAd+9Yi1zH/gEZY8bS3VxEstdHYJ4TE/wkDdsUOi2lKO?=
 =?us-ascii?Q?gkZ3RESaLn6/GN3qF+hf2y95uytp8Vkjre4087FsnxKemHrkT7xhFWztRDF0?=
 =?us-ascii?Q?zOl/B+4d0RhWOs1BL3HQ1NPalH2FOe1EAN7KF8ZaNtpo/RgZAMDVdYhs7HmF?=
 =?us-ascii?Q?Xv4t8TsSVXY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 21:57:14.0332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 721cafc5-3614-4431-1209-08dd042e220e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8842

pci_driver::cxl_err_handlers are not currently assigned handler callbacks.
The handlers can't be set in the pci_driver static definition because the
CXL PCIe port devices are bound to the portdrv driver which is not CXL
driver aware.

Add cxl_assign_port_error_handlers() in the cxl_core module. This
function will assign the default handlers for a CXL PCIe port device.

When the CXL port (cxl_port or cxl_dport) is destroyed the CXL PCIe port
device's pci_driver::cxl_err_handlers must be set to NULL to prevent future
use. Create cxl_clear_port_error_handlers() and register it to be called
when the CXL port device (cxl_port or cxl_dport) is destroyed.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 794a601fdbf9..af2ff6936a09 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -844,8 +844,36 @@ static bool cxl_port_error_detected(struct pci_dev *pdev)
 	return ue;
 }
 
+static const struct cxl_error_handlers cxl_port_error_handlers = {
+	.error_detected	= cxl_port_error_detected,
+	.cor_error_detected = cxl_port_cor_error_detected,
+};
+
+static void cxl_assign_port_error_handlers(struct pci_dev *pdev)
+{
+	struct pci_driver *pdrv = pdev->driver;
+
+	if (!pdrv)
+		return;
+
+	pdrv->cxl_err_handler = &cxl_port_error_handlers;
+}
+
+static void cxl_clear_port_error_handlers(void *data)
+{
+	struct pci_dev *pdev = data;
+	struct pci_driver *pdrv = pdev->driver;
+
+	if (!pdrv)
+		return;
+
+	pdrv->cxl_err_handler = NULL;
+}
+
 void cxl_uport_init_ras_reporting(struct cxl_port *port)
 {
+	struct pci_dev *pdev = to_pci_dev(port->uport_dev);
+
 	/* uport may have more than 1 downstream EP. Check if already mapped. */
 	if (port->uport_regs.ras)
 		return;
@@ -856,6 +884,9 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
 		dev_err(&port->dev, "Failed to map RAS capability.\n");
 		return;
 	}
+
+	cxl_assign_port_error_handlers(pdev);
+	devm_add_action_or_reset(port->uport_dev, cxl_clear_port_error_handlers, pdev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, CXL);
 
@@ -868,6 +899,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
 {
 	struct device *dport_dev = dport->dport_dev;
 	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport_dev);
+	struct pci_dev *pdev = to_pci_dev(dport_dev);
 
 	if (dport->rch && host_bridge->native_aer) {
 		cxl_dport_map_rch_aer(dport);
@@ -884,6 +916,9 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
 		dev_err(dport_dev, "Failed to map RAS capability.\n");
 		return;
 	}
+
+	cxl_assign_port_error_handlers(pdev);
+	devm_add_action_or_reset(dport_dev, cxl_clear_port_error_handlers, pdev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
 
-- 
2.34.1


