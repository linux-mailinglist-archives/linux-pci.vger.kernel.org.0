Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C49481973
	for <lists+linux-pci@lfdr.de>; Thu, 30 Dec 2021 05:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbhL3E65 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Dec 2021 23:58:57 -0500
Received: from mail-vi1eur05on2041.outbound.protection.outlook.com ([40.107.21.41]:24321
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229834AbhL3E64 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Dec 2021 23:58:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSsee+CBUKMzS8AEJ8ZsQOnhp0WanPgmyZsumi1ngDtaa9AfiCorxOdB61SgMozhNrJRFQgUO4hYSaZ/t8Y0B+FwM5r6xs2HUJn5acg4EJHqdexNNOANt4xKePA6ugqH8w7hiM8ioIgP3coOcRvCMTrKk3SQzukmuAJwvWeeEAjGoRORHRggPeQm2i/CYnBGe5zituery36YBr3D860JlPtV0GcXj0CZnTh6ryyFibhBl/sFkIgTcgUBXEMe7UEsUkHQrItLstGqt7R/0hxl8nHWuVm6DMzFCSyJ2zLiDAV3mHNU1kBe8hAVMbRut68Ot/Uu2V7R7AqOn3rF+zijqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWacNiUSub/MKMLLD+HwnFUHeRnGVQg6zlaT80VQnko=;
 b=SuqG6qjVhsU9vVttvK2glvcKrWmT/eIClpg7bpTaPm9FtpFrEhMa1iLe+8TaPuI/Vw5kBYN1QUQ1LrBvLK44cABIQgAHZ6AilY/o807O+JLj6Y5W+oKeQ+kwAnBeVEd9CVIBMduhIA7/XrVUDQhLB8cruirx19qEk9ISlrG+yupHGUeNBk7y8OIF0ALki+zI8rXp1F5fCfMVsVGoAetIrX2akEbsB1TrAScZU+ZSbe4utgeUU2QBNZT7dAf6e0qorenEvDoDM1SWGckZmbTU4atBdQxIpNx1SgX1gNmOml6ZL/FSZwCLS5mr6gmH4S+VQyhIeyknFReb6/+mGXA2PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWacNiUSub/MKMLLD+HwnFUHeRnGVQg6zlaT80VQnko=;
 b=WwpzueIn+pmcA748M5IyxwMT95TIBgnkZ5/IRox/ijLOBDOXZt50/MpHR9EiYIfzE9gnfgY7P98dgptbs9Zx8Q6/RsfoPPIS1yNaNBKBNySQLNuMlnQdrUZNcJ18UZeiCn8iYtIcc3LTUyP8zXipWtRAITjNn4umYRREYZttNOQ=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8931.eurprd04.prod.outlook.com (2603:10a6:20b:42e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Thu, 30 Dec
 2021 04:58:53 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::949e:59fd:6098:6508]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::949e:59fd:6098:6508%4]) with mapi id 15.20.4844.014; Thu, 30 Dec 2021
 04:58:53 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Philip Molloy <philip@linutronix.de>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v7 5/8] phy: freescale: pcie: Initialize the imx8 pcie
 standalone phy driver
Thread-Topic: [PATCH v7 5/8] phy: freescale: pcie: Initialize the imx8 pcie
 standalone phy driver
Thread-Index: AQHX51basRBPa9z4x0Ob3hpqHmdRI6xJk7GAgAD6bJA=
Date:   Thu, 30 Dec 2021 04:58:53 +0000
Message-ID: <AS8PR04MB8676151C053B01293A0C1E938C459@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1638432158-4119-1-git-send-email-hongxing.zhu@nxp.com>
 <1638432158-4119-6-git-send-email-hongxing.zhu@nxp.com>
 <7320d3fb-4338-86b8-5a49-b56f06f1cd11@linutronix.de>
