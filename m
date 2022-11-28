Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C601C63B423
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 22:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbiK1VZ0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Nov 2022 16:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiK1VZZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Nov 2022 16:25:25 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2084.outbound.protection.outlook.com [40.107.14.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E3E21E33;
        Mon, 28 Nov 2022 13:25:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+vOFWmesUbPbpnSXlKJ7jhUkLcDsR5rWfdZgiU5b/QRXh+UUwXo8he64BTExZdpFuDvZ7koqjKgVqiFJPA45UZ4dgov4FV4oDk/6Ab5arDexgmiCWWrpA2Bhu2ZKpu0co7RjfEHbuzjTmRmz7CgxkGvUDwq5Enj1by0pXfFYWcua2cnnPjxs521Mzsy4itBrJtEL7BZOdMGjsLDkpRnJW6Eo4BT4J/u6o3+/EuvbOq3m6UkMHhjqF7XK/R8kMspg/qG+MAbcwYrbPoZljFImY222H0thIqNVOpPaNF/oCZuxL9cDZ8Z/A7O2R8UuXSYgWES9FjZiFY1KNgQ8BDCCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9a7u1jqHkbS8mzfA8ECa8TIgmPafk6p1zuqMlM0pVk=;
 b=aJH4RMFaTjMXtRzLVxg+b/Gg5s9mkoiASEaONPL+FNkjS9aBZhhCRR+X9xJITZJsbAAZK8UtpdTtf3xjsIRKMpWnqotO/5+7TepVfggokFg2vRG8geDdoaHq0zAI8wFk3dXf6oi8a4wjuse4VbUrZgiviEAkYvhKcgzhBxjYxRAauv7bkssiKKa2+HaUkGKJrKJ4lNv9Xk0ZJUAzFoDHyDAMbpmqBiVatwq5dsPYzv8iEFWOcfdErEAewGOiEXg/O89AmgW9s8rgvmru000dbeQLUxHXtrFdvc3S9/rJeO0zrZv/aXiDHqVieSIivpjJlNjvoBrO3DNURF1a4TcCeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9a7u1jqHkbS8mzfA8ECa8TIgmPafk6p1zuqMlM0pVk=;
 b=fK5lyZrPhkmPfyLm+i6U+In1YhJyTFshiZT0XNere2uczf+SOd4WEZGHxHLDa6t1Y/VicU1MqqzstVDwdpvk4s4kgqbm6JfPT5hXEZRZFZcFw04CvUX2uuTe4taApCWcGqjyjCO1cp1rCNu/Ds8bSjzkoqVzadqtJ5TBTR17tu0=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by PA4PR04MB9438.eurprd04.prod.outlook.com (2603:10a6:102:2aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 21:25:20 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::203a:e5da:a4a:7663]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::203a:e5da:a4a:7663%12]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 21:25:19 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>
CC:     Aisheng Dong <aisheng.dong@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
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
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "lznuaa@gmail.com" <lznuaa@gmail.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [EXT] Re: [PATCH v13 2/2] PCI: endpoint: pci-epf-vntb: using
 platform MSI as doorbell
Thread-Topic: [EXT] Re: [PATCH v13 2/2] PCI: endpoint: pci-epf-vntb: using
 platform MSI as doorbell
Thread-Index: AQHY/8jEGxDCgJFzq061wXktOCH4pq5Uu8YAgAAaTfA=
Date:   Mon, 28 Nov 2022 21:25:19 +0000
Message-ID: <HE1PR0401MB2331DA6C4A52272B08E1661D88139@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20221124055036.1630573-1-Frank.Li@nxp.com>
 <20221124055036.1630573-3-Frank.Li@nxp.com> <87wn7evql7.ffs@tglx>
