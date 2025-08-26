Return-Path: <linux-pci+bounces-34696-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116FAB35191
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 04:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7158244D73
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 02:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8401F9F51;
	Tue, 26 Aug 2025 02:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LRwFJ1tb"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A841A08AF;
	Tue, 26 Aug 2025 02:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756174985; cv=fail; b=bVQ75qWCtr7YCG2fyhu5YUkRKEqgZYYNav3Ua6I/LGSPB1YBjc9UJmir9Ahy2/6Fk2/PjFUtAnAszNhZ4nS9JmTDNFgc1HIOeFi3Jn4v09G28yQ6R6dnn+kZx0TIt2SnRzMbX0uk01Ka5DWQKXoxBAwr4J3dt5ReLfrYvCXDovs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756174985; c=relaxed/simple;
	bh=bzJwfN8tkBYmSp/NsG/nomS7hrRg20MsxLA5eWhXmc4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DNmX7aISLHVBB+FhthvZl4+f3Mae1Y5TRYXxK98ZPOqTtoZTnBCXSmRLJpOTfuH4XRTD71LdmfoZrY0vCXOEfZYRtYivyH2IO9Ku1iHY5rJ8mDubFi78/nZyPe7VwL911dcY5/qPc6fjUuDjIzcBwnRbTXZIQNcV/QyYeRLDbyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LRwFJ1tb; arc=fail smtp.client-ip=40.107.100.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AcSDk+nKtkA+sIe4SaKfwPwgy6tVCahKAVoAT0+g+qQI9/pQCumooIiXT6oLM3/T6UtGeXP6xTc7yKfVH/dDWh0VcjtKMJfKr8ncMiUKhCQm2qxtReTeGYLSJeO8dc9+EfuQGXkXZDH6ThAuPl3XYE1WA7hCVvSwCiEyJHbkbN4tvXxkB+kIV3HqkOTf3QFlEwhI5OSdBOVd2gvJEId5IqrIeTY8TxiEBvcxKtjMVuINMpw5kJ/YoGCIefJqSPHAHGZpuHQ+rieCcttpT9Zm6K8oIkj8P1BmcTD0vQldCu80PMBEHpei2CqskVbukp/ovWjVpJgrKtGKxbTzD2G0MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mY2eCwYb/uoKFTFFnljT04i2pYrfIAXhRtXmHoHh4+w=;
 b=NKM50HAGbkScu6jehymidsO53jX4goq7O3U4VXVap3JeWuhxEbxnexpm58tVuw84b/hZLpmDTj5mHeUyVzA0OAR6TcbM6ilJs4XpKq9VkIl+XPRZntDZCs7H5KcJ/Jv7o6TWIdjb3E9ylFw/K7k1CW1SN3F/V+fHzDjushshe2oldrSt6f2s8X0xo2RItq/8EBJySBm3VcRZN1WuAF+uCrx04LaKesjC8i2hEUlCRaYdkYTm6rDn+5B7Nlx9Sw4stg+JHKWHXVc+m9gZOcfC9kn70xAltL3HPtixDLaCQyot6O03bMGyT/W9PdQpwlTIlWVLbwCQOrqGxArvV+y80A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mY2eCwYb/uoKFTFFnljT04i2pYrfIAXhRtXmHoHh4+w=;
 b=LRwFJ1tbCaqg3D/CH4wcDg/PsZU4nwXNQTEzFGOINlXdQDj6i4IVk8EYcf5x2BuUhlhwLZuOfkddePqSgiGEcj68bAdJuyR9pXBtxHiPtVvUjzOqWeieJQNAhhK+MAMjuX2bcu1Vs+Qx800SWk+yVaOyIYdByMfLGp7G6KC/DSQ9hakYQsuEzAjqoHPrN+/nNfjsxgsLwIX29ATeB3QCcMi5dlWYMHk0vDnDHDQnYk7mb1haz1z2casqzy+PsFk7Di3XUhdBwczuJ2NY3+bjyvocQdPlXFYX2Fh/yMmUj59ITe5ayXMm2VGH+hVfralPwU8LqgM9oca4vJgEL5iYSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by DS0PR12MB8020.namprd12.prod.outlook.com (2603:10b6:8:14f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Tue, 26 Aug
 2025 02:23:00 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9052.014; Tue, 26 Aug 2025
 02:23:00 +0000
Message-ID: <2c551130-4f2a-45ec-8191-1b14d14ddd77@nvidia.com>
Date: Mon, 25 Aug 2025 19:22:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] rust: pci: provide access to PCI Class and
 Class-related items
