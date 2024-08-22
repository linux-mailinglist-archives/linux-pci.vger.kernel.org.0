Return-Path: <linux-pci+bounces-12031-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A0995BCBE
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 19:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC10D1C22227
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 17:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA3E1CEAAB;
	Thu, 22 Aug 2024 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TeCERhWd"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013040.outbound.protection.outlook.com [52.101.67.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF261CFEA3;
	Thu, 22 Aug 2024 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346320; cv=fail; b=ilWkz64+fZ7HCtjmoWPLMyKYCMeU7kxvwjBEZly0BZHPhzGWwkWHfpurDbOmle0sd4gWkYIaKoZaCHKj9KEyfL7jJRswE/LSISwm/Kpwrb8q8DCo3ND6rmTZzxwsynm3gr6j0dhCFgmXlSFCMSlV3U+53zSu2Ll0VHr0VwKVk28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346320; c=relaxed/simple;
	bh=wdtrEhtk3HntFydLDwPFXTW1QfvO1ieMTexVzCBH4BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NINkaf0ER1KIHlKc6675kVpxDQH/AfIyGD9Q+vCrXqnDnXjTxU6I4oRiHULWGau7UzGKY0MNYcsshIT+W5ldz4rhNEYtxsViUzKezLXL0jsnaW+2eSAZs+yyATRqAHhe03p2zacal3oBlKY8i8HMeZXQGgFZhZb5McRENLJhahc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TeCERhWd; arc=fail smtp.client-ip=52.101.67.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vzqeMqF+VfY78Xb2k5D093l6cLQF7xt3LtFXNY9KXJenlBV3JXGmJ/pIHHdh2E5DX1mLXJdZnJmVoWiNSd+WCq+ONfTtHfv/r7Tag9/DQsVXyb7CVkTRX6x8jQCBrlP4+AKzI0+myKnFfxW4NfhSmqTZM80RQtb5qZid37mbwv2pj6e8dAnNEh023GXavyLDgzw1Fr1upM40ARyJeIG/vFKUYC7QQ+g6XejZdK0nQpPfED/PvMe+JvF5EpiohRZiKc1pwLcp6nv/C3inBohF+sdNAOmI4JQYePXPp6F0Gyo778O2ejW76tvKRGcGZZNU8R7ETTLqGII8Z7j8j0KAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzDF6CGz7+iqRT0yIyf8ZZOwofwcRUaNSZsO9rL8kR8=;
 b=w745S/1PTi4uPG1m0Je3fBS1TyKSYWJ9Taydb5WKSVxedr+a8rRhwPztjnkVKnT8BXkmMgvkyN4F+iQNZ4DPDBl+C0EzM9IyL0GJ3hS7v1AaCI+C1vH95QKgPDBUV9w759ALOcUTWybQ0lfKuPORUreLI3CX8v6tt71fccT5OIam/KdiM98jLwC+YifDHYfHVFY0+AhzWkM+A/vNDa6f+jLcahOn+kCtR6SlrbqOOLz/oj1Y3x/cBvJJ4UiCH51CZIQEV/Hhxibql3NfLdJo1zxQP/Hx01ugrf3C4MTO/LR9xFtDzy882XzrdRqMY7UaqyWM3jRC89mIa6uztaRUqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzDF6CGz7+iqRT0yIyf8ZZOwofwcRUaNSZsO9rL8kR8=;
 b=TeCERhWdP9J1ojaZPO80ItSGHQyx7vv9YyDxFTcUuW1psPxWHwc4orEpZ3YT5sBdDFc/5vEF0P/ndEV8V54/sNoBx284MsHBmsxFAqggU0dROFxO0GUKWkAx4s/LjL2hXHgK+9+M6KgdlU1JbI69Mg03QlLuSto2GGC/zJ9m6rpJkAPD58WPXUgo3ZzhgjuTSl+11czb32CHf2T0wIqoPNe8kS4GNoBpTXVNm4UAh86uLayRM9AJvxNNPNHAxf9RttFvgWsvWvRsKNrE9A50r1MnrFAKdgPTJNAAQMZo8N9zgv/JwOF73kJJAMITl+HwH6X9swjAR3BFlzNR3tvZ+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8876.eurprd04.prod.outlook.com (2603:10a6:20b:40b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 17:05:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 17:05:15 +0000
Date: Thu, 22 Aug 2024 13:05:07 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof =?utf-8?B?V2lsY3p5xYRza2kgIDxrd0BsaW51eC5jb20+O0Jqb3I=?=
	=?utf-8?Q?n?= Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/1] dt-bindings: PCI: layerscape-pci: Fix property
 'fsl,pcie-scfg' type
