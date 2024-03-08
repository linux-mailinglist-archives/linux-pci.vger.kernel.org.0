Return-Path: <linux-pci+bounces-4661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415DE876370
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 12:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5622823DE
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 11:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A1B5644E;
	Fri,  8 Mar 2024 11:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="WktgQtx7"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2046.outbound.protection.outlook.com [40.107.113.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A500756465;
	Fri,  8 Mar 2024 11:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709898107; cv=fail; b=OyO/G3klrB+1I3sWMPaFewegTYSl/yxfFl3/zkXn8ZvKuVSG6zzbKyRB4w1OObcCfVg0PrEHaCNLjpTqiq9DwZ4FGB067FjvcW1cmfDeS9sTGp2zRqWLqRqw9OBop7Pk7P1kUXDhlkCUN928DfuYm5s7GNz5bkTzj8le04Dw48o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709898107; c=relaxed/simple;
	bh=OL6jZ5Z6UjGPI2I1j2nLQRvjUIxi7KbWVG+xHgJ3rOA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fts2YmE6XOElBG1/atA2VETeYam6CwQ/ktTHSebKBp6kWwxvL6qlh1Fc7yiCc1j97wA0rIx3T1G7OpXNBJLiLilzv5hUcltiJXbsGMEe6z0egtun7iwBaIDUTiz6v8PVLflO9Bo9E4HgmuLsuFDTca9k/2fxrY2Z0G3ZIT6EBy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=WktgQtx7; arc=fail smtp.client-ip=40.107.113.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBIASYBQC2Vi+aT+8N4ZRHHX8rsDcP+WzfUJJ/jklXDNVfZ/3HY23smh2mwzQ+qV5qZrWAkxeb/fB26sLPxLVC1Kk+YSIuZoKpELWwDA6SnALrk2sRt0LuPjzIxpVdX3ceT/q6/gZJ9a7nrnDwdqNhF2hXtjD6t7qJ3FrW+OzUsTtViv+5SVlnYnc+65D/AHHFvPRFErSKu+Wb+no4gWjAs+hn/cbYR3I3T3GRBJrsRXCJJR0naWx6tMPs+JJGOVYHv8wNmqpg29UodWoi+MijfZnWus4NrH//gR09AivZg1zstDYcdg+NwrCjpmohcMG39K6fdNooP9rbRkg1ZL5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OL6jZ5Z6UjGPI2I1j2nLQRvjUIxi7KbWVG+xHgJ3rOA=;
 b=JuDVcIzmJeLlBe/3j/B9ZIwjrbklGfkuWN/eClOrUmYjteyRg5JD8ZLX8TSPVgKOa2ibmPzna7u62rJGxXyF1dmW/5girj1dA71XlhLbK3x4tRKOkpD8sV9XATaXQEo1HtiP0Vxa79Z6GoryqVZHI7DGW+73qJBBsoCn5vc43C52DyYIc7fMJAsDk3nSOWHyu3p3r6Lcdpfh584pqipOiGUR8ONFA6wnvTbtkOpQu0vawvNSHzHWL9tuD1W99fFAG77FxRKgvozD3C9njkEkJabcN0U8zl98ACMdByLdu1aum0dfxBjM5+Cn+YFChXVqt9G9GsSN86xLMau4i1jWdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OL6jZ5Z6UjGPI2I1j2nLQRvjUIxi7KbWVG+xHgJ3rOA=;
 b=WktgQtx7CtBNloByCttEV8GsLNXlSYlc7e1SRyQbfMT/AWgoZV8/TBMjf529W4caQfvtzITeKXTAoCNvrx2X7Hl+BZsbCKcmMJFlKI5/pcMv7G7M6IwxH7L0Q7jIly8TdvzNoqLQOuLSWiA8TpPqpUcYqvItNeJeKWEnWl1fiMM=
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com (2603:1096:400:3a7::6)
 by TYWPR01MB10774.jpnprd01.prod.outlook.com (2603:1096:400:2a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 11:41:40 +0000
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::f9d2:106:9dc3:224f]) by TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::f9d2:106:9dc3:224f%3]) with mapi id 15.20.7362.029; Fri, 8 Mar 2024
 11:41:40 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jingoo Han
	<jingoohan1@gmail.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Marek Vasut
	<marek.vasut+renesas@gmail.com>, Kishon Vijay Abraham I <kishon@kernel.org>
