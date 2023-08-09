Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2279177640B
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 17:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbjHIPhv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 11:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbjHIPhb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 11:37:31 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2052.outbound.protection.outlook.com [40.107.14.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542A81FF7;
        Wed,  9 Aug 2023 08:37:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+6aDyQAprgU7+ReO/z3Y8UeNvBWMOb0ZAobUucCuwoWLzpefhyvP5CoIP4wYG7Pd0Gy33WifEPSG+cTLN6uGGoWVblxxozifARXepbzIqC9CzVaCaGMH/d91UYjuEEb+5h5ScVWQY8ZR9EHiF2UdosTwcJ3JGAZ373X1RbawatD5fIAkcSYsTYKeVe3jX8B752/Ps1R9Qb71xIqiBug7va3o18U89LjUDZdQ0UcfZIKiRzyRGg+ZgFvir98O8m2XGLGcb1gtnI0Wg5ZUwWvpExUhCDHCfmCUAMQ5HWSmLLfqUVy7NVpvm5gFzyUL0LCs/lDTj/PyNTqNf886QsEPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjyxhbW06JhrkrTCJL7QM3CGDyh+FD/nRHJUcFll8aA=;
 b=QKY6mqnffKJ6dTdtqmatuGNix/x8oFyxppXgMgaErN6uCRWdMjIrbdjOZioiMg++eXjtOxn8v2jc8kNvKIvn4Gmn57lnC3tiSyLJfOjU2FcOb+L/Nn2/uxVf8UUpqTZGKA34ZaRwj303vVpABhHywBaNKn1i6bj+32zemWjhtrd/vwbJDj+w0RlMDNDxolYX3UT5EzZ2dxK/LdjFg96mmH1T/+tPORw6R0HxHp1nD6accMOrQ2MS9+PG2CKtHlB199V2cdVssTkVSxDZu4tmcHftwra0H57jCwMrAsZgcykmYzZtv6+7hEjYRrF2rkW1galsao9PYNNTKZltpTdyKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjyxhbW06JhrkrTCJL7QM3CGDyh+FD/nRHJUcFll8aA=;
 b=EJoPDz3W+gm/PXR3WHK7NOqucyZ9g6CWSwAoDMCrZNjRijBKOcRWuu632WMcwgXC0JthMRt9SWZYBEKjHI0hZ4R8S1qUaJc29C3URwfcUOY2i4/PywjyDYIjsupDyx7j6vuMwuLWKswZQMAEmr5s4t923+1DY3gNck9L+iQImis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB7161.eurprd04.prod.outlook.com (2603:10a6:10:124::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 15:36:09 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 15:36:09 +0000
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
Subject: [PATCH v11 1/3] PCI: Add macro PCIE_PME_TO_L2_TIMEOUT_US
Date:   Wed,  9 Aug 2023 11:35:38 -0400
Message-Id: <20230809153540.834653-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809153540.834653-1-Frank.Li@nxp.com>
References: <20230809153540.834653-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::28) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: b42a0b46-4c3b-4dd8-321f-08db98ee5a40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KYie95MJCCtgU/ZxBzlebD3zv7+jDT61KvoIxtZ4wjMuQfkSqtofu8lZ4k+CHWc327h1NUWGI3PJOFaaabodvPXdgm9PVcfMcA3xL+WwmV9Eg/rUsnGwP2mA3FjAIhsdB44G+n6aVcCbLS8BmR1o4dIZMSU3BkdB/+U8GtUpwu9q+h3b/2/5v3r55kI93npiN6gQFoNefC7tqFVhvED6RwcGc8AmZUE8I7UOWu2cIfWyrML6AbAtseKrkn9oSR6eruCcbosAR0+Plb2bYwPA6G8TnH3iNT59/DsWWJ6rjEo2O80S9f/n0uhili6b95qEW1ySVqFyEKUxbieZvB01w0xBdQSjQKeKJi2AOuDYZeGvi3ZRuBMexX1bjst3Ux03M3bn5HJLOAUR5OqbHwenFUQEBRF+QPUiHr7ou7btwM80hnY9PO8q7dCJCQpNpc7TxkBmXQ2YF/rHEum9tj/xjulMGS4S9ou893DJm7k1Zm1RChXE62ukyKbiUhtwCahxVxLWsq7/IcFR8eXLHyzIGkwCryy+wvVxlRlYid+RxYqJpJ3TAGBBCmf+LPpXc0MTpaFZXYGX70ht+LId8BC3P8w5C8yeNORiMhgrmVKuzrg8ApklSk/j28JGqw2+EyV7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(186006)(451199021)(1800799006)(6666004)(6512007)(1076003)(6506007)(26005)(6486002)(52116002)(66476007)(66556008)(8676002)(8936002)(316002)(41300700001)(36756003)(38100700002)(38350700002)(86362001)(5660300002)(7416002)(4744005)(2906002)(4326008)(6916009)(66946007)(478600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?65vLeTiQZ6WVjSHJh0zLn+2ZND96WWF0sXcI8k6dVYXULNg6VomeaD7rUllO?=
 =?us-ascii?Q?lYJGGyC8ZVslCB3W5PD/4on8FTyS3k/SIuDAhN1X9nXFTt/rCOXySG17ayWl?=
 =?us-ascii?Q?hMXNpfGjbM+e7a3fzlrDHCblLRv0BaqdbpuvlVDUJ1O/0a4/SAx5P/QideP4?=
 =?us-ascii?Q?sSweojCb/x9ekVzfAFxNXhWQwGcVCQBwOf1lVsd0PjbVGQgcT3YQsidFOGju?=
 =?us-ascii?Q?Xp7bK+2AP3JRUZKSSDrFJ/eGR65F/G40VdAq8mRccXT4LjwJLoLxdR/AJQ7/?=
 =?us-ascii?Q?Ye3vj1Myg2IxgPlgs/ZF6pOK3IbMXsNsYkX1SJdaSiVnxqFPOqB6EBGY+WnM?=
 =?us-ascii?Q?RGdVEI/mjbUWODcYD0T8hTUu+6Iy6qEuDx06pnqypcH4OQbsq7Z2LOPbg9xh?=
 =?us-ascii?Q?jLKkFNsvG1tWgvGEBqt0oRcsS/a9YrPhl9PA+gB7W2S8I/bNBST1pDFyFwcs?=
 =?us-ascii?Q?K0c9hyqk/j6Ou5KIY4M5Z16OpeH1oqAytZ/aXt2ynUgyNChUlIN+2ZNKgnzi?=
 =?us-ascii?Q?qX6A82pEdqBn8xLT/r/mUTAu6gNRurXrsiA5OhTr5goqaJ9AYe/qMzoT/DzU?=
 =?us-ascii?Q?dRtAQtrdSirZowYZ/jxp9Bw16NGpu+pCXbHtM48S4qwkyUcwyEqeLu08BfOD?=
 =?us-ascii?Q?8QdfzJZUjB0SBbXwswabvDPjmu7Du2aYP8izfT7O/8h2IyTomr70j4u37pSo?=
 =?us-ascii?Q?jBiYgbdM3Z7RWTYMfJtlxm6c3l1XbnjMeEjFyu1lRWdzg0KbWlshr1Qb1MeM?=
 =?us-ascii?Q?tP9LowN4t4YtaCuqOwHOT1zIxAbuDu403waXa2fOYdpDk4xo8aOTfPg/Boqn?=
 =?us-ascii?Q?iesEsce/TjqHkBaEP/fNgvExXpQcxBotjXNZHSkoJxZPZMpXZWRkAeM2EoR1?=
 =?us-ascii?Q?JevPAVoKqniPqOKoMtnyM2ocJFysTfvkG4qf65CPLtMTAbHqVXErlbO3oFx/?=
 =?us-ascii?Q?bCYJOidu2IeacAoQQoWnJXuafv8Kw/fwPMO936tX94oAKEgHSiZmKa07Ym8R?=
 =?us-ascii?Q?IQyEE117/shseQEWa7EfmurGIfW6z4xA/Hl8tVf0/EoTb0TORsIgeLCRR0qw?=
 =?us-ascii?Q?VMV9GWRQgIdok4LizJgsOWovLpCnvY+BLVbBBk/ku+gaM0tTb6tvKUiamm12?=
 =?us-ascii?Q?BNRcISyNRPZgdLrjSNhUJTqNtNvBtEw/D+F13zOjlR6/rEpha9qLziddYaUb?=
 =?us-ascii?Q?E8hnN6owHDAkByNLUOZoR3/vJqvNh+P7md569+fajkTZNW5vcNangY835Tpe?=
 =?us-ascii?Q?X6xF6d63GaWk8EMykkd48clKIfGi+Vw+h6hsEBGQ/fCGXmoEdADJrfCZpr5v?=
 =?us-ascii?Q?BsPPT37RBR8Hnq8zsb7JqMvEAw1dXQ//9v44wCKMrjeOoBeHfJiUfiG4H/cg?=
 =?us-ascii?Q?ELRt2J7p1LMom7AXdvpi/5Bbs9z/SjaFwpNE/i/nVuFF2ayLqs1e4tf9O3kC?=
 =?us-ascii?Q?SR88pzGSeooZcqhA+lIrvrVwRVD75aILVSmnnt0ilCla9zal9W8qaCThtTqD?=
 =?us-ascii?Q?4eo6hd2R+6ngkddstaBQa8MQLyO1J+5jMcvC3yJ4LUUJUTEjRPbQspgehLA2?=
 =?us-ascii?Q?0AQL8QtSXvDI1CjkrqE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b42a0b46-4c3b-4dd8-321f-08db98ee5a40
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 15:36:09.0029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5CHGQtTNgVwqPfa4xEGCTVwbERBUM477d+KiGEnZxqru7QH0rcUOSKJmLhGf187Bd4bORSC7uNSVcqTsc1ONUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7161
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
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

