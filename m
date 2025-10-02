Return-Path: <linux-pci+bounces-37427-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3BBBB3F7A
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 15:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375F519E014A
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 13:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450CD3112D1;
	Thu,  2 Oct 2025 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aT973K4r"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010045.outbound.protection.outlook.com [52.101.85.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92554311941;
	Thu,  2 Oct 2025 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759410005; cv=fail; b=qxI3OlfI7Rslinx7aGwgNT1TkUZpbyYEoYBaFQxqW7/Iiwq8InbKS5HRtbAZ3vinHIEcDdY0WveyW8dAi5rwDow8uX3tGjBfhEm2VYMAuDWeLXHYBnX3otidxv4bp0nMDPeta1eifpSVNn5maUlGx7uQAJVQFONhUjO3xDi7R6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759410005; c=relaxed/simple;
	bh=+OuW1xzh8qBQBETYes8ckcvdJCI+92RhXTMe8BHvvpk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lwTZ+btOMnNZATBwOfuqV4+yxZZ0FOgYPsH+12YlbcIFpzctawo0+ZVlziqPE1o6sEfYdczJVhL/9xbi1TdO9i7/YhPPA67nw0Ygy4FdBffO3BvjHMKCuwckKv1OYuRvpCRR4tLgt/82ZxP9tN/ip8CtMqnEa1snhITZbwei4nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aT973K4r; arc=fail smtp.client-ip=52.101.85.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9/zY96XotsAYJVHXS3GE6TLSDB+8PcLWNpzWA8CDafpfppn++et8sYVIGKrWBJGkcC32E+rpb+RaFkvpfxZikWOwfxOPu0fHopqeWpj5GIBg4efz4BxmLs2wejgU7+PIoL4hvFz3AbkMc+JKg4rn574pF9ctWr4iXZ6dmZfvqnNY5cjTODywv+Ne95X/lUUsJ5bPNuFvemc9AcUqTc6nNd+wv3S4kZvL+Lgl47q4ijZLURD/w5YUBYXSpZrPYP6tLpdOsSNvKujhmAeoDxfl69MiUgaVshUS/ACCZ6EgF9UqAJ/+1WS3yMds7WaKkTWqqFTXEAQHNcxBRp/yX3isg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OuW1xzh8qBQBETYes8ckcvdJCI+92RhXTMe8BHvvpk=;
 b=QB/LgdtwGg68PrKhppivH9uW3UyqnwSNq+hTD89AsktGJp3II7B4YthHwoPENFckC0BJgGPCUvZ3A/FoQsomSmQc0SY0hjuexlhHGQXaIoKuBua6hW8ShdnJ2wYUCybzhkBMbZNvaTMdptu08v/QtKsmpq+n+ff+QNl1CZFyaXPJ0bzzQ/Mo7YXua2hmB8ZF10J+GsnJKaHNDXmiw2MLaP5q3ZA5El3oXkj2/dJ4MoPIUyvqQjAUk3cnpoGCUxb9WbcAF2ngGFvoVsMDn8FTWWEaxegtX0ma+Z2ujD+I8c+FGV76s58cTmeiZrBRFbGcGEfGbeR0RQ2m7LfTqjxebQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OuW1xzh8qBQBETYes8ckcvdJCI+92RhXTMe8BHvvpk=;
 b=aT973K4rWR4wvqTLHM70O1vzEdRKTFq6kh8G9yzmt7CZYmHjI+dQOryKX/9ZJ4/aDh/xVjur5Pi9rAFLMAyOymP8nDG2on4k0yYFVwhYdcu0kfjEHfejH7FivNNbJOlkTKNMIrxWYqsePGLDlaIUWFlqcETdyfyS9iAbz0h+CF25jeJ37MudWuXA9vWAqJEMFyB4M5oQEWT3ZE79m+56CTXKfxor0hrfUaymT9avSPLeOsZQtmxEnx2ilDSvQCOx8F1G1JFApiZZBMjmO8ArIevJI+TDf8+HI3BVna+BzUUwy5GW1jH1IjjJvb1Ks+bMRo6XhCRnfplwBXs8nQkXmQ==
Received: from SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22)
 by CH8PR12MB9813.namprd12.prod.outlook.com (2603:10b6:610:260::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 12:59:59 +0000
Received: from SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a]) by SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a%3]) with mapi id 15.20.9182.015; Thu, 2 Oct 2025
 12:59:59 +0000
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
 AQHcMlax46GxNkf23km9cIaKZr5arLSsb4WAgAAQmYCAAAOXAIAAAaCAgABrcoCAAG9gAIAAa6iAgAD3WYCAABEVgA==
