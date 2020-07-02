Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7DA212824
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jul 2020 17:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgGBPlG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jul 2020 11:41:06 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:17904 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbgGBPlF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jul 2020 11:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593704465; x=1625240465;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=Ro85BUHrlMaExZ0yi6toz0apAXpFJ8z2LRC+Cmey2RQ=;
  b=Mq6Ov7HKKQM5xhQ77DSKuC6eb9oSf43G2htWz5ToCnbp2KTuOJV8fMIP
   Wh2HQoDTEIDvfHWBAhpttp/vRQ3QW7gMEWjDiILXLmaD44vLJtUQpPr/O
   b6peNcZrBq+wI27mFeSqTMN6LkLTPA2S8C8/CbvCekzpj9gmYQ8OeKS+Z
   wjtMkfBYoThphvMr4AbM+P1ErjNpM7VJqn+Kcvg2eLfrYwiRMwjcMDfYX
   97fHuKF+w/OzVCpjeNcgTmLgoPK7dg9pVjQy48QJnr5aZypo0ORMnU4N8
   f0WZhSpMGpye4unntQwsr6GQO2xaBbo/Lm9TvOrnKY9IVCL0RfWyIiQDd
   w==;
IronPort-SDR: 9gFqxDlP5zxE2pFo7eKf4ZPB+UZ51CCU0tW9pS6+Xscvq/tien3jtNSd00Ay3APixtZh+H36Er
 6yxvmIbK/oszYVoBpve3I6ly9Ze2NG5YL1JdAkssCgI0xz6+wChrYQ/UxczrAYI6NFIuPCtRXV
 WjzZ8WvnTRJ4Xpi1rxuJjqLbBjUVGpEBFZsSTJAHJbHmR6LQfr3Wrj+JBfzhVHWBwKpK9lgX5V
 tEf9Gezp9RkSeRUKFo3mtEIcUL1dmctuKYLUYBeUA5tXZjbyk6wF6d3mycDnNSwuXzP3yP8+ul
 QLA=
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="78587166"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Jul 2020 08:41:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 2 Jul 2020 08:41:00 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 2 Jul 2020 08:40:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfdbZ49YUIVyQx2euvi3nRWk/KTk6PEE/tj1hpC4hsR9Mkr4voxEuFGOo+aZgt+t6PbPs8iSjb3va8mLlHDgxf8NDLH3PBZU/unGMDXDm1cL02BY8FO6pM0+Q+SEEqYkC48zyvQzJYU86CdRV+H9853RGSMbbWy5FvWHmRL/kDMzNcp4ceyryIFWH/Rpq1ztQ3TPiV6fFPRRZTWQ53hl8uK9JbZTUmBlJXsXaB4oe3UzYcv7nrbTUSS/36X/OZrRg4MXRjlW8rG++NU8jQ2678wKN8cuInl4CvR/4XWZ2RIDdioeGOmTpHFJ5vvv85tqtPLYXRPbcC8Gm25H+8fYBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ro85BUHrlMaExZ0yi6toz0apAXpFJ8z2LRC+Cmey2RQ=;
 b=jeoxcHlk8n2pDGoGp5yhw1hHRP0MZFVucUGFy1g4/qFvLDSdKhBtdhKqCugSTjdL3SxvKcqNu4P+4shbCg8x+zA7wGZKm0S+tzGYzIIeut5j/D4Pvm/ZjD9f+G4cC/u6VraY5Vco5QfLqaWhyCOSST1ZanVbtfnuRmwnGZ16EJVd+TmE9LLnaW3DQ8Rn4HYcXwipV5pYly05KkE6WVAaGCJfs3r0EXvljYx/4IFcoDZJA7XRnt9axQmbRHr/jp9K0Q2JmzQZFXm9Fh8bGVum13OOuvXwAOND24tXCN15m8xOMCfL1Xp+iNM066BJ+Km52vuSUtDgj+Nr0kxl70O7Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ro85BUHrlMaExZ0yi6toz0apAXpFJ8z2LRC+Cmey2RQ=;
 b=DJ/QZuqXcLy12ytzLve4A6QNlKtidt11LJaN6HrpZDuN4n3GtPR8pt9UbYH8iLAmIpUruxw29Z9uxSn1UXZxez/Dq0VNK2jDPRfsfylC1NUxxAErV9xpaxOHJr2uNCT3fsG7m30O1Dj9BUg4CszDfd8X5J1/JAgGpxtKfpyEgsE=
