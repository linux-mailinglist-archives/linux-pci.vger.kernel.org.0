Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576C15F7DB2
	for <lists+linux-pci@lfdr.de>; Fri,  7 Oct 2022 21:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJGTOT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Oct 2022 15:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJGTOM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Oct 2022 15:14:12 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499ADB9799;
        Fri,  7 Oct 2022 12:14:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fm5eJ7cH1DHGOqioSI4Fblty0IIPNxTaFcpCVtroR3G5ktjxK/FkdTLaoIGbEP2t9mDyJT0SgrjIO3GsVX5hjtSgUxv9K6Jt4lxoJ3trpB925CQH5lg9fuVyoObqb/O9E19eJ0YL+FOmeL5+cCg/PzbTAal/VSf0Ny3CGylxGafXgz6k7IQGrlDf1eBeE9G1YJTP855x7t7UZ/hhO9u8nIt4aff8pwLJAfxBIfUBLIeDCcxK81cR4Yrg6Z3+Bbsvcvc68g1XZywTMMZs1SXCNWcTcZ3qOvIgmgn1I1EpBlysdCUyaf6twpIIl9eY68lRB7do+UQBaXzkMHkb7sXKkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0aTpYZBIayAJTU8Q7biEmzV0MnRHl78tQiUE5REJug=;
 b=n8mdteVoI7zUB85q9jGZzIODrDSmGkrHRmJaPrhYuuo4MbA7FYrfpRvTXAMsBrYYLkdSB+FLu8zqvS7S3cIiZTXPSm6qgv5VHMfX+REBE79/gdPh/7qif+LEXsQxIUOY5APUYDCMuG/eQp6cITidlxkyynhfDuzR40XeThrGJyyKp9i4SXIFTxujc5a6NvrAmLZ8KC44J4tCXAXIhfEsfFjWvJwT/DmerbgrT6t/RrBWiiaiq/K54CbbEncQRaismjpCxv//N6Kak7lApVOVcIbPOZb5NoieVtU15mEo2i2h/KGKeVpufKi+SeU7Evk7jTynNhCNSZDfik/DHsb7tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0aTpYZBIayAJTU8Q7biEmzV0MnRHl78tQiUE5REJug=;
 b=ONP/xp/BC4X31vkPv5dDZA7QAGjcwOKdL7M+6RIUMdbdtrg7WYwtcFulyxyuubgFV7Cqz34sNs1mkE+8zVg+RsvvJ0MQepZttUei0hw4zjrg+xisQWJjySA0OjHv/LL72Zv4c8lFUOSxPL2SUD2WUrj+joFQ3jFV83tlbskQDzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by PAXPR04MB8192.eurprd04.prod.outlook.com (2603:10a6:102:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 19:14:09 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::54da:4ebc:2916:de90]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::54da:4ebc:2916:de90%5]) with mapi id 15.20.5676.038; Fri, 7 Oct 2022
 19:14:09 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     imx@lists.linux.dev, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ntb@lists.linux.dev (open list:NTB DRIVER CORE),
        linux-pci@vger.kernel.org (open list:PCI ENDPOINT SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v13 2/6] PCI: endpoint: pci-epf-vntb: Fix indentation of the struct epf_ntb_ctrl
