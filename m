Return-Path: <linux-pci+bounces-39612-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B0AC18DDE
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 09:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A14F1C8833D
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 08:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FD9311975;
	Wed, 29 Oct 2025 08:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZWfUtSZe"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC7E20C037
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 08:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725082; cv=fail; b=iEmlMgfTIGpRF3Wnv5t/uBNFn0XFD4IOWHQ+j93FohrwgE/c5fldO88F8jVlklEilc6iDb80cqkXOeVaXakcN7lg5rBFAI/96NaGQczriHTtg9qieeQCmnzTmIPu+KXHWub7t/DcA8knKPCMIpMjPE+Nkjj3rMSlYCoQaN4prio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725082; c=relaxed/simple;
	bh=YArJ2i8V4a3zlZWS6jT1vX+jvKIFm+IqrAluwoEkWoY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A9USebo3/DTThzQqyalGax7c5d8qtSgqzUssqF01E6voz/+5jTzbt9fCO6wMX5QmqQ9noL13oOEq109pdcK9FipQ0eSj41LMLlTCHpYzIAKwS6jCrCyBWth8NkQU/ogvjOxr6aXz4RRt+76wE1v5WxhESCDilmP4SK0GHoiWOf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZWfUtSZe; arc=fail smtp.client-ip=52.101.56.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rc5eOSK4SKBSTH38XCTJ2uw2fJlyDXjSHkd05kcewP9pZa4kRwryaplamRIfUGgUdtgh1zpAkFU19VsWHvpA8AdbwxrACoJtkChLv/viUR+dQMEMVrcHs5kWGnKgb/VrAxB5zClaWhoxr5vLy9J4ocJXBfgZ5o3wn5qCJkcRA+2jMaF6/LLtwpCaMUAz9h4RdrQZVwWjxp4ILwxukLYUzOUJhl/LabtsgMAU0IvibbGBftLfEhehzZe2XraAxMARggVHZz+ArzsNGZIaNJTxR2No0IuAE530VNLRHbJlPRTjrm2rQFDS9T1HHWDZgYiSbro3n41S+vBmBl+h2y3GEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQ58IfUDslj6gRIuXEXyHXNtI1BBV+4Ucg25MyVrq3Q=;
 b=G286S+mLohZKt4P9Uu2Tqug5b4HAcGIQl9/J3Nf211BjP8218z7KDZ+4XJLXD87S13gL7RbuwhIXr+i+gGHN4PoRLfUJ2nPa0wAse147kL6Jn4pJGTtjpQluBcoozrFcVhjG4zn67zJrhqXnSkwxrzCSw3ISDUFqwB4ffUyKUEKq3K81kpaIfi84ynNKPN8uPoBIxNChMZqplymwDyicF/W0FpDaMIvkWsF8brg5qEghkwwznYqGxjKFuG3qJvtnoEiMIE3NMzmux//jodTtkv3b+FT5ev/h4BLbMW6xhXn43NX2OYMvJQlx9lICBFbJwnCE4yzgEsuylK4bEyTqEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQ58IfUDslj6gRIuXEXyHXNtI1BBV+4Ucg25MyVrq3Q=;
 b=ZWfUtSZeARi9Yd/gAPxsy3cugNn7f/njjrmHkbkuC0HJfXufJgUM5gqRMIS7wbPOxokiIRC5fi1JGIk1fE7ao17xgsUQd80/P5h7/w/Z6pCH9CIVcmNBIhCjLBrVMs1J4AxRtkvJvqiTAcLlnI8zVvpYRVk//nhe9WJ7YghLDUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DS0PR12MB7606.namprd12.prod.outlook.com (2603:10b6:8:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 08:04:38 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%7]) with mapi id 15.20.9253.013; Wed, 29 Oct 2025
 08:04:37 +0000
