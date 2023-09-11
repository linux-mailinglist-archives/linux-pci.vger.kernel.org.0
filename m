Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79C779C148
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 02:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjILAqM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 20:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjILAqE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 20:46:04 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on060b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::60b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AA8141923;
        Mon, 11 Sep 2023 17:35:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JM9T91Hk2Yy0wLB09pZdnPTd9iFpXDHoc24rfWyQ8tJKgTQL6aEO9b8qTWcqE1iIU29oI0eBWJZuvub3t16yRjp1JaZRfK6I9QzGU7UUFJT4d6Wd9cCTp0pnvCqVIDpuND22uWYhYmfnmqoclH/sq1eQxNq6pI24b6+gtfbBpssetXp43M6efkC6bmQ5w5aK/JOd1YFiNxRxpgN6eTmbW15kO0pSvFxavNOtlQ9zfK8UBSOwmK2L62IRuvUK2gTx2nNdMDlt+7N2jzxEc/5jRYSgAtSf5Jj88p7mV0mLS4jYSHMMjeb+x/HPx0pW2XWNbakuOI0AhsL8At4E5BkRgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EhE1gap6D3kYZSQq/ASaMYmSkecBwLLo1zEPZt2hAI=;
 b=CWrHluc6fKzH68k4DRjjWfzn5kBQ5aWAILiCXFSHtkfqPEpK7Mdshwttgeb9MQrxnCS+ewgpzlXx3YVhUqUjlHKfaNxuI7D/ULgAYA5WbVcE0Eii/1yN/qm6whoxVwyrKBqhv7BTUINH4AmBWK+lyRzgJHkRgYM/d3gOlyjMjANe1EvAWSgsPS4cUGm7s7UoqldD4bo7RgL0e7jZcptgSUKyHcXzRBzvREKlrIj08jOqVXvnEBE0oUdCQov00e/UWquOQUOzHxICSpp4y3WfMSdYoKBNnbY0EFQP1khXTdT9++r2xCc1A59iWlvwroeWkXhXCAzJGHySX/VTirk52w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EhE1gap6D3kYZSQq/ASaMYmSkecBwLLo1zEPZt2hAI=;
 b=SXQlHhfGySxEy+U7abpSFU/Yy1bwUQXigpBOy3Uy+oTM1c0WPukunK/J2d1h+lkMYBtFR4UYooxID3R6ibf7meU0wb3F5erP5/didx6ErVbWiatlq2A+wyP8NN7dfGRWg3q8Z6glB7/ws2mPedrjk3cIIfB4cFXz/hu4l8KM7ls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8125.eurprd04.prod.outlook.com (2603:10a6:102:1cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 22:09:52 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a%3]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 22:09:52 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     Frank.li@nxp.com, aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@kernel.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
