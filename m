Return-Path: <linux-pci+bounces-44651-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFA8D1A8B8
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 18:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ADE9F300875A
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 17:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41529350A17;
	Tue, 13 Jan 2026 17:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="diu1NfL3";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="diu1NfL3"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020141.outbound.protection.outlook.com [52.101.84.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAAB35029F;
	Tue, 13 Jan 2026 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.141
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768324519; cv=fail; b=eMeFO8fLGlylP84Crpbhat30Si3pr35LuMeoZe7eOzeN8W+XHFMHcLGJNz+y4u+UZXdxH1hYxsUQDSN7Hy9Ryr/KsWCmDWedlOFaSUyMvwuj77LozCIhJvgZBfglSr5sUDm70WvjwRw6U4ZiqtF6nAJO752Je7gV7aYhSD3ryHg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768324519; c=relaxed/simple;
	bh=7EE2ZXVvTIPZBQGhFjVV2wZAsI+BbV9DRSnPUM/khEc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VAUHQgym6urKUw248YZOgDFkPq8Zr5alkHvbuGk5k6l39vJ65q+zXG1UvbT7T+PJvfzzKvvEnWUU97fWQOriD/UoREKfGxkBKk6rzDXJeNYUfsCJglKlmmB3x8/7noY/BlzK3gNMmP1SAXMpORYpB9P8OilDzSvqLio7BC2vDv0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=diu1NfL3; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=diu1NfL3; arc=fail smtp.client-ip=52.101.84.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=OauLX3ejwlXMljy7G9Ws6S51ZQpoNej6Basi6uJtEfdyOHsbtPAPVeEiIQ5MOT0UPU8WH2SyY00pvXDNalqyA8zH9JeU1y3nily4yEF/gkn8RtOit094eGCQLWUsRMN9PWrYuFPIBJ7Qbeeh1kyn24fE7GMFDsp/O+p8VOoqql5LIzgYN5TQQvIoRny0PfPmn6pXIpaSRIgkR0g3yLwIL6jbuwG33mz+9wfcwVwHUmDM+UpgqUuUxjutqf9JXfEamFoNDOLNGsvh/dbSzKlLCSe/xgLYdLsRGdveMAh7yVPTPpyxayqDIA7uvsDIhHMKziep2eMocOeO4Q850+sS8w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIeD7LHbMhpD7PM/6kQgDbKzlMRrwyri8y1H4koWbNg=;
 b=Fh+40/TtOqeMHrlqHW61getxzYsRCFP//Fd01XPaGVktNQlA5/9DWalKHWOfdFq3MIUEk4DVY+/fACV2mWCfRGBS8kc9wAB/0ECdzBqSQsI9wLApeUUTR0Ft3PPmLe8W71m29F1qb9vZzKfsWRTy/nf4ta1N/b7L44lJ1xrNJkJLPI00WksDyQ+angWr36eXmj8vsAOUJ9F8WbGZhCqsygerzd6kYMKWfdCqC5NwPtf2T0eLRUe0cAQe526whr6CGWF6Li6NfnktKAOZUznFTzbtswOxurhsgU01mW5I27mPifqlX7t+nPxaY8XqloufejI+tJhOUGdpe6v9N4EykQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.83) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIeD7LHbMhpD7PM/6kQgDbKzlMRrwyri8y1H4koWbNg=;
 b=diu1NfL3rNgVCaRg1436B4cl92GAb60UibCLIlJ5EQYdCwDiOHpgJokhwrQAg/irL/1tllI8hwxqwKqw/yiXhCSge1hWboJntwgkn5Uq7skFjEnNuQ/jMRvoxibTcxc85uxwWL6oNT9UcwNbT/Vf+NClAMNd9LLyq+X07MOUaXXWBsF1riuBSty036jlUa5d5TXFti3Zl6rEKhkMLgMrQ5CuqU1PQFXqST/+LG3pFV+s+3e8h/02yqePOWp9x+y9aEFh7rpVbPBt+LC+gfFXkV4B50bwR1pJUa+KdMOPFGAMGb20RZJ1OgLDoGnU0/bgopweafkiYM+7J1C3dOBHNg==
Received: from AM0PR02CA0144.eurprd02.prod.outlook.com (2603:10a6:20b:28d::11)
 by AM0PR03MB6324.eurprd03.prod.outlook.com (2603:10a6:20b:153::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 17:15:11 +0000
Received: from AMS0EPF000001AC.eurprd05.prod.outlook.com
 (2603:10a6:20b:28d:cafe::d6) by AM0PR02CA0144.outlook.office365.com
 (2603:10a6:20b:28d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 17:15:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.83)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.83; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.83) by
 AMS0EPF000001AC.mail.protection.outlook.com (10.167.16.152) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Tue, 13 Jan 2026 17:15:09 +0000
Received: from outmta (unknown [192.168.82.144])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 9236F20080EA3;
	Tue, 13 Jan 2026 17:15:09 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (unknown [52.101.72.137])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 670D0200C4FE2;
	Tue, 13 Jan 2026 17:15:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEGYiOwWE7RNV5Oo2IAeC4XX344aH+Erxw52lQT5qaEa93H7BG6CCIQCRGG22ew0ULHC6svX0Bz3dG8W0V1uCCPNyaPQ6B2p1Nr/ZLniv7yfFdHQ4kItvIimKtOctQQS2ixSi1Se4YGoxxG+BCbum1ojpCYe4yLD25/t/yfbQFMyX/0kRgrb7j7CgD0V5cXabF7jSeXIz45OlI206akFuY9AHln0WSHo8tH5fo/uFPIDiTAf/pOaAWUX6JEtxZ5PCckyqrq5VMPsoplK222SesGs153L4JR8FjxZqNZVk+1iwvYG9p7mEEaGEu+OrAnxnD8DYpteJe4gnpCS+tp0Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIeD7LHbMhpD7PM/6kQgDbKzlMRrwyri8y1H4koWbNg=;
 b=YPOtPZ5CzjUATNYgretDst4wp0oZ6yHLzWj0Z5i7xBR14P5oz7fY2Al4lYjWFYz52UZfLHtjbT1+LYIApFiaJ8OErDb1HOlEJ3N5KHPTwGAs5xd6PFGKpxGCwy2m/hZc6w9IAMPyLJ0/wm36/WHSMkSA68xbrC1SFx0zmfTYeFe67Nq4Ndp7MYyyvoKnw1EekH+lrWKkHdyt7eayhK1vxxuMqfV/gd8/lZC9KMw2cMQkSdW3NdnUbSgf9hG0hatJQQO1vi7ljnk+KZXtG6dXgirrQz/mL2C0KkV+WOWitVE82iJ1/sc0UTb+x9yYnlB1h5LnU+BInggzwIfMEBjZQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIeD7LHbMhpD7PM/6kQgDbKzlMRrwyri8y1H4koWbNg=;
 b=diu1NfL3rNgVCaRg1436B4cl92GAb60UibCLIlJ5EQYdCwDiOHpgJokhwrQAg/irL/1tllI8hwxqwKqw/yiXhCSge1hWboJntwgkn5Uq7skFjEnNuQ/jMRvoxibTcxc85uxwWL6oNT9UcwNbT/Vf+NClAMNd9LLyq+X07MOUaXXWBsF1riuBSty036jlUa5d5TXFti3Zl6rEKhkMLgMrQ5CuqU1PQFXqST/+LG3pFV+s+3e8h/02yqePOWp9x+y9aEFh7rpVbPBt+LC+gfFXkV4B50bwR1pJUa+KdMOPFGAMGb20RZJ1OgLDoGnU0/bgopweafkiYM+7J1C3dOBHNg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by PAXPR03MB7807.eurprd03.prod.outlook.com (2603:10a6:102:202::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 13 Jan
 2026 17:15:06 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 17:15:05 +0000
Message-ID: <0da0295a-4acb-430e-ae1a-e144f07418d0@seco.com>
Date: Tue, 13 Jan 2026 12:15:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] PCI/pwrctrl: Major rework to integrate pwrctrl
 devices with controller drivers
To: manivannan.sadhasivam@oss.qualcomm.com,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>,
 Brian Norris <briannorris@chromium.org>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Chen-Yu Tsai <wenst@chromium.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20260105-pci-pwrctrl-rework-v4-0-6d41a7a49789@oss.qualcomm.com>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20260105-pci-pwrctrl-rework-v4-0-6d41a7a49789@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0060.namprd03.prod.outlook.com
 (2603:10b6:208:32d::35) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR03MB9020:EE_|PAXPR03MB7807:EE_|AMS0EPF000001AC:EE_|AM0PR03MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: cd8202a5-8b9b-4a8f-2f9a-08de52c74e3f
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UVlUZkpRZkJzU2hlREZ1OU5mQ3RSYThrRGRrQzlic1JlRDhMQVFYdFNDSklL?=
 =?utf-8?B?dU1ZT283OHpuYkE2YVQ0ZXhYZ1lYak5HNmxRdmU5bFZZZDRLOURNbVlUaGFW?=
 =?utf-8?B?YkxhcENJVUhab09tbXpHTlZvRUM0U0FXRjBISzVVb0tnbTFnR01oTWsyVlhv?=
 =?utf-8?B?OFRKdDcxeUZ4T2pUM1V1S1hRSzlrdjhvRWQ2U09jRm9uS0k2WlpURUFpYmVP?=
 =?utf-8?B?UzhlVVAxbWtSNTB4U1liTnpLOG0rcFFyc25hUDN0dThGQnlaT1BZUXQ4M1lj?=
 =?utf-8?B?aHh2N1Z3RFJwc1VhMzZVUUkrYkV2S0xoNWtHTDhaeGlVMmpuK29WY2xDS1Zv?=
 =?utf-8?B?Qm5rdERsY1V5MWk0LzRBQXpNdWNWV2VnUnJnWDE2M2VXSDNudzVHU0hYVVVC?=
 =?utf-8?B?OTRHUi9FbUx2cDgzN2hIZUtXQW52UTZzN2tMaXMxUjJCa2diM1A4b3dRSGxr?=
 =?utf-8?B?eDl3VkYxV0ZqaVlQNE41WWE4NE92Nk9SUE9IL2JnVEprcnNtME9zNDF5Snlx?=
 =?utf-8?B?SWg2aE1VSnVDYnVCVW5odEN5Y0RIUGVJNm5MejE5SnFXdjF0WExYQ3ZzbG5P?=
 =?utf-8?B?Sy9IWmd1ZmpHdUpKUDhyYmxJTnZ1TnFuR3pzelVmL2ZrWVdobUpIZ1U0KzMy?=
 =?utf-8?B?d011VVdjY0NjY0RObjZubTZyVGFXcWJZZXFOWWt1QjlaTkIyRHhDMWQ3OFFB?=
 =?utf-8?B?NTdaVm1iaFZ4YVpSZkFMTlI4Qm5iT0JiVHFRU2dNb2ZBK0NKWmx5SnVkYVJz?=
 =?utf-8?B?MzFBTm9VZ3NvcjlhenBLZUNvV3BXZ2t0NDVPOUZ3dDZ6bEdYOFdJU1FYR2dQ?=
 =?utf-8?B?MW53RVp2M3lkM3dlMzNROS80ODE5WUZmaWZTN082ejI5TkR5TzVCS3loa1pQ?=
 =?utf-8?B?MDVYY0o3eUpIZ2M2blU5SS9wbXd5RVp0S0tlcVNIRUxKTjhSNktUdk5sM0kz?=
 =?utf-8?B?UFgxYmY2VkNKVC9zdXFlY21NN1FWZ0dHTUtQQjczOHA2Y1lZSDBHbXZOaGFx?=
 =?utf-8?B?SGY1NmlVcGlsVkVjcm1EQWl5ME1SSS9WV3ZBMlpXYXFMaWpveDBtc3Q2TEpz?=
 =?utf-8?B?K25KV3g3S2p5NVJwbDVvTWEzNWQycjZXbDduWHRPSUxueENBc2gxMUNZeVBm?=
 =?utf-8?B?eGRBQ29nWlRYb2tzdzB5aFk5a3l3ZlFTcm1KSDUxN01lWnhMbWZXMWZCYzhy?=
 =?utf-8?B?VHE0ckFVTHI5a0xSTGI0d1RjRzFGZzhyQmJWTHN4aG1KNzN4dDdTZ3NsYktm?=
 =?utf-8?B?YWdKL2pTSmRxRVBFT2RhMEtoUnQ3bDRIZ05DTFpxTmdKUnUvNU9PUTh6TXFO?=
 =?utf-8?B?YlgydXVmQkdkSThnVnNjUWoyRFlIYTEzY00zN3JsT0lLbVBtZkNOUlpJWmpt?=
 =?utf-8?B?bkY0dzRQR29JVW9JOTYzOEd5S3JkcXpkbDZrYWlzdXBXYmU5VmYwRjd0d1JN?=
 =?utf-8?B?YzdWY0g1WUlkOHp0L3FDZXhzaXpHMDNxTDRqdWdNdWdnSUR4L2REckN6di9v?=
 =?utf-8?B?TWFzTlBMbHROVS9NSENXM1hSV2hDMStDQUdoWWZOUy9zT0VYWnRaTXhSOU1r?=
 =?utf-8?B?ZVEzSi9SbzRESllUWmRUMzFaTGZVNFNxUVlwR0YxNHdrV1p2dUtmWlozcWMv?=
 =?utf-8?B?NytnWE9jOEdPc3Z2eVo0UW5JaUxrOW9kSjErQWJZcnJXU0pFN2N1QVB0dmhl?=
 =?utf-8?B?WVVjb0tIT25ORW90dFhxcUNmbGlXUFZOaEtCeGozRzU3cFhBdG5UOUdickRp?=
 =?utf-8?B?RUFEVG1jK2lYLzNjOUJlcFFMUzhBVU80NkEzL2cwU0hiYjVQTlc3ZEIrWXly?=
 =?utf-8?B?Z2g5c3Z4dVcyQ2NVZ0pZeEdZbUszMnZveUkyd2FXczF3T014SmowTHROREUx?=
 =?utf-8?B?YlExZzdyTGltdkwvMElXR1BHS05ZY21NZm9QaGNxdEgrSE1OZlFhcWRsczBr?=
 =?utf-8?B?VE1UMmVkTGsra2k1V2pwODUzcWVwT1dhM3JkRnQxcFJQR2htcjZqc2dNOXhu?=
 =?utf-8?B?WmNOa24zWjRnPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR03MB9020.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7807
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001AC.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a9182b76-00e0-46b1-ef03-08de52c74ba1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|35042699022|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzRacExzdDJ3SERMY3poSkxNSmlKYSttcnBmQzFFWmdvN3JaWGxwMDgybTdy?=
 =?utf-8?B?WHA2bXBqWlNmZ0VvYm11d0RQSVpDc3ZJdDVzYTlybnBDdnJYcmFvaXFHR0Zp?=
 =?utf-8?B?c20ydkpiRTY5bWZxZDNobmswbklQT3B4aGhGV2dWcFIzQVNqaDBOYktPbzRm?=
 =?utf-8?B?ODZqamJpZ1VHMG1kakV4RFBzNXBlM2lRZmpIak41cXpBWm1PRjRaS3BwT2RM?=
 =?utf-8?B?WExiR0c1NTBDZm9wWHdGY2F0UDRTc0Jrck5tbDJsSjhPRjhuWm9UbU9lVG1O?=
 =?utf-8?B?NmZRcURVOGVHL2toVXZQQWQzQjk0eW1rZmRQQlBiVGJrNWZCa1V5NmJhOHhP?=
 =?utf-8?B?L0NkNmdWN1dPNFNuSG1qYzFodW5SRXZLM1dxOEx6OXc0M3ZSakdaem5JS09Q?=
 =?utf-8?B?WFE0N1NjSU9sSkpxMWJBUWdIVG1yZGVHMUpMb2o1ZDlNbC9hOUc1bXNQanBa?=
 =?utf-8?B?MTFBVGt6Y3RkdGN2Ym5rL014M2JlZ2hmZTk4MG1BY29PWndQdW5YeWd3ZStt?=
 =?utf-8?B?TDFXNUZkWk9teWJzeVhFK2Q3dSsvY051T21acTRPTE43QWk5ZVZUamo5czI1?=
 =?utf-8?B?dHhqeURrUE1VRmR1aHVSOTRGYkVZZGJqekFNamtYY2tKYW1WTFhNWDdKTml2?=
 =?utf-8?B?Snhqa3VXUDhyM2gwSk8xY1ZCY1N3RXJ0M0pJZmxvSEVIRks3ZzZxNmFuYVZH?=
 =?utf-8?B?OFI4Y05HVllvMzRJemlod0t6NnRWdjE3Tnh3ZDdYRG5CaTJVNXdLZVpMYnRD?=
 =?utf-8?B?WnovbXhIMkRhL2Vhd3h0WERSb1duandEYno2Rk44MG9leVBHWUlrSnZXTW9r?=
 =?utf-8?B?NUJwUERidmhVaEJQc01sa05WNVNrek10Q24wcitJVUFZUXBXdDVXNERjSmV0?=
 =?utf-8?B?VXlZTnZWc1RzMzZLRlhzTW93OEdFNzZXQ0VWVlRhVmQ2RUwyQVlEYzBzL0Qr?=
 =?utf-8?B?UjdLbTFMdGtwR2FmeHdkcVhpLzNueHpVT1o2aFBCd3VJbHpxMlRSV2hBZHpQ?=
 =?utf-8?B?dWN3UThKT2hJbVc0bkYrOXFURlRic1NxelliSkpocDZoalZ6ZjBlVmZOSFJY?=
 =?utf-8?B?aFR6Vk9abDVONDVINzZDTUx1ZHNMVUxhL1JUV29YRGdQaW9sbTVOZEVOM09u?=
 =?utf-8?B?TnpDaXpCWEVPRFV5NXZhc0kxQ1JoQm5SOEd4K3pJbytuMkVGL1RJSHJJc2ZX?=
 =?utf-8?B?SUg2MXkzYjd1Q0g0cU5QNXcwS0NqLzh6c2sxU0lHdnNoWnh4SmhLKzh1NGxy?=
 =?utf-8?B?UlZxbUV0TmFkL3JlanNSVUt4dkw3WjNqTTVoTEQzME94cllYa1F3Mk9IVVdQ?=
 =?utf-8?B?cGgweHltWUNicTcxbkswREk1TFdBL3JGenhKRzk2QmNtSHViY3NBNFNWVW5q?=
 =?utf-8?B?MjA4QzZHN0xWQzFVUlI2dTgvOWVBYWRQTHhxb0Z3MVVhSGgzMS9BMW1ncnZP?=
 =?utf-8?B?dXNZSWtEdTFDVmNxKzBVMUVURFRMS2pkYm40bkI3YlkyK3BMTDNlT1VvNWYx?=
 =?utf-8?B?ZFNZQVphMXh1RGppOG9pd1gyUG5JeFlweGxkaUJWRUdyTHVRYzhPVEtRdWts?=
 =?utf-8?B?ZmdHQ0xwZStFME8xaTd2V3R0dk1YbzJZL1g2QlBlSGswUFJ3eW9zcjZncmR0?=
 =?utf-8?B?UUY3d1RNUE93UmVaQXUvTVp1aWRvTlNPOGZOWHh4RytIQ2NKWjJMWG5nY2Q5?=
 =?utf-8?B?VVN6aDhZZlRocTM1YlVrRnVlV1NCR1prbWFYSHZoOHAvVlFvdVRFaWl4WDdY?=
 =?utf-8?B?SUdQV0ZNR3YxT0Z3MENOeG0rL2hscjBwQlRZZ3hHMHFid1ZWQm82M0d6UnpT?=
 =?utf-8?B?S29FVnpxTnA0RERpVDRpeXFRVC9CM0RUT0hPV2Z1SjBHd3RwalkxMlloOTBy?=
 =?utf-8?B?WGZRaTkyYm41WkNkcVVGc3AxUElYbDFXS09pUlpMOGZMUi8zb3A1ZkVqMnMz?=
 =?utf-8?B?VmdvWi9KdTVPQzN4R2g2bG1RWC9qczFDdFBqN2l0QzJmZ2pKUUVUWk9WaVBl?=
 =?utf-8?B?cSs0VlRQZ2kxT1I2alAyQ2hpRkdGZk1oRldZVzdSTTB4RC94VU5uUHpiNWpK?=
 =?utf-8?B?ZG11eFM5ZzFHWTNxTVNaRUNIVWlyQy9hUXNnbW5ram9qZWdzVDdMVWdEWGt1?=
 =?utf-8?Q?j2JM=3D?=
X-Forefront-Antispam-Report:
	CIP:20.160.56.83;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(35042699022)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 17:15:09.7457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8202a5-8b9b-4a8f-2f9a-08de52c74e3f
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.83];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AC.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB6324

