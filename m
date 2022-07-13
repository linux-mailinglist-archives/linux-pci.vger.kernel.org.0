Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE5D5731DE
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 11:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbiGMJBe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 05:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbiGMJBX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 05:01:23 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0C8E680C;
        Wed, 13 Jul 2022 02:01:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjQYo0NwGHsVGUsxNqvT9o+0vwev6Ydk6FsiVTLMhdPs1rd1dI/pNfIE2XiJmBO9FpCS3utJ4o3XKyrNj6mmy8MrR/vBkzi3K1SmXLlxJxM8wfM2gvepivFlanVypcQAwi1qgDeAMEGIPY0AnPI8McTS4EK4OEZ2788mZ50usMZcncR2kJ4tqAu1tCO4QtkmLjE1GGITbGRdHRrb1v19oyr3s2S7V8uyW4JYbG7/m2xXig8cMD6jTg84YNf2c5l5T5lYfaL5f0TwE0OAwQDvzUPjUmXVB6wQrOxm/aGI5v9Vif2aBg0xCYEinN2XnKnsFcoXBD0vncqgiVu82mRfdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zCyjWteW7l/CENSEGz/RRh7vC6aPY1msZngQiVtqQw=;
 b=EsRAkzvoMejH18AUKAJrKSOZstwxePerMKbjygokyGVx2NaSYjCbw8D4ZtOvYZrjD2k2mx6BxSv0J4IFpqVvU8H+lE2wObBD6NWzGHLHMTevNozEmji5iZ7F+dlTL4JUbaO9v2LqKzoxIn/IEw2z1RsRW2em0kSwA4KmRg16DiOo5wipkcba8olyU4QccVLQFJMyYqUA/6111beE5kK7/s/YDCRIzVo/odGdh9YdYOlTN7VDj05yclEh+hHGa/l7l4DHvIlvbEj8havJD61cbXmdAMYRN8gG1JrBmP79JkBdfxy67ILyGbvLK6R+vWZ3RoQCg3dIA+1Yd59VqToClw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zCyjWteW7l/CENSEGz/RRh7vC6aPY1msZngQiVtqQw=;
 b=Jikg9PHYzze8zKwcmyH4MuPsG9DBPxL2qyUxy0S6yU74g4+aZLDbao5P1TcwQDf5y+oQoPRC4P7EpI7a6NDo7RM0S91+0zdKvDXDJG2NqA0y5SusxyjoGTbHTqbnr3c/2dx9bevAS/0oun0udnTAm7T12hr3SOu9MNfb3tmLvXNzbb17f1K/AEQwE2Hp73Eyz3nzGu8DolohlduiIH5dID/ebWFE7DS4KoP5+olRL0Gw2S3IpuZZJnXnQCmszkbhEtQrhmfAJgpECKDcmQAS7m7k0gTIV6RWb+B1BeHYkrBmDVd1oJf4+3YuEeFiqoXsoRB1aCV/i+vxE1Xr1wR7eQ==
Received: from DS7PR03CA0271.namprd03.prod.outlook.com (2603:10b6:5:3ad::6) by
 CH0PR12MB5346.namprd12.prod.outlook.com (2603:10b6:610:d5::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.12; Wed, 13 Jul 2022 09:01:21 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::9f) by DS7PR03CA0271.outlook.office365.com
 (2603:10b6:5:3ad::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21 via Frontend
 Transport; Wed, 13 Jul 2022 09:01:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 09:01:20 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 13 Jul
 2022 09:01:20 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 13 Jul
 2022 02:01:19 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Wed, 13 Jul 2022 02:01:15 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lpieralisi@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <kw@linux.com>, <kishon@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V5 7/9] PCI: Disable MSI for Tegra234 root ports
Date:   Wed, 13 Jul 2022 14:30:27 +0530
Message-ID: <20220713090029.30395-8-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220713090029.30395-1-vidyas@nvidia.com>
References: <20220713090029.30395-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3aa114a-712c-4b0f-eb29-08da64ae415e
X-MS-TrafficTypeDiagnostic: CH0PR12MB5346:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g6/xsO8LA5X+etYdxwepkpqMxp7d/7AjP30OCIVUvIOiZbpmw8dOD0toDBieL5SJ/O1+z4HKLZbmvqLJawYa/r58ewM0vXtzYbMOAJzblJV28Q5QOfAyF7cuUFsmRSN3irI4H2BhT9lgGWfAzK8QWlkrBNTve6i5hAKm7VA8J0dlffzf4V3VkOC8dCfY8s321FB2aHeMoo6JpCQw0YnwY8abAvmq716wrrmcuqNOWeFNbqLIAjKn4RNIMBwA0VEhdSJI7qGUzQLunIYEoueKZU9x0y+e6oQjz9au6fefRheMi9PsVRLFopxNIHelwsrIt0KPOky4GaAaDGMoZHVzQOD1dZplSoUzuD3wxM16xI0Pn7HMGP4/L+A13p+XbtQ7Psjgv6PRYQ4QDwCTsUBIaibQLEJ9jkCbY36QgKwaVDq0P+FJRjRkezUf/7wiJADIHm4DW2jlpGmwwUvz8NnKm/N7W5s3+mqTxtlmHNSPmSE8NrqAyvmArY7d/bu2zXJ9SgG9pgv0UEOthZxxiWr7vRkXpu+cwJdL/oZKTtN+ywIG9d1Zxfs3jCZR4/pjXY9S+O0EQ/fMJwLzJUpvW82TpCh/LGhfsOIeyd8PI42TaQjRvdAxRrnoP8/sFLc21wepV3TTvNaNT8PfFy7UWHWpezp6tlaOv8eW+iMhhyCjwTbfzmsJXcLkYAlX6kfHKF2SSUha/V4SIIjjnICXq6cEkdGUSa3JzfuaaFSgEEqW2qD+YvCet2zkqBIAIKkADaHALKIIzbGIFABk7sEr9MpvkZ9D2Vbpzw5rNIw3PYbppOFwFY3Uz/AcgO1JWEpMTryYsGGe+GDJLgxz9Zku5vfbOKA38Z6uuhkhbKxihBNK/TFU8PrcLpyXt914N3lb9gbF
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(376002)(136003)(40470700004)(46966006)(36840700001)(316002)(110136005)(2906002)(36756003)(6666004)(41300700001)(54906003)(7416002)(426003)(2616005)(1076003)(336012)(26005)(7696005)(47076005)(70206006)(8676002)(70586007)(4326008)(186003)(82310400005)(81166007)(356005)(40460700003)(86362001)(82740400003)(83380400001)(40480700001)(8936002)(5660300002)(478600001)(36860700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 09:01:20.8923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3aa114a-712c-4b0f-eb29-08da64ae415e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5346
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
2.34.1

