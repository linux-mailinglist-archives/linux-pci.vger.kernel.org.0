Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5B94F21AB
	for <lists+linux-pci@lfdr.de>; Tue,  5 Apr 2022 06:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiDEDRl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Apr 2022 23:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiDEDRk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Apr 2022 23:17:40 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50073.outbound.protection.outlook.com [40.107.5.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9F41A044;
        Mon,  4 Apr 2022 20:15:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQhc7qAuTkORHwqd6AGbHji6PgWqTS0MIxyk0HQ04rR8gYpkl/srB5rW2OUdIfkNF+xhhtSh35IOO49aoYeQxCe6TRhJtsUvnXvzIQvNpunQHlFNJivQrFLykMZlHSD+nSNmAMBx2KHznhHIEVuw0qDc52HYFavCLZJiRbyk7ikrEc4YbUgRGap3coYsBDXJvOjcgfGEqvqXoQSjkZXYDiYmlvZQD1ybl3U9n6YGOjxiTjAm22BEvVfC1YOiFzRT2eYdssNp4ayUfHtUIDFZrLOcOaemHIJ0OrlWadbWY/fclXuRslRWVFEifAGwpIaWljWbYbQcy49ozldNttcNyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAXu3By1IDE2hgjX8CW9XMZWOMtQgEzAd3F+VfKN9dg=;
 b=Ew/F5/IUZjtRO84JHWiqpKgBblAQhMngwx1bWpCuZdcGKak2D1JhAYT4nPVxsBj+IamlP/bWLuVHvJM48pyzfeCqtbH8Kr6JqyK/jvZNQNCG/JmEwHvwI4IrakDDlnnz+GSgnrMmSdF+VIqyzMDGC1H6ygxXNT2kfkcYQDz3+Je8bvqZeBBBXbMABX+ixenJG2LsQja5IbffzNQid4uVVlpBlj6dnZ0kt8e3xEH/r1cIqzK2opboiEf68T3lwVla3gBZiMgs8hZXhiBfNWzajT5VlG9TEyZ0kgkHjghTv81i2oTdpnP4Sd8G8utnWH2AIA8fLzNavS1H1G9ijt/H2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAXu3By1IDE2hgjX8CW9XMZWOMtQgEzAd3F+VfKN9dg=;
 b=iKglqf9yWnNnl4TKskOy4iIPioBI18XRnlN1gNJgyZzczSzjEAx93Nb9xMl744bWxzsnNz0b60iZDlZmpoL3UfQ3GiMr3CDL1G3p4pbI3jldnrPvUNZlJ0vA5y5pSskf/RkoIyDn8vbvwLXDvz2kST2QhtpXBplaBd9Z+fn6YNY=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAXPR04MB8320.eurprd04.prod.outlook.com (2603:10a6:102:1cf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 03:15:38 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::ecea:cb09:5ff2:1800]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::ecea:cb09:5ff2:1800%4]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 03:15:38 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v8 6/8] PCI: dwc: Add dw_pcie_host_ops.host_exit()
 callback
Thread-Topic: [PATCH v8 6/8] PCI: dwc: Add dw_pcie_host_ops.host_exit()
 callback
Thread-Index: AQHYKfsvJHlP2AzW8UGmcNH944mEyKzbvl0AgABOesCABALLgIAAv2cg
Date:   Tue, 5 Apr 2022 03:15:38 +0000
Message-ID: <AS8PR04MB86764BFE2AC29F111DC607248CE49@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1645760667-10510-1-git-send-email-hongxing.zhu@nxp.com>
 <1645760667-10510-7-git-send-email-hongxing.zhu@nxp.com>
 <Ykdj+oJ+0k8UZCwK@robh.at.kernel.org>
 <AS8PR04MB8676A8E85BBDA507481E12C78CE39@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <YksDJfterGl9uPjs@robh.at.kernel.org>
