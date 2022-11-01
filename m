Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0523614A49
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 13:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKAMGq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 08:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiKAMGp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 08:06:45 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAB312611;
        Tue,  1 Nov 2022 05:06:35 -0700 (PDT)
X-UUID: 61ad0a334e9c4fec8e7ab67bf1a5c92b-20221101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=FC681vb5oMq6vCIWOC5sgEgCKmvcIwtNzgRGOIvCY8Q=;
        b=ZsSTZDO8Y87tnDsqySmOcy2pWsOlL4WGNZSvdVNwCWvkDl2RlQunzi5z7PkaBs6uMfwPTLrnTwQTOiQEIyiF57bREDH96bpCFFuL01yuHnd5kFfytfIGRHcsS6hImM4gD4Lsbaz0d8TT6aQgsko/DTT/7oef1qZ3B6GyEJ9aeeA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:0114aff1-c226-4694-9ec5-ab0f18297b39,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:249d18eb-84ac-4628-a416-bc50d5503da6,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 61ad0a334e9c4fec8e7ab67bf1a5c92b-20221101
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1375236678; Tue, 01 Nov 2022 20:06:28 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 1 Nov 2022 20:06:26 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 1 Nov 2022 20:06:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgG3EJcMEC3fn3I4jmL1+cMKWzXcELGa6dyQwO82bXR26qZj9+kXjd4YPjRuZvdAPaiCuBFoWNRk+zJ4nwIf9lcIUglt5XeTvSn8uBqCJv0vyJruY2Nd0UB4PmWCwTMnlp3oNqyHKHkT1n1yro7ZRoMQuC5tPa3qvUOMIZan1H3f9X2rRhBKXSded+4E9y4LnFTG+Ie6Mump62XF+ZUAc0+0qyvDDvhxmLMonxIxhVR8Rbc3Iu7rMF9Kn1tdv04StjEYLtlYCgroPM61Q7conmXwhy0Q7c7MixPT5meZHKapga1qZkev53NY6lCXLrP/qNYpL8DpjrKrG2qjrkxiPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FC681vb5oMq6vCIWOC5sgEgCKmvcIwtNzgRGOIvCY8Q=;
 b=UcIHQLlndOiFYOGJ5Cz/Fq80AZkhVY74osDMAPxft3Alfr/e2vdj1smjdXsqaDYNywAWKAdj0u2m/W7e7kMgw0SVoy0uwLZnE7HrY8seBU6AklRyA4Lk0luiwBQaBtPDqEm/IW9Z9up7jgXKb1qGTcyqkcofDZUMC0FuaATQXiTRVx7YamILZl5+5epOSzo6xmDAtJD32xb8iUezw2VMunyeAYaVCCCRqN055FZaqOgz2j5EynRjbudA65b7eK9eqOnC4mtfFPygl3FRdyJAgfN/AWgELWVLXbGqi5CVrKRtrDa4+UcxLgHC/snL4y6/VCg+6qVg/b/hkK/1Mez68w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FC681vb5oMq6vCIWOC5sgEgCKmvcIwtNzgRGOIvCY8Q=;
 b=F4qRHSXuaqWza5RH6aDwaDrf0Ktgg9BP1JCzbQdby/Eb0d/GfeDseLBNeBz0le1Jc1ASK2rRdlKx5XOaZ2QWMCkd/xq89QuE5U1Kc1Fx/T0P1KvFtlTPOGGZUIOT11GMdK83Z8JZFmmmApa4XDYDQlhSier6LRp/Ye3wWwwbocI=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by KL1PR03MB7150.apcprd03.prod.outlook.com (2603:1096:820:cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.16; Tue, 1 Nov
 2022 12:06:23 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::5bc6:5d32:688c:2f60]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::5bc6:5d32:688c:2f60%2]) with mapi id 15.20.5791.019; Tue, 1 Nov 2022
 12:06:23 +0000
From:   =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>
To:     "frank-w@public-files.de" <frank-w@public-files.de>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux@fw-web.de" <linux@fw-web.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: Aw: Re: [PATCH v2 1/2] dt-bindings: PCI: mediatek-gen3: add SoC
 based clock config
Thread-Topic: Aw: Re: [PATCH v2 1/2] dt-bindings: PCI: mediatek-gen3: add SoC
 based clock config
