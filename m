Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC074B03DD
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 04:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbiBJDXV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 22:23:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiBJDXV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 22:23:21 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80080.outbound.protection.outlook.com [40.107.8.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC02B205F1;
        Wed,  9 Feb 2022 19:23:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEEzecCPzK0aW7LJbyMzogbHpD9uXGFOOopAmyp5w8nQeZ8fHOktRN655SOyPfAxC6zDtO47LxvLKL7Jw3NT0V6VmCSspctH9lipac3dQog//3cgcwXnklat4PtMbSbJ2li0RBl9M870bnsV3Pg27Jw0rKKP0xBEGOX+D6aTCmF7akIaBpKiwXjL8ZKLzRljBYoor6tMqEI2HHyMmnSG4qmBzJmmEdLOrQ5sdlM6kZqBBbYYJQMsx3D+TCs4EJr3mzBlR90mK1XpeoQVGAE/g2PIE0z73Anpe2GMpSIiQjctOmt/xZXfRV+ayaz1L465KSzBYfL4kV0v8ATPwic86w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZJDqwbh9xEz5WV+xH5ExmdHy1BUQrl4lNGW/o+xkwQ=;
 b=PD5Sat4A5Sa4wt+VXzzZktwlwxpCisec1tf+zgwhk+OEpWx0wWhly6k0eS/XsWmW18NpSaB494R/XDNl6bCJaoWyMfin8X5rQ3m92wXkruoEQqB4SACMVvz2xA4PKr8OBGLCRfzTLUmWSPlSJxSzBG98kLsgVVQvpAESfNvKj8fGpoW5PyvCxxcRvsfKsZR0WFeG8XgLXXc0IwwHs7xLpURECy4zjlxokfQuZn1FpwUGCdngIHp2iPLVz+U46x+yn6WaYXiIV1fWGfOHIm4tlv97lY269QiF3LS0XzIpyKeouJ++Ze4iFxC/qhDu5ooysaIjESIx4Md8gnqVdIj7MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZJDqwbh9xEz5WV+xH5ExmdHy1BUQrl4lNGW/o+xkwQ=;
 b=GXb7TOUKTGRkQLOijKaiaoBJH6SXqOemtnNOvk26Lt5/ik68/SpPcoGyB7WMX+rLF69OkwFsnQwWSxlxv+RwnyULVwHJ3k1cOFxJ05xVkSlHwXblI38M7hMbDYqowNUYlX4GNO/3MFNiR2Beew9xb8kUlBhUonNCxd9NoSvA5fM=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM6PR04MB4054.eurprd04.prod.outlook.com (2603:10a6:209:49::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 03:23:20 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199%4]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 03:23:20 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [RFC 2/2] PCI: imx6: Enable imx6qp pcie power management support
Thread-Topic: [RFC 2/2] PCI: imx6: Enable imx6qp pcie power management support
Thread-Index: AQHYHYduLICm7+FWyEagAyZved6iF6yLWpYAgACtzBA=
Date:   Thu, 10 Feb 2022 03:23:19 +0000
Message-ID: <AS8PR04MB867616CDC587BB93772AC8588C2F9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1644390156-5940-2-git-send-email-hongxing.zhu@nxp.com>
 <20220209153636.GA557361@bhelgaas>
In-Reply-To: <20220209153636.GA557361@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b83b76f-28bc-4580-fb83-08d9ec44afc5
x-ms-traffictypediagnostic: AM6PR04MB4054:EE_
x-microsoft-antispam-prvs: <AM6PR04MB40544384176E43FBBFB13D258C2F9@AM6PR04MB4054.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zOIzOqU2Xs3l0CZfpjbNQbzJzqpr3X7yQrlff2H5cxb9MF6O1ODVAgvBY3Dw//s6geXlOJhIoklHBErHvEuB+NS6lVsNNAdPfPKfH9etBduA9VlMjPZowkPgEi5LLs5VBoS+U5qtJud+7zfSq2Wbx1TweRAS1qUZJSwGofNNZRSzixXV23oRlVIa9sG/oxKfGhVAQXcmXjsVPTLb05FlxU2O3f4WjtiANrZBOlZKRkfLck46v3rKGbueKAhJNeuFuEfms46l17jYEXcSt5JsHU5lghjAiCMzna2NBPljLc7f4VbMzU0yoXdRfGc22LI85671lOY5aE6OLCxcW5A6MbdZmG+6qY4v353CE18T7n5YfXkSWzhzD2Hn8CxMsY7Ym+iskPAuc03WMQuhJD5QJcqXcXr26Z5UBnvKbFQO9tDVPUJ25O6FkZoYpRUVJVyUSZ/VZwXgnwCI0V5ChEvmJop+uzQIoFHorAekyL9XASMHmLN/6TNazguNeR9cKFuiOJn3kPSnZDQaDne2lAdD7QxzeDGoXg2zpZKx1oGQLSu2CWhW856BaEAuX8cljmYcySvTe0ghCZZao6idvwlGKcdX6Rb4cZbDI+0B+xci0y5ZbfJEpeOCvHEEFe9HH4TJjp7fbeASCPmMh0jPY+sljRf4xm0tsUDCYGYgiuxMuZw8WqdKRYRdKctERErDpvT3jSeRQS+3UBJGhAvrp3NQlxMKuFdwDUV3S6AlqGce+R4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(44832011)(6506007)(38100700002)(2906002)(508600001)(38070700005)(66946007)(76116006)(66556008)(66476007)(66446008)(122000001)(4326008)(64756008)(8676002)(33656002)(86362001)(52536014)(5660300002)(6916009)(316002)(54906003)(7696005)(83380400001)(26005)(186003)(53546011)(55016003)(9686003)(71200400001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?NXdDZXN4VkhNUEFwSU1YWVpxcHpBRXQvY0I1dWZ0VG9XMEczeFdlSE1tY3V3?=
 =?gb2312?B?YTJxMDdBR0I3RmlqWWh2QlZYWUhxTTBFSU9kdGhIVXVrdTJWdXhtOENlSzZE?=
 =?gb2312?B?WnV3MmwrUTNBVitLZ1hIR1ZIQ0cwZzY4bDY4aUpNenhMWHBGbDlrZnUvN0M2?=
 =?gb2312?B?Ykt6cU5uS29Tb1JzcGpPZG9CMlI2ZVJzYS9zdnZRd29kVHZsRVBVUEVicGNo?=
 =?gb2312?B?N3V2VVozTXcwdWlaSktWeDVqQXBHQVM5OUVnNk1wRm5XQmc0bGExVUNrR1o1?=
 =?gb2312?B?ZWJWTnV3TXMyTzN5ajlUSU53cm5adlV6UDNJQjNqRXhuRVdkbTFuaUVJR2JS?=
 =?gb2312?B?RDRyWXRUSVp5bjIzbURpMDEwYjhoM1I3d1BKNDI5aXR6U3lMUjZReWZra0ZO?=
 =?gb2312?B?N3U4V3lSMVRoOHhnZkNaUWhNRzUxUC9jMGpIUDFlM0ZPdEtzSTh5b2J5dGF2?=
 =?gb2312?B?WU9nLytxdDRsdFNFakxhejdpZUQrMEVVdWRYQWVBQjUzcWZ6bUwycGRkdUlW?=
 =?gb2312?B?ci9RNC9mM3NzZmlUeTg0cStkUHFmMldYUXhEYTRJK0hPVTQveEFySHZsMGY1?=
 =?gb2312?B?ZUNZd0lVc09qb0tTRXpmWExUejkzOXM0aFJSQzNyNnpkSWk0U3Y0WGF4eE1l?=
 =?gb2312?B?cit4RHJUM2JhT2IvbEJyNm1iRklia09iSm1TY3pVWENPdXBVaG52akUraG9y?=
 =?gb2312?B?WEZ1ZXY5M0RFMmcxSmhwMXdZb3FZM3VNT2JsVFJ0OVd6TFc2S3NiUVo0N0Vu?=
 =?gb2312?B?d1F6NitZZEVQK1hQaUpaTWFCRTZSVEROeVc2SVM4dXV3NkJRMFpXSGdMaFZC?=
 =?gb2312?B?cVQ1ZE4xTXZqUmtvUDVVem1ZeUFzckJCTGFDUEJPRXdRNUw4bFBsY0F0ZmJs?=
 =?gb2312?B?ZGdZOFdKZHZOOHE2dEZTZEplNjFsbk10ZFVja081VUh0RmYxU1JhdEpKL1d0?=
 =?gb2312?B?eE1RQXc4T1BUczFyd1BQb0NwLzFuK25XZ3JLKzI1Wi9ZWjhLRWVGVW0yRm41?=
 =?gb2312?B?TmtpS2dHRExlYXNDNS9QTFo3ZTZNTjJFVXZuUUg5czhTL2l0cEltTVVmRTNz?=
 =?gb2312?B?VEZPYlk3ZU9uR00xMlFJaWgyNlpOdEhLN0NJcFplc3VWRFpJcWZjVjNDZHhR?=
 =?gb2312?B?eWl3eG9LYUdKdkxBK3dOb2FnL1M3Q2MvSm5jV3ZaYWlFaTlrQWxCbHA1MFhC?=
 =?gb2312?B?dnJNaUJxWmJXZ2ZNOGhjbGFrSk10MHp4ck1iaVlxKzNtelkvRStHY2RLZEU1?=
 =?gb2312?B?U1dIWjFEdFRWSERWZ2ZhN1lES0xYWmMyL291VGtnSE05RG5IYVRhSG1FYy9a?=
 =?gb2312?B?dkFyRHBoU2ZXSmo4dkZieU5zN0xzUHRiZGtaTWgzTE00aHQ0R1hvVm81Yk9p?=
 =?gb2312?B?NkNIQnJ0YjhsNExMQlFLUjkyRjdFelYxTVRLaGJrREU4aFBLYkFWaks2S3NR?=
 =?gb2312?B?bEVjTTdHOXhKM09VMTl3MnRZWVlFTEwwK0NMMjk0WVkxSENRTEhZSmUwNlcw?=
 =?gb2312?B?RXhqL0ZTUkhsVE9RNHU3VmRvWTFrb0FONk1VOU1UL0dyQTBHWU5RbFhKZlFK?=
 =?gb2312?B?dFNmYWJBSGVwK3lwVWFSVE0xdDhDUjhxa2MrTGZFbXRJM3dMMldPNEN3dnhF?=
 =?gb2312?B?aCtkVTRIOGNvNDM2b3ZGQXNGaVg4VklZdVZhenRrYnVSYWdhc3ZQYmk1THRw?=
 =?gb2312?B?RTgzTEVyQllJM0FaQXZKcnVaRnprWDJDWUVPNjJJdWtESjlpdElETVh4Y2gy?=
 =?gb2312?B?MEZjS1RCS1dUd3o0d25yTHVaMi92WURlTk1XcU5maU9wZlh5YmI2TVFPV1Rs?=
 =?gb2312?B?M2JHV2V0MUVzUlg5Y0dBMGsxQW5rQTZLNk93YWlNVVVhNU1PUCtBeWlOVTNN?=
 =?gb2312?B?YmdLMDhiM2ZnY0dPYW9VRm8rK2lLWlpKaG9RVGFHMU1ydFhEeVNyMkJtQktK?=
 =?gb2312?B?dVozRkFSbmhIbGtWS0F6QUFlR2ZCb0t0OVhlamFpRUlJZ0hlRFRicWR1R0JY?=
 =?gb2312?B?UThVZVFxQlNCTHdYOHAwb0Y3M3FtQUtwb0QvTXg4djdkc0Zka3VJaXlSVVhH?=
 =?gb2312?B?OE93K1JOWHg4U1ZTckpsUXhHKzVJTXA0OU5SdWx0Vkc4RjN5TnJtMWlFVzhp?=
 =?gb2312?B?eXNOOEhFRDNJUFlVbDlYT0JUSmUyVFhEcmY5d0x6YmpkU1p3dFBHWWZxRzQw?=
 =?gb2312?B?Mmc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b83b76f-28bc-4580-fb83-08d9ec44afc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 03:23:19.9304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DfqiFHHuPDdNwm8/A9CuHF2MH6MyD4gNfS7sQIq4XyJ1ZD34i5RYFa22rDrlpVktjA1uZjT4lmvlal9syRc8NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4054
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
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jLUwjnI1SAyMzozNw0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9uaXgu
ZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IHNo
YXduZ3VvQGtlcm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyAyLzJdIFBDSTogaW14NjogRW5hYmxlIGlteDZxcCBw
Y2llIHBvd2VyIG1hbmFnZW1lbnQNCj4gc3VwcG9ydA0KPiANCj4gSW4gc3ViamVjdCwgcy9wY2ll
L1BDSWUvIG9yIHJlbW92ZSBpdCBhbHRvZ2V0aGVyLCBzaW5jZSBJIGRvbid0IHRoaW5rIGl0IGFk
ZHMNCj4gdXNlZnVsIGluZm9ybWF0aW9uLg0KPiANCj4gT24gV2VkLCBGZWIgMDksIDIwMjIgYXQg
MDM6MDI6MzZQTSArMDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gaS5NWDZRUCBQQ0llIHN1
cHBvcnRzIHRoZSBSRVNFVCBsb2dpYywgdGh1cyBpdCBjYW4gc3VwcG9ydCB0aGUgTDIgZXhpdA0K
PiA+IGJ5IHRoZSByZXNldCBtZWNoYW5pc20uDQo+ID4gRW5hYmxlIHRoZSBpLk1YNlFQIFBDSWUg
c3VzcGVuZC9yZXN1bWUgb3BlcmF0aW9ucyBzdXBwb3J0Lg0KPiANCj4gQWRkIGJsYW5rIGxpbmUg
YmV0d2VlbiBwYXJhZ3JhcGhzIG9yIHJld3JhcCBpbnRvIGEgc2luZ2xlIHBhcmFncmFwaC4NCkdv
dCB0aGF0LCB0aGFua3MuDQoNCj4gDQo+IFJld3JhcCB0byBmaWxsIDc1IGNvbHVtbnMuDQpPa2F5
LCB3b3VsZCBiZSBjaGFuZ2VkLg0KDQo+IA0KPiBXaGF0IGRvZXMgIkwyIGV4aXQgYnkgcmVzZXQg
bWVjaGFuaXNtIiBtZWFuPyAgSXMgdGhpcyBhbiBpLk1YNi1zcGVjaWZpYw0KPiB0aGluZz8gIElm
IG5vdCwgY2FuIHlvdSBwb2ludCBtZSB0byB0aGUgcmVsZXZhbnQgcGFydCBvZiB0aGUgUENJZSBz
cGVjPw0KTm8sIGl0J3Mgbm90IGkuTVg2IHNwZWNpZmljIHRoaW5nLiBpLk1YNlEvREwgZG9lc24n
dCBoYXZlIHRoZSBzZWxmLXJlc2V0IG1lY2hhbmlzbS4NClRodXMsIGl0IGNhbid0IHJlc2V0IGl0
c2VsZiB0byBhbiBpbml0aWFsaXplZCBzdGF0IHdoZW4gbGluayBleGl0IGZyb20gdGhlIEwyDQpv
ciBMMyBzdGF0cy4NCmkuTVg2UVAgUENJZSBoYXMgdGhlIHNlbGYtcmVzZXQgbWVjaGFuaXNtLCBh
bmQgaXQgY2FuIHJlc2V0IGl0c2VsZiB3aGVuIGxpbmsNCmV4aXQgZnJvbSBMMiBvciBMMyBzdGF0
cy4NClRoZSBjb21taXQgZGVzY3JpcHRpb24gbWlnaHQgbm90IGFjY3VyYXRlLg0KSG93IGFib3V0
IGNoYW5nZSB0aGVtIHRvICJpLk1YNlFQIFBDSWUgc3VwcG9ydHMgdGhlIFJFU0VUIGxvZ2ljLCB0
aHVzIGl0IGNhbg0KIHJlc2V0IGl0c2VsZiB0byB0aGUgaW5pdGlhbGl6ZWQgc3RhdCB3aGVuIGV4
aXQgZnJvbSBMMiBvciBMMyBzdGF0cy4iDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4g
DQo+IEJqb3JuDQo=
