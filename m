Return-Path: <linux-pci+bounces-37378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC91BB2097
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 01:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4BA188CBDF
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 23:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67574291C33;
	Wed,  1 Oct 2025 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="scjB3GQR"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012047.outbound.protection.outlook.com [52.101.48.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C015134BA24;
	Wed,  1 Oct 2025 23:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759359631; cv=fail; b=sHtbggDzThqq2bPOfEh28T3T9grAOSM9EErigoITU7BYrxVKwu09Hzlh5YyQFGgYvZjN1re7ks3tJ+xiGRQvPHdOVEPbGsgsS6AirD2BvDnVBYjg7nYS3CNSFXa6x7+jsQj2ltcgeqFnYY3VfR5vIh4WF4ajwhK+kon/9qbVt1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759359631; c=relaxed/simple;
	bh=9InslZtgG73seqTMgVIGmkkoFihEkCv1PoG3L3Om8io=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S5GUMV4kOCuZN9XXZYeSYlYOvyIKPvBo1kT0WA6c6t3mCN5hLzMPS+dWxLgvAa7cGQF0LQzbLfe5CckifVhXTxQ2TEQIF0ig/V9FIfwRytTFWJs1dVA3g+Nzrl+lDm4ytJ2C6ggeaKRb6zGK1SOZju0xfLpJishGmph+UztfDVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=scjB3GQR; arc=fail smtp.client-ip=52.101.48.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmKHYb1Z+Cewn7J0QS8L3LBKKI8DRA+GwQRQOBSe6iF7KiEaIDj9J65vjfClOqPWAvIUgNfYclUVollq5untk1QWCeN9Lcj66orOtwjNLXxgw2jx/jNPhkChr0CJTWr2/ceHcXBaXO5dlV1MjLVxGJMHjYbuX2i1R77820Pf0Io8tPOgjpBCYi/ZwzR/SM0nUIycUJYU5vOskivdAkhxnqFjrUiJtO442FH9SFj1GrTBifqp1HDx1Ym/HcIE0sIufgkAIpPjLbpfoEmhwpl6135xHTc/63LISUg3aur3G2ClRB18U4pRXTCCiIr9iHc7zlRLAbE5Rnd60JjMntun+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fi0F4mjCHHMshZHj+uZJUfbtJj2IXtb6UoN4aFNOoG4=;
 b=KpGwpPHagWpQHAaJOFQF6pQu3Z5NzsBTyp7NdvJgq9LPTqEGOy0cabP7WPY6Gotk+j2lDUm7fSyH33KAu39rcZqwT6SKv9IKaOPeurtp74QLnVD25YE4Pn7jBSBz/hMyMlMiKbOGmgDLNCXJoEjDcZS+MTcG9JiO2it+wSAvPvetX3Ek1HL/G/cLnLpVy+HfMxj+nfpEaf7pplnPG3wGXZ72r9XJYBQlcrhpxNuehg1Jl/mV8nVvzKmDFrwkLHIO1Sooqwegj6F5QFBuWDOGKxOvHkYJKw5cElNEtHP9oLaDBre5HLlWwv0+ewkneqV708PYRf8w7wLLsQ1kR4Hjww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fi0F4mjCHHMshZHj+uZJUfbtJj2IXtb6UoN4aFNOoG4=;
 b=scjB3GQRm+HCYj0Yibk9/Y0x99G6v66jc6KqrfAWGfBRgqfzbbkwViP9WSg/R6BPbxaUxLHjj7+jUttaLQaTgdcobgw986cjArr8OrViauk5beazEoKcQOD5FJyphJCmnt+NRvR9zUWhwj/kGJDWHJczrXS+a1eTraq9myb+nBkSrGMiZ42EaKgqdvlf8MI7i1SwfOmEX1Z1+89u8Ci5IB+SmiYIaj71iwMUuRTr11JbaLKEo9KF6TxmDHh8qQbOxc4bDV2BkA783Svst0+UjMFQ+dXp+C8UWs8UoBo0lAf8T5DiF/iA3A3kBn9K/a9em3Yidw+U+43r5IwPOkUCEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by MW6PR12MB7070.namprd12.prod.outlook.com (2603:10b6:303:238::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 23:00:26 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 23:00:26 +0000
Message-ID: <e19781f3-1451-4b4d-b4be-c71c9ec8dc63@nvidia.com>
Date: Wed, 1 Oct 2025 16:00:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
To: Danilo Krummrich <dakr@kernel.org>
Cc: Zhi Wang <zhiw@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Surath Mitra <smitra@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <h6jdcfhhf3wuiwwj3bmqp5ohvy7il6sfyp6iufovdswgoz7vul@gjindki2pyeh>
 <e77bbcda-35a3-4ec6-ac24-316ab34a201a@nvidia.com>
 <DD6X0PXA0VAO.101O3FEAHJUH9@kernel.org>
 <f145fd29-e039-4621-b499-17ab55572ea4@nvidia.com>
 <ae48fad0-d40e-4142-87d0-8205abdf42d6@nvidia.com>
 <DD7CREVYE5L7.2FALGBC35L8CN@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DD7CREVYE5L7.2FALGBC35L8CN@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0113.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::28) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|MW6PR12MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9e0502-d40e-43eb-7d41-08de013e4f08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGxPWTNDZytROVZnbGlNaXd1c0VOL0RJckFJMkl3UlBCUjVscHRJYnA4d0FF?=
 =?utf-8?B?OW91M21WZ3VJUnFobzNpREVFeHJ1Q005ajV4ckxCeTBtUGIzY0dGcDB4SkhG?=
 =?utf-8?B?SDhIS1dpVU1XV3l3ZmNLVHAxakZqaEZFRnowQVdmbmprNUQ1TXUzS0dtRGp4?=
 =?utf-8?B?djlGdHBrUFppMVZsb2FnWWdpZ3JRVU1MK1R2RU1EaDFwMnhoOVZNZWNNSkJ2?=
 =?utf-8?B?eDZUZlFYTURtZkxmLy91UzM5ZE9QbWVzWnhLVE9CRkR3V1liajZIY2hXbGlq?=
 =?utf-8?B?VGRER3dqOHo1ekRGYm5tRi9QMk1KZWFSU3hDL2wxWHRYNmJmR1J0RDVlVDRw?=
 =?utf-8?B?eloxTlJQQ0xzUTNkMXFKck85eU5FU3RyWEhtQmpPZFBQMTFZNFdZNlJsM2Q0?=
 =?utf-8?B?M0RWQ3RUR0g1VVZQd0Y2ZXNBbW1vQUtIMmt0aThqc3djZko0QndMeG1PcHRY?=
 =?utf-8?B?ZWkvSWF1SnVxL1JRK2kxSG5oZThJOTI2RGJobzJBWnZEaE9JSDV3YWxKVUJ3?=
 =?utf-8?B?dDlsMHYxUnl5RkYzWXd5R0JDOGhLaTliZkhUVjhYMzJmbVY3QW1CKzliRkRr?=
 =?utf-8?B?U096WStFYm9GWko2QkZOdjl5aFd2VEpMbzZNOWZwbGtYM1pucWlwMWpzNktY?=
 =?utf-8?B?dVkzbU8vOWdQR3JycWcxV3hub21wMWNSMzBQY1VRVGhvK2NKQ2JTNFJVQ0tB?=
 =?utf-8?B?TjlKREtFdDFTaW9sNXdNcEZwd01RSStlYlgxK0RnVXp6R1J0Ymt3NTQxbXBn?=
 =?utf-8?B?MGJ2eGxPWjRaZ3p0cUNDUG5PNjc1VWZ2Q3RKMjJYUjJhQ0tBQ0MxSGRPcEVZ?=
 =?utf-8?B?ZzAwRy93cGExOC9waHM3UHYrcmNEZE43ZWRiYlhkdTlhWjQrczFxK25JZ2M4?=
 =?utf-8?B?UHpSU2Fyc1ZhQzdLd1h4YkR1YmVVVkRrVkVQc2JzeExLckp6S1ZNVmVYRW5z?=
 =?utf-8?B?Qy9rZnI2RUQ5MlBwY2JnMHhjSUdNZHRva3NCZUJKUk5abXNoYmkwRHBuVXN0?=
 =?utf-8?B?YStOdUVYcVg0TWNKS2FQQ25mNFk1VnFNNzhVVXVydkFKakNXMG45NEpyZU9F?=
 =?utf-8?B?RVJ6L09NY3ZtTUVGUTk1WW9DY1M4VU5nbW9UeER6Yms0Q2pydWRHSTUzSFA5?=
 =?utf-8?B?NGZVWFRUR1ltcll2R0YrU2ljVHRaMjcvSCtndWVQa1Y3UDZmOC9wMzJXM2tD?=
 =?utf-8?B?QmNqaEV5Szh6NUxVTjFoWEhmdTExbXF6VGc1VFdqZ3JqZlYvb1Y1SEZPRzgx?=
 =?utf-8?B?TlFWZ1dSTGxrdG1SZFJVUFRPTVB3ZW5vM2Y3eWFzWVJQU2tKNzNJWVlJT3hB?=
 =?utf-8?B?NlhKaU5JQzQwbjNMUzM2Zm91MHptUS9tbHFHSUhGOTFNNHM1SmFHWVVSUmZQ?=
 =?utf-8?B?R1F3elg4bkEzdmgveklTc1ByTk14VlgrY25BdGVMMElZQWJ0bmVKMGNhOFZD?=
 =?utf-8?B?UHdpTEE1S2VsYU56RjFyaENlK0lNdVlqNThWTVFHTzk1MExSZXdyaVZjUE9L?=
 =?utf-8?B?cE5naEswMjZOb2lBWnF5eEQ2c3U0VmlDaGJKU1pXbllWeWhjMWl3UHV0WkZ4?=
 =?utf-8?B?VjBMMCtOWTJhYnJLMHBWdjQ1Snpxa2gxV3MyYk9Sdmc0QStiQVg1dXlsUlNP?=
 =?utf-8?B?TW1LNEJUSG1pVHNNcytVa0FEWVFWV21WeWN1MVRJUHZBN0ptN0granlWY1Ux?=
 =?utf-8?B?eFAxNmFabUlnSWZsUEpJendoT1hyMTZ0S1NtTVYrWDJLZ0RDYUhaVnNNUXBW?=
 =?utf-8?B?RGRhVnRTZXZNeFdWVTI1N0x1b3VGQ0N2bzFWcVQ3WDI1dHA1VU4vbHBrVmRE?=
 =?utf-8?B?Z1BOT2ZWTlRFVjhUWHQyUTdPR0lhZ3hEalgyUFVWQVp1MUtNU2tURlhSdFpR?=
 =?utf-8?B?VEw4N3lncGtmZ2N2S0JKalJyckMzSWFuQzdCcHFSeWVpUzVjZzRjRE9VKzEw?=
 =?utf-8?Q?6xHPcsvhI/JeVGAIlfvtm7hJfEctG970?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OElPWEFXRWpzeWhySGZBMERWSHFwcFJDZEIzWHU1WlBoK0FkZDJKRUNQZ1lh?=
 =?utf-8?B?QkUyT1A0ZEV1b3crRU5icnNVby9XTGJld0gxeDk0NmFKbWZLTDgzN3ExRERL?=
 =?utf-8?B?QXZaOFZUdEZ6a3BnNU1qSnBVMTY3ZmJaY2w0VG8xS3VOYkNrVEE3QlBCVGZ2?=
 =?utf-8?B?Z3lhVVNRbWR2NXdKMTF1UFBybUF3cWpZcG4vTjBwenNCNWFmZStHQjV6U2sv?=
 =?utf-8?B?VktxR255aDhhdWYzYUo2M3NLekFZaWVlcWlvdElSVHBETzZkZGtyeGhjQ3Rs?=
 =?utf-8?B?dHpkempnN2c3Yy83WUMyN0liM0xzRDc5UTR4MkdxVkRWQkw0ZWFBRWhXbERj?=
 =?utf-8?B?aTZ1QlZ3RTh4Ui9SSXFuTGlWK3FKU1pSMHlGc0lrTmtjOGN3WkowVlFVMVRa?=
 =?utf-8?B?UmZ6M0dEeE9Cb1grbWV5VHF0elpGR0RVeVdkTHh0T096RGNRYjliczc4MGhs?=
 =?utf-8?B?WFA5M3VyYmlMQ2FaNWZsaWlIYkdva1lJR3lZSGw2Y3lUbWNHSlFWUGYzMGhk?=
 =?utf-8?B?ZzBIblJsT29FYmcrUHBlMVJLTkJyMVFpa1V4VDVDZ3dlMzh6bFlvTmI4YWd4?=
 =?utf-8?B?d2lCU2ROU0JYSE5ZdlFDU2ZRY0tOM1VmY0sxOVBiTXpOQ1pSUE9mTXhuLyt6?=
 =?utf-8?B?WmJuYWJnTXVvL1BsVDdTcGxwbFNkck9ud3NaVktrRXBXWmxwdUxtMFJjeWJH?=
 =?utf-8?B?S3BJbFFIZ2ZQblQ1WGllR0pETG96cmgwaHEzTUlaOHVDTUJpMG5pV2pneEtW?=
 =?utf-8?B?b3ZkcHFGQU9Bd2lra0VjSmdmRDVxWml2QmlJVkpLNHVTcEFaTERUbVZhU3hi?=
 =?utf-8?B?elZPMnM1OFdUVXJ4WTJJanlTdThOdW9hdjMxaVlxb0p0Q1FxeFhBKzNkbGtE?=
 =?utf-8?B?TzhSNlYrYlVUUWI1ZDVibXU2YlBJaDNKdThBcitQUHI5MXo1b283clA3dzR4?=
 =?utf-8?B?QkE3bDFsbkszSXhrMkZZR0YzdnBzSGl6cUNRL3I4YzN1TFU1YXRpZUY0TUpO?=
 =?utf-8?B?YlVweWs3dDFtMUpkajNHWUZiL3d4MVoxeEw1cGxVQmhpKzc4T2VQQTBORkE4?=
 =?utf-8?B?VTUzaEFMM1ZQNjZZUzdIUzdUeWl4THloOWpXTWZ0emxMbFFCTHcrUzhGbnpw?=
 =?utf-8?B?d0orN2Zhd1czUmg5U2RwTFZnSWJhZE9sMG9TSE1ZM3VjUVFqNlR1STNhQ0hD?=
 =?utf-8?B?eXliTDJQZThGUjZZZ2pXaFM2SE9LNjNaSjNXSDZuS2FiVk5JZE45SHNEZlNm?=
 =?utf-8?B?Mnk5ZENEVy9oWVo5VkJhVG04MzFEYzVsb0RudlJNV1gra2pQOFBRWGd4RzNz?=
 =?utf-8?B?aTVQRUhITGthYW11b3NuUkJQL0p6TU5qQnB4TFNESnBDbVRpOU90YWt4SWJ1?=
 =?utf-8?B?ekxqRHRZTWZCcjVxUzcvc255cWp6TW1UYlFmOURsMWZvYkdQZStFLy9PRmR0?=
 =?utf-8?B?OWdLTWlab0txc0E4d1IrZElwMERiamhWMEdhWm9SZEpCNlhqZ05oak1MYm9x?=
 =?utf-8?B?VGpYV292KzlEb2RvVXdVeHFYbzF3MGFwSkpVTnhteEFycmR0Tmk0UDFKbUJs?=
 =?utf-8?B?QUxKc2FCSFBjTy9WVFkzSEtBNTR5Y2syMFphcXpPSjB1dXpaRU5YQ2x6S01v?=
 =?utf-8?B?TkQzME5qRlBNM1E2bE5wT3ZIaEFnWitIUndOTXl3akhNT21kVSsvZzd0SDJv?=
 =?utf-8?B?bFZ4TjJUdTNpMjNnUGIxVFdBQy8vYytNV1Z0VjI1RXdoN2IyM00zOG5tYkNU?=
 =?utf-8?B?NmkrREhmZ0d5VGVpT0JoNFFaa0hMOFMvT2pTSFNTTDBxclhRTGRTbGRjYTVM?=
 =?utf-8?B?a00xLzNLOHpMc3R1NkFFQWkxelZTeFkwdHJ0ME1nVnlCNHZkeUJ5ZHhKVHJO?=
 =?utf-8?B?ZnhMQlcvb290dTZvUUhkdFROUExiMm9aTHRTdFVlSDRUWFVVUnUwL2lmUGZi?=
 =?utf-8?B?dWdWcmdralJIZmo0aU1EbG5KTk1tMmRUZjlUN20zWTFKYVoxakxCOEE2bjh6?=
 =?utf-8?B?Yi9NQXRBSGFtQ29EMHpOME1jb1NISG9TWGJlbm9kUnZoNE10aGVQU0hmSm1i?=
 =?utf-8?B?eDQ0YWt0d1QxNDM2Mk5DaW1MOUNqWGlnZ2JXbGJXR1Rlc0hOeVl5Z05vQmJq?=
 =?utf-8?Q?hvff965kFZbziBbhvVeqOiYOj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9e0502-d40e-43eb-7d41-08de013e4f08
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 23:00:25.9928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mcCcKje5V5o0qH+rcN5kRXYp2aM/LBSkXQyVxyFpOlqYmn0TMn+OEa0CW+08Nev0Y6SXfyODV4h3xfirJDu/RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7070

On 10/1/25 3:52 PM, Danilo Krummrich wrote:
> On Thu Oct 2, 2025 at 12:38 AM CEST, John Hubbard wrote:
>> On 10/1/25 6:52 AM, Zhi Wang wrote:
>>> On 1.10.2025 13.32, Danilo Krummrich wrote:
>>>> On Wed Oct 1, 2025 at 3:22 AM CEST, John Hubbard wrote:
>>>>> On 9/30/25 5:29 PM, Alistair Popple wrote:
>>>>>> On 2025-10-01 at 08:07 +1000, John Hubbard <jhubbard@nvidia.com> wrote...
>> ...
>> As I mentioned in the other fork of this thread, I do think this is
>> a good start. So unless someone disagrees, I'd like to go with this
>> series (perhaps with better wording in the commit messages, and maybe
>> a better comment above the probe() failure return) for now.
> 
> Indicating whether the driver supports VFs through a boolean in struct
> pci_driver is about the same effort (well, maybe slightly more), but solves the
> problem in a cleaner way since it avoids probe() being called in the first
> place. Other existing drivers benefit from that as well.

Yes, that is cleaner, and like you say, nearly as easy.

> 
> Forget about the SR-IOV RFC I was talking about; I really just intended to offer
> to take care of that. :)

I can send out a v2 with that "PCI driver bool: supports VFs" approach,
glad to do that.


thanks,
-- 
John Hubbard


