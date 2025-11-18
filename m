Return-Path: <linux-pci+bounces-41492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7ACC689AE
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 10:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 577594F20A2
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 09:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8958E29D29C;
	Tue, 18 Nov 2025 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="s3xQLcn/";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="gMq/Rk0e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A911391;
	Tue, 18 Nov 2025 09:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458771; cv=fail; b=rjZBgFETkBr777czGno9ktUzf5Q9Nh3dH5tRYvX9j3kCk1w5VnAkEkhE+kQxiirMR5LDUwumTVKSvpath0mypzTq0rLsgcN5+WOkT7hdkYT9GctfoAmKafr7INoJGdPld3fPMM91gOaPdzeLUhakK577m+yTLflytvP3QVgK0M4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458771; c=relaxed/simple;
	bh=ivkwV5oE/STrAI9iGXT8kA/El3W1suq9EaS6QtN/xoc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QZWMOfXXpFZFf9wHZHzbN3OADORokfmwAm5Ska6h6jQt+CWs2WoxbmQ9um/p3JqSEu64LjyzrkvEpl45t5b1LUz2o9KeT7Q2GM3jNeVyTTO0Fqez+joxTSGi67h8tTzBnJaGeuLXlGK+yRPl05IRl0T3YE6S2WbduHAXS+9pHCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=s3xQLcn/; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=gMq/Rk0e; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 769dfe9cc46211f08ac0a938fc7cd336-20251118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ivkwV5oE/STrAI9iGXT8kA/El3W1suq9EaS6QtN/xoc=;
	b=s3xQLcn//XsMgf5abEKMmz7S7Irn/CwkSVfRtvDcjWYsedNijIQF5J8eWoG+nMswUYvhvitZ3/GStJap4wNJJfvYq3mf2aEs5CnUZM9yPsFj6SJNHZWSCyl6i2z6CMQD+wOOkcr1Zdq1OKMsD0mrUwsskqNkuNz0SFMqwNA92Yo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:28e26c28-982c-4ffd-bd7f-8b08c0b52755,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:23840658-17e4-43d2-bf73-55337eed999a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 769dfe9cc46211f08ac0a938fc7cd336-20251118
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <johnny-cc.chang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1519730918; Tue, 18 Nov 2025 17:39:22 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 18 Nov 2025 17:39:20 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Tue, 18 Nov 2025 17:39:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rU1hW6+jGgsvCuEJ7RR6LdNUyUWpxxmrUeWS5D/mJ7LAEm02V7O3BIp9Ms/WWj+Y1IY+xu0z0M7dka/6qxCfeAmj84lUhNlxwJo8zmeYWcZrBOVM/8cKW2trFRWcwyvkWi9qfiZmTIe9SPOTs9PccHTihtxy7ziWiqqkmRt3eM6+CxSivN5opE8lJnrtsN8KIPeh97zopaoqLdKrRhWUmRc9vPOQ1CbiJRXn3y+a8cDW70IFa/w/uC6F82ntFMYefDUV8GIbQ4ZIkAsm489HpYhs8o+WADKK4FAs9CQjpCMvIDWN61MnhbGD/NaswOF35p6bV5U5PHuXIG505/i9sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivkwV5oE/STrAI9iGXT8kA/El3W1suq9EaS6QtN/xoc=;
 b=HXvwhFYOax7BpQTbwToAhY9J8VoFgdAP8AqMs3kqbJrR70zuJSWbPSSGxlAwBxubmvCTqM/zQb8sFTdgVOZqjKiTkIu9HZ8xWDgsJAHc/e/B9U4jZr/PZl9D6oArQ7UysuqZDJrFUnygNkihnj3/A5HzrRhEBlEESjkdDZNvbL0CGhUZeqcLviRkbheIAw35AeL6QUJZbBzp156XPtgTI0QjkCTbPWFmnGX8EJLNSMf0gMnPd/KuCa+5zPQ3E+bOZIq7eNjoSpw7aGY2mKsRcHpDMK7bUXL/YIWOhYBHIZ7ivHtLAdkCjiw/jprbqylUYssXgNlGaRhfpl8onbgEnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivkwV5oE/STrAI9iGXT8kA/El3W1suq9EaS6QtN/xoc=;
 b=gMq/Rk0eKe6BmxPjRzpVh8fBV/WoUHo326ANv+bsePY73VMFfUOl0JcGNDjTovHIkWgs0RijPQFwbcjfFQ4K5Qv1YdlKZklPIwYqtRs0sjBucMNpgi1LjbKlgRDYjTiKef84KT81cs1w6YAbjt7eyAd46RENBCZzBQeU8uYUN/E=
