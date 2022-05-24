Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268B4532120
	for <lists+linux-pci@lfdr.de>; Tue, 24 May 2022 04:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiEXCov (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 May 2022 22:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiEXCov (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 May 2022 22:44:51 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50046.outbound.protection.outlook.com [40.107.5.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB523917F;
        Mon, 23 May 2022 19:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=du6f9FmZA8DDJM6uj1q7aBpwhDvAUkaAMEDhTsOLwdZOd4TPt1cgSzIQ/4Jwg8fQCFLhIzdilfMqBtRrp4hkGs5XG3iwOmKHRIXETRg0WFEm8o+XgaVIbsOQnW7kav0zH1clOch4L0IciHuB+A8L0yMyV1jh7q1DuIEfg1HfRZZY15GMgKacRMb9vUlxWsDUqRZoVam1vfsPlpONItzdFxDPmf5T2RKW6DLm6m1LmVpDJ8vCs5PI446Sez+q+oEa03xfBep7Ladb8i3osUe+Hu/sA466SKx06lbDtK7UJhBgu2HwwAig4zx3qpDPPjP31ph+80DawMty/qxAhbk+BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKStDKrMPb+scjoWZowb+2K0qGTsPYqBt3jGSs8syUw=;
 b=ZQ5ltMQLluWIYmx5h848wWyhYEvUOe5yGj7ilQCsJHXKLehoyC4TAnDePucXfCVCqP7Vj0dpfU5i/UO+GgybT3r6I9NrwtXughPoyVp021Fi08eAWc5KSySI3WzzMncq9iOuRU8YO6I1LPRaIS2Qtqp4Mk+DcYvRVJ36+w4ER7E2RLsZDz6lwkHnaOmukWLFhmj+e5i97Sl/wsyQYB/lSJTW0KfbdgTzELSUP16kH/1mzIKwEKl1rargX1Q1ArPAnJilmQrbOL7ruMRm3JGgjkns4WOm5MuHFXG5QtDnyyZQlXD0re33A3zuqDJ3MF5BRQrsyCEEUhOZiX3tJ7Wi8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKStDKrMPb+scjoWZowb+2K0qGTsPYqBt3jGSs8syUw=;
 b=bZLpRKE2UvoMlii5ItPncII1tBwpKf3aZ3rlRzXuQWdTlt9V5CxmG2QRYHFnEjmXnGWlKRuEPhYJbv97VVaGd12WgsnaeI+RTHYkuc5V4Jc++R3BKLR5AZkjWpLrNfXUvUTu6Jksu8EizJHkeCNXk/2JrmmtA/We+RqYt+mQ1EQ=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB7588.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Tue, 24 May
 2022 02:44:45 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::c095:97b5:dbd3:d43f]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::c095:97b5:dbd3:d43f%9]) with mapi id 15.20.5273.022; Tue, 24 May 2022
 02:44:45 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     "tharvey@gateworks.com" <tharvey@gateworks.com>
CC:     Lucas Stach <l.stach@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v2 5/7] arm64: dts: imx8mp: add the iMX8MP PCIe support
Thread-Topic: [PATCH v2 5/7] arm64: dts: imx8mp: add the iMX8MP PCIe support
Thread-Index: AQHYMgQNwI/KYMhc8E25YFV+OIGtzKzwIfuAgAUuK7CAN/cQgIAAhAOg
Date:   Tue, 24 May 2022 02:44:45 +0000
Message-ID: <AS8PR04MB86767F671882E537D39C02BA8CD79@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1646644054-24421-1-git-send-email-hongxing.zhu@nxp.com>
 <1646644054-24421-6-git-send-email-hongxing.zhu@nxp.com>
 <fc2c6ddbf55723ac4c0f366e5a6131afafe546aa.camel@pengutronix.de>
 <AS8PR04MB8676F9A410442049E3DCA1F68CF39@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <CAJ+vNU271mS78iC7qFnaF1owzTF6+DWEY7gYVAQNmwiQk2-H0w@mail.gmail.com>
