Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F789777818
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 14:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbjHJMUe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 08:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbjHJMU3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 08:20:29 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939C8E54;
        Thu, 10 Aug 2023 05:20:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZPMDw2IPzHkRqktds6vyBd9Pu5i/++78y6sCdlf5CT28AdXcHK+O3dvWE+RGWxOM+/tMRJ18vm+HdwcykwtZYc3JmzOWZPvWNYw2TDhJ+MHo+aEt13C14oM5VQPSBSeBhsszB1psqZxsifb6+d/wQdZXgh6anW2euhpapniIS7zHK37gAiXgkXFD/mC1ePyEZS4fnWJF03YAloV3rEJa0iVojP+1FEtIc1ASBVN6Iu8T15Hv+GXdPQSV8NRPX4tYr5DsTywlGCbDU1BtNfZdh97RzEcSMVkDxpD2GXca+EofmUo2Oq9bOvEx9o45guxVWrRmltTAGR+WOHTMX9fsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3RQccs+rJsWqxvUxiHtCw96tfbR1EmeNVItWz449Gw=;
 b=oWcldxKimyHbwEVb5DlXK9Uv/rNphUDf23RXPMjiSGHoJ0nYUgX+Q2TNULM5/Ajr9qQQn8l46CD0QlGWmOYTAolnyPZWXq/8O4Tp3ML2Wz0/v9+yf9J9LeTfiT6S1mhEod/QpbyYFL3TerRS4+Lghxt91Ul7nATs6M19VHQmiQkKm5a3qOFF0IUdytj/240kDOSmBO9QetJ/rjtwkZuW5SZuwYLFCv92Xt0y4P3hMtoguf94knjiVm96PsMMlBkyjt9uoPnttnmCF1nlsYLpflNh8pM2NU3s5LMsykawEGGcn71YmRzjupJx6ve4rdDkLgThNugLiWXOdBcbMJwSzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3RQccs+rJsWqxvUxiHtCw96tfbR1EmeNVItWz449Gw=;
 b=mR+rBV7EhM+nm8ZdSwRYTgB8kx7CiOR+rT3XgavOtzK7PEcqL1gghFAJv070x02+xrSqHV84bMywFXXW9LpzKDjs7XU7/sFf5ZkkrLtW0+GWfj0jD21yj1nWna+a8pWb0kdZc0yxziev8ppPPMYKy7jIea84LGlikbGQv+cOLXA=
Received: from SJ0PR03CA0131.namprd03.prod.outlook.com (2603:10b6:a03:33c::16)
 by DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 12:20:25 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:33c:cafe::9c) by SJ0PR03CA0131.outlook.office365.com
 (2603:10b6:a03:33c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Thu, 10 Aug 2023 12:20:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Thu, 10 Aug 2023 12:20:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 07:20:20 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 07:20:12 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 10 Aug 2023 07:20:09 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <conor+dt@kernel.org>
CC:     <lpieralisi@kernel.org>, <bharat.kumar.gogada@amd.com>,
        <michal.simek@amd.com>, <linux-arm-kernel@lists.infradead.org>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH v3 0/2] Increase ecam size value to discover 256 buses during
Date:   Thu, 10 Aug 2023 17:50:00 +0530
Message-ID: <20230810122002.133531-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230810122002.133531-1-thippeswamy.havalige@amd.com>
References: <20230810122002.133531-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|DM6PR12MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: c0063d96-9f8f-474c-39db-08db999c2cd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JEd5peJLsSO454pGgUAZJ5tv2rui0M7cgoInMlfDAwi6tHzQ8S0My9pqp1pL8j0k/VCBlBiAV7aru2itg8nHkhDfwmb9qx1405ooApwT8EogqfpgXYP28aZHp8SiEaMao+ZrLmT1e3TLlyMkR/DEq1Xt0rQT2/Z4pHvrpBDsKtR7zfQI9b38Ehv04urikJRzc4N7iafdULl5Xdhhv+ubiPecuROJ7q7s7EHKBGppJhoCszqg4wliWFtWEt/UiXlLJqy42dejqa5j6rd9X31kcq6zZbqdeTJudvv6JBEpfnet+zPlJMbcNbstt59Q2aOTZmp1A1JjYxOISbLjSadvCkTH5w7z6XUZVG7idbvycB5XZAQJM+I/jIW40CzwC8+FVdmKTi5pFjA3Bv6ygag60Cgvg8ybHUZXFI3tRIA/Kfiv9HDiDsRQpyu/FhxhSCXGsyM1YJPHUtL3LYZCf+KZWfNZo4BHxH5wlatFqqwbayzQnTq7/sO2wA8IdPY9UCRN5Z0bdWMnkxjhuZEqCiK/Bh09dDIJThqkVlXvTz7RNnsF3cOeim3r6qhu6+EuJDJBLopcqgGsLOriCkHuyQy0Jygw3ALiiX+hk3jpJpD2NdDUbGxI0OKqIpDWm8NGC2w174Oo9DthnsVQk6+qTcX+Tj1mNHhET2yUoawUJJa35zUdD31kxKp/G5GWy9i6ahwGAg3Jo9vC0Pl6YvW9hKR78RqVPL77UQDLf7BN2jwgxLmC/UrTjmuS6a5oo/E1JgpA1dTThAcRKantWAhdArvCJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199021)(82310400008)(186006)(1800799006)(46966006)(36840700001)(40470700004)(82740400003)(86362001)(478600001)(54906003)(110136005)(356005)(81166007)(8676002)(8936002)(36860700001)(41300700001)(26005)(1076003)(336012)(5660300002)(36756003)(47076005)(6666004)(44832011)(83380400001)(40460700003)(316002)(426003)(2906002)(2616005)(4326008)(70586007)(70206006)(40480700001)(4744005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 12:20:24.7588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0063d96-9f8f-474c-39db-08db999c2cd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450
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

Thippeswamy Havalige (2):
  dt-bindings: PCI: xilinx-nwl: Modify ECAM size in example
  PCI: xilinx-nwl: Increase ECAM size to accommodate 256 buses

 Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml | 2 +-
 drivers/pci/controller/pcie-xilinx-nwl.c                 | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

-- 
2.17.1

