Return-Path: <linux-pci+bounces-40252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6A2C32411
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 18:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9333BDBFB
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 17:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49F633891F;
	Tue,  4 Nov 2025 17:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1J1lsNZq"
X-Original-To: linux-pci@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013063.outbound.protection.outlook.com [40.93.196.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0854B3396F0;
	Tue,  4 Nov 2025 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276020; cv=fail; b=INixMx4SKbSyEi8HO2RPSFB8mVVGs8fAQ9Bvfo8Y2O6NXnem0uS7B8+AyL82n2HWPz1RjHxD82XO0/O+Oaw4YmEELBx0HyX1ewcXgWXRKpykz5O55pZtWmmJNolX8M64NWS7A/iy5mOahyD2qtfLOpZ0KI4mNa5ZJgyQau6eAI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276020; c=relaxed/simple;
	bh=hbgh/iMgRb0flUlGfGuSyztVIg+IEU2HEd0N7kOb+fk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mibpDn64EXLcyvqbBe0zog8EJGUduTqlv/N2UX24YMT3tWHeFt+6B2oYxT01PmTutTR0LWiQ30io5ItuFD0m9caXWHh03CZTONxMRvwYW9f6asapjzIPP00aYSwes7GB2V7PKGndQQngS8eSJBVrMoCbUrlLR+o9+vHI2ef+CR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1J1lsNZq; arc=fail smtp.client-ip=40.93.196.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIotgvjwSeDSS/rENS2VKJwlRPkpwu7c9XJMHQswr2rbEgvlUvJRDAOOpxanv1UdAIXVCju3CZAUyU8o10zxPMwZrwJ7+EfFzK46nLuyxf5ucVr0oh15fFpS9+HHM2Rgwf0wuoGNqhv6RxVRS5EL1WxqPVHzIJ8eyvcTqcJgEfpU+zKWe9H+oocc6/X2NSEeGjHMdCdtZQI8Hh8DPpTaLleuSSc4IEHefOrjgcV9mWmme1b+FjNq8edRESyhzHgdIsLhJsdwEHPj60Q2TalgToIDYQTK7AsVGa6nmF8NUEg4iGr5tY1hrMqDpTR91VT7lvCSO8l3BnR+yrvhD1anJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6B7CbI7ujuW3DEPbsRDKhPd/KQK1oc5Bj9pexPwRGo=;
 b=vb1M2R2NfoB0z7sBsGEnm0ZLBQ28lRCBg1bRTImbyf7rmWVZjy65V11AXNuLr23p+MSSkmrvZkFK44vi3toCxEsOWpFpD7vxsS56uhKxbGBAq2VyLV/91RCPQ/qdTszwwqxX6VLOMFquTYBOG9OSX0UmYKf6F611/wQV03GgTA1PEKJ2I9ftGdbrKMe7o3AhMgA1WIgAZdJM0jOlNVxo0dyN7sQJ8fOK+EmV2jKir0jJ5kcjm+fYOT3i8FprJIKVAC9/XLOXJn0XXpdde5CgxbQVikZbdDQSl3kqL6+UpnzhLbUsvjrXg/sMeuqWC0jUv/hxKLiSnjq9Iy4i7E5R+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6B7CbI7ujuW3DEPbsRDKhPd/KQK1oc5Bj9pexPwRGo=;
 b=1J1lsNZqPZDdjQrxwJQYrGtL1oF2bA7X2Zt372gxmpjBvr8bvADYvl2USVSCK5fSzy0vcyeyMLwwdUX7g+IvZTmYmemc0a9x/oWpU7tFI1jNFlkoikgV4kSwUyfnQYQ66UfPS+TiAl4JXH+JH8LSQZs5nVd4wSftsqzf6HQBMcc=
Received: from SJ0PR13CA0089.namprd13.prod.outlook.com (2603:10b6:a03:2c4::34)
 by DS2PR12MB9616.namprd12.prod.outlook.com (2603:10b6:8:275::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:06:55 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::6) by SJ0PR13CA0089.outlook.office365.com
 (2603:10b6:a03:2c4::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Tue, 4
 Nov 2025 17:06:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:06:54 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 09:06:53 -0800
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [RESEND v13 20/25] CXL/PCI: Introduce CXL Port protocol error handlers
Date: Tue, 4 Nov 2025 11:03:00 -0600
Message-ID: <20251104170305.4163840-21-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104170305.4163840-1-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|DS2PR12MB9616:EE_
X-MS-Office365-Filtering-Correlation-Id: f59a76e7-35c3-4119-ca3d-08de1bc48e10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IJ9896HMdGiyuFNCu9p7I/hawu5HaQg0bk7F5WyJ0eNrN20KJmLpVLOxHNKN?=
 =?us-ascii?Q?FEP+six+n4MgJ781Q12gV/NSUG1P+P/X25ovn/W4d4cnuRrX00r5bZ5bCA0F?=
 =?us-ascii?Q?21hG5KMKmkz7cnZk/kw6apK7FLieiUdooKqDPbYoudq7NPR00H3PoScP7mS2?=
 =?us-ascii?Q?mPwYgtnLfaNbTHeRvhCuRl0QcT6hZul7oAzxfHxzlc0U1pj++2lrC2dz+xZj?=
 =?us-ascii?Q?aIun/HwUoH8TB+TE04C6dTealU9+msa1JNHQMLjlnIhWMCWXtn8CFdUfCu0S?=
 =?us-ascii?Q?b1bFKQYxCE8aMaBTedoglAKEdiHFEgGa3XXQTl7ha0EIIQ2AY1suiUln6O6e?=
 =?us-ascii?Q?oIPQecWu3ZaWgWVmXFF4c2b7vjIp1xD8qmZX8OgaqwSdcv0Otu7m4xcp+BRp?=
 =?us-ascii?Q?fyni1tMqwt/qqG6ExWk6R0jKnWquWTN/pJBQP8wbsDVwiH+Z7v5mjIeDZ3MU?=
 =?us-ascii?Q?IcyLs7urFYYp6QSei6MGdIRF66TM1CTujJgLqGqEga32uMEBeN8M/x1Tfqpm?=
 =?us-ascii?Q?44ijzpNlWNqhWptDOxLgoTWltYuDWfbzSokOYm9R2AtX/qwDMkkYLFAKiTdj?=
 =?us-ascii?Q?90sut6t9PwRPSPOG+3zs8mx7xbK7UlFaKWe6xnCd2iwZcb+GgTeSVW8gxI8+?=
 =?us-ascii?Q?liTDFhDEEOolWpU10uFfK7iThLbSQ/6an9Ipw08CO5qSDjTG8B6vCPm0gi5Z?=
 =?us-ascii?Q?Z3h8ZBySAZDzAYv4sszHH28n6o/MtG9oyn55T+68ybzIzPH9W3AoTstm+0up?=
 =?us-ascii?Q?FUdVHP/vZbeEQMk+hGzk4CPeIN6EOBKUKbtqO4hm4JgvTz2LTou9HmgOAMXt?=
 =?us-ascii?Q?EjaJr2/cDySGn2wfaTOmZQ9wpC7ZkHMkeFiBbyoL7RK4RalVKOMydgviS8rP?=
 =?us-ascii?Q?lYFF/nhwI0KUKgsoZPqc0E8MeE6SpiK7R6YQw11iZDOybENcLRWoyfy5ftsD?=
 =?us-ascii?Q?XwNYNKhyCWYgvy7hZcZfTVXizw1l8SYXiS8uSLErQKmOpxDFheQuF3ZJJoMH?=
 =?us-ascii?Q?NZDbqfT8hhgw2eUMJe0KVnGom0yYHQi0fqUAOQzkNKgOytppbTne2XddCOCT?=
 =?us-ascii?Q?pdSxltfFeU85ljckiJddOA0XGFnmq8EuXpFbNCtotAfb0XB9nPl+AqsqkD2i?=
 =?us-ascii?Q?GL/EueQgSYPXJxrYktxV6QMB9+LlqjEUXzzVnRpjyL68ORM6WwVCrjzbp3gp?=
 =?us-ascii?Q?udIDQino4gpwmiBMZ7fJVg1xmPRZfPBj9sXlIXpJZ16GxZ3ABHWej+JQbXw5?=
 =?us-ascii?Q?cIFPBUVwCShVlNgULBwJc57ErMXUY3h7NeNhiNKZDUDdoRGO8nUFt4OXnscA?=
 =?us-ascii?Q?FCD1MP/t3OqRs0UhGawiKOoFTXpDDYRTklL3E2qjmlSnHY2nwg+7yuVGWxr2?=
 =?us-ascii?Q?6eG0d2EY0DyvoXVv83fEn+w7+kDRV9hr5SCpiKP04g7A8dihMKK24W2IbCrS?=
 =?us-ascii?Q?/UVyUUjhnupN7twynep2r0NocIRzWy2OEQqtTBxD70jyOC/pIZmz4zu7ia3c?=
 =?us-ascii?Q?8veLI5bfrTV6tW9qj458Ch+l36fOFvBKmv9mS3qFoA8CO+Vnk1HIIoKQ7xWG?=
 =?us-ascii?Q?h5j3ocYrUeq2M7PLYqefXcS2xQO4Jh1Drwv0LisV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:06:54.2852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f59a76e7-35c3-4119-ca3d-08de1bc48e10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9616

Add CXL protocol error handlers for CXL Port devices (Root Ports,
Downstream Ports, and Upstream Ports). Implement cxl_port_cor_error_detected()
and cxl_port_error_detected() to handle correctable and uncorrectable errors
respectively.

Introduce cxl_get_ras_base() to retrieve the cached RAS register base
address for a given CXL port. This function supports CXL Root Ports,
Downstream Ports, and Upstream Ports by returning their previously mapped
RAS register addresses.

Add device lock assertions to protect against concurrent device or RAS
register removal during error handling. The port error handlers require
two device locks:

1. The port's CXL parent device - RAS registers are mapped using devm_*
   functions with the parent port as the host. Locking the parent prevents
   the RAS registers from being unmapped during error handling.

2. The PCI device (pdev->dev) - Locking prevents concurrent modifications
   to the PCI device structure during error handling.

The lock assertions added here will be satisfied by device locks introduced
in a subsequent patch.

Introduce get_pci_cxl_host_dev() to return the device responsible for
managing the RAS register mapping. This function increments the reference
count on the host device to prevent premature resource release during error
handling. The caller is responsible for decrementing the reference count.
For CXL endpoints, which manage resources without a separate host device,
this function returns NULL.

Update the AER driver's is_cxl_error() to recognize CXL Port devices in
addition to CXL Endpoints, as both now have CXL-specific error handlers.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

---

Changes in v12->v13:
- Move get_pci_cxl_host_dev() and cxl_handle_proto_error() to Dequeue
  patch (Terry)
- Remove EP case in cxl_get_ras_base(), not used. (Terry)
- Remove check for dport->dport_dev (Dave)
- Remove whitespace (Terry)

Changes in v11->v12:
- Add call to cxl_pci_drv_bound() in cxl_handle_proto_error() and
  pci_to_cxl_dev()
- Change cxl_error_detected() -> cxl_cor_error_detected()
- Remove NULL variable assignments
- Replace bus_find_device() with find_cxl_port_by_uport() for upstream
  port searches.

Changes in v10->v11:
- None
---
 drivers/cxl/core/core.h       | 10 +++++++
 drivers/cxl/core/port.c       |  7 ++---
 drivers/cxl/core/ras.c        | 49 +++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/aer_cxl_vh.c |  5 +++-
 4 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index b2c0ccd6803f..046ec65ed147 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -157,6 +157,8 @@ void cxl_cor_error_detected(struct device *dev);
 pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t error);
 void pci_cor_error_detected(struct pci_dev *pdev);
+pci_ers_result_t cxl_port_error_detected(struct device *dev);
+void cxl_port_cor_error_detected(struct device *dev);
 #else
 static inline int cxl_ras_init(void)
 {
@@ -176,6 +178,11 @@ static inline pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
 	return PCI_ERS_RESULT_NONE;
 }
 static inline void pci_cor_error_detected(struct pci_dev *pdev) { }
+static inline void cxl_port_cor_error_detected(struct device *dev) { }
+static inline pci_ers_result_t cxl_port_error_detected(struct device *dev)
+{
+	return PCI_ERS_RESULT_NONE;
+}
 #endif /* CONFIG_CXL_RAS */
 
 /* Restricted CXL Host specific RAS functions */
@@ -190,6 +197,9 @@ static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
 #endif /* CONFIG_CXL_RCH_RAS */
 
 int cxl_gpf_port_setup(struct cxl_dport *dport);
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport);
+struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev);
 
 struct cxl_hdm;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index b70e1b505b5c..d060f864cf2e 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1360,8 +1360,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
 	return NULL;
 }
 
