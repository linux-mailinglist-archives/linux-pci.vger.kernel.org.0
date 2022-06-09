Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9245443A4
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 08:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238690AbiFIGRl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jun 2022 02:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbiFIGRj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 02:17:39 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80071.outbound.protection.outlook.com [40.107.8.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A101E82AB;
        Wed,  8 Jun 2022 23:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJe6ig0rrbTxBE6QBZj8rD1wUeEiaBzNOrJVetID9Xg9vKTn5HN+CXqUuWfdKUKanubBiIA353R0bX73jT2GZXSXT8jgu9I06TNdTjOugJOsGzk4OYTzuObTx+OOlwuDrGgyu51ZjBwr0/I8UOjokpyjIb6otKf4CEL+Z4o+K0tlpdpjkGc0MbGr5zE5LQ14WPRAgpd/Ef3FsuQtpLiXuYyGZjYMO03E7JLKIwgAbbdh9UmF9G6SIoHNbuFYuIL37ssVQ9YIqm6B9qrD6qkfEcO03YUz4qMBlPCCOrANP9/tCy+nDJ2QeZ05YwlpvTBkwzv9vWzV6OSniJJ0YOsYOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qWzEYA+lqyAgI3nvG6QPBrS1hWuBgzTo7imcEGXePs=;
 b=nzXFbPcPi2RHRSB6Q0Q2TWDL6nkGAgUwors/i0ptazF1Ys5x6jpJiNBCG+CHNlj1YooiaRuRcJ7ccV5HhX4Bit7uayFD9+LRZzr9njm/OOynpnxZn684IKrdHSrZ2om5FDCWExuiV7Qn0PiaUWAcb7OgZPNE57FUuVFtLb8PivG5hpJsLuOQw5JfNxfMbFyw/vkXwWVz5gzQsUtpm1rv451ONj/wggoFw5WlSMfdbqDAjGdIpgOr+vpPC+HP4sUmMoFFlbV1H8XJrQdpNgHbozn1DSRrqzKxXpaBxvj6fuY0XoY8HYD7hRPULTLWbrIzJ4YFBFeJN+GIdEYSWlM/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qWzEYA+lqyAgI3nvG6QPBrS1hWuBgzTo7imcEGXePs=;
 b=jbDNaHJzRRoFthHa7eFdIuw6yC+y0mcx1FsqULgvdfQqnVQFO71ze3oKCcjEDGqDTC+Sh5sCljfFZBPRdaF+Jb3GLl81G7UTt57zavaakycb6qkYlsPOCFByVYslxJWrR+prbaHwGmWstTLnFEpjmmepoGVx4a3gdg67cdHuhgQ=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB7702.eurprd04.prod.outlook.com (2603:10a6:20b:23f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 9 Jun
 2022 06:17:34 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::983c:b5ce:91b1:447e]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::983c:b5ce:91b1:447e%9]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 06:17:34 +0000
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
Subject: RE: [PATCH v9 5/8] PCI: imx6: Refine the regulator usage
Thread-Topic: [PATCH v9 5/8] PCI: imx6: Refine the regulator usage
Thread-Index: AQHYYOzgY7AYlEljsUCdTBhQfAYNj61FUGwAgAAKrlA=
Date:   Thu, 9 Jun 2022 06:17:34 +0000
Message-ID: <AS8PR04MB8676708D899DCE93F14A28DB8CA79@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1651801629-30223-1-git-send-email-hongxing.zhu@nxp.com>
         <1651801629-30223-6-git-send-email-hongxing.zhu@nxp.com>
 <2427cef355dc1b9d1667a2c80448d2e23b97c447.camel@pengutronix.de>
