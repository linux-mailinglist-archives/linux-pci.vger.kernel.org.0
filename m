Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2DF212804
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jul 2020 17:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgGBPhR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jul 2020 11:37:17 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:17461 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbgGBPhR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jul 2020 11:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593704235; x=1625240235;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=ebJwwW6SScmWfhfj7urOMcrf/FelttpyX3jrMz8ZWhY=;
  b=XYJF9TOVfS4ZX9HvAs17cjZ/ya/jcKwims5YVC1AyyoXzh+EQHjfIKTa
   hhe1HW5Gw6uloazVLRmDsb4+u0ZyRLba8AiNwpwkdvABTkERvK03anYli
   59S43G1BUlPSUn58qT4wwL2M+hYz97EZ0niVL5JtvdYOsS8XCrv6KK5U7
   MVkwU0Z4pYRo4xOHcSxdod/psrFkAXTs1Uh3XLzczPWu8GhXaugWYCx5A
   JD16YfngxHGu2buy3BU+zjH0mwrT9z4UBvkkqkwnP0pZ5phwOyxlP5C+O
   rPKx6Zkikunb36W3EJMQGRnt2Bb7aUirazXwg0n86aLHWVaVySP89bDeW
   A==;
IronPort-SDR: Ca1HYBygDc25maL/UjrawLx5WdKKHCKGEWTkZlJtHen3f+wB6Z+qlTq61QGqdg5X1+r60PxE0/
 4wP/k7iwlgvdZK2t/6iDPs/6OEy8b3ZcckopGFKn+K3C81eiB7ZbEoiE4TXOJgIuBAb/iNpJGy
 DTGObqhpLesQcQtjyV//r8b8kHFBNoa0NnE+dIg0HuZDDtybXLYxSBCzKtr7g5dvQOgUyxuMkI
 e7euQpiAB7CWEcfmOesN8fuvwPHy9lGIWxwWRpqZvUOop0++eE4n/hn3HuBVUKhphbj597SQct
 EMA=
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="78586415"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Jul 2020 08:37:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 2 Jul 2020 08:37:15 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Thu, 2 Jul 2020 08:37:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwrYBvyOq6QhAMjuot6Ha8iyVqsG2hN2k8tcq86kIq9wxXiibdg1PyLPLc0bpZNoI33RPLvxKRCBuuSKqQ/R+HSXhgpjWdbOZr7X6AVBNSWjl8bgNxqGW+zJ3ftjCA9h9abjsFFHf7kDf6gP51AJzGGiFQTge8POv/5xRgBTxQwNeSMDDnjIT8kE3TceewX6D6m3lE9ELOzKrnQgZUWMoLp3PvpkTWir9kcurf90Vmm+5Gm8wJTqxdzaoeX0kKzvTCKGqjYY4nuFHNPcZStvRmhqtYgQXyc902vQ+QjnN0lMLRBGiYin7PckzBxf2O9xrFUN7/HmE0gSSq3ELSOQIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebJwwW6SScmWfhfj7urOMcrf/FelttpyX3jrMz8ZWhY=;
 b=JseqaGBwvZVvatwS4QB3fu6FXPOtQBd6lUfCWRGILmPfHtOjcKRR9rgN1CkH+ba55mP9Wlepk9UiG2cZEc4YJyl2SFmQ85EuTHqzYgxysPOmSFuimnaDP392P85SW4gSHfp9GRFiCMAPPdnz2Bv8wR7SIvMJgDzYYaonyqSvFf+7EyQsDyq7n+HKv3SEIMeMk764KK0HobP+PuQN2PfEShqtieazjiX2QJolknI6yknM5TOhbVRFJSUPx+PgXIa2Gk94IirSn5+BgavWOsKXkC2WeH9sNCGHy6JWGGhRKfOpLZk4N3T4gOKjR2Yl85UpgiH5xKsp/MZ5UIBAEZzQxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebJwwW6SScmWfhfj7urOMcrf/FelttpyX3jrMz8ZWhY=;
 b=H9x2mvTl1x5kw78Wg2zz6Hw1gwdUiKOX6R+nH/Y/ejjdLAen3K6uKZjwID1xOKM15dO4JgZCLoOaHeipE21ycy999PcZugFqwGM3L+RMkbaVP6onuKRgTFoFiAU6fg6OM3sf+i79FT60BSdp3zRwNE7o+ahmS/sDjy9a4ChyAPo=
