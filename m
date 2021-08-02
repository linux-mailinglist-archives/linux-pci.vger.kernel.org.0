Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43EB93DD630
	for <lists+linux-pci@lfdr.de>; Mon,  2 Aug 2021 14:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbhHBM6w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Aug 2021 08:58:52 -0400
Received: from mail-mw2nam12on2075.outbound.protection.outlook.com ([40.107.244.75]:40129
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233702AbhHBM6w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Aug 2021 08:58:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCgO0LvxO95DbAz7Tv8jsMeBKs47yPndr4U+xqxseBF6L0aKFBluAXLqnz5T2LsW8nBKw9yi4uecWDZRb9KeR4WbRvwuow4/z0PkpnCL4f0A9f7TeJgis+vw+CXxwiOfKmzAUO0g887FqBW93OYvz+Nb/qyUC5fwkUkbDlCT1fv6m/K1numcxa+vCq2vldq9o8EDGNxmPTFWJSMNberWfPqqe7mjZL0i6+IgEJfh6II35WibDBNEmPG2G32NC9b2VAPwwzcfa3avvEW08bLxhKzzduAyWAkJuUCwr4lKqjxpQz0INnc1ppUlrj62jlDRE8wHE5ZBNqTQ6VQwas24jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVC4Ne3ZupFMW1StyoZIpu2L+Qt776R3tU4D4x5NkYQ=;
 b=QK4QkHKMwgcqxo2gFNxwStqbhr6tvDkSgux2H6dKGSXPX+VdT2nI54LXZqgC3DcS228TPmlSALEsKiEODFZN38Lac75FjZnfZEsRzchQi5U9+WnKWbNvLQ+sciVtFIbxYIIxzxcXbs0NmvTDq0Jc2NU6DW/n+ZdnM0MsCkUQR1VJ9DgNx+9PyTxnc+ujSlk+/59kmw/10xrnWmOeqItIDlW4EYe4xL0T8I78BCSmejbIdZ+svzUz+Th6svtX453L2Lza0wAMI9eNIjYXdgPlhpZ+xxIQWSkmr/iNJvqLeCUZaD88KBOhu8zHolxzIagfSkOMTzwpVZ35ZKRju44ABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVC4Ne3ZupFMW1StyoZIpu2L+Qt776R3tU4D4x5NkYQ=;
 b=lEZXSN6G+uDxOVJx5NLe81d/wdvOklAHOC83wl+weN04BVz0pWJivdy6Unv3FWyYjznoyJRkMGlJSpC9VKomZ3U9C4PaxVQl3J+zm1iQpaFJLpJvhtATB65uyKr5CzQZ96I43Ok1/AiFLdSKGVZRw/gzfpRen9IOnn6f/7u4HS4=
Received: from MWHPR15CA0033.namprd15.prod.outlook.com (2603:10b6:300:ad::19)
 by CH0PR12MB5025.namprd12.prod.outlook.com (2603:10b6:610:e0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Mon, 2 Aug
 2021 12:58:41 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::89) by MWHPR15CA0033.outlook.office365.com
 (2603:10b6:300:ad::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Mon, 2 Aug 2021 12:58:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 12:58:41 +0000
Received: from sanjuamdntb2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 2 Aug
 2021 07:58:37 -0500
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     <mika.westerberg@linux.intel.com>, <andreas.noever@gmail.com>,
        <michael.jamet@intel.com>, <bhelgaas@google.com>,
        <YehezkelShB@gmail.com>
CC:     <Basavaraj.Natikar@amd.com>, <linux-usb@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH 1/4] PCI: Add AMD USB4 host router device IDs
Date:   Mon, 2 Aug 2021 07:58:17 -0500
Message-ID: <1627909100-83338-2-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1627909100-83338-1-git-send-email-Sanju.Mehta@amd.com>
References: <1627909100-83338-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed616601-0cca-4fc9-6f89-08d955b540a6
X-MS-TrafficTypeDiagnostic: CH0PR12MB5025:
X-Microsoft-Antispam-PRVS: <CH0PR12MB50255523C241B9AB67D3D6A1E5EF9@CH0PR12MB5025.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Kx4qVDiCut6cXTBukuCcF7iy300kV8q2nWYttnCWYg5e+kDjkhIix+1x/eZSvsnelDMCQpGsp36rahPSASeArGVWVqb4mjQmqSUcFJabPoq99+nOyjkm6UT9Ug3OdTLjclpwziuWaVxQ3aT3EdnTsTMnQH+xUmz2kA+Y/xQW9H241g4xyXgzE351DR6/0QsGrxrBBoTHvdXHfTNtUePcXr7g6WsRWMZQ9+YmK7pJiJaDrU4BapY2356gyFiNCcTPbtD0gC8RojBV/qsk0hWS1ybSYuqVbBffnq0fDDqBW+8AfWF+c220gc/EK5ZmDy5oIpJXHqYx4+LNhfn1nQdaarycSHd2rFl9nBhiEktjVOL+WM7WGTUF1VmSDEVThoWVHxedytWFbjgqLNUMZpV31yj8PafYAz52p5MBmWJAcOjcn56+JO1bcC7TykgGj0X2nmaQ02vNygSAw/8iAVJVeSVxiXmXETSJlzGgl9XVIty7kRCjVoJPyPiy21Rmi2ePXMalKx5QnGHcDZZ062t1dQSl2dBfiI2AKNMuXpfyaSRysUfZHI01IRQiCw9/xFX6FjQcMjCygS0aAZ80+NZVZIv61OZKpFLtzTC3wkEFYJjxOK+BrJe8B1KlBt0mccVL06mYxwYaUi5o0QQRTWBQdm7/n4TiKfBC9/rfMyQUKyX8hxYslmPbm4PEY4agov5yLmo1rdqz4E68mbfYXUU/I2O04PGMxSy7PsT2CCXBM4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(54906003)(2616005)(110136005)(82310400003)(36860700001)(4326008)(26005)(81166007)(7696005)(70586007)(5660300002)(8936002)(66574015)(316002)(70206006)(8676002)(6666004)(86362001)(426003)(47076005)(16526019)(336012)(356005)(36756003)(508600001)(186003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 12:58:41.0127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed616601-0cca-4fc9-6f89-08d955b540a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5025
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

This patch enables support for AMD USB4 host router.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/thunderbolt/nhi.c | 4 ++++
 include/linux/pci_ids.h   | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index fa44332..d7d9c4b 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -1338,6 +1338,10 @@ static struct pci_device_id nhi_ids[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ADL_NHI1),
 	  .driver_data = (kernel_ulong_t)&icl_nhi_ops },
 
+	/* AMD USB4 host */
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_USB4_HIA0) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_USB4_HIA1) },
+
 	/* Any USB4 compliant host */
 	{ PCI_DEVICE_CLASS(PCI_CLASS_SERIAL_USB_USB4, ~0) },
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 4bac183..6d50019 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -604,6 +604,8 @@
 #define PCI_DEVICE_ID_AMD_HUDSON2_SMBUS		0x780b
 #define PCI_DEVICE_ID_AMD_HUDSON2_IDE		0x780c
 #define PCI_DEVICE_ID_AMD_KERNCZ_SMBUS  0x790b
+#define PCI_DEVICE_ID_AMD_USB4_HIA0	0x162e
+#define PCI_DEVICE_ID_AMD_USB4_HIA1	0x162f
 
 #define PCI_VENDOR_ID_TRIDENT		0x1023
 #define PCI_DEVICE_ID_TRIDENT_4DWAVE_DX	0x2000
-- 
2.7.4

