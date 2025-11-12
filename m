Return-Path: <linux-pci+bounces-41008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AF675C5399B
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 18:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AF68634258B
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 17:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9C3343D79;
	Wed, 12 Nov 2025 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nn58EgJC"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010059.outbound.protection.outlook.com [52.101.69.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3819D287269;
	Wed, 12 Nov 2025 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762967534; cv=fail; b=AdQ0tQSos/ANXAuR2xcEJYJA3xJqjvipDo0m6Iu7wW01d7imLjphmpbFGF6NhOzLVKZxLnh4I3/uY9SOjsmsuPe6yv78+9l2VbbC5KQSlD8rHy63Jn4MesPTjVz/33dXf1YZa5EHP1MKmUAMAw1SMi2+ljvGO1sV6LgwFI06b+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762967534; c=relaxed/simple;
	bh=ZuYmyWneHHryJ9wv1BK+w3WC4Mch3YSqNWNpNu0gT2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iB3/iW0u1RCN7kpMRTDwtdNY+onZKRwGBXyvtsRjQb+hLUmxpeclAKsSDvNL7q3uZq8hrx1t0TdiTX4aApUe2M2eNvWAAhHje3ZZrI5OxAUDvOM8J2ftGWfV+37Ml9XJIetKhDbkw/Hb1DECFguc5yXC26+lVh2SUqYF3kISB/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nn58EgJC; arc=fail smtp.client-ip=52.101.69.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AI91DVlqZXkZ+hjJVzfuqjwwD3GcAwNv4bZOwqBismi0Q6K2VAb0LxtjtAXK5VTAphXetlr+YpaGVjCNEd+Vdq7aqzbtw+jL/hLhEbRWZsGLzgy7sgl5xYHxv/WbMFTO8w+rVoaBG83d4D0TnM2/hW8LrcoR8l21bjHRkbZzS0KFRHasMdBV2aB6YtEBeG1Afu4hKtbpWSiscPnNn4xKrx+zh1qkqACjDDRZ78vO8XezpizGDBCURr22kKotugpXAkMoyFJfGI6k0i2XWYkM4dVXddC8YMd2Fmygztell3C3e9szgZ6gwubwytipes//KPs247oEFdQor2u9kDHrMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmrv36jZN9yzuM0+8LBDBblqfY4cEQdOCvS8YeNHHtc=;
 b=ZRDKb12fb3pwgoGwwBqoutQ+lyQMn8d+JD8hNLbwxuQLsgNL+gO7flVwWsFtihF6k6OsWk7A4hCtKdbOeY1VHTxCdrLl/5UWkJ4MlX2zu7PmNeAxdLfUi/qMLLCZg4bTiepf/sNG9jZQDVW5b2qEngTVUwkp1MemlMA4HnzzbfkqffIPj1nfUGM0n8QdTuzTY/vokU9Tb94qf+RzauCuV97lRFgVPunNdDrlXVn6MfJ7LgZf3rYK2dLwN5/FUUQVDzlIkqVTSoFPDefMJ+JGhL4Q/LETs0OO5f3GyQZFvsW1OwZ7rKaV01zZ4nSSufHeL98aCQXixzD9xEbZbd8tHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmrv36jZN9yzuM0+8LBDBblqfY4cEQdOCvS8YeNHHtc=;
 b=nn58EgJCWeTqFkY+hQkBaZ5Q9subL2ZCu3P7gyBWdPKG0jHuRIG0IRQnzyNRzvor7x99q5+EtGn6P/8Qz6hyp+MwmLfec7WGajnZna/NTTsfo4Fzcq/XbBuwgiytPGyb35a0pSChynbEFTlJ79Ae5TRrM6tRNQ57T4jc7alSObuDhXKLoIZr6FLz9q+8MS3XWcqWvdygBMr3bn89btXTTUM61Ar3QoV0benkaYynr5mmTf9BtXzIAJIhn/9D0WrxH98pDUKX00XIpWo3DmzqcColIxdIJf7kYjQZcDp78ahLkwkByHRtSDhh/o4Q3afTRPpHgloj9uAf3laIUSTPtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VE1PR04MB7248.eurprd04.prod.outlook.com (2603:10a6:800:1aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 17:12:08 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 17:12:08 +0000
Date: Wed, 12 Nov 2025 12:11:56 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH 7/9] dt-bindings: connector: Add PCIe M.2 Mechanical Key
 E connector
