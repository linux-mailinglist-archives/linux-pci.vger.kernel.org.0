Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C295432FF2
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 09:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhJSHqD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 03:46:03 -0400
Received: from mail-eopbgr00086.outbound.protection.outlook.com ([40.107.0.86]:17646
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231701AbhJSHqC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 03:46:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mB8YFUqLllbTFhBazCrzm2/mrAfl3+OKZ3EhCxzDVjhMCE/GG5iuElYRIsThc/AVsIglDR/HQv2g+2egWyIfi+FQqOTkfynoX5S9lSCwRbcO9WAdl9xb2cEUx/+VI85urB32nvEY7KhPA8PvHqJO1US10Vb7u1fvEvh/4oNp4qy8Q/0myyq6rIp+TY5j9wjT0hYvQmiY61syhS3eAnkB5HbaV8MjmyPdnwlolcg89tXzcw9vI7dxNZFnv5iXyTl60cMh+VVd3al1RTZozLQq0GmN+P/vK8SaLzL1sx+jqkfmmijny/9DOLYTVZLS26YaVYu4GWPq8WMHZ7iancMYCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvBk4qK3Jo7YMrTFfR7ThNKtW13xJtI3N4EMYykdTNs=;
 b=gG2tSi0DW96jUosUSrfgzSdl5i6h+/x/fATuZedkGT9m7i3c0GJmSkPjLz+jsV9rZxSciasLZPUz8G+uXukeETL6LDgWacs4ajn4pQlOJRFkv45WJszM5b7sc7Ihj1UDwNYih2ZQK8i1lecehUDUeHncnnohqRuF9R/GYphfPFmF3Iws39ttaXjZ3t8Tw4iJPQhAhDK7mu/jmvchG3yvd1QPmmQb0nXQLKbNSyNPdMypSgC19sdamZRbwltBfTiTELoZUbQvvhJOW7TVZ6oCKPUku0kqMB7VUz0rMZGdCIpMAuNOHUq+s14tUapGACSzDscJXPPXIdeuCsZAcUZNFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvBk4qK3Jo7YMrTFfR7ThNKtW13xJtI3N4EMYykdTNs=;
 b=VfYTkwMFXdV9bU1EE22jjwu7SbDB6VS3O/BPON25tXQXXOe5qUqgXyAJNRkBHtvPYVppQ+6ymjdp8uyVBGmuIiIh5O50eDi+7HbblQUJpskmAu+7+T29TEzssTtKNtK2xsltp6S/ML2VEsw87yTfEctPe2EZ9dzfIJGgLpxVfUs=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8740.eurprd04.prod.outlook.com (2603:10a6:20b:42d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Tue, 19 Oct
 2021 07:43:47 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%4]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 07:43:47 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [RESEND v2 4/5] PCI: imx6: Fix the clock reference handling
 unbalance when link never came up
Thread-Topic: [RESEND v2 4/5] PCI: imx6: Fix the clock reference handling
 unbalance when link never came up
Thread-Index: AQHXwY4ue+QOjCGA8ESB+dHo+5+VOqvUYM4AgAWVPgA=
Date:   Tue, 19 Oct 2021 07:43:46 +0000
Message-ID: <AS8PR04MB86765D5BB34070D5F6BEFB628CBD9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1634277941-6672-1-git-send-email-hongxing.zhu@nxp.com>
         <1634277941-6672-5-git-send-email-hongxing.zhu@nxp.com>
 <39cae5a1e33d489bd390be9e7e4df67d788eb7be.camel@pengutronix.de>
In-Reply-To: <39cae5a1e33d489bd390be9e7e4df67d788eb7be.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 428c738a-fe82-4224-fb50-08d992d42f17
x-ms-traffictypediagnostic: AS8PR04MB8740:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB8740DD100E9115D9F907DF348CBD9@AS8PR04MB8740.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rZkOB+HR0doJ+qU6x77hb6N5vySuWkTF+NjqgOdaM/KmbodBSYGo3IahGrbmu3AFmquKfxf+bWQYDtJMTYvSIPkBk025NWjeJD4dX4wAbNQU+fYoxszlTpE3Z/qAm+7MTPztiCuNWM8AvqfcTK1G4bvAgkTzNoggLJopZIzzvZhaaAAEtF3o3OwF26a9S0DHyvu3uZh/WON3mU2O78S9fWWlZnJNVaJ27OwvsR/2u3QoOEySgtm2Zjt0DpYff4IchaVehdMOXjop6LN0MUbN7gWpH1KKeYVbFTT4dRXVm4DhAAQjyZZ6jzRvBQyagVyopPoA6Lla6qJjxEa7FhOzMJuOP9NACR9nWPFV8ThLMDIdqv+y9RVdtVOryp1BZoT4DJHSV5RFITGPMOj0TSQej0HGt5kVz89VoScfAQZmbb8dORJ7vQ5efuNdPMBh4YNL25fAdVawuI61Z2z6FSZPxOkLYSA+kXyzDhFWHJ0DfHiirDidhn4EPcI+PU9hvgmLMtMTXLw19ONII4pEck6u3ZxI5BZeiVHHtQ02iZo4s6u89kKOUGZ19JDx/IQbdGDls97Fv+skNXPXc0BYSAP9l4J70M73pZcPX4unlWAfSB6sgaI6SKg8wrUJUEpdkD02RLzQ9Yqzlnzh9eXb8dR3xm39tg3C7stRWy0TcaQWZAB40WLHndOW6weN8rpMjNyPHROHRYqt5Z4SK8OcatZUoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(508600001)(53546011)(38100700002)(4326008)(86362001)(66946007)(66556008)(6506007)(33656002)(5660300002)(38070700005)(122000001)(26005)(55016002)(66446008)(76116006)(83380400001)(7696005)(110136005)(54906003)(71200400001)(316002)(9686003)(186003)(8676002)(64756008)(52536014)(2906002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFVmRlJhdjJObWg4VGhwU0NvYmtpcVBrZkpoTytCMlY3SnJQZ3J4aTJNcXpp?=
 =?utf-8?B?bXJJL1lDdW14a1VjZUViblVNeWFFNEhlb1RheGxHMjllRHc5TTBuN3dFbElv?=
 =?utf-8?B?WlZKQnNVeEdVdEdqbzBvWXdMTW1EeDU3RlJyUFFJN2NxYVB4UnAwdmpEbVpI?=
 =?utf-8?B?NnBEUEVaYlNzaXhxV3FLTWEzcktIRUVJVSszenlxK3BpNE1aWW0xMVRQV0tD?=
 =?utf-8?B?dnpTMk1ZNVdKd1ZNZmxrQkpqQlFDZGhtNmx5cXNqeTBYMzVhQjZlUk9taVRI?=
 =?utf-8?B?RDhIdFhLSVJrejcyVWVFYVJOcTdnb1haOEViMWtrTEdBd0Y1RC84K0pBUzI3?=
 =?utf-8?B?NmthTlRyUjhpSXFjREpMVjFOYXFlanhRekZ5YlRmb1YzZVpGSklqMDRwcWxP?=
 =?utf-8?B?bkhxdEJNV3ZxSGkwWmVoWFJaVWNpV1JmRWdwMlU5V2VHWDNMZGZ0OGF0SUJo?=
 =?utf-8?B?Nm9ZbnQrbEVyNnFJaUpRZEJXY0hiWGJ3WGErR3ZxYWtIVm5YVkVFbkVxUnQw?=
 =?utf-8?B?QUxOZHRXRUNVWlhsbkI5T1NzRTRZTytOQlltY0Izb2JOTW5FQnJER0Ezbmcr?=
 =?utf-8?B?NENRazg3cTNwZnBBcTRBVVFrRFVuci9QWkxqYW14L3lSREowdkVLRFUwcGJ0?=
 =?utf-8?B?MzNiTGwvTGNDYkw1VDZyd0NCajY0NHJrVlhXc3FlTjhkd1BjQ1RnQ0g5bVdG?=
 =?utf-8?B?UjErbXhWMUpDcis0Y0ptbTBqa1lEcHZ0MzZ6b3YrSmU4czBveXA3ZzhWSWlj?=
 =?utf-8?B?dDl4TlU5aWFRTUdnd3oyUkpFOTY2OWdiK0NBNlY1UG5McVNkbTJtMERpbHYz?=
 =?utf-8?B?aThWVXN4Y2J0MTJ0dzQwNlpYUVZHbnlOUGlpT3cxUDZ2MVhCS2JrbjdtSHVr?=
 =?utf-8?B?NjN4WHpjK3BkOStXcFBvU0tOU2M4STNGMHpOQU5va2hLUHhSc1ZiOEJHQ29h?=
 =?utf-8?B?WTNCdXk2ZFdVSUpIUmI1U1ZGRkRnNFJ0U1JZbDlOWXFIU2RHOFVvY2FyNjJv?=
 =?utf-8?B?SWFHeUFqemc4TkFkTzZnSFVRdFJ2eFk3U1lwTExwMnZ4cGxkQlNUTzB3SVR0?=
 =?utf-8?B?UEs4S1VyVWt1aVdDcW1sOWIyNXhaZXlCUktFejc5VVNhWG1WYnQyL1BzeFZL?=
 =?utf-8?B?a05oR0UvUGJSL29GK0pwRUhaOHAzcWU4WHhLaDlnQjQyTkxFT3J3UldqWHZp?=
 =?utf-8?B?dUpQY1ZBdjFoOHBHUjFwSXFaYk92djVSTThGMk4yM29rUTlkajlmbHhYT1NR?=
 =?utf-8?B?UllNQk54bm9XZm1ocmFhVVY1N1RMK2JHNFNub2JIc0Q1WGNvdzVQU3hGWmFV?=
 =?utf-8?B?QmJhRm5ZMlRxUUVVNnFadis4TlNqWW5rYkV3ZHgrRmhibTdjcjJVdGRaYUZO?=
 =?utf-8?B?ZTZxMlBlZ3JMaHZyekxDVHZFU2NSWlpYcDh5djc4SWV2cXRMT2xBZWpBVFpF?=
 =?utf-8?B?dHViaXZEcE1PZkllYnFEQm56K0FXTUZNdEl1eTExdE5KVDNXdHZ2OG55bnc5?=
 =?utf-8?B?UVVyTGpyUy9uUkdiK1RqSWo2MlNwMGsrWVRYWmQ3TUV3ZG9oc3lQaWxlWEU1?=
 =?utf-8?B?TUt0Mk5LampUM2lqME9lTFozTXRqN3V3a3l2ajVKemxGak9XUlF2My9xczJk?=
 =?utf-8?B?Z0dseTJVdDRvYVZENVZEQXBhOVdIS3Q3Wm1GRVN3UzB1bEE1ODRwZnQ2NUZ0?=
 =?utf-8?B?ZGVpbXd0YWhtOXREOWEySWZJZUFTUnhmU0VEaVUrTm11VGNLMncvWitoT2pa?=
 =?utf-8?Q?tmB9fgue4IpHlruV6jrf3Ywgo6CsiMnYJ6SzaSC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 428c738a-fe82-4224-fb50-08d992d42f17
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 07:43:46.9423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jcxIlgljBdqgv97sX852U/rp9Av7zJYu0RMzXMlHtSZDCikWF3c8LimWjIVWf9ibXyen0ly7JJXKChrbtdqdqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8740
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogU2F0dXJkYXksIE9jdG9iZXIgMTYsIDIwMjEgMjoy
NSBBTQ0KPiBUbzogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgYmhlbGdhYXNA
Z29vZ2xlLmNvbTsNCj4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbQ0KPiBDYzogbGludXgtcGNp
QHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlDQo+IFN1YmplY3Q6IFJlOiBbUkVTRU5E
IHYyIDQvNV0gUENJOiBpbXg2OiBGaXggdGhlIGNsb2NrIHJlZmVyZW5jZSBoYW5kbGluZw0KPiB1
bmJhbGFuY2Ugd2hlbiBsaW5rIG5ldmVyIGNhbWUgdXANCj4gDQo+IEFtIEZyZWl0YWcsIGRlbSAx
NS4xMC4yMDIxIHVtIDE0OjA1ICswODAwIHNjaHJpZWIgUmljaGFyZCBaaHU6DQo+ID4gV2hlbiBs
aW5rIG5ldmVyIGNhbWUgdXAsIGRyaXZlciBwcm9iZSB3b3VsZCBiZSBmYWlsZWQgd2l0aCBlcnJv
ciAtMTEwLg0KPiA+IFRvIGtlZXAgdXNhZ2UgY291bnRlciBiYWxhbmNlIG9mIHRoZSBjbG9ja3Ms
IGRpc2FibGUgdGhlIHByZXZpb3VzDQo+ID4gZW5hYmxlZCBjbG9ja3Mgd2hlbiBsaW5rIGlzIGRv
d24uDQo+ID4gTW92ZSBkZWZpbml0aW9ucyBvZiB0aGUgaW14Nl9wY2llX2Nsa19kaXNhYmxlKCkg
ZnVuY3Rpb24gdG8gdGhlIHByb3Blcg0KPiA+IHBsYWNlLiBCZWNhdXNlIGl0IHdvdWxkbid0IGJl
IHVzZWQgaW4gaW14Nl9wY2llX3N1c3BlbmRfbm9pcnEoKSBvbmx5Lg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHwgNDcNCj4gPiArKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDI0IGluc2VydGlvbnMo
KyksIDIzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaS1pbXg2LmMNCj4gPiBpbmRleCBjYzgzN2Y4YmY2ZDQuLmQ2YTVkOTlmZmE1MiAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gKysr
IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IEBAIC01MTQsNiAr
NTE0LDI5IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX2Nsa19lbmFibGUoc3RydWN0IGlteDZfcGNp
ZQ0KPiAqaW14Nl9wY2llKQ0KPiA+ICAJcmV0dXJuIHJldDsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0
YXRpYyB2b2lkIGlteDZfcGNpZV9jbGtfZGlzYWJsZShzdHJ1Y3QgaW14Nl9wY2llICppbXg2X3Bj
aWUpIHsNCj4gPiArCWNsa19kaXNhYmxlX3VucHJlcGFyZShpbXg2X3BjaWUtPnBjaWUpOw0KPiA+
ICsJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGlteDZfcGNpZS0+cGNpZV9waHkpOw0KPiA+ICsJY2xr
X2Rpc2FibGVfdW5wcmVwYXJlKGlteDZfcGNpZS0+cGNpZV9idXMpOw0KPiA+ICsNCj4gPiArCXN3
aXRjaCAoaW14Nl9wY2llLT5kcnZkYXRhLT52YXJpYW50KSB7DQo+ID4gKwljYXNlIElNWDZTWDoN
Cj4gPiArCQljbGtfZGlzYWJsZV91bnByZXBhcmUoaW14Nl9wY2llLT5wY2llX2luYm91bmRfYXhp
KTsNCj4gPiArCQlicmVhazsNCj4gPiArCWNhc2UgSU1YN0Q6DQo+ID4gKwkJcmVnbWFwX3VwZGF0
ZV9iaXRzKGlteDZfcGNpZS0+aW9tdXhjX2dwciwgSU9NVVhDX0dQUjEyLA0KPiA+ICsJCQkJICAg
SU1YN0RfR1BSMTJfUENJRV9QSFlfUkVGQ0xLX1NFTCwNCj4gPiArCQkJCSAgIElNWDdEX0dQUjEy
X1BDSUVfUEhZX1JFRkNMS19TRUwpOw0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJY2FzZSBJTVg4TVE6
DQo+ID4gKwkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGlteDZfcGNpZS0+cGNpZV9hdXgpOw0KPiA+
ICsJCWJyZWFrOw0KPiA+ICsJZGVmYXVsdDoNCj4gPiArCQlicmVhazsNCj4gPiArCX0NCj4gPiAr
fQ0KPiA+ICsNCj4gPiAgc3RhdGljIHZvaWQgaW14N2RfcGNpZV93YWl0X2Zvcl9waHlfcGxsX2xv
Y2soc3RydWN0IGlteDZfcGNpZQ0KPiA+ICppbXg2X3BjaWUpICB7DQo+ID4gIAl1MzIgdmFsOw0K
PiA+IEBAIC04NTMsNiArODc2LDcgQEAgc3RhdGljIGludCBpbXg2X3BjaWVfc3RhcnRfbGluayhz
dHJ1Y3QgZHdfcGNpZSAqcGNpKQ0KPiA+ICAJCWR3X3BjaWVfcmVhZGxfZGJpKHBjaSwgUENJRV9Q
T1JUX0RFQlVHMCksDQo+ID4gIAkJZHdfcGNpZV9yZWFkbF9kYmkocGNpLCBQQ0lFX1BPUlRfREVC
VUcxKSk7DQo+ID4gIAlpbXg2X3BjaWVfcmVzZXRfcGh5KGlteDZfcGNpZSk7DQo+ID4gKwlpbXg2
X3BjaWVfY2xrX2Rpc2FibGUoaW14Nl9wY2llKTsNCj4gDQo+IFNhbWUgY29tbWVudCBhcyB3aXRo
IHRoZSBwcmV2aW91cyBwYXRjaC4gV2Ugc2hvdWxkIG5vdCBjcmFtIGluIG1vcmUgZXJyb3INCj4g
aGFuZGxpbmcgaW4gdGhlIGlteDZfcGNpZV9zdGFydF9saW5rIGZ1bmN0aW9uLCBidXQgcmF0aGVy
IG1vdmUgb3V0IGFsbCB0aGUNCj4gZXJyb3IgaGFuZGxpbmcgdG8gYmUgYWZ0ZXIgZHdfcGNpZV9o
b3N0X2luaXQuIEV2ZW4gdGhlIGFscmVhZHkgZXhpc3RpbmcgcGh5DQo+IHJlc2V0IGhlcmUgc2Vl
bXMgbWlzcGxhY2VkIGFuZCBzaG91bGQgYmUgbW92ZWQgb3V0Lg0KW1JpY2hhcmQgWmh1XSBBYm91
dCB0aGUgY2xrIGRpc2FibGVkLCBwbGVhc2Ugc2VlIG15IGV4cGxhaW5zIHVuZGVyIHRoZSBhZGRy
ZXNzZWQgY29tbWVudHMgaW4gdGhlICMzIHBhdGNoLg0KQWdyZWUgdG8gbW92ZSB0aGUgZXhpc3Rp
bmcgcGh5IHJlc2V0IHRvIHRoZSBlcnJvciBoYW5kbGluZyBhZnRlciBkd19wY2llX2hvc3RfaW5p
dC4NClRoYW5rcy4NCkJSDQpSaWNoYXJkDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IEx1Y2FzDQo+IA0K
PiA+ICAJaWYgKGlteDZfcGNpZS0+dnBjaWUgJiYgcmVndWxhdG9yX2lzX2VuYWJsZWQoaW14Nl9w
Y2llLT52cGNpZSkgPiAwKQ0KPiA+ICAJCXJlZ3VsYXRvcl9kaXNhYmxlKGlteDZfcGNpZS0+dnBj
aWUpOw0KPiA+ICAJcmV0dXJuIHJldDsNCj4gPiBAQCAtOTQxLDI5ICs5NjUsNiBAQCBzdGF0aWMg
dm9pZCBpbXg2X3BjaWVfcG1fdHVybm9mZihzdHJ1Y3QNCj4gaW14Nl9wY2llICppbXg2X3BjaWUp
DQo+ID4gIAl1c2xlZXBfcmFuZ2UoMTAwMCwgMTAwMDApOw0KPiA+ICB9DQo+ID4NCj4gPiAtc3Rh
dGljIHZvaWQgaW14Nl9wY2llX2Nsa19kaXNhYmxlKHN0cnVjdCBpbXg2X3BjaWUgKmlteDZfcGNp
ZSkgLXsNCj4gPiAtCWNsa19kaXNhYmxlX3VucHJlcGFyZShpbXg2X3BjaWUtPnBjaWUpOw0KPiA+
IC0JY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGlteDZfcGNpZS0+cGNpZV9waHkpOw0KPiA+IC0JY2xr
X2Rpc2FibGVfdW5wcmVwYXJlKGlteDZfcGNpZS0+cGNpZV9idXMpOw0KPiA+IC0NCj4gPiAtCXN3
aXRjaCAoaW14Nl9wY2llLT5kcnZkYXRhLT52YXJpYW50KSB7DQo+ID4gLQljYXNlIElNWDZTWDoN
Cj4gPiAtCQljbGtfZGlzYWJsZV91bnByZXBhcmUoaW14Nl9wY2llLT5wY2llX2luYm91bmRfYXhp
KTsNCj4gPiAtCQlicmVhazsNCj4gPiAtCWNhc2UgSU1YN0Q6DQo+ID4gLQkJcmVnbWFwX3VwZGF0
ZV9iaXRzKGlteDZfcGNpZS0+aW9tdXhjX2dwciwgSU9NVVhDX0dQUjEyLA0KPiA+IC0JCQkJICAg
SU1YN0RfR1BSMTJfUENJRV9QSFlfUkVGQ0xLX1NFTCwNCj4gPiAtCQkJCSAgIElNWDdEX0dQUjEy
X1BDSUVfUEhZX1JFRkNMS19TRUwpOw0KPiA+IC0JCWJyZWFrOw0KPiA+IC0JY2FzZSBJTVg4TVE6
DQo+ID4gLQkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGlteDZfcGNpZS0+cGNpZV9hdXgpOw0KPiA+
IC0JCWJyZWFrOw0KPiA+IC0JZGVmYXVsdDoNCj4gPiAtCQlicmVhazsNCj4gPiAtCX0NCj4gPiAt
fQ0KPiA+IC0NCj4gPiAgc3RhdGljIGludCBpbXg2X3BjaWVfc3VzcGVuZF9ub2lycShzdHJ1Y3Qg
ZGV2aWNlICpkZXYpICB7DQo+ID4gIAlzdHJ1Y3QgaW14Nl9wY2llICppbXg2X3BjaWUgPSBkZXZf
Z2V0X2RydmRhdGEoZGV2KTsNCj4gDQoNCg==
