Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0782C4BD689
	for <lists+linux-pci@lfdr.de>; Mon, 21 Feb 2022 07:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345130AbiBUG0w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Feb 2022 01:26:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345121AbiBUG0v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Feb 2022 01:26:51 -0500
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03on0613.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0a::613])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2535FF29;
        Sun, 20 Feb 2022 22:26:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuBjO9khm5H1D3rOSfqWVCqH3drPEj10zsexMKgzIP9cFwFSE2CglZne9iL8uV18BCR4xfNy4/9Dy9r1f9N1N8oRMM5O5CqFAbJYi6CSOam/TkoamprErubZxxelhxg0NdN//TTut9Qyt80C5rmXvk913JpG/GsCvL1SoOUukY4eJjJZfrmtqYrNI5MBkwtp05qVD2YZQ3M0s/PQ6eZsdMbaQv6Vqj+781w8eZzs/2X2ObJ7LymHvsMUy+Mt5IkmlobNrm+omnWTI5M8hwVZ6S1VcAMNURU64x2N9QsCb7MDp24++9/acE+YDfEO+T3Bs2q3Fkjl9z1x5n4g1PmU+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7i+pvipDXO5v7Mk59lwzQ+E1+ad6DF2QA5cZ2BjkRU=;
 b=XOYFXAuILrQXBAzV7aBbnsw0fY1xZdZJKuuEWheDjrLF5XYEe+mQHo8HQ0yVv6RJ/TE+KMmDKcJHdlhfgy2tkS8nD19fV/uTx1C0kU+zm2f22A9cK4cEyVfWGqWw2uH+AhHAH9+IlxhSeO83zO/NFP1GIiW2l7THbh/DtObVW/GEnL9KpD9kecak3AqxTXoqRUNWtmm/4XFRaNeDNuf7v5EOcBPc6xeFzjtCnH6ooUmpL53ZS1GaFWxKL1YTLfynDXY6F46yITfNscFdUIBe2kppSmpTijUrsWkCpGavZBmm/2bNNAM2jCLfPDh7B44bH7RyQUXkMbruHa5X4XkXnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7i+pvipDXO5v7Mk59lwzQ+E1+ad6DF2QA5cZ2BjkRU=;
 b=j99uXgpE+XfVtM4hqII6BeAbwWIj4Gr+mNHN/bMb9Gbf0hga9B9ZKNYLSArx0N5AR+F5LoBm7+1UwIJRV6bUj4ctzF/ceJd1VD8pIhBhZkVHFnCPU//3U9V0SxTVQDbeWHC0ZV1xH+bjexDaXhadg8280HU6VP1+IylYh7mVqDI=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VE1PR04MB6384.eurprd04.prod.outlook.com (2603:10a6:803:126::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Mon, 21 Feb
 2022 06:26:23 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199%7]) with mapi id 15.20.4995.018; Mon, 21 Feb 2022
 06:26:23 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v3 1/2] ARM: dts: imx6qp-sabresd: Enable PCIe support
Thread-Topic: [PATCH v3 1/2] ARM: dts: imx6qp-sabresd: Enable PCIe support
Thread-Index: AQHYIi+jK27YlPX030Wmh8GefH7b+qydcD8AgAAhniA=
Date:   Mon, 21 Feb 2022 06:26:23 +0000
Message-ID: <AS8PR04MB8676407A57D5741B05FC3A2B8C3A9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1644902192-12957-1-git-send-email-hongxing.zhu@nxp.com>
 <20220221042008.GL2249@dragon>
