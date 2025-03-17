Return-Path: <linux-pci+bounces-23930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 100D2A64F74
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 13:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F6A3AF2E0
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 12:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB9623A9BE;
	Mon, 17 Mar 2025 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e+a00mID"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2D8239082;
	Mon, 17 Mar 2025 12:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215318; cv=fail; b=aZXfdOOmVnD3CHWwXwBRDNwztlx4PCxhAjZozKDuWyQpXhi7CuO+4bpO929AL+2NkPQdIsYVDq+e0Fm0sfVPUDtnCTYxj8XngZ7ZRL2kUENWuVuUMsAkAPa7S7fh0z2jcAww9zWoyUBFto8m5mx2DC2o6emOThYy/FywF6IG+dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215318; c=relaxed/simple;
	bh=3jcDi+CHhRWx8/m1D8RcptT1HprG4uh/FjBz2rV0Gq8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b7lXamz1jbnK1aMkzJsO9/P+482o65kk4qO331Fqb9iim4mRbxQ1HX4yJdZl3nscKyT9v4EWuus+QdobxMr0+0ADiTtrbjAAhHAI7G098SJx6SJLaqRR5aCVigj6vypaN1kEs8Q0tbtpKm6r5x04tuDCvaUDQ+6TM/k/ewRWWCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e+a00mID; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfaLq6mRLtcy4ybMPD1gnbUSYZXfLaB6cfsIGD/SpGk2X14+o85dT5atjfoI8Beqasl/LL6kDxuThJoiUc8gjbBPNrOAJQsWLAEhKr5N3oYmA3Adjy/OW8eVE5Qld7JhU1WmkbpmAHrGVklB3ZF9shLdRQDHHYhUgAjOdDXEfIKBw0CWnaX3IHx11p2jSzBRWLTobQbYLrAFjMtMHXyVEIxokYTbXpPgDDCabcrKgr/U8NKqRn+TsrnxfFmSPfJLVi2XyfD2QCAfJOse9cCRfJXZGqs7uDQeGvFF4wxJ4Xy4cMnRjQeRvRfpNj2XQ0fEZv7+RdHwIzny351ABOk9OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFVq8gntCpphz6ij/ZXCeQkZ1mfOee0tavIGedNvxJ0=;
 b=uNMT89lJSFGBcZevf/5w94MteWLXvzkXkohbqsHKkpimFxixcrD7QYCBRpGD2K2Qg6lN9LPIWQtIhitJKh9apbPCas85KidLmM47Bcc9K9+6Yk78yCSwJcJFYCRt5XldgPUzl76sEzXpoBHtLVndUIwZSTRj3Bj3xsOgSzdnO30XdRIScF877JhEZ1Y4wsawdP9ymcxKjZSirbDjsAy3zwizW2idW5MG0I5hZdfE4h4hRjxBJPYKSOWJYXyjR59oKZ2UDGWS+6qA7DmyemK6sh0LPHJK2WOqKab6tjOWiWjfZwPjw2fhZf0yYb7mthQFv+Zmjx0E7vrEaNVBR7/3UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFVq8gntCpphz6ij/ZXCeQkZ1mfOee0tavIGedNvxJ0=;
 b=e+a00mID6IxuM/DBmIIleqqN9VGXUJpB8Z3kB/yMB+wZUXFlQ1flUoGThPXgRG6Pb9bK/ez7OgTG8je/KikOXpQ+Mb8fsFYR/2LB0nPY85ZmfpsTeaVv7O1OckoACERZPhU68KlpSufiwEWMQyUFPRxgCL/5AsS6ND/595a5dz8=
