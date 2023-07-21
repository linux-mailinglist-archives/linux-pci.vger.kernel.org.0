Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFE475D6BC
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jul 2023 23:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjGUVr5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jul 2023 17:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjGUVr4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2023 17:47:56 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DDDE0;
        Fri, 21 Jul 2023 14:47:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E38MX9oo65z/215o/TEX59gS79EIlstZFjBappQk6SZ/7+WXhH0rnjvbkQYM4Xj2/nJWWsRKhSsQr05rygAx6WZxWoxfE5hsWLtM8W8R31Qk5j2SzLjCvBtVZUj517q+DRR6k5DXCyqm3fHfNW+6LIbKxzXYV4QYY10xiuyY/oDfzww9YBdvhq0oSWMFCiuLN6KiDFZQ2P67pcKA2vj+qNO+NuAhdlYIfYjJPbCwqrcNpAQP2haQ1316cjBLDhVCU5orv0ekYt0RsRKhmfThJx1MdICRJonPFt77T9Ibim4XwdR0LmBw5jjva28QGQK/dMr7V739SMgA7ryTB82vpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7SwQ0oHgUPkpegIrHVCIqrWo61mTFcFQ7woXR8A01M=;
 b=P7qD2MWhK0XRZY+Rz5bYIt+VA/Jv8OkEzP7LnYzKlSDAKfmC22QbTT2uxg5cbJJwksEQMl+ULg8CN0Uh1scA7oMxu48UPCxS99mojXMOCEifoWMqKZYFnx/WG8906eWfD2O/40SH8DWxVqwlWjL87BZtJqtDQORD/YyvsmPKB/v9EcSpBTCU0nJhVElax2T2alWd5P8/pAKfiSupRdmZSbvEhi1fzaAc5mebTy9148jop1eHa1H/ht2CcPSLGUrwNZS/bOVZ41UzR91xxMgXBpbU0He23dOvRyte6jH6ES/NQOS7ebasvkLkpQYCf4QI+wEvTPYSKdWLjYJKNuIetw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7SwQ0oHgUPkpegIrHVCIqrWo61mTFcFQ7woXR8A01M=;
 b=TO6dEdJq7jtIdqnfQnrL9shCmQbEj8FmvAs06Xjz0O9BjGNWCbVrTPD+sXgwRmFaXETwF1KZCjK4MLXuKOgKoKHfrQv210e/oP8SILNhEqHMz9gWklTf+Cbk8YSMrpbCl2M1rCS+iWrAW2dY3NLPVmnPUrXLESJd8CQQnLSkOuc=
Received: from DM6PR06CA0022.namprd06.prod.outlook.com (2603:10b6:5:120::35)
 by SN7PR12MB6790.namprd12.prod.outlook.com (2603:10b6:806:269::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Fri, 21 Jul
 2023 21:47:53 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::5a) by DM6PR06CA0022.outlook.office365.com
 (2603:10b6:5:120::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Fri, 21 Jul 2023 21:47:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.28 via Frontend Transport; Fri, 21 Jul 2023 21:47:52 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 21 Jul
 2023 16:47:51 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <oohall@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 0/3] PCI/AER, CXL: Fix appropriate _OSC check for CXL RAS Cap
Date:   Fri, 21 Jul 2023 21:47:37 +0000
Message-ID: <20230721214740.256602-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT003:EE_|SN7PR12MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d09fe9-8930-403d-a9e0-08db8a3422c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LJlKMI2Sf39hha1yIh0LDsMv6c5kPdx/ZbBpAAVf36BiJtRfx7nGWbPDMa2un6ceaaExxi/naS5QDEGI1u4O2rbJZXNGBzZ9m+ci7gYnM5IpcKxR8pPQWrSsO0MhbabgZwePa6Ikb6ir3T/r/+SQp0wM13TZbXlWpsXAwJmp9K6IoNmkeG0CYltQRmkkpQH7I1hOHRvcH9FGU4Nlx51iMg/aA2pwpZ44pcD576P7i8AFQBbjR+u4xcyCdlPeoseX042zcg2GwZyR3ReStrs9GvucbCzM6xto/YjB+wfCYSW4EofGx9JAyKvG9x9T0NUyzY+qAuIrNIiANWbETrjeolRuAhrtf3rfbz2N/D3DHWZ/cxGkWGeJ++mVkwrQ4CZxsX91MkalEDkx0cAzQTdGfYh+EmmkUk2+S8JPPrtdXrT0qfdhvIZadwsMny2Y9ZcL85lOx0/9RO5SrG8Er9OZN0kcsHgv7CufrYVP4YVOEpRf/7oLz4CnAXweb6W8oSyAq3NR1WAm/NXXBGmb4Gb9X3Ftqrn10twrV2p5wD2l3/LHmMioddOjy64B30SFWdg8HlR2lz5clYxlL/LfJZDf9BZbZ+BuLa+9mAaH+qf5PahptpmEBvqUsflZWXPRq5mr6rSBJ86k+EssowYCvlBl0ikQJM2REZgy76mQDl/+JLdC+OZqaE93m/G28/bChzHi87DUS9MRRxHARcGBd/T309VFHAj9XwiSg4Yr7Q//pbc5K3l0SjuoGjm5QD0g+eYo
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(26005)(41300700001)(8676002)(8936002)(1076003)(110136005)(356005)(81166007)(82740400003)(4326008)(478600001)(70206006)(70586007)(40480700001)(966005)(40460700003)(316002)(7696005)(36756003)(86362001)(47076005)(2906002)(83380400001)(54906003)(2616005)(4744005)(5660300002)(426003)(186003)(6666004)(7416002)(16526019)(336012)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 21:47:52.8300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d09fe9-8930-403d-a9e0-08db8a3422c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6790
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series of patches fixes the appropriate _OSC check for CXL RAS
registers.

First patch addresses the _OSC check.

Second patch moves around pcie_aer_is_native() function declaration to a
common location to be used by cxl/pci module and third patch reuses
pcie_aer_is_native() in cxl/pci module.

Link to v1:
https://lore.kernel.org/all/20230719192313.38591-1-Smita.KoralahalliChannabasappa@amd.com

Smita Koralahalli (3):
  cxl/pci: Fix appropriate checking for _OSC while handling CXL RAS
    registers
  PCI/AER: Export pcie_aer_is_native()
  cxl/pci: Replace host_bridge->native_aer with pcie_aer_is_native()

 drivers/cxl/pci.c          | 7 +++----
 drivers/pci/pcie/aer.c     | 1 +
 drivers/pci/pcie/portdrv.h | 2 --
 include/linux/aer.h        | 2 ++
 4 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.17.1

