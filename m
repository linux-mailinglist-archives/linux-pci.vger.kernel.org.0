Return-Path: <linux-pci+bounces-16274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FE79C0C19
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 18:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BAE1B21954
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 17:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634FE824A3;
	Thu,  7 Nov 2024 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k4X3AFqq"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013020.outbound.protection.outlook.com [52.101.67.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205C41854;
	Thu,  7 Nov 2024 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730998972; cv=fail; b=FfY/58c7bYvAKSm+xgSLZcIA+eXLzD9tSgLkdzxjilRypSJ80R/pimkD9OGLbOM7BRSsdyKcGuPC14bJwYpL/5zy+EtFWDzDwZv3cQ5wR1Mb6N6fS2pVOtSKkzmHooHSCVMqyNnX8wQdUzPB1w3q2H2vOn8zxqXjkRlmYSK03QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730998972; c=relaxed/simple;
	bh=CriNaRbngc+Tnw86CCcUVxLfSrGLNdWG4P2CzWkLNpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cnchgQb9i9RDuHov+tlv983uQefCo/QGvQUUML6qGzEKiA3A71MPdyxphPRazNdKtfX3h7zWUqDmGa1yGN6mHTyArL02+cnGOCUgCV9nXD9BUYIMGCBBV1v7rlNjXsU1BsI/6aBUlci75skSTGyVrYmnCScebjMZ7Cej60xK69I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k4X3AFqq; arc=fail smtp.client-ip=52.101.67.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o370UdlCo7huGtmYYfBbl12HbuF9Xoyhc328vzhiG5Ktx5fAP4vvzSDA1gfE/yLN+cWYf8OoiLqyIFEgQMW93Bg9z1yykB7fIi2rhxtF9tvDtBXUhHb2k2tt6s7Cpr0s+uYBHMaJ8kGz2aJYXi72Ey0GLhXSf3BIvikwpbzNd6k8n8FWE4veGfoVTclmYPpTfluzue1afJ/i/NM9NItZsancH0+DzOBQotDMTNjkGvdSApILc3SHkFBwJJsSgZDPwkQQHFM8hLuVnrCj8FXwWzf1n7fUYc8RsRyYVD9oCUr/Z+jcahPitIksLfKuGVe7MWRoAIG7gwdu0CU3ol5loA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSVqercAspMclC7eqImftDhrpLSDMkTFBbZboNhWVfY=;
 b=fMA2kGd/yuSE4xV+de0Xurxfs+Wbgdt5g1MI3/jAlj2fTmi06cG2SeJEPmyLMZjC13tCz4zUSqFyb8tzMOv3kYJ7lLWMiDLUDTu6nXXCxXulaNWf1E62hUSD1tflXtaXN2LekMRhQCQUY07Gt/TJRI5KM1R9tCcQqG11Q678o3MIhV37jksDjHfH+cs9I4GJcuunOgCb9REmUJ5J16tsW+fwzDZ9ayrAqz/i7gX18d3Wxo0Bo7xd5ZI09DiIJqXO0zFITTWhVTA3fHK490fnqsC4L2IAOR7YMwc6MBkSmRaFhBj9e2jXdyh+u65C2HD3kpLkGp/nENzIVi1LJ7hB9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSVqercAspMclC7eqImftDhrpLSDMkTFBbZboNhWVfY=;
 b=k4X3AFqqGuHa0oTUx8feefyg5mk+S7A82uLC/LsaFv2NVho6lyD1FaWD3yBt4y00nj334eKIYRqnqsS9vW+HCFS2+PEiLHSIi7j7HuD8Bcb8wcL2n/x4H8WUdt3kG4zQsJEMIxphTUEqxyWy8ePmAerVZji+UYWTJjnf+0fwEQ+ron5ZxeamHacBqk5g4skL/OGg7FjlGV6x9h4ynsozzMzNRL5O6we6IW8QywC+KJkBDFGepDVYFSiRhG0kj4P2pN5ft2LTjNvPYeD4kRTOIHRqKFZPpQH6IG/fZw83dS5BZxGKiEC2F4V3YKJO5KfDd+0hVNpePGNnZ++kfHZDKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10327.eurprd04.prod.outlook.com (2603:10a6:150:1e2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 17:02:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 17:02:45 +0000
Date: Thu, 7 Nov 2024 12:02:35 -0500
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v7 0/7] PCI: dwc: opitimaze RC Host/EP pci_fixup_addr()
Message-ID: <ZyzyqzpBKb2xedWs@lizhi-Precision-Tower-5810>
References: <20241029-pci_fixup_addr-v7-0-8310dc24fb7c@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241029-pci_fixup_addr-v7-0-8310dc24fb7c@nxp.com>
X-ClientProxiedBy: BYAPR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10327:EE_
X-MS-Office365-Filtering-Correlation-Id: 02cfdc37-de5c-4c63-6be3-08dcff4dffbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K05abFJHd0Rpb1ZHYXV3L2t3Sjl1M1ZUdWdDemE0cDhzdnVNb1BpVmsrOXJV?=
 =?utf-8?B?cEtHdzRtYUVTS2ViSGFzcTJaSlJyakMrUlBIWlpORFZOT1Z1NG5PMkZsL3Rx?=
 =?utf-8?B?YXFvK0JONWVhUmQ2Nk56R0hjY0NncHJFVHdYVGFYZDFGVEVaWGw5SFNwNjRx?=
 =?utf-8?B?TTdwU1lROENIVkwxMTI5VlpyRkU1TU5QY3VGRE8wZmg5VFpiNUx3V3QxZXZ0?=
 =?utf-8?B?Y2I2N284Y0ZhSVdCYWlzZnQyYUdOeHBjT1h6Yi9KNGFaWFdLRU1SL0lnMHp4?=
 =?utf-8?B?WWRxcUNqNDlFcldrdzhzbzh3VVluaG5CYVZQTjJ0UzNFd0NPL0psS2dhYzR0?=
 =?utf-8?B?Y1FXRlNWYTRIa1JOVnZ6T0g4dENCSFBGSHZGZ1dWU3JxdUo0WGcxQTJ6WkpM?=
 =?utf-8?B?MGZ6cGxYNmVhOGRia1R5WFEzVzU4aDdTM0xZUjRreElCWEdZWDYwNWpKNjlD?=
 =?utf-8?B?d2Z2MWN3Y0FrcWFlTWsrMGJlejN1bGZFQVdCZ25PKytnT0QzeEhnRzY3Unlx?=
 =?utf-8?B?WDl0ZDB3cUxaRnE5K2wzdU5KbnJqWjRla1pYbzQxVTB0a0wwMHJ1ZklKTXFT?=
 =?utf-8?B?eGhwRE1va3BhdGJiY1ErRmFOT0p4ZkxxeE9KUWNROGJGS0x4NFpmM2phNHpt?=
 =?utf-8?B?R045Z0E2VmowaWc5Z1dQcWlwdG10SVZpWjFxaVhUdVhpc0J2d1VsWmRDNUM1?=
 =?utf-8?B?UWdIMlYxb3JncmJzQWF0aUMxZ1hqUUErREVlWWNxSVlKRzdPUE9xTitiRzQx?=
 =?utf-8?B?QmlsVnZueUx3Wis2T3pmWXB4QXd0dzZUTzViOHJuZGFOOExxRktQeUthVWhV?=
 =?utf-8?B?dHRRZytHeGpoaUVJZ2dEUXlCNWdjN1JjeWVMWGhpUWZHNnIyOG1hS0JxYXcy?=
 =?utf-8?B?d0tZcXZxQnpxU1kxREM3ZlRRVEloRVlEQzI0ZGxmeGl2bjRMYmZ5NmJIbGZ2?=
 =?utf-8?B?TzRXS0w0c0NqWWVtU3BVby82MFhvSXNpM3g0OSsvOHRpNlNUK1RWT2dHeUVs?=
 =?utf-8?B?UEUxSllpOHRPdC9sWlE5RkZzS1BvK3BTZ3pJbVVnNnVMQUo4Yzg4c243ZUE5?=
 =?utf-8?B?ejN1MmRWNDVnTzMxUTZ4eTloZlFvUk9wQm5yeitiWUV2SUJOMkdTeTN0bC9r?=
 =?utf-8?B?T0Jxd3U4WWJ1SUlHSUFVc0VBb1Vib242cC9TQzhDSFcrWEdHWnUzQjJQWmRO?=
 =?utf-8?B?Z3pWR2RIblF3eldvcFR5RlFMYUVvbHhVZFVmZkhBVzYwY0RINWhkUGkxMXBt?=
 =?utf-8?B?Vnd2aXA3Smord0pRRHhGcnkvWks0aHdIb2YvZ1lqSy9LRTBKMHRZdHpMWGVL?=
 =?utf-8?B?ZWhSNVU4c3kvQ1V4dnF2TnV2RzBRYmc5Ukx1ZnFNcTNUUmtaTy9WZEV3dnFl?=
 =?utf-8?B?U3FrcStoWWJ6T3NRQlIvdW4yZzgzS01tOSt4aU9CK2Y2MnovSWlOSlRISU5D?=
 =?utf-8?B?WVFJMVZMNmhrZi9NcUJVblpySTJuVElpMGhVQ3V1ZXRUeW03YkNPVTVGY2h5?=
 =?utf-8?B?TkZ3UmFLeVA1bkxnVThMeDRmaUFQcDZEQTU5T3FOb0FjdlpNRkR3QklocHVt?=
 =?utf-8?B?NTlibW5haEVLeWt3WDBQbkhrRk9GTHVyMWo1MUREd0ZIakJ1SEo4am9MZlds?=
 =?utf-8?B?dTNHVTVGU1BOSGxweElsOTZtZDJJbXF3S3NubERrZ1dqd1JoRVhXd1djeFJr?=
 =?utf-8?B?SEE4cVZSSWFHYVBQbFlzaDZHQ1RFMHZGN1VaaUZ3Q0VjRHZjWU05d2F4cTVG?=
 =?utf-8?B?aU9ZSTQwVTlNM3E1eVFUdENkR2dyM2hkcGhXdHFPeG9Md2dNZjQ2MUdEOHJt?=
 =?utf-8?B?bDU0ejgraFd5ejlKaS8wNSs3a0Q1TFA1RnFLRk1Cb2ZvT3M1VWtsTm45OHRy?=
 =?utf-8?Q?svY35yI3vFiH2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0dtcFNkWjNQcEN2cjMyUnZiOVRTMlpxeFFZazlWQU95TWJLV0FtT3RTMjhN?=
 =?utf-8?B?VWl3NTI3ckY3aGRKUk8rSnRabGtEVktCOHNWSGx2U1A0c1dqajZRM0dzM1FF?=
 =?utf-8?B?QzlZcjlTajV4cWhlZkcxWXV4WVRrY1ErTVZYYU8wbGR4UUNqb2JzbHlMbm0y?=
 =?utf-8?B?aUhKc3BFYXd2M01DM0EvU3BuaTg3anMxZXpHMUFOKzNFeXFFMnNFVEpGNVE5?=
 =?utf-8?B?ZXB5RmVaOXZ5ZjA3Y1htNVFjbVlKWlIxUjRGNFdxSTBmTXNsQVloMW9nWGtO?=
 =?utf-8?B?djlHR1haNHNicnJBL1BtTFhCbVhPbGpXcE5pNDhVWFJPakZLYVpKTUViVmR1?=
 =?utf-8?B?b0JxWVdwNURDT2s5T3JhUzJYL1dSelpKYTNhY0NxSWdGY0Y1TitsaE1lS3lt?=
 =?utf-8?B?c1lIc2dQb1hpYVNKNkFwSWwrcmYrVytUQ0syNkg0QW1QVDJ4cXNMSDdVc1FR?=
 =?utf-8?B?NmJnQTRmTDd6N3YvOWNsQXhWS3RxSm1GdHVrZ3JvdXhOT3ZWdjl2QjlTQ0d4?=
 =?utf-8?B?TDdpcDByUVFWTGdUWm9wWlFtbWdraVNrdENrSUhGQlkzZUJXRVk3NHEyOUs1?=
 =?utf-8?B?ZWt5SmhHamF1NVpqQk1RMTVqOWFxTFR0L0ZUTVdmVVZqemkrSFhRQUhUVEFp?=
 =?utf-8?B?b0pmcW4vUGtUbERwRlA2Wmh6bFZYdGxHN0FYZXIrdE1iQXNBdHJZY3h5Qnkv?=
 =?utf-8?B?MTVJclZXWEZLU29IV3NOUGx2STJEcjBCRU4rSmlpai9obFR6ZFBBRWYyVTVa?=
 =?utf-8?B?ajZwandnWnpBMDlZS0pmazJ4U3pYTU5BN3EwOHZLU0pRQUdVQVJYbTFZdXY3?=
 =?utf-8?B?V3VMaGxkOVFPd1EzblNRR0FVRnZJT0dJVHYvVWpmQ1hUUEhucG9BMjc4c3ZB?=
 =?utf-8?B?WlFMSVcwVWVIeFJNbkZVUW16dExtWUdsMXI5S081UjFIbnliTGthcXpFMVVH?=
 =?utf-8?B?aU5LNUt3dnlnNUI4ckFoUHF6cWxMZ2Q1NTJBakNqNDZ6THNjNkRqUmQ5S3Bp?=
 =?utf-8?B?QXh0MFp5cTBCUnZpQ3hEa1ZoSkdUR0V5bFRuZW1MazZoRXdQMmVWWW0yVnYx?=
 =?utf-8?B?a1VuOGNSZUJsaHVLTjk1dWdQR2dTbHI5UGlJVnZkS0VmQjlwUy9kTHczV09N?=
 =?utf-8?B?VVZmNGFkRlQxbnRmWE9DY0hFYlVPK0F2dUNTOTBubXNHOEFyRzNvYmVPdHBi?=
 =?utf-8?B?ak9jOW43V1BDOVRKWTVya2xJR2VZd0JtNWJ6N1hLOEJHTG9rb1hlZ01XZkNt?=
 =?utf-8?B?NmxlTko0d0pQNnlGN0p0UkN0MWhBRkZ6NEtIcjhNWHIzWk40N2ltVlNDTGls?=
 =?utf-8?B?VWhuSkd6TS9oaDFqSkQ3UzhEMldHaExTQ1A2RTNVVnJoNVlaMGQ3R3dmZlpz?=
 =?utf-8?B?dEt5cTcyUVZMSVkxN2FvdUkwU2ViMDAwZjZ4cmNGK2pvZXV5K0luVm8vczVo?=
 =?utf-8?B?MlJvSC9vMlNxRXdldkdhVExqQldDQi9LdUh0aW9SREJTdlN5L0YvaHlvMGt1?=
 =?utf-8?B?dnhxSmpxUi91MjRoQkdUTzhibDBVSGVYdE1vRlJMNjBRM3hEUnhsTDVBV3Y2?=
 =?utf-8?B?WDVJd1NnOXdTZnV1SmpXU3Y0Q3pKSHZaSW03cFdLMHdHVERYZWNwb05DWW5q?=
 =?utf-8?B?MzZpYS9kVUplUGx1Qk9yTkVCN0dLQ2Q0LzA3cTZsVklqbUExdnlXYU1JL0dU?=
 =?utf-8?B?TFFkbGpwQU8xOFdzbGl0S2habkI3cEVrSzRjbDJFRmszWnJJNFJubjVLaE0w?=
 =?utf-8?B?MVcrdm5CQ3EyKytPcncwc1pvZmZySE50SUgrWjlVUFltQjFyTXNhQWY3aEQw?=
 =?utf-8?B?VkQ1S2JmSHdhS2Y5TWZZQ3hVbHVGbU9udkVBb091Z3oxalFOeWFhcEpndHVa?=
 =?utf-8?B?bDllaGZiajhnV29MQ3l5alhIOEdDeGlRYjJOajc5Y2ovK3JXclpDQkJLb0Uz?=
 =?utf-8?B?VVdXWERIa2tHU1ArSWJ6OTk1WWE5eUxKc3EvejkrQUYvYUZuOEhhRVhHeDlq?=
 =?utf-8?B?ald4WGMrV0EyOG11cHlIaUUvYnRJSE90dDVIbjJyV0RZSWMxWnpmMXdpOTVL?=
 =?utf-8?B?ZjBid2hQcHZZRUVJdzYrdkthZ00vRGpKam41VDgvMG82T2l3VjlqWVdpd2F3?=
 =?utf-8?Q?FAwI1fCucwQRcORO42O2ksM7E?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02cfdc37-de5c-4c63-6be3-08dcff4dffbc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 17:02:45.1790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hd/WLo2861KwdJUuvgK3RVtuQ0LvKGwexB/2bw3xkLyjHnZiK9wsoi3CBSjexTNx+86Spxrj1S6MjbXxtIIhHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10327

