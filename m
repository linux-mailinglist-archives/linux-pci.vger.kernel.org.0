Return-Path: <linux-pci+bounces-31318-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E72EAF64D2
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 00:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5BDB16D847
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 22:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC243BA2D;
	Wed,  2 Jul 2025 22:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c+0kJWkl"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A23619D8A7;
	Wed,  2 Jul 2025 22:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751494087; cv=fail; b=JJjuc91NzElqV7s9c7pj3OJ+F3ekel2wvlyM8vzRVDU1iaIzPpYSkdjX5e2VUuNazRJDglIZ+OXMiVPmcuX+M8YhMac5jM9neXdWwxARIG8QJ+p56C5h1gFfajqfAnOi1rJNAE7uX66KnV0KjMaAlh4o2RXhzZjbKIbM3v08OI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751494087; c=relaxed/simple;
	bh=pABHfC359fhd0K9ZGBcxldvFmoYDKf1MqcZEpIi5cNs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=azM8+qFUMuQAyeRWSEYcE+gelNNjojbct1QIZ5B++AbP82uUggLIcZGU9slJnTt10LddJg6yIW5jqS1WARWI5D9r62rrBxbvz/FpneIxXl6Sff4Es3lQRFu3SMJgMNd5iWHG2RnuhKX0fcWBTb+l674bikNViNf1kyoLNSO8Pr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c+0kJWkl; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bq1kkUnkqx3istoLUHY6NRV3EwKOfoKtjpg4DisNBKXONvhhXMwxiENyyEpokAbNBm/ROM3nsUgFoeS9GY9QqrnYaqMRUqJL/kVOc6vMlMkLjNel/vrh18uo0x5fdUcIwdQLXyZP17r39A7nSNR+M2Ovu3Rp7YfjW9TVc0IPELesMIxX6HVqNoxKthvkU7YKpBO3dHxlroLkh0Xk4GjTXCToIKF09gbadK8X2f5M6kRCE3raauayw1P1cVsRkRUjkK/O/Z7HE3/YhdBWHguc8BEPc9V0aqapzI0obQmUEMQO3HumDLVvB7X3HGil0+fxuOBM8NG8VR+vJixbLabobw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1NEvGgKOokrcSjerHD+uT6tSr6/z5gccHsLhmq1OhM=;
 b=n8P2HS75X41u8miWpUZg3DA7PmlQfjK6HuhB25nspfgBnFOsU+sKFfh5VitmSlExmLsy++ihkSCvwXsPSII8XWu4uHSm37H6i9KhI9zifCYlCJj7u940YgrbJluhqOM5Ef6vAeiIjm/GJIw/spMhMvuSrOxwspCu80h473HC8aylg4u1VPODk6K4QBavbNKGR7/239n4WT6AGGXe6eLPt/+lbKly2fbFJrRjtysbe+CznVNfg1yskVGE9gv8Fu/9qXkUfInvhDoUmeKiiNjmXyBuMXN7CmEH4i/y3YdCW0eOO/MZNjwk57hj6/1hatWiQgEbtjmgROf70Rc2bySSOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1NEvGgKOokrcSjerHD+uT6tSr6/z5gccHsLhmq1OhM=;
 b=c+0kJWkl1yU9R6FKSCXsQFYPy6mwuFcM+4iQGTAQn+l9HPju5WgpCxtwNiOepMDXQirhsqP1XYbvVRXony1Jg5rYZp3rYp7gHaPa84TFtD4MvDRwwSomluaF3t1SFaSFjQhVeZdY2IAHMHrw+y8WaIlmHHFgNjzsrv8HXqPMa6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.22; Wed, 2 Jul 2025 22:08:02 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 22:08:02 +0000
Message-ID: <1db7c06d-f0a9-4308-878b-f82d6e445311@amd.com>
Date: Wed, 2 Jul 2025 17:07:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 12/17] cxl/pci: Unify CXL trace logging for CXL
 Endpoints and CXL Ports
To: Alison Schofield <alison.schofield@intel.com>,
 Shiju Jose <shiju.jose@huawei.com>
