Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5745A61169F
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 17:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiJ1P7J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 11:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiJ1P6V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 11:58:21 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2050.outbound.protection.outlook.com [40.107.249.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CDA219FE5;
        Fri, 28 Oct 2022 08:57:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WefRjbzdiV0HujiVEcKGLa7EutbYsavVSneJqOxj7BITB/4rFU3+3RlSq1AiaOnVDeDCx9WfXGPrR3Z8zJmkBV6zounvOec3KvwOle7tACIxbteXUvc5ezvR1baf7+O3IwkKLAubOvcTDXLW6gH2FB4OYXHKwefl8XQQLR1/f4Po7xe22mD7C9xk6ogmy0g+PydIA0VRRKFDmUyj1p5D6BYdvyr0vrLbNifn3YVIiAoWmmIYbL5EXXkNA6prgbdwerk4hKsCsel8AndDIjnvh+3Z/E0Z9o7OGofSzzle9lML6+g6DW6e4WB30ezapJ4YEji7ZElamdtnA0k/Kao0LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyD6aoIjEVUqZqDnSZCuVf6c3XoOXvPwpCEPm4asbEs=;
 b=A9BN3sXfEikFeh8v+2iZEm/j+KhmBnvD+gvMMBsXFmML8h4HlSDPo9DXuYxxZgZH+ClDQz5gnLoZop8xxiFU6tAltFBEPtTv+40vUXjEQBzEeQQ/1SPcqaDagDYVZWPYWAfEL5UZMfRk2y5tmIxj711chJnNFUfZU0ieJolnh+0UQIyUyyJ8tt9yrE8F3vh4MdrnamCmrFsbm0mlxViyZIijuMVQYAmddxlEV7mxBlxrCuWC17rd3tb3p5bD2bpyEEpVLPvt0ToKI7+FWBJYRTFypae2+jaRTo8MSkns1XOfA9iPzfCCbSSnWxKIibCBDZ1Ifhl2z7CJW6kVBFkUuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyD6aoIjEVUqZqDnSZCuVf6c3XoOXvPwpCEPm4asbEs=;
 b=FwCH8lvnxxxycavPlatnVIrabsPU/TSRZvY4bPPw3orYcltlHyTwq1vXwFpgNOAOpRkEB/w5ZKNxz/xIAc6FZxBjZE3sxgdLnHq0Fzc/D+lqD/cqTCgjud+dK7g+INNlXJ0a2/OHXBd2H7bIJskCgIONONRX3hbw1rOC5DGYUPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AM9PR04MB8323.eurprd04.prod.outlook.com (2603:10a6:20b:3e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 15:57:38 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%10]) with mapi id 15.20.5746.028; Fri, 28 Oct
 2022 15:57:38 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     allenbh@gmail.com, bhelgaas@google.com, dave.jiang@intel.com,
        helgaas@kernel.org, imx@lists.linux.dev, jdmason@kudzu.us,
        kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org, mani@kernel.org,
        ntb@lists.linux.dev
