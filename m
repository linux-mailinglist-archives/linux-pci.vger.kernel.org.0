Return-Path: <linux-pci+bounces-29122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB51CAD0A2D
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 01:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1740B3B38C8
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 23:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1069A1E5B82;
	Fri,  6 Jun 2025 23:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BEer1klm"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DB51B87C0;
	Fri,  6 Jun 2025 23:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749251727; cv=fail; b=McEVC3OdtihWw23jHQ+jniu85YPwu0oIu+HniJNXXuYNylVO5cCTAKCuFasOLDQ/me+XSnFPOG8ffWRCBnFiI5h19aIu9djLCQoRCWPLOlAQMV86W8S/CwUlM9X4RHwuD7stphqVJeoPjfMiZHe8ew05bqd4Qq61dUHdmtDErs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749251727; c=relaxed/simple;
	bh=67fSMSMeNvaUB9T8C2bofTNvMwx+kQGrrEnkfPTuhvw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K5kqm0gLmNk2koS8rTfUf1pozdpfRsA6HoNlzSaVzVY3uCf1M2+jJQElfhngQlJQUNuNfuu5+sR3vvySRZLkMTJGtr1ig+MkggcO9nkrSNV9hGczGjoSw7xh6y4CBLr5hH6q0bRWTIVQbgHYSzA0XidendoIZzLRAR3gAKLDq8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BEer1klm; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJoevMojogHNIaw2GOTfNyEC4jGCJH56Y+79f+aKwB5MSQfrz+LOMy8S3cta1Io/NEVLnld3Eg0T3vTsCFR5AoQgtMmcs2X+MCtxk7pLMPZuH9XCbxrctE8ECVatOmk8JdiN48KfdiMqRHGIU2WYHGSaGGFc6GMU3Oz1i6M3ZwmlW/1Rt3eEWOklLesyXyMj709WzM1lYKjzYvKAXsVvwZEJa/N32PkAlXp63z03W76my07kaEIbwEt2JQdZlSiIXCH3Lde5TnOC6cTAlmjdTQpUfSLSl1PnH6fg3Q30RZNhaBw7sVV9jBSYvuvb7UMDcBL9ZtzEQixLZnYoAiCunw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6VX37Tw9i+fuafl5vnUgsFdbG1+FXu8stnt1geJ10E=;
 b=Y7y+5ffQ0r417jZ/FzIEoNPGklu3c2onrwLZS12zv/7Iu74KE8NdD9zgF9fzno7Xh/b0ZnaPNEWM/tV95wwS+JbzN1cLRT1c0CUA0bVz+rq+VoDR1/sne4Pn9FPmssaH4hRupLBH0sO/C4GCKpPtCt1MxwLOuEde1jsOa17I314KiyAGynhyXG8jJAg++X0e8tOcdRcWCSj01wZe9XPblx3iMJakn3tDBPaOCOLKsNmFQcT082xeV+RJ5gGed0vuqplWTO62ofGMzlVU63aM47HG/gEWJsIn4gXv581Eudp9wK96mllWfNMVlR5MBz9b/ooH4GXb0BGhLcPDHuJN0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6VX37Tw9i+fuafl5vnUgsFdbG1+FXu8stnt1geJ10E=;
 b=BEer1klm8fC/mEyEb970L7nw+rYyotMUJrFqE4x9I2QtCueaqVyU1sj/huU8J1psvpBCAsDmJhAjZlLbMnVIc1A0d8exsByjH2yxBaUvVK9c7LbduzHZr9tDMnnob80b1sas7ddHmz4KiH0WP2iVZejGE9Q2n6mYpdh9se3duJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH0PR12MB5648.namprd12.prod.outlook.com (2603:10b6:510:14b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.34; Fri, 6 Jun 2025 23:15:21 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8792.034; Fri, 6 Jun 2025
 23:15:21 +0000
Message-ID: <f1886301-3c5b-4c38-8003-dd6cdf43b945@amd.com>
Date: Fri, 6 Jun 2025 18:15:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/16] PCI/AER: Dequeue forwarded CXL error
To: Dave Jiang <dave.jiang@intel.com>, PradeepVineshReddy.Kodamati@amd.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 bhelgaas@google.com, bp@alien8.de, ming.li@zohomail.com,
 shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org,
 coly.li@suse.de, uaisheng.ye@intel.com,
 fabio.m.de.francesco@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 yazen.ghannam@amd.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-5-terry.bowman@amd.com>
 <81214183-fd94-428b-abeb-3ec3d2688030@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <81214183-fd94-428b-abeb-3ec3d2688030@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0149.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::26) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH0PR12MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: f7099117-9924-4cb7-a01c-08dda550024e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2VvMFRQQ1hoNTFqQUZaVWJDSzd6RzRuNGZDZmxJK3dPQThwMnJBS3UvSkJX?=
 =?utf-8?B?VjhqaldIZnA0dTNsZWFnNkVET2E0MmY2MkdTMS83clNVUUYxR0dkNkIxb0Fs?=
 =?utf-8?B?QkF5RTNDYk5Db3lhWjdBbnpzK2MzdEtIT09maWFSb2dFcWl2TVdEMDhQT3F5?=
 =?utf-8?B?UlMzV2V4Rzk1ODg4Vi9mV0FxOUpqMzA2eTB4MlJYRjJMU3NIM3ZLVjhvNU1i?=
 =?utf-8?B?OU9OZHl5dlNhMmIvK0Y2WEFBSDF5K1BMOXo0TVFMWU1YaTVNT2tSWVRwU1kz?=
 =?utf-8?B?TW9kcU1RMGEzSHZoU3M0STUxT2Rwa3hLWmJDYjd6ZDRZTGxRN0FKY0Y3Vjdy?=
 =?utf-8?B?RTNnQ1NEOS82TnM3eE5jbW5MTmhncm9RRXc4QjJwU21hWkFWVW5hRXhtT0VF?=
 =?utf-8?B?TGVFNW5pTDR4MGMwbi9WMTY5eS9CSk1uSU16VzBibHJuOEU0QmthOFhuanpV?=
 =?utf-8?B?UDhhYTFZdmFZQnRhS2lVNFpwOGE0clVPZ3hlaWU3QURkaXNVRG5FQUIwZy9x?=
 =?utf-8?B?OGRwdG1TUEREMmNtakhCMTVCb3FRdXhhMGxLdmM2NXRJT2ZPU0h1aTBERUJM?=
 =?utf-8?B?V1lPaHViQ1BEc0pmNEhJRVF2Wm1LaXRrNGR5NFlMejJoMHpzaTZXUUhybDha?=
 =?utf-8?B?NVp2TnlIUEFBVk82b2xVeW1rTy95ZlA1YW4vNmVMOExjQm1kTVZVVmp1TUpO?=
 =?utf-8?B?RWRJTFAwT0JWVEozTy9wNWFFTEpFdkRTcWdjOXVBYTByZ0NxMm5hVEJpcUNR?=
 =?utf-8?B?WEhkc0FwOW95ZFRCYi85bmd5MjhIS2Uyc3JTVGN0eTZoQUdCTUxRVm50QitW?=
 =?utf-8?B?NkV6TDFERk5mbXUrei9qUENuaWR3cVIrUFo4cHA0ZnNWcFY4QzFubVVobkht?=
 =?utf-8?B?ODJDRStQdzVFOVhQZHFUa3BKQ3c3cTJaQlk0ZDNnQVRwSS9hNHArcDltWGNz?=
 =?utf-8?B?VUVWMEFzK3FZY0oyclUySnJ6RE5yQzhNbUVBZXNDTUNUdno5T1BjbTlySWpp?=
 =?utf-8?B?Nlo0RHFqYncwWGxWZTlobXRTYWUwWThJMFF0UC9wNmVVdTh0YzJTNVBxbnhl?=
 =?utf-8?B?dVR2QlkxbjViTGpLamZzRUtsMnh6cXMzVVhFcERhNlROdDNrMG1GcXdGUXo5?=
 =?utf-8?B?dkFNWmM3eXIybmZhZlZleTN3KzRaZ1hTUzY3amdmbjNRMnJPWWtNaTQyYytI?=
 =?utf-8?B?eXRxM2lCbmRTOTBwc2VFbThkeWVWcndJeWRWZXA2Y3QxT3JUTlRPUm9SeEZ3?=
 =?utf-8?B?dlh5WXU2RjJlT3g5T2k0Z3NCMHdBQjlJY1NmaEhZSlVPY0lqelJmZkFEL2pi?=
 =?utf-8?B?aGpjbXg0SWxwb0xuZ0JxbFNxUmdGYTVuejcraVY3OERrR0h3VkttVFl2L2xI?=
 =?utf-8?B?YkdLTlhUZkNVa3FWMGsrWXpoY1JIK3BBSHlxaVlGTlRFZ2E0U1pYTTB3MklL?=
 =?utf-8?B?WkpIWFFNTWZ6djdabVVyNXMzNGludXZqWjBJTkp2ODZha2x5ZzhjM0NEY3VR?=
 =?utf-8?B?eDZBeHpUS1QybW5aTmhqbmtxTHhVS20xVEJXeDJYY3ZyMXRwelJXL1Q0QUVQ?=
 =?utf-8?B?YmZ4ZzVHbDVwckpCalBNQTlPWDNOZ2NEbFVsVWJHOEU0d2RSZk5pZzM3VWdm?=
 =?utf-8?B?YUp4TlRUcTVUOUZwMnN6Y1lEK1pqazFzRjNZMTMxazNoVE1nOFdodUJWLzAx?=
 =?utf-8?B?QlVqZHRLNkcwNzhBeW44MG9aZGNMVTk5amNIL2FvWG8zV1RzWHNUYlppRGJZ?=
 =?utf-8?B?S2V5TGtDbVdjNnNqVnhGdUpadHhVb0dmZVdQclh1T2FjZ09Pb3gvVU1LdUhh?=
 =?utf-8?B?ajIxZGVyaVg0OWNUK3p2L3NZRU56MnFRTkJPOE51RlVzejQ0bzBieURRM2ts?=
 =?utf-8?B?anRVRjBRbnBnVFE4NmpIbGdDQWdENDNhSHErOVFBbnVFTHlOUitEbTlqTzV4?=
 =?utf-8?B?QTlvZzBzU0NYejlCd0Q3VkZPR1NwOWp4bUxWc25NMENycUd4cmVBRk1zc0xT?=
 =?utf-8?B?bndDU1VncHZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUN3ZU1JN0NrTlEzK3BFL0p6ZkZzbExxeXFUdzZlUzNGWmdwaHBqWmNXd2Zq?=
 =?utf-8?B?ZXgxcHFaUDBxYk83TVJKc05oaFFhN3VVYWNpOXgxSVdOZ0x3ZDM3eGdLek55?=
 =?utf-8?B?R3FIc1c4dkMxSjVPdFhnb2RLOGN4OHhrL2kvT1lsSWVEeDNIR3JqTGxoN2xX?=
 =?utf-8?B?VzJXNWpXZWJid25GaVd2ZWp4ZVorWEljWXI3Y21MR1FwZ2U3VkZwWmpJUnBr?=
 =?utf-8?B?ZW85NXppMUQ3UUJjV01kZXlWMDVyMmRRZ3BjRkdrTTFXbFBTRHo3bGYvVkZQ?=
 =?utf-8?B?UTgzMjVGT21XNzhLK1BraXhxNVR1amZTY0lzbW5zWkIvdDhBK1lTVnVFamlz?=
 =?utf-8?B?V0tBWDcxdXg5TGdGbDAwUnVCSmFhNFNQZjdxdmZvVGQxTGtxRW9lM25uYjJV?=
 =?utf-8?B?TXdpNFViazhiVEVLbC9Xci9nNXo0LzdXcWU5NzMwZ2diNFVTYzVKaTJiQjZH?=
 =?utf-8?B?MFRKYWxHT1RDck94d3RKQkt6LzUzTkZMTzd3N3dDYjh0M0tKSWR3OXRQNGN2?=
 =?utf-8?B?QlJRcWh4UC9Qd0RqSnlvZnlLQVkwdEUwZmU4TUpvZVBPMmVScWhGQ3R2cFRM?=
 =?utf-8?B?aExqSkdVYmJBY25zazN3VE5oNjRkWUR6RXF2ZUNoYTZlMUU0aGlCNlJ3NHFJ?=
 =?utf-8?B?NVhPREFxWkZwV2hkZDBxM0hsSnlVdDNtUXAwMFViMjdWTzlKaGtLL2tSZ1RI?=
 =?utf-8?B?T3lmTkt0VkZYRmk1cDUycHlXazFrWUhGblN0VStGdXlVUDArZkFCblh1bGFp?=
 =?utf-8?B?SW8wazY2aXBSQVJhMExBaDhpMWNWNnhYWjBxcVlTTGRvUkg1blI0dGtucFZr?=
 =?utf-8?B?dm5qWG1hVitpYk40SlRLalpURmRIb1FZNXovT0hhb3BqRTBXUTNncDBqNmdK?=
 =?utf-8?B?WVBCQWQ5SkxxZ2hyNGkyTlFBT1lZQ0I0WFkwaWgyZ0xHMTJJV3NxaGJDVlc2?=
 =?utf-8?B?KytVWW0ySDNDM2F4MUp2bi9DRVdJeG1DVnYxZnJ0L09INkVBTFNXNkZMdE05?=
 =?utf-8?B?YVhJNnhxYVFoV2NibmJuUi9lTkwvUmtVVDlUeHI5eWh2SklEYzBPMHhvVzhp?=
 =?utf-8?B?VlcrMnVhTW1OYVpNemhkazRvdjBKWG0zTnM2SDNOQ0hSbkdEbWFKWUtVQnlE?=
 =?utf-8?B?WDFyakpsb0lUMGVHdUxJOU1NQmttM3VqR3dudG85SkU5aVhDK3M0eFRCeFNI?=
 =?utf-8?B?VXo0aVo0YTNXNVNLRXh6dVhDTDU3Q3NBajlSQVBhSXVVMnl3RVJNVjQyeXk0?=
 =?utf-8?B?VlNQQW1ZdFdHaDQ3aEZKU0xTODZ2VDFZWkluaFJUREF1QU1pcnMyZlZUTk90?=
 =?utf-8?B?T1c5cDZxaEJHNGFXK29IT3d6SCtmQ0NuQzlXaU1oZTkva2Nmc21aRUJOM0Y0?=
 =?utf-8?B?QUhndGlZNWZ1aU51TVMrdnp6SjVubWZQMlFOdzdGYWV4OHZQS2tZSm9sVUhZ?=
 =?utf-8?B?TDJ4STJDYzJSZVN6bm5BVWVrN1ByRVRxY2tHTmkxSmJxKzJSWGI0K0FZRnlv?=
 =?utf-8?B?R0Z3eVpmZjB1RFovdnl3RnFXcDdjc2FraW16MzZCVmVQeXp1ZzNGbis2TWhS?=
 =?utf-8?B?cHhhUllzNHZzYjluSWpmUFBmYmdaMVVIeTUyWkQ2djltd0QzTGg2MWhoZTR3?=
 =?utf-8?B?dnlOdW8wOUcwa2lGaHRScVpGNDhCbFZiZTk0WktKbWQyY2NPd3lDYmw3N3RW?=
 =?utf-8?B?TnhwRkc4UXJLaXFjaXQ5eTFPbzNxemhDQjFSMVVNemdlTzZoTU4rUjFRMmdF?=
 =?utf-8?B?amltTFZjbWZCUlk0UW4wZzJTQkN1Y2liL0cyT3R0Qm5CQy9TWHRVRUZnbGk4?=
 =?utf-8?B?MlFYVzdYYUZnQzYybkNKVU1tMWhHZkI3dXQ0bHR4b2VTdk9PZ2hFbHhBWGlh?=
 =?utf-8?B?M1h2QXR0UFE4R2gxY2xoaWhvUXp6M1NIVTZORDR4YkF2TWJ0eGh3N1M2cEpl?=
 =?utf-8?B?WDVNNUg0OWZFeUtWZGNIWkRiTWdaVnVDQUhQQ0xEZ05neXROaGVzTC9mVmtU?=
 =?utf-8?B?TlZrTitXN1czWmZTeFdwZXV4aElGQk92Z29GckE5cnhISnhmT1JkTXJpZnBv?=
 =?utf-8?B?QTBvSmdJU1VlSi9xZEtoYklKRzdIQ2ZDTjZNSkVFbW1MRGx4K1BCOTI0akZu?=
 =?utf-8?Q?gE7SvEqCtovEWE+Q1hsWLm5Bv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7099117-9924-4cb7-a01c-08dda550024e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 23:15:21.3274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LmZLdCfn9eff9aiYAvLRL++9qDRmfSHOwrAhZaAahTaS0GAmNt+sYKcVzYPgffu4rLnD+5A7dkECNhOTtXSN3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5648



