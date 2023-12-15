Return-Path: <linux-pci+bounces-1030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2D4813F07
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 02:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19BE1F21663
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 01:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA2A381;
	Fri, 15 Dec 2023 01:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="f0bZbpSl"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2100.outbound.protection.outlook.com [40.107.113.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1D2363;
	Fri, 15 Dec 2023 01:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YU7HCApe5zIwzprsdk77dNiXthrmUIvN+Gm2RBfF8a70RSipLc8+RR7roF7q+skhycyI1wk/9BQCY3dmy4emJK7g8j+wqwEcyDK9p7/bTKUEsJcJOXBDYGrJ7TKCjdJD0Lxp6W9IILXA6MyrB6RImQpeK7FGEsZA2QCqCVb0ZK4P7ptis5U7O/E9gzRrMQ/FNe4KYMdbZiMZZ47qrxkiz3U+vhu4evOrdJnGwveEU7jw/fH2Ho+utCSEhgk5tHHulZU63ZvSEL0etrSdUkM+OAEAqm3xfSzmGSaKMdA1Q4fzGkiAxun3Hn+RP6I5nb84jGtc75zM3MhyGyRBDMw3Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfXqaOeVPmwE81Y/v6G0nKHfPwF7E7ajQpZaOsSW69k=;
 b=Av2z2HN1veiLPaorCv/gcUBC9qQ9tZ4y9EhA60TeRsMtj9ALg7s0OLNexVuWiQnXlyAEdw8KHj/HieOoZwwvrIHwMHBF7j1ghl7aUjf3QhFgzPyvOcHp8KG2CqKfc9QaXzwz7jwdMJNrLsirTctMRkT5UP88/noa2W5O8BRMFkgPNAHC5ayUj2F1AIRnFYjJLJwxPxQFhduse4HvkilQEgc92MQ7D12GxkThc0DJyJhlf638Up0jixn5CmkvevP9yzyxaNh7r3BpcQCfA3lcThkADpJjhaeL3p3Uyay1p/fDwmpkogO574ijENoRJsMkevPW5vyQhet3ROvAc6SMzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfXqaOeVPmwE81Y/v6G0nKHfPwF7E7ajQpZaOsSW69k=;
 b=f0bZbpSl/+eevuwZNJTnbUbkR4kymiuI/vs/aMX/QX5xz5UBb8+YHrT3dufVYeZY2fRpivRM6P9DlFDFLn5bR+WFR4AR6Pv6L29cJa5JSBdErIH2alJ49jeD08w3lh6JpPGTKgZ3OWKeYDbc1Ysq8YceN7/1LYoGUGybl35j0WI=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TY3PR01MB11850.jpnprd01.prod.outlook.com
 (2603:1096:400:372::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.10; Fri, 15 Dec
 2023 01:13:14 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::50f5:eb2b:710a:b7c7]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::50f5:eb2b:710a:b7c7%7]) with mapi id 15.20.7113.010; Fri, 15 Dec 2023
 01:13:14 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Serge Semin
	<fancer.lancer@gmail.com>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 4/6] PCI: dwc: Add dw_pcie_ep_{read,write}_dbi[2]
 helpers
Thread-Topic: [PATCH v2 4/6] PCI: dwc: Add dw_pcie_ep_{read,write}_dbi[2]
 helpers
Thread-Index: AQHaFr8d4uM2joYV60+An72PMAr49rB5o84AgASc84CAK3kk4A==
Date: Fri, 15 Dec 2023 01:13:14 +0000
Message-ID:
 <TYBPR01MB5341B3CEEB76CE12C4216184D893A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20231114055456.2231990-1-yoshihiro.shimoda.uh@renesas.com>
 <20231114055456.2231990-5-yoshihiro.shimoda.uh@renesas.com>
 <qpw6zgqnxvnxqwzilelaev26xmjebimnyyvc5jzfgdyqgvjyvq@sne5unvwbea4>
 <20231117091911.GF250770@thinkpad>
