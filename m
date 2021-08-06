Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA78D3E2436
	for <lists+linux-pci@lfdr.de>; Fri,  6 Aug 2021 09:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbhHFHiF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Aug 2021 03:38:05 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:46150 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230127AbhHFHiF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Aug 2021 03:38:05 -0400
X-UUID: 67a883dd59844e399312e76cac250ee5-20210806
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ILOMPyu0YEEHgDd130atu/c9ysAc7YoKhZnNBYEu6kw=;
        b=Bp+4r9bfJ0KBVJ1emSDOJGuEm8vJ0gWzeUL3VBdndG2cRm7fXW8I6096tuMrOTGjaM6v1kKKn+X3nH84RbWSjCEZW5l4WLxTqbh74HLajtF1z6PYWHqO2Zh3Rgd09nCVB9Qq90v4Obkf9RNrQ5ijUFXJ625QixOg1+0CRJGVXlE=;
X-UUID: 67a883dd59844e399312e76cac250ee5-20210806
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 316054315; Fri, 06 Aug 2021 15:37:45 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 6 Aug 2021 15:37:44 +0800
Received: from APC01-HK2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 6 Aug 2021 15:37:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecGqHYL+o3NB/sBmLiKFBm5sq7T6Xz0UWx53mxXPeF3VNvM3Fzgn6BL/1+HQ4ECDaTD4agMMMC5KxrprWLzGWKqEphsWi2B1J0ix6c4eG93I3goGhioTQE423xEvqQEAHtTmqAbfXT0CCAFMY15MZmunS1bbHAIhZLl1GJPbYbnt0T2HoJlDVlgSBTGJNXCXScHYEP/No0es8avb80faFVQKAhcS+Qx9hEG40Y+jB9iLgdN8wEv6CNVgejdpRuYvZ7ACI1E/rSQiRmksv7teEtg7gl9MhYFWYwD4On1zsIkGVBHP0Tz657FvodvQdQ5iYVh4wmv3MXGP4AGEXXIg5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILOMPyu0YEEHgDd130atu/c9ysAc7YoKhZnNBYEu6kw=;
 b=ZHJWez4LdTlCv4bm6HpDKx7L+EX4f8nqISV72z4sKHsGuYpBy+/jC4XF/Z0OJ0wirox7PJzWSeY0aezeRC0eYC9TXUcr9RIFGRVf70ENMPfnouNHuysc+sP8D/tBCcKompKb87HyDL1FSS8oIwWu3Hp6/psQ3xaaJKNGHVI3twX94I0A6t6ozeILpJYHVHiHoOOjJLdeuSe4YgnYbzqRRdJVwugNbWYRDiIge+SEUqZxtq5JclCcFUKb167Hr3ZZZNfRKeyOuF3p/7FNSUQki7ki+RzrNv4lrWn/Uzv0D/TDMoIK3WXu5vMs58dv7D80RgEWiWSMxRw4D/MidIiFrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILOMPyu0YEEHgDd130atu/c9ysAc7YoKhZnNBYEu6kw=;
 b=GPlCjUeGLsxeQJaxupMar1QaQPdhYc3kD71BVwKfORadGyf9Cb+RRn3UeAgsS9T8N4LQ0K5jz+J4QIJARE3fba3pre2dHeAo7gn3GCeLLIr91tifUhxcYw//6YiMzJ7TPGegAU123comyGvr3EHTgSf7wu3EK1bB9B6BAVeorDc=