On 1/5/26 08:55, Manivannan Sadhasivam via B4 Relay wrote:
> Hi,

I asked substantially similar questions on v2, but since I never got a
response I want to reiterate them on v4 to make sure they don't get
lost.

> This series provides a major rework for the PCI power control (pwrctrl)
> framework to enable the pwrctrl devices to be controlled by the PCI controller
> drivers.
> 
> Problem Statement
> =================
> 
> Currently, the pwrctrl framework faces two major issues:
> 
> 1. Missing PERST# integration
> 2. Inability to properly handle bus extenders such as PCIe switch devices
> 
> First issue arises from the disconnect between the PCI controller drivers and
> pwrctrl framework. At present, the pwrctrl framework just operates on its own
> with the help of the PCI core. The pwrctrl devices are created by the PCI core
> during initial bus scan and the pwrctrl drivers once bind, just power on the
> PCI devices during their probe(). This design conflicts with the PCI Express
> Card Electromechanical Specification requirements for PERST# timing. The reason
> is, PERST# signals are mostly handled by the controller drivers and often
> deasserted even before the pwrctrl drivers probe. According to the spec, PERST#
> should be deasserted only after power and reference clock to the device are
> stable, within predefined timing parameters.
> 
> The second issue stems from the PCI bus scan completing before pwrctrl drivers
> probe. This poses a significant problem for PCI bus extenders like switches
> because the PCI core allocates upstream bridge resources during the initial
> scan. If the upstream bridge is not hotplug capable, resources are allocated
> only for the number of downstream buses detected at scan time, which might be
> just one if the switch was not powered and enumerated at that time. Later, when
> the pwrctrl driver powers on and enumerates the switch, enumeration fails due to
> insufficient upstream bridge resources.

