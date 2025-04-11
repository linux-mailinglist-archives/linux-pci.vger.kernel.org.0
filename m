Return-Path: <linux-pci+bounces-25673-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CC2A85C87
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 14:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D0D4A4895
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 12:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A378329B211;
	Fri, 11 Apr 2025 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nnhQrZTs"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B0629C353;
	Fri, 11 Apr 2025 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744373397; cv=fail; b=J0tQ10CGIGC41VxryGOfaDF++UKOMdC7+lLdw6/MuEzhnRamclqJV58owYON2RZOKT5oiAhXVK2Mi791dBNVZ3iyQRxQCLceyRwhXMflb4Go/aKhlTijgiQmD1EGJLE8btitq81wLLWeBQUinmfO7nMoFEejMJn1lErOLwvddE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744373397; c=relaxed/simple;
	bh=/WxPSAGddzepkCUOzirOjYT4QttncFybcoE0CiGFgms=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZMh7LXWBVojpAKeBo9GYMVNOXcfHzzOUFMaEpo3f+VfoxnPG+JYaUQ6xQzdZjjbdFL2JhzWhG410hYM7bUfE/VXUEbj5TcAdmh3Q1H9FxLckYDdX+59Rf6hvscvgobtG2zyFbvFdHRiTZfVm2AvSREuWnAbaw2CPskNYXpvNcrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nnhQrZTs; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yaqir1ZE8d8mFnpL8smA9Erxc8S324BKcX1YWMe32yw3DqAI+rO5o2G8AaTBcQMMqz7ivrefTCtjZyx4OzTsKVE5B51kakbKpdd4spzdZV5LKETXHZVgQxrNV8++1hzyLnt7eKyH6MsyhLTKPL64wCk1F/wqQIDVxBxEgWmL6XYgmX84xJB4PshTIEOfEpzupOXYecXGDUyCxCnpKOsbsyMGVO5Sb9cCZ/gwglns5cskfJzbMvEj9C0JzNJbZAkDr0jLeRzit0M0Z0UKGrlV9R+UrVDIS7QdngrMEd7wykSlAGcxjQcxcUA2YAjfEBD4FwddK9zMlcca0mEgX0Gh2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUacHctjyyg7XgBZ/Qy5e/eyfweR0zKBMi9h5vy8XRA=;
 b=gbt9iKxUjr9njEMqt84g/3W40JQSkSewi+xMv1M6CK0DeitDGPHRdTdMl28xcun9QgECKl9+aMSGYZ6/H5dfEZ8dfvruT/LFq7gw564pHL6KpTwy3Bupi42RyAS9W8PGKPubwu02aZmTmLsOXYbOlL5mm+Lqnosqvrf/Q7wtL5oKkdj5Z3aMRO56uQ57TVtibbD5zRZjHdDIo7XhOLC3ZQH8nRUWCJsAxfuhxJltN5MGh3urZJJFZp9wJOZgJy+xu9kFQ+zjJQbx5P1n3oGmVP4OP5mPo1kDus0F00IRaJDU+4pB1ufuO8dsWxK0Rn8DQ5QWu2k8voJ0pyBlL6JanQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUacHctjyyg7XgBZ/Qy5e/eyfweR0zKBMi9h5vy8XRA=;
 b=nnhQrZTsZSE2zkyMmLli+0zyQdB22L3aW7sjKUsW26MOYM0VxOyCgD0WJdZ82OmZI1pdNjB9cqQhLv8KvEVvSg8kI3EF30eF01G/GrwXzQfMwracO9HMphrmRQ67u3m1qJ64yjaoELOPd6VwLLPcay+cHjQCLbq76RhAbvnN+uSMlRxZm1Q/VIUFdi7MwXnOU3wOHJn0BfkfAcYJqvUhI4NG35HoqnFUCTcB1Li5Dpu6mBavzhozp3pGju6Ejrid9fix2Gym6cvw2Ahiul6hhiwu7EWO8Ho7AJ3acnMnQ8rODaCb/FgeflZV2ceJ9OxSnaflOx75z2qyxjwW55jkig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA3PR12MB7877.namprd12.prod.outlook.com (2603:10b6:806:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 12:09:49 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%6]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 12:09:49 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 11 Apr 2025 21:09:38 +0900
