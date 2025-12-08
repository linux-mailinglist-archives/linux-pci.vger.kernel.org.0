Return-Path: <linux-pci+bounces-42768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFE0CADCD1
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 18:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89A0F3015D03
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 17:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1EE1946DA;
	Mon,  8 Dec 2025 17:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FAYWV4v/"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF86EAC7;
	Mon,  8 Dec 2025 17:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765213467; cv=fail; b=dgtA+FT/ZZ/WtycjC3Wl4bpPLZbByZ91l1pORqfKpxERclVayV5QCS0hX4Y2Ipw+NJca1RmuozNMFFcZWf/IAlF9lcTFDigNGg5dVx94IsqREupDBtD7KN9bOMAcVVihMrSTvaQa+i0R/UO0hpnDm2qQUbaPWfntWe1mOsZ3IKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765213467; c=relaxed/simple;
	bh=od9632IVew78Z7Q+Rb4IAO7VpJRQhVdWTbDsFhBEl7Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OW4E1RaG8ft2MsGTqPN49WaL5jGj7YdDRg0SC45v8buKXRc61EBC6DcK+3ngQqtYnDFo2jxmSH5JOmmAix8mFINmWgKAZEltNrTGNfBockxQDCDCX2kaj/PMn65NSRm9A8QIhF/ZplivOUjU3INrGGHhZvjDBCu3hOoRqyH0NYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FAYWV4v/; arc=fail smtp.client-ip=52.101.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMBStQf02nBuZx6TcbJ19jzRra4jVRyI47CIgNNmG4Oeg/qfYiUWYlpcaTJXdjSSOv+V2jxlqvVYf20GtwOsPtZbLNQgJkh2qExYQeGDscNkinWntY3UWJmAOoLQ4YeQOe+REk5LD5+Ev2XTopov5N7Rd0jqzlDMcyAt0TOvJ6RyzAE8KHk548JjO1aEcticmN38YjZlRYC0HAbPk+cXVUUWddAEig6+gHSnLEU97GYv5v9NJOwcp7tq8QyiIhkL//sRCscGtSpr4u+l1ZNzJ2PS2NPQbKzJT3+slmU5/5IsbmBwZZtlj08ZyGLhPQyP8vsDIMgh8E/K2MXWSAotEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mf9pOTLcwM+iY1CoVsQiqf2UG4fyTCTWuMpd5ih828E=;
 b=Y07Jg1e6Y09HQwY4V/WhoacWfpAXjgvyvRLNWgQu9N/1G0FykiLcam6mPOjnxK10Yx43ZOV6+3yGyEL5L+kmGkj2rXMjbNkNlcUaaqtBDxP3TuZauVIAlhk9TU1zlEsaMPlGYuSZd+B0GxlHzoL7iGYsvHKgOdmUxdYRa5g1ne434s3KmxunmzcCvz9x70/fwd70gQ1RZmSzhMMm5mMDoU7+vcIIXAPJSSQy9+7KA8DYUmz6NnazH1qWRnEZd/OAd5IeIdxJc+ksGWPeVPrG5JS6I9+QuWdGE4k4COleAcKnEt7tamPz/7BtUtOh0dL4OyRMckf8OhuARw0PPlX3LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mf9pOTLcwM+iY1CoVsQiqf2UG4fyTCTWuMpd5ih828E=;
 b=FAYWV4v/7ilvxUQv625boExkCPGEpCcL7nI8QSXbVNsvc/7gpOX6YrAMIuV9d92kvfl4euTGEmql3HrDNDkhFQYsLrODp0D9/qlWn06KHlkj9DGC7ROfMKmeYBQr3d5sC6eyPUyDyei3oNAOn3mRmRcNe412HDLJRO22Hp4VWkw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 17:04:21 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 17:04:20 +0000
Message-ID: <c7878afc-237f-4bfc-bfc9-aaded2e2420e@amd.com>
Date: Mon, 8 Dec 2025 17:04:15 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] cxl: Initialization reworks in support Soft Reserve
 Recovery and Accelerator Memory
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, alison.schofield@intel.com,
 terry.bowman@amd.com, alejandro.lucero-palau@amd.com,
 linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
 Shiju Jose <shiju.jose@huawei.com>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20251204022136.2573521-1-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0339.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::15) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB7988:EE_
