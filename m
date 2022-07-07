Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6C1569D18
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 10:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbiGGIOs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 04:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbiGGIOA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 04:14:00 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1063532EC9;
        Thu,  7 Jul 2022 01:13:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyIUsDuAWcNTJOoG+AlNPJO2uI8z0G9dVBT8nYC9ZwlCRLeWqJWKqxaNzi+qvUpAstWuB/nz5DhGmsnVjvi427wWxSEDNOrAzGH5JPRM4VEa9E5cnoTdtPBGAn5rPnMl+wZx7DfVUJwBe8iSWQPkWUUNd8q6IuVcqM14c+fDOntJ8LgaV/gsG8wF3MC4eSfGAtfGwccg66Py5xKCQ5qdPAbpFNowdEuyF+Qt5Pj2BvNqf7vhAqKEPfxcX0/XqnPcl45PB5d9yGqgfL6UyEshuLcawToZq8UaXYN1HMpnxcvkhgcN9ds8zyB5lNeldqNmZaTt9n8GMdGVfVNqVzXsSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npcINTCFWBbkJqVItbcULDj6cEaYOlYl695MDWmfn/4=;
 b=KeIihDwZUfXljpL6yTJ9o7bkSDkBoXbchiYh/a9UTyPG5UutAnAEEWfsNE2ZfdRrYydWuaqozQOjrcyUEc88BWTgDZ8PzSdcDvWZsljh/Y7Bsqppns43X3ZdfKZgnPfz6PZSSQmgv1dTUbbKIlCAEAApHZ5Ygyqn0tnmAxp03mQnD/vTjNFB490nAqdXzy2MV7LxXJdCgP3CwfP0ZXZbp1JdcXrm1PRAW7kZ9dPd3D+oiWJwXr6WtSZDpG6J6jCHdoIr+Ycdx2wpf0K72LDGymwc+sRUh+iuacPIMQbeXVkBNyt/vCmKNCXpvpzM2t58tskJw5H5gk5aruZ6FOW9vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npcINTCFWBbkJqVItbcULDj6cEaYOlYl695MDWmfn/4=;
 b=NE0XruJ830Nv+jS0nJsZBKJPqSfmbw0AtigOiwSZXhqJXBm9gvk53ABjd/bt9ACBrGLJPGxICEAmsmFLfhtYhVTaTyJglnw5iJJQqf5xHaqk5KmrArqJPYqPbBpSY5pXTmPIX/GnrLVusfPKbFYn/3pHyip87ljCMdN2H2JR4yL3xHmgVOpDv+HX46RvnDRljP0j1Lw4piYwoJTOo2YLGz0uR72V4B0aIPygWfuu1YtpTmltHjSSxuUdwvoECvUdb9PQplkFd/LVjqfhyJl8eR6GVbglLUCoGFhLLNQ6GaHzdBmi30qQFJnxvNMw0sUZb37q3MVz0z19rLAgEW7bDA==
Received: from DM6PR10CA0025.namprd10.prod.outlook.com (2603:10b6:5:60::38) by
 DM6PR12MB3755.namprd12.prod.outlook.com (2603:10b6:5:1c2::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.20; Thu, 7 Jul 2022 08:13:56 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::b) by DM6PR10CA0025.outlook.office365.com
 (2603:10b6:5:60::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Thu, 7 Jul 2022 08:13:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 08:13:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 7 Jul
 2022 08:13:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 7 Jul 2022
 01:13:55 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 7 Jul 2022 01:13:50 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lpieralisi@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <kw@linux.com>, <kishon@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V4 7/9] PCI: Disable MSI for Tegra234 root ports
