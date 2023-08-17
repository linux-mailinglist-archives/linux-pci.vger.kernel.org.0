Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B5977F615
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 14:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbjHQMLI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 08:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350734AbjHQMLF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 08:11:05 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on20602.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB22271B;
        Thu, 17 Aug 2023 05:11:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPE4SEUyjsAFN6/+4BiB4Gvk9JBfPBQhw+Koewm82ml5QjqW4Ku44YRVzcZ4MBoj4QZzDzZ6LxAYlXjaYyktUZEBix7Pi91hOqApu9bu8GYtZMKNEVnKLETEKMILKEDfTMHyKdjkt8WtqXqPhjkDyBezr7AtpVirO3yurcNLA0EPkW9HeXICDwepjQiwZaqxiLOqcuq+xA4nwl8bsuO2nkzoXZfXSOyqs22kma4gC8mT1a5oVvU3f/C/K9UK76jhTLgrx/R0LU3oWBM7Q+YK1VT/gG+a6YU7sG8Nv7spwSWofWbIFwliCT0UnNntd4CaSCfojwk4MVphpXF42FOjzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTY9MHftp/fagc+OdG+dGwuu3MU6QZM2vHdAeYsacEM=;
 b=gvs9k+7e7iv/tBvmTaZOW906jqafLSZ9+svmymTtc88QZsl7dOVdndnH8M1RfdJqPo/dwiiYXUiTfKcKVj4xzjz0eMZuxY+Y5y6QIfVawzOivdaw39P19PmAyHFkHWjeIYQaVTZ14AIzHCp8yjscly/gZV3zqSejMvj/8QJam/4ivf0NmumKzbJ52PVvgw057i9+SB6SM0aK6bH1OOffiQbG+cPA6uaee1uGQH+/YuagHrlgpdwVwrNTs6A2MnuTTNwfYoUNa2H2rkrV5jbiUye4KAGTNyHSQb6Soj/vhkaV6WNaXLdUeYPRFFIRyuejvAg5P7b+iqnIzs/AvvyaOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTY9MHftp/fagc+OdG+dGwuu3MU6QZM2vHdAeYsacEM=;
 b=m0djX0mAt6flsNB3RyJKULcDnKv47Gl3jFMui3vP36QkNmayi50FkbG76OasBRdrXcAAwbhaXQWWThjnOddrsxJw0cl7VQAUxsB+1s+ypYNLTVOl4yFjO5lffq9ZGPUgcISc0CnheGANPGf6krDyjR7zS2Up9Vlw5GS1itKh0M8=
Received: from BN9PR03CA0337.namprd03.prod.outlook.com (2603:10b6:408:f6::12)
 by SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 12:10:59 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::8f) by BN9PR03CA0337.outlook.office365.com
 (2603:10b6:408:f6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Thu, 17 Aug 2023 12:10:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 12:10:58 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 07:10:58 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 17 Aug 2023 07:10:55 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     <bhelgaas@google.com>, <robh@kernel.org>, <kw@linux.com>,
        <linux-kernel@vger.kernel.org>, <lpieralisi@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
Subject: [PATCH v5 1/3] dt-bindings: PCI: xilinx-nwl: Modify ECAM size in example
Date:   Thu, 17 Aug 2023 17:40:42 +0530
Message-ID: <20230817121044.8176-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230817121044.8176-1-thippeswamy.havalige@amd.com>
References: <20230817121044.8176-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 1969bbe3-8072-4b9f-c800-08db9f1b045a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H9tv/g1FrfNaCpufAnt4gKM2kn06Q2tl9PTTRA4nHvo7Yr0ARWof0knQIiFWaaKp+6bmhC8L7gJQPxeXVUwXjjahzQ+5lODcDYwhauMatJg6h7SWxoKrmxnWGnBcqMDqs5Ot0GdCkpSik3aUa6X8QheUcB1rSiSkqmGpQQz2v5vdNDrrmUPx8IRU32TOB6ytQ3JtTAq2bJGMOQcycZ/u1gJwCaDC6JyapzF9rn7upCVZO1zBpNqKP1ztHZY0bHMBGbDgfY8qThb3wTvWAnOYjb8oomfIdgvwOzjpAmVaDGK2zWIinK8xYg/7xLztphkVAIMD5RirScDNd7WZaCTzrBLeJB7F/ay9EDoI9dEhpW9BpLTlpKpsdHXql/8JWT4p4Gbu9CclHfY3IBqsTVaZ7+oLOGKS0ZU5KTRbRrcz8OvgOotSzYSOFNXmNt8f3oacZ3aAh9MTw4kOE0dT0iKwNmh6zeXHzFNXd0rQH52ovrXHmk0V4vlpUrGAxmskomd1nypMpNBa9SI60GwWQrb5Od6x2m5LLfXGp13xhCiEgTQDE40sF0HNF9JJeB8QmyszMRY5UUaCIIhs+xh2BbgpcqJ5whlZqOrs3fZbQaBGyrDN4IyIypO0pSYs3nM9mYpDEc7ybhFX+VuhJ85Ac4FBcS9q/u4gnU5/LuueJu6IE9HUjxon3HC5bMYikZWJMyIa3eOaP9p+6OXpoz9QHWRMTuDdWUf9F0YbakGutSHrZj3N6hOHrsU8bDG8L6DoImBuyHLcMLARHfRsPBwRM1gEW1wh/jhbrdbPsokPsq2lYFc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(1800799009)(451199024)(186009)(82310400011)(46966006)(40470700004)(36840700001)(316002)(54906003)(82740400003)(356005)(110136005)(81166007)(70586007)(70206006)(5660300002)(41300700001)(36860700001)(44832011)(47076005)(4326008)(8936002)(8676002)(26005)(40460700003)(2906002)(83380400001)(40480700001)(336012)(478600001)(426003)(7416002)(86362001)(36756003)(6666004)(1076003)(2616005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 12:10:58.8580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1969bbe3-8072-4b9f-c800-08db9f1b045a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update ECAM size in example to discover up to 256 buses.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
Acked-by: Rob Herring <robh@kernel.org>
---
changes in v5:
None
changes in v4:
None
changes in v3:
Remove period at end of subject line
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
2.25.1

