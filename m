Return-Path: <linux-pci+bounces-2908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C603845127
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 07:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB2828986E
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 06:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B91210E2;
	Thu,  1 Feb 2024 06:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x0AtvvbD"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55698289A;
	Thu,  1 Feb 2024 06:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706767501; cv=fail; b=Eqrn6ffsaJNkgpEV01WeNUwaSk44wSjyc92OLdN90ohV7esG9Ag/4DOpQIF94WJYy4BUekTjk0kaw5DFL81s9Oc6f6BoBI45W9fVH70vcnNJHlkshoXA6zSYYjy8DBgf9IDeE1MoCpHIHj2LdP96nBnH9CGpcmjWjdHIjbXNefQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706767501; c=relaxed/simple;
	bh=p2bWBbMVFIYAiUe+6fWVTdb7WhL+L/5LsnMp+4QVQfU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XyP9oTrPY10votX2uXHGDDznKSdYbi3zLSV/9RYiPl7CLTWKkn7JCVHB5/XThd6xJGH0JjT2nr2/YQRuLkHZCt8WKCcYViA0zYW5KZWaX0yLTtUhElfzlIUom8BIO2des1Dsc6LYY2TJPffHjpJwsE3glYdK0kuJ8861246Aabs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x0AtvvbD; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGGr4a1z5SJxqS82Q//JkwebLW1en5QrMpV4pb1Yn7dpdkybvrLHdo6zD5ohpG67aFkuwbcR+9u/1ojuI7NlNOWkiCv4ellydOl4MmuWyR+Cf5lQ18R2pUvFeo0rZ+tWUAVBUht9CnLdBLPhWqXeuqG9KOCIkWVHLuROCRmPDXEjxOQS/Pjv+T+xcEkQRrvagNRfgpF+gxm5TcO6M/6HBEv2K5pKWtRKsV4TaoiyzG+7r7OpMUFAvGBHUhD0SyVHceilahekLs1s8HCYrJXGSW044Z6nAl+vKCkcANJkcosN/+CQGFOToa3hM+7Zd1xKqpBbcA9ekHlpJ5m1Pjam7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2K8ONyPP5Te86GWfhOv3DIxGkbz0UFAcIMLHqsGOtc=;
 b=WGnENddxtFWJc6NAATYQnTrsTEaNVUQyp5UoNV/ZttFAHJap+FVG+KV8DcbCmrKz1U7j2H+0Ij2Bwc6YvstU3OhCuf4zmp6nfu5n1Rkkdl759x27yB0aMSWitDpxVW/2aPcX9FbJDk168aXc8Y6DKyZO2OwYq09atiyqStuSNC99ReDwroNd4z0jeP3WXcYqbLs3Cu1JC4FxIQLqIaCB5TkPrN8shdOmQ6BKgNF5fWSaJ3Q/GhFG5qJTBxEYmLSB6TkxtL0c+cvNlaIbST+TLcsvOWnUyFyyMZj6sOq3XEfP69e1YYP9bFMUQcweqZN7PfFLL/sRNsj+2lKQid+tug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2K8ONyPP5Te86GWfhOv3DIxGkbz0UFAcIMLHqsGOtc=;
 b=x0AtvvbD1w5DR57uRMh7J1tJpPRKE49AhPaFEJ9Xw+uTK/YIJThOlPBuC9sbiqdmJGd41FfsiIK3drxomD5TpkMaETyJk4/e5yQc4VgBK9BlcNGsPHYyqqiIAO4Hmw37dWUGtZNoqKha8JQJiHFrqgJU2TtoMrPjypikUkHenIo=
