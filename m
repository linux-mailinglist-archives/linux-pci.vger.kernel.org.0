Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B943FE7A7
	for <lists+linux-pci@lfdr.de>; Thu,  2 Sep 2021 04:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhIBCai (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Sep 2021 22:30:38 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:55310 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229679AbhIBCah (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Sep 2021 22:30:37 -0400
X-UUID: f7e8ecf1b694455ba2b9bc49d4f308f8-20210902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=l9m4mH6MPvkN+dFZbbWLaK9jVYGaGMxH1L1Pqsj37WY=;
        b=BeEFE3fIMeEJ9NEKvC2o1GQ24rlGxwJna6t0xPzWeQbIgghnrHI///5s+qf1/zOiS1H93JxCtnANeFlcASH1q1QiOIbZoWlBNw/LEaqDji1Z5eKoz/Eyc1OX7brHFtHi7cxo2Ij8WrsyXLHsPTajldCgzsrI3QDaiuaohQqe74U=;
X-UUID: f7e8ecf1b694455ba2b9bc49d4f308f8-20210902
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 517543634; Thu, 02 Sep 2021 10:29:36 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 2 Sep 2021 10:29:35 +0800
Received: from APC01-PU1-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 2 Sep 2021 10:29:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAxCQTwRwqxWm1KZ+8+l/LaKv87QK29adZbPE6aFCvczGULdUWu6/IcOJGOKr82wXCfAyK3lrBvcSjwoAuzNTHkeTKN1ERt+HLChuT7gRv6QpLiPn98WhERX9lxX5pmleAuoF6Gb5KaJUd+APDWz8FY/nXZlEzKn+SVG370QmDi9YaiKScbLnIlXNz9n2H4k5ATtTMXaeJGM7gm/2bFYoIr4hiZiZaF5kak0ZMmtySS3AnfqVtEPmsv/tJYrCVDO02KweWxKELiK497S74as6yVbwLOVOdTmwCVu1UZT9clQA8pfnffIE0aJczJ0XMP97bKC1cELViBmI8C15oo+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=l9m4mH6MPvkN+dFZbbWLaK9jVYGaGMxH1L1Pqsj37WY=;
 b=WGmlzjZHVcDdymHsSPxUTY1YCsZ0sHgwU190hGBzaFxkoX5kegIOp5FQBWciZ8v9ffgKZwtUVe/Xn8DOLPHAyTbjG1si4JWYbwK9ff3yhrcAAOpJCN0czBNPqGVbRlV5pU6gcyvG5ZrqVU1pL8Ounh1oAAHvKYycNCjacubdeEC5it1NonAYVRM78RgQFKeNNCo5fIf0OuSUGL3qYzIMqF7WAZdbe78CcnBDPKKtOBqc7vAuGVDcJgOfdG9GRacf7ooxAUhe2wGsxu/RY/aAJf4q89+VVFGCS4MTmE5eJzccMfNauCFyLurSY2tfX0zrZNo8nrmcFXC/M+t82KdNVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9m4mH6MPvkN+dFZbbWLaK9jVYGaGMxH1L1Pqsj37WY=;
 b=U2+2zKTi8PFl/aIkwa2qPitSdwJ6yev1iNefIu35D1xt9VHRvZ3Bht7juzRIov6bosZku6Mm73VdJYN54FA/qbpb0RGzdsddrzJl1G5Y0Cbpx/zF2kh+MgEhGbRl1v31sd+w1sFOfVdaq1bkvm6nGcDeUBUZW6/gBcw4dRm7L5Q=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by PSAPR03MB5271.apcprd03.prod.outlook.com (2603:1096:301:43::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.16; Thu, 2 Sep
 2021 02:29:21 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::3d11:979f:9b79:dcbb]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::3d11:979f:9b79:dcbb%6]) with mapi id 15.20.4478.019; Thu, 2 Sep 2021
 02:29:21 +0000
From:   =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "tzungbi@google.com" <tzungbi@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?Unlhbi1KSCBZdSAo5L2Z5a626LGqKQ==?= 
        <Ryan-JH.Yu@mediatek.com>,
        =?utf-8?B?UWl6aG9uZyBDaGVuZyAo56iL5ZWf5b+gKQ==?= 
        <Qizhong.Cheng@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        =?utf-8?B?UnlkZXIgTGVlICjmnY7luproq7op?= <Ryder.Lee@mediatek.com>
Subject: Re: [PATCH] PCI: mediatek-gen3: Disable DVFSRC voltage request
Thread-Topic: [PATCH] PCI: mediatek-gen3: Disable DVFSRC voltage request
Thread-Index: AQHXlPoY3AbtgI9rMUqtuhIbEVXy9Kt7vBGAgBReNIA=
Date:   Thu, 2 Sep 2021 02:29:21 +0000
Message-ID: <53b79201135690800f3c97d861af9567b6f2a40d.camel@mediatek.com>
References: <20210819125939.21253-1-jianjun.wang@mediatek.com>
         <YR8go1l0Xnvvqn5E@google.com>