Message-ID: <b61411d1-27ab-407f-87d3-35f6b217beeb@amd.com>
Date: Wed, 29 Oct 2025 19:04:06 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v5 07/10] PCI/IDE: Add IDE establishment helpers
To: dan.j.williams@intel.com, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: yilun.xu@linux.intel.com, aneesh.kumar@kernel.org,
 gregkh@linuxfoundation.org, Bjorn Helgaas <bhelgaas@google.com>,
 Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-8-dan.j.williams@intel.com>
 <eeca3820-01dd-4abc-a437-cf46dc718ab6@amd.com>
 <68ba3c9f508ed_75e3100ef@dwillia2-mobl4.notmuch>
 <43070157-cfc3-4ef2-8b2a-e677515e8bce@amd.com>
 <69014b1d8567c_10e910013@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <69014b1d8567c_10e910013@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0200.ausprd01.prod.outlook.com
 (2603:10c6:10:16::20) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DS0PR12MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f585eb5-29a2-4724-2cb1-08de16c1ce23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjZKVSszcWFidXE4RHgvUEVpb1crYVFxZFBTME9LS2wvNm8ydkFXc0dxMWRn?=
 =?utf-8?B?YmFEYlVsZjNPOFJld1owUHM2bVgyZnVobTU3WVcwakZOTVBuQ05rSzZUMi9L?=
 =?utf-8?B?ZWJHYnNaa0lVcSs3bGpqMVFvbGZ1WlpTZDNtUTFwRnlWZjdWay9QRThTdGhC?=
 =?utf-8?B?NWNqSXlDVlVZODBqL3RjbVBXZEVuZVBFeTYxVzliS3NKYnF6dVI5bG9QcSt3?=
 =?utf-8?B?SEhJUUJHMHpjaFVxcHp5dWtDY2YwTjZUOW5hbnZtSmJLaHJRcmRTWUx6UVY1?=
 =?utf-8?B?SmxVaFU0aUxla2NITzQ5SEZORkxlckovemVKakxhb295eUJPMEplb01xZXlG?=
 =?utf-8?B?aW9TYXM5TFhGR01JSDdKVjVFMVBoSlA1M05QOFJUUkpjOGFTekFtellscER2?=
 =?utf-8?B?L1ByTi9LL0swbm16bXoyUTRQYXhUaDBicGNBY1FzU3NYamNJYjRhS1Urdkl0?=
 =?utf-8?B?TVNXNHllYTB3Kzg2NCtwaE9uY2ViWVJMS21oT09SaTFzaUZ2N2dVdUFPSzdU?=
 =?utf-8?B?U3FTdERxdGNFOUlDRlczK1dOUHRPSUE2UEI4WHRiSVhpemVhVVVHNUtRNGYx?=
 =?utf-8?B?VVc5Q0lpYmFPUDRDay8wZmV2QWhCK3ZpV2EwbWswYmRGQ29aRzluRW8yTEly?=
 =?utf-8?B?ZlVoREVTN2xCWmJsRGJ1aWQ5UTFTZEhabklXdUZvQisraVdhTjJ0dzBpOFFv?=
 =?utf-8?B?VmZXUWF5YkUzbnFsbUdVSVZGbTNSS3hUZXpUcGhmem9sQ2lNUENaOGZFcUhP?=
 =?utf-8?B?Y0FxWGRENVJXanR6TVdDME1UTkZ2djNhbktTRStPTGErMThic0Yya0NKQVRO?=
 =?utf-8?B?MW11N3hZd3hDNHdmU0pySVV4UGV3bHJxM2RLMnJBb2lYNVlVZG5KVWJKdTlw?=
 =?utf-8?B?eTVTOEJSTXhySlRhTFpLdFRIUXFhNWRNSFZ1OTRGM2NRcVpzWkwrN0sxa01h?=
 =?utf-8?B?MG1MSGtnZm1hZVB5OFc5N3NmdFdBRCttdHFVOVZnUXVWZlZEY2VEUWI4YWFH?=
 =?utf-8?B?WnU4cEptcDZXWWcyMnV0NlZmd2RuWW9XTVRFcWp6cml3eWtCVmd6L2J2M2Nq?=
 =?utf-8?B?dU1PUHBoQUVjaFJ5ZzIycnpNa00rT3NrWTJ2dVNLMDNJWGNtTHlzRmdBTlM4?=
 =?utf-8?B?cXhYSlkwWHA0OW5YVFRaa0Zxa2dKbHhnL21tYlorZGE4Z09hTHR0SGRpWXhO?=
 =?utf-8?B?TU45cmM4RlRGcXZHdmliR08yL25kSStMcmowK3VMV1RveUJic0RiMWlHTnRi?=
 =?utf-8?B?aXpwTmZHTWdhWXpZOTdlVG5RWktxenRTSFpDelorRldlLzd3VktHMjUvMzNo?=
 =?utf-8?B?QllrOXR3RHRWUWhCOTBscjQvZmZwRFpERURVb3NzNlE0UCtnTGp6SGZob2FY?=
 =?utf-8?B?YW1qOGR4eC9pMUd0d0drY1UxdEZ0WDFIWkVUb1oyQmNxWFphV1p6OWxFM0tw?=
 =?utf-8?B?Tjl2MjdjS3MwY3A4T3I2SlpjaGJuVlRYZW9kRzgxeFU1cW01Z3hFZmFBclFV?=
 =?utf-8?B?SFJzejdac3JFSmNOekYwby9TbzNTbmpUdW5zK1hoSHJYVjdPQlNvNmtERjMy?=
 =?utf-8?B?Mk5odlk3VlhvYnZLSkR6aTlnMUl4dVIydmhKYmp4RE5hZFpGcXZHTDJLY09y?=
 =?utf-8?B?NytHRTFUSlcrMzhQY2diMzBzTEZSVkx6bUI4YVFOL2RKRS9xcXZZaVUwUmE5?=
 =?utf-8?B?V2xkZkc3bUx6U3BvSTJ5elNKT2p4ejZ1Mll2Ym8zMkNRLzZsbGJGUUhzNzMz?=
 =?utf-8?B?Y2JTWmdKWEpxQ05Gdzh5VzRtTEt4K0d3NDFLQnZVRFZ3WldxbWIvOFlqVlZN?=
 =?utf-8?B?Mm8xRlMvWTIrd1dmUVZteStFWWwzYzNSYW53cDFPemNzbDZQbHBSNFNiZU5P?=
 =?utf-8?B?T1JBbGZXL3pySUhZUmh4bDhZdG9pTW1FYmk3KzdxR1FaV1l2Sldzb2R4RUR2?=
 =?utf-8?Q?OcBiFd1cxjwc3NeI6pXOZgK/uHuvAofd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0JIdWV2SU1pVW5uOG1CcEN0Nk4vSnpFcDM1Q3hzRnI3SnNjWnJDMUFmdnJL?=
 =?utf-8?B?S2tVSW8vbXV2dWROT3hGTUh6dTBwQU4rck9SaEd5VU1ncHRzT0l6cERrWmdF?=
 =?utf-8?B?Qi9NZHM1WlFPZTYyVVlVMEYxTG9KaG9UYXRvTHpYdEJFN1N3aCtVU0NTcW5I?=
 =?utf-8?B?U3ZNcTJsVndEcGFKbGJjK1I0d1lUQjg4VktrazIrMSs1eFNxL0tBMnhFRlY5?=
 =?utf-8?B?TE4vQlRCdDhWSk5aWlYxWUpaMWxMWWoxNjJEdXdLaERsbWZxVi9vUjdJZGVk?=
 =?utf-8?B?azF6VDAvZFZCZm1zQW53OTJ1VWhyQmt6bjlxbHhvU20rTVBpRTlxWUJqV0RO?=
 =?utf-8?B?TDhjTTVCaDdLaS9nT2RkYjhhZm0xdzZJajlUTVJLWEZ3R3NuZUZ0d09UR3Ni?=
 =?utf-8?B?RG52Z0M4eVh1NldiaEF2dm5RUHBvYU56cXVxUnArQWlGV1ZwdUJOZ29VT0d6?=
 =?utf-8?B?RFNaWjhyMXV5dzRienY2ZGtKMXpYQlU2bWRHZTl1NUlleHNvaGdnMnpJWGZ4?=
 =?utf-8?B?N3NheTNPZFRhR1hjSUdZTXI1ZUdoRDdiYkRHZlNEbklrMndSeUJZR2VFRS9t?=
 =?utf-8?B?dmVlYWl3bU0xbEMrdTNBRXFqMXVJejdGQlc4bkNlekwwTmlHZjBTc1VnbGZm?=
 =?utf-8?B?WnBmbEpsMXlyMEdjQmV3dC9sckRPTHo5N09vTWVnckRxQkx1KzYxWStYbm14?=
 =?utf-8?B?c0s3K1RuaEl0VEFpci9kTlpiRS9TUFJQWVUxenJaTnl0YmJVd2ZHbmI4R0l4?=
 =?utf-8?B?ZCtBZWgxbFZoV2pJTHIzNlFFazhRTjRybCtCN1ZOT1BDSFBoMGdYVmIyOFdJ?=
 =?utf-8?B?ZUJicjBkU3g2d1Fjd1o5aE9YSmg3clBwdi95ckVEUktPZXlPV0RYV2VDNU93?=
 =?utf-8?B?eVNpTmJWV211cmJoaCtoRnVoUldGVnBYeFdPOFBnOWE0QlFlaHZuSHJjN2Rj?=
 =?utf-8?B?SDlsVkVyZlYrM0txWHR6dGdTL1F4MEFYWUJlZDhwOWpDc0NUM25hVjk0TE5j?=
 =?utf-8?B?dDZ6cGlkU00vUEpRTmlDOWRKR3k3c0MyMnJtVm51Tng5enIyWWpNUGpzaTRh?=
 =?utf-8?B?QmJJNDJycTJKTlQ4SzhjT25zZnNnNE1sakxKMjFnQ1ZxOVg3NjZZVmg3Sk5k?=
 =?utf-8?B?QnlDMGg4SFRLNE91Mlp2dXRJbnZETlJueExFM240eUpNTzhpcTN0czNpbzNi?=
 =?utf-8?B?NE9jZ2ExWDRaeWZkVmF0WkR1dE9yb1V1MjgrSmtpMmtlSTN6UnVHdVVmWlNM?=
 =?utf-8?B?VzF2Vmt5OWVDSGtKdThBbDBhZVNEZEFleDZHQWxqSzN5bFdxaWJweTVCemZv?=
 =?utf-8?B?MmJxL0EvUHV1enVEL0J6NGhqUkFXUUsvRGNzRnJBWHcwYmtXb1crOG40aFdj?=
 =?utf-8?B?MUtYUGdPS0Z6TFZqM29mNzc4TTRGN01uMnltY0dVYkk3WnEzanJvVlMydGlN?=
 =?utf-8?B?ZHB5T0k2MUs0cXI1RFkxRjNtVHExUWhqTWQxaVE5dkpSVFBBU00zRFRsK2Ji?=
 =?utf-8?B?aUhFQXByakk3bU1HbnYxVXU1VXhvM3NVdWgyZElZWUJDTTUyenpXOG5nS0s0?=
 =?utf-8?B?T0JmYWVQdzJFUEkwczR6UGp4MnNaV1RyeFdpQ0poSTBiWTVQb0RCNGs2QjB3?=
 =?utf-8?B?SFVLNURialMzVnViSU1Cc0Z0bGR3d2k1VExWaVdHZkNWa1cvNlRhWmtNa1lB?=
 =?utf-8?B?WXhqS05qNS9wYzB1NWpMdnUyWElJOXZlUmhndHJ3QWEwbk16ZWVMdndjWEF4?=
 =?utf-8?B?UnpvSE95cVlha1VoNS84dURRWUYrbSt6N0orQzlhdnJOYzhiaEh2YkRWUitG?=
 =?utf-8?B?endNb2FYTlJwSUs0TDgwRGV5eWgxV29TL1hzZ1FaUFA4eGVyb0w5MWtkdnYw?=
 =?utf-8?B?d2VrSzhKSEE5NWNhc0lPMmM0dlZnVit1RTRQOS83aWVDa2M2dU1QUmV2Z3ls?=
 =?utf-8?B?aFZNTmhxSVB1UlpWRXlCNGJ0NW5VWjZTQXJkblNLalVKc1dFbXhneDB3THJY?=
 =?utf-8?B?T01pdjhKZS90eG5uM0NtMXhVazRVVWZuaHRGU2JFdXIyaE5saGdGdW1rRmxn?=
 =?utf-8?B?aWhzNE1qRDFEMHQ4eDljTnZWUW85MnNJVFRmMUtNT1RVY0pHb3VhaWt1QnA2?=
 =?utf-8?Q?VB3M9Zrdus00Iw1EEe5bkMDjO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f585eb5-29a2-4724-2cb1-08de16c1ce23
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:04:37.8059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HSIq4qvhadWKqsuQcdzMJUKydODE1oRPHFq/oqDKtiYV+b7PGQc1pUlC0BWYwlONJ8PMRDkGPIU+XRymISTN7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7606



