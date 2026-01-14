Return-Path: <linux-pci+bounces-44814-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD044D20D5E
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 003C430D5A20
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4B82FFF8F;
	Wed, 14 Jan 2026 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="czgWJg09"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012047.outbound.protection.outlook.com [40.93.195.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166DE8632A;
	Wed, 14 Jan 2026 18:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415144; cv=fail; b=hYUlU911jJFsACLWUMJfxYEFNn1Osoz+W4gdr+VuagtK3cSLUH987wPuvWyNZyDpijdJTQdevXF2MMcXuGmjIi6R8FLRocRoO7S3c31OrgYyaeyWJXciGRh+p0QsTv74jvAQBLV6aWPSV5ICa7jGMwoj2qYLiSRRp/+zYy9Hk2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415144; c=relaxed/simple;
	bh=2jrW7eKglL2EPFtXDf6Gt1PgJD7kNNlrKFFAW0RhTeo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PuHG7ySzqesGBLo0wxsL5MZIzFTV4bW3mq11HV0v8MrRLVVJ9j5JRxkAu82iZycqkdWa0NwCbztKEvDajW09+v7zeDBMP1Shg+X5rLen4+YoKnjkD6Asmn9znoa5ismTWG5J4B6rvtuJ2yfjprH5fqxFbrUR6Tm7A0d+hpBV9b8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=czgWJg09; arc=fail smtp.client-ip=40.93.195.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIuSHV7dJQSW7fZx4ni1qHE3kJRXS2dHBEfDhs7oMr+8CacUkvjKXnN96OVD5F9tQLePxQ7Wu1MNLaxu4tnxJtnirteNpoDDcnzVnntBoGhxsnNf9sobk8VT3VzjrxSwSrJ4C+rsKqj1tWG4Vl9o5EfhevyscZaib2og0vmcGv07j/AeB8xrHCY5OoYUOD9pnvS3yQb9PcbSjQrTcXoAtHCHjCD5w/qnrskteRqCG6vT4y/5Sh7itfKqoYhLnPR4c38Eh0q3HJ49HcWA0a5nogg4GAwd018oJ6Fdpn6OB4rskbKMKgWu5BZi3ty0SFQqVr9XrGt9Mv03rwr8VU7BVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvexwpcumy3lwejV6dL8wwc4jMwXBeSgsw1/dM/oODE=;
 b=It2Z6cOKAk+jp4juSvR2G0bZmq5aRqnaYbksKSex/39hI4bjf6+bL1YVT2CIkTEyjKWc3mNdlgbitkN8shVeDp+b/boKGwfxSFanq6MqCpvBlWVxb3XQHNRuks1DcDLBKEZ7+qUa2vexEkpnLyfmC8eE6TJu8XNLSKHuniYRGvCJcfAn3TgSArHnlIC1SGE8fRxXhqaDF77TgEF5+Ft/CnCXzPvE75a7m6V1WZRp1/QCoBP7zR3DHLWNDhtC+9kOi3QitxOrCEbHMgVcmN2vjOFA7cFng2ah/cfo9aGPzO/HrOlf2zmHlJnn6f1BYgMSaL3p8OqaF2bBbcVfXglNfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvexwpcumy3lwejV6dL8wwc4jMwXBeSgsw1/dM/oODE=;
 b=czgWJg09DLjun9mn9216q9Ra3p0LA4kR8JcEQfd5qGSaNKMKmczARZ62Hb/g2yS/3ddmvx+4Jm4rHLa2U1FOuwNOxHvB8xFn93Ca8U4RpR1l+b2zB115glKaSMyXBqk77yMxQFHtmz3RQ+6vDNVM8qOCpUdQC8JGHeCThe6HHnY=
Received: from SJ0PR03CA0073.namprd03.prod.outlook.com (2603:10b6:a03:331::18)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 18:25:36 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::15) by SJ0PR03CA0073.outlook.office365.com
 (2603:10b6:a03:331::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Wed,
 14 Jan 2026 18:25:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:25:36 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:25:34 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v14 21/34] cxl/port: Move dport RAS reporting to a port resource
