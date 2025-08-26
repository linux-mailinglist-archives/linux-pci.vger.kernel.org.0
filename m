Return-Path: <linux-pci+bounces-34695-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934D6B35189
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 04:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6471B244D56
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 02:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129B61F9F51;
	Tue, 26 Aug 2025 02:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sztxV9vb"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEA21C5D59;
	Tue, 26 Aug 2025 02:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756174853; cv=fail; b=hUqQLkJ/heeJWyUlhrlQkmURbYNuK5g+Kdt/5xTm/eJcIfSiS/20MQpzpA49w4v7bKSvw4veRaSaSLHXJats0Twrz69L6cYvzeCbkzxprLp0gxyZjivxnvo2WC9oh76Gkc43iehf/CdlVRnewo542GZh5+HnbBOZbIh4WxP0Mpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756174853; c=relaxed/simple;
	bh=VQ7JUs11Pyr9Y9R1GBKiAC9Q7PnOyPAa4UgWKoYdems=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gnE4clSVcGGVph6A/ZyMMqGPh1ZgEMTqmiFjnSgqwKIx3wnpTVQym9iRjtKTpUqN46DCXzQZ4cyW45N4RfUnXeTEAu+U/rAzBL21eCI34osSlliFHgQRMjGOiwi+VznEqpKoD4rEpw4CCwR+8E0q0bsX81yg671zDq0ZyoY7xCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sztxV9vb; arc=fail smtp.client-ip=40.107.96.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1N5wNd4CVmH0LYOcfIeeDpWobqEep2GDPjmQn/KmGMEUxUlKjQbWUOvmwA3rYcfryrbbj3Cfzi/F/jDT5XFdPQP6xctpjsBwX2Tj4tkGqRjyLG8TtRyZol+ZMZ9UegFaQYNH7pOOMyUMz0fvlRPrgcg6qKQCIF6H91WGGEIfbYS6svBSCvIHxdpGLFL8P7vvhrV/vMcg/NrM8xaHHyYtRM5hWX4uzV+VmWc7MSUnJ1nCgjbUYj1nnXz8Y2hOsYFM5WhS6cXZl+Vuj/BxsnmM9AhYw88g8V2JS7FmstZuKajyYVR5xxOsjrun3F4Ltf2XhamVwBloeyarQmC6LVPng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/NTwZjBrsIXUwX5Uq0zzaQwuzqvsDSfYmrAB3bwpQM=;
 b=yI0v8Dm8o+vimDNy6yrdgZCa6RJQFDTzQ5czdlg3/1+JToprndXu/3BfMmb3IoFrWIGeyX7TJ6qU0ZfCnEhiWfiMvtSe6z3ebEWXzh+86bcVmzkYZwCK1YbobUjhZLjwS4BZ0iAWwaAih5sD4t36OnZ4WO/3b7DcLHoCo8icGYcOCMrSGB4eiPJFCPYOg+nLrdoxDP/z2ZUU4VZP/BG8PFmHy41NrGadC8GhU32Pjj3X4oKtcbnC7QG5ET1irvEH25tK19a5IgpJIm0fun1pgj4XQY40WnHUk2xWOeMMHMQyrYnI8xSF0+yw9E3qQ2i1BxRYzrKueBFNv9wXigtaaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/NTwZjBrsIXUwX5Uq0zzaQwuzqvsDSfYmrAB3bwpQM=;
 b=sztxV9vbeil8zANHzrHKjLYR5wJBDBlaQ+nldXPoEDWILyZ2D+JCuiOuWo87iBKriIBcRQE99veiAJRtwgqesIAkHQmvOS1gUDaPXv8estycpneg7jQATZNLpimjGnOI8sj6TBQrDzYnSG97pkxrR6cUXEXdAnlR33rDa6ub1XgibDw/t4ciogaT5XLtpZmk1bI0l/vkMdy8VOeD/HN6h/rfK7+APMegduIPatecdu3VOslminXFMuQev3ME97KHQ9syb2AVF5xLwnlYNeavmz5ydLI3sJ2v+XxcTFIrlg3k4VDE0U7DZp8BmdtUy1fQ9QwVG8X+WcOGlk7m11WGuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by DS0PR12MB8020.namprd12.prod.outlook.com (2603:10b6:8:14f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Tue, 26 Aug
 2025 02:20:49 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9052.014; Tue, 26 Aug 2025
 02:20:49 +0000
Message-ID: <49e1b47c-a460-4dd1-8276-1e6e99231a7b@nvidia.com>
Date: Mon, 25 Aug 2025 19:20:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] rust: pci: provide access to PCI Vendor values
To: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>
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
 <20250822020354.357406-3-jhubbard@nvidia.com>
 <DCBIF83RP6G8.1B97Z24RQ0T24@nvidia.com>
 <DCBIPY9UJTT4.ETBXLTRGJWHO@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DCBIPY9UJTT4.ETBXLTRGJWHO@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0376.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::21) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|DS0PR12MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: 792b743b-35e1-41e9-4bff-08dde4472c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0NhM0tCeFVDV2ZDcGRsdXZPSk84bnB5YXJzdXR6eUtHKzZYT0s4MVVQNGVi?=
 =?utf-8?B?bU1tODJkNFJDUmFyTUlnWVkxVG5yMEhtLzVna0lYSWN1ekdGZjVTdVhvV1Va?=
 =?utf-8?B?SnUzckdSWE0yd3ZMWmxRU1RzWWRPZFZFVjZLZFlDa1JybzdpWk90ZEl1Z2pN?=
 =?utf-8?B?UlZFQnpzQlh5TVlQQVFpRHN1K0l1T1ZSdjJtY1VYMGlrVDlEQ1dhcTNhZUR3?=
 =?utf-8?B?bVk5aTkvMUpYTHdqQkRyR29oOXBzL3RXSDdVRHFLVnYwZWM3bENaUVZNOGRS?=
 =?utf-8?B?MXEvMWJYekErRW43bWZzVm5XbUFaUS92QldOZ0cyaHdsQXNLZXp5MVFrWmds?=
 =?utf-8?B?cFNJWVFiODh5MmpabSt3YXd3c09XdGZjOXp1MEFRR1ZnNnNuVitURDFuQlIv?=
 =?utf-8?B?VHc5Ui9rTWp2YnRZZ05rZnJMS1poUGRwdXk1K3BJYkpvQXRtUkJ5eUpYK010?=
 =?utf-8?B?NlFFNDIxcXA2TGFoeVZMYmhjMW52RlFuS1BHSVhyajJpUmhOV01RQm1DbjN2?=
 =?utf-8?B?aXh1UWNFOTd4KzBSSHhnZEhXVUJ3OVNod3NyOFBOMEJjZmg1dk5hb2x2MllQ?=
 =?utf-8?B?S0lPN3JhSUFvaHE3UHF2R05XcVVxTGtsTDdBeElkZGNtRjAvbk1YeDdQeFJr?=
 =?utf-8?B?NEtKcjliaWdqdWx1SEZGYzdRYWFzL1FKbVc1UlRVa2VLQzRUbkhhbXFvSVhP?=
 =?utf-8?B?NGIwTEFsN2t1dFJnd0dIMmozOGRjT3FYRFRkaFM4Z0txblh4M2RReTNNK29F?=
 =?utf-8?B?WXJ0NXlPcEwvVVJnS2oyNnJhR09wZWZRcGs0YjhVTUFMNGkxcUllcDJHVGxp?=
 =?utf-8?B?M0oybWVaRTBSc0gyUnhDa2xNMzVWZStITS90QXZxNExKb1ZISDB5cTZtUkRQ?=
 =?utf-8?B?MWRMTzJmcFAxSldzZlFpdjAxcm1tUXNYOFVTTXJpSmFPUnhWcjdXT2E0RmJw?=
 =?utf-8?B?S1paaWRVeGV0Zk5hbHpHbkRJNzltemFDSkF2ejl5WmtlZ0REd2NwQ3MzOTlW?=
 =?utf-8?B?MUtLTndvYUR1czhleXUyTFNpVUFiTWd3amtTaTNDOGh4WmowY0VpVUQwZHlm?=
 =?utf-8?B?UjVNaUV4SkpLOU1PK1JZQUh2b3dvUG1JamFCRU9EWGdNK0o0ZmZVWmZiS2Iw?=
 =?utf-8?B?NFU0aWxpeTl1L1ZQbzVTeG1tMDdvSVlFZldrVGdZRmRob1dGSThkcldld3cv?=
 =?utf-8?B?ZGxMdEMraDNqdGEyQWxES3BMdkpVSUxPbFMrempKUy94cVRtRks4ME1xTG9U?=
 =?utf-8?B?RFR4RkRnRXpwTkJ6TVBFUFZTM0ZteFlweTZ1eTZTTDJBeWNiTktEeHl1MTR4?=
 =?utf-8?B?cVU4ZWx5bzlLWTJWbko4dC9qMlJ0Y0o5YUoxMWZQTjUyUHMrVjZYekNvMlJR?=
 =?utf-8?B?RGtxdVNMYi8vUEVvMzZHWDdKcVNETGRRYVlsdXIyb0tpZ1ljR1ltMkFhT3lJ?=
 =?utf-8?B?U1F1NlVZR1pJWnN0ZlNlRVU3OW14QjJkV3p0NHluY3JKWXdWSGtlSW1taWZU?=
 =?utf-8?B?WTZLTm52YjFad213L1o5dkdPWW9Vb3RFTS9PUnJJK1JQNXozUm9UYkprRWZp?=
 =?utf-8?B?blo3b1NRekJuZVlnbkREZE1ORWJ4Ui85S2pqNEp3TVM5YWpQcTV1bUdxOFM2?=
 =?utf-8?B?U2UxMVMrb0lKNmxBeG1UZHFHbzQ3TUU1RGtQemxrYVRvS0tsTHZzTmZJb0M4?=
 =?utf-8?B?aGFqeVVObWsyc3ZnYllybExqNHdxOTFMamZHSFhJYWVKdVdEQUtQV0syVWsz?=
 =?utf-8?B?bjlBSE43MUxyTVZmeXREVnQwcm12bFdTZ203ZnJYQmVxWUFhNzNvVU1JVk94?=
 =?utf-8?B?cFlwWUdwL1Y5bFVkLy9zMGJPTDliWlVORm1YUzd4dlBleFBVYkxacmdVcVVQ?=
 =?utf-8?B?ZVpESTUzMGM3M29oQU82YkIvL1NMSGVMN0VIZXBOOXVEUmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elBoSkZZaXl1dXR6QW5TT1BGbnlpaS9XcmRRaXVkeUpCOXQ4MUxVTVU1Umha?=
 =?utf-8?B?enl2NXlIam5PQmFYSVJOTFNaSnFyb2FJR2JwQkZSK3h1WlRVa2VHbUtralpJ?=
 =?utf-8?B?dE5qN1RoWThKZjRzZ1ZEenVpR2ZGRkx4dmJPSWJjNjd0c1ovNDgvMkxKTmRC?=
 =?utf-8?B?ZjlyZ1ByQ0orVUJWSHZUOHJ4VWRsaFpESmpOZDZFRThzMW1Ia3pSVDlsOGVM?=
 =?utf-8?B?a0RDSXR2SmJkUmZZajFjbFJMdkMxQ2lXcmZkWWlhL2dXQXo0Y1hkbTRyZVU0?=
 =?utf-8?B?a0tNa09hOXFkcTZUbHRJaHIzVTZJSnhTY2xCVmlKd2xFaHIyVDVacDdZVHh1?=
 =?utf-8?B?VGxPYXZKM3ZhR3c1QmV0anRLZWhJelVkek5WcVF6ckpPbFhOMEZad2NNUjcr?=
 =?utf-8?B?bEtjQ1Y0QkZqZXozNGhXWmtDUFl4RjVOYWc3eUlHV0gydHppOTVic0Mwb2Vv?=
 =?utf-8?B?Y05vTDRMWjlhVVRTU0l0QXVjbnIvYmVEdzhMZWtTbUxlTlkrbUF0b0J5YWIx?=
 =?utf-8?B?TlQ4eEtTQUYzY255U1AvcWVHR3k5Vm81MHVnOVJpeTN5VjF3b2RFRnRtZ1Zi?=
 =?utf-8?B?dUEwRnU4ZEdkeXJsNDBZcUo1WGozWHhRbks5aFhlcTFJa1UvY2NSNURrSVlT?=
 =?utf-8?B?cWVKdHE4YWhmUmJZZllHdWovZ05uZjl4NEd5UndTY3pJaEE3d0RyZ2txSnNF?=
 =?utf-8?B?cUxWa2xNcitiZnlIK2JHSWhMQUpKMTd4V0xhcjFZaWU2aVZSSTBwWG5vTXRp?=
 =?utf-8?B?cTFBeTZIamc2VHlDN0JvTzZjVGhmY0tOYVY5d0h5anRYYW5yYzkxSWw5ekha?=
 =?utf-8?B?YjNrdVRmc3JZcjI4dUIyS1gvdEJhMEU0a1pUWlp0UHRYb05yNXhySGZob0NS?=
 =?utf-8?B?VVkwanV1cStmRXlMaHFFSUVrczduSDY0TWFzcStlYklqaEZyelpLUVFqbVl5?=
 =?utf-8?B?K2lqRUtPNEVncUdQYmFsUEdmNngzYXhYL2xISXlsY3l2b3k3dDJ1anNUNC8w?=
 =?utf-8?B?UFZwdkhpYWF5UGNUbDcwTzFabkhHVXRDWGVtSm83c04wcXRuSGw0aWtNaGgx?=
 =?utf-8?B?Q01UWnR4bkdDNkgwd25TSW9sNERjODlCKzJrY3ptQlAxdEhDZWZUOUZFVVls?=
 =?utf-8?B?SjUvRFVndWFxbE5seXZ0Q0lWcHNFRFdQcXJBN0cxVXpaOUJEeWZVVEpMNDN0?=
 =?utf-8?B?cGw3Yis2cEpoSEd6OU9xMlhnNlk0eHJybDNRbDRrb3ZIUTArcEdUR1plVUJQ?=
 =?utf-8?B?cHBmdFhxdmtjNGVIMEhwR09PYm0zZ1piRXBDVGhmeHFRM1hZUlFzVGN4MkhC?=
 =?utf-8?B?eitDT3c1ZEVtR0pZWktDSUhCQTVMbHhianQ0YzZZdjNBdDZCVC9iK0FMMUlW?=
 =?utf-8?B?T2lVVE9FZElFdDVOZ0xvRFZCWUhBTmd1S1dvTDNxMllwMTFuZW80MFNVTGJH?=
 =?utf-8?B?UzAyS0w1RThwSk91ZE9nK1JMdkgvT25zNVJaUGxiZUlZWjBxUEh1VS9pcU5a?=
 =?utf-8?B?TC9EUnY3S2drb2IxT05PUnc2U21WU3ZIZ29NcDBqNlpvb1hhSGkwcXhwWVlu?=
 =?utf-8?B?RjQ3ZzAzRmdrNlVBWEx6TXV0NDdnczBoTk1qQUZKTzFzRVZRdVA3eU5MeE1l?=
 =?utf-8?B?cXowd1J5V3U3SGlxL05RMWQ3NHhIczY2V25tdXQ5RzQ5SWkwQ3NhTnByeUNm?=
 =?utf-8?B?cW5oWURKRENyTjZtSFhQUlBVL1BZdm5ybTZDNjFmVWlNRlZFaW5KUmJVWkJx?=
 =?utf-8?B?dnA3QzgxNnR0SzFHMTJLZUh1Ym82amRPWmpsVWxyQVFiTjZqT1FWWDdrNkli?=
 =?utf-8?B?WURYZVdNZ2pGUmMrVEVZQ3RXVXExUzhxdFBiL3ZIazdiVUgwSUdtQ0ZKcG14?=
 =?utf-8?B?bnpabEI5SVc5N2hKZzRWSUNtODdPa3VYaFJmSHA1UGpBVnhWdVIyUy9UMGFK?=
 =?utf-8?B?Q3FKTy9ZZFVXVUJZbDVBcDVvWG5WNklrZmlUWUFIeFVaVEpHcXBGby9YekFI?=
 =?utf-8?B?YjZOUTl6Z2NJekYrSkozcEZDWnVRc0JPL2RuRVE2aVlLbzhNOVMzYlhJKzY0?=
 =?utf-8?B?YVA3ckZ3OFNFN3NPM05kdGFBTGNQSmZFUUFtSmRSakxkZU1oYmY0ZGR4YWMx?=
 =?utf-8?Q?oFVX1twsygzUHdXaLQaueK+ph?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 792b743b-35e1-41e9-4bff-08dde4472c1a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 02:20:49.2207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAnd0s29nmzwv+XiIC87W6dRMmgpCODiuAxfXM+/st5jGmhrtIcM8J8ahWQUA39fxeyGvAGSh2/oOGRlVE5cKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8020

On 8/25/25 5:47 AM, Danilo Krummrich wrote:
> On Mon Aug 25, 2025 at 2:33 PM CEST, Alexandre Courbot wrote:
...
> So, I think the From impl is not ideal, since we can't limit its visibility. In
> order to improve this, I suggest to use Vendor::new() directly in the macro, and
> make Vendor::new() private. The same goes for Class, I guess.

OK, will do that.

thanks,
-- 
John Hubbard


