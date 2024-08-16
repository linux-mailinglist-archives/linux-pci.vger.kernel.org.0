Return-Path: <linux-pci+bounces-11771-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722A6954F95
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 19:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74607B214F1
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 17:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380591C0DEB;
	Fri, 16 Aug 2024 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YXjxqAL3"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011004.outbound.protection.outlook.com [52.101.70.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACE91BC9E6;
	Fri, 16 Aug 2024 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723828204; cv=fail; b=sd1bcNI0OYx5ww2quIM85i6LFz9hnhJZStKMdzRaIRtSIv61sblhzigU/cWsgGq3h0OryVezuZLEztv0agHoFMh7q3sUdIpOtlUuc1P4FvXJJUqs5pDZFlb9YI2Al5LzSZIT+78UQPPjl0Hzw9vHh5RlPb4VY4DkD5NpHmm6xIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723828204; c=relaxed/simple;
	bh=DU8Oy2ZtWvQ/Qgfjm58D0wNMvERRN9IQt+T/SDvwG/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rvmd+6s3WmbS8PekFceLYa42aLqBzPaFpOe6J+2rbtNyd7HuQ1WDoBvrB1TT7UOZ8ZkcuB//jhVrdydmwM0WpzMEkO7beSxJ2x4YvUncGhRxI/uR2bUXB63oa3XNiXrKlrMC0LLhHkqud7R7vliBH270tKxHdHseuqtQ+kQKFn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YXjxqAL3; arc=fail smtp.client-ip=52.101.70.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJepSxzZ9GMQfrb9OkiAoOzYptWa+jjfD0zewZi36F9uXq1D8YXZLyH5LdnzZwU5Koh7XA0GrgWx7EsFF+qaOCsa+r1sNjEOUU0+4CnLEWYqvtA4VvZAogXsEIQxTGazlrqhkjlv2kfs2/JQjyGN+7dDf69NNc13+gzoEthfYlNTDSKjD2IBEPa4wDVwEOiwrfu3NIvWXqdI6I+Y12j6H5uRwRv44EaPIEneLpL3LVfZZJPLzZzNRaYxm5qgbxAFgoi3aEZe1oqv8PKmlUk3cfa7IaMzwEELq3Vi/09zbuwJUGZrnswQ13VchxGK0jUNSNPEUruZUCwXyhG1uk6yCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DU8Oy2ZtWvQ/Qgfjm58D0wNMvERRN9IQt+T/SDvwG/c=;
 b=wi7UlhIHnyZ1u8ZlU4dI9lUbwgkhneU0k/hDx446T8dO8tc5E3OQGRAk5PV0Tqf3bj82Hj0zUjgkzPPn/JTmJpy/caBcsNRbmKrMJsdV8eA3JRh0ol0qcUM+W6I+bc4yHwr+uVCropfsRXWmJ9VSYbksElYGS2BA308FvtPxcBUuzWK3l71DOu57RwoK8VYZy01WdEWibglNFv44RfibgMwZABiptfRjexSmJncSfKDZMORFLtNnsclfOnXbxrJVBU+0FvhtAFTZ0YW2eqAtO3Ffy9BG1yrSBa5Sgk2iLdeI/GaqlywByK1gWFo6Y+R+Zq/UaADnqKqN6BJhLMSk3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DU8Oy2ZtWvQ/Qgfjm58D0wNMvERRN9IQt+T/SDvwG/c=;
 b=YXjxqAL31DbRADIuLV1fUEeSL9I22llRg2kr35FOI/RNM+bb+PGMeNDtQmV275YGL0oWQFGEUR/Ue4V3KWm5pXV5Zo8XbbcajDurdjyt0lEi1C0SsBvr3TSiQYkuY2ubmwJnbtK0Ma8B1Qzf84CxRiDEwuLrdqJW64NcvNP7JERpQv96s447M+8fFJUsHEcGMYxAcuJtNEHn8mHkktRHLOlpuBUMCAaINgX03ayP7x8VMoQNV7YpLmv7KcA2ZGXzKyho5ujA0bkzBdtUmmKWZ1nw/j0UPPiGoVQbEop7/HC+29LhFFf+0UhXx6gluExGm4PZEudGvSh9RVOACCzvpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9724.eurprd04.prod.outlook.com (2603:10a6:10:4c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 17:09:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 17:09:59 +0000
Date: Fri, 16 Aug 2024 13:09:50 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Zhiqiang.Hou@nxp.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 4/4] MAINTAINERS: drop NXP LAYERSCAPE GEN4 CONTROLLER
Message-ID: <Zr+H3gHZ/B7zTKBW@lizhi-Precision-Tower-5810>
References: <20240808-mobivel_cleanup-v1-0-f4f6ea5b16de@nxp.com>
 <20240808-mobivel_cleanup-v1-4-f4f6ea5b16de@nxp.com>
 <20240815155343.GC2562@thinkpad>
 <CAL_Jsq+rnUB2pDjf6qFF7ThtSD-C8MMZUrhJmTYKfts34Zhr-A@mail.gmail.com>
 <20240816054231.GG2331@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240816054231.GG2331@thinkpad>