OK, so to clarify the problem is an architecture like

    RP
    |-- Bridge 1 (automatic)
    |   |-- Device 1
    |   `-- Bridge 2 (needs pwrseq)
    |       `-- Device 2
    `-- Bridge 3 (automatic)
        `-- Device 3

where Bridge 2 has a devicetree node with a pwrseq binding? So we do the
initial scan and allocate resources for bridge/devices 1 and 3 with the
resources for bridge 3 immediately above those for bridge 1. Then when
bridge 2 shows up we can't resize bridge 1's windows since bridge 3's
windows are in the way?

But is it even valid to have a pwrseq node on bridge 2 without one on
bridge 1? If bridge 1 is automatically controlled, then I would expect
bridge 2 to be as well. E.g. I would expect bridge 2's reset sequence to
be controlled by the secondary bus reset bit in bridge 1's bridge
control register.

And a very similar architecture like

    RP
    |-- Bridge 4 (pwrseq)
    |   |-- Device 4
    `-- Bridge 5 (automatic)
        `-- Device 5

has no problems since the resources for bridge 4 can be allocated above
those for bridge 5 whenever it shows up.

These problems seem very similar to what hotplug bridges have to handle
(except that we (usually) only need to do one hotplug per boot). So
maybe we should set is_hotplug_bridge on bridges with a pwrseq node.
That way they'll get resources distributed for when the downstream port
shows up. As an optimization, we could then release those resources once
the downstream port is scanned.

