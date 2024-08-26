Return-Path: <linux-pci+bounces-12214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999DA95F9A6
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 21:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB191C21D71
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 19:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A991991CA;
	Mon, 26 Aug 2024 19:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="JSkos3LD"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2078.outbound.protection.outlook.com [40.107.104.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C365644E;
	Mon, 26 Aug 2024 19:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724700334; cv=fail; b=YQ5VtttLmjnBtphL5pLXMqeRP7vMJAz+skn2v2NcUrAz11l81omLfhRy63uu8kWfbrgcqj+zq7ereDFpWB+cWiJjggoZa2ke++2bDGFfxViYlY8WiwIVXTONrWf8Gaq4wSCqJ/wakmEBn1VhlT8mjq7YkLnLXyu+jtrg+RaHK/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724700334; c=relaxed/simple;
	bh=2IelCbtkzkK2bRRIqoltFhL27jmIdMz0IxEFPwNoQcg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t8WYFaFXjL5RkRR4wnlRGRsj4Klq4xvekkSb0cLSx6R7RW3q2cGM3SP0CIoOLylhGWz3+T3n1QsgjT0kn8D8I8UAkvNOMQ9zWnfep3JQhlOhDCp+Hiw4Yv49AkckU3PVZc10iTgwKoyfXq+ZJE9lksV5Iq/7XvA5sd/IXNg6448=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=JSkos3LD; arc=fail smtp.client-ip=40.107.104.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiyhFojwLvURS+PE0+I2fwwYQmw/VjIZoRdJElQWq1KjtUfhf4UHDIJ/HZVU9OVsNACpcRWjZ6SyRJA4Xsnh5odiYMn+yN0FqBTTIKg5tWu9kk6ngSZ8OoAYef5bGVEcV1RRgnGiP+jE08XznPqkeHhKGxrCA5bpsB5vlo5+PmQ5rvE9pzRWGVj11j1RboE2dc16DV3kWu9DMhmSkcQ/Y4+6BrBN+1VPIG2i7+t3PNRfme3HXUq1sBCDgrBjy1VUsqoKef4kADFiPEzZHawHlx/hyNFzZbxNF00pOKA9vZkRit1Sq8hSmtsuhJk7+peM6oqkXrEqzMw4a5+9yh+K/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4ZIMkrgrsknLBJOamFbicPEAq8j9DkBpeMQTGgKsTw=;
 b=Wp37kTTx6NPUjERdq9YTgIPhhrlBhMOULh052YY39/2QcvdXx9g3DKLELmOFx+QvF7/16HmVKPhx8orZ7jF0zZScAOyngZovUl8OXdVPXVEZ9c16w9AkcCzjWGy1487w0PbvCf5k2gTLEepy2UJYvRB1MpI30Nqr5W2Yu4dmBqvXtneWkZJVCtruY3D1o2uioXKRcmm8ou5wArc0cBKa3SLfTjNXRFw/dMKB/c20I2DcmEYNYTWvKzpIAY+vkbqDvxXwOQfGIfZTMWmAzvuwzmQhB/vqiAsevy+SA88/O8ORdmOR/Y16qWqFe82EXMNHXpPxbi23L4ZQOVDsb+IIoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4ZIMkrgrsknLBJOamFbicPEAq8j9DkBpeMQTGgKsTw=;
 b=JSkos3LDsaNGyYW/qtXt2QchqYZRlTVz+7CP2jVv75OEDaq8UaWX/X8LYRvRPI0P25C3kPkyHO8BPlFc4K/P9LGd6+rSiVIumlgZPiI0nRbZLI0R61f3QfCLUDu/NaWHzpEBBATB9TGkY+VcCyzkafH9FI5ea/epa7a8N1L2SYqu4Z5C4oQqo9zeBbwP928igZOg+COYsjylXCVgvZUnF/8DxCD/bQQBJbhUFSVJCwP+zHYGxnDXBDqwWlV6ewMTUr8oDQjjrvs1Q1RH8Xev6xqYEwFD2FQb4X/+DbSMIBciHoigoNP8EOKni52t+p6J4jSgVOiJgZWWshEUqewitA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB9175.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:416::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 19:25:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 19:25:27 +0000
Message-ID: <3dcaee19-3671-4658-a2e7-247e42b85805@siemens.com>
Date: Mon, 26 Aug 2024 21:25:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] soc: ti: Add and use PVU on K3-AM65 for DMA isolation
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Bao Cheng Su <baocheng.su@siemens.com>, Hua Qian Li
 <huaqian.li@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, linux-pci@vger.kernel.org,
 Lorenzo Pieralisi <lpieralisi@kernel.org>
