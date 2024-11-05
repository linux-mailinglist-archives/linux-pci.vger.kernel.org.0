Return-Path: <linux-pci+bounces-16076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B00879BD639
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 20:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411871F23D51
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 19:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBE32144CD;
	Tue,  5 Nov 2024 19:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l2Ol/MqE"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0426213EE3;
	Tue,  5 Nov 2024 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730836592; cv=fail; b=LBXPauKh7zizT8dYiam6gW6WhrcoGzg4omJfSkxIZa/0z8ywjD8ZBusnuUOl7E5SmBkkmjVrB55I3HFlzDvWUP7RHaqIIioF5pqKA3NaZnzyqMfYIXbcsK7vm3iNMNlPLPh1Vk3tiOfCpI2Y+SUd5E2OR3ICQMT1Bs3BH/lZA4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730836592; c=relaxed/simple;
	bh=CI9C60FZYN56Tnrvu8Vmp7ndBOsjPVCw16Q4mkSaKrc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W2NAyOySEL/Ye0L4wfMGVtospToZZE324fI7KyJ05ZRCIBABrAZ06ycTSudXQ+GaU9aRO2f8YBH0OddLoYl/2Sl4AWBNqZtvpafPS30zxmWsM92tT4mIl/3bGlZNZZRPZPgQEkYkVEWo32hiwCAlsXrofYyHs5/PrMV+EPTpHlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l2Ol/MqE; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXXm45hlMW0wKmbeYOLY8ioZFQ48f70ZCjG5NV4Ffg2k3n6eoNof11ZHRVW9u7vjYvuTSepUiuxhiHYWYIzSWMoBkun/gVP8OT0AxZ9CHKDQeO9yBLWHLid1eaPI1dOs3rmspyc8oP/XRzAGssyxAE77TMxmNKHduhQpEJHwcmY4BqrRnNKTNSMMahiW05m052+sVbCuxOO03sUntmSATr71H2rnVQZL+YqVWEBo9V/KaWDAkuZvSuo+scutbzGgmCQDZxPhgNBlVH386Rop66IjnwwFllY8SVaCmTeyvE6BM+6bcHzsGVmQMjvKbB2DBa1eRCHRupoSfm3QnlCFjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g00vfo64mOZC37j83ijFQApPVByPVw2wOQJ3Spcjkv0=;
 b=cSkj/djX8AQRGMzKzY5gUz53GhpFvyOEK359iWpk7vBTil5YiinP8vv33cTWk+/2YowHKBTlsT0ESR1JGtw6rUgfkY/Nu8R4jkKF1yn7EZnkcWZ3oluLoMQPDpSK3VTJAl1xEnEjEsoV1HrZz0vv0LdFZNs5mf3NBANJV+APQN1/ccdUkup4RUIOblv50bHqeKdKaHj44uINpecvyMBZK1QX103+Pi98WIKiwZYO0gzA8k1idTm7bQK672Qvo1kALAKEq0X0UGWO4yoOdUhGAJeQYRH4mP6w7IivneO46xKqEOZkGMY1ZMKa/ckCJ1MIGOZH9BPyIQoJyoeW23cxpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g00vfo64mOZC37j83ijFQApPVByPVw2wOQJ3Spcjkv0=;
 b=l2Ol/MqE3Y/yfBbin1nOY3TkgzA/9XYuCIm9UXnWCa8nw8NHx5Nwwx9eC2Q65A6q2+ae3dRfy17BU0ORF7NEwfb8/PTX4IZYsHaxilTgJSlVCQY5oEVOQoLxetY92ooU+Pe0eEOZDtYeTv231qC4Ewd+hhT9nZJAakKbjegtU4k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8062.namprd12.prod.outlook.com (2603:10b6:a03:4c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 19:56:27 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 19:56:25 +0000
Message-ID: <9137b724-d342-4f35-b554-0e56ef37b2d9@amd.com>
Date: Tue, 5 Nov 2024 13:56:23 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] x86/amd_smn: Add support for debugfs access to SMN
 registers
