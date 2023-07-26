Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434A9762903
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jul 2023 05:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjGZDDw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 23:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGZDDv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 23:03:51 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2114.outbound.protection.outlook.com [40.107.113.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015841BCD;
        Tue, 25 Jul 2023 20:03:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fU5t3gqXLPBnj6di/4UIRhb2wjCQxtS1byoliFowyLGB3wjY2BRsGOQDUY79Tl5csyEO9A86dhXtvFfAi1GHuepKfoehpxX5UV4gDjY1bB0BV9FDLOFkfgZv2Em8BWeFAcwLeVgMuC5ZrcaYjHps/cyh6Yhj2PxH0HPbjJXnQyQKvJvAVhCjZ7HJTjr2EXkl1stFpkE9HUUKWDqwWlLitu7CB7FZffTRK8SmJjnduczqF5PlSvUrIsuwGPtvz9zu5MuJD8bcQNcviDU9GNc3P1Sj0h9bQkvEuNay9Odo2eNjJJeh+tJLBI5r+Q/sZKAq+8AvgIKK6w36BiYVeCStxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a94Mgd45nrCaqnCsqhiBFxVQJjMKmRwgXxS90VWr9gg=;
 b=LcW4tP+LsO0+i52OpEgszaIu+2nVoyyEjVM07/CGwq30lFga8CwFjNRdm4BaNdjKjxcazcuOVTqMi1z6ZTjqHjZeeXhKgLTxCPzs6rQX075Ir4m5zvFfAJuKxO4lciZDXCBc53WOle8tz3coGzk9OfnJHpi6Cw64EAefOaYlqChaARmvvqgjcbRAojR8yoGJ6DbfynIMuLRCwyD/7QycgLMrPcJHEJv6i6LbElj0RHH8wqIxtLfCCp2kd7Im1/vvzx/xhqkl5mKSpoNTIbOh9W6Jv849TBH3VTBENj4hLcSiL/EDm2eKBjvu+oDgSVyXv6T3udXIgcUarZZ3hA53ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a94Mgd45nrCaqnCsqhiBFxVQJjMKmRwgXxS90VWr9gg=;
 b=Q7tgrGQI1VnTIKUx/wmFJejdtD1n+mWCSEQ8eVyfymGtFOA5pu8/qbUdho6Q2LxD+SAWNgyGF2ec0Dk3FATRYE0zS1RlNCGBbgnj9dNjKUss92dIGqhhEsiQ+0CIkpxkBHGcAwjagA3/DRercYjVIUEwuwN5Q8quhZUP0UVbUUA=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TY3PR01MB10453.jpnprd01.prod.outlook.com
 (2603:1096:400:311::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Wed, 26 Jul
 2023 03:03:45 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 03:03:45 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v18 06/20] PCI: designware-ep: Add INTx IRQs support
Thread-Topic: [PATCH v18 06/20] PCI: designware-ep: Add INTx IRQs support
Thread-Index: AQHZu6dCHzUUyphweEqNuQMaFQsJjq/Im/qAgALH+sA=
Date:   Wed, 26 Jul 2023 03:03:45 +0000
Message-ID: <TYBPR01MB534172AB2D8AA33A889FC036D800A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-7-yoshihiro.shimoda.uh@renesas.com>
 <20230724083421.GE6291@thinkpad>
In-Reply-To: <20230724083421.GE6291@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TY3PR01MB10453:EE_
x-ms-office365-filtering-correlation-id: 6ebbc543-d096-4123-ed37-08db8d84ed11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SrXjPwQJWHG9lE47LOvcN0Q1LKkhnB2XftyKKxuRFc7BPliE+zNnplI/5xdds84+JJkXdlH/jB2Q8CP6/m33AGtK9+UZb3V5UOgIfrjYVV9hXhAJXnMXe3AnnmSj5Jn+yRN+vLxmfTGYlfs4kUyG6+DafsovbqnizC+VrbbS0fFTm5J2yc2v/kIXtis69M7U93Gu4bczwyzjbYSIxd5G6rJLTDPqBuVhEivauybN37BI+JcoZRWcXBws/mRQ+3EdwAutyzlyA09aDBMUmyJLSyo5LjylYoV9b8uzkgilMh7kA1zNtgXRS5n7Edw1DF80UBb61+/aSZNJkgMTPnfBdKNQJXiVFBAr7aAog41N9TuDSMe8cuvQJDJBizAvEt7/dh5o3W7WI57/cpcuXFdisIFnTonoPKOoGL8swp/+oEn/0tyYBmLo72wXEPgaRkxM3a3dmqLdbbrnplpq/i864m8jwOFGzEgTwUQ6JZaSAIpbDf6qmAUA0mqE0qhAA5nKztRjw50wWkpHg+vg9W9tueZp39SwSDEhafyzkoH74dl5gsds/XAfDDIU98MuCk0BkA+GmdqG4EfXGzVWGXj7ha/wB01CgYPqrKTt1bqpyctKHIJs5agOwRKrYVEaAWzd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199021)(5660300002)(38100700002)(122000001)(55016003)(64756008)(66946007)(83380400001)(54906003)(9686003)(7416002)(8676002)(52536014)(66446008)(478600001)(6916009)(66476007)(8936002)(316002)(41300700001)(4326008)(66556008)(76116006)(6506007)(71200400001)(186003)(2906002)(7696005)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czEwalEzd3M2SU85cmF0MmtRUktxcWp3bzUvZW5FQ0lVTVpFYzBnWmozNzFN?=
 =?utf-8?B?YnM1dkpyOFF5Q0VGS1ZLR25uMkMrdjRmQXdpRlRkUkVxR1BpWFFxUVdvZEJI?=
 =?utf-8?B?WVZSMjZkdXl4TUZNUXF4Y01wUzNhVC8xSEtmdnhxRXNxZFlvc0Q3cXdUMXYw?=
 =?utf-8?B?VmVhWE9aUTJXVDhyMkhSTXFGeG1FbnVNazJvTGJPYlBGaTBLNFJKaUhTM09O?=
 =?utf-8?B?ZjVCSy9VOXdEZTZOQXZyQ1BkbU9mUlZrVEJqYnlneXZxNmJ0SXdlbGRUWGQw?=
 =?utf-8?B?eWZlRUVsNW5Qb0JUdjZMRExuLzQyS3p5b1dpNVlrNUhHQ2tYWkN4NmlqR2Y4?=
 =?utf-8?B?WjE0azFmSjB1L0lqNlloMVdRRUhSWG1qQWwwSktaL3UwaUtYVXFSbUM0UUlI?=
 =?utf-8?B?MTRHVkliUEhXaGh5YVJKWnltMXo4TE1tamE3OWFhMXdrMUlmaEZZSnBVS2Yz?=
 =?utf-8?B?NHNDN1pMaUFmNFROTGNUdUJUTmI3bGJZbEtqMXBzRS9RK3VEeDVHeWk0dlBu?=
 =?utf-8?B?VGdBWVhWaWltaDJJRnlkdk5RM0l5WHFLc0cvOStXemtpVkQ4SGhJWGJFYmxm?=
 =?utf-8?B?bTBGNzUwbnY2UlNwMGYwQkJIM000ZHhlMTZMcnFBeXVhTXB6eit3LzBTNzN3?=
 =?utf-8?B?ZE5WZVBnMHA2azFqZGJmTGE4dGJJdFJoemt5NmVsMGFPY0N6QnhzcXJCKzJv?=
 =?utf-8?B?SDU2UFN1Y085ckdlbGNic25YYkgwYjBoVmFBM1RxSE9IYll4TFNzaFJFUVBx?=
 =?utf-8?B?c1dJcjZJU2ExcXVQNm9Sekcwc1NvTTNpSUJ5QkFpNWpzOEh2eGlzVHJ2N3kr?=
 =?utf-8?B?UThPZGVVT0FOdVA4MzdGWnpHN0ZHTjZ1engwM2s3aS9hcW9qVjRZY3kyMGJh?=
 =?utf-8?B?QUtmZFVhaDdJN1hCblMxVko5UEk1cFJhYW9wOUdXRmRlRTFWWW1TVS9xbGs3?=
 =?utf-8?B?ekdDRHFLcWRpQ2VueDI1T1lENjdhbm1CN3FvSEZKSzhHYUpSVmFKV1BaSTFI?=
 =?utf-8?B?T2hiVFJOM1pkaEE3UkNKVmhIMEpCN0VKeXlMOUY5ZHBncVdZNHIzcDJTOEpZ?=
 =?utf-8?B?M1k3Z3BuTmlvdnRyNnBDSVJEU2J1OGRFLzRzOTdJdEtKdkh6WDVyN3JEZkZm?=
 =?utf-8?B?alQ4dHJPZTNwYWhNZmdPR2NhcUZnemhDVUw0TUNHWm1iU0dCSkNrbURnUmVo?=
 =?utf-8?B?eWdMSW95dS9rU1N5WmUybWo4T1pKQzVhOGZCMWdPWVphZEF4YjBLSm81REp3?=
 =?utf-8?B?VUNheURZcXJNakp2eTJ0MzI2dS9DbFNRc252cDBTOUhwMlUyNXRoUzdXNWll?=
 =?utf-8?B?ZFBsZ1FiU04yd0dZU3F4elZEQ0g5bmo5QzVEUVJrWDBzaHZoU2YxVURMb295?=
 =?utf-8?B?T1VxS05yL01lTmlFNU9Ga012ejEzYXZ3WE1SU1BnQjREendhK0dwSXNlMkxm?=
 =?utf-8?B?QnYyaDM4T3RtL2ozMEtyMDJmME8zRnBVZWNKR3g5V2NWdTdZalEySFNlVUxM?=
 =?utf-8?B?N2VZRm1RbWJ4M21OSDVrVVk4NVBudTJUN1hyT0VaKzh5d2c5R1VOdXZPdytr?=
 =?utf-8?B?Q2pLVmRLQXQ0TGxCZzVXS1FwQnVRRGlnbVFCODJqOS9zVVBsVHFEMUMyTWla?=
 =?utf-8?B?VXJJSnB6amo1UDlWQXBhVjFpWThLNWpZdDlkUiszdHhPQUlmYi9PdFY0Z21p?=
 =?utf-8?B?cXo3ZHBzOVVFU3FKRDRwTWpza0U3NEFkcFR5VlBSRjNxbjlQNlk0b2ZjOW1S?=
 =?utf-8?B?eGZPa3g1YU5DZDBKQW5VMzhUR1BBall3cEZ4ejU5dURjajQ1Ym8wTk0vRlBW?=
 =?utf-8?B?VmFXOUxnL2RGQ1QyOXFsc0N3WGRSWUdBZEJ1ZFBvSSs5TFl0dFFNbTlXczFZ?=
 =?utf-8?B?RGhZSHdBZzlzelgrVjY3d3hrcERXVnNWdEpsMWxPRjlRZHU1R0dLTDlDOWxx?=
 =?utf-8?B?UEFOMGgrZHRaa0taREFNRVJmang5Tm9ROVZYSWV6V1lSRlhFN24vYlg4Vlhv?=
 =?utf-8?B?ZEs4Q2poNU90Y3JqT1NXSmluK0lPVUpHY0RYOGJkbmdvbzhwUm8rSXRHTmZk?=
 =?utf-8?B?Z1B1S1pWdHNJTUZod2dDTTc0VEhVTXM4UU5YekFvV3pTWUlUbDhHV3BCVU8w?=
 =?utf-8?B?MTZuRC9LUVRuSVdkTFBpelZMdGNqK05zVVhLZGNVY3dNN3hlTVVMT3Yyaytw?=
 =?utf-8?B?YTdJQjhuT2tldjB0WHJYSDBzakhNN0hWRU40bXVneWdhSnNMUm5iOEFGL1ox?=
 =?utf-8?B?bk13K1NTdzBKYzg1MWN0OW9xQTd3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ebbc543-d096-4123-ed37-08db8d84ed11
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 03:03:45.5361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IAVOyUiXzJ+S53jeVTCt4oOoN29RTVQVIQKBTqiqRnqRZZU/ZuICAvV/v6n/LjPUHrb11FEEwfOVe57VeudpN+xq8qhhLlq0QiaGyASjdj9VMJbkxyJ9PaTCC697Zcai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10453
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTWFuaXZhbm5hbiwNCg0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6IE1v
bmRheSwgSnVseSAyNCwgMjAyMyA1OjM0IFBNDQo+IA0KPiBPbiBGcmksIEp1bCAyMSwgMjAyMyBh
dCAwNDo0NDozOFBNICswOTAwLCBZb3NoaWhpcm8gU2hpbW9kYSB3cm90ZToNCj4gPiBBZGQgc3Vw
cG9ydCBmb3IgdHJpZ2dlcmluZyBJTlR4IElSUXMgYnkgdXNpbmcgb3V0Ym91bmQgaUFUVS4NCj4g
PiBPdXRib3VuZCBpQVRVIGlzIHV0aWxpemVkIHRvIHNlbmQgYXNzZXJ0IGFuZCBkZS1hc3NlcnQg
SU5UeCBUTFBzLg0KPiA+IFRoZSBtZXNzYWdlIGlzIGdlbmVyYXRlZCBiYXNlZCBvbiB0aGUgcGF5
bG9hZGxlc3MgTXNnIFRMUCB3aXRoIHR5cGUNCj4gPiAweDE0LCB3aGVyZSAweDQgaXMgdGhlIHJv
dXRpbmcgY29kZSBpbXBseWluZyB0aGUgVGVybWluYXRlIGF0DQo+ID4gUmVjZWl2ZXIgbWVzc2Fn
ZS4gVGhlIG1lc3NhZ2UgY29kZSBpcyBzcGVjaWZpZWQgYXMgYjEwMDB4eCBmb3INCj4gPiB0aGUg
SU5UeCBhc3NlcnRpb24gYW5kIGIxMDAxeHggZm9yIHRoZSBJTlR4IGRlLWFzc2VydGlvbi4NCj4g
Pg0KPiANCj4gQ29tbWl0IG1lc3NhZ2UgaXMgbWlzc2luZyBhIGZldyBpbXBvcnRhbnQgcG9pbnRz
Og0KPiANCj4gMS4gRURHRSBJUlEgaXMgc2ltdWxhdGVkIGZvciBJTlR4DQo+IDIuIE9ubHkgSU5U
QSBpcyBhc3NlcnRlZA0KPiAzLiBJTlR4IHN1cHBvcnQgaXMgb3B0aW9uYWwgKGlmIHRoZXJlIGlz
IG5vIG1lbW9yeSBmb3IgSU5UeCwgcHJvYmUgd2lsbCBub3QNCj4gZmFpbCkNCj4gDQo+IEFib3Zl
IHBvaW50cyBzaG91bGQgYmUgaW5jbHVkZWQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIHRvIHByb3Bl
cmx5IGRlc2NyaWJlIHRoZQ0KPiBjaGFuZ2UuDQoNCkknbGwgYWRkIHN1Y2ggaW5mb3JtYXRpb24u
DQoNCj4gPiBTaWduZWQtb2ZmLWJ5OiBZb3NoaWhpcm8gU2hpbW9kYSA8eW9zaGloaXJvLnNoaW1v
ZGEudWhAcmVuZXNhcy5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IFNlcmdlIFNlbWluIDxmYW5jZXIu
bGFuY2VyQGdtYWlsLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2llLWRlc2lnbndhcmUtZXAuYyAgIHwgNjkgKysrKysrKysrKysrKysrKystLQ0KPiA+ICBkcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaCAgfCAgMiArDQo+ID4gIDIg
ZmlsZXMgY2hhbmdlZCwgNjcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUt
ZXAuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1lcC5jDQo+
ID4gaW5kZXggZmUyZTBkNzY1YmU5Li4xZDI0ZWJmOTY4NmYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWVwLmMNCj4gPiArKysgYi9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtZXAuYw0KPiA+IEBAIC02
LDkgKzYsMTEgQEANCj4gPiAgICogQXV0aG9yOiBLaXNob24gVmlqYXkgQWJyYWhhbSBJIDxraXNo
b25AdGkuY29tPg0KPiA+ICAgKi8NCj4gPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4N
Cj4gPiAgI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9y
bV9kZXZpY2UuaD4NCj4gPg0KPiA+ICsjaW5jbHVkZSAiLi4vLi4vcGNpLmgiDQo+ID4gICNpbmNs
dWRlICJwY2llLWRlc2lnbndhcmUuaCINCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3BjaS1lcGMuaD4N
Cj4gPiAgI2luY2x1ZGUgPGxpbnV4L3BjaS1lcGYuaD4NCj4gPiBAQCAtNDg0LDE0ICs0ODYsNjAg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZXBjX29wcyBlcGNfb3BzID0gew0KPiA+ICAJLmdl
dF9mZWF0dXJlcwkJPSBkd19wY2llX2VwX2dldF9mZWF0dXJlcywNCj4gPiAgfTsNCj4gPg0KPiA+
ICtzdGF0aWMgaW50IGR3X3BjaWVfZXBfc2VuZF9tc2coc3RydWN0IGR3X3BjaWVfZXAgKmVwLCB1
OCBmdW5jX25vLCB1OCBjb2RlLA0KPiA+ICsJCQkgICAgICAgdTggcm91dGluZykNCj4gPiArew0K
PiA+ICsJc3RydWN0IGR3X3BjaWVfb2JfYXR1X2NmZyBhdHUgPSB7IDAgfTsNCj4gPiArCXN0cnVj
dCBwY2lfZXBjICplcGMgPSBlcC0+ZXBjOw0KPiA+ICsJaW50IHJldDsNCj4gPiArDQo+ID4gKwlh
dHUuZnVuY19ubyA9IGZ1bmNfbm87DQo+ID4gKwlhdHUuY29kZSA9IGNvZGU7DQo+ID4gKwlhdHUu
cm91dGluZyA9IHJvdXRpbmc7DQo+ID4gKwlhdHUudHlwZSA9IFBDSUVfQVRVX1RZUEVfTVNHOw0K
PiA+ICsJYXR1LmNwdV9hZGRyID0gZXAtPmludHhfbWVtX3BoeXM7DQo+ID4gKwlhdHUuc2l6ZSA9
IGVwYy0+bWVtLT53aW5kb3cucGFnZV9zaXplOw0KPiA+ICsNCj4gPiArCXJldCA9IGR3X3BjaWVf
ZXBfb3V0Ym91bmRfYXR1KGVwLCAmYXR1KTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0dXJu
IHJldDsNCj4gPiArDQo+ID4gKwl3cml0ZWwoMCwgZXAtPmludHhfbWVtKTsNCj4gPiArDQo+IA0K
PiBUaGlzIHdyaXRlIGlzIG5vdCBkZXNjcmliZWQgYW55d2hlcmUuDQoNCkknbGwgYWRkIGEgY29t
bWVudCBiZWZvcmUgdGhlIHdyaXRlbC4NCg0KQmVzdCByZWdhcmRzLA0KWW9zaGloaXJvIFNoaW1v
ZGENCg0KPiAtIE1hbmkNCj4gDQo+ID4gKwlkd19wY2llX2VwX3VubWFwX2FkZHIoZXBjLCBmdW5j
X25vLCAwLCBlcC0+aW50eF9tZW1fcGh5cyk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4g
K30NCj4gPiArDQo+ID4gIGludCBkd19wY2llX2VwX3JhaXNlX2ludHhfaXJxKHN0cnVjdCBkd19w
Y2llX2VwICplcCwgdTggZnVuY19ubykNCj4gPiAgew0KPiA+ICAJc3RydWN0IGR3X3BjaWUgKnBj
aSA9IHRvX2R3X3BjaWVfZnJvbV9lcChlcCk7DQo+ID4gIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBw
Y2ktPmRldjsNCj4gPiArCWludCByZXQ7DQo+ID4NCj4gPiAtCWRldl9lcnIoZGV2LCAiRVAgY2Fu
bm90IHRyaWdnZXIgSU5UeCBJUlFzXG4iKTsNCj4gPiArCWlmICghZXAtPmludHhfbWVtKSB7DQo+
ID4gKwkJZGV2X2VycihkZXYsICJJTlR4IG5vdCBzdXBwb3J0ZWRcbiIpOw0KPiA+ICsJCXJldHVy
biAtRU9QTk9UU1VQUDsNCj4gPiArCX0NCj4gPg0KPiA+IC0JcmV0dXJuIC1FSU5WQUw7DQo+ID4g
KwkvKg0KPiA+ICsJICogRXZlbiB0aG91Z2ggdGhlIFBDSSBidXMgc3BlY2lmaWNhdGlvbiBpbXBs
aWVzIHRoZSBsZXZlbC10cmlnZ2VyZWQNCj4gPiArCSAqIElOVHggaW50ZXJydXB0cyB0aGUga2Vy
bmVsIFBDSWUgZW5kcG9pbnQgZnJhbWV3b3JrIGhhcyBhIHNpbmdsZQ0KPiA+ICsJICogUENJX0VQ
Q19JUlFfSU5UeCBmbGFnIGRlZmluZWQgZm9yIHRoZSBsZWdhY3kgSVJRcyBzaW11bGF0aW9uLiBU
aHVzDQo+ID4gKwkgKiB0aGlzIGZ1bmN0aW9uIHNlbmRzIHRoZSBEZWFzc2VydF9JTlR4IFBDSWUg
VExQIGFmdGVyIHRoZSBBc3NlcnRfSU5UeA0KPiA+ICsJICogbWVzc2FnZSB3aXRoIHRoZSA1MCB1
c2VjIGR1cmF0aW9uIGJhc2ljYWxseSBpbXBsZW1lbnRpbmcgdGhlDQo+ID4gKwkgKiByaXNpbmct
ZWRnZSB0cmlnZ2VyaW5nIElSUS4gSG9wZWZ1bGx5IHRoZSBpbnRlcnJ1cHQgY29udHJvbGxlciB3
aWxsDQo+ID4gKwkgKiBzdGlsbCBiZSBhYmxlIHRvIHJlZ2lzdGVyIHRoZSBpbmNvbWluZyBJUlEg
ZXZlbnQuLi4NCj4gPiArCSAqLw0KPiA+ICsJcmV0ID0gZHdfcGNpZV9lcF9zZW5kX21zZyhlcCwg
ZnVuY19ubywgUENJX01TR19DT0RFX0FTU0VSVF9JTlRBLA0KPiA+ICsJCQkJICBQQ0lfTVNHX1RZ
UEVfUl9ST1VUSU5HX0xPQ0FMKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0dXJuIHJldDsN
Cj4gPiArDQo+ID4gKwl1c2xlZXBfcmFuZ2UoNTAsIDEwMCk7DQo+ID4gKw0KPiA+ICsJcmV0dXJu
IGR3X3BjaWVfZXBfc2VuZF9tc2coZXAsIGZ1bmNfbm8sIFBDSV9NU0dfQ09ERV9ERUFTU0VSVF9J
TlRBLA0KPiA+ICsJCQkJICAgUENJX01TR19UWVBFX1JfUk9VVElOR19MT0NBTCk7DQo+ID4gIH0N
Cj4gPiAgRVhQT1JUX1NZTUJPTF9HUEwoZHdfcGNpZV9lcF9yYWlzZV9pbnR4X2lycSk7DQo+ID4N
Cj4gPiBAQCAtNjIyLDYgKzY3MCwxMCBAQCB2b2lkIGR3X3BjaWVfZXBfZXhpdChzdHJ1Y3QgZHdf
cGNpZV9lcCAqZXApDQo+ID4NCj4gPiAgCWR3X3BjaWVfZWRtYV9yZW1vdmUocGNpKTsNCj4gPg0K
PiA+ICsJaWYgKGVwLT5pbnR4X21lbSkNCj4gPiArCQlwY2lfZXBjX21lbV9mcmVlX2FkZHIoZXBj
LCBlcC0+aW50eF9tZW1fcGh5cywgZXAtPmludHhfbWVtLA0KPiA+ICsJCQkJICAgICAgZXBjLT5t
ZW0tPndpbmRvdy5wYWdlX3NpemUpOw0KPiA+ICsNCj4gPiAgCXBjaV9lcGNfbWVtX2ZyZWVfYWRk
cihlcGMsIGVwLT5tc2lfbWVtX3BoeXMsIGVwLT5tc2lfbWVtLA0KPiA+ICAJCQkgICAgICBlcGMt
Pm1lbS0+d2luZG93LnBhZ2Vfc2l6ZSk7DQo+ID4NCj4gPiBAQCAtNzkzLDkgKzg0NSwxNCBAQCBp
bnQgZHdfcGNpZV9lcF9pbml0KHN0cnVjdCBkd19wY2llX2VwICplcCkNCj4gPiAgCQlnb3RvIGVy
cl9leGl0X2VwY19tZW07DQo+ID4gIAl9DQo+ID4NCj4gPiArCWVwLT5pbnR4X21lbSA9IHBjaV9l
cGNfbWVtX2FsbG9jX2FkZHIoZXBjLCAmZXAtPmludHhfbWVtX3BoeXMsDQo+ID4gKwkJCQkJICAg
ICAgZXBjLT5tZW0tPndpbmRvdy5wYWdlX3NpemUpOw0KPiA+ICsJaWYgKCFlcC0+aW50eF9tZW0p
DQo+ID4gKwkJZGV2X3dhcm4oZGV2LCAiRmFpbGVkIHRvIHJlc2VydmUgbWVtb3J5IGZvciBJTlR4
XG4iKTsNCj4gPiArDQo+ID4gIAlyZXQgPSBkd19wY2llX2VkbWFfZGV0ZWN0KHBjaSk7DQo+ID4g
IAlpZiAocmV0KQ0KPiA+IC0JCWdvdG8gZXJyX2ZyZWVfZXBjX21lbTsNCj4gPiArCQlnb3RvIGVy
cl9mcmVlX2VwY19tZW1faW50eDsNCj4gPg0KPiA+ICAJaWYgKGVwLT5vcHMtPmdldF9mZWF0dXJl
cykgew0KPiA+ICAJCWVwY19mZWF0dXJlcyA9IGVwLT5vcHMtPmdldF9mZWF0dXJlcyhlcCk7DQo+
ID4gQEAgLTgxMiw3ICs4NjksMTEgQEAgaW50IGR3X3BjaWVfZXBfaW5pdChzdHJ1Y3QgZHdfcGNp
ZV9lcCAqZXApDQo+ID4gIGVycl9yZW1vdmVfZWRtYToNCj4gPiAgCWR3X3BjaWVfZWRtYV9yZW1v
dmUocGNpKTsNCj4gPg0KPiA+IC1lcnJfZnJlZV9lcGNfbWVtOg0KPiA+ICtlcnJfZnJlZV9lcGNf
bWVtX2ludHg6DQo+ID4gKwlpZiAoZXAtPmludHhfbWVtKQ0KPiA+ICsJCXBjaV9lcGNfbWVtX2Zy
ZWVfYWRkcihlcGMsIGVwLT5pbnR4X21lbV9waHlzLCBlcC0+aW50eF9tZW0sDQo+ID4gKwkJCQkg
ICAgICBlcGMtPm1lbS0+d2luZG93LnBhZ2Vfc2l6ZSk7DQo+ID4gKw0KPiA+ICAJcGNpX2VwY19t
ZW1fZnJlZV9hZGRyKGVwYywgZXAtPm1zaV9tZW1fcGh5cywgZXAtPm1zaV9tZW0sDQo+ID4gIAkJ
CSAgICAgIGVwYy0+bWVtLT53aW5kb3cucGFnZV9zaXplKTsNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaCBiL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oDQo+ID4gaW5kZXggYzYyNmQyMTI0
M2IwLi44MTJjMjIxYjNmN2MgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9kd2MvcGNpZS1kZXNpZ253YXJlLmgNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2llLWRlc2lnbndhcmUuaA0KPiA+IEBAIC0zNjUsNiArMzY1LDggQEAgc3RydWN0IGR3
X3BjaWVfZXAgew0KPiA+ICAJdW5zaWduZWQgbG9uZwkJKm9iX3dpbmRvd19tYXA7DQo+ID4gIAl2
b2lkIF9faW9tZW0JCSptc2lfbWVtOw0KPiA+ICAJcGh5c19hZGRyX3QJCW1zaV9tZW1fcGh5czsN
Cj4gPiArCXZvaWQgX19pb21lbQkJKmludHhfbWVtOw0KPiA+ICsJcGh5c19hZGRyX3QJCWludHhf
bWVtX3BoeXM7DQo+ID4gIAlzdHJ1Y3QgcGNpX2VwZl9iYXIJKmVwZl9iYXJbUENJX1NURF9OVU1f
QkFSU107DQo+ID4gIH07DQo+ID4NCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo+IA0KPiAtLQ0K
PiDgrq7grqPgrr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+NDQo=
