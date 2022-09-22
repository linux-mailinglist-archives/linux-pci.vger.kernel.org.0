Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3526B5E681E
	for <lists+linux-pci@lfdr.de>; Thu, 22 Sep 2022 18:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiIVQNd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Sep 2022 12:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiIVQNc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2022 12:13:32 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70058.outbound.protection.outlook.com [40.107.7.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC78471BC6;
        Thu, 22 Sep 2022 09:13:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWRjF7lFzZi3te9aSGuLNbfmtvc47VaK5iM2pTQhtdap2wdjZS9YT5j968wUNSS2yNXwOOuBlBE5n11he+oycD8vp9TchhmsU/zo57dJ844msMwXjkWK7PMQcFB3o1XyKk6P6yCfU3BZ+CIFye5GjnV6EW5raQmZ/jKrJUXhQ+eCOUCzfDFgGETeVz06GNCbZwJC/q/gsQzVdFcdrbargn7YOQ4PapjltPtwfapgDsLA5aRvq/nC2pjyv0+RHiG6vfPwe9UfpRfEzYsIMWiA6IPJAEHMUjvxjvDMm1Ik4zGcMWRVdROVXo6Khs1WhmimslJ0+s/dcSLFd6zGqmrmTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axRcNETS7XrMd/JCdyThx0jdtDR3biWRkVHFW431zF8=;
 b=QF1tB57esKo4AyIy477s0t17QrkWGVctmh6ChWC8zR6WDhG0jR1jkRqm955Eszr4JQrxq9Ruf1PUN1FdOSA4V7KDAs9k4S1tZ9EkjVzM+FzlXBJlxnTLZOgXCqBLCGfRc7YASoAyDqFiZuUtVl2XwLWp5oglCbAfjDUjBl0qvAbEmgmB8Kzj7/2soSN+ZOv+/K8GB6Tilv9bodzylds2FFHgufRDDSx0QH2iUd/RMKHG3Bv9s8gSL7ceBYFmndbDa8Xe+sPwaHJG2wfgBb2UBdKx52CJnltnxVbXyFCI/ckUULr7pBKChbwIKAV3KlH3EpZBZ7I8uEiVrss4QlItSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axRcNETS7XrMd/JCdyThx0jdtDR3biWRkVHFW431zF8=;
 b=B6C2t3s7RDQ5Nrsp+HQacUaxFEAdX/Zpr/kS94g06Zg+AIaBHe6GigzGrbBDZriVKU9VtSlvHmnoVH03oapFWmRhppY4HXrGMPqPYaPCbAuScX9oNYQGvKuJnggyeFTfRuy/LlI2lhMu5bkz6tAUh3U8ttd1DALeCWTdbIrLaoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8789.eurprd04.prod.outlook.com (2603:10a6:10:2e0::11)
 by AS8PR04MB7541.eurprd04.prod.outlook.com (2603:10a6:20b:29a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 16:13:25 +0000
Received: from DU2PR04MB8789.eurprd04.prod.outlook.com
 ([fe80::5c5d:d0e4:cd13:6428]) by DU2PR04MB8789.eurprd04.prod.outlook.com
 ([fe80::5c5d:d0e4:cd13:6428%5]) with mapi id 15.20.5654.018; Thu, 22 Sep 2022
 16:13:25 +0000
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
Date:   Thu, 22 Sep 2022 11:12:40 -0500
Message-Id: <20220922161246.20586-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:254::21) To DU2PR04MB8789.eurprd04.prod.outlook.com
 (2603:10a6:10:2e0::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8789:EE_|AS8PR04MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: c543f1ff-8500-4819-57c3-08da9cb560f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w7M2Xpk6SmDDS5ICrhMd+J9f+7krWL2+b8YZV1ZiJhGgpxXUqM3JX5jXp3AccoBMWbaSZuxq612UNBqUJckLfJuqyyiPxOnUhwqmoCn+NsKqoYHFTBHcWgeMWaNTAbBekgLva3N5tNAM1S7unLlygu4Ajl1tvmF80VbrbtL627exGWNC1MTN3OBzVziGu5Fk3Cf8GxBRYtJwWppF3/kuvMphcDLGCN1f82XQkev+PKyG4CEH3sY20zh6G+RGlMm1he6ZbxQuNYirKCCpalbnWhVhi5TF0whJnoZOyPDyLR86aoTMB/035/vDYJoO6sFpm1avbtn8wDr430fmnzLGiZ98IUySPQ75Slj8oEuU2WQKDwuXPBPQr+eUs5U8J41yrR1ccgsF22jljGyBuHxGjFCd4H9tCn7Vtp2w9faCtr19QdUq6m5BclA1DOVijyC3JviPt87wSRjwTUVkKMHvDr6Tl24ak6xXSkUsoO/ioqq4pj0oFu7ddXcNDbr8bml1Tvqrif9sTeKW7Hm6OZBQY7jsQvr8gZ2vdC5m0+x+xZAW+y6ui4xW5kesrho99aCmsu0o1bjI6Fb88Q/O3hZuIIq41foBe4Ji0EMolwD/fHuhz42mY/BDzEFXPUPefhvDZll2z+oiyTVK+CLyXR9f9Jfd253PAto2DQMhnNgs8VrDUAGQJO1PnMHimHeGGtnN8EdiX0qXw3HDP9VOy3hHB8BRx5XuQI67AXJQuFjSN0YJIyAlC4Wodll+L1wP8c1PJFi0ipbEMEKHtu09rLsMnfGBpxR5nyMBtrtkrHkn6hw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8789.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199015)(83380400001)(1076003)(2616005)(6512007)(186003)(38100700002)(52116002)(66556008)(38350700002)(66476007)(8936002)(5660300002)(41300700001)(478600001)(2906002)(6506007)(966005)(6486002)(26005)(7416002)(6666004)(66946007)(4326008)(8676002)(36756003)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUNQWGFpQnRobHVrY3lidDVxUzMrdkg1OWtaYTd3TWl2L1lZQmg0SWxYcGRx?=
 =?utf-8?B?Y09hWGQ2Q003RVNCUDA2UHhGU0EzazJScWJUcmNFbFZKSmY4alJzRmI2RExE?=
 =?utf-8?B?TG1xZ0I0L0VXZnp1cVhYbnc1TXBQU0wxK1BqVVYyMkcxUysrcjlGSWJOMFl6?=
 =?utf-8?B?ZGpWam5uWkxhTGVEM1g0S0hET1ZmUFlQMjdIY2RNQnU0MkZBckR5aXMrWTNW?=
 =?utf-8?B?S25QeWNVbVpXdnNVQU1NWjZpOVlMMlJOUnkrWXNUU2RFaUM5VnFZRnZ4MkRp?=
 =?utf-8?B?ODl4a1E1UkpZVk8rWGliWGNDWG1Vc0w4WEg3eTZTOERSUXJwdDVnTHB1bDZD?=
 =?utf-8?B?SmFpNFErS2d6bytyTFVNclYyWXRYMGFKMW43Z2theHoxZUhpaU40U05yWDN2?=
 =?utf-8?B?OU1FZ3I2ZmtXbGI0TFUybjBOVUN3dldabXo1Snh0OXNHR1FmRkJuU0hoNHM2?=
 =?utf-8?B?UEVUV042cGtFVU9sUU1DZTdkSmlIZkhaekRIWXI2T0Rxd0cvQk1FL2pCejhq?=
 =?utf-8?B?bndzUVFwa01BY281aW9yb1lLNXVPNjMvTlNTb3lxajY5YVBncGRsY2U5ZS8r?=
 =?utf-8?B?SDhOUTNmTHBZOVdybDFFL2dBSnFvcVVzYnlLUVB5RHZGSUlHVnVGeXZaNDRT?=
 =?utf-8?B?TnpWTHFRT01ubVEvK21rUkx3b0RFbXIzVWtraG9kYjExaVhUVGI2YWs4MmRv?=
 =?utf-8?B?d0JCK28zdERFT2lMdlRLYWlDZ3E3dmc2T0d5RmRKN0VSenpQVmNTbVJ5dVVt?=
 =?utf-8?B?TjNtOTNzNERVQXBzV0VVMzJBYm1iV2VTczFjT3RzTXhlRDFrV0FTL05JTXpQ?=
 =?utf-8?B?OS8rQXlRdm9UQm5LdnVPUnptZWJOSXo0Mk40cUtHTTlhenZRdHpBWFBVU21R?=
 =?utf-8?B?bENTZ1BpMEFMTDBFSFpnUzJXbG00MVRJK01FYmoveTd1K0dOd3l4Z3JlT0RS?=
 =?utf-8?B?R20wdG5kM2hyemswSDFVR3BsQzh1dTBPQzBBVjJub1drUTEyamZnRytjUFlY?=
 =?utf-8?B?WlhGVE1kQmNtL2FmckdJdkJXcmUrS0dUQ1lFbjliMEtodnR2WHA3UHp3QWVm?=
 =?utf-8?B?VTlHY1FBQWZsR2hIMG40QzhLVzdmS0QyTFlnNDJ4b2ZLTnNnQnU1M2d1czEr?=
 =?utf-8?B?QzNXazZBbHNlM3RoU1ZISEhGdkg1OFhUb3hPckpCQkxWbFdtdlBqeWpEaFlV?=
 =?utf-8?B?dXB1Nlh0blIwYTFVS2tWUThIMDBVMStCWlo4TmVxNFg1K2dNRW5jYXJMaE9L?=
 =?utf-8?B?ek9TaTdJemNEOGcvRktZaGFmVGJVQmFpS21KYWVTMS9QN2RFSzJoRWtZblF4?=
 =?utf-8?B?M0VLUVJrVlV4QWhCZmZPN3k5SUJOcDUrMkJLcjdrRVdJSEpFS2NWR1RuckZJ?=
 =?utf-8?B?TWppSUdYNndTbThJL1g4THRuZUVZRlU3Z0Z1S09pUkRnWXR5MkY0Yko2RWlo?=
 =?utf-8?B?REl0MWlVcXNHYWxjUjRFa1Z0NGIwSTFSK3g5TnlDc0RXN2NaUHM4dDU3YlNG?=
 =?utf-8?B?SG5Nb2pvYXJ0WW1LY1g3S2kxNFM2OTBHT0JmMlhHV1pLRk1ON09Obzk1bVlV?=
 =?utf-8?B?c1ljTjVpRk5sd1MwYmhRVlVuWGdLNERydjREWGdUSU1UYVRQQUUrUWo2MUt0?=
 =?utf-8?B?WGVXcVVPU0Nrb2xnTUxrZHc1VnBUbUtpbU1MWGtOZWx5aldtNXZmcWoxTFVs?=
 =?utf-8?B?N0xLUVBOUGtpaU1DT3NkTDNBV2FKUzErdTNhTCtOSjBsZk5tUWlwREVJcXZz?=
 =?utf-8?B?Sms1c0dXT0IxQjFrNzV1c2x1TjVpS2g1T1czRDhTZUpja0sxZWQvaVF0SW1G?=
 =?utf-8?B?bTRNQWNFaHpzNC84eWJQd1lTdXJPTmZ0QWJVNm9wWEsvMy9ZdVQ2U3l6UUJ0?=
 =?utf-8?B?aFkwR2ZOUmE1QVVCeWg4YkMwcmNwelBGUkRmWXdCZnlleGEyN1VWYmwvZ3JD?=
 =?utf-8?B?Rks1TW9KcGhDWktlZURyQVgwaEQ4UVBYbkNQdlFDMDlWdFVMczhWZ2FDc2dK?=
 =?utf-8?B?Z2J4cXg3Q08wV0RwWjFqaWhXRGxuOWc4SjdPb01QMVJnNmNOd0M1aW1lN0lJ?=
 =?utf-8?B?TE1NOFdEREErdEFxZ2NJc3Izd25EL0hDVExYVHlLOFA0VjlGMWhtbVY0MDVT?=
 =?utf-8?Q?eYBEtrwErNjx3q8SfQwKjPu+r?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c543f1ff-8500-4819-57c3-08da9cb560f3
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8789.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 16:13:25.7795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFjr2jAQ6Snb0N57mNPIukTED5cEpF/xuuwd0CvLaVPwjT/ploouts/ctb4wVfatqLLU0DhfPS8a2UnpdFRhaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7541
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

