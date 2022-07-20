Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9985B57BF95
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 23:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiGTVbK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 17:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGTVbI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 17:31:08 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548785C37C;
        Wed, 20 Jul 2022 14:31:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALFNS4jjIJObqTOJr1FAlo1yOXDsUQWDhxjZWs7djfQXasvIlOW5rne/Mhfvjn1nyF015+3ZdjM5XgEfDNx6+ZQgAK18MpgLur958v4C+zAOyhEIzAtxn3T8fGMEW99qigJAs00mdm8fpk88z2RxEwmN1AsCTCjcW2pOc4UgIpRCs9jjbaXaq6xeOC6B6h/GBqNxpmIfZpJlBSbm83078NvF82Udbbc07G9ReMcNQD01fl5f0miRZ+whe7nf+h7E0x/DQGiuf7/58djcfjQGwb1dApuXXOR9c8rENHBI8ymL/bs48FF+WRp3TWjndt/heIgTosb1BgIAnXFnIMt+zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxyZmoQ4HPxt9JAZN3QVzBllZWpIazPpqniEWrzTllw=;
 b=F1jUSeSPwq+4cboTF/Ls2z6q4kNerFSKLs9XWIJM0lvRdESz4io2zVDT124pLjujSdyBBgsjK5z+S4VegedSE2CpoK3sKAG/Rji/A9C2iY3VEKujauRhsOJiEKLCu/ZGRsV8uI8U31Kzt36gIsJiTn0k4g7apL9TAcJ52s28rE0XJsnMc14DnEocaGEi6tEWHaWDvSv6OnchLAH3PoGnzgPn0oNFSES9tRXbY01CA0JdrsaEmclgiGF789UYfA4JI2vUW5u7Hbf6HI2gYsrrM6BwDfhkXrGMg2EGmiCGN5iQIEPebW6X+WWJhANfmdSri3Ve1H56I0YNMjResAlFfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxyZmoQ4HPxt9JAZN3QVzBllZWpIazPpqniEWrzTllw=;
 b=F/DhJU49uXAWsT1UUmFg2jMphUVGP9LyMYPh0uf7Gbmnpq3JSl3om39cxhwLWYJDmeBR8v6j8c2Qm3cYBCIXBdiJJ/fTM6Fz507NUZlfpFFjwB0RgAhWYQm3bFRLCBLOJq/hlLrObETjXbfpjSiY1p4ZxRV/E6TarjRVdcZthGo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM0PR04MB5409.eurprd04.prod.outlook.com (2603:10a6:208:120::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Wed, 20 Jul
 2022 21:31:03 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::54aa:b7cb:a13c:66ab]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::54aa:b7cb:a13c:66ab%9]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 21:31:03 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     jdmason@kudzu.us, maz@kernel.org, tglx@linutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kw@linux.com,
        bhelgaas@google.com
Cc:     kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, kishon@ti.com,
        lorenzo.pieralisi@arm.com, ntb@lists.linux.dev