In-Reply-To: <YR8go1l0Xnvvqn5E@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5528d67-f7c0-4492-76ca-08d96db978ff
x-ms-traffictypediagnostic: PSAPR03MB5271:
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PSAPR03MB5271C54D2FCE8A6D85CE045AE7CE9@PSAPR03MB5271.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2AM6YOLKMDOe9lwnU4BtEQmgB8gtawhWxKkosMpPWhwUD1GQiO06cN5rsXszl8kEi8L+jwk3JDOKTgs3fMQV2zglWYGZfH654GgjUFN97uRlNHjwb76hh0nMjiK1kmvAn+xG6QXeaP2BD6ALEQyf01vzGHk92ParYjKPsZocGHb3uvOjm6o/DPgW42hrBwO/hzhE0m0+BH9i16kLVjGBCPvceME3HfpmBzBt5xbs7BmN2xkxr1W6UXez+GajEleaK56LB/trT2x4w+q7OqJOHkCuUvOp2oBRXVVJeF+K4x8mhIxnAzdbKCUdpbFMY47zSSxltsRXV/8bEiHcHRSu+R4apqI1t88FN9iC9FDtEc75mdoR7F37V4+FpTdjZMC1YqDxvJTnq1/G+wInfhxxIORuuYjsV9HRp4I9T89NsLDljH/iKqF3HwiCOMW5pKI795L56sprcG4JpwtwE2J45a3A4z13B6PWNOaAkaq88jSdhZ0h9nTMkldT5/r+f4U7UwuymOPdS9lEPGQawDuhCioVnM+4RSaLSkHLNLcvP+YTgRK5f59pVo6vJTcaQXhmOAImdrgOljMFZY0BS+Jon8ZuSDKleIrI3XzSDBN4lJCh4OtxqNHLnArbWRVNu+mX+enzd/neNm5hEMK9b7Pa9yG22Ndtwy0YkKRojdncRdQtD4WVGCP1kDKfKRWhXukW/3+RwS4Mb+9vs/Ky4X73BA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(71200400001)(26005)(316002)(107886003)(478600001)(186003)(8936002)(36756003)(6512007)(2906002)(86362001)(8676002)(5660300002)(76116006)(66476007)(66446008)(2616005)(6486002)(122000001)(7416002)(66556008)(6506007)(4744005)(38070700005)(66946007)(85182001)(64756008)(4326008)(91956017)(38100700002)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wkg2UkhMc2VQTmZqZjhtWWVJUkdSWWZLbFJKd2dBdENCQjgxQnRLb2wyekM1?=
 =?utf-8?B?YVJiUW1CcGJ4ZnJoR3FOS3VETExSMWFCTmp6eWJ0U0QySWtKNHBBNmhKcUNW?=
 =?utf-8?B?TlVXUEMyMkVUK3daVEVJTlNOZDF5Zm1xV3BQWGN6dVRnTm9LeitYdVFScm8r?=
 =?utf-8?B?MHd4VUk0aWIxMDduYzE1TmhONjdzS3JCU3pVT2p3MVBjZ0F5N3ZqdDE4UDRB?=
 =?utf-8?B?dUZhMXBSZXh3ZXhoTFZnSkpBK2YzNndyUkNVZXFVV1ExNlN1Tmk0M09JOGht?=
 =?utf-8?B?UXNNTGw0MERQWnNGa2lTaHh3b010bytJQ2ZDZVRYNTlTcEY1U2hvVzYza2FX?=
 =?utf-8?B?WnNsMFpiWkhmL0VYSEVKQ3VNenhtdTBGWHFiR2hmVEJ5Rk5XMnkvcHBsODRo?=
 =?utf-8?B?WjZ5UFVOMUpSUVUyaHBPREgwSHRGZENxYURsL2E4MVlqdG0xaTFhMjZlMmJh?=
 =?utf-8?B?ZWlEUEZNd2dFSXhyUUpVMGs0S1RBT3BUUi9QdEw1QzJoTkZ2dGNtM3F4aGEr?=
 =?utf-8?B?N09QZzJoTzJhMC9mSHMzRXNBZ0RPU0JJblQrR3NCVlJnbmlxeFVUT2JvY3J6?=
 =?utf-8?B?ejUyVXhyRTczdjZ5OWtSM2d5Rll4NnR1bkMrSXVpT0VjSG96REFsSVRiMzlF?=
 =?utf-8?B?SkJvNVlhcGcrSGtCWHRUOEJHeGFHbVdWL3FmYi9LVjhqMCtFdDFaSGNuSVY0?=
 =?utf-8?B?NzBybUlnUTRuRXFpam80RVRSZVVjNnR1cjJKaCtNVi9HMmh1NGl3SnhBcXRP?=
 =?utf-8?B?WXQycFpROWllVVYrWkF5emNiM2tKTFErd0NvV25KUXhYZm9QVUJ4cEIrSU1N?=
 =?utf-8?B?eUZ2K1BobzdxNzQ1cmpYamtqclNKYzcrQlRwMStGakZ4SGVSRFppUnlnMU00?=
 =?utf-8?B?MlpVRXAxZndvRDRBYzhvWGloRTh6L041SFRNeFVzWVI3M29EdHdFVGxCdXBI?=
 =?utf-8?B?dDdDa1ZMekZKKzhBYmY3VFdneUM3NmFhcEU4M0lUaGtPRzhSc1R3T0VOcjNs?=
 =?utf-8?B?b1JFK3VnMHJ5VHc3R2dUaU9SM0tlNmlackZDZXNiQlZWUmNvN1V6Nk1zMi9S?=
 =?utf-8?B?bGpCUUk4YkM2QTgzRER5OCtZT0xYaDBQT05uc3NFRFZobm93WE5yRjhJUU1n?=
 =?utf-8?B?Q2xGMFFGS2lJY3VycjlLcjhwNG94VVNTNWc2RGVJdHVsVUJ2SjQ2UE1oTU9a?=
 =?utf-8?B?bkVCMThOZnZqZVUwbFJJeHZ3T1pIS1ZSdThBU3orSGxGU1FpL0lMNEIvczJl?=
 =?utf-8?B?dHhDWHhLV0V3czNWelJLZjZYSk55MjhwSjRTQXdoVlllTGYwOXlZcHdxc3VP?=
 =?utf-8?B?NW9zdTlZK1hvOGxuYmpubTFvdkE3WUl0dFhVY3pjYUR2MzZFVGo4OVovVDRi?=
 =?utf-8?B?QUhjai9uVHlCbEtKcEFjR3J1VExZS0M4TzludDgyWDlHd1pXMURzKzdIOFNQ?=
 =?utf-8?B?dDlqdXVtZUgveWtYL0FlcFpGS2NwakQxa1o0V1RrbXRxMHZ1d1dWUEtNOEpI?=
 =?utf-8?B?UFNtVmtGRTU1YmM1Z1cxb2pFeXR6MWpqcFhOUFJwTm9tZm1INk9Sc0NjOEM4?=
 =?utf-8?B?bHoxbG1renJ3Qk9kUUM4LzhpVm9vMEdlb3g5WVFCNm41cWlLdSt5VVplWHlP?=
 =?utf-8?B?V1FWd3IySDFpS0x3V1RYOVE4UDcyMXV4UEZHbWVDanFDSG56QWZUSUlkMHBx?=
 =?utf-8?B?R3dRUkQ0SDRkWFU3Vi91bWNlWjVldDRmdGQ3SVBSRGtCUlhkdWJwRUdlVlpY?=
 =?utf-8?Q?kFU0UMZMwB4nDsoGHZaeiKAx5FV8ka8MUWKgo1a?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEAC0133633C65458428722D889AF6D8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5528d67-f7c0-4492-76ca-08d96db978ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2021 02:29:21.4985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CgPaSMohbXc5TuDHqCEpHLNni7ilNOsuWPTXZZUXSaEwJDNIlJJVUkkqFoeOzv6h3fLGvfe9+BYLk3zgxMMi3ngFuRWkCsWu+tv5sACzwVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5271
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTWFpbnRhaW5lcnMsDQoNCkp1c3QgZ2VudGxlIHBpbmcgZm9yIHRoaXMgcGF0Y2gsIGlmIHRo
ZXJlIGlzIGFueXRoaW5nIEkgbmVlZCB0byBtb2RpZnksDQpwbGVhc2Uga2luZGx5IGxldCBtZSBr
bm93Lg0KDQpUaGFua3MuDQoNCk9uIEZyaSwgMjAyMS0wOC0yMCBhdCAxMToyNSArMDgwMCwgVHp1
bmctQmkgU2hpaCB3cm90ZToNCj4gT24gVGh1LCBBdWcgMTksIDIwMjEgYXQgMDg6NTk6MzlQTSAr
MDgwMCwgSmlhbmp1biBXYW5nIHdyb3RlOg0KPiA+IFNpZ25lZC1vZmYtYnk6IEppYW5qdW4gV2Fu
ZyA8amlhbmp1bi53YW5nQG1lZGlhdGVrLmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBUenVuZy1C
aSBTaGloIDx0enVuZ2JpQGdvb2dsZS5jb20+DQo=
