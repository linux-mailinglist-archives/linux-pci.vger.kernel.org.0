Return-Path: <linux-pci+bounces-13869-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DE299108D
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 22:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 536CB281E5D
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 20:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21591C878E;
	Fri,  4 Oct 2024 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Oac1byBV"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013053.outbound.protection.outlook.com [52.101.67.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B661ADFF6;
	Fri,  4 Oct 2024 20:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728073492; cv=fail; b=b0R5Kbnzx9xmEo5XHyu2pBBFwCZmapivb5BH/uCHE59wA5z2UO2GtfBmsyUo0tQWIHndeXKTXQ5b+/gX8BCPNYkQt3znkrZwrK8jomUm5VrvrF3gYQ8cFOdvO/UIKKhVJiOx/2z21zCB4y/libmtpN4Oreb9BuurTz8gchsddlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728073492; c=relaxed/simple;
	bh=yO+gtcT/GBytzHOOvazI1D4OlZkBx1WODi37SzCjgE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bcqgcVq54Z/6FSzNc2BGJPFPo2mFT4f3S0ZyiC+Y/Kbg4AdOGFE8iEhH61dHp4L17O1ocWzSmb/KScGObogTiO28Uj0hlKLZbtjZGrxCBLIqh4pirNNK6DHHHx5B4nUvV9QuQ6SLdwThMFb52AROYBWOZGMgNyA74iJJ8BXnUDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Oac1byBV; arc=fail smtp.client-ip=52.101.67.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3tJu1bsuSmTPeSfMNattyPnxzCkKD4Ct5ntmmfSjxFDYOTMElMoIHxaraeGTVZBqLVkhOioBPd2XYifUbLFGzEOxiAsXl8rJ62dz2RkjudflK4AhTQXZcef2lcZz51B2oMW2wYcqzPRIpvf59imM+IbQCkupw4mLO0Mqq1NjUsBoSd3sY354SacJYhsSBmomw7xpKL4mKrBHN1eLpd3kul6gM5o1pE8+6izpGY2lBNpjSbhiNXr4LlBDv6OxzHab68L+vvziUwao2umREUtwXANuoLPeWL3c4D8EApKlR+4XVXQRyQLEPBLuBShaWnWx5puBXWwXho9EP9WM7V+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/y8Xjd2ai9HXQKTmtw7hWm2ImFFr3NdzZ2R3LZ8HFI=;
 b=BQoIXJSL2kANAEqvITUm+ELZ3RuVfNsWKunZ2FPwtRElaw9j2dzVq4rCpm5kEzC6Dr4IwmXy8ETgOI4D3p+i3WMqvNzYbKD21XlEtqNh4z67ZS6w1Jdc7gR/blu9h9aVQSCLR7DREPUGNuAkj8WMpPPitgsLBNBjQnXhX10gdAFr9R5HHNATw5QEiUhOUlQZuNfVxuOoyF/lOrNFDV91jwTRma0qxXj0/vakSVrCbNkUrnDZk220Xtn+bwzICZCdkGuug242iyRXgNXSe0BYN8ItzhjjSGa8ifmh8cG/4QWxqCKkpE5FrMdib2C1qhvtYHlqRpnF2Gj5SPZO/13UFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/y8Xjd2ai9HXQKTmtw7hWm2ImFFr3NdzZ2R3LZ8HFI=;
 b=Oac1byBVUS0OetueNLENaP6QZVK9IArzLS8I8wxfGJyDDYSUjNS9CJij/CfgSNb+0w4cilaExRSMHGXBbhYUMhETU1NAqhFWPf0/ZROzVsVqTdu6wX8HsAB0sI0PyQuSbDgHjMFc67l+TTlydsSviEu/Q1yKgyBUoFxGtO6anizQ1cgsclZqrhUjirn+WpaEY4oorTGE3mnXF7kD1X+Uvs9xr71MT0PmecQa9xXg89bpCVsTpireWvb1E9u57cj8M+80XLuhGKUj6ADYsnWb/ZBHeOTF5udNBMm/d3HfAiATLEEpil37kqMFdmMikuFkid009XBPVxQyiOhGrL5YFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8581.eurprd04.prod.outlook.com (2603:10a6:10:2d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 20:24:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 20:24:47 +0000
Date: Fri, 4 Oct 2024 16:24:37 -0400
From: Frank Li <Frank.li@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v2 0/4] PCI: ep: dwc/imx6: Add bus address support for
 PCI endpoint devices
