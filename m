Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC115AFAC4
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 05:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiIGDtV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 23:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiIGDtT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 23:49:19 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20058.outbound.protection.outlook.com [40.107.2.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747AF94134;
        Tue,  6 Sep 2022 20:49:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lv+V7WM+axmvhYW1YTqf5ga6dY5QbfgCKZBIb47+VNuGOxQWU+TiFb9CRrKvsa8hStYUQi6jBXtWqLLSZ80rXbXA8LOpdQUL6vIb4rMpeIItK2aW14CCe5S86dQmxdAtTxabxTE2Osle0iEFJf4b/4S4SZ+bMlU6FGWrSlYxqI6Yp+kyFCNHiicUNTorKamZMMFuEt/8JEil4rRhZbhvApRvJyesrCV5AQ8XLPgfPXzzgJ5bzaTY5Hye6XZaz+hQPxWop/Ej4gq2aOvrIHtfnjm+hMX2xDs2RHy79QGfipLsj4wAP+ogf3XvT+WIqrKovOmnwxhECpXyDa1eMfXeQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EboxE/oIDfdpYsVhHzlfpx9ijZ471IzZ7V1h82uuIS0=;
 b=Hboc4LPBCwgMbrT26SLZkrGZ6+roi0pPBUrPjhF9ey9zdokHn3l+PJ0D7siqxUbBrQkOcyw2LrJ+6fnzgcv5aGBb20Lv3ydS+3XXpRURFC3k/bqKQJajtpxQXkfHawz4xIMOKvoRlITYIsvXfCJvd4e7AYc3G7IXaCGvRoFWcxM98kuNYpwE8IcS1J77hUZjmwfUro6+1WHeHUCAI4fW0XJqmBjwW41fRjeBb+Mtu5c4jUoFTFyVLnToc0faXYOmryo9zKCfnJqhYRcyHNjN6n4aifFeSTw5esERy2Ez3rG6w+HyL9M2EgrF2103R+VioxNUqEvEMWN6Ho+1djzw0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EboxE/oIDfdpYsVhHzlfpx9ijZ471IzZ7V1h82uuIS0=;
 b=Y27DuReB635Fas74xw8DvV2zwc1HKaczv9L5Y40rVfCAkfhbeD2avfG+luKEL+UShLGTTlhpaqURpWWiW2ZR/SezgIYFpW0KIX0RMIak7ZPffZIBEzJayc43i8LqZKogK7tNHohhKuehZnt/Ec1OaPVDUSe1lIpIVD6RzlboNZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by AM6PR04MB5382.eurprd04.prod.outlook.com (2603:10a6:20b:96::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 7 Sep
 2022 03:49:15 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::1c3e:36a0:1adc:beb]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::1c3e:36a0:1adc:beb%9]) with mapi id 15.20.5612.012; Wed, 7 Sep 2022
 03:49:15 +0000
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
Subject: [PATCH v9 0/4] PCI EP driver support MSI doorbell from host
Date:   Tue,  6 Sep 2022 22:48:52 -0500
Message-Id: <20220907034856.3101570-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:a03:217::14) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|AM6PR04MB5382:EE_
X-MS-Office365-Filtering-Correlation-Id: ae12c00a-cc44-429e-eb18-08da9083ef46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kaaPJFs+snRVPGN1iDV0bRCUBIQLBzOi2tgK4lw9xT68JVB+VsNy7t3Z8Hbz6Pqpt4gMc0nFzOWlmvY+85gOgnBbmn6Dty6208MYKAGtG4YdOB0KYFFg8GaEszZ7hIzcaF0ggQrdZigrAEpvXLh7lro5lL0HToIch2dUSC1X6bjlhJbZ4U0DpRQ6FvULh0L1mR97UDcP1DVfDW+8vbevABx2P3yGeJrLhTLj6JtuxqR9xWr+s12w6+X9yjGhcRc837DVnSCG7l6DBRuh/oayQTLxCkFzwwsRCukjZIm1Qs6Xw4tWFtDGIZdtydmGK+FGYJNJ4vfJ/yxIWTahtunsg8i288wpacc1tBeNZ4SAbfSSavuyNVMmijHTR70ipYGyzPi1FSMO6QPvhhK1BbvtIXyTZmzsxmiXc3nBT9HYG+kPN4zkpFnElorNG3p6ec81s9X9lwaTQWJdSkYdjQMxNb6moP+tlv27XSybvTVVWmB4lXt9TUlxeA8c3XKmyLyJGHMeY5C1KfYuPQ3FHOTESlXwHBNPYfN/ZfUMDCdyxiLyiZ3btj9l4cnUKTU5MvjoD+cxaJjzlEhyrb0j/setRT2/21s/c8Ig/b80pE3ea5czItJnr85d3NxZYIoAIcO2sFFwIIOiiMCjwEibMmblVpsJyLvK4P5wrZVVYkg2lOObCV6hW4tUIXIz65pDBTBYAiDtWsEJiEbgkzCrIjNdyFtyaRC0grM6rY+ied3NfLd+VUr5Ccl7Kx4KqRXCFiatNFctxd8HlKJzlh4VrIECu+WmIPoSGehpiIwLbL2A+TeT0yY7PvLAawFZihMVHEnukkoIxPah+27fDpIxJ68CeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(6506007)(52116002)(26005)(41300700001)(478600001)(6666004)(966005)(6486002)(83380400001)(2616005)(186003)(1076003)(2906002)(8936002)(7416002)(5660300002)(6512007)(316002)(4326008)(66946007)(66556008)(8676002)(66476007)(38100700002)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkliMWFQbmpITGNwNm5xZmZNeE9WeDJERWZKK25KanNxcWZKNFhQMENRMVll?=
 =?utf-8?B?ZnBBTkhud1M4OEkyREtPcEZ5S0k5SzFsSGo1NWFsMkUrMis1RzgwOG5wOGdo?=
 =?utf-8?B?ZjFLVVFDdTJGai95NFVJdDhyK0J2Q0VER21hdDVTU3pSeWk0aWY4YUpoTUZq?=
 =?utf-8?B?YVFFYlBiajh4Ykt1YS83T253dWhvMW9ETURTd3ppTDRQb3JqT1p3d3ByNU9G?=
 =?utf-8?B?U0RPblB5dGRsTXlYZ0ZGelZya2hISDc5aDBqeE9xbW5GWURWVW1SZUM0ZFp1?=
 =?utf-8?B?OEdnd3owclN4S3drc0Zldk1uVkhuN3o5cUVaWlRKRGZxS0Q0UGxFUWlsTmI5?=
 =?utf-8?B?dTJJSVpMZ2J6ZXZtYzQ5cENzVzZUenJwNkZ3SisvYTQ3QnBPRHhndTZxbEUy?=
 =?utf-8?B?Ui9ieC9GVzJTK1I4WUMrcGhNOUVsUnpjL2djR2hZR2Y5YTR5UDIwdW42bFg5?=
 =?utf-8?B?b2VyeE1TanJoeldPUEJrNm9lVVdSTExYbHF4Q0owdWp5VDZnbW9ValhsYmFN?=
 =?utf-8?B?M01OZ0xCc2k3c3VTVkVONWV6cnBRdUhVa2JqUHh4OFhTbCtWeE9pSHhmcmMz?=
 =?utf-8?B?VVJVYXJUSXJ5Wk5PUm9jY3ViWFpwc2pFUmVTeGJxWURBUkJxa3RNYUdjclhJ?=
 =?utf-8?B?c0RpbVQyS0ZqQ0FkbXg0SUtNZ3B3VThxbWJPUHBZWFUwNi9JRFUycVE1aDJN?=
 =?utf-8?B?d1JUcFVDWVlQRW5JMVRMZzl0Q2ZJRmUzNlVPOU9FVUhGNjZzUzhzbGI4YVgv?=
 =?utf-8?B?cjdLWUErd1B2Q3VWU3dieVRMbGhsMTJuYm9talQ1aTJRM0d0T0d3ZHFTYk9E?=
 =?utf-8?B?QTJadUMrTkVydE84ZS8wZFBjbWhPbjZGYlpDOUNwb1pWNE1xTS9tcGE4NXZL?=
 =?utf-8?B?aDNPT1ZqamNhVEdHR1hwV3ZXYjNUWTlKUkF2R01DeWtVbG5XcHBTbWhIdWdS?=
 =?utf-8?B?ZlZNRFQ0TTlhNnJJK3MyUFpwcndDS29ML09SZUUwQ0FQTGVVYmVvZGNyTDlm?=
 =?utf-8?B?ZmM5YUlCVmltR0pMTGxXdDJHYjQ2RVU2dWZJYjR0WTZ6MkhKdUlDSXdzZDJL?=
 =?utf-8?B?T3J1bTJ5ZkRCeEZrbkxSTktER1h6bzJiM1pMcDgrWHZkM0RMMmk3Q3BLSmQ1?=
 =?utf-8?B?blJMS1ZzK09xc1ZDVEYvNGMyOHJrTGEyQTRpTlp6eWZhc0dqaFpvQnBud2kx?=
 =?utf-8?B?djVsSExSU2Uzb0FKREhmRTRLeGRTTWVLRWlVRzRabDJGaWRsYkVudTU4Si9z?=
 =?utf-8?B?Ymk2SEQvTjlZRktMV29ySkN4RXJXbUFPSXQ3bFE3QmhpZDFrTkp2eVRpVTBY?=
 =?utf-8?B?dHZtUWxuU0taVFZ0S2NtVWlZQit3WE1MaFRSRzdyMTVNWTMyVFlURk9PVUE5?=
 =?utf-8?B?aXRGc1RyL1hXZmtidm1LWERBMTgrN2ZYUmFGckNBaDY4aFo5bEJLd3llMFNr?=
 =?utf-8?B?dkRydldKK29RQTQxQ3JMOXhZaUpML3JETi95WklJRVJJV0RCZ1BuU2MwTm1K?=
 =?utf-8?B?QVdCSEJLZER0S1FxWERZOFg2aUpkeWx5dnFZM294NlNndFVGQnZ0enFWVDRF?=
 =?utf-8?B?VDBUTSswTVl4WElaV2Rod0MrL1VqUGlHWHBrL3RjT0todmsrTnZDRXZLVUg5?=
 =?utf-8?B?bzJZclN3WDhzQ3UxQWpqVVcyQUdQMVJlazBFTmd3TTQ5WFN0NXUwRTZIQXhK?=
 =?utf-8?B?NGNqUWJtMVdRR1JzMmhLamJ1UkFERSttRDdLODNONzVoM3k2cUUzUHptakJI?=
 =?utf-8?B?OFQxU2JOaFFHZFA2V1J2Nk01K1M5UTA2NkxzVjg2akFWcmplcnl3aUdpbkc5?=
 =?utf-8?B?NnJIKytobjBoZ1RucFI5VWtCVXJDNG54ZEZzbGlBbURVRVFxd0ZVYXlWdEE4?=
 =?utf-8?B?bmxQK3IwWHFvNFA1U0ROb2JLOWlPUUpHRWNKaEpoTk55MWpOMXc4aDVTMEtv?=
 =?utf-8?B?VEpZcnE1UDE0QjRaVVNDeWJiTGE5SHkwVktvVFphdCtrVFJtdlRNOHBma013?=
 =?utf-8?B?MVNpa0k4d2dpQUJWbVBFc1FRZUtqUEtNdTU5UmhzMHhkQlBPUnd0ZFpvTHJ0?=
 =?utf-8?B?UFpmSHNHNm9td2hRYTBOVFo0YVdxbDdFNWU5am16eHZhd0c2UHFuenRXMDRh?=
 =?utf-8?Q?josU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae12c00a-cc44-429e-eb18-08da9083ef46
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 03:49:15.7874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/xVwIf3DDM1cc65rgy8Xc+mWMFp/4eTaObTASTMaDksaiVjPfWfghuW01+gb1iAHuyOifMiTFZJrnjdtH0XUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5382
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
- Change from v8 to v9
  fix dt_bind_check error

- Change from v7 to v8
  irqchip: using name process-a-side as resource bind name
  pcie: endpoint:
     - fix build error reported by kernel test robot <lkp@intel.com>
     - rename epf_db_phy to epf_db_phys
     - rework error message
     - rework commit message
     - change ntb to vtb at apply irq.
     - kept name msi_virqbase because it is msi irq base number,
	not base address. 
		
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

