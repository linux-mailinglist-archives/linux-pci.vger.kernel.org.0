Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F53C7BA718
	for <lists+linux-pci@lfdr.de>; Thu,  5 Oct 2023 18:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjJEQuL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 12:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbjJEQtP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 12:49:15 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21EC1BEC;
        Thu,  5 Oct 2023 09:42:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4AIO1d3CQWuVIYwgyOcRa0mx4IL7l5WwK//v182wo+mh1ahpLjzgN3gmo9a+abKfdAW+1xhNbuzY+ezisFrnKwEa5VYZfEE1WQq1fLRY9TVx99upu1a6wK7SKsDmJ4XCvp+CUSedM/VCbfLKEP/m3dfucJCeelOfW7P/+SCZLaRGHcRwm7C8S5xZaJpo14bnL9D25YQjfUWqx2P+mJKJOlGNcXO6mvo657s/EHmxjEoi30gzwrPzgWCqyKgOFiZa+JS5CkKjWnNumkLyZsfWJe2ZSitOH0kdApA+movOdWDCoGam9HDlGQtDxYpk/7AwGyz9FHtoWmD9LVzCwO/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aljHyMWt8R/QLn5d6xJ+f8RBv6t6/Cj1hmwBAKY8Yjw=;
 b=UMi9l4xtIjjyg7Z+9ThSvX6mq2H2xVCjGec/ARJxaCryQdH2eAVyKEbBqIzwBomXhZWbqFNErLeMAGxNGjUjZ3N3MBpMXOmrCnv7R8tbXTVfYmxkhmADrOjrxZTLXPaNOCp/FCsjLTsUuxafhr4JttL3tajkmlKzCD1csHBzTXVGgbXMO39bWupTKmfU4ZXpdZEh4BxTa0z54OE8BgwlpCXY+W5DBjZfpVStHu1rFvl+w3cpe9sMncXodkGGY/TvtqR88agOEpUpP5ilrp1mpUnN2mlKkq7HFMExgeHdfjj5ruSDqbnasZ1iO+2GmjlwG4yxf7XOhFvzBa3xg2pR4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aljHyMWt8R/QLn5d6xJ+f8RBv6t6/Cj1hmwBAKY8Yjw=;
 b=Y4gzniQBcGjeWjUsIFzf+wXb+MWO/NGOL8kT3iG+Jvr+Ps9UXCwJeA2JK/72zcDXw2AeGoQ64xr/ci2SvoPbJ4lSiysDXay5guybeetBcCsp+hhgWBa13XN6RiXbGc7RUXgdFUkcHR3g9zIKtMqiwBQ3FzwMdL2Y1fvC4zw9O+c=
Received: from CY8PR19CA0045.namprd19.prod.outlook.com (2603:10b6:930:6::15)
 by CO6PR12MB5460.namprd12.prod.outlook.com (2603:10b6:5:357::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Thu, 5 Oct
 2023 16:42:02 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:6:cafe::42) by CY8PR19CA0045.outlook.office365.com
 (2603:10b6:930:6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Thu, 5 Oct 2023 16:42:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 16:42:01 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 11:41:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 09:41:59 -0700
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 5 Oct 2023 11:41:56 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <michal.simek@amd.com>,
        <bharat.kumar.gogada@amd.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH v5 RESEND 2/4] dt-bindings: PCI: xilinx-nwl: Modify ECAM size in example
Date:   Thu, 5 Oct 2023 22:10:49 +0530
Message-ID: <20231005164051.984254-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231005164051.984254-1-thippeswamy.havalige@amd.com>
References: <20231005164051.984254-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|CO6PR12MB5460:EE_
X-MS-Office365-Filtering-Correlation-Id: ac938533-ca64-4dc3-dd55-08dbc5c2002c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bH/85l1i0zhKstRucMqGfEwPR/sctaJjnatUGWgUiWGzvsHgWZ+GqdOid3hU4ld9X0CNTxYiIRkKpVaWqL+pLLjAVNuApIkYf4xOIHLEpZMW7CP/fWL6qrtlJRDLlMQUKdSyjBMDt1hux5GzBElN+tcWjGD1OlrLVwnfnrNPqXuGUGCTVHjuDWpVtXMOWJYmQoZ46YCdJ1KOhFz/kIchpeJTc1BmlfCoZbBKgnhl8mM8v4Exsn4ERZgSA/lNZ4uol1DmjOD7QVjqPKcDQU8cBI85rPTf+LXKdbY+Y3IFrgOO6/adxXmzifRXLtEXCQzjwnDL0Hs1pHfJgYJbVgurWeiNSMQCubnv2+Gi7XdsJJf5J3fN+tyWIfUFG1TN1qeZXfuc4/K4Bm09Ay7t5fz/4lcsR92NS59DESYRLfiYY8uq30zLun/zIDBwQyXuLx5FBwhz3yo25ZBZiT6JRMWuj9BPaB1hVVh+95naX3px4Wus8r6YzkILD3oD9hv9SoC8xaYmPx4Bqu/WooQqarnidbMie3m4ushEzeOEjUgsSvhhvNUNr+3D/pAoDc7RDgO+p5rQ1I+b2UsssB26pT6kjcRd/G4h1lLBFqIC70MNcajXQ4cxAf8mo5xZLkqDkZMDRZs/oGt2LIQ0dfCfTx4eOldehRigUdvXnhLP+wQHRh4LoGJEf9eEzo3jI9YY0Mas7GRpaViWZrgZbEWY5M5Q/YiH3CTriq4lyLoEYIvIsbp+kyAi+Qylo69aBjodsYTkR7uepqZK0/mGtspV2rlhkL0FiAYHjqP5SFdLy1qhaFQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(82310400011)(186009)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(6666004)(478600001)(47076005)(36860700001)(356005)(86362001)(336012)(82740400003)(81166007)(70586007)(26005)(7416002)(2616005)(8936002)(426003)(5660300002)(1076003)(83380400001)(41300700001)(54906003)(8676002)(36756003)(44832011)(316002)(110136005)(70206006)(2906002)(4326008)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 16:42:01.9230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac938533-ca64-4dc3-dd55-08dbc5c2002c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5460
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update ECAM size in example to discover up to 256 buses.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
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

