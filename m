Return-Path: <linux-pci+bounces-16259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDA69C0AD7
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 17:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900EB1C22A20
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 16:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23E42144DC;
	Thu,  7 Nov 2024 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U+/Fkqqg"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156C521620A;
	Thu,  7 Nov 2024 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995731; cv=fail; b=pDn58y+/PV1iEXIKw7eHFYFN+FhImKOlq76PG/of+8HyGKiwmxyeZX1tmW5XzVmEeuyNoYpaTeGp/4WJPDdVjaxoWtoC+BS4//dUqqiIHSCxschCom9r9JNLtXqNkYbb0w59Vn0t+2K5tQcXkoeNboyT5Kbrl8d9DyttZ8sBCz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995731; c=relaxed/simple;
	bh=+yFYNdx79ul1SIlXb2JSQuY7yM3pYafXd2C9Io62ddA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mPDEpHF4koHT0zTY5/lk3Eol2w5WGCg6ZvV6y50hN3/RiEz2wzjjfRG/vhBTU4E0/DwIUUdzcWQJLw/nGwHarzBdSq+jToBsplE309EcMZjMTtaN/ipINYVOfYl2d/PvShHgyS5Q9qS4TCuuBwRkrh2+jWftAojITG5NtmKVl44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U+/Fkqqg; arc=fail smtp.client-ip=40.107.20.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYNAbPgPjSVzVsetq+D53fcud8kqpBneR6LzXLtBRYvKMhhiP6emJrgifGqKOVtDfyFFPU6PSYT1uaL1tLFgKT8TmDKSDfeYqFljvkilCyCncpPNbIMukgwJHn+Q6e3fg02tdXG2EhWK5VgIjvQX5DlgsnnJa8uaAyxCx1NXVW5b3423MibjvG9ECcaaegao+N7RFjQnVFOLSm1ez+BYgWW3YZ57iz0jS/qlxYdXtp3+lzL8sbTJ7PYK0giSxL3Uq/0h4afkRHaspqAlaXXeERxyLzWz62oBva2zXcPd9RICqIjx9dNW/TM5zFRCpeR69H7SdIr/Y0ZmtV9s9T7BJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HobjXl4a9jMTRiGBsCd2/ADrwPnf9Ccr1ZNfNiXaPD8=;
 b=BjtiN5VQB+l3J2ueROmjr++iwjDdq/T8WVRmjtmi4VW4BI/EG5yGlq4l8frjKcWVjdlK9247wRIU0FZOmWwLCaRa/z9wjovddmxqj0ui448xLgCUSyMdkAnOLAbvrxINOe8JYoZmqbUkHLgB6MHgTvmS1vD+tzrlZDVBsTwcmXKtu+6y34AOtyUh4qYi4ApIryQVJbhijNJBqYKlKRMX6lWcXA5QHKVzhPor7/9bcBOfhM/Tite4oQd91ZTAS7SvR1msMWqgbMCkhf3VdjVW3dyPaoxjF7QDyGuI3uEQnyi1mV44mVhUEzk2JOlzL7b65l7oQ3g/G2Y0NLshsFLmXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HobjXl4a9jMTRiGBsCd2/ADrwPnf9Ccr1ZNfNiXaPD8=;
 b=U+/FkqqgABZw2NGWW4D5o6R6UU/NBTVaBdBI2YJk7d9MtAZmDtcMPAa5nFaRXM5CLUyHUUH6ZVLVX4v4gd1F+63ioQXh19ogyUbcfe8aRvPNu8ej5f5BOEV60f8C25KWYUR8dzUAAdkHzj7ynvqJtNgkBXlDXksSML2+GZdDFAKzuXAxcDyCudTx96sqmT/PsPz/CnkdGpsJxGRz5bjBFlnH2n2OvznKGTcN3ovyaPRyd/j6G8bfecYqZcIZYejjCS8Dvmikf+fD9K6f7FEis7kDujsp5tECEJ4PO1D6IVBMXdCqz+VfIZu5R4X0LPYsb3nCbWuwfqUXoW+mZjintg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10803.eurprd04.prod.outlook.com (2603:10a6:150:227::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Thu, 7 Nov
 2024 16:08:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 16:08:45 +0000
Date: Thu, 7 Nov 2024 11:08:37 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, jingoohan1@gmail.com,
	bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, imx@lists.linux.dev, kernel@pengutronix.de,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Message-ID: <ZyzmBQlt5WJ+D9xM@lizhi-Precision-Tower-5810>
References: <20241107084455.3623576-1-hongxing.zhu@nxp.com>
 <20241107111334.n23ebkbs3uhxivvm@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241107111334.n23ebkbs3uhxivvm@thinkpad>
X-ClientProxiedBy: BYAPR02CA0030.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::43) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10803:EE_
X-MS-Office365-Filtering-Correlation-Id: ebcaba34-f0cd-48de-486c-08dcff46749a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEhKQXl3NlkrUGJ2b2EvZ05IdUFUbkxVaFlDNXQ2bHlKSHFaY3lWQ1JSdjNj?=
 =?utf-8?B?dU5hZkRpK0IwZWV6WEtyQTY3QW80NFZEYkdZaEVSUTN3amxXVW1Wa0NxVXdJ?=
 =?utf-8?B?UVp1elNUSnowZFRDamgrR2ppcjA4bStzSEx6WEdoM0I1cE01N0JrR01DMC9o?=
 =?utf-8?B?V1FEL1ZvcHlydXd6Q0x3cU8zRTRYZDE3YlpPNlNsWmVwR2pZOEd1L1JZL0hV?=
 =?utf-8?B?TDFGbVoyQnlWQXBxWFd2eGJZME42cGFwV3lTUzJoUTZSUnhkaVc1U240QVZH?=
 =?utf-8?B?V1ZIV2tnbUc3bk1zSUh0MitKL0tDNi9xczd5OWJUZ2VQQlhFZjFNRGNmelRD?=
 =?utf-8?B?NFBRU2poLzVodnJaalNvZG5COGNGRmZWY095eGlyWWlsVjNmM0FzQWVkcjN1?=
 =?utf-8?B?ZWFnV2JTeEtNWnorWXlsWFhyYjF1a2N2SktlQ2wzUTRBU3BqUVRJVVZMUHdo?=
 =?utf-8?B?VGQ3WlBSWHFlZXh1ZkVsWk1BdmsvTUZLMWhEN3c3OVZEc01iR2hpU1dGcEE5?=
 =?utf-8?B?U1Z4QzVEOWcwYk1RQ1FNMXZSWlprbk5aSEpHWWpJS09ZaEdHazBxOGZqQVpp?=
 =?utf-8?B?VjZjd2ZrZWNjTUM2OXR4cEtXNFZMNWZxQzV2ZzRxOTRTM0txS3FEa3RTMXR1?=
 =?utf-8?B?UVpCSkxxdHRLZERTcDB4WWNYTFZLUWRjM21zdzhabmRsazB4TXJKYkxJZUwz?=
 =?utf-8?B?YTFCeUVrU2I5ZHZlRS83N1p6ODdKTzhQbkh5ODEwWW5TQjJRK2NJR3BlazJ0?=
 =?utf-8?B?ZE9DR1FjazA3cit0czZiMU1obDJ0ZmRSSFQzSENwVWg0QktpUUdEYlRuSW8v?=
 =?utf-8?B?TDNxNWMrRzA4N0ZPYTA4aHUyZ0tNbldpK3F0Sm9Id3ZlL1NSQ0F6YUFMbXpY?=
 =?utf-8?B?bFdIanpOeXB3Y1RJOG9GWXB0bW9kOTlsS2YvRkg2MDlBMTIrZitaTE8vR0Rq?=
 =?utf-8?B?cHR6YVhXNU96ck1sZkhRbGVBZ0JLMEx3SnZwNkhmSHhRdE8zQituQXdJSWNQ?=
 =?utf-8?B?ZjNJbGpvYVRlUDNmYS9qZGhSdFF6ZEhsSi9SZDVVMmc2eU1qaTlJOFRaVlhv?=
 =?utf-8?B?TGF2Rk4wUldaMldJTnR6Vm1vOFkzK3hGSis3ditIQnFublR3aGt2NkpWVzRy?=
 =?utf-8?B?bm1xMDZ3QWdLVVdMNHA4cng3N1ZpaHE0ckJjNCtyZk9qVm5aYW0zOFY0cnVj?=
 =?utf-8?B?M0VhbGZRbTFwNkk3Rmc4TVZlRzB3MzlEZ2Z1R29ya1N4VWtnOW8xSmpBT1po?=
 =?utf-8?B?ekZKYW9yK0hHMHU2bk9vWXRRbGFZUUk4WmhIWVV0UjhyVVE2SlpYMktNMFBq?=
 =?utf-8?B?RmxBUlV6K0N2czdMWnhyUVhkaGZkQmlnb0FFWWdGQ2JUT3dCbHBKdnRpU3hL?=
 =?utf-8?B?Q1BwZy9BczA0VzQ2clhLWEJ1UlJUZ04yVk54b3lHZUs0K0pNS0dvYXVMTnYx?=
 =?utf-8?B?YmM2NmZET3JGdlVISmxqaTNRTDh2RVNUQzByaG9ZeVV1RVZuSzVnWkQyczFa?=
 =?utf-8?B?WHZ4NWRLOE5SUkEwUStDcXFqaFFIRkEzRXdmak9OYXYxbTlvRks1U3l0ZGE1?=
 =?utf-8?B?aHp1cU1xN0k2TitrWWM5RVNkamh6NzVoM1N5RVBWMmJiamI1UU9HdkR1MmVH?=
 =?utf-8?B?c2xRWTMrcTR2ZEJMRW9Pb1pEQzdoS2h2bjJ1NFZOM0psWVJBemhQb2VUR1hx?=
 =?utf-8?B?VDNQdEdieUpxVFdtK2NLN25VbHpJN094R1lLRGpUUWJxSldFbW1TQ2Q4aVYy?=
 =?utf-8?B?MUNZdm9ncm5SL1haSThJZ2l2S2Y5VCtmV0xZbE5vRTMycDI4dmlrUkxhdlBv?=
 =?utf-8?B?aTNlc004ZU1uUE12TlJnVStHVURlYVZMNkRHSEhHdWZUZ0hlRXR5aERxSjBj?=
 =?utf-8?Q?HbOQBnxGuG5Y7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Kzc0Y05PdUJKZkxOQzZTcDRtRjlKRWxybnFZenZhUzFNeHc5c0d4aGFxNTN2?=
 =?utf-8?B?VDVTVk5qRHpaZ3ZmZU9XK1g2cG1hbzRTTTBOeVUyaGJpTUFaMUJ0SEw5OE1T?=
 =?utf-8?B?c1R4STZmZHlMc1ZFWDA5UEdndks0UmRDdXdSZE9OQjF5cmtTS3cxcFBnMGZn?=
 =?utf-8?B?Y3hGUkMrcHk1ZmxFZmZQbUJ0bHF5SVVKSU1ueitXMVFhUVZ4NXN3ZFRUYktu?=
 =?utf-8?B?VXRjMXkxazNtcWd5YjFnUGJxV1VGTDdwYnppR0hEMmdqSTdXb0VxUGFMNTN4?=
 =?utf-8?B?cG0wbWkrbWlkaTlkaURnNjFJaTFKNlNHbEgrTDZnclhjOFk4cFdITVFBcEpr?=
 =?utf-8?B?OTR0RVFQWnQ2VzYzRldnY3lGSU9kM0xYUEwvU0hIUXFaL1ZUVHc2dHNFZCsw?=
 =?utf-8?B?ZnhIZWp1bExxTEovemhnQXZUb1FRV1AxdmxBSm9JN1o3dnpHUmVGZWlLdk4v?=
 =?utf-8?B?TU5pVFpXbmZydEQ5c1pRUXcvNE9kQmNzNityV2l6WmhmQ3YrK1lQYkFlMzM0?=
 =?utf-8?B?WCtKTjdHZzM5UDhWUHlwRTNiY2hDUmdsTmRzOW9KSDcxM2M2SkwzL1hRWmNr?=
 =?utf-8?B?MW9KdDE5UDFjNHFqNGxVTGtobWtCenpGR1piNWgxRmtPN3BFQnJBcXNQd09w?=
 =?utf-8?B?VHlRaGI5U1FoWXVySS9BUENiWEtieGVXMDNiSlIxcS9EdHZiYnY3UUJsUmFh?=
 =?utf-8?B?bzhNREFBQzVRTkw3elBrZXBKNHZXRmhuOFVXN1hXb1pQb1N1R3dmRkNtSFB3?=
 =?utf-8?B?ckNZMUJlSCtTM2NscGIyU0VRRlRhK1BrRlJoTkp5K01JS0pQcHpzSEt1R0l2?=
 =?utf-8?B?Y2s3N3ZCT2NERXdwZjl4QVIzbm5rUXdKYTdmQWlYcmh0R1ZXWkJrd1hIa0p3?=
 =?utf-8?B?OTEySmhkTTFsSDV1TmxUNzY5SHMrY3F2cEM5ci9YRzFEcFhlVVBjQnR3dUtO?=
 =?utf-8?B?NWxEL3VBRERDN2UrRUI0aWZNNGYzblJVYUl0bFIyd0wxOXF1b2UrRHQ2NjdV?=
 =?utf-8?B?WUpGUW4yRHJ5eTM0Z3dOZmdkOFdNd0hDa1RLUnp4dE1icTh2anZyNkhoTUNF?=
 =?utf-8?B?OGdhVlVoWmREemRGTDdSd3JtdWQ5VGVuaGZwL3c1VURUcm0xK24yMThINEM1?=
 =?utf-8?B?NXJGWkw1SjhOTnpPUTZFNGRESGZJeGNBb0ZlVTdSQTc3WWJtdWdTVGUrVzg3?=
 =?utf-8?B?eitBMFBFVklTRnhmVFoxaW5qaFI5eW5nQklvdnF3dGlEM0JJVVAyVEFJcVFS?=
 =?utf-8?B?RGxHamNFbVZ2Y2lGaGtaTExxM255NHNjcnhTa21abVVwZjUzMHhianViMlBi?=
 =?utf-8?B?bXYxVDFITFhiNUZNSmVJbHd2YjhkRDg3bHhLb1VKSFJxZjdYWFJySC96MDNW?=
 =?utf-8?B?MEtGRXNJY25sSDlVaVFLL3lVTGpHdTAxSGlsbGRaWjNHYTZzSG5WcXdRQ0E0?=
 =?utf-8?B?M2lBd0d6Z0V1K0MvY2FocGZLZWRIbmwzdkY2YmlxbW1UL1NiWXdObnNTM0Rm?=
 =?utf-8?B?NW41TzlOeUM1WTljK29nTjRzOWQrcWF5YnN6K3FKZmxOQkhoaWVrcWhUTUox?=
 =?utf-8?B?eXdMdmtDWkZQRnJiV0lOamxUQXcwUEs4T1luS1MyN1pwQW1yTldHeSszU3FM?=
 =?utf-8?B?TGZzV1dadFBpU0pVRzUwdjhRVndDQlJPUXBINWdVRWtTSDJ1QnowVW9JZ0NU?=
 =?utf-8?B?cjR2c2dpRUJoTzZVaXN4Sm16V2R0SDlOeVRTczNIYVdoS0JNWUI3VU5GdnRL?=
 =?utf-8?B?YVAxQ3BXdC9TVU1McldQd0NSWk8vQ1RUQWUyd0oyTHVsUHBURzFIQjdFbFBD?=
 =?utf-8?B?OHpTYnAyR2VRVk9tZ29ySFhtUTYvVll4MEVLWi9JaytlT2xoZjg1WE1STUpE?=
 =?utf-8?B?UFc1ZDdXTDdpZE9VVU5FR3RwNVIyeVJRYVFHZS9PMTY0NVRoZS9uektNdFdh?=
 =?utf-8?B?Qm8xQjBDeGNja0piNUVPc2xzalAyNWR0aSt4VEUxeTV4Q0Y0Mi9uSWlYUFN4?=
 =?utf-8?B?TzM1Z0REMklIZzFuVTBzTzNHQSt4azhndnkrclNUUVhxQ3FYdmxhampaUVB1?=
 =?utf-8?B?ZStpTnkyQmZPK2pJTjN3TFVLb3o5V2VhYVc4d2JFZHY1MU9kM09NdzAzelhD?=
 =?utf-8?Q?yjyE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebcaba34-f0cd-48de-486c-08dcff46749a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 16:08:45.0718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtGsSIWwkRx4UefMjG+pA5g4DNn4qa8OYknEaohkD7tqE5gZ3qQ/cyybezXtln8LJuStK3PS8/1WJj0GtzesMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10803

