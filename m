Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F9D4D3F22
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 03:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbiCJCE6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Mar 2022 21:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiCJCE6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Mar 2022 21:04:58 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06EE127D42;
        Wed,  9 Mar 2022 18:03:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STVggS8rMhj1PV2bu4tE/dKDrjllC/FeK7SIrxj8fF0iRU4JXsdZrWfFS8K7Ye++y2raLdTd7q0MnpMiEirb0YBN7m3xFHilC+gAc5lsMbOElsUIZ36vPI1ATXvvTq/iKPSHmHj+YjNqSv64MkF9PzoDapurEsWQP2yziod0YKwIEO8mVVNxr67Xme7r11ptSmF87veBcZmSx414NvkYdlkK36JfZl1Fx46kfut+yt1IxZhNsyN4yiB/tno3o24O8m3TkJGKDKDqwZYKdxgsob11Pmnl63lyqqFW4NG0WxNy5D3x5b4D96Uhj5nr7smlUkFP1KMjkwuCtV3GOFcGHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOedUI4KRfqfC8LShNdNEu3l+RvhLhGsiE0XsrTllhA=;
 b=mMFG2E4sq15Fw9YgIFY5Rw6wKnie3HyUd6DHha9DywDK9gINo9HihXgEdo5tfX6716X6BwwsL5LZsnIXiZmgGDkMFiewsBJp1L6ftAGor9396LzkROGHUURppqdZ+g0C1sqif4kU5ymMzmVK5ge5u5Pz6cYQA3qXCEwXF7OdOZxcjf1UWC69Cibt0wH2BMZ8C72Tuw1qk6WRqijPMthNop+HJdFLKqsr+yG/shZAXRD7nuGl9PmeuQmZPNQ1hkCra0h7ll7OJI5wut9TZ0JQ3XUvIqIhw39qBxmTMk0E4JWKCMifNvOzoRBCFyEEgJQGDIahJM72LIvBiwRagv9UtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOedUI4KRfqfC8LShNdNEu3l+RvhLhGsiE0XsrTllhA=;
 b=sWNODe94aqOEz+X4G7nb3T2mmWrWU+f43BYC5b/w/iEe5CGoMefJuduHbQtrIHMFp4fq20AciQ4LwbXhqmUywsP2FCdVchxbBQgdUERquXxR6UFbQh2AlHTW4Ap9UbZPtmMRKpubuSh5+m4ZS/DVcsqnp7psAGhpoBeYG981aeA=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB5983.eurprd04.prod.outlook.com (2603:10a6:803:d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 02:03:54 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f4f1:fe49:d19e:4770]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f4f1:fe49:d19e:4770%8]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 02:03:54 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
CC:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: (EXT) [PATCH v2 0/7] Add the iMX8MP PCIe support
Thread-Topic: (EXT) [PATCH v2 0/7] Add the iMX8MP PCIe support
Thread-Index: AQHYMgQJVjtpqun8b0KM+ThJT0Oxray2soCAgAEvaAA=
Date:   Thu, 10 Mar 2022 02:03:54 +0000
Message-ID: <AS8PR04MB867643674A3DE3ACE692496D8C0B9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1646644054-24421-1-git-send-email-hongxing.zhu@nxp.com>
 <4743587.31r3eYUQgx@steina-w>
