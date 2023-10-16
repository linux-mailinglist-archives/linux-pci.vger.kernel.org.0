Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806997C9E84
	for <lists+linux-pci@lfdr.de>; Mon, 16 Oct 2023 07:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjJPFLk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Oct 2023 01:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjJPFLi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Oct 2023 01:11:38 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF156E6;
        Sun, 15 Oct 2023 22:11:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ME/jJKSD5ezp34DaANXEW4yL9g5d7BeJHHsHZm4bs27+v2d6iQ5ux7G9qfTZiivUvxoNGQ/jvcQC/tQaZNo6s4u3oS5mU6t9H69igCg1v/ozv2WLMwhed14kclMg7dLmZb88EWeMd4g+pInoQX5usVqh2vrABP5NU0NIjaGpplbMdWI895WZyQo+ngLBeKp8+NaXkbo3xnAdOCsStDL6Zvu3MHOwgfWxy7UqyNSjGVfOzWvAZ9OhWi1AAV9R8aVL6gXWo4ufxHkN2wiETZuvuUAE3q8EKGyopEyRdQnczJ8Dh3ZMgrTFKY0ct0yOkiqW4wOgkkx1u6J/ZIyxDWIHeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDp1xSqJUy/X3KgfO2i7a/7rznbyqcW3efpc1pzhCAA=;
 b=gGIm1OSn5VXVOPK42iiRCzOMf4DaMbvFyahIZSu2ZnFNUG3SHzz9N5BBuMHiNnIRyfv7mg/S47P6BGwx8UTTnYvH2jvhPZQmzQRU3/IazuSjbLWi3bqFsZDNQfgxNDlQkoEpYrsA5WXKCnYUZ0NumKX1YfiA+bJB0S07QaUipqNeyiLwVoMnCmAGuFEVxHTPx2aONgxqY1CM5oP5s812LgwRQ2XikIXH6cB01coKBHXMIyolfZHqF7/nXnFSkQ5Fly/BafktUe6V8U28qoHd20euiDc/n+Dl2ar4vpLlzs4OmwXsd2Dw9589bZmJrce3/t6n48eky+OmtreV0pv2PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDp1xSqJUy/X3KgfO2i7a/7rznbyqcW3efpc1pzhCAA=;
 b=4ANPAq5iJA1lVyjnAIHK6eh77FTxUUM/0PHDeYTArWoaZHw/XjFgxSGNtVZ4VSpM7+oLczKLd+iNU9NSsWBiNN3uCCrktyw60n6iEgFAyQkbMQ3ugVLP6HOfmfif+aWLdLCjgDwSaQtsDDxxkLZwpZGBUEgj3xePd2qadMg2dIc=
Received: from CH2PR17CA0029.namprd17.prod.outlook.com (2603:10b6:610:53::39)
 by PH7PR12MB7331.namprd12.prod.outlook.com (2603:10b6:510:20e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 05:11:32 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::ce) by CH2PR17CA0029.outlook.office365.com
 (2603:10b6:610:53::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 05:11:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 05:11:32 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 00:11:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 15 Oct
 2023 22:11:30 -0700
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 16 Oct 2023 00:11:27 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <colnor+dt@kernel.org>, <thippeswamy.havalige@amd.com>,
        <michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>
Subject: [PATCH v5 RESEND 0/4] increase ecam size value to discover 256 buses during
Date:   Mon, 16 Oct 2023 10:40:58 +0530
Message-ID: <20231016051102.1180432-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|PH7PR12MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: e6126713-86a1-463a-2eb2-08dbce065cb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +BGDVzSrgsP/6lx9qiCO0X043FE/RifTO7rTOxQ6NGw9KmlM12fADJSP6HVP8c6Y6atOLh82+eP/8fsu2pNIbghLgjLBTbJ7Dqsd1ykKJ51MepBjOK7qJ/19aa7cxptb0vLnHI4v0QT0h+vVlLgGU7ytTxjSPAwkarzlAhsefsHIkY9gzG5UTKSXqVonLkL4StpRMnwICj/9zNFM+URvN5r+ZTuU/onNEq+uExGnmIvLEyKga+x9Oniaak7fGEHSLqlW8ks08dTDjyczgHaxtZ5J+AO0iAue3qdxabd3fApnOOE8ajVvP+XKBPeuq/GKqOobCPMLRzW1gQTGqt6rpSHe6/ohgXdSRbhrt5QivQxPQM2TV3UAxWq6GaLJTKky0jbdak0ffhssdP9Q7lv/5+qss7cYVy/otzHD2OlgM88THxpwc6rcdZ62FUzyey4AkQX+OavSi2lVfFKLNJ/G1nnwjJ4yVSfj0LZcywbGdgJ7f16B66EmF276Fh7goOv4lXwjLsu9U8Hr3oBQyhch/2VeUAPlvDlpsa4wVlRNOMv7txIVLpVT0G/8CG0f67lJGVZqF05SH6zHg9U7YOFxi+JO8pO/HXlEZjeg4+vDR+l2mWxTzSHneb0G40iWeYNsAItzYvrseCKZLKp81rfS8NkVuuMhkwzYY4aR83aIFIe5UaguUr0dw0U/CNlQkpZTEQZIHd0giCCcTs3k4vAfkUmVAFhlY/X9fblCM/PwKDGfvFS+6TwS/kgamzwEv8mkMboQMlzbW9UVxmF1Z5CzKKsDdbizUKuhFfZX5L1H/mE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(64100799003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(40460700003)(1076003)(336012)(26005)(426003)(2616005)(6666004)(36860700001)(83380400001)(47076005)(4326008)(5660300002)(8676002)(44832011)(8936002)(2906002)(7416002)(4744005)(478600001)(316002)(41300700001)(54906003)(70206006)(70586007)(110136005)(81166007)(82740400003)(86362001)(356005)(36756003)(40480700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 05:11:32.1201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6126713-86a1-463a-2eb2-08dbce065cb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7331
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Current driver is supports up to 16 buses. The following code fixes 
to support up to 256 buses.

update "NWL_ECAM_VALUE_DEFAULT " to 16  can access up to 256MB ECAM
region to detect 256 buses.

Update ecam size to 256MB in device tree binding example.

Remove unwanted code.

Thippeswamy Havalige (4):
  PCI: xilinx-nwl: Remove unnecessary code which updates primary,
    secondary and sub-ordinate bus numbers
  dt-bindings: PCI: xilinx-nwl: Modify ECAM size in example
  PCI: xilinx-nwl: Rename ECAM size default macro
  PCI: xilinx-nwl: Increase ECAM size to accommodate 256 buses

 .../devicetree/bindings/pci/xlnx,nwl-pcie.yaml |  2 +-
 drivers/pci/controller/pcie-xilinx-nwl.c       | 18 +++---------------
 2 files changed, 4 insertions(+), 16 deletions(-)

-- 
2.25.1

