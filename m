Return-Path: <linux-pci+bounces-34811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCAAB375C2
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4EC2A62C1
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 23:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E45F2FE054;
	Tue, 26 Aug 2025 23:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d8+An65l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE233054E8
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 23:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756252693; cv=fail; b=j3M+0novVSrZj0jSgxJwMaAjl0mAlbKv8mDuyQlAAEjp/eJ0Sxk3wTCxNw8FxLH3k9cXnOEUIetpuK1JvcQk1KQgh7eWoSXLgVHe5WRjmwgNYuEaiu5J9qX4T40q5yC3gSmA3KEwU7+5AM2N54Yex3P8V0bh6zMjNQMf82YMA0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756252693; c=relaxed/simple;
	bh=oS68twLonsOmBvaHEyP5222leB9bn9u9oigZlXLsHWY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=HdHXWYP7Ofn6NWWhAkmV0LdzJPmVb79Iow/3EfNkLyUWwVTfXKOcODe0PR68Wj1do8mbuguEMmroFxXh+SkGfqPfMO2PrjyVvt14xVdapKgWq3QW68cC4d5qZzLw8X4a9VngkeU2gALld3M6BIhthEPutVqJh6sKQEnYrmN9T7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d8+An65l; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756252691; x=1787788691;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=oS68twLonsOmBvaHEyP5222leB9bn9u9oigZlXLsHWY=;
  b=d8+An65lOSuKfm88o6WdiEQgmZ5Qq/4+wuuYEkiJ2I+qJvOL7vkY1cxz
   3VoG4kXkBjgNuVn9MHZgTk7+D5wYKoesRTrRO7RnfW6soNdciQxgaP9XV
   n7/z6n6TQqNljtEoAULpNmiXH/tOip1FJWFGgBCWhiK87jQLhSPU/T8K4
   95TeaYFQLrpG1YIB+UQzEdRmh54rRQ4bluBRr6CxhYEb+BJKMpJ3w7zGw
   E4k/aPevLTzKLsha4XNJek1ytl0y+pnfN0I+s6sP39TOrb3F0dLs2GjfN
   3KUwLU3VHaNbZBu9eNSkcQgmPqdt30RShjVMPlQqKTIHUNRhl5xK43Sd4
   A==;
