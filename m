Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D56772776
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 16:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjHGOTE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 10:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbjHGOTD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 10:19:03 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2061.outbound.protection.outlook.com [40.107.6.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AED10CF;
        Mon,  7 Aug 2023 07:19:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbgR9ldgYj08IEGldO3+xArGuNSthVul/TPg1zPXC65KOHnofsQ20ENpqYrnq3WtZz2uVq3OUQt/o13oTMCwMl6tdqFL+JNUDfw+yawDBenT9CQFDbXxX1auxcHqVqyXFXHzUV7cl/Ac1H0pzAeCZHdfMkBi2ah9Fu5tuOx98m5cjWTfOhuJpvX0GQ544oe5+LFp8YuIK3WtI/Owaz0z1fWDzUO30Hh7mEEZpAWeNeO6NEMEG9E2NA+cos3cWTB3Yq8go/cGpqD4+OVYGRgaMmVlkZl4ZGWNF1M8wPw+JAr8FJ+PdCZ02PWtoOLJBA5o1zCoJgS9IKlEbvP+V2Ulnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjyxhbW06JhrkrTCJL7QM3CGDyh+FD/nRHJUcFll8aA=;
 b=gg8pCLl3igVprQvIWQjw0e8jShWYT8XKIh/FinGiE3nPYMdeVEh7EeI84xqIV4AbmpqcoxsZ8SJmkrKkJfNHkMAPMj+88ozUL+bz4BE1ktJbcha97oPxoZi0WzpHiaXvdvUExa1zssAB1R+iLCrpyg0XcxHAfU3dMF6/773axrTyZTi9TyJkrEpCkUrhVPk0NS+r1yx8H0+U7mxMkGU15ykyMl4Ukr0LUczChr03nL53vNbfAWeVBAw1Pq80Lw1Nk6T+dRHtx6m4VmQxgfNXk/t2bsG/xaxxGjjtEulITo3kXgaPhcEVpVqtQ0GpgH/fo9Sr8c96yw0t9GYdvAXuNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjyxhbW06JhrkrTCJL7QM3CGDyh+FD/nRHJUcFll8aA=;
 b=nu7XeUbKuOEbuiA6xkc6vxWVp3A2W3OSylhoAMVis9X487kFqryvMWsYKcldvhyM6qUkZTk77k70Yt1gid438PGcq06lEU6lvNLSH2y6PXSff0Tg8dOGyk9Jrl+jJiPOIJDzCxOaFRwYpVjb7f9x8xrCcCkp6YP5m01AJ3TIHWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB9798.eurprd04.prod.outlook.com (2603:10a6:20b:654::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Mon, 7 Aug
 2023 14:18:59 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 14:18:59 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     helgaas@kernel.org
Cc:     Frank.li@nxp.com, bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, imx@lists.linux.dev, kw@linux.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        lpieralisi@kernel.org, mani@kernel.org,
        manivannan.sadhasivam@linaro.org, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: [PATCH v10 1/3] PCI: Add macro PCIE_PME_TO_L2_TIMEOUT_US
Date:   Mon,  7 Aug 2023 10:18:31 -0400
Message-Id: <20230807141833.564479-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807141833.564479-1-Frank.Li@nxp.com>
References: <20230807141833.564479-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0057.namprd02.prod.outlook.com
 (2603:10b6:a03:54::34) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS5PR04MB9798:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5b36bf-815a-498b-d3b7-08db97513e22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: frmvgWTf0114w5DjahHnhx9NFxjI5BLzsVv36bX1bmch+QPGRb6UT+U5GyEcR8tRQZ5qV6nFqPeyhkmZb5R41Qxa54sczlYl85hACOvC4EgPsGo/Lf5cZFgJP1nY6sCNhZelBRfkCdEnYqDHpzl1eAlnxznhhg46yfjOP7tsJ1yd0RIt2x2DwKZTKnTJLhZTqAkF8S6mYqS7qdxL8YTqwSqYLygzPjTRosudty6fSJ45hO9L7TbP07k/G1UhgCCiscRdamuMyc1nf4+vquLFwE6imRNt3n2gxlsm/q+xgd0e1b75OOb87UOvruyZ52HJWdjtXpDV8e9nuir1bJo7MFuBfyrVSqucYt5xtkhMHllYpM5vcZ/yHyV4vdk2cthj5hmz5U/Et6Mju50aZ7eUKGPuLt1N/XJrewrpHU5lev3DcJO8dwnKcoAgUYPtOe75knl0cejOCKF51PFkUSQ0XpAvSn+aMuvo4lZdlnSd7pDojF4WO8Kv2Lw/JuE1bduxCMPmb0E/6jl/942wMEon9GqNzrtZKCG964oufSzlewcb694TKJ6YK/IhDUs4ekTvy9vw0TDOL8erc709i41noYHF7tRv26evPsdo1UzeGiX+Tg7C9gz9mtmhlo9DmVPb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199021)(1800799003)(186006)(6512007)(26005)(6506007)(1076003)(36756003)(38350700002)(38100700002)(5660300002)(7416002)(86362001)(4744005)(4326008)(2906002)(6916009)(66556008)(66476007)(41300700001)(66946007)(8676002)(316002)(8936002)(6666004)(52116002)(478600001)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3jQGPx0/Scx5vdA5wjgOjXA/ws/QUE2FF2h7u7iGx0uzFIH7MEeMDqfW1cFZ?=
 =?us-ascii?Q?xfGGRC4PhkyQD0iUM8LRIJ5gDSZnXI+fFcZZJPg3D+QUCptw1+ZhLwo9h4qL?=
 =?us-ascii?Q?luJkxgc8UcMQaMxwhNRjquPE1Zu1BopPc0tgHYSD//y8U1oz3t+XAASyszR5?=
 =?us-ascii?Q?+9d2RMLEG++uxj0QPcQ2vyRtvGzYvctyGAw1F3+oJWQOf7i92siToosgUwBj?=
 =?us-ascii?Q?cv1TqG0EziAidd1hMg7bJBM/QQsAmZFsTiqyODJ6WEiWURPvP3tNRuqxQKig?=
 =?us-ascii?Q?8J17aSfTr+99S6CPtxjaDTBcxkeKg2KT5RwrUgb1hHhAMJu1r5xFMizb772a?=
 =?us-ascii?Q?vQGLjwEDgJG4NXzRIUc0ebQ53LslW9JKToVXjdhrVZdn8x8B2ttQmL1Qhd7V?=
 =?us-ascii?Q?tYIOIhBHIhTEjS7d69z3RC0CMuJrr/kPudUGTwq1vXMGxK6Y4TFIcYA4HM2Z?=
 =?us-ascii?Q?qZQL+lXjZMuPn4tOuFyel+xb/rF3FZZe36jPWAwqN5ymizQwb/i2BT5AfNdk?=
 =?us-ascii?Q?C+VKdwPN599gmekQb1jYLFV9EUXwknD1XX87i+JaYa3xakix57ds89iwpP3o?=
 =?us-ascii?Q?kvuB9Gny53LSZeCZAadNFhkZN2Vn0C8PxtDZMRBzDmX8kTDK0U1+zfQUBo1F?=
 =?us-ascii?Q?LtgvJEQag8saUE3TWI+KHjCrXVrGsDQ9TS0ymuhqoZydpKZRAFCVKsFQWo52?=
 =?us-ascii?Q?PAogPIE/xHNfWx9YVA+swQMEVUpfyAOYGaaWl61ggW6v+awPiRkFKbHHWRdh?=
 =?us-ascii?Q?Bg6xtYr9PyN/4mw8h9iY3WH6D3NO+DdUndpU+9K/xrNpp7YjgSrDe7RZgF7L?=
 =?us-ascii?Q?es89e6SJ9ap62xPFtWqY2Ru4QBLh5QcPVVwSwyTNyLSiDMQuuCAr5KQWvvC8?=
 =?us-ascii?Q?n8Hmhm2A2Zn86udrSVFBaAhYAnhmPUSfehMKOU7BYVqRo5zERQPO2M+Yvx+t?=
 =?us-ascii?Q?+qJ76gVOV/xoE1x2vMzKnrmhhOeoXrit8DpLfRZrQcOOsY5SOXGVfwLsmG1+?=
 =?us-ascii?Q?mKLG3rayHb2goUOfT0VU7tzjxeWd3Mmu+DsJFt0LBV7ITFDxkXc08NLG/Fed?=
 =?us-ascii?Q?lUj2sZ+3aHjBUbydum59P9kOkhb6looCGCRUk6u//Ymtj+050pD1636PJjVk?=
 =?us-ascii?Q?fnuGoWLmi0o4EfLXABpSeJqHgl4TDhSQCAHVYTUhLCLDxPiODUf2ewiVmAXS?=
 =?us-ascii?Q?8917q8ku1TI93VzIArbSP53HS+BDHSJ2ekJvG3ArJ2N6lRc6gfIlkES1uRFb?=
 =?us-ascii?Q?llXy1gs+zrKPMyHkOy04kG4BpJWp31BtNgOGa8aBgNjJNTRGcrmx8B6Fv0Ol?=
 =?us-ascii?Q?8/BomDuDDgWjH5bY3dbtAO0o0uE9wuE9hmcgAZHb9RvtRebUlcE4NnTSQA3y?=
 =?us-ascii?Q?iX7UywSP4WaCQQyLoe02x7FLp6BkUqNszIGT/SxYczR31QoIg4vlDU3B5x9D?=
 =?us-ascii?Q?4pv9l3U3f30xo85WB3gVUuNLbhGQEng1ssGJvJN9Syxb9BIrE0kraAYtpx8U?=
 =?us-ascii?Q?WOGY4fO1ZkqKHpE2C7cUbs5SPmmmJiyRpuOUFayVtyYEwJKVv51e8LvETqpA?=
 =?us-ascii?Q?G13caMtmkHNuAMajTEk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5b36bf-815a-498b-d3b7-08db97513e22
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 14:18:59.7218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3MtXG52eyKwS3QhmKoP+FUwH05SqeAjIjzLbekIorgv0s3p0M9yB1/01oswlJbD9GXVKxe2qm9yU2NwO52jvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9798
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce the PCIE_PME_TO_L2_TIMEOUT_US macro to facilitate checking the
L2 ready timeout in the PCI subsystem.

Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/pci.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a4c3974340576..da8156663c825 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -13,6 +13,12 @@
 
 #define PCIE_LINK_RETRAIN_TIMEOUT_MS	1000
 
+/*
+ * PCIe r6.0, sec 5.3.3.2.1 <PME Synchronization>
+ * Recommends 1ms to 10ms timeout to check L2 ready.
+ */
+#define PCIE_PME_TO_L2_TIMEOUT_US	10000
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
-- 
2.34.1