Received: from MN2PR11MB4269.namprd11.prod.outlook.com (2603:10b6:208:190::32)
 by BL0PR11MB2946.namprd11.prod.outlook.com (2603:10b6:208:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Thu, 2 Jul
 2020 15:40:59 +0000
Received: from MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::8d6f:606b:5ddc:d5cb]) by MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::8d6f:606b:5ddc:d5cb%2]) with mapi id 15.20.3131.036; Thu, 2 Jul 2020
 15:40:59 +0000
From:   <Daire.McNamara@microchip.com>
To:     <amurray@thegoodpenguin.co.uk>, <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>
Subject: [PATCH v12 1/2] PCI: microchip: Add host driver for Microchip PCIe
 controller
Thread-Topic: [PATCH v12 1/2] PCI: microchip: Add host driver for Microchip
 PCIe controller
Thread-Index: AQHWUIcv8g+VEANO/kq+YE4TT1ZPng==
Date:   Thu, 2 Jul 2020 15:40:59 +0000
Message-ID: <dd0ce15cb88c08f26ff4d65ca445a2c87b82b179.camel@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: thegoodpenguin.co.uk; dkim=none (message not signed)
 header.d=none;thegoodpenguin.co.uk; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [89.101.219.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41d1242f-54bd-445a-7218-08d81e9e51b7
x-ms-traffictypediagnostic: BL0PR11MB2946:
x-microsoft-antispam-prvs: <BL0PR11MB2946B9F5CF8131BA57DC7AE5966D0@BL0PR11MB2946.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9kUZyntaSQWtU2z3TS8MZXJvTGUQK1XzjXvvwPIis0yJ9kepIo1ara0WjVkFCfAxwSBE6lCbEsttDTwjSBwytboDIih+fGxudan5AJ7Tri4B8Bj64wsZnISNPGFJqwNE2AtRV76fm0MrlGl0OqAVJC/Q5VWciQ66iCYBL+YDswoVAjfzQy2f+KPZyJ6U+nhaPVGV8rophvS+8L9UJotxwodCc8h+iVKX4mh2mSNlKN7Vn0pEnLG2DSf6Z6LYdJkRLiaIE6+OnwrZuTcGNHjYbsz9TT5SDsAbeGWkaG6FVCMdjDCDSy6redgzwez07eagp9u6r5q2EyXl9pg3JeFdEV99dGFJW2f4C+x7C4NN6tiiMLAOz/hjHk7fE6mawQ8Zg8UQRYSNluTuxDokIgOYqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(366004)(136003)(396003)(39860400002)(66946007)(26005)(71200400001)(6512007)(186003)(478600001)(110136005)(6506007)(316002)(2616005)(2906002)(86362001)(5660300002)(6486002)(966005)(36756003)(66556008)(91956017)(66476007)(64756008)(66446008)(8936002)(76116006)(8676002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Ge5QLs7OSB8mdMcvIPJP/MYiWX6WZUH13/p6D8MDs8f8o+s8x+c3Lq3s979bAMz9mR7X0HYwq3/LwxXTuHT1kPyE9MQm+axMERrpYPfZOv0tn+jHgkF2YK2u7IUpIO9+EMcMx/ahs8yPXNBXZQVV1lhcqiNeut07sS8Jd7BqxwtfxoJwD4aGiL4GI6S2fDV0H7sadyBvoeZBvnOciab6Kmu28etkLP8OxRY5RGGaqxppLfWxPtEs5IM4QAgCY9t6LuI7SZiPKGsvYA/g9NGeCW/NR8p58zMwwBoWI4H1FtusHFtbznsBNTOxwaTGTXb7eDiZPEpZfHoWi1Z/38VsXunZPyj0DAMsMJ2ij+WYhAEICZM/CKPBvQ0uwZ/Vl7AjBIwjJNEOI9pD1YlOfN7YM04pB+SrfXRZKzIA0TbH9fZPEwpeXt2t2exFbnDWUCHWOpCA8cg7KVz5pERHY4qCu0amNoQ8n6UKQjZ/OiuIkdbH1geyQkFoml9Dt93WkOLk
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF40D0743CB6BE488A7369295419D849@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d1242f-54bd-445a-7218-08d81e9e51b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 15:40:59.5609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZBOovXX6U5uZCEJFGoMrwn7OMJh0lErbfnWTlpJ2Wg3b69TZQ1yRcocLfodFWzSsoSpgKVNhOENLZnlQ++zEbSUcQFOJJvLryYwuabMFib8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB2946
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

YWRkIGRldmljZSB0cmVlIGJpbmRpbmdzIGZvciB0aGUgTWljcm9jaGlwIFBDSWUgUG9sYXJGaXJl
IFBDSWUgY29udHJvbGxlcg0Kd2hlbiBjb25maWd1cmVkIGluIGhvc3QgKFJvb3QgQ29tcGxleCkg
bW9kZS4NCg0KU2lnbmVkLW9mZi1ieTogRGFpcmUgTWNOYW1hcmEgPGRhaXJlLm1jbmFtYXJhQG1p
Y3JvY2hpcC5jb20+DQotLS0NCiAuLi4vYmluZGluZ3MvcGNpL21pY3JvY2hpcCxwY2llLWhvc3Qu
eWFtbCAgICAgfCA5MyArKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDkzIGlu
c2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3BjaS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwNCg0KZGlmZiAtLWdpdCBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbWljcm9jaGlwLHBjaWUtaG9zdC55
YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9taWNyb2NoaXAscGNp
ZS1ob3N0LnlhbWwNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwMDAwMDAuLmI1
NTk0MTgyNmI0NA0KLS0tIC9kZXYvbnVsbA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3BjaS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwNCkBAIC0wLDAgKzEsOTMgQEAN
CisjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVz
ZSkNCislWUFNTCAxLjINCistLS0NCiskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFz
L3BjaS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwjDQorJHNjaGVtYTogaHR0cDovL2RldmljZXRy
ZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQorDQordGl0bGU6IE1pY3JvY2hpcCBQQ0ll
IFJvb3QgUG9ydCBCcmlkZ2UgQ29udHJvbGxlciBEZXZpY2UgVHJlZSBCaW5kaW5ncw0KKw0KK21h
aW50YWluZXJzOg0KKyAgLSBEYWlyZSBNY05hbWFyYSA8ZGFpcmUubWNuYW1hcmFAbWljcm9jaGlw
LmNvbT4NCisNCithbGxPZjoNCisgIC0gJHJlZjogL3NjaGVtYXMvcGNpL3BjaS1idXMueWFtbCMN
CisNCitwcm9wZXJ0aWVzOg0KKyAgY29tcGF0aWJsZToNCisgICAgY29uc3Q6IG1pY3JvY2hpcCxw
Y2llLWhvc3QtMS4wICMgUG9sYXJGaXJlDQorDQorICByZWc6DQorICAgIG1heEl0ZW1zOiAyDQor
DQorICByZWctbmFtZXM6DQorICAgIGl0ZW1zOg0KKyAgICAgIC0gY29uc3Q6IGNmZw0KKyAgICAg
IC0gY29uc3Q6IGFwYg0KKw0KKyAgaW50ZXJydXB0czoNCisgICAgbWluSXRlbXM6IDENCisgICAg
bWF4SXRlbXM6IDINCisgICAgaXRlbXM6DQorICAgICAgLSBkZXNjcmlwdGlvbjogUENJZSBob3N0
IGNvbnRyb2xsZXINCisgICAgICAtIGRlc2NyaXB0aW9uOiBidWlsdGluIE1TSSBjb250cm9sbGVy
DQorDQorICBpbnRlcnJ1cHQtbmFtZXM6DQorICAgIG1pbkl0ZW1zOiAxDQorICAgIG1heEl0ZW1z
OiAyDQorICAgIGl0ZW1zOg0KKyAgICAgIC0gY29uc3Q6IHBjaWUNCisgICAgICAtIGNvbnN0OiBt
c2kNCisNCisgIHJhbmdlczoNCisgICAgbWF4SXRlbXM6IDENCisNCisgIGRtYS1yYW5nZXM6DQor
ICAgIG1heEl0ZW1zOiAxDQorDQorICBtc2ktY29udHJvbGxlcjoNCisgICAgZGVzY3JpcHRpb246
IElkZW50aWZpZXMgdGhlIG5vZGUgYXMgYW4gTVNJIGNvbnRyb2xsZXIuDQorDQorICBtc2ktcGFy
ZW50Og0KKyAgICBkZXNjcmlwdGlvbjogTVNJIGNvbnRyb2xsZXIgdGhlIGRldmljZSBpcyBjYXBh
YmxlIG9mIHVzaW5nLg0KKw0KK3JlcXVpcmVkOg0KKyAgLSByZWcNCisgIC0gcmVnLW5hbWVzDQor
ICAtIGRtYS1yYW5nZXMNCisgIC0gIiNpbnRlcnJ1cHQtY2VsbHMiDQorICAtIGludGVycnVwdHMN
CisgIC0gaW50ZXJydXB0LW1hcC1tYXNrDQorICAtIGludGVycnVwdC1tYXANCisgIC0gbXNpLWNv
bnRyb2xsZXINCisNCit1bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlDQorDQorZXhhbXBsZXM6
DQorICAtIHwNCisgICAgc29jIHsNCisgICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwyPjsN
CisgICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwyPjsNCisgICAgICAgICAgICBwY2llMDogcGNp
ZUAyMDMwMDAwMDAwIHsNCisgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibWljcm9j
aGlwLHBjaWUtaG9zdC0xLjAiOw0KKyAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4MjAgMHgz
MDAwMDAwMCAweDAgMHg0MDAwMDAwPiwNCisgICAgICAgICAgICAgICAgICAgICAgICAgIDwweDIw
IDB4MCAweDAgMHgxMDAwMDA+Ow0KKyAgICAgICAgICAgICAgICAgICAgcmVnLW5hbWVzID0gImNm
ZyIsICJhcGIiOw0KKyAgICAgICAgICAgICAgICAgICAgZGV2aWNlX3R5cGUgPSAicGNpIjsNCisg
ICAgICAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDM+Ow0KKyAgICAgICAgICAgICAg
ICAgICAgI3NpemUtY2VsbHMgPSA8Mj47DQorICAgICAgICAgICAgICAgICAgICAjaW50ZXJydXB0
LWNlbGxzID0gPDE+Ow0KKyAgICAgICAgICAgICAgICAgICAgaW50ZXJydXB0cyA9IDwzMj47DQor
ICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHQtbWFwLW1hc2sgPSA8MHgwIDB4MCAweDAgMHg3
PjsNCisgICAgICAgICAgICAgICAgICAgIGludGVycnVwdC1tYXAgPSA8MCAwIDAgMSAmcGNpZTAg
MD4sDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPDAgMCAwIDIgJnBjaWUw
IDE+LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwwIDAgMCAzICZwY2ll
MCAyPiwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8MCAwIDAgNCAmcGNp
ZTAgMz47DQorICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHQtcGFyZW50ID0gPCZwbGljMD47
DQorICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHQtY29udHJvbGxlcjsNCisgICAgICAgICAg
ICAgICAgICAgIG1zaS1wYXJlbnQgPSA8JnBjaWUwPjsNCisgICAgICAgICAgICAgICAgICAgIG1z
aS1jb250cm9sbGVyOw0KKyAgICAgICAgICAgICAgICAgICAgYnVzLXJhbmdlID0gPDB4MDAgMHg3
Zj47DQorICAgICAgICAgICAgICAgICAgICByYW5nZXMgPSA8MHgwMzAwMDAwMCAweDAgMHg0MDAw
MDAwMCAweDAgMHg0MDAwMDAwMCAweDAgMHgyMDAwMDAwMD47DQorICAgICAgICAgICAgICAgICAg
ICBkbWEtcmFuZ2VzID0gPDB4MDIwMDAwMDAgMHgwIDB4MDAwMDAwMDAgMHgwIDB4MDAwMDAwMDAg
MHgxIDB4MDAwMDAwMDA+Ow0KKyAgICAgICAgICAgIH07DQorICAgIH07DQotLSANCjIuMTcuMQ0K
DQo=
