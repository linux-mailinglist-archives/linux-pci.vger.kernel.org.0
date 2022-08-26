Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF095A2146
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 08:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245020AbiHZG5D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 02:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244690AbiHZG4p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 02:56:45 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A7AD21ED;
        Thu, 25 Aug 2022 23:56:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDpt5mNmbA3THfkXVFepvvKj4yjrpeZE83VbZnWhIcUVsuKQD0ZoJifkAIOoj7C+UEpy3411TBp3xscoXXkZmET5fiWkOi1M7XVKlxscUUpwTrBvO1JIOt1TocLuh3ibF+XBq49pceGtmBKrZMBZ2UVkJjevBENNyxH2JIcVlA8l191hlemMcMIUaImotGYk2cqmELBsWUFqgm8OP2+Wn/MuBDvIosWewqZuxRVZFG2noUvEjrb+gaYPd/aXwPGhYfRinixfMuEzFtaXaf+HJTpSzjsVjJDgBAz7o3IBkdH34p10v+96BhzApf3jx+aKg2wUmy++tTpJYKvQ2/Vsgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VU+LP/vSUmecEF811FI1WI+e7xc+92dYmPQWYowj+gA=;
 b=mCmW9+FHWewBTD59tV77OkwIP+Z534tlpqYiORff2kSBc8jUrHiiGZRmPicaNB4m2aS+O9d6tOTONRQMdY44C8+6uulEE3+LtabgK5AxyFKRWFg2pWBQQihTtrbBQjIwKK2quFHO2tuQRsHXMbVHBe4YJ7F8GfMlXtztUqo3kKUBpZ85wW28b5VOdZvJehflEp1TLRJBN3OkCZTT+jkKOInbNq58kZ7jY2D+2BJLZIWzL03O6mSaLg318NRXUCa+xcrU0Z6N3aJDmi98QsGe/3B7NOp1gjHdyQv2SyJ2v64FYqFdPTWrRbZWGriWFTDN178BPHmjvWEv94RSa7Kcjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VU+LP/vSUmecEF811FI1WI+e7xc+92dYmPQWYowj+gA=;
 b=lrtXgak0j797gCl3wx3RxNvmg85P6tU0VRv72k/lfGCOhHA0bRhyfS1zdIrlG4cIVsTkpXkmO0N46lal1F23uEvJiD0rwnCcvYYQrfylr6aTAQ8jkONsPpfVuloiRuQrDm01kFOc0U/2szaaAkTSSjCHW4fLMephr/jGahW3xQ4=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAXPR04MB8718.eurprd04.prod.outlook.com (2603:10a6:102:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 06:56:35 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da%9]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 06:56:35 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v1 0/2] Fix the wrong order of phy callbacks
Thread-Topic: [PATCH v1 0/2] Fix the wrong order of phy callbacks
Thread-Index: AQHYtisJvWRatmeqJkC37ps54LPbAa3AvRqAgAAHidA=
Date:   Fri, 26 Aug 2022 06:56:35 +0000
Message-ID: <AS8PR04MB867679A040E1926A93C5CE468C759@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1661173856-1192-1-git-send-email-hongxing.zhu@nxp.com>
 <4054884.5fSG56mABF@steina-w>
