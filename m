Return-Path: <linux-pci+bounces-20894-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22761A2C3E4
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 14:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50D816B881
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 13:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A4B1D61AC;
	Fri,  7 Feb 2025 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iQxm6oGo"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801C21E5B80;
	Fri,  7 Feb 2025 13:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935548; cv=fail; b=edO6Fah7Ec4uu6VBVWyJ4fSH3wqZAW0I6xxUoBCU/6Qo1NIEe8CLj8lb3VtE3gxxupffC5Suaf9PxVMfsbOYRnowIJXD9ikft05iD/B1erJD+o6q+AguYzJEXFyCU/DkaZ+rDamk0kjagQ57SMTzBAV1vRSo1ZfJtMgGNRDktQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935548; c=relaxed/simple;
	bh=xFKKpdtnFOFHWh2Y/t3QOOA3AzPF7/6kZBhfSTSoCDo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dKH/QZU9vxkCC7TUr0cbt6tMh667DsOKthqp3Remps5ygyAdYAVqm4XHMj6A6wrgsmoxnH+//ZJirDfmGDSZvkguPsdIKODr2sSEoaiXMjIGfllP48ltH/H+W/qML9tVo77wL+5oUMrYjSQXuYrW9WlWalRIGKCHl/mvSNUUnYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iQxm6oGo; arc=fail smtp.client-ip=40.107.95.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XcO3SBGfIZN6lmZ/J3JNfjUmSMeGYheipttpALEMzVJ6uzlK+I7APSJICBwQeszuBtopjB5ye69hlyMb4u5dy8BhTzT5pgURDZmkvdnJCpYIaEv50rjnA8NjZCF5dkDQ+rWJCg/gt8KoUmCr2ecVCFizhZNq0a6DPFAt9kKIeN/bZrTrY45mXQbiltizM4pMVscS5PYvUJwKBarE+DZRN+jSmXgdBK30VekyV3AWWXh06pQqySHuihOhM5z4i0rLO1qhkCiN9WDW9usRyNOkTOsZo8iP/fx/S6hkgUlRxytL2k9V68k3v3E87ySIUOK1d3CEY1REkHfHJnKmeBL0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APdtMEymnlOxrCf2khjDustK0rVZn4HHAgTIkMEadtE=;
 b=AeGVMOcT2usRf+/7NTx/fhy8tG6eedb/o8/pdPzb0PQAieukfn8NRthIee2YoV1LwPOCXki3VTLufCA89uFLKkBwiqs7R23O9piyZQhvAZnWtRIaLfjXCEHaJ3yBMMHLkJPujnMEoLKuBxToY3WD74d9vrp2S2hqAh39Ku5k8taozlFBjpHp/0xMdUT5gp8RnEFAuZ3PZDFwU6vFxTq828UvWhdUkYJQRqtcgalFoxb4bZiI3bRc7My7C/gTiJjXj7Jp4sraFICaFO2vVAfDg9VR5Zhl6cYOoyL0Bk50//rk8+gRZzMPkdL10oN6VlOmoMwyg4zUMlUJ9zHDMVFQxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APdtMEymnlOxrCf2khjDustK0rVZn4HHAgTIkMEadtE=;
 b=iQxm6oGo9GKXv50pUb/ZA4D6Ubt1gr/Sz3EJ5Ofjg0BUWs84J2RmCnK3W6q9pVqpdMlhOZeB0Ih2RHFvGVsKN+zeXutL4Vd3NAEgksm/G5cNXsdy5nM+i7lZ9l5fdEUGiHaKr+w8zsUTCktNbbXI3xHaXBRO/zzaAm+5RdCdyW8vyndFgaXsMHEjWxz+xJArPJcurEC03j7WlOkA7gOzPXICN0V3jsqwBeqoc2kcJO4SiFts3ixnQWGF6IyFgTnZgMaGCEZiakqionHanhQ0u3Y1/NCoE3iKD9jL6gV4tZ94Wqzd3cz46UcJ0vWrZkl+L6gTiobwThgv+zIVf667zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DM4PR12MB7621.namprd12.prod.outlook.com (2603:10b6:8:10a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 13:39:04 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%5]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 13:39:03 +0000
