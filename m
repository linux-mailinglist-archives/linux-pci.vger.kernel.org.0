Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1595BD13A
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 17:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiISPlG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 11:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiISPlE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 11:41:04 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60056.outbound.protection.outlook.com [40.107.6.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F5D32D8A;
        Mon, 19 Sep 2022 08:41:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDYUnBbfDAiiBRNU9qgr6ujhxKOtG76fIN2AFRdoPVaHYu1H1+QuS5nbveltodCnlgUuwv+C6c8x25fV+3UrTqoZAUT/mWfnueTtMTJJVnHiN5Xx05lMiWWGlO07oFJ2qke0Ue3HYiAOSgcCey2XM33VBeZ0D52j+CU7373iL7n0gvRiwk3429BgF4H9fkTN+940IUsdtt+DKIyojrVx4ntJbPlz+HfSJ20Fnc14SlqX/51jU7yvHndS/qgmHeyauZ3QKtVxkGvzqK/awQh7FGZzIwbkbAlZqqzFR+f6VGDpmL/oR9YiW575jl3mPwgk3N27bNynNBt+GTh61eAdEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDD2m4WaQLJ5X3cdlq5/ReU71Ft6dOt4Wh+UdBg4azQ=;
 b=kNxmYVRYdic3VD8SC+jfyu9VYwyasVlVMstd26OFOOGpC3T+o0oihFulhqHEXpwjOo6a19ky0piZ4w1KZKfxLKHawGOLzLugIZQkK5LUVyvBwOh0XqsyElUc5dAc1sRUYASR3BdtJTRpqtXcrZuloGW2LhI92OcjBqF0z7WCPXeZdzvNgEfFqJOr1PyFZfVDalp3uSVscPjPauIIK3ySZve6+Nvm9P+EwRS865Lnn47MhKlfQ/tFWr9m1+LgSn8+YrGJevysFa3JcazKSnVmbakfVHwPgnUlc5w1jDwqy8+NKTf3T6+fcu/RusFZAa0nsank7pEQ81FSJW51U60ABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDD2m4WaQLJ5X3cdlq5/ReU71Ft6dOt4Wh+UdBg4azQ=;
 b=Ez6SkKaeVphOaYsB2Uwr7cyTdJUWGHdnjvc31soIE8SHP3VcZt6wbUxFVECEZ/HyviLA9Dxk6kR9cVw8uP6XGXsxeU/Fh+3e2OGn3ep5lEuxznCpwT4HqZxHr3/xqLKJciiCnTMsVJqKcYfWLNyU9aApFclP9TG0C6YyJiBGzXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by AM0PR04MB6945.eurprd04.prod.outlook.com (2603:10a6:208:17f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 15:41:00 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::5a3:ff70:317d:a99e]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::5a3:ff70:317d:a99e%7]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 15:41:00 +0000
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
Subject: [PATCH v11 0/6] PCI EP driver support MSI doorbell from host
Date:   Mon, 19 Sep 2022 10:40:32 -0500
Message-Id: <20220919154038.187168-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::34) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|AM0PR04MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a7f91b6-d0d7-47d7-1e34-08da9a555a2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7q1oodgSvxVWe0W1TUJ0I/ROwWLrrdL3Zl6W5uwZSEeoXt+bAWGleBKdZN+LMLYZ8iKv8bLHOabWU4RzaZjlOtXdf8V18vtwOpkSI0/Tojtb0zMJS6BZ6muQEhwVCG3Jmf3Clf+0uO9Z6h4coCvYNefK4w4M14b5Jkpegv1sfrsdetfnsDfuzutByGUegJ6N3e5fU/idzO1uLmHblvpwup2pEtkNjJRWIuiMjXe7IFgMw5mlgZ2oy1vQLk6ZDca3B6KYEi+xtqQV8pWj09S9z3mkk0DkH52bjmAutZIPFDazd5wOq1efKgPzDfNGOErxnZ0hCvq7Amju87Ux51s/84n5xfTrh3H6PhvPtC4Bkmiqy6Y2xX/MHt8BRAKnrEud+Y1Kkl76nI3/hKhBmLa+m+5rCghHb/XU8mLkNto3TY1sfmcM2vEMv0EaDsdTXwdfjS1rCUFxBhR23opijiI9lLLL5Cyy2aW2KsRYnwr1Do8nfLWKabyoAU7PXxPKC644VY3sVzadsvDrl1zCFZ0KxgyYheWv4QNfnzCnYxagof/F/ayQ+CMON+POT5RGRMlM3ThlwYsIntrJMVd8op32A+BdGeq7vi3gkAWB0ItJb0xhdzKjyYDue34RSxcdbCX2I7ULAvW1kupS7mVDySDUXPzQezzST7+SJDRXm0T2Y5fa2xXVaS0nIW96zB7OgCNH6bUL++2w14E82zt5K0b6TM/3C64oVh1Kc6B6+n4ThE+AujRwi6TZAcQip2LkMIpdzzIVTCKjOTxMrZtJpzg4QwQTYXzzTgBpQ8JAY5vOfw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199015)(66476007)(36756003)(66556008)(1076003)(2616005)(2906002)(66946007)(38350700002)(38100700002)(4326008)(83380400001)(8936002)(186003)(41300700001)(6666004)(966005)(478600001)(8676002)(6512007)(86362001)(26005)(316002)(6506007)(52116002)(5660300002)(6486002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUNzUGV6bytjS1FVWEd2MGhrSjh4cDBQSmZwaFNCSUp2MkwvREgzZnhDV2pz?=
 =?utf-8?B?RDVBZ2UvbDJZTkdlQVhycGNWQTZJRzd6U3ZHTndvSFVnL0pxWDNYM3hLbU16?=
 =?utf-8?B?RzBOZWNMbyt4OVh3YVVNVStsRWNzbmF1UUQ0QjZhMStMUFVaTzkzSjFqK0Yw?=
 =?utf-8?B?aldyVGs4Z1N2aURoblg3WTlYL25kSVdOekpWR0N2QklPaDRpaXlrSzhGVU9Y?=
 =?utf-8?B?bkNPLzNUWHlsdjR1a0lYZEFOWWE5cFRvUmkvb3lVczZTa3ErcVpZdEE3Q3hN?=
 =?utf-8?B?K0VkNFRIY1JrMXBMeUhMZXZZY0JIazRiOHNCOTdwUlhhTHhmV3dtTVFNanJv?=
 =?utf-8?B?MVQxcDRYQmZHVTZXZ3FCWHBvQXlwRVBaUTk3Wkk3c2pmUE4xeHVXbXBwMXRy?=
 =?utf-8?B?UzhEMUp0bW5CMXpiQXdEZzRqTk5VV2lCSHRpaW9lWmk5aWNmUWRDMmdZalRT?=
 =?utf-8?B?N1pabzBaMmZWWTE4STR5eUJQMDNEQ1Fqc2tkdGorMmo5VmlQbU5nSzNjQzlI?=
 =?utf-8?B?UnlBWW5xWE93MUR4NnFrUzJkUEU4VS9WN04vWTdoSnRsbEl3QVJlUHYwU1ds?=
 =?utf-8?B?cGpSc01HYW90Lzc5ODRUZEZ6cGlHRXNlYXBKcXJ4VHBZYmJ5SDBQdXJGNzh2?=
 =?utf-8?B?cURiRFBLVDVXbW5xRU92SUZhTzhacFlOMTdJUWpvN1J2NEk4azk5dGRwOC96?=
 =?utf-8?B?Q1BFTXZsUEZySlExcFExR21UZUN6WGx6SlVyank3b1V1SnNVeHdFWGFURWM5?=
 =?utf-8?B?d3dXRUl0cUlBcy9QczV3cWtJa0syNENySjdMU3c1d3JjUHQ2YzF6S0V1bTNi?=
 =?utf-8?B?TG1xbWFpY09MdFFRWE04L29vcFFtNWhadVl2dWpudFMyS3R3d1ljRGtsUzlE?=
 =?utf-8?B?L3Jydit4djB0MUtLM2ZwdDcvcGRybFFTc2pXZTBydEpITHlPT3ZmWS9LWEpV?=
 =?utf-8?B?MzVZcS85d2xkaVdqZ2VFR1M5ZXYrSHVydkNMMlcrdmZEQmJWRjNGOUpzaHI3?=
 =?utf-8?B?TnhhM1BncVM3V2VCMTk1Z0ZvRVVvMW0zVlBJYXJNdkluSEk4Z2VqektiekFN?=
 =?utf-8?B?K0tHTmZTWFA2MC91VjYwdEE0WW1TNjlCL05OVE4xTmtzVDB0ODdIMFN6NEZU?=
 =?utf-8?B?bzVGTlNjYmc3Ni85S1VicE5JZ0pVRFFpbkNOTVlMZjJBWDF3TlJYMHoxTTNz?=
 =?utf-8?B?WFR2YzJmekl3RTg1QW1rWU5JQ1ZjTU1IdjRXY0J6dnNWTkVxSE1mZWV1MC9X?=
 =?utf-8?B?YVhnNDlFWGdEL3BoRlBHT1I1T3RtbWJINThacm9NYktaVnAxVUhnQ3BwYkxi?=
 =?utf-8?B?aDFPWW9Dbjdld0I5UFViRG9aaXBlWmNvQjRHR3Zhb0U4aFFjWExyejdpMUNB?=
 =?utf-8?B?U2FVYW1YRi93bE1PVGRwRVdQdkRpS3kzL0F5cnFNbVhDZFI3blpvOGJDR0dB?=
 =?utf-8?B?eVlNYktkY3cyaWw1TnlmT1J3TEJ2VVRKcm9nbDRMN3oxdUgvamtGSmtuVlpM?=
 =?utf-8?B?YXVZZm5zSUdqUHAzQ0xEbXZGdlZER0lOYUZNcnMxUXVZTHlMV1k4KysyZkh5?=
 =?utf-8?B?cS9IK0hrREdDM3N4Smpya3RTK0pmSVdFdUVvUmJTR3NCbVU2ak4yYUlreHJW?=
 =?utf-8?B?WWJrSlZDZVlsbjZJbFpBREFhMHlIL3NtOWZpSWY5bUR4ZzNFWkR5ZnRQeVl6?=
 =?utf-8?B?RnY0eUZYZWpXdVdsTms5S2YxUEQ5RDRZMWtOR2tlOFNmaGVNSEhIL3lzc01o?=
 =?utf-8?B?TG5BaktieTJVbXYxK1NGbStHaUtOVDBmMlpRWXlHbDhNUFhwYnk5cE9zY0s4?=
 =?utf-8?B?bkRsM2JnNG5ha0ZGbzB4TXd4dk5oL043MkZyVnZOMWg0MGkxOVVvWWVGQjU1?=
 =?utf-8?B?M2tGSHVkRkpOalprWWhCMG1aKzJtaDlEdWNQKy9zb2tMZDZoeHQ3M3p2V2Zy?=
 =?utf-8?B?eHd5eHZxSWMwdHhONlhsem1NU2E4VVNvT2YweUJMYnI3QlFVN3ExaWtqd3c1?=
 =?utf-8?B?Sk41MlQ3TThKbENiNUVQSVdUR1VYY1FkTkg5b3VzVEFwYitsWkZBMmtJYVZB?=
 =?utf-8?B?QlY5V3prSjJqeTYrMEV6aGRua2tjcWFwZlQySDZqdTZicHRBK3dvNHBoYjJU?=
 =?utf-8?Q?xspO86x0f3DGrVVAhWNGj05zH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7f91b6-d0d7-47d7-1e34-08da9a555a2d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 15:41:00.4806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbWkBNh0B4YqUjlVzUUi2bGKYCjT+ePdx1phWAM19UdTpR6ZFa69980T9Md/MpILk5nWETYBF7w61JoN5OtrHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6945
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