Received: from TYZPR03MB6164.apcprd03.prod.outlook.com (2603:1096:400:12f::10)
 by TYZPR03MB7639.apcprd03.prod.outlook.com (2603:1096:400:426::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.20; Tue, 18 Nov
 2025 09:39:18 +0000
Received: from TYZPR03MB6164.apcprd03.prod.outlook.com
 ([fe80::4975:7e68:a99b:d655]) by TYZPR03MB6164.apcprd03.prod.outlook.com
 ([fe80::4975:7e68:a99b:d655%5]) with mapi id 15.20.9320.018; Tue, 18 Nov 2025
 09:39:18 +0000
From: =?utf-8?B?Sm9obm55LUNDIENoYW5nICjlvLXmmYvlmIkp?=
	<Johnny-CC.Chang@mediatek.com>
To: "lukas@wunner.de" <lukas@wunner.de>
CC: Project_Global_Digits_Upstream_Group
	<Project_Global_Digits_Upstream_Group@mediatek.com>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH] PCI: Mark Nvidia GB10 to avoid bus reset
Thread-Topic: [PATCH] PCI: Mark Nvidia GB10 to avoid bus reset
Thread-Index: AQHcVHnastJoxsIJbEqLLkQpp8yUiLTwWe4AgAfbiIA=
Date: Tue, 18 Nov 2025 09:39:18 +0000
Message-ID: <39028d84844a08b8b716eb3941cc02562d21dc84.camel@mediatek.com>
References: <20251113084441.2124737-1-Johnny-CC.Chang@mediatek.com>
	 <aRWnYCI6Ax14XNJq@wunner.de>
