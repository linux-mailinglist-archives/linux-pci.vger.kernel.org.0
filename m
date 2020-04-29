Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C011BD86F
	for <lists+linux-pci@lfdr.de>; Wed, 29 Apr 2020 11:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgD2Jhy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Apr 2020 05:37:54 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:4120 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgD2Jhx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Apr 2020 05:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1588153072; x=1619689072;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=NOuptJ+pZbEAjNTtBK6fms+ox7byS5L4WK82pL0Ealk=;
  b=Mc1wQ07O449nl8Uttx6lxQlDTsZSO1KuPHC9W6mL5kH4XdXVYPyJPjYU
   f6mQIIRlwc87Qp9g71tkiT8Y2og9JV/KlzMvWyKCr5kBeCY0Cx0dV+dyG
   l4/vjaOaOi8lbu7mjYq/1/CAcSMrsZXoc37dpL/HAkhfg/sEKsvJTwKLT
   g5YNAuWAiV4g526ZbdXQVFY+tX3iRPCoT6nwTuw6MscQzMTD3PFE8sq3E
   o3el2dUZk70W+ZzNsOmddnWoXZ1+9yeffGfBn4Rpu9YGohwjiV7VWAuo7
   7ZFkj0nXBQBo6E5tr3Lwa+sx6OZV2hMsHCR2v1n2XbkRjCVoeDOK+u/OS
   Q==;
IronPort-SDR: i1caPPRAe+UM3Cnck20aWBKbv7xkPFc6zkypzIFWrBsNeA7fJDLHlLgyiujniuouKWOCdmdA9m
 TDVS0pYkYDhZjCIw1k2c6OXKCc/ADvllyeCAu6xFgye8QXwrd80Fsy2JVMN/BHi7JgL09nVXhg
 qcGLsUBKkZplIm/7KOseOJBgJyNOyCJwGOUZtw5K+9QqJ8QPcjFWL1E3D95Loq2INhRKlxTPfi
 qhGmQpLnJF3D9Ri1b3vgoR0/U7BFhHwIxO+oR8cznpcn+Nzvi24Ky4VoOOJCfsYBAbM0zLhkNL
 LtY=
X-IronPort-AV: E=Sophos;i="5.73,331,1583218800"; 
   d="scan'208";a="71879635"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Apr 2020 02:37:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 29 Apr 2020 02:37:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 29 Apr 2020 02:37:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6YIpXxnHMHaNN9LGHrSgvCgi5PNQKkGz9A+nzg5tncbDcdp+z7pKxFn2aLPUBt3KnlzTfIDj5WrgF8MHM9Y8bPYqwX/Rsha8Z8ntFjNXyJoq8low3VJ+VwIvCtqtVCqTw6Usk1E9dHyy6NCWM9ogmeuiX9hTkA/RMb/Vx+uGvXl4z90IotowHVrPwtsV9r4v8XLhkTcM6089/F8YYucqLKiLsaPlNJlm2Hv2RimBJqATdzxyhLgdkExIzav6YMurcMtnvINf9awtPL/LcQC0jj9CGKOhU/Dtr0HdHUxtTUp68v1oRNM1GGAPdA7kVK6QoR/zeIP3nxZnZ46IcMmNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOuptJ+pZbEAjNTtBK6fms+ox7byS5L4WK82pL0Ealk=;
 b=mTjOx5y4/WMKa71Gz8u4IhYgR1OabuuQV/xA33dhZHV9KYYRTZWoLELpxx9o90DAp8UlB4nevPXF4HNm7+GgOhy6UEOoFb3gHN1E+SR6R1gN+jPt+yDrEIC96oZDjm+DR4EKp3Hk6QsAkt2hTjZrkhG20VRGggbOgB5wLQNYJ95hz9sf/D9Yisg7oIudSmg6MtfPo7/QtjI5keS3uZfXsyvGND+3G2hkykVFAtEi8eazHN8WgYs60F2OtWhdKtW6CCX/B8PeHqss3h+zMMuqpGQ0YI3k5288pKBOM5J9GvRuZfQO4CpnMuOeDvz1WqN2+fpcmDs3REMrogQwpqMSxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOuptJ+pZbEAjNTtBK6fms+ox7byS5L4WK82pL0Ealk=;
 b=KCaUokF3xyy7dpi3jiZS03cwNuTD2xeLkeBTBp8IUQ2lhxvQuF9bxCd3JZnmfxtQdKboxOB2JWLgkeK0Zhlnb1G8Lco3YH/2oyms+2YRye48mPvL0ih8ry4QTXNr7lDtrnVht/+lIBJsu8mjbmVhU+10WbQ32HsWGjmr4PJ6wmI=