Received: from MN2PR11MB4269.namprd11.prod.outlook.com (2603:10b6:208:190::32)
 by BL0PR11MB2946.namprd11.prod.outlook.com (2603:10b6:208:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Thu, 2 Jul
 2020 15:37:12 +0000
Received: from MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::8d6f:606b:5ddc:d5cb]) by MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::8d6f:606b:5ddc:d5cb%2]) with mapi id 15.20.3131.036; Thu, 2 Jul 2020
 15:37:12 +0000
From:   <Daire.McNamara@microchip.com>
To:     <amurray@thegoodpenguin.co.uk>, <rob+dt@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <linux-pci@vger.kernel.org>,
        <bhelgaas@google.com>, <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>
Subject: [PATCH v12 0/2] PCI: microchip: Add host driver for Microchip PCIe
 controller
Thread-Topic: [PATCH v12 0/2] PCI: microchip: Add host driver for Microchip
 PCIe controller
Thread-Index: AQHWUIanSCscDxxci0Kk4zdyBO6TlQ==
Date:   Thu, 2 Jul 2020 15:37:12 +0000
Message-ID: <97e528fd7582186d7db4073c78d72601b2ce553f.camel@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: thegoodpenguin.co.uk; dkim=none (message not signed)
 header.d=none;thegoodpenguin.co.uk; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [89.101.219.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d311d271-2418-469d-1e41-08d81e9dca5d
x-ms-traffictypediagnostic: BL0PR11MB2946:
x-microsoft-antispam-prvs: <BL0PR11MB2946FC411A3BF55942CCC6AE966D0@BL0PR11MB2946.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ScKmWP5sIzZuPCUQValOJWrtW8oiwTsFtP36s8ccFp5ROgME7jaVyDjBZCotueiQecPAnKLzM6KBSGytaigTq/WH/kGpNOtVBGxyfaIhi2deHenm1IQY08lpt5Uf2pKIfuZCNsoDhEDSSmywOsY2yOjzRGFs5bN7VmJhBQTUEU3cqWp4UJ2l7bGw5L5TggVMYUawV68x2TrC2JC4y75bCF94/E1k5XUMT4hlh1u/9vwHRl/sBonX+6s7j0R+prILiZdDkG8EsXrmR0did3/xDg+9KcqkYDWOdcs0YK2LCx6uSWvmWqCXClnvARrNnsLI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(366004)(136003)(396003)(39860400002)(66946007)(26005)(71200400001)(6512007)(186003)(478600001)(110136005)(6506007)(316002)(2616005)(2906002)(86362001)(5660300002)(6486002)(36756003)(66556008)(91956017)(66476007)(64756008)(66446008)(8936002)(76116006)(83380400001)(8676002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: +4ocluhga788UxlSl4XEczUCKx/ckrGNH/Vwau8QTO8+PiSHOdfSZrWKPfYJi+oR7NNXqZjW9bovWJmaOKsgwxKnQZoqA9uFLchySaFxLJj5zKs1+RgFE3PHOSh0otU5kCg/vFTrW+1OGvA6MW+x07th0uLWrR3+2itZIKg0V2H4a/3H1YgmCIFOWzllCUH2+2l1QavFqgWZIcM4bz7okECksYSEqSYTfvMq9Z04IKpOeWd5Si1KpTV+dG24eAGMBom+yRYpx8OvafwORaSBhtn/ayR8Xw1Nw5IjTP/aTeD5GvUvS+hAKx1ds0qczAB+f6dicbXBTVJll+9T+ai3XihyrLPDaF8PIILbUYzxq/mzUkDrgOcdpV+Nl0jpH5dhYFqbuEtxZ6o04k5kZHRznI8d1ew8nNpaoVQxdCMw5AaTLwI6RkdhWV7m0cshKRhO4CFUqQwjucC++47HdOsiZPhug39n5E8WpvkOM+zCk9ueHHwlOosW24ub3LRFm0pI
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACADABCC1F43DA45901968D23B8AA861@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d311d271-2418-469d-1e41-08d81e9dca5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 15:37:12.5105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aGNlm5vv0nocJC3xd1uBTbrIm3actFZD0SlZK/g1AySZ6qencFPyKqvqo1SyRjco20NgVG7vGXZvYgK31lg3Dj/4gMr7xlkyexh86QlEXQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB2946
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VGhpcyB2MTIgcGF0Y2ggYWRkcyBzdXBwb3J0IGZvciB0aGUgTWljcm9jaGlwIFBDSWUgUG9sYXJG
aXJlIFBDSWUNCmNvbnRyb2xsZXIgd2hlbiBjb25maWd1cmVkIGluIGhvc3QgKFJvb3QgQ29tcGxl
eCkgbW9kZS4NCg0KVXBkYXRlcyBzaW5jZSB2MTE6DQoqIEFkanVzdGVkIHNvIHlhbWwgZmlsZSBw
YXNzc2VzIG1ha2UgZHRfYmluZGluZ19jaGVjayB3aXRob3V0IHdhcm5pbmdzDQoNClVwZGF0ZXMg
c2luY2UgdjEwOg0KKiBBZGp1c3RlZCBkcml2ZXIgYXMgcGVyIFJvYiBIZXJyaW5nJ3MgY29tbWVu
dHMsIG5vdGFibHk6DQogIC0gdXNlIGNvbW1vbiBQQ0lfTVNJX0ZMQUdTIGRlZmluZXMNCiAgLSBy
ZWR1Y2Ugc3RvcmFnZSBvZiB1bm5lY2Vzc2FyeSB2YXJzIGluIG1jX3BjaWUgc3RydWN0DQogIC0g
c3dpdGNoZWQgdG8gcmVhZC93cml0ZSByZWxheGVkIHZhcmlhbnRzDQogIC0gZXh0ZW5kZWQgbG9j
ayBpbiBtc2lfZG9tYWluX2FsbG9jIHJvdXRpbmUNCiAgLSBpbXByb3ZlZCAzMmJpdCBzYWZldHks
IHN3aXRjaGVkIGZyb20gZmluZF9maXJzdF9iaXQoKSB0byBpbG9nMigpDQogIC0gcmVtb3ZlZCB1
bm5lY2Vzc2FyeSB0d2lkZGxlIG9mIGVDQU0gY29uZmlnIHNwYWNlDQoNClVwZGF0ZXMgc2luY2Ug
djk6DQoqIEFkanVzdGVkIGNvbW1pdCBsb2dzDQoqIG1ha2UgZHRfYmluZGluZ3NfY2hlY2sgcGFz
c2VzDQoNClVwZGF0ZXMgc2luY2Ugdjg6DQoqIFJlZmFjdG9yZWQgYXMgcGVyIFJvYiBIZXJyaW5n
J3MgY29tbWVudHM6DQogIC0gYmluZGluZ3MgaW4gc2NoZW1hIGZvcm1hdA0KICAtIEFkanVzdGVk
IGxpY2VuY2UgdG8gR1BMdjIuMA0KICAtIFJlZmFjdG9yZWQgYWNjZXNzIHRvIGNvbmZpZyBzcGFj
ZSBiZXR3ZWVuIGRyaXZlciBhbmQgY29tbW9uIGVDQU0gY29kZQ0KICAtIEFkb3B0ZWQgcGNpX2hv
c3RfcHJvYmUoKQ0KICAtIE1pc2NlbGxhbm91cyBvdGhlciBpbXByb3ZlbWVudHMNCg0KVXBkYXRl
cyBzaW5jZSB2NzoNCiogQnVpbGQgZm9yIDY0Yml0IFJJU0NWIGFyY2hpdGVjdHVyZSBvbmx5DQoN
ClVwZGF0ZXMgc2luY2UgdjY6DQoqIFJlZmFjdG9yZWQgdG8gdXNlIGNvbW1vbiBlQ0FNIGRyaXZl
cg0KKiBVcGRhdGVkIHRvIENPTkZJR19QQ0lFX01JQ1JPQ0hJUF9IT1NUIGV0Yw0KKiBGb3JtYXR0
aW5nIGltcHJvdmVtZW50cw0KKiBSZW1vdmVkIGNvZGUgZm9yIHNlbGVjdGlvbiBiZXR3ZWVuIGJy
aWRnZSAwIGFuZCAxDQoNClVwZGF0ZXMgc2luY2UgdjU6DQoqIEZpeGVkIEtjb25maWcgdHlwbyBu
b3RlZCBieSBSYW5keSBEdW5sYXANCiogVXBkYXRlZCB3aXRoIGNvbW1lbnRzIGZyb20gQmpvcm4g
SGVsZ2Fhcw0KDQpVcGRhdGVzIHNpbmNlIHY0Og0KKiBGaXggY29tcGlsZSBpc3N1ZXMuDQoNClVw
ZGF0ZXMgc2luY2UgdjM6DQoqIFVwZGF0ZSBhbGwgcmVmZXJlbmNlcyB0byBNaWNyb3NlbWkgdG8g
TWljcm9jaGlwDQoqIFNlcGFyYXRlIE1TSSBmdW5jdGlvbmFsaXR5IGZyb20gbGVnYWN5IFBDSWUg
aW50ZXJydXB0IGhhbmRsaW5nIGZ1bmN0aW9uYWxpdHkNCg0KVXBkYXRlcyBzaW5jZSB2MjoNCiog
U3BsaXQgb3V0IERUIGJpbmRpbmdzIGFuZCBWZW5kb3IgSUQgdXBkYXRlcyBpbnRvIHRoZWlyIG93
biBwYXRjaA0KICBmcm9tIFBDSWUgZHJpdmVyLg0KKiBVcGRhdGVkIENoYW5nZSBMb2cNCg0KVXBk
YXRlcyBzaW5jZSB2MToNCiogSW5jb3Jwb3JhdGUgZmVlZGJhY2sgZnJvbSBCam9ybiBIZWxnYWFz
DQoNCkRhaXJlIE1jTmFtYXJhICgyKToNCiAgUENJOiBtaWNyb2NoaXA6IEFkZCBob3N0IGRyaXZl
ciBmb3IgTWljcm9jaGlwIFBDSWUgY29udHJvbGxlcg0KICBQQ0k6IG1pY3JvY2hpcDogQWRkIGhv
c3QgZHJpdmVyIGZvciBNaWNyb2NoaXAgUENJZSBjb250cm9sbGVyDQoNCiAuLi4vYmluZGluZ3Mv
cGNpL21pY3JvY2hpcCxwY2llLWhvc3QueWFtbCAgICAgfCAgOTMgKysrDQogZHJpdmVycy9wY2kv
Y29udHJvbGxlci9LY29uZmlnICAgICAgICAgICAgICAgIHwgICA5ICsNCiBkcml2ZXJzL3BjaS9j
b250cm9sbGVyL01ha2VmaWxlICAgICAgICAgICAgICAgfCAgIDEgKw0KIGRyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvcGNpZS1taWNyb2NoaXAtaG9zdC5jICB8IDY4MyArKysrKysrKysrKysrKysrKysN
CiA0IGZpbGVzIGNoYW5nZWQsIDc4NiBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbWljcm9jaGlwLHBjaWUtaG9z
dC55YW1sDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1t
aWNyb2NoaXAtaG9zdC5jDQoNCg0KYmFzZS1jb21taXQ6IGNkNzcwMDZlMDFiMzE5OGM3NWZiNzgx
OWIzZDBmZjg5NzA5NTM5YmINCi0tIA0KMi4xNy4xDQoNCg==