Date: Wed, 14 Jan 2026 12:20:42 -0600
Message-ID: <20260114182055.46029-22-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114182055.46029-1-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cf0b37b-a271-456d-f3e9-08de539a4fc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2vNZeuPCm61gFZKnRjs+B9lrdB9d+LiwYWasCBhkIQfPoBl38mM4czvVMV0b?=
 =?us-ascii?Q?qWIffHh7GjA1rj7N9hFHHh2/p34vMWw+Ga5V5+nCfmikFtBSPAH5Ytxun977?=
 =?us-ascii?Q?OEm6Fhz27hW7bJ7AyAxyytIenSnf9HCMgFoArP0uwRY7h2SsrkhAOZSbtPRB?=
 =?us-ascii?Q?4mnJLf5Osfznrz3b4zBs0k+vA45IaYpi51sroLAN7ZuDgNV0V2t0QfoQ3ZmH?=
 =?us-ascii?Q?SO1F9Tx1fyuc0onn6Smp2vN2hCti34CtqkOHB4U2pFcI9dO6/iHqhBt9N5Cm?=
 =?us-ascii?Q?w4axLifLXomqUlORTAT0D31zVYUn6gOhX2isVysbjKJmMp6gRJ30ivrPuEaL?=
 =?us-ascii?Q?6QMUHWCzsL2ZfeAtXteR9zbY/+aoI2EtwbcSDT0vKDXJLrnxVdo0VHo0SGwZ?=
 =?us-ascii?Q?axe8JFq4ZDxpCdNdJ0Wj/DYy2dSdKFOaA6Oka923UT+qMza8pLTrSsk3D9nD?=
 =?us-ascii?Q?o6USgKzbRaRkgQABqGX4nRDiLA4IPFSF4QKqQI8eG9WJFO9fyFJiDOq1WshP?=
 =?us-ascii?Q?oZHBV3Xat3GH6z+5lgbDXQpueldf7tHADB3D3jN+7nJBfjvsHNFnVE1ZdZLi?=
 =?us-ascii?Q?o60MZz/8tMtjdKHhof2eLO3GgxBwUVXVAKGL9OpXnFYBsH8kV0ZjgV5opdXy?=
 =?us-ascii?Q?jrmH/L3/udDyLOvU+oGv0JwifWqLchGoWObj5a3v5s/NhjIn51/Sds0ENcPJ?=
 =?us-ascii?Q?+n3xB86iJA25rtjEcCsIwj6E2c6cgrIyRbtvsb+tMnKMQgz4V572d2UgEuGs?=
 =?us-ascii?Q?z6O5p0Z8qbiUH8UCjqMObjDsI9t2iZ918lFRf4QmukANz7uPi92npHU4XJG2?=
 =?us-ascii?Q?/lq3puae4k7VX1XEsRAesUOCwhelWP5FqwGb9+upo8n6YrCUR5FFaDe9yeM9?=
 =?us-ascii?Q?H6Ihs/zrKWpZu4HvbMM9hObG7RNMxUI+CjxT0AKSl2pNC8aUiatd3P7tf5qt?=
 =?us-ascii?Q?V7lliGQ5mTRSIjHem+M36HI0USMdfMAVuzGWVUzIL62NsGuOaKzzQnvU9lZy?=
 =?us-ascii?Q?quTZoi+U7UwA/a+lP3ybde+rJV20jdUtKzokedWujq7KaDo9UrXnozFlYuJa?=
 =?us-ascii?Q?nowqd0fSY7EorHDkRwmzT/Csh9Z1lU+Jxgh5zybPpIcgFVzF0BSavqY8p9PP?=
 =?us-ascii?Q?MtDdlUw2P56N3XtVDHhPmrTV41UQa51CqzWGxGFmLqIIbxqW5FzyzG7z3sCh?=
 =?us-ascii?Q?wp0kq3avQg8J+WA7k48Kj5YGMRE7BuDsOY6Q7SGWHgJa6GRstP1lvpmZ8d3K?=
 =?us-ascii?Q?QSmHL6tO0PiyqeduUx1yF8wETTwf8Qb0kz4c/Gf6lAAKSS/6PZmU6dprH1yo?=
 =?us-ascii?Q?ZfbFvuvAN1beXVXv7uEgk1wRnHy/cChpXfK7Y3vFo5gmSvujh6W17wE5CmuM?=
 =?us-ascii?Q?1kk/0StF92S0ps8ct9Z5qFqRFzRJCNoo/kfjYZX7vklkjjDUXyTPA7CCdq+2?=
 =?us-ascii?Q?G97zZ79n8aE4zVAq0ea4M00brAvGEqBPU1xwLIxEfR6DsgVrBkXD+9aswL9h?=
 =?us-ascii?Q?6AF/5nDs8X47/aOHX9oPJ4eDt3/ABJnSGiRroszu5H1t0hslueRaNFM4P2Z9?=
 =?us-ascii?Q?6CoFucZwg8EHzeIm4cgqBD3nugyIGt2DKaP2nNlLtU+JIIXKdHP/NunarQWU?=
 =?us-ascii?Q?KBG09wajp1p8xZJpPlFjQkL8Cj8qX4VpISxkUdXBap9lrrzNSWupmU0G0Ls9?=
 =?us-ascii?Q?uMJTJ0BfqFA15CgbfIiIYOJ7VRQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:25:36.0166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf0b37b-a271-456d-f3e9-08de539a4fc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222

From: Dan Williams <dan.j.williams@intel.com>

