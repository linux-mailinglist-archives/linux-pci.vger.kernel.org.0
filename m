Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8736F0299
	for <lists+linux-pci@lfdr.de>; Thu, 27 Apr 2023 10:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243120AbjD0IbZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Apr 2023 04:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243118AbjD0IbX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Apr 2023 04:31:23 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253A935A6;
        Thu, 27 Apr 2023 01:31:14 -0700 (PDT)
X-UUID: dc6eaa2ee4d511eda9a90f0bb45854f4-20230427
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=behlzJ7kADJdH96B5eIU9iC/GC1kHI1feLpUNnwI7Yk=;
        b=ZjkIB06+Zzf04CvsXvjU6/BcOOrP94gdLsQuATs1/tTZmhxQ5bS4+jap2ky6TVX/Q/wceLNZXdbG3j55xrsId6vusjet56XVLAO5rg3Fj0veVnCWc9aw1fryYu7776bdFh0J4E37FJtc2RZAQOLN6yUv7aNervYN1MdplHSDadc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:669c8f04-530f-45cd-9ac4-0bfebdf84847,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:120426c,CLOUDID:ae26156a-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: dc6eaa2ee4d511eda9a90f0bb45854f4-20230427
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 678845966; Thu, 27 Apr 2023 16:31:09 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 27 Apr 2023 16:31:09 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 27 Apr 2023 16:31:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djRfXIhCOGMHclnhGzCi07ihoc1D4tOhSqrdyY1KpaSqSRaed0WGrsqcHOECIfaM9CzTWWmQbVICs4Ox5DQ8lWNqL3QTfTA9AcK3UA1Mr2R3g91vb8yA5QEk1OLD4/cg9ZhUO+MlSw11mmjNouMAj+Fsm0xWYUyayrgOpyw/Prsk9S8W/HcAocIgqE2kDFdbFjyTMvb1Ksukdq6d+welZs4c7qq/UUSt2axmWTRaXK+4mqXL2TvAhXQBHv4c3uhGTEs4B2SroPcNRKUCUcPeeeMXCKXgjTmtEXkCNMUu0ZZx6xmnnRb2LhOD7eHj6aaE0ESfnuUKlGzNraq4dcd5yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=behlzJ7kADJdH96B5eIU9iC/GC1kHI1feLpUNnwI7Yk=;
 b=XUw9dsT55fpHcBBHA0VPIYirwbw4ZTyWBv54xkAuTyZCf/KrYSrKcQ+mC3Tqt1oMmyAdFiRlMKgLEQPl26JQ5EX5bVcytHDht6hx9bFEc0x+tJUBaapvq5vpl5x9aKoGmazY7UE4r2Hmv++TRGZyZWfu402l3T5f5P03LW8UC42JxWjv2TRn1N3ZO0CbYha+OU4yjm08HTDOYAZM08AYqPwNaX4a5rIUXN4yOTo5CoMUSlooOh32d8O0CUX2Sk5puyqSXRnn83WrNy6fjWd+cSqjOUUrlagp8lTn/mqHOn4RAnqI9Hnh3SMAqzHn+q5+cMNRIesCu4X3drsZd9NUHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=behlzJ7kADJdH96B5eIU9iC/GC1kHI1feLpUNnwI7Yk=;
 b=WFX0DdEwZ8qZpm+uB/AFu0CaMF5vaz1hSwFW+alwaIprIZxi23GUyGej09ayZP2YFQZuPFO7Z2G4ydPbLKh3SVZTUV9QqFDwy9mmr+6+OYdrRk6YHeqKZlO4ARPtSJDUlU6JYH2ukv7BVb+sO8ucUxxD9z/L1mu6xjmPRcN2UrU=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by TYZPR03MB5214.apcprd03.prod.outlook.com (2603:1096:400:37::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 08:31:07 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::6eca:1bb6:7d2c:a4e0]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::6eca:1bb6:7d2c:a4e0%6]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 08:31:07 +0000