Subject: [PATCH v3 1/4] irqchip: allow pass down .pm field at IRQCHIP_PLATFORM_DRIVER_END
Date:   Wed, 20 Jul 2022 16:30:33 -0500
Message-Id: <20220720213036.1738628-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220720213036.1738628-1-Frank.Li@nxp.com>
References: <20220720213036.1738628-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:a03:255::10) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e42d61b1-aa3a-454a-b8a6-08da6a97259b
X-MS-TrafficTypeDiagnostic: AM0PR04MB5409:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KmH/rzUDrxtGGplsV3bVLlhBSGCJ2GzivaguZNNkgzoxqdPmvKxjZpP8QfLRMcT+qYd7qr3FziDybCLSpvmKONj0pCaM/ZsRthFxbhvdBgBwLqRYKm3iB39Q5S+i9zz0rowWchH9/UQ3+r0ds1a3qgmNzYj2NudaS9sUotSA/hm9sZlFd5U/CWwRjVQjB6Rqfyfztzb5KwFQIZPkqwh8/wnmHMemWDclHUZpl5RHJ3aBfFQKO7xbv1CFUb4+jaA3VDxCHMZgjYJp5476epHC56YRmK+mTtkRAvAM/OB8oxmd+/4AYeXc4NGvw6HEgm3TWyduh/6/soAU8YjWDP7xe2bSCdw5ojxZ2F5Kml4QhTj0jcQ6ZGLoNd7R58Wb9YyFjWctLKQNDcPtDWENINRkJ8Mue1yFF5F/l6WESYQC4/2JS8G5Jlvlk+ALZdTv2FjlZnL6KO71Ty8zBeZDUACIA8N0ga1ovJkVQVWp437vQbzMwOlP4lcXrATsL2G2hW4vwR8uMwqTZgwlMWlIToym8hNli/fOY8eG6Rjrytn+5IKEz/enaf/J/M9B1lOXM7FKNoevxTYpyxoSQmPNpth4ATWC1IpNfcaSRBedB1EFv/p0Fx9dcsv1ql34B8dQgX423IJNbA4uNJFjHWiLk3rZVawUaUu5CXmK7pm82VbPKh2llqBchlBQi6aar78o9h+Q54iEn9sP/zcaYKNqoRcsLX57WEyy1GxuF0iXBsatzjPPG0ULHxlcvmUcW6J5UK+WFx4o48ymEr+AmNN2MXbqTUerrmzykqBXVulecgv1bo6c5JrknJUzHxR5+1+1EFFQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(316002)(38350700002)(6486002)(83380400001)(6666004)(52116002)(478600001)(41300700001)(2616005)(36756003)(6512007)(186003)(1076003)(8676002)(7416002)(66476007)(6506007)(66556008)(5660300002)(2906002)(4326008)(8936002)(66946007)(26005)(86362001)(38100700002)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SRs6it8tqBAMCIIBcUuz8RJbrdst9NyM0JAuXcSOcRrfEY0rukeVOUvW0VIJ?=
 =?us-ascii?Q?sDn3aGPetEdQM8+cP1CSRU64QFgayrE2JK5q1iKM8aK4YaI21Rx4xUvKHMso?=
 =?us-ascii?Q?xUqvAPQpuc6OMwxy1fOcOXEh2MEBZ4FCSEpbtNM30D3GzTBcfPldSVgmEMrK?=
 =?us-ascii?Q?xspdGjlUFAZX83gEzirZjwPeAxbpgWyROKeF87FQjg/h9Q3JghCy4u9/SPWv?=
 =?us-ascii?Q?evLbBYC+Le3JXO8GtICs4oGdhX7grukKTtPdNKBryuQGOOcoM8ucVC/vxGID?=
 =?us-ascii?Q?3snegU7dUMmmyQoiyMCc0diBSP6Vzq5tMl3ZezNGyGvf1IORmPAPt2ihvxqR?=
 =?us-ascii?Q?+4SgnGyswk/LmIaHOZND15UqPHOg6H65vanX+3fWhZ0YHsO2z5wOVXKZic//?=
 =?us-ascii?Q?H0zNnQqLvXeNflB/J7ACSC+rArgeA6gsoUnAv1juQWumHOzYSCFOlaRvJ8jl?=
 =?us-ascii?Q?luLkcAppYl2Udt5hefU0vbVQLOx7RY67dfIAUnw6PBTgnBPY7NoDXQZe2AL4?=
 =?us-ascii?Q?WAreZq9DJR9FVhuyB9firecl054+VgEfPza3wKxTNsiQaC43OKtXMYTMol4/?=
 =?us-ascii?Q?Gaojo8Vm+FqhknPsC+OZr+j1k5qPCWLSh+HZGy1OC9CPwwVbi26jCF68XiKk?=
 =?us-ascii?Q?Mrndh/rrUXGFQtG/67o935fFYvO+cx7B7I5E0HN/QlQvlRaz/ixc/7o2J/gR?=
 =?us-ascii?Q?/hLqVdUtKCYZcaMYbsbtYlh0Gd5TZRXqtThLUAfi4WBy6nXZ5gW5pseqt2me?=
 =?us-ascii?Q?/qTuwNbG5f7aiS2ZeoU0qbLxiAydl7pA4+9yGrxCDhsZg49Mf9fTJBABQ9Dw?=
 =?us-ascii?Q?tVemJgbeTm1HwlTo/eDeBlCp5/bmS6Td8OrkHVUTMc8i9mwsIk0Gl5Xn4OGm?=
 =?us-ascii?Q?jCgKmEiILgcO0WXOqbw5nErLcFf+9hmPs0S/r1BIYEcr2t5jol2dtah0TphJ?=
 =?us-ascii?Q?gDZ3zB4YRCLzFG6FhO+tDRxEQRyzWnjD3tgOjOLIR2UqsQfuuOvbH5OPZnbH?=
 =?us-ascii?Q?H0n0F/MhSGGUmTtNiZkfElSPThmo0VA08sCZNmIuTGGKLd3Xs8EhuqadXKOr?=
 =?us-ascii?Q?u0Eu7ZCAHuzRLvQn/TEtoGCNaRWnZXnkCTWLlY2ljiP0kjOk42qY7RJ1LhqM?=
 =?us-ascii?Q?SPNK0SeBV9Xo+3bYgvJEJsKGSuXMz6UD4+tdAPksjklqn6lOS55rNcgxi1Lj?=
 =?us-ascii?Q?tso10jA5Tn+9tncYKH+WNAbFUfpUOCZFqcgr2J455yPKpBXwvRecyM9eTrsj?=
 =?us-ascii?Q?bHN6tIDqp39zVNmggxNaZYFUPIarg1CiDbXAvc3I2CmUixXLFo3G7nK8Z8Vc?=
 =?us-ascii?Q?o6kEnbanjV+Z4L6J1A6MKHLYQK45RaJqjeiUYY5D+M70aVPLtpWrGxfs81Cd?=
 =?us-ascii?Q?9Y2ggJhyP6Py2b5otKPrk4MHenLg7PYryPiP3SLdiBygSss5bwcyt0rjU50n?=
 =?us-ascii?Q?UgnxDdS9B5bJsTBjrGsDQCnY+B+r82isLs+83nh/wl64nZFSnuQZIDVOuvhP?=
 =?us-ascii?Q?DovT4F9wL6syddhrvMOUIHqsWVySrNaF20A0DcbPtusQA3kDxpvmWC/J4XCV?=
 =?us-ascii?Q?giUCTLZ9mCV51i3feDM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e42d61b1-aa3a-454a-b8a6-08da6a97259b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 21:31:03.3039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DyOUMYaEDyWDztITxVO57XQA25ALnWNFW0Vp2/Tl3y6vp0iWuQ98Z4Y4GzO7zAbkk2gpf8aJhVxIx5VL2YIw0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5409
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

