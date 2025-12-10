Return-Path: <linux-pci+bounces-42897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3825ACB3241
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 15:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 94B993016266
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 14:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54081322522;
	Wed, 10 Dec 2025 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KLJKJ/7o"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011041.outbound.protection.outlook.com [52.101.62.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8AB1D416C;
	Wed, 10 Dec 2025 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765376834; cv=fail; b=LgkBSQ3jTR6vZ5thptejYMX/oCAxEdGaf4NSOWBkho1HQ7O20lWHyyvOHL2O9YWBcaHprCyvaWKtLj8+aeDfWwr9jCfB11UJr12JYydoUYRUUhWR+ZkLRO4wA5rsfu4VRJ6MiC/EXNEmSQNxrBNzpQG90dJrWnVQe/eQwnEU4Zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765376834; c=relaxed/simple;
	bh=ViqWfz5ZEU4g8wE/SKHTvbFwES2bfo1NtjsDsypkqUU=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=MUSg/GqA6klehlUQwxlZBESTFcb7oIwgcfOVm1lJzzxBRQpxGAEYIeYn8Odorlb/HK0mi/CjtIM6R0i+Cri5Yyv/twav6H4cWbI9+b7EsoZqCpb0KJ5n4JSZr36KQBvI7oVEHLVzX+3ngR4TzcKY+5Qwz0MJDgo4krb0eYEDtL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KLJKJ/7o; arc=fail smtp.client-ip=52.101.62.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wj+/sMK3mrGMH66N44nnfDegs9rJZqItxm0trIqM+qBM1b5+gEj/qmdVkXh5FEoDn9l367pc0pAd4r2RyLS9oolvFaAH85Ysu9owzWGl4gCr4M/OISOu/J5lv5+MvmTBXrZqPe20i8dKeioI0XoBu5zJ0WFK2EHnMQ3PvhtKFNnf7/Q69mZyRD9BDcPw3OwzBwQVOAUDXFlUCSnaSREs4ZlB2vBt9bl+KDhcL9G2Kgu6cds43tSFTKR23PkhCJ6Q6cX9qutetFZHz5+qtjS1t/KGV8S7AnUKP/DbmadYnIk4E5T/ThULISs3zV+wCcxdQXZTntDjHzTlKj/IAJOBZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btYyvZZvwHS4NnLHY3O63HDKxbv3XM62fHYJJGbGukw=;
 b=ZipU2o12LSERbpLJIpAob6CBbMR+NWpLLXx8Qi/XF20RZ+fF1OZUML6XCC+9gMosVDPhWnlzh1yTt/yCxSgBqKUCpIKlt1TbosXGm0Cr6Cs9ymIacfZU+HxSl+2BWlOiU7x3xkPrCxPmAM4j5dET5InTO3jMu+33XEb61uErYjCv7Buk0MoHXedDjv7BK5msPtsV/xuEbgL0vaBjZICkk7MkPbefC2oGtjV4RrS469m+KebwIic/f6mv2B8OFwRf4UVEOCvUpKj9xhpXTwxSr8kZYAWKO2wPxkRK+isA7wgZEew12VoCS0KD5fsGO9qRhbNu7wgPTWIj0D+iUX+ydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btYyvZZvwHS4NnLHY3O63HDKxbv3XM62fHYJJGbGukw=;
 b=KLJKJ/7on0x5JXumb9qR3anKdkqUQsDAf4HkQamK1S9/S8dYNoU2p+cZoWhGFbeY5m2E72p4TMGltRfeUQd8yIpNYV4YbHD1q1HPWvzov/hdichI2g8O5Nf4xK6APeaJGtfoEPcBRqD6wyaPs9jNWrApGXJgdi4hk8iYR86nt51kWQNzm5AFlZGhBmCH4nryfdn5m74hU4iNh5kn/XkYoeYQIS4j9AB4bouKMp/fgMTp74vNIt8BsxG3ie9w7iybBlo8zgScTKSfx4gqmDTRj2hzuKF0TfCLs4RYhBEfkKQ6HSlzRe8v6R2r3ZXUT3QhvTT2pXRmKgy66GE1jOY0sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8187.namprd12.prod.outlook.com (2603:10b6:610:125::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 14:27:06 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 14:27:05 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Dec 2025 23:27:01 +0900
Message-Id: <DEULURWNK2ZP.1GGKEII07Q1IE@nvidia.com>
Subject: Re: [RFC 4/7] gpu: nova-core: populate GSP_VF_INFO when vGPU is
 enabled
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Cc: <airlied@gmail.com>, <dakr@kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <alex@shazbot.org>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
 <jhubbard@nvidia.com>, <zhiwang@kernel.org>, "Nouveau"
 <nouveau-bounces@lists.freedesktop.org>
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251206124208.305963-1-zhiw@nvidia.com>
 <20251206124208.305963-5-zhiw@nvidia.com>
In-Reply-To: <20251206124208.305963-5-zhiw@nvidia.com>
X-ClientProxiedBy: TYCP286CA0298.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: 088effcd-3877-45bb-8d49-08de37f83137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2FoQmlLakFrSTJFTXdqOTN0aHVETXdlQ2ZCNngvTmt2RmZTZHNRMkpIUnls?=
 =?utf-8?B?WTVlQ2FnNTlhemVDdXB4L1dhRXpaVktNV2VQZ1RWTFhaTWtpUklsSmVLQzBQ?=
 =?utf-8?B?eXBjOHc2VngrajFoekhNVkMxclBwSUxCQ1N6UHhzaFBjcFZkVlpoanZ1TC81?=
 =?utf-8?B?R2NpanhhRFRldjN5TzhpN0ZqekNoOTArVG81cS9SQnNCUnVobHZkSXJybjZ1?=
 =?utf-8?B?TUNpZmdtdnBCYXFENkdiTHJLZHMvRmNmQjdPYkF1QlhUZ2NVSXFxQVc4Q21P?=
 =?utf-8?B?WStqMlpoaWp0cVhjS1JZbldST3NlaWloRklreTZOWHpNdVVsdmFtc1MxRmxr?=
 =?utf-8?B?cjlHbzdJUXpsTUtZazJTeDUvNzgweEtUWFdsUVg0TDQ5Zkk4NVd6c0F5VFJ3?=
 =?utf-8?B?U3pWc0tRd3pvck50Z2JKeElVWlVud2UxajU3dlBEeVBZTUN4YUtFUHVGYmY4?=
 =?utf-8?B?VU5za2k3dHRldko0d3oyb2dLT21RL2VmbEFNV0x4N1VkemFlcitXUnJDNHBR?=
 =?utf-8?B?d1NmVEwwS2JETENSSHhrMXY5Q1ZrK2dKeGg2NjNhdDVWZ2xiOHp2SFl6OTk5?=
 =?utf-8?B?bUF0V2hwNC9icHozanpFYlc2MUxRQXlBUmVUNFU2QTE2V1dLSXZ0Sm9IQzFo?=
 =?utf-8?B?V2t3Wm10YlIwQUlhcDVXU25UL2xtMmEzaitWd3VLY3RUTEVtSkc2amxNU3BC?=
 =?utf-8?B?RFFWcEI5d1psYnoyV3FBNDFkdXpCdHlnYXdORjZDR01XMjNyK3BMTHRJbjdW?=
 =?utf-8?B?cUVuUVp0R1pMU3ZkWlNJZ29uQW41OHZoUzRjVjIrUWVwSlhsNzhWTmVDMlJn?=
 =?utf-8?B?bjdzR2k0SG9PNzFndlhWd2ZnN0o4eE50enM5T1hOY1ZMUDR2aWRiR1RwbW1P?=
 =?utf-8?B?UmxJRlRqbHAxSmt6VUwvR0t1M0lHNkFDQ3lWL2RYZHRnMG1TOFczQlMwV1VQ?=
 =?utf-8?B?dmUycXVBcnFCMUM1Y0dKUmNYL0ZZSm96WUY2WUdTQ0haQkUzNkRrMzJvdEN2?=
 =?utf-8?B?MHVWWS9jcHltT1RibStGUVRtWTRUQitSWGlURnVFa2IrbkhHZEZELzZTcWVY?=
 =?utf-8?B?TE91UEVEY1ZucXJHR1psdzhtbTFEVDI3akpGaXR1QlRnSGhiRkU3bVZnajAz?=
 =?utf-8?B?a25ld0NPR3dGSjhyVFBtN08zSFF1b0VNalVSamNqYWFoVkpROGFCR2VLZm9n?=
 =?utf-8?B?UkFaVURBYjlQL3ZKWEdVb1Q2Q24vcHRqRE5MVXpJWi8xTmxQNWIwdVBGbDdO?=
 =?utf-8?B?K2JpZXVEMkI1bVM4YXpxRzJyRnkvblgwaCtEOVBEQmdHazBSQlNwSERkMjVr?=
 =?utf-8?B?VklTcXhESzN4MWFEYlBJTW53Z05NMzBDWlhvRXR4bGdHRkx6MWhKc1Zsa2No?=
 =?utf-8?B?Z3RhNlBEQi9jSXM0SzE3Ni9TbzF5a0Z1TzJXdFJpYWxlZXRBcUVoSTVqNFB4?=
 =?utf-8?B?NW1rK3huUnJiMVlrRXluUGk0Z2lMQW5YcFpWY2lGSXgyQ2w1Z2hqb1dtS3Ey?=
 =?utf-8?B?bXlqdXNPbXhWODRnR0VodEt3akNYSWY3bEU5NzgwM3Ayb1BPY05SVHFtb2hG?=
 =?utf-8?B?TXJUNk9zZnZyWFk2NFRiUGNBblFjK29XZzlZdit1SGhRdkp1U2g1VkswY01x?=
 =?utf-8?B?cjhVUHlZZWR6c0h3NlJEVUI1R3kzUk44dXI3TnpEN3lNQ0NFU29nazN0TTZp?=
 =?utf-8?B?YitHTTZKUlJRYTdLSDBiejdiaXdjMUV2aW5hSDFtbDZZZDFvcHF0bmdROVN6?=
 =?utf-8?B?M09wTCt3TUM5S0c1eXlDWW9QQ0ZhaWMzKzQ5dkd1b2hCUkNxUlFYcUpzaHQ0?=
 =?utf-8?B?OW1yU1pSYWVGYjkzQ3doNzFjdDZ0bmJYckxlZ0c1VVZFc0FVbG40OTFlWE1F?=
 =?utf-8?B?aml1QlRMVTA4K2o1OXU0ak9VSnlSWGN5aEFVdzZ3OTJ5eEdLSE8ycDlnZ1BU?=
 =?utf-8?Q?denyFCvV2JjWR4hrEZHLfZAScv7B+tgD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2V0M3liSkxxNXlnQ0lFN05KNXBtR285VUs1OTNVNDFaMG5UUXFHZDdkOTBl?=
 =?utf-8?B?ZTJLRnFaSU1KWW50dVRGby9wQ1ZOWk93RnFLR0pkbUI4anhFSmM0ZmJhU2JJ?=
 =?utf-8?B?Y0x3NnpzNStNVkNwS0NROWFjU0hqTDdFLzdSOXJXVjdyTm91Q2dGMFprZHM5?=
 =?utf-8?B?a29MV25CNDVzN3pBUWlhL0JsSkdwMTFWSGs5WDNSci9DQ056M2R3ZWZwT1NM?=
 =?utf-8?B?WWhkM0xCUFpnNzYraElwVllRdmtVbFA3K2wwcnB4UmFWTG53RkN0ZG1lWXdF?=
 =?utf-8?B?aWR6V0Z3NDNVYWtTaktsR0dubE5ERWd5L3pNK1VNV2hSMFBDaGczRyttK3hj?=
 =?utf-8?B?YUFqR0JmVExSc1Y4cS9abno4ODZYYklwZFZZTTR6N2IvR0FsZnZlaUlWSExw?=
 =?utf-8?B?MTdaMERENWIwZUVnakwyemI5OEQwaml5eTR0d01HdnY1SkxXRVdoeVdCMElU?=
 =?utf-8?B?ZTJldFZnb2xDM2t2ZEtJVGZTVUJpazdvS0ViRjlmNG95NkRDUUdmVFdTdThP?=
 =?utf-8?B?bmZ2S3hKWVJxZks3bXFaVTJESm05Mjcza2N4NFMyd3NOVmxENkhtcHBpNlI3?=
 =?utf-8?B?UDIxWTBJMFIyaWdsMEhMYzkwamxZdlV5bElOWGt2TXFzZkdCSlZoZ0RKSEVP?=
 =?utf-8?B?QVdQVk11dEoyT3VNZktTZlQ3NlV3ZWZRbVhrb1g0c0xabFIxalF2V1g3M0VR?=
 =?utf-8?B?QmdHeHRGS3hHcUpIUzZMdkJZOTVOekN3dUlpb1AwMmdFamRIcmdKZm9MRVRD?=
 =?utf-8?B?M0xSQ2FndWd6emJUVkR6OVVlaW5tenc2bk1pbHNHMEtOczNpNkdsd2EvOTE4?=
 =?utf-8?B?MVVhYksyMFJKc3piSkpPL2VMMy9aZlE2MkdDaXZZdEFhTjdMeW5BZDltNGZk?=
 =?utf-8?B?QjF0cWd6b2oxbjZZT1hCamttZjBZMTdDcXJjeUhYamhFQmR5QVZ5aENrZ1pI?=
 =?utf-8?B?eGE1NDRGSGt3aTlXcXExSUIxMFJ5R0VZV2poYlR3TFpCb2JsVERjMnB1WkVG?=
 =?utf-8?B?czlRUXpOY054Q0NwRE9oOC9qaGhBNW92MGZEaDRYOGFqTk50aHpVa3RzUTdC?=
 =?utf-8?B?TjNtVG1nTlVtRGRpMjluN3hsRTVQcGhXYnBLWTJjeXlJc240b0JLT21CWkJK?=
 =?utf-8?B?SFlKeXQyWG5keWMxQXRkOHJ3MVV3OURFMVVBazEvZVFEUHJoaFYvNS9GV3c3?=
 =?utf-8?B?SXFRK1krZENRMkJWa3I5aEhTY2F2WVpOZjhWZ3RtMm9nYlFzM1E1WDhzUEVm?=
 =?utf-8?B?SldSMGdRYVpYM1pkRFhpNjdXcGNQQ3VkWkNDd24waG5DVmVWd3hlbldsbzln?=
 =?utf-8?B?NC8zL3B4YmdXeXdxN0JoM0JVRjdIVWxqR0VzS0lJU3BxcHB4WUVOKzJiTEh3?=
 =?utf-8?B?aWJqSHNTc2trQU1nNEdicTdsOEtJWXZmQ1JFYitJbE43UklDa2oyYzEyc20r?=
 =?utf-8?B?em1mdTdkalhXV3FIVHhrRlBTY0M4OWtBVXRyTm5XR3ZRdlVERW9qT3FGQTUw?=
 =?utf-8?B?UWxkOHhmcWlvVU5NRVpvTURBK2MxZEhIekJ6QkFvVm80R1ZnSEs2MzZwVlM4?=
 =?utf-8?B?UFU5b0NlNWRzb3pxRVlpUFd4WHpNTnQ0YkdLVm03dUd6Z3NKUkJmaXNyR0l6?=
 =?utf-8?B?Mng0WGRBK1p4d1JiU1NiK1NOUjRDQTB2YmtGWFRzZDdUWjQ5OHF5eDhPdlBt?=
 =?utf-8?B?RElvUklkK0c1Qkl3N1p6bTRUMmI4WGd6WE5yRWVtMllnTkRhYmo4WDlUT21m?=
 =?utf-8?B?SWhLWlFSSDFaUEFNSk1rM00rRHhHVFR3eTJjeFcxVnBDQ2VvTGs5M2wrSFpF?=
 =?utf-8?B?bUZ1QkYvVU9zRXM0MHh6THJTd2FRTWxRaXB3YzREOUFoTlI1Z0IycXczRlc0?=
 =?utf-8?B?YWxhZjc0Qm1HUnVPQkdpYVdoOXJHUmpwSVFTUThiY0djWjhUMHJHbDBEV1BW?=
 =?utf-8?B?NHhLNHF5YlpQeWc3R1Q0MS8rTzMwOGMyNHVXMDlXNlV1RXVSVHhJMms2VTZa?=
 =?utf-8?B?bmpsaSt4dGJrMTJNZnFsN3dBN1dHRGRvVjRWTGlkM0FxVnk1dG5welI5MFo3?=
 =?utf-8?B?N00wNStoVTUwOWpjNjQxRmNxcnFpaDZhRzliYlZjbnBiMk9zaE5mbDIvNU9v?=
 =?utf-8?B?QTdkV3orM3diaU1QTmRiMDhWRjFXYlJhSVJtNy9VUVNVakNWdGcvZGxKM2s1?=
 =?utf-8?Q?XEDqZjxqhwhRIfKQmwI/fJN+E24+3JtBNfHAHH0XrG1B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 088effcd-3877-45bb-8d49-08de37f83137
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 14:27:05.4684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gx8hzsFlZReGA6D6MJgz7D64abahIgnyWLIJZtvi57cgJgmR2oySIXJUQtNt5KQLfKGwNiX9JdLeqH1hDIavDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8187

On Sat Dec 6, 2025 at 9:42 PM JST, Zhi Wang wrote:
> GSP firmware needs to know the VF BAR offsets to correctly calculate the
> VF events.
>
> The VF BAR information is stored in GSP_VF_INFO, which needs to be
> initialized and uploaded together with the GSP_SYSTEM_INFO.
>
> Populate GSP_VF_INFO when nova-core uploads the GSP_SYSTEM_INFO if NVIDIA
> vGPU is enabled.
>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  drivers/gpu/nova-core/gpu.rs             |  2 +-
>  drivers/gpu/nova-core/gsp.rs             |  8 ++-
>  drivers/gpu/nova-core/gsp/boot.rs        |  6 +-
>  drivers/gpu/nova-core/gsp/commands.rs    |  8 ++-
>  drivers/gpu/nova-core/gsp/fw.rs          | 75 ++++++++++++++++++++++++
>  drivers/gpu/nova-core/gsp/fw/commands.rs | 11 +++-
>  6 files changed, 102 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index 10c5ae07a891..08a41e7bd982 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -285,7 +285,7 @@ pub(crate) fn new<'a>(
> =20
>              sec2_falcon: Falcon::new(pdev.as_ref(), spec.chipset)?,
> =20
> -            gsp <- Gsp::new(pdev)?,
> +            gsp <- Gsp::new(pdev, vgpu.vgpu_support)?,

This seems like it is making the whole `Vgpu` structure introduced in
the previous patch superfluous, since its sole purpose is to pass the
`vgpu_support` value to `Gsp::new` - we could just extract that value in
`Gsp::new`, or better in `Gsp::boot`, where we actually use it, and
avoid storing it in 3 different places.

> =20
>              _: { gsp.boot(pdev, bar, spec.chipset, gsp_falcon, sec2_falc=
on)? },
> =20
> diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
> index fb6f74797178..2d9352740c28 100644
> --- a/drivers/gpu/nova-core/gsp.rs
> +++ b/drivers/gpu/nova-core/gsp.rs
> @@ -115,11 +115,16 @@ pub(crate) struct Gsp {
>      pub(crate) cmdq: Cmdq,
>      /// RM arguments.
>      rmargs: CoherentAllocation<GspArgumentsCached>,
> +    /// Support vGPU.
> +    vgpu_support: bool,
>  }
> =20
>  impl Gsp {
>      // Creates an in-place initializer for a `Gsp` manager for `pdev`.
> -    pub(crate) fn new(pdev: &pci::Device<device::Bound>) -> Result<impl =
PinInit<Self, Error>> {
> +    pub(crate) fn new(
> +        pdev: &pci::Device<device::Bound>,
> +        vgpu_support: bool,
> +    ) -> Result<impl PinInit<Self, Error>> {
>          let dev =3D pdev.as_ref();
>          let libos =3D CoherentAllocation::<LibosMemoryRegionInitArgument=
>::alloc_coherent(
>              dev,
> @@ -156,6 +161,7 @@ pub(crate) fn new(pdev: &pci::Device<device::Bound>) =
-> Result<impl PinInit<Self
>              logrm,
>              rmargs,
>              cmdq,
> +            vgpu_support,
>          }))
>      }
>  }
> diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gs=
p/boot.rs
> index 54937606b5b0..5016c630cec3 100644
> --- a/drivers/gpu/nova-core/gsp/boot.rs
> +++ b/drivers/gpu/nova-core/gsp/boot.rs
> @@ -33,6 +33,7 @@
>      gpu::Chipset,
>      gsp::{
>          commands,
> +        fw::GspVfInfo,
>          sequencer::{
>              GspSequencer,
>              GspSequencerParams, //
> @@ -136,6 +137,7 @@ pub(crate) fn boot(
>          sec2_falcon: &Falcon<Sec2>,
>      ) -> Result {
>          let dev =3D pdev.as_ref();
> +        let vgpu_support =3D self.vgpu_support;
> =20
>          let bios =3D Vbios::new(dev, bar)?;
> =20
> @@ -162,8 +164,10 @@ pub(crate) fn boot(
>              CoherentAllocation::<GspFwWprMeta>::alloc_coherent(dev, 1, G=
FP_KERNEL | __GFP_ZERO)?;
>          dma_write!(wpr_meta[0] =3D GspFwWprMeta::new(&gsp_fw, &fb_layout=
))?;
> =20
> +        let vf_info =3D GspVfInfo::new(pdev, bar, vgpu_support)?;

This is a strange constructor. It initializes the `GspVfInfo` if
`vgpu_support` is true, and returns a zeroed structure otherwise. I'd
rather have an unconditional constructor that is only called if
`vgpu_support` is true, and store the result in an `Option`:

    let vf_info =3D if vgpu_support {
        Some(GspVfInfo::new(pdev, bar)?)
    } else {
        None
    };

It will become clearer later why this is a better design.

> +
>          self.cmdq
> -            .send_command(bar, commands::SetSystemInfo::new(pdev))?;
> +            .send_command(bar, commands::SetSystemInfo::new(pdev, vf_inf=
o))?;

As a result of the previous comment, `SetSystemInfo::new` now takes an
`Option<GspVfInfo>`...

>          self.cmdq.send_command(bar, commands::SetRegistry::new())?;
> =20
>          gsp_falcon.reset(bar)?;
> diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-cor=
e/gsp/commands.rs
> index 0425c65b5d6f..1d519c4ed232 100644
> --- a/drivers/gpu/nova-core/gsp/commands.rs
> +++ b/drivers/gpu/nova-core/gsp/commands.rs
> @@ -26,6 +26,7 @@
>          },
>          fw::{
>              commands::*,
> +            GspVfInfo,
>              MsgFunction, //
>          },
>      },
> @@ -36,12 +37,13 @@
>  /// The `GspSetSystemInfo` command.
>  pub(crate) struct SetSystemInfo<'a> {
>      pdev: &'a pci::Device<device::Bound>,
> +    vf_info: GspVfInfo,

... and this becomes an `Option` as well.

>  }
> =20
>  impl<'a> SetSystemInfo<'a> {
>      /// Creates a new `GspSetSystemInfo` command using the parameters of=
 `pdev`.
> -    pub(crate) fn new(pdev: &'a pci::Device<device::Bound>) -> Self {
> -        Self { pdev }
> +    pub(crate) fn new(pdev: &'a pci::Device<device::Bound>, vf_info: Gsp=
VfInfo) -> Self {
> +        Self { pdev, vf_info }
>      }
>  }
> =20
> @@ -51,7 +53,7 @@ impl<'a> CommandToGsp for SetSystemInfo<'a> {
>      type InitError =3D Error;
> =20
>      fn init(&self) -> impl Init<Self::Command, Self::InitError> {
> -        GspSetSystemInfo::init(self.pdev)
> +        GspSetSystemInfo::init(self.pdev, self.vf_info)

And here things become interesting: you can leave the constructor if
`GspSetSystemInfo` unchanged, since vgpu support is not strictly
required to produce a valid value. But you can also chain the
initializer to add the vgpu information when relevant:

    GspSetSystemInfo::init(self.pdev).chain(|info| {
        if let Some(vf_info) =3D &self.vf_info {
            info.set_vf_info(vf_info);
        }

        Ok(())
    })

(more on `set_vf_info` below)

This results in less code overall, and better conveys the fact that vgpu
support is technically optional.

>      }
>  }
> =20
> diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/=
fw.rs
> index abffd6beec65..a0581ac34586 100644
> --- a/drivers/gpu/nova-core/gsp/fw.rs
> +++ b/drivers/gpu/nova-core/gsp/fw.rs
> @@ -9,8 +9,10 @@
>  use core::ops::Range;
> =20
>  use kernel::{
> +    device,
>      dma::CoherentAllocation,
>      fmt,
> +    pci,
>      prelude::*,
>      ptr::{
>          Alignable,
> @@ -27,6 +29,7 @@
>  };
> =20
>  use crate::{
> +    driver::Bar0,
>      fb::FbLayout,
>      firmware::gsp::GspFirmware,
>      gpu::Chipset,
> @@ -926,3 +929,75 @@ fn new(cmdq: &Cmdq) -> Self {
>          })
>      }
>  }
> +
> +/// VF information - gspVFInfo in SetSystemInfo.
> +#[derive(Clone, Copy, Zeroable)]
> +#[repr(transparent)]
> +pub(crate) struct GspVfInfo {
> +    inner: bindings::GSP_VF_INFO,
> +}

You can use a tuple struct here (i.e. `struct
GspVfInfo(bindings::GSP_VF_INFO`).

Also none of the derives should be needed eventually.

> +
> +impl GspVfInfo {
> +    /// Creates a new GspVfInfo structure.
> +    pub(crate) fn new<'a>(
> +        pdev: &'a pci::Device<device::Bound>,
> +        bar: &Bar0,
> +        vgpu_support: bool,

As mentioned before, we can drop this bool argument.

> +    ) -> Result<GspVfInfo> {
> +        let mut vf_info =3D GspVfInfo::zeroed();
> +        let info =3D &mut vf_info.inner;

It is generally considered better practice to avoid mutating values we
initialize. By starting with a zeroed state and then initializing the
members, you are at risk of forgetting to initialize some.

What you should do is initialize your `GspVfInfo` in its entirety in a
final statement like the other command structures do, storing
intermediate values in temporary variables if needed.

> +
> +        if vgpu_support {
> +            let val =3D pdev.sriov_get_totalvfs()?;
> +            info.totalVFs =3D u32::try_from(val)?;

We should be able to avoid this `try_from` once `sriov_get_totalvfs`
returns the correct `u16` type as suggested on the first patch. :)

> +
> +            let pos =3D pdev
> +                .find_ext_capability(kernel::bindings::PCI_EXT_CAP_ID_SR=
IOV as i32)
> +                .ok_or(ENODEV)?;

`pos` also seems to be the wrong type - it seems to me that it should be un=
signed...

> +
> +            let val =3D pdev.config_read_word(
> +                i32::from(pos) + i32::from(kernel::bindings::PCI_SRIOV_V=
F_OFFSET as i32),
> +            )?;

... but I guess this comes from here - I understand that
`config_read_word` takes an `int` for its offset parameter, but when I
read the C code I also see checks that return errors if that offset is
bigger than 4095. What does the PCI spec says? It seems we can go with a
`u16` for the offset, which would simplify this code quite a bit.

Also please don't use `as` whenever possible, there are utility
functions in `crate::num` to do the conversions infallibly. You will
probably be interested in `u32_into_u16` for this method.

> +            info.firstVFOffset =3D u32::from(val);
> +
> +            let val =3D pdev.config_read_dword(
> +                i32::from(pos) + i32::from(kernel::bindings::PCI_SRIOV_B=
AR as i32),
> +            )?;
> +            info.FirstVFBar0Address =3D u64::from(val);
> +
> +            let bar1_lo =3D pdev.config_read_dword(
> +                i32::from(pos) + i32::from(kernel::bindings::PCI_SRIOV_B=
AR as i32 + 4),
> +            )?;
> +            let bar1_hi =3D pdev.config_read_dword(
> +                i32::from(pos) + i32::from(kernel::bindings::PCI_SRIOV_B=
AR as i32 + 8),
> +            )?;
> +
> +            let addr_mask =3D u64::try_from(kernel::bindings::PCI_BASE_A=
DDRESS_MEM_MASK)?;

This `try_from` will always fail as `PCI_BASE_ADDRESS_MEM_MASK` is
negative. This is a case for a legit use of `as` (with a CAST: comment),
although this is also a case for us generating better bindings. :)

> +
> +            info.FirstVFBar1Address =3D
> +                (u64::from(bar1_hi) << 32) | ((u64::from(bar1_lo)) & add=
r_mask);
> +
> +            let bar2_lo =3D pdev.config_read_dword(
> +                i32::from(pos) + i32::from(kernel::bindings::PCI_SRIOV_B=
AR as i32 + 12),
> +            )?;
> +            let bar2_hi =3D pdev.config_read_dword(
> +                i32::from(pos) + i32::from(kernel::bindings::PCI_SRIOV_B=
AR as i32 + 16),
> +            )?;
> +
> +            info.FirstVFBar2Address =3D (u64::from(bar2_hi) << 32) | (u6=
4::from(bar2_lo) & addr_mask);
> +
> +            let val =3D bar.read32(0x88000 + 0xbf4);
> +            info.b64bitBar1 =3D u8::from((val & 0x00000006) =3D=3D 0x000=
00004);
> +
> +            let val =3D bar.read32(0x88000 + 0xbfc);
> +            info.b64bitBar2 =3D u8::from((val & 0x00000006) =3D=3D 0x000=
00004);

Magic numbers baaaaaaad. Let's define these as proper registers.


