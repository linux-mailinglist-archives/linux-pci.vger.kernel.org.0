Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2D176EB63
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 15:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbjHCN7a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 09:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236424AbjHCN70 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 09:59:26 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928DF1723;
        Thu,  3 Aug 2023 06:59:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VghXEOLiSV6QVRoL2O4AyuGHI2PVBC4X+C5mCq5nm3yXP3HNHn+/edDNhC25uJgf1FD57yckWmK/YWEZ09YMAtPJnavtSopJv5RYKlD6CEXHufmBRiv3+gPmwz2ThVB9pTEEbq8Ax4NiBumYEcz8ATmYZysespVELMf907sD+wc3d42Mzl8/ArBQDW4x0MXXDJdB9ybuXTKHfhRsBAo4FMFuUK780YATj/uNRNqf6Y9iJJzzdb6opMN5yX19egmPPuzWT4xYHEwzWbfP+MCpEp61fOVddLRHtLszOFJru6/Rb3yVXsDIhrYHHdj27g8c0YYk30MvSfarNz6rI0qMZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n68zwqWSrkq+N7UHYvQYhDA2I1fmDsJ6lWCGNYx5WKg=;
 b=CB+hGOhkCFV9hDgs64ZrcaxaC4JEpY46Y86ItJkD+MSU1bBC/1Xnec3tXUiRUqeEaQoVqtd0oh9ug3gZ/lXVJyMirS8iPgDxnPDJDOiz/e+VmRAw4HcCLgxcyj4cE1euU14r9LRa63vnOE2Llat4wjQnBwpZyqFRi/Cc8AvKiGH7j9qAVTECtR5GYjUYpKTJkFk6SV1oIu007hWAzGA58InxKJ4BBW+C+bWOi658lIVK3/5i/BzdiLibBlPhHn7xSuhuQuQnh/mKBajHlZreMCOeD26LCdEG38i2YFtpVXrjgNMk6pWWtOEQmB4RQhGkiXPAf1rpa82sLYcIrlAbUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n68zwqWSrkq+N7UHYvQYhDA2I1fmDsJ6lWCGNYx5WKg=;
 b=nwyD1vyuH730dw7DCWrgyCtq1NHiP7JhyjIkaHbHsZv81MBEUqkX9OOaUzr265ErwEwa3kEDMSDzEBOqDhwTqp9SrMwh4tNMxP5Kbw6vAoqrN25UeHuDJlNx67wmvuOLv+xsDKymxZSyBjyAkzWuSeitTb/mlNPrzd94C4ubXBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB8799.eurprd04.prod.outlook.com (2603:10a6:102:20e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 13:59:13 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 13:59:13 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     linux-pci@vger.kernel.org, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH v2 pci/net 3/3] net: enetc: remove of_device_is_available() handling
