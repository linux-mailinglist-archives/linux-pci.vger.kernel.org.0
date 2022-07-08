Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7270056B86A
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jul 2022 13:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237672AbiGHLZ1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 07:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237594AbiGHLZ0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 07:25:26 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2093.outbound.protection.outlook.com [40.107.114.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EEB88F38;
        Fri,  8 Jul 2022 04:25:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l724cl/pWIFt2HQUDD0TDHUp6kyuyn5FQv/0cbBqFFSvHCIdVMNGixJN7+O1IHvs0Mw/2BzyZ80+dl6odgL4Sct2P9saOPQx1eQ3um99wP68AEKtF89oVZNkfG6Fdoau+On7pPQpQRYBNlw4F5AXGw8ggzVeaKq8IFpbxJhcBlfgOxd1zecnAMJtSny7Wx1tc91D/3S1SsgqUGbdRPBbTZ993a0t7m2uT8FKblzac3nfKNv0EZH1t3bRKp2cN8VYUQOnlHUAuimIV9abfpjOM+9rOUFphy7BdxpFGmU67cRRxsrgxv6o12rwXE4J6ul5Y2mmWDoliLi6geyoxyc8fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T059K0wYXKaVCCQb/4MRrB7MhJJLQfNLD1nydIB1cNA=;
 b=MS5E03KFkKVUj60sE2VlEuCGZACsHeq1Gp+mcAaVIEy8et9eZPF291GvQ69Y2YAGBtHvypUlPWh9MJrJme4eGxCe8XGvTm1FKRUCRuiBT6FNDESSjebiUpCmfDCOhNRiZsCb9uODKdKPRfiBWNzURkYoNKq6aZBQew8St7lgpcDfrUavRptGfe7qriLUiO/Rb0Xl+HhcCxtOUztRG29vrDP7JhfIVHdWwJAt4UXj8jraEtQlGAdaE3+JNCEiiGf1ruGNOrNiC0PPB2SEcscu4OjCNgUVoorSs2FqZyLPYe3xXcU6ZU3jk3TM7Q1Ld8SXReDLbGsOgxMSHyZirH3RAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T059K0wYXKaVCCQb/4MRrB7MhJJLQfNLD1nydIB1cNA=;
 b=iUyHgGTvCbwEma0BJKW7FDZRXH5EnRLc/VRu4iJJiuEPL1WVOmou+Ta1QqqH1/gpM+RGVy0EgrQuPqfhOU87sdH4c+RQD0ROmskdr6YVECdzrKvWD/pAzbIddR9NkVjWFpXEmy+tcX2eotprn8W1VSfTuybzlzSubDR+6dM84sE=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB9432.jpnprd01.prod.outlook.com
 (2603:1096:400:198::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17; Fri, 8 Jul
 2022 11:25:22 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b596:754d:e595:bb2d]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b596:754d:e595:bb2d%6]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 11:25:22 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3 09/13] PCI: renesas: Add R-Car Gen4 PCIe Host support
Thread-Topic: [PATCH v3 09/13] PCI: renesas: Add R-Car Gen4 PCIe Host support
Thread-Index: AQHYjShAgQj55T6hG0WCdmXoYXKRcq1pm4MAgArExsA=
Date:   Fri, 8 Jul 2022 11:25:22 +0000
Message-ID: <TYBPR01MB534151AE3E0C042CC7C67793D8829@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20220701085420.870306-1-yoshihiro.shimoda.uh@renesas.com>
 <20220701085420.870306-10-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdVsOuLDbhBGrSO8r5i1WF+8scoLRNReyUW-tg4TQQL3gg@mail.gmail.com>
