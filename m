Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52693F1205
	for <lists+linux-pci@lfdr.de>; Thu, 19 Aug 2021 05:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbhHSDlm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Aug 2021 23:41:42 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34330 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236304AbhHSDlj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Aug 2021 23:41:39 -0400
X-UUID: 8c9251a3ac0345898cda4a37495a9df4-20210819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=JdMAIaTAyrLo8OdIMAy2Vm6VWhpzX1SWN4kDufYCH6o=;
        b=etx9Rd9znez8kjW/jsGgngRlxvsUcExsB71eUp36RMHpCSSJpTzam+O7JTIXWJ4y5+Y3WNvfBr+gUyYscj8XtYgfHwF1XGmx4gODZnB4XUzuRhj05zIqpYGRV8Sj3ZjgfmLyu9KQrgDO7o49Wle0dGv3S2emYsQQjsp/yiUQPmo=;
X-UUID: 8c9251a3ac0345898cda4a37495a9df4-20210819
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1081302639; Thu, 19 Aug 2021 11:40:56 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkexhb02.mediatek.inc (172.21.101.103) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 19 Aug 2021 11:40:55 +0800
Received: from APC01-PU1-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 19 Aug 2021 11:40:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7wKX5xiFuHxq+Hr4JYz3Soj0Xs7w0ubjO4fNLwA27IKiTcatB3tsL3N4tPXz0Je7bZAk3LqMeYk3r5cID5i9qgB3apGr+x+thXeHwJKN4HEfw/ysUthLmZpFs0XSqZ2Gjwm1Mt6VG16mNfnNTy9b93aE5eME4ig4bQa9P3trtWSubKAC7aO9yflneG1dACn6VlOpWtqRc1OZIKfnBIwdqc/AysZsEalAdScywenv0xv4+aKnXkjzFd0cQb6zn7KuACEaqsPCnYKqg5e1wrX6RtSPZmT9ekNHScRxAXTf9DGQMjnLfYdGb179pmuG8H0xnWPlrux7T10KckZq8p5sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdMAIaTAyrLo8OdIMAy2Vm6VWhpzX1SWN4kDufYCH6o=;
 b=kyy+ZnRaLUptsll7iY7Wvky3Xt1aHB05Bbzq8H6L2wmJMlT79a8bQwEw98dYX/BYif/VYhWEez43AwMY9AAgwlrTSVrfiqMqZzKwb3Ix3CY74NtINjanDNRPSjkZr4jnn61lCS691D4w5orBG/Xar2KtDgOXa6JTU53KjKGFQBdC1rdGEGa5povjS56mhUhlBz4D//zTtMdZkUbP7ukWnumoh92mhlOHY7DZKhv0JdrCLQcaUj5ICYE1WCx6DsDpv0HVVTvDwvHlJqw/1HBoVw6X8gYZHz7fvrlwIwNwnfFNKWYPr1arlR7QaNRP4nLefFhk+ncLijLaYHSyfaa8SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdMAIaTAyrLo8OdIMAy2Vm6VWhpzX1SWN4kDufYCH6o=;
 b=O200fsILqraFNqUE8ih5iyhje43JHUyk6DHCTDwN/VFF3h7uczhN2MPo0PpfE2mA+NhjrK028+1DeGdTku4+FJ+58xucBN7ODPDDC83qDaLw1l1wVAVw1lpU3Xy0EiCMtCA41UKJXtRTLf8vIW97LAfnPQd/tXqL5PBFrceUxdc=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by PU1PR03MB3239.apcprd03.prod.outlook.com (2603:1096:803:3a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.15; Thu, 19 Aug
 2021 03:40:43 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::81ec:c1c3:4245:786]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::81ec:c1c3:4245:786%8]) with mapi id 15.20.4436.018; Thu, 19 Aug 2021
 03:40:43 +0000
