Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45325502642
	for <lists+linux-pci@lfdr.de>; Fri, 15 Apr 2022 09:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbiDOHfV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Apr 2022 03:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350272AbiDOHfU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Apr 2022 03:35:20 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70084.outbound.protection.outlook.com [40.107.7.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48DAA0BE4;
        Fri, 15 Apr 2022 00:32:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+Zr0ux54HSm+9HD8jQlCHKhLkMVJ77E3/lkfsSigCbSIe4DoIko3xyj7N+bb9Wo0A2CQL13up931LAPk5bhtKId28THF53Zw16QWuwP6wYfej0kTRhVQzW2Y23usOoUY2vThB5YUsTk/ilcyBPCmgvJl+BTP/qdW4j3TrSks0la53pcTdZw/LtnvZqGI6h1oSZHmBqqM2fLoGOdMO/1JxkAVic9ncp3uHU+8DOE/nSo9DtOm7Iehmueg7HEwKYKNIpXm6jnrgR4po7NpNYaeaY/2IfhE/RgUrbRyl0aJxSFKp+mbA4I4ev7rqf6CHLI4BNWif8XMSsaXX5PThsMeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Nb5F+KysDCin0TYu7LuGCAQI2kHds98rr10XpvnEgE=;
 b=hPq8RSl0kY0PauD7l9qvwOIcgWcJcRdS/SIMnZ2lAA+N7k3lzxVBAd3DQ6gInbbMTcPYhNHdF4qmYNay0z4EVhjl5NJkLZzlwKFgBASOrfuppIL1Q2DPm7sLFpAAhyJa8h3K5hymyTa4Lf9gp/HzipzcD+icbBlqLcaFgtK+GZIOmYj3850WLY09+kJ7O8tc+beEt9RFlQ9dQCpAWu47AuAtPa7YcngPjsgluT6oBrwVrqNS0KrpvOW/syAL+thazmEyMo5YGYAumfvJpESCBhUCYQA7buHaL50cS46ksst/8y8mlmnQMIOsU8787YTAegVs/2zLbtdBjDi3QMy5Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Nb5F+KysDCin0TYu7LuGCAQI2kHds98rr10XpvnEgE=;
 b=LSn4Kvtb2xcfdXSuBBxFu6Q/Jc0OEh5RTqDta+Iwf7/t6yqBFJd2BtLzwYVO1XXZx3SxvirRQiQfJyJ5CdxKj5mrPqrKod9H+Nnz0wJpmM0WSY2lr5WYopXpKEl2xDGKLZ22517NhX+kQOq9wvVe5tq5n5acaJKCZZ41RiyILOQ=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM0PR04MB6690.eurprd04.prod.outlook.com (2603:10a6:208:16a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Fri, 15 Apr
 2022 07:32:49 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::ecea:cb09:5ff2:1800]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::ecea:cb09:5ff2:1800%5]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 07:32:49 +0000
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
Thread-Index: AQHYMgQKvQY38d7zYkCsN9Iw8VH+Qqzfqj4AgBDL2gA=
Date:   Fri, 15 Apr 2022 07:32:49 +0000
Message-ID: <AS8PR04MB867672DB83F2B6EEA206E45C8CEE9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1646644054-24421-1-git-send-email-hongxing.zhu@nxp.com>
         <1646644054-24421-2-git-send-email-hongxing.zhu@nxp.com>
 <c967e6bdb586c273c187e4892b03aa82064af4ab.camel@pengutronix.de>
