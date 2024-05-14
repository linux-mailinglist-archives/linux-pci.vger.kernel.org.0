Return-Path: <linux-pci+bounces-7444-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5003A8C51B5
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 13:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B1D2828D7
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 11:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B91113AD32;
	Tue, 14 May 2024 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="ZsvvLKY3"
X-Original-To: linux-pci@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11011008.outbound.protection.outlook.com [52.101.229.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37751E495;
	Tue, 14 May 2024 11:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715684905; cv=fail; b=DedMxmNaRz1pj8QPDMOPqOP/+JFzM4IQG+IY3EfhB4sF8weWBFHmzxnU3XJnWbvUzLFQGvFu1y4yR5wVKMi8TFXGaT0BH6nneCOJ902zoYtvzPRx/hQ5VhdHkDyQVaeJ8pDe7M7Ri4fI3QobYZVJai1XK+FCJHg3vJY+Mime1Kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715684905; c=relaxed/simple;
	bh=BJS3geFSRyiDaeRW0yQfevTnjCAXzUl11KGbbpJ4o7A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=msLUsyqpgvGEs0E58WOahLSWlclwdz0JKQ4u/UudbsvP/+KUj5i3/mERoWF2uhu4baVhsMOs8aZ/RlhlsJZdsvmig+gtzHPaSBEKLJPCbbU7Yh6A5AvpGdT6Ob22cFPhRUmFKNOZuSj4MSEyg6VVBpLr+H4/H44VQqvVlpGgP2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=ZsvvLKY3; arc=fail smtp.client-ip=52.101.229.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6NdrTWPSQmmrVcqZj0nk6N5+toZ4hKzT6TYQn/vzomq38poJZkYso4iWDOzTfrPvGPiCAC6ums0aTpmDY8kHxSpk5AufyG/pOm1P0KXo9ERWmjbLSihWkrwccF1dM+SJTna2dJb/xUnqZ6vzW+LjMh3v23vrV2pqebiv0r5mJhRDvqXfD+7h38VhYGWIeFf9nF2/yTQim9m+oGQCtpFJatSpNS/Ij7GP/RTpxWWPoi8g07CugA0x792Hmjkeb/wo5n5EHGQsHA4uwjWzxOK1avAylwYHfRkoU2TsalF5xPT2g5xoc0H+48DZUwH+ArTq/16zU8qhQ03O79HVMy9Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJS3geFSRyiDaeRW0yQfevTnjCAXzUl11KGbbpJ4o7A=;
 b=YR8R7fYtVXFQoa+jPFR/f/TE40rYwCn9F72fZCltH+4inbma8AzPwVfH6DPM/zdMd8ExxYgw/5XLqvmyWGLEw1EXz1mgkFtfHF3FE/dRL/QJMnk7Wz8mXKKH9a4+s+4fJ3mavBFIXIc77jpzwVH8UpoYiC7qZEC4mYNitX6j3uC4/UHf2wVnf/5SiagIypGn2yjs/iZ5zgEMv605FYXRLVPbDlqnkxCbPIfx5h25yKh/7QT5d/DalFLh5Cej35Au9l68+LLxeoUDe+yKq1k1eW0zNiW2YASpdJ6zINB1/DIKCAUfUs/8IBDBZfCV9N7AynqGYmfBqmpjPJUuZUGSow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJS3geFSRyiDaeRW0yQfevTnjCAXzUl11KGbbpJ4o7A=;
 b=ZsvvLKY3I7K2LGs2MvN1WfqQcqFFyBMYCRK41NHLeRBebn8PIOMygGQy1ixm3/kCsxPCW9H4QDLrGSD/z5WK1oORnc/VBu0MjxVmSxwnEHzSZ3KJTSKYUeRmyjfOAzm88fjVE8apjXWOf2JcSDGmISUfSXHQ2xbb6lI/FJj3Vt8=
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com (2603:1096:400:3a7::6)
 by TYWPR01MB10322.jpnprd01.prod.outlook.com (2603:1096:400:1e6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Tue, 14 May
 2024 11:08:19 +0000
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::11c0:4ed:1ee4:d774]) by TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::11c0:4ed:1ee4:d774%5]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 11:08:19 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v7 5/7] PCI: rcar-gen4: Add .ltssm_enable() for other SoC
 support
