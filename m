Return-Path: <linux-pci+bounces-3736-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8E585A899
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 17:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7543B24446
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 16:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C243F8F5;
	Mon, 19 Feb 2024 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g3jziasl"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2075.outbound.protection.outlook.com [40.107.105.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19313D96C;
	Mon, 19 Feb 2024 16:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359498; cv=fail; b=OptcBu2EoYV/km+TR+TdLQ+L6sk7Un2VVEdAgVGvTg1p3k5tsxclIgaV0Y+EFjAJNxYOLt7pcSy5LLgt1DXkiOt6T42UhsVsRdyd1Jo9UHbGZGJJRqOwyczPX31GsToICx8qif7T28EHJ/86of7jMfY+AOn+oMMPoYArbXRIB+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359498; c=relaxed/simple;
	bh=eNIwgEefApxERcOBdyK8S9TILLsGq1QsHKQZ/1FSlQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NjI0K3fag7Uk7P1FkL5f/d62/Ov5Ws8X1EcKIKNpOf+LpG6NYhF9Dm22prXsTlVA3ddA88/VXBl76lnuABlExAeKfTz5Pm9hMzCxJG40Qx6kzx8reIWaqKbyGXipOzS0NBiWXLMJflGED+9VFz4r29RNZiwqWa/gg+AmSZY8l9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=g3jziasl; arc=fail smtp.client-ip=40.107.105.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZ5K6IQAQlz2U/Q1EZCzbmOT709V6prwFVeQrP071HHGKdY1GoPAO89ekxZCABcO+gKzI9LcYe7be4OLYpWF1s7FZkN9+EmqORuuCpn8EzZdtzc2RVoo51kRI51EIMjdQIB52XwW7IdfBGrrJuPeylP8NsI2oWdF2CBaho2fCqhxBD34m9he8nIeliJtPMFjqOtFMhCM0QV0d5IwRYKJXlqS3a0pJ2/Mqw33zyKZ3yIAp2aA7oh7V4+9ivr4TJfP/nDr8Vd+5f0xnp6jeOuv3RlQiMUBPbtRBoA74q13uXiuIw2Jv2ZejGAws1g/0yu1FwV0n4bKNOkWZelLAgoMXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbqylMgn8jML4Nfxq0+P5spUFuCc9wasobttBIBvY4Q=;
 b=AzfBA1zfbUT9pJ0VxjigfOVR8V3xGSxE/2pEpt9iCH/7M403o9LTueO9tvjZD1eSdy8pGF7zPbncN+DUpWICMqe7pswEJIdm606vAxqcFSZrljbRgYand/8R2n4LJws89GjEi0UmpEouz39NNGZj1E/+Ztvk5H/isUleJcDPvum+Cs+mJQ4+6EOL7Lssi4Tq+zH0oLUIz/kSMesYiBZq4ke24UPVprJmHEnOqm7cbcbD6BaeNKCDOYzayCNVD1A0eSvYUpO11RDBjYfvXx2AT1THYx1vO3AeWS5fEx9PCiL3Mx00QPBQ9+92+mtweNhBQEjTpgPcMQE7YM+kwYKRDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbqylMgn8jML4Nfxq0+P5spUFuCc9wasobttBIBvY4Q=;
 b=g3jziaslZOSORtrF6GkU914Bl378iC0vEPcqllOzkuc8wF9DtBe9qVVxSdIxz+6dKpUJaGTZJxVoRxLsNKUN7qRhTOINiF99OZn+Olq/oLuNAJxS3rLHpnyZ5JH+e9IEsh0qi+zcm4gH5/mSUosuuq4wUk7HVoYIQgITpQOpc4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6815.eurprd04.prod.outlook.com (2603:10a6:803:130::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Mon, 19 Feb
 2024 16:18:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 16:18:12 +0000
Date: Mon, 19 Feb 2024 11:18:03 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, festevam@gmail.com, helgaas@kernel.org,
	hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	robh@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v10 00/14] PCI: imx6: Clean up and add imx95 pci support
