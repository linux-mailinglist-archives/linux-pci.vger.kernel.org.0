Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49ABE62820C
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 15:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbiKNOJ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 09:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236762AbiKNOJz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 09:09:55 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58322494E;
        Mon, 14 Nov 2022 06:09:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLozf/Qvl/B/qIhSW85HmyT/7hwkUT9+Az2bwCiM+KE70yNQTcp3ydzZ470fqJjLVsYfqEChD4WQb38ZyS739mzlHAINDKU5Hc99ns+7vsOFa1rWerurxu1PDex4Uo4VqLmrjJM6hd/TO2MIRGbzckiePsoKLj0b2i2ra6R5bSjU/7ZtbSMHGBbwfcv083kPyzsUdgzqjXQ0iBj1CXWROQ2CTzURlsOSgH9e5E/A/7WdCRaHV4/YGtaCV+9/Jg4wQPXVtIuMSendcG5ko6XYWP4Qrw6hm1PcReueQSnlczvHlII1eh5e5Txwy6NdpedVZxjRcrS8Mr4DAdv279iRlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nd7q+WVYUahmTJRq3w88mbA6xdIQgU8UdaP0lgGY7VQ=;
 b=jbilKeJ6JYb+Z9l0tBXf1brRv28qRUzui+UEdwcLAqJ2AT06VcOf6f2lCv/sDMJe+n2Q5fRfevVryR2Gv7Q+Y0ccUNf4bmyUvfj+H9FhF8UwNiZdyZeyWI0ilUgq+Qa+LPOmp3nJCewue3QO8vkjPVpBUn/MNHLNhcvJX1XAz9TVJJallyFxPO5BUZGs+RfHeJpL1LWHbas8DVFY31SMNihB2nQa3KDDA2lWW3Q9YfwP6WqWLD/1ucOmGynD10MdMEZQST1ya9GHrbBNtygCdQ/uFHMK6Cq65ibNyNDs119s7aU2CvakLlNnX+IoFinOC89VhjbKm+BQaM5U23ZnDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nd7q+WVYUahmTJRq3w88mbA6xdIQgU8UdaP0lgGY7VQ=;
 b=mac292z5K5myKk3EW9JwycPQgkDC5pxvlqHW0I/+U9lJn6A10afNQj8cuCodPPssGggJdy3Ue36VyzqymdCIPKKtjGXojI4kdsMuks4ISKUHkxpfZSduQabCyM5fI0KVHjQnnZnHlm+xxaAq9kvKxTBleqkQzb+pxP6cg8cEm20MdJVuAitSpyuysymyNGWtQFk22Dz62s0bxTnuMizyFfCdm+ZtibTANbN0Ts2wgHiCrypAaA/ttaXDXfbJsJsdQBgNSb3W9lod5X9dIEmYDy2lNfLz6WOEz68qQVWLT36H2pLPgofcAYuLzH5OMGwsu7cANMRxfRfYt23sd7eoyA==
Received: from DM5PR07CA0109.namprd07.prod.outlook.com (2603:10b6:4:ae::38) by
 SA0PR12MB4494.namprd12.prod.outlook.com (2603:10b6:806:94::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Mon, 14 Nov 2022 14:09:53 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::70) by DM5PR07CA0109.outlook.office365.com
 (2603:10b6:4:ae::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 14:09:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Mon, 14 Nov 2022 14:09:52 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 14 Nov
 2022 06:09:52 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 14 Nov 2022 06:09:51 -0800
Received: from moonraker.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 14 Nov 2022 06:09:50 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <vidyas@nvidia.com>,
        <mmaddireddy@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2 0/2] Add ECAM aperture for Tegra234
Date:   Mon, 14 Nov 2022 14:09:14 +0000
Message-ID: <20221114140916.200395-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|SA0PR12MB4494:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cfce57c-644a-4425-3874-08dac649e684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: epvjEUNk+lpWDztnTGtzfiscACfPjALdWGEhus1iblwFavoq+OaoqIX40aJmniHawP0xaj7ToJoSn+bS1w4VH/oKtH2gyxZHsyp1Wlk1jeeHGcIU00sJTrKM7xMczldGdiJeNr0joZWUgjeqSkgDPfH15okYoJ2z81YHpPvbedSp/aEtVr484//DfQ5RNR439IDnpHL+21Mckc+hn6FNbs3vp4g99gcbjJdpwLZs6LsFlS7J4gZLdds3fTt2utFCJVi/K136kYty7B77BneuPQdV56w2S9WrEF9pxfBPuRYUHu+NDA4x3hpQvRl5CmiVjyXOts8UW3/AFZj/az8B5yzgqTEeSlPII74WWoSD0f6NTetV2NRQwfmOkJPtaRwTIz9Q6YAYa7Z2rM+bV5sot09aHJ/gl/kNVNdN2lznftm5smgLVCCZTUViKZEZmSCcPe3DFGv5NrRUUbUMsdbBrxCvoHQNnlP7890rzOOxR9rlIfIC73Fkyobxy8berP1omE5mhGYWv/YhxwVEv03Q/3FRG4Ts6abuzROkdbCJTlEwqI3sNlgqgGajvL6K3hOVdeTWd80GGUGBnf1ekg09vjzHwayaZysGxDTx0dzVeVKzubMgBisSjlQsK0s9zXozIWd5ir0ISdNN79cJnpEmlPf+dswtgMk89Pujfv4JRews+/7vulXcloq7Pry9yIsvz1aDK3SzEXOFTSYva6tD4s1izjuRzgje8ee5jq/mYVrMGhFB8dX+al5UPci5QDwT4OOrUeqwkDnEjkMVHlD22A==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199015)(46966006)(40470700004)(36840700001)(4744005)(2616005)(356005)(8936002)(82310400005)(478600001)(7636003)(7696005)(107886003)(6666004)(54906003)(110136005)(2906002)(40460700003)(316002)(40480700001)(36756003)(41300700001)(4326008)(70206006)(70586007)(86362001)(1076003)(186003)(5660300002)(8676002)(82740400003)(26005)(83380400001)(47076005)(336012)(36860700001)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 14:09:52.7277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cfce57c-644a-4425-3874-08dac649e684
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4494
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

 .../bindings/pci/nvidia,tegra194-pcie.yaml    | 76 +++++++++++++++----
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |  2 +-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      | 55 ++++++++------
 3 files changed, 95 insertions(+), 38 deletions(-)

-- 
2.25.1

