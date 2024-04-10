Return-Path: <linux-pci+bounces-6073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB2589FFA2
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 20:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF6C1F22D95
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 18:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38091802BE;
	Wed, 10 Apr 2024 18:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KcaHvXNU"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2090.outbound.protection.outlook.com [40.107.20.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E0E17F38F;
	Wed, 10 Apr 2024 18:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712773026; cv=fail; b=ZkY72tT9ozMte5UAUjaJxK/zRsT8QVW8B4lB4emMOBvQgwOjzt1aE0velLuNYeM96Y6I91U1dAFtwARfVkqeC3S9RVykpLt6XJ3Qjqmj25/PGGpuGzFT3wIRzoO68eQ2yeZa2HnkTVELRFpSg7ozk+jIec3lUTo19BGfIIjZQTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712773026; c=relaxed/simple;
	bh=4cjnBjJKSA1Auiyf2l+MRzcamZB1f+/yk19D8X9NHAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IP2zqGOgi3Cu7KAXFTnHEk0ZnJMulhWCqQvZ94Wpb8mgSPaWsL8dRwu7dkGLsuarcY16g97Q6juW7/DSaOtSWajTSVaPLk86pLw14t/Gcw3DeZ65oloV0MeEZMLOKlxiC2ZIa52qbXmdwmOM6en7tJf/X3EHy8tn8GdviKx41yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KcaHvXNU; arc=fail smtp.client-ip=40.107.20.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2+aFXDlrnHUcMD13qy8yc1hvQhJxEFf0r7Ha6NxHc+/Yu/PcvKsMTj/U/VjAoaVSfvPKLLlq1wQWru01Z6mUtdXXL9WC3tKfMxUSWwEb7ZkvmQFl5DFuJ/nmH+DzFZ5upwPEknfDeGIEPx53hHfrfKLcqYsV5T47qTAekWq/b5HfddZAWjc8LWbA96ph1wBASN5RgGnfeFQcjj6JXGQkcTxxMIvL+a7Yq5GUNwMNmFblH/ANWjTX6xpkqiQaWfp6FXN+8JY4dkYVxrMOHVDIsuzhJSlgNcFdVJnKcODN3REDnUvYKGfAn3XjsUDG6zBHq4LgPfWUOQ3WuBvD690fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrZEQyeUzGiD5v6bVrqP/r9BrfhmxL0Z9F9kw/IcXW8=;
 b=FwmxBUOrT0AzTLLh21Z1T8GPZ1E2DhMLXbHxeovdHl9X4j+SUuW3OBCntPZK9f4XkEePl6hzD+bCcfZ9/87bc9AQggApS8+hTSauYYNq8rEMCZkcdPWMwlpD58bXqaGMe4okkoPcrNqXZYClB7Vbzh6gonG0KuRUrUiRFoyWMGkgeyG/JcODcOP2pJ0c6a9F49rSzLIe9tbHrelEZxCT5H25g7rsKFO038FxaB5MqYXMfoEvSQHKusBiIFfwtUHg8jbRk3sv5K6xI/pkWqJwO6fUoZfQCLwImw7mU72YozXQ5NMzGpqhkYRdZ9dBksawsUjqpd23qBPW39C38fX5bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrZEQyeUzGiD5v6bVrqP/r9BrfhmxL0Z9F9kw/IcXW8=;
 b=KcaHvXNU9g0Yh92/S1QTr5S8+0IJSt5MAzhAmd9AM9XteV+XFqJZeKaAQClmJ+SrkNdr7bprDJpJJV/v0u1htOGDw/K4g/QBml0e8sC9a6yxBvpFPid6uiB+LIURHnilCYcmWvlRiIAPWojhRoSDcoNTceFU7uCq1kwWQIMElgc=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8090.eurprd04.prod.outlook.com (2603:10a6:10:240::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.53; Wed, 10 Apr
 2024 18:17:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 18:17:00 +0000
Date: Wed, 10 Apr 2024 14:16:52 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, helgaas@kernel.org,
	bhelgaas@google.com, gustavo.pimentel@synopsys.com,
	imx@lists.linux.dev, jdmason@kudzu.us, jingoohan1@gmail.com,
	kw@linux.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org, robh@kernel.org
Subject: Re: [PATCH v3 1/1] PCI: dwc: Fix index 0 incorrectly being
 interpreted as a free ATU slot
Message-ID: <ZhbXlOMNxc2nMIW8@lizhi-Precision-Tower-5810>
References: <20240326193540.3610570-1-Frank.Li@nxp.com>
 <ZhPFmFYorWa-sfLp@ryzen>
 <20240410180341.GF16629@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240410180341.GF16629@thinkpad>
X-ClientProxiedBy: SJ2PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:a03:505::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8090:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZVxQajRLxY+B3TQYkngHz+KwjHsxKmiEFaCk0ihDzA0Q9wpwEa9gUaLw/M5R5XtR0z4UpYUnZj6r8YvniseH3wwYEdnxnw0j641z+XXjAuMxQO26+7RgydS+l1Se00SQmy1EBC2aEYAjI73RFC6E0U0wG+J0ov1e/pawo/nZ54BDSdZ4xzuIMxLNc6wzdfx0HIB1Rl7IOuJT89rmFr3qtBiFUfketKlUGW/CNrKKeO51w3EjEX0H3AhywN7MyRjLs/oG8kCp9Zk77fHnhqT6NbLhcIZrqBuFAO6BiDofUbER19iugLGlesGuTUw6f58K2k1+py2kUd3KTe4WqxmZoPBfXhrpsjZ5AKTcE+LXgKxB5nIVoItEQ2sggAmqYsTUevCHwMIwDdF0iwtgqbk8WuJL4jKihHKOSr2VMS71Sp8zvI3rsNybFJbhDeZbflWtM6+W2OA9Wml62tCUgzyM9YsMRTjZsvsOydvqOaSNBH50gqZPENPhA00wRpw7HzVD9l2TS0/xFIOTyf67lwcDq+2JZc5o/HP5byVXPlYrmBy7nw4r4FTFKMveQw3q/jhYBDO6ZHQuFjnc+0SjbedEU60YmQvd0o3//Uw3rZ90FfCDhaMjKBsqFSKKHkgg+B6AuQrESpz77lhKQjwby5F8Q15BQufZoyX9oFTycJyisnI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHAvYUZLd0hWZ2lra1Bjb1pzTHZNekNKZkN2aXRoVkdIK211bytGRVdmamdM?=
 =?utf-8?B?SVczSTJzQURaenc2YVhud1grVkxJcCtWVlN6UzgvVXZYeWFyNDhlTW1WM2Jj?=
 =?utf-8?B?UlFUMVpteXhpRGdYUnZMakF6SCtVazNWSm1HUUkwL000V3IrakFRbEczYTlS?=
 =?utf-8?B?OURQZXZ1Y1NZMlNPZlhrZllWWi9WRjFoRWRjWHZDcDh3Ui9HVFEyQm1UbFR1?=
 =?utf-8?B?cUowYU1GQXFybHFSeDEzNjlWb2JQZFZXb05rOFZ2TTVzUHliWkRXWlFJZjY0?=
 =?utf-8?B?VndFcFFQcVNoZzVFcDZrdjJqSGlpbnpsV2JCT2lrOS9raDU1YmU0d0xRdks3?=
 =?utf-8?B?Vjd1SUl4cDZ0SUlqZ0xURHlsb2N2Mnd3ZnAzdlBnSU0yZ1BJTHNGNXR3K1JC?=
 =?utf-8?B?alJoRXRKOTV2NHlYNm9RbkFESlJjR2tIbTBHMHhpYjV3akZ5UnJ3UzArU2RR?=
 =?utf-8?B?ak8vcVhWcjd6d3VqeDhSMmhzQklZUmV0WHZsMjAwbXV6SDlIWjh5VGdiYkxm?=
 =?utf-8?B?MDBOU3B1TmhuZjlYblpmT0RVMVdnTW5oT1J2RG5UNmFLZWZUYXR3MlgvWmJG?=
 =?utf-8?B?TGsyOTRIL1JqblFrZE1KOXdtaTFXMmdDT3pTYjBmMHI4bmU1TmVLN2dkMHZR?=
 =?utf-8?B?VEZ0K0VaWTdDNnYyUVVxOE5FemlXa2FRc2N0YS9WKzA4ZWw0a0tzTkNDeWZN?=
 =?utf-8?B?TXhXWTVqanJmVk1SVGJ1WFg0d1V5QVBCKzZ0cjN6MVR5WTRUaExqTjJZTlNt?=
 =?utf-8?B?WHpTblRQNGt1SDN3Vitqd0FXWFlYbzZvbkYxTDZsZkwyMWJRaXV1Ylo0MDdm?=
 =?utf-8?B?OTdzWDJwU2lWVTM2VnZjbFNUTXFNcUc1TlhKY3Qyb2c4RGdSc2pBUjZtSnlp?=
 =?utf-8?B?L1pNTmd6dll4dFY3WHVXV20yRW1BTUpjZnBLSEgzY1o3dEhNSjRReUlrM2pD?=
 =?utf-8?B?ZVlZV1FxZTFuZzdXU0JCUXBXalM4NEdUMWhmVDM5STFzNXVna25md3UvdDJj?=
 =?utf-8?B?REUrVXhMWi9OOCtrNWliT2REdHJKYnBlOTczNmJpVDBMTXdQTzFqZ01LU3Jq?=
 =?utf-8?B?RFNneUM4NWVOS0JwdUVacEVDd09DTVRvNWRUMGJKUk90TU9kUHh3MHJpOHN4?=
 =?utf-8?B?MFFxQXZ0WkI4cEZxeG5ZVi9PTENKTUFZVS9EN1FUakdpaVpPTGxVbTJaOThy?=
 =?utf-8?B?K3JpMWxiUE9rZEhWSEF2QlpoSzE5eXArclZmRXpyM1FJSUt0R2VHNjBJdDE0?=
 =?utf-8?B?aHhidjRHTC95SFpwdXd3bVlOeFZjV29SUEo4elY4eEI2TTB3dnZoL2JYd1pp?=
 =?utf-8?B?b2lHb213S2VsTk56eTA1ak13QmNaVmhOZ0tvajc4Q2hoRFM3Y0ZETnI4cGZS?=
 =?utf-8?B?RHVaYXhjS0twd2IrL3owckgrVTdLaDJ1R21EZ2VJcmhKcHdodFJZL0tkYzFr?=
 =?utf-8?B?R3llTXRScmFlU0JpSjVYQTcxL3dwckNxQWp4cEl2WTd6elBnRktDeUtwUFlM?=
 =?utf-8?B?Y1A5VWdUaVBuenMzeHZpTG1JZjdETk4vc2RiTXlEWVFIWFY2Vko2U0NTOXp0?=
 =?utf-8?B?ci9JUkc5aml3TWFBQjNrWmdnK0p6dm56WFE1ZHZvOCtMN3REVDY0dE1QMVU5?=
 =?utf-8?B?Vzg0SnZ6dm1HVGVlN1dKd2pqbjREV1dIUkZVRXdiNFc2N051ZXk3N3JkRTM5?=
 =?utf-8?B?ZnQzb1pVNHNockJ4WEQ1SHlxQ0JGSXNrRW9ZQ09qWE9IeGk4VDNWUkNya0lo?=
 =?utf-8?B?SXIvOExDY3JBT0lkS0Rlc0tTQnlpRnI5cGJBbW56RWxRNEloVkN5TUdzaC9G?=
 =?utf-8?B?RzJWNWhOOC9YQUtldm1QMTZPYUpUY1RXY2oxK2RLRHRxZDNWdER1NkJ4NExk?=
 =?utf-8?B?Q2o3cHV1Qy9mSlg1SzhzUEU2Q2xCNm1TZUFYSTFNa3NuOFVVT21ZMDdzeTVX?=
 =?utf-8?B?QzBLdzVrZGlVMXFzSkVWcHhwU29FVUZuY2x2S2taVXkvYW55am83b1ZYUHRB?=
 =?utf-8?B?d3NqQ25WMEV2c1pxek9oRUVvS2xKMnNiVHVJV0RkV2syWHg0VSt3WXRSK2NN?=
 =?utf-8?B?Lys4VlJHVWRDQ2pWeDZJOXEwdWpnWHVYR3NhZVJOaC9IblpEeVhvOXdTS2o0?=
 =?utf-8?Q?o1tAbSKusS8ajc+Eox4tn6WB8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fac13af-7abe-42fa-61d8-08dc598a6a8f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 18:17:00.8877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIWHLQcv/Ajh7txHr3DR1Gh6OWQ2qhIdr02UXhyiStRBsK//kHEWXIDK+kVY9F/cJXAIk0k8tCr8sw9FYyPtfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8090

On Wed, Apr 10, 2024 at 11:33:41PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Apr 08, 2024 at 12:23:20PM +0200, Niklas Cassel wrote:
> > On Tue, Mar 26, 2024 at 03:35:40PM -0400, Frank Li wrote:
> > > When PERST# assert and deassert happens on the PERST# supported platforms,
> > > the both iATU0 and iATU6 will map inbound window to BAR0. DMA will access
> > > to the area that was previously allocated (iATU0) for BAR0, instead of the
> > > new area (iATU6) for BAR0.
> > 
> > Nit: If we want additional clarity, we could also add:
> > ""
> > Right now, we dodge the bullet because both iATU0 and iATU6 should currently
> > translate inbound accesses to BAR0 to the same allocated memory area. However,
> > having two separate inbound mappings for the same BAR is a disaster waiting to
> > happen.
> > ""
> 
> Since Bjorn asked for the above info, it should get added.
> 
> With that,
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Mani:

Do you need me rework patch? Or you can handle it by yourself when apply?

Frank

> 
> - Mani
> 
> > 
> > If the maintainers feel like this additional information is important, I think
> > it could be added while applying. (But I also think that the existing commit
> > message is detailed enough to be applied as is.)
> > 
> > 
> > > 
> > > The mapping between PCI BAR and iATU inbound window are maintained in the
> > > dw_pcie_ep::bar_to_atu[] array. While allocating a new inbound iATU map for
> > > a BAR, dw_pcie_ep_inbound_atu() API will first check for the availability
> > > of the existing mapping in the array and if it is not found (i.e., value in
> > > the array indexed by the BAR is found to be 0), then it will allocate a new
> > > map value using find_first_zero_bit().
> > > 
> > > The issue here is, the existing logic failed to consider the fact that the
> > > map value '0' is a valid value for BAR0. Because, find_first_zero_bit()
> > > will return '0' as the map value for BAR0 (note that it returns the first
> > > zero bit position).
> > > 
> > > Due to this, when PERST# assert + deassert happens on the PERST# supported
> > > platforms, the inbound window allocation restarts from BAR0 and the
> > > existing logic to find the BAR mapping will return '6' for BAR0 instead of
> > > '0' due to the fact that it considers '0' as an invalid map value.
> > > 
> > > So fix this issue by always incrementing the map value before assigning to
> > > bar_to_atu[] array and then decrementing it while fetching. This will make
> > > sure that the map value '0' always represents the invalid mapping."
> > > 
> > > Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> > > Closes: https://lore.kernel.org/linux-pci/ZXsRp+Lzg3x%2Fnhk3@x1-carbon/
> > > Tested-by: Niklas Cassel <niklas.cassel@wdc.com>
> > > Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
> > > Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > 
> > > Notes:
> > >     Change from v2 to v3
> > >     - Add impact in commit message
> > >     - Add mani's detail description
> > >     - Fix Closes link
> > >     
> > >     Change from v1 to v2
> > >     - update subject
> > >     - use free_win + 1 solution
> > >     - still leave MAX_IATU_IN as 256. I am not sure if there are platfrom have
> > >     256 ATU. Suppose it only use max 6 in current EP framework.
> > >     - @Niklas, can you help test it. My platform become unstable today.
> > > 
> > >  drivers/pci/controller/dwc/pcie-designware-ep.c | 13 ++++++++++---
> > >  1 file changed, 10 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > index 5befed2dc02b7..ba932bafdb230 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > @@ -139,7 +139,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
> > >  	if (!ep->bar_to_atu[bar])
> > >  		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
> > >  	else
> > > -		free_win = ep->bar_to_atu[bar];
> > > +		free_win = ep->bar_to_atu[bar] - 1;
> > >  
> > >  	if (free_win >= pci->num_ib_windows) {
> > >  		dev_err(pci->dev, "No free inbound window\n");
> > > @@ -153,7 +153,11 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
> > >  		return ret;
> > >  	}
> > >  
> > > -	ep->bar_to_atu[bar] = free_win;
> > > +	/*
> > > +	 * Always increment free_win before assignment, since value 0 is used to identify
> > > +	 * unallocated mapping.
> > > +	 */
> > > +	ep->bar_to_atu[bar] = free_win + 1;
> > >  	set_bit(free_win, ep->ib_window_map);
> > >  
> > >  	return 0;
> > > @@ -190,7 +194,10 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > >  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> > >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > >  	enum pci_barno bar = epf_bar->barno;
> > > -	u32 atu_index = ep->bar_to_atu[bar];
> > > +	u32 atu_index = ep->bar_to_atu[bar] - 1;
> > > +
> > > +	if (!ep->bar_to_atu[bar])
> > > +		return;
> > >  
> > >  	__dw_pcie_ep_reset_bar(pci, func_no, bar, epf_bar->flags);
> > >  
> > > -- 
> > > 2.34.1
> > > 
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