From:   =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>
To:     "frank-w@public-files.de" <frank-w@public-files.de>,
        "linux@fw-web.de" <linux@fw-web.de>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?SmlleXkgWWFuZyAo5p2o5rSBKQ==?= <Jieyy.Yang@mediatek.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: Aw: [PATCH] PCI: mediatek-gen3: handle PERST after reset
Thread-Topic: Aw: [PATCH] PCI: mediatek-gen3: handle PERST after reset
Thread-Index: AQHZZWUN3oyBy4cfO0S7ujfcGrEDja8+AfWAgAD4eAA=
Date:   Thu, 27 Apr 2023 08:31:07 +0000
Message-ID: <74149a72313c1b944c870a45b55893e1b9331c8e.camel@mediatek.com>
References: <20230402131347.99268-1-linux@fw-web.de>
         <trinity-8c5502f4-34bc-456b-9e4b-37edac37c3ed-1682530907724@3c-app-gmx-bs05>
In-Reply-To: <trinity-8c5502f4-34bc-456b-9e4b-37edac37c3ed-1682530907724@3c-app-gmx-bs05>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|TYZPR03MB5214:EE_
x-ms-office365-filtering-correlation-id: 96e1be67-e8b4-4a6c-3fa2-08db46f9bf4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 098oIE9ENfoNYlwHxJUI2sQPQg5DXdPLOOM7NcT0TSxXMm8af0znul7b/g2Fp3crKjjisagxdfjwewgtmquAC9ardpAmL7wjmZ9u0VXfTfF3ZlzuWPw9twBiVl58Rq8xEi7SjCBTPpT4Hny4Dc7mdsmEO57ycgTsq9uYeyiwHI6uDHcXOnucvtO3A7yVZa07EsNZczTvGSQsrmsqLPlF/+g45jIM1lnGCQAZVy7ueUwBCM6zvhaV53qmpHgyZv+5HymOLZGq1PEc78mxghjndC+MWJgRTlspBRJ9EmE7cNWehyV6K+79MY91coRMWDfdSncMhYqpRsipP+7w9GfeAm5kod8VrwkX0GaNOYR7/o9FGpaCGF0At6yA7zGgaCaiOW6s/8fC8fsfDvIfzUxbwuH8GZ6cxe00N75P60hp/RKv7U1uT59IeWAzB547JRaEp+5oO57jNWlNCXVs5qBvUWauEfQGp3oN9w1bhx19FZ7lsnW/ViT1cjXYyOpp6CIn4eDjMll9um3Qely6sOMNKmBJitlbAnv4k9DMyP08rx9YXQtrk+8zMhU4sCSU+bb9g6Us8qfy+2pLlVnmyBmznURFbpXfRXjbL84j4nyjMLY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199021)(86362001)(38070700005)(36756003)(2906002)(85182001)(6486002)(71200400001)(186003)(83380400001)(2616005)(26005)(6512007)(966005)(6506007)(66476007)(4326008)(66556008)(64756008)(66946007)(110136005)(76116006)(478600001)(91956017)(316002)(66446008)(38100700002)(41300700001)(8676002)(54906003)(5660300002)(122000001)(7416002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2pxNE5jb0hiNkFzTWZtMjFaTkdoWFRqNHdGRzQ1UGt2Sk1pckhTWTRRd0h0?=
 =?utf-8?B?VHJqTVJkcCtSOWYvNDhaQTdURk9lbUlwVEI0THpLTWhPL29iSU0wMHlsVWdv?=
 =?utf-8?B?aE4yRlAxY2VsQU5XWUNYUEZBa1BXODdUM29UM09QUkVzZTVDSzNNTVVlak41?=
 =?utf-8?B?VjA1NzdGbXhIZ21GaHBTQ3laNDBMU05oT1pFb3pEczhWRHdPT2VpU2h1aWs3?=
 =?utf-8?B?NkwwbUlyS1hGckxDc013dmd0dTFjMXB4Ny8xU1FGa2FrQjcrMU81TThnTktp?=
 =?utf-8?B?emxKZGlJdFZHYU5iYmtabVFlbXk3NWIvVUJ5QXZDYlpreWltVWhVbVZ4N0NV?=
 =?utf-8?B?aHlSa0VaRGd5ZFJYUGF4SityZ1dJRVNwWnZVQTB6d3VKWjQ2aHA5KzUrNnRr?=
 =?utf-8?B?MGRKd2JsYnMxUXorZU5ENHlXd3h5SjFKcjZUMFhKOGlzcURVR0MxUnd4dXJB?=
 =?utf-8?B?Q0E0NUFNeXBDSkJ0OTJ3Z2ZSKzZjMWFzdWFvcFRyeG9TMms2eVh6NzFUemdP?=
 =?utf-8?B?M09jMzg2cFRQK1VmTmIyY0ZUSkJmK3Blb2JRVzZNd3V4VUZaQkVyQ240RnlI?=
 =?utf-8?B?UC9KektEYm9ydmRtVnNqYUpJSGtDZFdtODlONSsyV3M1R2RsN3FyZzlhbExG?=
 =?utf-8?B?MEdOaXNWeGl0SzREMkhRbS9PZldDbW9pTzF3V1BXZWVqemUrZlFURzB0TWpD?=
 =?utf-8?B?QXM3MmNXdE5EYlF2bG8vL0FualV3cEp6eTF2djlsRXhCNmpJcHRBLzBIdmVM?=
 =?utf-8?B?WW5GTUFHR1puL2NFYlpYZEVmVXUwc1ZuazFtN09kaWVaTzJEamZZUHVScWNx?=
 =?utf-8?B?WlRhM3ZtL29kU3NLUlIxU0xiZmMyYzk5QXpndnVnZS8rY1A2NTIvL3ZjK2w0?=
 =?utf-8?B?K25NTDluVTdlV0VUMDJmWFNIdnlxRkpDM0w2aEZWd053UnBnZXZ5bk5VTXlx?=
 =?utf-8?B?RlJmQ2FlY05vWU5BMGwzRkdPc2NHUEVNemlJQk42UGlpMDBwRVlVMTBKUUh1?=
 =?utf-8?B?Y2lrRG1iOEQrcGRMdERQL2UwMnZuTGR4SHJUZjBlU0VLL0dhSVArWVRuYjR5?=
 =?utf-8?B?WjJWTFJaVVQ3QlAwT09JWVJNMDNkSmpsS0pKWVB0dHcxZ2s5UXJlZVhMWUlW?=
 =?utf-8?B?QktxSnF1QTlBVUNEeUtNTXlyWVFEM3p2YnYxby90Q1p1TDNxYzFobGovcUI3?=
 =?utf-8?B?dTBHbnpOLy9tYktyUGRqdlpwV1h6amg0RUdjOUZ6OGY5bXpIdUtJUVQrdlZw?=
 =?utf-8?B?QWV5L2lIZkdjNGJyRlJFZXFkZUJmYkVQMS9pSUxXcjFOTGgzQlJUejR4OHYw?=
 =?utf-8?B?d0dRekNhMmw3ZDBQeE8zRVA1UGEvajFhM0crT0hjWktwU2pkSXpCK2lHR0R3?=
 =?utf-8?B?VjdEa0YyM2ZnU1NYdWl1b2x4M3h5RldSZWFaaFgrcjR3TC9FWWpqRURCV1Vq?=
 =?utf-8?B?NlFQT0dWcVBobHBZdHpEaHFycUhsL2NqQXZoVk40UWc3cmx0dkZrTTBaSVM5?=
 =?utf-8?B?NVdkSDd5WnFXUGJCY0Z0MHlWQWhuWmh0d2M4MGlOdjZKSnpJelErc1hvTC9Y?=
 =?utf-8?B?cTFwd0dEajFxNU1kaG5LaWhlVmMyOFEzNU5EakVOWTV6VnJ6VHZTMHVuSndS?=
 =?utf-8?B?TlBjTDJsQkEzY0Fic3VsS2RWL0dkUG1sQXhoeW15ZC8xbmxBSG50WFFzU1NJ?=
 =?utf-8?B?SDVocU5OeFNkYXY3enVNR0c5dkV4VGZERG1BTExqTmtFRFdJMEpUWkZjYWgx?=
 =?utf-8?B?Ky84UkZabzEvK3FPR2Q4WDBvRndXWnFvWHlscjZrVTZjRzh3SnNsaWJoSnJN?=
 =?utf-8?B?VDh2UjNZRnpGZ0JiVXFVaGp4cnpxN2ZNZzRvc2xDUDdYNXFBZVZSYVU2R01D?=
 =?utf-8?B?K2NJVEdxZHdYRlRqZkIyUUo5Mjlqb3N6WHB3Z0orOFc2akI1R0FkelRrMzFs?=
 =?utf-8?B?dUkwV1RIZlE5MEJHZFlRMmk1MjZibjBuTWl6d2tkZFBScXZTcjVMbFBzaW9k?=
 =?utf-8?B?Z01zTEFnK3huMFA5SFF5aTdFSmN2V2g1V1lHNS8wMWRYZ2tQWUtYay9LcHZa?=
 =?utf-8?B?Wnp6KzJDZkF3aFZ6K3BVZlRFOVNRcm92a1F1bzZ0SVI5R1cycHkrcEtHMklr?=
 =?utf-8?B?UXBYakVNams3ZllKYi9ja3h3dGNIanVQRFVQM3kwTmE2cmZ6V2RMNGczcFhZ?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0B356C1168E0E41AD839982A99A9F09@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e1be67-e8b4-4a6c-3fa2-08db46f9bf4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 08:31:07.2705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VhPVNlFxnBHh2BDNpby4X/x0I8OLGpTdeIWBT2+fEMKOkFJ3lmdwP8ibPO3y0OB/g4PYOSAFxeQdRXYLQGOmf5vAXSegofbEKRsS8slHAlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5214
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgRnJhbmssDQoNClNlZW1zIHRoaXMgcGF0Y2ggaGFzIGh1Z2UgaW1wYWN0IG9uIGJvb3QgdGlt
ZSwgSSdtIGN1cmlvdXMgYWJvdXQgdGhlDQpOVk1lIGRldGVjdGlvbiBpc3N1ZSBvbiBtdDc5ODYs
IGNhbiB5b3Ugc2hhcmUgdGhlIFNTRCBtb2RlbCB0aGF0IHlvdQ0KYXJlIHVzaW5nIGFuZCB0aGUg
Ym9vdHVwIGxvZ3Mgd2l0aCB0aGF0IFNTRD8NCg0KVGhhbmtzLg0KDQpPbiBXZWQsIDIwMjMtMDQt
MjYgYXQgMTk6NDEgKzAyMDAsIEZyYW5rIFd1bmRlcmxpY2ggd3JvdGU6DQo+IEV4dGVybmFsIGVt
YWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGls
DQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+IA0KPiAN
Cj4gSGkNCj4gDQo+ID4gR2VzZW5kZXQ6IFNvbm50YWcsIDAyLiBBcHJpbCAyMDIzIHVtIDE1OjEz
IFVocg0KPiA+IFZvbjogIkZyYW5rIFd1bmRlcmxpY2giIDxsaW51eEBmdy13ZWIuZGU+DQo+ID4g
RGUtYXNzZXJ0IFBFUlNUIGluIHNlcGFyYXRlIHN0ZXAgYWZ0ZXIgcmVzZXQgc2lnbmFscyB0byBm
dWxseQ0KPiA+IGNvbXBseQ0KPiA+IHRoZSBQQ0llIENFTSBjbGF1c2UgMi4yLg0KPiA+IA0KPiA+
IFRoaXMgZml4ZXMgc29tZSBOVk1FIGRldGVjdGlvbiBpc3N1ZXMgb24gbXQ3OTg2Lg0KPiA+IA0K
PiA+IEZpeGVzOiBkM2JmNzViNTc5YjkgKCJQQ0k6IG1lZGlhdGVrLWdlbjM6IEFkZCBNZWRpYVRl
ayBHZW4zIGRyaXZlcg0KPiA+IGZvciBNVDgxOTIiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEZyYW5r
IFd1bmRlcmxpY2ggPGZyYW5rLXdAcHVibGljLWZpbGVzLmRlPg0KPiA+IC0tLQ0KPiA+IFBhdGNo
IGlzIHRha2VuIGZyb20gdXNlciBSdXNsYW4gYWthIFJSS2g2MSAocGVybWl0dGVkIG1lIHRvIHNl
bmQgaXQNCj4gPiB3aXRoIG1lIGFzIGF1dGhvcikuDQo+ID4gDQo+ID4gDQpodHRwczovL3VybGRl
ZmVuc2UuY29tL3YzL19faHR0cHM6Ly9mb3J1bS5iYW5hbmEtcGkub3JnL3QvYnBpLXIzLW52bWUt
Y29ubmVjdGlvbi1pc3N1ZS8xNDU2My8xN19fOyEhQ1RSTktBOXdNZzBBUmJ3IW5DWEVNNjg1cGtV
cG9pWllHS3B0UFljY05yV01lTjJEM2pJTzVfaXJ3eFpKN2M2WnpFZUFDSXgtVjJXZVpIQVBfMEZL
bERESVEwUmJESjg5MnBydG9Ub0R2MzAkDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMgfCA4ICsrKysrKystDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdlbjMuYw0KPiA+IGIvZHJp
dmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdlbjMuYw0KPiA+IGluZGV4IGI4NjEy
Y2U1ZjRkMC4uMTc2YjFhMDQ1NjVkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL3BjaWUtbWVkaWF0ZWstZ2VuMy5jDQo+ID4gQEAgLTM1MCw3ICszNTAsMTMgQEAgc3RhdGlj
IGludCBtdGtfcGNpZV9zdGFydHVwX3BvcnQoc3RydWN0DQo+ID4gbXRrX2dlbjNfcGNpZSAqcGNp
ZSkNCj4gPiAgICAgICBtc2xlZXAoMTAwKTsNCj4gPiANCj4gPiAgICAgICAvKiBEZS1hc3NlcnQg
cmVzZXQgc2lnbmFscyAqLw0KPiA+IC0gICAgIHZhbCAmPSB+KFBDSUVfTUFDX1JTVEIgfCBQQ0lF
X1BIWV9SU1RCIHwgUENJRV9CUkdfUlNUQiB8DQo+ID4gUENJRV9QRV9SU1RCKTsNCj4gPiArICAg
ICB2YWwgJj0gfihQQ0lFX01BQ19SU1RCIHwgUENJRV9QSFlfUlNUQiB8IFBDSUVfQlJHX1JTVEIp
Ow0KPiA+ICsgICAgIHdyaXRlbF9yZWxheGVkKHZhbCwgcGNpZS0+YmFzZSArIFBDSUVfUlNUX0NU
UkxfUkVHKTsNCj4gPiArDQo+ID4gKyAgICAgbXNsZWVwKDEwMCk7DQo+ID4gKw0KPiA+ICsgICAg
IC8qIERlLWFzc2VydCBQRVJTVCMgc2lnbmFscyAqLw0KPiA+ICsgICAgIHZhbCAmPSB+KFBDSUVf
UEVfUlNUQik7DQo+ID4gICAgICAgd3JpdGVsX3JlbGF4ZWQodmFsLCBwY2llLT5iYXNlICsgUENJ
RV9SU1RfQ1RSTF9SRUcpOw0KPiA+IA0KPiA+ICAgICAgIC8qIENoZWNrIGlmIHRoZSBsaW5rIGlz
IHVwIG9yIG5vdCAqLw0KPiANCj4gSGkNCj4gDQo+IGp1c3QgYSBmcmllbmRseSByZW1pbmRlci4u
Li5kbyBpIG1pc3MgYW55IHJlY2lwaWVudD8NCj4gDQo+IHJlZ2FyZHMgRnJhbmsNCj4gDQo=