Received: from BN0PR04CA0175.namprd04.prod.outlook.com (2603:10b6:408:eb::30)
 by SA1PR12MB6945.namprd12.prod.outlook.com (2603:10b6:806:24c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 12:41:53 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:408:eb:cafe::20) by BN0PR04CA0175.outlook.office365.com
 (2603:10b6:408:eb::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Mon,
 17 Mar 2025 12:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 12:41:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Mar
 2025 07:41:52 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 17 Mar 2025 07:41:49 -0500
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH] PCI: xilinx-cpm: Add cpm5_csr register mapping for CPM5_HOST1 variant
Date: Mon, 17 Mar 2025 18:11:36 +0530
Message-ID: <20250317124136.1317723-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: thippeswamy.havalige@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|SA1PR12MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 350c3b69-5488-4f8d-5fb1-08dd6551186a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NBFxi4VXtjgZXDlC6tpaLXdv6/ErsUtbhCDeNx+SyTLaQKHcLWILBQ9Hfggr?=
 =?us-ascii?Q?SvFskzPs1NRDxydh4rDRWS52ZkZVohILPYZ/G0CnIlO/K56yVdolwdBunUcb?=
 =?us-ascii?Q?nP6zTVzzUXKjvHPNqEz6+VITKi0tiiVZklIkb0BiBr6EPk4b6sW0VubeE2Dh?=
 =?us-ascii?Q?dnC5zfL60WYzCyBmbUL69RDNdfhmxyozLUtGMrfHtKFpFpKLKt6WBtCyLYBO?=
 =?us-ascii?Q?GdgKq8+XuKXtm9TWT1RiXF3fDt0eXPO+7TGw7I2cM1ONrAOTGBj1QpCOV3Hw?=
 =?us-ascii?Q?9Oksp5GTKEX5eKvUUhR+/91wnRSQ+D0kJWAdPBxQLBJNL5MXNnZMg2AAKD52?=
 =?us-ascii?Q?0lhNai87nmFLhjht/96L8bi1U0G3hxHG6CSHdvIywI759V2eT8ExGoUoWzzJ?=
 =?us-ascii?Q?VJ70enrbLTqneWSh1NFUE8b7jS21OwUkKcW+ihEycND0VCWTmDcD0k+cloyc?=
 =?us-ascii?Q?ooGLePQkrrQ487BQx2zI+vdR5iNdgDHZ9hoIiwphU+1vpYao5CK+S2iZ9GrL?=
 =?us-ascii?Q?b97X6LkZrEYe2/QLR++qQT0r3f31Os9NNf5RkyYgWXK+OL5THySqtWVS/+5I?=
 =?us-ascii?Q?tEf6aalO/U0U5rEzHHGaHVvQHhHa5n4T9GYwRGlqneTI/aCrMCl+Hv6YZMCm?=
 =?us-ascii?Q?8GPzSppNn4JlzDg9qKFErIh58s82GTXFoaZHf4ggtHo2+vKxJZmpAhxud4F4?=
 =?us-ascii?Q?dq0rS1lQbpepvLeRORVBbvalM5Py41QyY/x7J4bGHgoUqqIAW4Jc0vFD2ngC?=
 =?us-ascii?Q?Jcxxi20VYg4bPj+1TWCHfOv7191v7GeZNmSZ86vGdicSLzyKvNXO1qhB3xhr?=
 =?us-ascii?Q?hfSwD9E7qvaDzD+5IadcZ0w+1j+u53c8bf8gYGojXI3vvVouTy92l3so6mNK?=
 =?us-ascii?Q?JblKdDOgQ+J8mGfUnN0WyE7aLBe7JcvqOrvMdXSG3yS0gkviNuWIqT3ZOGGQ?=
 =?us-ascii?Q?lxZZ2wOcQxmlyHrh3u7g7oOCuDtY3oe2WDHnfUfByA2meo4KqGxw7AjlzXfh?=
 =?us-ascii?Q?4Z7B+b+H8/7iu9mhbw1BWubOXT0pJ2lNgjtIYIxdf6/NsdQTN883PTZtbB4p?=
 =?us-ascii?Q?qq6JJRQzZwCngScQTn2h6TCeVcpGKOZWaEuERPPYsCCRiYDbOfqtl+gJ9kwr?=
 =?us-ascii?Q?QYP8uWFfkkFwwNfJ0GZ7jRD7ouxv9f/PlWvVO0ghiW6tpuwG7431OcVetg4m?=
 =?us-ascii?Q?zKlx+wwoz0sW5Vi1jPOT6ywCvkinnYHCBN5TPxwXFn2fhiBECUAiHhEtshon?=
 =?us-ascii?Q?9LAa1Wb57X0nfoTrldxTJKQ02Ve/5TNPVlA2dExQ2lh4TVh69RX0Kd4Tjl5Z?=
 =?us-ascii?Q?4eUOyd+rn2QnUOVWPMcvNK0ZEOKiH5pEa/P3E+lvNp6KqFbKS41ANzJsGGUn?=
 =?us-ascii?Q?OW180d0kpXozQy682a5VQ0Qcxc4UvTjQcdcX+Km2N29ModO5PR5+GK5jtBOW?=
 =?us-ascii?Q?CO3nc0EwtiwOdq49yd/XIvNezItV++floSS+DFUwLfGkjiqaE4jMLA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 12:41:53.2546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 350c3b69-5488-4f8d-5fb1-08dd6551186a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6945

This commit updates the CPM5 variant check to include CPM5_HOST1.
Previously, only CPM5 was considered when mapping the "cpm_csr" register.

With this change, CPM5_HOST1 is also supported, ensuring proper resource
mapping for this variant.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
 drivers/pci/controller/pcie-xilinx-cpm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index d0ab187..13ca493 100644
--- a/drivers/pci/controller/pcie-xilinx-cpm.c
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -542,7 +542,8 @@ static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie *port,
 	if (IS_ERR(port->cfg))
 		return PTR_ERR(port->cfg);
 
-	if (port->variant->version == CPM5) {
+	if (port->variant->version == CPM5 ||
+	    port->variant->version == CPM5_HOST1) {
 		port->reg_base = devm_platform_ioremap_resource_byname(pdev,
 								    "cpm_csr");
 		if (IS_ERR(port->reg_base))
-- 
1.8.3.1