In-Reply-To: <YksDJfterGl9uPjs@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5435754b-e34c-40d1-bb9c-08da16b28efa
x-ms-traffictypediagnostic: PAXPR04MB8320:EE_
x-microsoft-antispam-prvs: <PAXPR04MB83201799105A49515173C8258CE49@PAXPR04MB8320.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JxkAt5XvLXiOUYbC9amUmqHVbGcd+11LIAtWveTDOv2h5m/a7Skf2WkpnyDj/YV42VnoXda3E7e0bHALTjWwkC7UO7IP11XzP3pHDgxI2FTPnJTCqCTeupRJ498o4q+ruMDUUCUkg8irE9g6QuNjdJYs0+Khcl/ZumJArUXHPKME1OhbDDcgVjC0iYpVVpOE8eUpYSzjifUuZ/6GEVD2x5KkF/qk6B7YHcXU7p2iQ2a9VKvp+A2nSFz3OBF5XFTa9qKaPnYrevuN8hXM3HFPUpU2cIHXsceCqBfGDHRxs9YiWVeAziUWHqL2H1OOmbzD2Jo1RPTF+MLYfYxzJPnSO5jCPcOnlQkwt3jNhhUzdeGwGvZNAOXeUqeyaF3mf2I3uZxY7W8qXNgs+fXcZaqOt1lzT+eNLA68Xo491oB/l58OFnJrXzS5+7dzTJalFTQ5OJSfLwNcndd+AH/wzm+p73a9MkIy2+t8dJpxec551cN2VcJD/vCmqJX8z7RaO/fm5r7h6R3oZZqanSw3W6YHEPm9xrg4CRg/SpuEwMb+cal+YAZ0ZtERNCIVCuY2gNi6QEccIgXzv2Qy8wo++ucLab48rndMNHzbXS6ZMh08eu411CRXk313UsG/Jt4ANEV8wlORfLlNgIdkq3eQ8W/WhdMx5KV6nmX6xpf1xxPLEYSQBogsym60zMp9p36WpA4LQhW4KZBtnnsLHRtoDckvnTflOurvJgUOPUT23lp0c1FONFlSMoNudW1vROfQ6LxMF50CKN5IA6Rjj/+fYBkeJytv25DnkLSsqjuINd6eJzU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(26005)(52536014)(7416002)(44832011)(5660300002)(8936002)(2906002)(33656002)(186003)(508600001)(9686003)(122000001)(7696005)(6506007)(53546011)(71200400001)(38100700002)(76116006)(54906003)(6916009)(83380400001)(45080400002)(8676002)(66446008)(66476007)(966005)(64756008)(66556008)(66946007)(4326008)(316002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SzdSbExpblNKTDhRY1RQdUFWc3BuelZCb3YxZjh0eVZpUzFydno2QS9HWWhl?=
 =?gb2312?B?ZUR6cGF0UEg4eDFFb1ZrSGZBMmZGazd5WTVpWEpvV3YrVWZwYUhVbC9ZNUo4?=
 =?gb2312?B?dmttSG1DYk5yUUw2aWhzekNwdFIvQ2FxRlpJNTFzTGsxc1AyTFBmL05CYzFF?=
 =?gb2312?B?amxFVmM5ak4wMHFUd3dQZVZLYjRIOEpTMkNSZ0lNbk1rQnNhOW9STDlkcTFE?=
 =?gb2312?B?TXNpdzkzU1p6c0RYQnpEYm1uS3hNZlpGMjBlOFNidnBSOVM0czdpVzg4clcz?=
 =?gb2312?B?OGRWYTh6dXFuTEVxdkNVdjNmNU1wcGUxOEJYZGpPSmxlMXZkNm1KamMxQzZn?=
 =?gb2312?B?WFByZDdINHpJVDBHNjd5MVcva0VONEJPdGdpSXRzYk1JVk5tMHgyZWFIUnRz?=
 =?gb2312?B?ZTVnckh1VlRaaGdZSFVFZC9jQi85cGkwTjZ4ZER6RTFMeGNCaVNleTVnWUgz?=
 =?gb2312?B?TWdrWjVubm00alNaeGdvc0NEbDBjcW1DSVgyV0Y0akxrQlNVQUdOc0cxaUZm?=
 =?gb2312?B?UnFwVHhBVi9uYVQ0S2YxOHl5eVZkZ1pWZGN4UW9xV0dmeU91UzZZM1gySGd6?=
 =?gb2312?B?dmMyU3dCZXMrNmpWS1lEdy9QTlZoNnh4K1VIa29RbWZiby9BdmZXOGFBYTRI?=
 =?gb2312?B?VlJjdkFDbUNUdGcyb2NqdzNCcFFLY281ZXZOL3FUZ0tsallLd05tbHJBMHRW?=
 =?gb2312?B?OTYvbEN0NjBCbE4yaktaUkdNUjRrZzNhMUYvc1puKzl2MThnVUZTS2loU01O?=
 =?gb2312?B?UlRUNTI2OUk2SG9Iamp1ZE5ucFlwMkNhT1YxOGc4UzRkYVN4elBXbEdqRFl4?=
 =?gb2312?B?ckRrOXJnanZ6QzBCa2tkSWY1ZS82WlhpVkNUKzlydGMvSFA0Q0tWaDBrYW5v?=
 =?gb2312?B?WWIydk40QlFsa2JKZjk4WUNoWkFaZGpuWkVCUlM4R2lOWXRaZ2JpRmV3NE42?=
 =?gb2312?B?bVpTYlZoK3RBSkFaSDdXL2U4MHFCbDE5eEZqMitENTQxSmcyWlFUd3NSdURK?=
 =?gb2312?B?TGlXeFhpWHFianRSbWowUkQ5NmZyMUZoWUREMmMzc0Q2c1pvbjBoSTAvckwz?=
 =?gb2312?B?dy9tYm9TOHAyNUZvaHZXS08vYzQzQmt5TWtvZDQ0Y3ZsTE8yWTVFNGNYeEtD?=
 =?gb2312?B?S3RUejRDZVgyYUxLNGgwR0NuZUgzbDlTODZ2bnpKeEZWM3RsSmREbktDcmo3?=
 =?gb2312?B?VGF6aTFKQnUxWEUvWTRMNmVvY0NWa1JCRy81elcxZGJEc0M3eXdpa2hnNito?=
 =?gb2312?B?NjBYMG5qQ3dJK2VmOU1yalphQzI5MHFTUE5OeVlJZmUzNytwS1JLOTRjOW96?=
 =?gb2312?B?NG8zN2F2OGRObVNSd2ptZGZXQTR4UEd6RTNsZy9MSDZlVjA4clpwSmhKMzJF?=
 =?gb2312?B?OUNjVUNabnF0b0dkcHN0d2NwZ214Nm11T1VBSEN3Y0REMW5IZ3JURlNiY1dW?=
 =?gb2312?B?L2wwRTVET1Q1c2JZS3ZaZEZqUEhncVFnRnZqaUV4dWE1UWMzMWNLdGw4bUVJ?=
 =?gb2312?B?MmlaOGNlTS9Ca1ZPNTZTTDhOT3RiTDU3cEtTUHBIU3ZoT2dnZzVXeWJ0L0dN?=
 =?gb2312?B?dC9TRERGVnZiQ3RoaUFjcHpPV3lsdDZQKzB6dnBmYldIUy8zaVA4UG51amFZ?=
 =?gb2312?B?dkI1SVJrYzlOMGNnM3ZnT2FrYlNkb0NzMmxVc1pPT0ZlV1RrbGZ4b1NvSno0?=
 =?gb2312?B?WTN6TVQyRjdJMVp0SU4zaHhFOWpUK21iayszSGRxenJabjFsaE1oSlpWVmRN?=
 =?gb2312?B?NUZVSExadDh3b3hvZmVibHhSd04wMnR2SEdhVFNDM00xemk2a3RxcVUzYUcr?=
 =?gb2312?B?NTVRK0RrdVJlVmUrVlRZWUNwemxocHZtbldNWHZObnJTR0V5allHUS95b0x0?=
 =?gb2312?B?V29vNU5tamg1dGNHSnFYbG1iOHBsVExWN0Q3bUNUNXJSZ3ZXOXZwbFlGK0hp?=
 =?gb2312?B?SXpHS2pRN01saDM2SmwrN0dLQTBLaCt0UjYzSVo2clBIRiswMFhid2hua1Zm?=
 =?gb2312?B?bGFHeXJZRnZTV0FjcWxhc1N1V1JDNTJ3R282bDlObnVmeXZQcDZJVlQ2S1My?=
 =?gb2312?B?K3VGbDR0WDcvb0kxOTFNblp1TVYraTAwdk5tY3ZRQ1hPbWVkQnRsTEtxdFQ2?=
 =?gb2312?B?dWhFanlvbEJPSDZUNnBPVEthckR4ZU94aktGNEJnSzRnZkpzWVhuSWF2Njhq?=
 =?gb2312?B?T1IxUHliN01DNDRkZ0dJT2JqeU5FcHE4eEhESWVON0ptY1VlWUlJYnAzdXVh?=
 =?gb2312?B?MmYyb3hHdTJHb2dZYzdJMWsydlRkZm9WUXZOQ1BxV3h4Q3dZZEZUVzdiUnZE?=
 =?gb2312?B?RTBCbk9BV2pwNEZONlQ0dzdtc3pJTGhjVmFod1U5MUp3OU0xR2xvZz09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5435754b-e34c-40d1-bb9c-08da16b28efa
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2022 03:15:38.4351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wyx4gkyny6N7rvdLXQbmBhy+Z/xq17+0v/y5QMXuWkDPuTpKLxESPAM+HZqa3uQJkCAEPSA4w5/QZyEPw9FGmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8320
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPg0KPiBTZW50OiAyMDIyxOo01MI0yNUgMjI6NDANCj4gVG86IEhvbmd4aW5nIFpo
dSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOyBi
aGVsZ2Fhc0Bnb29nbGUuY29tOyBicm9vbmllQGtlcm5lbC5vcmc7DQo+IGxvcmVuem8ucGllcmFs
aXNpQGFybS5jb207IGppbmdvb2hhbjFAZ21haWwuY29tOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+
IGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3Jn
Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14IDxs
aW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OCA2LzhdIFBDSTogZHdj
OiBBZGQgZHdfcGNpZV9ob3N0X29wcy5ob3N0X2V4aXQoKQ0KPiBjYWxsYmFjaw0KPiANCj4gT24g
U2F0LCBBcHIgMDIsIDIwMjIgYXQgMDM6MDM6MDBBTSArMDAwMCwgSG9uZ3hpbmcgWmh1IHdyb3Rl
Og0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFJvYiBIZXJy
aW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+ID4gPiBTZW50OiAyMDIyxOo01MIyyNUgNDo0NA0KPiA+
ID4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gPiBDYzogbC5z
dGFjaEBwZW5ndXRyb25peC5kZTsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgYnJvb25pZUBrZXJuZWwu
b3JnOw0KPiA+ID4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgamluZ29vaGFuMUBnbWFpbC5j
b207DQo+IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gPiA+IGZyYW5jZXNjby5kb2xjaW5pQHRvcmFk
ZXguY29tOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+
ID4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29t
Pg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2OCA2LzhdIFBDSTogZHdjOiBBZGQNCj4gPiA+
IGR3X3BjaWVfaG9zdF9vcHMuaG9zdF9leGl0KCkgY2FsbGJhY2sNCj4gPiA+DQo+ID4gPiBPbiBG
cmksIEZlYiAyNSwgMjAyMiBhdCAxMTo0NDoyNUFNICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToN
Cj4gPiA+ID4gV2hlbiB0aGUgbGluayBuZXZlciBjb21lcyB1cCBhZnRlciAtPmhvc3RfaW5pdCgp
LCBzb21lIGRyaXZlcnMsDQo+ID4gPiA+IGVzcGVjaWFsbHkgdGhvc2UgdGhhdCBkb24ndCBzdXBw
b3J0IGhvdHBsdWcsIHdhbnQgdG8gdHVybiBvZmYNCj4gPiA+ID4gY2xvY2tzIGFuZCBwb3dlciBz
dXBwbGllcy4NCj4gPiA+DQo+ID4gPiBJc24ndCBzdXBwb3J0aW5nIGhvdHBsdWcgb3Igbm90IGEg
Ym9hcmQgbGV2ZWwgZGVjaXNpb24/IEFuZCBob3RwbHVnDQo+ID4gPiBkb2Vzbid0IGhhdmUgdG8g
bWVhbiBwaHlzaWNhbCBwbHVnL3VucGx1Zy4gRm9yIGV4YW1wbGUsIHlvdSBjb3VsZA0KPiA+ID4g
aGF2ZSBhIHNvbGRlcmVkIGRvd24gUENJZSBkZXZpY2Ugd2hpY2ggbmVlZHMgcmVndWxhdG9ycywg
cmVzZXRzLCBjbG9ja3MsDQo+IGV0Yy4NCj4gPiA+IGZvciB0aGF0IGRldmljZSB0byBiZSBpbml0
aWFsaXplZCBiZWZvcmUgdGhlIGxpbmsgY29tZXMgdXAuIElmIHRoYXQNCj4gPiA+IGRldmljZSBp
cyBoYW5kbGVkIGJ5IGEgbW9kdWxlIGxvYWRlZCBzb21lIHRpbWUgbGF0ZXIsIHRoZW4gdGhlIGxp
bmsNCj4gPiA+IG1heSBiZSBkb3duIHdoZW4geW91IHByb2JlLg0KPiA+ID4NCj4gPiA+IEkgdGhp
bmsgdGhlIHdheSB0aGlzIGFsbCBuZWVkcyB0byB3b3JrIGlzIHdpdGggcnVudGltZSBQTS4gSWYg
dGhhdCdzDQo+ID4gPiBhbGwgaW4gcGxhY2UsIHRoZW4gZWl0aGVyIHlvdSBzaHV0ZG93biBjbG9j
a3MvcG93ZXIgb24gdGltZW91dCBvcg0KPiA+ID4gdmlhIHN5c2ZzIHN1c3BlbmQuIElmIHRoZXJl
J3MgYSBjaGlsZCBkZXZpY2UsIHRoZW4gdGhhdCBzaG91bGQgcHJldmVudA0KPiBzdXNwZW5kaW5n
Lg0KPiA+IEhpIFJvYjoNCj4gPiBUaGFua3MgYSBsb3QgZm9yIHlvdXIgcmV2aWV3IGNvbW1lbnRz
Lg0KPiA+IFVuZGVyc3RhbmQgd2hhdCB5b3UgbWVhbi4NCj4gPiBpLk1YIFBDSWUgZG9lc24ndCBz
dXBwb3J0IGhvdC1wbHVnIGZyb20gY2hpcCBkZXNpZ24gdmlldy4NCj4gDQo+IFRoZSBzY2VuYXJp
byBJIGRlc2NyaWJlZCBpcyBub3QgaG90cGx1Zy4NCkhpIFJvYjoNClNvcnJ5LCBJIGRpZG4ndCBn
ZXQgd2hhdCB5b3UgbWVhbnMgYmVmb3JlLg0KSW4gdGhlIGhvdHBsdWcgaXMgbm90IHN1cHBvcnRl
ZCBzY2VuYXJpby4NClJlZmVyIHRvIG15IHVuZGVyc3RhbmQsIGJvdGggcGNpX2hvc3RfcHJvYmUt
PnBjaV9zY2FuX3Jvb3RfYnVzX2JyaWRnZSBhbmQNCkxUU1NNIHRyYWluaW5nIGVuYWJsZSBhcmUg
b25lIHNob3QgY2FsbGJhY2sgZHVyaW5nIGkuTVggUENJZSBwcm9iZSBwcm9jZWR1cmUuDQpIb3cg
dGhlIGV4YW1wbGUgeW91IGRlc2NyaWJlZCBpbiB0aGUgcHJldmlvdXMgZW1haWxzIGNhbiB3b3Jr
IHdlbGw/DQpQbGVhc2UgY29ycmVjdCBtZSBpZiBJJ20gd3JvbmcuDQoNCkJlc3QgUmVnYXJkcw0K
UmljaGFyZCBaaHUNCg0KPiANCj4gDQo+ID4gVGhlIG9wcy5ob3N0X2V4aXQoKSBjYWxsYmFjayBp
cyBpbnZva2VkIG9ubHkgd2hlbiB0aGUgaU1YIFBDSWUgZHJpdmVyDQo+ID4gaG9va2VkICBjYWxs
YmFjayBvcHMtPnN0YXJ0X2xpbmsgcmV0dXJuIGFuIGVycm9yLg0KPiA+IEZvciB0aGUgcGxhdGZv
cm1zLCB0aGF0IHN1cHBvcnQgdGhlIGhvdC1wbHVnIGZlYXR1cmUsIHRoZXkgY2FuIGp1c3QNCj4g
PiByZXR1cm4gb25lIHplcm8gZnJvbSB0aGVpciBvd24gb3BzLT5zdGFydF9saW5rLg0KPiANCj4g
WW91IGNhbm5vdCBoYXZlIGEgcGVyIGJvYXJkIHN0YXJ0X2xpbmsoKS4NCj4gDQo+ID4gSW4gdGhl
IGN1cnJlbnQgc2l0dWF0aW9uLCBpLk1YIFBDSWUgZG9lcyBqdXN0IHJldHVybiBvbmUgemVybyB3
aGVuIHByb2JlDQo+IGZhaWxlZC4NCj4gPiBTZWUgdGhlIGRpc2N1c3Npb24gYW5kIGNvbW1pdCBp
c3N1ZWQgYnkgRmFiaW8gYmVsb3cuDQo+ID4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVj
dGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGcGF0Yw0KPiA+DQo+IGh3b3JrLmtl
cm5lbC5vcmclMkZwcm9qZWN0JTJGbGludXgtcGNpJTJGcGF0Y2glMkYxNjQxMzY4NjAyLTIwNDAx
LTYtZw0KPiBpDQo+ID4NCj4gdC1zZW5kLWVtYWlsLWhvbmd4aW5nLnpodSU0MG54cC5jb20lMkYm
YW1wO2RhdGE9MDQlN0MwMSU3Q2hvbmd4aW5nDQo+IC56aHUNCj4gPiAlNDBueHAuY29tJTdDYjIz
ZmZmNmIyYzI2NDQxMGRhMGEwOGRhMTY0OGYxMDUlN0M2ODZlYTFkM2JjMmI0DQo+IGM2ZmE5MmNk
OQ0KPiA+DQo+IDljNWMzMDE2MzUlN0MwJTdDMSU3QzYzNzg0Njc5OTc4MDY0Njc4NCU3Q1Vua25v
d24lN0NUV0ZwYkcNCj4gWnNiM2Q4ZXlKV0lqDQo+ID4NCj4gb2lNQzR3TGpBd01EQWlMQ0pRSWpv
aVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzANCj4gMDAmYW0NCj4g
Pg0KPiBwO3NkYXRhPWZFOVV4Q3E0UzVLJTJCVVRQV2ZGUjVoNXI1NiUyQjI2ZzdhbmxQS3ZrbG85
c0t3JTNEJmFtcDsNCj4gcmVzZXJ2ZQ0KPiA+IGQ9MA0KPiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxp
bmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnBhdGMNCj4gPg0K
PiBod29yay5vemxhYnMub3JnJTJGcHJvamVjdCUyRmxpbnV4LXBjaSUyRnBhdGNoJTJGMjAyMjAx
MDYxMDM2NDUuMjc5MA0KPiA4MA0KPiA+DQo+IDMtMS1mZXN0ZXZhbSU0MGdtYWlsLmNvbSUyRiZh
bXA7ZGF0YT0wNCU3QzAxJTdDaG9uZ3hpbmcuemh1JTQwbngNCj4gcC5jb20lDQo+ID4NCj4gN0Ni
MjNmZmY2YjJjMjY0NDEwZGEwYTA4ZGExNjQ4ZjEwNSU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5
YzVjMw0KPiAwMTYzNSUNCj4gPg0KPiA3QzAlN0MxJTdDNjM3ODQ2Nzk5NzgwNjQ2Nzg0JTdDVW5r
bm93biU3Q1RXRnBiR1pzYjNkOGV5SldJag0KPiBvaU1DNHdMakF3TQ0KPiA+DQo+IERBaUxDSlFJ
am9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJmFtcDtzZGF0
YQ0KPiA9T0c0DQo+ID4NCj4gNVhRQk9kcWtINkI5S1ltcVU4M21OczF3dUhpT0NiJTJCM29MOWFk
NlNRJTNEJmFtcDtyZXNlcnZlZD0NCj4gMA0KPiANCj4gVGhhdCdzIGEgc3RhYmxlIGZpeCBhbmQg
ZGlmZmVyZW50IGRpc2N1c3Npb24uDQo+IA0KPiA+ID4gPiBBZGQgYSBuZXcgLT5ob3N0X2V4aXQo
KSBjYWxsYmFjayBpbiBkd19wY2llX2hvc3Rfb3BzIHNvIHRoZXNlDQo+ID4gPiA+IGRyaXZlcnMg
Y2FuIGNsZWFuIHVwIGlmIC0+aG9zdF9pbml0KCkgZmFpbHMuDQo+ID4gPg0KPiA+ID4gSSdtIG5v
dCByZWFsbHkgYSBmYW4gb2YgYWRkaW5nIG1vcmUgb3BzIG5vciB0aGUgb3BzIHdoaWNoIGFyZW4n
dCB0b28NCj4gPiA+IHNwZWNpZmljIGFib3V0IHdoYXQgdGhleSBkby4gJ2luaXQnIGFuZCAnZXhp
dCcgY2FuIGJlIGFueXRoaW5nLiBJJ2QNCj4gPiA+IHJhdGhlciBzZWUgbW9yZSBzcGVjaWZpYyBv
cHMgd2l0aCB0aGUgRFdDIGNvcmUgZHJpdmVyIGluIGNoYXJnZSBvZg0KPiA+ID4gc2VxdWVuY2Ug
b2Ygb3BlcmF0aW9ucyBhbmQgdGhlIHN0YXRlLg0KPiA+IFVuZGVyc3RhbmQuDQo+IA0KPiBZb3Ug
ZG9uJ3Qgc2VlbSB0by4uLg0KPiANCj4gPiBpLk1YIFBDSWUgY2FuJ3QgaGFuZGxlIHRoZSBlcnJv
ciBleGl0IHByb3Blcmx5IGluIHRoaXMgY2FzZSBieSBpdHNlbGYuDQo+ID4gU28gSSAgYWRkIG9u
ZSBtb3JlIG9wcy5ob3N0X2V4aXQoKSBpbiB0aGlzIHNlcmllcy4NCj4gPg0KPiA+IEJlc3QgUmVn
YXJkcw0KPiA+IFJpY2hhcmQgWmh1DQo+ID4gPg0KPiA+ID4gUm9iDQo=
