Return-Path: <linux-pci+bounces-12213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B2D95F97F
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 21:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69648B20DA8
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 19:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0126F1991D8;
	Mon, 26 Aug 2024 19:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vT3JlOIC"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D742F1990C1;
	Mon, 26 Aug 2024 19:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724699804; cv=fail; b=uIPkeSBUt842eGYnjltRE6QvbRB4BUji6wpTospvZZTS2pSzwOBecCU28H3O5cu2Kj6D8y1Q0ZrbZwp7lxue5owYr+zRk2+pqvZE1Skf6LC64OoHboEjkrQLft6VEhoYtKRYCeBivqvbCnunSCjJO2Y1atWbQ+x6f2IQsZPWw0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724699804; c=relaxed/simple;
	bh=a9PZCda5wCykqHghzrfYToly9R4ruC0QZF0MmeUrvXQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AfvT5nKhz+i+CCya332ndMO8rNrD6veLCfgq8NIdKIMk2Um4H4zZMXk0vnqnQ/VPOjSolNSy6ui78YOKDKF6R775538RRDPnoG4EHuc5/uGaq8s6n4h+MObTKUspRL3wUvWLOskwA0mfSlKBf3rzumpv3YLIJViJ/Kaxt7mgPlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vT3JlOIC; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TimiZHeyvEowZgLOSkN6qS9sI2YZlVnjR3J7pFGWelgNMKl98iXQeTg6EXSpJt1Bawv4TvNyEO4cO65jWKC+sy8HctKC00LtK+34tSG3tyVIUKHY9omgKt0l41czJsvY8y1rwp77WFiooDw+2kVqwgDm4EoTUPl7V47wFUSsQY0og2j05iuSLirV//lkttOXX71Qqnl0E9dQmlagO+Yr3eaCMsAofZL6GaZGUBGQGX3f+NoWUNclyTJc3TNI7/RpOUtOJTTokYilEuolU9Z9MP/uG7bJouebunHLEWffuW+sm01upbVnlTu76jezAgOHPyITI3V6CmpUdjdbW1/lzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8s7kKL1ATOYWFCAFjpXXxAMIZpsR3Dz+OgZmHFVuto=;
 b=Z+7U+fcr5H8x8AiNaQaoCM7yXWlmQx6om82lvYEt2ORWQlICQtv6KKQConlu2MriNjCYNHYpTOJKLFO5Zws4Ca+zXFSAOxkh0xyC+6iVJ1wZ95IFASV5bTVGdxg5grEpWJRKUfpdvDix2bblceZ5eR9i0QSiMIQ2JvOaVCvEcChqRYnoaj1s12FmS4Uex4iBvESZXpsg172IabWdKkGXrRhrkop0eY2mpJgw0U+klrQTLR6iyhhvHqyXwDbnuv4z8m1Q43tbhchJdsDl5iXOovYFFigcN7ogsSG4x+a4Si4hhxqf9d26EvXT3BOZbYi6VpjDllxH4dlG2B5+5nlHVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8s7kKL1ATOYWFCAFjpXXxAMIZpsR3Dz+OgZmHFVuto=;
 b=vT3JlOICkguL1I1uuDp4fi0PFOueXBE/majUb/risxN/iqI2P14PvxJhnwiIqurqJYhxzAcbQgw4MGLkffhWXEdbxiIA1wb0hdzBeRGFlHD0IwjTEEgyb9PdFA+8I5GRz0V89FpY+O1JNVUAoJN1gyqkY/nLv0R8VklB/ybyLA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8877.namprd12.prod.outlook.com (2603:10b6:610:170::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 19:16:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Mon, 26 Aug 2024
 19:16:37 +0000
Message-ID: <f43d44f2-004d-4b67-8db9-2f474c3e6d30@amd.com>
Date: Mon, 26 Aug 2024 14:16:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] PCI: Check PCI_PM_CTRL instead of PCI_COMMAND in
 pci_dev_wait()
To: Bjorn Helgaas <helgaas@kernel.org>, Mario Limonciello
 <superm1@kernel.org>, Gary Li <Gary.Li@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
 Daniel Drake <drake@endlessos.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Duc Dang <ducdang@google.com>, Alex Williamson <alex.williamson@redhat.com>
