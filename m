Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B351BE16B
	for <lists+linux-pci@lfdr.de>; Wed, 29 Apr 2020 16:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgD2OoK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Apr 2020 10:44:10 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:18859 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgD2OoJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Apr 2020 10:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1588171450; x=1619707450;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=c4ntEiPW6qZAUL+YVbae6J2SqRAoFwxotlv1Vle85hY=;
  b=s1lMFgzKDysjPgNgrYhCOOo7LQte5zxodQ7xhIfZveXWJoXsrTtm+5dL
   lGQzd34FEze+9jatRTPoBEfTHd8JjVfl6F13EQhi43yvU5evFNLHHjzli
   HvJlyi3rxvlXQgwfCfufj0iYKbHduXmWnT5KuvE5khdqHa+qLbtgnc9Cs
   oSSfrJl4l1JM/aNWQ8AyJ3dB19tYOJASzJ9zwzqiBc6XNcbW2+sXou9GU
   8s5t2b6ng6HdBh//xaznVYQo+G2bfasJoKq/ge7KJr2BYkMTSYjHtJvLH
   tS+tkzaOWxIGjWDnzZthB391KcNCx9tw4w4SRbD75BNwanwglBFXBw82E
   w==;
IronPort-SDR: 0GVx+mwbwvxKg+/E4TYLMguGq1Q5g2DlMFf8X2LZ3tvA3RuMNW1YJNS900C+glafE5ehrfbWWf
 Pm5b8h+tyP4Ot5BOcOz0ijhWeIOkpbtE+OjOOa2ERtfLlhQy+C7VRYDYCgoWJIUlrzjcsJvG/L
 MVdyzIdq4nvng+rY9zh84gIcsyIJL6XVJ3rLj7IYlwg1Gmu5wOJy9n6ExXRqsC3nLr0jRuZe5W
 bA13Xbfd3ho+z3/9KCP6/gdoJ1QhudrmgBpcZ1KdZ/0BM+vEXhzL/S+btALLkf8eoaSItvNaf6
 DWc=
X-IronPort-AV: E=Sophos;i="5.73,332,1583218800"; 
   d="scan'208";a="74247678"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Apr 2020 07:44:09 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 29 Apr 2020 07:44:08 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 29 Apr 2020 07:44:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsocDLfaaPk93WtJmK//pkUM2oZobiLkJ9kvDbzRI2Vu2V+R7l9wrYurvpDe8xv8QWbbHSz2mWy/sYE9y+WUEfAndvnjhIDSRDioEbxssekx50yI+y37opVKfKYn8M2DIECYco8lzw7lenpAlcSoWuJnszAgkNbTG1f6VwnqdKXPPOSplqxdUxOg8FXkEyNg5NnP0A/bpV7x0HShvsI0RqOsta2hginm9Kb+87r+oKmV4JnwGPu10XsWefGBBytc/OuxzfoZ7Q2HOFnW6NrXg8NDMwpmmhMzFbvKRSrrsSKFLo3ueworkLOfWs7YRgj5akMfBwXGm1qaiPG48/etTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4ntEiPW6qZAUL+YVbae6J2SqRAoFwxotlv1Vle85hY=;
 b=Uk5Ld2Uo9raJmAYSWezAbUJWv9iYQ4owNjyo/ScDJ/Yu+ECmiuE9QmeeQNzUxBr0XitxQ3+smznHSDXKMdxb+Jpal1AY70Rex+phIedrHR7zVvR5nGjbZMzVmk23ArCUPUWQNIPkcXOVWgydOTZNghQvYLH1k5W8uHu+zOFfb8qGgP/wbubDyWNZf+QwY1ZugmExTui7XruCokJhhlhMQOONNDvMi3XqctrjDY4gGmfPj7guz4jIAGzQD+kTzo+D2/k+eigiZS2AWeYYaVigk3e0o6tgUH6AmuIIcvxFLnFHRZvbEhi51tfVTKq5Lzesv1SVGs5hgW3BftapFvjUAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4ntEiPW6qZAUL+YVbae6J2SqRAoFwxotlv1Vle85hY=;
 b=ozBNcUgteiYNTSb4NV7UUpfLM9Bcjmf4ewDPDb7Q2Ej5f6HBVtw8rW/ds8IEiTqbLmL/ajT+l6PMOMTT5BMrS0plFTAMzn2fyupE5P9CR0gbvbDYYiLYamKDMdRXdVpMr/Sf1Hw1LyfASEKj+IXUVyMZYMmf6gs125TMjUDyryg=
