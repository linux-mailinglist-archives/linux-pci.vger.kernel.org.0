Return-Path: <linux-pci+bounces-36311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0372AB806E2
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 17:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9F587B291E
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 03:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED49D27874F;
	Wed, 17 Sep 2025 03:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="riApcGlx"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F4626FA5E;
	Wed, 17 Sep 2025 03:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758079279; cv=fail; b=aPJayxpHvaZbD3ZtZelmzYNV2UIlNKgXFdLelTOqiVxaTgWhnRsffcdsWugDmvtVw/NpBbDW1DDFv14qXjtOY99O9S/HIXOLwcopUWTn9tnzpP2rpOLmKfwEryTgUeZomLBkYTBUkkXi5Zx9JOUhXgzJE+JQ2rTJs4a/VbgMoOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758079279; c=relaxed/simple;
	bh=J+kVYqjMIt2S10ZIqnS1Bi69yC2yJLl9RHiNoOORk94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EY1hgvZROAVgPwsURiqM7ysExi+65xcFeHAb5huk9qJxnf1VStkOCKuNh9b6qmbjwgdMVXeRvMHspSGpCmZndISZRcHWT4ghTTZSNQ6rcDwHoQGIbEh0xcAyBIiwHmFRrgDhtZmxC5H0ySm88lbYfkw61GQT7SA3TXcFCYhOw2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=riApcGlx; arc=fail smtp.client-ip=52.101.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CBGQMzKNngFz4xoXQpD1Tz6lPaFm+fy60Q1h9IyXJMcONu8tHZs7i8at+3ge17uItcPY7Bhb+aGIVwc+GBdVUgrAXNDbUbT9+bfTREzghwyL1OkMz5jf7XH5+HWgGKfZnTladq9xtIkA9wih4tOqSNvUr7ucCr22ZQq2GqIkPWwgHUtYzsNldtvlg9d7NBKN5m/TpSN2pZZ+ddsD0yMTA9zkh2MGULaS0VY3U284bkvUr5ow6OmVcLolAQzaVlakrftUKwpYVpHS3WKFrUCaw8GqlLZNDCT1N2lI+QGI+uyG9RXO2MuRwFV+xWOkeznth3f+CEuWD29QbbYhqr2A4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y297DNKXnGPYeabsTndoff8kk6meZO3xWRXaQEXsYpw=;
 b=akJTRxvqIISyuwgXQdOsqVfZxhRcwk+lLEJ2BSYP+oq7dDTfZi0Egbjzyc91ileSzl8ztDjQxuc4TWopJs4aojuVB7IDyuoAZrabwVD95RngfLMOr+h8qXCtGP3vE8/5XNFA1g66fPf2Wjr+B/zUCLpJY9ByQ38pu9hKRG0l0mHW+5jzh2joIZ3pSMjJhQlqeDdixoBXI4FQ51/ikZHUdG5og+DltCxUsSkAVLPmXQLurUUfFDzqC7M8DRzKw7vDWDbqIOAyf+PMVTKJh6HCQdP83pfXQt1/FtwgNsmej7Fr36CfBAuRUfiUlo3JPO3OG3ZKUXBCagMrmCB2i7H2FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y297DNKXnGPYeabsTndoff8kk6meZO3xWRXaQEXsYpw=;
 b=riApcGlx4LHILChMl4a3r0xgthEcBSiz7oa/ZWY+xqzMsa9Zb1O99ipa4yPoenhg7yEb2VhSt2oPScZmUxTdQnVmh4T6F35evBdUgf/lyTPMwMCWby6JUlIC2lJ/KaprLGiGvJRjhSFlIn60lTUNCbjWb25W+WoNpfCVTx/PGGcRAioj1sTtXPrx+nSdD2EbW9SevBHWZUcUx5fHqHnbfrovbg25U2SS+AZZR3n93pzCkgBC259ZvvCejsjGGqLVAhKWJCxfHcif4yVoxEZPDrR7gLv6UTSAvnYJvRPPz2g2ZAi+1zYo59Fy3fyQ6ZWY02cxd0BBGQWa5+4nymw6PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) by
 SJ2PR12MB7943.namprd12.prod.outlook.com (2603:10b6:a03:4c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 03:21:15 +0000
Received: from DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11]) by DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11%6]) with mapi id 15.20.9115.018; Wed, 17 Sep 2025
 03:21:15 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 "open list:PCI DRIVER FOR NVIDIA TEGRA" <linux-tegra@vger.kernel.org>,
 "open list:PCI DRIVER FOR NVIDIA TEGRA" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, Anand Moon <linux.amoon@gmail.com>