Cc: "dave@stgolabs.net" <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "dave.jiang@intel.com" <dave.jiang@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "ming.li@zohomail.com" <ming.li@zohomail.com>,
 "Smita.KoralahalliChannabasappa@amd.com"
 <Smita.KoralahalliChannabasappa@amd.com>, "rrichter@amd.com"
 <rrichter@amd.com>, "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
 "PradeepVineshReddy.Kodamati@amd.com" <PradeepVineshReddy.Kodamati@amd.com>,
 "lukas@wunner.de" <lukas@wunner.de>,
 "Benjamin.Cheatham@amd.com" <Benjamin.Cheatham@amd.com>,
 "sathyanarayanan.kuppuswamy@linux.intel.com"
 <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-13-terry.bowman@amd.com>
 <6b8b65df7c334043863b1464e04957db@huawei.com>
 <aGSI7oXthPW-AY6D@aschofie-mobl2.lan>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <aGSI7oXthPW-AY6D@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0029.namprd18.prod.outlook.com
 (2603:10b6:806:f3::28) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SA0PR12MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: f4792d20-3013-4db2-fe85-08ddb9b4e95f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGQ4dGc2N0J1NzlnbllNSGRMUFpWSWRXSTVyWnprbkh6WktxenpjOFBGd1Fj?=
 =?utf-8?B?WTh5alVHbGFLWlR2US8rSnIvYjh3d0xyRlhXeHRlSkJpenhjOTR5NHpUeGlP?=
 =?utf-8?B?YzF2YzNrcS9Va1Z3UVVyaGZmdHFrK2ZCSUM3OWhuYkluZ3grdnQvNUJqSzFQ?=
 =?utf-8?B?MGc3anF4UW1GM2ZVYnhPcXNIcUNPU2M0eVFscHNmdkcxRjRGMm5oNHM4dE9I?=
 =?utf-8?B?dzM3RW12eTFrWG1hQlYzVE1mVmYxUTU5RDBSdjUzSzJHbnZ5MzZzaFBacGVQ?=
 =?utf-8?B?Qk1PNStaZkI1UURVM0ttWGdEV0E0YjlmMXVLMjdtU2M3WnBxS3VaTjMxUGFh?=
 =?utf-8?B?QWowdURRUEptQmdxWmhFdWlJSVAxRzZsU3g0L3JwTmM1cFZSS0R5RkduZWpV?=
 =?utf-8?B?cXRIRXNzOHJ5d05hOU5lRHlBRWNXNnB3UDdXa3hkUmZFNXJLMDFkbHhOT2pW?=
 =?utf-8?B?R2VEa0pienBCTzl4MHQ0QUJiTE1rSU1nV3dLRnlKUExrMUdSTDZYM1RsMVJs?=
 =?utf-8?B?dm5rcVQrbW02OHJva1cySTVROGVXNGVjRmVQdVowdmttQktBUmt0Qy91dkEv?=
 =?utf-8?B?MGh1MlVXc3hXWjhkajVmNHBxN2MvbGlrdEpEeko3Qkw1R3NzTEg2S0JNNEFp?=
 =?utf-8?B?UXIzVFBIc3ROM0tOOFRBYW9zeVhFZ2xsNnZZU0pKb2Z6WG5LTDhrL1VmUTh5?=
 =?utf-8?B?SURNUmVUdEpSU1cvQWpOV1poRUw1cU1hYVNzOHo4QmZ4cUpZQ3c1OXF6QW9I?=
 =?utf-8?B?bVlhQ09zR1FjVEllWXo0ZjAzOWFQRjRuWDBFQjRlTkRzaHNVWkxCa3pqcitT?=
 =?utf-8?B?Rm1MN3NVeklydUkrdlArdHNNSnZMczQxRG9XMXgvenNYa3d4VGxoQkNRMlVh?=
 =?utf-8?B?M1hzRUZGdEltdGJrNWJiR055YzdudEtNek9CZjBXRlpYUlNsV1FBSkNGUVQr?=
 =?utf-8?B?WXdlVUFCOFplU1pyblBycW00UTNjUWtxV0hrei84K1ZQWHNMYXpkQTFyUFdE?=
 =?utf-8?B?QVVoTjNuWVVxMFFPbFNvdWV5V0NRamduc3AyUjhXUmVrOUZORE5UK0lYOTJm?=
 =?utf-8?B?UWVSZUlsTkRmNG5WNGYrdXVqb1lrNzF6NmhBNFNXZGZOWDZONlMybkJ0TWhF?=
 =?utf-8?B?dFFPU2ZhT3VxSEFQRmFFRWlQN05PQ2lDL3cyNFpGMkhENXZBc3puZmVmckFD?=
 =?utf-8?B?dnhKWFFGMVBrVlJtaThZUU5ZVldRWjJlY2xHdGVQREtQR0tWbEJTTnBqQXh4?=
 =?utf-8?B?TXE5SDZUbCtmS1g3Zk4rbktrR0pFSVFEWDl1dXpVL0plY0gwdkxneGhza3ds?=
 =?utf-8?B?bytobmwrWnh4SmF3aHJtWXNlM1BlUE5qdkpJbGcxZE11Y1EzVVdIbWRCc2F6?=
 =?utf-8?B?d09SSWNlSjN4Z09DSXY2TzRLcVhQTEdROWE2WHordFBZWGw1c0J2RWpHdkhy?=
 =?utf-8?B?V2djZ3pHRVdkQXdzZldZT1RxQkxNeTk5RjRXQjBBVTB4RzVJenZLTURqRm9y?=
 =?utf-8?B?R1kvQTF6TlBLWFkzUUdTU0lTWHdLTEJ5bDEvVzB5d2VNWXMxaVBYM0VRY2cv?=
 =?utf-8?B?QzRqVng5TlByZ3BaTzlYenU2V3FLTTZnTU9mWDR3TmRwSWpWTWpCRDI1VkpJ?=
 =?utf-8?B?aTdWcWVkbFlXMG56SkVrdSt0blp4RE5OcC9Sc2VQYXQvbHNFNU1QVmVLem1t?=
 =?utf-8?B?K0dNRW9TRWQreFcyZGZtbWpERlNyQkpxd1c0QVNaVzhiRGR5bUlZbDZLTmls?=
 =?utf-8?B?OTA3bVA0N3VTZFVtL1BYaXB6WHZaOWRiZW0xV0J3aGNJQ2VVNlQ1a1kyQndE?=
 =?utf-8?B?MWd1S2htaEtFMkRZWG5kOWNqV0cvU2pydGdvNGZrZWdSTk0vaFY5VmJuTmR5?=
 =?utf-8?B?OWdYUHpicmFNck0rRnFmL282cVE0M3ZhMkZha0U2eCsvTFNpdEhnVFFpTnpV?=
 =?utf-8?Q?KA2YcZ4DhNc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VThzTDRpQkZKY0FSN1VnRGJNeTFVTGFFSmMvZVp1ZWE4Y2s5aXd5M3N5cWhW?=
 =?utf-8?B?MnhZN1RhdG1RY0xMR3RJVEF2VjBtdStwemRHVTFNZXdEcG5tNVlWRDQvdE9I?=
 =?utf-8?B?cUlWVnpvdHVENlAxSWtocEtnMWdFTWVZN3EvOEIyU0Y0VzlxZWZoMnU0WGMv?=
 =?utf-8?B?TDdWWVhmQmcvZ2RHWVl6cXVBcWRJaFdJS2lhdW5oL3dVdEp4eDFSYWdNY2Ri?=
 =?utf-8?B?ODcxN05MdU1JNWVLUUtJaDA3Q0NabDFvdEhRc0FEN3BrSzBTNG10c2ZRZ25K?=
 =?utf-8?B?dFNQeStaSGl6bkViTzNFais3cUlFdmI2WEFwb1JUS3lPTUxBMHdveVJiRm5o?=
 =?utf-8?B?VWZpdHptREdwVklLSjlDYlpQdFUvWGlZZlBEZnlmeURwYkRxeEkxcXR5RWRY?=
 =?utf-8?B?d2FnSktHdzlYSW1wS05jVU40NDdpN3VEcXlxcHhEWkNzRGM4aDlpM0xoYklG?=
 =?utf-8?B?UEt5QlZkLzFxZzBXQUlOWmNxZnlYaC9GRC9rR2hGbzJORlZvRE01bTk1eEhV?=
 =?utf-8?B?RndwMUt2bmlRMUQvZzdSb0EzMjNrWVRPemdYcE5GWmdCcDdISEtTZlZ3a1hv?=
 =?utf-8?B?VDRJc1JUOXZDN3g5L3NxTTNldUpsZTBtRkthWVFuSHVGeU5EZVVuSUZvZWdO?=
 =?utf-8?B?c2NCaWx6b284cHFWT1gxZWtPUGJsQm1saVlKVVZGNmF6akJPajhoWUx2elNR?=
 =?utf-8?B?dHdOcDgvdExvbGlyVWdBcEV5cVhNYm5ZMjcwd0lOdldicXdPR0Q2R3JxYUVM?=
 =?utf-8?B?RFdGMVpCRVFKbE5pZEMwdVQzUEJQNS9QYksrWWxHVTFNdmQ1UnFncWpRWG9D?=
 =?utf-8?B?cWw5SHFzRjlzbElrR0VLM2JWQ3pkdG8zVXc0bnY4T3FySWkwMjl1eG5qNGVT?=
 =?utf-8?B?NWFLOGltZW14VHlKVnhxN1VEa1ZGSGM3a1M4V09lYTZZNEYvMDVlZ2dadGZB?=
 =?utf-8?B?eFRjeGFYMTErWWNkZEJCc0FiNDN3VG9uazhTYmhQNFZxU042MUZvY0Y0Z3M4?=
 =?utf-8?B?emtQNytKY3p0UEdBUEZYa090Z3MzblFiU2RJWURXZ0JFY2RTN2hyTXJtN1Nu?=
 =?utf-8?B?OEdTekNDZDg0MU5MYWx4bXczeVhPMVVmREhLc1Y4WWtjMEg3NGtDOHRidVhr?=
 =?utf-8?B?cWk1d1ZLazV6ZXZWSkg3eU5Ja2V3ekt4UHhudzk4Uk96b1BHbkJidFNMZ2po?=
 =?utf-8?B?UWMrNEVwQWE1cjZDTmF3SFN2Q1ZnQXd1TUw3RXBpY213RWhNaEtXT0c5d2wz?=
 =?utf-8?B?eTA3Wld0cVJ6K1ErRGN6R0laaDFWVjRqSEZBVFlMTFNJSFVpQzBmRHM3UjQx?=
 =?utf-8?B?VXkxRVJYdm0xVFlwUGdxQzQyQzVzK2htVDZlUTJGRG4zS0xDZ2xFbXI0L0Y4?=
 =?utf-8?B?M3R3aTVTOEhlRnIxaHZ5MndEeWxkbDVzQTBwOERjU0h0dWZXNDdKeHBBUEhp?=
 =?utf-8?B?cTV1MDNqME8zaUhIcUJiNllRWmxMREdPWm9MQzhBN1NmN2FzK3RWSzdTb2Iz?=
 =?utf-8?B?ZUZJOFBvZTFnc09qaHVSNnVvVkhySTVITnhWNEZhbVdjTGFrVEllSjRXdDlV?=
 =?utf-8?B?cGt3THNWR3MrZUFORWc0OGVhMDVpNWluZC85RUk2TUlrbWtGcGljdlN5dzh3?=
 =?utf-8?B?VDFLWXRnRkVLbi85VjJITDZpVGdjSkxFcWJERmprbTZydzdNWWQxR2FyenYz?=
 =?utf-8?B?MU5HREVzUzBERmJybXZLSmd3bENDV25QeVQ5TjV5d3ZCUzFWK20vYUptb3dY?=
 =?utf-8?B?S0NINitFTkpOWHlOZm9WR0ZkOVE4Y3BsZ1BxcUNsU0lRMmRXM0RJd2w5aVpI?=
 =?utf-8?B?cDZtU0NxMGpXVytONXR4emdKanExbmFqVmNJR2xBMlRMQkk1K2ZrWDAvcUw4?=
 =?utf-8?B?aWZUMHFHemQ5STR1cXQzZlA3aHYzMXkxRUNDMzZvckIvYTBxZGhWY2xJazVH?=
 =?utf-8?B?eDBoTDFHclJJRUVFb0pQZ3Rna1ZrY2YrUEVHRGtwbEpXOFpKdGc0Q003bjk1?=
 =?utf-8?B?alUwU3kzMEYvbmZITFNHMlltNkdndG9ScGs2RDdBZHM5RkZIeTI4ZlBsNDN5?=
 =?utf-8?B?ZXEwT3RVYzFVQUVmY1I5U1pzNVByV3pVOVYvSXhUek1OZFJrdGhUc1FZYS9i?=
 =?utf-8?Q?itOcD1vtPcuRxkNlK5b8JN67h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4792d20-3013-4db2-fe85-08ddb9b4e95f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 22:08:01.9858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uq/f6/J6xA9NjRZ7Fm2DdidDLBC4JCDFkXEFW2oy2+Zj1DTmnevb2iJcq/SDSMW5H60KIdOJmmRDIKgkhu8PXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415



