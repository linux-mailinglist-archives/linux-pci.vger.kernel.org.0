Return-Path: <linux-pci+bounces-31831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC0AAFF6C5
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 04:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BACA23BCDEE
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 02:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7A427F00E;
	Thu, 10 Jul 2025 02:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="arq2gkkC"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831EC27FB03;
	Thu, 10 Jul 2025 02:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752114267; cv=fail; b=r0itygyUdsLVhqMWB4uCj8DcBO9Kq0Pk1bMcVikMnwdhbMSs4p5WEXC4lvstSKeptsCPTzbKxcPptm7jptqJBgHLxIl8P9CWtsIP5gDF0CA4zwY0EkB9g1nL8n8nSlkj51531UVsvzKTjvtcvKGbeo/M95qvr6nyH/m6gUiZsR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752114267; c=relaxed/simple;
	bh=qpytoVE1z6Ooco8vYTQ0SCUBsJqbzXxkE8qVRtfAYRw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uv56CEdAZ/JJqt4PNGogtdYvllmFQ5Do5XUyELHCtaU064lnvv1urbaHyIVk7wZAlnfrijfIhOiCF2eaZdLlJEBNvuSVGxiMtWQvLfBe9BqlqC9Qupky7DAi393SnQ2dRKaHVK1fV5HEXWC7bALn4lT9zjMYlyrZAUfaP8WG2ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=arq2gkkC; arc=fail smtp.client-ip=40.107.101.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGZ2nsLNqKhesyFbQ9y6lbwRYCCfSisoFhHVXPP76RHPuASnqMaS548wBWC7OvGil4C02H2E5Yt9I00bYTiOorj3i5oJZlbMgO604thkqYcfJwdbkA5fbqwkKnF58VmmAz5CWr5F1ZpIakNUOTiBO419OUrNVDaqTKRTAkSTZyANAEtNk18rnoAy3t9t0rfXDYGdYVkBjqBnvEtjDhPKmOlgByPx2mGoVahxFzO/naFJnM3Dd9RiwtcXyyAMArT4cq2HwqEipAhEceRYYzDinfoGoIBz7BbOho4gcO2O0HCR65vLaoDe/Kkjf68uJe7dpGCsEVym9+GebRfExR8nrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyOD3xkh2Zgrin7mV9YQO6Pg0tnX7jz1UCtIjGmmjSM=;
 b=KpN5fhC5zBVVzxwYU7C49Zc9cb5jwS5upit8uaVnEwGlyswMEQPAXOeVoQXCayrIJ91FNIjqTg6m6TEiH0gDWlerCkPbjn6nuMoDui6bOAVies/t+dWdjwBJakJgJT5/ixZa5tDmVcLu1pc4O0eb5A8Gzldl7g8zPWlvqE8CpgswlzGBD2uK1uaZucaUCs2YF1qpN7QZqmlSXJR8RZ79gJfcoqSIl/exXQKWETyPksshT9BeEmfhwz9zhSiNn6upQ1BGftFpcmH3Fs7RL1R2ob1Ccx3iiBX0BaVSw+8RVq+3H2U45OdXfwQrY5jn5FN7wVN/AGL+pidjtCzqTEz2YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyOD3xkh2Zgrin7mV9YQO6Pg0tnX7jz1UCtIjGmmjSM=;
 b=arq2gkkCHLWsWLj8miihPsvAJbdX7ufZCAL5auVXUfpsLM9C4StUAO3FR/PFysFDSWOam75Q2IQCiLMJB9FffnEzGoXjiWVk6ake2WnkH5JzxYuZTMPRy5vkfTyY3E6yYBTcCiC/MmJPgqWgbp25MWK/OuDMZf2sdGQ36vxTxL05GJuOAO2PD498ZfqWRxjzgQz/SH+zqxdm9PnyiQv98CObK2kAR1jkrS3CWZHADtlO2jjLJXcodBLkfiopRj/GYMcZHZoYo2PfPSv2UnsZdJqBzNGTcFvfmgzJAGVvTDLWm9TbvaTFLS1tJP8QQ42KM6OYXRmXaStIb9aWlhlTTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Thu, 10 Jul
 2025 02:24:21 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8901.023; Thu, 10 Jul 2025
 02:24:21 +0000
