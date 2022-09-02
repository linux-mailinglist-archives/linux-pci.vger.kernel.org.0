Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE88E5AB718
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 19:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbiIBRDR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 13:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbiIBRDN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 13:03:13 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0B6D9E9C;
        Fri,  2 Sep 2022 10:03:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9DSLIMLBG+KkUWNVD/ZVVh0hGLYZay7f0Ft3sR4Q4zG4pUrOM6xY0yHhLSCJ/eswxw3BCItxSGU2ApG3X/tN4rB3UpHaEcjda0bZ687TmlM5N3NaUqbtlbJQFEnPC8GBn4O/qCK+7JxazzJ5//bk6n8zuaTyrlaGf5lq7pAFSCzY8JGHYbT1oFAjwt7+HQIpd8dzukOwNbGnJeLrVitjBKStT2S6ceSSUxQVyXdsVYdOH1SjPcAkXEbYOifTlq6DNzRyF6G6W1ohYjHh9lE6Gye/k83k3iktFWXloQs6v4niae6OVKGwDTJQaM7r2yhETr/k3xukX2Pz2Vy+LHh5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tfo+D7lFSPWEVvuZ1hgnbOvC6C+JsVSLoZrUsw+XpMU=;
 b=DNK9q+bTeKdRTZA6gUu8aAjEiYDoCrusbhBb4SQfWSTGvcAYoHgh2NZjasRP3XKf6xT2boZXh0clq/eCiuDrVHWM7dy+RT5n7fJ2BywPOkgF3Mam0gpxHyKt0b6AdK1Do/kfU79Y0lLtdSqDz0pdJjAkoJt/uXYwybpomQpFgiPtti9wymLoO+BaZDkLV8w5iC2GdPIbrZj/netL/pNpxpbuTybzqCO1TqTs2FlpcF+f651SUmIall8vIfUz2SM4PFw6BoOpUJJPjcZiPDbCPEXeFqTEn7SvoVRRDYAO9Um30UugNqLvgEVmSqvSjFVxCrRQY4aJ8v6uLGXl5s2Kug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tfo+D7lFSPWEVvuZ1hgnbOvC6C+JsVSLoZrUsw+XpMU=;
 b=gsHQMX+Q2eHtRvJY901jSR5UpAmUPiti7UU7PP6sAuLxcoeGw8+SISvs57cqtWd9oZZheeqpCI1i8uiifou2YZCV2++cvkUjVHITUohAM27WDE5RNhOp/1hS232SpZplBlAK4QhiMqjxx1/9pty/n+dC//1L9g63uV7IUliZaMo=
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by AM0PR04MB6113.eurprd04.prod.outlook.com (2603:10a6:208:13d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Fri, 2 Sep
 2022 17:03:08 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::1c3e:36a0:1adc:beb]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::1c3e:36a0:1adc:beb%8]) with mapi id 15.20.5588.015; Fri, 2 Sep 2022
 17:03:08 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     "maz@kernel.org" <maz@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        "lznuaa@gmail.com" <lznuaa@gmail.com>
Subject: RE: [EXT] Re: [PATCH v6 4/4] pcie: endpoint: pci-epf-vntb: add
 endpoint MSI support
Thread-Topic: [EXT] Re: [PATCH v6 4/4] pcie: endpoint: pci-epf-vntb: add
 endpoint MSI support
Thread-Index: AQHYsxTj8ial5WQflUOYb2uoUuXnWa3I5nOAgAONMpA=
Date:   Fri, 2 Sep 2022 17:03:07 +0000
Message-ID: <AM9PR04MB879319904C54C229C4BBCADE887A9@AM9PR04MB8793.eurprd04.prod.outlook.com>
References: <20220818151127.2449064-1-Frank.Li@nxp.com>
 <20220818151127.2449064-5-Frank.Li@nxp.com> <20220831104203.GD5076@thinkpad>