Subject: [PATCH v2 2/5] PCI: dwc: add doorbell support by use MSI controller
Date:   Mon, 11 Sep 2023 18:09:17 -0400
Message-Id: <20230911220920.1817033-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911220920.1817033-1-Frank.Li@nxp.com>
References: <20230911220920.1817033-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: 132e49fa-d0a7-43f8-1fcf-08dbb313d2c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Si/R84P0WKU4WEEhixSFHJEqa94WJUkEPAYKQSyWPPWVccxPc2G97kwIARoiDSHTlsVWJsjJRvk6VQVZrCpAs4rAYtWr+o5k5LqoofYFVt/2agpi1OofJCCGUvSAm6GkTC8gfnPmb4rNgVaI4PDEi/8VCbfhXNwHIdNgfC7B7BEAoK+CG5LnhX9j4YlDo9ryEJwCl+I6j9ogugTAO0tEVd5aQhAwWB6ReCI1Kpj5JOQiKYucILn5CzxnxGKlgMdOSC1jIUBWgWVG/rpaZSPwpuSGBigWDrvGLO6Ba4WA8jJICANOvf3fDpFNkbcp/3CE37APk/JVPgyt9L9R5SpEFruPkZjqN0XqNOm0CPfpIGz3KJbWol3hHJqAbbrL99E3CU9DSxFxx5t35Q9VTZXb+q627hIQVw+chfmi8MZ2mN/yH6yqLRgYlsN97t2pJdq5HaHEQ4BFAuUkZLZxtMkLGA5gIZ4G8OVtO1k9idHo6oVZ5hdIJYBL+dXdav44WoQR69vMnFtMTxFx94wzENMDLWFJOwqik7ZhMQ572gX5Le1fJ7mWgiF/RpwBoaoA4UJgj6I44KjA1KlmUdS44i+KkcrBmSXGdX2di6Tg0FnguzFO080hJZGa3R4iPWX18pe4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(1800799009)(186009)(451199024)(6512007)(26005)(1076003)(86362001)(2906002)(83380400001)(6486002)(2616005)(52116002)(6506007)(6666004)(7416002)(38350700002)(478600001)(38100700002)(36756003)(5660300002)(8676002)(8936002)(66476007)(66556008)(4326008)(6916009)(316002)(66946007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RrNdvTxONOmEkXTSjRRVJ1pswjZ6mcc3kJTyhwlLIqafNei71LKqzhBiSobF?=
 =?us-ascii?Q?h2fMDT11AaXtqYlSzU8Rza1Jc2925QD19qNPGRvl91S05gJmAKrWAZ0B3OpA?=
 =?us-ascii?Q?srO5HpRUUlcxfv0VNu4yCp+YnmmcS/DiNkCvXG8w8xj2BJuS+4Vwth1hSKjN?=
 =?us-ascii?Q?+Kt5fJTduUwRvUfKEBeEbmqhAR/OhCKs0JwdhaeC45PfmFI+2eJSctSeOUC/?=
 =?us-ascii?Q?uh667IZtBDSVNzdbyfTuZ99kqejrWHXzfS7SGCH8mgZ169kpdKrUJ/JXpgDG?=
 =?us-ascii?Q?54URkGeuj7hAH1FigDwYEaPjNrQq3PX40B7gjlAkKycfRk36aUxLrtIW/4fs?=
 =?us-ascii?Q?YcmuwCP5IJ45PrETBWs15lSLDn/x1KU8NJ/LimmnZQ7syqXtOuFvm0tnXOwz?=
 =?us-ascii?Q?+eqqaCQ8JeI/WgDkBvLZtE1+oFe/yQtVYHPEZLxl9pJiZwrZiR63Xpuw+ZH8?=
 =?us-ascii?Q?Nc6roMVCA11asIMvtJv2mlR1bj2H57dREBcPgDm1jWZH3N7DJ0FzZd9JipBv?=
 =?us-ascii?Q?N9pz3EfHuOHfmdcF+xRUFV30tRABFdASMry2PJKiICkE62ptxEB0RxXGalJR?=
 =?us-ascii?Q?kUKDdeGAiav37Nh7SqTR/uUzLei/iBBMQAykEOZEWDp7tgpA5jhqpWLk7yXW?=
 =?us-ascii?Q?SwgcrRCk2wlL3L9y4AAplZ8oWgg9iUKqyiUuxnjKPIBeQyQ3zHDszDUCeS2W?=
 =?us-ascii?Q?fW8kGSVCEg8/t/yem7B+f9rrpWfNqG1RFzwQEpzYsL9DWWNXVEGZaa1y7eT7?=
 =?us-ascii?Q?ssZAfaoyHQ5YrMg2tKnxjntSwDDa/5jr6Cf1qWr9Dpfmgs+P0RCaQuhuaJlQ?=
 =?us-ascii?Q?pIR7SLqToc8UB7/L8aHMIN7p8EDzxBr+nLshjFj7tjGyA6H/kS2EAQZCUOoq?=
 =?us-ascii?Q?32bCrDuiodCVDsx1JsIU6guT1TDBz/P1gavLTpMwc/OA2irKWArE87e3Zyjh?=
 =?us-ascii?Q?9gK9OPaHbR69//fM9fFIAVZd1KiokDEnURahNfpOZ9uTCvWGus9J3lk5rTwF?=
 =?us-ascii?Q?n8otDZlw5lzvK21RSD9hFPJFFM0WphwpfzEYSbhXwIMmmai2C17Xnu2/ac+E?=
 =?us-ascii?Q?XoauVjl9+kPgBTKr6FJgEf01e+G046VL8gTKXW11Z4ElaGO3GRCS+MbLi/xQ?=
 =?us-ascii?Q?ks0G/fo+6lkRy21mlNJ86ccw+4Y1fIQ8Basxr2N2Zj3S7a6SDmQ6NY05w7gx?=
 =?us-ascii?Q?vbiy/VssMcSm3IdyWLbMTERDgyNiXzrjuvQ+VaWWoKaVv1sVJBUt5I2sH6So?=
 =?us-ascii?Q?dHRuAY5EWeNrjLmPPJ7nkIE3v1p5/UDpYGxnCZ4ycyVqfKFzN7rJNO7KII/d?=
 =?us-ascii?Q?FtkIjfXgY5mpZTGv5WT8Duh0w8apIUCFmo/BGDCCdn8RGUTo1cyArxRhtNIg?=
 =?us-ascii?Q?wF6ZuCtPK4BjemAb8Ft5/C5zGCQ/4UknbgKa/VtQhqdEPxjZaVY+kvsZRCy2?=
 =?us-ascii?Q?RMPlGkCEaHoiiieRO9ua6357ALARGg/Bjqbed2O3CMRr03AiU32TERjrx7ov?=
 =?us-ascii?Q?2sSE1jo7B3Ko3wNEDrLdgMcwgbYQHa5ECThU1iTn4CPXBkCh2VQXc4FFYBSU?=
 =?us-ascii?Q?y4U7iHPVVOi0g5HLJA1aLdHMakmlX6xn599Ffi/q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132e49fa-d0a7-43f8-1fcf-08dbb313d2c9
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 22:09:52.8026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMH0qVgSc6npN8FBytjjLhSMnBIQ2uFR7th6qglISl/+6FaGrK4P6C506/3NBkk4Yu9hl7G1IbfvFk2Da8fngQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8125
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Call pci_epc_generic_alloc_doorbell() to alloc an platform MSI address
space.The Endpoint (EP) function drver can maps the memory assigned for the
BAR region by the PCI host to the message address of the platform MSI
interrupt controller in the PCI EP. As a result, when the PCI RC writes to
the BAR region, it triggers an IRQ at the EP.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index f9182f8d552f4..4f6be5f4ba18a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -477,6 +477,8 @@ static const struct pci_epc_ops epc_ops = {
 	.start			= dw_pcie_ep_start,
 	.stop			= dw_pcie_ep_stop,
 	.get_features		= dw_pcie_ep_get_features,
+	.alloc_doorbell		= pci_epc_generic_alloc_doorbell,
+	.free_doorbell		= pci_epc_generic_free_doorbell,
 };
 
 int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no)
-- 
2.34.1

