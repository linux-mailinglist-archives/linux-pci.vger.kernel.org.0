Return-Path: <linux-pci+bounces-24130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E10D1A68EEB
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 15:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939773B8996
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 14:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AE31CAA89;
	Wed, 19 Mar 2025 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iN8S2byZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD6D1C6FEE;
	Wed, 19 Mar 2025 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393949; cv=fail; b=Rak/kCxBWUspGJbsYMWa4JosyBJF8PoNSEOuRxAds/WDcIqvx6eTsc2EgfPgyS0J2bNlc4uX5T4xOtY6eN3HyHybBIJ2aPO9iMk9TpEHhaRwvc8mw8GATjtSCk6EVo45ajMRoCz/SVaYBg4Sfftw5eh7pZ++pL8jRk0gMMTeOdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393949; c=relaxed/simple;
	bh=sGuR/y+I/hfNrRHqw2C3aee/rQm2ahHYXY38fRTHYME=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=m2z3/l2v+lAoNvt+Bc5E5urHnvB/4q2/085a5rxo7OhmJffBfrp7JZCtfJZSgQN+9MpI8Ce35kEu0ADR0+HjIyiaSwYN8xMRHatV5iQHbSBlQ92zITCQOUBlbsSW0zLLWEduTrdlOCmd9Z+5FFeiYDuHRmjpPL+BrQgvTnXfEgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iN8S2byZ; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4SgmgjDc7Fj1amLDXUq1gq1fdU7DLV9mJbbETkVXRd+q2sB8UDozbGeWMTZPt2P1Ak76LRgOe9t2wrKZOuMUFTa0xO77rDRuTVFiDcN9OpUeLy2AFqrwgnyfhGgcAUWX2i+Nv9t6metTyGo1as6p7AvJ2zzTVRc4m2Xehuxfvzs+Ktt5NS4IJ2/RfT8fwdzoelDp1SH44wqXClvmelJyCoYD+fu4Zfr5Tt6z1QcFm+x11vFn/LNecPO+AoE0anaUeAnpRKvPLDR0F12ybejQEjB1AaPK1kYQyk/apTdmeJ1JHnSVBPUzO3EvkXeb+e9e0XyjkoSYX+zSFKtzasFtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7SQmKroyePSTjssZFG1Ar1NnwprnQ5d7JfZrmaZ8qE=;
 b=Dbvz09I/7qKUPW3nJPUwKl360NWArmZ0ZI5OLCPGAkSz8RF8sABD247Az/tEw6YmV20uFhUj72GxLsnrqK192ZcoZro3DMJTH+Nz3We+lEsRIVXNc6y2k7ddSHxKmnfN466COBdBS2LxrOXyBYMGgFBdVJDklAgigII7ivGvsvzkT4DlMM/OuMgc27FAIA+EQT+B1dgMoBGfsAAraeggUefTkq0r+hbcFi8aGcT73PcVPAYJz4DPy6fLKsTomQAOs8wViacls9L1VRinNQCuPSCZXAesYmM9j9qBkbAAic3vG2Nq6AzsIocIUwQq1fabriLrOckfxp04WaLLT3yKfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7SQmKroyePSTjssZFG1Ar1NnwprnQ5d7JfZrmaZ8qE=;
 b=iN8S2byZt1ckzV58gvvbpo+DSZInNCjpG5LRfLThIwmLhbEdUwUp5m8NSzN/rF5ecCLrXeMGlMcE7OHEBDuKZZo6iF5R8mrjvsQFIpj0q/INaIB7ACIImhYU33jsTyuH9cU+N+nKlCiC2lpUY3LJMhiYvQ6VTGS78r5nxpvwvT+NJmQ4EJS0nNqKjXtNcdgZctqOuOLC3w7+dQgDy3MqAzSlskUCJUvz45+aFFcyP2df/QkiWBIZoPUDoLXsehBy+E8Y8qtRO6mlKZk8mzpZPro3Co6zoixdbwbNEW7W64VueAPFEle0H2PBV60DkrScjsibljr758BVBk9In/4QOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW4PR12MB5643.namprd12.prod.outlook.com (2603:10b6:303:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 14:19:06 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%6]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 14:19:06 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 19 Mar 2025 23:18:56 +0900
Subject: [PATCH v2 2/2] samples: rust: convert PCI rust sample driver to
 use try_access_with()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-try_with-v2-2-822ec63c05fb@nvidia.com>