Received: from CY8PR19CA0027.namprd19.prod.outlook.com (2603:10b6:930:6::12)
 by IA0PR12MB8714.namprd12.prod.outlook.com (2603:10b6:208:488::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Thu, 1 Feb
 2024 06:04:57 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:6:cafe::21) by CY8PR19CA0027.outlook.office365.com
 (2603:10b6:930:6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Thu, 1 Feb 2024 06:04:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Thu, 1 Feb 2024 06:04:57 +0000
Received: from aiemdee.2.ozlabs.ru (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 1 Feb
 2024 00:04:49 -0600
From: Alexey Kardashevskiy <aik@amd.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Lukas Wunner
	<lukas@wunner.de>, Alexey Kardashevskiy <aik@amd.com>
Subject: [PATCH kernel 3/4] pci: Define TEE-IO bit in PCIe device capabilities
Date: Thu, 1 Feb 2024 17:02:27 +1100
Message-ID: <20240201060228.3070928-4-aik@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240201060228.3070928-1-aik@amd.com>
References: <20240201060228.3070928-1-aik@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|IA0PR12MB8714:EE_
X-MS-Office365-Filtering-Correlation-Id: b0cdca7e-bac5-411a-c2d8-08dc22ebb78b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BuZ5C+uJR2mXpEnMAlYQx0L1Y2k42N076BYiMfY9I6Q9IuGdEVFh3cAMYFRO0UxPiakD9avxeShOmWA1GUIpLS4SroNBgHKePiMLeTZD93tv9D82l0ZTG/sioMdY8O6KuzmOuD2D2GQMfn7VheT9YNjXkVUFCHNuuarzYvUfE0q+97z+Xt9Xk7Y2LKxj2xzpksva93FLA+vj8RdqQi/ZS3gYy+7ZRHs7DoBCVDKbjSS0BFDleGNs7uoNbeALy+mYNBnGD6GY6wHb+BZc9FOO6+omaiAiqmL2/tGps1D6THj2k9wvY4C6vB0kHIcjQDDk0nZOOAFEU6+oixYnncDGVsNspMRYQJfowHU8hxuViR0lcZojG1pbHFQXnyVAvs9BrLyovniWkeneTzmOI126OztNLmU0dycValznT7ZSbQAjyfhT3wQKa4zZIag12wdM/jeDuK6c24cOfTrIHWY0RMg52Ckic7f60ytFjiqWjvjOBneiLE+7zeQ9pQynkz1W1jkLVDqIr57gz48dTedA2DvkbyJqkOYJWpo4v7O21XcEYU4pDpNNcHUI6t3Qhj+utawHIjuy5fi7FFoYLS5LEfTMj/bhl37xxMyagXbFb9urwp+j0jBLPy0wGgmB30/6P7DAfhNxeuD2eVwiKcSdpwyLGC5kI8gbTOBexDhOmii3II5alFio0ys2i/YUF9Rr91Zi2i20Eewseft2Zz1bW2mAZyua37wUKRuxhSk0zT6SSxD9DWZmABXCYUnNZwaeaPJ5R+GEIrFvKgTZs/gv2w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(82310400011)(40470700004)(46966006)(36840700001)(6916009)(54906003)(4326008)(70586007)(47076005)(70206006)(478600001)(8936002)(8676002)(6666004)(316002)(2616005)(336012)(1076003)(2906002)(4744005)(426003)(83380400001)(82740400003)(5660300002)(26005)(36860700001)(16526019)(81166007)(356005)(40460700003)(36756003)(40480700001)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 06:04:57.0722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0cdca7e-bac5-411a-c2d8-08dc22ebb78b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8714

A new bit #30 from the PCI Express Device Capabilities Register is defined
in PCIe 6.1 as "TEE Device Interface Security Protocol (TDISP)".

Define the macro.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 include/uapi/linux/pci_regs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index b9c681f14181..e60b4df1f7d9 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -498,6 +498,7 @@
 #define  PCI_EXP_DEVCAP_PWR_VAL	0x03fc0000 /* Slot Power Limit Value */
 #define  PCI_EXP_DEVCAP_PWR_SCL	0x0c000000 /* Slot Power Limit Scale */
 #define  PCI_EXP_DEVCAP_FLR     0x10000000 /* Function Level Reset */
+#define  PCI_EXP_DEVCAP_TEE_IO  0x40000000 /* TEE-IO Supported (TDISP) */
 #define PCI_EXP_DEVCTL		0x08	/* Device Control */
 #define  PCI_EXP_DEVCTL_CERE	0x0001	/* Correctable Error Reporting En. */
 #define  PCI_EXP_DEVCTL_NFERE	0x0002	/* Non-Fatal Error Reporting Enable */
-- 
2.41.0


