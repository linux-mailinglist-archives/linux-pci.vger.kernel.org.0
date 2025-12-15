Return-Path: <linux-pci+bounces-43031-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F6BCBC7CF
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 05:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 314E63008782
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 04:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB97331E10C;
	Mon, 15 Dec 2025 04:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a/bnBi8e"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011063.outbound.protection.outlook.com [40.107.208.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3699731D759;
	Mon, 15 Dec 2025 04:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765773920; cv=fail; b=fGAPiWNZW1JqoFIJbFiJVy4lvYiKCtFzMaehPjnCiC1p0pLLk2YZC8FnKbV9sm5D4PP8W4WvB40rqW0G0FDrR7hTK/poAJ825Lk4uqF/D9UHb2bEibp+mHgN8At23FF+TEJ8xPb9d7nfsfYJbW+BevIfdkt87AyxEw8J1KTXjKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765773920; c=relaxed/simple;
	bh=JbC191dPSlbyth1CjIQAyp6pLYufUgRXyNgrq+hU13M=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=neZUdEjIPxEADNWLU6XcnH1LRpZbotmaoOaqYddWJojGDW+kqwdWzXiwW3f74mDxq+Xsn1LIt3Xl8oHCVyld+DOv1dwq2lrE9DlPDs7AP7u991cT8VHX3Mvw3M5t5P4YH/2jZInPuKut6+QcbCckzNS4bLXhPc76x8qQXzh1+6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a/bnBi8e; arc=fail smtp.client-ip=40.107.208.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glV0mIOabfrRgZuDjMrFyL9+FdLx35Jrr8HRay841F0bWEHr62FC5IfYzF5Qg+f2Skfl0IluAQxfdS3Qf1xlR6D1y1B6SBEYbZjlEE7no2fMNbaoIX2FFnr0vnX1GLsFsDkldlT5YgV9jvNbYjCFred2SX8L1o8eFTpvwOfsZSsMloDALP6Vv+38LsqfbRtT02VBNuDry+iXDRhY0gNGXh1pHu22imA91ExEuQjQgYDtEFtPZU338nGShc+ct+sf0vSIM0kR87ryAUctWYNPe/mo7+kIF5jXj+8OpGHUFvd3brwb2WrG6Hl9KIEpP5IB145SZtoqJXJwwk20iKe0oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbC191dPSlbyth1CjIQAyp6pLYufUgRXyNgrq+hU13M=;
 b=IIYekNC3I1v13sRjRH3HbkksoJabZIR8Pf5K30+3xEz1xw30fLQLCiTHVTvZu4HWg0xxh11hJgXBnTgy3/II6kvCaFPflP62YRfw7EsFUt7859Ix4k3V1Q+l/Y1quSTzt+bcdweUsNy19HbZLkfHHZE1RccWrUN/koqJmPCN91ZJeeae7GDnQJ0IR9nEeiJ6hlQLLnrpPyCq/NyoAWXC9ZmCnslaJrSweKzA6zM6k/Yi5aBjEr/2oQxduXJp5sSqoBfuNEWetXMcmBJ/5aAGwa8INYzcufM1Xcc/3aW9q1WNeuhRbCwz0L3kb4dfbahOPp13E23en/CnucIy0Fbfpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbC191dPSlbyth1CjIQAyp6pLYufUgRXyNgrq+hU13M=;
 b=a/bnBi8egyX/0hwSM4n2IozJiCG2prnfMyHdBdIrVRDRfWMpUy/0WXwaMRNdwp46OjCUmXqw/itOj74VkWxZ8yMIdeN2fBA+wwxWI1S/WbdmoXC4rK4ppx5AP8U+pmJb3h/XE/FObq8wf2wbbgVSJiZMeZytZhPmSKIuSK5p5PUz5nUF2ptpC4GEQrPJHXe3G9gntZ5cg7AjE/tCAmTMP/cvMFqjigQvwj7bYW/hcS8OD/WIQosodT849xbTcjZNsq0Qj4in25x3X1hC7lWX9clvYYC6CHnteT+IxzBd5mGgGx2vcTRigcOAhGYiUzLNbZDS7sC6mUFXpReIsWTYCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM6PR12MB4122.namprd12.prod.outlook.com (2603:10b6:5:214::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Mon, 15 Dec
 2025 04:45:16 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 04:45:16 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Dec 2025 13:45:08 +0900
Message-Id: <DEYILYUO4JUG.3BGBWBQSN2CCX@nvidia.com>
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
Subject: Re: [RFC 7/7] gpu: nova-core: load the scrubber ucode when vGPU
 support is enabled
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251206124208.305963-1-zhiw@nvidia.com>
 <20251206124208.305963-8-zhiw@nvidia.com>
In-Reply-To: <20251206124208.305963-8-zhiw@nvidia.com>
X-ClientProxiedBy: TY4P286CA0099.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM6PR12MB4122:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f2d586-01a3-46d2-2297-08de3b94bdef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUltTFluKzRxOXVDbW1YMmFSRmVHYzNraUtOeWZUejhMZjBEbjN0dWRYNXdD?=
 =?utf-8?B?NktsNVlVbkVRY3JoV2tnQ2dZK1djVERuS3VNWmY0UVdEWlE1YWJBUWR0Q2tv?=
 =?utf-8?B?L0lXZ0NBV1o5RnNmcWZQZkNaSEVrTnFBVlZpUUgxU3orMmtkMXNEcG12REhT?=
 =?utf-8?B?R2ZNR0JTWlFGWFpzbk1uMkkvVHpySGpBNHozYnBESTMybnN5b2ZZUFlPSmVF?=
 =?utf-8?B?OUxSdW1FczYvNWd0b3ovdkJ5SVVWNVdtYk1STjNIT1NjbEhMVk1IQjBwL2lo?=
 =?utf-8?B?ZE1qMWQ0dkdGVTM1WElVTDQwWks2eEU4OTE2dDFEV1JFRngwWkhGbVN6ZFJ5?=
 =?utf-8?B?VE9TTlBCcyttcW1aZmZFTmZybk0wYlN2UzlObmJsbmtUVGpZVW1NZm9Vc2pl?=
 =?utf-8?B?SlhxdHV4YzZaODg1TVlZdnczdFVhLzUzdmU1MnBUWDNvL1JGcyt5NEl1dXJo?=
 =?utf-8?B?ekxtYldHOHJpVHhWY3ZWSmV2RDdxVWR6U2tPeDlIaWM5RHRmNG14dlBqRjh4?=
 =?utf-8?B?WFdKTXNKaFY2QTRma1FablpLcUVLaDI1WnBGd3lWaWd5Rm5aWXhLeEhvNU1T?=
 =?utf-8?B?ZG1YSnNSc3JQbFFMVkt4SWlPc1hkZzdjRXJ4K1lkaXpBZDJPVnBkR01QN2I0?=
 =?utf-8?B?Y3NqdGFKS3p5NTB2ZGFvc0YyMlVtU21JdGhBWklnVW1WWGlZZ1hIbUt6SlRj?=
 =?utf-8?B?b09EY2hvOEV4OU9XOTF1ZHd5RGhCOU9MdVF6TmdKa09KZkJlbUxSblRHOEJ4?=
 =?utf-8?B?SWNTRGpGWEFuUWIwWHppS3hxT09yMytrbTg0LzJwRFRWODAwS2FrM2V4MWZa?=
 =?utf-8?B?cmlhN3BZQXBYT3FWNFhQbVJVcERKcXJwVzdjV3Z4aU5vaHZneElJSWx2cGR3?=
 =?utf-8?B?WFN0YlY5VFRVVEJWR00yV21hem5GMCs4enhCUE9sb21YcS9kRVBkS2ttUGg5?=
 =?utf-8?B?UGxSVnhGQm9TSGVyeCtxb0RyUTgzMVZWN1RuRTlsODV6Y2psY3dHdThUeDJn?=
 =?utf-8?B?aHdJN1l4TkZHVzg3eUFXYlZKMW5jRmQ4OEtNYlhCZjgzYS9OZHloUUpNYWcv?=
 =?utf-8?B?MGs3M0dzQXhrQTl5Wm9nTXU0clkwdEhRZjByWW9ENTBKZm9UdmNabzB5dEUr?=
 =?utf-8?B?S2JFOE94RGd4MnZLSi9PVnlweXQ3VnF3WFZNWVA2eTlGMS9jOGM0eGwrV0U2?=
 =?utf-8?B?ZGNERDQ0cXhYYjhsc0UrZGhkWFM0V1NiYllkYXpJRjlYSDgrQmtOSTNLaGsx?=
 =?utf-8?B?T1BhZVk2SFcwWU1qRkFMSGtTYno0MGpVRllHS0ZyUEVzMThWUXJuNEM3UHdz?=
 =?utf-8?B?UTZYV3VSMHgxM2pILzhSNW5JMXhYeXQwMHZEaUpZcFhySEtCSlpIbEZYdVdI?=
 =?utf-8?B?RDBicDBNZW9rZUxseEszMytRVWFMMEptR3VMdDFvbGxZdkpwZ2NtUkFLLzNH?=
 =?utf-8?B?VDJMWFhjL0ZTS1Y5Ny9EN0x6YjVvTWNBWENYU2I5TVZzRWRyUW5VeDRpK0xF?=
 =?utf-8?B?eERIUXB1cXZqVzZ6QzdCZGxSZDN6VlpDN2xpbld2QWVqSHAyNk9URDk4OHF4?=
 =?utf-8?B?ZWpNQmtkOHJ0eCs1b3NZTDgxYWs2bWFSMTUwNmVUcHhOOUxBeWp2TzQvMUtv?=
 =?utf-8?B?MEN1K1lFRUxsdzljRmJhRFUvYzlnMXViOEt2RVlJZVgwekxZdmVMUUVNaHcx?=
 =?utf-8?B?VzlDRTIwTS90Zjh1M2kwUm9wSytBTGhmQy9zMFdjQ2E4bUlKM2M5SlNGaStC?=
 =?utf-8?B?Q3BTbVVHZWZlVlZCZDVDZTd6WXdEM3h3UktVd2RrRzZIa1RhaGkwR0M1UHRX?=
 =?utf-8?B?YWpPdlowUlhTMHB1c3Y2Vm1YWlJBMlNXY3FBUDNuOHlXUk5tWjViL1ZDSVNX?=
 =?utf-8?B?RkNQMGs2dzFrRElYVkxNY24wUjNURS96RXhHSU5mL0ZscHAyWk8zUUtLQzVt?=
 =?utf-8?Q?zeRxu8nFo8UsxM6p+ilMz/OENGHOFKqX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akwvSWRxSGJFa3N3VnVqT0RxRWZ0R3J3NnE2M0ZKM2lBM2JQUUJMRlY1TDI0?=
 =?utf-8?B?bmdNcGF4a3dlZXNtK1JjSnBVbHpJNDhMUmdoS3NRUHNOcExlbDRSNkNjUFZS?=
 =?utf-8?B?ckUxWHY5RGg4L0FmclN3Ull3emN1RWMvcXpFeVJCcE82Sk8rVUlIdTRQeFFz?=
 =?utf-8?B?WnM5TDhaYU9IMlFxY3ZnNXo4ZTE3VjNpZTd1YURoRVJzbmNmd3daNTdIb2NI?=
 =?utf-8?B?cmhReXJPU25naHJFN09IQTVETGowcC9FejNFcGUzYy96NWt5aU5lclcrSWwr?=
 =?utf-8?B?WW9qdWVIYkh3TlJGUmlOWWtjK29oTGJndEg3N3J5VkVZZEhPZzZNSm9KeUdL?=
 =?utf-8?B?NGx3cy9wOWorWFdyc3RseVFBWklFWTI0SDRjd3hwK0pLV0V5cEpNN2xHUWFj?=
 =?utf-8?B?bnBydS9GdlZHK04zUExZTGM0cTQwNi9qT0lZLzNsVGJCb25nckNMVnJYeGRE?=
 =?utf-8?B?b3VHYnpZSTZQVWxyVFpMUFZUWjBtTjlkY2RBZ28xdDJLaGpLWnJKYzdybGxH?=
 =?utf-8?B?bm8xcGtUeExHQUNtTWMxNDBDWG5NTWhabFFlRGFicWJSa3pWUzdOY3lpR0tm?=
 =?utf-8?B?TlROYTJyQ2lpNVc4MG5lRUkrY3lXOEJOOGhLb3Q4NmlEbS9id3ZhZTIydlhO?=
 =?utf-8?B?TEVGdWkrYjBpb3ZIYUhQQ3VtTUZiWVhhSGRJVmZLMnc3eHp2eEk1aGZxcG5z?=
 =?utf-8?B?TnF4L3d6bkVtL25OdlJiajZjZnRxZ0VHeHJvODdaclZES1d0Z3RIUmdQbDdl?=
 =?utf-8?B?WExqN2xNakV2WXdNQytMT0JzdGVOazJ3bVlBOGdNQ1R5UGRBSHA4SEhna0Vt?=
 =?utf-8?B?ZXd3V3hYN21QWGZVSGd3L0dRN2x1TWNFSUpwaEZEWnMrLytkNnFPOHYrRkpC?=
 =?utf-8?B?U3JrSi8rQmh0WmlyTzRJTHlFTEMzQ3V4ZWNyQW9PNHYzcHd6dzJRQ1JjTVZu?=
 =?utf-8?B?aDFEQ002dWNZQnljMDQzc2lFSUlVeEQwaFpSa3J3R0E5VWllU1h2YTdJMlpE?=
 =?utf-8?B?aUdsTThSRWU0VGxhM2ZHalhQRG14N0ZnNWtNK1dLVFJtNGxiNVh1b2lnOTdO?=
 =?utf-8?B?clJMSmlyWk9qVGlUbUlGT1FQcTlLcFI4SXRObGNVcnlzS2tQUDVrYnNRWVdZ?=
 =?utf-8?B?S2FoY3hicUpWRVQ0SEV1YWV5L1RlTlM4dks4SkdrOENYRGNrenZzV041bmEz?=
 =?utf-8?B?SlJrcnRpVkJPbUkvRndzVStNZHJuZkdDQkY0Z1BqQ29RYitlUFVyK0U0WHUy?=
 =?utf-8?B?Ti9hMUtzeDdXNWF4NFJvazJaSUczV2g5SWtLejBLTElSWW9kRmdXbmh3RDEw?=
 =?utf-8?B?bGRjRTdKb0lzb3k1MGFRenIvTmJKYnlKV2RCUldqRmZ3QnJnUUh6dEJaYlF0?=
 =?utf-8?B?a0ZpTEw4L3RmQVNzNWdCRksxZnZpMTNabFVWSFQ3RjFLdExKM2VHMGM4ajN2?=
 =?utf-8?B?aHM3bERsOVNIQ0ZqWEpxNnFFTW1zS1ZMK0FUL1dtaFEwVkFhUGZPRURWNUND?=
 =?utf-8?B?V1B4ZzE2RGtmQldSdDFRNFQ0c0p1T2RPUUowbGpDMVNlZnJNc09Sc3JDR0Vu?=
 =?utf-8?B?UW1XRWZKMkRwcUM0eDlDa3ZRQUFMUHZwZ3FtKzVRbUVObm1paHkwUDVxSUNR?=
 =?utf-8?B?SmNidkN3b3NmR2hrd1BLODVibUExTTJ5QzJReXBHNzdBVktGUEI5VWU5SVBH?=
 =?utf-8?B?VTc4dDlYdmlqdWJHdGd6SFl5N1RQUy8zaXFheXgwek4wVVdhVngyWXVnZzk5?=
 =?utf-8?B?MUQ1ckVvd2N4bm1UMHE2aGd3cVdSTFhXM1d0VGVHS1MxbjYramRSUjFoREpG?=
 =?utf-8?B?eFhGdXZZOW9ZRmJLWlpPSC9aUlhrRGdraSthV2RGbWR6dE1wZkl6d2c2MHh4?=
 =?utf-8?B?T1VIdWhCNjNmeFhLcjVqcXlHeVFwalFFYnd6UU5JaWxUbVhuWkJKUEQwam5B?=
 =?utf-8?B?K21pRE9rOTZiLzRqdVptdDl3WDMvN3NCL3NPWTNseUVNZzJ6M2VldHRvbnB0?=
 =?utf-8?B?N0x6MThDaWRISU5xY3UvZklHdW5KQ3ZIemJNTjFMdzd4ZUFQbFBlZHZycGRK?=
 =?utf-8?B?TFNDRkM5bjNqOFg0YjU1MHJqdmlpUzBqVFVMNnJwc2RzSkNSYklVQ3h6Zyth?=
 =?utf-8?B?NTd4RWxLTGtHUDN0KzBqdVZycm1CVlUxcjdCZ2xNZzA5SnEzUnVLVmhHMFBV?=
 =?utf-8?Q?FITv/v/UC2UfeMXf7cuqo/mSgX/xqjYxZ94lKT0YwQ0+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f2d586-01a3-46d2-2297-08de3b94bdef
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 04:45:16.3867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ic9Bd8yleyyM0qMcg89ZWjW7C3wnmjAJ+TBZuNYpzxMjChnkxOG8rZ78mlBF8QVoE117r4JgfRH1uPTgKCRVIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4122

On Sat Dec 6, 2025 at 9:42 PM JST, Zhi Wang wrote:
> To support the maximum vGPUs on the device that support vGPU, a larger
> WPR2 heap size is required. By setting the WPR2 heap size larger than 256=
MB
> the scrubber ucode image is required to scrub the FB memory before any
> other ucode image is executed.

So the trigger for running the scrubber ucode is not as much "vGPU is in
use" as it is "the WPR2 heap size is larger than 256MB".

Can we change the code to reflect that? We have the `fb_layout`
structure available at this time, so it should be easy IIUC.


