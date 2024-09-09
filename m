Return-Path: <linux-pci+bounces-12939-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D02AB970E39
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 08:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5F5282C7B
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 06:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33EF1AD9C8;
	Mon,  9 Sep 2024 06:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="mvQTst5n"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E87C1AD411;
	Mon,  9 Sep 2024 06:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725864500; cv=fail; b=HLP34dfKK5hjNVDgo6/uLDacgD4E8KpBzhg0BZTmRuPDMcDK2cAFPuzNd53Zje7Y7imPjg1qrCZYf1op2dHvC5lvTMTWgun2YE1qrclFgnsC4qz8z9euH6EyWI4G+tx2+Lz0K90/vZimL9XyAJb1iuPznR5kPrsCWwIjTzAcW+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725864500; c=relaxed/simple;
	bh=aZiJq3Ooi+xFlKZ7Zk1FTj2kzuoqognE8r3D/OR0Srs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cLV26aAfFwNLvbJBVTbFeKJZUoNWd89EdLHrHVUgrwNQuG6LaiYtjS7vuSB4Ro//mVk2eBMxklT4JY9GtneKYXWR/ep6CaTP4uZXqwZg74f0l9wc7mNEk7JurEQe2H4Hs25YDuDjdyYck8pUlfsRcRYob/PXQKCUdWeOIMf9VAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=mvQTst5n; arc=fail smtp.client-ip=40.107.21.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+Ugx4077gja6zaBdVqkmT65U8DQxWIL9vSV4BLdRPZAf9mEHTGLZkDuBcK3rqIBlkBnHXdMUrLODFvu6mCQB2mzo5BsqcqBpjgO677jNl+vbMF6UBPiwXjlPhocEuhyAT6DFaM5r/G69Pk947C1aQe04Vo86oaZU30J1PxgY9v+XfvjuLcY2FakN8KV25E+PWI3Ax58T/l8TD8GRNlXo1dwbjgNKGXrgMTeNUNWWZyBHEMDJDpxNwmLIit9dN4IDWvmsh832FAZ4Z9N8OMwAQVd3S6c3gwRuMglmKYz2833oLXIKF7PVyaOJxPXxNQnIoHkhMrig+JW9xsGC3r6QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Q+F10lGlXIyWnKYLEOIYjTecH7ky27tU1FTHmcsO+o=;
 b=nYf/X6T503mskDqY6noVKRCuKmrc4Ox7w+YExcCjVGfPdgZ+xJn51nFyI26p5NpSof6n5TgMvXGPkOfXMnSfqEJ3xvro4H3Df+0KMOTxCvsBI8mN36OSvIk8ej2McvgocH/h+iMHplueSs+ymUYeqznyJVm21DHzsc5hIlFM5eqCA605YoSXqBXzzv/3bzWyUCV4zNg3VJ360FJ0fjjK5LHa+kocFWlYzY9ZgKIUFAPJDGvb0R6wGqvqTq88QfVdvlsjKJyhwtL8RMifPvggPS8jIq2iAaHwPtjfpn9drZVJ2Ab7FFA6KOnaa0UteeXInJV+IYXjnII2vxb1VTq8GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Q+F10lGlXIyWnKYLEOIYjTecH7ky27tU1FTHmcsO+o=;
 b=mvQTst5nXNT883SgWnhqQmWvS/X2Vu8w1YF6B6Ih61zLS8U+ulCz+gKDNc1DEEpoeWrY5F1Z9zJZWfWo+NFeC1EpNYfv5cx72X9Gp90o3QFF+UHK3TUHxNPxC/QvqmH4bo5gXXOUjnzinTo79Yp2DZ01y30zRBMtCbaUBtatqOz/XTXImNSNYacaZeS5lanxoYy7HuqdwyuSo3EQY+27t/MpRP54IlILuYA26HP9lxL+/2oMmpGWzTG9oaf2fBtojmft3LiHeHhfm+gjJ9duumh7Dyob5xeU7J4+QJ9mSlQK0uDQRlhBTdr4j8kc+0QBI26RSRwg4jtF7fEWwsQ1mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:386::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 06:48:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 06:48:13 +0000
