Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D27D5443AF
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 08:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238175AbiFIGS5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jun 2022 02:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237150AbiFIGSz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 02:18:55 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F0E2149FD;
        Wed,  8 Jun 2022 23:18:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/9icS6zJq++Wagk3jnlPdWqlvHlzoYMciAvTpWhLCBUwn9c9gqWnRrzNAkhbYSu4tVDKbkRzBDkVQdBGA15v71XwbhRSRj2yGSkZXZEQyhMoAQw0IoRsZBhYl9hl2KBQHNv7Wf5VoCGeT8U+2jB03/HMFvRdMzBT7UxrW3V8tuYehPgRIhc2PUrktTyge70gIhiuNupH568keiV7aOqrn5l3yOLAgVnkKxJTx3h/FJ6fZtzDMZPh6YQDlHyHE6jbFqT/ersGZ66j3k31a/Mv6FXerK2YU6pZJFMfeybcMYL2pzSG/sJROM3hAGQvtpXu4woK/iaaUzCDyP0aWyDtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLXVFAUNG35w/Ei7Du+mbqTs5+CrIFKndY1xQxL59uc=;
 b=IGL6IXIq54qJw+Mr7b3BakSjqFxLct9MyRMRNCscb+B722pOSza/wW0znVjmUg7Ggcww7zSWHe6bUhPbn+ulDFrv4xkIrfM90yssxlHMpLPa0CiZ1orj42Br9zNs1yLWgzKxQ9xgkSdZJ3HE3J2Mbtk7LBhSVeFOFibsLrYQ44YubiQITY3z/ResQeO9BZ3HmP1/ptFMuEzBrb7vhDbNKeNGhlNLHGHaE02Qipx911fG52hw7xg/k7f/qhkM2KjWcNrvZ0TRNa+nsHy8zokpABvg3XSphm3eyNsbSbbXgebSyynQfR++bI8x/Y5RP5zJR7BblLtM0ylHlOE2dICO/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLXVFAUNG35w/Ei7Du+mbqTs5+CrIFKndY1xQxL59uc=;
 b=Mx09yP1j/0+BhR93TnQkDW2ml23eXzPJUb8Z8VVtaTwXwoYHLO+XlbxtDV1bXwjLVJ8Wr2qhn+FC711XTCXJViMxAgMGvvddo2Z9Khw6bga87l8Y+ipicXIWNU6AFxPNJLFrzfQ+U1gR4dacczTwJBbCXAJ5FV7RpDXbIHTlGUI=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA4PR04MB7888.eurprd04.prod.outlook.com (2603:10a6:102:b9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 9 Jun
 2022 06:18:51 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::983c:b5ce:91b1:447e]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::983c:b5ce:91b1:447e%9]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 06:18:51 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v9 8/8] PCI: imx6: Add compliance tests mode support
Thread-Topic: [PATCH v9 8/8] PCI: imx6: Add compliance tests mode support
Thread-Index: AQHYYOziBeacLadrVEqLmP8Kvi21Ra1FVnSAgAE8LlA=
Date:   Thu, 9 Jun 2022 06:18:51 +0000
Message-ID: <AS8PR04MB8676A254DBBF6E06772DB76D8CA79@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1651801629-30223-1-git-send-email-hongxing.zhu@nxp.com>
         <1651801629-30223-9-git-send-email-hongxing.zhu@nxp.com>
 <6550645c8163bad0b36eebdfceeb244f57329e9e.camel@pengutronix.de>
