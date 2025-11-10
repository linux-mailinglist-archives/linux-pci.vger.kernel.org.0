Return-Path: <linux-pci+bounces-40711-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCA0C46EE6
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 14:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69BF93A3E8F
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 13:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B84A1FECBA;
	Mon, 10 Nov 2025 13:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y5GCRxoF"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA27D199E9D;
	Mon, 10 Nov 2025 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781605; cv=fail; b=ewBUJAWLPmhIqq2zacaTqMc4sEVdPZMYqEVXolzA73pfpNLlX7QLYYiA9DXwjw8iNJJad1Y2zmxjrBS/UJluuAjAppTWS2Tq5jDiFiKm1NsmJ0T2BElRbituwZAzckFumrm2pmNOj36xkK/dc9Yj+Yf1NA6ImCGsFzu2pFXZQfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781605; c=relaxed/simple;
	bh=U2MMeZEfegi6kN3LRAPt4uD2QqgfifZSW5H5VfzAeIE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HQKOidDK8XW/5nUV/EgggGXFQ/gZj2aEAUdj8iZOGDcHXJAmvytUTOW5lUUXCLFV+IHWy29NMKTeyJh3uoGQJwlD0XVwYCL2ZD/255DRLfU0adeVuRQAjW/KpFBCAkVzzo5oNHJ/Lp5kWjqOwl4iRcMvgHjU7T0xna5G/b6b7/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y5GCRxoF; arc=fail smtp.client-ip=52.101.85.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1SAyZkkkTbclGS59rLEKoGrEQMbnUVa0eAqlEUplZ4Ddp8B42J7Iexpv9xkiNPsaBct+SNeNeIbqCgYgF55De1GzpQaAZIhLyWom1Fvk7t8lVY+gpKTL4qA89X+hze2at+b/goajzkXYqaiy7HFmA4fAAr/oL4wdM0NzACwUoHPNNY5hjETuoYUXLv3aALTYM29eGWM0spfcdmvSDc5GcOKeuIBoHhCWf7t45N2Egvb2n75kxpUqANTeN89ZmdWXnN6a5Cz/GHSX+yivp6r8Z2EaFh3b8Hq8N0WmMXweV1/Hw4EN6k7zA/U5jxUodb/qneK65FAw96ysd4qvYI1IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUrkmBiRXX9k235vCITJ3mB04M1pdRmUPQToFbrBiyY=;
 b=kBgPU5gvq/vYCzqkmUY6LI7/IdEzMXn5WcVDaaBkqXSVC0sKk14QVtzOlKcs4X2ArEdmLChUQmiLy93lelCSeVAO5vmMxn5PZhB20J/b8uq99vO4HVvBUXjnCFzhGzDdMZ5kSTxwRW1jVGURDQkXt16wVy3hGEJHDsP22AxZBnXtO3kf4YZ/Ky+nZnqM05onImAvp1Ovl5Ur27ROWXyzWsO5EWbdRfDdLmmElQ+g0UGeOpZZu7wiNpGTkQYsJyqa8d4VqGKi3gljFxCCroUam6DCt91k8u7IUqrV8hX5uA+AhJB1rsPv3D1ca4Me6T9no8e0Zruw14OedBollqKnSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUrkmBiRXX9k235vCITJ3mB04M1pdRmUPQToFbrBiyY=;
 b=y5GCRxoFNU5hR+T0ylyPFjsqQZtjOgoP2Sp9wBnLF3SdvyU70tZ8+o+a0ilIbQ8Ki1MbxGC/xoO7sLFb+2PloHZDcmq9BmTZQcAj/B61raV1+JHTO8mzvaaXYXdb2FqhXvHutRkqQEy4ZolvVmktUJ4td4n+6DL33z3LFVMrFO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9155.namprd12.prod.outlook.com (2603:10b6:408:183::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 13:33:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 13:33:21 +0000
Message-ID: <0719d985-1c09-4039-84c1-8736a1ca5e2d@amd.com>
Date: Mon, 10 Nov 2025 14:33:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION 00/04] Crash during resume of pcie bridge
To: Bert Karwatzki <spasswolf@web.de>,
 "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>,
 linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, regressions@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20251006120944.7880-1-spasswolf@web.de>
 <8edcc464-c467-4e83-a93b-19b92a2cf193@kernel.org>
 <4903e7c36adf377bcca289dbd3528055dc6cfb32.camel@web.de>
 <4a8302a0-209f-446a-9825-36cb267c1718@kernel.org>
 <25f36fa7-d1d6-4b81-a42f-64c445d6f065@amd.com>
 <1853e2af7f70cf726df278137b6d2d89d9d9dc82.camel@web.de>
 <f18bafacbd8316c9623658e2935f8fc3b276af64.camel@web.de>
 <26bf82303f661cdd34e4e8c16997e33eb21d1ee4.camel@web.de>
 <635b6cb19b5969bed7432dfd1cd651124e63aebb.camel@web.de>
 <18e472a0489ee5337465d5dc26685cebaf7c4f8d.camel@web.de>
 <3772b8f5-6d1a-403e-ad27-99a711e78902@kernel.org>
 <0cb75fae3a9cdb8dd82ca82348f4df919d34844d.camel@web.de>
 <ab51bd58919a31107caf8f8753804cb2dbfa791d.camel@web.de>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <ab51bd58919a31107caf8f8753804cb2dbfa791d.camel@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0355.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9155:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bdbb4d2-613e-4c32-0cc3-08de205db73c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUxBRE9zMXhvbGNOWGh5UXZiY0JZcjVkaE1RS0tmRjB4OW0wbWV6R3RJRVRp?=
 =?utf-8?B?Y3pxSWpETEhnWmE0NXplUlhCRGZwd1BIZWRDRWNjK2FSeTdHWDJSbjJPeWxK?=
 =?utf-8?B?cGc2WWtVZk9GTC9TUEpwRmNYUnhEdU5mamo3emVMMXNtNVJCcng5RHI1Yjg5?=
 =?utf-8?B?aC9QdHBiT0lBcnhySE82RTlvQmdMWnVVK09WQnJjTWN4WEYvWm9DMTlZVFZ1?=
 =?utf-8?B?Q2NRUytsOGNzb0h1dnYyNkN6dy9Bd0NJb2lMZEpwTmFLMHNXSHdqeENCckJM?=
 =?utf-8?B?RE9SeWs3RjIxY2l6bzZVWTluSEcxQWIvdHNLQlBoRm1acUVNQUhBQTNCemo1?=
 =?utf-8?B?ZWwrS1kxNmw4VUFSL3Q1anQzYXhvTlFLTHI0aXB0MjYzeGpKaFBQMG12UXRP?=
 =?utf-8?B?ekJsbkdkeVlFSjV6M0FzRW9YNFR5OEZpNlZZMVFGMTM3Wmk1dXVlVUlEa202?=
 =?utf-8?B?azFmdnZJKyswREpJd2VWcHlrWUlEMzU3a3ZWL0ZOcWxSVmNQaEUvSVNYTlVy?=
 =?utf-8?B?WEIzazZRVlZDUHVuR09QcVIxRzVFN3VMdHcrcytIYUZwdXA1dzQ3SWFURjRi?=
 =?utf-8?B?ekpSR3g1MWFsWGxFaUFCVVBQSFpJcTk3Y1ZHbDJFaUhyYWlmMDc1a0V1V0xS?=
 =?utf-8?B?cmNnMTBnRHFka0VIOTh4dkFkZks5QmdRYVN2bERoZjZxUkhxS0xEZFFwVHR2?=
 =?utf-8?B?cVhYaExzek5lMXN1R3YyaUpySGxlcXJDaElYQUxwOHJMVkRVZEk2WEJ1Nnpm?=
 =?utf-8?B?SWV6SEVleGNqTUJ3Wit3THVJRDVQNWw1RjZZY21VZHlHWFZES2xEU0JtK29Z?=
 =?utf-8?B?MGwyaDVkeU91dFpjYUlOZTBLWFp1VGhGN3M0SGZIZDNwSlozUjhGTTlSUitW?=
 =?utf-8?B?OWZBb3hiMFZpdmMvdDNHWVkxNFNFaHRJcXZJb0YralRUamNmYkNPcVR0bjBS?=
 =?utf-8?B?K1RIRkF5M0ZBN0JJNzJ6U2owZmZxdGlWY3lkKytFdmltc0JISTZOaTBleFRn?=
 =?utf-8?B?NnpSeGZFSUVSUC9NNTgyTGx6alJXNGppMSt2M0FqUkdUOUxldTNhUUlWaFJK?=
 =?utf-8?B?S21OVWpmUnFlcjczRXB0WDdGaHZSd2VHMVZvRTJ1bXdWSGlWcGFhZXlLNFVl?=
 =?utf-8?B?WmhsZkU0VkpUWVpuQ2orVWp4ZllhUHhRTVhBR3hRYmc4QkEzYkV4akN1UU1F?=
 =?utf-8?B?cFg0SEpoTFBHcXltMUR3dndxR2t1V05JbWlQMEpxbit3US9WZFAwZ01ZTVVn?=
 =?utf-8?B?aE5lT0JPVGswUGpZY0ExZGMwSUJSdzg3eDB1Qlk0Q0RMdWFSSXorbTRKdDFj?=
 =?utf-8?B?S0E2VllhQkxlZjRvSUJvK24yUnVBSzNhWWV0RnJFV2FUK2o4bFpiNEZXY045?=
 =?utf-8?B?MlJRYnJxa3AxbDZRRVhyd21VUHloTjhzRkxkSmRSL1ZIc3hZbjFvUDNBcURr?=
 =?utf-8?B?SU1NYUttRDhQbUR1cEFpQjhNdWFzbjB1d3ZFeEovTnV2aUcrZG96YXJ1NjQx?=
 =?utf-8?B?blVOTWVXN3J2Y2RaUXRpb0R4ZXFrSnVEQmVYZHh1MEFGLzNPbEZXL2xhUTI5?=
 =?utf-8?B?WjYvSHdhVGJyckhURWMvL3ZrMktacUQvNWdzaWZOWUdGMHgzb2lmVFd6ZUd0?=
 =?utf-8?B?M2tNa3c5WkQ1bTR3VVQxOUJWMExtTDIwdnc4M0tMMzdoNm0wOGtHL0ZWUlRU?=
 =?utf-8?B?ZU9YSUVKd1VzM2JkVCt5Z042YTRnMUhoaGw2T1IzTFpKNHl6SlVnVm9SVXcz?=
 =?utf-8?B?SnZVeTVsNnFKa3NwZU1yVzhEWmlRYVJaQUhhcEkrcis1UFY0WUpkZFM5QXFP?=
 =?utf-8?B?KzhlWkU0V2tJVmdxdVpuQUU1M0x3TnQwVmhkOXUxVmRPQmh0MTkxVlpyMHVp?=
 =?utf-8?B?akErWjdCeS9HTXpLMWF6Z1RPMzh6SWhGbjVMRlBJaTNEWHN0SmQ3aUtRTUNY?=
 =?utf-8?Q?pejuWsCLr4MtisVg5uB8nWrmt2flwIV4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGdmM05tVGpDVHN0NXFvcWQ1QnZpL3k1T1hlU29MS2hZdDJzRng3KzVxWkIr?=
 =?utf-8?B?Y1FudDQwU3VqMy9WUlJodVlzUUowYU5RNmRCdnhkNERuK1hRcW8rYlZBZW1m?=
 =?utf-8?B?bWo2N2o2YWdiRVRuN2lVTkYxWDZySlVUTXVHbUM5RFdSWkNTc3hMSWJiWUxD?=
 =?utf-8?B?S1RXOXFmWms2Qk9QMXNJRW1vdGEvY05WbUVUbUV0YUxTVjJlSytKQTlYNS8r?=
 =?utf-8?B?Y2J3WTdjV1JUK2pGdnVuaHFlMUNRdHNTVC9SR3F3MXczN1NxLzBPbHdVWVlW?=
 =?utf-8?B?WTFRTzdJQ0ozcVRBaHI5akpvL05DNjEzcjFpK0dXR3dKbThzdnd1Wi9CWG1P?=
 =?utf-8?B?VTNQUnN4N3lGcGpKS2VRUkpVSTJGcVBGdDZKUkhqNEY1ZEcwejB6RDVEcmxa?=
 =?utf-8?B?U1hJQllISFZXRUpIbUVXSm5INlFJSzI4ejFNT0g1bS9weGJmNHFta1pGY1Qx?=
 =?utf-8?B?TDNha29laXc3TEVBV2VWdEJuU2RqcjhpSzMrZnhDbjFPbHQ1MVBubDBrUWxG?=
 =?utf-8?B?MFdIUTFMUjAwV3gyRHhYbFdIZFRxNEkySUFxMDlxZG5iaTFsWVYzNDBqTVNX?=
 =?utf-8?B?UlVtVGl4WnUvcmdIN0FpVnNpSjdIVUhlNVgxbGNvbVVVVXB1UmRZS2hKSHlM?=
 =?utf-8?B?Wno4b09MUktUYjI4UWVrSWFDZEx1MTlZVnhiN3htT0RTU2c5Y2VSTWFxS29Q?=
 =?utf-8?B?MzZETUFaLzh5S0kwR3lsSm00OEV1OUhIdkpEMldocGhQUjVSeVFVRkYzZDd6?=
 =?utf-8?B?LzJrQnVsRThqQmxhSi9ua2tZQkdtVDdCdFhuVURFNG1rbS80eWR6SkowR0JB?=
 =?utf-8?B?TVRRVThlbkZCalM1SEJtakdrZ1FmZzNXa0h4VWYwQ2JEUDhtZGEyM1ZaVU95?=
 =?utf-8?B?T1JBNXB6WHYzdG9qbVlTSGZsTTJSRlBueitTT1hQbXczMlNuTmI0VXZycno1?=
 =?utf-8?B?Qk9FbkpsR2daNnM0RkpaVlVtR1hKRHlMdFNvRXVKa2dsbytUY0FqZWxrNEdj?=
 =?utf-8?B?SjMzS0RncEdVT1dYbkxtbzNneTBqbTdqMDBscDcvN1diSzQwNXl1bCtKZGcz?=
 =?utf-8?B?Z3h4MzZqYTE4OTZJNllFQjVSeURTVlVVbHN2NmNSRlZSbWg0a08xZ3pzT1RI?=
 =?utf-8?B?bFI2Um45ZXNWWW1YSEVJYjBpdTlzT3lQRGdCS0FIeUtCUE1EemRmYWkzeXV6?=
 =?utf-8?B?b3V2STVhUzZHQi8wUmp2SU5YTHVHQ2tlZ2I5Q010WEYrNHRWZ05WQ0Uvd1pw?=
 =?utf-8?B?V0oxMXJqWXd3MWZCTW1OTlNoU3M1Ny8vWFJpV0c3ZWppQldtRDE1dWRNRUM1?=
 =?utf-8?B?K3VScGV1a3FpR1FNdkdneW0zeE9mT0k2amZkS3NuUWhJU0t2bVd6Wm9YQVlT?=
 =?utf-8?B?bDQyZmtrb1VOTDJwRUY4NUpSaDJ0K01rMm5kSTdWeVA1K2VZSWdUN3pzczZS?=
 =?utf-8?B?TlFxK05jR0tFSG41T0Y4QitaR3hpWjRxUTFGdmtjMTU1RkFCM1oyUUQxaTdC?=
 =?utf-8?B?WTZtZzY1VWVXNFNCRXNlZnFSaDA1d2Q2WWI0VTZDVUhpYzJ5TXk1VVlNa1My?=
 =?utf-8?B?K2IwcGF4SkpwV08xV05Ka2VSMU02QzBnY1k4czBmeDRCSVhxNjRPNXlJdXVE?=
 =?utf-8?B?MmNKK2xkeklQTEd3OGxESlpKQnI3a0ZMWjEvNzlRakN3U2FuR1o2ZVNRQWZB?=
 =?utf-8?B?aGd5cXA0U25vdE9KL3JqMVJwS25kTDRJcG8vU2FTMFNUK2QwaGh5SW1OT0xQ?=
 =?utf-8?B?TFcvSlFxS2pmcGJ2ZURta25VazBaQmwxVmZCS3VtWGVsdlY4SllybVZ1WjBJ?=
 =?utf-8?B?NnZtZkwrQzh2N0x6Z1Nac0lqaHpHdmtSTjMyQ1ZhQ004K1Z2V3FmZzAyMVg1?=
 =?utf-8?B?dTI1MFVMbmZFeHJvSFpTRjl5TXNsc0Zqc0ZKb2MyU1ZKSWxXdkRZN2J6eTEx?=
 =?utf-8?B?djhCcjVQbXcxdm5sUjB6L0I0OXBXR0Z3Njc4SEIyN0xLVlJRNlU5bW1VdGEy?=
 =?utf-8?B?YVFzMmJ4d1Z1dGhXaXl3bGF4dEVjbXkxYXdCRElrc014MGl3VGV2Y2trR0xV?=
 =?utf-8?B?aVBGY29oYW9DMCtVamlPQU96MGN6STJVZGdydG9USjNoZ3NUc0JDMW0rUW9o?=
 =?utf-8?Q?Rpbo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bdbb4d2-613e-4c32-0cc3-08de205db73c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 13:33:21.5501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YR/EfmU2vWKTrsTngsbTyTtJT7vxhqu8tQzxqag46vpG7FhqX6ehQnBw5EMn7m4n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9155