Thread-Index: AQHY6EN16HcqJT4E302SII4MCXJfgq4jjaoAgAB6OYCABfxFAA==
Date:   Tue, 1 Nov 2022 12:06:23 +0000
Message-ID: <47e696ace4cc28566fea88d73d857902434ce48e.camel@mediatek.com>
References: <20221025072837.16591-1-linux@fw-web.de>
         <20221025072837.16591-2-linux@fw-web.de>
         <61c0b62af62ddd0e98378159db2b7d94022c9bf5.camel@mediatek.com>
         <trinity-a848b9af-2c0e-41fb-9073-97a7d05011c8-1666975323664@3c-app-gmx-bs17>
In-Reply-To: <trinity-a848b9af-2c0e-41fb-9073-97a7d05011c8-1666975323664@3c-app-gmx-bs17>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|KL1PR03MB7150:EE_
x-ms-office365-filtering-correlation-id: 144e3eb5-39f5-47c2-977d-08dabc017eb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zOe+DloyLOJxsdVez9vBwl6w/EvtsrkaWJPg/1P0c6zZPmQWOdhSHD2IYwIrG/HXBzVCKl4eSn9Ir7x6btoP1D6CvWMrdRKqOOn1Rp0jf1LcKxjUG2eFPQuDfzl/dO9+dD7HFSJ0AAYZ6Oqq/Oqrw1c974hldHksDdS858WyqRixoR+1F+3Gvknv4j3YRFHYSwEK3s1IrTfDQ5fsx/obEoBM6lpcIrHjG+CjRyFVO2Xeamyt85yVaGx8E/aaS7otaAmyEnQVbr+65XVPXLFApLQlXSDl62wl9vfimZfeo1K/Yp8Ulm3gAYdijRKuE0957K3ph5DR9hCdMmtTW2cSJgjigcxzwhmwOeNSvOZfsHKATpWD8zzLi8yiUy1u25UqdcYbj1eWCx5HYhM1LVI/c+ntM2vw56n0IbtwJAK06VxKMSfqQvjkwNWehsetlr1ii0T8O4K2C6QLvJQAboLA2wZQFR969mGnSH+MUk0iLHXpU4ifXq395vZdp24Cuejv5eS62/6YXsOZCX3uH0sJ+ZF2OQ8M3sYS1NKXqzRSvxMwpr1js/I/op3CvTIDbmwgoRIMcc7zfYSA3762HSdiNwwNTEgZceagjYhm2tqMcOeSrx7MO8Q2DG5A8WgzAJ+TM+sUMWJ/pk3ctnc0TzcR1KKiSU1mBSKEzHCSIk2M/+iiqseJbnqBrQbiKMMLeBldYjPav5w1dpSBuiV/caoRmYZmrArN+vMgAQB8gOE5VS7A3mzcCgpIZJsSTK6VBl7S/+VcfHqtHhE0pPDGMgzEDhL5qymxPyqbvy5xF1n/O/xvLOIci07YL/ZINy6MASMmQvhcHk4S36NaPCJ1LatTnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199015)(83380400001)(71200400001)(86362001)(966005)(2906002)(4001150100001)(6486002)(38100700002)(122000001)(36756003)(85182001)(38070700005)(186003)(6512007)(6506007)(26005)(76116006)(91956017)(2616005)(4326008)(54906003)(66946007)(64756008)(66476007)(8676002)(478600001)(316002)(41300700001)(6916009)(5660300002)(66446008)(7416002)(8936002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K29iOFg0UzA3MXU3RzVQcWJGTVZTR2Z4cnYxSWRPSU1lUjlwcXNhR0QyK1dG?=
 =?utf-8?B?Mi9iUzVKbmdjSHpudVpVVmYwSmhJY3lUZGxwVXVNS0J5N2l4UUhUM0l4eFAx?=
 =?utf-8?B?UlhPZXlpc0kzOTBjamhkSXZKeXE2N3AwSG5ReGE1OTFyaWpBK0JrZGJaM3NQ?=
 =?utf-8?B?MllyTTNZQ2dvRDlJY2E5L0k4aVNLWTRXNElQb0x0aVdEdWxoL2xhODFhN0Fs?=
 =?utf-8?B?S0crSExTK0pyNUh5OG9TR1AxV3YvSENxb2cvS2dKS0x2Z3A3bHJ2Vld5Rmxn?=
 =?utf-8?B?UHdLNWg4YTB0cklTZGRXOWFXcmtrb09mdHRuRlJKOE1pdFAwSm82eUh5ZUZX?=
 =?utf-8?B?SThHYklIa0x3Z2x4TWtjZUNqL0RBek5RMngwcXRpc2hoTy9heHRVaWRCRzQr?=
 =?utf-8?B?YzlkZ00wSWhHTC9uNGZ3UzNlZ3dxRUdxRTZCd0lWVGxrM0UrRUllNmorNFc2?=
 =?utf-8?B?cUdYaWtsRk9vOWNDRVFYL1NzckFBQlZnbkRMRGhKVGVKZ3gxWG80SldhNjZh?=
 =?utf-8?B?WHVwWFluQ2lsVS9uSmo1T3dvcC8rSU1yenRHbGZwbzlRYm1yMjV4ZFNhcFVz?=
 =?utf-8?B?MXE2NVREU2pPYm5EK1RPenEzaUd3U08wWkgvOFQ1VXNqb3BsWDFkTkM3UnRE?=
 =?utf-8?B?QnQvWm1ZbTFhcnc1bUZSajZHTEdTblRWbUFQbGV3ME1kcGJuU241RHNkYk9j?=
 =?utf-8?B?NmFxa0Y5WFdSeEpkWlVrWDJZNFdBVlZNKzBwTkovVXM3ZW8xZkdvNzlnWWhw?=
 =?utf-8?B?VW0yYi93MzBGd3dYbEpPSlBOTjhQTXk3alhWcDZwVm83MGxqZ29qaXRSZ3Bt?=
 =?utf-8?B?WUYreHNRd1IyWU0xNzNyZ1pCOVpVV2Jid0pKQ1RQNkFuaktRcFQ1Q21vRXhh?=
 =?utf-8?B?aVJhR1NEVTNoTXhHWng4dncwa052MjQxN2FJN3ZrM0VmcDdYMWdqMjl0S2lH?=
 =?utf-8?B?WHB0SjM2NHA5bU5IUXE4UTBCL1VYd0dXclFXM1NCL2QxWXU5emhmM1FhaFFW?=
 =?utf-8?B?eW1XOHlBYjdYMUVWZzB5ZUhpVWlLQUFFRmVqTE1IRU5ra241akV4bG80bzF4?=
 =?utf-8?B?RWhwTitJQWZFZ1pzdnpkZExwc0hDZEcrdTRPQ2pUUmlmbzAzaXNoQnJtc2F2?=
 =?utf-8?B?eU1mVmZEd3dFVmlENmYzelAweU5yc3l2cStDcWR4b01nVHJYWEQ5Y2x3TDFN?=
 =?utf-8?B?ZU1ZcUhnNkJLMG9HWmNad1RqdHJlcFdCWk9qUkRsU1NOSU85bHJFVVlJS0Nr?=
 =?utf-8?B?QkxaTjBzTW5zOHMzYzk4TGYyMmJnTzc2Rk0rYjQ2enp1cVFIQzNJc2o1WHNk?=
 =?utf-8?B?eVB6OWI5S3IyUHlNT1FiRXBXbTNRckgwS3hCMWt3V2dVbksyYVpmMlNLdGJK?=
 =?utf-8?B?TWJVNDFIdmJUbklnSWZZb0pidDhLaThhZUsxdU11UnpteisxWktsbXZNZjY5?=
 =?utf-8?B?RkV3WS9Lb1lGdS9WVElGcmZ4ajZESUpBQWpZVFhaQ1JxYy9TYnpaYnM3RDdt?=
 =?utf-8?B?WklEQXVWR0l4TWZIZXFIY0JuNkxmZlJNWUVpSFIvVjJNYnRCbHJmZ2lPRXJE?=
 =?utf-8?B?UytLRlZnOXpRRG1mSnVnNUdEZWFNQjZBVFU2UEp6L3kwcXdjQ0pCT0wrWVJr?=
 =?utf-8?B?TnNWaXVNQUdWdy9leDFXaVRmS2wrcWtJNjdmU1c5UGJlMyt1WmtGb3V4VVdY?=
 =?utf-8?B?S1NkVHRiaTlmS1hZSHp0bFB1QjJIN1MwRzd5SzhZYU54Qmw5a3NpSEdyc3k4?=
 =?utf-8?B?Z1pKV1hhaHM0ZFRmdzgrWkVqV1d6SGZSNGJRdkpJMnNPUUVQRTJueVVxck1k?=
 =?utf-8?B?MzhwbjEwVExhVGgybVVNQlFtSktKYnJxUWdxUUdWaHZGUkxyVHpuL3h6LzQ2?=
 =?utf-8?B?K242dDZWajhPbExLNS9IT1VqMWZMQ0dDNGRibDRSSWFKOW9DenFmcGRZa2Ur?=
 =?utf-8?B?T2F4Si8wNXpRWlVFUndweTUwcFYwamhVR3ZDMkZGYk9LMHRtc0gydExQRFpo?=
 =?utf-8?B?ZUk0cFhaQnl1cldRcjN2Mlp2eUF1ZlJVZDRCSGRLUjdzYnR4Z21IR1I5a2pO?=
 =?utf-8?B?bzkwRkcxanZ0SzYvdmpjTm0zUXVrQ1FMbDBWZmNCVUxSVSt2NXVYUlg5MkdX?=
 =?utf-8?B?TjJjWmpEZzRVUkl5d0Y4K2hGZGY1TWpTR1U5Q1J0dUlPaXZUbWEwRXhQaGxO?=
 =?utf-8?B?Zmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5078E6C326AAD4C90B36209B01330D1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 144e3eb5-39f5-47c2-977d-08dabc017eb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 12:06:23.2762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DnGBAhjXTa5U29A4Nvn+W1tpjY/7hojdwInwVrHjePloOeREybD8RCPCjUCOLQ5MqmROnGOABQuFWZBg9Q0ORYjhbAKQuQpxnt6OW+/4NH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7150
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgRnJhbmssDQoNCk9uIEZyaSwgMjAyMi0xMC0yOCBhdCAxODo0MiArMDIwMCwgRnJhbmsgV3Vu
ZGVybGljaCB3cm90ZToNCj4gSGkNCj4gPiBHZXNlbmRldDogRnJlaXRhZywgMjguIE9rdG9iZXIg
MjAyMiB1bSAxMToyNCBVaHINCj4gPiBWb246ICJKaWFuanVuIFdhbmciIDxqaWFuanVuLndhbmdA
bWVkaWF0ZWsuY29tPg0KPiA+IEFuOiAiRnJhbmsgV3VuZGVybGljaCIgPGxpbnV4QGZ3LXdlYi5k
ZT4sIA0KPiA+IGxpbnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gPiBDYzogIkZy
YW5rIFd1bmRlcmxpY2giIDxmcmFuay13QHB1YmxpYy1maWxlcy5kZT4sICJSeWRlciBMZWUiIDwN
Cj4gPiByeWRlci5sZWVAbWVkaWF0ZWsuY29tPiwgIkJqb3JuIEhlbGdhYXMiIDxiaGVsZ2Fhc0Bn
b29nbGUuY29tPiwNCj4gPiAiUm9iIEhlcnJpbmciIDxyb2JoK2R0QGtlcm5lbC5vcmc+LCAiS3J6
eXN6dG9mIEtvemxvd3NraSIgPA0KPiA+IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9y
Zz4sICJNYXR0aGlhcyBCcnVnZ2VyIiA8DQo+ID4gbWF0dGhpYXMuYmdnQGdtYWlsLmNvbT4sIGxp
bnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmcsIA0KPiA+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
LCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLCANCj4gPiBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcsICJSb2IgSGVycmluZyIgPA0KPiA+IHJvYmhAa2VybmVsLm9yZz4N
Cj4gPiBCZXRyZWZmOiBSZTogW1BBVENIIHYyIDEvMl0gZHQtYmluZGluZ3M6IFBDSTogbWVkaWF0
ZWstZ2VuMzogYWRkDQo+ID4gU29DIGJhc2VkIGNsb2NrIGNvbmZpZw0KPiA+IA0KPiA+IEhpIEZy
YW5rLA0KPiA+IA0KPiA+IEFmdGVyIGFwcGx5IHRoaXMgcGF0Y2gsIHdlIGZvdW5kIHNvbWUgZHRi
c19jaGVjayBlcnJvciB3aXRoIHRoZQ0KPiA+IGZvbGxvd2luZyBwYXRjaCB3aGljaCBhZGRzIHRo
ZSBQQ0llIG5vZGUgZm9yIE1UODE5NToNCj4gPiANCj4gPiANCmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LXBjaS8yMDIyMTAyMDExMTkyNS4zMDAwMi0zLXRpbmdoYW4uc2hlbkBtZWRpYXRl
ay5jb20vDQo+ID4gDQo+ID4gYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTUtY2hl
cnJ5LXRvbWF0by1yMi5kdGI6IA0KPiA+IHBjaWVAMTEyZjAwMDANCj4gPiA6IGNsb2NrLW5hbWVz
OiAgICAgICAgNTogJ3RvcF8xMzNtJyB3YXMgZXhwZWN0ZWQNCj4gPiAgICAgRnJvbSBzY2hlbWE6
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbWVkaWF0ZWstDQo+ID4gcGNp
ZS0NCj4gPiBnZW4zLnlhbWwNCj4gPiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5
NS1jaGVycnktdG9tYXRvLXIyLmR0YjogDQo+ID4gcGNpZUAxMTJmODAwMA0KPiA+IDogY2xvY2st
bmFtZXM6ICAgICAgICA1OiAndG9wXzEzM20nIHdhcyBleHBlY3RlZA0KPiA+ICAgICBGcm9tIHNj
aGVtYTogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9tZWRpYXRlay0NCj4g
PiBwY2llLQ0KPiA+IGdlbjMueWFtbA0KPiA+IA0KPiA+IERpZCB5b3UgZ2V0IHRoZSBzYW1lIGVy
cm9yIHdoZW4gYWRkaW5nIHRoZSBQQ0llIG5vZGUgZm9yIE1UNzk4Nj8NCj4gDQo+IGknbSBzdXJl
IGkgaGFkIHRlc3RlZCB0aGUgeWFtbCBhbmQgZGlkIG5vdCBnZXQgYW55IGVycm9yLCBidXQgb24g
bXkNCj4gcmV0ZXN0IGkgZ2V0IHNhbWUgZXJyb3IgZm9yIG10Nzk4NiB0b28uLi4NCj4gDQo+IG1h
eWJlIHRoZSByaWdodCB3YXkgaXMgdG8gcmVtb3ZlIHRoZSBjb250YWlucyBpbiB0aGUgbWVkaWF0
ZWssbXQ4MTkyLQ0KPiBwY2llIGlmIGNvbmRpdGlvbiAodG8gbWF0Y2ggb25seSBpZiB0aGlzIGNv
bmRpdGlvbiBpcyBubyBmYWxsYmFjayksDQo+IHRoZW4gaXQgaXMgY2xlYW4gZm9yIG1lLiBDYW4g
eW91IHRlc3QgaXQgd2l0aCB5b3VyIHBhdGNoZXM/DQoNClNvcnJ5IGZvciB0aGUgbGF0ZSByZXNw
b25zZSwgSSBoYXZlIHRlc3RlZCB3aXRoIHRoZSBwYXRjaCBmb3IgTVQ4MTk1LA0KYW5kIGl0IHdv
cmtzLCB0aGFua3MhDQoNCj4gDQo+IGFsbE9mOg0KPiAgIC0gJHJlZjogL3NjaGVtYXMvcGNpL3Bj
aS1idXMueWFtbCMNCj4gICAtIGlmOg0KPiAgICAgICBwcm9wZXJ0aWVzOg0KPiAgICAgICAgIGNv
bXBhdGlibGU6DQo+ICAgICAgICAgICAjY29udGFpbnM6DQo+ICAgICAgICAgICBjb25zdDogbWVk
aWF0ZWssbXQ4MTkyLXBjaWUNCj4gICAgIHRoZW46DQo+ICAgICAgIHByb3BlcnRpZXM6DQo+ICAg
ICAgICAgY2xvY2stbmFtZXM6DQo+ICAgICAgICAgICBpdGVtczoNCj4gICAgICAgICAgICAgLSBj
b25zdDogcGxfMjUwbQ0KPiAgICAgICAgICAgICAtIGNvbnN0OiB0bF8yNm0NCj4gICAgICAgICAg
ICAgLSBjb25zdDogdGxfOTZtDQo+ICAgICAgICAgICAgIC0gY29uc3Q6IHRsXzMyaw0KPiAgICAg
ICAgICAgICAtIGNvbnN0OiBwZXJpXzI2bQ0KPiAgICAgICAgICAgICAtIGNvbnN0OiB0b3BfMTMz
bQ0KPiANCj4gDQo+IHJlZ2FyZHMgRnJhbmsNCj4gDQo+IHJlZ2FyZHMgRnJhbmsNCg==
