Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894D25951D7
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 07:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiHPFS3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 01:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiHPFSO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 01:18:14 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10089.outbound.protection.outlook.com [40.107.1.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BCC201D72;
        Mon, 15 Aug 2022 14:40:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2GFbvjz00XUox5EfY153FZ3raMF2pEOPv7G9BzqU7iIWoXmnOM2Uely1Ryd2iKa196LbRCDp/vyWWykoUXsQAihjWxEWqt2VMGZZ7DSOrH5nuKbw1GBhEUL2uHbTxlmknVA0EOFi+FgSr6QBCmfobywmC9pNS0CxZr38mPy2fyiV3loy1Hd2L8WBPNuty6C1qQD6iFVy41I5rXU7wpNonWFR3nnxcO9mq1InD5lN05cXm4l/pJKR8RenZ/2vc+nwn3MWJZT1s3v6C1SdBdvXn3yi0IjTdmMmn6dS+c+vYtCa3ruSrheRKu8KMZFQ6xe9hzfKmlQWKJmWF+GQ8ws6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cqUJlFv/0xz7Xx+xq2uKhrQiw7XueqIYx/1htoATHQ=;
 b=A0kLK8xLzX4n/rSNKPtOaR9thUR6n5JXylXjKEShERn7JmPmTUbxi9+fuSkT69QCBBiWEzzQJncFrn0ivdyKpQmiJ3UnSXSsCP3CL8mvszHPD5HTm6h7gEJFFR9RICoC5OPk/YBIUY6+ZZsMKBnRjOLx7R8LJJSdQ/j2ySrOy5GZNGdZQdMK69r6i80HZwwtJg2EtcPVJxxji0czDC0qYKj5H2PGP5vNgHyprVuvrK0mE3AXbhL48cMxVLjrFKzwSVDYuLSoxigqyX3dZUqxhlxnOQL1njno4xVDr6Z6QsYNXMJ54KMcK6yLkxy2KEfr22QbAJyMEr69xIknGOLeaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cqUJlFv/0xz7Xx+xq2uKhrQiw7XueqIYx/1htoATHQ=;
 b=JNZxzAhD1BeKA/wi1HI+Rq4R3N2Yjd/AhA7uUB4jOJjRotNi/qDqxEM2SCXL+BnV+L83Su2S+CDXHVbixxyHaZFe1me4Bf6AkArEt1wQ1hoxgXPt2vrD3TGgfoFLIvKPn8NTJDlZZj4C2XWWaVuk+FK4+qYlKbehYwUZFo0qS5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM5PR0401MB2580.eurprd04.prod.outlook.com (2603:10a6:203:38::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 21:40:00 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c5f1:b708:61db:a004]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c5f1:b708:61db:a004%5]) with mapi id 15.20.5504.028; Mon, 15 Aug 2022
 21:39:59 +0000
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
Subject: [PATCH v5 0/4] PCI EP driver support MSI doorbell from host
Date:   Mon, 15 Aug 2022 16:39:32 -0500
Message-Id: <20220815213936.2380439-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR15CA0006.namprd15.prod.outlook.com
 (2603:10b6:930:14::9) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 611b9abe-ddc0-4ccf-8e81-08da7f06b17d
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2580:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xOr+bgQa0lc63pYMs9SLyLP3f6r7fZb36ulj5EYJfC7W33LjOgQPr5CKS29hQ2xh0NvvDJJtJfzboYMT3R/aDw231EtdDBO4w5tdecDjQb3WVKrFeoDXSTIsANgLzSB2BItnVPYUstqL8gEnt6IjB4JWv8qQYPqLAkkILgJnVQO8VGR4Wr09fGscpoiYn4bOqe0CaGnd3YQYL2Q1xhbg0AkCpmMLRI264QigY0/8zggbE8ichSKS4qaaVMdSGRQ+zSnGTApwz63WfL61vOnb4yuhfeqd2ljFBG/HxHLhxkx/N5xqU+pj5YXSqrk5BpIeNgGtX8yVBlyGGCh/+FPAyNk+esN/yJFKjiwQWGJS1esydhBOjvMzrOSVBwvbDbGOPGgC9zj+bFJa98qItXFton0zATSvGNsFYfRId1zqi9u9ndvjPuRHWhTyG1VR9oX8p2ykJwbCr/b4i1UYK9KMXDfz3PVBEHSJ2qxGqDAU2TKBgOPk9oxh8lID19ba1jDo4r/YZOw7pLewQse0GuMKl+RYdvObpyGl5E3F2SEEhFIIgqUr7qpYvh2RfX1xI7RXnUrEM4N+j3WmY1JRPzqNgBBGPcxZ1G5FpAnIqZC1LaybhALZXXTlZD2jNyyt9YrVtKe5KAFJTy5QYUNps+9Nl6qcBjMaF7oS17YWbMJyHoHa7hZ+vMuRiPgnrTl7tA1hpR7Rd+fUrSf6MsjsZPs56SN8cJ9i/a8ABq00XKfMjblZDejz2xShqW0yjHYEg09gOgpRiQFnuroBdN5Cu3+VD5WR4cIR9b+Cm7+Eupc6H5WMJwXbfZI+xjBSZJr4ZnCUMzMPbqhqtt4lnADjINelHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(83380400001)(5660300002)(508600001)(1076003)(36756003)(186003)(6486002)(2616005)(38350700002)(8936002)(86362001)(966005)(316002)(7416002)(6666004)(4326008)(8676002)(66476007)(38100700002)(66556008)(6506007)(6512007)(52116002)(2906002)(66946007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGV2YWpVOUVsMUNkV201TEM4dmZUakJRTTZES1pGdjZRcnFtUkduaThUbGw1?=
 =?utf-8?B?MkZ4RFlVbU1aV2pSQjFyL28xRjNEd2psaDRST1VobkJxWWtYNG14c3NSRHdB?=
 =?utf-8?B?QVUyZFFBZzI5VlJzRXVYaDIzaHAxOCt3UDVLM3Z5L3FCRDR2WThtZ21xS2t4?=
 =?utf-8?B?a1AyTVRiQnE0QjJUQmE4NDVpc2R5RTU5UG90VS9DTHVPMFlNTlArQWl0Yzlv?=
 =?utf-8?B?TS9EajNVUFRWRlFDUG52WVQzUXJ2c3dvUnVXQ1VFbVlTd295NFprQXJJT01Q?=
 =?utf-8?B?ek1KYnluYTZZWTFIU3dFcU5SRURPMkErZFdoMHFDRXFnVGdsWWlJbElwRWNu?=
 =?utf-8?B?N1kwdk9XWnR2NDZkUHVlTUtLTGJRMDFhc2xNeW9TYUgwcjA5YngrSFNtSW5J?=
 =?utf-8?B?cDIvMjNxMGRibFpSMWtzZmpUQlJvN05Da2dOS2ZRbFFlV0VpekRYZVpJWVlz?=
 =?utf-8?B?UjByWFBreEl4ZUs3eW9vK25XdlZDbTNaLzUxME9SWSswNTdjSlFWbngyMitK?=
 =?utf-8?B?S3NiTEZyTkloaUswTWgrT05MTnNnNWNDYk4wc3VtMWljcktqQThSajJ4MmM1?=
 =?utf-8?B?aUVTdzhSQzEvczdHSXg0RllJNTROcUlMdE04UVNHblpPNUJwUTM2NlRFSUxO?=
 =?utf-8?B?SUZOTWtuQ0htUlo1UnM2Yzg1U21qQyt3dDNPUGx2MEFUVnB5UFJ2Sk5mNzdI?=
 =?utf-8?B?enhKY05STjhPdkhIamZPejQxS2JoZlpMVktSZlVhOXFXN2Z3cmlWZWlRRzFZ?=
 =?utf-8?B?dHMrUTlGV3JCbzlBTXRDcVhsaGw0SHc0MCtOTHNSdUFCS3lyMGdZQlJrZEJQ?=
 =?utf-8?B?Umk3OWlmYkRpa2t3NG40T2tCdkZpWVk3RXZSeTdTamJ5Z2hPYVg5K3dpblhX?=
 =?utf-8?B?M3dKdFMwQ2JvalhPY290dVRZSVpDRlJiTHRkeWhqNDFHMlU2VTV4b3hmQmt3?=
 =?utf-8?B?Y3p5N2xwbTJ0RkZwVEkvOE5Zek5mSXhQK1R3aDVnSnJ0eVM5VytZQy9PdHNE?=
 =?utf-8?B?UGFVUnlJaE00YTNPZStOWFFRN1UvTC9Xa3pPNDFYMTE0NjNEYUhhN2xlOVNW?=
 =?utf-8?B?eEJ0R3QrdkZOYUcxZmlJaVp6WW8zK2hlYk5qWGVLaE9hUlg4dkozYkQ5Z29Q?=
 =?utf-8?B?eitZVGtyY3FIMVlFRm9VODdNUUt5NDBiK1FPN1N4azhOYW1HNlhhNjQwT003?=
 =?utf-8?B?bnczV09RelJjUlVpaWpDNkZRUW5DQ2swYVZkQ3V1ZFdiRTBKeDUwZFREWTlP?=
 =?utf-8?B?OXF3T2doaTQ5RE1naVltRVdKbzZkMUZRZk42M0xCMGI1UzlQVnhOUUNkQ2Q5?=
 =?utf-8?B?a0RUNlNmYVdwbTBuTGJZZTBFME9jVUhBVGY4TEhKQUIvNGk0ZWZHRUJaSzNX?=
 =?utf-8?B?bE5rRjM5V095d3JHWjVTMFhDT29TTjVzYVJOT0t1cHNrZHdmcmdsK3Uxb3Fk?=
 =?utf-8?B?ZURMRGxQL3ZnU1BRM0V4Y3RLLzR3SWxvNU1MTWs5UXFXcUxSZEsyVm90Rk1C?=
 =?utf-8?B?d2hxZjVTVitlYW8vY1Yza1lkYVc0WVVHQ1BsSi9YaDlxZ2tTZVpIZVJyQ0pv?=
 =?utf-8?B?cDFCQ3VUbFBCM2lTT2lXUlo5V1p5ZzdydTFDbTZ6TmtmaTVNTi8xU05TT0Y3?=
 =?utf-8?B?dCtGSUhmVDJxa05Dc1NRUXJYbGFXZkJTU1BSeU1YeWtuelZ6ejR2M2tXTUx6?=
 =?utf-8?B?SmpaTzlCR05PYTRKZzA0ZzNVRFg2WklXRjBwdTFhS0J5RnYyRkZ2RlBNOE1M?=
 =?utf-8?B?T2pYd1BGQUsveDQ0R3ZEUDBvWXZtRzZ2aXczQTd2U3lnNGxuMGJWM3dHcU9I?=
 =?utf-8?B?UVF0YTFxc1pKMFZ5cERIdWxjV2ZaM1Qyb05USzNQRURGR3RzMjZRTDJWVWdH?=
 =?utf-8?B?b1JHSDZJWFZLNjI1YTBzaEl6SjJtQnMxU2YvYnBYaldSNWQvREQ3SFRRbUJU?=
 =?utf-8?B?cnJkaERXUWNUOEZLSC9yZWthWDZIMEhOODk2ZGw1TTVvTy9JazJCdTJHakRl?=
 =?utf-8?B?amZnM3cwRVJzaVBBajI2ckNFc0E2bjI0RG96UkdJRUVnTGMrb0JNeDRMay9i?=
 =?utf-8?B?K00vQXpmSUNUSFVmSFpCcHNUeWhTQlZLMk9ha0JvR1JxZDlMam5GY0tPVnFL?=
 =?utf-8?Q?TohbJgx+eIwHo1UD6SFMK8cDq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 611b9abe-ddc0-4ccf-8e81-08da7f06b17d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 21:39:59.8819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTcYGeHKjVQnl5DbhINKzTWDscrw8IuSYXNzvURcQh3zopi9Fb3PAebueTM9P/eiOkz8Vo95TdM5UEqCeJWjsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2580
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

