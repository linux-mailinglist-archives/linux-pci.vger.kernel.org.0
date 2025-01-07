Return-Path: <linux-pci+bounces-19440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66269A042EC
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 15:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CFDC3A1F78
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEF81F191A;
	Tue,  7 Jan 2025 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="potEqQcu"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FB41F37D3;
	Tue,  7 Jan 2025 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260921; cv=fail; b=FX1TVWS0+luPjtXEpJ1rKJiiXlnkIPMJykvI2F3NxNOs0KNlVsVCotwGWH7he4FVIh8v2ePAU5xqgLjJTREjyFP4VYIR5TYxtls+T7kOjtwlr32kDWkBnDIYHM6USsCytrZAl7KWesQ2UgMrg3uCgOt/lvQpmBUtwPNe8UwDKbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260921; c=relaxed/simple;
	bh=QtcuFBhsIqAixukXMFmUildyC2jYhQgaLwg+L/6JT5E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l83Eq41FluHyxrR5o4GEYVIKWSxZG9Ns77Zba9fkZ1Dm0DL5IpgW0qJam3nYWQONRcA9kVJqtWBe/JYBezFIym0pOsi7I44TdZD5B/MxkNWWe6QFGZFLu8bZ+XxLN/8zm9t2ZCgbDQWXJc10WS06dZFoPkEL6XacGkqqyQqxlGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=potEqQcu; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPPOJpsnb7cRrCNGr/OfclDIfmFdtSo9ns9B+CIn38cY7mmxlHp7MhjAPPZvUKX9GH7SkihX8QEEOFswvBq2wYKhkRW1WZcB75hj65YS8UPSyTN5BdpSTZps6C4NOTlipOEme0MsG7p3YyKxcx+xJCZD/LzdXiUENj27BOBqq6pKjR8sXqljZ0siWZ9lpYAuS+apvndACTRqK6W7kqQyf2p7qVtw+i+lyQD+jd486Ag4fpNRyjux0iYeQ0h631mu+VIlS3ye65l4yRjJ/ji4x56eHV4n377dCTdAq8sVc/P078EK7yHxZEyB2B6J6ITxfiZ/RaPDGaKk4xdZa8oI7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzcF/D/3cVatP8PvQJ/uBCaGTCKuYOo8fA3t6hW9fHM=;
 b=MNenqgoEomKnN7TghTGhtUDgih7s2whbEdlmcymfds3+qLP/ae0dIHO+bFXWeNP6z89/c4HZqQ+WDPPquhIgbIl0UaNKXxih57ra2TyRNUJkQXBKnYuilJ5hfjr0D8WjNjCPVwUaiNK41seC15b4Cut31J3/D5IskUs/QR/Y8WAUuvrainB6HX/hEz633pwPNISmiCNibxPZ2QMcp0RplRnYOlymynSa6WMt4JHl3loOsQnfXfZYUu1Nq3dL+OfXlEiTk1s2v5+3gCvct1xW7Qm6fMc00/mYE9YFCdGGTAXEbn1OSPlPGwTgPIHX0dC90QxJtw+jniD3ml0Ts45/dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzcF/D/3cVatP8PvQJ/uBCaGTCKuYOo8fA3t6hW9fHM=;
 b=potEqQcuGR438A/sr3vIwUsrRrsWL+lbtmHk2uUadEjiGiCdYHbVPylf3jw4e2a0TuM2T7jVh2fLdGYw3DW0pREqsIIP2n69ti9RHFFjUBx5949Sc84yaQOmb2rgiqrDNaWqV8zvn8g51lYBHvrol1ofN1RxalmNGRE2oElX8qA=
