Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4A17CD125
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 02:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjJRALp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 20:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJRALn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 20:11:43 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2107.outbound.protection.outlook.com [40.107.113.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D76C4;
        Tue, 17 Oct 2023 17:11:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbmZgvWxMRniYyfvThliY6Zqp5WeefjhNMRNqBhpVhKMK4Y07eIRG36RHTf9OcruMOsvqL90JzKIJi5QgOXedMYdkGzOILolOgwyJyyb5qLgS756uiQDbfC4Du8NCHffeZY6vACoWTS4h1oa2hDKSd7QfpKJf/LIqyheIJxRdRxhfJXJ320I5UG2lhTRf4YpcyFqqXcl454vZ3wm2plz9mJWxXuvuqjaTczgR8F28HViUbjefphIMAhfXXqg3mLptThvyUyYEOfWc/xIJrl1U72zdpHRw0C2S9olLxlaMYIVijSOnqxlr9REWF82iJtgaYK5J9y1iI8lMzWCH78fqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eq78UcYqoFhN18j/iNC65mJobbuYeMs6cuP2Y7SihIQ=;
 b=EjhRYyRGHY2cO/cUQGd3r8y6bAOIcXpapG8MUgSgfBHCTqhwxrAauuGBAw+VJYVTu8yH6a9osD7ifseaPc/Gt5eUMarUZvMUzOTWAjijfG8rPbm7wZ/OVdjvl0UXg56pq+c3oGSWWT4WqnxeilZq3opNoNZb3fIGLXHgT/BSlssnOloyMpN/mSgu+ZsNT9pE46vedgvOKWkzxIyYmB7Lz6jyeswqRiDomTo6lVSdS1Gil/4wzgBuzrLVtH/dh8rMwkvHOxaUONrqMOHKIkS93yAuojitEPklKA85xV0ZUHSUgX6aFFR1ie/KRnkZFcmS3o60jiGoIRezDkALZcJ3Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eq78UcYqoFhN18j/iNC65mJobbuYeMs6cuP2Y7SihIQ=;
 b=MvaY9yjHXGwNhgigfJarlyaLb4ktfNUp0i7pzFu/R2TRzmbPJQ9ZyXHg8OFAbo0LooggfxBlkCBEU9ev2weMWanq10axIzEKY5TGy1DdXcjTdw8gu2HczgDrHZzFRtsKPqCyN6YIzTY+emXoVX8dGGeLz3IY5L/sU67JrXeWgWs=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYVPR01MB10638.jpnprd01.prod.outlook.com
 (2603:1096:400:29b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 00:11:35 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::a188:9424:be62:e5fb]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::a188:9424:be62:e5fb%6]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 00:11:35 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     "mani@kernel.org" <mani@kernel.org>
CC:     Marek Szyprowski <m.szyprowski@samsung.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v24 08/16] PCI: dwc: Disable two BARs to avoid unnecessary
 memory assignment
Thread-Topic: [PATCH v24 08/16] PCI: dwc: Disable two BARs to avoid
 unnecessary memory assignment
Thread-Index: AQHZ/BKVrluFe2vL8EK2EaoOE81Q27BNveCAgAAopfCAADsYgIAAlTSw
Date:   Wed, 18 Oct 2023 00:11:35 +0000
Message-ID: <TYBPR01MB53415A74F7ABB79410D61CA7D8D5A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20231011071423.249458-1-yoshihiro.shimoda.uh@renesas.com>
 <20231011071423.249458-9-yoshihiro.shimoda.uh@renesas.com>
 <CGME20231017091924eucas1p2e65759cd05340e3e5b3a1d9ab9de1320@eucas1p2.samsung.com>
 <a85158a0-858c-43c3-b64a-c09de72a50f9@samsung.com>
 <TYBPR01MB5341006D4CEAA1422B0A41F3D8D6A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20231017151619.GE5274@thinkpad>