References: <20250319-try_with-v2-0-822ec63c05fb@nvidia.com>
In-Reply-To: <20250319-try_with-v2-0-822ec63c05fb@nvidia.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 Danilo Krummrich <dakr@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: TYCP301CA0087.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW4PR12MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: 93339263-4de8-485c-0084-08dd66f101bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXBZYVV1TzBCVituM01OSG5qVEIxRldnVW9GWHRuVEQ2RS9ncU1NRHRuVHBx?=
 =?utf-8?B?SmIzSWRBSjhEQlJFYjVtM1I5Y1BPdmFaZ2I4VVJXZWxUOTU3aCtha1A5T0Jr?=
 =?utf-8?B?WkF6ZnZJb2lGdEwxYTVyQnUyeER4c3VNcEpIQk05Ymd0SzRUcnk0YVhFQkpr?=
 =?utf-8?B?eGd6UUExdHhtYnkvMmZSS1dSMm5GOUpTNnlKN1p5ekNqTTljMXNHRUt2Qnps?=
 =?utf-8?B?YVpsT1ZJWDBQSG1LTmk2MkpMNjhnM0N1azBNZ2VEZCtyRWdDRlRnd3paOXBa?=
 =?utf-8?B?UFZTLzhWaER2b2wxU01FeUk1SGRDbkZqcitPcnF6UUFOVk01SjJqVHdHeUM5?=
 =?utf-8?B?cm1zbjVkNTN5b3h2V084VnUrZmF6aFM2Z0NuSGZVenRaT3lZQkVJRWEwa01n?=
 =?utf-8?B?cFJkbE81YkQybklrOGRtSmdlZkVZR2t6VFp3aDlxeHhPVG9uOGVueWVHd1hq?=
 =?utf-8?B?WTBrd2NCMmk2YVl4bCs4QWJzTXByS0d5ZWVzTmc0KzU0TGI4ZGVHUDg2WWxh?=
 =?utf-8?B?RTBQM1NWMnc1aHMzcXFOVGd6MkQxcjdCWXJNaFJsam9IVG1td1k2YWx4c1Rk?=
 =?utf-8?B?N1pHc3JaVm0vd3RmUThrV0FBYVMvcDBuRC90aGZyclV5VGdmUXBVT21QdkdL?=
 =?utf-8?B?bVZIckNLbGRBOXgwd2FhSHIxZC9lalFTQVQ1QWNmeERwM3paT1J2MUhESkpJ?=
 =?utf-8?B?YkkxMkNuZmR0cmZSNmczRG1NekVYYkpkSmtPU3ZhaVE3THNHd2ZHU1VlYlJh?=
 =?utf-8?B?TEV4ems4UXphOXQ4ekorYUtmTjFZZmp3c0lqaDFET0N4NlRoWjZUMVU4MVdR?=
 =?utf-8?B?R2hUOVNJUUZLY0hNS1o0djVMc2x1aktYZ1hHQm4vSjNCb2M4SlRaRVRZT0tT?=
 =?utf-8?B?NWZ5R291YW9KbWNMS3F1QzhaS09hZy9wSXl3U1I4VU5aYUUxelV6WHk1cTFJ?=
 =?utf-8?B?ZUlwYmRIZUZZaVFmTmxMYXk1enVYc2xFQ0FpUkhIb2xlNG5qeDVLTEEwZmFU?=
 =?utf-8?B?SitNUitKclVMU3l5d3E5VDRmY0FKNDloNm5BMWF6NG9mUCtFNFVraXRUaHdh?=
 =?utf-8?B?M0ZxdFVwWGtWZkl3SDF2enVZSW9CNXJ5b0JOcE9aOUxkaXNjRWZRZWRPYmlw?=
 =?utf-8?B?ZGZpS2s5TGwrUmcwTmd6VzY0ZGhWb3EyazRtVXdjemJuYnhrSTArVDBzQ0RZ?=
 =?utf-8?B?L0VENXhiZG1DenJxS2ZvbzVsVUtqZU10RDdjcTNDd3B0bk5DYjRXYVl5WDVT?=
 =?utf-8?B?N1REY1hGbnNBak9JOVZpU2ZsNnhwSUppL015YmpLTWM4ZE9MRDlvNEtHUDZs?=
 =?utf-8?B?Wk9nM2lNSjYrb2ZWbWRlTmczRFRDQTBzblBlaXl3MGI1eEUwUG91NHdBY3c5?=
 =?utf-8?B?blBtN0hYN1JkeGV5QXJ2VG5PYkVGSTlVWm9FWnBSUUVzZElBSXdJZmtEQjlS?=
 =?utf-8?B?Uktuc082cmNTSHl5Tkoza3hIOG9UbFhUYkZaWlV6OTA5WmVXWlhXWUdhOUtF?=
 =?utf-8?B?UnN4U2R1aXh3UG9LQWsrMjRMa2RCaThnZXBSMXArSEovZ20ra0dSUElyVThj?=
 =?utf-8?B?blJTZjJlcWNLQ0E4cGE4bVZoQy81aFcwNXY2WmIzaElNQU9Ra2FJUU5HM3Nu?=
 =?utf-8?B?eWtTRDZVVnBvRDZoeU1sOXUvbExKVnU1VzIzSjhpVjFjOFkyRDRydExFZzZC?=
 =?utf-8?B?K3piZHUyeUJpczBUS1FIN0pDWlhTNUlUcWtnR0JHSXFFRGJ2UTZsdzFsblpV?=
 =?utf-8?B?MnhmR2xTd1kxaU5CM29xejFhZjRMNlZUTkUzT2QyY0dWMEplNTFqbFYvanFX?=
 =?utf-8?B?TklUa3J0b05NWUU2RnRnZWRHTktoVnJWL2pmamsrZEVZZEw0RzNWaHZwU290?=
 =?utf-8?B?bDVEcjdjTEpBeUZSZ3NiNXBqdWhRR1VobXZIc2pFZnRKZ3lYeUduQmNabHh6?=
 =?utf-8?Q?9npmk3ghS6Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vnh5S0VIZVdUVUdZWG5TZHhYTFFucnE5a1ZqdlBKYWN2WFRqK2toZ1FtaFdl?=
 =?utf-8?B?MHUwNFM5c0tCanROUlR2ekJha3RpaFc3dE9ESm1Tbkw1ck4rSWNtNUVCMHJH?=
 =?utf-8?B?MVl6cWJxY2pwWDhqS2JWcm80TmZMaXAvUzFaenh0alFPdlBUUXYzaHdCZ3A4?=
 =?utf-8?B?MHJUWkRBc1g4SkJQV1lkNjNNMk1LT3pxanIyeFNKanpsMVMvT1MvM1Y3R081?=
 =?utf-8?B?RDNuV0l1b0FpbUZ3akJ4R2NhUGxZMS9xWHpWQXJMazdYUXIwOWtJbjhBTm54?=
 =?utf-8?B?M0d2ZlNURUN6SHFZbUthVERramJTaS9QeDZ3Y21xMDJXSEIxVUViRGR5YXpJ?=
 =?utf-8?B?VEU3amp3Wm1OOGNkWDc1NlhwZDBGcEp3eWU2a21GSkprSXdHNVFDUHdYeDB1?=
 =?utf-8?B?RVZaK1g3UHFjUmNROUVVZWtjR0sxb1JVVVoxZmpwOGhJb2VCaG5UanNDTWtD?=
 =?utf-8?B?ZVNVUXM2aUFweTRPNU0wTUFqbXkycysrd2NWdlB3RFZ3bnJFQ1lSL29JKyta?=
 =?utf-8?B?Q1J1a2JtRWNJdWdrS29HcmVLbEhMNzUzMjRTcjMrNFloM1NTU1RUK0xxQldT?=
 =?utf-8?B?QlZweDhZQ1NmZkhzS2VXN1Z3Vk9vemY3cUkrdHM0NXVvRlJIU2NpdGtMTHlz?=
 =?utf-8?B?blhrTzNnVS9WVFRORU96VmdJZ0RybzRwL1Z3YlpNTDZBRVl3bnRzNUU5eENK?=
 =?utf-8?B?OStjMzVickZmUWlZa1FOUW1Ud0NWcHQ5bTZLZGRlZjBZQ0JuMmdaTks3WGxl?=
 =?utf-8?B?cWJvbm41SEpac2UyZkIwR1V3TEdSWEhlSVk3K3FMOXdMMkV5QWdMMVdZc1p0?=
 =?utf-8?B?TGtnenRQaEl6K2UxNjlRKzFWREQ5c0M5Z1NLd0UyVUxFVDUwWTdkNTNDUjh4?=
 =?utf-8?B?RzQ5dXFHY1Q4N1BHdFZlUDd6ekFoeUdEcjlaMmdYT3JERWJVb3liWU1BSERF?=
 =?utf-8?B?bHJvVXkwUUZHdFdpRzRmd3BSL0RBMG8vcmNJNi9jZjJJWXVieStabnpFbkN0?=
 =?utf-8?B?QTZBL3ZGS3ZlM1Q5dktWeENTamVFWGJteHpxbEQ5K1ZzOFVoYkhDbS9ieUUy?=
 =?utf-8?B?MVJrOURPOUVhOWt5S01pMW1GczdZMGxRL2RUUmpiODNNU3kvWVZhTHJjMExl?=
 =?utf-8?B?U09NbHpWbHQ5bHkzR09FZUZjVWozY3l6Y0FHMjhtVmhzY3NCVGV2MlFWVCts?=
 =?utf-8?B?Zk5mY0lZZjFMamNuWU13UU9CczJqRHkxSlZaSnRRdGoxOU9jemhscmhPbkdQ?=
 =?utf-8?B?V3FXYzVJZHBtTHZLRDFKSWtNRWFzTW5iOXovbVdlVWx2WkFiREZQdlU2WnY3?=
 =?utf-8?B?dGtLNWJ2S01Wb3Btd0k0ZDJtRFZsWWpMaEsxcnpGdnhQR1BVN25pK3ZhU3lX?=
 =?utf-8?B?YTg5OUkwVzE2RXJwNm5oeFlkeWRQVURlZEpZMGg2am8wRFVMbERPK0w2cy9j?=
 =?utf-8?B?bStjWDk3UWNUeVBlbnJ6dXR2WUZvdWRHSlZUV2pDV0tqN0taWkpqTWx6ZVB0?=
 =?utf-8?B?NUIvR2p6QldDbmZRMmNlcnF1enU1dzB0Ujc3WXdGMy85NHoxYVBqOFRtb3Uy?=
 =?utf-8?B?ZnFTa3Y0Vm0xSjQ3YWsrYTdtTnZ0aEhLeUZNSUdES0tCSCsxTlg3eitSZmRq?=
 =?utf-8?B?ZytLNlUveE82N3pKZkx6ODdod2tnbXVKbVhZOWF3bURkbEcrQ3IzWGxSMG05?=
 =?utf-8?B?U3pFOHpOVVdVcytNdE1MMUw3SEdRb0FXS3VjazdzN25nZFpCZFlFd1FJV3l1?=
 =?utf-8?B?b1h3ZmRTUG1vRTdhK1RsdGpZdzdpT0RuNWsvSW5LVHNyUDNMTXFOYXFDQ3lt?=
 =?utf-8?B?eFlOQU9VZDREU3VVRU1VTlFsVTNzNGNVUjlBZnhJUnJMcFFnb1U5SFBEQytT?=
 =?utf-8?B?V3lTY1kvUUF4RjZ4NEZxc1JZVTdKbjhjT3VxZ1dSQVlmejN4WXVZbk9PVDBL?=
 =?utf-8?B?aXlia0ZHS2M0UWQ4N0t2RHpKVm5UR0QwYkt2K0NnOTdoNC8wN0hqeWVpNytk?=
 =?utf-8?B?dUdmYk1hajdDNWNrOFFlSm9TUWZFSmZVYTdSdU84TGc2ZFQ2NkVBNG14aHZo?=
 =?utf-8?B?dk5FV3MydTJkS2gvNktQQWxvRkFuT1RkR3ZkRngvZmwyMXBQNXorZENrNmhJ?=
 =?utf-8?B?a0J5QU4vZ1luRHJkbmNjdWdTeU5BNGFLNk9QMGxjNUcybGhoSm1CMGRPOU1I?=
 =?utf-8?Q?oZHlBMvv58mEjBfnVVp/1P3mFIJLIQkLjcsDG7qb/BR4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93339263-4de8-485c-0084-08dd66f101bd
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 14:19:06.1524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5AiIDpvFstOgCKAoMXlgBwz/NKaG9VYqtHJOKUqxnfhlCkd79/BmeRsDa4xGlog+laDXFPIZoq8FfG+MPbcQwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5643

This method limits the scope of the revocable guard and is considered
safer to use for most cases, so let's showcase it here.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 samples/rust/rust_driver_pci.rs | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 1fb6e44f33951c521c8b086a7a3a012af911cf26..f2cb1c220bce42d161cf48664e8a5dd19770ba97 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -83,13 +83,12 @@ fn probe(pdev: &mut pci::Device, info: &Self::IdInfo) -> Result<Pin<KBox<Self>>>
             GFP_KERNEL,
         )?;
 
-        let bar = drvdata.bar.try_access().ok_or(ENXIO)?;
+        let res = drvdata
+            .bar
+            .try_access_with(|b| Self::testdev(info, b))
+            .ok_or(ENXIO)??;
 
-        dev_info!(
-            pdev.as_ref(),
-            "pci-testdev data-match count: {}\n",
-            Self::testdev(info, &bar)?
-        );
+        dev_info!(pdev.as_ref(), "pci-testdev data-match count: {}\n", res);
 
         Ok(drvdata.into())
     }

-- 
2.48.1


