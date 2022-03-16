Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2124DA6BB
	for <lists+linux-pci@lfdr.de>; Wed, 16 Mar 2022 01:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240689AbiCPAPH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Mar 2022 20:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbiCPAPG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Mar 2022 20:15:06 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499FA63FA;
        Tue, 15 Mar 2022 17:13:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3QLOnDJWU38B0UPyXEQGPLUE34UEr9SEGWWKtADFA8JbR9tda1scDV+Ode3mme/BEBGKvf7A6xQevhCjEfXuf38qRUFIf624MGjzqqYAdNFjPuLruoW9kCV0/Ho4ykF47xFRilJYj7sPQMpqGM6Sc8EEPfGa3xKeX7lyAz+O4NesNSd6sBQ2zsLbe91rysmhiZsxD7lJ65q/AVK3YsU2tH8PSLd/nDUp5diczI8eC+8pRgFxFq8m3oNfPdsM9b3ByoR6qG9LshmXu/z8H62DYS1ZKIYsEDNu7AzIQ1Fy9OXo2PUDS2IDBg0+obVTGEwL5yI7jFk3ZSleKKvfRRaKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aKD0330vVb6cjFCrqPZRcsgx3MP2SHa38Mcye+nnAg=;
 b=AxBObwCpU8jVwDzxPnZ+ZN1ciXO01LPg7B4V1Sc/0bLMnNCy9pwbYKi1SSDha3uNGL3cCCPHEGLgikrNm1aGhtBv9NGVKy3HCtIWBT4ZGLpLKoEnpeQFE8argrG0F9P1o2B/JkLUaNTtu15vY6zFSDG7Na98ZoSQEU3HMfW0FJgl1Xz1KTfo2kZSEpm4pl63iQ1dSpKhuw/4z2N8OguNESm9lD5Ptl9y4rEFvt6BvAeh79kwYltY+IdjiJ9Xj4dfn3YexHAbhAOH+dhHAdmbbBVoeA6uWncF1BytB0OYxJ3gqagn3cisvVKrjh25CQE4SZrvXCpqxo2gW4d6AsLKRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aKD0330vVb6cjFCrqPZRcsgx3MP2SHa38Mcye+nnAg=;
 b=b2GhMyAF3g2hF+ZhWBS/g7Pp3Izq3nZnnX9mwGLYlXR8sPNa13+aEdOdK56DP6u+qxLImKUgLGXKOYpAK6q+5OC1DdWy8pR2vpjQY4iTytHUUTbc95txDZJYFjO09wmv3Ppw16z1Wkx6pkYSz0fWcvF4uL12uS/IBRuMayIdOrU=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB6094.eurprd04.prod.outlook.com (2603:10a6:803:f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.29; Wed, 16 Mar
 2022 00:13:49 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f4f1:fe49:d19e:4770]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f4f1:fe49:d19e:4770%9]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 00:13:49 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v2] PCI: imx6: Assert i.MX8MM CLKREQ# even if no device
 present
Thread-Topic: [PATCH v2] PCI: imx6: Assert i.MX8MM CLKREQ# even if no device
 present