Date:   Thu, 7 Jul 2022 13:42:59 +0530
Message-ID: <20220707081301.29961-8-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220707081301.29961-1-vidyas@nvidia.com>
References: <20220707081301.29961-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8c35b60-7e2b-4fcb-21ff-08da5ff0a365
X-MS-TrafficTypeDiagnostic: DM6PR12MB3755:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gUkiVm2MUyJpd4sAkSYO4eWLkiucu1O3TEqarOg17WOpGqPrXGmJU9/MK7RM9GfHrQSZakgEvk/Ukt54235QgrL4enLGbLLkzdKeAV8z8yN32LFbeyOCGw5/DpLQ0mINZTqLUZrDgR9R7sPriGMBpwqqEYbzvUBMEkNt15wXVdZFOWr+tv6j7VtsjJ9aAvpj+B8ErVQqghWlsbOyim2RxkkAd/vvtHK5dDQF193y1sCoR7fwVa6BWFfE1ZdPHag/mg/FPnDUpDcPsfRx/T0LFQVW3xkn2cW2ffRnhhfBIx9nbURIQLDW+sp/dqnUUyHnJ3NJD1VamlSIS2R1AnW3hfCW8lNBc9ogVELSvAlsOKCt7e6I2sKJxOUVGVDtCFZqazTmcFVVsBmIXV5npWcqNvpisUGK3dBkMZXiVCPh+ndhRBEalhX9qniawsO467hRxECaawUxBJoTGIfZBEA0WBG071EGs6Gzg/eRUXsUnFP+oVkyeQd9ObmGSrnOzeXHWKkqmawC92gGHMCqqhgNsaOfKDU+WRSxzbhZ1+BhU+5s8ptoNaubbD2NowvWY4DbdPfinA41JVOozuRGDj/gIFJVBMZgYp7Ibq6vw3QJTXLRuxRiCyk0T98uYNLf4t4Q0cQZAVYiCRW6rWxp+oceoxTZ/MLJUSVPJbhzulELsvE7VVaO5asXayQYQEEnBj65IG/RqpZ3FvRkmhUEOsiExOQ+HgN5OoSJlPaCrtrckyKSN+YE/qkRpVsPYGxCwjwgyF7x8OIx95qcjPlHQ55wFcp0ps/fopCdnZA9RS+HjDbeS0gVSf3pzZVVVL9ASeQp3RK8Dofp/MyP4Cecr6xPBU624lA+t74fFO+ycern4mg98ICoX4ItEJP3os/A5+R3
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(136003)(376002)(46966006)(36840700001)(40470700004)(7416002)(5660300002)(110136005)(54906003)(8676002)(41300700001)(26005)(356005)(86362001)(81166007)(316002)(7696005)(70206006)(8936002)(70586007)(478600001)(82740400003)(336012)(40460700003)(186003)(40480700001)(47076005)(1076003)(82310400005)(426003)(36756003)(36860700001)(83380400001)(4326008)(2906002)(2616005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 08:13:56.3200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c35b60-7e2b-4fcb-21ff-08da5ff0a365
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3755
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tegra234 PCIe rootports don't generate MSI interrupts for PME and AER
events. Since PCIe spec (Ref: r4.0 sec 6.1.4.3) doesn't support using
a mix of INTx and MSI/MSI-X, MSI needs to be disabled to avoid root
ports service drivers registering their respective ISRs with MSI interrupt
and to let only INTx be used for all events.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V4:
* None

V3:
* None

V2:
* Addressed review comments from Bjorn i.e. changed the PCIe spec reference
  to a more relevant section and modified commit message accordingly

 drivers/pci/quirks.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 2e68f50bc7ae..5b532449ac4f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2709,8 +2709,8 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
 			nvenet_msi_disable);
 
 /*
- * PCIe spec r4.0 sec 7.7.1.2 and sec 7.7.2.2 say that if MSI/MSI-X is enabled,
- * then the device can't use INTx interrupts. Tegra's PCIe root ports don't
+ * PCIe spec r4.0 sec 6.1.4.3 says that if MSI/MSI-X is enabled,then the
+ * device can't use INTx interrupts. Tegra's PCIe root ports don't
  * generate MSI interrupts for PME and AER events instead only INTx interrupts
  * are generated. Though Tegra's PCIe root ports can generate MSI interrupts
  * for other events, since PCIe specification doesn't support using a mix of
@@ -2760,6 +2760,15 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x10e5,
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x10e6,
 			      PCI_CLASS_BRIDGE_PCI, 8,
 			      pci_quirk_nvidia_tegra_disable_rp_msi);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x229a,
+			      PCI_CLASS_BRIDGE_PCI, 8,
+			      pci_quirk_nvidia_tegra_disable_rp_msi);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x229c,
+			      PCI_CLASS_BRIDGE_PCI, 8,
+			      pci_quirk_nvidia_tegra_disable_rp_msi);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x229e,
+			      PCI_CLASS_BRIDGE_PCI, 8,
+			      pci_quirk_nvidia_tegra_disable_rp_msi);
 
 /*
  * Some versions of the MCP55 bridge from Nvidia have a legacy IRQ routing
-- 
2.17.1

