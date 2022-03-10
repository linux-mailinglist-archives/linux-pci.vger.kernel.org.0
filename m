Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58ABA4D3F26
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 03:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbiCJCFp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Mar 2022 21:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiCJCFo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Mar 2022 21:05:44 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C75127D52;
        Wed,  9 Mar 2022 18:04:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEePTThECer6DLlKguhS2cPdCHMMZoxPLPboQQN2Sl5TazNEyKHVY4jCb2cr20ezfSp2J1u9VYNrFaQ6j5z0bHtxdJRVWDauUpVcSUlTqBT5oQpIv+3UH4rP6fwH5hGJclMf6ENiYihDd4+FQxyp+ZupQc4hW+d81KDsdsxpvcJjiGhuWEgXx+dvp/J5sBdE3LmfTxJdGqofENzoT0OokDXPAQrutDd2Ja4SP3sY3gQ147ZZZKMlj4+hqRF3TyERPWD5aS1f68BDD4nY4N2FZECeWAKYmY1hhzwJ3a+R7j4fuegAUd8JHUtvjnXgoO4pJjH0Y76CqBaS5a/cbS63Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGaD3lxqVThg3to12LiHTO6w6YQZjfnG8mvPl+NXU8o=;
 b=TX/tU3e30gGjwxUjoqr1RIe7Chd5sK9p2Woy/Q9x1hyisHhS1HKdYLIZzLql0xGpfcFUir+4+ozn/JRHyFc474vKX0ong15KtADZgZedT3kA6stcoCSjD5aAmnZB5R4kJRkiycXgeCEatIJlIP+U2yt2kYSoVb62nuTQ4cKIewtvktstjcj76MZx+I9cUWoZhkxre/6uicUc38uGG4Hm5kvRkpFzIRQ8fQUSFl8SVEJYLYxFxSfiFRdITA2Mqo7+nW5N9Koft2Km7muFQVJH+ChWqqva+A/1miJMdrfGnrgKwsK5tnnocQrzuXfSQC8wIjl5U5TxRkDHHpM1O/cWwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGaD3lxqVThg3to12LiHTO6w6YQZjfnG8mvPl+NXU8o=;
 b=ewewiiw2vK29Oaf6gUgczSlmE/maIjhubtxjgNo/AvcfhyzDlf9aPtPlqvwc2YLNEu/LeTXOS58zM4qtYtM22+e+V51QNpSkcKQr5OapjkI4Xrk7eLl2kha4EQPg2ekXmoPdvrmGO4tF0e/kc30Cvv1l27XiQbO6VHVOSj8sHwk=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB5983.eurprd04.prod.outlook.com (2603:10a6:803:d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 02:04:41 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f4f1:fe49:d19e:4770]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f4f1:fe49:d19e:4770%8]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 02:04:41 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/7] dt-binding: phy: Add iMX8MP PCIe PHY binding
Thread-Topic: [PATCH v2 2/7] dt-binding: phy: Add iMX8MP PCIe PHY binding
Thread-Index: AQHYMgQKfcucK6DC1U6fXyB7sqM2pqy0rcgAgAM0aCA=
Date:   Thu, 10 Mar 2022 02:04:41 +0000
Message-ID: <AS8PR04MB8676BE280A9E4FC8DE8AC9FE8C0B9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1646644054-24421-1-git-send-email-hongxing.zhu@nxp.com>
 <1646644054-24421-3-git-send-email-hongxing.zhu@nxp.com>
 <1646701660.888371.3624774.nullmailer@robh.at.kernel.org>
