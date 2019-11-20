Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3E2C10321D
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 04:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfKTDpY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 22:45:24 -0500
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:56377
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727357AbfKTDpX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Nov 2019 22:45:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bH5X8GBBaUKuYG4L8ADJhMaShgFj4KTqPH00hF2dvRqiBXDUs8QdQCBwWoOCHVYYydCj2FRQIrHNjZCWQmuyCmmCgDYV0oy7Mivh/7RoexaUb7tezhb7GVyMWeey/v8/Hcp6UmgtIziGXQVlAEnh73/078KERkqqzclwIpZgIRNTlKpdmFabZgcg5AJvrB0x1b3cha99mdAop0eDiTRv+H9MvQBzPuA7Zmak/PxSDa62kXdaUMjxN4DeRZaPbiSYTZ0zO1YJ/anJRgGsl6+CIQ4AAn/j/EE3sqre9PUMuf8Kva/GsY19iTxfNP8Y8BUhpDcfghP6mT6oq1lC0eaO+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxfxjL+9tJO1nriAKhZqhuIOHwq50HOSdd+rFy1EngE=;
 b=Eh83aJVXzewlZNZm5vDDds2IUGtKtW7QEhfQPcMqRUOLhqM6bDecTmX+OA4/f7tF1je5b7X4yXleVaRtNqByfvgA1tBZvN8zKuzYG2pLd9TQ/5JAVfmCusTmB2Y9rfgLx6IbVo0abuykBt6FDueiQwZSxeemcuouMfq1QmAM9fTfxEFHM/gjMvlVgowwApSsHlYwBHFdtxcsTJylUT0vYh63OAVA4AzVbfp604FgOI9A4nbnwQOKyXCakJE5QbgCAG9As1Ly0/FLm6KG4qma7jU6dPLscc0O4tvpBmu1xiHnHqPs58c+ge8UuYw+i4BzwI5w5e31K7Wa14UnA9JvwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxfxjL+9tJO1nriAKhZqhuIOHwq50HOSdd+rFy1EngE=;
 b=Fky1RXKT4OA2cHabj+3yMbYV5W4RifM/M7nCPwnLreMzDEUbJie19MtWVCg8C+zJZ9p8RVD5WEeWrzcQuoxebc+yu0DD+0xhcmVeIfASxP2gNvfK1k81KjC16X/CCyVbY0KM2iqpDYWzyeb/RnzSwKCqFSvlFc4bS5dzBjXFRpw=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB5657.eurprd04.prod.outlook.com (20.179.9.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 20 Nov 2019 03:45:17 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::898f:3cd6:c225:7219]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::898f:3cd6:c225:7219%7]) with mapi id 15.20.2451.029; Wed, 20 Nov 2019
 03:45:17 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv9 00/12] PCI: Recode Mobiveil driver and add PCIe Gen4 driver
 for NXP Layerscape SoCs
