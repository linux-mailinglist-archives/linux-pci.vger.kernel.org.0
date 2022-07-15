Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9039D576749
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 21:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiGOTWt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 15:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGOTWs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 15:22:48 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0B460506;
        Fri, 15 Jul 2022 12:22:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrxsrvgzPuvTUO2VivRGHAcXu9CBr0RNNmiCmClqrp8dTM5cnWgKeHaoo316l1eFTeB4MQQJCmptCwdlbP7Yl3wlr5XfsRUXZTAlmwszf4YcRQRx3PdzadPB00V7KolXcK+n+SwTtovCMCbDNZBh6fZurbB4lPMY2tRh/sIvolSDlH6UshXPnt0bldy8gFPDs9YDy8sftRqKkPc5QwgCg+bPcFDP72a+OoHEgPQ0UBkefHUCTkxV0mya3/Xi/UoChmsg7WJlnUN4l9c/xyZHPF/cy0m8PnIvoDEVIp1ypyb/j8amdb8F+bfxI0tjDy9N2vBZC6YAuj78QPQFVcMCTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJ3Ek3I76ogTB3E8FeuHsTYX2B4EThq6xrU9n3WKLAc=;
 b=gL8b2AJqX3TZCaeE+fR/X3SiDMkfZNC8V0IJJ6A8JTejtpS8RTmuZkPGUNZV9CWIbJ1ZNVpHZZlAP2PA79+1WYWTwP4p9b1/zcICoV05mei/6uHU28LBUounaE00ASZmWA7RX7xDbjgdF+JZpt/DccMwwEQQDmBrNE+rwmaRG+U7ouuLxMuYX550ey1O6SBR5Cv1Upr5tylz5WlbVugi52ne9dEtYi/gKNSefV/MxCv4L1MMf0+bvJO+nN/26wcKpTKP/oNPKOgOMIh0q7yM0L5XBtH79HH7UdKTFQXyItfbqAGYljKUvvR6p0JOZImW+AqIeX8lsJPW0TA/77fnjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJ3Ek3I76ogTB3E8FeuHsTYX2B4EThq6xrU9n3WKLAc=;
 b=EdI2oNIJRmPIZjmPpAUwAW2S/vsSobTd19p9+s+kel0yY4RdMChNVamwte8OgIU6U3mmaQaVTlcKPgKr5YazfmBBrmKVBn8VEaYxxU+7/lm/mIAk4hB2DWIVmDg/9S7TyEZdVuxIBylZ8uztaGeLJnVaZ5A4H9fNMDkrvPdC35c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by HE1PR0401MB2490.eurprd04.prod.outlook.com (2603:10a6:3:82::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Fri, 15 Jul
 2022 19:22:42 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::54aa:b7cb:a13c:66ab]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::54aa:b7cb:a13c:66ab%7]) with mapi id 15.20.5438.017; Fri, 15 Jul 2022
 19:22:42 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com
