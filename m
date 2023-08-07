Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA5A771F44
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 13:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjHGLHq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 07:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjHGLHp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 07:07:45 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2075.outbound.protection.outlook.com [40.107.96.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5815E83;
        Mon,  7 Aug 2023 04:07:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kq1n2w4C8h/KPWgmDWGzz+w2xkoK+8OMqkTWYY+7LMusrZOST4bRUrxTTBMDDmUIRmx5kZjnL4IhiuFrWqrtDGbJngXbm6ktAfilQ2Pvx5qtSWFhAgnaTU8VGAr9Xce+s/lUxH+KnnF3gUjDLlGdmbyNF3nhXzwV6wnPFrWX0Mi4ZTRs1FS6yKvgVDns58ir6IcunhFox1zbz8OFvrpZYv82AWsI73Whs3bwZcY1j/UsCybQBAjIG7jnPp5avJ+0w+85clr2t+Eq0M1KO62Qem7sth1xGCJifDL+opFxg79/no9oJt2dpwi6LtHYMpb65f3hpPSiV3t+5DOO/wlh6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqHGZiHzAIRZT0WaAxT7ddzN7HVdYhakLzsPe88Y7rc=;
 b=oCji3gPYznKO5HI7g4eQ0HH7tIMrIVPPJDw4EXRn0PwxeED18aCgiE5rjNLBIbajpMR3SvOo5YOZT11vkFkfb2fD1Khh8gEH6H4quUI9/mox91xdxvSvWJwwJpdrQIl5HXZo/mW05JJjA68iextUDZs3Fm3g9EXmVTGwk9mZYPw532cieacxOFUXn+EFeSTwPeK3wsy9VdLgCXhhCfJeQPGZxXLnPEzpFVihUVRNzDEP+IPIMyc08YvUrkLCqxhUkpIW/ewqptXQrCimTJ5cW8eUn1iW7Ovn8aWW/BOi3kQ2MOHyIpfcCGMcXALzXmG9rXIyULSzDMrhb1eQpA6HPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqHGZiHzAIRZT0WaAxT7ddzN7HVdYhakLzsPe88Y7rc=;
 b=PqD+IDhypgvKPNSl9eYQRXZtEebZ22EdwnuAazccgpMybrxPFsEBi2BnVfGxnLZ410P0mqEWso+fLCc3/36Jchwuf/b1VFYi36luuOw6bqo0ClvxLtlQEZdeUuH0ya/Fqubr7mVF1Ny8qZ1cCa/5pLUwKMBNaGIgJUVlGT3Csuw=
Received: from SJ0PR13CA0151.namprd13.prod.outlook.com (2603:10b6:a03:2c7::6)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 11:07:38 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::45) by SJ0PR13CA0151.outlook.office365.com
 (2603:10b6:a03:2c7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.15 via Frontend
 Transport; Mon, 7 Aug 2023 11:07:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 11:07:40 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 06:07:39 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 7 Aug 2023 06:07:36 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <lpieralisi@kernel.org>, <bharat.kumar.gogada@amd.com>,
        <michal.simek@amd.com>, <linux-arm-kernel@lists.infradead.org>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH v1 0/2] Fix ecam size value to discover 256 buses during
Date:   Mon, 7 Aug 2023 16:37:31 +0530
Message-ID: <20230807110733.77364-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|MN2PR12MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: 01804328-80d9-4ea7-5244-08db9736840d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aRbvURaDixhKwAhIF1iY37nXsGR2L7fD5NFkrCjvRCOqBVZ89xLXCH7roDBVdvENYK19nkuW25OqHo0ER7/PK9jtQ+MTCkdzW+KOW8DDufiCBx+GrX4XJwSqHtajvYCy21ynPJOeDlUPcbq/eZajnIJYDmX5TZIxJaLFpVfKt2eRgAaRPEa/mt3WHohzXOWFwDrRyMdsoDwiclU83TGO23HZTkiG3jV36BLBMeDmX2FrOxTBYS/Wp7WYyjALsV+NwxLMZI01r7VpyeZJhcXKLxQIzzI7l3NRH4G53Kt9XDo72GWeqqc16DQn6/uA6EFlwJOGYnNht6gu314PidCZwNwZuN66D4Q6k3+Wv0LnCNULvVKg/KvGAs7xdPlMdy4omCuZrfwT9jyMmt2DoiCHyp+ZxaPbpgSuWGEDz7uakYIimQp7rOQcNsmcTTADT8JCnbroQBb1s7TfGpSK6yZjY6EeTsJljr7YJw80jmn/X/uLCRSq/2a2ikvGQ/Iq0rDy/oTetS4H/kzLcVGUBugBvpa2jZ4xWSRwhzlvOX0eGGGmmuQnEg9SahBKxPpwkDgRqMcxDR4VxgcX6vTwJjZLZbBJOkby310EUpuCv1+gqXjnG2cqn8Jo6XTsSPQTMIkmbYa+Y3XTiEW6clnfLiR9FOmxgb6GDcM8bm7uOoj9DxiepRwWB9TU6ZNhc/whivcaiQifwrFiSnd18KkebQdFZU7nPW8+LAzftH1Bfv87u7eIy60m8V9F9n4fpSANw+w59cuzR7zEvR7mTEuCAuMkqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(82310400008)(1800799003)(186006)(46966006)(40470700004)(36840700001)(40480700001)(2616005)(40460700003)(6666004)(478600001)(86362001)(82740400003)(81166007)(26005)(36756003)(1076003)(356005)(41300700001)(4744005)(5660300002)(316002)(8936002)(44832011)(8676002)(54906003)(110136005)(2906002)(4326008)(70586007)(70206006)(336012)(83380400001)(47076005)(36860700001)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 11:07:40.1144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01804328-80d9-4ea7-5244-08db9736840d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341
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