In-Reply-To: <20231017151619.GE5274@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYVPR01MB10638:EE_
x-ms-office365-filtering-correlation-id: 40ae4b7f-960b-43f9-74f6-08dbcf6eca5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D+krrCQTAujJU/mbVB06dNoPio7y1WDYIkECNOgz82BexyAPQIkXyRkSIP6RBr3PPpNGa8c+g4D5xcV7lNUkv0mMQnL0cUugLScaqhRfh00MGJ6MBKZICK4M4Y0BzIFDmDGtJAU9n6w63ZkjTTKJTJNAMcFwVVuKe4gVli32MyZr7sa4FUunzXs8Mh6taOs0u14cX7fnW54rUHhH5sckW70pmmGnqeURYE7+T5PNsZ9RIH3hKrIc9PFpzXDuxQ7DH6iSpZ8GnVdSD2HnmN7LmWzXCDrspmNbuAwPxlIja/vQ9l39tQEpVbQiKU/sNOLAsYRfROilBl5Sq5Tp/55Yh2fbspGslPfwtsJATd33oa53DoyjdI6zuScZUVlEx7ZHynkbmzBbDXC0VOLwCfRqo6rB38agbRi9mC7qNVe8HIlSES0Prng9or+xeDasx7+/Z45T7CYJnECYowQlFtTtlFZ0jnItSu/rWkmQ48d8vshRqCfblInJKmF45B01ZngH+dKSiwMekg9mB2FkqHdakqDX1z7JC90OKhKSLhE9vSCXkaPlHmVm5IJ4oUXrMzzoOZ3tVDdIMxtPcMc8VaNCtOgxBJdt3OVtU2hXN+boab0R6ke0UOMa50AC0wJ2Amgj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(38100700002)(478600001)(53546011)(7696005)(9686003)(6506007)(76116006)(66946007)(83380400001)(71200400001)(38070700005)(45080400002)(54906003)(122000001)(66556008)(66446008)(6916009)(66476007)(64756008)(316002)(8676002)(4326008)(5660300002)(8936002)(55016003)(7416002)(41300700001)(52536014)(33656002)(2906002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWsxZGJ6UG5CTVJUc1lDcmpDS0xsczd1dTBrSnAzNXhiLzMySHZ1MWtJTmht?=
 =?utf-8?B?TzdOMEtza3BDRG9PZEVxMUVrakY3TTJPMmdJcXlNTE5xTUpKclQzT2ZuQXhm?=
 =?utf-8?B?QmFheG52YklBbElXVStHTVZWK3RFK2QvMm5Fa2Y5NVljLzdYdzl2czFMYkp5?=
 =?utf-8?B?S0FnSDNrM3lHQ1Zmd0hxK3VqVW42V3JvbzFTTVRLcWcvQlhmYXZDeXpwYTgw?=
 =?utf-8?B?WVFWZCtZTFZ4WVpqbEU0b09sSHVOb2c4UWVhdHpkOHp5M3BMRmN1QVVGbmF1?=
 =?utf-8?B?YTV0Q055NXNwcEFIWFZhS2t3R2JFWFVyUGU5K2YwT3BwZStLa1dhVm9iK3dn?=
 =?utf-8?B?VVFzK1QzWlNwckM2SjBqTTRZb2hhZTFPRVZBK0tiVHBYMloyZzgzbWdZTWJa?=
 =?utf-8?B?QmFuVVN1c1RwZEs2VWN5SW9odjJVSnBrUDUyZ0VFa2NQeGFmM3ZkTFg5Zm9u?=
 =?utf-8?B?L3dWanMxbXYxTzV6MnM2WmFMOWxUMjBoajNZcVBhOGxLVjJiaG02WHVrZENa?=
 =?utf-8?B?ck9MNjU5eGdoRktOQWNZTExnL2pweTJDVURFNWxxcks3eG1HYzlqbXVnOUFZ?=
 =?utf-8?B?KzQ4bkpKRFlDNHl5MFRmS1JYd1Z2a21DL1dYZGUzY25PMkRFeGpWZlB4YTEz?=
 =?utf-8?B?eFdBdFhuOVNwcitLNHRVUVpFRDl0WTJNY3Jtc09peDhOZkhzQ0J0QmNTMFBj?=
 =?utf-8?B?UVJxdWlZN2YxSjM2cTBxQnRXWW1WUkgrekpZdUN6Yk5sdU1yK1ZGd3lzQUdj?=
 =?utf-8?B?OTVYNmFJMGlFb0pqR2x6bk9zMVhhSTA3aVZwMkt0ekZpOUU2TWV5OFdmNjZY?=
 =?utf-8?B?WDJoSFl3aGs0NXkrbnJJMGpGenR3cmFaN013cmlKV3l6YTJoeFdDaXA5aGZW?=
 =?utf-8?B?QXVSbkFabDAra3JHZVBFV0RXNlVRVFB5d1lRV0VXcUZFMXA4ZTBoNkNzVUhW?=
 =?utf-8?B?bGUwV3NDZ0VmWGJCdCtBeG9xNkZvNG5hZTFtd3ZDR0pJQkJFQWhoeUh6NEhx?=
 =?utf-8?B?N29JaUtjNTBpWW9LcW1hNjRKK1d6ZWpndksrK2dGNFdSNThUZ3ZsUHZZZVJF?=
 =?utf-8?B?Mm03VGJhTzhBZENMYzN4NnU1M2xRaC9xOXJZZzlWNzFlTUc5WFBnd0tPMmVT?=
 =?utf-8?B?U1Nna0ttb0IzU3BUUmpUTi8yQmF6NXZFV0p0bHkyb1duOEtYME50Tk5wMlpn?=
 =?utf-8?B?SHBOQzNVa3lNUGwxS2wvaStEUW43V3MyVnpISUM0NFhaN2swR01jQVJoUGhK?=
 =?utf-8?B?dUF5N2lRangwQmVWT1R3Rm91MERFWkJGT05rN1k3TU5mTFpaTUtYZnVBYmox?=
 =?utf-8?B?TEZuTGRNZFRtTUJFdEhTRnhYZXMvWGtwVS8zQWd0eEl5Um44ZTUzWHZ1M1c4?=
 =?utf-8?B?dDF2RjJzcHQzWG5GK2lmL2pNSS9Pc1JYM2xRZzdPbXhBd3dnMHZ3dDJGTEN2?=
 =?utf-8?B?eHNoZURiYWNVcjF0TTlzandXRTRFajJuNzNjeUh3WHU3Z1l0Mzhzalh4aUpB?=
 =?utf-8?B?cmlONFVraDZRNDVuRGU5K0cvcXdGbHhTK3RyUkltaWxXZVV0bFFoTVVpMkFq?=
 =?utf-8?B?VWlCVi9sdGo4N0JId3JFeDluL00yeWlJVHpubDdmNFdRc25DUWdMOG90RDEy?=
 =?utf-8?B?TG5QWm1iVnVzS1NvbmF3dU1GSFNVeExCdTJPYk5UVlZWRlZCdDVKREJmdy85?=
 =?utf-8?B?M1Nma05hQXpMbkxPSmxQRHRsUnM3Tm1QS2hEdm9mbFNMK1BrNnBmNXRkWXJi?=
 =?utf-8?B?R1Ftbks0bHNBUGMyTnNtNUszYTNpZWN5SjNpYUNDQW1pRzc2RTIwem5sZEls?=
 =?utf-8?B?RER3em5PeU5FWWJneFNiRUZIY0x1eGpPWFNNQzA1dVFvQVI3dmtKQmQ5djc3?=
 =?utf-8?B?dE55WGI0MXpDOFdtaGh2TTJxSXI2aVgxSURJTWZOQnU4RXFXbER1dW84bmtX?=
 =?utf-8?B?ZldUL0EyVEd6aTR3c3d1elJLcVZGTzFKclpjVXh4di9IYXgvaGlzbzNyVTVq?=
 =?utf-8?B?T1gvUHY4VUN5Q2VJc05oTTBiMVU1emVtbnZPUnNLQitJcVF2ZlJDeGR6aVJZ?=
 =?utf-8?B?RGFEVW5jTFd6S29mc1J3NldBMFFNald2MWtHU2h2QXFyWDN6elJnSzIvUkVs?=
 =?utf-8?B?Yit1N1BRS1lmVld3TzFyTElJcjBVUE5SSnJRSlM3TVYxb2NNb1ZoR2ZzZ0xx?=
 =?utf-8?B?bGhpTitzbktVNVlvMHplYkI4SjZsSG9vQmFpc2FscHBKUGNia1B4L09ENk1o?=
 =?utf-8?B?WVRVejNVemRhbTliU2V1S0hNcXN3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ae4b7f-960b-43f9-74f6-08dbcf6eca5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 00:11:35.1382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mxfl2G9uU5ni1XTEwC14iwiDr7elL/ExoK8V3eMN+Rh07k53/gsyJmMEBnYgGkYLGfBU52GfQ3NJ+8sxdpCJ4TE155W13GzmXVDNhUovSOIESxj+xBXxUuq28WdJabS7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10638
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBGcm9tOiBtYW5pQGtlcm5lbC5vcmcsIFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAxOCwgMjAy
MyAxMjoxNiBBTQ0KPiANCj4gT24gVHVlLCBPY3QgMTcsIDIwMjMgYXQgMTI6MDU6MTJQTSArMDAw
MCwgWW9zaGloaXJvIFNoaW1vZGEgd3JvdGU6DQo+ID4gRGVhciBNYXJlaywNCj4gPg0KPiA+ID4g
RnJvbTogTWFyZWsgU3p5cHJvd3NraSwgU2VudDogVHVlc2RheSwgT2N0b2JlciAxNywgMjAyMyA2
OjE5IFBNDQo+ID4gPg0KPiA+ID4gRGVhciBBbGwsDQo+ID4gPg0KPiA+ID4gT24gMTEuMTAuMjAy
MyAwOToxNCwgWW9zaGloaXJvIFNoaW1vZGEgd3JvdGU6DQo+ID4gPiA+IEFjY29yZGluZyB0byB0
aGUgc2VjdGlvbiAzLjUuNy4yICJSQyBNb2RlIiBpbiBEV0MgUENJZSBEdWFsIE1vZGUNCj4gPiA+
ID4gUmV2LjUuMjBhLCB3ZSBzaG91bGQgZGlzYWJsZSB0d28gQkFScyB0byBhdm9pZCB1bm5lY2Vz
c2FyeSBtZW1vcnkNCj4gPiA+ID4gYXNzaWdubWVudCBkdXJpbmcgZGV2aWNlIGVudW1lcmF0aW9u
LiBPdGhlcndpc2UsIFJlbmVzYXMgUi1DYXIgR2VuNA0KPiA+ID4gPiBQQ0llIGNvbnRyb2xsZXJz
IGNhbm5vdCB3b3JrIGNvcnJlY3RseSBpbiBob3N0IG1vZGUuDQo+ID4gPiA+DQo+ID4gPiA+IFNp
Z25lZC1vZmYtYnk6IFlvc2hpaGlybyBTaGltb2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5l
c2FzLmNvbT4NCj4gPiA+DQo+ID4gPiBUaGlzIHBhdGNoIGxhbmRlZCBpbiB0b2RheSdzIGxpbnV4
LW5leHQgMjAyMzEwMTcgYXMgY29tbWl0IGUzMDg1MjhjYWMzZQ0KPiA+ID4gKCJQQ0k6IGR3Yzog
RGlzYWJsZSB0d28gQkFScyB0byBhdm9pZCB1bm5lY2Vzc2FyeSBtZW1vcnkgYXNzaWdubWVudCIp
Lg0KPiA+ID4gVW5mb3J0dW5hdGVseSBpdCBjYXVzZXMgdGhlIGZvbGxvd2luZyBrZXJuZWwgcGFu
aWMgb24gU2Ftc3VuZw0KPiA+ID4gRXh5bm9zNTQzMy1iYXNlZCBUTTJlIGJvYXJkOg0KPiA+ID4N
Cj4gPiA+IGV4eW5vcy1wY2llIDE1NzAwMDAwLnBjaWU6IGhvc3QgYnJpZGdlIC9zb2NAMC9wY2ll
QDE1NzAwMDAwIHJhbmdlczoNCj4gPiA+IGV4eW5vcy1wY2llIDE1NzAwMDAwLnBjaWU6wqDCoMKg
wqDCoMKgIElPIDB4MDAwYzAwMTAwMC4uMHgwMDBjMDEwZmZmIC0+DQo+ID4gPiAweDAwMDAwMDAw
MDANCj4gPiA+IGV4eW5vcy1wY2llIDE1NzAwMDAwLnBjaWU6wqDCoMKgwqDCoCBNRU0gMHgwMDBj
MDExMDAwLi4weDAwMGZmZmZmZmUgLT4NCj4gPiA+IDB4MDAwYzAxMTAwMA0KPiA+ID4gZXh5bm9z
LXBjaWUgMTU3MDAwMDAucGNpZTogaUFUVTogdW5yb2xsIEYsIDMgb2IsIDUgaWIsIGFsaWduIDRL
LCBsaW1pdCA0Rw0KPiA+ID4gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgcGFnaW5nIHJlcXVlc3Qg
YXQgdmlydHVhbCBhZGRyZXNzIGZmZmY4MDAwODQxOTYwMTANCj4gPiA+IE1lbSBhYm9ydCBpbmZv
Og0KPiA+ID4gLi4uDQo+ID4gPiBEYXRhIGFib3J0IGluZm86DQo+ID4gPiAuLi4NCj4gPiA+IHN3
YXBwZXIgcGd0YWJsZTogNGsgcGFnZXMsIDQ4LWJpdCBWQXMsIHBnZHA9MDAwMDAwMDAyMjA0NzAw
MA0KPiA+ID4gW2ZmZmY4MDAwODQxOTYwMTBdIHBnZD0xMDAwMDAwMGRmNmZmMDAzLCBwNGQ9MTAw
MDAwMDBkZjZmZjAwMywNCj4gPiA+IHB1ZD0xMDAwMDAwMGRmNmZlMDAzLCBwbWQ9MTAwMDAwMDAy
NGFkOTAwMywgcHRlPTAwMDAwMDAwMDAwMDAwMDANCj4gPiA+IEludGVybmFsIGVycm9yOiBPb3Bz
OiAwMDAwMDAwMDk2MDAwMDQ3IFsjMV0gUFJFRU1QVCBTTVANCj4gPiA+IE1vZHVsZXMgbGlua2Vk
IGluOg0KPiA+ID4gQ1BVOiA0IFBJRDogNTUgQ29tbToga3dvcmtlci91MTg6MCBOb3QgdGFpbnRl
ZCA2LjYuMC1yYzErICMxNDEyOQ0KPiA+ID4gSGFyZHdhcmUgbmFtZTogU2Ftc3VuZyBUTTJFIGJv
YXJkIChEVCkNCj4gPiA+IFdvcmtxdWV1ZTogZXZlbnRzX3VuYm91bmQgZGVmZXJyZWRfcHJvYmVf
d29ya19mdW5jDQo+ID4gPiBwc3RhdGU6IDYwMDAwMDA1IChuWkN2IGRhaWYgLVBBTiAtVUFPIC1U
Q08gLURJVCAtU1NCUyBCVFlQRT0tLSkNCj4gPiA+IHBjIDogZHdfcGNpZV93cml0ZV9kYmkyKzB4
YjgvMHhjOA0KPiA+ID4gbHIgOiBkd19wY2llX3NldHVwX3JjKzB4MzAvMHg0ZTQNCj4gPiA+IC4u
Lg0KPiA+ID4gQ2FsbCB0cmFjZToNCj4gPiA+ICDCoGR3X3BjaWVfd3JpdGVfZGJpMisweGI4LzB4
YzgNCj4gPiA+ICDCoGR3X3BjaWVfc2V0dXBfcmMrMHgzMC8weDRlNA0KPiA+ID4gIMKgZHdfcGNp
ZV9ob3N0X2luaXQrMHgyMzgvMHg2MDgNCj4gPiA+ICDCoGV4eW5vc19wY2llX3Byb2JlKzB4MjNj
LzB4MzQwDQo+ID4gPiAgwqBwbGF0Zm9ybV9wcm9iZSsweDY4LzB4ZDgNCj4gPiA+ICDCoHJlYWxs
eV9wcm9iZSsweDE0OC8weDJiNA0KPiA+ID4gIMKgX19kcml2ZXJfcHJvYmVfZGV2aWNlKzB4Nzgv
MHgxMmMNCj4gPiA+ICDCoGRyaXZlcl9wcm9iZV9kZXZpY2UrMHhkOC8weDE2MA0KPiA+ID4gIMKg
X19kZXZpY2VfYXR0YWNoX2RyaXZlcisweGI4LzB4MTM4DQo+ID4gPiAgwqBidXNfZm9yX2VhY2hf
ZHJ2KzB4ODQvMHhlMA0KPiA+ID4gIMKgX19kZXZpY2VfYXR0YWNoKzB4YTgvMHgxYjANCj4gPiA+
ICDCoGRldmljZV9pbml0aWFsX3Byb2JlKzB4MTQvMHgyMA0KPiA+ID4gIMKgYnVzX3Byb2JlX2Rl
dmljZSsweGIwLzB4YjQNCj4gPiA+ICDCoGRlZmVycmVkX3Byb2JlX3dvcmtfZnVuYysweDhjLzB4
YzgNCj4gPiA+ICDCoHByb2Nlc3Nfb25lX3dvcmsrMHgxZWMvMHg1M2MNCj4gPiA+ICDCoHdvcmtl
cl90aHJlYWQrMHgyOTgvMHg0MDgNCj4gPiA+ICDCoGt0aHJlYWQrMHgxMjQvMHgxMjgNCj4gPiA+
ICDCoHJldF9mcm9tX2ZvcmsrMHgxMC8weDIwDQo+ID4gPiBDb2RlOiBkNTAzMzJiZiA3OTAwMDAy
MyAxN2ZmZmZlMiBkNTAzMzJiZiAoYjkwMDAwMjMpDQo+ID4gPiAtLS1bIGVuZCB0cmFjZSAwMDAw
MDAwMDAwMDAwMDAwIF0tLS0NCj4gPiA+IEtlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBPb3Bz
OiBGYXRhbCBleGNlcHRpb24NCj4gPiA+IFNNUDogc3RvcHBpbmcgc2Vjb25kYXJ5IENQVXMNCj4g
PiA+IEtlcm5lbCBPZmZzZXQ6IGRpc2FibGVkDQo+ID4gPiBDUFUgZmVhdHVyZXM6IDB4OGMwMDAy
MGUsM2MwMjAwMDAsMDAwMDQyMWINCj4gPiA+IE1lbW9yeSBMaW1pdDogbm9uZQ0KPiA+ID4gLS0t
WyBlbmQgS2VybmVsIHBhbmljIC0gbm90IHN5bmNpbmc6IE9vcHM6IEZhdGFsIGV4Y2VwdGlvbiBd
LS0tDQo+ID4gPg0KPiA+ID4gSSd2ZSBvYnNlcnZlZCBzaW1pbGFyIGlzc3VlIG9uIFF1YWxjb21t
J3MgUkI1IHBsYXRmb3JtIHdpdGggc29tZQ0KPiA+ID4gYWRkaXRpb25hbCBub3QteWV0IG1lcmdl
ZCBwYXRjaGVzIGVuYWJsaW5nIFBDSWUgc3VwcG9ydC4gUmV2ZXJ0aW5nDQo+ID4gPiAkc3ViamVj
dCBvbiB0b3Agb2YgbGludXgtbmV4dCBmaXhlcyB0aGlzIGlzc3VlLg0KPiA+ID4NCj4gPiA+IExl
dCBtZSBrbm93IGlmIHlvdSBuZWVkIG1vcmUgaW5mb3JtYXRpb24uDQo+ID4NCj4gPiBUaGFuayB5
b3UgZm9yIHRoZSByZXBvcnQuIEkgZ3Vlc3MgdGhhdCB0aGUgaXNzdWUgaXMgcmVsYXRlZCB0bw0K
PiA+IG91dC1vZi1yYW5nZSBhY2Nlc3Mgb2YgZGJpMjoNCj4gPiAtIEluIGFyY2gvYXJtNjQvYm9v
dC9kdHMvZXh5bm9zL2V4eW5vczU0MzMuZHRzaSwgdGhlIGRiaSByZWcgc2l6ZSBpcyAweDEwMDAN
Cj4gPiAgIGxpa2UgYmVsb3c6DQo+ID4gLS0tLS0NCj4gPiAgICAgICAgICAgICAgICAgcGNpZTog
cGNpZUAxNTcwMDAwMCB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9
ICJzYW1zdW5nLGV4eW5vczU0MzMtcGNpZSI7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
cmVnID0gPDB4MTU3MDAwMDAgMHgxMDAwPiwgPDB4MTU2YjAwMDAgMHgxMDAwPiwNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICA8MHgwYzAwMDAwMCAweDEwMDA+Ow0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgIHJlZy1uYW1lcyA9ICJkYmkiLCAiZWxiaSIsICJjb25maWciOw0K
PiA+IC4uLg0KPiA+IC0tLS0tDQo+ID4NCj4gPiAtIEluIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtZGVzaWdud2FyZS5jLCAiZGJpMiIgYXJlYSBpcyBjYWxjdWxhdGVkDQo+ID4gICBi
eSB0aGUgZm9sbG93aW5nIGlmIHJlZy1uYW1lcyAiZGJpMiIgZGlkbid0IGV4aXN0Og0KPiA+IC0t
LS0tDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcGNpLT5kYmlfYmFzZTIgPSBwY2ktPmRi
aV9iYXNlICsgU1pfNEs7DQo+ID4gLS0tLS0NCj4gPg0KPiA+IC0gSG93ZXZlciwgdGhpcyBpcyBv
dXQtb2YtbWVtb3J5IG9uIGV4eW5vczU0MzMuZHRzaSBiZWNhdXNlIHRoZSAiZGJpIiBzaXplIGlz
DQo+ID4gICAweDEwMDAgb25seS4NCj4gPiAtIEFuZCB0aGVuLCB0aGlzIHBhdGNoIGFsd2F5cyB3
cml0ZXMgUENJX0JBU0VfQUREUkVTU19bMDFdIHRvIGRiaTIgYXJlYS4NCj4gPiAgIFNvLCBzaW5j
ZSB0aGlzIGlzIG91dC1vZi1yYW5nZSwgdGhlIGtlcm5lbCBwYW5pYyBoYXBwZW5zLg0KPiA+DQo+
IA0KPiBJIGNvdWxkIHJlcHJvZHVjZSB0aGUgaXNzdWUgTWFyZWsgcmVwb3J0ZWQgb24gUkI1LiBB
cyB5b3UgcG9pbnRlZCBvdXQsIGl0IGlzIGR1ZQ0KPiB0byBub3QgbWFwcGluZyBkYmkyIGV4cGxp
Y2l0bHkuIEJ1dCB3ZSB3ZXJlIG5vdCB1c2luZyBEQkkyIG9uIHRoZSBob3N0IGVhcmxpZXINCj4g
YW5kIGl0IGxvb2tzIHRvIG1lIHRoYXQgREJJMiBtYXkgbm90IGJlIGltcGxlbWVudGVkIG9uIFFj
b20gaG9zdCBwbGF0Zm9ybXMuDQo+IA0KPiBBdGxlYXN0IG9uIEVQLCBJIGNvbmZpcm1lZCB3aXRo
IFFjb20gdGhhdCBEQkk9REJJMiBhcyByZXByZXNlbnRlZCBpbiB0aGUgZHJpdmVyLA0KPiBidXQg
SSBjb3VsZG4ndCBjb25maXJtIGlmIGl0IGlzIHNhbWUgZm9yIGhvc3QgYXMgd2VsbC4NCg0KVGhh
bmsgeW91IGZvciB0aGUgY29uZmlybWF0aW9uLiBJIHVuZGVyc3Rvb2QgaXQuDQoNCj4gPiBQZXJo
YXBzLCB3ZSBzaG91bGQgcmV2ZXJ0IHRoaXMgcGF0Y2ggYXQgZmlyc3QuIEFuZCwgYWRkIHRoZSBz
ZXR0aW5ncyBpbnRvDQo+ID4gbXkgZW52aXJvbm1lbnQgKHBjaWUtcmNhci1nZW40LmMpIG9ubHku
IEkgYWxzbyBoYXZlIGFsdGVybmF0aXZlIHNvbHV0aW9uIHdoaWNoDQo+ID4gbW9kaWZpZXMgdGhl
ICJkYmkyIiBhcmVhIGNhbGN1bGF0aW9uIGFuZCBhdm9pZCBvdXQtb2YtcmFuZ2UgYWNjZXNzIHNv
bWVob3cuDQo+ID4gQnV0LCBpdCBtYXkgY29tcGxpY2F0ZSBzb3VyY2UgY29kZS4uLg0KPiA+DQo+
IA0KPiBZZXMsIGxldCdzIHJldmVydCB0aGlzIHBhdGNoIGZvciBub3cgYW5kIG1vdmUgaXQgdG8g
cmNhciBkcml2ZXIuDQoNCkkgZ290IGl0Lg0KDQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8gU2hp
bW9kYQ0KDQo+IC0gTWFuaQ0KPiANCj4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4gWW9zaGloaXJvIFNo
aW1vZGENCj4gPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gICBkcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jIHwgOCArKysrKysrKw0KPiA+ID4gPiAgIDEgZmls
ZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMgYi9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQo+ID4gPiA+IGlu
ZGV4IGE3MTcwZmQwZTg0Ny4uNTZjYzdmZjZkNTA4IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQo+ID4gPiA+ICsr
KyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4g
PiA+ID4gQEAgLTczNyw2ICs3MzcsMTQgQEAgaW50IGR3X3BjaWVfc2V0dXBfcmMoc3RydWN0IGR3
X3BjaWVfcnAgKnBwKQ0KPiA+ID4gPiAgIAl1MzIgdmFsLCBjdHJsLCBudW1fY3RybHM7DQo+ID4g
PiA+ICAgCWludCByZXQ7DQo+ID4gPiA+DQo+ID4gPiA+ICsJLyoNCj4gPiA+ID4gKwkgKiBBY2Nv
cmRpbmcgdG8gdGhlIHNlY3Rpb24gMy41LjcuMiAiUkMgTW9kZSIgaW4gRFdDIFBDSWUgRHVhbCBN
b2RlDQo+ID4gPiA+ICsJICogUmV2LjUuMjBhLCB3ZSBzaG91bGQgZGlzYWJsZSB0d28gQkFScyB0
byBhdm9pZCB1bm5lY2Vzc2FyeSBtZW1vcnkNCj4gPiA+ID4gKwkgKiBhc3NpZ25tZW50IGR1cmlu
ZyBkZXZpY2UgZW51bWVyYXRpb24uDQo+ID4gPiA+ICsJICovDQo+ID4gPiA+ICsJZHdfcGNpZV93
cml0ZWxfZGJpMihwY2ksIFBDSV9CQVNFX0FERFJFU1NfMCwgMHgwKTsNCj4gPiA+ID4gKwlkd19w
Y2llX3dyaXRlbF9kYmkyKHBjaSwgUENJX0JBU0VfQUREUkVTU18xLCAweDApOw0KPiA+ID4gPiAr
DQo+ID4gPiA+ICAgCS8qDQo+ID4gPiA+ICAgCSAqIEVuYWJsZSBEQkkgcmVhZC1vbmx5IHJlZ2lz
dGVycyBmb3Igd3JpdGluZy91cGRhdGluZyBjb25maWd1cmF0aW9uLg0KPiA+ID4gPiAgIAkgKiBX
cml0ZSBwZXJtaXNzaW9uIGdldHMgZGlzYWJsZWQgdG93YXJkcyB0aGUgZW5kIG9mIHRoaXMgZnVu
Y3Rpb24uDQo+ID4gPg0KPiA+ID4gQmVzdCByZWdhcmRzDQo+ID4gPiAtLQ0KPiA+ID4gTWFyZWsg
U3p5cHJvd3NraSwgUGhEDQo+ID4gPiBTYW1zdW5nIFImRCBJbnN0aXR1dGUgUG9sYW5kDQo+ID4N
Cj4gDQo+IC0tDQo+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/g
rrXgrq7gr40NCg==