Message-ID: <1c2433d4-7e0f-4395-b841-b8eac7c25651@nvidia.com>
Date: Fri, 7 Feb 2025 13:38:58 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PM: sleep: core: Synchronize runtime PM status of
 parents and children
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Bjorn Helgaas <helgaas@kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Kevin Xie <kevin.xie@starfivetech.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <12619233.O9o76ZdvQC@rjwysocki.net>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <12619233.O9o76ZdvQC@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0047.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::35) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DM4PR12MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4da4fa-7795-4d61-8062-08dd477cc960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEd2TVZKRXJXbDd5VFZTMnF6N1pyQ1ZlTi90WFZIMWQ3djZYWnQzaENrcXl3?=
 =?utf-8?B?TG80a3NLMVJORXhVdGw1b2FMa0h1TE10YXdiT05ESVRMblZlY2cxOXlOUnF3?=
 =?utf-8?B?eXpqc0c3ODZBekdPMjdjVXdVTmJMbEgrWHo0a1UwTSt1QTMxc2N3eTJqcXlx?=
 =?utf-8?B?bytIYk1WL1pLdEowdFFwTzdxb3NLM3JNYjJKTlMrS0RhaFJNY0RUZ2ZJeGdm?=
 =?utf-8?B?U0Fzc2Z2VnRjNUtJTklucXVwUlI1L1hudkdWRmZJc2lPLzdHT3R4MUphT3U4?=
 =?utf-8?B?SHZmbTdDTzk4MmxsZFJGZmZRejRmQi9KOGdhODgrQXFVSVk2bW80bTlRVG9W?=
 =?utf-8?B?OUZNS0RWcEZ1V0c0dmZIRG50d2FJVHd5ZFg1OHNELzNhSkpxbVlGNlhaOGZS?=
 =?utf-8?B?S3pGZU5SQVAwRmh5YXQwTHhqUmlrck1rdXoyYjVnRzNzTG14a3p1K1hsYnJC?=
 =?utf-8?B?NVpHeFZvRmdTVDF3bEdnM3M3YjhuL2ZxaTlNT3Y1UzRwQVhtS2VzeUdINFBT?=
 =?utf-8?B?WEpvdTNFZDNRUDNBK21xRGJxTHBBVjFPQXR4b1JYM2JXUGpxT0dWdnpuVnNL?=
 =?utf-8?B?WHFRRFNFQ0lsRWJiWjVSdXMrNmd6TjJjbGtvcWNhRS9BQi9TRDZhUjNweTEy?=
 =?utf-8?B?VzBNUHFPZXFmVTBnQzBWMFJ6dUhWTU9GUFpNbEd5WjgxdGRlWXVicjRGeStu?=
 =?utf-8?B?U1haOGJOREFJTkFmNGgraEdUallvWTBQQ1Fqa0Y3Q0FGTUVtaDB5N01yNWIz?=
 =?utf-8?B?TDVxdGswaEs3NWw3MGZUa01xQTk0aWFCRVZLeDVOdXVqUWl5WG1ZQXRlSy93?=
 =?utf-8?B?N2NHWjZ5dnd4L3FKOFF2czgwZlNWejhBNS9MUU1JbFM2ZXhCL3RmNHdTN2Ny?=
 =?utf-8?B?bmxvbE9hMTBZOTd0UE00eWY2aGs4cnR5ZDBOdThoZk1mN2lVRVlxRzBTSjNh?=
 =?utf-8?B?Vm1UVHIrRWF0cDFyRWd4ZXVUWE13VFdiSVJzSlN2a01wRlhxYjNlWFZJQS8r?=
 =?utf-8?B?WWFmK245S29jU0l3TStJbXVzWEd2YzBzelM2bXVHWlkvUkd3N0xFMmVlUkpN?=
 =?utf-8?B?NXorb3dwbVU2b3NoMVlzUXhRSngyNDgvTGduMzFtdmxpQzlkR2NYTENiVi9y?=
 =?utf-8?B?SEIyaXB1cG1QNHQ3YzVpVzJrTU9JWFdpYXh0VFNHaUxSMTJiaTlkeUQ5Mkxo?=
 =?utf-8?B?MkRJZUdXNFY3MnQ3dXcxMVBKUnIwQkJ4SHRvZkV4ajRkYjNXK0VNR2ErZjBt?=
 =?utf-8?B?LytRK0hBbFk4bWZjUk1pbHBIaEJRcDlzNEJZbnZWV0czSW53UkpTREc0ZFZE?=
 =?utf-8?B?RDBkQ1hBVzRkM280cWNPelRwYS9UZk5sK2hwZFhFNFkrN3FhLytWSXhXdWpN?=
 =?utf-8?B?KytIRG1wZVZuMlNuSXJvM0dWMlVtZ0VoQTZqcG8zQkJHOFFOODY0Kzc5Y1hq?=
 =?utf-8?B?SFQydWgrbXFQcitoSWxDWmdnT1BqNDlaRGN3cnVZV1ZvWGVxYnBlWGJFN2VJ?=
 =?utf-8?B?QmUySHpyV1J5ZkgwZUxHVHBDTFluWjNJRERKMHkvZGVOdTE3elNEUmZSWDRI?=
 =?utf-8?B?KzRZVUpBaUlWS3RBVitUUTJrcU1wN3N0alltOTF0Q0V0akxodnZZWlczN2NC?=
 =?utf-8?B?YXlDVkJFN3Z4WDdYU1dmekFVaUk0Q1diMGpCdC9BWWF1Q3RuVUlIU0dvaThY?=
 =?utf-8?B?OHoyKzB2YVNjTnJmTEtDbEw5U2hxQUovZXduZUNnYzNjKzJVaG9RdDRPdlNX?=
 =?utf-8?B?YVQyNkplSkcvQ0pJSklhQVR6aGJNRnVMMW9aNGJVeG4rbWdiY3BuaDUyeXZO?=
 =?utf-8?B?R2VTYWR1bzVpb2xFL3lvV0xjeldTaEN4Y0U1WnR4Zm5aTnY0QTNoSVhseExv?=
 =?utf-8?Q?TtMBny7SxeANw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDFUdmxnakM3V0d5cTNTNkpsNCt0SjdVVTBoeDRCb2JyN3l4S2FQeU0wWmxn?=
 =?utf-8?B?Zy9GMkZ2VTZieTEvWHRGTXNvMWZpSnB5S240dmZmbEFNVTdrYVA5cFZyV21K?=
 =?utf-8?B?Q1BuRWo1NlAvVTU2d21aY1NsMnNtNFZCVm51bHFCZ1dGalo4cXRkODBiTzV6?=
 =?utf-8?B?eFhyWFFobkIyZ3NFbXJzOWgwZmJ6WklGV1hKeFJoNkRscVErTGxITGRQRVkx?=
 =?utf-8?B?THNGUk5EMkhleHNaNitweTRZYWFpUVFSYzhnTk5CUTRhWi90OXB5b0ZuMDhJ?=
 =?utf-8?B?amNYaW8zeGJwcmQwWU45RzRBWUNCR2pveVJreDRVTEE2WjFQT3FYcnlNaGx3?=
 =?utf-8?B?eGoraEdic2tkYm11TC9WVm9RSU92Y3BEZFd5TVY3UXVoMHJPbGNDSTdhRVlj?=
 =?utf-8?B?THJ2YklrR3QyaSt5T2V1aENCTzZyd0lyQzlUc0Q5Y2hNeVpacjlLeUIxREVX?=
 =?utf-8?B?SFlxb2puaHZoSktxeWVWMmpWdmp2ckJUTm05Nk02UWc0eW5TdFl4YjhwSmNq?=
 =?utf-8?B?K1hBTGVXNDI4cHlCSVpPdTMzbTFmb200ck15VHpueStVdk8yWExFQWRTZjMx?=
 =?utf-8?B?bzJqY3QwZEFEelhIZ01MRUpNZ2pVZWtKUFRRWDBkUVE4bWJRM0RjUFlwOVJo?=
 =?utf-8?B?emNOSTJ5alJreTBYMzRKWmJ1ZzVDdGEyd3pVSlZBbFUvU282THBXNnQvaEk2?=
 =?utf-8?B?Ukh3TUNkbWFBMWFrSEYzYjcwcGUwMEdUeFJBeXpxYlFYd1VVbkpVZ0pRNHJT?=
 =?utf-8?B?ZEwvMk5xOXVwQVA1dFRLMUdmeGdQcE8rQ3N3UjhpSVZ0bjhkaUJ6VEdWN0FE?=
 =?utf-8?B?bmM3VnBaY0xWYTRNZjhNMGpYYjZlUjVvNmsyaEd0blMybEdreStaWXh3VUor?=
 =?utf-8?B?bjJ1WW5OTWpzcVNCTXBvdjV0Vmlucmd1WGhWcDBEZDJOODFFaFo2L1UzVXIw?=
 =?utf-8?B?Y01rL1ZtcWN6d1V1M0w3RFJDVWxVd2tYWWFadEYvaWNTM1lSV3VyUmFaUHhl?=
 =?utf-8?B?c2g1NDd4U1lVaEZocVJPa0NJb2xHbkkyc1ZJbEwzT2RYZmY5Rml4cHBvTjRE?=
 =?utf-8?B?Um9BeWNyNWZDVy8rd0xjT3NKVmJ2VEZoVTdaeUpsNXgvdE50THM0U3FZdlkr?=
 =?utf-8?B?UWFLTy9nWnluVkw4bUtxQ2FMSzlRQlBNSGxpbGR3MFlPR1YrOFRPLzJZaFRp?=
 =?utf-8?B?cVB4OGx5OStaTVJoNEhWZEpTOC92MXNjN2dXdVE5bVJiWXVyZnFKaWZpU3pm?=
 =?utf-8?B?SmVZcHBWVllxaDZNdXRJeTdFSHg5bThvZ2lMYlNqS2p4NUYwR3Rod1IxNzgv?=
 =?utf-8?B?aUptaHdHelpBblM5andCVksvQXV1bysvQWNueHkvYVJvRmM0blRQWGZFaVA2?=
 =?utf-8?B?dUpONUR1SjFsT3plMmhua1N4MzNONzc5aVYxTkliNHJUWWhia0dPSlpRbHMv?=
 =?utf-8?B?MUlIeFljYXlkdGNGMXRLaGRoM3VpVFlrblhPU2pNclFSV1UvbXlKYmdJUkJy?=
 =?utf-8?B?TmlhT0xnV0tnY29nemVXTUJXZXk2cFQwYkpIMlNPalZtUE5uY1lteDBPRFV4?=
 =?utf-8?B?NmJmeWNHbG95SFpCTVkzdWNWRVMyNHZoTWo3YlVjRSszeklJYXRqQnN4VDYw?=
 =?utf-8?B?bml6K3BZTEhoVThOKzZvY0tNV09OWFZFVVdiaHBRdXRkLy9PQkw0YjZnd2pT?=
 =?utf-8?B?UGQ4Wk80WHhuMUZCSjlsOEo2SUtMbW40b0pPTnRyL3p3UTh3dzV3b1ZiQ1VW?=
 =?utf-8?B?RE5kT1IrNlBJQU9HZ0hTUDY1VU56N1U4L0hPaVllMlgwMDhtMGdjdVNrVHFG?=
 =?utf-8?B?M1dlWHlkSG50eTFoNTBhNC94TE5YTjRjTzJCblEwZHdtVGcvWHZxMW5xaGx4?=
 =?utf-8?B?ZEI1V3M4UHFPQ0FhUHl1ZDQvaFZKeW9OaE43Z0VjSjBPTXdHa09kOUY0Qkox?=
 =?utf-8?B?ckp0aXZ3enR3MUt3enVlc1hOUDJRN1krNlVKVjIvM0R0ZkVHR0djZ0dZVkdx?=
 =?utf-8?B?WjZtcmNnUGhTRDd1akVBMG9zbXdGRjJpdjF0TW5oaWYwcXJZUjkxRW15LzRw?=
 =?utf-8?B?TFB0L1h6WjIyRFFxMzlnQ1BMc3N6NVNlbEZlaDdic0l4VFJnNlk2eURqT0dy?=
 =?utf-8?B?b2ZCSGxyODFydFQ1UmR2aTdrcDQzTHZFb3ZLUG9ITlQrODlJUXphaGJYeUVC?=
 =?utf-8?B?QVY2VE0rTWxLV1FqQ01pMEgwWVJBVXNpTFdwZzFoWldWNWVWdUxMY0xQazNX?=
 =?utf-8?B?RjV6bjd5VS9ZM0FFZHZoR1E5OUdnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4da4fa-7795-4d61-8062-08dd477cc960
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 13:39:03.8422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4DlZDiRHBqmETuO2/+VmhIzw/UsCA3gCZghDfZdpt2W0srndJeS7fiKeJP4Mhw02VMH/aDWwfdu6dsklArdHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7621

