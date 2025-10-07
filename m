Return-Path: <linux-pci+bounces-37662-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 904D8BC10F6
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 13:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6304319A0202
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 11:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E57015624D;
	Tue,  7 Oct 2025 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gfbKPuNn"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790881A2398;
	Tue,  7 Oct 2025 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759834811; cv=fail; b=ldYf6+igJmm0fwE5vDK4EgWuPRHWVfcyOHJSa+OW2tvoDv9R7wN0RsUpz5UZg7loQ2lpCG4lIUwxPQnh8Et3ETox59HhZxyLnKia3YKOoMqPfIswV+o6bUlr4FnfuhcfUYbS4wc79qjTIHqLHr6ip5DenxkkRKs5pOtW7xcDvlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759834811; c=relaxed/simple;
	bh=Tyz/xAxgiiQxuVXSEUmDXo/QgIobGNsY4c0MIjEA+Mw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hOo8ly4RnTMaQMQCajv0uCRCkUhZ+S3n+HFi0I39WWSwxOTQZYN2MmUHJIP/yMOQ7ICZix+fNZcYpDAO32lz2XofGLJzdcF7NCdZ47xWg3XLXl/g01RcR1TeNIPv/+Cxs1HyNhuKFgxFEcoHFJdsjhx2cXcSusBejCyx83IxJKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gfbKPuNn; arc=fail smtp.client-ip=52.101.56.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1QoQryKM9Oo0swZn+lJQlIqiU/Ju+AI+8ziunnAEy7rmXJDIyiXduuKkti634/cn3f7FdNKOdMjKm/shaLbWoaNX6EE6wX3yxVeb8pszNWkTaGNKlxA1mBwcTZ2JvuDm1wt/FDl7D87EaSjvp7RKmEtfVcU4LrtJSzt6hxzUl5BYPuWv+WowVYKrnxZB1uzdzUDXJRes3/KKGS/Q9F2K7SjFv5LM8ZWlNNBtWCzS6z4ceXK1Awoqr9hiAfNmsmku7HzB/9bk/KfE+5qGK1mYEquf8sQe3Je/SzLhEcf08GDt05ibOpVCTDplobgc3uomyt0hviRU0ct9cYf74DtDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tyz/xAxgiiQxuVXSEUmDXo/QgIobGNsY4c0MIjEA+Mw=;
 b=hYLiffMMgoV8JMCzOUz/GKQ75fcP65zxHfcFibYfv9sdZBihYOeqoDPBIf/Pa/60bO2pNq3flaO0DxckXvF4JEV6S0/ZdMOUEPpKN4kU5PaKpGIk5CmFb824CxiN6XnxObY6AF0wK++9bMbaQ2cR7vJ41BfjAVoZ87R/iIFcUxZ8xcLx0ExL6MiXwqXYf7RwENXSPrTBQ+VBLjzmrKjyuzQfJfkURcfO+XalP2xdkpLyk3oPDNg0+EG1v6HAAGFx3w1OVcICaLHMfea81T9KTyJUHQthYgBA5NR32Lbd7GDRqD57Cn5PUP3oSInupNS6cxyOZFyx1ACx0pgm1LY2hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tyz/xAxgiiQxuVXSEUmDXo/QgIobGNsY4c0MIjEA+Mw=;
 b=gfbKPuNnVjuErcbx7+oOasZLsry7TvvYheQZ21koct9Pp8hktPnjl7kHKL8zDpBPp9DOSzimCCss7roszqulBNie59IAJxHWdhFQ+AxmekyjKiaWxOK1s1y0b7syf1whV6/0OP1M4OzFebnM+onu7eSCRupOsljmrikk9Gg0OwXSv4zOKh5fXxglqlpx5elCTThjjDHklhv/Zr27WlZxAugmHWPpfQEbnMUV9HqC8T0CrqPFFdxJVsV93WqJIPcAQuBpOMIHLn4mqqK25uGqf2hQy5lPbX4fsSG5v+FjYFG7J9Z4w3ZBg7y0RifrR3iAHh4MKrLIYLSozUOvtzQU8w==
