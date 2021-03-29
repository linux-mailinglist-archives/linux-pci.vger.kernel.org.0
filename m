Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78CB34C10B
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 03:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhC2BXd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Mar 2021 21:23:33 -0400
Received: from mail-eopbgr40057.outbound.protection.outlook.com ([40.107.4.57]:6642
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229645AbhC2BXJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 28 Mar 2021 21:23:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEHeseZhHQe+Igh/JAJDkiNjAXBjRYsc+N2mjwrHGcBARi6tzQm+/rYjMvT88wYmJFHi+wnPMSDK3oiOi3sVGpiI194ZkKoAWysw9zLZlDTwm6x/8MAFc5P7tHeaVgB+NA0MCVry1olMnnyFBglqGp3DCFhfKy+iuCsd5KtMaThIuJG/dEf4f8/iBjg/l/aEbo+4RMTCw1PCGMqm+vBzny5bwB0WYZ29RYEpbNQfDE0LYlCt40XRPJIPkvCFMceqUPEdFQBhu88GxPIHFVadtpzgOELyToD7SAiC3onwjBjTd0Xc8vP8Ykiv/QjFWJRjOoWFvOcnKOYEBboE8K2HBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8SjPshArWKszn0OK0dnVkiSHvmfnaBSCZNcFqVRJbg=;
 b=dqj3k1YZh/EylbSBUfnPLB7jKt+Y12pi2d99jFusGD1k3IxeBWBAZf0mPqrg2gwIOA4mSSXt/D8cLLp6qrf9uaLt/9u93I+evnkDICibL7qa0nLIAYiWXo8beAFoxUuJRcLFk/o4CPy7+8stIPSchtmUaIFcgVbD/jHNV7uM60t+QaD6VFMXjpy0OLgqCZtnUvonRpuxiju84vhrv5/M8A9C7AbWrzEQm9wavYloWM/95n8EXopSHbBDz313IcmZ+DBpIDAexGU0H73RC2sg5VKaw2+4tw0q58n8t3HvITycLemOgowLwOnddKfobijo88wg+R5RTYdeZh4EgmQohQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8SjPshArWKszn0OK0dnVkiSHvmfnaBSCZNcFqVRJbg=;
 b=kUh3WdMdiT5Ntd8XJEty53goWv56+8mIh3GAxOldc3GudlFY3Sjx/3yrepfnX1Pp/48+j20/oM5wiSARWhNGDu+TsK0lIMsCzJ9Kd7EBj7ymfgXFok3dwmaY1av+9WKu/sBetm+Pa2MoNWefQAXFCj1GqRoaz0NCQC+hdAzdOJ8=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Mon, 29 Mar
 2021 01:23:06 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::8116:97ef:2fd7:251f]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::8116:97ef:2fd7:251f%7]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 01:23:06 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: Re: [PATCH v3 2/3] arm64: dts: imx8mq-evk: add one regulator used
 to power up pcie phy
Thread-Topic: Re: [PATCH v3 2/3] arm64: dts: imx8mq-evk: add one regulator
 used to power up pcie phy
