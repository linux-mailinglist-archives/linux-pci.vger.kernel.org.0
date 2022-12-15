Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F4E64DFA5
	for <lists+linux-pci@lfdr.de>; Thu, 15 Dec 2022 18:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiLORbF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Dec 2022 12:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiLORbD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Dec 2022 12:31:03 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA6D26574;
        Thu, 15 Dec 2022 09:31:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgVu1BYqJw15iDtAvPpa6W+jQV9Ul2bXrpGDZ+bqG6fY8c8V4EEHVSjmvSSznvIKVrrbvLBolnfPht6+/Df3cWuXCHfcU6vP9wkCc7kMG4A0W269vzxiuySd1UVvEyr2gtUBFCYtbtJpv6LDhGbJdK1J7thQHCt+py/xLVps2/HYh7t/Hct2xdHl2gr6shSnZGaPT2zFr5job+iXlmTkjI5hTXYK6bweF6iJtJOvFxnN1kvQ50mCyG2zQuUCBrr8aujF8eeqOGQg2TZzk08AxZlCkjP0agnFonC875/E7qGfS8XzBko6ZEx+LbrHaJCA13+ftBIj14Z95lJiY0Z5RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kE3EEoROF8TRC85LHQNVGLLOGk4/ncwzq/kMy+zm2w=;
 b=VlmzZhHLIpW3YRmW2NYrHzr7+Me3Hkfld0/chEgpO+Q9tqiKKc3503fn/C7MPtbaAudFPIzdsC3so4osW69lqTNtboK6OJqxxaZ53YEX5LKADT8cla5mE1FCbwGQ59IvSkiOGMAl0uuOG7/iYxPkYZktpi4UsTGfywx4hYS/iJwA28LLTiTUbrU6smH4mOxAR8hvcafhMDAgwoEsbReUH+aTv0Sl4gjU5iJ8qzCbl0t+IKAEU7uFXBPqFLElP4THooSbADqyNYKmHiX1EWLHOH4PuNpvqh1JVLlfpURxLSfzveiGe2JRh7340x97r+uGEqirFK/KUgOy88LGvZdftw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kE3EEoROF8TRC85LHQNVGLLOGk4/ncwzq/kMy+zm2w=;
 b=qKyCeHAG1nugpTi6wA2pJ1NURuqJqEmMVVcyE0Ip0Xk6uY/937rbhl0NPlijKcWkKlXkQHz3sQEurQrgizrHd1D/eyl726+U2x3YvLNPRDiFfm8FYLBxJl3ZB17ey3Z4LDeTlA53ZU6zsLyPf63MukX9kPJcL4dWNXK1fcn/qDA=
Received: from MW4PR04CA0134.namprd04.prod.outlook.com (2603:10b6:303:84::19)
 by DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 17:30:57 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::ee) by MW4PR04CA0134.outlook.office365.com
 (2603:10b6:303:84::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12 via Frontend
 Transport; Thu, 15 Dec 2022 17:30:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.12 via Frontend Transport; Thu, 15 Dec 2022 17:30:56 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 11:30:53 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 09:30:53 -0800
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 15 Dec 2022 11:30:52 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
Subject: [PATCH V5 3/3] PCI: Add PCI quirks to generate device tree node for Xilinx Alveo U50
Date:   Thu, 15 Dec 2022 09:30:46 -0800
Message-ID: <1671125446-57584-4-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1671125446-57584-1-git-send-email-lizhi.hou@amd.com>
References: <1671125446-57584-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT020:EE_|DM4PR12MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a50fd04-5bbc-4d74-23b8-08dadec22005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hh2K+rmWdvIjRLLJ7H8KujR/aGWjw1lxNDUxGUzS6g+z1lFL4zvL2CQey7AQiEWuGg2TxcP2VsYpyZ5Xq663/3W0Rm2QVutyKVsQZVXgjLM6H7j6rgzXLux4UZL1nxXGKNATHiDG29SKxLtmpfdNR8fsWgzC+31PFZvTrs6s/YR8vcWEz8YejtrepbUQ639e+TICy+5VX/BYmFD2QPRwsxPElhGggXTjswXqIe/QM8eEufwjeSVjneoJr5OEbEQbX6hNWVCXUx+KDXM1EIpP9/A9+eN/ue3juHpspZ4DCz1BZ095H5OaTwJF5KYLNx8e0/st4eXBaqITtKhB690X9Y0bhYDfS3g0xwmE8umqvO7pSV4e9tIKnQDifR8h5Aim6rV98M1b6mCKbQk4Skhdi+Ffp0P90YNZF1OhQzE8WpJkJ29mm5LZM7IJM3Bb8AtmxpJ+AxoKQ+B4z4LlflZYBpO1CgIYM0HyeKZ6lbmC7tpI/b7sBKGvgopbm1v5VxA5FJcTJeX4OfVCTgnSd3+a6oJDUEbLXgOcHFJBoklY2cfLWHxGRupSwwI639gjOXALScIqY186+z2kzDdPBlbOPeBv0eXf8vj1/2jt5BnkPrW1vmTBtpNDbCm0M0ZTvFBBfnkUogVv+XkoRWykt/NwECm4H/+/+rbfPWzzESzdIiu5/yM5/IEzJIeO16CYKhSMfBf3XIpdbZuZoUHOUWU9u24Kq7zrLy7K7ahWpiLWSRc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:CA;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199015)(36840700001)(40470700004)(46966006)(316002)(4326008)(5660300002)(110136005)(54906003)(8936002)(70586007)(70206006)(6666004)(36756003)(82310400005)(41300700001)(26005)(86362001)(2616005)(426003)(47076005)(36860700001)(186003)(336012)(40460700003)(478600001)(8676002)(82740400003)(2906002)(356005)(40480700001)(81166007)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 17:30:56.7013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a50fd04-5bbc-4d74-23b8-08dadec22005
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Xilinx Alveo U50 PCI card exposes multiple hardware peripherals on
its PCI BAR. The card firmware provides a flattened device tree to
describe the hardware peripherals on its BARs. This allows U50 driver to
load the flattened device tree and generate the device tree node for
hardware peripherals underneath.

To generate device tree node for U50 card, added PCI quirks to call
of_pci_make_dev_node() for U50.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Signed-off-by: Sonal Santan <sonal.santan@amd.com>
Signed-off-by: Max Zhen <max.zhen@amd.com>
Reviewed-by: Brian Xu <brian.xu@amd.com>
---
 drivers/pci/quirks.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4944798e75b5..5d76932f59ec 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5956,3 +5956,14 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, aspm_l1_acceptable_latency
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptable_latency);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency);
 #endif
+
+/*
+ * For PCI device which have multiple downstream devices, its driver may use
+ * a flattened device tree to describe the downstream devices.
+ * To overlay the flattened device tree, the PCI device and all its ancestor
+ * devices need to have device tree nodes on system base device tree. Thus,
+ * before driver probing, it might need to add a device tree node as the final
+ * fixup.
+ */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
-- 
2.17.1

