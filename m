Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B6B7DBFE6
	for <lists+linux-pci@lfdr.de>; Mon, 30 Oct 2023 19:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjJ3Sdu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Oct 2023 14:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJ3Sdu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2023 14:33:50 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2073.outbound.protection.outlook.com [40.107.8.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACA2C1;
        Mon, 30 Oct 2023 11:33:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nr6CF/vphWcSEO23gFMtcVJGR5kH3h0K85kp5CsYhmo1NHk68qJjcQmTxeawqMQClaaPljZce13LEPO/egA6XIgHef74h/aM770Jw2GBKKqhKhbf/vAvyqQCQRf3bmb7ayVDtTyKtOQ+dk+0Ztf/Iu28XlVqynYEXf4byvxIpNC9w4ueYDQPwjLuHS+oKG8L6EcFlCaRgkNM+Uo03lZ2w6x26ls9Kc6G1Y4f+S64rZpvJvuIK5+gTwdho/Cn1uwrsYzlV3yDIez8wT3pw7t1vtqGUtawnqriGLXnJc+7yYmSJ1wrGG6+dIhYxlAKpb3jWVnvdtiRdKKFZnMG7X/CYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cPl+isM1llFv5Iidiqr22m8i6TDE/vfmFqVs/mDPAM=;
 b=ezIFbHT+fFIwbLFTE8XUzNPyCaQbz7VUFcJ7Q7i2oRMe//xAZ+D5aFkyUZHskvwloFogKlFut0DlITJ1y7NJrw6oqQ35vhxmL8RZ6ZWALWZWmI+sqJ8Ova4NHrvbq7FPUxJLhnERSNKtSye5AHHbGX9yYcw5cSszejDz8yh3zQJOs3zgXdGlJOq1FXOSg1tpwMKftgT9N04vhUk5ikWIRBXT1/8LFZw+WKifxlMQJSsd0aQJMXA9LIwlLpoUsQ07o3iiPV8sCeoEVUtRPdVJ1YGFag8fXbFBbfdBNYUGknCYr/QpPgzN9C9xpAEu7uDhqRZ8+yeRIX50qHLxpG/1Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cPl+isM1llFv5Iidiqr22m8i6TDE/vfmFqVs/mDPAM=;
 b=W7uWBRts/gpyEOfoH+u7EMM+W3Dh9ZNcBsBvT7iJcA0kI2BJ2xRE9BTQ2MA5kCOXhoT7bm0HAgQyrKsKgQW3pHscG8K51yYB/ez9umkRdhbQcBzb3BgH5B+ddz9JwEypFSwqkaK15pfhyCpGaKMknMcJoCNYh9GdQbcUu/LNcBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8211.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Mon, 30 Oct
 2023 18:33:42 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098%6]) with mapi id 15.20.6933.011; Mon, 30 Oct 2023
 18:33:42 +0000
Date:   Mon, 30 Oct 2023 14:33:33 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     manivannan.sadhasivam@linaro.org, aisheng.dong@nxp.com,
        bhelgaas@google.com, devicetree@vger.kernel.org,
        festevam@gmail.com, imx@lists.linux.dev, jdmason@kudzu.us,
        kernel@pengutronix.de, kishon@kernel.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v2 4/5] misc: pci_endpoint_test: Add doorbell test case
Message-ID: <ZT/2/SSoS4azNJnb@lizhi-Precision-Tower-5810>
References: <20230911220920.1817033-1-Frank.Li@nxp.com>
 <20230911220920.1817033-5-Frank.Li@nxp.com>
 <20231020175304.GC46191@thinkpad>
 <20231020180139.GE46191@thinkpad>
 <ZTLBxvM/qNGw/FLd@lizhi-Precision-Tower-5810>
 <20231020182643.GG46191@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231020182643.GG46191@thinkpad>