> Proposal
> ========
> 
> This series addresses both issues by introducing new individual APIs for pwrctrl
> device creation, destruction, power on, and power off operations. Controller
> drivers are expected to invoke these APIs during their probe(), remove(),
> suspend(), and resume() operations.

(just for the record)

I think the existing design is quite elegant, since the operations
associated with the bridge correspond directly to device lifecycle
operations. It also avoids problems related to the root port trying to
look up its own child (possibly missing a driver) during probe.

> This integration allows better coordination
> between controller drivers and the pwrctrl framework, enabling enhanced features
> such as D3Cold support.


I think this should be handled by the power sequencing driver,
especially as there are timing requirements for the other resources
referenced to PERST? If we are going to touch each driver, it would
be much better to consolidate things by removing the ad-hoc PERST
support.

Different drivers control PERST in various ways, but I think this can
be abstracted behind a GPIO controller (if necessary for e.g. MMIO-based
control). If there's no reset-gpios property in the pwrseq node then we
could automatically look up the GPIO on the root port.

> The original design aimed to avoid modifying controller drivers for pwrctrl
> integration. However, this approach lacked scalability because different
> controllers have varying requirements for when devices should be powered on. For
> example, controller drivers require devices to be powered on early for
> successful PHY initialization.

Can you elaborate on this? Previously you said

