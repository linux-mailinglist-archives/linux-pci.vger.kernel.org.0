Return-Path: <linux-pci+bounces-19354-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47096A02FAB
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 19:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE8E1650FF
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 18:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF1C7E575;
	Mon,  6 Jan 2025 18:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YPTYMuJz"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2058.outbound.protection.outlook.com [40.107.103.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63162CA8;
	Mon,  6 Jan 2025 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736187635; cv=fail; b=YfNpCpIO5rP3t8mLxpmi1BVxqEbNHHwSujtATa8aXLJImdp70IPPnEGxr9HFQWclDClD2nB1PAmtIuvPNeY8imAE1Sl+8y31pMP87+Lb1VTqSWcFg98beh9Snk5LJj3BZHpvQe8lNJ10tW2WuCTwoA95QbJCwNshGK/OyXERbY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736187635; c=relaxed/simple;
	bh=kwNwyLjnFWFvNr0oYCWoqzO9ukcI3JI7ubHetovHZCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H/aqRV+e9PCdxUyzVIPmB9M2/BXD1CrYlefljX1JB64aOiNUxekhfvvt9bSUOV84zvkamXD1RCrDk/vweakhFfBIRHsWFtzS6rD2FTMWZs9m3WGOald6+p3KzY14aRDHZJu8vKqfL19+DJ75u+7o+oxVeY+o/x4Gp0eK3PQS4hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YPTYMuJz; arc=fail smtp.client-ip=40.107.103.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GX3I+qSCDQTtH78yQnOVZvWst5+0ZEfVmazpGOyVY4L9wHZzT5YH3xPFLEw2kJJ9C/ttyx7OkR6WRa8znRdA/yt5jQmj2O1CYjB+H9BAV1NC/cXScf2THuTygtK9JtvXC79GoNftJ3jR/KvOGsPaEkv+rTB2taq9cAZ9I5JaPrfYORqrKLZJC8/YEiNApKnfTa0jjQjxxLgAZ/39SyL017AnPHU/N622KFSM616HZI68cXd8D4dT+R6yIsacmkj4+AZhTNYaKcxveERRiTdiHoREPwJisO/QNW68AYLNMIRROgBo/UFhHONVB/vltAt/Z21wsQXPqSSGv5Q0GR9CYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WEwNqTLkDIANPAY038ax2+OHT7Yz986trHyf3y8OcU=;
 b=UINIS9czDEGJIF8IrTYld1IKIpz3rr3me7VJaAePqxKgO+m0l3CIKGl5UkNDXb05/XYzOtkBLL/J176IuQ3EJcBZPPAmgQXNpzTdryJrSf2YwU3rj/sVLJr0ZHkG+tB+8ZN5JPp96rjnuQpc+3nJXcuirz0EKVHwOSiome/PSbTuNOihRsA3pVwuISfl+If3NOXcU1BPPFoDL56CEMMnlUnmxp3lVqDdwE2n0ZS8bAeKbWoF6RnZbTX37gMyouaDgOQOkV9maYPrvBicOKhaJip8EIH4TFQxzV09IqgtR0YdWgyNwOsv+FjfDjtJ9X0oI9GXOpYKyYgkfJTFkLAuBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WEwNqTLkDIANPAY038ax2+OHT7Yz986trHyf3y8OcU=;
 b=YPTYMuJz+ug8rwLhuxZdFY9Ld1HdizHqTGmilWvj3lSLQv8HXGSERcTI0nlTjXJGGduE4vgEQ9N2zfxibTN+qBV1k0fgOn1vIIJadiPsiqhsp4HBKwU61kd7OHVu042BMmzF0CxtVc6ka6yC7GD4ifkSjP+qHlbbm4s3WVQyTdphhhC/D9VaEhY3MNzounwPSp4SEfJ1ezdpBgSdPz/6JStc1MYcGoTVJmJdd/my5fh9YwNQuvFV66jmDmGz1qXw5aPlTsKPM1FXYFOZzUfvMDUXjmO92OQ8/Hj9HmJl1SVCR6N//CrJCniV3ao/jSsv7PsaZCVOyaGIHbuMB8Olyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB9798.eurprd04.prod.outlook.com (2603:10a6:20b:654::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 18:20:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 18:20:26 +0000