CC: Serge Semin <fancer.lancer@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "mhi@lists.linux.dev" <mhi@lists.linux.dev>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, Frank Li <Frank.Li@nxp.com>
Subject: RE: [PATCH v4 1/5] PCI: dwc: Refactor dw_pcie_edma_find_chip() API
Thread-Topic: [PATCH v4 1/5] PCI: dwc: Refactor dw_pcie_edma_find_chip() API
Thread-Index: AQHab7Atmh7ui1YNvkGFUQQdigscobEttr5A
Date: Fri, 8 Mar 2024 11:41:40 +0000
Message-ID:
 <TYCPR01MB110408BECBB6E74F5BC26E589D8272@TYCPR01MB11040.jpnprd01.prod.outlook.com>
References: <20240306-dw-hdma-v4-0-9fed506e95be@linaro.org>
 <20240306-dw-hdma-v4-1-9fed506e95be@linaro.org>
In-Reply-To: <20240306-dw-hdma-v4-1-9fed506e95be@linaro.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11040:EE_|TYWPR01MB10774:EE_
x-ms-office365-filtering-correlation-id: d9ea5c2e-e7e1-48af-f75e-08dc3f64b8a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 sv/14kbcqmXi2T+37JOk8gsmqB+e0vTS6gbKpN4PpvvCqeIcZaX3vI7HGnWuxbkcVtBLZCskHaCIMZ00kxESEG4QxHdezGUY03DjcNTFGHaDQe5546B5ecTKJ7zBIHUrOF5Tg8qLqGUfVJ/xYz/OyJ67LY0+C1HJPfQyJYHEHzRCRBRaW4IPJcfevFH1tAenr4UEgVDEIlP77xi9QLmAtnlrDCO5Hoq9j/+19AoGnS59BW2RoUyTb9ptFA9+19RXBihqz+AAjtiVfOFF5eF4iLifmNcFBxigClPZaD6aXCwcYNTqKerFeT88ut3bJYthQ7RcFyVI4ZjwBuBZWPkgOhNSIXcKNlVAM6oV1cRENw/Nq80g3NXaBvmr9ZTqWREv78Z1fKKUvgYjKZW+cCG0xt3+W0LVWIeaIzbFzg9ytILDpfJIo/QwCU341fOWzW8ibUE8WiCyGjWGioiRkfqrZb+gF3iBZkiiVZgaMc8Yd3aUMvMOJIHt34S5inZECVdDAonV+CzgxSQ0wzI3ZAA6NabBI5JtqTkCygmZrg64dH0mnsYKWit3SOEtDjWX1aK46yL9065NolInkolGYy5GhVXaapR91Ed/AeydcVKWe0wWImQ4YaIHCPXA9XSw4e4QRMp8OQJeMG/gAp7FN6Pmx7vBVa9g6Qt6O1ryufKk5QPntqowYSc+cboaAj4Q8v4/oLfAGVJArZZrN5spszqBpA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11040.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N3ZXb2JLZllUN1Z6Zng0TThJd251RGt5SjBHSk5nMHFQSXIwTkRrZVFMNHAy?=
 =?utf-8?B?RG1FTW9laVQ3cnVpclRmTTZVVWc2cWJMb3k5NmFWYjJFV2N4aXRmc3hJZWE0?=
 =?utf-8?B?U0gzK1dZSklTVExaWnF3Q2NseDljYUdzckpZTGRxemlTZ01pYnR2VVhhTVJC?=
 =?utf-8?B?Zml2eCttZ3k4bmROSEx3L05oQVMxbTVnb3hmbE5HZVVUMEJIOGhUcEJxekQ4?=
 =?utf-8?B?eCtMWlBtU011dUUxUnpUUVVxMjJhZkpHOE56dG1hOXJaeGpITVNjckdoV3BG?=
 =?utf-8?B?bERRRjlRVkRXRzBsejJocHkyZzdmNThISWZFVXBzS0s5NE05U0tLbWZiVVhz?=
 =?utf-8?B?aVJMWU1vY3dHNjd2YUtLZ2tVZ0VhVDQ1QlNua0MvNDlIUjhld25QSklvdEwx?=
 =?utf-8?B?Z0NUd3ZjUzg4aVJtOEFmcko3VGoyL2tYNjU3eGlCYjBLeTRRbW9QT2RGYWUv?=
 =?utf-8?B?dERwWW9zajhMSmZVNkNrR1QzOVRzeTNvQlJKS0hFd1BqV0gxOGk0WHJLSzV3?=
 =?utf-8?B?aWNiUWJaaFlLRG8zdURockd3Z2t0ZkpLT20weEN4T2dUMGNiRGlQNTBxWnR6?=
 =?utf-8?B?SDJaNndnNGtXbExQTHJHS1VRTHJtK1drcXZCcm5PUjFaYy95M1E1WGNLUXAr?=
 =?utf-8?B?bnQxelZqVDQ1VncrUjRTWGFHQ1h5c1FQdHMyS1JwYk8xKzNCZCtHUEtPZWhM?=
 =?utf-8?B?WDR3cWhQMG01YURydVdxZmpQc1M0SjhFeGFLd2haY3plTzJvbDhPWk5pMDlp?=
 =?utf-8?B?UU5ubFcvWThTVUo2ZVQ0VHMrV1JJei9xRkZqMTdYaG1QclFXSHVnYTFtbHhy?=
 =?utf-8?B?MEVaVGFpVldIL0o5bG5pVjVMNjZjWWxxSEpwMWVNMjkxSUN2c0U3UWY1TG1u?=
 =?utf-8?B?eU45WGdJOUd2OUZFR0kyVzRsNG1GUjkzRHFrVkYzK0g4Z2l6eVBOR0FRUERM?=
 =?utf-8?B?U0JWRTh0VndGM0dPRFlQMzlzVGdQMGRuOU1zLy9ZeUFuTCt5SkVSb1NiNTMr?=
 =?utf-8?B?MEdPZndQbVpnWUorK21UdTZpZFdOcnRxd1htTGtqK0luam9QdC9aTDNNRHcz?=
 =?utf-8?B?N0wrV2FNeDREZmhCemF5TTNENCtESytuYzdlNVVXL2c3bXJ5aWpYcGxtYWtB?=
 =?utf-8?B?blpJY0IwbEI3UWxYQ1J4SWxjUUNXb1JnaGVIc2JhbnZpYU1FU2xldFZVVmQ0?=
 =?utf-8?B?TTR4elFCYW54enNycWpoRTRaZ1M5K1YrNFFPYU8ycXJhZ2pNQ0pLQzlBNVhO?=
 =?utf-8?B?cTF3SE4xOHFZL3FSV2dqdE1HdDlJby9CSzBYK01CLzdsME9IczQrNFpCdDZX?=
 =?utf-8?B?L2lpcXpOVzkyRWtEM2ZiZmtOU1NxalI3QzlPWFNLNm8yTC9ESENQdjF0WGNj?=
 =?utf-8?B?U0FOTVkxcHRrSEI4KzFPZ1NWWThZejl6d2dNUFlsR2VyRDJEbUFzVld1bi9N?=
 =?utf-8?B?T3B3Yy9wSDB5elpwYUVLbXZQUGw0VThnVmJmODRZRS9GN2phNnkveG93cU1U?=
 =?utf-8?B?dkkzMnFKV0YzUDNKS0VjVDRHQWh4SHNha3Y1cVVxMk05RzJDakQzR1MrMU5L?=
 =?utf-8?B?MDdlWlZkV2hKSGZRQjR0QTlvV0YvVURISUxseVdsdlp4VFA2MlBOVGlWYnR1?=
 =?utf-8?B?cEFqZUVzaFNWTnpkcnBxZFk0VGoxSVJ0UFRsQ3B6UDVXcjUwVFBsaEMreTNy?=
 =?utf-8?B?WDhudFVKUnhKcUFSeGFxSVVjN0p5Z2NyZWNieTl6cWYySDdtekwwWWZteHc3?=
 =?utf-8?B?TlM4aWxoNEdTUVIyNDJXRzdiUk9oSU5sQytaZVE1NG5QWFhUcDNvL3FqNDE2?=
 =?utf-8?B?QlBrSWdneTdMV0RUNnAzYUNmZWh3a2dVNUJNOTBMYVNCQU5yNWNBOGQ5KzRo?=
 =?utf-8?B?YUV1eWNVQWRsTjYrVnFuZ2FnMDdoOHJyeGlKL2Q0eTNLUEV4Qkdya2dmZzJs?=
 =?utf-8?B?N1ZoWlphbE91N0lCOUd4SVdkZHI3ZVQ5ZFFleVloRnJjQjJrUUxwUlJuNENR?=
 =?utf-8?B?WUU3V0s0Y2N0V0NQQmt3TzBKaXJPQ0F4TkswNXlxQkdpNGJDdW5VNzAyRWts?=
 =?utf-8?B?djZpU04yUWsvVVFpNEhKdnZFV3h1bXEwM1hhSDBkSDlSYjcvMG8wQmZ0VUdQ?=
 =?utf-8?B?dElhNm1NbE9FZGFTMldYZXlvQU1KZzFjZVNzeDJ2UlJOUmdiQmlDTTFDL0xL?=
 =?utf-8?B?RFE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ea5c2e-e7e1-48af-f75e-08dc3f64b8a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 11:41:40.6471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yMf0mZTH1QPWLdU26ft8FawXjEae++s6I9yXg8xcGOe3BirDmJnRD/UE/rccbAi0kMOe37DrpPICYqhpOGYnxY5EW6oZZcarD6HC76Rh4IJ8q/E+1nBFUS0vHuN4n+t7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10774