Message-ID: <Zsdvw0RpFmNxJt/H@lizhi-Precision-Tower-5810>
References: <20240701221612.2112668-1-Frank.Li@nxp.com>
 <CAL_JsqJYN62GO_e_+vrCdF3C9g+72qhPgzMrrXGtDJfd1rRZhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJYN62GO_e_+vrCdF3C9g+72qhPgzMrrXGtDJfd1rRZhw@mail.gmail.com>
X-ClientProxiedBy: BYAPR04CA0033.namprd04.prod.outlook.com
 (2603:10b6:a03:40::46) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8876:EE_
X-MS-Office365-Filtering-Correlation-Id: 565731cd-05c8-4321-4844-08dcc2cc97cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUY3YXlESWpiYUZOQXQvcUNkbFdNR0YzdWgvWW1ncmVvdEkzbXJwSGY4RUYz?=
 =?utf-8?B?WkFiMGQzRUdvSmpMOGNmMFZmdUFWWjVNYmpVMmJla1BscU0vWVF5eEVhTFVW?=
 =?utf-8?B?N1ZBNXZuS3M4MWJQR3BXNm9PbkdsLy95Vy9rMDV0Vnd3M0dDMGtTSXo1bFVH?=
 =?utf-8?B?N1UrelBydWlCOUw3NkIyUFRwMlJZNFFVMHR3blJOeWFmdGVSSWJXS0twTExZ?=
 =?utf-8?B?MU0vN1Nxby95SlNaSXFqS3RRQ3lhMERuVzJ2dWFObzVIVFRLME02eTNqekZY?=
 =?utf-8?B?SS9qaDRxWWxMNkhxcmdZVnBwbXBlUnM3TTVJT3R2b0VKUkRnMVpCcTB5U1VR?=
 =?utf-8?B?MkJyVXN0WDVvRnF5RFVoU2lOWndhNWsycXEwTzN3OFU4MFcwN1p3cDZxRHRF?=
 =?utf-8?B?RGVkWXJtOHd4RXN4UTdyNVZ3MU54T1hDdlJkTSt3V1BmZklqRVZIbm9WR2VE?=
 =?utf-8?B?aVg4NUkvQndLMHhEajBzWDh3N1ZNSmR6UmkvRm44VkZRNW5JK0pKY2xxS0th?=
 =?utf-8?B?NnVnYkJDUTJHM0N5TlF0TTJ0U2Fua1FKTURmRXNXTld1QUFvbkhkQ0Z2VFN5?=
 =?utf-8?B?cVdGSXQyN0luYkppc3ZxWFZQZlI1WU5MaXF5MnI5SGVOVDFFcm51MnlYNUxk?=
 =?utf-8?B?dkp2ZmJHNzh5My9BV2g4UXNYZk5GaHk3QVZld0YyN3lIM3RuVk1JclBaSTRY?=
 =?utf-8?B?S1ZjYUYrVVd0YjJHZW5UVnF1eHljNlRsZjh3aHpuNkRjVXFaeEYxZG8xWlor?=
 =?utf-8?B?eVpMejVGNWNjb0EyQWk5bXFjYXRiVUZ6eUQ5TGtsL2krS0RTa0Q3bXowbUJC?=
 =?utf-8?B?SDByQ3JudFlvMkZsbU1kYnZaeDZrVFQ3ckFhanZpRzlzUWtGS2RVNGh4YU9z?=
 =?utf-8?B?S0FOd1lEQmd5QlB4VDRKd1FPV2lLdHAwREdIRGN2anBKb0RaL1V1NlVXZTli?=
 =?utf-8?B?djJQWEZtekY0cGtLZzhNUTVEZDAvL0dhR3IvdnhqYU9tMzJWQ3FOZkdubnNQ?=
 =?utf-8?B?MDNBZ0VCQUhPSndtMHhFMklUbWpMMnJyL1hxYlhIblloRGl1aHFMZW9HaHBY?=
 =?utf-8?B?VGNZcE9EWklUemdmNnhjVGgxdjVOTThTVmpQQ3Jodk43Z0xSeUZHcThYRHpy?=
 =?utf-8?B?M3B6U3dvUG80cHBPZFhRNUJRL0dnOTNmN0cvYi9BSUFPc0JHVzgxSC8zak9W?=
 =?utf-8?B?b1FkNERNK0lCTTE1Vzh1elZNVGVTWXZoNHEzYkUwcWd2Zkh6emU0dGEvK2tl?=
 =?utf-8?B?ek5zdkxONW9BbnZSeTlpT0xSSzMyaTU5eEhLM2FQdDRXdWJzRGYyNmtVcnZw?=
 =?utf-8?B?UFpLL1A3RVpZYzNBVHJmbk9TOCtRRDBRMitMYXhPWS84dHZlazB6ZFYrT1FY?=
 =?utf-8?B?K3oyMzBjbTNEUStwRitpVW5UYUI5bEM0bGVmVVVoRGh3NUhPR1h2V2FKNXgz?=
 =?utf-8?B?Q2d1bVp2SVhlU3lRdlZGbFBFY2U4ZnVBcGVPaVFpYnlwcjB3NmlFWmhrMlFq?=
 =?utf-8?B?M3RLR3JZUjZrNGF0QWM0OE1UalFVdFZaZFltMzA3dnB1bG4vbjhJM0hvTXpD?=
 =?utf-8?B?UlphdEdCcXpBQ1RRaVBrRUhjeEVyUTNFRHVLMno2NVhObFhKeHd5UjIwL1No?=
 =?utf-8?B?YVU3L2d6emkrR2RPK1RmQUN1dW5leXNyNnlIYzhIVmthOXZBNjJPckd2WG5a?=
 =?utf-8?B?NzlyTVlSMTJVUnJEWDAzNUJyYkNIbDh5WHNidTRuenUrdmI1aU1Sc2dkYm9N?=
 =?utf-8?B?UTRDcGJ0Y2Q0cVpzQXhrYUV3SnVKcGFGYnNleFlkZWd3cEgrZXY1anpxenhZ?=
 =?utf-8?Q?8U0xmRv1P+F8hXk4mUKY5iWl/QKH2PsI+o0tc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmNBT3Z4citCRkU5RFBuZ2xOQXVrZmo5Q1dSV2NiRmpnTm1qUnNBSSsxZUpH?=
 =?utf-8?B?RjYzbWVFbjJrS0IrOERZWlFLV1dKbjQ2TWo1ZXR2YWtpVVpqRHBoQ3Frem1a?=
 =?utf-8?B?bm8zdVZsZE5JZUtUSWNLVXZvTzZ5YnZmOU5FR0NwbzdzdGQ4bVpFc3E0b1dV?=
 =?utf-8?B?S0tzUGo5SzM0amR6YmJMUUtqNHZ6UnNNdUtRYThXYjlWalYvVFhFQiszbUR2?=
 =?utf-8?B?RjdBMkI5NGltV3ZOMmRBc3c2ZUZHTW1lcVNYUUlSOElNZmZmOFB2QTFyWCs3?=
 =?utf-8?B?UmtVajNoT2t1bWRRU29lS0VTMU5mVkRkcm9BNFlFWHMwWStZcGZGUVBSRURB?=
 =?utf-8?B?SlVOSnJKSENvbTdyWG5SMi9pSE1mSStXTGxJYWdBZ1IvbzdjOS80RnNuV1Bx?=
 =?utf-8?B?Q1JxMWhXWnFUMFZteVNZMzJNTTYvbUc1WWhOZXp2TzRUTTY0bXpWdUx0MnVY?=
 =?utf-8?B?a01PTjh1VGtGcTNPMWkzWWhXMXRZQWo2S2dOVkZPaTJEbGplb1JtRE1UTGZo?=
 =?utf-8?B?bjJQR0hHMkg4bmh1U1NoL0FoK25UelN6MXdnblB3Y3VuaXdVRzlkazJidHcr?=
 =?utf-8?B?NlBPTjZ2N0pXUnlYUkgyamVHVlRCRHNSdnZscHdCSi9NQUNxdU9UUG4zUUFa?=
 =?utf-8?B?UFlIUUZwQnZxU09LR2NoZ2VZV3Y4ZGNPeTA2cDM3QitkVndGN0xhMWlWQTUy?=
 =?utf-8?B?TlNYMWpxSllCK3hIWDZjaldkcEhVSjkvc1RRSGQzc3VTSzFKK1dBNS9YMXQ0?=
 =?utf-8?B?bnpBOXRON0ZaWlBSMWVZeUtTQndmSmdZNFFCLzhDS0JCbWdUOGp5b05qMkMz?=
 =?utf-8?B?d2toMGF1TGp4ZkIyOENjS1E3YjhmQlRlQ3lpSkpaOWNLVmg2aUJXK1gxZEc2?=
 =?utf-8?B?L3VTdjFqV0JPZk1EUUxkaHhqWnNUdFRzL2dFWjlnL01adFAvQmZxdmRZRXRH?=
 =?utf-8?B?VDBQV3FuNXdUT21pdEVVZzBFdVlKbzYzRjVDR0ZPdnF2d2hRL2ZlTmJ4STcr?=
 =?utf-8?B?MWxvUTFqTzdDOHduL3NidjMvZWFkam1QRWd3a3VhT1pCTHhmcTM5NkQ2RzU4?=
 =?utf-8?B?YmlMZ0d1eU53NkF0MUNESGhLTGlSZU5lY1JQVFBnRzFqTHRiMis4cWNwQzZl?=
 =?utf-8?B?QkQzMDZsc01PcldUNG5pVy80TUJlNWJUMGF0bmlINUo3RTRvL3daSUcvSFNM?=
 =?utf-8?B?NlBkMFpwa1dHamtTK1hTVGtFYk5Rc2w3NHQ1bEFCNEdRZ2pWRCtselN3YkxI?=
 =?utf-8?B?RlRyRXNTMHIvNnMwS1ZrQUhOSy9ranRoRFVUTm9jdXkvUDQrZHlCUXVQOEht?=
 =?utf-8?B?YlVnemp3SWNKNzd2REZPRkltdGhhNHBFSXJaYjVQU0tPb3JqU1R3Ni9jSFRX?=
 =?utf-8?B?R3d6U3FJMnZNWm03SitvQ1VJYWZTR2tUczA3ZHFnYjI3NVBEakUvOXZMZW1k?=
 =?utf-8?B?NGNVOXlUeGlaeE9VdmVpWXRNZXg1VklkVTlIdFFLVnpRU3Z3T2dNcWxNc1Ax?=
 =?utf-8?B?aGd6T1JxVDB3SEo3ZFVBRE1YNytBb3FMZ2E1WkQxV29sQUVjTnJ1eE02WGJa?=
 =?utf-8?B?TjNBV3cxbldOQnFUcy9hU0g0Z2s3SU5HNlk4SVBDL1BseGV2TlNSRmd0d1ZG?=
 =?utf-8?B?UCtaTlowSXVqSzJ4MGJ0dDUyQy94elRSSmNuTVIrZ0tTbGxoNlRNRk14QVZY?=
 =?utf-8?B?ZlJ6c3RPeGsyelhpcFlNMkZHWVd6K2NSaklYNDl3TGsyYzdHWHd1K2ZpUVc3?=
 =?utf-8?B?NjY3K0ZZWGsvelAxNDhoallzWlBGMkNYTDJEUHdCZnJXRDJ2cXJlVDlscm1T?=
 =?utf-8?B?NUlZcEJzR2Y5NU41MVVnSnFtZUlEdzZTU2ZwL0hoNjYrZStvd1Rpc0VJWXpm?=
 =?utf-8?B?MXhOM2tFVzdTaWRPNldaUmJlRjV2VWU4MFRxRTR4azNUQzVpcGFlSmVTdmYx?=
 =?utf-8?B?eU9hUFVURC9CS1JkT042bXNGY3JaOFlMNXJvd1lzdEZOSXlwWk41U0pYL24v?=
 =?utf-8?B?RlFNZ0lCQVJkcjh6NEpybHJWOU56cVMvWWpXcWU1aXQzZjRvOFNSeTZJNVhW?=
 =?utf-8?B?dk1UNDVIK011MWRBTThVMEVZNnJhU0JxYmhaM0hJem93Vmt2eDhqY2pvVXAx?=
 =?utf-8?Q?89CuDXpY23jqqjXjFIJJ1hEfY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565731cd-05c8-4321-4844-08dcc2cc97cb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 17:05:15.6989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CmKfTI/ozxy/T0gTVfyK1EYQlVFIEc7zoNo9thz5b0G78dTten5XwxciiEYXqgSubgfVvYQl5LQ7dKRG/KPyFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8876

On Wed, Jul 03, 2024 at 11:27:21AM -0600, Rob Herring wrote:
> On Mon, Jul 1, 2024 at 4:16 PM Frank Li <Frank.Li@nxp.com> wrote:
> >
> > fsl,pcie-scfg actually need an argument when there are more than one PCIe
> > instances. Change it to phandle-array and use items to describe each field
> > means.
> >
> > Fix below warning.
> >
> > arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: pcie@3400000: fsl,pcie-scfg:0: [22, 0] is too long
> >         from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie.yaml#
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change form v2 to v3
> > - remove minItems because all dts use one argument.
> > Change from v1 to v2
> > - update commit message.
> > ---
> >  .../devicetree/bindings/pci/fsl,layerscape-pcie.yaml       | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
>
> Reviewed-by: Rob Herring <robh@kernel.org>


Krzysztof Wilczyński:

      can you help care about this patch, rob already acked.

Frank

