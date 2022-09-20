Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807FA5BD8EF
	for <lists+linux-pci@lfdr.de>; Tue, 20 Sep 2022 02:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiITAzo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 20:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiITAzm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 20:55:42 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50051.outbound.protection.outlook.com [40.107.5.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8BB48E82;
        Mon, 19 Sep 2022 17:55:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SB6BlIC6LtYQNhsKV3L7TUt73Itmjop/MNCSHg3xXLJXUT3RiYFlviT+iwD1jc844Gt5qpcAIx6qKqmTnVWCB8a9NiY9E/Pa5cKyJDO4EzswSmfxtNV9Yyi49TWhZQqvgUF/mTLoYhwB26dqm58C/IJ+elRPQyzX08fmP5r4IG7tfMSYNSn5RDceEumtqpQr6zuGPjQRTB8t6tFLQMZt39XptRucm0zSfL2h8TaZkOrlvLJkjBZhMI+o/l73PpSrxxO6cE1YJVQyA1G7O4VvSSJmuW32fuQQrPXqkcJWRRO74C8knnwUMaBUynvxpH0Aaoel4jLcvZiQvUQp0VhjdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnzEUa/WHPaDASnYc72K5W06/HqmLLint0KeyYH81mU=;
 b=ICYX2Yms7Fqy050hgYpQ1IJac3BwnLrItxoiru7HvtWQ/ThRrzgctkKMorKL+X4ZJ+aP5JcjM6ZcTgikygzdeDgPzL0uRcFpr/BJRTIhtVqwziDa17HWHlUIs9kPVbeQWodEyMzsd+TrxQg0beLLsEUCqJpE8m9rHPKt3UyUFs7yTutedaxJBhtSoK8WVDhR4tN3kW4e4g3K1eWS2VNVp1mLmBrAhsDh85Xq76yreQhYjyRegIZAmWyS7SdCKBKE7M4p31TeYLCoUUmuvG6dc2gRCZ2rQ8nY5UzLm07RYMELfk0+DY7IqEcDLl0dC95p1pLZaOHteJy7Boo64fBsew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnzEUa/WHPaDASnYc72K5W06/HqmLLint0KeyYH81mU=;
 b=Ln+IFIAiNYVdF5lIZMW/e3Z+NIicemwhjeJQxtHJdYaDFD4bylaMyU0vHJG802SfT4+xExz5fv8gd8+T8MrSWna9bf/jaq4TpgQ33lVyzsp0bMVLvyvX7nJaT7EpnBN2u2cjaEPALRy0wOuycBb083l2UNISo5wXal3Y8KE4pss=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DBBPR04MB7643.eurprd04.prod.outlook.com (2603:10a6:10:203::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 00:55:37 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::8574:efa7:38c8:3c05]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::8574:efa7:38c8:3c05%7]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 00:55:37 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "richard.leitner@linux.dev" <richard.leitner@linux.dev>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "marex@denx.de" <marex@denx.de>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v7 3/7] arm64: dts: imx8mp-evk: Add PCIe support
Thread-Topic: [PATCH v7 3/7] arm64: dts: imx8mp-evk: Add PCIe support
Thread-Index: AQHYvqyeR+r3+Be+tUGULAnIvuzCQa3m+emAgABn6ICAADTFAA==
Date:   Tue, 20 Sep 2022 00:55:36 +0000
Message-ID: <AS8PR04MB867657D03C61774096A5A1628C4C9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1662109086-15881-1-git-send-email-hongxing.zhu@nxp.com>
 <1662109086-15881-4-git-send-email-hongxing.zhu@nxp.com>
 <ec59c235f11664a0a90f14b86bd63f74fb7f6d27.camel@toradex.com>
 <CAJ+vNU3tV1NSNT8R-QNTxEhe+oxR=Fz9zHKGbf_MSBgr9dQ10g@mail.gmail.com>