Received: from SJ0PR03CA0277.namprd03.prod.outlook.com (2603:10b6:a03:39e::12)
 by PH7PR12MB6396.namprd12.prod.outlook.com (2603:10b6:510:1fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Tue, 7 Jan
 2025 14:41:51 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::57) by SJ0PR03CA0277.outlook.office365.com
 (2603:10b6:a03:39e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Tue,
 7 Jan 2025 14:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:41:50 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:41:49 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>,
	<alucerop@amd.com>
Subject: [PATCH v5 15/16] cxl/pci: Add support to assign and clear pci_driver::cxl_err_handlers
Date: Tue, 7 Jan 2025 08:38:51 -0600
Message-ID: <20250107143852.3692571-16-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107143852.3692571-1-terry.bowman@amd.com>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|PH7PR12MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f1bf85d-7847-4e26-14bc-08dd2f296c0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gGomQYwJ1Z/n0JXDjkoL/2nFvpkzIQ5X80e507V/0EIpx0lO+4Ug1YLmj+iB?=
 =?us-ascii?Q?EQl8osCUx0A6YG78qk0XDxPmhSnCaL9QIPnf90focxtRfQHPLeHGUQzYD4wL?=
 =?us-ascii?Q?9HShjpuByk355u+J9leI+Ix4ac1bJU2E+ZAEdLZeI1uV6YTcWsOEyT4muxYP?=
 =?us-ascii?Q?yX9v0b6Czdcjnh7Hws9SfMaIwt991eMG8fyREHVvHDG+wkq3x1Wn7AD63SD8?=
 =?us-ascii?Q?ku9dNK7x6f6OHF7xlbC+wK2K3We3z3lDrSdR8q9TS4VbXufc8/C8JyKEXJPl?=
 =?us-ascii?Q?bZQOtfpWkL71wW2MdSDLjrRg0PqS3VmCH0xXrvtfQm7N4MPXcE2I10t/JMbF?=
 =?us-ascii?Q?Uj+qKl74gcUhu0UZ9sqvxMyL5VBRhkZQ0Jn9CDG2fRLjZ+nOoI0V1d3lf0Fk?=
 =?us-ascii?Q?JZY+rcuOMcrpJgF2EbjNdNkl3SKP+RspYumOlHL+AwhzjxlHHih0igZcM3uH?=
 =?us-ascii?Q?5/I0WiNj83OYtJ6UMFX4Q8vt7hxm5keSPwRunxxQwRFOH+hNZad0jMZ3m90k?=
 =?us-ascii?Q?kwUbhcM0zEXX2SEk77fqrD5OOe0lGxziJ4pj5OZOGu6q0vdZyKVlES72UqYL?=
 =?us-ascii?Q?R/nEUMYauPHFJ/uAsDpfyikvtghZUYUidtXlbgiL1nRjWL+rwMuBgotVbrJY?=
 =?us-ascii?Q?orDTsUuTLltXlavey8KWePCeyYUC3yIC2gVY1ijjOFq5GmTgdrA9ov+dPQ4U?=
 =?us-ascii?Q?fNVwzQyIVgpiOqYQb9D4Z+mZmt3wr6mwzqWLIdgdy8vBEGIuxWgIlCHsdGEv?=
 =?us-ascii?Q?RoDZR9EPURpo+fqEadrcGRgfazEOvuCrAR79wWFvIRkC+0QDl6v7eI++knZQ?=
 =?us-ascii?Q?Ve+AmMeUBu7XBmodPGluaU1Da2p37y1IYe6h80uhgImqRswRMWJvf4VkSq7f?=
 =?us-ascii?Q?EKV1t8FnlHZPrSwp89BzbQ3PPVsfX83YGhAdG0UqxWDfBYYbOUaXixQpAmJW?=
 =?us-ascii?Q?ThUITXpaFzqypOKZT9ayrOaACOEWYx4nYX2dHvwG8KGsJjRqLHT50pyh4yOT?=
 =?us-ascii?Q?eQl6GkotGRKW1ygt9gS1Ji7YTSW+vyf2BnqGWF2t2B1hcVica3or+dFhpbBg?=
 =?us-ascii?Q?4wyLyJvmMsdnJ/y3pypT8WCPdtfwG6Mbq0XYb2OS3Xs0NlGZPTeNDavizSmx?=
 =?us-ascii?Q?8t6yuTGCeVaIbPe8pJjZ8Z9nddbmyE3RVyVKf6Wel3tnGN32WohqpdNY5P2u?=
 =?us-ascii?Q?+u/bozCpgv87uN3l7Iwar2Bok8Mgf890TlLi8MMTiippbHuPGtrOHfbCa3qt?=
 =?us-ascii?Q?M5wNNcFqWOzP5bEYrCXHg7mNaGbwTbeCXN0gwzu+O0JyD4jnwwOaG1bd0evi?=
 =?us-ascii?Q?PmSJ0+hMmIe5RcuKpCk01at1YAjGdNdJp/NQo4crNdRr8XWxMvLGqyw/rY/c?=
 =?us-ascii?Q?bJdnAsxRmV1LjGFGdHN6RkSwb6/TL7sMsJm5WfOX1IPMTBH2XBYVE0Gqd6Xx?=
 =?us-ascii?Q?qCHQHuCsvj6Hp4dMN00kMrGjVW/Pooyb/l6WggQrED5R8OrDOXMZNjUlX9y/?=
 =?us-ascii?Q?1MMppgSH7aLK48sWbVJOn9mspxRtQYUHIeob?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:41:50.7746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1bf85d-7847-4e26-14bc-08dd2f296c0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6396

pci_driver::cxl_err_handlers are not currently assigned handler callbacks.
The handlers can't be set in the pci_driver static definition because the
CXL PCIe Port devices are bound to the portdrv driver which is not CXL
driver aware.

Add cxl_assign_port_error_handlers() in the cxl_core module. This
function will assign the default handlers for a CXL PCIe Port device.

When the CXL Port (cxl_port or cxl_dport) is destroyed the device's
pci_driver::cxl_err_handlers must be set to NULL indicating they should no
longer be used.

Create cxl_clear_port_error_handlers() and register it to be called
when the CXL Port device (cxl_port or cxl_dport) is destroyed.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 49 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 3e87fe54a1a2..9c162120f0fe 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -848,8 +848,40 @@ static bool cxl_port_error_detected(struct pci_dev *pdev)
 	return __cxl_handle_ras(&pdev->dev, ras_base);
 }
 
