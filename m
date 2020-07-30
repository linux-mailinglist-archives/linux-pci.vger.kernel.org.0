Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376ED232E48
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 10:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgG3ITB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jul 2020 04:19:01 -0400
Received: from mail-eopbgr20068.outbound.protection.outlook.com ([40.107.2.68]:36086
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729169AbgG3IIT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Jul 2020 04:08:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgXdhKrVuUkVKi7JjCugpy+b9EqBDFNeuNHxQQgQln97jg9FMLrmcFx41k8BTSNrrnymvM8hv10kfKMf/bLvZ7/ds1Njx+pHZJP73t/xKRt6oQUqfyFOgaTUmELQUurwjzU2FDu4zM4Xx/8WEVtSXSjNHMZnvXVx64bf5ReMZLb+l646R8iJOwpHRhkLPmQZv/3GDGwwvesvc3s5pbG4IpZjPHdtAdubbuDYORwC/bBtw4mAbKHMMqzNcP5zvzr6gPfvz+uUbM3eAs7MfiRJMT/AiRaI0HNK3mLEU6q4luSBG5HfQzCI9Szhli9RJtqeB2Z8SrAtLKvmWlJ2Bu/smA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYRH13wY1ZFaZrdWEmKN4cuI+uwPfUDReLnebCzN3MA=;
 b=gxZgyCiXOlKr90o3i4k4p5/hP1cEG9BSYRzu4hNZLMEQ3dWbLxqVtwZqhp7rsNU8408o91DQeu4Rnyjcq3wCWq8r8+w8Um95e82oexjd6UQ6jMH4uHtR3PnM9NVkxE9I6pTDXaU0QvsTjHAX9LIupAjeUOKOeif7lKmW1TEvLmQLZPi6mCA+6RvXZyCS1U+dl6qCHfO55Ca7KTmlHOyooZjw03EaGJSL/aT8onCU/HrsgOCz0KcGFehLbnCym3e/zRtah/0oZVWd6tul6g1gWY7Htj5XqG6jHgkTcVrfhJLuPDHrMDOzRe5GLqu37yzahNw2yKx+UHl5FGvTa/vTiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYRH13wY1ZFaZrdWEmKN4cuI+uwPfUDReLnebCzN3MA=;
 b=NzK5OwrLjNwvdhUOkrsEnrQ62Bl+Ky1m/TyR+93U4KIb0GGhNyvUcOMLQ6nT8GmMVoLghcepCcYBDHgjwXtFr9lp1D7KcwQgaCIiNdh2zQmmAKk/mOo79Nja1T+gGVtxlxYV6vRntWbMY4x9ZMfAt/XtHgOF7mgi5I7DtZQ/eIw=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VI1PR0401MB2687.eurprd04.prod.outlook.com (2603:10a6:800:57::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Thu, 30 Jul
 2020 08:08:15 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::1de7:774:144c:e60f]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::1de7:774:144c:e60f%6]) with mapi id 15.20.3239.019; Thu, 30 Jul 2020
 08:08:15 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Anson Huang <anson.huang@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "olof@lixom.net" <olof@lixom.net>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "treding@nvidia.com" <treding@nvidia.com>,
        "vidyas@nvidia.com" <vidyas@nvidia.com>,
        "hayashi.kunihiko@socionext.com" <hayashi.kunihiko@socionext.com>,
        "jonnyc@amazon.com" <jonnyc@amazon.com>,
        "eswara.kota@linux.intel.com" <eswara.kota@linux.intel.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH V3 3/3] pci: imx: Select RESET_IMX7 by default
Thread-Topic: [EXT] Re: [PATCH V3 3/3] pci: imx: Select RESET_IMX7 by default
Thread-Index: AQHWZM0KX+ExJ9s00kefcpiD36eO46kfxJ7w
Date:   Thu, 30 Jul 2020 08:08:14 +0000
Message-ID: <VI1PR04MB58537AB6E14F48010B0B6A678C710@VI1PR04MB5853.eurprd04.prod.outlook.com>
References: <1595254921-26050-1-git-send-email-Anson.Huang@nxp.com>
 <1595254921-26050-3-git-send-email-Anson.Huang@nxp.com>
 <20200728105118.GB905@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200728105118.GB905@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 82f46ecd-f8fb-44e8-8364-08d8345fb5ee
