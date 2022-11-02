Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BC5616496
	for <lists+linux-pci@lfdr.de>; Wed,  2 Nov 2022 15:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiKBOLF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 10:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiKBOLC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 10:11:02 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0372612C;
        Wed,  2 Nov 2022 07:10:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGnNcw/Xi/BGXG7PCoYve9h9/T6lpA2bqcyBfqh8lpyhg+OxJ8VBnuygHXbVXbolEMZVZN3xfVbr8/HK0Qs7QRZZv4hoYbEVGfE4/aETFQ4pPm7rT3Du79sXyGEysG0PQJIL2uL5FJRWyON77HX4TQJj7A/qAumPQr0DD0zCZqFt98r9y3EBQ3BVXpyvE5pZ+qwiftH988HNJq704cQKoh0A0KuYbpYmS9dRQfPTT4aTfYP16bTlPWOXIy91i/gUqWuqcQgpeRxiozLLOquvBAvj7BPTGSMcoSVzVnFTroahi+LX/MoGj0ved8ICaUFDyZM2n1hUAkoLIgzigXNpWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cg9Cz+TfGC5o2RUupkOOm59g23D635oht16Vk34QK4Y=;
 b=eGorMdLoWbHZYIH3wYHxts/LUtkIyNG+pSj10WndJRn1O2z3FyCGFx9hxBsJTC5vdX9MNfj6/9iIhfsk83pDfLiXLnWY2XzTUxrdWWmCLL8P/ZMp14mTyznBMIFw92vWr+IfVVdf3/7TlLf9ts9be+redyoFezWYucM1GP/WSy6U1wDHWTlukrLhbj9xIOrRvtxK32FhDPwn+cE8uvrYWiFFNWFI15OICphcTatvKs4ACfLLgjvaAYTbUccMrRC4VGg/p+cEhXmJY4Gu/DQmF558XkXhi/UY8sftmOFFSMSfNgGGZdwXyufbb6UU9/gdGuoJYDJQkXAWZ7rYzvTdBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cg9Cz+TfGC5o2RUupkOOm59g23D635oht16Vk34QK4Y=;
 b=UBlBrbtzMnTviAhWLZO3l7L5otv9NIeXWowO51Aze7CgWYu5TVKoCMWrjwlg19mvBR3Dmy9kU7czseNThvBSgvuTPR0S9Nqq+tE/vtLFfon5NGY1ylm0ZyDkc04uOqAsynnZsYihInm9mdfyvpFid7qgpOsrt8+xa06HpwDMGMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DB9PR04MB8234.eurprd04.prod.outlook.com (2603:10a6:10:25d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 14:10:48 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%11]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 14:10:48 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     mani@kernel.org
Cc:     Frank.Li@nxp.com, allenbh@gmail.com, bhelgaas@google.com,
        dave.jiang@intel.com, helgaas@kernel.org, imx@lists.linux.dev,
        jdmason@kudzu.us, kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org,
        ntb@lists.linux.dev
