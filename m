Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F057C9E8C
	for <lists+linux-pci@lfdr.de>; Mon, 16 Oct 2023 07:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjJPFLv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Oct 2023 01:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjJPFLq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Oct 2023 01:11:46 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A25E7;
        Sun, 15 Oct 2023 22:11:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFqELoRoCRW36wSBsZMgSRUR9tmzf5gvXNQiha0sXMj0PBlW4Ms8gRLJ6rwm21daK/4YZbz5OwYCwL3Nx4cM7B7Xo0O07gsU5y6YdabUyvW7d7NpxM77CAygCfoPmER6ZNrF1pjag1CItjVFF7z0QJqrlC4eS/YUO2Z47lU3OVFdvjvMzfhfPkHGh+Ij3kE+f4vIHHehEUwGk5fYNUTPayZKa9h3PRdXPDbxS3DlFD9SzulyhQwmIIHVMBsQuIBplYwl+7jk0B7ZaWEYnyDZdiwjrnHCLvyx7Ju12GSK2Alwk8T2z+O3VMyxRGAZO1vbSbdCwYmFm21i42Dq1BMoQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aljHyMWt8R/QLn5d6xJ+f8RBv6t6/Cj1hmwBAKY8Yjw=;
 b=Ix96ZYmqx4GboqayLaPcSLvLoaIqz98VwF/bU3RY6uCfhGVRrsx40kbZP4QlcMkCBI706LNhBSTlTRYw77RqtiX6HeVvUCi8MB/WRgYqyqnN4zOpoR62r9DSXeIuCo8dauDmySXwGHTki2HQd93tNzmHd2X9Ut7WZaXJXiYtJpTxiYiJr6RE43h5s/iPjoHIAuzbSrr7Qg1jiNRgvbRy4DWZ0CEERcnTIKoOEC3L9ef4kkOTBqLVq5vWs5XaKagMT1hQtKk4g7+UVvCYcWvF0LFKLm+oLg+Wrq7sNm5QnrlE8A3zv3H0il0jY7RGDRU8EPGo/jSaY0bb3jyLaD+XfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aljHyMWt8R/QLn5d6xJ+f8RBv6t6/Cj1hmwBAKY8Yjw=;
 b=ILF8PN4y25ToF2JReJ1IPbTQvj6rEvs+bFEgSRcuAqumBPE2qI5l1UYRUHO6ucBXnIloIvCiQYp9cggR5V3DJs3jT2w2pXEs/1mF1hVV5uezzgIcPKwerfwm1UL1rdV3Th+WUgykMWz/tdr9wfTUQ+cPTFyhgomSFl6FLp5j+6w=
Received: from MW2PR16CA0012.namprd16.prod.outlook.com (2603:10b6:907::25) by
 LV2PR12MB5822.namprd12.prod.outlook.com (2603:10b6:408:179::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.46; Mon, 16 Oct 2023 05:11:41 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:907:0:cafe::9b) by MW2PR16CA0012.outlook.office365.com
 (2603:10b6:907::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34 via Frontend
 Transport; Mon, 16 Oct 2023 05:11:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 05:11:40 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 00:11:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 15 Oct
 2023 22:11:38 -0700
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 16 Oct 2023 00:11:35 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <colnor+dt@kernel.org>, <thippeswamy.havalige@amd.com>,
        <michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>
Subject: [PATCH v5 RESEND 2/4] dt-bindings: PCI: xilinx-nwl: Modify ECAM size in example
Date:   Mon, 16 Oct 2023 10:41:00 +0530
Message-ID: <20231016051102.1180432-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231016051102.1180432-1-thippeswamy.havalige@amd.com>
References: <20231016051102.1180432-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|LV2PR12MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: 59bbbbd7-e4d2-478b-14a8-08dbce066199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4BahLIGcHfjzaD4rCH1nFzCA5eVJyhpSPLa3REcI1RJQYruzBuotnNa2oFNW7T1pO/lzkQXy4j8sjFR7yqaa5GAWoy/50BNrPGZN/xJ0fPGSbtzmjvs9vuVVkBk0n/PYrbShVugxExJvQYuaHOX2oBwlSokHW4eI6E98vyM2fENv8cRSUx29rWoAhbHtwDUkAGGO6q6182g3GZB94UEFwC6eSVum+fRjCMOzHsy0KvurcLyi4DuNe1Sve310lGjyO54lyJFThdOa04N5VmB+nA85ryVkIxfJRB6yBHZB4gfBebsJMrQJFJ906G2w/8gDLvhppehcuKejOPtBVRhv3WCXtgKvBdi+oytYa4q6pN3aJFzZX5n4bu56i66UCIZJimjJ1Yfu56zKyeX2WXhDLpVys3o/AZL0wEfSjX0wQRjWfrWuMsN9RyqLPgWJYqcHIKJxKrOUkKZEQAHbudDSqAhDCTF6GMhpaVeKip5+n6hXuYkCMYIWtfYqLYjXRQ/nfwxmdP4Tz51SMUrbjAj9FTfVj0mFaZH6ePUJWY08CpZSmdER5hV2dJK2LpE1B4JFihH3DVXjesPJpEe7UCJN6REeifCiKLSKitxDXPGe7OAGTjxY+WWXmHdwTsYddC/0O6z2/y3ivqNSe3sn5LjYy3HW21iT9TsRffXkljA8P8dSfvq/TWEw9QzZyZxn90mYkiNIkFDa9eOl4LrBmNY4/2id8VuwLF4pYmzCfPh3hur2Ktzcl7Sth44ZEABpRu4Yfv07gDrhokGqaWteP1m7q6d6vTUV+Ek+J7cUfTxdjS0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(82310400011)(186009)(36840700001)(46966006)(40470700004)(40460700003)(1076003)(26005)(2616005)(336012)(6666004)(47076005)(83380400001)(8936002)(8676002)(426003)(36860700001)(44832011)(41300700001)(4326008)(5660300002)(2906002)(478600001)(7416002)(54906003)(316002)(70206006)(110136005)(81166007)(356005)(70586007)(82740400003)(86362001)(36756003)(40480700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 05:11:40.4042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59bbbbd7-e4d2-478b-14a8-08dbce066199
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5822
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