Date: Thu, 2 Oct 2025 12:59:59 +0000
Message-ID: <ea82af0d-663f-4038-b8c9-cf1eba5bc4df@nvidia.com>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <DD6K5GQ143FZ.KGWUVMLB3Z26@nvidia.com>
 <fb5c2be5-b104-4314-a1f5-728317d0ca53@nvidia.com>
 <DD6LORTLMF02.6M7ZD36XOLJP@nvidia.com>
 <12076511-7113-4c53-83e8-92c5ea0eb125@nvidia.com>
 <5da095e6-040d-4531-91f9-cd3cf4f4c80d@nvidia.com>
 <20251001144814.GB3024065@nvidia.com>
 <c56bd720-d935-4b51-b507-d794df3f66f4@nvidia.com>
 <20251002115851.GB3195801@nvidia.com>
In-Reply-To: <20251002115851.GB3195801@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6870:EE_|CH8PR12MB9813:EE_
x-ms-office365-filtering-correlation-id: 814f52ed-0eac-4417-efe0-08de01b3980d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TWRkdFEvZDI3RDc1U1JLeENSWHZNVUQyRzBWbm5DVmh5bHhSd2hqRFVRL2FZ?=
 =?utf-8?B?bXN1SnAwckNlRHlLaUJ0VHlEUHBKVnkxdFB2K2RVa2orNFRrYW50OXNwdjdC?=
 =?utf-8?B?eXJlN29hSnM5VEh3Y2habzVsSDVRckdKWjZpc0V2cGhtVm5VTHF0YjRIN2tM?=
 =?utf-8?B?VzFMbGtIQnZrenRQc1c3c1FOQWM3U3VkY0hvVVFwZ0xTcDkvRjlOQWtBWk9k?=
 =?utf-8?B?bmt4cTk1d0hlOE00RFZSd0taQWhUbU9JVDROV2I4TFd0b1dsTE1uMlBJNlY4?=
 =?utf-8?B?VzRza1dGSFpPU0o0WkpMRmtXZC84aTI3ZnVCNm5IMXpRQmdrQ3FQQjdZQUhJ?=
 =?utf-8?B?MFRvRGpTQXBKYnhORklBSU5ueFFpT0JQOGMwTUtpUzI3a0FjYmVVbm9hRWo3?=
 =?utf-8?B?RW5ZelRsbm9Zb3NBQTBtdFNaSEtCRVFkLytGbURWeUx5TmZTZVFIZHRvS0E4?=
 =?utf-8?B?a0RqSngrSTNKSnlaMm5PTlJhcGFaYlRkQ2NES1ZwRlNSSlIralJpbG96bTNz?=
 =?utf-8?B?c2RjSkIxWkdVKzZCMmxMN29yNTBmMkNDS2V0aGp6dnN5QVBncjVJUjdZQm5M?=
 =?utf-8?B?b2J4ZXRwSGxEbVpwL3M1YmJSOHUzRzFZVzFBWlpkNnNIWG1oQjVSaFVBR2Fp?=
 =?utf-8?B?M0tpM21qVmJ3d1NNcnpmcTd0REJjeWh0c1JvRE5FQlBUV1NzZ3dlanZtM0tR?=
 =?utf-8?B?UUFKekorVVZTTzFnTWZYQ3dMNmFXYzdxYjQwcHdDcTVXdlI2RncwNGJ1UUVx?=
 =?utf-8?B?ZEd5eXMvZkpOQ1Ziak5BLzliMGhQY1lObGxxNVZPQi9wRXRwSnV4ZXZSNDZ0?=
 =?utf-8?B?VHhsdGpYaGcyUTBlUG03Qm5hVUJxZXlEM2ZpQVVDdXF1cURRY2J2S3hMM1VC?=
 =?utf-8?B?b2l6NDVQYnMrOHhmZExpQmxkTHE3QjBmZG9xWGNuVjVEOENPZWRDVlkyWXBx?=
 =?utf-8?B?dHdrWE15aTdOeEUwbVNoTnNXOG9xZnl5Q2svRlA1QmVWRit6aFZ4bGx3RUZZ?=
 =?utf-8?B?R3FBQmkvSGNWd1c3SnpCSTJPR1ZLS0ZGQzBscHd6V1EzS3grY2k0RkM0VWdr?=
 =?utf-8?B?dmMwU1kvbUlCMEhXRStZZUN6SFp4bXovWXdjdE5KMzlzVytNVUJ3QzJjdkFY?=
 =?utf-8?B?aGxqV1lmTy9SUE0yMzc4RlBUK2FWQ0pLZUU5Y2REd2o3cUcwcW8yT0pRcXJy?=
 =?utf-8?B?d1IxV2pjdHMrUjJNdDd5bEVVTndIVk9MUDF4YmF2ZTVjSFNmVjRlUS8vRTNp?=
 =?utf-8?B?Sm0xQlArLzcremNpcnlNZklXWUdDVU92eWQrZS9xRGkzdnpEQXBTTXRVT1Zl?=
 =?utf-8?B?THptVGtKeEhlN2V1WVVyR09oRFBaUExidjFBMURkcWpQdFhJUWo1K0VOcjNr?=
 =?utf-8?B?VHNDR1RKN3RiMG9vODlmVFN2a2pBWm96YjcxQkNLMDBiS0tEc21uQ0FmK0N5?=
 =?utf-8?B?WW8xejh6aXVMQnUweU1LYy9RQ2x4dDA2cjhHbmpyZC9PemZ6S083Mml2WW5q?=
 =?utf-8?B?aERGeUNqZ3dvSEpuVnNNZXEwOTluZFJYSHpRMW5RS2puYU83bXcrT2pxSnVL?=
 =?utf-8?B?VTZRaHY4L0pZbU1nTC9DN0crYU5wYVBFWWtKYkFKS0hLZ2lVZ1l4UmI2R2NE?=
 =?utf-8?B?SG5pYW9GbFpMRnFvUWkxSkpaVzJoL3RIS21DbDhSeitPZG9iYUhqVUllczAw?=
 =?utf-8?B?UzliM0VKQ2M0NVB5Tmw5SkJmajBuRGFxUWJpS0l4RkJTSG1lRlZqUkx3bFVi?=
 =?utf-8?B?cUVSOWxGdVQ5NUJaeXBzeU5LczE5U0Voay9TSHJIWGZSR3J3Qnp2WFdjek9F?=
 =?utf-8?B?WHhhY1hYUHJ2OENoeWczSWJnRVh0eFYvenBxQnJycjVkU09kQzd2OXJ2MEhw?=
 =?utf-8?B?SncrNmhKMkpHOTEzRHN1bStlQ1cyMHpzaUF5cTE2a1grckZlV21yaFhPU1lD?=
 =?utf-8?B?WTZEenE1Ynp6N1lzVWVMbzhPc0hJVXRUTng1MENTVXltZGUxOVpKdWhYN0FU?=
 =?utf-8?B?bW1Ibm5HbHNiZWRScC9QVUs0bzltYW5iMHUyYlg5VU1jSHY4RThDYjVObTVx?=
 =?utf-8?Q?5S3cvX?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6870.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?STdPM1hRbzRwMzlQeTBzQ0tQdFVCZGdDempZd2ZjWUE4ZzFudGVtVEcxVTZI?=
 =?utf-8?B?bFlCZmcyZ0RTZDJiVmhGWnZ0NlRTVG5VMTFJU3ZkSVNscVhDU1JJbkwvcWcz?=
 =?utf-8?B?RHZTd00rRnFqTXFxODFHdG5SbXBhSlluQ1lFVVhwMURQQlZINm5EL3d6YU1p?=
 =?utf-8?B?eXdZZXdwaVRKRXd6czNkK1BnbXE4YTBONW5oa0hTb2JseHhrVXdxRjJDYnF5?=
 =?utf-8?B?WEJNMUpCUituWlkvbjJKQ0ZNOTVxR0ZGSEFHVWdEaVkyUjlqYmJVQUtSOE5p?=
 =?utf-8?B?bGRJZ2VQc3RKQWU4eGlQLzI1ZjBHYVRlSVJGWG5kM2VGelpGKzh0WWwrckln?=
 =?utf-8?B?cUk0YUZISnZ1Rkg3RzJvZTA4Q0xmdHVONzI1VTJKdnZJMFVDY0tzRDdVaXFU?=
 =?utf-8?B?WTluVkJCekZ5T280a0xwVGE3akQwbVZSeUtnSXQ0b0p0cUoyRFB4NDJkejY3?=
 =?utf-8?B?U1Azc0R6RnczditGMmVOR0FKd2dGOHlZWmRHLzN2NEFUWkEwbTMvOXJ2Y3B6?=
 =?utf-8?B?Y0FwRlAvZDhlUHVzbnJKQnFpTW1WNEpNS2YvZU85a3BmTWVkWEdrSjJUSTR5?=
 =?utf-8?B?dG9icGRLZVJnTENsanRkVXJtd1ZRRVpJMnlOY1VTVzZteEZmQlgrcGxsUDhi?=
 =?utf-8?B?dnBCZXlIaTZJajZhQ1dMejVrNGZTVCtLbUswZ0tIUm1EdmJZbE1iQ2hqWEVS?=
 =?utf-8?B?cWNnMnE0c0hvaXhDZEpSNzUzVkRUdEg3d1hSNHBrNVNscStNS2NJdElDdlh2?=
 =?utf-8?B?WWFaYVNyWFpYekdsa2liQ1FLL1l5Wk9UNzN0VmFMZkFhUEpvYUtIcVRvZllx?=
 =?utf-8?B?UXNHblpKbDFnc2UvMkp4aDBxeXIvZmxmQkNYSlROU2p1YzI1QkpoZVQxMmV5?=
 =?utf-8?B?aXA0em5xbUpTTlk4Yi83dGh4Nzh2ZmhlVVJtTHhHM1FPTnpVOW91cE0yWjVD?=
 =?utf-8?B?UUZRdjUwVXhtOHZySjBDck9obFIzZEV2c2w3TlFsWXQzMCtMQldaMk0yZkR3?=
 =?utf-8?B?WW5yOWUxVHdPeWFoTnU2NDBrSFR1SHZLY3ZrYmNDUU9KWEM1QjNHRlM5SUZS?=
 =?utf-8?B?TG5MOHNQc1JtNG00ZGNwTXV1aEVub3Y5ZXN5UkxycUtrVlM4RzhHNnFNOFo5?=
 =?utf-8?B?NjlLOG1SWHlZR2h4aWY3K0h1aEJJcUlQL0JUOCtEVWZCdGljZzB3U1pIR093?=
 =?utf-8?B?NWY3LzFHQ1dBajF4RGZUQnkyTXpycUIvMlY5a0FyNDYwdWh1R2EzN3NSbVlk?=
 =?utf-8?B?NG1Oa2xRUVE4RWVxWlgwM2kxZnVrTmNzdHdrNElFNHIxVnkyWWtSWDlhb2ti?=
 =?utf-8?B?b0RMOVBoaUw2aXpLblowN0YzMktJY1U4dzhkcm1PejBXN3VwaDdEUTlDN3Ns?=
 =?utf-8?B?OXZzbDBNTGgzOXZIQlU0U0VhOXozZlVrenhOVTQ4N3JRSVg0M09XS0p3M0lX?=
 =?utf-8?B?WWJ3dkhzOTVrYVBYYWFZcDRaai83bFhuWVlmcitWbGYzcEFrSW5SV2QxQmd6?=
 =?utf-8?B?N3ZXMnFKU3J6djhneGt1Vjc5K2dYeUhBM1psdHlRRVhMaDJWMUxsNGM0MExB?=
 =?utf-8?B?ZDQ1aGhWUG4xOTBJT1Bjc0FpRHFRZHF3VzlWZnF5NWliUVhNY25oK0o2L1hQ?=
 =?utf-8?B?MnpMNWtyVEtTNThRZnU3a05qMHlGVXhaMjJrU2Y5NVNqL3grSlFUZE5CVkZ3?=
 =?utf-8?B?a0FVRXc3aFdOL29ic0VlQU1tYVN6eThJVkpuOW9vNG81K2xMSGZQRE5JSkhP?=
 =?utf-8?B?dURHWnoyM24wU0ozQWd6dnRXSEJ3UUlnUkJqZHBUNEJ3d0hEQU1SMkZieUlh?=
 =?utf-8?B?M2Z5ZTBKUGFUMU1IYUQ1dkRRcVdVbmg4b3lzbTgyeHI4Y044SGVnalVJYlEy?=
 =?utf-8?B?emo0djlLVXVoSjd0RGgrSCtnd0NYQ2hsN1d2U1JGcUNHbXgzT0Y0YWxiWnJ1?=
 =?utf-8?B?aFZ1cGJmcWYzSitRQk5DeFMwdTVmZWRmb0dUNlY0VTZNK0pXQkpRSnVDcWFU?=
 =?utf-8?B?UXZCRThGbVF6L1VNMWxXYTBqYm8yazZZelRXbTE4S3ZwdWwrZzZDRDVHUFZR?=
 =?utf-8?B?Vy9RQWNnM3dwWjJ2emloU3RGMVNmeCtLT0k2S0Q3MFp2VS9VQ3J0OEdTRTFj?=
 =?utf-8?Q?DQ/0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B57DE9A2C24774B8BB7FD7D4A43239A@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 814f52ed-0eac-4417-efe0-08de01b3980d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 12:59:59.4506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dUD5vUNaQ/OI+TBgvyrqxUlxV+UgahHQc2DR/NxU7cz9jPSMLI6GAdpQU5ON9xPP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9813

