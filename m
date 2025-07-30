Return-Path: <linux-pci+bounces-33215-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD61FB1688F
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 23:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3CC2622734
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 21:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56FE223DD9;
	Wed, 30 Jul 2025 21:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I695oOCj"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F8321CC63;
	Wed, 30 Jul 2025 21:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753912219; cv=fail; b=knnE0hIk8aks9MNTI3v1YYY9rV7dAgt4jN9nkJvDCbU6426Sk0gjGuo+LqAJ4sGsfkfIwiHGPa4aIM6Z1dDxc1+CHZP5H7/pglaiVhiWiLZ8Xkb1KYYhPUVoBSkF9Rw3EiBxSSoKWwYuGtu2v3O8KxQ/VqcLZdq6iAFS5PPiqgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753912219; c=relaxed/simple;
	bh=Z/f77krkWelz28xy2D4qh+PG4qL6MIzl9SwOCvEEEJc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rG0vatZrGM2JrgPtfshqLPBbxtlskyo9AElzWcT7zsLBbYhVfluua6bZa3eugGKtRMw4gbPm1NUynkXtaIoahwJcqt3Ee7fy/HPZg+DrqTVbHmbaaroZqUgAb8VRP23IyxW4dWWKnZkUVcsvEaZJesK637ZRI9VD6aE9SCYLhOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I695oOCj; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlmfLdlG/w2g7Zy7TRfPI4VOQTeaoGqlyRi1KnF2Crdhu3TGFnsIu4HabFzYmdR6hcvvNTyobxNI356xIymM5QcfO6On1GKPilJ0nGsNRXK5FVy0sbD0/CF6NChT4knp1kGT2NYJsKd5abTEfXbxTONR7a/4LlAk7VskojZZ826tY4fCmKSNXyYYS53XhdN/zunxlApuoyiOr+/BV6hjq+hc4XNjVetIGXhoj0oXVTRmKT5lq4dravCPFufyqtedLGhvtXfDjGAOKteEkxec5isBfWtXggPkLssuYW96isSZn52jRvHe9oSUQptrj84XraGvEnLrLKZcngKiK7nMhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgsHtVs0LaoD2N7AlsEZbNni85Y0pcm0NZhikFgwq+w=;
 b=ZoGj/Rjd3wb5CFuqs1bCUmlhKOe0SYFjFTpn+zbirZJACR39itHtzENouS/TUY/dnHhjgsAXSP086mLrTc92ca9EGvp6F/MAaDbWzxBdq6bmQqiso+2+PI1bGhDDZzpeWjdPwV0helabZ4ReZo/DJb5JPZ9W5eijb39wsFaO6bclT4f6LSJx9tiDk1E4hX5LVFuFkZ8Wy5/BKyElAB0AZyZxqf9lGPBgfonzS6O+gySfLAhhzdnJa593qxxUyx5xXLknhzRDJnJ7I9/2eLFeBl1E1GTtj3jxguVyNCdytNFHm5HhCqPJnCtFVaLaGK05ceIIpnZhuez6MT6wtM+dJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgsHtVs0LaoD2N7AlsEZbNni85Y0pcm0NZhikFgwq+w=;
 b=I695oOCjAPZqDVYxcd0bQdpCBOXB3bGAZGdmHUchwkacoXcn6mrBOYaoz0TmbP/Kq+A+kdosvMLHh5YLiOmfieHqHlxKhnZB/hJhlYJVEuYf/nnuAfi0rKf1lmu9cwK5UVodeVTNw5xtolTjDJPDMCwZJZWAUjVMInUxRFH+xqw=
Received: from BL1PR13CA0123.namprd13.prod.outlook.com (2603:10b6:208:2bb::8)
 by DS0PR12MB7701.namprd12.prod.outlook.com (2603:10b6:8:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 30 Jul
 2025 21:50:14 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:2bb:cafe::39) by BL1PR13CA0123.outlook.office365.com
 (2603:10b6:208:2bb::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.4 via Frontend Transport; Wed,
 30 Jul 2025 21:50:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 21:50:14 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 16:50:07 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH 11/16] cxl/pci: Add isolation handler