Message-ID: <0f2c79b5-2aa8-4d4c-b568-e74876fd6ecd@siemens.com>
Date: Mon, 9 Sep 2024 08:48:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] dt-bindings: PCI: ti,am65: Extend for use with PVU
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Bao Cheng Su <baocheng.su@siemens.com>, Hua Qian Li
 <huaqian.li@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <cover.1725816753.git.jan.kiszka@siemens.com>
 <33d08f61fe9bd692da0eceab91209832bf16e804.1725816753.git.jan.kiszka@siemens.com>
 <n5l36lo6at3yfbexqc5wcxgxop5wwfzldhhm43rwr6qy2epf7a@jq7l6wiyvydc>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <n5l36lo6at3yfbexqc5wcxgxop5wwfzldhhm43rwr6qy2epf7a@jq7l6wiyvydc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: f611f9d7-a47e-47bb-2466-08dcd09b601e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGFSMzNiN3lYcEQySmRTYlU4NDNDNjFuMmJXQ0I4SWc1T1BKMVdCeXhXeVJx?=
 =?utf-8?B?NUx1K1FQbTdtbG8yUW41ZnJiNWc1UTdYTXJqN3dIVXJLZW84bVBzc1RwTzRv?=
 =?utf-8?B?UFJNaVFWNzdFMVBWT211MXlIQ1o3WFIvaHFnSkxUU1ZJWkY4eDhFZmNKL1BY?=
 =?utf-8?B?RzNPOGlaMXFkazIxY3RCTmlHZ0tsVUNOVnQ4MjExQ2hmTWxnK0s3Q29TSElZ?=
 =?utf-8?B?UGhYUkhLUVhVZTJWajQyU052aWhkQ3hKeXYyYlA1VEtZYlB1UktYajAvM3ZM?=
 =?utf-8?B?NGxaZ3BBTUErQitLRW5RUW5Md1dzeEJNQitIeU1Dd1NjOTBCbSttY0JsaDBo?=
 =?utf-8?B?SStoTTNVSERDbWRxbmlrdGV1dERoaDlZbUhWNTFMZVowMElHRkVCbzhPSllk?=
 =?utf-8?B?Tm1CM0NMQWoyMldFeFdnb0ViTUNQWmdETVdpZWc0bkZ5Y3dPakc1aUNJS2dB?=
 =?utf-8?B?eDR1VTZKc1ZVRGRVTWNUZlVKdi9oWC8yOTV4MGpOcS9jcEQ4MDBWSDRkVjlH?=
 =?utf-8?B?OEFZekpqN3ZnSTBveG1nSFhIblVLdURuZE13OEJsL2tyRTNpM3BSMVZtR2tB?=
 =?utf-8?B?dEZubEZjY1phMlpQWWNuUGZEZDg0c1B2NDFEWnpER0hCU29uMUgrUXpYeHhp?=
 =?utf-8?B?dW1Cd3pFWW8yWEI1b0lqSHUwM1NhVDRKeUU4ZlJvQ2w0elN6bC9GUzJSUGpR?=
 =?utf-8?B?Q0hnUnRCdjkzTXZ1dmk4MVZxT2dwNXh1UXl2QTZhMGNFSkJTV1EzeFZIMHpx?=
 =?utf-8?B?bDRLYVdnS0haTjFRZ0hZY3pBRmFuSXJ0LzdHVHpOczZEb3I2Qll6ejZ5c0NN?=
 =?utf-8?B?REFsd3g3bEJ0VFA4aDlCenJ2LzRTQmxscWNrWVRVRTFEdW5GcnV1emFENmZ6?=
 =?utf-8?B?TGdIbU9vM09SWi9EeEg5RktHc1F2WXJlcGVrNUFiR1JVeDRScEJnOXlQb1J5?=
 =?utf-8?B?UlNhM1BrZ204THJCcGFJZCtSSFh5YWhCN1NYYVU4ZlIxckszVHR0eWFNN1c4?=
 =?utf-8?B?WVhxcWtwanlCdkRkMGt3YUFnSzlqeGRKTlRuYU9wblRjSUtBMHRkSGJhU3Rz?=
 =?utf-8?B?UkVNVndneWY5bnBKcUhNZFN0ZFhwWGlHUFhHZ1hMZldhNEtCK0xRb3h4eVJZ?=
 =?utf-8?B?YkQ0ZmhHc3ozNkl2Nys3V1psdHhmSUhZZ3dac0I0b2c1QnVUV21Za2lmREtJ?=
 =?utf-8?B?MGQ0R0Z4Ukk5aVUxbytJQkxoYy93alRTNmdTeXQvVjBtZzk3amlhRWNIajls?=
 =?utf-8?B?ZGVkVWtpUUxNZjA1WVlOOWsvbUNaek5NaElMRTBpcyswQzd2akhLdHluNXpo?=
 =?utf-8?B?NnVYWTlBVnUrRGl0bWxFMVoxUFE1OW02Ni94bHFuWGl1bU9ZcFh0dDBsR3Vn?=
 =?utf-8?B?Y0lnODhzeHo3bE42YUJjb3RyS1A5UkY2TTNHR3lZMVJ3eVdlcnZjKzBUM2FZ?=
 =?utf-8?B?eU1jd1hGczZvbGh0Sy9ZT05QMUpiM2dWWll4bHRENzJvUTdHWVUvT0pBeTNh?=
 =?utf-8?B?SDJXVkl4TTVoN29TNzB3OGl0Sm1qZTZQc29VOGttNVVZV2t4UE5NNWxhQ0Nv?=
 =?utf-8?B?bXNiWG5HN2hlVEFPRG12UENCSFd6VFAyMWxUUi93a3lnZWduam5lSElDdXU0?=
 =?utf-8?B?a2QwaDZuemg2OHZTTGQxT2VJTmRiV2I2dTBXNzVLQnRtUWtkS0RkL25xdzNl?=
 =?utf-8?B?ME1DbDRvV0VVK1EyUG9TN1hQQTRLUmZrKzI2ZGZwV0t5WVVDNkpVdnZlRmNl?=
 =?utf-8?B?Vlg5LytkL3pXVmhZUSt5TTY3azJ2eTNyMVg4VUZEcGpXMEpDcWJKcUgyaFhW?=
 =?utf-8?B?TkdvNjVTK1hkRkU3d0JLZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmpGU2ZodS8wcEp2SXQ3TlRIZTRGL1lhb0tIcXNLTUdGTENCZ2JSQVhRUE5h?=
 =?utf-8?B?S2Q2NTVBOFl5dVpQaVd4dVVibmhueEFDME5nR2dvVkFlUC84MGI1V0RYZW9s?=
 =?utf-8?B?a0JiRTJRaVk3bGJSQkdIZWdFWDZLSmJTdDYyeGk2ekIrY0kvOXFRcC9GZEFN?=
 =?utf-8?B?ekhLdk9oQ0lZWnREVmlmYmd6RFRtblFicy9lZ3J1eXBxekw4VytUVmxlMWhO?=
 =?utf-8?B?dGRyOXJkSHFQVEVoemRQYlorMWFZQlpmTGJ4UUc3MXozZnp0Y3ZXU1BiTzFS?=
 =?utf-8?B?SFF3bExPazFvREErOXM2SjhEVDdaNmJGMGZxTWR4ZHhWb1l2a3FmL1J6emEr?=
 =?utf-8?B?ZGFjd1Z6UUNjQmxuU3hObml1enFaSmJzMzZDQlZ3Wk8rN3c1eEl0Zzk5U1Ux?=
 =?utf-8?B?S05UQlRGL1dOdkpLVUExUytRc1NLbm92TW9JVWFzNzVtb0IxVHprUHp3UWVk?=
 =?utf-8?B?L0VZVmFYMXA4Z1IvdTZBVlA1dGp6L3h2K2dJVWEySDRVb1hRMFFNZ1d3dEZ4?=
 =?utf-8?B?ckJJSEIvVHVTa3RESXYxWEltd0kwTEwzQXJkWFdjTjUrdVY3VDV0bS9FT0N2?=
 =?utf-8?B?ZDhTOWFNcC9YbmI0UytEVjcxRkFiejdjWnpiVjFFMTRZdlhGYUFBYlZYUENX?=
 =?utf-8?B?REMwQ05vQkR1WDFBcGxIR1R0aTZmYTVobDVMOTdoamFJK1NMMkVvWng0UGJU?=
 =?utf-8?B?V2llYlozKzNxazRtaFNQY3IveFI2ejk5bHVncXBRVGFXWmM0Y2kvdEppbFdy?=
 =?utf-8?B?NGNRWW0rT2daaVNITDZYL1pwbjVUZGgzQlBrZlV5akhpWlljR1NmRVF3cWVU?=
 =?utf-8?B?b0IwQWxEelJOelI0Z0Q3bG9ZZTVja1k0YlR5M3M2STAwUFRKV3BsTElCcWhn?=
 =?utf-8?B?YW54TXJlYk5vSURVc29ZS1pDOWI5OGpTV1hlbk9FYis2ZG4yYWQ2alJ3YUlP?=
 =?utf-8?B?SGNHbTFUTm9FRmJBZkMzOTNZRGExblFycUtNZ0l2QWNFL3VZM05yVXUyRTRZ?=
 =?utf-8?B?NEZpK2dKckxtelFwRU41UDRaZlJmNDZnMGpIS0o4eEVlRmdjUlVOd2U2Y21i?=
 =?utf-8?B?MmsvbEQwK1ZqN1l5NGdyYnkrSVdlcHpyZDJSWWZEVkc4TENwRlZPbTlxUG9q?=
 =?utf-8?B?eElhbHhkRzZweGNLVlZJU1ZucFFlb1VZR2haNTNzUmE3RURrWWlNTzNQa0xL?=
 =?utf-8?B?MjhXRi9PdVYxT3U2Y0tMVVVRYUZnK1p1YmU3UjN1MU9UZFplQ1JxaU80VDVO?=
 =?utf-8?B?Z3RhYUhvM0F6emF5L0c3cVRybEV1bk1mTEtCQThRNWdtV0NLMDVHcXMrUENY?=
 =?utf-8?B?UmpoOVVNeUQyU2RXMEluUERPeGl4U2ZSWWlpeFZvbUM0Q2pQL21GaXRmN0k3?=
 =?utf-8?B?NlZRV1A1b1FiaG14ekk4UGFHemlQL2xVT2hock8vc3paa01GUzh2RGxNYnk0?=
 =?utf-8?B?aGpMMkluUksxamIyd3hjazNJQnp0bEJTV0ZLdStsVkR6YkpuT2hKdldITVhQ?=
 =?utf-8?B?Tkh1SFhVODV5MTg3emJjNmp1ZWhPV0lUL0Z4R0pHUmtYKytNR0JWUEJTS1Bk?=
 =?utf-8?B?M3RFN3FqY0Y4ak42R1NyN0NEMVc1TVA5NUxOZmFIZGs5WkQ4bE5WSCtQUkZj?=
 =?utf-8?B?d1YxZVZzNlNaZ1ZwNlcrRUVPUHNzQUpldG0xOUlFa0xTZXp2Z1dhR2xsVTdp?=
 =?utf-8?B?MVdmN2pIVW91SG1FK0dweVkrTUlLTXdmQlo2aHd0c2w1bzRIT3FlM1JzUWVt?=
 =?utf-8?B?T0UrL1pDMmJZbmIvN2ZUMUtLci9LNSsySEs0RVdncG9IZGEwVW1NK3BzQU9l?=
 =?utf-8?B?aUhTZ1JwSWpaSC9xMS8yVWxSMWRTc2twczJVTDllbXhFb1ZYT2NocjdNaUxZ?=
 =?utf-8?B?Ti9pTEpBRmxBUjI4QTZwNlNIb0pQMDFIbXNUVnpCRG1oQWhFbE9USlBBUnpx?=
 =?utf-8?B?citzQzNUa2lHV3dxMTZTVkpTSHdGRTcza0VkZHBHVkJmbDRlQUViTFJsQyth?=
 =?utf-8?B?emxPc3JSSEhoZUIxUndZR1VnV2doUHI1TkJHOWpTQ3FYWXN6eGR3VnpPeVpj?=
 =?utf-8?B?ejEzWFp2UVFGN0hjRVhTc2R3L3JiTzg1cFI1VVVTeGFKRjArMHN1ZSsxdUQ5?=
 =?utf-8?Q?fwqk7KouUmTk+01kK/OoB/PqM?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f611f9d7-a47e-47bb-2466-08dcd09b601e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 06:48:13.1953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dyjJVvfETPVPGGM8Ttyee29T+50vBPYpcZPWt6sp+Wg05nQAA0OAAnkDP44g32P/ZOL+Y/xUSLG8Uor84dSORw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6190