Subject: [PATCH v14 3/7] PCI: endpoint: pci-epf-vntb: fix call pci_epc_mem_free_addr at err path
Date:   Fri, 28 Oct 2022 11:56:59 -0400
Message-Id: <20221028155703.318928-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221028155703.318928-1-Frank.Li@nxp.com>
References: <20221028155703.318928-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::23) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|AM9PR04MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c542b8-bc15-4059-bf0e-08dab8fd22f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yzP8S6SG+ifvpPQFb4s9yksk/eCiuUeQoZAMCddAFtzDSP7YtCDx22pj0ox37V9ilxSiAYB3yJW6PYCz7DocC4yQjsJB9B3cfy5vPUCVBaXd2nZerR9SUNNaa04t4TpPmR37Ahqlv9IRrmHoW+HZKdxLljLG5szBUm5fGlxyKLaSTmxXRyh97rCdP70x5cctyL7IGB0oQP3o+nsyeADr6BxpQPw3kD0uVYV3kJHw6LOoXHZSx8FAgda/3QQxjBSehXdqOofJ0Nbj/tqth2q7Sl7qKfWGEU+DohIgmhsPQE5VegHPAVM2ONCaZr2bgFZ8Ncyjv6jPyxoTE4lLQrA2wFUbsPQeU3yC0L5tTGbQ+aaLgPxXjlCF52jEvtQPIAlSC2a09zIyIusrkXjmL1xx1FjQpSCV771Yyl/5ePf6SF2G0+J13kcJn12GMkubn+RHfEcJGCniAPlSRQ8Qlc8mq7AjKHSsbTl8ksphhs7MS2i0tgKwUIKSqVy0c9n4qSTVP0pxI6/fzVjVCOw/TNpsxG8NyJd4C9jsZgqOpPnsDOo/12kukIwONl6mSFESZkDiuNJtorgjZO2aWsjX6ElWUO7kWcG2iZPak6k470K6RJMPB5uLNZgqXTCJ+y306FZ21Lc5Hlnly2W8KJCuo8g0DVZGRYY/IUYyY7mWW3uO2oRKrzPiyP8pzpAeZhrR4EhhfqLHwSTxhNVR244u3KCc6rWIxlKTtPw1HGFL5X+1QrMvBTFwJMwnhHAaZ16cRny8V884nEK0vHyfEy3QOH5pqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(6666004)(316002)(37006003)(34206002)(8936002)(5660300002)(4326008)(2616005)(186003)(1076003)(7416002)(8676002)(4744005)(52116002)(36756003)(6506007)(66476007)(66946007)(66556008)(6512007)(26005)(41300700001)(83380400001)(86362001)(38100700002)(2906002)(38350700002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?deJ2msMoPQq6hYgN/nKdX98x9Fv78JaJijPSok7Y8S30Z5uh0R6CaApJJ4Hi?=
 =?us-ascii?Q?4i5+g9ySi9OMklkPcJdmd1pi2ijG8kD7vm6aJe6uuImpShzJf/kuuRdZK8h8?=
 =?us-ascii?Q?iXAsJr5Dc4IlzML7zCMny86Kqy28304Gim8hyF5bf7KB92XGdFO8msBARQno?=
 =?us-ascii?Q?TNaqC7Ejk+i8OlUoL8DCfBIVSwDXl8lFlR+G1Pcc+mEWOKbmG3x6JHdqah4H?=
 =?us-ascii?Q?9id9VAtc/hrvY4DoTSoYVEfeL2pJwx4uXbazR1SAZJOBPS4A+Q++RFDot4kE?=
 =?us-ascii?Q?2vf7sGfVs3sG3e+cv69X/YnrvuMXG6mbXmlV72r6cGB35/YrH38nTjEYhXfi?=
 =?us-ascii?Q?QNybTys+gw0/uTWSzV3hYF2/OOr2G1oYdYh/bVqw0FOc8496xvEinklaI0pm?=
 =?us-ascii?Q?RBMwGuRPV7CER59FkRPun0EUrKEBk/zIBtu0gjURAc160gUDByeK1cTfSgL0?=
 =?us-ascii?Q?opTku29dgFJWauLpm+oIEOKOq2pC0f7YsYsUT+lzLmG2b+hFmCm/R6UrI7g1?=
 =?us-ascii?Q?WT7vpYkNu5yHd1jkW43eVTHf+ZARSinVhnVHgWoQlHl3sYqKVI1JYceKWUJS?=
 =?us-ascii?Q?F0pJjAwrgX8ZxEQf4fvUKwTvUu2zWds5nOZ24zxwMv37H8oSCGLWLRwLmKex?=
 =?us-ascii?Q?mfvS7S1gSNVtC6tE6Dcgkpb3guz53gvgvTy9iSszsGlY57Wx0uBJ/OXCQfmc?=
 =?us-ascii?Q?wkU/Ynp7dgr85hIK/SCrbuR2QXIVmMIxbAWQ/5zy2ZWMHuCYkuz/7dTYaDSe?=
 =?us-ascii?Q?PO1gFfj+FgsvHZ2oxwzFK1n1dNKxyT5tZ3cPnoddCluE3NZp9zm1pZhtR0JQ?=
 =?us-ascii?Q?0bYccVUqz3zRAXhJeSQBAh+xmW/gY5RxmZ9m9qhpPz95ytyT97hbOhgpA83B?=
 =?us-ascii?Q?YHw0IMiVupvT+pFFghPmviqEmbpBRVZC0mQJzOfniPRD5zfzMsHnkTP3bXFn?=
 =?us-ascii?Q?DQkeOGN1BrcvjOnOkjm+FcQiF9aiP9j3+n45Xw11GegwIGlr4T2oOjlbuDZm?=
 =?us-ascii?Q?nG/G1WDmKpq62TglEzKNMe9kPjVQBVb+8iYmWNVMh6pwpwpEYjaleSQ/d10a?=
 =?us-ascii?Q?Op6PpjvCifd45fp0lPAMUYQ1bNbPuTKX/Hw7mAlISRawgZRn7ihh4tcvnLM8?=
 =?us-ascii?Q?JjgxNVvh1n/SyT0KMphjk6Exzr36ukTZdeTAHxh8S5CtTFAkz6/KwoFU819c?=
 =?us-ascii?Q?uQpjkw9EO27OamEb5sqyDTwRHyu2xq6YXwznxrhr3vl8iNo5thPrIoHRNFN5?=
 =?us-ascii?Q?+XZWlRN7DYec/V9RCmNO4qCK7YQU7Gw7pnLfPqUbKk7pfPW7JcUskd+2itMY?=
 =?us-ascii?Q?rOUHm3ZL/l8Ul7ZN0NNJMtCR7hpxXHwcopgqR0ZK15fuW42bzt5XBiQBSoPI?=
 =?us-ascii?Q?lYqkj9j6HgungtiLZUqctCEahpy/VMUJETXphM7kiJkVaApoUmMIxQKg8C99?=
 =?us-ascii?Q?iPZsxxKEGeVpfjZU6Kx2BNtDCVkbcY4Gbi8LHaKcCDaCAjXSKmf9fykjSB4B?=
 =?us-ascii?Q?q9QHLWrT6j8TKA/VvpxONVbpl/52TFhvIxf4nftK9uO/8ju/9Kx2ygTkd6zg?=
 =?us-ascii?Q?PHQiXxY7RrChH2Zhmkw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c542b8-bc15-4059-bf0e-08dab8fd22f4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 15:57:38.2485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mllHL661QRfa0Z4HSGBQ2uPvxOn4veiqlVkhbWPo0kNf4flUAO0i/rcRQByMFUxpCrJcVUvJSwCAqpg6OavlEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8323
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Li <frank.li@nxp.com>

Replace pci_epc_mem_free_addr() with pci_epf_free_space() at error handle
path to match pci_epf_alloc_space().

Signed-off-by: Frank Li <frank.li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 1863006cc36c..191924a83454 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -571,7 +571,7 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 	return ret;
 
 err_alloc_peer_mem:
-	pci_epc_mem_free_addr(ntb->epf->epc, epf_bar->phys_addr, mw_addr, epf_bar->size);
+	pci_epf_free_space(ntb->epf, mw_addr, barno, 0);
 	return -1;
 }
 
-- 
2.34.1