Message-ID: <aRS/3OTerCBGlmBm@lizhi-Precision-Tower-5810>
References: <20251112-pci-m2-e-v1-0-97413d6bf824@oss.qualcomm.com>
 <20251112-pci-m2-e-v1-7-97413d6bf824@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112-pci-m2-e-v1-7-97413d6bf824@oss.qualcomm.com>
X-ClientProxiedBy: BYAPR21CA0013.namprd21.prod.outlook.com
 (2603:10b6:a03:114::23) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VE1PR04MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: 4be0cb94-401c-4dff-62cd-08de220e9c8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i9CHscv8ODzs52SvrSW4uiwubThFwmZHUWXHJaq5qt/SmceBcXhxZCiV45Bu?=
 =?us-ascii?Q?oKK+7ofIjZi/creV34ilHUwOrdlIQ/NijKvgpEl5M8LSVtWi/EqnfNY5Hzog?=
 =?us-ascii?Q?M0rBKTq6CNh968KZufzDaB49LcXFqB3ll+zNrKHRGhdB+hweM2q6LFTMVD4h?=
 =?us-ascii?Q?+17wXIYNKGCUjGjwwCzOV+Ja8jnvc2V9AWgwdeeE0N/rXsJ7R6zLJKLztiH/?=
 =?us-ascii?Q?W+GdWhfD18kJhmSIxEAorAVBUcAvof/hVXRUthT48MCcrRxsWBZvxQqwqDfF?=
 =?us-ascii?Q?LmID49SUuxUawSQ2DLZE6ofobQnp9tH9fKOyJdiEHuBlsBWJwPfzYn1Nu6ER?=
 =?us-ascii?Q?1fc6JgPQHBmcazo8tY+alOgkyT5Y/65DPZ+NKTacR9FJUbM4NrhjCVKc9rD6?=
 =?us-ascii?Q?SYvtA6SFMpyKhsNCffO99xokmtawF3zfLmcV6Zey+sYubly6tzhTsQwoNTbq?=
 =?us-ascii?Q?GvosZBSKUzCKTgvEJ1VqlKl1x1IWGPrtItrIEYjlqlmhUXVQ2okLmZDYGwtk?=
 =?us-ascii?Q?uHFZCPy01OB5Z5lZB4/kiX+u76wC3w44Ryh+pRimKlJTd31q8MOktzNx3tQG?=
 =?us-ascii?Q?6eFIM3gmZMRbnsBXO2heJAutE2rSE8Qse0ZnMaAASBvg6XwpR2eEvnmGW7rj?=
 =?us-ascii?Q?c3Lu/vORBQkEMVddgapaX8NzpzHIVx1J/RX8ak439hg+QtrY3clxeNDOPRHh?=
 =?us-ascii?Q?/1QNzpaFJVSczEk8FFoPNaOqZ8LSaA9b1YIa969LhQccimsWQuDtrB/VmgBj?=
 =?us-ascii?Q?68f1DCHC0ZqYMqUH7NLmFnwXvNXaSGS39D4Cv1IHdi4D5rXB3Z5pb8GENgqA?=
 =?us-ascii?Q?HWBjtefDjAqou6EiXcoklkM9+XrGMQvTEn+Nz1xKbhSL1KkqPH7I8M9V7XGg?=
 =?us-ascii?Q?bp6i6C5GJmQFUhaA7MzV8tYq3b7TWhtOszJL5/YPzx6J/hXOHyVE8qgIdwmw?=
 =?us-ascii?Q?j0qzalperWih0mFRe18TZEht+2LTZFa563o25JreVXSNy1jjtv1mpB9+t7F+?=
 =?us-ascii?Q?by3sr0W8MPIkZMO1Cs8oGIUhwsqkf+3++cEztXeS5g7S7FVyaOLb1OAj15MA?=
 =?us-ascii?Q?FEYIFctuAlDad1oLOjokMRqX6cxLLe25Y3JZpjBIKwl+btGC7LjG6IuLBOO1?=
 =?us-ascii?Q?VhhPJc4Uc6vbtLtN3OiRhW5R+ufd/T8+cSjSIvOOjYvBSx5Xiif18zIYE/Wa?=
 =?us-ascii?Q?uOiJgrnx1iQWvRzllOiMlKfvzm53KVGf53eWdM1cDMl8eb3oG/ebar3IGenC?=
 =?us-ascii?Q?P+LD+KWM2MBZtCALkLx3Vv6sW7DqwRQ07cBrz5uQlcYQ0CVLhvNCQCjooGsR?=
 =?us-ascii?Q?bpfoMF8AH94malIgeuiaAJ+XtP/ZNJGN2uE2eRMLa5Ook6joC3oPGXBLheH2?=
 =?us-ascii?Q?YrFlN1m21P6rDS3d6KqUzIWa4q0tm6YuVo+3Mzql2z6+AKSjBwovyp1eUhwf?=
 =?us-ascii?Q?WWZWye1pKtJMS007GByxDd6HlasDu5ZwNnZLzVYyXwPWF3ugXtkOXw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wiZ2hq0HDnsBMbaOyFkfRoqjWMeWX/7s2ruBIACg+tAhJRWbYYywjKgHxVVT?=
 =?us-ascii?Q?gfjQsFGS3Y994oXGv0035QbrMWMfuo43PCZ8uLpO/kPDVnejQ2l2drRHUBim?=
 =?us-ascii?Q?T/3eOdYLGEsGDhIjXVALixuQIGAd3Fbx+d94Fkjc6jOg5cIHNCqPVmU+REIR?=
 =?us-ascii?Q?2tisA9O5EcMKi3pB5n6rqgk+kZtTisf0YUwSZweFG4Oc7pyFNm/rK2eOPjlq?=
 =?us-ascii?Q?cheXal6IvXC/8twdlo0LNbNvL+Cq41Hjk5XaRFQtXK/BsenA3cOzuWGBp92d?=
 =?us-ascii?Q?cHTfFPrmjYTNZewBuYWvYEIkBbrQzuCZKnwG5bJjnxErYzSOoWgIsqGFiD2z?=
 =?us-ascii?Q?OV69w6oU2f5ZSnyNGw4ZPeKsjIIZE9aLDx9Q+3x5GfOHwWwT0y3fnpzEDH7O?=
 =?us-ascii?Q?6yMSZ8q5i5DOOYOrp4n+hMNrvJVwFoncqZpNd1B0abCBnTnBlEanyN8EjRUL?=
 =?us-ascii?Q?AaM4BA6/YSmlguxsj77TjbZupkoMbImzMjmK01D62uVAbUHkspiSsjcAhs7M?=
 =?us-ascii?Q?ZGf1bQZFAwLIv08TK6uhL8EQNYhYx0Vzn7yXjwpYSJDsYLwcoxHYcz44VKCz?=
 =?us-ascii?Q?pmZMvSHts9Glo7xGojDG2Hevj0rjabZGBM0gFWjTyRuEtfFXLj4w/7ZZui7H?=
 =?us-ascii?Q?6Z0yomvLzQINda96fWzG9K66aFNQQ39nhVrPRK/Q1BK2+38Fw8G79ZGf1rMJ?=
 =?us-ascii?Q?50Fuqbds4TC6k6ttQjKinuUVuc4AxkN71k3U0xjGeaO2EPjt3X2mzafGDCS+?=
 =?us-ascii?Q?xlvAWI0iZ4dqOrdI4EJBAjpj/L0Kta2Nty82jHJKRa/XpHpjteYOGLJ5jG9W?=
 =?us-ascii?Q?amVftOD8NwU+PXRPFU32ttb5PM/NsNFngr8jRF05Lg5e6HkAORU/sLvjIrX2?=
 =?us-ascii?Q?+//L49SBig5vXgMbV0BpTUKizntwiLw7q/+GReB5+/foaRZNgRui8QpmoSiv?=
 =?us-ascii?Q?Gvbp4r1bh+dK9OC+cjwRwv/kKD2ioHd26Rcpcq5/QgEbsi84WDY/uf5BWPti?=
 =?us-ascii?Q?YJ436HPS8v/xiI6BfYPjFRH9uhpJHjYrbAPvWCsXme4xFbALnkd0jOdA0GBv?=
 =?us-ascii?Q?Oi3cmrQ5yfxEK/AuD5JBL14sLREfeesIyXMRefE+hEe2b3RHL4sinpr6Ad64?=
 =?us-ascii?Q?dsXyaUa9H0LtFaeTVBGkP+QixwiyF1E6oWlsJF8tloyKGLpn+JeEJlT4/HgU?=
 =?us-ascii?Q?3RmLVLaV/XN/zHPJavpkGR21D8QeNaPYELkG+Z5QbPHrcYcnStd74CLT/sh9?=
 =?us-ascii?Q?fOXZTkji35ZRH4qK2bfTPe5mZb5jSm9xuKV4f67EoRxIJlGMpJf2c0m9Rigl?=
 =?us-ascii?Q?ED6XG/YviDapjeBEfsr6hURe/Iw4svFy9rOWK6z65RTzrQUqMq11WSNz3zGJ?=
 =?us-ascii?Q?y51HtJTnSzg2Y4OrSpXMsB25cFFXkz1rpzAduQJvCHRr77hum96mzrppUTnA?=
 =?us-ascii?Q?b0l3YdPSh8pr42osf6bUzd6q4OdRWIjbTS4c9jTo+UUvWTlNgdpbS1ZoLkxo?=
 =?us-ascii?Q?g+KuW69g4gAKnkwQ8DoU/sxy2vHFqwE4RZ6UNaxIw3qijvO4yYSQBfExsFHb?=
 =?us-ascii?Q?AZWZN1sQB5dV9EoKRBVOOyxmnVPnC8l22NZ7xVo8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be0cb94-401c-4dff-62cd-08de220e9c8f
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 17:12:08.6014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7KctrvqL6NkjGmPSwYfV34+EXn3njsr/xC35ZsP+veAAf+KSS/L6nu3un1HRSxjUYMQ7JyIqalzpe2EL7a7vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7248

