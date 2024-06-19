Return-Path: <linux-pci+bounces-8993-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00C190F272
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 17:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A7AD28433F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 15:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0597D15218A;
	Wed, 19 Jun 2024 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Psw/vtUU"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6045D155CBF;
	Wed, 19 Jun 2024 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811662; cv=fail; b=XneFDpyCEhyschslBPQTGJH6cm+wf0bZu7qgWmfFDPUaoxn1ZhIyVN3mqqcSuz9k/pxULiv8iDReOdbj2rAqSQx8QMb/VlY1bVnkCaL7Dr4bHRFlsgDQC6Lw60S8U12SKDLBfz5rNMD6nD0hNno1UTL+OYuLZET5mdZG82dZcPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811662; c=relaxed/simple;
	bh=mcIWdL0zqdhnyVXd76kAlfSoSPHxxWoKQ2wSzy55Fhs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A1/cqi8ew5riK6wiraiOIIm4olGkBwZ6mMClw3HAznXnoD9Utze5OVggdLNQajj+oehW87sYQG58rBf8NvcrmFRak8a0Nf8dKUroaemQcIDnkIazUgTH1C9xf9bjioEOfbFXQUXvLrO+e7/T5btpTtDwjTek8SiG3H/G8Zsfpu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Psw/vtUU; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJHusd7+EwAI+O6Q7viBMEDKmvUHaHzpRnLmyPUZa9EpP80ky28x6JW2Mb7eN40ZlnOKejmsiUsUn7NK/yQ923dgOrnrvkRhZ6BiuI42ITUY2J0dZaIhrYBc6XE7Ijy5UJ9uUZCG6SQJGzvIgL4IrJnYoadhS0R5ZXtnwfNBODADEpTjI8jrRLFNGfnJUw8/VJxzeXsFfzxm2RRbzuu0daLEALd6wHWyBLRlpEYPILo/dWyfVIUHlgdZOSZwVmFJQV4gUBnx4adxA2u34+kdzt0RPS31yNT29NpavAJdsacRTeOP2jRRujge7mw2/n6bVkF3nVlQ6f4Ku4t/QlIvkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZdGZzl6Wx+MmBEjtYlkLhuojY8Z/8XUmKX9Ii5MgOE=;
 b=NbAW3CLP+tshO864YLIVfGJPl+UbCk9QTry+p//YjOKIsBq5AxsJal1AqCM0z0AP7geEu7bzlGjMb66tVTB5SWnHn7oOJK0VoDSHqRfTfHYlHsTDDAOov5jgTuRnqkjXvb79OyG+9mWg2q7C/ZEYQdD0mJ8NDqMkgWJQR9Bf9l3k8lfo8mZa8NL4J8Cs+hh0meulFbNZh3ARQOkzmSSJw4mJwbKmYM0VBsr1Lnj9ZokshOqGMnEscslzWmrvdrjuy6vnIAaNxlgWGz/xhmG0ltU9YIKJlcyMCiZ1agifSHLwCwpIZDNENF42ZfgnNwHNCmxbTXRsHdBfMZXHmFAolg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZdGZzl6Wx+MmBEjtYlkLhuojY8Z/8XUmKX9Ii5MgOE=;
 b=Psw/vtUUQxN1JYAPK91TmyOG2CFBejEqBXoPvlMquU+9XJCLkpIVu/cu5wxkoGlQiVBXaxz0gTSqvuo4R/ZS0NdmIOqHZhcd67Lh1DT8hR5YoRCukY7bO3AGJMnre2znhMplwzKTd8XPsM2CzyLi/6E00BU9Nc/G/uAlE3P/Jw8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 IA0PR12MB9047.namprd12.prod.outlook.com (2603:10b6:208:402::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.19; Wed, 19 Jun 2024 15:40:54 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%7]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 15:40:54 +0000
Message-ID: <60fd4ef4-2fea-4836-a5d3-94481a61226b@amd.com>
Date: Wed, 19 Jun 2024 10:40:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 8/9] PCI/AER: Export pci_aer_unmask_internal_errors()
To: Christoph Hellwig <hch@infradead.org>
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, ming4.li@intel.com,
 vishal.l.verma@intel.com, jim.harris@samsung.com,
 ilpo.jarvinen@linux.intel.com, ardb@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yazen.Ghannam@amd.com, Robert.Richter@amd.com,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <20240617200411.1426554-9-terry.bowman@amd.com>
 <ZnKEJd44ItoL67_s@infradead.org>
