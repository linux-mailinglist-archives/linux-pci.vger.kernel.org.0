Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8138E59C37A
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 17:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbiHVPv5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 11:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236597AbiHVPv4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 11:51:56 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616082A960;
        Mon, 22 Aug 2022 08:51:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qz0rmHKs5p2Q1gh+S9fh4i4MG8hnRoDPrAIyNBXUKBYyFJHyyQZ3ZjEx0efihqHEXVFJU+LWwqkoyrr57RTZ1dI++7ejc69iqSCjV7KuV0HQXY36iE0OKLGtHPszSdui4Vs1rs0xifGXLFLY5bjG0odh8aZ1EDnu4ih4m6x/ua3RJBESYJgIeicIDn163fZjtvKQzfjmwZ473tHNtm+ODkUu1dHADevVQbd0aJVeE0knELDcmT07oKDTIIyiXCJzu6S0dSFaZEnVumWR7wtvnOz0x1anKQ6CnTLj1IxOjEHhxIqudPU9lc9vLSYmy2brEATBkkuEmx5ClR/pw9/4Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJlixqmQQxoLKu6qGTAVvd95979GeiOaY4aPCwvlxjs=;
 b=KTo7wPJYQxGCNTS+dKJNXx3R5J9CE6DheE+7ViCNt6h/CEvcIwHytXYQr9vDxQIbbGHGzIPK/NIJLqg477K0mUvek8awTvG1czMVOgAipuURy9BkyZoi1rcjwij1blDoked40OnxZskSsdE5LYA7RYNvpbZX5XA759olbMxMsDq5fFVsilUM5KdBL2SMm1p0NQMF7QdiqQ6hHcZyTf8qTZ0rcBxD53v9+ppVgz+wtoIsErGrsxVXImcQEUjqFLF1Qj3SdOW0UuLukYGpK4IwBMETy5AJigJfB+Qxz5bZT/uKIjWaGffM6vhwpT+K2X9urx1JBceqDt9b3P5k4fP1Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJlixqmQQxoLKu6qGTAVvd95979GeiOaY4aPCwvlxjs=;
 b=JSKlLCTAsGysH97ISYHeTycODCOBiwIgMGFHppV5iMW4jh9ZVkUMWxxXA8SQNyKYhEtp6B2F0RHfqy/JQk0V18woUe9DySE5XyctLZw1ehFvRkYiP/FZWY9if6y7SvcZlxNrTbD+dA1TElDgEcxaPfWfBu8JMyiAx5rUzozJXfQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM5PR04MB3169.eurprd04.prod.outlook.com (2603:10a6:206:4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 15:51:50 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::85cb:614b:9f52:2dba]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::85cb:614b:9f52:2dba%4]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 15:51:50 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev,
        lznuaa@gmail.com