Date:   Fri,  7 Oct 2022 15:13:22 -0400
Message-Id: <20221007191326.193079-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221007191326.193079-1-Frank.Li@nxp.com>
References: <20221007191326.193079-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::20) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|PAXPR04MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: 69cb62ce-50c7-44a5-3a11-08daa8981c84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: asr8XCOi1FzJ2lUJV5QmfzeM5ooUpP7dnuqNzbETs1ID8EEZzzfhEtK3BL3JdoaD421/biPgBUbaNvEphpya7BLBQnqpTuhyE3PMkSqcRidXc3LTlmn5i9TjwvU6ttJupcY8qt5MuLqnRHqJwm9Qz7yFhmpRfTX4VW571OnhK2PJ574VyLQkn4kbebAhjAm6DKqoDc8OHXl1/lLjjuD+oga97xhybDluGALPWpwObOIAc5oWgSUiAe8zub53mE53OjcRt1dp676k8IYd3jYkCHhiBEOXJ3+7djvrouBC/ILRW6x+Dt4u+YvzlYJOk6htCOdODRHAx6e7LYLsXRYiRPqG4SBb2Hwr0Bdc3NYQlfnjyN5b0tUrp1R2/dQT0QhRUR+5IOfIwwNfc6EsJtHAlArrErhaZkFec8nNnRWjLMXoK/0OvYYYaBlgcOEUuHn35WBZok2zZIFrlijgKczquP4ftPcRwbVlV9hvnmNbMAnhKGLi+0yJJTVqI3O39c6XsqnCoK/UI4Jh+vYhP7w3f41nMnA+F0RzQY2KSQpkhzQhvofkWIjo1ETQY1JwJCHvVAjeqlmBxGgECD5vlpGaGtSQOx79EhAxb1JW0PvDwkrCCwzrLyHsqMyD/Vqm3sSPeTu4isH53RDlEYuLbgA9FY6qVn/cGqPjcs0lfchpRAznn4mWA+cniuT93Zjjl2qH3wIDv5D1BkUHgJ5x/YP0I4IKfFyPDbNASWrsBZKsF8hpb84STvjr8upUqahEdG+0lMKJRznmp2sih9I/kAdFhxjg3Uh9G1PJmRuKWibit7I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199015)(66946007)(36756003)(6666004)(7416002)(38350700002)(8676002)(38100700002)(2906002)(1076003)(41300700001)(66476007)(186003)(66556008)(83380400001)(6512007)(8936002)(2616005)(52116002)(26005)(86362001)(5660300002)(921005)(6506007)(6486002)(110136005)(478600001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZSGPGWp0DTm6o2ZV4rt1vEU9KZ6YTMcGt1THtCRlgrVAlHcghlz62Ek7eMOf?=
 =?us-ascii?Q?twDxIVbXe4mFa1z2NZy5sC05XJ75bLUczFfHp31msGciTAKFncdlYeN0NdKx?=
 =?us-ascii?Q?BxSyUxNxFNJ4WP4Pw9BMBlMR5hhPf9OfoV0lIE6DAQ8Fuo5XQjdKSV7ekcG0?=
 =?us-ascii?Q?uDdR5TeZHMmYT+cmpb4On/YN93SjWOGG6UkHa03p7GfUKy9/cBfjCj1Pz8mu?=
 =?us-ascii?Q?3zxrzLldmsUOkhuk4CBq/eDGOi0uj6cKEP8yNvEUz25LdzasHO+MEEio6W+s?=
 =?us-ascii?Q?A1AM5smh++A/RVOhrU8hS8ajangqjnRymAGWtCqrGdqTw0WcO71etP+QdJ8P?=
 =?us-ascii?Q?HYuci+059XaDllVwjOWMBT/XmWJSJW2KX2Qr1rBy+WDuKxchOha7eRMc/3PT?=
 =?us-ascii?Q?1sExGqQC9TMpw52i/wx77mYuM73nYVd4fbmKAO68UxKEIs86SRAWRPhS2dfx?=
 =?us-ascii?Q?FlQcIahzcWi8kCtWKmLlcRabAP6dSCr/+a+YLNzfjJNWDoO7z6/z+ta8Eg96?=
 =?us-ascii?Q?KNeOKEtI9pg6zKjH3M8183gPmD2sbqttBSveVolAXi2KaooJEzq7WJ8kf/3o?=
 =?us-ascii?Q?yiFRrs51XFPXY/23HKoJAzpGGe1D4su7oYtIMfTc7urpciPmIhHTJnRMKrxE?=
 =?us-ascii?Q?hrXXjz3JRAqtuUseWs1uIXleibiLyEZynutf5OlQdd3b4ZgVA6qE7GqiVdNi?=
 =?us-ascii?Q?4BlZaFNIMfbQUFdawY6mTE7tRnDceUBcIQii6Y1ZZJ6lW43iVcfTcvdEo6RR?=
 =?us-ascii?Q?xJrqFGu7hLJV7yEjdZa62a5XFitrxG6uqfgED6T62Yd+BWIwB2cdkPBUae83?=
 =?us-ascii?Q?P3FNMK2z8E+FDWBanvocnlor5nFCkiBWD8cf8SmOcHV9w4d0WkWvJ2zBffiQ?=
 =?us-ascii?Q?dCDTGCKmMksXzus0gH1rVPvPcdOsg1ntJfmwkguWFrA9bqB/wTlOxPcUEaMD?=
 =?us-ascii?Q?CbV107q/MKIxQNyF8NZWi77u5FmC4YBjXLjRrd1pDjpe7cr9Sr1A91oen+qx?=
 =?us-ascii?Q?oo0BtgiVx6tBaIs79ZaixAQt+BbEtmJdv2saB1KrXY7zuW1Fn7vYp/Jk6epV?=
 =?us-ascii?Q?/8u9cLSwnJUqKCNp+6p5Pzb8tzsbvZ8hPoaIwvrt6XLwQltXf8hfWPr9ybeS?=
 =?us-ascii?Q?tbV4mBKA79ZAiCLl0G36lfMY5woO87wZZze8E7wiSWuvf9938irpTyTWnxDe?=
 =?us-ascii?Q?A/xc4P/TedIWwnaN4NGjpxYKQFGfrMXJm4Vl1eD2gAThPxN1N+igVnbSKsk/?=
 =?us-ascii?Q?vTx3KDNzvwKW+x3RbBWv87f23tAhJ/Grncr0yoU84mx/KfC0TqXtB9h45D2Q?=
 =?us-ascii?Q?r31oQkTLoyksGmxWb4uG+2RLPGd9ZuigMzcP3eAgV7Q2pfJL0CPmqRXpeGqv?=
 =?us-ascii?Q?bBAWMxL4GbV3PPOTBp99OikccCJhaKyS7MMvcbqSKU1Qq+DcDBPMhp4tSrFR?=
 =?us-ascii?Q?XXyInvG5ROnQU8FMBItCgSP8k2xNydI+9u1P7d1OcQq4b14hkRl9v+fWtYot?=
 =?us-ascii?Q?25BWgm7kvOCHLPAiPNdiJ7Nz/rnh4UIxGr+NV2KnOQnUNad+Z5l7H5U9Ygbb?=
 =?us-ascii?Q?pMLmnWzBaCubSpDqTbs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69cb62ce-50c7-44a5-3a11-08daa8981c84
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 19:14:09.6237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhfM4SrBLJvN3lXpbJmCg+r7wp+6F4J7heVMAjzvqiWVfv/22frhxMJPkwEol9hKVVBn6JbfYZqMnIdP1Rt2Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8192
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

Indentation of the struct epf_ntb_ctrl align with other struct

Signed-off-by: Frank Li <frank.li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index c0115bcb3b5e..1863006cc36c 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -99,20 +99,20 @@ enum epf_ntb_bar {
  *       NTB Driver               NTB Driver
  */
 struct epf_ntb_ctrl {
-	u32     command;
-	u32     argument;
-	u16     command_status;
-	u16     link_status;
-	u32     topology;
-	u64     addr;
-	u64     size;
-	u32     num_mws;
-	u32	reserved;
-	u32     spad_offset;
-	u32     spad_count;
-	u32	db_entry_size;
-	u32     db_data[MAX_DB_COUNT];
-	u32     db_offset[MAX_DB_COUNT];
+	u32 command;
+	u32 argument;
+	u16 command_status;
+	u16 link_status;
+	u32 topology;
+	u64 addr;
+	u64 size;
+	u32 num_mws;
+	u32 reserved;
+	u32 spad_offset;
+	u32 spad_count;
+	u32 db_entry_size;
+	u32 db_data[MAX_DB_COUNT];
+	u32 db_offset[MAX_DB_COUNT];
 } __packed;
 
 struct epf_ntb {
-- 
2.34.1

