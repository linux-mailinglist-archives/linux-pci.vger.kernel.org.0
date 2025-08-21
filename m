Return-Path: <linux-pci+bounces-34480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8403B30085
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 18:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BA897BAA99
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 16:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF792E5B17;
	Thu, 21 Aug 2025 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z8SIS7qk"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EE32E54D0;
	Thu, 21 Aug 2025 16:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755795277; cv=fail; b=UxIkIKojEw5LSq8gBbSdbdAP4En1gXO+JoqrGAUrPAc6Uqq2B1nLBTPTdMb7qikKPJRqtFBPhNpZxSK9nDJ9ecjmQkYV+KJ6USTgzeg8wTu4cvaH+anDDIt5pOevtEorLwVl6xDDNWN1dfjgpzkOiCE7E3prRf3xlC+1+fcSPh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755795277; c=relaxed/simple;
	bh=lkI001gql+KrzFY4QpO4aazSQIaUMnq4STNIIHc31PY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nnM875byDhe8HUoIEZvoEFbZ9NAa2MBQCjOeWwOxbfxJc67dtHwGzPKWGGAQX9EQj3/utkHDPMiSic7E+dnLkqT3e/fr3yODaciSiO8qloXtxe2uaH/iqzdhZYqCtIGkkJMECVtVqyvlCQd43Z3zr/8kHCapeAlR6Q4PReCgxwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z8SIS7qk; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlKOQ5vqRinxiTtCPBYw+Y4VcFbPibe5cRiYVQ8NXe3oTqkjPAAWm0ohQbqYkXc1Qf+QZ2tMfGc7jT5slRsYwj6WFLBnjaIQrNo1hsVu4e4pSgIjpsfNqHg8jArq6pV84vaY9WD7SLx1xg3LAuEJYInuHRkVcg4nr/1qibtXvv/pnyyp8fdEKYLaGT8g8dQlt2FmscQR5sQGa8dwawwKsMzmK7Z6Tlcs55C3V0LLFNQk/ZGpR2+uoY+W6G1Xj8BvQ925mhBS9Ubq8UUBRg+YbhZ6QI996BeLpeD0QrJ2eOqSKtwoksDvtNpJ3nqwHCVUoLrU4cXamnOz9172iy32PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luR1pc3eRfe3fGY1rY287+cu58tqANv1swG70EMLXfI=;
 b=nykovsCZTKt7REekuVFTBLQd7JW9uDZ5eCf0tIft3SM3K1tE3u7w7Ab7Y5pdZoYf6Ks/D1YZcLHw0D+SQ4BXdV/tpM6VGMmHHBIz+aQn23A2X1dY7WXNL/QdZt+KfpqT3jGRyDltgmS0QWCEc5N41pzntX2PXbKq2uBkX36EImxoZ6WRm7F+ozpOk+sQnuUFN5thGqgSQOoOcxIZrDlYWkxSAbrDlCuQQYAeG/vb4wP57iXy0ElIHUViCKZEQ8r5jXUCN1jriL792S4ozVmq2Cw9MczZKrocbJaduQdofyO5nLli7OWYFRYVlXUfflvxgYF0KJud3Cb4W5Kf9Q4Mpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luR1pc3eRfe3fGY1rY287+cu58tqANv1swG70EMLXfI=;
 b=Z8SIS7qkD5WtI6zNFcLX+CdAx/BquI+NmYbqgI5MoCRGQgTWLxIn1qvTRlop6VxG2secwuI6j8EDFLXyJ6pUYtli8Ydo7XwtKKrXYysIW/ZAiUN/BJ1rVunklTEH/HyfMeK7NrByJjVZM9P6X25eUB/7tjVhH5ux7SmbF9Oe8cFTtrl5HoMyJU6UFMRVWXirgtXBJkjrxRdlI7ZoDoHV3/WYbNSQtdtLVuImfT1JE6oS/D2luevZPkUMhn8H7qEJ1pTv/01ei6xJ2e7pC20BP8+D4b5FjdTxf/NLE/sT2uTWuZE3Bz5uBSG71laGUIsMVPOu0rh0fAY33RW+K/IJkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0SPRMB0001.namprd12.prod.outlook.com (2603:10b6:8:cf::8) by
 IA1PR12MB8553.namprd12.prod.outlook.com (2603:10b6:208:44e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.16; Thu, 21 Aug 2025 16:54:28 +0000
Received: from DS0SPRMB0001.namprd12.prod.outlook.com
 ([fe80::49ad:aa8b:a8b2:450e]) by DS0SPRMB0001.namprd12.prod.outlook.com
 ([fe80::49ad:aa8b:a8b2:450e%4]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 16:54:28 +0000
Message-ID: <f718170b-8ad0-4039-a6d4-45eb067d02ff@nvidia.com>
Date: Thu, 21 Aug 2025 09:54:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] rust: pci: provide access to PCI Class and
 Class-related items
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
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
References: <20250821044207.3732-1-jhubbard@nvidia.com>
 <20250821044207.3732-2-jhubbard@nvidia.com>
 <DC81R8RHTHTC.3J58ODZD3UQLQ@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DC81R8RHTHTC.3J58ODZD3UQLQ@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0021.namprd21.prod.outlook.com
 (2603:10b6:a03:114::31) To DS0SPRMB0001.namprd12.prod.outlook.com
 (2603:10b6:8:cf::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0SPRMB0001:EE_|IA1PR12MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ce2b130-8709-4868-63bf-08dde0d3641d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnJYcCtPQ3ZFNjFDUWx6aUg4VHR0Z3hpdXVTK09VZ0xuM0oyU0I5QTQyVS9O?=
 =?utf-8?B?RTN1SXJoQXRPZUJCdUd4alV0eG5EOVJmUEVEeHZBU1VyM2hPRXJOdjJRVFAy?=
 =?utf-8?B?K1dZZWgrZVVYcUwyZGFrcjJwN3QvZm0wa09lcHpMbENIdEVLZ3VCOEhOWDk2?=
 =?utf-8?B?Slc5Qk1JZm9pelkvOTVsOFpjNWEzcC9aS3YvVjRRNkVSWnNRZElTZURJT3l2?=
 =?utf-8?B?dEVSdXE0bVRlZTBDYnlVdWZ2ZDNIbXNFbmloc1BoMWxKZ2tIc1krRjVsTGQw?=
 =?utf-8?B?OU51VnFTb0NlWHRCNHFUdnEyZzJkaHRrMFNVRm51d0x4TjBhWjZCbERURWIy?=
 =?utf-8?B?OWpmcjk3bGVDYytlZTNLbG9QeWx5RnJCc0p3U29hR0owelFFdnBIeHFScXQy?=
 =?utf-8?B?YWlhY01yWUlZcThhUmg2RFFJMzgxdmgwNEx1VTdPY2gvdTZHYW5hK05Pa1lU?=
 =?utf-8?B?Z0ZuMkhyN215ek9RYmtrN0xuMlBrcjNJeGhWL0JPeVJuRWpzbE9Rb1lBL1Ru?=
 =?utf-8?B?ZDZOWmVPSzd6QVFiQ1RBM3JtbEpjeWxKM3EvcFRzMC9qRXpJRzZvWW5MRDYy?=
 =?utf-8?B?Y2pOQUpvN3ZLTzZYaFRiUVNNREZEUlMyWTJoL3RHOWllbitzOW1yV211SXcz?=
 =?utf-8?B?ZzRkd0o1UjllWnNwQTNJQXhTNmFZaWpRbnVwb3V5LzFyVndJdmtLT1drVkJh?=
 =?utf-8?B?Wjd4eGVTNTI2bHNXdzcwY01pSVNrb2RQQlZmWFlpSWJEV3pIYzNWNGZldmtt?=
 =?utf-8?B?TEsrK1ZBN0FEMnFLM2R2ckZsV0FhYUhXVnZDNkdhZUZlUHlrdlFhY29ta2ls?=
 =?utf-8?B?T2ZYek05cTVsYldmUXNoNjZyNjJyZG5OWmJ1dDJJSEw1RzJiakkyTitYRzJl?=
 =?utf-8?B?bEJmZ3luNFNhY1ZEd3VOZ1ZlV01zaVFQdTFEVnRKelRyV2JxLzVGUWNiRzhU?=
 =?utf-8?B?K3NPN0xhQ2ErUTdsMUR0ZG1ZKzNGQ3ovOWxHUW9TNG5YUjdpMUZQeGZMQU1H?=
 =?utf-8?B?TVJKQnZZMGc0clpnenJkMVRxQnUydXRwMThPZEF1OTdhWkgySkhqTm1kR0M0?=
 =?utf-8?B?VHZoeUZ3TDBXN3Y3NnVLQ1ZYV1NybHI0SlNOblYzS0pXOENVczR6ZlRHNE5K?=
 =?utf-8?B?L25WUUt3YytaVDl6Nno3VmpZUDVReXBmM0YvUmpHNjhFc3BqMjV2Tjg0K0pv?=
 =?utf-8?B?SnRGUjFrQkVkOGFnN05SYmlDdkFoQVVybk1IT0hBV2ZoWkx0d0R0RWJFYm9D?=
 =?utf-8?B?WG9xRExCYzByZXBEendwSGxmYjZMQktYWlBnRHBnWUVqSXVrTlBKcjlCSVBT?=
 =?utf-8?B?dTgrb3RFVDZ6L1gvQmIvYnlyRlQzSml0SW1Ed01VcFQwcTNKMjhicWJ3aTRH?=
 =?utf-8?B?V3F1ZktWeXBBbFNIT2piNW44RkVVMURObXVPSHdxV0dDRnU3M3F1WlM1U2lJ?=
 =?utf-8?B?a2tWRW50RVBUOUxtK1BFWjdGTERQKzIzOGxxUEFnYUk5RDRzZVUvREJNcEVD?=
 =?utf-8?B?TDBwQ3FOc1BnMGFDWHNKUHc4MGVJbWRQekw2aUVwNmd4bCs0SjF5b05wVmhh?=
 =?utf-8?B?U2prc0drYytvL1VnZm9BelBvY2I2VXZ2azUrK1NVYm14eFpTa00xWkFTeWZS?=
 =?utf-8?B?UVMwSEJ4cERCaGJDNmxZVHE3aHliQWplU1lpTXdybDJoZkJyRmtEekFVd0Rr?=
 =?utf-8?B?aGdjK0FXdnFmOXZDMGZQZGZ1UGd4dG9vbkFKaXhuMWltYU5ST2JubEsxYVV3?=
 =?utf-8?B?VGxlOWZaN1N2bW5NUVkwODN1UWFONitoRXdJWGZtL2RkYjBoSmszMDNiWXZT?=
 =?utf-8?B?d3kvclpDcUhhYWRJalQrVkpId1ZvRnNOM214aVMvbHZlNlVlQmpOOFJMb0ll?=
 =?utf-8?B?dFU1S3pZYlZ4ai9Cc3lMNWN2cUhZdVFrODRVYzF2ZjZUWmU4VGordVc3d1Mz?=
 =?utf-8?Q?a+t16cNQwDM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0SPRMB0001.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDlKZklWSklJend2YnVmOS9UN3BWZ0NvY3dlYVorYnBvdllwaHdpZ0NvVFQr?=
 =?utf-8?B?elZBczh4OVYzMzhETXovMjJtL3VZVGEzd3FpdDY1T2lraW9uTGo0VTlza1Zh?=
 =?utf-8?B?b2Z5c3FWYTlhT2thWW1TMmFWL01kRGlId05Gb2duRjhPcUFNZEFjODYzU1dI?=
 =?utf-8?B?bys1ME9ObUVyZ3RwbEZ4VGsvcTgzYzdKVkhpSTl4d1VzZWxia2FvRzhKdWhE?=
 =?utf-8?B?MXpaNlRBZDF6Y0xwNUx4cVFoSU53MnQ5ZXRmWUpBUEhoMXcxckc3TmdpNXRD?=
 =?utf-8?B?MmpPeFZoaUlUNjB5WmJ6Z2RtUlFuZFVhN3JOcUNka3lkbWR3bVk5cGp1L3Q1?=
 =?utf-8?B?ZHRnUVJtMDZ4ZGc1Si9JS2Y2eWNVTHFUd0wwaUxSSXdlVEt5NWxhVmlEejZQ?=
 =?utf-8?B?djUwWTFVMyswSU04K0tJcmpvNklnc21IUnNVTUZjK3o3bFFHUVhEZ0w5STF2?=
 =?utf-8?B?NEFpMWsyVjd6MXNxZjAyT2t3QTR5SnFuWTRQaFR3MHB5Z2RXRHd1TEt4ZzdC?=
 =?utf-8?B?aVo4SUdKdktmNHBDZ25PWmNQS0JwN1NZTVFvZHpyMFpMMmowazlpbkdNUkFH?=
 =?utf-8?B?L1k5bm1hcWtKTzlWejN2bm1Bd2tQZFhSWVRrTWYwNzNuQTB4WUQ3TkVlQWp5?=
 =?utf-8?B?Vm1DbWtpZXgwRkU4cVJtZnZLNGZIQ3c2QXhuQlp1UEwzeWRlTjRvSzJ1anRZ?=
 =?utf-8?B?YkZDYUE5TG1nUXVIRC9jRWhDS1VsRTM5dm96dGorNlRPQXJiVTlxbjF6cWo4?=
 =?utf-8?B?Z3ZLSGdjMUk3ekgxTFh0cFF3dlZOYitQSExGYzhabVdxd2o0ekY4ZUlJN3ZJ?=
 =?utf-8?B?bjd5dGVJMVkyVmQ2cHFwNDdmWjZvNkdlVmdvV0ZTSXlxZEF2bjZONU5yaG1n?=
 =?utf-8?B?RkRlc3VrQWhKdUxPRHZYTktJTlY4dzFzL3lKK2RoS1hmVlJIUW9pUVJTMTZE?=
 =?utf-8?B?SVBKYkRsZmY0UmJPYjhiUVhUUnArRjErYXVFUng5Q0xBOTZhdWF0Ry9WS1U2?=
 =?utf-8?B?TEhHSllLVi9ndHhXckhETStLZ0FuSEw2WW96SzFGTmpwOC9sVjBrZWNiZUYz?=
 =?utf-8?B?RmRFSHRna2ZGOGFaZ1E2VFQvcHZ3WVppUzFzOG14dmNneXpBQVJva3o5dURK?=
 =?utf-8?B?QllCWXV5bitmV2pwYU9EcHkvUXJ1MzZram5lRnFTbHNQWDc5dzNTRm96OUl2?=
 =?utf-8?B?ZWtkSDV5SCtTUjduNXdQcjNNVEduQndrT2xqbGJJdUh2NmI2SU9NbndFbUlM?=
 =?utf-8?B?SWRoZW1kOEVWc2tJMnAvWDBaZFlSOEFibW01alVvZVB2L1VIYlVBS2phVytW?=
 =?utf-8?B?K3doZ2RMcGE4aDY5czdpUmVlR3pCQ05JVXBGWDR4cERtSXd0bHFFTzlBZWt0?=
 =?utf-8?B?VUhnRi9Ubk9TTFhZaWF4cUY2aXcxalUyNzZQSEVYelE2S240V2pEdFRMMXls?=
 =?utf-8?B?TkxJc24rdjdDdld6a1hhaWNRWkU1c0Y2eGxsWXl2WGtydFF4RCtOcjBPVFNQ?=
 =?utf-8?B?K0twelJuWEVLN2Q5OXptcGpSYkhGWFozaWMvWWNtU0Z1aWVRNjVzRUFOZjBL?=
 =?utf-8?B?WXFkK0ZjRWtGWEdQMnVjS1VoWXFGa2xyVnc2YkdDOFVWa09MZU9TdlpKVXQr?=
 =?utf-8?B?c1ZYKzVrT0hnL2JiMVAxQkFhTW8rQ0dNQjJWdHdXTXdyVk82Zm1CK2tMcWt0?=
 =?utf-8?B?aDlmd0hQRlhRRVVCKzFrcXNMTWtMYUZOT3RvUkNMVzlGV1RzRHljUmtqMjBM?=
 =?utf-8?B?cHZuOVN2d25SK2hYZktsV1ZibGY4SmJqMDBocUxaYzNxbTgweUVjQTBYczZY?=
 =?utf-8?B?ZytkdTdvQ2hIOUwxTEtZZjZLaFpDNDNCWkRteTErVHp3MjVCSHhxZ2IvV21s?=
 =?utf-8?B?ZEVuU0h5Z1pFUHVZKzc4KzE5U3gzTGhPaHdXdS9MYysyb1R4emdmVXhmRGpv?=
 =?utf-8?B?UDRXTTZpNlNGT1VWNWFvM0VnZzc5NmZyTGgySzJXaGhtYW5WU2djcCtaTEp4?=
 =?utf-8?B?RzF3TmVPYlhkWFRNd3Y5QjZ0djlpQnNheVRscDVDOTFlWVU0R2dSdEdlZE9h?=
 =?utf-8?B?QmtQR0JFS2FsM3oxMm5DTHhsM2tXNGdqeXh6NmhESld1aVNGTkZaOGI4QUpw?=
 =?utf-8?B?Tk1mcXJwSGkyaGo4RXJ1RGVZdEdyV2RBNVdkeC9CVFdxMUpwMGJHakIzN1VE?=
 =?utf-8?Q?yaq73YE6NkErcaeJT+ldoyw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce2b130-8709-4868-63bf-08dde0d3641d
X-MS-Exchange-CrossTenant-AuthSource: DS0SPRMB0001.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 16:54:28.1307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /62bhEnTBmzuk/Gxwt2k6HQEAUrd541ZzSn/ZM5jzXpP+/4imV2zWURW9eeg3WSjZo2zfgy/2FH5cZ7uQqlPWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8553

On 8/21/25 3:51 AM, Danilo Krummrich wrote:
> On Thu Aug 21, 2025 at 6:42 AM CEST, John Hubbard wrote:
>> Allow callers to write Class::STORAGE_SCSI instead of
>> bindings::PCI_CLASS_STORAGE_SCSI, for example.
>>
>> New APIs:
>>      Class::STORAGE_SCSI, Class::NETWORK_ETHERNET, etc.
>>      Class::as_raw()
>>      Class: From<u32> for Class
>>      ClassMask: Full, ClassSubclass
>>      Device::pci_class()
>>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: Alexandre Courbot <acourbot@nvidia.com>
>> Cc: Elle Rhumsaa <elle@weathered-steel.dev>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>   rust/kernel/pci.rs    |  10 ++
>>   rust/kernel/pci/id.rs | 239 ++++++++++++++++++++++++++++++++++++++++++
> 
> Please add rust/kernel/pci/ to the maintainers entry.

OK.

> 
> (Would have done on apply, but I have another comment on patch 3.)
> 
>>   2 files changed, 249 insertions(+)
>>   create mode 100644 rust/kernel/pci/id.rs

thanks,
-- 
John Hubbard


