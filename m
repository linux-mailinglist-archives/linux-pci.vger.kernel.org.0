Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF82370413
	for <lists+linux-pci@lfdr.de>; Sat,  1 May 2021 01:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhD3X1j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 19:27:39 -0400
Received: from mail-bn8nam12on2083.outbound.protection.outlook.com ([40.107.237.83]:64480
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232757AbhD3X1j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Apr 2021 19:27:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0ONcqc9pzwn/ObKIAjN5LrVIom32Pn97q8y1LciXmrA2q54wmUM3ps6bd30+GdymaYhs1VxUutpD0mWdqFBiQjI7XeJarq7qHTuMA1nESnX4Ahn4HrVAP0FQOxEpbpg4GHIT0aHswJZizCb9xgM1mTbRgtBLiQynQKr29cBsBnV2buBghpQKF2uN/dX29U8r0KBZpMhiT4GpiTwiY21RejACBIPzDw6+7bORy1iOy25fyygQQZ+zSG/7tHKtZhUJKsYr4nuFDXeUIsv51obg7N65VxoZIKqTxYExwc7MDcKfO6P/lGAxD/xMZXueOWzQmhriM5ajHe5DEkwfyeAUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fh8GIOHiTLQe1OrexaBObUgLK7XCYWqn4hGsanqtKgk=;
 b=cRQuzBNnP1kgDLUg7P9mz41H334yMoNw+1NdT9qE+nAJC2SIWud/L1F9X9JQR6KEvOuKctrryWLLSms5TQHTN5MW8BTnbRsmN6e1hiHtLNgj31Und3ExkRQvrlrsA85iNTCqqJLLNK7yxRocQr4GcokQY7ois71OH5EQwvaqmxqB7gvV/0kRwP5e6JKr0X/dhrDw+TQeaaLGS++mVFMpy7zJetqwynw/gzJl6P/3jIHGMop5FFzjfMi5ZQB6mmEHhKHgBkA5ZBhZbwcsGUMfJTq/fIKC6cRR99RCk5dAlrb2JTTRgeLsuYeTvmOhWlruSghq/PLZfAFN5BMKcicJIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fh8GIOHiTLQe1OrexaBObUgLK7XCYWqn4hGsanqtKgk=;
 b=s5UMBr5QhGp73QlB6X1VIxQ9aACEriwakC93/Viry1PbMYJ2fDDrIlldOFoLhc6El2FyAsikHxcAR27g2mzAXTDyA7DZuceDbQcPWwvKVgiv+5qfuvD7AvlyqiqA4cc+c88pqdOrW2ZwhXE26DOu4dI9N4Gwv1z3CaVjJRd82KrOV4/UgRjSQPXBdpNexeeKuL/fPwgbboXjBVzx9BHvJ1GlKmjAfzAXTv0LHzwwARfh+LOWxigNDua7EtjoNJPLxhdF/GLnIx1MrWx5l6MgcGowT6aqdCgjZCowMiqgZNEEqyB03GpBOB6K4z/eM76fM3muQc/0HzMEdFm9GQBWrg==
Received: from BN9PR03CA0659.namprd03.prod.outlook.com (2603:10b6:408:13b::34)
 by SA0PR12MB4525.namprd12.prod.outlook.com (2603:10b6:806:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Fri, 30 Apr
 2021 23:26:49 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::8e) by BN9PR03CA0659.outlook.office365.com
 (2603:10b6:408:13b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Fri, 30 Apr 2021 23:26:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Fri, 30 Apr 2021 23:26:48 +0000
Received: from SDONTHINENI-DESKTOP.nvidia.com (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 30 Apr 2021 23:26:46 +0000
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        "Shanker Donthineni" <sdonthineni@nvidia.com>
Subject: [PATCH v5 2/2] PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs
Date:   Fri, 30 Apr 2021 18:26:24 -0500
Message-ID: <20210430232624.25153-2-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210430232624.25153-1-sdonthineni@nvidia.com>
References: <20210430232624.25153-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 590d81fc-5e8a-49b5-b8c7-08d90c2f6d8b
X-MS-TrafficTypeDiagnostic: SA0PR12MB4525:
X-Microsoft-Antispam-PRVS: <SA0PR12MB45253906E729151E2113716AC75E9@SA0PR12MB4525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RjaNTImz3YlSNOGWD8PAu5rXLpIyCUanozWzFAkpfejqjan00KcYz2CkceT2FypY3KsFijtFmHGi3MLaVfoMs4sUW9RPZdylPbfxk8e7oFLaxaaVDI60F7A1zJMP3yJdTWbiRfaY3Xx07EfM0wXvIcpssF8hu4Hn2YzRe2JZtDkejSlbnmEVrbZMlYDh1cQNTDYaQe/kt/b8sRSHT/UQyivPagS5rPfXEOpN0n2RcGmTcb5MvStY6/1b3AoALw/yLvVwmfm1CCJgaUIvWO3K4yCWiqEUsSjh4zZa1uARVpUNycM5U5PicrJC2pIMYt2VGWNj52ys8itiBdPmPCbvvGnRJT2vtz3kSmQpwCDAkcCGP8/7AtYQQcloOxb5tG1jq/E2OyiLvRRC08gCSX7oWuK9u9YOfAg9KsxizkOd2xHSIYzpjj1k3TijQSqH36qQf05Ug0VH88IHOwCpvNK/StKG4VMkakCigoNMd0DaGzmcRy9hu3bK/cCIjjrbV4NWJ3/DxMvpyxok/3GdlMb1x7aS7OGJGYvp5wkTDQiesYbCInyN0o/6ghkDx7+aOCuHKfUNSG+IlB3iSUQu3xn/B2a3/PGQVSLmHwZcs4WryRVHXWL3dmRcYtSw+AE4ZMSsdrorRAKFohR1ZHK58xAHEA==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(46966006)(36840700001)(107886003)(70586007)(47076005)(4326008)(2906002)(86362001)(8676002)(6916009)(5660300002)(356005)(36860700001)(7636003)(8936002)(26005)(1076003)(186003)(16526019)(70206006)(316002)(6666004)(426003)(36756003)(7696005)(82310400003)(54906003)(36906005)(82740400003)(336012)(478600001)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 23:26:48.8806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 590d81fc-5e8a-49b5-b8c7-08d90c2f6d8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4525
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
Changes since v4:
 - Move reset quirk next to the existing no_bus reset quirks
Changes since v1:
 - Split patch into 2, code for handling _RST and SBR specific quirk
 - The RST based reset is called as a first-class mechanism in the reset code path

 drivers/pci/quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8f47d139c381..ceec67342365 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3558,6 +3558,18 @@ static void quirk_no_bus_reset(struct pci_dev *dev)
 	dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET;
 }
 
+/*
+ * Some Nvidia GPU devices do not work with bus reset, SBR needs to be
+ * prevented for those affected devices.
+ */
+static void quirk_nvidia_no_bus_reset(struct pci_dev *dev)
+{
+	if ((dev->device & 0xffc0) == 0x2340)
+		quirk_no_bus_reset(dev);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
+			 quirk_nvidia_no_bus_reset);
+
 /*
  * Some Atheros AR9xxx and QCA988x chips do not behave after a bus reset.
  * The device will throw a Link Down error on AER-capable systems and
-- 
2.17.1