-static struct cxl_port *find_cxl_port(struct device *dport_dev,
-				      struct cxl_dport **dport)
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport)
 {
 	struct cxl_find_port_ctx ctx = {
 		.dport_dev = dport_dev,
@@ -1564,7 +1564,7 @@ static int match_port_by_uport(struct device *dev, const void *data)
  * Function takes a device reference on the port device. Caller should do a
  * put_device() when done.
  */
-static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
+struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
 {
 	struct device *dev;
 
@@ -1573,6 +1573,7 @@ static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
 		return to_cxl_port(dev);
 	return NULL;
 }
+EXPORT_SYMBOL_NS_GPL(find_cxl_port_by_uport, "CXL");
 
 static int update_decoder_targets(struct device *dev, void *data)
 {
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index beb142054bda..142ca8794107 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -145,6 +145,39 @@ static void cxl_dport_map_ras(struct cxl_dport *dport)
 		dev_dbg(dev, "Failed to map RAS capability.\n");
 }
 
+static void __iomem *cxl_get_ras_base(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_ROOT_PORT:
+	case PCI_EXP_TYPE_DOWNSTREAM:
+	{
+		struct cxl_dport *dport;
+		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
+
+		if (!dport) {
+			pci_err(pdev, "Failed to find the CXL device");
+			return NULL;
+		}
+		return dport->regs.ras;
+	}
+	case PCI_EXP_TYPE_UPSTREAM:
+	{
+		struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
+
+		if (!port) {
+			pci_err(pdev, "Failed to find the CXL device");
+			return NULL;
+		}
+		return port->uport_regs.ras;
+	}
+	}
+
+	dev_warn_once(dev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
+	return NULL;
+}
+
 /**
  * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
  * @dport: the cxl_dport that needs to be initialized
@@ -254,6 +287,22 @@ pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ra
 	return PCI_ERS_RESULT_PANIC;
 }
 
+void cxl_port_cor_error_detected(struct device *dev)
+{
+	void __iomem *ras_base = cxl_get_ras_base(dev);
+
+	cxl_handle_cor_ras(dev, 0, ras_base);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_port_cor_error_detected, "CXL");
+
+pci_ers_result_t cxl_port_error_detected(struct device *dev)
+{
+	void __iomem *ras_base = cxl_get_ras_base(dev);
+
+	return cxl_handle_ras(dev, 0, ras_base);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_port_error_detected, "CXL");
+
 void cxl_cor_error_detected(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
index 5dbc81341dc4..25f9512b57f7 100644
--- a/drivers/pci/pcie/aer_cxl_vh.c
+++ b/drivers/pci/pcie/aer_cxl_vh.c
@@ -43,7 +43,10 @@ bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
 	if (!info || !info->is_cxl)
 		return false;
 
-	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
+	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
+	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
+	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM) &&
+	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM))
 		return false;
 
 	return is_internal_error(info);
-- 
2.34.1


