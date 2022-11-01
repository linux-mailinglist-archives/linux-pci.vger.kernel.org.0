Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9161F614FD3
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 17:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiKAQ5t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 12:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiKAQ5q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 12:57:46 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70047.outbound.protection.outlook.com [40.107.7.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4041D0FE;
        Tue,  1 Nov 2022 09:57:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mU9lgzfdsGWg4VgjwULe7hSVBL5RQgAq7uGFq0lihRtVTCrBY2ZTrnBfaZ0wbaPVyWn/yF2V6gWtMUL1fMnmM4RwN2aSj3A6h864KMx9x6Pds+eXex9U8rq/cHp+kbnrgo+MPH5TamTcy/KVwjrRLm9dOuJBYCWWR/5nT0sIGoqfnsQrmXMy/Lk9OEeVO5/hun0blXH0NClHvVfOhVJ9GGtyXZ/8P/vyU2KTeMaLG8vVpjY0MIXwTy4oo89cCUIGYmfYexJYlr19HEEbxCVCoN7q2CTuQM/L3nlQBiL5GjnUSrPVfb1PEKRDRIQ7HAQuEMHb4c7+qy9zN2Rgu+rrNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRK103siZ5945LFLHIFILLE1HOlBh4/xZcoINeMqjBQ=;
 b=A1YV7cjQZwAnPEVuy4TUREunXISpicstprDxThzmty/9qnEiVjaOB58wKAW822EZkvQywIrvgSifFN1Cpxsfs317b0tgjPMRglkThTVvgu6a/x0aXrB4bQii9rlZl5stz4BEwpGcNHEsgY00hdy5hJqfZfLRfplQczHKcZEgLLhw5VtErw+jPRfBBXsG/4Hbl6+ag7BOQhPARQn9TEyHP0YYWcJYiQZyN7LCGXE0VwJP3+fpv0TQmwzsYaNzgYvLTkZ5KR0HVO8ASbVURDqLYEuWYkAKa0mkPxvLFn+V6F9qGYij3rs1TKSjt9LFpalmyRL+mDCWY0iwIfcFFKbAdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRK103siZ5945LFLHIFILLE1HOlBh4/xZcoINeMqjBQ=;
 b=O9IzxmVbQh7Fv+3qZio7XVm+0Im2jkwAy0Xs2emQgH/KvFi03lTZGjCiknRfiMH1hN5nzVWky5/7xoEbSZmzdVq/63fmmJvTd7NSJcze+Wnq1sZu3Qc5y8jW54fJoc6ZPPWk0JIXQWwyEFtDzCH/c3o6xBt2KXnMaB1JHmkdkhE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DU2PR04MB8631.eurprd04.prod.outlook.com (2603:10a6:10:2de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 16:57:41 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%11]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 16:57:41 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     mani@kernel.org
Cc:     Frank.Li@nxp.com, allenbh@gmail.com, bhelgaas@google.com,
        dave.jiang@intel.com, helgaas@kernel.org, imx@lists.linux.dev,
        jdmason@kudzu.us, kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org,
        ntb@lists.linux.dev
Subject: [PATCH v15 3/7] PCI: endpoint: pci-epf-vntb: fix call pci_epc_mem_free_addr at err path
Date:   Tue,  1 Nov 2022 12:57:05 -0400
Message-Id: <20221101165709.983416-4-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 50dbc345-2f14-4640-ab66-08dabc2a303c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Id6iNBatm8e8n2StFNdUaqWO3ZJngyTYzeeKOTn2uSv2F0rJIfrbWfNmsj0vxoHmY49Kp1hwUNXsIJh0OkJxgIlle/FxQyEjjmWm5HYWhm2qdRXMspVpuE57koGeXpyGueq9mQptEpg3IxOBydKKSlwX/yxnwCGiCP8uPPtkVaSn49h//gORs55Jxn9f3Gy/8UcerKjmnfzz4F9cvPYZJoDZbqqWAhm/Xqu1obhzNRD1lkm/0WlbKt+UoOzzo1ODdjDdToS5Bw77TfoDryNf/lyep0928/JBe6koQAUZf3BfLGtiz4v0xRsycwjxV2KqBAA3WLt/wWI9buJjavP+UtegNu0iFPTeFWHqDBXY0Rh6kVEhw1YoGpmJERjE3r6fwSAM8eVrw0wd+11bgaaaTgQlMhYyOxgmXS5Hpg703WfVVRbeRynjZ6KdTfRIHDGTb7Uv8stYfNBLpoF4VNLN262fogo4SOeeP/YmS31q+1AS8FgEmifGoWTC0wNVbH9l9ZZ+/RtN29umPuZ/IB4etiJABPAhmeMNOyxOCnKHiC28djMv/mx9Tj8R3rfLFxBqH77IrHkyDRj+iXqJOGJgMKfDvObGqp5+E1F4CwlD4vKXSWTbyrDxG30s8rD+sxC4HDuqLwYv07MC4hC9pe3gH/OimZLHwzDD6JlpSLeVqUbUIKEmr4fg4Z5IO6XTIbNZw2S5JAdQ/Ltd/QgkwkFyYkcbexMQMRR9BAqUJAE70IWdOm3k9TRM+XKgUFeix4rkv4COavWHvw84rsTXT5zfog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199015)(83380400001)(36756003)(86362001)(38350700002)(38100700002)(6916009)(316002)(6666004)(2616005)(1076003)(7416002)(4744005)(5660300002)(186003)(6486002)(2906002)(6512007)(26005)(41300700001)(6506007)(8676002)(4326008)(66476007)(66556008)(66946007)(52116002)(8936002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KTlWXZYoVekw3ZMSzgmHQ48HdLvBzwKdcJ9oiLp+CggpZ+6X7UYvqZice/kw?=
 =?us-ascii?Q?2AQCVei2lh6gP0Nsgf2A7ZygSzrPkcZFPy8Rf2W54y55mqNPKZkLe5SG6flM?=
 =?us-ascii?Q?75Uw0/UBchI6YIUQ5YrFqIxyWMqLkNls4BVH88YOkDeBgfK8WQXkZFsCQc8M?=
 =?us-ascii?Q?CQXq1WhB8ksM7li7pt6BuJKJuASUCfifSGqRxw5bqUwYIkXz7aQiKMUa0rup?=
 =?us-ascii?Q?QqfgUocKN54C3AMKkdOAfRXgVsNwbMAKR++ebf27nlD2jaXKHnN5a4XUXuyD?=
 =?us-ascii?Q?JG/dhj6E91LTy1fD9gAOqvCTsvNw90kesnAZU96OxC3T9Stl76TL4Havx8qC?=
 =?us-ascii?Q?Fs/Bo05mMDmEF8bsF95B6K4mewW4zomH657JeRwJ8WpPnb6danPAgR+yKAj+?=
 =?us-ascii?Q?jimRF+cpMkvYBxeJrGtzsABHPVVc82F/XWXBhSzSMAjTFgtmBsl908VU68Yh?=
 =?us-ascii?Q?qT/3buWnfCmmUPtW9dmmMWRGfL8a9u8T3xm7ctZZNhG99EB6QypqLoSZYSJP?=
 =?us-ascii?Q?KJJI08wylNmKfNAPsSyjFl7rs9JAIUirhOp6qEqcUrmU+S3Zty5zEUMnnpmw?=
 =?us-ascii?Q?tulZedY38+gvGoya8DVqSjyfg2mcr9QNv6R87EwRtUTckrRItwnh12WL0XIJ?=
 =?us-ascii?Q?gl8zFmDRSyH5q6OEOr7c/paJ70amlBi0Y7hzFtnj+sUjzSqwDqU9U1Y0dyk1?=
 =?us-ascii?Q?EG/WQDjPvzkKjAsLb/HFLFnfRoY7mu3tCYketTb3T40wyB6sX3T/VAMecrs8?=
 =?us-ascii?Q?FJEyP2VxsA612ldt5MRLLDJyuMbsgqLiITze2J/73N+7BCyYAUV+U40gjEtX?=
 =?us-ascii?Q?1MEY0jK0jdoZIhPe4CcScwA/pxzCHyrmwzC/JP41YSeShNRhKd2HoQoQHwPm?=
 =?us-ascii?Q?lqgYmI5Wh5Zt8eYtBswgcLVZ9rP0vyTp8WkhvAgDu7PoRdyl60xJ65oZ09D7?=
 =?us-ascii?Q?ahIjTyMwWcuSZlBS72PNTjLKHlbSsSAUwPDfhmUYhUsV6m4FOYELxJhJD6VW?=
 =?us-ascii?Q?RlN0olBYltAdKFK8iQnkvK0W4wT/d4BMxpzOTySNp4gcUAA7YrXcWYeNfKJn?=
 =?us-ascii?Q?D67jue77MMYSBNPlWUTHUizLIGqRaZidBMrLu4ye0IoVlshFupmg/3h6Rew1?=
 =?us-ascii?Q?Vm6CcXK/goGV6r/PcTY/8fbT6VfiCCKbJ0IWDfFZLbQpqQ6An7xrJHmFOSxJ?=
 =?us-ascii?Q?T+PF90CKN3StnDLy9cE4LVt7F2XVsmJIaU6ZQphNh+EUMBEYcE/lWZ/yrBIU?=
 =?us-ascii?Q?KO7V3NL6szQoBLC2qmPEp3No3QPYwPDM7XyQe3r80V7y9GGBtBmtTREzj0lU?=
 =?us-ascii?Q?FXg9LA/muFdZvsdmcNjMM84evMznHJRxwz9Ln83sYOVPUja7ZBpkMH9HBoL2?=
 =?us-ascii?Q?OmAVBBSWC/QnxjDUPCSzAF3gBmbia0jUC5HzSqMZsBdmtxHKbAAL5GTe/otg?=
 =?us-ascii?Q?uJyGZ+kapInOEpKKW5Ct76KWsf4uk5Qo99Gtxyy5lFX1SdreRGI/pB+64l+6?=
 =?us-ascii?Q?IJ6JV6wsoQmvNXtY0SKPDGOCphXSvZiD8/XpUjGaMEw3vYX31Ba7nrDLIzL7?=
 =?us-ascii?Q?nJ1j78p/enohNwSl3mx25AYtR43SVf+whnO75HIP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50dbc345-2f14-4640-ab66-08dabc2a303c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 16:57:41.3558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZyKXj6qYoElIxGiuVbOePHVHLfdwHBzKhv7S0o5ty+41qNx7zklozSI0Yt68Yi+xIxJGiqEFQLyfem/oTozogg==
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

Replace pci_epc_mem_free_addr() with pci_epf_free_space() at error handle
path to match pci_epf_alloc_space().

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")

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