In-Reply-To: <1646701660.888371.3624774.nullmailer@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77dfd61f-eaee-4a95-36ce-08da023a56f3
x-ms-traffictypediagnostic: VI1PR04MB5983:EE_
x-microsoft-antispam-prvs: <VI1PR04MB598311EE773372A6B953BB448C0B9@VI1PR04MB5983.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZqlkLTm7mgeUPwi2vmZyXC6YRROPjZJqTkD7h0Iit78l8yifXdLG9YyNhZxeT530Llz+LG7of22HDQir8QO6wzduCfLAuQZ5Hv80FXUXEWRSJTKNGFbgkOjLlGFj70KVlQ3h5kOD8ipfW8PjG+exY4mY2iQZAhMHqcWpRuKG8WOKd7Q4Vsk4Jk/VrCCe06zzzquhSFXDmcqiqI2dGhSJxGysX+eQY4bwfbHEGDrypW1bFX+nQ0QUL6Xi59S2YIm02V03f/BCyhBwRPJbtxs6Hv2xWc163VxtgprQKSsK4H8G7+zST+3dWCz2vdTNXQpOyyLyYQmszKkpLyX5vzadQqgbYsQPURbxRjp15TlSDrmJOxgKEsXTjfdeGjaDOULwxVSouWMuq9p3tj9gj/35BHJHA9g3SpbJ9S8HE7XgCK2CTMBuRrqQ9r6BxSjlPbvngBHfP+cAKbIL/wyQpWQ9U8Ua2LLFUrEOHmtwXZ8l+cBYE3LepzwK1RsBsnBa1Em0DaEgJ+oGmcg89uOYJ++yiuWXgLsIu1ZWvVeAPCubBTifuHzpabIkSZnEqD1ztq9KpyX/keIkmJ0nhaZYBbPQiwzkVQ2yvKSe6Q83kbgyWKOHSXuQeZSi4vIyfp93oliVFdLly7PSNXH9cxIkjogrTrA6x5tBR5uzst7cJl942S2AcCdhuV5bPr7kCVNSotXvJErD+myu9173Gh5Q9VWYhq6gHGAgA2IZSsJx7lEOC7/6k6GHD1h00oRQGTjem/fAfdOD25q0ukFoY6wnkrAVtzJ7c3A53drtGGacEV/tyzXv7Brq2VPeXL/vE3aDiUUD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(55016003)(53546011)(6506007)(7696005)(26005)(33656002)(9686003)(64756008)(66946007)(66556008)(66476007)(66446008)(76116006)(966005)(8676002)(122000001)(498600001)(45080400002)(71200400001)(4326008)(38100700002)(38070700005)(86362001)(54906003)(6916009)(52536014)(83380400001)(186003)(44832011)(7416002)(5660300002)(8936002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?NmFjNVhWekZIYWdGSi8xSnA5alZkYlFqNkZKOTJIM1dQMEVjTzhvYVpJMFJz?=
 =?gb2312?B?c2w2by80ZFNJNXlUL2lWK3hUUmFKNUM5aTEwekUyWDZXOS8vVEVaZEMwM1Zv?=
 =?gb2312?B?c0dTb1dpRnAzZDduRm8zNXdiemI4S2wrdmVjVXkrbDY4UDkxU1pHVGlUOGln?=
 =?gb2312?B?b1RRc1IraFlNV0Y0dEdQVTFqdWltK3VRaC83R0xVTUdhMXdsTHFURXMzWGZI?=
 =?gb2312?B?Z0FnU1VBbThHQzR5Sm9DVmRZT3NyNjl2akpIVlMrNlZ6TXE3eWJoSXorZjZZ?=
 =?gb2312?B?MnZtSWFaYUJSRFAzTVZ5UTNBOThTSDRmMVNVQU9mSjNIU2hmTE5TcWliSklx?=
 =?gb2312?B?d2t1OTcwTzhUcFBlNEVxVGVFUis3T2JoRHdETlVBUWMrZTNoWndEZW1CSmI0?=
 =?gb2312?B?K1RCem9iVklkdncrWFh1M29OaHI2M0x5ZXIzSG5ML2Z4THA5aFc2Si9XUERM?=
 =?gb2312?B?c1JHdEUzeDJYYWtpdDRvZ2tlU0p1ZkhYQmVEeDhJOFBjL3IvUUhIdFBjVE8x?=
 =?gb2312?B?SnRHYWJ0WU9jTWlGN3JNb2dGcWpIamI5ZVV0Q2F1enF5Q2VpNXFiTHhHbGRo?=
 =?gb2312?B?N2tLQ1JRcVhPQnpxd3BEUzZiKzEyTE0zMU5kM3BVeGN5aytsam0vZko0UVho?=
 =?gb2312?B?aE9CVmpleXp3OVZtdnYzTHZacExzZEdpM3J2MVdITGVOdW5PdHd4aklZVXdW?=
 =?gb2312?B?U1BEVXlGRzZGa0xWRGwvUjdRMUZSNmw3NGZNL0VwaEpFcmxwbzBKclJCV2dY?=
 =?gb2312?B?ZkNUM2h2ZTBrZ21YN1NjSkZ4LytFTU1ETTJpOXNCV3J3VGtBVXlzbE4zZWR2?=
 =?gb2312?B?V0ljdmVMWDJQWStDWVltekxWR2FuSnZOTWpqOTZFS1BmNHh2Qm01WklHeTBw?=
 =?gb2312?B?cEZGaVN3SVFMdWdnalY1OXZwWWNkQzIwVmVhSzV1WWVVWnJPTkI1UERGOGNC?=
 =?gb2312?B?bUZFUG1DOU56SUpDUktKcUNsVnpRWHgxNW5JSVZUdUlWeHJwakZpNTc3S2tT?=
 =?gb2312?B?elByMDJQNlhEYnN5T3FyV2pFaExXMnp3RlM2TnVud0FQWXVSVkNTeGdxd0xQ?=
 =?gb2312?B?NDZUNE1CMG5IcGp3cUlMdEN4dVRVNC9YR21EbkVSSmJCcG94U3laV3RhcUxO?=
 =?gb2312?B?ZWhzUTBMK0JNZzZiL3dLMHpyK1dSb2VKVG80S0xlMjFCYUpEWEtNaWdVcnRT?=
 =?gb2312?B?b2xjMjFFYlBoTDhVK1lDU284YzVwSEF6OVc3eVJMRTAzVVFYNVJWaFVZTXBj?=
 =?gb2312?B?MDY5eFE5QThrMWFJLzBPZU90cG5pczN2NXlyKzNicGpHREdwcU45Y0hjdE1a?=
 =?gb2312?B?WVRXakRtZWQrZE5ISWtSK3MwWE1SZ3VHK1dsa2UzWTFzazBsTGtpRlE1Myt5?=
 =?gb2312?B?L0NtbGNmeEl3Y0lCVCtRZ1ZXTzdXVjFkK1IrZmd3ekIxbFFjazdWSTBURXM1?=
 =?gb2312?B?UzFTQ2xoV1lqQjI4a2QwNHZvOXp4NjJmclBWMWJnY3FQWnduT1ZVWjdTTURF?=
 =?gb2312?B?SXNmL0FDQXVzeW05em9TaHNDWUJsVUNDaG9rTHBIV0tTeVFIdzRub0R5dk1y?=
 =?gb2312?B?dm00UC8zWWgySno4em1LTERZT3ZBNTlnbEkyY2ZDT1dMYnQ4c3NHbEtZUVVE?=
 =?gb2312?B?UjlVeUJKdjZLRnYvWlRYZUMzUDUyWDMxQVZmQXc2VXVDQ2x4dU1Nd2x2aGR3?=
 =?gb2312?B?OHlxZkI5T0dnOEJOT3BMaTlKN2JyR0U5NVRsRkM1b2xZQmJJQzdaejVLSGJi?=
 =?gb2312?B?MGUyZW55ZUtUTFdzRWlMcjZmOU9SM1hxUzRWbWt1dHRTeHZlTjVFVExjdjB4?=
 =?gb2312?B?cldtUDY3S1dnY2dUSjdRTWR0TWdQUDlwR1ROSnlBdHBaeVRWa1ZIQTdNQXBO?=
 =?gb2312?B?NGxGS2k1RTF3NW5tUkFSWVovTzFydXNsVlBvMVZmemxyMFRBR3ovVFpoZ2Iv?=
 =?gb2312?B?eDFpOWYrdnVTaE1OMEdVUk1HYXJheGduZVdGNnBVWWthVlAxMzN0OFNLMUJq?=
 =?gb2312?B?YjNDWlBrRUNpb21adlgrZUJ3RFdVVUJMLzFkdkRPNngzMndUNG1wbUZlWFdm?=
 =?gb2312?B?ZCtkUnpRc2dmdTZwYjd2c2tHQWtuSjZBOFZjZjVMR0NLSDBkTTdCZlJXdUp2?=
 =?gb2312?B?aSs0R3ZtSzdhSTJ5UlI5WUdweWMydnQweWkrWXA3RnZUZisybS9pazRjbDIr?=
 =?gb2312?B?SVE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77dfd61f-eaee-4a95-36ce-08da023a56f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 02:04:41.5860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q/jUr+fk6XqlkkuUqpJPG7OnZTd3iwkskyIMmS/ABfsEWb4TOlhxKSGikd9Chv21s7JdPXtGXUr3clMRcXqV9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5983
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPg0KPiBTZW50OiAyMDIyxOoz1MI4yNUgOTowOA0KPiBUbzogSG9uZ3hpbmcgWmh1
IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgbGlu
dXgtcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IGxpbnV4
LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGFsZXhhbmRlci5zdGVpbkBldy50cS1ncm91cC5jb207
IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsgcC56YWJlbEBwZW5ndXRyb25peC5kZTsNCj4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNv
bTsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IHZrb3VsQGtlcm5lbC5vcmc7DQo+IGwuc3Rh
Y2hAcGVuZ3V0cm9uaXguZGU7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+Ow0KPiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMi83
XSBkdC1iaW5kaW5nOiBwaHk6IEFkZCBpTVg4TVAgUENJZSBQSFkgYmluZGluZw0KPiANCj4gT24g
TW9uLCAwNyBNYXIgMjAyMiAxNzowNzoyOSArMDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4g
QWRkIGkuTVg4TVAgUENJZSBQSFkgYmluZGluZy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJp
Y2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9mc2wsaW14OC1wY2llLXBoeS55YW1sIHwgNCAr
KystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gPg0KPiANCj4gTXkgYm90IGZvdW5kIGVycm9ycyBydW5uaW5nICdtYWtlIERUX0NIRUNLRVJf
RkxBR1M9LW0gZHRfYmluZGluZ19jaGVjaycNCj4gb24geW91ciBwYXRjaCAoRFRfQ0hFQ0tFUl9G
TEFHUyBpcyBuZXcgaW4gdjUuMTMpOg0KDQpIaSBSb2I6DQpUaGFua3MgZm9yIHlvdXIgaGVscC4g
V291bGQgYmUgZml4ZWQgaW4gbmV4dCB2ZXJzaW9uLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQg
Wmh1DQoNCj4gDQo+IHlhbWxsaW50IHdhcm5pbmdzL2Vycm9yczoNCj4gDQo+IGR0c2NoZW1hL2R0
YyB3YXJuaW5ncy9lcnJvcnM6DQo+IC9idWlsZHMvcm9iaGVycmluZy9saW51eC1kdC1yZXZpZXcv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9mcw0KPiBsLGlteDgtcGNpZS1w
aHkuZXhhbXBsZS5kdC55YW1sOiBwY2llLXBoeUAzMmYwMDAwMDogcmVzZXRzOiBbWzQyOTQ5Njcy
OTUsDQo+IDI2XV0gaXMgdG9vIHNob3J0DQo+IAlGcm9tIHNjaGVtYToNCj4gL2J1aWxkcy9yb2Jo
ZXJyaW5nL2xpbnV4LWR0LXJldmlldy9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cGh5L2ZzDQo+IGwsaW14OC1wY2llLXBoeS55YW1sDQo+IC9idWlsZHMvcm9iaGVycmluZy9saW51
eC1kdC1yZXZpZXcvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9mcw0KPiBs
LGlteDgtcGNpZS1waHkuZXhhbXBsZS5kdC55YW1sOiBwY2llLXBoeUAzMmYwMDAwMDogcmVzZXQt
bmFtZXM6IFsncGNpZXBoeSddDQo+IGlzIHRvbyBzaG9ydA0KPiAJRnJvbSBzY2hlbWE6DQo+IC9i
dWlsZHMvcm9iaGVycmluZy9saW51eC1kdC1yZXZpZXcvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3BoeS9mcw0KPiBsLGlteDgtcGNpZS1waHkueWFtbA0KPiANCj4gZG9jIHJlZmVy
ZW5jZSBlcnJvcnMgKG1ha2UgcmVmY2hlY2tkb2NzKToNCj4gDQo+IFNlZQ0KPiBodHRwczovL2V1
cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZw
YXRjaHcNCj4gb3JrLm96bGFicy5vcmclMkZwYXRjaCUyRjE2MDE5NjMmYW1wO2RhdGE9MDQlN0Mw
MSU3Q2hvbmd4aW5nLnpodSUNCj4gNDBueHAuY29tJTdDZDFmM2I1NjI1MzNlNGM2NjZlODUwOGRh
MDBhMDEzNzklN0M2ODZlYTFkM2JjMmI0YzYNCj4gZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMSU3
QzYzNzgyMjk4NDc2MjE1NTk3NyU3Q1Vua25vd24lN0NUDQo+IFdGcGJHWnNiM2Q4ZXlKV0lqb2lN
QzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSg0KPiBYVkNJNk1u
MCUzRCU3QzMwMDAmYW1wO3NkYXRhPWJPTk41a0x3b0JQZTNEMEt3VVJSMUZhcE5GY0dJM2pzDQo+
IEs3WExQelplWm5RJTNEJmFtcDtyZXNlcnZlZD0wDQo+IA0KPiBUaGlzIGNoZWNrIGNhbiBmYWls
IGlmIHRoZXJlIGFyZSBhbnkgZGVwZW5kZW5jaWVzLiBUaGUgYmFzZSBmb3IgYSBwYXRjaCBzZXJp
ZXMgaXMNCj4gZ2VuZXJhbGx5IHRoZSBtb3N0IHJlY2VudCByYzEuDQo+IA0KPiBJZiB5b3UgYWxy
ZWFkeSByYW4gJ21ha2UgZHRfYmluZGluZ19jaGVjaycgYW5kIGRpZG4ndCBzZWUgdGhlIGFib3Zl
IGVycm9yKHMpLA0KPiB0aGVuIG1ha2Ugc3VyZSAneWFtbGxpbnQnIGlzIGluc3RhbGxlZCBhbmQg
ZHQtc2NoZW1hIGlzIHVwIHRvDQo+IGRhdGU6DQo+IA0KPiBwaXAzIGluc3RhbGwgZHRzY2hlbWEg
LS11cGdyYWRlDQo+IA0KPiBQbGVhc2UgY2hlY2sgYW5kIHJlLXN1Ym1pdC4NCg0K
