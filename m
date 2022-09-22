Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E795E6877
	for <lists+linux-pci@lfdr.de>; Thu, 22 Sep 2022 18:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiIVQcg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Sep 2022 12:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiIVQcb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2022 12:32:31 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B22FD8E1C;
        Thu, 22 Sep 2022 09:32:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aw5ZyuNTIfnbq8fPWEbnaEDkOr4tdt09SuqKa2pkI3CRppKYOWo16DzMf54HiW0v4yRYcSutjaT8SYuJY2SwCpdBFH0x2MYheVC3yNFqVPrtXWIOqfna8N2yC99f8y59arznpZ3Wc+UNgNAx6EFPJrWX0uI2FR0UGOTksmgwrWZWhpaMhONwW5DJFvV+YKV1kmMeeo3lEs/ij+xh0DXJjveWhWWsChwgTODkIUxZpmJWjoO87cYmcwZ49ow2V6clo9j0EVwZl1clD4CdTBWI1BMQRBB1mhUW5hm3WYgtB2LfDwQTZXeJhfhPFcG3YPyS3xyj4EGRkEij1ZpTMufdZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NeQ4vWTr+ec0pde1tg/gz0iPJVOdyjtridip3uYcEGo=;
 b=FXSWbNL1oXR1262p6shrCFdTequQXE1Vs3xrRI/4RJNQa4d8QUQg+Ocsfk1TJMH+tPgN4GS02i4aYI1nWSpBF1G+UetyPhv53aBpMOfSDJGUhgZTiBOWvV2E52fLQYXPcwqaDQr80dBQzLDlwQjnpbZZutUe4/NWVjX0jP1sMWVcnZpVAoguCCk/oP359EXZN+GHfttPk2JfdGHwkp3njP++2DZc6SaKhFJgi9hy3mzZpv/PVUnZWkNG/+LEcjGtoHGW551TUjETeydHuqNsNdDKtqveH1Vx+99uxKwVLBcWoQ0dAcNLWFOQ123RshtnxtckF+4YW0xLhg1Wca09aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NeQ4vWTr+ec0pde1tg/gz0iPJVOdyjtridip3uYcEGo=;
 b=J6F3zQ770jX5EkeqMd0E6O+abghElQ7x4+Kb0fP4doaGDUGWjsMt+crPjg9wJMrzvZNEDbdjpJcMiBbp4eMnntGu6gyg06ivHDhUhdy/cpslMUWZ/lNVuz39M8K25WMvIRo3a4qTNGq3W7RlsAGl2t85pUYGCqtzyuRCMaDvtCg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8789.eurprd04.prod.outlook.com (2603:10a6:10:2e0::11)
 by VI1PR04MB7119.eurprd04.prod.outlook.com (2603:10a6:800:12e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 16:32:26 +0000
Received: from DU2PR04MB8789.eurprd04.prod.outlook.com
 ([fe80::5c5d:d0e4:cd13:6428]) by DU2PR04MB8789.eurprd04.prod.outlook.com
 ([fe80::5c5d:d0e4:cd13:6428%5]) with mapi id 15.20.5654.018; Thu, 22 Sep 2022
 16:32:26 +0000
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
Subject: [PATCH v12 0/6] PCI EP driver support MSI doorbell from host
Date:   Thu, 22 Sep 2022 11:32:06 -0500
Message-Id: <20220922163206.21281-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220919154038.187168-1-Frank.Li@nxp.comv>
References: <20220919154038.187168-1-Frank.Li@nxp.comv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:a03:333::7) To DU2PR04MB8789.eurprd04.prod.outlook.com
 (2603:10a6:10:2e0::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8789:EE_|VI1PR04MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: 09814fd7-67ff-49b8-0ec5-08da9cb808a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZGRY/q15Rpvs50hTtJHs7RiacrE8tdkGHKH0MUKWwuJ+gqJAcoF9ALIOKGqy6Y89Wq287cJIVOOKvAZcPMlG17fawh/rSCqXH5Mu3mlg8jUdHlQtE8XDhi8K/GewCjvWePedydX7PAw48r075iXhSyxdQZHRTgbd6XBaZIs9EmoeexoEzMRnxB8zXQYciv7Rai+gS3ukYBJ9mJmf9af8W7ivEDndMu+su4/WGUdec5dd1Tc+qxl7UH7AFBvNVhayL/POxKCmQhBpIu90iz9/v24s1MzqLAXxIqvolJRaokv51X/Bll+vGyae6RlmkrMWM/p9AMvAMWo4DW6LcWVIXUYnGEtaMVRFIxH7AiBlqiHp4D78nyPCzebj7Rp+Ez+CPIiSINYG7BzOnBOiYOsevWwdpbj5vSIppIicUuXkgSeOMrY4DfjbeoGe6A5rqoqlJQ5c0T757qslVBcpKOjdiW8plAComNe9GA6hXxy650/wZUC8zPLqp/zMHv9J3YCCS52ofeyIJHNzKILdzufK+0UJQGVxp+TWFPgM8SMYIZ/wPTKyGwYpR85r1MoW47Yc5/o8ysgoykO51PEo78BOmvkRMBRUvWnZnchycWz8N4WrXMcbqwYorjNszZWNUeVdMfsEY/Su6zirPCbgdNGBBiAAJnRnktM7NW6Q0xrErmi1QW/zcQGROFtQqUVrIFFQb7yv0yVbyrc4YLiN6gSg4eT4bb90tBQx9454VX8XC1CA+fMVeAFzuuFABC6fqcBFmqJEFTy74rQDgySKUxDPzDT3fEI3oaDh0k3nGSX4/L0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8789.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199015)(83380400001)(4326008)(36756003)(66946007)(66476007)(38100700002)(38350700002)(86362001)(5660300002)(7416002)(66556008)(2906002)(8936002)(966005)(41300700001)(478600001)(6486002)(2616005)(186003)(8676002)(1076003)(52116002)(6666004)(6506007)(26005)(6512007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm9nY2EwTWw0eU03VWYraFozTlpwQjNHWHpzTm1jSWtNMUFkNFZ5M3BJVHlI?=
 =?utf-8?B?ZnhjQWtFYy9NY0tROUFhWEJYRHdvWjBJUzIzWE1sSXhabkZCNVFtMS9jSWc1?=
 =?utf-8?B?d1N2M1ZwTlBXT29KSEVNOS83OVlZM1BJbi9ZcHdDcEZJeHlkQjI4KzFwMStN?=
 =?utf-8?B?RzJiQVVkSUwxTHVobFJYblNXODA5dGhHWitjR3NvcFIxUjd1cWpZbkFHTS8v?=
 =?utf-8?B?ZG51dmlYUTV3YXo1R1d5b040M1hDMnBnZGZ4N2N0aFU2aDF4YWxUbThiKzVa?=
 =?utf-8?B?RE9tQkVYcEU1S0l4dEUxOGw5L2VabUZjYmhEc0R2Nk1Ea0hOTDNRVnY4K3ky?=
 =?utf-8?B?NzlpYzFabDZ4VDBqUnhoNzUrL1BNLzBNOWVZQ2dnMGFqOUUxYmsvU3gwd0ZY?=
 =?utf-8?B?dUJzSXdBSWx4bjNONFpSNVdkQnBRUmVpYVkxblhuS1JSMHFhQlRTNzVzR3ZO?=
 =?utf-8?B?RTRiY0lucFFINVZ3WGJPUXMrSStiVi82V2UzTC9vOVBKTUVsUDFDYXFjK1Q0?=
 =?utf-8?B?VjQzVW1Pd285TjlOeUxCZmFJelRlbTRNbnJBamtMd3dYYUo4VFlPSk91dnFY?=
 =?utf-8?B?cmdPZjUvblpEZWw3ZXVNZzFaYjFJbkQ0cDZOVVR5TlhkL3BrL1A0eXJyWHVv?=
 =?utf-8?B?N3NLaW1YUGRpQ09sYU95QXorV2xJNHMrajBRMmtOVjNSSXRSQUhMWFNRbjE2?=
 =?utf-8?B?ZTJxdkgzWmdQOFR3YnFMa0E0ck5wdHZWeVRjT2dROGx4bFB4UWtwcFlVUDFT?=
 =?utf-8?B?TVgwak9XVkhDazZybzlKNytROVFKVEZSRUxtQzVoSTZ1QXIrMktaK1pJeW42?=
 =?utf-8?B?MU5BSTBhSHlHUGRtR0t3RnpDSUhMR1J0Wld6K3ZhaGxEcDg0ZHE5NlR5WFB2?=
 =?utf-8?B?RTMrQ09hTHROaHpiZUFrVW43L2hlWHBuY1Q4MXNRb1Z2TFEwRGRBK01peTNQ?=
 =?utf-8?B?UWpic3RxclNWQU9GQTZJU2pIUGhHU3daV3o5ODZoMnJ2MzVzL3ZrK2RiOWpp?=
 =?utf-8?B?ZzNwbVZGK01MczlobmxMNnJ5Zjk4Rzl4ZmFCcXVSUHBCMFNGSnB5ZnBPTGxH?=
 =?utf-8?B?YUJBVHBPN09BRTZac0RPNWNSUzlhZkhoUkhBT3JYNHRDSmhxTTZSaVNkUnZr?=
 =?utf-8?B?cDRiVVBNcVErc3VicjVzakRoNy82Y294cGZERy84bDB3U1FtYjB0T2Q3T25G?=
 =?utf-8?B?TElpLzkyYktCQmduVkFFSENuMko2VXNzZUdtdnN0VXV2cTRzL0I2NXdEaTJC?=
 =?utf-8?B?czV5KzF1TXFwVXJaS0hIRmNBWUhrSTVFeTBucVZMSmNudlprTmRpWjV2QWdq?=
 =?utf-8?B?Yk5uWWg3Q1BneGxxZXBzTGl0TUxnckdWMXY0TitnaTdrckxOVjNmWWh6ZndU?=
 =?utf-8?B?V0ZHUnd6N1FlOU1ZVHRPNGc5SXJGS0NhSDNoNnpRdDZDblhMdm93N1pFMnc3?=
 =?utf-8?B?YVlDM0ZJMVcvd1MrVjNiK0xyT2k5cXZpeWxQL1dnY01SNUxzWnJqTGtHUFVq?=
 =?utf-8?B?UXhSVWE2Tk9yemZUSUpZMnN1M052bkQvQ1VUdmJXbXp4WXlhdTl1MzdhOHll?=
 =?utf-8?B?SkhhdnJ5aTM3UGJ5ZnZPNEhmbkNJT0xGVHl6WW5BWWhOSllNSDFieCtia3J3?=
 =?utf-8?B?ZTlFdTRFQnFoRVlIVGpjZ2NHeVhubVpBZU14SUlIcFQxQ3hZTnpBejg1S3N2?=
 =?utf-8?B?Z3h0bWpPakJ5R3BrK3ZpbkFEQVdGOUpFb05sK1NoWmIrYkZEQ2JBM1VYQXNj?=
 =?utf-8?B?MUNXRGFNWlFtakQvSzBkcVdPVlY0MnByMGZ0NUdOQ0hySWR5MHV2b000U0pI?=
 =?utf-8?B?RVVXeUFVWWg1WnllM1VKcXFPOEF1cjFTV0N0amFLVEtXWE14eVZ1amlIdDRp?=
 =?utf-8?B?by9waHVqbWlPNFg4S1dlR0ZPWWUrYVI0aWEyN1FRS1BoMkFWcUVRNDhuTWVz?=
 =?utf-8?B?K29tckJRUEI5YVlIZGlwUi90bW1zTE9uNC9LZTlrcVE2Y3NYV2Mra0ZUVEFZ?=
 =?utf-8?B?akh3VHowY04weFdKNVowKzBqSm0vaFNMTVk5VytML056a09CYlV0T1k1Z2Za?=
 =?utf-8?B?S2VDWlFuWDhGZVdMQzJWRkIra1FDRzhTZ3c3TmdBYUozczVQTlNzNzNlMDJ2?=
 =?utf-8?Q?kgt4S++L0/HuXZ9YDnKhF6Moc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09814fd7-67ff-49b8-0ec5-08da9cb808a3
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8789.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 16:32:26.2134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OAbxZTDhvDTt7y1xhSko9APLD2NOwEWCbFvEnUt5O+pNmQ6Xrz8bQ58DLAfh5HgoskUqfvgzy0sCR4osi6dvNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7119
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sorry, forget update version number and resent new cover letter

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

But Linux also supports endpoint functions.  PCI Host write BAR<n> space
like write to memory. The EP side can't know memory changed by the Host
driver. 

PCI Spec has not defined a standard method to do that.  Only define
MSI(x) to let EP notified RC status change. 

The basic idea is to trigger an IRQ when PCI RC writes to a memory
address. That's what MSI controller provided.  EP drivers just need to
request a platform MSI interrupt, struct MSI_msg *msg will pass down a
memory address and data.  EP driver will map such memory address to
one of PCI BAR<n>.  Host just writes such an address to trigger EP side
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
	 
mu-msi patches (1-4) and vntb patch(5-6) is totally independently.
These can be applied by irqchip and pci's maintainer seperatedly.

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
- Change from v11 to v12
  pcie: 
	fix typo in commit message
	change subject in commit message
- Change from v10 to v11
  irqchips: no change
  pcie:
	clean up build warning foundby kernel test robot
	clean up kernel-doc warning.
	clean up vhost VHost.
- Change from v9 to v10
  fixed build error reported by kernel test robot <lkp@intel.com>
  irqchips:
	fixed accoring to Marc Zyngier's comments
	Added new patch platform-msi: export symbol
 platform_msi_create_irq_domain()
	Using one lock for both reg and alloc msi irq
	Using predefined macro to init cfg data
   pcie: endpoint:
	fixed according to Manivannan Sadhasivam's feedback
	Added makeup patch before enable msi irq
		PCI: endpoint: makeup pci-epf-vntb.c

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

Frank Li (6):
  platform-msi: export symbol platform_msi_create_irq_domain()
  irqchip: allow pass down .pm field at IRQCHIP_PLATFORM_DRIVER_END
  irqchip: Add IMX MU MSI controller driver
  dt-bindings: irqchip: imx mu work as msi controller
  PCI: endpoint: cleanup pci-epf-vntb.c
  PCI: endpoint: Add vNTB MSI support

 .../interrupt-controller/fsl,mu-msi.yaml      |  99 ++++
 drivers/base/platform-msi.c                   |   1 +
 drivers/irqchip/Kconfig                       |  14 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-imx-mu-msi.c              | 455 ++++++++++++++++++
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 296 ++++++++----
 include/linux/irqchip.h                       |   4 +-
 7 files changed, 786 insertions(+), 84 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
 create mode 100644 drivers/irqchip/irq-imx-mu-msi.c

-- 
2.35.1

