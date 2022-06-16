Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7DA54D83D
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 04:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242913AbiFPCXf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 22:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239210AbiFPCXe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 22:23:34 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70072.outbound.protection.outlook.com [40.107.7.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AC84617B;
        Wed, 15 Jun 2022 19:23:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJOqWkGFYC0Z320KOro8D7zJLvStGIeGhiFg37vV0tkJiuQC3x97OnmeYgWTEDcU5zlRcV/k988TM/qSIwmJkXr73k3MfdFueFi4F5nCtLcuKwj73VHps1hS1Mh0/f7HUYmLE+5pJ1ZbsolWKibW0Bc3R8k4+14+Ov0gaEf6N8QLftKXjKHLATwHTWDOPsbYnAA2gxezB0A7XbMQJM6SUrhVO84PwT5Q5Tomp6m/AEUr7LerkdnrE+cpJqsrZhsQ83sKIKviBOvxktfJsML/sq7LnXE5atFnB6lZ1pcP2NxOrFEv2wMe8JTgW2AVhsXMW37CxCz24Kr5hE6+zx4pTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEexUkEq978p1i2Z8AgFow+upogVjtg0tTNdqupPjWk=;
 b=CFE9KH7xADX8OwmE+PaLfY8fZ9bdnEdEaEqU/xc5nER4F0N090uvsFgjJFkU278Scd85m/FXaB6aPlHsBia/wwCdBoTcP3t5PQpfHVACnGQdvqb+oX1BsN3Ws5tMK+LjMxNqWdCgZ/ElaL8lUL1v9h8E34mLmjY3+nadMDk0tji7Aihk8HEgG8bfERDAA0E5lhtV22qiknwG8ryJ4DR4AwCqjFdnOFd8tGWzxG2pdk+PWac3ywfmRWQ5my/rUekirrbc7o7GW1I/wMUy2hblnZlEYlPTcszcNDQXV4E0IVnbwZCmljo4xUsWRZSVkgGrO/H3jSCBkCVWPKk7gsr86A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEexUkEq978p1i2Z8AgFow+upogVjtg0tTNdqupPjWk=;
 b=YILzrrk07xqZ10AahOZargRTFz12EV7hgxqKkMF1N/Moe0zPlNnIkGgiEieJSBa7BjEECbeLK41lUb63Pqgtfx+rK/5XdDQqwkalOVAixUf6eeulu6Gp3Jokgjhj5DNdbXZ3J7gyR8HgrWMUfSikHHPGZmmWV3H27QNAOTC/sUg=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB9PR04MB8252.eurprd04.prod.outlook.com (2603:10a6:10:24d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 16 Jun
 2022 02:23:29 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::a0fa:978c:2b40:2cb7]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::a0fa:978c:2b40:2cb7%6]) with mapi id 15.20.5353.013; Thu, 16 Jun 2022
 02:23:29 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH v12 09/13] PCI: imx6: Turn off regulator when system is in
 suspend mode
Thread-Topic: [PATCH v12 09/13] PCI: imx6: Turn off regulator when system is
 in suspend mode
Thread-Index: AQHYgQ3uv73OABlIQ0uV4ens6/i6vq1RHbYAgAAqOkA=
Date:   Thu, 16 Jun 2022 02:23:29 +0000
Message-ID: <AS8PR04MB8676919AEB21FDA9F632CA4A8CAC9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20220615231551.1054753-10-helgaas@kernel.org>
 <20220615233034.GA1056086@bhelgaas>