Thread-Topic: [PATCH v7 5/7] PCI: rcar-gen4: Add .ltssm_enable() for other SoC
 support
Thread-Index: AQHajwyP0UTEDb7OV0S3rZrOCPwM6bGRzkEAgATwkZA=
Date: Tue, 14 May 2024 11:08:19 +0000
Message-ID:
 <TYCPR01MB11040708AC5609CA7752B5729D8E32@TYCPR01MB11040.jpnprd01.prod.outlook.com>
References: <20240415081135.3814373-1-yoshihiro.shimoda.uh@renesas.com>
 <20240415081135.3814373-6-yoshihiro.shimoda.uh@renesas.com>
 <20240511073812.GE6672@thinkpad>
In-Reply-To: <20240511073812.GE6672@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11040:EE_|TYWPR01MB10322:EE_
x-ms-office365-filtering-correlation-id: ef21506b-e4a6-41a2-faed-08dc74062951
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?ck9WbDVIbURYZ1UxdXpHak8xTzZyNVVyVGRHVTZtUzBmV3NoYzFMV0wrdkM5?=
 =?utf-8?B?MGY2Zm15eTRJVHdYclQ0aTRlN3RDTTByNnp1M3JzKy9hR2tOWjlaZ1BTTG44?=
 =?utf-8?B?NFhUUnNqMmJoTWVqWG9iMEZCeDdtS1VML3lmeEgvNHNiL212OEVOb0hicXh5?=
 =?utf-8?B?eWUvUVB3QytkdEN1VmVaaGZUWDU2VkVyYmpBVDBTV0dPYmZ4ZXh3Q3hSQWhq?=
 =?utf-8?B?NHFNTXlVelJXamNZK0tkdjR1ZC8xZHFtNHVPeVVWbmVRM2FXOGhkOGI2aVFy?=
 =?utf-8?B?TDZoM3lPV0FBYU03TFErK3FvRnpQY05LcjFiYXRVNkt5ZjdOeVlpQVp2aVFW?=
 =?utf-8?B?eUROMGdCVlJZWUxDZ3E3aFBoSFJyZUd2UjRRUHhrT1BNR0dCblpxM0dXdGhG?=
 =?utf-8?B?VEpzaG16eFkvWXNUVVNQWG54UnFWc1hJaEdFTFRYa3d4a1lrNTR1b0FTMDFl?=
 =?utf-8?B?OTRCeTdiTWljQ2oyYkxUQ3BoWmVkd0ExTjFCU2YvZzlBVmsrYmMzK0FPSmlC?=
 =?utf-8?B?UXphNk9sWU5hR2NtSUFSa0Y4SXl4Qm81L0RmdUJzNEJkK2RJRmhUNzYxTFRU?=
 =?utf-8?B?OFo1UWtVUTNoWUxBVzM5ZDZNMEE1RCszUHlGY0s5dGp6MjJuNGMwSmFDODZD?=
 =?utf-8?B?ejRDdi8yOGNkTFZDVExHbHNNaXM3SEs3N3RtVjFpK1RKZWdaU0xhd3NYVFJM?=
 =?utf-8?B?WFRGYXZqS3EyRlg0KzBiaDRiQllDazZMT2RFOWl5SjJpd3BqYmdFSkRQT3o5?=
 =?utf-8?B?T1lFekJhOTN5a2ZoS3FtV01RV2UxTUg2SmEzU1BLeEF1TVlXTEV6OW9ZYmkv?=
 =?utf-8?B?bm1lN1V2K2JHeGJ2TEw4RCtxT3BncTBDVjR6aHZtcUdBbWx1NU5LVGpWazRY?=
 =?utf-8?B?d2FBTlpNOEYvZmRHNlBiTnJwaW54YTdLUjRhbms5Yjhod25TZXVhU1hZUFZj?=
 =?utf-8?B?bW9MaENWVUxpNTJNMVJmc1lVTGFRUHIxRHFydEIyUnc3OXpQVDlvM3ZTaXJ6?=
 =?utf-8?B?eDA2bGFXNlowYWc5UHdDVmZvZCtOWit6cFdjODBIWDU1b1FzTzJMUU9Yc2xu?=
 =?utf-8?B?VkVMMjdqMWRxSXNEYU5VMnA3SExGcWZFSTZ1NytkNFE4VHJXL2Z1OVRQWEVO?=
 =?utf-8?B?SURUTVV5dmtpN0RQa3VUTGZGZlBUelBjOTZTdmppV1Y1QWJEaVZHNlp0N0tM?=
 =?utf-8?B?OGxuZlZkSE1kVDUxSUJYYTdvNUR1T2lra00xRmQ4c0ZmYkh0L3Q1ZjczWTcr?=
 =?utf-8?B?RCtFRjhpMUlLaHU4RmdyN1dQaVNPVmZyV1NpeGZIeGZFWTJFTkh6S0F6QUEx?=
 =?utf-8?B?cFBCVkpZSnRkamYyWFJNM1BUWVFVRjJiREFVUXJWRDB3aGdEVld2RmRuVk15?=
 =?utf-8?B?aGRLT0V2c2lCMHZXSm5uSW13RWE0cElmSXhJd0tnZHBFNERlbjlzN3J1WVVB?=
 =?utf-8?B?bkV3OU9PRzZ5cmc5OURmVWRab0FuVW91RVNkWW5nQVdpc1p0allrMWxwcDcy?=
 =?utf-8?B?ZTFjMUNZQkdPSzVLdUdTNk1XZ3BzTmdOeGdVa2RibVJQV3kvSkFETE1xMlRJ?=
 =?utf-8?B?MklpenRTeUdjRkRTQmRzVDNWZytPNmlUL1pXNzl2L29Fd05kT1UzbGh6eVlE?=
 =?utf-8?B?NStYVGNTUnRiV0Jpa0pkeHViNWdkSitVMXV3emF6dksvTERGRUkwTGhBa0NC?=
 =?utf-8?B?RVNPVWxsNndmTGZnSWs1OFgva0ZnYXdlNG1UamJZV3JzRG5NZGRFK0JFVXJ5?=
 =?utf-8?B?NW14STJrYm5UTklCQlhrMFh0YkZqUmQzR3lMWGNkWnVSSjRlUDVpL3JxazZR?=
 =?utf-8?B?c1lSWWpyakx2ZlZUVmMwQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11040.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dEQ3anNuUE44MVFXaXdoY1FWT3RKWERKcjdWcEk1NS8zZmFSZlBBU1IvUGtS?=
 =?utf-8?B?ODFwQXkrMEVPYXZKYmJvZjVQbzNaN0dmeEh3YW8rNm5EaGdabzR5NklUNUR3?=
 =?utf-8?B?RnNXelk1eEVHOU50NGdpYkNJKzM5L1dmSEk1Zkl1K3htclRVS0NreXdsOFBJ?=
 =?utf-8?B?Nm5vMW9lRTk5R1dFRThVR1Evc055RGV6OVRWWlBvY244NE9rV0hOc1NVZ1J6?=
 =?utf-8?B?Sng4THlnNnpzQ2hRdXVkcndVaVhjdGRFQXMvcHAvWWRMNjl0OGVwTkxHcVZJ?=
 =?utf-8?B?Y3p0TkU5V2t2ejk3WktNQTRuVkJGSlB0QURtVU1MVTI5bjc4cHlSTElHc2ZB?=
 =?utf-8?B?VVNvY0Qra0FMMUxuY25STmVERGdpcFRaMUJETjVoaDI4VkYyNlVFejhmelJo?=
 =?utf-8?B?dTJYeE51elpmazZRdmw0ckJGeUVQbjJpSjNhOVBZSG1wcXZyaUg2V25GQWJ4?=
 =?utf-8?B?OFRISHpWUThEVktPaTBIVTlIYnNXSkZpcEU4NlprcGJyWFF0aklSZFU3VWhM?=
 =?utf-8?B?NHU3eXh5S2pxUTV5Q1l4M1RUZTBCaWpZcTQxejBTTGhET0g1dTE1SE9JQ3B6?=
 =?utf-8?B?YkRocE4rNk5XRjgxUUlCbUNSN0FjSWlzVStNdGtWT0JXMW0zd1Y1M3haRWsw?=
 =?utf-8?B?SHVWZVZmNE1FYzVJN1FuZjhnZ0xZSzVBMVo0anJFczhVOFJRaVVyTno3dFd2?=
 =?utf-8?B?VTBhTHpvNCs3U0NNQmJBRGV5NWphNzI5dzAzZzl2QlJyTk9waERNeEFjZW8y?=
 =?utf-8?B?ZkRldHJZelljRFFYOWNtVkxmQUpnQ1d0ZXhaWEVEK3g2WGxhSFdVam83cFh4?=
 =?utf-8?B?dUtKVEI3TGhDUjNkOTBjbkFOUE9GU2hncC9MVmIxdXFxeW92V3cvQVJCUUgx?=
 =?utf-8?B?M1NPUmlQSUt1elFnY3hWOXRYdS9OWFFQL0I1Qkl1OTJRTzhsb2RyOTdrUXdj?=
 =?utf-8?B?bWR2MmtoU2ZHSUZhdzlqREVUcERrb1czalZCWC9kNWdtalQ4ZjZiaVRNazB6?=
 =?utf-8?B?dHMwQWltd1JDck5pT2g5TDJYaTNrbk1XRVZPVzR5TXljcEI1QXpIVHRhdTZP?=
 =?utf-8?B?Q0I3eG9ZamVIbG1MbzVtWm1zZ1BIRUdpeklHdXoxenRNZDc3TitMaGZFT3FP?=
 =?utf-8?B?WFJCVjlEa2dNU0F4RVN0bzZOejdQL0RsUjhya3dxcnN5R0o4anB0ZGtmVUs3?=
 =?utf-8?B?VTdqS3RPbE85VGdLaURyRDVla2tnaEJpaCtqK0g3U25oRmV6NUR0eVpYbjl1?=
 =?utf-8?B?dGczczJLU2lkeWt3Z2YzOVBkZUZ2Y0xPTW5reFpsTDZUWFJRbHNSSDVHZ25h?=
 =?utf-8?B?RW03Uy8yZVVrcmJRRk53M21GSHlsVzlCUi94eDdQaFBaTWViNkRUZVZUQk9M?=
 =?utf-8?B?d3FVZ2pDTHUrb0FTN2phNzVwa29tWTlOK2dUNXU4UW5TQmU1WXE2ZDhMQXRr?=
 =?utf-8?B?emxvWWRWMHZRS0VRR2hVWm43WURUTzBzblRvTjdsRWMvekdoSXNLUkVCZnR4?=
 =?utf-8?B?VllFZ05tWlhCOEZwb0kwdXJ6NHFkK1RBaFUveEtvZ1IyQjlMNlpUczY5a2w2?=
 =?utf-8?B?V0QwRUlHOWpCTzhKZ3RtYXJycFpLOVlrUTN6WkNFb1hhSEVGODRiY1hPYlFR?=
 =?utf-8?B?Q1hpMTFWcVU1TW9VZzlnalkzVGI3b1h4aXZUSTJOd29ZQnU4bGRCSVBJTml0?=
 =?utf-8?B?OHNES0FweFprRjdUcENIejR4ZjRsbVpkdXU5SkZYWlVHTU1JaWNGZFNxY1ox?=
 =?utf-8?B?Q3dTbVMzU3p5WjZkY1Zkbng0MW03eWJnYVdLQWVWTHh5TGMxVTdMcWZkK1V1?=
 =?utf-8?B?WldQa3NEOTk2VFcwV0IxbkJlVU84QjNtVjBCQjRHNVkrMWJsWEhTWW44bWNh?=
 =?utf-8?B?S0Q1MVJyaThYak4xMXgyVEdnU09NdExNS1RJTVlxcHN4Sm5kWmVNZVZGTmph?=
 =?utf-8?B?a0JiNTQrNlJ3QzhxSng0VHFPUkVWeTdkUmgycGx3S3FrU3QyQ2xBZkFUTTh5?=
 =?utf-8?B?UkhMdWdsSXR0dDRaWVQxaGt3bERjeFF0amhkTGppK3hNTllGUXloYS9NUWQ4?=
 =?utf-8?B?R3UyZ1FrMmo5Q1EyNlc4alZGcGg5enNaTEx1YWExdThiWWM4eVJlZHg0dG0x?=
 =?utf-8?B?NEQ1YlVNN05YMkRBUnQrRjE0NklhNnNQMjR0ZlloVXYxYmZmem1BdGw5WjFq?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11040.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef21506b-e4a6-41a2-faed-08dc74062951
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 11:08:19.1544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0QoYlSYEIMKnOyyUiN/P2JpX1OSe3ZPWAcE/ZZumJjpxn+N8san1F3XK0wNCaGjmCN5T6dTnprpBvuACnpcUcJUHOxBSxcyv3IaBqFToBPGhwOiwkYtQpXiJNJ9GfZ4B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10322