To: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Elle Rhumsaa <elle@weathered-steel.dev>
References: <20250822020354.357406-1-jhubbard@nvidia.com>
 <20250822020354.357406-2-jhubbard@nvidia.com>
 <DCBI3A82MOFN.3R7O7I6U6D7LN@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DCBI3A82MOFN.3R7O7I6U6D7LN@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0126.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::11) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|DS0PR12MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: 735d53da-b944-447a-61e6-08dde4477a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGw1ckVsVFVKUFVaYVVhenp2NkxUWG0rNEFSSTRJMGFSaXBCaE9lK3k0dHY1?=
 =?utf-8?B?YkczR1NlSnQ4QUdodHE3NkZPVDY1RHBsanVIWWZiZkFpY0hDQjU0UEdGem55?=
 =?utf-8?B?TDZKSU5DY0R6KzI2Z0NpeGVQQXlVQjkzaFgxckRnR09XdVhxalNTOGNBcDBQ?=
 =?utf-8?B?RVdXTG0vUG5iM2w5RzZ4SlhsZDVCSWxXMm1PTzdwMlBjWnBvRUllUm9WN1Bs?=
 =?utf-8?B?cnY0L3BKOWdWQ00zaTgydmF2aTY3eVFqdmFaTVVGcEx3YklTNE9mS3F5RkVk?=
 =?utf-8?B?OG9JUGhrZEdUT0N4eHE4Nmh4M0p4TEprQ2hnTGY0bElodjhBUGhOcGNBY2hp?=
 =?utf-8?B?S21tTHRLNUppU0pSbndJWHdza2phNE1Jb0ZGOWRoYmdWanlud2h0UHBzK0pm?=
 =?utf-8?B?eEQrUURKbGhUK0VXUlprUHRkejlVTXlvMmo1MU5hazIxSXNlUy84aTlWVHAz?=
 =?utf-8?B?Zyt3UnV0UkxSS0g4NVZjblhnSklucGlodTQrN21yZDdlQ3h0c2wzdVFFNVRp?=
 =?utf-8?B?R3hIbFRWMlZua3NkVnczckNoSVNJQlh4UDBwNjBPUHA2SExzN1IwNkZBM2VT?=
 =?utf-8?B?TTdZQVdVSldrYmo2Zk9aaXNvQUJYc0R0OU80L1N5M04yRlh3aGNEMGpTOEt0?=
 =?utf-8?B?S1A2eW1rK2lndjJRWVJyeWVXZDRiSmNPVTVUNVRSeU5VaEhuL25EbGozOWZQ?=
 =?utf-8?B?Y1BCY1VRKytpdzdzR2hvMnBpcTM5MjR6WVZlUXloSTRLZklXZGJNaGJBak1K?=
 =?utf-8?B?dGlJdjRXdW1Yei9YRm5Eam5WUWRscVoxS3c4clUvaEZUck5ZeDNmYXpEOEhL?=
 =?utf-8?B?TFRHL3JSa1RDZ0s0K2VDR1BLNk5pSWtMKzNzTFJoYThsV0dFdm4zRlNwVkVT?=
 =?utf-8?B?aDBJTVdHMWdLOVhuMm5tellEbUtsZk8wTVJRa2RQK2VuSG52aGRHL2NDUVlM?=
 =?utf-8?B?bVBpTnBvRHUwTGkzNXVvS3pFVUc4aWVyd1l2Z0tPaUUxU1NtOGh0bVlreFND?=
 =?utf-8?B?cGZyUHIyZEtVeEVhSGlOSnBnbVQ5MHMxZ1pZd3ZFUU1jTjhQRjNuUXRkWVk1?=
 =?utf-8?B?TEsxazF2NUgxc1dwOW9XcWVNQWdXQUdybE9CWE1RZlRNZmczSDdCMjNrSEFJ?=
 =?utf-8?B?b1pqYjNFRlU5QVpMSE9PVVFxR2x0dzNucmlDRHhHQzlGdnlpc0tsNUtvR0xr?=
 =?utf-8?B?NVpsNDBHbDlLSDZDOW12ZkZuTFR1ZmdTd2VhNXFzU1kvLys1WmlwbjVTOEpD?=
 =?utf-8?B?Z1g2Qm1UV1ZoSTNRY2I3TUlSTTlpb3FmL2tnYVc1QVE5dlNVdnNMRm95UEtI?=
 =?utf-8?B?eVNtZXV0QzV2eFh6RmVwRkpDc082VHFNbk5lcEtnMjJscUkzT05DQVdqQmNF?=
 =?utf-8?B?eXR3dXB4OHcweWNEOTVvY2tMTi9hMlNTR3ExRkx0NUdYTlVRM3VmbFJPM2Rr?=
 =?utf-8?B?N09vSGFxOXE1aDJJWVhoRVN5TkUyS3RRTUdtcUxtM2l4eHpkV1JoMmdwa21k?=
 =?utf-8?B?Kzl0akE1am5wd2FkcnVrYVBvN25rTkpvOVEzbEd2Q1VYN2FxdDIrNUZxbERS?=
 =?utf-8?B?aXBKREY0OGlQcW1Sbm9xUVlFZVVDWFVlRGkyVHc1UUd6M2QzZ0NZTmlhNFJR?=
 =?utf-8?B?YTNLYUkzYTM1RUV0NXBkT0JLVm1kemk0MXlKajBKMHg5WldUS3J5ZU9xN0ht?=
 =?utf-8?B?eGtzOEV3L1k2TWUrSS9YRFRBQkFNR1hjRDdlUmQ2ZDNhRTRKOGdtRWQ0V2JF?=
 =?utf-8?B?eEFqQ1JtTFlFNlZkMlp6ckJCNFUra2FMN2d5ejNFd3c1enNzT3pJNHRUcHFH?=
 =?utf-8?B?SjNpcHl5cmdPZk5EbzRxL2J0dzc2VkVVRW5jL1QrT2lXWjNWVFdmNFJmdDd5?=
 =?utf-8?B?OUl3Um1zdDJLdHlETERBWEFwQXduQi9DT1JqWExtVHdBU2l6YVY5cmkzZ1ZH?=
 =?utf-8?Q?FP2iIlMqCrQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUdqUjdEWGtHRVBXR3k4V1Y3Tm9vd2ZyazlQU1IrV2xHbEFhSGcwY1FGQTJk?=
 =?utf-8?B?UzNwQi9zNVlicmRzYk44bFRndEQyVEVKUlBqbHVqdm03a3hOalBwVkNHT2Qw?=
 =?utf-8?B?WEtPZG1uV3hDb3g4UDd4eXdWU1J0RklVdFhRWER4QVNzTHVoZG9KQ3c3S2xm?=
 =?utf-8?B?eHRoZ0p0TmVlUHJmK1JWVVZiSXRBSHJQcEFGVXBhdkluaFdyZXkzNEk2MERm?=
 =?utf-8?B?UUEwTFl4OWJyUTdITUZSRWRYdjZKMWw3V0pQeG5sREZBc0dtQVFCbFFxQVJL?=
 =?utf-8?B?aEhDRkFNRW9YSm50V21oaVl2c09ERjBSSDhnT1hob1RJTjdCdXdMcXpHSUZq?=
 =?utf-8?B?OWE3WWZKcERVYTBjU0RUb0dUeFlHc2loWk1PVk40OXJsSWUyMlpBeDdGbEw4?=
 =?utf-8?B?VFVWNWZaazNvWXNsZk9qeGlZY1hnZTNSMkhGN0NNdU1FaDljQ2VPM2dHVXph?=
 =?utf-8?B?Szg5QzkvS3JUM0N3Zll1b3NzYzRNQy9ZNThPYkFtT081dlRHSEpvWkVSdnZz?=
 =?utf-8?B?RXJ6MGw3dm5zR1VWMVJJc1Z0M1JWTW5OQzN2SWsvUEtiWEMxS09Yc2pnVVJQ?=
 =?utf-8?B?ZDF0UzdnNXdlTmFmSjhIY1Fnd2dCTzlTcUNNYStuNmhkTG1MZkJ6MjJxb2pM?=
 =?utf-8?B?WnNGLzF3NzhhQWVlMGY2MkdZU20rMnhWOFZCU2FGd0k4ZDlBUEpBalRtUjlw?=
 =?utf-8?B?RytGUmhqOHR4MW8rVjJwQTMvcEZiWUQzZEpuS0Z4b3dBa2NMcGZOZXFjb0pp?=
 =?utf-8?B?cm9Pejkzd2Y3YjVDNDdSbVRDY2JDVXRza3p3NCtSK3BPam9zUFNVc3hEVXpr?=
 =?utf-8?B?ZHQrc2N0VitSeUF3Wnc1TmJjUHN1MmZOcUcrUGw4QSs5S01xTUdxZE9jY1Vo?=
 =?utf-8?B?VEtWVkNBbXRxcjk5VThZTE1GUUp1V2dWL2M0UVBNcUlhNWRCb3BjTFRrVGI1?=
 =?utf-8?B?MUNGb1pxdGQxTUNUNEgxTE1wdEx0NUdHeUdDbTJkcjdGVmtMUlhHdUJHd3pz?=
 =?utf-8?B?NDR5RTBhbWMzL1hOODl1dXlIT1d5b0JzYjFZQmd4bjMzbUMwMFVLcWU4QTVk?=
 =?utf-8?B?QWhKVFhqVjNOd2U5V05ZeDRWVG9LQmpyK3VCUWg3OVlSclpyM3YxYkI5ZE5G?=
 =?utf-8?B?VVVuQ1ZrUyt5YVo3Z0Z2enl1Z01hMnp5bUJHeXJHb2tjR0hRbHBEanlxbFJY?=
 =?utf-8?B?Zlo2djhScFZ1ckdmYWJZSWJ1dWo3bENxWjIvbE0wQWlQVk1qa2xqYVhkODVq?=
 =?utf-8?B?RkRHei9YQ0dmWXd0aS9kOEpPWVNXUkovUndoSHN0R3QyemtXWHJ0S2hZaFBZ?=
 =?utf-8?B?NGE0QlBoRnZnS2hSQTZENmgyc1V1ai9CdXRmYURidk10djBsT3gvK1ZKT3Ji?=
 =?utf-8?B?WnZyenFzczF5RnJzM3k5OXhIdkhuWVJKLzhxenpKLzBxVThOU2VTbW1hOVdC?=
 =?utf-8?B?c1BtZ1c0ZmpMTTNHaWpPcjRLMmx4cUZ3c3Zvd3dKaGxRbXlEdmtpdnJTM0xr?=
 =?utf-8?B?UjY5Q3J6TG15d3BzbGxSOW9XWHFpN1JEcnE0U2hVNDY1Yi9Ta2hYMFRlNTcr?=
 =?utf-8?B?Sk4vNXRvOHlTaC9ja1lZYjR5cEVjMVc3S0pKNnVqMER5K1pudmYzdlA2ZTha?=
 =?utf-8?B?VzA0VG5iT3Avc0dHZlJReUZUNVJQVE9mdHliMlVZUFVESUdCY1R2SFhhbjBH?=
 =?utf-8?B?R3pDdEdUWWRoRVRsd0N0c0YyRjRNdjZCdnhnem4xZHZSMXNLREFwUWNqaDhI?=
 =?utf-8?B?WlROUGxOSmJQcGdKVmNpTWQ1QlBSUE5hSzdYZlp2R3FJTDBJOTJJZUdFTmZY?=
 =?utf-8?B?NUtqWTlMeTVpSzMvWWVIb3RBaUJuNFcvOVdRUjdRdWhtTXAyQlZCZzVYVCtK?=
 =?utf-8?B?ZEs0eUlMcTdZa29VU2cydlcwSm1XbDlSNHU1OVMxREpGL0lteDlQd1QvV0ZI?=
 =?utf-8?B?VzYrWWthR1YrR0QwYzdXeGFLOUIxYXJsUkozQUxiV1NiVm1NNDRRaHNPejdV?=
 =?utf-8?B?dE94bDRrQkkxZFFxOUF5eXpGd3JBcWZISFk3MXJNVUQxaDJmTDF4RkJnc1hp?=
 =?utf-8?B?aVBLenE0Mm9QSVljd0xRSkVBWVZhajVaYjcyd1ZkVkloNWFxVjVYcXJPWWJP?=
 =?utf-8?Q?uUDUpFkQhg7v1hMcUupcRVpHF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 735d53da-b944-447a-61e6-08dde4477a32
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 02:23:00.2369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28Cet4IIJs8VCH/EEY2qEh82/tT0dbWxooUetjcngwqaFODVflmtnEH6TPVYMmi31lTgOlxrDiZDtq2VrIOtfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8020