In-Reply-To: <20220615233034.GA1056086@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c99dfa7-0c68-4454-6919-08da4f3f33d2
x-ms-traffictypediagnostic: DB9PR04MB8252:EE_
x-microsoft-antispam-prvs: <DB9PR04MB825293F040FD2E85A5CDE33F8CAC9@DB9PR04MB8252.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5v85Ocx9PmvMfAaEiDFZERTvYkyz7S3qYvq6OYpvoN/XXLSBsTLNQaqOK/fL0kOuJ0qN8879cBqAJ3F4lQ78gQCm1/ROaDWGV9pAnYhEOr8E7+s8Q7/uRtogQL6K+RgCw4/4HdlENYDw+3ZcyfhXxLZE9tv3Dvl9plkW6rXvIZJ+mgqXbAf71fBeAqIG7L3HlKO6A+euCHY0Mon7pN+/oOmiqnsIvYmNOgQ02/tuoAssxgnbuidLfYAlfmKCI8qomCqi4vBWrcmeeJSoPI0rdEdN//1S6bnnYd19kwqPN0bHteAA8RE380aKOE1lRrKPWqVWn/saRBeczr+1AYPTmHaIHVx1WHBJGlDYBhWXrC0soltEdrAFuMJjR99u7J3BJ/V2z1VutzMJPM69nswpQ9OGE9JMeqyV32airzotNc8B3VkNkqa6ieNonQj+H6SZSH/ULspl7A68G2dW9m0xWhTWDb1cc1CC8SA4MA9GPnVLjSb3+vkEA6/uXqc+/8b2XFJvLOeEsy3uZe6Ztm4dsrn/8dlaf7t6AoEdW2pe6Z5y71vvIdFpPYOGiaYAvRpJdJJCIapg+178BB6TgVOk1/qZoqzPd/H74znIDeIsFCQnYvRNip5t8FCKVflcQTdkdWaUVEf/iRZx+JaqiMd9wiSSXYF8zfEMlG8f/RD45Iv2Hlyg7DK4U+VnVd41YT35G4yct1OXggXxLIHbuu5L5u+VXE7xFJ1GgT+ZGK2uiwfs1dnjXDMBcJ9bJoasCG9Tlqexe0u8xVB0XPTZh28xTzA8o41EaheiUgN0uTtPHyyNAtfOfZyrMMQi/pOVXkxiVrsBhbD1Ef3iNyrNtTaNpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(52536014)(8936002)(7696005)(6506007)(966005)(508600001)(2906002)(122000001)(33656002)(15650500001)(45080400002)(5660300002)(44832011)(55016003)(7416002)(186003)(38100700002)(86362001)(83380400001)(26005)(9686003)(316002)(53546011)(110136005)(54906003)(4326008)(76116006)(66946007)(66556008)(38070700005)(8676002)(64756008)(66476007)(66446008)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WVc0SEtHcEdTQjg4bkxiOXhDMEpTb0hDbFp1cTVyTm45bk1kVmxzeU5WRk9D?=
 =?gb2312?B?L25nT3N5WXVzYU1rNVJPa0NuRkE3ZVRhWjRVNHlsME1TUVZLOG1iVllEL3I1?=
 =?gb2312?B?QXI5MFU2SFBBZ045V2VxM1VYUlpxVGRIUHpURUt3WC9PVzhwb2hNdWdrSGhK?=
 =?gb2312?B?Z0IxMlp4Z1JFQ3QyU3AvdzBkY294UFRZT3FLUndheU5xN2NjK0JXeEVOeGVG?=
 =?gb2312?B?YkpUU3E5UjEyNmRORS85cEhDMlVoYytwczVnRlZkSTIyWHUrL3EvVk9yTmh2?=
 =?gb2312?B?ck9va0tqRHdGREY2cTFlMHN4Z2QxUUFEQlhxWVZrTXdwaXRpZ2kxTkZLdGRw?=
 =?gb2312?B?WURIZ0JLVW0za3VtNGVUOXJXOWpUSllQeGhtS2xVVDhkSlZjNXdGVTJmVlJB?=
 =?gb2312?B?d1BNYlEzZllsbU12ZXN5TmQreGVZcWpZekJ3RDNSRGNTZGJWMVU0L3ROVTBT?=
 =?gb2312?B?MjY1Z2FiOUVWZ3hvNFVLSUNJdGcwWHFpcU9PTlowZ0dyN0FjTHJBVG56TEQ5?=
 =?gb2312?B?QzF4NEh4UDRZc0hoMkc3T0ZnUW82QWpxd0RCTTh0Q1p3SytIbkcvZDVXT2Ey?=
 =?gb2312?B?dXE2TXpwQnRoZE5NUGJEUzcxRVZ3bU1GQmVOWXBOdGFQM0l3YWNRWTdLUmc3?=
 =?gb2312?B?Y1JIeU1nS0NpMDZVcmZDVFJvSDF4T2NBVGVJZ0NUYmJ5R1I2bUgzeFVnYzky?=
 =?gb2312?B?TFhDdmVpbHhxaUZrYnVJYzFRbzlvb3cxUjZvTVRrUWlCSTNRWVdRemVINXAx?=
 =?gb2312?B?aHlITUl1S0cwSGtMVHZ4RWNGQjBsUXVwV2s0RzFjNE1JNnd2R3ozQ0pEaGdL?=
 =?gb2312?B?cnVOSHVsL0lUVkxjVUs0ZnhXMC8xRHY2MzJjVmJNVUdadU9qMmVtVXZralZ2?=
 =?gb2312?B?Z05FdU1sM3Y4MW1FUnFpRnVlM0FaUUFrRjdTTVNmbTAxdFBZQWNqUHJVQXRS?=
 =?gb2312?B?L1hGaHN0WjJkM1FSbUtjTlpMMzl6bUpRMWpnZGNtSGtuQ2dDTlZEMURsYVhL?=
 =?gb2312?B?VVFQY3VlZlVFT2t3ZHJ5UXRCNFUyeW5RdmdQUGpkYUQvTEYrYVhUNDhGS0RG?=
 =?gb2312?B?ZnpwZEpOSWFtWlJLZmZHR2NJNjUrYm1ReWhna3RFQ2o3RjhkTzQ1Z1FZU1Jj?=
 =?gb2312?B?K1BmbmIxZzk3TlppbmtHcS8yNGVva3lVUGFTd1Bid2dncVJjNHlFMGFRYUdw?=
 =?gb2312?B?R2NLMWh6RG8rVlAzcTFFK1V5UlFrdFlJY1Jqcit3eFNOVjEwQlh1NWNnekw1?=
 =?gb2312?B?aElnLzU1Z2xpaXZxMnVwbkd2Z21Ca3ptVXJVMGxNZHo3MzB4d0RFcEd3RTEv?=
 =?gb2312?B?bkg2Y3hVMWV0dXBIc1dya2lNSDNldVFGVnN6eFNPVDB0L2F6L2RKUnlyUTZS?=
 =?gb2312?B?Zkc3QlkrZHBDdjU2dWs2aWtFMFUvSWdJWFFLK2lIbnA0SUwvUEJxcWlkMDdQ?=
 =?gb2312?B?bkdxQTBHeW9ucitQTFFuZ2xkakJBdVVNbFhqek4wRnFJL3Z6TzRaMFRENW1E?=
 =?gb2312?B?dnNJY2J4ODRzUEhDQjJuZmg0OTgyMEZlSXEyOC91YTBuZEpIWmx6SEJVYTB0?=
 =?gb2312?B?N1FGRTEzbVhkNUo2dVVuelViQ2EwMHFqSnZTRE9FSDB1aTNsTWhsQmU4Vk5n?=
 =?gb2312?B?dDdlMkdua3NKVCtRaWYrYUZPWSs4eEJrU3JuWWpnSnpkbEVVM2xZeWdNRWtN?=
 =?gb2312?B?ZE5kM3ltQ1RrWmJTOFFWd0N6UUcvVWpEQTlFeVVUYU1BZFRxZ2F0NWpSdDM5?=
 =?gb2312?B?ZWllTEtZbWM0QUVGM2xJWlBubXd1NmlOUTRkSGlmSEtBdTJMbHVrOVI3ek1N?=
 =?gb2312?B?ZnAyS2g5bE9YdDF0Ky85SW1kckNvK25wOTJtbjRldnMyZ0FocTBzWUxseEVq?=
 =?gb2312?B?ajNMMy94WEtMUjFMNmVTQ2JWNmlYZk1FaDNPUHlHb3pkN0VwaTVndTRGM1pH?=
 =?gb2312?B?L3VERG55djV4dmgwdkRGbkl3cVBMdDY1Mkxld3BBaVV1QlR2RWlUTWpHbW54?=
 =?gb2312?B?dXo4RFEwd0R4cjF6dTgwM2JxVGlPQ0VGQm4rdGlVdFBqZVdkWFRGUVlwbkNM?=
 =?gb2312?B?SW5SVklLR3BIbzc4bG1sR2NIR2tEaXVMQ2E2Ni80U2VNaWFFdnRuSmRBNW9G?=
 =?gb2312?B?UGIxb28yOFpXM0VVTUI1Y3phUDBlWHpJM1p3Z0NPYkNiVVRsMmt6WndGV25o?=
 =?gb2312?B?OFowOEdDN1lZYnJuM29NZHErN1dqQmFDYXBsN1daWXJwSjNFbTlTYUlueGNT?=
 =?gb2312?B?eGxQN3RDdi8vRE9TRjRUaW55ZTM3Q2dROXRVNHd5Rm5hYkd6a2o1R1NHV1Uw?=
 =?gb2312?B?UXVLalc4YStwRFVOUzdoY0FyYVJyU3JIaDV6OVVXZE55YVltMXZ2Zz09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c99dfa7-0c68-4454-6919-08da4f3f33d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 02:23:29.6669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JO2ZFk0PpACbCQR/eTQ8sg33YZx8fYmv90pG0PIPdoL7LPC7htiCGmfzkT56MfJYSssPNozwXGz6d5uCdXfzwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8252
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
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jbUwjE2yNUgNzozMQ0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IEx1Y2FzIFN0YWNoDQo+IDxsLnN0YWNoQHBl
bmd1dHJvbml4LmRlPjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IE1hcmsgQnJv
d24NCj4gPGJyb29uaWVAa2VybmVsLm9yZz47IExvcmVuem8gUGllcmFsaXNpIDxsb3JlbnpvLnBp
ZXJhbGlzaUBhcm0uY29tPjsgRmFiaW8NCj4gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPjsg
RnJhbmNlc2NvIERvbGNpbmkNCj4gPGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tPg0KPiBD
YzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBrZXJuZWxAcGVuZ3V0
cm9uaXguZGU7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+OyBCam9ybiBIZWxn
YWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxMiAwOS8x
M10gUENJOiBpbXg2OiBUdXJuIG9mZiByZWd1bGF0b3Igd2hlbiBzeXN0ZW0gaXMgaW4NCj4gc3Vz
cGVuZCBtb2RlDQo+IA0KPiBPbiBXZWQsIEp1biAxNSwgMjAyMiBhdCAwNjoxNTo0N1BNIC0wNTAw
LCBCam9ybiBIZWxnYWFzIHdyb3RlOg0KPiA+IEZyb206IFJpY2hhcmQgWmh1IDxob25neGluZy56
aHVAbnhwLmNvbT4NCj4gPg0KPiA+IFRoZSBkcml2ZXIgc2hvdWxkIHVuZG8gYW55IGVuYWJsZXMg
aXQgZGlkIGl0c2VsZi4gVGhlIHJlZ3VsYXRvcg0KPiA+IGRpc2FibGUgc2hvdWxkbid0IGJlIGJh
c2luZyBkZWNpc2lvbnMgb24gcmVndWxhdG9yX2lzX2VuYWJsZWQoKS4NCj4gPg0KPiA+IE1vdmUg
dGhlIHJlZ3VsYXRvcl9kaXNhYmxlIHRvIHRoZSBzdXNwZW5kIGZ1bmN0aW9uLCB0dXJuIG9mZiBy
ZWd1bGF0b3INCj4gPiB3aGVuIHRoZSBzeXN0ZW0gaXMgaW4gc3VzcGVuZCBtb2RlLg0KPiA+DQo+
ID4gVG8ga2VlcCB0aGUgYmFsYW5jZSBvZiB0aGUgcmVndWxhdG9yIHVzYWdlIGNvdW50ZXIsIGRp
c2FibGUgdGhlDQo+ID4gcmVndWxhdG9yIGluIHNodXRkb3duLg0KPiA+DQo+ID4gTGluazoNCj4g
PiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0
cHMlM0ElMkYlMkZsb3JlDQo+ID4gLmtlcm5lbC5vcmclMkZyJTJGMTY1NTE4OTk0Mi0xMjY3OC02
LWdpdC1zZW5kLWVtYWlsLWhvbmd4aW5nLnomYW1wO2QNCj4gYXQNCj4gPg0KPiBhPTA1JTdDMDEl
N0Nob25neGluZy56aHUlNDBueHAuY29tJTdDOGRlYTQ2ZDkwOGQzNGNiNDgyNTgwOGRhNA0KPiBm
MjcwZWFmJQ0KPiA+DQo+IDdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdD
MCU3QzYzNzkwOTMyNjQxNTY0MTUNCj4gMzUlN0NVbmtuDQo+ID4NCj4gb3duJTdDVFdGcGJHWnNi
M2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazENCj4gaGFX
d2kNCj4gPg0KPiBMQ0pYVkNJNk1uMCUzRCU3QzMwMDAlN0MlN0MlN0MmYW1wO3NkYXRhPXRxemxj
Q210U2tVTnhOekowRnI1bw0KPiBDUjNYMkNUSA0KPiA+IDRkd1VKUzROWHQ1S1JjJTNEJmFtcDty
ZXNlcnZlZD0wDQo+ID4gaHVAbnhwLmNvbQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1
IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCam9ybiBIZWxnYWFz
IDxiaGVsZ2Fhc0Bnb29nbGUuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2ktaW14Ni5jIHwgMTkgKysrKysrKy0tLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gYi9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gaW5kZXggNmVkZGQwYjVmNjI4
Li41MzdiOGEyZTBlM2IgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpLWlteDYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1p
bXg2LmMNCj4gPiBAQCAtNjcwLDggKzY3MCw2IEBAIHN0YXRpYyB2b2lkIGlteDZfcGNpZV9jbGtf
ZGlzYWJsZShzdHJ1Y3QgaW14Nl9wY2llDQo+ID4gKmlteDZfcGNpZSkNCj4gPg0KPiA+ICBzdGF0
aWMgdm9pZCBpbXg2X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQoc3RydWN0IGlteDZfcGNpZSAqaW14
Nl9wY2llKQ0KPiA+IHsNCj4gPiAtCXN0cnVjdCBkZXZpY2UgKmRldiA9IGlteDZfcGNpZS0+cGNp
LT5kZXY7DQo+ID4gLQ0KPiA+ICAJc3dpdGNoIChpbXg2X3BjaWUtPmRydmRhdGEtPnZhcmlhbnQp
IHsNCj4gPiAgCWNhc2UgSU1YN0Q6DQo+ID4gIAljYXNlIElNWDhNUToNCj4gPiBAQCAtNzAyLDE0
ICs3MDAsNiBAQCBzdGF0aWMgdm9pZCBpbXg2X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQoc3RydWN0
DQo+IGlteDZfcGNpZSAqaW14Nl9wY2llKQ0KPiA+ICAJCWJyZWFrOw0KPiA+ICAJfQ0KPiA+DQo+
ID4gLQlpZiAoaW14Nl9wY2llLT52cGNpZSAmJiByZWd1bGF0b3JfaXNfZW5hYmxlZChpbXg2X3Bj
aWUtPnZwY2llKSA+IDApIHsNCj4gPiAtCQlpbnQgcmV0ID0gcmVndWxhdG9yX2Rpc2FibGUoaW14
Nl9wY2llLT52cGNpZSk7DQo+ID4gLQ0KPiA+IC0JCWlmIChyZXQpDQo+ID4gLQkJCWRldl9lcnIo
ZGV2LCAiZmFpbGVkIHRvIGRpc2FibGUgdnBjaWUgcmVndWxhdG9yOiAlZFxuIiwNCj4gPiAtCQkJ
CXJldCk7DQo+ID4gLQl9DQo+ID4gLQ0KPiA+ICAJLyogU29tZSBib2FyZHMgZG9uJ3QgaGF2ZSBQ
Q0llIHJlc2V0IEdQSU8uICovDQo+ID4gIAlpZiAoZ3Bpb19pc192YWxpZChpbXg2X3BjaWUtPnJl
c2V0X2dwaW8pKQ0KPiA+ICAJCWdwaW9fc2V0X3ZhbHVlX2NhbnNsZWVwKGlteDZfcGNpZS0+cmVz
ZXRfZ3BpbywNCj4gPiBAQCAtNzIyLDcgKzcxMiw3IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX2Rl
YXNzZXJ0X2NvcmVfcmVzZXQoc3RydWN0DQo+IGlteDZfcGNpZSAqaW14Nl9wY2llKQ0KPiA+ICAJ
c3RydWN0IGRldmljZSAqZGV2ID0gcGNpLT5kZXY7DQo+ID4gIAlpbnQgcmV0LCBlcnI7DQo+ID4N
Cj4gPiAtCWlmIChpbXg2X3BjaWUtPnZwY2llICYmICFyZWd1bGF0b3JfaXNfZW5hYmxlZChpbXg2
X3BjaWUtPnZwY2llKSkgew0KPiA+ICsJaWYgKGlteDZfcGNpZS0+dnBjaWUpIHsNCj4gPiAgCQly
ZXQgPSByZWd1bGF0b3JfZW5hYmxlKGlteDZfcGNpZS0+dnBjaWUpOw0KPiA+ICAJCWlmIChyZXQp
IHsNCj4gPiAgCQkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gZW5hYmxlIHZwY2llIHJlZ3VsYXRv
cjogJWRcbiIsIEBADQo+IC03OTYsNw0KPiA+ICs3ODYsNyBAQCBzdGF0aWMgaW50IGlteDZfcGNp
ZV9kZWFzc2VydF9jb3JlX3Jlc2V0KHN0cnVjdCBpbXg2X3BjaWUNCj4gKmlteDZfcGNpZSkNCj4g
PiAgCXJldHVybiAwOw0KPiA+DQo+ID4gIGVycl9jbGtzOg0KPiA+IC0JaWYgKGlteDZfcGNpZS0+
dnBjaWUgJiYgcmVndWxhdG9yX2lzX2VuYWJsZWQoaW14Nl9wY2llLT52cGNpZSkgPiAwKSB7DQo+
ID4gKwlpZiAoaW14Nl9wY2llLT52cGNpZSkgew0KPiA+ICAJCXJldCA9IHJlZ3VsYXRvcl9kaXNh
YmxlKGlteDZfcGNpZS0+dnBjaWUpOw0KPiA+ICAJCWlmIChyZXQpDQo+ID4gIAkJCWRldl9lcnIo
ZGV2LCAiZmFpbGVkIHRvIGRpc2FibGUgdnBjaWUgcmVndWxhdG9yOiAlZFxuIiwgQEANCj4gLTEw
MjMsNg0KPiA+ICsxMDEzLDkgQEAgc3RhdGljIGludCBpbXg2X3BjaWVfc3VzcGVuZF9ub2lycShz
dHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gIAkJYnJlYWs7DQo+ID4gIAl9DQo+ID4NCj4gPiArCWlm
IChpbXg2X3BjaWUtPnZwY2llKQ0KPiA+ICsJCXJlZ3VsYXRvcl9kaXNhYmxlKGlteDZfcGNpZS0+
dnBjaWUpOw0KPiANCj4gVGhpcyBpcyBhIGxpdHRsZSBiaXQgdWdseSBiZWNhdXNlIGlteDZfcGNp
ZV9zdXNwZW5kX25vaXJxKCkgYW5kDQo+IGlteDZfcGNpZV9yZXN1bWVfbm9pcnEoKSBhcmUgbm90
IHN5bW1ldHJpYy4NCj4gDQo+IFdlIGNhbGwgcmVndWxhdG9yX2Rpc2FibGUoKSBkaXJlY3RseSBo
ZXJlIGluIGlteDZfcGNpZV9zdXNwZW5kX25vaXJxKCksIGJ1dCB0aGUNCj4gY29ycmVzcG9uZGlu
ZyByZWd1bGF0b3JfZW5hYmxlKCkgaXMgYnVyaWVkIGluIGlteDZfcGNpZV9kZWFzc2VydF9jb3Jl
X3Jlc2V0KCkuDQo+IA0KPiBJdCB3b3VsZCBiZSBuaWNlciBpZiB0aGUgc3VzcGVuZCBhbmQgcmVz
dW1lIHBhdGhzIGxvb2tlZCBtb3JlIHNpbWlsYXIsIGFzDQo+IHJvY2tjaGlwX3BjaWVfc3VzcGVu
ZF9ub2lycSgpIGFuZCByb2NrY2hpcF9wY2llX3Jlc3VtZV9ub2lycSgpIGRvLCBmb3INCj4gZXhh
bXBsZS4NClllcywgaXQgaXMuIFRoZSByZWd1bGF0b3JfZGlzYWJsZSgpL3JlZ3VsYXRvcl9lbmFi
bGUoKSBhcmUgbm90IGludm9rZWQNCiBzeW1tZXRyaWNhbGx5Lg0KDQpJbiB0aGUgb3JpZ2luYWwg
Y29kZXMsIHRoZSByZWd1bGF0b3JfZGlzYWJsZSgpIGlzIGNvbnRhaW5lZCBpbg0KaW14Nl9wY2ll
X2Fzc2VydF9jb3JlX3Jlc2V0KCkgYW5kIHdpdGggX2VhbmJsZWQoKSBjaGVjay4NCkFuZCByZWd1
bGF0b3JfZW5hYmxlKCkgaXMgZW1iZWRkZWQgaW4gaW14Nl9wY2llX2RlYXNzZXJ0X2NvcmVfcmVz
ZXQoKS4NCkJvdGggdGhlIHJlZ3VsYXRvciBkaXNhYmxlIGFuZCBlbmFibGUgYXJlIGludm9rZWQg
aW4gcmVzdW1lIGJlZm9yZS4NCkkgbW92ZSB0aGUgcmVndWxhdG9yX2Rpc2FibGUgdG8gc3VzcGVu
ZCBtb2RlIHJlZmVyIHRvIEx1Y2FzJyBjb21tZW50cy4NCg0KUmVmZXIgdG8gdGhlIGN1cnJlbnQg
c2l0dWF0aW9uLCBob3cgYWJvdXQgdG8gbW92ZSB0aGUgcmVndWxhdG9yX2Rpc2FibGUoKQ0KIG91
dCBvZiBpbXg2X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNldCgpIHRvbz8NCg0KQmVzdCBSZWdhcmRz
DQpSaWNoYXJkIFpodQ0KDQo+IA0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+IEBA
IC0xMjY5LDYgKzEyNjIsOCBAQCBzdGF0aWMgdm9pZCBpbXg2X3BjaWVfc2h1dGRvd24oc3RydWN0
DQo+ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+DQo+ID4gIAkvKiBicmluZyBkb3duIGxp
bmssIHNvIGJvb3Rsb2FkZXIgZ2V0cyBjbGVhbiBzdGF0ZSBpbiBjYXNlIG9mIHJlYm9vdCAqLw0K
PiA+ICAJaW14Nl9wY2llX2Fzc2VydF9jb3JlX3Jlc2V0KGlteDZfcGNpZSk7DQo+ID4gKwlpZiAo
aW14Nl9wY2llLT52cGNpZSkNCj4gPiArCQlyZWd1bGF0b3JfZGlzYWJsZShpbXg2X3BjaWUtPnZw
Y2llKTsNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaW14Nl9wY2llX2Ry
dmRhdGEgZHJ2ZGF0YVtdID0gew0KPiA+IC0tDQo+ID4gMi4yNS4xDQo+ID4NCj4gPg0KPiA+IF9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+ID4gbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QNCj4gPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcNCj4gPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2su
Y29tLz91cmw9aHR0cCUzQSUyRiUyRmxpc3RzDQo+ID4gLmluZnJhZGVhZC5vcmclMkZtYWlsbWFu
JTJGbGlzdGluZm8lMkZsaW51eC1hcm0ta2VybmVsJmFtcDtkYXRhPTA1JTcNCj4gQzANCj4gPg0K
PiAxJTdDaG9uZ3hpbmcuemh1JTQwbnhwLmNvbSU3QzhkZWE0NmQ5MDhkMzRjYjQ4MjU4MDhkYTRm
MjcwZWFmJTcNCj4gQzY4NmVhMQ0KPiA+DQo+IGQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdD
MCU3QzAlN0M2Mzc5MDkzMjY0MTU2NDE1MzUlN0NVbmsNCj4gbm93biU3Q1RXDQo+ID4NCj4gRnBi
R1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFX
d2lMQ0pYVg0KPiBDSTYNCj4gPg0KPiBNbjAlM0QlN0MzMDAwJTdDJTdDJTdDJmFtcDtzZGF0YT14
am4zalg3dWI5JTJCWCUyQkFKUTdZUGVjVjUNCj4gdWprekxBUFhrWQ0KPiA+IGhjaWVLcyUyQktx
ZyUzRCZhbXA7cmVzZXJ2ZWQ9MA0K