Message-ID: <ZwBPBSHnnz2e7YJK@lizhi-Precision-Tower-5810>
References: <20240923-pcie_ep_range-v2-0-78d2ea434d9f@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240923-pcie_ep_range-v2-0-78d2ea434d9f@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8581:EE_
X-MS-Office365-Filtering-Correlation-Id: da5b991a-534e-4d5d-6ca0-08dce4b29726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDhIdFZlTzRsY0JSNlprSXEyUDNSY3NucnpheXJ1NEdhRnJPNDM5MGdibXRD?=
 =?utf-8?B?RmJ3d3BCOVRCbDc3UHREanRMUWU5M3AyQm1sNkZ4MmtBVUtxNVFLVEVIWkR0?=
 =?utf-8?B?QUQ3dW1VYzZpb1RyM1BwNVhvbGxQTE9ZeHhWS2lVS1BGeHBsYjNpMG0wSUJx?=
 =?utf-8?B?YmNJdXFDS2RseHk1Rkh3RWRCdGJpUkFzOVRqWDU0SmZYZ2hNY0ltQnlsMlhi?=
 =?utf-8?B?V29IS3NPdGJTc01VZ3RCL1h1Y2JVaFFROHFzd1ZlVGtKaXVaM2tPS1k5SWl2?=
 =?utf-8?B?b0tHd0hCNkpVbm1HNDZOODQzbmU1YnJmOUwxMU92R3drRUV4OXhLVHdmSjJB?=
 =?utf-8?B?bzdtUmt4VGs0RTRoSTdTN2ptUXpqWGlvcjYyUlJpa1k0bjFlODczUFpVcVQ3?=
 =?utf-8?B?eHMzS1BOd1dzSzJKNll5dlJES0l5Z3h2WW9jSnJreHpNRi9hekU4UjQzU1Ft?=
 =?utf-8?B?WE5qbGs1dTRCUEVkVGhQQ0pGNTJwU2gzSTZPMEZQYmptVjQvajg5WVZjVXpq?=
 =?utf-8?B?blFQakNJV2haTXZEdTBZSDZSU3hDR0RUdGFSeWRMNlNMR0tpc3E0VjV6bUI4?=
 =?utf-8?B?NFg2YnRxOXJETENvd3hFR0EwbElQMHc5a0ZKYjZlOEI5K1NKQVZFczRuVFFS?=
 =?utf-8?B?SnYyS25PaDhOMjNlYi8xMER1RC9wWWd0d2c0VUFoNnFVcEpMRHZxZXZ4a2NH?=
 =?utf-8?B?UnJaRFBmZ0JrL3l5dG1JaERSNlNycXo5NFpFb0h3T3dTMm9tZXVoWXdyZTJz?=
 =?utf-8?B?SUV5RzBwVVBuWS9pYm0zUzhRMXhpaGZ6blh0amRsdnF3Zmo5djdFY1lyWEZl?=
 =?utf-8?B?UkNVZTVrc2hKS3RYMWpvSGpiSnN5aWNIM1RDY3VEcXZsazhiUXp5d0VUU2Fx?=
 =?utf-8?B?OUdkTENpT0F2eXIrUCtNOFI2WXczVzZaZXQ1MCtnbE1XOFY3SUVjMFVweXB6?=
 =?utf-8?B?T0ZUSHZ4Ky81QW9yUVFEdVA0cG5IaEFocngwbklpZmRVVDNiYjZ2QzlsMWpr?=
 =?utf-8?B?dmUyOUpwcTRlSHVpS0gwdm5iaUN2R3drdUYxNnZaQzBzZHgycnRrL3gzbEdP?=
 =?utf-8?B?bGVaY0xnOWswVlUvNjcrL3ZuTHgxM2V5c240RGNTNW5XMzNqSk4zSnZuOGky?=
 =?utf-8?B?S0VYbHkwNUx3NWtEU01pdWQxY2FOalhxODB6L3ZwQWJCZXVydmJhUVlPck1S?=
 =?utf-8?B?NHdTbUoxREhwRDEyRzljeHdrQVpDRGJETHZpTHZjVGhVUlBrUlBKL2dpM3ov?=
 =?utf-8?B?dFFnZEZLQjh3SkdFaE81bURWSGVZYXFzSUsvTXVRQ0xLMC9BR1dla3lsdW13?=
 =?utf-8?B?aEY4RXJVSnB2QXN2cEpVdWx5dEFQYWdTTm1sZUh6cUU3SFQxQ0Y2Zm9aQXVM?=
 =?utf-8?B?YmFEekJGbE5Mc0FkQkxHelZqSU1OQ1hyZmpCK1hlbVpqdFZkdzJxLzU4dTMx?=
 =?utf-8?B?R2xtUmR3cHR3ZFFIM0x2OTRHalZJTjBGTll5THE4ZXFoM3E3NlRlc2ZMU3Uz?=
 =?utf-8?B?YXFkQ1BkRUtVcmFna0hGUVBpREVMaFZqbVdyekt5bkE0Y0h6V2JNVUN5R3dp?=
 =?utf-8?B?K2toV21tWk9raDNzODBwVU5nV1RleXFEbnFKNlFQSERXaFBkYWFqZTNWSmtz?=
 =?utf-8?B?ajkySElPbWVnTnpwOFBnWThYNWdLUUVLSHMzWG9sd2NpVDRvVzlVcE03bGhN?=
 =?utf-8?B?c2tSaVh3ZWNWWFZpTm5udWd3QXIzUVlJRDlIUGwyWkpaU1Y3aUFUemRXZktj?=
 =?utf-8?B?Q2Q0aDdOU09kNHo0czJSTm14QjRHSTNkQzhLZUdyeWdQTW96TWpGZ3Y5L056?=
 =?utf-8?Q?qjGwwdh4vaIQsIel8qyXlOMZBTDD2KHJNLt+I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjdMclRvbCtERElBSVJJUklCNXZmak5QaVk1VGJZRWpyUy9VTDRRZENTY2tx?=
 =?utf-8?B?NTBGUmpENkVuTGkwZTd5WDQ2NXVvQW5MaVIxMVhncEw2ZXNkc2t0aitoMmdi?=
 =?utf-8?B?ZHFPeFVmTmZsL1F4SHFkK0VmUmFsSE16Q1NFMXpXYVBFOEp6V1ptN1c3WVlD?=
 =?utf-8?B?OUFyRjRvWmFIUEdsWm1TY3lKWUhJbmIyM0IxYlduNXpqd3ROSjkxTlNqSnYr?=
 =?utf-8?B?a3d5bEx6NG1IZURNUHgzcXRVcFlZZkJMUDdjL2kzVEd5SXk0M0ZrRDd0M0pm?=
 =?utf-8?B?WE9naGpQbGo5dVp5U0QzYTdFc3ZvVXBvUDVRdXN0djFNS2lQSFArMjJhM1NL?=
 =?utf-8?B?VDMwSFA1R1ZpVFRIQnFFUXVNVjVWYkQ1Q1huNy9SM3hEaE5sUEQ4NTVBVzFo?=
 =?utf-8?B?VUJ1cWk3RHZYRk4rSEx5UUo4aXY1ZzhhMnUwU3dWQkV2R2RwYzVTVTNCaTZl?=
 =?utf-8?B?cmgvMDVLbUlsNkphOUlId1hUTTRyQkFhZkFrTnFBZlNwZHA5M0h6M1N4MkpD?=
 =?utf-8?B?OFMyNzFzdXE1Q3owMWRzTmxtZFFvakQvVXpXNzZWTkxjOGdWSkhhQkxaYXY1?=
 =?utf-8?B?eUQrenRkUzB0TDAxbWtOakF1eVV3NXVwUExuMjRITHFnVWVHOWUvdGEwVDNJ?=
 =?utf-8?B?MUN0UlEzaDc1Z3JWNnkrVGtpZ2xQenpVWnBRbVUyU2RFTEhHWTUzb2Z5S0lZ?=
 =?utf-8?B?TWgxR0IrZDhWU29tRldoaWxPUk9BZGF2TGNYQ1N3WVRKL0d4dFp0ZTZ5Mkx4?=
 =?utf-8?B?bGZ4aE40MlBvR3AxdHNxVkM0ZHoyOXVuUXAvSDdKc2RQdzQ4SUI0ZXFJUDFF?=
 =?utf-8?B?cExjVndJcFkwMmZXTGQ1MjdjdTgwcExYL1NBRWJPWjJYejdHSGxCT25XVlln?=
 =?utf-8?B?enV5RW9lZkUvemsxWXR0UnZqZmNHME9sTDNVOGRsNTcwNit5QUw4YWtMZ2FL?=
 =?utf-8?B?MUFONDZWNEpJa0Q3VDQ0SHM1ZjNZckthV1VzK3RSY3BaemkycjdKMlhYRitL?=
 =?utf-8?B?cVg0MjJLUkhRbzJwT1laZnBNZUxVa0x6bFRZTDFGODBVV1k2T2pDS0hPOWVX?=
 =?utf-8?B?clF0U0hMRnU1M0ZkaE1BU1ZnekRLQjhIRjBmcjZZSHM5bFZVWjNaNUlhTFRM?=
 =?utf-8?B?aEdKby9mQVlWcGpBM0hlT1JWUnE5S1NBb1JNazZpMWJiY25KYTN6cEN4L0Zh?=
 =?utf-8?B?UGQ2dUhWS3Z5dCt0c0hyTWh2L3ljenkwTHRSUElEQjNwOVVGUC9zSlRLUEF2?=
 =?utf-8?B?cmh4akJhUkh5WHZKUXVPWm5tbStrL0tDT2lSc3N0N0o2V0lxZlk1TGpBdzBv?=
 =?utf-8?B?dXZibEtRTFA1dDJnbmZEbk84Wk1IM2lheWRQVjN5QkZRYlF1Z1pvdkprR2Fx?=
 =?utf-8?B?b3UveGozcTc5ajBHdXdHT2NOaTBLeTB3RWQ1ZkZJSElZb1RJN01VRmx6YVhN?=
 =?utf-8?B?MDFKVTIrTE4rKzNJNnZrV0t4eHF6SkxTNHBxUmZLVFBnUzM0L1pucTFTbEZK?=
 =?utf-8?B?OURqRSsrclNacG82S0tLUExUOXVxNHRTdVk5T2IwZlF2SUxzc2dVbmpvRzdC?=
 =?utf-8?B?aTJNRlp2Sk8rN3FzK2pWUkkyWjVnYmk4aXNyK2dkMHNVMWx1b0pGeTd5ajl2?=
 =?utf-8?B?bjROT290aHJiUlkya0pQWmN1T014dGpUeGNYVm5CZDROVEMwcTN1WTkrdjNt?=
 =?utf-8?B?bVUrLzNpVzhzV2ZvMWVjNTlKK2hHR1FWeUhXWm5TWGNoajV1b1J5WjkxbHhq?=
 =?utf-8?B?blpEbmdpSm0vUDNjUWptcUR4ZEg1QjQ1bWZYNWhDaTFMK09lL3pXeUtUYXhC?=
 =?utf-8?B?Qm5OMlc5a05hNlVOKy9wZGsvT09yWWhIcGRtOTVWa2FjbHI4NVZPeGk2djI2?=
 =?utf-8?B?RkdJb1pQdnFwRG4yNHBFMXZzUXVzc0NFNFhocXZXbGhCSmk5a1NqMngyMERz?=
 =?utf-8?B?aXowQTlLTTY0TDl2Q1lkM2t6Qm1VRzJ4YktiOHhnR3NnMDFjcW5Kc2F5c3Ey?=
 =?utf-8?B?anFaMGdUR2RXNE5FVXNRTTZDYTJHNHBCWXozakhhZFo5TVBlWHlMZFJ5WEFu?=
 =?utf-8?B?T1IrM3AvSTVKcSsyYUtYeTZQZnZaSnNYRDJBbWtPQk5PTm04M3JlM3NkSEJD?=
 =?utf-8?Q?dhks=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5b991a-534e-4d5d-6ca0-08dce4b29726
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 20:24:47.2107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+SuOB/9tKMnA6Xr3yGuMAs8KOIO/Upyud7gEkd3XkUSFAa5DwkomXKm9odZTjPCRn/SojHaBmbGgzxcgoDj8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8581

