Return-Path: <linux-pci+bounces-37664-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 710CCBC1342
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 13:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA0B634E42D
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 11:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D752DAFD5;
	Tue,  7 Oct 2025 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oYDZ5n0H"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012035.outbound.protection.outlook.com [52.101.48.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8978B2DAFA3;
	Tue,  7 Oct 2025 11:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759836383; cv=fail; b=sN708Djd1OVDsA6C1GTdb1j+UyRcaViG8ZFrif4PaGeKj8XorfQBVV3u7ZopQsH5ioLG3uwftdkoO2nPHbFWc/Eo6Yglz6hwi5IHwxIID5Je/yLozcio7ChQNtHPkXUzrbydnXaAHeF51P+UbsZJ6hcKH4EaWemf+mv1gBhPbFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759836383; c=relaxed/simple;
	bh=HFmiM95/EbS44DaYcEJYntc29RYnTFNKTPcfUawx1dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e+Y7cptr9Zm8HhRbw6qd2VIGDSoPVXqClWR9G7aSkYfBc+g2GZkyJo2TWKrVyKmPnJcFRPfdpyFrldmc3rdZv7DHvtIkOkz6QzJmiwBZnYiKX8FWsKjlDW7DeIsHyWa2vIcpBeCweM+5P7bbk+B29jPCTRtT9i6HyFEtEId2b8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oYDZ5n0H; arc=fail smtp.client-ip=52.101.48.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9nhQ0YoIXqFinJVU1N3iobjdl9p5WwB7RLYdqqS+qwffXZO8xW1hYthfj7ORYUjrHQpxohK/eMQ/1VKV+xXhNA78VdFyJCW1Pgg8Fe6hOVpdYgT0Kwko/XZeteoV8EZ5lu2bQRGScML4Is7/SmVbHY420O9YUUOqcwJPcoznVHH1x3ZWVmos2kRhvaCNQVeZuMNdWDACoszCs6th7I7x8Azc31ND8R2WnIqEFswDDAZUzzvgBsks3WYl9XWi4f/UuCM8pP0zpWTfXnk9T/vs+S9KcTWmPv45Mxq38Fshzjk0h5OlIglFtjRsVKtUu6gfRl9Rg/dbR5mzwVznYD3dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lcvID0plQtjva79ReS3LXD8oHKsvWG8EliapqKynPo=;
 b=Yq4GCHFjGxtCswK3kIc7DI397SHaYUQxBStJf9qhxLuCfxI7uzyN4wIcSqIWjnCnva0YEjsmLRvdqhWm0gAp1pMh4vfJpPgXurZstT3hCZxn6Yi8siZJw5nxcH3YGmSkct/V5jt7Boo3z2XW1Ll8BOzWGnHKv6kihbd5iHxW52dsedDHqEWWN/wm5RnAwXK1PJaNRtPUpv7Wv+mzyhK3cIAQryaVZKED0wqtJntVhNYfWh79kHlGjwPSLR9s7QnE6CAMTxH2TvkHPQQECOy7iCVxkia43RPePcWcFPvKR/FyNtCscknmhbHqwaE19sODpFRVAwP3DWr7Zd0sm3iKKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lcvID0plQtjva79ReS3LXD8oHKsvWG8EliapqKynPo=;
 b=oYDZ5n0Hx/ogdQaic5I/gGDTgWCUUJWH+oe+x53KcbXrFYOlz9tjA708Wbe0yXXzYuMjmgWV9xCJBiqy8yCx8LVZTpkXCAwV64YKdJH37dVXLvHd8NKzVf6x0nS8/QXgl5opgB8xWDGNqpdvrm/pVFerIdfC5P21uRrA3r+19KeG6g0maXCzRfGteCMbx9IqTmYz++eAmTSyCk7ZOBPqMXtpzrnf34LrchVdIptkEdm8LZaAsigPyKBk0xtBs7EpSzxmi5C0OSfGbpTHxA80rnHUyI230IbUmOqyn2y0nKGk2DZX81S0RSzTujGKTZEmIJ1KNpUcxMJhARjC4qGRBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CYXPR12MB9428.namprd12.prod.outlook.com (2603:10b6:930:d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 11:26:14 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 11:26:09 +0000
Date: Tue, 7 Oct 2025 08:26:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhi Wang <zhiw@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
	Surath Mitra <smitra@nvidia.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Neo Jia <cjia@nvidia.com>
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Message-ID: <20251007112603.GX3360665@nvidia.com>
References: <12076511-7113-4c53-83e8-92c5ea0eb125@nvidia.com>
 <5da095e6-040d-4531-91f9-cd3cf4f4c80d@nvidia.com>
 <20251001144814.GB3024065@nvidia.com>
 <c56bd720-d935-4b51-b507-d794df3f66f4@nvidia.com>
 <20251002115851.GB3195801@nvidia.com>
 <ea82af0d-663f-4038-b8c9-cf1eba5bc4df@nvidia.com>
 <20251002134221.GA3266220@nvidia.com>
 <0c94b94b-68a7-47e2-acde-0a2082ed36bf@nvidia.com>
 <20251002143116.GA3268803@nvidia.com>
 <75316915-fbae-487a-b710-ce01f088a2ed@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75316915-fbae-487a-b710-ce01f088a2ed@nvidia.com>
X-ClientProxiedBy: BL0PR02CA0142.namprd02.prod.outlook.com
 (2603:10b6:208:35::47) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CYXPR12MB9428:EE_
X-MS-Office365-Filtering-Correlation-Id: 0972f184-8b11-4ea6-c7cc-08de05944d9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnEwbjlWdEtiNndJTzJpcW8wMWlBSVhJWU5wZDB5R3NjRjdqeGRCZWZIclFu?=
 =?utf-8?B?RW82ZktkWDk4KzdMcCtlRXg3MHk5aXk4WkdzMHBqcVkrRnA3N284eWJ3cFlk?=
 =?utf-8?B?QXp2TGhnZFpuNURGUmdHb1JoOE01MWl4S1crdGJaZlN0elRpOHVhbUsrOVdh?=
 =?utf-8?B?Uk5OdDR4MXVqVTNLZFNKK2NOZFdFd1MxOUU5UkVCR1hJK080UzlpdDVTYkZk?=
 =?utf-8?B?aWJCbjdPOFFwUGdmelFtdjlmREhoMVBqZDNLc1JWa3FDQ0l3dkk5bEorVnNz?=
 =?utf-8?B?NXJ2RWNVMnkydkxpd2U0TWR5K0ExWXh0RWxCVmh4YW5hNmQwWVV5bjJSajhy?=
 =?utf-8?B?Y1JFekJpSTlNbGwyd3dLMllTeFI0UFVsenNRL0FNeEVOY3FzMERwYkR1Q0c2?=
 =?utf-8?B?UGc4SjBIUCtxOFc5UTlyVEJ5ZFdlanorbm5DeWFrVzN0ZDBCbXRlNHQ0MVVJ?=
 =?utf-8?B?UEJleDV0UnpIcTNOb29DRmlDbnpMNXpYbjgrQys3SC9xQzVrdDh6YlZHMHpt?=
 =?utf-8?B?L2U3amhPaU94UFExVTRsUDd6NlBlZ1ZNNGV0RGZWN3gxZHNmOG5qUjZpbjRC?=
 =?utf-8?B?UWJveGFveFdnUXFCRDBkUWNTanUwbXgwZTN3bGlSMTdKdG5jV2ZTdTlYS25h?=
 =?utf-8?B?Vk81OWJ0M0x1UTI2WFJwdFVVUWtTVjJvN2h5dDZJRkNvOVdwMkNybkY0VUx6?=
 =?utf-8?B?ODVnT3VmNXo3ZXJmanR3bGExOW84NXJGUUhlaGxVODJoTlVhbWFPaFlxUjJy?=
 =?utf-8?B?TWRicTh4R2dkcEYyK1VWWWN5U1B4RjVzeHY0MUFUQStnWFZRTXFWYlJCYys5?=
 =?utf-8?B?MWREamdIMDBYYjRZTWU4YytwYWFITHpRQTlFWUV1Y0lGdXovaXBWMDh4WEdu?=
 =?utf-8?B?bm5RMzBaaWhQYmFtbUtrbjJjNXhydGdwZDliSElPaHk5UUYzRDhSNktzU3lL?=
 =?utf-8?B?WDFpakFPTVQ4dXl4dkY5dzRSOG1WcXFFM2FVTHBwVE1WV25kVTZUVHBvSkF4?=
 =?utf-8?B?eThhdkI4d0pZQlpNck5KYXhMa3dGOXdUWUZpdzljT2diR29QcDVFVkx6TVAv?=
 =?utf-8?B?L3lqcUpuVC9RMVBrb3VxNjNvK0l3c3dSR2Q3S29oQXVJZ1FWRmtGeURTK3Ar?=
 =?utf-8?B?ZkkzTW9NTVZQRkVMcjN2QVVFU3ludzQ1SzNsRTJKRlZuYnpXMnEyRjNBODdr?=
 =?utf-8?B?c2kvaGtlV1prMG1KNHZsZGJiK3NCbU9HU1pFWTdKckVFRWNUS011YXNKZWVU?=
 =?utf-8?B?TmF2UVJ6Tks5eFgxSmtuKzlUVGhZRlBpR0dKdUFXb1RKUm42TmdtbjU5TXU3?=
 =?utf-8?B?NFFVMWY2RndNU3FCSmJCM05jZ1VOQzU3VmFmcU4xbjk5WGhpSmwzM3I3a2tB?=
 =?utf-8?B?MWVkTnNOVDdCb0FVYktNa1czYnE2SDJPVkgwdkFyaUZ4b0hMZjAzZTBaQVEy?=
 =?utf-8?B?Y2l3TzdHOWV3VlArSU15K0tLNzFPWSs1SUxleTB0eERTWVZpTXFWT0FWWXZh?=
 =?utf-8?B?K0hhNlJKemxkelVFZlA4VEx1MG1aMEgzc1ZGdk9JSm5EazRvZGhqTkU4L0U4?=
 =?utf-8?B?Z29mYUhyRVptQ0JQWThMdStBVnJQblJNanJBWHExTGtLSnpCZ3pzK1kyaVVo?=
 =?utf-8?B?QlEwTlpzemZ6b3llZXZpb1dHd2ljQk9CSEdtRWZ1Y0V5Q3Zrb0V1Y2p6QU11?=
 =?utf-8?B?SDVETXFYbmdlcG5nSjUrSk0xWTZTU1pjQ2E5TjVpS1BLajJiUHJhL0dseXVv?=
 =?utf-8?B?WGIwVjRKZlBCRXJYOFYrbFNJTk5mU2lzWlFQVHMzZDhkNDViZlBpUEdkQnhU?=
 =?utf-8?B?Skp0bzFlVVgwNUlMeXRPYzV2bjJmWEgrcXhqbEpUcWUzS0J4MjJkOFJ1SXdo?=
 =?utf-8?B?R1BtaVUrd1NGUlpCTlA1b1JGc0Z4VmhGSWhXTU9RY3pqNTVnQWNMd1NYMFNQ?=
 =?utf-8?Q?wSFzocUB4lfGry3lZNhqgAKmHGe9zbO+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkJ6OXFQSFhKZFRwTHFEUWVtY3o3MEVkYXRDeG5pSGs2QkhlckMrVjlrZ05P?=
 =?utf-8?B?QUc5VlcwNytxY3RmT29lWWtINUNWU2pqYW1PaXVpYm1WSFdKWDhTWG0wKzhX?=
 =?utf-8?B?KzVOYTJEbVYvcWNrT0FXQjF3VzlaSVR5aUxIRGsreGFoQTNXNGxQUVg4V0h2?=
 =?utf-8?B?SGliSnlYWnJ1bXdKbEhFZndCdGFGVk90NSttdWw5WWRtaGZkOUVGLzJiWVB4?=
 =?utf-8?B?cVFnNVFKbHV4VHpRZklSOGtLSmxqbFhnQkFLSndmVUh0Y2Q5dlR0LzhPRGd5?=
 =?utf-8?B?VGlJeUZ3bStXWEJDWENqQTVudVFTaHl2S3V5bHFtTHNkSnlzd1BSOHBzSGlq?=
 =?utf-8?B?L2NWSC9YR2oyWENyVStQM1REOXh4VllXVXlsWm5rbmdLZWpaYnc3M3VqTU5K?=
 =?utf-8?B?RDBCTE1NNFFUT1BKd1FlVE5sUU9CZXlYc2p0NFZ0OWI3bzVpVnRrY1JwNDJN?=
 =?utf-8?B?TmVvWjM3SlM2WmRwbStVS2sybXlEWnI3cytMWXNMSG1XSU5UcE95RFN1R1Za?=
 =?utf-8?B?ZitnSlBGZEFBUEVXSzZGWWJsaEs4NUlDZFpiVFp3cnI1bzFhYU9obGpDTVdL?=
 =?utf-8?B?d0ZEaklWekNmVXlaYVpOOENhOEVHOEMxejRCNHdGaHdYOXZ2SjlPL1ZDSVdH?=
 =?utf-8?B?R1poR21XY2F4RHpyeE11a1BVSGZHS3JEMmMzUVpsOWRzWnNUd3J5ZmE3SmJz?=
 =?utf-8?B?RUpMSFVBbmxYVXVWTUdKZmdOUkFXaDJlQkdmcGg4TmxIc1RudWNZRUJjWUVD?=
 =?utf-8?B?WUg1OXVRenZyWk44MDB4Nkk1WVJza0xRMm5NNkgrVkVwQnhxOG1leWJjMVJu?=
 =?utf-8?B?TjNYTlp3a3BnMEt3bmZPU3B5RXY4bWZKcG14Q2M2MXplNnIrallZZ09OUmRs?=
 =?utf-8?B?d0U3T0hhdWFaeWhqV0QycnRGNGc2SEZMcEN3WERJb2lDMmprMDNRMFlpOTEx?=
 =?utf-8?B?eDNIYVVWVlRJRzhrQ1kvcVRjUTJDeERaREk4VDEwVjRSY1NORjVHcUZETkww?=
 =?utf-8?B?RDJld0pIZC9QcHNtQU1hQVMrS2lTcDA5OHpDM1JOV000bW1sNWlPWkVwWWpa?=
 =?utf-8?B?dVdyNGxKWlFnRlhGMXVQSFlGWFpCZmVPQVpUdXQ3azl0a3g1TjQxdGkrUzk3?=
 =?utf-8?B?bTJ2QzdCYVE0eW9HK1FVQVloMGRMdEtlZjRFSURSY3dQRE15UVAyN3lhek0r?=
 =?utf-8?B?eWxtWjE5MmZqUWtBeW02c0MxUVNGM0YzWkR4ZmdMV0pvSGlhNVhyN1QyUjhC?=
 =?utf-8?B?akxtR1RDcmpNODhkRjRweDhCYVdmL043YWdCUHhLL2RNQlFnSDJlZE93WStD?=
 =?utf-8?B?TW1kc1pTdW5UcVBiWE5JeHI5MmVrRGRuU0FlMXpJeml1bWpIYnZxNldGeVhu?=
 =?utf-8?B?eXhQSndGTmZhamY2MER4SzVlVldmM3E2a2p3MHVzWlQ1VUJsWDNEaUVRSnhF?=
 =?utf-8?B?ZS9HYVlEZ0NyZnhMRkFxN0NtM3FhSzJhcUpXMWFnaUtlSXNPdXYycXJNd3hW?=
 =?utf-8?B?UGxTRVdTRWYyZWl1Z2FNMlg4eWpHQzYxRlJEaUt3MC9aN2d4V1h1VjJGb00z?=
 =?utf-8?B?dzA3SFhkQWI0ZE1vS1c0LzY4dytMc3dnZHVyQnFkQ1FBdWpWN0RJWVo3VDdm?=
 =?utf-8?B?dG1zSVVFYXJNcTZQYnhZUHR1b2RZT0RyTkNsWVUrR0t1WmJEY0NJM01LSkZH?=
 =?utf-8?B?SElSdDlVMDc0ZHp3dElxVVJQeUtLM0xxMkxuRGZKZDZwa080WVlETmY2NEFI?=
 =?utf-8?B?TWxtcDhhcXJBdW4rbmd0NzVqSTdJU1hEQmtXcXQvVGxGVmV0TW14SUQ0YUhu?=
 =?utf-8?B?b0RvRnVvQ0RRd01NSyt0L01NOGNQam9HaE1XakNKKzd0cWJnMm9Oak4xcll1?=
 =?utf-8?B?cktpcDZTOTdSZ0NKaElFNmhjVUVERHV0ZHFBU255R3dIUk5MSzRGblpOWDZj?=
 =?utf-8?B?dDcrTCs3SkFMelRnQ2VCYVovaFB3L2JSczNKYzkvWWpjaVZqQXJDRzEzdCtB?=
 =?utf-8?B?eWJHNDc3c2x5VEdraWtudGFVNG1kRnVPMWEvTUxVWUlJeTZRTE5hQTBCUVZV?=
 =?utf-8?B?NmpaZ2RNVXZLRFE1RzdIRTVxeGpRZFhoRGttWjVTM2doTWhlc2p1cllYclBY?=
 =?utf-8?Q?4HyLEHM7n6s1LtGPE6lUYIaBA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0972f184-8b11-4ea6-c7cc-08de05944d9a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 11:26:09.2239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hePS8OzJcUq56N7KyG9nzt9/PWHjHT7J0e6VAgOM5E29RCJjbEZ9ZpGOgESf0+3k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9428

On Tue, Oct 07, 2025 at 06:51:47AM +0000, Zhi Wang wrote:

> > You'd have to be more specific, I didn't see really any mediation
> > stuff in the vfio driver to explain why the VF in the VM would act so
> > differently that it "couldn't work"
> 
> From the device vendor’s perspective, we have no support or use case for
> a bare-metal VF model, not now and not in the foreseeable future. 

Again be specific, exactly what mediation in vfio is missing.

> Even hypothetically, such support would not come from nova-core.ko,
> since that would defeat the purpose of maintaining a trimmed-down
> kernel module where minimizing the attack surface and preserving
> strict security boundaries are primary design goals.

Nonsense. If you moved stuff from vfio to noca-core it doesn't change
the "trimmed-down" nature one bit.

I'm strongly against adding that profiling stuff to vfio, and I'm not
hearing any reasons why nova is special and it must be done that way.

Jason

