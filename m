Return-Path: <linux-pci+bounces-40159-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AE0C2E85D
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 01:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4994534B897
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 00:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E65B44C8F;
	Tue,  4 Nov 2025 00:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xBc0J8Oq"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010023.outbound.protection.outlook.com [52.101.46.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708B245C0B;
	Tue,  4 Nov 2025 00:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215047; cv=fail; b=GCOq0oX+Sg4SN78fYcPY06tkpfNEX76Mwh7EJKbOukn1XpdoeeVJD2ZXghRYnsdJ/WMS588XRqzz5onLuc8zGJkh/yO8qK5dBt28uY38wOAhPfaTw8yaNRqhKnTC9hhredyqg9GCZQuPehEKqsVGnttTcejU9xo6IvzM60fBysU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215047; c=relaxed/simple;
	bh=XPW+2rtyQFTY1dSZcSu+J20BPnB02US8lZ7YUju2nvs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tgWBgukJp+V9FevzzWMGIfb7GfIwC2QypPxfaggh+7L8ogNDcNdEFf+30P6OuZgR9RuU+mA1HXPiXnmdz3J51lXEeFJ4yqOs2GR2Z1ogMJQD27x4T38z6B3AsG0g4HIWQS9EhjSWDuBQkp0GaFy7ow+0QxOTQZisxyMlG0ewXs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xBc0J8Oq; arc=fail smtp.client-ip=52.101.46.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PVDe81vzYRCrtkeIBZ4TGblUxDpSGCRpVr6oZTlpyNJltUsCChmZNgmL7PR3LIKQXHeyELFgqaS0hdB04kwp/H2409pWqaysQEOnpzIVPNhxP+7UvfvECqHHbT+S/xPX4OUkHr1MF/mNXUg8e661/jBU2YvL8KCLITQQn0dMKsjiuJN6HmJRCmERPmjDvL4uU9M4jbjdLvFqzWhG3MTQOq9x1TeJyVd4sGDgprRParxNCRKt0NQPdx8i65dXbHdbHfinzhF608rRhfliQwVZkcvuQGikpZiGzWGVFs8r02FUGSf8KEGqvtdA25NVbLBzTjSXre17QGezO092k1q+TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cb8dJfXSiXk3kt7oeHbShtZ4F4wXIyAww3KxisEyfY=;
 b=an7DV/iNuHt8QnZAaoViIWkNZYqJuIv8etZ/QUNxnGcZ1x7xsCx50ragW6Q/I2jq/u2bfkVNe3HiQmklplHZ/u4JC7BVK2/+axZz+6xyJMjILSKh/B7bmCRT73uzM0p7kxiBm0qORTzl5E4+Dju83nyZAk+UPLjA7GouHdgxzonzuOX1iwfA7QWRLn8+OvYj87Cn0c6QB0AtlvVpKTA8czGg5xl+z1BxS0SOcNYnpWuNYvk7ELmdWeBUhkgO0ofAblNLVqrn9eSZFoMbVqHcsF4ZbwEBUO4kz1pDfNNSRdNylX1UGVur/eTm83V7WLorPYedmpcbJER+7ant6H8VcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cb8dJfXSiXk3kt7oeHbShtZ4F4wXIyAww3KxisEyfY=;
 b=xBc0J8OqduAWL7Rmgq+q0jxk7NMvQy2oIOgkj7N/JCzeGuNMpZaZgyxYdlpfbwgRGPT/9iGWf93jjgb+HxtEQgPAl+YX6qEdOmJes92Gjm5NCWQWUjCcjfhmQN7EJk6zMcTbGbZd2U6ZfbSvH7XTAN+3uZse0obuG4oARR06KrY=