In-Reply-To: <CAJ+vNU271mS78iC7qFnaF1owzTF6+DWEY7gYVAQNmwiQk2-H0w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40aaf72b-db11-4fe9-320c-08da3d2f5ce4
x-ms-traffictypediagnostic: AM9PR04MB7588:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM9PR04MB7588E800688A7E3D07E4BADE8CD79@AM9PR04MB7588.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jGrYddpa1DoyTZFtwsul2Dd7+oJrWaTBj68QCB7OjXrelXol/BVpr9IBRfl5tYXA70w30i1rWP6/YhTqs7KpNvJxrXbVuZy3KgVQ6b2+Hl6fVNaOdLH4sJIsIOpFgraBrFnqsk9luuWJ/Qkr9fLHynfwoeB2+pf/OL4WZ/w8F4xV+jMhbYVj6ml1CKoim9eS2PKRoKzHwJMHeH0Gaa4BxtVc+F+MWXUPPUe1QgM/jrZsmG7eXab9sFsNdROsODv0pFUk7C9WyYqx7yZb96foSZswgmeJDOw323sw/9f5xaG/NTVSsZF1oQZBhWwGVsuiysQQYCCCavienParNjIASeVxvYX4kjKFwvJ3H+ssje7DrVeEz09dRxlJeg8diHSh97MUaUw2+m5bMt7zpolCidccb2lJpnYyxiL+SBtCw8f7YbkdUXHSsT5mHMqY8fTyos2Y4E6wVSet2KGucAU1ABegbCcZTav7R5m8YNuLdnmScetSryRruMJOoh49KtXCFvWkR+bH8rsgyv5c8WbmDWBqikZ/CTL9QRfeX4mOWEKVY4D+JGTr1wkQymFuwsR4Jnt3UryN8RW6GWPB75Hmb5YUfIv94SzOIuVqJUggGCFDsftOKM9f+0+QPevGF0eR+7aZ64H+X/OuLcUCvaUu9+r5CLn+jgNhQbiQNZXSVSc2hwiliLXsCeKI5kxZpIK85jDU49ljckmvmum9/xcKmCOnmcihJNZDuMws2nTt2JI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(76116006)(122000001)(6916009)(44832011)(33656002)(38100700002)(54906003)(86362001)(2906002)(8676002)(316002)(53546011)(9686003)(4326008)(7696005)(26005)(66476007)(66556008)(64756008)(66446008)(71200400001)(6506007)(55016003)(66946007)(5660300002)(508600001)(83380400001)(8936002)(7416002)(52536014)(186003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTZNU2dYSWN1QUpNeFhvQ0pCTC9KYTRVdG5QT3JZQVVnQm80NHRYWWRQRStx?=
 =?utf-8?B?ZnVqUUVTb0hucS9MMEZsUUdXSU9PbnR0blBKNENJL0tJOHcrcXBod0tyeSth?=
 =?utf-8?B?R2RXbDI5VC9EeFpEM05MS1RFL3VTZDVwUElDQkJOeFZpT3ArNy9KRlcrcUpj?=
 =?utf-8?B?OVR4Njc5VXRhNWlzQzlVVTI4VzNTNXh5WmYyaExiR0tlUDN4RjRzb253THdB?=
 =?utf-8?B?MDFpLzJLQmVtZ003ZGY4OS9MdE93VHFEVGpWWFBTazJPK1F4WVY3eFZkOXdN?=
 =?utf-8?B?UDYvbFkxWHh0cjIvRGk2cG5CRzl0eW1NUmNmT3UxazI5Unk0MVJDVkwxZ3BH?=
 =?utf-8?B?RkVwZkdrMGJUb2UzeTNGSHd0QS9GSUtkR3dUeHBaVlZGUGNITTJQWUZ0cnRG?=
 =?utf-8?B?YVMzd0V6djlXbHhkVlRKZmFoczhiYjZnblkxT0VraFYwWndJVm9MR0x5Ykk1?=
 =?utf-8?B?S2VEQ3ZGMFMzcWU1UkhnK3B6VGFQYmkxV3hCWFVReFJkWGZYK2c2eDBiWFd0?=
 =?utf-8?B?YS93S0Y2Zkwvc3AvcWlKR2dRekpId3IrNEd2ZCtHbis5VXJUWEpSaVZCOWd0?=
 =?utf-8?B?bVM3N21UTXJVN1FUcDFHOC90R3VUTWhSbmJrVjRpY2lNZzZhbjdHSVYrMmRM?=
 =?utf-8?B?V2owRWVyQWR6VGFsSFVyYTdVN1RPMFExNDVXT3VUUUd5cFNGbytUaVE0R2hR?=
 =?utf-8?B?VUxvcXE3b0NUM01Sa3dDWGxzRk00RExjTFRFQ2kwK2grQkNkVDFjQVhjakRi?=
 =?utf-8?B?ZVI5eXEwRklWTFk3TzRwWTZDSnlvaE40ZFdPbjJGN00ySS9LS3hjWXAwOWhJ?=
 =?utf-8?B?bDVBNU1veFU0R3dpbmVGcUZ3eTF3RDFnRThnZ1JERGgwY2J5L1FxV2lUSytz?=
 =?utf-8?B?NmJQWHRjT2k5eXY5emRhTTBORDlYRTA4Rmc3YWdEdmphNTZWaXBCMGNscXF5?=
 =?utf-8?B?eU90OHp5U3oyRVFUYlN0TDRWR2JNTDl1NG9mdnQrUXk3UkdxeDBvc2xFVDNk?=
 =?utf-8?B?dU5TaittNXl3K1RuSk0veWxEZlBtaXIyL0lkanJ2aGFEWFB3OUZLOXFwTGtk?=
 =?utf-8?B?NXlneVpTNTFXcDFxNmVMd21YczRqUmdKSi9aYm53SzNpc2V2M0ZXcXl4ZUpT?=
 =?utf-8?B?NnV1U1JPYU9RS3d4cDkzcWRrYktQL3FxaGVucVZRRnpVeUZTY1dyTVlKZnRo?=
 =?utf-8?B?TWh1amlFUkd0V3k5VnZ5Qko1dGtJMEtzV0pQV2F1QWlYTGtncU92dHQwOFZH?=
 =?utf-8?B?UTFmaXg5SnEvL09pdFNaY251RVY4SnBOSExKaWxXdVQ5clRwSzhycVppOVhl?=
 =?utf-8?B?ay9NU082NVpYQmVXUUxXSFBKbytTUEE0aFQwa2t4WXpvZC9ldldJakhPYXNG?=
 =?utf-8?B?WDhCVThjZUwxSDdwQldKRVlsM0VyNlIrTElqWWtxMG9ZVjdvVm1jYUNiZk5x?=
 =?utf-8?B?LzZqeWVqMWlBSng0LzBITFF4Z2ZvN2J6RTRxc01DVmM2WDZnSlVLQUdEMkxI?=
 =?utf-8?B?cHlUK3VaVGsxNXNoS0k0d1BhbWVwRlNaV3c4UTFFcjRQUmE4Y29ZS3QxWkNL?=
 =?utf-8?B?bWZQWTh6Rm9pZ05VTzk3RmRGc0xpaCtHdW1iZ3RwSzZYRCtZWkg4U3FxTHBK?=
 =?utf-8?B?RVdRYWhWL3crb1JlYVBoclorYTRscndqcy9lSmhyWWZRS3NyUVptcFVoQnh3?=
 =?utf-8?B?NldzdUpMTWFyY3U4S1Rocm1JRnRWSVR2a1dTQ05nTnhaN2YvNENOSUpSUVE4?=
 =?utf-8?B?Wkp3Zm5vZjZDVGRGOGhMdzR3N0VhbzRlMVI5SVAyZ0Zzdm53RlFROHhDL0NJ?=
 =?utf-8?B?VjZjRjFzUmc0SDNjNmpRRXkrNi9yNXAxVFhmS0RCUWluVjRzZjlDcWVTTzJR?=
 =?utf-8?B?LzJIQTljMjJpN1c4V2ZNeTFsT1RVMk52MFczMitnTlF5bEZoVkxjN0VVd3ZL?=
 =?utf-8?B?ZFFDcjl2YWE1Zi9ldHdzcmNtb1FUYWJCOWEvRWE4aWJsaXNsUUZxaGhzYnZE?=
 =?utf-8?B?NTRjYTdQS1RvSFowWW9VOEpDUUxDUk56MHhHcE5qNVhiZkF4NGNjNEM1bUpL?=
 =?utf-8?B?eU9EZDAvMFVud2NISFJSQnFsRDAyR0YvOWg4cTUwa2RrejFIZ0FoamtwVCt1?=
 =?utf-8?B?aExFU0gxQmNYTDJiU1RrdkV3MFVpdUVHdGJnL3RRZ01vNm03am5MQit6Qk40?=
 =?utf-8?B?NUhoMVJmUDNIQ1dJcHRUMkQzSXhwcnBEYzIyMEJ2RWNiNm1paE1QM0YxMVhz?=
 =?utf-8?B?RStJVzN6c1ZNdEFzb01mWGJHNXFMemRMQXhmOVpnU2xpTXlsemF5dEkyZVUz?=
 =?utf-8?B?SGkrbWMxbXNsNHNhZnljTGZsYzhUeDNYSXVpWE9xMUovaEhLYzRiQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40aaf72b-db11-4fe9-320c-08da3d2f5ce4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 02:44:45.7406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8RESrsolW0MS3uU/PwzpoPBIVAx3FL4spzJJTt10enC5JWPRbwOIFbf/qCHBt5L/+LXeLU/OdFVy//0pQPj3JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7588
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaW0gSGFydmV5IDx0aGFydmV5
QGdhdGV3b3Jrcy5jb20+DQo+IFNlbnQ6IDIwMjLlubQ15pyIMjTml6UgMjo0OA0KPiBUbzogSG9u
Z3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IEx1Y2FzIFN0YWNoIDxsLnN0
YWNoQHBlbmd1dHJvbml4LmRlPjsgcC56YWJlbEBwZW5ndXRyb25peC5kZTsNCj4gYmhlbGdhYXNA
Z29vZ2xlLmNvbTsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgcm9iaEBrZXJuZWwub3JnOw0K
PiBzaGF3bmd1b0BrZXJuZWwub3JnOyB2a291bEBrZXJuZWwub3JnOyBhbGV4YW5kZXIuc3RlaW5A
ZXcudHEtZ3JvdXAuY29tOw0KPiBsaW51eC1waHlAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4LWlt
eEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDUvN10gYXJtNjQ6IGR0czogaW14
OG1wOiBhZGQgdGhlIGlNWDhNUCBQQ0llDQo+IHN1cHBvcnQNCj4gDQo+IE9uIFN1biwgQXByIDE3
LCAyMDIyIGF0IDEwOjAwIFBNIEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+
IHdyb3RlOg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJv
bTogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+DQo+ID4gPiBTZW50OiAyMDIy
5bm0NOaciDE15pelIDU6MDMNCj4gPiA+IFRvOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBu
eHAuY29tPjsgcC56YWJlbEBwZW5ndXRyb25peC5kZTsNCj4gPiA+IGJoZWxnYWFzQGdvb2dsZS5j
b207IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IHJvYmhAa2VybmVsLm9yZzsNCj4gPiA+IHNo
YXduZ3VvQGtlcm5lbC5vcmc7IHZrb3VsQGtlcm5lbC5vcmc7DQo+ID4gPiBhbGV4YW5kZXIuc3Rl
aW5AZXcudHEtZ3JvdXAuY29tDQo+ID4gPiBDYzogbGludXgtcGh5QGxpc3RzLmluZnJhZGVhZC5v
cmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gbGludXgtcGNpQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+ID4gbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51
eC1pbXgNCj4gPiA+IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjIgNS83XSBhcm02NDogZHRzOiBpbXg4bXA6IGFkZCB0aGUgaU1YOE1QIFBDSWUNCj4gPiA+
IHN1cHBvcnQNCj4gPiA+DQo+ID4gPiBBbSBNb250YWcsIGRlbSAwNy4wMy4yMDIyIHVtIDE3OjA3
ICswODAwIHNjaHJpZWIgUmljaGFyZCBaaHU6DQo+ID4gPiA+IEFkZCB0aGUgaS5NWDhNUCBQQ0ll
IHN1cHBvcnQuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxo
b25neGluZy56aHVAbnhwLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBhcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAuZHRzaSB8IDQ2DQo+ID4gPiA+ICsrKysrKysrKysrKysr
KysrKysrKystDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNDUgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OG1wLmR0c2kNCj4gPiA+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9pbXg4bXAuZHRzaQ0KPiA+ID4gPiBpbmRleCBiNDBhNTY0NmYyMDUuLmU3YjNk
ODAyOWUzNCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OG1wLmR0c2kNCj4gPiA+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OG1wLmR0c2kNCj4gPiA+ID4gQEAgLTUsNiArNSw3IEBADQo+ID4gPiA+DQo+ID4gPiA+
ICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svaW14OG1wLWNsb2NrLmg+DQo+ID4gPiA+ICAj
aW5jbHVkZSA8ZHQtYmluZGluZ3MvcG93ZXIvaW14OG1wLXBvd2VyLmg+DQo+ID4gPiA+ICsjaW5j
bHVkZSA8ZHQtYmluZGluZ3MvcmVzZXQvaW14OG1wLXJlc2V0Lmg+DQo+ID4gPiA+ICAjaW5jbHVk
ZSA8ZHQtYmluZGluZ3MvZ3Bpby9ncGlvLmg+ICAjaW5jbHVkZQ0KPiA+ID4gPiA8ZHQtYmluZGlu
Z3MvaW5wdXQvaW5wdXQuaD4gICNpbmNsdWRlDQo+ID4gPiA+IDxkdC1iaW5kaW5ncy9pbnRlcnJ1
cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+ID4gPiA+IEBAIC0zNzUsNyArMzc2LDggQEAgaW9t
dXhjOiBwaW5jdHJsQDMwMzMwMDAwIHsNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICB9Ow0K
PiA+ID4gPg0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgIGdwcjogaW9tdXhjLWdwckAzMDM0
MDAwMCB7DQo+ID4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0g
ImZzbCxpbXg4bXAtaW9tdXhjLWdwciIsDQo+ICJzeXNjb24iOw0KPiA+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJmc2wsaW14OG1wLWlvbXV4Yy1ncHIiLA0K
PiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJmc2wsaW14
NnEtaW9tdXhjLWdwciIsDQo+ID4gPiA+ICsgInN5c2NvbiI7DQo+ID4gPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICByZWcgPSA8MHgzMDM0MDAwMCAweDEwMDAwPjsNCj4gPiA+ID4gICAg
ICAgICAgICAgICAgICAgICB9Ow0KPiA+ID4gPg0KPiA+ID4gPiBAQCAtOTY1LDYgKzk2NywxNyBA
QCBhaXBzNDogYnVzQDMyYzAwMDAwIHsNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAjc2l6
ZS1jZWxscyA9IDwxPjsNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICByYW5nZXM7DQo+ID4g
PiA+DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgcGNpZV9waHk6IHBjaWUtcGh5QDMyZjAw
MDAwIHsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAi
ZnNsLGlteDhtcC1wY2llLXBoeSI7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICByZWcgPSA8MHgzMmYwMDAwMCAweDEwMDAwPjsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHJlc2V0cyA9IDwmc3JjDQo+IElNWDhNUF9SRVNFVF9QQ0lFUEhZPiwNCj4gPiA+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwmc3JjDQo+IElNWDhNUF9S
RVNFVF9QQ0lFUEhZX1BFUlNUPjsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJlc2V0LW5hbWVzID0gInBjaWVwaHkiLCAicGVyc3QiOw0KPiA+ID4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcG93ZXItZG9tYWlucyA9IDwmaHNpb19ibGtfY3RybA0KPiA+ID4gSU1Y
OE1QX0hTSU9CTEtfUERfUENJRV9QSFk+Ow0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgI3BoeS1jZWxscyA9IDwwPjsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgfTsN
Cj4gPiA+ID4gKw0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgIGhzaW9fYmxrX2N0cmw6IGJs
ay1jdHJsQDMyZjEwMDAwIHsNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNv
bXBhdGlibGUgPSAiZnNsLGlteDhtcC1oc2lvLWJsay1jdHJsIiwNCj4gInN5c2NvbiI7DQo+ID4g
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHgzMmYxMDAwMCAweDI0Pjsg
QEAgLTk4MCw2DQo+ID4gPiA+ICs5OTMsMzcgQEAgaHNpb19ibGtfY3RybDogYmxrLWN0cmxAMzJm
MTAwMDAgew0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgIH07DQo+ID4gPiA+ICAgICAgICAg
ICAgIH07DQo+ID4gPiA+DQo+ID4gPiA+ICsgICAgICAgICAgIHBjaWU6IHBjaWVAMzM4MDAwMDAg
ew0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiZnNsLGlteDhtcC1w
Y2llIjsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICByZWcgPSA8MHgzMzgwMDAwMCAweDQw
MDAwMD4sIDwweDFmZjAwMDAwDQo+IDB4ODAwMDA+Ow0KPiA+ID4gPiArICAgICAgICAgICAgICAg
ICAgIHJlZy1uYW1lcyA9ICJkYmkiLCAiY29uZmlnIjsNCj4gPiA+ID4gKyAgICAgICAgICAgICAg
ICAgICAjYWRkcmVzcy1jZWxscyA9IDwzPjsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAj
c2l6ZS1jZWxscyA9IDwyPjsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICBkZXZpY2VfdHlw
ZSA9ICJwY2kiOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgIGJ1cy1yYW5nZSA9IDwweDAw
IDB4ZmY+Ow0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgIHJhbmdlcyA9ICA8MHg4MTAwMDAw
MCAwIDB4MDAwMDAwMDANCj4gMHgxZmY4MDAwMA0KPiA+ID4gPiArIDANCj4gPiA+IDB4MDAwMTAw
MDAgLyogZG93bnN0cmVhbSBJL08gNjRLQiAqLw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgMHg4MjAwMDAwMCAwIDB4MTgwMDAwMDANCj4gMHgxODAwMDAwMA0KPiA+ID4g
PiArIDANCj4gPiA+IDB4MDdmMDAwMDA+OyAvKiBub24tcHJlZmV0Y2hhYmxlIG1lbW9yeSAqLw0K
PiA+ID4gPiArICAgICAgICAgICAgICAgICAgIG51bS1sYW5lcyA9IDwxPjsNCj4gPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICBudW0tdmlld3BvcnQgPSA8ND47DQo+ID4gPiA+ICsgICAgICAgICAg
ICAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDE0MA0KPiBJUlFfVFlQRV9MRVZFTF9ISUdI
PjsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHQtbmFtZXMgPSAibXNpIjsN
Cj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAjaW50ZXJydXB0LWNlbGxzID0gPDE+Ow0KPiA+
ID4gPiArICAgICAgICAgICAgICAgICAgIGludGVycnVwdC1tYXAtbWFzayA9IDwwIDAgMCAweDc+
Ow0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgIGludGVycnVwdC1tYXAgPSA8MCAwIDAgMSAm
Z2ljIEdJQ19TUEkgMTI2DQo+ID4gPiBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCj4gPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPDAgMCAwIDIgJmdpYyBHSUNfU1BJIDEy
NQ0KPiBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgPDAgMCAwIDMgJmdpYyBHSUNfU1BJIDEyNA0KPiBJUlFfVFlQRV9MRVZF
TF9ISUdIPiwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPDAg
MCAwIDQgJmdpYyBHSUNfU1BJIDEyMw0KPiBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gPiA+ID4g
KyAgICAgICAgICAgICAgICAgICBmc2wsbWF4LWxpbmstc3BlZWQgPSA8Mz47DQo+ID4gPg0KPiA+
ID4gSSBiZWxpZXZlIHRoYXQgaW14Nl9wY2llX3N0YXJ0X2xpbmsgZG9lcyBub3QgcHJvcGVybHkg
aGFuZGxlIEdlbjMgc3BlZWRzLg0KPiA+IEdvb2QgY2F1Z2h0Lg0KPiA+IFRoZSBhY2NvcmRpbmcg
bGlua19nZW4gY29uZGl0aW9uIHNob3VsZCBiZSBjaGFuZ2VkIGluIGRyaXZlciB0b28uDQo+ID4g
V291bGQgYmUgY2hhbmdlZCBpbiBuZXh0IHZlcnNpb24uDQo+ID4gVGhhbmtzLg0KPiA+DQo+ID4g
QmVzdCBSZWdhcmRzDQo+ID4gUmljaGFyZCBaaHUNCj4gPiA+DQo+ID4gPiBSZWdhcmRzLA0KPiA+
ID4gTHVjYXMNCj4gPiA+DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgbGludXgscGNpLWRv
bWFpbiA9IDwwPjsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICBwb3dlci1kb21haW5zID0g
PCZoc2lvX2Jsa19jdHJsDQo+IElNWDhNUF9IU0lPQkxLX1BEX1BDSUU+Ow0KPiA+ID4gPiArICAg
ICAgICAgICAgICAgICAgIHJlc2V0cyA9IDwmc3JjDQo+IElNWDhNUF9SRVNFVF9QQ0lFX0NUUkxf
QVBQU19FTj4sDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgPCZzcmMNCj4g
SU1YOE1QX1JFU0VUX1BDSUVfQ1RSTF9BUFBTX1RVUk5PRkY+Ow0KPiA+ID4gPiArICAgICAgICAg
ICAgICAgICAgIHJlc2V0LW5hbWVzID0gImFwcHMiLCAidHVybm9mZiI7DQo+ID4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgcGh5cyA9IDwmcGNpZV9waHk+Ow0KPiA+ID4gPiArICAgICAgICAgICAg
ICAgICAgIHBoeS1uYW1lcyA9ICJwY2llLXBoeSI7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiA+ID4gKyAgICAgICAgICAgfTsNCj4gPiA+ID4g
Kw0KPiA+ID4gPiAgICAgICAgICAgICBncHUzZDogZ3B1QDM4MDAwMDAwIHsNCj4gPiA+ID4gICAg
ICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gInZpdmFudGUsZ2MiOw0KPiA+ID4gPiAgICAg
ICAgICAgICAgICAgICAgIHJlZyA9IDwweDM4MDAwMDAwIDB4ODAwMD47DQo+ID4gPg0KPiA+DQo+
IA0KPiBSaWNoYXJkLA0KPiANCj4gRG8geW91IGhhdmUgYW4gdXBkYXRlZCBzZXJpZXMgZm9yIElN
WDhNUCBQQ0llIHlldD8gSSBiZWxpZXZlIGV2ZXJ5dGhpbmcgeW91DQo+IHdlcmUgd2FpdGluZyBv
biBpcyBub3cgbWVyZ2VkIChibGstY3RybCBhbmQgcG93ZXItZG9tYWluKS4NCkhpIFRpbToNClRo
YW5rcyBmb3IgeW91ciBraW5kbHkgaGVscC4NCkx1Y2FzIGhhcyBzb21lIHN1Z2dlc3Rpb25zIGFu
ZCBhZHZpY2VzIGFib3V0IHRoZSBIU0lPTUlYIGJpdHMgbWFuaXB1bGF0aW9ucw0KaW4gdGhlIFBI
WSBkcml2ZXIgb2YgdGhpcyBzZXJpZXMoIzMgcGF0Y2gpLg0KV291bGQgaXNzdWUgdGhlIG5leHQg
dmVyc2lvbiwgYWZ0ZXIgY28tb3BlcmF0ZSB3aXRoIEx1Y2FzIGFuZCBzZXR0bGUtZG93bg0KIHRo
YXQgcGFydC4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiANCj4gQmVzdCBSZWdhcmRz
LA0KPiANCj4gVGltDQo=