In-Reply-To: <aRWnYCI6Ax14XNJq@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6164:EE_|TYZPR03MB7639:EE_
x-ms-office365-filtering-correlation-id: 7eb5e5a1-7b62-4fe5-873a-08de26865859
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RERhS2NBSGsvK2lxUGt3Z2QrbFNIOTlCcGlHeVdBVFNYSkc0bFN0d1dabTJa?=
 =?utf-8?B?UnRzaVJsdHJxdW1NQUY3NXpPckVhTmd2ZFlkdHRMVnNYMWxmc0NGdEZpYmFZ?=
 =?utf-8?B?OUhmWXBtb09ZWURvWW92Z1BuN3ZXeVFtKzFueU8zcTcrQzRmVmVwZnpTL1NQ?=
 =?utf-8?B?eUR6SlBWV2NRcktKcjV0ZDVyYlQ2UCtFa0dPS1pZV3ZGNEVkci9RK2VSNmEw?=
 =?utf-8?B?UmdxYUd5TW9KVWhtajZqbTJwRTlhZHFpRXhza1Y5Q3BlZmdEUm5rc0xSdW5U?=
 =?utf-8?B?OUNNVEhIdGNHUWw1NDlSbnVpUzFJUUwwakNJRGhITzVhZ0ZKRVMzRjh5c2hR?=
 =?utf-8?B?VUlzdzJ3NGdkckRsOXNrNkx2SytOREIwbnBvOWxFNU02OUpNSVZ3ZTBzSjlt?=
 =?utf-8?B?WGp0b3ZEN2hicGl6T0JOdmRqVTVKNjZIaDFEaXFidHNQNi9EU2dJRmhZTlJi?=
 =?utf-8?B?TEdSejR1MjZqdHJlamFzd3R5QTlBV1I2Z3FWakd3dnFkNVhLNUlmUFBoV2FQ?=
 =?utf-8?B?UE5WZnY3Sy9Ob3lPd1NHUUZEcFZoZTJQRzkxbmUyKzhHdFgwTlR0WjN0U2d0?=
 =?utf-8?B?ODJNbEY3a2RvQVYwQ1pWMDkrQ0RZdnVyc2pyMEJ5RlpDbG9TSHViUEtkT3ZN?=
 =?utf-8?B?Qmxid2FVeEZqcW9MSS9GcEVqVnF3RnBNbzIycWV5SUJUVjhDYTJXbHhqbURa?=
 =?utf-8?B?UmZzaGhqaFd3WUVmbkx4QWd4dThCZFZiY3pUeHFFaUNtTENIUmVMdnJvZEk3?=
 =?utf-8?B?bE96SGgrSGR5b0IwL3VaYzRKakV0MjVhb29mc2hhZUpQc2R2Z0Uvd3hLL3F3?=
 =?utf-8?B?SHo0bHNWR2QySlo4SllDOGNPOVVFREhCbkZPR2FrQ0VEQ1pHSFlJbVNNQ2J4?=
 =?utf-8?B?R2FDSkEyOE14SUxCZXp6TXRrR3VRZnJMdXZZSEh6dkdLcUZIVk9pRFRVY3Q3?=
 =?utf-8?B?VGZ4Vit0Q3dFem0zNlNJaVNEU2pFVE42cmVkdjRERWt5ZUliZFZxZ29CYi9v?=
 =?utf-8?B?bWhsVnd2RVVhS1pQMUg3MkxDS0ZBc2I4ZW4zTmFuaHNHUDFtR0MwMWppTFFa?=
 =?utf-8?B?TUtuRzN0a0t2WVUzdjAxNVJhbTQvOHpCdUlVVTFkcUZvQm9iVFhNWEU0dWFT?=
 =?utf-8?B?T3UvU2VCZGNVVFpUZFh2MzE0UUZIV29sQXJlOFhpcytiWGdrdVk5Wm5rVS92?=
 =?utf-8?B?aWNNcDBlMzFkTkdZeU9EWHIzbHJObEFkdmRJY29TUjZlc0J5bUF6T0ZjNXhV?=
 =?utf-8?B?enlvejlkc2krbVYxdTl6VVBycHNvTVZGTFU0d2R1YlFPd1Jic2YxR0R6Ri92?=
 =?utf-8?B?WndvdDRnVW4xcjlTQmg1QkxycnFiNjZzUWI4UU1XeUZKWlArb3VvR0I5V1Ba?=
 =?utf-8?B?bU9kRFpuVndDd0lXYlh6Z0hZdW1KcjN2TFJ0RjNYYytjSGJ0SW01aEVKaUdK?=
 =?utf-8?B?dFZqaThJZkJyenZSYUtXV3c1ZXloQWJzZ1NkZVRJb0UveXo0YWtkVEJXN1ZO?=
 =?utf-8?B?cWF4WEVWL3hrN2kxNVArR1Mwemh0alM0VWRxbmlaaE1rSXpTVXZaZ3Zzc3JJ?=
 =?utf-8?B?NEZHOE1jSVYzUUlSSFZUVExhcUVlUVVxYlRoK3prc1Q3dURMYkkvT1NsYTM2?=
 =?utf-8?B?a3RPTTc5TkZ4N2dpTk9BMDUyd2Z5UEhxc0hxRVlJZDg5cU5yQlB4L0JONlJG?=
 =?utf-8?B?UGk2OVlpbHRvT1VBTFJCaks0TkFzLzM1SDVReWFlRUlqK0paQmNsbWxNckdu?=
 =?utf-8?B?eittTFB6UnY3VnRtUnhyQ1A2eVlmMVVOYVM4a09NMGNWM0hza3BVMkVVUUtK?=
 =?utf-8?B?YW5ETTUvaS9Mek5VV3dpYmpreXBVUHpnbU5YdjFRcnc3Y1BCbmNlS3ZtMUNE?=
 =?utf-8?B?b2w4WXZBcEVZY3ZNemZQY00yaVBneWppQXh4WStGQkRMTXRIdExiSkJQRExq?=
 =?utf-8?B?b01vU1lHdjdwNFlZVTRNSDBVRUlwanR6TWZRRWZVTHR2N0dvcFRVeHNTMVZM?=
 =?utf-8?B?Q3c3QkhMaFpZVFl0aHhSOUlvZGFwSGFZcHVhT01UdXM3WXNKNGYzUmdUOFZv?=
 =?utf-8?Q?xhUBvF?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6164.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDAxcVJuend5Ym1kODN1VFZhdnRkR2tBTTdjeDRtZyt3dlBwbXprcVlacjMx?=
 =?utf-8?B?TkRuMUI1eEVsVzNVRTcvUG5HTWFvN1MrRkZwZUFEdzg3eEFEcFk0S1l0cHpw?=
 =?utf-8?B?eERTR0lMVUhERmp5MmpBMFhHaGNsYTYzaExXaERac2N2VlJGYjcxZko5RTZZ?=
 =?utf-8?B?Yjl3aXgwRHFnU0thT0QzcElJcEZ6MzZBRjB0MWpIT0hrK3VZYzlGNWN0NXZK?=
 =?utf-8?B?aFlBK2lZWkFRSERJL3hCd29iWC9PTUhxejNLdi9ETW5tS3JMakZad1lMd2FJ?=
 =?utf-8?B?RTlONS81TmtYc3VYbkZaZEZ1Qk5RN0hCSHlkcmxLRHNmVm56YlFLSFBib2o3?=
 =?utf-8?B?NERyay81bzJoNlBBY1o5OGpVQVlhMzJtbE5mUk1UMTBkSFFCbFl0U3dmUFlG?=
 =?utf-8?B?K2p1dlFvY21iaUZwRE1tYTlpbGdQWEpWMWZYN05kSlNRMXBlQUxTT3gyWnpi?=
 =?utf-8?B?WEYwTDFiVUMzbmp1Y2oyZHBWbFB4OERYUURNNmladGRMa1NJK1R5V0laU2dJ?=
 =?utf-8?B?RGdhSG9aTjE2ZDZwQVVScU5hdXY2ZWd1UEQweDZDeTFUenB0NUVSdUgrelZH?=
 =?utf-8?B?QUl2UDFFWjVZYmg5VEY4YURoYUpMZjFrZGpZdCtPZ0NWdko0MUtVS2I3MVJI?=
 =?utf-8?B?RGl5QTRJWUVoMUlVb2dJbVd4dE5VS0JLSld5UWx0NGMwTHptaWQyNkRlTGtQ?=
 =?utf-8?B?YWhYMndhTDU5VHRLNWRwQXlKMG9EQkorcy96TEFJaUNXekR3NkhoSUNHL2dZ?=
 =?utf-8?B?c2pQWGdocGFlVUtiRm5MZHQzd0JUYmpKVldBR0lNc0Y0Q1BpTExSQ0ZXOEtS?=
 =?utf-8?B?V0F2cGx2SDdjTWFPc3ExUktZRXVDMFRwQnB2emNWM1FkSjIzTHNZelpQNlZL?=
 =?utf-8?B?NFl5UFhFbHpCYVE4eDRvamp4ZURXL1JFakFoSHNHdjl0ZDZ3WmNRRENBTmps?=
 =?utf-8?B?WXJ1WGcvd3lmSURMU0JUclBwVDZadkYySlNhZkh2NFN5Sm9pYnlocVl2S0pt?=
 =?utf-8?B?MGdrNkZRaWdHbTd6OU5qNWdzTkExaWg2TEdIU3l4SEpYaDVobFNSTEtiV01s?=
 =?utf-8?B?ZTVpcHJUdVN6K25qa2o4YVhHRnZuMldTVFU4bGlZb3BrRm1XMHJRUGZEQWJz?=
 =?utf-8?B?YXczbmVZb1c1aktSSmJncStFYmJXZ0dNSFNlQjBTT0lOVFpXcjRmUGNqWExJ?=
 =?utf-8?B?NmhQYTVOS3JnRWs4R1dOQkNBUVNQVFU3UTFHbytFU1l0dFdySkxHK3kyQjc5?=
 =?utf-8?B?QVg0YXZuM3hIT1ltL2lzakhYQkd6ckhhdlNnRjByZUpwYWtRUWxXK3N5TXVv?=
 =?utf-8?B?bzRQdTk2V3R0MW9iVGFoWkovRmc3Wit1TzcvQitMRWFwQkRtUkdJQnFNRUdt?=
 =?utf-8?B?V0dXZlVUeWM2cnBDbXBQMHNkY3YvY0xRMTFFZ1FIMXVQQklqL2gwR2E0czVP?=
 =?utf-8?B?bnV2VHpxWkpNYXJvZ2FWR3BlNGlvYXpFbERkNkpaM1pNWFhKYlRxVmdyZ0ZC?=
 =?utf-8?B?d1o0RU5RbnJvZFJQTFZIS0orZzVwRjdpYUtlZ2hUWExzRzZMOVdUblkwRGJt?=
 =?utf-8?B?V2N4dzhIS3B4MG5TNTBwSDNXRDNMcTFFWTdta2FvdkVlbVVFbVZLQ2dUa0J6?=
 =?utf-8?B?T0xhT1pzMXJHSWZvMUJEbHlSUXJQb2p1cVlKSG1od0xBcEF5VWpkSDlpRVRS?=
 =?utf-8?B?MkwzZWExdUtabHJlOVVTTVRJSk5LQnk5enpOMGRRUUlieTNPd2ZrdlM0WTd6?=
 =?utf-8?B?UENaYlY0Ym00ck0yRFF2ZkxEa1E1eEpiWDBqMmtyN0x6WmhGUSs2QmRtZU5X?=
 =?utf-8?B?bUozOXRJQ0JHR3NDSTd6TW5DV1VGZUVTblhUWTZ6SkFRczVFL040aHJ4RUt2?=
 =?utf-8?B?cVlNWG5mbVlYTjhsQUI5c21ZbEE1bHN2cWF6OFozZFQySW4zeTVmZXFab1VB?=
 =?utf-8?B?d3N2QXVyVERrVThTdEtZUkYwUkYxdFExT0lQbVc0YitrbXByb2Q0cGIyLzZM?=
 =?utf-8?B?NVlWemVwNzFDM0RlcWtLU3hCT0I1aGxEU1dYclZUbDR2c3VDNkErTncvcHZQ?=
 =?utf-8?B?OEc1MkFDc3EzcmRhZE1lYUx6TE42T2pxbGszWDNLeUZ2eCtabHlURjZkd2hz?=
 =?utf-8?B?VnBteXcwWnc2dDkwdVdObjVFNm1WTHRKU3dsOHU5dWMxWHY0VWpWbmxyOU8r?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <914DFE9D30118F4C8A2E295BCDED1B26@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6164.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb5e5a1-7b62-4fe5-873a-08de26865859
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 09:39:18.2511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DHsoVOteZTFj/ocyTbSyO9dtif/Mw/0as93ABFCBuI7VewDyCMvYz5nWODZSyY6DowQ5R5T9Kruf11p26TaELG0WwSfWxLE07n3zQSyilTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7639