Received: from MN2PR11MB4269.namprd11.prod.outlook.com (2603:10b6:208:190::32)
 by MN2PR11MB3792.namprd11.prod.outlook.com (2603:10b6:208:f7::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 29 Apr
 2020 14:44:06 +0000
Received: from MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::ef:e9a9:8618:bc9f]) by MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::ef:e9a9:8618:bc9f%7]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 14:44:06 +0000
From:   <Daire.McNamara@microchip.com>
To:     <hch@infradead.org>
CC:     <amurray@thegoodpenguin.co.uk>, <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <helgaas@kernel.org>
Subject: Re: [PATCH v8 0/1] PCI: microchip: Add host driver for Microchip PCIe
 controller
Thread-Topic: [PATCH v8 0/1] PCI: microchip: Add host driver for Microchip
 PCIe controller
Thread-Index: AQHWHgnYlyfiE9BLLUK3hvPoVULxTKiP8b4AgAA7cYA=
Date:   Wed, 29 Apr 2020 14:44:05 +0000
Message-ID: <0570e334b4816aef76be9e71e132eac5d14cd43f.camel@microchip.com>
References: <a71cee05633ffac508366d66ca23a467716b14b7.camel@microchip.com>
         <20200429111120.GA19649@infradead.org>
In-Reply-To: <20200429111120.GA19649@infradead.org>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [89.101.219.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dac06326-0a77-49d6-92e4-08d7ec4bc4c2
x-ms-traffictypediagnostic: MN2PR11MB3792:
x-microsoft-antispam-prvs: <MN2PR11MB379223161FE3489A973A7AFD96AD0@MN2PR11MB3792.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 03883BD916
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(396003)(366004)(39860400002)(136003)(8936002)(2906002)(6916009)(316002)(54906003)(4326008)(8676002)(2616005)(478600001)(186003)(6486002)(26005)(6506007)(36756003)(5660300002)(66476007)(66946007)(4744005)(71200400001)(64756008)(6512007)(91956017)(66556008)(66446008)(86362001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hYU5wN7AlLPIXL7ytBaKaIJabgEQewm4/d8ReJnGAOCiss1DEjr481tMu+IaZbW9R5jakEa3oSWeq+RspgAHTT0Mf/JGomu3zkNKQK+cSRuFc2OxcxGce0CIh6hqWWls6pRAhXpp3VCfULqwt8V2XOiCmft0Wt9sBMzlzfAmKxvBzfbSqP+b36eL11T10H0EjohJPPSfNKfVHRuDsFxM/fPEbGxoKnu+SjuLdrY7VzhMmnBjSxH4/31QLBNtVW74O8mz2yIAzEh13mMipe9EgueJNcYf7RmvullTF3IDUc+/Og+k0BEZ3ieWnPBNuLQBwmxGA2IxjWY0zM247UUKWmRsGfcHJ6863CbT6qynZ0/am7ssJtz0h6DKOQgGEog/9vHBM7MOpzEpTfdYmvrf2bIe1P160pKE6tnA799YI13mH7+lKAhVvj01M4RtwM8g
x-ms-exchange-antispam-messagedata: NC0hF2l/HFbxF97rRKLisC0vv+CAueN2lKkMSju5nmRmP0bxXl2VsFYkKeBNhfu26JGGW3r6jLSthNJHyG54yoZGnA6P5Mj/7hirqhVKTjoWv225sG+l+AMNGBcSvfNliyPQt1uiIzq97wC36r9SbdUCsNJOFpZvmL3BoEYQs7Wy0lZNxP6b+y2BFLIUuRXGzDgLUf1YwtDVUcM3sP3U444fuIAoa2Dd7b3E86yGtOk0JNsb/W9TqjSQ6u23y7YAjTOlxhneubfNX1KBF6N/nEMwyiAJLg9mWsv+EjJ49o4MJFF4OGp/WOPrAeFLXKAxeJXmfi4K1s9OhwXbrG5AjRwUMfM0jkdeETlyYUPslsDtUdth4lkU8sbovNO8a7302N47a7GGLblixKlQ6kYd1+We6Sg9fqDt3P0eeCw4zrssljz5jFUJK8V5tLTQf1qfmEejwoFDeaCqvPzGR1SEQFT17fjrsU+yMgX0Qh8rLOCw2Evw6bctneVsVcuMPYfO0jK2c4MaKwv5wkcnhzK/sfqQsIdd/r09Y6EuNh4Z1rBSWLKEImUhT3rer74sGXzttviXI/FPLrJgb9VwfxJXWWIuuBLktj2qn9Q12mZITcfPfI9iRN8ouqECMJHXS4WCtOCzTVV0D/imCAgfUHlMAkvYoXymF9L66/1kH1klA1LXVgUxdIbeD5ItwPKg/epcd8u6F5LmRBxkQezXgqSluNTDyXDtQBtBdo1FaHwPi1NJQGFj/bdXKfqZP0NCX4U4BZRPrUxhICJslGrIyoRzIRPcXCf/r8T48eFDBeGcZkI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB0240BEDC53824CA4B0F880DFA7AA70@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dac06326-0a77-49d6-92e4-08d7ec4bc4c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 14:44:06.2433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kL05NoJ/iN3SyBKsJQptd6W3joU2eQ87mX13Ccqw4/POL7Go8qNQa7a4uJ+PntolD5QDIf1a2qK44EuUEzszgoKn7EFmgc+Tz2O4wxz7UdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3792
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDIwLTA0LTI5IGF0IDA0OjExIC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBXZWQs
IEFwciAyOSwgMjAyMCBhdCAwOTozNzo0OUFNICswMDAwLCANCj4gRGFpcmUuTWNOYW1hcmFAbWlj
cm9jaGlwLmNvbSB3cm90ZToNCj4gPiBUaGlzIHY4IHBhdGNoIGFkZHMgc3VwcG9ydCBmb3IgdGhl
IE1pY3JvY2hpcCBQQ0llIFBvbGFyRmlyZSBQQ0llDQo+ID4gY29udHJvbGxlciB3aGVuIGNvbmZp
Z3VyZWQgaW4gaG9zdCAoUm9vdCBDb21wbGV4KSBtb2RlLg0KPiA+IA0KPiA+IFVwZGF0ZXMgc2lu
Y2Ugdjc6DQo+ID4gKiBCdWlsZCBmb3IgNjRiaXQgUklTQ1YgYXJjaGl0ZWN0dXJlIG9ubHkNCj4g
DQo+IHdoeT8NClRoZSBQQ0llIGhhcmR3YXJlIGlzIG9ubHkgYXZhaWxhYmxlIG9uIDY0LWJpdCBS
SVNDViBiYXNlZCBwbGF0Zm9ybXMgYXQgdGhlIG1vbWVudC4gIE91ciBpbnRlbnRpb24gaXMgdG8g
ZXh0ZW5kIHRoZSBkcml2ZXIsIGF0IGEgbGF0ZXIgZGF0ZSwgYXMgYW5kIHdoZW4gdGhlIGhhcmR3
YXJlIGJlY29tZXMgYXZhaWxhYmxlLg0KDQo=