Hi Rafael,

On 28/01/2025 19:24, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the
> resume phase") overlooked the case in which the parent of a device with
> DPM_FLAG_SMART_SUSPEND set did not use that flag and could be runtime-
> suspended before a transition into a system-wide sleep state.  In that
> case, if the child is resumed during the subsequent transition from
> that state into the working state, its runtime PM status will be set to
> RPM_ACTIVE, but the runtime PM status of the parent will not be updated
> accordingly, even though the parent will be resumed too, because of the
> dev_pm_skip_suspend() check in device_resume_noirq().
> 
> Address this problem by tracking the need to set the runtime PM status
> to RPM_ACTIVE during system-wide resume transitions for devices with
> DPM_FLAG_SMART_SUSPEND set and all of the devices depended on by them.
> 
> Fixes: 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the resume phase")
> Closes: https://lore.kernel.org/linux-pm/Z30p2Etwf3F2AUvD@hovoldconsulting.com/
> Reported-by: Johan Hovold <johan@kernel.org>
> Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/base/power/main.c |   29 ++++++++++++++++++++---------
>   include/linux/pm.h        |    1 +
>   2 files changed, 21 insertions(+), 9 deletions(-)
> 
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -656,13 +656,15 @@
>   	 * so change its status accordingly.
>   	 *
>   	 * Otherwise, the device is going to be resumed, so set its PM-runtime
> -	 * status to "active", but do that only if DPM_FLAG_SMART_SUSPEND is set
> -	 * to avoid confusing drivers that don't use it.
> +	 * status to "active" unless its power.set_active flag is clear, in
> +	 * which case it is not necessary to update its PM-runtime status.
>   	 */
> -	if (skip_resume)
> +	if (skip_resume) {
>   		pm_runtime_set_suspended(dev);
> -	else if (dev_pm_skip_suspend(dev))
> +	} else if (dev->power.set_active) {
>   		pm_runtime_set_active(dev);
> +		dev->power.set_active = false;
> +	}
>   
>   	if (dev->pm_domain) {
>   		info = "noirq power domain ";
> @@ -1189,18 +1191,24 @@
>   	return PMSG_ON;
>   }
>   
> -static void dpm_superior_set_must_resume(struct device *dev)
> +static void dpm_superior_set_must_resume(struct device *dev, bool set_active)
>   {
>   	struct device_link *link;
>   	int idx;
>   
> -	if (dev->parent)
> +	if (dev->parent) {
>   		dev->parent->power.must_resume = true;
> +		if (set_active)
> +			dev->parent->power.set_active = true;
> +	}
>   
>   	idx = device_links_read_lock();
>   
> -	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node)
> +	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node) {
>   		link->supplier->power.must_resume = true;
> +		if (set_active)
> +			link->supplier->power.set_active = true;
> +	}
>   
>   	device_links_read_unlock(idx);
>   }
> @@ -1278,8 +1286,11 @@
>   	      dev->power.may_skip_resume))
>   		dev->power.must_resume = true;
>   
> -	if (dev->power.must_resume)
> -		dpm_superior_set_must_resume(dev);
> +	if (dev->power.must_resume) {
> +		dev->power.set_active = dev->power.set_active ||
> +			dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND);
> +		dpm_superior_set_must_resume(dev, dev->power.set_active);
> +	}
>   
>   Complete:
>   	complete_all(&dev->power.completion);
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -683,6 +683,7 @@
>   	bool			no_pm_callbacks:1;	/* Owned by the PM core */
>   	bool			async_in_progress:1;	/* Owned by the PM core */
>   	bool			must_resume:1;		/* Owned by the PM core */
> +	bool			set_active:1;		/* Owned by the PM core */
>   	bool			may_skip_resume:1;	/* Set by subsystems */
>   #else
>   	bool			should_wakeup:1;