On Thu, Nov 07, 2024 at 11:13:34AM +0000, Manivannan Sadhasivam wrote:
> On Thu, Nov 07, 2024 at 04:44:55PM +0800, Richard Zhu wrote:
> > Before sending PME_TURN_OFF, don't test the LTSSM stat. Since it's safe
> > to send PME_TURN_OFF message regardless of whether the link is up or
> > down. So, there would be no need to test the LTSSM stat before sending
> > PME_TURN_OFF message.
> >
>
> What is the incentive to send PME_Turn_Off when link is not up?

see Bjorn's comments in https://lore.kernel.org/imx/20241106222933.GA1543549@bhelgaas/

"But I don't think you responded to the race question.  What happens
here?

  if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_ACT) {
    --> link goes down here <--
    pci->pp.ops->pme_turn_off(&pci->pp);

You decide the LTSSM is active and the link is up.  Then the link goes
down.  Then you send PME_Turn_off.  Now what?

If it's safe to try to send PME_Turn_off regardless of whether the
link is up or down, there would be no need to test the LTSSM state."

I think it may happen if EP device HOT remove/reset after if check.

Frank
>
> > Remove the L2 poll too, after the PME_TURN_OFF message is sent out.
> > Because the re-initialization would be done in dw_pcie_resume_noirq().
> >
>
> As Krishna explained, host needs to wait until the endpoint acks the message
> (just to give it some time to do cleanups). Then only the host can initiate
> D3Cold. It matters when the device supports L2.
>
> - Mani
>
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> >  .../pci/controller/dwc/pcie-designware-host.c | 20 ++++---------------
> >  1 file changed, 4 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index f86347452026..64c49adf81d2 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -917,7 +917,6 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
> >  int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> >  {
> >  	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > -	u32 val;
> >  	int ret = 0;
> >
> >  	/*
> > @@ -927,23 +926,12 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> >  	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
> >  		return 0;
> >
> > -	/* Only send out PME_TURN_OFF when PCIE link is up */
> > -	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_ACT) {
> > -		if (pci->pp.ops->pme_turn_off)
> > -			pci->pp.ops->pme_turn_off(&pci->pp);
> > -		else
> > -			ret = dw_pcie_pme_turn_off(pci);
> > -
> > +	if (pci->pp.ops->pme_turn_off) {
> > +		pci->pp.ops->pme_turn_off(&pci->pp);
> > +	} else {
> > +		ret = dw_pcie_pme_turn_off(pci);
> >  		if (ret)
> >  			return ret;
> > -
> > -		ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> > -					PCIE_PME_TO_L2_TIMEOUT_US/10,
> > -					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> > -		if (ret) {
> > -			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> > -			return ret;
> > -		}
> >  	}
> >
> >  	dw_pcie_stop_link(pci);
> > --
> > 2.37.1
> >
>
> --
> மணிவண்ணன் சதாசிவம்

