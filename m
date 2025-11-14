Return-Path: <linux-pci+bounces-41227-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 217AEC5C60A
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 10:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FEB75074F7
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 09:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77067308F19;
	Fri, 14 Nov 2025 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="En3z/5+T"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92133090C5;
	Fri, 14 Nov 2025 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112895; cv=fail; b=tx1vEucmkRpJRdhEeklnrd6s9AhDnisGuyAzmzbpddGBTb7VIXdhDFtfWVdiwBk2gtz7zE9HdQaQfKU1a5eBVW2P5yRogxP4VV6ItCK6GJWSN9EByGcoGy8AcWxofzQTpPScdzBmWHDMMVndh1UBFv2bKMfCfiYa3Y+pFhCWFTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112895; c=relaxed/simple;
	bh=C6YoZKj28mnMCvwyKhCNM9GzJqPeY3I+IHIoSCjKRY4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hsC0lC5x+YfQdtLUFJLhiX5rUw0NCb/L/jDZ9R9HiwaXPh5aJ8mPRs+p/YSFyvD7YIlazK/us59sbDgbtK+q8A3vdy7SL1SbbqAg+mT/zncHJZLoziLuSJdzn8QuKGF1YH5s9HzGHDQUUostLFZgDX46H5zRscTZr8o3PnIlnak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=En3z/5+T; arc=fail smtp.client-ip=40.107.209.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLHGeEGnrMIe/9ev+Nz+nIoiBPwyZSP1vB3oZiTqzIL+K/dAO2UVNW0t9ckC6eSe5XWCaZhaQYhGtvrGWpkzqRfwGlXuGySbucrprnj7deEbJohmR7Z7cE8SBahGl8qp3NVJtocbMLe/vK2FQbJ1SHPgTXqwZBQaXAnEgdcxYuSaIUwkX/VxcytlP5BTrNy/Obt0v9FSyXU2YDN/ygXxSN69YtO5PPKwy/c1ORV1DMBqeNuzbYrNeYnUnh5gfLXBE+WN6+ddQZF4ilbWfBE0YuwTRXMqRxXbelu1eejroN27Zb4CaYUrO86oEy+lkXYS9ENHrd7Gfnh/lWAyDCa8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APkU0ryha5BzbBGj9mTt2iUV9PFD5hPF2muDHuPU3zA=;
 b=ZBVmbat7Z9cAD8B4graMrUqBTw8cZJRf6cSwWt3aNLEIRdPIZgnTWa5y/hmvL/eK5j1FGqP4maLfeB6VWssuGNtdeCNuuUknhoScB0hbq3d6gymaS5nitWhWjTeo4n/wASber7pdNllLz7CICzOMsEVG07P0uImDQEgWckfd1mL14O022X+yVwSdAt2c7bfNrkmi30wR5jhJ9niHrOxc9kKjoWppUaGHGizWDFlguDY2m7RHloYrOlwRoIyQApUcmsZjpoocRODnZxeeQrA75adjA15xRb9Jtn4uAjCC7Ygu7TNvDrCfXPhPQByTq7DwIP36eRO2tEh/P3bwa8llzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APkU0ryha5BzbBGj9mTt2iUV9PFD5hPF2muDHuPU3zA=;
 b=En3z/5+TFuYoC5OjF7cxdPDJ3BNWMsfaOTEzGRQT06qqtY1muBWLnl6uKFNwsT5i7K/KbchmzgkXO8D/8BtJN63Y4oVfLO09kxtIWVKHH/f9CXvIYMVrI2VAVDsj5P6YZrTScueYmdcnsUUqPnb2aFtZ6jY1JAm1AhrYiNoFLds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB9735.namprd12.prod.outlook.com (2603:10b6:8:225::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 09:34:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 09:34:50 +0000
Message-ID: <ec0f0db3-078a-4183-9791-84381befe1e2@amd.com>
Date: Fri, 14 Nov 2025 10:34:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] PCI: Fix restoring BARs on BAR resize rollback
 path
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Simon Richter <Simon.Richter@hogyros.de>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Bjorn Helgaas <bhelgaas@google.com>, David Airlie <airlied@gmail.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 linux-pci@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>,
 linux-kernel@vger.kernel.org
