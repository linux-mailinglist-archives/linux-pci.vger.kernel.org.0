Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824395E98B5
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 07:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiIZFQ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 01:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiIZFQ4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 01:16:56 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130040.outbound.protection.outlook.com [40.107.13.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EB02A941;
        Sun, 25 Sep 2022 22:16:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAWBodxjYcwQSdVUQMB2gcbWGQrfRbwFQNHqkg3VrGf1kllHs408wTdv3H4EkocZFfgNyMCsO2SjOW9O4Uw2stNEJ+fwZxksT1qI0BgEzDIIij2wL6RUmYmIkjB70LDeep2hUtosO13yEqi4Oo7KcyolFL8kn5bm7m1LsFPwoMFvixGY47HuXHSsuEa0JUthFFeV+SxozE3NKQWZHD9JhBOOVve3oVNiauheyinmZ0DxAdh3zWIfSkblO7YwJB8ei7i21XZWsCj+FDofQtrCsCqKn6+nT/R8x7qqib8brzCx8NkhfaqZm2Q+pObwX/5ZB3nUT2NwHlYLEUS7xrYW+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1alx2T461xiAe58tpCQjUfLrNS5C32FwPtzaDlC0WmQ=;
 b=GeW74ee8ku/I/F6m85IonLPjagyoBSOtlp/UApUQ6gkfAVmDlPUVwup2SYcGMfhwFafaimB5uqQKtjTnKSdqVF0mcri2wGH+IpxbX/sNIGbzENuragQ9AjXMbCuhG1eU3KSf0W65Qi8wR8wtxLkVQGa7+nEWfCXb3Hhn/6+aMmapHr4HOFFa1winyzV0lIudCuycOPUh9MkaVuEqSqVoqaSCp/FtKDsdjEYKGGXTCM1g3ngixBziPLxdFeuXDdTmcE+L77TQoDtN6bHAypIGwQKO9fepv83yCx8cuAKrG29g6i5PVaozEUhyKhyQ0+Dsdrt5kArJG572Sra+IwSNsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1alx2T461xiAe58tpCQjUfLrNS5C32FwPtzaDlC0WmQ=;
 b=hLtVLnsSo7Iml9bRQXUIEmOqiQEaM1EdEWfV4p0k6T/I/lSRNrcqdvTwmkbWd550Bl/TvhavFnnmQ4XZvd9hRq9Fgnd/kmylmQlPqWY3YQJdAVKloFdyBqhnMM1SnSnSpbQQL5EASqrRkD9WmuXyanL1M5TXrbEN2oi75UP+ddk=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by GV1PR04MB9056.eurprd04.prod.outlook.com (2603:10a6:150:1f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 05:16:51 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::8574:efa7:38c8:3c05]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::8574:efa7:38c8:3c05%5]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 05:16:51 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>, "kw@linux.com" <kw@linux.com>,
        Frank Li <frank.li@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v3 05/14] arm64: dts: Add iMX8MM PCIe EP support
Thread-Topic: [PATCH v3 05/14] arm64: dts: Add iMX8MM PCIe EP support
Thread-Index: AQHYzxVYk24BljBB3UuPI1pQdD+3y63tDDCAgAQj1PA=
Date:   Mon, 26 Sep 2022 05:16:51 +0000
Message-ID: <AS8PR04MB867688B25B58C3ECF85D6C4C8C529@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1663913220-9523-6-git-send-email-hongxing.zhu@nxp.com>
 <20220923140255.GA1388596@bhelgaas>
