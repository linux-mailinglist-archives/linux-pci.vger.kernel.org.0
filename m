Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5326F766303
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jul 2023 06:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjG1ESh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jul 2023 00:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjG1ESf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jul 2023 00:18:35 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2094.outbound.protection.outlook.com [40.107.114.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E72359C;
        Thu, 27 Jul 2023 21:18:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhJFmMlGWaUtiLKSQJIiagOYpN8SSNRxHWUpaDutQ3YGbUDuBKyKTbDFeccUbx7+i8E+r9ExAnQvK+Po6PWyXmD42DDtxR6ocF9QpeV3dZrU3UtlpPAL3M81F0M8lo07Dc3TbXRfM7dAFRNY1C9H/l9HYcAMhvRS8FcBcnLBiuSKsdpVNmIMDBULBBgv3uj1NTSmZ7Zn4gO4g3z8O4Q6NNb1S5I+M7b9PxdXiZX8h9jpDPXWSEcJwSNM+ZImyjimd6On4AcRx5jLqRMdGlyoPOgKzpjlDJC9afpEuDjbVpZkGSlGLBJfX4YbWAnolxOdt0OkED5GaPx13mZHx9Nwmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98aTYX+UN7Cth9NeZC9bCPe76cChct9xyWBt34Ybnqk=;
 b=e0wbhcNM6HdF/vXqLyh452ZrCQJ7FI2YTCYc4t51B9e7dN13gYVlzXxWsuFbiCWnyFITRMKYMSD7qhmpFkDIu75IBPHPK93GzXLKK+TQ1fX0BvXLzbV+JyMiq/d/2dzB8Bj/7p7k3Zsrt8EaqEnq7Y//DV2HVGV8wUaqOK4ai0QmdKzd9oCL2tUmSltZOgSlPWesYx9nyvTpuSai2NC31wCxiftI7KJ7BR+BcZ1DbxFcBnx4q4rvNPaLiP91QfyNeFSlO6V2AegNdvN5bvhxWvIj688FLab84VTaZzza8RGu3kwJnuD5Hh3vkhe/uDf6YL0D1KnDmtNaJCK7QFWK4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98aTYX+UN7Cth9NeZC9bCPe76cChct9xyWBt34Ybnqk=;
 b=ESwhYtz7BKApnKVS9AQ/1xliQovZZFuCd4lpUT9K5luTn4PasgDeetIN4UPH1nDM9PBNLVix2/T4+dhPyNRucR/7gddyWk5RUqlAIZeOJafZUXwsZeWnF/Vc/4lqYsSV//8HBKJLebmi95Mmi8hTO0mARc4bIdQsuYqsuxexR20=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB8014.jpnprd01.prod.outlook.com
 (2603:1096:400:187::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 04:18:28 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 04:18:28 +0000
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
Thread-Index: AQHZu6dDjSUePTUsLESZ0DXx662VXa/IqhoAgAG2+NCABB/CAIAAG54w
Date:   Fri, 28 Jul 2023 04:18:28 +0000
Message-ID: <TYBPR01MB534145BABD5B9B319F604059D806A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-8-yoshihiro.shimoda.uh@renesas.com>
 <20230724092454.GF6291@thinkpad>
 <TYBPR01MB53412DCDBC766DB3322F7517D803A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230728023444.GA4433@thinkpad>
In-Reply-To: <20230728023444.GA4433@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB8014:EE_
x-ms-office365-filtering-correlation-id: a509f6aa-23ce-4f18-d220-08db8f21b204
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 98PHb/vvxJfohlnUpWZDiD83JmwhjlWwm+ogDYXAHmbAj++jqtsH69NkcTALR/s8SN/f3/EcY2H70rpFBtSCAW/9zBn9ZDTtaKnICKMCQex1ER2dXUJqeMDhEN9DcHkPoerPHOPHzBEVhbDQ1dZp4in3YugmQF9K8yQ0OLHQ7xzyrWhT8QO68xB6yOb9oP2bE+iF1rFG1UD/8ZAuK5vrknVeokzTFBPjjtFBTheXfmyHn1D6modKmIvyL082g+QmJdX91XGY7r+f8rlqbfEZlQ+jKdA2pfQk/nYgejDN1gwE70ly/NRIUZ4nCSmKQwJqYts/ppRbialm7iqg2RxjijKx/ygO4Y2Vtd2UtvhWOS9rtJQWPR0loB/tFI+ZqqYfmly3+5HXR8h28ZgtVKY5nePPpJy+LzBBviiyoV8R75pA0Tu2f5lr0RB+KuQuancYkgU+6GCkpWCVGxCq52WW9OX244/a5er7cC66tRJMeuFeXzXu4uvB5bYf9XMuvKDCn1PC7h1foshTVGS6WpGSvGSGyPpZd9Gtwg9HKMixJsTiKAcQftGww+TmxkmL9RSNVR/F+0UJCqyAzTWnepd6S79x8Ud4WbagYEIzv/J+kVeCgGnx9kVVsZtWM4ssIJUD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199021)(6916009)(38070700005)(66446008)(7696005)(71200400001)(66556008)(66476007)(76116006)(9686003)(66946007)(64756008)(4326008)(54906003)(38100700002)(55016003)(122000001)(41300700001)(478600001)(2906002)(83380400001)(7416002)(5660300002)(8676002)(8936002)(52536014)(33656002)(6506007)(316002)(86362001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TE5za00zaWtDa3JTRkNleitLZ2JCN04wWnF3bFg0U1ZramsvcWZmRUs4OXFF?=
 =?utf-8?B?WDNKcWU1b3VtYXoxbjlhcmNBWnQ0NEtNd1dOWE94cHN0eklyeTdLc0kyeFky?=
 =?utf-8?B?REVNTzgzZjF3cFIvM0FDa0RVUTE0Uk8vV0hrOXF6MFhSY1lMUGxFYVZSQ3hQ?=
 =?utf-8?B?RmE4UEE1TmNsTVJpMi9BSy9PTnVoNXpsaExGZktjR3BqemF4Y3RJc0hOdlhz?=
 =?utf-8?B?QjE0S25rRWlRUW5aN0wwYWdNVTZ1L1hJVzU4OHhaYVhPanNneEc2ZFZGM1Jt?=
 =?utf-8?B?N25XaE9hakQwMmZkWTZPNDNTbEZmd0VPNkxLMkJZdm9Ha0tUaVQ3YWUyTXY4?=
 =?utf-8?B?eTV2QjUzc3FJQ3U2WENxRDV5U3RDdkRpaEZKT2RZcC9RSjZJdW9qTjlEaEVx?=
 =?utf-8?B?SWJaUVRZNTE2dUJ0dGc1ZUxMNVpIdWVIY29GZ1pqZk9OL2dWWVVBT211cW5k?=
 =?utf-8?B?cGdpT2JwUFUrbmxQYnJINVBMaDUvbUIzb3gvSDhiQXdhSy9IajFibzJXMkRq?=
 =?utf-8?B?ZGtpaUp5VVJLNkVtamxKTEtlOWJ2UTZHRHNOdVJYbEIwUTFzakg5RTkrdTlk?=
 =?utf-8?B?Q3VJR0o5UkNiS1BuZnVhNUtPbGtrc0orRTRadUdIelNUOGtzWGlpZDR4eUNo?=
 =?utf-8?B?UlZUMm8yQVlkcFRUQk9oMnd5K3dudWpCdGxFY1plMWovTGxnRlNDOUZuU2pB?=
 =?utf-8?B?SmlZSDgzOEhKWUdaNk5VU3BrOVdNbmUxeWZZdnJ0bVBOMDNHZFNrQnRMYjhN?=
 =?utf-8?B?ZXV3amU5L0hzWm12QkZxcXNlMm1mU2ZFUEpiejZrVzRZWm5ONVZVeUsyMGFk?=
 =?utf-8?B?c3FHRC9MTWo5bERYLzRvUXRFRjdrQ09pVllnSXdOUm5Yb2ZCVGFueTMzNjJn?=
 =?utf-8?B?VlVTU0RNaGw3NlZhc2d4aWNuU0hsRVNEV2xrOStIbXcySndYQ1VSVVllY3dG?=
 =?utf-8?B?L0tFa1pOcHR6NXFDNlo4T1dHRlBqSG5sbU5hT1RERlA3aWJoa1hXSG1xd1hD?=
 =?utf-8?B?b2Ntc2JMaVJwL1BHVWh6YWNlMFdGbGRLaVl0aThBZXFwQ1NUMXhBVTNROXJt?=
 =?utf-8?B?WDEycmIyVjNiOFgrSEJrakZwaUZlcUo0ZmF5ZmZoQ29CMXk2YXh2aW9QRDBB?=
 =?utf-8?B?Q2RVTWV6QVRla2gvR1pqSmg5cWJFRGtJZkUrb2Y4elc3MzBKV0lwZ0pWVFlw?=
 =?utf-8?B?TlZESVFRUWFBSHg4b3Jib241VG1hbFBBSnJXWUc2bnZ2MHFGNnJCczZzOHZL?=
 =?utf-8?B?TXFIOTFzZmhKcUlNUW4raTBnekJrYkxHd1g2WjJKYVBtTkVLNW50dzJ3bVVm?=
 =?utf-8?B?TzR3SU93dEZ4Z0dDcFJQUXNtNE9RYnkzbW9jbUtMNVNOT1ZBTzBsMUR4cmQr?=
 =?utf-8?B?R1VoK1FhQzRJaElhQW9VNTJiNHVpanlqK3psY1RmZmNicmpaRWpHZHp6cmVE?=
 =?utf-8?B?NGNHNmpiNG5QUktIcmJYdjdOZk45SW1VUlpCUnh2Sk9USVFqVGtuQmNvb0w0?=
 =?utf-8?B?RlAxMmhaa1NLWWplby9ZOWVPTTJ6Vk5zNWhxYVpFOEdCQzJWQk9xaCtDTXpF?=
 =?utf-8?B?MWM3RXlyQmtkVmlsTWhqL3NETm5YSkxXemlzREwzTVMwRjk1NzhWREJUTkhu?=
 =?utf-8?B?UitUb2VQK2hmVTJHMmZtd2JKamZrNzVtemNwdVc5MlV5Z2FqbWNrYTNnVkx5?=
 =?utf-8?B?bVJjRHVMQU5jbnZQNTNFNlFvUVl3byttU2lNdDdLZ3ZHSnZPcnVMN2Y2Wmxw?=
 =?utf-8?B?NXVvR1NURk14Z1UweG9icHU1ZVY5Z0xvL3hOMm54VTFRMko3b3FXc0FDUGJz?=
 =?utf-8?B?VFhFeURUS3ovOW9FTS9Oczd4dXMzQTVmVWhuTVBnTTUxOEhLRy9IQTJmMjZJ?=
 =?utf-8?B?SmxqaFdUN3dVUTlGdEZ6TnVIYlFzMGlYOFN5SitoTXlVSFJSQW0yUHpPaWZZ?=
 =?utf-8?B?amhkWFZ0c0RUNXpCSE83dTlSak1LYXh4YmJJT2hFdWZRTUMyd2JEdS9mYm43?=
 =?utf-8?B?c2tLYkRDQVJjQVdDaUxoNFhZWWFCOVQ3MzVmbk9oUWxhNjh4OXgxWlROVFZE?=
 =?utf-8?B?cUc2eldFbXEwQ3VFZHlmUm83U1FqR2NEMWpVMGtHTWJaU1NVQmJiUkxScGNv?=
 =?utf-8?B?TEhFOWVlUENtcmlac1RaWW84ak0vQ2w3VUd2RWlKUGF6UitsTER6WlBTN2pq?=
 =?utf-8?B?WGJvb0ZmZFI0UEhhbnMrWFJKZlFtcGExL2tRM2FJQ21DSWpwNHRjdHZ1M0xx?=
 =?utf-8?B?Q3F1bnNUL0xHV2xpL1JGM3RMRFNRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a509f6aa-23ce-4f18-d220-08db8f21b204
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 04:18:28.6363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AgmbYI87069hmL0Yp968MYGVcFVfLYs3KbBNoRxRnSz7ukuUdaSfHlpKazqSoKORFJCdkwK2I87/zpWOpurrwPLIcCkXsVvhAER+rRedALdp+qfOoS1E6ivWKpwHwDl3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8014
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTWFuaXZhbm5hbiwNCg0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6IEZy
aWRheSwgSnVseSAyOCwgMjAyMyAxMTozNSBBTQ0KPiANCj4gT24gVHVlLCBKdWwgMjUsIDIwMjMg
YXQgMTE6NTc6MzRBTSArMDAwMCwgWW9zaGloaXJvIFNoaW1vZGEgd3JvdGU6DQo+ID4gSGkgTWFu
aXZhbm5hbiwNCj4gPg0KPiA+ID4gRnJvbTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtLCBTZW50OiBN
b25kYXksIEp1bHkgMjQsIDIwMjMgNjoyNSBQTQ0KPiA+ID4NCj4gPiA+IE9uIEZyaSwgSnVsIDIx
LCAyMDIzIGF0IDA0OjQ0OjM5UE0gKzA5MDAsIFlvc2hpaGlybyBTaGltb2RhIHdyb3RlOg0KPiA+
ID4gPiBUaGUgY29tbWl0IDI0ZWRlNDMwZmE0OSAoIlBDSTogZGVzaWdud2FyZS1lcDogQWRkIG11
bHRpcGxlIFBGcyBzdXBwb3J0DQo+ID4gPiA+IGZvciBEV0MiKSBhZGRlZCAuZnVuY19jb25mX3Nl
bGVjdCgpIHRvIGdldCB0aGUgY29uZmlndXJhdGlvbiBzcGFjZSBvZg0KPiA+ID4gPiBkaWZmZXJl
bnQgUEZzIGFuZCBhc3N1bWVkIHRoYXQgdGhlIG9mZnNldHMgYmV0d2VlbiBkYmkgYW5kIGRiaTIg
d291bGQNCj4gPiA+ID4gYmUgdGhlIHNhbWUuIEhvd2V2ZXIsIFJlbmVzYXMgUi1DYXIgR2VuNCBQ
Q0llIGNvbnRyb2xsZXJzIGhhdmUgZGlmZmVyZW50DQo+ID4gPiA+IG9mZnNldHMgb2YgZnVuY3Rp
b24gMTogZGJpICgrMHgxMDAwKSBhbmQgZGJpMiAoKzB4ODAwKS4gVG8gZ2V0DQo+ID4gPiA+IHRo
ZSBvZmZzZXQgZm9yIGRiaTIsIGFkZCAuZnVuY19jb25mX3NlbGVjdDIoKSBhbmQNCj4gPiA+ID4g
ZHdfcGNpZV9lcF9mdW5jX3NlbGVjdDIoKS4NCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBIb3cgYWJv
dXQsDQo+ID4gPg0KPiA+ID4gLmdldF9kYmkyX29mZnNldCgpIGFuZCBkd19wY2llX2VwX2dldF9k
YmkyX29mZnNldCgpPw0KPiA+DQo+ID4gVGhhbmsgeW91IGZvciB5b3VyIHN1Z2dlc3Rpb24uIEkg
c2hvdWxkIGhhdmUgc2hhcmVkIHRoZSBmb2xsb3dpbmcgaW5mb3JtYXRpb24NCj4gPiBpbiB0aGUg
Y29tbWl0IGxvZywgYnV0IGRiaTJfb2Zmc2V0IGlzIG5vdCBkZXBlbmRlZCBvbiB0aGUgREJJIG9u
IG15IGVudmlyb25tZW50Og0KPiA+DQo+ID4gICsweDAwMDAgOiBkYmkgRnVuY3Rpb24gMA0KPiA+
ICArMHgxMDAwIDogZGJpIEZ1bmN0aW9uIDENCj4gPiAgKzB4MjAwMCA6IGRiaTIgRnVuY3Rpb24g
MA0KPiA+ICArMHgyODAwIDogZGJpMiBGdW5jdGlvbiAxDQo+ID4NCj4gPiBTbywgb24gbXkgZW52
aXJvbm1lbnQ6DQo+ID4gIC0gdGhlIGRiaV9iYXNlIGlzIHNldCB0byArMHgwMDAwLi4NCj4gPiAg
LS0gQW5kIGZ1bmNfb2Zmc2V0IG9mIGZ1bmNfbm8gPSAxIHdhcyAweDEwMDAuDQo+ID4gIC0gdGhl
IGRiaV9iYXNlMiBpcyBzZXQgdG8gKzB4MjAwMC4NCj4gPiAgLS0gQW5kIGZ1bmNfb2Zmc2V0MiBv
ZiBmdW5jdGlvbiA9IDEgd2FzIDB4MDgwMCwgbm90IDB4MTgwMC4NCj4gPg0KPiA+IFBlcmhhcHMs
IHRoZSBuYW1lIG9mIG5ldyBBUEkgc2hvdWxkIGJlIC5mdW5jX2NvbmZfc2VsZWN0X2RiaTIgaW5z
dGVhZD8NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIH5+fn5+DQo+IA0KPiAiZnVuY19jb25mX3NlbGVjdCIgZG9lc24ndCBsb29rIGlu
dHVpdGl2ZSB0byBtZSBhdGxlYXN0LiBUaGUgaWRlYSBiZWhpbmQgdGhpcw0KPiBjYWxsYmFjayBp
cyB0byBnZXQgdGhlIGZ1bmNpb24gb2Zmc2V0IGJhc2VkIG9uIHRoZSBzdXBwbGllZCBmdW5jdGlv
biBuby4gU28gdGhpcw0KPiBzaG91bGQndmUgYmVlbiBzb21ldGhpbmcgbGlrZSwgImdldF9mdW5j
X29mZnNldCIgYW5kIHRoZSBBUEkgc2hvdWxkJ3ZlIGJlZW4NCj4gZHdfcGNpZV9lcF9nZXRfZnVu
Y19vZmZzZXQoKS4NCj4gDQo+IFNpbmNlIEkgZG8gbm90IHdhbnQgeW91IHRvIGNoYW5nZSB0aGUg
ZXhpc3RpbmcgbmFtaW5nIGluIHRoaXMgc2VyaWVzLCBJDQo+IHN1Z2dlc3RlZCB0byBnZXQgdGhl
IG5leHQgQVBJIG5hbWluZyByaWdodC4NCg0KSSBnb3QgaXQuDQoNCj4gPg0KPiA+ID4gVGhpcyB3
b3VsZCd2ZSBiZWVuIG11Y2ggc2ltcGxlciBpZiBkd19wY2llX3dyaXRlWF97ZGJpL2RiaTJ9IEFQ
SXMgYWNjZXB0ZWQgdGhlDQo+ID4gPiBmdW5jX25vIGFyZ3VtZW50LCBzbyB0aGF0IHRoZXNlIG9m
ZnNldCBjYWxjdWxhdGlvbnMgYXJlIGNvbnRhaW5lZCBpbiB0aGUgQVBJDQo+ID4gPiBkZWZpbml0
aW9ucyBpdHNlbGYgYXMgaXQgc2hvdWxkLiBUaGVuIHRoZSBBUElzIGNvdWxkIGp1c3QgZG8gImZ1
bmNfb2Zmc2V0ICoNCj4gPiA+IGZ1bmNfbm8iIHRvIGdldCBEQkkgYmFzZSBhbmQgIihmdW5jX29m
ZnNldCAqIGZ1bmNfbm8pICsgZGJpMl9vZmZzZXQiIHRvIGdldCBEQkkyDQo+ID4gPiBiYXNlLCBw
cm92aWRlZCB0aGVzZSBvZmZzZXRzIGFyZSBwYXNzZWQgYnkgdGhlIHZlbmRvciBkcml2ZXJzLg0K
PiA+DQo+ID4gU2VyZ2Ugc3VnZ2VzdGVkIHN1Y2ggaW1wbGVtZW50YXRpb24gYmVmb3JlIFsxXQ0K
PiA+DQo+ID4gWzFdDQo+ID4NCjxzbmlwIFVSTD4NCj4gPg0KPiANCj4gVGhhbmtzIGZvciB0aGUg
bGluay4gSSBtaXNzZWQgU2VyZ2UncyBzdWdnZXN0aW9uIGJlZm9yZS4gQnV0IEkgY29tcGxldGVs
eSBhZ3JlZQ0KPiB3aXRoIGhpbSBhcyB5b3UgY2FuIHNlZSBmcm9tIG15IGFib3ZlIHN1Z2dlc3Rp
b24uIEluIGFkZGl0aW9uLCBJIGFsc28gd2FudCB0bw0KPiBmaXggdGhlICJmdW5jX2NvbmZfc2Vs
ZWN0IiBuYW1pbmcgYXMgd2VsbC4NCj4gDQo+IEhvd2V2ZXIsIEkgZG8gbm90IHdhbnQgeW91IHRv
IGltcGxlbWVudCB0aGUgc3VnZ2VzdGlvbiBpbiB0aGlzIHNlcmllcyBpdHNlbGYuDQo+IEl0IHNo
b3VsZCBiZSBkb25lIGFzIGEgc2VwYXJhdGUgY2xlYW51cCBzZXJpZXMgbGF0ZXIuDQoNCkkgZ290
IGl0Lg0KDQo+IChJIHRoaW5rIHlvdSBib3RoIGFncmVlIHRvDQo+IHRoYXQgYXMgd2VsbCkuDQoN
ClllcywgSSBib3RoIGFncmVlIHRvIHRoYXQuDQoNCkJlc3QgcmVnYXJkcywNCllvc2hpaGlybyBT
aGltb2RhDQoNCj4gLSBNYW5pDQo+IA0KPiA+ID4gSXQgY2FuIGJlIGRvbmUgaW4gYSBzZXBhcmF0
ZSBjbGVhbnVwIHNlcmllcyBsYXRlci4NCj4gPiA+DQo+ID4gPiA+IE5vdGVzIHRoYXQgZHdfcGNp
ZV9lcF9mdW5jX3NlbGVjdDIoKSB3aWxsIGNhbGwgLmZ1bmNfY29uZl9zZWxlY3QoKQ0KPiA+ID4N
Cj4gPiA+IHMvTm90ZXMvTm90ZQ0KPiA+DQo+ID4gSSdsbCBmaXggaXQuDQo+ID4NCj4gPiA+ID4g
aWYgLmZ1bmNfY29uZl9zZWxlY3QyKCkgZG9lc24ndCBleGlzdCBmb3IgYmFja3dhcmQgY29tcGF0
aWJpbGl0eS4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWW9zaGloaXJvIFNoaW1v
ZGEgPHlvc2hpaGlyby5zaGltb2RhLnVoQHJlbmVzYXMuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+
ID4gIC4uLi9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWVwLmMgICB8IDMyICsr
KysrKysrKysrKysrLS0tLS0NCj4gPiA+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZGVzaWdud2FyZS5oICB8ICAzICstDQo+ID4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDI2IGlu
c2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtZXAuYyBiL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1lcC5jDQo+ID4gPiA+IGluZGV4
IDFkMjRlYmY5Njg2Zi4uYmQ1NzUxNmQ1MzEzIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtZXAuYw0KPiA+ID4gPiArKysgYi9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtZXAuYw0KPiA+ID4gPiBA
QCAtNTQsMjEgKzU0LDM1IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgZHdfcGNpZV9lcF9mdW5jX3Nl
bGVjdChzdHJ1Y3QgZHdfcGNpZV9lcCAqZXAsIHU4IGZ1bmNfbm8pDQo+ID4gPiA+ICAJcmV0dXJu
IGZ1bmNfb2Zmc2V0Ow0KPiA+ID4gPiAgfQ0KPiA+ID4gPg0KPiA+ID4gPiArc3RhdGljIHVuc2ln
bmVkIGludCBkd19wY2llX2VwX2Z1bmNfc2VsZWN0MihzdHJ1Y3QgZHdfcGNpZV9lcCAqZXAsIHU4
IGZ1bmNfbm8pDQo+ID4gPiA+ICt7DQo+ID4gPiA+ICsJdW5zaWduZWQgaW50IGZ1bmNfb2Zmc2V0
ID0gMDsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCWlmIChlcC0+b3BzLT5mdW5jX2NvbmZfc2VsZWN0
MikNCj4gPiA+ID4gKwkJZnVuY19vZmZzZXQgPSBlcC0+b3BzLT5mdW5jX2NvbmZfc2VsZWN0Mihl
cCwgZnVuY19ubyk7DQo+ID4gPiA+ICsJZWxzZSBpZiAoZXAtPm9wcy0+ZnVuY19jb25mX3NlbGVj
dCkJLyogZm9yIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgKi8NCj4gPiA+ID4gKwkJZnVuY19vZmZz
ZXQgPSBlcC0+b3BzLT5mdW5jX2NvbmZfc2VsZWN0KGVwLCBmdW5jX25vKTsNCj4gPiA+ID4gKw0K
PiA+ID4gPiArCXJldHVybiBmdW5jX29mZnNldDsNCj4gPiA+ID4gK30NCj4gPiA+ID4gKw0KPiA+
ID4gPiAgc3RhdGljIHZvaWQgX19kd19wY2llX2VwX3Jlc2V0X2JhcihzdHJ1Y3QgZHdfcGNpZSAq
cGNpLCB1OCBmdW5jX25vLA0KPiA+ID4gPiAgCQkJCSAgIGVudW0gcGNpX2Jhcm5vIGJhciwgaW50
IGZsYWdzKQ0KPiA+ID4gPiAgew0KPiA+ID4gPiAtCXUzMiByZWc7DQo+ID4gPiA+IC0JdW5zaWdu
ZWQgaW50IGZ1bmNfb2Zmc2V0ID0gMDsNCj4gPiA+ID4gKwl1MzIgcmVnLCByZWdfZGJpMjsNCj4g
PiA+ID4gKwl1bnNpZ25lZCBpbnQgZnVuY19vZmZzZXQsIGZ1bmNfb2Zmc2V0X2RiaTI7DQo+ID4g
Pg0KPiA+ID4gUGxlYXNlIG1haXRhaW4gcmV2ZXJzZSBYbWFzIHRyZWUgb3JkZXIuDQo+ID4NCj4g
PiBJIGdvdCBpdC4NCj4gPg0KPiA+IEJlc3QgcmVnYXJkcywNCj4gPiBZb3NoaWhpcm8gU2hpbW9k
YQ0KPiA+DQo+ID4gPiAtIE1hbmkNCj4gPiA+DQo+ID4gPiA+ICAJc3RydWN0IGR3X3BjaWVfZXAg
KmVwID0gJnBjaS0+ZXA7DQo+ID4gPiA+DQo+ID4gPiA+ICAJZnVuY19vZmZzZXQgPSBkd19wY2ll
X2VwX2Z1bmNfc2VsZWN0KGVwLCBmdW5jX25vKTsNCj4gPiA+ID4gKwlmdW5jX29mZnNldF9kYmky
ID0gZHdfcGNpZV9lcF9mdW5jX3NlbGVjdDIoZXAsIGZ1bmNfbm8pOw0KPiA+ID4gPg0KPiA+ID4g
PiAgCXJlZyA9IGZ1bmNfb2Zmc2V0ICsgUENJX0JBU0VfQUREUkVTU18wICsgKDQgKiBiYXIpOw0K
PiA+ID4gPiArCXJlZ19kYmkyID0gZnVuY19vZmZzZXRfZGJpMiArIFBDSV9CQVNFX0FERFJFU1Nf
MCArICg0ICogYmFyKTsNCj4gPiA+ID4gIAlkd19wY2llX2RiaV9yb193cl9lbihwY2kpOw0KPiA+
ID4gPiAtCWR3X3BjaWVfd3JpdGVsX2RiaTIocGNpLCByZWcsIDB4MCk7DQo+ID4gPiA+ICsJZHdf
cGNpZV93cml0ZWxfZGJpMihwY2ksIHJlZ19kYmkyLCAweDApOw0KPiA+ID4gPiAgCWR3X3BjaWVf
d3JpdGVsX2RiaShwY2ksIHJlZywgMHgwKTsNCj4gPiA+ID4gIAlpZiAoZmxhZ3MgJiBQQ0lfQkFT
RV9BRERSRVNTX01FTV9UWVBFXzY0KSB7DQo+ID4gPiA+IC0JCWR3X3BjaWVfd3JpdGVsX2RiaTIo
cGNpLCByZWcgKyA0LCAweDApOw0KPiA+ID4gPiArCQlkd19wY2llX3dyaXRlbF9kYmkyKHBjaSwg
cmVnX2RiaTIgKyA0LCAweDApOw0KPiA+ID4gPiAgCQlkd19wY2llX3dyaXRlbF9kYmkocGNpLCBy
ZWcgKyA0LCAweDApOw0KPiA+ID4gPiAgCX0NCj4gPiA+ID4gIAlkd19wY2llX2RiaV9yb193cl9k
aXMocGNpKTsNCj4gPiA+ID4gQEAgLTIzMiwxMyArMjQ2LDE1IEBAIHN0YXRpYyBpbnQgZHdfcGNp
ZV9lcF9zZXRfYmFyKHN0cnVjdCBwY2lfZXBjICplcGMsIHU4IGZ1bmNfbm8sIHU4IHZmdW5jX25v
LA0KPiA+ID4gPiAgCWVudW0gcGNpX2Jhcm5vIGJhciA9IGVwZl9iYXItPmJhcm5vOw0KPiA+ID4g
PiAgCXNpemVfdCBzaXplID0gZXBmX2Jhci0+c2l6ZTsNCj4gPiA+ID4gIAlpbnQgZmxhZ3MgPSBl
cGZfYmFyLT5mbGFnczsNCj4gPiA+ID4gLQl1bnNpZ25lZCBpbnQgZnVuY19vZmZzZXQgPSAwOw0K
PiA+ID4gPiArCXVuc2lnbmVkIGludCBmdW5jX29mZnNldCwgZnVuY19vZmZzZXRfZGJpMjsNCj4g
PiA+ID4gIAlpbnQgcmV0LCB0eXBlOw0KPiA+ID4gPiAtCXUzMiByZWc7DQo+ID4gPiA+ICsJdTMy
IHJlZywgcmVnX2RiaTI7DQo+ID4gPiA+DQo+ID4gPiA+ICAJZnVuY19vZmZzZXQgPSBkd19wY2ll
X2VwX2Z1bmNfc2VsZWN0KGVwLCBmdW5jX25vKTsNCj4gPiA+ID4gKwlmdW5jX29mZnNldF9kYmky
ID0gZHdfcGNpZV9lcF9mdW5jX3NlbGVjdDIoZXAsIGZ1bmNfbm8pOw0KPiA+ID4gPg0KPiA+ID4g
PiAgCXJlZyA9IFBDSV9CQVNFX0FERFJFU1NfMCArICg0ICogYmFyKSArIGZ1bmNfb2Zmc2V0Ow0K
PiA+ID4gPiArCXJlZ19kYmkyID0gUENJX0JBU0VfQUREUkVTU18wICsgKDQgKiBiYXIpICsgZnVu
Y19vZmZzZXRfZGJpMjsNCj4gPiA+ID4NCj4gPiA+ID4gIAlpZiAoIShmbGFncyAmIFBDSV9CQVNF
X0FERFJFU1NfU1BBQ0UpKQ0KPiA+ID4gPiAgCQl0eXBlID0gUENJRV9BVFVfVFlQRV9NRU07DQo+
ID4gPiA+IEBAIC0yNTQsMTEgKzI3MCwxMSBAQCBzdGF0aWMgaW50IGR3X3BjaWVfZXBfc2V0X2Jh
cihzdHJ1Y3QgcGNpX2VwYyAqZXBjLCB1OCBmdW5jX25vLCB1OCB2ZnVuY19ubywNCj4gPiA+ID4N
Cj4gPiA+ID4gIAlkd19wY2llX2RiaV9yb193cl9lbihwY2kpOw0KPiA+ID4gPg0KPiA+ID4gPiAt
CWR3X3BjaWVfd3JpdGVsX2RiaTIocGNpLCByZWcsIGxvd2VyXzMyX2JpdHMoc2l6ZSAtIDEpKTsN
Cj4gPiA+ID4gKwlkd19wY2llX3dyaXRlbF9kYmkyKHBjaSwgcmVnX2RiaTIsIGxvd2VyXzMyX2Jp
dHMoc2l6ZSAtIDEpKTsNCj4gPiA+ID4gIAlkd19wY2llX3dyaXRlbF9kYmkocGNpLCByZWcsIGZs
YWdzKTsNCj4gPiA+ID4NCj4gPiA+ID4gIAlpZiAoZmxhZ3MgJiBQQ0lfQkFTRV9BRERSRVNTX01F
TV9UWVBFXzY0KSB7DQo+ID4gPiA+IC0JCWR3X3BjaWVfd3JpdGVsX2RiaTIocGNpLCByZWcgKyA0
LCB1cHBlcl8zMl9iaXRzKHNpemUgLSAxKSk7DQo+ID4gPiA+ICsJCWR3X3BjaWVfd3JpdGVsX2Ri
aTIocGNpLCByZWdfZGJpMiArIDQsIHVwcGVyXzMyX2JpdHMoc2l6ZSAtIDEpKTsNCj4gPiA+ID4g
IAkJZHdfcGNpZV93cml0ZWxfZGJpKHBjaSwgcmVnICsgNCwgMCk7DQo+ID4gPiA+ICAJfQ0KPiA+
ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
ZS1kZXNpZ253YXJlLmggYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndh
cmUuaA0KPiA+ID4gPiBpbmRleCA4MTJjMjIxYjNmN2MuLjk0YmMyMGY1ZjYwMCAxMDA2NDQNCj4g
PiA+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmgN
Cj4gPiA+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJl
LmgNCj4gPiA+ID4gQEAgLTM0MCw5ICszNDAsMTAgQEAgc3RydWN0IGR3X3BjaWVfZXBfb3BzIHsN
Cj4gPiA+ID4gIAkgKiBhY2Nlc3MgZm9yIGRpZmZlcmVudCBwbGF0Zm9ybSwgaWYgZGlmZmVyZW50
IGZ1bmMgaGF2ZSBkaWZmZXJlbnQNCj4gPiA+ID4gIAkgKiBvZmZzZXQsIHJldHVybiB0aGUgb2Zm
c2V0IG9mIGZ1bmMuIGlmIHVzZSB3cml0ZSBhIHJlZ2lzdGVyIHdheQ0KPiA+ID4gPiAgCSAqIHJl
dHVybiBhIDAsIGFuZCBpbXBsZW1lbnQgY29kZSBpbiBjYWxsYmFjayBmdW5jdGlvbiBvZiBwbGF0
Zm9ybQ0KPiA+ID4gPiAtCSAqIGRyaXZlci4NCj4gPiA+ID4gKwkgKiBkcml2ZXIuIFRoZSBmdW5j
X2NvbmZfc2VsZWN0MiBpcyBmb3IgZGJpMi4NCj4gPiA+ID4gIAkgKi8NCj4gPiA+ID4gIAl1bnNp
Z25lZCBpbnQgKCpmdW5jX2NvbmZfc2VsZWN0KShzdHJ1Y3QgZHdfcGNpZV9lcCAqZXAsIHU4IGZ1
bmNfbm8pOw0KPiA+ID4gPiArCXVuc2lnbmVkIGludCAoKmZ1bmNfY29uZl9zZWxlY3QyKShzdHJ1
Y3QgZHdfcGNpZV9lcCAqZXAsIHU4IGZ1bmNfbm8pOw0KPiA+ID4gPiAgfTsNCj4gPiA+ID4NCj4g
PiA+ID4gIHN0cnVjdCBkd19wY2llX2VwX2Z1bmMgew0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAyLjI1
LjENCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiAtLQ0KPiA+ID4g4K6u4K6j4K6/4K614K6j4K+N4K6j
4K6p4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCvjQ0KPiANCj4gLS0NCj4g4K6u4K6j4K6/4K61
4K6j4K+N4K6j4K6p4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCvjQ0K
