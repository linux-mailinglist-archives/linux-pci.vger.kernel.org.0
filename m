Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0865771F38
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 13:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjHGLEr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 07:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjHGLEq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 07:04:46 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055A691;
        Mon,  7 Aug 2023 04:04:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUOhZk/bhsjKJqMktEH3b8KwuOjoR78GwjfIuaBok+xJHRo1LlU42/wdyfwp551cXa2lVjkGEClAbec0EgCRGTPFZgcU58EJswaQd3ehy+f8DOnDHpfVv6hAKCkU0mjKDX13EtMl7APCvcOBDE7bw8HK8T2NtpGlwkGksQxvbR4ivgaa4lbkrENajM/xGSDwYQb9SYuYMAq9cVWXTLinOjZJJ7uJd5SlxfPZOgTOiQKggnEqUw4EPVKXR4lLN1mF67QenlEpIjSOVF6dU0JlmDI6OvBWeJToWW6HnEGxA75V+ZZuBbYB3gIhiDHgicdGJCl+KCITEgmMDX/99rZyYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqHGZiHzAIRZT0WaAxT7ddzN7HVdYhakLzsPe88Y7rc=;
 b=VlNoWuEdHiC0EDZQMraNFHFY6zLDCBwig88xon2ERUEyx5Jl/H4n2eCi6tpkMf0Hbh88fxIi8UPnaEDcyrOgt63vqqsRdeIOczBIeEESV0mBzb+tn+fPrJkMv/Ed3dh6vB9mSqtTsh6xgZGNHpfpuROrFcev9moj6qpXo3aMwloGQYYFAFiAv6B5ajiP5be/etP11ewNQzDP0yX7USXQLYco3Rhm8mCTQhUjdWZlp3vO6YLEzaA2BDTSipSOWiqBp1YJRwHbnLo4oJVY61s7IVGwr4MXTOl9EdVzDwm6huatNi1zCnI17s6DJD/dfEIHXge2q/talVTe+RPWENy+Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqHGZiHzAIRZT0WaAxT7ddzN7HVdYhakLzsPe88Y7rc=;
 b=vLgYa6QtpUD4VIk9wqTzsgUXD0GE4ptyEvu2fK4cwKQzp++t4SRgajVzzPNs78cjc9NFgsMw9iTr49C+uFGUdHN3rlokx2H2zafIB1zpRgtWYg0xdekabHhD1AhLPAxHtH+hpIK2SSs/I0BjzV5GE1FALGzPfjSqSpYHAZPnnsA=
Received: from DS7PR03CA0025.namprd03.prod.outlook.com (2603:10b6:5:3b8::30)
 by SN7PR12MB6790.namprd12.prod.outlook.com (2603:10b6:806:269::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Mon, 7 Aug
 2023 11:04:40 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::6f) by DS7PR03CA0025.outlook.office365.com
 (2603:10b6:5:3b8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Mon, 7 Aug 2023 11:04:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 11:04:42 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 06:04:42 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 04:04:41 -0700
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 7 Aug 2023 06:04:38 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <lpieralisi@kernel.org>, <bharat.kumar.gogada@amd.com>,
        <michal.simek@amd.com>, <linux-arm-kernel@lists.infradead.org>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH v1 0/2] Fix ecam size value to discover 256 buses during
Date:   Mon, 7 Aug 2023 16:34:35 +0530
Message-ID: <20230807110436.77287-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|SN7PR12MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b65a62-bada-4897-3a1d-08db97361a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kA8wEtrEqQgEPxw3Vs/dlyKwzICct6PID+smSn855uAbKvvthNJbxkw9CWUdFCWu3tLFV1jqNfG3SgMHBq9ZB7UPfwvA1WlmSiiylvej6143ATOG+HHtGIkEt9oFS/Cs1Pfvenn1WT7is7DnQOGN/hYAzox9ML33z4k91XDHM98ZO6JDkpnIThIJqOx52W4xnwW9WyS0bRRRIW8tJLCmyTIK+gyvdFyUfWQxj9QgrC4TTfL8/lsRm0W6EbhfopPMN0XAvhS2PlOO2qB2vx155klo9YPc7K+jscKcykCp5ZZjgHna8SNlhfyGNkitmQAX2XkhhK+QY9bkIIhwOgiJ+tBmtSj4KmW0NfkqIW0IwzSQL2LaGOtImQ4pLsPCgZreXrp4J+hoWGV3NtjUK6ZWcOJexxVDnGC0XgIDIl1sPKABYDbgc8g9KAdMabVoMqUJco/W1CWTYQjHdcOaXLxB+f/0THRssE24ZmQ/qF7lOIY5qeLR+zvWcaO0CkbFIsVIXoM/xGmWEvoxUifhk6VVc0P8qLjUSrKIIn0TefMJl2xjk9Y93sJLOnGC6yOGmdbJVtBhoJELz8m353UzeBknQITycoPNfuaABpZQoil7qCqOGrPNpR9mWy42JcxYGYHAoDjnA239sYssrQQ3S3j606kol/BpAtpwAjReCIAHdHrP9WTjSp0G4VtTOecug0HnuxUbnKBkzySvmCbv3Rd22vcHSRBXBXa+t8Ur1aoD3v89cgAthFumhRhqfzQx9WMVO2lLu+cf044jnZAW7HqHLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(1800799003)(82310400008)(186006)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(2616005)(6666004)(81166007)(86362001)(478600001)(82740400003)(1076003)(356005)(26005)(36756003)(41300700001)(4744005)(316002)(5660300002)(44832011)(8676002)(8936002)(54906003)(110136005)(4326008)(2906002)(70206006)(70586007)(336012)(47076005)(83380400001)(36860700001)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 11:04:42.7194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b65a62-bada-4897-3a1d-08db97361a4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6790
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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

Remove redundant code which updates primary,secondary and sub-ordinate
register offset 0x18 in type1 header.

Update ecam size to 256MB in device tree binding example.

Thippeswamy Havalige (2):
  PCI: xilinx-nwl: Update ECAM default value and remove unnecessary    
    code.
  dt-bindings: PCI: xilinx-nwl: Modify ECAM size in example.

 .../devicetree/bindings/pci/xlnx,nwl-pcie.yaml         |  2 +-
 drivers/pci/controller/pcie-xilinx-nwl.c               | 18 +++---------------
 2 files changed, 4 insertions(+), 16 deletions(-)

-- 
1.8.3.1