On 8/25/25 5:17 AM, Alexandre Courbot wrote:
>> +        /// Convert a raw 24-bit class code value to a `Class`.
>> +        impl From<u32> for Class {
>> +            fn from(value: u32) -> Self {
>> +                match value {
>> +                    $(x if x == Self::$variant.0 => Self::$variant,)+
>> +                    _ => Self::UNKNOWN,
>> +                }
>> +            }
> 
> Should we normalize `value` to 24 bits (i.e. call `to_24bit_class`)
> before doing the match? The constants we compare against are all
> normalized, but if we pass a 16-bit class to this method the result will
> be `UNKNOWN`, unless I missed something.
> 
> Being able to store a class as either a 16-bit or 24-bit representation
> in the same type also opens the door to bugs, which we can avoid if we
> always normalize to 24-bit and make the class/subclass representation
> accessible through a convenience method only.

It's constrained by the PCI ID patterns, and should only be used in
order to get values from the C bindings, actually.

> 
>> +        }
>> +    };
>> +}
>> +
>> +/// Once constructed, a `Class` contains a valid PCI Class code.
>> +impl Class {
>> +    /// Create a new Class from a raw 24-bit class code.
>> +    pub fn new(class_code: u32) -> Self {
>> +        Self::from(class_code)
>> +    }
> 
> Do we need a `new` method when the `From` implementation does exactly
> the same thing and has the same signature?
> 

Looks like I'll remove the From, and only provide new, based on the other
thread.

thanks,
-- 
John Hubbard