X-MS-Office365-Filtering-Correlation-Id: 47029a0e-d437-4c77-1e67-08de367bd41b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekR3dnQ5aldHU3J2QWNsYWVsTkdTbS9aVkVPMWNFeDAvOUl6QTQ4T2ZYcHZz?=
 =?utf-8?B?VTV6SUU1K2FCV00rUDB2b2EvNFNqVzVKcXBITkNnYmxXOGUxVis4dG1TMFZF?=
 =?utf-8?B?YjJrMmwxMmtweUZ5WVgxOEsyRGZYQmxxME1xYWp4SkdGekxwQ3Vhb2xXamkr?=
 =?utf-8?B?WG9WY2lJb3hHWjhxUTF0WTBIaytpbHNkLzRkcWFKb1dOcXpXVHhNOUVWMkti?=
 =?utf-8?B?dWxwN0JxR0tmRkRJazFqZkEraVlNRDg3RjBMM3ZuR3VsaURQVzhGM1BhSHF4?=
 =?utf-8?B?VVlkd3BIaElkM2xTWnV5S1YwbnNya1BKWXZlWDBLMXVwdTNQc3ltbE1wL0FU?=
 =?utf-8?B?dUlrSEpvd1VDVzBDblRhbHV2elprQnJteHN0b2NqVFJOMmY2RWx3dmZOUHNX?=
 =?utf-8?B?NjRmOG0va3ZtQ29jNFRkSkttb3BvZFNiQ0NpeFJENStIb0daNnNKVXltWmd1?=
 =?utf-8?B?QzJiOW1TQ0luMSt4enBBTnl2RGw0UjNvMFlWK2dpeVhYa2JmcXFSWXZTNy9n?=
 =?utf-8?B?eUNTSCtwMVFGSHc4eU9scE1oT1o0NmRIVkJUUHg2bC9wSWVobnh2Ny9FWUZ4?=
 =?utf-8?B?N21Wc3hWVFloYVlmT0F3RDJlQnoyVC9mamJBUFppVnl3OTZwQUJ2aGhKa0t2?=
 =?utf-8?B?cFRGSHZtQXJaRzdZVzFDbEJWR2J4RndRUEhCWGZPRm1QM0dmeVQ3Q2k1Rk1W?=
 =?utf-8?B?K1JsMmVscEt4d1RvYXN3NXJkZk1DTXBKR0FkK2JFTEdjTmFlZDI0bW1yMW5a?=
 =?utf-8?B?VVRQNFJ0RlA5aElNeG1qNGNaN0VLUVpCQ1RpVFl2TDV3NWJ4K2pJOVNwWVVG?=
 =?utf-8?B?WFczcVBOd2FwdVMzZmp0dDhyNVphOERObHNpMFJjUDNJT1d3ei9LVEZvMjFH?=
 =?utf-8?B?TVYyK3IyWW1GMGVUQUQ2My9jK0FZUUhwd2k4Tmt5WXRZa2dSdkZyb0ZWWUp4?=
 =?utf-8?B?SlJiMFJYeGNJeDhXdURTalpTeUlxZWpUWVY2Q2NNd1hydWVZVEJTdFIra2xk?=
 =?utf-8?B?VzcxY1l2WHp2akRKV3kvNGRpSy9GcVVGVklkVytxTnhadHQ1eEtYTUYzblo0?=
 =?utf-8?B?Z01MbmN6Y0lJcXVmbld3VmlSMVp4ek1jZjdDdEYwaWh5Qi84eGQza2FCU1Bh?=
 =?utf-8?B?a0NhQVlNTlo1VWo3THJSaWlnOW9nZGdBWFZ0NE1PVno3dnA4MloxWm05Qy9C?=
 =?utf-8?B?WmRPUDJkd2gwa29tOTErYU40RDd0TGVwSi85U0JMUU4wbTczWVNCVGxCSWUx?=
 =?utf-8?B?NGI3VGVNN3dINThwbXVubWY1UkFtbFRLNUN6cHN6WjlSNFg0OTVLdER3NHR1?=
 =?utf-8?B?S2RlRm51VXV2c0NOOFU2bDhyOEJuQkYwVWJWR28xaGZlVU9WOW9QWTRCWVhQ?=
 =?utf-8?B?ZHhXSS9WdDUyWVg5L3ZzT0pNa1RuV3NuNVhXNndGK0RqdHBaR0NJZFc4aFlx?=
 =?utf-8?B?T2FLcExUc2RhK01FVENmcXFOSFBhTkV2ajNDUExwb2lMbTZ1dURFYjREdm84?=
 =?utf-8?B?NFUyMGJ2V3RHZkw0amNiTzFJRnM3bGNST25EdThZMmZSU1d3QXlzMTVlaUVr?=
 =?utf-8?B?MWp4dHplWkdtV1QwTEhqZXJFVzlGdXBoVDFUNkFGVC9FZmM3bk00YWNEWFBE?=
 =?utf-8?B?eDhSWUF1OHdSVi9RVlViOTJpS2J4VndxQjA4VHAvQVY1bVlCWFl4Y1ovaEww?=
 =?utf-8?B?OUlnbDk2dVhkU0hRMkV6b0RmZ3kvRGtYWUtjaTZhRS9zRUhIV1AyODY3M01I?=
 =?utf-8?B?eGtLek9Lam1lbVkvVXJnbWpVSUExRkJ4YU9seHEzZCtmMUsyeWtZcnpaRXFx?=
 =?utf-8?B?ZkFMRDlJRmd4NHR5cG9oYTIvWFF5QjZ1N0ZaelVKbUREZjRUR0lQL0pYcnZX?=
 =?utf-8?B?TUp6V0ZrejB4YUE1TlpKZUtPMXhSQUVtV0MxRDkvU1k1RXk0bkJ2RkMxSTFY?=
 =?utf-8?B?Uy9lZVRQa1hrLzBHSGdsZGRCRFR1ak9yT3VwMFFtMFhUbDcrS3JyN241dVdU?=
 =?utf-8?B?ZTRFYVFZVGx3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bms1anArK0tkWUNNYkdOcmFrVHR1OG51WGpiV21leTR6U1Q4SU1pNUhvNjlS?=
 =?utf-8?B?U2xUNDEwZTkwa2pUNEd3Q215bzJ3TC9ZNDBIVi9seE1DbzNMNnhBc2ZpYXhz?=
 =?utf-8?B?VEhJWXZRQXlVTE5BRFdLRzhDdFpCZ01GS3d2dk80NzA0c1JSUzViNVV4ckZY?=
 =?utf-8?B?cU9KSy9TWlREL1FVSFdkS2h0YVpsNno3bnF5V2RmelVkVW9RNC8wWmlTUjV1?=
 =?utf-8?B?SkNyL3hoMGV1blFRS3RZSW8zNm5jeFJuN1huL0lLQnB4NHZYV0hSZ29mOGx6?=
 =?utf-8?B?OUIzY2lXRngxSzFCU0NyY0o0dHpmeTIra2JmdHhrV3RaNU1iV0J1Rnc4TFRq?=
 =?utf-8?B?VEplRDY4VG1zUlplZVBhQkhYR0tBUFRMaFZnNEp6SWc2Q1h6WUpTamx4Q3lH?=
 =?utf-8?B?ekNQR2xJOGw3YXQ2T0FDZEk0YnJLOExuUkhmd3FGNzBtS1JsZFNDbkFieDhM?=
 =?utf-8?B?TlJvZEdOajRhMEgrMmFMMFU2U3lXUDNjYTJpOUo2dDV1TEhzcWF3anVnRHVy?=
 =?utf-8?B?Sjh5TDI1WndLeVZtOVVGRnVIRGhKN0c3c3RjbE9NSEdCZXpIb0Q3YTB2cC90?=
 =?utf-8?B?MU95elo4TjlmamZidkI4Q09UTUkyM2hqd2RDdTNYSWxBVXNLTVRsN3pqSG1F?=
 =?utf-8?B?SUhFN2dVNjJYWklLNjRjU1hGVXo0NjRYRGg2eEk1V3ZLMEtmbkZvQSswZENk?=
 =?utf-8?B?bDFXVHZscURjUzdqUjFSUE1nVTBiNnA2YXkyZ2RuYWNnekdUMmJIcSsvRGFz?=
 =?utf-8?B?UUp0amVXaWlKaGY0WFZrdFpzVUdkMzc4K1JJRi9DZEIrMWE0eFd6SnFhbDFo?=
 =?utf-8?B?VkFRSHBONmJFZkJBdkF5ZHVxUUtQMDdxdHlrUFBjL25nbjV6VWJmbldtS0Fw?=
 =?utf-8?B?Ym80NjROakhKSzFmVkJtTmVCaGhBS0ViZWJSa0MzUkNxSDFHdGNjMmkrOGdu?=
 =?utf-8?B?OW5mSVRuSCs1T1NVZWwxVEg0aXBGQm1xZGZ2RTZXa1ZGaXQxZGZDR3dGeitV?=
 =?utf-8?B?aElvK1dsaStxQjlKOHk1aFR4cjFIUGtKZlNzOXE4RGpkREhueERQTG1leGpW?=
 =?utf-8?B?UlBEVVdkb3dOR1BsVHIva2ZvTXFtY1l0eGcwZm0vb3JObElOa2VhMXE4TWgx?=
 =?utf-8?B?czMzd2llQ1NZWE01VXpWK2ZCaVZTRXZyWVJaaHFDTjJKUlZGRjFYeVhIY2pn?=
 =?utf-8?B?M1ZwZXd6bWQ3M1J0dzdFVCtoSjMwY21UUE15d3BMZEdvM25KbVB6Nms3RjF1?=
 =?utf-8?B?RjltdjNTVzJ0cTJoRWFPUmJQcUU2VHcxUy93byt1aGQ5Tit5UlVlaE5DZksz?=
 =?utf-8?B?OGxXWWhDdzRBQWxvME02NzBENnRxdDBjN3pCMFN6UkRXZ2tiaWM2THlMSGlw?=
 =?utf-8?B?U2RXWHUvM04zV0VDVnlYU25sdjlxQ1piK0lYckZxV1U4ODZqMlJaUklsMzhz?=
 =?utf-8?B?T2pKWGJ6c2NwbmdRWHpES3ZZclp0L3hwcXJoOU9rcUFvaFhiek9ibDA2UUZX?=
 =?utf-8?B?Y25WbXVoMFdCYTlRM3dhalh6K3picW1nVnhyOHdHTWRGVC9Cbld3QTdlZHIz?=
 =?utf-8?B?OHNCR0JTTnNjT05BQUJ3citOT2lyWnJQcWllbUQ0OGlEa1R3UXFJaGZIZ1Zw?=
 =?utf-8?B?NFN0OXpXVmtheWJhTGEwYTBaTWorbTNUZGw1bTdpYTdMRkJBWjRoVjJJVTJY?=
 =?utf-8?B?M1lQU1RsbUNrcHZNb09FdCs3MllOZ1Y0dTdKZGRxWHMxTlY1NnZCTGEvcDRB?=
 =?utf-8?B?QWJ2VDZlRzZzby9IeUJ2eDlrR0VXakVoTnlmcVFnQndHakhjMDZSR0JJd1k5?=
 =?utf-8?B?ZGNEdWFobzVscjl5OTdxQ2dLaElNczNoekQwZ0hWamlwR09zejIyQ3RqSmg0?=
 =?utf-8?B?Wk8zcWN0SW04VjZiZGhPb2dvY0E3NTlmZ0Jhc2JxT1VzRkJ6b0NDNE5mbmIy?=
 =?utf-8?B?TU0yTkFFMGIrdlpkUEhZVWxHVDM5MUVuTmdmamJ1cmFVdGNhdnI2U2J3YVAv?=
 =?utf-8?B?L0RmOThUcnQ4ZEs1dFdXanVNbytGN1hzTitCNEhoTEgzek5yVmIxZkJ3OGFy?=
 =?utf-8?B?WjFaTEt4eGQ1Vi8zVGRhTG9WUVFrWVN3RnA3bisvVm0wS3Fpcm05NDQwLy9Y?=
 =?utf-8?Q?3nsNU8vet6/4s/6ry+87DiTCY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47029a0e-d437-4c77-1e67-08de367bd41b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:04:20.3710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9aBnhFoxYXEeaUX4MP64TJNq+kL2zbnkm9uQoNoJPBD3Qa0f2FBKyJOMfCkaLSBdJNDafO1uLRHO8RPlwZ/PJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7988