References: <20240823195400.GA377553@bhelgaas>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240823195400.GA377553@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:806:f2::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: 9429253a-b5ab-4deb-cf86-08dcc6039b7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3V6N3Q2d290V1NtbnNqNDhBNTZBNjJzVWt4T0tPZHBka1IzU0RCZmMyMTVl?=
 =?utf-8?B?VjZJNW52ZjhXOFM2N3NsdDY2aFhIR2h3d0J2bHdlTXNaVnMyeVVEUFFOZnlu?=
 =?utf-8?B?UWNaakZKNWg2amk4WC8rYm9TbEI2em4xdkEybHhNRWxsL2NDT2VEdEZid1hF?=
 =?utf-8?B?YkdyZXBJV0NVajZFYUdyMEtEYjJ2QzN2UmZsUmhkRjBkWU1kdFZaUTZXVHhO?=
 =?utf-8?B?cHdHYVR4dE41KzczVlAvcE9rWkJMa2YvVlFtYzZ3MFBCYWVzVUxmN25ZTGFU?=
 =?utf-8?B?WS9qVUU2SjNGZ0ZDVTloUGh6K0dqT210eldrdVZtMGUyazFHYkxZZjhvRzVl?=
 =?utf-8?B?UEJYOEZMTjZra0dQR3NOOCsrTHplQnRsanE5NGRCazVwWmJ6dUdxSFhUTlhl?=
 =?utf-8?B?c0ZsdDBZTWpIckVabnpsZWZOcUdjS3RnTVRxNjRPR3VmRVpvSHM1WTVZQStR?=
 =?utf-8?B?ZzhEQ1VhM0NuSTZuU3Q5bTNnSlRaR3BRQTlyTTg3akNPS2pUcmpWaVZ5Wmww?=
 =?utf-8?B?WWo5NjFjdzJsUk8xZ2Ruak5CNmtLdFpuUUtJOUtXQmxUN2dRcUIwV0lsZkFN?=
 =?utf-8?B?Q3hZYk1VWWdTWDhHTEpwWWo3TTV0UDJVemdnRVI0ajVkc2krRlJab1V1YmE3?=
 =?utf-8?B?RVAyWllnV3dYN0pROHA1aGphdElyVXdqRndKYWY3dCtXZENGYUpONEN1MjRO?=
 =?utf-8?B?VEp0aTlFdmJNRUthenlvTm8wL2ZXNC9GYmd0cndKTnFLek9OVFJ5WnQ2UE15?=
 =?utf-8?B?RldEMHh0TE1yWU9qREsrYkQraU83M2N2QVBNOXc4a09tQjdlSlpDSzdRVzVl?=
 =?utf-8?B?NllLdXdTRmMzRHdHTG83MjE3UkYxVHFJR2YvcnUyWEgzSndiRmJsRWRJb3l6?=
 =?utf-8?B?WU1zY2lHZGYrS0J0Z2dPUjdLbzJoSkYxbEJmM0dobVFSZkp2NmY4cE5uTXh2?=
 =?utf-8?B?OFF6NG1YRTJnejhHd1NuT2JmSUhnSTdXMTA0cUNyYngvU3JrTXZCb2ZmcTNi?=
 =?utf-8?B?R1k4dnIrRGlSM1ZNZEhiYmFKSmlRZzMrYVFyVmJmY204QlI1MEQxK0srNmQ1?=
 =?utf-8?B?c0FNdVQzV0RPVnJwWEYzUExsUFo2UUplVmFYbVBOZUdLV0txMXllM0FjelJs?=
 =?utf-8?B?TGt4Nk9lRjFvRFNaQkdWR01NN21vWjJDcnZIOVlONzZVU1RTZTBoSHowYWI4?=
 =?utf-8?B?ZVJQM24yWFYxenEvSUVYUFdxVWdlM1l1MkRYblNOdTczWGdIVjB1MzJZZnVo?=
 =?utf-8?B?aGV3UUloZi9xWlFOdm91ZXR4czBNTEdBNmYzMTkxL2VlckJjaFBmZHMxWjMv?=
 =?utf-8?B?clJYSEExbGN4clU4MnU4aEdvaGNFUjcycTRiaFVGR0gwQjhoR1d2c29jSXNB?=
 =?utf-8?B?MnlDenpPR09KMUIzemlpVStJUEYxWm04MXRKSDgxN1JhM2I1cnpjelZzeDFr?=
 =?utf-8?B?alczYmN0dHRLS0owVDVubkREcUhnU1cxUk0vd3B0eW5VNmlHZ1NwNTFsNkxa?=
 =?utf-8?B?alhhZTJpVkRpcFlCa3h6YURxUERhZnE0SUdXVjhxQ0FkV3hla1YxWWpkU3lT?=
 =?utf-8?B?NitYcEJ1eG04azRyVW1CWFQ1aEEzV2dxaXB0dVF2T3VtTjl0cnNiTWFld0hH?=
 =?utf-8?B?bkJCeHVyaDQydmlZUUY1Nk1yZ2V0WGpLL1lMaW5vVnRUMTduWWI5TG5mWVF2?=
 =?utf-8?B?eXdGNDV1dE9JVnlKdVNJZ3owWjZ0dkRTaHI1blVpYkZYdHNYM2kvR0NSNmpp?=
 =?utf-8?B?SEFaL0M4ZXRhVmZqVXlTUGozUDkxTEhRclNBTmQ3UTltTGJWd2hrbW5lL0V6?=
 =?utf-8?B?cEo0UEovOGVJMmZCUDEyZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVpSWVFqNjl3UG82ZFdPSkZXdlhROVBHdWlmV25QS1hWOGg1cWhBdUxrN0tu?=
 =?utf-8?B?TVFzVHc0S1pXbzJaT0FhdFUza2cyT05MS0ZkaDBFZ05kbVc2ckFNN3g3WDNx?=
 =?utf-8?B?aVZya2tXY2p1WnI2NUVIOURvOStVS3pueEQzamhvQjRxUm1SUldEdERNSk5S?=
 =?utf-8?B?UGoraU5EMGhXakQ1MHFLam1tdGh5QVVYdy9zTUYwNkdkS3JLT29uL0s5ZmdC?=
 =?utf-8?B?VVloeDVjYlZFYmNsMHEvdDBwWkJhUXdPNnBjNzFtQUhOdEdLQWNJYVhaWlYz?=
 =?utf-8?B?NWs2L1poTmNPYUNzWk1kVGFSdmsrVUQvTDVIclFqaGM2SVZIZzBXSzdJSW9v?=
 =?utf-8?B?aWdiMkdZVkluKzQ0U214RUpEWDkzQ1ZGZEk4QXhKcERvOUs0YnE4NlgrZ3J5?=
 =?utf-8?B?RkJnM1E1Yk40WURUMno4bkR0dWU5OE51N2FaQTJlck1COEk2OE5vMlFmL2Vw?=
 =?utf-8?B?blBMRGoyWHM0aEJiQVlzOUI3UWZHQ3JSRUMzR2s5MjFKQWlMTXhvWWxhY09a?=
 =?utf-8?B?REdYaEJreW0vbUhQSlFlUk1kWHN3RmNxSVBOaEwwV0cvSzVqWHNReHpGNzRP?=
 =?utf-8?B?N0ttMFBRWjFuM2hYcUV6eHdMWkZyKy9iMEFRdmJIWlZUN25LSnhGbDhub09o?=
 =?utf-8?B?ZlFuOTY5ZlpiR2FuVUFNbHo5V3B5a2JYcDFKQktJZW84QVM5dkhpSGZaUUww?=
 =?utf-8?B?OTJMbEVyNGlwaUxSZXpXWGNOS25ML3pOSTB4ZGo0YzVBNzEvUDNROXovUUVp?=
 =?utf-8?B?OGxPUUQ5QmtpUndqOHZIQnZrUU1Tb3NhWE00bjhET1drdThBejRoUkEzcE1E?=
 =?utf-8?B?VFhxVllIb1kwaThMbUVSR2NCM1lhRjFoR3lRUE1zTGhRODVUbHBvNzBsb1Z3?=
 =?utf-8?B?Vmd4aTM4VzVYdTF5VjFjb1VIYWJTTGl1eFA1R2NmZU56NGJUNVNRL2hINFlu?=
 =?utf-8?B?Wk9BS2pqUFB3YkFsUGpWWldBZC94T0huUm5SV3ZxV0pXNVRPSWZ6cDVNTmZP?=
 =?utf-8?B?ZDJzVkZmSjRDTFM5MVFzeGhQQWRDcjd6RVpnV3VtbGdmUTQ2MHFvbXdnQmNk?=
 =?utf-8?B?SmNiaWZ0OHhDSGlsenZxNm4xVXBwaW16OUJ5cW9tbUM2VyswZmVpaHYra3J4?=
 =?utf-8?B?aXRhNFBtTTZsTDNpTVlVaDJMdVJGREZWeVFzYi9PbWc2UDkvL1dqaWVuZlp1?=
 =?utf-8?B?M3hMeE1jb1Z4UGNCRHhibWJ3NVZnOFlWbkhCdVZCVjl2dGZxNUZySXlaZnlK?=
 =?utf-8?B?WXU4STd2REZ1Z2xBNXEzanV5U2hkT21BSy9VRGZXRGUzbUFmRGxCdkYvK1dS?=
 =?utf-8?B?Y1Y0UzMrdUgrc2M0c0tMR2c5OEpVTXVzcDg1M0VxbWU2ZFFpQnRRQ0FSUkN0?=
 =?utf-8?B?Wk54RTVxdTEzZkVtU2hRcTRseSsybGNCYUtOMUNPR3phNVNjUTR5R210dkRk?=
 =?utf-8?B?UitHc2QzYWF0RFRSekFrd0NnUlBsWnhnNXd2eFYzVXFseXZmSll4bDhhVzVF?=
 =?utf-8?B?bGNSblo3WkRSWnFndC9iV1N2WXVPOVowektzRURLY0J3UDVKK2s1cDNTYmM2?=
 =?utf-8?B?M04yUkgrWThoa0UzSWcwSmFVOW8rQU9XR0NKR2swSjFtdzB1bmNMNVhlSTZ1?=
 =?utf-8?B?b29LWXpVT3QwSzFhT3BjWVVDd3lncDB1TXRkemI1czlSTFg1SHF5c09peWIw?=
 =?utf-8?B?OG8xaStQZlhTRStjZzhBY1dQVE5PSG9QMGthTzFVWTJDdUlzNkhSMnRBVE9S?=
 =?utf-8?B?c1h0dkdKVHJVZWRFMFBLSVhvakw2bklYOFFVVDFWVDhlNVQ5N1pIRzF1ZUdl?=
 =?utf-8?B?OEIwVmF5b3B2WTJMQm9GZXJ2V0RWMjhmVnFsRmVPZzM3Z3pod2grTlBGR2JP?=
 =?utf-8?B?NDJqM2tla2dycFJEMWVzZzkvcTVPN1M5MXdpbE9pSG5yQkxBaTUyMm1iRHZV?=
 =?utf-8?B?YW9jSS83ZzlUdy8xaEJ0a0tNektWSVgwM25kVXhNSWtzV3g2UjJwQ3JNTXln?=
 =?utf-8?B?UHFvendqMHc1NitYTCs4aDgwSUdNcklsT3dGTkRBMFBVaEFOSDJYTXBXcDJz?=
 =?utf-8?B?Sm8ydVd0dVowZm5zNlliQjRQM0ZxeUFFNFkxay9CV2VZZU5ScWc4MCszUjFC?=
 =?utf-8?Q?7hLc1MQxwSMV+KZVE32Wf43Pl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9429253a-b5ab-4deb-cf86-08dcc6039b7e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 19:16:37.8364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tTN+JzOJftGcyHbKAKTLqf4d4FgL04ZQgDYgTrAfDco/xZHea3ITTlzAXs2TNzr5kQDPgV5offO7PTuRv8oSNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8877

