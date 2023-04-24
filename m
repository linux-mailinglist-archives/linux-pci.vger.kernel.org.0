Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081AF6EC5DC
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 08:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjDXGBo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 02:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjDXGAy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 02:00:54 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2097.outbound.protection.outlook.com [40.107.114.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885393A80;
        Sun, 23 Apr 2023 23:00:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByQGP0CkxCSWcowufbCwiUDNEYiEVRUSkQH4HlRo6JMQ9smXKQNoFuPgbeQ7HPrEIaNzHJK0byoeSarVGxOK9sM+F23ZTeYo4AXITuNpAZDwcD+Q4WgYjBi1hA+eetW5i23OPbtV+ndohDQBbAj7zSiHgpoEpCb6tZp3wtuWmVugxYfTf+G+OLg+bdeElMvzyBshS/AMZuDShm0tDHmpzoXsfJ4d27TwYi5shnW0YnTU6cDVVoJv5H7vFoR0PgTFo5vgzuzjdGsUn5Oq2ik99iAt0S6MnHAggssdvetRxG3zmibrlcdz+Ar/tTU/PUmfLN2WdkqR4/G8HmKx99G7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1SXn63FNziHDwkNwMtlyIdn5IXYOwjzyx8GkB1WYBc=;
 b=cu58zjCpK05x3bFlLSbVWyKlXNI7a+Ktw4qVD5yIaCw+qByfNA6klUyoZpcImBT85NyLxKUFPJCfVMeM3+Bbpc0spfhvzZeN8BOupvAAZwAIstOM6EKI7gCsnmmvkz8qSxTZTHHr5z9XsEpjKp3xrvSN5IJHRee2zZfR+Z0POlw/iDMvkZVwlEgxySI0p1bqEvEsJdePVK04PwdfQaIDzueWZmZnOBZqYhYj9TRj34NRTsQ3b80W4H/8lGThzOXWkqx8vGcIYyolx1D7yr5Mdf0PmMUAuF2iLSQt9fB6J3uZVb4vhv8LHQ0lKIr5xVMsBPYS1aCvq+V84x+R9fO9cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1SXn63FNziHDwkNwMtlyIdn5IXYOwjzyx8GkB1WYBc=;
 b=jXwXb7f0zEo/8QkYJ0HWOsbCxAqwRBXtUf3CW3CMYTIbdsvzX7suP2DVoS3+pwMEnxR9YGIDnaJw4ZuO8ICiFENuLlhUT2v4+FSTTsKPyYs2I5T/mwtRe+aiOoWcwWpMOezlaLfpwBibHTyiT40MPl0bIvkpVoFPr+KezL15MDE=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB10195.jpnprd01.prod.outlook.com
 (2603:1096:400:1e7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 06:00:10 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%5]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 06:00:10 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v13 13/22] PCI: dwc: Add EDMA_UNROLL capability flag
Thread-Topic: [PATCH v13 13/22] PCI: dwc: Add EDMA_UNROLL capability flag
Thread-Index: AQHZcfCxw9eO+7fbFUiT9d/QyNBfDK83YLoAgAKYaaA=
Date:   Mon, 24 Apr 2023 06:00:10 +0000
Message-ID: <TYBPR01MB5341963F97F448F4A3CA37DCD8679@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
 <20230418122403.3178462-14-yoshihiro.shimoda.uh@renesas.com>
 <20230422135658.GJ4769@thinkpad>