In-Reply-To: <20231117091911.GF250770@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TY3PR01MB11850:EE_
x-ms-office365-filtering-correlation-id: 7b274f79-85bd-4c71-78d4-08dbfd0b0352
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rc/51I63Fwc0SFtw7BbCO59jW5gEHm1X9PMP9lp9QPUvli+J7ye6IgzP8hZxySbuQLH7vogsZrQpQH13Tq04ks0NJRm/aFKMUiIiQFUP7erNH3C9neRADA3lbPGYdFvCo8o1gRxPVSwpU1hNQNqpou23KuTodQ7KewwZEEMhcUiWurmuKgSmI6ZEmmARcVyEvc9P23InZByP6gWbAZAT4LJZc1euVNQJ/V8TPH3z9wUJ7SdrNgH9c0/JfrXwDX5QD36Kmufm+brF+R7DXKXWnH5GEiA1dFz/ped/GxZ5hMpJgjPXriEZZUQ0F+etlSIY49A3TeKC4mM9Q/BmNRyIqabAa9asCsdw26utCAQ15FoBqy49+5xzeYlTwwq7UHo8mgGQ4qiX5Jmlk8+eO7vKiCGP/rik5DGELlsw+SoAp4SfeBfHSSKc4+YKCZCfkL8uqXX36WHSBCLnD6k7t2ZbiXAqrH+ipmSAJ4lw7JQ38vaXADVKpktaUr/pG2AmlVUKaTgq/UsNjpn+wHjWV48zcYYsrEAL5wKu/D27WGExSAJQVKXOWlFCwSudx0GJUNrqTg7M3bWahqYtYSMuhNjQSYmYhAliBUP8YMqyHhn/b5JNmg+jV54HxDLNvSxQrj7Q
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(366004)(396003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6506007)(7696005)(71200400001)(9686003)(83380400001)(5660300002)(7416002)(52536014)(4326008)(41300700001)(2906002)(478600001)(8676002)(8936002)(76116006)(110136005)(66946007)(316002)(54906003)(64756008)(66446008)(66476007)(66556008)(33656002)(86362001)(122000001)(38100700002)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RDgwTWQyTll5WGFhLzlKSXpmTWZhZ1NpYUVXOEkydC9CQ0t1bVVPaFN1Sm5Z?=
 =?utf-8?B?Z3FTRm1OcFptWHcwRXlBanR0c2RTSkw0aXBwbmN0ZUlGL2k2cVpTSzlyb0dE?=
 =?utf-8?B?V1QzZDY4RVpFS1J6MVVlRTMvNzlRNTVOTG96WDdrSEd3MmQxeXk4UHBIWDZ3?=
 =?utf-8?B?aXdwTjhSejRqTGI4SFkvUTZHVmJ1amZFWVNqZkd4c2ZiYitzUmJ6L0dnQ0tL?=
 =?utf-8?B?Q3FJWFk1NXhoVnhkQjJ3ZExSM1B2MDdRK1hVSndHelJhNEtWVzJ3UmRYaGhj?=
 =?utf-8?B?ZW9kb0h3eXJXUGZuekNwQ3h4Q0VFOGpOQklCRlFjcWRoUzFFU1RUbkxGK3ds?=
 =?utf-8?B?dTVZRzhLNllkdW5VNG5tbkR1REFVTG1NWXhiT3ZVQkVqei8zOWdKVWpISEhK?=
 =?utf-8?B?SHFwTGFKSjlFOVI2TXQxdDI0U2czOWFxSU92VXU1cFlaWWV2bzFtUlNGaFN5?=
 =?utf-8?B?RXlOM0V6RFdWY1UwWGtyNC9CMkFLd1VhOFBXQ3o4alFaVmtrV3ZtT2tWTVlB?=
 =?utf-8?B?WC9sMFZMUDlXNUlLRHA5NE9vLy9rclh5RnBaZXNZRmdtRHdCaE15aFd2bnU5?=
 =?utf-8?B?RDdYREVKRDJkaVRtN1VuT2VMVnZNVFVJQWZmbk5yVWxWQTBjaCtaeFludkpJ?=
 =?utf-8?B?aGxKYmd5dFRNdEZGV2IzQmlsMmFPS2g3OWhnTnZqOCtybTEwSFZPamp2UW95?=
 =?utf-8?B?L3FseDNFM0cwVEpyYTlDTFBpVnhqWmNNWkVCTytNQ0FPakU4RWF3YU9lbUlh?=
 =?utf-8?B?aW0wSlVWdkhpZ1g3cW8wSGZSUzlUNUhEQ3RzT3A5T3VuZFY4a0VHdldLZEpi?=
 =?utf-8?B?VWJObHAzMXc2aWxSeVdwcnB6YWtpd2Z6TGxXRStISlhnMmQ1aGpsSzZCTEYy?=
 =?utf-8?B?SGJTbkIvOHNmMHM5bWowOUM2Q0Rmb09lY05mYUVNZTBWTzRSVVBVRDFnMHVl?=
 =?utf-8?B?MmNWQWZDNzVDdzZrZVhmTTFoVkR6NHN0UUM0bGt1cWpVWTh4WnZCTmtveERq?=
 =?utf-8?B?M0dwbDVlSDI0Y3g5SVZ5eFo4RHd3eFlJMjNIeUJTYitibWhjRUhLb3FMZi9l?=
 =?utf-8?B?eTR2clhlaXkrZXRFK0JCOWFEa3hVOWVWS1c0NmZwc0RZalhHVjlXQVpyUk5G?=
 =?utf-8?B?WlZ3QUtVQnptelpacW9nbHFrY3k0MFNxNWs2ZHRqdUM3ay9XK1cwb25XNmxt?=
 =?utf-8?B?aEJBcitoM280amg2dVltKzE3amtXQVJ6NUpiRC9rQXhIbWJ0ZmFqWmFad1lN?=
 =?utf-8?B?ejE3dVZvaDV6djNpdHdGL0hqbm4zdnNZK1ZWTGdiZXpNN2FNWDl3WFlZOXdm?=
 =?utf-8?B?Tkd1SmEzT2xTZzhoVERxN1ZFU2N6NjdXQXorbFlURmlOUUxVRzhMOEpVVldW?=
 =?utf-8?B?OWorT0sxZDkrUXRzTmJERUVqT2dmT1R1T2tRdkNOVW1CaktzQVhhVHlMd2Rq?=
 =?utf-8?B?Qm5LYUREOEZrUDg0VW1Ra1JDOEY3S2gzeDRUZEVQOFJwMW1KYk5udHRiM0hE?=
 =?utf-8?B?WmpBcmdhUFV2ekJxTGUza0xCTDlCN0NjSVNoODROM0N4NDB0cDMrd1oxY3hk?=
 =?utf-8?B?T0hFMm1tL0N0N29oZC9BRVltT0RMMGVqOE9iTkM2eVR2WndTMUl6UXMxMEtZ?=
 =?utf-8?B?MW1qU1hQSlQ3R1o0U0FDaVJnTVVPa2orZmFoNVEzYlRodFZZTTVHWGE0RW5O?=
 =?utf-8?B?cGUwNHVkNndmSEVtYklPSzlVblZ6QVhJc00zRmo0K1k5cGhVQWF0S25kY1M2?=
 =?utf-8?B?ZC9DUFcvVE1sK1V4SFI5VWZ2bWh6R1A0M1NpVkpzN2RuTFI2b1FXYmpiUDBj?=
 =?utf-8?B?SUNFTnlFTGNvaWM0ZUVoSVRPY1VMY0xKZ1pnREdTMWtoN3ZIU3F4SlZ5aFM0?=
 =?utf-8?B?RXhWeitvNFkzZ0xvcStXRTlMNWFiMndBaElQYUtHZWZ3amJFUHgrbDgrVE1m?=
 =?utf-8?B?V1hpdkRnd1FTS3VQQWhWdVAwRmtnblVBcjQ5d1c1M0cyOVR1UDlCZFY3bklS?=
 =?utf-8?B?ZDQvQVR6Q3IxbWJXY1hIUk1vNjNLZCtMeVUwY3NPUUwrT0huMXdzTjFLSWZr?=
 =?utf-8?B?Y0MyRkdZcGxCRkovSFNWNDMyZCtHN1hsZGViWnhuOXRsTjVmK0lKNllLbXFF?=
 =?utf-8?B?ZC9tSDV0eTZ6emw3ZHR6L05jcm5kK25idTVwWnpuYlFQSkhwWnNPRjgrQkF0?=
 =?utf-8?B?cWhHTTBXMkZBWk1HRk53ZzBBQUlXVXJ1YTNpby9QT3V3Ym1SODNuc1dTbjFi?=
 =?utf-8?B?bjV6ZFYySTAyVXhTdGx3ZVB1QmNRPT0=?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b274f79-85bd-4c71-78d4-08dbfd0b0352
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 01:13:14.4649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5D6haOgnaWZy3carGRiOjNV0sC3Gh2qgX7ofO+ySd3I40qz2j5HPCmCtBD+OJqIVEEwesqsaKMeZVoZ6ExPCCmoKb+L7ljmD+xgkI12tq/rh5G3+E5++O68J21W3HmKk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11850