X-ClientProxiedBy: SJ0PR03CA0164.namprd03.prod.outlook.com
 (2603:10b6:a03:338::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9724:EE_
X-MS-Office365-Filtering-Correlation-Id: ff76d8d5-e1ee-4747-b5af-08dcbe164240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0FJTVd4V3ViZlc5MnpYRHpYSnUyUHVDN0pVdVVodHpyK3AzNkJmbGJjaVNP?=
 =?utf-8?B?SUtIQTdweGhsN1o0UllsdXhIL0lkaGJEQUtQU1NkWitDSkorSFRRWkh2UXhN?=
 =?utf-8?B?Wm1INGZ2SWg0WjE4ZlJHWXdYRmcxaGlHVjEreW9wbVc1dzhtY0l0UnQ0dmJM?=
 =?utf-8?B?QWh3VjFKQ3R2Y0FLUFJFTFVlVm9DRnVoWktqTlY5SDJxNEFuUi9aN25JbFFN?=
 =?utf-8?B?WGl6NWtITG92QlJTL1ZoaGh5VCt1RFBnZlBEaC9WY3JneFp2ZUp6YmJOK1Uy?=
 =?utf-8?B?OVJVaUhjZ2ZtUUZYTmxqRy9iNUZvRTZ0OUlCOStQYkdlS2FuTUlNZUFhZWdY?=
 =?utf-8?B?VWo1Wjc1a0pObWQyN3BONmxqOE10bTk0NEl6SWhORkJ2d0NPMDR1cDdCSks2?=
 =?utf-8?B?ZjVVMjJneXV4VWpuT0liR0FOekI1Y25QOEFMbTN5SDcvSXR6ckpYRnZ4WkMw?=
 =?utf-8?B?VDZrUjhJY1hBd25TR1J2RlB4V2lwdU5lRDZFN3ZvcUJaVTZka3dqUDd6L0k3?=
 =?utf-8?B?RXN0UWkwOXMwOHg4TVdKR09QQk5PN3g2YlhyZENnYWlkQVVGRkVmMW94VzRO?=
 =?utf-8?B?SUxXWnZEajVKSGpwdE1LdzNYNlBsN09QOFcxSis2UkF1N2l6eVJUTW4vWkJh?=
 =?utf-8?B?WWhhMXU2ejA3M1NVb1pwWjMxMzVYcHpsZzJtVUNwTFdTSXdsbzhEdjkybCtt?=
 =?utf-8?B?Z2RhSU5KVk9BNjBoMXFWRktJSUR0cGJJUy9nS09OVW5FcE00QUt1d3EvU0dw?=
 =?utf-8?B?czY0b3VMUUtiNVFMSWNoSEtoUWZYbVZuL1NLS21IODBFMXNHNVhpL0FUMGpw?=
 =?utf-8?B?Rmx3Ylk2VDJOUW1wVjhPNFQySi8rNXRwWGd6clA0MWxzbHkvSmlYaWY4MjFU?=
 =?utf-8?B?L093TUY3L3l2dHdpYjYydTlsay9GVk13Z29TY0hhWDJWWXQwRlZEeGFTSnhT?=
 =?utf-8?B?SERydnhHenRmQkh1RWE0Sm94VGZTSytKTXBlcDlNVElJc3lheHo4eWRIQnZB?=
 =?utf-8?B?ckQxdFExOEdWVHhUSUpFRWUzUGMvYytvS2lLZ3o4d3hLVGxlUDBQTUZTVXRI?=
 =?utf-8?B?RTRzcGdOcVQyYTVEVnl5QVllT3FYU1EyVmF1YmlMaklPaFR3bWJHUTl0YnRT?=
 =?utf-8?B?UnREb0pZREU3NWdYbVFjWDlTVGhzZm1Gc1dvcFBzSEpYN0RxL2w3TU9aTmc5?=
 =?utf-8?B?aHE5VFRldG1IYlpJMEE1bHl6QXd3RHk4Y2s5NC9FMlU2dkNaa1U5UG9oZ0NR?=
 =?utf-8?B?MWc2ek5UQnpNWDh6eW9WZGVlTC9DQmdJYVVzL1JsYnhQWStyMVR5dVRVYXhY?=
 =?utf-8?B?SkRleXU0VzVGTjZTL3J3ajNJRGh6TmxjQmR5cm5BeVFtWUlPWGZkd3UrMXpw?=
 =?utf-8?B?aEtoQ1FDcTVGQXMyc1dtMWRYY1g4NG5qMnl4endUbyttOW9HTExNTXpRNTl4?=
 =?utf-8?B?aHdSQ0RBcmtJUmhwRys5TFBzL1Q3emdKMHJFME5LaStOSjZKc2dxaVpuNUlL?=
 =?utf-8?B?R3EyTUxHUmNsclBYOXpHZlBkM3lPS1J2WTgxYTFSM1FpaUhFNVBiSWhBdm5W?=
 =?utf-8?B?SzVmSHN6RWZKcWFpdXdSaGR6MkgwTE5EYjNrVzRZZzNxZU5ZREhOeVduZ09w?=
 =?utf-8?B?SU5Ib0R6NkhkUFZjb1ZnZ29kdWp2dWtkQ1NGc2hpYnE4WDNOWDlxcFhtcGI4?=
 =?utf-8?B?Q1RyV1N0bi9FY203Mk1RRWdzWTZHQVMveWN5NUJ3L2wwZjZmUlMrZllwTEdC?=
 =?utf-8?B?bk5SRndEelYwclJzT0RxOVQrME05WGFaN24rVXRFTHBlUVZSMVpWSWs0V1Nu?=
 =?utf-8?Q?CigdTbF5EMhy0XSxLPtKBVP9jNDelJS5rJpPQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c09SWVJZdkxZejBVWnl2akRUNGdWZ2JQYXZsZ0x3Y1UyUy9JTStvcjNNb2N4?=
 =?utf-8?B?VE12NVNna2tRbUZLR2xvWGtJZlc0cGdIWnYzYkhDSFVJK2pvSG44cTlKRG5K?=
 =?utf-8?B?cTlzVXlydDZIU0pGcHZVeThPSU5abTloNEYzS0NBdXdwdDVMd1RDWXZCQlhO?=
 =?utf-8?B?L2JwUnFGU3YvTUIzTTBXbUhXVnVnamNRL3QwSXNGMnFQM2VKL1NJUG5SdFNF?=
 =?utf-8?B?UnNlQzRoKzBHYWN0MWVvL21wa3B1Y011RUlycTNsbHJ2QTl4L3htenlpWnJ0?=
 =?utf-8?B?K2FlQVdDbU01QWF5RmVvZk02bTlKSjVZZGMzZ1J4NzNaT1oxOVR0b2IvUWl2?=
 =?utf-8?B?bURQZ2lCRTQ2Rm8xM2pUcDdUdEdLVVdjbUJ2QTdoWWVtdmEwS3dIaEZhWGtC?=
 =?utf-8?B?N09sVkNpdU9WTnhXMVlJNHhKQ2NpdVBsdTJqdUs0Z0RQRnYya3N4TVdVa2VR?=
 =?utf-8?B?MHJHc1RqUzFCRzlwMVFER0VrUjRuMGlpNmYwb0tmRDZJZk41RFMxeVJyYWJT?=
 =?utf-8?B?b21Gclc3aEVQN05uYWVFQTJra3RYR2dpMmJML1Z6cWlPYStFUEgzcDRxaFZt?=
 =?utf-8?B?TU04NE9FVjhXbVJzLzYycHdYS3dPeWo3NUFZZ2ZPR0tHUjREU0ZBWjVybFp6?=
 =?utf-8?B?NXRlaXVHMktwMGYySjQvQjk1bEN3clRZc3RPVDBFNEU2d1J5blB0NGdnb09G?=
 =?utf-8?B?b1lSclFocnR5T1VmNm05TUZiRW9PQlZZL1VmR3hkaC85aFJkcnBKWkNBUEpL?=
 =?utf-8?B?NFhoalRrNEtYaVBpRlZHZ20weVpmY3NVTko2NUt4Yi9tSGh4SVArTi9jT2Rj?=
 =?utf-8?B?ZHBNSWZWWHJFd0lsNHQ0YWVsejdjL2hvSWRPTGRlc2ZuaGthN0xJeVYzNFMz?=
 =?utf-8?B?S1lPbFNkWVM2S0o3dXZadVRubVB2QnFpS09VWnFScjNHeEsyOENEUGplYlQ0?=
 =?utf-8?B?SmJzZHRIaGxaRUd2QkZLbkdBNThTWGRjN2xsYlFQeG04eDhJeXlQQXFtZlY3?=
 =?utf-8?B?dVNGTmJ5TW9BKy9yQVo4M2RLUEw2TGZUclJFaFgrQW4vMnlkTjdMQmJiQ0xi?=
 =?utf-8?B?VVdVQS9QZWxJY040cDJrclJTMmwwdVVRQlBJTEdYU25RbXlxQTdBQ2czNWNp?=
 =?utf-8?B?bWN5bzlRTnMzam0zenRUSkRnOEljdHhnV1dZNWsrdmJ0M2kvdFVKcVZWd1pN?=
 =?utf-8?B?TjZWTDZ1c0lWRndFUWdnL2U4NnpOcVZjQUJLaGYyMU1Md2hPbGFxVGFMQjBC?=
 =?utf-8?B?cXlkSit5alJHbmJLQlo1cVhFZGpGWFlsM3lpNk45ZDM5NzZQbzFRajRnQUk0?=
 =?utf-8?B?VXpBdW1yZGROUkE2Wm9BY0FIQXB6ZHYwcW1OeisrZnZ2MTNnRFErSzdRU3Qz?=
 =?utf-8?B?amI4WDcrOEVsVS80UThTZ205ckZES24rSHphL096WDBOTDNreXB3a0lPM0pU?=
 =?utf-8?B?ZERVVmVObWhFWnRtS0NQVm1YNW12VWZqU0JxeU9tUzgyMDkvUGhxQVBubDNO?=
 =?utf-8?B?SG5QUjFIVkxuM0hpV3RoVTZTR01yUFpQbm50VWM4NW9ESzN3M0dWTDlvSlNF?=
 =?utf-8?B?bTNXMFJvY3NjUmE5dUtMRDVHL0JyY3pVdC9vb1VBUXdSa093OEQ3VnFtMGJY?=
 =?utf-8?B?YnRLMWlrVFluZm5GRGNqbEQ3cFZPSEhGV2pob2NEMzg1RlZ6TE9pMkNCaW9j?=
 =?utf-8?B?b0orZ1I0bDJoanRsZ0FuTEhXRkhWUzZYa3g1aDZndWlEVVRTeE82OS9ZZE1p?=
 =?utf-8?B?US9TT2cvZFJGdU1xWDJMK0VYZ0tTZmtNZjBRMHFETnV0L2ZlOFRyTHhSTXRr?=
 =?utf-8?B?L1FKMHM5WW1LSU9uNDYzT1dQdkZqU0FINnZ4TFZxSXBMZGJOMmg5SzlMd1pt?=
 =?utf-8?B?bElJS2ZuNUdyQlVORVZVMGlGb1NNUTdUWmV1eTc2OUo3eHlsVzR6UitSU2Zm?=
 =?utf-8?B?SXVFeW1LVGR5amRDKy8yWlk0T2RFcG1WSCswbWpvTDEyZUZyYkxhSlE4WTZJ?=
 =?utf-8?B?U0EyTXU5RzdmNE9ialhDSVEwaUgwQmpHZS9pSU9pYTRtam1DOE80a1JhNkdk?=
 =?utf-8?B?VmNSTHhGODBpSk9qTkpkTkxGNkpZZUNFMURiQWJ1RjRrb3hxdW9jL2N3RG1Y?=
 =?utf-8?Q?ALygtG1+AvOf4mLB9e4hSHzek?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff76d8d5-e1ee-4747-b5af-08dcbe164240
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 17:09:59.1018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iuIcJLwQpV/AzORok4UGzlNUMTu5NTJ0VI9V1aItswKiI0DNlqnQL2Bmc+aVUxQ5NFYpmAkIP7OOEqbWBu3CVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9724

On Fri, Aug 16, 2024 at 11:12:31AM +0530, Manivannan Sadhasivam wrote:
> On Thu, Aug 15, 2024 at 03:15:52PM -0600, Rob Herring wrote:
> > On Thu, Aug 15, 2024 at 9:53 AM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Thu, Aug 08, 2024 at 12:02:17PM -0400, Frank Li wrote:
> > > > LX2160 Rev1 use mobivel PCIe controller, but Rev2 switch to designware
> > > > PCIe controller. Rev2 is mass production chip. Rev1 will not be maintained
> > > > so drop maintainer information for that.
> > > >
> > >
> > > Instead of suddenly removing the code and breaking users, you can just mark the
> > > driver as 'Obsolete' in MAINTAINERS. Then after some point of time, we could
> > > hopefully remove.
> >
> > Is anyone really going to pay attention to that? It doesn't sound like
> > there's anyone to really care, and it is the company that made the h/w
> > asking to remove it. The only thing people use pre-production h/w for
> > once there's production h/w is as a dust collector.
> >
> > If anyone complains, it's simple enough to revert these patches.
> >
>
> My comment was based on the fact that Bjorn was not comfortable in removing the
> driver [1] unless no Rev1 boards are not in use and Frank said that he was not
> sure about that [2].
>
> But I think if Frank can atleast guarantee that the chip never made into mass
> production or shared with customers, then we can remove the driver IMO. But that
> is up to the discretion of Bjorn.
>

I think Bjoin's request is impossible task. Generally chip company send
out some evaluted sample to parter, which use these sample to built up
some small quantity production. Chip company have not responsibility to
call back this samples. There are always some reasons to drop mobivel and
switch designware, it may be caused by some IP issues which can't match
mass production's requirememnt. Such informaiton already removed from
nxp.com. Only Rev2 left.

Leave such dead code in pci tree actually no harm for me, and clean up need
extra efforts.

I send out v2, which don't build gen4 driver default. It may a feasibility
way to do clean up. If no one complain for a while, it should be dead.

https://lore.kernel.org/imx/20240815182420.58821-1-Frank.Li@nxp.com/T/#u

Frank

> - Mani
>
> [1] https://lore.kernel.org/linux-pci/20240808172644.GA151261@bhelgaas/
> [2] https://lore.kernel.org/linux-pci/ZrUJngABI8v3pN6o@lizhi-Precision-Tower-5810/
>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்