Message-ID: <ZdN/OyNpw0Xa7qXG@lizhi-Precision-Tower-5810>
References: <20240205173335.1120469-1-Frank.Li@nxp.com>
 <ZdNvsdao8jbB/52L@lizhi-Precision-Tower-5810>
 <20240219161208.GE3281@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240219161208.GE3281@thinkpad>
X-ClientProxiedBy: BYAPR05CA0081.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f51130-38fe-4082-c3e8-08dc31665eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QNOKJWfOOy3HOywHKJMayUSIFDV8mSsbiIuAoYDuR45i50F1Jtf9v9C0duwJA/VE7nyN2mMnkPLqNaBuKR/6Y3lOej8CaZ27lbq+Ycn7k4bsbJtvqvo76QEjn+Epww3vIe8ix/9HFAjrXVWyEUKfFT6bkWFkbMwdfZ7iheiWadaLyJR0LOFBMr9M3QYAoHkgmykAAHXwkkH3S3Mphtz34Q3Hag2wGENm0eIDzNDQk+run/ZJNTisxjNTIkPOUgZNfOZePLhhDYbQeb5/Nky6mhuOwWO8w9nzOKE0OQtZ/LBbkfaZEcQt38WLrn01BeK2/btfQ1MQNYBE+ScuAZJwjwkMZatvvdqROR7fL/1vFMPCUdUki8AYM1xHdgwXcSgYrDQLrz4V4pm2Ce+4VHRavlyW1ijttPBBLlv9TtjebnOhudmgzaoTJsn0KpVvdWwabj73GyyMgyYbw+/ceJ5RQBOqtmQ3dB6IvDHPFQLvdVoK9RJX5K+GxPisJ6UKF8AMVfo8ZX9H47elF4zo2uJXtt3ffHz7kycoawr4Hn8zdLedK2AwV7sCBAybkSbesgIE5esvXDCeOsg6QIYlZXtP1cd1Nf+vpDbaPLH835frGJ9DqjLfvRqsx9McwyREy6jC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0lydVJjanczN3BFU215QytpS1F0a0tJdXM3ZUIyOWxNMVFUcEZUSU9kRktK?=
 =?utf-8?B?N3paZXRUQUQ1blc2QjA0V2g2cGtJczQ2eUdFSGdRbHROMXMycDlPRG9vNnJV?=
 =?utf-8?B?S1VORkJORktKdHdDSENkVXFVMC9tQWR1YjZZMnQ0dGpOd2NDQ0JWcjE2UGRY?=
 =?utf-8?B?dXpxeFRRbExiKzh5dUM0T3lqTWFOUmRFSHIxQUlVanAyaVlsWVBFY2o4ckRm?=
 =?utf-8?B?VXB2WERMcHdDenlvNStldUJMTnQ4VGhVVDZuV1RvWkNqdSsrVDlkVGpqTjBv?=
 =?utf-8?B?cGtqRzM2N0xYNk5wV3VqSjRaMnkzeHFscEpVRzd2a1BvakgwNlJPMTFKR3Jy?=
 =?utf-8?B?cE5IbzROL2RTT3gvcjdlSXRvaUkvaHI1ZGt0NmM4NW9QZWord21PZ3k3Uy9u?=
 =?utf-8?B?cDI2WDFmTVM3R3laMm9YTiszWnMvV3ZlamxJMmRReW9WQ0ZIZ3EvRFZSaTcw?=
 =?utf-8?B?NUhqNHk3WEZoVTY5YkVKOFowV3FXZUFYa3puZ0tzUXp2aG02NGxlZ2c1WEZC?=
 =?utf-8?B?SW1laUdUQzVKb2tTZUFDbTVJY0Vhbzd0WnFUcjNKaTVMcXVRZElKM2NINGU2?=
 =?utf-8?B?Z2pBM0pOWjhWTnFYeVp4aVFHTlY1NlJaenpXbnp5dGNoQnBZbjhBV3VQTHRK?=
 =?utf-8?B?Ync3SFVGeld4enJRbG5ySCs4WDNKeTRUSkVuL3FDQitad1drSTc0RFJHZjBr?=
 =?utf-8?B?NE9LSWVKK3B4b05rQ0cza0YzcmVmdUtUazZKNFRZTHlHK05oME1xb3VUUWpN?=
 =?utf-8?B?d3lFU0wzb0ZDNUQrSWtkbEVadFV6Y28weDRxNFpYN3pxeGN4NG03V1BybzM3?=
 =?utf-8?B?Q3Q5T0FWWm95MXpNcU52L2x2SlZqdmZzOHRPTjgxZExvTWJVTGt6Y1h6cnI5?=
 =?utf-8?B?cWx5SkVIdjVjV25IWjBad1VEVDZuSFlHbFlWc3BVUE5iNk5MbFlWTjc5UWc3?=
 =?utf-8?B?YjRaRVU4Z3ZhK21HVkxuZUxpQmVSbnR3QXlvWXEwK2F3L3FJZTQ1UEdtUlNs?=
 =?utf-8?B?Yi8zMVRSNkdWSFBYNVhFL1lhaTVURlo2eFh0ZVR4SXJxTmlQQW9Za3N6U3Z5?=
 =?utf-8?B?WkltY3I2WkZmb1ZGSmw3RHJ0ZUwrRE9WTlczRkVIWjFFeVBLUHc5azdLRFla?=
 =?utf-8?B?a3Q1NU1aZWQ0Ti9wMmU4aE9uclM4WXFoVHJySDJPTVRZNi91LzFiRFVYMGJn?=
 =?utf-8?B?SUNsaitTdTdzNWFxYnBNSVFBRHlFVHlweXp0cmdPQitadkxBZGZnRFNFWVJM?=
 =?utf-8?B?SHZUdFVrQ1NudjJEM0x1aGN2TWhtYzROWjBQMXl4NFlWV2VqaGJ0OXJmd3Nl?=
 =?utf-8?B?TkFCWVliZjFuN2xMM2FwSjNMQ05QQUhWMlpiZEp3ZEd5dXZ1aEt0OG5uK0JH?=
 =?utf-8?B?aVYvZGh6WDlVQngwajBOYTFNK0pKOC8yem4yOUh2UEpjcElUd3VLbDQ3dk4y?=
 =?utf-8?B?Y3YvSlZMSFRBaTZZZ1N0YzJMSDcxRDg1NTB1cXJDbkI2TUsxMmNlandINVUx?=
 =?utf-8?B?UGtndUNmU2JCOUFwdUptV1pBWnBtWjUwdW9ObjBWUUV0MVlUK2pRb1IwL21o?=
 =?utf-8?B?QUJlRXpPYWc1TWNzZVF0UXI3dXE1eWY4emowMGlPdTlta2pMbmNKeWNvbDdX?=
 =?utf-8?B?bTM5R0Vza0FlN0J2Wlh3VnF3a3R6VlRwWExoNWVwNi9USVQ1R2Nnb2pBTllz?=
 =?utf-8?B?RHhXTkc3YVdKTXlzOGJnK0xQd3haWUl0WVNvNjQwQU9oL0hrUzd4bTAzbHFP?=
 =?utf-8?B?Y01pRkdlSm54WmRocEVhR2lhRVJwWUpxa2ZpYXpiVS9QYXkzbFNMNFNuNHpC?=
 =?utf-8?B?d3lpeWw4ZjNQWE9MTGdOTGt1c0RUZldEQW9lcjRWRkhFK3IwRzlFa1dEakZY?=
 =?utf-8?B?NzJvUThpc1ZseDFzWmtPbFg4eFZIakIzV0lhc21VRm9mZnVkN0tzek5wQlRP?=
 =?utf-8?B?VGpqOEZtb2VzY29TQ3NTb1dqWC9OMjZldDNEbnBIRnMvZW9Xa05CVjN5QXdL?=
 =?utf-8?B?djhxK2Z5OGpUUVdORW5aTkZLa1FINlBibGJ2TEIvVEo2aHdwMThYd2wyNUJs?=
 =?utf-8?B?ZTkwc2ZMUUJtUVRVbXlFNnZ0NjlNb1NzRm0vdHdqWHJidDRoVFVkQ1oyUXp3?=
 =?utf-8?Q?hNyU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f51130-38fe-4082-c3e8-08dc31665eb7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 16:18:12.6461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJ8Gof48nUrPvGhB9gYse0mDkrB1ZTb0nVol+4HIO7K5WfwPV77fBvx2rOqsB0C6r9iWoMhqavbpHr7dKJ8Vpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6815

