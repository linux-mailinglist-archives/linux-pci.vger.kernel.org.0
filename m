Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA0A1F6D5F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jun 2020 20:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgFKSYS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jun 2020 14:24:18 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:58812 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgFKSYS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jun 2020 14:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1591899856; x=1623435856;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=zuD9CBfORn9PFCWsqK/B6EAfCOKRSZ8A95JL/5lkfUs=;
  b=0/zI01fXuAtgnjrHuse0dhCERaF3RmjnY6NzEvuwZ7uRLkZoV9kgd5KQ
   PvW4v0RCmKsMHWaWCI68Uy8BEbx3uh+a7ZihFvYg+ALU+pSVb6y27++NE
   wLyPoUt8RlXyfB1FQVz427dtnYK7Vz45JCYck4oaorHtuKQLjNE23fVyS
   PSAiWGwpRTA4HUbIcCbQO/Ta2FqV8RdO3kvy2SMeXeQS9/M36zl4ron4O
   xbFSVfIQVbDnr64vUtiQgyGRwKcgjMcLxZ5l3ksBFYGTf5c1aPWztc7dq
   5biYYWpGCa1IJWI9OFzlshIoHL9KK8WEvcQYZmzcZzPNgPATikfnp1fZF
   A==;
IronPort-SDR: zLex9s8bStPXeNS/2k8D4giYjLw8JVl6947Oi/2RhtShdb43It8267IiMpNHTNnpv4pa4Purie
 U54QT5akYGaJk2Tr3V5PETHVzyNQA7gFK3JmuKtRjKuc+NPkpf2ps6u73yMdbJS1z0rJns4daU
 Tq4PRLpB1xB2KKolsJ06VJIUF+gYSdQ1A5Dp/iLHkXaqQmEAIg/g9NegoK2J0cF96LZfqG2hFI
 OLSMArtcJAsEjCVJnKu4ojqq22Esh3meOv3Ki4QPzuaNLTOa4HvZjM1x7yT7kk2eugaZ5v9XeQ
 Rqc=
X-IronPort-AV: E=Sophos;i="5.73,500,1583218800"; 
   d="scan'208";a="76293252"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jun 2020 11:24:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 11 Jun 2020 11:24:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3 via Frontend
 Transport; Thu, 11 Jun 2020 11:24:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P837EB0zvNluTAF12YVez54FwXa9ifqyusxbs4ck2/I+UKOVZbnsZDptM3KQb5n8j6hKcG1PB8GXsqPDROBHRzDsuf470PwR8bin3BRznhJj9NQvD8Vjr3tCIXb1nOS5zVQjwFSewUlJwAKhNuLCDaSDz8a5HD8sGv6UjRdq1LHNDBJajw0dnP+2TCNimb7wTaroaQqP1x9U95vnsvuXXxs1DdBwK9+hghdA9aKDprh/wrg6ILbHFvxhqooXyqomPxzw3mrw0fmdg4vuLumt6fLUP6tuNUhvQ6xnriJ8zyKN+FQ8FhqFbFpiBoAFXqVRocsn4ypkH0zGXCTbgnjMug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuD9CBfORn9PFCWsqK/B6EAfCOKRSZ8A95JL/5lkfUs=;
 b=Smgk0/+SZYcFjNk5I5DXV8zplU9Rd/csLxxkFpUWGDhLAxlCYLK6nYnp8h8gAk3EfIv2KvbrUYkTor89NSdKr5Y3FX7G+2ZNLOjerldUc250pl/zrhtN1jdeLUbwhmkbsa2Yu9xX0XGk929P8axE2WVZV3B0V++d/NYxOIpeLIAYJCPT+1WHu2EiKuNcTI6tpi+N9zZSCudKQ7vLCI51AvCMO+jWMmSaKH1zvR+bE8Ja+YyfUiO/NGdFLry6M7KUZ1dEGsSjmRcFGNDRk+vvVfU+g7llfjDlZ45dlVnanQTqiYxAjVYVA5U1CXZnfoTnGZLrffxRb9QwyZ6KIpce2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuD9CBfORn9PFCWsqK/B6EAfCOKRSZ8A95JL/5lkfUs=;
 b=NDKuQCqpqknLZjucbvH3EUGAf/IjUfgANVIjfzAQAJ1+SMQ9+qQq91Mt6wAROoFeG62VcYmyaVZVgAly7J+oXGBxmw+otAgk2gFAj7knXiGfwlQLUvxom6aQt6qfMs4yunvRFy7gqgwYuVq6OGK0l2jVSrbucwEND8ZDQRZegkM=
Received: from MN2PR11MB4269.namprd11.prod.outlook.com (2603:10b6:208:190::32)
 by MN2PR11MB4320.namprd11.prod.outlook.com (2603:10b6:208:195::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Thu, 11 Jun
 2020 18:24:12 +0000
Received: from MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::8d6f:606b:5ddc:d5cb]) by MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::8d6f:606b:5ddc:d5cb%2]) with mapi id 15.20.3088.021; Thu, 11 Jun 2020
 18:24:12 +0000
From:   <Daire.McNamara@microchip.com>
To:     <amurray@thegoodpenguin.co.uk>, <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>
Subject: [PATCH v11 2/2] PCI: microchip: Add host driver for Microchip PCIe
 controller
Thread-Topic: [PATCH v11 2/2] PCI: microchip: Add host driver for Microchip
 PCIe controller
