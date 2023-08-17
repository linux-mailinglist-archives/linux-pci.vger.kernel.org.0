Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BDC77F622
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 14:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350714AbjHQMLk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 08:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350673AbjHQMLJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 08:11:09 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7902136;
        Thu, 17 Aug 2023 05:11:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDul/3834V1DAGN5oegE+jtiPacQfaOF0vt+somhaC6mI3Wf+B/Sh1L3d8eXZ9QkCJNZFhjVMmD89BqSu5mOEnsujIMSiwt2Ouy5AWsf8005ivIl5Mc6uy1xO3t4KZPIxFph2tCQczcv9H58YJSiFzjclTILiS44G57AzzLEsWFpFAqZ4r5D3yCX8g2EgNCjPFUw0ZKGCoMRNwP/ev+ukjQFOmw+Dzq5fMhdfpZT1lY/4mEj3E9zvpfhGov2IMTd8eHTKFNzmRBNA/e294OEYJA9XWgOea8Yw/FnVlVV3W8fyJ0PWw6Zhg8Mczx9kVJubUNuVScAMehN+aoWTovxmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBJZOK/3Sd/hkz9852w+GyNxaltQ9eMs0gDMLPobpgA=;
 b=HBCrUJo7DPZ/iO0jRVs8EokbDBQj/+a2i+vBfg5BrEkiB0nNiHA1K9xartNmDjD7qXs9nP9CMTOJYoYvvRqKCtyKHs1xv2j7/znQVt0OSEgizX2RfH6EL3YrG+xeaDSXwZ1ViUG2kJNZ/HT7H0THfWVHQMO+XUPTKOwflDq+GsAlNkyCWWA+TuMlmeG/huUX+d/Ozq0zfiJNP2Idw/iCT0K8S21WUnTJH6/EL1SQiI/APyz7uks5pv9aqVFHkKfuoRrfEP8jzqUm0qUj9ip9cdE8djh61/Mh46y5yFhED38WMxtr+PcY+MR+NKg3nxOLBZB+Std0Gy8FZEYsaP0w6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBJZOK/3Sd/hkz9852w+GyNxaltQ9eMs0gDMLPobpgA=;
 b=A5GlKmLV3aPYVQ+HwPE1GpVn8TdlFTEZ49D1URMHu2NJuBk/Cd+KBZcyRCa5pkpUSBSgOLz1EOE+H4juLmDaZbcS3PqDWyCRODRaETj0D4NDzh/NtypcAINjsAKWlgMIbc5oAJgN012jXTQusEXrX9mHt+ReQqdCnBE1avhvrcc=
Received: from DM6PR06CA0010.namprd06.prod.outlook.com (2603:10b6:5:120::23)
 by DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 12:11:06 +0000
Received: from DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::68) by DM6PR06CA0010.outlook.office365.com
 (2603:10b6:5:120::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Thu, 17 Aug 2023 12:11:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT094.mail.protection.outlook.com (10.13.172.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.17 via Frontend Transport; Thu, 17 Aug 2023 12:11:06 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 07:11:05 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 05:11:05 -0700
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 17 Aug 2023 07:11:02 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     <bhelgaas@google.com>, <robh@kernel.org>, <kw@linux.com>,
        <linux-kernel@vger.kernel.org>, <lpieralisi@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH v5 3/3] PCI: xilinx-nwl: Increase ECAM size to accommodate 256 buses
Date:   Thu, 17 Aug 2023 17:40:44 +0530
Message-ID: <20230817121044.8176-5-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230817121044.8176-1-thippeswamy.havalige@amd.com>
References: <20230817121044.8176-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT094:EE_|DM4PR12MB5167:EE_
X-MS-Office365-Filtering-Correlation-Id: da6d1862-542f-4f54-4238-08db9f1b08c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7bniovtrBnps5m6sIOUoMpcaZqD0CthDUgJ1eeLxw1WDEMLj5wMxG0yjiW2IfTQDZbFewt55c4HavytyvQLwPaggBzXfIEnqISQ1YLN+sq0ffXRD6khsLyafjMDq7jEReB/BzzKGHNshv8bkQYYyN9kACuC81MqD6GkOSQ/VMr27jy1Q3KFA7f2e3nDbfd7GBJKE5+tVhcb5sk1dTswyZ+CPd1BbglrGZLV/yRX/FfRKI6gsAPOsO5o54NI2vNkYLg7MWIuizzPiXkbGfdEEWGbO3uWYn9/D7Emtje7Ofmy4z22/e7kFVJ9eiWG/b6F+SFqYSFl6kpC9lropOqk7YZ4Bn8AUxi+wuHaMpQPBfPcjbTg1XbEsMTn63OBmzgFSkbeRKxT3ACxb/hHPGSm2Za/cP7XWpCkmng7u0R5W9yGpGKBySOHzMJeGOT8pZWOP1ynDLQXTAUsIKv1FGcFDUP8huIeUMhOUkZz/h/SjcsO5+d4ldWgROwy5UpBge66h/g6Oh6dUDRxLN1SzwN+8K9K7oyUV5jn9evlwAPhpoIJbzBmzOhRiKGHHS9T5GuWyBU6Z5RCCCQ+qam3suRkUR1R2w5pjMzj3b3CCOfZXdhIeix8Kwh/QE3mpcP6An58zY1OHGAugrxmXnFF3rrq3Sgfug2dWCQWcOPg2PSNLC1fIaXtmcbtiX355c3ztaJZc3Fjgv1g5WhY1X4rpR66cBUbYEbRr7E7yotVEZ82CIZX059GfuSWn2HvxbIxoLqm0kJVA129XDUB6drR/Bu71Y76+M1Ce0iMFXrZLAjniXWo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199024)(1800799009)(82310400011)(186009)(40470700004)(36840700001)(46966006)(86362001)(36756003)(82740400003)(356005)(81166007)(40480700001)(5660300002)(44832011)(2616005)(110136005)(70206006)(70586007)(478600001)(316002)(6666004)(54906003)(26005)(1076003)(4326008)(8936002)(41300700001)(8676002)(40460700003)(36860700001)(336012)(7416002)(2906002)(426003)(47076005)(4744005)(83380400001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 12:11:06.2223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da6d1862-542f-4f54-4238-08db9f1b08c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5167
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Our controller is expecting ECAM size to be programmed by software. By
programming "NWL_ECAM_VALUE_DEFAULT  12" controller can access up to 16MB
ECAM region which is used to detect 16 buses, so by updating
"NWL_ECAM_VALUE_DEFAULT" to 16 so that controller can access up to 256MB
ECAM region to detect 256 buses.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
changes in v5:
None.
---
 drivers/pci/controller/pcie-xilinx-nwl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 8fe0e8a325b0..e307aceba5c9 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -126,7 +126,7 @@
 #define E_ECAM_CR_ENABLE		BIT(0)
 #define E_ECAM_SIZE_LOC			GENMASK(20, 16)
 #define E_ECAM_SIZE_SHIFT		16
-#define NWL_ECAM_MAX_SIZE		12
+#define NWL_ECAM_MAX_SIZE		16
 
 #define CFG_DMA_REG_BAR			GENMASK(2, 0)
 #define CFG_PCIE_CACHE			GENMASK(7, 0)
-- 
2.25.1

