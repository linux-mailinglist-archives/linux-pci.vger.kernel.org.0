Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D3B5F281F
	for <lists+linux-pci@lfdr.de>; Mon,  3 Oct 2022 07:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiJCFPD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Oct 2022 01:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJCFPB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Oct 2022 01:15:01 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24361A07F;
        Sun,  2 Oct 2022 22:14:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijVxRNmwa+FBF8fHZyRqALlQFZvi9XIkMl1aVqP0O7C+Ya0yD1/3bMS03VbbB0+Olfl8YTxdSCMrB0s738kzFReT4uhir4vGICzDBJgA3PPbFN6HNt9fhvdeaYOp0lhaupWMwKmZbsMRTWz6K6P4PlaaG2ZQLacE+AD6PxhyxJFG4dumtGI9elDhBbAkGmhRBWHB6MHpAEquChp7rA3LgiOIkhyceIZZb7oAJlXDnWsHW/IJaqD5/CQTwskAKHtGbXjRdvJ+FwiabrkRfR3ZzKCCKHg7v88XjvydYwPNa8KOjM1TXek7FdrXjGRNl60Mmncdfw6fPn7oW1M1qw7v+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsFfL9tBnUUcyLz66wcs2xOtx7B67RjEj0rGk6D/1Kc=;
 b=c26ic8l/02QBPXm0txRyHimA/ii1XS8j7P5LB2qnF3orbDeyVMsW2UkRmo/JiIpawc7k7DnBJTkZAvU0dFTJT/YOYLkGr26Q3W2tl4MdMB1ShBOj1q+eaRDGNG2gtK6F5x2iGE/PHJL9wIMGiOGKI5dGj+GCezj6iw7FXtuy/MtxzszMA3BftWGlqTcRs+VwL2qamsjRzCbCMNGcrv2tFUGrMHk2e+PTYHV2UsGMOWTnfmJX6O94BJ/oQgu7HAtsCDwxf7tztpTbhaVk6yDxwBy3FF/S32d9r9L0fZ45AGX7uXyedUFqEdKKGEATSKxnIBxbrGoX7UWpJgPBPQj/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsFfL9tBnUUcyLz66wcs2xOtx7B67RjEj0rGk6D/1Kc=;
 b=W3HAtUyzFmcyRtMX/ssSGzi04oJwyfGoKMen6VkDb+OdpTpqfU4agY4USppfW+iKFpinoSmzg/hvLF1EZ1Qa2+Pu5lesQFzjaJv0GnRgeIYBzoLXKHS/JNN/u4RWEVZzNQfWQc6cXvWZSPzL2bN1N8tzvLxGbiYC1nHFsQ8Bfto=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB7896.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Mon, 3 Oct
 2022 05:14:56 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::1abe:67d2:b9fe:6b63]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::1abe:67d2:b9fe:6b63%4]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 05:14:56 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "marex@denx.de" <marex@denx.de>,
        "richard.leitner@linux.dev" <richard.leitner@linux.dev>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v10 3/4] phy: freescale: imx8m-pcie: Refine i.MX8MM PCIe
 PHY driver
Thread-Topic: [PATCH v10 3/4] phy: freescale: imx8m-pcie: Refine i.MX8MM PCIe
 PHY driver
Thread-Index: AQHY0+FVQzF3aQVFnkawteJEbcbsE633pZqAgAR1YeA=
Date:   Mon, 3 Oct 2022 05:14:56 +0000
Message-ID: <AS8PR04MB86764711BAD58E47AEAD6D738C5B9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1664440622-18556-1-git-send-email-hongxing.zhu@nxp.com>
 <1664440622-18556-4-git-send-email-hongxing.zhu@nxp.com>
 <0017a1b1-f932-7bb3-7d00-a139bd4cc98d@pengutronix.de>
