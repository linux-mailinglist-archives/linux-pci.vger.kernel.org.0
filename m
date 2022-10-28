Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3879F6116A2
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 17:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiJ1P73 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 11:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiJ1P62 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 11:58:28 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2050.outbound.protection.outlook.com [40.107.249.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC538219FE2;
        Fri, 28 Oct 2022 08:57:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6ciNuXG6LXOGihgkWZVI0R2TYJXdyv2c9BN2ElJB+nTxMuFN1LBeyij3aaEirzaA6eOhwQrozE8LXLON7VDdb8fS/BCnn36svUmG+vaXq+854MAutsyLpTajoRXbHHcpxGkShzHDuTdRwYri4vH7/HFaUV5f2Yz2g+0MI195qKmcaA4K0JoKdVKhz6Z5ubFUk8+Toy2QlLUHM35l/VPmNbxpVeTqYnUpo7VCLt1/mI51fu5LAFcLbuH3iJBB8QNrf9bQpLs9RkbI8yiL3kfvEjwl1PKdBzdgPVQpmiI2ayeH8KnjLVy+u84AZOSLrb888qcZMpCByOfrFzlBavqPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfqKjmRXfkbqfS71fsocR7ajWkM3hp3bLrQF/zSSm4k=;
 b=BSJ3CLx4cZ0LF5vz3JFCxWDE0HSezm6vHZuvNhFELKzNEPmsH+NFEazK3ieCsFDCe3kwcENgcpCcn9OeHuF14lC63lSC0PI0xf6oI+Io/mdBRHCz/VYGKjYFJYesV0WDyfpDPTTZDutKw1F9FWhcHM+huDeTjTveZCO8jV+l/z0L/kFTKkcOABrhwwKSDHrYwhTPH9mC07uLdCJDd0E98OmvVLhPmKGYVMZ79KfF6RLT0AOwGsnMPdOMf3s1mZ2RHBEqqgQ8zaTN1Z4H/QVtgjdE+Og5TijijEJC7eoOH8qIxOOnGL3n8EKD8NLgZZWnnmLu+KFnS9rP1ahyV7RSxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfqKjmRXfkbqfS71fsocR7ajWkM3hp3bLrQF/zSSm4k=;
 b=r/mweWOkyM7fHxRGxCmxGOuN+TRmgQ44ihhcRGDtDBZ2cp9fqLYcdXq37+YzsC/+nHo2whiZvGNGBze80aN2JAeFFVJVOTiZ6mmvuKQtHg+9v+TlqBCrY1hKAzOdQYm2pldeReBKb1GAHPLTBwzuhOX6cPjkfpEPrZk4GfPlozs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AM9PR04MB8323.eurprd04.prod.outlook.com (2603:10a6:20b:3e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 15:57:42 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%10]) with mapi id 15.20.5746.028; Fri, 28 Oct
 2022 15:57:42 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     allenbh@gmail.com, bhelgaas@google.com, dave.jiang@intel.com,
        helgaas@kernel.org, imx@lists.linux.dev, jdmason@kudzu.us,
        kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org, mani@kernel.org,
        ntb@lists.linux.dev
