Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030AD60FD05
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 18:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbiJ0QZb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 12:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbiJ0QZI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 12:25:08 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70049.outbound.protection.outlook.com [40.107.7.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F026473;
        Thu, 27 Oct 2022 09:25:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXiMKjslZ7phIqvV2Vh13SDdu1WNPyi/AV1C7ex9xEB00YyGYu+RS+6DwnxptD/Rp2T+DH6C/Q9RQWyI5B6XFEXqXTkBO81J1O3xnChXSsS4O6HdMkA/kdHnv4z8cPGkcVgg3bGoXewH5N0spAVNeN1tVPzdErahlZlBOgMA5KKg/mDkhFVYfD0Zip56gF95RSvOouO6Fz2GZ9/atCzfALq2Joi44cty3mp+Hx4PIJoo6kZoKnyLxWwYu47ci7YeAdce7CuUDV9alNPA8b61xGoOf6cskddZkb00Nz1qGFL7ZLTGyhms7/4Hq8+IPyzSfqu2xqYhLwW06thOJpiVmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpYlwC+HpeApD/D3o2bHADQ2ixW08fB+Mdzv+mbgCOE=;
 b=ILxMyLB1UpYSTWiiYc6kg4Qb5sAIqThzw2U22MwS/hO8RaxV3fkAmyTYZ6bfqXIyCSvxLMm2e2uytyprZyaBJYFvGqp9ookvSevp+AOGDYUUvxpCChc+QJ3HpVIfNQW02E0ICe3rVaUQ8/3B1KSWQ3ObJsc+VKpiMFrorpRJj8ICR5wcw7zhWWvEuE4dIqvr7GWuOZT/NbHouULeAelsLAn+Gxq2DTU2rBHX8qSSQNjxUEaE/D/6gOzxheZG3Hkv8ePu4f6RskV8VVJhADyp/n0dCj2IJi665/oEGatpcpMHcT45YD46/ciz+2mad/YavLEqCMjR+aR5/KUK3lgpsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpYlwC+HpeApD/D3o2bHADQ2ixW08fB+Mdzv+mbgCOE=;
 b=PyAvxtIwz4X6l4raytm5vSfGMvcsqVMlcFeXsMH5Oj5PkNP9QhSCAl3brEJaIrcHeTgqh9+6lPtSUGqjhDN4aoJh3sa0xbUEInmiQO+sQwurEnSPdahQJiVVVCkgC7ZwqGN9S4t2y8PkNCZRf78dpgUN7xro3Ic4SO4N/juvn0w=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DBBPR04MB7818.eurprd04.prod.outlook.com (2603:10a6:10:1f2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Thu, 27 Oct
 2022 16:25:02 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%10]) with mapi id 15.20.5746.028; Thu, 27 Oct
 2022 16:25:02 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Shunsuke Mie <mie@igel.co.jp>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v2] PCI: endpoint: pci-epf-{,v}ntb: fix a check
 for no epc alignment constraint
Thread-Topic: [EXT] Re: [PATCH v2] PCI: endpoint: pci-epf-{,v}ntb: fix a check
 for no epc alignment constraint
Thread-Index: AQHY6H0/bvuG5O/HGUqsNICaEl4Piq4fRolwgAIzcoCAANaFIIAAC4kAgAABBFCAAA73AIAAAb7A
Date:   Thu, 27 Oct 2022 16:25:01 +0000
Message-ID: <HE1PR0401MB2331032AECAE30A8C31AF01A88339@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20220922092357.123732-1-mie@igel.co.jp>
 <20221025142143.GA109941@thinkpad>
 <HE1PR0401MB233126D2C7410EC5F6C3976488319@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <CANXvt5qjnbZMzFJt8kBtQz6FHc_QQYw7=fZp8kK87mZ-t75z+g@mail.gmail.com>
 <HE1PR0401MB23319EE329D62420919740C688339@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <20221027151220.GC76627@thinkpad>
 <HE1PR0401MB233111DEC8F76341029183F188339@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <20221027160932.GD76627@thinkpad>
