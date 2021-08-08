Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34573E38BA
	for <lists+linux-pci@lfdr.de>; Sun,  8 Aug 2021 06:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhHHEvf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Aug 2021 00:51:35 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53214 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229473AbhHHEve (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Aug 2021 00:51:34 -0400
X-UUID: ed296c640e8441a18092c92cdd410ab9-20210808
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=on/j7cl/N/Jgdgcr6rQkmCI3trvdPC5zQ16Jm736qW8=;
        b=PwCKKSq43DLQuUv6dOyTZTK0+92utlpncEJHOQT+TCzpO3Z8UibAPKNIHI4SXSPWv+544IWl09paZK8gZVbQ4dyZ01X/qpfHL+N8GWn+xLzVMIBJG7nYWeIdGn8Wng+nB3i80cjwTAC8w6S7EGtm7G506f5eJ1sq+xeFCe91Hag=;
X-UUID: ed296c640e8441a18092c92cdd410ab9-20210808
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1168969015; Sun, 08 Aug 2021 12:51:11 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 8 Aug 2021 12:51:10 +0800
Received: from APC01-PU1-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Sun, 8 Aug 2021 12:51:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b83qtqTYp3IIX9wdI2j4zToal+Zxl1e89RzFSRyjjWN1VHkaSDm9PZT+X4sxXyEKl4cEhRlyLPgjQ8tCZuhS/RWNNeisxDQV+SuFTYqRaDc2uMfzxprTrVxVWsMdMxjDUQga3dFRaIf+T19aJjpKX/Tg11OBlJdxepHzlkLXozYQuoTgZj1BuBIA/sbiW1heOsK2NWO3wtKoiEiJfv34m3oNeBHklxvZWZLmTzYDoRfGBCiUs/Up1W5JmSrcBSgtW4c0YqOWTrwzOpd4QNsF9F32C2BPIOJ3MEsGjCxbDjxadHolBYyWF0Y9NtN34xfTgFBToMMxlOcZ7VFrXkbL0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=on/j7cl/N/Jgdgcr6rQkmCI3trvdPC5zQ16Jm736qW8=;
 b=FShclrRfs6SyqwW/5KtjoRX3y2GIwFM20oMXFE0DsxV40sVwhKkRutKAYRoncFOpRtgRfQELBmVPFmuPiRN/kN7GK9lHnPm81jdir8IByF2R13aINmGGzliLwD6/cMQv06hOK1nqWHdK0lSqB/gEcmBjrWMF+HnftKW2n6uepzmEXWgSwr+Tw0lgYIbKsUWLXGb3zNSFH53DudjAtkMxKbTbZDGcEF7C+arxpFQwU9gowBxmvXv/fW6Ri3H+Fstp2Ly7QuuMaalLAoyYhYGK1W/ClyB7ZbB3ElBsZYaInymAnHJTdKv0uE4SBeTr02cqLBPOI4vQvNhlHKaVj0aVNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=on/j7cl/N/Jgdgcr6rQkmCI3trvdPC5zQ16Jm736qW8=;
 b=jUakosgN6Z79sdK6Kw5bjk4AT7G0cxSg7+Cnnfd77lYBBZaUOn66xNwFiGfAIAQP+KvKbGZeUuOmmz3rk/9q+9Dajvvox83lxOJkuiUwPqCSS4mwPc7JS5Raax+YIpugZ+OoE3hPykpZz1yb8w7Dw62c63FFI2es2CHh8QITyEw=
Received: from KL1PR03MB4694.apcprd03.prod.outlook.com (2603:1096:820:12::14)
 by KL1PR03MB5061.apcprd03.prod.outlook.com (2603:1096:820:12::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.7; Sun, 8 Aug
 2021 04:50:57 +0000
Received: from KL1PR03MB4694.apcprd03.prod.outlook.com
 ([fe80::88a8:25ac:66d5:5ec1]) by KL1PR03MB4694.apcprd03.prod.outlook.com
 ([fe80::88a8:25ac:66d5:5ec1%7]) with mapi id 15.20.4415.010; Sun, 8 Aug 2021
 04:50:56 +0000
From:   =?utf-8?B?Q2h1YW5qaWEgTGl1ICjmn7PkvKDlmIkp?= 
        <Chuanjia.Liu@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?Q2h1YW5qaWEgTGl1ICjmn7PkvKDlmIkp?= 
        <Chuanjia.Liu@mediatek.com>,
        "frank-w@public-files.de" <frank-w@public-files.de>,
        =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
        =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        =?utf-8?B?UnlkZXIgTGVlICjmnY7luproq7op?= <Ryder.Lee@mediatek.com>
Subject: Re: [PATCH v11 0/4] PCI: mediatek: Spilt PCIe node to comply with
 hardware design
Thread-Topic: [PATCH v11 0/4] PCI: mediatek: Spilt PCIe node to comply with
 hardware design
Thread-Index: AQHXfHCzjQXqeA7gL0SSIH0AtWQWVqtmVSMAgALT5gA=
Date:   Sun, 8 Aug 2021 04:50:56 +0000
Message-ID: <229da9cfe5b6fa599dd38b4a69128eb1b00dbf60.camel@mediatek.com>
References: <20210719073456.28666-1-chuanjia.liu@mediatek.com>
         <162824274659.11010.3812952145024175369.b4-ty@arm.com>
In-Reply-To: <162824274659.11010.3812952145024175369.b4-ty@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e87278fa-c459-4703-3e2a-08d95a281c3b
x-ms-traffictypediagnostic: KL1PR03MB5061:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <KL1PR03MB5061D157600F0806B289504BE6F59@KL1PR03MB5061.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4jRvjByDOsBsbyFDTq5lzq8pKQOTWQd4H0JtONcE/kDoAlojvUgn5rZh3oMmdmSJihPgYtxvE26OIHxbVlm80m5p8ayJO4HImz0zjh3l49BrIrheY8zBpJavxmKNxmSXBIJ8o0P0GoIXPmaOC+VYZydLiiJvQC10GAZAHGs+JoaPAP+tdB6MBsesANBTOngTUDawQTn9n8xKVSuwdgq8d6bedbnS5VbHNsJgf0FQLbjUr0AqCXPZCR1ASDZFUt2RpwNMREYproN8xCpxd+EpbyEs/n4oCJ+1A6xGUkITCUfR7PbuVY+QBA0Riniw6lN7S9QcRMJJCRx39MH88aJr1I3W8SBWJVlZo/aTHhqxVL7Ja1ntjJozyq9APRm6Q5TbXnm7ES5g3gOUDh4ZOcNtkXf1qruM+sp5aE8mfsR7YCL9vkBFqEyKQT/K0E5UKXLeHlXW2fe68nWBs66QgkJL4poR2FSTNmF4HAqhUrkpeaH2a7u7CIIthcy1U1MfsAKc9p5SIXPWrZwnx/FjWtGnEKdzO7+r4BjFfyxCFtzp6zLVsTvY2emB3x/TAhevCbzmOR7ZwjRjq5axmvgYy7PMNlXzr0h04VqRyJH0CfPFEqBDkTV62FWBOnsmNvxB3ZbcP8s0M+znqlSMN53xLfWqrly/lOclV5QqQf0Ql1H77FMqDHh39JQzBwyJKjFhp/pwtpFYXtD6iKYTPa0f140Gvtgubq2sO/KSrvH1yMdBpM85H7RmOveUo3fa8hVdM5kMAcLPeUiQXeDVfhe6T/1C8Pif8vQ1omXrMj9da85WadoWvLhMWFclcOk5kadUuViQjweS7TR+o4/BWevhZtweJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB4694.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(346002)(136003)(366004)(396003)(376002)(6512007)(4326008)(8936002)(5660300002)(36756003)(6486002)(83380400001)(478600001)(2906002)(8676002)(2616005)(122000001)(38100700002)(6506007)(91956017)(7416002)(316002)(26005)(86362001)(186003)(38070700005)(85182001)(66476007)(66556008)(71200400001)(966005)(76116006)(107886003)(66446008)(66946007)(64756008)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3dOYWIvR2RFZ1hQNVhFd3NmQW9QVFdES2w2YWp3eHZIV3ZtZkJENTBFbCtr?=
 =?utf-8?B?bm44QkIwNGFGSWNRQTEzZXpFRXVlajZla2pYeG1tSncxREt2VW9NNUVrSDBm?=
 =?utf-8?B?amhiVEEvbWtlV3VCSlJ0LzVCSHlvZ2paWWU1b2k0MHFqcFdrTXVLU3dzNGs0?=
 =?utf-8?B?UitXd1ZBKzBneERodG1KYTlhcGs5R1JEbzhoZm9OelVOTTB0SXRraS9odEs3?=
 =?utf-8?B?WlhQeWFKOE14Q2xPS2lxbmhqekZyd2NGR3lHVnI2Nkx2bkkvRys0NS8zL2lE?=
 =?utf-8?B?eUhpODdOSnZGK2p6SE42TS9EVndJMCtTWGx1a01Dc1dXTm1kV3B0cWdXWDlw?=
 =?utf-8?B?RkJZYW4zQytxTTNDVytpMUpycWZsN2JSYXV6bVdlOHRHY2lFM1YrdGxJNTRW?=
 =?utf-8?B?STJ6Ym5pLzBXZGlIanBOWkdpV0hyK1M1cWZabkxrNnJ3dHFqUHB2N05wZHRv?=
 =?utf-8?B?SmRhN3BzaGxGRVJvM3R0THVFT1ByNEp4Q0kyOENMc3BNdDZJSjRsRnRCaWU5?=
 =?utf-8?B?R2V0b1dDOWdDdkVlRkdqeVhtTkpKSFdFZDlxQWNTbkJKN2p2Q3pvZFVBUW5h?=
 =?utf-8?B?RElDTXYyQ3pRR0dySGpGQ1JqaytpRlZER1FlVTN2ZjdnUU96cUVLTTB0M1hR?=
 =?utf-8?B?L3NYNUppWlpub3NDSERoWHJjNFpITzVDYnpvazNlcmkxTlVnYVVuUGF5Ri83?=
 =?utf-8?B?cTZQWUlyTmIwOHBkQ0MxT01iaG40TGFYN1NmMWEwV3VjZXg0WFB1UVFqYkZE?=
 =?utf-8?B?ZnBjOUhYTWdES3VBRC9yeE5YSThXOHQ0RWZ0YklJUDJvaWlrMWdJV0xVSDlH?=
 =?utf-8?B?Z1JVMjlENHU0UWVIVUNocDk3VmhNSGptMFJlVVN1d2VoN0ZTQVdNMHc4amQ1?=
 =?utf-8?B?TDdLaVh4cE5qRFV5OE5rNG5uaUUzTlgzaUpVLzdCZVc4enc5RldVTVhUSXdy?=
 =?utf-8?B?NTgrUWdHWG55NllUa29SODk4UnZxd24yQnFFUzBhT1BmMWFEZlhsZHNtSFhw?=
 =?utf-8?B?WG52SEhLYkVSZElRQWMvdUlsSUE4NXB2OU5xNFJzZVB5YTNoOWVJdmVvSzVX?=
 =?utf-8?B?cHdUZ251YU96THFwd1R1d0tEbnkzakViZjZrajhsQXNSVTVYY1FMWTlTTXRW?=
 =?utf-8?B?dHFtTTdrRE82a2ZUa3FDclVac1R0TFZqbU5ubWhDcUdpWnJvckZsNmQwd0lk?=
 =?utf-8?B?RDEwcHA3WndXT0xPbmdwQTREeXpYamZSNWcxUnFaTWRSb2VxalBEajgvZFh3?=
 =?utf-8?B?MmVlYlB2cHJnenNYSjg0M0VNWWt5NmVOTCtEUSt3UEN0cmZueXVRYnZhc0dD?=
 =?utf-8?B?WTFkbGVOMGVnS09aMlFNUndMdUZVOXNnVlUzRUdEdTFBVytOMU9yZGkvMllh?=
 =?utf-8?B?eGVlaVRaa1FIeUpRSUhWUUhMWFY1ajJMZmZzZDBXeHRmYU85RFFyTmxneU9v?=
 =?utf-8?B?TmJhbmtRRDhaWG9nM2hXTWFQRjNjQUhuTE03Z3VpN2FkMkl4aW5SRWUrOHl0?=
 =?utf-8?B?VDFTV20vVVlTdFlVSGEvRFBVb3loWVRnME9OQlBBY0tXR0tIYWVNbER2TlRG?=
 =?utf-8?B?amg3VS9DejJOYnpzVjlJU0lqUjlDSDNmN1JxczcvaGFyWjUwRjFyN2JiaEJK?=
 =?utf-8?B?WHNkVGs5TVpmVW9xTjdZNjR6cERQT25NSnBvRWNRNU9uZEpyekI2VmYvaUJD?=
 =?utf-8?B?WWVWZlc1dHVYRCtwZWhFdWp5aXVUV0ltVDk5Tk1sS0Rybm1PekFCazdPYnJy?=
 =?utf-8?Q?AdB1edw/UWl7xEQNeQcMVLJHV3u5wfmXo2y2eiu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1064F6C9CDA1254CA99BC6E62FFEC87D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB4694.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e87278fa-c459-4703-3e2a-08d95a281c3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2021 04:50:56.5703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o0CNYE6C/UDGiHoMlLoe5ykJGj3CUxZzv4C/cf3MijDUJ6wpcOHAq4iN7ue0FcTwv9FO8VsADN/6JjIlP+MLQUig0Mu1kbUz6vk0V8dcbsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5061
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDIxLTA4LTA2IGF0IDEwOjM5ICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gTW9uLCAxOSBKdWwgMjAyMSAxNTozNDo1MiArMDgwMCwgQ2h1YW5qaWEgTGl1IHdy
b3RlOg0KPiA+IFRoZXJlIGFyZSB0d28gaW5kZXBlbmRlbnQgUENJZSBjb250cm9sbGVycyBpbiBN
VDI3MTIgYW5kIE1UNzYyMg0KPiA+IHBsYXRmb3JtLg0KPiA+IEVhY2ggb2YgdGhlbSBzaG91bGQg
Y29udGFpbiBhbiBpbmRlcGVuZGVudCBNU0kgZG9tYWluLg0KPiA+IA0KPiA+IEluIG9sZCBkdHMg
YXJjaGl0ZWN0dXJlLCBNU0kgZG9tYWluIHdpbGwgYmUgaW5oZXJpdGVkIGZyb20gdGhlIHJvb3QN
Cj4gPiBicmlkZ2UsDQo+ID4gYW5kIGFsbCBvZiB0aGUgZGV2aWNlcyB3aWxsIHNoYXJlIHRoZSBz
YW1lIE1TSSBkb21haW4uSGVuY2UgdGhhdCwNCj4gPiB0aGUgUENJZSBkZXZpY2VzIHdpbGwgbm90
IHdvcmsgcHJvcGVybHkgaWYgdGhlIGlycSBudW1iZXINCj4gPiB3aGljaCByZXF1aXJlZCBpcyBt
b3JlIHRoYW4gMzIuDQo+ID4gDQo+ID4gWy4uLl0NCj4gDQo+IEFwcGxpZWQgcGF0Y2hlcyAxLTIg
dG8gcGNpL21lZGlhdGVrICh3ZSBkb24ndCBtZXJnZSBkdHMgY2hhbmdlcyksDQo+IHRoYW5rcyEN
Cj4gDQo+IFsxLzJdIGR0LWJpbmRpbmdzOiBQQ0k6IG1lZGlhdGVrOiBVcGRhdGUgdGhlIERldmlj
ZSB0cmVlIGJpbmRpbmdzDQo+ICAgICAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvbHBpZXJhbGlz
aS9wY2kvYy85YzIzMjUxNjQwDQo+IFsyLzJdIFBDSTogbWVkaWF0ZWs6IEFkZCBuZXcgbWV0aG9k
IHRvIGdldCBzaGFyZWQgcGNpZS1jZmcgYmFzZQ0KPiBhZGRyZXNzIGFuZCBwYXJzZSBub2RlDQo+
ICAgICAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvbHBpZXJhbGlzaS9wY2kvYy8zMDJlNTAzZTA4
DQo+IA0KPiBUaGFua3MsDQo+IExvcmVuem8NCg0KSGksIG1hdHRoaWFzDQpDb3VsZCB5b3UgaGVs
cCBhcHBseSBkdHMgY2hhbmdlcyhwYXRjaCAzLTQpPw0KTG9yZW56byBoZWxwZWQgdG8gYXBwbHkg
dGhlIGRyaXZlciBwYXJ0LCBhbmQgZHRzIHBhcnQNCmhvcGVzIHRvIGFwcGx5IHRvZ2V0aGVyLg0K
DQpCZXN0IFJlZ2FyZHMNCg0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXw0KPiBMaW51eC1tZWRpYXRlayBtYWlsaW5nIGxpc3QNCj4gTGludXgtbWVkaWF0
ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW1lZGlhdGVrDQo=
