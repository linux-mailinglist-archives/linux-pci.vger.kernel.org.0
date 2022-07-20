Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FD557BF92
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 23:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiGTVbE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 17:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGTVbC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 17:31:02 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D32532EE9;
        Wed, 20 Jul 2022 14:31:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCMsfmdJLb7ScAXg3XSaC7qvZSx4GCxU/mdDOOLO6GjpuAaqrxk5mEGxNYPvpppwAGyAIdlbzMeOiDSMGN6cJTy4ShXYnaKunzEOOYq/4izSTuv1aP/GKngBl71FLeYT2ppiCGtWEAchJjAp+kc0UfBmltqPSiCWAkzkP3J1cUr/K54Yd0ER0Q8v3iommVJJNb+fTZgu2fYc/LGlSF02L2oxdqkmAmTeb6BAaEV93iYHfe3HsIr7uuT9Gij8V6+9ZYAx0TwKVbqNW1bAp03bANr/hT7NxniTWmhWPOSAS6U5ZZ5wXbUuP+pSfrjCcMD1rjyvMvHGQ5tumm+Awe+frA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBQOqQuKJU62Vw4dbroiGAp9nKUrPLY3piGGRaMNM9w=;
 b=PzSVaFR0KaXZV52iRBu4S1+9opBNJqHk69irbFZQvsmdahni2J1joljl8ORcG92tQbpx5gTws7hhxNMwuVFyT1RLpX7v4l8mEpbFNq8CmF8Qj+GZv/z4NVL3eHm1tkmZ++TAiBKt7T2CCjZ3KxSqZMitsnAgBpBGasDlAt8cG7w5QVOHTZwgOlSx5RJtu7RBLNO4wznlCX8oodfdOAvRrBIKzn3mgODpQRUblVVupo/P8c0dSvLLmqL0ibXJNQrfsPTpbd3hF3ub7vgYqkt2iqE9pUZOeE4nq9UoaUyc4vkisgSzjDb6lyG0sCWcPRovFIeMI5G6nS1C3+K2loOrnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBQOqQuKJU62Vw4dbroiGAp9nKUrPLY3piGGRaMNM9w=;
 b=ez92hQLi+Qjs8iqKS9igJKRCoyGr+LLjjM3A9C8wnX2QmRQfu53pWnBrO7TVFMa2cfT0XSgKRpiMtPZlUxEHcsoATWgAEVaRnXLdMJOrnGcIfhRI9qVoZTozceRD+2NCpE9YTwSQkpRS8xW6EPh6BLTubrwirgpZT2rv15l2YgI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM0PR04MB5409.eurprd04.prod.outlook.com (2603:10a6:208:120::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Wed, 20 Jul
 2022 21:30:58 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::54aa:b7cb:a13c:66ab]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::54aa:b7cb:a13c:66ab%9]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 21:30:58 +0000
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
Subject: [PATCH v3 0/4] PCI EP driver support MSI doorbell from host
Date:   Wed, 20 Jul 2022 16:30:32 -0500
Message-Id: <20220720213036.1738628-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:a03:255::10) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5da7568a-78f0-4f74-c8b1-08da6a97228f
X-MS-TrafficTypeDiagnostic: AM0PR04MB5409:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZL1y9NWm6N10UXF8jssR5JW0+xubUK5iKyZzibsLCXXWD5DbMkZ5tWHEJXvHsu/wCbc2P7kAqZhsUzWIcNsdbNdYEFoFHzr5YP4uf/qoWNoYBpjTvpGnXE9hq3xEBe0kT0vKmIeSvcZcDjRyEGTcDKPEFxugK4zVx2heJpH5F8PeW4e9fSTza9O6c7fm+k53Wa+1w/QrXefzugdVSFTxQadr5w8lxDvH5S/7uhcrDcvVWsuWmar7pZYLajVNd11HXIqp71shcFD4/hWreBm+1N80QF+Rgvcpe6QFF5v75ttIv6m1DOjboBil4hQnKQG3m2ErrM0zETtAgYw/XHVDUqfp+X5kpFrvG+kpzXp7eisYALd4f+RGcWr216szIYh2ExEsVwLcweTE+zrdbD7lY5T5Q2MS2tE6QXW3MuojhWn+4vArauwJqTBwxhd0uu2zGQeNFKMMAckcCYk/KkykMb/PCANsgzjN9+a+a5HQAUUpP9o2h/dfU0gZwlV6nmpTiL6GdvcbeU0oRHsmB1Kj/LU/FgjjI6bU+DgBcI2H8aZdeVxB6cBalohadtouoEL2l9eUiHI5hBE7HbpNgutJWmq34WUCbDwhMvBOscTkcoTdeH3zFa3V4g7uEkFCtxh4TEaHimJb4GELagj89jTz5TdiId1y4xjs9tsGm7wQv1YO92KugKuiw9RqibhMhdS3qJT4WqA286+sBPENkuUKVopxpqL46fheWQNOYocghlPgt9QO+mLXlQA2eIUqMV+hS6ESShPFxStww00odjNxsW35h9XBq56euwWsCsWwiJ0xeOZv0Achx1TNC+FmbDN7UQQ6/XKodIusa2gaDW60sA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(316002)(966005)(38350700002)(6486002)(83380400001)(6666004)(52116002)(478600001)(41300700001)(2616005)(36756003)(6512007)(186003)(1076003)(8676002)(7416002)(66476007)(6506007)(66556008)(5660300002)(2906002)(4326008)(8936002)(66946007)(26005)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YitlYnM0SzMzdEJVTDM1YjZOaUcxTUxoWGVPVHRCaDByVWJtaUtxREx5NE93?=
 =?utf-8?B?aTdDY01hMVIxNFY3ekhUM1Rlek90VG9Yai9JczFIOUN4aVFkaHpkVy9Va3lu?=
 =?utf-8?B?Y3IxM3ZTcTVXNFpaVms1a3pFRytPSHppa05OU3habCs1NkZkVmZ4dUFiNzZW?=
 =?utf-8?B?TUgxRE1TUDgvZzE4QmxQczV2TkpUdDlHRjBsaXJaUXpMQWFFQVZNUnA0QUQ2?=
 =?utf-8?B?NmlobmprcmlreE05RENVZ1JMWW9PZGNCZFFoVTZONSswSzM4QlVocndtN2Zt?=
 =?utf-8?B?Q2hvYXRsSVpSL2xTR1JmMkExTExVRzFsMi96UGQ2WkthSFFjcmZaNStFNkpz?=
 =?utf-8?B?dmZmTi9RT01QTjJnZ1g5RUdOWkQvazcyakFUN3RuRXU5ZWxSMy8rNGJlbnFl?=
 =?utf-8?B?Vkd0NS83N3lDMkszcTkrZUxLNC95TG5rYmVHbWdvYTZnd2dhTFBMQ2VlUVVK?=
 =?utf-8?B?Y0J5NSthOVE1MHpTcC9yeDQwVmxrQXVScHhOSVBOL1N0NTJYaE9GVnl2RTlY?=
 =?utf-8?B?Vm5uY1ZhVFIwL1hHS1Q2TllwSVI4MXJVeG40QlRtM0ZJSjBCalNDN3ZnL2pU?=
 =?utf-8?B?TjJxeFVRZjBURG52Q0FKS0Q3dWJ5VE1GZXNDVjI4Nkt1RmRiYkd3ZzBEMksw?=
 =?utf-8?B?RWF3QkFyU2QrOWs1SDlQYjkyK1cyNVRPSitZQWx0WTkyVWRBWEgrNlFuNmZW?=
 =?utf-8?B?VGZKTlRSUU1aeE9mVWo3cVdUaFlKNHF4ZnpGYWY0SGU3dXVjOU1qN2dZM1Jn?=
 =?utf-8?B?bnR4TU13Q2tKbUZlbzNFMVRZcEpOcHZSZDdURW1palV3L1hwK28vdVRpcUhF?=
 =?utf-8?B?MnM2aEZxQVQzTVRJcFArYUpyRFNKOWxrWmd4akhFSU5LSXJxVjRZQzVTR3BX?=
 =?utf-8?B?RC9mZ2ZkZitNMllzOUVuaTJDT0IzdWQwUmcvbFV6cWFib3N5Q3VsTDJjNndv?=
 =?utf-8?B?OEwxZFBtYko2TFpzeDY3d084RTZWVjBBeE4rRE9sTWN6YTlTRWc3Q09iT2Jw?=
 =?utf-8?B?YnNtVmJZM2FQZjhSejFNdjA5QXlqOGkzU2FLMWNYRHVxV2dGWTh0NXJmbGR4?=
 =?utf-8?B?ODMyMFlTWkdSTVBCRWNuMm9OOTlxaGpDV1ltZm1PbUdnM21qUG0yNU9SZGcz?=
 =?utf-8?B?VUhUVnVLUlJMbSt3TDhyQ3FRQmNRVzlpRVIvQUdWNEJyZUR3dURTbStNcSt2?=
 =?utf-8?B?TzliZ28rNmE4RmxLL0kvekFtR216OXVrbk9QbzBhcnlGaFhyN2pyMUZzdVVh?=
 =?utf-8?B?a3UxRVZNMUpKWE03SC9LcVA2d2pHTk40SnV0TVVrU0R0dVZQN0MxZkJrbThV?=
 =?utf-8?B?UHJGSElGSG43cFFEWXQzSVd4akxzNWU5VytQL1BGQngxRkV1aTN4UWhjV2xK?=
 =?utf-8?B?VXVQUVM5NUFDUzBVdXJobWJGeE9KM0NoaU5zakc0cDd5NGwxK1VBekl2WXV5?=
 =?utf-8?B?bGd5ajhZeXU5aGV5Y3I5SkhNRGtYY09nT1kyQ21CR2kzaTEzbUhwR09yWjRy?=
 =?utf-8?B?QjY0TG1jcjlLemt5bnpUUkhKb2tNSVJnUWhOVmU4cHh0OVVyYmRyNEduV0dL?=
 =?utf-8?B?OHhSS0tBejhjU2tRYjlFSlBjeU9kcnRUZ09rN0dFaTR6aHlsaW55clFMM292?=
 =?utf-8?B?cW9SMll3NUhqNTNZOGVJNDlPTGFnUVVIbkdtTGI4M1pZRXNXVENUQS85d0l1?=
 =?utf-8?B?ZDNPMldJTSs0LzQ5OGhGMlEzV3hGMUJNMEZOWlpuaWFySCt2UDRpNlhHdE1u?=
 =?utf-8?B?bE9qQms3Qk9IaklFSzI0Zk9nb3lUOUYrMjFqM0p3aTNVS1hQQnB2TEY2Vy9n?=
 =?utf-8?B?QlpQU2lVZzJCL2ZRUzBkbERIWjJSNEp5WXlkUkNMOFRtYjFJZlFDNmFvTjdO?=
 =?utf-8?B?Q1lOcVZjd1I1ME0rOVlycW9GNDRHVHI2OFlQQVhWYndOaElkOE5FWlJBblJT?=
 =?utf-8?B?ZFErN1V6eFRyWU4zUHRyelhMd05DRzhKaHBVUTYwRldBTkdsWGU0OFhIazBm?=
 =?utf-8?B?aEVwSXhHS25zTms3NHRPRkdQby8xM002dEx5a3c2VTB2R3EvNEN0Yk5iYmVH?=
 =?utf-8?B?elRaVlFnMDc0S2lIVVlGZWpCV3AwWnVmL0ZCSC9NUFlZenI3eHhzUThzUGVl?=
 =?utf-8?Q?hbpA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da7568a-78f0-4f74-c8b1-08da6a97228f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 21:30:58.0362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2CXfsCPrS4Fh/vVUi49CRhZqV2m3+TrDpLCFtXZ6ZQCGF6DDhpxWZP9ufA32CWTQ7olnVWt/RQp7BgD5nMErQ==
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


                  ┌───────┐          ┌──────────┐
                  │       │          │          │
