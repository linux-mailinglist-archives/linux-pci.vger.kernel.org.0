Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1A24CD063
	for <lists+linux-pci@lfdr.de>; Fri,  4 Mar 2022 09:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbiCDIpm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Mar 2022 03:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiCDIpl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Mar 2022 03:45:41 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4FF527F3;
        Fri,  4 Mar 2022 00:44:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZGb+Q4cnaR8GlOA/dLgphEBvf+lB26m1u3PafuucB5T1iU8oAOV3VDAakRVcJUKi+5dahQP7MO+NNYJF7Nm5wRwfj1tina2NfpEGH3qfAWhtLe/Imvkm16+ALvTml0MRvDlwrxWRWwqUgosUw0yULAl2wgNwLpvqyEclw4KkEmdbMx0ucWi2wWqLuu2UGzRTPf7ABsSaByAmaWIXDTz3XiB/7Ckc0Evm53AwT3PxtPzRSBpUZJKNRpJuUkH5jouCnXndluUQuyHggM3XIwkMGMHFSRWuUe0yUnqd3+IUu7ckRysE3ozzab5b7fwknWnE8df5ypdRAsOnacL5jPLCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjqUyBhfSN/R4El8whrh+BIWF2MHnRPka+B4thgZ1rA=;
 b=OBjXtxbltRN/Rcbf6hkj236FrgS+tVCejECR/Br+9bryPz9z9jyI6vuBzGbg85z4Jvtna+2J8ugp7ZJAJ5+Gf/l3IheQGYCCYgkt16IHdUgeN+LMJyB8RECnzeELPSo9ln1BxrxPcjw4hD3VBIaK2RzmnZ1u7tNSmQx7z5BWyUMmv2vafnVP9rFqVlz0P+d9zLPGPd/wZWk0Q5gjhHWm4W+xmdKzF04gba4ABF1x+7LGRPEH/yIsuuTgGIwuXY3SQL3/wbj39sDKqirKGkPdZdkfac2xHph3hpsp/6hHlmZXyoHr/suu57ejz7fM1Qr+7q3s/KzOvdUREd5ra7J/BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjqUyBhfSN/R4El8whrh+BIWF2MHnRPka+B4thgZ1rA=;
 b=nidBedS6GzqQU+TW+kOzKUsJifGHWrTiXBl9TAjXZZM6CoO9P2Q4BIYwZkI6UnFcm8hSvYRcKWgOiUwvhwx/I56jbPDY5mEl6s2wgFYdYkKUkyRKYAdMMSR2i+kFomhU35AZ0dFBLfjtXTUdwvYT6oq0MjSlHZSi+8sd01gewJQ=
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com (2603:10a6:10:2dc::14)
 by AM4PR0401MB2337.eurprd04.prod.outlook.com (2603:10a6:200:4f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Fri, 4 Mar
 2022 08:44:51 +0000
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::dd95:fb05:b7a:7206]) by DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::dd95:fb05:b7a:7206%5]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 08:44:51 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v8 5/8] PCI: imx6: Refine the regulator usage
Thread-Topic: [PATCH v8 5/8] PCI: imx6: Refine the regulator usage
Thread-Index: AQHYKfsvg1HUHyEWlUuoa32+k2SRDqykBDGAgAQzpNCABqvYAIAACaog
Date:   Fri, 4 Mar 2022 08:44:51 +0000
Message-ID: <DU2PR04MB867777FA2A46BAAF937834D98C059@DU2PR04MB8677.eurprd04.prod.outlook.com>
References: <1645760667-10510-1-git-send-email-hongxing.zhu@nxp.com>
 <1645760667-10510-6-git-send-email-hongxing.zhu@nxp.com>
 <20220225094301.GA2171975@francesco-nb.int.toradex.com>
 <AS8PR04MB8676418087498F9CAF9849FD8C019@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20220304074530.GA1164950@francesco-nb.int.toradex.com>
