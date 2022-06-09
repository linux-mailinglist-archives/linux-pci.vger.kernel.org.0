Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC495443BB
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 08:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238739AbiFIGUZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jun 2022 02:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiFIGUV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 02:20:21 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80087.outbound.protection.outlook.com [40.107.8.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727C23EF37;
        Wed,  8 Jun 2022 23:20:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YULncEJX6zh9XQF1NXtNkfTdK/QwrMj+hYsjA1eFUtN9ycZzEmlt/kaYWGor/O6IcdPb0U8rqvA8ByapPAoOUGJB7RczpAE509pqkbg3bSNFO30UBjPvCbZ/J5mgiIq1UoQOlFCRK4JHDXV4ajAkPmwpHlkJ/5p6ltXwKM1g8RYTu20/oa11UXc59t8o1BADMbCMqDYnpYldeNCEY13YVh+hZYGNmOiHNQ5u3wxvo8ZzIHZ5Gu30NWmKCnALpKsKCbWvNKJ36XNifJV5JyYcW1OHqCF6/uAQcReyyaD3w2a/8HPtR+4gaD8EJW8jzy5XfqDcMMwu6oczR6e7NC6lMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZBHW6olC88sMB2YN4W+tk4ZL4mfOyA5f8vhb2aAMro=;
 b=Z1VW7oAbdF50eHlHfHHr1eN392SQpt+rxxFxZdknUH9D8B17HBLKILh7DrB3YxONpy6UkOFoa1sDAyrGAY+VXQgdsUtBnXqp481rsypV62VCwuW/amk46Vy8wJKA1gscFxqJdfosDHVPVl1NPd0rM32bNIM/WpPNQy6yoFc+Vri4C0di7CHIjK5rOMrXWNvfqLbCDMOTRO8lRyDlBccKXSE/KRPZVncvCw7MdMFM+J7StJVCFT9yGLrtkaVehSEWFi3JAd35mNxzGaGs3cCJLrkbQ6yGFWZHika/ZHyTt9W/81PWpNCX9lWTZUY1+xwq+m00Ctl7zbW1LRHRaJJVHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZBHW6olC88sMB2YN4W+tk4ZL4mfOyA5f8vhb2aAMro=;
 b=OH1AXnIiVUH+aRDQV4ntfyxlgFPrkpvV6sZ++IqfxZrNkO4Q478dj/ueDOreIzzqvW4Jy0Lb4Y8z+DNc2ZwPkUW4GG88pLU6mkA4j6+TPILxM3bzjqrm6UHtaF5TblKxjXmKeSraYHgzk75UkQw/+ggEGFrDr+6Kryc1Lsvoho0=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR0402MB2736.eurprd04.prod.outlook.com (2603:10a6:800:b1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 9 Jun
 2022 06:20:16 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::983c:b5ce:91b1:447e]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::983c:b5ce:91b1:447e%9]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 06:20:16 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
Subject: RE: [PATCH v9 7/8] PCI: imx6: Move the phy driver callbacks to the
 proper places
Thread-Topic: [PATCH v9 7/8] PCI: imx6: Move the phy driver callbacks to the
 proper places
Thread-Index: AQHYYOzlA5pwlzpYQUSX/QC6T/qeLK1GEXcAgACKSxA=
Date:   Thu, 9 Jun 2022 06:20:16 +0000
Message-ID: <AS8PR04MB86768DB1E04AAE3D63E8BE618CA79@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1651801629-30223-8-git-send-email-hongxing.zhu@nxp.com>
 <20220608185754.GA411026@bhelgaas>