T24gVGh1LCAyMDI1LTExLTEzIGF0IDEwOjM5ICswMTAwLCBMdWthcyBXdW5uZXIgd3JvdGU6DQo+
IE9uIFRodSwgTm92IDEzLCAyMDI1IGF0IDA0OjQ0OjA2UE0gKzA4MDAsIEpvaG5ueSBDaGFuZyB3
cm90ZToNCj4gPiBOdmlkaWEgR0IxMCBQQ0llIGhvc3RzIHdpbGwgZW5jb3VudGVyIHByb2JsZW0g
b2NjYXNpb25hbGx5DQo+ID4gYWZ0ZXIgU0JSKHNlY29uZGFyeSBidXMgcmVzZXQpIGlzIGFwcGxp
ZWQuDQo+IA0KPiBDb3VsZCB5b3UgZWxhYm9yYXRlIHdoYXQga2luZHMgb2YgcHJvYmxlbXMgb2Nj
dXIsIGhvdyBvZnRlbiB0aGV5DQo+IG9jY3VyLCBldGM/DQoNClRoZXJlIGlzIGFib3V0IDEvMTAw
MCBjaGFuY2UgdGhhdCBhZnRlciBTQlIgaXMgYXBwbGllZCwgYW55IGZ1cnRoZXINCmFjY2VzcyB2
aWEgdGhpcyByb290IHBvcnQgd2lsbCBiZSBibG9ja2VkIGFuZCBtYWtlIHN5c3RlbSBjcmFzaC4g
DQoNClRoYW5rcywNCg0KSm9obm55DQo=