I am seeing the following crash during suspend on a couple of our boards (with mainline/next) and bisect is pointing to this commit ...

[  216.311009] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[  216.311229] Mem abort info:
[  216.311298]   ESR = 0x0000000096000004
[  216.311393]   EC = 0x25: DABT (current EL), IL = 32 bits
[  216.311515]   SET = 0, FnV = 0
[  216.311593]   EA = 0, S1PTW = 0
[  216.311668]   FSC = 0x04: level 0 translation fault
[  216.311770] Data abort info:
[  216.311855]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[  216.311972]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  216.312081]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  216.312267] user pgtable: 4k pages, 48-bit VAs, pgdp=000000010b905000
[  216.312411] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[  216.312620] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[  216.312747] Modules linked in: snd_soc_tegra210_admaif snd_soc_tegra186_asrc snd_soc_tegra_pcm snd_soc_tegra210_mixer snd_soc_tegra210_adx snd_soc_tegra210_mvc snd_soc_tegra210_ope snd_soc_tegra210_dmic snd_soc_tegra210_amx snd_soc_tegra210_i2s snd_soc_tegra210_sfc tegra_drm drm_dp_aux_bus cec drm_display_helper drm_client_lib drm_kms_helper snd_soc_tegra210_ahub tegra210_adma drm snd_soc_tegra_audio_graph_card snd_soc_audio_graph_card snd_soc_rt5659 backlight snd_soc_simple_card_utils snd_soc_rl6231 ucsi_ccg typec_ucsi typec pwm_tegra ina3221 tegra_aconnect pwm_fan snd_hda_codec_hdmi snd_hda_tegra snd_hda_codec snd_hda_core phy_tegra194_p2u tegra_xudc at24 lm90 tegra_bpmp_thermal host1x pcie_tegra194 ip_tables x_tables ipv6
[  216.354364] CPU: 1 UID: 0 PID: 14450 Comm: rtcwake Tainted: G        W          6.14.0-rc1-next-20250206-g808eb958781e #1
[  216.365388] Tainted: [W]=WARN
[  216.368279] Hardware name: NVIDIA Jetson AGX Xavier Developer Kit (DT)
[  216.375099] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  216.381928] pc : simple_pm_bus_runtime_suspend+0x14/0x48
[  216.387698] lr : pm_generic_runtime_suspend+0x2c/0x44
[  216.392962] sp : ffff80009003baf0
[  216.396103] x29: ffff80009003baf0 x28: ffff000088043480 x27: 0000000000000000
[  216.403453] x26: ffff800082c11350 x25: ffff800082e0e000 x24: ffff80008093d634
[  216.410803] x23: 0000000000000000 x22: 0000000000000002 x21: ffff800082e0e000
[  216.418411] x20: ffff800080938af8 x19: ffff0000808ec410 x18: ffffffffffff4ac8
[  216.425328] x17: 2033303a35353a36 x16: 312031312d39302d x15: 000047edca5d49da
[  216.432937] x14: ffff000088043500 x13: 0000000000000001 x12: 0000000000000000
[  216.440110] x11: 000000321a7856a0 x10: 0000000000000aa0 x9 : ffff80009003b8e0
[  216.447219] x8 : ffff000088043f80 x7 : ffff0003fdf08a40 x6 : 0000000000000000
[  216.454291] x5 : 0000000000000000 x4 : ffff800081ffe8c0 x3 : ffff0000808ec410
[  216.461723] x2 : ffff8000805d133c x1 : 0000000000000000 x0 : 0000000000000000
[  216.468986] Call trace:
[  216.471179]  simple_pm_bus_runtime_suspend+0x14/0x48 (P)
[  216.476775]  pm_generic_runtime_suspend+0x2c/0x44
[  216.481499]  pm_runtime_force_suspend+0x54/0x14c
[  216.486049]  device_suspend_noirq+0x6c/0x278
[  216.490253]  dpm_suspend_noirq+0xc0/0x198
[  216.494278]  suspend_devices_and_enter+0x210/0x4c0
[  216.499348]  pm_suspend+0x164/0x1c8
[  216.503023]  state_store+0x8c/0xfc
[  216.506260]  kobj_attr_store+0x18/0x2c
[  216.509940]  sysfs_kf_write+0x44/0x54
[  216.513699]  kernfs_fop_write_iter+0x118/0x1a8
[  216.518163]  vfs_write+0x2b0/0x35c
[  216.521399]  ksys_write+0x68/0xfc
[  216.524810]  __arm64_sys_write+0x1c/0x28
[  216.528574]  invoke_syscall+0x48/0x110
[  216.532253]  el0_svc_common.constprop.0+0x40/0xe8
[  216.536628]  do_el0_svc+0x20/0x2c
[  216.540299]  el0_svc+0x30/0xd0
[  216.543016]  el0t_64_sync_handler+0x144/0x168
[  216.547736]  el0t_64_sync+0x198/0x19c
[  216.551327] Code: a9be7bfd 910003fd a90153f3 f9403c00 (f9400014)
[  216.557197] ---[ end trace 0000000000000000 ]---

I have not looked any further, but if you have any thoughts, let me know.

Thanks
Jon

-- 
nvpublic