Content-Language: en-US
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <ZnKEJd44ItoL67_s@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:806:f2::16) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|IA0PR12MB9047:EE_
X-MS-Office365-Filtering-Correlation-Id: fa07c13e-c19c-44db-b1cc-08dc9076347d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011|7416011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aE45NFJON3Fna2lkVGIwK3Y3aGZSdjUrTTQwZnd4bjlXYmVqVk9JWkxSdm55?=
 =?utf-8?B?dC9Kc0daejF4SkdaOEx6NHdQbm0xVk41UHFzbVpLR0oyWkt4eG8yOS9QS2dF?=
 =?utf-8?B?alhnU0dFRk45Wlk2NU9mRlZ1bE9Ncm1oTnpTL3pvVXg4ODFJSWRxU0gvWUh1?=
 =?utf-8?B?SXlFYnVmSCtiaWh0UjlSdEFzWXBKcmFnRnFNcHNla1ZnZThnV0RtaHBKanF1?=
 =?utf-8?B?WVFOb3kzYW5UTWlzWkdyNE9HSW40NGExRm1aSnNSeVdMR3QzK0w1anUvQktK?=
 =?utf-8?B?Nkw5UTdHQm40ZitKVG4xT2gvaFdRTmY3V25YV29UcWx4cXBUR3JOeVZuVjFn?=
 =?utf-8?B?SFdFdmdjY0Vyc0tJWWMrbmNBeXFDRnd6bDZzTkRaSklyZ2JOWlJJdjdmWldY?=
 =?utf-8?B?ZFBhaUhkSW04OVNubldZbGVaV3hQOFdyOWc2Y1JjZDZxU3FZNTRoTUI3NExu?=
 =?utf-8?B?Q2ZGdXZyZlBRaG9TMXBKUXhtaUVGZjJDdFg1TFlZQ0hpTVFUZnZpT3pOYTFW?=
 =?utf-8?B?a0J1V1NRTzBZcjZWZzcydk9kY1hsaS9SUjFnMWJvSU4vMExjNUFiZ0QvYlVm?=
 =?utf-8?B?TmV4dTdkUjR1NVRmcWYxQ1N6R0M0WlhubEFSdGNxVVZRdFd4RU9PZ3lwVHBu?=
 =?utf-8?B?bU1FVHdrQXprNnNNVjM5RHRqRWRGbWMxK2NLaWxITFRQV3JvVWVvVHNCRXpj?=
 =?utf-8?B?ajdrKy9xc1BTcG1zWmIzSk9SZ0JxMnRoKzcvQitTL1p5K2YvVFBYanVpZkFz?=
 =?utf-8?B?ZFRwMEJ6bDFuaHVGR0VybHRFWjZ6Y3RQRFI0aUY0NFdXbC8yNG5WcFVTYUdn?=
 =?utf-8?B?SXl5ZG5UdTBiaU5vekpQRG1JNGZsNVFaRUxEb2tsU05TYVRJSm0yQXlEQ0JN?=
 =?utf-8?B?eDB6YTBNb3BjeFh5UTRvbGdVOGEyZnE0YnluZDJXanE1c3pqd2tocGxlOGZj?=
 =?utf-8?B?RUVRdVVzZVhSVmNnSUZXQytQRy94NEM0SEtEMFdFM3l3Z0M3N0FsNjQ5cW9K?=
 =?utf-8?B?V3ZuNkpITnFHNDVtZ1FqbUdYemFWcllGb3Y0SGJ0eDhTcHJzdSs2bjdvZEJw?=
 =?utf-8?B?RldmODRqT2R6NVRNMDhYamtwWnR4OEc0eWNIVElHZnhWSnhESkpOT1VNTmUw?=
 =?utf-8?B?Q0syWkM0TllQbjRudGZaZEVVb3gxU1p2aUgxYTN3aTRlS2wwRTI4cHJJaXB0?=
 =?utf-8?B?VnEwOHBXR1JEa0YwQ2syYXl4TjVwK0ZZUVFUN0FpSmJBYjNkMXpzK3NSRE9n?=
 =?utf-8?B?cnJwTk81T0JPNDEzelJMeUVTNXlsUjlyei90TDZzSmJzZmh5ak13SnU1R3oy?=
 =?utf-8?B?Mzh1SVVDMDNaVnVyUURHeEg4SHZvR094NHlTdGU4Tm9mTHQzUWRWWGovSGht?=
 =?utf-8?B?QVoybWFXaTRLaWJWK3dQUkEzckxDK09nbkMvZk9FSkw4ZnBKRzQ2eDFLalk5?=
 =?utf-8?B?NEZOaTlxWHpmNFRWRGNnUElKQ2FEdWMxR3h2RDkvblBEY01adUQ4d2VseXNj?=
 =?utf-8?B?VWlOT1EzQ3pKbTd2dnpqT2Fvc1JmeGlxU2hreUtnYzZndmZwM2EyMGl3Wk42?=
 =?utf-8?B?cm5TRkU4bEtWQ0YwUkpTSG9rZlJCdWtKVGorMVUwYVBSWkwyM0FYY2o3NHJz?=
 =?utf-8?B?MzdFaEdGVElvQjF6TksrZEo3TnNsU3gwNGI1ampVVlVkdDRWdTBPNVErTkRj?=
 =?utf-8?Q?veUNCWZDLMt0FRkWSyQZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(7416011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0xyWllneDI2UFNDVW1iMWZBajVqK3IrTGprQnBOMFF3cWNxSjY4Vzh5MXBN?=
 =?utf-8?B?WnQ3OWVORDBxLzVsbi9wanRUVnJRYksxYUkzUy9IM2RBSTMwdC80dWNiMnp3?=
 =?utf-8?B?OCtIak5UT2RKdnQ3c0x4ZkdkS2cxUERDcS9yYVh5SkFIYUI5Rmg4eVM3VDFx?=
 =?utf-8?B?STdlMlVINXBtVlRqakowYlpsL2FLRktQU2pNY1ZndzU4S0tnR0l2WjlPeEwr?=
 =?utf-8?B?K2dDTW5jM1R1MVMwcjhLYWJYSU1FUERhKzVKblBDRmRGNHZHR1BhelpURC9T?=
 =?utf-8?B?SUVPQ0h4Q0toZTNRS0FHdjBLSUF1Q2wrbmtWdWlZYVQ1U2kxZExrWDdHUm1l?=
 =?utf-8?B?dTY4R3VYNzhnYlRXdDZaWXF0MGNGbVlJdnpMZ0N6UzJNQk1qektaYXFBWFl5?=
 =?utf-8?B?MFpXSk0yTGpCOUEvTjBMKzFHQlRVNzhWa01zUXZoV24xbm4yVTdOWjdndzFr?=
 =?utf-8?B?MXY3bXgwRE9BMks2MlR5dVNvTW1OQXJSZm1CWS9DYndsWnJFL0pDZXQzSGVx?=
 =?utf-8?B?UjlNTUJ4WjBMVUxCQzVsVnBoME9sMXNYTUNpa2pDeHUrTjJqN0pZUWhmZlg4?=
 =?utf-8?B?ckJ3WVcvTDlYQ0h6eWZ5elFRUnBsRnNIRmRIdml2dFZJNTlIeXZpQXZuQVE3?=
 =?utf-8?B?cmkwRUM1VGQvays1eDJOZzVnbmhRSVh3NUJSWlgxdEJjMGxPK0xMaVIyOUh1?=
 =?utf-8?B?SGhsZXRMSGF6TjV5YU52ZjVUdzJEZFo0YzkrbGZDQk1nNXRZa09uWWJ4SlRJ?=
 =?utf-8?B?OXpSN0pWVkw5VklFaWE4TVhuOUdQVlM1YkZmbmpqbmZZWG83OFNkV0MxUlNw?=
 =?utf-8?B?anYvM0FKNkdJMEtXTG9KT1o3YnBKdy9JRkp6UWZONi9pdjhGTlFHYndPcDB3?=
 =?utf-8?B?cmJBTVVUSE9OaVlWVGw3TFE4MmhTbHY4VVY2QXdoRjMwT2VBWDhVQ28rKzV3?=
 =?utf-8?B?UTFMNlhja24zeGU0ek5GVTlMV0JHanpQTjYzak9VeW96V3orakYzMWJJdExw?=
 =?utf-8?B?emVmb3cwMlBGMnpGTVhyc0VkS3llM1dySGh2OHZzL1JSSG15WkU4dU1BWHA5?=
 =?utf-8?B?Wi8zQ2ZYdGV1eHdvY1hhQ1haaENTQnI0WlhaTTF2UUp0ektta3ptZnlNVlB1?=
 =?utf-8?B?d1BJaEpyV2xTZnhxckVqNjhHTjZ3Mmw5UVEwcXV4YUhCU0c5a09nZm9lRnFS?=
 =?utf-8?B?WVpnYTVobGVQVmlKdnZCcHNxV202Z2NWaVhTTVp6eE92Y2lMVHJWYXRqTGdz?=
 =?utf-8?B?a1NISytxaUpvRGRlblRGV25oM0dRZWJCR2tFSzBVR1hVbTVKOWwwQmpyRUp2?=
 =?utf-8?B?M0Q4MEs0R2JtcHErbkJ1aFBRQkZTS0hIc282MThtKzlqOTFva1lsWUJaMStw?=
 =?utf-8?B?SW1uZkYvaTQ2VzFxUHpNei9JclVFQkdHUG9JUzh4b0tyRFpiT28zaU1FekM0?=
 =?utf-8?B?eStDdWkrc2t1TmRGK0JtdVpQcmhPL0NOMzU0dXNZN3hVL1ZJbEpnSE5scnpD?=
 =?utf-8?B?ck1VZE1QL3hkVWVLeVNRT2VwcFlzaXJuS0NORXJkMURNNmlZc2t4anZWeDZw?=
 =?utf-8?B?YXRLUGJTalVPYk43WkxKZ2ticGRZdVgvL1ZNQTdVN3Y2RjBQYmwrdGRVS01x?=
 =?utf-8?B?dEtZUFN4YllvdWxJTlF1cjFSUDU5YjJDRlZveE1mVERvbkNMTk1pUXVQbWRR?=
 =?utf-8?B?YVVhQndrcFVYYU9OVEhWNCtPUkN3eFRpOGZCT3J6VWVzc3hmaCtFRE4wVmxq?=
 =?utf-8?B?UTN5aVRRQVZyQWZIUjZHcGoxdjZ4dTdvWTRVRkR6OUpNbVVzV0dkb0p0L2hk?=
 =?utf-8?B?SUxCL1V4QUFpK1FjQ2xJNDhWUHdJL2JMbUtFZWZjdUtRdFFUOUpaSTdqbWxK?=
 =?utf-8?B?QVJGcTBrWVBRYnoxQUM2VkVoRkVnK2xWOWNIRzhxcU1mSWtQbnBGY0M3SjRz?=
 =?utf-8?B?UnR1QWlCdUZjNDdNR2pNTTY0ZDFXN1lpR3FwWk5QWFBFcG9BM0ZEbTcrS2dX?=
 =?utf-8?B?Vnc1NTFPc3dBMGVqSFhzeG9aZHFlbzhtSng1Q25UZVJxRVA4N2xuMXBFVkJx?=
 =?utf-8?B?MVErS00wWHp2Wi9UUGt6bDV4WjVKaEszeHVRSmRwb0JwYm5vZElZbEV0clZN?=
 =?utf-8?Q?DLhWMrzS0SRxEpmihhvjPqGFu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa07c13e-c19c-44db-b1cc-08dc9076347d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 15:40:54.3492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qg33NNAl6kzSal+Rsn+ypJnPIp225xaRN38Ax925qaelePFp1c+gKVfRSOy1Milxf0qi5JROfd+WHiYzJVI2lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9047



On 6/19/24 02:09, Christoph Hellwig wrote:
> On Mon, Jun 17, 2024 at 03:04:10PM -0500, Terry Bowman wrote:
>> AER correctable internal errors (CIE) and AER uncorrectable internal
>> errors (UIE) are disabled through the AER mask register by default.[1]
>>
>> CXL PCIe ports use the CIE/UIE to report RAS errors and as a result
>> need CIE/UIE enabled.[2]
>>
>> Change pci_aer_unmask_internal_errors() function to be exported for
>> the CXL driver and other drivers to use.
> 
> I can't actually find a user for this.  Maybe that's because you did
> weird partial CCs for your series, or maybe it's because you don't
> want to tell us.  Either way it's a no-go.

The use is in the following patchset (9/9) that missed being shared with 
PCI list. If there is rework I'll fix so both are sent to PCI list.

https://lore.kernel.org/all/20240617200411.1426554-10-terry.bowman@amd.com/

Regards,
Terry

