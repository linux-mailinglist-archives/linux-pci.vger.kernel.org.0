Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BC57D1575
	for <lists+linux-pci@lfdr.de>; Fri, 20 Oct 2023 20:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377953AbjJTSHS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Oct 2023 14:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377925AbjJTSHR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Oct 2023 14:07:17 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BF4D55;
        Fri, 20 Oct 2023 11:07:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZSEPasjWStYQGD/2ebHKey4HpwSGapIHaKkd8VhJ4uDydR06XNgjwezHLsHJOjNFQXz+iUTCuRIzY2pR547dB+tqvETNB2EHJhlVv7S8KcQ6FiQxSLC0cSTVCpiGaE6f9uE+VTov7L9ZVNwL1g9ryCZGWmdbWDIuwzhZq34lcKng+zMEITY0y/8Kk7XNd099QZe2HzJM7D12p2xGyHg69olVBUc/mHyACSRtxN6/sPUgSE/XjQ8VRGhrxaADSj5YGmZFJDLj/eK/nmfFnK/+NQr6Ow0Ja8FnS/lBhso/dUPbp4Ukb/bU4gvvUugPxYEds/kvZwvDq2R1MdOVyti1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+Tb430DUqMq2dqUXX7UUIMkGDZWLbNdqgMJvB/K3Uo=;
 b=BP0HioeKXmI4qhq0MmT4GA+x5cPmKYC72Ul1c38dq6ALASOKMaUsicchSWOiVMeFqy3rE6xHrUuz5e9Nf0ath/vWwLp6vomfWdxAreVXXPLj3xLVScfqRA2nCN+tehMA1+62uImmfAijMxv2np1dlURWYfxHnuNFiIEErMD+5D6wjcDXrVosNoZ9ol94CJGYgmiZhNBs2BEaI7CnihkX2CNuD4dHcaYL23EicZlav5M/QtB+/OJyTJwxQeNQa4XUzF0Hsp8x4r0AzOJxv13TOLU8sSXm+ZXMT+P1RM3Cgnz2Ovr8/QCEesIzVEtNUV18LGJG4pgaJT6Ap/PVImqc0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+Tb430DUqMq2dqUXX7UUIMkGDZWLbNdqgMJvB/K3Uo=;
 b=RedjjzEXdHENl/tbPRCXkyVQ6OTmjrdigxtqvWCusziIzkmPuR3mhXumjP47zapODJQ1MpEbpPd/0pwhHXLtktD2HpMPZJXDrzpdCWvHeWayoLrvhuIR3q5ApnzTltC9Nm5xergVMuBofu49ht/ZA0iZOYNXbNf8jjsAPddVXMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7729.eurprd04.prod.outlook.com (2603:10a6:20b:24c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.10; Fri, 20 Oct
 2023 18:07:12 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 18:07:11 +0000
Date:   Fri, 20 Oct 2023 14:07:02 -0400
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
Message-ID: <ZTLBxvM/qNGw/FLd@lizhi-Precision-Tower-5810>
References: <20230911220920.1817033-1-Frank.Li@nxp.com>
 <20230911220920.1817033-5-Frank.Li@nxp.com>
 <20231020175304.GC46191@thinkpad>
 <20231020180139.GE46191@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231020180139.GE46191@thinkpad>
X-ClientProxiedBy: SJ0PR05CA0066.namprd05.prod.outlook.com
 (2603:10b6:a03:332::11) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM8PR04MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: cc2bc133-4d72-4d3a-0822-08dbd19761ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nmyfmsZUtBp6VQvvbC1a8xVspif4b++ZSZ04PkHWsRNnXuSyCxDvn0JfgRU4AWCnHpFlKV2AOYS7kILszjZi7DV0aaFTV87n7K1rLck2wFlAA8yqhMmm12trbRH4Y8dehMyH08AOmS+aYXmoLn0Yeb0THqYNnJFUxIYbKt37BxFHMcZDA5bsBSfwulqNPxaooeTWRRcWMXiBETFKX/I4NJoMsNP9z+iWy6w25fDplCSqIS1orfj7HpDStK9C/hSjEnMguJfeDMdcGBylxxqvPchlcWXc5hnerKwRgQm95NpKLRanAETAS4yhn8SzuxVSJ9hMBH5mcyWUjb+jxWFIoVPN4v2wG9IWGYPiimkX2kJr/cWJCvtH1SQ9lsOaZIgf3OQGcsoiJWjWllsZZ92XcYCcCnnApkNsYUI76MfnkjvwZLCkbj+TlbVohIQi8aoxeWZPV80PSAfzbu3397pP6HJtmQdq4pnNwzZvPdzSNbobqKfhHC8Un4JKpJyLEllLAIgjtyoXbgpogzBomeCngwRPXfXrW3dEk73RoEk/w6MwMq4nRFY67ZFOaLePVuO0KtsYH7pnPmc8V+d8BQDUs9Z06Ux9qCPMdB22C2ELHuozrCTKbUpYlHjPfLy7+Xn5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(39860400002)(136003)(376002)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(33716001)(4326008)(86362001)(5660300002)(8936002)(8676002)(52116002)(6506007)(6512007)(9686003)(7416002)(2906002)(26005)(6666004)(38100700002)(316002)(66476007)(66946007)(66556008)(6916009)(478600001)(6486002)(38350700005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z29OYTBkZkJYRjkwTDhYdzlhdVVWQVUzdkcwQ1dYdWFQbC9lZnd4OWgzNFpk?=
 =?utf-8?B?RXpoMVlTSVYwWnJva2tlU3pSR2hwQzdvY0d0T2pXand5c0l5Z3JGZjJ1RDFT?=
 =?utf-8?B?YnhaOWZZelRDMStVclZkd3k1WEpPZ0lVdEI0bmhnUVVBNWJIVnA4NzBuaDBT?=
 =?utf-8?B?TjJIclExRGtiWVJPcEJyY3Z6cDlNUjF5Rk1URC9Dc0FZUGdHalJXMkhTbXJz?=
 =?utf-8?B?UU42VmRwMmlQR0p4eUJ6SEZrUnJJUFoyczI0K3pLeUVhVHlwTkdFS3NkTGZY?=
 =?utf-8?B?WlkyWWxsRkpwcS9SdGJjWC9IS3lOSUU0UC9BZm9BYmJ1bjJSTE0xZ0F3Vytp?=
 =?utf-8?B?L0NBVHlhd2RzSlBBTkFRZzVaVTJDOTU0L1RvMDJLdEhrQnB1ekF6STlrdDFq?=
 =?utf-8?B?YVVIMGRDYVVUVkFaZmg4M0ZkcWM1NU5KWUlzSWhtZHhvOWlWZmNhb3lMWjQy?=
 =?utf-8?B?WEdYZTUvS3NxTGVRVlNpMlM5MHRXMjB1K0ZPVEJKUEY2ZWIxM3VxUWp6K1dR?=
 =?utf-8?B?MU5yOGpCMVpHVWoxcDVMSW5vSXgwSTFMQnJJNEs5eDR1SlBrRWJBRElSY3pQ?=
 =?utf-8?B?amlmS3JUaEYzQU52azVyZ0llTlJrdzk3Vk9GN25DK3hDdG5Dd3FPcU10SWU3?=
 =?utf-8?B?RHIwY1pwSWFuVU9TSGVWWHNycmFlcGpSWjlaNUlzYUl2ZnAvZkUvTTBmTUpq?=
 =?utf-8?B?ZWxpNHY3RzAxZkZNNFFuRlk3U2Q3d1lQNzUxOUdTaUQ4MlN3R2NsT2ZreGJ3?=
 =?utf-8?B?bzd0aEg3MkcxM1dDSW80Q1lPQ3BXeTRwNnhRMVBlRi8yNkJTQkFRK2pJaEpy?=
 =?utf-8?B?TjJRZ21zSkxmZTdPZmhiZ2ZYcjVRaGVNZmdFd3ZUaDcyeDlqQWtCUjl4Wk5X?=
 =?utf-8?B?cHNlb29KNmo5UC9ld0g1VHAzQWpMbGJBYXF1Um9uM2dHOVBZWXM4eUlzZS9J?=
 =?utf-8?B?VUdmNWJZV3ZuNHZEUHNaMmt3S0ZVOENwdFBoODVCUGNueE1VNGFVYzdqdXda?=
 =?utf-8?B?ZHVGZndlUGRkeU1lSlZMMFpyaWVTMXo5QjQzRnZjSjNyUkVZV1JxMk9odzY2?=
 =?utf-8?B?NUJrelAzYUF5NjVQd0lPWExCc3krU1ZOSWhiNnJjcW1aNlNvc0M3TWdKd0x6?=
 =?utf-8?B?dGNYVzJlK1NmdE9GbG9JMDl6MW5ZcUZVZEVLUFovbitFQjF5V3NmTkUvMzhr?=
 =?utf-8?B?aytlZnBuamdMRGI3eGJ6UlluQ1QyYTQvYmMrMFdkbkpHSzh4WGFnZTBRUjEv?=
 =?utf-8?B?Sy9oc1gzRkVtN1U4K1V6RVM4WkZmVFc2SGZaNGpZdlpPaERVQTR1L2Zjd3h4?=
 =?utf-8?B?TExTTkpWNFpiSmd2SkVRZHFPdDB6dGZGM1FTVDBKL2M4cFRMVWdCL3R4TUQ3?=
 =?utf-8?B?MzhvSjdlWkFuNUZlby9MMkwycjZ4T21iVUFhYW9ockRGYklTbmd4bmd1M2ZS?=
 =?utf-8?B?b0hGTkxlUXZkelNsWFJkbU93bldaaTFaajRyKzFUb3JadnNPTEZLVGFrcG5h?=
 =?utf-8?B?Uk9TWXUwMURVR3ZXU1BKeWMreDdZaThPUlpaUVpkK1VHTVE5VmxUSFYwWjZR?=
 =?utf-8?B?RmdsVGpHM1FuMjVyNTdpanJBTlFPTmVSUWZEcmpKVCtLNmlOdDUrSDRNRkwy?=
 =?utf-8?B?TXhHbDVVVVdXYXRuNUZWcFpHUHRkbHBQdFBIZXJWb2JBNGlDOHU0eENKanE5?=
 =?utf-8?B?c1dGaTlCL2M5NmcvNlNRdmJscDlXdzlLMWpvenNDanpORjc4TWMwQ1lkVUE4?=
 =?utf-8?B?RTZVSUY2SlQ3Zm9SMkxMWTZTcVllaXg3bVBpNkVEVFJFKzV2VjNCT282UTRM?=
 =?utf-8?B?REdDK0E1MmxFN1ZPYzZEdzlMeElOSy9DMmRpRjJvZXFIMlllanNhRHVYMnNP?=
 =?utf-8?B?bFl0TlllOTdnN1lxTC96eldyTDh2OTk0RVJGMjE1cUFuRVh1YUF2VDBHempl?=
 =?utf-8?B?bHRzS2RacXN0YlNXYTBXTVBVZkpjcndrTlBYUGlIS3MzNDFKYnpodmI0UjRT?=
 =?utf-8?B?YmpLMGI3NnhyRVJwYXVhelhrbnYzL1kvMFFqajJyWEdhU0lKQk85ZFlIaXZK?=
 =?utf-8?B?RkhORGs4d0ZLcTNKQjhIdTFZSUlVcUJGQjMzVG9yZDY2VmR2OVphejRUTXR0?=
 =?utf-8?Q?y903sefs3PQqox0R5lF0QQips?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2bc133-4d72-4d3a-0822-08dbd19761ea
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 18:07:11.9151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERt1NdPLQIqqKNgJXHBsM+AiGnfh746pdKyxc5FJgGKQW2FAMxjsoYuBaE3OigKjEWnRXsukRkYp5WmyedRcJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7729
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 20, 2023 at 11:31:39PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Oct 20, 2023 at 11:23:04PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Sep 11, 2023 at 06:09:19PM -0400, Frank Li wrote:
> > > Using bit 0..7 of magic as version number in pci_endpoint_test struct to
> > > support older driver versions. Save to 'version' field of struct
> > > pci_endpoint_test to prevent reading non-existent address.
> > > 
> > 
> > Since both drivers are in the kernel, I don't see a necessity to maintain
> > compatibility. Does it make sense to load drivers of previous kernel revision
> > with a new kernel?
> > 
> 
> Shoot... Sorry, I completely forgot that one is EP and another is host. Yes, we
> do need to maintain compatibility.
> 
> But can't we use the doorbell register contents to determine that?

Doorbell register is not exist at old EP driver. If old EP driver register
size is 64Byte,  doorbell register is 64 - 68.

Read unexisted, or unmapped space will cause kernel dump or other side
effects.

Frank

> 
> - Mani
> 
> > > Add three registers: PCIE_ENDPOINT_TEST_DB_BAR, PCIE_ENDPOINT_TEST_DB_ADDR,
> > > PCIE_ENDPOINT_TEST_DB_DATA.
> > > 
> > 
> > This patch is not adding these registers and not this driver also. So this
> > statement is wrong.
> > 
> > > Write data from PCI_ENDPOINT_TEST_DB_DATA to address from
> > > PCI_ENDPOINT_TEST_DB_ADDR to trigger doorbell and wait for endpoint
> > > feedback.
> > > 
> > 
> > You can reuse a part of the commit description I suggested for previous patch.
> > 
> > Rest looks good to me.
> > 
> > - Mani
> > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  drivers/misc/pci_endpoint_test.c | 48 ++++++++++++++++++++++++++++++++
> > >  include/uapi/linux/pcitest.h     |  1 +
> > >  2 files changed, 49 insertions(+)
> > > 
> > > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > > index ed4d0ef5e5c31..ed0b025132d17 100644
> > > --- a/drivers/misc/pci_endpoint_test.c
> > > +++ b/drivers/misc/pci_endpoint_test.c
> > > @@ -33,6 +33,8 @@
> > >  #define IRQ_TYPE_MSIX				2
> > >  
> > >  #define PCI_ENDPOINT_TEST_MAGIC			0x0
> > > +#define PCI_MAGIC_VERSION_MASK			GENMASK(7, 0)
> > > +#define PCI_ENDPOINT_TEST_V1			0x1
> > >  
> > >  #define PCI_ENDPOINT_TEST_COMMAND		0x4
> > >  #define COMMAND_RAISE_LEGACY_IRQ		BIT(0)
> > > @@ -52,6 +54,7 @@
> > >  #define STATUS_IRQ_RAISED			BIT(6)
> > >  #define STATUS_SRC_ADDR_INVALID			BIT(7)
> > >  #define STATUS_DST_ADDR_INVALID			BIT(8)
> > > +#define STATUS_DOORBELL_SUCCESS			BIT(9)
> > >  
> > >  #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
> > >  #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
> > > @@ -66,7 +69,12 @@
> > >  #define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
> > >  
> > >  #define PCI_ENDPOINT_TEST_FLAGS			0x2c
> > > +#define PCI_ENDPOINT_TEST_DB_BAR		0x30
> > > +#define PCI_ENDPOINT_TEST_DB_ADDR		0x34
> > > +#define PCI_ENDPOINT_TEST_DB_DATA		0x38
> > > +
> > >  #define FLAG_USE_DMA				BIT(0)
> > > +#define FLAG_SUPPORT_DOORBELL			BIT(1)
> > >  
> > >  #define PCI_DEVICE_ID_TI_AM654			0xb00c
> > >  #define PCI_DEVICE_ID_TI_J7200			0xb00f
> > > @@ -102,6 +110,7 @@ enum pci_barno {
> > >  	BAR_3,
> > >  	BAR_4,
> > >  	BAR_5,
> > > +	NO_BAR = -1,
> > >  };
> > >  
> > >  struct pci_endpoint_test {
> > > @@ -118,6 +127,7 @@ struct pci_endpoint_test {
> > >  	enum pci_barno test_reg_bar;
> > >  	size_t alignment;
> > >  	const char *name;
> > > +	u8 version;
> > >  };
> > >  
> > >  struct pci_endpoint_test_data {
> > > @@ -713,6 +723,38 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
> > >  	return false;
> > >  }
> > >  
> > > +static bool pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
> > > +{
> > > +	enum pci_barno bar;
> > > +	u32 data, status;
> > > +	u32 addr;
> > > +
> > > +	if (test->version < PCI_ENDPOINT_TEST_V1)
> > > +		return false;
> > > +
> > > +	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
> > > +	if (bar == NO_BAR)
> > > +		return false;
> > > +
> > > +	data = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_DATA);
> > > +	addr = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_ADDR);
> > > +	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
> > > +
> > > +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
> > > +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
> > > +
> > > +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
> > > +	pci_endpoint_test_bar_writel(test, bar, addr, data);
> > > +
> > > +	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
> > > +
> > > +	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
> > > +	if (status & STATUS_DOORBELL_SUCCESS)
> > > +		return true;
> > > +
> > > +	return false;
> > > +}
> > > +
> > >  static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
> > >  				    unsigned long arg)
> > >  {
> > > @@ -760,6 +802,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
> > >  	case PCITEST_CLEAR_IRQ:
> > >  		ret = pci_endpoint_test_clear_irq(test);
> > >  		break;
> > > +	case PCITEST_DOORBELL:
> > > +		ret = pci_endpoint_test_doorbell(test);
> > > +		break;
> > >  	}
> > >  
> > >  ret:
> > > @@ -887,6 +932,9 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
> > >  	misc_device->parent = &pdev->dev;
> > >  	misc_device->fops = &pci_endpoint_test_fops;
> > >  
> > > +	test->version = FIELD_GET(PCI_MAGIC_VERSION_MASK,
> > > +				  pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_MAGIC));
> > > +
> > >  	err = misc_register(misc_device);
> > >  	if (err) {
> > >  		dev_err(dev, "Failed to register device\n");
> > > diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
> > > index f9c1af8d141b4..479ca1aa3ae0b 100644
> > > --- a/include/uapi/linux/pcitest.h
> > > +++ b/include/uapi/linux/pcitest.h
> > > @@ -20,6 +20,7 @@
> > >  #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
> > >  #define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
> > >  #define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
> > > +#define PCITEST_DOORBELL	_IO('P', 0x11)
> > >  
> > >  #define PCITEST_FLAGS_USE_DMA	0x00000001
> > >  
> > > -- 
> > > 2.34.1
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்
> 
> -- 
> மணிவண்ணன் சதாசிவம்
