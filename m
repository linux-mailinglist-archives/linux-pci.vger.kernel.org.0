Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8D3628468
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 16:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbiKNPyB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 10:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237168AbiKNPyA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 10:54:00 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1589020361;
        Mon, 14 Nov 2022 07:53:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvWGkdthRdOADaR1CiC03cCZbgzAr346vpny/mMqiFB6hs//gQGY/UHyealKXxh/9cX4L1e9qAoABCvoeUie1ZPDwIvCvR84acyqvwOFbmhrD7UzEIevBsdwe5zYzBscEl+17DQSB/MJBs8gpacgXKZzkOAyjYfJey58d+xXHZx2KCi9G9/FDNZxjfLorbFqrAoHkU+l7JT127N1CF1ewIpQdV9g2t2Qa8lp4S6CnduwT2R9huAGWaNobd8o7Ccwrj6Eifj+ARGBPu2zL8X98zn1lHRmkl49ixKkyRB+qpwyF43rD3JYnLbhPMJ7do5m4JdIz2rakaVGi3v6Kh3hlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCZdRJRAKiUOO6QzsuBra6D6+5XaQKabGWZwGltWjbM=;
 b=eVyGQ+d48cSdf/FSF4g75/KwEYRn9J7beQbcE2wIhGbeJJ/4gfW4xiscVyQjbEmbsSjB01asCtYxdD7Env8gv5Q/BG0UQXpoquXYKD66CNA45NC8CiVaR/8/keatYMqWszbuY2APLKcU7HpoO9x2fSEGFRsp8GLN6GdoyTOnFmVFh9EsPvrB5YzSkBVHmA0qHsho0ahVhc/fKsH6WNQbKU+8OlrG0/A26aiotsOT+CcFElHrWFguWTvNYb+HXqtrRGxniw/vtK5zDP+Cl7bq5zDTt6xlZ9z9LSJqf027m84kSAfJYQXR3QHioksAjoUixcmw6rWijndMARQzEZdiTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCZdRJRAKiUOO6QzsuBra6D6+5XaQKabGWZwGltWjbM=;
 b=ofIiU5dQen8iVKbEExw9vo1DWJG/weF4qFT9/7LGvps4DvonSX1HFVA0w0ObpIXCiR/rNF4xVJZNP9dUgcBxLdwgr/XEu/0M+mVR4+6Nv8qLyok9y7eFof0mnLmlS3InxAhglll2QaWEf0kLZXAZBQauSYRuZ5mOJAekV33NqYBvNWwfgQntvHOXgi5gWjLaE+r0x1VLf5J5EtsOHejqJC9mYuuZdssL8N70DOKs4i+5hlKRZOLK3t67ya1AlY8dj0O1seOcBHsFXraI6CXOpUerZa4eBEzr5M1zqAaJ7G6uLM1SVIF9WIcPi8QsN1Fqx0cdJT7Zgb2GRtlE+4UGvQ==
Received: from DS7PR03CA0061.namprd03.prod.outlook.com (2603:10b6:5:3bb::6) by
 BL1PR12MB5379.namprd12.prod.outlook.com (2603:10b6:208:317::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 15:53:57 +0000
Received: from DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::69) by DS7PR03CA0061.outlook.office365.com
 (2603:10b6:5:3bb::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 15:53:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT097.mail.protection.outlook.com (10.13.172.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Mon, 14 Nov 2022 15:53:56 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 14 Nov
 2022 07:53:47 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 14 Nov
 2022 07:53:46 -0800
Received: from moonraker.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 14 Nov 2022 07:53:44 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <vidyas@nvidia.com>,
        <mmaddireddy@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 0/2] Add ECAM aperture for Tegra234
Date:   Mon, 14 Nov 2022 15:53:31 +0000
Message-ID: <20221114155333.234496-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT097:EE_|BL1PR12MB5379:EE_
X-MS-Office365-Filtering-Correlation-Id: c0889817-8919-4287-904a-08dac6587061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zirrET2G8y0ZHhKCwhnXgPlCA/egY0Lzw7IKDYlvsEe4eQ5lZJRPcyOWOnhQ9NGGO4gUQdXgdcGMAtJpB75+6ltRL8Dk7IZEZPQ+gv6eaaQ+9/Rmqyuiv3Sd9/FM9Rgt/7aviG0rfh9SPghk1Mp3fJtw9vpu7NYKT5b5EyISwo5l7P4ITGdX6ObMw4YyF4GKk83pLBI3Mw0H8y6Sh1u4hY1DCIO8o5eFnsZc/oMg+im87B/U1WUA1YHGj9g5hnEcMob2KrzYCK47YJub1YR2m1lPAPIcJH2Add2UoHpWRWQIYIPOIdSXN0PNUF+iyUtK6n7EGXdWfz8AF7bfFQud8bbDXfy3u3ZNs7bbJTCAADLah8ZGashvXpUywqA8uHVNrtNlR1BKgjAbXa17DfbL60rH0rE7BpmN+dRBpvkmN4fQEyM2J1of+Ew3YGJUha+0UaBk1J4ZqPKuG/WT6XIXAxZNOTnvgcWTtcBqQDwait67NdweDexx9YS4BOt5Ozcv0lysVEviJREquMiRhdr6QevGrYZGWg3fEnICp+VNv0Jis76lgtymxRD5POIGpPZaWjK4e9Sn/u60tyJryoYcJ3l+DQyHlNsPLaiBNQfIFnCVmaWhA5vF8Bcun4qE0725HSCIke/HZhaI+1JjEJ19evzycnzuWuhiY3iVVONDCQqQPgMD3RhLnzLuInDwlftAGcM68MGwDLQ24UDrnwL1u601rd4FEskVGQOZnG22i0AcbDoHqhio9JDP0unBYfohwSP8ymR9B/xSAB2zsPIY6Q==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(36840700001)(40470700004)(46966006)(107886003)(6666004)(478600001)(36860700001)(54906003)(40480700001)(110136005)(186003)(426003)(2616005)(8936002)(4744005)(336012)(36756003)(41300700001)(26005)(2906002)(7696005)(5660300002)(70206006)(47076005)(316002)(70586007)(4326008)(8676002)(40460700003)(83380400001)(1076003)(86362001)(82740400003)(356005)(7636003)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 15:53:56.9647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0889817-8919-4287-904a-08dac6587061
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5379
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds ECAM aperture information in both device-tree and
documentation files for Tegra234.

Vidya Sagar (2):
  dt-bindings: PCI: tegra234: Add ECAM support
  arm64: tegra: Add ECAM aperture info for all the PCIe controllers

 .../bindings/pci/nvidia,tegra194-pcie.yaml    | 34 +++++++++++-
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |  2 +-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      | 55 +++++++++++--------
 3 files changed, 66 insertions(+), 25 deletions(-)

-- 
2.25.1