Cc: Anand Moon <linux.amoon@gmail.com>
Subject:
 Re: [RFC v1 2/2] PCI: tegra: Use readl_poll_timeout() for link status polling
Date: Wed, 17 Sep 2025 12:14:44 +0900
Message-ID: <23013855.EfDdHjke4D@senjougahara>
In-Reply-To: <20250831190055.7952-3-linux.amoon@gmail.com>
References:
 <20250831190055.7952-1-linux.amoon@gmail.com>
 <20250831190055.7952-3-linux.amoon@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0169.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::12) To DM4PR12MB6494.namprd12.prod.outlook.com
 (2603:10b6:8:ba::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6494:EE_|SJ2PR12MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: 287845cb-3a87-4f58-73e4-08ddf5994226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGxrazVRRzl1SnFodU1MdDE2b016bDJraExXY0s1UXBnUStkaVZ3YWhyRFlP?=
 =?utf-8?B?L3F2SG41WWF0SkpLV08yakZqQTkxMGsxTDlJTUk3QVczMDc5NFVNUDl4ekV4?=
 =?utf-8?B?M1dieTNTc1QwYkczcGVXaEo5cUtEZFhPNXAxbWkvWi9kTkkzaUxXV3NSQ1kx?=
 =?utf-8?B?bkJDMjRkc3lJdVdyUDExVHhodlgwVVkzM25nL3AyazBQcXlua2pDTmlEYlZ5?=
 =?utf-8?B?VU1PZHd1UU8rMVpOTGxoNXk3R2VjSDlCbWJDNERQZk9wTHhRWlhGWWpEcXpS?=
 =?utf-8?B?MVpYL0JCbXYvRlNBTEkza0xjbnprTkpmVzhuY0FVTHNQcFJFWDZvbmwyaFpD?=
 =?utf-8?B?M1VjaldpZ1NPVW1pUlJNOFN1dmc4NWpqYjkyQjVodmlUWXhUN01ubWhlbFpV?=
 =?utf-8?B?SjVDbVdYQ2tpYnZCUTVzNGVoYWN3cXIrYmVkaks2RlBkblhITkRZRVdKbVNw?=
 =?utf-8?B?SzFpcUNBY044MVhKYmtNN1FmVGVUa0xlSUFDQVRrWDlPbWJTcWRGOFhzSUcz?=
 =?utf-8?B?MzNkelNlajFsNFB2aXA5b2xodm9Yd0w1NThVWk9DUTBoWEdTbUZLQ2ZNc1Z6?=
 =?utf-8?B?NTJrMnpLcW9BVGI5VWhTU0FTRkhyV3MyaXpIMFRVUncxOVF0aUJsY21XNWZx?=
 =?utf-8?B?MGF4WExlNFd6NnBSS2FMYW8yNVRyQlZQVS9tTTlPQm1wT0lCcUZ0cklHRmVJ?=
 =?utf-8?B?WU1vSWxUVDdpWWd3Q0NxM25MZlo0S0pVN2FtWFJXbWdHbHk1b2k1UEdkSDNt?=
 =?utf-8?B?RkswWjJUb3hZSW5rWGRTZnEvTmttOVZSVGw3OUxYT2FBNENIWVNYZE1EM1Qz?=
 =?utf-8?B?eTQ3ZE0xSFVta3ZhOVVQdUQ3eEdmcVc4ZTY2ckNST2N0WXJQYzVTdURBM0JI?=
 =?utf-8?B?UHcvSFpsT295UWYxRnBmQWtsRE1WemhrQk9DeGJtc1hPd1BBSk1Hem80amY0?=
 =?utf-8?B?cDlDY05kL0VvT2dtQXdXdUZvejlma3NRYittaG1HaDRwMVNrdjBaWFR2YlJt?=
 =?utf-8?B?SDFVYVNYUS9TMkpVSFErV3AyRHU3VUZGaEFTOGFkUzFORWVoaFdRb05RZllr?=
 =?utf-8?B?VnJWY0tPTGFMcEZXWTMrY1Y5RzVxUGpGNXAreWY4ZWJGaUR1WXdvTVorWFVq?=
 =?utf-8?B?U2hSRXNtOG9ERGZhaDVpaHBub3lJU3B5K09DR0haWERVdVNwdnVaamhpM0hs?=
 =?utf-8?B?UDlESTdVRFlDTjJ3Uk14ZzcvcDZqRkJDeFZlQWl6VURJa0R1SGcrRUI2bHJw?=
 =?utf-8?B?Q3ZWcmFLbFdJNVdCYlQ0dE43TlNqK00weXdEcE1DRWdtczUzTG11SnhNUTBW?=
 =?utf-8?B?Z2hpVC9EN3NVamNaQ2NDOTFJZDFFdWJ5TVdEVFcvaUgvNjBmU005MWhkSTdC?=
 =?utf-8?B?UmNvNFVyVE10dTdWRXFFOUlHOVZnRm1OU2w3RlpmcmRJRFhoY3lyWm1JOXZH?=
 =?utf-8?B?TktPU1FmRGNmZktncmJVS1BaZFlaWGFRSXhNRVI4NnUyaFYwVzhka3BacVBE?=
 =?utf-8?B?UjZQTjlxN1BpQ3JUWDZmd0lIS1Facml6L04xSmswUno5RWVhMlQ1TUh5SFpi?=
 =?utf-8?B?Ny9XeVB3WTV4OCt6bnZGSjFObXR0TVB6OWt2NnM2ZVJsU2hybjNTNHFoZlA0?=
 =?utf-8?B?MWo0UDg5UHBFdWwwamdYUDYxbzBaVVlYUmIwMjFQRk01OE1VOVZxd20zUlRs?=
 =?utf-8?B?TzdTY2lpU3VGU1E3WWNWT3FmUmVrWjI0UXRLcWlRc0MrSVR2NEdOYlJCeEpL?=
 =?utf-8?B?d05oK1drQm1GVy92cy9SWGhaKzAyWWRHSnJvOFE1YjZzSTJyWkwyOUVSclJy?=
 =?utf-8?B?YjNlYkpqaHl5UFFXYlJCVTJWK3NJNmJZU20vWGRWb2JrTjdQRmtnOE9vNVFI?=
 =?utf-8?B?TSsvT2x3c1gyMS9VWG5ISm9Pdml0S3RKbHFYV1pPR3h1cFhNaVFjMnhlSUc1?=
 =?utf-8?B?bld6RG5zRHg1ZEtwY0JyZlNsa2Fhc2h1RC84RHNZREZZK2pNMmZ5dE8rNHpo?=
 =?utf-8?B?UE5wbzlDM2JRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2k2NVJEU0lCajZWcHhheFdVQXhkTXUzNzFXMzZkK1Z4YUFkTWFPN0J0ZTRS?=
 =?utf-8?B?dkVBUWhsVFFPNXp5Q0JGb1h2Nk93cWNnemxXN25uYzg2RHFzaVZ1dmR5aTRL?=
 =?utf-8?B?N0hoWFM2QmozZWdVbGU5L0xvSnF2Rk1sL3RoYjc5d3NVeEg5cVh2SzAxblNY?=
 =?utf-8?B?Mlo3ZjA0Y0FBNmJYSnBBOSsyS2M0akhadnpxWHllWXZDekJLZ0VYNExXRFF5?=
 =?utf-8?B?dmVLaUpVclFLMGh5eFBXWkJhM0hGNGRWdE04R1NEVHFGSHdIUmhab3E0bGl3?=
 =?utf-8?B?TEhHQTFyNGUrdEpBTEVqUExPajVBNWM5L0M0RjVLVUVvSVM5eHFrR29lNi9H?=
 =?utf-8?B?UHB3TzA2T0N3bkVobGJlRm9QTzhYcWtmaFBIczB5dElVdFl1SHVyQk5mOGxU?=
 =?utf-8?B?MzA0TW5lT0pBUE1wY1ZiUVlKczFncHFsUU1TSnk0S050QkVnYVozVTg3WVhn?=
 =?utf-8?B?d25Cd05TcVo3STBsUDJzQzNCS0ZzVlVyanhFS2prT3JOWmhJK2tFU0tRZE9D?=
 =?utf-8?B?MkUyaXVlVU0zS1dicXZWUXBXK2E2NVE5Nmp4WlZQRzhKYW45NVNtZkJRMGdr?=
 =?utf-8?B?YWFUcFJteC9IZ0ljSXJUWFlGL3V4WWhkTmtEbFluMzJXOUVwN1pHSE8yNE5w?=
 =?utf-8?B?ckRPRDZjeTVNdCtNcDlSY0YwYWJIK1BROVc1N2FWMndUSCs0blA0allITjA0?=
 =?utf-8?B?ams1NnNjZ1hKcGNHVGpTa29XOUFoL2draVFIbVJMd2JwV2p3UUFzbkJhY2M2?=
 =?utf-8?B?R04ydmpvdDd1bGVUbW5SdE05QUplZDVzd2llOHhmYmNPODJhdFFpa0NtL0Jo?=
 =?utf-8?B?OFprcXFETHFxQ1JENDJHcHNXcUpaTjVtRlJuUGNreFdQdTBKcnhSd214blZW?=
 =?utf-8?B?bVkzU21OTEEzL2NsSnVlMUdvTEdSamRHZG5tRWtJZjZzczFHZnNHRFhsdkNk?=
 =?utf-8?B?VlBRcnFGaG1VNHBpTjdlanR6S2dEUzJFM3JlT2tLOXYvSC94aVVndjVSUlB6?=
 =?utf-8?B?RjZxOHJtWTBJeXlXSVBXVDBqeStibmRUczRZL3BBM0dVN2JTM1RxcTAzS2Vi?=
 =?utf-8?B?WE94blg0dVFnaElncW0ydzZNZityeUhkaG5EY3hyL0l5NGRKMGVMU1ZNeXdU?=
 =?utf-8?B?bXJHR3c3V25uYWlESnkzaEsvMXJhUitNdFA4N3I4V0JOaHhuSzVqanAwRE5I?=
 =?utf-8?B?Rkd5MVZLeUlXdHZzYkRUQ3V0RVlrRmE2OWFsM250SHVpaUhINGtrSVJmZ1d2?=
 =?utf-8?B?eGxINnlOVEhNa1FhRDNRbGRVZS9OVk9pL24vVmJOQ1Z2UTExQzh6Nm9tT2pu?=
 =?utf-8?B?WU96V1I5cXo2bjNrQjBmRXpBNWJud3BYK3lzZWNPR2FYOEJSOFZQWWJyczhk?=
 =?utf-8?B?bVVWd2xnYjN1YVBEeDA1eVVobVBZTU8xTndhMkxld05oKzRnNWtXVGZuOElz?=
 =?utf-8?B?ZkJBZm5VdEp4OEc2RzBYYTF0V1ZXMzNGWkhrSzJsOFpteFNWb2ExcHpKTkF3?=
 =?utf-8?B?Y1A0OEs1NndiclhFSFIzWXNuRzRXMzZ4dWs0bCtFaTN6azdweWlkVVVlOW93?=
 =?utf-8?B?K3gyN2YzTGJma3lxejhsY1A3NjcwMnIvT1ZKbkQxSC9xSzVXVjFjcDM1NVM1?=
 =?utf-8?B?VTVXVDBYSGZkd3d6bmV6NGdxL25IYW9zVHhWa3prQXAxVjJMRHdxVnVKcU5U?=
 =?utf-8?B?NmEyWklFcktmWlM4WFB3b01ZOXQ3UDk3NmUrQUJESzRUQnB0L0hDWDl3N055?=
 =?utf-8?B?aVFpMSswZituNGF1TjhXb0tjNXAxRThKMVZpOGxpUE5ncFp3SytLcEtEY2t4?=
 =?utf-8?B?d0hIaVFQWU9TK1NFVmVGQ3B5eDFuNUlkRzdKeGZHalJ3cWpYWDZOclFwWCtI?=
 =?utf-8?B?RG5WcWVGRnFETGxuYjdYdXVES2syWWk1NUpWMUtmT1gzeFJmK3hJMFFXR3Zs?=
 =?utf-8?B?QzI0QVZhMjJseEQ1dmFrcVA5NURKNmpNQURZRmRzVVcvd2JVZE14NXlaeVV0?=
 =?utf-8?B?Q2dFRDFmV1NmZTl1QS9jcW1KZFpQWk1GT0sra1RpRHJqUmZkNkZHMmdwdHB4?=
 =?utf-8?B?TzMxQzFlTjl5MGNVbnNhWkJxL2UyVEVtSmxCT2RZcXdJY0ExMlhIVUE2RCtP?=
 =?utf-8?B?MkZTa3RqclBJNGgrOHJNcEpmWWVsb2paMVFVdXBCRGRONVhZNjk0VmppQVFX?=
 =?utf-8?B?QUo4SkFYZTJDWTRYeCtwNHBBVFl3VVQwQTA2T2ZKc1pYNHp0Rml1ZnpoOG9r?=
 =?utf-8?B?TGhLUDZYTW4zMkdnOU1MQi8xUDZBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 287845cb-3a87-4f58-73e4-08ddf5994226
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 03:21:14.8152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlK8t5Rhl7rJN5YIEOosGIIzx4Wesi4mOTJOMu2C0dTSFyEltorGsPjLCnjcY9aTaDrhSvbrUTKvgBv/ylLUnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7943

On Monday, September 1, 2025 4:00=E2=80=AFAM Anand Moon wrote:
> Replace the manual `do-while` polling loops with the readl_poll_timeout()
> helper when checking the link DL_UP and DL_LINK_ACTIVE status bits
> during link bring-up. This simplifies the code by removing the open-coded
> timeout logic in favor of the standard, more robust iopoll framework.
> The change improves readability and reduces code duplication.
>=20
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 38 ++++++++++++------------------
>  1 file changed, 15 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index 3841489198b64..8e850f7c84e40 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -24,6 +24,7 @@
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/irqchip/irq-msi-lib.h>
>  #include <linux/irqdomain.h>
> +#include <linux/iopoll.h>

There is already an iopoll.h include in this file, so this adds a duplicate=
.

>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
> @@ -2157,37 +2158,28 @@ static bool tegra_pcie_port_check_link(struct teg=
ra_pcie_port *port)
>  	value |=3D RP_PRIV_MISC_PRSNT_MAP_EP_PRSNT;
>  	writel(value, port->base + RP_PRIV_MISC);
> =20
> -	do {
> -		unsigned int timeout =3D TEGRA_PCIE_LINKUP_TIMEOUT;
> -
> -		do {
> -			value =3D readl(port->base + RP_VEND_XP);
> -
> -			if (value & RP_VEND_XP_DL_UP)
> -				break;
> -
> -			usleep_range(1000, 2000);
> -		} while (--timeout);
> +	while (retries--) {
> +		int err;
> =20
> -		if (!timeout) {
> +		err =3D readl_poll_timeout(port->base + RP_VEND_XP, value,
> +					 value & RP_VEND_XP_DL_UP,
> +					 1000,
> +					 TEGRA_PCIE_LINKUP_TIMEOUT * 1000);

The logic change here looks OK to me. This makes the timeout 200ms (TEGRA_P=
CIE_LINKUP_TIMEOUT is 200). Previously, the code looped 200 times with a 1 =
to 2ms sleep on each iteration. So the timeout could have been longer than =
200ms previously, but not in a way that could be relied on.

> +		if (err) {
>  			dev_dbg(dev, "link %u down, retrying\n", port->index);
>  			goto retry;
>  		}
> =20
> -		timeout =3D TEGRA_PCIE_LINKUP_TIMEOUT;
> -
> -		do {
> -			value =3D readl(port->base + RP_LINK_CONTROL_STATUS);
> -
> -			if (value & RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE)
> -				return true;
> -
> -			usleep_range(1000, 2000);
> -		} while (--timeout);
> +		err =3D readl_poll_timeout(port->base + RP_LINK_CONTROL_STATUS,
> +					 value,
> +					 value & RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE,
> +					 1000, TEGRA_PCIE_LINKUP_TIMEOUT * 1000);
> +		if (!err)
> +			return true;
> =20
>  retry:
>  		tegra_pcie_port_reset(port);
> -	} while (--retries);
> +	}
> =20
>  	return false;
>  }
>=20





