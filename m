Return-Path: <linux-pci+bounces-36773-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E689B9602E
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 15:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48678162BB2
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 13:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5EE323F7B;
	Tue, 23 Sep 2025 13:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="flRW5P8I"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011055.outbound.protection.outlook.com [52.101.57.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09897318141
	for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 13:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758634145; cv=fail; b=WjIEZlX383mbyaoyLTMWqZ3E62cWjlezvVsh8WsKg2AkkaL24dfTqiOmSrA5h4ob8M9Lwsb6naxD3juTKta0pl++/3zEJ+tO45eazWsk56ZAvSzO2op6SJ0Ao1aTbvWw8qdUCa8R3okuXwS5jtbN9ms+lrGsUlBKSmt7XcMpo7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758634145; c=relaxed/simple;
	bh=WCY4uTG2qz6OE2pSGJGMjg0CNVgzc+6PkwDlivDn07U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K3eL6o7Q3c4PL1HzWvVX+/U67FYm5FBg9iikjVF2a0kxEq7+BvFIre5oHBFNlgO9kZoRU2oimBFGbtmd2ZlsIrlms2tMfwfllrXJB5ymqTh7KFflK9u/U2e+1vGWim9W0DYiqJzEwaEMmjscGNiXrPYitSVUaToUtmpCR1fcIdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=flRW5P8I; arc=fail smtp.client-ip=52.101.57.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dq3xUt9ntkPxTFRQQT6Ttq6/xDVe5jZb2JsPbaUPi+ZPu5DookBVK8saUWzt4w99jsBXL5L50LTMlxo0rOjJ/nN0aBSvqs4/uhw/xzMaS7JKZPvUxu+1erOokPGKYfgHv+pEIA9EVP1txignW6cqWImzcnXeMqZ39rUUQ5i2gIALIdmc+wms+vabVadxTDdOU8k2SJTgUkPt7z60TI87DWRHULl5DC6RkLXE7klUtDVIxsYv4Gzrg+PGntxjFTliuwwYio+82GIHu8qgjgBLLa/TZqvEJfN9cJBCTuKZ9I4KGbuGSFeTD1PZyBUPPnXIEFuDEyhn/rBV+Ehuj2rZ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LUybMtmP2hhxSfIFWvgsGfL4/MHXM5EsMukoQ7uvbo=;
 b=xb/zosXPag2QQQUhumE4FPQJ9qoIC638LoXxgj+kXBsrEV1wCpZPsNAPxGr1qvhCO+IgWO02obL9KK01a9BiEXvMrY4qtSvqsHNeAr27I3Baq3r0/gN8FIXqJNOG7FQ9ajUZZfXTlyAhg6Ov/WXdFZubmx4yWOjao4bgT2r4senA/FLGgSAbWhX77YjApUnEZSaMkZErq+MQORBisap10GvBIb925rZrSrjElzPzFgO65MkRWZib8gS3ktdSxUAYBFiGCsxx63VeCX6/uTLfmxCV5PJKJcbJ5QOOnF2qUXKsN9tcHmginsHt3kcQapsUgNGNwVRe6/KfSVdvXHrB6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LUybMtmP2hhxSfIFWvgsGfL4/MHXM5EsMukoQ7uvbo=;
 b=flRW5P8IbEvaTknmpbPJnqBcUughV8nCXL6uODLrYEZ+Z70Sc8gYgYQA3XRgonKI0HM9olsGLy5+fHx3+IUzNWW5QbWJ9VD0yFe45TOi1tsqkWaR1Od9nBpmeEsBtuV6/4K/W63y4ggcAfzadFkPRQjZFnjIufMGGKjuchc6VBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB7764.namprd12.prod.outlook.com (2603:10b6:610:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 13:29:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 13:28:59 +0000
Message-ID: <8da25244-be1e-4d88-86bc-5a6f377bdbc1@amd.com>
Date: Tue, 23 Sep 2025 15:28:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] PCI/P2PDMA: Don't enforce ACS check for device
 functions of Intel GPUs
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Matthew Brost <matthew.brost@intel.com>,
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
References: <20250919122931.GR1391379@nvidia.com>
 <IA0PR11MB718504F59BFA080EC0963E94F812A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <045c6892-9b15-4f31-aa6a-1f45528500f1@amd.com>
 <20250922122018.GU1391379@nvidia.com>
 <IA0PR11MB718580B723FA2BEDCFAB71E9F81DA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <aNI9a6o0RtQmDYPp@lstrano-desk.jf.intel.com>
 <aNJB1r51eC2v2rXh@lstrano-desk.jf.intel.com>
 <80d2d0d1-db44-4f0a-8481-c81058d47196@amd.com>
 <20250923121528.GH1391379@nvidia.com>
 <522d3d83-78b5-4682-bb02-d2ae2468d30a@amd.com>
 <20250923131247.GK1391379@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250923131247.GK1391379@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0349.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d79140-1fce-41ca-440b-08ddfaa5276d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VktCMnM2VUsxLzhYakMwK2MxUGt6QW1mVGRCb1plMmJudFJiNmNMYVQwdEdZ?=
 =?utf-8?B?MVViMStjUnBwejlwK3l6ajBJMVJtNmFFdGROWHFjb1RxQWd4NGVmMGIzYkNw?=
 =?utf-8?B?RzcwSFhOaG56Znc0bjA4cFlnYjVMdk1YMXBSOTVobkVVcE1aekNpTXg0UHBl?=
 =?utf-8?B?cFVnNFpuMC9NNHNFMXo4aVh6RCtWNCs0UGs0MTNHTWMwcnVjcXB3UW5VOU5m?=
 =?utf-8?B?UWNkZy9WOW1uSlA3UTZmOXd1MkdkM0llM2tBYm5rZDZZUFlsR21GN0tBYzZr?=
 =?utf-8?B?M1pFTDhpVmcrNnBoTWhSMGNrdzlSVXN3ZDZ4NFZrcXcyV3o0WXQvSExjUHlG?=
 =?utf-8?B?MkU0UUgvbkJJOCtVRjBvaXhEQjJOM3Z2QUhHZWxNWTl0WThNTy9rekhYMVNy?=
 =?utf-8?B?TnlNYkV3Q0RBck4wcWNNa1lvbldoaVVkd3VXRFNCZmRkN004a2lvUlFlOCsz?=
 =?utf-8?B?clJUTVdJM1J2OEl6T2ZxQnFHSVVaSi9YRWg2VkMvKzZPRG5xV1pMaFR3ajdw?=
 =?utf-8?B?UTBGeXZ0MUcvNTdreGYyUlh5UmxIT0kwRmw3c2lYU1ROVWtzNERoM2FxTWNs?=
 =?utf-8?B?WGNMUHYrK1lEWlJoVXlCTnVHZXZ4T201cXR4MWlua1N4L3ZLREo1cS9QdzFL?=
 =?utf-8?B?K21RVU44QlozcmY4a0tUd2lNNllZWG5GdGhYZytndzZLelFieXZkRjdMaGNC?=
 =?utf-8?B?dUcxQUZkNEMvM2lCTnlRRXJORUFiSkJPTHNNSnlTYnFGb05ZZlVRZ0c4bHhx?=
 =?utf-8?B?c0FOMlRzSENuTGtNK0VwL3VQa0ZCQzQyZGxscWpSLzkzVHFENFpWMnpzTnlZ?=
 =?utf-8?B?eGx5NnBJQ21zdGk1djdKTHNEOXlOTUExek00NmZaS01ZMGd0NFFld3g1VmVO?=
 =?utf-8?B?Vk9pN2piT3NhRytHajNWd1RpSzJnMHN5VWxheEdNNVVZODgwNjVnMSs3NXYz?=
 =?utf-8?B?RDVvVm5XSGQ4b09QNkZRME85eHNyWDh5LzhyWWsrdWM4VWs2RmsyMFZsWUxu?=
 =?utf-8?B?Nng1bGE2dkMrOEtrMXVOSjdvOHpxMjBSZkhKUUFpZi8yR3pKR0lHTGNmaTl1?=
 =?utf-8?B?ckFoNkJpeWlzQkFpOGRUZEZkbWU3MGcxTGRUdEJzclVWZ0lBbnZjV2M2SUln?=
 =?utf-8?B?ampwWlBLdHlIaERCWG13WEw4V3pqRjA5aG9SdjAwcHFDVktMZUxpVWQ0Lys4?=
 =?utf-8?B?WTc2M21RK0E1eUxmMm9rRE5ZdFVZOUNjT2dBaU1TT0N0VUF4bU5mbTF0U1BE?=
 =?utf-8?B?U3VpelFHdFl5N1pGc1pqNGZFTXJVYjAxZjBRVnp5QVEvRU9tLzJJd2h5SW1N?=
 =?utf-8?B?aStrU01YUStsb0Vtbmx2cXhJMW84QWhSdEJTWmlLNFBxb3VWV0pyODFwZWt1?=
 =?utf-8?B?MnI3VGlubURuWm0yY0N2MXdSVlJjREZUS1dBWGtqbzEwbHFWbVlSRTVFNmxj?=
 =?utf-8?B?YisrdE1COHBXWTY5WnVyTkZSb1dtZVZBcnhvVnExWHpGUHlYbDdtK0crK05B?=
 =?utf-8?B?YVd2ZUZMVVI5R0J2YVZ3MkMrMHZ1eDJjUWVQV0NsQ2VrRWlUSlVyc1U0bDRU?=
 =?utf-8?B?SGYxTzVoeEloaXBodmdZakdiTTlMVXM0dDlabzU0VUdWaTlHU1lRNWcySFFH?=
 =?utf-8?B?VmpGaFo2ZUg0dVMvNHVQWUtjMGNxbG95ZUtaWWZQWG00ekV2dU1MUkFWcXBl?=
 =?utf-8?B?NDlJMHhTWlROU0pUbGx0MU1vQ2h0dml0cjZzOTdoN1N5Z1NLQy9MUCtqTTA3?=
 =?utf-8?B?WktOWC9WQWNXY09HQTM1aW52cEpNQUdPMm5YLzBSbm56ay9vYVU4QURTVXox?=
 =?utf-8?B?SU1BR1dXNGpEZ2EwcDRIVXgwajhzL2hmTzlIajR2NXF4Mld2bkNsL0hSL1pJ?=
 =?utf-8?B?eUZ4Z2psOXNITmVKQXB2V3VaZkErcGQ0alUzc2VkNUYxOFluZ1VRWFZTemRM?=
 =?utf-8?Q?6Eb6rS45pak=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2swRWFQbXE4UFJlR295RWVkSFJ1MmczR3FIc1ZpaDVCMm1rQUpEZFpyY0hl?=
 =?utf-8?B?MVI3MFpxck9reE1GVXNTRzNTSWVqUWd6dXRFN3FjR05ST1B6c3NjUDdGY0FQ?=
 =?utf-8?B?SUtCelljcW1ENVQ5bTBTQSsyYkxESlJuSE4vdjlhOFh5YVdDa3kzRmZzNmhW?=
 =?utf-8?B?SUlmc1RVYXlqUFVOL3hNSG9TbTZxOGg5OEd1SUlwSDFIVmtsMWZic3M4V3lO?=
 =?utf-8?B?VTZRV1NCdi9lZ29kUzRBMHVSZlZyRTF3L0w1SWNkUmtQZmZFWFZRekNJeUhZ?=
 =?utf-8?B?YndPQzRrS1FRcjQ1bWFyQ2NiTU9STVVyYVVCSkdFUk5Ba1FaWEl4MEplQ2Fs?=
 =?utf-8?B?RVMwRXpkTFBLZXdManZBNmx2WG5RTE15ZXZQK3VaTEZQcVZSeWJtaVpkKzk1?=
 =?utf-8?B?Tjc2WTVHUjJWaXB6Y3BTdjZDWC9sVWJCbURMb2M1LzlNTnV6VHZRVzB0TlFH?=
 =?utf-8?B?UEZkeUpYQTgrY2RSL2M3cnhBeCtSNXVsMGo1c1pYb2JnMm9WU2N3SlFQYjRy?=
 =?utf-8?B?enNxOGV1czBMa1cwcm5zM0x5MTBDVTRwbk9TZWkvdnBOZjU1b3Y2anB4bW9i?=
 =?utf-8?B?OWtHVFZnbnF6UVlmbEpjTFc1MThBRUN1S0d0bEJDUEV2anJ4OCtEWTZqQlNG?=
 =?utf-8?B?MkxJWG83eEZPVWVEWEZrMVRTdFJFTEdmTnVkUUtnOUR0UUhlQnJmZ0YrU3ZZ?=
 =?utf-8?B?Y0UvTHVkSXg4NmRKTU1OZW9pKytYQktOVHN2SGxvUE5rQnNHMi9pVU9Pcjhp?=
 =?utf-8?B?elFmYkI5ajluMXU0NkxpYUVKMTl1Zkxna3JnRXR5VkZ1UVl4Y0ZsazNXSkV2?=
 =?utf-8?B?NHZDU2tRdTBZb2FlUTJvMkdRTnpob0V0VHZ3OWxnME1VRHFLcmNhNm40ZHc4?=
 =?utf-8?B?YWRWdkdpQjFxcWwxUHoyQ1lGMHJrNTA5RUxrNisreTdldk5hckt0RDJoZjA3?=
 =?utf-8?B?YnowSCt3ZGV3NEJwYmluNk9YNlhyQUNJZ3JDQkUyMHp2VXpoTVRQbHZiUVlj?=
 =?utf-8?B?WkNrckhqWkxsUk9RZVBMRlNuR0kwTFFuSS95ME5wSUNqeUkzQ3QvQWxXZ1Zq?=
 =?utf-8?B?d28vTjg3VkJyTUhmcUUvZEM1U1A5ZDN0N2tNRXozWUpsVWlDNkd1aWh6dkFl?=
 =?utf-8?B?RkdIZ3I3MzFOd09IZlhtc2hmdHh2Sld4aTdXbGhPSTQvK1RoamQ4cHhHcDV1?=
 =?utf-8?B?cm5MN2dNRFFjdEplNzVBODJhOFBCOVQ2eXhKTU9KZ0J5NnFYanNwZFlQRTls?=
 =?utf-8?B?MXhFS2JudWg4SCsxVzJIRUlscnVJWTRTOTl2RDVDakU2S2ZBYWlqSkJQekpJ?=
 =?utf-8?B?eTlzZy9nbnVHOHJreHdxL2NRWU9DY1FXNk5aalQyWFV5SGZOQkYyd1RPR0xw?=
 =?utf-8?B?U2I2cXBJbFlBdzJ0UFA0MXdtd2ltbm5tdHh4ejFGa1VnUUNKYXorWkhwTklr?=
 =?utf-8?B?eVhJQ1RMNW1aNUxBeElFMThPYnBtRGs2bHlVUG5vaDY0TlQvanlWNTJyamYz?=
 =?utf-8?B?RDI4UXk4UjFsTnJ1cXV5NTFIM3lTNnV1UUMvVEdJMFkwd242NnJSQ3AzRjZI?=
 =?utf-8?B?RzRZZWsyU0pEUFcyMnhjalJVV3NqdVRPMFpLWnYweG1qV1dwQVhmd2gvTHFP?=
 =?utf-8?B?aGJTa09UNFdleXZCU1c5Um1Jb2ZkTDVhZU1QcS9iM04zYkdwb2QwV0tLN0pJ?=
 =?utf-8?B?NUd3WG94TmgxdGZmSVdRUzJZZk45dnowRVh3d2RuZlYwNzVBcjlVbGlaZ3hH?=
 =?utf-8?B?dWJuWWpWbzM2RStZcER3VjhrcHd5U1VuQTcvYWFINnZXa0ZiQ0FCOGxTZFBt?=
 =?utf-8?B?K0ZwM2xhbnBxUy8vUDdzWlg0NHdlV2ZMLzYzc29uN1ZXbEhyaktEVXQ3ejRq?=
 =?utf-8?B?WWlyVXQvMDNpVCsrUE8ySHMzWDJ5RXJzaUpOTG5HVlRXNHJpZGtEMmxoQ0xL?=
 =?utf-8?B?UHhMbmhZYmNoNzFESkhTVElJTFliL00xNFhBY1B4U0QvazNtYXpIVzU3cXJq?=
 =?utf-8?B?OW52Z01YUmJReXRkSFJSMnFIV1hZSGdXaGFob3M4QmZzWXR5SnpaMGdoV1Zz?=
 =?utf-8?B?TFR6VjFZVzF1bHZQdkxZNmhLK3UwclRpdGMvRWgzdVJIM0hDeHJWc2E4SkZS?=
 =?utf-8?Q?BmdGsJO4/xBrTsBMiw59lMWsp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d79140-1fce-41ca-440b-08ddfaa5276d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:28:59.6025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /kBA6l5BTJL1Loe6Pd7AZwOe2n7ThbUy1IAh1lxnCf9GOdAM13QmRCmblHubeGIP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7764

On 23.09.25 15:12, Jason Gunthorpe wrote:
>> When you want to communicate addresses in a device specific address
>> space you need a device specific type for that and not abuse
>> phys_addr_t.
> 
> I'm not talking about abusing phys_addr_t, I'm talking about putting a
> legitimate CPU address in there.
> 
> You can argue it is hack in Xe to reverse engineer the VRAM offset
> from a CPU physical, and I would be sympathetic, but it does allow
> VFIO to be general not specialized to Xe.

No, exactly that doesn't work for all use cases. That's why I'm pushing back so hard on using phys_addr_t or CPU addresses.

See the CPU address is only valid temporary because the VF BAR is only a window into the device memory.

This window is open as long as the CPU is using it, but as soon as that is not the case any more that window might close creating tons of lifetime issues.

>> The real question is where does the VFIO gets the necessary
>> information which parts of the BAR to expose?
> 
> It needs a varaint driver that understands to reach into the PF parent
> and extract this information.
> 
> There is a healthy amount of annoyance to building something like this.
>  
>>> From this thread I think if VFIO had the negotiated option to export a
>>> CPU phys_addr_t then the Xe PF driver can reliably convert that to a
>>> VRAM offset.
>>>
>>> We need to add a CPU phys_addr_t option for VFIO to iommufd and KVM
>>> anyhow, those cases can't use dma_addr_t.
>>
>> Clear NAK to using CPU phys_addr_t. This is just a horrible idea.
> 
> We already talked about this, Simona agreed, we need to get
> phys_addr_t optionally out of VFIO's dmabuf for a few importers. We
> cannot use dma_addr_t.

Not saying that we should use dma_addr_t, but using phys_addr_t is as equally broken and I will certainly NAK any approach using this as general interface between drivers.

What Simona agreed on is exactly what I proposed as well, that you get a private interface for exactly that use case.

Regards,
Christian.

> 
> Jason