In-Reply-To: <6550645c8163bad0b36eebdfceeb244f57329e9e.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5045fbd-42ce-492d-160d-08da49dfec00
x-ms-traffictypediagnostic: PA4PR04MB7888:EE_
x-microsoft-antispam-prvs: <PA4PR04MB7888F9AF1CF83AA17A4AA1CA8CA79@PA4PR04MB7888.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wX7TV7raPTevTsTrenFdfKgE5HVhaXcp1oYuFwzsaPoBFx+9xKu+3/beLv43naNJaT8g/ibIZ34881Trb0nj+pKBKc7L5Qs1RlNH2dPumlQQnqdMdAORD4hj0rzSUsoOs3i2+RA4x5/eBP5Ba+3LmbRrO0PN3KYnVJiGWM4FmKb10LwIvRWSpDpGPb55UfC3RzRNApg5BQOeOHfAVZLrMydJrNMr9P0BXpsRxIFtSpbsYdhnBjo/apURmQIN/8nG9h0vwMBa0ziUuL1k8DQa9i+ibhedpVgd7Kytjo1c8KRF15NiewZ4YUmlALkD+zBsfFGMoXXS81ZA0sj9SzC6O6NzylwgSc3FhFOd1YlzAyHQuHIl6zRDuWXptiAsD9yPGkQxj/Se2cjsT4tthsarkWmf9NP3bUql+gRef4EuuFQUbaEVIr81suQqFU6H3bfl+1HIQEOQb+4nA9eKoOkaERGqp6RoWXPUFr+vZKYLO9GjFrVxj3Zqjb4Jid4FFWQ7oAhLVKXasV/Mm42j4zy4zbqFM+DcGHdW3Qvl+MeMdhGam8UfHJJzv1w8Zd/RMSbJHzQHVU5mocERnnb9buhNIBkBbis0nOep8SEwuGIlCP/T5vsgVckqtmqglhg9wQigkPgcER4WaxQEto/Q2Q4GEHY1TCkgMSud+Akg5TTQRdRxoej3UPEV8ZkjrXsSQN7J/AKStx91pPZM4h2qY62AfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(33656002)(110136005)(316002)(38100700002)(4326008)(8676002)(122000001)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007)(86362001)(54906003)(71200400001)(44832011)(186003)(83380400001)(53546011)(7696005)(2906002)(6506007)(7416002)(9686003)(26005)(508600001)(52536014)(55016003)(8936002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzVVeUU3NEg4M3IzYkdvSDBCUEcwTFRtSUtwTlBRZERVSHROcXU2ZEVhTU9k?=
 =?utf-8?B?aHNmTW4wT0xOOGZuZnk2OFh4SHAxa3Z6bHU4dUhNaVJEQUNNRXNNZ3VoRlNH?=
 =?utf-8?B?di9OZ050K09KWE44WTE2dVVDWnVkV01ZVVJLaU9xOEFKQ2t6VEc4U002eDZr?=
 =?utf-8?B?MzFDVTB2eFVhMG5EOWxpSEFkcHcxektsOEFxdVI2RFBiYUxTV2RhRmE3TFBy?=
 =?utf-8?B?NXZOcnRiaWgyLzJYMGxVRVhIcThGa21OaVpIRzBwVkpRTXVUbEd5ZVVGZnVt?=
 =?utf-8?B?WWtOeDUwOVdYcEt0M0VocUFidWU2ZFNocnVWRTNwT3hjWVhBdFlSWnpOL3Ez?=
 =?utf-8?B?TWNaQkxLZk9EQTF6em1vclhIcHBPTktBOGNqbGNUa0hXSWR6dldBUklZWHBX?=
 =?utf-8?B?Wll6SFJ6eUJxMHdoQ3RyeGFoMTJWTEVicy94RXcyMmJpdFNGYlNIM2ZTT3JC?=
 =?utf-8?B?YnUxM05TS3Jsc3ZUM2dNTGVrcUdOS3Ewdkh2MlNCQ0N3T0ZaYXFjbE1QQUlL?=
 =?utf-8?B?UjJSRzNOdEFnMEJnL0FYZDF4NHlmUE5CN2MwRFdZRU11QVFYR1QxVmdNM0RV?=
 =?utf-8?B?dFgyMTNZUHZPOU9LL3d5cnNCTHF1L1lFY2xkUXBGa2daZ3NTSFdzdDZDcURj?=
 =?utf-8?B?ZXVFSHA0SHdyQ25QQXo3dUdpM0xLNHQzMDhjUnNYbUlNVDFpTmMxa2pmUk4r?=
 =?utf-8?B?MmxWaFVwQ1FMOUg3MzVRRFNLQVRYSW8vOTlVTTBpYVFxbkNGUmx4c1Robkdn?=
 =?utf-8?B?d1o1b2dzU1R3Um9zYjI0VFhaNXZiQ3JMcmkvNTE0Z2JlVnhhdWVYVHhWTlR6?=
 =?utf-8?B?bDRXV0pYRWY4ZC8vcDBQSnp0RFhQVHE2eFN4V0t6VksveVMzTGdpYTdJQ3hE?=
 =?utf-8?B?ais0ZFpESmpzQ3ZaV3NQYXN6dXVMTWdMSWUwRXNXNFl5YWhuODlQb01KazM0?=
 =?utf-8?B?TzNoNjVTVjhqc3ZJNjhvaXp5L0NsL2N4LzVPaU1HTnQ3TktGRFBYekpnK1BF?=
 =?utf-8?B?dzczZmJQdVJXYlJjTDliVDVDRUtKckJNVU92aGE0ZldjaGU4NVZRWjA5MHR0?=
 =?utf-8?B?OENWVHB4bEtoUmNlNkhzVGpTTnJtQnNrVmhVK3BxQlZGNExNNDg4YmV6NVM0?=
 =?utf-8?B?U2VEUTNhVFdQK3hQYkhMdStkd1BNNDcyZTd4d2h0SnNVelFsKzEyUzA1aGFq?=
 =?utf-8?B?eEdhV1BUMENHeXhRQkNRaGduZXV2RDdKTGVUVm5VOEpSRyt2MzBJSGJoa0xN?=
 =?utf-8?B?bVZqaGtZZUoxQkg0YVhwdFhTclJIRlJENHEzdDJ5L01iOGM5Wm1FVEFiUm5x?=
 =?utf-8?B?c1cySDFKZzIvdzlxc2ZXZ2NqM0k1QmdPR2xNQjh4WXhNcCt4TGJoaUJ2N0Ns?=
 =?utf-8?B?RkJOSHdTK29aMFQ2RThLbngxSjFtUEtHbXMxUUdxZUtSNngyeWVobjZsSlgz?=
 =?utf-8?B?SkpqQlZhWlkyRUowVkZ3ZmNyRUNjaWo2YWtuWFVhMkxXeTZCZW5uQ25QTzZa?=
 =?utf-8?B?WkV4M3p4aDU4c2JCWFo4RU12b004WTRyZi9yaGxCbXNkYThDK0xGK0hocUli?=
 =?utf-8?B?ZlV1Ujk4NU1RbWgvYnNwL3NIZkVXaDJwUk9MMWNuR01haU5BVmFVUlhFMmFu?=
 =?utf-8?B?VCtkWHArUUxPUm5oYjRTbTFWUXhZYVZtSk9vU0R5bEYxQ1BYTkFiaFRuNHVX?=
 =?utf-8?B?NGY0NzRFYlNEZm9nVTdNYXhNcEtMVXNwN2ZINUtHbmdvM3RXM3hYQVh2MW9y?=
 =?utf-8?B?SUJjZXp3ZHlnT2ZPLzA0cXB6NG9FTXlMaElyYnlsaUcvNWdSeDE3cE0zZ3pI?=
 =?utf-8?B?WElGT1RSYkdQdFhOUm8wN1dKK3N5enpBOUFZM0taTUlYNlhxK2lJWmR0RFVI?=
 =?utf-8?B?M0VxczNMZGZFZzZkOFcvUm5OQlU2RTk4dDZoQkhYQmtsSS9Cd3Q5d3ZNMnBU?=
 =?utf-8?B?WUhUYlJnS0J3eTk0ZzBSOHk4NWcvZ1E3MS94enhSbUtzYmpMT3NQT0hEc1Fa?=
 =?utf-8?B?YWVuanA3S1JwVWtBSVdJbUg5cGN4MmM0WU8vbkFTYlE0OFBZUVptY3JTSnFG?=
 =?utf-8?B?bE1vbS9MKytHVitOamZYblp4SC9nNllkYk5NWjR0VCtZWkV1N2lmbWNVM0JI?=
 =?utf-8?B?T3pzeHo2ZERMU3Rucm4vM2RBVkJ0VDgxVmJaOXFjMU9ndWxyL0pnNkZPeUpY?=
 =?utf-8?B?MUdtZHVOS2dBZmY3emRNczdJamZFNFk5OU1OdHpQbHoyU2xReEdGSmhHL3Rr?=
 =?utf-8?B?UU9vTitrYmRaNW5nUGJmRG9XTmF1WDFjc25pM3pLd0dYMzk2UVhUR3VoRXVm?=
 =?utf-8?B?R2J0a0JrOWY4Vjd6c2NwNDV5VGxoMWV2T2JFOXZMQVB1bzNxTTN0dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5045fbd-42ce-492d-160d-08da49dfec00
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 06:18:51.2153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cJKzhviE1B23e/g/uoxT4P9hcssCsvxMvcYzUpQiU3rs8oSYfY+e8mgPNTsGDBTlojfOnw4nanE1NBYNcMZlXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7888
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMuW5tDbmnIg45pelIDE1OjQ5DQo+IFRvOiBI
b25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsN
Cj4gcm9iaCtkdEBrZXJuZWwub3JnOyBicm9vbmllQGtlcm5lbC5vcmc7IGxvcmVuem8ucGllcmFs
aXNpQGFybS5jb207DQo+IGppbmdvb2hhbjFAZ21haWwuY29tOyBmZXN0ZXZhbUBnbWFpbC5jb207
DQo+IGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tDQo+IENjOiBsaW51eC1wY2lAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgt
aW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OSA4Lzhd
IFBDSTogaW14NjogQWRkIGNvbXBsaWFuY2UgdGVzdHMgbW9kZSBzdXBwb3J0DQo+IA0KPiBBbSBG
cmVpdGFnLCBkZW0gMDYuMDUuMjAyMiB1bSAwOTo0NyArMDgwMCBzY2hyaWViIFJpY2hhcmQgWmh1
Og0KPiA+IFJlZmVyIHRvIHRoZSBDaGFwdGVyIDMuMiBTeXN0ZW0gQm9hcmQgU2lnbmFsIFF1YWxp
dHkgb2YgUENJIEV4cHJlc3MNCj4gPiBBcmNoaXRlY3R1cmUgUEhZIFRlc3QgU3BlY2lmaWNhdGlv
biBSZXZpc2lvbiAyLjAuDQo+ID4NCj4gPiBTaWduYWwgcXVhbGl0eSB0ZXN0cyAoZm9yIGV4YW1w
bGU6IGppdHRlciwgZGlmZmVyZW50aWFsIGV5ZSBvcGVuaW5nDQo+ID4gYW5kIHNvIG9uKSBjYW4g
YmUgZXhlY3V0ZWQgd2l0aCBkZXZpY2VzIGluIHRoZSBwb2xsaW5nLmNvbXBsaWFuY2Ugc3RhdGUu
DQo+ID4NCj4gPiBUbyBsZXQgdGhlIGRldmljZSBzdXBwb3J0IHBvbGxpbmcuY29tcGxpYW5jZSBz
dGF0ZSwgdGhlIGNsb2NrcyBhbmQNCj4gPiBwb3dlcnMgc2hvdWxkbid0IGJlIHR1cm5lZCBvZmYg
d2hlbiB0aGUgcHJvYmUgb2YgZGV2aWNlIGRyaXZlciBmYWlscy4NCj4gPg0KPiA+IEJhc2VkIG9u
IENMQiAoQ29tcGxpYW5jZSBMb2FkIEJvYXJkKSBUZXN0IEZpeHR1cmUgYW5kIHNvIG9uIHRlc3QN
Cj4gPiBlcXVpcG1lbnRzLCB0aGUgUEhZIGxpbmsgd291bGQgYmUgZG93biBkdXJpbmcgdGhlIGNv
bXBsaWFuY2UgdGVzdHMuDQo+ID4gUmVmZXIgdG8gdGhpcyBzY2VuYXJpbywgYWRkIHRoZSBpLk1Y
IFBDSWUgY29tcGxpYW5jZSB0ZXN0cyBtb2RlIGVuYWJsZQ0KPiA+IHN1cHBvcnQsIGFuZCBrZWVw
IHRoZSBjbG9ja3MgYW5kIHBvd2VycyBvbiwgYW5kIGZpbmlzaCB0aGUgZHJpdmVyDQo+ID4gcHJv
YmUgd2l0aG91dCBlcnJvciByZXR1cm4uDQo+ID4NCj4gPiBVc2UgdGhlICJwY2lfaW14Ni5jb21w
bGlhbmNlPTEiIGluIGtlcm5lbCBjb21tYW5kIGxpbmUgdG8gZW5hYmxlIHRoZQ0KPiA+IGNvbXBs
aWFuY2UgdGVzdHMgbW9kZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxo
b25neGluZy56aHVAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxl
ci9kd2MvcGNpLWlteDYuYyB8IDM5DQo+ID4gKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5j
DQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gaW5kZXgg
ZjBmZmQ5MDExOTc1Li5mNzhiNTk4MjI2MjYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBAQCAtMTQ2LDYgKzE0NiwxMCBAQCBzdHJ1Y3QgaW14Nl9w
Y2llIHsNCj4gPiAgI2RlZmluZSBQSFlfUlhfT1ZSRF9JTl9MT19SWF9EQVRBX0VOCQlCSVQoNSkN
Cj4gPiAgI2RlZmluZSBQSFlfUlhfT1ZSRF9JTl9MT19SWF9QTExfRU4JCUJJVCgzKQ0KPiA+DQo+
ID4gK3N0YXRpYyBib29sIGlteDZfcGNpZV9jbXBfbW9kZTsNCj4gPiArbW9kdWxlX3BhcmFtX25h
bWVkKGNvbXBsaWFuY2UsIGlteDZfcGNpZV9jbXBfbW9kZSwgYm9vbCwgMDY0NCk7DQo+ID4gK01P
RFVMRV9QQVJNX0RFU0MoY29tcGxpYW5jZSwgImkuTVggUENJZSBjb21wbGlhbmNlIHRlc3QgbW9k
ZQ0KPiA+ICsoMT1jb21wbGlhbmNlIHRlc3QgbW9kZSBlbmFibGVkKSIpOw0KPiA+ICsNCj4gPiAg
c3RhdGljIGludCBwY2llX3BoeV9wb2xsX2FjayhzdHJ1Y3QgaW14Nl9wY2llICppbXg2X3BjaWUs
IGJvb2wNCj4gPiBleHBfdmFsKSAgew0KPiA+ICAJc3RydWN0IGR3X3BjaWUgKnBjaSA9IGlteDZf
cGNpZS0+cGNpOyBAQCAtODI2LDEwICs4MzAsMTIgQEAgc3RhdGljDQo+ID4gaW50IGlteDZfcGNp
ZV9zdGFydF9saW5rKHN0cnVjdCBkd19wY2llICpwY2kpDQo+ID4gIAkgKiBzdGFydGVkIGluIEdl
bjIgbW9kZSwgdGhlcmUgaXMgYSBwb3NzaWJpbGl0eSB0aGUgZGV2aWNlcyBvbiB0aGUNCj4gPiAg
CSAqIGJ1cyB3aWxsIG5vdCBiZSBkZXRlY3RlZCBhdCBhbGwuICBUaGlzIGhhcHBlbnMgd2l0aCBQ
Q0llIHN3aXRjaGVzLg0KPiA+ICAJICovDQo+ID4gLQl0bXAgPSBkd19wY2llX3JlYWRsX2RiaShw
Y2ksIG9mZnNldCArIFBDSV9FWFBfTE5LQ0FQKTsNCj4gPiAtCXRtcCAmPSB+UENJX0VYUF9MTktD
QVBfU0xTOw0KPiA+IC0JdG1wIHw9IFBDSV9FWFBfTE5LQ0FQX1NMU18yXzVHQjsNCj4gPiAtCWR3
X3BjaWVfd3JpdGVsX2RiaShwY2ksIG9mZnNldCArIFBDSV9FWFBfTE5LQ0FQLCB0bXApOw0KPiA+
ICsJaWYgKCFpbXg2X3BjaWVfY21wX21vZGUpIHsNCj4gPiArCQl0bXAgPSBkd19wY2llX3JlYWRs
X2RiaShwY2ksIG9mZnNldCArIFBDSV9FWFBfTE5LQ0FQKTsNCj4gPiArCQl0bXAgJj0gflBDSV9F
WFBfTE5LQ0FQX1NMUzsNCj4gPiArCQl0bXAgfD0gUENJX0VYUF9MTktDQVBfU0xTXzJfNUdCOw0K
PiA+ICsJCWR3X3BjaWVfd3JpdGVsX2RiaShwY2ksIG9mZnNldCArIFBDSV9FWFBfTE5LQ0FQLCB0
bXApOw0KPiA+ICsJfQ0KPiA+DQo+ID4gIAkvKiBTdGFydCBMVFNTTS4gKi8NCj4gPiAgCWlteDZf
cGNpZV9sdHNzbV9lbmFibGUoZGV2KTsNCj4gPiBAQCAtODg3LDE0ICs4OTMsMTYgQEAgc3RhdGlj
IGludCBpbXg2X3BjaWVfc3RhcnRfbGluayhzdHJ1Y3QgZHdfcGNpZQ0KPiAqcGNpKQ0KPiA+ICAJ
ZGV2X2RiZyhkZXYsICJQSFkgREVCVUdfUjA9MHglMDh4IERFQlVHX1IxPTB4JTA4eFxuIiwNCj4g
PiAgCQlkd19wY2llX3JlYWRsX2RiaShwY2ksIFBDSUVfUE9SVF9ERUJVRzApLA0KPiA+ICAJCWR3
X3BjaWVfcmVhZGxfZGJpKHBjaSwgUENJRV9QT1JUX0RFQlVHMSkpOw0KPiA+IC0JaW14Nl9wY2ll
X3Jlc2V0X3BoeShpbXg2X3BjaWUpOw0KPiA+IC0JaW14Nl9wY2llX2Nsa19kaXNhYmxlKGlteDZf
cGNpZSk7DQo+ID4gLQlpZiAoaW14Nl9wY2llLT5waHkgIT0gTlVMTCkgew0KPiA+IC0JCXBoeV9w
b3dlcl9vZmYoaW14Nl9wY2llLT5waHkpOw0KPiA+IC0JCXBoeV9leGl0KGlteDZfcGNpZS0+cGh5
KTsNCj4gPiArCWlmICghaW14Nl9wY2llX2NtcF9tb2RlKSB7DQo+ID4gKwkJaW14Nl9wY2llX3Jl
c2V0X3BoeShpbXg2X3BjaWUpOw0KPiA+ICsJCWlteDZfcGNpZV9jbGtfZGlzYWJsZShpbXg2X3Bj
aWUpOw0KPiA+ICsJCWlmIChpbXg2X3BjaWUtPnBoeSAhPSBOVUxMKSB7DQo+ID4gKwkJCXBoeV9w
b3dlcl9vZmYoaW14Nl9wY2llLT5waHkpOw0KPiA+ICsJCQlwaHlfZXhpdChpbXg2X3BjaWUtPnBo
eSk7DQo+ID4gKwkJfQ0KPiA+ICsJCWlmIChpbXg2X3BjaWUtPnZwY2llKQ0KPiA+ICsJCQlyZWd1
bGF0b3JfZGlzYWJsZShpbXg2X3BjaWUtPnZwY2llKTsNCj4gPiAgCX0NCj4gPiAtCWlmIChpbXg2
X3BjaWUtPnZwY2llKQ0KPiA+IC0JCXJlZ3VsYXRvcl9kaXNhYmxlKGlteDZfcGNpZS0+dnBjaWUp
Ow0KPiA+ICAJcmV0dXJuIHJldDsNCj4gPiAgfQ0KPiA+DQo+ID4gQEAgLTEyODksOCArMTI5Nywx
NSBAQCBzdGF0aWMgaW50IGlteDZfcGNpZV9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KPiA+ICAJCXJldHVybiByZXQ7DQo+ID4NCj4gPiAgCXJldCA9IGR3X3BjaWVfaG9z
dF9pbml0KCZwY2ktPnBwKTsNCj4gPiAtCWlmIChyZXQgPCAwKQ0KPiA+ICsJaWYgKHJldCA8IDAp
IHsNCj4gPiArCQlpZiAoaW14Nl9wY2llX2NtcF9tb2RlKSB7DQo+ID4gKwkJCWRldl9pbmZvKGRl
diwgImRyaXZlciBsb2FkZWQgd2l0aCBjb21wbGlhbmNlIHRlc3QgbW9kZQ0KPiBlbmFibGVkXG4i
KTsNCj4gPiArCQkJcmV0ID0gMDsNCj4gPiArCQl9IGVsc2Ugew0KPiA+ICsJCQlkZXZfZXJyKGRl
diwgInVuYWJsZSB0byBhZGQgUENJZSBwb3J0XG4iKTsNCj4gPiArCQl9DQo+ID4gIAkJcmV0dXJu
IHJldDsNCj4gPiArCX0NCj4gDQo+IElmIHlvdSBkcm9wIHRoZSBlcnJvciByZXR1cm4gZnJvbSBp
bXg2X3BjaWVfc3RhcnRfbGluaywgbGlrZSBJIHN1Z2dlc3RlZCBpbiBwYXRjaA0KPiA2LzgsIHlv
dSBkb24ndCBuZWVkIHRoaXMgYmxvY2sgYXMgZHdfcGNpZV9ob3N0X2luaXQgd2lsbCBzdWNjZWVk
IGV2ZW4gaWYgdGhlDQo+IGxpbmsgaXMgZG93biBvciBpbiBjb21wbGlhbmNlIHRlc3QgbW9kZS4N
ClRoYW5rcyBmb3IgeW91ciByZXZpZXcgY29tbWVudHMuDQpBcyB3aGF0IEkgc2FpZCBpbiB0aGUg
Ni84IHBhdGNoLCB0aGVyZSB3b3VsZCBiZSBhIGxvbmcgbGF0ZW5jeSBpbiB0aGUgcHJvYmUgYW5k
DQogZXZlcnkgcmVzdW1lIG9wZXJhdGlvbiBpZiB0aGUgcHJvYmUgaXMgZmluaXNoZWQgc3VjY2Vz
c2Z1bGx5IHdoZW4gbGluayBpcyBkb3duLg0KV2l0aCB0aGlzIGV4dHJlbWUgbG9uZyBsYXRlbmN5
LCBJJ20gYWZyYWlkIHRoYXQgdXNlciB3b3VsZCBoYXZlIGEgYmFkDQpleHBlcmllbmNlIGFuZCB3
b3VsZG4ndCBhY2NlcHQgc3VjaCBraW5kIG9mIGxvbmcgbGF0ZW5jeSBpbiBldmVyeQ0Kc3VzcGVu
ZC9yZXN1bWUgb3BlcmF0aW9ucy4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+IA0K
PiBSZWdhcmRzLA0KPiBMdWNhcw0KPiANCj4gPg0KPiA+ICAJaWYgKHBjaV9tc2lfZW5hYmxlZCgp
KSB7DQo+ID4gIAkJdTggb2Zmc2V0ID0gZHdfcGNpZV9maW5kX2NhcGFiaWxpdHkocGNpLCBQQ0lf
Q0FQX0lEX01TSSk7DQo+IA0KDQo=