On 7/1/2025 8:18 PM, Alison Schofield wrote:
> On Fri, Jun 27, 2025 at 12:22:39PM +0000, Shiju Jose wrote:
>>> -----Original Message-----
>>> From: Terry Bowman <terry.bowman@amd.com>
>>> Sent: 26 June 2025 23:43
>>> To: dave@stgolabs.net; Jonathan Cameron <jonathan.cameron@huawei.com>;
>>> dave.jiang@intel.com; alison.schofield@intel.com; dan.j.williams@intel.com;
>>> bhelgaas@google.com; Shiju Jose <shiju.jose@huawei.com>;
>>> ming.li@zohomail.com; Smita.KoralahalliChannabasappa@amd.com;
>>> rrichter@amd.com; dan.carpenter@linaro.org;
>>> PradeepVineshReddy.Kodamati@amd.com; lukas@wunner.de;
>>> Benjamin.Cheatham@amd.com;
>>> sathyanarayanan.kuppuswamy@linux.intel.com; terry.bowman@amd.com;
>>> linux-cxl@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org
>>> Subject: [PATCH v10 12/17] cxl/pci: Unify CXL trace logging for CXL Endpoints
>>> and CXL Ports
>>>
> big snip -
>
>>> -);
>>> -
>>> TRACE_EVENT(cxl_aer_uncorrectable_error,
>>> -	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32
>>> *hl),
>>> -	TP_ARGS(cxlmd, status, fe, hl),
>>> +	TP_PROTO(struct device *dev, u64 serial, u32 status, u32 fe,
>>> +		 u32 *hl),
>>> +	TP_ARGS(dev, serial, status, fe, hl),
>>> 	TP_STRUCT__entry(
>>> -		__string(memdev, dev_name(&cxlmd->dev))
>>> -		__string(host, dev_name(cxlmd->dev.parent))
>>> +		__string(name, dev_name(dev))
>>> +		__string(parent, dev_name(dev->parent))
>> Hi Terry,
>>
>> Thanks for considering the feedback given in v9 regarding the compatibility issue
>> with the rasdaemon.
>> https://lore.kernel.org/all/959acc682e6e4b52ac0283b37ee21026@huawei.com/
>>
>> Probably some confusion w.r.t the feedback.
>> Unfortunately  TP_printk(...) is not an ABI that we need to keep stable, 
>> it's this structure, TP_STRUCT__entry(..) , that matters to the rasdaemon.
>>
> I'm not so sure you should be letting him off the hook for TP_printk ;)
> It seems TP_printk should be kept aligned w TP_STRUCT_entry(). As a
> user who often looks at TP_printk output, I'd say keep them all in
> sync, and consider them ABI - ie. add to but don't modify.
>
>
I agree. I will keep TP_printk and TP_STRUCT aligned by using 'memdev' and 'host'.
The only change here will be TP_PROTO and will be:
TP_PROTO(struct device *dev, u64 serial, u32 status),

Let me know if that's not ok.

-Terry

>>> 		__field(u64, serial)
>>> 		__field(u32, status)
>>> 		__field(u32, first_error)
>>> 		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
>>> 	),
>>> 	TP_fast_assign(
>>> -		__assign_str(memdev);
>>> -		__assign_str(host);
>>> -		__entry->serial = cxlmd->cxlds->serial;
>>> +		__assign_str(name);
>>> +		__assign_str(parent);
>>> +		__entry->serial = serial;
>>> 		__entry->status = status;
>>> 		__entry->first_error = fe;
>>> 		/*
>>> @@ -99,8 +72,8 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>>> 		 */
>>> 		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
>>> 	),
>>> -	TP_printk("memdev=%s host=%s serial=%lld: status: '%s' first_error:
>>> '%s'",
>>> -		  __get_str(memdev), __get_str(host), __entry->serial,
>>> +	TP_printk("memdev=%s host=%s serial=%lld status='%s'
>>> first_error='%s'",
>>> +		  __get_str(name), __get_str(parent), __entry->serial,
>>> 		  show_uc_errs(__entry->status),
>>> 		  show_uc_errs(__entry->first_error)
>>> 	)
> snip
>