Date: Mon, 6 Jan 2025 13:20:17 -0500
From: Frank Li <Frank.li@nxp.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <apatel@ventanamicro.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org,
	jdmason@kudzu.us, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v13 4/9] irqchip/gic-v3-its: Add
 DOMAIN_BUS_DEVICE_PCI_EP_MSI support
Message-ID: <Z3we4QuRo5ou+r2y@lizhi-Precision-Tower-5810>
References: <20241218-ep-msi-v13-0-646e2192dc24@nxp.com>
 <20241218-ep-msi-v13-4-646e2192dc24@nxp.com>
 <868qscq70x.wl-maz@kernel.org>
 <Z2RRimPlT41Ru281@lizhi-Precision-Tower-5810>
 <Z3wG6pMbjsldqU/n@lizhi-Precision-Tower-5810>
 <861pxfq315.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <861pxfq315.wl-maz@kernel.org>
X-ClientProxiedBy: BY5PR17CA0037.namprd17.prod.outlook.com
 (2603:10b6:a03:167::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB9798:EE_
X-MS-Office365-Filtering-Correlation-Id: 02d7991d-eb4b-4423-8e41-08dd2e7ecaa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djhzWVpYMGxxanhkUmU4OTRCdTk4RjIrMFgvRWdKYWtFbHZKS1hjQlFuRzY0?=
 =?utf-8?B?bWg4RUlUbVROT21hdCtFMW5vWmQ4R3VvUTE3cXEzV1FkbUVaQStQamFjRjF2?=
 =?utf-8?B?ZDk4Q3lpVVNiMVRYbG44d1prK0paRk5NNGZqbHFVK2R4OHpWMUx1eFBDRkM0?=
 =?utf-8?B?bmY2Rm1DUnBGdGc2MnMvRTZ6MTRyQ2hVVTZhSG44ellpWFJ2YlBlRWJUZDRz?=
 =?utf-8?B?U01TSkNHVU9xdmJEUWpGVDJDZFk4dXJGV05zVFlGZVJaRW5ZUFZURVh5QlNI?=
 =?utf-8?B?WHhXbmI2bUtybzR3eTNiOWtvY3FnME1xN2xWZ2Q0N1dCd2xIdkNEY2lub0ZZ?=
 =?utf-8?B?U1BFZUdhazhManRPR2tLQjR5dkMyZXpmMUZ5VUNrUlZGcGg0ODdlTTBuRzRL?=
 =?utf-8?B?VlBUd2dDWlpiUHd6Q0ZwS2Vsc3owdkVza2ZxaUdIdkxraEk5djdNNVh1eUdI?=
 =?utf-8?B?VlhKWk5LamtDQ01scFpjd3g5UmMraUR1UGxvV3VNZ2g5bm5IMHFuekFZT2E1?=
 =?utf-8?B?US9CN0kwYUhKZTh3UHBYdW8wYmVmTys3eVB6c2lRRDZ1OXlhNHRYT09mRW5P?=
 =?utf-8?B?bCtrYXh6QTI4T1E4N1pzSFRoUzlZTE40L1RKOGhwUE9TUURGRUQxYm5POWdK?=
 =?utf-8?B?SnplZnBGRHZTaXB2a3EyR3pqWTY1Ui9VeTdJMk9pTXpEd2tsVUdWNkNJRHpG?=
 =?utf-8?B?REhBYlFxMTlhU3NaQkNHbFFxcHRTdXVVYnMrNDNPZXpET1ZEMEdUMk5RczdP?=
 =?utf-8?B?SkhnenR2R2pRakVvS01acjBub2kxTS95RGZKanp1UmMxU0VFbWpxa2gyaVlw?=
 =?utf-8?B?d1VWY0NJWjNxTnczTzI4TlNzeHZkVGxoY3l6eWswaFV4Um5vbnZQK0ZFc0JZ?=
 =?utf-8?B?Sk1uUmFOd1l4c3pLaHdtRm5vaUNaWndCTTJNYWhDRjYwdzluYVhNMUJUTkx4?=
 =?utf-8?B?MDVMUjVNblYwLzhwSERHNC9qRHdSTVBTcG93Mlc4OEhWZEpKaFQvbElqc0Fl?=
 =?utf-8?B?dHFGN2d1UngrdW5VVGxUbTBsaFJRRlNFNnByNnBBeVZpVjBDQ1NDamlxMjdt?=
 =?utf-8?B?N0JrTE52Ym9NSlR2WVdvVWQ4NG0zUkllNEw5bEZYQUdvRVlGU2ljdUdkZUhQ?=
 =?utf-8?B?enh5MWIydmFzbVdCellwWDk0eDlDbklOK0hSeEFwaXJMdFhkRGNtTndxU0hU?=
 =?utf-8?B?MWk3K0ZjU3VmRWR6eHRpSDU3MCtFTHZCTDNld0d5M1QrQ21XcVFON0JhbUcx?=
 =?utf-8?B?amxFTVl4OUEvT1VkcEVWMFhCampGNXZOMFVPUVpDZHN6bndtb2VRbm5xclg4?=
 =?utf-8?B?aWt1SGI2VEs0UzRjd2c1SnJGMnFhYzJGa1M0VUhveWpjczhRUkpBNFBGbEhh?=
 =?utf-8?B?WEs4Q25kZ01CajhEOHBGMXNxL3FFdmZDbDFpb0hIWWlEM3hsNTQyOGVjSUQx?=
 =?utf-8?B?bUk3SE9pcWwzb3Bkek51QXNqeVh3SGQ4Tk9iZjlJTG1xK3hxVS9qcEtra3VW?=
 =?utf-8?B?MWdaYVlWWXFRRnhZTXNsMGI4dGhPRG1uVlEvZERCTWJ2bGtnNFVVb0N0cWlo?=
 =?utf-8?B?MEV1Tkd0UzJuc3IyMjdMV1dTRVZTZ3JoTHFJTm1ybWt4VEVVSnEyTXYzdUlm?=
 =?utf-8?B?WmZSQVFTdkw3eTd6MXlkbWRkd1NKRWo0Zy96SnFGMEdlRTdwRDZ3OHIxQi85?=
 =?utf-8?B?d2FJY2xYREZ0UE80YjBFdkZISG1uVS9zL1o0dHBuZGdZYVBVTGQyam5ZRGZF?=
 =?utf-8?B?YUR3dCt2bHAyOGJDRENaSkdlbzhkc2V4UWxkakNKTG9VNkNoaTNvTmtpeEhQ?=
 =?utf-8?B?WjRKMVp4MmtOOWlvbG5Objc5N2JFUWZJL0tveHczaGtsTTFBcndDTUFlWUQx?=
 =?utf-8?B?RkhFSWRQUkNTT21xazd3elFQZGR4R1pUbSttV1V2UUZNSytsY0kxT1R5M3Ur?=
 =?utf-8?B?clN5ckZGNGxLbStHNVVoeGs3UElBWGtJM21nVGFFb3NaT0tSN3JiL0RuNWFu?=
 =?utf-8?B?eUQxQ0VxcWJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGdJUG1URHNaaWZiK2ZnM25DNHh4d2kxNng2UVZiTlV1L2MxcnNBaVNibG1R?=
 =?utf-8?B?enBLcHE3dXJjSWdVZVFsakFLcVhKWEVQc1ZqaEJLRnRjUkdCNnhOdVNWdlBY?=
 =?utf-8?B?NzFCQWw5bEI0N01SbnhTdGxrdU42MUJISnNzNzdXbk1lVDRESlRCYkRSV2dU?=
 =?utf-8?B?NklsQ0lxZUZXYXJDTEFGQ1RTQ21hdStIcjRESWN2MEN0bTN2OWZNak9iSERF?=
 =?utf-8?B?djZWM25vemlzZno0Y1JrVHlINmQ5dkZqVCt5S2RwVXdhanBRMWZIa1hucGpx?=
 =?utf-8?B?bCtNRWlyTm00ZjhCNjUzL3NMRTJOaHVqQW5iU3AzWjBaMG1MbXV6cnM5YXp0?=
 =?utf-8?B?Y1N2K0ZOOVVSbkxLZEVCR2FtVDlPV0JId1J4NEV2VURkYnA5dnc1eUI1WmhG?=
 =?utf-8?B?RERBZFFMOGs3azM5OXB1N3c0Y0taNUphZHR6cit6RE1QaTlIMUsxSGRLZTYw?=
 =?utf-8?B?bFpsQ0p4RE9aVEdRTUlCY3hZWldwK2hOdFRadVhQMUR6WXNYdUlKQjBiQldE?=
 =?utf-8?B?a2o3Z2JXZ0ZEYVF0bVkyNUFJYUxJU09pcHpzM3pOT0Z6MlhueFF1T05ySDNU?=
 =?utf-8?B?STFwc2dNTTI2UFNiMW0rWlJDaXMvNFg4bVorNVVpM3U5MUtLaG91VldKU3VK?=
 =?utf-8?B?R0lBaWdodndRRTRZZU16cUdvdVlFSkRwZEwzRHZKM000T1ZNNlU1dnNEbjJn?=
 =?utf-8?B?TmpOa0E0S3BZTGJKY1ROcHdtS2VWVDFBTldGZ2N6ZzNJZ3h3N2dWYnRSTzFs?=
 =?utf-8?B?SGJLZXE4MzZ2eEwvMDMreHRMdy9DTjlRSjB2dUdXaklicWdxN0tUTDF4QzFF?=
 =?utf-8?B?eXVpREpHcU1teE5rMHBhWkpBUXpLUzlpQkFtMWhoOGxqODN0M0kxWmRmSWYz?=
 =?utf-8?B?TzJJSzc2ZDIrbWpobkdUaXBET2hQVXdoaDI1Q1ByUFc1bkhON29jUTBJWUty?=
 =?utf-8?B?RU00OU9pbzUwQkxEbCtneXBoeWltaXdrNzR2U0lmM2xOWEx5N0dEYWsxSEw1?=
 =?utf-8?B?c0dDWkdScXA2c3hDWFNzSkRMS0ZVTlFFbEc5NmhMNldRQ0Iwa1RUTE0vSXdu?=
 =?utf-8?B?Y0lYdVZYRTEvQU83M3c0TE84aDUzQXM4b29OOEptc0tMcm5yQ1BzdWdnbklJ?=
 =?utf-8?B?c3dpdHQ0WDhnRDlibWpsbk1vdTBjT0ZEaWFtTlhaaCtXNUJXMjZnMVJVWUtD?=
 =?utf-8?B?a2VQSEJ1RGdtaWUrcDFnZ1RGUkdCQk5Ic0hiUEhqS1pHU3NqN3luTjQ5SFpy?=
 =?utf-8?B?RFQzcnBaazlDTFZnS1hkRzVleHo4WldLNlExQk8xOEVFT1ZHV21lRXBNUW5w?=
 =?utf-8?B?UXljMXFJRzZOcnJkbHpkYkpHRU42WFNPb25oaVhZSEZTNTdlSEV6dXgzSmZa?=
 =?utf-8?B?MXRWMlMvM2FVSnJFL3RGUm5sWHpqam1WaUV1VzBtdFFva2twQU5vemJUWUFy?=
 =?utf-8?B?ZGtNV0ZISzRsdXVSNkFsUlNuOEs3MnA3WlRVQmYrYzdKR1pNc2ZsVWFJckZl?=
 =?utf-8?B?OGZ1UTYwZExaeXBYQW9wV2g3eDM3dmhWRE5mWVBOWmJkRzNkb0FqVFhaL2o4?=
 =?utf-8?B?aXh5aXlWMUpiRUNGUmFlekc3TFM5d3UxNGExV1ZWWldHTGRkMGhETEJKbVZE?=
 =?utf-8?B?a241TVczQnlzMlNEeVVFWTBiMDVjcXJrSUFOQ3dreC9kMDFxZnorY1lZZXFY?=
 =?utf-8?B?M2c0UU5hdWtoT1d2WTQxZzB2SzJrRUxuQXJYaHo4T0xDQUlPalc1UVJIOW0v?=
 =?utf-8?B?NHd4ek5pQXdhUTBnQVBnbXpsWUFRMHR4U0tFa3hPVnFPZWdnOWhKc3FKMHdG?=
 =?utf-8?B?dFp1bC9nWTBtR2lmdlVya1Y1aHRqNGdJYnhNQWJDN2xxcU9qWDM0dmNtMkVP?=
 =?utf-8?B?RzArb091bmFTRFVQcTVDWjVPUU1EYzBiUFJ0dkNBZnBWZmhzL0FUc0lBY0ty?=
 =?utf-8?B?M1d2Y0VMSlJNckw3bTYvczVuQnBBNkljOHhGVDlqSXFRMUFZYzZyQ0dBRGwz?=
 =?utf-8?B?NzNqSkErQlNBVlpVWERYcDFHQUZYVTZWTmxtdllWZ1pGckpJaEI4c0Fqc3Vs?=
 =?utf-8?B?R2tiVEhXdDQ2ZkowSzQyM1NUVm5hZ2ZpbzV4R3VZUGN4bnhGbG9EQjhGOHlP?=
 =?utf-8?Q?UNBi7z0WqOJq53v7sQzO8Klhb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d7991d-eb4b-4423-8e41-08dd2e7ecaa6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 18:20:25.9973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dR0ooVj9oTT6ZyLTtHEj384AuSVfUanrt8oVj8CNg96X6/THATPpeVuTWT0eVDReWaOPWicJ7qvKE4q5j8ZYCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9798

On Mon, Jan 06, 2025 at 05:13:10PM +0000, Marc Zyngier wrote:
> On Mon, 06 Jan 2025 16:38:02 +0000,
> Frank Li <Frank.li@nxp.com> wrote:
> >
> > On Thu, Dec 19, 2024 at 12:02:02PM -0500, Frank Li wrote:
> > > On Thu, Dec 19, 2024 at 10:52:30AM +0000, Marc Zyngier wrote:
> > > > On Wed, 18 Dec 2024 23:08:39 +0000,
> > > > Frank Li <Frank.Li@nxp.com> wrote:
> > > > >
> > > > >            ┌────────────────────────────────┐
> > > > >            │                                │
> > > > >            │     PCI Endpoint Controller    │
> > > > >            │                                │
> > > > >            │   ┌─────┐  ┌─────┐     ┌─────┐ │
> > > > > PCI Bus    │   │     │  │     │     │     │ │
> > > > > ─────────► │   │Func1│  │Func2│ ... │Func │ │
> > > > > Doorbell   │   │     │  │     │     │<n>  │ │
> > > > >            │   │     │  │     │     │     │ │
> > > > >            │   └──┬──┘  └──┬──┘     └──┬──┘ │
> > > > >            │      │        │           │    │
> > > > >            └──────┼────────┼───────────┼────┘
> > > > >                   │        │           │
> > > > >                   ▼        ▼           ▼
> > > > >                ┌────────────────────────┐
> > > > >                │    MSI Controller      │
> > > > >                └────────────────────────┘
> > > > >
> > > > > Add domain DOMAIN_BUS_DEVICE_PCI_EP_MSI to allocate MSI domain for Endpoint
> > > > > function in PCI Endpoint (EP) controller, So PCI Root Complex (RC) can
> > > > > write MSI message to MSI controller to trigger doorbell IRQ for difference
> > > > > EP functions.
> > > > >
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > > change from v12 to v13
> > > > > - new patch
> > > >
> > > > This might be v13, but after all this time, I have no idea what you
> > > > are trying to do. You keep pasting this non-ASCII drawing in commit
> > > > messages, but I still have no idea what this PCI Bus Doorbell
> > > > represents.
> > >
> > > PCI Bus/Doorbell is two words. Basic over picture is a PCI EP devices (such
> > > as imx95), which run linux and PCI Endpoint framework. i.MX95 connect to
> > > PCI Host, such as PC (x86).
> > >
> > > i.MX95 can use standard PCI MSI framework to issue a irq to X86. but there
> > > are not reverse direction. X86 try write some MMIO register ( mapped PCI
> > > bar0). But i.MX95 don't know it have been modified. So currently solution
> > > is create a polling thread to check every 10ms.
> > >
> > > So this patches try resolve this problem at the platform, which have MSI
> > > controller such as ITS.
> > >
> > > after this patches, i.MX95 can create a PCI Bar1, which map to MSI
> > > controller register space,  when X86 write data to Bar1 (call as doorbell),
> > > a irq will be triggered at i.MX95.
> > >
> > > Doorbell in diagram means 'push doorbell' (write data to bar<n>).
> > >
> > > >
> > > > I appreciate the knowledge shortage is on my end, but it would
> > > > definitely help if someone would take the time to explain what this is
> > > > all about.
> > >
> > > I am not sure if diagram in corver letter can help this, or above
> > > descriptions is enough.
> > >
> > >
> > > ┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
> > > │            │   │                                   │   │                │
> > > │            │   │ PCI Endpoint                      │   │ PCI Host       │
> > > │            │   │                                   │   │                │
> > > │            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
> > > │            │   │                                   │   │                │
> > > │ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
> > > │ Controller │   │   update doorbell register address│   │                │
> > > │            │   │   for BAR                         │   │                │
> > > │            │   │                                   │   │ 3. Write BAR<n>│
> > > │            │◄──┼───────────────────────────────────┼───┤                │
> > > │            │   │                                   │   │                │
> > > │            ├──►│ 4.Irq Handle                      │   │                │
> > > │            │   │                                   │   │                │
> > > │            │   │                                   │   │                │
> > > └────────────┘   └───────────────────────────────────┘   └────────────────┘
> > > (* some detail have been changed and don't affect understand overall
> > > picture)
> > >
> > > >
> > > > From what I gather, the ITS is actually on an end-point, and get
> > > > writes from the host, but that doesn't answer much.
> > >
> > > Yes, baisc it is correct. PCI RC -> PCIe Bus TLP -> PCI Endpoint Ctrl ->
> > > AXI transaction -> ITS MMIO map register -> CPU IRQ.
> > >
> > > The major problem how to distingiush from difference PCI Endpoint function
> > > driver. There are have many EP functions as much as 8, which quite similar
> > > standard PCI, one PCIe device can have 8 physical functions.
> > >
> > > >
> > > > > ---
> > > > >  drivers/irqchip/irq-gic-v3-its-msi-parent.c | 19 ++++++++++++++++++-
> > > > >  1 file changed, 18 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
> > > > > index b2a4b67545b82..16e7d53f0b133 100644
> > > > > --- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
> > > > > +++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
> > > > > @@ -5,6 +5,7 @@
> > > > >  // Copyright (C) 2022 Intel
> > > > >
> > > > >  #include <linux/acpi_iort.h>
> > > > > +#include <linux/pci-ep-msi.h>
> > > > >  #include <linux/pci.h>
> > > > >
> > > > >  #include "irq-gic-common.h"
> > > > > @@ -173,6 +174,19 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
> > > > >  	return its_pmsi_prepare_devid(domain, dev, nvec, info, dev_id);
> > > > >  }
> > > > >
> > > > > +static int its_pci_ep_msi_prepare(struct irq_domain *domain, struct device *dev,
> > > > > +				  int nvec, msi_alloc_info_t *info)
> > > > > +{
> > > > > +	u32 dev_id;
> > > > > +	int ret;
> > > > > +
> > > > > +	ret = pci_epf_msi_domain_get_msi_rid(dev, &dev_id);
> > > >
> > > > What this doesn't express is *how* are the writes conveyed to the ITS.
> > > > Specifically, the DevID is normally sampled as sideband information at
> > > > during the write transaction.
> > >
> > > Like PCI host, there msi-map in dts file, which descript how map PCI RID
> > > to DevID, such as
> > > 	msi-map = <0 $its 0x80 8>;
> > >
> > > This informtion should be descripted in DTS or ACPI ...
> > >
> > > >
> > > > Obviously, you can't do that over PCI. So there is a lot of
> > > > undisclosed assumption about how the ITS is integrated, and how it
> > > > samples the DevID.
> > >
> > > Yes, it should be platform PCI endpoint ctrl driver jobs.  Platform EP
> > > driver should implement this type of covert. Such as i.MX95, there are
> > > hardware call LUT in PCI ctrl,  which can convert PCI' request ID to DevID
> > > here.
> > >
> > > On going patch may help understand these
> > > https://lore.kernel.org/linux-pci/20241210-imx95_lut-v8-0-2e730b2e5fde@nxp.com/
> > >
> > > If use latest ITS MSI64 should be simple, only need descript it at DTS
> > > (I have not hardware to test this case yet).
> > > pci-ep {
> > > 	...
> > > 	msi-map = <0 &its, 0x<8_0000, 0xff>;
> > > 			      ^, ctrl ID.
> > > 	msi-mask = <0xff>;
> > > 	...
> > > }

Bookmark 1

> > >
> > > >
> > > > My conclusion is that this is not as generic as it seems to be. It is
> > > > definitely tied to implementation-specific behaviours, none of which
> > > > are explained.
> > >
> > > Compared to standard PCI MSI, which also have implementation-specific
> > > behaviours, which convert PCI request ID to DevID Or stream ID.
> > > https://lore.kernel.org/linux-pci/20241210-imx95_lut-v8-0-2e730b2e5fde@nxp.com/
> > > (I have struggle this for almost one year for this implementation-specific
> > > part)
> > >
> > > Well defined and mature PCI standard, MSI still need two parts, common part
> > > and "implementation-specific" part.
> > >
> > > Common part of standard PCI is at several place, such its driver/msi
> > > libary/ kernel msi code ...
> > >
> > > "implementation-specific" part is in PCI host bridge driver, such as
> > > drivers/pci/controller/dwc/pcie-qcom.c
> > >
> > > This solution already test by Tested-by: Niklas Cassel <cassel@kernel.org>
> > > who use another dwc controller, which they already implemented
> > > "implementation-specific" by only update dts to provide hardware
> > > information.(I guest he use ITS's MSI64)
> > >
> > > Because it is new patches, I have not added Niklas's test-by tag. There
> > > are not big functional change since Nikas test. The major change is make
> > > msi part better align current MSI framework according to Thomas's
> > > suggestion.
> >
> > Thomas Gleixner and Marc Zyngier:
> >
> > Happy new year! Do you have additioinal comments for this?
>
> I think this is pretty pointless.
>
> - DOMAIN_BUS_DEVICE_PCI_EP_MSI is just a reinvention of platform MSI,
>   and I don't see why we need to have *two* square wheels

"DOMAIN_BUS_DEVICE_PCI_EP_MSI" was purposed by Thomas Gleixner.
https://lore.kernel.org/linux-pci/87o7197wbx.ffs@tglx/, the difference
is
- "platform MSI" only have one device id for each device. But
DOMAIN_BUS_DEVICE_PCI_EP_MSI have multi child devices, which need map to
difference devices id.

If you like, I can try to extend "platform msi" to support msi-map. But
The other problem "immutable MSI messages" need be resolve also.

PCIe EP require "immutable MSI messages". address/data pair can't be change
by set irq affinity.

>
> - The whole thing relies on IMPDEF behaviours that are not described,
>   making it impossible to write a *host* driver that works
>   universally.

Host side need NOT know EP's side IMPDEF behaviours. Host side just know
addr/data pair.  *(BAR<n> + offset) = DATA (in RC side) will trigger
doorbell.

"AXI user bits" concern see below book mark axi.

> Specifically, you completely ignored my comment about
>   *how* is the DevID sampled on the ITS side.

See above "book mark 1", let me change another words, descript again,

It is quite similar with PCI root complex case.

In PCI RC's dts, it looks:

pci {
	...
	msi-map = <0 &its, 0x<8_0000, 0xff>;
	                      ^, ctrl ID.
	...
}

ITS call pci_msi_domain_get_msi_rid() to get device id.

static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
                               int nvec, msi_alloc_info_t *info)
{
	...
        info->scratchpad[0].ul = pci_msi_domain_get_msi_rid(domain->parent, pdev);
	...
}

PCI msi common code call __of_msi_map_id() to convert PCI rid to stream id
from dts file.  It should have similar method if device have not use DT.

--- EP case (Run at EP side) ---

for my patches, it do similar thing, in dts, PCI EP controller

pci-ep {
	msi-map = <0 &its, 0x<8_0000, 0xff>;
	msi-mask = <0xff>;
}

static int its_pci_ep_msi_prepare(struct irq_domain *domain, struct device *dev,
				  int nvec, msi_alloc_info_t *info)
{

....
	ret = pci_epf_msi_domain_get_msi_rid(dev, &dev_id);
....
}

PCIe EP common part will convert EP function device ID to difference device
id according to msi-map in pci-ep node.

>  How is that supposed to
>   work when the DevID is carried as AXI user bits instead of data? How
>   can the host provide that information?

book mark AXI:

Host driver needn't such information. Host write PCI TLP, such as
*ADDR = DATA.

PCI EP controller get such TLP, which convert to AXI write. PCI EP
controller will add AXI user bits, which was descripted in PCI EP
controller's dts file.

pci-ep {
        msi-map = <0 &its, 0x<8_0000, 0xff>;
			      ^ "8" is AXI user bits, which added when
convert TLP to axi write.

}

>
> - your "but it's been tested by..." argument doesn't carry much
>   weight, as the kernel has at least one critical bug per "Tested-by"
>   tag

My means is this solution can cross difference platform with only dts
change.

>
> Given that, I don't see how this series is fit for purpose.

sorry for add book mark to refer to difference place in the the mail.

let me know if need further description.

Frank

>
> Thanks,
>
> 	M.
>
> --
> Without deviation from the norm, progress is not possible.