In-Reply-To: <c967e6bdb586c273c187e4892b03aa82064af4ab.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 090cc74c-547d-48ac-2e53-08da1eb224c3
x-ms-traffictypediagnostic: AM0PR04MB6690:EE_
x-microsoft-antispam-prvs: <AM0PR04MB66904E05210AD11B2EFC87768CEE9@AM0PR04MB6690.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UME2g2kVTa/F6IWukdqGQ3jViGk6ezrEWUcWxWRXw7rMa/3kYPDCKiczrPyZHHJwOWJIqlMZ+6SqZOYVN+VyUsjP+G+65wkI/RsEUiU4Jz7Xd3A80qIDPZhHHQFlSLUqYHahccEvDVeqUs052KL9EyeBofZt6/g5C/cuc+ZJ+WlNEiDl9jxJmD/jZPnBkUSt2DZHZUiYdgTIo1s3kLpcW33XWq9tsnJEJ79MH4pFQUFH6xkj2BpxLhjjZPsYlwYNnwtWYDX7sfdZBJUbO0Dtmj3MRrQuecWfhkJ2yauMzaqputDeozvGf5RfFq62NT+zpZkFIgH6nwsbrXui2Z1kxCnbe3a5PvTUwh00PNAp3ukTTdlFC+oEZv7J2trMhwv3C3CXle0HNyCa53bk5R22yFCnCP9xuVw3gKy3PLJzM56l53PgR5t8OwnJ74Jo4fSrbriPwgVmG7cZZ8Vv5ErUNQ1OWowKtA2Rn2TtZuBIFiimWYJf05F0DBvpSRV3qRnw36r8VXfujqK/zIoYQWNAbpohF6+ON8Y5AwNcBwWgWjmpQ4qVdEdwVeiL0jvIxq1IRj4ieAFS9Nz3nweCCN6AnbvedhQqQ+dx40bGtoRanXChk97oYWTmQO5Ks0PVYMUzXR+ZNYsSHe7koMd80zGkFhNWIZc6/ZquhBIXD+erMnKvEi2WLlb12TchIK9QndaMSPNefXqgPC4Ej1Y2WSaL0SivO3Nu0Bpofb7xfiFnIqU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(2906002)(64756008)(66556008)(6506007)(9686003)(5660300002)(44832011)(316002)(71200400001)(33656002)(52536014)(38070700005)(26005)(86362001)(66476007)(66946007)(76116006)(53546011)(7416002)(38100700002)(4326008)(7696005)(8936002)(110136005)(54906003)(55016003)(508600001)(83380400001)(122000001)(8676002)(66446008)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3diVkVUc05aZWhzN3F5QTNpb2FPRXJCYkZQcy9BUDJIKzQ4SFNmcWhhcFZm?=
 =?utf-8?B?Q3F6UGhZQm93MjNBT0hnbFY0SW5OUUxDalRvY2FxTGxGWG5WZVZ3ZzV4RlR5?=
 =?utf-8?B?NHRtZXNyR0JRUk81Q2d1RUZRSHhxLyszTFZWTi9DVzQ4Q01vd3l6K0N0WUJU?=
 =?utf-8?B?Sm1BQUpRV1J3SnkvNXF5aE1GVzJFbDFYNXN3OXJNYkVvc0pOc2Q0MjIrazFj?=
 =?utf-8?B?aUQ1UGxBTWw2OWNab1pzRG0xZVJXQTcrbmlvV0NMOCtUR0dKVldpK2F4WnR6?=
 =?utf-8?B?aUgzVDdaQ0ErZVFOTFNuMm1DaDNtRDZLQXhsVlJPcitZMHp5UVlEcXEvclRD?=
 =?utf-8?B?WVhtTm5UVm5nWUZxd3RhaUVOa3A0TW9XRTZiK3Y0UzhSWHF2WUZlbFg4K0Yw?=
 =?utf-8?B?a3hwVnk0MDd5RGNkaDJuV3diajZxZmJvaHpCMDk4ZmpsR1pld1luajNVNjRv?=
 =?utf-8?B?Lys3STNvejd3TTlpcUxoRjhlT2FySGluM1dGaTRuSGdsTzBuYVhQSHpLOFM5?=
 =?utf-8?B?NjNpWjd4VVRnSFl1ZTFHcDRJQ3Z1TGZBQll4bVpRR0JOUnY0MVBFTlo5NlJr?=
 =?utf-8?B?TVB0UU0zTmdKTk1jQU5pd0Y1dUlmWEs2RGRGTnJlRS9iRTUrdXI4ZWtuRHR1?=
 =?utf-8?B?UjVKeTBxNG1aSVRDMUtveHhyYVUwazdQS3R1N2Z5VEh2SG1jKzNYSTNzRXNT?=
 =?utf-8?B?L1VVTDQ3a1k5NzVoUWIxaHpMUlVuQlZ6R280b3NrZmU2eStvTHFKOU5hTnla?=
 =?utf-8?B?Z0JYd3RjMTBheVVDVnpGbVlySzJxZWJzMVNheXZES2Y2YzExM3YvV3BHeGJl?=
 =?utf-8?B?SXVVU0FwRThNNXlaN3IwWi94RXhEZGVCb1ZPUkNDa3FEVHZ1ci93MDM5RWdS?=
 =?utf-8?B?MEZORlZ3OEsrNjZJZTJiYm5ZR3NqdFV0TnlaTUcwcHRVZVFZb3padDJSWFhB?=
 =?utf-8?B?ZFpIc1ZicC9tUWtkVnF4QVJxTWFQaUF2U295clFUSFNxMWNMMEFzcWtxSXE4?=
 =?utf-8?B?RzZzaUtUZzVheTlrSytVdGVkd1h4THhITU1JUjBUQjBsOGg5R0xGYitEWWpv?=
 =?utf-8?B?ZUF5RlZGZ25NQ2srblZEbnRZR2NrN2dKRk5ONDdiNzZoNlFJVHFOYjJZZzI1?=
 =?utf-8?B?RzNJeGtGY2xERVRHYzN3RjFhMHFveXkzYUxRaEVSQzU3aFFFUXJabEZEVnVm?=
 =?utf-8?B?V2srb1dGZlAyWUpOVFdnYW5qcGVsaTRXYnh6bGRzanRCd2hFVlc5MVcrajZF?=
 =?utf-8?B?TmlrUXlNTENFanFld2cwbllacHdnWHAweURuTGxOMmZiM3Vqa2tzdU5WOUxz?=
 =?utf-8?B?NWgzWlZBcUI2NStmbndQMDlMNWRzODRaWDhvTFBYNGNPbTJGbGFqdlREUnU5?=
 =?utf-8?B?amNnN2R6YWtrbGZua3JZWjBJZW1mK3NUSXhIQnU3QldUYitreGZmTisyTHNL?=
 =?utf-8?B?UmFIc2NRWlFMeHRCbmQ4WXY2Rk9UeE1jcE9XY3ZSRHlFdUpCaUdTYlcvYTVW?=
 =?utf-8?B?VEMxQVJhRWxLNWNKbzBhMmMyQU9hZXFiUGdDWEwybk5DaUYyb2ZPcEgzV0sw?=
 =?utf-8?B?OGhPcGE3c3c0akt5ZnptL1VKVnNEMGFmL2l3QjJPSG9walBkYWZBaXo1UjZC?=
 =?utf-8?B?bmIvbjhjRjg1VlRseUh3Q0ovQ3E5UEJRUkVrWDdjZzU5QzVybzBZeUhyM2hL?=
 =?utf-8?B?bFhVOU1ncG5OY29RZG8yWDlhRDF0SjZiV1lQL2Q0NHlPbnJyRDA0ZmkzUlRi?=
 =?utf-8?B?NERXeVB4cmtLSHArRXFQd2VkSFBpUzFtTnRLakI3Zk9QV1lOVVpXdEhldHdk?=
 =?utf-8?B?K1VaUm1DL2Q0ZzY5MWVtd1VYNkdmUm56Q0RBQzJBM3VFS2ZDYW9OU2VmU29k?=
 =?utf-8?B?ZWM4b1VodGlleU1WYTlobWVSbDA2VmtLbDJhblpFOU03VUZMWEVQcVFibG51?=
 =?utf-8?B?UTNpNFpSZGNKZnhpMklLb2VwUFZCcW5zb0tsdDRlNlFyanEyUERXb3lJellQ?=
 =?utf-8?B?ZG5JSUtTamtXSUlVZEZPVmt6c1cxMmRQRDBmb0grcFlJODdEZDlvRHNhNitu?=
 =?utf-8?B?NHNycWgvUFFnRGhFc3Y5SyszTlMwMWZ6R0E5SUpjTEYwK3lDMzdsWFdBNkND?=
 =?utf-8?B?cFNpZWxzVk56VkJNUTY5U1F4V1RPdDB5b0twZ1ozb1E1alJHSGhuenY1TTE2?=
 =?utf-8?B?UENqN05ya2hzempyYTc1aG9YTGZOa0NIMkhCcEs4Mk9jbXhmZmlGM1BSTjZr?=
 =?utf-8?B?QjM5M2NHeWJuZ3IxTXhOSnd3K2ZPMkVqbyttWnIybzYxYkdhdkY0RmtHbWRs?=
 =?utf-8?B?TzJtMVAybXFacUEvUVZ6YXQwMWlRUUczUEUvQzE5UzFxeDgxeWUyQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 090cc74c-547d-48ac-2e53-08da1eb224c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 07:32:49.5504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ulBA1iRQlrsc6J8XJHtdoySVIKiZ7yxf5NIQ/gtrOQPeWDbPGOW9SR5pfVhoXMaqYMuKCoZ9B9+tz41vWJZShw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6690
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUGhpbGlwcDoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQaGls
aXBwIFphYmVsIDxwLnphYmVsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyMDIy5bm0NOaciDTm
l6UgMTc6MzQNCj4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBsLnN0
YWNoQHBlbmd1dHJvbml4LmRlOw0KPiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBsb3JlbnpvLnBpZXJh
bGlzaUBhcm0uY29tOyByb2JoQGtlcm5lbC5vcmc7DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHZr
b3VsQGtlcm5lbC5vcmc7IGFsZXhhbmRlci5zdGVpbkBldy50cS1ncm91cC5jb20NCj4gQ2M6IGxp
bnV4LXBoeUBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsN
Cj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBrZXJuZWxAcGVuZ3V0
cm9uaXguZGU7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjIgMS83XSByZXNldDogaW14NzogQWRkIHRoZSBpTVg4TVAgUENJZSBQSFkg
UEVSU1QNCj4gc3VwcG9ydA0KPiANCj4gSGkgUmljaGFyZCwNCj4gDQo+IE9uIE1vLCAyMDIyLTAz
LTA3IGF0IDE3OjA3ICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiBBZGQgdGhlIGkuTVg4
TVAgUENJZSBQSFkgUEVSU1Qgc3VwcG9ydC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hh
cmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiDCoGRyaXZlcnMvcmVz
ZXQvcmVzZXQtaW14Ny5jIHwgMSArDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Jlc2V0L3Jlc2V0LWlteDcuYyBiL2Ry
aXZlcnMvcmVzZXQvcmVzZXQtaW14Ny5jDQo+ID4gaW5kZXggMTg1YTMzM2RmNjZjLi5kMjQwODcy
NWViMmMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9yZXNldC9yZXNldC1pbXg3LmMNCj4gPiAr
KysgYi9kcml2ZXJzL3Jlc2V0L3Jlc2V0LWlteDcuYw0KPiA+IEBAIC0zMjksNiArMzI5LDcgQEAg
c3RhdGljIGludCBpbXg4bXBfcmVzZXRfc2V0KHN0cnVjdA0KPiA+IHJlc2V0X2NvbnRyb2xsZXJf
ZGV2ICpyY2RldiwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOw0K
PiA+DQo+ID4gwqDCoMKgwqDCoMKgwqDCoGNhc2UgSU1YOE1QX1JFU0VUX1BDSUVfQ1RSTF9BUFBT
X0VOOg0KPiA+ICvCoMKgwqDCoMKgwqDCoGNhc2UgSU1YOE1QX1JFU0VUX1BDSUVQSFlfUEVSU1Q6
DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB2YWx1ZSA9IGFzc2VydCA/IDAg
OiBiaXQ7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBicmVhazsNCj4gPiDC
oMKgwqDCoMKgwqDCoMKgfQ0KPiANCj4gVGhpcyBkb2Vzbid0IGRvIHdoYXQgdGhlIGNvbW1pdCBk
ZXNjcmlwdGlvbiBzYXlzLg0KPiANCj4gVGhlIFBDSUVQSFlfUEVSU1QgYml0IGlzIGFscmVhZHkg
c3VwcG9ydGVkIGJ5IHRoZSBkcml2ZXIgKGFsYmVpdA0KPiBpbmNvcnJlY3RseT8pIC0gdGhpcyBw
YXRjaCBqdXN0IGludmVydHMgdGhlIGJpdC4NCj4gDQo+IFNpbmNlIHRoaXMgYml0IGlzIG5vdCBp
bnZlcnRlZCBvbiB0aGUgb3RoZXIgcGxhdGZvcm1zLCBhbmTCoHRoZSBpLk1YOE1QDQo+IHJlZmVy
ZW5jZSBtYW51YWwgc2F5cyBub3RoaW5nIGFib3V0IHRoaXMsIHBsZWFzZSBleHBsaWNpdGx5IHN0
YXRlIHdoeSB0aGlzDQo+IG5lZWRzIHRvIGJlIGludmVydGVkIGFuZCBjYWxsIGl0IGEgZml4IGlu
IHRoZSBjb21taXQgZGVzY3JpcHRpb24uDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMsIGFuZCBz
b3JyeSBmb3IgcmVwbHlpbmcgbGF0ZS4NCkkgZGlkbid0IGdldCBtb3JlIGRldGFpbHMgYWJvdXQg
dGhpcyBiaXQgZGlmZmVyZW5jZSBiZXR3ZWVuIGkuTVg4TVAgYW5kIG90aGVycy4NCkxldCBtZSBj
b25zdWx0IHdpdGggZGVzaWduIHRlYW0gYWdhaW4sIGFuZCBiYWNrIHRvIHlvdSBsYXRlci4NCg0K
QmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+IA0KPiByZWdhcmRzDQo+IFBoaWxpcHANCg==
