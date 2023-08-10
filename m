Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD99A77781A
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 14:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbjHJMU2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 08:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjHJMU2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 08:20:28 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAF3E54;
        Thu, 10 Aug 2023 05:20:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+7hotkdkPGfI0rkuIt4w6LTbN74kCu+Wu5FzwKoL5/P/0PI3Y3qiWu3I8HZTbgcSQlJr7pmGujT51ShTWg3CNIxVYNKHpTClmsMwT73zJ0VJWMWR34YpHwvjePUeJ5+1WSzgr61svFS2TbTIL3lJIavbqS7/whLzGttZ72eTlhif/puuwkLKr6EEs7HinevdiPd9dLHwBAmY1Xg94j23HCc456CIRnat8kAg52yTDB7lV0sHsYuDYzoveUl7hit+BoLnpJU+C5kCNranvzKiBOlZ3rFJQ1r6Ei9cIt+0y4MypA0e0OnhcSF+awsG5GCAbKmSUMxsbz9ozqGg5IQjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9n2jDcgFYbaLtwbuNgM34lXAcNOfk+i77SN7Lne6b8c=;
 b=aaH0vGrQDpp9J4CPhNOpwUfbd0P/X53J/gI+QdKjr6sVQ0VzFgUhu7bDcV1kMGj1tr0Vs6Bh1TQAXewnTiRW5OVsS39JFqY6WMzDm5aL5JqJBDrkUtS2cxLZ7fbF+1liv5ea8sEyG1EewYxW0il2yKtMPsNi1p/3En6jetTz1b0yP4Mb9ePgdAzgyCsHM+FA1eG6i6FcS9kDCFg56X6cPPx7E2xWPERu2J7W80LNR1cPh3qk9WOt5DFpQ18hAhEVo9R77CkVfc7S/q4lrPZMkJDrhpcmv2/qzRfiBKs9KtZHvO4/RPyHyoK+iMCfZPto97tXdWGgS3bswGwBygHTKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9n2jDcgFYbaLtwbuNgM34lXAcNOfk+i77SN7Lne6b8c=;
 b=mPIiCtTGafJgGPdsOR5BJNSEUNss54g5mCqa7j/IoshIKPeIR0qdkk/oimwNVMJTHsyx7Hvdjd5cn63jD5uMP9fGEercUGDif+ACE+aFR9MJizkR6Z6zWi+fox+96VdZmCdeXabAkKEYproFth30Fhvx38veRADQ6WtslSvPfyg=
Received: from SN4PR0501CA0117.namprd05.prod.outlook.com
 (2603:10b6:803:42::34) by DM6PR12MB4138.namprd12.prod.outlook.com
 (2603:10b6:5:220::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 12:20:21 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:803:42:cafe::7d) by SN4PR0501CA0117.outlook.office365.com
 (2603:10b6:803:42::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.7 via Frontend
 Transport; Thu, 10 Aug 2023 12:20:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 10 Aug 2023 12:20:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 07:20:20 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 07:20:16 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 10 Aug 2023 07:20:13 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <conor+dt@kernel.org>
CC:     <lpieralisi@kernel.org>, <bharat.kumar.gogada@amd.com>,
        <michal.simek@amd.com>, <linux-arm-kernel@lists.infradead.org>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH v3 1/2] dt-bindings: PCI: xilinx-nwl: Modify ECAM size in example
Date:   Thu, 10 Aug 2023 17:50:01 +0530
Message-ID: <20230810122002.133531-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230810122002.133531-1-thippeswamy.havalige@amd.com>
References: <20230810122002.133531-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|DM6PR12MB4138:EE_
X-MS-Office365-Filtering-Correlation-Id: f4034ef2-16b2-475d-bfc0-08db999c2ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /tu544tuxbWxS8Zb4UypyP17HHwBS/3NT/whngthhwvqskIs6I78UG1FMx6hLJVr6cwKyShKDLD+WFcmf1Yn8+bcxfNipo73jNjwpxRO0g24NAHNM7u+jKKcFdRfjChNX5yM3nLMiOrszZG7dVwgVoU16FZdJ8bY5wG0PL0qU6HDjk+TuT+DWLcm+svN4R2rgSTFDdh3bEndlwvSsOL8UaOLR9ih4ILwH3HCOTdV44DUt+K74JvvnM/mwc5vXNY8GRYJUN9amYed/ghh61ns63FIykxwDPh0VskmEhu/YfZ8Q2KGytH/tiHm5klWB6onDkeXcBkP6LrS7MKs+BykROjfTKWh8nSvww9q5bvqnn3uurn8es4EmQPl2EHe9Z297kcUJ8KChUdeX+gMgrF1ksb8JJJRw4NV7+osLJQv3GI4vRhyrzfAsyxQ/KRkfU5DIP1H2llRgY7+ZIHygP4CE27YjZKZmYNcBz2qxUX3wDILG/QsWaMPNtrEi+GqhCiZPFDmD6wYy0ojiP5Jn74bfMpU+xp55itgttQzouxmfxGBGEzsbuvaAljX45URzLyYRCXd1NrqeoAqE+tR4btbb9eH5XAIyu/aXGAucIis1vykupRtDa4wt/7+T9VjMg+aCR6oDUuyPzoQE9UDIZb1GZ6yHh8l38Z0T9uxRnu5VoZCMBsOh2CWr4SPgpRDXoXWqVCRrF3cQZp3MfEGZOhAcmgLneRNWrijUb5EUHjH8pchgmeZ9Gq+qjN0+6+VRD2xuCtiBzuxYx8o8s8LB399VQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(186006)(82310400008)(1800799006)(451199021)(46966006)(40470700004)(36840700001)(54906003)(26005)(1076003)(110136005)(81166007)(8676002)(8936002)(2616005)(426003)(356005)(36860700001)(336012)(478600001)(86362001)(4326008)(70586007)(70206006)(47076005)(41300700001)(40460700003)(316002)(82740400003)(2906002)(36756003)(83380400001)(40480700001)(5660300002)(44832011)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 12:20:21.5817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4034ef2-16b2-475d-bfc0-08db999c2ae1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4138
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update ECAM size in example to discover up to 256 buses.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
---
changes in v2:
None.
changes in v1:
None.
---
 Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
index 897602559b37..426f90a47f35 100644
--- a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
@@ -118,7 +118,7 @@ examples:
             compatible = "xlnx,nwl-pcie-2.11";
             reg = <0x0 0xfd0e0000 0x0 0x1000>,
                   <0x0 0xfd480000 0x0 0x1000>,
-                  <0x80 0x00000000 0x0 0x1000000>;
+                  <0x80 0x00000000 0x0 0x10000000>;
             reg-names = "breg", "pcireg", "cfg";
             ranges = <0x02000000 0x0 0xe0000000 0x0 0xe0000000 0x0 0x10000000>,
                      <0x43000000 0x00000006 0x0 0x00000006 0x0 0x00000002 0x0>;
-- 
2.17.1