┌─────────────┐   │       │          │ PCI Host │
│ MSI         │◄┐ │       │          │          │
│ Controller  │ │ │       │          │          │
└─────────────┘ └─┼───────┼──────────┼─Bar0     │
                  │ PCI   │          │ Bar1     │
                  │ Func  │          │ Bar2     │
                  │       │          │ Bar3     │
                  │       │          │ Bar4     │
                  │       ├─────────►│          │
                  └───────┘          └──────────┘

Many PCI controllers provided Endpoint functions.
Generally PCI endpoint is hardware, which is not running a rich OS,
like linux.

But Linux also supports endpoint functions.  PCI Host write BAR<n> space
like write to memory. The EP side can't know memory changed by the Host
driver. 

PCI Spec has not defined a standard method to do that.  Only define
MSI(x) to let EP notified RC status change. 

The basic idea is to trigger an IRQ when PCI RC writes to a memory
address. That's what MSI controller provided.  EP drivers just need to
request a platform MSI interrupt, struct MSI_msg *msg will pass down a
memory address and data.  EP driver will map such memory address to
one of PCI BAR<n>.  Host just writes such an address to trigger EP side
IRQ.

If system have gic-its, only need update PCI EP side driver. But i.MX
have not chip support gic-its yet. So we have to use MU to simulate a
MSI controller. Although only 4 MSI IRQs are simulated, it matched
vntb(pci-epf-vntb) network requirement.