On 6/6/2025 10:57 AM, Dave Jiang wrote:
>
> On 6/3/25 10:22 AM, Terry Bowman wrote:
>> The AER driver is now designed to forward CXL protocol errors to the CXL
>> driver. Update the CXL driver with functionality to dequeue the forwarded
>> CXL error from the kfifo. Also, update the CXL driver to begin the protocol
>> error handling processing using the work received from the FIFO.
>>
>> Introduce function cxl_prot_err_work_fn() to dequeue work forwarded by the
>> AER service driver. This will begin the CXL protocol error processing
>> with a call to cxl_handle_prot_error().
>>
>> Update cxl/core/ras.c by adding cxl_rch_handle_error_iter() that was
>> previously in the AER driver.
>>
>> Introduce sbdf_to_pci() to take the SBDF values from 'struct cxl_prot_error_info'
>> and use in discovering the erring PCI device. Make scope based reference
>> increments/decrements for the discovered PCI device and the associated
>> CXL device.
>>
>> Implement cxl_handle_prot_error() to differentiate between Restricted CXL
>> Host (RCH) protocol errors and CXL virtual host (VH) protocol errors.
>> RCH errors will be processed with a call to walk the associated Root
>> Complex Event Collector's (RCEC) secondary bus looking for the Root Complex
>> Integrated Endpoint (RCiEP) to handle the RCH error. Export pcie_walk_rcec()
>> so the CXL driver can walk the RCEC's downstream bus, searching for
>> the RCiEP.
>>
>> VH correctable error (CE) processing will call the CXL CE handler. VH
>> uncorrectable errors (UCE) will call cxl_do_recovery(), implemented as a
>> stub for now and to be updated in future patch. Export pci_aer_clean_fatal_status()
>> and pci_clean_device_status() used to clean up AER status after handling.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/core/ras.c  | 92 +++++++++++++++++++++++++++++++++++++++++
>>  drivers/pci/pci.c       |  1 +
>>  drivers/pci/pci.h       |  8 ----
>>  drivers/pci/pcie/aer.c  |  1 +
>>  drivers/pci/pcie/rcec.c |  1 +
>>  include/linux/aer.h     |  2 +
>>  include/linux/pci.h     | 10 +++++
>>  7 files changed, 107 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index d35525e79e04..9ed5c682e128 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -110,8 +110,100 @@ static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>>  
>>  #ifdef CONFIG_PCIEAER_CXL
>>  
>> +static void cxl_do_recovery(struct pci_dev *pdev)
>> +{
>> +}
>> +
>> +static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
>> +{
>> +	struct cxl_prot_error_info *err_info = data;
>> +	struct pci_dev *pdev_ref __free(pci_dev_put) = pci_dev_get(pdev);
>> +	struct cxl_dev_state *cxlds;
>> +
>> +	/*
>> +	 * The capability, status, and control fields in Device 0,
>> +	 * Function 0 DVSEC control the CXL functionality of the
>> +	 * entire device (CXL 3.0, 8.1.3).
>> +	 */
>> +	if (pdev->devfn != PCI_DEVFN(0, 0))
>> +		return 0;
>> +
>> +	/*
>> +	 * CXL Memory Devices must have the 502h class code set (CXL
>> +	 * 3.0, 8.1.12.1).
>> +	 */
>> +	if ((pdev->class >> 8) != PCI_CLASS_MEMORY_CXL)
> Should use FIELD_GET() to be consistent with the rest of CXL code base
>
>> +		return 0;
>> +
>> +	if (!is_cxl_memdev(&pdev->dev) || !pdev->dev.driver)
> I think you need to hold the pdev->dev lock while checking if the driver exists.
Hi Dave,

Wouldn't a reference count increment prevent the driver from being unbound and thus
make this access here to the driver safe (given the pci_dev_get() above)? And a lock
would prevent concurrent access with a busy wait when the driver executes the next
lock take?

Terry

[snip]