Date:   Thu,  3 Aug 2023 16:58:58 +0300
Message-Id: <20230803135858.2724342-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803135858.2724342-1-vladimir.oltean@nxp.com>
References: <20230803135858.2724342-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0108.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::49) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd3422b-6c3f-4459-1224-08db9429d15b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ISsiYjelXBnUJQH83iBo3eI9xmRqhm35knwQ6bf4QHsSb1crD/hMuob7HXT56//k5BbFVANDsz3TypCoxtRkL3aZ6zReh0rQ3DyjTS3Eoa1UvBCRHYWKSVR4zDZjfxAEf5DNjtu9LiFTgm080hEQxWgs2dLV0mA16Lk2bX4ZrTbMf5ONc1MDCJ2tv57KWsag3q1M4bXfvsC9RxtffOzy8XwhofQxcPAQJH7nG/6qk9ORMnnKVITSbhUedump5aCpRHTyl3blWEDkIR0sCZx1rv+O+ti2IkO+6MwJtCrzMiHSvcSgfhbGdhfnJrHJyyzqN0g0mmR52cp3EroT7H81cYxuIn5hTMfW4aUU6e2JNFVUJfE8MwiFgJIZwPUYee2cY+qo401tY+mLH2ih9/VLnX4tcAY0h9ky+tmA/lM05HAhGWdg8HLZ06iE5ERg/urQnfC3kiwljTyOuiVXQXkbM1SKwpu57vetryo24b/ix7HLtejcMAxgBrgAtsYoY7aIqJ9AarO8cmmaxVvzl/Y3gb2+GTmMWpQgz6Den71ofudEGaKzpqYQ6h4dtAW0N/8UhW7WOEnTVJtQGdN7ARVAhmg+PXLz7EQzCj0gh2YzkKioW77vjoPVGM+f8qwgvhZL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(7416002)(44832011)(5660300002)(8936002)(8676002)(41300700001)(66946007)(66476007)(66556008)(316002)(2906002)(4326008)(54906003)(52116002)(6486002)(6666004)(6512007)(478600001)(38350700002)(38100700002)(83380400001)(2616005)(1076003)(26005)(6506007)(86362001)(36756003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?66WrtLHgvDgYl8FsDdyCOH6jm8LXbV10kDQGpHATKeHQWGMddRSvw4TCNxM/?=
 =?us-ascii?Q?PT78iJstxEhlA1HEY6pN4iX1JMOgWjTnROWlTAm0YIBF1fNWh/Gkvtji8R0I?=
 =?us-ascii?Q?kRbS5r7jfCFC+UbjTX7syXJ7vYVwLJwHWIvdjaSqEGVb8R+IaNV7zOSs5/v8?=
 =?us-ascii?Q?O7l/jCyw1aHt41ZTdosc0n3ZZCnvJaYglTSNNw88u5bwUSI+wtrKgl6GEWIp?=
 =?us-ascii?Q?KSkFYJKVA5Ir+FtbaoUxCeAd4gTOoZBgdnyTrbioNNQJbOBcMUc+fja2bdhn?=
 =?us-ascii?Q?e2T476xaQBobZkMWa/gROkj8uitd+33/+Xnf31TEgc6alTmwPA1se1yVDQg/?=
 =?us-ascii?Q?KwzRmwH5flWHck0hxEHSHmngFewaC0floVgV9bztZ4hRlXjIuY47B0X46qL1?=
 =?us-ascii?Q?9aScnQ9Tj/PvYDzOwES5Z1saRZGyzQI1ah9vxrR0jF012uRqieN+QPMVcWnu?=
 =?us-ascii?Q?fWt97+lDNTnCYrJTRmtTI+j3TpT1p2zi9LlebRs/jFNzp2o9zNpqRrzQ7blr?=
 =?us-ascii?Q?aUGIMfbQJVF+L12FlfZO28n3iZerK7CBZMaLMd7so2LFkwSzphpx4uynSt2U?=
 =?us-ascii?Q?JaLd/aPES/pyzWo5SyTnqAJAWcavoyqJLQLvvTQFGjiG5bXNAumUWfckvU1m?=
 =?us-ascii?Q?FgngchmbmMadtB2f35gEVYue6u+E3BuVAmRZyB9s4DM7t7XVToArJMkOwk4U?=
 =?us-ascii?Q?cXipDT2YgmxJOzdLureLyBon3cIkzvVL9jbd0ijUykLm4eVVIauT2lSGp985?=
 =?us-ascii?Q?zzNcWl/P+wV37pt0KDM8q+DyUA7ebgoNogN6u0hSEUSJgQGYZO3/maInvFKW?=
 =?us-ascii?Q?dmti46e5pAzUbBDA9B9aT7dfdKw15hkA/qBIRvZOGPxoMnh+4dU0j8A1XjGY?=
 =?us-ascii?Q?3nJWo/kz3u4Uy5KMETxJJnfgfut5GTWQrCLnu1RFl/N6jP8os7hGiLdU+dOk?=
 =?us-ascii?Q?EE3d+D4Xcqr6s36kkx9GowPux4WaYHMLSyMerbrnJ8cD+mZnwv6ntTj4OLV+?=
 =?us-ascii?Q?KsCRdOHbNVWwPLFLxt2BTc2Fq+PD+ZMzezMkdw1joYpqJryzcK90DzHyJv+5?=
 =?us-ascii?Q?/5Yc59+r6CK/AObyC0iW9Zd9BMrwlwS3Uk7gGTGDy+Arh0Ny6AxsenfjLW8Z?=
 =?us-ascii?Q?wlej0hy5qbu3fygzAjbRxFSm6YVsUohXmKM1DItESeBtj7tTMbc89LH9UtSY?=
 =?us-ascii?Q?XB0DItP/JoRN70UeqXN6/f0PH1oOHi1lTzm7en1rCPL7VSDbVsIVj3kUyM+l?=
 =?us-ascii?Q?ZLIGfBrLblAbO54O4hqRd+V7VOt7sqcilwR1Z5E1fwW3OjtNZIUkWKaLaYrQ?=
 =?us-ascii?Q?28rb8r5uB9PJQOiXte84o+eqmgTieGSXOld6ytIdMprdgwr2VxT9ujr3JOul?=
 =?us-ascii?Q?2JfOLrGuS/fWb8Z3OlQ7or1wZWSphtSlUilvrPXn8/zzLq85/JAKaJggEbmJ?=
 =?us-ascii?Q?3yxyxz9dwkEYTRH9JFh2doSeUMd4RFVAauwuTFYZF05rSGtCOC+69csNP2hl?=
 =?us-ascii?Q?mJ5cZhVpXCYICn8Qgot8Hv3+R/NXC5i3C1EA30MLFMFpXUphXqS6osehyzlR?=
 =?us-ascii?Q?ZF4UKtw9opdTl3Lq1WxMImUChDgsZvltsbJlr0W1neaCYa2fYCFEX5uiVIjk?=
 =?us-ascii?Q?zQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd3422b-6c3f-4459-1224-08db9429d15b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 13:59:13.1486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFErHsG56drzKdhguREF9y+a8gY4JqFFcJf72gRqN6sNPNbNy656yhEAxxMSerHwX9TxP6jaHMcwI6cmjDV2ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8799
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since commit 6fffbc7ae137 ("PCI: Honor firmware's device disabled
status"), this is redundant and does nothing, because enetc_pf_probe()
no longer even gets called.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index d52ac0b6add6..e0a4cb7e3f50 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -1186,14 +1186,9 @@ static int enetc_init_port_rss_memory(struct enetc_si *si)
 
 static int enetc_pf_register_with_ierb(struct pci_dev *pdev)
 {
-	struct device_node *node = pdev->dev.of_node;
 	struct platform_device *ierb_pdev;
 	struct device_node *ierb_node;
 
-	/* Don't register with the IERB if the PF itself is disabled */
-	if (!node || !of_device_is_available(node))
-		return 0;
-
 	ierb_node = of_find_compatible_node(NULL, NULL,
 					    "fsl,ls1028a-enetc-ierb");
 	if (!ierb_node || !of_device_is_available(ierb_node))
@@ -1285,12 +1280,6 @@ static int enetc_pf_probe(struct pci_dev *pdev,
 		goto err_psi_create;
 	}
 
-	if (node && !of_device_is_available(node)) {
-		dev_info(&pdev->dev, "device is disabled, skipping\n");
-		err = -ENODEV;
-		goto err_device_disabled;
-	}
-
 	pf = enetc_si_priv(si);
 	pf->si = si;
 	pf->total_vfs = pci_sriov_get_totalvfs(pdev);
@@ -1370,7 +1359,6 @@ static int enetc_pf_probe(struct pci_dev *pdev,
 	si->ndev = NULL;
 	free_netdev(ndev);
 err_alloc_netdev:
-err_device_disabled:
 err_setup_mac_addresses:
 	enetc_psi_destroy(pdev);
 err_psi_create:
-- 
2.34.1