In-Reply-To: <CAMuHMdVsOuLDbhBGrSO8r5i1WF+8scoLRNReyUW-tg4TQQL3gg@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cdd0f8f-245e-45c9-7bc9-08da60d48bf8
x-ms-traffictypediagnostic: TYCPR01MB9432:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RuH29TeP8W9NHkvx+XDrNp2CHMo1Z3PIT5ZV/erZGRJ9wGMvYy73ksB1QF2uQ7FmZGzyYSYgNoTBd0+XTNgiuV7sKv5S54mfDYdYK56ELvU1lCdP6QbIe55RwLH2NzQG4B74hNxWtnS+yG/jWAC8J80mu7/nkL4ubyXk/O7heKgapl1/1bv7VNAKyRIf813PYd+llRES/r2rip5mfZXERqgRniox79jx4YVfNsCSRX3Mccr9C5/jjS6CEFAJKx9khqP1KIBxv4VEP4Kwlin5R8lScSwL6/0Dp4dkXhfgVmWJkEq2l84J80u/gR8uw2Lf6/kX93HWxBmvtmAEJ9sd0SY9puWT36Sr2EyfEwsymnM60VJiDl90RO78En0e0moacNG6tlRX6SZ0EFvBhyHcrnZ8k2T22Cu915yLRkyU+fVYsPAy+ovdWuGEjzOANCfW4eow/+y3frY+Pl2FNWQxK6DkKHIsm+DJJQaqsDiL3yr7ebPckcYTLn/ks1MlgdZfz43CsnSBojbjgqDWu3ZK1VzVey4D0e7uW4BQQJedhYxPO/Y+TQgS+lfRxWUc9A+ktnKrDHJoHHLu7mZMrTryNwGc9J8cxHk3pUFxOtUGMcaIWT1fRcKyFfNKJxSMY9vuhXQFAdg9XxwIAF9y6agJY2ocg5GkTqoqOax7kKkT38N5Rl6O1/Jj7QLKSbpRdlvHsK7MuOSTVhzz3Ooyr4Xn11bwkFr0bKJruPNkuKNFGc0EUpPLYpywqjfv1z6ENvY1zoD8hZEod1iQR4cNSm5rpMuqjmRby/2viZcThp46Q4epQvMV/lp75NCI3Pw1tIfh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(66946007)(66476007)(64756008)(55016003)(41300700001)(66446008)(76116006)(66556008)(478600001)(316002)(71200400001)(4326008)(8676002)(7696005)(6506007)(53546011)(38100700002)(186003)(6916009)(54906003)(8936002)(4744005)(38070700005)(5660300002)(33656002)(7416002)(86362001)(2906002)(52536014)(122000001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NG50ZGwyUnpjNFNkWFFyZnY2alJGNkNWT3ZlVWFwVXZIZVZGV2hlTkNpc2Ur?=
 =?utf-8?B?UGh4VjZJWXVubGltWjRsOEpDOS9rRXlvRFhFR0RtRDBGbmFGSmd1a0s4UVRO?=
 =?utf-8?B?NHl0eVk3LytYTnhua3ZFbVZkT3h6Q2VnajhTVDhZRmZWRDNnQiswSEV0STNE?=
 =?utf-8?B?WmNCN0g5Y1dFWkFPdmQ1clh2aWY0ZG45NDFEWHJkNldsWXVpQmdpaGlGVFVu?=
 =?utf-8?B?WGtHTVJpM2dtK0owR0RpaVkxd0U5Z2lKbU1tNDhFQ05mUVFxS2hMb090RGxL?=
 =?utf-8?B?QlUwTmRQeTVTaHBIZUQxNG8rNWJjTnEzUE90Rk90M2o2RWR1bWM3WmFPNSta?=
 =?utf-8?B?TXgzSFY2VnRCNGl1ci9BaU9aT1NXNmhrenJpMFZhQ2t0RU9waVNvMFQ4UklV?=
 =?utf-8?B?YXpPM0NFMUlLR2R2T0JuY0ZEb3h4YmxkOE9ZQTZzUm5mMXBPNFAwZzZoK2NX?=
 =?utf-8?B?NlpOWC9jQTNVb3NwSERvY0hOdklVcFJucFRRRzV6bzhnb0h3c1JGcnd2eWtE?=
 =?utf-8?B?eDFWbGRsTXZsdENLQjJ3Z3NCbHNwNExBZ1lTc3FzRHFRanVlaXBTNkduL0Zp?=
 =?utf-8?B?dUpqRGthRUxlaVkraGJFelNCYVVTYkNiNmZTRGFONXNtb0Z4Nm1DQys5RzRU?=
 =?utf-8?B?ZDRPR2hzQTlHbFA4M0xpRDZyOFpVV2FEdnNycEkxd0Uxb3NuTFdMR0xBV2Yx?=
 =?utf-8?B?NnVtdjdmVHBFT2xiLzlvQXJJSjYzTTk4bCtJTVZnR3FFU2VpYzFpdW82NHdv?=
 =?utf-8?B?MW81Qkhwb3B4R21VUUwzU0tpL2FBOUxubzlGN0dyWnhiajBYOUl0ZEMyS3c5?=
 =?utf-8?B?cmJyTnh6V1J1UVRwS3BiR3lrOHhqTFRiM2RvMXZhU0RJWUNNajhrUDhiVC9o?=
 =?utf-8?B?YXhmWkN5L1U5Q0xCQmU0RWs4aGR4V3ovaHpVOCs2SkF6WWs1MDJ2anc2b3Iv?=
 =?utf-8?B?RVBFL2k3NWNpTEtsZWMwM2dEVmFOaWJBREJDMmF0c3lLdmsySlFGaHFSYnJm?=
 =?utf-8?B?bGxlbTc5VkNUd3YxaGlTa3NsZEpYa3dmZ3hRUUJHVmZWUGpKaVVORmhpanB0?=
 =?utf-8?B?ZGhPbndJWDJJdHVkM2Mwajh6cXVGUUZ6ZVpSa1dDZ3ZEMVpia2E0ZWVMNGpY?=
 =?utf-8?B?SnJxUDczeGxJeXhKSDJmbzVQcDROV255WGpvSk51MHM0czdiR3VRekhDcDFs?=
 =?utf-8?B?WnBYQmJtVXVjbUYyc00vVHlhV2NwNDJyUjF6Qkx2TFkxc2MrdmVwVlozSGJ3?=
 =?utf-8?B?RkU1VTlHc0VnMmpnbWhSSTQ3bU9QVXQrTlVBWWl5WkRwS1pvUlpOUzFKTm93?=
 =?utf-8?B?RE5DY2ZtK1MyNHE3ci9UOHFmVEJCRkcxSis1Vk0yQ2dFdkJDRWVSUDNBa214?=
 =?utf-8?B?ZS9BakNhWlNhWTdWWFM2eTU2UXBYMU9tRnFieWN2TTI1NXhqUkg3amtuOTFW?=
 =?utf-8?B?V2hzMnEzTnZ5UHRCRnVvSThSNGdmLzk4cEx2LzB2TVNpNUhvU0JOSEFqN29E?=
 =?utf-8?B?dytlTUJWMitLclQzdkhrd0N1WDhkWjdBcDJiNWNEV2M1b1g4OEVta2xPVldK?=
 =?utf-8?B?TzVMcWlWTHViY1VOU20zdWxPUE5abnhTSkkrK09OR25EZFIzQjBvL0luQkJz?=
 =?utf-8?B?L211aGJHdlZxWDZuaDdBWjNaTmtYY0wrcDNpeU1JVWN3OCtsUnRXUlBlYnVv?=
 =?utf-8?B?Q1QzMWNRcUNjSW5iMW9FMGtsc0N4RkhxaHgzb1krY1V4TWM4T2dsYnh6WEc3?=
 =?utf-8?B?Q09IU29QQ1AxY0RNQ1dGM2dXK09zTDRPVXJyZHE1Rm9VM1VOV0Fic0o5MDFP?=
 =?utf-8?B?NFFZK3pseTdKL3BaaDlmRW03T29SZGRaWnQyaVE2UGgyOE1zdzBwQjFOU3dN?=
 =?utf-8?B?UzVtMnBuOEp0NExlLzhlM1EvSS9QOWNaeFZ1MTA5Ny9aVGR4Y2dLMDg3dDNo?=
 =?utf-8?B?R0E0Z0NIOVdCT0MrbzdZTVAvZEVtd1pQZE5Oc2hITUxwNHAxNGRQMEk0bnZY?=
 =?utf-8?B?d3Fwczl6b3gwVHRENCtWU2lPRm93dnk3TmJhdTZNVlphbDBiSWswa1pvbDFL?=
 =?utf-8?B?MkQvd1YwVmFyaERRTWRZOFduZXNiYjAvUVFlWEJ2SG15OTNMSGgwUVAyak9G?=
 =?utf-8?B?ZVlFaFdXelF6RkxGNGU2cjdHd1BBNzZQU0hORUNwdStsY254b1pLdzVRaC9M?=
 =?utf-8?B?LzJTd2dodjVaVExla3pMUDZjd1FVa29KQXFENkFJR05KMS9DYVpHRnJvVXdU?=
 =?utf-8?B?VHZjSVU4dmU1QmVvQmRKL2N5cWh3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cdd0f8f-245e-45c9-7bc9-08da60d48bf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 11:25:22.3684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VHAcqbgZOcmkBu1qHNTxwi0at+45heUKTobJrWtwrK8WNjtklbKBvve8kkPrsTzB+CbapEuej4Hrw+SdQIrJvag2VCfLCCt5XkJFkxLNTsaZJY+sl7WO9GdtNhTXh9KY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9432
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgR2VlcnQtc2FuLA0KDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiwgU2VudDogRnJpZGF5
LCBKdWx5IDEsIDIwMjIgMTE6NTggUE0NCj4gDQo+IEhpIFNoaW1vZGEtc2FuLA0KPiANCj4gT24g
RnJpLCBKdWwgMSwgMjAyMiBhdCAxMDo1NSBBTSBZb3NoaWhpcm8gU2hpbW9kYQ0KPiA8eW9zaGlo
aXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+IEFkZCBSLUNhciBHZW40IFBD
SWUgSG9zdCBzdXBwb3J0LiBUaGlzIGNvbnRyb2xsZXIgaXMgYmFzZWQgb24NCj4gPiBTeW5vcHN5
cyBEZXNpZ25XYXJlIFBDSWUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZb3NoaWhpcm8gU2hp
bW9kYSA8eW9zaGloaXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+DQo+IA0KPiBUaGFua3MgZm9y
IHlvdXIgcGF0Y2ghDQo+IA0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2llLXJjYXItZ2VuNC1ob3N0LmMNCj4gDQo+ID4gK3N0YXRpYyBj
b25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHJjYXJfZ2VuNF9wY2llX29mX21hdGNoW10gPSB7DQo+
ID4gKyAgICAgICB7IC5jb21wYXRpYmxlID0gInJlbmVzYXMscmNhci1nZW40LXBjaWUiLCB9LA0K
PiA+ICsgICAgICAge30sDQo+IA0KPiBQbGVhc2UgZHJvcCB0aGUgY29tbWEsIGFzIG5vIG5ldyBl
bnRyaWVzIG11c3QgYmUgYWRkZWQgYWZ0ZXIgdGhlDQo+IHNlbnRpbmVsLg0KDQpJJ2xsIGRyb3Ag
aXQgYW5kIHBhdGNoIDEwLzEzLg0KDQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8gU2hpbW9kYQ0K
DQo+ID4gK307DQo+IA0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUn
cyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnDQo+IA0K
PiBJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxs
IG15c2VsZiBhIGhhY2tlci4gQnV0DQo+IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMg
SSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0K
