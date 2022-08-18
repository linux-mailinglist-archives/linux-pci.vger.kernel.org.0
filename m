Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFCF598707
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 17:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245730AbiHRPME (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 11:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344109AbiHRPL5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 11:11:57 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F5ABE4F0;
        Thu, 18 Aug 2022 08:11:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byNOOTI1lEswpaJSWNeN8XEomafr0DR5y924QVwCW3nPH+qQ6aK+1ybT7mBm5rJniyKYQsYc3Ct0nQEEhQ4wfjkwwwpLdpIVOROURsrvly/8LLs2kU4nZlCk/j01IFYVQuHq8ixgE20zz5MBdL/Jijb3EEfeqmjeBTwmjS7uEOaGSN9OoNvqlrf35q+tSF5IfBD5xgw35+VVhf8Cbo2W711j9Q/tApHeqvgy6N/VUchP9tNQU54DYRrR+LaSmGSXw5xuS9zr+m0SRl4J6Qn6JbqRMq3CXIcZqcIr4CQhWaUO2gfyLtX+D6FYiYA53LNfBdpDN6zJzhG18ITblHyFYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtMpNVplILGZi2u/dVsX903we9+baZrIzJYTfXjWhUk=;
 b=W7OaBtk1BhWxXHVJuB686zbPWPwUuPsKVgLx5ERz+jFyJKVLj3W4TAW2qRhK42bx1ERWtVuUwTQV+SmInjYjITmcAViFBvMsns2qG/UO6/d0PqJ9PQmYLXIwWG/6DZkbTkAD5/dCtD+4Kw8G2+0yd1NIHVX8InbxVLNY45sYRipMoGZTJUBNVzIdOj27yI2x8T/n0wAPBaEiGJY1MdSJEiVWuIhZ5DqS8A+KiU2EdpWo5hMVCpof2AroJXsUocvtGPn1HhJScmzOv+cW9/5boio8p7g4LyVKEo27gUZNv4YD4CaEmPINIoTYKnl+Zxh1RdiROK28zcME6dU8ai0B8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtMpNVplILGZi2u/dVsX903we9+baZrIzJYTfXjWhUk=;
 b=WJoqDI3o8ocAv0UzWeDhYs0Axc/Pnojebb6J6q9zp0UzbZ18yvqNTfyuAhmgkicDl2qsAWAJh65xW+JlpbEBcfI2qGqFJXX7NOC3SjD9OF/EC3lz+uPV2cJ2tGkDKOHHpU/bKAh1aPDx6pqHkxwictj39YLpuj+VdmFGbiKQXRU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM0PR04MB5713.eurprd04.prod.outlook.com (2603:10a6:208:125::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 18 Aug
 2022 15:11:48 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::40a9:93e4:75d4:f73c]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::40a9:93e4:75d4:f73c%3]) with mapi id 15.20.5546.016; Thu, 18 Aug 2022
 15:11:48 +0000
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
Subject: [PATCH v6 0/4] PCI EP driver support MSI doorbell from host
Date:   Thu, 18 Aug 2022 10:11:23 -0500
Message-Id: <20220818151127.2449064-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0141.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::26) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5e39ade-f509-42e2-a94c-08da812bf862
X-MS-TrafficTypeDiagnostic: AM0PR04MB5713:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rwa7EjpSWXS2S/ESv3m/AGXPxJUlAQz56i44Wp1GGyYVSROll6vXeKR/e+IYzTo8Mc8RM2NnfrDTjpY6abk2eOiLunJDNO0XX32HFWL4f6ELjff/Sa2eo80BTK1HPRa1xAnPYkljpa+F+AucdUHTv0yXpAHvTZbC3fTM+Ds8tQFK6X/KWh0UEoeXW2ebij5FIRenCvehMf8E1S9yM7uVWmgf3eebpO2s3wc5EJjfriw6I3u7Mf2KoJuOonhZY4bQSj4rTmDwWJwwROzGSTRF5aMa5JB/33k07E6wwnBSp8JXfiL4XYa1nWJOZVL02ro9S3Ybs11aWZa72THxyRG7JLnfqiLyl0xmW7+AIEZWU62ZlcADTf3/8JgLTruEu1h0JIE7EW617gXZCwHHFRp01ykqCiK7ux1TYNuzuU5RO411J4IBiGHYaO+su5h6d6GFKR9b3BeIarlVo/C5Rh9axbj3/eTyUFd6LGZG+3IlyDf6A7dFMrUoS8aQ+lRoxvQookpzccX8O2Pzu0Q+EcveC65g+RayyPrqerYQJGpAAo427DFDBD9C5CB6EdhLrt1/IdlwostJhahz8UGjGzXv05sYtnY2IBuZHhti5wYnbSFeKVMpjmB62Et7ZKv5QJE3AAWtFkUmM3K2BwkV1SP7M5Zd1ahZJ5sbd0xDw4KD9dgoxRhSHbEuGjMo8S9+FjbT+w8fGv0+SPykVszGIvZ3nBrFvHNnD55K+9YgtT5RR+zTVbQjlqK3KdF9W23Z4hrDqCn6HyaLn3kGjD/OiXRyipHxzcyY2IFmEXjmrc6Q2/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(2616005)(316002)(1076003)(186003)(83380400001)(36756003)(38350700002)(38100700002)(6506007)(52116002)(4326008)(66946007)(66476007)(66556008)(2906002)(966005)(8676002)(6486002)(86362001)(6512007)(41300700001)(478600001)(26005)(6666004)(8936002)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWpSZXFVR3pBbHdTYmFWcGtrQTBCZkxYQllFbVhzM2g1ZzJ5Kzk2TGF0Z09h?=
 =?utf-8?B?c1lHY0RzU2tJQndvc1FQZlFmTEdsV2o4Nkg3akF0VDRmeGtCL2lUdjRGNmd0?=
 =?utf-8?B?WjhDTjNPdnJydllHV0gwZ3JnRE02aUZYNWFWR2laT2VMVndNVDFkMXdxblVR?=
 =?utf-8?B?aUh0VUh1MjYzRjdvQlR4Ti82Y1RQZnFkQ2RMQVlSaTNFZTd5cGpObDhQZ29x?=
 =?utf-8?B?ekUrRGJOdFpqaVpPUElZOVg0SVZBdjdUc0RjWTBDcjdqOUtnWHlnS2ZsSzU5?=
 =?utf-8?B?YUFhbExGdktLc1B6UGdDZkxpRjBUeUMreWRTTEcvSTBpbnRLenR3T2FKenFm?=
 =?utf-8?B?RDFQWUJVK1BOVzVhUVFtbWVVWFZBejZUQ29VVFROcW5qS2lDQWdSSDh1YWtG?=
 =?utf-8?B?cExjRW9LOGpkS003Q0hWR0kxS2QzVUI0UGw1WjRjUGFCb2JQdS9YSXQxRVh2?=
 =?utf-8?B?S3luWU5iK1dNSG9JM1JpNjdkT1NmdTdEREtXY0NEUEx1TFBpeTNTcjZjVGxW?=
 =?utf-8?B?UzFrWG9PU2syQWhaWkNBWU91NmI5SDdhazV3T3BLQm5BUlgxSGh3TnVnNWVV?=
 =?utf-8?B?SFRKTjJ4NmlmbjRxSXJFeXNURmZ1Z1dpaHVUbUp3SW8vdjdyTGREQVNjTCtU?=
 =?utf-8?B?ZWxuNFJIamswUDkrNDF2NkovaE5ja09iZWNXbUtTM1kwd0QySEFkdzhNbnpp?=
 =?utf-8?B?bzRDMjRHZ2EwS21LSjh5QmRZY3ZROGczaVVUQlNuaEtDVW9ibUFIZEdyTktn?=
 =?utf-8?B?aVlwbzBaZlVPdXM3TVFlZm5xNXJwNEY5YnNXbnd6WEZxRVhYWGdCcjAvczFq?=
 =?utf-8?B?QmdubU5FSStxd0xzdUsxUkoxQ3NUL1QxT21FL1BwOUROWmFIL1orTDFFVC8w?=
 =?utf-8?B?bmZoOHpvYmEzODlpbE9CYUlRU0VVdW9XaFMwLzhnbk9hRUdUT0VxY05lSHhm?=
 =?utf-8?B?S1RtWlZvY0M0NERqckVBNUp2WnZkMWdEMjVDUVRkZWpEQzlPMHJnM0kwdHQx?=
 =?utf-8?B?U0VEbXd6ZUFGcVMyZmQ5OHNQNjN6T2F5STNIcUUycjRjRVNPbHdINGRYS2RQ?=
 =?utf-8?B?eDJZS04xYUZ0eXNZYStKUnd5Q1VhdmlNMi9pUjRBaWovcWg5SXRSOVk5UVln?=
 =?utf-8?B?emdRTllsQUtFNzZlMFc0dE9BaFpBdEdHbG12Q3hkckpuWkZjQXBUNFRCNDlG?=
 =?utf-8?B?THhNYUpFSmdlL0tmNjY3UG1NRVNRRUM5dzhLc0tzQ0Rzdk1BZEdGMXZCVXdj?=
 =?utf-8?B?TUJFWUlaNkdnYW1DTTZSUmJMVHE3WDJSV0V4Zkk4SXRSUmplbFQ1b2JXQWp5?=
 =?utf-8?B?elc0bHVqQXFPZDYzYnBIYkVNT3l5MzR5V1IrZHpMZVNEZWQrQU1JT0pNamZk?=
 =?utf-8?B?eDlWaDQ1c3E4V0h6eDdaZnlTb1ZwQ1c3SVVNTXFFWVpEUmw1eWYyNEdXcjMy?=
 =?utf-8?B?T0lnSWVBa3FFWDBBZjFoVE5qdTM1ME02STR3ejVZMHRLWHhGYmhYdUdnbksw?=
 =?utf-8?B?TEQrQkJiOGpiVFpIcDdXOGVuUnNCTFdEaTg1VGwvRFFITHYraG0ydUl1VTlu?=
 =?utf-8?B?Sk9QZHdmQmJkQzcwUUdMR1hBNS9HMHlvc2NtZVlYQmIraVN0cC9jdHlMRFEz?=
 =?utf-8?B?Q0hOK3kwMVJEajdrbW1kNnFYMzRPbU85cE1PTkxORm1IaytYaHZEbVVoTnpj?=
 =?utf-8?B?ZmVXR2o3TllEZWlaYzRzTmNScitXb3c3Nnk3TE10SDQyWC9ydzhKUzJpZG4y?=
 =?utf-8?B?Mk0rT1o3bEpEZ2V0eWtsSWpmV0ZONFBmMUJBQWU0VVZKOHMzampEakVYeUN3?=
 =?utf-8?B?U3VLOFJHQmo4Z2ZscU9VL3lyQmZBNGVSWVpmVDZ1cjR0UlhUS2hUUHhrb2kr?=
 =?utf-8?B?djRaVEZuTXVQajNRTDFSV2labnRqTzM0d1d4dW5rcVI3VllqdER4blZOU2Iw?=
 =?utf-8?B?eVNVRzAyeEppRk9TTE9aWndKSk5RYVA4REozWGFOMDUzdzh2emNuNDVTV3N3?=
 =?utf-8?B?RjNhbnEwU0hLcHZOb0ttVmpQRk54eG95Qjc0V0ZiMGg1TDFVL3J1T255enJG?=
 =?utf-8?B?aGJwU09qSFcyaCtuRUdWTWV3ZGFid08rcnBlcjMyYWZCOTM2Uys5eE9BSEdE?=
 =?utf-8?Q?mF0Q=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e39ade-f509-42e2-a94c-08da812bf862
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 15:11:47.9794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /UHUOvq4jDxB6UOVnCPPmfZWhir5zpMVg0uf5vYdzjqf1osklMi6h36uOtGnscg5X2pkaCxivpyEedDRLFYZjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5713
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