On 09.09.24 08:22, Krzysztof Kozlowski wrote:
> On Sun, Sep 08, 2024 at 07:32:28PM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> The PVU on the AM65 SoC is capable of restricting DMA from PCIe devices
>> to specific regions of host memory. Add the optional property
>> "memory-regions" to point to such regions of memory when PVU is used.
>>
>> Since the PVU deals with system physical addresses, utilizing the PVU
>> with PCIe devices also requires setting up the VMAP registers to map the
>> Requester ID of the PCIe device to the CBA Virtual ID, which in turn is
>> mapped to the system physical address. Hence, describe the VMAP
>> registers which are optional unless the PVU shall be used for PCIe.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>> CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> CC: "Krzysztof Wilczyński" <kw@linux.com>
>> CC: Bjorn Helgaas <bhelgaas@google.com>
>> CC: linux-pci@vger.kernel.org
>> ---
>>  .../bindings/pci/ti,am65-pci-host.yaml        | 29 +++++++++++++++++--
>>  1 file changed, 26 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>> index 0a9d10532cc8..0c297d12173c 100644
>> --- a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>> +++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>> @@ -20,14 +20,18 @@ properties:
>>        - ti,keystone-pcie
>>  
>>    reg:
>> -    maxItems: 4
>> +    minItems: 4
>> +    maxItems: 6
>>  
>>    reg-names:
>> +    minItems: 4
>>      items:
>>        - const: app
>>        - const: dbics
>>        - const: config
>>        - const: atu
>> +      - const: vmap_lp
>> +      - const: vmap_hp
>>  
>>    interrupts:
>>      maxItems: 1
>> @@ -83,13 +87,30 @@ if:
>>      compatible:
>>        enum:
>>          - ti,am654-pcie-rc
>> +
>>  then:
>> +  properties:
>> +    memory-region:
> 
> I think I said it two times already. You must define properties in
> top-level. That's how we expect, that's how dtschema works (even if it
> works fine otherwise, it's not always that case), that's how almost all
> bindings are written.

Look, if you have such rules, also enhance the checker, or people like
me will continue to work intuitively. Add reasoning along that as well,
would help further to reduce your review effort. The current situation
with rather fuzzy results from the checker and strange mechanisms inside
(see my maxItems finding) is not very helpful IMHO.

I this concrete case, I would add this item top-level, just to set
maxItems to 0 for ti,keystone-pcie? Not a pattern I'm finding anywhere.
Or do we have to allow memory-regions for all compatibles now?

Sorry for all these iterations, but you should see from my questions and
actions where the problems in the concepts are.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