In-Reply-To: <20220221042008.GL2249@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8825828f-8a60-40c6-25d9-08d9f50314c1
x-ms-traffictypediagnostic: VE1PR04MB6384:EE_
x-microsoft-antispam-prvs: <VE1PR04MB6384DD1FB43D4E52FBA5879B8C3A9@VE1PR04MB6384.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zxe78FTG3ZNy1zftxv6gOizqt0QqhowdvJlUDsGjQhT9IzKE6pFkrc/LiqSgNiGkhlYYtU1yb5dc8PMxgSQF0rPwPZslSpud+RoYuVcTA1MrnHZBqYtQurVhd4/BaIHDwF2wYy8sHmXykKXT8Mk14gALAePy4Qw7AeGUoRd7aQaLhg8kQlhQX3vEz4F7WgcTag/0LJ4oMHu/agjST95kVT/xfYiwNj+KIxWOZh2VkPl9gbprAcJFUhTt+0KAxzRYYonZdR96vWh9/J9kFD5aT9fP1vwXn1IZ+rpLh69ELuIzPuEm6uSpGnOBGdAtr+fh9peLb1L1iqdVVpBFCEmibp1M8mlQzBY2k3jImLjtBTvPR2+NiJZeiZDe9EDCJyNxmhzVhx2MAwyfs5oOU1XZs8kovpiJvzQboK/AnoAMqYiWlG58JpUdcPtrNbrjjDUCyuskLAv4uxfAMiS72MMHkx3tTJjww0DcrUPQu/ov3aytJb544N2mj4mRTBzOGZ+fH5VfngNrnUBgEF8cEKJJKMqK8UcmKQNp5VyHjaT9MsiioZlMt/sIEQvVz/uFslzv5sPWKXCVTj7HcK7QmOBofQfKOsg8gTO1vt0Gx3N5OTTSdU6AWHAHsz7qctjA5aA1U/WX3KRIRvUICUffdo+ztgBHDqtvAns5tvjK3ULevBBDuw/CIuMCnzoH77mEEKgChuTg/fuMIW/lA4heeuY5BJUX4eWc6tGV27RgUQVQb+E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(52536014)(5660300002)(8936002)(2906002)(122000001)(9686003)(38100700002)(86362001)(26005)(186003)(44832011)(316002)(71200400001)(83380400001)(6916009)(54906003)(53546011)(7696005)(6506007)(33656002)(8676002)(508600001)(4326008)(76116006)(64756008)(66446008)(66476007)(66556008)(55016003)(66946007)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dGJVV1k3V3drTVNkTXlKYmF4NkVvWitTN05rOStHTUxUVXhoVm00VmtSMUJ0?=
 =?gb2312?B?UDNBN2xTK2kxMjhJaXVEM3ZwaTRpd2hlNGtRdmZFdFBzR2M1cFl5SDFSWVpo?=
 =?gb2312?B?aGtmeXFTa1dCR0hpbkVzc3dKZWhxNFYrRjN4Y3ZmTHZvS2NpVVJZRUpDc0xC?=
 =?gb2312?B?MWo2OGRQWm8xNzFhdDZiUDllZFJBVVBINWdZaUJtcEJGK3l4d0cvUVUyYU9G?=
 =?gb2312?B?NTFQU1BMNU10S29sdVZvSWlwTU9tbUlXaTIrMG1MeG5SdkFselZ0R2tWU2pZ?=
 =?gb2312?B?bGtCUERpa2JUTi9FZGhLdXZkb3NDYU5ZWEY1M2UyR2VydW4vanMrZWd2ZXh5?=
 =?gb2312?B?R3MwNzlhODZ2eGdiSGF2K09LbEloMTBoREpQK3VMLzRDQjJONzlja1RvNG5C?=
 =?gb2312?B?WVFHV1o3MWlYL1NjY0lrQXhjSVU0Q3loRWZWQUtKRXoxQ0JtcURjS3pTWnZG?=
 =?gb2312?B?Y201bnFoUzRRRnhVRXpHbW9UYThoVXNaemxFdUJiT3JxYkp1dHZMYWhFc25s?=
 =?gb2312?B?SW9LcllPaTRKMXdUbjFXVDlaK2hVTGhaSGVHMCszRjVCK0VKazJrYmVNcDZS?=
 =?gb2312?B?Q0srMk5sSHpYbEpUd3N2LzArWGhhOUZxcEpiQXVHdmdHOTFXN2hqTjFwSFUw?=
 =?gb2312?B?U1lNS3RyZi9GNFR0elhKcnErZGV6dFZYclljSzlGQnltUS8wRUZHQUNQVmUv?=
 =?gb2312?B?UG80Y0pFSlFSVkpXeVYxL3hkNHhVUG5wOEhuMG5jL1dVZmVUc2RuVlViV0oy?=
 =?gb2312?B?WEpwQ2k0Q0swTUEwclpubUFpOHBrb0VtN2FxTU10T2V0bmhieHRsVkZxL0VE?=
 =?gb2312?B?d2VGc0szdXV6RldaNHBEbmxESWhpZVppUmJiOEI2aU9Pd1BnRzQ2VmVPRHlL?=
 =?gb2312?B?TlpWSFBOV0FydU5tQm5YZjJuM2ZoQ2RPdlVyUGN2MVlOS1V2MSsxcWJvaloz?=
 =?gb2312?B?TEtPMzR4TmZOemhmV0JFREF2cjNMVGkremFSbEpNLzdFL2czdk8yTS9rbk41?=
 =?gb2312?B?YnpSVm8zbWdXcW44TUFRRzQ2dC94WVVqRlhzNFlaaStJeC84aysrbFBBb0JO?=
 =?gb2312?B?Z0U2SDBsdXJlcExOdjkxWTN5Z1Eza3M4Z0U3OXQ1cE5jVHNKNVdjMHdRTFlE?=
 =?gb2312?B?S05xUVZrQWtHTFdPZUk5VXJYdE9OUFRQRFRvUUJOQUJabTNSRCtYZXpsQ2JV?=
 =?gb2312?B?UEd5UkkwVWwxYlBQRGs1VmJEbWVaU2FQQXhxbFYxRHhqUzlLVEJ3TVFuSjk1?=
 =?gb2312?B?Y2tjTkVDdXV0b0ZBNGVoYzF3ZTJ0TkJRZHluZmxvdzJaTGlYZnBua1FPYnFo?=
 =?gb2312?B?K01qbzdBQ25SVmJ1ME84ZzlZNHVVMThWb2lRcWg1TkU1OTUvbTdaQ0d0S25i?=
 =?gb2312?B?MEZucmxXbUtRenFFNmxJNTBOZjFtVVlBMlM0RHB5dUVmVk52QThwZWNqRXVG?=
 =?gb2312?B?MmVsY0IrdW8yUFdqcG1GLzk1OHZuY0EwQUpNNjMyZzVJNVBDSU42b3Z4aWNI?=
 =?gb2312?B?d0tqa3VYaFFZdnZSSjZ4S1hrRkVKUDhWR3RDNmt4dGYxclEyUHI0R3kycmgv?=
 =?gb2312?B?b2ZqRFFyNEkxSXlKaUdMWUtjOUxwd2Vxcm9WQmV1SFJQdlI2WS9FZlNPTStC?=
 =?gb2312?B?MGtMbTc3VXBZMnVJMWFHRytVaDgvcGdQM2ZxOXdOMGtEZ0ZlUUoyckU1NUY2?=
 =?gb2312?B?aEhTdFBqWi9hSlRVcFZmV3JFdW52c1htN0FMVE0zN2wxRU14Z25Nc09KamtP?=
 =?gb2312?B?YjBkYloweGtLTVpNaEw4eGMrVGtTTFlSdEYxZjhRTDYwckhneUFjMVBkbE9u?=
 =?gb2312?B?aFJNSmRUMjV5c1U5dHZWTitMY2xuTllqY0xNeE5OWVYrVC9xNXRDM25vYWtI?=
 =?gb2312?B?NERJcW5HMmlYWnFlNFdUT0JndG9HK3UvWVY2OFBmcjFlL1BvYSt6Z2J2S3do?=
 =?gb2312?B?WEplaGNZN0Jlb21ncVhHYXlMRXFwdzVSR2E4WGlTbFozdzVaRFp3UVJlRVMy?=
 =?gb2312?B?a2JZaWZaY0g2UlB6cy9GUjNxdWIyTUlWWjFMSmttcy9KZkJXVFU0SE13bWFK?=
 =?gb2312?B?aEIzSk0vRFhIQ01lZ3ptL0JSME1ZcXcrY3NiS2J3NmJzQUNDZGd3OWtWdkNu?=
 =?gb2312?B?dUM4dzh2by8vN0NnTTZ4bi9TSGgyTjVEOCtQSVh0b0FFTW1lNE83YUxKQ2lL?=
 =?gb2312?B?RVE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8825828f-8a60-40c6-25d9-08d9f50314c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 06:26:23.0608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: do8jY4iiNMYuHuGBS7RLtt6bK+0xW18eVcAuSRnMfEfCViBjqyLQ3ATzV6QsSfsBwjLdefEESb3qKn7UI1ft4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6384
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGF3biBHdW8gPHNoYXduZ3Vv
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jLUwjIxyNUgMTI6MjANCj4gVG86IEhvbmd4aW5n
IFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBsLnN0YWNoQHBlbmd1dHJvbml4LmRl
OyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBsaW51
eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGtlcm5lbEBwZW5ndXRyb25p
eC5kZTsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MyAxLzJdIEFSTTogZHRzOiBpbXg2cXAtc2FicmVzZDogRW5hYmxlIFBDSWUgc3VwcG9y
dA0KPiANCj4gT24gVHVlLCBGZWIgMTUsIDIwMjIgYXQgMDE6MTY6MzFQTSArMDgwMCwgUmljaGFy
ZCBaaHUgd3JvdGU6DQo+ID4gSW4gdGhlIGkuTVg2UVAgc2FicmVzZCBib2FyZChzY2gtMjg4NTcp
IGRlc2lnbiwgb25lIGV4dGVybmFsDQo+ID4gb3NjaWxsYXRvciBpcyBwb3dlcmVkIHVwIGJ5IHZn
ZW4zIGFuZCB1c2VkIGFzIHRoZSBQQ0llIHJlZmVyZW5jZSBjbG9jaw0KPiA+IHNvdXJjZSBieSB0
aGUgZW5kcG9pbnQgZGV2aWNlLg0KPiA+DQo+ID4gSWYgUkMgdXNlcyB0aGlzIG9zY2lsbGF0b3Ig
YXMgcmVmZXJlbmNlIGNsb2NrIHRvbywgUExMNihFTkVUIFBMTCkNCj4gPiB3b3VsZCBoYXMgdG8g
YmUgaW4gYnlwYXNzIG1vZGUsIGFuZCBFTkVUIGNsb2NrcyB3b3VsZCBiZSBtZXNzZWQgdXAuDQo+
ID4NCj4gPiBUbyBrZWVwIHRoaW5ncyBzaW1wbGUsIGxldCBSQyB1c2UgdGhlIGludGVybmFsIFBM
TCBhcyByZWZlcmVuY2UgY2xvY2sNCj4gPiBhbmQgc2V0IHZnZW4zIGFsd2F5cyBvbiB0byBlbmFi
bGUgdGhlIGV4dGVybmFsIG9zY2lsbGF0b3IgZm9yIGVuZHBvaW50DQo+ID4gZGV2aWNlIG9uIGku
TVg2UVAgc2FicmVzZCBib2FyZC4NCj4gPg0KPiA+IE5PVEU6IFRoaXMgcmVmZXJlbmNlIGNsb2Nr
IHNldHVwIGlzIHVzZWQgdG8gcGFzcyB0aGUgR0VOMiBUWA0KPiA+IGNvbXBsaWFuY2UgdGVzdHMs
IGFuZCBpc24ndCByZWNvbW1lbmRlZCBhcyBhIHNldHVwIGluIHRoZSBlbmQtdXNlciBkZXNpZ24u
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5j
b20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZxcC1zYWJyZXNkLmR0cyB8
IDggKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxcC1z
YWJyZXNkLmR0cw0KPiA+IGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFwLXNhYnJlc2QuZHRzDQo+
ID4gaW5kZXggNDgwZTczMTgzZjZiLi4wODNjZjkwYmNhYjUgMTAwNjQ0DQo+ID4gLS0tIGEvYXJj
aC9hcm0vYm9vdC9kdHMvaW14NnFwLXNhYnJlc2QuZHRzDQo+ID4gKysrIGIvYXJjaC9hcm0vYm9v
dC9kdHMvaW14NnFwLXNhYnJlc2QuZHRzDQo+ID4gQEAgLTUwLDggKzUwLDE0IEBAIE1YNlFETF9Q
QURfU0QzX0RBVDdfX1NEM19EQVRBNw0KPiAJMHgxNzA1OQ0KPiA+ICAJfTsNCj4gPiAgfTsNCj4g
Pg0KPiA+ICsmdmdlbjNfcmVnIHsNCj4gPiArCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDE4
MDAwMDA+Ow0KPiA+ICsJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MzMwMDAwMD47DQo+IA0K
PiBUaGVzZSBjYW4gYmUgc2F2ZWQsIGFzIHRoZXkgYXJlIHVuY2hhbmdlZD8NCg0KR29vZCBjYXVn
aHQuIFRoYW5rcy4NClRoZXNlIHR3byBsaW5lcyB3b3VsZCBiZSByZW1vdmVkLCBzaW5jZSB0aGV5
IGFyZSBub3QgY2hhbmdlZC4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+IA0KPiBT
aGF3bg0KPiANCj4gPiArCXJlZ3VsYXRvci1hbHdheXMtb247DQo+ID4gK307DQo+ID4gKw0KPiA+
ICAmcGNpZSB7DQo+ID4gLQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiA+ICsJc3RhdHVzID0gIm9r
YXkiOw0KPiA+ICB9Ow0KPiA+DQo+ID4gICZzYXRhIHsNCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+
DQo=