Received: from MN2PR11MB4269.namprd11.prod.outlook.com (2603:10b6:208:190::32)
 by MN2PR11MB3952.namprd11.prod.outlook.com (2603:10b6:208:153::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 29 Apr
 2020 09:37:49 +0000
Received: from MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::ef:e9a9:8618:bc9f]) by MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::ef:e9a9:8618:bc9f%7]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 09:37:49 +0000
From:   <Daire.McNamara@microchip.com>
To:     <amurray@thegoodpenguin.co.uk>, <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <helgaas@kernel.org>
Subject: [PATCH v8 0/1] PCI: microchip: Add host driver for Microchip PCIe
 controller
Thread-Topic: [PATCH v8 0/1] PCI: microchip: Add host driver for Microchip
 PCIe controller
Thread-Index: AQHWHgnYlyfiE9BLLUK3hvPoVULxTA==
Date:   Wed, 29 Apr 2020 09:37:49 +0000
Message-ID: <a71cee05633ffac508366d66ca23a467716b14b7.camel@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: thegoodpenguin.co.uk; dkim=none (message not signed)
 header.d=none;thegoodpenguin.co.uk; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [89.101.219.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee93b916-d34e-4e8c-271f-08d7ec20fb89
x-ms-traffictypediagnostic: MN2PR11MB3952:
x-microsoft-antispam-prvs: <MN2PR11MB395269DD3261B8AB2CE44FEE96AD0@MN2PR11MB3952.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:489;
x-forefront-prvs: 03883BD916
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(39860400002)(366004)(376002)(136003)(396003)(8676002)(71200400001)(6512007)(36756003)(2906002)(5660300002)(186003)(8936002)(6486002)(76116006)(2616005)(6506007)(66476007)(66556008)(91956017)(86362001)(66946007)(64756008)(478600001)(110136005)(26005)(316002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XpjrRgyH8pquM5z7swA19NPwDnnDL3W+1so8U+oJ8F7qX7zN2omOmc6Oiv55dpduHcliT5FmMexH4VttaHgpBapWq3m2WehU3KH9rMCWggqlok81xXDfR1DioTLNU8AIyqp7v0uxHwgs8JSccD+i8KbCe9ndFfHVZRitOxJNkZfiJiwqff4dsXkqUpPjoY3krzSquRvnWqaBapUWEo8TxHxbPDv5Zl8+ihjRSO1tbPnNfpDqZlxpT644ukKhszHxWUP7QXRsf8uGhgBnSVVzU4ZIBgWfWrhHq6Mcb6p++sNUo/+oUi4rw1eibe5RlAewEA5yERtHfo0NLd1qI6r5y8LxZJlbg7NJwQSLM1/vrxlq/LgOXywBNznIzqsQKivPIakxDlo4n11kPODd0sLIXk/eY7wnjCB6Wt90vsJv4rz7ZgS2jELQA+P31Q01EKpg
x-ms-exchange-antispam-messagedata: BtxIhmbwU69ty+GUCIfTIdUTXix3dttCp8LaObfrIuFHbAO71wjQu2TB7LoEdYV0wBk0aAF7Pr+tmLMsOyA3F7XkxjNxNsZlOXi4fttnagwjhRjapq9r7QVs+ajjLFtpH+NqOc5qRBP28KeAjRxpsbIHyLrbnw17uO07wIRmzZAYhNZmrNYJ9gVxHKUse7xOVoRJy2Jvist1VVOSVIeffRt0cLOU0n3m887+JPvBCfr4jSKxfwPe1bypBv0rz6GtNJMAPa3eFnVEdR7zPp0Mnm0qSgOvuSMLmHxVFfCM7pkKhA8KqnmTQqBK0b1ASP/Ln691lfmhKAybEa8RnqFrnpS18Qxrt20ClxP3o2/kJ9pyg9nSspxLSNq0dcylXrpAzkynm5WVIfLqziI+/ZH/AXwjN7z/bwI0O95NAo1+bvILqaNtFSh2zWgLi3VeQ9jvy0D1Wgb7erNVcipjEonC4mgYXM76jOsExXJ5LCJmAhybLuNTwAiIqKGaZDgxFVE/Mrk2S6b/p2gYFX7ZcLJa1uDO8LuXkfXZk2sbUAFHdlXMS2dDh/o4TH9qdwkTaSEh07buqynmlbM8dmE45H8E/S09U53l33wpADcbTiHJPijX39udqOfJe505AMjTZjp6NlOXeuWjtNp2Z1JAfxa64jOVBz2gVc32+qh756t6gNZvxA6EaM9umM4/5CbCrX53r158sFLjcc/gJp7xFhSB2L4JdnEG+i3WeP88uY5SYMOgDUdjNmqucSQVwPjzXAfz9I+WR98kHtdgksbbuuC225UnH1tLd7uDd/+rf92EZ1c=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E52A2377578824FA8EA13CCC86AFDD1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ee93b916-d34e-4e8c-271f-08d7ec20fb89
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 09:37:49.7573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z8rByV7ss9vgJeZoHXSKiDCSad9e8PDu8Lke4ze4SfhvwspjVfB9S8/Thw85W3QEiYxEUjSlJj5Kvr8BfcSBWYlITJvNO6zTpb65mExC6pQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3952
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VGhpcyB2OCBwYXRjaCBhZGRzIHN1cHBvcnQgZm9yIHRoZSBNaWNyb2NoaXAgUENJZSBQb2xhckZp
cmUgUENJZQ0KY29udHJvbGxlciB3aGVuIGNvbmZpZ3VyZWQgaW4gaG9zdCAoUm9vdCBDb21wbGV4
KSBtb2RlLg0KDQpVcGRhdGVzIHNpbmNlIHY3Og0KKiBCdWlsZCBmb3IgNjRiaXQgUklTQ1YgYXJj
aGl0ZWN0dXJlIG9ubHkNCg0KVXBkYXRlcyBzaW5jZSB2NjoNCiogUmVmYWN0b3JlZCB0byB1c2Ug
Y29tbW9uIGVDQU0gZHJpdmVyDQoqIFVwZGF0ZWQgdG8gQ09ORklHX1BDSUVfTUlDUk9DSElQX0hP
U1QgZXRjDQoqIEZvcm1hdHRpbmcgaW1wcm92ZW1lbnRzDQoqIFJlbW92ZWQgY29kZSBmb3Igc2Vs
ZWN0aW9uIGJldHdlZW4gYnJpZGdlIDAgYW5kIDENCg0KVXBkYXRlcyBzaW5jZSB2NToNCiogRml4
ZWQgS2NvbmZpZyB0eXBvIG5vdGVkIGJ5IFJhbmR5IER1bmxhcA0KKiBVcGRhdGVkIHdpdGggY29t
bWVudHMgZnJvbSBCam9ybiBIZWxnYWFzDQoNClVwZGF0ZXMgc2luY2UgdjQ6DQoqIEZpeCBjb21w
aWxlIGlzc3Vlcy4NCg0KVXBkYXRlcyBzaW5jZSB2MzoNCiogVXBkYXRlIGFsbCByZWZlcmVuY2Vz
IHRvIE1pY3Jvc2VtaSB0byBNaWNyb2NoaXANCiogU2VwYXJhdGUgTVNJIGZ1bmN0aW9uYWxpdHkg
ZnJvbSBsZWdhY3kgUENJZSBpbnRlcnJ1cHQgaGFuZGxpbmcgZnVuY3Rpb25hbGl0eQ0KDQpVcGRh
dGVzIHNpbmNlIHYyOg0KKiBTcGxpdCBvdXQgRFQgYmluZGluZ3MgYW5kIFZlbmRvciBJRCB1cGRh
dGVzIGludG8gdGhlaXIgb3duIHBhdGNoDQogIGZyb20gUENJZSBkcml2ZXIuDQoqIFVwZGF0ZWQg
Q2hhbmdlIExvZw0KDQpVcGRhdGVzIHNpbmNlIHYxOg0KKiBJbmNvcnBvcmF0ZSBmZWVkYmFjayBm
cm9tIEJqb3JuIEhlbGdhYXMNCg0KRGFpcmUgTWNOYW1hcmEgKDEpOg0KICBQQ0k6IG1pY3JvY2hp
cDogQWRkIGhvc3QgZHJpdmVyIGZvciBNaWNyb2NoaXAgUENJZSBjb250cm9sbGVyDQoNCiAuLi4v
YmluZGluZ3MvcGNpL21pY3JvY2hpcC1wY2llLnR4dCAgICAgICAgICAgfCAgNjQgKysNCiBkcml2
ZXJzL3BjaS9jb250cm9sbGVyL0tjb25maWcgICAgICAgICAgICAgICAgfCAgIDkgKw0KIGRyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvTWFrZWZpbGUgICAgICAgICAgICAgICB8ICAgMSArDQogZHJpdmVy
cy9wY2kvY29udHJvbGxlci9wY2llLW1pY3JvY2hpcC1ob3N0LmMgIHwgNzAyICsrKysrKysrKysr
KysrKysrKw0KIDQgZmlsZXMgY2hhbmdlZCwgNzc2IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9taWNyb2NoaXAt
cGNpZS50eHQNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ll
LW1pY3JvY2hpcC1ob3N0LmMNCg0KDQpiYXNlLWNvbW1pdDogYzBjYzI3MTE3M2IyZTFjMmQ4ZDBj
ZWFlZjE0ZTRkZmE3OWVlZmMwZA0KLS0NCjIuMTcuMQ0KDQo=
