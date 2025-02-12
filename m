Return-Path: <linux-pci+bounces-21273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCE0A31E3E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 06:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C42188BD7F
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 05:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619DD1FBC87;
	Wed, 12 Feb 2025 05:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gPHY1KJH"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29F31FAC3E;
	Wed, 12 Feb 2025 05:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339475; cv=fail; b=C2rWbrwRCeuY2R7tVQThUS/+/pnbF394MPocf+rh4Br33UspREOUUdewz0E9X3V4fX/8FM+LIO2y9vnj/jlZGFcaxSNtcpaWD+zPhBs5TzemsZgfh6oIIxqHLnUcDFMv+oNoekGX3j6NYjwKzSIExC99fzDwgd/lIUtRM13Jl+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339475; c=relaxed/simple;
	bh=oaE4abzPYJS7CfyIhYzmFOBIMw8MbVmv2zfn+DNHzM0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRhVRCqecPBpqvMHaZoAbr9Y/nQZEhAS4NsRbgi/lt2yGMzaQEtOt6JTznLY8g/C5NX0KFxBR44WyeTWgzMvP5i3Oes+UstVPeGbIfHWQUAt1IhW+ySdpZSGuavq33EKWfB6rpMXpjqy8kielf0bWqoyTXiI4GG1uYSSw8MAkIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gPHY1KJH; arc=fail smtp.client-ip=40.107.96.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qX6RsaG41HgoGlC8m6CvyBWAFFJZDhZhcXTAunQh5DjGHsiaqJTJiysV5yU1auk6O5hmn1Aq4dS5CVW5M0G5uXhKWN4kAtf/4C9IFsj+dpKhAe2l0hNC/5G4J5MBzOYrgiXAosaJSZ0FzQuIGJAodI+vmA14Yz21Kjyk67jZMprGuLWPIcEWTku+HcPofsf1Fe8VmPEj23RMfHbvd9mgZhtbLDeiicfy49t9/TW3qylpg5xRUbWcx7EgBBgXiXJEeh2UrAmnCB8ywGBFRdNEc8Yjcu6ygY9TN88FLzheDe+/WTmXn7AbmXfu6GD2BkQ5nJ2Q2e5SNjITknD0MLLNew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5mopQno1JiNDsd6JokWjXRTZsaMF2FCq/DMWLGQeJY=;
 b=T/Y0JXolg8faj5Xv3WWBhLL8aRY/xalFNs+y1S89wl9R6WD74X3tPlVhu/LgOD7QbITO5lzlGrQF4cecIteaXa0kjT0aQH+egfgX7rEqtDS/9Vfck3X0c3Elo4QgA5CJf0RRDHzTF52MuftrGRvp4skcyjEt0YrcvkqFb5n+4+TChl1t0V/qQuKuinEWZge+kTUCu7HG5LzxfMQVEeho7FfhFEsFzcN0i42L89ETiL1Z4JdOAStdVwCLROzZrNpY7BNXMQ0ed9+N8P5OoDc8IBXBqhjiQ4cBmnlxTj0UK6TifvgMcOQ23H9mEl788xVtAAygNFSYbJps1iKQVnyTYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5mopQno1JiNDsd6JokWjXRTZsaMF2FCq/DMWLGQeJY=;
 b=gPHY1KJHQqRYHi83zWTh4kNcbCUYnLG8ewpUiZFYdR+3OWiPaOy15v2bE7MQNQmPb+dCKXyporHEs2TASCkZ4crJR+zYmGK9MM/bwcR8yU0KTRWjbrBkYHkIKUzAcSRD0Li8XGwY1uXwko/pS9W8QtWq1xVcB1Nwvmy2CWQTNwU=
