Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 483BD154271
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2020 11:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgBFK5Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Feb 2020 05:57:25 -0500
Received: from mail-eopbgr60075.outbound.protection.outlook.com ([40.107.6.75]:61566
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727698AbgBFK5Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Feb 2020 05:57:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRRF/TsOUFVifwhfm56aTo3Dki2xAw2PNVG3UcY7522UsB0Z2U1OsNeaR8gJa4qQqJAiHa640QcNO9Gr/ynr+ViFlFGli1zREoFw3LIkoGjFEfGzGEfIZCq96nWYznNeI8Yc/NM03iay37FFZBw/QZifsnSQ4X85PE6J0NeuN9BdVQh6MiqQpO2nOalVkg6JkDtojF0w1wx54LOGV9F2Iy553GvefSh6vZFBRE4VsZ2xuCpB5NaDPXmRNhwqfTy/i011CoaxfoePNQqcpcvhhMJAgmKrIxAQNOFJd3pUXI4PhL8RwaJElWqDMRTanrog5eiPA/d314pdsWDhFz08fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUUITFqmrpTrBulNn1KbrwxOh/awNv3JleG3gGEIkaQ=;
 b=E94nREJnsPqyKAyxzvZJLoysWH7gX4wPubjaqUfvC4z0IYFARgHb4tPGLoGowDaq1ERo+ZMmtegVL9ngwjM0FzZ82zW09HcSFiRwgkztTmfASSO7H+CuPVt6drI75B+o+xSJYZ1aX8FXyCF0yDQWLSBOUKtF8I4wujTQf5KQZNRMBcIQ6feY+xfio9+k17uQ+XgBjKCNi0U3U8ORhmtDsm/WrzyDxigxBOYwbQ107LJQBuD49Nd683YRoVY2lhGHZPiC4wAKghtmlGlrLnhiDN3Zb3Sx6gjwc4+YNocoS5zu9UsSG8HT5+fywFoPGQwdbN2tEwdUatfOjFLootPtwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUUITFqmrpTrBulNn1KbrwxOh/awNv3JleG3gGEIkaQ=;
 b=R5FZX0iMpoSfJIJVEX2NC0QfBEEKeeh+GC+XlmkVQPJii19G29FnxVECvLH0g0wgljoLL/PuH8+jVt5FucudAKwwT22dqahXiMhX++gWQVpACNGq8NlMQ+Pk0DQ2MKNifV3ApDUcV6FN2ZrhjNq7sQ8w4LH3W7QM1YMQYzM0XGA=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB6732.eurprd04.prod.outlook.com (20.179.251.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Thu, 6 Feb 2020 10:57:22 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa%4]) with mapi id 15.20.2686.035; Thu, 6 Feb 2020
 10:57:21 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Olof Johansson <olof@lixom.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        Leo Li <leoyang.li@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCHv9 00/12] PCI: Recode Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Thread-Topic: [PATCHv9 00/12] PCI: Recode Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Thread-Index: AQHVn1Tsfp+9ZVhNFU2th1+s/za9wae4ifkAgAU/LmCAJo7igIAAGaaAgCh8UlA=
Date:   Thu, 6 Feb 2020 10:57:21 +0000
Message-ID: <DB8PR04MB67473114B315FBCC97D0C6F9841D0@DB8PR04MB6747.eurprd04.prod.outlook.com>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
 <CAOesGMjAQSfx1WZr6b1kNX=Exipj_f4X_f39Db7AxXr4xG4Tkg@mail.gmail.com>
 <DB8PR04MB6747DA8E1480DCF3EFF67C9284500@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <20200110153347.GA29372@e121166-lin.cambridge.arm.com>
 <CAOesGMj9X1c7eJ4gX2QWXSNszPkRn68E4pkrSCxKMYJG7JHwsg@mail.gmail.com>