On 8/23/2024 14:54, Bjorn Helgaas wrote:
> [+cc Duc, Alex]
> 
> On Fri, Aug 23, 2024 at 10:40:20AM -0500, Mario Limonciello wrote:
>> If a dock is plugged in at the same time as autosuspend delay then this
>> can cause malfunctions in the USB4 stack. This happens because the
>> device is still in D3cold at the time that the PCI core handed
>> control back to the USB4 stack.
> 
> I assume the USB device in question is in the dock that was hot-added?

No; it's actually the USB4 router that is malfunctioning.  The CM 
(thunderbolt.ko) thinks the router is in D0 already, but when it 
attempts to do a register read it gets back all F's and it trusts that.

> This patch suggests that pci_dev_wait() has waited for a read of
> PCI_COMMAND to respond with something other than ~0, but the device is
> still in D3cold.  I suppose we got to pci_dev_wait() via
> pci_pm_bridge_power_up_actions() calling
> pci_bridge_wait_for_secondary_bus(), since I wouldn't expect a reset
> in the hot-add case.

As I said it's the router (part of the SoC). The device never 
disappears.  It's the action of plugging in/out the the dock that causes 
it to change power states.

We didn't try it, but I wouldn't be surprised if it could be reproduced 
with a script that turned on/off runtime PM on very tight timing around 
the autosuspend delay.