References: <cover.1724694969.git.jan.kiszka@siemens.com>
 <93da058b-8d72-4f76-9ee7-f6837a1a4a9a@linaro.org>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <93da058b-8d72-4f76-9ee7-f6837a1a4a9a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f52fa86-2839-4984-d086-08dcc604d748
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3hhdjJkaTRXUmRWNUNoT01VRGwwdFoyY2Z1RkpEMjJRVDhJeFhMTHZVZjgz?=
 =?utf-8?B?anpSdVZGOUszVzR0bGJURVFvWjBDNmwvdW9LdkdxRkZXMzN2ZndZR1BrQUgy?=
 =?utf-8?B?ZmlRYVZaTWZNY3c2aUZrZHhzOXZ1Rk5lUkdSV1VNd1A5RjFDYzBwZG82d0lk?=
 =?utf-8?B?c2hjajd5SGNKMFJUSW1hQ3h2ejYyS0l5elhpNjMwamloMWdlaDdKSXlBeWM0?=
 =?utf-8?B?ek9nQmlwdEU4cTZZdDZtcXA4WFh6WXRNUVA0VEI3WDc0TG9Gc2Z1QXVmRmM4?=
 =?utf-8?B?Tk5vSks3T3ZHbFloZUUzS1R4NjhPUmZRUWl0Vml6VEZEU1lrU1B4RkpQK3du?=
 =?utf-8?B?dldNdDJKQzZsMzluVDJ0Y2tUc1l5ME5oK0w2azRmMjk5NE9GR3FoZ1hIRGpq?=
 =?utf-8?B?bkpnUkdWQkNyM3BMQ1ZvS05RRmtEMCtRSUNwVHUxREpEZmxHWFVvdUFUb0F3?=
 =?utf-8?B?ZmFndjZwRFRXNzdIVGw4QzNPRXp2Wml6aUtHMWhJeHhwVWZpWUVSZWR4MG93?=
 =?utf-8?B?cU02MTMvL3dDVE5qRHE0NnFiQTNPanVIS2dLbVcwK3dqNmdHdExLMHlCWWU5?=
 =?utf-8?B?dG9rOW5LdDg3cmViUWlVRUJKOW1GUjRkaEVsK3prY2VyZEx5WGIreFlWMWJw?=
 =?utf-8?B?MHE5QmR3TVhtQ1lZZFZoY1krM2oxN0JEYTdGcVdkaEFONk5kdllRRXJPQU0y?=
 =?utf-8?B?NXVnWkNpS2g0VXNtTkFrZEZWdXdIckFNOFBBNHJIMmw5UkZGOXFKa1BqSXN3?=
 =?utf-8?B?MnNQZU4wY2h4T0UrK25QdlRjbW5LY3JDdjloeVZScHM2ejJIM1BGeStCV3k4?=
 =?utf-8?B?QU80NVk0UU5BOGhhTXBDZktSeEhIT2xpRnJBajVqaityNS9DRFFjWndHWTRP?=
 =?utf-8?B?d3IxaDBFQ2syWE5MUFExVGZXMXZ0eFViSE9TTWhGd0pVazlOVTdHTG1LZmp5?=
 =?utf-8?B?RVVsdmFTUGtwQ1NqaCtRRkhxVjZOYzVOay9oMkF2Qjcra2RISkM3VDRhZmxB?=
 =?utf-8?B?OTNYbGJhRTM0cU95MklibTVKZk03SzU3bTFJTTRaSjRpenlDUFlGUDM3Vnpn?=
 =?utf-8?B?MkNQbzFXZXhJbjIxWHJRVWt2TmcwZWJMSlB2QnFEV1R3OWFkUkJwQkVqTHdu?=
 =?utf-8?B?UVRUSk03dy9ZODhVa1hGODdQM2k5L1RwWUtrb1BXL25FbE81dmlQd1MzYTFr?=
 =?utf-8?B?VElyaFFHdWRHQ0hIcGpYeGY0NGRFTU1wK2VKY0lCQUE0RkdualRHYzA0b1RT?=
 =?utf-8?B?akkxWXowVjZJRkxzY3Joa2d1aS9QdWRNME5WYXRodFRsSmRIMmhIeFQ5Z3ZV?=
 =?utf-8?B?R3dKME5WVjVPTGphZzRwZlBsRVo2b3JPU2RNcExDcVBlRTV3aDM2eDVTc2Yr?=
 =?utf-8?B?OWpNZndWVkxVb0FSWm15Nk5ialNxZHRTRThQb3JQMEVaakh3ZE5ycGdCMWFU?=
 =?utf-8?B?YWhXcEE0V3pPaHl3MUJ3aDdWWUgycGdGL1JqNWxONW11eWNvaXdFZ3FDT2lZ?=
 =?utf-8?B?Tm5jcFo1M0FRNmJSMXhOQm9rQzRKZU1jQVZxYmtmYWFxWDhNeGxYVzZQeFVZ?=
 =?utf-8?B?UktuUG1qdGRiY0hpN1g1NkR6aitPYnZXQVg0NUdlbnNJSUpyeldianNHbXZY?=
 =?utf-8?B?Y015aUgwNlFqMy9TY3pKSWU3SWU0TUZiR3JBSXE2OENQcDhaVjl4ZXRUK3l0?=
 =?utf-8?B?QlFlcS9OaTR2dzRiTEY3akNzTUkxRFk3NU02TEl4blVrVll2TGNsRXNDNnQv?=
 =?utf-8?B?Uk5uSnRIQVNVenVKcThpYVhiZ2tHR01rN3FQNFR1amMxRERkOUpreXREZTFL?=
 =?utf-8?B?VWxyYmhxVUl0SWZhRktYdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmdFSVJqMy96b0lQR3Rwdy8wenFqRkR5OGRscnVKSER6dmtrbUtmMjhJajRQ?=
 =?utf-8?B?L3lUMTRmOTZZeXRSTGMvUGFCc0pkUkVuRDhJN3Bhbkl0aUl6enpCczBOcEE5?=
 =?utf-8?B?SHJobXV4VlZLWUp1b0hyditvY0V4a05PK2JLOHNWRnM3a2J2ZzJtajg0RmEz?=
 =?utf-8?B?WVR5S3pFaGtKcmFVY1gwMmMzeDlxbGFtdzlQK09pRkNLUUpKd1BUQXpzNmhk?=
 =?utf-8?B?R2VuZ3hRQ05VZklzekpjZUNtVTNMK0RuKzVvK2pKcmhUUndxZHRtVmRMekcx?=
 =?utf-8?B?YTRMcitjNTJZeVlPMFF1NDdQZmswVVZMRE8xcFp2ZGhTVlA5N09lTVd6TTBm?=
 =?utf-8?B?UjZLRXdybkVKR3REdWlUVlZOYSswL0FRT1RNNkFMTm9jcU9ZaGpPVVpqM3ZW?=
 =?utf-8?B?WEw1Nkt4VW5tMmRuQnpmNitwdXlLTmVxVFR0VXlxSmhFb1IvQ0gvMisvejVk?=
 =?utf-8?B?SHFhK1U3SHdxUWFyZDlkTW8wSzgwd0k5eFp3bEZ0WDRRdWhFcTF3UWRBeTQ4?=
 =?utf-8?B?MDA3YTBVM3o3a0tCK3RjUTZYVkcrem1lNm5INmFPeWRpWUZSRHlwNk5RR2R4?=
 =?utf-8?B?RnUvVmw2bytWWXJ6bGNheFZENllmMVBKZW40WXlaZ1ltSnpQd1pHdElBdHo3?=
 =?utf-8?B?SUI4UEp2NFVxSUlSUEhEZXI3aHg4RUpKR1FYVzZ1dDc5ZlJCTWNZclVRaVFv?=
 =?utf-8?B?UnhOaHIwSVZpR3d2SlZiUVRRd0lIL2pjYVJsL1RJYXBqRzN2b0JNcjRQaDNP?=
 =?utf-8?B?MUk4d2hWZjVJeWl4UlJ0YyswNEEvOXk3NkZ3Y0ZTQWlBQ2dCNndINFNtR2VM?=
 =?utf-8?B?NllUNmlDdTBGZGl2ZWFmc0x5ZVRsN3NIMVFmQ1ZIT0VrSkx2aitnZUN5dFRp?=
 =?utf-8?B?cXIxOHphRHFETjNxdi9LemtSQUFyVnZ6Szhkay8wdmE2YXRRUHYzS01vMTFl?=
 =?utf-8?B?UW5GSEwvcmkyOHVsdU1wYjQ3ZDYwUzdwbllJQjBpMzl5UW1hVWt6TkZlR2dt?=
 =?utf-8?B?YVVpdUtJWTgvOXlsK3A5TUpMQXBLN0IyRE8rZUpNbXMyNkF6ckRaRnk2Q3ky?=
 =?utf-8?B?bTVpYU5nMjhGMHNRU1lUMXBGSmhpajE2ZEVKb1o2QmpCem9XSmZMeEZkMTVs?=
 =?utf-8?B?UVdDVGRrTkNTZ1IvYnJSeHRPZmhxU0ZxWVZiaURzYklZdit6SmdLQjNZMnBG?=
 =?utf-8?B?blF6R2Rpb3ZvZ2hINGQvRGRiSGg1SXdjZW1IeGhRb2cwOEUrYWMyUWJ3Y1FK?=
 =?utf-8?B?L0tWdEk5Y2phR3h4Y1RtM3pDS21ZUTFRamErRHJRWldJUlJybWlKV09xWC9W?=
 =?utf-8?B?ZkpWaEhMTGdsbE9QRXNvaWUzbHZxWlZpaTVWdVBOSjh4WVFxSDBTQ21LZEZi?=
 =?utf-8?B?d3RzRldNT0p3SE5HdmJzUHdRMkkrSkxwVjNlTjQwRVdOKzZkZmVXRkd3MmRn?=
 =?utf-8?B?anM5ZUUzQmU2MHNPaU1uamlDZGN1WXU4UmRZYmVGUUM2Vy9DU28vTTI5UVR4?=
 =?utf-8?B?NHl4aGFvVENMR3ZUVDM3ZXJYZC9tNVpOL3FqcFdGeFZGL3FnL01KbEpmYU9N?=
 =?utf-8?B?RkI0MWNTRFc3TjllMmRFeEtCenVkVU5nSSt0MzVndlhObmpMTk52QzFBRXFu?=
 =?utf-8?B?QnZGSmZLUHlXeG1RWDJLck53SHk2cjg1TXFSZExTRXVubC95VnNvR3dpZld6?=
 =?utf-8?B?N2t3M29kQlJZelZUQ2JLSlVPNW5jaGtIcDJVVlJZRGQ4N29nNWJtbEF1ZUFR?=
 =?utf-8?B?bnhFTXNVSU12ODlYMDlLdklJWDdad1BlMFpYUlZNOWV5bmNhQ0xOOGg4cDZB?=
 =?utf-8?B?RkJ6KzhuOWNNMFJFWlhLVWVKNTVtS0dqMWFpYWlvY3RiQXNWM01meGN4S2Z3?=
 =?utf-8?B?djl0UEh2a2pObHROTUVNa0lkRUs2dWN3MHhCd2grSFZrM1UybktyYzFqTk14?=
 =?utf-8?B?eThRTEZOUS93UnJuTDR0T2NBS0pKUTZaZFVkUms5ZFpXYS96cTkzTHRPNHl4?=
 =?utf-8?B?N2pmbGVZUWVwVVNQTlozSVUzWk1TSngyRllwL0NsZmZxMkdwaXY3TTdLOVht?=
 =?utf-8?B?UGIrV0FVb0hjV3NPeFdra2syaVR0QnJXNCtLMy83elF5ZnhhKzZubG9vN1FE?=
 =?utf-8?B?emxMOS94Wnd6akMrbHFjLzI0eHk2Z1A2MkNrTkhmSk5DeFMvYmhWTyttSXR6?=
 =?utf-8?B?U1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f52fa86-2839-4984-d086-08dcc604d748
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 19:25:27.4932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2asgzXhP+X2EABiY49gu3oJsbBJxh+scLcAj76lRFLnWMMj5ly9cbwjsqdfYS6pXhv/Bsjp+g7w4c2XCalDKzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9175

On 26.08.24 20:53, Krzysztof Kozlowski wrote:
> On 26/08/2024 19:56, Jan Kiszka wrote:
>> Only few of the K3 SoCs have an IOMMU and, thus, can isolate the system
>> against DMA-based attacks of external PCI devices. The AM65 is without
>> an IOMMU, but it comes with something close to it: the Peripheral
>> Virtualization Unit (PVU).
>>
>> The PVU was originally designed to establish static compartments via a
>> hypervisor, isolate those DMA-wise against each other and the host and
>> even allow remapping of guest-physical addresses. But it only provides
>> a static translation region, not page-granular mappings. Thus, it cannot
>> be handled transparently like an IOMMU.
> 
> You keep developing on some old kernel. I noticed it on few patchsets
> last days. Please work on mainline.
> 

How did you come to this conclusion? This patch set was written for
mainline, just rebased and tested again over next-20240826 before
sending today.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