Thread-Index: AdckOSg8Q16M1R64S4e+DtU9wjRbPA==
Date:   Mon, 29 Mar 2021 01:23:06 +0000
Message-ID: <VI1PR04MB58537DC9AFC8A127AC8B4D458C7E9@VI1PR04MB5853.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ccc466b4-20e8-4d30-6dae-08d8f25134df
x-ms-traffictypediagnostic: VE1PR04MB6638:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB66389A9680CA1819BFDF4B938C7E9@VE1PR04MB6638.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3uyV19Kb31hTTR9557Q0jXFAC8/iILDloZUl/HpxP1Z2NERjdBbdlnKbB2Vm2vgbwJ9AWnbklOWVfIGh7wh7eNv7i62ivFKs0DfNAUgmxtq0AaRNLeBkYfzAwAP/y6psgl/PEFgPqrtE/q4bhiqPsPXJzmPFJTu4mYucRUS/AJZnLToOF9jOq5By6BHwN50ZD7ZIQrsF/aPxlpg5YWjkAP0gYA8oC56SjsWrcNwcvjyvbRXUZpTUIIqCsu/Jejl3eeNszHOPjhBlqCJmGRzdDAk2B1Q9FdMqwEcHDDaGP9fn53q2JNZAVaZYKGAC3ep4nfR9lxetrbDMjYY5r1WlgeInrCIfPBdpaKkFl4vdfzWXmgvI8K6QEhJ+FKAbItQH6/sHFfM7ToJ1tRKKu7PyldHzuolD0S8zheCDgplj/1sxk26nFVzPdXEKaPNpaiqiLSWmnTfnBBPLs0h22SHnuwfG0jcJHAuQrizz9lCXUQuz0Jz1MP+D4zknGY8OOjrAkvUuK0W4BXgdj5aRGizlQKLkoE8K0xkzm63Qf3oYIo8jDYiyBNXYl4mJQOTaoQo0ZYvxRu1aLGj/EHUEELtWMVAFvUSrA1NRM8Rx2KEWPzvn2uyeKA0nv15WOmIw61mnd7yj2V619lf/mzNIJt/aKr0W+e+CO6jeVBrs75flSC9u4cmsVrizpersNcxJ8/BX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(71200400001)(5660300002)(478600001)(4326008)(7416002)(9686003)(55016002)(186003)(7696005)(83380400001)(8676002)(53546011)(8936002)(6506007)(38100700001)(2906002)(66946007)(76116006)(66476007)(66556008)(64756008)(33656002)(54906003)(66446008)(110136005)(316002)(52536014)(26005)(86362001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dVdyZmdMR1l3VTNlaVNVMHpFRFVoMGhlS2YvdE80WkhoUzVXRGJjTTE2MHI2?=
 =?utf-8?B?QVBKa0FVTXFLeVhqeFBUaHFFNVhteHdENGxnZzh5anZ3V3pMWE5pbzBKU2VY?=
 =?utf-8?B?eG1pRStPKzhLTzVVZkxKNTdhclpSSmdxc0xLWnRFMDJZa0gwTjI5dGF0VGZV?=
 =?utf-8?B?TmhhQ1I0bHNXL3ZmalB6M0Fiak1PeHp3ZTA4WHhaTE5ROXd1K2ZZUGVObFZS?=
 =?utf-8?B?SFVIS2hiRDJsdGFSNHZodkxYcmJwWVE2aGYxQVJoQndiOUZJK3lYUWF5a0NF?=
 =?utf-8?B?WmhHcU1CdjdSZEV5NjJLVUFIM3VXR2RQM0tJSkhqcUtjQkltM3lRM3QydVlp?=
 =?utf-8?B?K3B6cDBjL1FUZDZScWQzN2xram9icVBxNnZaREFCdjE0TDVJL1ovdm4xdDV2?=
 =?utf-8?B?aGUxa3Zvck1lVkpkL2pBMnM3UVJqbW1ydVhiYitzS2NSVFQ1Y0hYdkRSK3lY?=
 =?utf-8?B?eHhGWXcrNmZtb0oxcFlwbzhpc0JXYy9mNFpaLzE0aE5WcEdrc2k4Ly9RZjF3?=
 =?utf-8?B?NnVWdkFkMXkyODg0dURBZDFyZ1NJZENQWEJrbnQ3cXJ6MThIWE9USnRhdVR5?=
 =?utf-8?B?WEMxZ1lKekdxWGlvT0RZNVV5WUNnVml6MUFqRVBjZys0Z29IWk5vWm9IUTlU?=
 =?utf-8?B?cFkwUjhPc3pGYzdCaUtyaWFEbXcwdm82Z1lmeHIvM2VvZVl0bUxadUx1ZlFy?=
 =?utf-8?B?YVhaamZUY3VSbk91eDRPSTMrUEVvRURsbHF5T3R4SFJkZWk3WGFGVGhkekdY?=
 =?utf-8?B?bWFiWlBieW1jQWxZM0VXOFJnT3JwQlUzQXgxLzlLUjEvOHdhWTRxTldrb212?=
 =?utf-8?B?WEM0QjZabGJHcDZmTHJ4YVF0L25NSTl0eGk1bjBMV2FwMjYrdHh6L3Bzd2Nz?=
 =?utf-8?B?VWMrdDZNUlQ1Rll2NE9leHlnUy9IWDd6c2M4aENIR280Q3gzZlBwZEd1TGlH?=
 =?utf-8?B?ZDhoNzBKbWtRQTJQTk9hY0YvSTd1cU1DNXRWRGxacVlkbk1zalJjZGp2bkY1?=
 =?utf-8?B?YThiNjNKS0cvNkQ4RDNWY2xYSCt1SFJaMW1tZW15S3ZYNVhncHY2bjFpWVBm?=
 =?utf-8?B?TUxRQlViS2FkUXVyMHBKQjBqN0I0OEhwcDUyVkVmOXlZa1B1Z2RJZFdrR09R?=
 =?utf-8?B?Z2V4bS9PNTVvZEt6NlJKWTltMklmUndQZng5ZGhVR0p6eGtwOThSTjY2YTlS?=
 =?utf-8?B?Vmx6eFNzcy9CMkxKVFdtblJuSzRjNEJvQ3BGTlBOUkJXcWVXaDFsanUxeUoz?=
 =?utf-8?B?bExQK011c216azRJcURpd3h4MjNXMTBpUE44T0dsM0RFbE9UQ3h5Mm51VEZ5?=
 =?utf-8?B?d0pZN1VoM202dzVhSmIzSDg4T012Y2Q4bGo5KzRqM2k5VExpQmg5b2txb3Rj?=
 =?utf-8?B?bXFBSmYzMlZKK3hCbFo1UXBwZHFybE9DY3NHaXQxZXFMUVltRzFmenRKY1NF?=
 =?utf-8?B?TmEwemtRMjlGOVl5d3lXaGJuNStTNkVoQk02YjBxeFBiNjhxNGRJRjI4Tmwx?=
 =?utf-8?B?d3d2Qkp6U280RmVLM3ZKR0ZDNG51cU1jaE0zMTVOTHZYQnF0OXJCSmNJMW1P?=
 =?utf-8?B?UkplMWFKRjdvcUxVMGRIK0lianl6QUFqc3k0ZXo3QVlSYytYaWZYMnE2eWp6?=
 =?utf-8?B?ZWVBc1NDQWdQelBqdmRPWDFNTXo5SUJOTHl6ejFZbU1wOWVmTDlxY09uNmRn?=
 =?utf-8?B?RVh4M1NRYjIzdkFkQVZVU3pOamVqVFE3MEVZT0tBOVdsZWFkNmljd2R4TGli?=
 =?utf-8?Q?XsofvrW5h2Yd6XX5nRR6SOsmXU1ee41WTn1EGsr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc466b4-20e8-4d30-6dae-08d8f25134df
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 01:23:06.5056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wLtQAUjOadIs08KhNJEVyfXNd5Jfez1NIKFWqvD8f4ODhkgGfhKF0dfdPWDCEhLq1NfGyQLLN8cRgGta1x6oTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6638
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogRnJpZGF5LCBNYXJjaCAyNiwgMjAyMSA1OjQwIFBN
DQo+IFRvOiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBhbmRyZXcuc21pcm5v
dkBnbWFpbC5jb207DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IGt3QGxpbnV4LmNvbTsgYmhlbGdh
YXNAZ29vZ2xlLmNvbTsNCj4gc3RlZmFuQGFnbmVyLmNoOyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0u
Y29tDQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4
LWlteEBueHAuY29tPjsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGUNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MyAyLzNdIGFybTY0OiBkdHM6IGlteDhtcS1ldms6IGFkZCBv
bmUgcmVndWxhdG9yDQo+IHVzZWQgdG8gcG93ZXIgdXAgcGNpZSBwaHkNCj4gQW0gRG9ubmVyc3Rh
ZywgZGVtIDI1LjAzLjIwMjEgdW0gMTY6NDQgKzA4MDAgc2NocmllYiBSaWNoYXJkIFpodToNCj4g
PiBCb3RoIDEuOHYgYW5kIDMuM3YgcG93ZXIgc3VwcGxpZXMgY2FuIGJlIHVzZWQgYnkgaS5NWDhN
USBQQ0llIFBIWS4NCj4gPiBJbiBkZWZhdWx0LCB0aGUgUENJRV9WUEggdm9sdGFnZSBpcyBzdWdn
ZXN0ZWQgdG8gYmUgMS44diByZWZlciB0byBkYXRhDQo+ID4gc2hlZXQuIFdoZW4gUENJRV9WUEgg
aXMgc3VwcGxpZWQgYnkgMy4zdiBpbiB0aGUgSFcgc2NoZW1hdGljIGRlc2lnbiwNCj4gPiB0aGUg
VlJFR19CWVBBU1MgYml0cyBvZiBHUFIgcmVnaXN0ZXJzIHNob3VsZCBiZSBjbGVhcmVkIGZyb20g
ZGVmYXVsdA0KPiA+IHZhbHVlIDFiJzEgdG8gMWInMC4gVGh1cywgdGhlIGludGVybmFsIDN2MyB0
byAxdjggdHJhbnNsYXRvciB3b3VsZCBiZQ0KPiA+IHR1cm5lZCBvbi4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gDQo+IFJldmll
d2VkLWJ5OiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4NCj4gDQo+IEkgZ3Vl
c3MgeW91IG5lZWQgdG8gc3BsaXQgdGhpcyBwYXRjaCBvdXQgb2YgdGhlIHNlcmllcyBhbmQgcG9z
dCBpdCBmb3IgU2hhd24gdG8NCj4gcGljayB1cCBpbnRvIHRoZSBpbXggRFQgdHJlZSwgYWZ0ZXIg
dGhlIG90aGVyIHR3byBwYXRjaGVzIG9mIHRoZSBzZXJpZXMgaGF2ZQ0KPiBiZWVuIGFjY2VwdGVk
IGludG8gdGhlIFBDSWUgdHJlZS4NCltSaWNoYXJkIFpodV0gU3VyZSBpdCBpcy4gU2hhd24gaGFk
IGJlZW4gaW5jbHVkZWQgaW4gdGhpcyByZXZpZXcgbG9vcC4NCldvdWxkIHNwbGl0IHRoaXMgcGF0
Y2ggb3V0IG9mIHRoaXMgc2V0LCBhbmQgcG9zdCBpdCBmb3IgU2hhd24gbG9uZWx5LCBhZnRlciB0
aGUgb3RoZXIgdHdvDQogUGF0Y2hlcyBhcmUgYWNjZXB0ZWQgaW50byB0aGUgUENJZSB0cmVlLg0K
PiANCj4gUmVnYXJkcywNCj4gTHVjYXMNCj4gDQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhtcS1ldmsuZHRzIHwgMSArDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2lteDhtcS1ldmsuZHRzDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4bXEtZXZrLmR0cw0KPiA+IGluZGV4IDg1YjA0NTI1M2EwZS4uNGQyMDM1ZTNk
ZDdjIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDht
cS1ldmsuZHRzDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1x
LWV2ay5kdHMNCj4gPiBAQCAtMzE4LDYgKzMxOCw3IEBADQo+ID4gICAgICAgICAgICAgICAgPCZj
bGsgSU1YOE1RX0NMS19QQ0lFMV9QSFk+LA0KPiA+ICAgICAgICAgICAgICAgIDwmcGNpZTBfcmVm
Y2xrPjsNCj4gPiAgICAgICBjbG9jay1uYW1lcyA9ICJwY2llIiwgInBjaWVfYXV4IiwgInBjaWVf
cGh5IiwgInBjaWVfYnVzIjsNCj4gPiArICAgICB2cGgtc3VwcGx5ID0gPCZ2Z2VuNV9yZWc+Ow0K
PiA+ICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4gPiAgfTsNCj4gPg0KPiA+DQo+ID4NCj4gPg0K
PiANCg0K