X-ClientProxiedBy: SJ0PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::7) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: 37dcc282-abb5-4306-7982-08dbd976be57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rPz+ZjrXF/0/KUpgXEtrqxNnOK6JczXShnFRW2QgazAA7o2lP8UJMM+TsooPVV/2TFOTBYhZcd2Dhyz5OL2mdHGHDxJ1qYhMmzEVdH9h15n4lcL1CTSkUT0H9daAUWo2JXJzYd9n6cqBuwTtZtlb+VsJ4KJDFN8r+OlC7dO13S8FK2OhK/IXzj+ahUMlY6SftEaLh2kmc9uehocb2VQLprEQLCwXBUFeP2qCupbVeOj4NYOQFa4aI7YYl4zHz7ojYXlkmXeQRAMg6CL+uOBOZtRh2CobiwNafcb3VzmaBJbE/rZD49T9xG2/ZUWL6PKEMYs299F13EE89RU6eNvBOQDXWq6Yf8vQrRo6DmWqeIteQzt1nLth6NImBXjf5rqAzRys9O0LLN+ZY+GirkvA+hilvYra7q6iyXfMOJUFu0IoCIwjHIDaQIWa3BLA1znWyTxb94njCcESPGK12TqB3YyvwZ14pBIgRUPWnmNAeXTWHq/2aj0JLsa/LlYaGzKIW2nFxkA9bhdjsMq3xZyuD+KwDua/FXXtOGvwP3k72jq7b6gV/V9znXlFcERyHbhWArBjIQFJVjOsqhfZIp61xuzTLlXX2OJZoMyaIjjpOF55E3/ZHDwwXsxZ2vV/bJYZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(39860400002)(136003)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38100700002)(26005)(6512007)(6506007)(52116002)(9686003)(38350700005)(33716001)(6486002)(8676002)(8936002)(41300700001)(4326008)(86362001)(6916009)(5660300002)(316002)(2906002)(6666004)(66556008)(478600001)(66946007)(7416002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzZLbFZFUGFhcEowNlE1eDlBdzJaVHFSOUlDcVQ3cmRCV1lKWTkyUkpNWEtw?=
 =?utf-8?B?ZngzZE9zcmhLSjM2cm1VMithQXZ4S1NBaU9DRVdTbklhR3Y3MitDNFNFTTRC?=
 =?utf-8?B?VW1HRWFOVGwwNUZHS1RYSXV3dkRCNWJ4NEFSWHJNVjA0UDhBdnphWjdoMnZB?=
 =?utf-8?B?ZEhYNTMzYWp6YzRNRVlLTkdHd0VWdHNOb28rK0NIOHhuem9PRmVxbjNXK3lO?=
 =?utf-8?B?b0NFTnBtbEN4QmRZNUJoc0Qrekk1Z0k5Rm1mZFdMU0ZsajdjSTFxKysyVDVy?=
 =?utf-8?B?bnc0RFhpVnFia2UvN2pjbURnWTNKZnZyVVJCYnc4dkZ1SmtmK3UrbUprR2dW?=
 =?utf-8?B?Rjl6V3lFVUl3NnNoclRvQVpjSHZwSnhnT25XZ0hoL3dsVFVjczBCOStnOHEx?=
 =?utf-8?B?Q2I2bGZWVW1ackwwenl2OUpaUmE1RWU5a2c0a1B3YWxDWkJPK01WelExeE9W?=
 =?utf-8?B?ckRDQjh0RTFScGFpMzlFeFNRSU1PcUVTV2ZnV0YrcE8xS0dyM2dwUHFKaFlX?=
 =?utf-8?B?aWFTMmNBQnpOWENOMUdNcHRRblhJWHNkZGFTZjJaWCt1T2ZsWk1uc3NiUUIr?=
 =?utf-8?B?bkIvWUNjYmJFN0dHYXU0VkxWS0dFcWRqUFMrZ05HZlEyQ2ExV0NyNkp4dkJw?=
 =?utf-8?B?RzhUMHJVWk1Dd2QyVjhEckFJRlFCdzZpK1JOc0hwZlFpaHplU3Y2K3NKYnlV?=
 =?utf-8?B?M1J3ajZ2Y29VVzhwU2JqRmhsYitZMDdWYXl4RG9QUlhZcm5aK256TVI2U0Vz?=
 =?utf-8?B?Wis2Zmhlc2tlYW9IOVA2SFdKUTdxKzZyYVBuVzFjK3BaODMwR25tcDc4Z0Fi?=
 =?utf-8?B?c09yS29qM2F5TUVwTi9jZ0FNcUg4bng1cXUvNDNRcEdhSi9QZTd1SysyTHFh?=
 =?utf-8?B?OHNFZ2hJWUNYZFE5dVBKbitwalI3TW4zc21qZnNhbE1NZVZRWndyRkY5OVJU?=
 =?utf-8?B?RlJUZ2oxdHhYRDAyZWRaSkt2Q2dMS0VYZEVUQzBKTmFUYzRna1hzTytoUVFh?=
 =?utf-8?B?RlB6bHBka1I2OFg5L24rR3NiV1lkVnRldGRsMkhWYnVtcFlyRW5DeGtKZlJi?=
 =?utf-8?B?cGVGYXQvYnV1eFJxSzRrck43dWt6L0NTM3RXK1ZGQUFlV245NEI4RUJMV0dB?=
 =?utf-8?B?Z0NSdXhZdnpHRS9CYWFDZWFpZ3dRVkFyVjF5SXdVeWpRTk5sMGo0b2EzdUpm?=
 =?utf-8?B?Y2Qwc1FjQ0VkNjh5WnV5K0F3NlBFaUxxOU00bXFGRzMyYnRTeFdqc1FvekNa?=
 =?utf-8?B?YzRUMDM3Y1JTSU01VFNtRy84Q3UxZ0FicVh6eFNmaERDeDIrb0V3eGdQK2ZC?=
 =?utf-8?B?L2drNWVyMVIvd3VpSmZlc2lGTDUwSVkzQkxsTkY2RHJFMEU3eTRiT244cUV1?=
 =?utf-8?B?dFRZalZzZjVuNTFrQUdFOG95SU1NSk4vQndpamF1bVcvTHR4SGE3VWZ4SHFQ?=
 =?utf-8?B?QWZuWkloVFdMTGhjakxCRy9MZkk0aW9WZ0xQb1hkVVdDS2daUlVFOFMxS0lt?=
 =?utf-8?B?SE1DRTE4TnV2QmQ1TWN2dE5ZdG1paEo1OXNRcVliczd1dXlPeWdkbTlqT2RE?=
 =?utf-8?B?azY3WkRPK3QvQWRVRHc2bk5RaWtNQTJ2RjFFdUtTQldQTElSeEcvcUl2TTM1?=
 =?utf-8?B?dGNUbUJneU1EZTdOYndUUHBxZno2ckhFNGpMTHNGWVg4cWdVYVBjbmpodWgw?=
 =?utf-8?B?V0FxM3VzRDBjVC80bkJlQXkzM3pPeTdBMlRBZ1VSTVNyTjlQT2N2MDF3Nlkw?=
 =?utf-8?B?aVQwK3lmNFhxWHpDQWdsY2lXdWY3bStQQ3dTQUZWczNtS3dCaC9sbDhueGZq?=
 =?utf-8?B?cVROYVJwczdzWlVRQTc1dUd3ZmI4THdQM3RTMEwvTmFIZ0VKa1JPOURjRGY2?=
 =?utf-8?B?RERXeWZYR2JNOXNwSFJsemRDRnJLQVNycFppTUFVTlJDc3N3cHM2bXRwekNX?=
 =?utf-8?B?cEJRcElTazkwL2UxQktGdUJJd25UT0dKZjB5QmNhc1VtQlFmREZPWnNwNWRZ?=
 =?utf-8?B?N3NUUHZCbENYU25jZnh3RDZ5TmthakJ4WXZkM1pkVTdjckE2dy8zRFJoMnNj?=
 =?utf-8?B?VUtCWHg0RUZHVHZEWFl1THBHMTJNYUczdGNaNysrWXZlQzk2UXdkeWs0K1Qz?=
 =?utf-8?Q?cOww=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37dcc282-abb5-4306-7982-08dbd976be57
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 18:33:42.7583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kg8lcAZiuqhyIEAB2P1x3itSPvW9dqGYN/Lmv2wSIntikVBREdohmEN9YuqJmcRBR/aYIPvb1eGlwqEHbKxeCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8211
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 20, 2023 at 11:56:43PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Oct 20, 2023 at 02:07:02PM -0400, Frank Li wrote:
> > On Fri, Oct 20, 2023 at 11:31:39PM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Oct 20, 2023 at 11:23:04PM +0530, Manivannan Sadhasivam wrote:
> > > > On Mon, Sep 11, 2023 at 06:09:19PM -0400, Frank Li wrote:
> > > > > Using bit 0..7 of magic as version number in pci_endpoint_test struct to
> > > > > support older driver versions. Save to 'version' field of struct
> > > > > pci_endpoint_test to prevent reading non-existent address.
> > > > > 
> > > > 
> > > > Since both drivers are in the kernel, I don't see a necessity to maintain
> > > > compatibility. Does it make sense to load drivers of previous kernel revision
> > > > with a new kernel?
> > > > 
> > > 
> > > Shoot... Sorry, I completely forgot that one is EP and another is host. Yes, we
> > > do need to maintain compatibility.
> > > 
> > > But can't we use the doorbell register contents to determine that?
> > 
> > Doorbell register is not exist at old EP driver. If old EP driver register
> > size is 64Byte,  doorbell register is 64 - 68.
> >
> 
> Yes, I know!
>  
> > Read unexisted, or unmapped space will cause kernel dump or other side
> > effects.
> > 
> 
> For sure it won't be unmapped as the BAR0 size is 512B. I thought we could infer
> something from the uninitialized registers. I need to think about other options.
> But changing the semantics of MAGIC register is a no-go.

@Mani:

Any other options? I plan respin these patches soon

Frank

> 
> - Mani
> 
> > Frank
> > 
> > > 
> > > - Mani
> > > 
> > > > > Add three registers: PCIE_ENDPOINT_TEST_DB_BAR, PCIE_ENDPOINT_TEST_DB_ADDR,
> > > > > PCIE_ENDPOINT_TEST_DB_DATA.
> > > > > 
> > > > 
> > > > This patch is not adding these registers and not this driver also. So this
> > > > statement is wrong.
> > > > 
> > > > > Write data from PCI_ENDPOINT_TEST_DB_DATA to address from
> > > > > PCI_ENDPOINT_TEST_DB_ADDR to trigger doorbell and wait for endpoint
> > > > > feedback.
> > > > > 
> > > > 
> > > > You can reuse a part of the commit description I suggested for previous patch.
> > > > 
> > > > Rest looks good to me.
> > > > 
> > > > - Mani
> > > > 
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > >  drivers/misc/pci_endpoint_test.c | 48 ++++++++++++++++++++++++++++++++
> > > > >  include/uapi/linux/pcitest.h     |  1 +
> > > > >  2 files changed, 49 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > > > > index ed4d0ef5e5c31..ed0b025132d17 100644
> > > > > --- a/drivers/misc/pci_endpoint_test.c
> > > > > +++ b/drivers/misc/pci_endpoint_test.c
> > > > > @@ -33,6 +33,8 @@
> > > > >  #define IRQ_TYPE_MSIX				2
> > > > >  
> > > > >  #define PCI_ENDPOINT_TEST_MAGIC			0x0
> > > > > +#define PCI_MAGIC_VERSION_MASK			GENMASK(7, 0)
> > > > > +#define PCI_ENDPOINT_TEST_V1			0x1
> > > > >  
> > > > >  #define PCI_ENDPOINT_TEST_COMMAND		0x4
> > > > >  #define COMMAND_RAISE_LEGACY_IRQ		BIT(0)
> > > > > @@ -52,6 +54,7 @@
> > > > >  #define STATUS_IRQ_RAISED			BIT(6)
> > > > >  #define STATUS_SRC_ADDR_INVALID			BIT(7)
> > > > >  #define STATUS_DST_ADDR_INVALID			BIT(8)
> > > > > +#define STATUS_DOORBELL_SUCCESS			BIT(9)
> > > > >  
> > > > >  #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
> > > > >  #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
> > > > > @@ -66,7 +69,12 @@
> > > > >  #define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
> > > > >  
> > > > >  #define PCI_ENDPOINT_TEST_FLAGS			0x2c
> > > > > +#define PCI_ENDPOINT_TEST_DB_BAR		0x30
> > > > > +#define PCI_ENDPOINT_TEST_DB_ADDR		0x34
> > > > > +#define PCI_ENDPOINT_TEST_DB_DATA		0x38
> > > > > +
> > > > >  #define FLAG_USE_DMA				BIT(0)
> > > > > +#define FLAG_SUPPORT_DOORBELL			BIT(1)
> > > > >  
> > > > >  #define PCI_DEVICE_ID_TI_AM654			0xb00c
> > > > >  #define PCI_DEVICE_ID_TI_J7200			0xb00f
> > > > > @@ -102,6 +110,7 @@ enum pci_barno {
> > > > >  	BAR_3,
> > > > >  	BAR_4,
> > > > >  	BAR_5,
> > > > > +	NO_BAR = -1,
> > > > >  };
> > > > >  
> > > > >  struct pci_endpoint_test {
> > > > > @@ -118,6 +127,7 @@ struct pci_endpoint_test {
> > > > >  	enum pci_barno test_reg_bar;
> > > > >  	size_t alignment;
> > > > >  	const char *name;
> > > > > +	u8 version;
> > > > >  };
> > > > >  
> > > > >  struct pci_endpoint_test_data {
> > > > > @@ -713,6 +723,38 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
> > > > >  	return false;
> > > > >  }
> > > > >  
> > > > > +static bool pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
> > > > > +{
> > > > > +	enum pci_barno bar;
> > > > > +	u32 data, status;
> > > > > +	u32 addr;
> > > > > +
> > > > > +	if (test->version < PCI_ENDPOINT_TEST_V1)
> > > > > +		return false;
> > > > > +
> > > > > +	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
> > > > > +	if (bar == NO_BAR)
> > > > > +		return false;
> > > > > +
> > > > > +	data = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_DATA);
> > > > > +	addr = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_ADDR);
> > > > > +	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
> > > > > +
> > > > > +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
> > > > > +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
> > > > > +
> > > > > +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
> > > > > +	pci_endpoint_test_bar_writel(test, bar, addr, data);
> > > > > +
> > > > > +	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
> > > > > +
> > > > > +	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
> > > > > +	if (status & STATUS_DOORBELL_SUCCESS)
> > > > > +		return true;
> > > > > +
> > > > > +	return false;
> > > > > +}
> > > > > +
> > > > >  static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
> > > > >  				    unsigned long arg)
> > > > >  {
> > > > > @@ -760,6 +802,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
> > > > >  	case PCITEST_CLEAR_IRQ:
> > > > >  		ret = pci_endpoint_test_clear_irq(test);
> > > > >  		break;
> > > > > +	case PCITEST_DOORBELL:
> > > > > +		ret = pci_endpoint_test_doorbell(test);
> > > > > +		break;
> > > > >  	}
> > > > >  
> > > > >  ret:
> > > > > @@ -887,6 +932,9 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
> > > > >  	misc_device->parent = &pdev->dev;
> > > > >  	misc_device->fops = &pci_endpoint_test_fops;
> > > > >  
> > > > > +	test->version = FIELD_GET(PCI_MAGIC_VERSION_MASK,
> > > > > +				  pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_MAGIC));
> > > > > +
> > > > >  	err = misc_register(misc_device);
> > > > >  	if (err) {
> > > > >  		dev_err(dev, "Failed to register device\n");
> > > > > diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
> > > > > index f9c1af8d141b4..479ca1aa3ae0b 100644
> > > > > --- a/include/uapi/linux/pcitest.h
> > > > > +++ b/include/uapi/linux/pcitest.h
> > > > > @@ -20,6 +20,7 @@
> > > > >  #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
> > > > >  #define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
> > > > >  #define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
> > > > > +#define PCITEST_DOORBELL	_IO('P', 0x11)
> > > > >  
> > > > >  #define PCITEST_FLAGS_USE_DMA	0x00000001
> > > > >  
> > > > > -- 
> > > > > 2.34.1
> > > > > 
> > > > 
> > > > -- 
> > > > மணிவண்ணன் சதாசிவம்
> > > 
> > > -- 
> > > மணிவண்ணன் சதாசிவம்
> 
> -- 
> மணிவண்ணன் சதாசிவம்
