Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF9659CE57
	for <lists+linux-pci@lfdr.de>; Tue, 23 Aug 2022 04:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239282AbiHWCMF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 22:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239208AbiHWCMD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 22:12:03 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1560E4DF2B;
        Mon, 22 Aug 2022 19:12:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7fqz+pJwSAZ0v4sxHUpqVGVfE5AGWh8gyLq7X+eCC4qj8VjasqFr03x8hPB8cvO72l+2RFKJkQHYx774Pt3nO8qTDqsu1pi7O3k3LMsufVNvWY4pcLXqAIk/ymImuDlecr7nLY+NmRW2rywbmIsqLBmc3kvbH9ES271EcO8GgY9kiG7y6e0F8hGZxoK/mtbiBRLOTBUTzJPnGhdn4ixgXAb3NQje6cLsqaxVGwYOgovebCpmtpbM9px99ySHB77laNOU3f++v306Am8SH0mDCYW4OMGYs3Tye1M3mTp1dA/Bq0Y6TL8rRlT2+qfnvALIScy4v+JQ7AHWe9cN0bnUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Csq3FgsAR7BzrMUIzr7gSgK0fRKmhk6XWytIjQ598P8=;
 b=c/2ZhaBYlgizvW4snipaz92cZE6J2dlFK0x59r9XkyJYpWImHJDn/VAT0mODmGYAnMtb1NGDp3ZXON4NhCfcdJY61B2dBSyeeRI1Ywh9mmaZR7BWQpaGHJFlFQ8WLCPq+dt9QarEAH17FHuZ03Ynw1TV1r1rUwAY9w3/sh+vqXMLnWOw1kA6r7vg7jLzH7OWFkZCWVG/rlMA8F8PnUX9jEijoH5U/fLfKESN/TH4pO73GqZVRjkwe1j9L351MJ6hmvl1YVYXg63bIu1zPi3UzdLfuvLalJkicYnAJCVrn9NY12fXmqUFQimI8kSK56OFstBHhPHjohzfZhsaX4HMdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Csq3FgsAR7BzrMUIzr7gSgK0fRKmhk6XWytIjQ598P8=;
 b=OlK94/NPDhS8U1Uf4Y5I/dT6PF4gqGFGPatKNzB1H+7C8Hlvj1spP3h3mRh/nNBQHFW82yflj98Rz7A1Nuc64TOD+nthjbdw3o630XmgN5+9sJ5r//KH/LCsAsyl/qjxh5nToiNijOuyzlHL9qB+esUGuHdv8jtWlm3DLxl8Cow=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PR3PR04MB7482.eurprd04.prod.outlook.com (2603:10a6:102:8f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.24; Tue, 23 Aug
 2022 02:11:58 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b478:43c4:f1df:d1ff]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b478:43c4:f1df:d1ff%6]) with mapi id 15.20.5546.024; Tue, 23 Aug 2022
 02:11:58 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "marex@denx.de" <marex@denx.de>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v3 2/6] dt-binding: phy: Add iMX8MP PCIe PHY binding
Thread-Topic: [PATCH v3 2/6] dt-binding: phy: Add iMX8MP PCIe PHY binding
Thread-Index: AQHYstLhBnUuOF8ALUKGid366nxpcK27PlyAgAB2RfA=
Date:   Tue, 23 Aug 2022 02:11:58 +0000
Message-ID: <AS8PR04MB8676272814A6F20E26C53B758C709@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1660806153-29001-1-git-send-email-hongxing.zhu@nxp.com>
 <1660806153-29001-3-git-send-email-hongxing.zhu@nxp.com>
 <20220822180713.GA75195-robh@kernel.org>
