Return-Path: <linux-pci+bounces-38362-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F2EBE44BF
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 17:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC914231FA
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 15:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F5734DCC0;
	Thu, 16 Oct 2025 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kk0oQLSS"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013020.outbound.protection.outlook.com [52.101.72.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7122FD7DD;
	Thu, 16 Oct 2025 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629117; cv=fail; b=A7eLKUP6W+Xxxgb2728D/K2DqI29OjxJVVot1RRmIozuwN7yeGNRNrY1isMpH1xVnBTEim7TlXS7VkbjnWKK6wP/l5ETq6zyHoX63n36zJHo6n1XKlDeURnFHbrRDpAgUxDPmS/Al6biE6R/s/ZzgZ+CtLKW1B6mt8ifFzte+D0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629117; c=relaxed/simple;
	bh=MSbPW8Gisa7Rt6i99+INkr860HPQvoOK3Id/lKzrN0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YF3a3djuKilGiswXSHgrDxsY96efXaDXjyMa4VN24FX4hAigF1+3EI3ZysJJ5nQZG/LHyCEp5d735YuwymVX2GALJ5inb6RZ05USt2j/ohcWPwAS8QkKm3Ufv1ollb3mqojxmQCXaMkrM61zTxVNUR86GRrVxZNvP3AbtFyOMBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kk0oQLSS; arc=fail smtp.client-ip=52.101.72.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xV4Ou8AGvt0Aa4jNIKTg+xtPY9Dx4vM4IieLrZP13LfVdrNMOY9UdWiJFtlQZ0sgKBiLpkqktvKTHsdow2ZTBemDO9fWqP4HtO23fR4tmhOEvXtfBFB/v6s0w5AB5BWN2XaqTB3TcG2lol5e5SgdzOHQS4QcfemX250P7xQEHMEuhCE7GCHGaUo90lve/iMPBvOYIFvqB8aIH6UawzTpEjW4kDiz3gEbhU7LI3HuTVREQMdd8TvIyljpmuWwiKnxxw4/bRR5IozlsVz8ylMolSrce/QPFvgcCforrvzrR5KiHpKdJN+ujvIiNTv3D73Y2KeqEXNpTfT8RhZYwP7JTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/EtoZRiU7PM2AIDtJXkuOoHF38AwPT2UzapsdhtRKo=;
 b=bBfeYubUXmbYeUO3STNu5T2KdWxekXMFApnqTuavnBVF2H97L/1dlIySRCOIflqKPy2jtPkSEzYK8fmT1sdOxU7/qLHQBtNSsoq00IgN6OLrT2J+fmQp85LD+HVFgPhfMRTPkvY5U8lXMBChvOi0fAi+fOstX/HJhJ/OTZjDaViYGx58G/fimHxIx/95qSojaVlVtvec0oYw6bKdpMO5nID1bG2d4w8PLCNByk55ATJC1qKxDZC4pwku5qqM14i6IWZo1eYCc46KZMinAq0yV4U+6M07JVb3K0fMa2W33E6k4QgtpRP37PROqqtcPpmCBbiMtbjBgwdM/L9DZefNJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/EtoZRiU7PM2AIDtJXkuOoHF38AwPT2UzapsdhtRKo=;
 b=Kk0oQLSSCEGSfq82SXm6BUbRa6YOsEpejQCUifwKWvHJ2zz4Byv4wleFrCUmNdbOOf3BYvycRgkqcVjwi0xwiy6FZkJK4WCF7Yi76Q9qKdM9vURvFbH6cJEXIbia3awFbBUVQijs5S+Tcqa6FWk22bEYNmfmxMbu9HDgLHVP1znGHdDdtQZ/obUCExoPOcaStoJyBlslk86qMNvvkzvTkktWinLRlWr2VJELJ5zuwciQQ8vuoIMDYNEb36OZThS61aPRW2sXnLEvIAQdCPdD5xEK71eA1Fh+2/zcE/HwLwdz6EqHNbIQC9Q/X6UJ0YO7g92fd/7Kpbzn4UpR3FsQPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS5PR04MB11467.eurprd04.prod.outlook.com (2603:10a6:20b:6c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 15:38:29 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 15:38:29 +0000
Date: Thu, 16 Oct 2025 11:38:15 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Lee Jones <lee@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: Fix inconsistent quoting
Message-ID: <aPERZ/IpjAhD2sen@lizhi-Precision-Tower-5810>
References: <20251015232015.846282-1-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015232015.846282-1-robh@kernel.org>
X-ClientProxiedBy: PH0P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::20) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS5PR04MB11467:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a12a7f8-7aaa-4c75-02b6-08de0cca0df6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|52116014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HbGBelW3YZSW2ud8dNHnqK8aOB0aMkt3j6xlpN4degQBkwVjIjDbbvXVXCSs?=
 =?us-ascii?Q?7mXGUUUEfHifoNtnfLjR4w0kaDHqV6oIi8lAWvzuQibABj3Jom6ic1cIPPkK?=
 =?us-ascii?Q?t7SEc94BcYF/SPlGQ6MHGfV6KgduOIae5SlgwWKf1ttDVsCMfRJUP3jbmNJh?=
 =?us-ascii?Q?7DdtUy89sIQZVl/zy6zmihcFXgp6gpCpfCXELd2yULiz2VjMdkheQnL9Gnnu?=
 =?us-ascii?Q?sIg1JNesw+qKUFz8ZlWW3VzLBTd4c23wQO6AJo4tEXZ5BF4mNdnJ1ku9tg4V?=
 =?us-ascii?Q?hgus1Z3GrSVrF5aE7TanVcR+rsAzH98f062ld8FZ1M/GPwavntXUtAsTqvpa?=
 =?us-ascii?Q?L7Qsx06/adG0PDrOqgcEI+fmDKFjFynhmAoCsdq79Iny7pEZH8rX20IrIz2B?=
 =?us-ascii?Q?22PqZbtdusboYRko45OGziMrtq2lUj/PbtA4Kiuigmii+9rYYtzhgu0ZwTKu?=
 =?us-ascii?Q?rZ/SSbG6hBKVh847pPBC/ZxsnCB3VbgnkYugl4abP0wZjCZAC6rdb8b1S5AG?=
 =?us-ascii?Q?UeSqllLOWS6C2C75OzOD3UT4gn12XGUVQ7AWBsUGklM7CHeenyQukyF5EdKS?=
 =?us-ascii?Q?15xejD1tsjlbKxrmz1OIAplU+cb26Q3cRU17DXGbRxK6LY9kbLgNT/4BCBZD?=
 =?us-ascii?Q?g2VmZilBb1UieE0UOBs+UQjUPXpZhbG8r1lhwHnquYAsPmKXHzNRMSUZTeRe?=
 =?us-ascii?Q?jx8DHwGBRM54g0AxSmjhd4xiHyDzcJ3aNczFJVUSDPsfVUPnvY+lmRboaDfg?=
 =?us-ascii?Q?Q1DwUHW0NNHh7nPLIJKYtA83kk7NMar0oCunnBEbVRQf4o3W8Y220VfdY4bx?=
 =?us-ascii?Q?hhNtWnqUkR77N42ao2XBFMsAJc/1tiC3GFeH+MPu0wDQrmxvfTB/ciR0gOen?=
 =?us-ascii?Q?n0zjZzLpFP/8bOpu0UsLJyxDwQMYW25Kib+uMqNMZtGEkcvtSdyfOYEn91Jb?=
 =?us-ascii?Q?DM4gGP17LDl8SkSCm4XOZb4/mIG6R4jFiZd3vMIDRMd5h/Yj4uOJBtUaQUgS?=
 =?us-ascii?Q?Vr7T5rXmbIDxBbSGbTAN6wuh4vP/+PsaJuyOBORu4hOEs0T5MoTafP/0jJ3r?=
 =?us-ascii?Q?JSEBJe51pB4xUvp4oTs1fTIK8eWmb2oYLUpJtDaPCgUH+Cdi9Nf8pVNdhwF4?=
 =?us-ascii?Q?WCXx0fOfK9OXMU6/j+kTD/izUau7njvgz0nDDsJbzSQGn+YKaxSlUV8tcI7x?=
 =?us-ascii?Q?Gdl+DfFLAk1FnweBidBfz+7cBJUza6enUcJLTrT7ehWhxxLSSkOTCFgvo1/w?=
 =?us-ascii?Q?1clHAemg/Ytv7U6cxguL0eody9XoyLpmBaD06uiQFlAZVDUoi9dY7ev+jGy7?=
 =?us-ascii?Q?0rshVUJL8gSdNeTHTWxmPbeafPOU3DhWpOF9qKSBWECiqa0STMytf9ahiMnN?=
 =?us-ascii?Q?ywyDq1OGHH1BrqTps8zUIpV1Ds016WV/658T7+ms1ctfGY7wtUsGDznI69Qu?=
 =?us-ascii?Q?HTZW2//5yghoshJ/clyaQHm0btElulWnwNSKRmu7Pi8/gfcQ6IsO9R0ZJmgz?=
 =?us-ascii?Q?XVmYznuen2ZrxWZ+xNZWCu0Ax2NBDyZru088?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h1FBt7H+TYtBI+GjkCdNmYUKluFT/7DjHUlDVf6CFyuv2CXBNxrr65f9/ALq?=
 =?us-ascii?Q?a5v/iaKaSNOLEnX7He6Y4fhXkmHARqN06d5zGjroiT+qwsnnK03K33eHb7Ep?=
 =?us-ascii?Q?L7rv5UOqIeQ50ND1H+uC93DKIdfDhzsGWtBmkxmzRICaixFOCuwOC+Uf0iTr?=
 =?us-ascii?Q?FQM1hzEHVN0cMBWjLgmj56qchYBA3HyUSEEJo4adiU1DfTvhFxHcRL2Ot0IS?=
 =?us-ascii?Q?l/+nKs/WS0TGhB6fo7dKP+98cFSaASl8/H3hnc4nSzatmWHIv13ybaM0UDhh?=
 =?us-ascii?Q?zQyZUNkTx1d6zWWh5Qxu/Dsgm5z/3O/Go/XzZOIiqlQ1GX+WW0pzPOO34pQM?=
 =?us-ascii?Q?3S+clpSYdflJRiqJ7376SV2jppsoS7mhNrBT0/9OT81yCW5wGju/4dP7wzri?=
 =?us-ascii?Q?RDDfGSP/CBLXtc6OhQO0rsOXD/yCmLTbNsuTaVAu2BAOdBBFV6pY++5JrHUl?=
 =?us-ascii?Q?nSKhQrVCu1K9iwQshS5/WH4XCz9RZOGkTzo9zwmQB5H9KCj4fRRKxNo93DCA?=
 =?us-ascii?Q?d+bTP6X6jlNUu2yYUJRlB2LdLVpfUQ/FGtK3pD3SDI0TczkOxY238JZmqQiK?=
 =?us-ascii?Q?UlESPiKxm1EdIxgu4uBTbFEAR+VGNwfZx9eHtdAODtyUEe2mGKg3mEfr3VmY?=
 =?us-ascii?Q?z5KXww52PXDfpaMhzjPrWuw+XqG0g1d6VD9KfkIpr6keb9+AhyfPjVdHLxri?=
 =?us-ascii?Q?x9dLZ9FM8cJr/Zy5+/V3NjzucMdGM4ZOuH9XPnL/OQHXLWKMiKej79bIQFeC?=
 =?us-ascii?Q?w1xLJ3nTUc969SEbK9ZV0v3YRhVrvFSuXL3OvyanZdBSMdmJOcacr87VypEa?=
 =?us-ascii?Q?F0P5Y0Tb9/o/sKs2y/5qO+xFzq6mk6LgxCiPEer8wXi76nMNVbzi0JHvNUF0?=
 =?us-ascii?Q?eq0V27WFB+1cn/TkVM5adlsBVMlNrzLzBZpu3jsSugr8e+u3PcuFD8HlWhI5?=
 =?us-ascii?Q?KDCCl1puvoHDbyMIaFbl7E1+apWAUCDTG0+DbFvdxltAIwZpxIIh8HVzYV43?=
 =?us-ascii?Q?IBUaaP9j8yoOBla+AjtvjWR91VV1rcXayU1c8MJIoMdSUmo7ZgmTKfA6dOqb?=
 =?us-ascii?Q?BCmIhKhP8H7+AYYh4KK7/LIE7SaPhUagPzrGrnI2oESGWFz3wTMDAtlYkAXC?=
 =?us-ascii?Q?YsXrOAZQc6QwuXh/nIgPhdD+ovhp1yfuOqEZC3PR+FCq4ROic+s6k6TlYciD?=
 =?us-ascii?Q?RX8uAelJZq2ilRlZBj1Kehkdu38qyy+Ioz2qCLfsvBVKkQKIpHsAL8rjmIle?=
 =?us-ascii?Q?iU90j4enKT+Vi7BGvaSp5D4QviR7Sc9jTmjpTCXJfPemSPVnEIrWcPw0DEfY?=
 =?us-ascii?Q?vQ+tQ4+k+BQzJ1LbJc0CqL7G6KE9HYArzAEqa7mMHSQXbj29Ierp6UUlm8Ia?=
 =?us-ascii?Q?CYsqUOvQ3ra94kqkiSslJlpKmNzwvHiby2xVHChMHLcT79RmJAeHC6nSjh+x?=
 =?us-ascii?Q?6104WiTzhQekODNOS3m66ldGWU/ln3U+uEe+aRzfY6WEy0SeXLX7yg4DyF5T?=
 =?us-ascii?Q?hd8w9SYMspz6GRRxytBwOheyDXWupT1MOU9OJklOw2PIHvranz6i4960Rtt4?=
 =?us-ascii?Q?0dlSJtkUOpp+LpyzC5cdI8aMKdpvy8aWWxE0TujN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a12a7f8-7aaa-4c75-02b6-08de0cca0df6
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 15:38:29.5354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSgT6dj6DrH+vFPoaYfZTtR9gM4NrcorJrfd6VUnYAEwrlII4buZO5k8hhdtuFTurv+L6ugIPQ6zhWbDI1fcZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11467