In-Reply-To: <0017a1b1-f932-7bb3-7d00-a139bd4cc98d@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AS8PR04MB7896:EE_
x-ms-office365-filtering-correlation-id: f688d3de-37b9-4e77-df81-08daa4fe3671
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IPDIXhLKQsPYJP1h7Y0unC6LFbJK8azVtv44L9TpNt9/RMK+2Qg81EbAns9R4isozR70JuYv1+hQP4MWbDNXejK1I5cnGzKzDdJrwf+yRMuZyZKQlg4sBSsDFHq7AzLchFw54CKoHhvLdLcLbEniBpY/XQN/lY9HSyTNQTYW6TzwoYLgVJ94Ne+W/cc4/z2ljrPxPGqLeQZ95+D6OQht80JQi7snp+dJyytO1TI7zDSMlXFk+Dhba7jVWsZerb/AFdbrGrWCZ/pSYVDuoaPLd+sx7f25oeRvSildz1EWXpqevXj9mhEl7txz0SQ/Bz/LIpSraJCjhAVEGqwjwMjQluK1kNRJsA4FXi2wA3ElioDQp/+vCiUREZHDEGD+ERXC35ICDg5KDIXl4F8k70sIRGyGDyEhsRTo05de9LEXvuXI2yufng6Fu/JFVy5uQTInCfU9+mEm/zt29OZhdFLfSWYpj3RIlGiI3KoptFoBiLvye9o7Rk7OcR8WPVG/D8lSGU+RQi2bBdOUfqITIHWjKSv6PFYfx+/moXkC7u8Kvj4Nd1gjiFOlVOxglK2/4bOVzzwbtuwmi9R+oLan1mwhbngNyHWbRLm74++2O/FKnt4jnJkkD0QBDqeSLLgG3ZVvsPZmz3K5tddowwoSVQCkBh8Zn6pLXl3u09NQ9wmq7aHUZ5geuatijBn82sNdxnQxWKik2ld5RRS4jatF24cHL9DQRQHt1h/kXEzk3Ik+Lg0Wk3NDMt4941qWn2yOqlXA3xW0n8IiWNzOcrmnVMIc+whY9YnTc6yUJRDl6tr1aVqPRsgmY3NzmCYWPi4+gzBvf0EccKNElgraccFIJavS0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199015)(66476007)(66556008)(66446008)(64756008)(8676002)(33656002)(110136005)(54906003)(86362001)(122000001)(966005)(44832011)(83380400001)(186003)(2906002)(66946007)(38100700002)(7416002)(4326008)(921005)(26005)(7696005)(53546011)(45080400002)(478600001)(71200400001)(316002)(52536014)(38070700005)(6506007)(8936002)(76116006)(9686003)(5660300002)(41300700001)(55016003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?L1c0VG1IMmRIQTkyS2Rvd01ubzM4MC9MbTNjME96RDdLTG9VSWZCMi9lQmI0?=
 =?gb2312?B?S2ZPZW1LakVHUG9ZS1hnK0RQaTRhZ2FoSWhpeis4Y0EvL3E2THRaS2puY28y?=
 =?gb2312?B?VHpLNUxxRmNQZFh2UjFaTTNrQUhXY0UxalRqNDZPU1hURXdRNFpsRmg3dVcr?=
 =?gb2312?B?SEJhS3V5d3JlbWNGZXRXdHhWYTZDZzVlSDVHbDhxVmhaajNWWmR5anhCYkdQ?=
 =?gb2312?B?Rlc2OTQ3R3BYUzhEWWw3T3dUbjBmOXFoZTdYQmovYldqVW9UYUFxVkdaVE1V?=
 =?gb2312?B?MkFtQ05yRC9aRnFRM1diL2FyTFp4NXA2Mms0b0xvZTAvaENQcnd3YTMza1Zu?=
 =?gb2312?B?MFlCV053c3d1ZTlDZVBqaVVSZTNieDNQRkZZdWRuQmpCMGNnZ0hvNnQybTNu?=
 =?gb2312?B?WnhETk5LSktRY1dCL2Y0MWx2STNaSVhvZTF4cEJDVnZINzBUb2pKRmJJZ1F6?=
 =?gb2312?B?djMzUG82WnZ2ay80TTdhTlc1Z25VTUFLSy90OEkyeEtIeVl0a1l5UXJGY1E3?=
 =?gb2312?B?NUFNWGtJT3cxZ1kxMVgvditUVzZwVmlNTXc5NGhEOWMrcGJweVdlcEZpWENM?=
 =?gb2312?B?VmFlenM0dFU0dytNNHFDVlQ5TWxYait4OUIwNzdwRDdxOVcxK055YWY2dVEx?=
 =?gb2312?B?Wi9rRCtYaGZzcWRoZklZUFJqdVhLb0RpVC9qSGF6a21IenIzRk5zNjgzNThw?=
 =?gb2312?B?eVBKRll0VGhOdExpV2hpdUtlR1dTOXY2d2hPVHhxYVRCKytzZkpzSHVBcWdq?=
 =?gb2312?B?U3JRNFZ0TmlocGJHV2h4RzFCeDMxbHBlNVI4eWpLdmpRVDFSNlR3amhzZDd6?=
 =?gb2312?B?Z2xUNkFKU1VQTC9sTXhZcnFjNE5uUlRYdFkrMGV2NmFQUndDTFRWWjYwRDYw?=
 =?gb2312?B?YXhuc2lxd0RZMkx0RTdQZlo2NHRRYWE5U05SMTNGUW5JMllQU0IrTFlVM3NL?=
 =?gb2312?B?Z3BTSU1vWHZZNGQ4TzBObXNQQVQ3Y3c5VVBZTytlMWxNRDA5MGtiVTdqdzh3?=
 =?gb2312?B?R1A1VUFRTWJ5OUFSaE1MQ2hpQlNsSG04aUlHeVdIOVRlZDhFdFBsM0V2bHcz?=
 =?gb2312?B?WFA2d3BHemhpNmZLRndYNkNoU1J1d2htQjQzRFhzRjRpWkJRQ1FDcmJZS3Ar?=
 =?gb2312?B?MmpPTFZLRXVDL2VOVE1PVGczQTE1WlJlbk1vZ1llN1RlWDd5UU9hK3BlZnp5?=
 =?gb2312?B?UkVGSVByM28xTzQ4Z1B2TS93LytJQnlueUtYL2RRYk1nT1dLSFdaVm8vb3hl?=
 =?gb2312?B?UjBGdjJraURTK2RzSG9MRHZLZW1uVnY0VjZwYWtmQlJIcXBybWljZjQxa3BE?=
 =?gb2312?B?MmwrSitWeHFHd21Ebnh5Y0NCb08vSFdNakhnT2xoRWpHV3dNVXVDUkhZRkJE?=
 =?gb2312?B?SFFYMVB0YUZCcUtYNHY0Y2pXMGFEbUhVRVlobVVwK1JTNFB3b0tiMUZvak1B?=
 =?gb2312?B?ejBEMCtHZ3JMQmE4bzQ3WnpGN05KMk9BeFpXU0czVTg1RGp1YzdwK2MvK2Vx?=
 =?gb2312?B?cjhCVkQwZnZqZnFPRDEvRkhDSFlVRnIzRkxROVFCdGUrOFRvRENmeUp2OEJK?=
 =?gb2312?B?ajFoNjFjQTZBYmdpSzJGUlRwa2hFN3RoQ24wZDh1MGhGSTA4aWpKV0EzeFR1?=
 =?gb2312?B?MGhFc1cxUVEzbkUyemZpRmRVcTk1Y0ZPNmFVbGEzR2F2ZEdGMDVQY29nZzFz?=
 =?gb2312?B?ZGswb3dNaEhyYTYxYUZLOVl2VTRjSThETWdjTmUza0Z1VldjVWxXTEx6UHlw?=
 =?gb2312?B?OVFWdnZSWlltdjhUUEpJS3d6M0NFQlZVZVlKb3c2NnluZThLUmNtREJhaFc5?=
 =?gb2312?B?ckhEQTFkVXFhcjFIaEp3Zm9acVkvZWtwWWcvaEZrTHFMdW8wUGgwUUl0SVN2?=
 =?gb2312?B?QzJxblZZamFqLytKZ2VtM0l4YmRIR0FYUjdPYWtCbDdoenlTeG1MUjdKdDVV?=
 =?gb2312?B?SmVENXlUL1RpblZEaGtTN25DeWxBZy9pY0loM1JIUnFuWlZHNXU5UDdGQWxM?=
 =?gb2312?B?dlhSYzdIamx2TEdqcVRxSm1TeUdHUnQ3ZERkRzdzSEpYTFFtNXlCMjc1bDMv?=
 =?gb2312?B?WHVFM0R2UXBEcWx1STI5UzFBTVpUVjRoL25Ndk5pUU10Q0llbE5Ieis4ZHEw?=
 =?gb2312?Q?YH+yIOsacM7Zp2nDANAnXTYVf?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f688d3de-37b9-4e77-df81-08daa4fe3671
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 05:14:56.8114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cLsWbUO74cJ0dLE/aFVsh11wcZ4KkEfjbVb2zWpmLJNUbd5CPa35AB6/3uUv280A0czD3GibZkxpDuORNnafHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7896
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBaG1hZCBGYXRvdW0gPGEuZmF0
b3VtQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyMDIyxOo51MIzMMjVIDE2OjI5DQo+IFRvOiBI
b25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgdmtvdWxAa2VybmVsLm9yZzsNCj4g
cC56YWJlbEBwZW5ndXRyb25peC5kZTsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgYmhlbGdhYXNA
Z29vZ2xlLmNvbTsNCj4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgcm9iaEBrZXJuZWwub3Jn
OyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBhbGV4YW5kZXIuc3RlaW5AZXcudHEtZ3JvdXAuY29t
OyBtYXJleEBkZW54LmRlOyByaWNoYXJkLmxlaXRuZXJAbGludXguZGV2DQo+IENjOiBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47
DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgbGludXgtcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7
DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYxMCAzLzRdIHBoeTogZnJlZXNjYWxlOiBpbXg4bS1wY2llOiBSZWZpbmUgaS5NWDhN
TQ0KPiBQQ0llIFBIWSBkcml2ZXINCj4gDQo+IE9uIDI5LjA5LjIyIDA5OjM3LCBSaWNoYXJkIFpo
dSB3cm90ZToNCj4gPiBUbyBtYWtlIGl0IG1vcmUgZmxleGlibGUgYW5kIGVhc3kgdG8gZXhwYW5k
LiBSZWZpbmUgaS5NWDhNTSBQQ0llIFBIWQ0KPiA+IGRyaXZlci4NCj4gPiAtIFVzZSBncHIgY29t
cGF0aWJsZSBzdHJpbmcgdG8gYXZvaWQgdGhlIGNvZGVzIGR1cGxpY2F0aW9ucyB3aGVuIGFkZA0K
PiA+ICAgYW5vdGhlciBwbGF0Zm9ybSBQQ0llIFBIWSBzdXBwb3J0Lg0KPiA+IC0gUmUtb3Jhbmdl
IHRoZSBjb2RlcyB0byBsZXQgaXQgbW9yZSBmbGV4aWJsZSBhbmQgZWFzeSB0byBleHBhbmQuDQo+
IA0KPiBSZS1hcnJhbmdlDQpTb3JyeSBmb3IgdGhlIHNwZWxsIG1pc3Rha2UuIFRoYW5rcyBmb3Ig
eW91ciByZXZpZXcgY29tbWVudHMuDQoNCj4gDQo+ID4gTm8gZnVuY3Rpb25zIGNoYW5nZXMgYmFz
aWNseS4NCj4gDQo+IE5vIGZ1bmN0aW9uYWwgY2hhbmdlLg0KR290IHRoYXQsIHRoYW5rcy4NCj4g
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5j
b20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXgu
ZGU+DQo+ID4gVGVzdGVkLWJ5OiBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT4NCj4gPiBUZXN0
ZWQtYnk6IFJpY2hhcmQgTGVpdG5lciA8cmljaGFyZC5sZWl0bmVyQHNraWRhdGEuY29tPg0KPiA+
IFRlc3RlZC1ieTogQWxleGFuZGVyIFN0ZWluIDxhbGV4YW5kZXIuc3RlaW5AZXcudHEtZ3JvdXAu
Y29tPg0KPiA+IFJldmlld2VkLWJ5OiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5k
ZT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9waHkvZnJlZXNjYWxlL3BoeS1mc2wtaW14OG0tcGNp
ZS5jIHwgMTA2DQo+ID4gKysrKysrKysrKysrKy0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCA2NiBpbnNlcnRpb25zKCspLCA0MCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3BoeS9mcmVlc2NhbGUvcGh5LWZzbC1pbXg4bS1wY2llLmMNCj4gPiBiL2RyaXZl
cnMvcGh5L2ZyZWVzY2FsZS9waHktZnNsLWlteDhtLXBjaWUuYw0KPiA+IGluZGV4IDIzNzdlZDMw
N2I1My4uNTliNDZhNGFlMDY5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGh5L2ZyZWVzY2Fs
ZS9waHktZnNsLWlteDhtLXBjaWUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGh5L2ZyZWVzY2FsZS9w
aHktZnNsLWlteDhtLXBjaWUuYw0KPiA+IEBAIC0xMSw2ICsxMSw3IEBADQo+ID4gICNpbmNsdWRl
IDxsaW51eC9tZmQvc3lzY29uLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9tZmQvc3lzY29uL2lt
eDctaW9tdXhjLWdwci5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gKyNp
bmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3BoeS9waHku
aD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiA+ICAjaW5jbHVk
ZSA8bGludXgvcmVnbWFwLmg+DQo+ID4gQEAgLTQ1LDYgKzQ2LDE1IEBADQo+ID4gICNkZWZpbmUg
SU1YOE1NX0dQUl9QQ0lFX1NTQ19FTgkJQklUKDE2KQ0KPiA+ICAjZGVmaW5lIElNWDhNTV9HUFJf
UENJRV9BVVhfRU5fT1ZFUlJJREUJQklUKDkpDQo+ID4NCj4gPiArZW51bSBpbXg4X3BjaWVfcGh5
X3R5cGUgew0KPiA+ICsJSU1YOE1NLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RydWN0IGlteDhf
cGNpZV9waHlfZHJ2ZGF0YSB7DQo+ID4gKwllbnVtCQlpbXg4X3BjaWVfcGh5X3R5cGUgdmFyaWFu
dDsNCj4gDQo+IEJldHRlciBkbyBpbmRlbnRhdGlvbiBvbiB0aGUgbWVtYmVyIG5hbWUuDQpHb3Qg
dGhhdCwgd291bGQgbWFrZSB0aGVtIGluZGVudCBsYXRlciB0aGFua3MuDQo+IA0KPiA+ICsJY29u
c3QgY2hhcgkqZ3ByOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAgc3RydWN0IGlteDhfcGNpZV9waHkg
ew0KPiA+ICAJdm9pZCBfX2lvbWVtCQkqYmFzZTsNCj4gPiAgCXN0cnVjdCBjbGsJCSpjbGs7DQo+
ID4gQEAgLTU1LDYgKzY1LDcgQEAgc3RydWN0IGlteDhfcGNpZV9waHkgew0KPiA+ICAJdTMyCQkJ
dHhfZGVlbXBoX2dlbjE7DQo+ID4gIAl1MzIJCQl0eF9kZWVtcGhfZ2VuMjsNCj4gPiAgCWJvb2wJ
CQljbGtyZXFfdW51c2VkOw0KPiA+ICsJY29uc3Qgc3RydWN0IGlteDhfcGNpZV9waHlfZHJ2ZGF0
YQkqZHJ2ZGF0YTsNCj4gPiAgfTsNCj4gPg0KPiA+ICBzdGF0aWMgaW50IGlteDhfcGNpZV9waHlf
aW5pdChzdHJ1Y3QgcGh5ICpwaHkpIEBAIC02NiwzMSArNzcsMTcgQEANCj4gPiBzdGF0aWMgaW50
IGlteDhfcGNpZV9waHlfaW5pdChzdHJ1Y3QgcGh5ICpwaHkpDQo+ID4gIAlyZXNldF9jb250cm9s
X2Fzc2VydChpbXg4X3BoeS0+cmVzZXQpOw0KPiA+DQo+ID4gIAlwYWRfbW9kZSA9IGlteDhfcGh5
LT5yZWZjbGtfcGFkX21vZGU7DQo+ID4gLQkvKiBTZXQgQVVYX0VOX09WRVJSSURFIDEnYjAsIHdo
ZW4gdGhlIENMS1JFUSMgaXNuJ3QgaG9va2VkICovDQo+ID4gLQlyZWdtYXBfdXBkYXRlX2JpdHMo
aW14OF9waHktPmlvbXV4Y19ncHIsIElPTVVYQ19HUFIxNCwNCj4gPiAtCQkJICAgSU1YOE1NX0dQ
Ul9QQ0lFX0FVWF9FTl9PVkVSUklERSwNCj4gPiAtCQkJICAgaW14OF9waHktPmNsa3JlcV91bnVz
ZWQgPw0KPiA+IC0JCQkgICAwIDogSU1YOE1NX0dQUl9QQ0lFX0FVWF9FTl9PVkVSUklERSk7DQo+
ID4gLQlyZWdtYXBfdXBkYXRlX2JpdHMoaW14OF9waHktPmlvbXV4Y19ncHIsIElPTVVYQ19HUFIx
NCwNCj4gPiAtCQkJICAgSU1YOE1NX0dQUl9QQ0lFX0FVWF9FTiwNCj4gPiAtCQkJICAgSU1YOE1N
X0dQUl9QQ0lFX0FVWF9FTik7DQo+ID4gLQlyZWdtYXBfdXBkYXRlX2JpdHMoaW14OF9waHktPmlv
bXV4Y19ncHIsIElPTVVYQ19HUFIxNCwNCj4gPiAtCQkJICAgSU1YOE1NX0dQUl9QQ0lFX1BPV0VS
X09GRiwgMCk7DQo+ID4gLQlyZWdtYXBfdXBkYXRlX2JpdHMoaW14OF9waHktPmlvbXV4Y19ncHIs
IElPTVVYQ19HUFIxNCwNCj4gPiAtCQkJICAgSU1YOE1NX0dQUl9QQ0lFX1NTQ19FTiwgMCk7DQo+
ID4gLQ0KPiA+IC0JcmVnbWFwX3VwZGF0ZV9iaXRzKGlteDhfcGh5LT5pb211eGNfZ3ByLCBJT01V
WENfR1BSMTQsDQo+ID4gLQkJCSAgIElNWDhNTV9HUFJfUENJRV9SRUZfQ0xLX1NFTCwNCj4gPiAt
CQkJICAgcGFkX21vZGUgPT0gSU1YOF9QQ0lFX1JFRkNMS19QQURfSU5QVVQgPw0KPiA+IC0JCQkg
ICBJTVg4TU1fR1BSX1BDSUVfUkVGX0NMS19FWFQgOg0KPiA+IC0JCQkgICBJTVg4TU1fR1BSX1BD
SUVfUkVGX0NMS19QTEwpOw0KPiA+IC0JdXNsZWVwX3JhbmdlKDEwMCwgMjAwKTsNCj4gPiAtDQo+
ID4gLQkvKiBEbyB0aGUgUEhZIGNvbW1vbiBibG9jayByZXNldCAqLw0KPiA+IC0JcmVnbWFwX3Vw
ZGF0ZV9iaXRzKGlteDhfcGh5LT5pb211eGNfZ3ByLCBJT01VWENfR1BSMTQsDQo+ID4gLQkJCSAg
IElNWDhNTV9HUFJfUENJRV9DTU5fUlNULA0KPiA+IC0JCQkgICBJTVg4TU1fR1BSX1BDSUVfQ01O
X1JTVCk7DQo+ID4gLQl1c2xlZXBfcmFuZ2UoMjAwLCA1MDApOw0KPiA+ICsJc3dpdGNoIChpbXg4
X3BoeS0+ZHJ2ZGF0YS0+dmFyaWFudCkgew0KPiA+ICsJY2FzZSBJTVg4TU06DQo+ID4gKwkJLyog
VHVuZSBQSFkgZGUtZW1waGFzaXMgc2V0dGluZyB0byBwYXNzIFBDSWUgY29tcGxpYW5jZS4gKi8N
Cj4gPiArCQlpZiAoaW14OF9waHktPnR4X2RlZW1waF9nZW4xKQ0KPiA+ICsJCQl3cml0ZWwoaW14
OF9waHktPnR4X2RlZW1waF9nZW4xLA0KPiA+ICsJCQkgICAgICAgaW14OF9waHktPmJhc2UgKyBQ
Q0lFX1BIWV9UUlNWX1JFRzUpOw0KPiA+ICsJCWlmIChpbXg4X3BoeS0+dHhfZGVlbXBoX2dlbjIp
DQo+ID4gKwkJCXdyaXRlbChpbXg4X3BoeS0+dHhfZGVlbXBoX2dlbjIsDQo+ID4gKwkJCSAgICAg
ICBpbXg4X3BoeS0+YmFzZSArIFBDSUVfUEhZX1RSU1ZfUkVHNik7DQo+ID4gKwkJYnJlYWs7DQo+
ID4gKwl9DQo+IA0KPiBJZiB5b3Ugc2F5IG5vIGZ1bmN0aW9uYWwgY2hhbmdlIGludGVuZGVkLCBJ
J2QgZXhwZWN0IHRoYXQgcmVnaXN0ZXIgd3JpdGVzIGhhcHBlbg0KPiBpbiB0aGUgc2FtZSBzZXF1
ZW5jZS4gSXQgbWlnaHQgYmUgb2ssIHRoYXQgeW91IGRvIHRoaXMgdHVuaW5nIGhlcmUsIGJ1dCBJ
IHRoaW5rDQo+IGl0IHdhcnJhbnRzIGEgbWVudGlvbiBpbiB0aGUgY29tbWl0IG1lc3NhZ2Ugd2h5
IGl0J3Mgb2suDQo+IA0KPiANCj4gTG9va3MgZ29vZCBvdGhlcndpc2UuIFdpdGggbml0cGlja3Mg
YWRkcmVzc2VkOg0KPiANCj4gUmV2aWV3ZWQtYnk6IEFobWFkIEZhdG91bSA8YS5mYXRvdW1AcGVu
Z3V0cm9uaXguZGU+DQo+IA0KR290IHRoYXQsIHRoYW5rcyBhIGxvdC4NCg0KQmVzdCBSZWdhcmRz
DQpSaWNoYXJkIFpodQ0KPiANCj4gLS0NCj4gUGVuZ3V0cm9uaXggZS5LLiAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwNCj4gfA0KPiBTdGV1ZXJ3YWxkZXIgU3RyLiAyMSAgICAgICAgICAgICAg
ICAgICAgICAgfA0KPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2su
Y29tLz91cmw9aHR0cCUzQSUyRiUyRnd3dy5wZQ0KPiBuZ3V0cm9uaXguZGUlMkYmYW1wO2RhdGE9
MDUlN0MwMSU3Q2hvbmd4aW5nLnpodSU0MG54cC5jb20lN0MzZjc1DQo+IDY0M2FkMDNiNDA2ZGRm
YmYwOGRhYTJiZGQ4MDQlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNQ0KPiAlN0Mw
JTdDMCU3QzYzODAwMTIzMzUwMDMxNTI0NCU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXDQo+
IElqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2
TW4wJTNEJTdDMw0KPiAwMDAlN0MlN0MlN0MmYW1wO3NkYXRhPTZOUHNHTUJOOGN1bFQlMkJqSVd0
YXkwcVQwbzRMNjZsbm1PdFhJDQo+IDRmbzd6ME0lM0QmYW1wO3Jlc2VydmVkPTAgIHwNCj4gMzEx
MzcgSGlsZGVzaGVpbSwgR2VybWFueSAgICAgICAgICAgICAgICAgIHwgUGhvbmU6DQo+ICs0OS01
MTIxLTIwNjkxNy0wICAgIHwNCj4gQW10c2dlcmljaHQgSGlsZGVzaGVpbSwgSFJBIDI2ODYgICAg
ICAgICAgIHwgRmF4Og0KPiArNDktNTEyMS0yMDY5MTctNTU1NSB8DQo=
