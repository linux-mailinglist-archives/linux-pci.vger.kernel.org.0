Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398F25981B5
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 12:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238963AbiHRKyE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 06:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241609AbiHRKyD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 06:54:03 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70075.outbound.protection.outlook.com [40.107.7.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759B96CD18;
        Thu, 18 Aug 2022 03:54:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msHxz4YMCZzWQcJU+TMrmW54fJ2YBMl+wArUgElSTRyH7/vbNo80JhSxvM/ZzN/HbBqE8S+7QTzThCJtsg2pybQXoahNouTGNt594F5oQ8yMWsSItkxAYPP8HRQTQEDdF88WrCRarVvyl5YF1rOk4/kJb+udpdbZGUj7X1UdbepyKINn9dFKkEPv6bBYkfszVwm45+2i2mEYgKMDrmy6Z9/F8R4UlQBQLNlavAriLYGpk3Tkf1ls9IqB7Tqf9MpAhQOmbiKpkt4wmsEdNT38OLbqmK23AfuHgRnYJqFSKP1mZe1AYL0MOkFIsYUPFIzwn7jagEmCuUv9hHuy6EKE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkGOff9s2lFErjnHtMzZ3c6B+y8DDs7/CVo9vhoU2bk=;
 b=NfI+ls9O2qKve+9NVoDYIXed3SYGR0ONmEy62FLuGXHtoDb+69DqpK6+YI8YvxNNKkUXnNXZmipXaK6Bbp6+2geIEfThyFNXux/wX5XO/B7wu8+zPb94nfIADAz/DcXNBOGhfDT2BaF+HiQIokPR7fABU7SlFFphPRc8301W5kJ8mCECTt/rIIzS4rbIF7zPMzJ3T0prPWQC8qFrBBqzNOnwyIjqeLu6QIQjJd0IQrSo/LGrp2U5zwywIZPbV00gg13YoaT7haWQ1jAi5joMZK97G5frpCyvi4a0IZdN5E6Adrz1mkG9zNQRVIDjyc+cHsVwGmyCtCwQBUd/cjqPiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkGOff9s2lFErjnHtMzZ3c6B+y8DDs7/CVo9vhoU2bk=;
 b=bkt3xkxQVV13bjA2EOchCk/Dzdsa9uA/1WZi/sAVAkcuF7NOAaliIm6Hr/4l32sbfVEBdnQuF/ILEanEPMnwEnXNQ/uHnCQSV1oca7+yqpukdVY5mlAeyhaUYbwYLiTPk0Y9tOj5WhyimZaFGGLMulHTQuuGCkbiCW4q6FFZS3w=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB8PR04MB5658.eurprd04.prod.outlook.com (2603:10a6:10:b2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 18 Aug
 2022 10:53:55 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b478:43c4:f1df:d1ff]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b478:43c4:f1df:d1ff%5]) with mapi id 15.20.5546.016; Thu, 18 Aug 2022
 10:53:55 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Marek Vasut <marex@denx.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>
CC:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v3 0/6] Add the iMX8MP PCIe support
Thread-Topic: [PATCH v3 0/6] Add the iMX8MP PCIe support
Thread-Index: AQHYstLfaP14T4wF40K69XTShRcol620Yd0AgAAZ+HA=
Date:   Thu, 18 Aug 2022 10:53:55 +0000
Message-ID: <AS8PR04MB8676D575ED7FD81B0451BD028C6D9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1660806153-29001-1-git-send-email-hongxing.zhu@nxp.com>
 <2afdb802-9a86-8313-ebfa-9f2fee7e0023@denx.de>