Date: Wed, 30 Jul 2025 16:47:13 -0500
Message-ID: <20250730214718.10679-12-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
References: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|DS0PR12MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: e99c3ec3-2a26-46fc-c585-08ddcfb310af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ue0eeZGbNhRoFpJKBJcqMLzuqYXTiGkUWdgNAdPPaDDJTYs7aRul1BA7T/Ia?=
 =?us-ascii?Q?BaWGM2e2/Rbfh5KlEka453PQ5uieSdY4xiGZXSHVzLj6ikMDOF9EMCDzroWc?=
 =?us-ascii?Q?wnZVLqNNkp3nW+d4oT6rP2r8dAY2GGCPE2lxjnrR5kbPrw9xh9/wER3K+q0Y?=
 =?us-ascii?Q?HIBUmGLsHqbRq+NHqjZN65IVQriS1SQ4htZHE4XDynffnJWAjCTOWmc+/FFw?=
 =?us-ascii?Q?4k1Ezd+SxYcsTigfiUflQcU9+Kep19gfeNaRK6wNzr1pZIlWY+9ioAJnAwpr?=
 =?us-ascii?Q?AqjjQlPREpVa3B0MP7G++l3+4BoC5+3GAKvgVSaGVkJoujRAaRvXjFUL53Ys?=
 =?us-ascii?Q?MsXqNGipTVRvQZdGVlxjgnandNNR5GptTpxlodh2yOdWtozzY4gKzvthwcUm?=
 =?us-ascii?Q?j5Vib4Khc4JjbRWZMOxJ+o6ue6xnqy3iG8184poRS9GohaHp/7JyBmuFZ6fE?=
 =?us-ascii?Q?a/WtaB1gvazECfcPuLcE7YmUZeRr+83THBxkSRRWuWpbEuZr1E6Un00VC6ej?=
 =?us-ascii?Q?uVVTJBqTn2/yggi3YS65GtpxUFCzapMpJ4GIlUWTYa/XTrN5ZC05ZwDhaNmA?=
 =?us-ascii?Q?OCgnI7FRwwrYarMWhha6imS3vgUc8m8QSDEemuEsSi20F0b2mGANw3BHBRRQ?=
 =?us-ascii?Q?vu3HSj6bUj4ZIZH1WS/sIU1/ikLn5uBdQWXo5gXbVAe3Jwt+RVQlpq59H7S/?=
 =?us-ascii?Q?iR8w3NqmwAyD2fDXJg9IkCMrVBEJxgH/woUq/zICx4Qhcli+OjIzNimT7Y5l?=
 =?us-ascii?Q?u5OsfcI9w3hHXuM2U1DRiKe7apahanffIxHCl9U0/9WR+4MHz/1oe0kxo5sX?=
 =?us-ascii?Q?qXQuLapF6sFioUlDlat7q8c8GwgPG+kU+yHU7gXnATRVdY3c7mGFyEP1pzl5?=
 =?us-ascii?Q?AX3HE9kdbPh6Yxlg2CJKW4r2EBFP7HZYIctHadQ5l4LxMBzVXCHQrz3MbMfu?=
 =?us-ascii?Q?YrhLMyxWNAoDhGQR6JURdu1/ggBBzaytIT/BoVTKlhbjb7G1tjX69GgPx+iQ?=
 =?us-ascii?Q?dJT3DmjHtLkLryXHDvuAWDx0cikgVbatULgbllLrptlovdQnK+HtAHuq/ifJ?=
 =?us-ascii?Q?LYP621o2LdDcCkH4rNmf4wdNPZ1ZnLJ+mLNvqi7S+sBybHIm8NbW5ktTNbQL?=
 =?us-ascii?Q?BNJRlNBcELnrybI4gVfsjo9/fPhwcV371qVBL6AvHWqaDqZnfHYHWnB4QbTe?=
 =?us-ascii?Q?4oUTjq3JrmKoigffap8zT7BeANP4FlCcjnmjRQYKGn7cH90zdp+yPrRCwiPU?=
 =?us-ascii?Q?vzsQbVafHFZ7LYnkaK0wCtcW+GwpX2LMHmLiQbQZWt5fjuv6rtS/WwDMqguC?=
 =?us-ascii?Q?9yvHkbjGecswAJq+azYRMx5bztHMYWigGAoEH7llyZIo7re1IXHR56WX9r6H?=
 =?us-ascii?Q?9Si/p88xy8UFZAP5TsHfYOOdSwXVWQu4Le7oqMWqgYTdXjX2rF+HYmP79cbf?=
 =?us-ascii?Q?vV0jhqyBIJME33sig/AqnpPQ70wfJGaswE5qvotQVddt/Xfny1+hIkBTsqMq?=
 =?us-ascii?Q?NArtk7H1cZoWZgzjydSemrVItGvllhIGf/XH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 21:50:14.2101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e99c3ec3-2a26-46fc-c585-08ddcfb310af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7701

Add an error isolation handler for type 3 CXL devices. The current
behavior is to log any AER information and then panic.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 2a56936ac4f2..b0f2400c6ac9 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -900,6 +900,13 @@ static struct attribute_group cxl_rcd_group = {
 };
 __ATTRIBUTE_GROUPS(cxl_rcd);
 
+static enum cxl_err_results
+cxl_pci_isolation_handler(struct cxl_dev_state *cxlds, bool lnk_down)
+{
+	cxl_error_detected(cxlds->dev);
+	return CXL_ERR_PANIC;
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
@@ -1006,6 +1013,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		dev_dbg(&pdev->dev, "No CXL Features discovered\n");
 
+	cxlds->isolation_handler = cxl_pci_isolation_handler;
+
 	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
-- 
2.34.1