To: Borislav Petkov <bp@alien8.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
 avadhut.naik@amd.com, john.allen@amd.com, bhelgaas@google.com,
 Shyam-sundar.S-k@amd.com, richard.gong@amd.com, jdelvare@suse.com,
 linux@roeck-us.net, clemens@ladisch.de, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
 linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 naveenkrishna.chatradhi@amd.com, carlos.bilbao.osdev@gmail.com
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-17-yazen.ghannam@amd.com>
 <20241105192124.GXZypwNJ26qqahcpOZ@fat_crate.local>
 <2b539169-8acd-40c6-9261-47c0252df91a@amd.com>
 <20241105195329.GHZyp3uVMKHAF3BEmV@fat_crate.local>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241105195329.GHZyp3uVMKHAF3BEmV@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0184.namprd04.prod.outlook.com
 (2603:10b6:806:126::9) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: a66e5448-f269-44d1-d681-08dcfdd3ee29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTlJcHVzckVhT0YweUQ4UDRJRzJsaSs4UHZ0clZmdjZXT1QyVHVmaEp6Mi9C?=
 =?utf-8?B?S1RRR0JLTGljZXdHQklQUUxTNzF5cm8rZ2xCWUlzcUJaOGdKa08wZDMyaE1k?=
 =?utf-8?B?NEt2RlQ5eXg3Q2pNVWw3YXhNcCtVdmZJdC9Mc3NvekkyWjRwRmprS2czTFpq?=
 =?utf-8?B?SksxWkdwRE1IbjNzN1JZUTZhL0tOZG4wT2tDQ3RsZGxuYTA0RWJONEx4RTRi?=
 =?utf-8?B?VS82L0k0YmlETlpDVEsycmZSaUxiQVNXNHdydjQybmtsVTQxWWtqMk5Oc0px?=
 =?utf-8?B?QStZTjRzUG9yMVZOMVdTcWc4T2tCREdUYVdWVlJGUDkvYlBNSEhjNjFLOHIw?=
 =?utf-8?B?U1JIcnhndENtK3NQcmc2SFVJeEF4QlM4Ri9sK05oWnlQZjFKSnFMdThvdC85?=
 =?utf-8?B?ZkZZR0tabUNpb2RyUlVseTlGL1RhRFF4cWgxTmhacVNuRnR1c3RXMXFSdXNv?=
 =?utf-8?B?RjdPVGFuUW85MG41MUtNNldsSXloNjJUSkV0a0c5a2x2K09XTjlnWGVwM00v?=
 =?utf-8?B?UVE0aitoUDhEZEhBUTgrYnVPYVYwWjRoa2phRjc1VC9EUS90NU9Sa0oyQkZV?=
 =?utf-8?B?ekdQN05WbXRzSXJYdGNGMlJWdjM4U2ZwUGRacVpMVU9pSExDUVdhcDQyNk1h?=
 =?utf-8?B?Q3pONTMzWDVIZ3lsbnBETDh6YlFzdDlCbURESEh6RmlyK1hVcUwvaWg0L2JD?=
 =?utf-8?B?b2xHYXJxR0dkcisrd1RoSkM3VEtMR0FuNXkzVHU3TEJWc3JZTUNpUFRKQks5?=
 =?utf-8?B?VTc2N2I5eVBvRkc2a2QvSVdvemZxTjU4cDlWaDFCYUxFUEcrbEVSYllpeU1m?=
 =?utf-8?B?cUlsSjNGRHpVbGtjVm90dHZrQW82SzNFYjg1cEpxa2M5WU4rOTEzSWZrQ3Rt?=
 =?utf-8?B?NzA2MzBnQzdpemttdGFhUE5vdDNZb2kvRDAxYmwxem9aZmU4eVlJTlV5KzNZ?=
 =?utf-8?B?TUZvL0sxZk1sQ1NteWpRM1UwcWd6cktCMkFDcURaOURHUjJVdXZuVFE5SzlZ?=
 =?utf-8?B?MVVuZ0dFYTRnME5WbmlRVzI5Z09HZjJrZDJxZTVhVmdjcUh1Ym9IT0Y2RW9E?=
 =?utf-8?B?MkZyaGs4YmcwV2ZQTmRmYjN6ZlFya0FSSzlVME5MK3c3M1BkSVRKbEZTTHBp?=
 =?utf-8?B?V3ZLL0lhS3pxU2h5YnFTNkdUSDB4UzNRMFUrbUErNWwzeVNTZzlPZkRvS2kx?=
 =?utf-8?B?dWkrdUtNbmRoN093MUxHYVR0RjhmTHgrSWdPNHd2cENVZSswaUo5bXhjS0Uz?=
 =?utf-8?B?amVCcE9pMlA3aSt4L1ZzTStzdWNkT3BFMVU0bkZvL1RaS09mZHYyamozazZF?=
 =?utf-8?B?NUl6UWo5dUxtcGVtRUl5UldYK2xGNjZxSldISFY5dkhxZ3JZZmM2bGdjRUpO?=
 =?utf-8?B?VkxMMjZMc1JXZnkvLzF0NWxUNTFYQUVDTy9seDdCRndMZU1tMC9ub2tnYmJG?=
 =?utf-8?B?VXp2NCtJWDBTR2sxZkVCM1dzMzE0THlRK2dxSUtVNjJzMWhLVnNtejVwaFZV?=
 =?utf-8?B?dHBnbFNFbHBaQ2taa2R4R1BSOTNPWVRwWnhkL3B5c2NNdzhCWFRJMFR4eEdN?=
 =?utf-8?B?OXdpK3B2R0tEL0w1QmdNVnp6c2JKNEw4dDUxNGFBLzlQVEc5a0FOa0Z2QWRv?=
 =?utf-8?B?enVuUW5uUWVZbFVNRzFnakxUUW54MlZtMURROVJDWi9XQlVkcnJSQkRFQTNh?=
 =?utf-8?B?dHNmNGU2dDI1TThkWnBQcGUwWWFiODV3bEdROC90Q0FEQXdZcldxc0xPWk4z?=
 =?utf-8?Q?K78tZ0IQ161DCSlH//4eAMFGOWVdRNrR8k5bwG1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czFVdkR4RHVTNUhJSjBRVUlMc2p2QWJlSk1nbzR6aU1YNnRtZVc3RVRsd2NC?=
 =?utf-8?B?dXJ5aUtQNjd3RXhTWGxBNWhJMkpXODQwMWtWREphRGlndE9LbEtCVThMeVR6?=
 =?utf-8?B?MUwrUnFxN2QrZk9mVUtVSmN0eCt0b3hXM1VSUkMyNEZYUFJVRy9HaHA2UGc0?=
 =?utf-8?B?UU5sSXNRLy9wZlNJNzRxWjNvSzFvV09jRmphbTRJRndxaW9mZ1lHVXNIanVy?=
 =?utf-8?B?eHJhc0s2WUhhVTRTQVl2dE03WW91YU9iZ2Q3WDhVcVBkbmtkdE1UM2N5b0tF?=
 =?utf-8?B?RTkzV1M5b1NoU0FEYnZVYnZOMDZTdnNFYTU1LzNyQnVIV2lPbTdyRWJYS0hr?=
 =?utf-8?B?Y2s0dWZUd2E3WkV2Y0NBU1ZQWGlQUTI1NTNqeHJCYVZGd3BDSzRQa1A4NElG?=
 =?utf-8?B?ZXhnUjdHeUxxZmt1eXBpWHhMUFRXREtGMGh2QjJYeWhpMWt2TmltdVlRWFI4?=
 =?utf-8?B?cXZQVmNyaUpxRktlRjFOOVNlSVhpRGhwZ05uYzRtTmNJVEQrVzVNQm5zL0V6?=
 =?utf-8?B?S2FaMmJvYXpaSWordmJQZ0RwQ0Y0L0NRZmRmRHhiNGs3QW5NaU5rc3JveStp?=
 =?utf-8?B?eElxT1hud2RTTnZKdW5YbEk0MWJZQ0Z3WGRmcXVFbjBXUmgzaWRzbGQ5ajVI?=
 =?utf-8?B?T2l2dm83dEtJTjBwTktEVE9UQVpPR3FjTy91eEtLZ1FXcUVzUE1qTGxZMlAz?=
 =?utf-8?B?S1pkQVlHcVJFRHdrTUlmMlByTG5mYld0STFudVBSM3BRd1hXSU1ycktSZjNV?=
 =?utf-8?B?c0dWV0kvSE5vYjBQYkQwUitBalA5VjVOMHBYOVh5ZWxmWDJ4cUxYQnkyMGdY?=
 =?utf-8?B?dktjWFRKSkI3ZDhQMHNkb2xCS3pYcTh5Q1BPNFJ6T3MyeFJ3M3BzeWZ3ZzN6?=
 =?utf-8?B?SExBdG52QmM2ZG1CYkcxcUNYWE1VKzdXM3VRMzZPcWZBSnRPL1JmcEdTRm9Y?=
 =?utf-8?B?RzYwTHc4bERHcE43dVFPQTR1QzVaMWZ5Mkhyczc0RTNiVm1CcHZrVkVBeDdt?=
 =?utf-8?B?QVFvTnRqTHI2VVVOOVAvTVVHLy93R3YwRjhQaGxQaUpBSHhoaWhiSTAwUnJl?=
 =?utf-8?B?ZDk4b3hqb0daMHNlQ3pubEdtTDBiL2Q5WHlmL1M0T3RxMUYyT0Y1VGhla0pJ?=
 =?utf-8?B?UmpNSE1lLzJEaEhHOVB5R29DbG5LN1o1ZnlleHM3UWVSUTVuSHVmeVRhOVhR?=
 =?utf-8?B?MG5mWi9TOVZVQjNzdU82azBQSlZ3QVJLcEgwZlRwYzdUb0dMMlhqNG8wbWlR?=
 =?utf-8?B?TXdlTlFSWko3K2UrTjh3YnBEL1NMblluS0NDdVNyZVFHc2MxT1pCSWt1SUMz?=
 =?utf-8?B?RWc0aUFmYWJZRW51Rm9ZYXJyNG5HK2VKdGplbFhDYmtta1E3NlVuNWlyTXRo?=
 =?utf-8?B?SnRwQjJoaGhScU5GRFJGcktSMzZIZXBKeGJuNGRjTGdCQVRWeTlLT3Jxbkgy?=
 =?utf-8?B?YXI4Zm0wZmZldk5VakhrRkE3cGs4ZUdvTW9Nc1hGY3FmMWVYam55UU40Y2Rm?=
 =?utf-8?B?ZFRCQnlaUWxyZndrR1RqZGU0amJOYXlqMjhQUFU3Mm54ckpIdm05cHVvZzNR?=
 =?utf-8?B?UVUrV2NkbTlIZjVqbUExYnRSQ2N0S0YweDI2MjJ6MW5NZllJdGJ3MUJKRWov?=
 =?utf-8?B?OEVCY200ZXNYR2J6cGJwTVpCZVBQUnJFL0V6bHlqUGMyTTlGTjQwQ2J4TXFS?=
 =?utf-8?B?ZjNiLzBISTBhWVV1Y0EzQU14bjZCTWRYTEJQUkN1TGYzbHVnOG9ITGcwblQw?=
 =?utf-8?B?MEJBREpyalZrL01yVFU3V0M2aTN2TVJmTmJxdzR0aytBV0ZhUTJvRTJpemdM?=
 =?utf-8?B?RmtRbHdReEFuaWltMUN2T2g5Ri9MKzZsb3hwTXRNUk53YWJ6LzdSMDNhSUZo?=
 =?utf-8?B?UWdqakxYM2pka0hVZC9YdjJrY09iSGo3UTVvWkVIbUdIMU5FMXhJbkh0WHNN?=
 =?utf-8?B?bnFIOUR4U2pGNThMRXc5SnJ1UGtXejdhczltNWgyUHBVU2xlbWRXSVdDYXV4?=
 =?utf-8?B?WTVwOThUMkpmcDh6ZWErb3NZUnoyL1Vkdytva3N2emdoNjZpM3kwb1FlVHBN?=
 =?utf-8?B?STk4QWJ0UWV6Q3NkWDlZcFo3Y1RCZTdqejBIdFhUMXk5dDk0aGt3Z3RGa1Na?=
 =?utf-8?Q?SawnwoTgOOrF7PMsS+JOfv/6R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a66e5448-f269-44d1-d681-08dcfdd3ee29
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 19:56:25.7464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7k3KPpFpQVFjfd/kDgs3h01okfDsL6ePqSQt3sijnGJQdF908DxH+UNGmMzqrfwX3UoKbb0Dnbl+vtoorU3hew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8062

On 11/5/2024 13:53, Borislav Petkov wrote:
> On Tue, Nov 05, 2024 at 01:46:46PM -0600, Mario Limonciello wrote:
>> Why the worry about it being in debugfs by default?
> 
> I want people to *actively* and *explicitly* do something before they can
> brick their systems.
> 

OK got it.  Considering that I think after this series lands we need to 
re-open the conversation about PCI config space access to userspace; 
particularly on regions that have been marked as exclusions.

By that grounds a taint is definitely not enough for that either.

