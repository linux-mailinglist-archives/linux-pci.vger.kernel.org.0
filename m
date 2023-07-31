Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2571A76897C
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 03:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjGaBPL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 Jul 2023 21:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjGaBPK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Jul 2023 21:15:10 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2123.outbound.protection.outlook.com [40.107.113.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2AD1A4;
        Sun, 30 Jul 2023 18:15:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kM8GwoRfD9wBrHSCnn+co76PCGbzjt4dHZmUjCrTnFa0ICMHr5XQAu1BahHOFj5OhPtfNvW3k6AkqnlRvUn9ShTtb/3dxAXy7OSiKrEeJCedWT2PfxDR2O1DBj5iKv7bkp+IYyeHKuFLSei8ZPPsYipPuNAn/+63ka9mHHBTGEmJ9GTzdXQr+vgNL4roHCltXcreTzv5ztYwUVTnNO3hsbivv7eNxO+8X898TjIYWfxrJcZp+Sib56iBgQTKnfN2XcgEfquyD9DA2BoazW9QDFDPvmqHV5fzgAyFQbj0UJ/0yl8G4gqJOdKdl0OnaezTPi/idBfl5Z6MATFTLGiDnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGkLJ+aVbhFfzDbfmxST7dqzAHljBekFiDaLWykSt5s=;
 b=SQoUg1Ircehe8ySMhFBBzeSsa74xZlInOEtPe1FTgbsd9Cc7YNwjOF0VDtlw2YQjqRzmkTLVuy9/ybOX6e0t8sWQkCy54MjLWMNKg5c6FQ+WnWtFGLvmReK4d5P/OjdeOJq1FxnRl+JC8v6IsZgKjJzK3297JQ2j7WOKIbiPnKrY6O5B9FuPSnYazxWS8NgVxVWNPVNlSAA5QXp87r6nJ8uHs+W/q4yaCvrV+ppsT89cmO5IWkjXgooQUXDcYG9XLfaxo0Gvca+ybP6xFjvyHuvQjm4/i8wPbWwysP4jj+1Tg++gSsOoweHyah8T6qvwJdz0QWG9Sst1t4/ZcRuwfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGkLJ+aVbhFfzDbfmxST7dqzAHljBekFiDaLWykSt5s=;
 b=XWA3rCgPJLxb56pws4/B5HirjyYm8TetAWDykCEAYlwZFog1CcJw6jkNhsCgIfRL6f2KrWrnFT5a7kIRiafCXIu1tdiSgaBdsDnOFkRZHjtLFaEnD0WA9qC5AkCU4RKmvqkVm6Ksihtllc+/mK40RgvYaN3Ngt6myKNTKrWJYZc=
Received: from OSYPR01MB5334.jpnprd01.prod.outlook.com (2603:1096:604:8a::15)
 by TYCPR01MB11708.jpnprd01.prod.outlook.com (2603:1096:400:388::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 01:15:02 +0000
Received: from OSYPR01MB5334.jpnprd01.prod.outlook.com
 ([fe80::fe8:f613:9823:4075]) by OSYPR01MB5334.jpnprd01.prod.outlook.com
 ([fe80::fe8:f613:9823:4075%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 01:15:02 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v18 09/20] PCI: dwc: Add PCI_EXP_LNKCAP_MLW handling
Thread-Topic: [PATCH v18 09/20] PCI: dwc: Add PCI_EXP_LNKCAP_MLW handling
Thread-Index: AQHZu6dDGGGQ+OAg50C3BavsZe1ATa/IxbcAgAKD7jCAAzvRgIAAGFuwgADF+ICAA7m14A==
Date:   Mon, 31 Jul 2023 01:15:02 +0000
Message-ID: <OSYPR01MB5334ACE9FCE20E92B7776919D805A@OSYPR01MB5334.jpnprd01.prod.outlook.com>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-10-yoshihiro.shimoda.uh@renesas.com>
 <20230724110344.GH6291@thinkpad>
 <TYBPR01MB534165847452C8A2398B03D9D800A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230728025119.GB4433@thinkpad>
 <TYBPR01MB534130DF2431F0A49E0C5C3BD806A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <2zv7mcxa7skywhxe2ene3c5ycine6tsmsfwmpf4nknhoeye7rx@m525r5ph3xow>
In-Reply-To: <2zv7mcxa7skywhxe2ene3c5ycine6tsmsfwmpf4nknhoeye7rx@m525r5ph3xow>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5334:EE_|TYCPR01MB11708:EE_
x-ms-office365-filtering-correlation-id: 2a09545d-eb25-4395-ed7a-08db916390f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OOuNa2gH+3CKAE2TJINp8NPwj+DGaymBci7iQIs3lUpLD60J2ElE+iWc3UvJsHiNnXsodZh3W+9j0y0xPoLmZdlg0TZl7PMqaQxiLnCbH3E5AZ4TNFNT4pixnvuSbmhq2mw1B3KXD7BP93ZZ+0XRlSM2Azim4bBElKYV7IcLYWJVAYdLhgtCEKeqwe+QjUjGLN8Nxk9ECBDoj1rIquZ1wCkdY4NWN6IaKO5Aam68E9BtKo4VEg+x7urG0Ut7cUmr+vJul7hLej01A4iFa1isLFo4K6+D0whYxpvvkOEhpKRH+oFNrhUB6w66Hb8EEDjWQQ27eyGhl0Bsib7wAfYE9GvET/Wt+eduX1pvCPGUsh0llLPgOmNvxzJanZO29zoP9AiX1T0CvL//x/Z0MJhJ1/EFufKTRG5fWawlFJ2fygw+qeIuGpgwnzO3Q5ubWZct3L6346AetDmbFEAoobUdcZ9ttQbNIOOQS4WNLLC9c9WO0pwRBPPu9rv4nIN3I3AngnbcQ5As43v+9bGC2KwlAtAeHB4uCzGSxU7DaYyyc9j12iu3/TAMBBKq7gQtj4tlSC80/qUKX5iyxTE1dPO0SI0XI7vfOdPCntoJ+WQNisSMqIFsnDQ4tSj+fJcQNMwL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5334.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199021)(9686003)(7696005)(55016003)(6506007)(83380400001)(186003)(33656002)(76116006)(66946007)(52536014)(66556008)(7416002)(38070700005)(122000001)(54906003)(110136005)(41300700001)(86362001)(66476007)(316002)(66446008)(64756008)(4326008)(5660300002)(8936002)(8676002)(38100700002)(2906002)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjA4U0NZNEswcGJxdndEL1ZQc1NydVZhVUpua2pqWldoQVJMZElpbEZFMzU1?=
 =?utf-8?B?NHVjV0NvT2ttRUhlOW5JV2hLdnNxV2x4ZkZNaW5qVjk4MENzNThaNE04bytI?=
 =?utf-8?B?Tm1qZVJncktiS3dhUHRleU9sSXliZUJmanIxcGM3S1ljcEQySmUySUpHNEZE?=
 =?utf-8?B?R3RUdFVHUHZhdjlTWWNWcEhjTDEwU0Y1QW94MlAxZlBlUjk0Z25NdW5LakNq?=
 =?utf-8?B?NmprSTZjNWNpVFNhemQ5NVI4a1V5ZE5UcVpnZnFqVHpjaENwb0hTSGNQMGhl?=
 =?utf-8?B?R0JVaW42Wkx2WlN3Vk9yMklNRXoyV2tuOXBxY2g5am9BQTYzQkFTd1EzbDVY?=
 =?utf-8?B?dVp0SjUxTDZ2YjNGaTl0QjRDK0RaVjhXeWU4L0lUd093NjM0bTNGdGU4VlVo?=
 =?utf-8?B?VjNtck9USWV5Y1RQU1NrWU9Pb1lnYU91WWpvTnFlblVSdDE1azlGaXNOTU85?=
 =?utf-8?B?MUd1dmJ2TVFyUGVYOGYrR0MxaFRJZlpRU21ZS1RHTjIxdFUxRGZNbWhlQktU?=
 =?utf-8?B?NC9DU1NBc2VnSmRvc1ZHWHNGRC92TzIrRHVEaXZWUUxyRXNmcnJkUm9JWFhk?=
 =?utf-8?B?dVdHNjVlWENvT2F4SHhPZDh4UE5BYytFR0MvV2E2WlJEdGJzcnJQSTIwSlBh?=
 =?utf-8?B?R01VMWhBTWNZbUhhWWJQNnRHUE52dVdQV09IN1l1eUJzdlJkS3NqZFRGQWJW?=
 =?utf-8?B?ckxSRk0yNm9QUVVWVUtEMGtrOUJFNSt5UnVqa1JDK1RwMWwyTFBhVGhpMGk1?=
 =?utf-8?B?dGZDYjZSb1pWalBUTHlQcmtpdDB2Nmd3Y3M1eUhWcGdUM1BtWXBDOVpVam41?=
 =?utf-8?B?VVFYbVk4S1FGNVZrMThVbldOY3duck9LSUxXd2NnUTh2WUVueTBIZG5GSy9R?=
 =?utf-8?B?QmFRK3BDWjIwM1c3M1pUV2JhSWdEOXdmN2xOSlJJVG5rbExGM3Z0UjVINkhP?=
 =?utf-8?B?bi9RMk5iSnIxdG5uaHZzb1N2SjF6bjNFTGJSSURtV25XWmlOT2JMQlM3VkN6?=
 =?utf-8?B?T3Z2RnNCdk9OalBSRktSS2JLMkY0VCtYdXV6Z2VWdURnNm8vYk9XcEVNT1Ny?=
 =?utf-8?B?dS8zWnh1L0txV3YyZitPbnptaSszRDExQmNYN3FDeWlONzhKNk1tNy9CMEJ1?=
 =?utf-8?B?VEN1cEFueHVGektZWXRiV2hCUzNSWW52bFJtUnhkT04vNmhTZDRacTVUbUFS?=
 =?utf-8?B?dk5PMXdjQnJxTXM2OVIzOTBCRSs0VWxoa0dBT2ZvbzRadGlrbysrYXowbXJP?=
 =?utf-8?B?UWxwSE1lNjRQeHQvWENVV2Z3bHZmQ1c2Y2lObUFpN0pnT1VuNkZlZnhzUFpk?=
 =?utf-8?B?RHZGYlFTRUMzYllxNzEweFBENXdqWVQveDBteGRKWEVIVm04NWJRYzBLNTB5?=
 =?utf-8?B?MjB1MjhZT1UxeXRxbHc3dkxiYmtlSU1yT1VrOFdHZU9QeXZvTXhpTnkvTzBi?=
 =?utf-8?B?RkJKTHUwRkxGQmNaa05YbytmRVM3KzVyL1lOMTVEb3RxVldHR0llZENsbFgw?=
 =?utf-8?B?b1Rkend4MUJvdVQ5MFAwTWpDKzdzc296Q2lpZDNhWDJMWklZTWhHUmVzL1lL?=
 =?utf-8?B?VVI3UGFHK2pVVmNSUENONkt4UDJ2MGdOMXV1cEd6K2F3aENVVkZDTE9lMHB5?=
 =?utf-8?B?Ly9WYmdXNU95MWtRVmoxK2VQVGxMQ2VSTE95c1IrUlBRREo0NTM4KzZ3OW91?=
 =?utf-8?B?MHE1Z0NtNEFXOE9MWkFmVFVOVk9SR3hNMU9nTDZNaWJ3a2tNeGxIdE9GUFk4?=
 =?utf-8?B?N3M4N00zKy9XS2U3dXJsclYwSUJXcGhFK0F3YnM4bWVIb1BBRktLMXBGVldk?=
 =?utf-8?B?ditGajMraUdmdVlPOG1tZGFUSzBKeUt3ZzM4MHg1MnpOUGwyWHNzQVFJVDRN?=
 =?utf-8?B?d3NId0w5bjVsYnZ5bzdtOGo0bVhSRWN0a0FBMHpGRTEyMmZ5RXFOaWNKeTlu?=
 =?utf-8?B?MWVyVkpTakpSNFdjbkpUaGhSOHhmOSs0RUVKa2dSWHBpWEt5RElKRktYSWhy?=
 =?utf-8?B?L09zN2tETXBBQk9qaVpjK3g5MndHOHNiWWxpTm1yNWQ1YzFTb3RVY3QrUzVC?=
 =?utf-8?B?dVh4cFVYcVhINlQ3djZ0TTN5WjJjM0xVQ3FEbzdNWXBRMU9DM2NINVhOZUNF?=
 =?utf-8?B?aGdZRitqYjF4MnRiTGpsWWRhL3NIR05oQkltNHFCb2Y3Qlk1eFZkRVB6QlRW?=
 =?utf-8?B?b3FjbFo5WVdRS3hYT0k0VDhvNVYyeGoxWkRHaG1YWVYyUnAzRnBQMEVEYVov?=
 =?utf-8?B?YnNRaGtHdDNLNnROTUw0RWZHSnlBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5334.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a09545d-eb25-4395-ed7a-08db916390f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 01:15:02.2227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uSyOP3sdqBe9zcA/83ZvLHw8CSCB0e9BnZczAixvDUHZEKqifpMTb+bJLpA502DdYtvuPZf5mhFCcO73jNiuuj/kCVtJ4lMEn9m1rS2fHr55W1jczolepEizgsVQUg9x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11708
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgU2VyZ2UsDQoNCj4gRnJvbTogU2VyZ2UgU2VtaW4sIFNlbnQ6IFNhdHVyZGF5LCBKdWx5IDI5
LCAyMDIzIDE6MDcgQU0NCj4gDQo+IE9uIEZyaSwgSnVsIDI4LCAyMDIzIGF0IDA0OjE5OjM4QU0g
KzAwMDAsIFlvc2hpaGlybyBTaGltb2RhIHdyb3RlOg0KPiA+IEhpIE1hbml2YW5uYW4sDQo+ID4N
Cj4gPiA+IEZyb206IE1hbml2YW5uYW4gU2FkaGFzaXZhbSwgU2VudDogRnJpZGF5LCBKdWx5IDI4
LCAyMDIzIDExOjUxIEFNDQo+ID4gPg0KPiA+ID4gT24gV2VkLCBKdWwgMjYsIDIwMjMgYXQgMDI6
MTI6MTVBTSArMDAwMCwgWW9zaGloaXJvIFNoaW1vZGEgd3JvdGU6DQo+ID4gPiA+IEhpIE1hbml2
YW5uYW4sDQo+ID4gPiA+DQo+ID4gPiA+ID4gRnJvbTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtLCBT
ZW50OiBNb25kYXksIEp1bHkgMjQsIDIwMjMgODowNCBQTQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
U3ViamVjdCBzaG91bGQgY29udGFpbiB0aGUgd29yZCAibWlzc2luZyIuIExpa2UsICJBZGQgbWlz
c2luZyBQQ0lfRVhQX0xOS0NBUF9NTFcNCj4gPiA+ID4gPiBoYW5kbGluZyIuDQo+ID4gPiA+DQo+
ID4gPiA+IEkgZ290IGl0Lg0KPiA+ID4gPg0KPiA+ID4gPiA+IE9uIEZyaSwgSnVsIDIxLCAyMDIz
IGF0IDA0OjQ0OjQxUE0gKzA5MDAsIFlvc2hpaGlybyBTaGltb2RhIHdyb3RlOg0KPiA+ID4gPiA+
ID4gVXBkYXRlIGR3X3BjaWVfbGlua19zZXRfbWF4X2xpbmtfd2lkdGgoKSB0byBzZXQgUENJX0VY
UF9MTktDQVBfTUxXLg0KPiA+ID4gPiA+ID4gSW4gYWNjb3JkYW5jZSB3aXRoIHRoZSBEVyBQQ0ll
IFJDL0VQIEhXIG1hbnVhbHMgWzEsMiwzLC4uLl0gYXNpZGUgd2l0aA0KPiA+ID4gPiA+ID4gdGhl
IFBPUlRfTElOS19DVFJMX09GRi5MSU5LX0NBUEFCTEUgYW5kIEdFTjJfQ1RSTF9PRkYuTlVNX09G
X0xBTkVTWzg6MF0NCj4gPiA+ID4gPiA+IGZpZWxkIHRoZXJlIGlzIGFub3RoZXIgb25lIHdoaWNo
IG5lZWRzIHRvIGJlIHVwZGF0ZWQuIEl0J3MNCj4gPiA+ID4gPiA+IExJTktfQ0FQQUJJTElUSUVT
X1JFRy5QQ0lFX0NBUF9NQVhfTElOS19XSURUSC4gSWYgaXQgaXNuJ3QgZG9uZSBhdA0KPiA+ID4g
PiA+ID4gdGhlIHZlcnkgbGVhc3QgdGhlIG1heGltdW0gbGluay13aWR0aCBjYXBhYmlsaXR5IENT
UiB3b24ndCBleHBvc2UNCj4gPiA+ID4gPiA+IHRoZSBhY3R1YWwgbWF4aW11bSBjYXBhYmlsaXR5
Lg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFsxXSBEZXNpZ25XYXJlIENvcmVzIFBDSSBFeHBy
ZXNzIENvbnRyb2xsZXIgRGF0YWJvb2sgLSBEV0MgUENJZSBSb290IFBvcnQsDQo+ID4gPiA+ID4g
PiAgICAgVmVyc2lvbiA0LjYwYSwgTWFyY2ggMjAxNSwgcC4xMDMyDQo+ID4gPiA+ID4gPiBbMl0g
RGVzaWduV2FyZSBDb3JlcyBQQ0kgRXhwcmVzcyBDb250cm9sbGVyIERhdGFib29rIC0gRFdDIFBD
SWUgUm9vdCBQb3J0LA0KPiA+ID4gPiA+ID4gICAgIFZlcnNpb24gNC43MGEsIE1hcmNoIDIwMTYs
IHAuMTA2NQ0KPiA+ID4gPiA+ID4gWzNdIERlc2lnbldhcmUgQ29yZXMgUENJIEV4cHJlc3MgQ29u
dHJvbGxlciBEYXRhYm9vayAtIERXQyBQQ0llIFJvb3QgUG9ydCwNCj4gPiA+ID4gPiA+ICAgICBW
ZXJzaW9uIDQuOTBhLCBNYXJjaCAyMDE2LCBwLjEwNTcNCj4gPiA+ID4gPiA+IC4uLg0KPiA+ID4g
PiA+ID4gW1hdIERlc2lnbldhcmUgQ29yZXMgUENJIEV4cHJlc3MgQ29udHJvbGxlciBEYXRhYm9v
ayAtIERXQyBQQ0llIEVuZHBvaW50LA0KPiA+ID4gPiA+ID4gICAgICAgVmVyc2lvbiA1LjQwYSwg
TWFyY2ggMjAxOSwgcC4xMzk2DQo+ID4gPiA+ID4gPiBbWCsxXSBEZXNpZ25XYXJlIENvcmVzIFBD
SSBFeHByZXNzIENvbnRyb2xsZXIgRGF0YWJvb2sgLSBEV0MgUENJZSBSb290IFBvcnQsDQo+ID4g
PiA+ID4gPiAgICAgICBWZXJzaW9uIDUuNDBhLCBNYXJjaCAyMDE5LCBwLjEyNjYNCj4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiBTdWdnZXN0ZWQtYnk6IFNlcmdlIFNlbWluIDxmYW5jZXIubGFuY2Vy
QGdtYWlsLmNvbT4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEFkZCBSZXBvcnRlZC1ieSBhbHNvPw0K
PiA+ID4gPg0KPiA+ID4gPiBJIGRvbid0IHRoaW5rIHNvIGJlY2F1c2UgU2VyZ2Ugc3VnZ2VzdGVk
IHRoZSBjb21taXQgZGVzY3JpcHRpb24gZnJvbSBteSBzdWJtaXR0ZWQgcGF0Y2ggWzFdLg0KPiA+
ID4gPg0KPiA+ID4gPiBbMV0NCj4gPiA+ID4NCj4gPiA8c25pcCBVUkw+DQo+ID4gPiA+DQo+ID4g
Pg0KPiA+ID4gRmluZSB0aGVuLg0KPiA+ID4NCj4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFlv
c2hpaGlybyBTaGltb2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4NCj4gPiA+
ID4gPg0KPiA+ID4gPiA+IFRoaXMgbG9va3MgbGlrZSBhIHBvdGVudGlhbCBidWcgZml4IHRvIG1l
LiBTbyBwbGVhc2UgbW92ZSB0aGlzIGNoYW5nZSBiZWZvcmUgdGhlDQo+ID4gPiA+ID4gcHJldmlv
dXMgcGF0Y2ggdGhhdCBpbnRyb2R1Y2VzIGR3X3BjaWVfbGlua19zZXRfbWF4X2xpbmtfd2lkdGgo
KSwgdGFnIGZpeGVzIGFuZA0KPiA+ID4gPiA+IENDIHN0YWJsZSBsaXN0IGZvciBiYWNrcG9ydGlu
Zy4NCj4gPiA+ID4NCj4gPiA+ID4gSSB0aGluayB0aGF0IHRoaXMgcGF0Y2ggc2hvdWxkIGJlIGEg
bmV4dCBicmFuY2ggYmVjYXVzZSB0aGlzIGlzIHBvc3NpYmxlIHRvDQo+ID4gPiA+IGNhdXNlIHNp
ZGUgZWZmZWN0aXZlLiBBbG1vc3QgYWxsIGRyaXZlcnMvcGNpZS9jb250cm9sbGVyL2R3Yy8gaG9z
dCBkcml2ZXJzIGV4Y2VwdA0KPiA+ID4gPiBwY2llLXRlZ3JhMTk0LmMgZG9lc24ndCBoYXZlIHRo
aXMgc2V0dGluZywgYnV0IEkgYXNzdW1lIHRoYXQgdGhlIGRyaXZlcnMgd29yayBjb3JyZWN0bHkN
Cj4gPiA+ID4gd2l0aG91dCB0aGlzIHNldHRpbmcuDQo+ID4gPiA+DQo+ID4gPiA+IEFsc28sIHRv
IGJlIGhvbmVzdCwgSSBjb3VsZCBub3QgZmluZCBhIHN1aXRhYmxlIGNvbW1pdCBJRCBmb3IgdGhp
cyBwYXRjaCdzICJGaXhlcyIgdGFnLg0KPiA+ID4gPiBBZGRpdGlvbmFsbHksIEkgY291bGQgbm90
IGRldGVybWluZSB3aGljaCBvbGQga2VybmVsIHZlcnNpb25zIHNob3VsZCBoYXZlIHRoaXMgcGF0
Y2gNCj4gPiA+ID4gYXBwbGllZCBhcyBiYWNrcG9ydGluZy4NCj4gPiA+ID4NCj4gPiA+DQo+IA0K
PiA+ID4gT2suIEJ1dCB5b3UgY2FuIHN0aWxsIG1vdmUgdGhpcyBwYXRjaCBhcyBJIHN1Z2dlc3Rl
ZC4gSWYgd2UgaGFwcGVuIHRvIGhpdCBhbnkNCj4gPiA+IGlzc3VlIHdpdGggdGhpcyBzZXR0aW5n
LCB0aGVuIHdlIGNhbiBlYXNpbHkgcmV2ZXJ0IGl0Lg0KPiA+DQo+ID4gSSBnb3QgaXQuIEknbGwg
bW92ZSB0aGlzIHBhdGNoIGFzIHlvdSBzdWdnZXN0ZWQuDQo+IA0KPiBOby4gQnkgbW92aW5nIHRo
aXMgcGF0Y2ggdG8gYmUgaW1wbGVtZW50ZWQgYmVmb3JlIHRoZSBwYXRjaDoNCj4gW1BBVENIIHYx
OCAwOC8yMF0gUENJOiBkd2M6IEFkZCBkd19wY2llX2xpbmtfc2V0X21heF9saW5rX3dpZHRoKCkN
Cj4geW91IHdvbid0IGJlIGFibGUgdG8gZWFzaWx5IHJldmVydCBpdCBhZnRlcndhcmRzIGJlY2F1
c2UgdGhlIHBhdGNoICM4DQo+IHdpbGwgbW92ZSB0aGUgY29kZSBhZGRlZCBieSB0aGUgcGF0Y2gg
IzkgdG8gdGhlDQo+IGR3X3BjaWVfbGlua19zZXRfbWF4X2xpbmtfd2lkdGgoKSBmdW5jdGlvbi4g
QmFzaWNhbGx5IHlvdSBzdWdnZXN0IHRvDQo+IHN3aXRjaCB0aGUgcHJlcGFyYXRpb24gYW5kIGZ1
bmN0aW9uYWwgcGF0Y2hlcyBvcmRlciB3aGljaCBkb2Vzbid0IGxvb2sNCj4gcmlnaHQuDQoNCllv
dSdyZSBjb3JyZWN0LiBJZiBtb3ZpbmcgdGhpcyBwYXRjaCB0byB0aGUgdG9wIG9mIHRoaXMgc2Vy
aWVzIGFuZCB0aGVuDQpzdGlsbCBhcHBseSB0aGUgb3JpZ2luYWwgIzgsIGl0J3MgZGlmZmljdWx0
IHRvIHJldmVydCB0aGlzIHBhdGNoLg0KDQo+IEJhc2ljYWxseSB0aGUgTGluay13aWR0aC1yZWxh
dGVkIHBhcnQgb2YgdGhpcyBzZXJpZXMgY3VycmVudGx5IGltcGxpZXMNCj4gdGhlIG5leHQgbG9n
aWM6DQo+IA0KPiAxLiBQcmVwYXJlIHRoZSBEVyBQQ0llIGNvcmUgZHJpdmVyIHRvIGltcGxlbWVu
dGluZyBhIGNvbXByZWhlbnNpdmUNCj4gTWF4LWxpbmstd2lkdGggc2V0dXAgbWV0aG9kcyAoYWth
IGFzIGl0J3MgZG9uZSBpbg0KPiBkd19wY2llX2xpbmtfc2V0X21heF9zcGVlZCgpKSBieSBtb3Zp
bmcgdGhlIExpbmstd2lkdGggcmVsYXRlZCBjb2RlIHRvDQo+IGEgZGVkaWNhdGVkIG1ldGhvZDoN
Cj4gW1BBVENIIHYxOCAwOC8yMF0gUENJOiBkd2M6IEFkZCBkd19wY2llX2xpbmtfc2V0X21heF9s
aW5rX3dpZHRoKCkNCj4gDQo+IDIuIEFkZCB0aGUgUENJX0VYUF9MTktDQVBfTUxXIGZpZWxkIHVw
ZGF0ZSwgd2hpY2gNCj4gZHdfcGNpZV9saW5rX3NldF9tYXhfbGlua193aWR0aCgpIGxhY2tzIHRv
IGJlIGNvbXByZWhlbnNpdmU6DQo+IFtQQVRDSCB2MTggMDkvMjBdIFBDSTogZHdjOiBBZGQgUENJ
X0VYUF9MTktDQVBfTUxXIGhhbmRsaW5nDQo+IA0KPiAzLiBEcm9wIHRoZSBkdXBsaWNhdGluZyBj
b2RlIGZyb20gdGhlIFRlZ3JhMTk0IFBDSWUgZHJpdmVyOg0KPiBbUEFUQ0ggdjE4IDEwLzIwXSBQ
Q0k6IHRlZ3JhMTk0OiBEcm9wIFBDSV9FWFBfTE5LU1RBX05MVyBzZXR0aW5nDQoNClllcy4NCg0K
PiBJbiBjYXNlIGlmIHRoZSBwYXRjaCAjOSBhcHBlYXJzIHRvIGJlIGEgYnVnIGZpeCwgdGhlbiBp
dCB3aWxsIG5lZWQgdG8NCj4gYmUgYmFja3BvcnRlZCB0b2dldGhlciB3aXRoIHBhdGNoICM4IHdo
aWNoIGlzbid0IGEgcHJvYmxlbSBhdCBhbGwNCj4gKHRob3VnaCBpdCdzIGRvdWJ0ZnVsbHkgdG8g
aGFwcGVuIHNpbmNlIG5vYm9keSByZXBvcnRlZCBhbnkgcHJvYmxlbQ0KPiB3aXRoIHRoYXQgc28g
ZmFyKS4NCg0KQmFzaWNhbGx5LCBJIGRvbid0IHRoaW5rIHRoYXQgYmFja3BvcnRpbmcgIzggaXMg
Z29vZCBhcyBiYWNrcG9ydCBiZWNhdXNlDQp0aGUgIzggcGF0Y2ggaXMgYSBjbGVhbiB1cCBjb2Rl
IGZvciByZWFkYWJpbGl0eS4NCg0KPiBCdXQgaWYgcGF0Y2ggIzkgdHVybnMgb3V0IHRvIGJyZWFr
IHNvbWV0aGluZyBpbg0KPiBjdXJyZW50IGNpcmN1bXN0YW5jZXMgd2UnbGwgYmUgYWJsZSB0byBl
aXRoZXIgZWFzaWx5IHJldmVydCBpdCAoc2luY2UNCj4gaXQncyBhcHBsaWVkIGFmdGVyIHRoZSBw
cmVwYXJhdGlvbiBwYXRjaCkgb3IgZml4IHNvbWVob3cuIElmIHlvdQ0KPiBzd2l0Y2ggcGF0Y2gg
IzggYW5kICM5IG9yZGVyLCB0aGUgcmV2ZXJzaW9uIHdpbGwgcmVxdWlyZSB0byBiZQ0KPiBwZXJm
b3JtZWQgZm9yIGJvdGggdGhlc2UgcGF0Y2hlcyB0byBhdm9pZCB0aGUgY29uZmxpY3RzLiBUaHVz
IEknZA0KPiBzdWdnZXN0IHRvIGxlYXZlIHRoZSBwYXRjaGVzIG9yZGVyIGFzIGlzIHdoaWNoIGxv
b2tzIG1vcmUgbmF0dXJhbCBhbmQNCj4gd29uJ3QgY2F1c2UgYW55IHByb2JsZW1zIHRvIHJldmVy
dCB0aGUgZnVuY3Rpb25hbCBjaGFuZ2Ugb3IgdG8NCj4gYmFja3BvcnQgaXQuDQoNClRvIGZvbGxv
dyBNYW5pdmFubmFuJ3Mgc3VnZ2VzdGlvbiBhbmQgeW91ciBjb21tZW50cywgSSdtIHRoaW5raW5n
IHRoYXQNCi0gZHJvcCB0aGUgIzggYmVjYXVzZSB0aGlzIGlzIGp1c3QgY2xlYW4gdXAgY29kZSBm
b3IgcmVhZGFiaWxpdHkuDQotLSBBZnRlciB0aGlzIHBhdGNoIHNlcmllcyBpcyBtZXJnZWQgYW5k
IHdvcmtlZCBjb3JyZWN0bHkgd2l0aG91dCBhbnkNCiAgIHJlZ3Jlc3Npb24gb24gb3RoZXIgcGxh
dGZvcm1zLCB3ZSBjYW4gYXBwbHkgdGhlICM4Lg0KLSBtb3ZlIHRoZSAjOSB0byB0aGUgdG9wIG9m
IHRoaXMgc2VyaWVzIGFzIE1hbml2YW5uYW4gc3VnZ2VzdGVkLg0KLS0gVGhpcyBtZWFuIGFkZGlu
ZyB0aGlzIGNvZGUgaW50byBkd19wY2llX3NldHVwKCkuDQoNCkJ1dCwgd2hhdCBkbyB5b3UgdGhp
bms/DQoNCkJlc3QgcmVnYXJkcywNCllvc2hpaGlybyBTaGltb2RhDQoNCj4gLVNlcmdlKHkpDQo+
IA0KPiA+DQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+IFlvc2hpaGlybyBTaGltb2RhDQo+ID4NCj4g
PiA+IC0gTWFuaQ0KPiA+ID4NCj4gPiA+ID4gQmVzdCByZWdhcmRzLA0KPiA+ID4gPiBZb3NoaWhp
cm8gU2hpbW9kYQ0KPiA+ID4gPg0KPiA+ID4gPiA+IC0gTWFuaQ0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiBSZXZpZXdlZC1ieTogU2VyZ2UgU2VtaW4gPGZhbmNlci5sYW5jZXJAZ21haWwuY29tPg0K
PiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS1kZXNpZ253YXJlLmMgfCA5ICsrKysrKysrLQ0KPiA+ID4gPiA+ID4gIDEgZmlsZSBjaGFu
Z2VkLCA4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253
YXJlLmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuYw0KPiA+
ID4gPiA+ID4gaW5kZXggNWNjYTM0MTQwZDJhLi5jNDk5ODE5NGZlNzQgMTAwNjQ0DQo+ID4gPiA+
ID4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuYw0K
PiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253
YXJlLmMNCj4gPiA+ID4gPiA+IEBAIC03MzAsNyArNzMwLDggQEAgc3RhdGljIHZvaWQgZHdfcGNp
ZV9saW5rX3NldF9tYXhfc3BlZWQoc3RydWN0IGR3X3BjaWUgKnBjaSwgdTMyIGxpbmtfZ2VuKQ0K
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICBzdGF0aWMgdm9pZCBkd19wY2llX2xpbmtfc2V0X21h
eF9saW5rX3dpZHRoKHN0cnVjdCBkd19wY2llICpwY2ksIHUzMiBudW1fbGFuZXMpDQo+ID4gPiA+
ID4gPiAgew0KPiA+ID4gPiA+ID4gLQl1MzIgbHdzYywgcGxjOw0KPiA+ID4gPiA+ID4gKwl1MzIg
bG5rY2FwLCBsd3NjLCBwbGM7DQo+ID4gPiA+ID4gPiArCXU4IGNhcDsNCj4gPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiAgCWlmICghbnVtX2xhbmVzKQ0KPiA+ID4gPiA+ID4gIAkJcmV0dXJuOw0KPiA+
ID4gPiA+ID4gQEAgLTc2Niw2ICs3NjcsMTIgQEAgc3RhdGljIHZvaWQgZHdfcGNpZV9saW5rX3Nl
dF9tYXhfbGlua193aWR0aChzdHJ1Y3QgZHdfcGNpZSAqcGNpLCB1MzIgbnVtX2xhbmVzKQ0KPiA+
ID4gPiA+ID4gIAl9DQo+ID4gPiA+ID4gPiAgCWR3X3BjaWVfd3JpdGVsX2RiaShwY2ksIFBDSUVf
UE9SVF9MSU5LX0NPTlRST0wsIHBsYyk7DQo+ID4gPiA+ID4gPiAgCWR3X3BjaWVfd3JpdGVsX2Ri
aShwY2ksIFBDSUVfTElOS19XSURUSF9TUEVFRF9DT05UUk9MLCBsd3NjKTsNCj4gPiA+ID4gPiA+
ICsNCj4gPiA+ID4gPiA+ICsJY2FwID0gZHdfcGNpZV9maW5kX2NhcGFiaWxpdHkocGNpLCBQQ0lf
Q0FQX0lEX0VYUCk7DQo+ID4gPiA+ID4gPiArCWxua2NhcCA9IGR3X3BjaWVfcmVhZGxfZGJpKHBj
aSwgY2FwICsgUENJX0VYUF9MTktDQVApOw0KPiA+ID4gPiA+ID4gKwlsbmtjYXAgJj0gflBDSV9F
WFBfTE5LQ0FQX01MVzsNCj4gPiA+ID4gPiA+ICsJbG5rY2FwIHw9IEZJRUxEX1BSRVAoUENJX0VY
UF9MTktDQVBfTUxXLCBudW1fbGFuZXMpOw0KPiA+ID4gPiA+ID4gKwlkd19wY2llX3dyaXRlbF9k
YmkocGNpLCBjYXAgKyBQQ0lfRVhQX0xOS0NBUCwgbG5rY2FwKTsNCj4gPiA+ID4gPiA+ICB9DQo+
ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gIHZvaWQgZHdfcGNpZV9pYXR1X2RldGVjdChzdHJ1Y3Qg
ZHdfcGNpZSAqcGNpKQ0KPiA+ID4gPiA+ID4gLS0NCj4gPiA+ID4gPiA+IDIuMjUuMQ0KPiA+ID4g
PiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4g4K6u4K6j4K6/4K614K6j
4K+N4K6j4K6p4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCvjQ0KPiA+ID4NCj4gPiA+IC0tDQo+
ID4gPiDgrq7grqPgrr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+N
DQo=
