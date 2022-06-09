Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FD25443B7
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 08:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbiFIGTw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jun 2022 02:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbiFIGTu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 02:19:50 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C938DAE7E;
        Wed,  8 Jun 2022 23:19:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hI6ffE/pJAP2WIVCFNc7tTyZrapCOdzQoBlIBbltPYgFFzsgF0j/BC34tjv9KYNqsVWsMekJioWsSfP7QpG6h9PLt+UKAlF5usCUDFCrg3CFzTntEVvp7ne+fo26a2CFcMpw5IVXViiAs7lPic6yqFspd9KFcbEdn2DPmgbLp+AB+Vd/TjsLS0GjSbIn8mjw104dyjU5UucQbNldj/mA9JqcVxX25DLA48GzpX+e48Vfuk9yCd5+4PoTSUmrv9vDOg8DoJT77dGF+l77O5jcMYXZSYXV08UkYg6y8XQh93bnEsKC1aY2Q2zItG9AhtQBaGVBlFR0NROGR7PqUa8Uug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=me3NKm7UQ3VOKieD9cqm69VdJgUgwA0Qe6Skz2pyD4w=;
 b=K6DH/h117ouvgIK3p7dlWlmyPp2dIABANd3Rcfsxl+kSPIRUQI85RPEz1/9E4SygwY5rNZk8yq6SoWAQqK83q78GrA6nmX/EDPnM+WIn7bWLep1QpIGalE78/cEo8pN8vAEaW0qOMzowyXj6SmQYNWff6O020wPsh34CrqbFYO3jg6X8YG8hmWyYg8GHsS/xySn1ulzSV36an/2JVDPKJ7OvB1vB9jYiRmObZb2hwZvJPLzG80dUtgFBQq9agpFD8J5lAjPY/UY5olY5GTV4pzMcs3hdsS+H03VDqxdg5iSRoFc1qaUU/EN8hYZj9ID2v9k7gx32kWbrjjcRGqC2Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=me3NKm7UQ3VOKieD9cqm69VdJgUgwA0Qe6Skz2pyD4w=;
 b=GSr1+CixzqXZoJTqp7+eenUPSFoKqaS7auiWrfBNo6tIALI6LSO3vbWL+1qIpliWic/MIpwqeD+6Xow1vT9FBKsXX4RUbnYFRXD0EbMBboJdiaRO6X3OEuDGDpwYMRaxvR4Ae72PNHeNsVAEEnTU31yF/K8gEJ2+WNVE9pIPXNw=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA4PR04MB7888.eurprd04.prod.outlook.com (2603:10a6:102:b9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 9 Jun
 2022 06:19:47 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::983c:b5ce:91b1:447e]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::983c:b5ce:91b1:447e%9]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 06:19:47 +0000
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
Subject: RE: [PATCH v9 5/8] PCI: imx6: Refine the regulator usage
Thread-Topic: [PATCH v9 5/8] PCI: imx6: Refine the regulator usage
Thread-Index: AQHYYOzgY7AYlEljsUCdTBhQfAYNj61GEJ+AgACFwmA=
Date:   Thu, 9 Jun 2022 06:19:47 +0000
Message-ID: <AS8PR04MB8676EFCB2BA9C1DD0F33C4FA8CA79@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1651801629-30223-6-git-send-email-hongxing.zhu@nxp.com>
 <20220608185453.GA410841@bhelgaas>
