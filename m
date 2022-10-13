Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8482D5FD1D2
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 02:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbiJMAwr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Oct 2022 20:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbiJMAwb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Oct 2022 20:52:31 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20613.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::613])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7750EA691;
        Wed, 12 Oct 2022 17:49:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aj03MJNqOl+yg7cnf/acvYnXLuQSIG+QG7dSKYXcKDpbaNmtWWXVWd1DiKVWDdyk00O4lJj2JQP4afZoJNpgOx0cTH+RGZAXdPUwlBTUCG1S+bAlTtcgAcB/Bk7RU90e3RzMwXAZwQpsIuqcwmNVE4FhOu6sk4Z52YvhcKvD7/VLyZM+wkCNlrrvXyiJwjG66ydmUMnB1o0qa11M64NApWdbOJl6n3eRtczM7qphLq1IH+d24YFJaIkCNrn4Qj8mmBPdPjfTFxZgyg6Fpa60aJk4E6y+pUROoJzNZx+IBCafQmgUUc38vbQ/THoTyLyUdSmInLz/cRKBRYq/4YUbLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EibY0q++j+IA19rCEkpYkFsqy0bZKYXGQjXKp/NhI8E=;
 b=kewy+7LOF//6zU2uoxLhaDpIl+sUyAYt5t4oMTF51EwCKpoBeDcIg+SUOAPfoUuA2WDX2I70kIn9ZeJ7B+kOoctNIwXFo0wnuQwOcjCldUg57iD5TwTQzqmJ8Pqtta6almeVWAOcZw0FHkhuiELP0w8Kj00bXEmoVVzavAn1i2XKRB2b0ZlfUV7hbGRmSitfeVETXZpcUvtwFguFQQDl2+9yUc+Yqsy7NNUs6S1Ih68p25hZ2pzcjCrpDfEg1tau+bf+CkvHuONJOTV2vJ6EhUbGK7NBhbNagpU8w612Uy/g8/1Utgaq0NpyiiXxjOQz6tqO381TW8HgSOkMAgjQvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EibY0q++j+IA19rCEkpYkFsqy0bZKYXGQjXKp/NhI8E=;
 b=qwzw7p+wPHcU4LsZeXC1PAUmF38Wj6pAknrMO79lNTNpFt7q+NT8Vi5+N44D/uBIuh2w+fASr0xxtd9TEOt3JIvgABfpQu+o+hYrO2xldHGBT5b6iXvABsz9EaeGAfx867Lph315geMirpqkFuAGPpck3G6L9qsK24xcvymTtVA=
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com (2603:10a6:10:2dc::14)
 by VI1PR04MB6784.eurprd04.prod.outlook.com (2603:10a6:803:13e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Thu, 13 Oct
 2022 00:45:43 +0000
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::d1bd:16c6:38bd:9220]) by DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::d1bd:16c6:38bd:9220%6]) with mapi id 15.20.5709.015; Thu, 13 Oct 2022
 00:45:43 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     "tharvey@gateworks.com" <tharvey@gateworks.com>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "marex@denx.de" <marex@denx.de>,
        "richard.leitner@linux.dev" <richard.leitner@linux.dev>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v12 0/4] Add the iMX8MP PCIe support
Thread-Topic: [PATCH v12 0/4] Add the iMX8MP PCIe support
Thread-Index: AQHY3H8e1ZA2Rlf190q0hpLDVunRzK4LGJgAgABnq1A=
Date:   Thu, 13 Oct 2022 00:45:43 +0000
Message-ID: <DU2PR04MB8677C5FEE1F93CF2B9B12D3B8C259@DU2PR04MB8677.eurprd04.prod.outlook.com>
References: <1665387971-17114-1-git-send-email-hongxing.zhu@nxp.com>
 <CAJ+vNU2G_zVcFBmS6cR-HQk0XKgx_KaXvwSNmCHRgDy69=J_4g@mail.gmail.com>