Thread-Topic: [PATCHv9 00/12] PCI: Recode Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Thread-Index: AQHVn1Tsfp+9ZVhNFU2th1+s/za9wQ==
Date:   Wed, 20 Nov 2019 03:45:17 +0000
Message-ID: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0199.apcprd02.prod.outlook.com
 (2603:1096:201:20::11) To DB8PR04MB6747.eurprd04.prod.outlook.com
 (2603:10a6:10:10b::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4557d7ec-7fce-4afc-4fbd-08d76d6c0ed7
x-ms-traffictypediagnostic: DB8PR04MB5657:|DB8PR04MB5657:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB5657F7029350437B37A9D024844F0@DB8PR04MB5657.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(199004)(189003)(2201001)(54906003)(86362001)(36756003)(256004)(7736002)(305945005)(6116002)(66066001)(3846002)(110136005)(316002)(71190400001)(7416002)(1076003)(71200400001)(52116002)(2501003)(4326008)(5660300002)(66476007)(476003)(64756008)(66556008)(2616005)(66946007)(6512007)(66446008)(8676002)(386003)(6506007)(2906002)(99286004)(102836004)(6486002)(81166006)(81156014)(8936002)(50226002)(186003)(26005)(478600001)(14454004)(486006)(6436002)(25786009)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5657;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4mwWzxB45ziGvC1OAdR73Rv9zjOoSiqv9RRg3n/bLQYv8K6F9hvGA6rn9a01PiHaDQ1SKjrcfCW2/FJp5iwF58cpKRBbVJKaSuzabrvVMb2Cctn+0hViv5d1OdUtzr4yOD4aDdC55ybA6gyB2VVxpgFUsXSlR5hnrR2nQf7a08wy2Np7q6CcLJtuOI3CvdM3opYRQRck+Nvabw9QCMaYmZYS7VHQSLVa9A7cfU7QUVn+qB2w/ItDB09WRKErU0CPUyVWs6m7hEnlXE0w/Kdt1uywGWE2y43wHDL2xghl0QhHj9DHGMy971qWi82EWBkjwEW3PsvrSgsrWW+yWlxWAUTCpejPJEec0F+h2Kp0I7SOa/iFGlgW7H1b3vFylFyc+yL1VvmErUUjJ+4BPgTnDfJYWGOYlUBkQdycjCLJfuSRfOu/NrWPdk6BLVoo69iF
Content-Type: text/plain; charset="utf-8"
Content-ID: <815B273423C1F5439F7E8D28EB382DDA@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4557d7ec-7fce-4afc-4fbd-08d76d6c0ed7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 03:45:17.1950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3cDOUGDVrRLXPlx0TE6wYtvXGyTtjQwUM5bNBh6MSTLXn5JZmid+LHIvLXmyIUOnLrsUF9AjAHzSQ+wBHk4JyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5657
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KVGhpcyBwYXRjaCBz
ZXQgaXMgdG8gcmVjb2RlIHRoZSBNb2JpdmVpbCBkcml2ZXIgYW5kIGFkZA0KUENJZSBzdXBwb3J0
IGZvciBOWFAgTGF5ZXJzY2FwZSBzZXJpZXMgU29DcyBpbnRlZ3JhdGVkDQpNb2JpdmVpbCdzIFBD
SWUgR2VuNCBjb250cm9sbGVyLg0KDQpIb3UgWmhpcWlhbmcgKDEyKToNCiAgUENJOiBtb2JpdmVp
bDogUmUtYWJzdHJhY3QgdGhlIHByaXZhdGUgc3RydWN0dXJlDQogIFBDSTogbW9iaXZlaWw6IE1v
dmUgdGhlIGhvc3QgaW5pdGlhbGl6YXRpb24gaW50byBhIHJvdXRpbmUNCiAgUENJOiBtb2JpdmVp
bDogQ29sbGVjdCB0aGUgaW50ZXJydXB0IHJlbGF0ZWQgb3BlcmF0aW9ucyBpbnRvIGEgcm91dGlu
ZQ0KICBQQ0k6IG1vYml2ZWlsOiBNb2R1bGFyaXplIHRoZSBNb2JpdmVpbCBQQ0llIEhvc3QgQnJp
ZGdlIElQIGRyaXZlcg0KICBQQ0k6IG1vYml2ZWlsOiBBZGQgY2FsbGJhY2sgZnVuY3Rpb24gZm9y
IGludGVycnVwdCBpbml0aWFsaXphdGlvbg0KICBQQ0k6IG1vYml2ZWlsOiBBZGQgY2FsbGJhY2sg
ZnVuY3Rpb24gZm9yIGxpbmsgdXAgY2hlY2sNCiAgUENJOiBtb2JpdmVpbDogTWFrZSBtb2JpdmVp
bF9ob3N0X2luaXQoKSBjYW4gYmUgdXNlZCB0byByZS1pbml0IGhvc3QNCiAgUENJOiBtb2JpdmVp
bDogQWRkIDgtYml0IGFuZCAxNi1iaXQgQ1NSIHJlZ2lzdGVyIGFjY2Vzc29ycw0KICBkdC1iaW5k
aW5nczogUENJOiBBZGQgTlhQIExheWVyc2NhcGUgU29DcyBQQ0llIEdlbjQgY29udHJvbGxlcg0K
ICBQQ0k6IG1vYml2ZWlsOiBBZGQgUENJZSBHZW40IFJDIGRyaXZlciBmb3IgTlhQIExheWVyc2Nh
cGUgU29Dcw0KICBhcm02NDogZHRzOiBseDIxNjBhOiBBZGQgUENJZSBjb250cm9sbGVyIERUIG5v
ZGVzDQogIGFybTY0OiBkZWZjb25maWc6IEVuYWJsZSBDT05GSUdfUENJRV9MQVlFUlNDQVBFX0dF
TjQNCg0KIC4uLi9iaW5kaW5ncy9wY2kvbGF5ZXJzY2FwZS1wY2llLWdlbjQudHh0ICAgICB8ICA1
MiArKw0KIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAx
MCArLQ0KIC4uLi9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEuZHRzaSB8IDE2
MyArKysrKysNCiBhcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnICAgICAgICAgICAgICAgICAg
fCAgIDEgKw0KIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvS2NvbmZpZyAgICAgICAgICAgICAgICB8
ICAxMSArLQ0KIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvTWFrZWZpbGUgICAgICAgICAgICAgICB8
ICAgMiArLQ0KIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvS2NvbmZpZyAgICAgICB8
ICAzNCArKw0KIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvTWFrZWZpbGUgICAgICB8
ICAgNSArDQogLi4uL21vYml2ZWlsL3BjaWUtbGF5ZXJzY2FwZS1nZW40LmMgICAgICAgICAgIHwg
Mjc0ICsrKysrKysrKw0KIC4uLi9wY2llLW1vYml2ZWlsLWhvc3QuY30gICAgICAgICAgICAgICAg
ICAgICB8IDU0NCArKysrLS0tLS0tLS0tLS0tLS0NCiAuLi4vY29udHJvbGxlci9tb2JpdmVpbC9w
Y2llLW1vYml2ZWlsLXBsYXQuYyAgfCAgNjAgKysNCiAuLi4vcGNpL2NvbnRyb2xsZXIvbW9iaXZl
aWwvcGNpZS1tb2JpdmVpbC5jICAgfCAyMzAgKysrKysrKysNCiAuLi4vcGNpL2NvbnRyb2xsZXIv
bW9iaXZlaWwvcGNpZS1tb2JpdmVpbC5oICAgfCAyMjYgKysrKysrKysNCiAxMyBmaWxlcyBjaGFu
Z2VkLCAxMTU3IGluc2VydGlvbnMoKyksIDQ1NSBkZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAx
MDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9sYXllcnNjYXBlLXBj
aWUtZ2VuNC50eHQNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvY29udHJvbGxlci9t
b2JpdmVpbC9LY29uZmlnDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvbW9iaXZlaWwvTWFrZWZpbGUNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvY29u
dHJvbGxlci9tb2JpdmVpbC9wY2llLWxheWVyc2NhcGUtZ2VuNC5jDQogcmVuYW1lIGRyaXZlcnMv
cGNpL2NvbnRyb2xsZXIve3BjaWUtbW9iaXZlaWwuYyA9PiBtb2JpdmVpbC9wY2llLW1vYml2ZWls
LWhvc3QuY30gKDU0JSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvY29udHJvbGxl
ci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLXBsYXQuYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9iaXZlaWwuYw0KIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBkcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9iaXZlaWwuaA0K
DQotLSANCjIuMTcuMQ0KDQo=
