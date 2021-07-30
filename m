Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91903DBA33
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 16:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239235AbhG3OSD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jul 2021 10:18:03 -0400
Received: from mail-bn8nam12on2065.outbound.protection.outlook.com ([40.107.237.65]:2848
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239205AbhG3ORs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Jul 2021 10:17:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqBfPfNOZ7XIJ1kjLgZ4zfSsgv1+LdPo1H9+jicxPT+86QHSbJLhn2oD4q+o9N2XdNPARPxApehnSQ+nwupzAMjM3e21/3QDF1LyMHOifvL+Y6tziB/4S5WO/spdQxHMuwWuyW5+uN37WYHa9C1YhkBwYKwcweLDhYKP/o0Ml/VP6XPkEY8FCHEn1NL3wjPVkHI8LdW2XELhKKbW4EXJmf7ZM9ddcpA5C+ekITbbq5Foa0i87dYn1ZrfquNXr6Gx/EVGrCw5NamX1ahgUMkVMYaoJb6oLMnPQw6Vww7skO7Td0YyWS0Hj8udhJpi6UuJh/3jSjpLrbejmEhU1kb3JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovTOJ5n9ok4h/ZoSjHvItqKjGAYjwQ7wAIyxsyzGNMM=;
 b=i7lMYQHnP7fAfF9iTpNNImX4lQVHR9SOatpn98pAI3ZH7izJiK0VNNVeypXGT9q15WbGsB2aa9VoQHgURreDRMDwvdkQBpD+I7s393uGeE4X+8Gw19Nh6IyjQ6hrD9hwyDAdeo5Zm4tNVosPJxcl930zh6Fr8oraeyzRs0jvb0Z2rF6PT9uN+2OBs/m4H2khO60PSLwlpjuVdlPCNNbb+/hVhh2LeEXqpuQDZRNIBJWw+tofDY2iozo31Za9hvfb5otTU+JACc62+yxHNV0FRYBH1xO7IqBoHV1SC74HJXnICWSw4IddFotUxRG2+uVDupRCJpTZKZ1aho72oR4Plg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovTOJ5n9ok4h/ZoSjHvItqKjGAYjwQ7wAIyxsyzGNMM=;
 b=0gLmWsMjhg2PfUFUrYEzUnW4GTn8NhPjkZEOPBdLBKgE6RC1ong9q1VCLiofgwgcblQeHgE3r3bdRzzrWOaF3lbktEQkWRC6zgffTiFeN9FBYuk4fF6oUhwzztVyDWAhm6LvtaZhI633NOALgMaU8LySBy+YNh92L+hrdg4oSI8=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5224.namprd12.prod.outlook.com (2603:10b6:208:319::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Fri, 30 Jul
 2021 14:17:41 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4373.025; Fri, 30 Jul 2021
 14:17:41 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Marcin Bachry <hegel666@gmail.com>,
        "Liang, Prike" <Prike.Liang@amd.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
Subject: RE: [PATCH] PCI: quirks: Quirk PCI d3hot delay for AMD xhci
Thread-Topic: [PATCH] PCI: quirks: Quirk PCI d3hot delay for AMD xhci
Thread-Index: AQHXfqWQH6NgRDKkG0aHkV8xOmUiZ6tadkoAgAABCwCAAAaIAIAAAPoAgAAFwQCAAAEIgIAAATcw
Date:   Fri, 30 Jul 2021 14:17:40 +0000
Message-ID: <BL1PR12MB5144A5AEEE71A3011CE56E20F7EC9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20210729213026.GA992249@bjorn-Precision-5520>
 <20210729213407.GA993416@bjorn-Precision-5520>
In-Reply-To: <20210729213407.GA993416@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-30T14:17:36Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=01f8488a-23db-4650-a268-ad9546fd28a9;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 133a577e-9c83-4e98-d852-08d95364ca9a
x-ms-traffictypediagnostic: BL1PR12MB5224:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5224D5E9EA0967F0D77A4290F7EC9@BL1PR12MB5224.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: udVlxr0ZhIePzygnTy2dKYtChyQpPyTIJ38uH5d0geVT+sdBXVg8zTP+rBKnjilQmTtQiUuq4w8zMkTLvaADOhpaASnvcvomqqo+93aO10lo8bVUCeVfc2Z8MYNvQCAsrrMImC4HFcLtk6a+52IdQXVwvU7C94E/imq3vP6DX4lgJOx6yfHBIQOS3HMhbePWouXu0bii9WvWEl5/BfG+UQ/sBRnAlkf2EvQVFl9F/x74zWjGlUo4OPWBhCYdLEbcekA3OoVIr813xxut82BWf/wA6OkI8/i8r22wmJzSXRuFVZM3p90pRlXrlo0BHGjneBCd/oyH4ufbJoJRmJAAlUN2VIUKhpgz6ng46NWfoQwT5sA+8vw1/GCIeBh4Z2OGsEvBwMjewIdeqFda7Q/sqVrNS1D3CBiDuoHUijoQR2kGr9I7KEiUdtmKJQXaO92j6lOGbNPBgKKK6s5iGpKPts1owU7q12LdXQgr/6zQxrR2B1krdeRbqQmYZKNc+1OorSV2boUkWojXB347Peh8zMQodsohREv6Q6ZXY0iJ+au9gxMBYJjk8/iOZnCd4rNrZj6ILXrg4h0shfDyAsRnfaVJRawNERdNYOSDee5oXJrtolXiUgRSVCIQ1BLEzOjoaDCsj5rYwSY7yNRffDaFJ8qgvjsZJEgjNiN8q7FqNr0eFRC06tPaTdYES+E/vA1uBmRMtJyLE1zSnS9JPfIG/uFh0FEOiHo3gY3CeV5kpLDmMiHlczoxN7QEGJluTsAE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(122000001)(478600001)(26005)(38070700005)(316002)(76116006)(38100700002)(2906002)(5660300002)(6636002)(55016002)(186003)(8676002)(71200400001)(33656002)(110136005)(4326008)(9686003)(66476007)(52536014)(8936002)(83380400001)(86362001)(54906003)(53546011)(6506007)(66446008)(66556008)(64756008)(66946007)(7696005)(42413003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzJOSGE4Nk43dTZtVGU2dVRxZjBTUXB4TytxdW1CU0xKbUdTak9MNnZVTG1V?=
 =?utf-8?B?Y3FsR3dBZzkxK1RPd0dnOGQ5N0ZoelpQcExjUWxrQVNBZGNFQkFBMUt2KytG?=
 =?utf-8?B?RzVId3AvdEJoVjZZTEhEcjFUbWc3MWtxV3NNTWwzZnR4TnhLd2tab2dLYjZk?=
 =?utf-8?B?YUc5QytGeGszNS9FS2s3d3NlTmEzdWgwY3dsVHpNVGQzLzhYMkFtdUJHQlF0?=
 =?utf-8?B?YjdERk1GZkxUblhhK2hwa3FZZ29ZSFZ2SUNPd29zaXh4UnhZYk9jV0xNSU5v?=
 =?utf-8?B?U08zVldLS2Y1bzJUbmFJR25uZkhKcGllQy9IVW9KNDIya3QzT2FkSXFYQWhB?=
 =?utf-8?B?L0pUN0FhbEJ2MWd2VUR0TllEUXh1c09JdmZIUlpzVkNRbDlGWm5oNXAvaW5R?=
 =?utf-8?B?L29Oam5nUDNld2xpMEV6YW9aQVNyVXcxN0pzUXhHU0hjOXFpajVwTklGQ0t1?=
 =?utf-8?B?RCt0VVl3M25pYWhZYXZhcENyZ0FIVXZHRFRkQkcvUm95dnRWZDlTOXV2cGdr?=
 =?utf-8?B?SzkxOW9Cc0xmN2VzbTFkYnFRLzBKV3ZJU05pRlRlM214UEVyZDNOT3cwZm9Y?=
 =?utf-8?B?Y1doWm1hZkVTSE5IYllnZDd1R2JPbUJRSjVjWno4RUhRdmlKbndHOGZuZm40?=
 =?utf-8?B?Q2ZUUitWclprU0FPdEtWY1FUZDBPcEYvT3VteENpSzJtQlpyQ2dVQnJ3dkZ1?=
 =?utf-8?B?eHNtNTl4UURsVmM4QW9mM2ZkOXRTaEt0bmVXcmxLVktIeU91MTRrSmtvZ0w2?=
 =?utf-8?B?Z1ZzOFpiZi9XMEdBYmhUSmtTeGdFMGVkYlFFMU9GOGJVZ1FJdmZuZiswZ3hC?=
 =?utf-8?B?eVl4dTBRQkN0WmJhZDVOdWZibmg2UTFSclVRVTVwYmQ3UmN4a0V3Z1FjU0pl?=
 =?utf-8?B?UlNndDdxYmRSazN0elcxQ0lEZkFLcW9IRUNNWWdGZjdSU0RMZXh2ZWY2Qlcz?=
 =?utf-8?B?YkQzOEgyZ2JhRisxd0M4MXptWEVrOTdnREZtaGlvaEREaFcrdVBkMkRUZ2p6?=
 =?utf-8?B?b1hoRFJCRUUwUlU5aEVTcmxqN0FtYXR5REZzcHQwcDY3QWJ4U1VQTVFjSVNz?=
 =?utf-8?B?Yk1MSjE1OC91QkVlcFRRaGRRSjRVQ3dOMDB6WmxmM1NkQ1hKODVhb3d1ajlz?=
 =?utf-8?B?aDljZWlmQUpPNjJmc0lIcUlMVkE4WXlCUVRoajMwTm5wbGVsaTJHYmp4Qi8w?=
 =?utf-8?B?NVpVSHVwMjdKUDZ2M05vVzFUMHhqdU41OEZ5TUo5UWIvVDUvZTJBSERZNlhE?=
 =?utf-8?B?MEZlUlpvNUduYkZzSzdhcWRMQWlHdEtwcHRnSHFHTnBaTmxsWXNJWTVoWldN?=
 =?utf-8?B?NnprSCtLVU1HV01mWmZPQW9pVWFtbm8xRE5aRzZrdnZveHJqVjBPS0F0NjV2?=
 =?utf-8?B?aEp3NFlKT1FUdHZ5QjhlVERydEpDZDJCVDlITEhOYjVlL25QeXJzM2N2b01t?=
 =?utf-8?B?aGFUVU9oRnlrWURacXViUlBBZEFHbVFwUUg2R0RXcldKRUhZNE1jOXJacldy?=
 =?utf-8?B?ei9DcTR3T3RucytucDdkU3dKTmtpc0trWkxXVUs4ZDRjTFM3Q3BnTUhITWFL?=
 =?utf-8?B?cmtjTHVVT1R1OXhDOWdaS1pGTlJVcWh0ckNxQiszUGJ0aTU1SUpaQ0VtQzEv?=
 =?utf-8?B?c1RXUXJ6Mjlucm5QTGgvNE1tRW1mUzlkTFpNdmRtM3psSlh3ZWJ1dDFnRFQr?=
 =?utf-8?B?ZjNpYXErbWFjUGhnelhPTzFyMCtaY2Z6ZjE3T1JNdmRWU1pWbDdqa0g3eGFK?=
 =?utf-8?Q?Wv+Gv/tpA5ksKjbgOM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 133a577e-9c83-4e98-d852-08d95364ca9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2021 14:17:40.9580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XswRWBSS6TPttMmAZFL1Ac4dJzRM8EW0febJmXK7JWexuUvKI9Bu8oA/XdZVoy4K668eM2wqihZ8wvqKLLR47A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5224
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBI
ZWxnYWFzIDxoZWxnYWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDI5LCAy
MDIxIDU6MzQgUE0NCj4gVG86IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9A
YW1kLmNvbT4NCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT47DQo+IGJoZWxnYWFzQGdvb2dsZS5jb207IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7
IE1hcmNpbiBCYWNocnkNCj4gPGhlZ2VsNjY2QGdtYWlsLmNvbT47IExpYW5nLCBQcmlrZSA8UHJp
a2UuTGlhbmdAYW1kLmNvbT47IFMtaywgU2h5YW0tDQo+IHN1bmRhciA8U2h5YW0tc3VuZGFyLlMt
a0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBQQ0k6IHF1aXJrczogUXVpcmsgUENJ
IGQzaG90IGRlbGF5IGZvciBBTUQgeGhjaQ0KPiANCj4gT24gVGh1LCBKdWwgMjksIDIwMjEgYXQg
MDQ6MzA6MjhQTSAtMDUwMCwgQmpvcm4gSGVsZ2FhcyB3cm90ZToNCj4gPiBPbiBUaHUsIEp1bCAy
OSwgMjAyMSBhdCAwNDowOTo1MFBNIC0wNTAwLCBMaW1vbmNpZWxsbywgTWFyaW8gd3JvdGU6DQo+
ID4gPiBPbiA3LzI5LzIwMjEgMTY6MDYsIEJqb3JuIEhlbGdhYXMgd3JvdGU6DQo+ID4gPiA+IE9u
IFRodSwgSnVsIDI5LCAyMDIxIGF0IDAzOjQyOjU4UE0gLTA1MDAsIExpbW9uY2llbGxvLCBNYXJp
byB3cm90ZToNCj4gPiA+ID4gPiBPbiA3LzI5LzIwMjEgMTU6MzksIEJqb3JuIEhlbGdhYXMgd3Jv
dGU6DQo+ID4gPiA+ID4gPiBPbiBXZWQsIEp1bCAyMSwgMjAyMSBhdCAxMDo1ODo1OFBNIC0wNDAw
LCBBbGV4IERldWNoZXIgd3JvdGU6DQo+ID4gPiA+ID4gPiA+IEZyb206IE1hcmNpbiBCYWNocnkg
PGhlZ2VsNjY2QGdtYWlsLmNvbT4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gUmVub2ly
IG5lZWRzIGEgc2ltaWxhciBkZWxheS4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gW0Fs
ZXg6IEkgdGFsa2VkIHRvIHRoZSBBTUQgVVNCIGhhcmR3YXJlIHRlYW0gYW5kIHRoZQ0KPiA+ID4g
PiA+ID4gPiAgICBBTUQgd2luZG93cyB0ZWFtIGFuZCB0aGV5IGFyZSBub3QgYXdhcmUgb2YgYW55
IEhXDQo+ID4gPiA+ID4gPiA+ICAgIGVycmF0YSBvciBzcGVjaWZpYyBpc3N1ZXMuICBUaGUgSFcg
d29ya3MgZmluZSBpbg0KPiA+ID4gPiA+ID4gPiAgICB3aW5kb3dzLiAgSSB3YXMgdG9sZCB3aW5k
b3dzIHVzZXMgYSByYXRoZXIgZ2VuZXJvdXMNCj4gPiA+ID4gPiA+ID4gICAgZGVmYXVsdCBkZWxh
eSBvZiAxMDBtcyBmb3IgUENJIHN0YXRlIHRyYW5zaXRpb25zLl0NCj4gPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTWFyY2luIEJhY2hyeSA8aGVnZWw2NjZAZ21haWwu
Y29tPg0KPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRl
ci5kZXVjaGVyQGFtZC5jb20+DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gQWRkZWQgc3RhYmxl
IHRhZyBhbmQgYXBwbGllZCB0byBwY2kvcG0gZm9yIHY1LjE1LCB0aGFua3MhDQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiBUaGFua3MgQmpvcm4hDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBHaXZlbiBob3cg
c21hbGwvaGFybWxlc3MgdGhpcyBpcyBhbmQgNS4xNCBpc24ndCBjdXQgeWV0LCBhbnkNCj4gPiA+
ID4gPiBjaGFuY2UgdGhpcyBjb3VsZCBzdGlsbCBtYWtlIG9uZSBvZiB0aGUgLXJjWCByYXRoZXIg
dGhhbiB3YWl0IGZvciA1LjE0LjENCj4gaW5zdGVhZD8NCj4gPiA+ID4NCj4gPiA+ID4gRG9uZS4N
Cj4gPiA+DQo+ID4gPiBUaGFua3MhDQo+ID4gPg0KPiA+ID4gPiBXaGF0J3MgdGhlIHJlc3Qgb2Yg
dGhlIHN0b3J5IGhlcmU/ICBBYXJlIHdlIHdvcmtpbmcgYXJvdW5kIGENCj4gPiA+ID4gZGVmZWN0
IGluIHRoZXNlIFhIQ0kgY29udHJvbGxlcnM/ICBBIGRlZmVjdCBpbiBMaW51eD8gIE9idmlvdXNs
eQ0KPiA+ID4gPiBub2JvZHkgd2FudHMgdG8gaGF2ZSB0byBhZGQgYSBxdWlyayBmb3IgZXZlcnkg
bmV3IERldmljZSBJRC4gIEl0J3MNCj4gPiA+ID4gbm90IGxpa2UgdGhpcyBzaG91bGQgYmUgaGFy
ZCB0byBmaWd1cmUgb3V0IGZvciB5b3VyIGhhcmR3YXJlIGd1eXMNCj4gPiA+ID4gaW4gdGhlIGxh
YiwgYW5kIGlmIGl0IHR1cm5zIG91dCB0byBiZSBhIExpbnV4IHByb2JsZW0sIHdlIHNob3VsZA0K
PiA+ID4gPiBmaXggaXQgc28gZXZlcnlib2R5IGJlbmVmaXRzLg0KPiA+ID4NCj4gPiA+IE1heWJl
IHlvdSBtaXNzZWQgdGhlIGVtYmVkZGVkIG1lc3NhZ2UgZnJvbSBBbGV4IGFib3ZlLiAgV2UgaGFk
IGENCj4gPiA+IGRpc2N1c3Npb24gd2l0aCBvdXIgaW50ZXJuYWwgdGVhbSB0aGF0IHdvcmtzIHdp
dGggV2luZG93cyBvbiB0aGlzLA0KPiA+ID4gYW5kIHRoZXkgdG9sZCB1cyB0aGUgZGVmYXVsdCBk
ZWxheSBpcyBzaWduaWZpY2FudGx5IG1vcmUgZ2VuZXJvdXMgb24NCj4gV2luZG93cy4NCj4gPg0K
PiA+IEkgZGlkIHNlZSBBbGV4J3MgbWVzc2FnZSwgYnV0IGl0IGRpZG4ndCBhbnN3ZXIgdGhlIHF1
ZXN0aW9uIG9mIHdoZXRoZXINCj4gPiB0aGlzIGlzIGEgaGFyZHdhcmUgZGVmZWN0IG9yIGEgTGlu
dXggZGVmZWN0LiAgIkl0IHdvcmtzIGZpbmUgaW4NCj4gPiBXaW5kb3dzIiBkb2Vzbid0IG1lYW4g
dGhlIGhhcmR3YXJlIGNvbmZvcm1zIHRvIHRoZSBzcGVjLg0KPiA+DQo+ID4gUENJZSByNS4wLCBz
ZWMgNS4zLjEuNCBzYXlzICIuLi4gU3lzdGVtIFNvZnR3YXJlIG11c3QgYWxsb3cgYSBtaW5pbXVt
DQo+ID4gcmVjb3ZlcnkgdGltZSBmb2xsb3dpbmcgYSBEM0hvdCDihpIgRDAgdHJhbnNpdGlvbiBv
ZiBhdCBsZWFzdCAxMCBtcyAoc2VlDQo+ID4gU2VjdGlvbiA3LjkuMTcpLCBwcmlvciB0byBhY2Nl
c3NpbmcgdGhlIEZ1bmN0aW9uLiINCj4gPg0KPiA+IElmIHRoZSBoYXJkd2FyZSBpc24ndCByZWFk
eSBpbiAxMG1zLCBJJ2QgY2xhaW0gdGhhdCdzIGEgaGFyZHdhcmUNCj4gPiBkZWZlY3QuDQo+ID4N
Cj4gPiBJZiBMaW51eCBpc24ndCB3YWl0aW5nIHRoZSAxMG1zLCBJJ2QgY2xhaW0gdGhhdCdzIGEg
TGludXggZGVmZWN0Lg0KPiA+DQo+ID4gSWYgdGhpbmdzIHdvcmsgYnkgd2FpdGluZyAxMDBtcywg
dGhhdCdzIG5pY2UsIGJ1dCB3aGF0J3MgdGhlIHBvaW50IG9mDQo+ID4gc3BlY3MgaWYgd2UgaGF2
ZSB0byBpbmNyZWFzZSB0aGUgdGltZSBhbmQgcGVuYWxpemUgZXZlcnlib2R5IGp1c3QgdG8NCj4g
PiBhY2NvbW1vZGF0ZSBzb21lIG9kZGJhbGwgZGV2aWNlPw0KPiANCj4gMTBtcyBhZnRlciBoaXR0
aW5nICJzZW5kIiBpdCBvY2N1cnJlZCB0byBtZSB0aGF0IHNpbmNlIGFsbCBvZiB0aGVzZSBxdWly
a3MgYXJlDQo+IGZvciBBTUQgZGV2aWNlcywgd2UgY291bGQganVzdCBtYWtlIHRoZSBxdWlyayBn
ZW5lcmljIHNvIHdlIHdhaXQgMTAwbXMgZm9yDQo+ICphbGwqIEFNRCBkZXZpY2VzLiAgVGhlbiBB
TUQgYm94ZXMgd291bGQgcmVzdW1lIGEgbGl0dGxlIHNsb3dlciB0aGFuDQo+IGV2ZXJ5Ym9keSBl
bHNlLCBidXQgc29tZSBvZiB0aGUgbWFpbnRlbmFuY2UgYnVyZGVuIHdvdWxkIGdvIGF3YXkuDQo+
IA0KDQpXZSBwcm9iYWJseSBvbmx5IG5lZWQgYSBzbGlnaHQgaW5jcmVhc2UuICBBcyBJIHNhaWQg
aW4gdGhlIGNvbW1lbnQgb24gdGhlIHBhdGNoLCBpdCBzZWVtcyB0byBvbmx5IGFmZmVjdCBhIHNt
YWxsIHBlcmNlbnRhZ2Ugb2YgYm9hcmRzLiAgRm9yIHRoZSBtb3N0IHBhcnQgMTBtcyBzZWVtcyB0
byBiZSBmaW5lLiAgTW9yZSBvZiBhIGNvcm5lciBjYXNlLCBtYXliZSBzcGVjaWZpYyB0byBjZXJ0
YWluIHBsYXRmb3Jtcy4gIEl0IGRvZXNuJ3Qgc2hvdyB1cCBpbiBzaWxpY29uIHZhbGlkYXRpb24g
b24gb3VyIHJlZmVyZW5jZSBib2FyZHMgYW5kIHRoZW4gcHJlc3VtYWJseSBkb2VzbuKAmXQgc2hv
dyB1cCBpbiB3aW5kb3dzIGR1ZSB0aGUgaW5jcmVhc2VkIHRpbWVvdXQuICBJJ2xsIGtlZXAgdGhp
cyBpbiBtaW5kIG9uIHRoZSBuZXh0IHBsYXRmb3JtIGFuZCBJJ2xsIGNvbnNpZGVyIGEgcGF0Y2gg
dG8gZ2VuZXJpY2FsbHkgaW5jcmVhc2UgdGhlIHRpbWVvdXQgZm9yIEFNRCBpZiBpdCBwcm92ZXMg
dG8gc3RpbGwgYmUgYW4gaXNzdWUgaW4gdGhlIHdpbGQgYWdhaW4uICBTbyBmYXIgb3VyIHVwY29t
aW5nIHBsYXRmb3JtcyAoYXQgbGVhc3Qgb3VyIGludGVybmFsIGVuZ2luZWVyaW5nIHBsYXRmb3Jt
cyBkb24ndCBleGhpYml0IHRoaXMpLiAgVGhhdCBzYWlkLCBJIGRvbid0IHJlY2FsbCB1cyBzZWVp
bmcgdGhpcyBpc3N1ZSBvbiBhbnkgb2Ygb3VyIHJlZmVyZW5jZSBwbGF0Zm9ybXMgaW4gdGhlIHBh
c3QuDQoNClRoYW5rcywNCg0KQWxleA0KDQo+IEknbSBvbmx5IGhhbGYgam9raW5nLCBhbmQgSSB3
b3VsZCB0YWtlIHRoYXQgcGF0Y2ggaWYgeW91IHNlbnQgaXQuDQo+IA0KPiBCam9ybg0K
