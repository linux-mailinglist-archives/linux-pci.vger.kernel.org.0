Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC534C24BF
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 08:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiBXHum (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 02:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiBXHum (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 02:50:42 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F73417CC61;
        Wed, 23 Feb 2022 23:50:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBAV7NImlTz4vL6kDMF+3Jgx1lMCCodBWH4gS16ohPIXkEf0ArlDucrEPyiFKW3/BPrb+udAbI8R05/xoYs69p9cDK/rtdi00bvvuD9/pttLI7NrEunud0CexffemqqO5cuY+zU6gvYH/Pn4Typ0voM+w30IrWAPuFHVRcRnzde0232vOJv+wma397koIbAV0tCaBQDEGtONM/bVQ5XggvZXXVnceG6gi25yb2K4WU7HK4lUZtqI6aN9AYYPSGKCpxQzX+MSkNCGdZBhlTecuxx/D2cI0oHXlRzFO7gP9xhQG7TCIob03HAuxB8+CievJP/Jr9Zuw56HPvvYJlkuGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YG/iYuO/IlFLk8wYTi6CaHqV5BIMAx+FbkT50+DXKf8=;
 b=JWnBIb5YYTgp6d/uad6KYFy3NfDVvp5X42eohgrVT9fpr6RE8HWf4qLQif9k9x/5/L0hB5aLGpUw9KJN1OL3UrkkSIV/Zfoso5JauksMqtO5UPx6fExorSQMinFWR0gpVfaroEWjvq23tV4LKkjjllvFD7V/bg9zo1cqU2TKX4WXiQh0BBU21uvAhi5sYH/kEP+zYlcPFvF3Uqhx/izLyARjdPdEl2OG2NqaAOg451qm3QerX65SM5Lpinr8QzJlZOGjSNweQuYeXFcL2zN29MosHF9yiJPo8+HZgS7EP4btzy+JXaSei/BgQADDVZ1LVQODKbUN/tPChfL6pWamZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YG/iYuO/IlFLk8wYTi6CaHqV5BIMAx+FbkT50+DXKf8=;
 b=VxFbm3Rb9Zmhp2i67k4ZH1pYe0HgMTNvBHC7lS8gElL5p0JB0QNw5z7/7/c0/SslPoqto4OVdXKeqotCEmcNiF7pgcQYvfCdhDcuzo+ix7Rx1RF/02rEhdJJKJa/PqOWiI7KBGUDk1msAx45xfOzKnjeYV5+JOeiCzkPI0YRglo=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB5597.eurprd04.prod.outlook.com (2603:10a6:803:dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 07:50:09 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199%7]) with mapi id 15.20.4995.018; Thu, 24 Feb 2022
 07:50:09 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Subject: RE: [PATCH v7 8/8] PCI: imx6: Add the compliance tests mode support
Thread-Topic: [PATCH v7 8/8] PCI: imx6: Add the compliance tests mode support
Thread-Index: AQHYIwHX/egF3SXwLEylMM5+FyepLayhcs8AgADsOJA=
Date:   Thu, 24 Feb 2022 07:50:09 +0000
Message-ID: <AS8PR04MB8676DCB7CB8D94B0CBC97D0B8C3D9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1644992463-14467-9-git-send-email-hongxing.zhu@nxp.com>
 <20220223174014.GA139367@bhelgaas>
In-Reply-To: <20220223174014.GA139367@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efec8500-b3e6-4752-8283-08d9f76a4815
x-ms-traffictypediagnostic: VI1PR04MB5597:EE_
x-microsoft-antispam-prvs: <VI1PR04MB55979996A86E51D09D5493EC8C3D9@VI1PR04MB5597.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Niq3i356AKxEKdv3S8H/RWb3uzGpledFSTNMWbvJ8fTzTIfk0WGZWdM81eEyeg0JVtRpIBNL2CnBTwaXgajg1rleRcLTj77TR7X4Qa4CbXinEkVOa05iNB6IaRhwYT9mHsE4xVfkGOb+UWtf6QZQYHxvaGOQRWpHc0Pan7iVCWS1oGDFBP1cjFBNgo9Fe/qCzaVuAdsNNB/qmyuzMALFYmoOncTlHjCUwishKIjAcfW5+CjXceHAVNzCGFqy005xBkFdWK2wDJ20oQLMMuYLhNRodXWGiELLmBJHjLU8J4ZFsiUFc1Kxt1kxCe/6EHL/m6/3G2D06y7jFO0cI4aGfSqW2oE8grkLKwJ2ectl1uIsYTA6i7hX7aM99iRnlQi3Y1Iqq5rpHF8u+NMY+ztFeTrzNE48rAW6GcT9JFJirkB7StSpAs3UBQletYtB4Hod0DNiGyFKLVxtqndAsFSwZ4254Sg3FbQy9kgaX1qkmnqlvxFwAMDJ5Cn8LAO5O6xjRP3k7HQL5CnMr7ey0B87aqx+nXgoafozP44W5sThE5olVGlhLazfXRnjGKskFKbuXU68ZOLNopqA4CX8c7c9rO7eXcd9dSs1+YeRAHiRwf1frF6hfd8aOxHPKigZPt7SaBfB8kQOmDMdc2BDCzQDTbzqv0oUqlAqCxfIy//845UCydxkPKSLh3zxGwOc3aW5XwZTjHJ1mxBJ8RehkUyYdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(508600001)(55016003)(26005)(38070700005)(83380400001)(38100700002)(71200400001)(33656002)(2906002)(316002)(4326008)(6916009)(64756008)(186003)(8676002)(52536014)(54906003)(66446008)(66946007)(66556008)(66476007)(76116006)(53546011)(9686003)(7696005)(6506007)(7416002)(8936002)(44832011)(5660300002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?b3ZSZUpKbndSV1RVTG1NS2NhT1dNL3l6NDcvbkFDZWhRL3hoWi96WmRVcTdj?=
 =?gb2312?B?RktJTHJMaEt5Q2pkL2psYXJmaVEyODR3Um5DZGZseU5yWThaODVDbFVVSHRD?=
 =?gb2312?B?VmM1SnFrRDdOYWs1ZUdTUTBTTFQ2VW1LVDJtV0xiOEhJSElwTWdxcEpsa0lo?=
 =?gb2312?B?NVRSRHdkbGlGZkI4a0tvTjFUaWM0RUx4TmRaQXA2NmZsVHRxRmo5RXhEZDBa?=
 =?gb2312?B?N0F4cFVWeFhRdGxiRXZiVHVONm5QTy9OZDBxbzRlTjQ5SHVPWUhpSmg3bkpQ?=
 =?gb2312?B?aFBjc2lZY2pIK2RBSTNwVFlydXhmbjc0ZUl4cTJUVVlBV2ptalRtQVJXdnVX?=
 =?gb2312?B?ZFd0dFc0U2FmODE1QTI2U1hLaFJWaWZCSVlmQUQwUFkzQ1hUZThjSHNJSGdH?=
 =?gb2312?B?WTNHb2Z1eDBxL3l4SWlxTkdQN0wwK3VqZkpweFczcVlJNWpmRkhXYVJpUFhT?=
 =?gb2312?B?MEhKRzR0Ym9kdGpLN1NVcUZJK094U3VpdWsrbWJOQ3lCKzZhS01NY0JhcVc0?=
 =?gb2312?B?L0hQcVI5RHdHcVVKSW9PVTRCYlY4SGI1R3l2UnpBMlRqdXFvK0JnM256Vk92?=
 =?gb2312?B?TGc5azdIUkZqVEtpZGd6OGlYcE1Lei83QkJSUVJHZ1hTTStOU2FPejNCdjNh?=
 =?gb2312?B?OFZRNkJFN2RNQURVY0VoaWYvZ3dqT04xTjR1ZGlRdnJxaWk4V1NpUm9KQmFi?=
 =?gb2312?B?eGIyYlZkMnUwcVNUZEVKaG9GWWRWQUhiWnZ6SkFDajZaUnB5clVBeHNJS2Q0?=
 =?gb2312?B?aXl5ZDBuLzdwZktIVzVVaHptd05VRFNYZjd1QmN6UXkyMTNsNS84cHRtU08x?=
 =?gb2312?B?S0tZb29lRk1Da1I4aU9ha1drU1hickVkWHRZaUpjc2NPSUZzNHMyd1Rrd2ty?=
 =?gb2312?B?d1kyQ2dyb1lDWCtCb1lidGhXcEZ5Qlk3RnBTWElyWFFLWFJWS2I4Z3RmYzhv?=
 =?gb2312?B?RjJUQm5yMDZMa05vcmNJYkF4L3J0NldESnluMWUxMVlFSXp1OExrdTVpaGtu?=
 =?gb2312?B?bWtBU0VkRERhR09HYjNOZDVBWGlzcVFpemhrMUR3M2g5dnZEMFdadHZqRlJt?=
 =?gb2312?B?Nk1pWHpRM3hoSTBEMjRXUkI2ZDJKNDh4UXZncjBWeUJtM3hML1RPM2l5OFRS?=
 =?gb2312?B?dUN1dEpwYlNYdHErRWp0Z2pGZEQ2REI1VGUvbU1LMFpYQkNSU3FUSEhxdURZ?=
 =?gb2312?B?SHE3WmdRV1QyVjZFU2hjRzY2KzkvSENvcWhySHBmK2VWb0FLQVRNU0xyS0dx?=
 =?gb2312?B?emRLN3UrelZDWHYwUGxlVWd0ZDkzeEJwcU5PS1RkdkpWc3NtU2poWWtVZ3JB?=
 =?gb2312?B?RUc3S1ljemE5ZW5LM01IY1dIUmc1WGxra3NpM0xCNVlFYVRvUkNJbFRVczVw?=
 =?gb2312?B?eEZmbmxFV3BhMzBqaEh5aitlREplQ3ltNnVuQkRVT0RNRlNyVzVrZkhjZUVD?=
 =?gb2312?B?eGRZYTZESEJrVFJxOXQwL3lkTW9Md3pkSjZUczBKNzRUWCt3d2taN2lldlZk?=
 =?gb2312?B?TDBBT3V0RUx4Zk5POUNOMzJlT0JEN0VrRWtWSTJOQWg2UFJROXZQbFV6SXFz?=
 =?gb2312?B?ZzRvQ1Y4OFlaSkQ4b3ZyOVI4SUs2cWJJdVZjNFhzcXhuMk9YdmlTcWVETDAw?=
 =?gb2312?B?ZFVGZFFiRGFMYzFHYXc5alJ1N1VnQnkveEhjNnVyRmhpMEV2cndGQXRuR1dt?=
 =?gb2312?B?VFQyaFRPU0VLckpqVG9rQnVjaW4vUUhIbjFsS0E3MnBUUzQvU1NhOG16UTUw?=
 =?gb2312?B?eUxYSkRGdEo1bzBhUGJhMFR6MHV0KzExZWprSEtZUHF3MXlyMXlIeDRleDVo?=
 =?gb2312?B?NHVlSVp4cGlhSTN3NncvYUIreG8wcXpybG9iQXFza3h1aHNJbjdoWWdGWEw2?=
 =?gb2312?B?d3NGNnI5RERYNHdSb2RucGo5MGVmQ3c3WVZtRFJBZFBnOEc2Z1RwY2VaU1Fo?=
 =?gb2312?B?cFFCMW5VUVNaVGVGaWhCWXY3MUd5QlVzUzI1T0RaQVZVdktoUWRjUG1LR3VL?=
 =?gb2312?B?aUllSVRwUEVYSm1wblVkcTRFNkxzWkoybkpFRVZVeEtqdCtwRHRDTUltZ0Ew?=
 =?gb2312?B?WTVGZmkxYjNTQnpSaXp0QlJmLzZsRlhVTnh5aGNmaW9Qa3llNnc5ZVorMElk?=
 =?gb2312?B?YnB6YXNyRko1V0h5MkxIeGdtZ1UyUFJ6WWhKU3R1a3ZLVEF5YVVWdmYyZXMw?=
 =?gb2312?B?emc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efec8500-b3e6-4752-8283-08d9f76a4815
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 07:50:09.6818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WNOol64jqL64bIEgb985R2Dt+iNBNZh7A4sDAhUmSJ7DbnfhJ3SAfhBpYkoF0kDq0x/oMJI0GOW0qpmFjiT55w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5597
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jLUwjI0yNUgMTo0MA0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9uaXgu
ZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207IGJyb29uaWVAa2VybmVsLm9yZzsNCj4gbG9yZW56by5w
aWVyYWxpc2lAYXJtLmNvbTsgamluZ29vaGFuMUBnbWFpbC5jb207IGZlc3RldmFtQGdtYWlsLmNv
bTsNCj4gZnJhbmNlc2NvLmRvbGNpbmlAdG9yYWRleC5jb207IGxpbnV4LXBjaUB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1p
bXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY3IDgvOF0gUENJ
OiBpbXg2OiBBZGQgdGhlIGNvbXBsaWFuY2UgdGVzdHMgbW9kZSBzdXBwb3J0DQo+IA0KPiBJbiBz
dWJqZWN0Og0KPiANCj4gcy9BZGQgdGhlL0FkZC8NCj4gDQo+IE9uIFdlZCwgRmViIDE2LCAyMDIy
IGF0IDAyOjIxOjAzUE0gKzA4MDAsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+IFJlZmVyIHRvIHRo
ZSBzeXN0ZW0gYm9hcmQgc2lnbmFsIFF1YWxpdHkgb2YgUENJZSBhcmNoaWVjdHVyZSBQSFkgdGVz
dA0KPiA+IHNwZWNpZmljYXRpb24uIFNpZ25hbCBxdWFsaXR5IHRlc3RzKGZvciBleGFtcGxlOiBq
aXR0ZXJzLA0KPiA+IGRpZmZlcmVudGlhbCBleWUgb3BlbmluZyBhbmQgc28gb24gKSBjYW4gYmUg
ZXhlY3V0ZWQgd2l0aCBkZXZpY2VzIGluDQo+ID4gdGhlIHBvbGxpbmcuY29tcGxpYW5jZSBzdGF0
ZS4NCj4gDQo+IHMvYXJjaGllY3R1cmUvYXJjaGl0ZWN0dXJlLw0KPiBzL3Rlc3RzKGZvci90ZXN0
cyAoZm9yLw0KPiBzL2ppdHRlcnMsICAvaml0dGVyLCAvICAgICAgICAgICAgICAocmVtb3ZlIGRv
dWJsZSBzcGFjZSkNCj4gcy9zbyBvbiApL3NvIG9uKS8NCkdvdCB0aGF0LiBUaGFua3MgZm9yIHlv
dXIga2luZGx5IHJldmlldyBjb21tZW50cy4NCg0KPiANCj4gSXMgdGhpcyBhIHJlZmVyZW5jZSB0
byBhIHNwZWM/ICBJZiBzbywgSSBjYW4ndCB0ZWxsIHRoZSBuYW1lIG9mIHRoZSBzcGVjLCB0aGUN
Cj4gcmV2aXNpb24sIG9yIHRoZSBzZWN0aW9uIG51bWJlci4NClllcywgaXQgaXMgYSByZWZlcmVu
Y2UgdG8gYSBzcGVjLiBIb3cgYWJvdXQgY2hhbmdlIHRoZW0gdG8gdGhlIGZvbGxvd2luZz8NCg0K
UENJOiBpbXg2OiBBZGQgY29tcGxpYW5jZSB0ZXN0cyBtb2RlIHN1cHBvcnQNCg0KUmVmZXIgdG8g
dGhlIENoYXB0ZXIgMy4yIFN5c3RlbSBCb2FyZCBTaWduYWwgUXVhbGl0eSBvZiBQQ0kgRXhwcmVz
cw0KQXJjaGl0ZWN0dXJlIFBIWSBUZXN0IFNwZWNpZmljYXRpb24gUmV2aXNpb24gMi4wLg0KDQpT
aWduYWwgcXVhbGl0eSB0ZXN0cyAoZm9yIGV4YW1wbGU6IGppdHRlciwgZGlmZmVyZW50aWFsIGV5
ZSBvcGVuaW5nIGFuZA0Kc28gb24pIGNhbiBiZSBleGVjdXRlZCB3aXRoIGRldmljZXMgaW4gdGhl
IHBvbGxpbmcuY29tcGxpYW5jZSBzdGF0ZS4NCg0KVG8gbGV0IHRoZSBkZXZpY2Ugc3VwcG9ydCBw
b2xsaW5nLmNvbXBsaWFuY2Ugc3RhdGUsIHRoZSBjbG9ja3MgYW5kIHBvd2Vycw0Kc2hvdWxkbid0
IGJlIHR1cm5lZCBvZmYgd2hlbiB0aGUgcHJvYmUgb2YgZGV2aWNlIGRyaXZlciBmYWlscy4NCg0K
QmFzZWQgb24gQ0xCIChDb21wbGlhbmNlIExvYWQgQm9hcmQpIFRlc3QgRml4dHVyZSBhbmQgc28g
b24gdGVzdA0KZXF1aXBtZW50cywgdGhlIFBIWSBsaW5rIHdvdWxkIGJlIGRvd24gZHVyaW5nIHRo
ZSBjb21wbGlhbmNlIHRlc3RzLg0KUmVmZXIgdG8gdGhpcyBzY2VuYXJpbywgYWRkIHRoZSBpLk1Y
IFBDSWUgY29tcGxpYW5jZSB0ZXN0cyBtb2RlIGVuYWJsZQ0Kc3VwcG9ydCwgYW5kIGtlZXAgdGhl
IGNsb2NrcyBhbmQgcG93ZXJzIG9uLCBhbmQgZmluaXNoIHRoZSBkcml2ZXIgcHJvYmUNCndpdGhv
dXQgZXJyb3IgcmV0dXJuLg0KDQpVc2UgdGhlICJwY2lfaW14Ni5jb21wbGlhbmNlPTEiIGluIGtl
cm5lbCBjb21tYW5kIGxpbmUgdG8gZW5hYmxlIHRoZQ0KY29tcGxpYW5jZSB0ZXN0cyBtb2RlLg0K
DQpTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IA0K
PiA+IFRvIGxldCB0aGUgZGV2aWNlIHN1cHBvcnQgcG9sbGluZy5jb21wbGlhbmNlIHN0YXQsIHRo
ZSBjbG9ja3MgYW5kDQo+ID4gcG93ZXJzIHNob3VsZG4ndCBiZSB0dXJuZWQgb2ZmIHdoZW4gdGhl
IHByb2JlIG9mIGRldmljZSBkcml2ZXIgaXMgZmFpbGVkLg0KPiANCj4gcy9zdGF0L3N0YXRlLw0K
PiBzL3Bvd2Vycy9wb3dlci8NCj4gcy9kcml2ZXIgaXMgZmFpbGVkL2RyaXZlciBmYWlscy8NCk9r
YXkuDQoNCj4gDQo+ID4gQmFzZWQgb24gQ0xCKENvbXBsaWFuY2UgTG9hZCBCb2FyZCkgVGVzdCBG
aXh0dXJlIGFuZCBzbyBvbiB0ZXN0DQo+ID4gZXF1aXBtZW50cywgdGhlIFBIWSBsaW5rIHdvdWxk
IGJlIGRvd24gZHVyaW5nIHRoZSBjb21wbGlhbmNlIHRlc3RzLg0KPiA+IFJlZmVyIHRvIHRoaXMg
c2NlbmFyaW8sIGFkZCB0aGUgaS5NWCBQQ0llIGNvbXBsaWFuY2UgdGVzdHMgbW9kZSBlbmFibGUN
Cj4gPiBzdXBwb3J0LCBhbmQga2VlcCB0aGUgY2xvY2tzIGFuZCBwb3dlcnMgb24sIGFuZCBmaW5p
c2ggdGhlIGRyaXZlcg0KPiA+IHByb2JlIHdpdGhvdXQgZXJyb3IgcmV0dXJuLg0KPiANCj4gcy9D
TEIoQ29tcGxpYW5jZS9DTEIgKENvbXBsaWFuY2UvDQpPa2F5LiBXb3VsZCBiZSB1cGRhdGVkIGxh
dGVyLg0KDQo+IA0KPiA+IFVzZSB0aGUgInBjaV9pbXg2LmNvbXBsaWFuY2U9MSIgaW4ga2VybmVs
IGNvbW1hbmQgbGluZSB0byBlbmFibGUgdGhlDQo+ID4gY29tcGxpYW5jZSB0ZXN0cyBtb2RlLg0K
PiANCj4gVGhhbmtzIGZvciBpbmNsdWRpbmcgdGhpcyBpbiB0aGUgY29tbWl0IGxvZyENCj4gDQo+
ID4gIAlyZXQgPSBkd19wY2llX2hvc3RfaW5pdCgmcGNpLT5wcCk7DQo+ID4gLQlpZiAocmV0IDwg
MCkNCj4gPiArCWlmIChyZXQgPCAwKSB7DQo+ID4gKwkJaWYgKGlteDZfcGNpZV9jbXBfbW9kZSkg
ew0KPiA+ICsJCQlkZXZfaW5mbyhkZXYsICJEcml2ZXIgbG9hZGVkIHdpdGggY29tcGxpYW5jZSB0
ZXN0IG1vZGUNCj4gPiArZW5hYmxlZC5cbiIpOw0KPiANCj4gVG8gbWF0Y2ggb3RoZXIgbWVzc2Fn
ZXM6DQo+IA0KPiBzL0RyaXZlciBsb2FkZWQvZHJpdmVyIGxvYWRlZC8NCj4gcy9lbmFibGVkLi9l
bmFibGVkLw0KT2theS4NCg0KPiANCj4gPiArCQkJcmV0ID0gMDsNCj4gPiArCQl9IGVsc2Ugew0K
PiA+ICsJCQlkZXZfZXJyKGRldiwgIlVuYWJsZSB0byBhZGQgcGNpZSBwb3J0LlxuIik7DQo+IA0K
PiBzL1VuYWJsZS91bmFibGUvDQo+IHMvcGNpZS9QQ0llLw0KPiBzL3BvcnQuL3BvcnQvDQpPa2F5
LCB3b3VsZCBiZSB1cGRhdGVkIGxhdGVyLg0KVGhhbmtzLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hh
cmQgWmh1DQoNCj4gDQo+ID4gKwkJfQ0KPiA+ICAJCXJldHVybiByZXQ7DQo+ID4gKwl9DQo+ID4N
Cj4gPiAgCWlmIChwY2lfbXNpX2VuYWJsZWQoKSkgew0KPiA+ICAJCXU4IG9mZnNldCA9IGR3X3Bj
aWVfZmluZF9jYXBhYmlsaXR5KHBjaSwgUENJX0NBUF9JRF9NU0kpOw0KPiA+IC0tDQo+ID4gMi4y
NS4xDQo+ID4NCg==