From:   =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?WW91bGluIFBlaSAo6KO05Y+L5p6XKQ==?= 
        <youlin.pei@mediatek.com>,
        "ot_jieyang@mediatek.com" <ot_jieyang@mediatek.com>,
        "drinkcat@chromium.org" <drinkcat@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        =?utf-8?B?Q2h1YW5qaWEgTGl1ICjmn7PkvKDlmIkp?= 
        <Chuanjia.Liu@mediatek.com>,
        =?utf-8?B?Unlhbi1KSCBZdSAo5L2Z5a626LGqKQ==?= 
        <Ryan-JH.Yu@mediatek.com>,
        =?utf-8?B?UWl6aG9uZyBDaGVuZyAo56iL5ZWf5b+gKQ==?= 
        <Qizhong.Cheng@mediatek.com>, "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        =?utf-8?B?UnlkZXIgTGVlICjmnY7luproq7op?= <Ryder.Lee@mediatek.com>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: mediatek-gen3: Add property to
 disable dvfsrc voltage request
Thread-Topic: [PATCH v3 1/2] dt-bindings: PCI: mediatek-gen3: Add property to
 disable dvfsrc voltage request
Thread-Index: AQHXbVqO9CQSKczlFkOxGjtukonEratFcJSAgDUBOYA=
Date:   Thu, 19 Aug 2021 03:40:43 +0000
Message-ID: <dbae65c4e56a7d445905245be9e3f3d3f3b68d89.camel@mediatek.com>
References: <20210630024934.18903-1-jianjun.wang@mediatek.com>
         <20210630024934.18903-2-jianjun.wang@mediatek.com>
         <20210716173333.GA3632722@robh.at.kernel.org>