Received: from SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22)
 by MW3PR12MB4363.namprd12.prod.outlook.com (2603:10b6:303:56::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 11:00:01 +0000
Received: from SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a]) by SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a%3]) with mapi id 15.20.9203.007; Tue, 7 Oct 2025
 11:00:01 +0000
From: Zhi Wang <zhiw@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: Jason Gunthorpe <jgg@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>, Joel Fernandes
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
 Williamson <alex.williamson@redhat.com>, Neo Jia <cjia@nvidia.com>
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Thread-Topic: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Thread-Index:
 AQHcMlax46GxNkf23km9cIaKZr5arLSsb4WAgAAQmYCAAAOXAIAAAaCAgABrcoCAAG9gAIAAa6iAgAD3WYCAABEVgIAAC9aAgAANE4CAAACYAIAHW0eAgAA4sgCAAAyoAA==
Date: Tue, 7 Oct 2025 11:00:01 +0000
Message-ID: <f52fb3f0-20a4-4b4b-a078-6142c73a4555@nvidia.com>
References: <fb5c2be5-b104-4314-a1f5-728317d0ca53@nvidia.com>
 <DD6LORTLMF02.6M7ZD36XOLJP@nvidia.com>
 <12076511-7113-4c53-83e8-92c5ea0eb125@nvidia.com>
 <5da095e6-040d-4531-91f9-cd3cf4f4c80d@nvidia.com>
 <20251001144814.GB3024065@nvidia.com>
 <c56bd720-d935-4b51-b507-d794df3f66f4@nvidia.com>
 <20251002115851.GB3195801@nvidia.com>
 <ea82af0d-663f-4038-b8c9-cf1eba5bc4df@nvidia.com>
 <20251002134221.GA3266220@nvidia.com>
 <0c94b94b-68a7-47e2-acde-0a2082ed36bf@nvidia.com>
 <20251002143116.GA3268803@nvidia.com>
 <75316915-fbae-487a-b710-ce01f088a2ed@nvidia.com>
 <DDC0EQ0793TC.2W132ZB3J9LPK@kernel.org>