Received: from CH2PR03CA0030.namprd03.prod.outlook.com (2603:10b6:610:59::40)
 by CY3PR12MB9678.namprd12.prod.outlook.com (2603:10b6:930:101::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 00:10:41 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::6a) by CH2PR03CA0030.outlook.office365.com
 (2603:10b6:610:59::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 00:10:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 00:10:41 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 16:10:40 -0800
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
Subject: [PATCH v13 03/25] cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
Date: Mon, 3 Nov 2025 18:09:39 -0600
Message-ID: <20251104001001.3833651-4-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104001001.3833651-1-terry.bowman@amd.com>
References: <20251104001001.3833651-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|CY3PR12MB9678:EE_
X-MS-Office365-Filtering-Correlation-Id: 095bdeaa-f08d-46ee-4bc1-08de1b369724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|30052699003|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N/Q5KHPzUv1g1JkvnJ9AEy+uype1tzK8/mnh7Mf0ECyfTOw2Wf2PzMz6h2Ps?=
 =?us-ascii?Q?oDzShOlGVNtJv8BFqrkqLeF1MIQrrShbR/DjM6ds2GE1QIgut4KC84NKPdGT?=
 =?us-ascii?Q?3wnXN8l7Gc9PuRWT4hGS/rB6XllMRysPaGS2QvBSjYjp3ttLWmJhKX6a0b09?=
 =?us-ascii?Q?0t40RtPBMHBYV9Jgx4bXZPSrRsmvsdROoHFNwTJOHBdeozzZ9Pqmha8Arxvy?=
 =?us-ascii?Q?hgiJzJw3X2OyxpHYcRdh1NLtiet26Afv3c6KMsQ9zT21DkE44gBBi5bO16bw?=
 =?us-ascii?Q?JVk5r6A6BKF7m7yKBSamMGQoybZ6oTm6NpW2aVFjDWT7sC0aRhVPjr3BzGVy?=
 =?us-ascii?Q?OWuj7/76nS3WV0v89SwBq5uGIxJ0lTfurIT9v1mqxnNqSqjNazJABFNtMOYC?=
 =?us-ascii?Q?FSZarhhExT3tG3ijUSaYyn7fWOL4Y5RmDVAS2PyPnGOez354n9Fxwk4nTQli?=
 =?us-ascii?Q?On5pdPIBOL3x7vXJTm2EBXqnNBnWLfyrLiZTIEzDj15EWw/SgzVWGos82bpc?=
 =?us-ascii?Q?hGvUwqM1XeTeuLz0Es+VtSjWUXrpKRz9KD+neLyq0DwV58aCURJQD88Jtec5?=
 =?us-ascii?Q?S4q8eIaeOkYOC4Mz3P5Hqv3iwC4p//cbQPbGBQb/acIPisH41WkaTq3ZP7OR?=
 =?us-ascii?Q?MchgyI4s/dtbjDpOYHszitFFMEiGS2wJcdXn60cd8QLtJrTJDecF+p8BImhZ?=
 =?us-ascii?Q?Ra3TZ0hLWv3uBBOp+VyORvoMvZwCU7eB4sudr1gIlxvcJdHg5uGK5HBgUXZB?=
 =?us-ascii?Q?M4+85LebOD6YBnS/8gu8r4v/3ooHGU2PX2pL9aXtfSkV+J8/UckncRuURMjA?=
 =?us-ascii?Q?v5QhCckaHVG32d2di8bToTjQky5v0wgWlbnjV7BWYUDH3b2kSbQreYNsb3eT?=
 =?us-ascii?Q?IHh5ZqUCk/RPFbqkfFHtjMUk6UlseA75MUBL8pZ9X78murWDkVpYxWX2A0nO?=
 =?us-ascii?Q?ROoEVB2Ikpd8dLzyUOSns+QJj09+c7MFhAPgFlwe/psYcVRV3lA9p7iBsGr8?=
 =?us-ascii?Q?YoGpU/RJJgKQru/qOPTer5Xlv0EAdSm3tK7c7ZiaEU1SHC2EIKRQb26jLHyp?=
 =?us-ascii?Q?LKMgeKqnKtE2bxYkI0EDQ9f5jakuHlOOieSuXaK4pqY9WhWmmn4m4ZE5By6N?=
 =?us-ascii?Q?Fk99lnrDDo+j4IRcWCTaK/GRk3+mhz2dJfEJ6JdoItvv0yl5kQdMRSoXamJL?=
 =?us-ascii?Q?C8CwXdMDJrpxwnJNtwZGVpsBxhsz0itI8wrykunGeXKhTJRRd8yLCvnr/ii0?=
 =?us-ascii?Q?nXS/LW6XiPEy4sHdRipC9LapoE9Kr1b4wbMyzV6gbppfhkFInaKB9QYcIaEE?=
 =?us-ascii?Q?f3ZllkJ8ee9l1Ir7E2asWTxEpKTlImU9Qm6uRj/s9vPunMfZKH1Phj8sr/Fd?=
 =?us-ascii?Q?6W1aiqCTxix6eD7ciU2tg896bK6SN5GMbKx2Rrrp6o9yrv9N7/PkfowZquK8?=
 =?us-ascii?Q?tqGjfVTHtXy7qU36njk3SGUfdOsFZnWGCMTI9u9I3cZmWfzUJUHPNkeFwbWi?=
 =?us-ascii?Q?ZLWF62KZ3k07vTeqWhKeoAi9WdDVU4LcrZD7liv154M7p9Y3Z2FxErS1ustB?=
 =?us-ascii?Q?7vSAGEgH8oeIs2NB6batA6T2obzNvMnaGb9RlJeL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(30052699003)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 00:10:41.0572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 095bdeaa-f08d-46ee-4bc1-08de1b369724
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9678

The CXL driver's cxl_handle_endpoint_cor_ras()/cxl_handle_endpoint_ras()
are unnecessary helper functions used only for Endpoints. Remove these
functions as they are not common for all CXL devices and do not provide
value for EP handling.

Rename __cxl_handle_ras to cxl_handle_ras() and __cxl_handle_cor_ras()
to cxl_handle_cor_ras().

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Changes in v12->v13:
- None

Changes in v11->v12:
- Added Dave Jiang's review by
- Moved to front of series

Changes in v10->v11:
- None
---
 drivers/cxl/core/pci.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index cbc8defa6848..3ac90ff6e3d3 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -711,8 +711,8 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
 
-static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
-				 void __iomem *ras_base)
+static void cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
+			       void __iomem *ras_base)
 {
 	void __iomem *addr;
 	u32 status;
@@ -728,11 +728,6 @@ static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
 	}
 }
 
