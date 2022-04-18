Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB39504BE2
	for <lists+linux-pci@lfdr.de>; Mon, 18 Apr 2022 06:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbiDRE5W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Apr 2022 00:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236579AbiDRE5P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Apr 2022 00:57:15 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80049.outbound.protection.outlook.com [40.107.8.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A60418E19;
        Sun, 17 Apr 2022 21:54:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVC8ERikEYWm3Xn9wXR4Gs4dPPSFDr+67pg8AtMhDxnHDX3zSgwec9wptI1W3t4Gbzb9pPQr88e/FUjvL5nXJ9HGZ3IQO5xZe7ESL/2Cimpap2Y3YdcOrAfKLVp+bRhjxJWH4KJupI8WrViNRx8nARISqgGsqO3AZqvCS/cPgYDpvj+28gpDREl+Rkgm9NPTnv8fntzrgtdjz1JcYkq+11M3NKQIAIaAHY7rM9uRCJbHo/gOHFxXshkTNoZrAvhbt3vpTgL8JtqyGQSsaY8nT2Uue+AZPnkbepRccZdIZKcix+sNSwRkGenbW4ygBON1VuwIzPa/evs4G7MguiV9tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=so0I4GNJl6xkjMWlamqGc3llJzZWhPbHD8Tk2WPLXfQ=;
 b=RQPAai8QeaYk4a1ALymA6LHqGke0fjQt6//olx6rD/Yk7mSKgdiO+ftTVmCHohTW4AqjPrjKaxElPrb/uKum15qMwSP+OTANTLHp4Qn8CBeVx8OrSlTMPihvK1REFAu/4mMzpKpYt0ab4HNax0V1Ci1TM4pQBE53KUIFC9Gkglq8NAoSoBhmHBm0zocUPTOniVUsvt7Bu4ia7qIVfUi/1/5la7VnlcbA4Bi2vYw3iluDvOplY1UciGTKgfh2yy3SptiN+R3kamel9y5DM0FnUEFtu6aL66TV0GJxANIaan2pedmwbxn0N+EPyLMDXbNjIY05PcViyunbxDmstL4rIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=so0I4GNJl6xkjMWlamqGc3llJzZWhPbHD8Tk2WPLXfQ=;
 b=o0j5ftR/+rbkyOrcuigWyn5QnCX/LOWzELQb1KNO9rLAsSWzah1L8eW+c/KsFw8+pAgWRLcHTZG5WQzOcRX0Af9vilGVSLkLyilhMSCwZsmNTXJPWMrHjbjdaZ39ikdzt77oyhCCayfEm9OZubK8DceQUib+4vkRMAXZxI+v8XA=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by HE1PR0402MB3433.eurprd04.prod.outlook.com (2603:10a6:7:87::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 04:54:33 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::ecea:cb09:5ff2:1800]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::ecea:cb09:5ff2:1800%5]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 04:54:33 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
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
Thread-Index: AQHYMgQKvQY38d7zYkCsN9Iw8VH+QqzwHeSAgAUxMuA=
Date:   Mon, 18 Apr 2022 04:54:32 +0000
Message-ID: <AS8PR04MB86762A33F301071ACC2C0CF88CF39@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1646644054-24421-1-git-send-email-hongxing.zhu@nxp.com>
         <1646644054-24421-2-git-send-email-hongxing.zhu@nxp.com>
 <837af8d131bd0674d7466d89c3df74da08c8c435.camel@pengutronix.de>
