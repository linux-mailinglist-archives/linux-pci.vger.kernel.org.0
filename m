Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB5E72F2A2
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jun 2023 04:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjFNCle (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jun 2023 22:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjFNClc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Jun 2023 22:41:32 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173EB1BC7;
        Tue, 13 Jun 2023 19:41:26 -0700 (PDT)
X-UUID: f274f59c0a5c11eeb20a276fd37b9834-20230614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=N7iLz7mqWbPcjVeKQ2qd55/9xJkBjq98Vk+QMeizH6U=;
        b=UyQjKUwIpW+neWp5Jw4HqsZwJEVm8tH4kkDmMHX0zI6IJb6GibEuRzbrpHktzabIHGzsTPQNe3n+Vix3zF6Tc2Zz4RTI3go2SV0qGAl0Fm16HUDSrhcaC0uvTRHX07se/l51j0/iY3Y8r9ul6L5INiP5cd99zB4Sj4DE2q1j7yo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:bae88b93-fb12-445a-aff2-8143fb2a9202,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:9a1b8a3e-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: f274f59c0a5c11eeb20a276fd37b9834-20230614
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <zhiren.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1041589724; Wed, 14 Jun 2023 10:41:21 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Jun 2023 10:41:20 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 14 Jun 2023 10:41:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zzi0kfNZtyOSRgLUzQgIA0Z1AUCOYEcbfddVbwks1Wn9c7xmolib6cAnxMxKLYXy8MpVah6AxUiPa8IrkaObIKOcOmKUNRFq3kdoVt0oB4BoaaSaw2B7svno3Jd8ZgM6GrpDJnwZzkJ9CNCEx7M79Zm9+hDe70S7jiHFDtb/56o3ksAPnMST/5J0Pg1TcePVQ4nXBuLQGti2dp1hIdJdduHiMkj4e9BBDirB1Qo3ste2rkXSOdGd3D1S3txKwc0Fz2USNYtnhz5yQIKgYMWneJCc17mRxOGazHByExCizoAloX3cyguuhhsDshBUqHeMYbpNzWQqgwQpoYnwmHy+Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7iLz7mqWbPcjVeKQ2qd55/9xJkBjq98Vk+QMeizH6U=;
 b=mPRJWj86sD8AMbRVOdmdLKfdO4RvMg2oh3g1zwTKoRYlBjxMyP5/sNQOBBKZKn7UnCtY+CECTYhzr7w9giXlyqBN5zWzhPz3r8tGzxSrthT7BovwgFT+2WRtoBhBlmgjwy8DZ9Pv+sUAwVBrE9p85NKCo8tmDcwHocnUrSXCbXoQtjjKks9O6aT0Z5a+D+wjyT8tQc08O5jtnVNigJDc4Ct/4Ku7CaBoKNF6zjtIPhzLDKh6pPQIO16+7SZVqCcOBd7s3ljG/OcqrkOp6Mr79BSWzNMnHhCSvZ+sap38ybdazdYYvLsuzzV19WKrzL9qi9PPBU7u+Y0+t4nXqaaLdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7iLz7mqWbPcjVeKQ2qd55/9xJkBjq98Vk+QMeizH6U=;
 b=kMOsiJNqydFI+A/rh7B99f69RHaxK4UN48vqVWo0SHESJXZKXEmpXTuwK3c0RK0gx67MbErgbHGYeLVMVB6i7QwZ90jU/PCzH48j58kiMK3PVV+k2xUi7pIzePr0qE56rht6mxiZnjcUewRK3wlP2mX1inWXUpOPOvG6Vqx68tQ=
Received: from TY0PR03MB6775.apcprd03.prod.outlook.com (2603:1096:400:218::13)
 by SEYPR03MB7416.apcprd03.prod.outlook.com (2603:1096:101:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 14 Jun
 2023 02:41:18 +0000
Received: from TY0PR03MB6775.apcprd03.prod.outlook.com
 ([fe80::9f60:6eaf:1726:8469]) by TY0PR03MB6775.apcprd03.prod.outlook.com
 ([fe80::9f60:6eaf:1726:8469%7]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 02:41:18 +0000
From:   =?utf-8?B?WmhpcmVuIENoZW4gKOmZiOW/l+S7gSk=?= 
        <Zhiren.Chen@mediatek.com>
To:     "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        =?utf-8?B?SGFpanVuIExpdSAo5YiY5rW35YabKQ==?= 
        <haijun.liu@mediatek.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        =?utf-8?B?TWluZ2NodWFuZyBRaWFvICjkuZTmmI7pl68p?= 
        <Mingchuang.Qiao@mediatek.com>,
        =?utf-8?B?TGFtYmVydCBXYW5nICjnjovkvJ8p?= 
        <Lambert.Wang@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] PCI:PM: Support platforms that do not implement ACPI
Thread-Topic: [PATCH] PCI:PM: Support platforms that do not implement ACPI
Thread-Index: AQHZmnpkqiBN1yD7ckqVZqD7Z8TGxq+CW+UAgABnEYCABaFpAIAAbeYAgADMKYA=
Date:   Wed, 14 Jun 2023 02:41:18 +0000
Message-ID: <a76791fe2fadad058e7aeb8b4b0e14586158a105.camel@mediatek.com>
References: <20230609023038.61388-1-zhiren.chen@mediatek.com>
         <20230609114920.GA1242120@bhelgaas>
         <CAJZ5v0iiAGGuzjT1-ZmCaUT9CH4uXaDG9XQ1QmKbp-bnCjEF6w@mail.gmail.com>
         <f2b93387ab364758a14774e4310c80ae8a0daeab.camel@mediatek.com>
         <CAJZ5v0iRY1PVbKHMpLxZozmK_hDvx+0SZrnbFWkDs_7O6D_fYw@mail.gmail.com>
In-Reply-To: <CAJZ5v0iRY1PVbKHMpLxZozmK_hDvx+0SZrnbFWkDs_7O6D_fYw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6775:EE_|SEYPR03MB7416:EE_
x-ms-office365-filtering-correlation-id: 42a40f34-e2ff-4243-0ba2-08db6c80d4b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VH5pcNGEfzCWKEzQifSsXYaxExt2PVQ0D2sZYD5aWLCWST1Bo5CabUaEP6gtihDPo9VJ4MWadJC4Si0UpKDo7vNobuJHw//7KUqxUz3iB96izsQhdmnyBUe6UecEQuUd1rh70UwWEFN8ovD6W7oz5atAjv86le5uqeq4KsiIZ31qukPtRLuH0/UqGQYAfbM+s+qEVWlqCMTjnbQGq/Y1UAPR9wdnvG7vte+GcM7ClnjyYkv+QjCNUrVdwzT8uOFhptsmLxdzISv61/N6hwPUBJbW30oMgrcn/3l1dL3ZyUyIT4bjnjHpgU5QeACqaB2qD4YFTbK5lCC9hPfKNP8KG6k0IORbu6q+n0EiMMrirtExu3a9Y0wyUoKvdRmGHSP60j/EfWtSX9qmN59QE3xIF5yjble0dStAluYRHSdfh3U3kXq22n/Fm6X4dqaFSh9pLTpcyfifSvjPPr3aTCD2CffC7ksyGTwclCZn4KJ72J4ywzmpSUw0p/VkfW11MSBcFREoKbO2axw35BAv0+1ncEH31y1wjISeQFoqVT88whgJcyhSQT4rQ9ZVtxT0yMtQ6XE2e8PYNiIDW60Y/43IMYHieGeRNlKaOR7Mq+v1c7EASBPsSVOFLji/THkZheKX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6775.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199021)(85182001)(2906002)(36756003)(122000001)(38100700002)(8676002)(186003)(54906003)(5660300002)(66556008)(478600001)(71200400001)(86362001)(6486002)(8936002)(64756008)(66946007)(66476007)(91956017)(41300700001)(4326008)(83380400001)(66446008)(316002)(76116006)(38070700005)(6916009)(2616005)(26005)(53546011)(6512007)(966005)(6506007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmcrRE4rUngycXMrTmhxQ3VaZFhSSDh2YnBYeVhLNnRIT0xNd2Q2MHdPNk9p?=
 =?utf-8?B?amJlbFpoL0hqdVg5RzRBekFIQ0tYU0gxT2xJK3QwdkYvSHAyUjlweUNmWFox?=
 =?utf-8?B?cGxvMmZ1WUU4US9vUVJaQm9Gd2dsd3FFSGJqUzRpUDV2ZnNXaXlyR1pwLzdk?=
 =?utf-8?B?Z25UY3VEeU9VQXB5V0NjN044L1hZTGVLbVM3N29Wd3BzYnBJZlFUMzZoUE5Y?=
 =?utf-8?B?SURQTVp1V2Ird2JYckpiZjkwQ2wyek1HZVdlM0haQTZJWTVNMTFrODlyd2di?=
 =?utf-8?B?T3NwUkRCWklvd0dRY0FETzhjUDd5ODYxOGxaa1EzMkZNRjNMd3BIREVPTWMz?=
 =?utf-8?B?NThubE92b1YzdSt2NnlNR01GcjZYVit5UVE1SSs2NVU5Vmk4NVlrczQ5Rm4x?=
 =?utf-8?B?ZFlGYUE3VXFpZkJsRC91dGVCYkR0WnZHVVFxcFg5VTNJcE1KVnI4L1NzUXVO?=
 =?utf-8?B?cDBaV0Q5NXdEazFJWERHcE5zanNVb2l3MmtJK2NxcGQ1a3h0SDVKMEEvNTFS?=
 =?utf-8?B?cC80cnZEWk93MzRDU2FrdVBEQnhEZHlhekZPNkszcFRydTQrOGMxVU5nWVIz?=
 =?utf-8?B?NU95YkhIVUsxeHpqZjltSzhOR0FTdlQyNzZtdXp5RUIvV0gwLzJ2YWlrejVu?=
 =?utf-8?B?T2xSNEdLWmhKYldhS3RIZ1h2QlJ2TVEwVHZWZ09CK3hoenViS0orSWYyTGk0?=
 =?utf-8?B?U0FURWp1Q2huU2FhcW5CSmNpMlRmSEhBckRyanZkV1o0d2w0ZnVXanpRWGNr?=
 =?utf-8?B?SHlsUGJnMzdybDNpMG5QbmdlZldYRjV0bVY0b3k5NHFwTU9TVDVyNkRkeDdx?=
 =?utf-8?B?NEloTjB3dUJiY2lDZC9CdjNxTHFPMStPSm1VOGd2TzJDTGdLUlFjOExwaC9x?=
 =?utf-8?B?NkEva1pGczV4KzUyZTRJVUtvZjFnY3NOSXFYTjBXSFRNMDFML0x6bXJOeXY4?=
 =?utf-8?B?SVpSVHMrWW5MRzh6eUswRFRkNzA3TnFYeklvQVpOZjhsa2hmeURuRDhkZjYz?=
 =?utf-8?B?S1NsT2Fiazl4alo5R3FZdStvQjNyUUluS3Z6cko2b09kU0h2UmNWSjBxOHVF?=
 =?utf-8?B?ejZSekdBMTVQK0QzeUtaaHpORFdIUnpubXA5VlZGUzMxWDdKSWRNUGVOTFdS?=
 =?utf-8?B?VkhJTlptSVlrODgzMVZQeW5qT1p5Wng2Y3JET0NzR0Mvc21sMXdNdUkvTVhH?=
 =?utf-8?B?TGFTRmp0dWJJeE5pRXZDYmNmM2xCZ1o5b20rVktoUkh5Sm9JdjFaeHcybTBI?=
 =?utf-8?B?STIySDRoQkp0d2VWWDJ1VUZFYlZxRmJFQmZML09vZjBSMHhjb3htVGNTdk8y?=
 =?utf-8?B?R2RrbE44bk1Hb0VYRk5DYTQ4VkRkNGlWQ0E4Nk9seU9XV1V4c0c2VTVOYTlG?=
 =?utf-8?B?R2w2cktMVW1YRGJ1QTc0ci9jbGVrYTcyb0FBc0k1eThuYVFqaWsxWEtGVStO?=
 =?utf-8?B?eTYwcFhyQXFNdEFLZS9VQWpUMjBkUGRsNHlzbjNJcXprZTduYmpHZ3AzSmJo?=
 =?utf-8?B?Um03ZGp0ZlFLUlhMTmhmNmRUT29iT2lNMzFVTE5TaEN1cktRMXVOUXFsNnlE?=
 =?utf-8?B?cDVHSVlqY0hlUUxLT2NpbFJsWVZ2cnhGYmZ1LzMzekxNbFNQZnNJVFJKRUh5?=
 =?utf-8?B?MnVhVW5sT2k5TzF6TWN6L2VJYXRpWm5yWWhTV2U2Y2NPVjRJbjlCRnRZUjlq?=
 =?utf-8?B?RENFVEQrOTRIMVZNOVZ5WFlrM3BGRS8xSEhreDBYZ2ZkUHBFcjBKbEhqSlBj?=
 =?utf-8?B?RFFwK2N2MVNnTDZhdHp6SE9zbmVrN3REVWU1UEZzUGE4Vks4R3ZMTkdKVFVO?=
 =?utf-8?B?Z2ozMWpSVkswcTFoditGeXhoeHhVU3hDSGJnYlJPTFc5bFQvd2tFRUprTnB6?=
 =?utf-8?B?SC91bFlnV0M5Tk5CZyttMURTMENCMEdOMFVPSDA2TkF5Q1pDMEZkZS9nWnBE?=
 =?utf-8?B?djdXcE9ZNFV0NUxhSGwwRVhTWVlSNjhhUGtnYlIxa0h3dUxHRkxBb3hiVmln?=
 =?utf-8?B?ZC9JODYyNEhMMUNjOUIwK0hzb1pKSG8rMVBBdzk3ODNYRTVZUWU0QjNxZlpB?=
 =?utf-8?B?SVJaOFRBYnlPV3RBOExCM1pMNXYrLy9kdkNwekp6dkYrSmJnMFo0d1R5dndB?=
 =?utf-8?B?bXhnTXpNb2RsQUZRNWlOZFcwREI2Qy9zSU9FWG5iMnc2d2tvL2JxQ3NvRVAz?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15DE58C435E2264096546D4410B60E28@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6775.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a40f34-e2ff-4243-0ba2-08db6c80d4b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 02:41:18.2939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6hM5xweCmXC23trnXdYOwV8ccd52E4QtpS53Kh1w4s2YiIp6NHa3CJqKTTVnb19fml9yIbnctUP8SBOkAX5+6I4X1OCQlWS9bOsru8s0fmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7416
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTEzIGF0IDE2OjMwICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gIAkgDQo+ICBPbiBUdWUsIEp1biAxMywgMjAyMyBhdCA5OjU34oCvQU0gWmhpcmVuIENo
ZW4gKOmZiOW/l+S7gSkNCj4gPFpoaXJlbi5DaGVuQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4N
Cj4gPiBPbiBGcmksIDIwMjMtMDYtMDkgYXQgMTk6NTggKzAyMDAsIFJhZmFlbCBKLiBXeXNvY2tp
IHdyb3RlOg0KPiA+ID4NCj4gPiA+ICBPbiBGcmksIEp1biA5LCAyMDIzIGF0IDE6NDnigK9QTSBC
am9ybiBIZWxnYWFzIDxoZWxnYWFzQGtlcm5lbC5vcmcNCj4gPg0KPiA+ID4gd3JvdGU6DQo+ID4g
PiA+DQo+ID4gPiA+IFsrY2MgUmFmYWVsLCBsaW51eC1wbV0NCj4gPiA+ID4NCj4gPiA+ID4gT24g
RnJpLCBKdW4gMDksIDIwMjMgYXQgMTA6MzA6MzhBTSArMDgwMCwgWmhpcmVuIENoZW4gd3JvdGU6
DQo+ID4gPiA+ID4gRnJvbTogWmhpcmVuIENoZW4gPFpoaXJlbi5DaGVuQG1lZGlhdGVrLmNvbT4N
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoZSBwbGF0Zm9ybV9wY2lfY2hvb3NlX3N0YXRlIGZ1bmN0
aW9uIGFuZCBvdGhlciBsb3ctbGV2ZWwNCj4gPiA+IHBsYXRmb3JtDQo+ID4gPiA+ID4gaW50ZXJm
YWNlcyB1c2VkIGJ5IFBDSSBwb3dlciBtYW5hZ2VtZW50IHByb2Nlc3NpbmcgZGlkIG5vdA0KPiB0
YWtlDQo+ID4gPiBpbnRvDQo+ID4gPiA+ID4gYWNjb3VudCBub24tQUNQSS1zdXBwb3J0ZWQgcGxh
dGZvcm1zLiBUaGlzIHNob3J0Y29taW5nIGNhbg0KPiByZXN1bHQNCj4gPiA+IGluDQo+ID4gPiA+
ID4gbGltaXRhdGlvbnMgYW5kIGlzc3Vlcy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEZvciBleGFt
cGxlLCBpbiBlbWJlZGRlZCBzeXN0ZW1zIGxpa2Ugc21hcnRwaG9uZXMsIGEgUENJDQo+IGRldmlj
ZQ0KPiA+ID4gY2FuIGJlDQo+ID4gPiA+ID4gc2hhcmVkIGJ5IG11bHRpcGxlIHByb2Nlc3NvcnMg
Zm9yIGRpZmZlcmVudCBwdXJwb3Nlcy4gVGhlIFBDSQ0KPiA+ID4gZGV2aWNlIGFuZA0KPiA+ID4g
PiA+IHNvbWUgb2YgdGhlIHByb2Nlc3NvcnMgYXJlIGNvbnRyb2xsZWQgYnkgTGludXgsIHdoaWxl
IHRoZQ0KPiByZXN0IG9mDQo+ID4gPiB0aGUNCj4gPiA+ID4gPiBwcm9jZXNzb3JzIHJ1bnMgaXRz
IG93biBvcGVyYXRpbmcgc3lzdGVtLg0KPiA+ID4gPiA+IFdoZW4gTGludXggaW5pdGlhdGVzIHN5
c3RlbS1sZXZlbCBzbGVlcCwgaWYgaXQgZG9lcyBub3QNCj4gY29uc2lkZXINCj4gPiA+IHRoZQ0K
PiA+ID4gPiA+IHdvcmtpbmcgc3RhdGUgb2YgdGhlIHNoYXJlZCBQQ0kgZGV2aWNlIGFuZCBmb3Jj
ZWZ1bGx5IHNldHMNCj4gdGhlDQo+ID4gPiBQQ0kgZGV2aWNlDQo+ID4gPiA+ID4gc3RhdGUgdG8g
RDMsIGl0IHdpbGwgYWZmZWN0IHRoZSBmdW5jdGlvbmFsaXR5IG9mIG90aGVyDQo+IHByb2Nlc3Nv
cnMNCj4gPiA+IHRoYXQNCj4gPiA+ID4gPiBhcmUgY3VycmVudGx5IHVzaW5nIHRoZSBQQ0kgZGV2
aWNlLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVG8gYWRkcmVzcyB0aGlzIHByb2JsZW0sIGFuIGlu
dGVyZmFjZSBzaG91bGQgYmUgY3JlYXRlZCBmb3INCj4gUENJDQo+ID4gPiBkZXZpY2VzDQo+ID4g
PiA+ID4gdGhhdCBkb24ndCBzdXBwb3J0IEFDUEkgdG8gZW5hYmxlIGFjY3VyYXRlIHJlcG9ydGlu
ZyBvZiB0aGUNCj4gcG93ZXINCj4gPiA+IHN0YXRlDQo+ID4gPiA+ID4gZHVyaW5nIHRoZSBQQ0kg
UE0gaGFuZGxpbmcgcHJvY2Vzcy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6
IFpoaXJlbiBDaGVuIDxaaGlyZW4uQ2hlbkBtZWRpYXRlay5jb20+DQo+ID4gPg0KPiA+ID4gU29t
ZXRoaW5nIGxpa2UgdGhlIHBjaV9wbGF0Zm9ybV9wbV9vcHMgaW50cm9kdWNlZCBoZXJlIGhhZCBi
ZWVuDQo+IHRoZXJlDQo+ID4gPiBmb3Igc2V2ZXJhbCB5ZWFycyBhbmQgdGhlIG9ubHkgdXNlcnMg
b2YgaXQga25vd24gdG8gbWUgd2VyZSBBQ1BJDQo+IGFuZA0KPiA+ID4gSW50ZWwgTUlELCB3aGlj
aCBpcyB3aHkgaXQgd2FzIGRyb3BwZWQuDQo+ID4gPg0KPiA+ID4gSSB3b3VsZCBsaWtlIHRvIHNl
ZSB0aGUgcGxhdGZvcm0gY29kZSB1c2luZyB0aGVzZSBuZXcgY2FsbGJhY2tzDQo+IGluDQo+ID4g
PiB0aGUNCj4gPiA+IGZpcnN0IHBsYWNlLg0KPiA+ID4NCj4gPiBJIHRoaW5rIHRoYXQgbW9yZSBh
bmQgbW9yZSBlbWJlZGRlZCBwcm9kdWN0cyB3aWxsIHVzZSBQQ0kgZGV2aWNlcw0KPiB0bw0KPiA+
IGFjaGlldmUgaGlnaGVyIHBlcmZvcm1hbmNlIGZvciBkYXRhIHRyYW5zZmVyLCBhbmQgdGhlc2Ug
cHJvZHVjdHMNCj4gbWF5DQo+ID4gbm90IG5lY2Vzc2FyaWx5IHN1cHBvcnQgQUNQSS4NCj4gPg0K
PiA+IFdoZW4gZGV2ZWxvcGluZyB0aGUgTWVkaWF0ZWsgVDh4eCBtb2RlbSBjaGlwIGRyaXZlciwg
SSBmb3VuZCB0aGF0DQo+IHRoZXJlDQo+ID4gd2FzIG5vIGdvb2Qgd2F5IGZvciBUOHh4IHRvIHNr
aXAgRDMgc2V0dGluZyBpbiBjZXJ0YWluIFBNDQo+IHNjZW5hcmlvcy4NCj4gDQo+IFdlbGwsIGlz
IHRoZXJlIGFueSBjb2RlIHRoYXQgeW91IGFyZSBwbGFubmluZyB0byBhZGQgdG8gdGhlIG1haW5s
aW5lDQo+IExpbnV4IGtlcm5lbCB0aGF0IGlzIGdvaW5nIHRvIHVzZSB0aGUgcHJvcG9zZWQgaW50
ZXJmYWNlPw0KPiANCnllcywgTWVkaWF0ZWsgVDh4eCBtb2RlbSBjaGlwIGRyaXZlciB3aXRob3V0
IFBNIGNvZGUgaXMgdW5kZXIgcmV2aWV3DQpub3cuDQpyZWZzOg0KDQpodHRwczovL3BhdGNod29y
ay5rZXJuZWwub3JnL3Byb2plY3QvbmV0ZGV2YnBmL2NvdmVyLzIwMjMwMzE3MDgwOTQyLjE4MzUx
NC0xLXlhbmNoYW8ueWFuZ0BtZWRpYXRlay5jb20vDQoNCj4gSWYgbm90LCB0aGUgaW50ZXJmYWNl
IGl0c2VsZiB3aWxsIG5vdCBiZSB1c2VmdWwgaW4gdGhlIG1haW5saW5lIExpbnV4DQo+IGtlcm5l
bC4NCg0KSSB3aWxsIHN1Ym1pdCB0aGlzIHBhdGNoIGJhc2VkIG9uIFQ4eHggYWZ0ZXIgVDh4eCBk
cml2ZXIgaXMgYWRkZWQgdG8NCm1haW5saW5lLiBUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudC4N
Cg0KQmVzdCBSZWdhcmRzLA0KWmhpcmVuDQoNCg0KDQoNCg==