On Wed, Oct 15, 2025 at 06:16:24PM -0500, Rob Herring (Arm) wrote:
> yamllint has gained a new check which checks for inconsistent quoting
> (mixed " and ' quotes within a file). Fix all the cases yamllint found
> so we can enable the check (once the check is in a release). Use
> whichever quoting is dominate in the file.

Can we simple require only use one of " or ' to let everyone follow easily?
support both " or ' is unneccessary options.

like hexvalue in dts should be lowcase.

Frank

>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../arm/altera/socfpga-clk-manager.yaml       |  4 ++--
>  .../bindings/clock/nvidia,tegra124-car.yaml   |  8 ++++----
>  .../bindings/clock/nvidia,tegra20-car.yaml    |  6 +++---
>  .../devicetree/bindings/gpio/gpio-mxs.yaml    |  9 +++++----
>  .../bindings/gpio/snps,dw-apb-gpio.yaml       |  4 ++--
>  .../bindings/iio/temperature/adi,ltc2983.yaml | 20 +++++++++----------
>  .../mailbox/qcom,apcs-kpss-global.yaml        | 16 +++++++--------
>  .../mailbox/xlnx,zynqmp-ipi-mailbox.yaml      |  2 +-
>  .../bindings/media/fsl,imx6q-vdoa.yaml        |  2 +-
>  .../devicetree/bindings/mfd/aspeed-lpc.yaml   |  4 ++--
>  .../devicetree/bindings/mfd/ti,twl.yaml       |  4 ++--
>  .../bindings/net/ethernet-switch.yaml         |  2 +-
>  .../pci/plda,xpressrich3-axi-common.yaml      |  2 +-
>  .../bindings/phy/motorola,cpcap-usb-phy.yaml  |  4 ++--
>  .../pinctrl/microchip,sparx5-sgpio.yaml       | 12 +++++------
>  .../bindings/pinctrl/qcom,pmic-gpio.yaml      | 10 +++++-----
>  .../bindings/pinctrl/qcom,pmic-mpp.yaml       |  6 +++---
>  .../bindings/pinctrl/renesas,pfc.yaml         |  4 ++--
>  .../bindings/pinctrl/renesas,rza1-ports.yaml  |  2 +-
>  .../pinctrl/renesas,rzg2l-pinctrl.yaml        |  2 +-
>  .../pinctrl/renesas,rzv2m-pinctrl.yaml        |  2 +-
>  .../bindings/power/renesas,sysc-rmobile.yaml  |  4 ++--
>  .../soc/microchip/atmel,at91rm9200-tcb.yaml   |  8 ++++----
>  .../soc/tegra/nvidia,tegra20-pmc.yaml         | 12 +++++------
>  24 files changed, 75 insertions(+), 74 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.yaml b/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.yaml
> index a758f4bb2bb3..275554bfedce 100644
> --- a/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.yaml
> +++ b/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.yaml
> @@ -39,7 +39,7 @@ properties:
>
>        "^[a-z0-9,_]+(clk|pll|clk_gate|clk_divided)(@[a-f0-9]+)?$":
>          type: object
> -        $ref: '#/$defs/clock-props'
> +        $ref: "#/$defs/clock-props"
>          unevaluatedProperties: false
>
>          properties:
> @@ -67,7 +67,7 @@ properties:
>          patternProperties:
>            "^[a-z0-9,_]+(clk|pll)(@[a-f0-9]+)?$":
>              type: object
> -            $ref: '#/$defs/clock-props'
> +            $ref: "#/$defs/clock-props"
>              unevaluatedProperties: false
>
>              properties:
> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra124-car.yaml b/Documentation/devicetree/bindings/clock/nvidia,tegra124-car.yaml
> index a9ba21144a56..13bb616249a1 100644
> --- a/Documentation/devicetree/bindings/clock/nvidia,tegra124-car.yaml
> +++ b/Documentation/devicetree/bindings/clock/nvidia,tegra124-car.yaml
> @@ -37,7 +37,7 @@ properties:
>    '#clock-cells':
>      const: 1
>
> -  "#reset-cells":
> +  '#reset-cells':
>      const: 1
>
>    nvidia,external-memory-controller:
> @@ -46,7 +46,7 @@ properties:
>        phandle of the external memory controller node
>
>  patternProperties:
> -  "^emc-timings-[0-9]+$":
> +  '^emc-timings-[0-9]+$':
>      type: object
>      properties:
>        nvidia,ram-code:
> @@ -56,7 +56,7 @@ patternProperties:
>            this timing set is used for
>
>      patternProperties:
> -      "^timing-[0-9]+$":
> +      '^timing-[0-9]+$':
>          type: object
>          properties:
>            clock-frequency:
> @@ -94,7 +94,7 @@ required:
>    - compatible
>    - reg
>    - '#clock-cells'
> -  - "#reset-cells"
> +  - '#reset-cells'
>
>  additionalProperties: false
>
> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
> index bee2dd4b29bf..73cccc0df424 100644
> --- a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
> +++ b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
> @@ -39,11 +39,11 @@ properties:
>    '#clock-cells':
>      const: 1
>
> -  "#reset-cells":
> +  '#reset-cells':
>      const: 1
>
>  patternProperties:
> -  "^(sclk)|(pll-[cem])$":
> +  '^(sclk)|(pll-[cem])$':
>      type: object
>      properties:
>        compatible:
> @@ -76,7 +76,7 @@ required:
>    - compatible
>    - reg
>    - '#clock-cells'
> -  - "#reset-cells"
> +  - '#reset-cells'
>
>  additionalProperties: false
>
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-mxs.yaml b/Documentation/devicetree/bindings/gpio/gpio-mxs.yaml
> index aaf97124803f..4b5b8e794613 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-mxs.yaml
> +++ b/Documentation/devicetree/bindings/gpio/gpio-mxs.yaml
> @@ -26,9 +26,10 @@ properties:
>        # Devices. Keep it as it to be compatible existed dts files.
>        - const: simple-bus
>
> -  '#address-cells':
> +  "#address-cells":
>      const: 1
> -  '#size-cells':
> +
> +  "#size-cells":
>      const: 0
>
>    reg:
> @@ -132,8 +133,8 @@ patternProperties:
>  required:
>    - compatible
>    - reg
> -  - '#address-cells'
> -  - '#size-cells'
> +  - "#address-cells"
> +  - "#size-cells"
>
>  additionalProperties: false
>
> diff --git a/Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml b/Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml
> index ab2afc0e4153..bba6f5b6606f 100644
> --- a/Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml
> @@ -111,8 +111,8 @@ additionalProperties: false
>  required:
>    - compatible
>    - reg
> -  - "#address-cells"
> -  - "#size-cells"
> +  - '#address-cells'
> +  - '#size-cells'
>
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> index 312febeeb3bb..ee0b558bb866 100644
> --- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> +++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> @@ -88,7 +88,7 @@ properties:
>      const: 0
>
>  patternProperties:
> -  "^thermocouple@":
> +  '^thermocouple@':
>      $ref: '#/$defs/sensor-node'
>      unevaluatedProperties: false
>
> @@ -146,7 +146,7 @@ patternProperties:
>            required:
>              - adi,custom-thermocouple
>
> -  "^diode@":
> +  '^diode@':
>      $ref: '#/$defs/sensor-node'
>      unevaluatedProperties: false
>
> @@ -191,7 +191,7 @@ patternProperties:
>          $ref: /schemas/types.yaml#/definitions/uint32
>          default: 0
>
> -  "^rtd@":
> +  '^rtd@':
>      $ref: '#/$defs/sensor-node'
>      unevaluatedProperties: false
>      description: RTD sensor.
> @@ -280,7 +280,7 @@ patternProperties:
>                type: boolean
>
>            dependencies:
> -            adi,current-rotate: [ "adi,rsense-share" ]
> +            adi,current-rotate: [ 'adi,rsense-share' ]
>
>        - if:
>            properties:
> @@ -290,7 +290,7 @@ patternProperties:
>            required:
>              - adi,custom-rtd
>
> -  "^thermistor@":
> +  '^thermistor@':
>      $ref: '#/$defs/sensor-node'
>      unevaluatedProperties: false
>      description: Thermistor sensor.
> @@ -364,7 +364,7 @@ patternProperties:
>        - adi,rsense-handle
>
>      dependencies:
> -      adi,current-rotate: [ "adi,rsense-share" ]
> +      adi,current-rotate: [ 'adi,rsense-share' ]
>
>      allOf:
>        - if:
> @@ -392,7 +392,7 @@ patternProperties:
>            required:
>              - adi,custom-thermistor
>
> -  "^adc@":
> +  '^adc@':
>      $ref: '#/$defs/sensor-node'
>      unevaluatedProperties: false
>      description: Direct ADC sensor.
> @@ -407,7 +407,7 @@ patternProperties:
>          description: Whether the sensor is single-ended.
>          type: boolean
>
> -  "^temp@":
> +  '^temp@':
>      $ref: '#/$defs/sensor-node'
>      unevaluatedProperties: false
>      description: Active analog temperature sensor.
> @@ -437,7 +437,7 @@ patternProperties:
>      required:
>        - adi,custom-temp
>
> -  "^rsense@":
> +  '^rsense@':
>      $ref: '#/$defs/sensor-node'
>      unevaluatedProperties: false
>      description: Sense resistor sensor.
> @@ -476,7 +476,7 @@ allOf:
>                - adi,ltc2984
>      then:
>        patternProperties:
> -        "^temp@": false
> +        '^temp@': false
>
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
> index 615ed103b7e6..f40dc9048327 100644
> --- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
> @@ -187,10 +187,10 @@ allOf:
>              enum:
>                - qcom,msm8916-apcs-kpss-global
>      then:
> -      $ref: "#/$defs/msm8916-apcs-clock-controller"
> +      $ref: '#/$defs/msm8916-apcs-clock-controller'
>        properties:
>          clock-controller:
> -          $ref: "#/$defs/msm8916-apcs-clock-controller"
> +          $ref: '#/$defs/msm8916-apcs-clock-controller'
>
>    - if:
>        properties:
> @@ -199,10 +199,10 @@ allOf:
>              enum:
>                - qcom,msm8939-apcs-kpss-global
>      then:
> -      $ref: "#/$defs/msm8939-apcs-clock-controller"
> +      $ref: '#/$defs/msm8939-apcs-clock-controller'
>        properties:
>          clock-controller:
> -          $ref: "#/$defs/msm8939-apcs-clock-controller"
> +          $ref: '#/$defs/msm8939-apcs-clock-controller'
>
>    - if:
>        properties:
> @@ -211,10 +211,10 @@ allOf:
>              enum:
>                - qcom,sdx55-apcs-gcc
>      then:
> -      $ref: "#/$defs/sdx55-apcs-clock-controller"
> +      $ref: '#/$defs/sdx55-apcs-clock-controller'
>        properties:
>          clock-controller:
> -          $ref: "#/$defs/sdx55-apcs-clock-controller"
> +          $ref: '#/$defs/sdx55-apcs-clock-controller'
>
>    - if:
>        properties:
> @@ -223,10 +223,10 @@ allOf:
>              enum:
>                - qcom,ipq6018-apcs-apps-global
>      then:
> -      $ref: "#/$defs/ipq6018-apcs-clock-controller"
> +      $ref: '#/$defs/ipq6018-apcs-clock-controller'
>        properties:
>          clock-controller:
> -          $ref: "#/$defs/ipq6018-apcs-clock-controller"
> +          $ref: '#/$defs/ipq6018-apcs-clock-controller'
>
>    - if:
>        properties:
> diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
> index fe83b5cb1278..04d6473d666f 100644
> --- a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
> @@ -142,7 +142,7 @@ patternProperties:
>        - compatible
>        - reg
>        - reg-names
> -      - "#mbox-cells"
> +      - '#mbox-cells'
>        - xlnx,ipi-id
>
>  required:
> diff --git a/Documentation/devicetree/bindings/media/fsl,imx6q-vdoa.yaml b/Documentation/devicetree/bindings/media/fsl,imx6q-vdoa.yaml
> index 511ac0d67a7f..988a5b3a62bd 100644
> --- a/Documentation/devicetree/bindings/media/fsl,imx6q-vdoa.yaml
> +++ b/Documentation/devicetree/bindings/media/fsl,imx6q-vdoa.yaml
> @@ -16,7 +16,7 @@ maintainers:
>
>  properties:
>    compatible:
> -    const: "fsl,imx6q-vdoa"
> +    const: fsl,imx6q-vdoa
>
>    reg:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> index f329223cec07..0adfeef149e7 100644
> --- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> +++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> @@ -111,12 +111,12 @@ patternProperties:
>        reg:
>          maxItems: 1
>
> -      '#reset-cells':
> +      "#reset-cells":
>          const: 1
>
>      required:
>        - compatible
> -      - '#reset-cells'
> +      - "#reset-cells"
>
>    "^lpc-snoop@[0-9a-f]+$":
>      type: object
> diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> index 776b04e182cb..1611b1581a8e 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> @@ -400,7 +400,7 @@ properties:
>        - '#pwm-cells'
>
>  patternProperties:
> -  "^regulator-":
> +  '^regulator-':
>      type: object
>      unevaluatedProperties: false
>      $ref: /schemas/regulator/regulator.yaml
> @@ -429,7 +429,7 @@ required:
>    - reg
>    - interrupts
>    - interrupt-controller
> -  - "#interrupt-cells"
> +  - '#interrupt-cells'
>
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/net/ethernet-switch.yaml b/Documentation/devicetree/bindings/net/ethernet-switch.yaml
> index b3b7e1a1b127..03001ba40e0f 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-switch.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-switch.yaml
> @@ -72,7 +72,7 @@ additionalProperties: true
>  $defs:
>    ethernet-ports:
>      description: An ethernet switch without any extra port properties
> -    $ref: '#'
> +    $ref: "#"
>
>      patternProperties:
>        "^(ethernet-)?ports$":
> diff --git a/Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml b/Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml
> index 039eecdbd6aa..fe2e8beb5bab 100644
> --- a/Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml
> @@ -72,7 +72,7 @@ required:
>    - reg-names
>    - interrupts
>    - msi-controller
> -  - "#interrupt-cells"
> +  - '#interrupt-cells'
>    - interrupt-map-mask
>    - interrupt-map
>
> diff --git a/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml b/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml
> index 0febd04a61f4..dd345cbd0a0b 100644
> --- a/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml
> @@ -67,8 +67,8 @@ properties:
>    mode-gpios:
>      description: Optional GPIOs for configuring alternate modes
>      items:
> -      - description: "mode selection GPIO #0"
> -      - description: "mode selection GPIO #1"
> +      - description: mode selection GPIO#0
> +      - description: mode selection GPIO#1
>
>  required:
>    - compatible
> diff --git a/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml b/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml
> index 0df4e114fdd6..fa47732d7cef 100644
> --- a/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml
> @@ -18,7 +18,7 @@ description: |
>
>  properties:
>    $nodename:
> -    pattern: "^gpio@[0-9a-f]+$"
> +    pattern: '^gpio@[0-9a-f]+$'
>
>    compatible:
>      enum:
> @@ -26,10 +26,10 @@ properties:
>        - mscc,ocelot-sgpio
>        - mscc,luton-sgpio
>
> -  "#address-cells":
> +  '#address-cells':
>      const: 1
>
> -  "#size-cells":
> +  '#size-cells':
>      const: 0
>
>    reg:
> @@ -76,7 +76,7 @@ properties:
>        - const: switch
>
>  patternProperties:
> -  "^gpio@[0-1]$":
> +  '^gpio@[0-1]$':
>      type: object
>      properties:
>        compatible:
> @@ -132,8 +132,8 @@ required:
>    - reg
>    - clocks
>    - microchip,sgpio-port-ranges
> -  - "#address-cells"
> -  - "#size-cells"
> +  - '#address-cells'
> +  - '#size-cells'
>
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
> index 5e6dfcc3fe9b..6632bcd037ba 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
> @@ -424,13 +424,13 @@ allOf:
>  patternProperties:
>    '-state$':
>      oneOf:
> -      - $ref: "#/$defs/qcom-pmic-gpio-state"
> +      - $ref: '#/$defs/qcom-pmic-gpio-state'
>        - patternProperties:
> -          "(pinconf|-pins)$":
> -            $ref: "#/$defs/qcom-pmic-gpio-state"
> +          '(pinconf|-pins)$':
> +            $ref: '#/$defs/qcom-pmic-gpio-state'
>          additionalProperties: false
>
> -  "-hog(-[0-9]+)?$":
> +  '-hog(-[0-9]+)?$':
>      type: object
>      required:
>        - gpio-hog
> @@ -503,7 +503,7 @@ $defs:
>                   - gpio1-gpio12 for pmxr2230
>
>          items:
> -          pattern: "^gpio([0-9]+)$"
> +          pattern: '^gpio([0-9]+)$'
>
>        function:
>          items:
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
> index 9364ae05f3e6..daf4c1c03712 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
> @@ -74,10 +74,10 @@ required:
>  patternProperties:
>    '-state$':
>      oneOf:
> -      - $ref: "#/$defs/qcom-pmic-mpp-state"
> +      - $ref: '#/$defs/qcom-pmic-mpp-state'
>        - patternProperties:
>            '-pins$':
> -            $ref: "#/$defs/qcom-pmic-mpp-state"
> +            $ref: '#/$defs/qcom-pmic-mpp-state'
>          additionalProperties: false
>
>  $defs:
> @@ -100,7 +100,7 @@ $defs:
>                   - mpp1-mpp4 for pma8084
>
>          items:
> -          pattern: "^mpp([0-9]+)$"
> +          pattern: '^mpp([0-9]+)$'
>
>        function:
>          items:
> diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
> index cfe004573366..ab1cfe9dcde5 100644
> --- a/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
> @@ -129,7 +129,7 @@ additionalProperties:
>
>      - type: object
>        additionalProperties:
> -        $ref: "#/additionalProperties/anyOf/0"
> +        $ref: '#/additionalProperties/anyOf/0'
>
>  examples:
>    - |
> @@ -190,7 +190,7 @@ examples:
>
>              sdhi0_pins: sd0 {
>                      groups = "sdhi0_data4", "sdhi0_ctrl";
> -                    function = "sdhi0";
> +                    function = "sdhi0';
>                      power-source = <3300>;
>              };
>      };
> diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rza1-ports.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rza1-ports.yaml
> index 2bd7d47d0fdb..737eb4e14090 100644
> --- a/Documentation/devicetree/bindings/pinctrl/renesas,rza1-ports.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rza1-ports.yaml
> @@ -118,7 +118,7 @@ additionalProperties:
>
>      - type: object
>        additionalProperties:
> -        $ref: "#/additionalProperties/anyOf/0"
> +        $ref: '#/additionalProperties/anyOf/0'
>
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> index 5156d54b240b..00c05243b9a4 100644
> --- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> @@ -135,7 +135,7 @@ additionalProperties:
>
>      - type: object
>        additionalProperties:
> -        $ref: "#/additionalProperties/anyOf/0"
> +        $ref: '#/additionalProperties/anyOf/0'
>
>  allOf:
>    - $ref: pinctrl.yaml#
> diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml
> index 5fa5d31f8866..88b2fa5e684d 100644
> --- a/Documentation/devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml
> @@ -88,7 +88,7 @@ additionalProperties:
>
>      - type: object
>        additionalProperties:
> -        $ref: "#/additionalProperties/anyOf/0"
> +        $ref: '#/additionalProperties/anyOf/0'
>
>  allOf:
>    - $ref: pinctrl.yaml#
> diff --git a/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.yaml b/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.yaml
> index fba6914ec40d..948a9da111df 100644
> --- a/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.yaml
> +++ b/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.yaml
> @@ -45,7 +45,7 @@ properties:
>          const: 0
>
>      additionalProperties:
> -      $ref: "#/$defs/pd-node"
> +      $ref: '#/$defs/pd-node'
>
>  required:
>    - compatible
> @@ -83,7 +83,7 @@ $defs:
>        - '#power-domain-cells'
>
>      additionalProperties:
> -      $ref: "#/$defs/pd-node"
> +      $ref: '#/$defs/pd-node'
>
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> index 2c7275c4503b..abf1adca0773 100644
> --- a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> +++ b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> @@ -57,7 +57,7 @@ properties:
>      const: 0
>
>  patternProperties:
> -  "^timer@[0-2]$":
> +  '^timer@[0-2]$':
>      description: The timer block channels that are used as timers or counters.
>      type: object
>      additionalProperties: false
> @@ -80,7 +80,7 @@ patternProperties:
>        - compatible
>        - reg
>
> -  "^pwm@[0-2]$":
> +  '^pwm@[0-2]$':
>      description: The timer block channels that are used as PWMs.
>      $ref: /schemas/pwm/pwm.yaml#
>      type: object
> @@ -92,7 +92,7 @@ patternProperties:
>            TCB channel to use for this PWM.
>          enum: [ 0, 1, 2 ]
>
> -      "#pwm-cells":
> +      '#pwm-cells':
>          description:
>            The only third cell flag supported by this binding is
>            PWM_POLARITY_INVERTED.
> @@ -101,7 +101,7 @@ patternProperties:
>      required:
>        - compatible
>        - reg
> -      - "#pwm-cells"
> +      - '#pwm-cells'
>
>      additionalProperties: false
>
> diff --git a/Documentation/devicetree/bindings/soc/tegra/nvidia,tegra20-pmc.yaml b/Documentation/devicetree/bindings/soc/tegra/nvidia,tegra20-pmc.yaml
> index 7140c312d898..f516960dbbef 100644
> --- a/Documentation/devicetree/bindings/soc/tegra/nvidia,tegra20-pmc.yaml
> +++ b/Documentation/devicetree/bindings/soc/tegra/nvidia,tegra20-pmc.yaml
> @@ -133,12 +133,12 @@ properties:
>            property. The supported-hw is a bitfield indicating SoC speedo or
>            process ID mask.
>
> -      "#power-domain-cells":
> +      '#power-domain-cells':
>          const: 0
>
>      required:
>        - operating-points-v2
> -      - "#power-domain-cells"
> +      - '#power-domain-cells'
>
>    i2c-thermtrip:
>      type: object
> @@ -220,7 +220,7 @@ properties:
>          xusbc    USB Partition C               Tegra114/124/210
>
>      patternProperties:
> -      "^[a-z0-9]+$":
> +      '^[a-z0-9]+$':
>          type: object
>          additionalProperties: false
>          properties:
> @@ -365,9 +365,9 @@ allOf:
>  additionalProperties: false
>
>  dependencies:
> -  nvidia,suspend-mode: ["nvidia,core-pwr-off-time", "nvidia,cpu-pwr-off-time"]
> -  nvidia,core-pwr-off-time: ["nvidia,core-pwr-good-time"]
> -  nvidia,cpu-pwr-off-time: ["nvidia,cpu-pwr-good-time"]
> +  nvidia,suspend-mode: ['nvidia,core-pwr-off-time', 'nvidia,cpu-pwr-off-time']
> +  nvidia,core-pwr-off-time: ['nvidia,core-pwr-good-time']
> +  nvidia,cpu-pwr-off-time: ['nvidia,cpu-pwr-good-time']
>
>  examples:
>    - |
> --
> 2.51.0
>