In-Reply-To: <CAJ+vNU3tV1NSNT8R-QNTxEhe+oxR=Fz9zHKGbf_MSBgr9dQ10g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DBBPR04MB7643:EE_
x-ms-office365-filtering-correlation-id: 37b2c80d-96a4-4356-0d04-08da9aa2d4d0
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d5tBx7Ho7emC9BEqjaKM8QbXdtAl1c11iW7mdPJ/seWBmYwOaJXsbZv/0+mtZ5Qq5YkrzBnC+JJfbXvYqSiY4SMKiCFhspfIMpy05MlZBq2EUaSPRElb1y/XxwjVHh+LcELQZHcWzfoXGvG5AOTLgj2Ds3PvjlCixbml22QiGeSKuOxNDjhfGZi4lGWtGkkgxNGeYFb9GReQBkopIIrLM7cr5qB0XUwQ/DXP768yE2qEwpu1GUx+MB9rKcs1ODzmx8JpA+CdyECT8rV0ja+9e6BDn8ATwXxvRco5eMztt/aacUZynTCas8j3fU2BfZpmw6w3AfxplSC1x3ui8BoRhAd3WzBrWaJg+LKHk/SIGlv9vXLaQMy1o58bL1bZRyva/jyabHwNCLgJ6JP0rnmek03Dxjtplkv8mjrw1POzREKMrkSb7eMwJ877GeEtpqxlmU0AJBZ8uXzEFQhWichCWez9vsCT02vhLhDqqUYf3I1hV+ZQFM1rpEBw2RCgqFWBIc0GYpxKo5SpbN7IWUop0VZUe0H3O4qBKp9TtnvUfAr/A8fn8qGkXHAgoTLEpPInQZxByQ/D/km/VItXD8EL2HamEHgJEfMv+g4HDxojKLQ9BcqeN4qnP56dchxVwDkRSL3zRCYK3ZlgIq0YJKThpCFXWbrvgIJI/nlRmXOghLf+Pe112bAp5bGA1ugkeHqYP4qHgwM6gZ+Ju2HUt99ZN8fbv6lt0HEArF9s/OuQ+nwmCoslmvG+pPe0LgrbCklTrSJPJ1j2hxpl36fIe234XYNoFEb0BCQ8zSauEEeK4TNOjsKFi0bRxNQxWStYavaK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199015)(38070700005)(4326008)(6506007)(7696005)(2906002)(66446008)(71200400001)(86362001)(38100700002)(55016003)(53546011)(8936002)(9686003)(76116006)(26005)(8676002)(66556008)(33656002)(122000001)(66946007)(66476007)(64756008)(41300700001)(966005)(110136005)(45080400002)(83380400001)(478600001)(186003)(5660300002)(52536014)(54906003)(316002)(7416002)(44832011)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?K2RLK01kWFVNSjhieXF4U21LYXZLNkpJQWFPa1ExYzhvNWVDYjN3VEFpZ09Z?=
 =?gb2312?B?R1ZYWlNEVlh0Z21rdjVwQWswZzdjRmVMTnlIVGlLeHYzK0Z5dmdMRWFzTkJ4?=
 =?gb2312?B?TTl6ZkQzME1qSmhXS2VsVzNzUW0yU1VPTDZUUzRyM1Nqb2ordnpSTk55RGFB?=
 =?gb2312?B?eEJrOVNudWtWUVkyYXhTZVRCbXFSTWNtUE53UFpEZXNCK0dvOW4xaDl4YnNQ?=
 =?gb2312?B?RURHdUQ5OVBUYnhLOTRXZ2RqMFB3cCs3TEZlZElYc2NPcS8yNEdlSkU3bGZt?=
 =?gb2312?B?MUtYemh5ZnpxRGpUZHgvNC9USFgycFZiYzNuTk5FNnJRM0h3eHprK2tqS0lE?=
 =?gb2312?B?S1dzd2dOZzJPVzd3bUI1ZlhqNHBUV0tHNUxMQ3Z5TUJSemtUSFdCV3llK1pi?=
 =?gb2312?B?S2EyRzZFWVJJUzNaU0w1dDdmVW03LzdvSWhkVG1FTkZCNUlNUm5qWGx3UU5S?=
 =?gb2312?B?ZGRTVjBYNkJ1eENMYWFlN0JaY0xteUVERnA2czRFeGtMWWhjeFpIRm9mQ05a?=
 =?gb2312?B?WEJFMlhNZzd2SUZNaHFlUENGQ1gySkxhTDdIMVFZTHhLVWVEM2pkSW9KNXFN?=
 =?gb2312?B?bElNSFdGQ3FsRGh1b3NSazVqc1VWYVpzdHB1Rlg0WnJicjBzekxqcEZIVW9Z?=
 =?gb2312?B?UHhTVUtOb2krSzNlT0lFZHA5elJlb01IeVREdjJtMGlPNDVEUXpCeTFMaThO?=
 =?gb2312?B?TWNVOHBDemVaWXhtNG5NcnN4WTlsMEJ2djQreWpseVlrc3R0Y1Q0anpTTjU1?=
 =?gb2312?B?TWdrR1ZYSnpvWXJwS0MvVi9jOXplTURyWGtBT2I1cmhVSVRtbWlMcjJCc2Nm?=
 =?gb2312?B?SFJVSFZJZE1OODVQdElJQVAvV2FLRTJ2bWxCVU8yRXFXK1YyNUx6NzZ2eEJS?=
 =?gb2312?B?QzBzQjFtNGN5TnhMN0laRno0WE1kN0ovZ2FEY2hSTERNQlBPOTFLbXVKVHR1?=
 =?gb2312?B?b29vMlZMaFlab0JISzFlbHovNUE0TEpFVUhQRlBEMU80NnJzYnJPVkRUaHBK?=
 =?gb2312?B?cWNiRzI3elBVQUM3QVZDZi9NOVFJRUNVcHVNa3QvZ1JHWjFzanIzYjlpNW5E?=
 =?gb2312?B?RkROb0ZYcGZFQmdtTkwzS1BsQWJINWR0OXkwak84aU5tcjdYdUxUVGlPQ3Vs?=
 =?gb2312?B?MXFOTHZhRmc0aDc2NUhtQnd3bmQ0YWlmRmIwb0JQYTdWRDNERk9NMkJHNDN5?=
 =?gb2312?B?ZE5aODhwaThoWVFvZzhOR0tjR1NaRXl2N3NTV2VFQmNYZlBHSCtrOEIxNWly?=
 =?gb2312?B?UzNueGlMU1pPdTRvTGlNYXpJQXZjMFRFR013d0lKR0xyUENtT0ZJZVNqbmFz?=
 =?gb2312?B?QVFFbUFxc3l3SmdJVWEyWXU4TXpKU3E4N2pXbEZybFR0MjZNaDBkcDNCMHMv?=
 =?gb2312?B?ZnpPMWlDU2NrS1QyUVRpMTArTFpvYTY5cXlSbXhiM241bDJ0UlV0bWY3Y1hm?=
 =?gb2312?B?ZXpjQkZadGxUemE5T1pSTHZMbllvM1VsMWgvNWNwN0ZISENVOHNxZHhWN1NB?=
 =?gb2312?B?ZHdnc3dLZVhQN1dEZklMaVpNRGtvbm1MMjhpQTk4RnJMZytZVFRsYmorOEZL?=
 =?gb2312?B?WFpvRkE1SUp4Ui9vdDhnVkpBaWtQSzlOeTRDdjh5aDU3ODBuMkpBV1B1YjZ5?=
 =?gb2312?B?OWVCc05nZkpWVTZoQ3VLNWVRdFJ5dGZ6aTBBcHQvWUZHQWhVVXVpMlQ5bkht?=
 =?gb2312?B?ZDVNSWNmVXpHM0dxZWt1TVFjSnRmRmtob05xWVh1Q1R6SEJ3cHYyNFdaUXZv?=
 =?gb2312?B?ZytTSWJ2UHo0aU9PanF5SzZxWFlweFlObnpWdHNpVTNmSnpkT0hmcFdqT0VE?=
 =?gb2312?B?eVFvOGZabE84VnVLVld6M2IwNUFMNzdGWGpKZHhDSS83VnJ1NTVUVEN5N1Jj?=
 =?gb2312?B?dWU2M1FQbWx6bjVJSVFia2dadVd1TWYyRnFpTUdjNWFpaEEzVmRva0YyT0d5?=
 =?gb2312?B?RHJiMyt6bXQvbWVRNGltYXJQcWF4bDZOejIxZm1LQzhqcDExUzZ2K3ZqSE14?=
 =?gb2312?B?ZDdiSVJTQ3g0RExXOUNOTVcyd0Z2Z0lsU2Q5eGdsNXd0NU9qQzFMUWhkbFBu?=
 =?gb2312?B?ZmFoU0g3WlR6UEttaVptam92ZXFERFhocERrMjFNSGhQR0ozM0FRUHZ3NnhO?=
 =?gb2312?Q?HPY+MSkdfWCDI7uJMe1J2WZDm?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b2c80d-96a4-4356-0d04-08da9aa2d4d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 00:55:37.1506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sA8BBs692bavFifUvqRQTMnxCSw0wh96cu1Hr+0vvPRgfXlLfCM3fRlFwP7UinlaLGEx+tcOPNj0vqyHPnDJTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7643
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgVGltOg0KTWF5YmUgdGhlIGludGVybmFsIFNZU1BMTCBtb2RlIGlzIHVzZWQgb24gTWFyY2Vs
JyBWZXJkaW4gaU1YOE0gUGx1cyBib2FyZC4NClRoaXMgbW9kZSBpcyBub3Qgc3VwcG9ydGVkIG9u
IG15IHByZXZpb3VzIHBhdGNoLXNldCB5ZXQuDQogDQpIaSBNYXJjZWw6DQpJIGd1ZXNzIHRoYXQg
dGhlIGludGVybmFsIFNZU1BMTCBtb2RlIGlzIHVzZWQgb24geW91ciBWZXJkaW4gaU1YOE0gUGx1
cyBib2FyZC4NCkNvcnJlY3QgbWUgaWYgSSdtIHdyb25nLg0KDQpVcCB0byBub3csIHRoaXMgbW9k
ZSBpcyBub3Qgc3VwcG9ydGVkIHlldCwgYWx0aG91Z2ggSSBoYWQgYWxyZWFkeSBvbmUgdGVtcA0K
c29sdXRpb24gdGhhdCBpLk1YOE1QIFBDSWUgd29ya3Mgb24gRVZLIGJvYXJkIHdoZW4gU1lTUExM
IGlzIHVzZWQgYXMgcmVmZXJlbmNlDQpjbG9jayhmc2wscmVmY2xrLXBhZC1tb2RlID0gPElNWDhf
UENJRV9SRUZDTEtfUEFEX09VVFBVVD47KSB3aXRoIHNvbWUgSFcNCnJld29ya3MuDQoNCkFib3V0
IHRoaXMgU1lTUExMIHN1cHBvcnQgbWV0aG9kLCBJIHN0aWxsIGhhdmUgc29tZSBjb25mdXNpb25z
IGFuZCBuZWVkIHRvIA0KY29uc3VsdCBMdWNhcyBsYXRlci4NCkkgY2FuIHNlbmQgbXkgbG9jYWwg
cGF0Y2gtc2V0IHRvIEx1Y2FzIGFuZCB5b3UgYnVkZGllcywgbGV0J3MgZmlndXJlIG91dCBvbmUN
CnByb3BlciBzb2x1dGlvbiB0byBlbmFibGUgdGhlIGludGVybmFsIFNZU1BMTCBtb2RlLg0KDQpC
ZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogVGltIEhhcnZleSA8dGhhcnZleUBnYXRld29ya3MuY29tPg0KPiBTZW50OiAyMDIy
xOo51MIyMMjVIDU6MzQNCj4gVG86IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRv
cmFkZXguY29tPg0KPiBDYzogdmtvdWxAa2VybmVsLm9yZzsgcmljaGFyZC5sZWl0bmVyQGxpbnV4
LmRldjsNCj4gYWxleGFuZGVyLnN0ZWluQGV3LnRxLWdyb3VwLmNvbTsgcm9iaEBrZXJuZWwub3Jn
OyBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBsb3Jlbnpv
LnBpZXJhbGlzaUBhcm0uY29tOyBwLnphYmVsQHBlbmd1dHJvbml4LmRlOw0KPiBIb25neGluZyBa
aHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsNCj4gbWFyZXhA
ZGVueC5kZTsgbGludXgtcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtl
cm5lbC5vcmc7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGlu
dXgtaW14QG54cC5jb20+Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcN
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyAzLzddIGFybTY0OiBkdHM6IGlteDhtcC1ldms6IEFk
ZCBQQ0llIHN1cHBvcnQNCj4gDQo+IE9uIE1vbiwgU2VwIDE5LCAyMDIyIGF0IDg6MjIgQU0gTWFy
Y2VsIFppc3dpbGVyDQo+IDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+IHdyb3RlOg0KPiA+
DQo+ID4gSGkgUmljaGFyZCBldC4gYWwuDQo+ID4NCj4gPiBUaGFuayB5b3UgdmVyeSBtdWNoIGZv
ciB0aGUgaS5NWCA4TVAgUENJZSBzdXBwb3J0IHdvcmsuDQo+ID4NCj4gPiBPbiBGcmksIDIwMjIt
MDktMDIgYXQgMTY6NTggKzA4MDAsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+ID4gQWRkIFBDSWUg
c3VwcG9ydCBvbiBpLk1YOE1QIEVWSyBib2FyZC4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBSaWNoYXJkIFpodQ0KPiA+ID4gPGhvbmd4aW5nLnpodS0zYXJRaThWTjNUY0BwdWJsaWMuZ21h
bmUub3JnPg0KPiA+ID4gVGVzdGVkLWJ5OiBNYXJlayBWYXN1dCA8bWFyZXgteW5RRVFKTnNoYnNA
cHVibGljLmdtYW5lLm9yZz4NCj4gPiA+IFRlc3RlZC1ieTogUmljaGFyZCBMZWl0bmVyDQo+ID4g
PiA8cmljaGFyZC5sZWl0bmVyLVdjQU5YTkEwVWpCQkRnaks3eTdUVVFAcHVibGljLmdtYW5lLm9y
Zz4NCj4gPiA+IFRlc3RlZC1ieTogQWxleGFuZGVyIFN0ZWluDQo+ID4gPiA8YWxleGFuZGVyLnN0
ZWluLVczbys5QnVXalFhWm94NG9wNGlXendAcHVibGljLmdtYW5lLm9yZz4NCj4gPiA+IFJldmll
d2VkLWJ5OiBMdWNhcyBTdGFjaA0KPiA+ID4gPGwuc3RhY2gtYkljbnZiYUxaOU1FR25FOEM5K0ly
UUBwdWJsaWMuZ21hbmUub3JnPg0KPiA+ID4gLS0tDQo+ID4gPiAgYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvaW14OG1wLWV2ay5kdHMgfCA1Mw0KPiA+ID4gKysrKysrKysrKysrKysrKysr
KysNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNTMgaW5zZXJ0aW9ucygrKQ0KPiA+ID4NCj4gPiA+
IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtZXZrLmR0
cw0KPiA+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtZXZrLmR0cw0K
PiA+ID4gaW5kZXggZjZiMDE3YWI1ZjUzLi45ZjE0NjlkYjU1NGQgMTAwNjQ0DQo+ID4gPiAtLS0g
YS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtZXZrLmR0cw0KPiA+ID4gKysr
IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLWV2ay5kdHMNCj4gPiA+IEBA
IC01LDYgKzUsNyBAQA0KPiA+ID4NCj4gPiA+ICAvZHRzLXYxLzsNCj4gPiA+DQo+ID4gPiArI2lu
Y2x1ZGUgPGR0LWJpbmRpbmdzL3BoeS9waHktaW14OC1wY2llLmg+DQo+ID4gPiAgI2luY2x1ZGUg
ImlteDhtcC5kdHNpIg0KPiA+ID4NCj4gPiA+ICAvIHsNCj4gPiA+IEBAIC0zMyw2ICszNCwxMiBA
QCBtZW1vcnlANDAwMDAwMDAgew0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgIDwweDEgMHgw
MDAwMDAwMCAwIDB4YzAwMDAwMDA+Ow0KPiA+ID4gICAgICAgICB9Ow0KPiA+ID4NCj4gPiA+ICsg
ICAgICAgcGNpZTBfcmVmY2xrOiBwY2llMC1yZWZjbGsgew0KPiA+ID4gKyAgICAgICAgICAgICAg
IGNvbXBhdGlibGUgPSAiZml4ZWQtY2xvY2siOw0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgI2Nsb2NrLWNlbGxzID0gPDA+Ow0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY2xv
Y2stZnJlcXVlbmN5ID0gPDEwMDAwMDAwMD47DQo+ID4gPiArICAgICAgIH07DQo+ID4gPiArDQo+
ID4gPiAgICAgICAgIHJlZ19jYW4xX3N0Ynk6IHJlZ3VsYXRvci1jYW4xLXN0Ynkgew0KPiA+ID4g
ICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsNCj4gPiA+ICAg
ICAgICAgICAgICAgICByZWd1bGF0b3ItbmFtZSA9ICJjYW4xLXN0YnkiOyBAQCAtNTUsNiArNjIs
MTcgQEANCj4gPiA+IHJlZ19jYW4yX3N0Ynk6IHJlZ3VsYXRvci1jYW4yLXN0Ynkgew0KPiA+ID4g
ICAgICAgICAgICAgICAgIGVuYWJsZS1hY3RpdmUtaGlnaDsNCj4gPiA+ICAgICAgICAgfTsNCj4g
PiA+DQo+ID4gPiArICAgICAgIHJlZ19wY2llMDogcmVndWxhdG9yLXBjaWUgew0KPiA+ID4gKyAg
ICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsNCj4gPiA+ICsgICAg
ICAgICAgICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiA+ID4gKyAgICAgICAgICAg
ICAgIHBpbmN0cmwtMCA9IDwmcGluY3RybF9wY2llMF9yZWc+Ow0KPiA+ID4gKyAgICAgICAgICAg
ICAgIHJlZ3VsYXRvci1uYW1lID0gIk1QQ0lFXzNWMyI7DQo+ID4gPiArICAgICAgICAgICAgICAg
cmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MzMwMDAwMD47DQo+ID4gPiArICAgICAgICAgICAg
ICAgcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MzMwMDAwMD47DQo+ID4gPiArICAgICAgICAg
ICAgICAgZ3BpbyA9IDwmZ3BpbzIgNiBHUElPX0FDVElWRV9ISUdIPjsNCj4gPiA+ICsgICAgICAg
ICAgICAgICBlbmFibGUtYWN0aXZlLWhpZ2g7DQo+ID4gPiArICAgICAgIH07DQo+ID4gPiArDQo+
ID4gPiAgICAgICAgIHJlZ191c2RoYzJfdm1tYzogcmVndWxhdG9yLXVzZGhjMiB7DQo+ID4gPiAg
ICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJyZWd1bGF0b3ItZml4ZWQiOw0KPiA+ID4gICAg
ICAgICAgICAgICAgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7IEBAIC0zNTAsNiArMzY4LDI4
IEBADQo+ID4gPiAmaTJjNSB7DQo+ID4gPiAgICAgICAgICAqLw0KPiA+ID4gIH07DQo+ID4gPg0K
PiA+ID4gKyZwY2llX3BoeSB7DQo+ID4gPiArICAgICAgIGZzbCxyZWZjbGstcGFkLW1vZGUgPSA8
SU1YOF9QQ0lFX1JFRkNMS19QQURfSU5QVVQ+Ow0KPiA+DQo+ID4gV2hpbGUgdGhpcyBpbmRlZWQg
d29ya3Mgb24gdGhlIEVWSyBzbyBmYXIgSSBmYWlsZWQgdG8gZ2V0IHRoaXMgdG8gd29yaw0KPiA+
IG9uIG91ciBWZXJkaW4gaU1YOE0gUGx1cyB3aGljaCByZXF1aXJlcyB0aGUgZnNsLHJlZmNsay1w
YWQtbW9kZSB0byBiZQ0KPiA+IElNWDhfUENJRV9SRUZDTEtfUEFEX09VVFBVVC4gSXQgaXMgbm90
IHF1aXRlIGNsZWFyIHRvIG1lIHdoYXQga2luZCBvZg0KPiBjbG9ja3MgSSB3b3VsZCBuZWVkIHNw
ZWNpZnlpbmcgaW4gdGhhdCBjYXNlLg0KPiA+DQo+ID4gSGFzIGFueWJvZHkgYnkgYW55IGNoYW5j
ZSB0cmllZCBvbiBhbnkgc3VjaCBIVyBkZXNpZ24/DQo+ID4NCj4gPiBGb3IgcmVmZXJlbmNlIFsx
XSBvbiB0aGUgVmVyZGluIGlNWDhNIE1pbmkgdGhlIHNhbWUgd29ya3MgdmVyeSB3ZWxsIGJ1dCB0
aGUNCj4gY2xvY2tpbmcgc2VlbXMgcmF0aGVyIGRpZmZlcmVudC4NCj4gPg0KPiANCj4gTWFyY2Vs
LA0KPiANCj4gRG8geW91IGhhdmUgYWxsIHRoZSBwYXRjaGVzIGluIFJpY2hhcmQncyBzZXJpZXMg
YXBwbGllZCBbMV0/IFRoZXkgZ290IHBpY2tlZCB1cA0KPiBpbiBkaWZmZXJlbnQgdHJlZXMgc28g
bWFrZSBzdXJlIHlvdSBoYXZlIHRoZW0gYWxsLiBJIGp1c3QgdGVzdGVkIHRoaXMgc2VyaWVzIG9u
IHRvcA0KPiBvZiA2LjAtcmM2IHdpdGggaW14OG1wLXZlbmljZS1ndzc0eHggYW5kIGl0IHdvcmtz
IGZpbmUuIFRoaXMgYm9hcmQgaG93ZXZlcg0KPiBkb2VzIGhhdmUgSU1YOF9QQ0lFX1JFRkNMS19Q
QURfSU5QVVQuDQo+IA0KPiBEbyB5b3UgYnkgY2hhbmNlIGhhdmUgQ0xLUkVRIG5vdCBob29rZWQg
dXA/IElmIHNvIG1ha2Ugc3VyZSB5b3UgYWRkIGENCj4gJ2ZzbCxjbGtyZXEtdW5zdXBwb3J0ZWQn
IHByb2JlIHRvIHBjaWVfcGh5Lg0KPiANCj4gQmVzdCBSZWdhcmRzLA0KPiANCj4gVGltDQo+IFsx
XQ0KPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9
aHR0cHMlM0ElMkYlMkZwYXRjaHcNCj4gb3JrLmtlcm5lbC5vcmclMkZwcm9qZWN0JTJGbGludXgt
cGNpJTJGbGlzdCUyRiUzRnNlcmllcyUzRDY3MzU0OCUyNnN0YQ0KPiB0ZSUzRComYW1wO2RhdGE9
MDUlN0MwMSU3Q2hvbmd4aW5nLnpodSU0MG54cC5jb20lN0M0YTg1YTMyYzgyMQ0KPiAzNGExOTky
YmIwOGRhOWE4NmMwNTQlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlNw0K
PiBDMCU3QzYzNzk5MjIwMDc4NjUyMTI0OSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpv
aU1DNA0KPiB3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2
TW4wJTNEJTdDMzAwMCU3DQo+IEMlN0MlN0MmYW1wO3NkYXRhPUk5WnVCQ1NkeVFpckdxaUpWYXlS
Wm56N3lwYiUyRkNDdEJVc29MV282d2dkSQ0KPiAlM0QmYW1wO3Jlc2VydmVkPTANCg==
