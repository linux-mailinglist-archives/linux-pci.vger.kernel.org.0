Return-Path: <linux-pci+bounces-9756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3577926885
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 20:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F33B1F21938
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 18:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970AC186E3B;
	Wed,  3 Jul 2024 18:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DL9J7F6k"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011054.outbound.protection.outlook.com [52.101.70.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB97717A5B0;
	Wed,  3 Jul 2024 18:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720032425; cv=fail; b=Eahm9uQyG8JpQYBMYu7i4KbS4RXOQ6MOQkG0ox4L7CPEg1zP990Dd19/M8CJ9B+W9CNHnKdD4RZ0JfRx+BoM/9wziI93OgDMDtn5oqlUIwyxBBqmSMhV2Z0/A84P6LkMOC/sghaapKFNqQxAORQxWEWvY+ulnjdgwgGU6OhCh4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720032425; c=relaxed/simple;
	bh=kx1DOjnWli368xW+aoBzyJCHvlaR0Y+xkduJaMNZqNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wxz70UAabNVsAwB6+BTYSuUIb9nBg3ideIqubSPgNnMQt/B2vll+kmb3+IE7KnHqTqVE9v7DENPt/EZDSCt48h9/Bzg4j2Q4hxEMUXmQh3gY87roF5AJqn6+UOR9XZ+WIBUn2vQudmpq3W6CI6xgFk3WlxH3EXp2G+JrszuapU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DL9J7F6k; arc=fail smtp.client-ip=52.101.70.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRJca36fW1XPFPy8rx4zcpw+tgEw99OMpXjL6JFDVZgB+fsiRKHzBW7N6uhZwaUEGhOM1bhV9OCadO5dNnF8D8hxhJbMXHU4cvVtVLnkH3OZHwenN3agqRAdW8MI1ejAR0epM4rhdaIMV2u+zJ4gS+vvZrkINrFXo5x8s+waeVqs+hVPzxEUISeyZZ/UY4BGT1aQh2MEf371WEHiyYcdnvZXbPrHgAGP00X7qdUU9g6+J3mrpsxCamnDfIH65IUnlScvw0bLZJb0ZHUXwiIziBygNZ9rfF0E8RtSbn+klJjsnHn/VYez4sudezwfOcT1tJq63yxC6EV1o04nre2xmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+Uayn5Gpdlc6QzUby0PDS1YldafSC2HRfFBvOg7vOk=;
 b=LVrq6A7NXC7p96vVVIOyKGnX9rYsJ4X+/CB2OhPO/Z6T7q0XDndea11QID0NT6mopIqeVqoe68mnKK8bSiA1EYVERMQ4alRCLBsiCZtT065r4Zth/qsQbDID9zGsSUj6PiXotqwHcxQ0VSQZXoW7EtvlDxiO0lg5rEB2peyX2jstdNYSLq6iF4dFaEpPxZXtrHwFohLC0s2abqeq1ZKWxJ32XxBoY5azka5q/jLeWtMvjFTyMaQ6a2h70mLPlMY7Mfa6P50m67nrGr/s78baGOqrCXaPG+kUv2ajcPg4L+/Cc4S36SN19V+ZmE0J1Wou6hWaXmzPHK3Q4PL7+oeb3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+Uayn5Gpdlc6QzUby0PDS1YldafSC2HRfFBvOg7vOk=;
 b=DL9J7F6kSGMp4uKqfN0IgELzOAundg8PLinzw+gcqX6Ryf+11z6P8SrVFpQ3ky21PxiKHlqTCXivJPnZ/lKzyZnzGGB33Kf7CSI8us8veHjm9RXoJkdxbLgzCtz2fbo85Ejhvw2ltPkUe+r7O3Js4DDxW0apcewLQdQ5uXgEUXs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8108.eurprd04.prod.outlook.com (2603:10a6:10:25e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 18:47:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 18:47:00 +0000
Date: Wed, 3 Jul 2024 14:46:51 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:PCI DRIVER FOR GENERIC OF HOSTS" <linux-pci@vger.kernel.org>,
	"moderated list:PCI DRIVER FOR GENERIC OF HOSTS" <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: PCI: host-generic-pci: Increase
 maxItems to 8 of ranges
Message-ID: <ZoWcm9Rtn/ZGVVtx@lizhi-Precision-Tower-5810>
References: <20240702153702.3827386-1-Frank.Li@nxp.com>
 <CAL_JsqJAKXfdSVGrOvZFn7_asmgv_g6a7-A7wq87xXKpJJnC8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJAKXfdSVGrOvZFn7_asmgv_g6a7-A7wq87xXKpJJnC8Q@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:a03:331::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 761fab57-0c77-4e02-f0bc-08dc9b908600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1J0OWd0NEMvOTNwWGZucmVBWlZ0Zk9lWUZhMWp2a09UYzVjZXRrdGlFdzN1?=
 =?utf-8?B?UjYwYnlLL25kRjQxWnNYQmRKdVE4TGRpcUp2ZFNoUEFlak52Yk10WmJPSFZz?=
 =?utf-8?B?OVUvQ1VKejBRTGt0Q3lNTVBSUEFXdExDRjRCWmxYRjBGb1oxZlBEVG41YlM5?=
 =?utf-8?B?UktKdEtUMHNCK3lVemk4REIzaFcyZ2ZxZ2lFREJMaWdCeURRa25tb1o3TmJ5?=
 =?utf-8?B?ZGdEb08vUUpPMk5yTlJGN2QwajkrUGxHQ2RuMEFoVjhuUFdHSXcwNmM5T3Fx?=
 =?utf-8?B?OEs0NVdyL1hsczhwL2Vkd3JIL2lBd3hNcGd4ZG9XMG1mSGtmNEU3b0hzUGhU?=
 =?utf-8?B?eDNSWmpDallyaWdmYzdWTTBJNXduNlB6dDZWTTNueUVWbk01eUNsMmxGSFd4?=
 =?utf-8?B?TFBjbjREcitUMTAxbmFQOUFNWlZGWEczODIrTXI3eG1zTFI2aDlsdWovTmhZ?=
 =?utf-8?B?RisyYkpQME5JUXF5ODJXL0FqeXo3UXorT2N2ZU5oNlZwbFRUNTZpazB5dkN5?=
 =?utf-8?B?bXRRM0U1akFhcWRPMlgrS09ZZXBlUkV4NkxsL0JyTUY5VklnU0JYTENJZDhT?=
 =?utf-8?B?MGdlWjdpWjZJTWh0N09RQkVJMDlJOXVGWWlPRkVUUWJUdGREclF2T1NZSHZh?=
 =?utf-8?B?T21UUHVjVlRRUmlYeUthR2pTUWpYVlAvU0JVRy85VzJTV2xpZXVhUzBGU09X?=
 =?utf-8?B?WXgzRDFFVWdaVWN3Qy9uMDZXRG1NQkJLNDAzeTNYbk8rVkN3VThLK2htL0kv?=
 =?utf-8?B?RmFUYlRwbklZdEpyNjZhNEN3cnFrbXAvZmgrbHkrYTAvbS9jOW43Y3ZTNCs1?=
 =?utf-8?B?enNscDRCTzdJb2dlQk04MHllQlVyOGpmakQzZFd4VVBOZklLQlJXb2h3YzdV?=
 =?utf-8?B?cVZtZklINk11WDFSakE5aG45N0c3WkxweEM2YVhYWEROMDNQcHlBTTFkVjJQ?=
 =?utf-8?B?RHpEYnljbEwyaXN5Ni9RaUJGelc2dnh2Qkc5N2g5TW1veHk0b3FKM1ZFdnZM?=
 =?utf-8?B?OEpJaVhRL3RGVHU3Vm1NMlhwRlZZYXBFS2VHK3pRb3A3akROL0NQMVZ5Vlhu?=
 =?utf-8?B?TEVBRElzQ24zQllKQ0JZckdCUUFTUmo0b1hKU2xBZEZMRXBCR2Rtb1hNYkI2?=
 =?utf-8?B?MXduMXVvRHF5MHpaUXp3MnBsd0hORkNlMWVRenZ3VDQvMUducHNza3IyTHhR?=
 =?utf-8?B?MXJTUnJCakdDekpIUURhK2NTZkVNSlpEVjdvMFlyT3dkQWZaWndzOFRVYmw3?=
 =?utf-8?B?VUVMM253WGMvajNqZW95cWk1aFNpWE0rSnQ3enJKNHNCbmxDUFdqOTRPMXlo?=
 =?utf-8?B?S2NOd25Nb1VhNWpkMGtMMWFrSXg5SHlYRE0vN0JMRDNmUllsbytHNWFyOG9r?=
 =?utf-8?B?ZGVzS3VYdUgxNjFPL1ArSWJwWXRXQzNyMlZoVTlOblF0WW5VYmJLZ3E1VmV6?=
 =?utf-8?B?cHI5UXU0aEVuZjR4Wjkrd3Z2UVJoY2piQmFpbU8wYmtUejdjdzhtU0kvQzdz?=
 =?utf-8?B?NkprWjNCUFZPMFlYVGNjOU1GR0xrOXFjZzJHdW1MaFV4SmptdVJZWmZvcTY1?=
 =?utf-8?B?YmhFNEtrR3NxZkxsakRGbHVXYjZJdFpXWDNON1VvL0hsNHdhVEdPVmFCLzBL?=
 =?utf-8?B?YVhGaGdSZzBZd0g0N21UYUVzYmpjd1ZUcm9TbFdlUU5Fam0zN2kwcjlQMmFz?=
 =?utf-8?B?a2h5M3NvQXppZ01SRHRBSWFXNWFXdGdENnJyZURleHc5SXRCWEZ3MWE5Si94?=
 =?utf-8?B?OTdyWEhzWEkvUFdpTVFBSlJESUZNdGo5djZnSURSbUN0ajZ3N29SRVhkaW8x?=
 =?utf-8?Q?pU1Xk2LkgqxtFIwI7Jxc5K2M43tE6oLZieHgk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0M5TlJadXRkdHUyQXZrZFNhSDVxMjFud0pHQ1kreWpJMDNVbTFEaDRzTU0y?=
 =?utf-8?B?TEdyRkZ5ODc3MUhkWmVaM3kzNVpJYThDL0dUZUl1OFh4dFZhL3JHNjFPTEpr?=
 =?utf-8?B?RllEd2E5YzByRlRtU0RRMmNBVnVoTVpJbHNxMkthK2dCT2g5emVTUWYxb3ht?=
 =?utf-8?B?MFErNVczWGJ2OTVTRFJoMDFpam9yMS9xMlRwUnNVczdZeEROdGtVZFNNMEY0?=
 =?utf-8?B?V3U5dGdUQ2gwQXkvVmJPdzk2NHBCR2hRQVZIaG1FVGJaOUJBSnk1OWZRbENz?=
 =?utf-8?B?ZlUrZnVUQzJDL2FCMDNiaVo2Ui9HRlNEVkVhREtrK05JV2N3U3FRZ29OOWkv?=
 =?utf-8?B?RmJwck0yUzBocEVvQ3hmQm8zWHNXWHoveGpBZmZSMEFJNDAzZmZwbTdYTk53?=
 =?utf-8?B?RnJoUXJ3WHNLc29xM3FhWDlGN2dwZkgrNm50R2swVlNkWWtiUEZvcHlFVGIr?=
 =?utf-8?B?T3M1aEVnSU41Q1haTGQrdlUrOGxnL1lDM3Z4amppc3dpR2xhTnVUTEhzYlY4?=
 =?utf-8?B?TXlNRUtlUk5NVkFteEpyZXNTYWZCTjUraXNCM2Y4YllsNTFPT0tZMWtwbHZQ?=
 =?utf-8?B?YnB6VDR0R0N5SlRKRzNJOFE4TnlJTVdReGw5T3BybVNSYXlvcTE4MHFzczhI?=
 =?utf-8?B?Q3lEN0dSc3Nxd2F1M0RPcnZpSDhHWWV3WXhqNE9EWkgyc28weW9pZzR2Vm04?=
 =?utf-8?B?U1FUTmNxRGFzR2Y1T09qSFRkYlozYy94MlpMZzhVRG5HRStZcUh0OXdFMnNG?=
 =?utf-8?B?WnhadnQ3OGQzQ3MwMG9YUzBMVnZFL0ZDd1lUYWFTVUpIejRsY04raE9DNFpD?=
 =?utf-8?B?VkdvWXF4ZGRXS2dkSzdSbldiaUJnS3lsMHo2cEc2SnRtdW5BdU5ObDZrZzd6?=
 =?utf-8?B?aXMvRDkwcmVxZVdpdkM4OG9YNmlPOXlXN3FLa1NTL28vZE9uTVJ3Q2VQQzBN?=
 =?utf-8?B?VGcrYlFUdkFNR01jalNvMGl6UDF6bGlOd1JOR3pvT2xtWWsvd2FOVGJEckFE?=
 =?utf-8?B?WFZ5Wmt6blM5U1Fncm0vNExsV05QVjRoZlFkTHdCWkVUL0c3bXhyMDNiQVN3?=
 =?utf-8?B?ZHBQOHpNK3M2cWszbi9nZ3BxZFhkVkFaaWNhZ0YxeG9tbzg3dkVhU2txNDZX?=
 =?utf-8?B?b2ptY2puenZ5eUkzcE9ESVdEdlNwd1pXTmFpQkNXeElETHlSOWpxRmJTb29F?=
 =?utf-8?B?bkFjbGlOQVkyTkRRV1JIL296U3lHRVZoQkpYbEJIalVJdGtJN2dXajIrZFg2?=
 =?utf-8?B?TGp2Nk9qT0oxYTZWQ2RWQjlpY1VYYTRPQy9SMGM0VmtuK2kvd241REkzSjB6?=
 =?utf-8?B?UG9UZGxMVnR3NE9ONkpVMzVvaDRXTnQrTktRYkpybm1NVFBFNEdsNVR2QldG?=
 =?utf-8?B?cEMvNEI2ZUJDQloxMTZNaGcyK3JsNFJCRHpGVXJjTW9ZTitHY0J2WlhKZWNp?=
 =?utf-8?B?SGRkdEN5SnpDSkZYb05xNXVCR3RScHdJbW1tZ0RBZElJMFdiakFDT1lzVERm?=
 =?utf-8?B?SzA4WEFKRkpVMlQ0U3dvQ2IrcDd1YWFPV3UvbUJiQllpTko4TWpTd2E0cmVV?=
 =?utf-8?B?ZWpRamhMczJGNW9XSkN1WGk1aXR5bm4xMzV4OEJMekpEUENaMlRHd24vUHBl?=
 =?utf-8?B?emtaOGZLUmt2YXU1RDJsaVMzRlpXMzZhY2tya1JxOFFrZ3JoWFJMbjFlc1ZX?=
 =?utf-8?B?SUlQTmFLRkFlMEpqR1FZOGhXeUxLQThPMjNQdGJLeGdPc3lXUExaZ1g4ekJQ?=
 =?utf-8?B?VlEwOHNJU3FQMHZxVitiTTlzS0FKMGYzdUgyMExsbjkzTmViTS9QL0pzTTdv?=
 =?utf-8?B?UkZJc0VZK3RETFJUWVlMWDUwenpabk9YTFJqSEsydnF6VDlWV3c2K0RHWkUr?=
 =?utf-8?B?bzdxanJncUpNK01EVXBwWWZWTlI4bFJBbkNzOUpSblU1WEtvRndBVTE0WEFu?=
 =?utf-8?B?ODdjTFZ3OTFHakFLUE8xbEVJK1MrUFZRM2VXdnN5VEs2NmJMTys1MzRaTlJZ?=
 =?utf-8?B?RVgrcCtOU1hWYmQzaVQxOWVPOGtNRkZvMG1abTNSYjlvTGtEZzZrMUpWbWRQ?=
 =?utf-8?B?RzRic0EzSFRXU0phWTJiL0szUXFXdms5SWE4bW8vRnVHRGZHa1I5YlQ4c1Ny?=
 =?utf-8?Q?Rm+NIs6cYKvoG/VJJFOAoeaqa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761fab57-0c77-4e02-f0bc-08dc9b908600
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 18:47:00.7857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8F1PV9c42nwpn3qlyQXhX4j/hc/KKB1V7+77N5Q5W+rKgb0ixNnhOwDwqoAqhUandMNOvvczABdIK6nvTPvFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8108

On Wed, Jul 03, 2024 at 11:26:14AM -0600, Rob Herring wrote:
> On Tue, Jul 2, 2024 at 9:37 AM Frank Li <Frank.Li@nxp.com> wrote:
> >
> > IEEE Std 1275-1994 is Inactive-Withdrawn Standard according to
> > https://standards.ieee.org/ieee/1275/1932/.
> 
> That has nothing to do with this.
> 
> > "require at least one non-prefetchable memory and One or both of
> > prefetchable Memory and IO Space may also be provided". But it does not
> > limit maximum ranges number is 3.
> 
> 3 was just my poor assumption that a non-prefetch, prefetchable and IO
> region would be enough. Not sure why you'd want multiple fragmented
> regions though. I guess for device assignment based on the comments.

ENETC is embeded PCI device, hardware address space layout is fragment.

Frank

> 
> > Inscrease maximum to 8 because freescale ls1028 and iMX95 use more than
> > 3 ranges.
> 
> Unless there is some actual limit, I would just drop the minItems and
> maxItems here. Then it will be limited to 32 entries in
> pci-bus-common.yaml (in dtschema) which is also a 'should be enough'
> value.
> 
> Rob

