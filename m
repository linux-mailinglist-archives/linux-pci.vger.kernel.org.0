Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5E15AA3E3
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 01:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiIAXqo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Sep 2022 19:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiIAXqn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Sep 2022 19:46:43 -0400
X-Greylist: delayed 714 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Sep 2022 16:46:40 PDT
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1115.securemx.jp [210.130.202.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FDF7C1A3;
        Thu,  1 Sep 2022 16:46:40 -0700 (PDT)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1115) id 281NYlLI029791; Fri, 2 Sep 2022 08:34:47 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 281NXVK1008867; Fri, 2 Sep 2022 08:33:31 +0900
X-Iguazu-Qid: 2wGr4d9xrFbDfCVpqr
X-Iguazu-QSIG: v=2; s=0; t=1662075211; q=2wGr4d9xrFbDfCVpqr; m=pyt+BGlcR0JlGt+mlDJ5VkirvQAzSOqdSrbYJtLnpQg=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
        by relay.securemx.jp (mx-mr1113) id 281NXSDe023113
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 2 Sep 2022 08:33:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7Vfmmf82am7zgAIDvobYZum3KaHfiFeEyNGjJZ4NVmc+nXdOFIz2nU5IzNUsmHeQi8j5DC5ZOIT+CBY8cFqZtLVzMPZlJyzMB8mnWwa+MvoSLIYEQzK2dDvtk2UgItoCbV6/MxmoVsW4zrQvU21NPsLmP5b5QZHq0iYkj4HnOMVhgRB11w0XdGVl3XTjbSq/NMAoGagkg2KKoPuYA2XbE8ecTW1VSuNrxHqGRjpI8Z7cpc24paAAqsD09NnywJ6QT9qV+NVwPgmvj+QXNygGbwuy1bCJ7svWaAG3YR7Aje8CLeA7kgDpKMAK7I6BwSQgjVaILNbLaQgSvTIUqJeiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=praOG0K/sFnS6rEdtQPkOR5Hl/iSCaI3v74333B2Azk=;
 b=IJ3vhW+9SbfG3z9J/31fpvTJLUKOxr1fT3bVowA7tXIwzbM8tw0ODnkAHAT9TxW9T4l6As3KVB973tF2Y+RxfalX/CBdBk2ecGgbZq+/5qxXw6oTqfEh0CW3a6xGpQAX9huj4S9FnYdCgF/NafW25cTBJdr0DzVLkCDrvKa4HSLUB9wLiGJRKAbxtmP/COgX71aa+evOAQpSmH1ew296px0orLf2M2W1C5PHKxZ5uB/7+EXefTay0oTCoRXjNH7W7F5YnD8l9sCDnAvnDWHPQO6u9JOP7M5FIsNCclIuIGsjiqr98jqDBTRVDW3EXOh/z1Doy6hBz6yK+BGOoreqsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     <Sergey.Semin@baikalelectronics.ru>, <robh+dt@kernel.org>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <fancer.lancer@gmail.com>, <Alexey.Malahov@baikalelectronics.ru>,
        <Pavel.Parkhomenko@baikalelectronics.ru>, <kw@linux.com>,
        <Frank.Li@nxp.com>, <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v5 02/20] dt-bindings: visconti-pcie: Fix interrupts array
 max constraints
Thread-Topic: [PATCH v5 02/20] dt-bindings: visconti-pcie: Fix interrupts
 array max constraints
Thread-Index: AQHYtlet6QFk3JOve06vSZaj9zDrTK3JtZvw
Date:   Thu, 1 Sep 2022 23:33:25 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB94203F5B2F3737448364719E927B9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
 <20220822184701.25246-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220822184701.25246-3-Sergey.Semin@baikalelectronics.ru>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d055b993-2059-473f-7ea5-08da8c725df0
