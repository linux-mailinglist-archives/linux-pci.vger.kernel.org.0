Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0657036BD51
	for <lists+linux-pci@lfdr.de>; Tue, 27 Apr 2021 04:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhD0C3K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Apr 2021 22:29:10 -0400
Received: from mail-bn8nam12on2063.outbound.protection.outlook.com ([40.107.237.63]:62049
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231958AbhD0C3H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Apr 2021 22:29:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maGEdpFFUMvACFn7QHtq1NqSyPueOtWClc+PmZ/TtbnvL+q7/ONY4gdiSZ0pUklgZRvhbCGhXaJFLNoB6boXdH+5mOLwHkQTfcVG4YGmxUPh0GFMRDNXoD6KidFTi1CoZCXB3KNZcwX+wcXmALRMaYxmzU+3XkPt73rPGfsINovKxduICcD+HAojx/5K4MwKZJAHvaZk9hAofGvx1QAJn/ig1a4/TclmivaF7C9N6Ua29JouF2NLeRsFjn58pZkQ3XtJfSN1hqZZHU8rlFwwRUk9Q01EG/BwB9rN/zBj+p0+4hZOI09+S/URPtJtgThsK2p3FftL3yZNkDbJE8qqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNm2ODLdbWIlzfCihzUgQ7QJjbWZbrti0ZEUhppWpFQ=;
 b=jCbGhq9zl78GfMRvN1J4rUTIOhX6Zr1gC0zBgC82b6CHy2CQ+EBIljdwlku05q1dDZoOIE22M/KTdrsX/SWRDIO3GUw1r/xTdduCtQe/DUVkixy9M9A1U2wmsMOengyjsmOuSYybrVcY11K1mv2F5t4Epyc22eh/oz7lAOCuXwAAdydr5GKFpZ11kd4/SCBRZdGxADvl0aJpTB3zRM1wiNV0x7HoUZvLzMbCOW8VBzRmSiKX0Y31pVtSqn3+mDON5L3d3pjJNpPg7tQZxn9qejHKqov+LZ8I28oCe7pLYaByiDbSqjzpVG+07nwxRJ8lUHA0RvLQz35WZLUF8e7iAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNm2ODLdbWIlzfCihzUgQ7QJjbWZbrti0ZEUhppWpFQ=;
 b=l6rvlVVxNqHx4cIlDTOl57Je/sNWFaWewajemzHPY02GGXcOpq6D5pNhX4aFeY6qNqErdOio5UOtGCevcuVw0MrA6thkuFR0pMYfl4Dk7FxUAkbtvCeC6Y/7b688N0Z6K0Ewa8FlTCQRF32tz1p4BRrXBUgpbbRplAfe+8RvRYwpgZCubN2VhhP9IvVc1OhjRLs97uERfE8eT45vH/P9HVpEfT5GFgqHZ2sO4Ezec7c1LKSYBVeN6vTt3I5ZpC39cDaOimrJPVGhrHclHSFCto/EJEgLk1/+qmGnnpcEj+KdoA1qYPr28JDdLS5XDVUK3V7nNbuMvx5nxpaffixXJA==
Received: from MW4PR04CA0132.namprd04.prod.outlook.com (2603:10b6:303:84::17)
 by SN1PR12MB2381.namprd12.prod.outlook.com (2603:10b6:802:2f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Tue, 27 Apr
 2021 02:28:23 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::7c) by MW4PR04CA0132.outlook.office365.com
 (2603:10b6:303:84::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Tue, 27 Apr 2021 02:28:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 02:28:23 +0000
Received: from SDONTHINENI-DESKTOP.nvidia.com (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 27 Apr 2021 02:28:21 +0000
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: [PATCH v2 2/2] PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs
Date:   Mon, 26 Apr 2021 21:28:02 -0500
Message-ID: <20210427022802.21458-2-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427022802.21458-1-sdonthineni@nvidia.com>
References: <20210427022802.21458-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 240aada0-ead6-48b5-7f4a-08d909242169
X-MS-TrafficTypeDiagnostic: SN1PR12MB2381:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2381D3BD9F1E083782512E3FC7419@SN1PR12MB2381.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D03KJY9DW+FWJOmaz9JPwn+S3weWBj88R6uPLcENXEFCrFDMEVttZ0cMZnW5TBYnhf20H6S9X4BS8Go27lS6bPUgwFPI2U1XJST1b+5GozwD5FqbOLaCe8RU+DI68hEsoG6TlSF2x/tqk91AMwZjO7Zo6FV361N5l+aiU43wOr27y5GD15TZsgK18a5CTQk1s7HiLdoUHTKpT3YmroNgltMMyVkQ1kmAx/DVB2xTw0NHqHBezggfASa9hnfdziyEVYRE95qdkVl/7FxosEJTX+M7FIQS++oxfswFCUFCikzS9HQoipGPfPe7BknF39JvFeXR3+PzSLJZa1/A+S6b/5i/YuqScpihfMYUUu+zAiQXw18nDSKBtJEoroB8MANDQKLNF71V6jEbYhpAddMmClwtLXy4gVyPJqtcDu5Uwl4TdaCyL08pY8XK1jmFJmrr79d/aG7s8DjCDcge406ll4x7SkoJIeJ1p3mNazvRk3QkMREBjntB6gb/L0GHoRk1q9WVGB+Zos/rlC1+tt6yO5Yqi5ujTzi+vHH5HStTJpaf19hmm5KVzZW1SkL7KLu9Sox9JetogKay0YwqjorjF4pJpWccdljUvFKTLV1siImKjP4QE3/bOBqBnFD17fg6yyrlIojDGMyK/oBwEsrAHVEicUZMT+B7D23bnG88EiM=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(46966006)(36840700001)(70206006)(336012)(47076005)(70586007)(86362001)(1076003)(82310400003)(2906002)(82740400003)(7636003)(26005)(8936002)(8676002)(426003)(316002)(356005)(36860700001)(2616005)(186003)(36756003)(16526019)(7696005)(6916009)(54906003)(4326008)(107886003)(36906005)(5660300002)(478600001)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 02:28:23.2601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 240aada0-ead6-48b5-7f4a-08d909242169
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2381
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On select platforms, some Nvidia GPU devices do not work with SBR.
Triggering SBR would leave the device inoperable for the current
system boot. It requires a system hard-reboot to get the GPU device
back to normal operating condition post-SBR. For the affected
devices, enable NO_BUS_RESET quirk to fix the issue.

This issue will be fixed in the next generation of hardware.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
Changes since v1:
 - Split patch into 2, code for handling _RST and SBR specific quirk
 - The RST based reset is called as a first-class mechanism in the reset code path

 drivers/pci/quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 653660e3ba9e..1da80e772ee1 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3913,6 +3913,18 @@ static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
 	return 0;
 }
 
+/*
+ * Some Nvidia GPU devices do not work with bus reset, SBR needs to be
+ * prevented for those affected devices.
+ */
+static void quirk_nvidia_no_bus_reset(struct pci_dev *dev)
+{
+	if ((dev->device & 0xffc0) == 0x2340)
+		dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
+			 quirk_nvidia_no_bus_reset);
+
 static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
 		 reset_intel_82599_sfp_virtfn },
-- 
2.17.1

