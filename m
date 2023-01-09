Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7E0662DC8
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jan 2023 18:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbjAIR46 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Jan 2023 12:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbjAIR4d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2023 12:56:33 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2075.outbound.protection.outlook.com [40.107.6.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5F941020;
        Mon,  9 Jan 2023 09:52:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQR0hzp2oOfWl/4e6kbCs/gmHFgV05UE3KT9D2EH1hHvWh9QkYoUBz7VdKNGpgozfwABcmGXhe6DcUq9AsMuSHLhX9p6vVWl9bLCiYN/Mypo31yU+vRcHrpUD3bfMwpVGbCj8S+ReRKrqrFVZZoEfdjKl0OP/iRGCXlCZUvxQGYqkMguphu49sPPoQtd2VleE1cdxRzIrDom2UUbh2RkvDam42TgSEvuYJ2+LC/e6WFqrfKAV40BSSivF9G3dEbsuxPpTsiO3LOOVtT1gQPw7kOzqK1QnmBfm6McaQbj91lGvUYEcw/c3lwMmSYN5cC7VwEES7tIjfgkEQh6YzIfYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xatx8QMwyInM7O2a9PuN51wMDsn1SN4RNkC+qeZDxpw=;
 b=gstm1Kgx9ICU/AfWwpmbWpq7Glq0SM+a4zULQOnSriZZwV9l3A6uXUR0OrBUl7OOsFxFFVNItCuWZzxcCLoNplj6S9tLlTOCvJzbIw7OKyXctY5XXquznAhxyeR15Mgp30/elbI+7SskLiI6SbAuPVMftzOKHvjKJ7gZ666mL4u+s5DUKZN+mK7xKmFDzsX5GkiKw9nQt3peW7/hwLm9a6wrMkly1ymCTWG7Q+kKTvz0y4vc654gofRm8GkISxwIfD8OIyPIjvOhNiAoXOuGZF/1O+T02wV6JLayvfL8jkQDz0tyh/+j9Uy/8cLdiDQ50+uO41RcVoAA4zclaNbmPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xatx8QMwyInM7O2a9PuN51wMDsn1SN4RNkC+qeZDxpw=;
 b=dkqHBCriDC7XWN3UdixDrP1VsDrv1+iixe27UFSNHF95eFSUapr8Ob60C4cBRgXkcQCKcL/n5af79Kf3SHeWjFTXQ3s3232pqFEYA/4FA5+i7RUlO1r3eZFMoSJ4EpwbuVdi8klsAiQ7zyXs4uKA5fSW4+jYlFZnjnEJle8nlLk=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by PA4PR04MB7695.eurprd04.prod.outlook.com (2603:10a6:102:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 17:51:59 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd%6]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 17:51:59 +0000
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
Thread-Index: AQHY/8jEGxDCgJFzq061wXktOCH4pq5Uu8YAgEHk1qA=
Date:   Mon, 9 Jan 2023 17:51:58 +0000
Message-ID: <HE1PR0401MB2331A0C7F45D5F30465DFD3188FE9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
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
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|PA4PR04MB7695:EE_
x-ms-office365-filtering-correlation-id: c56bbf5b-d7b7-4bc2-c404-08daf26a3475
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vANf4NGkV6elevgMfYH4a9UvUHsmoXYB2tdY6UB/yzfZ609s/pqZW9GduNmdEqrF5NnwejLCeZ26mOZH8Tfd864uqTVKJ1M9m0LzcmMYSXjBTnYEFoPQx+DdlNZ/hwbGkcUQV0AqJGGEJF5Iu6HJNlL+/vYB8L4xCdHbOJqSr2hWrCQb/DvXgigdu6xTfEkrwtr5Pq555KGNMxJwakNEq2fs4miXkWiKzy0B3zrTh2RHcPPw3vuzzOuXFK45yP20w6A54WGL0aNEEMYxlfq6kArblkey74grhKNjAyCPkyG1bU6bcIs9T6Pj8TdAlfRgPnM+BYGTNYYOQ913ELCp6VcqFug7GFbNxeGcMW1NhCqwUfjt+SJn3GHJClp777XB7+3xj1ZULeHAub+WlqqP4Q0/0jOWJiK6RBjQIHdCXVG8sF40+CdY+HW8A1WAx+IKeFoic0NUZImNHNbERFe2hncgToJLY4LpxqxXx7rn9VS4GwJncFMCi1H1DtuIb7BI2tO/vOCJJTNOASkt+Bq2ZotnXtCqRlNNkP2CHnuztOkvXlUU640PZtbpbORTqGWqzMfUenCaqICG6RSKJSFw6Bv4rnSSdrzNt636cOGOHEFXh9D97KC0f2Nzyfo/IHpjUa/3PgUkEgOee426FUhxaMT20ogmW2kAf7iK5qCY/9jX9lpiOq8TaXpDQOwq9jvQWSLuBR4FF4LtmYnCooVXfO8EIFWn414mBOJC+hOvMQVYx7vJVONr10uELFWkTLMj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199015)(8936002)(2906002)(5660300002)(45080400002)(52536014)(41300700001)(7416002)(66446008)(71200400001)(38070700005)(7696005)(66556008)(4326008)(76116006)(8676002)(66476007)(66946007)(64756008)(316002)(44832011)(110136005)(54906003)(186003)(9686003)(26005)(122000001)(38100700002)(55016003)(86362001)(83380400001)(966005)(33656002)(478600001)(6506007)(55236004)(98474003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUhhUlVrTEVya3JCQUVLRGV1Tkk2VlI2eVZmTlFrQWk1UEY5Uy8rbHJhdlZr?=
 =?utf-8?B?ZkpGdWhmaXE3b1F6c1FnbG1ENnYxVVZqaTgwZkl4UUxyaDhibVV0Y28vYlh3?=
 =?utf-8?B?b0tnanQrZUM4ZmpEK0EwcmhYTDJRVTFiOHdiRnNuK0Y0ay9sUmpmTDRZdTd0?=
 =?utf-8?B?SU9UeThrNHVTMmFUZXdnYTFtQlQzbVQvT1ZCTHF4WlFFbVhjTDNYbFVwTlgr?=
 =?utf-8?B?T2pvZTVKMGRsRXYyQmk1NXNFTnlDREphZnNtT1VEaW5STys5cmpoQW1BaVJq?=
 =?utf-8?B?SzBQY3dkWU9YeVdmM0lXcTZ3NGRmQTByWTVpc05UTXdablFWeWtwRjRWNnNO?=
 =?utf-8?B?ZWJVeU9GQVZFRkxobUl4Rk01dmVTeS82dE9aVk1aSENDUEduM2pXa0JoSGZk?=
 =?utf-8?B?WXZlV1JJRGxIVEZUV0dWM1FxdHU3aUovUWZaN1RSeEgzNkQ5UmRJWUd6YmRQ?=
 =?utf-8?B?RTJZc0Y5S1Q2VXc1cXl6M3hjcjFLZ0VWZm9xYXFYN2JSSUJ4QjFMaFduKzNx?=
 =?utf-8?B?WmhSUHFjVzBOQitXNU44YmpkR3NhUkkxN29Jb0V5Mlc4U29GM2xyd1IrZVlj?=
 =?utf-8?B?R0NSR3hQWWRXVXJrTEdLei8yOWFIeFVNK1lGTmY1Q0c3U0pXQjUzOG9iZ0Ni?=
 =?utf-8?B?OWpucHEyYTJZS3IzVTlXRGhaVEwyUTMzWTkrL0M4MU5ja2MrQ2VBczl5WXFY?=
 =?utf-8?B?aW9zRElpWWxmVW5zRkE4S20wTkttN0ZvMHJOU2cyRCtFTHo2K0xoY1ZaeTAz?=
 =?utf-8?B?ZENGTkdvVjBaaU8yOU5LVmdYUC94WGZPSEo2cTFUZWJqaHk3WHFxVlJvWjhi?=
 =?utf-8?B?N2M0Z2wxWW1FNnprTmJiV0wwTXJrMytBTkZBbjB5djVRL3hHNHhQeTJQeWtX?=
 =?utf-8?B?Q2lLQkxSdGhWZW13ZEdLRzZ5UGFUSTZVM2pPcHF4djl4M1MvUFUrbmhwQzNE?=
 =?utf-8?B?eTRXdmlNZE05dlc5V1hySlN0UE5ZTGF2MWVkV3BDa1cxL3pBcnRtZWlWYUgx?=
 =?utf-8?B?K0x4bjAxUm4rU0NtU1lscGZOOFN6OHNKcHRUNnJ1S0tRcDNzNUVQdStMczc0?=
 =?utf-8?B?bWthZ0s1R1o4eE9NdGNVNE9jVURCOU85SXh2NFVieDRGOXZlN3c2RnFKcGM4?=
 =?utf-8?B?aXFvakpkeWZaTUN1WHMxMExrcjlPazM2ZVA2R3dVcEtIdFlpRTVxRUd4NE02?=
 =?utf-8?B?VzFqZlp1T1J3Ni9DM2NMM3pvT3BiU0NuM2tvR1lOMVdmb3RBMlNhUXIxSG5x?=
 =?utf-8?B?NzRyWWZpRlA4bExka2prOThQTk56eEF4R21UZWl1SjN1UExrcGQrNEFpekh4?=
 =?utf-8?B?T3ZTSUg3bVB0bGE0NlRlNUFDOFhpYnNVYXdRNmlEbUk0dituSDh6b21uRkI1?=
 =?utf-8?B?TlM5Q215YjhZa0k3a0QyUFZZY1ZmalNXRW1jZVowci9yZkg5a1pYZ0g3Rlh1?=
 =?utf-8?B?ZTZNOHJPWis0dlFDVm9Lb09BUFBXM3h6NEc4Z3c5WUdHOHkrajBLdUdYRTJU?=
 =?utf-8?B?QUQvMUpWeXpGWHhZUkJyMUxPMnpENkxWWlNlbFNNU2x6Q3MyUXllV21iL3Z3?=
 =?utf-8?B?bThVSnpBMUR3TGZXR01EV0hBZUFhMURtVnVYeHhEY2VMVVBjQ1BTSE5ucnk2?=
 =?utf-8?B?R242dHh5enJQOGlwajJWTm5iQ3lFekJFYTFkcHBFZE1nZ0J3QzNDQ3ZweWVi?=
 =?utf-8?B?dmNOcm1Oc1paWDBOMm9Kc0VlYWtaYmhZVi9ENEZJOWhFcE1WeGFobkJhMVQz?=
 =?utf-8?B?RGJZNWJJckNzcTJhZmJNckN4bkxjazgzUjM5OE1GdXF0YUJBU1VpUmo2QU1u?=
 =?utf-8?B?bzQ2OXU5S0RmNUJJK296bDcxRk01TXFhUzhNMm5TU0kvL2ZjejRUREFENWRO?=
 =?utf-8?B?RC84SnBDQkZrUUlzNlkvUGFVMTFwOCsyQXlFOFpXTlNjMis1TFpCL3ZNK0Zs?=
 =?utf-8?B?UGNLOStIa3pyZEJPbUc1YUNvbXVwZVBTSzhINGRUU2lyMjlMdkJGbjQvZ1pp?=
 =?utf-8?B?YWtGak8wWk4wR3k4ZVZYa2Y5Z3k2RmlzQnRONmh1Y2ZrSkFGTS9uU0RRMEVn?=
 =?utf-8?B?KzFQc0Vacnduc00yWmV3UGt1V3pURFNRODhhRms4VVJVVmxPY251c3FQZk9y?=
 =?utf-8?Q?FPpk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c56bbf5b-d7b7-4bc2-c404-08daf26a3475
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 17:51:58.6759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JH0v2+QztUaW/OyClS5qIY8CaR8ca4WEcvmSfEsVoUdg6Im7eyAWv4QbZqrApA1lYvrHAi1UhVkB14SMhJXqLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7695
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQo+IE9uIFRodSwgTm92IDI0IDIwMjIgYXQgMDA6NTAsIEZyYW5rIExpIHdyb3RlOg0KPiA+IOKU
jOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUkCAgIOKUjOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgA0KPiDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilJAgICDilIzilIDilIDi
lIDilIDilIDilIDilIDilIANCj4g4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQDQo+ID4g4pSC
ICAgICAgICAgICAg4pSCICAg4pSCICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICDi
lIIgICDilIIgICAgICAgICAgICAgICAg4pSCDQo+ID4g4pSCICAgICAgICAgICAg4pSCICAg4pSC
IFBDSSBFbmRwb2ludCAgICAgICAgICAgICAgICAgICAgICDilIIgICDilIIgUENJIEhvc3QgICAg
ICAg4pSCDQo+ID4g4pSCICAgICAgICAgICAg4pSCICAg4pSCICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICDilIIgICDilIIgICAgICAgICAgICAgICAg4pSCDQo+ID4g4pSCICAgICAg
ICAgICAg4pSC4peE4pSA4pSA4pSkIDEucGxhdGZvcm1fbXNpX2RvbWFpbl9hbGxvY19pcnFzKCni
lIIgICDilIIgICAgICAgICAgICAgICAg4pSCDQo+ID4g4pSCICAgICAgICAgICAg4pSCICAg4pSC
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICDilIIgICDilIIgICAgICAgICAgICAg
ICAg4pSCDQo+ID4g4pSCIE1TSSAgICAgICAg4pSc4pSA4pSA4pa64pSCIDIud3JpdGVfbXNpX21z
ZygpICAgICAgICAgICAgICAgICDilJzilIDilIDilrrilJzilIBCQVI8bj4NCj4g4pSCDQo+ID4g
4pSCIENvbnRyb2xsZXIg4pSCICAg4pSCICAgdXBkYXRlIGRvb3JiZWxsIHJlZ2lzdGVyIGFkZHJl
c3PilIIgICDilIIgICAgICAgICAgICAgICAg4pSCDQo+ID4g4pSCICAgICAgICAgICAg4pSCICAg
4pSCICAgZm9yIEJBUiAgICAgICAgICAgICAgICAgICAgICAgICDilIIgICDilIIgICAgICAgICAg
ICAgICAg4pSCDQo+ID4g4pSCICAgICAgICAgICAg4pSCICAg4pSCICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICDilIIgICDilIIgMy4gV3JpdGUgQkFSPG4+4pSCDQo+ID4g4pSCICAg
ICAgICAgICAg4pSC4peE4pSA4pSA4pS84pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSADQo+IOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUvOKUgOKUgOKUgOKUpCAgICAgICAgICAgICAgICDilIINCj4g
PiDilIIgICAgICAgICAgICDilIIgICDilIIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIOKUgiAgIOKUgiAgICAgICAgICAgICAgICDilIINCj4gPiDilIIgICAgICAgICAgICDilJzi
lIDilIDilrrilIIgNC5JcnEgSGFuZGxlICAgICAgICAgICAgICAgICAgICAgIOKUgiAgIOKUgiAg
ICAgICAgICAgICAgICDilIINCj4gPiDilIIgICAgICAgICAgICDilIIgICDilIIgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIOKUgiAgIOKUgiAgICAgICAgICAgICAgICDilIINCj4g
PiDilIIgICAgICAgICAgICDilIIgICDilIIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIOKUgiAgIOKUgiAgICAgICAgICAgICAgICDilIINCj4gPiDilJTilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilJggICDilJTilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIANCj4g4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSYICAg4pSU4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
DQo+IOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUmA0KPiA+DQo+ID4gVXNpbmcgcGxhdGZvcm0g
TVNJIGludGVycnVwdCBjb250cm9sbGVyIGFzIGVuZHBvaW50KEVQKSdzIGRvb3JiZWxsLg0KPiAN
Cj4gQ2FuIHlvdSBwbGVhc2UgZXhwbGFpbiB3aGF0IHRoZSBNU0kgY29udHJvbGxlciBpcyBpbiB0
aGlzIHBpY3R1cmU/IE1TSQ0KPiBjb250cm9sbGVyIGlzIG5vdCBhIHRlcm0gd2hpY2ggaXMgY29t
bW9uIGluIHRoZSBpbnRlcnJ1cHQgaGFuZGxpbmcNCj4gbGFuZHNjYXBlIGRlc3BpdGUgdGhlIGZh
Y3QgdGhhdCBpdCdzIHByZXR0eSB3aWRlIHNwcmVhZCBpbiBkZXZpY2UgdHJlZQ0KPiBiaW5kaW5n
cyBwcmVzdW1hYmx5IHRocm91Z2ggaW50ZW5zaXZlIGNvcHkgJiBwYXN0YSBjYXJnbyBjdWx0Lg0K
PiANCj4gPiBCYXNpYyB3b3JraW5nIGZvbGxvdyBhcw0KPiA+IDEuIEVQIGZ1bmN0aW9uIGRyaXZl
ciBjYWxsIHBsYXRmb3JtX21zaV9kb21haW5fYWxsb2NfaXJxcygpIGFsbG9jIGENCj4gPiBNU0kg
aXJxIGZyb20gTVNJIGNvbnRyb2xsZXIgd2l0aCBjYWxsIGJhY2sgZnVuY3Rpb24gd3JpdGVfbXNp
X21zZygpOw0KPiA+IDIuIHdyaXRlX21zZ19tc2cgd2lsbCBjb25maWcgQkFSIGFuZCBtYXAgdG8g
YWRkcmVzcyBkZWZpbmVkIGluIG1zaV9tc2c7DQo+ID4gMy4gSG9zdCBzaWRlIHRyaWdnZXIgYW4g
SVJRIGF0IEVuZHBvaW50IGJ5IHdyaXRlIHRvIEJBUiByZWdpb24uDQo+IA0KPiBZb3UncmUgZXhw
bGFpbmluZyB3aGF0IHRoZSBjb2RlIGRvZXMsIGJ1dCBmYWlsIHRvIGV4cGxhaW4gdGhlIHVuZGVy
bHlpbmcNCj4gbWVjaGFuaXNtcy4NCj4gDQo+IFBsYXRmb3JtIE1TSSBpcyBkZWZpbml0ZWx5IHRo
ZSB3cm9uZyBtZWNoYW5pc20gaGVyZS4gV2h5Pw0KPiANCj4gVGhpcyBpcyBhYm91dCBhIFBDSWUg
ZW5kcG9pbnQsIHdoaWNoIGlzIHVzdWFsbHkgaGFuZGxlZCBieSBhIFBDSS9NU0kNCj4gaW50ZXJy
dXB0IGRvbWFpbi4gT2J2aW91c2x5IHRoaXMgdXNhZ2UgZG9lcyBub3QgZml0IGludG8gdGhlIHdh
eSBob3cgdGhlDQo+ICJnbG9iYWwiIFBDSS9NU0kgZG9tYWlucyB3b3JrLg0KPiANCj4gVGhlcmUg
aXMgdXBjb21pbmcgd29yayBhbmQgYXQgbGVhc3QgdGhlIGdlbmVyaWMgcGFydHMgc2hvdWxkIHNo
b3cgdXAgaW4NCj4gNi4yIHdoaWNoIGFkZHJlc3NlcyBleGFjdGx5IHRoZSBwcm9ibGVtIHlvdSBh
cmUgdHJ5aW5nIHRvIHNvbHZlOg0KPg0KQHRnbHgNCg0KSSBmaW5hbGx5IGdldCBhIHBsYXRmb3Jt
LCBsczEwMjgsIHdoaWNoIHVzZSBnaWMgaXRzIGFuZCBhbHNvIHN1cHBvcnQgUENJZSBFUCBmdW5j
dGlvbi4NCkkgcG9ydCBteSBjb2RlIGludG8gbGludXgtbmV4dCwgKG5leHQtMjAyMzAxMDUpIGFu
ZCB1bmRlcnN0YW5kIHlvdXIgY29tbWVudHMuDQoNCkl0cyBuZWVkIGEgZGV2aWNlIElEIHRvIGFs
bG9jYXRlIG1zaSBpcnEgZm9yIGVhY2ggZGV2aWNlcy4gIA0KDQpFcGYgZGV2aWNlIGlzIGR5bmFt
aWMgY3JlYXRlZCwgd2hlcmUgYXJlIGZpZWxkIGVwYywgIGVwYy5wYXJlbnQgcG9pbnQgdG8gUENJ
ZSBFUA0KQ29udHJvbGxlciwgd2hpY2ggaGF2ZSBiZWVuIHByb2JlZCBieSBkZXZpY2UtdHJlZS4g
DQoNCkkgdXNlIGEgd29ya2Fyb3VuZCB0byBnZXQgbXNpIGlycSBudW1iZXIuIA0KCWRldi0+b2Zf
bm9kZT0gIG50Yi0+ZWZwLT5lcGMtPmRldi5wYXJlbnQtPm9mX25vZGU7DQoJUGxhdGZvcm1fbXNp
X2RvbWFpbl9hbGxvY19pcnFzKGRldiwgLi4uKTsNCg0KSXJxLWdpYy12My1pdHMtcGNpLW1zaSB1
c2Ugb2Zfbm9kZSB0byBnZXQgYSBJRC4gDQoNCllvdSBzYWlkIFBDSS9JTVMgY2FuIHJlc29sdmUg
dGhpcyBwcm9ibGVtLiAgQnV0IEkgc3RpbGwgbm90IGZpZ3VyZSBvdXQgaXQgeWV0Lg0KQ2FuIHlv
dSBnaXZlIG1lIHNhbXBsZSBjb2RlLCB3aGljaCB1c2UgUENJL0lNUyBvciBwcm92aWRlIGEgcHNl
dWRvIGNvZGU/DQoNCkZyYW5rIA0KDQo+IA0KPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsb3JlLmsNCj4gZXJuZWwub3Jn
JTJGYWxsJTJGMjAyMjExMjQyMjUzMzEuNDY0NDgwNDQzJTQwbGludXRyb25peC5kZSZhbXA7ZGF0
YT0wDQo+IDUlN0MwMSU3Q0ZyYW5rLkxpJTQwbnhwLmNvbSU3QzZhMDdlMzNlNTZhZjQ1ZmZjMWZm
MDhkYWQxNzRkMDJkJTdDDQo+IDY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3
QzAlN0M2MzgwNTI1OTY5MDQ5NTMwMDYlN0MNCj4gVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJ
am9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkINCj4gVGlJNklrMWhhV3dpTENKWFZD
STZNbjAlM0QlN0MzMDAwJTdDJTdDJTdDJmFtcDtzZGF0YT1ROGpyZVZHRw0KPiBMYTJNNHloakdP
N05qcXdkbTU5WERDMEd5TEV3a3IwazZCMCUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiANCj4gaHR0cHM6
Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJG
JTJGbG9yZS5rDQo+IGVybmVsLm9yZyUyRmFsbCUyRjIwMjIxMTI0MjMwNTA1LjA3MzQxODY3NyU0
MGxpbnV0cm9uaXguZGUmYW1wO2RhdGE9MA0KPiA1JTdDMDElN0NGcmFuay5MaSU0MG54cC5jb20l
N0M2YTA3ZTMzZTU2YWY0NWZmYzFmZjA4ZGFkMTc0ZDAyZCU3Qw0KPiA2ODZlYTFkM2JjMmI0YzZm
YTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM4MDUyNTk2OTA0OTUzMDA2JTdDDQo+IFVua25v
d24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pC
DQo+IFRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3QyU3QyU3QyZhbXA7c2RhdGE9
VGM5cFhOSjQ5DQo+IDlFVEZnTldRQk5MVmlGazhENUdidnJyd1lEbEJXJTJCZjJxZyUzRCZhbXA7
cmVzZXJ2ZWQ9MA0KPiANCj4gcGx1cyB0aGUgcHJvdmUgdGhhdCB0aGUgcGxhdGZvcm0gTVNJIG1l
c3MgY2FuIGJlIHJlcGxhY2VkIGJ5IHRoaXM6DQo+IA0KPiANCj4gaHR0cHM6Ly9ldXIwMS5zYWZl
bGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbG9yZS5rDQo+
IGVybmVsLm9yZyUyRmFsbCUyRjIwMjIxMTIxMTM1NjUzLjIwODYxMTIzMyU0MGxpbnV0cm9uaXgu
ZGUmYW1wO2RhdGE9MA0KPiA1JTdDMDElN0NGcmFuay5MaSU0MG54cC5jb20lN0M2YTA3ZTMzZTU2
YWY0NWZmYzFmZjA4ZGFkMTc0ZDAyZCU3Qw0KPiA2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMw
MTYzNSU3QzAlN0MwJTdDNjM4MDUyNTk2OTA0OTUzMDA2JTdDDQo+IFVua25vd24lN0NUV0ZwYkda
c2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCDQo+IFRpSTZJazFo
YVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3QyU3QyU3QyZhbXA7c2RhdGE9UjVLTlZmY0cNCj4g
cXhvQ2FtJTJGWWhZNTdpaHNsb1dHaEdMTTNLaDlJa3lNRTRsayUzRCZhbXA7cmVzZXJ2ZWQ9MA0K
PiANCj4gTlRCIGluIGl0J3MgY3VycmVudCBmb3JtIHNob3VsZCBuZXZlciBoYXZlIGhhcHBlbmVk
LCBidXQgdGhhdCdzIHdhdGVyDQo+IGRvd24gdGhlIGJyaWRnZS4NCj4gDQo+IFdoYXQgeW91IHJl
YWxseSB3YW50IGlzOg0KPiANCj4gICAxKSBDb252ZXJ0IHlvdXIgcGxhdGZvcm0gdG8gdGhlIG5l
dyBNU0kgcGFyZW50IG1vZGVsDQo+IA0KPiAgIDIpIFV0aWxpemUgUENJL0lNUyB3aGljaCBpcyBn
aXZpbmcgeW91IGV4YWN0bHkgd2hhdCB5b3UgbmVlZCB3aXRoDQo+ICAgICAgcHJvcGVyIFBDSSBz
ZW1hbnRpY3MNCj4gDQo+IFRoYW5rcywNCj4gDQo+ICAgICAgICAgdGdseA0K
