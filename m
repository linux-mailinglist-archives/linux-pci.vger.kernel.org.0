Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA215B6B6C
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 12:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiIMKMv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 06:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiIMKMu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 06:12:50 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C61F5B79F;
        Tue, 13 Sep 2022 03:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDSCfCgxLP0HNu0xd5EakKbI7oW7csbH53iWmyfLv7oobjGndVIkc/eyVb4d8cMIIB31456DAQzeBdF5GROYz45EHJIE7ICoaNCy1JPwWdXxW3ktHjF5eMQMIjAr89tppxyrYSNbvsZVGLXozOlKfVCSdSnhKNrTsZmtyVlSeWt85zrehrNdQ2M2tqf9Chq6A0CvuVX5Z39sxX/gBBFt6FR+0C6S50DIHcq6dAVPJfoG5jcOu7xUO+tOVG+CPtsSUHEIu0NC86MyhdQX3Q1jKOEft1o4cY0CQwkyPVGaNmO5z1uxN9erQ5gL8Gdg7zWw7aBWM+ZyNPJ0mcMXNoF1hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2W2mIC2yFDzgnvT20Co7W5wi2Ei6MHaECmGEsGyZ884=;
 b=Qc6CRM8UaVDw2J4ZVhJ6n99o5gSoP5vU3LyOWCK2tMrhWC8r6PW2PZcJpYnX52vmEdGeBmA/Gu/Cp0ztjUKZ3CDQhLoNQ+1dbD5wcwMkFXPkxPIx1S4CkwneguM/dBTv2L8TZvFRjsyGnOwQiqLnbO5F2V78pkIocatsHFY0TQONIpmxxM39vTDPB9JEsOJX9rvVIbCfuZG1IQV3WrEHYg29w1kJ4T6ZzN7y/XgD0Rga8LKhrVRHIgPp8ikAB8XFvAN+THC3UMuXm2IOz9LCY9E/GpX49oLeh9be5AyXkroLv6fLKQInpUv536CTkGGqgDq7aU4Sa+vmr0Jiebw+Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2W2mIC2yFDzgnvT20Co7W5wi2Ei6MHaECmGEsGyZ884=;
 b=Eeehm1gtA2JMaKTWlR5wb9Ehmvz1iUttBVflHAgn10Jy3fBa3P/f7LlKeU/jcQj5fH/K+UtL8tYixYYntWSfWturOpMTDNV63Mxybqek/BKJ10oQmFmN7obTmLdqFbbYg7TbMvjjMlbjXH7lk01zCPOPcXW0jP1a2QAFZFncbNVyp997NfYjuuBUaTN2gaf7eGB/bJBr78LoJRBahU1jDfQXdlbH1mqhGhn+wmhQa4AGPm+lzmolGpkmLjSlPbRqyGs6AKOvwJw+fLnDqV76hFlmglWpe0vGf1U2tmE00yXaRLkU68smyqkORBkftGbxppvZQuDrUWmc88ptTYpE7A==
Received: from DM6PR10CA0027.namprd10.prod.outlook.com (2603:10b6:5:60::40) by
 DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.20; Tue, 13 Sep 2022 10:12:46 +0000
Received: from DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::80) by DM6PR10CA0027.outlook.office365.com
 (2603:10b6:5:60::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Tue, 13 Sep 2022 10:12:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT090.mail.protection.outlook.com (10.13.172.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Tue, 13 Sep 2022 10:12:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Tue, 13 Sep 2022 10:12:46 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 03:12:45 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 13 Sep 2022 03:12:41 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V1] PCI: dwc: Use dev_info for PCIe link down event logging
Date:   Tue, 13 Sep 2022 15:42:37 +0530
Message-ID: <20220913101237.4337-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT090:EE_|DM6PR12MB4124:EE_
X-MS-Office365-Filtering-Correlation-Id: 947a0b8b-df5e-4166-ab69-08da95708171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QaU3dEJprU49D+YKAyeg3HuwksSePxc1rfd8exK95odOdqUYG1D7fPhM8R2pfqO7NSQxnFEsduAptyNBX1PANs/owxsQsABI1kfiSWlSMhSPBhcJpOHICJy+65NBRgnDvGHmn5jDNegaCs/0Vy1LzrUp58SrWGC/jdM7pLLmPbhiyLjI4gZlHwlZICAHGSs21WRpdcJxSddQ0lyMAxyUvRDgELO4LzeDku0mgVSUIJxSBZv6mG7P7zPyiYE+WKPDQJPC+KCyAchTFuBRtrJNBrX7cdx0wWqDv/kNJKBJ72fJoAlqxZ1RViM7RFjTgUjHS0ftQwbr6hQc+UdxomIQQQIVYeU7wXi9x8yaUpyelISJDE71UJCyizyuPDTMbmkHCaAt9waIhsiyv8dcp69vns0V7r9T6jy8I1FUOqobltl6AG43YjhEyfAJkKLceB5V7j3VijJ+j1PrRZ7iPItFBjcb84lyp2DMvDDy+kO93NL0FnIe4GAqlHz0g0HMWcDdi9fEC2MydZ1fSbzbtS0iv/N4uRE8m2IJlJ/jKq0RLySJOsjRB3SABaaHWVZw4I1gncCJQUlr4XDx3PuLgp2mmh1NpZbAE1BFJYdmjcpisJyr3udcdWAJhPJ7aFEcHst0TkqqxGyL6EGSa/eMxEk2vEEfyH/bg0timv1ROrLughV95XExnRsEcSEoF7JjZybj6Jyyqib9csolJciKqc3uRL9ofrsellaVRx6zus2UMsg5jNISL7KRSUWQJfFvNQwm7QK9KVTJzHXRMFCKSR7ZoWF1PxN20jgb3fvxTf5oe6M=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(46966006)(40470700004)(36840700001)(86362001)(4326008)(7696005)(2616005)(8676002)(47076005)(4744005)(26005)(426003)(478600001)(1076003)(110136005)(2906002)(41300700001)(40460700003)(5660300002)(6666004)(316002)(70586007)(36860700001)(81166007)(83380400001)(36756003)(40480700001)(54906003)(82740400003)(6636002)(336012)(8936002)(82310400005)(70206006)(186003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 10:12:46.5682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 947a0b8b-df5e-4166-ab69-08da95708171
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some of the platforms (like Tegra194 and Tegra234) have open slots and
not having an endpoint connected to the slot is not an error.
So, changing the macro from dev_err to dev_info to log the event.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 650a7f22f9d0..25154555aa7a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -456,7 +456,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 	}
 
 	if (retries >= LINK_WAIT_MAX_RETRIES) {
-		dev_err(pci->dev, "Phy link never came up\n");
+		dev_info(pci->dev, "Phy link never came up\n");
 		return -ETIMEDOUT;
 	}
 
-- 
2.17.1