Subject: [PATCH v4 1/2] rust/revocable: add try_access_with() convenience
 method
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-try_with-v4-1-f470ac79e2e2@nvidia.com>
References: <20250411-try_with-v4-0-f470ac79e2e2@nvidia.com>
In-Reply-To: <20250411-try_with-v4-0-f470ac79e2e2@nvidia.com>
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
X-ClientProxiedBy: OS7P301CA0008.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:604:26e::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA3PR12MB7877:EE_
X-MS-Office365-Filtering-Correlation-Id: b02f214b-9999-4b60-9b5a-08dd78f1c1fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nnh2MzVwWUpBNDk3MENMUmNIdTgyOGFPRDNaaXBrTm9QL3ZWTDkzMG1SZkQw?=
 =?utf-8?B?ZlM1WlJGMHdOQnJjNzl0b0VDTTRnRGNZRnlpTUxVbFpud3QxVWZockJkWG1o?=
 =?utf-8?B?eUZWd05xdFVNam9pYWI3a1hMdXIvbVI4ZitYdTJEM2JrcEllbkxpUlZ1bHAy?=
 =?utf-8?B?NFE5RTlpVUY1Z0NRdXBPS0VjMlE0emhTYUpBYzFRcVdMaDZsVk4vVlZ0QW9M?=
 =?utf-8?B?V1FhV0hrV2J4SzdMZ3ZkRXdCbUdnVmkvR3EzR0g5VDZZMUxQdGxzNHUvTFp0?=
 =?utf-8?B?UHhQalYySzZ3UFlFRTRmM3BNTTM2V2Q4akozam1rclRRTlMzblpsSWxCT2s1?=
 =?utf-8?B?QU5NTVVWWU4zdVRxY1d4bW1vZ0JaUjlNZVhGdE9vZlIyQyswYk9EYjMyWXRE?=
 =?utf-8?B?VDZMcXZueUZva2NXVW9ObFlNc2U5Tk5BQkJhSHdoZXhJQ3JVZGJxUTk3NzJB?=
 =?utf-8?B?ZTFxNVhLY2hma0huVVdPVVZIbXlNVFY0cktwejBuVFhDb3FMZzBMSk0yc2N3?=
 =?utf-8?B?QkhRN1JTT2oxY3JCY1hid2drQi8rcHlkWlVYR1M1WnpWdS84b1JqYkNGT2pt?=
 =?utf-8?B?N0dzSkVoNDNGRzY0d3duMis2Yyt2VDJLZnJjSDVRZm9vT1U3N2lrb2tGQ2Rt?=
 =?utf-8?B?V0xIVWduWHlBQVR5WlBybDNPeXNuMEltMmFobS9EUFl4aGx3dFBaODR6a3hJ?=
 =?utf-8?B?TEF3ZVJTZnpBOVA0UENoRW9LWkFCRUtrS0pZVkllOFpraEtCQUhkditGdjhI?=
 =?utf-8?B?bjRZMURxemptZnVQTC9VSlEwRUFjZUhCVXIrVmswSkVNdjNxMW5xbWlJeGFt?=
 =?utf-8?B?ZmlzUXVFN3FxNkFHNkFmQWhFVEg0dFFuS2MyTldrMlRxWFpNN3hpZGQwL3k2?=
 =?utf-8?B?emVqdFdOWlVDL3pUV0x4NFJGTitKT005bDdQZE1CZjlodEhsUzcyTHQzbWIr?=
 =?utf-8?B?WWw2dHRlUmwwajBicXpJaVp3VmJ5RTVXb1dNdnRKbDVPa1ZTSHVPZmtBNnla?=
 =?utf-8?B?VXJWbm80L05JYmg2czVGOHRTbzBiRFFaMDJmSldSd2ZMR1p5a1VYS1g0Z0Rm?=
 =?utf-8?B?aVo4S0xJYm9qRW9ZM1o3TmxYUTE5dWJjSjhsMXVMLzNZT2RwSDJpYU14VWVE?=
 =?utf-8?B?MlYxeU55dGpYTXRXUzkyQjF3NW9iZFdPUGsyZnV0R1JFZTFKRUVCMjRnanp1?=
 =?utf-8?B?SGJYMjFrQndBa2tMdVRwUVhSdzBRWTlYRTJIajFjampiWDBYekJRTGx4MHlL?=
 =?utf-8?B?YzlYb1pnUHZwOUJHUGdteHVyNE9WL3J2aVNlL2UxNTNNUlFMQlJwZ2VINk05?=
 =?utf-8?B?NGpHK1RvUVRmZkpkVE02RFVwM3BPNlExUTlxMGF4T3IwVWVGdE9RNXBmVGpI?=
 =?utf-8?B?bVhTNnV6TVRtRzN6M0E1emRXeFZDcDI1OGNXVGNENVROdTNTaHY4N0VncUFL?=
 =?utf-8?B?VTdvS2E5K0hoT3BmZTE4dERuV0VUNkM1dExOMlRRUFdvWUhpVEhJZzk1ZWRx?=
 =?utf-8?B?VzlQRUkwUnVtN0VvMDZOOVhZSHV5SUZiZitSRk4xSnc5bzhVb2hpZzBsZnN0?=
 =?utf-8?B?aTU4b2FHaHhpazR2WkZNNlNkU21waExXblpYOWo4anFFem83RXNOWWZwTGl0?=
 =?utf-8?B?TWJjM203TTg0SC9YeHAwOFFzSno4NGtPci9WdlNJZVA2VnZsaU9oNzE5bU1i?=
 =?utf-8?B?QUpzZDlqUHJzSlBRRmJlcGl6OUE1Y1NwakM5TGNCdEowMkduMXkrK0JQdEpa?=
 =?utf-8?B?cHNaRWs5VHAweE1uZGNGQkluWjBtK1hzd1BZa2JOdUptZHZwQnRqT0loWWdP?=
 =?utf-8?B?Y0QzZ05sS3EzSnJRWlhLR3ZUdEVnYU0yMmRLcjllcXlWTGhRUVVGVDk0Ykdz?=
 =?utf-8?B?UDVrS0gvenRicXVnNW01Y0pKUnpob3hqT3Vhckl2aDZ3WUxpY1hZVGc3dk9s?=
 =?utf-8?B?U3lyRVVTRDQvSDNob3hvOFJhc1FHT2hyb3pSU1UzcTRyeUk5d1FzVjR5NkRD?=
 =?utf-8?B?cEJ0c1pyQjB3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkpmK2NDckJDaTZ0TzRVRmNKWEFWU1g0bUxSWFVPeE43S3htdjliTWtTcWJ2?=
 =?utf-8?B?cGY3RE16RmFkdmltR2xzNCsrS1dCU1ZxUUx6UEh3OTdZNG94YXFKeStyOWdC?=
 =?utf-8?B?dzNUOUhUb2t4MksrRExXM2hlTTUvMmhCTVMrdGNHeFZEVVp4OHhEYWdTcXNz?=
 =?utf-8?B?eVJONW8yTTByRkFxM1kxL1FpRmR3dWF3MzB3ZW90Z09YZmNJcFRRSkVab0kw?=
 =?utf-8?B?VXkxSTNRRFk4NDlDK1FxUG1XaER4Q3pCVGxlejlHMndPUWZHdndoL2ZuK05o?=
 =?utf-8?B?bS9USk9IQ2d1VTZBdytxSzBVSHJIUVZxTCs2Wit6aWEwM1J2ZlR1b1J1aHJo?=
 =?utf-8?B?Q2RFQWtmU1VCaUFxRFJmM2h2TG9lbzYvbTVKdVNsMmlzWi8yZ2s5NTZ2SXlq?=
 =?utf-8?B?cTczU0hJTnBiRGM2RnhkQzVBanV0eDJmMWVRMGNGUE5acFZoM0pHRVl4cmxU?=
 =?utf-8?B?N0VnRXA4dFNVMEN2RjBubmtsOWtpSFQ4cW5nZHh1WTQzSnp2ZDN5eXZ5Q0hu?=
 =?utf-8?B?VFVTVW5xYkxWQnlMQWVLYzQyUFF4UDZ1QVE1SFBRSkdRUEswc2NCN0JJRFpK?=
 =?utf-8?B?RjNhZDVEYUVTMEdMRVVCV2pUa3A4QUVqeTV0ZXFPMHRRbVVyb2pNQTRQbktH?=
 =?utf-8?B?SktmVi93K0d5RjBzY0RpVWFUY3JxMlI0dFdrblM2OS9NSEtQVmc1SVJTOG0r?=
 =?utf-8?B?Y1hKWjhHS1V5cjQraXoyakRqa1hQeXp4MjBmM1lmS3d5Y3JXenZJSzJGSlhu?=
 =?utf-8?B?d1cydGZhNnpnY2lUdkpxTkdhNVV6TTdxdmU0VVBvUDBJVk1NM014cXVRUnpD?=
 =?utf-8?B?enJ0MVRvK1dXMDJnYWw0c1REMnpFUENTLzl6dEFBc2o4WmJVMjdRUFpmZ1BQ?=
 =?utf-8?B?L3VSS25MSGRDNkx1TngxSkF2SU9ZZ2ZTcEExbjVxdFJLMW16R2IvV1FNTVVF?=
 =?utf-8?B?Ym44bWNqRFdlRDZGWDFMMDJabzNiR3I0YmhQU2VkUGQyL1ZzaUxKN3hYdG5j?=
 =?utf-8?B?RXZ1aE92bnhkRlZWcjNvczFQUi93QVFDU242b2JlN3pJQnh5NW05QlN1bTc1?=
 =?utf-8?B?QlpuRDRQaHo3VHFIa1NZcUtBa1JpR05vZ2VrS0hYUTZZTU4rSWJoVmZmYmdR?=
 =?utf-8?B?bWpyeExjREhCNlA1ck9OV3VLRTFpRzU1S016ZFdVcTR6bTRQVlJ2citheC9R?=
 =?utf-8?B?QUZEOGFyZ3o3b1B1di9ZUG1FZHBCaW1YYWZwRVE4cFJpWFBpRGo2RmJxb1BX?=
 =?utf-8?B?Ui9KT2lpOVdLMDd3a09Tb1MxNkIySDZTTDlpMzlLL2lieUJ3Z1hLV1ppWmFu?=
 =?utf-8?B?ZTVmM1M0WVNET2g5UGMwUVFjTlBiazJvUm5KU1dTak1ZdHpvcFFkcTF5d3Fo?=
 =?utf-8?B?ZVZxUkZvS3pNdkFxZHp6OHlQSHFONUFiaDJCejNTSkY5NGJLckVjbm9qZ1JK?=
 =?utf-8?B?aGpIYzY1MkJCRTNsVTg3eXBzMWlvcDlDT0tFeTN1TS96RGxtSVZsVTNLeDU2?=
 =?utf-8?B?RlFNTDdSTGdtR2NHdzYxQ1FjYUpMTE9qNURUb1pYTHVJL002QUVvN1VGRk94?=
 =?utf-8?B?Zi90a0FXQlZaUkZHL2JYNmRHRFI0TzJYcVdRTU52UU1ZK0FObGw0RGw5U2g0?=
 =?utf-8?B?TXZFODdrYVdGb3YrMzRZN1Mzb2hFMU5hTTczY3YzL3g1dlNuOEFtd1JZY2M1?=
 =?utf-8?B?ZGljc0xoVmtLczRPMmhrakJCZ1g5WGN5VzZ1akZkZktQSjZ5VThhNzFsSEwx?=
 =?utf-8?B?eDluNmNoWG52WmhVaklaME4yUm9Eb3gxM1JFcGFSMitxd2VJeWVrS0s4WlE4?=
 =?utf-8?B?MSt2dmdDT2l3VzFHU2FtbGN5QjZodW5GWnRnUWp4YVM0QWJCTkV4VVJSaTNa?=
 =?utf-8?B?dTczZElPWmR5RTUzN2FvWGNsT3R2QjI1ZzZpQmZOYjJCRHc3cVcrQm84S2JL?=
 =?utf-8?B?ajNqekY4U2lEWXZKajU3ZlZlbEtJOWI2dytRWUV2dkRjQlVuNjlQWWdJQVI3?=
 =?utf-8?B?MEF5VWZXYzVCYlVGUWMxM3hMdU9KNDdFSXowWkk3dTBvMVpDQmVkVlFQSEda?=
 =?utf-8?B?alU0T2NIczNsOTVyRDdaQXV2dlBnSkNCNWVGSTcyamlpTlpYM0IzWVhWY2s1?=
 =?utf-8?B?a3RWUlRsbWo1TFJTQkVLLzJtMHVBNXF5Uzc4aWtFcmZCOWQ5eVRhb2RuNDBU?=
 =?utf-8?Q?j1dmkUftcjUPeK7DSj83xL0+Me6kLs5alxek0PxQKn3K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b02f214b-9999-4b60-9b5a-08dd78f1c1fd
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 12:09:49.6330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 206I9mNGA4OD0HIRRluce7bOfCeudXW1hKzVObRdPq9wqAXnOQIt+ifjmCVQenhEdVKe+nyEXISRXeeSxaPdyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7877

