Return-Path: <linux-pci+bounces-37433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8D5BB42A9
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 16:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02006326B2E
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 14:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60089312816;
	Thu,  2 Oct 2025 14:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YseI2bNG"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013049.outbound.protection.outlook.com [40.93.201.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6695464D;
	Thu,  2 Oct 2025 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759415355; cv=fail; b=hCZ3/SkRyEAWuMYknaDuFcN5VQQZnUtPCHjqjpn6H9E6WkYz+K8CRo/NqdrQJzNcT9g8m8rgFbBMKSqW5ZvK5mPLMbW93OfeA6XF7NLxaJA165n1/BaM4vEFyrYRMJSg8nAoq9GffJNsG3GMXFVNbz2rjzJfjDWT95MnY7yFnDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759415355; c=relaxed/simple;
	bh=g/MuxZi7/XGvUoFdnXE/tUMHDJcPU2GE/og+bjmHzCs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B+1o5paIjgC0D4jofGeIUDaf5z6rfKNMlO8JeNQxBmAbvAemzveB3NFci7cRFccnG6arD/ydfV2kVIh8oBWIVDC6yCykxESJ/Y+SP0aIxnRT9+IMNfJipQUb5b6JfRUhLwdFSC5iX12orAzr+KaUpyE5uHuEORZHereaBVMm6Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YseI2bNG; arc=fail smtp.client-ip=40.93.201.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ei2h99AEqm7mHAfpPwclPVxaHJL/5Rh0lU6o5KY7TO62mEy2sJp+afmxKHv2hIPg2l7Yis0GwIkBBNa0KjYx4aEI344UpcVnyDVloqYouvC8l4yAIwYS7vLplWx+Pl5U6LclW3oR1YxOSLQbgoSZm2Hp0/g1AQU2B20ysVfTrUdwICMcgEwk9VKim8n4+yiuBHH0FQ3Zmlc8RQb9sV5PIiPkCg7qLY9+XRDI7oGnHdQgLOca9Fe4h5VkX8fCQ/1v6DddRWOXS6ufsjHGrn7WTG/74oaUNJ0piSrVecSTIAmWxqyKDVvrEzbntGTR3YsjmOSPbWGxN4FEB0TyGXjrGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/MuxZi7/XGvUoFdnXE/tUMHDJcPU2GE/og+bjmHzCs=;
 b=b4Q6erEtItuJfGcMnALblraddiuOll5ZMqbA4ha88YKeueE631ZWsqeFkiUCq1yr0J7zS159/+ii/JkvNrLobvk5tkyRJ3ZGQTkKe1l9fAK+tBcH2EbDPgvvsgN11d05BgBfE+CTk7j8InQ0G1TZoip07nlnFAlg3Z933u2zdQj+METlnscGk9A7bxlLO2E8k6uBj1xxO39mX3Lxbq4IXoqAXFLtldXeZ/qe1/E92h/VSqSKPeRZl8KXzp8sjMBKdAIyC/dt+OCbhqWoSIxFHBO7BFbKMSs6OFHH9q2f8WEA90+4A5XHcJFkOZK3nM26A8I7SqnkLPTUSqnPStxv3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/MuxZi7/XGvUoFdnXE/tUMHDJcPU2GE/og+bjmHzCs=;
 b=YseI2bNGmxKvAFakV34aTNLj7WXUFrQ9LL7ggd6gKQvbfzb3HnH/i4ZzFaZZHJ+xl8oV69mxvvSy9b8I7vzVKf1LOb/zoFnai7R37cXGFJAoG0NS1H6RjjBtaKmapPzGANUlnOCRahWQeGCUSPGE53lrI8yBj9dblRskZ+nXuVyyHCA3UvXRe66AshU41ncGW6fpEtpsxR/5eEgMW6SWKcr4HMfxkUcFmJN/OFvE7olRQJi3on5MH4W/DsWfcvpVfB6bgLpeR3aK8X383cHeOHwoAHF13oYYyCkGiyrEckWK3kcGUC7vN1XBJnzjz83iLz2G6ZLZ5CmgL2ujZI76Og==
Received: from SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22)
 by PH8PR12MB6938.namprd12.prod.outlook.com (2603:10b6:510:1bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Thu, 2 Oct
 2025 14:29:09 +0000
Received: from SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a]) by SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a%3]) with mapi id 15.20.9182.015; Thu, 2 Oct 2025
 14:29:09 +0000