In-Reply-To: <87wn7evql7.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|PA4PR04MB9438:EE_
x-ms-office365-filtering-correlation-id: 31ca267b-9689-482d-f595-08dad1870ccd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kaCefSbhmzziNKaq0hmGlKaY8rO7w1U0EMEf0nqsZoL3XIW2OTeyqcWaFrKFYDRtkIoOCcAvSUqL2HFJbraYMGU32LfdoIQSlwqOpccrPMIcknwTYEEeCYEiCkPuyShIcNyxCyGllLgQES/ysEGj8VNg3NYjWK6KWfuPVg6LVM9+l+zEOBrigKdU4Y49Bz4Q2bTk73n8ybdgUootF0PS2EWlHiUb6BWfJfJ92z312TfcX7XsgFbdJAuXL7zSWdbGP1JeeSY5yIl5eOiMlAfdUpSjVjc8kWxfpnrhGk1AXb0k4T5RySpankV6Wb3KJC/Mb9zyvxyDJ9ZVKb5HYA1egatDPw1of/fElBZCGGV+Q4pjgPPOSmoy6Ljg1dE6DUhCJUhSj7h7GSX+F+fZiw8RRwmdJ8Q5dwXrdQOoLwrFWRP37onGo2/xOQe+lJGFclzGB0/NGBN3vsCcNrORPx+wtRvm1FMOtEcDqIzqjKElGfqmdlwGXW1k7HcldVg/pAuTrtO7OWA7IQiqtg8t8Xwx7CO7Qnd82XK79rMHnd9WZXdkifDo6+BEg70vsTYMTTHnISWXFDGTw18PzSxVysN+NhKfVFNWfmHBJAhvKdw402J7bm25g8/nWd+ps4IkF9X6AzHzICRBLm2Sq2LGbLuoCin5XJ60dPdqFmDxV2gD1bosPlZUsQjS7wKp+DXSXVnMF6OTE+fiimRuoSflR+RuBVn8Jug1VMFIzgz69omBeObxzYvLRDiPs0hoaP6ui+NRFLB0AEWhRedd2drg/Q8Nyq2ZAVpolLkI90oQ/+yT9Ig=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199015)(55236004)(53546011)(2906002)(186003)(966005)(26005)(9686003)(478600001)(6506007)(7696005)(45080400002)(71200400001)(122000001)(38100700002)(86362001)(38070700005)(55016003)(33656002)(83380400001)(41300700001)(52536014)(44832011)(66446008)(66476007)(66556008)(8676002)(64756008)(66946007)(4326008)(7416002)(8936002)(5660300002)(76116006)(316002)(54906003)(110136005)(98474003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDFmcFhXNnpyaEo4cDkwc20zdERtb1RVL0JiR3NMZWh3YVhXczNwZFNmR0ha?=
 =?utf-8?B?SzZTS3V6TFphK0JJbzdiNFBIcVhaZlczL2w3RGhhbXR2NkhxWnVHR2pRbjNp?=
 =?utf-8?B?WlJ5RTRDdHQ0dHR6Z1pBUE40Y3UzTElMZjN0dkdDNlU5Q2NhQ0JXdjRmQW42?=
 =?utf-8?B?QWgvWW52K0dydHZJdUN1ZTAzZERLUGc1MVRXc3JxRXEvVldGanVXVXlPYW1i?=
 =?utf-8?B?MTZmS1ptMlRjOWhrZjUvUUxRYXl0Yk14a3VmUHpGaUszZkl0NWxWUzZrUU1O?=
 =?utf-8?B?VnVFUUkrS3ZzZTdXWm9JY1RFaG5yNExRM2FRcjJnT0JHdU9OVDNvQ040ODdz?=
 =?utf-8?B?eGJ5aEgxb1F0cmxvR0hFdEY3VC9RYzdXTE1oRi9zRlBkTVpUSWplQWUvMjNK?=
 =?utf-8?B?ajlkWjgzaElYN3cvZWZUdnppNmFIR3FVT29KUzBieEpQT0N4Y3dtc0RUc0Rv?=
 =?utf-8?B?QW5YelZibUZYalJrdktTS09XU2NTZGtTSitMeEF2dGNvM0pXdTljRVEzc0VS?=
 =?utf-8?B?M3NCS0xncGtvOWpMNitqU2JETTFWTUdPeFB5RklSL1VkbFZxZHJQUjZtb01G?=
 =?utf-8?B?TmpVSStzK1I4ZGJPV0pIeU1Sejh6Tlk1UlBvWjFUSGNhbmNXcTIrVmttaksw?=
 =?utf-8?B?M0E0aDB1aTE0QzJ2WFI2R0NUNVJDU0xQRzZkOHEwVDdzK2s2ZUVnQk5MbTZx?=
 =?utf-8?B?TWFnSnFmWnhCbUMyc25ZY1lZRUxnVWpyeEU1ZE1UbE0xVklack1HOXAraDIy?=
 =?utf-8?B?a21ISkFnNjQ3OU85a2tQZ2FBMlhLMjFVdEswdUg5ekZwelNmU3p0WExWdmls?=
 =?utf-8?B?RlczbFpmRnc2dVlQNDJvZnNYV1BrcHBtYm0vdjFDWnFJeVVYMzd4OFhIMEJi?=
 =?utf-8?B?N2tnWmprcUNmVFVwQUJuMjRJdk9vMS9LYUhEeDlkWko2cXk2U05BNFBRWVQy?=
 =?utf-8?B?K29UNXFjc0w5cDUxSzN6TlliUlN4cUNCMFlhcEpzdk1jbmJ6NWtwVWV4R1Fj?=
 =?utf-8?B?RVJJKzB4aWNjNklHSlhUNzRRbE5kMGpScy8rblRBK1JBQnJBcDJOUk4zV3JD?=
 =?utf-8?B?YjZSU0FISVpVa1N6LzNzRDExQUowVDR2VW1TcjBvM2owV2ZXMlZGU0lZL0VV?=
 =?utf-8?B?U1NLTzRUdjJkS1BEMkFualBDdE01NUx5QnB0ak45a3RFYXRrazNnWW1nUW81?=
 =?utf-8?B?amJncVRvckx6UGpOWkliaGZlbVNrU2o2YUhMb255cnFDQmxBNktaVFgvZFBW?=
 =?utf-8?B?QWE4MTNsMnJBTmN5RzFmcjVZVEVyWjhlUjFrV0tpVE04aGVKMS8vclRoV2lt?=
 =?utf-8?B?ZUo4N0pydk5tL1RPbmJUTE1KUm9RalhxLythOFdtdk4va01semlveEY4aW4v?=
 =?utf-8?B?MmIwOGlkTnBBbTZ5dTUxVHJvVkkzdmZHcmx3WVJZS080aHF6WmI2NzE3RmpE?=
 =?utf-8?B?UEhobzRPTEUraFNVN0pnZnRiUEpOT3kveW1yRnFlRlljTjdzZnF0aHRiaDJF?=
 =?utf-8?B?K3N4MDgxd2NJOHlCY3poM09LRDNJbUxSYURuTDZzeVFHWUFTWUN5MVNtTGpz?=
 =?utf-8?B?ZjRlV2VZUHpyZWxGdjNKZkx4RVpmMDl5WWpTSVFTaURUVGV4QmZzTjE2NkVV?=
 =?utf-8?B?TE1kN0tkMnhGc3VFMGQ2eThaaytvU1hPNTZ5NnN1OGN6TWM4TkN2QTFhVW1Z?=
 =?utf-8?B?RHVyTnpiL2lxOWZZSGwrVlJrYnRXZnZuUWYrRWdHQ3IzSkhjakRwbzI2YWVv?=
 =?utf-8?B?T05oeHptR0dIeFk0STA4TlBLUVY0cE5OK2xGb3ZDV0p2MmlLK1RKaU1hd3A5?=
 =?utf-8?B?UGZ3RlpBUm9vNDJ5UStKbWk2MzFOL0ZnTlZxUFYwcm5EZEppVVRqU0RaRkVM?=
 =?utf-8?B?NmJ6S1MySzBUaWszWk8zRDRVaXZld3A1SVBiL0pVNUdVVGEzZk9TUjFHWVpy?=
 =?utf-8?B?Mk0vY1VvZ2lyVFN3Mi9DcnZZK3BHVE9wWFZ5Wk0yWE9DT095d0djNTJtK3Fh?=
 =?utf-8?B?bU1sMXRvN1MxL3BrQnNoaC9DbXRPUTR6bHJ2ZFVRcmdJemtVb0RCcElMWnpQ?=
 =?utf-8?B?RnMyT1lXVE50cldUNnh5MUs1WXBJbjNHWlZ0TFllbmNaWEJOd0pMNXRIWU5j?=
 =?utf-8?Q?5crI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ca267b-9689-482d-f595-08dad1870ccd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 21:25:19.1648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dyJ2ngmW9Uil8HR6fFEqIJoXIns/1lOyUH7JmUqJgf8UGVwMVdswHAtS+QFWMv0Gpm+LVkNSF0HbBLMYPDGm9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9438
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGhvbWFzIEdsZWl4bmVy
IDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMjgsIDIwMjIg
MToxNSBQTQ0KPiBUbzogRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBscGllcmFsaXNpQGtl
cm5lbC5vcmcNCj4gQ2M6IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsgQWlzaGVuZyBEb25n
IDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47DQo+IGJoZWxnYWFzQGdvb2dsZS5jb207IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+IGlteEBsaXN0cy5saW51
eC5kZXY7IGpkbWFzb25Aa3VkenUudXM7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4ga2lzaG9u
QHRpLmNvbTsga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOyBrd0BsaW51eC5jb207
IGxpbnV4LQ0KPiBhcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGRsLWxpbnV4LWlteCA8
bGludXgtaW14QG54cC5jb20+OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgbHpu
dWFhQGdtYWlsLmNvbTsNCj4gbWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc7IG1hekBr
ZXJuZWwub3JnOyBudGJAbGlzdHMubGludXguZGV2Ow0KPiBQZW5nIEZhbiA8cGVuZy5mYW5Abnhw
LmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsgc2hh
d25ndW9Aa2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHYxMyAyLzJdIFBD
STogZW5kcG9pbnQ6IHBjaS1lcGYtdm50YjogdXNpbmcgcGxhdGZvcm0NCj4gTVNJIGFzIGRvb3Ji
ZWxsDQo+IA0KPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gDQo+IE9uIFRodSwgTm92IDI0IDIwMjIg
YXQgMDA6NTAsIEZyYW5rIExpIHdyb3RlOg0KPiA+IOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUkCAgIOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgA0KPiDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilJAgICDilIzilIDilIDilIDilIDilIDilIDilIDilIDilIANCj4g
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQDQo+ID4g4pSCICAgICAgICAgICAg4pSCICAg4pSCICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICDilIIgICDilIIgICAgICAgICAgICAgICAg
4pSCDQo+ID4g4pSCICAgICAgICAgICAg4pSCICAg4pSCIFBDSSBFbmRwb2ludCAgICAgICAgICAg
ICAgICAgICAgICDilIIgICDilIIgUENJIEhvc3QgICAgICAg4pSCDQo+ID4g4pSCICAgICAgICAg
ICAg4pSCICAg4pSCICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICDilIIgICDilIIg
ICAgICAgICAgICAgICAg4pSCDQo+ID4g4pSCICAgICAgICAgICAg4pSC4peE4pSA4pSA4pSkIDEu
cGxhdGZvcm1fbXNpX2RvbWFpbl9hbGxvY19pcnFzKCnilIIgICDilIINCj4g4pSCDQo+ID4g4pSC
ICAgICAgICAgICAg4pSCICAg4pSCICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICDi
lIIgICDilIIgICAgICAgICAgICAgICAg4pSCDQo+ID4g4pSCIE1TSSAgICAgICAg4pSc4pSA4pSA
4pa64pSCIDIud3JpdGVfbXNpX21zZygpICAgICAgICAgICAgICAgICDilJzilIDilIDilrrilJzi
lIBCQVI8bj4NCj4g4pSCDQo+ID4g4pSCIENvbnRyb2xsZXIg4pSCICAg4pSCICAgdXBkYXRlIGRv
b3JiZWxsIHJlZ2lzdGVyIGFkZHJlc3PilIIgICDilIIgICAgICAgICAgICAgICAg4pSCDQo+ID4g
4pSCICAgICAgICAgICAg4pSCICAg4pSCICAgZm9yIEJBUiAgICAgICAgICAgICAgICAgICAgICAg
ICDilIIgICDilIIgICAgICAgICAgICAgICAg4pSCDQo+ID4g4pSCICAgICAgICAgICAg4pSCICAg
4pSCICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICDilIIgICDilIIgMy4gV3JpdGUg
QkFSPG4+4pSCDQo+ID4g4pSCICAgICAgICAgICAg4pSC4peE4pSA4pSA4pS84pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSADQo+
IOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUvOKUgOKUgOKUgOKUpCAg
ICAgICAgICAgICAgICDilIINCj4gPiDilIIgICAgICAgICAgICDilIIgICDilIIgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIOKUgiAgIOKUgiAgICAgICAgICAgICAgICDilIINCj4g
PiDilIIgICAgICAgICAgICDilJzilIDilIDilrrilIIgNC5JcnEgSGFuZGxlICAgICAgICAgICAg
ICAgICAgICAgIOKUgiAgIOKUgiAgICAgICAgICAgICAgICDilIINCj4gPiDilIIgICAgICAgICAg
ICDilIIgICDilIIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIOKUgiAgIOKUgiAg
ICAgICAgICAgICAgICDilIINCj4gPiDilIIgICAgICAgICAgICDilIIgICDilIIgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIOKUgiAgIOKUgiAgICAgICAgICAgICAgICDilIINCj4g
PiDilJTilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilJggICDilJTilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIANCj4g4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSYICAg4pSU4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSADQo+IOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUmA0KPiA+
DQo+ID4gVXNpbmcgcGxhdGZvcm0gTVNJIGludGVycnVwdCBjb250cm9sbGVyIGFzIGVuZHBvaW50
KEVQKSdzIGRvb3JiZWxsLg0KPiANCj4gQ2FuIHlvdSBwbGVhc2UgZXhwbGFpbiB3aGF0IHRoZSBN
U0kgY29udHJvbGxlciBpcyBpbiB0aGlzIHBpY3R1cmU/IE1TSQ0KPiBjb250cm9sbGVyIGlzIG5v
dCBhIHRlcm0gd2hpY2ggaXMgY29tbW9uIGluIHRoZSBpbnRlcnJ1cHQgaGFuZGxpbmcNCj4gbGFu
ZHNjYXBlIGRlc3BpdGUgdGhlIGZhY3QgdGhhdCBpdCdzIHByZXR0eSB3aWRlIHNwcmVhZCBpbiBk
ZXZpY2UgdHJlZQ0KPiBiaW5kaW5ncyBwcmVzdW1hYmx5IHRocm91Z2ggaW50ZW5zaXZlIGNvcHkg
JiBwYXN0YSBjYXJnbyBjdWx0Lg0KDQpJIHVzZSBpcnEtaW14LW11LW1zaSB0byBkbyB0ZXN0LiBJ
IHN1cHBvc2VkIGl0IHNob3VsZCB3b3JrIGZvciBhbGwga2luZHMNCmdlbmVyYWwgbXNpIGNvbnRy
b2xsZXIuICBEVFMgcGFydCBzdGlsbCBub3QgdXBzdHJlYW0geWV0IGJlY2F1c2UgUENJIEVQDQpl
bmFibGUgcGF0Y2hlcyBzdGlsbCBiZSB1bmRlciByZXZpZXcuIA0KaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzE2NjM5MTMyMjAtOTUyMy0xLWdpdC1zZW5kLWVtYWlsLWhvbmd4aW5nLnpodUBu
eHAuY29tLw0KDQpPdXIgdGVzdCBwbGF0Zm9ybSBoYXZlIG5vdCBHSUMgSVRTIHN1cHBvcnRlZCB5
ZXQuIA0KDQo+IA0KPiA+IEJhc2ljIHdvcmtpbmcgZm9sbG93IGFzDQo+ID4gMS4gRVAgZnVuY3Rp
b24gZHJpdmVyIGNhbGwgcGxhdGZvcm1fbXNpX2RvbWFpbl9hbGxvY19pcnFzKCkgYWxsb2MgYQ0K
PiA+IE1TSSBpcnEgZnJvbSBNU0kgY29udHJvbGxlciB3aXRoIGNhbGwgYmFjayBmdW5jdGlvbiB3
cml0ZV9tc2lfbXNnKCk7DQo+ID4gMi4gd3JpdGVfbXNnX21zZyB3aWxsIGNvbmZpZyBCQVIgYW5k
IG1hcCB0byBhZGRyZXNzIGRlZmluZWQgaW4gbXNpX21zZzsNCj4gPiAzLiBIb3N0IHNpZGUgdHJp
Z2dlciBhbiBJUlEgYXQgRW5kcG9pbnQgYnkgd3JpdGUgdG8gQkFSIHJlZ2lvbi4NCj4gDQo+IFlv
dSdyZSBleHBsYWluaW5nIHdoYXQgdGhlIGNvZGUgZG9lcywgYnV0IGZhaWwgdG8gZXhwbGFpbiB0
aGUgdW5kZXJseWluZw0KPiBtZWNoYW5pc21zLg0KPiANCj4gUGxhdGZvcm0gTVNJIGlzIGRlZmlu
aXRlbHkgdGhlIHdyb25nIG1lY2hhbmlzbSBoZXJlLiBXaHk/DQoNClRoaXMgcGF0Y2ggdXNlIFBs
YXRmb3JtIE1TSS4gIEkgbmV2ZXIgc2FpZCAiIFBsYXRmb3JtIE1TSSBpcyBkZWZpbml0ZWx5IHRo
ZSB3cm9uZyBtZWNoYW5pc20gaGVyZSIuDQoNCkJhc2UgbG9naWMgaXMgdGhhdCwgZ2V0IG1zaSBj
b250cm9sbGVyJ3MgbWVzc2FnZSBhZGRyZXNzIGJ5IGlycSBBUEkuIA0KTWFwIHRoaXMgcGh5c2lj
YWwgYWRkcmVzcyB0byBEQiBCQVIsICBzbyBQQ0kgaG9zdCB3cml0ZSB0aGlzIERCIGJhciwgdGhl
bg0KRVAgZ2VuZXJhdGUgaXJxLg0KDQpZb3UgY2FuIHJlZmVyIHYxNCB2ZXJzaW9uLCB3aGljaCBz
aG91bGQgYmUgYmV0dGVyIGRlc2NyaXB0aW9uLiANCg0KPiANCj4gVGhpcyBpcyBhYm91dCBhIFBD
SWUgZW5kcG9pbnQsIHdoaWNoIGlzIHVzdWFsbHkgaGFuZGxlZCBieSBhIFBDSS9NU0kNCj4gaW50
ZXJydXB0IGRvbWFpbi4gT2J2aW91c2x5IHRoaXMgdXNhZ2UgZG9lcyBub3QgZml0IGludG8gdGhl
IHdheSBob3cgdGhlDQo+ICJnbG9iYWwiIFBDSS9NU0kgZG9tYWlucyB3b3JrLg0KDQpQQ0kgZW5k
cG9pbnQgaGF2ZSBub3Qgc3RhbmRhcmQgUENJIGNvbmZpZ3VyZSBzcGFjZSB0byBlbmFibGUvZGlz
YWJsZSBNU0kgaXJxIGFuZA0KTVNJIGFkZHJlc3MgKENBUCAwNSkuICBUaGF0J3MgcmVhc29uIHdo
eSBuZWVkICJwbGF0Zm9ybSBtc2kiLCBvciB5b3UgY2FsbGVkICJnbG9iYWwiDQpOb3cuICAgDQoN
Cj4gDQo+IFRoZXJlIGlzIHVwY29taW5nIHdvcmsgYW5kIGF0IGxlYXN0IHRoZSBnZW5lcmljIHBh
cnRzIHNob3VsZCBzaG93IHVwIGluDQo+IDYuMiB3aGljaCBhZGRyZXNzZXMgZXhhY3RseSB0aGUg
cHJvYmxlbSB5b3UgYXJlIHRyeWluZyB0byBzb2x2ZToNCj4gDQo+IA0KPiBodHRwczovL2V1cjAx
LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsb3Jl
LmsNCj4gZXJuZWwub3JnJTJGYWxsJTJGMjAyMjExMjQyMjUzMzEuNDY0NDgwNDQzJTQwbGludXRy
b25peC5kZSZhbXA7ZGF0YQ0KPiA9MDUlN0MwMSU3Q0ZyYW5rLkxpJTQwbnhwLmNvbSU3QzZhMDdl
MzNlNTZhZjQ1ZmZjMWZmMDhkYWQxNzRkMDJkDQo+ICU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5
YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzgwNTI1OTY5MDQ5NTMwDQo+IDA2JTdDVW5rbm93biU3Q1RX
RnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXoNCj4gSWlMQ0pCVGlJ
NklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJTdDJTdDJTdDJmFtcDtzZGF0YT1ROGpyDQo+
IGVWR0dMYTJNNHloakdPN05qcXdkbTU5WERDMEd5TEV3a3IwazZCMCUzRCZhbXA7cmVzZXJ2ZWQ9
MA0KPiANCj4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/
dXJsPWh0dHBzJTNBJTJGJTJGbG9yZS5rDQo+IGVybmVsLm9yZyUyRmFsbCUyRjIwMjIxMTI0MjMw
NTA1LjA3MzQxODY3NyU0MGxpbnV0cm9uaXguZGUmYW1wO2RhdGENCj4gPTA1JTdDMDElN0NGcmFu
ay5MaSU0MG54cC5jb20lN0M2YTA3ZTMzZTU2YWY0NWZmYzFmZjA4ZGFkMTc0ZDAyZA0KPiAlN0M2
ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM4MDUyNTk2OTA0OTUz
MA0KPiAwNiU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJ
am9pVjJsdU16DQo+IElpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3QyU3
QyU3QyZhbXA7c2RhdGE9VGM5cA0KPiBYTko0OTlFVEZnTldRQk5MVmlGazhENUdidnJyd1lEbEJX
JTJCZjJxZyUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiANCj4gcGx1cyB0aGUgcHJvdmUgdGhhdCB0aGUg
cGxhdGZvcm0gTVNJIG1lc3MgY2FuIGJlIHJlcGxhY2VkIGJ5IHRoaXM6DQo+IA0KPiANCj4gaHR0
cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNB
JTJGJTJGbG9yZS5rDQo+IGVybmVsLm9yZyUyRmFsbCUyRjIwMjIxMTIxMTM1NjUzLjIwODYxMTIz
MyU0MGxpbnV0cm9uaXguZGUmYW1wO2RhdGENCj4gPTA1JTdDMDElN0NGcmFuay5MaSU0MG54cC5j
b20lN0M2YTA3ZTMzZTU2YWY0NWZmYzFmZjA4ZGFkMTc0ZDAyZA0KPiAlN0M2ODZlYTFkM2JjMmI0
YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM4MDUyNTk2OTA0OTUzMA0KPiAwNiU3Q1Vu
a25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16DQo+
IElpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3QyU3QyU3QyZhbXA7c2Rh
dGE9UjVLDQo+IE5WZmNHcXhvQ2FtJTJGWWhZNTdpaHNsb1dHaEdMTTNLaDlJa3lNRTRsayUzRCZh
bXA7cmVzZXJ2ZWQ9MA0KPiANCj4gTlRCIGluIGl0J3MgY3VycmVudCBmb3JtIHNob3VsZCBuZXZl
ciBoYXZlIGhhcHBlbmVkLCBidXQgdGhhdCdzIHdhdGVyDQo+IGRvd24gdGhlIGJyaWRnZS4NCj4g
DQo+IFdoYXQgeW91IHJlYWxseSB3YW50IGlzOg0KPiANCj4gICAxKSBDb252ZXJ0IHlvdXIgcGxh
dGZvcm0gdG8gdGhlIG5ldyBNU0kgcGFyZW50IG1vZGVsDQo+IA0KPiAgIDIpIFV0aWxpemUgUENJ
L0lNUyB3aGljaCBpcyBnaXZpbmcgeW91IGV4YWN0bHkgd2hhdCB5b3UgbmVlZCB3aXRoDQo+ICAg
ICAgcHJvcGVyIFBDSSBzZW1hbnRpY3MNCg0KU29ycnksIEkgc3RpbGwgZG9uJ3QgdW5kZXJzdGFu
ZCB5ZXQuICBUaGlzIHBhdGNoIGlzIGp1c3QgdXNlciBvZiBtc2kgY29udHJvbGxlci4NCllvdXIg
cGF0Y2hlcyBmb2N1cyBvbiB0aGUgbXNpIGNvbnRyb2xsZXIgaXRzZWxmLiANCg0KSW50ZXJmYWNl
IHBsYXRmb3JtX21zaV9kb21haW5fYWxsb2NfaXJxcyBzdGlsbCBleGlzdCBhdCB5b3VyIGRldm1z
aS12Mi1wYXJ0My4gDQoNCg0KPiANCj4gVGhhbmtzLA0KPiANCj4gICAgICAgICB0Z2x4DQo=
