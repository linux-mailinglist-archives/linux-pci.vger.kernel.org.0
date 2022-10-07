Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080BD5F7DB4
	for <lists+linux-pci@lfdr.de>; Fri,  7 Oct 2022 21:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiJGTOV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Oct 2022 15:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiJGTOS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Oct 2022 15:14:18 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7ECD77E6;
        Fri,  7 Oct 2022 12:14:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iepfl7snjBwzJppU/IWZIhWxhYSAQLH0r05q/SIv/l64mTGu8zuKIOWiUzn6P1Lz5YkpdSV7GjTOjFW+xfmmbZ+aG3LvCu8fOCFrwpzoo62gAYunFZWFpefNqc1LyXPP8RXS27gdRhwgnNXjCf+Rg1yuCnd3pV/h76bJIYThGWQmMoaUT6pGbI98s+XH9kZFgIdF8Dd296HpjFj7Fg4V0wNejR+9zhu8qe5qWa7wxnf6zDkvOUhPoRVsHfg9rOhR4YABqH9vxlDKbian2Srn4CqxeugHm7QjteOVb4f+tn//OJ3M12d9H3ubo/n4eZ2vpFl//wwGhAcHtwBnn95Llw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyD6aoIjEVUqZqDnSZCuVf6c3XoOXvPwpCEPm4asbEs=;
 b=isJoCt653zp4U/8n40toxlnGxSRW8huTpx9fkl6lo9FDzCDzqBUGclc/AuzN5sGDa6Q8WJM5xdrf9AorXwaFH4zZRLy4YpqRRPoxy69DCGRcb7UOCzlztyX3KVQku22Y1mGkB9IBJVK1TGCnYDXa3mxL1oIDHFQRqXj2REOsxno2k8IA4r/oRGsiX1NiRiFOMN4hS9fZivTOvPFujhIjKNOgiAMAlGIPcdC8XJLl6eqLjcw5EOyGWZO9E3xFHSTab4WmgML6Hj8+7pZpY6S0Zexk4hUrA1nleCnJMXv3hqB7I78l2n8csUtmvwl6YGY7Hd8Kxmk1vSwL9YgGdgfG0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyD6aoIjEVUqZqDnSZCuVf6c3XoOXvPwpCEPm4asbEs=;
 b=Y4dG8uXObixhTR/okIEq3fvXogTIleLeEWLeuLeNafafTkX5MIRhMBb9cxbOJdmt+lDPJwONde/NRXowVGJhZCXMdcsiJLVtbJr3NOnvxE7eePh3Tt/Oa6wdlvpwZyZ5PgQWelqpS3xrlLwb59diKlGu25XnRGRl/GIhWa/rRqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by PAXPR04MB8192.eurprd04.prod.outlook.com (2603:10a6:102:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 19:14:13 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::54da:4ebc:2916:de90]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::54da:4ebc:2916:de90%5]) with mapi id 15.20.5676.038; Fri, 7 Oct 2022
 19:14:13 +0000
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
Subject: [PATCH v13 3/6] PCI: endpoint: pci-epf-vntb: fix call pci_epc_mem_free_addr at err path
Date:   Fri,  7 Oct 2022 15:13:23 -0400
Message-Id: <20221007191326.193079-5-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6707ec1e-deba-4f52-8443-08daa8981e89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LiAqTK/fnQkfq92m2ydXd2FvClop0QN70atTDondaK5cz0hcVNqc9WWF4YwD2gjwfELqnLMQTwBH0LruKXnler00Xn4JQZbWJ9oHpjb/TvNCHM9/iao6k+OviGsm5t9V86Z40NQ3ZEdmenEp3YUu/ZIBSnSDUbfhgjICah1CfsQqdPM4bjur/2HfblCvNkKiotPJ/7QyUaTkAkzB9vJQbXluxtCOJpXS+cfZnaUQ/DRLeAZPUUWLiLkyYy0snHEmz67sF8tGdomUz9CtX2uUpGSG0h4jG9XMAh/Sa6+1M/qWeXBjWDAf5Lgrt4CV2bkzzJLsNB+WBetkXmWOEmxn/lPO9a5/aXen3vi08l5Xkp9GDtwav7ocCQu9qwhv6LnQOcyFfWw5iHMEaYLnbLiwS3KtVuyNlOOhVP/Pqyoy27KvJh9jfkmXWuy/xBZZHxaQdwgsmnrETBWG5bWZO0Qe81tK/d04Fu1p0Qad1blwatEw1QzVawA0oHdsWf0DIHNnOKiSqrkV+soi7UXU0X/iRca96Dz69AHVKDLNwLg3oxjPaA0/D66RTlvVw9SICNCGhQiOtG/lDE25+yMGpYXrMTDBNMXpA5WFgZQqPDbrm3LFQn1K8rCXSDVdJ7crCtsuR6kSeHtkAdOGuVxs+VIzxsEICrn8FdV2sXBju2A2r5S4vMIyoT3uLumFbAdYR7tiWKBfyn0TyqfWgOHs6Mgf3Lr+8eso0SDAgLk36ff+HLszIHYB48SQkkFEk5BR8zQ4v1SAaylYqXfLNR8BvTSaLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199015)(66946007)(36756003)(6666004)(7416002)(38350700002)(8676002)(38100700002)(2906002)(1076003)(41300700001)(66476007)(186003)(66556008)(83380400001)(6512007)(8936002)(2616005)(52116002)(26005)(4744005)(86362001)(5660300002)(921005)(6506007)(6486002)(110136005)(478600001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3g52ECWT/4s8HTvqsRyqLg3C0uEu76N0ZaAc/QntrxIcDuUvfUSlHo83SwQv?=
 =?us-ascii?Q?KzHiIP2Hu6DJ6HFjLqkNpghNI9Hu+nJqMvtOBHPwqjav5DKkeO7XGv56J15f?=
 =?us-ascii?Q?sC6WpyYlfdXJxyTsCRnO+gb8vlpdVg+yWPVkR8vMyqgo82qweBhOjo8P+MQf?=
 =?us-ascii?Q?rvHNnk0uiNK7/XmTM/bh6JfWwb+LUQpRARG9y9iBTQ7+815M4WkRJqrupJTS?=
 =?us-ascii?Q?ETmlAz4zUbJBe8aCIJtxosaJ7Za/TRXD2Pos/5Q7jH6K6EZ+8FZkaaaBRZMV?=
 =?us-ascii?Q?sheqgtNMIvVDpksBWOKwVUBm0/PuQTWVfKknX+jZMYRSDiu8l+luqKmHeWeJ?=
 =?us-ascii?Q?rp2wfPY7prmP85sDbp/PWW6qLiQE9h3mMcZkh/U76DgSFCfQL83tVqnTa0nR?=
 =?us-ascii?Q?M2kg2vZpuY3uJR2rONqY5+MgAs9VgXP2JV1aqFKGj0dJBVAqtekI9CPfPtUM?=
 =?us-ascii?Q?An3o83Ip8s3KsJeetI4x0+iEIhNa+2aoHSRn+Xv6eLycf+IeUpTvCXKrwDYW?=
 =?us-ascii?Q?71BX9uA9F0kwsuqMJLpGwAmzVupkFe1w/RtrLqXPt12f+BSDVk57ee0e28ry?=
 =?us-ascii?Q?TAlo/MxZc/DSUuNLILo+K8VKIe8jf4aamrwOQRE5KeBGgyqzj3ipwOGU/UvI?=
 =?us-ascii?Q?JT0SPGJ2W7qRMXYaVEL+fQCccw7fGzY8ja7Bc3b4UARXsYzL8sH90pB70Pf8?=
 =?us-ascii?Q?aT0mA0Uumfe94avhOTqpFbkvgdZSRQJ0M2BY0uLx7xYILGKL+9PACYxw5Tx+?=
 =?us-ascii?Q?zKyvqr6P8Fu1utiMMeH/yQF5loG6BnNbtEe+xAJZaG2iKgV8kBuhlQDyxhZ/?=
 =?us-ascii?Q?mujqmIPEszBbO93RG22C4DoVtzqTHtOXyS4hBfg5MbKR3mprqXzJ6sebk9/w?=
 =?us-ascii?Q?SB8e5jMJqBynSgN4//7atugpJTwObaPuBwWkVRa6Hq0UglCdF99JHanLe/Xe?=
 =?us-ascii?Q?plkn1a3+XxjtPYMPSMb+ury66oqmI0dxiGH+KAtk7NZ6x364vTqDoLXCcHT+?=
 =?us-ascii?Q?0WbIfBb0XhdvMyeDdMMl9csatrBeEl9ZntE1PX4HtQ9khTZ62y+uVSwCL7AE?=
 =?us-ascii?Q?p+e+41ezII1KUkXuhOmzPUG0Q3ukM+CofNSmneeoD4PfBxeYJqHtdBMbeGro?=
 =?us-ascii?Q?1CgTz/SCpdivqhCuGbNvRnMtsEYqfXfTobfKLpjoJaQvTOYACw002wEHNMCZ?=
 =?us-ascii?Q?I22YIPRwkKE/OsZ8oQ0tKqEpp9rCf/X+lELgAVRZBz8LsSEung45sU7Xebzy?=
 =?us-ascii?Q?mLVq34Y0xvN+I0aC62TuU9xC6Oo1glSc32be/XAwZl3dSAgzNoDJttPYPAMR?=
 =?us-ascii?Q?MVn+69045wLWPFDHtXX9P/xb3anguZUCOITY61dBTVv2CqBPToUKANaxle1L?=
 =?us-ascii?Q?Bn7Lph2eh53dNUQpuoLD4xBTIw/itDnlQs3o3lkvI74KC4w1umH1e4Ms4e3S?=
 =?us-ascii?Q?mBspEKOJ5LBEquMZPwrC8gEb1vvuDmL/9RJE3eKyAmMVsx54ieAVdpDpzd5e?=
 =?us-ascii?Q?m1vmVuvtH4DkIc+lFnX0D8ZZHNoUH1SUYet1Ta5O/q7NnnFCX6YcJs3pSmt+?=
 =?us-ascii?Q?BsH+QjP5lOyvghYYfKg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6707ec1e-deba-4f52-8443-08daa8981e89
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 19:14:12.9838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: znwNLwWKSRpxF96DoFnAXnHdZNNWrF/xVJGNmAkHpBne2mO2C3l3chPonEv5I4tsvtlO0bfKrugEMlZaOYTouw==
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