From: Zhi Wang <zhiw@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: John Hubbard <jhubbard@nvidia.com>, Alexandre Courbot
	<acourbot@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, Joel Fernandes
	<joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, Alistair Popple
	<apopple@nvidia.com>, Surath Mitra <smitra@nvidia.com>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas
	<bhelgaas@google.com>, =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?=
	<kwilczynski@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
	<alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
	<gary@garyguo.net>, =?utf-8?B?QmrDtnJuIFJveSBCYXJvbg==?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, "nouveau@lists.freedesktop.org"
	<nouveau@lists.freedesktop.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alex
 Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Thread-Topic: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Thread-Index:
 AQHcMlax46GxNkf23km9cIaKZr5arLSsb4WAgAAQmYCAAAOXAIAAAaCAgABrcoCAAG9gAIAAa6iAgAD3WYCAABEVgIAAC9aAgAANE4A=
Date: Thu, 2 Oct 2025 14:29:09 +0000
Message-ID: <0c94b94b-68a7-47e2-acde-0a2082ed36bf@nvidia.com>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <DD6K5GQ143FZ.KGWUVMLB3Z26@nvidia.com>
 <fb5c2be5-b104-4314-a1f5-728317d0ca53@nvidia.com>
 <DD6LORTLMF02.6M7ZD36XOLJP@nvidia.com>
 <12076511-7113-4c53-83e8-92c5ea0eb125@nvidia.com>
 <5da095e6-040d-4531-91f9-cd3cf4f4c80d@nvidia.com>
 <20251001144814.GB3024065@nvidia.com>
 <c56bd720-d935-4b51-b507-d794df3f66f4@nvidia.com>
 <20251002115851.GB3195801@nvidia.com>
 <ea82af0d-663f-4038-b8c9-cf1eba5bc4df@nvidia.com>
 <20251002134221.GA3266220@nvidia.com>
