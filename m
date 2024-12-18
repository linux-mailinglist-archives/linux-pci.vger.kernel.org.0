Return-Path: <linux-pci+bounces-18732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA019F7086
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 00:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C32116BC5D
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 23:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A931FDE31;
	Wed, 18 Dec 2024 23:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hVJnwl2z"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5157E1FDE26;
	Wed, 18 Dec 2024 23:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734563365; cv=fail; b=GUT1dTHh1zrxzZFdYuEcJZZTuFDjsybEWXW0Y4vgltkYUxHSnLbdGtc4ra314DhiAfbNJIb38GB4dlGEAMc1YFJherBCt6dUgF4DzcmBX6IXbtjTQgIsk1nbP03KnqBufwQ5l8Uhsdv88l41pZ+Od3HWZ2QzIfYBq2uuDD4JWiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734563365; c=relaxed/simple;
	bh=4WwkstL35KhL3qhGUlXubFCz9/fgciZTvqmYrG8rlZw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Df49Qt8zVBeBDg6sRzg1BYG7AL5cY52EB8mJhdQDoWtYlbwfyMBtlM+WyU7dnd2RU4Jvf8pJzUJWZR1ghPwrKH7QPcATrXw84H/44aFG2dzKZJNoAKNL40+KrkZQ5hrALDNWKzztSs+zr0gGjIcJzrizrJvioxYH6gFr0kg9Xvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hVJnwl2z; arc=fail smtp.client-ip=40.107.20.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xcewkx4zqwRui28rgSoFK2Tnm3svSa+UJhTIVx7mlMFs/ppY+TpwIFrhMrAlyGJZIKMq6TFH0IeGDNPZAr3+1LmCPT/Y+pEbwk4gDP/d+ye3Azkc85qUIdLnX5NyDWkX1ISF3qVuU4z27ZU/aa4YaF4hu5UZpP5Qfw/mxwurVZOIwPevC8rdFGJW3Ne60PNwXrV9Q9x8+3ahlPAT1JgAvjncSHAeFauQ8vqY6eYfj0Ngm6MKIx4G3EhlF8GFU85mUY73AikWdZ1ty4gg6eBxPhp9M3mfqHn/AybQoFcCOJS073E98u9rzcpAULZmdmiRBGZoUM2aqfDNmLPD8/R2aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3FjoyRz3SjkhMK8MORPoSjLFnPjDhKj+yUIz4mwf6s=;
 b=M7i1zrpCtAVtXOLWlotReZGc773qtNZxBS3UYR81BwhtlgKGE9j+lKDpCE04+pyokJoZiwaTKGpxWqPAjRnnWPMg3JnIkKZ5JuC7kENjOrvRvkpXS8O7JmzpFdoO8kOX3WRmh+eOQZ9r/a1xb8+SNbX0Mlghw+gbE8+W7sszVWlNWWxupNb6tWpkr6XAJf8kEymzSsLAHv0Au10VnaOSUXMkXvaztLA0ABLxqR95QYlrSXnJveVxqwQeBoIP4NKPEzrbRE4SbLCLYXd8Q3TTjdvwaJ9cQhAT7cu3c/cHxB97SYVyjC3qcBjBfT2wPXg9IChV1j3VwrOaxOuFLKUzmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3FjoyRz3SjkhMK8MORPoSjLFnPjDhKj+yUIz4mwf6s=;
 b=hVJnwl2zwYvih5KGR6HoF5kNITia0jIAB0unx6f/ndM8pOplQURwF2nOc7DwwlrMbe5tusYNhZSAhag+ZXYQHuom1kDVuJ3/mgNEpJu9Vcys/uVDrU3EMA/IKslJiJq9eo8JPhslE90l0Us9FpU4RUnCjC9SJxpp2iMlrgHS0c66J/SvH9d0XFvxRBZshUsz4dElB/rZRizcHrodGXd5rB5+trK7zMu+79ySpUcEYZm9IcsFVNMztNOWK6nd/uxZ/8Nr9sKWeevjOYDf9shuo6v+f/1uTUsHYGSuIMml4up8KA+NwMHWganOP13BOsz+8lR/lcwZ1xB0BjcMFzA7kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9939.eurprd04.prod.outlook.com (2603:10a6:10:4c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 23:09:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 23:09:21 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 18 Dec 2024 18:08:39 -0500
Subject: [PATCH v13 4/9] irqchip/gic-v3-its: Add
 DOMAIN_BUS_DEVICE_PCI_EP_MSI support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241218-ep-msi-v13-4-646e2192dc24@nxp.com>
References: <20241218-ep-msi-v13-0-646e2192dc24@nxp.com>
In-Reply-To: <20241218-ep-msi-v13-0-646e2192dc24@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
 Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 jdmason@kudzu.us, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734563338; l=3555;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=4WwkstL35KhL3qhGUlXubFCz9/fgciZTvqmYrG8rlZw=;
 b=nzwsc8/qZUuzDYm+GQxGjDUKpheDTKeoYWbKwVPnApomjR+n6TZNUIS6Bqo+80gxDr8rTYBSu
 Sp1XHabTldFC+iFxgIO+gpSeHK93A5PiIrfk6hIghkofGzJE2nwCFyT
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9939:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b9c9e9-75ac-4805-c8ed-08dd1fb90174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjF5LzJObEVsTDhYZ3YwRjBrZjFyOFJpSFNaTTNqWHJCZ1UwZVF4ZG44TUpE?=
 =?utf-8?B?d0FWc3o5dnhMb1NNMVJVb3pLQ1pic1FmcUlNd0oxMjc0YTRuQ1FFbHI0aEpv?=
 =?utf-8?B?aXZRQyswZWpiRE5lYkRmZFNHblJabnJMUXlzdkE4cFFsSUdJc1YyeFRWMUV6?=
 =?utf-8?B?SzJQai9oeUFNQy9MaElSY1JWdFpIZktHVHk2emdrWmpiZkF1aGg3a1lpNldu?=
 =?utf-8?B?Z0xNOWMyVHBmTmZ2dXhISDNUS3NVejFPUDZrbCtBL3lvczNXZGtpd1IyL2w2?=
 =?utf-8?B?bTg2M2k3K0h6VlpFLzVBeHlXOGZHSWpzYWNaN0NTSGpybUwrc2pWYmxpRk5p?=
 =?utf-8?B?amJRWnhRWUJ2eEsvcGQxaEp2YnFVZEVhK3Y4TTgyaWllSmErK1lGczF4UzhX?=
 =?utf-8?B?cDNuTE1idjBVcVZPQlhHbmRYT2hJWThqVjNTb3M1bVJjY3YvOHJEbWRsRUtu?=
 =?utf-8?B?WVNnT0V1RXFRL0NySXlSTFlnMkt0QnR1ZHlTaGExWlVva2xTVng4dzJlNmZT?=
 =?utf-8?B?ZGxpWjc3NHRUWHM2VDY4eEptTVFtdzlXTnh2WkdHeEhBbzhSTW9na0pucTky?=
 =?utf-8?B?dFlBSWZzWHRtTUpnN041ejlpcnpGcXh4VzVFcmlLYlNVS2VGQmhTVExsaElC?=
 =?utf-8?B?Q3dMcEdDWEE5MVdmaURUZlkxaHZKMFdNWWlIWWp6aVNtc2RHTy9UYXA4QlVn?=
 =?utf-8?B?T0pnNm12SHg2SFZSaVpMNHZ0dFM5R3JZdVpSNDVLTlFhQjh0dnBrQ3lzUklq?=
 =?utf-8?B?ZWwxQTlKYzZlVDY3bmQ4eEdnM0dHWVVwNWk4OGV1MktNN1piclBZQmNZVkk4?=
 =?utf-8?B?TzhOdkx6NWdPc2ZYVjdwalJCUHkrVFNUL3drbms3UTcxazdnWEF1SHhNUmpI?=
 =?utf-8?B?UWN4ckMvN01NVUpjeEZHRU9ITVNBb2ZWWm9JNHdXN2l3NlV0akJqMnRJc1Er?=
 =?utf-8?B?UzJvdm5jRnlySW9heTcySTBMeHRYVVd0TEZTMnoyZGtzT0ZCcG1mbm1pbWtL?=
 =?utf-8?B?eWVPUkVPTEcwYzhFWWE0dE5HZXhKbWplSDRNZDhXd1AxUUxoQ3RuUkZNejRK?=
 =?utf-8?B?TXdyZTdFc0hDWUhXc3JJOHFzaFNhb3RCU0RuNHFIa0hSVTRvSWJJdnV5Q2VQ?=
 =?utf-8?B?cmVEL1Y5UkFtNldTZ3JPK3VOSk45NGtTSUdnemd3VXpTVnJYbFNrUXlPMzlQ?=
 =?utf-8?B?MWdUUjRjQ3NYRS96RnQyajg0M1habW81YThpaW9aUlA1M3VwY3M0SWMybFhy?=
 =?utf-8?B?SVR4SU1oMnJsNktURXBvTlVqNDEyMUJvaTlEYlBOcjJ2bVR1bnoxMkRpeEg0?=
 =?utf-8?B?eFVjSU03L01pY2F2czA3QmsrUXZFMzVkSDBQUDNBd3RnVitOYm1NNWZYS2Fn?=
 =?utf-8?B?dDV4aEpDZmlReTVYU0pRNDh1QkhtMzF4dmpManozdWY3RlBRTTRZOE9oRTV6?=
 =?utf-8?B?d3drQldKTXdGcC91TU5BUnFCZ0dISFllMjlma3drSE9mVHdKeXVZMm5pSmps?=
 =?utf-8?B?YVpiVS9tc20rWTFJTTNrV1A1R21VaCsrNE1DMEtYVVpIb2xkTmQweFdiQTdH?=
 =?utf-8?B?NE8zNHhqOXV2ajI5OTNOVW96c0Fqd05zakdHUXA1NGYwTmVNd3JlRjZKWkR1?=
 =?utf-8?B?QURRbkpSc3c3TmN4dHBZb3ZGNmlhUm9KN2M0TEpoM3BUcEkyNGFTMFVqcEIw?=
 =?utf-8?B?QjRLdEYrSXhnWjlDOUhyRHRsWjlYYkxmMGRCb1NBVjBxTHM4YnlJUzZHMEx0?=
 =?utf-8?B?MURLNm00NEFNd0NsT0N2NFg2a1hLWHRkU1ZXVVhRNmxvYXdmYUxsK1oxUFpR?=
 =?utf-8?B?ZzRJQitlb1lLOWJGSVlMR1FPeVJKbVZpMk1PSzVZOUZ0NHF4STdwT1o2Yjcy?=
 =?utf-8?B?dFUwZzhYY00xNzlYVTlwZ2N2QVpwRU5QczBMYm9LSC91eCtGQkNoNjhGYTFP?=
 =?utf-8?B?K2gvZ3FQTVdQbXFaWngyMGtCODdSZXg4YmVYYVBVK3IzKzI3L2hUOVd2VGE3?=
 =?utf-8?B?MkNKOUNmbVBBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SE16VnRLcjJnZk11L0lHTnFMdWdnNENlSUppODg2V1gxakk5cmo2aTIzMzZw?=
 =?utf-8?B?eWFVM2NwS1VrbEhpQnBkY1pYOW82Q01FTHM3dENXN25xM0ZQZXBsQy9uK29m?=
 =?utf-8?B?cEVZOWdaWVpjbEo4Tm9OTXkvRjFQY2xHT1RLcVd4UjRmTzdkckZhMCtNbHVr?=
 =?utf-8?B?dTZkOFlQZkdSRlpjTGtLeVM5anAycldTbDNuSTRjUmZFWUpHRUFkVHBQeXF3?=
 =?utf-8?B?WWh1MmxMQk9UNnl4YURZQUpPV3IyL3Z6cmVXaFhrd0hYZktQTForcmtnZVJv?=
 =?utf-8?B?bVhNS2hzRVg1aXRxRWlhdHdqcXQxa0o2Tll2Q21qNDZFcURtcU1MSFIzWjNh?=
 =?utf-8?B?N2R1Z3hwbktDanljcmNKSFB6R0QxRWdlcEZncXNmVTlZdGVQaW9kdHZqVkgz?=
 =?utf-8?B?RzhucHFiMkt3b0NKWCtwZW0xQVdHeVJNVEc0Zk9paVBkNjRiSUFlU3Z3T1Rs?=
 =?utf-8?B?UGRTdHVLK0FiclVwLzlvU3gxOVdEN2pQOVlJaUJZckVjc3ZOZUNqc0lGSk9I?=
 =?utf-8?B?d01rMDRZV3AzekhTeHU0QVI5NE9zK3UwSHM5WDBQaHZTc3hGWWQxeCtFSGpq?=
 =?utf-8?B?bkxsaWFLUmNXNVdpZUxLdVZ3a2NoaFVsOHRvSzNuNVNTaUJHS3crdGY5c3Jq?=
 =?utf-8?B?NEMvN1B6YXg1RjhYaXFjd3dtaVJvZ2E0dHZZSTRBcnhOSDJWUlBWbVNXYlZ5?=
 =?utf-8?B?SzNheHFsMnIwRTRDbWgxdTVaVUFteU9aZnVXRzVRY1VINFVQNmVZRUd2Rlpq?=
 =?utf-8?B?VEd5UHFxWjNWTHhHcmRjWDZJL0pjNGpzTnV2TzFCTGE2M1lVOW9oMXh0K2dt?=
 =?utf-8?B?dk4xcmR1bDE2WGw2UUhKY2tKMDJUMEl4dHVEZ042ZE8zNWx2MXowenBoQi9m?=
 =?utf-8?B?WHlGUkd5UnlnUms4NU9WMHI5S2x3eVVjT1NoV0Q2VS9GcDU5aFE3T2JhY2RH?=
 =?utf-8?B?VC9OVmxsaXdzeUdudUtLRUFPZzZHbFhodlJUZUF4VVhWR3YzYU1uZzRBdUFD?=
 =?utf-8?B?N2tsWmtkNFhhTTU2MThFcXRZK21tUG1wRTFKb3VMeExBWFBsOE1LemFvb2Fo?=
 =?utf-8?B?OWRyQlRGNDJ1MUVKSU1XZkoxNDVGMjZ1cTNqTktXTXhpWjJjNC9rYndrYzJ2?=
 =?utf-8?B?bGdxR2V5WmdzOHlnV0FzOXBpOTVmTko0RWRsVy8vWWhYcFUyNWhER0FhNkt6?=
 =?utf-8?B?WmE2dnlQdjd5U1dNL3NneXBOT1ppTGJzaWlZVHBQL0pUdy9mT2tsWlVXZHVL?=
 =?utf-8?B?NU5QaG1XeTlDMEpUQis5YkpuSy83L0Vnc2FXRXFSdllxYmF4WGd0Smt6dVhV?=
 =?utf-8?B?akRJNFA4VmtrVGZWTWsvMm9USHBkSDlPbUhNL1pvT09VNm1jSlV5RXFXbFdQ?=
 =?utf-8?B?SVZySGJSSzVWQ0FEUXhXaS9ZY01LVGdrU0sxZXdSMmYxN0xZampnODJ5a25r?=
 =?utf-8?B?SmZsNGNPWWVtcnczM3g3aFV3TjViVFBjbTd5Zi82YmRHaXFwVXlvaElSVllQ?=
 =?utf-8?B?Rk9sME53RHBFMUY1cis0YVpMN3ZNNGN1TmJObFJMUUJueXUyRzBtZHB3cEZR?=
 =?utf-8?B?Y3VJbHpZbnRMMU53ZlR0QnB5em9mcWg0ajhhclpoSmNsQ25WVVovRHJJeU9m?=
 =?utf-8?B?bEZnQkJFcDZSb1daQ0lGTEdCZk1tanhqaEc4V0Q4eVRVeVhZNCtnTjNjWUNR?=
 =?utf-8?B?djh0VDA1WjRiUFBKY2c0YlNkT0xldFhjdUpZMm1XcGk1Z2gwM1l5ZFNmYVFr?=
 =?utf-8?B?dkhiZmJaZEhCSks5d0E2ME8xWFhKaXBFVndzM0hkVXhLWEFCYVZ2a2ZBTlhS?=
 =?utf-8?B?TjNSTERaZWJrZ3JYTWRzVXRwSmdLMDRQUkJHY0pWWDBvOEZJc1FDOE1pSHB3?=
 =?utf-8?B?cUpGSXphSmRxVDZDdUxhYkZiQWtkeFQ3bnROaXJjK0dzcSt0ODhOZGNjMHpl?=
 =?utf-8?B?VldTeGp2Z09aeUtjNDZneFNmYkpucUJRS0JuQzRhMWhhQ2htdWlQNTNtcTNk?=
 =?utf-8?B?UE1NeGZEd2sxMkdNeWRNQVNBVzQwMXJkNFFxL3F1SDlUdXp5WnVaN09LVjhB?=
 =?utf-8?B?eFVmbG9UcHFMNUE5VWtDQTBZcTVKaDZiVG0yblh0QlVvengvQ3NHaHhhKzFU?=
 =?utf-8?Q?HSWYaB4yLc61jPpZnYF6Cw63S?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b9c9e9-75ac-4805-c8ed-08dd1fb90174
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 23:09:21.1077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfHcn2FxTiEQy7lOhYBCIoXzBgoSHTLPajp9kPs+EjJ5IspD++cNw50rQ9hRdWyL03b6f8l/wlM0146tqUSgUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9939

           ┌────────────────────────────────┐
           │                                │
           │     PCI Endpoint Controller    │
           │                                │
           │   ┌─────┐  ┌─────┐     ┌─────┐ │
PCI Bus    │   │     │  │     │     │     │ │
─────────► │   │Func1│  │Func2│ ... │Func │ │
Doorbell   │   │     │  │     │     │<n>  │ │
           │   │     │  │     │     │     │ │
           │   └──┬──┘  └──┬──┘     └──┬──┘ │
           │      │        │           │    │
           └──────┼────────┼───────────┼────┘
                  │        │           │
                  ▼        ▼           ▼
               ┌────────────────────────┐
               │    MSI Controller      │
               └────────────────────────┘

Add domain DOMAIN_BUS_DEVICE_PCI_EP_MSI to allocate MSI domain for Endpoint
function in PCI Endpoint (EP) controller, So PCI Root Complex (RC) can
write MSI message to MSI controller to trigger doorbell IRQ for difference
EP functions.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v12 to v13
- new patch
---
 drivers/irqchip/irq-gic-v3-its-msi-parent.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
index b2a4b67545b82..16e7d53f0b133 100644
--- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -5,6 +5,7 @@
 // Copyright (C) 2022 Intel
 
 #include <linux/acpi_iort.h>
+#include <linux/pci-ep-msi.h>
 #include <linux/pci.h>
 
 #include "irq-gic-common.h"
@@ -173,6 +174,19 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
 	return its_pmsi_prepare_devid(domain, dev, nvec, info, dev_id);
 }
 