On Wed, Nov 12, 2025 at 08:15:19PM +0530, Manivannan Sadhasivam wrote:
> Add the devicetree binding for PCIe M.2 Mechanical Key E connector defined
> in the PCI Express M.2 Specification, r4.0, sec 5.1.2. This connector
> provides interfaces like PCIe or SDIO to attach the WiFi devices to the
> host machine, USB or UART+PCM interfaces to attach the Bluetooth (BT)
> devices along with additional interfaces like I2C for NFC solution. At any
> point of time, the connector can only support either PCIe or SDIO as the
> WiFi interface and USB or UART as the BT interface.
>
> The connector provides a primary power supply of 3.3v, along with an
> optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating at
> 1.8v sideband signaling.
>
> The connector also supplies optional signals in the form of GPIOs for fine
> grained power management.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  .../bindings/connector/pcie-m2-e-connector.yaml    | 154 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 155 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..91cb56b1a75b7e3de3b9fe9a7537089f96875746
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> @@ -0,0 +1,154 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/connector/pcie-m2-e-connector.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PCIe M.2 Mechanical Key E Connector
> +
> +maintainers:
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> +
> +description:
> +  A PCIe M.2 E connector node represents a physical PCIe M.2 Mechanical Key E
> +  connector. Mechanical Key E connectors are used to connect Wireless
> +  Connectivity devices including combinations of Wi-Fi, BT, NFC to the host
> +  machine over interfaces like PCIe/SDIO, USB/UART+PCM, and I2C.
> +
> +properties:
> +  compatible:
> +    const: pcie-m2-e-connector
> +
> +  vpcie3v3-supply:
> +    description: A phandle to the regulator for 3.3v supply.
> +
> +  vpcie1v8-supply:
> +    description: A phandle to the regulator for VIO 1.8v supply.
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    description: OF graph bindings modeling the interfaces exposed on the
> +      connector. Since a single connector can have multiple interfaces, every
> +      interface has an assigned OF graph port number as described below.
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: PCIe/SDIO interface