In-Reply-To: <4743587.31r3eYUQgx@steina-w>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c0420eb-c369-4c7a-88b0-08da023a3aeb
x-ms-traffictypediagnostic: VI1PR04MB5983:EE_
x-microsoft-antispam-prvs: <VI1PR04MB5983AECE87671AA5D3AC58A28C0B9@VI1PR04MB5983.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W3GHye0WRdYMCF1gaO7CQMoiyZjKgRvGu1dE78Jz+7+gb8WX4GEyHSgl2YFxWUJoo9XrIF8efRw6OyDi4mzSzObAEnopVR2vgJeHXc0rDC3MklZXvPlUrr2uGRu7IkxdfWf9Cx+fr8+xRpgXGH1am6dA5qlQ8JuinTJMPH74SF0i1iE/a+iuPnCiwTlxyVfuQGxnW5auW9euOGzhl6iaycpBm7b/z1kZatiCuHSrr5m36zNybGyoRP2neze6DeLTsrOn2QvBEGqcRy4g+y5EYQwTQlrOI1HayIEBRrE8aphEcI051GNSfbJcnGXHQs/+IW0FT5kE0RVMIFZlTRfOZnmx3VFUBZuQJ9++GRPhl+THXmTUuNzSOFxwxnVY38dmhq36ssFTLDA+3SC/4CdvWsyOH2M0/RP0mrh6j7Co9H5p9Wst4/spO79XCn5KTnYm8X7Mi6gMipM12/e5UflyUsBYmeeDfSKXZTK9R+D9Tv9ICOKrv1oB+cCfW8l3j6xPpjgF2e6LOazT4cM9uzgvYhKVUXryioN9aN1/NtXDBVnjI/wr3ulgt109Tfa5/Daw2yz9vZq3hTqxdOQxQXNU8tsc5nij9tL/lJGCv0YEDnya2+uFrKgsD8HijZkX1Kl9GKbhVYTxR8Uhav/0T3DkL6vFhu50bk53xL9XfYB4lr7JEKWC1SkxIegroREgWl4ADtiJhAMYwwbiLT7tjKUdusKHeeRVFFG/G4cs2L45bRql3kRtZLLa+UNVqiwJ3jXPEBSTH1LnGqQy/+/B8o7pXC/zL3/wwqHX8FW06grtCxP4U42aoGGWDwH6FYVssl5W
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(55016003)(53546011)(6506007)(7696005)(26005)(33656002)(9686003)(64756008)(66946007)(66556008)(66476007)(66446008)(76116006)(8676002)(122000001)(498600001)(45080400002)(71200400001)(4326008)(38100700002)(38070700005)(86362001)(54906003)(6916009)(52536014)(83380400001)(186003)(44832011)(7416002)(5660300002)(66574015)(8936002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlFOTjJNVUx0OVJwVk1PejZ1blRZdnBTY3VaNERhWmxyTldIWkdzL3pxdGhB?=
 =?utf-8?B?MFZma3grRjdKK3RneW9kZkJtak5GRUp0aWFjb3grN0s1dVpEeUs2Sm02QTNl?=
 =?utf-8?B?NnpMaENRanE1M3N5cnBRdGZoWDdqYTZ5akV4QVo2ejNuYWpXcjNqTTVGbmpp?=
 =?utf-8?B?KzFNRkVMdkVreXMrc3YyWHEvcW43R3AxUWwxQWsyajNQSFJ1MXZHcDJNbzFt?=
 =?utf-8?B?L2ttejFWQXFzVVJNR2V3dkhycXlIK3I3bjRyYVNOSWlhK280dFkza0J1cXZ0?=
 =?utf-8?B?NmJOREl3a0traFlWQXRLVjVJNmtMWmhtZ0NKckk3MmxRNnhicHhEdjVSd2N5?=
 =?utf-8?B?ZXhjdWF2TmFJSnJYVFJUcHdwM1JWb3pPNEZqTVBBeU9lSU1LYjJNQkxPRXNl?=
 =?utf-8?B?WW96Y0Fad2hheitQSWczY1JSK2R6cXlHcGp1VzFETjFjdFNRNWJEUlF3c3Bi?=
 =?utf-8?B?amNEU2NvSTZOYWhBMDZlMWU1SUtLZ25XMHZTU3RyUy9yWXpwS2o5L1ZLaTAx?=
 =?utf-8?B?L1d6dnh3aytUR2xnUUxsUDNLb1duVTJmWEk5Skx3RUtTR25SL0xqZlFyK0Zi?=
 =?utf-8?B?dG5vYWt3aEdDdlBGcTkvZXo2T3JuQklBRnBhK2ZjMW1Ec2xacUMrd3M4OGdV?=
 =?utf-8?B?TUV4Z29EdklRVU9UU1dTc0FUbmYwYkp1NEJvNEgzbWd2eXBqcXlVUnVVQVFX?=
 =?utf-8?B?c1ZCSGVmaTU2NUJoWlZGT1lEZ2tIMVBnRzIzUTl1aHQ0aitzbEpPNjlFa1VL?=
 =?utf-8?B?ZkNYRmp2dk4xSDhFTmpxeFF1VTNqcE9CMGNnaTB1dUhid1dZdlNSbjBEZENh?=
 =?utf-8?B?Nm92ZU5GS05MYTYrMWFqWFBSdnNhTm40aHJ2Smx5ZDM1OWxobldIYzE5Q3o3?=
 =?utf-8?B?STRMNmNsTmdOWnp4MVhZeHh6a1NOZEJkZWd1enF6RjJidU5JTmUxWW1KM0lK?=
 =?utf-8?B?YVdMYmhWNEJOeXFtMk5lVlFsYkxBVEtRVS9IQWcwMEhheS9kNFhwdnBjS3Ny?=
 =?utf-8?B?NUlBbVYzbDBOWmYrRjRVbHBEOFpvNGVHRXdYS0UxcHM0QVZDdEhjbGU0VFVZ?=
 =?utf-8?B?emIwdG1LV1l5Q0ozYW9DVUU5eWtKR3pWUWh6YnFlR0l4bnJqMG1CWWEvSWRo?=
 =?utf-8?B?VStQMndFL09LQjZSV3VrVmQzdHFMNnRiVEp1cjQ5MmdYNi9Sa0VxNlo0Um91?=
 =?utf-8?B?ZHY1aU9pRlZjMFV3eGFLQkpwTHA4RHBNODF2MXFYYVVxcThETTJYVFQrclNz?=
 =?utf-8?B?cmVENlptd1lTdTZnclprUjhOeFhveXltanRtTjNOQXRtZEFoUUxPVnJ3eEhG?=
 =?utf-8?B?RjN2RXhHQkFzNTdTM2p1a0F5R2p6clFCVFBaQ1JqT1hUS3ducjBIeURqVEhU?=
 =?utf-8?B?MEwwRVFWRVU0RHBRZVlxS0pEeFFPN0ZPQ3dHdVc5dTNnMFFhc1AyZnNaeWM3?=
 =?utf-8?B?SWtvTi8raTNxQ1dJTHZhQkIrb1lQSjJmNUFYamdkNTUva2o2Sm1EQUNJeGwv?=
 =?utf-8?B?QWt3TERZdmlMSVl1eVdVY1NpVy9DL0E2UEJkUHRUYWNzTXdxTUl0WjViZ0hx?=
 =?utf-8?B?ZUppeWF5NjRsczZEMWVaYnlGYmoxNnJxRExkczRweEVsekpLOEpiWDlpaWxE?=
 =?utf-8?B?Ymp3dXNteXMyTUNMR3M2VGJPRVYwR1JFUmJ2YUpDYUo2Q3JwRDNhTjlNOTBI?=
 =?utf-8?B?Q1g0MG1UVDF4ZncyV2FOckZ5VnhoUnAvNmtPbVB5OEZMdHU4OTlQcVZYWGpY?=
 =?utf-8?B?YTdnWjA0Sjl2QzFxVlRNQTk3VlNJVjYwK2ttM3hKTnJ6TFpsYVR6cXZuQlZk?=
 =?utf-8?B?ZDBMWkcrOWl0T0x2OVRmNVJHQ0tBclRSeGZ0T1p1Umw5Q0htUWRSb2JjaSt6?=
 =?utf-8?B?bHZ0VW9VMEtmT2FGZGFxOGpnRzY1MEdSUlJTTG5mTFFkVzJpcm5xU2JleU1u?=
 =?utf-8?B?bTFhczQrQ2FpclN5S2pLV1JnbTIxb3JDYXB1bllDekhXT0ZvbU9MZy9yeDZC?=
 =?utf-8?B?RWpZeFFqckRrR0Eyem01c0NOSXhLMzBNaE1KazlVd0ZyK0ZqaXhTelYwaEYv?=
 =?utf-8?B?ZWx3cTBaYXgxaHhEVDhoRy9Obk50NzRBYUg0ZmhGUXVXb1VFcEZRaDB1anNP?=
 =?utf-8?B?Ry9Ndm4vUVhlS2Y5NGxETGo5K2ZLYW81bnJXajk4SmYwdWN3OWxjSjRWbm5R?=
 =?utf-8?B?Wnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0420eb-c369-4c7a-88b0-08da023a3aeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 02:03:54.5438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s6unOglRHxv7GyKfiYQJFDbgyMlNDduqKF5Jag6UDh2avOdyJMZ43nEbtRz1OL01N28kbK4Z8mYthfCplqdizA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5983
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFsZXhhbmRlciBTdGVpbiA8
YWxleGFuZGVyLnN0ZWluQGV3LnRxLWdyb3VwLmNvbT4NCj4gU2VudDogMjAyMuW5tDPmnIg55pel
IDE1OjU3DQo+IFRvOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzog
cC56YWJlbEBwZW5ndXRyb25peC5kZTsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgYmhlbGdhYXNA
Z29vZ2xlLmNvbTsNCj4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgcm9iaEBrZXJuZWwub3Jn
OyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiB2a291bEBrZXJuZWwub3JnOyBsaW51eC1waHlAbGlz
dHMuaW5mcmFkZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LXBj
aUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsN
Cj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBk
bC1saW51eC1pbXgNCj4gPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogKEVYVCkg
W1BBVENIIHYyIDAvN10gQWRkIHRoZSBpTVg4TVAgUENJZSBzdXBwb3J0DQo+IA0KPiBIZWxsbyBS
aWNoYXJkLA0KPiANCj4gQW0gTW9udGFnLCA3LiBNw6RyeiAyMDIyLCAxMDowNzoyNyBDRVQgc2No
cmllYiBSaWNoYXJkIFpodToNCj4gPiBCYXNlZCBvbiB0aGUgaS5NWDhNUCBHUEMgYW5kIGJsay1j
dHJsIHBhdGNoLXNldFsxXSBpc3N1ZWQgYnkgTHVjYXMgYW5kDQo+ID4gdGhlIGZvbGxvd2luZyBj
b21taXRzLg0KPiA+ICAgLSBvbmUgY29kZXMgcmVmaW5lIHBhdGNoLXNldFs1XS4NCj4gPiAgIC0g
dHdvIEZpeGVzWzJdLFszXS4NCj4gPiAgIC0gb25lIGJpbmRpbmcgY29tbWl0WzRdLg0KPiA+ICAg
LSBzb21lIGR0cyBjaGFuZ2VzIGluIFNoYXduJ3MgZ2l0IGlmIHlvdSB3YW50IHRvIHRlc3QgUENJ
ZSBvbiBpLk1YOE1NDQo+IEVWSy4NCj4gPiBiNGQzNmMxMGJmMTcgYXJtNjQ6IGR0czogaW14OG1t
LWV2azogQWRkIHRoZSBwY2llIHN1cHBvcnQgb24gaW14OG1tDQo+ID4gZXZrIGJvYXJkIGFhZWJh
NmE4ZTIyNiBhcm02NDogZHRzOiBpbXg4bW06IEFkZCB0aGUgcGNpZSBzdXBwb3J0DQo+ID4gICAg
IGNmYzUwNzg0MzJjYSBhcm02NDogZHRzOiBpbXg4bW06IEFkZCB0aGUgcGNpZSBwaHkgc3VwcG9y
dA0KPiA+DQo+ID4gU29ycnkgYWJvdXQgdGhhdCB0aGVyZSBtYXkgYmUgc29tZSBjb25mbGljdGlv
bnMgd2hlbiBkbyB0aGUgY29kZXMgbWVyZ2UuDQo+ID4gSSdtIHdhaXRpbmcgZm9yIHRoZSBhY2sg
bm93LCBhbmQgd2lsbCByZS1iYXNlIHRoZW0gaW4gYSBwcm9wZXINCj4gPiBzZXF1ZW5jZSBsYXRl
ci4NCj4gDQo+IFRoYW5rcyBmb3IgcHJvdmlkaW5nIHRoZSBkZXBlbmRlbmN5IGxpc3QuIFVuZm9y
dHVuYXRlbHkgdGhleSBkaWQgbm90IGFwcGx5DQo+IHdpdGhvdXQgZXJyb3Igb24gbXkgbG9jYWwg
dHJlZSwgYnV0IHRoaXMgaXMgY2F1c2VkIGJ5IG90aGVyIHBhdGNoZXMgSSB0cmFjay4NCj4gSSBt
YW5hZ2VkIHRvIGZpeCB0aGUgY29uZmxpY3RzLCBJIHRoaW5rLg0KPiBFdmVudHVhbGx5IEkgd2Fz
IGFibGUgdG8gZ2V0IGEgUENJZSBNLjIgZXRoZXJuZXQgaW50ZXJmYWNlIHdvcmtpbmcgb24gbXkN
Cj4gVFFNYThNUHhMIGJhc2VkIGJvYXJkLiBpcGVyZiBzaG93ZWQgPjkwME1CaXQvcyBUeCBhbmQg
PiA3MDAgTUJpdC9zIFJ4Lg0KPiBUaGFua3MgZm9yIHlvdXIgZWZmb3J0LiBPbmNlIHRoZSBkZXBl
bmVuY2llcyBhbmQgcmV2aWV3cyBhcmUgc2V0dGxlZCwgeW91J2xsIGdldA0KPiBteSB0ZXN0ZWQt
YnkuDQpIaSBBbGV4YW5kZXINCkl0J3MgZ3JlYXQgdGhhdCB0aGlzIHBhdGNoLXNldCB3b3JrcyBv
biB5b3VyIGJvYXJkLg0KVGhhbmtzIGZvciB5b3VyIGhlbHAgdG8gdGVzdCBpdC4NCg0KQmVzdCBS
ZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiANCj4gVGhhbmtzIGFnYWluIGFuZCByZWdhcmRzDQo+IEFs
ZXhhbmRlcg0KPiANCj4gPiBUaGlzIHNlcmllcyBwYXRjaGVzIGFkZCB0aGUgaS5NWDhNUCBQQ0ll
IHN1cHBvcnQgYW5kIHRlc3RlZCBvbiBpLk1YOE1NDQo+ID4gRVZLIGFuZCBpLk1YOE1QIEVWayBi
b2FyZHMuIFRoZSBQQ0llIE5WTUUgd29ya3MgZmluZSBvbiBib3RoIGJvYXJkcy4NCj4gPg0KPiA+
IC0gaS5NWDhNUCBQQ0llIFBIWSBoYXMgdHdvIHJlc2V0cyByZWZlciB0byB0aGUgaS5NWDhNTSBQ
Q0llIFBIWS4NCj4gPiAgIEFkZCBvbmUgbW9yZSBQSFkgcmVzZXQgZm9yIGkuTVg4TVAgUENJZSBQ
SFkgYWNjb3JkaW5nbHkuDQo+ID4gLSBBZGQgdGhlIGkuTVg4TVAgUENJZSBQSFkgc3VwcG9ydCBp
biB0aGUgaS5NWDhNIFBDSWUgUEhZIGRyaXZlci4NCj4gPiAgIEFuZCBzaGFyZSBhcyBtdWNoIGFz
IHBvc3NpYmxlIGNvZGVzIHdpdGggaS5NWDhNTSBQQ0llIFBIWS4NCj4gPiAtIEFkZCB0aGUgaS5N
WDhNUCBQQ0llIHN1cHBvcnQgaW4gYmluZGluZyBkb2N1bWVudCwgRFRTIGZpbGVzLCBhbmQgUENJ
ZQ0KPiA+ICAgZHJpdmVyLg0KPiA+DQo+ID4gTWFpbiBjaGFuZ2VzIHYxLS0+djI6DQo+ID4gLSBJ
dCdzIG15IGZhdWx0IGZvcmdldCBpbmNsdWRpbmcgVmlub2QsIHJlLXNlbmQgdjIgYWZ0ZXIgaW5j
bHVkZSBWaW5vZA0KPiA+ICAgYW5kIGxpbnV4LXBoeUBsaXN0cy5pbmZyYWRlYWQub3JnLg0KPiA+
IC0gTGlzdCB0aGUgYmFzZW1lbnRzIG9mIHRoaXMgcGF0Y2gtc2V0LiBUaGUgYnJhbmNoLCBjb2Rl
cyBjaGFuZ2VzIGFuZCBzbyBvbi4NCj4gPiAtIENsZWFuIHVwIHNvbWUgdXNlbGVzcyByZWdpc3Rl
ciBhbmQgYml0IGRlZmluaXRpb25zIGluICMzIHBhdGNoLg0KPiA+DQo+ID4gWzFdaHR0cHM6Ly9l
dXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJG
cA0KPiA+DQo+IGF0Y2h3b3JrLmtlcm5lbC5vcmclMkZwcm9qZWN0JTJGbGludXgtYXJtLWtlcm5l
bCUyRmNvdmVyJTJGMjAyMjAyMjgyMA0KPiAxDQo+ID4NCj4gNzMmYW1wO2RhdGE9MDQlN0MwMSU3
Q2hvbmd4aW5nLnpodSU0MG54cC5jb20lN0M1YTdiNWMzZDA1MDI0MmMNCj4gYjlhYTgwOGQNCj4g
Pg0KPiBhMDFhMjZjNzAlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0Mw
JTdDNjM3ODI0DQo+IDA5NDM2OTYzNg0KPiA+DQo+IDUzNyU3Q1Vua25vd24lN0NUV0ZwYkdac2Iz
ZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16DQo+IElpTENKQlRpDQo+ID4NCj4g
STZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCZhbXA7c2RhdGE9WlhvMXpUT09TeE9zR2U4
SU1EcjENCj4gYXhXY3FDbmYNCj4gPiB1TDhLQWFPZElHazFueEklM0QmYW1wO3Jlc2VydmVkPTAN
Cj4gPiAxLjMzMzAxOTItMS1sLnN0YWNoQHBlbmd1dHJvbml4LmRlLw0KPiA+IFsyXWh0dHBzOi8v
ZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUy
RnANCj4gPg0KPiBhdGNod29yay5vemxhYnMub3JnJTJGcHJvamVjdCUyRmxpbnV4LXBjaSUyRnBh
dGNoJTJGMTY0NjI4OTI3NS0xNzgxMy0NCj4gMQ0KPiA+DQo+IC0mYW1wO2RhdGE9MDQlN0MwMSU3
Q2hvbmd4aW5nLnpodSU0MG54cC5jb20lN0M1YTdiNWMzZDA1MDI0MmNiOQ0KPiBhYTgwOGRhDQo+
ID4NCj4gMDFhMjZjNzAlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0Mw
JTdDNjM3ODI0MA0KPiA5NDM2OTYzNjUNCj4gPg0KPiAzNyU3Q1Vua25vd24lN0NUV0ZwYkdac2Iz
ZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWkNCj4gTENKQlRpSQ0KPiA+DQo+
IDZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCZhbXA7c2RhdGE9Szc4NnlEZmpzaklWOVFw
VDZIeWF3bA0KPiBFa1F2JTJGDQo+ID4gaFFOVkJ1WGsyVVUycCUyQlhzJTNEJmFtcDtyZXNlcnZl
ZD0wPg0KPiA+IGdpdC1zZW5kLWVtYWlsLWhvbmd4aW5nLnpodUBueHAuY29tLw0KPiA+IFszXWh0
dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUz
QSUyRiUyRnANCj4gPg0KPiBhdGNod29yay5vemxhYnMub3JnJTJGcHJvamVjdCUyRmxpbnV4LXBj
aSUyRnBhdGNoJTJGMTY0NTY3MjAxMy04OTQ5LTENCj4gLQ0KPiA+DQo+IGcmYW1wO2RhdGE9MDQl
N0MwMSU3Q2hvbmd4aW5nLnpodSU0MG54cC5jb20lN0M1YTdiNWMzZDA1MDI0MmNiDQo+IDlhYTgw
OGRhDQo+ID4NCj4gMDFhMjZjNzAlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3
QzAlN0MwJTdDNjM3ODI0MA0KPiA5NDM2OTYzNjUNCj4gPg0KPiAzNyU3Q1Vua25vd24lN0NUV0Zw
Ykdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWkNCj4gTENKQlRpSQ0K
PiA+DQo+IDZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCZhbXA7c2RhdGE9RHAyR1UzaUR1
VFI5MVk2QXdxYm4NCj4gMEF4UHZiQmU0DQo+ID4gJTJCdFBWdnlsZ3pGZVdPVSUzRCZhbXA7cmVz
ZXJ2ZWQ9MA0KPiA+IGl0LXNlbmQtZW1haWwtaG9uZ3hpbmcuemh1QG54cC5jb20vDQo+ID4gWzRd
aHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBz
JTNBJTJGJTJGcA0KPiA+DQo+IGF0Y2h3b3JrLm96bGFicy5vcmclMkZwcm9qZWN0JTJGbGludXgt
cGNpJTJGcGF0Y2glMkYxNjQ2MjkzODA1LTE4MjQ4LQ0KPiAxDQo+ID4NCj4gLSZhbXA7ZGF0YT0w
NCU3QzAxJTdDaG9uZ3hpbmcuemh1JTQwbnhwLmNvbSU3QzVhN2I1YzNkMDUwMjQyY2I5DQo+IGFh
ODA4ZGENCj4gPg0KPiAwMWEyNmM3MCU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1
JTdDMCU3QzAlN0M2Mzc4MjQwDQo+IDk0MzY5NjM2NQ0KPiA+DQo+IDM3JTdDVW5rbm93biU3Q1RX
RnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaQ0KPiBMQ0pCVGlJ
DQo+ID4NCj4gNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJmFtcDtzZGF0YT1oc2JVUmFT
ZXZCeHhSZnVzJTJCanJlDQo+IFBwbzk2T2kNCj4gPiAlMkZlbCUyQlNjZXVlWWRJYXklMkI4JTNE
JmFtcDtyZXNlcnZlZD0wPg0KPiA+IGdpdC1zZW5kLWVtYWlsLWhvbmd4aW5nLnpodUBueHAuY29t
Lw0KPiA+IFs1XWh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20v
P3VybD1odHRwcyUzQSUyRiUyRnANCj4gPg0KPiBhdGNod29yay5vemxhYnMub3JnJTJGcHJvamVj
dCUyRmxpbnV4LXBjaSUyRmNvdmVyJTJGMTY0NTc2MDY2Ny0xMDUxMC0NCj4gMQ0KPiA+DQo+IC0m
YW1wO2RhdGE9MDQlN0MwMSU3Q2hvbmd4aW5nLnpodSU0MG54cC5jb20lN0M1YTdiNWMzZDA1MDI0
MmNiOQ0KPiBhYTgwOGRhDQo+ID4NCj4gMDFhMjZjNzAlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5
OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM3ODI0MA0KPiA5NDM2OTYzNjUNCj4gPg0KPiAzNyU3Q1Vu
a25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWkN
Cj4gTENKQlRpSQ0KPiA+DQo+IDZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCZhbXA7c2Rh
dGE9dVl3bklTVVdCU1AxeUJ4ZTVxZlJUDQo+IGElMkY5STd5DQo+ID4gOFlxZnlFWlhtdHM1RDlZ
cyUzRCZhbXA7cmVzZXJ2ZWQ9MD4NCj4gPiBnaXQtc2VuZC1lbWFpbC1ob25neGluZy56aHVAbnhw
LmNvbS8NCj4gPg0KPiA+IE5PVEU6DQo+ID4gQmFzZWQgZ2l0DQo+ID4gPGdpdDovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9scGllcmFsaXNpL3BjaS5naXQ+DQo+ID4g
QmFzZWQgYnJhbmNoIDxwY2kvaW14Nj4NCj4gPg0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9wY2kvZnNsLGlteDZxLXBjaWUueWFtbCAgICB8ICAgMSArDQo+ID4gRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9mc2wsaW14OC1wY2llLXBoeS55YW1sIHwg
ICA0ICstDQo+ID4gYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLWV2ay5kdHMg
ICAgICAgICAgICAgICAgIHwgIDU1DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKyBhcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAuZHRzaQ0KPiA+ICAgICAgICAgfCAgNDYgKysr
KysrKysrKysrKysrKysrLQ0KPiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5j
DQo+ID4gICAgICAgICAgICAgICAgICAgIHwgIDE5ICsrKysrKystDQo+ID4gZHJpdmVycy9waHkv
ZnJlZXNjYWxlL3BoeS1mc2wtaW14OG0tcGNpZS5jICAgICAgICAgICAgICAgICAgIHwgMjA1DQo+
ID4NCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiArKysrLS0tLS0NCj4gPg0KPiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICsrKystLS0tLQ0KPiA+IC0t
LS0tLS0gZHJpdmVycy9yZXNldC9yZXNldC1pbXg3LmMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwNCj4gMSArDQo+ID4gNyBmaWxlcyBjaGFuZ2VkLCAyODYgaW5zZXJ0aW9ucygr
KSwgNDUgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBbUEFUQ0ggdjIgMS83XSByZXNldDogaW14Nzog
QWRkIHRoZSBpTVg4TVAgUENJZSBQSFkgUEVSU1Qgc3VwcG9ydA0KPiA+IFtQQVRDSCB2MiAyLzdd
IGR0LWJpbmRpbmc6IHBoeTogQWRkIGlNWDhNUCBQQ0llIFBIWSBiaW5kaW5nIFtQQVRDSCB2Mg0K
PiA+IDMvN10gcGh5OiBmcmVlc2NhbGU6IGlteDhtLXBjaWU6IEFkZCBpTVg4TVAgUENJZSBQSFkg
W1BBVENIIHYyIDQvN10NCj4gPiBkdC1iaW5kaW5nczogaW14NnEtcGNpZTogQWRkIGlNWDhNUCBQ
Q0llIGNvbXBhdGlibGUgW1BBVENIIHYyIDUvN10NCj4gPiBhcm02NDogZHRzOiBpbXg4bXA6IGFk
ZCB0aGUgaU1YOE1QIFBDSWUgc3VwcG9ydCBbUEFUQ0ggdjIgNi83XSBhcm02NDoNCj4gPiBkdHM6
IGlteDhtcC1ldms6IEFkZCBQQ0llIHN1cHBvcnQgW1BBVENIIHYyIDcvN10gUENJOiBpbXg2OiBB
ZGQgdGhlDQo+ID4gaU1YOE1QIFBDSWUgc3VwcG9ydA0KPiANCj4gDQo+IA0KDQo=