In-Reply-To: <20220923140255.GA1388596@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|GV1PR04MB9056:EE_
x-ms-office365-filtering-correlation-id: 2e92188a-0a13-4937-6159-08da9f7e51de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PUNpeGbdn4j52WzBa9tW+znLGGTA+KBqw/sGSVJ+B+PPzyas7F8gBAJhXqq8UqxIK26+vnsz/Zy0gR0Aubu5A9SBmjB1lHn5e7H0uGCgKnL5dG38xcKaZElED23kKd1+bu6o7QayrDvfRv7uGN8IOYXGu7H4xbfEWVaTxElcDcWOeJAmQjd1MM6DNHD/02zf6lFKqXVG2HGuF/AtC4zoB7TLCEyLoQP7f6WqsGp4T0/E0sm42WSbdur7DoOx3oSDh2g+BhGbQZt6aWFfzCg+QMoI19zto3l7dwf68pjW3eKPNbYdoXZUq83muzolTzrb5OVBmSJr7Pq13RZAkLQenZLhK9Mmvs8XBbsRJ4q/EDeLi0z+rGATGHVlnW3sQpRBQUZ+5B6YVrTKb97U7601Mw/NiIPMMjNM4hMcYLa/tsaIf8HxiwCOAnRHMcfwAXvJj5Jh2rWjPBi1EBEbAOzcsbQ5qoOjop3oID0KzK7jqaLf6USIvvGnsIdFeAvqcaE0pcbDBMG08AYnwYqfe2xa0nw1rWogobfnzhfCAviTDfjZavub4gFyHnWSLR4UyMLGqXV8RRMFS4ElmWNFdkRYPzhKEN86PFYqw9mQBvxYrunZo88Yy0Lu3VeVBtHNj3FPnfIqg/K4CmlJlH9OjcQiugyhPdStqAkzUnAdKQV30Sy/Rg4Eea8DHwT/HvHKlNQySYd8HrLnOvf9ipO6M+63AyK6pzXoKYPjpt0uAiyEFOn+7Fl1QQGhxaGIIJVSlQTmL+btiLJWnhOM/FkeAxWo28RmJNb1YVtbtvV7UOQ+jEeZU1krx/CQ9bG3t2le48Ko
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199015)(54906003)(71200400001)(6916009)(966005)(316002)(45080400002)(478600001)(83380400001)(76116006)(66946007)(66556008)(8676002)(4326008)(66476007)(64756008)(66446008)(41300700001)(7696005)(52536014)(6506007)(5660300002)(9686003)(53546011)(7416002)(44832011)(26005)(38070700005)(2906002)(8936002)(33656002)(186003)(122000001)(38100700002)(55016003)(86362001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Nm5VUXJKVXl2dTYxT3RPOUk4dmg3U1RtaC80d0xvak1PQkhyOFlaRFdPaE5s?=
 =?gb2312?B?elY5STdZZ1FmUDlKSHRtcmNxS2pidVV0dFJHTkY5WW5ib2h0M1RMeDNtSUJh?=
 =?gb2312?B?b3Rqb1dITFBnb3FPMy9EelpITThKeGJTbXUyMUFkN1pqWG1rTXp2RkZTMms4?=
 =?gb2312?B?MnlUL1dLeEp0SndibEVMVXd1MjJTQ01Ddm9TV2VNSitoNDlXQXhLenh1dUZy?=
 =?gb2312?B?anErTGFRL2M5OWdNb2NEQUc3TUFHaXlyT3B5dHE0WWVJR1dnQXVCRjB0MXFM?=
 =?gb2312?B?c3U4QjhXVm9UUUx5SnRVeHV6dVRwRmEra2VTWkRXSmRQYy94ZG1KeGJQck8y?=
 =?gb2312?B?TGo1Vm9CWk1PMjFPSUtEV2Y0ZXZBenJsUmNKMEZwV2hCcVRlRVJKQVZjakxh?=
 =?gb2312?B?TkFaTFQvU3Y2a2VYdU9UZ0ZWTCtmWXBjNzVuUnlaM0RsejJCNkRZSmNydGdJ?=
 =?gb2312?B?MEM0N2tLeVdwemtqTCtVbjRHTnJyTVN3UnJyVUtVVjkwZ3lWMmRMMVlLaHM1?=
 =?gb2312?B?dWFxWXJ1YXk1cm1ZQU9WMWN1RnhTRlVSamRmR2ZWd0YyVHlRQWpEWHcrcDVt?=
 =?gb2312?B?NXhXR2l5bmNhTDRNdS9KcVdFSlltdC8rZGVjL0JYZVozMHI0STJFTk82bmhK?=
 =?gb2312?B?c0U2V2M4VStwVmhEbzIxZEd0bnJzQnNKaGQyZEdEOGRvZzh2MUpHUXZZRFhX?=
 =?gb2312?B?c3RoeUczV2JXMFhJTmF6UENKKytLUzRvNVI2V2JNNXFCUmpkSEc0ZmU0M3Yz?=
 =?gb2312?B?dFl5emIvR2FFV0wzMFRpY3Z3elF5cHluTWxtWjl5U2dpeHBvTDRDdlNQdlR1?=
 =?gb2312?B?Z2Exb1owMlhmTUhZUlJVMWtCSE15NWZ5UnlUOXBoQjFtcmNJRW9yUUsrWmZp?=
 =?gb2312?B?R3hXWVQvdEVDRlVmZlFjZ1h5VnA4WmUzZzBvQzdzcnhBc2U4cVhDMmJxNS90?=
 =?gb2312?B?b1pzVFhUcHRVZXN2Z0FFbkp1bks2V1NWaStqYUxjZDY4UW1kYktwWHZhZE1F?=
 =?gb2312?B?V2g3Q1RlZklRQ3REUjBjRHl6ZXA1QzNsSFY2Z1VSWDRMRnp1d1Yybm9xeTZs?=
 =?gb2312?B?a3hSK2M5NGsrb1BjSHo4QnJxcWVXT2JvdHZsVkxEZ0J1RlRiQnJDTU00MlVq?=
 =?gb2312?B?d2hPRkxWKzFxMVhiT2VWZjg2aUJ1dzh6bEpoL3NZekh3dGJNTVE0TFVlcXRp?=
 =?gb2312?B?TnJwamphTERNOUFuMm4xOEtCL2xxbGhSMVBpTWEzUTQ2TGo0cUJhZS96UmRH?=
 =?gb2312?B?Q0kwU1VxeFlLU0pZbDEvNC9ObjJUWnRZNnhJNkxuWmp6ZisrZnZoeTduaGdQ?=
 =?gb2312?B?T3ZEMjZROFFuVjhqZVR2NEV0a3Y4clNmakVMZmphTFNScWtLUFo4ZldwalFz?=
 =?gb2312?B?aUI2NVNJaFpsc2sxaUUzZkxVMEpMR2R5dWJ0NUZabUFjMHRXL0x1WXNkT3Va?=
 =?gb2312?B?eFh3aVZMZGVQM0sySHNCWllQdjJ1NnkrS3JjRENWanFIdmpraVJoLzJMOEV4?=
 =?gb2312?B?QnorQmdxcHYyRlYxUXU2NTZzNGVXZkN4eGNpWGN2bHg3L0tEOUJhQjhIeGd2?=
 =?gb2312?B?Tjl1bHovOXZLWFRFdXY5czNySG80bmZRK1BNRThVWUJ1SmhtZXA2a1lLM2ZP?=
 =?gb2312?B?ZE8xQmdOanlyb2NHcWlyMm5Bb3NVcXVqN3hTS0JmdFlQeFNRakxOZ2t1UFMv?=
 =?gb2312?B?em9jbE92ZGIxQ2RyVURRMXdXbE1Ebk1ONmR6WFpveUpjelNkZVA2T3g2dzhr?=
 =?gb2312?B?cjJXU2lpa2srQ3UvVDRyN2VTc1N6eStlUHlrSG8vNUFWQTViVXBKZGIvekV3?=
 =?gb2312?B?QThuMFNlWG1MOG9JaElmTDI3MndVNFVWWUI1cGpsbURCVXF1NS9qNlNvaUJv?=
 =?gb2312?B?aXV2Vi81RGZnZXVFRjFCbG5kdS83cVFtUjdHWVlFZU5CbEMrMldjb3pLOFFO?=
 =?gb2312?B?TjJrVUo3SGhsRldpOW5rUGtBRUZTUmtFbWI3UkthblJ6aXlnSFpWNEVHVjgx?=
 =?gb2312?B?T0N3OWJuSytGZmNlT0xPZ0JaY3BiUFVQbHlieHByT1VZYmRwVmM2QUlIb2o1?=
 =?gb2312?B?OVE1bVpoMS9wQVZtQnVRN2h1L3VMQktlaWV6dVBMVmVQVUV1V29WTjNRUENr?=
 =?gb2312?Q?M+LTPQgCsdpdOPcvhwUQHhBFY?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e92188a-0a13-4937-6159-08da9f7e51de
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 05:16:51.4257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 17FTj5vvv1BDfyVJMC5/xu2aT8oP9C08zHXiYPDhSatD8U1oe8jEhFSXcmZSNGorv6W2tiDebAcO+ZFUNiWt/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jnUwjIzyNUgMjI6MDMNCj4gVG86IEhvbmd4
aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBsLnN0YWNoQHBlbmd1dHJvbml4
LmRlOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IGxvcmVuem8u
cGllcmFsaXNpQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7IGtpc2hvbkB0aS5jb207DQo+
IGt3QGxpbnV4LmNvbTsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBsaW51eC1wY2lAdmdl
ci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMDUvMTRdIGFybTY0OiBkdHM6IEFkZCBpTVg4
TU0gUENJZSBFUCBzdXBwb3J0DQo+IA0KPiBPbiBGcmksIFNlcCAyMywgMjAyMiBhdCAwMjowNjo1
MVBNICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiBBZGQgaU1YOE1NIFBDSWUgRVAgc3Vw
cG9ydC4NCj4gDQo+IEhhbGYgdGhlIHRpbWUgdGhpcyBpcyBzcGVsbGVkICJpLk1YLi4uIiBhbmQg
aGFsZiB0aGUgdGltZSBpdCdzICJpTVguLi4iICBQaWNrIG9uZQ0KPiBhbmQgdXNlIGl0IGNvbnNp
c3RlbnRseS4gIEkgdGhpbmsgImkuTVguLi4iIGlzIHJpZ2h0IGJlY2F1c2UgdGhhdCdzIHdoYXQg
SSBzZWUgb24NCj4gbnhwLmNvbSwgZS5nLiwNCj4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJv
dGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGd3d3Lm4NCj4geHAuY29tJTJG
cHJvZHVjdHMlMkZwcm9jZXNzb3JzLWFuZC1taWNyb2NvbnRyb2xsZXJzJTJGYXJtLXByb2Nlc3Nv
cnMlDQo+IDJGaS1teC1hcHBsaWNhdGlvbnMtcHJvY2Vzc29ycyUyRmktbXgtOC1wcm9jZXNzb3Jz
JTJGaS1teC04LWZhbWlseS1hcm0tY29yDQo+IHRleC1hNTMtY29ydGV4LWE3Mi12aXJ0dWFsaXph
dGlvbi12aXNpb24tM2QtZ3JhcGhpY3MtNGstdmlkZW8lM0FpLk1YOCZhbXA7DQo+IGRhdGE9MDUl
N0MwMSU3Q2hvbmd4aW5nLnpodSU0MG54cC5jb20lN0M1YjYzZjQzOThlMjc0NWViMWY2MDA4ZA0K
PiBhOWQ2YzUyODIlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdD
NjM3OTk1DQo+IDM4NTgyODQ3MDc3NyU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1D
NHdMakF3TURBaUxDSg0KPiBRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4w
JTNEJTdDMzAwMCU3QyU3QyU3QyZhbXANCj4gO3NkYXRhPWdlMmtidXFUMXdWT2JheXlHRUJsNVJR
ZzJhcG44ZktFc1h6WlI2Nmp6NlklM0QmYW1wO3Jlc2VydmUNCj4gZD0wDQo+IA0KPiBBbHNvIGFw
cGxpZXMgdG8gc2V2ZXJhbCBzdWJzZXF1ZW50IHBhdGNoZXMuDQpPa2F5LCB3b3VsZCBiZSBjaGFu
Z2VkIGxhdGVyLg0KVGhhbmtzLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gDQo+
IEJqb3JuDQo=
