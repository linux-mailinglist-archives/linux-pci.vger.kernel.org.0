Return-Path: <linux-pci+bounces-40978-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA40EC51A0F
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 11:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C1CD4E28BC
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 10:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E866A280025;
	Wed, 12 Nov 2025 10:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Ti+Wj8or"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011009.outbound.protection.outlook.com [40.107.74.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076E020FAAB;
	Wed, 12 Nov 2025 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942653; cv=fail; b=ilZbNmzi72z5usvGl1CbHd0LzFHkwpVfQ/I0MfY8bE16A0rzShfjcRdYm0Z4QzJUjhRF3kuVvebeR1JOOsWksl6v2OUSUhBzBY78bvoTmNTW4e8TZNHFXxUnmIVl3QDbE42nEjCWdsZdGrZW80qxhN7WSLG6FMVL106HTJiCip8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942653; c=relaxed/simple;
	bh=tPI75JK9C53NIwh+IMU36iyFwL+xdsHgt295oJ/FFws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KYjTAv1V1FyfUPXsMI9mhAIqKHbQx+vWPPTETPyJ7wzTsGYY4kREjV4YCfKhbhGKQPiW0njlNLSMT7rN68jN9JKZQ7M3p4g5mvWtZzHAyVqggle5WuVY6a95O0xUWyKZUedM05iP63ePy5uyDhPUD4GyrbNaN2nPWd8UDxaqOUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Ti+Wj8or; arc=fail smtp.client-ip=40.107.74.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYAozIqk8lrGJCPDAssqXwNbp770IStor0nuWQPxziMSL6Tlt9ib8yPwj2mfQeiltOFdc0mKcYDrIXyf2fGAnNbP70K4ZQT9t9FANxO4lCqAndHcq61lPe9qEQgxvXs8YcgWeh12QZcG/llIU9h8Hr/TMhSCZaUNHFIDH+aU0rHt3ptlVa1sfmqi2obUZoP2Mg5DOfBOxJIW36jwlu0rZ9jySLJv9dkBF7PP79dIGd3VG6X8P1I34QzOhujZPHxmfnKEBW+dyaAQEbVIwG2sfFcPfFLxeObUoxNesd53QWScSoqnahgZhuLmZine7DRXamcwo29rA0Qz8s/Bz3vatg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPI75JK9C53NIwh+IMU36iyFwL+xdsHgt295oJ/FFws=;
 b=D0Em7HXUnuwjYL4BpVEUGaWxG5OJt30btKjHpvyYGEwP/48ngszzeTiMfq05ThITszu/tNmtmKgWQPrlP8kfVUmlSDH5bYPFbwwvmHgdmHGXA/7DqIMI6pES26cwLopR7EEX0fDJUGYVdoP8a2bVrZnwalw3BTQd5xESfFUQZj2WyLQ9V231s+JbE/NzpBzhwMSFYlLBsdRR4pPWtyUfsior2AfsmNz9PSh1H9EVzRIB81j5ZcyIJCiobv3//R3c8YK4g6MUtEY4U6VDI6K7osGJqPgV9oFnLq6oEa6ZvxtTyu7znWs1nAkOETCT3BHMZkTevGKwmb0+Sf0SrWPUwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPI75JK9C53NIwh+IMU36iyFwL+xdsHgt295oJ/FFws=;
 b=Ti+Wj8orKZeZg3Jo/DtQwe+UQwxB26BbHkM8Dzb+4rmjNb1yLjObOuzP/ZwsBXocT1SN8QBIqdZSMxLua+qOrU9Sn4OPIf/eT94ci0F31BG88OenVRGWDaUGfsVcZwlF3XAOjmJLN09JWgzCFge3p3M5hOY8j8TtkTdLL2iNYIS29IeEy5gklSSrvPiD27mshkYW14Dli2QtMPYDkH5wa3rhbkUt7rl8ckBgUiyDvvtPjtfd9E+AYieLXxLGfEhUQRYDX7x4upy1SJFcKjILh+r+b+7U4vTw+fNLOdfXAwL38fZMWLrrbhaAXUUGHQehvDRUJltHBLzTNt6ZThqdUg==