After enable MSI, ping delay reduce < 1ms from ~8ms

IRQchip: imx mu worked as MSI controller: 
     let imx mu worked as MSI controllers. Although IP is not design
as MSI controller, we still can use it if limited IRQ number to 4.

pcie: endpoint: pci-epf-vntb: add endpoint MSI support
	 Based on ntb-next branch. https://github.com/jonmason/ntb/commits/ntb-next
	 Using MSI as door bell registers
	 This patch is totally independent on previous on. It can be
applied to ntb-next seperately.

i.MX EP function driver is upstreaming by Richard Zhu.
Some dts change missed at this patches. below is reference dts change

--- a/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
@@ -160,5 +160,6 @@ pcieb_ep: pcie_ep@5f010000 {
                num-ib-windows = <6>;
                num-ob-windows = <6>;
                status = "disabled";
+               MSI-parent = <&lsio_mu12>;
        };

--- a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
@@ -172,6 +172,19 @@ lsio_mu6: mailbox@5d210000 {
                status = "disabled";
        };

+       lsio_mu12: mailbox@5d270000 {
+               compatible = "fsl,imx6sx-mu-MSI";
+               msi-controller;
+               interrupt-controller;
+               reg = <0x5d270000 0x10000>,     /* A side */
+                     <0x5d300000 0x10000>;     /* B side */
+               reg-names = "a", "b";
+               interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
+               power-domains = <&pd IMX_SC_R_MU_12A>,
+                               <&pd IMX_SC_R_MU_12B>;
+               power-domain-names = "a", "b";
+       };
+

Change Log
- Change from v2 to v3
  Fixed dt-binding docment check failure
  Fixed typo a cover letter.
  Change according Bjorn's comments at patch 
	pcie: endpoint: pci-epf-vntb: add endpoint MSI support
	 
	 

- from V1 to V2
  Fixed fsl,mu-msi.yaml's problem
  Fixed irq-imx-mu-msi.c problem according Marc Zyngier's feeback 
  Added a new patch to allow pass down .pm by IRQCHIP_PLATFORM_DRIVER_END

-- 
2.35.1