PCIe and SDIO is difference signal at key E. why combine to one port? The
similar case is USB2.0/UART

> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: USB 2.0/UART interface
> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: PCM/I2S interface
> +
> +      port@3:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: I2C interface
> +
> +    oneOf:
> +      - required:
> +          - port@0
> +
> +  clocks:
> +    description: 32.768 KHz Suspend Clock (SUSCLK) input from the host system to
> +      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.1 for
> +      more details.
> +    maxItems: 1

Do we need add pciref clock here?

> +
> +  w_disable1-gpios:

use "-"

w-disable1-gpios

> +    description: GPIO controlled connection to W_DISABLE1# signal. This signal
> +      is used by the system to disable WiFi radio in the M.2 card. Refer, PCI
> +      Express M.2 Specification r4.0, sec 3.1.12.3 for more details.
> +    maxItems: 1
> +
> +  w_disable2-gpios:
> +    description: GPIO controlled connection to W_DISABLE2# signal. This signal
> +      is used by the system to disable BT radio in the M.2 card. Refer, PCI
> +      Express M.2 Specification r4.0, sec 3.1.12.3 for more details.
> +    maxItems: 1
> +
> +  led1-gpios:
> +    description: GPIO controlled connection to LED_1# signal. This signal is
> +      used by the M.2 card to indicate the card status via the system mounted
> +      LED. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.2 for more
> +      details.
> +    maxItems: 1
> +
> +  led2-gpios:
> +    description: GPIO controlled connection to LED_2# signal. This signal is
> +      used by the M.2 card to indicate the card status via the system mounted
> +      LED. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.2 for more
> +      details.
> +    maxItems: 1
> +
> +  viocfg-gpios:
> +    description: GPIO controlled connection to IO voltage configuration
> +      (VIO_CFG) signal. This signal is used by the M.2 card to indicate to the
> +      host system that the card supports an independent IO voltage domain for
> +      the sideband signals. Refer, PCI Express M.2 Specification r4.0, sec
> +      3.1.15.1 for more details.
> +    maxItems: 1
> +
> +  uim_power_src-gpios:

property use -

Frank
> +    description: GPIO controlled connection to UIM_POWER_SRC signal. This signal
> +      is used when the NFC solution is implemented and receives the power output
> +      from WWAN_UIM_PWR signal of the another WWAN M.2 card. Refer, PCI Express
> +      M.2 Specification r4.0, sec 3.1.11.1 for more details.
> +    maxItems: 1
> +
> +  uim_power_snk-gpios:
> +    description: GPIO controlled connection to UIM_POWER_SNK signal. This signal
> +      is used when the NFC solution is implemented and supplies power to the
> +      Universal Integrated Circuit Card (UICC). Refer, PCI Express M.2
> +      Specification r4.0, sec 3.1.11.2 for more details.
> +    maxItems: 1
> +
> +  uim_swp-gpios:
> +    description: GPIO controlled connection to UIM_SWP signal. This signal is
> +      used when the NFC solution is implemented and implements the Single Wire
> +      Protocol (SWP) interface to the UICC. Refer, PCI Express M.2 Specification
> +      r4.0, sec 3.1.11.3 for more details.
> +    maxItems: i1
> +
> +required:
> +  - compatible
> +  - vpcie3v3-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  # PCI M.2 Key E connector for WLAN/BT with PCIe/UART interfaces
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    connector {
> +        compatible = "pcie-m2-e-connector";
> +        vpcie3v3-supply = <&vreg_wcn_3p3>;
> +        vpcie1v8-supply = <&vreg_l15b_1p8>;
> +        w_disable1-gpios = <&tlmm 117 GPIO_ACTIVE_LOW>;
> +        w_disable2-gpios = <&tlmm 116 GPIO_ACTIVE_LOW>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                reg = <0>;
> +
> +                endpoint {
> +                    remote-endpoint = <&pcie4_port0_ep>;
> +                };
> +            };
> +
> +            port@3 {
> +                reg = <3>;
> +
> +                endpoint {
> +                    remote-endpoint = <&uart14_ep>;
> +                };
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9b3f689d1f50c62afa3772a0c6802f99a98ac2de..f707f29d0a37f344d8dd061b7e49dbb807933c9f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20478,6 +20478,7 @@ PCIE M.2 POWER SEQUENCING
>  M:	Manivannan Sadhasivam <mani@kernel.org>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
>  F:	Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
>  F:	drivers/power/sequencing/pwrseq-pcie-m2.c
>
>
> --
> 2.48.1
>