Subject: [PATCH v14 4/7] PCI: endpoint: pci-epf-vntb: remove unused field epf_db_phy
Date:   Fri, 28 Oct 2022 11:57:00 -0400
Message-Id: <20221028155703.318928-5-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 36ab77ec-6b50-44a6-a5e2-08dab8fd2541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zrpwZk9NWj52lwo773mFAseeiCvBHe10QmfP97v93HhVNI6yatIM7Gqlot7V1Z8FYTwkyLN342o3K1cboJ+MOrd4If23YXtpM4Sv7SZgaCbZ/lCSZg0XaoKmGDb2CMogJnTAP26jPcX+HPXr+5iv7PYAdmPqY0ww/0X+Kms7q6WRbX2QektidhrMawA2n/H+wQPIw9vcNDZQZuaW7PWu9uM06ePYyBt5HF6C2HuUlJuc5nuqVsNW2TswfsJUL00FH8hMkmxiheiCkWmM1b9V21phCTZA+Yoibam/h2l8EYwvLoH/q3QB+gStAPRrDZpftoq30BcydkpOqQ/cyHE0u0PugbrW199GdHQfZnAYMtFKS/dNspMdky9/kvEO1vhwKRA2+qqUmtIAbjCnzCkinHFb/3Vc/kFUjxKEj/V6anRsXyH2pYwBjVTS5Y2DI+BJd3JLbsxg93pVTyDjWrioCZ63ooee9vLCnR+LB3AB/im50k49QNkjJWQ9/9A1If3CCRREP1djtIuBJr2J2fDPPYWql9V3QUDzw6zgKCKOv6NdNvfY/UQJMETHiegLDcvWojCdoWfxX0bPMVb9+NnmQGetyWyrrhrlvTjaQCGrAhW7aoo2eDrwEWsUPyF59dfeDyB1LGVVYISyO0okgNZzPNUSMi/lLB/JugRQluAnjlsGwYOCw6qwjG2gpjGDJrDdOlDmOMI03pM/mOV524t/8TU84CTeCmDuWibz03jxMetylT0s18P4WHcgtd/d+Q9wZSIhY8TtQn456+bfrADE8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(6666004)(316002)(37006003)(34206002)(8936002)(5660300002)(4326008)(2616005)(186003)(1076003)(7416002)(8676002)(4744005)(52116002)(36756003)(6506007)(66476007)(66946007)(66556008)(6512007)(26005)(41300700001)(83380400001)(86362001)(38100700002)(2906002)(38350700002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YAQr2m8pOnhZ4Me0nVeNc+7bjQvpQPPi4IgTF5DJ7RlSfw5RuPuFwZLwg+LE?=
 =?us-ascii?Q?30gLMzD4nEtfvCOBgwEpVDVKk9Nfa00fOD6rOgnaMfmTczt2UoPtls26uq0O?=
 =?us-ascii?Q?aJSDiQiYM6VlnD2d61t9kD9122MBg3GAeJ7P4sASjppupkjKhOUPc+yX/e17?=
 =?us-ascii?Q?QPigif74fGQVgyCDRkyz4nAGChP5WM+VIva0xAVnNY3jkdZxeLyCJAKKcsvq?=
 =?us-ascii?Q?80/Z9nPvptOESS2I75Ubbc9rGOfBnOo69rNHKa5YM6cacpPNti/b7vaM920D?=
 =?us-ascii?Q?rp7ScjeOmPTqjRL86qth51W3ns1Rv+/btxskyBLPOrKTaOpVXAmqyrj6dCTP?=
 =?us-ascii?Q?bTrpKz/HGDVCOlPDWV3QDxk1jiIjcN+qBVp6NmL8AgTKv2SM43KrwNh+f0th?=
 =?us-ascii?Q?Vp9UmiQMiaRRzC9pyEEdIA+KGlMEMcmMcrhgl2a8f4bjYO/4c4O/5Gpwpjyl?=
 =?us-ascii?Q?eVG+xtAgvtJxb6LtDBhSGeOnnhGzMr6jdQ91+apGQ0fK3ipHDTSmJT2rov9v?=
 =?us-ascii?Q?4RNdIduAxK3LdEPD6NtcBj+9CGXOPXf1iuJXW8dMLbh2zodBy2hBW7g9afTF?=
 =?us-ascii?Q?vLBfrki4Fl3m5D+3AaRt3+RsAUa/utrqXcKn0VUWXElO2NsSnaZdve9IHtEQ?=
 =?us-ascii?Q?OoMWbHmBAX1fxxOvYrBvVvqkioj2IqDassbyjeAPomLirPTjOVxxVbvMGpYn?=
 =?us-ascii?Q?aSmj3nRSOpgTQL813zBxs67GxRSdicfs4M4rZ+qJjPCwFxyNUQxQqyPYZNeb?=
 =?us-ascii?Q?niRhWKuqg/79dPpNz4bEiOMV1TFVfdD/CBuxVlRXoEez5BAzARtulUnXxDtK?=
 =?us-ascii?Q?J8vQ87cpjPXdSNIu4LhQik/ptgRBYSCQhRyTe5nvWuTfe4jOg2fEFIE0aVNB?=
 =?us-ascii?Q?hZ7yI8uq6EwsmrPsHhfNi3A386nM90syQb68JonUsAdURlymjj4EimvFCUTd?=
 =?us-ascii?Q?6Rw2Roikofv8Mc5pm8Vdd9PCUG5iHLmQGb6N8lNAu8FtjWjCw0l0B6mLmRbS?=
 =?us-ascii?Q?CBA8Saxjj3ILSGrevLw7BPXS77jfdX/S+BB7nlCcjlpcyT8qOcA09a7AVkub?=
 =?us-ascii?Q?naWjFrwL0ydFi9dSpT/a70b1pkoIvr7P9ooacvWu60P7AZiMQeIVXHm0yw0x?=
 =?us-ascii?Q?qns5fgfXC0PpIFPTy2Diwn0dLj0wcUAaEQV7I+M3IUf0FNCj4V4VcBULejaw?=
 =?us-ascii?Q?/+Tkcf4Ja6DXJNQbPQKUxNslkCJWHtyYdlBQWCrW4ZUEszs8udKfviHleJxz?=
 =?us-ascii?Q?zieQnTqrFHUEfoTPpZUuWtjTBuBr+sKGIuoOZAGXvs1HWbIK/qnpyXBQWtqn?=
 =?us-ascii?Q?1lwYzMhojc+0kbivfu+rRL8sGn6H4no0eUzo3+wenbayCsrNC8PCuCkt8h0V?=
 =?us-ascii?Q?rFnA06qEPFq6hYc6kDkR2XfcNaPNTrgmBf0ppJBIxWZ3ZmvxQ4hLZhSXtnT0?=
 =?us-ascii?Q?M/SgK+SEt2etPTh5RnrhBSCF2/DEgSHQDdZ79kPwmzLHYZ1bglhLMyyBMTyr?=
 =?us-ascii?Q?zjg9Rdv5tq/F9Bgo1aq/kkB9dpZm6PT/yFKSCI6k8K7vx2qKN32CRcarPcvg?=
 =?us-ascii?Q?pWshQzVFX4d65z/E1kg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ab77ec-6b50-44a6-a5e2-08dab8fd2541
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 15:57:42.1080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QR8JeKU3nnEzcxPJoeeYQ7d6JRESWjqYpRcA8mluYkYMRA/419zP9fBt0w97WsRUcKiG6V0pBB1bTEag964kKg==
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

None use epf_db_phy and remove it.

Signed-off-by: Frank Li <frank.li@nxp.com>
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

