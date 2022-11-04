Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F97E618D85
	for <lists+linux-pci@lfdr.de>; Fri,  4 Nov 2022 02:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKDBON (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 21:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiKDBOM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 21:14:12 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70071.outbound.protection.outlook.com [40.107.7.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37BB192B8;
        Thu,  3 Nov 2022 18:14:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awE94Jps2qTGlzFUFSPdXKajQFJZdob69X/1gmJ9K9/7d2dI5LHIIk+seUMg9qxC1lVjC4dooYqTRHEFu53pc83U3jZ9CntDKPxoDmFaqMf7tDCBymRHTwkvlTz83dnsYefseZYPLaFNVFcjyXJ2YnF/YVEW/t4k7FNpJQ04Lyp+QRXpmiOjzaEKyNUJhJQtnCzZDIMdsMss3wuRzye/F44TnCL6b2gM8mh8BMql09L6F8T3cIGO5OrnqQIitKa1ANbjvYghTxdHZZAmy8o1uvpSh/2M2PcxJb7SNt1NwmzDwMt31jgF++tGshpC6jwIbKmXw0R4MGA6LSrtYspzlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEp7kWkMvf/qWPI1+wFnCJFEUEI6x6Mti3maEmO0eFo=;
 b=dEaFmsY43JBQdmoOi3PtsGoTe+ZiBBW03/kLyOQGQq2U5Xtx4RS+Mk1yBOpmyf90kWXemgmeJ3w4r/sOvivGxRjwHXG8FwVBtdqbrXBC2xanuXhwikhwoto5DRMJQdU55ows9p2yW+RL30yP9fKIacadnW/aoUbgI31+Qto7GYy5kFhTj5rEtv+MIemDeHO0wQTM6kGusJ0Py2phMyKE2EL/fZjkcXHRFOtFxxJSiQe8DJLjtd5Ue8Kri8VBFe2neDcJfZ5eqVPaKg+bdvHBgcEIFYCJN9BwlnXKAudPMG2IzzwEQjTgElWS0OgfAhbGdwNwC2JjmqGGLOEj9BekRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEp7kWkMvf/qWPI1+wFnCJFEUEI6x6Mti3maEmO0eFo=;
 b=VFi8MV13iFGqqInUEkkHllpGwoWgmUBuUXm37zbaeE+t5SG7frUuAf5L6IxkydT7wK+pDoK+pnA4hNvKc/G2VGNJbAC2Kd23uzqhDID/dl9MGCb8Dh6zMIePsm4ip+/zjAOxZ1hK+e2gSD+CAqkYxuGO/aCovzATjDL/z5LrgEQ=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PR3PR04MB7257.eurprd04.prod.outlook.com (2603:10a6:102:93::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 01:14:08 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f135:ec2c:8528:d866]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f135:ec2c:8528:d866%9]) with mapi id 15.20.5769.021; Fri, 4 Nov 2022
 01:14:02 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v1] PCI: imx6: Keep the GPIO regulator always on
Thread-Topic: [PATCH v1] PCI: imx6: Keep the GPIO regulator always on
Thread-Index: AQHY702b+QfiU75Jy0iV08bNcaBQXq4s6e2AgAEMc3A=
Date:   Fri, 4 Nov 2022 01:14:01 +0000
Message-ID: <AS8PR04MB8676EF7960CAD0A7BA23DD188C3B9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1667455698-14578-1-git-send-email-hongxing.zhu@nxp.com>
 <8561d5ac952d39bf3d1923ca9e3fa651ab1bb531.camel@pengutronix.de>