T24gMi4xMC4yMDI1IDE0LjU4LCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+IE9uIFdlZCwgT2N0
IDAxLCAyMDI1IGF0IDA5OjEzOjMzUE0gKzAwMDAsIFpoaSBXYW5nIHdyb3RlOg0KPiANCj4+IFJp
Z2h0LCBJIGFsc28gbWVudGlvbmVkIHRoZSBzYW1lIHVzZSBjYXNlcyBvZiBOSUMvR1BVIGluIGFu
b3RoZXIgcmVwbHkNCj4+IHRvIERhbmlsby4gQnV0IHdoYXQgSSBnZXQgaXMgTlZJRElBIGRvZXNu
J3QgdXNlIGJhcmUgbWV0YWwgVkYgdG8gc3VwcG9ydA0KPj4gbGludXggY29udGFpbmVyLCANCj4g
DQo+IEkgZG9uJ3QgdGhpbmsgaXQgbWF0dGVyIHdoYXQgIk5WSURJQSIgZG9lcyAtIHRoaXMgaXMg
dGhlIHVwc3RyZWFtDQo+IGFyY2hpdGVjdHVyZSBpdCBzaG91bGQgYmUgZm9sbG93ZWQgdW5sZXNz
IHRoZXJlIGlzIHNvbWUgc2lnbmlmaWNhbnQNCj4gcmVhc29uLg0KPiANCg0KSG1tLiBDYW4geW91
IGVsYWJvcmF0ZSB3aHk/DQoNCkZyb20gdGhlIGRldmljZSB2ZW5kb3IncyBzdGFuY2UsIHRoZXkg
a25vdyB3aGF0IGlzIHRoZSBiZXN0IGFwcHJvYWNoDQp0byBvZmZlciB0aGUgYmV0dGVyIHRoZSB1
c2VyIGV4cGVyaWVuY2UgYWNjb3JkaW5nIHRvIHRoZWlyIGRldmljZQ0KY2hhcmFjdGVyaXN0aWMu
IFZGIG9uIGJhcmUgbWV0YWwgaXMgbm90IHRoZSBvbmx5IGFwcHJvYWNoIGZvciBzdXBwb3J0aW5n
DQoqY29udGFpbmVyKi4gU29tZSBkZXZpY2VzIGFyZSB1c2luZyBpdCBiZWNhdXNlIHRoZXkgaGF2
ZSB0byByZWx5IG9uIGl0DQp0byBkZWxpdmVyIHRoZSB1c2VyIGV4cGVyaWVuY2UuIEl0IGlzIG1h
bmRhdG9yeSBmb3IgdGhlbSBiZWNhdXNlIHRoZXkNCmhhdmUgdG8sIG5vdCBiZWNhdXNlIG9mIHRo
ZSBhcmNoaXRlY3R1cmUuDQoNCkkgYW0gbm90IHN1cmUgd2h5IGRvIHRoZSBkZXZpY2UgdmVuZG9y
IGhhcyB0byBiZSBmb3JjZWQgb24gc3VwcG9ydGluZw0KIlZGIG9uIGJhcmUgbWV0YWwiIGlmIHRo
ZXkgaGF2ZSBhbHJlYWR5IG9mZmVyZWQgdGhlIHVzZXIgYSBzb2x1dGlvbiB2aWENCm90aGVyIGFw
cHJvYWNoPw0KDQpJbiBmYWN0LCBhbGwgdGhlIENTUCBJIGtub3csIHdobyBhcmUgdXNpbmcgR1BV
IGNvbnRhaW5lcnMgKG5vdCBWTS1iYXNlZA0KY29udGFpbmVycykgd2lkZWx5IG9uIGNsb3VkIGdh
bWluZywgTUwsIHRoZXkgYXJlIHVzaW5nIFBGIGRyaXZlciBiZWNhdXNlDQp0aGV5IGFyZSBleHBl
Y3RpbmcgaGlnaC1kZW5zaXR5IGNvbnRhaW5lcnMgd2F5IG1vcmUgdGhhbiBhbW91bnQgb2YgVkZz
IHRoZQ0KR1BVIGNhbiBvZmZlci4NCg0KSSBkb24ndCBzZWUgdGhlIHBvaW50IG9mICJWRiBvbiBi
YXJlIG1ldGFsIiBpcyBtYW5kYXRvcnkgZm9yIEdQVSBjb250YWluZXJzLA0KYXQgbGVhc3QsIG5v
dCByaWdodCBub3cuDQoNClouDQoNCj4gSmFzb24NCg0K