In-Reply-To: <DDC0EQ0793TC.2W132ZB3J9LPK@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6870:EE_|MW3PR12MB4363:EE_
x-ms-office365-filtering-correlation-id: db5010b3-380d-4b4b-2476-08de0590a9b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RkJxaGppeGRWL01FL1lIZTBBN1JKNWxJRFVwSWRhNjJGZlZXME1JTmZNR2dC?=
 =?utf-8?B?cjlQb0RXRmU3SGZETzE5Rkd4QnlHdkpWbDBEOVh1dHM1alVnWSswazg0SzZy?=
 =?utf-8?B?SkR2UTdDVnZTd3VXcDJ0Nm9PQXppSllQL1JoaThhZFpMM3Zjc0krTkR2Nkgv?=
 =?utf-8?B?WjdmWXIwQ3RmK1JINElMdzZsekpvWHNUMEFHMUF3ZDV2Vml2WnlreFlXTnhv?=
 =?utf-8?B?eG03TnJFUmYyVGF6TjFWU08yelcyOWlrdXFhbHRjOTlBaUtUWXUrVjdERVgv?=
 =?utf-8?B?SllHNkJrK2h6N3RZMVlhZzJIeTYwWGRWZlNab0JBZUhDNmtPWStsSEYwZVBW?=
 =?utf-8?B?NWZPV3dCWTZYWkx5bTMzWnNscEt0VExWZVA5MXBPWHBpYnYxbUR4Ykc3NXk2?=
 =?utf-8?B?dWhaN3JVaTRuaGFVM05IZC9nNHZ0eklZMVVod0hGV2lPTkdhUEFURm5QUEdF?=
 =?utf-8?B?WUZlZkZybzRubTU1RnNFcm1JWG5qVzAyMURQaHZjR0dUaEdoaGt4ZDdTYW5O?=
 =?utf-8?B?d3hSNWIxcXBCR0h6YjdsQndGcEhZOENUbVZMek1zUTlEamRwbHRRNnd3RDIy?=
 =?utf-8?B?bUt1d1Z4dkhjOGF3ZXVTOTNhN1IrQnFldUJYdjM1d0NaS25YUEdxRkFIcE95?=
 =?utf-8?B?dUJhQm1BZ05EV3pMVmxlYXBMZ0tPZlk4UVhhd291OEpvbzJLeEZON0N5WXZB?=
 =?utf-8?B?RFBYaXZEbG00bE5VSkE1RXE1YkNQYWtIdWgzRHY4V0pnMHpmWkErVnZzcnRk?=
 =?utf-8?B?L2hlcFBvelZQZ2NTUWkvQVU3ajdtdUZLNGJpTlg2QlczWUNhN2ZmSTkvVDlw?=
 =?utf-8?B?KzBhZHp6SnhxSHhNTnM2ZUVQcDRrZWVpcUxrVXBXb1NISTZINFhQZStWOTFw?=
 =?utf-8?B?VzVEcGFuejRjaUYva2lHVzlYU2lsaUVJNFNBR1RFK0YzWStVOHEyVGVxTkpY?=
 =?utf-8?B?WTBWVC9CTFArWkRHWkNXZUUyVzJ3b1N0dUc4TVFzSDJYNTFLVEEzNG96VXI3?=
 =?utf-8?B?WmtMVEFvcDkzZHRFc0lhbWZySnk5em03ZGtmSVhxdGFHVEVpb3pKOTVVcEVU?=
 =?utf-8?B?anZoeEhST3lNekl1ek1yc3lHYitVTUZKSXNLQytMdzlnQlVsdHF0V05USGdo?=
 =?utf-8?B?V3NuQ3huMTVraWp4RE5jcmU5TnNNb1YrQnRXbFFXbUVZWE91djgyTnRGK2Jp?=
 =?utf-8?B?eHhWSHo4ZkNsSnl6b2JDdzdtVnZxNFRmNlRVY24yQ0g0RTdraVI2RlBrZTQ1?=
 =?utf-8?B?SUw0bjAzemtOMVZQcDRXek1SOFRhZmhNelo1ZFJzWjhDYmpQemppTEg0WHV4?=
 =?utf-8?B?eU1YWG9HbkMvQlpZQ1ByR2xYemViZ0RzbVZHYVY5WndNOXdTNkt0ZjIxeUFw?=
 =?utf-8?B?Q2lxTUswSk1rRTF3ZWQvODZVTWJ5QkE2cGo5ZjAzVUdxb2Z1bGhRSWFTMjNy?=
 =?utf-8?B?T2t0U3MvTVpjU3hlUXVEWTRSbWxwVUplWHVVdHFtVmxScXNUOXY0cDJrM29o?=
 =?utf-8?B?RGM4RmtzK0lOZ0VUc1ZEbjNEZlJTUGNJQWJGT3BySHdMZTNaZDYxY0p0TXdO?=
 =?utf-8?B?RE9yNlZLZlRxZUJIOU5mZXUrSGwycGJPaFNXcFlCRHRtSENxOFZtdjMvZ0xK?=
 =?utf-8?B?bG53bmt3cTFITWFtQ2JVSzhZTTdhbEZQZklWc3BESkdvVE9lYzhleklnTWd4?=
 =?utf-8?B?OExyV2JRMHNHZ3BqT0VtL0czWDZsZlBmT1pscVU2RkYva1VLQkkwb1ZZMG9L?=
 =?utf-8?B?YzFCbmU1ZGlZa2hTYUVkdkh0WHpZaUptQjV5UW1yS1lON3N1WmdMUmdEWnhX?=
 =?utf-8?B?ditWNE5nQlZIZlRjVlZkWDZNRkMxRnRKLzhEMlM5Umd4VUlRVXkyQWdDN1hT?=
 =?utf-8?B?M1d3c1pDMXhmVFV5N2d2Vm83eGNPU1kzTVhPMGs4MTl6U292ekhWY1NZcXN1?=
 =?utf-8?B?MHlxT2pTRG40RWx6ZC9EY28wZFRIYVZ2bU5kaUtLbGxjNWFyVlRoOStUWng3?=
 =?utf-8?B?RktKeWcrUjZicURGTDZFNm5mMkNiMm9TaERyM0JSdm9oVUZiTzBKejVPRkJ6?=
 =?utf-8?Q?ZUB9ez?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6870.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ri9iRU1FTEltRmFpTmtobWdlRUpoUVZueGZVejIvcXVlWjM5WkNDZ21sTzJX?=
 =?utf-8?B?bG92M2UrZS9LUm9RN2loVGwzUVdIZnYrclNyTHUvcWpvWXYvdjFZOC9sWENI?=
 =?utf-8?B?U3VUVGNPbGVSZEw2Yjh5ejFmbmFveDNGUWRhMnRtMnFCUVZ2RXN5c3g0Yjgy?=
 =?utf-8?B?K2FWRXRhS0VkWk9MbW5KQUZ2TUNYbXBaRCthL1ZhOHNTRUlmZ0lwcWgzSERZ?=
 =?utf-8?B?b09pRTBpN1JwRXpsOHk5UEY3SFdyNzJETGRUbWJLZGJyc1k0cGZ3THJ6aGkz?=
 =?utf-8?B?VThtRU14V1dRN1hMa2JlL3V6NW0zam4rSlBkcEVyT2kwamZyUEpqcjVnUHps?=
 =?utf-8?B?UTJsTkNaZE1lanpPb1FvNitQTFBzZlJVczd5VWc4S0VDa2VMNStZeEZ4dW9u?=
 =?utf-8?B?R2xtWUxWUmRpaEVya28yUENrcEJvUk1kQkRscUZPSVk3UEt2ZWRXZ01Zd3Vn?=
 =?utf-8?B?TnRsZzNwWXRxb2x1L1B3eVVKT3pMK3c1azFCVFVwZzQ4VUhBVGMwT000RWpN?=
 =?utf-8?B?b1pKRmVEdnFtQllqS1pTT243STY5b3BJcC9wYzk4TU1MR3FvT2d5Z3hjZDht?=
 =?utf-8?B?S3JwcG9oeFg2UTA1YUVFOGJ2ZlBaaU82M1JpejZBOXo0YXB6bEVNQ2NrdVA3?=
 =?utf-8?B?ekxWelNOczk1K0RUbm54aEpWVVJaZ3RNZ1MyOXNkYWhtd0o5NytZK3ZBWURr?=
 =?utf-8?B?VnNlblBweHJtdlUrT0RjK3Jza3hSQ3crM3ZsK0pkaDB4MDVMQUpNRnBDeVhN?=
 =?utf-8?B?a2hZTjlHS3ltWVN2NEFTaXd1SFUzc1o4RmptRjZ6eDlVZVBicFc0TnBLaGZm?=
 =?utf-8?B?clFjVGtNYmRTRTlHN2I4aGp0REJIRTNLSE5MQTBybTFCZWNqaWpEK1d4SFNM?=
 =?utf-8?B?eWtHeGFLMUJ5SFdtRTViYUJWZTZDcVFXemFKRjRudHJ3SHJ2ejhERy9EUis3?=
 =?utf-8?B?OGhqMnM5ZXRLRU1kd056b2NxS2MrVFUyazBpVVU4ZFk5SkcvRUFtT3E3QjZF?=
 =?utf-8?B?c2E5blk5TUFKL0ZYSzU4VXYvSlZiTERISXBCbFZHQjVjVjRUL0JhY3FaazJD?=
 =?utf-8?B?dGJpOWxGVXhpZU94YXAwWmFkc2NuTXE1K0RnLzlzL0g2M0Rqdkx3bnoyTzFI?=
 =?utf-8?B?UHRKVXJUNk91Y09pU2loUTYwN2RrS1dzRzE1allpSHh6c25hWHVQeHlLVU5M?=
 =?utf-8?B?UENaazM5UUdHUTRBbzhSZTFub1ZpRG9IZjRNK1ZJN2g4OUs2SFZsS1F6M3pm?=
 =?utf-8?B?UUMzL0NUa1NUdlAwbHcxY1cwdXh1TEpLQ1R1RUVrbkY0ZkQxUTVycjJLaTh2?=
 =?utf-8?B?b0xRdFlENS9oTUFTaHFuSG1XSDJLb3lsaVFoaWltd3h4eXVQUDdad0t0dkpj?=
 =?utf-8?B?ZkI4eFZ3OGZXdzlHeGo0MjM4cEhFTERBSmxrSys4bTJqbkdHV0ptNDNSb1Rx?=
 =?utf-8?B?L1d3ZzNXcy8zSm9EaGlCWnNYYnlWMFc1b1BQNXE0cHEyOHZiMVhrMVJSSTRx?=
 =?utf-8?B?TTl3eGhaYVlvMjV6REFyRUZpd0cxMUVnTVBsM25rN1o0U0VzTks1YXlseUc4?=
 =?utf-8?B?NTRCaWJjR1NFWE1qdi8vQU5nSjhUR0x4R2xsR3lLWlJvRVZtNWQ0Q096Rm84?=
 =?utf-8?B?V21VOVZvUUFReUM4Z0ZrYk9UWnB0dDRtcm8rMmRtK0lJRytiVm5MclFyNzJW?=
 =?utf-8?B?RllQY080R2VxRHZ4Yzg0Umc5eGJPL0tqa2IzMExMdDZrZThRWDlIMkx0S0Nw?=
 =?utf-8?B?R1dXMi9JZnlTbWF1WDJtYUxVRWFKOUtLYi9tRk9VY1FOU0dIVTl2RWR4cXd1?=
 =?utf-8?B?TGpqZ1VUTHA1ZW82OG43UjF5cG1NemYvd2RCVlp3QW9ZL2JKVU1tWDl1NGhJ?=
 =?utf-8?B?STA4UWJHTzBHdUhHQ1krazMzc1BrNitqNTRiRHJMVmNaYjlJT3ltZnB1Yyth?=
 =?utf-8?B?U1UxQkhMMEllbVZ1dGFGV05pVm5EY3IrRXpaN05pdG1vQnJLMXZqZkVKYnpB?=
 =?utf-8?B?c0VhdktZUkM2dG8vU1hJQzF2Q0dLZGhpUUtwamx2eEZTVWZ5SWNzYkhyRU1K?=
 =?utf-8?B?TXpzWHJFT0o2L0lJbFUwcjVlbWpGczFnaERJb3hQMTJvakFCRCs1T05RY09q?=
 =?utf-8?Q?t77o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E59FE291213A74E8742DABD6570A9FF@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: db5010b3-380d-4b4b-2476-08de0590a9b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 11:00:01.3515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XJmlXOXYi5eX4ILvdYgT6bAYBsx8mOYbX1eJcQ79d3Dw/+1oBWBkD76gwQyc2HJv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4363