Revocable::try_access() returns a guard through which the wrapped object
can be accessed. Code that can sleep is not allowed while the guard is
held; thus, it is common for the caller to explicitly drop it before
running sleepable code, e.g:

    let b = bar.try_access()?;
    let reg = b.readl(...);

    // Don't forget this or things could go wrong!
    drop(b);

    something_that_might_sleep();

    let b = bar.try_access()?;
    let reg2 = b.readl(...);

This is arguably error-prone. try_access_with() provides an arguably
safer alternative, by taking a closure that is run while the guard is
held, and by dropping the guard automatically after the closure
completes. This way, code can be organized more clearly around the
critical sections and the risk of forgetting to release the guard when
needed is considerably reduced:

    let reg = bar.try_access_with(|b| b.readl(...))?;

    something_that_might_sleep();

    let reg2 = bar.try_access_with(|b| b.readl(...))?;

The closure can return nothing, or any value including a Result which is
then wrapped inside the Option returned by try_access_with. Error
management is driver-specific, so users are encouraged to create their
own macros that map and flatten the returned values to something
appropriate for the code they are working on.

Acked-by: Danilo Krummrich <dakr@kernel.org>
Suggested-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/revocable.rs | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
index 1e5a9d25c21b279b01f90b02997492aa4880d84f..b91e40e8160be0cc0ff8e0699e48e063c9dbce22 100644
--- a/rust/kernel/revocable.rs
+++ b/rust/kernel/revocable.rs
@@ -123,6 +123,22 @@ pub fn try_access_with_guard<'a>(&'a self, _guard: &'a rcu::Guard) -> Option<&'a
         }
     }
 
+    /// Tries to access the wrapped object and run a closure on it while the guard is held.
+    ///
+    /// This is a convenience method to run short non-sleepable code blocks while ensuring the
+    /// guard is dropped afterwards. [`Self::try_access`] carries the risk that the caller will
+    /// forget to explicitly drop that returned guard before calling sleepable code; this method
+    /// adds an extra safety to make sure it doesn't happen.
+    ///
+    /// Returns `None` if the object has been revoked and is therefore no longer accessible, or the
+    /// result of the closure wrapped in `Some`. If the closure returns a [`Result`] then the
+    /// return type becomes `Option<Result<>>`, which can be inconvenient. Users are encouraged to
+    /// define their own macro that turns the `Option` into a proper error code and flattens the
+    /// inner result into it if it makes sense within their subsystem.
+    pub fn try_access_with<R, F: FnOnce(&T) -> R>(&self, f: F) -> Option<R> {
+        self.try_access().map(|t| f(&*t))
+    }
+
     /// # Safety
     ///
     /// Callers must ensure that there are no more concurrent users of the revocable object.

-- 
2.49.0


