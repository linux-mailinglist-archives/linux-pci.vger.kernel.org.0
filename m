Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7752D700A95
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 16:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241197AbjELOpS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 May 2023 10:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241266AbjELOpQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2023 10:45:16 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2071.outbound.protection.outlook.com [40.107.8.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BF82682;
        Fri, 12 May 2023 07:45:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXL6AAiDO3PcAx8P1yJkYwd8k6L6dJSvu8pvgSy2f+7RslyiN0Y6TrQqg3pxoucQpR3AZ2mbeWKwgxifsFH1e8D5NLmJmN51wa6dcwWe+91U6Dgr067g1E1XE2q4qH/ttyoeWymPNVhFVAJQ9h60DtPl3WgdsadbK14AASzyT1tHvCoxIJHz7579JDgilcGW7nly/oeA8EtCMkyiQvErraQxkOYdaseItiuCbmxp0IbzfTsCc84Mv5ozlvYxGNoOeKkcr++5toulm+XTOxYsFUynCDoQOX6JjsCiacpXgLV+d0U+/gSWzCLVQeGnidP71SzyVqb9gU+SSqGD28Fm0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0H3fp5UxmiwFZzvNTi1IlSyMacAQVGtWPHTbpmTS5w=;
 b=COqd9whjR8dXLRxuuRs1VsxS0s46EvrSApAh8D75W42GbabhPQjNtw/N/cZoV+3QkUma8ktTvTHEiXee8jU6yC72hS3iUZtqTWme9fUoA7VkHYu+3VwbMKfMqZQBMZLFWxF+tlsG+aiD6PEZVtbwN5epYijqrXPvrFPT+o7rfTFI5gxrZEQnS4woFkFbyqX3RQI4/I0mLPbUgzu8Np9mQ5yvZIVlFML6ovfqaV9ge8ZaYyzRFH+Fd8refe60LnARshW+zpwZvJHiqgLB7pN/aff7JqpNPWwht40bXhAM9iTHfQASWk+Cd30wIURZX63kn5C/25SRHdOEjQzoeVFlQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0H3fp5UxmiwFZzvNTi1IlSyMacAQVGtWPHTbpmTS5w=;
 b=dkWtGDvjY+nFHLn6Wb0DbOYN0FwVew+4kpWIuPzep5DDs+iG9VKoGMD5S7loYYgHW6CS78acYhqGYikTlgYJceBYSKlB4py7O0XVYOXFosFI+sY4huhMdPRVYEI/K/kOslmEwy6htDD1Zl5ETBeqxxqW80m6YEZJOL3l/3izKCU=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8478.eurprd04.prod.outlook.com (2603:10a6:10:2c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.23; Fri, 12 May
 2023 14:45:12 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6387.023; Fri, 12 May 2023
 14:45:12 +0000
From:   Frank Li <frank.li@nxp.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "kishon@ti.com" <kishon@ti.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>, "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [PATCH 0/3] Add RC-to-EP doorbell with platform MSI controller
Thread-Topic: [PATCH 0/3] Add RC-to-EP doorbell with platform MSI controller
Thread-Index: AQHZeH6QDUNIo7Q7Q0irLpjqcbPLYK9Wz2Mg
Date:   Fri, 12 May 2023 14:45:12 +0000
Message-ID: <AM6PR04MB483849BE4788EE893306F38E88759@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230426203436.1277307-1-Frank.Li@nxp.com>
In-Reply-To: <20230426203436.1277307-1-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|DB9PR04MB8478:EE_
x-ms-office365-filtering-correlation-id: 10df28e9-ce4a-42d3-b8ab-08db52f77daa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v5OIEk9pRiR3DgKUpOhH0Ub05fQZ5wX20aci/r0e2NmUMxyrp2ExN/NizSG0PgwdYu4g/9EXLK9wtKD87dxtFFj301JZujkrISN++K+Raui/PJsmEX6r3F6f2b4jqrNfOoKXz/gNHs2iHDt2ligWvRJW5z4CLIWBsIyNJ26wvweMEWwLfJT55/Tfu/YRhQY2DYZTvTXTOgJtx+toMnp4ySAAvejec0MADQe3CN7HWHrcR7sSp4hl0gtGLl6qR+HcWx6EMqeyqSECMfvw3INszTDUSd4J4rnjR72b4DQ458XvObqT7mNRFJ8Duyd6YQwOB1aXnoW/zcuGJ8bBqoJ+yU7nOn8yhy1O7KW2hHL15pxO4d3WzpRMXJrbV3U21dXmmWZdJ+3dQeK3CLEglRuIqQ4kYnj8aec9GvL9l6ZtcEClwrqvaMkAIp/UrvgPG/8pW9QtSRnzMpRq/WZW476JHPDqNwc29ukGp2KnRCSyyk7EgQ+T15McMMvRqjOr2R4Bf2Gth995UUAOHYItBGNiDcp0LXuSyVKhhKnQW7r4CVy2XghiMsnLvq9QfSnoNBD4ZfwyhM8W/aQxJQCVuDzD6OstH72wLurAt2iouUh5STZvxyH2sEsj82uesFpQWQWj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199021)(54906003)(26005)(55236004)(186003)(6506007)(9686003)(110136005)(478600001)(38100700002)(7696005)(55016003)(122000001)(71200400001)(4744005)(2906002)(52536014)(8676002)(7416002)(8936002)(5660300002)(38070700005)(44832011)(41300700001)(66946007)(76116006)(33656002)(66556008)(66446008)(66476007)(64756008)(83380400001)(4326008)(86362001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cE5Eb2RDQlZNSzRHWExEdGE4NnBta2lTRzRNWWRKM3FxZUEwbzZHTDR3UVJZ?=
 =?utf-8?B?Z1BGeEw0Sm1qU1N0cysvUElrU2xCREV6ejA2eE45UnFlS0lYS09Nd0lpU0tZ?=
 =?utf-8?B?bEkvbFZJTHR2MkhZZEk1SWM1WTVpeFAzQURMekQ1emFqc3VZWTdkb3k5b0Rl?=
 =?utf-8?B?VkRObVBXam1vbGpQeGxOdUxVVEtQU0c3aGU0YnZSR1hkYWVGRVNTS0lZUzJ6?=
 =?utf-8?B?TjcrVnhkdmkvM3VyM0s4NzhKaFFVM3M2dm9XTllOQlRaN0RWVFFyOWlkeUFn?=
 =?utf-8?B?NnBxNkQwdTB3MmxoVGJWdWtPTDhieUN0ZWtkL1p1U3l1Z2RKWUtGU1pDMDkx?=
 =?utf-8?B?blJMSEpENG5TU21wemNudndiTWpNNVZ4aFQ4ejUxUER1emJCQTgySGVUWFEw?=
 =?utf-8?B?ZXdZU1E2UDA5KzByYnArQUNzc1ZWckxCc0s1N1RaUHk1OENlTS9Ob1hBZ1Vt?=
 =?utf-8?B?MHFpMTFJSGlpMURaQzgyajJCOUZPWU53bWExQVFORTdPaVBodHNFNWdNbG1p?=
 =?utf-8?B?YmNkeTVzcy83ejFxeXBmeVVxZ05iVzhQaGgzWFM4L3FVOHRNRjZwbWxjOUZa?=
 =?utf-8?B?WFY5akJ4MnZHc1RjdkNTbDh4bmJNaC96VmRhVE8zRG1BdlNJcHZ0RC81dHJn?=
 =?utf-8?B?T0hMVlozUmVuTVBFVmtEK05SZ2tHMXNxNHZJRGdWMnRrc2NTdmNjcm53dUxL?=
 =?utf-8?B?SlR0anlLZUx2SVRKU0RGdGtwRGh1dzF4Tm8vRXJaY2VIRC80WFNrcSs3Y1I4?=
 =?utf-8?B?QjlheEF4elloYk9nWVcvcVFTMjBnRGpVMEEwUGVnVW1xODBWTTZTRUR6dHdF?=
 =?utf-8?B?SC9rOW5CakNRdXZjbk1UTWlaRWwzSUJ0NzhPYzR2amNNUE8rcUplMUNaaEFs?=
 =?utf-8?B?aFJWYkt0cXRhV2ZPVll0QldtNnRlSFFISjFaY1ZYTFduSjB5amNkdURkbkxB?=
 =?utf-8?B?bXNhY1htMUVSTGlVZ1FGZWt1d050SjlTNGo4U1hWZlArYTF1djZoZmVvNlNy?=
 =?utf-8?B?RDZGL2VDcWFjOURvNENXY25xL3NZR3ZzckRaVmdhblhzQ0ViYmYwcmdUSHlJ?=
 =?utf-8?B?SkVyWm55UEQ1WG42ZCtPOVNscUt5TThseXYvdlpjUUhPSVh1ZGcxSDN0NHRQ?=
 =?utf-8?B?WHZ0S2plSkpzd010MHZSZ3NnTnY0RjdWbnR1cGw3SSt6ZlREcWdlbG9GSTZN?=
 =?utf-8?B?SmF3MXhGWXBQYldVUGxEMS9ZUkFMcCtvcEV4N2UvT1VUMWtMUDBDSlcwNU02?=
 =?utf-8?B?akpYMUZ1NDFaSFBHdTFKa1dUZlZkWEtENkx6bUlFTmdOaVlnbWNEWkNoMmpF?=
 =?utf-8?B?RUdieDN0bEtxREV5QjRYbThGdjRMMUljSkhKZVl3OFBZVnhib2lud1doSDBF?=
 =?utf-8?B?NGtjTU1HSjl6cithSStJRm9YVkM1VHplTUJlNXRtYXBTVmhFSFgwK2RVb0wz?=
 =?utf-8?B?SkFxeUYyZm5GdEg1Q25FVnl4UURyV1dGRnZOL2RPVW16V0VRU3lpSkduSlpC?=
 =?utf-8?B?eVZkMWx2ekwwMk5zbTF2bGROUFJLeDNQdlN6STNodFU5NERjQ1ZlaHM2Sm1w?=
 =?utf-8?B?dFo3eHU4SFIvRmhDWm1HUzhabU1jblA3Vkh1ZEtlbTFHUzZuRGpWUWJESS9G?=
 =?utf-8?B?SGxqYUsxVWhucVk3dVZJUzU0VU1MK3pBRTVtS3VVTEZSbGR6aHdzdk9iQ281?=
 =?utf-8?B?a3Z2N0tlWDcxbXZBakxydk9TZ2szOGE4a0orV292Lzc0WWhtUy9JMjgvNGxK?=
 =?utf-8?B?dG5mdE92c2hCV0xlQjJybjhGQ0wxNkRaTi9ZS0laN1ovNzNvbjEzUzNDMGls?=
 =?utf-8?B?cXpmalFmSDU1WnlhdHZHd0kwRDJUZnUxY2ZQbXY5Q21LN0ZJamhPbVd2TTgz?=
 =?utf-8?B?anR6RzhZaWJocUUvZkdWbDRrdWkwRVhSaXl0V1R6YS91NUFJZnpuelkzSUlK?=
 =?utf-8?B?NnlrS1hKMFMxRGZqWXRzbk56bHk3NnlQREVwUlNWU2g1Nm9mdk9UdmYrcTdw?=
 =?utf-8?B?NnRIM2ZEUFg1ZmxxeG15QUNGNVVaenZkaDJmNFdsalRic2hWdGdINHZSZ1NR?=
 =?utf-8?B?TmtzbkRJS2JDTlkwRkhMNFdCRmR0TWFFSVdKbjdNa253TXVsUFlNMjZUM0N6?=
 =?utf-8?Q?bw2o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10df28e9-ce4a-42d3-b8ab-08db52f77daa
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 14:45:12.1287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0lH0Lmm1ou+qNd0SwDmOjMSdLV2HlvQuGBBtOENPHpzAGvEgbvl6qUbtTpXHmtHnCel54bwLpjqGMecH8kFtog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8478
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiANCj4gVGhpcyBwYXRjaGVzIGFkZCBuZXcgQVBJIHRvIHBjaS1lcGYtY29yZSwgc28gYW55IEVQ
IGRyaXZlciBjYW4gdXNlIGl0Lg0KPiANCj4gVGhlIGtleSBwb2ludCBpcyBjb21tZW50cyBmcm9t
IFRob21hcyBHbGVpeG5lciwgd2hvIHN1Z2dlc3QgdXNlIG5ldw0KPiBQQ0kvSU1TLiBCdXQgYXJt
IHBsYXRmb3JtIGNoYW5nZSBzdGlsbCBub3QgYmUgbWVyZ2VkIHlldC4NCj4gDQo+IGdpdDovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90Z2x4L2RldmVsLmdpdCBkZXZt
c2ktdjItYXJtDQo+IA0KPiBTbyBJIHN0aWxsIHVzZSBleGlzdGVkIG1ldGhvZCBpbXBsZW1lbnQg
UkMgdG8gRVAgZG9vcmJlbGwuDQo+IA0KPiBJZiBUaG9tYXMgR2xlaXhuZXIgd2FudCB0byBjb250
aW51ZSB3b3JrIG9uIGRldm1zaS12Mi1hcm0sIEkgY2FuIGhlbHAgdGVzdA0KPiBhbmQgdXBkYXRl
IHRoaXMgcGF0Y2guDQo+IA0KDQpQaW5nPw0KDQo+IEZyYW5rIExpICgzKToNCj4gICBQQ0k6IGVu
ZHBvaW50OiBBZGQgUkMtdG8tRVAgZG9vcmJlbGwgc3VwcG9ydCB1c2luZyBwbGF0Zm9ybSBNU0kN
Cj4gICAgIGNvbnRyb2xsZXINCj4gICBtaXNjOiBwY2lfZW5kcG9pbnRfdGVzdDogQWRkIGRvb3Ji
ZWxsIHRlc3QgY2FzZQ0KPiAgIHRvb2xzOiBQQ0k6IEFkZCAnQicgb3B0aW9uIGZvciB0ZXN0IGRv
b3JiZWxsDQo+IA0KPiAgZHJpdmVycy9taXNjL3BjaV9lbmRwb2ludF90ZXN0LmMgICAgfCAgNDEg
KysrKysrKysrKysNCj4gIGRyaXZlcnMvcGNpL2VuZHBvaW50L3BjaS1lcGYtY29yZS5jIHwgMTA5
DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIGluY2x1ZGUvbGludXgvcGNpLWVw
Zi5oICAgICAgICAgICAgIHwgIDE2ICsrKysNCj4gIGluY2x1ZGUvdWFwaS9saW51eC9wY2l0ZXN0
LmggICAgICAgIHwgICAxICsNCj4gIHRvb2xzL3BjaS9wY2l0ZXN0LmMgICAgICAgICAgICAgICAg
IHwgIDE2ICsrKy0NCj4gIDUgZmlsZXMgY2hhbmdlZCwgMTgyIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gDQo+IC0tDQo+IDIuMzQuMQ0KDQo=
