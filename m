Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0A3771F4A
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 13:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjHGLH5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 07:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjHGLHz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 07:07:55 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D756B10FA;
        Mon,  7 Aug 2023 04:07:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRu2d0p4h4Egibjtzjg9ORmqQACrIxhEdqJ9q5frUjtdiY+PRWP544ZCA8D4JqmGUlCRUPzC297kuvrM7i5eoY567FUGjbTcgP4RGpHibKD7dJ5cQ2XiE4AF49IqK8HNvR3cdN19puqx+k29snhSn2QkoKTYEj7sDWk6K4UZVYH0UXjK61cAfwbqUpPs0MvNsfsV7/mhcnklgFyMb+SAzfa96D3Yh5KZC+OF8oD/ywLznghcuJKLC6YGX/DqiASll5B7lHiDV5MhwBjc+96DbznYDjyGNw9/Hs4ibrWh0SF03aMLSBLHi4Ip9c4VsO67+AZ2CTLYys+syCKbtdgLOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XapXdSHjTSQE1TBJ8yLdHwqIt9W4MuvhqBNTTPne2k=;
 b=Zb/O2CU2IDHLWut0utxaK2ehnmxFy9HcN5KAGSgXUlbtg3hJBcVixguUkx2efNdQ7lV6hk3OZpGUCulkfsLYu6VVYDqMGvaWSEiff7G6Atx4KoAj3iGAfIe34nnOJGtvFqSDuqT/xn6trXilRZ87C5ZE9yxPZQA6ymKrmCC4RAKd5tSnVMGMTm7u/MsQVZxwd+NH4EBRH5w+W9u6iheiE6CetvFmEeuvBzcy62J/fF0qrJQXSY5jgd1j0P4AvTRu+iNK1zcB1RzyUnSjQD/xWvd9eNKLWKFXxdCnnHTjxZ+hmyTOoUsuTL9Ai/QxWm2TYskq6lMBIZoMz7CIE5N90w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XapXdSHjTSQE1TBJ8yLdHwqIt9W4MuvhqBNTTPne2k=;
 b=o5tP5fc+73gugZgfNycKHV/zsARhEDLgewE5mkz2ATj8Ud7U2rX6/YWrxPxlm/MIibVZrGfWupymxc+OvHCCbBcG2mferWKC5vO71SSbTaakNrsFAl6oX6t7e7ctHE6zayXJjGtn0Pxf6ad+XdLgn5++MDauy8xu13oxocic0tg=
Received: from SJ0PR13CA0176.namprd13.prod.outlook.com (2603:10b6:a03:2c7::31)
 by DM6PR12MB4545.namprd12.prod.outlook.com (2603:10b6:5:2a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Mon, 7 Aug
 2023 11:07:47 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::ef) by SJ0PR13CA0176.outlook.office365.com
 (2603:10b6:a03:2c7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.16 via Frontend
 Transport; Mon, 7 Aug 2023 11:07:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 11:07:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 06:07:46 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 7 Aug 2023 06:07:43 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <lpieralisi@kernel.org>, <bharat.kumar.gogada@amd.com>,
        <michal.simek@amd.com>, <linux-arm-kernel@lists.infradead.org>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH v1 2/2] dt-bindings: PCI: xilinx-nwl: Modify ECAM size in example.
Date:   Mon, 7 Aug 2023 16:37:33 +0530
Message-ID: <20230807110733.77364-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230807110733.77364-1-thippeswamy.havalige@amd.com>
References: <20230807110733.77364-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|DM6PR12MB4545:EE_
X-MS-Office365-Filtering-Correlation-Id: f85c3ce2-fb7f-4f4f-9bc8-08db9736896a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uIlWsNIvrXLHhsFhC2p/S4AsrAOsF7gkJzsr0Z8WorSmCVZyPs05pTZL+CgRtu78lEjZQiL0hA9LlClclxge0Sh57Z142PK23AolA7UQLpkWbpxXOGyCjkUbg8xw1KaMvNBm7pf/6/Q8KyFRXhs1VYsX+2FB6cVxlkiMZBbElnRO3DyEmUIZLB861kG5iXSwkZTJouZek2J0HCIm1kQb2faLi1Vux7ILzsNvL/4Fh0Gh4tT3a/tBr6jkfMPxnvdu7R7114nz+3UlExWj2EVcD8geJf8BuHkQsfCcoOyNGXk/nhV4V0uCaVI+mfe2+YiDfXgd4cT3oDkfe7xlcIvCxNoIgCN7ub8I/tSxy43xWiEy+8zKRFZdYaBI3TMlCQ4XzJ7vdvOy80VjSjYLWh8KBnb1wAsjEgW3l7/81b9u0+iV9BMJV/JpQ7Tzl7LW4CQCeiqo39aZK2k82+sfmHYsgIe74JrNG5wCqEh2XDjOjuz7se9iztjHRUWJ96iMhEzqBbCvLzqLIdJN0iL70UUxgxI/getCNFJMEkUyj+2BRzrNw4/XV/RfcA0NgI/RuQesDUkkq/fQtSa+Ai7/W/fuv2aL/sJTbtmdOI2OXdNQbQ5KbU/YIAeeE8auTpq4HpT5/oV1XYM5hhZRBfhLKrcyZ9PBj8hqN2NYF9aef4A2I86XJSducbZMiiKpoU5x9NGfzYzUVYREwT0okqEU57zd02G6DVR0Q3hZgjcbih5M8vzu8hRjqIC/HoJrfCy6juoCX1f+HGn+z/4YGYTpjwuydg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(82310400008)(1800799003)(186006)(46966006)(36840700001)(40470700004)(40480700001)(26005)(1076003)(40460700003)(36756003)(110136005)(54906003)(44832011)(5660300002)(86362001)(4744005)(4326008)(2906002)(70586007)(70206006)(41300700001)(8676002)(316002)(8936002)(6666004)(478600001)(356005)(81166007)(82740400003)(2616005)(47076005)(83380400001)(36860700001)(426003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 11:07:49.1144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f85c3ce2-fb7f-4f4f-9bc8-08db9736896a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4545
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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
 Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
index 8976025..426f90a 100644
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
1.8.3.1