On Mon, Sep 23, 2024 at 02:59:18PM -0400, Frank Li wrote:
> Endpoint          Root complex
>                              ┌───────┐        ┌─────────┐
>                ┌─────┐       │ EP    │        │         │      ┌─────┐
>                │     │       │ Ctrl  │        │         │      │ CPU │
>                │ DDR │       │       │        │ ┌────┐  │      └──┬──┘
>                │     │◄──────┼─ATU ◄─┼────────┼─┤BarN│◄─┼─────────┘
>                │     │       │       │        │ └────┘  │ Outbound Transfer
>                └─────┘       │       │        │         │
>                              │       │        │         │
>                              │       │        │         │
>                              │       │        │         │ Inbound Transfer
>                              │       │        │         │      ┌──▼──┐
>               ┌───────┐      │       │        │ ┌───────┼─────►│DDR  │
>               │       │ outbound Transfer*    │ │       │      └─────┘
>    ┌─────┐    │ Bus   ┼─────►│ ATU  ─┬────────┼─┘       │
>    │     │    │ Fabric│Bus   │       │ PCI Addr         │
>    │ CPU ├───►│       │Addr  │       │ 0xA000_0000      │
>    │     │CPU │       │0x8000_0000   │        │         │
>    └─────┘Addr└───────┘      │       │        │         │
>           0x7000_0000        └───────┘        └─────────┘