In-Reply-To: <20220822180713.GA75195-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4d4bcf8-db24-45e2-972e-08da84acdc18
x-ms-traffictypediagnostic: PR3PR04MB7482:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 34sxIMHLcRCphaX4mqCrtrdICnVZiytlAU7+4fMcur0gW/MtfZKvTuqCXLi4o8z1fFVFqQ567pbSaJJr80wPkGo65eA2ogpHfwQ0dVXO0YOYLxApPwDQU2XtTYDVQALkWqSozuTSudnHfjz7c5cX40qUn6f1R5O/YSsR9qgbsPei6MvDbrae0MqZisEX8Lkk7fYHsBNmDnCdDswUPwV8hTArpZwkLYyN3HzaaipY9SUQvt/Vxj7hkuXKGNLifu5WuziG7hfwvqn/4vKtvxI/a/Kpm1YPAoGcg/1/6aGBoCgdDIUq03OTNizcdgXmb51j56S+7KGdxtyXFJ4qNP5pWV2B9In4PD89Fiug13iD5BO9loYXLIqPMaBU9m9AAXDSnxxUA03Mw4GD6l06ChtlbORW3dCwBJ9EN4fB7p3mty3zMjMEkEdoKrAhG8TYzuw/4e4VA+vM1F/1/NTJAkqbSEM8F5ANKD7lwspc0CpC2d/v5v7dsAHm7jpLXpjfY4MgTaFMDwQnnxepH2n7x7vKIw76PR2/DxUv520wWs8MdQhkMf6p72AQ0VBa6pVyYoBJ/wSo4Pp0V4rqUfBIBp1L+NDafVkMIQleEl2XLXEnxunShiHdN9SN2qQMKgfp5Q8Ea632uqFnxEyHB6zN2c/vQ6s4WcctEuO7Fydq1VfKJ3rLjF2WyUh4f0tupr4Qy6yowTnRy8DMI+wWFbtFqrRFgCQcIPm0gOn1UPMoHnMc7Ail4Irc50smjejP3zwRJV28wLUPPcJ55ar0npX28wLzsa9LzzZ/dYTSV7mRpSRSCzI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(33656002)(66446008)(66476007)(76116006)(66556008)(66946007)(44832011)(52536014)(2906002)(41300700001)(64756008)(55016003)(4326008)(8676002)(5660300002)(86362001)(54906003)(7416002)(8936002)(6916009)(316002)(83380400001)(186003)(478600001)(71200400001)(38070700005)(26005)(7696005)(9686003)(53546011)(38100700002)(122000001)(6506007)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?aEtDNWJ0RVI5UVJsTnovWmtvVWIvNnJvWUhsQTZGK3ZBL2xlK3V1WTdPazJz?=
 =?gb2312?B?Z1V3NXMzbzNtTkdGSHFlbWttZ2htQ21pSzltUjZDNElDSmZ4RUlYZENGR0w3?=
 =?gb2312?B?TWE0aXNOS3dzUHBpaWhrNTVmL1ZDN29PaklnOTd2UkpIWm9vT05weUhQWC9V?=
 =?gb2312?B?MVVNNnF4V1hoTElNWVRvZzFiWjJsODNCUjNYVGJWcllXREhkSTdURXZkOXlR?=
 =?gb2312?B?K3JNYy9mNmZwRzhiVE1OVkZHZ2UxaG9VdWZlQ3Z2bUJ4TlYzb01xd0llVE9H?=
 =?gb2312?B?K3NXdGhteDQzTUVJcDlJaWVzVDRRYnEvSXVkR2xkeHY0b2FZSlNJMlFqM1Zw?=
 =?gb2312?B?Q2oxZGpydkdNOFFrNEN3NnFiUFYzQlg4QkVyNWhXSUgzdTZWZFE4d2dmOTZC?=
 =?gb2312?B?S3VnVVc5SlJwOUJPSGY3OGh4cGgrNWViN2lRMWliRFE5U3BlcWNQMVJoNERM?=
 =?gb2312?B?bVg1cXE0Zm5KY2o2THdzMnFiQ2xBNUx1RW1SeEk3UkF4TW8xSzlZaktXalZ2?=
 =?gb2312?B?TW5RdFljQzNnNVBTdExtbXJJMVVuMkc0ZUtETXhyVWRmN2RhN3drZ0ZoZWMv?=
 =?gb2312?B?Q0JwNFdmOTRNWEw2dHN1ejM2a3plTWQ2dWtnNGxKU0s0NGNIb05GK1YvNHhH?=
 =?gb2312?B?V0ZwOTFwU3FjM1BLaXM1Q0Rxc2ljZ0Vyc1Bzalo4UGdDajBPa0NpWmRKQng4?=
 =?gb2312?B?aEtyOHA2cTJSc1VYeUQvRnE4N3FLb2RUMTBqS3RrK0p1b0J6WG5PY3RWVGtI?=
 =?gb2312?B?WUJpSWUvb2JReVdTbG1zVmVxczROUklIRm8wNm9obzk0ZFdVWEVhK2hBNmhU?=
 =?gb2312?B?QVRNd2kralZJcWpRYnpKUTNKTWxxMFVyVjgrK1pvZjQzN0Z1Rm5CbkxBWkd4?=
 =?gb2312?B?UUlqbU9EK0pkeVJJMDdpVHJqckRpS1JBT0JRQXZBRDR5Yld2SXBmT0poekZl?=
 =?gb2312?B?Rk5QbnA5MlZteUZtRjBQUmVpZW1lU21LQmdQZFNCMUVtWnpmK2ZBQjZIU1BP?=
 =?gb2312?B?NkdPUEFvb1JoQU9XVkgyMWk5ak0rc3Z1eWl1bUN2dnR4WWcvZGRhVTVKTlVG?=
 =?gb2312?B?eXNuUWpPOEtiZFhjNThnUGxMVXlEd0hnYWpwVW1qakc4SXRhbEdRbE9mdUpi?=
 =?gb2312?B?Y2ZqM0l5L0IwTnlwTXEzZXc3aGFYRlhkVGV6S3pZV3l0ZEVrQURlYk1QYkZQ?=
 =?gb2312?B?UFZlSllDVVhRZjZndTFCT0R1bUVidjdMdS8vbFZmRVVIUU8zWGtVTHpTYkpZ?=
 =?gb2312?B?Q2NRNnJuR3lSNkF0L3VEVUFObEx4SVpOeXhYeDJLTm1ET1lWY1NRdGxBS0No?=
 =?gb2312?B?QXBIRXBVWFhDdDlYRFdrSFNOSUJ5TEFwVEtYTWZvMUE5U0hDeDlOL1Erb1N3?=
 =?gb2312?B?b0RoejJ3YVU0YSs2MG0weVJHM00xMzV6Mi94UDYzTkhySDlOWjZ3Q3dLUmo4?=
 =?gb2312?B?SnJJRVVOQysxb3hWa2FPUXFqUGRKWlVZbEkxcENBc2t6NEFPWDVpNnpXbHlI?=
 =?gb2312?B?NzdZYXVOb2V3RXlkWWxmbDdTTWhqZkJwTjZzZnZMQy9FRHdrSUlGd1NDNGE4?=
 =?gb2312?B?UzY1V21lVkJ0Z0VWQ2lQU0s5TS9FektMTFJSbnJOak1XNVlTd2tjVmpZanBw?=
 =?gb2312?B?cWRVOGh4S0dtOVRpanR4cVFLbjUvRmt3UytoL3h6TmZIT2hQQm9CMkVwdTJC?=
 =?gb2312?B?K2ZHN2pPeHBrNkRwNHE0Rk45eVZISTVnTkthbzgwSWp6V1IwNEs0RmVLVk0r?=
 =?gb2312?B?a2JLaExxVFNLTTY3ZFgrL0pKTjNkTEdUYncwSWl4QlVqUkpETGJHSDlrZHlQ?=
 =?gb2312?B?SjM1ZkkvT0tQRHV4a0V4eXBtZWdlQ2IyRmJrOFlwRTJGT0Jmb3o1RVNUck9J?=
 =?gb2312?B?bXpzUHVPRWJhVmtGbk5KWVdaQkhwdlRMakptbGJUTVNDUm94N0sybkhFaWpi?=
 =?gb2312?B?My8zRTFxeEhFalBtem92ejRON3hjRjI4aVZhdGdxVlY4eHA2UEhuUUE4bzlX?=
 =?gb2312?B?bFNsWGRYVkhvSGhkeStTcWY4QVNHV1RETVFKdHJqREoxOHpDcnNvM1Z1cnJS?=
 =?gb2312?B?ZW5hSE1IZXl2L2lSQVV0NWxIVjJhdEFMSE1vVldEWGpoZDJCZ3EvbUMyd1BW?=
 =?gb2312?Q?OQuzAM6e0YxO99bDwpwJb+3VN?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d4bcf8-db24-45e2-972e-08da84acdc18
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 02:11:58.7718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zz02BiWGyFrW+funrS2rvWQwAGXbWErQtukBbOlq3EPnp2zaiUkmfYMCMmuopy5VBNGZJ1XrjrPgIwNn+B7XHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7482
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPg0KPiBTZW50OiAyMDIyxOo41MIyM8jVIDI6MDcNCj4gVG86IEhvbmd4aW5nIFpo
dSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBwLnphYmVsQHBlbmd1dHJvbml4LmRlOyBs
LnN0YWNoQHBlbmd1dHJvbml4LmRlOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiBsb3JlbnpvLnBp
ZXJhbGlzaUBhcm0uY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOyB2a291bEBrZXJuZWwub3JnOw0K
PiBhbGV4YW5kZXIuc3RlaW5AZXcudHEtZ3JvdXAuY29tOyBtYXJleEBkZW54LmRlOw0KPiBsaW51
eC1waHlAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+
IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsga2VybmVsQHBlbmd1dHJv
bml4LmRlOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYzIDIvNl0gZHQtYmluZGluZzogcGh5OiBBZGQgaU1YOE1QIFBDSWUgUEhZIGJp
bmRpbmcNCj4gDQo+IE9uIFRodSwgQXVnIDE4LCAyMDIyIGF0IDAzOjAyOjI5UE0gKzA4MDAsIFJp
Y2hhcmQgWmh1IHdyb3RlOg0KPiA+IEFkZCBpLk1YOE1QIFBDSWUgUEhZIGJpbmRpbmcuDQo+IA0K
PiBFeHBsYWluIHRoZSBkaWZmZXJlbmNlcyBpbiBoL3cuIFRoZSBwaHkgaXMgY29ubmVjdGVkIHRv
IFBFUlNUIz8NCj4gDQpIaSBSb2I6DQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3IGNvbW1lbnRzLg0K
WWVzLCBpdCBpcy4gUEVSU1QjIGltcGFjdHMgUENJZSBQSFkgdG9vLg0KVGhlIGRlZmF1bHQgdmFs
dWUgb2YgdGhpcyBiaXQgaXMgMWInMSBvbiBpLk1YOE1RL2kuTVg4TU0gcGxhdGZvcm1zLiANCkJ1
dCBpLk1YOE1QIGhhcyBvbmUgaW52ZXJzZWQgZGVmYXVsdCB2YWx1ZSAxYicwIG9mIFBFUlNUIGJp
dC4NClRoZSBQRVJTVCBiaXQgc2hvdWxkIGJlIGtlcHQgMWInMSBhZnRlciBwb3dlciBhbmQgY2xv
Y2tzIGFyZSBzdGFibGUuDQpTbyBhZGQgdGhlIFBIWSBQRVJTVCBleHBsaWNpdGx5IGZvciBpLk1Y
OE1QIFBDSWUgUEhZLg0KDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9u
Z3hpbmcuemh1QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9waHkvZnNsLGlt
eDgtcGNpZS1waHkueWFtbCAgICAgICAgICB8IDE2ICsrKysrKysrKysrKystLS0NCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9mc2wsaW14
OC1wY2llLXBoeS55YW1sDQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bo
eS9mc2wsaW14OC1wY2llLXBoeS55YW1sDQo+ID4gaW5kZXggYjY0MjFlZWRlY2UzLi42OTI3ODNj
N2ZkNjkgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3BoeS9mc2wsaW14OC1wY2llLXBoeS55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3BoeS9mc2wsaW14OC1wY2llLXBoeS55YW1sDQo+ID4gQEAgLTE2LDYg
KzE2LDcgQEAgcHJvcGVydGllczoNCj4gPiAgICBjb21wYXRpYmxlOg0KPiA+ICAgICAgZW51bToN
Cj4gPiAgICAgICAgLSBmc2wsaW14OG1tLXBjaWUtcGh5DQo+ID4gKyAgICAgIC0gZnNsLGlteDht
cC1wY2llLXBoeQ0KPiA+DQo+ID4gICAgcmVnOg0KPiA+ICAgICAgbWF4SXRlbXM6IDENCj4gPiBA
QCAtMjgsMTEgKzI5LDE2IEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICAgIC0gY29uc3Q6IHJlZg0K
PiA+DQo+ID4gICAgcmVzZXRzOg0KPiA+IC0gICAgbWF4SXRlbXM6IDENCj4gPiArICAgIG1pbkl0
ZW1zOiAxDQo+ID4gKyAgICBtYXhJdGVtczogMg0KPiA+DQo+ID4gICAgcmVzZXQtbmFtZXM6DQo+
ID4gLSAgICBpdGVtczoNCj4gPiAtICAgICAgLSBjb25zdDogcGNpZXBoeQ0KPiA+ICsgICAgb25l
T2Y6DQo+ID4gKyAgICAgIC0gaXRlbXM6ICAgICAgICAgICMgZm9yIGlNWDhNTQ0KPiA+ICsgICAg
ICAgICAgLSBjb25zdDogcGNpZXBoeQ0KPiA+ICsgICAgICAtIGl0ZW1zOiAgICAgICAgICAjIGZv
ciBJTVg4TVANCj4gPiArICAgICAgICAgIC0gY29uc3Q6IHBjaWVwaHkNCj4gPiArICAgICAgICAg
IC0gY29uc3Q6IHBlcnN0DQo+IA0KPiBUaGlzIGRvZXMgdGhlIHNhbWUgdGhpbmc6DQo+IA0KPiBt
aW5JdGVtczogMQ0KPiBpdGVtczoNCj4gICAtIGNvbnN0OiBwY2llcGh5DQo+ICAgLSBjb25zdDog
cGVyc3QNCj4gDQpPa2F5LCB0aGFua3MuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4g
DQo+ID4NCj4gPiAgICBmc2wscmVmY2xrLXBhZC1tb2RlOg0KPiA+ICAgICAgZGVzY3JpcHRpb246
IHwNCj4gPiBAQCAtNjAsNiArNjYsMTAgQEAgcHJvcGVydGllczoNCj4gPiAgICAgIGRlc2NyaXB0
aW9uOiBBIGJvb2xlYW4gcHJvcGVydHkgaW5kaWNhdGluZyB0aGUgQ0xLUkVRIyBzaWduYWwgaXMN
Cj4gPiAgICAgICAgbm90IHN1cHBvcnRlZCBpbiB0aGUgYm9hcmQgZGVzaWduIChvcHRpb25hbCkN
Cj4gPg0KPiA+ICsgIHBvd2VyLWRvbWFpbnM6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjogUENJZSBQ
SFkgIHBvd2VyIGRvbWFpbiAob3B0aW9uYWwpLg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiAr
DQo+ID4gIHJlcXVpcmVkOg0KPiA+ICAgIC0gIiNwaHktY2VsbHMiDQo+ID4gICAgLSBjb21wYXRp
YmxlDQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0KPiA+DQo=
