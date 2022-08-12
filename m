Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44C45916DA
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 23:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbiHLVxL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 17:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbiHLVxK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 17:53:10 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE232B2854;
        Fri, 12 Aug 2022 14:53:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYfHsPyuI7rwa42xUpOMW0BaWJfNV3PKHlnZOIS36LHIUSS8AgyQeN7Jc62leJESNaKrmnvLcKar+wZLwG7wBU8yPgeV1tV01lYEzBFbatqEgenYcLUSiPF409qL/meATcrhVYw8UNybJ6a9FzJsRTfCM3F32sBmsC9rUAGvr5DZiY9WZrSzcvxAWtYSdK/2zW/1T8s9I77nHi9RTKi//GEJtyu9mNen5tQRcLpILi2t/i4idOmuVYtuxyIF7HYPjYDIAK4uCTDc9DerTNanxFDGeBTkNL6fG+q7ayQojKcZbwMQEpFWq4xYnTGWGJ/yFb1uT2Ot1GBfbpoTihn/bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFJyrv0Xx2Ur5Qdjp6r83x9ircfqsPnRALMElrURjgM=;
 b=HbtuSNRMBo6axdiw1NPh27Ek1sf6tJMAj58YcWyddLkbEWXgjCInRMZUNY43e/FIUbo4Ef7M761RExswsRIiGY0O63X5MMeXUlgpcqG9dCYNzpvivz5eyhdHnaAJ2jJ3xHcOxWRS+RBA2mZbtFmw7nd5VtpnSN7ezFSf760sGFEnW6LBX12CRM79wIEXTjeZRCRNraD8NnVV0JEc41W7HZejtQg12+JeRBkDIW4QFD7kDWP26IU94Y10nNlV4M+vyeHAPo3cef4U0nZJOQodW/h0AcRpdgiWQb+ug0Fu9o5h8N6dlZcxJbqrVO414DBhkchgntUlA4sjfTvbWPafJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFJyrv0Xx2Ur5Qdjp6r83x9ircfqsPnRALMElrURjgM=;
 b=Cmpl3sJyYCei67HDzTKtCPlTaFBqkdr4IphW7Oqky2DxxVX47JRFy984QKNOAzMIr3+GRlhCBOMvSRVf7G7bnhQ16lH9bHFSVq2nOAXTFCv62cOhZqsaUxYiXDQ3NDkBo2ttbK9TpKF1q8fj05QDiqIxnzYJ7mSX4YFpJa/6vdY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by GV1PR04MB9087.eurprd04.prod.outlook.com (2603:10a6:150:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 12 Aug
 2022 21:53:02 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c5f1:b708:61db:a004]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c5f1:b708:61db:a004%6]) with mapi id 15.20.5504.023; Fri, 12 Aug 2022
 21:53:01 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com
Cc:     kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev,
        lznuaa@gmail.com