In-Reply-To: <20220304074530.GA1164950@francesco-nb.int.toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d2d4d20-4cb2-42b2-f602-08d9fdbb3f77
x-ms-traffictypediagnostic: AM4PR0401MB2337:EE_
x-microsoft-antispam-prvs: <AM4PR0401MB23377363F8574E6939C53F648C059@AM4PR0401MB2337.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fYxD7oLntEKHIz76Rc0RpQj6IbrEnQy0J/U3khoJfDU7iDrdhb3FufkLD6s8CqcW7tAqxiFGkeGMFlMMuc88G9qUihLjBzNUILLv/CFXZV0jsYjBN0CVKKkBT2ywIaWm1RFF5KOlHV00uy7bTjFSsVPW1v+4huPabkTH/x4agZEVIm7xWXF1+ZvIEZipnmGz9pZNSFxvhP846Pw97N4W7nUUAKU4ZO+blTRVPjoo+OguwrJSCy+Yokq+CJGKbXhzlneB+2oXKOgSJKyt7mScvrrGVu5Fq1kgrBh8HuCnyzD6Fby1tApKYzm59iO4KUoTuPq6HKPAxWLJVjCYpmHRUPFxTu/oSHtUSKJzkK74PNQeQeiBmxE191e1iB3FXQSwo8Lf/DowNEGQEZ5IXB6duZZuH+z8XKJ4UF64QTFqaMNbJg7AGiMUmcSQqkPKGENAWaEF/URy1XuuEDVg49I62ySXf942ds1WoEvWcLvngvjGsJ+JqrX2ChbrNGJExBdWRL+MHGB8uTST4XwFH6SLKL2WlUq7O0HKePTMHCw2tvsfJTKsCdhnTNtKV4vmm8ouUNFMYcKpHUcMmh6EeyaA1YSP+KHiF1ohWWoCl3TlWR1kuYP+MGDqUmYXn89kATv1nPcvRJc9pGFPseScH/rN8QlkE84xjjCA+uQzWijf3ffXcMcdtHQYUyVPq+JlwyVdHIrr4DlA8S4M0hE0O//JBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8677.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(186003)(83380400001)(7416002)(2906002)(33656002)(44832011)(38100700002)(508600001)(8936002)(5660300002)(9686003)(53546011)(6506007)(7696005)(52536014)(8676002)(316002)(76116006)(54906003)(66446008)(66476007)(66556008)(66946007)(86362001)(64756008)(55016003)(38070700005)(4326008)(71200400001)(6916009)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?YjlOY29nc1A0YVI1YisxV0VBd1B6YmE5OTM3ZTR4VVYvRXJrU3BLcVU4WENv?=
 =?gb2312?B?SGdEcTBMTmt1Q1crU08xNkE2YkwrY1FjSmp2bnZwWnBXa1pZWHRnQ1RSOWNH?=
 =?gb2312?B?OXFaVzZNbzkzM0Z2WVlnNm8wTVdVQVRsSlUrRnF5bnIwQ2JxN2llWEJBbmt4?=
 =?gb2312?B?bVgvUmFENXdJZDdzV1hvMy9kaVo0eFBCcEtSNkVzbGRXWEE2WmxvQjVKOWdq?=
 =?gb2312?B?cDhhL2lBMFd3dUxjMHljL1ZCTVJZalE3VHpoTmxyamNVVDVaeTZqaGFNT1lz?=
 =?gb2312?B?Tnlza3hXVFUwZ0UxYmJYM2ZlL1FsMEVXUUg1TTlXR290UmpqOUp2WGlsQkJY?=
 =?gb2312?B?Wlgrc1lKZmhWbWhwdEg4VzRxOXc3djVEeFhMNGRQZEdxY0UxYkxsVFRycTNK?=
 =?gb2312?B?RTJJdTlDeGVrZkY0cVhtQnhiSm5MMyt5Z2ZxK1Y2bmhJL3RlcjFTckUrelU2?=
 =?gb2312?B?L1V3VUxPSUtEMkpsa0NNMVVoL0lXU0pXcDRxUWNpV2tlR2I4ZXQ2clVFM3N5?=
 =?gb2312?B?b2taa2hRQ213WHoxb1UwaDZQZEFzYk03K3JlQUdrSUhwclYyaWVSYUViUFFP?=
 =?gb2312?B?VkFIcGxZcXdiMDJ4Z3lBSGxzb29LcjNZS3A1K3dta1VZb3lORnFLalM5ZEQ1?=
 =?gb2312?B?RCtVWkVZaWI2SUJiQ010eEJhaExDM1poeGFPbzVZT3MrTFRCamRjSVNRSGN0?=
 =?gb2312?B?cnJpR2FzVDVtQWdYenVnM2tXc1hUQzJrWjdNSURIeGpkQ2RXOUxMNnhwQ3pj?=
 =?gb2312?B?ZzZVUFJCcUFNK1Fuc0RVYmxOWXJtT2lLWjJ4Mkd4dUdpSkt3UGZEMm9Vd3ZH?=
 =?gb2312?B?eEcyNkhRcnlreFFrY1dpc2tQVnhVaThSSzlqd2o3RnhrQVNKbTNUR2QyYXFX?=
 =?gb2312?B?aGVLc3ozNFl3QjNoWG5GZ2hqeEUwRWp6N2FjRjBIYUdKaEtybUhUVWk4Q1Qz?=
 =?gb2312?B?bjFIdVJRUEYrc2dPUW9FTWI3NldDTnV4bG9SMkNGR3U1R2NpOFBLR0h3QjVo?=
 =?gb2312?B?czlOd25EenNVcm1YSVk3Yk00STNoZDBYaTdsdXBhN1oxWTdnRXIybG1XUUhV?=
 =?gb2312?B?YUY0NGxBZjc0dzRoS05jZGpqOVFPbm84czdYZ0Z4K3hVM0ZvQ0VDcHlobmVo?=
 =?gb2312?B?dGhwYUhPREd3RUl2amhDNUIvY2wzMy83TmxhSTVTNW42Z1NIS2NqemZmdEND?=
 =?gb2312?B?KzNzWkVWZ1hVQlhFa1YvdnNnOHB2M0ZLWFVnOWN2aGNCVElmcUVmUW9FT3I5?=
 =?gb2312?B?UWU1TFY5S2xDdFVNdVRMaEdpTWxVN1lVUG0zL0htcWRGaUNqSk5zdFh1SytC?=
 =?gb2312?B?REpUbUM0OWQzMHI1L2g4VVNHSGJHMmhUb21TWE1tNzhYcUpTdkdpOFpaeFYv?=
 =?gb2312?B?dll3SUM3TTFQSlFoL3ppVDAyb2M0SHlYLzlGN3Yza3YvYk9id0R4NlA0ZDhk?=
 =?gb2312?B?NEsyNE4yb0xXSElySHVTYmJzbE41QXJYSVR1Z3QwQlNFRWJsRHJBMmJJTnZE?=
 =?gb2312?B?bHpWTkxPQ0FMdEhLZWR5QVg0allBTXdYTVM2Wk1vcEM4VGphbktreFpPejlG?=
 =?gb2312?B?TGpUcjVVSVZTRGE1a2JHWXNCeXBVMmZlbmZUb0JYczNXcjducXRRQ3JDOFE4?=
 =?gb2312?B?OUx6S3NtNmVkdG9oTEtXYVhzbnRoSEtaR0E2QVZ4Rnpqajg5c0pHZU9Rbm4z?=
 =?gb2312?B?aUdkdjA2d1hTQms0WlZndXFQcTlySW9Jek81NHpWbjUrZ1I0aVVDK3l2VkF3?=
 =?gb2312?B?UVh0L3duK3lRTkZIZVIyRWcvbEY5V0JqSVNUdTFzN1IvVkpRQ05hUmJ4OTgw?=
 =?gb2312?B?bmVvVExLSDlNdmlhM1lBMFI2Q2Z4RFV5c3hvaklpT1A4bUdjREo3d3NDN0po?=
 =?gb2312?B?aWRiOTB1MVh0aXhhL2Q1dDRwdHQ5d2pua0tjK1dDTW9idDNKSS9lNGNkd1c0?=
 =?gb2312?B?dHhjSENlc0FJMUgwbUpXcmxFbWQ1RmVQa2hnZ0tPMEV4NHcxTTh6cVJlTDFJ?=
 =?gb2312?B?SEViZ3A4WnM0L2w0eWhHdDgyNlNvNUpjeEFvTFpoeTMvQVM5VnlmQk5YeWYw?=
 =?gb2312?B?eGNibHcyenFjMllnd1JmZFNzd0x0a3Z3cTdmV21ET3hQT3J3Qlg0SVJ6T2ZF?=
 =?gb2312?B?N0JLNWhmSVJWcDhodFMxLzF0ajZzTGJCRUFRaU1zOUJoeWhZb1FlUjdOd2pV?=
 =?gb2312?B?TFE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8677.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2d4d20-4cb2-42b2-f602-08d9fdbb3f77
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 08:44:51.4549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n2BMPmy2JGqTgUEn5CnDquyTAy5HPEw1aGCnsZZgZ54iANfuBmFJ2V2VzTBJdlXbof51Cf0krc3Kq9kRexHMzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2337
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuY2VzY28gRG9sY2luaSA8
ZnJhbmNlc2NvLmRvbGNpbmlAdG9yYWRleC5jb20+DQo+IFNlbnQ6IDIwMjLE6jPUwjTI1SAxNTo0
Ng0KPiBUbzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IEZyYW5j
ZXNjbyBEb2xjaW5pIDxmcmFuY2VzY28uZG9sY2luaUB0b3JhZGV4LmNvbT47DQo+IGwuc3RhY2hA
cGVuZ3V0cm9uaXguZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207IGJyb29uaWVAa2VybmVsLm9yZzsN
Cj4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgamluZ29vaGFuMUBnbWFpbC5jb207IGZlc3Rl
dmFtQGdtYWlsLmNvbTsNCj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjggNS84XSBQQ0k6IGlteDY6IFJlZmluZSB0aGUg
cmVndWxhdG9yIHVzYWdlDQo+IA0KPiBPbiBNb24sIEZlYiAyOCwgMjAyMiBhdCAwMzo0MzowM0FN
ICswMDAwLCBIb25neGluZyBaaHUgd3JvdGU6DQo+ID4gPiAyLiBXZSBhcmUgcGxheWluZyBhcm91
bmQgd2l0aCB2cGNpZSBkdXJpbmcgcmVndWxhdG9yIGR1cmluZw0KPiA+ID4gc3VzcGVuZC9yZXN1
bWUsIHdoeT8gV2UgY3VycmVudGx5IGhhdmUgaXNzdWUgd2l0aCBzdXNwZW5kL3Jlc3VtZQ0KPiA+
ID4gd2hlbiBhIFBDSWUgc3dpdGNoIGlzIHRoZXJlLCB3aXRoIHRoZSBmaW5hbCBlZmZlY3Qgb2Yg
UENJZSBiZWluZyBub3QNCj4gPiA+IHVzYWJsZSBhZnRlcndhcmQuIEkgZmVhciBsaWtlIHRoaXMg
aXMgcmVsYXRlZCB0byBvdXIgaXNzdWUuDQo+ID4gPg0KPiA+IFRvIG15IHVuZGVyc3RhbmRzLCB0
aGUgVlBDSUUgaXMgdGhlIGFic3RyYWN0IG9mIHRoZSBESUVTQUJMRSMgc2lnbmFsLg0KPiA+IFJl
ZmVyIHRvIHRoZSBDaGFwdGVyIDMuMS4xMi4zIFdfRElTQUJMRSMgU2lnbmFsIG9mIFBDSSBFeHBy
ZXNzIE0uMiBTUEVDLg0KPiA+IFRoZXNlIHNpZ25hbHMgYXJlIHVzZWQgdG8gZGlzYWJsZSB0aGUg
QWRhcHRlcidzIHJhZGlvIG9wZXJhdGlvbiB0bw0KPiA+IG1lZXQgcHVibGljIFNhZmV0eSByZWd1
bGF0aW9ucyBvciB3aGVuIG90aGVyd2lzZSBkZXNpcmVkLg0KPiA+IEl0J3MgcmVhc29uYWJsZSB0
byBhc3NlcnQvZGUtYXNzZXJ0IFdfRElTQUJMRSMgc2lnbmFsIGR1cmluZw0KPiBzdXNwZW5kL3Jl
c3VtZS4NCj4gPg0KPiA+ID4gV2hhdCBhYm91dCB2cGNpZSBlbmFibGUgaW4gcHJvYmUsIGFuZCB2
cGNpZSBkaXNhYmxlIGluIHNodXRkb3duIGFuZA0KPiA+ID4gdGhhdCdzIGFsbD8NCj4gPiBUaGUg
V19ESVNBQkxFIyBTaWduYWwgaXMgdXNlZCB0byBjb250cm9sIHRoZSByYWRpb3Mgb24gdGhlIEFk
YXB0ZXJzLg0KPiA+IEkgdGhpbmsgeW91IGNhbiBkbyB0aGF0LCBpZiB0aGUgcmFkaW9zIGFyZSBh
bHdheXMgb24gaW4geW91ciBzeXN0ZW0uDQo+IA0KPiBBY2NvcmRpbmcgdG8gdGhlIGJpbmRpbmcg
ZG9jdW1lbnRhdGlvbiAoaW14NnEtcGNpZS55YW1sKQ0KPiANCj4gICB2cGNpZS1zdXBwbHk6DQo+
ICAgICBkZXNjcmlwdGlvbjogU2hvdWxkIHNwZWNpZnkgdGhlIHJlZ3VsYXRvciBpbiBjaGFyZ2Ug
b2YgUENJZSBwb3J0IHBvd2VyLg0KPiAgICAgICBUaGUgcmVndWxhdG9yIHdpbGwgYmUgZW5hYmxl
ZCB3aGVuIGluaXRpYWxpemluZyB0aGUgUENJZSBob3N0IGFuZA0KPiAgICAgICBkaXNhYmxlZCBl
aXRoZXIgYXMgcGFydCBvZiB0aGUgaW5pdCBwcm9jZXNzIG9yIHdoZW4gc2h1dHRpbmcgZG93bg0K
PiAgICAgICB0aGUgaG9zdCAob3B0aW9uYWwgcmVxdWlyZWQpLg0KPiANCj4gVGhpcyBpcyBob3cg
aXQncyBkb2N1bWVudGVkIHRvIGJlIHVzZWQsIGlmIHRoaXMgaXMgdXNlZCBhY2NvcmRpbmcgdG8g
dGhlDQo+IGRvY3VtZW50YXRpb24gKGFuZCB0aGlzIGlzIGhhcHBlbmluZykgd2hhdCB5b3UgYXJl
IGFscmVhZHkgZG9pbmcgKG5vdA0KPiBjaGFuZ2VkIGluIHRoaXMgcGF0Y2gsIHlvdSBhcmUgcmln
aHQpIGlzIG5vdCBjb3JyZWN0Lg0KPiANCj4gQWJ1c2luZyB0aGlzIGZvciB0aGUgV19ESVNBQkxF
IyBkaXNhYmxlIGlzIG5ldyB0byBtZSBhbmQgZG9lcyBub3QgbG9vayBsZWdpdC4NClRoZSB2cGNp
ZS1zdXBwbHkgaXMgb25lIGdwaW8gcmVndWxhdG9yIGFjdHVhbGx5LCB1c2VkIHRvIGNvbnRyb2wg
cmVtb3RlIEVuZHBvaW50DQogZGV2aWNlLCB0aHJvdWdoIHRoZSBESVNBQkxFIyBzaWduYWwgKGRl
ZmluZWQgaW4gTWluaSBDRU0vTS4yIFNQRUMpIG9mIHRoZSBwb3J0Lg0KDQpCZXN0IFJlZ2FyZHMN
ClJpY2hhcmQgWmh1DQoNCj4gDQo+IEZyYW5jZXNjbw0K
