Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769AB7617D3
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jul 2023 13:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjGYL61 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 07:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbjGYL6V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 07:58:21 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2109.outbound.protection.outlook.com [40.107.114.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701A01737;
        Tue, 25 Jul 2023 04:57:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9vcMkGmk6UyNWfRXqq8hiKX+wS7meVWfzaJFdt27/IegqKJrksoZnBObwwcIrbHGZaJ4zZ1zDZIG+QDt9L7jhUUTXjur9pqaUUSkBkSmTbJmuXPGl72lYYkeVped4yaFzxiDY1u1kdIvKmT4u+c5jpQ91O8pKJ1OigWO9flvCDglFoT3/8sJHgUhmTLHPJj5KHgBP4r2uQYbZ9QWM2M+7O7m0UoSlZSVR/vpKQdh39B9rXIQDXbuE9LpQrB/FkyrnyxL/DtN2HQZY1twKMDPB6+ZUOxLnDfoswc9s0PC7sraVFdx8zXitgeFPjRhP0nmibK2GeB2GzgGcpENuLoHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OStj8iaSnZ9IH/fO3NsXdzcybA8aEXcx/6KW6LGpZig=;
 b=SVgUCvD0RJwvKVh8OfBT6fS5zOLGSO0N5vkcJ4Ykl3aMqgQBsytwKZC1ykoO7KCUy/FNNStSTHERRf0nadnFsXOvFoZYmC7jDpTUxWC31p6cL06emnDNivOzJke53IGeG9SS755TlGHu6XDVQpZq3Fy5j1o37SeOy7N5Es+8o+UG8OGfNgLH4V1Xav5kRbOTa5KNf6lBN/0dDp+hFuNAWgpkMne2H7I6ngjzwVmMH9lW6nqf8O78bZi8JxTbAhXsK2/t4ehrJUTs6xED58WqpE1O/4K8uZ7JMPT7RWRBA1fz++bdX9woLZ5CGXsqpuInOumNue1hWXvtGg4bELmIeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OStj8iaSnZ9IH/fO3NsXdzcybA8aEXcx/6KW6LGpZig=;
 b=S7uD6pIJ3b46LWG4qhs0iq4QiVYtp37u9qTMS6IRMWgE2wqetE6Q9UvxD4Hl0ZSrFWW+SIDmrspWa5j+UjQnq1vPtNYj3h+3MOnPoQEd0jTWiu1Nk9vBqixpvOve/bqde82QoDT0hKdkyw+rUzxEWENzR4l5kD/2aaDNqh/M9Jk=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB8721.jpnprd01.prod.outlook.com
 (2603:1096:400:189::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 11:57:34 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 11:57:34 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v18 07/20] PCI: dwc: endpoint: Add multiple PFs support
 for dbi2
Thread-Topic: [PATCH v18 07/20] PCI: dwc: endpoint: Add multiple PFs support
 for dbi2
Thread-Index: AQHZu6dDjSUePTUsLESZ0DXx662VXa/IqhoAgAG2+NA=
Date:   Tue, 25 Jul 2023 11:57:34 +0000
Message-ID: <TYBPR01MB53412DCDBC766DB3322F7517D803A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-8-yoshihiro.shimoda.uh@renesas.com>
 <20230724092454.GF6291@thinkpad>
In-Reply-To: <20230724092454.GF6291@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB8721:EE_
x-ms-office365-filtering-correlation-id: 53cb8d41-d794-4bce-3a17-08db8d06557c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CazIH6h2HpVfPZuqT4yaYYoGnvJWChjPFPSyhAoHgBI3s3DbVAzaVe9FwhDYuFirr97me5W2WkrrZNG/jWXxcPa9WT2RvyAqcLgEZVB1RemcgE6GouidwyySQA9O2yN/UWEm7WqZJYiNswpk5Z0EcqZqVu42Rp+0tRHgxKPsr1YivnbmUEuVWGZMf2OQ236nL6zlyETiDJmb6uz1k4PG4FYZQt2YcleokysjWIjqx6CAVpoo5NtwK01l+CPIS4PrLbEeNHYh683CJY7KPANEhxqSnqPyZzkPK03fMIzeRo1wXsSEvgJI8NpmVg2dsqP7Aswgv2NfJKwweFcMGtsVaWGRYygGwiTI23MCHLUVpkwn2/7iNiVxsTdLVhheT0U9sCk84ifCCZGAtYWot5fjI+0cyw8aTjl4xqUEla9uuw4zNJZ/tqceZ9GOcL6CBmvs4ONWCYTOJ4fHct7BCinaFsHG0FUDqr6FWQrNRx+UgUzKG0/4OVX4YB0uW6QuGSOkd4AgKHRHhie/BIpZxCTkx4TCRwXfw+dOEnsMMRqEZAbS2HUBt9H7bW3KYm9n5J0pAs6S5KfRKbTwmeJiOOycYjajZvaIZwG5gvgzThDiAW8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199021)(9686003)(54906003)(7696005)(966005)(478600001)(186003)(66476007)(71200400001)(6506007)(2906002)(66556008)(66446008)(64756008)(66946007)(52536014)(4326008)(316002)(6916009)(76116006)(7416002)(8936002)(5660300002)(8676002)(41300700001)(38100700002)(122000001)(38070700005)(55016003)(86362001)(33656002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWVVdG1QQWZtOThMY3JKSS9WY3BaVGs5QVRwYjZxRHUrUnlwdk5FVVpOdS82?=
 =?utf-8?B?V0NMQktzUG9IWTdBOUprK1hyZXVYRStmQklieEJXT2ZKeWNGYjVmeFlDY3VP?=
 =?utf-8?B?NzBEMDQ2Y3QrSHp1aWZzRlcxbUxlQ01zbGdjdmhDcTVlekRxWlVaQUkzYzFU?=
 =?utf-8?B?MHlJbVB0QWtHSHNDM2NDYmRoMlFNZ3pTdHgzWXM1QWRhVW9oQ0U5Z25MakRN?=
 =?utf-8?B?Vkg3YUxERmdQcVg0VWRpdzBoSm55TEozejgrWVM5aDZRcGhkRnYwQi9Fa20y?=
 =?utf-8?B?NVFPWW1CcmNVbmp3dFNVOTlIRFlGYkh3NEI0b1AzcitJZVJFNG5TcDJ6bVV5?=
 =?utf-8?B?Z3VTeUJyZXpsNHhsS2pUcXp3TzcvQjFkSWh3M0lRejZ6ZnpoL1E4Wnl0c01J?=
 =?utf-8?B?c2d6dDhtN3JJOHpWNnlEdTBOTFN0M2pLdlFsN1ZhZFFTR0EzUlM4SHRrbytM?=
 =?utf-8?B?cDNEYm82WHkvMmR6UTZwT0lad25mdngyZThsQytmZ1l1VEllZE05TXBZZkZq?=
 =?utf-8?B?OFQ1U0VKejAxVW4zejNSUFdpdW5wd05DNVUyMmlRMEJWYThuQTc5cXRZaUJH?=
 =?utf-8?B?cnFQSTAvak93TUZDSkNuY1h1L0EySzcyZSswcFdkT0N5aG4wTHE1bEZ4aWVn?=
 =?utf-8?B?Z3lUQmFRbEtjWFgvVjdqSG5uOXNqTk5HdngxeWhMY1RTWjM2Qjhub2JsSGxj?=
 =?utf-8?B?SGxhNzN2VkUvYkNBOVBDRjJNREF4THdHRm5aaFNrWVBYdGVWc1J0c0c3UjNS?=
 =?utf-8?B?OU4yTE5hRlgvdE03ZmZVK2ZLd3MwOUd5aWxxMHllK1RuTUtIYkZpdXh6MUNQ?=
 =?utf-8?B?ZFJMMVRpQWNqNHVvcVdpSGdzRTVHRlVNcDQrbjg1RE5vcThLZ1dGUlJXMUdT?=
 =?utf-8?B?RDE5dFpnektIeldRbHFSemVUTFpFcjlJT2tSNDdwVHhOUnd4RW94b0pneFlB?=
 =?utf-8?B?Z1JhUC9tUXZaOXBsUmpodndJa2xNWjBMbFBEKzlIMXlWVjllOFNTNzY3MEwv?=
 =?utf-8?B?TWhOOVUxZTF0M2s0YUMyR1FXNnJoWDVXVEFvYnJMTXhlYWdrdjBkeHNKckNJ?=
 =?utf-8?B?cmpuZldVMFE3RXpRa1VTaUhiNGpiV0tVRi9QQ2Q3NW1OdWFYdUY2blhqekpO?=
 =?utf-8?B?WFltNFVFYmUwbC82QzJocnlNNzM4ZGhBNTYvanBqM1R1R3dIUlAzODNueVhH?=
 =?utf-8?B?UE9keGFIYmc3QWppNmNKTXgvVXVQeEpBY3dSRTdVZ2piamd2VDRWbWhQR2NM?=
 =?utf-8?B?cjFtaGhDK3JpTlBMWjNCMXBaMGdNd1pNYXlrS2UwVFhSaE5XWHdYYW5uR2lj?=
 =?utf-8?B?Q0ZPVUVsOHBYSGJ4bVdSSlpXWGg1R3FRUFNQRndNTUhiLytQamp4WU5iczFD?=
 =?utf-8?B?LzB3Y0hzR25IeE1ySmtWVnE3VzRtempPcG5PVnM5SFhFS2VvbUsrUXBMS0FJ?=
 =?utf-8?B?aWt0NVdQR3BhVFlzdmczZ0ZGMlQ0alNZWWlTczRtWVFqNDhNaFVVU1VkbEJh?=
 =?utf-8?B?bnFXclFHQ05KRmxkcy82cFkrMlFPR0RqcXV4K2thTlYwS1REc21WbVpUbGwy?=
 =?utf-8?B?WFpsS1E0b2psS0lPTU8rUDVjUDVrSDNDWHlVQjFERUFKS0dOaU5Cd3VMbjVq?=
 =?utf-8?B?Ky9qbVkwWjF6RUs0dVdSMTZPNEMwYXFPRy9TcnFrWUF2T3hSbHVDOUh6L3E2?=
 =?utf-8?B?R3lObzgrVTRWUGxwdVZmZzY2anBjME5Kcll2L0hjb05MbVdKT2ptY1VMUytH?=
 =?utf-8?B?VU4veStnUkM2a3hiUEZmZ1RrZ1RQN3oyc1gvbFZ0dUdYMVZTWjdYUG90Ti9T?=
 =?utf-8?B?TWZ5bjhsNDVhbm1mQWdhcm1QU2xEVWJDQzVXZ2hkOVUxcFI4RDBtRlJhYzFw?=
 =?utf-8?B?SmxQNlpNOXB5NlVpNmZTQXh0czlmSmFqSm5kYlBNb0NpSnRJbDF5VlQvdE94?=
 =?utf-8?B?bkVOenZHcy9zVkRtMEU1NitSblFTQlR3MXhMcjA1V3B0c3BYcm1HNXNWNFB5?=
 =?utf-8?B?UzBKV2xiOTlKVHR1QTJDdVFVeGtWQlF5dG0xWTc5SnB5MndOckZieFRGQWkv?=
 =?utf-8?B?RGRDOFc0cVFNUXNBVTEzOVdLeFcyRmpFcmFWamRUamtDbXRKd3hRa25qd2Jp?=
 =?utf-8?B?ODhqQmlsL2pXRUZqV3BQbmxURGVrNWRJWEFBb1lud21aZmNEMGtJT1ZTTWNv?=
 =?utf-8?B?bEVKRm1tVU5RdSt3SkM5bktqUGJwU2xIMDBjTk50c2NHMTkyeS8yR1dCbmpl?=
 =?utf-8?B?TVM4K1lGVmxTUEU3LzdFSzVTNHlBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53cb8d41-d794-4bce-3a17-08db8d06557c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 11:57:34.6181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LFwO/xV4PXljmuYXK4bvuU3RHz4mBGlpO6HZ6e8t5VhqLFh5wxNt1qCrFJOtoaQlJvSZ8jZuIXHEFQaV9GiFaxo4MRCXELxzcpEh71yVX1Nu1gtAyxQW1E+n+8jUvNdO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8721
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTWFuaXZhbm5hbiwNCg0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6IE1v
bmRheSwgSnVseSAyNCwgMjAyMyA2OjI1IFBNDQo+IA0KPiBPbiBGcmksIEp1bCAyMSwgMjAyMyBh
dCAwNDo0NDozOVBNICswOTAwLCBZb3NoaWhpcm8gU2hpbW9kYSB3cm90ZToNCj4gPiBUaGUgY29t
bWl0IDI0ZWRlNDMwZmE0OSAoIlBDSTogZGVzaWdud2FyZS1lcDogQWRkIG11bHRpcGxlIFBGcyBz
dXBwb3J0DQo+ID4gZm9yIERXQyIpIGFkZGVkIC5mdW5jX2NvbmZfc2VsZWN0KCkgdG8gZ2V0IHRo
ZSBjb25maWd1cmF0aW9uIHNwYWNlIG9mDQo+ID4gZGlmZmVyZW50IFBGcyBhbmQgYXNzdW1lZCB0
aGF0IHRoZSBvZmZzZXRzIGJldHdlZW4gZGJpIGFuZCBkYmkyIHdvdWxkDQo+ID4gYmUgdGhlIHNh
bWUuIEhvd2V2ZXIsIFJlbmVzYXMgUi1DYXIgR2VuNCBQQ0llIGNvbnRyb2xsZXJzIGhhdmUgZGlm
ZmVyZW50DQo+ID4gb2Zmc2V0cyBvZiBmdW5jdGlvbiAxOiBkYmkgKCsweDEwMDApIGFuZCBkYmky
ICgrMHg4MDApLiBUbyBnZXQNCj4gPiB0aGUgb2Zmc2V0IGZvciBkYmkyLCBhZGQgLmZ1bmNfY29u
Zl9zZWxlY3QyKCkgYW5kDQo+ID4gZHdfcGNpZV9lcF9mdW5jX3NlbGVjdDIoKS4NCj4gPg0KPiAN
Cj4gSG93IGFib3V0LA0KPiANCj4gLmdldF9kYmkyX29mZnNldCgpIGFuZCBkd19wY2llX2VwX2dl
dF9kYmkyX29mZnNldCgpPw0KDQpUaGFuayB5b3UgZm9yIHlvdXIgc3VnZ2VzdGlvbi4gSSBzaG91
bGQgaGF2ZSBzaGFyZWQgdGhlIGZvbGxvd2luZyBpbmZvcm1hdGlvbg0KaW4gdGhlIGNvbW1pdCBs
b2csIGJ1dCBkYmkyX29mZnNldCBpcyBub3QgZGVwZW5kZWQgb24gdGhlIERCSSBvbiBteSBlbnZp
cm9ubWVudDoNCg0KICsweDAwMDAgOiBkYmkgRnVuY3Rpb24gMA0KICsweDEwMDAgOiBkYmkgRnVu
Y3Rpb24gMQ0KICsweDIwMDAgOiBkYmkyIEZ1bmN0aW9uIDANCiArMHgyODAwIDogZGJpMiBGdW5j
dGlvbiAxDQoNClNvLCBvbiBteSBlbnZpcm9ubWVudDoNCiAtIHRoZSBkYmlfYmFzZSBpcyBzZXQg
dG8gKzB4MDAwMC4uDQogLS0gQW5kIGZ1bmNfb2Zmc2V0IG9mIGZ1bmNfbm8gPSAxIHdhcyAweDEw
MDAuDQogLSB0aGUgZGJpX2Jhc2UyIGlzIHNldCB0byArMHgyMDAwLg0KIC0tIEFuZCBmdW5jX29m
ZnNldDIgb2YgZnVuY3Rpb24gPSAxIHdhcyAweDA4MDAsIG5vdCAweDE4MDAuDQoNClBlcmhhcHMs
IHRoZSBuYW1lIG9mIG5ldyBBUEkgc2hvdWxkIGJlIC5mdW5jX2NvbmZfc2VsZWN0X2RiaTIgaW5z
dGVhZD8NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfn5+fn4NCg0KPiBUaGlzIHdvdWxkJ3ZlIGJlZW4gbXVjaCBzaW1wbGVyIGlmIGR3X3Bj
aWVfd3JpdGVYX3tkYmkvZGJpMn0gQVBJcyBhY2NlcHRlZCB0aGUNCj4gZnVuY19ubyBhcmd1bWVu
dCwgc28gdGhhdCB0aGVzZSBvZmZzZXQgY2FsY3VsYXRpb25zIGFyZSBjb250YWluZWQgaW4gdGhl
IEFQSQ0KPiBkZWZpbml0aW9ucyBpdHNlbGYgYXMgaXQgc2hvdWxkLiBUaGVuIHRoZSBBUElzIGNv
dWxkIGp1c3QgZG8gImZ1bmNfb2Zmc2V0ICoNCj4gZnVuY19ubyIgdG8gZ2V0IERCSSBiYXNlIGFu
ZCAiKGZ1bmNfb2Zmc2V0ICogZnVuY19ubykgKyBkYmkyX29mZnNldCIgdG8gZ2V0IERCSTINCj4g
YmFzZSwgcHJvdmlkZWQgdGhlc2Ugb2Zmc2V0cyBhcmUgcGFzc2VkIGJ5IHRoZSB2ZW5kb3IgZHJp
dmVycy4NCg0KU2VyZ2Ugc3VnZ2VzdGVkIHN1Y2ggaW1wbGVtZW50YXRpb24gYmVmb3JlIFsxXQ0K
DQpbMV0NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXBjaS9qNGc0aWpueGQ3cXlhY3N6
bHd5aTN0ZHp0a3cybm1uand5aGRxZjJsMnlqM2gybXZqZUBpcXNycWlvZHFiaHEvDQoNCj4gSXQg
Y2FuIGJlIGRvbmUgaW4gYSBzZXBhcmF0ZSBjbGVhbnVwIHNlcmllcyBsYXRlci4NCj4gDQo+ID4g
Tm90ZXMgdGhhdCBkd19wY2llX2VwX2Z1bmNfc2VsZWN0MigpIHdpbGwgY2FsbCAuZnVuY19jb25m
X3NlbGVjdCgpDQo+IA0KPiBzL05vdGVzL05vdGUNCg0KSSdsbCBmaXggaXQuDQoNCj4gPiBpZiAu
ZnVuY19jb25mX3NlbGVjdDIoKSBkb2Vzbid0IGV4aXN0IGZvciBiYWNrd2FyZCBjb21wYXRpYmls
aXR5Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWW9zaGloaXJvIFNoaW1vZGEgPHlvc2hpaGly
by5zaGltb2RhLnVoQHJlbmVzYXMuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vcGNpL2NvbnRyb2xs
ZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1lcC5jICAgfCAzMiArKysrKysrKysrKysrKy0tLS0tDQo+
ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oICB8ICAzICst
DQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRl
c2lnbndhcmUtZXAuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2Fy
ZS1lcC5jDQo+ID4gaW5kZXggMWQyNGViZjk2ODZmLi5iZDU3NTE2ZDUzMTMgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWVwLmMNCj4g
PiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtZXAuYw0K
PiA+IEBAIC01NCwyMSArNTQsMzUgQEAgc3RhdGljIHVuc2lnbmVkIGludCBkd19wY2llX2VwX2Z1
bmNfc2VsZWN0KHN0cnVjdCBkd19wY2llX2VwICplcCwgdTggZnVuY19ubykNCj4gPiAgCXJldHVy
biBmdW5jX29mZnNldDsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB1bnNpZ25lZCBpbnQgZHdf
cGNpZV9lcF9mdW5jX3NlbGVjdDIoc3RydWN0IGR3X3BjaWVfZXAgKmVwLCB1OCBmdW5jX25vKQ0K
PiA+ICt7DQo+ID4gKwl1bnNpZ25lZCBpbnQgZnVuY19vZmZzZXQgPSAwOw0KPiA+ICsNCj4gPiAr
CWlmIChlcC0+b3BzLT5mdW5jX2NvbmZfc2VsZWN0MikNCj4gPiArCQlmdW5jX29mZnNldCA9IGVw
LT5vcHMtPmZ1bmNfY29uZl9zZWxlY3QyKGVwLCBmdW5jX25vKTsNCj4gPiArCWVsc2UgaWYgKGVw
LT5vcHMtPmZ1bmNfY29uZl9zZWxlY3QpCS8qIGZvciBiYWNrd2FyZCBjb21wYXRpYmlsaXR5ICov
DQo+ID4gKwkJZnVuY19vZmZzZXQgPSBlcC0+b3BzLT5mdW5jX2NvbmZfc2VsZWN0KGVwLCBmdW5j
X25vKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gZnVuY19vZmZzZXQ7DQo+ID4gK30NCj4gPiArDQo+
ID4gIHN0YXRpYyB2b2lkIF9fZHdfcGNpZV9lcF9yZXNldF9iYXIoc3RydWN0IGR3X3BjaWUgKnBj
aSwgdTggZnVuY19ubywNCj4gPiAgCQkJCSAgIGVudW0gcGNpX2Jhcm5vIGJhciwgaW50IGZsYWdz
KQ0KPiA+ICB7DQo+ID4gLQl1MzIgcmVnOw0KPiA+IC0JdW5zaWduZWQgaW50IGZ1bmNfb2Zmc2V0
ID0gMDsNCj4gPiArCXUzMiByZWcsIHJlZ19kYmkyOw0KPiA+ICsJdW5zaWduZWQgaW50IGZ1bmNf
b2Zmc2V0LCBmdW5jX29mZnNldF9kYmkyOw0KPiANCj4gUGxlYXNlIG1haXRhaW4gcmV2ZXJzZSBY
bWFzIHRyZWUgb3JkZXIuDQoNCkkgZ290IGl0Lg0KDQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8g
U2hpbW9kYQ0KDQo+IC0gTWFuaQ0KPiANCj4gPiAgCXN0cnVjdCBkd19wY2llX2VwICplcCA9ICZw
Y2ktPmVwOw0KPiA+DQo+ID4gIAlmdW5jX29mZnNldCA9IGR3X3BjaWVfZXBfZnVuY19zZWxlY3Qo
ZXAsIGZ1bmNfbm8pOw0KPiA+ICsJZnVuY19vZmZzZXRfZGJpMiA9IGR3X3BjaWVfZXBfZnVuY19z
ZWxlY3QyKGVwLCBmdW5jX25vKTsNCj4gPg0KPiA+ICAJcmVnID0gZnVuY19vZmZzZXQgKyBQQ0lf
QkFTRV9BRERSRVNTXzAgKyAoNCAqIGJhcik7DQo+ID4gKwlyZWdfZGJpMiA9IGZ1bmNfb2Zmc2V0
X2RiaTIgKyBQQ0lfQkFTRV9BRERSRVNTXzAgKyAoNCAqIGJhcik7DQo+ID4gIAlkd19wY2llX2Ri
aV9yb193cl9lbihwY2kpOw0KPiA+IC0JZHdfcGNpZV93cml0ZWxfZGJpMihwY2ksIHJlZywgMHgw
KTsNCj4gPiArCWR3X3BjaWVfd3JpdGVsX2RiaTIocGNpLCByZWdfZGJpMiwgMHgwKTsNCj4gPiAg
CWR3X3BjaWVfd3JpdGVsX2RiaShwY2ksIHJlZywgMHgwKTsNCj4gPiAgCWlmIChmbGFncyAmIFBD
SV9CQVNFX0FERFJFU1NfTUVNX1RZUEVfNjQpIHsNCj4gPiAtCQlkd19wY2llX3dyaXRlbF9kYmky
KHBjaSwgcmVnICsgNCwgMHgwKTsNCj4gPiArCQlkd19wY2llX3dyaXRlbF9kYmkyKHBjaSwgcmVn
X2RiaTIgKyA0LCAweDApOw0KPiA+ICAJCWR3X3BjaWVfd3JpdGVsX2RiaShwY2ksIHJlZyArIDQs
IDB4MCk7DQo+ID4gIAl9DQo+ID4gIAlkd19wY2llX2RiaV9yb193cl9kaXMocGNpKTsNCj4gPiBA
QCAtMjMyLDEzICsyNDYsMTUgQEAgc3RhdGljIGludCBkd19wY2llX2VwX3NldF9iYXIoc3RydWN0
IHBjaV9lcGMgKmVwYywgdTggZnVuY19ubywgdTggdmZ1bmNfbm8sDQo+ID4gIAllbnVtIHBjaV9i
YXJubyBiYXIgPSBlcGZfYmFyLT5iYXJubzsNCj4gPiAgCXNpemVfdCBzaXplID0gZXBmX2Jhci0+
c2l6ZTsNCj4gPiAgCWludCBmbGFncyA9IGVwZl9iYXItPmZsYWdzOw0KPiA+IC0JdW5zaWduZWQg
aW50IGZ1bmNfb2Zmc2V0ID0gMDsNCj4gPiArCXVuc2lnbmVkIGludCBmdW5jX29mZnNldCwgZnVu
Y19vZmZzZXRfZGJpMjsNCj4gPiAgCWludCByZXQsIHR5cGU7DQo+ID4gLQl1MzIgcmVnOw0KPiA+
ICsJdTMyIHJlZywgcmVnX2RiaTI7DQo+ID4NCj4gPiAgCWZ1bmNfb2Zmc2V0ID0gZHdfcGNpZV9l
cF9mdW5jX3NlbGVjdChlcCwgZnVuY19ubyk7DQo+ID4gKwlmdW5jX29mZnNldF9kYmkyID0gZHdf
cGNpZV9lcF9mdW5jX3NlbGVjdDIoZXAsIGZ1bmNfbm8pOw0KPiA+DQo+ID4gIAlyZWcgPSBQQ0lf
QkFTRV9BRERSRVNTXzAgKyAoNCAqIGJhcikgKyBmdW5jX29mZnNldDsNCj4gPiArCXJlZ19kYmky
ID0gUENJX0JBU0VfQUREUkVTU18wICsgKDQgKiBiYXIpICsgZnVuY19vZmZzZXRfZGJpMjsNCj4g
Pg0KPiA+ICAJaWYgKCEoZmxhZ3MgJiBQQ0lfQkFTRV9BRERSRVNTX1NQQUNFKSkNCj4gPiAgCQl0
eXBlID0gUENJRV9BVFVfVFlQRV9NRU07DQo+ID4gQEAgLTI1NCwxMSArMjcwLDExIEBAIHN0YXRp
YyBpbnQgZHdfcGNpZV9lcF9zZXRfYmFyKHN0cnVjdCBwY2lfZXBjICplcGMsIHU4IGZ1bmNfbm8s
IHU4IHZmdW5jX25vLA0KPiA+DQo+ID4gIAlkd19wY2llX2RiaV9yb193cl9lbihwY2kpOw0KPiA+
DQo+ID4gLQlkd19wY2llX3dyaXRlbF9kYmkyKHBjaSwgcmVnLCBsb3dlcl8zMl9iaXRzKHNpemUg
LSAxKSk7DQo+ID4gKwlkd19wY2llX3dyaXRlbF9kYmkyKHBjaSwgcmVnX2RiaTIsIGxvd2VyXzMy
X2JpdHMoc2l6ZSAtIDEpKTsNCj4gPiAgCWR3X3BjaWVfd3JpdGVsX2RiaShwY2ksIHJlZywgZmxh
Z3MpOw0KPiA+DQo+ID4gIAlpZiAoZmxhZ3MgJiBQQ0lfQkFTRV9BRERSRVNTX01FTV9UWVBFXzY0
KSB7DQo+ID4gLQkJZHdfcGNpZV93cml0ZWxfZGJpMihwY2ksIHJlZyArIDQsIHVwcGVyXzMyX2Jp
dHMoc2l6ZSAtIDEpKTsNCj4gPiArCQlkd19wY2llX3dyaXRlbF9kYmkyKHBjaSwgcmVnX2RiaTIg
KyA0LCB1cHBlcl8zMl9iaXRzKHNpemUgLSAxKSk7DQo+ID4gIAkJZHdfcGNpZV93cml0ZWxfZGJp
KHBjaSwgcmVnICsgNCwgMCk7DQo+ID4gIAl9DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmggYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaA0KPiA+IGluZGV4IDgxMmMyMjFiM2Y3Yy4uOTRi
YzIwZjVmNjAwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZGVzaWdud2FyZS5oDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
ZS1kZXNpZ253YXJlLmgNCj4gPiBAQCAtMzQwLDkgKzM0MCwxMCBAQCBzdHJ1Y3QgZHdfcGNpZV9l
cF9vcHMgew0KPiA+ICAJICogYWNjZXNzIGZvciBkaWZmZXJlbnQgcGxhdGZvcm0sIGlmIGRpZmZl
cmVudCBmdW5jIGhhdmUgZGlmZmVyZW50DQo+ID4gIAkgKiBvZmZzZXQsIHJldHVybiB0aGUgb2Zm
c2V0IG9mIGZ1bmMuIGlmIHVzZSB3cml0ZSBhIHJlZ2lzdGVyIHdheQ0KPiA+ICAJICogcmV0dXJu
IGEgMCwgYW5kIGltcGxlbWVudCBjb2RlIGluIGNhbGxiYWNrIGZ1bmN0aW9uIG9mIHBsYXRmb3Jt
DQo+ID4gLQkgKiBkcml2ZXIuDQo+ID4gKwkgKiBkcml2ZXIuIFRoZSBmdW5jX2NvbmZfc2VsZWN0
MiBpcyBmb3IgZGJpMi4NCj4gPiAgCSAqLw0KPiA+ICAJdW5zaWduZWQgaW50ICgqZnVuY19jb25m
X3NlbGVjdCkoc3RydWN0IGR3X3BjaWVfZXAgKmVwLCB1OCBmdW5jX25vKTsNCj4gPiArCXVuc2ln
bmVkIGludCAoKmZ1bmNfY29uZl9zZWxlY3QyKShzdHJ1Y3QgZHdfcGNpZV9lcCAqZXAsIHU4IGZ1
bmNfbm8pOw0KPiA+ICB9Ow0KPiA+DQo+ID4gIHN0cnVjdCBkd19wY2llX2VwX2Z1bmMgew0KPiA+
IC0tDQo+ID4gMi4yNS4xDQo+ID4NCj4gDQo+IC0tDQo+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+Cu
qeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==