| Some platforms do LTSSM during phy_init(), so they will fail if the
| device is not powered ON at that time.

What do you mean by "do LTSSM during phy_init()"? Do you have a specific
driver in mind?

I would expect that the LTSSM would remain in the Detect state until the
pwrseq driver is being probed.

> By using these explicit APIs, controller drivers gain fine grained control over
> their associated pwrctrl devices.
> 
> This series modified the pcie-qcom driver (only consumer of pwrctrl framework)
> to adopt to these APIs and also removed the old pwrctrl code from PCI core. This
> could be used as a reference to add pwrctrl support for other controller drivers
> also.
> 
> For example, to control the 3.3v supply to the PCI slot where the NVMe device is
> connected, below modifications are required:
> 
> Devicetree
> ----------
> 
> 	// In SoC dtsi:
> 
> 	pci@1bf8000 { // controller node
> 		...
> 		pcie1_port0: pcie@0 { // PCI Root Port node
> 			compatible = "pciclass,0604"; // required for pwrctrl
> 							 driver bind
> 			...
> 		};
> 	};
> 
> 	// In board dts:
> 
> 	&pcie1_port0 {
> 		reset-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>; // optional
> 		vpcie3v3-supply = <&vreg_nvme>; // NVMe power supply
> 	};
> 
> Controller driver
> -----------------
> 
> 	// Select PCI_PWRCTRL_SLOT in controller Kconfig
> 
> 	probe() {
> 		...
> 		// Initialize controller resources
> 		pci_pwrctrl_create_devices(&pdev->dev);
> 		pci_pwrctrl_power_on_devices(&pdev->dev);
> 		// Deassert PERST# (optional)
> 		...
> 		pci_host_probe(); // Allocate host bridge and start bus scan
> 	}
> 
> 	suspend {
> 		// PME_Turn_Off broadcast
> 		// Assert PERST# (optional)
> 		pci_pwrctrl_power_off_devices(&pdev->dev);
> 		...
> 	}
> 
> 	resume {
> 		...
> 		pci_pwrctrl_power_on_devices(&pdev->dev);
> 		// Deassert PERST# (optional)
> 	}
> 
> I will add a documentation for the pwrctrl framework in the coming days to make
> it easier to use.
> 
> Testing
> =======
> 
> This series is tested on the Lenovo Thinkpad T14s laptop based on Qcom X1E
> chipset and RB3Gen2 development board with TC9563 switch based on Qcom QCS6490
> chipset.
> 
> **NOTE**: With this series, the controller driver may undergo multiple probe
> deferral if the pwrctrl driver was not available during the controller driver
> probe. This is pretty much required to avoid the resource allocation issue. I
> plan to replace probe deferral with blocking wait in the coming days.

