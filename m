Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57495B7C7D
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 23:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiIMVK1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 17:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiIMVKZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 17:10:25 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150073.outbound.protection.outlook.com [40.107.15.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E3A72866;
        Tue, 13 Sep 2022 14:10:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPWrsMLStBGylUkekheA4oa2Ca/b0d+11wPzlqDND2f2T3QV2L5vDwtbApvh19ZaF+0yTfc8dz5b974xWkq6EavLqEDGm8Tj+cNBxY3R0bz/vYDpwWNGMyQwfEZuc1/SD8cdg9Aocrpx000bi3w6dqnIEvKM1jBecP+wq7cYgZq/lMhUmXe5uTsBd1LjWUQViSRTepciaivBRjiPQDOarmd3W/7qaBM6YRcML4HI438NFAuSDOpKJdx2ieBFbsqRjU/Eb8PGZQ1tscrAjxV0qAp8RRtNHrewWmkdZWVb9iTR7Uecsrg+6fgtdrnN5aoZo3Kfx6wVKQ/+Dae6XmvD/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJpYy0Gtz1uHbX+DDVq2T49sq2eO9Ep89TrbIu3P0no=;
 b=dCL+XrargncVBb9erl2y+r4j+xhyNsc20l/oWbF8Jvtwz9CsJgKofDUaCpI84anpn4nN/SIrkjK7pHAscuHHaGOx70dc6e2/7/8RVroSSpRQRJKXxQURH9zew46cJDKB0W4XvQcuDJk5nIDGQiyOPX8ylaCeGUoyYYpTW3NJifkZmq9K0yWNoRxbFdxAnlUPjFwH/4HlRp51mlX1cio4+4k3siS6SdJfnhhH1SgcFUl2SvIEGNEXP0QMF9ezRUNHR+mxhhtcw/Mtp1WS4+sK0n1ngmPeHWOggQRSIfMo/cqcMWtFWg0ot0YSQqkNs7HtLjhe66qjxhQpVTJZUJqupA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJpYy0Gtz1uHbX+DDVq2T49sq2eO9Ep89TrbIu3P0no=;
 b=Y0ATuhVf6XT1Ss7Tjx+YGfP7VHUt5iBkN8LOSwva/KSaOJV0DkaS67R769Sc6qjVjUQaydITlMB8+vNj8BqnPw/v8H3Vmw9ncTfCVOIssLiGvcwUSvJlxQO04Z+qS4g2iocFkrgRvZGTMfy+S1X6S9uBnv3E/vZ+eQeMlWxuGv0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by PAXPR04MB8621.eurprd04.prod.outlook.com (2603:10a6:102:218::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 21:10:17 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::e5ca:22d0:52e2:15f5]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::e5ca:22d0:52e2:15f5%3]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 21:10:17 +0000
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
Subject: [PATCH v10 0/4] PCI EP driver support MSI doorbell from host
Date:   Tue, 13 Sep 2022 16:09:51 -0500
Message-Id: <20220913210957.3493826-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::36) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|PAXPR04MB8621:EE_
X-MS-Office365-Filtering-Correlation-Id: d627ee80-1ff9-4dea-08cd-08da95cc5bbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pQoEU3kHJc/Epkpq3n83TNhYXvcF2QoOecS25KGhPTbYpKyNk8Wp6CHTwyJUvVE/bJ1uHGcwLuvwrvzkOhnT+HhitQ5lfKoi4wb6kB+3vjUb1pH+SAwK24jW3zuHMCz2cyX/bGxtz+Ab6zAL4jYj7lvWQeumiYnbD8oCaLeRXWZyMABsl2iAWUpUnI70JaOFOSRO50RRGBxNSwpuNKW1Wyhq97+qtjbvknjlHTG8eQAyrg9PgovmSaFupyeo2hgVokSoCRP17WlXC05wA8LBtO7PiNdR918N3Icod09ajp0r/4YxRYs19SKUvouMBnTBUuWFytCOR+lh4lQzX1OcsL6ZMByFLuq71yuyYxvZW8GVEfFxubaK86jzN1aPnseJ8ai5MylwugOOiOCVkH/u3NUivm5PYNkzogChmu8p25qqHb9jkexo2sdentJxPHAzMA0Syv7OsrwsECPwQAJSoh3y9Rm/ve8YlNWDYPCQlgD3GtXtx2R+64o0LMllh+wKmwWZYtBvpDIsNc1mwMb9NrIa25+QmnvAn+L0ttUkZnbqHyH4MgfHR/ewuvfu79Cmg/SXtk/1Axc5O8vTnQOMveIG0gyKRUZy13XRFTw6EKtHv1jHoee0NIir3ok556LaRCN9wydTLvuFtfj0B12K71QNkDZisZXI+67CHDq+BvbrbcciTcn9k6hHu0tAq1NQPNvqqihSe6BtGjrtIZZBU/6fd4pEIr2w7ZIHigBDeiJBDuOH3+53nZRsHIa/ivWMtwkbPORYaKd7ILLOVNxZIrOFLjceUy2s1qrYIdYsemc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199015)(38100700002)(478600001)(316002)(966005)(83380400001)(36756003)(8676002)(66556008)(2906002)(26005)(52116002)(2616005)(6486002)(66476007)(66946007)(6512007)(86362001)(6506007)(4326008)(41300700001)(7416002)(38350700002)(6666004)(8936002)(5660300002)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFB3VEc5clZEYkMzRzhnZWh0VkFUdGhFUmsvcml2d0YxN0REWGovWjhQeVFN?=
 =?utf-8?B?UmxQM2x4QnBRbE0vVGhsOWdjcmYxRGpuVlFWTzRHMDREZHp4WThzZ292d3JV?=
 =?utf-8?B?OWdrc2tqRWp5cXUvUSs5dTZhSjJ5WTBZTVp2S3NKYjU0enlZU0JEeHJ4OFBT?=
 =?utf-8?B?TTJZTStTbTljemJRbGQxSEVBb3Qvc0l4K3RYdm4xZUZReDNxMWp2WW1yZnRV?=
 =?utf-8?B?OVJhNGt3cTdsL3JkQUprYlBKOVAwcmxQTzh4TjJXR3U1UmcvMGY2RHlBR0RZ?=
 =?utf-8?B?TkVKeVRlQWtvbTA1blFJMGRKYU5URWU5M01kNUd6UmMwNEFlQ3UyU2RiTmxQ?=
 =?utf-8?B?dFVIZ3A4Q2YzeEVyTWlnRFJKa28xK3BsMWtnaVE0dFNHQ3hJekdXT1o1NTFn?=
 =?utf-8?B?RWZXdGx1VmgvdVlUODlUcW1Rc3dOU2dzbDgzc012Q21uc2N4akpTZ1hpMnlD?=
 =?utf-8?B?aTQyRklHd2VhVDlCVkRvVll4NnpCalhCWHJPZHBJUDFDampnNnpWeE5sVjc4?=
 =?utf-8?B?MFVFbXZtOVVSY3FoZ0RhWUFGUkJqejR1WEp5KzQ2d3o5Ni9xOFNiTzdUY3Ft?=
 =?utf-8?B?NzZuaEI1dzFoaWx3N2prUjBoNDNXMzNXakg3S2d1RHkwMVJRbXFnRDQ1Z25Q?=
 =?utf-8?B?SGtHc3hhY2xVOC81RkhaNmdYS1hVa0tBRVh3c0tFU0JOQi9jbVpNeS9RSTcv?=
 =?utf-8?B?NVVoMU1rQTMwQitzYmFnNnRGemVWM3hvM0htSUtvUkVtcjdJWThxTXlBNGVM?=
 =?utf-8?B?ZUdVMGk0MUpxR2VpQ3p3N1dsM0Z5aHVsdDRiL2pDNFRGUitBY2JieEwwaFhV?=
 =?utf-8?B?b3hzdndYVHpzU1VwaGNmMkNFVjFoRk1SWmNGWVl2NWxnZkl6ZFdrNXkzc2Jp?=
 =?utf-8?B?MEFIM2E2VWJSRFNjQVFBUVRldDRiYm9RcXJsaDcwc1pHeCtWZ3pqR2ZKRit1?=
 =?utf-8?B?T3llYnp5TTBPSEFXd0RUMnkrVE0xbHpPSHVPdUo0OFB5Mzd5d0hTOW4zVmxV?=
 =?utf-8?B?N0hUOE1yenpBV0tZNnpkVkVqL0I1Zy9sYnV0OVdLaE94RTc2amZFSFFQejd6?=
 =?utf-8?B?bDFjcXZGY0ErV0xVT3pzcWlqdys4L1c2ODV3dk1LMlJGamtFRGlhMzBHTlpF?=
 =?utf-8?B?SVVHVWFQVHd0dU1wTGpQUkFROUZHZS9ES0owdWt2UkVNQ3hXM0tqNExxbHlD?=
 =?utf-8?B?L0ZTSnJRdmZiMVRCZkVBSUV5Y21odU42cFlxUEZBNXNLNUxhWTl1a3MwVjNM?=
 =?utf-8?B?RGV1akorenRjMUZaVzA4Q0I5KzhTQnA2clE2WHBZT3V6cHdqekhiZ0JVTGNa?=
 =?utf-8?B?VWZ5T3ZocDdCTFYrbzcxN1J2SCsySFRtUzVYdVF5RFNLaU1ZS2txTFhVamRV?=
 =?utf-8?B?bmwrV3d3K2M4UWUvK1N1WmJsakl6bVRnL3duZkZDeVNweDFRdktPdkFHVXdJ?=
 =?utf-8?B?Z0lDVkpDZUJTckxac2UwM0Z6elRQY0RaZVB4cCtuakkwZGpBSTB2VzYyeUNR?=
 =?utf-8?B?dUZBK1VGMHczaVVBakJnK095UVVYbDdPVTUxblc1UkVBNnd4Y3BKSDhEdDJQ?=
 =?utf-8?B?S3VlNTNTSWtYOFQ4alNQdkFubGRaejd1UFR6SGdTbm5YVmFlZGduV25WekNT?=
 =?utf-8?B?RlNsSkFIY0hNOFVJZXcwS08wd1A1NnovWFozZkpHYWhNSDJrZktPS1Y5SjNk?=
 =?utf-8?B?VTdmREs0YUJpS2xaQksrdlljVXBBdUdTa2FwMi9XeXhpL1h3cFgwdTJ2YVhx?=
 =?utf-8?B?MkZQYWRyd3loK0xtRkRYUGFVZzEvM3hqN3pmazlMMmc4OUloVTN3UTFpdGdp?=
 =?utf-8?B?bzRmc3dPOG0vc3o0Tmd2UFRNRURDU2pGYTZEM2RKWDJ4NGNTR05PcmZaSnVl?=
 =?utf-8?B?TUppeXA1Z2N0M0V3TmVLUERLenNyRmYrVXJFdWo1eHZYK01oaVhEYS95M1dN?=
 =?utf-8?B?R254UGFyald1bWxjOVI3K0NFY0VpKzIyQ0IraCtwZE5HRzZ3WkdmNm9GdERa?=
 =?utf-8?B?NGdESGlQS1c0SlBKWjc1eVkyQU9Xb1lsQzYxYkU5RlMyb2YvYklNY1hCYkpa?=
 =?utf-8?B?c25JVzYwQkRWUXZIelZQV1RMRUNkVFg4c2FHYWZscitQdG1JSEJFUmZwRzR2?=
 =?utf-8?Q?sosXobEfDXOWwiEcG2AfuuTNA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d627ee80-1ff9-4dea-08cd-08da95cc5bbf
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 21:10:17.3647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +IqxssjX2nGCDDhymecoVSX5U0B8M/zVTyFdyhtiZA5zd9Sg4ZMqBW9/58u009+3zBZw8KibdUE48HKIUe2Mkg==
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

-- 
2.35.1

