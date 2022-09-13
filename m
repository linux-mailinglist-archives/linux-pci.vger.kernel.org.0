Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D02E5B7C7F
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 23:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiIMVK2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 17:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiIMVK0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 17:10:26 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150073.outbound.protection.outlook.com [40.107.15.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BAB75488;
        Tue, 13 Sep 2022 14:10:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXomGX8uXownR0kKElSficPClpZgcMawAahKwg0ka/e/FkfQVG+899KINgRlJaeiwOZyZt7sermndrryRM7atOB9IBIKFtGq+UC3Ocp+29XWo8oAqZuFQZ0hk2imwWZgWbfN+TSSHlJcZe7rQRZRWoP/sKXN9whcLBazS4ZSkQQaXyaEmRsfqYXvvpDjmVjzdiY4FqnpENHrFfeW9Gq/Mzm7QjHfA/oYbPJtFIo42G4rkiZuuc6HUNTot3EXXzMHKHdmn7CAKS8y/qlQ2OXGQ1Pi8lD+RD9nxZUIT2Z9sc8MrzJ+laRYvLpF9/5rtErH5EQY7uosTQqw2XsBhpbBpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbNiVo7RZMy4Rlt7L0xulvmPhpNytBQxjbyUTmsqFR4=;
 b=IYikZMUw8us6mKLEUJK9jr50JbPKZ2hKPsK0eIlCchmMIEPNZ7pj8AZ/wYzvXdwQP6ikPXxQ3oDMvpQISarc0/ZUOvwL4u6M6/jH83QYj1w+367Q/2qvcZEvhjDLQP2phI2Km97xB/NxHxhmFrXbaM3PwE7dmvqxI88VGjVNwW2EumIw9LotF4EtdBmkY2S3PEPQvNR4bcbeXoM38So7iCZ0QteVQiOOZC74V5VbP8abtm3EBYFQYNJZqtWaID0oct8nj9c8FOrCQEe66vVBbSrch/55uAIEBrQXdEVpaD+FpfqHRID+KlE8zAMZm7Vwc/o61fPJJtrhIkpiT+/P0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbNiVo7RZMy4Rlt7L0xulvmPhpNytBQxjbyUTmsqFR4=;
 b=VuOHX55f+lW2B0NnQ/tvQ7nlRxDm00DWjpUBDtHtvrgr4ciwlzaOUFf0m8gv4SIpMzc0g7jMTxMEpeOHBUFWmi1jUd5M3ivERUXCR0i18fT9phXeeHycywwrRECX3aRyDmvmWLai7blP7iFL6L+t9bvXPXRvwKoxv+pFOEHwdAk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by PAXPR04MB8621.eurprd04.prod.outlook.com (2603:10a6:102:218::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 21:10:23 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::e5ca:22d0:52e2:15f5]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::e5ca:22d0:52e2:15f5%3]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 21:10:23 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev,
        lznuaa@gmail.com, imx@lists.linux.dev,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v10 1/6] platform-msi: export symbol platform_msi_create_irq_domain()
