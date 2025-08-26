Return-Path: <linux-pci+bounces-34792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 411F0B37424
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 22:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6A36886C1
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 20:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92432848B4;
	Tue, 26 Aug 2025 20:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L2645uTW"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646C4285C9F;
	Tue, 26 Aug 2025 20:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756241940; cv=fail; b=iovy9m+5LciP0G3DvBCzI1q+lvWqU/NpMizNmZLyKmS8Xzl6oOR0W/yEeAB0ygJ5p7dqDwMv4jGp+1j7G+G8FXaIgwwHhJ57X3+6O3Emohl3H38unqfru6mvbTiZI/crlnWvbJXvYKgtqB1wx8XXgEvdZLUZv2YQulAvgnGMYbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756241940; c=relaxed/simple;
	bh=ybX5oyUT8LlS0aFIQipva0IIpEgFSATns5JIgiKqSx8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tbzIrjCYVuFgQqAhzsposxCTzdpmH70RxyLVUnpdpNHF7DJf83ojywJjWssicPAiEKq3UHMz93Nra/K5GbylkeFXSofHK0gwsHSGw8M6hCYS4LezeXcVmeuSWzgh98bY9T+VwjlmJ5ADIjFW4Ti7jhj0aVXUI5/d8FXMzjyNgh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L2645uTW; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbsdG7F3gHC2ytsJr+JpgrrAZ9x5yIlzedzl277D+gPeTK95jGaGqwVd3/z7l4fToEsc5KeV3GsbW24OL+RKLlSG/sex42LnplGE4hkNbwhNjz+pfG6MD3S0FFpEgJ4JiMx84P9eGDc7H06ql/jdFsvd3O3qnMdAUPTVLKUEZjp3sgXqGi0UbQRaMhGfBHkbQIwP9nvZt8nRCh2yRyI2SLm/ghr2MusJ9UBPP30rudjCqjx7948FrvvuoSshpfaA1PiXKQLxZsYB3QcHXSsMdaAnvC4f2QB7v/vM3LMyPuQw5VDp3FCf9Ts/5u+l+b+ceq8t2bFQuwB/wgb9tpFu6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdEGDD80bj6qNLVcd+0uAfrs03YPaub3dk17lhF6xq0=;
 b=jzJnP8dNE2PBGAtun2tOrOXijE0C6MoQWVBvvNZhouBf7oDv/QGtdovWMquUM6iksNfebTOlSGF/pSfwv5bzxDCod7XRW45529X64COab9hrxKOngxlLPjT9BqiiRtSeBiWLnbyDrkilgYWO3Pia6RBUBK0gnFcOTGKYC6MdIEdlswHJAMZnivoorJ7lVeCU72xWJhWK1GiTHFlQ202KAES2R4t4PjRddReTIr/ofr5TQcxg1hZ2NB7JPaJPnGyJvBCpclOftI0PvGkVp97J1p8VLTwaIhksXMiZ3Bj+sn1+KXFCUlDJb2kuI1F3YVEkQFrs4kpNkARd3LeADtSscQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdEGDD80bj6qNLVcd+0uAfrs03YPaub3dk17lhF6xq0=;
 b=L2645uTW/6H6LdjO03Psh71UEATlIKsDNRtXdBfd1M+AaPoAdJvFgNzl5KnrGpBP9a3IhPc2T9v5qFstuiNd0PO9XUiz7q0M15+fxD9tgE8YVv/q856vs9Kc6cQj2Vslw3gclqbesEhqA3p3/q6bgig77a/JJF9BaqtMcSDUIL28vLglSjntGfPQCNcvPA4HlFGZJmz4kT3bn0GU4OhEP2EvNj0rueof6G1FC7zHYRFmCU2s8Zs/HVEKN7a8+5I02TXAkYBBa0zplOEmdovyrum8pUXq8GDzZeI05IQmjIQ8R3tD4Vh18Q3aNIjipe92TezeByVQ46AriaWqe+YWHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by SJ5PPFABE38415D.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 26 Aug
 2025 20:58:54 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 20:58:54 +0000
Message-ID: <65072e90-a1cd-43bb-bc31-04b16947113f@nvidia.com>
Date: Tue, 26 Aug 2025 13:58:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] rust: pci: provide access to PCI Vendor values
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
References: <20250822020354.357406-1-jhubbard@nvidia.com>
 <20250822020354.357406-3-jhubbard@nvidia.com>
 <DCBIF83RP6G8.1B97Z24RQ0T24@nvidia.com>
 <DCBIPY9UJTT4.ETBXLTRGJWHO@kernel.org>
 <b1cbdc99-317e-454c-bf03-d6793be5b13c@nvidia.com>
 <54b19bdc-5d88-4f71-ad8e-886847ccee8a@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <54b19bdc-5d88-4f71-ad8e-886847ccee8a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0331.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::6) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|SJ5PPFABE38415D:EE_