x-ms-traffictypediagnostic: VI1PR0401MB2687:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB268766DB3DD83139171CEF0C8C710@VI1PR0401MB2687.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZI1hB8CYAJXzWsJkRLLqxF1uUrfqyPwUTttXuAuv3cLObIQ1gHI1KtzKd7KAg+XmRhLqUq2JSWpNWgFx7khXM+x+ZMLuV7WvxCXtsqDQrTVph57O+MK3kgBCbBSVJ7dqd1yueT0pgYrG6logsLIDFNfZCs3hTxtVbPfCECj4W1ARye9oSdc6vWiAp08PyQtID1nCCuOJ0ERKpFLl/al8ZxtP6apZ1Lx1rRGxXbYWBEmtnyUew18SzEvOa+tVS7EDH6FhtFvioJUeP96Ufa8PT4IONQjCdkN4LBJUSWd1a/Jkb6z7Q/q7Zug2l228yPh/V70ujVEkoFc+qrUCMSfCQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(316002)(7696005)(4326008)(53546011)(7416002)(110136005)(8676002)(9686003)(6506007)(54906003)(86362001)(5660300002)(55016002)(8936002)(33656002)(52536014)(26005)(478600001)(66446008)(66946007)(66476007)(66556008)(83380400001)(71200400001)(186003)(76116006)(2906002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: V+1p7nWxyYG4cSYzawgk2P7Yas8CfRVci5hdeswmBLFYgU2WS4UE2e9GQthEXsJz4LDZQci8YxGR1IA4hlaVyjVKRzJb92tpi4MPEu6NcTakff959pktXiBKbMOK0tXhw2F/9K3uhP002/05vwzoOM2RdAFM/n/W4SQcNEMm1b4iAzUmemVr2vFSYYUk2NIoLEHzGFK5XRLrqcvvtTSRxyXCT3i1P8Bnkg2mkNB/93+ec3lbyXodXdVzkIzs/Dmnr40KeyLGjXU+wWk8qlrTvF27hkQGmnxi9O1xmBsdKskNPR623X+s7KGObiPu9oqY4D//jWq9MbxAx/m3Zi+qI1SMxBSwK91jeOCd0mrZe4OMI41Ke6xXGr+vQBOXLYhbXkc9uMhjoZ89vEOEC+0Xm2Ak4Yh0Ldc20sunp12xQRcW8xaBsADhoyIIjICxi3gxOtL5uTVOPyWrsFE1YiWFogocbXSLBwkvzWQHWaUKdaw=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f46ecd-f8fb-44e8-8364-08d8345fb5ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 08:08:15.0170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/+OOIvU/Lc4buwQ6iTjhzgmPhOsfeMlwFhUbMI6Ac74nSN+1EDOrucIrYtCExUr4SQy5Vma+BDjX/geEYDu+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2687
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMb3JlbnpvIFBpZXJhbGlzaSA8
bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbT4NCj4gU2VudDogMjAyMMTqN9TCMjjI1SAxODo1MQ0K
PiBUbzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+OyBSaWNoYXJkIFpodQ0KPiA8
aG9uZ3hpbmcuemh1QG54cC5jb20+OyBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5k
ZT4NCj4gQ2M6IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOyB3aWxsQGtlcm5lbC5vcmc7IHJvYmhA
a2VybmVsLm9yZzsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgcC56YWJlbEBwZW5ndXRyb25peC5k
ZTsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVs
QHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+IGJqb3JuLmFuZGVyc3NvbkBs
aW5hcm8ub3JnOyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47IHZrb3VsQGtlcm5lbC5vcmc7
DQo+IGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlOyBvbG9mQGxpeG9tLm5ldDsgYW11cnJheUB0aGVn
b29kcGVuZ3Vpbi5jby51azsNCj4gdHJlZGluZ0BudmlkaWEuY29tOyB2aWR5YXNAbnZpZGlhLmNv
bTsgaGF5YXNoaS5rdW5paGlrb0Bzb2Npb25leHQuY29tOw0KPiBqb25ueWNAYW1hem9uLmNvbTsg
ZXN3YXJhLmtvdGFAbGludXguaW50ZWwuY29tOyBrcnprQGtlcm5lbC5vcmc7DQo+IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsNCj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BB
VENIIFYzIDMvM10gcGNpOiBpbXg6IFNlbGVjdCBSRVNFVF9JTVg3IGJ5IGRlZmF1bHQNCj4gDQo+
IFtDQ2luZyBJTVg2IG1haW50YWluZXJzXQ0KPiANCj4gT24gTW9uLCBKdWwgMjAsIDIwMjAgYXQg
MTA6MjI6MDFQTSArMDgwMCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gaS5NWDcgcmVzZXQgZHJp
dmVyIG5vdyBzdXBwb3J0cyBtb2R1bGUgYnVpbGQgYW5kIGl0IGlzIG5vIGxvbmdlciBidWlsdA0K
PiA+IGluIGJ5IGRlZmF1bHQsIHNvIGkuTVggUENJIGRyaXZlciBuZWVkcyB0byBzZWxlY3QgaXQg
ZXhwbGljaXRseSBkdWUgdG8NCj4gPiBpdCBpcyBOT1Qgc3VwcG9ydGluZyBsb2FkYWJsZSBtb2R1
bGUgY3VycmVudGx5Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29u
Lkh1YW5nQG54cC5jb20+DQoNCkknbSBva2F5IHdpdGggdGhpcyBjaGFuZ2UuICBBY2tlZC1ieTog
UmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KVGhhbmtzLg0KQmVzdCBSZWdhcmRz
DQpSaWNoYXJkIFpodQ0KPiA+IC0tLQ0KPiA+IE5vIGNoYW5nZS4NCj4gPiAtLS0NCj4gPiAgZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvS2NvbmZpZyB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9LY29uZmlnDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9LY29u
ZmlnDQo+ID4gaW5kZXggMDQ0YTM3Ni4uYmNmNjNjZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9LY29uZmlnDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvS2NvbmZpZw0KPiA+IEBAIC05MCw2ICs5MCw3IEBAIGNvbmZpZyBQQ0lfRVhZTk9T
DQo+ID4NCj4gPiAgY29uZmlnIFBDSV9JTVg2DQo+ID4gICAgICAgYm9vbCAiRnJlZXNjYWxlIGku
TVg2LzcvOCBQQ0llIGNvbnRyb2xsZXIiDQo+ID4gKyAgICAgc2VsZWN0IFJFU0VUX0lNWDcNCj4g
PiAgICAgICBkZXBlbmRzIG9uIEFSQ0hfTVhDIHx8IENPTVBJTEVfVEVTVA0KPiA+ICAgICAgIGRl
cGVuZHMgb24gUENJX01TSV9JUlFfRE9NQUlODQo+ID4gICAgICAgc2VsZWN0IFBDSUVfRFdfSE9T
VA0KPiA+IC0tDQo+ID4gMi43LjQNCj4gPg0K