T24gNy4xMC4yMDI1IDEzLjE0LCBEYW5pbG8gS3J1bW1yaWNoIHdyb3RlOg0KPiBPbiBUdWUgT2N0
IDcsIDIwMjUgYXQgODo1MSBBTSBDRVNULCBaaGkgV2FuZyB3cm90ZToNCj4+IEZyb20gdGhlIGRl
dmljZSB2ZW5kb3LigJlzIHBlcnNwZWN0aXZlLCB3ZSBoYXZlIG5vIHN1cHBvcnQgb3IgdXNlIGNh
c2UgZm9yDQo+PiBhIGJhcmUtbWV0YWwgVkYgbW9kZWwsIG5vdCBub3cgYW5kIG5vdCBpbiB0aGUg
Zm9yZXNlZWFibGUgZnV0dXJlLg0KPiANCj4gV2hvIGlzIHdlPyBJIHRoaW5rIHRoZXJlJ2QgYmUg
YSB0b24gb2YgdXNlcnMgdGhhdCBkbyBzZWUgc3VjaCB1c2UtY2FzZXMuDQo+IA0KPiBXaGF0IGRv
ZXMgIm5vIHN1cHBvcnQiIG1lYW4/IEFyZSB0aGVyZSB0ZWNobmljYWwgbGltaXRhdGlvbiB0aGF0
IHByZXZlbnQgYW4+IGltcGxlbWVudGF0aW9uIChJIGhhdmVuJ3Qgc2VlbiBhbnkgc28gZmFyKT8N
Cj4gDQo+PiBFdmVuDQo+PiBoeXBvdGhldGljYWxseSwgc3VjaCBzdXBwb3J0IHdvdWxkIG5vdCBj
b21lIGZyb20gbm92YS1jb3JlLmtvLCBzaW5jZQ0KPj4gdGhhdCB3b3VsZCBkZWZlYXQgdGhlIHB1
cnBvc2Ugb2YgbWFpbnRhaW5pbmcgYSB0cmltbWVkLWRvd24ga2VybmVsDQo+PiBtb2R1bGUgd2hl
cmUgbWluaW1pemluZyB0aGUgYXR0YWNrIHN1cmZhY2UgYW5kIHByZXNlcnZpbmcgc3RyaWN0DQo+
PiBzZWN1cml0eSBib3VuZGFyaWVzIGFyZSBwcmltYXJ5IGRlc2lnbiBnb2Fscy4NCj4gDQo+IEkg
d291bGRuJ3Qgc2F5IHRoZSAqcHJpbWFyeSogZGVzaWduIGdvYWwgaXMgdG8gYmUgYXMgdHJpbW1l
ZC1kb3duIGFzIHBvc3NpYmxlLg0KPiANCj4gVGhlIHByaW1hcnkgZGVzaWduIGdvYWxzIGFyZSBy
YXRoZXIgcHJvcGVyIGZpcm13YXJlIGFic3RyYWN0aW9uLCBhZGRyZXNzaW5nDQo+IGRlc2lnbiBp
bmNvbXBhdGliaWxpdGllcyB3aXRoIG1vZGVybiBncmFwaGljcyBhbmQgY29tcHV0ZSBBUElzLCBt
ZW1vcnkgc2FmZXR5DQo+IGNvbmNlcm5zIGFuZCBnZW5lcmFsIG1haW50YWluYWJpbGl0eS4NCj4g
DQo+IEl0IGRvZXMgbWFrZSBzZW5zZSB0byBub3QgcnVuIHRoZSB2R1BVIHVzZS1jYXNlIG9uIHRv
cCBvZiBhbGwgdGhlIGFkZGl0aW9uYWwgRFJNDQo+IHN0dWZmIHRoYXQgd2lsbCBnbyBpbnRvIG5v
dmEtZHJtLCBzaW5jZSB0aGlzIGlzIGNsZWFybHkgbm90IG5lZWRlZCBpbiB0aGUgdkdQVQ0KPiB1
c2UtY2FzZS4gQnV0LCBpdCBkb2Vzbid0IG1lYW4gdGhhdCB3ZSBoYXZlIHRvIGtlZXAgZXZlcnl0
aGluZyBvdXQgb2Ygbm92YS1jb3JlDQo+IGZvciB0aGlzIHB1cnBvc2UuDQo+IA0KPiBJIHRoaW5r
IHRoZSBiYXJlLW1ldGFsIFZGIG1vZGVsIGlzIGEgdmVyeSBpbnRlcmVzdGluZyB1c2UtY2FzZSBh
bmQgaWYgaXQgaXMNCj4gdGVjaG5pY2FsbHkgZmVhc2FibGUgd2Ugc2hvdWxkIHN1cHBvcnQgaXQu
IEFuZCBJIHRoaW5rIGl0IHNob3VsZCBiZSBpbg0KPiBub3ZhLWNvcmUuIFRoZSBkaWZmZXJlbmNl
IGJldHdlZW4gbm92YS1jb3JlIHJ1bm5pbmcgb24gYSBiYXJlIG1ldGFsIFZGIGFuZA0KPiBub3Zh
LWNvcmUgcnVubmluZyBvbiB0aGUgc2FtZSBWRiBpbiBhIFZNIHNob3VsZG4ndCBiZSB0aGF0IGRp
ZmZlcmVudCBhbnl3YXlzLA0KPiBubz8NCg0KQE5lby4gQ2FuIHlvdSBzaGVkIHNvbWUgbGlnaHQg
aGVyZT8NCg==

