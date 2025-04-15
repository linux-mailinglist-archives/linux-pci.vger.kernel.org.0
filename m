Return-Path: <linux-pci+bounces-25899-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9B5A89308
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 06:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4609E3B8758
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 04:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F3523C39A;
	Tue, 15 Apr 2025 04:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ilDesiX7"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB26D23F294;
	Tue, 15 Apr 2025 04:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744691854; cv=fail; b=SFFq1mjsNTBg9BtW+qxlVOnmo9tPz+Hm5L/nR1hQXYnEUvTmCJ6J5lkwAWUxoXrb/kJxPTjK6+6fkGlami0y2vL8s7jh3pY64g++m8VGmURiv3r0W7ZQ4ArGM/9chEU/L6gQ++7mDmfTA8F+v5EgNfFSsxRHWZnkUwizTec0+dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744691854; c=relaxed/simple;
	bh=vYrHm9EM1LVt/THLr3rQWmp23hexQa4XH+RGql905DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c8qTWsOBQKLlAxj6Bw0mmo9HybYwATo7SqAPdmy4etnD/MWIqIvO8OAG+8NiKmuIRGh/CGeDUoPq2tIHa2/L+Dc58NSKuEisNx1tTT86NTnejMg7MQowC2IHwLOOBFm/8p9dNcjGyyAHd/RBoY1pCqn1QglISP5nR4uo+XtBJws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ilDesiX7; arc=fail smtp.client-ip=40.107.101.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EF0axFUOOOTAEFpF+QuYTPuXfvJeVcHUMhRLAxwwAy97wHG44bPcSmAjLxY7gEalTUgDIg439ghsgYcEyGYP+r2vPZOrUZmMLlXrK10dkwIfhNLG4B5tPD96nzTOsWOIlTB7t1PleHJLkCiVCooQgaI4in5F6ijfRqy5gHXSrdI6PT4+r8HQJBpSPM+IuPeyhyeX6bWWLma/GxguWd8Dy7tBLnu2BgeMORiel0aYODXbbP//MKkfyaYgRYRZhzA8ZyhnQU45hh5HricMfEQ70Xz9YJLgdQ0Ko2PU0qFgvNB+duzL3CITBJwODJeOZMSG5Xt8uirmBH03qCE0Tjjqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpSLe4AogAK6ZCs6B0koDV/6s76H/sVo0rRGOFHLkH0=;
 b=h/WThSbA6zM+gpvTejRsxdAL++djBtx4n1cTSW+AZm4vKpw7SX3okijiqpBL21Lthnp2Pi7kChMGQUqPd50b7Sr7Ua62rlQbsJtM0lZ0QSDEdM9mKTJ+tKgW0kudTxu0pYDG+yxYprwQgbg5WFQtKo/FWQpJNFIrr3YXd+tixeL8/XROx0/zf/zZF+Wm4LX5A7XK3vA7Nv2RZ5BMsI6d5Pbsz12E5S7hBm5NAu6D5xEVKjGYDguK6hjTbg8RIhynC1Jfh7Md0oSwSj6fHdi402w8jMGakSthvE8ZMQklIgzQ+yIII+MWgkse4yKK4x07r6ra8C5lDx6lEK4595/BZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpSLe4AogAK6ZCs6B0koDV/6s76H/sVo0rRGOFHLkH0=;
 b=ilDesiX7u7REmcloAneh+Sby2DLHi+Pn/Et2BsLn6tWcPLYSsJIbGB7M6qsRLmMKf389+lu1g3KU7akVgCrxe7uqIRkfUiqABCzL69yLD3Qvn/gUlz+gHejpq67C+RpWJX0TgybL2f0GQuiGffTYgwmOytckbIIhzYmi2JpwhGEWzcr2CnV6VC9Y7kOzTVyhpj+oS7PfuzzopAv5J3QseHlOUsbZIDWUFScvtlRDEO1fJixYenM2e/ailt8TVb1fURopysQIwEm7WBRYkVhbT9ceTxwKYZSBbG4LyIQfYTqqcep35LkpOTzKbmrxq3aZYhpMDSFQSdFTvttLWwOrtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA1PR12MB6554.namprd12.prod.outlook.com (2603:10b6:208:3a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Tue, 15 Apr
 2025 04:37:27 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8632.025; Tue, 15 Apr 2025
 04:37:27 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, Danilo Krummrich <dakr@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, rust-for-linux <rust-for-linux@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [v4,1/2] rust/revocable: add try_access_with() convenience method
Date: Tue, 15 Apr 2025 04:37:25 -0000
Message-ID: <174469184533.110.4333293420825189955@patchwork.local>
In-Reply-To: <20250411-try_with-v4-1-f470ac79e2e2@nvidia.com>
References: <20250411-try_with-v4-1-f470ac79e2e2@nvidia.com>
Content-Type: text/plain; charset=utf-8
X-ClientProxiedBy: BN9PR03CA0215.namprd03.prod.outlook.com
 (2603:10b6:408:f8::10) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA1PR12MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf4b3f9-e049-4bc5-d078-08dd7bd739ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnJYOWtDSFUzVjdBcjM3SGNlUlVZVUorZXNNZlhpazd5QTcxTlJEeG9wdHFo?=
 =?utf-8?B?Y214d3lFUnA0TDZRc1hTYndvWVMrZVRmaFNmZ1hRelZFSm9hOTJrYWZqMElQ?=
 =?utf-8?B?Y0lTTHJUMm5XMk9nVFluZjV5cjc3bWpSNmxiT2txenpYeHE2b2JZT1N2dCtQ?=
 =?utf-8?B?WVR5UE5NcVptMm1OVkk5cXBTcW1jbC9MTXliVlNWMW9NR0ZnTElFOGZlMXFT?=
 =?utf-8?B?TmxLeWZkMWZsVGgxcWkrc3BpaHNKT05QSlVQZ3dVVDdMS05xdDZHRURHQ29Q?=
 =?utf-8?B?RWY4cElWYzhmOXVPMnU5OEN2MXBjM2lESXJ5L05CNkJSSHh5UjA5clBDczFX?=
 =?utf-8?B?SFN0RTNCVmlSMU45K0JPWGJHOExXZU41bWVnMlBCV3E4dVZBMnFWOEJnOGhw?=
 =?utf-8?B?eC93MStDbTExMUlVYUNONzllaE5MOFB6SWJwSW1hOWRVYlBJaWhsWkFGSFc4?=
 =?utf-8?B?V0dqSEppZWxTZTZ3b3dnVFFsbTZlR3Fvdk1sSitmNzRqMzVoRGZTdytjTmNZ?=
 =?utf-8?B?YXpxRzZ3QlJaakM2Y0gwZlp1NTFzMCs5MHlZZnFBK1lZaFFyZDE4MkRwN3VC?=
 =?utf-8?B?WHdMUFFPcW1wOEFOeDVxdEt2b1MwbkFETUsrdkYrcU5sczJ6bXc2cEhiYTJs?=
 =?utf-8?B?TlhWV2I4d3Zic1ZVNkVDUWl3dXBNZ0YxdnZkWC9IQ0t1NXc0b3ZuMU1sUEEx?=
 =?utf-8?B?RW5JRnlQMmo5UEpVZFIzNXRqV3RCYWlyT0QyNll1RnNDakVORzZEejM0Unla?=
 =?utf-8?B?U2VJRmdzZk5JMkMrS2lCR09uemFkbjY2Ym13RUtlQ3drNUs0WmFpbC9DTXl0?=
 =?utf-8?B?RWpNeEpqRC9kd0ZjS0FKQjdkUFdWL3RlQW5HeHlYNzhvTEZZTmovQmVKV1Jl?=
 =?utf-8?B?RXh5eXB0bWo1bllGdHhRa0RHeFpqamZJZjRKVjN2T1U2NFZpQ0RXUU91QUR5?=
 =?utf-8?B?OW5UK0N6Ym12VXRCTU5wdGtaUzJ6bUlMRmJ5YTRSVVZ4TWx5dDZjUlYvRnJD?=
 =?utf-8?B?ZGNzckl4THVqaEE4ZmRoem5GeXlrQnB5RUw5Mk1yUUNHZFFLK3U1Qk1TRGdk?=
 =?utf-8?B?NnJMNDN4WnZvN0lXcHJnOTRhejlhZkY0VlhUQUFNYlhEb2FwdWpqU2V3bFFv?=
 =?utf-8?B?a010cURadEtsdDlzemE1QTV4RWwyN0M2TjdzNC9zU0lKaDlzOXVqYU9hQ0s5?=
 =?utf-8?B?Ky92T1hQaUt5U0R0YUE4c0djdGFBOUdrdG1RNk9CSk05eE4yY0dUc09VN0k5?=
 =?utf-8?B?d2gxYUgvM3NlcExqRGVDNjIyYkZDU3oyeDVXa0FmMERHdDBXME9vOURFdGg3?=
 =?utf-8?B?STl0b2w1L2EyVCtSMWNQS1VMSjdwNHFmRjZjL08vMHR0Q2syZ1lhbFJBVFdi?=
 =?utf-8?B?VmQ0Syt1dWJra2NxUjczMWtzbTRNbFcwZU9oTCthUk5KeVVNNVJ2UUJQSEgx?=
 =?utf-8?B?bUhVL2MwV25JK21renJvc21LNGFxUkdnT1lLRUxkY0ptL0VUZlhXUE5zdllV?=
 =?utf-8?B?d0NXUS9qNzliTFQzcGYvMmQycGcrSGdTYXJzZDRBbENsOWFEcWtXY0R1RFJN?=
 =?utf-8?B?NDIvdzR1dUdZdmZUMUtCN2dlRWcwMW1heURCVlRqYkhxai84OXFwSElzZkRn?=
 =?utf-8?B?RXk5RlArZ1FsbmJMTVVIcWgxbnpUdjRtWVRkT3h5bGJjMWVyTlZ2Y2N2ZnFv?=
 =?utf-8?B?a2ozbWtNbnp4cTVubFhMbmorNmM1Sld2THd0N042MkZuanhhV1VORXdmajhz?=
 =?utf-8?B?bkpaQkZ4Qm80ZFcycXlhMHZPa3RaNE5lSFEwbHRZRzlLeTBJeUM4NG95VkQ2?=
 =?utf-8?B?ZWtYWVFYT1BLVHBoMUwvNEdDck9tenV1NHg3VTRJajYrd0FGUGdzb1BFL0o3?=
 =?utf-8?B?WkppSHV2a2FKSngvakRuQ0FEVGliZFJYbGdaMGtHTjY4bVovU1RkY3o3MUIz?=
 =?utf-8?Q?O5rZEt5lsQc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnVWaXhROGFReUtIc1kyaUxXS214SXRUNGJna0lvVS96TFA4ODJPbm5YTW5Z?=
 =?utf-8?B?SUFrMVdMdjRGZ0JuUDdmRCtJM2VqZ0ZnT0diQkxzZXlBV3liQ1QzeEt0VmdB?=
 =?utf-8?B?RWxTdEtudnRGTnJIVVJ1d0ZRLzZ2VTJOdkYzMW9QZHR4ZHE2ektENmliNzNJ?=
 =?utf-8?B?U2xkaFJGQ20wOGtuVkJra1FiM2YzVXViMHNNMkpEeStLOXhnZm9WdU5zOGFF?=
 =?utf-8?B?Nmc2RUZFZTZ4NnEvQ2t6SzhFeHhPRVZmSFpvQ0dkUjQvRk5iNVdpTldiZVFo?=
 =?utf-8?B?N3lHcDM5aUlNUUc2L2x6SXJBOVRYeUtsa3lqZzIzN2l1NGNvTVJWRVJjdXZJ?=
 =?utf-8?B?QW1oK0Nuc1NkT2JqaHVSZnV5S292Q1pDcHJOWmtpYWtFb2J3Q0pjWVBBN2g3?=
 =?utf-8?B?T2tWWVBld2lrZFo3QW9rcXh1cWdZMks2bXVOQ0Z3YXRpejFmWWhnd3B3UlNU?=
 =?utf-8?B?QjQwUkQ4Qm4rQ1VTdjljeU9UZk9TTDhaNk9odUxCUUdxQ09UZG1ta0tzVHFJ?=
 =?utf-8?B?ck44UmNXU1pYM3BxTTBINGwxcDI1MUM2aWFtUFlsS2pCSGw3Snh3cEhjMVFG?=
 =?utf-8?B?UkdZRlhBT1VUZkYvSXgxTEJFeVk5SUFHU0lYd0xyaFBTT3lkOXUzR1VJK3NJ?=
 =?utf-8?B?OW1BOXMzZ0NBdVJnellRQTVGSEhUVG1BOFFudTk1Zkh5SHFQWWpSSkl3T1l5?=
 =?utf-8?B?WWc2ekgxNlNacmI5OUtqV28rZXVZcnlMbTJhdWVlMU1OTHVYMnRTNkY2Qndm?=
 =?utf-8?B?NW1jM1pXVlkzY0JpdEtkM1ZJRXh5TXRyTzM5QlNxbDFYTm00VzBiRUFKNlhU?=
 =?utf-8?B?azhTNWJuM21ZS0dIcmZYekVPeFRvM1o5YmVRd1F6UmxZRUUwM0FNWkFBMXFQ?=
 =?utf-8?B?NWcvak4vNWEwWHdRNUJldWFkekdSU2NOWklrM0FHK3JlcDV2bjhHcUlBMGdJ?=
 =?utf-8?B?S2IwWHFlL1RrM0krWlREeEpmOGwydHcrUXdrL2kwbzhObVlUUElybzJpbmh5?=
 =?utf-8?B?OUo2bDEvd3krS01GcUdhdmtQTTFlWFdxZXNzRVNhSllxQXlabFRRdyt1OFds?=
 =?utf-8?B?dnk2aUYxdkhBU0lMZEFqNStISHhEc2ZEdk8rSCtDN1o1WUYwS2pZUU5mMlV2?=
 =?utf-8?B?MlB2Rm9ZbmwweDdzdTlrTU5HNitsM0VVUFBjSlhmSXgyQU5PKzJCWXMydUhn?=
 =?utf-8?B?N21JclZTd3J2d0NUREdJL0hxSUpoOHhVVG4zbkU2RFZzNFFLZ05yQU9BZVlv?=
 =?utf-8?B?enNiSkRJeUpLYnlqMlFRcnBSOW1JZ2pVVXc5Rkc0aE9VanZCcDNsMkZWRllG?=
 =?utf-8?B?b3ZsMGVkZE10em1RN3lWdE53WE1WUlZ4cWFseWpIVVNoYkFvdWtDZW1YUFpl?=
 =?utf-8?B?UWxOVkhzQ21sQWY1SFJCeG4za0lDRUU5T2hSb1Z0NUZYSm9yQjFxQm9UU2lQ?=
 =?utf-8?B?NFQ2T3pUci8vSFFMYXVNNmdKNGtPQ2U3Wm15cWwxdWUrU2tabTZzclozZGFF?=
 =?utf-8?B?V0x4QnJobmYwbjk2TGlKUzBRS2ZxTXBIajdFNEZxcCtvODFSWGNZV1FGU0k3?=
 =?utf-8?B?VHh0ei80bVJxSldPdXZEMFFrek5SMDRQdFp6bTZWZVBtMUJFVnRqNnE3ekE3?=
 =?utf-8?B?MEJPQkhyemtxV2t0dldnNG9lbld3aER3WEwrNjluTy83dzIxYlM4UGthT2tx?=
 =?utf-8?B?RUxjUVZVMmtmdVZRTUVBaWF2NXpuUTNWZHFqdUJETXNMN1djUnF2czFzTkt6?=
 =?utf-8?B?MllxbkhaZnZOR25MYzVUaFA3RmZzb2ZNanFjQk1mL0hnVUhLKzJXTGtYUDd4?=
 =?utf-8?B?QW5SbXAvU1FRU3JPQzFYM0JpUTRxQ2FPbWF1bkI0R215R1VkSGRsY3YzdzJy?=
 =?utf-8?B?MGhCV01SRTNCQWJkYTY5aDlldlVXcWh3NXBSVU5KRHJSRncxNEEwTFduKzBm?=
 =?utf-8?B?TnlpWDVEUUZrQTNqWHhNRVNETjh0WEdjZHJuUXNMMVFaRldqbWtuVmptVktB?=
 =?utf-8?B?K08wVkRzdUYxYkdwRGRQcGxsWFhia1J4aUllMloyU20rMWM5bTRHSWtHaVhS?=
 =?utf-8?B?aGpsamNXSVFoejdvWkVia2w0enVNTXF3Z3BsSFQwYW1Ba1ZQd0NvdDUra3Z0?=
 =?utf-8?B?OU0rblVUR3Bjd1FmN0lOMjN3K3lUTG80blQ2SkRTeFJkc3krenhVNVRXQTVC?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf4b3f9-e049-4bc5-d078-08dd7bd739ff
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 04:37:27.8478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OshvKsS2rS3T/j3+3/SLklXFKHW/OZIcHUSi4rN2xTwM6+QoCJAxSDCWyai5JAFvQoP9z9AcOwTmLIxnfMZ61Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6554

Hello, Alexandre,

On Tue, 15 Apr 2025 04:37:01 GMT, Alexandre Courbot wrote:
> Revocable::try_access() returns a guard through which the wrapped object
> can be accessed. Code that can sleep is not allowed while the guard is
> held; thus, it is common for the caller to explicitly drop it before
> running sleepable code, e.g:
> 
>     let b = bar.try_access()?;
>     let reg = b.readl(...);
> 
>     // Don't forget this or things could go wrong!
>     drop(b);
> 
>     something_that_might_sleep();
> 
>     let b = bar.try_access()?;
>     let reg2 = b.readl(...);
> 
> This is arguably error-prone. try_access_with() provides an arguably
> safer alternative, by taking a closure that is run while the guard is
> held, and by dropping the guard automatically after the closure
> completes. This way, code can be organized more clearly around the
> critical sections and the risk of forgetting to release the guard when
> needed is considerably reduced:
> 
>     let reg = bar.try_access_with(|b| b.readl(...))?;
> 
>     something_that_might_sleep();
> 
>     let reg2 = bar.try_access_with(|b| b.readl(...))?;
> 
> The closure can return nothing, or any value including a Result which is
> then wrapped inside the Option returned by try_access_with. Error
> management is driver-specific, so users are encouraged to create their
> own macros that map and flatten the returned values to something
> appropriate for the code they are working on.
> 
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

Thanks.

