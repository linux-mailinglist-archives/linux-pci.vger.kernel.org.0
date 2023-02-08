Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511B668EDC4
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 12:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjBHLTz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 06:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjBHLTI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 06:19:08 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFC3457FF;
        Wed,  8 Feb 2023 03:18:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/4A4ShrUpfegRBhEI9y8NCh1RMGotc2Fu7SaKemmc5kEuPuCSKEZLuzewB+/44I8dHnd5EVESD40LRtKGHNkIW0qXTE6ycEt33SYilkZ8JtOzBFQX7lhARh4THJQGaqjWL6B4AP+uC3PURlEmsgfnNmIs7C1cUQ5tgBZnJu3YWiCM9hhGUwWd4SSP1A32CDylDrGhyf3N9fTBZnqo3y4Zbgr06ACQiTdy6N0bvDA6YqRq7xhVOoRu+1j75MZovxMKi4RoyVFkMbvk2AzfvmwkUQztJpe4qhvs0n4GNf/b2iHZgT3XwdNpBE38fUzUJZku3PrEHSlghelEgyfilUbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFJuUx+vshbAtE3PcS6oKKtJhnpxHv7OrgQo9Xd4G4g=;
 b=mtiqXVBkKVQmPd+ZGUSzUYUBGpVKJ6xjpqoe9g7mI27Eiyw6TjEVnl7F0VnJhfxMWQK+Nuj4OUw9OkXuzqfwmltWb+Z+gnTwuQksnACpBq+nW/9Qo8/DKBpwloU0w2WHLbHRwKMVB1u3i05DmEGlzUv45ce2ptQ8Tzo/Sd/i6IAG+CPX24S6aTn8BVFAciEyU2mgiOp8aacK6FSHgGiPb/nMWT35XMKr7j+DIWaba18x1kXINpCz2SN00lnpHpH25fma0QsZFWkjI9vZmy6vHop2hfOP71UheW0hcEdxFbHaumRc2e8a0QFjdu4P7Y/13CI4gmd2G99mIGciOLzGkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFJuUx+vshbAtE3PcS6oKKtJhnpxHv7OrgQo9Xd4G4g=;
 b=SH0Nd86d9XIN6V575zvsZFqQbq6tZBrxXSFMTS8dkGIvKGlP98htR2vh6lHSR6TJgKyE583O2BFK/2hYRrAu+5ukPYfWrFQhqofY8u+PH99tKhB3KIust4jKbkVku+ExflyYWY5C879SumbQNN/kp3VM688VNsMU60je9/l5XozrKBCvE0FeyuULWyBjqKIQzqlKXFJeUn64BUZ0fooVr+ODDciPt9MwgqTobyg2TTCcsXXgerdFznc2sG3JXS9yvr2EFi0v/ic2OBALibyu8o86zAxt0kqyk3GQGLZ403rOgyb3Mak1EncDXtfoiWZ0S5Gfgm+GXfd8x+Nnb9l90Q==
Received: from BN7PR02CA0018.namprd02.prod.outlook.com (2603:10b6:408:20::31)
 by SJ2PR12MB7942.namprd12.prod.outlook.com (2603:10b6:a03:4d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 11:17:56 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::65) by BN7PR02CA0018.outlook.office365.com
 (2603:10b6:408:20::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17 via Frontend
 Transport; Wed, 8 Feb 2023 11:17:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.17 via Frontend Transport; Wed, 8 Feb 2023 11:17:56 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 8 Feb 2023
 03:17:44 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 8 Feb 2023
 03:17:44 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 8 Feb 2023 03:17:37 -0800
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <petlozup@nvidia.com>, <rafael.j.wysocki@intel.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>,
        <jeffy.chen@rock-chips.com>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <jonathanh@nvidia.com>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <gregkh@linuxfoundation.org>, <steven.price@arm.com>,
        <kw@linux.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <vidyas@nvidia.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [RFC,v14 5/5] soc/tegra: pmc: Add Tegra234 PCIe wake event
Date:   Wed, 8 Feb 2023 16:46:45 +0530
Message-ID: <20230208111645.3863534-6-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
References: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT068:EE_|SJ2PR12MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a1fb2df-3a00-4386-98ea-08db09c620d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FPklJNVKITaQVJc/91Oee5OnaVMnBY1AvrHmXGPF6xkfx/+J8Fa04t2qc8/AGmv/ktq1WnaVznLcWMDbvYqDXkSRwKnDTdwJkO+17Ye7w4jSAoRZO38kKvAVDeWGI8IiebO/FAw/xZWF1ttS64Y8ZBlLjRiZxLAlzV8Iphqsjj9Q5w13Fz6H+I4zqEkhtDyngEPvkTqLpQtQgOLT+46amz7lyvYwfn4fCdiGlO2dQJh5Z7jkx0Os6bnqITcnrqrCGWTie0wUgp+YxNTqiW3M+MrWAqZdvHW0Odby2rahGtmd59JEWkLyDV3cZKpNtkMnxGlRtGNBTyuTYLllEiMKpDaZX98KZZMDTcyRfgNFX5AzdaXjExeGDv8GY7U3vu1frVOJpk8RowelXckZfejvEkq4xHT9/UQXBLlWWQO+uNPAanc3EnVjcDeNTXEjBMggIbqOQAtpMIpgzjhnEutPlFQbPuxrR0F8KUW5JpUe9DvI5fiNpPAVYlcTSpfMDEJpketMO6bZCPc6QuQHZNZVqjiankneIkNxGOonXt8pGUHztvyzu95M06tcbU+3H8M073dRTvJRrtNAQVQmzIFUU6Z1oFOauL7up39A/VkwEFfYXdRkSvJcc+fwdLQWcNOoxUQV7/NA1K8+gkV1udDeZ3LnmGNIQdE7cXFFtmT16AARPTsdKx0ueKN7jVyZpyLIJ2T7NO4Kemk8N7+7BhL3GA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(4326008)(70206006)(70586007)(8676002)(36860700001)(336012)(40460700003)(316002)(7636003)(110136005)(54906003)(86362001)(426003)(5660300002)(7416002)(478600001)(356005)(1076003)(26005)(186003)(36756003)(107886003)(6666004)(2906002)(47076005)(4744005)(8936002)(82310400005)(41300700001)(82740400003)(2616005)(7696005)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 11:17:56.0004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1fb2df-3a00-4386-98ea-08db09c620d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7942
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable PCIe wake event for the Tegra234 SoC.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---

Changes in v14:
New patch in the series to support PCIe WAKE# in NVIDIA Jetson AGX Orin.

 drivers/soc/tegra/pmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index cf4cfbf9f7c5..139ee853c32b 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -4225,6 +4225,7 @@ static const char * const tegra234_reset_sources[] = {
 };
 
 static const struct tegra_wake_event tegra234_wake_events[] = {
+	TEGRA_WAKE_GPIO("pcie", 1, 0, TEGRA234_MAIN_GPIO(L, 2)),
 	TEGRA_WAKE_GPIO("power", 29, 1, TEGRA234_AON_GPIO(EE, 4)),
 	TEGRA_WAKE_IRQ("rtc", 73, 10),
 };
-- 
2.25.1