Thread-Index: AQHYKSzAyD6KlX2DBkWsg1rw2U4b/azBQomg
Date:   Wed, 16 Mar 2022 00:13:49 +0000
Message-ID: <AS8PR04MB8676DF41D10EB1DDAC6F11A88C119@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1645672013-8949-1-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1645672013-8949-1-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cd0d6ad-0814-4d5f-3974-08da06e1d8b0
x-ms-traffictypediagnostic: VI1PR04MB6094:EE_
x-microsoft-antispam-prvs: <VI1PR04MB60941BB8F294EDEAF3C3D7D78C119@VI1PR04MB6094.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oQesuJhykrAZwJUqRkTuBtCrHSANW6G9DXdmVKLiSQpYaWey7mUOpmbzu9R5ze1EJB204M2UXctsrIgZ4gxZFTdSSpb5ZhFmWC88tjCxkwe3Ml04vznFLbbb6AvQUgEavRwtXBS/bp/5vxxTOtxnnKv8xJKGXMqGMQqyL/yOgroDT0LkN0dE1bW0zQkOHSikC9EQU7bJNa7dTpxkaySXfirxWANAbjy4r32SUrBnoRHiFEonL98TCYVV7UA4diT34XMBkSVo6FJNd73YBE3XgWbFYDVS2+FtrDEdpaPw+bS7Ob21kSTUIq3GXgFKuMZSJl9DkGeKL7W6z4CfCXm2fk/AmlSUC+FVrzce28fVH/Q6HRseLlD0ZYodvego+WjoBnrZOniGS+FFDm1eDNnLdQnq6qtUf/k2u0GdCxs2sF+ikB8O7KHun6ClGXgaQ2HtkwFcCKcXeyyXluPp9UE/USPF4aT64XCJ6WomFBnvABt5Tg+moWeb3Y6YCr91nbW7FwpamV6Z7f5xcGb0G/WnRC+V4c+WepBe8dmpHXJpHikkXE0T3JeIxtLdBSNNHbYtImRRfDnlX30XLsq1eF4GpXK/uu90floXMksA4YgOqmHWcrlvejtnmv8KLSDcfhD+X9LMevmNThH7BBqBseVlrWlt07KmuyBrfRmXnks/EjWJBwql5eCb9IgchNAafg19wmJ3PfQSws6jusNPfn5b0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(84040400005)(26005)(186003)(54906003)(55016003)(316002)(76116006)(66946007)(66556008)(66476007)(66446008)(83380400001)(38070700005)(86362001)(7696005)(508600001)(110136005)(71200400001)(9686003)(6506007)(64756008)(38100700002)(122000001)(53546011)(8936002)(52536014)(2906002)(44832011)(4326008)(8676002)(33656002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?cU1SZVZwK0xwbkZKeWxGRFQrZmRKNkNYTTZuOGdJUTJja1R2b3NvWmZXbnBM?=
 =?gb2312?B?KzEzbUpadjVPUkxobnF4QmFRcFhSdE1naUZpeG54Ly85aWRnZjJmN0c5UVRa?=
 =?gb2312?B?Zm1JMVF5bnpJUjY2ditoTjVOVHY3QXBVSTVUNVViYk1KTGFUYTRzaXJQZlVE?=
 =?gb2312?B?ZVlyNmtBbVFianJhMitPei9mQjZOa0MrcEMrM3hBMGU2dERZSXhsUC9aL1R4?=
 =?gb2312?B?RE5keHJmSDVtbjExMnhqVXJ0TXJucDJxaWxlTUtIMDBIS3RNN1NkUHA2aUxT?=
 =?gb2312?B?dVNpQmNwKzQ2a2hBOXZOK0JlYnRwVmY0RnRCR0FEdmFSMUtlUGNqdlljQUVY?=
 =?gb2312?B?ZVRFeldEcURxTGtycHBpSy9jRlZyMWdPclk5MW5zSjdPZFViOU51bXNNSXpp?=
 =?gb2312?B?RHdNdkp6bDRXTUlLa2lJNVVETFhJVzdMVlZDZ1VPN2JkdWdxeUVldThvY1Qy?=
 =?gb2312?B?OVJUaWxaZ1dhWFpUWkk2VFpLRkVOUU84L2VnRjUvRVhIZVpZdmhQRUlEcmZu?=
 =?gb2312?B?bjJSOUtHOHkrdDRUVHlpUHhTbXZ0bGNvUllleHhnNFA4emFNT3Fub2M1ZFpw?=
 =?gb2312?B?WjNpQVR6TmNsaW5VTlhwK2RxQTlMdmIvS1hRTUJLU2NkZVJWRFBVanc1S1lO?=
 =?gb2312?B?VTFyTm1nUm5iOXVsR3E0dWMwbDVTUEZIcG4zdG12S2FOeURRUXBScGtmai9a?=
 =?gb2312?B?UmlRM3dkeW9uT0NRbmhVYnRsdlo0RlgzRHJhdk1McWwvU2tsTUpLOU5hay9y?=
 =?gb2312?B?TDNleE50MGgwWHY1Y3MxMzd6ajh2ZjU3TG5mU21sOEhkM1p6TGZiODZyd2Vo?=
 =?gb2312?B?TTRKeXlQOFI0NVZiMVA2KzJZSERCbmhWN08wMTJZZzNQaG1yWTc3MERjVFY3?=
 =?gb2312?B?RndxTUxOM0J0TW9HbDRZVGZvZVpyUGNCT2tLbUtiUjJxRHZhTEpkTFZqNk5N?=
 =?gb2312?B?MmNvRUxuMlB6RGdBNFFlQU8xWEo5NlkrTXJyeWdWdnRYVzhzRk1JU25kTExM?=
 =?gb2312?B?OG5QZWk4NldjckhRZFMxRzdKWnlNcGx5NHE2QS9HT3QyV3pISmVFK0lMSExp?=
 =?gb2312?B?VG5NNk9GUWlCZkM3U3NudDJvVTRveWMrY3dmUDlxTEYxRzNZRExxNkVXM0hQ?=
 =?gb2312?B?R0NmK24ya2lVdjJZR25UNGJhdG5MckRlUHZSakRsYkl1NUcwWGdyM3h0SkdO?=
 =?gb2312?B?QVJlNlE1YjFmcm0xLy9VRkplOFdoR3A3MUZsRWtnUlZac3FnNisyZ04wd25Y?=
 =?gb2312?B?bFFoN05vNktkZDZWbkQ0TGtpVU5vcW9mbGllWGRqdmRxTkpTTmlhRXlMQ0Z4?=
 =?gb2312?B?LzhTaU9wTmVpWjJCT0t6Uyt1K0xCNmE2MUc4c05iWkwxWEt0TnMySUNBd3p3?=
 =?gb2312?B?M0c1QjhERkZmRm1heVNaMm9IbmpEK0xxWFkwMFBUVVUwUVVPNUYwd2xhM09O?=
 =?gb2312?B?TitXMXUxMW5TSFB0ZEdNTG85TG1yMnpIUXY0UFhYT0RVTS9KeFQwMHQ3bEtU?=
 =?gb2312?B?OGxYaXB3TEdCUmpuRUcvNDB1U2JYMWpjU0o0elJES1J3RmN6ZnJBbGpTSEpr?=
 =?gb2312?B?OVEyaS80Wm90S09URFRkcXFHQjA2Tmh4ZjlFNSsycjBSQzdYOWxjcnVwUDZ1?=
 =?gb2312?B?aERJSnYvVHpraW9OV3JFMWpYdUEvVnBKakpYZUFmdFUrd3I5VkYzSTYvTEZz?=
 =?gb2312?B?eWhjTWJ2V0kxUy9yV2pQMjBpTEhQVmlLandGbXB2UHQ1Zk1tbjcxNzU5WWFv?=
 =?gb2312?B?WVB3TUF3RmpJbDFtd2hSbVdXL2NaaVFIZUx4Wk43UWdMVTlabVhIdGl4bnJP?=
 =?gb2312?B?RTBFTTdnZSswOTJKNHd0aFFwM1JKcHJnK1dKVlJJekpuSm1FaWp0aHA4RGlR?=
 =?gb2312?B?bklLemR0b3c1WXhZUklMeDcrK1ZrR2srcXdCTEVQSHd6aldWNlhyVWxZRTNC?=
 =?gb2312?Q?v6awBe7gelxtmMZsSKbQgnuioJL5y0YQ?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd0d6ad-0814-4d5f-3974-08da06e1d8b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 00:13:49.8557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: faeMCPoXzv78OF91VgXwCKtJJXPJkDDm1BJa/Lvo1wrUoSPq9u1QL+sZvqSC2gdg874lhcgo7JEK5XX5/4UPQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6094
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTHVjYXM6DQpUaGlzIHBhdGNoIGlzIHBlbmRpbmcgZm9yIGEgd2hpbGUuDQpDYW4geW91IGhl
bHAgdG8gdGFrZSBsb29rIGF0IGl0IGFuZCBnaXZlIHRoZSBhY2sgaWYgeW91IGRvbid0IGhhdmUg
Y29tbWVudHMgb24gaXQ/DQpUaGFuayB5b3UgaW4gYWR2YW5jZWQuDQoNCkJlc3QgUmVnYXJkcw0K
UmljaGFyZCBaaHUNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNo
YXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IFNlbnQ6IDIwMjLE6jLUwjI0yNUgMTE6
MDcNCj4gVG86IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+
IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXgNCj4g
PGxpbnV4LWlteEBueHAuY29tPjsgSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4N
Cj4gU3ViamVjdDogW1BBVENIIHYyXSBQQ0k6IGlteDY6IEFzc2VydCBpLk1YOE1NIENMS1JFUSMg
ZXZlbiBpZiBubyBkZXZpY2UNCj4gcHJlc2VudA0KPiANCj4gVGhlIENMS1JFUSMgc2lnbmFsIGlz
IGFuIG9wZW4gZHJhaW4sIGFjdGl2ZSBsb3cgc2lnbmFsIHRoYXQgaXMgZHJpdmVuIGxvdyBieSB0
aGUNCj4gcmVtb3RlIEVuZHBvaW50IGRldmljZS4gQnV0IGl0IG1pZ2h0IG5vdCBiZSBkcml2ZW4g
bG93IGlmIG5vIEVuZHBvaW50IGRldmljZSBpcw0KPiBjb25uZWN0ZWQuDQo+IA0KPiBPbiBpLk1Y
OE1NIFBDSWUsIHBoeV9pbml0KCkgbWF5IGZhaWwgYW5kIHN5c3RlbSBib290IG1heSBoYW5nIGlm
IG5vDQo+IEVuZHBvaW50IGlzIGNvbm5lY3RlZCB0byBhc3NlcnQgQ0xLUkVRIy4NCj4gDQo+IEhh
bmRsZSB0aGlzIGFzIG9uIGkuTVg4TVEsIHdoZXJlIHdlIGV4cGxpY2l0bHkgYXNzZXJ0IENMS1JF
USMgc28gdGhlIFBIWQ0KPiBjYW4gYmUgaW5pdGlhbGl6ZWQuDQo+IA0KPiBGaXhlczogMTc4ZTI0
NGNiNmUyICgiUENJOiBpbXg6IEFkZCB0aGUgaW14OG1tIHBjaWUgc3VwcG9ydCIpDQo+IFNpZ25l
ZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHwgNCAtLS0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpLWlteDYuYw0KPiBpbmRleCA3OGUzMmE1MzkwNjAuLjE2OGNiMTI4N2JhOSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiArKysgYi9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+IEBAIC00NDcsMTAgKzQ0Nyw2IEBA
IHN0YXRpYyBpbnQgaW14Nl9wY2llX2VuYWJsZV9yZWZfY2xrKHN0cnVjdCBpbXg2X3BjaWUNCj4g
KmlteDZfcGNpZSkNCj4gIAljYXNlIElNWDdEOg0KPiAgCQlicmVhazsNCj4gIAljYXNlIElNWDhN
TToNCj4gLQkJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGlteDZfcGNpZS0+cGNpZV9hdXgpOw0K
PiAtCQlpZiAocmV0KQ0KPiAtCQkJZGV2X2VycihkZXYsICJ1bmFibGUgdG8gZW5hYmxlIHBjaWVf
YXV4IGNsb2NrXG4iKTsNCj4gLQkJYnJlYWs7DQo+ICAJY2FzZSBJTVg4TVE6DQo+ICAJCXJldCA9
IGNsa19wcmVwYXJlX2VuYWJsZShpbXg2X3BjaWUtPnBjaWVfYXV4KTsNCj4gIAkJaWYgKHJldCkg
ew0KPiAtLQ0KPiAyLjI1LjENCg0K