-static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
-{
-	return __cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
-}
-
 /* CXL spec rev3.0 8.2.4.16.1 */
 static void header_log_copy(void __iomem *ras_base, u32 *log)
 {
@@ -754,8 +749,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
-				  void __iomem *ras_base)
+static bool cxl_handle_ras(struct cxl_dev_state *cxlds,
+			   void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -788,11 +783,6 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
 	return true;
 }
 
-static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
-{
-	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
-}
-
 #ifdef CONFIG_PCIEAER_CXL
 
 static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
@@ -871,13 +861,13 @@ EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
 					  struct cxl_dport *dport)
 {
-	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
+	return cxl_handle_cor_ras(cxlds, dport->regs.ras);
 }
 
 static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
 				       struct cxl_dport *dport)
 {
-	return __cxl_handle_ras(cxlds, dport->regs.ras);
+	return cxl_handle_ras(cxlds, dport->regs.ras);
 }
 
 /*
@@ -974,7 +964,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 		if (cxlds->rcd)
 			cxl_handle_rdport_errors(cxlds);
 
-		cxl_handle_endpoint_cor_ras(cxlds);
+		cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
@@ -1003,7 +993,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		 * chance the situation is recoverable dump the status of the RAS
 		 * capability registers and bounce the active state of the memdev.
 		 */
-		ue = cxl_handle_endpoint_ras(cxlds);
+		ue = cxl_handle_ras(cxlds, cxlds->regs.ras);
 	}
 
 
-- 
2.34.1