Received: from OS9PR01MB12421.jpnprd01.prod.outlook.com (2603:1096:604:2e2::9)
 by OS9PR01MB16199.jpnprd01.prod.outlook.com (2603:1096:604:3df::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 10:17:29 +0000
Received: from OS9PR01MB12421.jpnprd01.prod.outlook.com
 ([fe80::6569:be59:abd6:eb0]) by OS9PR01MB12421.jpnprd01.prod.outlook.com
 ([fe80::6569:be59:abd6:eb0%7]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 10:17:29 +0000
From: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
To: "'dan.j.williams@intel.com'" <dan.j.williams@intel.com>, Balbir Singh
	<balbirs@nvidia.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "peterz@infradead.org" <peterz@infradead.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Kees Cook
	<kees@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Andy Lutomirski
	<luto@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Andrew Morton
	<akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
	<rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
	<mhocko@suse.com>
Subject: RE: [PATCH] x86/kaslr: P2PDMA is one of a class of ZONE_DEVICE-KASLR
 collisions
Thread-Topic: [PATCH] x86/kaslr: P2PDMA is one of a class of ZONE_DEVICE-KASLR
 collisions
Thread-Index: AQHcUFfqaFp2q2XfZ02e6WqAx2HKZLToET0AgASDKACAAiKNkA==
Date: Wed, 12 Nov 2025 10:17:29 +0000
Message-ID:
 <OS9PR01MB124215C4182B59D590049B99390CCA@OS9PR01MB12421.jpnprd01.prod.outlook.com>
References: <20251108023215.2984031-1-dan.j.williams@intel.com>
 <d6ad21dd-82f1-486e-8a0d-b007b39b4d32@nvidia.com>
 <6912767eb60ac_1d9810070@dwillia2-mobl4.notmuch>
In-Reply-To: <6912767eb60ac_1d9810070@dwillia2-mobl4.notmuch>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9NDc5ODJhNDYtOGY2ZC00OTNlLWJlNjQtZTIwNmY1YjNm?=
 =?utf-8?B?YmU0O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjUtMTEtMTJUMDg6MTA6MzJaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7TVNJUF9MYWJlbF9hNzI5?=
 =?utf-8?B?NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfVGFnPTEwLCAzLCAw?=
 =?utf-8?Q?,_1;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB12421:EE_|OS9PR01MB16199:EE_
x-ms-office365-filtering-correlation-id: bddb0755-aa18-400f-8a4a-08de21d4af80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?WENpSXEweFZDdnVjZ2pZV0MxUXRNMXhQa0J2ckRGMktHc3h6akcwYlZRMEhu?=
 =?utf-8?B?a2RlS1doR1pFbk02aEZLNlVZckhhRituT3dYNVlweE9jWUQxL3hQbzhESko0?=
 =?utf-8?B?bDQzclppOXIrWUt3MTNmMUliQlo0UHZnWk1HV1BFWTNjVTd6OW1Da1JVblcy?=
 =?utf-8?B?c0NpQlRQOSt1SlpJVnJIdUdQYkNwc09YWlpLYy9HYXp0UGVsUm1CUWtnOWFQ?=
 =?utf-8?B?ZG1waWdDeFFDdVhkM1NkUGFRcVNtcmxnSjhLUXI2UENtR0VaRTRLUWkzNTkx?=
 =?utf-8?B?TUhXTTZWZmlmZzJoK1gwa202VkFrdGtFbGZqbUcxUXpCYnFBSzNLeks1dHFS?=
 =?utf-8?B?bVF0ZXF3cXNBMTgzY1BWZXp3RUxxRmloNnpnc1hZWGZDSDl2ejlMVU9KL3A3?=
 =?utf-8?B?Rkp4UEZLOU1leFViM2ZUbnpVYUtoQi9ZeDZBK1owKzN0OGF6bkxSTnY3M01M?=
 =?utf-8?B?ZmN5d1lNZzZqdkI1TnNhNisxUnVxOE11ajh4ZEEvVXgyMVA2R0lpRitRWHN3?=
 =?utf-8?B?djV1SGIxempjWUp5U1R4S2p0cjNHRmZHak9iVmRTL3hwb0w3OXM4dlY3MUMw?=
 =?utf-8?B?VnJKMW5GUjhzU0FMS2pmTzB4bHFpcXoxclpEOUhIYjdBU25CV0FJTjd1YUlW?=
 =?utf-8?B?aGxoQzFNbE4vRVluUTIxeGxlZnJZQTNRT0JHRGZjenFEUklXNUxZNmZlNGoy?=
 =?utf-8?B?UnU1KzlVT2p5RGsrMFZpdjZodVU5OHlqbFMxT2RnVWpWLzRxWmVnRSs5ajFO?=
 =?utf-8?B?emE1QytOOXc1VTVuRlB4WmlXV3IzRjVaYmZPbEdjUm1ING9MZThWaXU1TGpO?=
 =?utf-8?B?QnNWaUNUMnNRdW5sUmpDa01yYjlRQjRWVVdBMmFYVmw2eWZVbWpabE96RlBI?=
 =?utf-8?B?YnRCTVpsWXBYVVArL2VhMXpvbGQvTGlZTGwySmZjOStqTE81ZUhIc3lmRHU3?=
 =?utf-8?B?ZFJNRDAxRUtUeFVSeFA2RXZCTmYvWm5FTk5oVmtFZ2kza2pEazZneVdUTUJ1?=
 =?utf-8?B?NytpWXdBSVVPakVEcVNBRDJaZk5nb0dwdVc1N1JZN09NK3JTS0d1WXRvcFl1?=
 =?utf-8?B?TXIzS0pRc2xkZU9rUDQ3YkVXTmhsYnVWdHJnS1dJVXhqK0JIZ2EwZnZUeWls?=
 =?utf-8?B?cm44eDZoTkw0eTF6bWd4dzZyMFhUNk5kQ0NLRkVpL1R3dloyRnBsRnM5ODRi?=
 =?utf-8?B?ZkZNT25RWFRzempIaEhXVURnT3dnOWNta1lUb0Y5KysvL1pUSmJqaGlkNmhl?=
 =?utf-8?B?N0dkOXpkQkoraFdwQWhacDVZU0JEMnRFWVBiaXJQcDlNeUVzVG50UXVtbU4y?=
 =?utf-8?B?aXRnc05vZTJwVDdSU0N6NlRjTXJBYnE1eVNwQlVpV1NvTzN0a2lhbWorQWJH?=
 =?utf-8?B?bkcxbDh6aWVQeVc2dWVObjB4ODRvc0FhWVJHZ0gwSWMyMm5YSytnQ3ZkT0V3?=
 =?utf-8?B?bVBJaWlaR3MyYlZqaHROenZFNWF4bFlyeEx3SHNNV0ZJaStQMFdRa0doZmhT?=
 =?utf-8?B?ZDBsSDVnQmxtc1dZVWtJL0JUTElEaHJqQTNZZnV0dVpLSTBrKzJCdnlmUmdG?=
 =?utf-8?B?VVRLRWxxWFJ3VnRvK1QrM0VwcEhYNTdOSXhhWHgzLzFkSmZ1a2pyVklZTktL?=
 =?utf-8?B?TXhnVG5VK2d4RForSENhWDNvb3FDa2NaSVJoTWNLcUZqakVuVVptT2NIOEpr?=
 =?utf-8?B?ZjZtYWtFMENtM2FGbCsvNFlJTmZxSDZkRHdKdE1XVXVaUzJyWUxkOWhudUJw?=
 =?utf-8?B?MHJqWlhVUER4d2djK3VKVExwL1M3UFlManpJMUJuS2pmK1p4b3FkYVlXaHFE?=
 =?utf-8?B?Nk1FRmVVUEhuK1NnakY5bTc2UWJQR0NhUHpCb2JDdmE0SHZmdGlqMTZiWlNq?=
 =?utf-8?B?TVVvdzQ2TGZ2cGh1Z2RXa0p1N3BaMFJzUURTQ0hnejZ0dk5lUjJGbzhSN2M1?=
 =?utf-8?B?UG1Ba004ZnFrbXNmQmVRRGllcmk5RzlzNFBIQmpXUk5UeHFpU3paMmVmYVRn?=
 =?utf-8?B?VUlJUHRWaDduOWMvZ2JBK25iRjZpVFlseHJPVVBXcFArZk5ZM0ZTZTFUa0pp?=
 =?utf-8?B?R2xoQi9ubkpWNnhRb2ZUN293RXRiY2RoNFVPZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB12421.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Rk1mczZoYllqbUFOSThtTnZGOTFXb1N6QjA4a1lsVjhRVk1iUDQxWWdBRi9E?=
 =?utf-8?B?bk92ZWROT1grMDJMSXlNMTZ5NDJLTUxWTCtucEtKQVhOZW1VamNjRVRaQlNT?=
 =?utf-8?B?MlBaelpKWE81bUxZc3RQTmVVLytLRk8wY1VIWWo4MThKMit0Yi84RXlDUmhm?=
 =?utf-8?B?MHdrS1A0ME00Y1hwVS9vNTB4OUxZcWlzc0J2YnpLTDZnY2xPTG5iNGhyN0N6?=
 =?utf-8?B?UzZyb01jTTJYa1hlWFJ0RWJLZk91U0tJcFIweUNrb2RMUGhHb2NuSkNDT3Mx?=
 =?utf-8?B?c2ZGZE5WWEZHQk95eng0bDY2OWh5RzlycnJJV1labnZFVFlGRUFWTnV3QXlu?=
 =?utf-8?B?WDU5T1R0ZkJ1eURZcXdUdTB1LzVGR3JabUJkWWhlSFZmendyR3JmaWlFSm9h?=
 =?utf-8?B?OTlManFkRk5TMWJRcGxTWjVSZUZlZUd6KzZ6RE8wcXJUTXQxaHdyQmRuM2c1?=
 =?utf-8?B?V3p6cFJyK2YzaTJvVzlBKzdqMWU5dFpXeDBhYzA3Z0hja3plclV4L2xOUHlo?=
 =?utf-8?B?NFp3Q2xOK2FBQkpJVUtwK3pwcXVvZjRaSDA4clllYnpZTHVwVlZ5SG1EU2h0?=
 =?utf-8?B?SFBoU2VaRHdUVTJKeTB4RnU2dG1jZ2ZvS3V0WFdFZU9Pb1FZMm82QUxFNk4r?=
 =?utf-8?B?UkRVSU9xa0szdnp3Z05aWUMrbEJOa3pnTG1ONzNQVFk5a3FNc2ErVGtBTjFF?=
 =?utf-8?B?Z09QREdTb0VyWGhvWHNUUXBGekV1Y1U5SndZNlkxczBWQ2FidnFmMFlkcTdN?=
 =?utf-8?B?ckovWVZGQ1FPQ1BDWnN4UlBoTGJkaVRhQVU0NUdyUktzS0k1OWJzZVczUTN0?=
 =?utf-8?B?SVJuVjh0cnNTcDI2VHV5SWpXRi9lck1NdzNjZm1ZcEpmN0dvTnJnNEtpOW90?=
 =?utf-8?B?S3drckpKdmdTSXJ0VmY1OEVLOXBYK290dmdWUlc3SmNibDVVK0x2ZWs0T3dj?=
 =?utf-8?B?Q0xFdFhpTzU1RVhkZUI0c1NRNlVQREV6bTBITkxXM051ZHd3MngrbWRrcmJt?=
 =?utf-8?B?aytmR3lVVFdmdkgrS3NrUEg2ZFVlRkRzcmRrcjJIQW42WDEvc2RBbXczWjNU?=
 =?utf-8?B?Z1hOeENOc2hsWmh3cjYvRTlhSVJRb1VrbTRNNm4wQVg0YzVja2sxbW1JVXE2?=
 =?utf-8?B?azE0a2RxZ01US2h6NzhJZ2xmZVQ4SUgwTVNReUhqczQ0OTh5UGZkNmNBNXVk?=
 =?utf-8?B?Z3FucUh4d3o1K2liWHBlY0pWT1ZVdTZaRlpKOTZCdU1TQUF5YjRVelFicGdt?=
 =?utf-8?B?VTBUQWdKbjZpcFVxbjFnTG0vUzdhcEJhYll0SGVJWmxwUWZnT0tKRjIwMm44?=
 =?utf-8?B?eE1sTkdZTDN0eG1COXZaNUhsTnZCSDFVYlVvY0R5OXlDRTl3K0E0LzJxdTZ5?=
 =?utf-8?B?SVY3cDNDOWI4L0o3czgvdHNuM1p5L013WkI5czl1WGJyb2tVd2o3c3F6d0hU?=
 =?utf-8?B?SzBSd3FBY1NaSko0bkJhcXhKNTVXYk1hMEdaWFh2d0Ztc3ZmeHNDMGNCQnRw?=
 =?utf-8?B?Y2Jaa2VvbnhPRHlOc05HTmZSRW5QN2hIcGFZa291ck1QMzNHYVB0eVE3STQ1?=
 =?utf-8?B?M0dIbXV6QkQvVkVXbld4NGRsNFV4NXF1aEcxNENKUnhVUGlVMjRZdVROL3NE?=
 =?utf-8?B?ZlkzRzBwTDJBZGtVZTFjSDFYUTZrV2dZMXJDdEtNSXdEb0dzLzFFNFpIaE1r?=
 =?utf-8?B?bW9VZWYxeFVCNGNyVnRkZDRSRTVYdlJmaGtDdjB0SFpFS3FvbTd1c3ZDdXRh?=
 =?utf-8?B?YUpUbGdnVTZFOUdTYWdXc0szWDJmZXpzT2FNTit6aXZtNU5JQjJIZXBodnBM?=
 =?utf-8?B?N2o1ODltdXJ0RjdlWEFyUnA1c3p6YlAyZXBkMjlKdCsrYjd0TTVEaGZUMWhx?=
 =?utf-8?B?QnlBT0psdmpqbXZ3UExmRHk2OFRNLzYrZmc1YjEwdkZXYlZEbmRaUTI5ejBo?=
 =?utf-8?B?YzNIMVFwdDNZcVV1Tm52elhMM1d1N1pBa25xMDlVUVhNWTF6SFdSUmowZVlt?=
 =?utf-8?B?blV4dXF5T0I0MWQxL2FGK00rSnhqZ0hXT3NPdFBXbEwxMTdvK3JFZVRaSXo1?=
 =?utf-8?B?VjBjbGYvc3orYTNpOE1YZEw1cmxmQ3Ntd3Q0QjlUV01QT0ZxMVdwTW9ON2h2?=
 =?utf-8?Q?hdgqzUJ5eTMCe9s6EjmE59bi/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB12421.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bddb0755-aa18-400f-8a4a-08de21d4af80
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 10:17:29.4376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t4+37f+A+zyRpYHZIiMML/kKTXwxcbgLcqSvbk+jdOH9nE/dAHH2qBXKo+bXKGGDfGtEmazJzn4K2SLaeY2EEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16199

SGVsbG8sDQoNCj4gQmFsYmlyIFNpbmdoIHdyb3RlOg0KPiA+IE9uIDExLzgvMjUgMTM6MzIsIERh
biBXaWxsaWFtcyB3cm90ZToNCj4gPiA+IENvbW1pdCA3ZmZiNzkxNDIzYzcgKCJ4ODYva2FzbHI6
IFJlZHVjZSBLQVNMUiBlbnRyb3B5IG9uIG1vc3QgeDg2DQo+ID4gPiBzeXN0ZW1zIikgaXMgdG9v
IG5hcnJvdy4gWk9ORV9ERVZJQ0UsIGluIGdlbmVyYWwsIGxldHMgYW55IHBoeXNpY2FsDQo+ID4g
PiBhZGRyZXNzIGJlIGFkZGVkIHRvIHRoZSBkaXJlY3QtbWFwLiBJLmUuIG5vdCBvbmx5IEFDUEkg
aG90cGx1Zw0KPiA+ID4gcmFuZ2VzLCBDWEwgTWVtb3J5IFdpbmRvd3MsIG9yIEVGSSBTcGVjaWZp
YyBQdXJwb3NlIE1lbW9yeSwgYnV0IGFsc28NCj4gPiA+IGFueSBQQ0kgTU1JTyByYW5nZSBmb3Ig
dGhlIENPTkZJR19ERVZJQ0VfUFJJVkFURSBhbmQNCj4gQ09ORklHX1BDSV9QMlBETUEgY2FzZXMu
DQo+ID4gPg0KPiA+ID4gQSBwb3RlbnRpYWwgcGF0aCB0byByZWNvdmVyIGVudHJvcHkgd291bGQg
YmUgdG8gd2FsayBBQ1BJIGFuZA0KPiA+ID4gZGV0ZXJtaW5lIHRoZSBsaW1pdHMgZm9yIGhvdHBs
dWcgYW5kIFBDSSBNTUlPIGJlZm9yZQ0KPiA+ID4ga2VybmVsX3JhbmRvbWl6ZV9tZW1vcnkoKS4g
T24gc21hbGxlciBzeXN0ZW1zIHRoYXQgY291bGQgeWllbGQgc29tZQ0KPiA+ID4gS0FTTFIgYWRk
cmVzcyBiaXRzLiBUaGlzIG5lZWRzIGFkZGl0aW9uYWwgaW52ZXN0aWdhdGlvbiB0byBkZXRlcm1p
bmUNCj4gPiA+IGlmIHNvbWUgbGltaXRlZCBBQ1BJIHRhYmxlIHNjYW5uaW5nIGNhbiBoYXBwZW4g
dGhpcyBlYXJseSB3aXRob3V0IGFuDQo+ID4gPiBvcGVuIGNvZGVkIHNvbHV0aW9uIGxpa2UgYXJj
aC94ODYvYm9vdC9jb21wcmVzc2VkL2FjcGkuYyBuZWVkcyB0bw0KPiBkZXBsb3kuDQo+ID4gPg0K
PiA+ID4gQ2M6IEJhbGJpciBTaW5naCA8YmFsYmlyc0BudmlkaWEuY29tPg0KPiA+ID4gQ2M6IElu
Z28gTW9sbmFyIDxtaW5nb0BrZXJuZWwub3JnPg0KPiA+ID4gQ2M6IEtlZXMgQ29vayA8a2Vlc0Br
ZXJuZWwub3JnPg0KPiA+ID4gQ2M6IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+
DQo+ID4gPiBDYzogUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPg0KPiA+ID4g
Q2M6IEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJuZWwub3JnPg0KPiA+ID4gQ2M6IExvZ2FuIEd1
bnRob3JwZSA8bG9nYW5nQGRlbHRhdGVlLmNvbT4NCj4gPiA+IENjOiBBbmRyZXcgTW9ydG9uIDxh
a3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPiA+ID4gQ2M6IERhdmlkIEhpbGRlbmJyYW5kIDxk
YXZpZEByZWRoYXQuY29tPg0KPiA+ID4gQ2M6IExvcmVuem8gU3RvYWtlcyA8bG9yZW56by5zdG9h
a2VzQG9yYWNsZS5jb20+DQo+ID4gPiBDYzogIkxpYW0gUi4gSG93bGV0dCIgPExpYW0uSG93bGV0
dEBvcmFjbGUuY29tPg0KPiA+ID4gQ2M6IFZsYXN0aW1pbCBCYWJrYSA8dmJhYmthQHN1c2UuY3o+
DQo+ID4gPiBDYzogTWlrZSBSYXBvcG9ydCA8cnBwdEBrZXJuZWwub3JnPg0KPiA+ID4gQ2M6IFN1
cmVuIEJhZ2hkYXNhcnlhbiA8c3VyZW5iQGdvb2dsZS5jb20+DQo+ID4gPiBDYzogTWljaGFsIEhv
Y2tvIDxtaG9ja29Ac3VzZS5jb20+DQo+ID4gPiBDYzogIllhc3Vub3JpIEdvdG91IChGdWppdHN1
KSIgPHktZ290b0BmdWppdHN1LmNvbT4NCj4gPiA+IEZpeGVzOiA3ZmZiNzkxNDIzYzcgKCJ4ODYv
a2FzbHI6IFJlZHVjZSBLQVNMUiBlbnRyb3B5IG9uIG1vc3QgeDg2DQo+ID4gPiBzeXN0ZW1zIikN
Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwu
Y29tPg0KPiA+DQo+ID4gUDJQRE1BIHJlcXVpcmVzIFpPTkVfREVWSUNFLCBNb3N0IGRpc3Ryb3Mg
aGF2ZSBQMlBETUEgZW5hYmxlZCwgeW91DQo+ID4gbWVudGlvbiBzbWFsbGVyIGRldmljZXMgLSBh
cmUgeW91IHJlZmVycmluZyB0byBrZXJuZWxzL2Rpc3Ryb3Mgd2hlcmUNCj4gPiBQMlBETUEgaXMg
bm90IGVuYWJsZWQgYW5kIG9ubHkgWk9ORV9ERVZJQ0UgaXM/DQo+IA0KPiBUaGVyZSBhcmUgMiBj
b25zaWRlcmF0aW9ucw0KPiANCj4gLSBPY2Nhc2lvbnMgd2hlcmUgUDJQRE1BIGlzIGRpc2FibGVk
LCBidXQgWk9ORV9ERVZJQ0UgaXMgZW5hYmxlZC4NCj4gDQo+ICAgSSBzdGFydGVkIGxvb2tpbmcg
YXQgdGhpcyBhZnRlciBhIHJlcG9ydCBhYm91dCBDWEwgZmFpbHVyZXMgd2l0aCBLQVNMUi4NCj4g
ICBJIGRvIG5vdCBoYXZlIHRoZSBrZXJuZWwgY29uZmlndXJhdGlvbiBmb3IgdGhhdCBlbmQgdXNl
ciByZXBvcnQsIGJ1dCBJDQo+ICAgY2FuIG9ubHkgYSBpbWFnaW5lIGl0IHdhcyBpbmRlZWQgYSBj
YXNlIG9mIENPTkZJR19QQ0lfUDJQRE1BPW4gYW5kDQo+ICAgQ09ORklHX0RFVl9EQVhfQ1hMPXkN
Cg0KSSBiZWxpZXZlIEkgYW0gdGhlIGZpcnN0IHRvIHJlcG9ydCBDWEwgZmFpbHVyZXMgd2l0aCBL
QVNMUi4NCg0KVG8gYmUgaG9uZXN0LCBhZnRlciBjaGVja2luZyB0aGlzIHBhdGNoLCBJIHJlYWxp
emVkIHRoYXQgdGhlIGRpc3RyaWJ1dGlvbiBJIGFtIHVzaW5nDQpoYXNuJ3QgYXBwbGllZCBjb21t
aXQgN2ZmYjc5MTQyM2M3IHlldC4NCg0KVGhlcmVmb3JlLCBJIHRlc3RlZCBib3RoIFAyUERNQSBh
bmQgWk9ORV9ERVZJQ0UgcGF0Y2hlcywgYW5kIGJvdGggd29ya2VkIHN1Y2Nlc3NmdWxseQ0KdG8g
YWxsb2NhdGUgcGh5c2ljYWwgbWVtb3J5IGZvciBDWEwgaW4gbXkgYm94DQoNClRlc3RlZC1ieTog
WWFzdW5vcmkgR290byA8eS1nb3RvQGZ1aml0c3UuY29tPg0KDQpUaGFua3MgYSBsb3QhDQotLS0t
DQpZYXN1bm9yaSBHb3RvDQoNCg==