X-MS-Office365-Filtering-Correlation-Id: 43166ac4-aa18-47ab-eb46-08dde4e35e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2J4QnJBM2xEQnpuNHh5REY0UVRmNFNnWjdXS2dybFozUzlYVVozbDlJNERD?=
 =?utf-8?B?emE0TTAzR0dtRFpHNHJFTTFkNUhqQTFwZ2NBWk1lbGtSeTJScHQwU3lUcFVu?=
 =?utf-8?B?d1ViQkZRL01WNGV3bGlQWmRjQTNCeDdpcmdVd0lKUnhJR1UzY2pXTmxaY0N0?=
 =?utf-8?B?Q1BwVzBvRUk2Mk8wUUtDZVdlU056SndzZVJyVDBaSDZTd1hkNXFHbUFMWlU1?=
 =?utf-8?B?ZGxGczJaL2tuem1IQ21KRXhGb2J2T0oxQklBY0lIVHA5V0hJejlpUVhSZmpu?=
 =?utf-8?B?TFIrR29XeUh4bWtqR21IQ0N3dlNBYitEb00rOVVvdU51aUlNZDRVRUZEakNM?=
 =?utf-8?B?TFVpSGJNSFcrazUyNk82YXgvcm43bnl0QWhlTUF5NzdwVlhWSkZOTlJHajJE?=
 =?utf-8?B?R3NuSEZJRU9PT1k3WnRnb3hidHFEdEFIQStuMmlTUXlrNlJ5SWZ1eWpBYzFL?=
 =?utf-8?B?T3AzbGx3S3JXelg5MXAvNTc0YnFBTmJxbktnbFQ0cFM4QndiRnU0YnVkR3pt?=
 =?utf-8?B?MnpVMWQwTjFpalEvdDdZU2szblRnSVg5Yi9VcSt6YW5tZmZsZmRGQ1BhWFVT?=
 =?utf-8?B?eE81bitMU1F0UU1rRmYweTJzTzRPZjYzajFhNzNPR3RQdUoxS0tUL0xucG9P?=
 =?utf-8?B?bGduMUl5ZEc2REdBRUxISDdkRnpmRlljbnlyY3JGQzlPTWRBdHJVQ1BDcFpM?=
 =?utf-8?B?VU5sVFdVOHdxbW1FWC9UeEdXcUpRSlNHSXFOa2M0Umo0YmRweitVSERtZDQx?=
 =?utf-8?B?ZXVrNEpoU3UzV2VEbG1heE1oVEtMVEEzdmRVRDJnMmdybzBNUFV3RytJbk5U?=
 =?utf-8?B?S2tVbWQ3ZzYvaU1kWmo5NUwrMXpxQXo3em9MVktBZzZodnhaQlR3dlVJaXp1?=
 =?utf-8?B?ZUpBdjcxSm0wdHU0U1FZTnIwSWJZMTlIR0NPRnh4VzU0ZS9sRTBUNVN4aHZz?=
 =?utf-8?B?ZWNqRmtSeGhQbXNQOThZbEh2NEZXVzV3UXF1TU81QS9lQU5YNEhhTWR5MDE1?=
 =?utf-8?B?K3I5bWVHbGxjeGxiK1JaREJFZUd6OWhhcDFxaEYrZmQ5a2hDQjIyaC9KRWpS?=
 =?utf-8?B?QlBiSWZjYUdsOTd0VSswb3d6YXN0RFhRVTJyZ2pqeHNqeGQ1TDVqMTN4Vm1T?=
 =?utf-8?B?bnNtSUZzbTVKR0lhUTd5QzhuK2NvUW1VcmxQVzA5OUJsdFhjcElUaEdybm9v?=
 =?utf-8?B?YjljczU4RDMzK2kwWWJFMXdQQnVVbEhHK1NIeE9FTFhBMGdML0cwUHpaQThn?=
 =?utf-8?B?UlVlSjJLS1VOekdZaUx5aTVOY0dsZVJROWw2SXZrUlJkRlFvNkphUjZ1aUND?=
 =?utf-8?B?UjlGTXRzM3o3Vndkb2hEYWM4ZHVBN2VjYUJXa0NTb1F1bzhhYTN6dzNtbHRu?=
 =?utf-8?B?QmhIZGdTbWt3MHU1eFFVWmRyUzV3V0M3ZDBLRlJMSzh4NU1ONGpiZ2NwSzdS?=
 =?utf-8?B?WGdkN1BDNzZuRWpkMXkwMEJlNnEzV25JYXlyWktWWGZjSnhUcjJpKzduWklV?=
 =?utf-8?B?MWF2RHNVZWRmZjVNdjVwdUw3QTNQaDBYYUI0VEpSSUxUQVpaeWJPYWJJbWR1?=
 =?utf-8?B?T1pkU1lOYlZGeGNFclVWRzJRK0crZmp4b1JSTE9CN2NkREQ3ek5pcHBtTjBa?=
 =?utf-8?B?RXVodEJreUVQK1pOR2l0aXIwelAvYXRPYUZ1VHdDQzRhbWZsQVhuMUxtMGJ2?=
 =?utf-8?B?S1A4aE1UVkZ2eVQxZ2pVVHYzYy9tZ3ZvUGp6MlY0S0lLdmNlNEgyTTlJN1NH?=
 =?utf-8?B?NXpzSGN3cUh1WERhYnRpZHRLbHVQYi92TExpcndnbnorUk9kaC9leUZpbEpj?=
 =?utf-8?B?aUhGai9sRUZCeWJENG1BSHdnSEZJSTZnQlllRTVPZlZkR0VKWEcrOXBNeitn?=
 =?utf-8?B?QVFCaS9OVVM4c3E4VW9lWUZ3c2h5NysxV1NERlhwWjlYVVR2a0JnbVZaWE5T?=
 =?utf-8?Q?l8BEA/w9dDs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDBjUENVd2RnUTU1WkUzOEJ5d3kyU3kwVVdXTTBZWFVkMW5IaVg3S1pDQkdL?=
 =?utf-8?B?WG5uQTZ5eFo0bHkyRVFxT1l4SFZHbjFjaHJYbnVHRG1JdHU0bWx1b2I0d25T?=
 =?utf-8?B?c1B2U1AvUFlFT08xZHBEM1pTR1l6OFpHQjJtcklxUmJSaFM0QjlESHpLcmxq?=
 =?utf-8?B?ZmRTb3ZXVHZ1ZmViRjkyU3hXd1NVbCsrY3o5eGdPUmYycEFpcDBmTm1mSXpQ?=
 =?utf-8?B?MVlLTEpRQjB5SE1yWmo1UThqdTZ3Y3ZjNlBMcE1WTFpLa0xmMkVoT2J4RThM?=
 =?utf-8?B?YkVjdk4yOFFlUDRWeEUzdGR2WmNNTnlIOWpzMHgxSUZpRjVobjM3SERNalpk?=
 =?utf-8?B?c0RrOHFDM096WUwwNnU1UDY5ekYwVUZjUW85UHV0Zzg3bGZQNlVwTUpwTnZr?=
 =?utf-8?B?OTJPQ1BERWt2UEJSeExqc0JobG1YdmZvRHhVbFp4N2dnck9kaTBtdUF1UG9t?=
 =?utf-8?B?UGtmVmw5N05ZTE9HQjFhVFJoUHVpc3Vwa0RXYzM5aWtzMTdlVW1oamVxREtz?=
 =?utf-8?B?ZmQ3eXRqYTlvbWdhVFAyT3ZYckl1bEk0ZkVBQkRVRklVSVc5SC9wTTRFMUZU?=
 =?utf-8?B?TEJDL0FFOE5WRWZVV0xWM0ltYWRGQkM1V0V0dDFDZ0t0SGNLM2Jnb0s4NkYv?=
 =?utf-8?B?OUtjb2hFWTZsakxTaDA5bzUxOUZOTWZWVlFoNVcvdVhLUGZmTTJTdEg0ZkFa?=
 =?utf-8?B?ZTVEOHl5cXdQVHlEcHdUcWNaSGdmSVhIQzJvYkN3eUQwQklKRTNKZHhuMm81?=
 =?utf-8?B?WFdmR0ZicHlxNGJvZmFxTk5URzBib2FVL0xQNFJvZ1JsWWNpUzdPRjFsOUkr?=
 =?utf-8?B?TFBnaWRGVWlLK0psMDdEQURHdENseTZOb1A4QWl4SlBLaTBGZWJPc1lyTytV?=
 =?utf-8?B?dDh3MVh0QTVQTkF3OGNQa05vMHBEVXVhOUVBa1JtOGtRSCtWUG1YYlZCcnRB?=
 =?utf-8?B?SUtacGMyV2hJeU1DN0RDcXBnZ2NmcDhKWVJNWnhFVDl3d2NVT0NTT0xydm55?=
 =?utf-8?B?OWUxeFhBSC9lSDMraU5Id1JJMmlVM3NRUExINHVFWWJrOUdCS09tQk14cGN4?=
 =?utf-8?B?RjJ0SkFnemIzamU2bmFSNHhXV25oYlE0dW9ONEVVVUtQS1JyTVF1UkF1eFBQ?=
 =?utf-8?B?em1NUHpIM2MxYnR5RDhkdVVrRXpUOThwaThnUmtIRm5GTzBIS2doaWlTQkJn?=
 =?utf-8?B?ZGVaZmk5eXV2eU14a1lBRHdFZ1JYQ1lxY0syUS82UEFWeW9wVDNPRTV2OU9l?=
 =?utf-8?B?R29zZGFxajNDdEduSUlVNXFIRWFZMkNGYUR5aXRhc0ZiYXVSZWRNT3IyOTA3?=
 =?utf-8?B?cUw0WjJIeUJFMDFEcGhXd3ZrSmowS3c5NGJWeXhIZ3RjQ2JUWXBwa3dKUjQz?=
 =?utf-8?B?bVJSYmFCbkJPMkU1Smc5NkdBU0ZPb2hjWmEwT3QrUVZOa29tTEx0V2hlMzl2?=
 =?utf-8?B?dGNhM25KYXdRSVVVbjNDOExmT0FZa3ZqUWFrNnhQTFYwYmRTNlhxUjBuZmNu?=
 =?utf-8?B?bll6TXVpVFJWOTY5RlIxS0V1akFSTERWRlRrNk1JVm0yQVRlNFRaQitqVzRW?=
 =?utf-8?B?a0M0TUN5cDMxNWZCTkRSbFgzVnFOZkxXdURIMnF5MzlEM2V2RUhyTk1oY2dp?=
 =?utf-8?B?QUF4U0tzeUw2TTVTNmZKTk16eDNuajI2ZjEzN1FYRmQwRHIyWXJPYVFVV2h2?=
 =?utf-8?B?Nmh1c3N2RlBEUlQrVlZTNHE5OUljTDdpdXJtcVlUWXRWN1dERVlIZGhoYlBq?=
 =?utf-8?B?dDIyT3Jyem5HOXNmcEJPbGdxU0RxbU5iTlg2YmZXT0ZxN2tYaGxkazAvZEVZ?=
 =?utf-8?B?K0wvTmIrTFFUeWpET1B6bisyYWdEd3FscGMvUDk5QWxYYTk3U0dRb08wSHFV?=
 =?utf-8?B?RmNNVGpaRVk3a0RQa3dYUnVxOVdLSHlFYzZkMEpYcG0yQUpEcWNDejVRREo0?=
 =?utf-8?B?UDBFYlVNSlBCM3ZKOHpqK3pFcW96aTluVi9PaE9rZENKZXhCMGI4a245cnR6?=
 =?utf-8?B?MFBUbkJwNm1WZENuTUptYVpQenl5aFE2MHJZSVM5ak9HaUlJRzZlSm1xMXd2?=
 =?utf-8?B?RHNZU05CRHlDdnlWU0RxczNsMW85YXZtU05tNUovQldBSURuK3ZQM25qYlpB?=
 =?utf-8?Q?lCdwydFADUw6R4SOUUeCLp+Q2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43166ac4-aa18-47ab-eb46-08dde4e35e1c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 20:58:54.6157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0eix2sRjKXN0E1vbMoSVeb7ugZt1k7cU8voKZZy8GwrylmijwMbmP+hV+4g4Ku+8ZaYc3vdka2sakyIDfQV5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFABE38415D

On 8/26/25 1:45 PM, Danilo Krummrich wrote:
> On 8/26/25 10:38 PM, John Hubbard wrote:
>> On 8/25/25 5:47 AM, Danilo Krummrich wrote:
>>> On Mon Aug 25, 2025 at 2:33 PM CEST, Alexandre Courbot wrote:
>> ...
> Sorry, that's on me being not precise. When I said private I meant private to
> the parent module.
> 
> The diff looks good, thanks!

Huge relief! :)

> 
> Please also make sure to add #[inline] where appropriate and rebase onto
> driver-core-next.

I have no idea "where appropriate" is, here. These are not hot paths, and
the existing pci.rs methods such as Device::vendor_id() are not inlined,
and so my initial approach is to just not inline any of this...

thanks,
-- 
John Hubbard