From: Alistair Popple <apopple@nvidia.com>
To: rust-for-linux@vger.kernel.org
Cc: Alistair Popple <apopple@nvidia.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] rust: Update PCI binding safety comments and add inline compiler hint
Date: Thu, 10 Jul 2025 12:24:14 +1000
Message-ID: <20250710022415.923972-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:610:cc::26) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 903e7ecc-f8ae-4041-3dc7-08ddbf58e15d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?andEeXNUZmpvdUVnc2VQaFhQZ2NTTXEwQlZxUXRTU3VvUlJLQWp0MTRwQ1Rm?=
 =?utf-8?B?b2N1Y08rRGhXdmNWYnRQdVFoZzRXYmVHckxISC9Fa3VFMGRaUFBlVmZZSWtt?=
 =?utf-8?B?aVZVVXJKblRvTURZTUpRT2MwZGNDRlVZMmo0WFo2MEEwUEFkRmJTZ2RSOUZh?=
 =?utf-8?B?L0M4UE9wUGpkcVBzdCtTU05pZzFXWG94R05tQU9Yd1pYVUVJMC9SK0RsS0lO?=
 =?utf-8?B?QVhueGt1Skx0blJRZUlUL3lyVVFWY0ZjUWxjN0JyL045aVJmU0RndFZlb3Nw?=
 =?utf-8?B?YnFvSTJLd0pxbm9yYkNJK2dKWUpUOC83TmVoRG5qTmdBY2hNQ01zSkxWd0Q3?=
 =?utf-8?B?NXd4ZEVubXlWNXA2TFRHUzNqcjEyaXRTRlcvVHR3Ri9sejFFZVBVNlE4dFQ5?=
 =?utf-8?B?SndFS2lHZ1RyVnhhWUgvU2FRUzU0NDFKV3Mra2NlU2hUS2xiTWI1NUZIVXJ3?=
 =?utf-8?B?U0FmRllDMERmS1J3eGFWSDdpR2dpUzNhSGhFQWNKbzFFTGZVUjJEd09WZWVR?=
 =?utf-8?B?cGp4eDVMSlVVTkQzMnMvVUV3TEVvd1YvYmVZdlFWZ2w5RFRGQ2VhZVc0RCsv?=
 =?utf-8?B?c3laWHpaVGU0ck9XOTJZQUF4WnNSTWU0aVBHc3c0bjl4Zmh1d2RNQW90MkJU?=
 =?utf-8?B?VFg3bHA4VEU4KzNDdEFSYUJ4Q25ZR3QvSS9ER2x4TVk1YWZxOW9TWExzYWR6?=
 =?utf-8?B?N3V1REgxRW1jNG5IazJ6Mk9pNTZlNWNwY1RlR3ZUMnlzNHR1aVRKL09qOXpB?=
 =?utf-8?B?RUQ2K2tDSGloeW9yc0YzZDRnc2ExazViU1ZsV0lLcHJNSkF4S1Z1WXZhR0tu?=
 =?utf-8?B?anpvM2VOR2pta1BJaE1jUWtkRjh3SVZOc1U2ancxYjF3ZnhyL0x2b2VaVklu?=
 =?utf-8?B?WHJkOWtvMk54Q0xTNkRxQzA1ek50bk92cmpmUnNObGtFdEZGQ3NTYjlCd0dW?=
 =?utf-8?B?cFdWaFR6bkEzQlZPdm9WRCtPUGJpSWlTWFhOcllRU3gyYzZ2eS92ZUdVdjZr?=
 =?utf-8?B?ZHVkWDBoSDVFTmdiSW8zVzVXVVlkckZzMzFFVkZCT2pNaVVNcTVIQTIwcmtQ?=
 =?utf-8?B?c2lLU1o2b05IbDIzMm5DaTNlOVFXM1VtcUkvdU0wWVRmMUR3ZUs0NFJUaVdm?=
 =?utf-8?B?Q1EvVU1BM1Yxdkt4VkxHdTZJK2p1ei9hKy9NOUYxK2tabXpiSGFFNkFUaUMy?=
 =?utf-8?B?UGYwNzVZK2NSMzdhYklNUEI1aEhmN1FBeEQ5M2FnT016anZLSWNQelg2RW5v?=
 =?utf-8?B?WXpCWlZHM3llSTVNdGU3YnV0RnZLemlFdnJuRkg1UVF6d1B1eGgxaFZPVWxs?=
 =?utf-8?B?REN6UzB0OVVuWkJNaG5lT0Rudk1XekEwK0ZFVmlrbGdRenpDSFFqcXNaTHpY?=
 =?utf-8?B?K1psOGxxUnFGV1hXSS96WHlzelJucFJGTXBkUFArUGpDakFLZi9tRnZuT1JR?=
 =?utf-8?B?M2R6aU9aNkhhR2F5Ri9tTnN1NHJIUTR4ekRaV3hwMkZtdERCbVBFOFBncnJq?=
 =?utf-8?B?UzAvN0drT1hsN0lzcGtUTGV4bEdUeHduUDgyczBoT0phcmZUeUJpYTNaS3lJ?=
 =?utf-8?B?c1VpNkZyZFhTblN5c0l1ellGZU0xMHB3SEY0SHY5S1dUQ1lZNXZXSkJ6S3RZ?=
 =?utf-8?B?V011ZlFzZW5RbjQ4cjFlSE1jaWFqRFRvZEdRSnZKUzB6bXA2RE5QRXIvaDFm?=
 =?utf-8?B?VTdDc0QvS2VIQUZIMGY5cmxQVTIraUJtZTQyOHBYWHRtTVFubC9VMUt2MGdD?=
 =?utf-8?B?L2hUYmtmUGt1OTFTM2RqR2VPbXhJdytZZlBRVVJLai9OT3NwYUQybEJqZE1E?=
 =?utf-8?B?UndMa2NKeENRUTdmN0svRG5QRXVNVUMxWFQxemhINVdWZ1VvaXFodWNZeGVL?=
 =?utf-8?B?c2Y2dko4K0N4dlplSEE5bDZ0NEducXpHQXZjdWpSYjJLN3dZTEVoNVRQL1kx?=
 =?utf-8?Q?uskO/w3Golg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nk1sRHpIcTF6RTBzTDVOeVhCVTNTblIySTFEeERmUm1ndVRyUVljSHBaQktD?=
 =?utf-8?B?RmxtYnBKUjVOTlhVY1JMS0xXNGJRcFgzVENLdmd2dEV4NnNtRGlUK2tkTnVl?=
 =?utf-8?B?ck02UlBKais4eFlvaTJTSy9Ec0dKeFNXUmpLeGxQMk5zRXQ5MWs4R3U4SmJD?=
 =?utf-8?B?QWhla0UrUmQvb1h5NW05S1drVWliY1BSSmpEVzE0ZmVhaSsrb2hqWU95cG9k?=
 =?utf-8?B?UGdSZ1hoMlFxSEJHS3J4bnlzMzEwQ0Q5aUY2VU9JS1Bva2FsQlJ4ckVHVXNk?=
 =?utf-8?B?anlIbGx2U21NSGRDbHkwb2xMbWYyZFV3RjF4ZXJWQmN0Y0dkUHpZVHV6bEJT?=
 =?utf-8?B?WXN6QjI4aGxZcmZqUGdKNHkwSGRSQm9tSGtDVkR5eG1iOTZ1NVB3QjE2UEdD?=
 =?utf-8?B?R3BmQTRwY0tsVytFWHA3WllnRExRSm5YdnB6dk11NlhYZGpyZUJGeFVqNHV2?=
 =?utf-8?B?UEdOOGcwcGhWdGhidmFXdXFHK3VHK3ZSZkM1bGFaaTdreDlaRmx4Vyt0WGNq?=
 =?utf-8?B?bDdyc0lPYTVueXlYWmxrTzUrUDNNaG5XOC90YnlGbTB0K3RWVkRYZUdUbTQy?=
 =?utf-8?B?WVdlaUpkbWh6NTRhV2VJdTRaUVFGZHovOCtSY2FqMnQ1RWJzT3lFazVNeGdO?=
 =?utf-8?B?QUJEQlFIaXZZaHBFejQwRVpsL3RXRkUwWGxlaXJYSDdtdHBvVndoOUJ3MzRX?=
 =?utf-8?B?ejQ3U2ZaeHozZGhkOFBCZlA2ajQ1Z1IyV3BlcXVRbkRuVnVnQnlYOVd4L3JF?=
 =?utf-8?B?VnJWSi9YVS81ZGVVVTZpYmRVaWZQTlVwd2xjbU5FazdDTm9EbUVZdHhZQWZV?=
 =?utf-8?B?T05ySEtCS0Q0QVZ5Z3JTbE1xaldQYkR6dncyNStVVU1KQ2NpVlROOTdOb1Bw?=
 =?utf-8?B?M0ovVU9hRmhFZmFxeTNjQWthc3pucmw3VFJFaEJDbTVHdjVCUXJUNGM5clhR?=
 =?utf-8?B?alpEM1pNMjZiTGxnN01ka0Q4R3hWUUUrNFNWdmloenRhWDhXcnpFVHpiNExw?=
 =?utf-8?B?ckJvSFU4RjlmT21WSlFNZm5QaVVtQmsyeXI2T1FicWQwZGhnUyszVlE5YkVn?=
 =?utf-8?B?RS9OSW1UZUJKNGR5T2RWc3MyZ0VWTVp0b1FSeHNYcHd2dGloajRUZW1PbElx?=
 =?utf-8?B?aWRWSlM0eExIcTJ0Z2tqd1hJbk9wckc1ZWZoWks2aDhVRXh1MXY2THRnWkZa?=
 =?utf-8?B?RTA1cHB6M2R1SFlzNEw2RWx1eTljeG9RNUM2QkFyOTd6Q1huUzFmRERBYmEy?=
 =?utf-8?B?ZmdMdjZhYzVkbkJLTFZqZWprQVZsaENKOEpOTVhqZWR3YlNGclorazhFVEY2?=
 =?utf-8?B?TGNLSklTK2dIWlZReUo2MTUwczczSjRRYndhMkJKNDRTOGIrVloyV3gwM1Vh?=
 =?utf-8?B?S2E2QlhreTh4T0VIRXJpUFJKb0V5TnJrZjdGSWNFNmNBcjhCUW0zMlA1ZytT?=
 =?utf-8?B?ZGt2dzZmOXhnOHNJTEJFZjQzOW0zSVhPVEIzQUh6a0VBemdaT0tXelhtWGVZ?=
 =?utf-8?B?bUs3eG9FK2R1Y1lWWU9Wem9ybXpsMk1WY2NWbFJuSjAyNi9WT0ZWTzZJeEEz?=
 =?utf-8?B?YVRuT0UrTGx0S3krNnVVTFJNRlkwa0l4Q2Q3eG1FSXpIVUtCc2FOTWJNN01n?=
 =?utf-8?B?L3dUNTVYWEc3YkJ6RkYwcU5zdXNGa0NGNGlMbTY4cWlQTzNvRUdiL0o4NU01?=
 =?utf-8?B?WFFES3FrMXRGYlFUaTJ4UDlsUjlSd3pXQVcwYmJCUmdJK21jNGxNNm8vcDdH?=
 =?utf-8?B?V2FhRHlrUWl4WVVDVkJyKzZKNlZleFd1Wm1mSXlmYXFIb09jRzhHSVNFSW5L?=
 =?utf-8?B?dFlZMVJlYm1TQS81anlUdDJmUXRGcXNNaUJTL1JPSGcvYmJWL3o1MGxzenN6?=
 =?utf-8?B?WkNyelAvZ1ZxK1E1cXEyRURZdENueUttTllBYkJUbFBQbk1zZGppcExiRXhF?=
 =?utf-8?B?cWJoSmRiNlNIQnBXM2ttVHBHc25SYkRIM0FzaHZqRmpaZXB2d2NDbzFuRHdV?=
 =?utf-8?B?dS81ZEcyeE03bkN5c3BhNUQ2YXdvVjNKOUFZaGxtNWIxWDlvSnBRRGQvSmF1?=
 =?utf-8?B?ZjZ3dEZnUjh6ZEZlRlpnQzlkSDNQWDUxN3JSQTF5dnJNRVB6bS8xOEpzamxn?=
 =?utf-8?Q?+XvF2p79IFYnhHGnhO4tT39LP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 903e7ecc-f8ae-4041-3dc7-08ddbf58e15d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 02:24:21.8180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vWb8W+r/qKTljaE0myo89SSTTHh0Tqu9evyc0KOvcZF7iZ8iVKMBA88/uEYtVwdY0WaQb16w1QlrQjYEY389mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132

Update the safety comments to be consistent with other safety comments
in the PCI bindings. Also add an inline compiler hint.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Suggested-by: Danilo Krummrich <dakr@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Gary Guo <gary@garyguo.net>
Cc: "Björn Roy Baron" <bjorn3_gh@protonmail.com>
Cc: Benno Lossin <lossin@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Trevor Gross <tmgross@umich.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---

Changes for v2:

 - New for v2
---
 rust/kernel/pci.rs | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 8435f8132e38..5c35a66a5251 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -371,14 +371,18 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
 
 impl Device {
     /// Returns the PCI vendor ID.
+    #[inline]
     pub fn vendor_id(&self) -> u16 {
-        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        // SAFETY: by its type invariant `self.as_raw` is always a valid pointer to a
+        // `struct pci_dev`.
         unsafe { (*self.as_raw()).vendor }
     }
 
     /// Returns the PCI device ID.
+    #[inline]
     pub fn device_id(&self) -> u16 {
-        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        // SAFETY: by its type invariant `self.as_raw` is always a valid pointer to a
+        // `struct pci_dev`.
         unsafe { (*self.as_raw()).device }
     }
 
-- 
2.47.2


