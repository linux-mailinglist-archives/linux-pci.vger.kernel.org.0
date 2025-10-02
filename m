Return-Path: <linux-pci+bounces-37384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9392CBB22A7
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 02:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14BFE19C247F
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 00:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B292AA93D;
	Thu,  2 Oct 2025 00:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nb5iqrSe"
X-Original-To: linux-pci@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012017.outbound.protection.outlook.com [52.101.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C60A139E;
	Thu,  2 Oct 2025 00:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759366137; cv=fail; b=U4KQiWGGaymYVlCpFg7VRoYTN/1RDpESDbRcMrB+k7lWU0szRAGY7ECkrhp7dCf/fbFYEvymjrLBr951q6IQLn5VVH3y0cxqdDQRiYPvgoc7iBj0lf1noFV5PXpxwe+7K99x33HmEdJKN5fY/4xxKXETQFXa8hZHnUpj2wm7DFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759366137; c=relaxed/simple;
	bh=NIuLVugqKMRNovsNKoogy+czQooYFQIMdNTMgVK5x2U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PIRBOzw+co1Xe3VvHsMeBR969a5T22JEMLBfGOdxz2gt9jM3978oyviHbO59Fok+b+YEIED27zV8j/0K5t4Lg5I5Ff7UC2TKVEauNSu3nMjL7efp8UbPtxb0VDIDNFhU68c2oYhFc3P0EN/KRUEJoNwxTT5En1AfNTlUDiD0R+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nb5iqrSe; arc=fail smtp.client-ip=52.101.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NM0uSgRo2MrXX7tQrT4xmUsFUALd89QXMP6pXEW9UbK2hz/UE8m+2SjtXafeorlYaE4Q7b1k6oFelnZNqwaaIQ5vv9txd6ZAc0oAE/mkLH78peEsuCQpWn3PjzZds+Dh6zSBDpCWYyyw6PKX4snVRutUx6U18axcL50q03k278zefqFLxIyzO7pdqVpf5ehyniBTWkiTjM5uwPtMeouG6In9cef1XqXG31cIS2yw17m4ye8dlkIlP6gDeDJhBv/oVo0ULnXB6XexCvzPcxfBllKHErOdhYboj6mnx56Zr278GMzAbTcotBkWQPa1UXIHQCqrfIErnfRPN1o/jwucFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIuLVugqKMRNovsNKoogy+czQooYFQIMdNTMgVK5x2U=;
 b=Pm8tMXmu/nmEDsyWjKXvpEW/7cJjfqDEZGrVib3v/o0tTDSZ7q/FaL1VNVFEr3/dgogtJLaEHvFypgpdAS1wfQCpxxBcYgTgy9NmUDmpMtGHRUeBGFW1TWNiI1t/k1z+W+GYpaqANKF0Rg+g5zuxMHwqA0oRkW9cgYRYcUQbcvoSzYVvAefsrfoAlCmvRpHde0CAs7hv87Pnp9BtKbh4T/VjIKwxFpHBVZmZGV1Jzm6YDoFfUY9jOcp2Pv4bWFxdj3HYfXcNQLwbVbm8UdRZpq+P23U/g7oxx+RrIPFagiwxbAmP1BXhMEvJAF/wt5XyTX6kQv+o7EmDGNwFvDCw2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIuLVugqKMRNovsNKoogy+czQooYFQIMdNTMgVK5x2U=;
 b=Nb5iqrSeYfVdDmb5u466mdDeFTjRb0jSXRX4/NcWxIM+GQgBSYukSFr0RRowheL/3hklbRiix3FHfwsbUukBUJUXPH7BcgGZByxLT0xGOjWAQn573S5wl25scVBMfk5Tlu1XMzI9Spwek/KmBPT9F/LBNxH+chrsNJA4WzctSwrl2uIEfv+w/CCe1JwmGqkBoMdoFuJOM0lmOf8EfMyorqoy6i7pt19uoMyHegBR07V2VOKwxf8eIQPKyYP9ouNLcGrZPvz2l8GSB1LSADoooXWV30cKRSmtFnlOWuJ2D1IP+L9siovk9dC6F78GBCxRWky7ag9J6Xv8OFenx6AE6g==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 00:48:50 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 00:48:50 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: John Hubbard <jhubbard@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, Alistair
 Popple <apopple@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>, Timur
 Tabi <ttabi@nvidia.com>, Surath Mitra <smitra@nvidia.com>, David Airlie
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
	<rust-for-linux@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jason
 Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Thread-Topic: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Thread-Index:
 AQHcMlaxgAP9KUZ9sEWkb2Bjoc2DFrSscEuAgAAO2gCAAJltAIAAOAwAgACTD4CAAAOvAIAAAkgAgAANNumAAAEkAIAAATCAgAAOxxU=
Date: Thu, 2 Oct 2025 00:48:49 +0000
Message-ID: <68BD4291-A757-475D-A1AC-582EF4ADE197@nvidia.com>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <h6jdcfhhf3wuiwwj3bmqp5ohvy7il6sfyp6iufovdswgoz7vul@gjindki2pyeh>
 <e77bbcda-35a3-4ec6-ac24-316ab34a201a@nvidia.com>
 <DD6X0PXA0VAO.101O3FEAHJUH9@kernel.org>
 <f145fd29-e039-4621-b499-17ab55572ea4@nvidia.com>
 <ae48fad0-d40e-4142-87d0-8205abdf42d6@nvidia.com>
 <DD7CREVYE5L7.2FALGBC35L8CN@kernel.org>
 <e19781f3-1451-4b4d-b4be-c71c9ec8dc63@nvidia.com>
 <1FA2746D-6F73-4D5A-A0DC-803D0563A5D7@nvidia.com>
 <a7bd8285-922e-446f-9b43-a67fff67a505@nvidia.com>
 <DD7E4902SAFP.3JLTVDIKKCRWS@kernel.org>
In-Reply-To: <DD7E4902SAFP.3JLTVDIKKCRWS@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|CH3PR12MB8460:EE_
x-ms-office365-filtering-correlation-id: 7fc4e82a-f189-40fa-e055-08de014d73d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cEJHbzE5cUx2Rm93djFmMkkzK3Vyd3dCK3JWYnBlOC91SkxLVmZoR3lCbmtu?=
 =?utf-8?B?OXhGRStZRUJlZHJEYjh3VUd1dkNRT2U0M1RrNHhiNTMyUytlUzZGZzQ5NGlz?=
 =?utf-8?B?a2RNQmVGVkpxU0lOKzZpT0hqZG9WRjI5TU5nbEJCUnlVVUxvZG00MFBJVG5Z?=
 =?utf-8?B?eVJnSUZqSjYrRHNTNXE4WXpBRlAzZThZZTBESlU5SWxvYmQ4L2VjcHJyeEpH?=
 =?utf-8?B?YmI5UjZtQWNneWtWaTRCYXVyQWtRMjh3akhJNCtyNXh5VXEzNFArblZnVE9R?=
 =?utf-8?B?RzNxVG56a242ZjIwNFZoSGl2emU5MlZGdjVrM2t1bFkreDR0WkkvbTZneTNZ?=
 =?utf-8?B?QmpsS2pBTzQ5TXUxbTRpRE1GMlBhWE41OU4wRm9BSjNqamFDYVdEUzhPZWxS?=
 =?utf-8?B?SjZoYkJCaU9Wb3BBRFByQVk4S2lkZEVlanRmdHYyaGVxVG1RRVFGbXU5UlFr?=
 =?utf-8?B?dWZTUEluN3RIeE01UDVuMXJjbDBtc1BvMjZGbDBZOW52cXdQRWMvR0swZXN1?=
 =?utf-8?B?c2hoTlFiemhDeDNEalRDMUlUUHJSOE9YeVdHMExDSFpSOEdaSDM4UVZWQm80?=
 =?utf-8?B?a1FrUnppT2c5b09YajRuMjBHRXpDTEY2amJuQ0h5WEFmc0lFU1h2L1M4OUN1?=
 =?utf-8?B?VzNyQ2ZSS1p5a0szS3lXTnNWdTRJVVNTZFVuL0Jnem5wQTJOdjA0YWhSa0dY?=
 =?utf-8?B?WjFaKy9KMHllUDdZNHNFWGQ4MEJzY1FhdUtrYU40alJTZzhpeElqVEd3bEMx?=
 =?utf-8?B?YXp1Uk9NY25sN01EZzFFKytmVjdIZUswNVR0SXViM3M2UkFjb3ExU2V4cjd5?=
 =?utf-8?B?YlQ4NjVlK1ViOVEvVkFTUi84eTBqU3I3ejh3ZWNUUGNyZGhwSlhCMzJ6Z2Vv?=
 =?utf-8?B?MG96Y0pScUF3UVNSdEZsRnRRTGNLR2JvMkprNDJnREcrNnhSa3ovanZJZmFt?=
 =?utf-8?B?UUpRa0JyM0t6SnBzaUdxTElBbmJ2c3NEa1NCalFhRjA2OWYvYy92OUlDMDND?=
 =?utf-8?B?QnlvV3ZDZVZTOVErZDJQMFBLd2p4UjJIdjdqRDRMQTZVckZ4ZTRzaG1NZjda?=
 =?utf-8?B?aXQ2WnZqOXU0dU1MdTRmanExZGtHYU5tV21WWXZKdDArSHAvdnVTOU5kbGx1?=
 =?utf-8?B?NUQwK05nNzF2R2JFcitLdnhrcDJUWi94dDFHZXdDeGszeVZzeUJWR05qTHVS?=
 =?utf-8?B?NTZISERWZTVTcmlDN1NOT0U1UVJGQnpqNmM5V3djaDNncUEwb3loSUtLeXJL?=
 =?utf-8?B?OHg1SmRxRERhR2orRXYxSHBmSlY0UHlyUDd6YjBKU1BnN0Q2Z2NGelgxd1Qy?=
 =?utf-8?B?VGQ0QlJrVmQvanFqR2drZEZGQVhFL0llS1FDd1ljR0EyMXZqbmlFbVJHVUJi?=
 =?utf-8?B?NU5HblU5NFVWa2pKdEJld0tTSHRmdXpZYUNNbVljSWVPWlRNSWxyWEEwUGhs?=
 =?utf-8?B?UlBoR3NNakNZMXc4bzhNTlRQcWVWeng5bzZqbExvMFNwcnRSMkI1dnNpc3Fl?=
 =?utf-8?B?MVpZR3BPMXdWWUFzNTJGSDROMWJKUW9STEZJU2k3bWhBZmo5M0tvbzIxN2VR?=
 =?utf-8?B?SHVOVUptWUg5MFV4OTdodkZzOFlwQ28zeWRnZWFhT2JVeC9hL21WOEF0L0Q5?=
 =?utf-8?B?ci96MWhCcGtiTjZKTEE3T04ycTdTN3l4Zk4wMDUzbTFIVmRiRmQ5cXRqRnhs?=
 =?utf-8?B?VU9ySWhRSi9NQzA0ZEY2SHJ1TTZzSktaeTZVV0g1ZUtVeDlSdWZHc2luOE5m?=
 =?utf-8?B?UkpxcG4zZC93WXFGa2RsZGptSmNrL3NCbXBTV1gyeDdSZ1NQTjZOMVdoOG03?=
 =?utf-8?B?L3dUR1BNU3Q4WUM1TEg5SzQvZkpJNUw5Qi9IaWRONElabmkxcnRhZTJyWGda?=
 =?utf-8?B?Z1lUa0Y4YTdhVlJVUE90a2tzM0tuMGhuSzRXSGlUcks3TnpoZVBhd0F3RmFZ?=
 =?utf-8?B?aXJmNzBJTWUycjl1Q05GSmg5Mm9ack13eGpHZzVsb2hPUWt0WGNFV0h0OVFM?=
 =?utf-8?B?Qm0wakh0Wm54UG1SeWJpeTIzdmFQRjR5ajNMQlZ4WUc1Qzhla0l4MnVBaHZz?=
 =?utf-8?Q?caQl+q?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YkNVay9ibnRoOHZlcVBYcXVNeG5jSEpVVE8yc0FUbCtIWE5odFlTL2d1RExi?=
 =?utf-8?B?T2tVdnZVU2Q3S0NVVTM3Y1dLcGg4dHdNamwyUG02SENlRHIvL0hRdGpQU2Fu?=
 =?utf-8?B?Nzc2bG8zMTl5cUdycHhFQnBiTk9zeFNqVE5qeGxYbTN4TmFaUmZmQTJ1bWRn?=
 =?utf-8?B?OWx6aHd5dHZZRDU4TnZUZ2tSdXRWQlF4ZDNPVURQYWlKOU9XZEtBMEcxdXo5?=
 =?utf-8?B?c2JiclFnN3JOYUl5SHE5UTRkQ2h5K0NEeXphaGJuVzd1SDJITUNmcnRIT2ZL?=
 =?utf-8?B?cE5MNGNtTTlFYjRwMHFwd24rN0U2TldoOWNkam5XZlBaMy9OL0hLRHI1V0g3?=
 =?utf-8?B?WTJkSTVxQzdUcFV3VEIrSEtXWUZOaHNGRnY3bW9DUnJXRkYvUDJmWWVCeGww?=
 =?utf-8?B?ZjV1ZWJLamJJZ0FxSEFsWXEvUDRpc2pDNWpXRWFQc2dOVlhJTkJRRUc1bWd6?=
 =?utf-8?B?VDY0cEViVGd0ZnVUVDlMKzhTWkVMaVAwQ3l4ckp1SkY1WXlMSlpFNGpETzdV?=
 =?utf-8?B?VENNRnhPYno5aytGd1gxVWRZT3puY1ZaR2Y2NGNGb0dIRVVtOW1YdEpaZmcy?=
 =?utf-8?B?RmJEZUVWSnRrQUNqZmJIM2I2UmhDbzlyUVdjZU5zdWszdXNVZytOWVlDVWlD?=
 =?utf-8?B?NDlyY1FjUklKZ29BdmZ4cDVnMWk0a2JRYnk1dDZ0UTQ0SFdxNUlCYmVtaHF3?=
 =?utf-8?B?ZlFSZmQyaXdDcW53dGhsTncrUy8rVWptOW1CbzhERHg5QWg5OVBnamoyV3Fq?=
 =?utf-8?B?Vm9MNXVjaGdoMzRyRkNDVU9ib0NobnFBQ2VsY0YxbHhCL2lkbTZiMU9EYWpD?=
 =?utf-8?B?RkFGdEZwN0ZreTdBMTU5Q0JiR0Q5dHgxa1JMRGNTRVJyaElPbXdrMW5FOGsv?=
 =?utf-8?B?dHptS21tTVI5QThQU2xTdFEzaWZOQXBCQVRHZnVWeVNqM21IOHRXVXUvNnZE?=
 =?utf-8?B?cXZJNEE3TUZrUENqWWx2TUVtQi9CeUFVRVlkVmtSdHFGZWM4VlR1TWdTYWdN?=
 =?utf-8?B?Y25jT2NlSXZyRVc4YWFTcFM1aWRSbFRESC9yYWZVSEJNRFVuT3JmOHo4TVFt?=
 =?utf-8?B?TEczRjNrNk5oRzhqYWNyTHN4N1JGd1FHWEF2V2FXZXdkRDdtR3pwa2MwZ2Ji?=
 =?utf-8?B?Z2VHa1NYVGJCdStweVc3RzVya093N1ZyOUlydWkzb2piellMSHhuTlVYeVdI?=
 =?utf-8?B?cDBXZGtIL0FiaEVKZVVVVXpVNGY1WE03ajA0WlAxZklJVFNseWlyNFo5ZXpj?=
 =?utf-8?B?Y1M5eTdZbHZNZjZqWjNTTUM0bEZ1RkhWL0Z5OVQ0dmY2S043STQxb1RMSmpn?=
 =?utf-8?B?eUVQem9qczRPRkptUWFlNExtbHlEaVlSeU4zc3pDdVVxZXNkLzV3dzhwZ0VJ?=
 =?utf-8?B?V21tVDN4Sm1EVU1qVjhqK1B3QU1hbWpkTHpiK093VElxSkJRUzBOOUt3WVhK?=
 =?utf-8?B?eVBrT2ZQRlp1UFVvQjhvMnBVQ3JZWW9OL0U5OGttTHNzeTIxVHlmNUdBZ1JF?=
 =?utf-8?B?UUYrRDJFMEhuYkJxRVFORmZtZExOOEVzeFhWYnBzMEF4WDg1ZkR2aDhzSjI5?=
 =?utf-8?B?K1VwaXNNV0dIUHpUZi9BWHk5aUhXd2NzUCs5aWt3Z0FjSk1zQUhWK0VYUXlT?=
 =?utf-8?B?TGFrMjRCcDM4WnhqOHpzalJBMW8vVURCZFBoaXhTQWpNWmRGOXVYdXZFeDNM?=
 =?utf-8?B?UHF5aHBtSTZ0d3BKNi9mTmo1Q0N1RjBEQ0ZHYzFBSFludUpOeDQ5bjFRTzhU?=
 =?utf-8?B?VXBRZE9ybjNTUExkMDQ2Ukw1elVLWVArQm1XdVU1WFplR1c5OXBIdlZDeHgz?=
 =?utf-8?B?cUE0OHdZdzNDemhSVi9TbHZMY1lkcVNWUEFVZjgvTlpxbzJMQlcxVjJYL0lQ?=
 =?utf-8?B?QmhJelhNQjFKRjhCZEVhUS91eFhjamR2cVBGSTc0SGo0SEdJcTJiRC96NmlM?=
 =?utf-8?B?WWJ0YnMrNkF6WEoxN1ltZmVKaWlzaXNIZkttTkZGN3BicWZzOW50VHZJeXVB?=
 =?utf-8?B?U1Y1cUJUdGMrN2V4R2I2U3cycUJJOWZrQmNwV2JralNVREwyMUowM3N2Zkpk?=
 =?utf-8?B?bEgzcVJkR3pCTC9mcU9jdFVObnVSN1NmMSs3WHVUU0FvYjNpZ1c3cmhWZEdO?=
 =?utf-8?Q?0vN0yRMKvKfVuynVmZmciIfV4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc4e82a-f189-40fa-e055-08de014d73d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 00:48:49.9872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2lVmLj0ll3aRhd5we99manQaOxi9E+YtyXIC9B7lnO176i3yelO378AFsrMPAwIOqnuhsSgciI4ztb/XFBKdfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8460

DQoNCj4gT24gT2N0IDEsIDIwMjUsIGF0IDc6NTbigK9QTSwgRGFuaWxvIEtydW1tcmljaCA8ZGFr
ckBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IO+7v09uIFRodSBPY3QgMiwgMjAyNSBhdCAxOjUx
IEFNIENFU1QsIEpvaG4gSHViYmFyZCB3cm90ZToNCj4+IE9uIDEwLzEvMjUgNDo0NyBQTSwgSm9l
bCBGZXJuYW5kZXMgd3JvdGU6DQo+Pj4+IE9uIE9jdCAxLCAyMDI1LCBhdCA3OjAw4oCvUE0sIEpv
aG4gSHViYmFyZCA8amh1YmJhcmRAbnZpZGlhLmNvbT4gd3JvdGU6DQo+Pj4+IO+7v09uIDEwLzEv
MjUgMzo1MiBQTSwgRGFuaWxvIEtydW1tcmljaCB3cm90ZToNCj4+Pj4+PiBPbiBUaHUgT2N0IDIs
IDIwMjUgYXQgMTI6MzggQU0gQ0VTVCwgSm9obiBIdWJiYXJkIHdyb3RlOg0KPj4+Pj4+IE9uIDEw
LzEvMjUgNjo1MiBBTSwgWmhpIFdhbmcgd3JvdGU6DQo+Pj4+Pj4+IE9uIDEuMTAuMjAyNSAxMy4z
MiwgRGFuaWxvIEtydW1tcmljaCB3cm90ZToNCj4+Pj4+Pj4+IE9uIFdlZCBPY3QgMSwgMjAyNSBh
dCAzOjIyIEFNIENFU1QsIEpvaG4gSHViYmFyZCB3cm90ZToNCj4+Pj4+Pj4+PiBPbiA5LzMwLzI1
IDU6MjkgUE0sIEFsaXN0YWlyIFBvcHBsZSB3cm90ZToNCj4+Pj4+Pj4+Pj4gT24gMjAyNS0xMC0w
MSBhdCAwODowNyArMTAwMCwgSm9obiBIdWJiYXJkIDxqaHViYmFyZEBudmlkaWEuY29tPiB3cm90
ZS4uLg0KPj4+Pj4+IC4uLg0KPj4+IEhlcmUgaXMgbXkgb3BpbmlvbiBhbmQgY29ycmVjdCBtZSBp
ZiBJIG1pc3NlZCBzb21ldGhpbmc6DQo+Pj4gDQo+Pj4gSXQgZmVlbHMgcHJlbWF0dXJlIHRvIHJl
bW92ZSB0aGUgb3B0aW9uIG9mIG5vdmEtY29yZSBiaW5kaW5nIHRvIGEgVkYsIHNpbmNlIG90aGVy
IG9wdGlvbnMgdG8gZGlzYWJsZSBhdXRvIHByb2JpbmcgZG8gZXhpc3QgYXMgSmFzb24gcG9pbnRl
ZCBvdXQuDQo+Pj4gDQo+Pj4gVGFraW5nIGEgcGFyYWxsZWwgd2l0aCBWRklPIHBhc3MgdGhyb3Vn
aCBmb3IgaW5zdGFuY2UsIHRoZSB1c2VyIGFscmVhZHkgaGFzIHRvIGRvIHNvbWUgZGlsaWdlbmNl
IGxpa2UgcHJldmVudGluZyBkcml2ZXJzIGZyb20gYmluZGluZyBhbmQgdGhlbiBtYWtpbmcgdmZp
by1wY2kgYmluZCB0byB0aGUgZGV2aWNlIElEcy4gVGhpcyBjYXNlIGlzIHNpbWlsYXIgdGhvdWdo
IHNsaWdodGx5IGRpZmZlcmVudCwgYnV0IFZGSU8gc2V0dXAgcmVxdWlyZXMgc29tZSBjb25maWd1
cmF0aW9uIGFueXdheSBzbyB3aWxsIGl0IHJlYWxseSBpbXByb3ZlIGFueXRoaW5nPw0KPj4+IA0K
Pj4+IEkgcXVpZXRseSBzdWdnZXN0IGhvbGRpbmcgb24gdGlsbCB0aGVyZSBpcyBhIHJlYWwgbmVl
ZCBvciB3ZSBhcmUgc3VyZSBub3ZhIGNhbm5vdCBiaW5kIHRvLCBvciBvcGVyYXRlIG9uIGEgVkYu
IFRoaXMNCj4+IA0KPj4gSSdtIGNvbmZpZGVudCB0aGF0IG5vdmEtY29yZSBjYW5ub3QgcHJvcGVy
bHkgaGFuZGxlIGEgVkYgd2l0aCAqdG9kYXkncyogY29kZS4NCj4+IFRoZXJlIGlzIG5vIGV4cGVj
dGF0aW9uIGF0IGFsbCBmb3IgYSBWRiB0byBzaG93IHVwLS15ZXQuDQo+PiANCj4+IFdoaWNoIGlz
IHdoeSBJIHRoaW5rIGl0J3MgYXBwcm9wcmlhdGUgdG8gc2tpcCBpdCByaWdodCBub3cuDQo+IA0K
PiBJIGFncmVlIHdpdGggSm9obi4NCj4gDQo+IElmIGEgZHJpdmVyIGRvZXMgbm90IHN1cHBvcnQg
YSBjZXJ0YWluIGRldmljZSwgaXQgaXMgbm90IHRoZSB1c2VyJ3MNCj4gcmVzcG9uc2liaWxpdHkg
dG8gcHJldmVudCBwcm9iaW5nLiBDdXJyZW50bHkgbm92YS1jb3JlIGRvZXMgbm90IHN1cHBvcnQg
VkZzLCBzbw0KPiBpdCBzaG91bGQgbmV2ZXIgZ2V0IHByb2JlZCBmb3IgdGhlbSBpbiB0aGUgZmly
c3QgcGxhY2UuDQoNClRoYXQgd29ya3MgZm9yIG1lLiBJZiB3ZSBhcmUgZG9pbmcgdGhpcywgSSB3
b3VsZCBhbHNvIHN1Z2dlc3QgYWRkaW5nIGEgZGV0YWlsZWQgY29tbWVudCBwcmVjZWRpbmcgdGhl
IGlmIHN0YXRlbWVudCwgc2F5aW5nIHRoZSByZWFzb24gZm9yIHRoaXMgaXMgYmVjYXVzZSB0aGUg
VkZzIHNoYXJlIHRoZSBzYW1lIGRldmljZSBJRHMgd2hlbiBpbiByZWFsaXR5IHdlIGhhdmUgMiBk
aWZmZXJlbnQgZHJpdmVycyB0aGF0IGhhbmRsZSB0aGUgZGlmZmVyZW50IGZ1bmN0aW9ucy4NCg0K
VGhhbmtzLg==