On Tue, Oct 29, 2024 at 12:36:33PM -0400, Frank Li wrote:

Mani:
	Do you have chance to check dwc and imx6 pci part? I combine EP and
RC thread to one.

Frank

> == RC side:
>
>             ┌─────────┐                    ┌────────────┐
>  ┌─────┐    │         │ IA: 0x8ff8_0000    │            │
>  │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
>  └─────┘    │   │     │ IA: 0x8ff0_0000 │  │            │
>   CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
> 0x7ff8_0000─┼───┘  │  │             │   │  │            │
>             │      │  │             │   │  │            │   PCI Addr
> 0x7ff0_0000─┼──────┘  │             │   └──► IOSpace   ─┼────────────►
>             │         │             │      │            │    0
> 0x7000_0000─┼────────►├─────────┐   │      │            │
>             └─────────┘         │   └──────► CfgSpace  ─┼────────────►
>              BUS Fabric         │          │            │    0
>                                 │          │            │
>                                 └──────────► MemSpace  ─┼────────────►
>                         IA: 0x8000_0000    │            │  0x8000_0000
>                                            └────────────┘
>
> Current dwc implimemnt, pci_fixup_addr() call back is needed when bus
> fabric convert cpu address before send to PCIe controller.
>
>     bus@5f000000 {
>             compatible = "simple-bus";
>             #address-cells = <1>;
>             #size-cells = <1>;
>             ranges = <0x80000000 0x0 0x70000000 0x10000000>;
>
>             pcie@5f010000 {
>                     compatible = "fsl,imx8q-pcie";
>                     reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
>                     reg-names = "dbi", "config";
>                     #address-cells = <3>;
>                     #size-cells = <2>;
>                     device_type = "pci";
>                     bus-range = <0x00 0xff>;
>                     ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
>                              <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
>             ...
>             };
>     };
>
> Device tree already can descript all address translate. Some hardware
> driver implement fixup function by mask some bits of cpu address. Last
> pci-imx6.c are little bit better by fetch memory resource's offset to do
> fixup.
>
> static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
> {
> 	...
> 	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> 	return cpu_addr - entry->offset;
> }
>
> But it is not good by using IORESOURCE_MEM to fix up io/cfg address map
> although address translate is the same as IORESOURCE_MEM.
>
> This patches to fetch untranslate range information for PCIe controller
> (pcie@5f010000: ranges). So current config ATU without cpu_fixup_addr().
>
> == EP side:
>
>                    Endpoint
>   ┌───────────────────────────────────────────────┐
>   │                             pcie-ep@5f010000  │
>   │                             ┌────────────────┐│
>   │                             │   Endpoint     ││
>   │                             │   PCIe         ││
>   │                             │   Controller   ││
>   │           bus@5f000000      │                ││
>   │           ┌──────────┐      │                ││
>   │           │          │ Outbound Transfer     ││
>   │┌─────┐    │  Bus     ┼─────►│ ATU  ──────────┬┬─────►
>   ││     │    │  Fabric  │Bus   │                ││PCI Addr
>   ││ CPU ├───►│          │Addr  │                ││0xA000_0000
>   ││     │CPU │          │0x8000_0000            ││
>   │└─────┘Addr└──────────┘      │                ││
>   │       0x7000_0000           └────────────────┘│
>   └───────────────────────────────────────────────┘
>
> bus@5f000000 {
>         compatible = "simple-bus";
>         ranges = <0x80000000 0x0 0x70000000 0x10000000>;
>
>         pcie-ep@5f010000 {
>                 reg = <0x5f010000 0x00010000>,
>                       <0x80000000 0x10000000>;
>                 reg-names = "dbi", "addr_space";
>                 ...                ^^^^
>         };
>         ...
> };
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
> the device tree provides this information.
>
> The both pave the road to eliminate ugle cpu_fixup_addr() callback function.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v7:
> - fix
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410291546.kvgEWJv7-lkp@intel.com/
> - Link to v6: https://lore.kernel.org/r/20241028-pci_fixup_addr-v6-0-ebebcd8fd4ff@nxp.com
>
> Changes in v6:
> - merge RC and EP to one thread!
> - Link to v5: https://lore.kernel.org/r/20241015-pci_fixup_addr-v5-0-ced556c85270@nxp.com
>
> Changes in v5:
> - update address order in diagram patches.
> - remove confused 0x5f00_0000 range
> - update patch1's commit message.
> - Link to v4: https://lore.kernel.org/r/20241008-pci_fixup_addr-v4-0-25e5200657bc@nxp.com
>
> Changes in v4:
> - Improve commit message by add driver source code path.
> - Link to v3: https://lore.kernel.org/r/20240930-pci_fixup_addr-v3-0-80ee70352fc7@nxp.com
>
> Changes in v3:
> - see each patch
> - Link to v2: https://lore.kernel.org/r/20240926-pci_fixup_addr-v2-0-e4524541edf4@nxp.com
>
> Changes in v2:
> - see each patch
> - Link to v1: https://lore.kernel.org/r/20240924-pci_fixup_addr-v1-0-57d14a91ec4f@nxp.com
>
> ---
> Frank Li (7):
>       of: address: Add parent_bus_addr to struct of_pci_range
>       PCI: dwc: Using parent_bus_addr in of_range to eliminate cpu_addr_fixup()
>       PCI: dwc: ep: Add bus_addr_base for outbound window
>       PCI: imx6: Remove cpu_addr_fixup()
>       dt-bindings: PCI: fsl,imx6q-pcie-ep: Add compatible string fsl,imx8q-pcie-ep
>       PCI: imx6: Pass correct sub mode when calling phy_set_mode_ext()
>       PCI: imx6: Add i.MX8Q PCIe Endpoint (EP) support
>
>  .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml | 38 ++++++++++++++-
>  drivers/of/address.c                               |  2 +
>  drivers/pci/controller/dwc/pci-imx6.c              | 46 +++++++++---------
>  drivers/pci/controller/dwc/pcie-designware-ep.c    | 21 ++++++++-
>  drivers/pci/controller/dwc/pcie-designware-host.c  | 55 +++++++++++++++++++++-
>  drivers/pci/controller/dwc/pcie-designware.h       |  9 ++++
>  include/linux/of_address.h                         |  1 +
>  7 files changed, 148 insertions(+), 24 deletions(-)
> ---
> base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
> change-id: 20240924-pci_fixup_addr-a8568f9bbb34
>
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>
>