Towards the end goal of making all CXL RAS capability handling uniform
across upstream host bridges, upstream switch ports, and upstream endpoint
ports, move dport RAS setup to cxl_endpoint_port_probe(). Rename the RAS
setup helper to devm_cxl_dport_ras_setup() for symmetry with
devm_cxl_switch_port_decoders_setup().

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v13 -> v14:
- New patch
---
 drivers/cxl/core/ras.c        | 12 ++++++------
 drivers/cxl/cxlpci.h          |  8 ++++----
 drivers/cxl/mem.c             |  2 --
 drivers/cxl/port.c            | 12 ++++++++++++
 tools/testing/cxl/Kbuild      |  2 +-
 tools/testing/cxl/test/mock.c |  6 +++---
 6 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 72908f3ced77..d71fcac31cf2 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -139,17 +139,17 @@ static void cxl_dport_map_ras(struct cxl_dport *dport)
 }
 
 /**
- * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
+ * devm_cxl_dport_ras_setup - Setup CXL RAS report on this dport
  * @dport: the cxl_dport that needs to be initialized
- * @host: host device for devm operations
  */
-void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
+void devm_cxl_dport_ras_setup(struct cxl_dport *dport)
 {
-	dport->reg_map.host = host;
+	dport->reg_map.host = &dport->port->dev;
 	cxl_dport_map_ras(dport);
 
 	if (dport->rch) {
-		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
+		struct pci_host_bridge *host_bridge =
+			to_pci_host_bridge(dport->dport_dev);
 
 		if (!host_bridge->native_aer)
 			return;
@@ -158,7 +158,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 		cxl_disable_rch_root_ints(dport);
 	}
 }
-EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
+EXPORT_SYMBOL_NS_GPL(devm_cxl_dport_ras_setup, "CXL");
 
 void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
 {
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 6f9c78886fd9..e41bb93d583a 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -81,7 +81,7 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
-void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
+void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
 #else
 static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
 
@@ -90,9 +90,9 @@ static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 {
 	return PCI_ERS_RESULT_NONE;
 }
-
-static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
-						struct device *host) { }
+static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport)
+{
+}
 #endif
 
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index c2ee7f7f6320..e25c33f8c6cf 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -166,8 +166,6 @@ static int cxl_mem_probe(struct device *dev)
 	else
 		endpoint_parent = &parent_port->dev;
 
-	cxl_dport_init_ras_reporting(dport, dev);
-
 	scoped_guard(device, endpoint_parent) {
 		if (!endpoint_parent->driver) {
 			dev_err(dev, "CXL port topology %s not enabled\n",
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 2770bc8520d3..8f8fc98c1428 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -75,6 +75,7 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 static int cxl_endpoint_port_probe(struct cxl_port *port)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
+	struct cxl_dport *dport = port->parent_dport;
 	int rc;
 
 	/* Cache the data early to ensure is_visible() works */
@@ -90,6 +91,17 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	if (rc)
 		return rc;
 
+	/*
+	 * With VH (CXL Virtual Host) topology the cxl_port::add_dport() method
+	 * handles RAS setup for downstream ports. With RCH (CXL Restricted CXL
+	 * Host) topologies the downstream port is enumerated early by platform
+	 * firmware, but the RCRB (root complex register block) is not mapped
+	 * until after the cxl_pci driver attaches to the RCIeP (root complex
+	 * integrated endpoint).
+	 */
+	if (dport->rch)
+		devm_cxl_dport_ras_setup(dport);
+
 	/*
 	 * Now that all endpoint decoders are successfully enumerated, try to
 	 * assemble regions from committed decoders
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 25516728535e..7250bedf0448 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -8,7 +8,7 @@ ldflags-y += --wrap=cxl_await_media_ready
 ldflags-y += --wrap=cxl_add_rch_dport
 ldflags-y += --wrap=cxl_rcd_component_reg_phys
 ldflags-y += --wrap=cxl_endpoint_parse_cdat
-ldflags-y += --wrap=cxl_dport_init_ras_reporting
+ldflags-y += --wrap=devm_cxl_dport_ras_setup
 ldflags-y += --wrap=devm_cxl_endpoint_decoders_setup
 ldflags-y += --wrap=hmat_get_extended_linear_cache_size
 ldflags-y += --wrap=cxl_add_dport_by_dev
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 10140a4c5fac..8883357ee50d 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -234,17 +234,17 @@ void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_cxl_endpoint_parse_cdat, "CXL");
 
-void __wrap_cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
+void __wrap_devm_cxl_dport_ras_setup(struct cxl_dport *dport)
 {
 	int index;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
 
 	if (!ops || !ops->is_mock_port(dport->dport_dev))
-		cxl_dport_init_ras_reporting(dport, host);
+		devm_cxl_dport_ras_setup(dport);
 
 	put_cxl_mock_ops(index);
 }
-EXPORT_SYMBOL_NS_GPL(__wrap_cxl_dport_init_ras_reporting, "CXL");
+EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_dport_ras_setup, "CXL");
 
 struct cxl_dport *__wrap_cxl_add_dport_by_dev(struct cxl_port *port,
 					      struct device *dport_dev)
-- 
2.34.1