In-Reply-To: <20220608185754.GA411026@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7de462f6-0b24-4506-13b6-08da49e01ea8
x-ms-traffictypediagnostic: VI1PR0402MB2736:EE_
x-microsoft-antispam-prvs: <VI1PR0402MB27365636BBE1686FD5A629FF8CA79@VI1PR0402MB2736.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LHkVbFwo0JWFQEdEU+46SdM1aOQLweExmCPhEItTBGrI5Z92ywuuoD0/KXnP8YyZugXUsWFeDHnt0aA/Dr/NvZ3479xHysZBQ2Utmnod8DQia68YrMdOfcboFVQKPugZ23BYZFBTxbKousZkCpq6v7p2R33nnBGx+KhLfyEQuTKGhPiwHFNhERTRK+DsDaO1wm7kCg/PzXsdx79rFbuhpJBN1MAEZl52VLhy9sDltWdXpuF4AqrOf4DnuFclFnX/sw7peVZiYZ+H02jeN8U6TbeAub2usCr6t4lIua5VnS+4PbRHsrTQmiha6I3QcV5aX61cOJyVosptJMtAqKhyDkcObj/yIElPIdBQObF3Ac5XNqhWzArCzCQyUxEBvEmbWUtzlMadzslRH+Dg2BPOa8pnofU1bgt5jB8rgS1hYdDKaMi6bmO4kZCNUbHONbwTidRj8U4ucZnZIKYBBdE77dIVYEt/oE+lIOxqfF6E+sge1SqpKDZbhZhJNL0/8UKguUz1InRjZwbq0bWCi/5ceUfGcWUPVFRPRCoe6c/V1k72oSb7Li+7S7bnlvy6W08cxpYux3MXjVGObAFetlivtZLoYJ6jj1JrF/gGrPiWF71COL0AxzVwOwNkOV+KU5SVUmOyBpg7LN2A4MIaiDh2PFVj1XkbYGZa1sz5uE3wK8X/lQyYd0khs1MT1ViEhc7V6oEwG9jYfGSIMCBZVC02+M7eoOvsmARQ2AO3sZSCtLbulguaZv/0+nWydHe6Ot2w0L6/MA+xABAIrALuYbortB7vyNlut2sA2tnKzT3HYk8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(33656002)(122000001)(316002)(38100700002)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007)(86362001)(54906003)(6916009)(71200400001)(44832011)(186003)(83380400001)(53546011)(7696005)(2906002)(6506007)(9686003)(26005)(55016003)(508600001)(52536014)(966005)(8936002)(5660300002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?aFhObTdJcjRKdHpEUGJQengyQ3dNcUhXeDZYVnhYcHRyZTdrTS9IZ0ZkZWU1?=
 =?gb2312?B?NHh3alh1dGdsSWw2Nk8vOVJENDdFQkFlR3NDOW51cFRzaExkZnZDSTVtWmFU?=
 =?gb2312?B?S2UrUmlpc1RvSGI2OG9MUGFvYUlzaUtFNHBTYjd4TlFMTVY4ZlFGTGJPZkZT?=
 =?gb2312?B?WFFoR08vM3BHdmE4ZG1CUkJjNFU5VTVsRmgxUWh2cUcrODJiQ2xjMnNSWlFl?=
 =?gb2312?B?bHkvNmsrQTQrTlRicnU4REJoL1JTUm9FTDBVOTVtS3NPMGhzWFZsc0IrWE5m?=
 =?gb2312?B?Z1pvWURVTzJmaWVMemQxM3Q4Z0l4Q0NUYjhjeEVHUFZuVTdFWjloQWZ5TVJa?=
 =?gb2312?B?QzNleEYvYzcza3F2RlB4OHNOT1NTRFlvbUU2VzFZSkVhdWJPZjl5ZTl5ZWdL?=
 =?gb2312?B?RjF3SjRhazZpUjlZWkErWm1yUU1JMEMvaUttVWhFbjhPS3lqWUpVQU5nU0lK?=
 =?gb2312?B?dXlZMGk2UTZEVVJlb1N4b2FzZ0d0K2s5Q1pNQWFBZElqM0FGelZEN3h2a3Zz?=
 =?gb2312?B?aGxHZUl6Ui9HVU1OSDBKaURZRGNZK3hxSHl5MmhWUWNLUGk2SWlyWXQ0azdS?=
 =?gb2312?B?S0JFN3RoZ3dLWC9RT2VSV3d3c0NBYU9qRjVoczY0U3FaVzRFSTN0UFRsWXUz?=
 =?gb2312?B?d2doMHUwYnFsWFE2MHdSZXQrREZPS0FWY3RTalRNNEhhd2UzTm9UNEt2VEJX?=
 =?gb2312?B?ZGc5SjVEdkxwV0wyNnRXN0FsTXhTT3daYTZGc1g3VjVUdEhOUVJkZDVqTU1P?=
 =?gb2312?B?ZnhTMnZTNVRkQU1XaldaTTh2UnYrRVVyd2pyM0VpeENmaUMyRGp6WDBFMjJ1?=
 =?gb2312?B?eFVickRjM0R6Tkw4MS9CN29QbXIybHBFYlVNSUM3RzBKS3BpRFNPN2ZqRUk5?=
 =?gb2312?B?TGJPUEMzUzl4OWdlcGxYd1hHcmVPd1o2YjB6S1lWM3JDK2pKdnB5Z0dHbXhS?=
 =?gb2312?B?ODlmOTZybHo5c0txc25kRk1YR1BLbnRINjJoZHVTSHNiaEFSNUpJTnBYWHVy?=
 =?gb2312?B?UjhCaUhJWVpDRG5GNlNQTDZjdDJCTEh5cm5jNWFoaUlObnpPaWh0UGtuMTBD?=
 =?gb2312?B?ZThqK0hlanBRbURmVTRIeko4U0R3VWdZenYxeG5ETG96YjNqeUhtSFVRdUdP?=
 =?gb2312?B?MGJIYjZnSWdTbzNienkwRmtnZUVXcnc5RU5pRU1DVTdkVFMyVmtMUWpza1Y5?=
 =?gb2312?B?TUFkbEFHZDlvOHBVaC96WXpTY0xDWGpjNTAxUlIrcStFYklLbXgxeC9hNERP?=
 =?gb2312?B?aTJySXp0Sjg4TWZhbm5rYWNmL05VSHRFWG5BTGZ2cVpBTVJJekowR1NxdW83?=
 =?gb2312?B?QWxVcXR5YzRUZHh0UUhMV2UvVFZXR2dJQ0l6TG0xZk1uZ09IYXRBNHpnaWls?=
 =?gb2312?B?WnRNVERyUlFSWFBnRWRCeHlEOFBQK1NsU0dKSlhiVnNmbTFxUlhQVXYzOUhH?=
 =?gb2312?B?L3NKSXJ3SUVJb0g1dkY1dldwempEK2p4RThyZHkrUEh4T3lFRWdmN3dMbzhU?=
 =?gb2312?B?b2ZBWmFnNlNXOGc5bFZrMkk4dkpSL1B1VWNSQ2FRUkU3aGRacnFXV0VHTC90?=
 =?gb2312?B?SWlYckNCenVXVFI4WW1zMGM1cjlUdEFNSngyMTlyQjhkeFBHeUg2U0pncm1D?=
 =?gb2312?B?aUNoOEMwRlcrU2w3a3lKQUtHdDdYMjhtYThNVEtxS212UWxWZnczUTJhT0E4?=
 =?gb2312?B?dU41OFJaNmc3SVdMVkVQeTM5T3I5Wk5FMHY1R0xRWUZpU3lxSVBmek1kU3JR?=
 =?gb2312?B?czFiVWJmWXhOb1Z6Q21XUlh5WFlrT0FLVld3SnVSbUhJcUhHaXJPcmM4cjRn?=
 =?gb2312?B?eWt2dVNzQ05rQ0I1STVDTmFVdlZaZXF5aEtOdGlWdWdRdHBWeXI4aGhNZm9C?=
 =?gb2312?B?dlIvQStiQ1N4Zkh4WmZBSkVVMkNVZjdHb1RoYzZsQ1Jma3FnZTU5enIzK3lR?=
 =?gb2312?B?UGtPUGlCcFg3aThsaWViTGVlcXJubldqVkVoZkNOMWwxVWtOakdJRlRMM2pC?=
 =?gb2312?B?c1c1emFqSStRUlFLVXJ2M3pURHBYUS80ajFscGJHSVRCcUlCTm5RdjdKOTJZ?=
 =?gb2312?B?RGNHaUpCbGhGVmVlQWRaMUNUWFBadWZtU2FTVC84dnpWd3VCTGcvcmxMOC9t?=
 =?gb2312?B?TVA0RXFtV29mM3FKZTMvdGNkdW5pWVlPbG9qaFF4R3lxYkxMM2o0MmpiQ3lX?=
 =?gb2312?B?VXBtdWVMRDkxR2hkUi93SHk2R2Y5eXhLMms2SDBLSDZ4SzBsQitGd0xzb090?=
 =?gb2312?B?WlpKcG1MaVI4RE5YYWNnS3FjN2F2QmEyM2IzVlZiZjE2dHdIV0pSTk5jTUhS?=
 =?gb2312?B?bXBBSzJrMmQyZmVLTmwzN1kvQjE5WGcyZWROR280RXJUMjVXNEFjQT09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de462f6-0b24-4506-13b6-08da49e01ea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 06:20:16.1555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ExCKuMExBIOlsiAtz2uP7Hd+feD2eyFSywXNyAFiDbl0cFlyzpQLBGfBM1DIQswzWfevgZLGy+XTZRTD5kDVow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2736
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jbUwjnI1SAyOjU4DQo+IFRvOiBIb25neGlu
ZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogbC5zdGFjaEBwZW5ndXRyb25peC5k
ZTsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBicm9vbmllQGtl
cm5lbC5vcmc7IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IGppbmdvb2hhbjFAZ21haWwuY29t
Ow0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tOw0K
PiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRy
b25peC5kZTsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2OSA3LzhdIFBDSTogaW14NjogTW92ZSB0aGUgcGh5IGRyaXZlciBjYWxsYmFj
a3MgdG8gdGhlDQo+IHByb3BlciBwbGFjZXMNCj4gDQo+IE9uIEZyaSwgTWF5IDA2LCAyMDIyIGF0
IDA5OjQ3OjA4QU0gKzA4MDAsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+IFRvIG1ha2UgaXQgbW9y
ZSByZWFzb25hYmxlLCBtb3ZlIHRoZSBwaHlfcG93ZXJfb24vcGh5X2luaXQgY2FsbGJhY2tzDQo+
ID4gdG8gdGhlIHByb3BlciBwbGFjZXMuDQo+ID4gLSBtb3ZlIHRoZSBwaHlfcG93ZXJfb24oKSBv
dXQgb2YgaW14Nl9wY2llX2Nsa19lbmFibGUoKS4NCj4gPiAtIG1vdmUgdGhlIHBoeV9pbml0KCkg
b3V0IG9mIGlteDZfcGNpZV9kZWFzc2VydF9jb3JlX3Jlc2V0KCkuDQo+IA0KPiBJJ20gbm90IHN1
cmUgd2hhdCAibWFrZSBpdCBtb3JlIHJlYXNvbmFibGUiIGlzIHRlbGxpbmcgbWUuICBJbiBzdWJq
ZWN0IGxpbmUgYW5kDQo+IGNvbW1pdCBsb2csIHBsZWFzZSBzYXkgc29tZXRoaW5nIG1vcmUgc3Bl
Y2lmaWMgdGhhbiAidGhlIHByb3BlciBwbGFjZXMuIg0KPiANCj4gSXQncyBwcm9iYWJseSBtb3Jl
IGltcG9ydGFudCB0byBzYXkgd2hlcmUgdGhleSBhcmUgbW92aW5nICp0byogdGhhbiB3aGVyZQ0K
PiB0aGV5J3JlIG1vdmluZyAqb3V0IG9mKi4NClRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4NCklu
IGFub3RoZXIgcmV2aWV3IGxvb3AgbGlzdGVkIGJlbG93LCBMdWNhcyB1c2VkIHNhaWQgdGhhdCBp
dCdzIG5vdCBnb29kIHRvIGhpZGUNCiBQSFkgaW5pdCBpbiBpbXg2X3BjaWVfYXNzZXJ0X2NvcmVf
cmVzZXQoKQ0KU28sIEkgbWFrZSBhIHRyeSB0byBtb3ZlIHRoZSBwaHlfaW5pdCgpIG91dCBvZiBp
bXg2X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQoKS4NCkFuZCBtb3ZlIHBoeV9wb3dlcl9vbigpIG91
dCBvZiBpbXg2X3BjaWVfY2xrX2VuYWJsZSgpIGFjY29yZGluZ2x5Lg0KaHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXBjaS9wYXRjaC8xNjQ2Mjg5Mjc1LTE3ODEzLTEt
Z2l0LXNlbmQtZW1haWwtaG9uZ3hpbmcuemh1QG54cC5jb20vDQpPa2F5LCBJIHdvdWxkIHNwZWNp
ZmljIHRoYXQgdGhleSBhcmUgbW92aW5nICp0byogbGF0ZXIuDQoNCj4gDQo+ID4gSW4gb3JkZXIg
dG8gc2F2ZSBwb3dlciBjb25zdW1wdGlvbiwgdHVybiBvZmYgdGhlIGNsb2NrcyBhbmQgcmVndWxh
dG9ycw0KPiA+IHdoZW4gdGhlIGlteDZfcGNpZV9ob3N0X2luaXQoKSByZXR1cm4gZXJyb3IuDQo+
IA0KPiBJcyB0aGUgcG93ZXIgc2F2aW5ncyB0aGUgKnJlYXNvbiogZm9yIHRoaXMgY2hhbmdlPyAg
SSBjYW4ndCB0ZWxsIGZyb20gdGhlDQo+IGNvbW1pdCBsb2cuDQpUaGUgZXJyb3IgaGFuZGxpbmcg
b2YgdGhlIGlteDZfcGNpZV9ob3N0X2luaXQoKSBpcyBub3QgbWVudGlvbmVkIGluIHRoZSBzdWJq
ZWN0Lg0KU2hvdWxkIEkgc3BsaXQgdGhlc2UgY2hhbmdlcyBpbnRvIHR3byBwYXRjaGVzPw0KDQpC
ZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo=
