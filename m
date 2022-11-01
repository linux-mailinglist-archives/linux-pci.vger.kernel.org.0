Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C278614FD1
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 17:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiKAQ5r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 12:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiKAQ5m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 12:57:42 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70055.outbound.protection.outlook.com [40.107.7.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0911D0F9;
        Tue,  1 Nov 2022 09:57:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F60l9JoFyx+GQfdZwSCh3r0GlzbiJEvco6+ZD9NYOugkdfPucAYmd0fS+G99TBT3stn1z6G5AEEu5R34wAicIoX8Tj/DpgpHpVZVh4NFXI6tFcqZRCCfg+Ts7K9Hp6hbl/MZz0izy36EhmhwAQv+c3GgpjgshJYilR33xBqd7XVpvrpuCJ4mry7NKX1ER9Vkb3exgJBRpHghpjUF5GEpl8V5Whnyyi3PsBKXaORGEx+RJtFvmRGqUjlm3aLNb/pgtQIsMHG4DuS2CcrAQAHYxMboCFgHmZFQeFrN7ux8OTMc+oiSZm7HEh40RWvk4OrkSEG3EKn8vyvp3XhGEcY20A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSqxyTF416uWTAfTmzpTKKp4abZoPZOkUSlBUHn3j/M=;
 b=apu+iMGFDP7dhD425/iTHdr69RyxH7/NuDpt/h4rJGVRtRaHvzqcRe+Lqk4WnLFpIfEQF96W/qGl4w9Y8y0H/emMZ7eOC3FS/QtSDK/NjXEO0S3ts79algcilPudrnLPVdvmNNCLIm/F+1QMqCILwWKIodI5u3Zzy1mYYLuE5gHr0csDvu7DVwI4+p62bONx9moY2Bxnw4rU/ph+J/3EYcOToRVwI/t0pMzjf35YkD18N+yKUo1FjK8vcNOsNHFTkEsEHAZHrV4xUAPI6VkJ9OWDMGo5OA87QwFuGm5qOcrG3PjQswM4akiqE95NzLNiomZalqjg9g+aEWrThq/k2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSqxyTF416uWTAfTmzpTKKp4abZoPZOkUSlBUHn3j/M=;
 b=lirKo7xepSaiL3y29YZABSPsYx7M72QKkuz066mXbTC0QHZOjQIiFSVfMqJnwxyaBCiwNjMcCxU0+YPDcIih+aazYpPhPo4P7SjV3FjIN0oloPM2f5lEEcmDjMCjl7KQCgWb+RQGhBzfNPnm3cE8R1LFDNJmVHCBxYlnhG8k5Ac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DU2PR04MB8631.eurprd04.prod.outlook.com (2603:10a6:10:2de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 16:57:37 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%11]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 16:57:37 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     mani@kernel.org
Cc:     Frank.Li@nxp.com, allenbh@gmail.com, bhelgaas@google.com,
        dave.jiang@intel.com, helgaas@kernel.org, imx@lists.linux.dev,
        jdmason@kudzu.us, kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org,
        ntb@lists.linux.dev
Subject: [PATCH v15 2/7] PCI: endpoint: pci-epf-vntb: Fix indentation of the struct epf_ntb_ctrl
Date:   Tue,  1 Nov 2022 12:57:04 -0400
Message-Id: <20221101165709.983416-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101165709.983416-1-Frank.Li@nxp.com>
References: <20221101165709.983416-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::20) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DU2PR04MB8631:EE_
X-MS-Office365-Filtering-Correlation-Id: af02de2c-6459-4de4-e5da-08dabc2a2de3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1IjVS4ggcsGnr3p08bDmxNgngOPY6Khgjxwc9250B7WmZ/LoGqI/Wg9kPEt2/45ZvIYBZofvGGA3zGJeMqpH/mqPzUIGi35HxACxiRGZu5e+aHP0Nnu+Sm8PORJQ7SDpkuxslF0h8JD2bn0wOMwe/LhHFtVITnZWgCuoNNYtDA5bdk76ZE0MtHqLe1SV9X+8sWPIeq5I53qBCmGouG+NZO0lYRZSwMFNBZr9nXzP8QfW1OhOmIqQlcbFNp9nEdt4pCNDtkyDcbhqLS8gtshrFYghJiuj1zL7XaomoPP+KG6GIdHDPaGBHTWjxbdEPUgUr2zL8kBdLYDr0tFtdWffKIt2/iDma+nhOAPQ+QYrSNTW0A3Z24wPaqw+x1a9MFeRGrRzZHNkmwma4W0fvnArVDPHdFsE/JmudPtdx2g6a0OivumWqWGkU4Ix5tmBCiElSZAsxTeUy+A7ZsxcMkZO/Kid6zglilR7ax3z/k1S5mD56KIGs6wpPLiqs1IVNddjn6pwQsbrDZSdku3OmfSX01/djGGe1TPfHYIOhAA7kumUSESg12JVY3Vd1ydx7kbo03nkPiub+/JnVNlTkqSh8NBywEI2HrNurAyT7rQ753Q0/lmJSJgSww1Wt1u0fZRdNZL2bYv2H0DnlI7xG0rIUUzLBdFAlTcXZppWe8bZ3kfgvm/3JNqCjXd0JxzYgh06m2hAMBZPYn+unNN30sd9i7jO1l37K/BrDGVK+TsAMeqg/O3jY6qej99ELy1dwPrZedcUNf4cNnyh0f+euaF/cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199015)(83380400001)(36756003)(86362001)(38350700002)(38100700002)(6916009)(316002)(6666004)(2616005)(1076003)(7416002)(5660300002)(186003)(6486002)(2906002)(6512007)(26005)(41300700001)(6506007)(8676002)(4326008)(66476007)(66556008)(66946007)(52116002)(8936002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u6xjuA1w/SlDnNwvhMCFk7n7tPBPPeJCGyzwT8X3O1rxstDYfw3Iq4N8X6RF?=
 =?us-ascii?Q?WynNXBGaB+goB5FhBqVKFyXQFSQnS9PU9z+2yrJ/tdwgV1SsGdrI1eXRjcI/?=
 =?us-ascii?Q?HcDxJP49rUSJHFe4wE817fnuex4hpu5VfuP1Zn53w7otaV1CuHj9QKCbulL2?=
 =?us-ascii?Q?z9FdtACKidrqhfDf/2GzQPC8RU6vh9w6Ln6CCFYP8YYRwK7+oV0P0/UmfecK?=
 =?us-ascii?Q?/8MYmcDrwXvkiC09IxuQCDlWT3oF0cP+mE2QybxSTPDpv0PGFzpdQnt6J5P6?=
 =?us-ascii?Q?e99q+I7M6iWr148jgzpFbZMcHSjsvDMRvmBrA4stoxfvgoYsWTpceDIsM3uG?=
 =?us-ascii?Q?mtMQYVzgeoMkYnilnABIAWMvWA2LdJRSaNBHA41/HaoDnk2zFxsSYeheosdG?=
 =?us-ascii?Q?egvVALfI2LLhUZS/iBokILAj+XMhPsDMlSlaXcQ4uo29BoWGVRg3l9sfL2Be?=
 =?us-ascii?Q?kFnnmfmN8PqX0Rp7QELsup8Q0pmun+h7X05SVyJVRkI1p6UyvJNwPpruVJtd?=
 =?us-ascii?Q?XVq7oYbwR9lGPoV6F42nOIqgvv6cB4+xAxtsPqyBFvxpHUkpFcnJaLg/++qR?=
 =?us-ascii?Q?t6NDtCxq8ZgjsOePnhR/pnrnOjpq0taJS9GzR65GFSNmVbH8mBJjoTI7Jb17?=
 =?us-ascii?Q?/L4kViW3NGu/5cnkp1z1GHrUxDMNiEw6lgUoRPFo5pTSVnhfiAiyU8CMtpzH?=
 =?us-ascii?Q?lpYTpyfEvcQEXr+Jg7BS14K3k19sSVMTNmz6WC9BDYsO+TXwXWarArbc5Z3q?=
 =?us-ascii?Q?dOnYX9IUxY+7tdGGLfemiBRK1WAkmW37o4qVX/v1viQ7eDWbPxXDCwJMIeQ2?=
 =?us-ascii?Q?Fmiw1iP0M7cICGVi5XVd4IbkDaRI5oC+PVPHbdAfuK1yyvhMtT1hlhHCrvgb?=
 =?us-ascii?Q?mMHSu/ONwy0T3cYvlgQzjvdoWQU1AOdi5B3EQ6+9B94dCDKkDcQA8WbV1Uw8?=
 =?us-ascii?Q?Iv3/rPMO4QiOIFm3mOV04ym2JC3mi840hdQFq9eEolHNACkjZ+k9g0zaqrUh?=
 =?us-ascii?Q?JWVfwfW4H0aKJD7UxetfaJCbi0Spyr1wSVZYxhDa05iKL0uBg0DfGT+LtCMW?=
 =?us-ascii?Q?8cE0Erk4D5uXPmfzKCgQ6Pl7v6Yh4yjKSNyfS4Ov8JuG5MdMm5ag+ZI01bYP?=
 =?us-ascii?Q?UFCWtglEnpGHuMueoFYDEJNi+DhCNUveq4ircssO35X51xG6v/s0XfDZ8wpB?=
 =?us-ascii?Q?rQCxHwiaKYFBLb7BGu8EjBKUjzugLLkxJHpxw2dmb84TkkeG7VIDLODMn40g?=
 =?us-ascii?Q?ApE/JHnk5SkK0xToa/5+659PGUVU1LxKKMLTGRXEIGbWleKxCqrTglKXYPdD?=
 =?us-ascii?Q?weOwAho3EPHGDKNipEbuPuL00sZzmA+GGXfRclOg8BBj4EHLVqOzARAaqD82?=
 =?us-ascii?Q?eT6Kq6AtSdHYxXcNMRF0bf/5z6UFdLGvKuELRRFWNnxXITYZUWCNk5UjNaBI?=
 =?us-ascii?Q?fGa4MU+hq1UAxGV05mhrnIZB7XQXdWf0ZUzaoLQJCbaVbdDlwr/z2/2CQDtj?=
 =?us-ascii?Q?fQ8B38YVhO1IxUuxC1hL9kq15AorRB6AGCPsiC9QWqMZ9dTRUBWgFbUyAdbp?=
 =?us-ascii?Q?p/UG6QUKAGx5r0U/M7qjTKqRp0XKqh3OiZ/Ikc0i?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af02de2c-6459-4de4-e5da-08dabc2a2de3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 16:57:37.4186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: poOHuD91yKrGD9dOQPGRbhXW6rugqfYhCy3dH+mZzcDr5a2eh11nQm1Tatj8dfSbV8nrZNDA94piFS1GJ0hxjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8631
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

Align the indentation of struct epf_ntb_ctrl with other structs in the driver

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