On 12/4/25 02:21, Dan Williams wrote:
> The CXL subsystem is modular. That modularity is a benefit for
> separation of concerns and testing. It is generally appropriate for this
> class of devices that support hotplug and can dynamically add a CXL
> personality alongside their PCI personality. However, a cost of modules
> is ambiguity about when devices (cxl_memdevs, cxl_ports, cxl_regions)
> have had a chance to attach to their corresponding drivers on
> @cxl_bus_type.
>
> This problem of not being able to reliably determine when a device has
> had a chance to attach to its driver vs still waiting for the module to
> load, is a common problem for the "Soft Reserve Recovery" [1], and
> "Accelerator Memory" [2] enabling efforts.
>
> For "Soft Reserve Recovery" it wants to use wait_for_device_probe() as a
> sync point for when CXL devices present at boot have had a chance to
> attach to the cxl_pci driver (generic CXL memory expansion class
> driver). That breaks down if wait_for_device_probe() only flushes PCI
> device probe, but not the cxl_mem_probe() of the cxl_memdev that
> cxl_pci_probe() creates.
>
> For "Accelerator Memory", the driver is not cxl_pci, but any potential
> PCI driver that wants to use the devm_cxl_add_memdev() ABI to attach to
> the CXL memory domain. Those drivers want to know if the CXL link is
> live end-to-end (from endpoint, through switches, to the host bridge)
> and CXL memory operations are enabled. If not, a CXL accelerator may be
> able to fall back to PCI-only operation. Similar to the "Soft Reserve
> Memory" it needs to know that the CXL subsystem had a chance to probe
> the ancestor topology of the device and let that driver make a
> synchronous decision about CXL operation.
>
> In support of those efforts:
>
> * Clean up some resource lifetime issues in the current code
> * Move some object creation symbols (devm_cxl_add_memdev() and
>    devm_cxl_add_endpoint()) into the cxl_mem.ko and cxl_port.ko objects.
>    Implicitly guarantee that cxl_mem_driver and cxl_port_driver have been
>    registered prior to any device objects being registered. This is
>    preferred over explicit open-coded request_module().
> * Use scoped-based-cleanup before adding more resource management in
>    devm_cxl_add_memdev()
> * Give an accelerator the opportunity to run setup operations in
>    cxl_mem_probe() so it can further probe if the CXL configuration matches
>    its needs.
>
> Some of these previously appeared on a branch as an RFC [3] and left
> "Soft Reserve Recovery" and "Accelerator Memory" to jockey for ordering.
> Instead, create a shared topic branch for both of those efforts to
> import. The main changes since that RFC are fixing a bug and reducing
> the amount of refactoring (which contributed to hiding the bug).
>
> [1]: http://lore.kernel.org/20251120031925.87762-1-Smita.KoralahalliChannabasappa@amd.com
> [2]: http://lore.kernel.org/20251119192236.2527305-1-alejandro.lucero-palau@amd.com
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.18/cxl-probe-order
>
> Dan Williams (6):
>    cxl/mem: Fix devm_cxl_memdev_edac_release() confusion
>    cxl/mem: Arrange for always-synchronous memdev attach
>    cxl/port: Arrange for always synchronous endpoint attach
>    cxl/mem: Convert devm_cxl_add_memdev() to scope-based-cleanup
>    cxl/mem: Drop @host argument to devm_cxl_add_memdev()
>    cxl/mem: Introduce a memdev creation ->probe() operation
>
>   drivers/cxl/Kconfig          |   2 +-
>   drivers/cxl/cxl.h            |   2 +
>   drivers/cxl/cxlmem.h         |  17 ++++--
>   drivers/cxl/core/edac.c      |  64 ++++++++++++---------
>   drivers/cxl/core/memdev.c    | 104 ++++++++++++++++++++++++-----------
>   drivers/cxl/mem.c            |  69 +++++++++--------------
>   drivers/cxl/pci.c            |   2 +-
>   drivers/cxl/port.c           |  40 ++++++++++++++
>   tools/testing/cxl/test/mem.c |   2 +-
>   9 files changed, 192 insertions(+), 110 deletions(-)
>
>
> base-commit: ea5514e300568cbe8f19431c3e424d4791db8291


I have tested this series with Type2 and it works as expected:


1) type2 fails to be installed if cxl_mem not loaded.

2) cxl_mem, cxl_port and cxl_core not removable as type2 driver 
installed depends on them.

3) cxl_acpi is still possible to remove ...


FWIW:


Tested-by: Alejandro Lucero <alucerop@amd.com>