On Mon, Feb 19, 2024 at 09:42:08PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Feb 19, 2024 at 10:11:45AM -0500, Frank Li wrote:
> > On Mon, Feb 05, 2024 at 12:33:21PM -0500, Frank Li wrote:
> > > first 6 patches use drvdata: flags to simplify some switch-case code.
> > > Improve maintaince and easy to read code.
> > > 
> > 
> > @Lorenzo Pieralisi:
> > 
> > 	Do you have chance to look other patches?
> > 	Mani's apply EP side change. 
> 
> Even though the controller is for the endpoint, it is still a controller
> driver. So all the patches should go through Lorenzo.
> 
> I only merge patches under drivers/pci/endpoint. Hope this clarifies.

Sorry. It confused everyone. My means was that Mani applied Niklas Cassel's
patches, which cause my 14th patch build failure.

I asked if I need update my 14th patch or applied 1-13 only. 

Frank Li

> 
> - Mani
> 
> > 	'PCI: imx6: Add iMX95 Endpoint (EP) support' need be rebased. 
> > 
> > Frank
> > 
> > > Then add imx95 basic pci host function.
> > > 
> > > follow two patch do endpoint code clean up.
> > > Then add imx95 basic endpont function.
> > > 
> > > Compared with v2, added EP function support and some fixes,  please change
> > > notes at each patches.
> > > 
> > > Change from v9 to v10
> > > - remove two patches:
> > > >   dt-bindings: imx6q-pcie: Add linux,pci-domain as required for iMX8MQ
> > > >   PCI: imx6: Using "linux,pci-domain" as slot ID
> > > it is not good solution to fixed hardcode check to get controller id.
> > > Will see better solution later.
> > > 
> > > dt-binding pass pcie node:
> > > 
> > > pcie0: pcie@4c300000 {
> > >                         compatible = "fsl,imx95-pcie";
> > >                         reg = <0 0x4c300000 0 0x40000>,
> > >                                 <0 0x4c360000 0 0x10000>,
> > >                                 <0 0x4c340000 0 0x20000>,
> > >                                 <0 0x60100000 0 0xfe00000>;
> > >                         reg-names = "dbi", "atu", "app", "config";
> > >                         #address-cells = <3>;
> > >                         #size-cells = <2>;
> > >                         device_type = "pci";
> > >                         linux,pci-domain = <0>;
> > >                         bus-range = <0x00 0xff>;
> > >                         ranges = <0x81000000 0x0 0x00000000 0x0 0x6ff00000 0 0x00100000>,
> > >                                  <0x82000000 0x0 0x10000000 0x9 0x10000000 0 0x10000000>;
> > >                         num-lanes = <1>;
> > >                         num-viewport = <8>;
> > >                         interrupts = <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>;
> > >                         interrupt-names = "msi";
> > >                         #interrupt-cells = <1>;
> > >                         interrupt-map-mask = <0 0 0 0x7>;
> > >                         interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
> > >                                         <0 0 0 2 &gic 0 0 GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
> > >                                         <0 0 0 3 &gic 0 0 GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
> > >                                         <0 0 0 4 &gic 0 0 GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
> > >                         fsl,max-link-speed = <3>;
> > >                         clocks = <&scmi_clk IMX95_CLK_HSIO>,
> > >                                  <&scmi_clk IMX95_CLK_HSIOPLL>,
> > >                                  <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> > >                                  <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> > >                         clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
> > >                         assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> > >                                          <&scmi_clk IMX95_CLK_HSIOPLL>,
> > >                                          <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> > >                         assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
> > >                         assigned-clock-parents = <0>, <0>,
> > >                                                  <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
> > >                         power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
> > >                         /* 0x30~0x37 stream id for pci0 */
> > >                         /*
> > >                          * iommu-map = <0x000 &apps_smmu 0x30 0x1>,
> > >                          * <0x100 &apps_smmu 0x31 0x1>;
> > >                          */
> > >                         status = "disabled";
> > >                 };
> > > 
> > > pcie1: pcie-ep@4c380000 {
> > >                         compatible = "fsl,imx95-pcie-ep";
> > >                         reg = <0 0x4c380000 0 0x20000>,
> > >                               <0 0x4c3e0000 0 0x1000>,
> > >                               <0 0x4c3a0000 0 0x1000>,
> > >                               <0 0x4c3c0000 0 0x10000>,
> > >                               <0 0x4c3f0000 0 0x10000>,
> > >                               <0xa 0 1 0>;
> > >                         reg-names = "dbi", "atu", "dbi2", "app", "dma", "addr_space";
> > >                         interrupts = <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>;
> > >                         interrupt-names = "dma";
> > >                         fsl,max-link-speed = <3>;
> > >                         clocks = <&scmi_clk IMX95_CLK_HSIO>,
> > >                                  <&scmi_clk IMX95_CLK_HSIOPLL>,
> > >                                  <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> > >                                  <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> > >                         clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
> > >                         assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> > >                                          <&scmi_clk IMX95_CLK_HSIOPLL>,
> > >                                          <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> > >                         assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
> > >                         assigned-clock-parents = <0>, <0>,
> > >                                                  <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
> > >                         power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
> > >                         status = "disabled";
> > >                 };
> > > 
> > > Frank Li (13):
> > >   PCI: imx6: Simplify clock handling by using clk_bulk*() function
> > >   PCI: imx6: Simplify phy handling by using IMX6_PCIE_FLAG_HAS_PHYDRV
> > >   PCI: imx6: Simplify reset handling by using by using
> > >     *_FLAG_HAS_*_RESET
> > >   PCI: imx6: Simplify ltssm_enable() by using ltssm_off and ltssm_mask
> > >   PCI: imx6: Simplify configure_type() by using mode_off and mode_mask
> > >   PCI: imx6: Simplify switch-case logic by involve init_phy callback
> > >   dt-bindings: imx6q-pcie: Clean up irrationality clocks check
> > >   dt-bindings: imx6q-pcie: Restruct reg and reg-name
> > >   PCI: imx6: Add iMX95 PCIe Root Complex support
> > >   PCI: imx6: Clean up get addr_space code
> > >   PCI: imx6: Add epc_features in imx6_pcie_drvdata
> > >   dt-bindings: imx6q-pcie: Add iMX95 pcie endpoint compatible string
> > >   PCI: imx6: Add iMX95 Endpoint (EP) support
> > > 
> > > Richard Zhu (1):
> > >   dt-bindings: imx6q-pcie: Add imx95 pcie compatible string
> > > 
> > >  .../bindings/pci/fsl,imx6q-pcie-common.yaml   |  17 +-
> > >  .../bindings/pci/fsl,imx6q-pcie-ep.yaml       |  46 +-
> > >  .../bindings/pci/fsl,imx6q-pcie.yaml          |  49 +-
> > >  drivers/pci/controller/dwc/pci-imx6.c         | 634 ++++++++++--------
> > >  4 files changed, 436 insertions(+), 310 deletions(-)
> > > 
> > > -- 
> > > 2.34.1
> > > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

