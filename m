Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3494857CD5C
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 16:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiGUOWS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 10:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiGUOWJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 10:22:09 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B177BE1D;
        Thu, 21 Jul 2022 07:22:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aODAdK4aabMoCGYrui2SDhVwu9B76R/WMfkF6Zp48K0mTosGmWBWlF2mDLGHrhAxMHuKNzwZA+2jrxXW+8XsObsrm4fbGlk41VnnK0Fu77ajVEOYVpvG3X+0ibb4HrcDKkz7my1U9rfRkmY3GW6V9+o+uQDbfwCYNvbmYhPZ209TuCUg/f2mfumQ9zCtGiGmrVpTI2pKX42fvNnO52qGOSBV4mkBgsrPFuRXVIfNa8DY1TD2CQCDSqeFPAzza4W8GHPON5y8hsV1JlNu7TOX/CRWUSMbgY7bnIGOtYoiYx13VwI0sbkdBsV9T+vZl8z9gnHhoYMkHngr9ll2HRj51Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2JUUOmkVby15TFdtCHkiVXcuWt4I74CWGb3GjLV0lk=;
 b=EXtrT3lCnIdPF/ylwMoYY4Dhzs17QyPnEcsftvpSnm22msU4Zo2X2JvOU2BBpEXMqMGN17O+UrOIf2E4u1GmWTdVo1dNDtJqmjo9b3GzUBmFtalBdiLMVBZxdw+7tJF4RB9nNll07AAIE5Os7CuYWj7KsExFRa5BZWa1cmJH2Y6SgnwQpgvZfk1pR6WZyKMdfra5szTgc5zC3TpOzErKLCNqAqM3YuhAdDr1y+pWe1MhHK/VhY/1cBcJxb9XqgkaS825MqIxoV4wWZrAxbzWrbFyktLTmkCtM91osJ3CjWg4Dg9bbtNtCAu1RgRerKs4zRlQbBCBgq58CSZGLz4CSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2JUUOmkVby15TFdtCHkiVXcuWt4I74CWGb3GjLV0lk=;
 b=Yzer1hcH86PHHaIoU9g4zL44H6G5bG2WTw6iU1c70e7/+KhXT8U7OqwfeV8CX+SoIqttLW90IMFgcxyjwscmdpbkBQzszMeJmmi5GQHr7tVzd3Slj8d0vGefggXSltqoldG+1m+d3p/Q/RIltZxoSbWH6LPUrvZ3iLWeA71fIAAHKhNi1D71yY4mRy2CB6Vdg0JGaj8F5oHR6iZPXoY5yrVzjV2XgaMQle/RfMiNJHA95auTVEq0fP9mZWgrk/8cATmyfI9/hIv3+mBov39eopy9dwKFL5xdRHVHjMoOfNlwUIaA8pBjrKvG/5KX8MPRqJX6vg6B+m9Pb4WOL1wWFA==
Received: from DS7PR03CA0207.namprd03.prod.outlook.com (2603:10b6:5:3b6::32)
 by BN6PR1201MB0034.namprd12.prod.outlook.com (2603:10b6:405:53::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 14:22:00 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::fd) by DS7PR03CA0207.outlook.office365.com
 (2603:10b6:5:3b6::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20 via Frontend
 Transport; Thu, 21 Jul 2022 14:22:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 14:22:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 21 Jul 2022 14:21:59 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Thu, 21 Jul 2022 07:21:59 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 21 Jul 2022 07:21:54 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lpieralisi@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <kw@linux.com>, <kishon@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V6 07/16] PCI: Disable MSI for Tegra234 root ports