References: <20251113162628.5946-1-ilpo.jarvinen@linux.intel.com>
 <20251113162628.5946-7-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251113162628.5946-7-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0692.namprd03.prod.outlook.com
 (2603:10b6:408:ef::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB9735:EE_
X-MS-Office365-Filtering-Correlation-Id: 5447a843-6f1c-40ec-5289-08de23610eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RE42Mkh6LytRdUZYMW52MHFiMUZQK1A4SGRHWEFrNkJqbHlidzJnMThISkc2?=
 =?utf-8?B?bTk2NXA4M1QzTy9Ib1VBU21ocVhpcEIrQlIzblpITTdpeTVQZU54NFI4Yjk3?=
 =?utf-8?B?ZXRUK01kNHhxVjBwUEdaYWxmRXl5SjdrNlpUNzc2enZYWllNRGYzT3pDVlVU?=
 =?utf-8?B?ZkNEK2hNTG1CV0o1emFzaFE3c0JmeE83U2xYT0RiWS90MFVMMzkvdHNJbHBT?=
 =?utf-8?B?ZWgxNy9mTlJrL1pOV00wRnJZd2pHbExVNEhlWkU3OGVpQVR3MXA3N2E1YXBa?=
 =?utf-8?B?YVFqUXQyTnc1ZS9qR0h3Rkx1aXFGMUhaYXdhdXZPT09RSjA4ZEZkN3Q0d0F6?=
 =?utf-8?B?Vk45bjM5U3V3L3ovTmJkcVE0MThnRVpUOW5uZGJjSGJrSUlkaUZ1Q2VZOTNG?=
 =?utf-8?B?YWxmWnpEZ0VoSmdGK1JXNWJZNXB2QlMvbDVFT0ZkMFFtajYyY2hHRjZIS3NY?=
 =?utf-8?B?VUl6RllYdGhVRDVrVDkyU0hwdERWRjJPU3E2MWJ5dnQzV3NwMjcyR29Lb2ZU?=
 =?utf-8?B?QVpuWjhXbnNycDhyOVkrNklhUDNxRDAyUmoyOCtOUzlnNjFBL3pvci80eTNR?=
 =?utf-8?B?OUxLNEJ5TFA0SWZ1M0dHa2t4d0d5Z1Q2NDN1aVB4dHNDTlN2NDJuQktlMDhm?=
 =?utf-8?B?alhuQlU1TTlLR3c4VFBRb0RsbmlvRVloMXl4M1doaXhOQXVoN29scjl4UkZj?=
 =?utf-8?B?ZUdRdzNRTCtTWDFjbEoxZVIxQzBqcTR4dDM3M3VWTFR0S2JlTU5BYk83SHd0?=
 =?utf-8?B?dzgxNHNkL2p6WHpKODdseHJJUG5WZlVUVU9jYTJqcWZJS3ZPajdZeGl6NXZI?=
 =?utf-8?B?Q2xkTXJ1ak5aaWZzVGk5aUtYaW5rZWs5MVR4VjZVV2FiUjhhK0haQmJFc3dW?=
 =?utf-8?B?MmsrWkNSdEtHVTh3YTR4NmZrWUdBaktGMkdwWTQ4bmVsVFVTQ3M1S2duYUdR?=
 =?utf-8?B?eHFXaTNPejdQcGloeHd5UDBmMmFSbDd3SDVJOVFwMndzQzUvcGVCNGpZSmpp?=
 =?utf-8?B?dlNvUCtJTmZHbWN4U2IvVzVVdTNpUU5oL0owa09FTXcydWgvRzIxeU1JdU5x?=
 =?utf-8?B?N2dSd1Y5dy8weE85cUNrd2FacW9UcjlNY3ZLSDk1Q3c3aGN3bFhuTURXdWU4?=
 =?utf-8?B?M1JxR0w4M01MNzlaSHN5YTBZV0ZSdUljbFpPRE5yRkpXZSt0eWtKdHQyd1Jl?=
 =?utf-8?B?SlUzaDFnU0pWTUV3ZzdhUlU2Yit2SWYybnd5OFBnelo4RGxDSHF6SlNGblZh?=
 =?utf-8?B?KzYyN25UR1Fxb0Z6dXk2NEM4dmw1MEt1SmxYelZpTlNnSEVTdmk0UVFpYWJa?=
 =?utf-8?B?Y0hlYkI4dzlLSktQRDJtTStvYWZEVU9OYWNKMmptaFRHUlJtYk12MW5mQ3hI?=
 =?utf-8?B?NHhZZEJzODBDV3RieDgvWHk2OGpZZERuTG4rMVN4N2JsU28vSWVPazB0NW9i?=
 =?utf-8?B?ckVQTVBRbmVrUjlmMkJYL1p0L1c1eTNuVzF4NGs1OFpLYXFYS0w4VHJMWThI?=
 =?utf-8?B?bFF2NGRFbTd0MjI5ZzhibXZCK2ExaW1mcUY2SFNZVHAyK2EyZGNBV0QzZGZH?=
 =?utf-8?B?VTM4eXBCLzRXSThwQ0h6enFxb1pmdDRra2VFOHU2alFnTkxrMEdGWWxxL3d0?=
 =?utf-8?B?SzNmWTlIQTdXY3kyV0xBcDRPLytEMGtMNjE1SFRoVGlaZ0hHVGVVSnN0WEJo?=
 =?utf-8?B?RStINUUyNkhWWS9VSVRVSU5EN2xXbjYvV0g5Q1UwOUxjOE1wREptS1ozdW5h?=
 =?utf-8?B?Sm90MzFDTDI2Vy9HRDkzUEs2a3cvbUlWdnoxc0xkc3p5RVRLb08yL2RLSThu?=
 =?utf-8?B?R3gvOC9HODFQdG85cXBRZ3k5NkI1amxmNTlwSUNNbzBiN0FDNzR1S3FOdWZq?=
 =?utf-8?B?WEJQOERseWpUN3hTdWR5L3pLV0hGRnJRSkxENUt2ZjYxQmJ0enovYTFjNWhq?=
 =?utf-8?B?aUQ3MHJaazZvb2ZvKzBIRDZFTitqOU5sK283RGd6dnNkRkI1TXFWZ3I3Vlpr?=
 =?utf-8?Q?NRXgTemH9ChImEpGLk1RvlskZQg0O8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sk9XdkNaeHRIMS9XMVI5WFVmWW9BWFZEdjhVYWhNV2FicTk1VkVDVWNEcm9q?=
 =?utf-8?B?dDNUMk1FZUh4NmY5V0lxV0xSdW1qWlFKa2ZzSUJRakVWYkxEVTFYUnd0aEFK?=
 =?utf-8?B?NU9nWWRFQnU4SDV0Q3o3Zk1vZ09UbGdpWVcwelRadW8vU1VkSVp5MndjSGxT?=
 =?utf-8?B?TkJKaDlKS0FoUUNaeUlKdG9YdXNwY3lUdHpoSVgwYnF5dGE3eDNiTDBWbEZR?=
 =?utf-8?B?bFdmaGFDZG5OYW8vaUNJcjF0Y0pGUHVDa1d3Z3BWVVZ0dzBGNHc4TjZ5TGY1?=
 =?utf-8?B?WUVqTjJBUmFFRzFxdUk2K05RZXYrTXcxNVVRbWVpbDI3RDdhNXZzUjhwd3U1?=
 =?utf-8?B?UCsyNzJLaWM2djVBQmJCY3lKeXA5ZHRGUFh1dFJxVHhGL2RheGpzMFlZNXRY?=
 =?utf-8?B?SlM3U3VOS3I4Q093OHoxSnRENHU3OXFrZlBxRnFLcXBCU0ZWMVRhWG1NL2lB?=
 =?utf-8?B?Mzd4a0UwOGVlUVhiblZldDdvZVpjNUoyNDJRNTc1MjNpMXArSU1abGlZSFZq?=
 =?utf-8?B?Z09kL3Q3dlJ3anRkTTZTUmpoMldscDBVUUxsOW1DNzI1SzBYbEU1RmxLbmhm?=
 =?utf-8?B?ZXV5MkVaeU5MZ3VLWHlEOWRWeEh1d25CMzhETFA2SEpFZ0RzRXNUa0toMHRL?=
 =?utf-8?B?eCtEQVpyOVpDWEo5NE5HSGlNUTJXUkt2cGorWTUyNitOemd4QWRnU1JhZ2pw?=
 =?utf-8?B?ZmM1bG9xRzdWQURjTVJQQnlNeTF5VXc3czhiMmtJSVZhbTFuK3BtanlTSFAv?=
 =?utf-8?B?SldsWDhPQkVOWSt6VW1ld0paZUgydUF5V0tDRlFBYVdQQTlHRnBhTHBhbjd4?=
 =?utf-8?B?a3hsSXZpcVRwMlp3VGkya0RNZEorcUk2NzFyMDBVRDA4TmRSOUJIQzE1SUNM?=
 =?utf-8?B?TjdYWmJuWDZzbThVL1RVQ2FjU0ErZFloSnBiT245aWplMkhyTHBnSlZUZGhE?=
 =?utf-8?B?RXFNS055L2RwZVRwL1dZbzMrTkRjUGJ2NzJ5Ukxhbnptb1hWVnRPREw2cTRu?=
 =?utf-8?B?MFp2cFcvZERnOGIwRkx3QmY4elp3NU9YUDE3UlgwWFpjeDV6bHdUU3lPMTdl?=
 =?utf-8?B?MExxWlBjMmluYjExSUF2ZmpkTmRPVUFxNWVMVDRqblB3dHhScFRYRlR6M3JB?=
 =?utf-8?B?MG1ReG1RbTZYdCtUVWl3UUZyNEcwVUx5ZVJ4QUZ0SFVEc20rSm9qN2MrMG13?=
 =?utf-8?B?blZsSUlFL1RneVJyaVQrdW9lMXRZV1VSTXNvdkdXbHRtdXkxSmJTYUYwMTgw?=
 =?utf-8?B?V1I0ekhlKzhHTlV4bDdGWU01aVpkV2dCanhGL2NGYzBkcnlEUFcyd3BSV3hl?=
 =?utf-8?B?V2I1MGxPSlNIWlhhTDAwYjVVckl2QlQxY3RwRnBHUktUdjNnSmRhYm82b2pp?=
 =?utf-8?B?ejkzVzAxZlJHSGZ5aGNRd1VWZENlTHh3OWw4dHJGSEFBVzlOOEFCb1NUUHor?=
 =?utf-8?B?MDF3d2NmcHRJMjkrQUtRM21UdzcwUGFTS1drV091VUVmQ3kzWnNSV0RsYnhJ?=
 =?utf-8?B?NWZUdkI0QnM0ekNPdE5ESCtOVmNtZWVUOHA5TGVFbFJWUVhTcERIdGNlOUgy?=
 =?utf-8?B?ZFcwYVBVZHFXR3NWZDNkTmtHVDhFbUtWOFNGQUFkd2dlNkNzVG11WUVtajNy?=
 =?utf-8?B?anpaYk9lS045bEF2UEFkRWpiOHRSOFp1R0R6R1NHRkYzNnNoWElrR2QzRzkr?=
 =?utf-8?B?R1FFWGtOSEUwNEZSakt3UnA4cVNGbldiWGVUaTU0STU3ZnRhUGdJeGttTzI5?=
 =?utf-8?B?VzNZRk5FREFLS1R1a3pGb1pMeENMbEpMUWhpblNDNFRHUmEvMEp5R1dJODBU?=
 =?utf-8?B?UjJDQmFPVTRyNitOWWpsa0w0dmFaaTJubkJxYmFNNzM3d0lHZTFHdlBpNUZ3?=
 =?utf-8?B?SXZ2djRjQjZsMUlLS0ZBczJPUjk3bHkxSmRsRVZ6N0ZlSGRldXBISEpWV3J4?=
 =?utf-8?B?MWxmTEZHM2tuQzg0dXdNejY5UHVFVGdVZzhyM054RDZqbkhQUFQ4bGpXdC93?=
 =?utf-8?B?WjR3blI1R0JHZURZd1FOOXN0dTlwVC95MnZSSHdhQU4vYUJwUWxnNUlMeUxP?=
 =?utf-8?B?Zks1WFBQQzl1Y0FCcndtQ2ZzRDVWWnFtaGdjMFJoamhhb0EzSHk5elhlT1lx?=
 =?utf-8?Q?0beU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5447a843-6f1c-40ec-5289-08de23610eb3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 09:34:50.0186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjoRm+ZooCX2NL9hn++GEhZiOQKAsp6ki8Ycd9xhWoRKICYpF65CqePhF4yxznGj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9735

Hi,

On 11/13/25 17:26, Ilpo Järvinen wrote:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7a899fb4de29..4e241836ae68 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1736,7 +1736,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>  
>  	pci_release_resource(adev->pdev, 0);
>  
> -	r = pci_resize_resource(adev->pdev, 0, rbar_size);
> +	r = pci_resize_resource(adev->pdev, 0, rbar_size, 1 << 5);

It is HW generation specific if that is BAR 5 or 2 which needs protection.

There is an "if (adev->asic_type >= CHIP_BONAIRE) pci_release_resource(...);" which depends on the same criteria.

Something like this should work:

if (adev->asic_type >= CHIP_BONAIRE)
	r = pci_resize_resource(adev->pdev, 0, rbar_size, 1 << 5);
else
	r = pci_resize_resource(adev->pdev, 0, rbar_size, 1 << 2);

Apart from that the patch set looks really good to me and is certainly a very nice cleanup.

We can potentially also remove a bunch of the extra checks in amdgpu. Going to take care of it after this set landed.

Thanks,
Christian.

>  	if (r == -ENOSPC)
>  		dev_info(adev->dev,
>  			 "Not enough PCI address space for a large BAR.");

