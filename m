Return-Path: <linux-pci+bounces-34398-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B32BB2E3EB
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 19:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75D461C83F11
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 17:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC1D3451BB;
	Wed, 20 Aug 2025 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oghlp738"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE08A3375B5;
	Wed, 20 Aug 2025 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755710426; cv=fail; b=quXwjbQwjSLhBKZ6pWdNBvWXzf3aapUE/ENWSdo7fOhmjPYpPThYZMNq4Tab9HzMJSo+wfH/kTj28P/YOTg/9jlQtBjU50B/OTKHdhFo+wQA5wF3+H6RltJRAAn3bHdW6pOurjDlOIDrg8UTmVI48eWJ3S60OZ8FVhSwGOk+pYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755710426; c=relaxed/simple;
	bh=QThzFThrYU3TNHQiixPYLLDXir056qXWau3IeMsKpPU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R6/HkQEw3YT8qSAH84IoGPAl8spRiqRqYrEdug/OwysjVas/yVtzWswxWwrazXizbZwm38olGEs8NWnl4KjpevwlVZo4lemKRWsJrINmSyStpJXzA+kU3a31uWrYdEekWx9C8Y4Nmaedx4yXN/4Zyohg3mFBQW72JK3nnReqTjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Oghlp738; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQwmoBSISfVw2boLFr0aS6sKw7/wiJRRp2WjQDpP6vav1CUjctIfshnpDDnnZNa4Pm6NQANVkIea5ulXkUW1I9PA7F6M6+XLClM/K8zxahE9Ene0PD1YRVAAi8UhJXNNpzm0yBCcylIFOIRzw6ghiAlshMrmGH0IXMOQgcJy6dsXGNOmGYEjVBXuLYVHY4zgZh+vjN7QdnBBEr5vO+0TsKtUqlVxfbWquYrTtMQ3TlKGsrYPeVCVkAv7dTL2UZxSyNg1EATVe2BfGgM5CMD+8VDQ2BzKa7OXqjRPhXKvkVPySf/UcgP99+FRmvU7I2ZkUx5WZ6elxq3pWxY+xhS3YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cBOXmIfc2FTVOq20P2HcEaGb+7OrdUKcycu94ckPs8=;
 b=GZFM5kxgrGeJdYKfs5+XOghXcHCgR1MYn6qZW70vSeNA07vuW7YdfqeoDfWw6hGZbN4q+zuu2Y3xQeQOstzLIUzP7WNJzX/oihG84GNxNA/UHRArJAloEZCLevUYh6tDP/XdDh77340WH4GI2qqBK8EF0Ll/2zt+wtYzN7z4h9W98/sxTxNiDVTp+RUkie6yQjIs+n8zclzziLaV4NfexU/olODD+3PP8ZnMqrOJTjp+jKwALiLnnBHDTKGLmZZwrcpJ0N5XnAO8yqW+x+cvkfhJ9U2zIED/y7d1I2/SK0V+Z5Mxw8fDaQe/6Dy44QM17UbUvuYJY0jQPDCNylgMAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cBOXmIfc2FTVOq20P2HcEaGb+7OrdUKcycu94ckPs8=;
 b=Oghlp738eI1WD/GNL5DexwMXQEXEtfyzZap6uvBaDAZT6hcZi5QqyW3dWwzw5t6B1m1EEoIthLm4VmcmN1TRHVDJm+1/1nTne7ewStc1oL4rJ5Nv9m4esUfGhI90hckNGFY9k/4+UpckInb8sDSjC+SQWxuCHaEWyI6GbmM8ULUb0vxdhhwreSZvspgh+xP1h1P9qG+BH72xwHFDx6tV/AbgyTIqpFxt4XGm75YT0LxqmjG8rInEBxAZYV8OISS505k/uVufdrt/ZqV+0PGLunSyJwyheAQhXMVCe66laxGVs/+Mvkl8emL7oKDeMn7lc96kFqxke3dHht55Vl4dRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0SPRMB0001.namprd12.prod.outlook.com (2603:10b6:8:cf::8) by
 IA1PR12MB7758.namprd12.prod.outlook.com (2603:10b6:208:421::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 17:20:19 +0000
Received: from DS0SPRMB0001.namprd12.prod.outlook.com
 ([fe80::49ad:aa8b:a8b2:450e]) by DS0SPRMB0001.namprd12.prod.outlook.com
 ([fe80::49ad:aa8b:a8b2:450e%4]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 17:20:18 +0000
Message-ID: <fa1c51af-a517-4a04-a5dc-72e4410063ee@nvidia.com>
Date: Wed, 20 Aug 2025 10:20:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] rust: pci: provide access to PCI Class and
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
 rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20250820030859.6446-1-jhubbard@nvidia.com>
 <20250820030859.6446-2-jhubbard@nvidia.com>
 <DC78ENI8QVIO.1AU7LK858YKTM@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DC78ENI8QVIO.1AU7LK858YKTM@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::21) To DS0SPRMB0001.namprd12.prod.outlook.com
 (2603:10b6:8:cf::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0SPRMB0001:EE_|IA1PR12MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: 45aeb672-902a-4c7d-6b50-08dde00dd605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dm04TVhncHdWc0p0SlpZWW9WdWFEUEtHbG1zOHp2QzBqMHdXeVVUOGhMTjZP?=
 =?utf-8?B?cjB3SzNHRnlJSWNwL1RZNll3Y0JXb2R6RnRUcUdKQWZlMUZVTktHSUd4M3pq?=
 =?utf-8?B?cXE0elZEME13V3B5VDhhWm8yekpZRmt4czYyc012dk4xSVE2QWN5QjhjMC91?=
 =?utf-8?B?ekRpZEhjMWVwZnZ6SXFJbndjWXZlbzZpWjkvZEtZUEFqVXdXNFo1TFdoMkRI?=
 =?utf-8?B?Y2FZYUp6QWUxVm0wVTk4TkxBdDRPTFgxMDhQOVRGd2tyZkpacmhNeXI1blIz?=
 =?utf-8?B?aHhCalRjYmdmYjZ2ZktvVk4yNzhncFI2RW8ybWpJdU93MkNjOXJMKzJuMEhu?=
 =?utf-8?B?UXRBRSthbGFBcFNCZTR1WTJJaFZRNVVibGJ1WENZaWV1anNnTnJzczZYZFp2?=
 =?utf-8?B?MkkxR1BRdDlZTGFhSzhxOTAzNDY3aVdkRHl3dnRVMVZ5emRDWVVibUEramQw?=
 =?utf-8?B?RDY2YnQyRXJySklOWlBSNzExTFRwSUtSUTNneXVieUpiK0l2cGdsVjBlLzAr?=
 =?utf-8?B?Z3Fsa0F0Y2pZTFV5UnQ2ZGUzK00xL2hQb0cralJmSlQ2RUFRL3VXa3FKdmo0?=
 =?utf-8?B?MWd3dm9iS0NSa0tVdzJMSzZ0VVZ5L0NLYmZvUUU3RTJqbHVTUURwVjdrQkN4?=
 =?utf-8?B?VGJaR1U2YjVPOXZqdUZhemN6R1RLb1d0UXdoVTl5dGQweFZNZW5Dc3NodGNJ?=
 =?utf-8?B?WXhyS0ZiaFNKOGtaREVQRnFMakNndm9hNXVhSmp4UXI2ZC9MclRPbFFwZm1K?=
 =?utf-8?B?bWZINHU0YVA3S2Q0cENLTjlpZ2p5L0JHQmZ1WjBRd204aEt5eVdnNmcyR1Q3?=
 =?utf-8?B?cU5KMnl0UzlMYWF5ZTNuT3dGK0xENnI2cDJaVVU4ZVZGV2xkSnNLUmdwWk1h?=
 =?utf-8?B?cWpobmFoZlBIOXdzeUpOZUNrQXY0by9PY3lUSER2QnFWWk9ScVVGMmtqM2Zj?=
 =?utf-8?B?MzVMQS9rN2s3bFpCMVk0UjhZQk94WlFFalZUWTdKWHZNdHZOSmZuOUJjSnJa?=
 =?utf-8?B?Wk5nZFgvbW1rYWMwYWZYeFBSQWFnaFI4bUhLZ20wdTIxSUxMNmJuN25QbmFo?=
 =?utf-8?B?THJFMFJaR01Eck0vNE9YUlpQZS91L2lxbHZFNXNlRUlNbTZhOW4xcVRrRS8x?=
 =?utf-8?B?d1ZHMURJcURXZklGSng4TkxweXRqYzNNQTFGa29QVFBtK3VDSW13SGlja2g4?=
 =?utf-8?B?Rm5VbnRqZnFtTjlhajJzanEvVGtCbEVuME9hTXMyTXJZenJQcHlLbEk2V01q?=
 =?utf-8?B?Vi9JLytTTmk2bnY5aExwRWdCbXk3TGZNSWlhbXMvUDNURlJPeXFTQng3NElH?=
 =?utf-8?B?bUI5WGNaeTVSLzdhRmRaVlppbXA1R3BCbGw2OXoxMGhKSGpzWFFGc0I4VGZF?=
 =?utf-8?B?M0FRbGU2clhBbXdXZjMzZVpuelZTSnMwNDQrVXRVdUtVNnl1U3NyOEtJL3gy?=
 =?utf-8?B?WlJFcUR0V0YrYlh2VUVLSGdxRjZUMDlzWERDSERvbUdpY1loLzVJbVFHNU5S?=
 =?utf-8?B?NlJCQ2JxMGpSUndaZXR0OFo1TTZaSnVWaUVEQ0V0dy9zWTB1R2x5VGsxb09I?=
 =?utf-8?B?RFZmY1p4bVdzZHFERUFVUmdqNFFNWWh4eHZoTDVYNDByMGVhODEyNEpNT21G?=
 =?utf-8?B?WEVJM3RFd0VWM251c1lmOVgvRVY4REFJQmVETlpFeVJSMjN5ZmdrOTI3Y2Qr?=
 =?utf-8?B?T0RmVitEWUEvRnQzZzd5RUZXb1VUK3NmejZFN1F1KzZ6UEREaCtuNHRZZ2Iw?=
 =?utf-8?B?dXpBdFNyd3hSRXkwTzNWRVpzMjh5WGM5dm1zeCtnUUhpV0JoQytWWDB3ZDkw?=
 =?utf-8?B?amc0a28yNExhWUwyb0hhUHRhNjh1RkUxZjFEbkdTMFZoU3NtNzhKbUNScytX?=
 =?utf-8?B?N2VmSTQ3Z2pxOTNmNy9pcVVHZHNPYUdYeDN4MnNYa21kcWlQWm0vRjBTbllV?=
 =?utf-8?Q?jwDRkEP9Lhc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0SPRMB0001.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlVwR1RjQ2JLVmdNd1FPbDVEWHA0K2Erdmlyc1A4VnhDTlVzMWhCT0plWFhW?=
 =?utf-8?B?dlA4NmZpMEdqS05aTnYxcUtWek80WlNkV1dmdFlUL0QyK0tzZEt6a2dseldL?=
 =?utf-8?B?NEpqVUVoeDVsUnA5c25kcjZsSUF0WmJYeTIrOHV0MHdtNDRnRVh1OUt1a3N2?=
 =?utf-8?B?Tk9FQWMvS2pmemdmM3NZYXlxM1g3R3AvWHozWDAvS2hlK1o3dlJWcExTWi9Y?=
 =?utf-8?B?V2crMzNmSjM1TklYTnBnbFg0aXcwSW1ObXl0UEJXMHNBNjVYRE5kTFJ3dWtk?=
 =?utf-8?B?NExab3o4emlXMVZXUEZGMVFTUXBIQkxJeDhuUDVZY0Y3cC9BNnBtMytBWnNp?=
 =?utf-8?B?WGVTa3VzWmdIUVNBcllhQ2lmd1cySTlzejRodkEzenZuSFJZcWhPQThyTXN5?=
 =?utf-8?B?TjNwNDkzTmY4VDI5bzhUazJjb0NCcXppWEVsQ3g1eEJPNXhQWDhiSnJta0Z5?=
 =?utf-8?B?cHRJblVsVzI2ckdwL2g4T1BBaFZIWVlOM0lkTUxGL2dWVDlGV3Z5c1VXcDA3?=
 =?utf-8?B?OUZ6clRyNm41bGtDWTlNSS9jbWNjTllKeHlYU01GZ1hWaFZJSU1xNzJxV3ZX?=
 =?utf-8?B?dVE5aVh0SXhkeUZSb3ZqVHZyTHQ2dmU2b0pjMEJ4MHdCYlN3NE45UjUwRzNF?=
 =?utf-8?B?bW1yc0tuQ3B2N21VT2dCYWxzN1BEZEVra21hbkY3MGlOSkJZMkRRSUVFOHEw?=
 =?utf-8?B?ZlNScmZrbW9ZTHpYdGg4eFAyazRCL0ZVRVhxc0Vyd2t4UGJadXgrNlZYbXNR?=
 =?utf-8?B?MktHTU4ySHo2dmdJb056ZmNuUE9qc0dlT0Y0SlA2RWd1Tk9JelFUOExZWGdV?=
 =?utf-8?B?RVFGcFJmbnVJVjhYTVQ0VDVQZ0t2WmI0NmtzKytaNW9Vemh2dWVvNFpzNDZD?=
 =?utf-8?B?WmNSQThObGRrcVFia1Z1UW95RVFqK0N4YjRVbFlJcExqZUZxZ3JCU2MzTnZv?=
 =?utf-8?B?MEZKWVAyMC9BbmdZb1hzV1pXU05iOGVPcXBOODdHVUNxNklLLzFyVWtLcjYr?=
 =?utf-8?B?QmtGM0FSSExuUjNRdVA4WmFFTXpBL3Jmdk1vdDgzQm1HcGd1ZHZzOEFwWGZZ?=
 =?utf-8?B?NjIyQ3RrK25SZUg4djB2d3VqOG1udFhBMHdRTm1ubnI0UkxTN2gxMTkzbHlv?=
 =?utf-8?B?RjdrOGJKSFZtVTM0U01DZ3ZPVjdnYmZHR1RGWHFwMDI3M09sUG56Q3QzQyta?=
 =?utf-8?B?QjdVVFJKSDNWSklXQ2hRSForVjl0V0UyZDdLQmJ4VEYrU2FLZ2R4WlQ5ZkhK?=
 =?utf-8?B?UElPRDR6UEZXV0taaEVGMVJpM1F2MXRRZ1gvN01tK2lla0J1MzE1N21CbmhF?=
 =?utf-8?B?VlF2WWZhVUx1MTJCREpNR01tUEtHTTNHVHFPSld6ekdVcjAvUkNSWEtvcGhZ?=
 =?utf-8?B?SHB1eUtwSjVhbW04TGxHcGduY05uL0NCSG5XWHE4WHN3TkpzWVI2NjJZYzk0?=
 =?utf-8?B?c1JndElmWDVrM1Y3SVM2b3huNXFJN0phNUpjU3RmVGxiTDF5NjZvcG9IQmVn?=
 =?utf-8?B?YTdNWm9RM3hiNFhpbForcDV3MUpPbm1ZNzM3anBxb2l0US9MM2FNN1RlMGtq?=
 =?utf-8?B?Y3gwTDgyZGtVY1M5K0Y0Q2pwVGJ3ckJzYld2aU9lUW52N1c2bk1GalUxTUhB?=
 =?utf-8?B?cXY3RC9VRi93dTVLVFFnUm94d1c2OCtFdE51eVY2L3NPSlpMTzFLVGpjS1dn?=
 =?utf-8?B?bkNHN25tRVJ2bVJaTXZkSjA4T2tDK0FuNHpvaWFIRTNDZ0lwV2pUa081ZGpY?=
 =?utf-8?B?NWoya2tULzlaa2tXVHdyTEs0TDhuUWhxcmlMVkgycU1FY3h2K2VkaklLYUZX?=
 =?utf-8?B?MVJXbjg0a05RdDhCQnpVTTByaktTZWNmZElwY1R2eno0bzEzZXozMU56QVJn?=
 =?utf-8?B?RDlBYmI0N2w5dWJpVlQ5ak1SZW80VkNNcWdOaGJId3dKZnU4NmJUclF2WEtD?=
 =?utf-8?B?WTZ5OW00dTVzTGRCbVQweW9RWTdGSEszbnpJdTVNMGlzZnJHUGxZSDNtUW1h?=
 =?utf-8?B?Z044aDlXYU43MG9YSUhEWHRjWi9ISWpFTHhHYmhtbW5ZUVgzUWZObzUzMGNX?=
 =?utf-8?B?R0pWU2xZS3JIRFlHSVIzMXlobHB2c1A3LzA2MG52T1lsU083bmo3SGw0dDR5?=
 =?utf-8?B?dnBnblJwOWMwT3RuNGxOSVEvY1VpQVZRUlJYcllCbzErTkxqWGZ5VzRRU0NM?=
 =?utf-8?B?alE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45aeb672-902a-4c7d-6b50-08dde00dd605
X-MS-Exchange-CrossTenant-AuthSource: DS0SPRMB0001.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 17:20:18.7920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GzbL1TUwWLjy/mz2zyNui+JZfYlOSlMzvx2e1otgCdTJppCPkqTZhZvVrEJZLHB0Pm7ewGKowlqyDH0SYqjawQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7758

On 8/20/25 4:51 AM, Danilo Krummrich wrote:
> On Wed Aug 20, 2025 at 5:08 AM CEST, John Hubbard wrote:
>> Allow callers to write Class::STORAGE_SCSI instead of
>> bindings::PCI_CLASS_STORAGE_SCSI, for example.
>>
>> New APIs:
>>      Class::STORAGE_SCSI, Class::NETWORK_ETHERNET, etc.
>>      Class::as_raw()
>>      Class: TryFrom<u32> for Class
>>      ClassMask: Full, ClassSubclass
>>      DeviceId::from_class_and_vendor()
>>      Device::pci_class()
>>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: Alexandre Courbot <acourbot@nvidia.com>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> +    /// Returns the PCI class as a `Class` struct.
>> +    /// Returns an error if the class code is not recognized.
>> +    pub fn pci_class(&self) -> Result<Class> {
>> +        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
>> +        Class::new(unsafe { (*self.as_raw()).class })
>> +    }
> 
> I think all this turned out very nice!
> 
> One thing to reconsider would be whether we really want this to be fallible.
> 
> It's probably better to define a pci::Class::UNKNOWN and implement
> 
> 	impl From<u32> for Class {
> 	    fn from(value: u32) -> Self {
> 	        match value {
> 	            $(x if x == Self::$variant.0 => Self::$variant,)+
> 	            _ => Self::UNKNOWN,
> 	        }
> 	    }
> 	}
> 
> instead.

Yes, I went back and forth on whether Class and Vendor should be
fallible, and finally settled on the wrong choice. haha :)


thanks,
-- 
John Hubbard