In-Reply-To: <20220608185453.GA410841@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ad5700a-ed58-438b-41c5-08da49e00d87
x-ms-traffictypediagnostic: PA4PR04MB7888:EE_
x-microsoft-antispam-prvs: <PA4PR04MB7888EE9266F2FE05A57BB4FF8CA79@PA4PR04MB7888.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CloEpPDtu2MB278Y3CpbrwbeBACmV8S+vSTqYMND0xcmLbehv+30Xw5I61IZOsqnSmPVzqAeSDMPYBTFxmLEvzQs/o4+56LSPkSrgf7E5dg8myRt8sLB35jwCrtnOVNrgB3JgSnkGsMMthZZqWcMiKoz5ru76BnweIH+bC7Al2dbZGaIopS0PFdP983FIM8ZvstasbvWSdpGBbt4kbRahI/5BODUuR/5t0ktpQBXR6uwnD5af77zSQe6Q1pdSMU2VGRfSISjAydH6CBm4AUOfaxBhoZlT/XHcZWEwm+5tnw4LXA9AEcy2nhoUFTrbWWbbNw8pjU+vNJTDCAgxlMAmn9FCaq8GiiSSRFJLZj3qFSVIchK9JvB07Muh+v3oktgF7ejktk65/Rg4B36U+32idgGFhmzgWOxcxaIFjWCvR5fkDKrQ9e42V37gmwZzRIV8JO5CLZvSTc2vjtaZcEhlJV24TNKSa3CTReQgWUoeznjig3LxhSCvsuClyDDyTmRLhhYUBdqiFGVUMQnwB9auUGMGxQsMVvfKLdc1l5SAHjtJZ5AlLKqFcLK1v6DXRKbU4GjysEdwgRPjXetJ6Z0X+9csmNXYPVb1ifdy3BCkmtp5wD9U/iOhijMHhceNj7YLXOlIuw4VYrcMAdrLNSWBjbkJ4Bd1BgJkCZeQY4nnCagJxh6EKPWCuYOz/36TbHtYMOKEMP6XpIdLVz2QAvajA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(33656002)(316002)(38100700002)(4326008)(8676002)(122000001)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007)(86362001)(54906003)(6916009)(71200400001)(44832011)(186003)(83380400001)(53546011)(7696005)(2906002)(6506007)(7416002)(9686003)(26005)(508600001)(52536014)(55016003)(8936002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZTVsalU5U3JuV2tNd1liRWVic253Ymx2R2JHTWU0TmszblVLL0tpaGpuTzV4?=
 =?gb2312?B?MzFWdE5tSEliNXNLZy9MUFViMkxyamM3Yi9xMEFmK2JhS1VXZFVUc2x5YW9L?=
 =?gb2312?B?K2dVem5NVHFUQ29idE8xYVZneXBjSXkxS1NiRWYwd282dENFeUM1cVAxR1dn?=
 =?gb2312?B?N1lRaVBEdmVmbUlsenZmeFo1eDB0elhENTErZnN6SVR3Q1Z4L3JCaG1VVTIx?=
 =?gb2312?B?YUtsTm5sVzN1YUdLS2k1bC84SE80bGhOV291RWlSR21pcFlKZkRKb3lEUjRx?=
 =?gb2312?B?VUNwcDlzTWFxWGI2a09QdXJiRS9vczBta1EwOXlWRnEwdUl2Q05wcjEwcU9q?=
 =?gb2312?B?azBnQTdqcG5DTDVSbVJ1clZIN2ppVG5YUFpDM0MyMFZOdVY3K2NSbXRzeXhw?=
 =?gb2312?B?MTg5NURyK3VlU0hwYkZNYVcvYTVsUnpjV29GWDZHVmE2N0FvYUxHSDhuRXh2?=
 =?gb2312?B?alNZZjV1bmYvZ2Yvc1Q4WHVHNTZGSnM4TGxIZ0tIVmw5aUJ4aGVOaDFKa2M3?=
 =?gb2312?B?RkV1VDMrb2c1S1FTY1BwV05rMEFEcDdiQVErWFdKQ1NvNVZiR2JiT2JjaUJy?=
 =?gb2312?B?ajNPWEpWTnRZdUpwUU84ZXVDZ3N6WWd5cXcvMzBlWW5vbDBiT0JFOGNJZ0VO?=
 =?gb2312?B?eURlcGEyZGVGcmlPMXQ0NjhCQ0hDRGF0cTROU0szQlpYWVZid0ZTMXd4dUpm?=
 =?gb2312?B?M1pzYTV3T0k0S0Q5RUFQWHNnYWZ5RG1wM0YzR3V1N2RLUG1nVVk0K0ZOLzBC?=
 =?gb2312?B?TTZqTWNQQmY5S2xVblB3amJGdlJUVWhOL1FHeU53R090aFFjSG1wdncwSlBr?=
 =?gb2312?B?dTFxeWtYNzN2b2htWTExaVdIMFhmUkhlOGc4OEU2MklBd01ia0FucmE4bUk2?=
 =?gb2312?B?d1BUcE5ON3c4REF0SEVKRzd5OUFSaGVjNFkwSStQZ01IdEtwbWZBWmZvZ3Nm?=
 =?gb2312?B?UlV2WW1oQzJLbUlCK2FZM0c4ZlFMeWRMQmF1Vmh4cjdvZ0l5TDlnZDZWRWJ2?=
 =?gb2312?B?eGxPZmtFejFEdmFxV0FOYkl5emI1UlBpOTRXd1VLSDVJOGhhaXhDdENQUjUx?=
 =?gb2312?B?dW9lVy80WWU5WE93cU5Rb2NPSk9pMld4WVJFRDB1cDlscTBKTkM0SGwyUk9i?=
 =?gb2312?B?YUN3N0t6RmtVd3V2OFpyQVI0alVvU2FTcGNUVTBGclRPemU1TDBuUFV5Tjc2?=
 =?gb2312?B?RnFOOWg1YTJUZ254ZTBkNWxPSGFZQ001WFliL2ZKYWIxVHl4b0FLK0owUVMy?=
 =?gb2312?B?aXkwOFQ0cFVyOTFqd2dna0lwMUFENFUyWWl3MElESUdDR2NIWXZEenozaGdM?=
 =?gb2312?B?OXEvL2EwdlNMVVdycW04TzJKMFdMYzRuVmxNaWFTUFRzMEh2YUNOTHdVQjhu?=
 =?gb2312?B?b2lVN3J3bFU3SHRla3JqNFJFd0lUSXF6Mks4czV4cGR6WW03aHFMdC95aEp0?=
 =?gb2312?B?SVNSd1FCZDFpa3hhUjJUaEhVd2RVMU5PVTlLdXhLRzFIN2lNUjlSMlFhODF1?=
 =?gb2312?B?alBWYWhMR0prVUhwOWR2MnAva2I0bWdSRTFqWnJuK1QzODlkRFJvNjVWSkJ4?=
 =?gb2312?B?UysvTHVWM0NoQXV2QVg1ZXUyanBnbzk2YzkyQk9LeGRqaWJhU3h4R2hINVFj?=
 =?gb2312?B?L3RYeUNISmZLVHkwdW5SQkI3V1ROeldDZG9YbGtEU0Y2OGhGdDkrOWRvL2Ex?=
 =?gb2312?B?S1FtcmRTQjFPZnQrbWM3S2lPdFFSSEFZcHZUcmhTa0FuOVdsNFlGaVAwZUZX?=
 =?gb2312?B?Rm9FaWNSSEZwL3ZyQTkrTXRaMC80RHdZNmViZW95MDhrTkg1NmsrOUR0Nnls?=
 =?gb2312?B?aVVQWktWMDNlRmlzWHNlOWQ0cmUvTlVadlpvY3FRSW5VKytjdElIdlFIa2xV?=
 =?gb2312?B?elhheTBGRm5PczhSa1RBU1JCU01rOE1OcFRPRzhXbzhyM3BoRnZJRXZJSmEx?=
 =?gb2312?B?L0QyQmtQM2JVblNibk5MdkVQWmNESXpaRVFibGxXUHBlUVNYb0xnQ0JPdWQv?=
 =?gb2312?B?MWRCZU9MaUczVjd5UzNWYkJSYVl4TmQybnBEU25lRmFWWDRKY2VWa3ZYMzJm?=
 =?gb2312?B?eEdlQnppdWZkNmZHNXdLSGJnTzkyeGxwSEdCTjNNVFpIOVU1RWVWRG91Y2Jy?=
 =?gb2312?B?MWFqbnN0Yy9MY2Q1UWJzZ2pNK3Vad0p3YU1PQktNUTVKSWQrNmx1bDBZMGg3?=
 =?gb2312?B?VHBHOEIzdTk0RkdpWHkrQUxHdFA2L3lWT1FIb2xNNUxkZzFtZVpTL3lxMDF3?=
 =?gb2312?B?dFcyckVDWnBma3V0MVd0MmFCUTFSNWFDb1h5SHIvYlAyNXlTTEFmOC81Mk1Z?=
 =?gb2312?B?T1ZQTDR4WjBsN1FFeEFTaklrclRQcTVNNnhJRjQ1bkNUSjkwOGlzQT09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad5700a-ed58-438b-41c5-08da49e00d87
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 06:19:47.4179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W1Ke4eozNpPupXnLXYtCqyWj7NObrFXnWnYFro0kwSpgMU/cNdK6bo3YCUt8eQGcB9FfXmJWZi6G2SxNdA8+RA==
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jbUwjnI1SAyOjU1DQo+IFRvOiBIb25neGlu
ZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogbC5zdGFjaEBwZW5ndXRyb25peC5k
ZTsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBicm9vbmllQGtl
cm5lbC5vcmc7IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IGppbmdvb2hhbjFAZ21haWwuY29t
Ow0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tOw0K
PiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRy
b25peC5kZTsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2OSA1LzhdIFBDSTogaW14NjogUmVmaW5lIHRoZSByZWd1bGF0b3IgdXNhZ2UN
Cj4gDQo+IE9uIEZyaSwgTWF5IDA2LCAyMDIyIGF0IDA5OjQ3OjA2QU0gKzA4MDAsIFJpY2hhcmQg
Wmh1IHdyb3RlOg0KPiA+IFRoZSBkcml2ZXIgc2hvdWxkIHVuZG8gYW55IGVuYWJsZXMgaXQgZGlk
IGl0c2VsZi4gVGhlIHJlZ3VsYXRvcg0KPiA+IGRpc2FibGUgc2hvdWxkbid0IGJlIGJhc2luZyBk
ZWNpc2lvbnMgb24gcmVndWxhdG9yX2lzX2VuYWJsZWQoKS4NCj4gPg0KPiA+IFRvIGtlZXAgdGhl
IGJhbGFuY2Ugb2YgdGhlIHJlZ3VsYXRvciB1c2FnZSBjb3VudGVyLCBkaXNhYmxlIHRoZQ0KPiA+
IHJlZ3VsYXRvciBqdXN0IGJlaGluZCBvZiBpbXg2X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQoKSBp
biByZXN1bWUgYW5kDQo+IHNodXRkb3duLg0KPiANCj4gSW4gc3ViamVjdCwgIlJlZmluZSIgZG9l
c24ndCB0ZWxsIG1lIGFueXRoaW5nIGFib3V0IHdoYXQncyBoYXBwZW5pbmcgaGVyZS4NClRoYW5r
cyBmb3IgeW91ciBjb21tZW50cy4NCkhvdyBhYm91dCB0aGUgZm9sbG93aW5nIG9uZT8NClBDSTog
aW14NjogRG8gcmVndWxhdG9yIGRpc2FibGUgd2l0aG91dCB0aGUgcmVndWxhdG9yX2lzX2VuYWJs
ZWQgY2hlY2sNCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0K
