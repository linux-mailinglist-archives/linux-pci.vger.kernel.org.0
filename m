Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F54690096
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 07:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjBIGsW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 01:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBIGsV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 01:48:21 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C5430EB9;
        Wed,  8 Feb 2023 22:48:18 -0800 (PST)
X-UUID: ba590988a84511eda06fc9ecc4dadd91-20230209
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=/hE9Ff3QXyY/LHLDhyh47Q2UttRaAGn7Y9msDWT9ErQ=;
        b=DkjBFoIkQDs64iw8NNgB1mvtN1d12LZv5eiUD/SmerFkIvA24WmsKngSaxVrhyuaNgUKwmFkgV/yQ+X5Q8mzF3Qy41R74LMXA8279PS6SkOX4jxMk/46+BFt+0ZMNWfjT9LudyqqGQVpcGHjX7qE6SbMznWAm1Z3P2NpvtiXanE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:7f06776c-cbb4-4f08-8dbb-1af2885acbf2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:e751edf7-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: ba590988a84511eda06fc9ecc4dadd91-20230209
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <jian.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 772793315; Thu, 09 Feb 2023 14:48:15 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 9 Feb 2023 14:48:13 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 9 Feb 2023 14:48:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwXGQtfbnyLFiO21LH4a4RAYni9Ip5tayETpeG50PAC2SEpV+Q6cRc7kr2oIwpLHoDr2QVT3d0EGqijuXQpZUWIdt7tn+rR6okQOLhUY4oAFYlhw7nse6KONbirZbL6YqBHUdBQZ/FmRGHHuquajWEtUzUkcFqZGyS/YyTK0tkAyvE8XhtNjcvKCeJDd9g+AX8wg3tDcqruOxBmCeDYdPGqPI8HW5/JZnUW4m8m45jJVKjwn0KQP0NbVgMRT+TTtjTtcZbzgfWrZvKgvGBxwSdfSNkdKtxl46vNt+cBlYkLWK72cYNuPlIzB8GTmTjT7CT2c87hdnW7dGbtA1UqikQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hE9Ff3QXyY/LHLDhyh47Q2UttRaAGn7Y9msDWT9ErQ=;
 b=aCK2dv5MMKL+IWLbV+3U+AqHV1RuxgYgCR5y9TV+yeNL/Ozf42awTLNgI6FgUl8HGAVV1CMWpgDRr+jhxgoqeVgNjdmq+gkqzU6f0kn4HQdtld4u4CfL6g02ZNwfguQ768GGEKxYNqTanXG616VPovNYRhl7mMTssjLkkT1LonsvhEZ2QZke71DtmUpBYWyfpRNDV5ZKBnv78JLPOG7IZpGqktuf6w3KMYs0oFlinu8iQAYXiaykSPr+85uQcT/N0N9nN86AYCxws4Z2OszZ/iZgF1pDJo+HK+CmrnOGvWg7iF3ORv79P1RIxcsmsqaJ1nfexqq1pISQ2nBlXDVsOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hE9Ff3QXyY/LHLDhyh47Q2UttRaAGn7Y9msDWT9ErQ=;
 b=uQpch7+t+wFIU8coqf4UqGIFN5/wHW0hELQ8CsbrPABU467U6lbAlJRDC8/6bm0qfibXEYUNXmU8V74VbY9Sq0FiM0I5/JSyYoHQMlq969UhnPZS+KKgY50H0vndkBj+pLXP6C5JbWlHoW7JpCvgZsBhVyF0EyQoUH6fzpiI3ao=
