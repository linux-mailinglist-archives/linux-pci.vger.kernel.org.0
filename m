Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2056604D93
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 18:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiJSQjf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 12:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiJSQj2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 12:39:28 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4BB14D0E;
        Wed, 19 Oct 2022 09:39:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddoDaHhdelUAn4A5CCCsHcjhMwaMeLIRN9ux2mY/VVmY0BAjSMiAY0LMtc6h/JRal3nx+Pm20qnglxxSb2+BOOeq8KjhKsNrEMeunM4bI8gMObVwa3A/7PCbk2jkGP8CbmC26FLthzMYn323eHOU6K5LyYTPvcm+1XKS0BYBBKT5M7JHT+6VLwZfJjQZvZDhKOsUE4FEgSxqFPMfq902AsIY2QMBh7NJLlreSE14ag3WPLBpGjqjzc6QGxEFxSA3tamjgioVAmem8qqmTFTGy3QBNeEissX5phAtjZXUOmiTQn3/iEV1zSxHzZ8+luXCNJ2lVY86URGK37j49Y6Lvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0aTpYZBIayAJTU8Q7biEmzV0MnRHl78tQiUE5REJug=;
 b=XwzIcQs22lq/09k6IcsAamiFq0QkeTlGg9KauX/XbXiGzsjpgqjx3WobaQIUGA4qmPpRoRO8J6oe/jdaXrAKahtGviCnlR4tGAjEbIqEqg3MnrTVGWmsVIr+XBRDtx+RdLtTpJ1HEH5KT51lt3uzALIkSk/r6V/BVXtWtngEqdLiGHa+t3J50PEC6I1SK8Cs4TH8C6bR2adL709Kohx2yIUJ/aqCNTMdiYnLNcoXm4nqsegXJnx4NGOG36h1oPFEjT+kaEwYmfGH7SCxMlFtKLrMEMbg807m7FMMPxkOzgBWii+bnYSBZROVpIfsWBVaFhIA/zH9tXfnPWsk9qvE4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0aTpYZBIayAJTU8Q7biEmzV0MnRHl78tQiUE5REJug=;
 b=Atxp4oCrksJMQucglq+sh2sgOC2icWLE3N98XrIsRdNBtZ3s5SKxPeac6y5o4J+lK+6gg0t9eHuPrjZ8gNAzsHkHV45qEoy6BC2J9Grhs8mZF67WUteUZdQq0/IAGiEutU3DbS0QhAfy1LbEMc2UXiVlPMpP8WSECzEgSjMOyaY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DBAPR04MB7318.eurprd04.prod.outlook.com (2603:10a6:10:1ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Wed, 19 Oct
 2022 16:39:23 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::6110:8304:5648:88f5]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::6110:8304:5648:88f5%10]) with mapi id 15.20.5723.034; Wed, 19 Oct
 2022 16:39:23 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     helgaas@kernel.org
Cc:     Frank.Li@nxp.com, allenbh@gmail.com, bhelgaas@google.com,
        dave.jiang@intel.com, imx@lists.linux.dev, jdmason@kudzu.us,
        kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org, mani@kernel.org,
        ntb@lists.linux.dev