In-Reply-To: <2427cef355dc1b9d1667a2c80448d2e23b97c447.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8913393-3a3c-42c6-53ee-08da49dfbe1b
x-ms-traffictypediagnostic: AS8PR04MB7702:EE_
x-microsoft-antispam-prvs: <AS8PR04MB7702688F3B1DC58D66B96F1C8CA79@AS8PR04MB7702.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SjaDkjFfl+x+y/2zKC4xhv04zurZfNcLYp5Sy7VJXp3r6BabgLXwj1+eTF8+vjZS1v4wzA0/+aznObGKm8Iiu27LdStW4sNGpqs/Cwn6a9mCekYPsmnUOE7BLUCL2FCV+B9P2ozAHPUv/0RUYn6jjH8OlF3MlqyEowQGRiU07WCrpnsZGNROyEallBA69zZYdHgpp+eOFAOT7EHrAv860B1Mpaf88Gni7aq9LpGxBkdj3Dcx8YNrCmTOEib1kyMarto9jKy5EbEKBPVrVHo+SVQZwkEwTZdOohLS5n7pViE2MhQ5qqeTEMXOUGYfx38NYAUddLNlROELFxqIgzFvGt3Zq/sU36hmmjDGJPVq7Vs7z33CMxIPreq4+tplMixgxF5wPbRP0XfIxp5Juj3agzUDTWP7cbxRTjKDPLtSK0RB23/mgvTfCMDpFGn/cw8HWccgHgNNCP9nebc87hBJhh7XRsKP2Mko/RqRfbP6LqJuckFPG8uvGpC5EGpMW0U/JqTQW5wcjIIdK/5sy0v5hdlBVlwVZ0madq8rva0MnkOP+zj684k7x3u95Xe8OYL2OvIWaBjayBYV+AOwweGOkTNYaPvSLZcLC07lIM1jJIkCO23fL47XA7iMCPlITExG5Qlfl+if1TJHr7h7tE/N/b/w5OZOL0Zjd5xbqPWyfFJ1Uj8oC67j4Bu3eBFwiawePXCKEnZ6LI5nYBLsi2M24A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(86362001)(6506007)(26005)(33656002)(2906002)(44832011)(122000001)(53546011)(9686003)(7696005)(38070700005)(508600001)(83380400001)(55016003)(8936002)(76116006)(186003)(38100700002)(5660300002)(52536014)(8676002)(4326008)(110136005)(316002)(54906003)(64756008)(66446008)(66476007)(7416002)(66556008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGZpNHNmN0lyQmpUVVc1RytmOVlFL1VFbXpJelpNcEl2WDlJRWh6Qmxud2VS?=
 =?utf-8?B?eThiY09NTjAxMGE2NVVDRDR6cXpzb3BodHM0RjJUWGNHcG5pWHBqeERURkpQ?=
 =?utf-8?B?NFVURnkxMzQ3NEd6OUZRYmJoaTFqVGxsZ0ZjWEdrUVcwd0pBNW01RmhHWTQy?=
 =?utf-8?B?UTRJNDNMYzF4Yno2MElzd3ZTVkV0SDhBeEZMUkl2anVkNWZxNGtRMEdzaDI5?=
 =?utf-8?B?Y0NuWGNZUHkzTEMwRUN0cnJLblVqclgwSG1wbjY4MzNvUTN6MlVON1BEc1lo?=
 =?utf-8?B?R3R2b0JjWEUvMmFKcEplQllkbStYdUswTlVoeDU0WHBxYTN6a2gxSElUVTh1?=
 =?utf-8?B?YWZIWG1iY29SOUJleVZiWUE2U3ltbjJUYmlKc1FpbXRVbCtZZ2EwTWZGdlhk?=
 =?utf-8?B?SnZWK2Z3RzlqdXFqY3NzWEVFWW80RktnQytYd215bWtud0VialVNSEt1Y2RP?=
 =?utf-8?B?SEdrcFFUTHIzS2w1RUN5OTNjZWx6ZWhsUGduOFZnTitTNGtqa1NHVjFtbkkw?=
 =?utf-8?B?U0NyVW1GWVgreTB6bEJSOUVWYlNVdlhHcW1Oc24rd1RNQVNKTzA3NGY2SHkr?=
 =?utf-8?B?ck9jNFppTXBsTGZwR0FpYVZqQjRVNmhWZGZ3M1dEcnkwRHlLbzZ3UEZLTjNE?=
 =?utf-8?B?TlFoTFhZMDZKL0MvZ2lwekx0WnVoaFJoOWhEdmNKWWNpSERmR1ZqOFFlNktW?=
 =?utf-8?B?ci9FeldTWTJTOVZNdDFxWXd3OFN4RWdiQUgzaFArSHBaZmtnNDNSK2dyMlpp?=
 =?utf-8?B?WXJlcC9QZmFTN1UvamxhelhpM1ZhSGE5NE8zNHRCZ2RjbkpXR0dwa01kalc4?=
 =?utf-8?B?c3ZXc1NGRXNCb1pIUk9VZFptRzY2TGdHTEUwTEc1dFNhM3dETnE1amFWaWxz?=
 =?utf-8?B?L1pGMVdmQVlGVU5WWXhDY3kwQjZnbGtmakcwQ1ZmUzNoWUhkRklGMjBFc1A1?=
 =?utf-8?B?Nm53bHRPcWRvU3JTTUxaWGl5QXBYeTc1cUdzYVVEWWhYc05YYzdmK2tWTWc1?=
 =?utf-8?B?V0VSNUhGd3F3dmJRQnBzK3Nvd1FhVElLZVRWU2RmVGQvT0tHK1FiUHVTL0ZJ?=
 =?utf-8?B?Q0JYVU9RSEZvcFJoSnN2NUtYaXBPMko3M2o0VElCWGR2SkEyTlFEUm8xbUcz?=
 =?utf-8?B?eHZva1lHK0RFWG5QMjVlZmdJQStNV2dONHlTYnZLd2Q1RG5nT2JLUThCK0tC?=
 =?utf-8?B?T1Z1TVdkSHZ2c3RGaDAxNHdqNUo5NnFQY1RYSVIrVVp2Qi9BdER3SlRlZldv?=
 =?utf-8?B?SjBqS2lrRWpHSzJNVUlFdmtKakNaL29XVFlwSmdRQTltMFJKeEQrRHFDaXB2?=
 =?utf-8?B?UTBjMWFkRkhXMkoxbWYvZXpwbmxSS0RUYW04b3FYZFJzZFJwckpZYTVyVWZ0?=
 =?utf-8?B?TTRZd1VwK21sdjJuejVpWnpjNWJWeTgrZ3BJaXJmckR2ZytrR0FJVEVVbzEy?=
 =?utf-8?B?cUpsNnpvbnNWOTRVTTRhVy9vVkZFa3QwZ0xqMjdPckt1TnZwU2hqcWNuaXd2?=
 =?utf-8?B?bnF2WnBPNE42bWNFOC9SWmlUd2d6QmxwVzNEakxaMW1XVjlFYXgyQ1ZWYm9C?=
 =?utf-8?B?dEdtaFVIKzBaVGRFMGRiNkJXb0RkdHRvMGhGY2I4TG03eENJcC80ajluY2JV?=
 =?utf-8?B?UjRYWXdZVHFmZTY3T2dhbGsrT2VyT29naGc5NHN5Sm5PSlRTUmVWSUh1MG9B?=
 =?utf-8?B?UElEd1AwSmVGTTRSeTRQSXozYzdYQWJBdXRCQ0ttV3FrdEJubStsM0ZFSFk4?=
 =?utf-8?B?K3pjVTY4Y0pkanlEcDRHZEZzMXY2YS81TW9wWHRWdU1idWh2MEx0ZWNaTmta?=
 =?utf-8?B?NStTSDlWUk1iYkJoN3dZNUpRZXorWjJHWlI4cGxreE5ZRjJSWVRZcEhSSm5X?=
 =?utf-8?B?cUVZUnZROTZaOXFwc2N3Q21rUHZjd1dURzIrYWZLWklIMjBoaWpSc0N2TlFp?=
 =?utf-8?B?bVppN1pKWE55d1UvR2IwYTNMMlF6Z3FieDQreVF1SHpCbFhBazRjejAxRXVE?=
 =?utf-8?B?akVlZkdQc2t0ZEVScENocERWejRPbW8zbEh0a0RyYllwMWRCdVlPaGxKMlNV?=
 =?utf-8?B?TEsxS3F3ZDJMOXoxUHpSNDlrVEt0L0d2TEd5UDRsTXpuZ3l0YzVhY04rRVlk?=
 =?utf-8?B?cm9MOENFVWhlZTVqb0lRaGtSUnNjZTNQNGNEd1VlenBkWlhMdWJCYzVlZ2tm?=
 =?utf-8?B?bVp2cldrWVlVN2p3Z1VtK3NZYTBCMlZjWFRCUkdIdDZHNUJncFk1ZzhmcFpm?=
 =?utf-8?B?Slo2K3RuRGVGejlYaUNYT0NVQVhRaWlkOTRqc0ZIWmRBZ1JNQ2tBVlJuL2RO?=
 =?utf-8?B?ZDFEZmdTdjV0V1VXTjdYbHMyYXFkNjNYWmx4UW1RekpZNXlDc01Qdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8913393-3a3c-42c6-53ee-08da49dfbe1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 06:17:34.1874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mXUDes9KrOtFTrh0VKVThK2xsBezljp8H2+JDqkVzXx6C65Co5vIX4cmnWyXrE/2UFRN7pL2JZMltLqLOSS0/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7702
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
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMuW5tDbmnIg45pelIDE1OjI3DQo+IFRvOiBI
b25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsN
Cj4gcm9iaCtkdEBrZXJuZWwub3JnOyBicm9vbmllQGtlcm5lbC5vcmc7IGxvcmVuem8ucGllcmFs
aXNpQGFybS5jb207DQo+IGppbmdvb2hhbjFAZ21haWwuY29tOyBmZXN0ZXZhbUBnbWFpbC5jb207
DQo+IGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tDQo+IENjOiBsaW51eC1wY2lAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgt
aW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OSA1Lzhd
IFBDSTogaW14NjogUmVmaW5lIHRoZSByZWd1bGF0b3IgdXNhZ2UNCj4gDQo+IEFtIEZyZWl0YWcs
IGRlbSAwNi4wNS4yMDIyIHVtIDA5OjQ3ICswODAwIHNjaHJpZWIgUmljaGFyZCBaaHU6DQo+ID4g
VGhlIGRyaXZlciBzaG91bGQgdW5kbyBhbnkgZW5hYmxlcyBpdCBkaWQgaXRzZWxmLiBUaGUgcmVn
dWxhdG9yDQo+ID4gZGlzYWJsZSBzaG91bGRuJ3QgYmUgYmFzaW5nIGRlY2lzaW9ucyBvbiByZWd1
bGF0b3JfaXNfZW5hYmxlZCgpLg0KPiA+DQo+ID4gVG8ga2VlcCB0aGUgYmFsYW5jZSBvZiB0aGUg
cmVndWxhdG9yIHVzYWdlIGNvdW50ZXIsIGRpc2FibGUgdGhlDQo+ID4gcmVndWxhdG9yIGp1c3Qg
YmVoaW5kIG9mIGlteDZfcGNpZV9hc3NlcnRfY29yZV9yZXNldCgpIGluIHJlc3VtZSBhbmQNCj4g
c2h1dGRvd24uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcu
emh1QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aS1pbXg2LmMgfCAxOSArKysrKysrLS0tLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3
IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBiL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBpbmRleCA3MDA1YTc5MTAwMDMuLjNjZTM5OTNk
NTc5NyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14
Ni5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+
IEBAIC0zNjksOCArMzY5LDYgQEAgc3RhdGljIGludCBpbXg2X3BjaWVfYXR0YWNoX3BkKHN0cnVj
dCBkZXZpY2UgKmRldikNCj4gPg0KPiA+ICBzdGF0aWMgdm9pZCBpbXg2X3BjaWVfYXNzZXJ0X2Nv
cmVfcmVzZXQoc3RydWN0IGlteDZfcGNpZSAqaW14Nl9wY2llKQ0KPiA+IHsNCj4gPiAtCXN0cnVj
dCBkZXZpY2UgKmRldiA9IGlteDZfcGNpZS0+cGNpLT5kZXY7DQo+ID4gLQ0KPiA+ICAJc3dpdGNo
IChpbXg2X3BjaWUtPmRydmRhdGEtPnZhcmlhbnQpIHsNCj4gPiAgCWNhc2UgSU1YN0Q6DQo+ID4g
IAljYXNlIElNWDhNUToNCj4gPiBAQCAtNDAwLDE0ICszOTgsNiBAQCBzdGF0aWMgdm9pZCBpbXg2
X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQoc3RydWN0DQo+IGlteDZfcGNpZSAqaW14Nl9wY2llKQ0K
PiA+ICAJCQkJICAgSU1YNlFfR1BSMV9QQ0lFX1JFRl9DTEtfRU4sIDAgPDwgMTYpOw0KPiA+ICAJ
CWJyZWFrOw0KPiA+ICAJfQ0KPiA+IC0NCj4gPiAtCWlmIChpbXg2X3BjaWUtPnZwY2llICYmIHJl
Z3VsYXRvcl9pc19lbmFibGVkKGlteDZfcGNpZS0+dnBjaWUpID4gMCkgew0KPiA+IC0JCWludCBy
ZXQgPSByZWd1bGF0b3JfZGlzYWJsZShpbXg2X3BjaWUtPnZwY2llKTsNCj4gPiAtDQo+ID4gLQkJ
aWYgKHJldCkNCj4gPiAtCQkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gZGlzYWJsZSB2cGNpZSBy
ZWd1bGF0b3I6ICVkXG4iLA0KPiA+IC0JCQkJcmV0KTsNCj4gPiAtCX0NCj4gPiAgfQ0KPiA+DQo+
ID4gIHN0YXRpYyB1bnNpZ25lZCBpbnQgaW14Nl9wY2llX2dycF9vZmZzZXQoY29uc3Qgc3RydWN0
IGlteDZfcGNpZQ0KPiA+ICppbXg2X3BjaWUpIEBAIC01ODAsNyArNTcwLDcgQEAgc3RhdGljIGlu
dA0KPiBpbXg2X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNldChzdHJ1Y3QgaW14Nl9wY2llICppbXg2
X3BjaWUpDQo+ID4gIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBwY2ktPmRldjsNCj4gPiAgCWludCBy
ZXQsIGVycjsNCj4gPg0KPiA+IC0JaWYgKGlteDZfcGNpZS0+dnBjaWUgJiYgIXJlZ3VsYXRvcl9p
c19lbmFibGVkKGlteDZfcGNpZS0+dnBjaWUpKSB7DQo+ID4gKwlpZiAoaW14Nl9wY2llLT52cGNp
ZSkgew0KPiA+ICAJCXJldCA9IHJlZ3VsYXRvcl9lbmFibGUoaW14Nl9wY2llLT52cGNpZSk7DQo+
ID4gIAkJaWYgKHJldCkgew0KPiA+ICAJCQlkZXZfZXJyKGRldiwgImZhaWxlZCB0byBlbmFibGUg
dnBjaWUgcmVndWxhdG9yOiAlZFxuIiwgQEANCj4gLTY1Myw3DQo+ID4gKzY0Myw3IEBAIHN0YXRp
YyBpbnQgaW14Nl9wY2llX2RlYXNzZXJ0X2NvcmVfcmVzZXQoc3RydWN0IGlteDZfcGNpZQ0KPiAq
aW14Nl9wY2llKQ0KPiA+ICAJcmV0dXJuIDA7DQo+ID4NCj4gPiAgZXJyX2Nsa3M6DQo+ID4gLQlp
ZiAoaW14Nl9wY2llLT52cGNpZSAmJiByZWd1bGF0b3JfaXNfZW5hYmxlZChpbXg2X3BjaWUtPnZw
Y2llKSA+IDApIHsNCj4gPiArCWlmIChpbXg2X3BjaWUtPnZwY2llKSB7DQo+ID4gIAkJcmV0ID0g
cmVndWxhdG9yX2Rpc2FibGUoaW14Nl9wY2llLT52cGNpZSk7DQo+ID4gIAkJaWYgKHJldCkNCj4g
PiAgCQkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gZGlzYWJsZSB2cGNpZSByZWd1bGF0b3I6ICVk
XG4iLCBAQA0KPiAtMTAyNiw2DQo+ID4gKzEwMTYsOSBAQCBzdGF0aWMgaW50IGlteDZfcGNpZV9y
ZXN1bWVfbm9pcnEoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICAJCXJldHVybiAwOw0KPiA+DQo+
ID4gIAlpbXg2X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQoaW14Nl9wY2llKTsNCj4gPiArCWlmIChp
bXg2X3BjaWUtPnZwY2llKQ0KPiA+ICsJCXJlZ3VsYXRvcl9kaXNhYmxlKGlteDZfcGNpZS0+dnBj
aWUpOw0KPiA+ICsNCj4gVGhpcyBvbmUgbG9va3MgbWlzcGxhY2VkLiBTdXJlbHkgeW91IHdhbnQg
dGhlIHJlZ3VsYXRvciB0byBiZSBvbiB3aGVuDQo+IHJlc3VtaW5nIHRoZSBQQ0llIHN1YnN5c3Rl
bS4gSXNuJ3QgdGhpcyBqdXN0IHBhcGVyaW5nIG92ZXIgYSB3cm9uZyB1c2FnZSBjb3VudA0KPiBo
ZXJlLCBiZWNhdXNlIHRoZXJlIGlzIG5vIHJlZ3VsYXRvcl9kaXNhYmxlIGluIGlteDZfcGNpZV9z
dXNwZW5kX25vaXJxLA0KPiB3aGVyZSBJIHdvdWxkIGV4cGVjdCB0aGlzIHRvIGhhcHBlbj8NCj4g
DQpIaSBMdWNhczoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4NClRoZXJlIHdhcyBvbmUgcmVn
dWxhdG9yX2Rpc2FibGUoKSBvcGVyYXRpb24gYXQgdGhlIGVuZCBvZiB0aGUNCiBpbXg2X3BjaWVf
YXNzZXJ0X2NvcmVfcmVzZXQoKSBmdW5jdGlvbiBiZWZvcmUuDQpXaGVuIGNyZWF0ZSB0aGUgNS84
IHBhdGNoLCBJIGZvbGxvdyB0aGUgc2FtZSBiZWhhdmlvciB0byBkaXNhYmxlIHRoZQ0KcmVndWxh
dG9yIGp1c3QgYmVoaW5kIHRoZSBpbXg2X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQoKSBmdW5jdGlv
bi4NCg0KWWVzLCBpdCBpcy4gSW14Nl9wY2llX3N1c3BlbmRfbm9pcnEgZG9lc24ndCBoYXZlIHRo
ZSByZWd1bGF0b3JfZGlzYWJsZS4NClRoZSByZWd1bGFvcl9lbmFibGUgaXMgY29udGFpbmVkIGlu
IGlteDZfcGNpZV9kZWFzc2VydF9jb3JlX3Jlc2V0KCkuDQpCb3RoIG9mIHRoZSByZWd1bGF0b3Jf
ZGlzYWJsZSBhbmQgcmVndWxhdG9yX2VuYWJlIGFyZSBpbnZva2VkIG9uY2UgaW4NCiBpbXg2X3Bj
aWVfcmVzdW1lX25vaXJxLg0KU28sIHRoZSByZWd1bGF0b3IgaXMgb24gYW5kIGhhcyBhIGJhbGFu
Y2VkIHVzYWdlIGNvdW50IGFmdGVyIHJlc3VtZS4NCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUN
Cg0KPiBSZWdhcmRzLA0KPiBMdWNhcw0KPiANCj4gPiAgCWlteDZfcGNpZV9pbml0X3BoeShpbXg2
X3BjaWUpOw0KPiA+ICAJaW14Nl9wY2llX2RlYXNzZXJ0X2NvcmVfcmVzZXQoaW14Nl9wY2llKTsN
Cj4gPiAgCWR3X3BjaWVfc2V0dXBfcmMocHApOw0KPiA+IEBAIC0xMjU5LDYgKzEyNTIsOCBAQCBz
dGF0aWMgdm9pZCBpbXg2X3BjaWVfc2h1dGRvd24oc3RydWN0DQo+ID4gcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KPiA+DQo+ID4gIAkvKiBicmluZyBkb3duIGxpbmssIHNvIGJvb3Rsb2FkZXIgZ2V0
cyBjbGVhbiBzdGF0ZSBpbiBjYXNlIG9mIHJlYm9vdCAqLw0KPiA+ICAJaW14Nl9wY2llX2Fzc2Vy
dF9jb3JlX3Jlc2V0KGlteDZfcGNpZSk7DQo+ID4gKwlpZiAoaW14Nl9wY2llLT52cGNpZSkNCj4g
PiArCQlyZWd1bGF0b3JfZGlzYWJsZShpbXg2X3BjaWUtPnZwY2llKTsNCj4gPiAgfQ0KPiA+DQo+
ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaW14Nl9wY2llX2RydmRhdGEgZHJ2ZGF0YVtdID0gew0K
PiANCg0K
