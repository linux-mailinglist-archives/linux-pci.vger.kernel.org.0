Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DDB77F619
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 14:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350672AbjHQMLJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 08:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350731AbjHQMLF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 08:11:05 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC892112;
        Thu, 17 Aug 2023 05:10:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4GJfPcGV41ymFf0e1Ln/9jjjuxGvFrGAfn7D0y+q4JDv4+HxNtIMxtd1Pzl9i28wab1/1tIOVs/WSy9PPZ2r66HcasAP7IYEiIysvv7H20zBmXEY51uTVNhiSYIYF9UZczfWEJd4CG9gELt70JtoAsR48uZIM4UDWjePMl4PriHiqomSzVCyx/Bc9Zn9vNIFGxptrvatVKrJ2EbKjabWDdONQrth9mh+Ft1+mK9jzu8f1OXJoDEZVktBiPtFLPKEDfm870ME3HDEUI2a0fqzEpDptsSQav/NGBu3rvZ1TZK27Pk5ObQmE2oWjzVy8Mw6GgCfvMwm3XuGIcyTvEPbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NVBgsR59LxRYhU8BqwD0xX8992kelJdt3lNRtCKdYc=;
 b=Yi2TXvxdPlLLg01HF2EOxb09rpyr7f0RCgM5Qt1GPSMlv+aqgWE4FGrzcFgxOTYIRnjdvO8+OSbEep0Ph2BC7OSjBE3tHE0WOv89TbqRva3zomeiBSre19TMM7fNOXIlX2ZnOFYhmVn5+V3xdFHXLvRHwNo4BSifM+cSvZBmoDnC/BfKR/8p3Q70IuB3VTyuW8U8nLXIhNga3tCmETO+J9dCvjokgN8dO4k9KAH9ee7LTzyirqo1tGDmqdcRb1fbb+b1V6tMPvIeEs70DUniu6LJLc/OQt9L/Slef21xH5eyT4LHtKR9RfaHdNBGhRXOMIw2u+tlRFN4YX5S0tbcPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NVBgsR59LxRYhU8BqwD0xX8992kelJdt3lNRtCKdYc=;
 b=nZwRC7Ey1THZzpxPPNzV/HapHfeYX2fvYT6jJxyP4BIuBCBYy07lovE5LWg1ZIBTqbGSzeGbaWMhn/8JNV5MeNrFYHojYBESw+Vfwk1qxFSmN0cmCH1UrrLoyq3hWXhgEPkj3NzO1H+Mc2t3llPjIFx2vo5CkUAjdivpA8k5C3w=
Received: from SN7PR04CA0180.namprd04.prod.outlook.com (2603:10b6:806:125::35)
 by SA0PR12MB4463.namprd12.prod.outlook.com (2603:10b6:806:92::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 12:10:55 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:125:cafe::78) by SN7PR04CA0180.outlook.office365.com
 (2603:10b6:806:125::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Thu, 17 Aug 2023 12:10:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 12:10:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 07:10:54 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 17 Aug 2023 07:10:51 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     <bhelgaas@google.com>, <robh@kernel.org>, <kw@linux.com>,
        <linux-kernel@vger.kernel.org>, <lpieralisi@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH v5 0/3] Increase ecam size value to discover 256 buses during
Date:   Thu, 17 Aug 2023 17:40:41 +0530
Message-ID: <20230817121044.8176-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230817121044.8176-1-thippeswamy.havalige@amd.com>
References: <20230817121044.8176-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|SA0PR12MB4463:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c2c356-c4ea-4fd0-e751-08db9f1b0238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W+GDqCYo2UnUIF/oKrUcWPhLE9oNLUbeMBBW0dUos09xBGwCdOtpl3baFqmU4BxSJa8Zt6obg12rLBngK0Hr7BcfZNdHe1K43umBigUOeAUclHQsb1BXNajVieRlGGEWVPI49aX//Ci3E4wvI8AsIDhaSnwl08Q3ai3WYrjrQbNN0nAl0Noe3/pikjwsqDNHcYRx/32vEMpbnSjHNS+/4LVZ/lIyOXART5/t6Pqr8M+Uk74beYELXLFTA1F5+qar+LL9Sy73RZeff1dxt3CIAuxpRagYEbrfTWbd1aGWV+78FRoLDjRfG0CtCoPTastcNcVMp8uDl+6KhxVwltJUieJiDP8xgtFDouDVKyfLlX28RDK+CHpD0RFQavWTMh3xHEFhGjaTH1TPYEjm7+D/UWqY2x9xgW6xSkwVz71CNYmqnNDnK7HFOV4cfLuO5UJUVzoSdl8eRl1rKH3G9drCnKxSFy4s+XhMMDr7jShl0RR62vFVB+vvi9eMmQMAg0j2OWQxgBj8XimEamu3QdfFb/zVpqsNlnxphoBUqqincXwaT9I4s3vzjb8l0Ks9Uwn5TzgwmQmoiuTPaC41sVThbrWpNG2riy+1wC5Jd1z7uQdi51F4nD4NiJhIqFMFxVxV1pNLgV0fnPbQfiwI43uHAtIaDVyI16BIN3U0EJhi+EzE0hfDerlVd2rXnSKTRCpKDvWIAdbIb/pXlLGpxRvjejSshfJqvoNz83UOwnVvHsh1N1B73tkiEkggm7tzdb/OX/+s2D8j7QUaTPgQBoEjrnv9jr3yIS8lyypN5F/JRuk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(82310400011)(1800799009)(186009)(451199024)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(47076005)(426003)(7416002)(83380400001)(4744005)(2906002)(336012)(36860700001)(110136005)(70586007)(70206006)(478600001)(6666004)(54906003)(316002)(44832011)(5660300002)(2616005)(26005)(1076003)(4326008)(8936002)(8676002)(41300700001)(36756003)(86362001)(82740400003)(81166007)(356005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 12:10:55.2649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c2c356-c4ea-4fd0-e751-08db9f1b0238
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4463
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

Update ecam size to 256MB in device tree binding example.


Thippeswamy Havalige (3):
  dt-bindings: PCI: xilinx-nwl: Modify ECAM size in example
  PCI: xilinx-nwl: Rename ECAM size default macro
  PCI: xilinx-nwl: Increase ECAM size to accommodate 256 buses

 Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml | 2 +-
 drivers/pci/controller/pcie-xilinx-nwl.c                 | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

-- 
2.25.1