In-Reply-To: <2afdb802-9a86-8313-ebfa-9f2fee7e0023@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a9f6805-da05-4ae6-9f2e-08da8107f231
x-ms-traffictypediagnostic: DB8PR04MB5658:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q2AVNCv4Y/5fXbj2led0iOGxhoomXhOX/C6xt3X/lDEIrglip57BoKDl3o1CCpMdmSTNTi+ysuT1iOwPxWCF8ejnLY0N+Vbbcdy50TpFecE3RbuA0fNI1Rp2wTFa924jMF4uyphxQBWJtqJqMUB6ijq26VXUrZ4835kLXprBvdNbyNTfJupskK3KmT6CmDTPyXTx7Cvq7RaKJbj0V1yrBmMyguvlAwHaJz3FxlxSB2QHqQu9sMr1fD+saXJJrcrHLlVwv4qWz0uloaZc4jJh9eOeDzusSuTDZ6a+7r+RsjU+0sakr5UDzAgPeSC/VLxL6OkrfGgUFYTYX0zZLCzNlxWB8xDq6pTVHAtkAtIj6uevQNvlfqs7Z68yNjHT3jl0ASoV+KPDNb+egNBbNDoW2bp9kY28RYan9LhtDBND/NQbpoIUioEIqYV5PCLeakcltg6c+pXyjDiAWxjHtsYuiu9Ap7zOh7uv5cwk7qWw7TXo7NVEqjDOq4x89+fDb2aVBhLU9E0Clfx9A3GG3NYbfnN/9OVETrvm+utgdlxU7qmFo3UjO/u9du4lxPst6Bw9H7javebywXMccCeZblrsILpbSWyri/5ulK+JrxNKVPPxeHrqMLMXAjG05QZdqzy5XM8iXsRuwItCkqpNGfzerdgbEaFc2vs3JC2/bXUkUSkKFWvul6maVOBTHDmkN8CB0OcvrrLjGhFBonk6LAvHMFc2XA7M3yTqN1tUCQCquB/t3fuSKBRzRoA7KNzVZXhgqaqx4mEpC1tTrtSp/NEbtkP6EQgE+cjTCNd2sKRfT0w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(9686003)(33656002)(186003)(26005)(122000001)(53546011)(86362001)(6506007)(38100700002)(38070700005)(7416002)(4326008)(41300700001)(7696005)(83380400001)(478600001)(54906003)(110136005)(71200400001)(66946007)(76116006)(66446008)(316002)(5660300002)(8936002)(44832011)(64756008)(52536014)(66476007)(66556008)(55016003)(2906002)(8676002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3phTkdEUzlxYkl4UVFDMHZwa2lsV3E1U2p6SnorTmpwL0MyOTU2aUFhbW5m?=
 =?utf-8?B?T3RHenprVmNuWEQzZXk3MzZ5OGZCWnB1Wk80c0k0MnRMTk5jQUNNUnM0YWFH?=
 =?utf-8?B?bnFHZ3gzSjlUWHdFV1N3dmtMakJqMjcxcGxoeXlNbzRrYnZiSktIbVEzREt4?=
 =?utf-8?B?ZWF4TjdKN1VBbGtOYjBKVjRDWjJqbVl5SW9MRUdnK0loNDQ2OVFyUUIyZ1Ni?=
 =?utf-8?B?L2VNSVZPM09zNThQK096ZFlsdEw4eGZNYjlzbjdXQzhyRlNYdXVQaUhYM1F4?=
 =?utf-8?B?am1XblJndnB6eXlEcWJIYzNNUDVlVXZ3a2xFM3JCaDUyNERvTk1KYVZSOHpM?=
 =?utf-8?B?WmRvbXN4b2ZSWE51VGRPSG9YbEFDTnQ1cGNOcTlTV01FRXhWZ2dEM3hsa05q?=
 =?utf-8?B?LzJoUG1UeUZOdHhiVE1lUUk5b2ExMm5LVUV5ZkRGQjNBek5Zc1diWmFLMDJr?=
 =?utf-8?B?cFNxTE5UTVJwTzlDOWZDbm1KR3loZTlNMElDc0Z1TzRQcEtWalBWb1RZRVVi?=
 =?utf-8?B?WXpWNWFmSDZjSXEyemgvLzQ4NVY3Nmt4WGF1cE5KMDNhOE1Ec05xeEFQbS9v?=
 =?utf-8?B?Z0Fia2xmeFd3d0MrRkw0SldTbXFTNE9OOHhQZmJCRkhYVi9EcGxyTDVPazQ3?=
 =?utf-8?B?WFZERE8vOHlCT0pvcVNxNUJYbFdVNDU2OWRJcXZXNFhib2FBTXREK2MwZ0RZ?=
 =?utf-8?B?NHZraTkra3ZQNTh5R29hK2NrWlRPOEJKQVNacXFpbWRZWlFMQThtZHNEUWhO?=
 =?utf-8?B?ZFFLdnBRZjJidUEyZTRaSHFhLzBCaGc2Zk9CbEhHVDY5M2J6dFNxZGxYdTFC?=
 =?utf-8?B?N2Z6Y1BxMnU2RWxoMWJxTUlIeUxiZTBQYU9xcllLT280TFZsM2k2S3lZYmdQ?=
 =?utf-8?B?RVh2MHZpcWYxVTlQYUhncmYyWkFWdy8wNjM5U3U5WWxLNVFJU0FHWDVGdWFU?=
 =?utf-8?B?ZVdvbXd6Yjd0Zm9taUF4UklxVGFyNW5tNW9YNnlqQ3ZVMis3UGJRTGY3b08z?=
 =?utf-8?B?YnBwT2VPZTlnbHZzN3Y5TzZZQk1tRld2ZlZJTW95U3pZVlNxUVVYU3VHUlZt?=
 =?utf-8?B?VTIrZHY1TEltTEg2Rml3ZnJaZDVZNHUzTVpFaklRZXNEOC9GVjFscUlPSkRH?=
 =?utf-8?B?TXZuYXhWS0VLN3BVMld2ditpUWNvemQxM3dPZU9RaEVGUkZycnh0aWhMcUMw?=
 =?utf-8?B?WnpTSVBpOUVUODRyUnVjUTZod1hPVGpCUVNoTGFQQmZOb3cvc0o4YlhSbVJL?=
 =?utf-8?B?RkFTbmw3NUlzM2ZxNzk4b2c2TlI3c3U4aHFyU3VIV3laUWhQZENRVjA1d01W?=
 =?utf-8?B?RC9yMkNmUE9zNU80TDRpVThMZWNNLzMwRGJMYVFYTW0wN3hvOHQ5L0NCcElG?=
 =?utf-8?B?cy9PWHhUelhKNkF6MGdrNXBFVUJxTTQxb3dBM0xMOTdheXVFVWdqbnpWMHZ2?=
 =?utf-8?B?cXNKaER4cUt1QitTNlYvNjZNdnI5Tm5hU3NrZHlpMTdRajlETEw5YTBxODBI?=
 =?utf-8?B?cDBIK3F1TnBpYS9sTXdYdkQ0TmtIa2F6cnpENEt0allxL2sweFlOZG1qVkpQ?=
 =?utf-8?B?OXliczhpSFIzNjRrTXQwMklvUTEyUldld21NemdhS2k3UjlUVnlJeFc1Myt6?=
 =?utf-8?B?cVpiQllJMW9MMjFhN2JkUUF0VDlhVlN3U3hhbzl3ZXFLMEp3K0g2Y1lmVjVq?=
 =?utf-8?B?MjZ1UnZjcXU3ZFdyVGxxb2plcUExa3FoZDQwN213Qlp5QlFQdEZoOEdPVzR1?=
 =?utf-8?B?dURmWFBFbTVFWnhYK0QrU0FUVHJyalJORmpOMUJseWhWNXkwT2JrUTZkWVJi?=
 =?utf-8?B?UEdUci95N3VkRkV1TUxFaEVsK2dKd05sUjZwdlB6K3RMMFBLaWNzZzRZUEdI?=
 =?utf-8?B?VjkvNml1WFk1elZWVldYTmR1c2hzdUpDd0tZa0ZnRVdhTUl4ck9IaUgxM0dF?=
 =?utf-8?B?QzRKa2JxbHZuNVJScWc4RDRLMW5BVFZSSjNkdlBzTmNWYXdxNHZvdk9uUllz?=
 =?utf-8?B?dG5lTjRmZS91NCs2aFZtZFR0eUhJMERneU5RTHdENjZ0ZVFsQU9yVnlERHRQ?=
 =?utf-8?B?RFJiWUdSTnVWYTNlSDJFSVRXZzBMMWQyRzRtOGZYamR5RmlDRUttN28yZUEz?=
 =?utf-8?Q?ukTxOLbPf2ipYBGNnX8YnYTyi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9f6805-da05-4ae6-9f2e-08da8107f231
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 10:53:55.3658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2mQiwwMYGIuBp3WxqR9QT83IFSioVpU7ocuXOyowuAAuG/GKON+YssJeIe5Mk7zJ/1jwnChFrQYn6UzsUtwLtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5658
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJlayBWYXN1dCA8bWFyZXhA
ZGVueC5kZT4NCj4gU2VudDogMjAyMuW5tDjmnIgxOOaXpSAxNzoyMA0KPiBUbzogSG9uZ3hpbmcg
Wmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IHAuemFiZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGwu
c3RhY2hAcGVuZ3V0cm9uaXguZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207IGxvcmVuem8ucGllcmFs
aXNpQGFybS5jb207DQo+IHJvYmhAa2VybmVsLm9yZzsgc2hhd25ndW9Aa2VybmVsLm9yZzsgdmtv
dWxAa2VybmVsLm9yZzsNCj4gYWxleGFuZGVyLnN0ZWluQGV3LnRxLWdyb3VwLmNvbQ0KPiBDYzog
bGludXgtcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
Ow0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5n
dXRyb25peC5kZTsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2MyAwLzZdIEFkZCB0aGUgaU1YOE1QIFBDSWUgc3VwcG9ydA0KPiANCj4g
T24gOC8xOC8yMiAwOTowMiwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gQmFzZWQgb24gdGhlIDYu
MC1yYzEgb2YgdGhlIHBjaS9uZXh0IGJyYW5jaC4NCj4gPiBUaGlzIHNlcmllcyBhZGRzIHRoZSBp
Lk1YOE1QIFBDSWUgc3VwcG9ydCBhbmQgaGFkIGJlZW4gdGVzdGVkIG9uDQo+ID4gaS5NWDhNUCBF
VksgYm9hcmQgd2hlbiBvbmUgUENJZSBOVk1FIGRldmljZSBpcyB1c2VkLg0KPiA+DQo+ID4gLSBp
Lk1YOE1QIFBDSWUgaGFzIHJldmVyc2VkIGluaXRpYWwgUEVSU1QgYml0IHZhbHVlIHJlZmVyIHRv
DQo+IGkuTVg4TVEvaS5NWDhNTS4NCj4gPiAgICBBZGQgdGhlIFBIWSBQRVJTVCBleHBsaWNpdGx5
IGZvciBpLk1YOE1QIFBDSWUgUEhZLg0KPiA+IC0gQWRkIHRoZSBpLk1YOE1QIFBDSWUgUEhZIHN1
cHBvcnQgaW4gdGhlIGkuTVg4TSBQQ0llIFBIWSBkcml2ZXIuDQo+ID4gICAgQW5kIHNoYXJlIGFz
IG11Y2ggYXMgcG9zc2libGUgY29kZXMgd2l0aCBpLk1YOE1NIFBDSWUgUEhZLg0KPiA+IC0gQWRk
IHRoZSBpLk1YOE1QIFBDSWUgc3VwcG9ydCBpbiBiaW5kaW5nIGRvY3VtZW50LCBEVFMgZmlsZXMs
IGFuZCBQQ0llDQo+ID4gICAgZHJpdmVyLg0KPiA+DQo+ID4gTWFpbiBjaGFuZ2VzIHYyLS0+djM6
DQo+ID4gLSBGaXggdGhlIHNjaGVtYSBjaGVja2luZyBlcnJvciBpbiB0aGUgUEhZIGR0LWJpbmRp
bmcgcGF0Y2guDQo+ID4gLSBJbnNwaXJlZCBieSBMdWNhcywgdGhlIFBMTCBjb25maWd1cmF0aW9u
cyBtaWdodCBub3QgcmVxdWlyZWQgd2hlbg0KPiA+ICAgIGV4dGVybmFsIE9TQyBpcyB1c2VkIGFz
IFBDSWUgcmVmZXJyZW5jZSBjbG9jay4gSXQncyB0cnVlLiBSZW1vdmUgYWxsDQo+ID4gICAgdGhl
IEhTSU8gUExMIGJpdCBtYW5pcHVsYXRpb25zLCBhbmQgUENJZSB3b3JrcyBmaW5lIG9uIGkuTVg4
TVAgRVZLDQo+IGJvYXJkDQo+ID4gICAgd2l0aCBvbmUgTlZNRSBkZXZpY2UgaXMgdXNlZC4NCj4g
PiAtIERyb3AgdGhlICM0IHBhdGNoIG9mIHYyLCBzaW5jZSBpdCBoYWQgYmVlbiBhcHBsaWVkIGJ5
IFJvYi4NCj4gPg0KPiA+IE1haW4gY2hhbmdlcyB2MS0tPnYyOg0KPiA+IC0gSXQncyBteSBmYXVs
dCBmb3JnZXQgaW5jbHVkaW5nIFZpbm9kLCByZS1zZW5kIHYyIGFmdGVyIGluY2x1ZGUgVmlub2QN
Cj4gPiAgICBhbmQgbGludXgtcGh5QGxpc3RzLmluZnJhZGVhZC5vcmcuDQo+ID4gLSBMaXN0IHRo
ZSBiYXNlbWVudHMgb2YgdGhpcyBwYXRjaC1zZXQuIFRoZSBicmFuY2gsIGNvZGVzIGNoYW5nZXMg
YW5kIHNvIG9uLg0KPiA+IC0gQ2xlYW4gdXAgc29tZSB1c2VsZXNzIHJlZ2lzdGVyIGFuZCBiaXQg
ZGVmaW5pdGlvbnMgaW4gIzMgcGF0Y2guDQo+ID4NCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcGh5L2ZzbCxpbXg4LXBjaWUtcGh5LnlhbWwgfCAgMTYNCj4gKysrKysrKy0t
DQo+ID4gYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLWV2ay5kdHMgICAgICAg
ICAgICAgICAgIHwgIDUzDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLmR0c2kgICAgICAgICAgICAgICAgICAg
IHwgIDQ2DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiBkcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2ktaW14Ni5jICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTcNCj4gKysr
KysrKysrLQ0KPiA+IGRyaXZlcnMvcGh5L2ZyZWVzY2FsZS9waHktZnNsLWlteDhtLXBjaWUuYyAg
ICAgICAgICAgICAgICAgICB8IDE1MA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tDQo+IC0tLS0tLS0tLS0tLS0tLS0tLQ0K
PiA+IGRyaXZlcnMvcmVzZXQvcmVzZXQtaW14Ny5jICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgMSArDQo+ID4gNiBmaWxlcyBjaGFuZ2VkLCAyMzIgaW5zZXJ0aW9ucygrKSwg
NTEgZGVsZXRpb25zKC0pDQo+IA0KPiBGb3IgdGhlIGVudGlyZSBzZXJpZXM6DQo+IA0KPiBUZXN0
ZWQtYnk6IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPg0KPiANCkhpIE1hcmVrOg0KVGhhbmtz
IGZvciB5b3VyIGtpbmRseSBoZWxwIHRvIHRlc3QgaXQuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFy
ZCBaaHUNCg0KPiBUaGFua3MgIQ0K
