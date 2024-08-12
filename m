Return-Path: <linux-pci+bounces-11598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BF594F4AD
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 18:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6971C20ACD
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 16:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A60718754D;
	Mon, 12 Aug 2024 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NTU+2r4+"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013057.outbound.protection.outlook.com [52.101.67.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DFC187345;
	Mon, 12 Aug 2024 16:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480395; cv=fail; b=VMxBhQgtNoWpRtVmGLCT/5LTxz449ROAewCEwEnFw0Mb8iLnq5ONAj3l7WcFOl7A3CazWSYfYbDVR5QqFI2bZoPz3L1XJ7FeVAPjg2vdo8WpE8a+2GbKbqtvc+bwx6qQOsenSE5rPwJ7L3IuSt6rCT1D5LjAgx0nl8p3yw4sAZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480395; c=relaxed/simple;
	bh=fDPgZQPXuMpVXXsL84tH95PwwYaTeHKfTOdDWaHy0f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OtTZ0++oooUwSnR0zxP0URfJhTvSGMKq7A4J3S789W7RSp4InjnZtXe4tSsfBASVRGvDA8Plnc4z7/9MWAOVFVYq0nczwK7r4uBJRhByMK/4/b8NnP0nMSTs07ig1Y0mdBdJDx5rK/1eafTQue8FNIm5OkGx5m25QQXjnFjU0oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NTU+2r4+; arc=fail smtp.client-ip=52.101.67.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egUWIJ2g+yHODZ5p3E30J4R0PLi22TSYtcJuCxZUqJnV8zFx4Zim/Dbdp4m+c/WBrf+i2+slJCqp6rRh3X3mY04CstUpXvHuDVPu9wogxaiUubJ8tUGxUn/GE8gz0Q0Lsw08sIMib1medw/Ef50iLGeXUvr11vtK0fpAkEtjhG9tT6L28QG2SW9DjpHE0kMXi0p5v7AYFQdugef4zkWLjY1mRHG9Dwz4Xui0m2TVygB8/IQkX13MR+hfJlToVE9OKP9KhX10JCVAUsgAxS1H9w3ngdlM5jZwZkylXDXzubRPRg+48hRE5DKQiORLsTEvyHd/fh3v4FW90KQodsHO2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9JVGF50MGwBbP2iPqlynpv/BCgrbq0nw269KsWIDkg=;
 b=qaL9gCDdBbblOw1Bd1HIyYVhWvcKfzVdtzceQrf0mS4HHo4yhNUnkY2XRw2xXS2Zyj1dMM2AQrFMv7UhCsPgcKP2PdW6CALQbk+oQNo5IySLrpHZ36f00pl1sETYRls74Tb+HQD4LeVKKqcSQ3GVHRnSXZXZDNEGO2sf+0L7+mOYcTVhyok3EbsrcMCaJ8WKky9B/CoGpAZlt+J3Vzt50LnCwnMYgLV9WZZtfumHQ4Bd4OjvdYJ8EF0GrXpobn1JcYsU4MeGMKmAF8k+X2aXc+zE9dARsbXujqnCL5636XcK4pXa5S7awwxhqolR4glD4CBOfxOhTLR+qREbjZVf/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9JVGF50MGwBbP2iPqlynpv/BCgrbq0nw269KsWIDkg=;
 b=NTU+2r4+8AC82QDO/gozx81nJ/XJnZdiP3N2mUDLeCz7pysqoTE+DpleV9j0ohsZJ8jmw9NOSBKisVACg7KpsK84V+7UPm9+D/on+gnd1hsNNnqADhpc9Tj3dROpYcFxPPB9nAv7utBtvYmLw46Zwv2U8U55GFF0Qwo1OrulqitEIzFqTqTEbLHA5FwYM0F+72Z1lQpl4cJRT/J2nV2gCuMtz4tpNUgDOlE5doaJEORGbAdu3WUTqsRQajADsgR7JjziaosG7K7Kh7LXRQ31waZALBKykYL5jJh37ot1LRlluZ+R4HvXTWkP3wwMO3s4yVxazh4QRo5OLeBDo2oHCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6941.eurprd04.prod.outlook.com (2603:10a6:803:12e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 16:33:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 16:33:10 +0000
Date: Mon, 12 Aug 2024 12:33:02 -0400
From: Frank Li <Frank.li@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev
Subject: Re: [PATCH v3 1/1] dt-bindings: PCI: layerscape-pci: Fix property
 'fsl,pcie-scfg' type
Message-ID: <Zro5Pi2LbnCjBiNA@lizhi-Precision-Tower-5810>
References: <20240701221612.2112668-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240701221612.2112668-1-Frank.Li@nxp.com>
X-ClientProxiedBy: BYAPR01CA0010.prod.exchangelabs.com (2603:10b6:a02:80::23)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6941:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f8561b1-92ae-469f-59df-08dcbaec73fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1lPRVVqTitTMzVqY0lYdHVHdngrNzNoOEMzMHE5TS9veDBvdlNJMmRhUVJL?=
 =?utf-8?B?eDNqeGNnSUNGUjBrRjFBWjYxYWRDcUdIWnN6cEZzY0dDdXl2ZlR1dUZZKzR1?=
 =?utf-8?B?QWZJWmg1UWRPZDlIaWtjd0s0QkNtZDFNemE1Zm5xVytXZUVuemhsT1NxSFdR?=
 =?utf-8?B?alR2Z3pYNkpkQ1hIZWFkdmNxZG11WTRRR01VK0RwWFhuSHBOZXZoZ0RyZk95?=
 =?utf-8?B?c3h2Ny8ydEcrYTVBWXBPMXZ0MEllTHg4T0JkZzFOS0ltSU9MSDlwQk5lQ3NV?=
 =?utf-8?B?SFlDTWh4V285UDg2ckdiR1J3OVNvLy9xUk4yYVA4Y3VGekoyVkhpdFVERlBn?=
 =?utf-8?B?UWJuenhxY3dpbnZqMnNUWm1lUGRkT3hGa2JIeWZucEY2WlZTWjJ3WHFwT1ZP?=
 =?utf-8?B?M1RWRTAxeVY0amFlTEFTUU0vVXpWQnl3OVV6YVdhajRGR0VNVUVZd0VLbUpk?=
 =?utf-8?B?aDlzdkQ2akRqZktvV0srU2liNEx6eDZsN201bEJYSnUzdEdaYkJ3S0hmMmRY?=
 =?utf-8?B?TnRwYnRqZUEzRHFHRzU4T3pxMjM1WXBhRndnMHpkQWlQWkcwTTV6V3hPdnk4?=
 =?utf-8?B?OUZzVGdyb2FFR0EwNzQycDJqRG43M2syc1JsOFJacDFHRzNMZ01Bd1ZKdkUz?=
 =?utf-8?B?RmdUbXlpeUFmTDVDMVpjWTF4QStPazAxMS8xSUx3ZXN3S2Nld1ZuZ3V0TU1s?=
 =?utf-8?B?bTAwMmJyZWI1Rkw5MWREcVdGbW5aTmlyQmt3Tlp4S0ZwdUYxT0hwM3hrODlG?=
 =?utf-8?B?NzRtWW5nbUxOQjlFbzZWOCsyb0tsbUV3VW1ISi9jZHJpNkROdkpxSy9YUlpV?=
 =?utf-8?B?RG4xM0FOWGd1NXIyaVZOejBSVlJ5bEJWWTZ1MUp1S1VFVHRZTVo5L2dkOExX?=
 =?utf-8?B?REJpZjg4TG40cWVyZkhHbXZ0YkdzTnMxTHBWYnhTdEJKMnRSZkZieWRoTEhE?=
 =?utf-8?B?TmZrMFNtRW5ZOXk4R0VTbFlUUjBjei95dGZJK1N5bWF6bWl6T0xZeWdzSE14?=
 =?utf-8?B?NHZhUzNnNjRLS25aR1A0Qm9KZEdrQ2hQWWo1cjVvZW1GcnhXaUVmQ0FrSWl0?=
 =?utf-8?B?ZHUrVjV4Rkh4TVhodnBGREVsNnNhSEd2YW5iMXR4dGlPT1NFQTZrenRnT2sx?=
 =?utf-8?B?aE1SZmtZTTd6YVYxK2lsZnJGYVdzd2M5ZUZMZ0N5UGQ0anAvQlNRMXczZGVW?=
 =?utf-8?B?SkI3R1laUHAyYnJKQ1I5NDRtaWUyVzg4SEhBVjBzeVJpK2J2eXhTWXc3Qnoz?=
 =?utf-8?B?dG0vS2hnT3ZjT3hHNTR5TUxOVHRqaE42UG1UQjU5Vms0WXcvRHZBYlplZXJp?=
 =?utf-8?B?NnZSZWZtUG9OYXk1VjhVQ2gxY1NGbVQ1NkdXdFFrTW9acitkeEN2NVQzVHlp?=
 =?utf-8?B?WlpWL2J4YXVlaWhWNU9Hb1U0ZEtTZHM0bWVxOUlaTjJqUURqVmxlRnpmZW9j?=
 =?utf-8?B?eDcxZm1Ba0E5VHpwaGFhbmp2amoyNGRTMFRBUGQ0V0dINDNuK0JjRlZFT2Zz?=
 =?utf-8?B?MU1heGtFODBmYnpyNThmaTJhOWFydlNSYm8zT1hZWXBNYjZPWUJwSTdsY2Z0?=
 =?utf-8?B?bkxJeHkzam4rTjMrZGJyY09FN0MvYWZXakFNY3lRVzF1VnZuSklDdlA2dTI2?=
 =?utf-8?B?eFVXSUJkYjVhR0J1VTVzNjRSalFVOUhseVhiN0ZiK0RXQ3lUKzVqZmxJcnJv?=
 =?utf-8?B?N3g1TmZaT2Q3bWxkTmpPWE1VdkpnTTdHTVk4bW5RMzNQdGRpbVhjU3ZWdHNI?=
 =?utf-8?B?bDQ5TFcrR1VDSy9QdVlGSVFKbU1jeE1Oc3FyVGhoZklTSFBYUDBIQ2ROMFZn?=
 =?utf-8?Q?YTaCpCCLUk6L8EV1qeRsVppOnmTYmxIXkye0A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmJyNXYwNkZ4L2s0MG1DaTdnWHJTSW5pbE92R2VCTk9aMGJZbkRHSDdhNVdm?=
 =?utf-8?B?R1N1eXljRTlDRHZWeWJob1JJUXVqc1FtR2NGRmJKMkVvZXFpWlVjQWphWGJ3?=
 =?utf-8?B?RGMxOU5xellDZVVmSGpycnIrK0pGNEl3WjJRSmxWaGlDZmE2RCsxdk5BaGM3?=
 =?utf-8?B?ZFE4MjF1T2w2RmlhcnI3ZjdiTEpuQ1JLanBUaFdMSjNYV3pDV25zZEVVc25W?=
 =?utf-8?B?M1dRdHlzTHdkZFdYMXEyTDlXWDFjTS9FY2E4R1JEajRCK0lFVjcyQS9kSVlK?=
 =?utf-8?B?bGVDYmw3RDA4U2QzYkZ4VDg4bTVkRmlxRlhlS2c2Y3FLTHdXYndXUm1kdWY5?=
 =?utf-8?B?YVd0Ulg1UEZBZklGdU81eXgrdHpJbzhYZk1BSVA3c2NUV0ZaN21PSGJQN0pp?=
 =?utf-8?B?WnNQcTIweUV0ckFXc3F5TnhsYlZrTXZlMW5BRktsZms0cUxoODJsNkhuRGIr?=
 =?utf-8?B?M2ZCL3d6OEpreVdycmhCMEZXVklVVEplc3BSYTFlQ09QaFlTaWVNZGNXYVpn?=
 =?utf-8?B?VExlTFhtQnB5dmJuNG95RUFRd2lrRVg1Q2d3OVBWUkRldzBtOHNLdnlVWGNW?=
 =?utf-8?B?TldlM0g3a2swMjdOSHZJVWdRZUJGdDg5Zm5xR3NBWVBBdTE3M3JNWEpmeHRT?=
 =?utf-8?B?QVFTNjdMZDhzeElDcHlnakd0UFNvc2NxSzlQUlJjV084dU4xeDMrOWtFc0dS?=
 =?utf-8?B?YnQzU05XRFdpNkpIYXdLVVk5cUh5WXZlazQ1OFQzbUhhMDBKckhId2dQc0ZZ?=
 =?utf-8?B?bFZOV3BJbkkwd2hOdlIwQ3k4ZmF1S2FmUDJWdmVzZDdCZW1Td1NKY0lPclJG?=
 =?utf-8?B?WEhYcVZKNHd2aHVLVzlLUFN5by82QXM3b0xsQmd5SFdpQmpwQUs2TUYvN1B3?=
 =?utf-8?B?YStwRHpYczNqMnF0N0RuQTVZR2lVcmY4S0M3QTkrM0lWc2hzLzdjVGdEUFB6?=
 =?utf-8?B?WTFuZ3NkVzh1cUVxY0ZENzhyOTBoVEFSRzhxUk1zdmJyTkpIeFhNVDJxa1R0?=
 =?utf-8?B?cmxURFlFbnNweFIrM092ZUJQeDNrS1NPeW5iRDNQZ2ZTNnFOWm5VRVRyT1Nq?=
 =?utf-8?B?Vk51U2tvY2ZkdG1oRFVNcWRlMG1rT1NXRTVtckEzN2h4VDBFOFZIZzNRM3lH?=
 =?utf-8?B?SmNueDJjMkFmaDN6eExCTjQ2N3ZveUZoVDkwQmFWblZ5YUtyWDhlMVlucE94?=
 =?utf-8?B?ZzYrWlBDbU00RzVVUTJFOW5wZTgxejNUbG10bUxORXZra2ZXOXdiOE5jb1Iv?=
 =?utf-8?B?OU9VZXh5bDg3NCtiM1VoZ256R0R5dzdXMVNiS09hN1pOMWlpdTdNbE5xY1Zj?=
 =?utf-8?B?K3N6Z2RJNDB5MWczUCticWIwQkhjSzJVYk5GY0RVYytIUC80RW1RckRKVFVt?=
 =?utf-8?B?dXZ5WWlJQitQakJjM2xkcXovVGJjcFJUd2hNaTBsd2d0akdvSm5rejdqL3Mv?=
 =?utf-8?B?MzBRb0NwR1A0VEVkT1p2S0xJSVA2YXVqWWgvdWVxVWZ2Zm8vRVFJem42b2tT?=
 =?utf-8?B?WjRFbUs1K2xTK2g2c1VKVG9CdGg0OXJ2eE5FcUMrVXlpWk4zMDJKQklGcGxi?=
 =?utf-8?B?aFpCVkZTbUEwcGQ1bW00MmFxMGl3WmFRc3owQ2FnWmZvNzYxNWJQcUFYZUVB?=
 =?utf-8?B?Qkt2WWFzNVlrSU01TEN1OEFvUDZZRC8yRkpCNkxkbGFqcUkzWWhMWkhmSnhQ?=
 =?utf-8?B?amtWQ3ZsS2xGVkxRS05GaW5QZEdIeElDaFdkYXFyT25zTmRDSngvTEwvMjBR?=
 =?utf-8?B?Z1hQVlRoMFJUWGpPTjBuQS83TDhJV2NtYXhSNmlmY3BMRkFNRlkydzNWZzN3?=
 =?utf-8?B?ZllCSnFGak5iSk5NMGVlczNYeEFCQ3BFdFhiT2xZQ1dkSk9VckpUVEJ3ZE90?=
 =?utf-8?B?ZStQZFNLZis1VFE2dkdNbE8zVE9tcVRPQU1zQXhtdExDYTJvRWpBWXc3MmZC?=
 =?utf-8?B?Snc2SVBscEpwenFMMDdSVWZjb1ZYamlIbDg2ajZyYkRzWkhpTmM0SFJwT2JY?=
 =?utf-8?B?Z3h2K05vcnhFcFNBbXhXaW9hWGlodXpFY0UzZVR2QUZEdDc1SHluQ2NRcEVr?=
 =?utf-8?B?MWtRcmRCdXpIRm5HbzVlcUFvdkI5RVRyK3RtTSt0Z0ZBM2NJL1VhQTBiTS94?=
 =?utf-8?Q?Dzl2YtUt/LwWtEh10uL5uOtNc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8561b1-92ae-469f-59df-08dcbaec73fb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 16:33:10.2638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCCE0dLALHhi9i5E4YQC2Di7h1Opoccp/+Bv3v7F1S1GYKfzfMvR3WnrrTPmPOrlEsOLJ0NrGfAN+tW/7yMrjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6941

On Mon, Jul 01, 2024 at 06:16:12PM -0400, Frank Li wrote:
> fsl,pcie-scfg actually need an argument when there are more than one PCIe
> instances. Change it to phandle-array and use items to describe each field
> means.
>
> Fix below warning.
>
> arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: pcie@3400000: fsl,pcie-scfg:0: [22, 0] is too long
>         from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie.yaml#
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Bjorn and Krzysztof Wilczyński:

	Can you take care this patch? Rob already acked.

Frank

> Change form v2 to v3
> - remove minItems because all dts use one argument.
> Change from v1 to v2
> - update commit message.
> ---
>  .../devicetree/bindings/pci/fsl,layerscape-pcie.yaml       | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> index 793986c5af7ff..741b96defcc95 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> @@ -43,10 +43,15 @@ properties:
>        - const: config
>
>    fsl,pcie-scfg:
> -    $ref: /schemas/types.yaml#/definitions/phandle
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>      description: A phandle to the SCFG device node. The second entry is the
>        physical PCIe controller index starting from '0'. This is used to get
>        SCFG PEXN registers.
> +    items:
> +      items:
> +        - description: A phandle to the SCFG device node
> +        - description: PCIe controller index starting from '0'
> +    maxItems: 1
>
>    big-endian:
>      $ref: /schemas/types.yaml#/definitions/flag
> --
> 2.34.1
>