Subject: [PATCH v4 0/4] PCI EP driver support MSI doorbell from host
Date:   Fri, 12 Aug 2022 16:52:38 -0500
Message-Id: <20220812215242.2255824-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0064.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::41) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0109858b-fe8d-4b85-d0e7-08da7cad0709
X-MS-TrafficTypeDiagnostic: GV1PR04MB9087:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 14GOLx58O9rU1G5cDS9KUqugOKdAED5AAcKjEk1GDlCW1tjpJ5Sx607/ZjI10nx5eHKtNHXnsktkZuQnTvC5VIldy4tN8LJkWYlWDMyMH13YVv9hkn4S7JKf/2/Klkiudcm4y+8Db62Zt+KSx2Ibi0IMQWmocjDWWfVAk78huf5uA/Jggyxxpv/0SCA5ykQevDDV8KSSQ25+tjixXg3SadNH3icJKFnV4Xi2OQbpY+jfzTQLhDi/eyt2v7V3dZRAmRniek893wbFe/kAH7iYIv25xLpaHBm39Y7Ufjl4DxjaOyoMC32bUCD//vzPCBNiIO6F2vGA+Ol6WL9xi6gvwG9W8LAJcsPumU49xjzTYEA4HoJBnRIrn0xlB7lWZVCFY10FI3xzR70u4xyZLA2m/u/QcuaxOnvCv7sVRdqlz9RoVYov5r+Wot/QRMZfE2UpsXQAvdbL4anzoPDF+t5drQ3QZYs208vzZvxIck9bBvK+oRsDD8OaD7v9E957nYaAcF5IVZuuPPxRy0im3h7/GU82pGe5OWcXvBVxaWAwq/l5pauHTWpjg/wq8bDFZu6NMPe1TzPywy2Z0TI4UR0Cbk8gyvhbo/iJy2LCNFEzOaTJYQnJZ7ETf1WSH6spXZObF7cNa0j7xJg4koDZGm0Ig4dlGgvWyotCG+Ij64yx7lCb7FXcMXZZcs6v6xq9JEKpwRIx/hFNCpJZ08tuC5Vr8J/ysp0cqxXJ41IshOOKs/sOTgC97UI6dCi9rHTlFtcHIEiAc1ymqqvJATfIiF+RPvlvjeioq/4l0FyGreGpHoBl3NsGXfhJTqYvv+9hGNQa3i5u9dUj0aiftdGDQLiEUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(1076003)(2616005)(186003)(83380400001)(38100700002)(6486002)(478600001)(38350700002)(966005)(316002)(66556008)(41300700001)(6666004)(7416002)(5660300002)(52116002)(2906002)(8936002)(26005)(6512007)(66946007)(8676002)(6506007)(4326008)(66476007)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFNJajZhWHhrVmNDcy9UN1VEQnFCRExKTWlPUXg5ZGNKUnNNT2Y0K3VXalpS?=
 =?utf-8?B?OHN3RlZ2Ym1ZWVllOVVPMEp4UkVqUE1PT0QxNXhjRlR1ZHVja2xTMUhDNE5s?=
 =?utf-8?B?RnF4ZXZWQ2taWHJiS0FaOTNSbmx4TExPRWZSWldGUWF5V2IwSnFQeG5QeUhB?=
 =?utf-8?B?bFBHVURvZjhrbFZoKzVjb0pObmtvVTlHTkRkTWxRZEpRd01KRlBEUmx4czZL?=
 =?utf-8?B?Wld3cHphSnBTdEl1MkJQMklFQXM2U1ZJTkthUlEzNjUvM2hoWXdCTjg1MFdW?=
 =?utf-8?B?MTRNNmxnS3pZME42WXNFK0FzZk5WNmZaeGp1dkViSWFqU1pWb2RZWWdTeWpH?=
 =?utf-8?B?cG1VT1NNd2JzbTZBejlkSk9YaDIvUnVWTmRYZXNiNmVwc0lsQi9teEhBUlgy?=
 =?utf-8?B?RVBuQ05tVTBqWUQrYnJKRU1qWHNzWXhlZDh2Q0JQWXo2Z01aT3QxWDBjMXpm?=
 =?utf-8?B?d3k2U2M5LzZFUzB2YVRqTWpuNWJPNXBMQWRZTW92UkVwUy91TnhraG9Mbmk2?=
 =?utf-8?B?VTVCaHBTVTE0a1g0SDNDVjdQaHhvbkgzdVVNWXRsSkE3TEZlS1piZXNqLy9J?=
 =?utf-8?B?K3BUVDhTQnRTUUVJeWlNbllHRWVmcUNPc0pVTmVMdmJBdC9KRzBpNmZNMzN6?=
 =?utf-8?B?V0NuKzA5eUZxbTJGa09wN2tIRkJSQXZFVXFxZmRrWW5LOXczbVJGTlJlTi9I?=
 =?utf-8?B?dkVIeEZoekFxR25pYTZWUzlNY1ljUHNuMGNodlV4NEI1K1VycFYrSG50eWsw?=
 =?utf-8?B?dHFDZEgzK2VhZzV1OHY1TzhRT1BKTEluWnQ0NEd1ZGFta1UwdnFyek1jbkhQ?=
 =?utf-8?B?Q0UzV0xDSTVLWTYzUHpCZGkreXRuUDlCaXF0MUZzdDlHb0Rza3J3WHowcG4w?=
 =?utf-8?B?UEtBQUFRQkRkUER5aVcyQWFRWWYrRFgrbDV1c3FiSWoxMnRpaDl6YTVoR3Av?=
 =?utf-8?B?N0N6Z3ptU1gyREpFcWp4S3ltdzMvWVdqZzl0d29BcVBGcWxmdVcxWDVpd0Vr?=
 =?utf-8?B?WVpLVEpNNVFXcHM4MTNOYXViSjl5TXUzL2N1WmRWSXJuK1NrdnpVWHpLeEc5?=
 =?utf-8?B?NGtjSGM5dHRkSFVRSU9WcFV3eWdzOUNjM0lhMkI1VFY1cXVGQXFyWGN6QWxV?=
 =?utf-8?B?NjVWZnpHV25GUVVqRUFvaWtIK29xMFpjZVdIdm12US9MRmhpNGhUWEdqdml6?=
 =?utf-8?B?a1NrcUxCbENCNGJ5eG1vcHpYOEwwajZNQ2lOb0ZUSkVRNU9hTmREQ2tCSG5Q?=
 =?utf-8?B?bG12VjR3S3gxeFFJNmtmQVNJMWZPWWZFQVdlUGxIdGlRL2NLblduUzhuZW5W?=
 =?utf-8?B?WlJseFNaTEVkbkVVcWJ5ZkZJR28weG1iRThUc0lDZlJtRjVjRWwrREZUNHNM?=
 =?utf-8?B?b2ZrSjg3REVlU21WbkN2L1VMVU5uMHduVll4QmZRRG9ZMHRDcGlFNE9ML3pD?=
 =?utf-8?B?dWNjZFpyYTJlMHVlc3hTdk1paW1CZXZMQ1lSSGFXNUlrd2h0dlN0VDZQYXUw?=
 =?utf-8?B?OG5DdnV5U2tTRW15T3lvUWwxOXBJNCtwVUdxWkxibC82Q2Znci85Z0VLVjU3?=
 =?utf-8?B?L2M4R01tWmV2dFQyVFcyUitTWWJVYWhoSVh0b0diN2ptK09oa1IyTXlHbE9E?=
 =?utf-8?B?QndQNE9kL2VQaXJBbTZzbXd2WStRZ3dMNG55M1FTQkVjMFBvZWxHaUdUZUYr?=
 =?utf-8?B?NHpOMGZDd1h5N3ZUREZOeWQ4Ly83VzZvZXhqWDZQVUhCSTdNbEkrZjIvRVM0?=
 =?utf-8?B?emxremZpSlg5bXVjazI3d1ZuOFdoV29KRGkvSGlTTjdBYWE2czhNME11YXg5?=
 =?utf-8?B?QzR6VG1YaGpJYU1UcmZtSXV0UksrRHA3UWdISmZJMENnS2cxQVRRM0J4bUdQ?=
 =?utf-8?B?aU41K1JjYStDT0F0YUFpRTUvc1BiZkx0SzRqam51MUo2Wm1ER0dkYTNlckpq?=
 =?utf-8?B?SmptWmEzUWFZSitjOEo5MDJQM1NuMzR5bEJnWjl2UVVqQW14MWQrdXh3UVVE?=
 =?utf-8?B?cTBlNXptSzEwMnZVcTVMTURBZDVTdGFmY2FYYjl1c3JGZDZtSHg2RC9XSlNN?=
 =?utf-8?B?aGJEUHBwR2lWUzZIYW5nK1VLTnIzM2RBWWM2SkZtcDhwdGxoTFJYNWxDbWdG?=
 =?utf-8?Q?TXPro3l9cWUTYyaeGNTkytX86?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0109858b-fe8d-4b85-d0e7-08da7cad0709
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 21:53:01.7491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z766RuB/Gw/khMdWstSYUMbtJe9bsH8wb9jB21BlEfK0BO47D1YSjY43fEx9PcB2NPFGuDAjpRu5CK1X6DXX7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9087
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

