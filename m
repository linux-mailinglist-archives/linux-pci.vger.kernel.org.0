Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F5362F2F7
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 11:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241514AbiKRKsC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 05:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241702AbiKRKsA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 05:48:00 -0500
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E463697F4
        for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2022 02:47:57 -0800 (PST)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2043.outbound.protection.outlook.com [104.47.22.43]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-RXMvd36KPxi-npg-21HSyA-1; Fri, 18 Nov 2022 11:47:54 +0100
X-MC-Unique: RXMvd36KPxi-npg-21HSyA-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZRAP278MB0142.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:13::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.9; Fri, 18 Nov 2022 10:47:52 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::98a2:d371:57e0:cc3]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::98a2:d371:57e0:cc3%9]) with mapi id 15.20.5834.009; Fri, 18 Nov 2022
 10:47:52 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "marex@denx.de" <marex@denx.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "richard.leitner@linux.dev" <richard.leitner@linux.dev>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH v2] soc: imx: imx8mp-blk-ctrl: Add PCIe SYSPLL
 configurations
Thread-Topic: [PATCH v2] soc: imx: imx8mp-blk-ctrl: Add PCIe SYSPLL
 configurations
Thread-Index: AQHY+vxoPOannHJiikmQ58K/x/rcB65EgHCA
Date:   Fri, 18 Nov 2022 10:47:52 +0000
Message-ID: <aacc40f4d8f727a8e1be97c094d1e391a8f72012.camel@toradex.com>
References: <1668740199-31956-1-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1668740199-31956-1-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZRAP278MB0142:EE_
x-ms-office365-filtering-correlation-id: 7cf43dc1-8bb0-4962-07e2-08dac95257f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: 6dNz9ngGuEsGMdWQxq92ZHqD0kzBnDFFC4dGmL14uonGSgC2KHtotvVv+9JNBZ1NUcnU9DwFYa6UDYTqsDwWMRiJyZ0galnLKNHhrGCaXvB0RTLx6QK1eKdGKwmH80/GLQcxlW68/an4XbqMTIa5UcMBB1eNYElF9wK77FW7Jmqf1eiYFAa+IRfZyBE5D2m0kyg1De/IqEDxUFKtsgRXwwSN1kJxrJGaJ+o4/LWHmelIjRhp6M5Y3EiZgAcBxWed3yqN35S9bpPjoqIVQSFfgBZxyRnMMcDR1o7uBNJmtAIavrrTm4zyqMXWdqD9Vmb9eJRoEHjlen00GO2aOHUV9jgKQSCvnpWNr/GJzX7yK/lRbjByAaG1OFfVU57b7znyUPBSuSFTMTg4gve9GZrDfBPMtPXE2B8lFG7p2z05QkHxBpFdR/T0uiEPCxMfptafQCeNIg5UN09pwcLeTveMqOJUkzU7FgbEsabFEzAHKRZ0e1+RON9byW9YL24yg60ddParLSd6/1nf46hEinFMc2HJu6eFc094Syr2Rizh56npKJ5tlHKEHJwfYPOnyerWdSafhICX1KDwlmrIrdVpZ0YAMpP8erc9gS2dP8GOjLpfN15iEze2hRMyRCp7U7S8iQsXNlccRRl+fPDyMk96Iaa5XeVz5xWGS0IS+CvRKci2TNxp8hOtJb7CGQkNP4MpZ534di+3U+ZfpLP4IwaAJh5Um7w8+21GFuQNTVEUYiVeaigDUNY5fKuyJBqfBGV+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39850400004)(136003)(376002)(366004)(451199015)(54906003)(110136005)(316002)(4326008)(64756008)(8676002)(6512007)(478600001)(966005)(6486002)(66946007)(66556008)(6506007)(71200400001)(66446008)(76116006)(66476007)(186003)(5660300002)(7416002)(41300700001)(8936002)(2616005)(44832011)(36756003)(2906002)(4001150100001)(83380400001)(86362001)(38100700002)(38070700005)(122000001)(32563001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTdGMlZraTZqazlEZ2xDcXRwVko3Rmx2UFBiSkVBSmhUcEp3SXJtVnpFMmhP?=
 =?utf-8?B?UlBZdlprNUdYM1BoeGhWU0J0TzhIVXhHNlZ3YS9GVVBaVGVTYUZXdGpvZTl0?=
 =?utf-8?B?OUlyYjJOdnZFM1hFY1JCS0NCaytQQmxVWldYc2Y4cWZXbDA0TGZ0VlpSaWFs?=
 =?utf-8?B?V05zOXdvNVRZYUNsaUdLRVlEUGdrMXpTSTkyeWVSQytyVDRzcDExU2V4cWhR?=
 =?utf-8?B?bU04Vk9ZN1EzbWdtcFN4MlB4amVMRjlHUDJrMzc5VkJmeGlTWjQyQWVmR3Ix?=
 =?utf-8?B?dHYraDNQUEFLNkdQbGJ4azRsMGhZRHZGNXZEQ0YweG5JU1Q2WmIrSkJuUUM5?=
 =?utf-8?B?R0xPMUJVRDNJb3JLS3p4cmZyV2dvRlV0Z3lFeUwwNWN5cDhUOW1NY2g5UkhT?=
 =?utf-8?B?bzByM2dXOEhSL3VzV3VuMTFoNlBRMDA1VHJ1TTBGZjNwd1Y5Qm9qT2tTdG5H?=
 =?utf-8?B?UmFESFBCMkhTakNkdmdmaTNsVERzRW95bmRZY1dwbVl4UFU5Nm9aZGlUbFVP?=
 =?utf-8?B?bDFTVTZFY1lMTk5kVEduSE1Wd3hxVHdhSEZBdFZERjFPSG16Qy92Ymcwd1pL?=
 =?utf-8?B?bkZHaEdIemdvK0lLZkQxbS9xNWxVTWN1eWpjYnJ5SE0rb1NDTGVNN2x0Q3Zw?=
 =?utf-8?B?LzM0Q1VOM1BpNkNZVWFLZm5GTEoxZWx3elgrS1l4ODIwMGtTTG1sTWR5Zm0x?=
 =?utf-8?B?bVYvSmk3ZUQ5clRvdmkwdU5VTnZJNDhXWUY5OTZQaDdCRWFYT3ZkOXBZZWtM?=
 =?utf-8?B?QzVMR0VqY2FRcTU4V1NqTzVWWDh2VWVQUWtiN3ZCc2V3VUgzeGtvRVBPVy84?=
 =?utf-8?B?Y3NJd2pxeEdDTGM3WENuejlwZjMrVGZmenFBQ3gzV29hakVuMlJhbm9Yanl0?=
 =?utf-8?B?UWw5MEdkalYybi8xVC8xSFlBekFNVHluek4yRnB5WGx0T2haQ09uN3FnQ2Vi?=
 =?utf-8?B?dHo1N1hSODVDSHhoL3VjaU00cXViamRiOHZpbS9lOFJJNm9TWVF1K0NSOE9t?=
 =?utf-8?B?OElxSG9tUTYvU1QycFRmMUp0QmIxN3ZKWXFwdkprcDkvM3VZa1RUQnVISjVJ?=
 =?utf-8?B?Q01EZ1dua1BRdmxOQkIxblVGeXpnQUY1QjRBYlpyTkZrcjhVY1RVRUQ0bzVl?=
 =?utf-8?B?MTlzdnoxOVFoaWJ1cG1TNXFaelo5M3gzTDlVTGo2dVlWVTE4azhXc3hvelJT?=
 =?utf-8?B?c0ozNTZuVHlqWitwRzg0YzNKdUdSeFFvejdNNzlJU3Z2K1k4RFhRY2NBZmtW?=
 =?utf-8?B?RXJsbVU4NjgrTWtRY25ZQ2VJMnByNGdWdTR6OVMxdHlieDA0dEc0UDJiTG5v?=
 =?utf-8?B?YXRPNmR3eDd0L3FxOWFHQ0dOZGthOEpsTUJrY1NaaWpHNjBUbjk1WHp6ejda?=
 =?utf-8?B?c2NjcjhRZ0JHSzZhYjV3K1ZRVGpnbU9YWDhOSVd2RnVzWFEzM3ZyK3hCcE9x?=
 =?utf-8?B?ZC9LRHZlRzA0RFM2MFNnYnVlZUkvSWNZdUhteFpUNGpkSzZjNy9rdmlYWmpP?=
 =?utf-8?B?eUkwa2FxWmdtUFBtYStoK3ZVay9ZeHZUTk01VjUyaCtDSjFkd3BtR09LampT?=
 =?utf-8?B?NG1IeEFwWkVuYkZnTkllazRoc0FYbEdLWHNHbEo2TzhSV0VKRm81cVR5LzUw?=
 =?utf-8?B?c01PU3lyaG55TmhENnl4V0YxTUxxVFN5Z3BScTBUU3JlVldBVE1tdlQyS3JE?=
 =?utf-8?B?VmZsZk5IWHlmWE9ucFFvT3JsWG9mZU85blpncnk1SCtBeXZmS2RILzRvNkdN?=
 =?utf-8?B?V0dWankxalRuU2NFenIrYk5SdjhpMU5vQTJRQTMzTkNTOFFpTk1WWFB3YkJH?=
 =?utf-8?B?RmlNSkgvbUdVUm5OcThuVlY3d2FaenpKZitOOGxYWlFOSjdFUkt6TEVxK25u?=
 =?utf-8?B?ZWJLNnBOVExaSm5WQ3FXTkFiVGhnZERzTk5DYzEyL0ZTVm9lMUNNT3ducWd0?=
 =?utf-8?B?dkhGYjJHQ3dJZ1cvbVg0QkRRdFNjckVKYndpUnZNY0FwWEN2ZGlSc1NXZWpP?=
 =?utf-8?B?T1QvY1pxVkRmdHpWNlV6NmVTVjIzVEFyUHBTYmp5QXJoR2crcmdNWVhaQ09l?=
 =?utf-8?B?cEo5OWs3aS9mL1JwU2J6OWs4YzM1eUo0OWY4YWFaRE1oYS9RNFV2UmNDYlBo?=
 =?utf-8?B?VVQ1MExERmpjVjZoM09NR2JaQ0FvS1oyMXpUMVBHYXRoa2czMzJVQUNla1lH?=
 =?utf-8?Q?3OmRfvmegd6lgEySieMlQMUOMlKXDbsE59LFfs5zRWE7?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf43dc1-8bb0-4962-07e2-08dac95257f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 10:47:52.6276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m0orVZ7XH5T0NkftjW4PyANxpKOggnQM/CtukY4YhUVP+KCBDeotiDCDwkPhYUy63lJHbOJCdaHyHenFTBOguEXRbUEcrAbeGnzObDLoqiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0142
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <A065B3F9B1EA8145AEEE26B17D2C911F@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUmljaGFyZAoKT24gRnJpLCAyMDIyLTExLTE4IGF0IDEwOjU2ICswODAwLCBSaWNoYXJkIFpo
dSB3cm90ZToKPiBBZGQgUENJZSBTWVNQTEwgY29uZmlndXJhdGlvbnMsIHRodXMgdGhlIGludGVy
bmFsIFNZU1BMTCBjYW4gYmUgdXNlZCBhcwo+IGkuTVg4TVAgUENJZSByZWZlcmVuY2UgY2xvY2su
Cj4gCj4gVGhlIGZvbGxvd2luZyBwcm9wZXJ0aWVzIG9mIFBIWSBkdHMgbm9kZSBzaG91bGQgYmUg
Y2hhbmdlZCBhY2NvcmRpbmdseS4KPiDCoCAtIFNldCAnZnNsLHJlZmNsay1wYWQtbW9kZScgYXMg
JzxJTVg4X1BDSUVfUkVGQ0xLX1BBRF9PVVRQVVQ+Jy4KPiDCoCAtIENoYW5nZSAnY2xvY2tzJyB0
byAnPCZjbGsgSU1YOE1QX0NMS19IU0lPX0FYST4nLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFJpY2hh
cmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4KClRlc3RlZC1ieTogTWFyY2VsIFppc3dpbGVy
IDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+CgpUaGlzIHdvcmtzIHBlcmZlY3RseSBmaW5l
IG9uIFZlcmRpbiBpTVg4TSBQbHVzIGFzIHdlbGwuIEkgd2lsbCB1cGRhdGUgbXkgcHJldmlvdXMg
UENJZS1lbmFibGVtZW50IGNvbW1pdAooZGV2aWNlIHRyZWUgcGFydCkgaW4gdGhhdCByZXNwZWN0
IGFuZCAocmUtKXN1Ym1pdCBpdC4KClRoYW5rcyEKCkNoZWVycwoKTWFyY2VsCgo+IC0tLQo+IHYx
LT52MjoKPiBSZWZlciB0byBMdWNhcycgY29tbWVudHMsIGRvbid0IGV4cG9zZSBJTVg4TVBfQ0xL
X0hTSU9fUk9PVCB0byBkdHMgbm9kZS4KPiBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3By
b2plY3QvbGludXgtcGNpL3BhdGNoLzE2NjY1OTAxODktMTM2NC0xLWdpdC1zZW5kLWVtYWlsLWhv
bmd4aW5nLnpodUBueHAuY29tLwo+IAo+IFVzZSA8JmNsayBJTVg4TVBfQ0xLX0hTSU9fQVhJPiBh
cyByZWZlcnJlbmNlIGNsb2NrIHNvdXJjZSB3aGVuIGludGVybmFsCj4gY2xvY2sgbW9kZSBpcyB1
c2VkIGJ5IGkuTVg4TVAgUENJZSBtb2R1bGUuCj4gCj4gVmVyaWZpZWQgb24gaS5NWDhNUCBFVksg
Ym9hcmQgd2l0aCByZW1vdmluZyBSMTMxL1IxMzIvUjEzNy9SMTM4LCBhbmQKPiBwb3B1bGF0aW5n
IFIxMzUvUjEzNi4KPiAtLS0KPiDCoGRyaXZlcnMvc29jL2lteC9pbXg4bXAtYmxrLWN0cmwuYyB8
IDIyICsrKysrKysrKysrKysrKysrKysrKysKPiDCoDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRp
b25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL2lteC9pbXg4bXAtYmxrLWN0cmwu
YyBiL2RyaXZlcnMvc29jL2lteC9pbXg4bXAtYmxrLWN0cmwuYwo+IGluZGV4IDBlM2I2YmEyMmY5
NC4uNWFkMjBhOGVhMjVlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvc29jL2lteC9pbXg4bXAtYmxr
LWN0cmwuYwo+ICsrKyBiL2RyaXZlcnMvc29jL2lteC9pbXg4bXAtYmxrLWN0cmwuYwo+IEBAIC0y
MSw2ICsyMSwxNiBAQAo+IMKgI2RlZmluZcKgIFVTQl9DTE9DS19NT0RVTEVfRU7CoMKgwqBCSVQo
MSkKPiDCoCNkZWZpbmXCoCBQQ0lFX1BIWV9BUEJfUlNUwqDCoMKgwqDCoMKgQklUKDQpCj4gwqAj
ZGVmaW5lwqAgUENJRV9QSFlfSU5JVF9SU1TCoMKgwqDCoMKgQklUKDUpCj4gKyNkZWZpbmUgR1BS
X1JFRzLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAweDgKPiArI2RlZmluZcKgIFBfUExM
X01BU0vCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBHRU5NQVNLKDUsIDApCj4gKyNkZWZpbmXCoCBN
X1BMTF9NQVNLwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgR0VOTUFTSygxNSwgNikKPiArI2RlZmlu
ZcKgIFNfUExMX01BU0vCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBHRU5NQVNLKDE4LCAxNikKPiAr
I2RlZmluZcKgIFBfUExMwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCgweGMgPDwg
MCkKPiArI2RlZmluZcKgIE1fUExMwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCgw
eDMyMCA8PCA2KQo+ICsjZGVmaW5lwqAgU19QTEzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgKDB4NCA8PCAxNikKPiArI2RlZmluZSBHUFJfUkVHM8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoDB4Ywo+ICsjZGVmaW5lwqAgUExMX0NLRcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoEJJVCgxNykKPiArI2RlZmluZcKgIFBMTF9SU1TCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBCSVQoMzEpCj4gwqAKPiDCoHN0cnVjdCBpbXg4bXBfYmxrX2N0cmxfZG9tYWluOwo+
IMKgCj4gQEAgLTg2LDYgKzk2LDE4IEBAIHN0YXRpYyB2b2lkIGlteDhtcF9oc2lvX2Jsa19jdHJs
X3Bvd2VyX29uKHN0cnVjdCBpbXg4bXBfYmxrX2N0cmwgKmJjLAo+IMKgwqDCoMKgwqDCoMKgwqBj
YXNlIElNWDhNUF9IU0lPQkxLX1BEX1BDSUVfUEhZOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmVnbWFwX3NldF9iaXRzKGJjLT5yZWdtYXAsIEdQUl9SRUcwLAo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBQ
Q0lFX1BIWV9BUEJfUlNUIHwgUENJRV9QSFlfSU5JVF9SU1QpOwo+ICsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgLyogU2V0IHRoZSBQTEwgY29uZmlndXJhdGlvbnMsIFAgPSAxMiwg
TSA9IDgwMCwgUyA9IDQuICovCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZ21h
cF91cGRhdGVfYml0cyhiYy0+cmVnbWFwLCBHUFJfUkVHMiwKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFBfUExMX01B
U0sgfCBNX1BMTF9NQVNLIHwgU19QTExfTUFTSywKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFBfUExMIHwgTV9QTEwg
fCBTX1BMTCk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHVkZWxheSgxKTsKPiAr
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZ21hcF91cGRhdGVfYml0cyhiYy0+
cmVnbWFwLCBHUFJfUkVHMywgUExMX1JTVCwgUExMX1JTVCk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHVkZWxheSgxMCk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAvKiBTZXQgMWInMSB0byBwbGxfY2tlIG9mIEdQUl9SRUczICovCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHJlZ21hcF91cGRhdGVfYml0cyhiYy0+cmVnbWFwLCBHUFJfUkVH
MywgUExMX0NLRSwgUExMX0NLRSk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBi
cmVhazsKPiDCoMKgwqDCoMKgwqDCoMKgZGVmYXVsdDoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGJyZWFrOwo=