SGVsbG8gTWFuaXZhbm5hbiwNCg0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6
IFdlZG5lc2RheSwgTWFyY2ggNiwgMjAyNCA3OjIyIFBNDQo+IA0KPiBJbiBvcmRlciB0byBhZGQg
c3VwcG9ydCBmb3IgSHlwZXIgRE1BIChIRE1BKSwgbGV0J3MgcmVmYWN0b3IgdGhlIGV4aXN0aW5n
DQo+IGR3X3BjaWVfZWRtYV9maW5kX2NoaXAoKSBBUEkgYnkgbW92aW5nIHRoZSBjb21tb24gY29k
ZSB0byBzZXBhcmF0ZQ0KPiBmdW5jdGlvbnMuDQo+IA0KPiBObyBmdW5jdGlvbmFsIGNoYW5nZS4N
Cj4gDQo+IFN1Z2dlc3RlZC1ieTogU2VyZ2UgU2VtaW4gPGZhbmNlci5sYW5jZXJAZ21haWwuY29t
Pg0KPiBSZXZpZXdlZC1ieTogU2lkZGhhcnRoIFZhZGFwYWxsaSA8cy12YWRhcGFsbGlAdGkuY29t
Pg0KPiBSZXZpZXdlZC1ieTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IE1hbml2YW5uYW4gU2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFy
by5vcmc+DQoNClRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoIQ0KDQpSZXZpZXdlZC1ieTogWW9zaGlo
aXJvIFNoaW1vZGEgPHlvc2hpaGlyby5zaGltb2RhLnVoQHJlbmVzYXMuY29tPg0KDQpCZXN0IHJl
Z2FyZHMsDQpZb3NoaWhpcm8gU2hpbW9kYQ0KDQo+IC0tLQ0KPiAgZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmMgfCA0MCArKysrKysrKysrKysrKysrKysrKysrKy0t
LS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2ln
bndhcmUuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jDQo+
IGluZGV4IDI1MGNmN2Y0MGI4NS4uM2EyNmRmYzUzNjhmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuYw0KPiArKysgYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuYw0KPiBAQCAtODgwLDcgKzg4MCwxNyBA
QCBzdGF0aWMgc3RydWN0IGR3X2VkbWFfcGxhdF9vcHMgZHdfcGNpZV9lZG1hX29wcyA9IHsNCj4g
IAkuaXJxX3ZlY3RvciA9IGR3X3BjaWVfZWRtYV9pcnFfdmVjdG9yLA0KPiAgfTsNCj4gDQo+IC1z
dGF0aWMgaW50IGR3X3BjaWVfZWRtYV9maW5kX2NoaXAoc3RydWN0IGR3X3BjaWUgKnBjaSkNCj4g
K3N0YXRpYyB2b2lkIGR3X3BjaWVfZWRtYV9pbml0X2RhdGEoc3RydWN0IGR3X3BjaWUgKnBjaSkN
Cj4gK3sNCj4gKwlwY2ktPmVkbWEuZGV2ID0gcGNpLT5kZXY7DQo+ICsNCj4gKwlpZiAoIXBjaS0+
ZWRtYS5vcHMpDQo+ICsJCXBjaS0+ZWRtYS5vcHMgPSAmZHdfcGNpZV9lZG1hX29wczsNCj4gKw0K
PiArCXBjaS0+ZWRtYS5mbGFncyB8PSBEV19FRE1BX0NISVBfTE9DQUw7DQo+ICt9DQo+ICsNCj4g
K3N0YXRpYyBpbnQgZHdfcGNpZV9lZG1hX2ZpbmRfbWYoc3RydWN0IGR3X3BjaWUgKnBjaSkNCj4g
IHsNCj4gIAl1MzIgdmFsOw0KPiANCj4gQEAgLTkwMiw4ICs5MTIsNiBAQCBzdGF0aWMgaW50IGR3
X3BjaWVfZWRtYV9maW5kX2NoaXAoc3RydWN0IGR3X3BjaWUgKnBjaSkNCj4gDQo+ICAJaWYgKHZh
bCA9PSAweEZGRkZGRkZGICYmIHBjaS0+ZWRtYS5yZWdfYmFzZSkgew0KPiAgCQlwY2ktPmVkbWEu
bWYgPSBFRE1BX01GX0VETUFfVU5ST0xMOw0KPiAtDQo+IC0JCXZhbCA9IGR3X3BjaWVfcmVhZGxf
ZG1hKHBjaSwgUENJRV9ETUFfQ1RSTCk7DQo+ICAJfSBlbHNlIGlmICh2YWwgIT0gMHhGRkZGRkZG
Rikgew0KPiAgCQlwY2ktPmVkbWEubWYgPSBFRE1BX01GX0VETUFfTEVHQUNZOw0KPiANCj4gQEAg
LTkxMiwxMiArOTIwLDE3IEBAIHN0YXRpYyBpbnQgZHdfcGNpZV9lZG1hX2ZpbmRfY2hpcChzdHJ1
Y3QgZHdfcGNpZSAqcGNpKQ0KPiAgCQlyZXR1cm4gLUVOT0RFVjsNCj4gIAl9DQo+IA0KPiAtCXBj
aS0+ZWRtYS5kZXYgPSBwY2ktPmRldjsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gDQo+IC0JaWYg
KCFwY2ktPmVkbWEub3BzKQ0KPiAtCQlwY2ktPmVkbWEub3BzID0gJmR3X3BjaWVfZWRtYV9vcHM7
DQo+ICtzdGF0aWMgaW50IGR3X3BjaWVfZWRtYV9maW5kX2NoYW5uZWxzKHN0cnVjdCBkd19wY2ll
ICpwY2kpDQo+ICt7DQo+ICsJdTMyIHZhbDsNCj4gDQo+IC0JcGNpLT5lZG1hLmZsYWdzIHw9IERX
X0VETUFfQ0hJUF9MT0NBTDsNCj4gKwlpZiAocGNpLT5lZG1hLm1mID09IEVETUFfTUZfRURNQV9M
RUdBQ1kpDQo+ICsJCXZhbCA9IGR3X3BjaWVfcmVhZGxfZGJpKHBjaSwgUENJRV9ETUFfVklFV1BP
UlRfQkFTRSArIFBDSUVfRE1BX0NUUkwpOw0KPiArCWVsc2UNCj4gKwkJdmFsID0gZHdfcGNpZV9y
ZWFkbF9kbWEocGNpLCBQQ0lFX0RNQV9DVFJMKTsNCj4gDQo+ICAJcGNpLT5lZG1hLmxsX3dyX2Nu
dCA9IEZJRUxEX0dFVChQQ0lFX0RNQV9OVU1fV1JfQ0hBTiwgdmFsKTsNCj4gIAlwY2ktPmVkbWEu
bGxfcmRfY250ID0gRklFTERfR0VUKFBDSUVfRE1BX05VTV9SRF9DSEFOLCB2YWwpOw0KPiBAQCAt
OTMwLDYgKzk0MywxOSBAQCBzdGF0aWMgaW50IGR3X3BjaWVfZWRtYV9maW5kX2NoaXAoc3RydWN0
IGR3X3BjaWUgKnBjaSkNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gDQo+ICtzdGF0aWMgaW50IGR3
X3BjaWVfZWRtYV9maW5kX2NoaXAoc3RydWN0IGR3X3BjaWUgKnBjaSkNCj4gK3sNCj4gKwlpbnQg
cmV0Ow0KPiArDQo+ICsJZHdfcGNpZV9lZG1hX2luaXRfZGF0YShwY2kpOw0KPiArDQo+ICsJcmV0
ID0gZHdfcGNpZV9lZG1hX2ZpbmRfbWYocGNpKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4g
cmV0Ow0KPiArDQo+ICsJcmV0dXJuIGR3X3BjaWVfZWRtYV9maW5kX2NoYW5uZWxzKHBjaSk7DQo+
ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQgZHdfcGNpZV9lZG1hX2lycV92ZXJpZnkoc3RydWN0IGR3
X3BjaWUgKnBjaSkNCj4gIHsNCj4gIAlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2ID0gdG9f
cGxhdGZvcm1fZGV2aWNlKHBjaS0+ZGV2KTsNCj4gDQo+IC0tDQo+IDIuMjUuMQ0KDQo=