SGkgTWFuaXZhbm5hbiwNCg0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6IFNh
dHVyZGF5LCBNYXkgMTEsIDIwMjQgNDozOCBQTQ0KPiANCj4gUENJOiByY2FyLWdlbjQ6IE1vdmUg
TFRTU00gaGFuZGxpbmcgdG8gbHRzc21fY29udHJvbCgpIGNhbGxiYWNrDQo+IA0KPiBPbiBNb24s
IEFwciAxNSwgMjAyNCBhdCAwNToxMTozM1BNICswOTAwLCBZb3NoaWhpcm8gU2hpbW9kYSB3cm90
ZToNCj4gPiBUaGlzIGRyaXZlciBjYW4gcmV1c2Ugb3RoZXIgUi1DYXIgR2VuNCBTb0NzIHN1cHBv
cnQgbGlrZSByOGE3NzlnMCBhbmQNCj4gPiByOGE3NzloMC4gSG93ZXZlciwgcjhhNzc5ZzAgYW5k
IHI4YTc3OWgwIHJlcXVpcmUgb3RoZXIgaW5pdGlhbGl6aW5nDQo+ID4gc2V0dGluZ3MgdGhhdCBk
aWZmZXIgdGhhbiByOGE3NzlmMC4gU28sIGFkZCBhIG5ldyBmdW5jdGlvbiBwb2ludGVyDQo+ID4g
Lmx0c3NtX2VuYWJsZSgpIGZvciBpdC4NCj4gPg0KPiA+IEFmdGVyIGFwcGxpZWQgdGhpcyBwYXRj
aCwgcHJvYmluZyBTb0NzIGJ5IHJjYXJfZ2VuNF9wY2llX29mX21hdGNoW10NCj4gPiB3aWxsIGJl
IGNoYW5nZWQgbGlrZSBiZWxvdzoNCj4gPg0KPiA+IC0gcjhhNzc5ZjAgYXMgInJlbmVzYXMscjhh
Nzc5ZjAtcGNpZSIgYW5kICJyZW5lc2FzLHI4YTc3OWYwLXBjaWUtZXAiDQo+ID4NCj4gPiBFeGlz
dGluZyBkdHMgZmlsZXMgaGF2ZSB0aGUgY29tcGF0aWJsZSBhYm92ZS4gU28sIG5vIGJlaGF2aW9y
IGNoYW5nZXMuDQo+ID4NCj4gDQo+IEhvdyBhYm91dDoNCj4gDQo+IFNlcXVlbmNlIGZvciBjb250
cm9sbGluZyB0aGUgTFRTU00gc3RhdGUgbWFjaGluZSBpcyBnb2luZyB0byBjaGFuZ2UgZm9yIFNv
Q3MNCj4gbGlrZSByOGE3NzlmMC4gU28gbGV0J3MgbW92ZSB0aGUgTFRTU00gY29kZSB0byBhIG5l
dyBjYWxsYmFjayBsdHNzbV9jb250cm9sKCkNCj4gYW5kIHBvcHVsYXRlIGl0IGZvciBlYWNoIFNv
Q3MuDQo+IA0KPiBUaGlzIGFsc28gd2FycmFudHMgdGhlIGFkZGl0aW9uIG9mIG5ldyBjb21wYXRp
YmxlcyBmb3IgcjhhNzc5ZzAgYW5kIHI4YTc3OWgwLg0KPiBCdXQgc2luY2UgdGhleSBhcmUgYWxy
ZWFkeSBwYXJ0IG9mIHRoZSBEVCBiaW5kaW5nLCBpdCB3b24ndCBtYWtlIGFueSBkaWZmZXJlbmNl
Lg0KDQpUaGFuayB5b3UgZm9yIHN1Z2dlc3Rpb24uIEl0IGdvb2QgdG8gbWUuIEknbGwgdXNlIHRo
aXMgZGVzY3JpcHRpb24uDQoNCj4gPiBTaWduZWQtb2ZmLWJ5OiBZb3NoaWhpcm8gU2hpbW9kYSA8
eW9zaGloaXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcmNhci1nZW40LmMgfCA0MSArKysrKysrKysrKysrKysr
KystLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25z
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
ZS1yY2FyLWdlbjQuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcmNhci1nZW40
LmMNCj4gPiBpbmRleCAzZGEwYTg0NGUxYjYuLjk4MGE5MTY5MzNkNiAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXJjYXItZ2VuNC5jDQo+ID4gKysrIGIv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1yY2FyLWdlbjQuYw0KPiA+IEBAIC00OCw3
ICs0OCw5IEBADQo+ID4gICNkZWZpbmUgUkNBUl9HRU40X1BDSUVfRVBfRlVOQ19EQklfT0ZGU0VU
CTB4MTAwMA0KPiA+ICAjZGVmaW5lIFJDQVJfR0VONF9QQ0lFX0VQX0ZVTkNfREJJMl9PRkZTRVQJ
MHg4MDANCj4gPg0KPiA+ICtzdHJ1Y3QgcmNhcl9nZW40X3BjaWU7DQo+ID4gIHN0cnVjdCByY2Fy
X2dlbjRfcGNpZV9kcnZkYXRhIHsNCj4gPiArCWludCAoKmx0c3NtX2VuYWJsZSkoc3RydWN0IHJj
YXJfZ2VuNF9wY2llICpyY2FyKTsNCj4gDQo+IGludCAoKmx0c3NtX2NvbnRyb2wpKHN0cnVjdCBy
Y2FyX2dlbjRfcGNpZSAqcmNhciwgYm9vbCBlbmFibGUpOw0KDQpJIGdvdCBpdC4NCg0KPiA+ICAJ
ZW51bSBkd19wY2llX2RldmljZV9tb2RlIG1vZGU7DQo+ID4gIH07DQo+ID4NCj4gPiBAQCAtNjEs
OCArNjMsOCBAQCBzdHJ1Y3QgcmNhcl9nZW40X3BjaWUgew0KPiA+ICAjZGVmaW5lIHRvX3JjYXJf
Z2VuNF9wY2llKF9kdykJY29udGFpbmVyX29mKF9kdywgc3RydWN0IHJjYXJfZ2VuNF9wY2llLCBk
dykNCj4gPg0KPiA+ICAvKiBDb21tb24gKi8NCj4gPiAtc3RhdGljIHZvaWQgcmNhcl9nZW40X3Bj
aWVfbHRzc21fZW5hYmxlKHN0cnVjdCByY2FyX2dlbjRfcGNpZSAqcmNhciwNCj4gPiAtCQkJCQli
b29sIGVuYWJsZSkNCj4gPiArc3RhdGljIHZvaWQgcmNhcl9nZW40X3BjaWVfbHRzc21fY29udHJv
bChzdHJ1Y3QgcmNhcl9nZW40X3BjaWUgKnJjYXIsDQo+ID4gKwkJCQkJIGJvb2wgZW5hYmxlKQ0K
PiA+ICB7DQo+ID4gIAl1MzIgdmFsOw0KPiA+DQo+ID4gQEAgLTEyNyw5ICsxMjksMTMgQEAgc3Rh
dGljIGludCByY2FyX2dlbjRfcGNpZV9zcGVlZF9jaGFuZ2Uoc3RydWN0IGR3X3BjaWUgKmR3KQ0K
PiA+ICBzdGF0aWMgaW50IHJjYXJfZ2VuNF9wY2llX3N0YXJ0X2xpbmsoc3RydWN0IGR3X3BjaWUg
KmR3KQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgcmNhcl9nZW40X3BjaWUgKnJjYXIgPSB0b19yY2Fy
X2dlbjRfcGNpZShkdyk7DQo+ID4gLQlpbnQgaSwgY2hhbmdlczsNCj4gPiArCWludCBpLCBjaGFu
Z2VzLCByZXQ7DQo+ID4NCj4gPiAtCXJjYXJfZ2VuNF9wY2llX2x0c3NtX2VuYWJsZShyY2FyLCB0
cnVlKTsNCj4gPiArCWlmIChyY2FyLT5kcnZkYXRhLT5sdHNzbV9lbmFibGUpIHsNCj4gPiArCQly
ZXQgPSByY2FyLT5kcnZkYXRhLT5sdHNzbV9lbmFibGUocmNhcik7DQo+ID4gKwkJaWYgKHJldCkN
Cj4gPiArCQkJcmV0dXJuIHJldDsNCj4gPiArCX0NCj4gPg0KPiA+ICAJLyoNCj4gPiAgCSAqIFJl
cXVpcmUgZGlyZWN0IHNwZWVkIGNoYW5nZSB3aXRoIHJldHJ5aW5nIGhlcmUgaWYgdGhlIGxpbmtf
Z2VuIGlzDQo+ID4gQEAgLTE1Nyw3ICsxNjMsNyBAQCBzdGF0aWMgdm9pZCByY2FyX2dlbjRfcGNp
ZV9zdG9wX2xpbmsoc3RydWN0IGR3X3BjaWUgKmR3KQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgcmNh
cl9nZW40X3BjaWUgKnJjYXIgPSB0b19yY2FyX2dlbjRfcGNpZShkdyk7DQo+ID4NCj4gPiAtCXJj
YXJfZ2VuNF9wY2llX2x0c3NtX2VuYWJsZShyY2FyLCBmYWxzZSk7DQo+ID4gKwlyY2FyX2dlbjRf
cGNpZV9sdHNzbV9jb250cm9sKHJjYXIsIGZhbHNlKTsNCj4gDQo+IFlvdSBzaG91bGQgdXNlIHRo
ZSBjYWxsYmFjayBoZXJlIGFzIGxpa2UgYWJvdmUuDQoNCkkgZ290IGl0LiBKRllJLCB0aGUgY3Vy
cmVudCBwYXRjaCB1c2VkIHJjYXJfZ2VuNF9wY2llX2x0c3NtX2NvbnRyb2wocmNhciwgZmFsc2Up
IGZvcg0KYm90aCByOGE3NzlmMCBhbmQgcjhhNzc5ZzAuIFNvLCBJJ2xsIG1vZGlmeSB0aGUgcmNh
cl9nZW40X3BjaWVfbHRzc21fZW5hYmxlKCkgZm9yIGNhc2Ugb2YgZmFsc2UuDQoNCj4gPiAgfQ0K
PiA+DQo+ID4gIHN0YXRpYyBpbnQgcmNhcl9nZW40X3BjaWVfY29tbW9uX2luaXQoc3RydWN0IHJj
YXJfZ2VuNF9wY2llICpyY2FyKQ0KPiA+IEBAIC01MDQsNiArNTEwLDIzIEBAIHN0YXRpYyB2b2lk
IHJjYXJfZ2VuNF9wY2llX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+
ICAJcmNhcl9nZW40X3BjaWVfdW5wcmVwYXJlKHJjYXIpOw0KPiA+ICB9DQo+ID4NCj4gPiArc3Rh
dGljIGludCByOGE3NzlmMF9wY2llX2x0c3NtX2VuYWJsZShzdHJ1Y3QgcmNhcl9nZW40X3BjaWUg
KnJjYXIpDQo+ID4gK3sNCj4gPiArCXJjYXJfZ2VuNF9wY2llX2x0c3NtX2NvbnRyb2wocmNhciwg
dHJ1ZSk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRp
YyBzdHJ1Y3QgcmNhcl9nZW40X3BjaWVfZHJ2ZGF0YSBkcnZkYXRhX3I4YTc3OWYwX3BjaWUgPSB7
DQo+ID4gKwkubHRzc21fZW5hYmxlID0gcjhhNzc5ZjBfcGNpZV9sdHNzbV9lbmFibGUsDQo+IA0K
PiBKdXN0IHBhc3MgcmNhcl9nZW40X3BjaWVfbHRzc21fY29udHJvbCgpIGRpcmVjdGx5Lg0KDQpJ
IGdvdCBpdC4NCg0KQmVzdCByZWdhcmRzLA0KWW9zaGloaXJvIFNoaW1vZGENCg0KPiAtIE1hbmkN
Cj4gDQo+IC0tDQo+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/g
rrXgrq7gr40NCg==