In-Reply-To: <20251002134221.GA3266220@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6870:EE_|PH8PR12MB6938:EE_
x-ms-office365-filtering-correlation-id: b1ef9b96-7c42-49de-23ab-08de01c00d05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?OU1jM2t2ZExmR0hObWJxOEt4TzlXMzNSa05TZXNlaW14ZzdJVG9UKzRIaUVQ?=
 =?utf-8?B?L1ZOWXFlYU9mR1JZeThlM295MjlsT2o2VEp0Q3VPeVpscmVWTStsYWVTSXc2?=
 =?utf-8?B?REJRZE91YzBMc1l3MTZsT2wxUlI0a00rc05Mb1ZQd29PUWsvRExmRjNpck11?=
 =?utf-8?B?T2VNaWt0RGhIQ3RqdUJCb1kxY2JmL2cxK0JUSkZCcTVXWGJQYXh4NlYrcEhz?=
 =?utf-8?B?M1QxV2pIK0dFUHJmUENML0thSDkwMjhPbXY0cXZyNTdvVG5WbW9iMjFOaHkv?=
 =?utf-8?B?Q3NyUnE5R2wyRm5jZzV0aEs5KzVNT2Q1NCtVTzNlVmtCWG5Sa1Bwa3J2RTh6?=
 =?utf-8?B?WkRzcEhIblpXUkVqVm1YdlZadkh2RkxXZjl1a09YbzhkcmViWlFYQ0dwM1U4?=
 =?utf-8?B?TlRlNnNQa3pwbVUyRERhRkU2MC90WDRMYWhHVDZUWktmS0UyTDNPSUg4YXJp?=
 =?utf-8?B?NU9HZ1BFNG5LeDl4QWZPNTNHY2lKVjgvUS9lWmxsdi9hTmZrUHZybFYvTGFx?=
 =?utf-8?B?dUt4cS9RR3dtcy9FRURGa3BaTmliaUwwcHp6dzJ3dDdQOUhCRldZSXkwdUYx?=
 =?utf-8?B?OTNyaHpXOGp3eXozMXRqYy8yZUkvVEwzTEY3c3J0V0xKRzYvV0RqbE0xYjll?=
 =?utf-8?B?clVXVHRGNEM0ejRmMml1aEg3bTM2aDFKTnVRcEx6MEVIZ1V0SFRlRU85d3JL?=
 =?utf-8?B?L0NRU2dBNGFnT3dud01tOWw0SmF2ejlkRUpWdldxT2pjSkI2dEY2d3QweldR?=
 =?utf-8?B?dnVYN3ZKUGNuSkVHSzlXcGRBZlFRU2t1YkhDcFZXMTBLdXNOdW1memw0Ymg5?=
 =?utf-8?B?L2RiK0ZRaUltaGVkcnlKK0JLT3dVcnZlNkk5QVlINitJcEtmV01yYXVaVGlt?=
 =?utf-8?B?VG8yS0V0TTNoRkxwbkxpaXU0L0VnTEVPSUZnY0o0Wi9lYS9NQkJ5QmN3dWpW?=
 =?utf-8?B?T1dJOXhQZ0NnS05oR1l2aXh2ck1NWmF6M29NM0ExdS81K1I1NE5DcndSdEQr?=
 =?utf-8?B?SCtRM2JzbzkzRDUwa0NCMGNTbHBBMVJIbVBrWUFpY3ltVlpVamt0UEg1WWNQ?=
 =?utf-8?B?bXBMSmVSbUN1UHE4Tnk4eWt2NHk3emFrc0NFUE82YnBPK1NpQlRSdUdOMFpy?=
 =?utf-8?B?Y2IxTlVVSktIRy85eWpkNmtNa1IwQm95eUlZb0Z3ajdTeGgrd0RiSXd0ZWgw?=
 =?utf-8?B?M2doWmFCa040cFVLWlFQK2JOQWF2MlEzUFlJcGpDR1I5SjY3SE55YmRQNlNB?=
 =?utf-8?B?SUY0cU9oWThNeXYyTFAvWnlJM2NXY2dyNDZiaWJFak1JQ0tJTjFnOHVlbVRv?=
 =?utf-8?B?Ym83aHVpZnk1cFFiQW5ZbnNPWk5zaTJDMURrRzB4OHVsajRVUkhxVGc3aVZF?=
 =?utf-8?B?a0VlRzg0di92SlFCNm9lM0UxTWV4UDgvS2RzV0FGOGtXRHRyOHptcVZzbmg4?=
 =?utf-8?B?WHBPSEF4R3NQWVQ2UkIwdzdMZElrSXJ2SS92Y0xROVlJQlo3S1NiOGNxbTg4?=
 =?utf-8?B?RTNncFZwck9nNUhRT3A2N0tHeERyWkxVVDd5OHBsOGZHNnhta3JjYURxSzdP?=
 =?utf-8?B?WDVoRzl1aC8vUzJINWdMMkJ5eHovdlRXaFh3YnpRRGpaYk5jYUtaM29qaHF1?=
 =?utf-8?B?Z1ZFRXhra2hJQmZsZ2x1M0hDRnR4YkEvVEdERW9lVjEySVFteUNoUU9NMUpz?=
 =?utf-8?B?cC9DNXcyR3k0M3lqREhMUDBrZ1J2K0FtZlpLK1orcGpQcDlTRzlVVkwwdEVz?=
 =?utf-8?B?MkZtRktnMlpoZ0FGVVRaT0NMSFVZTHEzK1EyTkdaUEIwb09PS1I3VmlGWXFC?=
 =?utf-8?B?MVE5YzFCeDBVNTdNOU9HSC9pbTB0byt3MUVuQldGVnJMU2xjMGRyOWY1RDFJ?=
 =?utf-8?B?by8zUHNUWnlEelU2aEdBSjJ6VXVHTUthYzhkbnF4Mnp1bk1yTzIxanBjMzNm?=
 =?utf-8?B?RFY4MWJJc3IrdTFFNU9ZRUNKUVFPUnkvOVNSQTEyUzdpczN2M09TczNlZFRt?=
 =?utf-8?B?aUNhMU1wUWR6RkczSTZhcmFTd3JHSHFtd2kvdXFKL1ZUWk5xV0hGa3M0Z1Fp?=
 =?utf-8?Q?VrJ5m0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6870.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dnA3bUNjRFAvcmlEK0JtNnlLOHE0VjBFcDY3d1l5dk9vblVWaVd2MVgwYm9Y?=
 =?utf-8?B?R3Q2TXNjcTdxSFQzTWNCRVNkY2h6VGR0aGVqb3lnOU9YTU9laVFvM3F4aGpl?=
 =?utf-8?B?UWsrejNyOEpCOXppT0lEdWhJTlE3STZpUU1LdHZuN04raFNuOENTUndZbzRI?=
 =?utf-8?B?VFRSNXM2aVpLVmxkSGJOSlJvTGxreWxabFRKOVMzZjZERUF0cDRpL1N6Y2Rz?=
 =?utf-8?B?Q0oyWUxtbms3YVZPK2YzRWI5Qit3aFpBVjY1R2p4Q3k5aXpKNi8rRVpWSFJ1?=
 =?utf-8?B?alZqck95a1NUUThRZk13aEszaU5ZaXJUZ2dkQ2JmSFhIczNSdEdiOG9tbFRu?=
 =?utf-8?B?MjhFaVZNM0VlaUFpM0dWU0JaMFVncStIcy83V1NFc2VFYWliSTFFTU9XU2x5?=
 =?utf-8?B?OGZGWEtKY0FqMTR2cEowMXNpUWNsVkZXekNJeDlEQnhOaTk0RFN6U3hmcmt2?=
 =?utf-8?B?ZGMrZmhLVTFGTW1DcFRxZHZqUmY1M0h1NnQxd29Gam8wUjlVQWlCU04zZHZv?=
 =?utf-8?B?Z2lKUEE5UmJub281dGswYS9zeEFSUGFFSndtZnpOdUVsMjlLenpaZG1rYVlx?=
 =?utf-8?B?bXB0eWl1ck9IUHowcGZOZktscURhdElkWDdWRHJVaGJLbXpsNEJPckZ5VG9Z?=
 =?utf-8?B?c0hIdlJYMVVSRk1teTEvcWpXUzhSd3l0NWJ2eFdlbXpjQmJkZjdabTUwUFdK?=
 =?utf-8?B?dkVtZUtTME1ZM1dPUllNZVpCY3NJL20rTFBmRE9DUGFWMGVpZDQ4YVhieWd5?=
 =?utf-8?B?Y01xU3FPNktSSEN0RG1GSXJzUEZUV2d0L2NUTitDVEJ2eThHc08yejhHU3Jh?=
 =?utf-8?B?aldDb2kvWUJVYW5OT2xCQ3lia091K25CVkxJNmpYV1FNUStNa29uZEdMaUxJ?=
 =?utf-8?B?WTBJQXRyOXZrbkRzTTlCZktZdFNNMlM1czBSV2lNR1BtSytEVEtJdGtsZU1I?=
 =?utf-8?B?UGpuaE9rZVFnbUYySHRTRVJXRFBtbUd6ZjdsNTRvbFVyVS9zU0NWa3dSL1Ns?=
 =?utf-8?B?cmw5L3lmQnVMMEZUTFhYWWZ4VEZ4VFdtUGJQMXgzTzdlNSt5bjlyT3BaOG84?=
 =?utf-8?B?dFBqeHE4R3E4bFdUZFk0ekMyZmRXa3VtVENWV1RIbDZ4NmtnWG5mOEhXSWg4?=
 =?utf-8?B?RDlmcFFEY3BldUZEemE0VmhYQjVsejRoUktxMWphb3FPb1R5OFhrNnkvQU9O?=
 =?utf-8?B?Q2h1ZTRoRmRWaitucGFVME1ESEc4VFNlaWllZHkzV2dBd1FwN1NoU2lSa1Q2?=
 =?utf-8?B?eHcwKytXUnlpbHBQTHpHdzV6OWw2QWU5bURIYWVjUHlaVTJmV1M2eUVKT2lr?=
 =?utf-8?B?SDJYMGk0THhTb3lEUUtqR2VVSlg2aDFEanlJenFBTFcxVTFKNnlaQnJ2MzF2?=
 =?utf-8?B?M3VISVlDYmxtRjN3T0grc0tydk9VNyt4NkFpeGxrdUpITUFaeDFvU05wRFho?=
 =?utf-8?B?RzZ4K0QrS2pHMHNzYklacG5aV2FoWVBjMEEzR2JtSWllMFBmM294OUJ6M2pO?=
 =?utf-8?B?NkRMMmFGMU84ZHQyOWJRS0habXZxSmtRdDBzYzVDMVQxeVQzWlQ1N2cwMmY5?=
 =?utf-8?B?cjVraDhGMHVPcFNZVWVpZUQxSm1SMEhMVHRkbU11YldYWk5tRTk2N2VHTnFT?=
 =?utf-8?B?MEVsV2p1aG9zQ0ZhK1gwK3FTWnVGNkNSY1djNGIyT2VONXo1ZkhlaTNqNWN0?=
 =?utf-8?B?K0MzZGptWmFFeXJxNTIyRjNGZDhIb1R1TGpHOUNsa0pOMTVnc3p3K0RCSW1T?=
 =?utf-8?B?WnFLNDF5bnloQm5ka1lwWFJGS3JTRlpOVkMvZk5hcFFxU0d4cGF3TkNkSldk?=
 =?utf-8?B?SmsyRVNEYmZLV1loQmVoK1JydmNkRStaWWpNeE9zZUZyUkZZbWtWS05lSThU?=
 =?utf-8?B?L1NGNjkydWdUdkhmelJJU3NHNHNaRGxaNU4xRnpVOWVjZFI2UldwSjByaitz?=
 =?utf-8?B?SUsyUTBxcEpkSUlNeXpnQ1Y4QlYvL3cyY1FRZnR5bW1zL1pCb3ZaeVZGeHl6?=
 =?utf-8?B?VG81QlNubFlsMWZtQnIyL0J0eFltRlZtMDA5cjZra2lBMDdiclJHM2VXQVk0?=
 =?utf-8?B?a3ZQdFZMczNOY0YxNGVDeXBpNXRTSXVmTzFjNXZZaWh4TThpbDBPem9mY2pn?=
 =?utf-8?Q?2Sp8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F327DB0A9D59F24DB5FF30E0CBC9F134@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6870.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ef9b96-7c42-49de-23ab-08de01c00d05
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 14:29:09.6891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9JCU6sxdiRJ4J1TOmz/u+JgULN6ZbCIr5zP6zlNdjLaRvi9uywy3HSEvJVfDppWp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6938