In-Reply-To: <4054884.5fSG56mABF@steina-w>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3cddf027-5e94-4314-ebba-08da87301dd1
x-ms-traffictypediagnostic: PAXPR04MB8718:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +ufDEBMpSJ5C6kOBB/UfmDxkdRhRTI7IeKQo1YodIKwY48tzr993Bdc8IRUiS6w3+TS+mTIzWokLh7XZn4cXsKV/ZxYfO8yO6EBduOXZRPY6MafRhobpvECgXIyx6KseMGyQk3MDYB5m2Jl3CZxmtvFL7GuuZcSzDXNIG9zjgnnCe5Ayt/bKMhp6GmngtPpiLoFpxhqE5/9TZCh3SvnPtFs070D6YweGbLUahmv9x1f1OvCu90sRbJ9DbE20xu0/GDEptUemvDQtGbMoJLlC0Q/1a+fXkkXzTivyKuvJ5VGnHwo8Tw1D/5Ty036PjsU+UhxqRlpG4B8WrD3sVsJHa8vzj/oHQC425++pvJoPGo3Xl5AHCHDUBhePYXCBaAQEjoCBifwKegRJG2E54ObV3A//hN7L87GwaR9c44UXcmqPr1XAaGpfOoUBkiW/Yofdhwdi7nhEYBYsEAEp2hgQ7qRC1xkCuq9CInUXoJMFh1Nw3uOPP0SVz5POQVANNca+twOID/RjvQNQ9sPeYS9+ZGbutvQUVIWFk1ZLbwspqYJOa4ZBr3m6YVAkPxO4w7ephveE6daUK+4E4+yFQk3phLk+uutrxSGgBS9BMC5zidSKsMlDglzp9aPOLAFJqExzLxxOfhDlayqIzpcdYUbyhWY3Ph2VRXHU/+ftbDQeHD+w4uDQB47n8qYZcxv830AWiAdEP+c9G2TZLvZwfhm5+Uoxyg+QVe0SL4YsBcN7qpDe6ZnHNT3NSWatbCsRbZbXWqlW3hK9AyZUSNL1EZLnNMauzP0+9RApxDkDU0g9few=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(66476007)(52536014)(66446008)(66556008)(76116006)(66946007)(54906003)(55016003)(478600001)(5660300002)(8676002)(38100700002)(122000001)(4326008)(8936002)(6916009)(45080400002)(316002)(44832011)(7416002)(41300700001)(64756008)(26005)(53546011)(7696005)(2906002)(186003)(83380400001)(33656002)(6506007)(86362001)(71200400001)(38070700005)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bFpsVWNXU1NSQ1p4NEoyeGErTW5RTllhQnBLYzYrRHpNZFJUUG5sUWxuSERQ?=
 =?gb2312?B?TDNRSU1ZbVZnVG5PSnJEY1lpT1lvK3VKUkRzRnIxVVliblpGTnNvbVdzTm5K?=
 =?gb2312?B?L3lxSHpHd0Q1T05zL3F4ejVoOWdGK01NdDV4Y0U0QVphL2REME94N0NDYjNt?=
 =?gb2312?B?eU13bk5LMkVueGVPMXdYVytsZkpSMURieDluWTJGR3EwMXdGMkxZa1djMGJ4?=
 =?gb2312?B?d05TeUNxdHJlYmpubVZZdE9ndU50d2VkRThNWU51YjJZN01oNUw3T2xlTWl2?=
 =?gb2312?B?NE5ydEdreTAvY2wyMXJ2VnZyNi9ScHRhTTlFQnBDY3l3aGlkQ0N0VlU2MWxy?=
 =?gb2312?B?TjRaYWgwSDNGYzhLRDYrUzA0QlhhSytKN2RSOWJmb3AvZ2RqSDQ4aElwSkhk?=
 =?gb2312?B?a2pIU1NqUGVQT2U1aVZ1Rm9lN3htVjBUMFVTWHF3TGdQaW1sVlFEejIxQ0Mz?=
 =?gb2312?B?RjJnUXU4NXpmZUZSejhkdWJPekp1SUV4MjBZYXdoa1hMWXdIOTJGc0pkV2I5?=
 =?gb2312?B?bWpJY0txV29STi9KNER4TDA2aU9qV3pOWnJ4b3FhVE5aOUhyajRTUytYYkRN?=
 =?gb2312?B?WmljZlUxN09mNkE2UGpENXgxWXBtWGcrWFN0K2Z0V1FCRnZEbUlBMk95aUt1?=
 =?gb2312?B?Z2UwTmZZSDNLMWdpOTNiOEhnSkR2SkhmT2ZqM2lyVmd5aTYxY3BOaHdLd1BD?=
 =?gb2312?B?Z0J6VDkxZ1dWVzBRTlJvc1hGMmNmWWhSSS96ZUxXMXV0MkNIZHRoOEpkWC8w?=
 =?gb2312?B?TU41QWVFcEZVbTdnNUJUQW9QVm9ZL1NBY3hwQjloSTlVMDlTd3V1KzFZQUl5?=
 =?gb2312?B?NjNodzJVclg1NEpVS3dMWWpHSFBsYzRnM3RLT3U1U2d6TWxsbUVFN01TS0N1?=
 =?gb2312?B?Y1hEMVlIT0ZPazhGdWNDbXFwRmdicVIyK1ZhRjh2cytudDhxRFdub3Z2RFRh?=
 =?gb2312?B?T3hpQkZJVHR5RWpNN0lPT2s3R0NBYk5TN0dtOVBLb2NuQW8zY1drekdGZkR2?=
 =?gb2312?B?RVFmNUhyWkR6ZzVvWlg1bTloOGpWVkdWMWd1WlVwVjhzMU01ODBtcFB6Z1ZI?=
 =?gb2312?B?SW5uaHdQUnFKVkxENHJWYjcrZ0FtZVRTYlNrT2s3THg1Q2N0M3hGZ1YrN01D?=
 =?gb2312?B?L0Mzd2g4UU5PQnJJdEFKQ1FOMWFERjlTdjFZVFdET0kwS1pIT09zVyt1bDhK?=
 =?gb2312?B?THNLRzgrTVQvQ3BjMlhMTVRLL24yZ0hjcHdoWk4zWUpNS0lmb0w4QW5CUG9h?=
 =?gb2312?B?cXhJK3RReDZYVTV2TXFkL0VOTlFlY2Jkd2hRQmNzekxTdlFUOGFDLzdtajQ4?=
 =?gb2312?B?S2hjdnpOaUJ0a3JYRFVkanBkdnhKenVQeWhTSi9ycVVhSWE1d3FCUGY1dzV5?=
 =?gb2312?B?TXhKNURKcndIUXFDc0RJK1JCNi8veUc3eEVGZThySVhhSk83aWU2VFRNSDE3?=
 =?gb2312?B?OEdIL2x1aGQ5MlhLL2hIWnpNckovaFJsbGJDeXY5Vzd5UThmbklWaVRKZFhF?=
 =?gb2312?B?eHpOL1Bjd1dFN2RGUnBvdzdLZHAwUklSYzNuYS90dVFQcHltcHVrMjlEZ1pj?=
 =?gb2312?B?YUtpTEx2Ukt6cjNDMHRpTitFWUNjckx4eFFGR05aRXhmVURDK3VwUXFPQy82?=
 =?gb2312?B?S3BiRHNwNjZ4QVIzWnVqWm1KVENpLzJUZVhGa3RMeURRdjZjNDFPMnJLd2pq?=
 =?gb2312?B?cDYzK28yRThobFVMUjZVTEpNNFFPbWp1aGxKQmZUZUNPZmVBMjZ2bjhEaHBC?=
 =?gb2312?B?a1g3Vmo3RlhKVjRHQ29GVUNaVWlZYnA5VStZaUszSWp5Qi9USTZsTFJQNVZt?=
 =?gb2312?B?OUlGeXFMTmZUallTaE85Z2VKRFRTdjVPeThSelNGcE9XYTRnendSbkV0NjRG?=
 =?gb2312?B?UngzTSttUUtnRHNORWNCdUt1QlFWbUFyNWMzREk0RkJCa1pMK1lLNDU5cnl5?=
 =?gb2312?B?WkFramZqOGhBRkNVc3RucFh4R0RqdiswRU5aUkh2QnkzcStsS2ErbFdaTEVS?=
 =?gb2312?B?ei9XcGo5YmNxV0lxT2lxN3RPdzhubytieFFhN212U2NJeFlGbldrN3VFZmVD?=
 =?gb2312?B?eGNUZk9GYkt0QkI3RXhuSy9aRW02bmlUUkdlSXRpclRoYVZYSUUxOXg4WmEx?=
 =?gb2312?Q?vpvtrrwj0adEf1gl49Kp9GFaD?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cddf027-5e94-4314-ebba-08da87301dd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 06:56:35.4666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 11lWrQt1kLX9CAJ28Pbst3RHIl9HQ+JnidGMxvTEIqfr1umM7BFpsmYoA/3AtCgd69HCzTgnS2V2up+YisJhlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8718
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4YW5kZXIgU3RlaW4gPGFs
ZXhhbmRlci5zdGVpbkBldy50cS1ncm91cC5jb20+DQo+IFNlbnQ6IDIwMjLE6jjUwjI2yNUgMTQ6
MjYNCj4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBsLnN0
YWNoQHBlbmd1dHJvbml4LmRlOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiBsb3JlbnpvLnBpZXJh
bGlzaUBhcm0uY29tOyB2a291bEBrZXJuZWwub3JnOyBNYXJjZWwgWmlzd2lsZXINCj4gPG1hcmNl
bC56aXN3aWxlckB0b3JhZGV4LmNvbT47IGtpc2hvbkB0aS5jb207DQo+IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNv
bT47DQo+IGxpbnV4LXBoeUBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1wY2lAdmdlci5rZXJu
ZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgt
aW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAwLzJdIEZp
eCB0aGUgd3Jvbmcgb3JkZXIgb2YgcGh5IGNhbGxiYWNrcw0KPiANCj4gSGVsbG8gUmljaGFyZCwN
Cj4gDQo+IEFtIE1vbnRhZywgMjIuIEF1Z3VzdCAyMDIyLCAxNToxMDo1NCBDRVNUIHNjaHJpZWIg
UmljaGFyZCBaaHU6DQo+ID4gUmVmZXIgWzFdLCBwaHlfaW5pdCgpIG11c3QgYmUgY2FsbGVkIGJl
Zm9yZSBwaHlfcG93ZXJfb24oKS4NCj4gPiBUaGlzIHNlcmllcyB1c2VkIHRvIGZpeCB0aGUgd3Jv
bmcgb3JkZXIgb2YgdGhlIHBoeV9pbml0KCkgYW5kDQo+ID4gcGh5X3Bvd2VyX29uKCksIGludHJv
ZHVjZWQgYnkgY29tbWl0IDFhYTk3YjAwMjI1OCAoInBoeTogZnJlZXNjYWxlOg0KPiBwY2llOg0K
PiA+IEluaXRpYWxpemUgdGhlIGlteDggcGNpZSBzdGFuZGFsb25lIHBoeSBkcml2ZXIiKSBUZXN0
ZWQgb24gaS5NWDhNTSBFVksNCj4gPiBib2FyZCB3aGVuIG9uZSBOVk1FIGRldmljZSBpcyB1c2Vk
Lg0KPiA+DQo+ID4gWzFdaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29r
LmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGZw0KPiA+DQo+IGl0Lmtlcm5lbC5vcmclMkZwdWIlMkZz
Y20lMkZsaW51eCUyRmtlcm5lbCUyRmdpdCUyRnRvcnZhbGRzJTJGbGludXguZ2kNCj4gPg0KPiB0
JTJGdHJlZSUyRmQmYW1wO2RhdGE9MDUlN0MwMSU3Q2hvbmd4aW5nLnpodSU0MG54cC5jb20lN0M1
NmMzNzANCj4gMmRiMWU3NA0KPiA+DQo+IDY3NjgyZWEwOGRhODcyYmRlMmYlN0M2ODZlYTFkM2Jj
MmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwDQo+ICU3QzYzNzk3DQo+ID4NCj4gMDkxOTcy
MDcxMzEyMyU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDDQo+
IEpRSWpvaVYybHUNCj4gPg0KPiBNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdD
MzAwMCU3QyU3QyU3QyZhbXA7c2RhdGE9M2pqDQo+IHZuT0V4cw0KPiA+IHVFUzhBJTJGMmtUeGxZ
VHVUZ2xOU0szVExZMkdBUjhUbU1pUSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiA+IHJpdmVycy9waHkv
cGh5LWNvcmUuYz9pZD12NS4xOS1yYzEjbjIzMw0KPiA+DQo+ID4gW1BBVENIIHYxIDEvMl0gUENJ
OiBpbXg2OiBGaXggdGhlIHdyb25nIG9yZGVyIG9mIHBoeV9pbml0KCkgYW5kIFtQQVRDSA0KPiA+
IHYxIDIvMl0gcGh5OiBmcmVlc2NhbGU6IGlteDhtLXBjaWU6IEZpeCB0aGUgd3Jvbmcgb3JkZXIg
b2YNCj4gDQo+IFRvZ2V0aGVyIHdpdGggeW91ciBpbXg4bXAgcGF0Y2ggc2VyaWVzIG9uIFRRTWE4
TVB4bCArIE1CYThNUHhMOg0KPiBUZXN0ZWQtYnk6IEFsZXhhbmRlciBTdGVpbiA8YWxleGFuZGVy
LnN0ZWluQGV3LnRxLWdyb3VwLmNvbT4NCj4gDQpIaSBBbGV4YW5kZXI6DQpJdCdzIGdyZWF0LiBU
aGFua3MgZm9yIHlvdXIga2luZGx5IGhlbHAuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUN
Cj4gVGhhbmtzIGFnYWluIQ0KPiBBbGV4YW5kZXINCj4gDQo+IA0KDQo=