Subject: [PATCH v7 0/4] PCI EP driver support MSI doorbell from host
Date:   Mon, 22 Aug 2022 10:51:26 -0500
Message-Id: <20220822155130.2491006-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0038.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::13) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a09cbf7-3f7a-48cc-8ba0-08da84563a07
X-MS-TrafficTypeDiagnostic: AM5PR04MB3169:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BXcWSMLSSfVFcifcbSte0pRpFWw36ZqqiprdHSJj/s75Ok5uaJ5mFd8Vkh+/Q+4hb9aaQn4b1SQWbuj5IxWMtsfC3ZUqEDBL3AVCp0ygbRIXIijSMzp9YRi1lrnXVOzgqnC2sCUgBZmNyMEV5FIBlIqnu6Rj81pvlfFeuRKqpZVocPO/wzYBaLZzAhEM8EndaoG2NfeliW3COEwS6Lx8EFUET6MgAXUAjy+0qGfaDGA5m1+eOlE5rQakq23PMevcoLyYrPFf1fPWC43uLaFPG1zFDIafgFYbk52XbKa2jgER8ZZH8XZaNv6a4BHk3AYc9HBh97R0YCXAa2ULt4gGhQhPIa9a3NoNY/9M4ROOuA8j0YtUi7r4CuW63VXoDR7VX0H8oaqE5Yx/xBbR1CqerRFADb1wMplz2UvDuym0H1h2jIfEP0uGC1vl/2LUh/stoW4eh8mzJo0LUrBTFngiizJktqJHtREOedoDPraeGe8FkDsmfIzs41bHhsbdUpOCuzi4g5Ev1cjToc8EjKe3cCaG5TSJE+gxfpP0RPL1NsU+OtYrvH43FBeRaNq3T9qLa7j5xOnN1jJHFOWoaFZb6dDpaPidwwYAv28lMr/qcs/FtcNWvINP0YqgKxGrDxrzwwxSU1G5cgZNMsskTe6uHZH4EsuJI3VK8WXAaDiHIhmWI6SqU5NIj7EjEqWlkWRK1YBwO/zNaDZ/r3AT9+kp1g18QYzBDcQCSkBv8LXbiVMPcTs30yj3gfFL58Rwut+EkbDoT7tS6KJtspEx6bBFZG2jzVL9V9qMYM322q4LNUc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(316002)(86362001)(38100700002)(38350700002)(36756003)(41300700001)(83380400001)(26005)(6506007)(52116002)(6666004)(6486002)(966005)(6512007)(478600001)(2906002)(66946007)(66556008)(66476007)(1076003)(8936002)(5660300002)(8676002)(7416002)(2616005)(4326008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmUwS0tZdTRrekJHbVlCbW5LcXB2MlEwcVppR2R1YzhHdkVTTWNJWTBUVVpk?=
 =?utf-8?B?VTFFaHZRc2ErREd1ZXllWmtpV2dPYzNPRXlOTmVvR1U2RlhxZjN0Y1Q4eHNY?=
 =?utf-8?B?R0ZkQXJ6aUNQelloalF6R3BMUjJNRVYxMWN5NU8vNWxCcVNLeUE3bENiOGtN?=
 =?utf-8?B?K3VnRzZGNk1nNXJ2Vnd1elBtclJZUXo0M0x3VzlLSU12RzNoQ0hwV0grYjh2?=
 =?utf-8?B?YVhScmF2bGV1KytTQ2ZoaGJGeWlaamlZTDc5YTExOVA1cmdJNkpFTDNjWDhW?=
 =?utf-8?B?QTRkelFlQUhwbWRtMjFZcU5McjNxQklUYjdwM2JPZ1UyYUIzbWdROE1TYzNy?=
 =?utf-8?B?eGRGQkJkOXMxZlY0dldVeCtqeFJ0RjZpNDZvNSs0MDlOczdzM3F1YVFKaEg5?=
 =?utf-8?B?NFZBcG9zWjQ3R0hTbTNZckZ3WlVtTEI1VnovYkR1SGlOYlZFTDRmNnA3cGpp?=
 =?utf-8?B?VVBLcVd6VE5zQ3RqYTJSWTB6WnFCZDdZT09FOGtTNGxMRlJTZk5sTDdwdGx3?=
 =?utf-8?B?YW5hdVp0bEhvUWtmTldiRG9ZcTNHYi9aelYwcUFDdE9ZMk1qajhkN3poRXdC?=
 =?utf-8?B?TjBxdElPWHFNYkxyTGFLS1BQb1REUDFQeGpaMTRKRW9RRStDNTIzY2IvYk5Y?=
 =?utf-8?B?eDZPUTJEVVVSaFRpU28rcmJFVC8xU29kWFZqYTdCb09iQ2lmQzlienJsTWE2?=
 =?utf-8?B?TGQ4Sk5VVHBFcDNPOWs3Mm9lTGt1aDB4ZU9wTi9jZ1M2Y2RBQ3h6VmVOWU16?=
 =?utf-8?B?VzJENjZQT09zYzRsVzM0UnRqRFQzblE3c0ZmL3ZPaGFrZUhnTVdieXZ2di85?=
 =?utf-8?B?bmc5TTRTRDZZSGZiQ2lzVDlqdDBUbzZPWlUvVUxYNktTUE52RStucGpuYkt0?=
 =?utf-8?B?MDIrcUo3K0k2TElFRTNrNHhnUkY4dXFOWk83dUh1ZC9WemkxUnpEZnJ2dk9D?=
 =?utf-8?B?RG95UVNqaUhXM2lOZFZoZnVmODFHQ1h5YXZJb1lFazJmVVViSlM2SWhtWG5j?=
 =?utf-8?B?NGczTkpGTjJEVUJFamtPR1JZOWJYaGh1MTV5dml5SXoxTVdhcFlJZEd6cnpK?=
 =?utf-8?B?dnpwY0dHMDl3M3h6R3U5NkZkdzFRTHdHQy9lMmxlYmUrM2VrcDV1QmtxVFpB?=
 =?utf-8?B?U0lYUHRnT3pQSkFMSkx0dHVxU09ySEhLQVJ0M0JKVytLdDROUTljcmR5czkz?=
 =?utf-8?B?eHNwaUhDb1R4S25Jai9oNDNCL2FjOUJTRGNPa3Z1MVIxbUZ4ZjlGQnZFbjZ4?=
 =?utf-8?B?YzNvb2t6dGhtNHZIT1RIbUIzazliRmRRV3JhVGlGRDZ6K204dnVsdnYxSVUy?=
 =?utf-8?B?Mys4K2lUQTFVUlF4SkxuRmlFM1VpZkh4S3dpc1M1NWVPSlFCMEVJc2hFK1p3?=
 =?utf-8?B?ZVh0UjRBZUFnUzVIcHpycjhOb3JQY2RnNExEb09CVndTQ3dPekxYR0xBenhu?=
 =?utf-8?B?RllGT3E3QzJpMXBLaCtCVEw0OEJobGhyUGg2NWRqMGkxOHNtT2p5Y3NOM2Zm?=
 =?utf-8?B?YXY2UzRhb2J6bnBDMVhkZzFPU0hoa3hsL2E5SC96d3BIOEhiZVRqOU9URndG?=
 =?utf-8?B?TG02cnlndzFJY0k3RG9YMnZnbXVwaUZ3WGJ1cmNTRGtOVUtNbjhIb1RIdkMw?=
 =?utf-8?B?cXV4cnR1UlNlaXdVZ0ZPZjlSYXR1dTRxMVdaMWtjT3BjQkp3NzFmdDBsVnZi?=
 =?utf-8?B?UTNPWDRoL2U0aUYrbG16MGZRRUVYZXpBQVZoajZ1VTJzRE9uVFZiTjdsNUNt?=
 =?utf-8?B?UXV1c3dpL1Z6WDVWQ2J5dkRTTGQ3bFVaU1lEUks2SVQxTC9UMG9TLzRVSEZG?=
 =?utf-8?B?UnBJbEhBcE9VZlQxdWN2aU5QQVlHdWdyTnExUTg4SjNzOG5pUDlrWDNBdXEr?=
 =?utf-8?B?M2hsbS9lQmZsaktIcFBOYmlYLzJNNjYvNzF5bEhVbzVSWDJWSGUvUm5JQlU5?=
 =?utf-8?B?L0NwUXRaRFpndTBzNFY3LzBTTjlYaDVrSG1oRndNaWRPSGgvMFZPaFI4VHVr?=
 =?utf-8?B?aTg5TFZ4cG55ZEZIU05aTzFtdDZOTWxOdmxEZDZaKzBZQjJ3YUVyOUR0RDIy?=
 =?utf-8?B?UUZMUjgrSHI2UlBPSUZqYjF5MmlTVnNJRkYrTUxjeVVBbTBBMGRjOGFlVXZi?=
 =?utf-8?Q?vxgA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a09cbf7-3f7a-48cc-8ba0-08da84563a07
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 15:51:50.4316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MgXmT04uH6mytudEOD7s3LutrjSQ1T33ZVV9WYLCBKD1xpB2JPGnVZIXmEjfNSps9lgimPATFo7WztAce1UIrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3169
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
- Change from v6 to v7
  pcie: endpoint: add endpoint MSI support
  Fine tuning commit message
  Fixed issues, reviewed by Bjorn Helgaas

- Change from v5 to v6
  Fixed build error found by kernel test robot

- Change from v4 to v5
  Fixed dt-binding document
        add msi-cell
        add interrupt max number
	update naming reg-names and power-domain-names.
  Fixed irqchip-Add-IMX-MU-MSI-controller-driver.patch
        rework commit message
        remove some field in struct imx_mu_dcfg
	error handle when link power domain failure.
	add irq_domain_update_bus_token

- Change from v3 to v4
  Fixed dt-binding document according to Krzysztof Kozlowski's feedback
  Fixed irqchip-imx-mu-worked-as-msi-controller according to Marc Zyngier's
        comments.

	There are still two important points, which I am not sure.
	1. clean irq_set_affinity after platform_msi_create_irq_domain.
	   Some function, like platform_msi_write_msg() is static.
	   so I have to set MSI_FLAG_USE_DEF_CHIP_OPS flags, which will
	   set irq_set_affinity to default one.
	2. about comments

	> +	msi_data->msi_domain = platform_msi_create_irq_domain(
	> +				of_node_to_fwnode(msi_data->pdev->dev.of_node),
	> +				&imx_mu_msi_domain_info,
	> +				msi_data->parent);

	"And you don't get an error due to the fact that you use the same
	fwnode for both domains without overriding the domain bus token?"

 	I did not understand yet. 

  Fixed static check warning, reported by Dan Carpenter
	pcie: endpoint: pci-epf-vntb: add endpoint MSI support

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