In-Reply-To: <20220831104203.GD5076@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4462b3b-9e4b-49dd-a7a8-08da8d050289
x-ms-traffictypediagnostic: AM0PR04MB6113:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iBBy8G9zsRoWavZxy2/zN6vxXWgoelZ2HQsAfThKvjcYk6eJmBJsNOtbz8pHgZBna/YAFCBXpQs4UHnPZSRVWb+USKxCRY/QS+m439nlyzgKS67Z6aGNbYQghbov72AXkwgmtXBrh48Rm75k1Z+QJ6aygOTN3YxFSD5n7a/Kicn09GP+iosDwrAIVNsw2yR2eBrGrKj/lkz44kzQJEs/3GCc1qTTE/Toh+ZGnkmUUPLrKSEO50RCn2B+dP7GqfAONEuF1zOzZ72YHgC5wAH+G+1jFTlZ3N9A2+jyaiVDQtI/+HwPXtSF7pOhOFaGOt2t2vJXkCOCqpecDdX9U9rjy4WW9ieg4ocpaThdwHvf5mvMwwpwSWo8sNtq/VHLmzuiENMmGo580d4Bd/ifptjTMIb+DVs4ODnCsGhA9UbGLD1X1kpW+yrYtSwgRf2XjrVeuTmiA3EiomBJ1T4dEhYt74By4TXd/FtaTjKm0lrGoJzyWG5LUNW19CJBYH/c1SyzFIqB/f1VAe6oy59GILG9/rpLKqRP8wXqaiU6TJBdQ+30mvcqiPj0v83JP14klXub/QlEx3I6ufUxpneQfB7lLQwI6R/f1Dls8obNYxsSX9cv/c68APTro1qmBsK52eHMy4NDpTn5sReKqtnP/J+WB2d3fbcEJqfLl3kjt7NMjX7Hc39PFCxkkRU0zrw+Qk+FZQfmq0rsawIltk0e9P9LPp7hSvaFjoyqRRq1cKs29yqox4L9O/hjluc+JF42A1QqtoOh6gCBbQTUjQfU0vu3xg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(2906002)(26005)(55016003)(7416002)(6506007)(38100700002)(7696005)(83380400001)(30864003)(122000001)(53546011)(55236004)(44832011)(33656002)(186003)(9686003)(316002)(71200400001)(4326008)(6916009)(54906003)(76116006)(66446008)(66556008)(41300700001)(66946007)(52536014)(8936002)(66476007)(86362001)(8676002)(478600001)(64756008)(5660300002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkhPRERxTzB0TDZvSnlBakNtbW9RV2NkYlY1c29JTUp3cXNHamxoWVJPRVAr?=
 =?utf-8?B?M0s3UExETDdGUWJqTFNKTnE2cHQvOGFaMGx6UkJJR1FNRk9VVGVWWDQ0VFds?=
 =?utf-8?B?U2Ixd3gzRFZ4bDlJa3RCckZNQjhBbjVGZGx2dElLQ1BMQlcvbTRid0I0NXU0?=
 =?utf-8?B?bGRrdUZFdExQenVOdDdqbGhYM1Y1ZW14cmtoYlpSeDI4cmVZRzFPcWtlbytW?=
 =?utf-8?B?MFcvU2RNOW1EbXB6c2ZjaTF1N3ZzbFFJTDMxSUNnZ25ROUU5Z0JxUHZ2aGxS?=
 =?utf-8?B?aktVMENBYytiSmJlQnU1NVJVNklNZ3lRYVpUMGkyOWRuNXF4aGFLV0tGV2lv?=
 =?utf-8?B?clY3VER2NVljeUZlVHpBZDRtWm5ka2d6aW5ZdGZ5R0o3a0FQVUR5R2pyMHlT?=
 =?utf-8?B?STdNUk1vd25uSFd1UjFDNlpSQ09BSWgvcmVSMktCUDdkazRSb1JnSTg1YnJh?=
 =?utf-8?B?R2ZCNU5NVVhKWUZQMDduK0R3dW5jWDRlT2F6WjVsbW1CaE5qd0pPUjBZanRj?=
 =?utf-8?B?NXRVR3JyK0pPbktDQnRQSkFQQ3pLVTRkbi8wUlU3UmdBamJDQVYzT0hwYkZv?=
 =?utf-8?B?OEtNZ05ESjZPTm80K3lvNFRBM2pLcVo3REdXRVhMTVhsNlpkTkp2dzNodzk4?=
 =?utf-8?B?V2VWdXhuTWN6NExGNmZEeHJNcHliZUpwUFdjYWxoOTRsWC9KZzRkeUY0VlhE?=
 =?utf-8?B?RndJbS9QdHhQWmMrNHRkNlNNWGxpNW8ramRBQktkN0p6Vys0akMyQ2FiT0Mr?=
 =?utf-8?B?MEVUQ1hzNDFyMVdzcysrNkNFNTBMS0dYYnk0R3NJY2pVRUZqcys2R2ZlSTVE?=
 =?utf-8?B?VEg5aDZRVWRweXFmMWFlQWxNczhrV3FwV3VEWHl0ODU3UFFoNHFZU1FlNVNR?=
 =?utf-8?B?c1YzYkZNUjNuKzdhdXlOR0tBeUNSdU5QTE9pSzI3amdZMGlDNnFDZ2FxZW96?=
 =?utf-8?B?NFR1V0pieW5GUlJxcHRzUzloOHpSWng3MDF5L1kyeTZBMG9ueVg3YW5sSE1v?=
 =?utf-8?B?SzJybUxuMXllMU9MaHBCL1pOMGxPdlRoTTZHN1VmdVNSMDNBNmlzYTRsMWp1?=
 =?utf-8?B?RmpHNURrNEV3SkVWMTJzOVREVVZvUm5xcHA5YlFlaXdiKzNGOHowSTRpR2Rk?=
 =?utf-8?B?a25MckhQR01aakFmZm9oM3ZJWmJXTzVIM3BZaGZ0SHFvbkVZcE9YU3VpUjJL?=
 =?utf-8?B?SHpLSmI0K2NnT1hFSGJ6Wm4xTDk0VUlGUFNnYmQ2Q0dYLzF3VDZILzFFR0hV?=
 =?utf-8?B?Zk5RbWpiTkpQeVJabE5jYzdkVDd2dHMvSm1FTHFVbmdiUnA5WE1hSkJDTEo5?=
 =?utf-8?B?U09aNDZHM0JLMVVYNkF5U0QraXhreHN3bG5uR013TjJ4UkptN2NFUEJTQjZM?=
 =?utf-8?B?ZEQrNWFSUDJGdE9DQkRzS2RJK1U2cS9YanA2eFZzV1MzSjVDeHN3c2tlKzFZ?=
 =?utf-8?B?enlma3NwR1dxKzhsMSt0RGtKdFRYVlk0ZFl3U3JobVdCRUdQTC9IRHhidFFD?=
 =?utf-8?B?ZW92STF5UUVhVDFuNWQraWdWbUh2QmZWTlFOd2dQS3hjcFdYSkx6eHhKUEY5?=
 =?utf-8?B?T3hONHdQRkFKcGgwRlVSL0ZxaDJMamh4ZmJnWkhSdk52Q2lGSE44UDlUM0g2?=
 =?utf-8?B?aHBzSUVpczhYR2Jpa282MjMvUE1TUUJqcXNBOG1KZXArS0JkVXhUYWZDOEdD?=
 =?utf-8?B?QTRkY1FCcVJZMXlYWjFmY2FicFVYU3VIcUU2VWdTWEplcGorRjkzNUVtcVBV?=
 =?utf-8?B?bkZHSG1LdXBpK1V6L2dxRExnQnZobmVkcDltdXFmOFkvVitmU1pGamNHamVQ?=
 =?utf-8?B?UHpTVGdqdzVSZ0wwaWtEZnNXaU8wS29LeHZnL0pId3BxOVlBV1FOTGxsaHVi?=
 =?utf-8?B?TUJ2NkdySGNUbjFlU2IrQ2tPdGlQRytUbmRDbkdHbW1TdGxwTHB2MVRHd0Z2?=
 =?utf-8?B?TEpqSkFxT1FyQ0U2TVVjdlhGUnNMNU9MblBrYTFLN2t4SWFmODU3bVJxTmVm?=
 =?utf-8?B?NG5YaGlIR2lJdWlOUkliaUZXeGpjMjlmeExPQlVSYlZaY3BuemFxRVRTcGVO?=
 =?utf-8?B?WXRXd0prSURzQm1NY3MzRXNkTGh0Vk95czlBSzFUNHcyeVdhQnNaVnFFWWIx?=
 =?utf-8?Q?iGf0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4462b3b-9e4b-49dd-a7a8-08da8d050289
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 17:03:08.3118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3v3Fi+/GLeiTI7QWTbhEwdOGdbHmXMIUClnmfQxyvQwtlH3VAp8A5iu6nAr5iDFsV0IgdGst+XWhamt4qNVRMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFuaXZhbm5hbiBTYWRo
YXNpdmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZz4NCj4gU2VudDogV2VkbmVz
ZGF5LCBBdWd1c3QgMzEsIDIwMjIgNTo0MiBBTQ0KPiBUbzogRnJhbmsgTGkgPGZyYW5rLmxpQG54
cC5jb20+DQo+IENjOiBtYXpAa2VybmVsLm9yZzsgdGdseEBsaW51dHJvbml4LmRlOyByb2JoK2R0
QGtlcm5lbC5vcmc7DQo+IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgc2hhd25n
dW9Aa2VybmVsLm9yZzsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga3dAbGludXguY29tOyBi
aGVsZ2Fhc0Bnb29nbGUuY29tOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IFBlbmcgRmFuDQo+IDxwZW5nLmZh
bkBueHAuY29tPjsgQWlzaGVuZyBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47DQo+IGpkbWFz
b25Aa3VkenUudXM7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBk
bC1saW51eC0NCj4gaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IGtpc2hvbkB0aS5jb207IGxvcmVu
em8ucGllcmFsaXNpQGFybS5jb207DQo+IG50YkBsaXN0cy5saW51eC5kZXY7IGx6bnVhYUBnbWFp
bC5jb20NCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCB2NiA0LzRdIHBjaWU6IGVuZHBvaW50
OiBwY2ktZXBmLXZudGI6IGFkZCBlbmRwb2ludA0KPiBNU0kgc3VwcG9ydA0KPiANCj4gQ2F1dGlv
bjogRVhUIEVtYWlsDQo+IA0KPiBPbiBUaHUsIEF1ZyAxOCwgMjAyMiBhdCAxMDoxMToyN0FNIC0w
NTAwLCBGcmFuayBMaSB3cm90ZToNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICDilIzilIDi
lIDilIDilIDilIDilIDilIDilJAgICAgICAgICAg4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSQDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg4pSCICAgICAgIOKUgiAgICAg
ICAgICDilIIgICAgICAgICAg4pSCDQo+ID4gICAgICAg4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSQICAg4pSCICAgICAgIOKUgiAgICAgICAgICDilIIgUENJIEhv
c3Qg4pSCDQo+ID4gICAgICAg4pSCIE1TSSAgICAgICAgIOKUguKXhOKUkCDilIIgICAgICAg4pSC
ICAgICAgICAgIOKUgiAgICAgICAgICDilIINCj4gPiAgICAgICDilIIgQ29udHJvbGxlciAg4pSC
IOKUgiDilIIgICAgICAg4pSCICAgICAgICAgIOKUgiAgICAgICAgICDilIINCj4gPiAgICAgICDi
lJTilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilJgg4pSU4pSA4pS84pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pS84pSA4pSA4pSADQo+IOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
vOKUgEJBUjAgICAgIOKUgg0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIOKUgiBQQ0kgICDi
lIIgICAgICAgICAg4pSCIEJBUjEgICAgIOKUgg0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
IOKUgiBGdW5jICDilIIgICAgICAgICAg4pSCIEJBUjIgICAgIOKUgg0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgIOKUgiAgICAgICDilIIgICAgICAgICAg4pSCIEJBUjMgICAgIOKUgg0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgIOKUgiAgICAgICDilIIgICAgICAgICAg4pSCIEJBUjQg
ICAgIOKUgg0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIOKUgiAgICAgICDilJzilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilrrilIIgICAgICAgICAg4pSCDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAg4pSU4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSYICAgICAgICAgIOKUlOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUmA0KPiA+DQo+IA0KPiBUaGlzIGRpYWdyYW0gZG9l
c24ndCBzYXkgd2hpY2ggc2lkZSBpcyBob3N0IGFuZCB3aGljaCBvbmUgaXMgZW5kcG9pbnQuDQo+
IEFuZCBub3QgY29udmV5aW5nIGFueSB1c2VmdWwgaW5mb3JtYXRpb24uDQo+IA0KPiA+IExpbnV4
IHN1cHBvcnRzIGVuZHBvaW50IGZ1bmN0aW9ucy4gUENJIEhvc3Qgd3JpdGUgQkFSPG4+IHNwYWNl
IGxpa2Ugd3JpdGUNCj4gPiB0byBtZW1vcnkuIFRoZSBFUCBzaWRlIGNhbid0IGtub3cgbWVtb3J5
IGNoYW5nZWQgYnkgdGhlIGhvc3QgZHJpdmVyLg0KPiA+DQo+IA0KPiBJIHRoaW5rIHlvdSBqdXN0
IHNheSwgdGhhdCB0aGVyZSBpcyBubyBkZWZpbmVkIHdheSBvZiByYWlzaW5nIElSUXMgYnkgaG9z
dA0KPiB0byB0aGUgZW5kcG9pbnQuDQo+IA0KPiA+IFBDSSBTcGVjIGhhcyBub3QgZGVmaW5lZCBh
IHN0YW5kYXJkIG1ldGhvZCB0byBkbyB0aGF0LiBPbmx5IGRlZmluZSBNU0koeCkNCj4gPiB0byBs
ZXQgRVAgbm90aWZpZWQgUkMgc3RhdHVzIGNoYW5nZS4NCj4gPg0KPiANCj4gTVNJIGlzIGZyb20g
RVAsIHJpZ2h0PyBUaHJvdWdob3V0IHRoZSBkcml2ZXIgeW91IHNob3VsZCBjYWxsIGl0IGFzICJk
b29yYmVsbCINCj4gYW5kIG5vdCBNU0kuDQo+IA0KPiA+IFRoZSBiYXNpYyBpZGVhIGlzIHRvIHRy
aWdnZXIgYW4gSVJRIHdoZW4gUENJIFJDIHdyaXRlcyB0byBhIG1lbW9yeQ0KPiA+IGFkZHJlc3Mu
IFRoYXQncyB3aGF0IE1TSSBjb250cm9sbGVyIHByb3ZpZGVkLiBFUCBkcml2ZXJzIGp1c3QgbmVl
ZCB0bw0KPiA+IHJlcXVlc3QgYSBwbGF0Zm9ybSBNU0kgaW50ZXJydXB0LCBzdHJ1Y3QgbXNpX21z
ZyAqbXNnIHdpbGwgcGFzcyBkb3duIGENCj4gPiBtZW1vcnkgYWRkcmVzcyBhbmQgZGF0YS4gRVAg
ZHJpdmVyIHdpbGwgbWFwIHN1Y2ggbWVtb3J5IGFkZHJlc3MgdG8gb25lDQo+IG9mDQo+ID4gUENJ
IEJBUjxuPi4gIEhvc3QganVzdCB3cml0ZXMgc3VjaCBhbiBhZGRyZXNzIHRvIHRyaWdnZXIgRVAg
c2lkZSBpcnEuDQo+ID4NCj4gDQo+IElJVUMgKGJ5IGxvb2tpbmcgYXQgb3RoZXIgcGF0Y2hlcyBp
biB0aGUgc2VyaWVzKSwgdGhlIG1lbW9yeSBhc3NpZ25lZCBmb3IgQkFSDQo+IHJlZ2lvbiBieSB0
aGUgUENJIGhvc3QgaXMgbWFwcGVkIHRvIHRoZSBwbGF0Zm9ybSBpbnRlcnJ1cHQgY29udHJvbGxl
ciBpbg0KPiBQQ0kgRW5kcG9pbnQuIFN1Y2ggdGhhdCwgd2hlbmV2ZXIgdGhlIFBDSSBob3N0IHdy
aXRlcyB0byB0aGUgQkFSIHJlZ2lvbiwgaXQNCj4gd2lsbCB0cmlnZ2VyIGFuIElSUSBpbiB0aGUg
RW5kcG9pbnQuDQo+IA0KPiBUaGlzIGtpbmQgb2Ygc2V0dXAgaXMgYXZhaWxhYmxlIGluIG90aGVy
IHBsYXRmb3JtcyBsaWtlIFF1YWxjb21tIHdoZXJlIHRoZQ0KPiBtYXBwaW5nIG9mIGEgcmVnaXN0
ZXIgcmVnaW9uIGF2YWlsYWJsZSBpbiBCQVIwIGFuZCBpbnRlcnJ1cHQgY29udHJvbGxlciBpcw0K
PiBkb25lIGluIHRoZSBoYXJkd2FyZSBpdHNlbGYuIFNvIHdoZW5ldmVyIHRoZSBQQ0kgaG9zdCB3
cml0ZXMgdG8gdGhhdCByZWdpc3Rlcg0KPiBpbiBCQVIwLCBhbiBJUlEgd2lsbCBiZSBkZWxpdmVy
ZWQgdG8gdGhlIGVuZHBvaW50Lg0KPiANCj4gPiBBZGQgTVNJIHN1cHBvcnQgZm9yIHBjaS1lcGYt
dm50Yi4gcGNpLWVwZi12bnRiIGRyaXZlciBxdWVyeSBpZiBzeXN0ZW0NCj4gPiBoYXZlIE1TSSBj
b250cm9sbGVyLiBTZXR1cCBkb29yYmVsbCBhZGRyZXNzIGFjY29yZGluZyB0byBzdHJ1Y3QgbXNp
X21zZy4NCj4gPg0KPiA+IFNvIFBDSWUgaG9zdCBjYW4gd3JpdGUgdGhpcyBkb29yYmVsbCBhZGRy
ZXNzIHRvIHRyaWdlciBFUCBzaWRlJ3MgaXJxLg0KPiA+DQo+ID4gSWYgbm8gTVNJIGNvbnRyb2xs
ZXIgZXhpc3QsIGZhbGwgYmFjayB0byBzb2Z0d2FyZSBwb2xsaW5nLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLXZudGIuYyB8IDEzNCArKysrKysrKysr
KysrKystLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDExMiBpbnNlcnRpb25zKCspLCAyMiBkZWxl
dGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5j
dGlvbnMvcGNpLWVwZi12bnRiLmMNCj4gYi9kcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMv
cGNpLWVwZi12bnRiLmMNCj4gPiBpbmRleCAxNDY2ZGQxOTA0MTc1Li5hZDRmN2VjOGEzOWZjIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLXZu
dGIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLXZu
dGIuYw0KPiA+IEBAIC00NCw2ICs0NCw3IEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC9wY2ktZXBj
Lmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9wY2ktZXBmLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51
eC9udGIuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L21zaS5oPg0KPiA+DQo+ID4gIHN0YXRpYyBz
dHJ1Y3Qgd29ya3F1ZXVlX3N0cnVjdCAqa3BjaW50Yl93b3JrcXVldWU7DQo+ID4NCj4gPiBAQCAt
MTQzLDYgKzE0NCw4IEBAIHN0cnVjdCBlcGZfbnRiIHsNCj4gPiAgICAgICB2b2lkIF9faW9tZW0g
KnZwY2lfbXdfYWRkcltNQVhfTVddOw0KPiA+DQo+ID4gICAgICAgc3RydWN0IGRlbGF5ZWRfd29y
ayBjbWRfaGFuZGxlcjsNCj4gPiArDQo+ID4gKyAgICAgaW50IG1zaV92aXJxYmFzZTsNCj4gDQo+
IGRiX2Jhc2U/DQoNCltGcmFuayBMaV0gaXQgaXMgbm90IGRvb3JfYmVsbCBiYXNlIGFkZHJlc3Mu
DQpEYl9iYXNlIGxvb2sgbGlrZSBpdCBkb29yYmVsbCBiYXNlIGFkZHJlc3MuDQoNCkFjdHVhbGx5
LCBpdCBpcyB2aXJxIGlycSBudW1iZXIgYmFzZS4NCk1TSSBhbGxvY2F0ZSBtYW55IGlycXMsIHN1
Y2ggNCBpcnEgKDAgZm9yIGxpbmsgaW5mbywgMSBmb3IgcXVldWUgMCwgMiBmb3IgcXVldWUgMSwg
MyBmb3IgcXVldWUgMiAuLi4uKSAuIA0KSXJxIHByb3ZpZGVkIHdpbGwgcHJvdmlkZSA0IHZpcnR1
YWwgaXJxIG51bWJlcg0KU3VjaCBhcyAxMDAsIDEwMSwgMTAyLCBhbmQgMTAzLg0KDQoxMDAgaXMg
dGhlIGJhc2UgYW5kIHNhdmUgdG8gbXNpX3ZpcnFiYXNlLg0KDQpXZSBuZWVkIGtub3cgd2hpY2gg
aXJxIGJ5ICh2aXJxIC0gbXNpX3ZpcnFiYXNlKS4NCg0KU28gSSB0aGluayBtc2lfdmlycWJhc2Ug
aXMgYmV0dGVyIG5hbWluZy4gDQoNCg0KPiANCj4gPiAgfTsNCj4gPg0KPiA+ICAjZGVmaW5lIHRv
X2VwZl9udGIoZXBmX2dyb3VwKSBjb250YWluZXJfb2YoKGVwZl9ncm91cCksIHN0cnVjdCBlcGZf
bnRiLA0KPiBncm91cCkNCj4gPiBAQCAtMjUzLDcgKzI1Niw3IEBAIHN0YXRpYyB2b2lkIGVwZl9u
dGJfY21kX2hhbmRsZXIoc3RydWN0DQo+IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiA+DQo+ID4gICAg
ICAgbnRiID0gY29udGFpbmVyX29mKHdvcmssIHN0cnVjdCBlcGZfbnRiLCBjbWRfaGFuZGxlci53
b3JrKTsNCj4gPg0KPiA+IC0gICAgIGZvciAoaSA9IDE7IGkgPCBudGItPmRiX2NvdW50OyBpKysp
IHsNCj4gPiArICAgICBmb3IgKGkgPSAxOyBpIDwgbnRiLT5kYl9jb3VudCAmJiAhbnRiLT5lcGZf
ZGJfcGh5OyBpKyspIHsNCj4gDQo+IGVwZl9kYl9waHkgaXMgYSB3aWVyZCBuYW1lLiAicGh5IiB1
c3VhbGx5IG1lYW5zIHRoZSBQSFkgY29udHJvbGxlcg0KPiAoUGh5c2ljYWwNCj4gbGF5ZXIpIGlu
IGtlcm5lbC4gSWYgeW91IGFyZSByZWZlcnJpbmcgdG8gcGh5c2ljYWxsIGFkZHJlc3Mgb2YgdGhl
IGRvb3JiZWxsLA0KPiB0aGVuIHlvdSBjb3VsZCB1c2UgInBoeXMiLg0KPiANCj4gPiAgICAgICAg
ICAgICAgIGlmIChyZWFkbChudGItPmVwZl9kYiArIGkgKiA0KSkgew0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICBpZiAocmVhZGwobnRiLT5lcGZfZGIgKyBpICogNCkpDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgbnRiLT5kYiB8PSAxIDw8IChpIC0gMSk7DQo+ID4gQEAgLTQ1
NCwxMSArNDU3LDkgQEAgc3RhdGljIGludCBlcGZfbnRiX2NvbmZpZ19zcGFkX2Jhcl9hbGxvYyhz
dHJ1Y3QNCj4gZXBmX250YiAqbnRiKQ0KPiA+ICAgICAgIGN0cmwtPm51bV9td3MgPSBudGItPm51
bV9td3M7DQo+ID4gICAgICAgbnRiLT5zcGFkX3NpemUgPSBzcGFkX3NpemU7DQo+ID4NCj4gPiAt
ICAgICBjdHJsLT5kYl9lbnRyeV9zaXplID0gNDsNCj4gPiAtDQo+ID4gICAgICAgZm9yIChpID0g
MDsgaSA8IG50Yi0+ZGJfY291bnQ7IGkrKykgew0KPiA+ICAgICAgICAgICAgICAgbnRiLT5yZWct
PmRiX2RhdGFbaV0gPSAxICsgaTsNCj4gPiAtICAgICAgICAgICAgIG50Yi0+cmVnLT5kYl9vZmZz
ZXRbaV0gPSAwOw0KPiA+ICsgICAgICAgICAgICAgbnRiLT5yZWctPmRiX29mZnNldFtpXSA9IDQg
KiBpOw0KPiA+ICAgICAgIH0NCj4gPg0KPiA+ICAgICAgIHJldHVybiAwOw0KPiA+IEBAIC01MDks
NiArNTEwLDI4IEBAIHN0YXRpYyBpbnQgZXBmX250Yl9jb25maWd1cmVfaW50ZXJydXB0KHN0cnVj
dA0KPiBlcGZfbnRiICpudGIpDQo+ID4gICAgICAgcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+
ICtzdGF0aWMgaW50IGVwZl9udGJfZGJfc2l6ZShzdHJ1Y3QgZXBmX250YiAqbnRiKQ0KPiA+ICt7
DQo+ID4gKyAgICAgY29uc3Qgc3RydWN0IHBjaV9lcGNfZmVhdHVyZXMgKmVwY19mZWF0dXJlczsN
Cj4gPiArICAgICBzaXplX3Qgc2l6ZSA9IDQgKiBudGItPmRiX2NvdW50Ow0KPiA+ICsgICAgIHUz
MiBhbGlnbjsNCj4gPiArDQo+ID4gKyAgICAgZXBjX2ZlYXR1cmVzID0gcGNpX2VwY19nZXRfZmVh
dHVyZXMobnRiLT5lcGYtPmVwYywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBudGItPmVwZi0+ZnVuY19ubywNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBudGItPmVwZi0+dmZ1bmNfbm8pOw0KPiA+ICsgICAgIGFsaWdu
ID0gZXBjX2ZlYXR1cmVzLT5hbGlnbjsNCj4gPiArDQo+ID4gKyAgICAgaWYgKHNpemUgPCAxMjgp
DQo+ID4gKyAgICAgICAgICAgICBzaXplID0gMTI4Ow0KPiA+ICsNCj4gPiArICAgICBpZiAoYWxp
Z24pDQo+ID4gKyAgICAgICAgICAgICBzaXplID0gQUxJR04oc2l6ZSwgYWxpZ24pOw0KPiA+ICsg
ICAgIGVsc2UNCj4gPiArICAgICAgICAgICAgIHNpemUgPSByb3VuZHVwX3Bvd19vZl90d28oc2l6
ZSk7DQo+ID4gKw0KPiA+ICsgICAgIHJldHVybiBzaXplOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICAv
KioNCj4gPiAgICogZXBmX250Yl9kYl9iYXJfaW5pdCgpIC0gQ29uZmlndXJlIERvb3JiZWxsIHdp
bmRvdyBCQVJzDQo+ID4gICAqIEBudGI6IE5UQiBkZXZpY2UgdGhhdCBmYWNpbGl0YXRlcyBjb21t
dW5pY2F0aW9uIGJldHdlZW4gSE9TVCBhbmQNCj4gdkhPU1QNCj4gPiBAQCAtNTIwLDM1ICs1NDMs
MzMgQEAgc3RhdGljIGludCBlcGZfbnRiX2RiX2Jhcl9pbml0KHN0cnVjdCBlcGZfbnRiDQo+ICpu
dGIpDQo+ID4gICAgICAgc3RydWN0IGRldmljZSAqZGV2ID0gJm50Yi0+ZXBmLT5kZXY7DQo+ID4g
ICAgICAgaW50IHJldDsNCj4gPiAgICAgICBzdHJ1Y3QgcGNpX2VwZl9iYXIgKmVwZl9iYXI7DQo+
ID4gLSAgICAgdm9pZCBfX2lvbWVtICptd19hZGRyOw0KPiA+ICsgICAgIHZvaWQgX19pb21lbSAq
bXdfYWRkciA9IE5VTEw7DQo+ID4gICAgICAgZW51bSBwY2lfYmFybm8gYmFybm87DQo+ID4gLSAg
ICAgc2l6ZV90IHNpemUgPSA0ICogbnRiLT5kYl9jb3VudDsNCj4gPiArICAgICBzaXplX3Qgc2l6
ZTsNCj4gPg0KPiA+ICAgICAgIGVwY19mZWF0dXJlcyA9IHBjaV9lcGNfZ2V0X2ZlYXR1cmVzKG50
Yi0+ZXBmLT5lcGMsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgbnRiLT5lcGYtPmZ1bmNfbm8sDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgbnRiLT5lcGYtPnZmdW5jX25vKTsNCj4gPiAgICAgICBhbGlnbiA9IGVwY19m
ZWF0dXJlcy0+YWxpZ247DQo+ID4gLQ0KPiA+IC0gICAgIGlmIChzaXplIDwgMTI4KQ0KPiA+IC0g
ICAgICAgICAgICAgc2l6ZSA9IDEyODsNCj4gPiAtDQo+ID4gLSAgICAgaWYgKGFsaWduKQ0KPiA+
IC0gICAgICAgICAgICAgc2l6ZSA9IEFMSUdOKHNpemUsIGFsaWduKTsNCj4gPiAtICAgICBlbHNl
DQo+ID4gLSAgICAgICAgICAgICBzaXplID0gcm91bmR1cF9wb3dfb2ZfdHdvKHNpemUpOw0KPiA+
ICsgICAgIHNpemUgPSBlcGZfbnRiX2RiX3NpemUobnRiKTsNCj4gPg0KPiA+ICAgICAgIGJhcm5v
ID0gbnRiLT5lcGZfbnRiX2JhcltCQVJfREJdOw0KPiA+ICsgICAgIGVwZl9iYXIgPSAmbnRiLT5l
cGYtPmJhcltiYXJub107DQo+ID4NCj4gPiAtICAgICBtd19hZGRyID0gcGNpX2VwZl9hbGxvY19z
cGFjZShudGItPmVwZiwgc2l6ZSwgYmFybm8sIGFsaWduLCAwKTsNCj4gPiAtICAgICBpZiAoIW13
X2FkZHIpIHsNCj4gPiAtICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGFsbG9j
YXRlIE9CIGFkZHJlc3NcbiIpOw0KPiA+IC0gICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+
ID4gKyAgICAgaWYgKCFudGItPmVwZl9kYl9waHkpIHsNCj4gPiArICAgICAgICAgICAgIG13X2Fk
ZHIgPSBwY2lfZXBmX2FsbG9jX3NwYWNlKG50Yi0+ZXBmLCBzaXplLCBiYXJubywgYWxpZ24sIDAp
Ow0KPiA+ICsgICAgICAgICAgICAgaWYgKCFtd19hZGRyKSB7DQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgIGRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGFsbG9jYXRlIE9CIGFkZHJlc3NcbiIpOw0K
PiANCj4gRXhwYW5kIE9CLg0KPiANCj4gPiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1F
Tk9NRU07DQo+ID4gKyAgICAgICAgICAgICB9DQo+ID4gKyAgICAgfSBlbHNlIHsNCj4gPiArICAg
ICAgICAgICAgIGVwZl9iYXItPnBoeXNfYWRkciA9IG50Yi0+ZXBmX2RiX3BoeTsNCj4gPiArICAg
ICAgICAgICAgIGVwZl9iYXItPmJhcm5vID0gYmFybm87DQo+ID4gKyAgICAgICAgICAgICBlcGZf
YmFyLT5zaXplID0gc2l6ZTsNCj4gPiAgICAgICB9DQo+ID4NCj4gPiAgICAgICBudGItPmVwZl9k
YiA9IG13X2FkZHI7DQo+ID4NCj4gPiAtICAgICBlcGZfYmFyID0gJm50Yi0+ZXBmLT5iYXJbYmFy
bm9dOw0KPiA+IC0NCj4gPiAgICAgICByZXQgPSBwY2lfZXBjX3NldF9iYXIobnRiLT5lcGYtPmVw
YywgbnRiLT5lcGYtPmZ1bmNfbm8sIG50Yi0+ZXBmLQ0KPiA+dmZ1bmNfbm8sIGVwZl9iYXIpOw0K
PiA+ICAgICAgIGlmIChyZXQpIHsNCj4gPiAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiRG9v
cmJlbGwgQkFSIHNldCBmYWlsZWRcbiIpOw0KPiA+IEBAIC03MDQsNiArNzI1LDc0IEBAIHN0YXRp
YyBpbnQgZXBmX250Yl9pbml0X2VwY19iYXIoc3RydWN0IGVwZl9udGINCj4gKm50YikNCj4gPiAg
ICAgICByZXR1cm4gMDsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB2b2lkIGVwZl9udGJfd3Jp
dGVfbXNpX21zZyhzdHJ1Y3QgbXNpX2Rlc2MgKmRlc2MsIHN0cnVjdCBtc2lfbXNnDQo+ICptc2cp
DQo+ID4gK3sNCj4gPiArICAgICBzdHJ1Y3QgZXBmX250YiAqbnRiID0gZGV2X2dldF9kcnZkYXRh
KGRlc2MtPmRldik7DQo+ID4gKyAgICAgc3RydWN0IGVwZl9udGJfY3RybCAqcmVnID0gbnRiLT5y
ZWc7DQo+ID4gKyAgICAgaW50IHNpemUgPSBlcGZfbnRiX2RiX3NpemUobnRiKTsNCj4gPiArICAg
ICB1NjQgYWRkcjsNCj4gPiArDQo+ID4gKyAgICAgYWRkciA9IG1zZy0+YWRkcmVzc19oaTsNCj4g
PiArICAgICBhZGRyIDw8PSAzMjsNCj4gPiArICAgICBhZGRyIHw9IG1zZy0+YWRkcmVzc19sbzsN
Cj4gPiArDQo+ID4gKyAgICAgcmVnLT5kYl9kYXRhW2Rlc2MtPm1zaV9pbmRleF0gPSBtc2ctPmRh
dGE7DQo+ID4gKw0KPiA+ICsgICAgIGlmIChkZXNjLT5tc2lfaW5kZXggPT0gMCkNCj4gPiArICAg
ICAgICAgICAgIG50Yi0+ZXBmX2RiX3BoeSA9IHJvdW5kX2Rvd24oYWRkciwgc2l6ZSk7DQo+ID4g
Kw0KPiA+ICsgICAgIHJlZy0+ZGJfb2Zmc2V0W2Rlc2MtPm1zaV9pbmRleF0gPSBhZGRyIC0gbnRi
LT5lcGZfZGJfcGh5Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaXJxcmV0dXJuX3QgZXBm
X250Yl9pbnRlcnJ1cHRfaGFuZGxlcihpbnQgaXJxLCB2b2lkICpkYXRhKQ0KPiA+ICt7DQo+ID4g
KyAgICAgc3RydWN0IGVwZl9udGIgKm50YiA9IGRhdGE7DQo+ID4gKyAgICAgaW50IGluZGV4Ow0K
PiA+ICsNCj4gPiArICAgICBpbmRleCA9IGlycSAtIG50Yi0+bXNpX3ZpcnFiYXNlOw0KPiA+ICsg
ICAgIG50Yi0+ZGIgfD0gMSA8PCAoaW5kZXggLSAxKTsNCj4gPiArICAgICBudGJfZGJfZXZlbnQo
Jm50Yi0+bnRiLCBpbmRleCk7DQo+ID4gKw0KPiA+ICsgICAgIHJldHVybiBJUlFfSEFORExFRDsN
Cj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgZXBmX250Yl9lcGNfbXNpX2luaXQoc3Ry
dWN0IGVwZl9udGIgKm50YikNCj4gPiArew0KPiA+ICsgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9
ICZudGItPmVwZi0+ZGV2Ow0KPiA+ICsgICAgIHN0cnVjdCBpcnFfZG9tYWluICpkb21haW47DQo+
ID4gKyAgICAgaW50IHZpcnE7DQo+ID4gKyAgICAgaW50IHJldDsNCj4gPiArICAgICBpbnQgaTsN
Cj4gPiArDQo+ID4gKyAgICAgZG9tYWluID0gZGV2X2dldF9tc2lfZG9tYWluKG50Yi0+ZXBmLT5l
cGMtPmRldi5wYXJlbnQpOw0KPiA+ICsgICAgIGlmICghZG9tYWluKQ0KPiA+ICsgICAgICAgICAg
ICAgcmV0dXJuOw0KPiA+ICsNCj4gPiArICAgICBkZXZfc2V0X21zaV9kb21haW4oZGV2LCBkb21h
aW4pOw0KPiA+ICsNCj4gPiArICAgICBpZiAocGxhdGZvcm1fbXNpX2RvbWFpbl9hbGxvY19pcnFz
KCZudGItPmVwZi0+ZGV2LA0KPiA+ICsgICAgICAgICAgICAgbnRiLT5kYl9jb3VudCwNCj4gPiAr
ICAgICAgICAgICAgIGVwZl9udGJfd3JpdGVfbXNpX21zZykpIHsNCj4gPiArICAgICAgICAgICAg
IGRldl9pbmZvKGRldiwgIkNhbid0IGFsbG9jYXRlIE1TSSwgZmFsbCBiYWNrIHRvIHBvbGwgbW9k
ZVxuIik7DQo+ID4gKyAgICAgICAgICAgICByZXR1cm47DQo+ID4gKyAgICAgfQ0KPiA+ICsNCj4g
PiArICAgICBkZXZfaW5mbyhkZXYsICJ2bnRiIHVzZSBNU0kgYXMgZG9vcmJlbGxcbiIpOw0KPiA+
ICsNCj4gDQo+IFdoeSBhcmUgeW91IHVzaW5nIHRoZSBpbnRlcnJ1cHQgY29udHJvbGxlciBhcyB0
aGUgTVNJIGNvbnRyb2xsZXI/IFdoeSBub3QNCj4ganVzdA0KPiBhIHBsYWluIGludGVycnVwdCBj
b250cm9sbGVyPw0KPiANCj4gPiArICAgICBmb3IgKGkgPSAwOyBpIDwgbnRiLT5kYl9jb3VudDsg
aSsrKSB7DQo+ID4gKyAgICAgICAgICAgICB2aXJxID0gbXNpX2dldF92aXJxKGRldiwgaSk7DQo+
ID4gKyAgICAgICAgICAgICByZXQgPSBkZXZtX3JlcXVlc3RfaXJxKGRldiwgdmlycSwNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVwZl9udGJfaW50ZXJydXB0X2hhbmRsZXIsIDAs
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAibnRiIiwgbnRiKTsNCj4gDQo+ICJu
dGIiIGFzIGEgSVJRIG5hbWUgc2VlbXMgcXVpdGUgZ2VuZXJpYy4gWW91IG1pZ2h0IHdhbnQgdG8g
cHJlZml4IGl0IHdpdGggZXBmDQo+IG9yIHZudGIuLi4NCj4gDQo+IFRoYW5rcywNCj4gTWFuaQ0K
PiANCj4gPiArDQo+ID4gKyAgICAgICAgICAgICBpZiAocmV0KQ0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICBkZXZfZXJyKGRldiwgImRldm1fcmVxdWVzdF9pcnEoKSBmYWlsdXJlXG4iKTsNCj4g
PiArDQo+ID4gKyAgICAgICAgICAgICBpZiAoIWkpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
IG50Yi0+bXNpX3ZpcnFiYXNlID0gdmlycTsNCj4gPiArICAgICB9DQo+ID4gK30NCj4gPiArDQo+
ID4gIC8qKg0KPiA+ICAgKiBlcGZfbnRiX2VwY19pbml0KCkgLSBJbml0aWFsaXplIE5UQiBpbnRl
cmZhY2UNCj4gPiAgICogQG50YjogTlRCIGRldmljZSB0aGF0IGZhY2lsaXRhdGVzIGNvbW11bmlj
YXRpb24gYmV0d2VlbiBIT1NUIGFuZA0KPiB2SE9TVDINCj4gPiBAQCAtMTI5OSwxNCArMTM4OCwx
NSBAQCBzdGF0aWMgaW50IGVwZl9udGJfYmluZChzdHJ1Y3QgcGNpX2VwZiAqZXBmKQ0KPiA+ICAg
ICAgICAgICAgICAgZ290byBlcnJfYmFyX2FsbG9jOw0KPiA+ICAgICAgIH0NCj4gPg0KPiA+ICsg
ICAgIGVwZl9zZXRfZHJ2ZGF0YShlcGYsIG50Yik7DQo+ID4gKyAgICAgZXBmX250Yl9lcGNfbXNp
X2luaXQobnRiKTsNCj4gPiArDQo+ID4gICAgICAgcmV0ID0gZXBmX250Yl9lcGNfaW5pdChudGIp
Ow0KPiA+ICAgICAgIGlmIChyZXQpIHsNCj4gPiAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAi
RmFpbGVkIHRvIGluaXRpYWxpemUgRVBDXG4iKTsNCj4gPiAgICAgICAgICAgICAgIGdvdG8gZXJy
X2Jhcl9hbGxvYzsNCj4gPiAgICAgICB9DQo+ID4NCj4gPiAtICAgICBlcGZfc2V0X2RydmRhdGEo
ZXBmLCBudGIpOw0KPiA+IC0NCj4gPiAgICAgICBwY2lfc3BhY2VbMF0gPSAobnRiLT52bnRiX3Bp
ZCA8PCAxNikgfCBudGItPnZudGJfdmlkOw0KPiA+ICAgICAgIHBjaV92bnRiX3RhYmxlWzBdLnZl
bmRvciA9IG50Yi0+dm50Yl92aWQ7DQo+ID4gICAgICAgcGNpX3ZudGJfdGFibGVbMF0uZGV2aWNl
ID0gbnRiLT52bnRiX3BpZDsNCj4gPiAtLQ0KPiA+IDIuMzUuMQ0KPiA+DQo+IA0KPiAtLQ0KPiDg
rq7grqPgrr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+NDQo=
