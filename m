Return-Path: <linux-pci+bounces-34385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CC1B2DE79
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 15:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8DED169208
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 13:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEB31D63E8;
	Wed, 20 Aug 2025 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tUdNg3dv"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43A91BCA1C;
	Wed, 20 Aug 2025 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755697983; cv=fail; b=hMdg13gtA5uTfOrSs78jMLu3JYnWB+J9dU9cQ2LuOcic4oMOrVv/dye0JhASoTz3pJNy6Amys+VZly+HoTsh1jk+sSVjLg5guPqVXRPjvo6dEwyqTOvP3vWvP4HR1Mlh6UYMx47zaw2LSEuUTvcegCGp9XJuKEkc9/5McR3H+oQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755697983; c=relaxed/simple;
	bh=wGTUqto30GJAX7PQ6fLg7wes2iRwZNs/eida+8SZcqI=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=CgLd0j873q97x286Upendsa5AfKZlyy7qDOFLTSBF4jYntmvYzflpduFBTfrkQmpceZTl7h150OPQO+QLdJGN3ol9azel2w7RpCPSzkC3emEwPtagpXQS7v5u7tz8XiAiGdmIIOygvKK4+yKCXdsBeFVWHOlYuEFAATWTh9vO6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tUdNg3dv; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPxo2bdgcALRrg2KoIjjBwxJzlWUPsGEihsRGEp4ayoGseCzWk2A19MPX4jNB/+8FRAmBY9qbiCSvtlSpguswL73ouMmcdFRawrnFp/YufHXYAtmg5/nS5untjmot8dBGzsahBUtS1ktvS7FbsJt/ijVC1/X5z1NdY7jeWrNQ+ExCoXG8rcK+qOrcdSLiaWh/tYKLchJw93+p8Ftlf3QOX2sj7rDXDtB070KGtIYmCYMVG5a20q92qIAkMzJBNCoz3EVUUKa421ZG2AJZPIRZyIH65Vs7ftuKna8fI4nDWxKrHNTeoBmCIk5SN7KTXzQm/DcZs9WPvfQR0H0s1Nelg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsvDk9HnnRFoNz7zYYXYj6fc4RoRPv+3X06iJPEJL30=;
 b=VWJMMAZzFVDMqIlX6veWKJWbjY1jhD2SyA8Z9w7PU831E3tjq+kwqNPNcVvSQ5YI/kiGlVJZGaQjQrKC6vGpQN7rW8mQJf663K0wvCsY+Qm/UKn5Bp4SCWE9DqEOT1fNhH2j4cRqLGBQFUQC5SL0fzikbg09osGQVvX3hEwvZEW1mGh5dwG7c0XksDguTSAT8gnb3P21sgGhgBEqYMPnn9CTjPBdLojgohZKPSc6rctLoHFbaVNp84Hk+yf1Yc3M5/gxKvjHqBu9duntDyb+/t/uPtDQWaI7YIbmAK8cux7KHB9+57JMqh+Yu2+uek/4l4e1YQfCbfONEd2dklJZRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsvDk9HnnRFoNz7zYYXYj6fc4RoRPv+3X06iJPEJL30=;
 b=tUdNg3dv2c8FgoQBOqY876N475Sk2yMiaEpLKoGmkcasZTwZ+Xi6k9xI9Y/ga0S6FpzXA+xvFVNGvNWU61De/wIb8r5Eh0PQ0stnz6XjlpPQ23dpNeD/j2YYY8McYIExunu6xWO3NdEecLhQXtXaIGhQ7IM7oRbL38DwadPlJQ4cU0s8Nd8VZjdTLDRF4yX5e0fV/Oqgtuq+0VzDbxnpmVEflQgtY+v3fNcPrFWoQz1XA2c/MxnZQ4CgOAXbCYUGS3/GrlUVnkUcPx10a3Mt64guaJd9R60yKqUXVUwZL6V08TjMsxoyllRVvLe6G4MIfFBncE6+dPYrrZ6ARHjUnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ0PR12MB6759.namprd12.prod.outlook.com (2603:10b6:a03:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 13:52:55 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 13:52:54 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Aug 2025 22:52:50 +0900
Message-Id: <DC7AZL4OWXTY.2F7TRSCZYNK6S@nvidia.com>
Subject: Re: [PATCH v4 2/3] gpu: nova-core: avoid probing
 non-display/compute PCI functions
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>
Cc: "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <nouveau@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250820030859.6446-1-jhubbard@nvidia.com>
 <20250820030859.6446-3-jhubbard@nvidia.com>
In-Reply-To: <20250820030859.6446-3-jhubbard@nvidia.com>
X-ClientProxiedBy: OS7PR01CA0214.jpnprd01.prod.outlook.com
 (2603:1096:604:252::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ0PR12MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: cc322a31-efa9-4d02-99ce-08dddff0dcb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUV3bk85b2NTc3JvMWk5V2NZbFJmQXhjSGtLVWtteDE5WWNRSUxjMTVUM2hP?=
 =?utf-8?B?QWV0VkRvVE91d0xRR1hFZVRkYmVBUm9JeFNkamEzR0NwVWFMWTYzQlpQYVJS?=
 =?utf-8?B?QkQ5K01rOWl0eDFUazZkbHlOTTlQYzF2VGVOYzBJMzJ2bE9xekNlanFGdElp?=
 =?utf-8?B?ei9JN0tFcEhrOVd0VWZOZnIzOVlvUUpFeExUQ1YyRU00OVFoajR1Vy9IdVhm?=
 =?utf-8?B?NExkNVNoZ2kzYXQ4MzQ3Yk1vTXZFYkZucWxGeXVnZzRNOUpJZ1U3SjdITktL?=
 =?utf-8?B?aVBVUGRLbHRRUFlhd3ZmdUNUZm1GTDBUZTI0L2pUbWlaUDlBSWJVNXVoMlFs?=
 =?utf-8?B?eEUrSEM2T2JYR1ZYQ2pEdVovREFjSVpxdU9qakw3UUpYa3lKRFNjdGc1YmFo?=
 =?utf-8?B?ODN3U1NSUmdMY2dVT2IrYXgrcElHS00zVDJheFVyWlhuY0syMTUwQXVOdjNk?=
 =?utf-8?B?ZGk2RTFkSWpvamNCU1pwUjZNNkR6VXI0YnRQRlloN0NrYXB0T1JXRmZHa1p6?=
 =?utf-8?B?bXFpd1BHMVFFMGdoaml6UVhLN1VXRHdvWTVHRGtHZlZuak5hMXp2dXJTRXU0?=
 =?utf-8?B?c0w2M1VxN1NkQ3dnWElSVFhwNVFGN0ptTklFQ0xLbDF0V0dwbXlQNDNaUlZJ?=
 =?utf-8?B?dldLVEw4TmlvVTR1UVZ3cGlqVmpSYjRoa2RRV3hmZTYwRi9rWFhMeUlzQVA1?=
 =?utf-8?B?VDE2eEpaOC96b2Y4MGk2ZitNTXpISExhUUlneWlVRy9PQTE2eVRwazh6YUI1?=
 =?utf-8?B?OWU0RVZpYnZTWHFwNnhlQlNyUExXQ0llSkN3RUszTC95b3BJUHc5ZXpzM1Ev?=
 =?utf-8?B?SjNlQjRHMWdTeHJ5ang3bHdEOGRyeFFXV3BRWTVuYTg4dnZvZVhHZTd2eHh2?=
 =?utf-8?B?aHJjWWxwSlRsL0pJTC92V2x2aks4OElZOWoxTXBYaUJ6QURSYmp5WEE2YThG?=
 =?utf-8?B?WS9GcFZUenBNbkloS2pQYUdUTHc2ME91d0lPWit5S0h2UmN5Y1BTU1NHWUN5?=
 =?utf-8?B?V0d4TmNyNWtBY1hockdaY3ZoOVAyY2Rzd28wU0RxbmlDUDBoelRSK3NnL2NJ?=
 =?utf-8?B?V2pVLzM0M3ZkdHJha2ZrMGdrODJUZGpBVm96RGZ1aEsreDU4amozUjdiMkJi?=
 =?utf-8?B?Sk9SWkc5Q3NvQmpJZ2pyeVZaSU96RlBpUVhtTVlscGUyelBubkwrYkx2d1Qr?=
 =?utf-8?B?YWc4c1pFL2Z4c3o4Vm5TK0hDTVBjS0VIVW9PNVRKUTBJRUFnSVhPMXQvN0FK?=
 =?utf-8?B?YmdReGRBWHJFU2YzYWYzcEp5TVZyWWErZHBsMTlYMHZkTmFWenVpcVZsVEVl?=
 =?utf-8?B?NGFJdndlaFgzeFlzS2QvbVFnZ3d0L0lyM1lqZTZ1NmVEN2JXTm0vNS9lZG5J?=
 =?utf-8?B?YmlFdGJSVEE0aCt6RG1hb1dyeWdvN1RsZi9ERUlxK05VNVp4S0liWTB5Mmor?=
 =?utf-8?B?dVFDZG4xMUJ3Sm5NVXQ3QS82aDlBd1lDQ01yNVhFRmtjU3A1d0tVcjU0eDhT?=
 =?utf-8?B?ZmN6MGl1VFd5VDUxYW03QlhHbml2VnB3TmQ0RlZINW5DWWhibTh1UGY1YUM3?=
 =?utf-8?B?bXRYRURTRlJkcklQVkF1a3VpVkJRbE85eEVuanJ4TndBdTFtVVF1ZFMrcitN?=
 =?utf-8?B?aUs5M1d4SDRHWEtwdFpvc2ZOTWEwSmxrOGdDalNVdHZnVXNSZjh0dzZRRnFS?=
 =?utf-8?B?VzRKbUVkSENyWlJVa01uczdjQVNZeVdMeWVZMFZyeHJaK0lKTmxZTWJtRlUr?=
 =?utf-8?B?Vmxab2o5cjUxMjBlbW41R05FVWRjMGs1UmlkdnVxMG5kRGc0c0VYSUFVbFNa?=
 =?utf-8?B?STBwT2trK2lpYU9LYVJqYkhoSTdWV3BtNUZacGpKL3JFbWpKTWdFRC93cENV?=
 =?utf-8?B?MXh3eXd0Z0lKSUs4dlgzUUEyblJscGpJcm51ajVtbEE3Y2NFZnVzeG1PSVYw?=
 =?utf-8?Q?NIflsObW6QE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmlWalh0QmF3NkZXbmVlU3dOQm1ETjdIczZNM1EvQ29sUUFhRzFUQUVLTFh3?=
 =?utf-8?B?S0pXM242dnhsYmhLZkRTYU5NSWJZZkVsU2RRK0xoUTVrK1VWWmxHb1lXSmhs?=
 =?utf-8?B?UVFGL2MzdzZVR3JjLzNmSmtUVkd0cHgxVTVnUkQzeFozSXE1TzBIYVd6cSty?=
 =?utf-8?B?SkhoclpOUDhGT3dXUVFMa0pFbTBXcGtvd0ZTNUdpdk15Vm11M29EYTA0YTkw?=
 =?utf-8?B?ZnJIRkJ5V3YyZ1dGai9XdnRXdkVBM29GV0tuR2xtSjEvc1p4VTM5Ny9VZm5i?=
 =?utf-8?B?MUxUb0w1NFFKUDh1bGNaQklmL3hBUzF3UDJzU3pUclR5VUZSWXNNalZHZ1lm?=
 =?utf-8?B?WmN0NTdiZDlxQk10ZFZDNHR1SlhxRVVBb3F0d29ieVdJN1RET2N6cWRYa2Vm?=
 =?utf-8?B?RldNSE1mT2I1b2hyUE94Z0k0L1NBKzBDaWNENGVuWW5DanRlSkQveWNuSGtO?=
 =?utf-8?B?MFlUMWM2dWpLU3MwblNGUDd2OVNRUlF6bEk1WWtYaHMyVnVLMkNFMTREMnNt?=
 =?utf-8?B?S1lJY2J0c3RzYk8zR25acXZseGFJM3JaZ2I0TjZNSndwUVUvQjVMN3A4end4?=
 =?utf-8?B?S3d6ZWgwTXppZlZIWFJlQWRENm1RQUcrb1FvaEV0SWdkc2J3WHNDa0J3cktH?=
 =?utf-8?B?U2hrL3VISGJoU0liQzZjOGUvOUZjOEtyWVh2MkliVFVUdFQzOUpleXBjSVJk?=
 =?utf-8?B?Q0haQzh2aC95MjU3ZUtiSjUxS080Mm9TcWVRQnlTSXBaYUFPV1kvdjZpUFR1?=
 =?utf-8?B?MnFvVUpYclRKZGFBa3B3dGxGbjVCYjBUeGN0NnZGZFAyblJ6clhzOGRCM0x0?=
 =?utf-8?B?RWk0VXYzWGhDd0NuZ1BsL2ozQmFmVjh5eEVnbTM5SnVmRXppd2gvcXQ0eGNk?=
 =?utf-8?B?dDB3eFArcGI2SXBXV1NPSDZXTXRwZk9XN2Q5VkVTbWpmbzNJNmtVcHdMc00z?=
 =?utf-8?B?VVBZYUYrYXc1VStISXc2cjlOc0NCMFVLSHJ5WEpvYWwwZXNrdVFtSTBZRDhm?=
 =?utf-8?B?MTJVQjdxV1RKbGZKL2JKb250OGM2TzExbGZ3L0ZrWWkxSWUzVHN1L2JSQm1R?=
 =?utf-8?B?aTdpTEN6QWVtWkYyRStIMktTci9IL3RjT05malkwWHQ2ZkpZUFdFSHg4R1Vt?=
 =?utf-8?B?WWtHSEg3M28xanZiUDJ1SUdvakhTL2dqTHMwcWxtU3ZLT0d5ZDk3UUZCL09k?=
 =?utf-8?B?M25ucUpjbVUwWnpWR0FUbUFyb2ZMRW1qL013SVZIYXZoK3JXNFBBNllKdE1W?=
 =?utf-8?B?VldrWENzbStLNFJJZi9adVRnU2c4Ymx3ekl0NExoNmt2czM0dml4VFNLai9P?=
 =?utf-8?B?ajI5dktMOEJHOFJsMk9sLzByNmFiWFdhZ0dtRUdKUnJobWFndjVOM1ZBZkMz?=
 =?utf-8?B?TnpiaHQvLzkrak5SZnJkajFqYWRFdCtFcmt0MDl0SlhZRTU0UG1ob0xLMUFm?=
 =?utf-8?B?U3JibGdPZ3VKSFEwRFBNVzVVR2JrQXNuT3pyT2xWVmhIcGI4UkRBemVCZEVu?=
 =?utf-8?B?V3NIOGFrQ0J3elVBVDVaQ0YzbnZraXgwc24yS0ZBVzFBcDN4eVhFbmt1cGZY?=
 =?utf-8?B?ZFMrMThKTTJ4eCtJTTdDMmVyemFqMW4zazhVZ3dneVFyNjFWTTBtWUpyODNl?=
 =?utf-8?B?b2dUeHJkcFIzbHFDdFVXQlNZY0w4SzhzWmRJQjR0WkVYQ1JSR1pCeUpRMnEw?=
 =?utf-8?B?ek96cFZ5ODNOUmtxV0h2WVhoY3dPOGk5MGpiYkJmYzhSOVNFelFTb2RFM3Jz?=
 =?utf-8?B?UXZMUUtKSVhCYkZITjVaVXdtakROT3lCNWN1bHFldVd0czZ1bTUrd3JlV1Ay?=
 =?utf-8?B?VUY0UTFrUmUxUHByay9Pb2lDbWNoVSs5eHMzdS9uME9YbDJIKzhURXQ4dDha?=
 =?utf-8?B?ZGZqblJWRWhKZU5jZ0FmLyt6L1RWZ3Nsb2psN2hNYktNcVBDNFdYZmp0SGdO?=
 =?utf-8?B?Ui9XbUM3SGM3d29zVGUrU20zNEdIZlVxL0Z6R2FkVFlOeHg1cDJ1RkRuUGtu?=
 =?utf-8?B?aG5CZGZsRnNmTkplNndkckZ3cy9WZGs4dUt2YzlyRmowL2dYQ1hCeXhQYk1v?=
 =?utf-8?B?bjJTWGpZU2hONzJIMXREc2hJM0JKdGtPQmY1VWZmZFJNbDBuOWNLSi9kSytp?=
 =?utf-8?B?NEViT3BGRitiY2habVJITEg2dzBYR0ljeks3Q1ZlZE54QTZqYWE3ZVhYOXhM?=
 =?utf-8?Q?6OPtjwK7nc5EpP9nowNWUxy+Qe5+slt2rG1UGPhopajj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc322a31-efa9-4d02-99ce-08dddff0dcb4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 13:52:54.7333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: or67kqkV1A33ZiI27sVZD1ihohpFE43gJE74jWLly06LNDHEtd/ikYCucK9ZU/Cr/W3Ra/VUrR+clvy4DAmNxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759

On Wed Aug 20, 2025 at 12:08 PM JST, John Hubbard wrote:
> NovaCore has so far been too imprecise about figuring out if .probe()
> has found a supported PCI PF (Physical Function). By that I mean:
> .probe() sets up BAR0 (which involves a lot of very careful devres and
> Device<Bound> details behind the scenes). And then if it is dealing with
> a non-supported device such as the .1 audio PF on many GPUs, it fails
> out due to an unexpected BAR0 size. We have been fortunate that the BAR0
> sizes are different.
>
> Really, we should be filtering on PCI class ID instead. These days I
> think we can confidently pick out Nova's supported PF's via PCI class
> ID. And if not, then we'll revisit.
>
> The approach here is to filter on "Display VGA" or "Display 3D", which
> is how PCI class IDs express "this is a modern GPU's PF".
>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  drivers/gpu/nova-core/driver.rs | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driv=
er.rs
> index 274989ea1fb4..b60c9defa9d1 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -1,6 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
> =20
> -use kernel::{auxiliary, bindings, c_str, device::Core, pci, prelude::*, =
sizes::SZ_16M, sync::Arc};
> +use kernel::{
> +    auxiliary, bindings, c_str, device::Core, pci, pci::Class, pci::Clas=
sMask, prelude::*,
> +    sizes::SZ_16M, sync::Arc,
> +};
> =20
>  use crate::gpu::Gpu;
> =20
> @@ -18,10 +21,25 @@ pub(crate) struct NovaCore {
>      PCI_TABLE,
>      MODULE_PCI_TABLE,
>      <NovaCore as pci::Driver>::IdInfo,
> -    [(
> -        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_NVIDIA, bindings:=
:PCI_ANY_ID as u32),
> -        ()
> -    )]
> +    [
> +        // Modern NVIDIA GPUs will show up as either VGA or 3D controlle=
rs.
> +        (
> +            pci::DeviceId::from_class_and_vendor(
> +                Class::DISPLAY_VGA,
> +                ClassMask::ClassSubclass,
> +                bindings::PCI_VENDOR_ID_NVIDIA
> +            ),
> +            ()
> +        ),
> +        (
> +            pci::DeviceId::from_class_and_vendor(
> +                Class::DISPLAY_3D,
> +                ClassMask::ClassSubclass,
> +                bindings::PCI_VENDOR_ID_NVIDIA
> +            ),

This is making use of `from_class_and_vendor`, which is modified in the
next patch, requiring to modify this part of the file again. How about
switching this patch with 3/3 so we only modify the nova-core code once?

I also wonder if we want to merge 1/3 and (the current) 3/3, since 1/3
alone leaves `from_class_and_vendor` into some intermediate state that
nobody will ever get a chance to use anyway, and one doesn't really make
sense without the other. WDYT?