On 29/10/25 10:00, dan.j.williams@intel.com wrote:
> Alexey Kardashevskiy wrote:
> [..]
>>> diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
>>> index cf1f7a10e8e0..a2d3fb4a289b 100644
>>> --- a/include/linux/pci-ide.h
>>> +++ b/include/linux/pci-ide.h
>>> @@ -24,6 +24,8 @@ enum pci_ide_partner_select {
>>>     * @rid_start: Partner Port Requester ID range start
>>>     * @rid_start: Partner Port Requester ID range end
>>>     * @stream_index: Selective IDE Stream Register Block selection
>>> + * @default_stream: Endpoint uses this stream for all upstream TLPs regardless of
>>> + * 		    address and RID association registers
>>>     * @setup: flag to track whether to run pci_ide_stream_teardown() for this
>>>     *	   partner slot
>>>     * @enable: flag whether to run pci_ide_stream_disable() for this partner slot
>>> @@ -32,6 +34,7 @@ struct pci_ide_partner {
>>>    	u16 rid_start;
>>>    	u16 rid_end;
>>>    	u8 stream_index;
>>> +	unsigned int default_stream:1;
>>
>>
>> This sets "Default" on both ends and the rootport does not need it in
>> my setup (it does not seem to affect anything though) - the  rootport
>> always knows the stream ID from the RMP entry of a MMIO being
>> accessed. May be move it to pci_ide_partner? Thanks,
> 
> I was about to change this, but it is already the case that "default
> stream" is only an Endpoint port concept in pairing of endpoint and root
> port. Also, this is already in 'struct pci_ide_partner'. So if your TSM
> driver sets this for the PCI_IDE_RP case, then that is your TSM driver
> concern, I do not think the core should worry about filtering mistaken
> settings from TSM drivers.

Right, my mistake, as of today, it does not set "default" on the RP (not sure when/why/if this got fixed), please ignore the suggestion. Thanks,


-- 
Alexey