Received: from KL1PR03MB4694.apcprd03.prod.outlook.com (2603:1096:820:12::14)
 by KL1PR03MB5093.apcprd03.prod.outlook.com (2603:1096:820:1a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.14; Fri, 6 Aug
 2021 07:37:33 +0000
Received: from KL1PR03MB4694.apcprd03.prod.outlook.com
 ([fe80::88a8:25ac:66d5:5ec1]) by KL1PR03MB4694.apcprd03.prod.outlook.com
 ([fe80::88a8:25ac:66d5:5ec1%7]) with mapi id 15.20.4415.007; Fri, 6 Aug 2021
 07:37:33 +0000
From:   =?utf-8?B?Q2h1YW5qaWEgTGl1ICjmn7PkvKDlmIkp?= 
        <Chuanjia.Liu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        =?utf-8?B?Q2h1YW5qaWEgTGl1ICjmn7PkvKDlmIkp?= 
        <Chuanjia.Liu@mediatek.com>,
        "frank-w@public-files.de" <frank-w@public-files.de>,
        =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
        =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        =?utf-8?B?UnlkZXIgTGVlICjmnY7luproq7op?= <Ryder.Lee@mediatek.com>
Subject: Re: [PATCH v11 2/4] PCI: mediatek: Add new method to get shared
 pcie-cfg base address and parse node
Thread-Topic: [PATCH v11 2/4] PCI: mediatek: Add new method to get shared
 pcie-cfg base address and parse node
Thread-Index: AQHXfHE58Vwso+DZ00iND05GAYdwVqtLLasAgBdEUYCAA8D2AA==
Date:   Fri, 6 Aug 2021 07:37:33 +0000
Message-ID: <2db708627db9a0005089f081f8b83859e33509c7.camel@mediatek.com>
References: <20210719073456.28666-1-chuanjia.liu@mediatek.com>
         <20210719073456.28666-3-chuanjia.liu@mediatek.com>
         <1626749978.2466.14.camel@mhfsdcap03>
         <CAL_Jsq+DcNe8jVqisHXt3jQHeJAoLKmiah7o8ePVKra5OvAbGA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+DcNe8jVqisHXt3jQHeJAoLKmiah7o8ePVKra5OvAbGA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bccb9943-9f1e-410b-b030-08d958ad0dbb
x-ms-traffictypediagnostic: KL1PR03MB5093:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <KL1PR03MB5093611F82E23EAEAD34E78CE6F39@KL1PR03MB5093.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U37esbJcIYElVcq+emnHtJsISJ8o2tQ1RDXhqkC/VYrcFVWsCydZan8y5SQAG+1JTpqzi9Ox0+UjfX5ISsZaLpLe6UpikTdj6vhX46uLf0Qk2arkacL9ZefHyRvOzy5wxZD3nnG+esQRylhhRAvHdCGhanmJOFM4vkuwzyryxQRAck9las0zeC3v+IbufIwkWgQYSNiY2xv2RrvC56lY64baOeARr4LPMhTFub2PkVm4WnmTZrFXWA5KgOfAYYjhLEoI2rFBABMZucvy2tKBw1/9/R9BdbZG62U6t/0Vn0LEq43OgHdHiSx6CtE2j48DFJ4n7mnx6fGD/Fkn+gEfNICuDmrPSzFCxMXRdxo83qF/bKHsodw0Vl+r/blAX0HLo6YARUBIyqqRRwyQBTx+ZWba2kNrnsCNGhoO4CRnfV6nd+g85iwTCUbJS+8zhIY2W4lznScFWX8ZKmx13vqYMnsUifm859ty5es7p43niHmzcr3mfQ8jtMHNok9WDShpNxw/MqMlunAKHUrdDii8/K84d6W/aNx6oR/dr+A6gvK6etdvYQtoHnVX1UJRsl+XdUf1cQg7iGWYLvX4r9svnuENUGj/d4vMnaiHQ+VLYGIxWZB78GZXYK7F4i7g4rqnlTkbTj7EkEDiobvnHybY7anwO3xB3gklXjLtp7Vqsv6KXM1kCxjCjGQ3LmiBLv0avsklzZAa0qetNYQbpdClBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB4694.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(396003)(346002)(39860400002)(36756003)(86362001)(2616005)(107886003)(6512007)(6486002)(7416002)(83380400001)(122000001)(4326008)(26005)(38100700002)(54906003)(5660300002)(186003)(53546011)(6506007)(71200400001)(316002)(38070700005)(91956017)(2906002)(66946007)(478600001)(8936002)(66556008)(64756008)(66446008)(8676002)(85182001)(66476007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YklCWjF5NVNscXZsQk5IQ29vNEhIa0dvQm95bm1nenp1S1kzc1JGSkZLZjVv?=
 =?utf-8?B?amVsYkZWZ0ZrVWwzRWxqNFlXTldEOGgwUW55RldveS82d2RLMDdWcFJzSjY4?=
 =?utf-8?B?MFBucXFVWjZmSkVMcmtSRFpkWjRVbnRydWQ3bXZBcUVvdCtWdHJob1hCWHNn?=
 =?utf-8?B?ZlJHZy9UdzI0Y2FteDFoeW5UaWpiVmJycUloalc4NGNDa1gyUjVHMWpZNzIz?=
 =?utf-8?B?Q0xpU2hrRGl3a00wbWx3WUI0T1l3c3BxbUhRSmE2MHlrRDlHL1VhMCsyU3Fi?=
 =?utf-8?B?ZUNLcTVZbG14R21BaXVjbjZpWURVa2FJRE14YkMxYzRaSWx1R2NwbmQzMmpt?=
 =?utf-8?B?bmxidzdtZklOOFU2SjNGWGV3STBXSUlSR256ZWhTdDFoTUJ5b044SzJaRldY?=
 =?utf-8?B?dnFtS2g5NHJ3bXpIUk4ySWhPN1A1Q1UrTG9uVWlDVFQrNEVLdFVSekxFVklO?=
 =?utf-8?B?Mkl2T3BBY0F5dkEvZm13OVVLbEhlOUZvMzY0Y055M2xMWHQvYURrQVE2SEVj?=
 =?utf-8?B?QVdvZWc4c2t1eGZnQmptb3dMQWw0K3pjdDNVSFVXZy9zbTducmtjUXBPdGxx?=
 =?utf-8?B?bHZnbjQ5Mm13VHd2QmxMTWJRRDNTSUV1QUh0elFEYTV3TzVZWUtmblFwNjlu?=
 =?utf-8?B?L0tSVEg1NU4welhndDJlMjl2KzdMZEZMWk5WRjl3S2JjTThYVHQrZXhGOHl3?=
 =?utf-8?B?b05EWjZQWVRzOXN3UFp3ZDhYLzM0V1QxckxKVXRsSUErRmRCYm1pV2JJdkVo?=
 =?utf-8?B?a2luRnAzNGN2QUMzaVRQQlBIbHp5c0I5N3JGZ2lWUll2d3BObDdFQW9hSi8r?=
 =?utf-8?B?SXBnN3dxVFRjOUpqTHdBK0dJQStCMitRRXJtNEF2MWJ5cDRJVEgxVS96Y1pk?=
 =?utf-8?B?d2g5V1NOZ1pxTUpwUFRkK29qaWhybSttTjdWUGxHTkZpL0ZKcGE1SkpyMzZn?=
 =?utf-8?B?bm1XTit2Q3FBcUMwS3JHaGU3T1k3a0U1OFdlaVdVWTlhVkdFSlZKYW9YOWNR?=
 =?utf-8?B?WXJQWmJKaVpSRTZ1b0NHVWwrMWowNXYyRmxpRElRU3F5Z0x1ZHQ2RDFTd1Nv?=
 =?utf-8?B?dGp4VDBFZk12UThVRlRzZ0lXS2lvTmZlUC82UDF4ekRmSmFVNnNySnoxKzJ5?=
 =?utf-8?B?Zlh6T3Z5WWcwQ0RxeG5PVkQ2NzRPVTRyL0tqN09IaHowRVh6NXZ2SkF5L0VX?=
 =?utf-8?B?MWRrK0o4R1ZZZkJzbzZTZCtTc210RndZMHRRc09Xd0Y5dWk4MWJseDJTSUhH?=
 =?utf-8?B?MUk2aUt3OFFUaFEzSE9VNGJJZlAyZWRKa05qQUNkUFZHZ0ZmbmNyMVZobkIy?=
 =?utf-8?B?eEJpR252QlpqK2JodDJzdjNtTDVBYTVXK3hlUkNXQU1uUnR4RFJzQ2owM1Zt?=
 =?utf-8?B?RWNHL09VdkNQSGZ2cHkzUnRGZmgxNHViT1JValZxbk1RVFQwTW9lZjZKdkYy?=
 =?utf-8?B?LzVhK0FvQXZsU3VyK1UvckZJZ2w0MS9Ya3dEMUdQL3ZRc084T3RBMXF3S01s?=
 =?utf-8?B?QnJTeVR0MzJIYm1GOCtxbGZQb1dnNDl5R3RndlEvR3VYblRkcXg0d2JmVUVr?=
 =?utf-8?B?aFBjNXljdXFYa3R2ZHFDUmJ1QUhZSGhqRWQwTnU5Rmt3ellIQmVVaS9lek01?=
 =?utf-8?B?eGNaSTczZmp1QXhNSVZZcVY1UXEwU242amsyemhJeW40eXNsWnp3YmNQMHc1?=
 =?utf-8?B?TmZTODA0YUxKUGExdTQ5cDFCeFkyblN5UHBZMXh3MmdJNVJBWjRQVDFkNUhL?=
 =?utf-8?Q?22pEf0D1CVQWLIgcAgcR/PYPZFPjs36TG3hYbza?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22B226733A904F42A0D15928A931DFC2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB4694.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bccb9943-9f1e-410b-b030-08d958ad0dbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2021 07:37:33.0917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OQHjl+tbpwRNurjmBYzJ9Ba9sqvVua8y8TKU/FwkDniUSbzWrueUdDCVxuds+W1e/Aobn5Lu4A4ENlbs0GsTp91K4BwiGDt2I/drPmNzgkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5093
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIxLTA4LTAzIGF0IDE2OjE4IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gTW9uLCBKdWwgMTksIDIwMjEgYXQgODo1OSBQTSBDaHVhbmppYSBMaXUgPA0KPiBjaHVhbmpp
YS5saXVAbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBNb24sIDIwMjEtMDctMTkg
YXQgMTU6MzQgKzA4MDAsIENodWFuamlhIExpdSB3cm90ZToNCj4gPiA+IEZvciB0aGUgbmV3IGR0
cyBmb3JtYXQsIGFkZCBhIG5ldyBtZXRob2QgdG8gZ2V0DQo+ID4gPiBzaGFyZWQgcGNpZS1jZmcg
YmFzZSBhZGRyZXNzIGFuZCBwYXJzZSBub2RlLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBDaHVhbmppYSBMaXUgPGNodWFuamlhLmxpdUBtZWRpYXRlay5jb20+DQo+ID4gPiBBY2tlZC1i
eTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAg
ZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLmMgfCA1MiArKysrKysrKysrKysr
KysrKysrLQ0KPiA+ID4gLS0tLS0tDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDM5IGluc2VydGlv
bnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLmMNCj4gPiA+IGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9wY2llLW1lZGlhdGVrLmMNCj4gPiA+IGluZGV4IDI1YmVlNjkzODM0Zi4uOTI4ZTA5
ODNhOTAwIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1l
ZGlhdGVrLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRl
ay5jDQo+ID4gPiBAQCAtMTQsNiArMTQsNyBAQA0KPiA+ID4gICNpbmNsdWRlIDxsaW51eC9pcnFj
aGlwL2NoYWluZWRfaXJxLmg+DQo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L2lycWRvbWFpbi5oPg0K
PiA+ID4gICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCj4gPiA+ICsjaW5jbHVkZSA8bGludXgv
bWZkL3N5c2Nvbi5oPg0KPiA+ID4gICNpbmNsdWRlIDxsaW51eC9tc2kuaD4NCj4gPiA+ICAjaW5j
bHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L29mX2FkZHJlc3Mu
aD4NCj4gPiA+IEBAIC0yMyw2ICsyNCw3IEBADQo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L3BoeS9w
aHkuaD4NCj4gPiA+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ID4gPiAg
I2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gPiA+ICsjaW5jbHVkZSA8bGludXgvcmVn
bWFwLmg+DQo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L3Jlc2V0Lmg+DQo+ID4gPiANCj4gPiA+ICAj
aW5jbHVkZSAiLi4vcGNpLmgiDQo+ID4gPiBAQCAtMjA3LDYgKzIwOSw3IEBAIHN0cnVjdCBtdGtf
cGNpZV9wb3J0IHsNCj4gPiA+ICAgKiBzdHJ1Y3QgbXRrX3BjaWUgLSBQQ0llIGhvc3QgaW5mb3Jt
YXRpb24NCj4gPiA+ICAgKiBAZGV2OiBwb2ludGVyIHRvIFBDSWUgZGV2aWNlDQo+ID4gPiAgICog
QGJhc2U6IElPIG1hcHBlZCByZWdpc3RlciBiYXNlDQo+ID4gPiArICogQGNmZzogSU8gbWFwcGVk
IHJlZ2lzdGVyIG1hcCBmb3IgUENJZSBjb25maWcNCj4gPiA+ICAgKiBAZnJlZV9jazogZnJlZS1y
dW4gcmVmZXJlbmNlIGNsb2NrDQo+ID4gPiAgICogQG1lbTogbm9uLXByZWZldGNoYWJsZSBtZW1v
cnkgcmVzb3VyY2UNCj4gPiA+ICAgKiBAcG9ydHM6IHBvaW50ZXIgdG8gUENJZSBwb3J0IGluZm9y
bWF0aW9uDQo+ID4gPiBAQCAtMjE1LDYgKzIxOCw3IEBAIHN0cnVjdCBtdGtfcGNpZV9wb3J0IHsN
Cj4gPiA+ICBzdHJ1Y3QgbXRrX3BjaWUgew0KPiA+ID4gICAgICAgc3RydWN0IGRldmljZSAqZGV2
Ow0KPiA+ID4gICAgICAgdm9pZCBfX2lvbWVtICpiYXNlOw0KPiA+ID4gKyAgICAgc3RydWN0IHJl
Z21hcCAqY2ZnOw0KPiA+ID4gICAgICAgc3RydWN0IGNsayAqZnJlZV9jazsNCj4gPiA+IA0KPiA+
ID4gICAgICAgc3RydWN0IGxpc3RfaGVhZCBwb3J0czsNCj4gPiA+IEBAIC02NTAsNyArNjU0LDEx
IEBAIHN0YXRpYyBpbnQgbXRrX3BjaWVfc2V0dXBfaXJxKHN0cnVjdA0KPiA+ID4gbXRrX3BjaWVf
cG9ydCAqcG9ydCwNCj4gPiA+ICAgICAgICAgICAgICAgcmV0dXJuIGVycjsNCj4gPiA+ICAgICAg
IH0NCj4gPiA+IA0KPiA+ID4gLSAgICAgcG9ydC0+aXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2
LCBwb3J0LT5zbG90KTsNCj4gPiA+ICsgICAgIGlmIChvZl9maW5kX3Byb3BlcnR5KGRldi0+b2Zf
bm9kZSwgImludGVycnVwdC1uYW1lcyIsDQo+ID4gPiBOVUxMKSkNCj4gPiA+ICsgICAgICAgICAg
ICAgcG9ydC0+aXJxID0gcGxhdGZvcm1fZ2V0X2lycV9ieW5hbWUocGRldiwNCj4gPiA+ICJwY2ll
X2lycSIpOw0KPiA+ID4gKyAgICAgZWxzZQ0KPiA+ID4gKyAgICAgICAgICAgICBwb3J0LT5pcnEg
PSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIHBvcnQtPnNsb3QpOw0KPiA+ID4gKw0KPiA+ID4gICAg
ICAgaWYgKHBvcnQtPmlycSA8IDApDQo+ID4gPiAgICAgICAgICAgICAgIHJldHVybiBwb3J0LT5p
cnE7DQo+ID4gPiANCj4gPiA+IEBAIC02ODIsNiArNjkwLDEwIEBAIHN0YXRpYyBpbnQgbXRrX3Bj
aWVfc3RhcnR1cF9wb3J0X3YyKHN0cnVjdA0KPiA+ID4gbXRrX3BjaWVfcG9ydCAqcG9ydCkNCj4g
PiA+ICAgICAgICAgICAgICAgdmFsIHw9IFBDSUVfQ1NSX0xUU1NNX0VOKHBvcnQtPnNsb3QpIHwN
Cj4gPiA+ICAgICAgICAgICAgICAgICAgICAgIFBDSUVfQ1NSX0FTUE1fTDFfRU4ocG9ydC0+c2xv
dCk7DQo+ID4gPiAgICAgICAgICAgICAgIHdyaXRlbCh2YWwsIHBjaWUtPmJhc2UgKyBQQ0lFX1NZ
U19DRkdfVjIpOw0KPiA+ID4gKyAgICAgfSBlbHNlIGlmIChwY2llLT5jZmcpIHsNCj4gPiA+ICsg
ICAgICAgICAgICAgdmFsID0gUENJRV9DU1JfTFRTU01fRU4ocG9ydC0+c2xvdCkgfA0KPiA+ID4g
KyAgICAgICAgICAgICAgICAgICBQQ0lFX0NTUl9BU1BNX0wxX0VOKHBvcnQtPnNsb3QpOw0KPiA+
ID4gKyAgICAgICAgICAgICByZWdtYXBfdXBkYXRlX2JpdHMocGNpZS0+Y2ZnLCBQQ0lFX1NZU19D
RkdfVjIsIHZhbCwNCj4gPiA+IHZhbCk7DQo+ID4gPiAgICAgICB9DQo+ID4gPiANCj4gPiA+ICAg
ICAgIC8qIEFzc2VydCBhbGwgcmVzZXQgc2lnbmFscyAqLw0KPiA+ID4gQEAgLTk4NSw2ICs5OTcs
NyBAQCBzdGF0aWMgaW50IG10a19wY2llX3N1YnN5c19wb3dlcnVwKHN0cnVjdA0KPiA+ID4gbXRr
X3BjaWUgKnBjaWUpDQo+ID4gPiAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSBwY2llLT5kZXY7
DQo+ID4gPiAgICAgICBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2ID0gdG9fcGxhdGZvcm1f
ZGV2aWNlKGRldik7DQo+ID4gPiAgICAgICBzdHJ1Y3QgcmVzb3VyY2UgKnJlZ3M7DQo+ID4gPiAr
ICAgICBzdHJ1Y3QgZGV2aWNlX25vZGUgKmNmZ19ub2RlOw0KPiA+ID4gICAgICAgaW50IGVycjsN
Cj4gPiA+IA0KPiA+ID4gICAgICAgLyogZ2V0IHNoYXJlZCByZWdpc3RlcnMsIHdoaWNoIGFyZSBv
cHRpb25hbCAqLw0KPiA+ID4gQEAgLTk5NSw2ICsxMDA4LDE0IEBAIHN0YXRpYyBpbnQgbXRrX3Bj
aWVfc3Vic3lzX3Bvd2VydXAoc3RydWN0DQo+ID4gPiBtdGtfcGNpZSAqcGNpZSkNCj4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihwY2llLT5iYXNlKTsNCj4gPiA+ICAg
ICAgIH0NCj4gPiA+IA0KPiA+ID4gKyAgICAgY2ZnX25vZGUgPSBvZl9maW5kX2NvbXBhdGlibGVf
bm9kZShOVUxMLCBOVUxMLA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAibWVkaWF0ZWssZ2VuZXJpYy0NCj4gPiA+IHBjaWVjZmciKTsNCj4gPiA+ICsgICAg
IGlmIChjZmdfbm9kZSkgew0KPiA+ID4gKyAgICAgICAgICAgICBwY2llLT5jZmcgPSBzeXNjb25f
bm9kZV90b19yZWdtYXAoY2ZnX25vZGUpOw0KPiA+ID4gKyAgICAgICAgICAgICBpZiAoSVNfRVJS
KHBjaWUtPmNmZykpDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIo
cGNpZS0+Y2ZnKTsNCj4gPiA+ICsgICAgIH0NCj4gPiA+ICsNCj4gPiA+ICAgICAgIHBjaWUtPmZy
ZWVfY2sgPSBkZXZtX2Nsa19nZXQoZGV2LCAiZnJlZV9jayIpOw0KPiA+ID4gICAgICAgaWYgKElT
X0VSUihwY2llLT5mcmVlX2NrKSkgew0KPiA+ID4gICAgICAgICAgICAgICBpZiAoUFRSX0VSUihw
Y2llLT5mcmVlX2NrKSA9PSAtRVBST0JFX0RFRkVSKQ0KPiA+ID4gQEAgLTEwMjcsMjIgKzEwNDgs
MjcgQEAgc3RhdGljIGludCBtdGtfcGNpZV9zZXR1cChzdHJ1Y3QgbXRrX3BjaWUNCj4gPiA+ICpw
Y2llKQ0KPiA+ID4gICAgICAgc3RydWN0IGRldmljZSAqZGV2ID0gcGNpZS0+ZGV2Ow0KPiA+ID4g
ICAgICAgc3RydWN0IGRldmljZV9ub2RlICpub2RlID0gZGV2LT5vZl9ub2RlLCAqY2hpbGQ7DQo+
ID4gPiAgICAgICBzdHJ1Y3QgbXRrX3BjaWVfcG9ydCAqcG9ydCwgKnRtcDsNCj4gPiA+IC0gICAg
IGludCBlcnI7DQo+ID4gPiArICAgICBpbnQgZXJyLCBzbG90Ow0KPiA+ID4gKw0KPiA+ID4gKyAg
ICAgc2xvdCA9IG9mX2dldF9wY2lfZG9tYWluX25yKGRldi0+b2Zfbm9kZSk7DQo+ID4gPiArICAg
ICBpZiAoc2xvdCA8IDApIHsNCj4gPiA+ICsgICAgICAgICAgICAgZm9yX2VhY2hfYXZhaWxhYmxl
X2NoaWxkX29mX25vZGUobm9kZSwgY2hpbGQpIHsNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAg
ICBlcnIgPSBvZl9wY2lfZ2V0X2RldmZuKGNoaWxkKTsNCj4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgICBpZiAoZXJyIDwgMCkgew0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ZGV2X2VycihkZXYsICJmYWlsZWQgdG8gZ2V0IGRldmZuOg0KPiA+ID4gJWRcbiIsIGVycik7DQo+
ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycm9yX3B1dF9ub2RlOw0K
PiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIH0NCj4gPiA+IA0KPiA+ID4gLSAgICAgZm9yX2Vh
Y2hfYXZhaWxhYmxlX2NoaWxkX29mX25vZGUobm9kZSwgY2hpbGQpIHsNCj4gPiA+IC0gICAgICAg
ICAgICAgaW50IHNsb3Q7DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgc2xvdCA9IFBDSV9T
TE9UKGVycik7DQo+ID4gPiANCj4gPiA+IC0gICAgICAgICAgICAgZXJyID0gb2ZfcGNpX2dldF9k
ZXZmbihjaGlsZCk7DQo+ID4gPiAtICAgICAgICAgICAgIGlmIChlcnIgPCAwKSB7DQo+ID4gPiAt
ICAgICAgICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICJmYWlsZWQgdG8gcGFyc2UgZGV2Zm46
ICVkXG4iLA0KPiA+ID4gZXJyKTsNCj4gPiA+IC0gICAgICAgICAgICAgICAgICAgICBnb3RvIGVy
cm9yX3B1dF9ub2RlOw0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIGVyciA9IG10a19wY2ll
X3BhcnNlX3BvcnQocGNpZSwgY2hpbGQsDQo+ID4gPiBzbG90KTsNCj4gPiA+ICsgICAgICAgICAg
ICAgICAgICAgICBpZiAoZXJyKQ0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Z290byBlcnJvcl9wdXRfbm9kZTsNCj4gPiA+ICAgICAgICAgICAgICAgfQ0KPiA+ID4gLQ0KPiA+
ID4gLSAgICAgICAgICAgICBzbG90ID0gUENJX1NMT1QoZXJyKTsNCj4gPiA+IC0NCj4gPiA+IC0g
ICAgICAgICAgICAgZXJyID0gbXRrX3BjaWVfcGFyc2VfcG9ydChwY2llLCBjaGlsZCwgc2xvdCk7
DQo+ID4gPiArICAgICB9IGVsc2Ugew0KPiA+ID4gKyAgICAgICAgICAgICBlcnIgPSBtdGtfcGNp
ZV9wYXJzZV9wb3J0KHBjaWUsIG5vZGUsIHNsb3QpOw0KPiA+ID4gICAgICAgICAgICAgICBpZiAo
ZXJyKQ0KPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyb3JfcHV0X25vZGU7DQo+
ID4gPiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGVycjsNCj4gPiANCj4gPiBIae+8jFJv
Yg0KPiA+IEkgY2hhbmdlZCB0aGlzIGluIHRoZSB2OSB2ZXJzaW9uOg0KPiA+IFdoZW4gdGhlIG5l
dyBkdHMgZm9ybWF0IGlzIHVzZWQsIG9mX25vZGVfZ2V0KCkgaXMgbm90IGNhbGxlZC4NCj4gPiBT
byB3aGVuIG10a19wY2llX3BhcnNlX3BvcnQgZmFpbHMsIG9mX25vZGVfcHV0IGRvbid0IG5lZWQg
dG8gYmUNCj4gPiBjYWxsZWQuDQo+ID4gaWYgeW91IHN0aWxsIG9rIGZvciB0aGlzLCBJIHdpbGwg
YWRkIFItYiBpbiBuZXh0IHZlcnNpb24uDQo+IA0KPiBZZXMsIGFuZCB0aGF0J3Mgc21hbGwgZW5v
dWdoIGNoYW5nZSB0byBrZWVwIG15IFItYi4NCj4gDQo+IFJvYg0KDQpIaSwgUm9iDQpUaGFua3Mg
Zm9yIHlvdXIgcmV2aWV3Lg0KDQpIaSBsb3JlbnpvDQpJZiB0aGVyZSBhcmUgbm8gbW9yZSBjb21t
ZW50cywgY2FuIHRoaXMgc2VyaWVzIGJlIG1lcmdlZD8NCg0KQmVzdCBSZWdhcmRzDQo=