T24gMi4xMC4yMDI1IDE2LjQyLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+IE9uIFRodSwgT2N0
IDAyLCAyMDI1IGF0IDEyOjU5OjU5UE0gKzAwMDAsIFpoaSBXYW5nIHdyb3RlOg0KPj4gT24gMi4x
MC4yMDI1IDE0LjU4LCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+Pj4gT24gV2VkLCBPY3QgMDEs
IDIwMjUgYXQgMDk6MTM6MzNQTSArMDAwMCwgWmhpIFdhbmcgd3JvdGU6DQo+Pj4NCj4+Pj4gUmln
aHQsIEkgYWxzbyBtZW50aW9uZWQgdGhlIHNhbWUgdXNlIGNhc2VzIG9mIE5JQy9HUFUgaW4gYW5v
dGhlciByZXBseQ0KPj4+PiB0byBEYW5pbG8uIEJ1dCB3aGF0IEkgZ2V0IGlzIE5WSURJQSBkb2Vz
bid0IHVzZSBiYXJlIG1ldGFsIFZGIHRvIHN1cHBvcnQNCj4+Pj4gbGludXggY29udGFpbmVyLCAN
Cj4+Pg0KPj4+IEkgZG9uJ3QgdGhpbmsgaXQgbWF0dGVyIHdoYXQgIk5WSURJQSIgZG9lcyAtIHRo
aXMgaXMgdGhlIHVwc3RyZWFtDQo+Pj4gYXJjaGl0ZWN0dXJlIGl0IHNob3VsZCBiZSBmb2xsb3dl
ZCB1bmxlc3MgdGhlcmUgaXMgc29tZSBzaWduaWZpY2FudA0KPj4+IHJlYXNvbi4NCj4+DQo+PiBI
bW0uIENhbiB5b3UgZWxhYm9yYXRlIHdoeT8NCj4+DQo+PiBGcm9tIHRoZSBkZXZpY2UgdmVuZG9y
J3Mgc3RhbmNlLCB0aGV5IGtub3cgd2hhdCBpcyB0aGUgYmVzdCBhcHByb2FjaA0KPj4gdG8gb2Zm
ZXIgdGhlIGJldHRlciB0aGUgdXNlciBleHBlcmllbmNlIGFjY29yZGluZyB0byB0aGVpciBkZXZp
Y2UNCj4+IGNoYXJhY3RlcmlzdGljLg0KPiANCj4gWW91IGNhbiBlYXNpYWxseSBwdXNoIHRoZSBj
b2RlIHRvIG5vdmEgY29yZSBub3QgdmZpbyBhbmQgbWFrZSBpdCB3b3JrDQo+IGdlbmVyaWNhbGx5
LCBzb21lIHNpZ25pZmljYW50IHJlYXNvbiBpcyBuZWVkZWQgYmV5b25kICJ0aGUgdmVuZG9yDQo+
IGRvZXNuJ3Qgd2FudCB0byIuDQo+IA0KDQpUaGUgcG9pbnQgaXM6IGl0IGlzIG5vdCB0aGF0ICJl
YXN5IiBieSBqdXN0IHB1c2hpbmcgdGhlIGNvZGUgdG8gbm92YSBjb3JlDQphbmQgdGhlbiBpdCB3
b3JrcywgYmVjYXVzZSB0aGUgZW50aXJlIHNvZnR3YXJlIHN0YWNrIGluY2x1ZGluZyB0aGUgZmly
bXdhcmUNCmFuZCBpdHMgaW50ZXJmYWNlIGFyZSBub3QgZGVzaWduZWQgZm9yIHN1Y2ggdXNlIGNh
c2UuDQoNCkl0IGp1c3Qgd291bGRuJ3Qgd29yay4NCg0KWi4NCg0KPiBKYXNvbg0KDQo=