X-CSE-ConnectionGUID: sXPLZNNgQOWqpKpzzwOGhg==
X-CSE-MsgGUID: 78s53U4AQsyiDI2EB7Dt/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="61137475"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="61137475"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 16:58:09 -0700
X-CSE-ConnectionGUID: tzMxxh+CQ1C5jT2DSBGxuQ==
X-CSE-MsgGUID: wvV7/ryQQU+OOxy6RvdQQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="170101619"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 16:58:09 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 16:58:08 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 16:58:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.46) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 16:58:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBzldZssQE6ZCnpXulwv9vMaXDazOsYnele+fN7JR+yVqOs3bzOfFhJHV4gZgXAU4vQLJ3YerhQIy/5VzrdyArkdYc3j2dtwMbgfcinhZSR4wgAX2pxfo4Zrn+QvVlvo8ZK/EwSBm/ifJvLSJBRb8g3SASpcKzCzaVuOyUpIWStqeK/qOMokyS2ULs1imMTKTg8D72b5lZJQE92MWmMbl8JYN4IcE2JnPacj3Z/ArwhVM89g5mQ0GICfclOojniYoBo1FzeIHjoIcixSS4ywlz8l0U2+5vmoZLj68e//lchpXBzMga9zXvM9eg7xXHDZYRr4rEOqwIA4r68v3bhheQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiLV7cFBbfk/liap1XGykop2fa5Z5E6EjDaspQgVO2c=;
 b=TCMQ+DNH+zh0WtqJ4mIoFFId4zWH5DetWFkpX0Loeea5FJoc2+dtacatMmTfdUjRYnWrrw/EGYIi6D5hRgJ+LSzyg0zacP5oKDKaTL14jFFKCxhFkouMsiJqdc06N5iSu/vOhRi7ez9fO4yDvARFFCMEiSESqlYVLMVIPM+E8YoH6VPhHE+Uh67aM9FQKI6TPSsd8l2ACXf1kCuFXYflMwE5B7YVyw9cQh8JJCcy0NJ7eIAl+iaRgSrEvpqf3DG5sSVcAm+4TS1A1Z2hkO2jazbDlaXb0blH5y2cim5iiHxTvdAQhOSycRmwAiK1M2EC6SyTpdK1RmdlLRH83nwFkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7510.namprd11.prod.outlook.com (2603:10b6:806:349::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Tue, 26 Aug
 2025 23:58:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 23:58:06 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 26 Aug 2025 16:58:04 -0700
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <lukas@wunner.de>,
	<aneesh.kumar@kernel.org>, <suzuki.poulose@arm.com>, <sameo@rivosinc.com>,
	<jgg@nvidia.com>, <zhiw@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, "Xu
 Yilun" <yilun.xu@linux.intel.com>
Message-ID: <68ae4a0c45650_75db10016@dwillia2-mobl4.notmuch>
In-Reply-To: <b11535a1-0b20-41ec-be3b-05d7de3a6db9@amd.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-4-dan.j.williams@intel.com>
 <b11535a1-0b20-41ec-be3b-05d7de3a6db9@amd.com>
Subject: Re: [PATCH v3 03/13] PCI/TSM: Authenticate devices via platform TSM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0204.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: 8256c221-9f1f-4a7d-2c56-08dde4fc66ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MlQ0WHZiM1ZZRG0yYy9ET09EZzlHVGt2ZDJzeXJYMTdXcTkwR1lmSStFaUN1?=
 =?utf-8?B?bVNDRlVLNVoxWEdYeUdHdUxWWlUzcXZLUkFiZFVyWXJrRW5LamlJbEtXNXJp?=
 =?utf-8?B?Qk55NFFXVWZKREsreHdscXRJUFBDT0VtNW42RU5NZUxSQ0tFY0pZQWFHUFN3?=
 =?utf-8?B?aHJPZ2VtS0E0eW5Yb0x4TFNwMnJtTjB6cDJoNFFJZVlrWHRzQ1dRN2E2VlpD?=
 =?utf-8?B?TmlBK1NhK1hUNzY5RlJ4bXh5Nk52S2tST3QrK2ZlQjZZYnFNNHdFeTZyWDRU?=
 =?utf-8?B?MEZ2REQwYTcrTW5hSUJaRU14SGJmenRwQ1VyaDBrOEVaMzV6T1BRMGdQZmVI?=
 =?utf-8?B?RTRLUEN3bTBUSDBVTnA0QjUzby9XSjJ1ZVBPV1NyVkdJQWQyVlp0elFadmVy?=
 =?utf-8?B?V3FVakZPUVNqcklDQmhUWmxXM3dXblF5L1dxelVBektTbGJ0T3h2TnJQRDFS?=
 =?utf-8?B?SXVoNTY5SmxBb2RRZlM3TjlxUngrZWRXWFBpYng5c0JKN3ZDbm9XNkJwZ3ZN?=
 =?utf-8?B?QzhncCtMRmRuRU01d09qM3haVVpPbE1GYm1XWFVRS1Era1JNSlhvTERLdkpR?=
 =?utf-8?B?KzFlK0loUktCditBeWo5TWw1eXNaVlhEM0NUcUh0UUZiaDQxNmdkb1lYOHhG?=
 =?utf-8?B?WXFVTHBHb1JWRFhKcUhCTUJlczkxY0l6UGpXb1A3VzJBZnNBSDhTYnlyZlE4?=
 =?utf-8?B?RDBpdG9PRndRcm0wdVR5aVNMTGdjSnFzMGxUVWZWbm5rMlBRQ0dVVnNSZk1a?=
 =?utf-8?B?UzhTS3pUTWJWQ3E4SC9jSzVuNVJjZFdycmhlZG9TWWNiYnBvMm1RdU01WVda?=
 =?utf-8?B?SXB4ck4yUndrWDV4UElTRlM2SXF5RUduTUl3Ny93aCtDUDczSmZGejJXa0w4?=
 =?utf-8?B?bUo4RkV3YndGNFFNVDVqdkZEWjlNOHFQRVBnbjc0WXE0WEVYQ3RPUkF3Q2dS?=
 =?utf-8?B?bUluamxVOVE5S3hvQTR6TEdYTjNHb0lIYjFpRktWQ1RBcTNtNDhoWnJKQzRL?=
 =?utf-8?B?SW9TcW1tTzQvTXRVZ1BnMDVVbUVkNFEvMU10eGlLemFlMFV3Y3d2aFNWTGh1?=
 =?utf-8?B?K3VlZ0dUbVNXd21mN1lUNEE3aUQ1WUxsd2VkNTNsY0xFazRaejlaNi9wK0lZ?=
 =?utf-8?B?enlvMmFyRlZKTzBXeFNITXUzcXVGc1JPM0FrNktTdWRtRmtXK3paSW1QTzJF?=
 =?utf-8?B?bk1XOG1WQWtaT1Y3NWdVblNWRWdqdExkWmgwTlZUZmZONW1YWGppaVErc0Qr?=
 =?utf-8?B?a0oyWGRucjJUQzByN1VTdndoVjBRREdPRXhLYVE3YlVnV3QxY2pOTTJPNnJX?=
 =?utf-8?B?aEs1bmo3VmQyeHVXeUhnKzUvUGlqQjJpM2ZGQzhDdWtiYVpuMHlLSEZNQit0?=
 =?utf-8?B?Nk1Vd3lSVGtLTnBkVStTZjc5WlZaRWpzQisvL1hIRlc4QVdHS2N0WUxISWM1?=
 =?utf-8?B?YzhMRE5OaXdYbGMrbWdESk5mVzcvL1kwdmtQaG5IVk1MOW4xV0JVYmczWkd2?=
 =?utf-8?B?ZEI1d1RxalNDc0Q5aU11b1B5N29KOXdLeGZBSkdndmNYcHZSYTVXaUg4R0Qy?=
 =?utf-8?B?Sitvdkk0bWlRdGxKdFBQZkRFMUlsUno4Nzlpang3ZVdtSXJlbndGZXBGL2FG?=
 =?utf-8?B?VTYrcnpxYzNUN3BxS2ludmNNWkVTbkI4cWthUUxZc0pnQnd4cFoxNmVGdmU5?=
 =?utf-8?B?Mnl5OVVHSkRtYURvNEN6SXdjRWlCZGs2dVo3TXBISUpoYjIxVHRFWTZGQW5a?=
 =?utf-8?B?TnppbUtJRHdlOE1NWnRTUjlFazVpMXAvaUVjRXY5K0FYTGNwdDc4bGpzM05E?=
 =?utf-8?B?ZlBtTEZkNWJkOCt4c0FvRkVYemJRTThFSEpZNTQrSEZ3U3dRUEEyenpaOGZM?=
 =?utf-8?B?VkxVbm1DYXp3cWR6UHk5RGNZY0RHc3JWVWwrVW1BTnhCaVFrNFhpUURPZUJX?=
 =?utf-8?Q?KCweGo59q3g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1hUakpCMjR1UjJ1cGF4cUpXV0xCU2gwOGl3TVZSRklUV1pVV2tHVXB0R2ZL?=
 =?utf-8?B?UUNEcDl4QTdpR2lLMzRKdXNFOUZTV0VGNy84bFBvcFBnbUlxaHFTdmhBRXpP?=
 =?utf-8?B?RjdFVjFzaUNMOE5vSlV3UU0yQmdYRmJ3amYyUW4vQ3hOajI3MmpKM29BZUtx?=
 =?utf-8?B?K0R4Yy9GUjRsMTFjMmRyVmFscVp3MXVLL1RXTzJCaXFjWmVJRk1jaWZHYy8w?=
 =?utf-8?B?Wi9mTTNZaUhFNVg4bXRhWnprRFplWnJHejU4NStqV3FXbW8wdVhERTJ3dHdr?=
 =?utf-8?B?UWhKSjY5c3Y4bUdDbm4yNDNVc29hUjIwRjYvem9UZTNKMUdEa1lISXZxRTM1?=
 =?utf-8?B?VldYOGlMb3FqMnQ4ajVvaDdvZ2NadmtKY1ZzN1MzVzhQa1JaVk9Gd1lZNkdU?=
 =?utf-8?B?ckkxUHYzSWJhQmt2ZWJxZUtXNms4RHVBNHZjOFB6d1VEallIY1FybGdNSzZU?=
 =?utf-8?B?VlBTUm5ENEgyMng4OVZkVW11MW0veWRYdjlVZUErbXVUc0d2MUhhZGw3U0Vx?=
 =?utf-8?B?MDlzNDRzdE03ejZGejk2WUlTWU9WYkE3VWMxL0NXSnJCZU1EZFYzaDlqS25m?=
 =?utf-8?B?TVZoMEZEK01zK1RuaTF0aE8xeWJETlNad0VrRTBLZy83aHpLZEUwVE0vNHVv?=
 =?utf-8?B?VXJES1FOSTNVdjdDQW5aWDlRcXR3Q21sWEo1Vjl5TldOb2FIaUh4Mk00dm51?=
 =?utf-8?B?c29kUVZ6UTJkeVM3M2VMR2FLK1FSdXQ1cDNmRklsK3NzZ2tlUlovbGU3amp4?=
 =?utf-8?B?YS9QOGliWWlLdjBxeWFmWUhmUVRoTzN6cUJJZkdkMHVpajA0YjlnYm0rRVAv?=
 =?utf-8?B?c2MzTHdWUExtQ1RrRU5FTDA0cDNaWEZEQU9KMHpHRisxWjA4Z3Vtcml3RExN?=
 =?utf-8?B?WXZwQ2ZHRFNDaE9KTUlWRFJvcWYra0ZBczRkZHZ3ZkFqQVAwL0xROGdCbDRO?=
 =?utf-8?B?dU9FZWZvUkNrb1hWWk5yK2pvV0VTZTA3UVYyL1RhVEpxTG9QczFwZkpwY3Ji?=
 =?utf-8?B?L1U2NytWdnI3Z3BRMWtRWHg5QmE4QUlrQ0VDZkE1UHNSWGRoNEI2bTA2cStQ?=
 =?utf-8?B?OUFqZnpuVnlvdlp1dFJyWnlKZUxFem44Q1ZmSFh5M2xpMXRmMXNaQkd2SlVV?=
 =?utf-8?B?MnVPMWFUNVVxRmtkVVZnZUh5aWR5OWNNWE1nS0lJVzc2c1cxZ3kyMEloTEFC?=
 =?utf-8?B?RUN0M3QzRW9XQTZyL1M3Q25LS01MM2tDU2FoMDkwTldrQ1VURndWVmd3bFZt?=
 =?utf-8?B?Y2xOMWJpUHpicVNjMDhXOEtKRWNoSHJ5VW5HT2gya2R1cVZ5OVdJR3p3SFEx?=
 =?utf-8?B?N3VLendPeDlWTENBMGt4MUppRW5FeTZUU0ZLU0c2cW9kb1loZjRwd0dMeVNk?=
 =?utf-8?B?UXJsYnlOUnphdlpwc0szaFhQWE5HTkpybU9WL0RtMnA2MGdvTExmS29hTFJz?=
 =?utf-8?B?cXRZYWJJNUZqTEU3Nlp2eVFMb1RBU0x0VStpbEpLTU1HRDB2YkRaWnNMclc4?=
 =?utf-8?B?Wm90VmI1Nk51L05YZjk5R0plVUxCTkdWekZJZXZjWmJhc3p4MDR5NDRvdDJw?=
 =?utf-8?B?VGJ2anFRQWI1dkNLL3NKMktzckFLaWxteGhmWXJrWHR1dnoxVDl0SW03REpw?=
 =?utf-8?B?SXdtaVVZcmFuY2NqYWQzRC9PR1lWanJIditKeXp6WU8xRnh1ZjBuWmxMTURI?=
 =?utf-8?B?ZGs3VnRHeG9hQVhMYzZLdFc5ZEN5bi9aUzRIZXg2QmN0dGl4T2xZWlVnR2Y4?=
 =?utf-8?B?M0tRL0s3bXQxZDNjWFhyUjdWV05Za1d2bFFSWXZGNXByNHh4aEJtTnYzT3pC?=
 =?utf-8?B?Z3NuMlhlNElJeTFFSkYxa1lxNXFEYTdZQVVGU2pyWnlyemJkYS9yZlY2WDBQ?=
 =?utf-8?B?dmc0Yk9KSGw4N0E3aS9JVGw3RTFITGJUTTI5TlFiR3hSdC9XbHhSYnFZVmNn?=
 =?utf-8?B?ZEZMblloL1l2a3ZWRFcrTzFsWEl2enV5d2VpOUdjN2VFTzVtYWdnZmdVMGxT?=
 =?utf-8?B?NkpiT0h4M1d1bVdNWmV1M3AzSHR3NU9XV3AxZTBMWEVzMGk4R0o3MDNGcGJS?=
 =?utf-8?B?MkkwM2dQWGJxSGNhb0dCM1Y4dzY1MEJvd3N5bnI4KytqT2ppWWtoTDMvUlpG?=
 =?utf-8?B?bEs3YTN2UlVlczV3U1ZoN090aVNGeWJWRlI4RVIvWGVvbThxb3dMV1lCbnI2?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8256c221-9f1f-4a7d-2c56-08dde4fc66ce
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 23:58:06.5435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJKrb4lSd+QuVBIJoBsIoLJfrAfbI6PVM8kVGCq8Dq414Fg5kIK0+Sn0An8hr/UUrZ2dzvZxXxlJT3efmrsbKhEZG/zcojKQc7aPP/54HU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7510
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..trim reply..]
> > +int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
> > +			 const void *req, size_t req_sz, void *resp,
> > +			 size_t resp_sz)
> 
> 
> This does not belong here yet - no user.