In-Reply-To: <20221027160932.GD76627@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|DBBPR04MB7818:EE_
x-ms-office365-filtering-correlation-id: ccd25aba-b0d6-4b6c-334f-08dab837cc75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gDCX+D6Uezepuw3Z5ogklBNnN+CnCyLpsuR7ihLkoynIMcTX2iGaoFN/VopT6MBDLvs4+etJgapnM38sv74VMQtisX3uTnfrkhqNJjFcMzL119HMFOQEFjvB7fQh5FaLw76qC+dbteTST6GpT7OLP7Aasd4XVXDPZ4EqtV8nRa9x/kYy2cMlSaj4AOnjAB4MfOp/nI1lUmJpTL2ema2iEzxa7PefoVDedOTvrKCJgCEoan58CneGDE6POMf8D8RzYUZ5o05iOW9HV/Nmhaf0fb1xc1WxcoW//l7Yu0GWXnd7j1QKpN5HJvr1nOSbwyfTBCBWVtsrs0HPMLJIuLR/J7U8Tv94mrOERlL0JTDK2PJWOvojhzkcpCRD5AvOLonuaRbvdZqTaWUNdkxq7FTPMVeouuE1ax/QcceeKtRNdEv7DQGVvyWI3UYNltF/WkCN3JQsFpIiqTCDxVXw0or2fkta6H8KC9Ec4RZSVWGpf1DJjl4rjTp1ubKt7GrWlWfux8D0FAfnnoDuUlNR3laBM/UZdyDXV3aAduSEJm8xg8qlXahtSRUuJR1XGHkKyFNjSei3/wGc8+nCwJLoUPYz80ZD0bR9oCy7Czp1/B3stwsQQUZg/dN0e6cTvZj+suEsldAsbkPAxY+XuODWvtL73j7E1enRM9thQ1TZd6Ash+xZMeKWcmt4OhqbtssoAKTySYZfNEtwpyAr3nPFnMBYE4CDS8pBDXq3CIL18J0AqBIUqwJ31klIfKC5Eovc96MarP0sMbDts/pCjCv6zapsug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199015)(66946007)(33656002)(44832011)(2906002)(38100700002)(83380400001)(38070700005)(4326008)(186003)(66574015)(66556008)(55016003)(6506007)(7696005)(71200400001)(76116006)(53546011)(122000001)(66476007)(6916009)(86362001)(316002)(64756008)(26005)(66446008)(9686003)(55236004)(54906003)(478600001)(52536014)(5660300002)(7416002)(8936002)(8676002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bU5zWlFPdDRVYXVMcEJ6MTgzN3JydmZJeTZuQ3NGdlY4U21nbXJjT3UrYXBs?=
 =?utf-8?B?eGpIdG9LYWRWb2FXODRudFFadHA1bjJqR0c2UEd1eENHSnVqWWJGdWFFT2VY?=
 =?utf-8?B?RCtRbTZ6Ymt6SlhSdE4wNzRtSk5PdmdpbEg2Uml0bk5MelJaV21KYnJraDJY?=
 =?utf-8?B?THZ3blZUbTJYYTJNbDhya0NUTG1jdk1Jc0tsMmxJby8zTDJMVlZ3ZDNTdTVK?=
 =?utf-8?B?OXYxZFpqczE1OEVZczlTYmxaVmUrSkRjejRVZysxWjRBNGZWYzRzamtkWUVt?=
 =?utf-8?B?YzBORGF1eUtSWE1vNENUU2M5SGU0cGI1R3J3T3dOeWM0Z0hIRE1ieDIvQ0VF?=
 =?utf-8?B?MHZzYktlSEQwcDhrZ2x2Q0FMeDVsTjNuU3lQSWlJUHhqTWZXUkwyV0FKQ1Zs?=
 =?utf-8?B?TFh2M0FpaDdhZHZ6TTVXS3FOVkpNZTVLTWphMHZjd3NVemVwYXNBaUpFVGEr?=
 =?utf-8?B?WFlKdGowZmc3RDRXc0VwbFRpaFE2MXNrcFJsbDRCaGgrU3JDOWRiVGp2VjBk?=
 =?utf-8?B?SWtWUEpBRFN6U01oTXdXTEFaTmFHS2xSNjdEWTVjQUlHaDljQ01EWFNrcXJk?=
 =?utf-8?B?UjBHWVlnQXBKTlphM2pBU1Mwc1BJV2JFR3JWTjZSamVqU1ByNCtuZmNzQTlZ?=
 =?utf-8?B?NnFFZU5ubjhLc2RwanYxNzNROE50bm5IZEpueDdTd0NLejB2RmZTbGI4YVhw?=
 =?utf-8?B?QnFGTWYvamtmQWtrWkJTQkhZN0NIeWdaR0NPaUE4VGlhempaUmVmNWc2MkJF?=
 =?utf-8?B?WnF0NWxxN1cxUGd3RXFaUHpUUjVnQ0t6T1A5R25weDBwWnMzMU1adXFLbEM3?=
 =?utf-8?B?MmIvdndXV2dXZ21jajNaYzByamdhd3dGTUpxQy9IQ2NKdUx3a0o5WXdKY2tH?=
 =?utf-8?B?eWRoTWNZcnpLbEJ5Rm1kaEE3Y1p5eWRVWStWNUROdlBYME9meHBnWG5VUGdY?=
 =?utf-8?B?aTFTSUE3bGpYelJFc3Jua0RhdUVhNVVHWityZm1oU3hWUnhQZzNZYWZ3ZGww?=
 =?utf-8?B?dEF2Yy8yYm1SYUNTTGdmbC9GZ1FDcG5LZjV5Ym5FT1RBNzM3SXNXbDZCNnk4?=
 =?utf-8?B?NXJldS96ajNTblVUMkgzSWFUanAzcnVtdjZ3VHNId2EwcTJGTHJzRUp2Y2tm?=
 =?utf-8?B?VDIvaGZ6d1dNdUloVjBNL3VEck45MHJCOGczRlRSeHBMaDBBaXdIMTVHNzZR?=
 =?utf-8?B?WS9ZUHZ3VHBCNVNQVlRGK0JFeE9pV09YM1FPSTB2RXpEQWpydGZDOWErTW9W?=
 =?utf-8?B?WUM0UHZld29nS2Y4cXpTNVJhcGRRTHJkNEJINHBWeng3MS9vSE94TlpDUnY5?=
 =?utf-8?B?Njk5MDh3Ty9waCt3QkdITkRub21PcU4rbG10ZEpocTJ2YVc2UkJ5T2JJb3NS?=
 =?utf-8?B?MTZadGJta1RrdGJjSEpsRTErYWJLQTFOck1pUEp6T2ZzQUI5SW14ZW1NMGpp?=
 =?utf-8?B?OEpHZnptbTRodEFBazZscE1rK1ZNNmprRTlSZXNzcHc0QWJOaThwc1Z4cWcr?=
 =?utf-8?B?NC9IYWVaUHN1Zk9HVzhTcURXK3pKYzBQZXFGKzRSeU5LcHFzSXg4ZG93NCtO?=
 =?utf-8?B?Q1ZCQTErNmlUT2RVWUZLVUtyOTl1ZlpzUFpwM2tHTVB5NmtlQjN2S0w4Rmhh?=
 =?utf-8?B?MGtwamxOSU1GeWlXNGRNV1hPRkpaRkE3Z04zYXhFV21pSVpaNW9yaGhkUFF4?=
 =?utf-8?B?T2d4NUt5S2UrQnVCbW9uSFcwY0VWeG9LTXRMRU9aNnlORWFxUGVCUWlIeDBR?=
 =?utf-8?B?SnRqSEU2T2ZmY0owV1pEM3lxRE1TNDk5bTZMSjQydVFMaEZ6QlRHbFcybkR4?=
 =?utf-8?B?N3JyUjdtVEdyWGFHYWo0RGtLdVdaY0RHeGJDY1VObFp2cHpxY0F2STMvb1V5?=
 =?utf-8?B?U3ZuODZ5TkFleWVaL2tIeDBkcVZSaDhFTGdaZGNNQjVPRCsrY0dBY2p4a0p6?=
 =?utf-8?B?enVyancxcU9NWjJFeE0rdkxpL0c1TnFrNUczZEtDU1NEanJwNWZFNG5ldFl1?=
 =?utf-8?B?OU9EM3NOYzhrL1hobXA2eUUyZUlQRG1mU0hBeGJVd3Y4eEZPZit1VHpXREx3?=
 =?utf-8?B?bGhpbCtVS003R0dMVVh3T3VRR3hSUTZ6dVZDTUdLdkhLMVR3NGJnN3JNOXJs?=
 =?utf-8?Q?f/ds=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd25aba-b0d6-4b6c-334f-08dab837cc75
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 16:25:01.8978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OiRlwFbqKqyQkQvaMUdm2NbbhzrHiptH+BNFxvU+YJOSeI5kYJ+tUCUtQ3pnupY6qzcTU8QlSCSgwKjOEouyYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7818
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFuaXZhbm5hbiBTYWRo
YXNpdmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZz4NCj4gU2VudDogVGh1cnNk
YXksIE9jdG9iZXIgMjcsIDIwMjIgMTE6MTAgQU0NCj4gVG86IEZyYW5rIExpIDxmcmFuay5saUBu
eHAuY29tPg0KPiBDYzogU2h1bnN1a2UgTWllIDxtaWVAaWdlbC5jby5qcD47IEpvbiBNYXNvbiA8
amRtYXNvbkBrdWR6dS51cz47IERhdmUNCj4gSmlhbmcgPGRhdmUuamlhbmdAaW50ZWwuY29tPjsg
QWxsZW4gSHViYmUgPGFsbGVuYmhAZ21haWwuY29tPjsNCj4ga2lzaG9uQGtlcm5lbC5vcmc7IExv
cmVuem8gUGllcmFsaXNpIDxscGllcmFsaXNpQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YNCj4gV2ls
Y3p5xYRza2kgPGt3QGxpbnV4LmNvbT47IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5j
b20+Ow0KPiBudGJAbGlzdHMubGludXguZGV2OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbRVhUXSBSZTogW1BB
VENIIHYyXSBQQ0k6IGVuZHBvaW50OiBwY2ktZXBmLXssdn1udGI6IGZpeCBhIGNoZWNrIGZvcg0K
PiBubyBlcGMgYWxpZ25tZW50IGNvbnN0cmFpbnQNCj4gDQo+IENhdXRpb246IEVYVCBFbWFpbA0K
PiANCj4gW0FkZGVkIEtpc2hvbidzIG5ldyBlbWFpbCBhZGRyZXNzIGFuZCByZW1vdmVkIHRoZSBv
bGQgb25lXQ0KPiANCj4gT24gVGh1LCBPY3QgMjcsIDIwMjIgYXQgMDM6MzQ6MTFQTSArMDAwMCwg
RnJhbmsgTGkgd3JvdGU6DQo+ID4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPiA+IEZyb206IE1hbml2YW5uYW4gU2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNp
dmFtQGxpbmFyby5vcmc+DQo+ID4gPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAyNywgMjAyMiAx
MDoxMiBBTQ0KPiA+ID4gVG86IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPg0KPiA+ID4gQ2M6
IFNodW5zdWtlIE1pZSA8bWllQGlnZWwuY28uanA+OyBKb24gTWFzb24gPGpkbWFzb25Aa3VkenUu
dXM+Ow0KPiBEYXZlDQo+ID4gPiBKaWFuZyA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+OyBBbGxlbiBI
dWJiZSA8YWxsZW5iaEBnbWFpbC5jb20+Ow0KPiBLaXNob24NCj4gPiA+IFZpamF5IEFicmFoYW0g
SSA8a2lzaG9uQHRpLmNvbT47IExvcmVuem8gUGllcmFsaXNpDQo+IDxscGllcmFsaXNpQGtlcm5l
bC5vcmc+Ow0KPiA+ID4gS3J6eXN6dG9mIFdpbGN6ecWEc2tpIDxrd0BsaW51eC5jb20+OyBCam9y
biBIZWxnYWFzDQo+ID4gPiA8YmhlbGdhYXNAZ29vZ2xlLmNvbT47IG50YkBsaXN0cy5saW51eC5k
ZXY7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnDQo+ID4gPiBTdWJqZWN0OiBSZTogW0VYVF0gUmU6IFtQQVRDSCB2Ml0gUENJOiBl
bmRwb2ludDogcGNpLWVwZi17LHZ9bnRiOiBmaXggYSBjaGVjaw0KPiBmb3INCj4gPiA+IG5vIGVw
YyBhbGlnbm1lbnQgY29uc3RyYWludA0KPiA+ID4NCj4gPiA+IENhdXRpb246IEVYVCBFbWFpbA0K
PiA+ID4NCj4gPiA+IE9uIFRodSwgT2N0IDI3LCAyMDIyIGF0IDAyOjM1OjU2UE0gKzAwMDAsIEZy
YW5rIExpIHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4gPiA+ID4gRnJvbTogU2h1bnN1a2UgTWllIDxtaWVAaWdlbC5jby5q
cD4NCj4gPiA+ID4gPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMjYsIDIwMjIgODo0MyBQTQ0K
PiA+ID4gPiA+IFRvOiBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT4NCj4gPiA+ID4gPiBDYzog
TWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZz47
DQo+IEpvbg0KPiA+ID4gPiA+IE1hc29uIDxqZG1hc29uQGt1ZHp1LnVzPjsgRGF2ZSBKaWFuZyA8
ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+Ow0KPiBBbGxlbg0KPiA+ID4gPiA+IEh1YmJlIDxhbGxlbmJo
QGdtYWlsLmNvbT47IEtpc2hvbiBWaWpheSBBYnJhaGFtIEkNCj4gPGtpc2hvbkB0aS5jb20+Ow0K
PiA+ID4gPiA+IExvcmVuem8gUGllcmFsaXNpIDxscGllcmFsaXNpQGtlcm5lbC5vcmc+OyBLcnp5
c3p0b2YgV2lsY3p5xYRza2kNCj4gPiA+ID4gPiA8a3dAbGludXguY29tPjsgQmpvcm4gSGVsZ2Fh
cyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT47DQo+ID4gPiA+ID4gbnRiQGxpc3RzLmxpbnV4LmRldjsg
bGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+ID4gPiBrZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+ID4gPiA+ID4gU3ViamVjdDogUmU6IFtFWFRdIFJlOiBbUEFUQ0ggdjJdIFBDSTog
ZW5kcG9pbnQ6IHBjaS1lcGYteyx2fW50YjogZml4IGENCj4gY2hlY2sNCj4gPiA+IGZvcg0KPiA+
ID4gPiA+IG5vIGVwYyBhbGlnbm1lbnQgY29uc3RyYWludA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
Q2F1dGlvbjogRVhUIEVtYWlsDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBIaSBGcmFuaywNCj4gPiA+
ID4gPg0KPiA+ID4gPiA+IDIwMjLlubQxMOaciDI25pelKOawtCkgMTowNyBGcmFuayBMaSA8ZnJh
bmsubGlAbnhwLmNvbT46DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+ID4gPiA+IEZy
b206IE1hbml2YW5uYW4gU2FkaGFzaXZhbQ0KPiA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFy
by5vcmc+DQo+ID4gPiA+ID4gPiA+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjUsIDIwMjIgOToy
MiBBTQ0KPiA+ID4gPiA+ID4gPiBUbzogU2h1bnN1a2UgTWllIDxtaWVAaWdlbC5jby5qcD4NCj4g
PiA+ID4gPiA+ID4gQ2M6IEpvbiBNYXNvbiA8amRtYXNvbkBrdWR6dS51cz47IERhdmUgSmlhbmcN
Cj4gPiA+IDxkYXZlLmppYW5nQGludGVsLmNvbT47DQo+ID4gPiA+ID4gPiA+IEFsbGVuIEh1YmJl
IDxhbGxlbmJoQGdtYWlsLmNvbT47IEtpc2hvbiBWaWpheSBBYnJhaGFtIEkNCj4gPiA+ID4gPiA+
ID4gPGtpc2hvbkB0aS5jb20+OyBMb3JlbnpvIFBpZXJhbGlzaSA8bHBpZXJhbGlzaUBrZXJuZWwu
b3JnPjsNCj4gS3J6eXN6dG9mDQo+ID4gPiA+ID4gPiA+IFdpbGN6ecWEc2tpIDxrd0BsaW51eC5j
b20+OyBCam9ybiBIZWxnYWFzDQo+IDxiaGVsZ2Fhc0Bnb29nbGUuY29tPjsNCj4gPiA+ID4gPiA+
ID4gbnRiQGxpc3RzLmxpbnV4LmRldjsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgt
DQo+ID4gPiA+ID4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gPiA+ID4gPiBTdWJqZWN0
OiBbRVhUXSBSZTogW1BBVENIIHYyXSBQQ0k6IGVuZHBvaW50OiBwY2ktZXBmLXssdn1udGI6IGZp
eCBhDQo+IGNoZWNrDQo+ID4gPiBmb3INCj4gPiA+ID4gPiBubw0KPiA+ID4gPiA+ID4gPiBlcGMg
YWxpZ25tZW50IGNvbnN0cmFpbnQNCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gQ2F1dGlv
bjogRVhUIEVtYWlsDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IE9uIFRodSwgU2VwIDIy
LCAyMDIyIGF0IDA2OjIzOjU3UE0gKzA5MDAsIFNodW5zdWtlIE1pZSB3cm90ZToNCj4gPiA+ID4g
PiA+ID4gPiBTb21lIFBDSSBlbmRwb2ludCBjb250cm9sbGVycyBoYXZlIG5vIGFsaWdubWVudCBj
b25zdHJhaW50cywNCj4gYW5kDQo+ID4gPiB0aGUNCj4gPiA+ID4gPiA+ID4gPiBlcGNfZmVhdHVy
ZXMtPmFsaWduIGJlY29tZXMgMC4gSW4gdGhpcyBjYXNlLCBJU19BTElHTkVEKCkgaW4NCj4gPiA+
ID4gPiA+DQo+ID4gPiA+ID4gPiBbRnJhbmsgTGldIHdoeSBub3Qgc2V0IGVwY19mZWF0dXJlcy0+
YWxpZ24gMQ0KPiA+ID4gPiA+ID4gbm8gYWxpZ25tZW50IGNvbnN0cmFpbnRzIHNob3VsZCBtZWFu
IGFsaWduIHRvIGJ5dGUuDQo+ID4gPiA+ID4gSXQgaXMgb25lIG9mIHRoZSBzb2x1dGlvbnMgdG9v
IEkgdGhpbmsuIEJ1dCBpbiB0aGF0IGNhc2UsICB3ZSBuZWVkIHRvDQo+ID4gPiA+ID4gd3JpdGUg
ZXBjX2ZlYXR1cmVzLT5hbGlnbiA9IDEgdG8gYWxsIGVwYyBkcml2ZXJzLCBkd2MsIHFjb20sIHJj
YXIsDQo+ID4gPiA+ID4gdGVncmEsIGFuZCBldGMuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJIHRo
aW5rIHRoYXQgbXkgY2hhbmdlIGlzIGJldHRlci4NCj4gPiA+ID4NCj4gPiA+ID4gSSB0aGluayBp
dCBzaG91bGQgYmUgYmFzZWQgb24gd2hhdCBvcmlnaW5hbCB0ZXJtIGRlZmluZWQuDQo+ID4gPiA+
IEl0IHNob3VsZCBiZSBmaXhlZCBhdCB3aGVyZSBtYWtlIG1pc3Rha2UuDQo+ID4gPiA+DQo+ID4g
Pg0KPiA+ID4gMWJ5dGUgaXMgdGhlIGRlZmF1bHQgYWxpZ25tZW50IHRoYXQgZHJpdmVycyBjYW4g
YXNzdW1lLCB3aHkgZG8geW91IHdhbnQNCj4gPiA+IGRyaXZlcnMNCj4gPiA+IHRvIHNldCB0aGVt
IGV4cGxpY2l0bHkgd2hlbiB0aGV5IGRvIG5vdCB3YW50IGFueSBzcGVjaWFsIGFsaWdubWVudD8N
Cj4gPg0KPiA+IFdoYXQncyBkZWZpbml0aW9uIG9mIG5vdCBhbGlnbm1lbnQgYnkgYWxpZ24gdmFy
aWFibGU/DQo+ID4gVXNpbmcgYm90aCAwIGFuZCAxIGFzIG5vIGFsaWdubWVudCBpcyBub3QgZ29v
ZCBlbm91Z2guDQo+ID4NCj4gPiBJIGdyZXAgd2hvbGUga2VybmVsIGRyaXZlciBkaXJlY3Rvcnks
IG5vdCBvbmUgdXNlDQo+ID4gICAgICAgSWYgKGFsaWduICYmIElTX0FMSUdORUQoeCwgYWxpZ24p
KSAgc3RhdGVtZW50Lg0KPiANCj4gSSBjYW4gc2VlIG11bHRpcGxlIGhpdHM6DQo+IA0KPiBsaWIv
dWJzYW4uYw0KPiBkcml2ZXJzL2dwdS9kcm0vaTkxNS9nZW0vaTkxNV9nZW1fZXhlY2J1ZmZlci5j
DQo+IGRyaXZlcnMvZ3B1L2RybS9pOTE1L2k5MTVfdm1hLmMNCj4gZHJpdmVycy9udmRpbW0vcGZu
X2RldnMuYw0KPiBkcml2ZXJzL21pc2MvcGNpX2VuZHBvaW50X3Rlc3QuYw0KPiANCj4gQnV0IGlu
IG1vc3Qgb2YgdGhlIHBsYWNlcywgdGhlIGFsaWdubWVudCBpcyBndWFyYW50ZWVkIHRvIGJlIHNl
dCBieSB0aGUgY2xpZW50DQo+IGRyaXZlcnMgYmVjYXVzZSB0aGV5IG1pZ2h0IGJlIHJlYWQgZnJv
bSB0aGUgaGFyZHdhcmUgcmVnaXN0ZXIgb3IgZml4ZWQgZm9yDQo+IGFuDQo+IElQLiBCdXQgaW4g
dGhpcyBjYXNlLCBJIGRvbid0IHRoaW5rIHdlIHNob3VsZCBfZm9yY2VfIHRoZSBkcml2ZXJzIHRv
IHNldA0KPiBhbGlnbm1lbnQgdG8gMSAoZGVmYXVsdCkgaWYgdGhleSBkb24ndCByZWFsbHkgY2Fy
ZSBhYm91dCBpdC4NCg0KSSBrZWVwIG15IG9waW5pb24uICBJIHRoaW5rIEVQIGNvbnRyb2xsZXIg
aGF2ZSBub3QgcmVwb3J0ZWQgY29ycmVjdCBkYXRhLg0KSGFyZHdhcmUgcmVnaXN0ZXIgYWxzbyBj
YW4gYmUgc2V0IDAgYXMgbm8gYWxpZ25tZW50IG1lYW5zLiANCkl0IGJyb2tlbiAiYWxpZ24iIGNv
bnZlcnNpb24uICANCg0KSWYgbW9zdCBwZW9wbGUgcHJlZmVyIHRoaXMgd2F5LCBJIHN1Z2dlc3Qg
Y2hhbmdlIGFwaSBkb2N1bWVudCBhdCANCkluY2x1ZGUvbGludXgvcGNpLWVwYy5oIHRvIGV4cGxp
Y2l0bHkgc2FpZCAwIGlzIHZhbGlkYXRlIG9wdGlvbi4gIA0KDQo+IA0KPiBUaGFua3MsDQo+IE1h
bmkNCj4gDQo+ID4NCj4gPiBUaGVyZSBhcmUgYSBjb21tb24gY29udmVudGlvbiwgYWxpZ24gaXMg
Ml5uDQo+ID4NCj4gPg0KPiA+ID4NCj4gPiA+IEkgdGhpbmsgdGhpcyBwYXRjaCBpcyBmaW5lLg0K
PiA+ID4NCj4gPiA+IFRoYW5rcywNCj4gPiA+IE1hbmkNCj4gPiA+DQo+ID4gPiA+IEFyZSB0aGVy
ZSBvdGhlciBwbGFjZSB1c2UgYWxpZ24gPT0gMCBtZWFucyBubyBhbGlnbm1lbnQgaW4ga2VybmVs
Pw0KPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gZXBmX250Yl9jb25maWdfc3Bh
ZF9iYXJfYWxsb2MoKSBkb2Vzbid0IHdvcmsgd2VsbC4gQ2hlY2sgZm9yDQo+IHRoaXMNCj4gPiA+
ID4gPiBiZWZvcmUNCj4gPiA+ID4gPiA+ID4gPiBJU19BTElHTkVEKCkuDQo+ID4gPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTaHVuc3VrZSBNaWUgPG1pZUBpZ2Vs
LmNvLmpwPg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBSZXZpZXdlZC1ieTogTWFuaXZh
bm5hbiBTYWRoYXNpdmFtDQo+ID4gPiA+ID4gPiA+IDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGlu
YXJvLm9yZz4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gVGhhbmtzLA0KPiA+ID4gPiA+
ID4gPiBNYW5pDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4g
PiA+ID4gQ2hhbmdlcyBpbiB2MjoNCj4gPiA+ID4gPiA+ID4gPiAqIEZpeCB0aGUgY29tbWl0IG1l
c3NhZ2UgaW4gcGhyYXNpbmdzIGFuZCB3b3Jkcy4NCj4gPiA+ID4gPiA+ID4gPiAtLS0NCj4gPiA+
ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ID4gPiAgZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVu
Y3Rpb25zL3BjaS1lcGYtbnRiLmMgIHwgMiArLQ0KPiA+ID4gPiA+ID4gPiA+ICBkcml2ZXJzL3Bj
aS9lbmRwb2ludC9mdW5jdGlvbnMvcGNpLWVwZi12bnRiLmMgfCAyICstDQo+ID4gPiA+ID4gPiA+
ID4gIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+
ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2Vu
ZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLW50Yi5jDQo+ID4gPiA+ID4gPiA+IGIvZHJpdmVycy9w
Y2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1lcGYtbnRiLmMNCj4gPiA+ID4gPiA+ID4gPiBpbmRl
eCA5YTAwNDQ4YzdlNjEuLmY3NDE1NWVlOGQ3MiAxMDA2NDQNCj4gPiA+ID4gPiA+ID4gPiAtLS0g
YS9kcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNpLWVwZi1udGIuYw0KPiA+ID4gPiA+
ID4gPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLW50Yi5j
DQo+ID4gPiA+ID4gPiA+ID4gQEAgLTEwMjEsNyArMTAyMSw3IEBAIHN0YXRpYyBpbnQNCj4gPiA+
ID4gPiBlcGZfbnRiX2NvbmZpZ19zcGFkX2Jhcl9hbGxvYyhzdHJ1Y3QNCj4gPiA+ID4gPiA+ID4g
ZXBmX250YiAqbnRiLA0KPiA+ID4gPiA+ID4gPiA+ICAgICAgIHBlZXJfc2l6ZSA9IHBlZXJfZXBj
X2ZlYXR1cmVzLT5iYXJfZml4ZWRfc2l6ZVtwZWVyX2Jhcm5vXTsNCj4gPiA+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gPiA+ICAgICAgIC8qIENoZWNrIGlmIGVwY19mZWF0dXJlcyBpcyBwb3B1bGF0
ZWQgaW5jb3JyZWN0bHkgKi8NCj4gPiA+ID4gPiA+ID4gPiAtICAgICBpZiAoKCFJU19BTElHTkVE
KHNpemUsIGFsaWduKSkpDQo+ID4gPiA+ID4gPiA+ID4gKyAgICAgaWYgKGFsaWduICYmICghSVNf
QUxJR05FRChzaXplLCBhbGlnbikpKQ0KPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgcmV0
dXJuIC1FSU5WQUw7DQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiAgICAgICBzcGFk
X2NvdW50ID0gbnRiLT5zcGFkX2NvdW50Ow0KPiA+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNpLWVwZi12bnRiLmMNCj4gPiA+ID4gPiA+
ID4gYi9kcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNpLWVwZi12bnRiLmMNCj4gPiA+
ID4gPiA+ID4gPiBpbmRleCAwZWE4NWUxZDI5MmUuLjVlMzQ2YzBhMGYwNSAxMDA2NDQNCj4gPiA+
ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNpLWVwZi12
bnRiLmMNCj4gPiA+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlv
bnMvcGNpLWVwZi12bnRiLmMNCj4gPiA+ID4gPiA+ID4gPiBAQCAtNDE4LDcgKzQxOCw3IEBAIHN0
YXRpYyBpbnQNCj4gPiA+IGVwZl9udGJfY29uZmlnX3NwYWRfYmFyX2FsbG9jKHN0cnVjdA0KPiA+
ID4gPiA+ID4gPiBlcGZfbnRiICpudGIpDQo+ID4gPiA+ID4gPiA+ID4gICAgICAgc2l6ZSA9IGVw
Y19mZWF0dXJlcy0+YmFyX2ZpeGVkX3NpemVbYmFybm9dOw0KPiA+ID4gPiA+ID4gPiA+ICAgICAg
IGFsaWduID0gZXBjX2ZlYXR1cmVzLT5hbGlnbjsNCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gPiA+IC0gICAgIGlmICgoIUlTX0FMSUdORUQoc2l6ZSwgYWxpZ24pKSkNCj4gPiA+ID4gPiA+
ID4gPiArICAgICBpZiAoYWxpZ24gJiYgIUlTX0FMSUdORUQoc2l6ZSwgYWxpZ24pKQ0KPiA+ID4g
PiA+ID4gPiA+ICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+ID4gPiAgICAgICBzcGFkX2NvdW50ID0gbnRiLT5zcGFkX2NvdW50Ow0KPiA+
ID4gPiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4gPiA+ID4gMi4xNy4xDQo+ID4gPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gLS0NCj4gPiA+ID4gPiA+ID4g4K6u4K6j4K6/
4K614K6j4K+N4K6j4K6p4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCvjQ0KPiA+ID4gPiA+DQo+
ID4gPiA+ID4gQmVzdCwNCj4gPiA+ID4gPiBTaHVuc3VrZQ0KPiA+ID4NCj4gPiA+IC0tDQo+ID4g
PiDgrq7grqPgrr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+NDQo+
IA0KPiAtLQ0KPiDgrq7grqPgrr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K61
4K6u4K+NDQo=