x-ms-traffictypediagnostic: TYAPR01MB6138:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TO4crLbNpX+X3Gv0yYWXK3Gop0hpdPLar2lnbEj+3nJvv4OwwjZvinpZCYXkqxU+88ly8BRSUOIVk7OvhybemWl/t/rTv0W4YARA67W1zF1CdL/2Xq742t+7Ig1Y57NQ/twkOjoLoKqbDwH1YziEYMcCoenxxg/t0BdpQyWmvGal5ltOCZovk1Jt+tFt02xY49NMg6BHRdtWB1YAP6gdu+oqm8b+NvM6K98k8aGB+WQySFT1/5ZB2QIv7zbKyejYQnpn72ckJ+/DUuO6bJb7GuoYt/wO4cnHvMrGIUAb3vDQ1HOPnwTiZIJ2P60sxZBHnTUdf7q0JiylhvbCd3gkYjZVsk82hCa5N3B+82HmMh3rIkcppbH17v1ohG0BLaDiilzHRYYP0zGnaAt339oV5dRg9GJeslcBT/P17JJsvK3UIpqYdrOrdjITpzA9d7rWkWg6O+i6LnSrq07X/FRqHi6qpktPInFuTZnn73oJyRZObrgYPyVnLbYX70U2EWF0xpNkAFTiZlz8qEct92XFisRYupWtNcN4C0DznzhRbTQgcNQt/A4U83YauPmfCrE/6s6m5Pi8PhZlEQ7H9oxQLDLVICszipI4abLWjiwv82g5IyGqSnDs8TFRsciP3px+twPTVO+HS425Vkr4ow0wGQgF13l6cBNPMUKvrQ4L+0RGuUZRvGRYRX2I3+ZzpXA2tUCa63cObQJmNDZYZXv/AlYTL6VY5Lg9H5bgDZ6pl6muzrwK31+kPIvH0iPfq8NPndhJwsS2Zn0EfLntUUhrfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(110136005)(71200400001)(316002)(54906003)(52536014)(8676002)(4326008)(8936002)(5660300002)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(41300700001)(26005)(6506007)(7696005)(7416002)(2906002)(9686003)(53546011)(478600001)(38070700005)(33656002)(55016003)(186003)(83380400001)(122000001)(86362001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVVRdlM0TFJnV2ltNW53a1ZoUkhpZ2pBMTVBbU9Rc09uamRCdFVNQXVxT2Yx?=
 =?utf-8?B?S3Zkdm42RXpUcXJvanBEYnpvSU5EbVpwZFk0TXlBZ1VZbi81VXBJVUZOMWgz?=
 =?utf-8?B?NWZoS3RZTXdEd3AzSnNGVENBaVoySjhqU2hFaHh1M2VSVGdiQW9vdmR3VHZF?=
 =?utf-8?B?WFZMSWpZSnRPTVZLQmdVTGNCMFpWTmhGZ0RaSGZZMTdNbm82VEVkMXhRVTJy?=
 =?utf-8?B?ZURNK3d6ZmszbVhZWUtmYTZWYXdPM1BJNk0rWkIxUzJEemtzVTE0UUdvVm4r?=
 =?utf-8?B?U1RTekdVeld4bUM2SlRWR2xwSGRSVzl1QitYSzB2cW5FZFNYenZBUVpXWE1w?=
 =?utf-8?B?dzg2VSt4Z2gyNUhJS3Z0c3lyMVBWcGRwa2FUYU5TYktiZm5wU05yTTEzTEFt?=
 =?utf-8?B?UDJwZ0I3YnhUTDl5YWJwSDJxRXlVMzJXL2pGVDJsQjlEbVljTUIwWEM2S1Q0?=
 =?utf-8?B?b0Q1anlLSGtjY0hDRVJ5MkcrN01HVFF4UHA5VWJQeHVqWnM3WG1uQ3AvaVQy?=
 =?utf-8?B?OTJLNUhKd01PdnNuemFuVldaZ0FmYVg1WFdwY25HaXJEbEwrR0h1Nlk4YTNT?=
 =?utf-8?B?WEdOTlNUWUtsNU9WalhvZXA2N2hHZzFhVGVNU0x5REE0cEVpYnRjLzVuK254?=
 =?utf-8?B?N0xMMHNRM0dmSUc5TlNIMVozT2ZKNlJ2QnB0ZWhFbUhLWU5XSk9NaXpVc285?=
 =?utf-8?B?Z2ZZNVlyVWxXUUNSUy9WU3NGbVN6Rlc4bXozYXFrY05mY29qSm92R1VSUG9H?=
 =?utf-8?B?dklpWEJmUXk1cDN5RDZ6S3RVdHRQM3gxSWFFV2U1aEJSSU1WaHh0cHF6UDE0?=
 =?utf-8?B?YWVqYzVVbjd0ajc3bGpxV3FQcjJaYnhqZUZMemJyZXgzdXZtbkNDZUFJQmtP?=
 =?utf-8?B?d0xLbCtoMVJOVkZ0akY1QnVQVGRkcHpXWmRXTUFaMnczRnJ3QU1LSmZTMndS?=
 =?utf-8?B?NmJEUlJicVdNN1UzaGJuMEV3SGp0ZE1FZnZTamVYRm03S1pnWU11L3A1RzdO?=
 =?utf-8?B?bWFIVzBIUnVLamhIUFBBQ3Q1Y2daKzdDeHJETGRENU0vcjVSdWlvZm9jOEVK?=
 =?utf-8?B?QmdPVjRFVjhicHhmaHdvTkJhVElJUzN6OHp4VlBZSVl2R1BndDRLRmZVRjZ3?=
 =?utf-8?B?TXA2L0dRSytTcVprbFJ3dDJxY0lJSlovVzJ4NWQ2QStxbWxHdDlXQ1U1aWFa?=
 =?utf-8?B?Vyt5djVyRVBna3NMbnBsYW84Zzhoekw1Sm9YVmtEV2g2MVgxcEthWWptWmdF?=
 =?utf-8?B?c2ZVS0YzMHBiRnJycDZtbktQUlpYbk1BSDhJMFBTTVBrMWpXbm1ab0ZpUjdT?=
 =?utf-8?B?dFJvUXQwNHpSZDlpMGNnWTJvMDBvWS9KdDlqeW4yWkx6Q0lmakFYdk1UdVVM?=
 =?utf-8?B?QTlmMExINHpUOElIMllYMTI1ZFZtV3VycWJnZHlmZWxyNGNLZVkxWW9YblZi?=
 =?utf-8?B?Smw2ZlZEWXo2SFNWUDJjQ1l5N0Rmb1pMMjZBS3A1em8rOHZJNDRvYUs1UXpy?=
 =?utf-8?B?dFEvYkYxZU43TXlXOGFUalZDallTNkRqUmE3WkRQZkNLaFpZcEVBWksyek85?=
 =?utf-8?B?NEg2eUd1RkF3NVRicFJ2dGFueTVtMm0zd052OTBKSk0rT2FiZ09Mb0gwNU1z?=
 =?utf-8?B?bklvRnJlanp4NWROWUk0eE02TkJjRm1GSmphdHdjQ0t6T1cxcTg3QVlOQ1Fk?=
 =?utf-8?B?UTN0bTUrT0xFOU1GSXNvSHlnbmxsN2xEVmpvTUZNd3RmWWJSc1RyTlZKbGx2?=
 =?utf-8?B?RWcrRUUyTG1TbThwdm1mWjZwd2E4RXo3ZGMvT25HcExSTyttdSthMFBPZ1oy?=
 =?utf-8?B?ZGlVRFBEem44b1o3eTVOdXpGWFVzRVQyWGZEODNFdUNBYmpOckN0Qmhxc1Uz?=
 =?utf-8?B?Q2xUWlRRWTJidjgrOTRsWFRodlUrQzU0WFhwVzhjMDRKaS94WDRTbXlGVFhY?=
 =?utf-8?B?YmNzWVViWitrOFFFWlJMZlptR01Rd3d2MFhYelYwK3NLUHJ1dktFZjhyZnZL?=
 =?utf-8?B?Y2NRc0dQeG55VEJxdkcybVJxanNEa0prQlNYb29YT2JEUEg2ai95dG1IR2k1?=
 =?utf-8?B?MEE1bkJDQzN6SlF6b2lEVmQ4ZUxWcDc4RUw3QUk4dkZoM2xPN2dyTWFoN0Q5?=
 =?utf-8?B?SnM4QmZpY0MzZE02OElyMDhmVExBOUwyL0VFZDd0RFQ4aFVwT1N3WlVJMHZi?=
 =?utf-8?B?VWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d055b993-2059-473f-7ea5-08da8c725df0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 23:33:25.6236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ja41vp7toqW2ZwtNmEaQkg8tSfn0thSyJhdim6lxsGQT3hb31QGTdDO68/MlX0Z9PSrtqzIgSfIa0BgqUKBvrbcdX7N/NcXTqwIqQ1X2f989lJfpDXYlrX4uGTAhWXAf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6138
X-OriginatorOrg: toshiba.co.jp
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTZXJnZSBTZW1pbiA8U2VyZ2V5
LlNlbWluQGJhaWthbGVsZWN0cm9uaWNzLnJ1Pg0KPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMjMs
IDIwMjIgMzo0NyBBTQ0KPiBUbzogUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IFJv
YiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+Ow0KPiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5
c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+OyBCam9ybiBIZWxnYWFzDQo+IDxiaGVsZ2Fh
c0Bnb29nbGUuY29tPjsgTG9yZW56byBQaWVyYWxpc2kgPGxvcmVuem8ucGllcmFsaXNpQGFybS5j
b20+Ow0KPiBKaW5nb28gSGFuIDxqaW5nb29oYW4xQGdtYWlsLmNvbT47IEd1c3Rhdm8gUGltZW50
ZWwNCj4gPGd1c3Rhdm8ucGltZW50ZWxAc3lub3BzeXMuY29tPjsgaXdhbWF0c3Ugbm9idWhpcm8o
5bKp5p2+IOS/oea0iyDilqHvvLPvvLfvvKMNCj4g4pev77yh77yj77y0KSA8bm9idWhpcm8xLml3
YW1hdHN1QHRvc2hpYmEuY28uanA+DQo+IENjOiBTZXJnZSBTZW1pbiA8U2VyZ2V5LlNlbWluQGJh
aWthbGVsZWN0cm9uaWNzLnJ1PjsgU2VyZ2UgU2VtaW4NCj4gPGZhbmNlci5sYW5jZXJAZ21haWwu
Y29tPjsgQWxleGV5IE1hbGFob3YNCj4gPEFsZXhleS5NYWxhaG92QGJhaWthbGVsZWN0cm9uaWNz
LnJ1PjsgUGF2ZWwgUGFya2hvbWVua28NCj4gPFBhdmVsLlBhcmtob21lbmtvQGJhaWthbGVsZWN0
cm9uaWNzLnJ1PjsgS3J6eXN6dG9mIFdpbGN6ecWEc2tpDQo+IDxrd0BsaW51eC5jb20+OyBGcmFu
ayBMaSA8RnJhbmsuTGlAbnhwLmNvbT47IE1hbml2YW5uYW4gU2FkaGFzaXZhbQ0KPiA8bWFuaXZh
bm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0K
PiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6IFtQ
QVRDSCB2NSAwMi8yMF0gZHQtYmluZGluZ3M6IHZpc2NvbnRpLXBjaWU6IEZpeCBpbnRlcnJ1cHRz
IGFycmF5IG1heA0KPiBjb25zdHJhaW50cw0KPiANCj4gSW4gYWNjb3JkYW5jZSB3aXRoIHRoZSB3
YXkgdGhlIGRldmljZSBEVC1ub2RlIGlzIGFjdHVhbGx5IGRlZmluZWQgaW4NCj4gYXJjaC9hcm02
NC9ib290L2R0cy90b3NoaWJhL3RtcHY3NzA4LmR0c2kgYW5kIHRoZSB3YXkgdGhlIGRldmljZSBp
cyBwcm9iZWQNCj4gYnkgdGhlIERXIFBDSWUgZHJpdmVyIHRoZXJlIGFyZSB0d28gSVJRcyBpdCBh
Y3R1YWxseSBoYXMuIEl0J3MgTVNJIElSUSB0aGUNCj4gRFQtYmluZGluZ3MgbGFjay4gTGV0J3Mg
ZXh0ZW5kIHRoZSBpbnRlcnJ1cHRzIHByb3BlcnR5IGNvbnN0cmFpbnRzIHRoZW4gYW5kIGZpeA0K
PiB0aGUgc2NoZW1hIGV4YW1wbGUgc28gb25lIHdvdWxkIGJlIGFjY2VwdGFibGUgYnkgdGhlIGFj
dHVhbCBkZXZpY2UNCj4gRFQtYmluZGluZ3MuDQo+IA0KPiBGaXhlczogMTdjMWIxNjM0MGYwICgi
ZHQtYmluZGluZ3M6IHBjaTogQWRkIERUIGJpbmRpbmcgZm9yIFRvc2hpYmEgVmlzY29udGkNCj4g
UENJZSBjb250cm9sbGVyIikNCj4gU2lnbmVkLW9mZi1ieTogU2VyZ2UgU2VtaW4gPFNlcmdleS5T
ZW1pbkBiYWlrYWxlbGVjdHJvbmljcy5ydT4NCg0KVGhhbmtzIGZvciB0aGlzIHBhdGNoLg0KDQpB
Y2tlZC1ieTogTm9idWhpcm8gSXdhbWF0c3UgPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNv
LmpwPg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=