Thread-Index: AQHWQB2Bp7ACvp2LZUy0NlpzIRz1Dg==
Date:   Thu, 11 Jun 2020 18:24:12 +0000
Message-ID: <8869ea1c241cbdf687ee78f342087cba4bb40bd1.camel@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: thegoodpenguin.co.uk; dkim=none (message not signed)
 header.d=none;thegoodpenguin.co.uk; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [89.101.219.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3eabda2-f6a7-421f-db06-08d80e34a426
x-ms-traffictypediagnostic: MN2PR11MB4320:
x-microsoft-antispam-prvs: <MN2PR11MB4320B850985D2E66C6171E4996800@MN2PR11MB4320.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1J/fvl41IS6TzbzJuDOWXa/Y0KEoNtOO3r7LEgxTxx3K0dLyMNijM1qo3A8m02rAcwVhESgrFIDvQO2uOPMKM0QNpP5amB8C+Se962wGoDbQBV+rYMm7ephIVzUa59NuhZvWpb+xMDDzBEiXH5728lL1t7gfb4K314KrDIkNRnAXHseCHUjhNPtxkoFQC+i1jzwUBwMM4Sk62GCZ9moFn5FnybGJCcXf9lNoj0VTkV3ct+VCll5y8vdA8NbqcWip8uu7FX/SazO51QEo7WcvPdb1F+Vs07sGkTdXKxvp8/FebawhObGmVjxjOtrYuaGOsjIRsK/WIx0hNWXnl4DtBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(366004)(346002)(396003)(376002)(8676002)(6486002)(110136005)(8936002)(83380400001)(86362001)(4326008)(30864003)(316002)(91956017)(6512007)(2616005)(64756008)(478600001)(66946007)(26005)(186003)(66556008)(6506007)(66476007)(2906002)(66446008)(76116006)(36756003)(5660300002)(71200400001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: hdALYSZoKb/ZIXvjj44YUrfinxzStt/j9/MY/SHDPmx3M7r9XfAleK8NLpSw4m6qxn2cLJS6G99JVafKrI0bds2fqon7z/MP1RymeUFD6Ar2Ebbqtb/WxFlnf56jK7Y9AViC3ecs0LaXFgEl1tI1TRIYVCVtmpXEzuIzIq0TfV8fqyydKxEqHiqS9/aN4uphKp6BJgyMiEjFRpnURTCCjmbYX9xFQ/oOG7Aqw27Vp1zOrejFKrm73s8ESeAbaK6Sk8acqHjsRy0BcZPOHEt2HnYpSWI0dsFmSB4lw/Nx7C42xshJjVnGjT/ijyQFW90K4jycT98Z7quTqZFCyMibvs6wbpb90iGAWwvLkp9ubTGLc960rbPw7G6bh0dN/WCB35c89JrpgTE+Q1yQ/uygMekZ0kSqUs88S3+Mqj+6ZQjGSJc7PXxjc63YskvkqOvjmTSlJkfuSM1ylNg9ftddPc7da2Ly/Dxq1l7IMeqGjne7Jfre334JyrFuiisnT43r
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2832449EED072846A383B51964FC0907@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b3eabda2-f6a7-421f-db06-08d80e34a426
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 18:24:12.6634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6IfPytji00wYiwerGGfrvh0auQhihnXwxbOyZyN6xKqJZkL7Z4SgEP0T0L4Z5ugijzc/PUA5Vcw6RgMqPBL3ByXfZsVwJhmAP9eDd12weus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4320
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQphZGQgc3VwcG9ydCBmb3IgdGhlIE1pY3JvY2hpcCBQQ0llIFBvbGFyRmlyZSBQQ0llIGNvbnRy
b2xsZXIgd2hlbg0KY29uZmlndXJlZCBpbiBob3N0IChSb290IENvbXBsZXgpIG1vZGUuDQoNClNp
Z25lZC1vZmYtYnk6IERhaXJlIE1jTmFtYXJhIDxkYWlyZS5tY25hbWFyYUBtaWNyb2NoaXAuY29t
Pg0KLS0tDQogZHJpdmVycy9wY2kvY29udHJvbGxlci9LY29uZmlnICAgICAgICAgICAgICAgfCAg
IDkgKw0KIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvTWFrZWZpbGUgICAgICAgICAgICAgIHwgICAx
ICsNCiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWljcm9jaGlwLWhvc3QuYyB8IDY4MyAr
KysrKysrKysrKysrKysrKysrDQogMyBmaWxlcyBjaGFuZ2VkLCA2OTMgaW5zZXJ0aW9ucygrKQ0K
IGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWljcm9jaGlw
LWhvc3QuYw0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9LY29uZmlnIGIv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9LY29uZmlnDQppbmRleCBiMDhlZmVhMzk0OTYuLjJiZjVl
N2U4OTRmYiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvS2NvbmZpZw0KKysr
IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9LY29uZmlnDQpAQCAtMjg2LDYgKzI4NiwxNSBAQCBj
b25maWcgUENJX0xPT05HU09ODQogCSAgU2F5IFkgaGVyZSBpZiB5b3Ugd2FudCB0byBlbmFibGUg
UENJIGNvbnRyb2xsZXIgc3VwcG9ydCBvbg0KIAkgIExvb25nc29uIHN5c3RlbXMuDQogDQorY29u
ZmlnIFBDSUVfTUlDUk9DSElQX0hPU1QNCisJYm9vbCAiTWljcm9jaGlwIEFYSSBQQ0llIGhvc3Qg
YnJpZGdlIHN1cHBvcnQiDQorCWRlcGVuZHMgb24gUENJX01TSSAmJiBPRg0KKwlzZWxlY3QgUENJ
X01TSV9JUlFfRE9NQUlODQorCXNlbGVjdCBHRU5FUklDX01TSV9JUlFfRE9NQUlODQorCWhlbHAN
CisJICBTYXkgWSBoZXJlIGlmIHlvdSB3YW50IGtlcm5lbCB0byBzdXBwb3J0IHRoZSBNaWNyb2No
aXAgQVhJIFBDSWUNCisJICBIb3N0IEJyaWRnZSBkcml2ZXIuDQorDQogc291cmNlICJkcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9LY29uZmlnIg0KIHNvdXJjZSAiZHJpdmVycy9wY2kvY29udHJv
bGxlci9tb2JpdmVpbC9LY29uZmlnIg0KIHNvdXJjZSAiZHJpdmVycy9wY2kvY29udHJvbGxlci9j
YWRlbmNlL0tjb25maWciDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9NYWtl
ZmlsZSBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvTWFrZWZpbGUNCmluZGV4IGVmZDk3MzNlYWQy
Ni4uMjdmODliNDk5YzZlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9NYWtl
ZmlsZQ0KKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9NYWtlZmlsZQ0KQEAgLTI3LDYgKzI3
LDcgQEAgb2JqLSQoQ09ORklHX1BDSUVfUk9DS0NISVBfRVApICs9IHBjaWUtcm9ja2NoaXAtZXAu
bw0KIG9iai0kKENPTkZJR19QQ0lFX1JPQ0tDSElQX0hPU1QpICs9IHBjaWUtcm9ja2NoaXAtaG9z
dC5vDQogb2JqLSQoQ09ORklHX1BDSUVfTUVESUFURUspICs9IHBjaWUtbWVkaWF0ZWsubw0KIG9i
ai0kKENPTkZJR19QQ0lFX1RBTkdPX1NNUDg3NTkpICs9IHBjaWUtdGFuZ28ubw0KK29iai0kKENP
TkZJR19QQ0lFX01JQ1JPQ0hJUF9IT1NUKSArPSBwY2llLW1pY3JvY2hpcC1ob3N0Lm8NCiBvYmot
JChDT05GSUdfVk1EKSArPSB2bWQubw0KIG9iai0kKENPTkZJR19QQ0lFX0JSQ01TVEIpICs9IHBj
aWUtYnJjbXN0Yi5vDQogb2JqLSQoQ09ORklHX1BDSV9MT09OR1NPTikgKz0gcGNpLWxvb25nc29u
Lm8NCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWljcm9jaGlwLWhv
c3QuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1taWNyb2NoaXAtaG9zdC5jDQpuZXcg
ZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMDAwMDAwLi45MGQwNTExMDAxODENCi0tLSAv
ZGV2L251bGwNCisrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1taWNyb2NoaXAtaG9z
dC5jDQpAQCAtMCwwICsxLDY4MyBAQA0KKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwt
Mi4wDQorLyoNCisgKiBNaWNyb2NoaXAgQVhJIFBDSWUgQnJpZGdlIGhvc3QgY29udHJvbGxlciBk
cml2ZXINCisgKg0KKyAqIENvcHlyaWdodCAoYykgMjAxOCAtIDIwMTkgTWljcm9jaGlwIENvcnBv
cmF0aW9uLiBBbGwgcmlnaHRzIHJlc2VydmVkLg0KKyAqDQorICogQXV0aG9yOiBEYWlyZSBNY05h
bWFyYSA8ZGFpcmUubWNuYW1hcmFAbWljcm9jaGlwLmNvbT4NCisgKg0KKyAqIEJhc2VkIG9uOg0K
KyAqCXBjaWUtcmNhci5jDQorICoJcGNpZS14aWxpbnguYw0KKyAqCXBjaWUtYWx0ZXJhLmMNCisg
Ki8NCisjaW5jbHVkZSA8bGludXgvaXJxY2hpcC9jaGFpbmVkX2lycS5oPg0KKyNpbmNsdWRlIDxs
aW51eC9tb2R1bGUuaD4NCisjaW5jbHVkZSA8bGludXgvbXNpLmg+DQorI2luY2x1ZGUgPGxpbnV4
L29mX2FkZHJlc3MuaD4NCisjaW5jbHVkZSA8bGludXgvb2ZfaXJxLmg+DQorI2luY2x1ZGUgPGxp
bnV4L29mX3BjaS5oPg0KKyNpbmNsdWRlIDxsaW51eC9wY2ktZWNhbS5oPg0KKyNpbmNsdWRlIDxs
aW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCisNCisjaW5jbHVkZSAiLi4vcGNpLmgiDQorDQorLyog
TnVtYmVyIG9mIE1TSSBJUlFzICovDQorI2RlZmluZSBNQ19OVU1fTVNJX0lSUVMJCQkJMzINCisj
ZGVmaW5lIE1DX05VTV9NU0lfSVJRU19DT0RFRAkJCTUNCisNCisvKiBQQ0llIEJyaWRnZSBQaHkg
YW5kIENvbnRyb2xsZXIgUGh5IG9mZnNldHMgKi8NCisjZGVmaW5lIE1DX1BDSUUxX0JSSURHRV9B
RERSCQkJMHgwMDAwODAwMHUNCisjZGVmaW5lIE1DX1BDSUUxX0NUUkxfQUREUgkJCTB4MDAwMGEw
MDB1DQorDQorLyogUENJZSBDb250cm9sbGVyIFBoeSBSZWdzICovDQorI2RlZmluZSBNQ19TRUNf
RVJST1JfSU5UCQkJMHgyOA0KKyNkZWZpbmUgIFNFQ19FUlJPUl9JTlRfVFhfUkFNX1NFQ19FUlJf
SU5UCUdFTk1BU0soMywgMCkNCisjZGVmaW5lICBTRUNfRVJST1JfSU5UX1JYX1JBTV9TRUNfRVJS
X0lOVAlHRU5NQVNLKDcsIDQpDQorI2RlZmluZSAgU0VDX0VSUk9SX0lOVF9QQ0lFMkFYSV9SQU1f
U0VDX0VSUl9JTlQJR0VOTUFTSygxMSwgOCkNCisjZGVmaW5lICBTRUNfRVJST1JfSU5UX0FYSTJQ
Q0lFX1JBTV9TRUNfRVJSX0lOVAlHRU5NQVNLKDE1LCAxMikNCisjZGVmaW5lIE1DX1NFQ19FUlJP
Ul9JTlRfTUFTSwkJCTB4MmMNCisjZGVmaW5lIE1DX0RFRF9FUlJPUl9JTlQJCQkweDMwDQorI2Rl
ZmluZSAgREVEX0VSUk9SX0lOVF9UWF9SQU1fREVEX0VSUl9JTlQJR0VOTUFTSygzLCAwKQ0KKyNk
ZWZpbmUgIERFRF9FUlJPUl9JTlRfUlhfUkFNX0RFRF9FUlJfSU5UCUdFTk1BU0soNywgNCkNCisj
ZGVmaW5lICBERURfRVJST1JfSU5UX1BDSUUyQVhJX1JBTV9ERURfRVJSX0lOVAlHRU5NQVNLKDEx
LCA4KQ0KKyNkZWZpbmUgIERFRF9FUlJPUl9JTlRfQVhJMlBDSUVfUkFNX0RFRF9FUlJfSU5UCUdF
Tk1BU0soMTUsIDEyKQ0KKyNkZWZpbmUgTUNfREVEX0VSUk9SX0lOVF9NQVNLCQkJMHgzNA0KKyNk
ZWZpbmUgTUNfRUNDX0NPTlRST0wJCQkJMHgzOA0KKyNkZWZpbmUgIEVDQ19DT05UUk9MX0FYSTJQ
Q0lFX1JBTV9FQ0NfQllQQVNTCUJJVCgyNykNCisjZGVmaW5lICBFQ0NfQ09OVFJPTF9QQ0lFMkFY
SV9SQU1fRUNDX0JZUEFTUwlCSVQoMjYpDQorI2RlZmluZSAgRUNDX0NPTlRST0xfUlhfUkFNX0VD
Q19CWVBBU1MJCUJJVCgyNSkNCisjZGVmaW5lICBFQ0NfQ09OVFJPTF9UWF9SQU1fRUNDX0JZUEFT
UwkJQklUKDI0KQ0KKyNkZWZpbmUgTUNfTFRTU01fU1RBVEUJCQkJMHg1Yw0KKyNkZWZpbmUgIExU
U1NNX0wwX1NUQVRFCQkJCTB4MTANCisjZGVmaW5lIE1DX1BDSUVfRVZFTlRfSU5UCQkJMHgxNGMN
CisjZGVmaW5lICBQQ0lFX0VWRU5UX0lOVF9MMl9FWElUX0lOVAkJQklUKDApDQorI2RlZmluZSAg
UENJRV9FVkVOVF9JTlRfSE9UUlNUX0VYSVRfSU5UCQlCSVQoMSkNCisjZGVmaW5lICBQQ0lFX0VW
RU5UX0lOVF9ETFVQX0VYSVRfSU5UCQlCSVQoMikNCisjZGVmaW5lICBQQ0lFX0VWRU5UX0lOVF9M
Ml9FWElUX0lOVF9NQVNLCUJJVCgxNikNCisjZGVmaW5lICBQQ0lFX0VWRU5UX0lOVF9IT1RSU1Rf
RVhJVF9JTlRfTUFTSwlCSVQoMTcpDQorI2RlZmluZSAgUENJRV9FVkVOVF9JTlRfRExVUF9FWElU
X0lOVF9NQVNLCUJJVCgxOCkNCisNCisvKiBQQ0llIEJyaWRnZSBQaHkgUmVncyAqLw0KKyNkZWZp
bmUgTUNfUENJRV9QQ0lfSURTX0RXMQkJCTB4OWMNCisNCisvKiBQQ0llIENvbmZpZyBzcGFjZSBN
U0kgY2FwYWJpbGl0eSBzdHJ1Y3R1cmUgKi8NCisjZGVmaW5lIE1DX01TSV9DQVBfQ1RSTF9PRkZT
RVQJCQkweGUwdQ0KKyNkZWZpbmUgIE1DX01TSV9NQVhfUV9BVkFJTAkJCShNQ19OVU1fTVNJX0lS
UVNfQ09ERUQgPDwgMSkNCisjZGVmaW5lICBNQ19NU0lfUV9TSVpFCQkJCShNQ19OVU1fTVNJX0lS
UVNfQ09ERUQgPDwgNCkNCisNCisjZGVmaW5lIE1DX0lNQVNLX0xPQ0FMCQkJCTB4MTgwDQorI2Rl
ZmluZSAgUENJRV9MT0NBTF9JTlRfRU5BQkxFCQkJMHgwZjAwMDAwMHUNCisjZGVmaW5lICBQQ0lf
SU5UUwkJCQkweDBmMDAwMDAwdQ0KKyNkZWZpbmUgIFBNX01TSV9JTlRfU0hJRlQJCQkyNA0KKyNk
ZWZpbmUgIFBDSUVfRU5BQkxFX01TSQkJCTB4MTAwMDAwMDB1DQorI2RlZmluZSAgTVNJX0lOVAkJ
CQkweDEwMDAwMDAwdQ0KKyNkZWZpbmUgIE1TSV9JTlRfU0hJRlQJCQkJMjgNCisjZGVmaW5lIE1D
X0lTVEFUVVNfTE9DQUwJCQkweDE4NA0KKyNkZWZpbmUgTUNfSU1BU0tfSE9TVAkJCQkweDE4OA0K
KyNkZWZpbmUgTUNfSVNUQVRVU19IT1NUCQkJCTB4MThjDQorI2RlZmluZSBNQ19NU0lfQUREUgkJ
CQkweDE5MA0KKyNkZWZpbmUgTUNfSVNUQVRVU19NU0kJCQkJMHgxOTQNCisNCisvKiBQQ0llIE1h
c3RlciB0YWJsZSBpbml0IGRlZmluZXMgKi8NCisjZGVmaW5lIE1DX0FUUjBfUENJRV9XSU4wX1NS
Q0FERFJfUEFSQU0JCTB4NjAwdQ0KKyNkZWZpbmUgIEFUUjBfUENJRV9BVFJfU0laRQkJCTB4MWYN
CisjZGVmaW5lICBBVFIwX1BDSUVfQVRSX1NJWkVfU0hJRlQJCTENCisjZGVmaW5lIE1DX0FUUjBf
UENJRV9XSU4wX1NSQ19BRERSCQkweDYwNHUNCisjZGVmaW5lIE1DX0FUUjBfUENJRV9XSU4wX1RS
U0xfQUREUl9MU0IJCTB4NjA4dQ0KKyNkZWZpbmUgTUNfQVRSMF9QQ0lFX1dJTjBfVFJTTF9BRERS
X1VEVwkJMHg2MGN1DQorI2RlZmluZSBNQ19BVFIwX1BDSUVfV0lOMF9UUlNMX1BBUkFNCQkweDYx
MHUNCisNCisvKiBQQ0llIEFYSSBzbGF2ZSB0YWJsZSBpbml0IGRlZmluZXMgKi8NCisjZGVmaW5l
IE1DX0FUUjBfQVhJNF9TTFYwX1NSQ0FERFJfUEFSQU0JCTB4ODAwdQ0KKyNkZWZpbmUgIEFUUl9T
SVpFX1NISUZUCQkJCTENCisjZGVmaW5lICBBVFJfSU1QTF9FTkFCTEUJCQkxDQorI2RlZmluZSBN
Q19BVFIwX0FYSTRfU0xWMF9TUkNfQUREUgkJMHg4MDR1DQorI2RlZmluZSBNQ19BVFIwX0FYSTRf
U0xWMF9UUlNMX0FERFJfTFNCCQkweDgwOHUNCisjZGVmaW5lIE1DX0FUUjBfQVhJNF9TTFYwX1RS
U0xfQUREUl9VRFcJCTB4ODBjdQ0KKyNkZWZpbmUgTUNfQVRSMF9BWEk0X1NMVjBfVFJTTF9QQVJB
TQkJMHg4MTB1DQorI2RlZmluZSAgUENJRV9UWF9SWF9JTlRFUkZBQ0UJCQkweDAwMDAwMDAwdQ0K
KyNkZWZpbmUgIFBDSUVfQ09ORklHX0lOVEVSRkFDRQkJCTB4MDAwMDAwMDF1DQorDQorI2RlZmlu
ZSBBVFRfRU5UUllfU0laRQkJCQkzMg0KKw0KK3N0cnVjdCBtY19tc2kgew0KKwlzdHJ1Y3QgbXV0
ZXggbG9jazsJCS8qIFByb3RlY3QgdXNlZCBiaXRtYXAgKi8NCisJc3RydWN0IGlycV9kb21haW4g
Km1zaV9kb21haW47DQorCXN0cnVjdCBpcnFfZG9tYWluICpkZXZfZG9tYWluOw0KKwl1MzIgbnVt
X3ZlY3RvcnM7DQorCXU2NCB2ZWN0b3JfcGh5Ow0KKwlERUNMQVJFX0JJVE1BUCh1c2VkLCBNQ19O
VU1fTVNJX0lSUVMpOw0KK307DQorDQorc3RydWN0IG1jX3BjaWUgew0KKwlzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2Ow0KKwl2b2lkIF9faW9tZW0gKmNmZ19iYXNlX2FkZHI7DQorCXZvaWQg
X19pb21lbSAqYnJpZGdlX2Jhc2VfYWRkcjsNCisJdm9pZCBfX2lvbWVtICpjdHJsX2Jhc2VfYWRk
cjsNCisJc3RydWN0IGlycV9kb21haW4gKmludHhfZG9tYWluOw0KKwlyYXdfc3BpbmxvY2tfdCBp
bnR4X21hc2tfbG9jazsNCisJc3RydWN0IG1jX21zaSBtc2k7DQorfTsNCisNCitzdGF0aWMgaW5s
aW5lIHUzMiBjZmdfcmVhZGwoc3RydWN0IG1jX3BjaWUgKnBjaWUsIGNvbnN0IHUzMiByZWcpDQor
ew0KKwlyZXR1cm4gcmVhZGxfcmVsYXhlZChwY2llLT5jZmdfYmFzZV9hZGRyICsgcmVnKTsNCit9
DQorDQorc3RhdGljIGlubGluZSB1MTYgY2ZnX3JlYWR3KHN0cnVjdCBtY19wY2llICpwY2llLCBj
b25zdCB1MTYgcmVnKQ0KK3sNCisJcmV0dXJuIHJlYWR3X3JlbGF4ZWQocGNpZS0+Y2ZnX2Jhc2Vf
YWRkciArIHJlZyk7DQorfQ0KKw0KK3N0YXRpYyBpbmxpbmUgdm9pZCBjZmdfd3JpdGVsKHN0cnVj
dCBtY19wY2llICpwY2llLCBjb25zdCB1MzIgdmFsLA0KKwkJCSAgICAgIGNvbnN0IHUzMiByZWcp
DQorew0KKwl3cml0ZWxfcmVsYXhlZCh2YWwsIHBjaWUtPmNmZ19iYXNlX2FkZHIgKyByZWcpOw0K
K30NCisNCitzdGF0aWMgaW5saW5lIHZvaWQgY2ZnX3dyaXRldyhzdHJ1Y3QgbWNfcGNpZSAqcGNp
ZSwgY29uc3QgdTE2IHZhbCwNCisJCQkgICAgICBjb25zdCB1MTYgcmVnKQ0KK3sNCisJd3JpdGV3
X3JlbGF4ZWQodmFsLCBwY2llLT5jZmdfYmFzZV9hZGRyICsgcmVnKTsNCit9DQorDQorc3RhdGlj
IHZvaWQgbWNfcGNpZV9lbmFibGUoc3RydWN0IG1jX3BjaWUgKnBjaWUpDQorew0KKwl1MzIgZW5i
Ow0KKw0KKwllbmIgPSByZWFkbF9yZWxheGVkKHBjaWUtPmJyaWRnZV9iYXNlX2FkZHIgKyBNQ19M
VFNTTV9TVEFURSk7DQorCWVuYiB8PSBMVFNTTV9MMF9TVEFURTsNCisJd3JpdGVsX3JlbGF4ZWQo
ZW5iLCBwY2llLT5icmlkZ2VfYmFzZV9hZGRyICsgTUNfTFRTU01fU1RBVEUpOw0KK30NCisNCitz
dGF0aWMgdm9pZCBtY19wY2llX2lzcihzdHJ1Y3QgaXJxX2Rlc2MgKmRlc2MpDQorew0KKwlzdHJ1
Y3QgaXJxX2NoaXAgKmNoaXAgPSBpcnFfZGVzY19nZXRfY2hpcChkZXNjKTsNCisJc3RydWN0IG1j
X3BjaWUgKnBjaWUgPSBpcnFfZGVzY19nZXRfaGFuZGxlcl9kYXRhKGRlc2MpOw0KKwlzdHJ1Y3Qg
ZGV2aWNlICpkZXYgPSAmcGNpZS0+cGRldi0+ZGV2Ow0KKwlzdHJ1Y3QgbWNfbXNpICptc2kgPSAm
cGNpZS0+bXNpOw0KKwl1bnNpZ25lZCBsb25nIHN0YXR1czsNCisJdW5zaWduZWQgbG9uZyBpbnR4
X3N0YXR1czsNCisJdW5zaWduZWQgbG9uZyBtc2lfc3RhdHVzOw0KKwl1MzIgYml0Ow0KKwl1MzIg
dmlycTsNCisNCisJLyoNCisJICogVGhlIGNvcmUgcHJvdmlkZXMgYSBzaW5nbGUgaW50ZXJydXB0
IGZvciBib3RoIElOVHgvTVNJIG1lc3NhZ2VzLg0KKwkgKiBTbyB3ZSdsbCByZWFkIGJvdGggSU5U
eCBhbmQgTVNJIHN0YXR1cy4NCisJICovDQorCWNoYWluZWRfaXJxX2VudGVyKGNoaXAsIGRlc2Mp
Ow0KKw0KKwlzdGF0dXMgPSByZWFkbF9yZWxheGVkKHBjaWUtPmJyaWRnZV9iYXNlX2FkZHIgKyBN
Q19JU1RBVFVTX0xPQ0FMKTsNCisJd2hpbGUgKHN0YXR1cyAmIChQQ0lfSU5UUyB8IE1TSV9JTlQp
KSB7DQorCQlpbnR4X3N0YXR1cyA9IChzdGF0dXMgJiBQQ0lfSU5UUykgPj4gUE1fTVNJX0lOVF9T
SElGVDsNCisJCWZvcl9lYWNoX3NldF9iaXQoYml0LCAmaW50eF9zdGF0dXMsIFBDSV9OVU1fSU5U
WCkgew0KKwkJCXZpcnEgPSBpcnFfZmluZF9tYXBwaW5nKHBjaWUtPmludHhfZG9tYWluLCBiaXQg
KyAxKTsNCisJCQlpZiAodmlycSkNCisJCQkJZ2VuZXJpY19oYW5kbGVfaXJxKHZpcnEpOw0KKwkJ
CWVsc2UNCisJCQkJZGV2X2Vycl9yYXRlbGltaXRlZChkZXYsICJiYWQgSU5UeCBJUlEgJWRcbiIs
DQorCQkJCQkJICAgIGJpdCk7DQorDQorCQkJLyogQ2xlYXIgdGhhdCBpbnRlcnJ1cHQgYml0ICov
DQorCQkJd3JpdGVsX3JlbGF4ZWQoMSA8PCAoYml0ICsgUE1fTVNJX0lOVF9TSElGVCksDQorCQkJ
CSAgICAgICBwY2llLT5icmlkZ2VfYmFzZV9hZGRyICsNCisJCQkJICAgICAgIE1DX0lTVEFUVVNf
TE9DQUwpOw0KKwkJfQ0KKw0KKwkJbXNpX3N0YXR1cyA9IChzdGF0dXMgJiBNU0lfSU5UKTsNCisJ
CWlmIChtc2lfc3RhdHVzKSB7DQorCQkJbXNpX3N0YXR1cyA9IHJlYWRsX3JlbGF4ZWQocGNpZS0+
YnJpZGdlX2Jhc2VfYWRkciArDQorCQkJCQkgICBNQ19JU1RBVFVTX01TSSk7DQorCQkJZm9yX2Vh
Y2hfc2V0X2JpdChiaXQsICZtc2lfc3RhdHVzLCBtc2ktPm51bV92ZWN0b3JzKSB7DQorCQkJCXZp
cnEgPSBpcnFfZmluZF9tYXBwaW5nKG1zaS0+ZGV2X2RvbWFpbiwgYml0KTsNCisJCQkJaWYgKHZp
cnEpDQorCQkJCQlnZW5lcmljX2hhbmRsZV9pcnEodmlycSk7DQorCQkJCWVsc2UNCisJCQkJCWRl
dl9lcnJfcmF0ZWxpbWl0ZWQoZGV2LA0KKwkJCQkJCQkgICAgImJhZCBNU0kgSVJRICVkXG4iLA0K
KwkJCQkJCQkgICAgYml0KTsNCisNCisJCQkJLyogQ2xlYXIgdGhhdCBNU0kgaW50ZXJydXB0IGJp
dCAqLw0KKwkJCQl3cml0ZWxfcmVsYXhlZCgoMSA8PCBiaXQpLA0KKwkJCQkJICAgICAgIHBjaWUt
PmJyaWRnZV9iYXNlX2FkZHIgKw0KKwkJCQkJICAgICAgIE1DX0lTVEFUVVNfTVNJKTsNCisJCQl9
DQorCQkJLyogQ2xlYXIgdGhlIElTVEFUVVMgTVNJIGJpdCAqLw0KKwkJCXdyaXRlbF9yZWxheGVk
KDEgPDwgTVNJX0lOVF9TSElGVCwNCisJCQkJICAgICAgIHBjaWUtPmJyaWRnZV9iYXNlX2FkZHIg
Kw0KKwkJCQkgICAgICAgTUNfSVNUQVRVU19MT0NBTCk7DQorCQl9DQorDQorCQlzdGF0dXMgPSBy
ZWFkbF9yZWxheGVkKHBjaWUtPmJyaWRnZV9iYXNlX2FkZHIgKw0KKwkJCQkgICAgICAgTUNfSVNU
QVRVU19MT0NBTCk7DQorCX0NCisNCisJY2hhaW5lZF9pcnFfZXhpdChjaGlwLCBkZXNjKTsNCit9
DQorDQorc3RhdGljIGludCBtY19wY2llX3BhcnNlX2R0KHN0cnVjdCBtY19wY2llICpwY2llKQ0K
K3sNCisJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiA9IHBjaWUtPnBkZXY7DQorCXN0cnVj
dCBkZXZpY2UgKmRldiA9ICZwY2llLT5wZGV2LT5kZXY7DQorCXN0cnVjdCBtY19tc2kgKm1zaSA9
ICZwY2llLT5tc2k7DQorCXN0cnVjdCByZXNvdXJjZSAqcmVzOw0KKwl2b2lkIF9faW9tZW0gKmF4
aV9iYXNlX2FkZHI7DQorCXUzMiBpcnE7DQorDQorCXJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJj
ZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMSk7DQorCWF4aV9iYXNlX2FkZHIgPSBkZXZtX2lvcmVt
YXBfcmVzb3VyY2UoZGV2LCByZXMpOw0KKwlpZiAoSVNfRVJSKGF4aV9iYXNlX2FkZHIpKQ0KKwkJ
cmV0dXJuIFBUUl9FUlIoYXhpX2Jhc2VfYWRkcik7DQorDQorCXBjaWUtPmJyaWRnZV9iYXNlX2Fk
ZHIgPSBheGlfYmFzZV9hZGRyICsgTUNfUENJRTFfQlJJREdFX0FERFI7DQorCXBjaWUtPmN0cmxf
YmFzZV9hZGRyID0gYXhpX2Jhc2VfYWRkciArIE1DX1BDSUUxX0NUUkxfQUREUjsNCisNCisJbXNp
LT52ZWN0b3JfcGh5ID0gTUNfTVNJX0FERFI7DQorDQorCW1zaS0+bnVtX3ZlY3RvcnMgPSBNQ19O
VU1fTVNJX0lSUVM7DQorDQorCWlycSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwgMCk7DQorCWlm
IChpcnEgPCAwKSB7DQorCQlkZXZfZXJyKGRldiwgInVuYWJsZSB0byByZXF1ZXN0IElSUSVkXG4i
LCBpcnEpOw0KKwkJcmV0dXJuIC1FTk9ERVY7DQorCX0NCisNCisJaXJxX3NldF9jaGFpbmVkX2hh
bmRsZXJfYW5kX2RhdGEoaXJxLCBtY19wY2llX2lzciwgcGNpZSk7DQorDQorCXJldHVybiAwOw0K
K30NCisNCitzdGF0aWMgdm9pZCBtY19wY2llX2VuYWJsZV9tc2koc3RydWN0IG1jX3BjaWUgKnBj
aWUpDQorew0KKwlzdHJ1Y3QgbWNfbXNpICptc2kgPSAmcGNpZS0+bXNpOw0KKwl1MzIgY2FwX29m
ZnNldCA9IE1DX01TSV9DQVBfQ1RSTF9PRkZTRVQ7DQorDQorCXUxNiBtc2dfY3RybCA9IGNmZ19y
ZWFkdyhwY2llLCBjYXBfb2Zmc2V0ICsgUENJX01TSV9GTEFHUyk7DQorDQorCW1zZ19jdHJsIHw9
IFBDSV9NU0lfRkxBR1NfRU5BQkxFOw0KKwltc2dfY3RybCAmPSB+UENJX01TSV9GTEFHU19RTUFT
SzsNCisJbXNnX2N0cmwgfD0gTUNfTVNJX01BWF9RX0FWQUlMOw0KKwltc2dfY3RybCAmPSB+UENJ
X01TSV9GTEFHU19RU0laRTsNCisJbXNnX2N0cmwgfD0gTUNfTVNJX1FfU0laRTsNCisJbXNnX2N0
cmwgfD0gUENJX01TSV9GTEFHU182NEJJVDsNCisJY2ZnX3dyaXRldyhwY2llLCBtc2dfY3RybCwg
Y2FwX29mZnNldCArIFBDSV9NU0lfRkxBR1MpOw0KKw0KKwljZmdfd3JpdGVsKHBjaWUsIGxvd2Vy
XzMyX2JpdHMobXNpLT52ZWN0b3JfcGh5KSwNCisJCSAgIGNhcF9vZmZzZXQgKyBQQ0lfTVNJX0FE
RFJFU1NfTE8pOw0KKwljZmdfd3JpdGVsKHBjaWUsIHVwcGVyXzMyX2JpdHMobXNpLT52ZWN0b3Jf
cGh5KSwNCisJCSAgIGNhcF9vZmZzZXQgKyBQQ0lfTVNJX0FERFJFU1NfSEkpOw0KK30NCisNCitz
dGF0aWMgaW50IG1jX2hvc3RfaW5pdChzdHJ1Y3QgbWNfcGNpZSAqcGNpZSwgdTY0IGNmZ2h3X2Jh
c2VfYWRkciwgdTMyIGF0cl9zeikNCit7DQorCXUzMiB2YWw7DQorDQorCW1jX3BjaWVfZW5hYmxl
KHBjaWUpOw0KKw0KKwl2YWwgPSBFQ0NfQ09OVFJPTF9BWEkyUENJRV9SQU1fRUNDX0JZUEFTUyB8
DQorCSAgICAgIEVDQ19DT05UUk9MX1BDSUUyQVhJX1JBTV9FQ0NfQllQQVNTIHwNCisJICAgICAg
RUNDX0NPTlRST0xfUlhfUkFNX0VDQ19CWVBBU1MgfCBFQ0NfQ09OVFJPTF9UWF9SQU1fRUNDX0JZ
UEFTUzsNCisJd3JpdGVsX3JlbGF4ZWQodmFsLCBwY2llLT5jdHJsX2Jhc2VfYWRkciArIE1DX0VD
Q19DT05UUk9MKTsNCisNCisJdmFsID0gUENJRV9FVkVOVF9JTlRfTDJfRVhJVF9JTlQgfCBQQ0lF
X0VWRU5UX0lOVF9IT1RSU1RfRVhJVF9JTlQgfA0KKwkgICAgICBQQ0lFX0VWRU5UX0lOVF9ETFVQ
X0VYSVRfSU5UIHwgUENJRV9FVkVOVF9JTlRfTDJfRVhJVF9JTlRfTUFTSyB8DQorCSAgICAgIFBD
SUVfRVZFTlRfSU5UX0hPVFJTVF9FWElUX0lOVF9NQVNLIHwNCisJICAgICAgUENJRV9FVkVOVF9J
TlRfRExVUF9FWElUX0lOVF9NQVNLOw0KKwl3cml0ZWxfcmVsYXhlZCh2YWwsIHBjaWUtPmN0cmxf
YmFzZV9hZGRyICsgTUNfUENJRV9FVkVOVF9JTlQpOw0KKw0KKwl2YWwgPSBTRUNfRVJST1JfSU5U
X1RYX1JBTV9TRUNfRVJSX0lOVCB8DQorCSAgICAgIFNFQ19FUlJPUl9JTlRfUlhfUkFNX1NFQ19F
UlJfSU5UIHwNCisJICAgICAgU0VDX0VSUk9SX0lOVF9QQ0lFMkFYSV9SQU1fU0VDX0VSUl9JTlQg
fA0KKwkgICAgICBTRUNfRVJST1JfSU5UX0FYSTJQQ0lFX1JBTV9TRUNfRVJSX0lOVDsNCisJd3Jp
dGVsX3JlbGF4ZWQodmFsLCBwY2llLT5jdHJsX2Jhc2VfYWRkciArIE1DX1NFQ19FUlJPUl9JTlQp
Ow0KKwl3cml0ZWxfcmVsYXhlZCh2YWwsIHBjaWUtPmN0cmxfYmFzZV9hZGRyICsgTUNfU0VDX0VS
Uk9SX0lOVF9NQVNLKTsNCisNCisJdmFsID0gREVEX0VSUk9SX0lOVF9UWF9SQU1fREVEX0VSUl9J
TlQgfA0KKwkgICAgICBERURfRVJST1JfSU5UX1JYX1JBTV9ERURfRVJSX0lOVCB8DQorCSAgICAg
IERFRF9FUlJPUl9JTlRfUENJRTJBWElfUkFNX0RFRF9FUlJfSU5UIHwNCisJICAgICAgREVEX0VS
Uk9SX0lOVF9BWEkyUENJRV9SQU1fREVEX0VSUl9JTlQ7DQorCXdyaXRlbF9yZWxheGVkKHZhbCwg
cGNpZS0+Y3RybF9iYXNlX2FkZHIgKyBNQ19ERURfRVJST1JfSU5UKTsNCisJd3JpdGVsX3JlbGF4
ZWQodmFsLCBwY2llLT5jdHJsX2Jhc2VfYWRkciArIE1DX0RFRF9FUlJPUl9JTlRfTUFTSyk7DQor
DQorCXdyaXRlbF9yZWxheGVkKDAsIHBjaWUtPmJyaWRnZV9iYXNlX2FkZHIgKyBNQ19JTUFTS19M
T0NBTCk7DQorCXdyaXRlbF9yZWxheGVkKEdFTk1BU0soMzEsIDApLCBwY2llLT5icmlkZ2VfYmFz
ZV9hZGRyICsNCisJCSAgICAgICBNQ19JU1RBVFVTX0xPQ0FMKTsNCisJd3JpdGVsX3JlbGF4ZWQo
MCwgcGNpZS0+YnJpZGdlX2Jhc2VfYWRkciArIE1DX0lNQVNLX0hPU1QpOw0KKwl3cml0ZWxfcmVs
YXhlZChHRU5NQVNLKDMxLCAwKSwgcGNpZS0+YnJpZGdlX2Jhc2VfYWRkciArDQorCQkgICAgICAg
TUNfSVNUQVRVU19IT1NUKTsNCisNCisJLyogQ29uZmlndXJlIEFkZHJlc3MgVHJhbnNsYXRpb24g
VGFibGUgMCBmb3IgUENJZSBjb25maWcgc3BhY2UgKi8NCisJd3JpdGVsX3JlbGF4ZWQoUENJRV9D
T05GSUdfSU5URVJGQUNFLCBwY2llLT5icmlkZ2VfYmFzZV9hZGRyICsNCisJICAgICAgIE1DX0FU
UjBfQVhJNF9TTFYwX1RSU0xfUEFSQU0pOw0KKw0KKwl2YWwgPSBsb3dlcl8zMl9iaXRzKGNmZ2h3
X2Jhc2VfYWRkcikgfA0KKwkgICAgICAoYXRyX3N6IDw8IEFUUl9TSVpFX1NISUZUKSB8IEFUUl9J
TVBMX0VOQUJMRTsNCisJd3JpdGVsX3JlbGF4ZWQodmFsLCBwY2llLT5icmlkZ2VfYmFzZV9hZGRy
ICsNCisJCSAgICAgICBNQ19BVFIwX0FYSTRfU0xWMF9TUkNBRERSX1BBUkFNKTsNCisJd3JpdGVs
X3JlbGF4ZWQoMCwgcGNpZS0+YnJpZGdlX2Jhc2VfYWRkciArDQorCQkgICAgICAgTUNfQVRSMF9B
WEk0X1NMVjBfU1JDX0FERFIpOw0KKw0KKwl2YWwgPSBsb3dlcl8zMl9iaXRzKGNmZ2h3X2Jhc2Vf
YWRkcik7DQorCXdyaXRlbF9yZWxheGVkKHZhbCwgcGNpZS0+YnJpZGdlX2Jhc2VfYWRkciArDQor
CQkgICAgICAgTUNfQVRSMF9BWEk0X1NMVjBfVFJTTF9BRERSX0xTQik7DQorCXZhbCA9IHVwcGVy
XzMyX2JpdHMoY2ZnaHdfYmFzZV9hZGRyKTsNCisJd3JpdGVsX3JlbGF4ZWQodmFsLCBwY2llLT5i
cmlkZ2VfYmFzZV9hZGRyICsNCisJCQkgICAgTUNfQVRSMF9BWEk0X1NMVjBfVFJTTF9BRERSX1VE
Vyk7DQorDQorCXZhbCA9IHJlYWRsX3JlbGF4ZWQocGNpZS0+YnJpZGdlX2Jhc2VfYWRkciArDQor
CQkJICAgIE1DX0FUUjBfUENJRV9XSU4wX1NSQ0FERFJfUEFSQU0pOw0KKwl2YWwgfD0gKEFUUjBf
UENJRV9BVFJfU0laRSA8PCBBVFIwX1BDSUVfQVRSX1NJWkVfU0hJRlQpOw0KKwl3cml0ZWxfcmVs
YXhlZCh2YWwsIHBjaWUtPmJyaWRnZV9iYXNlX2FkZHIgKw0KKwkJICAgICAgIE1DX0FUUjBfUENJ
RV9XSU4wX1NSQ0FERFJfUEFSQU0pOw0KKwl3cml0ZWxfcmVsYXhlZCgwLCBwY2llLT5icmlkZ2Vf
YmFzZV9hZGRyICsgTUNfQVRSMF9QQ0lFX1dJTjBfU1JDX0FERFIpOw0KKw0KKwlyZXR1cm4gMDsN
Cit9DQorDQorc3RhdGljIHZvaWQgbWNfbWFza19pbnR4X2lycShzdHJ1Y3QgaXJxX2RhdGEgKmRh
dGEpDQorew0KKwlzdHJ1Y3QgaXJxX2Rlc2MgKmRlc2MgPSBpcnFfdG9fZGVzYyhkYXRhLT5pcnEp
Ow0KKwlzdHJ1Y3QgbWNfcGNpZSAqcGNpZTsNCisJdW5zaWduZWQgbG9uZyBmbGFnczsNCisJdTMy
IG1hc2ssIHZhbDsNCisNCisJcGNpZSA9IGlycV9kZXNjX2dldF9jaGlwX2RhdGEoZGVzYyk7DQor
CW1hc2sgPSBQQ0lFX0xPQ0FMX0lOVF9FTkFCTEU7DQorCXJhd19zcGluX2xvY2tfaXJxc2F2ZSgm
cGNpZS0+aW50eF9tYXNrX2xvY2ssIGZsYWdzKTsNCisJdmFsID0gcmVhZGxfcmVsYXhlZChwY2ll
LT5icmlkZ2VfYmFzZV9hZGRyICsgTUNfSU1BU0tfTE9DQUwpOw0KKwl2YWwgJj0gfm1hc2s7DQor
CXdyaXRlbF9yZWxheGVkKHZhbCwgcGNpZS0+YnJpZGdlX2Jhc2VfYWRkciArIE1DX0lNQVNLX0xP
Q0FMKTsNCisJcmF3X3NwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnBjaWUtPmludHhfbWFza19sb2Nr
LCBmbGFncyk7DQorfQ0KKw0KK3N0YXRpYyB2b2lkIG1jX3VubWFza19pbnR4X2lycShzdHJ1Y3Qg
aXJxX2RhdGEgKmRhdGEpDQorew0KKwlzdHJ1Y3QgaXJxX2Rlc2MgKmRlc2MgPSBpcnFfdG9fZGVz
YyhkYXRhLT5pcnEpOw0KKwlzdHJ1Y3QgbWNfcGNpZSAqcGNpZTsNCisJdW5zaWduZWQgbG9uZyBm
bGFnczsNCisJdTMyIG1hc2ssIHZhbDsNCisNCisJcGNpZSA9IGlycV9kZXNjX2dldF9jaGlwX2Rh
dGEoZGVzYyk7DQorCW1hc2sgPSBQQ0lFX0xPQ0FMX0lOVF9FTkFCTEU7DQorCXJhd19zcGluX2xv
Y2tfaXJxc2F2ZSgmcGNpZS0+aW50eF9tYXNrX2xvY2ssIGZsYWdzKTsNCisJdmFsID0gcmVhZGxf
cmVsYXhlZChwY2llLT5icmlkZ2VfYmFzZV9hZGRyICsgTUNfSU1BU0tfTE9DQUwpOw0KKwl2YWwg
fD0gbWFzazsNCisJd3JpdGVsX3JlbGF4ZWQodmFsLCBwY2llLT5icmlkZ2VfYmFzZV9hZGRyICsg
TUNfSU1BU0tfTE9DQUwpOw0KKwlyYXdfc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcGNpZS0+aW50
eF9tYXNrX2xvY2ssIGZsYWdzKTsNCit9DQorDQorc3RhdGljIHN0cnVjdCBpcnFfY2hpcCBtY19p
bnR4X2lycV9jaGlwID0gew0KKwkubmFtZSA9ICJtaWNyb2NoaXBfcGNpZTppbnR4IiwNCisJLmly
cV9tYXNrID0gbWNfbWFza19pbnR4X2lycSwNCisJLmlycV91bm1hc2sgPSBtY191bm1hc2tfaW50
eF9pcnEsDQorfTsNCisNCitzdGF0aWMgaW50IG1jX3BjaWVfaW50eF9tYXAoc3RydWN0IGlycV9k
b21haW4gKmRvbWFpbiwgdW5zaWduZWQgaW50IGlycSwNCisJCQkgICAgaXJxX2h3X251bWJlcl90
IGh3aXJxKQ0KK3sNCisJaXJxX3NldF9jaGlwX2FuZF9oYW5kbGVyKGlycSwgJm1jX2ludHhfaXJx
X2NoaXAsIGhhbmRsZV9zaW1wbGVfaXJxKTsNCisJaXJxX3NldF9jaGlwX2RhdGEoaXJxLCBkb21h
aW4tPmhvc3RfZGF0YSk7DQorDQorCXJldHVybiAwOw0KK30NCisNCitzdGF0aWMgY29uc3Qgc3Ry
dWN0IGlycV9kb21haW5fb3BzIGludHhfZG9tYWluX29wcyA9IHsNCisJLm1hcCA9IG1jX3BjaWVf
aW50eF9tYXAsDQorfTsNCisNCitzdGF0aWMgc3RydWN0IGlycV9jaGlwIG1jX21zaV9pcnFfY2hp
cCA9IHsNCisJLm5hbWUgPSAiTWljcm9jaGlwIFBDSWUgTVNJIiwNCisJLmlycV9tYXNrID0gcGNp
X21zaV9tYXNrX2lycSwNCisJLmlycV91bm1hc2sgPSBwY2lfbXNpX3VubWFza19pcnEsDQorfTsN
CisNCitzdGF0aWMgc3RydWN0IG1zaV9kb21haW5faW5mbyBtY19tc2lfZG9tYWluX2luZm8gPSB7
DQorCS5mbGFncyA9IChNU0lfRkxBR19VU0VfREVGX0RPTV9PUFMgfCBNU0lfRkxBR19VU0VfREVG
X0NISVBfT1BTIHwNCisJCSAgTVNJX0ZMQUdfUENJX01TSVgpLA0KKwkuY2hpcCA9ICZtY19tc2lf
aXJxX2NoaXAsDQorfTsNCisNCitzdGF0aWMgdm9pZCBtY19jb21wb3NlX21zaV9tc2coc3RydWN0
IGlycV9kYXRhICpkYXRhLCBzdHJ1Y3QgbXNpX21zZyAqbXNnKQ0KK3sNCisJc3RydWN0IG1jX3Bj
aWUgKnBjaWUgPSBpcnFfZGF0YV9nZXRfaXJxX2NoaXBfZGF0YShkYXRhKTsNCisJcGh5c19hZGRy
X3QgYWRkciA9IHBjaWUtPm1zaS52ZWN0b3JfcGh5Ow0KKw0KKwltc2ctPmFkZHJlc3NfbG8gPSBs
b3dlcl8zMl9iaXRzKGFkZHIpOw0KKwltc2ctPmFkZHJlc3NfaGkgPSB1cHBlcl8zMl9iaXRzKGFk
ZHIpOw0KKwltc2ctPmRhdGEgPSBkYXRhLT5od2lycTsNCisNCisJZGV2X2RiZygmcGNpZS0+cGRl
di0+ZGV2LCAibXNpIyV4IGFkZHJlc3NfaGkgJSN4IGFkZHJlc3NfbG8gJSN4XG4iLA0KKwkJKGlu
dClkYXRhLT5od2lycSwgbXNnLT5hZGRyZXNzX2hpLCBtc2ctPmFkZHJlc3NfbG8pOw0KK30NCisN
CitzdGF0aWMgaW50IG1jX21zaV9zZXRfYWZmaW5pdHkoc3RydWN0IGlycV9kYXRhICppcnFfZGF0
YSwNCisJCQkgICAgICAgY29uc3Qgc3RydWN0IGNwdW1hc2sgKm1hc2ssIGJvb2wgZm9yY2UpDQor
ew0KKwlyZXR1cm4gLUVJTlZBTDsNCit9DQorDQorc3RhdGljIHN0cnVjdCBpcnFfY2hpcCBtY19t
c2lfYm90dG9tX2lycV9jaGlwID0gew0KKwkubmFtZSA9ICJNaWNyb2NoaXAgTVNJIiwNCisJLmly
cV9jb21wb3NlX21zaV9tc2cgPSBtY19jb21wb3NlX21zaV9tc2csDQorCS5pcnFfc2V0X2FmZmlu
aXR5ID0gbWNfbXNpX3NldF9hZmZpbml0eSwNCit9Ow0KKw0KK3N0YXRpYyBpbnQgbWNfaXJxX21z
aV9kb21haW5fYWxsb2Moc3RydWN0IGlycV9kb21haW4gKmRvbWFpbiwNCisJCQkJICAgdW5zaWdu
ZWQgaW50IHZpcnEsIHVuc2lnbmVkIGludCBucl9pcnFzLA0KKwkJCQkgICB2b2lkICphcmdzKQ0K
K3sNCisJc3RydWN0IG1jX3BjaWUgKnBjaWUgPSBkb21haW4tPmhvc3RfZGF0YTsNCisJc3RydWN0
IG1jX21zaSAqbXNpID0gJnBjaWUtPm1zaTsNCisJdW5zaWduZWQgbG9uZyBiaXQ7DQorCXUzMiBy
ZWc7DQorDQorCVdBUk5fT04obnJfaXJxcyAhPSAxKTsNCisJbXV0ZXhfbG9jaygmbXNpLT5sb2Nr
KTsNCisJYml0ID0gZmluZF9maXJzdF96ZXJvX2JpdChtc2ktPnVzZWQsIG1zaS0+bnVtX3ZlY3Rv
cnMpOw0KKwlpZiAoYml0ID49IG1zaS0+bnVtX3ZlY3RvcnMpIHsNCisJCW11dGV4X3VubG9jaygm
bXNpLT5sb2NrKTsNCisJCXJldHVybiAtRU5PU1BDOw0KKwl9DQorDQorCXNldF9iaXQoYml0LCBt
c2ktPnVzZWQpOw0KKw0KKwlpcnFfZG9tYWluX3NldF9pbmZvKGRvbWFpbiwgdmlycSwgYml0LCAm
bWNfbXNpX2JvdHRvbV9pcnFfY2hpcCwNCisJCQkgICAgZG9tYWluLT5ob3N0X2RhdGEsIGhhbmRs
ZV9zaW1wbGVfaXJxLCBOVUxMLCBOVUxMKTsNCisNCisJLyogRW5hYmxlIE1TSSBpbnRlcnJ1cHRz
ICovDQorCXJlZyA9IHJlYWRsX3JlbGF4ZWQocGNpZS0+YnJpZGdlX2Jhc2VfYWRkciArIE1DX0lN
QVNLX0xPQ0FMKTsNCisJcmVnIHw9IFBDSUVfRU5BQkxFX01TSTsNCisJd3JpdGVsX3JlbGF4ZWQo
cmVnLCBwY2llLT5icmlkZ2VfYmFzZV9hZGRyICsgTUNfSU1BU0tfTE9DQUwpOw0KKw0KKwltdXRl
eF91bmxvY2soJm1zaS0+bG9jayk7DQorDQorCXJldHVybiAwOw0KK30NCisNCitzdGF0aWMgdm9p
ZCBtY19pcnFfbXNpX2RvbWFpbl9mcmVlKHN0cnVjdCBpcnFfZG9tYWluICpkb21haW4sDQorCQkJ
CSAgIHVuc2lnbmVkIGludCB2aXJxLCB1bnNpZ25lZCBpbnQgbnJfaXJxcykNCit7DQorCXN0cnVj
dCBpcnFfZGF0YSAqZCA9IGlycV9kb21haW5fZ2V0X2lycV9kYXRhKGRvbWFpbiwgdmlycSk7DQor
CXN0cnVjdCBtY19wY2llICpwY2llID0gaXJxX2RhdGFfZ2V0X2lycV9jaGlwX2RhdGEoZCk7DQor
CXN0cnVjdCBtY19tc2kgKm1zaSA9ICZwY2llLT5tc2k7DQorDQorCW11dGV4X2xvY2soJm1zaS0+
bG9jayk7DQorDQorCWlmICh0ZXN0X2JpdChkLT5od2lycSwgbXNpLT51c2VkKSkNCisJCV9fY2xl
YXJfYml0KGQtPmh3aXJxLCBtc2ktPnVzZWQpOw0KKwllbHNlDQorCQlkZXZfZXJyKCZwY2llLT5w
ZGV2LT5kZXYsICJ0cnlpbmcgdG8gZnJlZSB1bnVzZWQgTVNJJWx1XG4iLA0KKwkJCWQtPmh3aXJx
KTsNCisNCisJbXV0ZXhfdW5sb2NrKCZtc2ktPmxvY2spOw0KK30NCisNCitzdGF0aWMgY29uc3Qg
c3RydWN0IGlycV9kb21haW5fb3BzIG1zaV9kb21haW5fb3BzID0gew0KKwkuYWxsb2MJPSBtY19p
cnFfbXNpX2RvbWFpbl9hbGxvYywNCisJLmZyZWUJPSBtY19pcnFfbXNpX2RvbWFpbl9mcmVlLA0K
K307DQorDQorc3RhdGljIGludCBtY19hbGxvY2F0ZV9tc2lfZG9tYWlucyhzdHJ1Y3QgbWNfcGNp
ZSAqcGNpZSkNCit7DQorCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwY2llLT5wZGV2LT5kZXY7DQor
CXN0cnVjdCBmd25vZGVfaGFuZGxlICpmd25vZGUgPSBvZl9ub2RlX3RvX2Z3bm9kZShkZXYtPm9m
X25vZGUpOw0KKwlzdHJ1Y3QgbWNfbXNpICptc2kgPSAmcGNpZS0+bXNpOw0KKw0KKwltdXRleF9p
bml0KCZwY2llLT5tc2kubG9jayk7DQorDQorCW1zaS0+ZGV2X2RvbWFpbiA9IGlycV9kb21haW5f
YWRkX2xpbmVhcihOVUxMLCBtc2ktPm51bV92ZWN0b3JzLA0KKwkJCQkJCSZtc2lfZG9tYWluX29w
cywgcGNpZSk7DQorCWlmICghbXNpLT5kZXZfZG9tYWluKSB7DQorCQlkZXZfZXJyKGRldiwgImZh
aWxlZCB0byBjcmVhdGUgSVJRIGRvbWFpblxuIik7DQorCQlyZXR1cm4gLUVOT01FTTsNCisJfQ0K
Kw0KKwltc2ktPm1zaV9kb21haW4gPSBwY2lfbXNpX2NyZWF0ZV9pcnFfZG9tYWluKGZ3bm9kZSwN
CisJCQkJCQkgICAgJm1jX21zaV9kb21haW5faW5mbywNCisJCQkJCQkgICAgbXNpLT5kZXZfZG9t
YWluKTsNCisJaWYgKCFtc2ktPm1zaV9kb21haW4pIHsNCisJCWRldl9lcnIoZGV2LCAiZmFpbGVk
IHRvIGNyZWF0ZSBNU0kgZG9tYWluXG4iKTsNCisJCWlycV9kb21haW5fcmVtb3ZlKG1zaS0+ZGV2
X2RvbWFpbik7DQorCQlyZXR1cm4gLUVOT01FTTsNCisJfQ0KKw0KKwlyZXR1cm4gMDsNCit9DQor
DQorc3RhdGljIGludCBtY19wY2llX2luaXRfaXJxX2RvbWFpbnMoc3RydWN0IG1jX3BjaWUgKnBj
aWUpDQorew0KKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGNpZS0+cGRldi0+ZGV2Ow0KKwlzdHJ1
Y3QgZGV2aWNlX25vZGUgKm5vZGUgPSBkZXYtPm9mX25vZGU7DQorDQorCXBjaWUtPmludHhfZG9t
YWluID0gaXJxX2RvbWFpbl9hZGRfbGluZWFyKG5vZGUsIFBDSV9OVU1fSU5UWCwNCisJCQkJCQkg
ICZpbnR4X2RvbWFpbl9vcHMsIHBjaWUpOw0KKwlpZiAoIXBjaWUtPmludHhfZG9tYWluKSB7DQor
CQlkZXZfZXJyKGRldiwgImZhaWxlZCB0byBnZXQgYW4gSU5UeCBJUlEgZG9tYWluXG4iKTsNCisJ
CXJldHVybiAtRU5PTUVNOw0KKwl9DQorCXJhd19zcGluX2xvY2tfaW5pdCgmcGNpZS0+aW50eF9t
YXNrX2xvY2spOw0KKw0KKwlyZXR1cm4gbWNfYWxsb2NhdGVfbXNpX2RvbWFpbnMocGNpZSk7DQor
fQ0KKw0KK3N0YXRpYyB2b2lkIG1jX3BjaV91bm1hcF9jZmcodm9pZCAqcHRyKQ0KK3sNCisJcGNp
X2VjYW1fZnJlZSgoc3RydWN0IHBjaV9jb25maWdfd2luZG93ICopcHRyKTsNCit9DQorDQorc3Rh
dGljIGludCBtY19wY2llX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQorew0K
KwlzdHJ1Y3QgbWNfcGNpZSAqcGNpZTsNCisJc3RydWN0IHBjaV9ob3N0X2JyaWRnZSAqYnJpZGdl
Ow0KKwlzdHJ1Y3QgcGNpX2NvbmZpZ193aW5kb3cgKmNmZzsNCisJc3RydWN0IGRldmljZSAqZGV2
ID0gJnBkZXYtPmRldjsNCisJc3RydWN0IHJlc291cmNlX2VudHJ5ICp3aW47DQorCXN0cnVjdCBy
ZXNvdXJjZSAqYnVzX3JhbmdlID0gTlVMTDsNCisJc3RydWN0IHJlc291cmNlICpjZmdyZXM7DQor
CWludCByZXQ7DQorCXJlc291cmNlX3NpemVfdCBzaXplOw0KKwl1MzIgaW5kZXg7DQorCXUzMiBh
dHJfc3o7DQorCXUzMiB2YWw7DQorDQorCWlmICghZGV2LT5vZl9ub2RlKQ0KKwkJcmV0dXJuIC1F
Tk9ERVY7DQorDQorCS8qIEFsbG9jYXRlIHRoZSBQQ0llIHBvcnQgKi8NCisJYnJpZGdlID0gZGV2
bV9wY2lfYWxsb2NfaG9zdF9icmlkZ2UoZGV2LCBzaXplb2YoKnBjaWUpKTsNCisJaWYgKCFicmlk
Z2UpDQorCQlyZXR1cm4gLUVOT01FTTsNCisNCisJcGNpZSA9IHBjaV9ob3N0X2JyaWRnZV9wcml2
KGJyaWRnZSk7DQorDQorCXBjaWUtPnBkZXYgPSBwZGV2Ow0KKw0KKwljZmdyZXMgPSBwbGF0Zm9y
bV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KKwlzaXplID0gcmVzb3Vy
Y2Vfc2l6ZShjZmdyZXMpOw0KKwlhdHJfc3ogPSBpbG9nMihzaXplKSAtIDE7DQorDQorCXJldCA9
IG1jX3BjaWVfcGFyc2VfZHQocGNpZSk7DQorCWlmIChyZXQpIHsNCisJCWRldl9lcnIoZGV2LCAi
cGFyc2luZyBkZXZpY2V0cmVlIGZhaWxlZCwgcmV0ICV4XG4iLCByZXQpOw0KKwkJcmV0dXJuIHJl
dDsNCisJfQ0KKw0KKwlyZXQgPSBtY19ob3N0X2luaXQocGNpZSwgY2ZncmVzLT5zdGFydCwgYXRy
X3N6KTsNCisJaWYgKHJldCkgew0KKwkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gaW5pdGlhbGl6
ZSBob3N0XG4iKTsNCisJCXJldHVybiByZXQ7DQorCX0NCisNCisJLyoNCisJICogQ29uZmlndXJl
IGFsbCBpbmJvdW5kIGFuZCBvdXRib3VuZCB3aW5kb3dzIGFuZCBwcmVwYXJlDQorCSAqIGZvciBj
b25maWcgYWNjZXNzDQorCSAqLw0KKwlyZXQgPSBwY2lfcGFyc2VfcmVxdWVzdF9vZl9wY2lfcmFu
Z2VzKGRldiwgJmJyaWRnZS0+d2luZG93cywNCisJCQkJCSAgICAgICZicmlkZ2UtPmRtYV9yYW5n
ZXMsICZidXNfcmFuZ2UpOw0KKwlpZiAocmV0KSB7DQorCQlkZXZfZXJyKGRldiwgImZhaWxlZCB0
byBwYXJzZSBQQ0kgcmFuZ2VzXG4iKTsNCisJCXJldHVybiByZXQ7DQorCX0NCisNCisJaW5kZXgg
PSAxOw0KKwlyZXNvdXJjZV9saXN0X2Zvcl9lYWNoX2VudHJ5KHdpbiwgJmJyaWRnZS0+d2luZG93
cykgew0KKwkJaWYgKChyZXNvdXJjZV90eXBlKHdpbi0+cmVzKSAhPSBJT1JFU09VUkNFX01FTSkg
JiYNCisJCSAgICAocmVzb3VyY2VfdHlwZSh3aW4tPnJlcykgIT0gSU9SRVNPVVJDRV9JTykpDQor
CQkJY29udGludWU7DQorDQorCQlzaXplID0gcmVzb3VyY2Vfc2l6ZSh3aW4tPnJlcyk7DQorCQlh
dHJfc3ogPSBpbG9nMihzaXplKSAtIDE7DQorDQorCQkvKg0KKwkJICogQ29uZmlndXJlIEFkZHJl
c3MgVHJhbnNsYXRpb24gVGFibGUgaW5kZXggZm9yIFBDSQ0KKwkJICogbWVtIHNwYWNlDQorCQkg
Ki8NCisJCXdyaXRlbF9yZWxheGVkKFBDSUVfVFhfUlhfSU5URVJGQUNFLCBwY2llLT5icmlkZ2Vf
YmFzZV9hZGRyICsNCisJCSAgICAgICAoaW5kZXggKiBBVFRfRU5UUllfU0laRSkgKw0KKwkJICAg
ICAgIE1DX0FUUjBfQVhJNF9TTFYwX1RSU0xfUEFSQU0pOw0KKw0KKwkJdmFsID0gbG93ZXJfMzJf
Yml0cyh3aW4tPnJlcy0+c3RhcnQpIHwNCisJCQkJICAgIChhdHJfc3ogPDwgQVRSX1NJWkVfU0hJ
RlQpIHwNCisJCQkJICAgIEFUUl9JTVBMX0VOQUJMRTsNCisNCisJCXdyaXRlbF9yZWxheGVkKHZh
bCwgcGNpZS0+YnJpZGdlX2Jhc2VfYWRkciArDQorCQkgICAgICAgKGluZGV4ICogQVRUX0VOVFJZ
X1NJWkUpICsNCisJCSAgICAgICBNQ19BVFIwX0FYSTRfU0xWMF9TUkNBRERSX1BBUkFNKTsNCisN
CisJCXZhbCA9IHVwcGVyXzMyX2JpdHMod2luLT5yZXMtPnN0YXJ0KTsNCisJCXdyaXRlbF9yZWxh
eGVkKHZhbCwgcGNpZS0+YnJpZGdlX2Jhc2VfYWRkciArDQorCQkJCShpbmRleCAqIEFUVF9FTlRS
WV9TSVpFKSArDQorCQkJCU1DX0FUUjBfQVhJNF9TTFYwX1NSQ19BRERSKTsNCisNCisJCXZhbCA9
IGxvd2VyXzMyX2JpdHMod2luLT5yZXMtPnN0YXJ0IC0gd2luLT5vZmZzZXQpOw0KKwkJd3JpdGVs
X3JlbGF4ZWQodmFsLCBwY2llLT5icmlkZ2VfYmFzZV9hZGRyICsNCisJCSAgICAgICAoaW5kZXgg
KiBBVFRfRU5UUllfU0laRSkgKw0KKwkJICAgICAgIE1DX0FUUjBfQVhJNF9TTFYwX1RSU0xfQURE
Ul9MU0IpOw0KKw0KKwkJdmFsID0gdXBwZXJfMzJfYml0cyh3aW4tPnJlcy0+c3RhcnQpOw0KKwkJ
d3JpdGVsX3JlbGF4ZWQodmFsLCBwY2llLT5icmlkZ2VfYmFzZV9hZGRyICsNCisJCQkJICAgIChp
bmRleCAqIEFUVF9FTlRSWV9TSVpFKSArDQorCQkJCSAgICBNQ19BVFIwX0FYSTRfU0xWMF9UUlNM
X0FERFJfVURXKTsNCisNCisJCWluZGV4Kys7DQorCX0NCisNCisJcmV0ID0gbWNfcGNpZV9pbml0
X2lycV9kb21haW5zKHBjaWUpOw0KKwlpZiAocmV0KSB7DQorCQlkZXZfZXJyKGRldiwgImZhaWxl
ZCBjcmVhdGluZyBJUlEgZG9tYWluc1xuIik7DQorCQlyZXR1cm4gcmV0Ow0KKwl9DQorDQorCS8q
IFBhcnNlIGFuZCBtYXAgb3VyIENvbmZpZ3VyYXRpb24gU3BhY2Ugd2luZG93cyAqLw0KKwljZmcg
PSBwY2lfZWNhbV9jcmVhdGUoZGV2LCBjZmdyZXMsIGJ1c19yYW5nZSwgJnBjaV9nZW5lcmljX2Vj
YW1fb3BzKTsNCisJaWYgKElTX0VSUihjZmcpKSB7DQorCQlkZXZfZXJyKGRldiwgImZhaWxlZCBj
cmVhdGluZyBDb25maWd1cmF0aW9uIFNwYWNlXG4iKTsNCisJCXJldHVybiBQVFJfRVJSKGNmZyk7
DQorCX0NCisNCisJcGNpZS0+Y2ZnX2Jhc2VfYWRkciA9IGNmZy0+d2luOw0KKw0KKwkvKiBIYXJk
d2FyZSBkb2Vzbid0IHNldHVwIE1TSSBieSBkZWZhdWx0ICovDQorCW1jX3BjaWVfZW5hYmxlX21z
aShwY2llKTsNCisNCisJdmFsID0gUENJRV9FTkFCTEVfTVNJIHwgUENJRV9MT0NBTF9JTlRfRU5B
QkxFOw0KKwl3cml0ZWxfcmVsYXhlZCh2YWwsIHBjaWUtPmJyaWRnZV9iYXNlX2FkZHIgKyBNQ19J
TUFTS19MT0NBTCk7DQorDQorCXJldCA9IGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldChkZXYsIG1j
X3BjaV91bm1hcF9jZmcsIGNmZyk7DQorCWlmIChyZXQpDQorCQlyZXR1cm4gcmV0Ow0KKw0KKwkv
KiBJbml0aWFsaXplIGJyaWRnZSAqLw0KKwlicmlkZ2UtPmRldi5wYXJlbnQgPSBkZXY7DQorCWJy
aWRnZS0+c3lzZGF0YSA9IGNmZzsNCisJYnJpZGdlLT5idXNuciA9IGNmZy0+YnVzci5zdGFydDsN
CisJYnJpZGdlLT5vcHMgPSAoc3RydWN0IHBjaV9vcHMgKikmcGNpX2dlbmVyaWNfZWNhbV9vcHMu
cGNpX29wczsNCisJYnJpZGdlLT5tYXBfaXJxID0gb2ZfaXJxX3BhcnNlX2FuZF9tYXBfcGNpOw0K
KwlicmlkZ2UtPnN3aXp6bGVfaXJxID0gcGNpX2NvbW1vbl9zd2l6emxlOw0KKw0KKwlyZXR1cm4g
cGNpX2hvc3RfcHJvYmUoYnJpZGdlKTsNCit9DQorDQorc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9k
ZXZpY2VfaWQgbWNfcGNpZV9vZl9tYXRjaFtdID0gew0KKwl7IC5jb21wYXRpYmxlID0gIm1pY3Jv
Y2hpcCxwY2llLWhvc3QtMS4wIiB9LA0KKwl7fSwNCit9Ow0KKw0KK01PRFVMRV9ERVZJQ0VfVEFC
TEUob2YsIG1jX3BjaWVfb2ZfbWF0Y2gpDQorDQorc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2
ZXIgbWNfcGNpZV9kcml2ZXIgPSB7DQorCS5wcm9iZSA9IG1jX3BjaWVfcHJvYmUsDQorCS5kcml2
ZXIgPSB7DQorCQkubmFtZSA9ICJtaWNyb2NoaXAtcGNpZSIsDQorCQkub2ZfbWF0Y2hfdGFibGUg
PSBtY19wY2llX29mX21hdGNoLA0KKwkJLnN1cHByZXNzX2JpbmRfYXR0cnMgPSB0cnVlLA0KKwl9
LA0KK307DQorDQorYnVpbHRpbl9wbGF0Zm9ybV9kcml2ZXIobWNfcGNpZV9kcml2ZXIpOw0KKw0K
K01PRFVMRV9MSUNFTlNFKCJHUEwgdjIiKTsNCitNT0RVTEVfREVTQ1JJUFRJT04oIk1pY3JvY2hp
cCBQQ0llIGhvc3QgY29udHJvbGxlciBkcml2ZXIiKTsNCitNT0RVTEVfQVVUSE9SKCJEYWlyZSBN
Y05hbWFyYSA8ZGFpcmUubWNuYW1hcmFAbWljcm9jaGlwLmNvbT4iKTsNCi0tIA0KMi4xNy4xDQoN
Cg==
