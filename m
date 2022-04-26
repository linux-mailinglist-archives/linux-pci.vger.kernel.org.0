Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4681B50EF34
	for <lists+linux-pci@lfdr.de>; Tue, 26 Apr 2022 05:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243032AbiDZDau (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Apr 2022 23:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243029AbiDZDas (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Apr 2022 23:30:48 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C431F24083;
        Mon, 25 Apr 2022 20:27:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqCTcYZDjQ3Z/3OsIlWt0Zlbfe0Vuhvmx9I3al6ydRJmFzwQt7L72bx6iWa0k3Fp6UcZLD+qrYNLIezBpDRClIHBtr0wmWkyvppftNd+8VAJKnW6Ys0YwJF9TJyUbJif2mmS7MC4JgMRDEfdkwp9eOPMLsFLUois6H8ig/xH2ETUW0DsTF7WeXr4GqjIQuLQpi352zGad9bSbOUPw3m1GhXlpcs2kcYTVgZdCKzRl3CSR3tVounuvYtTh2s6hauq+/Sn+dnpi6tMkS+t7Ajqrn+7qVVz+/KqobG5iL9v/AjLwj11WwNgq4MrdDfS4C+ql2BeVLkbfx1cAJZfKm2UDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJ3hGEvRUIGKlRaYyhCHs0DCAJG38Mm4XB9ckyZILeg=;
 b=fXsaqPPyD/gL7opeU3+U4/NPMlCpDD6q+Rnl2fpSyKnkZJcysvCm1bHuN1ZPnN8IoCnsjx3paPBbWkfAf+xWY6oOeiDmxvG8LHMkaHybHxv3hCx/XLt9m1fJzisQZp4F3C6HNd7zer04qnlzT8ZTxde84A65C9ECpukfQfT0bxBs2LIUdRqJQPvy2MG3/+oo7irLCIKXRQeXJFqSYp+q96sgwl9WptMILMRF3Bb4JJxyEqo2JemfiUmvunSNDKb1V5E3qP+FG3v5vgGlA3tNGnZMIb1Tm1KEMRQMhybwdyAN0NFfsuDRE185CU0sDjXKo72F9aJvCxH2dFBUtTPmQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJ3hGEvRUIGKlRaYyhCHs0DCAJG38Mm4XB9ckyZILeg=;
 b=eswGZ59KtJBAjE7BOA+/xuFH+PSbsHQuXJgLPlOcmHFLRjCvtV2q4irrOLp4kY1IOYujxBza00SNC0gJe379ORyhi9c1wN2sgkdictRwvxxzI+oe7KeJ+IjDOOw2A5Zl3Rpc2wWWHtxO6xbWaeJ6VSmr5/TN1iguvHeDIY00raU=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB6PR04MB2982.eurprd04.prod.outlook.com (2603:10a6:6:a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.21; Tue, 26 Apr 2022 03:27:39 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::ecea:cb09:5ff2:1800]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::ecea:cb09:5ff2:1800%5]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 03:27:39 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
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
Subject: RE: [PATCH v2 1/7] reset: imx7: Add the iMX8MP PCIe PHY PERST support
Thread-Topic: [PATCH v2 1/7] reset: imx7: Add the iMX8MP PCIe PHY PERST
 support
Thread-Index: AQHYMgQKvQY38d7zYkCsN9Iw8VH+Qqzfqj4AgBDL2gCAEVgXQA==
Date:   Tue, 26 Apr 2022 03:27:39 +0000
Message-ID: <AS8PR04MB8676E0AEEB88F79BDFF276438CFB9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1646644054-24421-1-git-send-email-hongxing.zhu@nxp.com>
         <1646644054-24421-2-git-send-email-hongxing.zhu@nxp.com>
 <c967e6bdb586c273c187e4892b03aa82064af4ab.camel@pengutronix.de>
 <AS8PR04MB867672DB83F2B6EEA206E45C8CEE9@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB867672DB83F2B6EEA206E45C8CEE9@AS8PR04MB8676.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2334fb27-ca2b-4212-99a5-08da2734b748
x-ms-traffictypediagnostic: DB6PR04MB2982:EE_
x-microsoft-antispam-prvs: <DB6PR04MB29821CE5F550A50CC5EC08768CFB9@DB6PR04MB2982.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 10l2Yi0Gy2SQvmJzszfaFjZMGD5JYSxFr31ZU0bKEGm6P0ZfJSo1DRKZM1OEdVhWd7AmhQFVEYiQNFPMHGXqvq2T9Mb31JAqUzTFbHJLEKYq22SESYzEGTyUV7GDi/HfGKkWHNzltQvm+RxEln9uQL+M7ukxpAuU7pXm5BIr6Jn9xM0aVuZ0+xjNfnIdyR51JM4Hem7c5PuRBtBmR6DLo/0XN1oVAw0U0qeflD2LDcF2yGNlemEnOqUwPei5eyE15KQy575P4dvCuuAB0ZlHaOtoGQPhcNlTV8LpDc5prKEbZyG9hlr3XBe36JU3TiTzGjv2uwzo5W5wcg5LyP5F5fH7ydg/wCRZioTuWT6UzkMR9W9R95GrVTnBTDjmuPcc05xI47eVGtcEmGaIZ8djbf9CT4AqGhb4yfIk1iDaaPUaclg9lXcvGisJuIo8DXQWJa6tdkHeMS4j+3/QIZ2DBM9mpv4PvoqCtvYfKFMJXB/cSsrzbU/u1jQpQ9l3YrX3Y9l4dXnBcH238vIzI4xhVDsVa+c3F0J1i11Z0GJvfFrE0Ro1oe+C2sZ6OaylCt/z9tunZxMie6Gtj3yLXrezWNlvOJ2B4In5JZ3hL1bZffn/eddipR8X1tww+HJQawk3jjT/IFy8EiOnli5E+IkBTxpleFgbUkBmaUm1sUzMF7DExqFVcEOFvmiBuEyAb+M0nmW746iSdjBazkydenvZV5iHlFm08wRs9fYjs/pzPcE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(508600001)(8936002)(55016003)(316002)(71200400001)(4326008)(76116006)(19627235002)(54906003)(66946007)(83380400001)(66556008)(64756008)(66446008)(110136005)(8676002)(66476007)(5660300002)(52536014)(33656002)(7416002)(6506007)(53546011)(86362001)(122000001)(38100700002)(38070700005)(26005)(44832011)(9686003)(7696005)(2906002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkpReDZBSHVrZGVKOTliYVdtcVFib2c5bGhVci9ubUcxZmZaWm5vT0ZpbDJh?=
 =?utf-8?B?T0VaaTh1RVRURzNtR1FTOHdidE5GL1lxaXVWSTRIbnl6bXIwTUlCcUlybGVM?=
 =?utf-8?B?NnlWSkE2dGJjdUtOelVGdHo3a2I2YWI5ZVFSeXlaaEVkRHBkZmpDbEd5YlVq?=
 =?utf-8?B?dWxuQWVmYzVnc3lWUGxERHc0RCtsdDRLQTlqS0xITmppVzZwMUNhajRjdVJt?=
 =?utf-8?B?a2RtcWdoaUFmTkZGYm10Tmp6QjlVSlgvN3VEVFJxTmRMb2VLME85TFhDRjhJ?=
 =?utf-8?B?UTdSSmVkaVE1azJrN3NreUNkNUxabG5jNVZSQThvUm9mT1lQUXZqdXRvc09j?=
 =?utf-8?B?SThSeVBEdCtJZzhxL1ZGdkV5ZGZPMkxSaHVZYnE2bnZrNVorWWgyWmoyYUlB?=
 =?utf-8?B?R0kzejZhckwxaU96ejdldmdHdEEvOGFmZUl5MWVXTE44TENVOVVUMTR2U2ty?=
 =?utf-8?B?TTgwZVY0ZElVeFBteldseGVBL1NGNzlBODJsVmx3WVV0WlR1VFVZODc5eVh6?=
 =?utf-8?B?VnNIMnlReGY5cERmQUNCMGFqY1lIM3FubHl5SnhCSjczL3ZaM3NqQXlzaVFW?=
 =?utf-8?B?VytyeGIzVDByYmhERVR4T0tkZVVEazAzVEFMY0U4SEF5MnE1aFhLYjFXTGVL?=
 =?utf-8?B?c1lKbnlWZWlHUmJ1TFhOQzE3bHdOVzRlRUxpampsNlh1Sk5BbnduSkRPMGdU?=
 =?utf-8?B?NzhhNUdlMkJmVVBNbWM2VG1sdndsMXVFK3czaFFQbmhqRXdaYU9OVDFpRDVl?=
 =?utf-8?B?MXlTK3FJUXJITWVPMSt1QnYyaDdXK3BjWkZmUWZqU2FQOWUraUVvRDRIK1A0?=
 =?utf-8?B?VzYyNklrTEs5YVk1UGFkYVRBMXkxZWpsWGNwT0ZySUhSK2ViSVhjVlovWmsz?=
 =?utf-8?B?Ym5VZjM2ZE5Ld1dCOWJPWS9BUEhIUWlUanJobmNtWmZ6TWErcTQxUlBnWDU0?=
 =?utf-8?B?VURyenNLeXdpbXBWQkJsb0FiUmxjdDB1MVhkRy90MWlncU50NkhSSEdLblps?=
 =?utf-8?B?ZVJvM3h2T0VmT2dSWnk3VXZrQ3hFa05jOEFWc1k0Qk1tUnZnY2tPZzhod2xy?=
 =?utf-8?B?emMvVUxIVDJwMCtYb1plbUVqcjdHcTA1Ylp4ZFpjdjhhUXRWdGFtQVl1ZjIw?=
 =?utf-8?B?S3E1eWV0OUM5bXN1dzh4elJROVRESUQydnhlZ2hPRnRwajRSWFJtMVJ6SnNu?=
 =?utf-8?B?K3liUFVrTDFzUldzd1VzOEdBR0FOWEloV2t6bVZMUWxnWGpsMHpseVNZL0R0?=
 =?utf-8?B?S3hhQ1RVSi90RVk2a0h2UlRFUzZiTE1Vc1hzZHR1WE5ML2JkTldlK21jYWZi?=
 =?utf-8?B?ZlJnLzVYNmx2Sks0MkZ5NDRrTmdod3RWYmFBUDVFcVNMS3ZKWEdzNkh2cGt0?=
 =?utf-8?B?OTI5WmFncjlMam1iR1ljckVPSi9Pa0xGd2c2MDJvSGl1TC8wZUZUbUhTd0J2?=
 =?utf-8?B?MzlaN3BZSEYxM1g5bVpWcUZNdHZzcngrTE4wY0ZEd3laMHMyYWhub00rVHNL?=
 =?utf-8?B?dDRsczMvZzZaTzNoY0x6SERVVDdKQjZPNGFQWWo5Q0pmQkFkSTFibTBIRXpX?=
 =?utf-8?B?MHZjV1lpOXhxakJOcVlweVEzZFY1a0VXRE56eCtpNVk4cWRUNWc2WGhTNDRP?=
 =?utf-8?B?RzE4Vy9rRG5TTFpMWUVtYTIxVW1HSlEzd1A1UDJOTVhMbnpiSEYxVUV5QmZZ?=
 =?utf-8?B?b1lHbGwxNWcvbDMrT1cxeDJYNk9zRmtlbFBaQVVnaG12Z3RlbkZWb2dTNnBw?=
 =?utf-8?B?b1BkaXhiS2ZIaU44YStOQ1p6VTVmK2k0bkM5NlBmNWFGTlp5akxkYzF5K0dX?=
 =?utf-8?B?clNiMzBqcjV6eU5EdGQxd1UvWi8wSHB6SEhyZHNsYlZ4YTE1TGhRa1luSUNp?=
 =?utf-8?B?OGVQV0dVR2NIRjQvNEJnbE1uaVVCb3hqTG4vTllNa2hWM0JtQUdxR3VlT1k0?=
 =?utf-8?B?K0lKd21jQ3dXS2liTThNSzhxdzZCRUpaTHhSSGoxRGl4ZTNwM3RGcDU3aFFy?=
 =?utf-8?B?T3VJQ2VrNkRxRElxNWx1OVJFdHRDTDJ5Q3ZxMlIxN3R6bWd5cm5UNjFKckEw?=
 =?utf-8?B?ZFJYWi9VR3hKOGViK0ZHQW5vN0wrRUhQeWx2bG1VcEltWU53T2NSbkkwRW52?=
 =?utf-8?B?bktsWDhXTS9PSGV4a2FMYjRlYXhibndmajZ3UU5RT2JXU1k2WnQ1bXh6UExP?=
 =?utf-8?B?Slo4anhVTlN4cEgvTjMvWDN3cmVIZGM1Q1VIYi9EV0ZpeVBxcWM5TTFrVkQw?=
 =?utf-8?B?VjVoeFYrc3p4cDlaSUtQVlQ2VTZmRUd6c2pJT253UFhscUNFalk2N1RuQTNs?=
 =?utf-8?B?bUkyV2ZzVGtyb0FMRmxjbmppUnN1SW51Q2hTTUJxZGp5RXlXSjl1dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2334fb27-ca2b-4212-99a5-08da2734b748
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 03:27:39.2805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G35UxYnZvqVe40DPg/KlgoqO1jcQah80CmfPCgVGJCv5DhalWAL33OgJvnOH3Ryob0VGBzzrzYhQVJeZR2XGQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB2982
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUGhpbGlwcDoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIb25n
eGluZyBaaHUNCj4gU2VudDogMjAyMuW5tDTmnIgxNeaXpSAxNTozMw0KPiBUbzogUGhpbGlwcCBa
YWJlbCA8cC56YWJlbEBwZW5ndXRyb25peC5kZT47IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7DQo+
IGJoZWxnYWFzQGdvb2dsZS5jb207IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IHJvYmhAa2Vy
bmVsLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgdmtvdWxAa2VybmVsLm9yZzsgYWxleGFu
ZGVyLnN0ZWluQGV3LnRxLWdyb3VwLmNvbQ0KPiBDYzogbGludXgtcGh5QGxpc3RzLmluZnJhZGVh
ZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1wY2lAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14
DQo+IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2MiAxLzddIHJl
c2V0OiBpbXg3OiBBZGQgdGhlIGlNWDhNUCBQQ0llIFBIWSBQRVJTVA0KPiBzdXBwb3J0DQo+IA0K
PiBIaSBQaGlsaXBwOg0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZy
b206IFBoaWxpcHAgWmFiZWwgPHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+DQo+ID4gU2VudDogMjAy
MuW5tDTmnIg05pelIDE3OjM0DQo+ID4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54
cC5jb20+OyBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOw0KPiA+IGJoZWxnYWFzQGdvb2dsZS5jb207
IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IHJvYmhAa2VybmVsLm9yZzsNCj4gPiBzaGF3bmd1
b0BrZXJuZWwub3JnOyB2a291bEBrZXJuZWwub3JnOyBhbGV4YW5kZXIuc3RlaW5AZXcudHEtZ3Jv
dXAuY29tDQo+ID4gQ2M6IGxpbnV4LXBoeUBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZzsNCj4gPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXgNCj4gPiA8bGludXgt
aW14QG54cC5jb20+DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzddIHJlc2V0OiBpbXg3
OiBBZGQgdGhlIGlNWDhNUCBQQ0llIFBIWSBQRVJTVA0KPiA+IHN1cHBvcnQNCj4gPg0KPiA+IEhp
IFJpY2hhcmQsDQo+ID4NCj4gPiBPbiBNbywgMjAyMi0wMy0wNyBhdCAxNzowNyArMDgwMCwgUmlj
aGFyZCBaaHUgd3JvdGU6DQo+ID4gPiBBZGQgdGhlIGkuTVg4TVAgUENJZSBQSFkgUEVSU1Qgc3Vw
cG9ydC4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcu
emh1QG54cC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+IMKgZHJpdmVycy9yZXNldC9yZXNldC1pbXg3
LmMgfCAxICsNCj4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4gPg0K
PiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVzZXQvcmVzZXQtaW14Ny5jIGIvZHJpdmVycy9y
ZXNldC9yZXNldC1pbXg3LmMNCj4gPiA+IGluZGV4IDE4NWEzMzNkZjY2Yy4uZDI0MDg3MjVlYjJj
IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9yZXNldC9yZXNldC1pbXg3LmMNCj4gPiA+ICsr
KyBiL2RyaXZlcnMvcmVzZXQvcmVzZXQtaW14Ny5jDQo+ID4gPiBAQCAtMzI5LDYgKzMyOSw3IEBA
IHN0YXRpYyBpbnQgaW14OG1wX3Jlc2V0X3NldChzdHJ1Y3QNCj4gPiA+IHJlc2V0X2NvbnRyb2xs
ZXJfZGV2ICpyY2RldiwNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJl
YWs7DQo+ID4gPg0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoGNhc2UgSU1YOE1QX1JFU0VUX1BDSUVf
Q1RSTF9BUFBTX0VOOg0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgY2FzZSBJTVg4TVBfUkVTRVRfUENJ
RVBIWV9QRVJTVDoNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdmFsdWUg
PSBhc3NlcnQgPyAwIDogYml0Ow0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBicmVhazsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqB9DQo+ID4NCj4gPiBUaGlzIGRvZXNuJ3Qg
ZG8gd2hhdCB0aGUgY29tbWl0IGRlc2NyaXB0aW9uIHNheXMuDQo+ID4NCj4gPiBUaGUgUENJRVBI
WV9QRVJTVCBiaXQgaXMgYWxyZWFkeSBzdXBwb3J0ZWQgYnkgdGhlIGRyaXZlciAoYWxiZWl0DQo+
ID4gaW5jb3JyZWN0bHk/KSAtIHRoaXMgcGF0Y2gganVzdCBpbnZlcnRzIHRoZSBiaXQuDQo+ID4N
Cj4gPiBTaW5jZSB0aGlzIGJpdCBpcyBub3QgaW52ZXJ0ZWQgb24gdGhlIG90aGVyIHBsYXRmb3Jt
cywgYW5kwqB0aGUgaS5NWDhNUA0KPiA+IHJlZmVyZW5jZSBtYW51YWwgc2F5cyBub3RoaW5nIGFi
b3V0IHRoaXMsIHBsZWFzZSBleHBsaWNpdGx5IHN0YXRlIHdoeQ0KPiA+IHRoaXMgbmVlZHMgdG8g
YmUgaW52ZXJ0ZWQgYW5kIGNhbGwgaXQgYSBmaXggaW4gdGhlIGNvbW1pdCBkZXNjcmlwdGlvbi4N
Cj4gVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLCBhbmQgc29ycnkgZm9yIHJlcGx5aW5nIGxhdGUu
DQo+IEkgZGlkbid0IGdldCBtb3JlIGRldGFpbHMgYWJvdXQgdGhpcyBiaXQgZGlmZmVyZW5jZSBi
ZXR3ZWVuIGkuTVg4TVAgYW5kDQo+IG90aGVycy4NCj4gTGV0IG1lIGNvbnN1bHQgd2l0aCBkZXNp
Z24gdGVhbSBhZ2FpbiwgYW5kIGJhY2sgdG8geW91IGxhdGVyLg0KDQpJIGdvdCBzb21lIGRldGFp
bHMgb2YgdGhpcyBQRVJTVCBiaXQoQklUMykgb2YgU1JDX1BDSUVQSFlfUkNSLg0KVGhlIGluaXRp
YWxpemVkIGRlZmF1bHQgdmFsdWUgb2YgdGhpcyBiaXQgaXMgMWInMSBvbiBpLk1YNy9pTVg4TU0v
aU1YOE1RLg0KQnV0IHVuZm9ydHVuYXRlbHksIHRoZSBpLk1YOE1QIGhhcyBvbmUgaW52ZXJ0ZWQg
ZGVmYXVsdCB2YWx1ZSAxYicwIG9mIHRoaXMgYml0Lg0KDQpBbmQgdGhpcyBiaXQgc2hvdWxkIGJl
IGtlcHQgMWInMSBhZnRlciBwb3dlciBhbmQgY2xvY2tzIGFyZSBzdGFibGUuDQpTbywgSSBhc3Nl
cnQvZGUtYXNzZXJ0IHRoaXMgYml0IG9uIGkuTVg4TVAgb25seS4NCg0KQmVzdCBSZWdhcmRzDQpS
aWNoYXJkIFpodQ0KDQo+IA0KPiBCZXN0IFJlZ2FyZHMNCj4gUmljaGFyZCBaaHUNCj4gDQo+ID4N
Cj4gPiByZWdhcmRzDQo+ID4gUGhpbGlwcA0K