In-Reply-To: <CAJ+vNU2G_zVcFBmS6cR-HQk0XKgx_KaXvwSNmCHRgDy69=J_4g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8677:EE_|VI1PR04MB6784:EE_
x-ms-office365-filtering-correlation-id: e91110f0-9579-44a1-1d0d-08daacb442a7
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kBnwNUhC3aTDt7cCzH1b4M6zgCG5juQw/KnulYQ/AhsjXQZozMm196jigJkPWu3Xfz/DJazrlSNT8gHc2+m+DS9Cbetj/VX3hZw0B8dJXOk1ckXVtSPM2qwrV//SESH5kfigATtfB4vuebnN8V6NQUxgzGPYrMhCVEFHji+P2WGF2xcAUtokhHJWSDPVaGm6LujBO/Sa03UbaSDrc/Opafi5eL6c3+UOosgz8xlQzXDCUbIP7sFUKd1cWx3NHtMSF8jJv5qMxznYIYG3HEuJcGX806REWEbdmhRx3ecQmfbbvo/7i71kKBSa9cmEhPGkXpseAaeyCf5ZYgZQq1GNTfPicI/oSLuwA23WKgetIn+oowuQ9YflTJdZhZ1d0i0pQJ+BnhEIJbQ8vYc2Ar9q+/cCsyRrYil2yJIBt1/OV3NjrrgLmE0dd+epATE6lTu6Al37UBIU8SzgXI8tXsshb2kjUmkCJo/N1dqOvVP8+OgHOXBmjrrzN6aJEX36HKh4OtjbAkBzY6R+1oF/l9XXS36jSi9KYviiUNfTMF2tL4VVYi9AMlK9WEMcqTxjiP0f/4EZYly3PvY01X8M7DQzHBqv3Ch1MdWTrqOQNU5YghxFLM0Kjgcy84xg++zddn2UHcuSuA0GkVCon8WHQoXcAY1nQonu8G7xL8dToVsg39aC916WAAfTqyZ+yZzrgZfPm5pptrYw22lWfw3hBh/ot7AXY0qauvi3md8zLl+90EWa6+PWA9I1llk+j547ZrNx90qftqpKkheQ/rbFZbzuAGcLJJrAnMuzOiBWTHfmIM0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8677.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199015)(86362001)(38100700002)(33656002)(2906002)(8936002)(7416002)(44832011)(52536014)(5660300002)(41300700001)(66946007)(76116006)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(316002)(6916009)(71200400001)(38070700005)(54906003)(122000001)(478600001)(53546011)(26005)(83380400001)(55016003)(7696005)(9686003)(6506007)(186003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHcxU3QydlMxL1RuVEpNRG96VjduZm54VEpqSHdJNzEzYmtUd0JwOVcvblJU?=
 =?utf-8?B?eWNhaFJSTUpKMk85emlKdFpIaiswUmVDZnR3Ty8wTnhDaEtlbU9uLzZuUXN0?=
 =?utf-8?B?cnJaNlljeDQvKy9WdkVKYng2bG1XbkM1UExaL3U1THN3QXV3QTB5bzZKdk0w?=
 =?utf-8?B?TGE0KzJCMjByYm1XR0pTeFR2Q21ObCt0SUNCT2ZnNGdkZldRK1pDZzUvREV1?=
 =?utf-8?B?blIweVAvRjVweFpsdzE0TkVaQUNrcmJ6R1V6ZklLa1BWM1Zya1BOOXo0TkpU?=
 =?utf-8?B?OWFPQlpQdDJSMzhDR1dwMEpTcXVIMFlmdTVnQk8yaXNDOFN0WXUyRm9vTitz?=
 =?utf-8?B?d0wveHIzdExjSkdETkVGS3VQTTV4RVYyS1VqRTFTWEhwS1FKckJlTWt0ODRI?=
 =?utf-8?B?RlNFTDlBYXNLLzJYYmI3ckRBcVk5NlRqdVZuN08rUlZ2UG45TG5OdzNDZ0gv?=
 =?utf-8?B?L05ya09OZzFDSCtYTUxvM0d6dHFCemVzRzVVMWs3YVYxK01wNkR4dWlSYlFU?=
 =?utf-8?B?R0xnSFVqT01SWFBsbzFmMHFRcXZ0cWNXc1VyNlVuQllQZDlnVytwQUdDTmZr?=
 =?utf-8?B?R1M5Y2ErZk84VEJ3TGQ5anl3ZVVTcGZPWDFha0RHMkZtanRVOEV1dDNYQkVw?=
 =?utf-8?B?aFdGUVovRnRkUm9EMGdubzhiMVVqOW1wcy9abm91TkJKUWZEbURqS0p6T3Fl?=
 =?utf-8?B?M2VZRnFBNlprcnBHNDVEUmwrZURFT2EvR21kRTgweHhSYjEyQ01wQmxlSXFr?=
 =?utf-8?B?N0NCMHlMczZSMkErUEN5bDFPSU9VTUhZekljU3d1R3NPckZGb3d4WnFMeEY2?=
 =?utf-8?B?VWl3d2s4Z2V0WEVpZEUvSHR6TDVFZitRZVFCQSs5M0lZV0FUN1dUUjNkSmtK?=
 =?utf-8?B?VVQ1WGxxekFKaTkzcFJCcVFJZ1RObWVPVHZyWWF1czk4QVR3UFBoY2pLUDhY?=
 =?utf-8?B?Tm1LREZUVnpEd1lPOTdKY1VjRFJTN01VMGFNeVBqdHAvVnFCakhyOGErSDRn?=
 =?utf-8?B?VGhLQVhXY0t6UjBQdVlxUWNJd00yM3BqMy9jSzNERmZWVUdEMG5IZVU2YWNB?=
 =?utf-8?B?RXFZV1RNbTduUHAxM2JzODEwYVJhS0JjMFVwNGZsUWhOUkg4MmNhb3Z5eGh6?=
 =?utf-8?B?anpYMEEwcitRRGpNZmVOd2g0dnRtTEhTTmRERmF2Y0V4UUpLNUFWamZGQ09y?=
 =?utf-8?B?bnVJOGFXVGpadGR3dWJUMXdJK1lVdEpic3Fxa0VQT3dUbUhsejNPdFVkS0Fl?=
 =?utf-8?B?SWJhUm5CeFJ1c2lpRzVFNG54R0FmSklidkhoU1lSdjlpY3lBOUllZCtOVFJQ?=
 =?utf-8?B?cVVpVjd1ajV5aVBMSnM2SnoyQW5GRktKcWpmN3FvNUVEWjVTa2hEaTZkUnRt?=
 =?utf-8?B?MEhCMkx2QXdoL3VudWFUQXJ0N3ozcDR1S3VDYXF6clpCTFdEYzFQRnV1UEZi?=
 =?utf-8?B?dUNVQ3Z1NWxTYXFHS3dMYkY1M2JQNHVCeGtMbXR0UmRpVS9DMjVpWlUrZlJt?=
 =?utf-8?B?NTdLUXZmUEI1Rm5GeUNnT2JuVnU0eEtqOFpPYklRRGtLYThaMFY0UlRKSDJ4?=
 =?utf-8?B?TmxhZkdMU3J3TmtpZjFNaHB1RzFpNnpsdjAraldHREhzQ1ZNYzRKNEdMaUpG?=
 =?utf-8?B?amI4SFY0dCtsNjc5Uk0xN0U1Y0diR2pLSTVOZlMvbmM3RmEyVTk5UE5PUy9E?=
 =?utf-8?B?QXJoc3VLdVdrMDlzMGI4KzBxdmNSaGYyaFFvSXZKV3AzWXkycHNubXByRjhy?=
 =?utf-8?B?OUlXUXNzZTVkKzZiRnlaU2lNVmNCUTdtVE5GbHJTY3BSTkU5NDlocjFHYy9W?=
 =?utf-8?B?UXZFdnljWHRLa2hKRVVVd0svVVFiTmg5Qko3SzJXMGNHeVMxUVZDYjlwQzB5?=
 =?utf-8?B?WjdoZlV3MlBXRk4zNlZJNXF0cUhTU294RC8vdG9oVVZlQ1dPNTQ5NEV2aStx?=
 =?utf-8?B?dDNqWjdNKytPcC9kMHlKL3dFTXMrWmwwQXRld1Q2Z29SdGlWVmUyQVdxNndy?=
 =?utf-8?B?bERta3pyMWtxV2hKZ25pZHdnY0tCZnNPckxQTjJ6TjBXU1U4d1pkTWxFb2t1?=
 =?utf-8?B?NnE1WmM1eVFaeTBRK0NvU24xQytNM2ZRTzVRL0xQVm1xSklSdFFvVU1pTnpY?=
 =?utf-8?Q?BFKcuEeStYocEzTnmp07vcbFg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8677.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e91110f0-9579-44a1-1d0d-08daacb442a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 00:45:43.8204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h1FxGrjrmv8+WTdCPopAKkw6FstsqyqA18TZEBPisIAsIHHoM35/GeeSlrs0VgRPIyfJl+V671bianKVvdDB8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6784
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaW0gSGFydmV5IDx0aGFydmV5
QGdhdGV3b3Jrcy5jb20+DQo+IFNlbnQ6IDIwMjLlubQxMOaciDEz5pelIDI6MzENCj4gVG86IEhv
bmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiB2a291bEBrZXJuZWwub3Jn
OyBhLmZhdG91bUBwZW5ndXRyb25peC5kZTsgcC56YWJlbEBwZW5ndXRyb25peC5kZTsNCj4gbC5z
dGFjaEBwZW5ndXRyb25peC5kZTsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbG9yZW56by5waWVyYWxp
c2lAYXJtLmNvbTsNCj4gcm9iaEBrZXJuZWwub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBhbGV4
YW5kZXIuc3RlaW5AZXcudHEtZ3JvdXAuY29tOw0KPiBtYXJleEBkZW54LmRlOyByaWNoYXJkLmxl
aXRuZXJAbGludXguZGV2OyBsaW51eC1waHlAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBu
eHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxMiAwLzRdIEFkZCB0aGUgaU1YOE1QIFBD
SWUgc3VwcG9ydA0KPiANCj4gT24gTW9uLCBPY3QgMTAsIDIwMjIgYXQgMTowNyBBTSBSaWNoYXJk
IFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gQmFzZWQgb24g
dGhlIDYuMC1yYzEgb2YgdGhlIHBjaS9uZXh0IGJyYW5jaC4NCj4gPiBUaGlzIHNlcmllcyBhZGRz
IHRoZSBpLk1YOE1QIFBDSWUgc3VwcG9ydCBhbmQgdGVzdGVkIG9uIGkuTVg4TVAgRVZLDQo+ID4g
Ym9hcmQgd2hlbiBvbmUgUENJZSBOVk1FIGRldmljZSBpcyB1c2VkLg0KPiA+DQo+IA0KPiBSaWNo
YXJkLA0KPiANCj4gVGhpcyBubyBsb25nZXIgYXBwbGllcyB0byBwY2kvbmV4dCAocGNpLXY2LjEt
Y2hhbmdlcykgYW5kIG5lZWRzIHRvIGJlIHJlYmFzZWQuDQo+IEl0IGRvZXMgYXBwbHkgb24gdG9w
IG9mIDYuMC1yYzEgYnV0IHRoZW4gdGhlIHBhdGNoZXMgdG8gcGNpLWlteDYuYyBhbmQNCj4gaW14
OG1wLmR0c2kgYXJlIG1pc3Npbmcgc28gSSdtIG5vdCBzdXJlIHdoZXJlIHRvIHRyeSB0byBiYXNl
IHRoaXMgb2ZmIG9mLg0KPiANCj4gRG8geW91IGhhdmUgYSByZXBvIGZvciB0ZXN0aW5nIGFuZCBo
YXZlIHlvdSBiZWVuIGFibGUgdG8gdGVzdCBhIEdlbjMgbGluayB3aXRoDQo+IEExIHNpbGljb24g
eWV0Pw0KPiANCkhpIFRpbToNClRoYW5rcyBmb3IgeW91ciBjb25jZXJucy4NClllcywgSSB1c2Vk
IG9uZSBOVk1FIGRldmljZSB0byB0ZXN0IHRoZSBHZW4zIGxpbmsgb24gaS5NWDhNUChBMSkgRVZL
IGJvYXJkLg0KT2theSwgSSB3b3VsZCByZXNlbmQgdGhpcyB2ZXJzaW9uIGFmdGVyIHJlYmFzZSB0
byBwY2ktdjYuMS1jaGFuZ2VzLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gQmVz
dCBSZWdhcmRzLA0KPiANCj4gVGltDQo=