I had been pulling things out without users, but Yilun and Aneesh ask
for them to be included for staging purposes. When this staging branch
goes upstream a user for all exported APIs is a requirement. However,
per your comment below this is worth deleting.

> 
> But if you still want it - "enum pci_doe_proto" should go to pci-doe.h like this https://github.com/AMDESE/linux-kvm/commit/af12dec97ed98a9f365bbbb6925e76c556937d01

Yeah, I will move it over there.

> > +{
> > +	struct pci_tsm_pf0 *tsm;
> > +
> > +	if (!pdev->tsm || !is_pci_tsm_pf0(pdev))
> > +		return -ENXIO;
> > +
> > +	tsm = to_pci_tsm_pf0(pdev->tsm);
> > +	if (!tsm->doe_mb)
> > +		return -ENXIO;
> > +
> > +	return pci_doe(tsm->doe_mb, PCI_VENDOR_ID_PCI_SIG, type, req, req_sz,
> > +		       resp, resp_sz);
> 
> The wrapper does not seem to be very helpful - the platform driver
> (==TSM ==CCP) which is going to call it already knows it is a DSM and
> mailboxes are initialized (otherwise the DSM's pci_tsm_ops::probe()
> would've failed) so it can just call pci_doe() directly. Thanks,

True, this is a weak helper the TSM driver already knows when and if it
should be using the already exported pci_doe().