In-Reply-To: <CAOesGMj9X1c7eJ4gX2QWXSNszPkRn68E4pkrSCxKMYJG7JHwsg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 764ab8d2-64a1-471f-bc82-08d7aaf35798
x-ms-traffictypediagnostic: DB8PR04MB6732:|DB8PR04MB6732:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB6732A0523DE19CF114AD1CFA841D0@DB8PR04MB6732.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(199004)(189003)(6506007)(53546011)(8936002)(81166006)(81156014)(8676002)(110136005)(54906003)(316002)(64756008)(71200400001)(66476007)(52536014)(66556008)(66946007)(5660300002)(76116006)(66446008)(9686003)(4326008)(55016002)(7696005)(33656002)(2906002)(186003)(86362001)(26005)(7416002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6732;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RgEQ561lZXehOH8R3AOSRNcjETKSaS3WFglDHqgcC0uXR+3W/4w9c+chKHDBy1X+Q/tbfvtcONQmnRuyN6evGAQva9U+D2UXYxv5VqN+TxUMu8KZQZLUXRUejQCORtbC8Oaeb0+Pw+UWVW534Fn/etCEPL06iRN4BdleUniZUKIDi2ma8FFB1KWU91xUDRYmDInevb0Km3//qwdHNro2s+1+7MUlNY+sCWjXP8mt/hp/OcFynZpIkAu8/Vq6c/FZ0r1iyExHm8Lc2cV4XmNcFlEkUljm8CGlDJxZ1+6tdIFZXb+kYo9PWTPyutzAr0m+JnUwOyRjWn/5kP0eCCH/rXr2YWnyxErONdAji8yHe1+hf+cgthfNaTWp4xKVrt95xMHrodkOGSxDlRukusVQnDiKXgHkgr9Pyjmtrs08WIfVxJ00HuKT66r91W5FsCvW
x-ms-exchange-antispam-messagedata: yCZ/EtPRPoV8kV/Tta2hG2kW8PpoZnTQohevi5BHIjSyOeqPZ7gZhnVA83SA3pxIvD4wQ9iCr36T2PBHSpX99LLSVt3j6Zlyi/o2zLk9oSf7XJIUanX1V4lZM7XH5ER0Twt+lbLaSNaT4qbqabKB+Q==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 764ab8d2-64a1-471f-bc82-08d7aaf35798
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 10:57:21.7098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fXTo6qZuSDlZMq2ERXcz3MKIQ+CeX41rlojxWuEwHeR3D2wnXBZCg+7ooc5U9gZv+zEycT9dLBWIeJIpzZj30w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6732
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgT2xvZiwNCg0KVGhhbmtzIGEgbG90IGZvciB5b3VyIGNvbW1lbnRzIQ0KQW5kIHNvcnJ5IGZv
ciBteSBkZWxheSByZXNwb25kIQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IE9sb2YgSm9oYW5zc29uIDxvbG9mQGxpeG9tLm5ldD4NCj4gU2VudDogMjAyMOW5tDHmnIgx
MeaXpSAxOjA2DQo+IFRvOiBMb3JlbnpvIFBpZXJhbGlzaSA8bG9yZW56by5waWVyYWxpc2lAYXJt
LmNvbT4NCj4gQ2M6IFoucS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT47IGJoZWxnYWFzQGdv
b2dsZS5jb207DQo+IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsgYXJuZEBhcm5k
Yi5kZTsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+IGwuc3VicmFobWFueWFAbW9iaXZlaWwuY28u
aW47IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IG0ua2FydGhpa2V5YW5AbW9iaXZlaWwuY28uaW47
IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsNCj4gY2F0YWxpbi5tYXJpbmFzQGFybS5jb207
IHdpbGwuZGVhY29uQGFybS5jb207IGFuZHJldy5tdXJyYXlAYXJtLmNvbTsNCj4gTWluZ2thaSBI
dSA8bWluZ2thaS5odUBueHAuY29tPjsgTS5oLiBMaWFuIDxtaW5naHVhbi5saWFuQG54cC5jb20+
Ow0KPiBYaWFvd2VpIEJhbyA8eGlhb3dlaS5iYW9AbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSHY5IDAwLzEyXSBQQ0k6IFJlY29kZSBNb2JpdmVpbCBkcml2ZXIgYW5kIGFkZCBQQ0llIEdl
bjQNCj4gZHJpdmVyIGZvciBOWFAgTGF5ZXJzY2FwZSBTb0NzDQo+IA0KPiBPbiBGcmksIEphbiAx
MCwgMjAyMCBhdCA3OjMzIEFNIExvcmVuem8gUGllcmFsaXNpIDxsb3JlbnpvLnBpZXJhbGlzaUBh
cm0uY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IE9uIFR1ZSwgRGVjIDE3LCAyMDE5IGF0IDAyOjUw
OjE1QU0gKzAwMDAsIFoucS4gSG91IHdyb3RlOg0KPiA+ID4gSGkgTG9yZW56bywNCj4gPiA+DQo+
ID4gPiBUaGUgdjkgcGF0Y2hlcyBoYXZlIGFkZHJlc3NlZCB0aGUgY29tbWVudHMgZnJvbSBBbmRy
ZXcsIGFuZCBpdCBoYXMNCj4gPiA+IGJlZW4gZHJpZWQgYWJvdXQgMSBtb250aCwgY2FuIHlvdSBo
ZWxwIHRvIGFwcGx5IHRoZW0/DQo+ID4NCj4gPiBXZSBzaGFsbCBoYXZlIGEgbG9vayBiZWdpbm5p
bmcgb2YgbmV4dCB3ZWVrLCBzb3JyeSBmb3IgdGhlIGRlbGF5IGluDQo+ID4gZ2V0dGluZyBiYWNr
IHRvIHlvdS4NCj4gDQo+IE5vdGUgdGhhdCB0aGUgcGF0Y2ggc2V0IG5vIGxvbmdlciBhcHBsaWVz
IHNpbmNlIHRoZSByZWZhY3RvcmluZ3MgY29uZmxpY3Qgd2l0aA0KPiBuZXcgZGV2ZWxvcG1lbnQg
Ynkgb3RoZXJzLg0KPiANCj4gWmhpcWlhbmcsIGNhbiB5b3UgcmViYXNlIGFuZCBwb3N0IGEgbmV3
IHZlcnNpb24gb2YgdGhlIHBhdGNoIHNldD8NCg0KWWVzLCBJIHdpbGwgcmViYXNlIHRoZSBwYXRj
aGVzIHRvIHRoZSBsYXRlc3QgY29kZSBiYXNlLg0KDQpUaGFua3MsDQpaaGlxaWFuZw0KDQogDQo+
IA0KPiAtT2xvZg0K