Subject: [PATCH v16 4/7] PCI: endpoint: pci-epf-vntb: remove unused field epf_db_phy
Date:   Wed,  2 Nov 2022 10:10:11 -0400
Message-Id: <20221102141014.1025893-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102141014.1025893-1-Frank.Li@nxp.com>
References: <20221102141014.1025893-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0210.namprd05.prod.outlook.com
 (2603:10b6:a03:330::35) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DB9PR04MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: 3abff87d-dcbc-4cfd-229b-08dabcdc0aa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4uZDE39GaWqLBAxxC1H944ryTkzA7gmnd7YuNExTOMPrxaYZQYJztiXgan2GVyPRoD+ngZuILsnq/ZSvOf6U/EvErdv/gj1FoQAD72rPS7ZG+yqpzgn3OscbJYqRLbh2+UvYfxSnjnGlnF1jOahoZxH5OC0VRFB4u2mDVv7ibGP38C5DQVDl04ySGN8blxqx/HTTSjLFXjo4gQAkDfEWZuBnLms0QUT0TRp1uF2X64YIYUMoqqkoc42+IioaYWrRsWI9cVeiNmOIDSdLJ2Kk8/9kGqvNiJEyb/dl06xpZf07Q58r8Df41xL4p7WO/0Y8aaZmQqCcs9wLL8wp1+s9aakFxbDOm9BzCgak8+HW16jQeM9BoQQWX3C8UEeUzxAPSAyGlcZCgAJENgqgZLGmIP29KUTcLEVMFPlNw4+WWyEQJJVKyJYNrlw+Py5xy9zWdzm5hOQKllNwc9ObpeeoOYx5cn7ifHACbA7AbcXIjf1LxjYwB8lfD8WFzGxOj/9XiKXdkAP8d3OKu0Mfry/fH/2pycOp+d8Lp5JthfrZNKZhZA/lO870gZU5bm0odANDDNS+Bn4120xJJBub1qk57aMGYhx0NkZuJVAEb2PFw9L4nMbCWhOrrtu+bYy7x4o6DP9946e57F7dROIPE8FY9PI1HhfGG3eRh2GWCTqwkE/NCw/EhUoPA0uMZxtq1PAFcm7/VZ2Q959V7WwP5NTanqBcjW6DAkQvnLcYLdYFbGT18NEUPbKY6xGkA4nyEgXfbq8NNanyVYBgEx1Wf/3cxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199015)(36756003)(6916009)(6486002)(5660300002)(7416002)(83380400001)(478600001)(2906002)(41300700001)(66556008)(316002)(8676002)(66476007)(4326008)(66946007)(8936002)(26005)(6512007)(186003)(4744005)(38100700002)(2616005)(1076003)(38350700002)(86362001)(6666004)(52116002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?00zaARr5x/zZ9PNCdvJ+vVJA9xQEuEGqQ50EHeE2KXxTE+hYM4oRknO84j59?=
 =?us-ascii?Q?D9k7uaA9zJxCQU8ayZb681ycUcZdV0qNmYQtnWoYB97cy/dyU2zyfwZAJzwL?=
 =?us-ascii?Q?Q3yr+bakUcCvq+QkvbFn1mRGaQZvt4UcN/Bci5TTVABPyxcxaUQNmL2UNQZn?=
 =?us-ascii?Q?ZSpsy4w38xVz1v9mUopCrQ6+hA6ZAbnKjmj8t5diDK3oCRXuw8JsEKwXXsmj?=
 =?us-ascii?Q?sxGi+ZqDVecXJoqyPgAnDZqSfQ/gr8bcyAhYZFk47a/fUB1kWiXNq3nGNjPn?=
 =?us-ascii?Q?8+2EgaKwuUG4FwGRzV8Gw3P/tpJNy1clEBm6Gf0TC3EPw3xL6ciAx+CZKG7B?=
 =?us-ascii?Q?OptrHGqrTr5HVRFCe83k3WN/9Ec5QyncQ00qSA4hnFKAdwnQQS8Yg7mmIqVZ?=
 =?us-ascii?Q?9U0gnpGkYTJ9PAKIdkQ8T08trqoZzmC14tRCL/dw5f5MV4seI8Efl9uOrOYu?=
 =?us-ascii?Q?jbS4sHaQ/R2Eb3Vu1lxez676SkCrDRyoiyMRKppQ2N2y15q6XlG+x4ZaOawA?=
 =?us-ascii?Q?lPtz70ykGotiJvpu5eNDj6B2rResTpFLyTcHwwgkcP20IkuPgQUY8WYskq3r?=
 =?us-ascii?Q?cY4il1ZeIwLRuyaHgSwpOSYBunhiLHc7+avtWyLx2yAa89JxtuCPu9wiCF56?=
 =?us-ascii?Q?i1s3cWX1SD4TwdE5taTMdHAOKve8VTDlz1BGQkemC0DyWQYW8k9TLqW4R52W?=
 =?us-ascii?Q?6Zm9OKEunVTrGDMD6NSuxkaniQwn6w+1RS+LI/jKdUOXsVFiTiG9cVqxyTFs?=
 =?us-ascii?Q?50TJbBTlW5bj9WSQE+5VzZEnqEXtm6UyyfdIemXphE4ivv4+q2TzsdYlcCHU?=
 =?us-ascii?Q?Gcwf3b85SjCFrUkWX1VvixU3XwvKmNWVFDR8mslBxaBoMjSJf2LfvLn2DPec?=
 =?us-ascii?Q?EJBd5IJ2qnbO3d4GLr3bVHFrzjbQu7IaCiUWCH4wCs9HlmI/OGlW33Mex+6D?=
 =?us-ascii?Q?CiktWkxjEBcBJRCrAqH5gl/Kg/RbJfBHVZo8tLEX0EhaFWdTXGucOxxPJHaY?=
 =?us-ascii?Q?/U756UuiALprGCE/V1K/kj4czqVdlSpH2TsEQaWeflWIy8y44mQKq2/1PL4h?=
 =?us-ascii?Q?puEiuzMMWtuH1Ebeoog9CumF9YdEnY7zgAuWU1dzDhOErhO+xneDFkrr1SE/?=
 =?us-ascii?Q?3p2gRCCLAVr1b6Dfe5+aYvTNLjMsBZioWb/mWCM2HS29DidEbgTgLmFSaqL7?=
 =?us-ascii?Q?chCusfZ3D7MfVwi/PXO+GboI5QgdQFZxFsfHI+PCu/FC8kZrD/KaA+tMpvuO?=
 =?us-ascii?Q?e6+6Gz9Vfuo9cRlaybxtUz8yWZUTL48fWfAHvPXiVfgVOFlNP+0ba4T9olgo?=
 =?us-ascii?Q?JMGz+kbKnex1gx6oeqvZmznAm5+EmJi5Gf/d06l5K7DCcfglb9W+TInqRLsB?=
 =?us-ascii?Q?1muN45uHbw4Yi/ZxMP92V80G4NgWMoAwpDt818y2w4Nrq73u0FjOgrithFh3?=
 =?us-ascii?Q?KQBTRMjQw3HqKUPZJLgnwH3Y0BeUn70L11PkaNXPmmTxww+NujQFJc1WVp+9?=
 =?us-ascii?Q?s6U7Oq1gE1O2wLx012Baw6ngD28JIZ0ww9fIzqZcegRIasBh+zEzDb114T2H?=
 =?us-ascii?Q?snfcz7cUX+mYMFtPA7ink6UuEjcodlhL+NuzRwPM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3abff87d-dcbc-4cfd-229b-08dabcdc0aa8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 14:10:48.7089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLEAFoOtM3s3X1IjQMXTIIoD5qGbZ5xjw0ZdoGkh2fMsVBY+ze9AdSUjFnvJJP9mX59AFx0WjxX0OSHT1ZQsBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8234
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

epf_db_phy is not used, so remove it

Signed-off-by: Frank Li <frank.li@nxp.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 191924a83454..ee66101cb5c4 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -136,7 +136,6 @@ struct epf_ntb {
 
 	struct epf_ntb_ctrl *reg;
 
-	phys_addr_t epf_db_phy;
 	void __iomem *epf_db;
 
 	phys_addr_t vpci_mw_phy[MAX_MW];
-- 
2.34.1