In-Reply-To: <837af8d131bd0674d7466d89c3df74da08c8c435.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f74504a-e8ae-407e-fea5-08da20f7879d
x-ms-traffictypediagnostic: HE1PR0402MB3433:EE_
x-microsoft-antispam-prvs: <HE1PR0402MB3433E4C2496673659F356C7C8CF39@HE1PR0402MB3433.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s6o9D2AjaAAGZToAwn8szHBh54764RFUP8s8exMobXtwq700fSjlYMgD7B866hADwNdjEoUjHQsxeTac3dUjAjnU72adsxmnQJ49p0Fqca+EyNjo3uwNYJY5KS9D1Ra0HYATkD+GNIajDYN03U6Epjgk65iiLkvxsX8R+n6qTmTl48oawAY9bJ014LFD7vuIrDEbJyLgbbe0nrMFbx5JVyJqaP2hrikPuwUuL3jcwJBYTcZFGnv8iHokrKXUH0c6+csleX6uj/7o/LYPWlr+kSPzz3JesmGQQrjCZkHA5gffqo1WJUioFx8Cnt3GsKqgaUq7nE0h197dN4NpF9t7i540hYyCo0ArpjxUN0yDBcwZFpRsdhe4r0WBnev1fcwVNhFyF4e8VXHYEUq4Rsm1hBAp4ARfKN56TbOxNKWaNATnT5HEFq+SCuxFVpZDdmtoPfpRprE7CxCGFeb0BikPJnZglu6RjgjTZGZSwCMu/erURo+/AS/YD/JPY83mlSZCJOAMfy6Zpgs9fE5iGEs5HwZrb/VhvpuvRjANonlSrBUhaQeq+o7hcwME3iA4tI0P8QI+264MEg8qfz/v1DD2hw3mNqn+/M3/wImV9Koz80VktFhCQTDXt7EIDCeHuNL23lEuUmuAnm4YsftwIu7637mXC9bIVjVJiZeqbH12zCLa2lAsTsqDhG8sp5w7oPgknT55otQnUM3qBg4KmGKkNHHelKu7dYUEBvPYYeBH9tE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(33656002)(38070700005)(508600001)(110136005)(83380400001)(186003)(26005)(9686003)(53546011)(6506007)(122000001)(38100700002)(44832011)(7416002)(7696005)(2906002)(5660300002)(54906003)(71200400001)(8936002)(4326008)(52536014)(76116006)(316002)(66946007)(66446008)(64756008)(55016003)(8676002)(66476007)(66556008)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0xnUGp0aW85d25OeHZHR0dISDIydlBiVnNKQTltd3dKNXc5WU54c0VMNHVP?=
 =?utf-8?B?OUpXNE0zay9qTkdPOXZrTUxRY21vM0Yxa2JxM012RTJobHJHUS81QTVVbUo2?=
 =?utf-8?B?YnRRWFJHL3pLTlVNS1l4SkwvM3JpNGVwb0xHUVo4RU1jSzc0SzdLY1UwTFJV?=
 =?utf-8?B?d0p4UWJ4QjcyWC8wdHhSR2dNNjBoV0ozMTJsNnpGSk9OZkc3RUVNbUYxbVdW?=
 =?utf-8?B?ZlNETHBwNGkxaDRQWm9PN3NkMnZjdDhDK3RXUE1uR1BaWkx5ZTF5VGw0bEtS?=
 =?utf-8?B?b0VISzJNQ0ZqNmxPOUZDK2VZRG1pWXU2ZUN6UzhvME9MbHp0Mml2RkVLTTlj?=
 =?utf-8?B?ZlVjSmpxUmNRQk93SHhxVmxaZFF4NURuNHhmS0VHWERMaVhSYVZaU1Q0b2dW?=
 =?utf-8?B?eGhHQmVML25Hb1FHUUZBZUNpdlcycFBVVFAyd3hjaXF2UDFjR0tqTEF5UlRy?=
 =?utf-8?B?QVA0TlFBKzlVOEZsMCtaYndLcDVVREh4dkhMdEMxNjQ1SzI2Vmc0THp4T1FE?=
 =?utf-8?B?NDBtR3YycnRBQ2JOUU5TOXpyY0J6dEZyTVYyUlBlR2FHUUVxMm9FVmUweG5o?=
 =?utf-8?B?M1VlMUdYZ05GQkdkdkZyQVd0SnZMUjArNWpUSzl4WVcvR2VlT2FoTCt4aENw?=
 =?utf-8?B?S24vL2V5VWNCQTJOc1RJalBGZmNPN09BY2VWYlI5T21GdmhCUjlCUDZabFVu?=
 =?utf-8?B?bzdFVVpGOE1WN2lhT2M2MnhTS0dwTjhjVXpDVzI5dEJzekJDZVdJTkNsUXBO?=
 =?utf-8?B?OXN1Y3lMTzhKUGEzUUxuQkhjdjlTNEwxZXJYdmJrTDFtd2V3bTFRVkZmbjhQ?=
 =?utf-8?B?dW56UzZoUkQrRE92amdrWmxjTU5sWFFDdHBmS2o4NmY4aDhzam40d1JSUWoy?=
 =?utf-8?B?aUN6WFlzVHl0Wnp5cnlwaE02a05WZnN4cEp1OVJzY1VLdkJMR2ZGaWxBdUNF?=
 =?utf-8?B?N094T3NrcVdEQ1lKejk0VDM5cEZqeGhDcWxhbG5CaWRKVkdreFpIcEZRa2dC?=
 =?utf-8?B?YVpYVzBreDdlK2tpazBSbTVBR296MzRnOEY1V0x5T1h2ek5Ia3RQOTUrT0hp?=
 =?utf-8?B?SG5EN01PWWYwVUozZVNPTjU0V1QzdnJWaUJiT0VOd1h0TldjZ0p6TU8reGZk?=
 =?utf-8?B?OElFRUx0aCtIeVZncDRJTVhVYVBhTmRPMldzOTJxVHNtaklkUCtxRklreVd2?=
 =?utf-8?B?RlFZeU9FNXgzV3UrSENPOThzY21mZHhqbHhNazFUdVRCZVd0b2JVcVorMm1Y?=
 =?utf-8?B?NWdQVm91MmxuZVNHTWNuOHRXcmJXVkdIT3ExajVWVFlqWmRxbm9oeDJRdkJ1?=
 =?utf-8?B?QmtqS0Q5Q2JVRG1OWDdlWkZOVnpkY2RxS1ZlR3RxcklSQ3pqdUJGcWYzZjRx?=
 =?utf-8?B?QXZCSC9IaUVSRHR2NHhMcWJyUk4xcCtGOHJIcFdnSFl1b3VUSTN0QThzTzJD?=
 =?utf-8?B?d1hSS25QV1RoVW5NLzkvU3ExS3BNYWZBbVdyOUIyOE15QnkrRm5UaU9pdklB?=
 =?utf-8?B?Vlo1VDQ5RWJFbjJpSktwV1VtbUhtNVBiVEpESVBhY0JWblI2VHA2Rk53Uisx?=
 =?utf-8?B?SlJYN0xXSC9Ec2UraDJ0SFVQSG96bG1hNTVnOUlRRVdnc2lOM3RocSs4cy9w?=
 =?utf-8?B?TkdjUFJtV1M4V3RwZTJEcUxXRzBqQWRYN0ExRWw3UjNndFdRVm5qUDh6aTBK?=
 =?utf-8?B?S1g4aThRaEVlc282bnJkank3TXZLU2NJNm1JaVZKVGh4UWYvc2loMk9YL1Bh?=
 =?utf-8?B?OHZYc2loZDQwSk5NVWYyNWF2UjdMR1BrcUVQYzhhdVo5RlJ3K1dXeHdycEI4?=
 =?utf-8?B?Yzk2QThtdGU5MmZPTWswQkVSejZUM0hHbHV4NUVHTmxZY1hDRTY4QzVVZzVY?=
 =?utf-8?B?VUtGaXc1TU5YcjZlY0t5NmtISnkwc3REZUpQWlJwWlZtNVVuaVBEUk83RUk2?=
 =?utf-8?B?Rk5BQmNMZmo1ZEE2bFRiWm93ZHpVU1A0SHVnSlNEKzV6VGZ5NTJvQk1sYzZH?=
 =?utf-8?B?Yk4zSmc4U05LbDJSU3JLRTRwVGhEY05OYXE3V3Rudlh6OHR1MWMwQ2h6V2tx?=
 =?utf-8?B?Z0h5WmFWQjcyQyswTUYwVTFad2xUenNhUUltcDRCaEhZR0I1WlV2TGFiSzBu?=
 =?utf-8?B?aVROZ0hLalNGN3lleTRYZXVObDMwbGdxL25PUEZNa203ekJvNDlaeTYzSUdC?=
 =?utf-8?B?U1dWbEpybElwM0dqbldmcmR1aFlWTURlenozZWtseElYZkhOOFZyNms1aGNM?=
 =?utf-8?B?SXIxVGkzbnE2a3Zmb01lYkJGblo5a0d2Rnl0bjMvTDlvNU1VZExodXpwTFlw?=
 =?utf-8?B?SkozekdCWWxTMVV2MWE0SmpYV1lhRlRUTkJzZzRsWlhTd0F5MWNUUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f74504a-e8ae-407e-fea5-08da20f7879d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 04:54:32.9542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MxfH8YaMW5KDlNXV4B8Vds07eGxkSibr8s1lE7tKodOHxx7nabCOAgbhoYvAymM4RAvPvajBG53JZvKcoviWTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3433
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMuW5tDTmnIgxNeaXpSA0OjQ4DQo+IFRvOiBI
b25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgcC56YWJlbEBwZW5ndXRyb25peC5k
ZTsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgcm9i
aEBrZXJuZWwub3JnOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyB2a291bEBrZXJuZWwub3JnOyBh
bGV4YW5kZXIuc3RlaW5AZXcudHEtZ3JvdXAuY29tDQo+IENjOiBsaW51eC1waHlAbGlzdHMuaW5m
cmFkZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LXBjaUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51
eC1pbXgNCj4gPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEv
N10gcmVzZXQ6IGlteDc6IEFkZCB0aGUgaU1YOE1QIFBDSWUgUEhZIFBFUlNUDQo+IHN1cHBvcnQN
Cj4gDQo+IEFtIE1vbnRhZywgZGVtIDA3LjAzLjIwMjIgdW0gMTc6MDcgKzA4MDAgc2NocmllYiBS
aWNoYXJkIFpodToNCj4gPiBBZGQgdGhlIGkuTVg4TVAgUENJZSBQSFkgUEVSU1Qgc3VwcG9ydC4N
Cj4gDQo+IEFzIFBoaWxpcHAgc2FpZDogcGxlYXNlIGFkZCBzb21lIG1vcmUgZGVzY3JpcHRpb24g
b24gd2h5IHRoaXMgaXMgbmVjZXNzYXJ5LiBBcw0KPiBmYXIgYXMgSSBjYW4gc2VlIHRoZSByZXNl
dCBpcyBhbHJlYWR5IHByZXNlbnQgb24gOE1RLCBhbmQgaXMgbG93LWFjdGl2ZSwgbGlrZSB0aGlz
DQo+IHBhdGNoIGNsYWltcy4gV2UganVzdCBkaWRuJ3QgaGFuZGxlIHRoaXMgcmVzZXQgYXQgYWxs
IG9uIG90aGVyIFNvQ3MgYXMgdGhlIHBvd2VyDQo+IG9uIGRlLWFzc2VydGVkIHN0YXRlIHdhcyBv
a2F5IHRvIGdldCB0aGluZ3Mgd29ya2luZy4NCj4NClllcywgaXQgaXMuDQpJIGhhZCBhc2tpbmcg
dGhlIGRldGFpbHMgZnJvbSBkZXNpZ24gdGVhbS4NCldvdWxkIHVwZGF0ZSB0aGUgZGVzY3JpcHRp
b24gYWZ0ZXIgSSBnZXQgdGhlIG1vcmUgaW5mb3JtYXRpb24uDQoNCkJlc3QgUmVnYXJkcw0KUmlj
aGFyZCBaaHUNCg0KPiBSZWdhcmRzLA0KPiBMdWNhcw0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJp
dmVycy9yZXNldC9yZXNldC1pbXg3LmMgfCAxICsNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9yZXNldC9yZXNldC1pbXg3
LmMgYi9kcml2ZXJzL3Jlc2V0L3Jlc2V0LWlteDcuYw0KPiA+IGluZGV4IDE4NWEzMzNkZjY2Yy4u
ZDI0MDg3MjVlYjJjIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcmVzZXQvcmVzZXQtaW14Ny5j
DQo+ID4gKysrIGIvZHJpdmVycy9yZXNldC9yZXNldC1pbXg3LmMNCj4gPiBAQCAtMzI5LDYgKzMy
OSw3IEBAIHN0YXRpYyBpbnQgaW14OG1wX3Jlc2V0X3NldChzdHJ1Y3QNCj4gcmVzZXRfY29udHJv
bGxlcl9kZXYgKnJjZGV2LA0KPiA+ICAJCWJyZWFrOw0KPiA+DQo+ID4gIAljYXNlIElNWDhNUF9S
RVNFVF9QQ0lFX0NUUkxfQVBQU19FTjoNCj4gPiArCWNhc2UgSU1YOE1QX1JFU0VUX1BDSUVQSFlf
UEVSU1Q6DQo+ID4gIAkJdmFsdWUgPSBhc3NlcnQgPyAwIDogYml0Ow0KPiA+ICAJCWJyZWFrOw0K
PiA+ICAJfQ0KPiANCg0K