In-Reply-To: <20210716173333.GA3632722@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b97231a6-3609-4326-4ab7-08d962c31f8f
x-ms-traffictypediagnostic: PU1PR03MB3239:
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1PR03MB3239986F7D34EBA68CD4885CE7C09@PU1PR03MB3239.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3bGpx8vDywIhYKsmiFndQodQizivU5AaRM65/EUV2z+TStdMj4mxw9+UmvT2G4AMyWXkvl80Qmwww1Ap3tKP9gKtUHk/ubvfHqj75wSGsoLuF8RZhuxEgU2vsU9FdLaCVhrWhMoDpamDS9EIFjk7f48C0usEJcijmFV+p2tfa/fno7gQixKkqAinKOuAeJm2cgTchvfrmIveFOQIMpJMEcsaN7ews3efDt+g2HprJsDqtEtyg+FPkmFHTYjv4UxUEsVtdPDIosEIbL/yqTpGjt8nslzkbx62pAbaY5IBxcPzJC6JGfdagqi8saz+FT06VfRG5HqLAniP+aw7RftSBkP7SxYBQC229bjRGnMFEBk/aMNv/hSScxMQWdy0YJizEHNLZYZdw9jsLnczy0s/7j02DvDyllH1R8/PGpJNHjQpw/IEUOHJYsuKzTKPMc5oiuEvjE21WgxwiWZx80GRRoLEYmidHB0Vq0q8ggu3AxJRW4L2V+su/fIgX802W0f7Q4FF7VQb/EiG4LxmvvNty6k2q7xioCClcEaXHUToKW1kpdbC/He/21BJWo4nzuMMucUAZwz2LXnnQNZq4OXb8o95/qgtgClb9apwn0QGqzkWJEPK8uNokZGEnUxJAFW+OY5Q3eZI5OKBWefmwc0x/R22cK86uVcaXhZ+NqEi1BSK8BczwVnxijeFA0xeNNqcg5BU8ICfPnhuC+xjxd66Kt33vKB5l4/fT3g4GoIO1qA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(2616005)(85182001)(8936002)(66946007)(64756008)(66476007)(66446008)(91956017)(186003)(316002)(7416002)(76116006)(6506007)(2906002)(86362001)(26005)(8676002)(107886003)(66556008)(38070700005)(4326008)(36756003)(71200400001)(83380400001)(5660300002)(6486002)(122000001)(54906003)(38100700002)(6916009)(478600001)(6512007)(40753002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjVEWi9DQ1hEVUVxVVR1WG4weHhydytkMzAzYSs4NGdyZEVRVEZZUHZ1VDcr?=
 =?utf-8?B?OTJWUHNMZnlWOWNrWUZkdTNyTGpqVnVzaDVIV2ZuVkZ0N2QwaS9BVk1TOGVh?=
 =?utf-8?B?R0hmejNuaWUwMXVadEgvcGg4OXJqSGtIcUVsZTdwU1I4dEh2QmFJcDZoN3FF?=
 =?utf-8?B?QzdkSnhHTDRCV3JFRkpSQ0RLYmNpRnd6WXJRWE5XcnFJUmsvU094ZHVtNU15?=
 =?utf-8?B?KzRLbWJyUHpnY3o2ZkkzU21BRUI5MkxzZlgvNlowNUxKdTgxbkkzTXlxa3ow?=
 =?utf-8?B?blQzSHhwMFMyNVovUDRFOFdwS1RwRWxjeU1kSFBaTGd2Q1krNFZtVHpYcXNK?=
 =?utf-8?B?RktScFQ2L01mVGRXMGwrTWladmJTa1NQUHNScForVUhOQ3JrUktyUmlYTmNq?=
 =?utf-8?B?MS93ODVIU3RFdW1wRWI5WjY0L3VqY1NmdXlUTUREZnRPN0NVSUZOcEorODho?=
 =?utf-8?B?b1llYjErWlFCVTVyVWFDRXp2TGZ2NUtxSXhuWUFwSVZwS3BzMnRkclRYUWFl?=
 =?utf-8?B?bFJ6a2VOd2FQQUtaTVYxSkwyK2xhd1dGaVJ2TnZYU3I1cXhkSDNLT0FTQTdW?=
 =?utf-8?B?UW9aSXdtRFoxRys0L3dCYWUrOFBFM1k4cHJKczlmV0VGVHlXZGhSNnZ3cGtz?=
 =?utf-8?B?MXhSUVdWZVVDTUdvaUNqZHk4OWdGNjJSYUdkeXQzRTlVRXdIK1lWTlhsUnoz?=
 =?utf-8?B?REgweUZaV0hxanBDeERMVUdIV3ZiQTlsdUtEWmtvMjhYQVVlZ0lLSUJvWnJQ?=
 =?utf-8?B?OUF0THQ2S1AyaHNSSVp1a1RSSFllR2xMbThma0Q0VDhGOWdOcmk3OHZnZlU3?=
 =?utf-8?B?YkUwR1Zpa1ZtTG9URmRpR292WHo4UVZJSDM3c3JPNWgvY00vdTlRUGVMVlg1?=
 =?utf-8?B?SCt0eDVHUHVPOXVuNmZWelZaQ3h4SzRrZGxZaG1DWkZ1WkVYTTFpcmtGMDNU?=
 =?utf-8?B?MWVnb2tKcUc2TUNycXlGOFNwYXRnY2k2bVJlSFJWSVpGTE5xS3RreUc1ekNZ?=
 =?utf-8?B?Vno0MG0zYlM2Y1VMbXRDd3ZBb2I0V1prblZ1VUNLRm4zbFl6MXdhQzM5c1RN?=
 =?utf-8?B?WUVTc29GNFlHMG9yeEtMeSs3TmZRNDFKZ1Z5bVNxZXErSjlLZGtFM0h6UmNw?=
 =?utf-8?B?eFFicVFnaVQ3SXNORnFWa1U5SStvaWpjTFBYN2x3emVVK1dENjBMWUM5a3dj?=
 =?utf-8?B?Z1kva3VlMDhOR0FiRDdXZHBkOEJHN1RYNDZ3ZUxMbGFTT1NEa3pGMVo3c3Bn?=
 =?utf-8?B?ZEYvTzlPb3h2VEJJREw3Q3VsNE5BY0hPczAxSEF4Rm53djE2U0VtbW1VcHdT?=
 =?utf-8?B?VTFkRFY2K2pFVmtZSHRzeE5NTzVMeTJDR2hmTG9uSFZCa0d0c1ZLZ0w2d0lu?=
 =?utf-8?B?Z0t3Tlpyek1mQVgzaFFUVHdtN0NUb2FLQmJoZEx2WTl6MkpMWGNuUTV3QkZO?=
 =?utf-8?B?K1p0VE13SXpBY0Q2RExmckduclFaenFMSFo5YXphQWFMdUwzQVdDSDhnMlhi?=
 =?utf-8?B?VWdLQmh4dGR5bnhGMU5XenVnVmRYdGtSTDBtQ0pzNVJFUnUxVFVlMUZrSG1o?=
 =?utf-8?B?NkdDVWtZeXV0MzNuN1J2QVRWM1ppdDV6MUFuYWQ2OW5rU3dpZ3poODZqTkxr?=
 =?utf-8?B?a1hOajV3UFNuZzhUcStzTm4vRVFuaTcwVWw1ZUNDYnZDZGlkL0ZGcUVGWEt6?=
 =?utf-8?B?NzJVUXYyVGh1QzZ2dWxLOWVIZ0ppVHlIcWgxM2ROTnk3TWlncmQ1S0VJcjdo?=
 =?utf-8?Q?aXHFL5pifkg9srRO437CqkUHSRjChJ84WOnP2BR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65DF2A57EB406D4F8E1AD4A0F9D77802@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97231a6-3609-4326-4ab7-08d962c31f8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 03:40:43.6598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WJ4bHodFZdEbN0c3XQBhgdkMxZtLJ4me9VbIAb4yDHKqvfu4ZvH9icM6Wg0ZHqZ7GAqTc5SFaCsd1PdRVOy+19Hr0R7/5RrA6THJmjfbQp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1PR03MB3239
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDIxLTA3LTE2IGF0IDExOjMzIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gV2VkLCBKdW4gMzAsIDIwMjEgYXQgMTA6NDk6MzNBTSArMDgwMCwgSmlhbmp1biBXYW5nIHdy
b3RlOg0KPiA+IEFkZCBwcm9wZXJ0eSB0byBkaXNhYmxlIGR2ZnNyYyB2b2x0YWdlIHJlcXVlc3Qs
IGlmIHRoaXMgcHJvcGVydHkNCj4gPiBpcyBwcmVzZW50ZWQsIHdlIGFzc3VtZSB0aGF0IHRoZSBy
ZXF1ZXN0ZWQgdm9sdGFnZSBpcyBhbHdheXMNCj4gPiBoaWdoZXIgZW5vdWdoIHRvIGtlZXAgdGhl
IFBDSWUgY29udHJvbGxlciBhY3RpdmUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSmlhbmp1
biBXYW5nIDxqaWFuanVuLndhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vZGV2
aWNldHJlZS9iaW5kaW5ncy9wY2kvbWVkaWF0ZWstcGNpZS1nZW4zLnlhbWwgICAgICAgfCA4DQo+
ID4gKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiA+IA0K
PiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL21l
ZGlhdGVrLXBjaWUtDQo+ID4gZ2VuMy55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLQ0KPiA+IGdlbjMueWFtbA0KPiA+IGluZGV4IGU3YjFm
OTg5MmRhNC4uM2UyNmMwMzJjZWE5IDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9wY2kvbWVkaWF0ZWstcGNpZS1nZW4zLnlhbWwNCj4gPiArKysgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL21lZGlhdGVrLXBjaWUtZ2VuMy55
YW1sDQo+ID4gQEAgLTk2LDYgKzk2LDEyIEBAIHByb3BlcnRpZXM6DQo+ID4gICAgcGh5czoNCj4g
PiAgICAgIG1heEl0ZW1zOiAxDQo+ID4gIA0KPiA+ICsgIGRpc2FibGUtZHZmc3JjLXZsdC1yZXE6
DQo+ID4gKyAgICBkZXNjcmlwdGlvbjogRGlzYWJsZSBkdmZzcmMgdm9sdGFnZSByZXF1ZXN0LCBp
ZiB0aGlzIHByb3BlcnR5DQo+ID4gaXMgcHJlc2VudGVkLA0KPiA+ICsgICAgICB3ZSBhc3N1bWUg
dGhhdCB0aGUgcmVxdWVzdGVkIHZvbHRhZ2UgaXMgYWx3YXlzIGhpZ2hlciBlbm91Z2gNCj4gPiB0
byBrZWVwDQo+ID4gKyAgICAgIHRoZSBQQ0llIGNvbnRyb2xsZXIgYWN0aXZlLg0KPiA+ICsgICAg
dHlwZTogYm9vbGVhbg0KPiBXaGF0IGRldGVybWluZXMgc2V0dGluZyB0aGlzIHByb3BlcnR5PyBD
YW4gaXQgYmUgaW1wbGllZCBieSB0aGUgDQo+IGNvbXBhdGlibGUgKHdoaWNoIHNob3VsZCBiZSBT
b0Mgc3BlY2lmaWMpLg0KPiANCj4gSXMgdGhpcyBwcm9wZXJ0eSBzcGVjaWZpYyB0byBQQ0llIGNv
bnRyb2xsZXI/IA0KPiANCj4gV291bGRuJ3QgdGhlIHJlcXVlc3QgYmUgaGFybWxlc3MgdG8gbWFr
ZSB0aGUgdm9sdGFnZSByZXF1ZXN0IGV2ZW4gaWYNCj4gbm90IA0KPiBuZWVkZWQ/DQo+IA0KPiBJ
IHRoaW5rIHRoaXMgcHJvYmFibHkgc2hvdWxkIGJlIGFkZHJlc3NlZCBpbiBhIGNvbW1vbiB3YXkg
YXMgcGFydCBvZiANCj4gb3RoZXIgUW9TLCBkZXZmcmVxLCBldGMuIHJlcXVpcmVtZW50cyBmb3Ig
ZGV2aWNlcy4NCj4gDQo+IFJvYg0KDQpIaSBSb2IsDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcg
YW5kIHNvcnJ5IGZvciB0aGUgbGF0ZSByZXNwb25zZS4NCg0KV2UgaGF2ZSBpbnRlcm5hbCBkaXNj
dXNzaW9uIGFuZCB3ZSBhZ3JlZSB3aXRoIHRoYXQgdGhpcyBmZWF0dXJlIHNob3VsZA0Kbm90IGJl
IHNwZWNpZmljIHRvIHRoZSBQQ0llIGNvbnRyb2xsZXIsIHdlIG5lZWQgdG8gZmluZCBhIGNvbW1v
biB3YXkgdG8NCmRvIHRoaXMuIA0KDQpCdXQgYXMgdGhlIGRyaXZlciBvZiBkdmZzcmMgaXMgbm90
IGZpbmlzaGVkIHRoZSB1cHN0cmVhbSwgd2UgZG9uJ3QgaGF2ZQ0KYSBiZXR0ZXIgc29sdXRpb24g
Zm9yIG5vdywgc28gd2Ugd291bGQgbGlrZSB0byBwdWxsIGJhY2sgdGhpcyBwYXRjaCBhbmQNCndp
bGwgc2VuZCBhbm90aGVyIHBhdGNoIHRvIGRpc2FibGUgZHZmc3JjIGJ5IGRlZmF1bHQgdW50aWwg
d2UgZmluZCBhDQpjb21tb24gc29sdXRpb24gdG8gZW5hYmxlIGl0Lg0KDQpUaGFua3MuDQoNCg==