Received: from TYZPR03MB6021.apcprd03.prod.outlook.com (2603:1096:400:128::9)
 by KL1PR03MB5762.apcprd03.prod.outlook.com (2603:1096:820:78::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Thu, 9 Feb
 2023 06:48:10 +0000
Received: from TYZPR03MB6021.apcprd03.prod.outlook.com
 ([fe80::bf9d:c68b:dc9:3943]) by TYZPR03MB6021.apcprd03.prod.outlook.com
 ([fe80::bf9d:c68b:dc9:3943%5]) with mapi id 15.20.6064.036; Thu, 9 Feb 2023
 06:48:10 +0000
From:   =?utf-8?B?SmlhbiBZYW5nICjmnajmiKwp?= <Jian.Yang@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?SmlleXkgWWFuZyAo5p2o5rSBKQ==?= <Jieyy.Yang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?Q2h1YW5qaWEgTGl1ICjmn7PkvKDlmIkp?= 
        <Chuanjia.Liu@mediatek.com>,
        =?utf-8?B?UWl6aG9uZyBDaGVuZyAo56iL5ZWf5b+gKQ==?= 
        <Qizhong.Cheng@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "kw@linux.com" <kw@linux.com>,
        =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        =?utf-8?B?RGF2aWQtWUggQ2hpdSAo6YKx6Yi657+UKQ==?= 
        <David-YH.Chiu@mediatek.com>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>
Subject: Re: [PATCH 2/2] dt-bindings: PCI: mediatek-gen3: Add support for
 controlling power and reset
Thread-Topic: [PATCH 2/2] dt-bindings: PCI: mediatek-gen3: Add support for
 controlling power and reset
Thread-Index: AQHZJW08mAoVUkodH0Stwnt7OwVpoa69iFwAgAjRuQA=
Date:   Thu, 9 Feb 2023 06:48:09 +0000
Message-ID: <7f96a46c330459961e2fc18afd92fdfd66ab2bf5.camel@mediatek.com>
References: <20230111032830.20447-1-jian.yang@mediatek.com>
         <20230111032830.20447-3-jian.yang@mediatek.com>
         <CAL_Jsq+eAQ-M9a+9g7Kk3GC9WjE_4mZXXrsdm4PucOJ4p2QYVQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+eAQ-M9a+9g7Kk3GC9WjE_4mZXXrsdm4PucOJ4p2QYVQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6021:EE_|KL1PR03MB5762:EE_
x-ms-office365-filtering-correlation-id: 5104a175-5afa-4a6f-35c6-08db0a699b84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y9iOyq0Sh/33icJCFp9/VXH86Imw6s/S1wurRFr5uxr70mH46bseJvzGCwT1nfk28cVuBrHnBaw5S3jlX2CDtwFB3JJoyMqgmKpUn260Lg2WYxeqb7E45MpwQCaet2A25CuhrSK3yvMCJ27w41D+W6179YyHgCPp4xG0Sf2Dx1/oWzt+rxvLDsQSImMB0JB8P9PEC30PGjIibrFRuL4tLFWPR344gX2pxT4fy31DaP1DQaWQHESaD8VPLwX0WzZKt/ogFF4hBe7fIcpe+gIdn6KiBfDwc7po9xdXQkHvRH7JiPaC+kqdnpYspesBNBhsse626qzAJwvB0O3hI5kptubzVM2Yqe4ofl2ZpzymDRCnQ3SPnBMMW0yQK3kx5C0Ef5f7U6niCax4ZPCYDhb63QiP2ojL1FlCt0JbAhRKmyKp+mN0bsmvIUnqMfc/7N5PLDR65YvHnqpAaYVvKW+lfUUtxRC1rwfFp5iCkDUbaD83E7tkEZT+XtOvNd+a/cd5vJTUf2Ly9ODnlAxTFCVBJ1SmD4ZrrBXwZcNvMTp8ZRAbqilcsPN22ARIUtHFS2tKBVZ2RPJV+/eJX4169FyfeqPotIdZFOatiZu1CgxCzvkWu8SSd3AiVDSpEP1jn4IbQKK+jVDKZ/L3+9U2Z496AOlhmyMOP5bef/Ljw6MXeSfX2V8cIVT+3dcfD9Z+l7QnwKdbzX7Ui0xrwmG0WHK1NA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6021.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199018)(122000001)(38100700002)(71200400001)(6486002)(316002)(86362001)(54906003)(6916009)(478600001)(41300700001)(38070700005)(2616005)(83380400001)(66946007)(107886003)(2906002)(76116006)(8676002)(91956017)(66556008)(66446008)(66476007)(4326008)(64756008)(5660300002)(85182001)(8936002)(36756003)(53546011)(6512007)(6506007)(26005)(7416002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzNMck93VjdFdHg3WGlHZlB5T2JIL2NXVTFORzhFT0tpaG9MMENUVlB1NlZa?=
 =?utf-8?B?MnJOemJ6aURHV2JWWnVPNDlXVFlpcDJ6Y0ZJNEVWb3JSY3haY1pJcHJqTU11?=
 =?utf-8?B?Vk8yZk1DcGhPUTd3REtjK0htYm50TlcvNFJVajFMU1cvRjdZbzlBV1ZucTNr?=
 =?utf-8?B?YjF5TnpvRDQwcnlocVlEVy9tUXVKVFpKRGowTzM3M0IrZVEvSGczQjlBVDdt?=
 =?utf-8?B?NDF6QjYrTVl3dFQyRmVZQ0tnbWNTcEpDd00xSmxUbW5jenRHQjRXaFRkcklt?=
 =?utf-8?B?YmtYU2JmM0VPQVNLNEVDeklJb1dFQ0FSdTFJckQrMk1mdERrR3czU0kvZ00w?=
 =?utf-8?B?ZUVSSjFZQXFFck9WTEFhVUV4M25acUNtYTdBMWdlOTYyTEM5RHNSeElERW1V?=
 =?utf-8?B?bkJ3V205M1JvYkNuOEt5blU4cTJFQ1NoMStsa0RVRzY5NnZXaHpDY1ZzelZs?=
 =?utf-8?B?SFk5Q2dSMUpCUDJZVDVRZEZhZHZBRjg3dGl5V0dUbEswR29LcnNsb2NBTXZN?=
 =?utf-8?B?ZDdydldLbW5maW5idWhBa3ZGQTBSVk00YjdWdXJsWXRQM01oOEhlUnJMbnkw?=
 =?utf-8?B?Ry96ckNqaHRodDIzcEdTYkVscDF6VDNuY1ZTa2xKaE1SQUlSZWpMbjlYay92?=
 =?utf-8?B?MDhhQkJuNXVJTHhqMGdvcTdScElYSjRxVTV2SlBFbWtNR1JnclUrRGJkT0Vl?=
 =?utf-8?B?cEV6RTVTcmE0SHBNR29HTnVsdjFmbFBiNDhYT0o3TGl2VHc2bHlSa2p2Wk5R?=
 =?utf-8?B?SERQcUx6NEJmUnRjSUQ2TTNtbFNMTzlSTTZHQUUvWFVFYUNXakQ0TWdRMVND?=
 =?utf-8?B?bW1UN3ZnL1lOaHlQN0xCRHhZekswZ3A4VVduQ2NTYjFuTWFsd0hnYUdEdmFS?=
 =?utf-8?B?a0JOR0EyZUE2YjNNVFdZa29Bd21lZWRNUGxuTmFyVXVPcENIbWFhYUU3ZHZi?=
 =?utf-8?B?dlFTVUIvSUF4OWw3bjBIQ2Z6c1FuQWdoNmdyWWtjTVpRNzZRYmRxTHFMZjZo?=
 =?utf-8?B?eUZ2VlNVazlQVU5UOXZkbVUzMC81YVZLR0lPN2p6TzlPaVpteEZqd0tyaUkz?=
 =?utf-8?B?TC91T2NveElhaTI1RWd2dFovdzVBYXIxalZCZEVzcVF0NWNhUGRRUW1wVDZL?=
 =?utf-8?B?VkVyVjFFYWJvWkNVK1FWZWMvcUw4Sy95NVM1Ymh1RVBNRlZ4cUlldzFVbmZa?=
 =?utf-8?B?d1VsQkFCMHR3VGlwME5KQ04vVDB4cGVMN2dQN21BRGlkVGFGL2NXd2p6bjVC?=
 =?utf-8?B?MEwxOVBFTE11SHppVWdKN2VQY0tjSEpvNXR4R0R0Rk5OMGs3bkd0aXNlMHNZ?=
 =?utf-8?B?Y3BjdkdiSm9YRzRKU3N4cWk2UG9iMlpQZndLWU1Jb0Vva0hKRXppdk9uZU9T?=
 =?utf-8?B?MUlIZmpxVlJBekwvRzl5TFU1ZUVNeVhGb3FxNHhESnpCRUllQzVwVldMc29F?=
 =?utf-8?B?NmQzcWNlUkk4UXFBWFdDM0g4cXB6Tlk5RG9WOHNuR1h0Y2c1ZXJvbWl0ZzA2?=
 =?utf-8?B?RHJHNkdwRis5K0VjcndDS29RSU9TYlZSQ3JvOHAwRXZudzFHbERQQklDekxv?=
 =?utf-8?B?VzA2dWFkcTRnNXNGWUNPcGJURGR5NjJhVG9oWDNoVjREZ29pY08vUUpHRzFD?=
 =?utf-8?B?Mkd3cHV2UCtvK05jandKaXlxQkpYZS9KK0FNTVNqUWhUTEJFd3h1ajhRMHRP?=
 =?utf-8?B?ZXhDcHlBRTIrbmZUcXpYVzBDaXV5ZmY1WUhPZmhhMXpGbzhTenNzclVOc2pw?=
 =?utf-8?B?eks0MElLdHpGd3psZnRaUmpreDVVQmhKYjFVK3lUQ2YzRFh2am5rOEQ5VVRK?=
 =?utf-8?B?SXhaR3JpUlZZRHVlOGo3MEhZQ1V2VldTd3V6bFFHUzZ0Mnp1TkNSazhOakpi?=
 =?utf-8?B?MDBsa0xIemdFZ1dnN3ZBcWJGdzc3NHhid2hBRldsWjhybkZHcGZ4SEwvdE5S?=
 =?utf-8?B?amdSTzIrblQ1SmpzNm45eUR6Yi9KMTB4b3BGTUJkaFJiZkNrWHlUeWRndVl5?=
 =?utf-8?B?UnZzd2tEQkoxN2kxdHpBcGNtTFlZaElzRE5aZFg1ellPek00anoxL0lyMnov?=
 =?utf-8?B?V0ltcHFWelhQOUpNTkxjbFdkeUN5U3lzYW5NRVFRQTVxV1l4ZWZxb25XT0E5?=
 =?utf-8?B?S2l6YmoyTHQ1NFZSQUltdDNEQ1BEUTloK0pZYXpuUHdIcDh4enNGMXZEYk5v?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CA2357807557D4096E760576E641F91@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6021.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5104a175-5afa-4a6f-35c6-08db0a699b84
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 06:48:09.9721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: grN6blPm6+rS9tRKNOLL4sBq9Q3aEwyC8EhfuhsxghqKVTteCmtpvny8HG8Fu7Ul2ELmU1TNQoSa6btF+nGrEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5762
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RGVhciBSb2IsDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50Lg0KDQpPbiBGcmksIDIwMjMtMDIt
MDMgYXQgMTA6MDcgLTA2MDAsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBPbiBUdWUsIEphbiAxMCwg
MjAyMyBhdCA5OjI4IFBNIEppYW4gWWFuZyA8amlhbi55YW5nQG1lZGlhdGVrLmNvbT4NCj4gd3Jv
dGU6DQo+ID4gDQo+ID4gRnJvbTogImppYW4ueWFuZyIgPGppYW4ueWFuZ0BtZWRpYXRlay5jb20+
DQo+ID4gDQo+ID4gQWRkIG5ldyBwcm9wZXJ0aWVzIHRvIHN1cHBvcnQgY29udHJvbCBwb3dlciBz
dXBwbGllcyBhbmQgcmVzZXQgcGluDQo+ID4gb2YNCj4gPiBhIGRvd25zdHJlYW0gY29tcG9uZW50
Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IGppYW4ueWFuZyA8amlhbi55YW5nQG1lZGlhdGVr
LmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWdlbjMu
eWFtbCAgICAgIHwgMjMNCj4gPiArKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAyMyBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbWVkaWF0ZWstcGNpZS0NCj4gPiBnZW4zLnlhbWwg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL21lZGlhdGVrLXBjaWUtDQo+
ID4gZ2VuMy55YW1sDQo+ID4gaW5kZXggN2U4YzdhMmE1ZjliLi40NjE0OWNjNjM5ODkgMTAwNjQ0
DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9tZWRpYXRl
ay1wY2llLWdlbjMueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9wY2kvbWVkaWF0ZWstcGNpZS1nZW4zLnlhbWwNCj4gPiBAQCAtODQsNiArODQsMjkgQEAg
cHJvcGVydGllczoNCj4gPiAgICAgIGl0ZW1zOg0KPiA+ICAgICAgICBlbnVtOiBbIHBoeSwgbWFj
IF0NCj4gPiANCj4gPiArICBwY2llMXY4LXN1cHBseToNCj4gPiArICAgIGRlc2NyaXB0aW9uOg0K
PiA+ICsgICAgICBUaGUgcmVndWxhdG9yIHBoYW5kbGUgdGhhdCBwcm92aWRlcyAxLjhWIHBvd2Vy
IHRvIGRvd25zdHJlYW0NCj4gPiBjb21wb25lbnQuDQo+ID4gKw0KPiA+ICsgIHBjaWUzdjMtc3Vw
cGx5Og0KPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gKyAgICAgIFRoZSByZWd1bGF0b3IgcGhh
bmRsZSB0aGF0IHByb3ZpZGVzIDMuM1YgcG93ZXIgdG8gZG93bnN0cmVhbQ0KPiA+IGNvbXBvbmVu
dC4NCj4gPiArDQo+ID4gKyAgcGNpZTEydi1zdXBwbHk6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjoN
Cj4gPiArICAgICAgVGhlIHJlZ3VsYXRvciBwaGFuZGxlIHRoYXQgcHJvdmlkZXMgMTJWIHBvd2Vy
IHRvIGRvd25zdHJlYW0NCj4gPiBjb21wb25lbnQuDQo+IA0KPiBXaGlsZSBpbiBzb21lIGJpbmRp
bmdzIHdlJ3ZlIGFsbG93ZWQgdGhlc2UgaW4gdGhlIGhvc3QgYnJpZGdlIG5vZGUsDQo+IHRoYXQg
aXMgYSBtaXN0YWtlLiBUaGVzZSBzaG91bGQgYmUgaW4gdGhlIHJvb3QgcG9ydCBub2RlLiBZb3UN
Cj4gcHJvYmFibHkNCj4gZG9uJ3QgaGF2ZSBvbmUgaW4gRFQsIHNvIGFkZCBvbmUuDQoNCkluIE1l
ZGlhdGVrJ3MgUENJZSBzdHJ1Y3R1cmUsIHRoZXJlIGlzIG9ubHkgb25lIHJvb3QgcG9ydCB1bmRl
ciBhIGhvc3QNCmJyaWRnZS4gSSBhbSB3b25kZXJpbmcgaWYgeW91IHRoaW5rIGl0J3MgbmVjZXNz
YXJ5IHRvIGFkZCBhIHJvb3QgcG9ydA0Kbm9kZSBpbiBvdXIgaG9zdCBicmlkZ2Ugbm9kZSBiYXNl
ZCBvbiB0aGF0IHN0cnVjdHVyZT8NCg0KQW5kIEknbSBhIGJpdCBjb25mdXNlZCBhYm91dCBob3cg
dG8gZGVjbGFyZSBhIHByb3BlcnR5IHdoaWNoIHNob3VsZCBiZQ0KYWRkZWQgaW4gYSByb290IHBv
cnQgbm9kZS4gSSB3b3VsZCBiZSBncmF0ZWZ1bCBpZiB5b3UgY291bGQgcHJvdmlkZSBtZQ0Kc29t
ZSBnb29kIGV4YW1wbGUgYWJvdXQgaXQuDQoNCj4gPiArDQo+ID4gKyAgZHNjLXJlc2V0LWdwaW9z
Og0KPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gKyAgICAgIFRoZSByZXNldCBHUElPIG9mIGEg
ZG93bnN0cmVhbSBjb21wb25lbnQuDQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiAr
ICBkc2MtcmVzZXQtbXNsZWVwOg0KPiANCj4gRG9lc24ndCB0aGUgUENJIHNwZWMgZGVmaW5lIHRo
aXMgdGltZT8gV2UncmUgdGFsa2luZyBhYm91dCBQRVJTVCMsDQo+IHJpZ2h0Pw0KDQpUaGUgImRz
Yy1yZXNldC1ncGlvcyIgcmVwcmVzZW50cyBhbiBleHRyYSByZXNldCBwaW4gb3RoZXIgdGhhbiBQ
RVJTVCMNCnJlcXVpcmVkIGJ5IGEgZG93bnN0cmVhbSBjb21wb25lbnQuIEkgdHJpZWQgdG8gYWRk
IGEgcHJvcGVydHkgaGVyZSBzbw0KdGhhdCB1c2VycyBjYW4gY29udHJvbCB0aGUgZGVsYXkgdGlt
ZSBiZXR3ZWVuIHRoZSBhc3NlcnRpb24gYW5kDQpkZWFzc2VydGlvbiBhY2NvcmRpbmcgdG8gdGhl
aXIgcmVxdWlyZW1lbnQsIGJ1dCBLcnp5c3p0b2YgbWVudGlvbmVkDQp0aGF0IHRoZXJlIGlzIGFu
IG9uZ29pbmcgZGlzY3Vzc2lvbiBhYm91dCBhICJHUElPIGRlbGF5IiBkcml2ZXIgY2FuDQpoYW5k
bGUgdGhpcy4gU28gSSB3aWxsIHJlbW92ZSB0aGUgImRzYy1yZXNldC1tc2xlZXAiIGluIFYyIHBh
dGNoLg0KDQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgVGhlIGRlbGF5IHRpbWUg
YmV0d2VlbiBhc3NlcnRpb24gYW5kIGRlLWFzc2VydGlvbiBvZiBhDQo+ID4gZG93bnN0cmVhbQ0K
PiA+ICsgICAgICBjb21wb25lbnQncyByZXNldCBHUElPLg0KPiA+ICsgICAgbWF4SXRlbXM6IDEN
Cj4gPiArDQo+ID4gICAgY2xvY2tzOg0KPiA+ICAgICAgbWluSXRlbXM6IDQNCj4gPiAgICAgIG1h
eEl0ZW1zOiA2DQo+ID4gLS0NCj4gPiAyLjE4LjANCj4gPiANCg0KQmVzdCByZWdhcmRzLA0KSmlh
biBZYW5nDQo=
