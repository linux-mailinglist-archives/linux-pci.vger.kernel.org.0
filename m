Return-Path: <linux-pci+bounces-26869-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F6EA9E345
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 15:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B86A23B56F0
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 13:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ABB610D;
	Sun, 27 Apr 2025 13:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c55mGvPu"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215DB143C5D;
	Sun, 27 Apr 2025 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745759836; cv=fail; b=QUd0qBUaOIkoAjIrny2z6wxCjiaT02xpD8NbHxmfoFiRW6WnWgu0P/r6BoUlxIzpnab91wZeir/ATG5JTW1snDwz7Gjip4k8T5eFg2QwAri9WzMIZj8+nFsQddnvD89K5EbqUv9LkBtKXGwa2SyKVLkj4q8mP0zAsdvFRc+dQAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745759836; c=relaxed/simple;
	bh=oQwb0qJbbChiteddClqw8Ux+WqmStMip1xYk76v1/UI=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=dIYver/1KYMdbREQHPJzYqJXyzOzBvfDTyDkXNunxGZBii7PGB9GIr5gT7erxjhGVPHKf9eMZXPTEqirYHk3jNXHLGeovFBh9xAYcTowUVVrVAdx/2z7z9qnkGgMk3ws6WDBimadkRc/LZpkgJEaHsJHzXdo4/4uh6kU7RsV5aA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c55mGvPu; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JyIb3yG0ul0swfcN65oYNOBee9gQpU6fSbk2idbxIGLRO7xQZ75puqXpJlnOqF/Oa7eyNA8gShJkT8K1D0AhsTWJOu6dmcC04d9UIqdCCjw7GlZ44jpDjowQLBvz/yCIT652AEA6wAwUiStCntH+S80C2AdgJU1qTYySNWFDYy8jYtsbTQ0WkU/VydeFWJCkWF2VO8kklgUxhROAOrpgFmTC3Kmc85Fc+hjkHne+gvoRnK8h6XM+D9NpZFXn36X2aBTXC7tvHj5olB6jQ17B8G//A17v5OPmkdk6/X3CNhaO8Tppc2arAG3t2GSPn2MkrnPwsuAeQ2ISCiuhWncTgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+nd/2U0HZ+rn7s3tdos3gE8b9VJFjg7j1UxykeEZ2s=;
 b=QKvfS7pOQ8vW9MxEw/AKgLOaCsZtCTbZu0cD3R1Z988UGbACp5cAG5UGcIjjaVeVtPyPh1UmrLbTS/Yktqw1a+RwwtS9X/K9GMzCEcd7+0PokH1l5q0yaq67GnFsEe+mO0hbKQh7YUksjxnH0iZCjqGADEkxOUiAXoFoV5nRthjzPyUkA2lnr02t1iHHqUbl5mGTn6uFOKcB/tZzsI21GdW2ZFcEdP3ynMRwETy8PA5dEFcF/Z4MSiXFb49+QDtPvxTgzlH7Xr3SXPW3SLQj/kw0YjFykVCc31/7kPYu5hOe1rWR3/fhFmSbx+Zx5lCNZ8t2WAPuILVj1txZ66wGrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+nd/2U0HZ+rn7s3tdos3gE8b9VJFjg7j1UxykeEZ2s=;
 b=c55mGvPu65tCueuTFwRyFn+0epJTZxnqWcN/W7/P+J669Pb7eOF8cKd9yg0vI2fc0nkMhXcIjW9hweac0zLmwgDj3D/nvtr3H0kRRqc4XM/IpvByLJ3nIy45ltJOBbN/FrCowT4acHhOMRKRdWM7grRH9fvNYPcwNAhmhdo4QDEvjihfANyl7v4UJfJt60jGrLekM/VukY4ddVRGJkYONAmjr8UGO4HM+++sHvHKxDsaflm/gFpyzZOB/ujfRCWDykdABalv1V5kyew0bxUfyfYTcO5NBXnMOOqvfk04cqBJrJiSdTkHgL++lIQrv2oKWoI0NXtvWNnCXJbYrvx62g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB7640.namprd12.prod.outlook.com (2603:10b6:208:424::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Sun, 27 Apr
 2025 13:15:31 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8678.025; Sun, 27 Apr 2025
 13:15:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 27 Apr 2025 22:15:17 +0900
Message-Id: <D9HG66ONN8E4.1DK7SLRLD0YJZ@nvidia.com>
Subject: Re: [PATCH 2/3] rust: devres: implement Devres::access_with()
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <zhiw@nvidia.com>, <cjia@nvidia.com>, <jhubbard@nvidia.com>,
 <bskeggs@nvidia.com>, <acurrid@nvidia.com>, <joelagnelf@nvidia.com>,
 <ttabi@nvidia.com>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <benno.lossin@proton.me>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>
Cc: <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250426133254.61383-1-dakr@kernel.org>
 <20250426133254.61383-3-dakr@kernel.org>
In-Reply-To: <20250426133254.61383-3-dakr@kernel.org>
X-ClientProxiedBy: TYCPR01CA0061.jpnprd01.prod.outlook.com
 (2603:1096:405:2::25) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB7640:EE_
X-MS-Office365-Filtering-Correlation-Id: c3655d66-c4f9-49dd-f8e6-08dd858d91ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|1800799024|7416014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1BteHRtc3BTK1h1SzVwT2lLVXBNQ0djaUp6eFBwRUVMWEpPZlE4eVdEOVEz?=
 =?utf-8?B?djltM1hxY3NZMVcwNUxDeXZxbG1PbnJpVjMxLys2WEY3MXRlTE5WZFM4NTcx?=
 =?utf-8?B?d205N0ZldXZQcnltRXY4U1dNWWQxL3VCYXNKTlBtMVNLa0wzNTZkdzZmdWRL?=
 =?utf-8?B?QmVxSEVQRXhJZDJxenhrWDRRZkNwak8zWUg5QnBtUEpWcnNQZ2VGN0pjVGpZ?=
 =?utf-8?B?T3VDRitrZU01L0ppK1RWM0hnSzV1VFJNSWJ5TmxDQ09tWjdqZ3ZxcVJaUk1o?=
 =?utf-8?B?aSt4Z242b1ZHdWFkdk1PUEV5RGRKVmtESFBlcEJhZ3h6Z1grTlRiL2VXVkEv?=
 =?utf-8?B?Y0twNUhxeWFYRFI3TEpueElIVGYrTlIxNGluQk9zOWp6MUF6YThBeWg4Y05V?=
 =?utf-8?B?VmNtbUw1VUNEVkhpQ1lYZll5Nk9NNW9DRkk2by9ScnlROUFHMGkzeSs2V29C?=
 =?utf-8?B?dlJpd2h0WE5maXZEaElaY0ZsYUxYSW9lWWV0bXowR1g3SDF4SjVOZlZudlB3?=
 =?utf-8?B?ci9BQ3pVY2lNU0x0aUk5L054c2lZN2VIZjhkOFFZZUdzQVJ3QVI0ZlZJUUVp?=
 =?utf-8?B?V1IvNEQ0NmNSOHVhRFFIMHJ2dVJ1NGJubXVJT3RoYU45VFlnUkFwdkdIMmVv?=
 =?utf-8?B?ZTVXMFc5SEVSajI2M2RXenBUUTRrTlVKc3pqazFDcmtWOGw2cW1BQitIK3J2?=
 =?utf-8?B?TXhqYUxvMVJ5QkozN2taK0hsdzJEUDhkS1d0STUvNmIrY25YTGtFM3JUVGZS?=
 =?utf-8?B?aEpxcEViZkorNUVwcHFzOHk1eFc3UGppdVJ6clB0QS9WazN0eHNKckNwVlU4?=
 =?utf-8?B?ZUszeTZieDhHV2cwZ1RYcjBsekFJY3kzQ3ZwVnlTSGkwTkttVjJyRmdIU3ZI?=
 =?utf-8?B?V0kwQldKMTZzN2xCMW5qNmxHTGIzY2JLRUVkQWQvbkNEb0tlMWJXcHlVdFRk?=
 =?utf-8?B?bVovTUtDbmx0OVBFVkZQQ0t0Q2FsZU1PQmQ5WGl5ajJJRXdUNGZvUEUrZEYw?=
 =?utf-8?B?OGpYaStsYmR0RmI4MGU5WXhzVG9HOFJIbC9Tdms1WW1NTFB3OVA4WExaRDJZ?=
 =?utf-8?B?QTdjeG16OGlSdThmZitIaWxUMXBuR1NJVHFUaGMvRWJBa09vQTJEYnU0dHVk?=
 =?utf-8?B?Zkh4Yi9yNUZOMzBnZDBtazVocHN5WVNXNEIwWVhPbCtGQWVsVHdaSGpGbjB4?=
 =?utf-8?B?NXM0bGlQMjRCNHM0ZFp0YW9ya0RPNkNxYmZPSzRUSFlRcEtCMjdyQzc0cERv?=
 =?utf-8?B?NUJyK256Zlk4RzJTQ0M4WE0xbEQyUjJFbFJ1RVZLOEpFM3RUVnQ3a2VtbFlm?=
 =?utf-8?B?cEpBb0RtMmJ6WGtBRkFVOU5YL3lNc2RoUDJDQkFlRldLYjdZNUlYbU4zeDE3?=
 =?utf-8?B?OFZHREdTSUZsaENrOWhDazdFTGJFV1l2WjNLTmlwT3k5RFE2NnpYTHIxcTBD?=
 =?utf-8?B?Ym5BZlNFL0xmY0FtMWhDUStmcWl0bmxpMmFTc2oyajdzR1dUSWpYZWI4ZU1H?=
 =?utf-8?B?c3Jzek5sRXZTclhSQlFWV0JIVlcwTTM1cTc2TDYycVU2endOeGwyWE03Nk8v?=
 =?utf-8?B?Zmo1cFEveDRUMjM4ZmdXUjhNcml5SlBLSTZ4WVpXUkxZZUI0SkpsanJ1RmxH?=
 =?utf-8?B?cG5NYkUxY3JOd3QyQW03azBXS3p0b3o4NCtsMXpHNjJEOEMrSjBXNEl0SWYw?=
 =?utf-8?B?Y2s2Z3FFOGRsNU1IOEx3T0Y2aGY3Rkx3NTdCaEpETUQ2bWFzMjlOZUJPTkdz?=
 =?utf-8?B?MkVKOHJIVHE3d3k1NlRFZE1XMzh0cllpcVVPV1FqaHlTbmpQdnlBQ3dhSEtR?=
 =?utf-8?B?RCszYmd1dlJUamhocDJVMWwxUitPcjVtUXZ1eGliOWxxbHBXSWxLRkRJVzJU?=
 =?utf-8?B?RjdEZitDNjdNQ1dkOU1MamMxWVVzUmxEWC8yS05HSC9xQ2RncU5VUXYvdDhs?=
 =?utf-8?B?emVDNTNKeGpxQzRTWXdIaG44amF6bXA4S1draTVYR2NaWHRNcDM1QnAxWmlR?=
 =?utf-8?B?VWowV0VnV0l3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(7416014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Um0zQUk0NG9hVzRyUzlDYlQyVGlsaE9teVJOQXZLMGk1T2tLbTFkOGlNSjNE?=
 =?utf-8?B?K2FTaWIzRmxhcnhLRTJVVmVqTmVqL2U2Vm4zbmdqZHRqVFZmT1kvTWRsaHVh?=
 =?utf-8?B?NUlrUGNOM2pHbDIzVUU1MmhtQVJQb3U2MGNwdmRkZVNHNll0eTBUY1VmcG01?=
 =?utf-8?B?bzJrdDlWUVhUK3RuQ1d6d3ZrUXVnUGxUdjF4U24rcjNSV0lzZXVwcUZRbUEz?=
 =?utf-8?B?TjB5ZXBYdmJXUFpxOGNzcnM1UjJLNTB4czJaRFZIWFpucXFQc3FlN1VTYTR6?=
 =?utf-8?B?MVpUS29KWHNvTENKZkFSWFJBRVRjOGwzcUQyR3loY2FaTWw2MWx2aHNIcTVL?=
 =?utf-8?B?WDJ4d2dZdzYvTlBaTWw5N3hCdklHNlFUWmRTa1o0WVZCVGExVUR2WEdUejRy?=
 =?utf-8?B?QkFQc3NXdUNCOGRHVzRGTVBwYWV5VFFkMzBUL05mK0ZHMm1vdkZCVjcwc2pi?=
 =?utf-8?B?TXNFMTZ1TEplZng4a0xQTk9wK0ROek9qOHBLZnZua0JYWTNaNDdtWnMyVFo1?=
 =?utf-8?B?UXh0RkEzOEpDa2VDRkRXV3ZiNGd4S3hFN3NJYWR4OFNWQ3pZSHVLcjdUWHo5?=
 =?utf-8?B?TnhUMDV4aGJzQThrMDNpZStXeTV5dXJuL2hPQUtkVURkbUxPeUZPc29xaWZv?=
 =?utf-8?B?MnhpaHFXSW9pYWU2bjV2aVVuSmVWQU9vT2JQekYydlQ1aVl4ODN3ODhaeWVs?=
 =?utf-8?B?RmVGaEJ0MXBZSTV4bXlMalR5d3VaUVJ3NTdZSHhIdkpxTXlaWUQrbFZXdi9L?=
 =?utf-8?B?cDV2NzN3b1R0c2NoN3lhTHpmRGZlN2x6U09PRjlXdUtNUWtDNi9aZmY2UWFr?=
 =?utf-8?B?TzdRUnNiOWYzKzBLUCtpVW9kSlBnMXA5ZkplV1hQejRQbDlEVnI3eXF3UnVZ?=
 =?utf-8?B?STNyZzMvc2RhcGNTdE5jN3BRTHZIVVZFU0MrNkRtbUNiRWhVdHRCV08yS3V3?=
 =?utf-8?B?L08vZThxc2huK2RJYXE0b0habTgzZ0dXZTZtcDVXVDArU3g5ZmF2bUVodm5a?=
 =?utf-8?B?cWd5ck00eml2UDl5dDZHTkh5U2REYS8yTVVyWVc5Y2VjK0hmVzNHTjZUekow?=
 =?utf-8?B?azhETCtoV1NuVmFabTJaQ0VyWXlITzB2ZUxtUlFhQkV2akE4ZHFzUk5BV2lh?=
 =?utf-8?B?UDEyWTBlcXNGMjU5VUVnaE5Ja3FUUHF0b01Qd3NqMDhlY2IvOS90OGFNbGo5?=
 =?utf-8?B?bUhITXBvbXFzN0MyUnV1MzlyWVdpb1RoR0VvMjRxRENtdEFZZm9kUFNRQmtK?=
 =?utf-8?B?NlNWRGNHcERMak5ualphZkFYeWxtV1MwM0hRM1JYN2FEK3VrOW9vNGlxN0d0?=
 =?utf-8?B?SElueWZlOHhoa0pJQ2szb1h3NFNOdWxWU1ZBNE5PUlI3OW9RSG9Pb3pFMXZ0?=
 =?utf-8?B?S2hsSXRzSFRVZmNXOE5EbmtXSnZsYWhSSVQ0WUxvajdJcmdpQnhRa0o3VTcr?=
 =?utf-8?B?anVCYkdNRkJHbzZpTWlaeDFFd01JaWNMTXpmcFdJaGxsRDRDSmo2LysvbnJu?=
 =?utf-8?B?ckFqdDByWVFyV01GMlpmaU0rOGxLaFdEL2k4Zlp2VTduWFZlQTNsYUtQZ2JP?=
 =?utf-8?B?TzB2VVFZYmlnbTdRUDFPOFFmVjkxaUNuMG9TcmNoNSt3UlhEM3preERhWVJW?=
 =?utf-8?B?UnFmdUVzTnFkWEZqRGFkZE9LRTNaVHJpSU81NHJZNWhDRm1ISkxXZzZoK2VW?=
 =?utf-8?B?QUwxamxicWFYdWdjcHR3SWZJTGNCSzF4L1BMWEI3MkMzcmpPdU0wU3NLa2Z5?=
 =?utf-8?B?QU4xYmNtQW5NUE5MSUlZVjJqSFNxSUNhd3hIeTNJSldNajM5cnpCSW1kNTZN?=
 =?utf-8?B?Q0IySEROclNIQ0hjOTBFclJYZ3hXTnFHUW1wVzV0Z2hYc3J3YUNCT2RnYmtB?=
 =?utf-8?B?Z0FVVS9BWkhYbTdFSG9Ic0VWZWtGN0p5K2lrVktod0paZHNwUjZ3OU14N05Z?=
 =?utf-8?B?dGpEak1VVjM4L0t5b3VXQnF5cXR4dlhuMUhUdWFYR3NiSHIzdEdPaDJJd3Vz?=
 =?utf-8?B?dGJVM0NIc3pYdjR6TVQ2R1Fyaml6bk9TNGpKZG9hZU1WKzM5R0hjNHF0OVg1?=
 =?utf-8?B?bzZWZm9BU0UyQXNNNzhFUE90VWsyMUxVL0RhZnllbkJreHphcDgrUXFSQklN?=
 =?utf-8?B?Z1VBZmVqR2taNUVtMFRKS0xYVDJtTXQ3MTArS0xSdFFvM3N3anU0QnJ2VDUw?=
 =?utf-8?Q?y9zdh42yifrOYFqvmndDoo+dvRazGsK/4nxqWiVPP6xW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3655d66-c4f9-49dd-f8e6-08dd858d91ef
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2025 13:15:24.5643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxQGZRjl1allqjmJ1ZEIUglK0vaOZcHS/S4tCMUrurt1p0muiq0kN8+KufyPIJQ0YS+hs3IE0SS/yaDQBuW0PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7640

On Sat Apr 26, 2025 at 10:30 PM JST, Danilo Krummrich wrote:
> Implement a direct accessor for the data stored within the Devres for
> cases where we can proof that we own a reference to a Device<Bound>
> (i.e. a bound device) of the same device that was used to create the
> corresponding Devres container.
>
> Usually, when accessing the data stored within a Devres container, it is
> not clear whether the data has been revoked already due to the device
> being unbound and, hence, we have to try whether the access is possible
> and subsequently keep holding the RCU read lock for the duration of the
> access.
>
> However, when we can proof that we hold a reference to Device<Bound>
> matching the device the Devres container has been created with, we can
> guarantee that the device is not unbound for the duration of the
> lifetime of the Device<Bound> reference and, hence, it is not possible
> for the data within the Devres container to be revoked.
>
> Therefore, in this case, we can bypass the atomic check and the RCU read
> lock, which is a great optimization and simplification for drivers.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/devres.rs | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index 1e58f5d22044..ec2cd9cdda8b 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -181,6 +181,41 @@ pub fn new_foreign_owned(dev: &Device<Bound>, data: =
T, flags: Flags) -> Result {
> =20
>          Ok(())
>      }
> +
> +    /// Obtain `&'a T`, bypassing the [`Revocable`].
> +    ///
> +    /// This method allows to directly obtain a `&'a T`, bypassing the [=
`Revocable`], by presenting
> +    /// a `&'a Device<Bound>` of the same [`Device`] this [`Devres`] ins=
tance has been created with.
> +    ///
> +    /// An error is returned if `dev` does not match the same [`Device`]=
 this [`Devres`] instance
> +    /// has been created with.
> +    ///
> +    /// # Example
> +    ///
> +    /// ```no_run
> +    /// # use kernel::{device::Core, devres::Devres, pci};
> +    ///
> +    /// fn from_core(dev: &pci::Device<Core>, devres: Devres<pci::Bar<0x=
4>>) -> Result<()> {
> +    ///     let bar =3D devres.access_with(dev.as_ref())?;
> +    ///
> +    ///     let _ =3D bar.read32(0x0);
> +    ///
> +    ///     // might_sleep()
> +    ///
> +    ///     bar.write32(0x42, 0x0);
> +    ///
> +    ///     Ok(())
> +    /// }
> +    pub fn access_with<'s, 'd: 's>(&'s self, dev: &'d Device<Bound>) -> =
Result<&'s T> {

Coming from `Revocable::try_access_with` (and the standard library in
general), the name of this method made me think that it would take a
closure to run while the resource is held. Maybe we should differenciate
the names a bit more? Maybe just `access` is fine, or
`access_with_device`?