Subject: [RESENT PATCH v13 2/6] PCI: endpoint: pci-epf-vntb: Fix indentation of the struct epf_ntb_ctrl
Date:   Wed, 19 Oct 2022 12:38:51 -0400
Message-Id: <20221019163855.1267295-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221019163855.1267295-1-Frank.Li@nxp.com>
References: <20221019163855.1267295-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::27) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DBAPR04MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d430591-4c3f-4db6-34da-08dab1f07a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +HgJJmusikCG8IIFKKXDYVJlw6fZdsUbwOA0okOwQEcBI7jJmHN0jaFsNykHIdwOE1AxhdztSKrlsBQm+JBVC0r9NvxrK9NBaILGwqBatWn2iKetf/rx3dQpWOvctEW4SHMQtzu7Ymoz9CSJxruhNiDKU7XIpx6iNTDG2AB3FBPUF74umf/NpIBOkJ6bquiGmr3DOHAUvN3cs23cKfkmjjIMGOQW7fjjBGhra8wA8eG7ilOZSwbMUOyvBK/TTNbbLpx+D8GXfqm2rp76k4vZTrgmWTZlzJlqqXVgfVPcEH0ub9W8zqjnVZbvD5xlnmqBMFCv4RDSXStqK4uK4BzhMCvwOqt5LzkX+lN0PqVcKERHntobRYqwJK/+amfyItW1hXKFuP95ptqVqSYBXSYAehm8XulSb3Pv5XY0nrbiivil4l8ZO4Eqmn9GdcgkUDZEkh3ybwpU2JZHw4cXoFMEwpTVL9suZHE58liYr5LLIwnl7LbRi1Rjit91TJ/Ejm9JRAjv46Ka4+1SgU9ApVImPcYI7p9VFUGGAqh/SNYZVd/1tbF+fcK/RJEGSqHfcdyk0RX7kjC/CJ9u4OCzk37sG+WDYj10idN7Yl+bjXNpKWYqdd1FfQj1S3MXKsLMEaJZdpGhiBz+lpQXFRTWGh9YAPOexR9Ik4CwBk7pLPdsyXDJd/NXZGFVGx0KHfcT6ikw1UvmSLEb21kVDUFrY/TyMDZ5zRWiGX40DlpLu9ekxCNGTP78jwbR41Q9HS1wPdLCgEQ2hTAV4/MXEw1B//1KpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199015)(41300700001)(5660300002)(8936002)(2906002)(26005)(316002)(66946007)(7416002)(6916009)(4326008)(8676002)(38100700002)(66556008)(66476007)(83380400001)(38350700002)(6666004)(52116002)(86362001)(6486002)(6506007)(478600001)(6512007)(186003)(1076003)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K5ujA53XOiRq+zJLCwEED+SgC9EY3l15PKW1Ji/AA1mhw6cRKSZ1nHjfsZQB?=
 =?us-ascii?Q?Img+1o9pJLmAHy2QGgB8QFZKaxrSAAcT20R8eSzFAMQxg8hoFrm20wOGz1Cb?=
 =?us-ascii?Q?c36ykzbl9/La/mxvMmDEo02oiLVWb/u5fMFtgo6zr8xED34SC9Q08tt+KlXk?=
 =?us-ascii?Q?K84BTAFPf7FzYF0ydCRGvraqMTAJ/S0to83CSUBOUicg/6wb6R5+JcqiU8d9?=
 =?us-ascii?Q?ZDXjngvYQaAN0yoWcQIHnKi3PMWFv7Y/Zg+55w/uRHkZQZQ5/cxQmFnwIh8P?=
 =?us-ascii?Q?9Qi99aX5tB9zw7axQnQ15wxUI/VnJyjtdbTDRwab0+IgZ3igJt0n/YXJ9zfL?=
 =?us-ascii?Q?jqPfRwjfA1UJ9II8EG0gFOxkJAQPf92g8tcwjfpKAFPzHulTQ9DVaEUrV+dC?=
 =?us-ascii?Q?gPtoqC9sc7i0Sfg9bhvFftLf0tQ+Xyful+LXHDm07urqjhQKpNvmeo0eYkA2?=
 =?us-ascii?Q?9kNa+w0P5ylJ9SB9u0GspNmYvC8jVdZRFJYTGBjTPbxISQdp+EHTtOChe8J1?=
 =?us-ascii?Q?Sel8ZG1QOadmKV8qDMnZcTgMkE/H0bDC/A/ZcQKeja3oog9WzL/NZUCPt8kP?=
 =?us-ascii?Q?NCz6kkN1DKapgt2oTApPUo0O9q28Yv6vjiQVQ1OH33nh+i/nBo2LFBsTv+hZ?=
 =?us-ascii?Q?vFffK2ZvScFrs1n4ggZgCIn78CIwIm7NhfGoD0zH3xxB5eRL2qpW1gkvx6cW?=
 =?us-ascii?Q?Vbymo76ZfRbN2jbAniNNDef+P35O8mUZr3WcyaZPrkoM6TZkmmokLx5zh2cj?=
 =?us-ascii?Q?8Hjdso0YzjrBVbj08kZWo1IvC61ZlMfDbvaTEsXtb5RwFMKXC8haglK9KYER?=
 =?us-ascii?Q?rgYptyaFvzLZtSifqysRf4JYXjVl0D+Iamja8A6cYN0DoU5D+VJZ2Ay3nwEx?=
 =?us-ascii?Q?u0JU8eyqHZdTZK94jkQeAAHb2zHrS5Lq3ZvFZz7EFUyyXRHDlFTlYwp63HI3?=
 =?us-ascii?Q?VAJg7Gg20o8uYdwb+LPE52vlC26yF/fhRohXR6xdkGJhGixIqpidOHkKFjOK?=
 =?us-ascii?Q?LuQhvWpbwHonvRzkU5OLRRWlwWW1cbxsyH8IILkGn5eCe4XfEtFulATaCeg3?=
 =?us-ascii?Q?uKO7NeEjh/jy4Bnb1ampAbvByqCYye/1YEntbDfuwJBCbNEEGy1VVgQu0aNi?=
 =?us-ascii?Q?PyeCM85cGb3wiGV94PxCMKmYgxT11rZgoGfxGNKUOz0r9uKV5bi/2QpfnHbw?=
 =?us-ascii?Q?WkPSkSwZbOkJT782t+FGCBwwY2OxSLH2k63Nt4TsMFZp8Qt+VP/YJnrAiPYf?=
 =?us-ascii?Q?TDICSd1bkxwgaFnbNFrfh4x8/XhCvJBIvTaMOXNKANYnnO6edtcZ4u+8PgUD?=
 =?us-ascii?Q?9U/ijCbFPKADOTqZOeRjoNDdU4Zs4Jj7aovJn2VavWbOMhuLBOVIaqyNQp85?=
 =?us-ascii?Q?5I+7VEtxEreZkB+JO8//rb2c0yZ1jw432KQT8ZddostTd9PYuHbmz/mkA7W3?=
 =?us-ascii?Q?cXUHH1AZC9ffYH15jb+tXJkgXJjW//TNi/ERyhQLhrVQ5TkTCecBctmhIK2L?=
 =?us-ascii?Q?BruM8MMEG0hrLLIop61jPnczRD2cK/pvmTpr8C7rYRpj5gMDvoeRxwJXAX++?=
 =?us-ascii?Q?Tpxowt09eGLX1eecgMN9So2sNrYNq0C1xQueYYjK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d430591-4c3f-4db6-34da-08dab1f07a4d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 16:39:23.1775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFc5gXs4IwIou2kxBllgar2CZw47a7bTH8AMvAw+PtpMHQVNN6MZy6V7vKUW1vuRvzI/y6FdmCn/LT8U9fwhsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7318
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