Date:   Tue, 13 Sep 2022 16:09:52 -0500
Message-Id: <20220913210957.3493826-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220913210957.3493826-1-Frank.Li@nxp.com>
References: <20220913210957.3493826-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::36) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|PAXPR04MB8621:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ac48c2-b4f6-4f4c-2dd8-08da95cc5f05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dFlnWZvKdnEzAM+iXJDycCR3Nn9zIXdcD30okztFyuzmjQE3ZZiiC/bvBLeoa2EwGfavT3CZthPTl+OSfSrCaVVzzVSMyiiY4BfDe8pMl9DMzD3tjblOHzjbal0gBflljwmu4jWxRjHqnEziCWapkSq0TxvCAqrwocUxtyW+I6K697FBjFyNkaxEigZQnP0SNJ3UDtcdvXXiHW/PvwW0J5E0lcjC/iqewFH9+vA9OxYfpVLURkthoogidatg01dQ4i5X3FeExr89npNIZ67PMWrcR51P0Wcg29rpwV0aWrcbHdGRUmmH1oMcL6Pl1oYPVlvSe4BFci3mhsWE6dydLoQr+Lj4gwPa6nvoOnXsDM28tuIHIVsx5wwD7xsJMTIhkYhJHJhZtl6+jrywoSXJ9gOjr0j1IxX6chcBJvCR3aQvupb3UkkbnMZ4hha/YTLr3PWipmFcPn4SAtVQqeFD/ykpirPPtgA0EIj7GkPLYkinJZbRAEPX3H98yzjRygOCFD/o0PQ7Ic9qlzZ1n30jaJvfKD0SHjQ+lQFyU5SS1t6NAg+cfODXpqM744FRpEl6SeDhIfKbJMWtJcGcQGPjFHWzS9b7HZe10gfVT2ZRjjeJIkItkNW4GQTUKN/JNzOrBG8JUqIsy4IW/F7I4ak2hi1e1HMwBkwQa1fYeVsypwqPAgDRbuVcAgaFF0b53I/+VWoY6dHGYKaEPbHMqANOUGBpircXYX6m7NBxU/IS/7zWclx8oTsBrb/tNsAV62v32GIj9G1QzEbYQlNJXahTlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199015)(38100700002)(478600001)(316002)(36756003)(8676002)(66556008)(2906002)(26005)(52116002)(2616005)(6486002)(66476007)(66946007)(6512007)(86362001)(6506007)(4744005)(4326008)(41300700001)(7416002)(38350700002)(6666004)(8936002)(5660300002)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k/RAoosNE0aUcw2bxUBcbVZsjxVymggeQP8Z9IEgRg/4hhDouXWInk8Flb/X?=
 =?us-ascii?Q?wXNf8DwFXq+N5l25ykNBPGTaIKlREEn0FhaDE8jDunWzmvdBstvr/PShEesC?=
 =?us-ascii?Q?3hTd+sHMyacAPyBpR2GR/29+UHVRZzlI9GvV3g9LLs8ev3tpkkSgkWo0YRuY?=
 =?us-ascii?Q?XMAs4Y9Dvd3sU2dv8JE0w76Xp3yC2HdtHGp93cnFQSyxtDEqCDm4q9VDfeog?=
 =?us-ascii?Q?VMfLnBjxRr12eNamFqLfcxacaOK3tMBk/16AAOBHlufgrPG9iBkgyjXt+zHS?=
 =?us-ascii?Q?7elPMzj/fYGunDzSBFo0Gf+v7/IXp6QwK70yqCKROvfnsYsw7dwfUQUrwIHJ?=
 =?us-ascii?Q?/KPgaNu6j/xQuughcVXw77cLoizxuL+vDWw5EiikPxr69k5XJUJ3PlbwimG4?=
 =?us-ascii?Q?MsCI9GoHLuktZJxT80nyfhP9NhNQMYcKrSuBo387gPvRqTf79FLUp/9IoDmD?=
 =?us-ascii?Q?lRe5MoP1P1i4xOHG1nnpUkpwKTH8jjiJw6wCgWbLUHMgHO9CQatDXD1RaMx3?=
 =?us-ascii?Q?IU8QEPRDiNE+t+aPMYwGYNz2M9jG6VvxqEnWeIkz3XQ9QmBBG+kzcEntGBay?=
 =?us-ascii?Q?4doq3NWDNQy9IXoBSUNVbNfXKHf75Xx1/+tF1Mi2mbcajkvObufi0CmJIBMw?=
 =?us-ascii?Q?/dJBK6eAw5kiINyYjToViZhgEEv1S6Xidg1nqI2CRvBJnGaezV71r2njiIHX?=
 =?us-ascii?Q?wvwBLrZUapqiBYpi8rQJP+uxjFliQc55whXC58vbX/D3DV50RVcDnXSkl51o?=
 =?us-ascii?Q?Hs2KBg99aV67rUpqHGAQPUGzur6VkJZ6EZte3OufVrM/NRcMlU3yn5wdXsfV?=
 =?us-ascii?Q?Gk7wIroh/EffCc8Q2ySWZovtOIUUtICrCnFP4Z4E2xJfLkpb1BJLgi4PZ3ss?=
 =?us-ascii?Q?+H6q2yiYpOvVxc58G0/ydXeOsBVhLwfgc4qUsuSDFoNG2+5e9QlOMdyT/JMQ?=
 =?us-ascii?Q?oJqmfHwpnaSawpa3cji1k2v2418ra5WAE34aju2ndXkqjCHoQXm2u6rnle8S?=
 =?us-ascii?Q?muwnLWv33lVc8UK9A0EJH9Cvvq6RIWnX7aKDUsDgMD5vPdbORwoiNud5Oj90?=
 =?us-ascii?Q?79hVD4i3Z6fgX4gMtKskaX3GLmOnlGrDLtJ+kQdoPQ4JS0wVDWvXUVNrpqgc?=
 =?us-ascii?Q?h/zZr44rVUfj8K7nha9IIZXnjQ/ceaovh4IAvrYWCVfsDmHDcWUP5R90cRcp?=
 =?us-ascii?Q?YprHL+LFgpO3YrsWTdf/oXRw9qVdPpi7G1ehDOJkuIHTsUme754mtXQPFT4h?=
 =?us-ascii?Q?v/iaW6S6V9zg2LSIDajCa2mHzdC7Y17Pma2W4nmfvjqhQSODAWX73cXIENgJ?=
 =?us-ascii?Q?OMGLRwO/G+DzpvKUJZCavs3j9F1/4UmRNsnpIboUTVMfmbvZ3gAZzmSiQG3V?=
 =?us-ascii?Q?Wh9MblS69Bg9emexcbVFlNeQSMV6KMc27Lfnfc0SPCM0R4FNJdyxncDL+nmf?=
 =?us-ascii?Q?B8GKSIEwfELLJrNqsB3d+z/qScN1YYKsuC84wUOAyR6g9M3ZRBEFZySnpDbT?=
 =?us-ascii?Q?yXzi7HzbSEneep1MxWh4HyccPOiaYq87C/54r31VqmyV8f+ErDNbe6YotWFW?=
 =?us-ascii?Q?mzV5d2s37idedPH+96vvrbCpslOfIGjplKb+TO3m?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ac48c2-b4f6-4f4c-2dd8-08da95cc5f05
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 21:10:22.9681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EMgY4lwYM/y1SxQKGi4oXFGNiyq0oP6IA2BclChYzx+otYSDh206l3yMyKfdAeRQBXzWRJJ40WUyGtq089UOQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8621
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Make platform msi irqchip driver can be built as module

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/base/platform-msi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 296ea673d6615..12b044151298b 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -138,6 +138,7 @@ struct irq_domain *platform_msi_create_irq_domain(struct fwnode_handle *fwnode,
 
 	return domain;
 }
+EXPORT_SYMBOL_GPL(platform_msi_create_irq_domain);
 
 static int platform_msi_alloc_priv_data(struct device *dev, unsigned int nvec,
 					irq_write_msi_msg_t write_msi_msg)
-- 
2.35.1