Hi Bert,

well sorry to say that but from your dumps it looks more and more like you just have faulty HW.

An SMU response of 0xFFFFFFFF means that the device has spontaneously fallen of the bus while trying to resume it.

My educated guess is that this is caused by a faulty power management, but basically it could be anything.

Regards,
Christian.

On 11/7/25 18:09, Bert Karwatzki wrote:
> Am Freitag, dem 07.11.2025 um 14:09 +0100 schrieb Bert Karwatzki:
>>
>> Testing:
>> v6.12			booted 13:00, 7.11.2025 no crash after 1h, 890 GPP0 events, 287 resumes
>>
>>
>> Bert Karwatzki
> 
> v6.12 crashed after 2h, 946 GPP0 events and 499 resumes. So there's no base
> for a bisection. 
> 
> But the crash from v6.14.11 gave this error in netconsole:
> 
> 2025-11-06T19:17:34.967439+01:00 T370;[drm] PCIE GART of 512M enabled (table at 0x00000081FEB00000).
> 2025-11-06T19:17:34.967439+01:00 T370;amdgpu 0000:03:00.0: amdgpu: PSP is resuming...#012 SUBSYSTEM=pci#012 DEVICE=+pci:0000:03:00.0
> 2025-11-06T19:17:34.967588+01:00 T12;pci_bus 0000:03: Allocating resources#012 SUBSYSTEM=pci_bus#012 DEVICE=+pci_bus:0000:03
> 2025-11-06T19:17:35.143353+01:00 T370;amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000000 for PSP TMR#012 SUBSYSTEM=pci#012 DEVICE=+pci:0000:03:00.0
> 2025-11-06T19:17:35.226021+01:00 T370;amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not available#012 SUBSYSTEM=pci#012 DEVICE=+pci:0000:03:00.0
> 2025-11-06T19:17:35.237386+01:00 T370;amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available#012 SUBSYSTEM=pci#012
> DEVICE=+pci:0000:03:00.0
> 2025-11-06T19:17:35.237386+01:00 T370;amdgpu 0000:03:00.0: amdgpu: SMU is resuming...#012 SUBSYSTEM=pci#012 DEVICE=+pci:0000:03:00.0
> 2025-11-06T19:17:35.237386+01:00 T370;amdgpu 0000:03:00.0: amdgpu: smu driver if version = 0x0000000f, smu fw if version = 0x00000013, smu fw program = 0,
> version = 0x003b3100 (59.49.0)#012 SUBSYSTEM=pci#012 DEVICE=+pci:0000:03:00.0
> 2025-11-06T19:17:35.237386+01:00 T370;amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched#012 SUBSYSTEM=pci#012 DEVICE=+pci:0000:03:00.0
> 2025-11-06T19:17:35.509600+01:00 T370;amdgpu 0000:03:00.0: amdgpu: SMU: response:0xFFFFFFFF for index:6 param:0x00000000 message:EnableAllSmuFeatures?#012
> SUBSYSTEM=pci#012 DEVICE=+pci:0000:03:00.0
> 2025-11-06T19:17:35.509600+01:00 T370;amdgpu 0000:03:00.0: amdgpu: Failed to enable requested dpm features!#012 SUBSYSTEM=pci#012 DEVICE=+pci:0000:03:00.0
> 2025-11-06T19:17:35.509600+01:00 T370;amdgpu 0000:03:00.0: amdgpu: Failed to setup smc hw!#012 SUBSYSTEM=pci#012 DEVICE=+pci:0000:03:00.0
> 2025-11-06T19:17:35.509600+01:00 T370;amdgpu 0000:03:00.0: amdgpu: resume of IP block <smu> failed -121#012 SUBSYSTEM=pci#012 DEVICE=+pci:0000:03:00.0
> 2025-11-06T19:17:35.509600+01:00 T370;amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_resume failed (-121).#012 SUBSYSTEM=pci#012 DEVICE=+pci:0000:03:00.0
> 2025-11-06T19:17:36.114889+01:00 C8;INFO: NMI handler (perf_event_nmi_handler) took too long to run: 35.314 msecs
> 2025-11-06T19:17:36.114889+01:00 C8;perf: interrupt took too long (275880 > 2500), lowering kernel.perf_event_max_sample_rate to 1000
> 2025-11-06T19:17:37.930799+01:00 C4;INFO: NMI handler (perf_event_nmi_handler) took too long to run: 152.914 msecs
> 2025-11-06T19:17:37.930799+01:00 C4;perf: interrupt took too long (1194640 > 344850), lowering kernel.perf_event_max_sample_rate to 1000
> 2025-11-06T19:17:38.939845+01:00 C14;INFO: NMI handler (perf_event_nmi_handler) took too long to run: 197.312 msecs
> 2025-11-06T19:17:38.939845+01:00 C14;perf: interrupt took too long (1541521 > 1493300), lowering kernel.perf_event_max_sample_rate to 1000
> 
> These 4 lines have not been recorded previously, so perhaps I have to look
> for a NULL pointer dereference in an error path:
> 
> 2025-11-06T19:17:42.571252+01:00 T1896;ACPI Error: AE_TIME, Returned by Handler for [EmbeddedControl] (20240827/evregion-301)
> 2025-11-06T19:17:42.571252+01:00 T1896;ACPI Error: Timeout from EC hardware or EC device driver (20240827/evregion-311)
> 2025-11-06T19:17:42.571252+01:00 T1896;ACPI Error: Aborting method \x5c_SB.PCI0.SBRG.EC.BAT1.UPBS due to previous error (AE_TIME) (20240827/psparse-529)
> 2025-11-06T19:17:42.571252+01:00 T1896;ACPI Error: Aborting method \x5c_SB.PCI0.SBRG.EC.BAT1._BST due to previous error (AE_TIME) (20240827/psparse-529) 
> 
> 
> Bert Karwatzki