In-Reply-To: <7320d3fb-4338-86b8-5a49-b56f06f1cd11@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ca173a4-a4b8-42d9-3db7-08d9cb511403
x-ms-traffictypediagnostic: AS8PR04MB8931:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AS8PR04MB89316700693BB6C3B1476E478C459@AS8PR04MB8931.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3bDeVDrVFCrPiV7dNFPLXoxb2u2w2ovZZJqIyAJtqeKH0ELtXa9+M45T/qqjIWa92MuPe57ev+/9bSkDYgtQ5t+99gvBpTDWA2u9hqMi3xKJa1fk57hIhG3bZA9fsPECVAZZLS3LAJVhAjw1styZ8F0QOVZ7UgA6kL1RLCU7R6m9jH23ilPQbiHTw2QY7Ng1vDg8SjY/FJXZ8SUnTTlSPd/8pueqMtf1Ds3ehefi/Ut9RCJ4+B/WVhmjFlTRRcsCaxApSl5fL6SbJZe+Uzs/lld4b4SGc6JA9mZ+zksjPRdfXjlSuFeRnUNy76RBidt4HDXGO9Ja8MB7TjmYMCcLuiRAklvvsUqtIANGe/k22hzjViMj2JZdc7+phIoEwNNIyyNgNZ0Gch1W3X40H5W18qK7yuI+OwtuwpaxUcb1E3kl4DNN439iKIzJFbf3eMmsDny/kdWg2L8Gz5N+36YDyRP7g5j2aGKDRTsk/x17CLesdahlSVxrG4pbHZ18JtDGCMSHf4LO5uERrx9NzT2lxImBiNlTHXlFGIAHowpKBltoo1EXYtmc2CYrDHaIVr4ou1r2McOoDVIKM5ixPrS3OcRR9Ipw0MP1i3SKCwRFXHI16bSQFECFBBQ7zrM8vrynRqM16Mb4BJq/pg/5Je/0NxlM4a24JEwZFAuVWKSuzeUYbgjzt5+ltC0gDddpaBequq7vjpR8xqjbkHvsoOSVRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(122000001)(7416002)(33656002)(26005)(38100700002)(38070700005)(5660300002)(316002)(2906002)(44832011)(83380400001)(52536014)(7696005)(8676002)(53546011)(6506007)(55016003)(66446008)(9686003)(8936002)(54906003)(4326008)(86362001)(66556008)(64756008)(66476007)(6916009)(76116006)(508600001)(66946007)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjB2czI1dVo0QjE0S2t4aVhBSmErSW51anNpUVhNY3RQQW15UFlZanVvVDJQ?=
 =?utf-8?B?QjVEYTU0NlkxTUhHb3VXbHozbG41MURSSjFCMXB5ZVA1N0I4TnlkenBPaWpL?=
 =?utf-8?B?SFpiREcyNkVPZnZpbnpsUXd5TmJuUUFVdDFqQ1ZYYk05alhjeGwvekRQc1NS?=
 =?utf-8?B?S1hIc0tMOGI2dkpUNFk5Y1dVMWVqU3VwUnRuMnQyNmQrS2kxdC9jb1FsZzhj?=
 =?utf-8?B?S210TGZ4azE0YUVpZzhHRlViQlJmczNWZTZablp4c0U1MytxZ0FYU3Zobjhr?=
 =?utf-8?B?Mi9rNzhWb1pZT2hCNElTbk9tNFBHazFxYkdVT3pzV0JnQWNTN1E4SEdNOVYx?=
 =?utf-8?B?Q3pkWjkwVWpXRUtST09FMHpGeHgxUzZmK2l3NTYyeExmdjhhOEVEaVp4dVMx?=
 =?utf-8?B?MWErdnlEZU16VDkvaGJDMDZzN0RTT3l2bXNqeTQrNWpTNlpzRVRmdnU3L08w?=
 =?utf-8?B?VHNhQkpMRlhUTEdBM0RXM3BNT0dGNUQ2UE5CcGJENm4yRUVEVlVwVFJIM09J?=
 =?utf-8?B?dDhjRWY4TVhGS0JwY3NQbVIrc3ZQNy9yczI3bWc2NmxBejUwYkF3eFM2WFF5?=
 =?utf-8?B?ak0rRVdmeDdmZDdSZ2ZaY0J6QU5xU1k5c0VEYmZ1OXhNTHJ5QktBR0RCNU55?=
 =?utf-8?B?QWRtODU2TFRQc01FMFRETWRLVEsxakx0bGFRODFjci9URldTY2hJdDMvbk1l?=
 =?utf-8?B?bUJRMnd0SDNIa2NweTM0bG9MQnN4RC8ySWxMUVRSbFdEM25Zb29qVFpNN09F?=
 =?utf-8?B?bE42dnEwWUdERU1sQ1FKQkVkeDJ5WTBwNlZTa2VvL2VPeFQ3dHhYUCtmbHNo?=
 =?utf-8?B?VzlRcUc4WDBWUEVjMmVMVTBrQjlVQThmeERxdEluOVpHQk1NNm16VHBCUWZ0?=
 =?utf-8?B?cmYxb0FGSUdBVnNnOVRkMllEa0tNMWdEQURrcVRlekw2WXpsY1FWdXZFRDZu?=
 =?utf-8?B?YUoyaDB3UUNXNG1VREhoY2EzT2pIOVpnYWd3OHBCRk1sZ01vMTA0NnBBYmVN?=
 =?utf-8?B?SVQxam1XT0pmaFhMTWZiWjAzN0RHUlhJYm5mTXNPN2MwR0RDaFkyN0VhVWsr?=
 =?utf-8?B?OEJhMWxBWndRMFhvQWsrSnc2R1NqRnVuWVZNVi9YWEtzMlRIWi9SdCtIY2RF?=
 =?utf-8?B?NTN2Yk5RcjdxYW1ENGRzUmd1U1hjRk9KNjFSK3YyU2ZueW16ZnJaM2VhdGF5?=
 =?utf-8?B?WXVCZTJPRGU0c2dpd1F2RXd1QUM1amxkdURMZWU5ZUtzRndna1RFN2FGVkg3?=
 =?utf-8?B?SVY3UFNPeXg0ZmFCYkExZG1TNVNDdUtaT015RXZuaVdmcS9JcTlmd2Z4Vmd0?=
 =?utf-8?B?MVU1LzhSS01HeDZBTmtZQWhOWi9aTHdxZzBzYXV4Sm4vYWg0a3dyQzg2L0k0?=
 =?utf-8?B?UUZzSEVCVk15NThGZU44ZzlWNVk2VUE1MllWS3NVNHVLaWRONnpHNTF1Z0p3?=
 =?utf-8?B?S1pyMldSYm1JbjBpcG4yTTk3VWJ6WWJoVWhvMm82ZFdVMEFlc3pYU2RTa3Ny?=
 =?utf-8?B?QzR6TThRV1BFOGJpOEVCbTM1Rk9odXh0SEhuT2RGWmZJQUJ0aWV5bWVTVmFu?=
 =?utf-8?B?MGI4NHJJLzQ5RDI4TCs5T09vZ0FKQnRHVG1mUUdlOHZLT0NPaTVteFVHM25z?=
 =?utf-8?B?S0pUbG5NS0xOcGZSNWdadDdnYytFc1pYNklQTTNERUR1VlRwT2txWU13UXRU?=
 =?utf-8?B?VVV0Y3JyUnZxSzFkYnpFSGtVMDNEY0o0UDNsZEd2Z1pNL0JrVElNSFVlOGVR?=
 =?utf-8?B?SU53YkRYZVRUQlJqc0hQUlFqQTM2UVV3VkEySXFZTlNhVC9ST3FUMUFlMWJV?=
 =?utf-8?B?ZCtUMkxXZk0wUjRCL21NU3dIQkNXQTVhMHFJSmdIN0JCeW82ejF1QUlTZWRJ?=
 =?utf-8?B?bDNuVncybTJXTkVvK1dkQk9kQ1IwNWtsQmZEWWdZTVpocG52dlI2Y29FSmEv?=
 =?utf-8?B?dHI4VGJvR2pGMnpmU250YXdEa3FleVZ3Vm9xWjVLaVVQazdORnZiaHU4SkpH?=
 =?utf-8?B?WG9ueUI3UnFkeDBOUWtiRUo0WFlnUUZ0d21GTVVkSnB1OGNINHhkSy9wUEdC?=
 =?utf-8?B?cjJxNW1yZlhURjZLalJPOUV0MnNiU2c1eE8rR0hFWi8wVGVvSlVKZHM5YXlJ?=
 =?utf-8?B?RDdPTm94MVgyRXVUS0xpUHpLUXV6dUx0ck05ai81VlB5YjRJUXBMemZsUnc2?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca173a4-a4b8-42d9-3db7-08d9cb511403
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2021 04:58:53.6619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DeAH/Do3JSmBxvSdo6nBKxa4Qxi8JVoMED15xzSem7mrEIunxql4D1u93WhOEriqT/TeWTOAjTcnt+OVt5HSdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8931
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQaGlsaXAgTW9sbG95IDxwaGls
aXBAbGludXRyb25peC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciAyOSwgMjAyMSA4
OjQwIFBNDQo+IFRvOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzog
bC5zdGFjaEBwZW5ndXRyb25peC5kZTsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsNCj4gbG9yZW56by5w
aWVyYWxpc2lAYXJtLmNvbTsgdGhhcnZleUBnYXRld29ya3MuY29tOyBNYXJjZWwgWmlzd2lsZXIN
Cj4gPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT47IGtpc2hvbkB0aS5jb207IHZrb3VsQGtl
cm5lbC5vcmc7DQo+IHJvYmhAa2VybmVsLm9yZzsgZ2FsYWtAa2VybmVsLmNyYXNoaW5nLm9yZzsg
c2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gbGludXgtcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14DQo+IDxsaW51
eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyA1LzhdIHBoeTogZnJlZXNj
YWxlOiBwY2llOiBJbml0aWFsaXplIHRoZSBpbXg4IHBjaWUNCj4gc3RhbmRhbG9uZSBwaHkgZHJp
dmVyDQo+IA0KPiBIaSBSaWNoYXJkLA0KPiANCj4gSSd2ZSBydW4gaW50byBhbiBpc3N1ZSB0aGF0
IGFwcGVhcnMgdG8gaW5kaWNhdGUgYSBmdW5jdGlvbmFsIGRpZmZlcmVuY2UNCj4gYmV0d2VlbiB0
aGUgZXhpc3RpbmcgaW50ZWdyYXRlZCBwY2ktaW14Ni5jIGltcGxlbWVudGF0aW9uIGFuZCB0aGlz
IG5ldw0KPiBpbXBsZW1lbnRhdGlvbiB3aXRoIHRoZSBzZXBhcmF0ZSBwaHkgZHJpdmVyLg0KPiAN
Cj4gSSdtIHdvcmtpbmcgd2l0aCBhIFNPTSBhbmQgYmFzZWJvYXJkIGZyb20gUGh5dGVjIHRoYXQg
aXMgYmFzZWQgb24gdGhlDQo+IElNWDhNTS4gVGhlIGJvYXJkIGRvZXMgbm90IGhhdmUgYW4gZXh0
ZXJuYWwgUENJZSBjbG9jayBhbmQgaGFzIGENCj4gZXRoZXJuZXQgY29udHJvbGxlciBoYW5naW5n
IG9mZiB0aGUgUENJZSBidXMuDQo+IA0KPiBXaGVuIGJvb3RpbmcgZnJvbSBhIDUuNCBOWFAtYmFz
ZWQga2VybmVsIGZyb20gUGh5dGVjIHRoZSBldGhlcm5ldA0KPiBjb250cm9sbGVyIGlzIHByb2Jl
ZCBhbmQgZnVuY3Rpb25zIGFzIGV4cGVjdGVkLg0KPiANCj4gQSBjby13b3JrZXIgYmFja3BvcnRl
ZCBhIHNsaWdodGx5IGVhcmxpZXIgdmVyc2lvbiBvZiB0aGlzIHBhdGNoc2V0IHRvDQo+IDUuMTAu
WzFdIFdpdGggb3VyIGtlcm5lbCBib3RoIHRoZSBjb250cm9sbGVyIGRyaXZlciBhbmQgbmV3IFBI
WSBkcml2ZXIgYXJlDQo+IHByb2JlZCwgYnV0IGEgdGltZW91dCBvY2N1cnMgaW4gZHdfcGNpZV93
YWl0X2Zvcl9saW5rKCkgd2hpY2ggaW5kaWNhdGVzDQo+IHRoYXQgdGhlICJQaHkgbGluayBuZXZl
ciBjYW1lIHVwIi4NCj4gDQo+IEFmdGVyIHJlcHJvZHVjaW5nIHRoaXMgaXNzdWUgSSBjb25maWd1
cmVkIHBjaWVfcGh5IHdpdGgNCj4gSU1YOF9QQ0lFX1JFRkNMS19QQURfT1VUUFVULiBXaXRoIHRo
YXQgY29uZmlndXJlZCwgcGh5IHJlZ2lzdGVyDQo+IENNTl9SRUcwNjIvMHgxODggbWF0Y2hlcyB0
aGUgNS40IE5YUC9QaHl0ZWMga2VybmVsLiBJIHRoZW4NCj4gY29tcGFyZWQgdGhlIGNvbnRyb2xs
ZXIgYW5kIFBIWSByZWdpc3RlcnMgYmV0d2VlbiB0aGUgdHdvIGtlcm5lbHMgYW5kDQo+IG5vdGlj
ZWQgdGhhdCBDTU5fUkVHMDYzLzB4MThjIGlzIHNldCB0byBBVVhfSU4vMHgwIGluIHRoZSA1LjQN
Cj4gTlhQL1BoeXRlYyBrZXJuZWwsIGJ1dCB0aGUgbmV3IFBIWSBkcml2ZXIgd3JpdGVzDQo+IElf
UExMX1JFRkNMS19GUk9NX1NZU1BMTC8weGMwIHRvIHRoYXQgcmVnaXN0ZXIuDQo+IA0KPiBJZiBJ
IG1vZGlmeSB0aGUgcGh5IGRyaXZlciB0byBub3Qgd3JpdGUgSV9QTExfUkVGQ0xLX0ZST01fU1lT
UExMLzB4YzANCj4gdGhlbiB0aGUgc3lzdGVtIGJlaGF2ZXMgYXMgZXhwZWN0ZWQuDQpbUmljaGFy
ZCBaaHVdIA0KSGkgUGhpbGlwOg0KVGhlIGFkZHJlc3MgMHgwMThDIGlzIGEgcmVnaXN0ZXIgdG8g
Y29udHJvbCB0aGUgb3V0cHV0IG1vZGUgb2YgUmVmY2xrIElPLg0KV2hlbiBpbnRlcm5hbCBzeXNw
bGwgaXMgdXNlZCBhcyBQSFkgUkVGIGNsb2NrLg0KUmVnYXJkaW5nIG15IHVuZGVyc3RhbmQsIHRo
aXMgcmVnaXN0ZXIgc2hvdWxkIHNlbGVjdCB0aGUgc3lzcGxsLCBhbmQgcm91dGUNCml0IG91dCBv
ZiBTT0MgZnJvbSBDTEsgTi9QIHBhZHMuDQpUaGVuIHRoZSByZW1vdGUgRVAgZGV2aWNlIGNhbiB1
c2UgdGhlIGNsb2NrIGZyb20gQ0xLIE4vUCBwYWRzLg0KDQpJZiB0aGUgYml0Ny02IGlzIHNldCB0
byAyYicwMCwgdGhlcmUgd291bGRuJ3QgY2xvY2sgb3V0cHV0IGZyb20gQ0xLIE4vUCBwYWRzLg0K
V2hhdCdzIHRoZSBoYXJkd2FyZSBkZXNpZ24gb2YgdGhlIENMSyBOL1AgcGFkcyBpbiB5b3VyIHBy
b2plY3Q/DQpDYW4geW91IG1vbml0b3IgdGhlIHNpdHVhdGlvbiBvZiB0aGUgQ0xLIE4vUCBpZiBp
dCBpcyBwb3NzaWJsZT8NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+IA0KPiBCZXN0
LA0KPiBQaGlsaXANCj4gDQo+IFsxXTogSSBwbGFuIG9uIHJlYmFzaW5nIG91ciBicmFuY2ggd2l0
aCB0aGUgbGF0ZXN0IHBhdGNoZXMgdGhhdCBoYXZlIGJlZW4NCj4gYXBwbGllZCB1cHN0cmVhbS4g
Tm90ZSB0aGF0IEkgZGlkIG5vdCBzZWUgYW55IGRpZmZlcmVuY2UgaW4gdGhlIGZvbGxvd2luZw0K
PiBjb2RlIHdpdGggd2hhdCB3ZSBoYXZlIGFwcGxpZWQuDQo+IA0KPiBPbiAxMi8yLzIxIDA5OjAy
LCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiArI2RlZmluZSBJTVg4TU1fUENJRV9QSFlfQ01OX1JF
RzA2MQkweDE4NA0KPiA+ICsjZGVmaW5lICBBTkFfUExMX0NMS19PVVRfVE9fRVhUX0lPX0VOCUJJ
VCgwKQ0KPiA+ICsjZGVmaW5lIElNWDhNTV9QQ0lFX1BIWV9DTU5fUkVHMDYyCTB4MTg4DQo+ID4g
KyNkZWZpbmUgIEFOQV9QTExfQ0xLX09VVF9UT19FWFRfSU9fU0VMCUJJVCgzKQ0KPiA+ICsjZGVm
aW5lIElNWDhNTV9QQ0lFX1BIWV9DTU5fUkVHMDYzCTB4MThDDQo+ID4gKyNkZWZpbmUgIEFVWF9Q
TExfUkVGQ0xLX1NFTF9TWVNfUExMCUdFTk1BU0soNywgNikNCj4gPiArI2RlZmluZSBJTVg4TU1f
UENJRV9QSFlfQ01OX1JFRzA2NAkweDE5MA0KPiA+ICsjZGVmaW5lICBBTkFfQVVYX1JYX1RYX1NF
TF9UWAkJQklUKDcpDQo+ID4gKyNkZWZpbmUgIEFOQV9BVVhfUlhfVEVSTV9HTkRfRU4JCUJJVCgz
KQ0KPiA+ICsjZGVmaW5lICBBTkFfQVVYX1RYX1RFUk0JCUJJVCgyKQ0KPiA+ICsjZGVmaW5lIElN
WDhNTV9QQ0lFX1BIWV9DTU5fUkVHMDY1CTB4MTk0DQo+ID4gKyNkZWZpbmUgIEFOQV9BVVhfUlhf
VEVSTQkJKEJJVCg3KSB8IEJJVCg0KSkNCj4gPiArI2RlZmluZSAgQU5BX0FVWF9UWF9MVkwJCQlH
RU5NQVNLKDMsIDApDQo+IC4uLg0KPiA+ICsJaWYgKHBhZF9tb2RlID09IElNWDhfUENJRV9SRUZD
TEtfUEFEX0lOUFVUKSB7DQo+ID4gKwkJLyogQ29uZmlndXJlIHRoZSBwYWQgYXMgaW5wdXQgKi8N
Cj4gPiArCQl2YWwgPSByZWFkbChpbXg4X3BoeS0+YmFzZSArDQo+IElNWDhNTV9QQ0lFX1BIWV9D
TU5fUkVHMDYxKTsNCj4gPiArCQl3cml0ZWwodmFsICYgfkFOQV9QTExfQ0xLX09VVF9UT19FWFRf
SU9fRU4sDQo+ID4gKwkJICAgICAgIGlteDhfcGh5LT5iYXNlICsNCj4gSU1YOE1NX1BDSUVfUEhZ
X0NNTl9SRUcwNjEpOw0KPiA+ICsJfSBlbHNlIGlmIChwYWRfbW9kZSA9PSBJTVg4X1BDSUVfUkVG
Q0xLX1BBRF9PVVRQVVQpIHsNCj4gPiArCQkvKiBDb25maWd1cmUgdGhlIFBIWSB0byBvdXRwdXQg
dGhlIHJlZmNsb2NrIHZpYSBwYWQgKi8NCj4gPiArCQl3cml0ZWwoQU5BX1BMTF9DTEtfT1VUX1RP
X0VYVF9JT19FTiwNCj4gPiArCQkgICAgICAgaW14OF9waHktPmJhc2UgKw0KPiBJTVg4TU1fUENJ
RV9QSFlfQ01OX1JFRzA2MSk7DQo+ID4gKwkJd3JpdGVsKEFOQV9QTExfQ0xLX09VVF9UT19FWFRf
SU9fU0VMLA0KPiA+ICsJCSAgICAgICBpbXg4X3BoeS0+YmFzZSArDQo+IElNWDhNTV9QQ0lFX1BI
WV9DTU5fUkVHMDYyKTsNCj4gPiArCQl3cml0ZWwoQVVYX1BMTF9SRUZDTEtfU0VMX1NZU19QTEws
DQo+ID4gKwkJICAgICAgIGlteDhfcGh5LT5iYXNlICsNCj4gSU1YOE1NX1BDSUVfUEhZX0NNTl9S
RUcwNjMpOw0KPiANCj4gSWYgSSBjb21tZW50IG91dCB0aGlzIHdyaXRlbCgpIHRoZW4gdGhlIHJl
Z2lzdGVyIGRlZmF1bHRzIHRvIDB4MC9BVVhfSU4NCj4gYW5kIHRoZW4gdGhlIHN5c3RlbSBiZWhh
dmVzIGFzIGV4cGVjdGVkLg0KPiANCj4gPiArCQl2YWwgPSBBTkFfQVVYX1JYX1RYX1NFTF9UWCB8
IEFOQV9BVVhfVFhfVEVSTTsNCj4gPiArCQl3cml0ZWwodmFsIHwgQU5BX0FVWF9SWF9URVJNX0dO
RF9FTiwNCj4gPiArCQkgICAgICAgaW14OF9waHktPmJhc2UgKw0KPiBJTVg4TU1fUENJRV9QSFlf
Q01OX1JFRzA2NCk7DQo+ID4gKwkJd3JpdGVsKEFOQV9BVVhfUlhfVEVSTSB8IEFOQV9BVVhfVFhf
TFZMLA0KPiA+ICsJCSAgICAgICBpbXg4X3BoeS0+YmFzZSArDQo+IElNWDhNTV9QQ0lFX1BIWV9D
TU5fUkVHMDY1KTsNCj4gPiArCX0NCg0K