Received: from CH2PR07CA0051.namprd07.prod.outlook.com (2603:10b6:610:5b::25)
 by LV8PR12MB9134.namprd12.prod.outlook.com (2603:10b6:408:180::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 05:51:10 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::24) by CH2PR07CA0051.outlook.office365.com
 (2603:10b6:610:5b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Wed,
 12 Feb 2025 05:51:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 05:51:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 23:51:10 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 23:51:09 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 11 Feb 2025 23:51:06 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: PCI: xilinx-cpm: Add compatible string for CPM5NC Versal Net host
Date: Wed, 12 Feb 2025 11:20:58 +0530
Message-ID: <20250212055059.346452-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212055059.346452-1-thippeswamy.havalige@amd.com>
References: <20250212055059.346452-1-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: thippeswamy.havalige@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|LV8PR12MB9134:EE_
X-MS-Office365-Filtering-Correlation-Id: f67f10c1-200d-468d-9f25-08dd4b2940ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aHmhK3VoWYOkQUZOvbmCfIXLcfaBeXQjsHgV/SuoJNWikmjvRcYYGRi81wu1?=
 =?us-ascii?Q?RT7Auxr02GYycSwG55xKQfPI+Gabm0aACEsEWR/vn+Bh/7K8BjY9jqGjBqR/?=
 =?us-ascii?Q?nHAk7OgTxyvsSXZaCF8/MoDB4FRrj3pt8HuhHjwnLPbn1jD/9PPbBFWAWn+C?=
 =?us-ascii?Q?F/xfhbOwgu1a3zrDTAxzM2CtZENpsTtRVjBOpKbGWox0/326hCG5oP713dtf?=
 =?us-ascii?Q?qhvuYoEBKVpB+tj0WsGGg/a/5PZsNCqJ7vMs5mpA+H7snKSTHmo4TMN1HBlh?=
 =?us-ascii?Q?EKmrT9QaZU+jsNj0rIpJgudx1Z5asrHtUnlWvTLEgmnEi1pO/O3McG9QEOyn?=
 =?us-ascii?Q?1KMgokSYhmFMneVjnx90LmT4uZJl0XK9ZkQqqA61APiASAkgwFfE/5Mv1ms6?=
 =?us-ascii?Q?QkkiPMUo303c0qpO5P87nmRncQHqdc+Cym2cc2pWhujiYx4xAz5oQrPF2Bse?=
 =?us-ascii?Q?77zeNDPgZO1Z6ZmrbyZQdbrqcgiMxrgXLK0HkXNZvAhMV8jUiqUpsnlPhr18?=
 =?us-ascii?Q?V4sIH93gYVcPuvunZZLG84kKz7qF16Ovw+mRE2YEBkc97lOmpxnvJqnxJCJM?=
 =?us-ascii?Q?moKWgc0k5K9+tA/RsF/9PDjyZGTmK4TvObc5qnkAp5CFFogORuVqXJX31dGu?=
 =?us-ascii?Q?XzB9g49n2PQ7Lm3aWdd2Voo3S428enjyWF8W2eD75x/NqfBhKndk6lBLb9Zh?=
 =?us-ascii?Q?Q+5/1jMhnsjhgXJAXCr8JNacCV4ODJp1NQs9VcbL/0YaQl+jt5tIoDAwyq0/?=
 =?us-ascii?Q?ghgdY47PffEOEV1v7STInrUZXi6aLRQZlVQjm9Y1Qa+HyxmyUoWn7RuUs5zn?=
 =?us-ascii?Q?gJzd5Z75EZu+0P6SLXXwXZHA74LMOTnsjVHSerJwNu8cf68nOmn4XBEikoWC?=
 =?us-ascii?Q?RR4KYIzJc5r2eKyH9+TEP99Ps71pLe2iIGR8+Ifb9HM+ZyB9J/qXw5qmsoxk?=
 =?us-ascii?Q?oF7IIyIP1ct3nyxxM5d3W5SJId8nsO2zhyD2s4sYYkYlSJcEv/O6sS5IMhw4?=
 =?us-ascii?Q?H+3vHZCbym4yQqWXBCT9BnwVBVd2HghgkEBSwiV+wCUI3vUi/yiOfnd7HOY9?=
 =?us-ascii?Q?BPQTYo8yIMCIJo08TX0bxOnYFLoo6ZfKV+9w1tevcws0vI+EezPJGTZRa0Xz?=
 =?us-ascii?Q?vt5WOqq154uQKmRFu6a+HkDwKreF+Fs3VH/8/BaazF1aPLSf0gX5pBIt8M91?=
 =?us-ascii?Q?H0+S3umGzm0Jp6P7F2Y1QZ0GwfdEZI/jboYOFZA3YBmzVJEVzhQmB+xq07cj?=
 =?us-ascii?Q?eVapynCHvCI3Ftdv5b4kqrw8Vz5LO3v3zZQg/fMPUHPNKEWKIIP4+XAxBZb7?=
 =?us-ascii?Q?EVRRoVYaCQUy0FIkCDTRx09Y2vVJ25D73kg1kbETisJaoalNkN4wgT1r1koc?=
 =?us-ascii?Q?R06Fa5WfimqWnlKCLd/3l9JuFeuDecmetSK0g9xMaHxOTg3IppEJjCAQv8Yx?=
 =?us-ascii?Q?pA8aNwWmjUBh13Fv/zEB+vs5RxSFCQ5qsKprdST/an5DZzLnnzR5hTTu5pEz?=
 =?us-ascii?Q?W5/gWA6SM6f6l0g=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 05:51:10.7411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f67f10c1-200d-468d-9f25-08dd4b2940ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9134

The Xilinx Versal Net series has Coherency and PCIe Gen5 Module
Next-Generation compact (CPM5NC) block which supports Root Port
controller functionality at Gen5 speed.

Error interrupts are handled CPM5NC specific interrupt line and
INTx interrupt is not support.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v2:
- Update commit message to INTx
---
 Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
index b63a759ec2d7..d674a24c8ccc 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
+++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
@@ -18,6 +18,7 @@ properties:
       - xlnx,versal-cpm-host-1.00
       - xlnx,versal-cpm5-host
       - xlnx,versal-cpm5-host1
+      - xlnx,versal-cpm5nc-host
 
   reg:
     items:
-- 
2.43.0