+static int its_pci_ep_msi_prepare(struct irq_domain *domain, struct device *dev,
+				  int nvec, msi_alloc_info_t *info)
+{
+	u32 dev_id;
+	int ret;
+
+	ret = pci_epf_msi_domain_get_msi_rid(dev, &dev_id);
+	if (ret)
+		return ret;
+
+	return its_pmsi_prepare_devid(domain, dev, nvec, info, dev_id);
+}
+
 static bool its_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 				  struct irq_domain *real_parent, struct msi_domain_info *info)
 {
@@ -205,6 +219,9 @@ static bool its_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 		 */
 		info->ops->msi_prepare = its_pmsi_prepare;
 		break;
+	case DOMAIN_BUS_DEVICE_PCI_EP_MSI:
+		info->ops->msi_prepare = its_pci_ep_msi_prepare;
+		break;
 	default:
 		/* Confused. How did the lib return true? */
 		WARN_ON_ONCE(1);
@@ -218,7 +235,7 @@ const struct msi_parent_ops gic_v3_its_msi_parent_ops = {
 	.supported_flags	= ITS_MSI_FLAGS_SUPPORTED,
 	.required_flags		= ITS_MSI_FLAGS_REQUIRED,
 	.bus_select_token	= DOMAIN_BUS_NEXUS,
-	.bus_select_mask	= MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
+	.bus_select_mask	= MATCH_PCI_MSI | MATCH_PLATFORM_MSI | MATCH_PLATFORM_PCI_EP_MSI,
 	.prefix			= "ITS-",
 	.init_dev_msi_info	= its_init_dev_msi_info,
 };

-- 
2.34.1


