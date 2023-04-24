Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6A26EC49A
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 07:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjDXFAL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 01:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDXFAK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 01:00:10 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2131.outbound.protection.outlook.com [40.107.113.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A61273A;
        Sun, 23 Apr 2023 22:00:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bH+6OXwIwnaG+ewA78qzmQBUS84OVIUaKVAlwRFjXmT0DaudIG+EVuqDuQrObEVuFJ8zbUfrwdqC8roqNUArV1XHB3eyF8BwB7uf8d79dXcDuBOAHk716ck5QXhhzFO+OQaoYKkS29rOoS/p3EEn1W1nbzxtO35qJXcshmgOCDrEB4NW4g4UORRNwwnWCQOmgDSqvQlLssmkXFIl8w5NqpV/VLY0Vto4RgS5kTIJjHuVstnXrjXDQ3YY7ORzqZdQKlwiuGEMj0XTFsOKnoQRwyncR7mczx59BHifTnynDIfdQ+ZiqZnjLbW6jv6RgmKLwGk9BVDKxwFqkEGDtxVfvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5laZqXEpa7vGayEpe0DhthmbOgYUDaHWhTrLb4/Rr+c=;
 b=XbfwWky0L8HKoA5uhQDqUNB/AaXLdBa7KGi9uDSOMDPi6qyRxsQsTfXTJSsXw+lcSi+uf88LK2VbQ22R0nAEm8H6sL4UEU6PGg2ORsIwrvJH8MlyZu1ln0k29AT2A5QDdc4BSdPg/F7NIWr9XVT656GxTWyYbomkU0TN0cgqZCZjlZhE6MjVzoSg6AX7STwPTlh3/GVVb8I1DNCGbCs72YoEshph5mj6pPHbYI959etEF636uPspFnJQRE96d5eLJQ/pB+e0SZKRR61un8KxQewc9CLI5KlVwnQSHm7fiSxBbpz66FW09J+QvpyZdy0lZG0+v4rpz+A6P5fqJg8vQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5laZqXEpa7vGayEpe0DhthmbOgYUDaHWhTrLb4/Rr+c=;
 b=auozO+7RRsXanmQ/JAEzWdBROyGDbMATypgJN6xhEe1/CdW6XJQs79iJeG5Yxs4QdDBfXtebZdrTShWbNNC7cx0DK+8kFUXdF5IDgOcfOPujH/q7gQSB01Q7YEZbBJRFcpO+IuVk7QddcN8It0haHv0xAlFajAVVQBv9LWVOEe4=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OSZPR01MB8733.jpnprd01.prod.outlook.com
 (2603:1096:604:15c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 05:00:03 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%5]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 05:00:03 +0000
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
        <linux-renesas-soc@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: RE: [PATCH v13 04/22] PCI: Rename PCI_EPC_IRQ_LEGACY with
 PCI_EPC_IRQ_INTX
Thread-Topic: [PATCH v13 04/22] PCI: Rename PCI_EPC_IRQ_LEGACY with
 PCI_EPC_IRQ_INTX
Thread-Index: AQHZcfCwad7VIMmynkKXRXNk/ik2sq83LmWAgALAiqA=
Date:   Mon, 24 Apr 2023 05:00:02 +0000
Message-ID: <TYBPR01MB5341508D53C3D70C37A558DED8679@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
 <20230418122403.3178462-5-yoshihiro.shimoda.uh@renesas.com>
 <20230422105649.GA4769@thinkpad>
In-Reply-To: <20230422105649.GA4769@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OSZPR01MB8733:EE_
x-ms-office365-filtering-correlation-id: 6ad295b5-d37d-40f8-0499-08db4480c386
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PWHFmSIa0uGPc2ek7AAk1j+WUl95xKvUumN2j2SJviQfPDkrd55klqWh4QPv5ImC9UhcACV0VjvMBh/8Z6ezWhS0Qtmu8ig/D6Ps2hLvmhzlku0gyRc5RhhPq3oHqcuyl+KdEvsm6H8mk6CdJR8IhB5uo8EqzKa0CA5YzwlVc2ZmBlh4D+PyE9DBC6cwiUweYfPBaBLmPnpZC/vi4+ajPyXqlN9Gf2v22t3A3/iFdDuxscqfBD+xOPppQWHA9Qbf8yv6x/2GqDEQeF0c3BmEjzVvZMNFVhY9H0fZVgUowRv8YmtXm5O1EurkkGZdtEItdRNWJqz566LA4xv1HHJ8OFxCauIkDmVA2pJMx6a/ltC6Rf5uUX6h/TbEVHVvGFVad+/OX1i7g/VE3Y3QSJDR6UIh973Mpr615zoITEgN8fSdRXeb6JrmCgVwrgvfSxzNoKIk0qA5Ns8jd/AkrsMTmdiiA1A1UHUFJx+LCb3keVXq1T6PG1An74556ufHxXQHZLPpg7UG2RQWZaH8UWoPLoIHpeutWo2CrKnzDEzF1vl0nAju9rD3ckacUPtjkoa0U3P9hJRrVPVJ2myH9DnjYVlV9vxBT+iXac9INhRA6bjW9sDaIKDZzKJH98wJjQ+Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199021)(2906002)(30864003)(7696005)(71200400001)(55016003)(9686003)(6506007)(186003)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(8936002)(316002)(41300700001)(6916009)(4326008)(478600001)(7406005)(5660300002)(52536014)(7416002)(54906003)(38070700005)(38100700002)(122000001)(86362001)(33656002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzFMN0NzNUVHaDNGN005bExFQ2FuQ0tNdzVSN3FhdUdiRktJL1YvOU1zNVpU?=
 =?utf-8?B?WGYyU0diREY4QVYrQ2FLMjllSDJZOXdhbVQ4cy80OVExMjd5YVhhUGdqRmlB?=
 =?utf-8?B?UE5OUVYrNEVUREttZy9kNjY5QlhLcFcwUXNuVllOaEluRkQ3dndtcDlCcEtu?=
 =?utf-8?B?RlpUN2dkZHlWL2syakxJVG1OZkNoRzg5UitaOVdNcysyQ2pOUEpYNlBUYlVF?=
 =?utf-8?B?VFlNbC9SYm9zWWIzNWd6Q0VzVTBteEt4T0JDZSt4Z0dsdndxRzR6aERuT2Iv?=
 =?utf-8?B?QXY4L0dYckJCSGF5ZnhOZXd2bUtpK0dzSk9zRjl1aFJ3TUhoc0NFWnBjUE8x?=
 =?utf-8?B?ZHlmaHI4Sjh5VllWTWF0QUF6a21ZeGFWWmRHR2tJbFhqUG1hNVZ1cTU4NXZn?=
 =?utf-8?B?dmFWenBWampGeHV0d25ET1dkMlBsOE9TKzc5MlZ5ajQ5YXk3SXVJbGI4WXds?=
 =?utf-8?B?MkZJUFZKbUdsNVhBZzBZQWt1Yno1MldWL2plZC85bUt2ZGE5ZytlY1BXU3Bu?=
 =?utf-8?B?aFM0VzZDUVRPSFVxWWFJam5ubm1INk92QmdRcFM1RVdxcGh4UC9lSXpsdjA4?=
 =?utf-8?B?cUFLVHBydDUvbDVzUHdKZGRCZjcvUnJiR2tKZUFydG44Mk1pdTF6TVpPeXU3?=
 =?utf-8?B?dzd4YW9hTXcrTTQvZGdRTDRUUWlTYlFBTDBENzQ4d2l0NHFrWkhkN3F1Yzg3?=
 =?utf-8?B?M2kveGl3UmdUb1hZcFZTYndsWDFRSjFnT2YxWmY5QnA0aUl4ZmJaMkFTTEND?=
 =?utf-8?B?RmYvKy9HMG9JL2dVaTlzSGU0QlhOMk04U2ZZODc2a0x5dTg3QldoY0xXVHpC?=
 =?utf-8?B?WDR4U25QRW9IU0FaKys3Zm5qYUk5YURSNmdiNVNDUWdGODVtV2V0UHBURDFk?=
 =?utf-8?B?bS9hcEkzMDk1T2d1cTkyb0ZtMHdReTUvOW1nOFpTZXpTaWJ4bDNMU0pYR3FQ?=
 =?utf-8?B?c0VtZWk5Z3JDQldCWGhNc00xTHZCeGQwSTFyRjdGdGJaTGVWclVWbTEvRTZm?=
 =?utf-8?B?MFZlUVQxZ1FHN2F5bVlUVDFkL1FJQllXQzExckpIbUhnbTVaM0dGcDd3bU9V?=
 =?utf-8?B?SEo3eVQ4KzVGYWpScFdDTTY2L2lSSHV4K3F2Z3NlSEVYdmVsUG82L0J0NTRJ?=
 =?utf-8?B?VEVzNFQvMmpWNWprelNNU2cwMEdGYlptMGk5bmk4RGtyaEZ2RXJrT2pQdTA4?=
 =?utf-8?B?SDkyUkdjc2EreHZLbnJBZjYzQlVLc3lGcXB6UG9FM0pRK0l1eEFOeDNHK3JO?=
 =?utf-8?B?Z2JGRll2NnFGSXQrdEV2bXZZMEw1OHBXWU5EWU4vVmF0UWxuQks1enJZRkp4?=
 =?utf-8?B?WkZwU2pyYXo4TDJka2s1TWtrNGd2eEozY3hWbDFONGUvUkFuZmNZWWZnT1ZC?=
 =?utf-8?B?YStSVDFYZ0ZYWHRtUER0WEtxbHJ0S2JpMjNtMHFidG00SU9OVDFNd0k4bGVX?=
 =?utf-8?B?Q0xGU1VRMlRVb1BQSTZUb2xIZE4vVWRiKzE3S1JCMnRwdHNRY3dtNGpZczN2?=
 =?utf-8?B?RW1VQzMyaVFDVUN6cVZROFVxY0FJZUUzN3FBUHRZOU5YbHJpZmhXTmFtTkwv?=
 =?utf-8?B?SDF3aVBMOUtyaHpqTElyRDNzRlFNczU5T3hVMXZXQUFwMHpvQTY1VjNxeGtL?=
 =?utf-8?B?VW5lRlZybTludlJIdDVsemc1UkdrU1BSTWIzVXpIU3dIbEwzczhQRDlaem13?=
 =?utf-8?B?WVVZanorNUVaODV2eXkzOXZPT2N5ZXdZNmFSaFd0Yk1RZnNvc2duZnoxUVJ1?=
 =?utf-8?B?QWpDOWlFaFhxMWN1cmwwLyt4ZCtiWG1mVXFWNFJUbEN4RFN5VHJuV0M5WXRT?=
 =?utf-8?B?U3AyaFBKSDBaaFJ1Mk84QUE2akNCWVNLd1ExNzJPV2lLQ3RMVzU3azhiM2Fq?=
 =?utf-8?B?SE0yaktna1NnL0ZDV1ZNOTJTWS8vSE8vYUVGanFVek11cWdsSHltQkRFajJi?=
 =?utf-8?B?M2s5RFgrWkhTTytkbmRvMWVaMmdNaGJMSWNaQ0NuL0l5ZTZaRE5TL2w2UFoz?=
 =?utf-8?B?S0ptU000WWtZRS9tNkNhRUw0WkEremR4dnF2NVlNQ0M3N1FtYTZVMUUyR0JH?=
 =?utf-8?B?cUloVkJxM1lUVkYvR090Q2V6NXp6ZU5iZDI5V2U5TTFlbisvdFMzMm9PY1Yy?=
 =?utf-8?B?eUZFTVFwckxuamh6dTh0aVgyeTVVUUpxU0ZJMTJKUEE1TFI5a0JIM0JHajVm?=
 =?utf-8?B?ZW5xMzF4ZFZoMkJmSzlONTBNN2Z5MElzNXlma3I5SjdXQWtseVpRNHFieTNN?=
 =?utf-8?B?dXprS3VSTXNZVjNIbFZQN1owY2F3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad295b5-d37d-40f8-0499-08db4480c386
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 05:00:02.9676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3963Aqr/gjLwnAlnbtYwqPP5JaCsbFYiZKneJ/XaNH3LFEvjiJORQE9DQoOuMeCzuzVVLVrFaRlV+bdmFNiQ4F9RX5kbhTrrcEOdZdmRiEXlFVPe6QUYsyopvpGUPdjO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8733
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
dHVyZGF5LCBBcHJpbCAyMiwgMjAyMyA3OjU3IFBNDQo+IA0KPiBPbiBUdWUsIEFwciAxOCwgMjAy
MyBhdCAwOToyMzo0NVBNICswOTAwLCBZb3NoaWhpcm8gU2hpbW9kYSB3cm90ZToNCj4gDQo+IFN1
YmplY3Qgc2hvdWxkIGJlOg0KPiANCj4gUENJOiBSZW5hbWUgUENJX0VQQ19JUlFfTEVHQUNZIHRv
IFBDSV9FUENfSVJRX0lOVFgNCj4gDQo+ID4gVXNpbmcgIklOVHgiIGluc3RlYWQgb2YgImxlZ2Fj
eSIgaXMgbW9yZSBzcGVjaWZpYy4gU28sIHJlbmFtZQ0KPiA+IFBDSV9FUENfSVJRX0xFR0FDWSB3
aXRoIFBDSV9FUENfSVJRX0lOVFguDQo+IA0KPiBzL3dpdGgvdG8NCg0KSSdsbCBmaXggdGhlbSBv
biB2MTQuDQoNCj4gPg0KPiA+IFN1Z2dlc3RlZC1ieTogQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0Br
ZXJuZWwub3JnPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvc2hpaGlybyBTaGltb2RhIDx5b3NoaWhp
cm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4NCj4gDQo+IFdpdGggYWJvdmUgY2hhbmdlcywNCj4g
DQo+IFJldmlld2VkLWJ5OiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbmlAa2VybmVsLm9yZz4N
Cg0KVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciByZXZpZXchDQoNCkJlc3QgcmVnYXJkcywN
Cllvc2hpaGlybyBTaGltb2RhDQoNCj4gLSBNYW5pDQo+IA0KPiA+IENjOiBUb20gSm9zZXBoIDx0
am9zZXBoQGNhZGVuY2UuY29tPg0KPiA+IENjOiBWaWduZXNoIFJhZ2hhdmVuZHJhIDx2aWduZXNo
ckB0aS5jb20+DQo+ID4gQ2M6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4g
PiBDYzogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+DQo+ID4gQ2M6IFNoYXdu
IEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4NCj4gPiBDYzogU2FzY2hhIEhhdWVyIDxzLmhhdWVy
QHBlbmd1dHJvbml4LmRlPg0KPiA+IENjOiBQZW5ndXRyb25peCBLZXJuZWwgVGVhbSA8a2VybmVs
QHBlbmd1dHJvbml4LmRlPg0KPiA+IENjOiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5j
b20+DQo+ID4gQ2M6IE5YUCBMaW51eCBUZWFtIDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gPiBDYzog
TWluZ2h1YW4gTGlhbiA8bWluZ2h1YW4uTGlhbkBueHAuY29tPg0KPiA+IENjOiBNaW5na2FpIEh1
IDxtaW5na2FpLmh1QG54cC5jb20+DQo+ID4gQ2M6IFJveSBaYW5nIDxyb3kuemFuZ0BueHAuY29t
Pg0KPiA+IENjOiBKZXNwZXIgTmlsc3NvbiA8amVzcGVyLm5pbHNzb25AYXhpcy5jb20+DQo+ID4g
Q2M6IEppbmdvbyBIYW4gPGppbmdvb2hhbjFAZ21haWwuY29tPg0KPiA+IENjOiBNYW5pdmFubmFu
IFNhZGhhc2l2YW0gPG1hbmlAa2VybmVsLm9yZz4NCj4gPiBDYzogU2VyZ2UgU2VtaW4gPGZhbmNl
ci5sYW5jZXJAZ21haWwuY29tPg0KPiA+IENjOiBTcmlrYW50aCBUaG9rYWxhIDxzcmlrYW50aC50
aG9rYWxhQGludGVsLmNvbT4NCj4gPiBDYzogVGhpZXJyeSBSZWRpbmcgPHRoaWVycnkucmVkaW5n
QGdtYWlsLmNvbT4NCj4gPiBDYzogSm9uYXRoYW4gSHVudGVyIDxqb25hdGhhbmhAbnZpZGlhLmNv
bT4NCj4gPiBDYzogS3VuaWhpa28gSGF5YXNoaSA8aGF5YXNoaS5rdW5paGlrb0Bzb2Npb25leHQu
Y29tPg0KPiA+IENjOiBNYXNhbWkgSGlyYW1hdHN1IDxtaGlyYW1hdEBrZXJuZWwub3JnPg0KPiA+
IENjOiBNYXJlayBWYXN1dCA8bWFyZWsudmFzdXQrcmVuZXNhc0BnbWFpbC5jb20+DQo+ID4gQ2M6
IFNoYXduIExpbiA8c2hhd24ubGluQHJvY2stY2hpcHMuY29tPg0KPiA+IENjOiBIZWlrbyBTdHVl
Ym5lciA8aGVpa29Ac250ZWNoLmRlPg0KPiA+IENjOiBLaXNob24gVmlqYXkgQWJyYWhhbSBJIDxr
aXNob25Aa2VybmVsLm9yZz4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9j
YWRlbmNlL3BjaWUtY2FkZW5jZS1lcC5jICB8ICAyICstDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaS1kcmE3eHguYyAgICAgICAgICAgfCAgMiArLQ0KPiA+ICBkcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jICAgICAgICAgICAgIHwgIDIgKy0NCj4gPiAgZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWtleXN0b25lLmMgICAgICAgICB8ICAyICstDQo+
ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1sYXllcnNjYXBlLWVwLmMgICAgfCAg
MiArLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWFydHBlYzYuYyAgICAg
ICAgIHwgIDIgKy0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253
YXJlLXBsYXQuYyB8ICAyICstDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUt
a2VlbWJheS5jICAgICAgICAgfCAgMiArLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2llLXFjb20tZXAuYyAgICAgICAgIHwgIDIgKy0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jICAgICAgICB8ICAyICstDQo+ID4gIGRyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaWUtdW5pcGhpZXItZXAuYyAgICAgfCAgMiArLQ0KPiA+ICBkcml2
ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtcmNhci1lcC5jICAgICAgICAgICAgIHwgIDIgKy0NCj4g
PiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLXJvY2tjaGlwLWVwLmMgICAgICAgICB8ICAy
ICstDQo+ID4gIGRyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLXRlc3QuYyAg
ICAgfCAxMiArKysrKystLS0tLS0NCj4gPiAgaW5jbHVkZS9saW51eC9wY2ktZXBjLmggICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICA0ICsrLS0NCj4gPiAgMTUgZmlsZXMgY2hhbmdlZCwgMjEg
aW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9wY2kvY29udHJvbGxlci9jYWRlbmNlL3BjaWUtY2FkZW5jZS1lcC5jIGIvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9jYWRlbmNlL3BjaWUtY2FkZW5jZS1lcC5jDQo+ID4gaW5kZXggYjhiNjU1
ZDQwNDdlLi4yYWY4ZWI0ZTZkOTEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJv
bGxlci9jYWRlbmNlL3BjaWUtY2FkZW5jZS1lcC5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9jYWRlbmNlL3BjaWUtY2FkZW5jZS1lcC5jDQo+ID4gQEAgLTUzOSw3ICs1MzksNyBA
QCBzdGF0aWMgaW50IGNkbnNfcGNpZV9lcF9yYWlzZV9pcnEoc3RydWN0IHBjaV9lcGMgKmVwYywg
dTggZm4sIHU4IHZmbiwNCj4gPiAgCXN0cnVjdCBkZXZpY2UgKmRldiA9IHBjaWUtPmRldjsNCj4g
Pg0KPiA+ICAJc3dpdGNoICh0eXBlKSB7DQo+ID4gLQljYXNlIFBDSV9FUENfSVJRX0xFR0FDWToN
Cj4gPiArCWNhc2UgUENJX0VQQ19JUlFfSU5UWDoNCj4gPiAgCQlpZiAodmZuID4gMCkgew0KPiA+
ICAJCQlkZXZfZXJyKGRldiwgIkNhbm5vdCByYWlzZSBsZWdhY3kgaW50ZXJydXB0cyBmb3IgVkZc
biIpOw0KPiA+ICAJCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9kd2MvcGNpLWRyYTd4eC5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpLWRyYTd4eC5jDQo+ID4gaW5kZXggNGFlODA3ZTdjZjc5Li5iNDJmYjFjYzhiYzggMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWRyYTd4eC5jDQo+
ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWRyYTd4eC5jDQo+ID4gQEAg
LTQxMCw3ICs0MTAsNyBAQCBzdGF0aWMgaW50IGRyYTd4eF9wY2llX3JhaXNlX2lycShzdHJ1Y3Qg
ZHdfcGNpZV9lcCAqZXAsIHU4IGZ1bmNfbm8sDQo+ID4gIAlzdHJ1Y3QgZHJhN3h4X3BjaWUgKmRy
YTd4eCA9IHRvX2RyYTd4eF9wY2llKHBjaSk7DQo+ID4NCj4gPiAgCXN3aXRjaCAodHlwZSkgew0K
PiA+IC0JY2FzZSBQQ0lfRVBDX0lSUV9MRUdBQ1k6DQo+ID4gKwljYXNlIFBDSV9FUENfSVJRX0lO
VFg6DQo+ID4gIAkJZHJhN3h4X3BjaWVfcmFpc2VfbGVnYWN5X2lycShkcmE3eHgpOw0KPiA+ICAJ
CWJyZWFrOw0KPiA+ICAJY2FzZSBQQ0lfRVBDX0lSUV9NU0k6DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMgYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gaW5kZXggNTI5MDZmOTk5ZjJiLi4xZjM5ZTczM2NlMTkg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBAQCAt
MTA2Miw3ICsxMDYyLDcgQEAgc3RhdGljIGludCBpbXg2X3BjaWVfZXBfcmFpc2VfaXJxKHN0cnVj
dCBkd19wY2llX2VwICplcCwgdTggZnVuY19ubywNCj4gPiAgCXN0cnVjdCBkd19wY2llICpwY2kg
PSB0b19kd19wY2llX2Zyb21fZXAoZXApOw0KPiA+DQo+ID4gIAlzd2l0Y2ggKHR5cGUpIHsNCj4g
PiAtCWNhc2UgUENJX0VQQ19JUlFfTEVHQUNZOg0KPiA+ICsJY2FzZSBQQ0lfRVBDX0lSUV9JTlRY
Og0KPiA+ICAJCXJldHVybiBkd19wY2llX2VwX3JhaXNlX2xlZ2FjeV9pcnEoZXAsIGZ1bmNfbm8p
Ow0KPiA+ICAJY2FzZSBQQ0lfRVBDX0lSUV9NU0k6DQo+ID4gIAkJcmV0dXJuIGR3X3BjaWVfZXBf
cmFpc2VfbXNpX2lycShlcCwgZnVuY19ubywgaW50ZXJydXB0X251bSk7DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1rZXlzdG9uZS5jIGIvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9kd2MvcGNpLWtleXN0b25lLmMNCj4gPiBpbmRleCA3ODgxODg1M2FmOWUu
LjM4MDZmNTUzMDkzNyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2kta2V5c3RvbmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aS1rZXlzdG9uZS5jDQo+ID4gQEAgLTkwOCw3ICs5MDgsNyBAQCBzdGF0aWMgaW50IGtzX3BjaWVf
YW02NTRfcmFpc2VfaXJxKHN0cnVjdCBkd19wY2llX2VwICplcCwgdTggZnVuY19ubywNCj4gPiAg
CXN0cnVjdCBrZXlzdG9uZV9wY2llICprc19wY2llID0gdG9fa2V5c3RvbmVfcGNpZShwY2kpOw0K
PiA+DQo+ID4gIAlzd2l0Y2ggKHR5cGUpIHsNCj4gPiAtCWNhc2UgUENJX0VQQ19JUlFfTEVHQUNZ
Og0KPiA+ICsJY2FzZSBQQ0lfRVBDX0lSUV9JTlRYOg0KPiA+ICAJCWtzX3BjaWVfYW02NTRfcmFp
c2VfbGVnYWN5X2lycShrc19wY2llKTsNCj4gPiAgCQlicmVhazsNCj4gPiAgCWNhc2UgUENJX0VQ
Q19JUlFfTVNJOg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2ktbGF5ZXJzY2FwZS1lcC5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWxheWVy
c2NhcGUtZXAuYw0KPiA+IGluZGV4IGM2NDBkYjYwZWRjNi4uYWIzMzA2ZTIwNmQ4IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1sYXllcnNjYXBlLWVwLmMN
Cj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktbGF5ZXJzY2FwZS1lcC5j
DQo+ID4gQEAgLTY1LDcgKzY1LDcgQEAgc3RhdGljIGludCBsc19wY2llX2VwX3JhaXNlX2lycShz
dHJ1Y3QgZHdfcGNpZV9lcCAqZXAsIHU4IGZ1bmNfbm8sDQo+ID4gIAlzdHJ1Y3QgZHdfcGNpZSAq
cGNpID0gdG9fZHdfcGNpZV9mcm9tX2VwKGVwKTsNCj4gPg0KPiA+ICAJc3dpdGNoICh0eXBlKSB7
DQo+ID4gLQljYXNlIFBDSV9FUENfSVJRX0xFR0FDWToNCj4gPiArCWNhc2UgUENJX0VQQ19JUlFf
SU5UWDoNCj4gPiAgCQlyZXR1cm4gZHdfcGNpZV9lcF9yYWlzZV9sZWdhY3lfaXJxKGVwLCBmdW5j
X25vKTsNCj4gPiAgCWNhc2UgUENJX0VQQ19JUlFfTVNJOg0KPiA+ICAJCXJldHVybiBkd19wY2ll
X2VwX3JhaXNlX21zaV9pcnEoZXAsIGZ1bmNfbm8sIGludGVycnVwdF9udW0pOw0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWFydHBlYzYuYyBiL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtYXJ0cGVjNi5jDQo+ID4gaW5kZXggOTgxMDIwNzll
MjZkLi4xMjhjYjExMThlM2EgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9kd2MvcGNpZS1hcnRwZWM2LmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2llLWFydHBlYzYuYw0KPiA+IEBAIC0zNTcsNyArMzU3LDcgQEAgc3RhdGljIGludCBhcnRw
ZWM2X3BjaWVfcmFpc2VfaXJxKHN0cnVjdCBkd19wY2llX2VwICplcCwgdTggZnVuY19ubywNCj4g
PiAgCXN0cnVjdCBkd19wY2llICpwY2kgPSB0b19kd19wY2llX2Zyb21fZXAoZXApOw0KPiA+DQo+
ID4gIAlzd2l0Y2ggKHR5cGUpIHsNCj4gPiAtCWNhc2UgUENJX0VQQ19JUlFfTEVHQUNZOg0KPiA+
ICsJY2FzZSBQQ0lfRVBDX0lSUV9JTlRYOg0KPiA+ICAJCWRldl9lcnIocGNpLT5kZXYsICJFUCBj
YW5ub3QgdHJpZ2dlciBsZWdhY3kgSVJRc1xuIik7DQo+ID4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+
ID4gIAljYXNlIFBDSV9FUENfSVJRX01TSToNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLXBsYXQuYyBiL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1wbGF0LmMNCj4gPiBpbmRleCAxZmNmYjg0MGYyMzgu
LmZjM2IwMjk0OTIxOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2llLWRlc2lnbndhcmUtcGxhdC5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9kd2MvcGNpZS1kZXNpZ253YXJlLXBsYXQuYw0KPiA+IEBAIC00OCw3ICs0OCw3IEBAIHN0YXRp
YyBpbnQgZHdfcGxhdF9wY2llX2VwX3JhaXNlX2lycShzdHJ1Y3QgZHdfcGNpZV9lcCAqZXAsIHU4
IGZ1bmNfbm8sDQo+ID4gIAlzdHJ1Y3QgZHdfcGNpZSAqcGNpID0gdG9fZHdfcGNpZV9mcm9tX2Vw
KGVwKTsNCj4gPg0KPiA+ICAJc3dpdGNoICh0eXBlKSB7DQo+ID4gLQljYXNlIFBDSV9FUENfSVJR
X0xFR0FDWToNCj4gPiArCWNhc2UgUENJX0VQQ19JUlFfSU5UWDoNCj4gPiAgCQlyZXR1cm4gZHdf
cGNpZV9lcF9yYWlzZV9sZWdhY3lfaXJxKGVwLCBmdW5jX25vKTsNCj4gPiAgCWNhc2UgUENJX0VQ
Q19JUlFfTVNJOg0KPiA+ICAJCXJldHVybiBkd19wY2llX2VwX3JhaXNlX21zaV9pcnEoZXAsIGZ1
bmNfbm8sIGludGVycnVwdF9udW0pOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2llLWtlZW1iYXkuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUta2VlbWJheS5jDQo+ID4gaW5kZXggZjkwZjM2YmFjMDE4Li5jZWI5NDBiMzI3Y2IgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1rZWVtYmF5LmMNCj4g
PiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWtlZW1iYXkuYw0KPiA+IEBA
IC0yOTAsNyArMjkwLDcgQEAgc3RhdGljIGludCBrZWVtYmF5X3BjaWVfZXBfcmFpc2VfaXJxKHN0
cnVjdCBkd19wY2llX2VwICplcCwgdTggZnVuY19ubywNCj4gPiAgCXN0cnVjdCBkd19wY2llICpw
Y2kgPSB0b19kd19wY2llX2Zyb21fZXAoZXApOw0KPiA+DQo+ID4gIAlzd2l0Y2ggKHR5cGUpIHsN
Cj4gPiAtCWNhc2UgUENJX0VQQ19JUlFfTEVHQUNZOg0KPiA+ICsJY2FzZSBQQ0lfRVBDX0lSUV9J
TlRYOg0KPiA+ICAJCS8qIExlZ2FjeSBpbnRlcnJ1cHRzIGFyZSBub3Qgc3VwcG9ydGVkIGluIEtl
ZW0gQmF5ICovDQo+ID4gIAkJZGV2X2VycihwY2ktPmRldiwgIkxlZ2FjeSBJUlEgaXMgbm90IHN1
cHBvcnRlZFxuIik7DQo+ID4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcWNvbS1lcC5jIGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpZS1xY29tLWVwLmMNCj4gPiBpbmRleCAxOWIzMjgzOWVhMjYuLjA3N2Fm
Y2U0OGQwYiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ll
LXFjb20tZXAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcWNv
bS1lcC5jDQo+ID4gQEAgLTY1OCw3ICs2NTgsNyBAQCBzdGF0aWMgaW50IHFjb21fcGNpZV9lcF9y
YWlzZV9pcnEoc3RydWN0IGR3X3BjaWVfZXAgKmVwLCB1OCBmdW5jX25vLA0KPiA+ICAJc3RydWN0
IGR3X3BjaWUgKnBjaSA9IHRvX2R3X3BjaWVfZnJvbV9lcChlcCk7DQo+ID4NCj4gPiAgCXN3aXRj
aCAodHlwZSkgew0KPiA+IC0JY2FzZSBQQ0lfRVBDX0lSUV9MRUdBQ1k6DQo+ID4gKwljYXNlIFBD
SV9FUENfSVJRX0lOVFg6DQo+ID4gIAkJcmV0dXJuIGR3X3BjaWVfZXBfcmFpc2VfbGVnYWN5X2ly
cShlcCwgZnVuY19ubyk7DQo+ID4gIAljYXNlIFBDSV9FUENfSVJRX01TSToNCj4gPiAgCQlyZXR1
cm4gZHdfcGNpZV9lcF9yYWlzZV9tc2lfaXJxKGVwLCBmdW5jX25vLCBpbnRlcnJ1cHRfbnVtKTsN
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5
NC5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jDQo+ID4gaW5k
ZXggMDk4MjViNGEwNzVlLi40YWRiYTM3OWI4M2QgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jDQo+ID4gQEAgLTE5ODAsNyArMTk4MCw3IEBA
IHN0YXRpYyBpbnQgdGVncmFfcGNpZV9lcF9yYWlzZV9pcnEoc3RydWN0IGR3X3BjaWVfZXAgKmVw
LCB1OCBmdW5jX25vLA0KPiA+ICAJc3RydWN0IHRlZ3JhX3BjaWVfZHcgKnBjaWUgPSB0b190ZWdy
YV9wY2llKHBjaSk7DQo+ID4NCj4gPiAgCXN3aXRjaCAodHlwZSkgew0KPiA+IC0JY2FzZSBQQ0lf
RVBDX0lSUV9MRUdBQ1k6DQo+ID4gKwljYXNlIFBDSV9FUENfSVJRX0lOVFg6DQo+ID4gIAkJcmV0
dXJuIHRlZ3JhX3BjaWVfZXBfcmFpc2VfbGVnYWN5X2lycShwY2llLCBpbnRlcnJ1cHRfbnVtKTsN
Cj4gPg0KPiA+ICAJY2FzZSBQQ0lfRVBDX0lSUV9NU0k6DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdW5pcGhpZXItZXAuYyBiL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaWUtdW5pcGhpZXItZXAuYw0KPiA+IGluZGV4IDRkMGE1ODdjMGJhNS4u
Nzc4N2VlZGY4N2Y0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaWUtdW5pcGhpZXItZXAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaWUtdW5pcGhpZXItZXAuYw0KPiA+IEBAIC0yNjIsNyArMjYyLDcgQEAgc3RhdGljIGludCB1
bmlwaGllcl9wY2llX2VwX3JhaXNlX2lycShzdHJ1Y3QgZHdfcGNpZV9lcCAqZXAsIHU4IGZ1bmNf
bm8sDQo+ID4gIAlzdHJ1Y3QgZHdfcGNpZSAqcGNpID0gdG9fZHdfcGNpZV9mcm9tX2VwKGVwKTsN
Cj4gPg0KPiA+ICAJc3dpdGNoICh0eXBlKSB7DQo+ID4gLQljYXNlIFBDSV9FUENfSVJRX0xFR0FD
WToNCj4gPiArCWNhc2UgUENJX0VQQ19JUlFfSU5UWDoNCj4gPiAgCQlyZXR1cm4gdW5pcGhpZXJf
cGNpZV9lcF9yYWlzZV9sZWdhY3lfaXJxKGVwKTsNCj4gPiAgCWNhc2UgUENJX0VQQ19JUlFfTVNJ
Og0KPiA+ICAJCXJldHVybiB1bmlwaGllcl9wY2llX2VwX3JhaXNlX21zaV9pcnEoZXAsIGZ1bmNf
bm8sDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1yY2FyLWVw
LmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtcmNhci1lcC5jDQo+ID4gaW5kZXggZjk2
ODJkZjFkYTYxLi5mYmRmM2Q4NTMwMWMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9wY2llLXJjYXItZXAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
cGNpZS1yY2FyLWVwLmMNCj4gPiBAQCAtNDA4LDcgKzQwOCw3IEBAIHN0YXRpYyBpbnQgcmNhcl9w
Y2llX2VwX3JhaXNlX2lycShzdHJ1Y3QgcGNpX2VwYyAqZXBjLCB1OCBmbiwgdTggdmZuLA0KPiA+
ICAJc3RydWN0IHJjYXJfcGNpZV9lbmRwb2ludCAqZXAgPSBlcGNfZ2V0X2RydmRhdGEoZXBjKTsN
Cj4gPg0KPiA+ICAJc3dpdGNoICh0eXBlKSB7DQo+ID4gLQljYXNlIFBDSV9FUENfSVJRX0xFR0FD
WToNCj4gPiArCWNhc2UgUENJX0VQQ19JUlFfSU5UWDoNCj4gPiAgCQlyZXR1cm4gcmNhcl9wY2ll
X2VwX2Fzc2VydF9pbnR4KGVwLCBmbiwgMCk7DQo+ID4NCj4gPiAgCWNhc2UgUENJX0VQQ19JUlFf
TVNJOg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtcm9ja2No
aXAtZXAuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1yb2NrY2hpcC1lcC5jDQo+ID4g
aW5kZXggZDFhMjAwYjkzYjJiLi5lZjlkMWY2YzM4MmEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9wY2llLXJvY2tjaGlwLWVwLmMNCj4gPiArKysgYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL3BjaWUtcm9ja2NoaXAtZXAuYw0KPiA+IEBAIC00NzcsNyArNDc3LDcgQEAg
c3RhdGljIGludCByb2NrY2hpcF9wY2llX2VwX3JhaXNlX2lycShzdHJ1Y3QgcGNpX2VwYyAqZXBj
LCB1OCBmbiwgdTggdmZuLA0KPiA+ICAJc3RydWN0IHJvY2tjaGlwX3BjaWVfZXAgKmVwID0gZXBj
X2dldF9kcnZkYXRhKGVwYyk7DQo+ID4NCj4gPiAgCXN3aXRjaCAodHlwZSkgew0KPiA+IC0JY2Fz
ZSBQQ0lfRVBDX0lSUV9MRUdBQ1k6DQo+ID4gKwljYXNlIFBDSV9FUENfSVJRX0lOVFg6DQo+ID4g
IAkJcmV0dXJuIHJvY2tjaGlwX3BjaWVfZXBfc2VuZF9sZWdhY3lfaXJxKGVwLCBmbiwgMCk7DQo+
ID4gIAljYXNlIFBDSV9FUENfSVJRX01TSToNCj4gPiAgCQlyZXR1cm4gcm9ja2NoaXBfcGNpZV9l
cF9zZW5kX21zaV9pcnEoZXAsIGZuLCBpbnRlcnJ1cHRfbnVtKTsNCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1lcGYtdGVzdC5jIGIvZHJpdmVycy9w
Y2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1lcGYtdGVzdC5jDQo+ID4gaW5kZXggMTcyZTVhYzBi
ZDk2Li4zNmEyYTgxMjA2NTMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvZW5kcG9pbnQv
ZnVuY3Rpb25zL3BjaS1lcGYtdGVzdC5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvZW5kcG9pbnQv
ZnVuY3Rpb25zL3BjaS1lcGYtdGVzdC5jDQo+ID4gQEAgLTE5LDExICsxOSwxMSBAQA0KPiA+ICAj
aW5jbHVkZSA8bGludXgvcGNpLWVwZi5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvcGNpX3JlZ3Mu
aD4NCj4gPg0KPiA+IC0jZGVmaW5lIElSUV9UWVBFX0xFR0FDWQkJCTANCj4gPiArI2RlZmluZSBJ
UlFfVFlQRV9JTlRYCQkJMA0KPiA+ICAjZGVmaW5lIElSUV9UWVBFX01TSQkJCTENCj4gPiAgI2Rl
ZmluZSBJUlFfVFlQRV9NU0lYCQkJMg0KPiA+DQo+ID4gLSNkZWZpbmUgQ09NTUFORF9SQUlTRV9M
RUdBQ1lfSVJRCUJJVCgwKQ0KPiA+ICsjZGVmaW5lIENPTU1BTkRfUkFJU0VfSU5UWF9JUlEJCUJJ
VCgwKQ0KPiA+ICAjZGVmaW5lIENPTU1BTkRfUkFJU0VfTVNJX0lSUQkJQklUKDEpDQo+ID4gICNk
ZWZpbmUgQ09NTUFORF9SQUlTRV9NU0lYX0lSUQkJQklUKDIpDQo+ID4gICNkZWZpbmUgQ09NTUFO
RF9SRUFECQkJQklUKDMpDQo+ID4gQEAgLTYwNiw5ICs2MDYsOSBAQCBzdGF0aWMgdm9pZCBwY2lf
ZXBmX3Rlc3RfcmFpc2VfaXJxKHN0cnVjdCBwY2lfZXBmX3Rlc3QgKmVwZl90ZXN0LCB1OCBpcnFf
dHlwZSwNCj4gPiAgCXJlZy0+c3RhdHVzIHw9IFNUQVRVU19JUlFfUkFJU0VEOw0KPiA+DQo+ID4g
IAlzd2l0Y2ggKGlycV90eXBlKSB7DQo+ID4gLQljYXNlIElSUV9UWVBFX0xFR0FDWToNCj4gPiAr
CWNhc2UgSVJRX1RZUEVfSU5UWDoNCj4gPiAgCQlwY2lfZXBjX3JhaXNlX2lycShlcGMsIGVwZi0+
ZnVuY19ubywgZXBmLT52ZnVuY19ubywNCj4gPiAtCQkJCSAgUENJX0VQQ19JUlFfTEVHQUNZLCAw
KTsNCj4gPiArCQkJCSAgUENJX0VQQ19JUlFfSU5UWCwgMCk7DQo+ID4gIAkJYnJlYWs7DQo+ID4g
IAljYXNlIElSUV9UWVBFX01TSToNCj4gPiAgCQlwY2lfZXBjX3JhaXNlX2lycShlcGMsIGVwZi0+
ZnVuY19ubywgZXBmLT52ZnVuY19ubywNCj4gPiBAQCAtNjQ5LDEwICs2NDksMTAgQEAgc3RhdGlj
IHZvaWQgcGNpX2VwZl90ZXN0X2NtZF9oYW5kbGVyKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykN
Cj4gPiAgCQlnb3RvIHJlc2V0X2hhbmRsZXI7DQo+ID4gIAl9DQo+ID4NCj4gPiAtCWlmIChjb21t
YW5kICYgQ09NTUFORF9SQUlTRV9MRUdBQ1lfSVJRKSB7DQo+ID4gKwlpZiAoY29tbWFuZCAmIENP
TU1BTkRfUkFJU0VfSU5UWF9JUlEpIHsNCj4gPiAgCQlyZWctPnN0YXR1cyA9IFNUQVRVU19JUlFf
UkFJU0VEOw0KPiA+ICAJCXBjaV9lcGNfcmFpc2VfaXJxKGVwYywgZXBmLT5mdW5jX25vLCBlcGYt
PnZmdW5jX25vLA0KPiA+IC0JCQkJICBQQ0lfRVBDX0lSUV9MRUdBQ1ksIDApOw0KPiA+ICsJCQkJ
ICBQQ0lfRVBDX0lSUV9JTlRYLCAwKTsNCj4gPiAgCQlnb3RvIHJlc2V0X2hhbmRsZXI7DQo+ID4g
IAl9DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9wY2ktZXBjLmggYi9pbmNs
dWRlL2xpbnV4L3BjaS1lcGMuaA0KPiA+IGluZGV4IDMwMWJiMGU1MzcwNy4uYzI1NzJhOTNkNzNk
IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvcGNpLWVwYy5oDQo+ID4gKysrIGIvaW5j
bHVkZS9saW51eC9wY2ktZXBjLmgNCj4gPiBAQCAtMjEsNyArMjEsNyBAQCBlbnVtIHBjaV9lcGNf
aW50ZXJmYWNlX3R5cGUgew0KPiA+DQo+ID4gIGVudW0gcGNpX2VwY19pcnFfdHlwZSB7DQo+ID4g
IAlQQ0lfRVBDX0lSUV9VTktOT1dOLA0KPiA+IC0JUENJX0VQQ19JUlFfTEVHQUNZLA0KPiA+ICsJ
UENJX0VQQ19JUlFfSU5UWCwNCj4gPiAgCVBDSV9FUENfSVJRX01TSSwNCj4gPiAgCVBDSV9FUENf
SVJRX01TSVgsDQo+ID4gIH07DQo+ID4gQEAgLTU0LDcgKzU0LDcgQEAgcGNpX2VwY19pbnRlcmZh
Y2Vfc3RyaW5nKGVudW0gcGNpX2VwY19pbnRlcmZhY2VfdHlwZSB0eXBlKQ0KPiA+ICAgKgkgICAg
IE1TSS1YIGNhcGFiaWxpdHkgcmVnaXN0ZXINCj4gPiAgICogQGdldF9tc2l4OiBvcHMgdG8gZ2V0
IHRoZSBudW1iZXIgb2YgTVNJLVggaW50ZXJydXB0cyBhbGxvY2F0ZWQgYnkgdGhlIFJDDQo+ID4g
ICAqCSAgICAgZnJvbSB0aGUgTVNJLVggY2FwYWJpbGl0eSByZWdpc3Rlcg0KPiA+IC0gKiBAcmFp
c2VfaXJxOiBvcHMgdG8gcmFpc2UgYSBsZWdhY3ksIE1TSSBvciBNU0ktWCBpbnRlcnJ1cHQNCj4g
PiArICogQHJhaXNlX2lycTogb3BzIHRvIHJhaXNlIGFuIElOVHgsIE1TSSBvciBNU0ktWCBpbnRl
cnJ1cHQNCj4gPiAgICogQG1hcF9tc2lfaXJxOiBvcHMgdG8gbWFwIHBoeXNpY2FsIGFkZHJlc3Mg
dG8gTVNJIGFkZHJlc3MgYW5kIHJldHVybiBNU0kgZGF0YQ0KPiA+ICAgKiBAc3RhcnQ6IG9wcyB0
byBzdGFydCB0aGUgUENJIGxpbmsNCj4gPiAgICogQHN0b3A6IG9wcyB0byBzdG9wIHRoZSBQQ0kg
bGluaw0KPiA+IC0tDQo+ID4gMi4yNS4xDQo+ID4NCj4gDQo+IC0tDQo+IOCuruCuo+Cuv+CuteCu
o+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==
