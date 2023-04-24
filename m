Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7476EC4C2
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 07:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjDXFYD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 01:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDXFYC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 01:24:02 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2135.outbound.protection.outlook.com [40.107.114.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416FB26AD;
        Sun, 23 Apr 2023 22:24:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d77ScS4aT7RhlqcaJnb/EVpsns5oN67URKY0jh+kMhcPqG5sP+2aFYSAl0Wm8e1ffhse1VKfsp36/k9GKKDDoOFvoUZTn6e5yV7JmE1hbpUEpFt6oh/v9F+UxPyUanVzcyUR32smg3JzKd/Kyt30mTFVzeNhRQYVBhDGUxmWo5APzObnWMD+mb5yzT92Vz091qiV52YJuZ6QPYSAdVTlucVsgBGVzpv9M1x595bbdyxSNOHTDEnXxMaa6KqdaR2m7qjxvy11bzrb4tK9Wgq2LsGhy2VYElBw+axl6cDjD2bYa5R9GCT98Y98WIowbZxLFzTM2j99aJDJozJCpKl55w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVbHGmx/WySgOxr9U2leOSbu6vGrXpf+Xe0+vOp28qg=;
 b=mpRZC781fW3cfDOuEJzqDjmL8JdYxumc1Uvpi26u1DAi/fa9XqZwvCQYOCTqJqEfnyXmWzXehLELrfzHXyYB7ahQToHBkpmY1tiB7sFX2UqUfgIQ8+k365Q5J+jvEkH6Ucm8oOa8lsqNG1rvkBtZu1wlY9APAYISLQhFMz7q448/iwN4Gx4NyhqehVy09zUXP/TDLcKpTN15LuCJ30DFC0deZ1bw7w0MtsZE3nbXyDEVU9jnoa+VjNwX/kJ4/cf5YU1dyQRIeSXVhEfKMZLNLJuZdGsCxBb4kUgi9L5YjERwo+tOqjqYhcQm5AlhSpaHRlzCFGyV0bkeQ2BuwJRl/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVbHGmx/WySgOxr9U2leOSbu6vGrXpf+Xe0+vOp28qg=;
 b=THxH/uSTF0Odg3C6BOuD8nhAXBJ7e8DwHOkds3v2kQ2QpN2skaRaAkhH5xR/zvVrSBeGSTw8jbHVQqQmD/cdgl5UWYTTb/CX3gG//5vVm+xniXOtU9pS44ZLstx+WCJorU7f7D0KIMI7U5CJwk2+v2TU5vtt8aKu2tdd7uK4hpk=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYTPR01MB11064.jpnprd01.prod.outlook.com
 (2603:1096:400:3a1::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 05:23:57 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%5]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 05:23:57 +0000
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
Subject: RE: [PATCH v13 06/22] PCI: dwc: Introduce struct dw_pcie_outbound_atu
Thread-Topic: [PATCH v13 06/22] PCI: dwc: Introduce struct
 dw_pcie_outbound_atu
Thread-Index: AQHZcfCxU6qv/gUnQEOWFkQn8WkUUq83Mg8AgAABnYCAAsIbIA==
Date:   Mon, 24 Apr 2023 05:23:57 +0000
Message-ID: <TYBPR01MB5341484DE185BEA2BD7CAB0CD8679@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
 <20230418122403.3178462-7-yoshihiro.shimoda.uh@renesas.com>
 <20230422110956.GC4769@thinkpad> <20230422111543.GE4769@thinkpad>
In-Reply-To: <20230422111543.GE4769@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYTPR01MB11064:EE_
x-ms-office365-filtering-correlation-id: a603278a-64ab-4b18-86a4-08db44841a53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tsQg2YaP4xiyspyiHSO5MMJvKfbZ5tfLeViLb8Ql82Ti9nKuuVImbhdtCKHzcNOAEATqfDiVmFGnvD4xn33ie3KG7oHmWT9LcdiItBvBOtDW1UFRnbCD3NB5tD33l325JBNQTqyaHVlH3OYnNBkyPqh1mB2MueND9x65CFxkW0Y1i5oHStIkCt5X6j6c+jg4esBGGe3JsQ4++mqvh5xzhRmliNZi0Ik8wu/2wndX9eZxRtpOPFb22vXolNIqrSefsWEkX7z8T6WayE40n5+zmU6AB2SKRjmBbve+gQ/gj1LKTXTTTa4iCtCWhZT5gz55AvCW8jpKUr5EuS/JU40W8edcZzq7YKMZ6+d804A3jmzDjv6WTykKKwSK6IhEB19r+GqcqUGIeUVoANJyJO+uPQ0c3vkYOtkLN1DFsnXZMGnC1vOL8xr9QVdTQe1Cm4ziMe77qhszgrIMY/DWhXBeX4rcRwKJyhlY/tC6xSFdOu190sT1Ym9DkkDPV/n7ahNduLVo9aVGb1ABl9jnK5sc/5JHIfvJ4zkpCldc2PNxs1OXD4j0uOmUf3gadqi2zY/W/HkLB26tl/oqComMS7xUCTnGtpMKB/OQoy6yTkXai7K9RoNRQx4kiOz2xni33t4U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(478600001)(54906003)(86362001)(186003)(7696005)(9686003)(6506007)(55016003)(33656002)(71200400001)(4326008)(6916009)(64756008)(66446008)(66476007)(66556008)(316002)(83380400001)(66946007)(76116006)(2906002)(38100700002)(122000001)(41300700001)(8676002)(8936002)(38070700005)(5660300002)(7416002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmRXOXdUblErV1lLbXIwZ3Qraks4elpkWlBIUkJ3ZzdqVXNOQmhpTXdWUkpj?=
 =?utf-8?B?cUQxR3hqclkzT0hZZUZCdzkzSUlOODY0TWdtNFBwenpDTEg2ZGc3R2h4eG53?=
 =?utf-8?B?bkliS2czMUpwUWlpYzZTa3BuOThYQ09INzF5OGtONHN3NUNEeVZ4YXJLdU9Y?=
 =?utf-8?B?SUdUcDJsaGdCTTlxYzhnYzJCeEgyb3BQa2RUeE1qazhRa3JHRktDa3BhV2lm?=
 =?utf-8?B?OG5ZSzVzbnRyR3lRNjJ0S25Wb29SNnBwcVBiSFc4QnBjQ2phQVJmcW9Lejds?=
 =?utf-8?B?LzRYWm9pMGZaQ0ZJZ3hSaVltaFRmNXJHdGpXQ2FxTE5BS0hjTUliSDAzTzIz?=
 =?utf-8?B?VDNKaFNoRExWdTd3UmVCS2tYWXlrblowOXcxdVpObVB0RW5waWd1NHNiSkV5?=
 =?utf-8?B?SG9XSFFwU2MzbHdZNUR2K0d2aW1OdENCOUVhSHFjRUJGWGdnOFBzVUdaZ1pW?=
 =?utf-8?B?eXpoNHZPVWkxMStiMmtMRTRFYkpmemdMdjR2WFB0cWRISkNmN25PWG9CbjdH?=
 =?utf-8?B?RTVPN2NJNjNwdUNlRmE0MDVMMDZrMXhZNk1nWmIrWi81Ylo3ZDhFU2c4azdL?=
 =?utf-8?B?VXZjL25sVGhBSmw3dFowS1VWeEpjWVM4QVZGUCtjZlJGZndNaGFqVUdGNUZq?=
 =?utf-8?B?dGZpU1lkWXhuWnRWUHhVeUhmQW5NdnpaZGZGMVlYaTRTNXhpZm5VQ3BQcTl2?=
 =?utf-8?B?dmFuU2JIbW1Hb3NMUy9LV2FlaFNVN2E4c2JaakFEQ3VWUm1CL2dsOEZ3ZXhi?=
 =?utf-8?B?MlE1NWJNeGRiZlRvaUxsbCtWUHBSdXNCa1VjMWVSRUlhOTFVanBQeE5oK2Ny?=
 =?utf-8?B?QThmYWx6N3hTRHlvd1JaekNxWnlFYUNWMlJEN3dPWjB0K1pxY0duUjc2TjVS?=
 =?utf-8?B?V011RCsxWmZjdW5EL0Y4SExXWVJrVTlUczNESHJvQXZhQThGY2E1cnlLaUhF?=
 =?utf-8?B?c1FIVjZtaHlObURNM0lvck1wSTc1UmxOTngydDBEYnhoOERLS3hURzB6QUx0?=
 =?utf-8?B?cFhycFFpMW51V3Q5WHFlbmdaY1dQVSswU011WTIxOWl3Qm11V1I1M1IzOTR0?=
 =?utf-8?B?VXdCUkdVdURyZGZxRHYzeWNVZ0I1OFBSbXBNaGlVNVl6SUQrdk45RHphVHV2?=
 =?utf-8?B?ZXB6eEdzMDdkWlJXRVczK1MxM2xZWFNJbER6eFpJUVBXTGZBVWpXY3ZIaVo1?=
 =?utf-8?B?Y3N4Q2hlVzUwRlA4ZGJleTBJVUl3T3IwUnFTUmtrOXdCdFdPZmlyb282UnQ2?=
 =?utf-8?B?Y2dTVVRtdU9GR2pEZFBmcjhSTzVXRVZhZ3VSS05GczlOK0o0S0RvSUxWTjgz?=
 =?utf-8?B?SUNVbnF0QUZ3UUlhdm1ZTnNvLy9MZmtJV3FmRzl5RE5JZTZMTkJWdFpjekdy?=
 =?utf-8?B?bkNaWXMxWGtHYkZzekNneTNXWXo4cktiNUp1TEFld1l3V0lRVXh2U25iWXRR?=
 =?utf-8?B?UHR4V1FlYXZnbVlOdGF3cmRXVTBoandjRGZvNUhLMjA1MFc1U042cFc0OEtx?=
 =?utf-8?B?dDREWFdoZzNPRllVdE5UWCs4WXF6dDZkOVhlampoSlUyVzhjWll6dGsrdGds?=
 =?utf-8?B?ZTY5TzN3bVdqU0Mxbnl5cld6WGpheE4vb0RYSkJQSzc3RGZOUWVDOWl6K3do?=
 =?utf-8?B?bDFkTlQrRVJzZXp4bVJVaDVESTM3bkVNRWRKMHN3aWJpa2R3bmVkUTA0Zzhw?=
 =?utf-8?B?Q0xZemZrVDNXSnlSb2E1NGFYN3MrRk5OMHhRRG5nRS9HKzdDV28xbW9KT29D?=
 =?utf-8?B?RGw5dTh5c1RTNVhubTNzRFJQYkV6MFFqN1E5Q1JXR2NoK09xWjkxbkVGdEEw?=
 =?utf-8?B?Q1VUWVBybE5FRWxOSStBdDJpYjdHaThBYzloRGRpRm55S0xEaVZuMi80QW90?=
 =?utf-8?B?N25yUnplSlNTeEpYY1RIeGJwYXppQ1pkUkF4NnQrM2ZOQ1o3TEozZUk2dTFB?=
 =?utf-8?B?M3hxU2RkdmhLV09pT3d2M3BoQzAzUytKMG9XTm8rcm5Mei9qd3F5RTdVaUVq?=
 =?utf-8?B?K1VUcFh5a2pGVDdNMndMYUtOazl2dzR3eVVCc21IUmRnMU1YUGd5bExBa2Nx?=
 =?utf-8?B?elQ1cUoyUk9PZ2JlbC9sSFQza3p2M21OeGpjcnUrbGg4MDkzYUVkdWdzMjgx?=
 =?utf-8?B?c0JTZm1VR241c2lTR0U4S2didnhQdUJkSFVkdlVLbloySEE3OW0xdDljTmpw?=
 =?utf-8?B?NDVXUXlld3VJSlhBQ0RMY3FUcnBocW95MzNSU2RZL3BxbmhoU0tPcE9KVnRZ?=
 =?utf-8?B?dWlIZDdWODlIamVXamxJTEsrY0xRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a603278a-64ab-4b18-86a4-08db44841a53
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 05:23:57.1055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 86NhFwc0adxibzHT8XvkXXlvWKp5hLnPDQz5/krEbLes7acx7N5BpX0RnsCxRY4QiijcH3u8vX5kNHrKuIGqcCck2LSa3TS24/gMRQu/aDtqTXS9iGb3VVq1Hsm97qaE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB11064
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
dHVyZGF5LCBBcHJpbCAyMiwgMjAyMyA4OjE2IFBNDQo+IA0KPiBPbiBTYXQsIEFwciAyMiwgMjAy
MyBhdCAwNDozOTo1NlBNICswNTMwLCBNYW5pdmFubmFuIFNhZGhhc2l2YW0gd3JvdGU6DQo+ID4g
T24gVHVlLCBBcHIgMTgsIDIwMjMgYXQgMDk6MjM6NDdQTSArMDkwMCwgWW9zaGloaXJvIFNoaW1v
ZGEgd3JvdGU6DQo+ID4gPiBUbyBhZGQgbW9yZSBhcmd1bWVudHMgdG8gdGhlIGR3X3BjaWVfcHJv
Z19lcF9vdXRib3VuZF9hdHUoKSBpbg0KPiA+ID4gdGhlIGZ1dHVyZSwgaW50cm9kdWNlIHN0cnVj
dCBkd19wY2llX291dGJvdW5kX2F0dS4gTm8gYmVoYXZpb3IgY2hhbmdlcy4NCj4gPiA+DQo+ID4N
Cj4gPiBXaHkgYXJlIHlvdSBsaW1pdGluZyB0aGlzIHN0cnVjdCB3aXRoaW4gRFdDIGNvcmUgYW5k
IG5vdCBleHBvc2luZyB0byBjbGllbnQNCj4gPiBkcml2ZXJzPw0KPiANCj4gU3J5LCBub3QgY2xp
ZW50IGRyaXZlcnMgYnV0IHdpdGggdGhlIGR3X3BjaWVfZXBfb3V0Ym91bmRfYXR1KCkgQVBJLg0K
DQpUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudHMhIEknbGwgbW9kaWZ5IHRoaXMgcGF0Y2ggb24g
djEzLg0KDQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8gU2hpbW9kYQ0KDQo+IC0gTWFuaQ0KPiAN
Cj4gPg0KPiA+IC0gTWFuaQ0KPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZb3NoaWhpcm8gU2hp
bW9kYSA8eW9zaGloaXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+DQo+ID4gPiAtLS0NCj4gPiA+
ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuYyB8IDY2ICsrKysr
KysrKysrKy0tLS0tLS0tDQo+ID4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1k
ZXNpZ253YXJlLmggfCAgOSArKysNCj4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDQ4IGluc2VydGlv
bnMoKyksIDI3IGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuYyBiL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jDQo+ID4gPiBpbmRleCBlZGUxNjY2NDUyODkuLjky
YmVlOWQ1MTgwZCAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaWUtZGVzaWdud2FyZS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2llLWRlc2lnbndhcmUuYw0KPiA+ID4gQEAgLTQ2NCw1NiArNDY0LDU1IEBAIHN0YXRpYyBp
bmxpbmUgdTMyIGR3X3BjaWVfZW5hYmxlX2VjcmModTMyIHZhbCkNCj4gPiA+ICAJcmV0dXJuIHZh
bCB8IFBDSUVfQVRVX1REOw0KPiA+ID4gIH0NCj4gPiA+DQo+ID4gPiAtc3RhdGljIGludCBfX2R3
X3BjaWVfcHJvZ19vdXRib3VuZF9hdHUoc3RydWN0IGR3X3BjaWUgKnBjaSwgdTggZnVuY19ubywN
Cj4gPiA+IC0JCQkJICAgICAgIGludCBpbmRleCwgaW50IHR5cGUsIHU2NCBjcHVfYWRkciwNCj4g
PiA+IC0JCQkJICAgICAgIHU2NCBwY2lfYWRkciwgdTY0IHNpemUpDQo+ID4gPiArc3RhdGljIGlu
dCBfX2R3X3BjaWVfcHJvZ19vdXRib3VuZF9hdHUoc3RydWN0IGR3X3BjaWUgKnBjaSwNCj4gPiA+
ICsJCQkJICAgICAgIHN0cnVjdCBkd19wY2llX291dGJvdW5kX2F0dSAqYXR1KQ0KPiA+ID4gIHsN
Cj4gPiA+ICAJdTMyIHJldHJpZXMsIHZhbDsNCj4gPiA+ICAJdTY0IGxpbWl0X2FkZHI7DQo+ID4g
Pg0KPiA+ID4gIAlpZiAocGNpLT5vcHMgJiYgcGNpLT5vcHMtPmNwdV9hZGRyX2ZpeHVwKQ0KPiA+
ID4gLQkJY3B1X2FkZHIgPSBwY2ktPm9wcy0+Y3B1X2FkZHJfZml4dXAocGNpLCBjcHVfYWRkcik7
DQo+ID4gPiArCQlhdHUtPmNwdV9hZGRyID0gcGNpLT5vcHMtPmNwdV9hZGRyX2ZpeHVwKHBjaSwg
YXR1LT5jcHVfYWRkcik7DQo+ID4gPg0KPiA+ID4gLQlsaW1pdF9hZGRyID0gY3B1X2FkZHIgKyBz
aXplIC0gMTsNCj4gPiA+ICsJbGltaXRfYWRkciA9IGF0dS0+Y3B1X2FkZHIgKyBhdHUtPnNpemUg
LSAxOw0KPiA+ID4NCj4gPiA+IC0JaWYgKChsaW1pdF9hZGRyICYgfnBjaS0+cmVnaW9uX2xpbWl0
KSAhPSAoY3B1X2FkZHIgJiB+cGNpLT5yZWdpb25fbGltaXQpIHx8DQo+ID4gPiAtCSAgICAhSVNf
QUxJR05FRChjcHVfYWRkciwgcGNpLT5yZWdpb25fYWxpZ24pIHx8DQo+ID4gPiAtCSAgICAhSVNf
QUxJR05FRChwY2lfYWRkciwgcGNpLT5yZWdpb25fYWxpZ24pIHx8ICFzaXplKSB7DQo+ID4gPiAr
CWlmICgobGltaXRfYWRkciAmIH5wY2ktPnJlZ2lvbl9saW1pdCkgIT0gKGF0dS0+Y3B1X2FkZHIg
JiB+cGNpLT5yZWdpb25fbGltaXQpIHx8DQo+ID4gPiArCSAgICAhSVNfQUxJR05FRChhdHUtPmNw
dV9hZGRyLCBwY2ktPnJlZ2lvbl9hbGlnbikgfHwNCj4gPiA+ICsJICAgICFJU19BTElHTkVEKGF0
dS0+cGNpX2FkZHIsIHBjaS0+cmVnaW9uX2FsaWduKSB8fCAhYXR1LT5zaXplKSB7DQo+ID4gPiAg
CQlyZXR1cm4gLUVJTlZBTDsNCj4gPiA+ICAJfQ0KPiA+ID4NCj4gPiA+IC0JZHdfcGNpZV93cml0
ZWxfYXR1X29iKHBjaSwgaW5kZXgsIFBDSUVfQVRVX0xPV0VSX0JBU0UsDQo+ID4gPiAtCQkJICAg
ICAgbG93ZXJfMzJfYml0cyhjcHVfYWRkcikpOw0KPiA+ID4gLQlkd19wY2llX3dyaXRlbF9hdHVf
b2IocGNpLCBpbmRleCwgUENJRV9BVFVfVVBQRVJfQkFTRSwNCj4gPiA+IC0JCQkgICAgICB1cHBl
cl8zMl9iaXRzKGNwdV9hZGRyKSk7DQo+ID4gPiArCWR3X3BjaWVfd3JpdGVsX2F0dV9vYihwY2ks
IGF0dS0+aW5kZXgsIFBDSUVfQVRVX0xPV0VSX0JBU0UsDQo+ID4gPiArCQkJICAgICAgbG93ZXJf
MzJfYml0cyhhdHUtPmNwdV9hZGRyKSk7DQo+ID4gPiArCWR3X3BjaWVfd3JpdGVsX2F0dV9vYihw
Y2ksIGF0dS0+aW5kZXgsIFBDSUVfQVRVX1VQUEVSX0JBU0UsDQo+ID4gPiArCQkJICAgICAgdXBw
ZXJfMzJfYml0cyhhdHUtPmNwdV9hZGRyKSk7DQo+ID4gPg0KPiA+ID4gLQlkd19wY2llX3dyaXRl
bF9hdHVfb2IocGNpLCBpbmRleCwgUENJRV9BVFVfTElNSVQsDQo+ID4gPiArCWR3X3BjaWVfd3Jp
dGVsX2F0dV9vYihwY2ksIGF0dS0+aW5kZXgsIFBDSUVfQVRVX0xJTUlULA0KPiA+ID4gIAkJCSAg
ICAgIGxvd2VyXzMyX2JpdHMobGltaXRfYWRkcikpOw0KPiA+ID4gIAlpZiAoZHdfcGNpZV92ZXJf
aXNfZ2UocGNpLCA0NjBBKSkNCj4gPiA+IC0JCWR3X3BjaWVfd3JpdGVsX2F0dV9vYihwY2ksIGlu
ZGV4LCBQQ0lFX0FUVV9VUFBFUl9MSU1JVCwNCj4gPiA+ICsJCWR3X3BjaWVfd3JpdGVsX2F0dV9v
YihwY2ksIGF0dS0+aW5kZXgsIFBDSUVfQVRVX1VQUEVSX0xJTUlULA0KPiA+ID4gIAkJCQkgICAg
ICB1cHBlcl8zMl9iaXRzKGxpbWl0X2FkZHIpKTsNCj4gPiA+DQo+ID4gPiAtCWR3X3BjaWVfd3Jp
dGVsX2F0dV9vYihwY2ksIGluZGV4LCBQQ0lFX0FUVV9MT1dFUl9UQVJHRVQsDQo+ID4gPiAtCQkJ
ICAgICAgbG93ZXJfMzJfYml0cyhwY2lfYWRkcikpOw0KPiA+ID4gLQlkd19wY2llX3dyaXRlbF9h
dHVfb2IocGNpLCBpbmRleCwgUENJRV9BVFVfVVBQRVJfVEFSR0VULA0KPiA+ID4gLQkJCSAgICAg
IHVwcGVyXzMyX2JpdHMocGNpX2FkZHIpKTsNCj4gPiA+ICsJZHdfcGNpZV93cml0ZWxfYXR1X29i
KHBjaSwgYXR1LT5pbmRleCwgUENJRV9BVFVfTE9XRVJfVEFSR0VULA0KPiA+ID4gKwkJCSAgICAg
IGxvd2VyXzMyX2JpdHMoYXR1LT5wY2lfYWRkcikpOw0KPiA+ID4gKwlkd19wY2llX3dyaXRlbF9h
dHVfb2IocGNpLCBhdHUtPmluZGV4LCBQQ0lFX0FUVV9VUFBFUl9UQVJHRVQsDQo+ID4gPiArCQkJ
ICAgICAgdXBwZXJfMzJfYml0cyhhdHUtPnBjaV9hZGRyKSk7DQo+ID4gPg0KPiA+ID4gLQl2YWwg
PSB0eXBlIHwgUENJRV9BVFVfRlVOQ19OVU0oZnVuY19ubyk7DQo+ID4gPiAtCWlmICh1cHBlcl8z
Ml9iaXRzKGxpbWl0X2FkZHIpID4gdXBwZXJfMzJfYml0cyhjcHVfYWRkcikgJiYNCj4gPiA+ICsJ
dmFsID0gYXR1LT50eXBlIHwgUENJRV9BVFVfRlVOQ19OVU0oYXR1LT5mdW5jX25vKTsNCj4gPiA+
ICsJaWYgKHVwcGVyXzMyX2JpdHMobGltaXRfYWRkcikgPiB1cHBlcl8zMl9iaXRzKGF0dS0+Y3B1
X2FkZHIpICYmDQo+ID4gPiAgCSAgICBkd19wY2llX3Zlcl9pc19nZShwY2ksIDQ2MEEpKQ0KPiA+
ID4gIAkJdmFsIHw9IFBDSUVfQVRVX0lOQ1JFQVNFX1JFR0lPTl9TSVpFOw0KPiA+ID4gIAlpZiAo
ZHdfcGNpZV92ZXJfaXMocGNpLCA0OTBBKSkNCj4gPiA+ICAJCXZhbCA9IGR3X3BjaWVfZW5hYmxl
X2VjcmModmFsKTsNCj4gPiA+IC0JZHdfcGNpZV93cml0ZWxfYXR1X29iKHBjaSwgaW5kZXgsIFBD
SUVfQVRVX1JFR0lPTl9DVFJMMSwgdmFsKTsNCj4gPiA+ICsJZHdfcGNpZV93cml0ZWxfYXR1X29i
KHBjaSwgYXR1LT5pbmRleCwgUENJRV9BVFVfUkVHSU9OX0NUUkwxLCB2YWwpOw0KPiA+ID4NCj4g
PiA+IC0JZHdfcGNpZV93cml0ZWxfYXR1X29iKHBjaSwgaW5kZXgsIFBDSUVfQVRVX1JFR0lPTl9D
VFJMMiwgUENJRV9BVFVfRU5BQkxFKTsNCj4gPiA+ICsJZHdfcGNpZV93cml0ZWxfYXR1X29iKHBj
aSwgYXR1LT5pbmRleCwgUENJRV9BVFVfUkVHSU9OX0NUUkwyLCBQQ0lFX0FUVV9FTkFCTEUpOw0K
PiA+ID4NCj4gPiA+ICAJLyoNCj4gPiA+ICAJICogTWFrZSBzdXJlIEFUVSBlbmFibGUgdGFrZXMg
ZWZmZWN0IGJlZm9yZSBhbnkgc3Vic2VxdWVudCBjb25maWcNCj4gPiA+ICAJICogYW5kIEkvTyBh
Y2Nlc3Nlcy4NCj4gPiA+ICAJICovDQo+ID4gPiAgCWZvciAocmV0cmllcyA9IDA7IHJldHJpZXMg
PCBMSU5LX1dBSVRfTUFYX0lBVFVfUkVUUklFUzsgcmV0cmllcysrKSB7DQo+ID4gPiAtCQl2YWwg
PSBkd19wY2llX3JlYWRsX2F0dV9vYihwY2ksIGluZGV4LCBQQ0lFX0FUVV9SRUdJT05fQ1RSTDIp
Ow0KPiA+ID4gKwkJdmFsID0gZHdfcGNpZV9yZWFkbF9hdHVfb2IocGNpLCBhdHUtPmluZGV4LCBQ
Q0lFX0FUVV9SRUdJT05fQ1RSTDIpOw0KPiA+ID4gIAkJaWYgKHZhbCAmIFBDSUVfQVRVX0VOQUJM
RSkNCj4gPiA+ICAJCQlyZXR1cm4gMDsNCj4gPiA+DQo+ID4gPiBAQCAtNTI4LDE2ICs1MjcsMjkg
QEAgc3RhdGljIGludCBfX2R3X3BjaWVfcHJvZ19vdXRib3VuZF9hdHUoc3RydWN0IGR3X3BjaWUg
KnBjaSwgdTggZnVuY19ubywNCj4gPiA+ICBpbnQgZHdfcGNpZV9wcm9nX291dGJvdW5kX2F0dShz
dHJ1Y3QgZHdfcGNpZSAqcGNpLCBpbnQgaW5kZXgsIGludCB0eXBlLA0KPiA+ID4gIAkJCSAgICAg
IHU2NCBjcHVfYWRkciwgdTY0IHBjaV9hZGRyLCB1NjQgc2l6ZSkNCj4gPiA+ICB7DQo+ID4gPiAt
CXJldHVybiBfX2R3X3BjaWVfcHJvZ19vdXRib3VuZF9hdHUocGNpLCAwLCBpbmRleCwgdHlwZSwN
Cj4gPiA+IC0JCQkJCSAgIGNwdV9hZGRyLCBwY2lfYWRkciwgc2l6ZSk7DQo+ID4gPiArCXN0cnVj
dCBkd19wY2llX291dGJvdW5kX2F0dSBhdHUgPSB7IDAgfTsNCj4gPiA+ICsNCj4gPiA+ICsJYXR1
LmluZGV4ID0gaW5kZXg7DQo+ID4gPiArCWF0dS50eXBlID0gdHlwZTsNCj4gPiA+ICsJYXR1LmNw
dV9hZGRyID0gY3B1X2FkZHI7DQo+ID4gPiArCWF0dS5wY2lfYWRkciA9IHBjaV9hZGRyOw0KPiA+
ID4gKwlhdHUuc2l6ZSA9IHNpemU7DQo+ID4gPiArCXJldHVybiBfX2R3X3BjaWVfcHJvZ19vdXRi
b3VuZF9hdHUocGNpLCAmYXR1KTsNCj4gPiA+ICB9DQo+ID4gPg0KPiA+ID4gIGludCBkd19wY2ll
X3Byb2dfZXBfb3V0Ym91bmRfYXR1KHN0cnVjdCBkd19wY2llICpwY2ksIHU4IGZ1bmNfbm8sIGlu
dCBpbmRleCwNCj4gPiA+ICAJCQkJIGludCB0eXBlLCB1NjQgY3B1X2FkZHIsIHU2NCBwY2lfYWRk
ciwNCj4gPiA+ICAJCQkJIHU2NCBzaXplKQ0KPiA+ID4gIHsNCj4gPiA+IC0JcmV0dXJuIF9fZHdf
cGNpZV9wcm9nX291dGJvdW5kX2F0dShwY2ksIGZ1bmNfbm8sIGluZGV4LCB0eXBlLA0KPiA+ID4g
LQkJCQkJICAgY3B1X2FkZHIsIHBjaV9hZGRyLCBzaXplKTsNCj4gPiA+ICsJc3RydWN0IGR3X3Bj
aWVfb3V0Ym91bmRfYXR1IGF0dSA9IHsgMCB9Ow0KPiA+ID4gKw0KPiA+ID4gKwlhdHUuZnVuY19u
byA9IGZ1bmNfbm87DQo+ID4gPiArCWF0dS5pbmRleCA9IGluZGV4Ow0KPiA+ID4gKwlhdHUudHlw
ZSA9IHR5cGU7DQo+ID4gPiArCWF0dS5jcHVfYWRkciA9IGNwdV9hZGRyOw0KPiA+ID4gKwlhdHUu
cGNpX2FkZHIgPSBwY2lfYWRkcjsNCj4gPiA+ICsJYXR1LnNpemUgPSBzaXplOw0KPiA+ID4gKwly
ZXR1cm4gX19kd19wY2llX3Byb2dfb3V0Ym91bmRfYXR1KHBjaSwgJmF0dSk7DQo+ID4gPiAgfQ0K
PiA+ID4NCj4gPiA+ICBzdGF0aWMgaW5saW5lIHUzMiBkd19wY2llX3JlYWRsX2F0dV9pYihzdHJ1
Y3QgZHdfcGNpZSAqcGNpLCB1MzIgaW5kZXgsIHUzMiByZWcpDQo+ID4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmggYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaA0KPiA+ID4gaW5kZXggOWFjZjZjNDBk
MjUyLi5jNjU1NmVlMjQ4MzYgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaA0KPiA+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmgNCj4gPiA+IEBAIC0yOTEsNiArMjkxLDE1IEBAIGVu
dW0gZHdfcGNpZV9jb3JlX3JzdCB7DQo+ID4gPiAgCURXX1BDSUVfTlVNX0NPUkVfUlNUUw0KPiA+
ID4gIH07DQo+ID4gPg0KPiA+ID4gK3N0cnVjdCBkd19wY2llX291dGJvdW5kX2F0dSB7DQo+ID4g
PiArCXU2NCBjcHVfYWRkcjsNCj4gPiA+ICsJdTY0IHBjaV9hZGRyOw0KPiA+ID4gKwl1NjQgc2l6
ZTsNCj4gPiA+ICsJaW50IGluZGV4Ow0KPiA+ID4gKwlpbnQgdHlwZTsNCj4gPiA+ICsJdTggZnVu
Y19ubzsNCj4gPiA+ICt9Ow0KPiA+ID4gKw0KPiA+ID4gIHN0cnVjdCBkd19wY2llX2hvc3Rfb3Bz
IHsNCj4gPiA+ICAJaW50ICgqaG9zdF9pbml0KShzdHJ1Y3QgZHdfcGNpZV9ycCAqcHApOw0KPiA+
ID4gIAl2b2lkICgqaG9zdF9kZWluaXQpKHN0cnVjdCBkd19wY2llX3JwICpwcCk7DQo+ID4gPiAt
LQ0KPiA+ID4gMi4yNS4xDQo+ID4gPg0KPiA+DQo+ID4gLS0NCj4gPiDgrq7grqPgrr/grrXgrqPg
r43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+NDQo+IA0KPiAtLQ0KPiDgrq7grqPg
rr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+NDQo=