In-Reply-To: <20230422135658.GJ4769@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYWPR01MB10195:EE_
x-ms-office365-filtering-correlation-id: 0dbf6e39-be27-4d11-b5ca-08db448929f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8QaOVC3ORoIp9LSfAufi/KAFb5LKiiUs7HA/9G+W7ZDwmtqCfaolSJzhUolmpq/gkER5GW8hpa1Ph0EueLhH/Zh6sJBriCZTBzRdRz4FbUHhbcKX4n+NJA4IT+euIgVaZAAPyRzuzzNx9KmlgehtuBZaMYIWUMkI6DcM8RBQouLwJ7aBy1QRGM1EU5e/B4wPHtVrZ+3S/w9B0bOeJr4PF1l1xImaNqc9JdRpAa8MabMRDdignM8YnjESrKBhzXYIuGGpW+v+m3/53pYmwJX+uxuFkwO88dQcZ/nH/M9ZHovd4I3khtUm91g9rNyx2ljlDBTM0IV7NgUp0vkhFueVXqsWffY0h9gSxDYPAxHzD6P8K26z6MqfN+zfL6wzvNVfjfxVY9PkITRAbaRQiZ54nOBnw4lsZnp9R4B2M/KbZUZ7dWU0a2YMu2Z2DRgHdHu9CP1UogUEMfPLfmm9ZYZDxT/fNeJaNgBixpfY5+GNFvEVegYxYPwS2BDdiEcBTT5PW5bwAyS6206R4AA+n5ZeUkE94Inh9BJQFPZBTvBITLh+8xBb+7/HQV+i0LM0zizaQI91q0Jfr39QNt8BG40GEgahHfoZ0ct1A1u5rf9MxcDve2wZK8Lotyj6Mx7kS+2K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(478600001)(54906003)(86362001)(186003)(7696005)(9686003)(6506007)(55016003)(33656002)(71200400001)(4326008)(6916009)(64756008)(66446008)(66476007)(66556008)(316002)(83380400001)(66946007)(76116006)(2906002)(38100700002)(122000001)(41300700001)(8676002)(8936002)(38070700005)(5660300002)(7416002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHRSQUhpRkdNME9qUnVRSVhWSGY4NjloK1UzZ2hkRUtDTW9yZUFKS2hoYXln?=
 =?utf-8?B?dTRXN1hTay9hSFVNS25XTDhwdnlTUi85M3EvdGMzU0VRWlR1akh4TXZjbTZu?=
 =?utf-8?B?SmpZclZtL3JUTHZ6U3FVU1RkZ2dMWEhCQTh3eXVQb3ZhVzBBbFMvS0R3djhz?=
 =?utf-8?B?OWFkRWtrRlk1NGJBUU0renNPVzQ2RXFIbllMbnAvYlAyb2JiRzI1N0Jodm95?=
 =?utf-8?B?UmJLZm8wMnd2MDVVUFdXQ25zSmZYb25JZlZkK2pGL3hGakFxRElOcGNHWnlV?=
 =?utf-8?B?YkdEUTc1SUJCSTNBcmE2U29WUzhwN1o3TjNLOEN0SXFyN0NCWUJYd2ovWUVj?=
 =?utf-8?B?dkwvV1AvbFNJUzIrejlLQ2xvYlo3c2VVdERJYldmcXU1YkZOQ3B2OFhnaEtI?=
 =?utf-8?B?aUtabzdiUjV6WVVOWDZoSUhpSEN1WHNuWVlpcFBma2lCclFBcWl1d09EUWJt?=
 =?utf-8?B?cDN3RFhQU2hLWFd0RWN3ZUFzSEkzeWxwZjU4QUt4OFgraTFoM1ZxcnJhNXk1?=
 =?utf-8?B?SU9hNmFZUXdNRW0ydk5vWC9yWWFvY1NvaDQya3gvRklaTFFNQVNoQjAya0lY?=
 =?utf-8?B?ZnVlaFl5RzVOdEU1MTNEVGpNMW9jM2k4cHhucC9Da0dZN0V3L3FQYVZRMmJK?=
 =?utf-8?B?dGVWbmdMb1hZMXhlRlJRbVN2RHl2SHdqM3Y2a2lhQUxORHVocTNvOGQvL2dP?=
 =?utf-8?B?NUdDNGVPT2NVcm9DdmFHMWVyWWJKdUFTaXhzTlZTOEplMFdJcWt5S2VjYzdV?=
 =?utf-8?B?c2pCWmFCOXN3cS9EQnpUbDR0TWVSMzRsVWJhQllsR2RrMjZXbG1scy90UGY5?=
 =?utf-8?B?eTVWcEN1MEVGSjZGUEN2OFE5NDg0MWNIWW42ZWVxY240a1QwaWRPM0xDTGhK?=
 =?utf-8?B?azhZQ08zSGFxRmx6VFdsU2dSWHlCdUJOaCs2SmozNkJJM0R5Qi9aY3k5a0pa?=
 =?utf-8?B?TGxoQk5ONzcrN2R4MWdUU0U4VmdXWmF4WSt5UWdNUUVuOXAyMFB6Mlpqcm5n?=
 =?utf-8?B?SnF3OWptYm5Qelpta1RHVkdnS2F3YjdQTUN2ZGVGRG5ianZSMnc3UWhLR1g4?=
 =?utf-8?B?bW92SnJZbmZ2a0l5YUFySUMrenBnM1p3aEk5cXNwUU1UalVGODJ5djhJa2Rj?=
 =?utf-8?B?RWVCTTVNdmg5U3V3SUc5MzBpNjkyTU1pT2p5OWx4V2dqUDJuRGRIY2pWeE1H?=
 =?utf-8?B?TlYrS3hkWW9qeHZKZXk5SXBIUXI1b2xFZnNNTEd5ekE1aUZBVEcwdXFTdFBL?=
 =?utf-8?B?MkM4T3NlMEU4bXN1Zi9lMWU5RU9xV3FLOTdmWG9aUHlUNnRWMmxsd2JtL3VZ?=
 =?utf-8?B?OVhTVmlxODZkTkVoLzcxaks3Z3c0TDM4QWttdHhQTFloV1pCb3prYmNiTDZK?=
 =?utf-8?B?ODUyZERRM3UvaUx4QmRlTnNEdFNYQ0F5bCtrOGtjVmthRytnTjdaTEwrZW1N?=
 =?utf-8?B?QVhzSEZrUGFXRkpGUytiMjlYemdwd1MvRnRDRFZMbFYrYS9VeXk2em5uUjY1?=
 =?utf-8?B?Ylh0UkNuL3BVZHNzUHJsYjdSMFE4cjVYTzdxZWV0QmFpdmtoNExvUG1ValRt?=
 =?utf-8?B?N0hXSW5SWTllMFlITmtzSjZvb0g1R3Zoak02RUlkcGVxSFAxeDlmTDE2V1NI?=
 =?utf-8?B?OUhpZHpBaG5VNXVPS2VQVi81NytUNXpxekV0NUtVYnRrMkNoMVY2M2NNbk5p?=
 =?utf-8?B?RkZHKzdGVTNVNGM0RXE2ZmZqaWNlUUhQaUp4aW50UmhyMXU5VlVHaFNaaEJ0?=
 =?utf-8?B?V3dBckkyaUdaUkYwWGZtb1hZM1hKRElhamJhTHZ3QUFtdEFwRGhrVmEranRr?=
 =?utf-8?B?REVWZVpmUFNpeDlVci9mb3lGVmFsTzZVQ1lRbjNjdnZJbGJrWUJ4RlgyalFq?=
 =?utf-8?B?UlhOd3NFelUrSHJ3aURYNGk1Uk9KcXh4MlBnRVV3Zk54WW5CZWFaMjZkaHdF?=
 =?utf-8?B?VFJaVU1QcnBCUFNxcEVVM0JxYVI2UXlZTUtHYWh2RW1IbEZiN3hqUkR0NnN0?=
 =?utf-8?B?VWFQYzZ4ejdzU002c3ZrRUxhaGhFNnFubEIweVY3c2lDMXRwbXJ3ZnFlTkNw?=
 =?utf-8?B?c3hxS25Ya1pTSTJ1YSt3Q1k4UFRQRDEvUzJlVHZaUFQ4YW1pOTkvM254dzln?=
 =?utf-8?B?dlVFaGdTSFR5U1JpdzdqZU5xa09HVGxmNE5yMDhOdEEvaStYQXRvV0xJbG1D?=
 =?utf-8?B?U284bGYzMS9CQVNVMGcrazVDK2FHeit4MlZKWEk5eVA5UXlQRGtlL0hvTjlT?=
 =?utf-8?B?VldiS0x5S0RzVGJFOEhmYW9nRi93PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dbf6e39-be27-4d11-b5ca-08db448929f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 06:00:10.8325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wy+XwPSJ3DW8xkYzNZgfLqdLwv8TWzb98XuwsgpuvwPC3nHlB/odlg6JGhDLbB4mZcJPTfXOxJjrXKlhZqDvLr03QvdOZol2SXsozQBNKoNlmsupgC5MpxbTpqAtZSoG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10195
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTWFuaXZhbm5hbiwNCg0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6IFNh
dHVyZGF5LCBBcHJpbCAyMiwgMjAyMyAxMDo1NyBQTQ0KPiANCj4gT24gVHVlLCBBcHIgMTgsIDIw
MjMgYXQgMDk6MjM6NTRQTSArMDkwMCwgWW9zaGloaXJvIFNoaW1vZGEgd3JvdGU6DQo+ID4gT25l
IG9mIFBDSWUgY29udHJvbGxlcnMgaGF2ZSBhbiB1bmV4cGVjdGVkIHJlZ2lzdGVyIHZhbHVlIG9u
DQo+IA0KPiBXaGljaCBQQ0kgY29udHJvbGxlcj8NCg0KUmVuZXNhcyBSLUNhciBTNC04LiBTbywg
SSdsbCByZXZpc2UgdGhlIGRlc2NyaXB0aW9uIGxpa2UgYmVsb3c6DQoNClJlbmVzYXMgUi1DYXIg
UzQtOCBQQ0llIGNvbnRyb2xsZXIgaGFzIC4uLg0KDQo+ID4gdGhlIGRiaSsweDk3YiByZWdpc3Rl
ci4gU28sIGFkZCBhIG5ldyBjYXBhYmlsaXR5IGZsYWcgIkVETUFfVU5ST0xMIg0KPiA+IHdoaWNo
IHdvdWxkIGZvcmNlIHRoZSB1bnJvbGxlZCBlRE1BIG1hcHBpbmcgZm9yIHRoZSBwcm9ibGVtYXRp
Yw0KPiA+IGRldmljZSwgYXMgc3VnZ2VzdGVkIGJ5IFNlcmdlIFNlbWluLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogWW9zaGloaXJvIFNoaW1vZGEgPHlvc2hpaGlyby5zaGltb2RhLnVoQHJlbmVz
YXMuY29tPg0KPiANCj4gU2hvdWxkIHRoaXMgcGF0Y2ggaGF2ZSBhIFN1Z2dlc3RlZC1ieSB0YWc/
DQoNCllvdSdyZSBjb3JyZWN0LiBJJ2xsIGFkZCB0aGUgZm9sbG93aW5nOg0KDQpTdWdnZXN0ZWQt
Ynk6IFNlcmdlIFNlbWluIDxmYW5jZXIubGFuY2VyQGdtYWlsLmNvbT4NCg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuYyB8IDggKysrKysr
Ky0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmggfCA1
ICsrKy0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2llLWRlc2lnbndhcmUuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdu
d2FyZS5jDQo+ID4gaW5kZXggMjQxM2NkMzkzMTBjLi5mZWI2YWI5ZDQ5NDQgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmMNCj4gPiAr
KysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuYw0KPiA+IEBA
IC05MjAsOCArOTIwLDE0IEBAIHN0YXRpYyBpbnQgZHdfcGNpZV9lZG1hX2ZpbmRfY2hpcChzdHJ1
Y3QgZHdfcGNpZSAqcGNpKQ0KPiA+ICAJICogSW5kaXJlY3QgZURNQSBDU1JzIGFjY2VzcyBoYXMg
YmVlbiBjb21wbGV0ZWx5IHJlbW92ZWQgc2luY2UgdjUuNDBhDQo+ID4gIAkgKiB0aHVzIG5vIHNw
YWNlIGlzIG5vdyByZXNlcnZlZCBmb3IgdGhlIGVETUEgY2hhbm5lbHMgdmlld3BvcnQgYW5kDQo+
ID4gIAkgKiBmb3JtZXIgRE1BIENUUkwgcmVnaXN0ZXIgaXMgbm8gbG9uZ2VyIGZpeGVkIHRvIEZG
cy4NCj4gPiArCSAqDQo+ID4gKwkgKiBOb3RlIHNvbWUgZGV2aWNlcyBmb3IgdW5rbm93biByZWFz
b24gbWF5IGhhdmUgemVyb3MgaW4gdGhlIGVETUEgQ1RSTA0KPiANCj4gQWdhaW4sIGl0IGlzIGdv
b2QgdG8gbWVudGlvbiB3aGF0IGNvbnRyb2xsZXJzIGFyZSBleGhpYml0aW5nIHRoaXMgYmVoYXZp
b3IuDQoNCkkgZ290IGl0LiBJJ2xsIHJldmlzZSB0aGUgY29tbWVudCBsaWtlIGJlbG93Og0KDQpO
b3RlIFJlbmVzYXMgUi1DYXIgUzQtOCBQQ0llIGNvbnRyb2xsZXIgZm9yIHVua25vd24gcmVhc29u
IG1heSBoYXZlIC4uLg0KDQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8gU2hpbW9kYQ0KDQo+IC0g
TWFuaQ0KPiANCj4gPiArCSAqIHJlZ2lzdGVyIGV2ZW4gdGhvdWdoIHRoZSBIVy1tYW51YWwgZXhw
bGljaXRseSBzdGF0ZXMgdGhlcmUgbXVzdCBGRnMNCj4gPiArCSAqIGlmIHRoZSB1bnJvbGxlZCBt
YXBwaW5nIGlzIGVuYWJsZWQuIEZvciBzdWNoIGNhc2VzIHRoZSBsb3ctbGV2ZWwNCj4gPiArCSAq
IGRyaXZlcnMgYXJlIHN1cHBvc2VkIHRvIG1hbnVhbGx5IGFjdGl2YXRlIHRoZSB1bnJvbGxlZCBt
YXBwaW5nIHRvDQo+ID4gKwkgKiBieXBhc3MgdGhlIGF1dG8tZGV0ZWN0aW9uIHByb2NlZHVyZS4N
Cj4gPiAgCSAqLw0KPiA+IC0JaWYgKGR3X3BjaWVfdmVyX2lzX2dlKHBjaSwgNTQwQSkpDQo+ID4g
KwlpZiAoZHdfcGNpZV92ZXJfaXNfZ2UocGNpLCA1NDBBKSB8fCBkd19wY2llX2NhcF9pcyhwY2ks
IEVETUFfVU5ST0xMKSkNCj4gPiAgCQl2YWwgPSAweEZGRkZGRkZGOw0KPiA+ICAJZWxzZQ0KPiA+
ICAJCXZhbCA9IGR3X3BjaWVfcmVhZGxfZGJpKHBjaSwgUENJRV9ETUFfVklFV1BPUlRfQkFTRSAr
IFBDSUVfRE1BX0NUUkwpOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2llLWRlc2lnbndhcmUuaCBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUt
ZGVzaWdud2FyZS5oDQo+ID4gaW5kZXggOGMwODE1OWVhMDhlLi5jNGJkZmVkN2IyZTIgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmgN
Cj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaA0K
PiA+IEBAIC01NCw4ICs1NCw5IEBADQo+ID4NCj4gPiAgLyogRFdDIFBDSWUgY29udHJvbGxlciBj
YXBhYmlsaXRpZXMgKi8NCj4gPiAgI2RlZmluZSBEV19QQ0lFX0NBUF9SRVFfUkVTCQkwDQo+ID4g
LSNkZWZpbmUgRFdfUENJRV9DQVBfSUFUVV9VTlJPTEwJCTENCj4gPiAtI2RlZmluZSBEV19QQ0lF
X0NBUF9DRE1fQ0hFQ0sJCTINCj4gPiArI2RlZmluZSBEV19QQ0lFX0NBUF9FRE1BX1VOUk9MTAkJ
MQ0KPiA+ICsjZGVmaW5lIERXX1BDSUVfQ0FQX0lBVFVfVU5ST0xMCQkyDQo+ID4gKyNkZWZpbmUg
RFdfUENJRV9DQVBfQ0RNX0NIRUNLCQkzDQo+ID4NCj4gPiAgI2RlZmluZSBkd19wY2llX2NhcF9p
cyhfcGNpLCBfY2FwKSBcDQo+ID4gIAl0ZXN0X2JpdChEV19QQ0lFX0NBUF8gIyMgX2NhcCwgJihf
cGNpKS0+Y2FwcykNCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo+IA0KPiAtLQ0KPiDgrq7grqPg
rr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+NDQo=
