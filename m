Return-Path: <linux-pci+bounces-8879-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF2290BBA9
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 22:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C38F28284A
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 20:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7965D18F2E5;
	Mon, 17 Jun 2024 20:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d+4hLdFp"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE1EE542;
	Mon, 17 Jun 2024 20:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654681; cv=fail; b=FExAF3cMRij72Z+/CoQ2NgcQz/cQ8AzDmRqyg5rqbqp+FxHqz5CnJgLMwI1jOM1UlYHmVgrXqssAB/irdPyiHl/1Z/j+t9PbB4KssTAiGEKoCdK4YHxehhKZ/2Nn40/w8y8ySsD2qJt6SukGlo0DVYshvo+rwJbFvJ9va5142MM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654681; c=relaxed/simple;
	bh=iIiWo71BMYN6t41ECHNmO95zl1J+plKfADdgKrkqbuM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gpGCtPDOZW9iP/dym/ROaF9go8Pix+nB/BMqFBPUCFQ4b00cpmcxxa5PKUD7Qraho0qI2PeSY/EsqvClscSclNM/LdzBbgk1sc/F2QxmmKHbplfVwJ76on15pbuwFcLK9LGMfPJ0suhBpZt5KX3oh9nA7pMZjx1QnzwyOpJRHnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d+4hLdFp; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOhHJqwMb96627X8NvtgHGqBETDBZXsBbO6wOvCDaIiER5kzdDPmTs0DF6fmf6/h5G8HQJ4IY1agFbhzyvLPX7WOgXU1ngNPLB7chlv3Fht1R+Sq4B6eTpSFvVgTgGEvPsu4aTCsvdXnxWj36DBjs63C+x+boAKmX/xvGN3xquFX9adh3f6loQdHgZBn9mKRZ/UIs9+en9lvsPh0Nt9nP6epXE7ngsLj4RYh92BrV4570lO4ZduObObU2+CcFjE8NXlYWyXwQCoC+QVQaTs19rTYq1LtLg6O0OHIL6ozTe49TkhM3b5br1SE/5EactitH0JEVu5YOLymAxw0r3wj7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7tuKWOBSNUKoTf6tuLn8VCStoGfSAplcLpQhO77+xE=;
 b=A6CAPtmCz3/WgNYe/fPU0G4UQabrYa9rgnJNrA9AKiMRt0fYP7fR4MWLxprvsebby/c16GgZx7kaTA3DljsXuy+0zeMO/s+01/cEh+UsgDo1eZ0oH6qjotWF0X2bQwAp7ATdl/h1Y1wG015sbPNHRDBch7TC6NjtjQ/m5UuMmzZmgR3KBp3Hyvbg2PI3GdGLTCDRfoWpqRe33A/rErPGY4XKSpO3DSigOYQ2gVpdday3gOVesO20wT0N676wXgvayyV4iVXnp4l7jj5QUm9aKTvBXxVzlIByN4sEyQAXMfi8YpTJg+AwK3Hb9TI8oNlqUYXKQJYAfRrhAviJpSzY5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7tuKWOBSNUKoTf6tuLn8VCStoGfSAplcLpQhO77+xE=;
 b=d+4hLdFpZpRa3vEUPtNqjrmMhWOFS7ImTJffyE/zcLWnDIB9AlkLra4Lod/EWboTvraJ5Ox2iTfbYwjFiwo5rEyoF1KghpkDZsNQ/rYOLIQiZ+Z2GAFtAtxIez7acwL2634/bCl/uoNwZKtpq8IdMCr/057lzRZ99LHSvqMfUxM=