SGVsbG8gTWFuaXZhbm5hbiwNCg0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6
IEZyaWRheSwgTm92ZW1iZXIgMTcsIDIwMjMgNjoxOSBQTQ0KPiANCj4gT24gVHVlLCBOb3YgMTQs
IDIwMjMgYXQgMDE6NTI6MjRQTSArMDMwMCwgU2VyZ2UgU2VtaW4gd3JvdGU6DQo+ID4gT24gVHVl
LCBOb3YgMTQsIDIwMjMgYXQgMDI6NTQ6NTRQTSArMDkwMCwgWW9zaGloaXJvIFNoaW1vZGEgd3Jv
dGU6DQo+ID4gPiBUaGUgY3VycmVudCBjb2RlIGNhbGN1bGF0ZWQgc29tZSBkYmlbMl0gcmVnaXN0
ZXJzJyBvZmZzZXQgYnkgY2FsbGluZw0KPiA+ID4gZHdfcGNpZV9lcF9nZXRfZGJpWzJdX29mZnNl
dCgpIGluIGVhY2ggZnVuY3Rpb24uIFRvIGltcHJvdmUgY29kZQ0KPiA+ID4gcmVhZGFiaWxpdHks
IGFkZCBkd19wY2llX2VwX3tyZWFkLHdyaXRlfV9kYmlbMn0gYW5kIHNvbWUgZGF0YS13aWR0aA0K
PiA+ID4gcmVsYXRlZCBoZWxwZXJzLg0KPiA+DQo+ID4gTmljZSB1cGRhdGUuIFRoYW5rcyENCj4g
PiBSZXZpZXdlZC1ieTogU2VyZ2UgU2VtaW4gPGZhbmNlci5sYW5jZXJAZ21haWwuY29tPg0KPiA+
DQo+ID4gSSdsbCByZXBsaWNhdGUgbXkgdjEgbml0cGljayByZWdhcmRpbmcgdGhlIGFjY2Vzc29y
cyBsb2NhdGlvbiBoZXJlIHNvDQo+ID4gdGhlIG1haW50YWluZXJzIHdvdWxkIGRlY2lkZSB3aGV0
aGVyIGl0IHdvcnRoIGJlaW5nIHRha2VuIGludG8NCj4gPiBhY2NvdW50Lg0KPiA+DQo+ID4gPg0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogWW9zaGloaXJvIFNoaW1vZGEgPHlvc2hpaGlyby5zaGltb2Rh
LnVoQHJlbmVzYXMuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgLi4uL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2llLWRlc2lnbndhcmUtZXAuYyAgIHwgMjMxICsrKysrKysrKystLS0tLS0tLQ0KPiA+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAxMjkgaW5zZXJ0aW9ucygrKSwgMTAyIGRlbGV0aW9ucygtKQ0KPiA+
ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRl
c2lnbndhcmUtZXAuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2Fy
ZS1lcC5jDQo+ID4gPiBpbmRleCAxMTAwNjcxZGI4ODcuLjJiNWI1YjBmYTdhOSAxMDA2NDQNCj4g
PiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1lcC5j
DQo+ID4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUt
ZXAuYw0KPiA+ID4gQEAgLTY1LDI0ICs2NSw4OCBAQCBzdGF0aWMgdW5zaWduZWQgaW50IGR3X3Bj
aWVfZXBfZ2V0X2RiaTJfb2Zmc2V0KHN0cnVjdCBkd19wY2llX2VwICplcCwgdTggZnVuY19ubw0K
PiA+ID4gIAlyZXR1cm4gZGJpMl9vZmZzZXQ7DQo+ID4gPiAgfQ0KPiA+ID4NCj4gPiA+ICtzdGF0
aWMgdTMyIGR3X3BjaWVfZXBfcmVhZF9kYmkoc3RydWN0IGR3X3BjaWVfZXAgKmVwLCB1OCBmdW5j
X25vLCB1MzIgcmVnLA0KPiA+ID4gKwkJCSAgICAgICBzaXplX3Qgc2l6ZSkNCj4gPiA+ICt7DQo+
ID4gPiArCXVuc2lnbmVkIGludCBvZmZzZXQgPSBkd19wY2llX2VwX2dldF9kYmlfb2Zmc2V0KGVw
LCBmdW5jX25vKTsNCj4gPiA+ICsJc3RydWN0IGR3X3BjaWUgKnBjaSA9IHRvX2R3X3BjaWVfZnJv
bV9lcChlcCk7DQo+ID4gPiArDQo+ID4gPiArCXJldHVybiBkd19wY2llX3JlYWRfZGJpKHBjaSwg
b2Zmc2V0ICsgcmVnLCBzaXplKTsNCj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gPiArc3RhdGljIHZv
aWQgZHdfcGNpZV9lcF93cml0ZV9kYmkoc3RydWN0IGR3X3BjaWVfZXAgKmVwLCB1OCBmdW5jX25v
LCB1MzIgcmVnLA0KPiA+ID4gKwkJCQkgc2l6ZV90IHNpemUsIHUzMiB2YWwpDQo+ID4gPiArew0K
PiA+ID4gKwl1bnNpZ25lZCBpbnQgb2Zmc2V0ID0gZHdfcGNpZV9lcF9nZXRfZGJpX29mZnNldChl
cCwgZnVuY19ubyk7DQo+ID4gPiArCXN0cnVjdCBkd19wY2llICpwY2kgPSB0b19kd19wY2llX2Zy
b21fZXAoZXApOw0KPiA+ID4gKw0KPiA+ID4gKwlkd19wY2llX3dyaXRlX2RiaShwY2ksIG9mZnNl
dCArIHJlZywgc2l6ZSwgdmFsKTsNCj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gPiArc3RhdGljIHZv
aWQgZHdfcGNpZV9lcF93cml0ZV9kYmkyKHN0cnVjdCBkd19wY2llX2VwICplcCwgdTggZnVuY19u
bywgdTMyIHJlZywNCj4gPiA+ICsJCQkJICBzaXplX3Qgc2l6ZSwgdTMyIHZhbCkNCj4gPiA+ICt7
DQo+ID4gPiArCXVuc2lnbmVkIGludCBvZmZzZXQgPSBkd19wY2llX2VwX2dldF9kYmkyX29mZnNl
dChlcCwgZnVuY19ubyk7DQo+ID4gPiArCXN0cnVjdCBkd19wY2llICpwY2kgPSB0b19kd19wY2ll
X2Zyb21fZXAoZXApOw0KPiA+ID4gKw0KPiA+ID4gKwlkd19wY2llX3dyaXRlX2RiaTIocGNpLCBv
ZmZzZXQgKyByZWcsIHNpemUsIHZhbCk7DQo+ID4gPiArfQ0KPiA+ID4gKw0KPiA+ID4gK3N0YXRp
YyBpbmxpbmUgdm9pZCBkd19wY2llX2VwX3dyaXRlbF9kYmkoc3RydWN0IGR3X3BjaWVfZXAgKmVw
LCB1OCBmdW5jX25vLA0KPiA+ID4gKwkJCQkJIHUzMiByZWcsIHUzMiB2YWwpDQo+ID4gPiArew0K
PiA+ID4gKwlkd19wY2llX2VwX3dyaXRlX2RiaShlcCwgZnVuY19ubywgcmVnLCAweDQsIHZhbCk7
DQo+ID4gPiArfQ0KPiA+ID4gKw0KPiA+ID4gK3N0YXRpYyBpbmxpbmUgdTMyIGR3X3BjaWVfZXBf
cmVhZGxfZGJpKHN0cnVjdCBkd19wY2llX2VwICplcCwgdTggZnVuY19ubywNCj4gPiA+ICsJCQkJ
ICAgICAgIHUzMiByZWcpDQo+ID4gPiArew0KPiA+ID4gKwlyZXR1cm4gZHdfcGNpZV9lcF9yZWFk
X2RiaShlcCwgZnVuY19ubywgcmVnLCAweDQpOw0KPiA+ID4gK30NCj4gPiA+ICsNCj4gPiA+ICtz
dGF0aWMgaW5saW5lIHZvaWQgZHdfcGNpZV9lcF93cml0ZXdfZGJpKHN0cnVjdCBkd19wY2llX2Vw
ICplcCwgdTggZnVuY19ubywNCj4gPiA+ICsJCQkJCSB1MzIgcmVnLCB1MTYgdmFsKQ0KPiA+ID4g
K3sNCj4gPiA+ICsJZHdfcGNpZV9lcF93cml0ZV9kYmkoZXAsIGZ1bmNfbm8sIHJlZywgMHgyLCB2
YWwpOw0KPiA+ID4gK30NCj4gPiA+ICsNCj4gPiA+ICtzdGF0aWMgaW5saW5lIHUxNiBkd19wY2ll
X2VwX3JlYWR3X2RiaShzdHJ1Y3QgZHdfcGNpZV9lcCAqZXAsIHU4IGZ1bmNfbm8sDQo+ID4gPiAr
CQkJCSAgICAgICB1MzIgcmVnKQ0KPiA+ID4gK3sNCj4gPiA+ICsJcmV0dXJuIGR3X3BjaWVfZXBf
cmVhZF9kYmkoZXAsIGZ1bmNfbm8sIHJlZywgMHgyKTsNCj4gPiA+ICt9DQo+ID4gPiArDQo+ID4g
PiArc3RhdGljIGlubGluZSB2b2lkIGR3X3BjaWVfZXBfd3JpdGViX2RiaShzdHJ1Y3QgZHdfcGNp
ZV9lcCAqZXAsIHU4IGZ1bmNfbm8sDQo+ID4gPiArCQkJCQkgdTMyIHJlZywgdTggdmFsKQ0KPiA+
ID4gK3sNCj4gPiA+ICsJZHdfcGNpZV9lcF93cml0ZV9kYmkoZXAsIGZ1bmNfbm8sIHJlZywgMHgx
LCB2YWwpOw0KPiA+ID4gK30NCj4gPiA+ICsNCj4gPiA+ICtzdGF0aWMgaW5saW5lIHU4IGR3X3Bj
aWVfZXBfcmVhZGJfZGJpKHN0cnVjdCBkd19wY2llX2VwICplcCwgdTggZnVuY19ubywNCj4gPiA+
ICsJCQkJICAgICAgdTMyIHJlZykNCj4gPiA+ICt7DQo+ID4gPiArCXJldHVybiBkd19wY2llX2Vw
X3JlYWRfZGJpKGVwLCBmdW5jX25vLCByZWcsIDB4MSk7DQo+ID4gPiArfQ0KPiA+ID4gKw0KPiA+
ID4gK3N0YXRpYyBpbmxpbmUgdm9pZCBkd19wY2llX2VwX3dyaXRlbF9kYmkyKHN0cnVjdCBkd19w
Y2llX2VwICplcCwgdTggZnVuY19ubywNCj4gPiA+ICsJCQkJCSAgdTMyIHJlZywgdTMyIHZhbCkN
Cj4gPiA+ICt7DQo+ID4gPiArCWR3X3BjaWVfZXBfd3JpdGVfZGJpMihlcCwgZnVuY19ubywgcmVn
LCAweDQsIHZhbCk7DQo+ID4gPiArfQ0KPiA+ID4gKw0KPiA+DQo+ID4gTXkgY29tbWVudCB3YXM6
DQo+ID4NCj4gPiA+IEZyb206IFNlcmdlIFNlbWluLCBTZW50OiBNb25kYXksIE5vdmVtYmVyIDEz
LCAyMDIzIDk6NDEgUE0NCj4gPiA+ID4gSSBhbSBub3Qgc3VyZSB3aGV0aGVyIHRoZSBtZXRob2Rz
IGFib3ZlIGFyZSBzdXBwb3NlZCB0byBiZSBkZWZpbmVkDQo+ID4gPiA+IGhlcmUgaW5zdGVhZCBv
ZiBiZWluZyBtb3ZlZCB0byB0aGUgInBjaWUtZGVzaWdud2FyZS5oIiBoZWFkZXIgZmlsZQ0KPiA+
ID4gPiB0b2dldGhlciB3aXRoIGR3X3BjaWVfZXBfZ2V0X2RiaTJfb2Zmc2V0KCkgYW5kDQo+ID4g
PiA+IGR3X3BjaWVfZXBfZ2V0X2RiaV9vZmZzZXQoKS4gVGhlIGxhdGVyIHBsYWNlIHNlZW1zIG1v
cmUgc3VpdGFibGUNCj4gPiA+ID4gc2VlaW5nIHRoZSBhY2Nlc3NvcnMgYXJlIGdlbmVyaWMsIGxv
b2sgc2ltaWxhciB0byB0aGUNCj4gPiA+ID4gZHdfcGNpZV97d3JpdGUscmVhZH1fZGJpeywyfSgp
IGZ1bmN0aW9ucyBhbmQgbWlnaHQgYmUgdXNlZnVsIGluIHRoZQ0KPiA+ID4gPiBwbGF0Zm9ybSBk
cml2ZXJzLiBPbiB0aGUgb3RoZXIgaGFuZCBubyBMTEREcyB3b3VsZCBoYXZlIHVzZWQgaXQNCj4g
PiA+ID4gY3VycmVudGx5LiBTbyBJJ2xsIGxlYXZlIHRoaXMgYXMgYSBmb29kIGZvciB0aG91Z2h0
cyBmb3IgdGhlIGRyaXZlcg0KPiA+ID4gPiBhbmQgc3Vic3lzdGVtIG1haW50YWluZXJzLg0KPiA+
DQo+ID4gWW9zaGloaXJvIHJlcGxpZWQ6DQo+ID4gPiBQZXJoYXBzLCB3aGVuIGEgZGV2aWNlIGRy
aXZlciBuZWVkcyB0byB1c2UgdGhlc2UgZnVuY3Rpb25zIGFjdHVhbGx5LA0KPiA+ID4gd2UgY2Fu
IG1vdmUgdGhlc2UgZnVuY3Rpb25zIHRvIHBjaWUtZGVzaWdud2FyZS5oLCBJIHRoaW5rLg0KPiA+
DQo+IA0KPiBJIGFncmVlIHdpdGggeW91LiBTaW5jZSB0aGVzZSBhcmUgcmVhZC93cml0ZSBhY2Nl
c3NvcnMsIGl0IHdvdWxkIGJlIGJldHRlciB0bw0KPiBtb3ZlIHRoZW0gdG8gdGhlIGhlYWRlciBm
aWxlIGluc3RlYWQuDQoNClRoYW5rIHlvdSBmb3IgeW91ciBjb21tZW50LiBBbmQsIEknbSBzb3Jy
eSBmb3IgZGVsYXllZCB0aGUgcmVzcG9uc2UuDQpJIGNvbXBsZXRlbHkgb3Zlcmxvb2tlZCB0aGlz
IGVtYWlsLi4uIEknbGwgbW92ZSB0aGVtIHRvIHRoZSBoZWFkZXIgZmlsZSBvbiB2My4NCg0KQmVz
dCByZWdhcmRzLA0KWW9zaGloaXJvIFNoaW1vZGENCg0KPiAtIE1hbmkNCj4gDQo+IC0tDQo+IOCu
ruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==