Cc:     kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev
Subject: [PATCH v2 0/4] PCI EP driver support MSI doorbell from host
Date:   Fri, 15 Jul 2022 14:22:15 -0500
Message-Id: <20220715192219.1489403-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0084.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::29) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2280d835-476a-47da-dc25-08da66976374
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2490:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KAfMxwN+Gnpbq9drSPyaU3riw7XqR9h1ZzDD1zj5jEhaLohxquwzSDcDEvL2lpayBUwvjM2T1I18fLTzqi70oJPqyWikMNxzjc5EKJLKGOQbO725/iaxWfhs7Q1AJXXnkxzOlg/9YMPsYFxQNQb39oIodGghVc1u44pbkZecwxKLWYWyHTWi80Gd5+zVItLmnxM8a6w8fVqp7MAS9tcmTtUamA42URE8hwjzbPX8dWNhkL7zL9Fav+qlFc0xJfgdozu/IFgfpsd/jt8wOCNJbLTWVw9ck/2x0K9o8YwMnICOuNl7Bf8mSIuPP4TdUOuzEUHr2oHUiII7vbKlgxJnE/O5O3LQ6KB5YUgy56+1QbpLa2qzC8Dujn0dGRqSclrb4odduf/g/9g8BJMoLqrdVebn8ofkGPIwEZTkQUtug5tBSanv0TrVOpbkh5IRpbYARuoxx0hQLU7q4nHQ9KuayclygbLezRG0kl3/1ywD2v1IGVCuMz/oviBo4dJW8EdR6QttxvcQ6h/tEl6jD+IT6CBhKuZ0ryNgn2wV66AsmNoRa80oz1nTrDKjGM4yZCd8WZ1pwm/LTplJrA6GqO/BoRevKP2oUKXCN+RnzrNDs0VOrWn7qpheEhTiWJaZBuGOH69LnHD05jaPSt88les16M92fj+AWkNBwb9LUqyaZxErY7dYMo6099g+oLe0iiV4yhjPbPdrgIeztTTHl/iRX1FrI+eGNmCYYBLaD6kTN+rHdWYyFdwAmx93tHnLC2LEfKMBhKs10D8nA1k90zydlpdXePYRYVRO0M4ExRYtDAX7UFAloVTtFM5BBGhiM6i+ZMCQvMSYnvX8HtmDC8WKjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(316002)(186003)(966005)(5660300002)(86362001)(8936002)(66476007)(66946007)(1076003)(66556008)(6486002)(4326008)(8676002)(6512007)(2616005)(41300700001)(38100700002)(38350700002)(478600001)(26005)(6666004)(6506007)(52116002)(2906002)(36756003)(7416002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlM1OUJpakRZWitiUG02Sk5XUFBUdHJVK2R3czVRaTB1Z3NXaHozcFlVVmtv?=
 =?utf-8?B?VzZBQmpKSDZSSmRjQko0NFg3MDhaVEo4TjEvbk90cTQzOXAvbHJBNWFsVng4?=
 =?utf-8?B?T1hmZGJoTUZJQlQzMm5nVEd1VHFIWWNCRm5BS09HWmw4QXE0UkU1T3pqclhk?=
 =?utf-8?B?WHBGVVlZV1ZDYm9iSTUzMGNOdXdLTXY0SWV0dHBoR0Y5bzJJeFd5WmRHbzMr?=
 =?utf-8?B?clV4QTVmZDJJUy9MY1lXa1BMbHJ4YUhqQTlwZHQvZHBrSStkTG9OeEpjb2V0?=
 =?utf-8?B?OWptOGFuSVJ4c1hyekN5NUpDdVg0aWhuNFpMKzFOR2RYOGdOT0NYN0YxaHFS?=
 =?utf-8?B?NUVjdXBpaWx3S042SmJyMGJPSUI5VzBiQU14bXIwRFNmbkhIZThPMDFaODBt?=
 =?utf-8?B?b201ZGRzcjJqSXZxNDRuS0NVcFExaTNERlAxdFV1dllSRllzL0ZHc2t2L3BI?=
 =?utf-8?B?TzdzSXRWNlZOUllaY0xHVjdCUTZlUVlqaVJqbWY4enJjUThMT01CVXY1dE1n?=
 =?utf-8?B?NUlDS204Y2djQ0VyTWQwb0doWnM0TXZnd0tNRHBnWXU2RzBhWSt1REFFaFdm?=
 =?utf-8?B?a2M5SEYrby9iOEc3NERsMUlNQmpObVk2cnRtZnVHWnFjU2tPOXFjTVJwdWZp?=
 =?utf-8?B?QnJXT1RVdE02a01LMGxCakRYcHRNWmh1Ris2YWk5TU1SQ0xnU2ZGbU41RXhL?=
 =?utf-8?B?M3B2L0c1aHZlZEFnYVhYa1RMUVRVWk85M1JERzdZSklnNGhpYk80WEtKZFBG?=
 =?utf-8?B?Y0NWVlI5M1JKNEg3TXZ4bGFkZ2lqckFMcjIzRXNaSi82S2srcHNpLzAvck80?=
 =?utf-8?B?QU9KdEJYZGZGRk9HOVRMU0lhWElFN0k2VzdXQTlaSk5lZ3JGc3VXYVMrQWI4?=
 =?utf-8?B?NkFIa0wvcEtualV2L1M3c3ByYmVPc1hhUlF0c002YnkxaWU5OGxKeCtPT0U2?=
 =?utf-8?B?UkdnTHJkVjVHVlFPcnY5U2s5SEtJM3ZVTDRzQVVLRWJmT3ZXV25QbHUvMno5?=
 =?utf-8?B?R3lVeXdYR2dCSnN4WklTbkdnaHB2SHJEY0xJRjRJMERTeDlQN0lBUlRTRmJn?=
 =?utf-8?B?VE91bG5IZ2pkWFV5NFB3c09GOW83NGkyY3ltTXdPNmZxYitoZFBtRTdIUlJP?=
 =?utf-8?B?N2xwZmVRZ0xKS1BvQmZ6d1pJQjF5K0MzbXdyZ21MVUI2OVBCY3FLcURIZ2k0?=
 =?utf-8?B?OU0valFFR0w4ME82ZEorTlFRVkdFZSsvbmUzTVpOZHhWVWM4Ykh3YlVKZ3Bj?=
 =?utf-8?B?R3BPNDVWc3VFTlZoR0RTdXVxN0J3T3g2N2g5bjduWnlROThEc0lUTjFvZ0Z1?=
 =?utf-8?B?RFErU1dZb3QvOWNnMkNpSURMTTRCWE1NOXpicWFwZ3VGMjcrZy9OSnVqZzZ3?=
 =?utf-8?B?NXRUTVNBODFZdWhkMkhyeVY4ZGpUWWdDYWVFcjNSdTZINUhUKzRhSnA4d0s2?=
 =?utf-8?B?MlJGcFo3K2VybjNvK1E3NExIRkc1bjNHdFZOc3ZNQkFsL3NDRVB3QTAvTllT?=
 =?utf-8?B?NUwwazh5dSt0VFZtUHp2OThUcTUwR2FjeGloWi8vM0JwK0VCOXRzZEtzN0tQ?=
 =?utf-8?B?MlNnZlpuWCtoV0lqdURXdDJpOE1rSVArakVuRzFnSWk5OWxsZmdDUnlFQ04v?=
 =?utf-8?B?NDFRZEtkbm9GZmxkRzZxZU1STnZQTG03ZkJsQ3dIdTRDRVVJbWYwb1VUbGJU?=
 =?utf-8?B?OFgwRjg5UzRVK2loZGg0T1U2SFFqNkhmQ2JaYWN1a21vNUFlOUdpU0s3K1JE?=
 =?utf-8?B?T0x2RThkdDdpK3EvZ01KRCtwZVFFd1VKcGVvSDhYZlhGc0Rxb0tEcGwyQjZw?=
 =?utf-8?B?T0RWVWRSZldpaFMzTGZjRFRWYkxZNnEwbG8vSHNwNkd6Z2FPcVNydUs2ZW1r?=
 =?utf-8?B?STdwblhSd0RwRjNoQkM1TVoycDhJR1lVU1lnUXBUNTJrclFOUHlWTmUvVUVs?=
 =?utf-8?B?L2FLUi84RVJPdEgyQ0xzUERMVWFCcXM3b3ZicHI2ZStVOE42Rk4ySVUxMkdk?=
 =?utf-8?B?MXVaSWdrWFhMSlJxSzU3anovVkgveTVmWEJFSFZXUk0rcTZ0Q3psUURpU0E0?=
 =?utf-8?B?cG9XS0ZMK3kwMFZiT1l1WkdOK2pVUWN6OUQ3aCt6MXUxVHI2a1VjYmpTbDNj?=
 =?utf-8?Q?N1u0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2280d835-476a-47da-dc25-08da66976374
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 19:22:42.3075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AgdcKci/K9G0a1W584hVPUGoN1l2TTPDFp0C31oOjCtcxZiVH0Xcyvqd5cuwvuYTqH610NH8SB3IGXSmMibTsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2490
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
Generally PCI endpoint is hardware, which is not running a rich OS, like linux.

But Linux also supports endpoint functions.  PCI Host write bar<n> space like
write to memory. The EP side can't know memory changed by the Host driver. 

PCI Spec has not defined a standard method to do that.  Only define MSI(x) to let
EP notified RC status change. 

The basic idea is to trigger an irq when PCI RC writes to a memory address.  That's
what MSI controller provided.  EP drivers just need to request a platform MSI interrupt, 
struct msi_msg *msg will pass down a memory address and data.  EP driver will
map such memory address to one of PCI bar<n>.  Host just writes such an address to
trigger EP side irq.

If system have gic-its, only need update PCI EP side driver. But i.MX have not chip
support gic-ites yet. So we have to use MU to simulate a MSI controller. Although
only 4 MSI irqs are simulated, it matched vntd network requirmenent.

After enable MSI, ping delay reduce < 1ms from ~8ms

irqchip: imx mu worked as msi controller: 
     let imx mu worked as MSI controllers. Although IP is not design as MSI controller,
we still can use it if limiated irq number to 4.

pcie: endpoint: pci-epf-vntb: add endpoint msi support
	 Based on ntb-next branch. https://github.com/jonmason/ntb/commits/ntb-next
	 Using MSI as door bell registers

i.MX EP function driver is upstreaming by Richard Zhu.
Some dts change missed at this patches. below is reference dts change

--- a/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
@@ -160,5 +160,6 @@ pcieb_ep: pcie_ep@5f010000 {
                num-ib-windows = <6>;
                num-ob-windows = <6>;
                status = "disabled";
+               msi-parent = <&lsio_mu12>;
        };

--- a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
@@ -172,6 +172,19 @@ lsio_mu6: mailbox@5d210000 {
                status = "disabled";
        };

+       lsio_mu12: mailbox@5d270000 {
+               compatible = "fsl,imx6sx-mu-msi";
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
- from V1 to V2
  Fixed fsl,mu-msi.yaml's problem
  Fixed irq-imx-mu-msi.c problem according Marc Zyngier's feeback 
  Added a new patch to allow pass down .pm by IRQCHIP_PLATFORM_DRIVER_END

-- 
2.35.1

