Return-Path: <linux-pci+bounces-2909-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D3584512F
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 07:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C79561F274EA
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 06:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E50585C43;
	Thu,  1 Feb 2024 06:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fJyzEQ+z"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F373284A20;
	Thu,  1 Feb 2024 06:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706767549; cv=fail; b=aBHG/6yKb3BJ+nHGqbRY00rzZXLFNM7a5AYfkYD/8go3Y3a3cLEjL++D4HTECqruwRvjVcRG2XmJsjCMk4BSvq6RFl356JxhdpgLJYqciHZneM7FQLGYLcv9gTD1XHFlAd6nq1N32QY6P44kW4xSnXWDJaZPh6gJKahfYlR+C28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706767549; c=relaxed/simple;
	bh=LSTk8r2e/XD+STS/2m0i9L7NmSdMUs49sJmwEm9bkm4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PxAmra7t1+39Jxz7UXiF5k0tR0KYcaYPxGkpGw2tGM7nRXYhjG20L3BWI7GFn+pme3Bp1DhhjkgiMd8yp7HYoYzWDZJa0HkHx039/H1LgKvuX4Xa5iKFB0E06tvvvEH6OX5rrnWgdKluS+6T0Q76kmiqu4U7EktNRtSKSbfJ0ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fJyzEQ+z; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLUzQoUSXfmGRAAzMxeOxGChQoiTEWrbKp+flk8qjm//LNtpC1SuZJexMh6iF3MKycHO4ro7tOxT2ob77dsH6TgfByIqAwH+kEVgURvMmaqUq6m4BPsiKF99ZTefhXscobd1AlnzA/pE5sgtPCFVQqKdfz+aTpaJOF91LZ50SFWzIGQwTt8g0P0WWbdUJ5pvzWePR177zba7/u/lmO480OhR98kOhml3PYqToPGlyToVo5G710XRaYgAwBlBUe0YUyjOt0pPbSZ/ljzTKK+Uyy5X/hKcs5Ce+WNcFH4fIVEICYdRcSovOLwGiPoZGgrJNdKgb1fpVC9QOR8+OgSC4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugysfKEnDE4LyGczsnvqEIN+i2LFgRlRc50394Mqc70=;
 b=HqXj/jTdGGWGXR+RFfmxPulicsK6eaWQUIeZHdlt22gPi0gYGm2+6LhXD6U20BVdbP5TESwTEoIdUvwY9HF5VaJyYhHVLsm1nxDlchB5Bo0eP8qvJvMNUOKbbg8beHCVwlObqeFf7EOh7J5Sbra/4lqyT58PQdhvK2bhw7ERE55tAsco97MVnV8n/x3PakbAOT8MnWkVgl6veiJ9Bk7n88eMMyqs75oN6PzVcK6oj2LcOCxacR7xweapTwOiiz1jCKizHuGrJK6y+gLcMrqqgi+ExuYrk0GYIiVa7Dz2KUWdzVzuNDbxM98bJHOs53uxAWdguJZAs7g8VZNPTFJtSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugysfKEnDE4LyGczsnvqEIN+i2LFgRlRc50394Mqc70=;
 b=fJyzEQ+zp2xOi0nW5WeiQv0I/3WMMxiGLRF0t51n8W7vulW9kFiQ93+b3nRE6FHyqfX3VfnvU8iMqRZ0yvJW9cPpt4YXjWqAMGezGhALGrlYg8DrhpMxLOuEFWJxrFl4QbGoNIv2uvC4H25JHgWhY3TqZIkfIDBKBjV5tjWfh0Y=
Received: from DM5PR07CA0062.namprd07.prod.outlook.com (2603:10b6:4:ad::27) by
 DM4PR12MB7600.namprd12.prod.outlook.com (2603:10b6:8:108::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.34; Thu, 1 Feb 2024 06:05:46 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:4:ad:cafe::6e) by DM5PR07CA0062.outlook.office365.com
 (2603:10b6:4:ad::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26 via Frontend
 Transport; Thu, 1 Feb 2024 06:05:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Thu, 1 Feb 2024 06:05:45 +0000
Received: from aiemdee.2.ozlabs.ru (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 1 Feb
 2024 00:05:38 -0600
From: Alexey Kardashevskiy <aik@amd.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Lukas Wunner
	<lukas@wunner.de>, Alexey Kardashevskiy <aik@amd.com>
Subject: [PATCH kernel 4/4] pci: Define Integrity and Data Encryption (IDE) extended capability
Date: Thu, 1 Feb 2024 17:02:28 +1100
Message-ID: <20240201060228.3070928-5-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|DM4PR12MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: de7c4b6e-27b0-48a2-b157-08dc22ebd49e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ABrEfMDB8U6D/NW5dKrarHDUfewD0YIDSVMdTCdVLFX0dAgKY1/HJF9rzcvJa+85h2WOhVDysTjs9gH2a/IhZvkS/TLG5SMwc2nHQmHxLqXbbLWfDTZHQAglev9uZDCUzaO9r0S9o9IdSqgkQFoFucKkoJS4xlKZJ/D9GjSoMALVxPza0LUnOpsqBC8qhpRXJBiNMnOjUzcIpPz0i3T8jm9ILYc0y2LV4EvCcNpz/0WhUI8gSBF9X00kDsx7tO3NuQmAgHeYBygkPmpotW2zT8gX8B76R2mCFJk978XH1YKCB0gJlt5dqW1vKwKoDQccOuJx+rNfKfZou+D8hDMMDia8eQdSr0EGJLbPadB1aPf39TsYAaufWhp0EQwhopeHZhzz7mUqCzZwb+ilvz1RT468VyLxOOtGlqdg35OjAvyGu4SELScMGeqdOscGJ1TGT+0NAUMGK94c8oIQn15UIwK0KckrRQlSQUqUEo7nCE4swm86Xlrg2WSRayvRCz09rnaT1m7AYPSiY97AihwryEOeS0DZk6WCjl6/OrVUbS/FKYrsYbtiJ/oNMw82H7v9mZbG0jtoM0a/TjtjhxlRB7ImMLgXde1baCeJqY52R9SaXTNJEuAWWbdpE+aTrnlLAkFgiTlbILe2p44+lFObat+w/zU0uMxGwWmpVa7bwrtQR+fJqQO7KZV6LVaQ27TVEUtPvq1PpkHQQCxjwWqCxYxlTAbJQpi73KFFLzvcTeheqdq61YyNXs9UjPDswfM6wKZhiIyglYxOIWs9So0Q8A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(426003)(478600001)(5660300002)(16526019)(70586007)(2906002)(26005)(6916009)(336012)(83380400001)(6666004)(70206006)(8676002)(54906003)(316002)(8936002)(4326008)(356005)(1076003)(2616005)(966005)(36860700001)(47076005)(81166007)(82740400003)(41300700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 06:05:45.8502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de7c4b6e-27b0-48a2-b157-08dc22ebd49e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7600

PCIe 6.0 introduces the "Integrity & Data Encryption (IDE)" feature which
adds a new capability with id=0x30.

Add the new id to the list of capabilities.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---

This only adds an id. The rest is here:
https://github.com/aik/pciutils/commit/ide

Not sure how much of that we want in the Linux.
---
 include/uapi/linux/pci_regs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index e60b4df1f7d9..b8d447b2c793 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -743,7 +743,8 @@
 #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
 #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
 #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
-#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
+#define PCI_EXT_CAP_ID_IDE	0x30	/* Integrity and Data Encryption (IDE) */
+#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_IDE
 
 #define PCI_EXT_CAP_DSN_SIZEOF	12
 #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
-- 
2.41.0


