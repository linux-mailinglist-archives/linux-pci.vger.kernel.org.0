Return-Path: <linux-pci+bounces-27021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BBAAA411C
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 04:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318C24A0CED
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 02:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153C4288D6;
	Wed, 30 Apr 2025 02:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dfchNXK6"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BCC2111;
	Wed, 30 Apr 2025 02:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745981173; cv=fail; b=o4tTCjzDJe+YYVnIMAVUCTyFHlFsA9wbzJA7lEuy8sv3qal8+6czSaxL6dM5tGWdq0ADKhZkBAuXuMVy/PaJajZFMlDSirxukzWIAFQh+of5vV/2ppdLG6pSEMTr2yEgPmp6tCu0uBV43BBjZc7gnA9c+cIRMIJpv7KsMpGy4/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745981173; c=relaxed/simple;
	bh=TOuZJmorADNCsBsaJCrymLM8Y7/IRZkErt4EDao8ARU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=NGgQpGKG5ubs0KZtzddQBUPtbP4i7ZjMbpajLoCYb4QbVj0kpC3IKH90Y+A0YWZa3G0GRJe/pStHXJHQ96a8ZhpuxD8FAsgsAVdBQdtJTh3lnMnDEQX4u7+uCmvnHNkRBSv09ZC/g0lJ1ZJ9KnU1+LwRgJmzrnYvMOY1h/rljLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dfchNXK6; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4qhnz4/GR3RCamVlJtFHpdG7MYq8KAVSYiN0yeXgSOnIutTnB8xiiezwB1A/LWkNUJaUQ7Kmy9pzvzl3TcVfiKpvKSxPU3cfIKe8tptnVBYDuUc2JvrEn/HElOpYtXN6XihoJhqml0s3ehdKIQlWit+JAQ9ciWAfOp+W46mHb1ZdEf4P18PaNrSWt6xQNWJKPnl6VoFVtKjMOYKMLz+mmGY2YqIaJrKoQ4ygD6Rb08L/DNyya+RxZfYlqpqKCVDs5PrQVwSAAX5IfJbiUSOfyg9p2cgcIngPNdXsFcXYvTlu53mTSbxOqNd27IC57e3HA8Bkl1STkjv15RfoTMoyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOuZJmorADNCsBsaJCrymLM8Y7/IRZkErt4EDao8ARU=;
 b=UFb21uH265zOvMqBtu6HgeRGiKhmsIoX7cgFT8dRmcGhbZpX+kjc54q41WQ1tfqgupyWP1cy0daUuzLL4XxDRMHW/1RbIsNNc7AgqaMvhLTnkhv7zSIo8gUUrkVuBs6Vuz5mrFQAyEQ9fTdQR7HCqjkuBlISA9aYszWQl//b3/R2EfE5/pBJgTAUUO6eVz2Il8DYt6lDKgYGwKY88WeLN8xvAid8Kn+QlJGwuE9y5UWHlIBePrbsekv6ICdrMhMA3NqbRLB8TZPAkpM/K9+c/akrclrVnaLUKgeM8vbHJS2/e/eWgvU5L8GJm861HNwrTrZDQlQ6Z6ZRS+GQwURuWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOuZJmorADNCsBsaJCrymLM8Y7/IRZkErt4EDao8ARU=;
 b=dfchNXK6Bi4pSQ+T99MIBMS3rh2Ao8o91szM2qgjV7qCdw71bJTdQmzYllgNN4sodZ3xLcL0AFytTkXJqB4ofjZU7mtrOwhyYhYMKUBGEIR4oleygUV8sZIary2XLX92x0sWaHjBGVunnlN/eEvxLm7HnDtF+eCUOLyzOVJXN8lIqHZtBPvadG4QgCLZ4G7hNq5tbQTayKD2MUDG5ctT8tkVrcBYew3L/dbXoHKDa+eqI6WRUdIGRJ2Bwts/2mmoaYM10fdSGYCeM0pb6EpxmfOj/XWlCmASsSyOgSLdnrC2PgDjo5w0S1ttxrB8MH/Mr2gB013w0ZuyqXvmpZikBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB7616.namprd12.prod.outlook.com (2603:10b6:208:427::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 02:46:07 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 02:46:07 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Apr 2025 11:46:04 +0900
Message-Id: <D9JMO1USPIAB.3TBU959NO7P9M@nvidia.com>
Cc: <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Devres optimization with bound devices
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <zhiw@nvidia.com>, <cjia@nvidia.com>, <jhubbard@nvidia.com>,
 <bskeggs@nvidia.com>, <acurrid@nvidia.com>, <joelagnelf@nvidia.com>,
 <ttabi@nvidia.com>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <benno.lossin@proton.me>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250428140137.468709-1-dakr@kernel.org>
In-Reply-To: <20250428140137.468709-1-dakr@kernel.org>
X-ClientProxiedBy: TYCPR01CA0063.jpnprd01.prod.outlook.com
 (2603:1096:405:2::27) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: 04bf9ca3-b95b-4044-6866-08dd8791281d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkY3c1psRllHSDNrTUtmODU2K2hDU0c3bVZpWDNQb3Q0Q3plR2o1akhidEtD?=
 =?utf-8?B?L0ptbExLd05qdkRzeWc5VFFrTCt3Vmg0TTlRZS9SS1paNW1CakwvOTlOMXVK?=
 =?utf-8?B?eG02RzhMeG9GaUs0aUpMUzYzbUZtYnpadDdCZmRnTnQ0OGN3ODVETkJ0bUtv?=
 =?utf-8?B?Z3lwRDRVVzYwY01JSzBSVkhGZUpMZC9wUjYyMGVDdWZsSW9pODYrMWJKY1F0?=
 =?utf-8?B?VTFLNTJhWGZqZ1d5RmMxRFdNdkFOaHkxRjU5WHVqa0NZNTVvTDJmRi9NYnBE?=
 =?utf-8?B?bE95eEo0d21VVkNXM2orV1NUYVBMcmlPbzR2ZUF6akY3VWVMbkhPVXpKaU1B?=
 =?utf-8?B?SmVMb3NjQlRhVU5KY2h6QXhSdXRRcldZTVE3QXFzMkxOZnlyMW1zYVZKbXhl?=
 =?utf-8?B?bjJPN0VERjRWc05QNEQ1SHZ4NlUrbjJ1dVYxQU5PUUFDYXkrbXBwanh3RlR2?=
 =?utf-8?B?U3crVkZYWERWRnhNdm9DV0Y1REVXd0V0WGxsNUR5cFBjTnF4RWphRFFISnFx?=
 =?utf-8?B?TUt3OXQ2bXFGQWswcUlNbUo3Q2c4aUpmb01nQVcrUVdBeis2b3NlTGFPUURx?=
 =?utf-8?B?MlA5RGwvZUtha2VzVm55cjBxWVJlNHplK2Uxc2lnOUNnK1RheTF3TllObFd3?=
 =?utf-8?B?UUdneTBEZURFYkdianU2WFM4R1puSkdPeU9NczMvL0N0c1BWNDFjUWxudStk?=
 =?utf-8?B?M0NyTzlhTGxQR0QrQ3BkMmxEUmdvK1gzRWdTeXpPRlVhUEJRMktBTVFUeWhv?=
 =?utf-8?B?aFE5VmtiK3RITE84Vjl4MkgvVHd6OE1BcVVQblV2TW01cit0b1dSSFNHL0tt?=
 =?utf-8?B?VWcySXdDeit5NnVMczdPTzVaL2lRaDdsRDRicTVQbU02S2VSV3BiQ1NMYXdZ?=
 =?utf-8?B?TUk3YlhPVmFTUzhUbWJTeXUxZkR6cmkrOHdNeDVGcnZZclNLVzYxNUlEYmwx?=
 =?utf-8?B?eExJUnRxd1Mramt2dDEzODliRnRlS3dvL3VmOXp4YTlEWHgrWENNa0NCL2ZC?=
 =?utf-8?B?Uk9xS3lCN3FrV0Zmd1BOaEprTnlzY2ZEYW16L2pQQm1tM3JwL1E3dGVUUExa?=
 =?utf-8?B?c2JwK0lpUUN3TU9UUXd3eVNIdUN5cmVnNW5oMXBUeXZCUEJLR2YrSVpFT2Zy?=
 =?utf-8?B?Yjg3Q3h3QnhaVEoySVc2YVdWNld4a1JSVUFzVXdUUWVLblkvenZnK0xkZmJ4?=
 =?utf-8?B?QWFldmpNN25BQ2VYZUJRdDFRbUp3V1p4cjV2NzU5T1JEbkY1UlFsbnhJSkZZ?=
 =?utf-8?B?djk1cGNFWlhlWXJZbW42YSt0TWdFR1N1MFBoQWFHRnFFZ2hPbVRKbnlDNDhm?=
 =?utf-8?B?Mzk4Mk4vZlc4ZXRGUU9UcWF1TysxeFNtS001alNPbWNtQXZGVklKNXA2V2ZC?=
 =?utf-8?B?Nk44TUF2bFlEOXZjeTd1VldibjNURllOeUg5ME1jVUpaMDZUb2NTTitZTkVs?=
 =?utf-8?B?cDlUUzlZcHpnOXJQUDJPaHFjZjZNRDBsOFV1TVh5dnRRZVU2ZFF0RDc1K0JE?=
 =?utf-8?B?eEZDWGFFV0t4MzhMdHFDcnAxa2JpNFNUbmphdUlrMlUyNW5JTU50bFFuREZH?=
 =?utf-8?B?NXlFTmh0bU9zR3pnR3IrUVNReElTdG9oV0pmQTRCRldqZFA1UXF5RC9KdUI1?=
 =?utf-8?B?UWlxVXdWUGNUVEFiQTRYbDNtZktoRXNzSThzYW1rYlM4T2pqUTI3VVpBQTN4?=
 =?utf-8?B?MUJDYXZCUXRRZE9CcFMxbU95QnpSQ2dlSTBKQzZCc00xRkErVWhuUTErNGJR?=
 =?utf-8?B?cmk1QjNJbkcxVWM0MmFTL3J4d1dUaUU1dDJwdFA0Q2xrYXI3d3ZwOS9XN2tL?=
 =?utf-8?B?d2g0bEltWnBwZ2ZvREkxbnBKRzVwTURuaXJWcGNQUmdDZm1Oa0FPMzNGOWsz?=
 =?utf-8?B?cllpOEFmcEdKZU5nNG9uSlVYakFSdFJLN0oxZ3hJTHNUU2JjTGduYVNCUVBC?=
 =?utf-8?B?NStaQWIycUdIQmI5RExQbXlkNVFPYTRJV3Y0b3l2aUxvVThRZ0RUQU9hakp0?=
 =?utf-8?B?S250eWkwbThnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1U5b0hraDZaWERGMnFEVWVnRnBWbmhRa0paL2htcVlwWGlhaVN4M2xqUTdL?=
 =?utf-8?B?VWFUV0xLQXRYUG9SdWdBVEFrYTBTclVTRVFTcXEwY2MvZTYxZjFkZXEyR2dV?=
 =?utf-8?B?L3Zqc0VIMVQ4QkZaWW9YdDBLMmtNd2NiaDRFaVFpNzFYOHFkMGRuREZjMnEw?=
 =?utf-8?B?NCtoMU1zTkJ4bkVFeG10T2l4MHViV3Fpam80Z0JtL0JPc2tsaGJuZVlVZnNm?=
 =?utf-8?B?dFZLb1pJTTBXaEtaeEp3ZjdORnIrWlcra2VwQi9OWENzRklzZjRUY0NGTThD?=
 =?utf-8?B?Q1FkbHk3MmFYMUFxRFhCRjRVQUJCaG8wOGVia3FBdGlSdWtIN0dSbFJSNmlC?=
 =?utf-8?B?MTRCUm1QaDlVd0FtVFA2OEZMdHVRZTF4bzNNWlhRVWg3c1NpMzdNSm5NYzh4?=
 =?utf-8?B?ekdNaXNwYkNPR1JBSkFFUm05Um51a2IrZmxNb1d1V2RYMml6K0Q2R1pCM0c0?=
 =?utf-8?B?QXRES0RmUk1wMkEreXlxMmRCeTl2VmdNcEhLSUxLZXBmbDM3b0MyUnFvenhS?=
 =?utf-8?B?K0JRMXhoRGx3TnF3MGhnMURDSXo4a1g1bkU1Um5YNkdROUF1R1dDRTB3eXov?=
 =?utf-8?B?SHYwNG9sSkQzY1JRdXFyOUptbGxTZkUzM1FEdWx3aTFxN0FZYVJOSEVoSU42?=
 =?utf-8?B?UmNWb1VuVy8xYVpJYVQ3V3hvRGhhZWJuKzd3RHBBdlZHV0ZpRm9Ja0RHNTJp?=
 =?utf-8?B?YWoxS0tOdFN1eHRNS3Z5Y3Rid1RISjhxWDJGVkZSRnh1Rm50ZVF0Z0V1Rklt?=
 =?utf-8?B?RXhlM2xBcVRVOTVPMmxCcGdtcHpOR3FFeVVidGdXQ1R2aXBiVG4wa3MwcHFX?=
 =?utf-8?B?anBwWXlHelhuMEJGSThJUjlEbGZnVHVRZUhBbnN0K3hBenhIZTZickIrbXBY?=
 =?utf-8?B?b2ZJRUJNUGxYU0NPeXdmN0tKTkhkWHloZS83TFZhajhwQ2J3ck5CWXEwN1BD?=
 =?utf-8?B?MnYzZVZaTWdIcFVmMnlhUENUY0NZRmNxMTM0Y1IvSEhWVG5Vc21ucUJMeEpk?=
 =?utf-8?B?bEFQTlhoTkttNnNSaTJTeS9BQWhVODhPajhBS0hkOWN6UWo2Q1l0T0d6dXF1?=
 =?utf-8?B?b1lsbEo5elJhL3E4NWZWRktWRzBqcVA4bzEwWmFTNC9aOU9sUWMzcGpaNklW?=
 =?utf-8?B?NldXZkoxRnBpNnkvbTFNbEpSK1cyUG8wemhWL0k2NU9yZ3VRNVlJWmNxS084?=
 =?utf-8?B?M1pmSFRxMG9vL09XN0JpY1ZwYk1jcC8rWEtpYjZWT1hPQVZPRmdKRm9NTlRJ?=
 =?utf-8?B?Nmw0bDJXcHNEVkovbW5iZnpIcmxCUzc2ZGp2Wjc1LzU4TFdWOERjYUs3NWFS?=
 =?utf-8?B?VUNkKzNKRkc3ZFgzYWhDL25VdSs2cVRMRi9OMzRQcmJTd1ZmMnBhNlZpT2U4?=
 =?utf-8?B?c3lnZDlNeGJMY0t3bDR0RkcyNjlLRzRFclg1QW83TnZNdGVQa1RmUTZlN1VY?=
 =?utf-8?B?SzhqUitHTGg4Q1lrbTExQUR3UWYzTnQzd2U2S3llK2NnN3UwQ1hRWFBCekYw?=
 =?utf-8?B?VFdVekxhRkVvMkZiN3pSd3FyTituTzhNemtLWDcxM0xuTXNxdTdlYytWZlRS?=
 =?utf-8?B?NjIzRmg1SG9MK3lScWpyK0N5N1hIZTdCTnI5ZndmbFlEZGVpYkRzMjhsT2FD?=
 =?utf-8?B?SStpd3owdWFjZGVRL3Y4VDhjY21Fei9lTloyS2FzVDVDMlJGMEFJNkYwZzRP?=
 =?utf-8?B?Ump4S0tUdkJxWFQwWncvcEVYQmxaSDVkeGg2RUJkVnFUZnVXRWtBSWg5ZVBs?=
 =?utf-8?B?RXJTU2pDRDZHWGs0RmFoQmhhT09USEdDS1J5bGZPUTR6ME9xbkw1dlFkVDhF?=
 =?utf-8?B?bzRBZHZ4UkZscFVSY0dwL21nRkZpM1NIT2p6SElBUk9hNDg2U2dZMm1IRDZB?=
 =?utf-8?B?TWtxN3Q3eGErRENtYmFEME5QNml3VVYva1ZuNGUyaEoxeDJSL0FBSVZBbUlu?=
 =?utf-8?B?ZmVOUUgvbzd1L2cvbmtvVVJmNmVpYk9HSi92VVloMkpXbjhLdWw3ampUVk8r?=
 =?utf-8?B?dXBSc3FxM2VPUDBEcGE3ZVpZNjh0OTY3eWNEM3NFdEVPNUhINVUyVVZ1WGVa?=
 =?utf-8?B?QkRMVktTSHR4L3NtY1J0OEZSR0JJWDFMaU1SbmtzSGU0amRhejFlT1ZGNTZ0?=
 =?utf-8?B?emRMaGhzcitIZkhVaXhZT05jUXpBYW8zT1ZGUytzUWtPTnUzL0djY2ZOcnpv?=
 =?utf-8?Q?I5NXt0EnIdrK3DXovh/yr3ffWY3dAoV/QBVWmrKYVAlR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04bf9ca3-b95b-4044-6866-08dd8791281d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 02:46:07.3554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhsId6DQg81o0zJpi0IvIwla9gH7EEG8Dx7NazE14P/lyNpeDhuXF8HBBOEjMnObT3/qAoIy13TGjub+ke141w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7616

On Mon Apr 28, 2025 at 11:00 PM JST, Danilo Krummrich wrote:
> This patch series implements a direct accessor for the data stored within
> a Devres container for cases where we can prove that we own a reference
> to a Device<Bound> (i.e. a bound device) of the same device that was used
> to create the corresponding Devres container.
>
> Usually, when accessing the data stored within a Devres container, it is
> not clear whether the data has been revoked already due to the device
> being unbound and, hence, we have to try whether the access is possible
> and subsequently keep holding the RCU read lock for the duration of the
> access.
>
> However, when we can prove that we hold a reference to Device<Bound>
> matching the device the Devres container has been created with, we can
> guarantee that the device is not unbound for the duration of the
> lifetime of the Device<Bound> reference and, hence, it is not possible
> for the data within the Devres container to be revoked.
>
> Therefore, in this case, we can bypass the atomic check and the RCU read
> lock, which is a great optimization and simplification for drivers.

Thanks, this removes one of my pain points with the way revocable
resources were accessed and will allow to write drivers in a much more
natural way.

FWIW, the series

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