You can only do a blocking wait after deferring at least once, since the
root port may be probed synchronously during boot. I really think this
is rather messy and something we should avoid architecturally while we
have the chance.

--Sean

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> Changes in v4:
> - Used platform_device_put()
> - Changed the return value of power_off() callback to 'int'
> - Splitted patch 6 into two and reworded the commit message
> - Collected tags
> - Link to v3: https://lore.kernel.org/r/20251229-pci-pwrctrl-rework-v3-0-c7d5918cd0db@oss.qualcomm.com
> 
> Changes in v3:
> - Integrated TC9563 change
> - Reworked the power_on API to properly power off the devices in error path
> - Fixed the error path in pcie-qcom.c to not destroy pwrctrl devices during
>   probe deferral
> - Rebased on top of pci/controller/dwc-qcom branch and dropped the PERST# patch
> - Added a patch for TC9563 to fix the refcount dropping for i2c adapter
> - Added patches to drop the assert_perst callback and rename the PERST# helpers in
>   pcie-qcom.c
> - Link to v2: https://lore.kernel.org/r/20251216-pci-pwrctrl-rework-v2-0-745a563b9be6@oss.qualcomm.com
> 
> Changes in v2:
> - Exported of_pci_supply_present() API
> - Demoted the -EPROBE_DEFER log to dev_dbg()
> - Collected tags and rebased on top of v6.19-rc1
> - Link to v1: https://lore.kernel.org/r/20251124-pci-pwrctrl-rework-v1-0-78a72627683d@oss.qualcomm.com
> 
> ---
> Krishna Chaitanya Chundru (1):
>       PCI/pwrctrl: Add APIs for explicitly creating and destroying pwrctrl devices
> 
> Manivannan Sadhasivam (7):
>       PCI/pwrctrl: tc9563: Use put_device() instead of i2c_put_adapter()
>       PCI/pwrctrl: Add 'struct pci_pwrctrl::power_{on/off}' callbacks
>       PCI/pwrctrl: Add APIs to power on/off the pwrctrl devices
>       PCI/pwrctrl: Switch to the new pwrctrl APIs
>       PCI: qcom: Drop the assert_perst() callbacks
>       PCI: Drop the assert_perst() callback
>       PCI: qcom: Rename PERST# assert/deassert helpers for uniformity
> 
>  drivers/pci/bus.c                                 |  19 --
>  drivers/pci/controller/dwc/pcie-designware-host.c |   9 -
>  drivers/pci/controller/dwc/pcie-designware.h      |   9 -
>  drivers/pci/controller/dwc/pcie-qcom.c            |  54 +++--
>  drivers/pci/of.c                                  |   1 +
>  drivers/pci/probe.c                               |  59 -----
>  drivers/pci/pwrctrl/core.c                        | 260 ++++++++++++++++++++--
>  drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c          |  30 ++-
>  drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c          |  48 ++--
>  drivers/pci/pwrctrl/slot.c                        |  48 ++--
>  drivers/pci/remove.c                              |  20 --
>  include/linux/pci-pwrctrl.h                       |  16 +-
>  include/linux/pci.h                               |   1 -
>  13 files changed, 367 insertions(+), 207 deletions(-)
> ---
> base-commit: 3e7f562e20ee87a25e104ef4fce557d39d62fa85
> change-id: 20251124-pci-pwrctrl-rework-c91a6e16c2f6
> prerequisite-message-id: 20251126081718.8239-1-mani@kernel.org
> prerequisite-patch-id: db9ff6c713e2303c397e645935280fd0d277793a
> prerequisite-patch-id: b5351b0a41f618435f973ea2c3275e51d46f01c5
> 
> Best regards,