In-Reply-To: <8561d5ac952d39bf3d1923ca9e3fa651ab1bb531.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|PR3PR04MB7257:EE_
x-ms-office365-filtering-correlation-id: 7cadd33f-df89-4e1a-0477-08dabe01dbe2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M/4k08mXAsFh/Wa6PWpmDQCXwl/4fBMMTPaWf77m/J41XgVRKoC2BNM9MTxW95cEO7UXTUuStAdmdC26/fBJ0ke2YYPH4Pkpcj9apllMsnMka9AOd14J2iDpVHPL8Z4Mq6CzAxF2zU07en5V0/sG8y/olrTT2JYGpOh3HETRO1CCGh+ysE2Gna96hymdunr5AfSb1sbEG1nzQSnI+ImSuystGZQAEob97FjE4y3ZusJeZGJ7j99tBNxBTuvi8hv3qkxABQYsvAa8TUHJyhviw4qtd1okkn/0SycMP9+LaIiHughUdk2qLvk1lgMU1A68FeUD0K07zNnA4EECN6mVHhrFbZIG+HYhN3D4myC1z2YxMVRDvI8YYRU18UiWStM32KWxMlY0Cl3gKT3+NLQpc6vzmJFqQPPnsN2ZdKxePzPs0SOaIey8lj1Fw+6LgbE1C9He0Jy1u4tWfkqbLpRfRNCPMQ7F/8NRKKC035uDGqGhj/OBCoW4Y1UJijB+b7sGIYTJgx70jbNv/wFctvGMHKEB6t+qCzHwWwbkE0hgX9LFu6eZhdbtAsOASDGxW+HrE3cZ11vuEz/4fPFnlCx20VSrxVq/M8r73U1RH5Rzazd1+FvtgVXLgm/JffxCLqxcJkA8ylcub80Ute7l8B/n+/NjNdasWU/Xkk4L7ryw9UQRdCfQrxT2hidJhNnBK0H7PopHDmFv3Wtj2SiSEb+bJyoS9xh2Hvklk2svH/jcdw4IAz7xmLm8oP6srxmKrP89NTWNomqG26kNS2dnOgHRNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199015)(8676002)(478600001)(76116006)(2906002)(64756008)(71200400001)(66556008)(66476007)(4326008)(66946007)(66446008)(52536014)(86362001)(5660300002)(33656002)(8936002)(122000001)(38100700002)(41300700001)(110136005)(55016003)(54906003)(316002)(44832011)(38070700005)(83380400001)(186003)(6506007)(7696005)(9686003)(26005)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFZtZGVDNGIwUkMwVVRyWXk5RE5QTnJCMGtwQmhCcW5IUmR0WGRNZktxZ3JL?=
 =?utf-8?B?TGdLbC9xU0svVFU5MjVDay92SHpzeWFxT2k0MVVJU2N6bllES3ZUUUwweER6?=
 =?utf-8?B?NlFJYUw0OFhIU3JYbFVIM21DYzhmVWZ2Q0c3YnBqR1hqR0VOb1E5ZUNtTnU3?=
 =?utf-8?B?NnBkL1RKSFhYaWZyM1NxUU0yTk9PQmhoaUZPYmp3QWp6bjNBT3dkWlR1Uk5B?=
 =?utf-8?B?SWs4QW04UVA3YmpqZjk4QmxwSXlaMmwvZjVydHZ4NUdicjFhRytNZ0ZsUWxK?=
 =?utf-8?B?TTVCWHBGcmUrQ20vbFBuQVhSZDFBdXFJS2swdzBjQ2RZQ1J5NHRUTzdmTCtm?=
 =?utf-8?B?YXFqOEl1TTB2bnZiKzhRRWNEcmR0QlhvcTJOL1hqcEtvQXVkZlBqWE1Sc0Ra?=
 =?utf-8?B?UXliOFFVSDI1L0xWU2VpSnRiMk1ua0RIbmZNL09STFBkdDk3dVVrOTkyMk9w?=
 =?utf-8?B?dmRESUVWWWxnTmVsdlIySWlmWDZXZk1DUEtJaTMwVWhwM0IrbFhheHBvZkhB?=
 =?utf-8?B?QzJMYjZSMklXaXZUSjVuTkI4MjRXa0pPL3Mxdm4yQXZlMm5xdWpHZ3lvdUhE?=
 =?utf-8?B?aVpoa2hLcWhJSHlQM0VqLzE0c2Q2dzZLek5jMXBzSmdYZlhhWGl1bWk2Mll5?=
 =?utf-8?B?aUxPeFBKenpOOXhZcFdpcDN3QVBLcDRib1VaVUdacmVMWENKUDFQQWhoQnVM?=
 =?utf-8?B?NjJ2OFhVU3lXaU10NEEvcEVTSndiWjVDL0t2U25yYVJkVFhuRGZNeXphQ3Rz?=
 =?utf-8?B?TEc4KzFIV0ROek1iZlZlYmoxZE1CR3UxRmkvbGFIMExLSWlHeWtieVFLMTZ0?=
 =?utf-8?B?ZWRpUlB5bytIOFgwM0JMTFRyZHVlRGVoNm9zamxoYVdKYkgzSWpOTmVRUzJM?=
 =?utf-8?B?R3VjdjgrQ2wvK2VVWUxLcmV3QStVSHpJT1YwalpxZ3NOa0NLV1VRREFJV201?=
 =?utf-8?B?ZDFqVFM5dTdPWHdyRmxKQitwdnUzTHpINmFCL1dtaXBCRE9FUDBKUUVPbERC?=
 =?utf-8?B?b3ZnME5BdmVFVHNxQm0xbm5SM2dOQ3MxbXJnSGRaREV4WjErMU1RZkIyRGJJ?=
 =?utf-8?B?WmJ2bEhlYUZ3NlpwTDBId2x3N1NUaCtKbHFFSHRjb0FyQVd2VDBma1VaS1h2?=
 =?utf-8?B?UDRCTGViQWRMbWZJMHJnS3l5ZmMwcFN4b2tqWktMMnJqVFVTcWczQ2p6MFNJ?=
 =?utf-8?B?ektlZm5BeFZ5VDNZa3RpeWJsUzE3MzRHaDV3UWsreHROTGROU0V6V2lKcDJl?=
 =?utf-8?B?WXdEa0EyWlVDU0lCc0pCQS8zd3U0RU5tTHRpcUluc2VpVXVFS1IxWVFSbVdE?=
 =?utf-8?B?V3hNUGVJMURuVVZJMFFpQ0llL0lYeHJESUh6b0k3RHZhNkhHTHcxUWVKTk5G?=
 =?utf-8?B?TlEyQTA0S2RseDdqS1JHTldkVWwzQ083K0oybFVsS0dPcUNnWlEyejBzWVp3?=
 =?utf-8?B?NGF0dENvOG9aNnhZbXVuUlJZdHVxWGZMTk9rVUlqMEhuZzcwOGNKNjF0aUlV?=
 =?utf-8?B?NStUM3hTQ2lGY2pHSTJ1bUhQRWlDbTRCYkxid2s4eUxtOVdVckJZSUJ0SHNR?=
 =?utf-8?B?Si9GZ2dMU2JDd3hDd1VJMUN1Z0tyc1MvbE9iOFhaZHBWNlVGdjh2VVREc0Y5?=
 =?utf-8?B?eEVONVRVYmpudXgrWk9FQklrWU1iSHB1elI0aWJ2eE5YZmg1RlliQTA2ZEZ1?=
 =?utf-8?B?UHpEdDVwTk55MGNTRTVNa2ZWSVZqb2tYTG00K0xWcm1zcTlSbSs2aHU2RGc3?=
 =?utf-8?B?WkVUYXJsbUNnYWRHUTk0aUtnOFVUQm5vSWlGNEE4a1hPbEprcHFYVkJWUjlS?=
 =?utf-8?B?eTZtQnY4cW8wT0tKZVVGL3NnZDg4TWgrMDc0ZWFMRTNsYlJBN1VpVW14OXpU?=
 =?utf-8?B?MHR5b2lLRzFFenU1bWhFR0Z5WUxTR2huUWJ1YmJMbDJKamMzRlN4a1BJMnoy?=
 =?utf-8?B?ZmpzUHViaTFWdExvRzVLNWg3SUlpTmJhbzdqa3d1ZEJ1enduck55M3RyZ09l?=
 =?utf-8?B?RFJNTW1tN1UwRCtEeHRTRGxwMXlLSjVDWEUzUHdoRG1qMkUvZWUrS2F6cDNH?=
 =?utf-8?B?MjZSejJRdC9wZTdBYzRFU3ZvV3J4QzQxdWl3WU1kTUM2NitJamZlc1ZLUStt?=
 =?utf-8?Q?MOfqirqJsHaJma3vHv0fauVCT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cadd33f-df89-4e1a-0477-08dabe01dbe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 01:14:01.9145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KC4f+jEFfRxxq0iL54O28Nt1xc7jpm4IzQJ3MsAKRyTEhtcAu+1rbtbNQGQWBSZ5FMdX580uNieeoDCM2UAmnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7257
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMuW5tDEx5pyIM+aXpSAxNzoxMg0KPiBUbzog
SG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IGJoZWxnYWFzQGdvb2dsZS5jb207
DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXgN
Cj4gPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxXSBQQ0k6IGlt
eDY6IEtlZXAgdGhlIEdQSU8gcmVndWxhdG9yIGFsd2F5cyBvbg0KPiANCj4gQW0gRG9ubmVyc3Rh
ZywgZGVtIDAzLjExLjIwMjIgdW0gMTQ6MDggKzA4MDAgc2NocmllYiBSaWNoYXJkIFpodToNCj4g
PiBTaW5jZSB2cGNpZSByZWd1bGF0b3IgaXMgb25lIEdQSU8gcmVndWxhdG9yLCB1c2VkIHRvIGNv
bnRyb2wgdGhlDQo+ID4gVlBDSWVfM1YzIGFuZCBwb3dlciB1cCByZW1vdGUgUENJZSBFUCBkZXZp
Y2UuDQo+ID4NCj4gPiBTb21lIFdJRkkgbW9kdWxlcyBsb2FkIHRoZWlyIGZpcm13YXJlIG9uY2Ug
aW4gcHJvYmUsIGFuZCBjYW4ndCBiZQ0KPiA+IHBvd2VyZWQgb2ZmIGR1cmluZyBzdXNwZW5kLiBP
dGhlcndpc2UsIHRoZXNlIFdJRkkgbW9kdWxlcyB3b3VsZG4ndCBiZQ0KPiA+IGZ1bmN0aW9uYWwg
YW55bW9yZSBhZnRlciByZXN1bWUgYmFjay4NCj4gDQo+IEkgd291bGQgY2FsbCB0aGlzIGEgYnVn
IGluIHRoZSBXaUZpIGRyaXZlci4NCj4gDQo+IEkgdGhpbmsgd2UgbmVlZCB0byB3YWxrIGRvd24g
dGhlIFBDSWUgaGllcmFyY2h5IHRvIHNlZSBpZiBpdCBpcyBzYWZlIHRvIGRpc2FibGUNCj4gdGhl
IFBDSWUgcmVndWxhdG9yLiBXaGVuIGFsbCBkZXZpY2VzIGluIHRoZSBoaWVyYXJjaHkgYXJlIGlu
IEQzaG90IHN0YXRlLCB3ZSBjYW4NCj4gc2FmZWx5IHB1dCB0aGUgd2hvbGUgaGllcmFyY2h5IGlu
dG8gRDNjb2xkIGJ5IHJlbW92aW5nIHBvd2VyLiBXaGVuIGFueSBvZg0KPiB0aGUgZGV2aWNlcyBj
b25uZWN0ZWQgdG8gdGhlICBSQyBhcmUgaW4gYSBzdGF0ZSBvdGhlciB0aGFuIEQzaG90LCB3ZSBu
ZWVkIHRvDQo+IGtlZXAgdGhlIHJlZ3VsYXRvciBlbmFibGVkLCBhcyB0aG9zZSBkZXZpY2VzIG1h
eSBuZWVkIHBvd2VyIGluIHN1c3BlbmQgdG8NCj4gaW1wbGVtZW50IHdha2V1cHMgb3Igb3RoZXIg
ZnVuY3Rpb25hbGl0eSB0aGF0IHNob3VsZCBiZSBhdmFpbGFibGUgZHVyaW5nDQo+IHN1c3BlbmQu
DQo+IA0KVW5kZXJzdG9vZCwgdGhhbmtzIGEgbG90Lg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQg
Wmh1DQoNCj4gUmVnYXJkcywNCj4gTHVjYXMNCj4gDQo+ID4NCj4gPiBTbywga2VlcCB0aGlzIHJl
Z3VsYXRvciBhbHdheXMgb24gaW4gdGhlIHByb2JlLg0KPiA+DQo+ID4gRml4ZXM6IGE0YmI3MjBl
ZWIxZSAoIlBDSTogaW14NjogVHVybiBvZmYgcmVndWxhdG9yIHdoZW4gc3lzdGVtIGlzIGluDQo+
ID4gc3VzcGVuZCBtb2RlIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hp
bmcuemh1QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaS1pbXg2LmMgfCAyNCArKysrKysrKy0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IGIvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IGluZGV4IDI2MTY1ODVjYTVmOC4u
OTRhODliYmYzODFkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaS1pbXg2LmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14
Ni5jDQo+ID4gQEAgLTkyNiwyMiArOTI2LDEzIEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX2hvc3Rf
aW5pdChzdHJ1Y3QgZHdfcGNpZV9ycA0KPiAqcHApDQo+ID4gIAlzdHJ1Y3QgaW14Nl9wY2llICpp
bXg2X3BjaWUgPSB0b19pbXg2X3BjaWUocGNpKTsNCj4gPiAgCWludCByZXQ7DQo+ID4NCj4gPiAt
CWlmIChpbXg2X3BjaWUtPnZwY2llKSB7DQo+ID4gLQkJcmV0ID0gcmVndWxhdG9yX2VuYWJsZShp
bXg2X3BjaWUtPnZwY2llKTsNCj4gPiAtCQlpZiAocmV0KSB7DQo+ID4gLQkJCWRldl9lcnIoZGV2
LCAiZmFpbGVkIHRvIGVuYWJsZSB2cGNpZSByZWd1bGF0b3I6ICVkXG4iLA0KPiA+IC0JCQkJcmV0
KTsNCj4gPiAtCQkJcmV0dXJuIHJldDsNCj4gPiAtCQl9DQo+ID4gLQl9DQo+ID4gLQ0KPiA+ICAJ
aW14Nl9wY2llX2Fzc2VydF9jb3JlX3Jlc2V0KGlteDZfcGNpZSk7DQo+ID4gIAlpbXg2X3BjaWVf
aW5pdF9waHkoaW14Nl9wY2llKTsNCj4gPg0KPiA+ICAJcmV0ID0gaW14Nl9wY2llX2Nsa19lbmFi
bGUoaW14Nl9wY2llKTsNCj4gPiAgCWlmIChyZXQpIHsNCj4gPiAgCQlkZXZfZXJyKGRldiwgInVu
YWJsZSB0byBlbmFibGUgcGNpZSBjbG9ja3M6ICVkXG4iLCByZXQpOw0KPiA+IC0JCWdvdG8gZXJy
X3JlZ19kaXNhYmxlOw0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gIAl9DQo+ID4NCj4gPiAgCWlm
IChpbXg2X3BjaWUtPnBoeSkgew0KPiA+IEBAIC05NzQsOSArOTY1LDYgQEAgc3RhdGljIGludCBp
bXg2X3BjaWVfaG9zdF9pbml0KHN0cnVjdCBkd19wY2llX3JwDQo+ICpwcCkNCj4gPiAgCQlwaHlf
ZXhpdChpbXg2X3BjaWUtPnBoeSk7DQo+ID4gIGVycl9jbGtfZGlzYWJsZToNCj4gPiAgCWlteDZf
cGNpZV9jbGtfZGlzYWJsZShpbXg2X3BjaWUpOw0KPiA+IC1lcnJfcmVnX2Rpc2FibGU6DQo+ID4g
LQlpZiAoaW14Nl9wY2llLT52cGNpZSkNCj4gPiAtCQlyZWd1bGF0b3JfZGlzYWJsZShpbXg2X3Bj
aWUtPnZwY2llKTsNCj4gPiAgCXJldHVybiByZXQ7DQo+ID4gIH0NCj4gPg0KPiA+IEBAIC05OTEs
OSArOTc5LDYgQEAgc3RhdGljIHZvaWQgaW14Nl9wY2llX2hvc3RfZXhpdChzdHJ1Y3QgZHdfcGNp
ZV9ycA0KPiAqcHApDQo+ID4gIAkJcGh5X2V4aXQoaW14Nl9wY2llLT5waHkpOw0KPiA+ICAJfQ0K
PiA+ICAJaW14Nl9wY2llX2Nsa19kaXNhYmxlKGlteDZfcGNpZSk7DQo+ID4gLQ0KPiA+IC0JaWYg
KGlteDZfcGNpZS0+dnBjaWUpDQo+ID4gLQkJcmVndWxhdG9yX2Rpc2FibGUoaW14Nl9wY2llLT52
cGNpZSk7DQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGR3X3BjaWVfaG9z
dF9vcHMgaW14Nl9wY2llX2hvc3Rfb3BzID0geyBAQA0KPiA+IC0xMjYzLDYgKzEyNDgsMTMgQEAg
c3RhdGljIGludCBpbXg2X3BjaWVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRl
dikNCj4gPiAgCQlpZiAoUFRSX0VSUihpbXg2X3BjaWUtPnZwY2llKSAhPSAtRU5PREVWKQ0KPiA+
ICAJCQlyZXR1cm4gUFRSX0VSUihpbXg2X3BjaWUtPnZwY2llKTsNCj4gPiAgCQlpbXg2X3BjaWUt
PnZwY2llID0gTlVMTDsNCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJcmV0ID0gcmVndWxhdG9yX2Vu
YWJsZShpbXg2X3BjaWUtPnZwY2llKTsNCj4gPiArCQlpZiAocmV0KSB7DQo+ID4gKwkJCWRldl9l
cnIoZGV2LCAiZmFpbGVkIHRvIGVuYWJsZSB2cGNpZSByZWd1bGF0b3I6ICVkXG4iLA0KPiA+ICsJ
CQkJcmV0KTsNCj4gPiArCQkJcmV0dXJuIHJldDsNCj4gPiArCQl9DQo+ID4gIAl9DQo+ID4NCj4g
PiAgCWlteDZfcGNpZS0+dnBoID0gZGV2bV9yZWd1bGF0b3JfZ2V0X29wdGlvbmFsKCZwZGV2LT5k
ZXYsICJ2cGgiKTsNCj4gDQoNCg==
