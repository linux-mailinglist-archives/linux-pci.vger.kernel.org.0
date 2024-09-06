Return-Path: <linux-pci+bounces-12885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117B696EBBB
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 09:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41786B227EA
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 07:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4103714A4D1;
	Fri,  6 Sep 2024 07:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="p+9tFr+C"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2049.outbound.protection.outlook.com [40.107.103.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F79217736;
	Fri,  6 Sep 2024 07:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725606806; cv=fail; b=bdJdpGRyXBCfXCWJKRB4Gffu+Fgp+MsyTZwUOAWCCWmB6b3476Ip1RMrVIFIcbXuM8TttDLG5o65IbXUtUCQbRKkuIBxjoGJox15Am86c3EXtbbpN4PONmgqvekmBN/Nru5/yDqUveqvO6sHFVg4GCrS/Ayn9j+3RJN5EgFdCYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725606806; c=relaxed/simple;
	bh=S3kv1bT/rKGXHq44Z6+TVeSxxuyUNNDaSuEbOw3cbcc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JhlEqaKSkHxyTD1SW89rM4BTTVp12RIxMnVutFkrU1GaenhN0F76VjlbQfL4M/FcWlFgopke7ef0jFbCvAf3kHWwq/Rpbt7kvZzOgnKlIaBO8m9n9ygJtZnuufJ12Muf8fJgIi56Du4RRVJjfOV1IDNuibZx34ZCrGjhAXJURD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=p+9tFr+C; arc=fail smtp.client-ip=40.107.103.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCxSWGjAPcj3LU/sRQZ6fBAvTtqsjsfgW3DScLs3HEVIvOno+U/xClBMSKlz3FQ4Mq8FtaxU+qSoi5yS6OwMJroTEMKE66XUR15HXfTwFgX945/ZzDr3wMdmFBFNkUsrbuaa+2Yf5HZLxk2SHfGhpI6XOdosJgyKZQUY8PxIyESguaUrpaV6lyZldDfcZppcTL7cvsftXHuzZnn2/awZIBnyaFmVdAS6SDaZxBC360H97p3PJftIEcnkh64LxLv0TIiHgrjc2uvXZnHBRrv9rJuK/+xu7op0BqhYivrzbBLOyrPgSKAgONTM00GC3tLZIXvVKzOs6hQtXeLLnjKY/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzAwOyPxaC72XldPGcn+qP9jkXtYPm8kQQl6uNM+d4c=;
 b=xYUeiKMHfCg/uCczUsgYrpSI3mOE1F//MW49Skle6rqSST7gCksluCGyGCWtO/MrTNnfOXqB7FgeKfChohCm3wf5dY3sfAFR9DXq5aBWXybHD7NC5Fh9mJwiWqSinJZgRmZWDkjp5/kW8NwiqLInxXv4IKrH6wxkD9GZrxDLTPyqpUSqw5Kcz5Q5SJKWq1rzBEfimsoPqJgYKk7gMP0Ewnj3oat6T6nRJbnIE31gNWQYru44jpNmeaCWIROvfpH9SzHa1d3NQO/SsJoiOkth9sLBIrro7nb5gY+76K2yd9RPxnaVR8CiUwoEJ2DEepCO6VsDyn+mdzIPDJfYKs4DLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzAwOyPxaC72XldPGcn+qP9jkXtYPm8kQQl6uNM+d4c=;
 b=p+9tFr+Ct9DQez1HyQTWBRMeUzqiYzgmmjcPJMyI1riMRjKKTcIzb/kUyugT9A3iezB2Y/y3N2Qq1RRoITltDNGly7oyyY3MxD/nq/Ztj25DjwrH/UtbYN+SIpvM1+IgxUqOyItgsZ6VE8ypURH9xfwYXJufwDrzD3CUR0SVZcD3kCi9QO4pbu/otqhscQCx9keh8ThVRoltrT/HiELd8Dzwdg/hhHo25ZRio5kTRSntbzi7KlfiltIaJa0mVicZDIHptk/0agc6/JZT4PVANJLmxxUcj5WHmsbIWjXXYqQ5EqRzVMvPZSoxmPeqqi4S+gHZfOyVdUoUIBgO39Q7DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6684.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:86::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Fri, 6 Sep
 2024 07:13:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 07:13:20 +0000
Message-ID: <d35f94d3-6231-4c19-8795-8807d361d04a@siemens.com>
Date: Fri, 6 Sep 2024 09:13:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] dt-bindings: PCI: ti,am65: Extend for use with PVU
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Bao Cheng Su <baocheng.su@siemens.com>, Hua Qian Li
 <huaqian.li@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <cover.1725444016.git.jan.kiszka@siemens.com>
 <28d31a14fe9cc1867f023ebaddd6074459d15e40.1725444016.git.jan.kiszka@siemens.com>
 <acd72984-4c04-40f1-9e0e-f84f6c566b37@kernel.org>
 <3b8ff45e-28d8-4180-a46d-f507fa0bb65c@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <3b8ff45e-28d8-4180-a46d-f507fa0bb65c@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: 42cd9c57-4430-4075-2484-08dcce436324
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3JNaUN3dmRDU3Z5MHZUc0o1aVBoTGVnUUt6akNJS2dtbjVuRlduTnlZVnd3?=
 =?utf-8?B?NlQ3OFFueEtGVjFUaUtldjk3dkJnMFZuSWpnemp0NU5hcFBtbUVpaWNvUklj?=
 =?utf-8?B?NHY2TjFQZmN0Q1MzT29UeCs5aFdPRHlzaVkwZlMwQklaU2UyRlQ0Q3VqUVBw?=
 =?utf-8?B?YTVxalhocmVpZ2x6Q2dzaE5NNHhiSEc0bWw2QThkdDBRM1hPOEdraTRLWVpz?=
 =?utf-8?B?aEFRcXVKR2RRa2duUVY1TjdHd0NUWUpobjdFL3UxWXRTUHhEN3MrTWJ0MFl3?=
 =?utf-8?B?V2IrVkxFZHBsZEJvemF2WWNlOUhDKy84cnBNVmNRT1V3RnJJaHBxR1EvUGE2?=
 =?utf-8?B?OHhHTUc3dEhDZGsxampWQUZxbWdPeENCUkxvM0JQY0FhTGN1R09HKzFnNmIz?=
 =?utf-8?B?a0NkWUxoMVJZYkFqbVk5ZTBZL0IyNGVTcW9NMi92dEpFLzArUWY5cUU4Rm1o?=
 =?utf-8?B?R2l4Y1h3RWRMRmg0S3BjM1FmRHZTOVB6Z2RMeWxyY2VOeUtLdWRUUHJ4cWlK?=
 =?utf-8?B?MXpKdW1NbS9ZRENxQTNzSDR1bEpFeXdpOEZiQ1lCWFRnbUVNRzh0S3FBZTB2?=
 =?utf-8?B?bXRxTlpvUVgxUUpFRzVadjNKY0pxeHc2MUN0ZnVRMGxlTmFGV3NMdmdrcDlD?=
 =?utf-8?B?VXQ2NndOdXhoRHh2YmgzK1BWakRmSmdwdGJQaFlPRTNpWXg3bE9OSkhNQWFY?=
 =?utf-8?B?SGtmKzBCbVhrdVRiNUZjanFTUDYxNVROekY2MEF1eEs1cVBxUEtLenI0M3FU?=
 =?utf-8?B?VHAraW9FSDFMcVdzdFdrT1dqSlZyV2phamZSMVFqcGsxSUlpYzdkdXJicGJZ?=
 =?utf-8?B?dWRQTEl3UHNvZmhISDdZV25SeGZyamdUTW1sdEkzaWJRZ3ZQWEErY0NPWGZK?=
 =?utf-8?B?bkNvVHN2b09iNkNyM0h2NVRUNlRBN1J1Z2c2UDJZdy85VklYMkVrU0ppRW8v?=
 =?utf-8?B?TEpUbm93LzJkNS9qUW51WFQ3aDkreGt0R09zR1VkSzdjZmZNMm1aWnVqczVB?=
 =?utf-8?B?TjFQTjd6QkJ3MFlhdHdTN2FyeWtJanpHOThoV0VYUGFKTFFNK3JBZ1ovVW9I?=
 =?utf-8?B?ZXRCQUhYUDVraGRUSW9qcEg5VEY4amhOQVV0R3N1UTliR3VnSnU2UjU4by9S?=
 =?utf-8?B?QUlORlJBeUo5anF6Y285elM4N2tMVWx6NExFTi9iTVhnU0l1U1RqZ3dsK2h3?=
 =?utf-8?B?UG5uUHpxZ0dyemFPcHVra2VQYWxSWGtnVUdvallXMFhuT3JJZU1kNkxqdnJW?=
 =?utf-8?B?eUt5anlDazhRbFMxQkEycHkxcjVmby92YWl2RUpaVkU1ZGNRQ2l0Z3FZOWJW?=
 =?utf-8?B?WkFPS2MrOUVJUGdMM09rSG8xSWpBc2ZRRW05YU1xZzVNOUVRb0NFeTR5bWwz?=
 =?utf-8?B?RzM5dHM1M1h5UUNYTnpzbFVWT3FpQ0Q3akE2NTdGaE5ERG5jbm1mWmFxVDh4?=
 =?utf-8?B?R29yZEgrNjVBemtCUDNxWkdZMzdSRXcvd2FOZ0Y2dy9UdkUxbVFxMFMxQjkz?=
 =?utf-8?B?eU9aYzErSHVzY3FKcGZ2YW1UdHhra09lclgzTTJOZVBOdDlUWmFmZGZlTFM0?=
 =?utf-8?B?WS9CSXFuNlFFU2xtY215T1VVQTVETE5oZVlnb2xGcDB4aDhPYTdrOTVEM0Nn?=
 =?utf-8?B?eUNCbmdtUG9nZEhPL1d5ZW9uWExFWVFMYzJWdFdlUEU5OGVjendGZldURGZS?=
 =?utf-8?B?Z1MvTEs4VEsyNFAwa1hkZ24wK1VVVUpIb1V2OS9TVUsyOVBuZ0ZQbDNONk1W?=
 =?utf-8?B?UFJLcnMzMlB3cTkrVWN4TlkwaUx6MHFZTUtHMyszKys2QXBWVWRGc1JQeE9L?=
 =?utf-8?B?d3NkYVpLcDFGemVtbkZzcTN0MmhkL0plOEpIZ0tkdjVrUEZ4UFJ4RlNmbGpq?=
 =?utf-8?Q?L0uqtKpw35nOG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTJoRWQ4V20vVlVhWWdrd2pLbHNTLzRUeUptelJoM0JFaGZXTnFqcTIzL003?=
 =?utf-8?B?MzNod25nVE1XMDJWK1NDbWdXQUFUMDhqeENXS2lXektqK3RPRHYxWDhFTVFQ?=
 =?utf-8?B?Zzh6Q3hReU53QjlvWW0zT2ZKZjluUE9Ud2MvdmhTOXY1UHZYWFJSeU1pRjB3?=
 =?utf-8?B?byt1NmlVeDJ2cDJPd1VJdkwzbC82MTIxc1Y0eHZiRmVwckMxczdVdWI2eGlN?=
 =?utf-8?B?ckJZS25vVmU5cCs3UWRxelMzMlFlRkZXSTA3VzdhNXJRc2E5ak9GRGE4THFq?=
 =?utf-8?B?WEJiam1hU0VKOW5zOUNtUFgzb3VENlVoUTlER0dCcmVVK21IT1N4bE56ZkZF?=
 =?utf-8?B?SE1WenZvM1BLaURqU1h5VzZCR1dyN1B0RTVCS1BBTmJOcmw4RU1PaTRLSXpO?=
 =?utf-8?B?aUhVeUxqVTNWdWRTNDdWdEtZaUROOEVyR3orbk1nWmdhOWVBemM3L0E5T1VS?=
 =?utf-8?B?dndPaVJaYkNUOFJJVmFnNllvdXdvVHk3bjlId3NhUHlwb3NLZ0cvSWJDclA1?=
 =?utf-8?B?UGhWL3lCRU5aL3FYVDFBS3FrNTdGNUtqZ2NPd28zSUNlMzN3V2FObDNiQUxY?=
 =?utf-8?B?cXlQSkhZNWpmeWs2SHE2TUREbXpLWWRsZGltZnZkWkZYSERtNFpyZGd0TGhX?=
 =?utf-8?B?U0ZLSkNFRC9MdEo3ZjFHZkJPSnR6M2pUMTlqOVlWUktZaStsVTdsMjNuc1RB?=
 =?utf-8?B?OWI0cU1lSzVIR3dLcXQ5QWpxQ3dGZytyVFFtUVk1UEtoR2RqSTN3UmxnNFRW?=
 =?utf-8?B?QUkxdHAyeUN4WTNnUklaYmw0R25rTFJERE1TRlRWSXpscDdPU2QwRWxnYUt1?=
 =?utf-8?B?ZHNuQm9qWllGenN0bXp5QzV6aE5YMEkySnUvc2VHdldDTGtMQ2o5bnFZRWMw?=
 =?utf-8?B?QzJRNVVzcVZmb1ZuRytMYjVLU0F3OEorTWY4aFRHYUJXU2swVzR2ZWJ4OU5T?=
 =?utf-8?B?dlEvRm5kMjg3QmVZSXhjV0t4dDNIWVZZQTd6Lzd3Zm9WUGZJd2hoYTJRSzVt?=
 =?utf-8?B?S1lkb3B3T2RzTElDaUpDOW5EY1p4L2pUaXF1TFhBYS93OEFWRmFTa1AwbjM5?=
 =?utf-8?B?VFlsS3l0SU9RMU1Xd0h3ZU9wY2pnZlE0TDVrZWNSaEd5L2c0bm9qZHgwdm5n?=
 =?utf-8?B?bjB3NkY2TEFmUy93UXp4bFpWZU00K2I2MWRrZjFJQllXcjdGTm0vM0hKMWZE?=
 =?utf-8?B?M2hqNE1vb0JCWnBFeHpqUGo0ZWF6VE5TaUtITmgxM3NMYjR1Tlp2aVMwZG4r?=
 =?utf-8?B?SDdnQXlGQWMyTFhKQ1p6bVVQMCtiWkwvazZaTFhTL2ZmNEhiNThseEFveDdY?=
 =?utf-8?B?OVBzM3FsQVNMM0ZYbk00dzlES0JsY0ZTNFMvVWdaVWhRcC9TYkVoQlovWEVT?=
 =?utf-8?B?ait6bXBrNjFWYlJKL1JZYkNEdGhzOWorakllQU83M3N6WkxNYk1MVjFTNmV3?=
 =?utf-8?B?REJwWmFtVUY5WmRPVW5hd204bnREMmdNWlR3ZGdZRE9YY2tjaEpyNW8wWW16?=
 =?utf-8?B?cjN3cXdOajRYTWowZUZXeFp5R3RPRnBrM0lDSll5OThQT0ZOMi9zR0hzUmtS?=
 =?utf-8?B?ZTRxTEM1L3BNcmwxQ1lLUHNUdXdPUitvRTUweGJVcWpycG1yZDY2cE9QdmVC?=
 =?utf-8?B?VmswbkNCN0FGUTJtYk54c2VPQkRQWVZ1c2c4YkFkUDBNR2d0cW9LYlR2THRI?=
 =?utf-8?B?bVRyb2tmbXNzZlgydE15dDg1c2VVamh5RzNBa0NQQ1gxR2VremlPZGVzeDF0?=
 =?utf-8?B?aEFTaTYrK3NuRjZJaURIUUJkbXFmaUh2ZTFqdWVlQlVjT3pETGs3SFA4azF2?=
 =?utf-8?B?ekkxS3FUd3QvUUJGbnVBTXNPMElEeUtKUFI2dWtQdDcySVBQK09MRXJOZ2Na?=
 =?utf-8?B?S3RuOW5NVmxHSnB4STNMSkdMamFuZGgrUHJQV3VGZzJ0ZXpIaEZDUjdQS3dl?=
 =?utf-8?B?TVVjVUdXZU5Lak8vMG5oYjZDZnRibFZLRXA5RWZDbkNlamg2akxXQlIyeE90?=
 =?utf-8?B?NHZoZjNzdXU1MEpCdmtBMXZqSExBQmZzMUJucjRyOTN1OGZjdU1jVTcyTzF2?=
 =?utf-8?B?YmpGVEZoRUdvL1ZNOTczWHFNQjAzSERYYTNyWlZZUXhPM0h1VFUvb2dNNlA4?=
 =?utf-8?Q?pTmFHsxzR+q5A6gyYKOSL+96e?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42cd9c57-4430-4075-2484-08dcce436324
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 07:13:20.2333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+VpyMQdXLYiOjRCr8njPeWSPhHbA0/Nm5Uh2rJlwujKhp+MnMImoVPVRPZFBltomp6W+gUMC0w5rS75CIGq3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6684

On 05.09.24 09:16, Jan Kiszka wrote:
> On 05.09.24 08:57, Krzysztof Kozlowski wrote:
>> On 04/09/2024 12:00, Jan Kiszka wrote:
>>> +
>>> +    reg-names:
>>> +      minItems: 4
>>> +      items:
>>> +        - const: app
>>> +        - const: dbics
>>> +        - const: config
>>> +        - const: atu
>>> +        - const: vmap_lp
>>> +        - const: vmap_hp
>>> +
>>> +    memory-region:
>>
>> This also did not improve. You did not address any feedback from v3.
>>
>> Missed feedback:
>>
>> This *must* be defined in top-level.
> 
> Answered in the other reply.
> 
>> I still think this must have some sort of maxItems. I accept your
>> explanation that you could have multiple memory pools, but I don't think
>> 2147000 pools is possible. Make it 4, 8 or 32.
> 
> Can do - if you can explain the benefit of that.
> 

It turned out during further investigations that swiotlb actually only
allows a single restricted DMA pool per device. So this discussion
auto-resolves, bindings and code will be adjusted in v5.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