Date:   Thu, 21 Jul 2022 19:50:43 +0530
Message-ID: <20220721142052.25971-8-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220721142052.25971-1-vidyas@nvidia.com>
References: <20220721142052.25971-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 132a6bc2-e22e-4789-db60-08da6b24603d
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0034:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8mabH5Ii39SqRXfl5T7M1WhNXsxqb2TgFSPZcWYi9V/GEFlXBFoh7CPvDFeeQGWSPVXZLjv054a+DBZx0wHzHQbNZvJv/YDUEDwqv7n9DCQv2fK3PTGj6Lb/zpLrO930bxwwU1bfzKjbhROCS8gie7CwXNQ6WapQJIhRoXvVNnLYUbxbnfWbTjrmkrxw/2X3pfKE/VGw+jC3jT9klow4pM9ooUr0OwAi9CSAyKs6+1VDFklBuO4yk0z7Hf8may8wd0KYHxqoDpPq567+vaoUVU7oHmmDnwZFISq5BHETOe2QOkheo+NTLbTrOJHvSix98IHdXZnZzw52PKjfbPWtplk/ToM4T8VG0KSZpeowNZKVncyBtgfMU00+/kWfIBtmGUebsATS+Cs//Z0STx6p3dCpIBQtYSkPQwSzwA7qtUHRg+WZBBCtCKwuRw4pLiPB1Ff3PEXINWuBvyBMfXBvcTbWluaL+CRLzA9ajAdMTBrYJfu9EtSZ9xzp/H4xe27hupSkOwgR98e1traYrFueRzQSq0kvjaK7ffVddjQ+GkcemfI+hkj1kD486EhAxi+M0PPUfEesw45Pqgqh5COcbODMCYpE5UPQOPlK22mNgK0TlYl3QBWiB8akzCOnrNjRtfAgPTDtaGdHCNG+CucQmWk6R534hrRwjt3R/xyT65RS7z8Ah3a5JDnPL8S1DSU2i5IpyvlPhyKiqPSjQsbK5+e48WtFDb2ToEYggXoJ8rtVMn5HhiTiqUKE1VWny/XzXnZPsSQw7reAGn3aYSkuUOjNwMR/ZyHrYebAf/9JQJ1KapMuP9450i1ZbC0VvLzy7QBRdYALGDmxNZv5rVMBmZ0AX8EKBO24cM5D9r30ppo=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(136003)(36840700001)(46966006)(40470700004)(186003)(1076003)(40480700001)(110136005)(336012)(426003)(36756003)(8676002)(70206006)(54906003)(41300700001)(47076005)(70586007)(4326008)(26005)(2906002)(7696005)(2616005)(6666004)(81166007)(83380400001)(40460700003)(82310400005)(86362001)(36860700001)(7416002)(8936002)(316002)(5660300002)(82740400003)(478600001)(356005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 14:22:00.2757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 132a6bc2-e22e-4789-db60-08da6b24603d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0034
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tegra234 PCIe rootports don't generate MSI interrupts for PME and AER
events. Since PCIe spec (Ref: r4.0 sec 6.1.4.3) doesn't support using
a mix of INTx and MSI/MSI-X, MSI needs to be disabled to avoid root
ports service drivers registering their respective ISRs with MSI interrupt
and to let only INTx be used for all events.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V6:
* None

V5:
* None

V4:
* None

V3:
* None

V2:
* Addressed review comments from Bjorn i.e. changed the PCIe spec reference
  to a more relevant section and modified commit message accordingly

 drivers/pci/quirks.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 2e68f50bc7ae..5b532449ac4f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2709,8 +2709,8 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
 			nvenet_msi_disable);
 
 /*
- * PCIe spec r4.0 sec 7.7.1.2 and sec 7.7.2.2 say that if MSI/MSI-X is enabled,
- * then the device can't use INTx interrupts. Tegra's PCIe root ports don't
+ * PCIe spec r4.0 sec 6.1.4.3 says that if MSI/MSI-X is enabled,then the
+ * device can't use INTx interrupts. Tegra's PCIe root ports don't
  * generate MSI interrupts for PME and AER events instead only INTx interrupts
  * are generated. Though Tegra's PCIe root ports can generate MSI interrupts
  * for other events, since PCIe specification doesn't support using a mix of
@@ -2760,6 +2760,15 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x10e5,
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x10e6,
 			      PCI_CLASS_BRIDGE_PCI, 8,
 			      pci_quirk_nvidia_tegra_disable_rp_msi);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x229a,
+			      PCI_CLASS_BRIDGE_PCI, 8,
+			      pci_quirk_nvidia_tegra_disable_rp_msi);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x229c,
+			      PCI_CLASS_BRIDGE_PCI, 8,
+			      pci_quirk_nvidia_tegra_disable_rp_msi);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x229e,
+			      PCI_CLASS_BRIDGE_PCI, 8,
+			      pci_quirk_nvidia_tegra_disable_rp_msi);
 
 /*
  * Some versions of the MCP55 bridge from Nvidia have a legacy IRQ routing
-- 
2.17.1