IRQCHIP_PLATFORM_DRIVER_* compilation define platform_driver
for irqchip. But can't set .pm field of platform_driver.
Added variadic macros to set .pm field or other field if need.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 include/linux/irqchip.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index 3a091d0710ae1..d5e6024cb2a8c 100644
--- a/include/linux/irqchip.h
+++ b/include/linux/irqchip.h
@@ -44,7 +44,8 @@ static const struct of_device_id drv_name##_irqchip_match_table[] = {
 #define IRQCHIP_MATCH(compat, fn) { .compatible = compat,		\
 				    .data = typecheck_irq_init_cb(fn), },
 
-#define IRQCHIP_PLATFORM_DRIVER_END(drv_name)				\
+
+#define IRQCHIP_PLATFORM_DRIVER_END(drv_name, ...)			\
 	{},								\
 };									\
 MODULE_DEVICE_TABLE(of, drv_name##_irqchip_match_table);		\
@@ -56,6 +57,7 @@ static struct platform_driver drv_name##_driver = {			\
 		.owner = THIS_MODULE,					\
 		.of_match_table = drv_name##_irqchip_match_table,	\
 		.suppress_bind_attrs = true,				\
+		__VA_ARGS__						\
 	},								\
 };									\
 builtin_platform_driver(drv_name##_driver)
-- 
2.35.1