> 
>> A device that has gone through a reset may return a value in PCI_COMMAND
>> but that doesn't mean it's finished transitioning to D0.  For evices that
>> support power management explicitly check PCI_PM_CTRL on everything but
>> system resume to ensure the transition happened.
> 
> s/evices/devices/

Thanks.

> 
>> Devices that don't support power management and system resume will
>> continue to use PCI_COMMAND.
> 
> Is there a bugzilla or other report with more details that we can
> include here?

No, unfortunately in this case it was only reported internally at AMD.

Gary who is on CC brought it to me though, and if you think there are 
some other specific details needed but are missing we can see what else 
can be added to the commit message.

> 
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v4->v5:
>>   * Fix misleading indentation
>>   * Amend commit message
>> ---
>>   drivers/pci/pci.c | 28 ++++++++++++++++++++--------
>>   1 file changed, 20 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 1e219057a5069..f032a4aaec268 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1309,21 +1309,33 @@ static int pci_dev_wait(struct pci_dev *dev, enum pci_reset_type reset_type, int
>>   	 * the read (except when CRS SV is enabled and the read was for the
>>   	 * Vendor ID; in that case it synthesizes 0x0001 data).
>>   	 *
>> -	 * Wait for the device to return a non-CRS completion.  Read the
>> -	 * Command register instead of Vendor ID so we don't have to
>> -	 * contend with the CRS SV value.
>> +	 * Wait for the device to return a non-CRS completion.  On devices
>> +	 * that support PM control and on waits that aren't part of system
>> +	 * resume read the PM control register to ensure the device has
>> +	 * transitioned to D0.  On devices that don't support PM control,
>> +	 * or during system resume read the command register to instead of
>> +	 * Vendor ID so we don't have to contend with the CRS SV value.
>>   	 */
>>   	for (;;) {
>> -		u32 id;
>> -
>>   		if (pci_dev_is_disconnected(dev)) {
>>   			pci_dbg(dev, "disconnected; not waiting\n");
>>   			return -ENOTTY;
>>   		}
>>   
>> -		pci_read_config_dword(dev, PCI_COMMAND, &id);
>> -		if (!PCI_POSSIBLE_ERROR(id))
>> -			break;
>> +		if (dev->pm_cap && reset_type != PCI_DEV_WAIT_RESUME) {
>> +			u16 pmcsr;
>> +
>> +			pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>> +			if (!PCI_POSSIBLE_ERROR(pmcsr) &&
>> +			    (pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D0)
>> +				break;
>> +		} else {
>> +			u32 id;
>> +
>> +			pci_read_config_dword(dev, PCI_COMMAND, &id);
>> +			if (!PCI_POSSIBLE_ERROR(id))
>> +				break;
>> +		}
> 
> What is the rationale behind using PCI_PM_CTRL in some cases and
> PCI_COMMAND in others?

We saw a deadlock during resume from suspend when PCI_PM_CTRL was used 
for all cases that supported dev->pm_cap.

> Is there some spec language we can cite for
> this?

Perhaps it being a "cold reset" during resume?

> 
> IIUC, pci_dev_wait() waits for a device to be ready after a reset
> (FLR, D3hot->D0 transition for devices where No_Soft_Reset is clear,
> DPC) and after power-up from D3cold (pci_pm_bridge_power_up_actions()).
> I think device readiness in all of these cases is covered by PCIe
> r6.0, sec 6.6.1.

Would it be helpful to you to get a dump_stack() call trace to 
pci_power_up() the specific call flow that needed this fix?

Gary is able to to reproduce this at will, I think he should be able to 
gather that using an unpatched kernel to help this conversation.

> 
> If the Root Port above the device supports Configuration RRS Software
> Visibility, I think we probably should use that here instead of either
> PCI_COMMAND or PCI_PM_CTRL.  

I did check and in this case the root port the USB4 routers are 
connected to support this.

How do you think this should be done instead?

> SR-IOV VFs don't implement Vendor ID,
> which might complicate this a little.  But it niggles in my mind that
> there may be some other problem beyond that.  Maybe Alex remembers.


> 
> Anyway, if we meet the requirements of sec 6.6.1, the device should be
> ready to respond to config requests, and I assume that also means
> the device is in D0.
> 

Within that section there is a quote to point out:

"
To allow components to perform internal initialization, system software 
must wait a specified minimum period
following exit from a Conventional Reset of one or more devices before 
it is permitted to issue Configuration
Requests to those devices
"

In pci_power_up() I don't really see any hardcoded delays specifically 
for this case of leaving D3cold. The PCI PM spec specifies that it will 
take "Full context restore or boot latency".  I don't think it's 
reasonable to have NO delay.