Manivannan Sadhasivam:

	Do you have chance to review these patches?

Frank


>
> Add `bus_addr_base` to configure the outbound window address for CPU write.
> The BUS fabric generally passes the same address to the PCIe EP controller,
> but some BUS fabrics convert the address before sending it to the PCIe EP
> controller.
>
> Above diagram, CPU write data to outbound windows address 0x7000_0000,
> Bus fabric convert it to 0x8000_0000. ATU should use BUS address
> 0x8000_0000 as input address and convert to PCI address 0xA000_0000.
>
> Previously, `cpu_addr_fixup()` was used to handle address conversion. Now,
> the device tree provides this information, preferring a common method.
>
> bus@5f000000 {
> 	compatible = "simple-bus";
> 	ranges = <0x5f000000 0x0 0x5f000000 0x21000000>,
> 		 <0x80000000 0x0 0x70000000 0x10000000>;
>
> 	pcie-ep@5f010000 {
> 		reg = <0x5f010000 0x00010000>,
> 		      <0x80000000 0x10000000>;
> 		reg-names = "dbi", "addr_space";
> 		...
> 	};
> 	...
> };
>
> 'ranges' in bus@5f000000 descript how address convert from CPU address
> to BUS address.
>
> Use `of_property_read_reg()` to obtain the BUS address and set it to the
> ATU correctly, eliminating the need for vendor-specific cpu_addr_fixup().
>
> The 1st patch implement above method in dwc common driver.
> The 2nd patch update imx6's binding doc to add fsl,imx8q-pcie-ep.
> The 3rd patch fix a pci-mx6's a bug
> The 4th patch enable pci ep function.
>
> The imx8q's dts is usptreaming, the pcie-ep part is below.
>
> hsio_subsys: bus@5f000000 {
>         compatible = "simple-bus";
>         #address-cells = <1>;
>         #size-cells = <1>;
>         /* Only supports up to 32bits DMA, map all possible DDR as inbound ranges */
>         dma-ranges = <0x80000000 0 0x80000000 0x80000000>;
>         ranges = <0x5f000000 0x0 0x5f000000 0x21000000>,
>                  <0x80000000 0x0 0x70000000 0x10000000>;
>
> 	pcieb_ep: pcie-ep@5f010000 {
>                 compatible = "fsl,imx8q-pcie-ep";
>                 reg = <0x5f010000 0x00010000>,
>                       <0x80000000 0x10000000>;
>                 reg-names = "dbi", "addr_space";
>                 num-lanes = <1>;
>                 interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
>                 interrupt-names = "dma";
>                 clocks = <&pcieb_lpcg IMX_LPCG_CLK_6>,
>                          <&pcieb_lpcg IMX_LPCG_CLK_4>,
>                          <&pcieb_lpcg IMX_LPCG_CLK_5>;
>                 clock-names = "dbi", "mstr", "slv";
>                 power-domains = <&pd IMX_SC_R_PCIE_B>;
>                 fsl,max-link-speed = <3>;
>                 num-ib-windows = <6>;
>                 num-ob-windows = <6>;
>         };
> };
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v2:
> - Totally rewrite with difference method. 'range' should in bus node
> instead pcie-ep node because address convert happen at bus fabric. Needn't
> add 'range' property at pci-ep node.
> - Link to v1: https://lore.kernel.org/r/20240919-pcie_ep_range-v1-0-b3e9d62780b7@nxp.com
>
> ---
> Frank Li (4):
>       PCI: dwc: ep: Add bus_addr_base for outbound window
>       dt-bindings: PCI: fsl,imx6q-pcie-ep: Add compatible string fsl,imx8q-pcie-ep
>       PCI: imx6: Pass correct sub mode when calling phy_set_mode_ext()
>       PCI: imx6: Add i.MX8Q PCIe Endpoint (EP) support
>
>  .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml | 38 +++++++++++++++++++++-
>  drivers/pci/controller/dwc/pci-imx6.c              | 24 +++++++++++++-
>  drivers/pci/controller/dwc/pcie-designware-ep.c    | 12 ++++++-
>  drivers/pci/controller/dwc/pcie-designware.h       |  1 +
>  4 files changed, 72 insertions(+), 3 deletions(-)
> ---
> base-commit: 4ed76e3b7438dd6e3d9b11d6a4cb853a350ec407
> change-id: 20240918-pcie_ep_range-4c5c5e300e19
>
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>
>