Received: from SJ0PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:33a::6)
 by DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 20:04:36 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::aa) by SJ0PR03CA0001.outlook.office365.com
 (2603:10b6:a03:33a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 20:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 20:04:35 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 15:04:34 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dan.j.williams@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <ming4.li@intel.com>,
	<vishal.l.verma@intel.com>, <jim.harris@samsung.com>,
	<ilpo.jarvinen@linux.intel.com>, <ardb@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <terry.bowman@amd.com>,
	<Yazen.Ghannam@amd.com>, <Robert.Richter@amd.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Subject: [RFC PATCH 1/9] PCI/AER: Update AER driver to call root port and downstream port UCE handlers
Date: Mon, 17 Jun 2024 15:04:03 -0500
Message-ID: <20240617200411.1426554-2-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617200411.1426554-1-terry.bowman@amd.com>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|DS0PR12MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: e58444e7-03bc-45b9-5c50-08dc8f08b63a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|36860700010|1800799021|82310400023|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iD7a1SFXbbi2gOuYIOFa8M/2RtMT0ZA2kuz2Qo5SnypwJZ8/SeCtucrZU02o?=
 =?us-ascii?Q?twHs057ziJLqLqevlYrCdW40mlvCFaxOEBTSAk7ScW8IPM7f66dtvPsHkhdE?=
 =?us-ascii?Q?nQ6/YFXV7tXgLwbr/Z7S1nOF582w3o/PEGY20GsBaHjQUrVmd8H94cyaclbL?=
 =?us-ascii?Q?gbdSMa3aP2lBMqkTx9vkKmRV5hpf/bmbLii+dCSZiD+q68pa+KWbNU8UHTgD?=
 =?us-ascii?Q?bPy0NucOSGLl8zygA/Ao1FVSmT7a37NpHudwXF7NeFDd5GYNXfVWnAm/PDSC?=
 =?us-ascii?Q?GynsEf0jCwGRAHpGUOzAqYzjkP/dCShK2ygxdKksHOri2QpWJEkdo3w8yJIZ?=
 =?us-ascii?Q?Rj5KEOD2dDzKpyUtcPBuKrZNWSMgV3dJKnyuzMpMsppYi8rjL7fD3comybDz?=
 =?us-ascii?Q?ecC3Idp9jvL6E9VtmI0KMxoA9vpOMCCIYz9Zbb0J2KVfpJnJSJ5crmTkV5x9?=
 =?us-ascii?Q?nMReVh4l8OZn0izMwHqUyJ6AYfMkdvLiaalld9/p47SUidWgXhWsMlFYzKCM?=
 =?us-ascii?Q?0uGNJ67PYxbiR2GFDg0U751OSGerRSJXLcQ9qUzlrKZvgirk0JhJ9nsxuQe5?=
 =?us-ascii?Q?cXhP595JCPHRcfD32D4ecFp24Xs4QRQvaUZ3wqX3AM03nrBNDQ7VgfLpcLje?=
 =?us-ascii?Q?AnArWkx/SSSzbzuEf6FmcPmWWOo+NdGEH5R0mnYq7k02JMYyZqch32WH7oJr?=
 =?us-ascii?Q?380qgO4wQcA593PUWfywyZ783uSaD0CL4BR6oRl3CCAft/ZVaIu5Kl8cuKen?=
 =?us-ascii?Q?9HuGLIjvGG6P9lJVBA0EevJj7v0eUcLQIvzVB5DT4wt5om399jTyV7upkud7?=
 =?us-ascii?Q?0E9bztB5kQ5SoO0WRY697pNwd+Z+wAdbbuVN4iZucpO/FCsetG8/YfF6HOxx?=
 =?us-ascii?Q?/QIJpUQuohjguxvRMXvRDgvYgAziGoGuMPzK1xD5NF5lcLh0cVktYRwMEFjg?=
 =?us-ascii?Q?Q1mrzSPKg5ErSamesw1pkfNJ9ghWsAE2/5TFXLqyynqLPam+//dL12oOaDSa?=
 =?us-ascii?Q?04x1V8YMM90FHH+sUps3th5z+9tweTocmfNUk3Oay+ZUFUTEBoSLsj5AYZmA?=
 =?us-ascii?Q?AlQTU56w57w/1nDkz3z7GmxZ1NSkwHOCgf7o5bQU0Tn1AW9PDzz6DKZpP2Fl?=
 =?us-ascii?Q?HJbQwEI0qi93uMELyEJlPZYHHgms0lpwLIVpRrhWZQb+XpDWVzPSdwbZI4bU?=
 =?us-ascii?Q?+iKz032F7pW6xA9BSbz4lDXMWu9M10N5N/t6/BJpMmBDzF9Ffk8ru1XxyiYl?=
 =?us-ascii?Q?zSmIssmOCV593QjudLASMhwcpImZ7EPodmuaCqrSZ2CPS3q52sAL4yy0MaUJ?=
 =?us-ascii?Q?jCVIHR+EE4XEc5S2IeMRp4y/h+E/rF3yXfpszv2mXLEuJ3OYX6CTwrAmka+w?=
 =?us-ascii?Q?OZOhPiKRyimH1hKlg5mOE2w0un0rtPWoZy+6dXFrHF8kCfU1uKvpVNIzfUhF?=
 =?us-ascii?Q?2TixJoRnKno=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(7416011)(36860700010)(1800799021)(82310400023)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 20:04:35.7993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e58444e7-03bc-45b9-5c50-08dc8f08b63a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771

The AER service driver does not currently call a handler for AER
uncorrectable errors (UCE) detected in root ports or downstream
ports. This is not needed in most cases because common PCIe port
functionality is handled by portdrv service drivers.

CXL root ports include CXL specific RAS registers that need logging
before starting do_recovery() in the UCE case.

Update the AER service driver to call the UCE handler for root ports
and downstream ports. These PCIe port devices are bound to the portdrv
driver that includes a CE and UCE handler to be called.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/pcie/err.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 705893b5f7b0..a4db474b2be5 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -203,6 +203,26 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 
+	/*
+	 * PCIe ports may include functionality beyond the standard
+	 * extended port capabilities. This may present a need to log and
+	 * handle errors not addressed in this driver. Examples are CXL
+	 * root ports and CXL downstream switch ports using AER UIE to
+	 * indicate CXL UCE RAS protocol errors.
+	 */
+	if (type == PCI_EXP_TYPE_ROOT_PORT ||
+	    type == PCI_EXP_TYPE_DOWNSTREAM) {
+		struct pci_driver *pdrv = dev->driver;
+
+		if (pdrv && pdrv->err_handler &&
+		    pdrv->err_handler->error_detected) {
+			const struct pci_error_handlers *err_handler;
+
+			err_handler = pdrv->err_handler;
+			status = err_handler->error_detected(dev, state);
+		}
+	}
+
 	/*
 	 * If the error was detected by a Root Port, Downstream Port, RCEC,
 	 * or RCiEP, recovery runs on the device itself.  For Ports, that
-- 
2.34.1