+static const struct cxl_error_handlers cxl_port_error_handlers = {
+	.error_detected	= cxl_port_error_detected,
+	.cor_error_detected = cxl_port_cor_error_detected,
+};
+
+static void cxl_assign_port_error_handlers(struct pci_dev *pdev)
+{
+	struct pci_driver *pdrv;
+
+	if (!pdev || !pdev->driver || !get_device(&pdev->dev))
+		return;
+
+	pdrv = pdev->driver;
+	pdrv->cxl_err_handler = &cxl_port_error_handlers;
+	put_device(&pdev->dev);
+}
+
+static void cxl_clear_port_error_handlers(void *data)
+{
+	struct pci_dev *pdev = data;
+	struct pci_driver *pdrv;
+
+	if (!pdev || !pdev->driver || !get_device(&pdev->dev))
+		return;
+
+	pdrv = pdev->driver;
+	pdrv->cxl_err_handler = NULL;
+	put_device(&pdev->dev);
+}
+
 void cxl_uport_init_ras_reporting(struct cxl_port *port)
 {
+	struct pci_dev *pdev = to_pci_dev(port->uport_dev);
+
 	/* uport may have more than 1 downstream EP. Check if already mapped. */
 	if (port->uport_regs.ras)
 		return;
@@ -860,6 +892,9 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
 		dev_err(&port->dev, "Failed to map RAS capability.\n");
 		return;
 	}
+
+	cxl_assign_port_error_handlers(pdev);
+	devm_add_action_or_reset(&port->dev, cxl_clear_port_error_handlers, pdev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, "CXL");
 
@@ -871,6 +906,8 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
 {
 	struct device *dport_dev = dport->dport_dev;
 	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport_dev);
+	struct pci_dev *pdev = to_pci_dev(dport_dev);
+	struct cxl_port *port;
 
 	dport->reg_map.host = dport_dev;
 	if (dport->rch && host_bridge->native_aer) {
@@ -887,6 +924,18 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
 		dev_err(dport_dev, "Failed to map RAS capability.\n");
 		return;
 	}
+
+	if (dport->rch)
+		return;
+
+	port = find_cxl_port(dport_dev, NULL);
+	if (!port) {
+		dev_err(dport_dev, "Failed to find upstream port\n");
+		return;
+	}
+	cxl_assign_port_error_handlers(pdev);
+	devm_add_action_or_reset(&port->dev, cxl_clear_port_error_handlers, pdev);
+	put_device(&port->dev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
-- 
2.34.1


