Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D727BA71A
	for <lists+linux-pci@lfdr.de>; Thu,  5 Oct 2023 18:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjJEQuN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 12:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjJEQs7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 12:48:59 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AB2A6;
        Thu,  5 Oct 2023 09:41:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDT7PPEHwFeBNYWbzscAt95VPGKoTEjHZqZVgGa9D4RvjQrHIA/ur3WDKq5zLwzKEIaNjFzltgrh76NznhgleTz0zTM6xtZB10mFFkT28+nJuC+BBYZna/8ObGzTT6cpfo1t4P6aoQ+YrJFDGla2v+yflCbBkDifBD+aLnzFJGi1s5qStITddZOj3I+FN7AJRZ8CmYjU6YiZetP8+/DvOgCC7ECWYfTkCFDPWbIcVMHoxD4XhkaIxWshR8N1alVd9MMAsfydmkbPkaYhhmOWwWEuWpxWbyTK7cXKg12tRJfL7U7nL9ZIq+HWrCY2i8TD8VQ/MlDiPL1fERL9G4eQig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDp1xSqJUy/X3KgfO2i7a/7rznbyqcW3efpc1pzhCAA=;
 b=PotOJMU8i3aoVROGSG1HcymnJWJUv+aKEmmlzM1KK6BICHRQd9j9wTUaK50zAQG+VTHmArZDaEvOVDwDGkfugcMjHjzgsfHDHunxAaU4BaLrSBR99ZcW8bVeD+kBf3xzwM9JuO1s+1jK//4xg1oWEuN4PdyqO9SqXYpWwBFb/4tg4yfMLVQJQA08+vDIBiu2mQHKocRwSGVNwQJjk71YXFtBE+CimRG6fSwQfzcYwV/Y/8raeYwBG/ftMzujYkVy5TWXDYLwJ4wemHBt3tKB06nLu6z0GLLobiMVysZtzhyoGBlPsADBjzzoG7Bzb3bzmcSV5fUNKIH7L1cIyjciDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDp1xSqJUy/X3KgfO2i7a/7rznbyqcW3efpc1pzhCAA=;
 b=kg8KlkaVTj1GF0wfuaYquAcgHeG4kWvaG1++ETZLcmJUgsOtsFCUiV3gICokm9iO/qP7OaP5OLhNDGdZ2SAzaFf96+4li11Q8INI0MjusrrZtoiWmrsBkqHHT1DdHokRi8UJ6Rk3bD9rTP0IF2xY21n6yU1TEGpyH0BO/kIzhL0=
Received: from DS7P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::22) by
 SA1PR12MB8841.namprd12.prod.outlook.com (2603:10b6:806:376::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.33; Thu, 5 Oct 2023 16:41:53 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::cb) by DS7P222CA0013.outlook.office365.com
 (2603:10b6:8:2e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37 via Frontend
 Transport; Thu, 5 Oct 2023 16:41:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 16:41:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 11:41:52 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 5 Oct 2023 11:41:49 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <michal.simek@amd.com>,
        <bharat.kumar.gogada@amd.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH v5 RESEND 0/4] ncrease ecam size value to discover 256 buses during
Date:   Thu, 5 Oct 2023 22:10:47 +0530
Message-ID: <20231005164051.984254-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|SA1PR12MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b205d80-53c2-4a7d-1d30-08dbc5c1fab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dnxP2bIq7omJ1yo9T86PcCJ2H04IBYLGe9ccojepafgxlWwIQVrWsppVc9BXM0+QjfxBL+OYdWlJWwuLDWkWldE3MGxrU0+Dwfge+UJ6WPT7VX+ihH/KhobMtTSeKgjBOKUWlaCVV932OICpQZ/1qiuJMUwvjpYGfu2wTKjDsVheB4/y0S+d4QhMjb0pvUwSIt3/Qk+55y9zfK4SyIYbGeRtHEcoviZP/NQlvENfVhbUYeHLcakketjphuP0qSoRpcTEdn+n466tf4m7Me5mwvOLlFllkjthinuUlFwuzvGGfg0nSHo5HD5zIWB+ectLa/0YDPkiQPVt898srccH21gJxjkgVAQMqhtww2asr4NxcKAueFh9pbfTLn8fFpHADhRQ3u86TNSKTGJM8/NB5FTImWABBYQbflVvWdSImbC3c7ZDc39U5/5Fd1OmuwCBUoyQVsd7p6PIwfdqpiLyw4B3ZdllrDRjMvL3kdihvOpVw9vRqG1ptt7kxEji1AywQ9P6F1ExAa9gKqQh40M32j4fydzWsur62OC75ySbXyLMHRAi3j6H/jf0E7iaL+pMQbYpPyebDZ92P8uULjk2W0Shvh8QUhl4rGPCiEbgYm/AqiEyjHdMuqpUfJYV5d84opDZlSNvwrSlruv024Ai+dWFdoTw3YXqB/+IleUWhwxi9/hK03/vI0k//LWCbazQgnU3dBbc5jAAHj9U3/xwYt0s7itpLZQDP0lcAHGla0vPPXhaAQwQCZrlHBcQVJxLt0RlMn9OI9riv6nJppQlKtE2L30ncItNwDLO99Wy/Fk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(4744005)(47076005)(2906002)(83380400001)(40460700003)(7416002)(82740400003)(86362001)(81166007)(36756003)(356005)(36860700001)(40480700001)(54906003)(316002)(70586007)(110136005)(70206006)(41300700001)(1076003)(2616005)(336012)(478600001)(426003)(4326008)(44832011)(8676002)(5660300002)(26005)(8936002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 16:41:52.8005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b205d80-53c2-4a7d-1d30-08dbc5c1fab8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8841
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

