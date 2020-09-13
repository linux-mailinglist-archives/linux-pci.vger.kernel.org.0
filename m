Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87237268033
	for <lists+linux-pci@lfdr.de>; Sun, 13 Sep 2020 18:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgIMQRZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Sep 2020 12:17:25 -0400
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:9102
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725956AbgIMQRS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 13 Sep 2020 12:17:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQJPaFSbDljBtvWZIiwPSGkY5n+MEWXtoHpYaCUuzaixjE2G3GNZgvq2SArupXS+SlnJefXl6IgDGI7N4gSP6TygXQYoNuZrphs5IXEQjMn0N6LZoZ28SI2eN+r8vcs8kmlP4Bd9VKAoWiVU5TZBWY3Jj4xhs+LewXu288rglMpqXpcHk6S5s84eanMltJ3lFx64qzZ0JVQqBAd9sxSm3ZvHRg2xx25QOrNFYlWuDLeEJszSMRvZ9cQd5l0AB4g1a+3y1LrPisGd7FgoaU4M/rq/nQmy7nJK69LZ41ihmp+/1sUGdUDf7+SPnOzxHE2OELOx6v93nm85n9i/hpIImg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bumO07WZwIfU5Pqvfy0VXIKETyr7sOGuMPim+L62SDk=;
 b=Vckb+RhsUXjuTrKI+Uxh+ocwGzJo0J376l06plIfSBpCG5nVj6sUw498ka146QqCmFkAJfuForKJpsyGgbIOkVubdpS+82lWoNFZ6nXkNctuO0moulRkKjnMJwQgaiO2Cf44DvkgfcnUKlcMQTxGyIN6H7C6BNzJkAW7A6kNUdMXQV/BiStR+SY0cCEJHpMtLMkewnDQfLEDl30U4f3hhQaRYXAk0KhFwx7K/FQsNxS3arDRSFOoeClmeQ5eHVvfVlCFNKMC2VaMleRPzp5t3Etg08xH8VEfT5MAckdgxkVhXTnWu/TPo1O4N2idPaVQqndf5fMUG3M+ARCpLTvtGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bumO07WZwIfU5Pqvfy0VXIKETyr7sOGuMPim+L62SDk=;
 b=VfKVO3HwMr7IvEEtJTlOeBdkf72VYHqtrKyuaP58Kn0IcWzJ+O0jEAuU+/Eid0qeUw07+J5towPW3Jd8//8My+rcNUX26FI6xFkRfNjcpB6er4Njm0eypS7JoEG+k947dG5dFU2+vxUUpdNYT6qY6r4riobxeGwd1O8Fkkflf+I=
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR04MB3307.eurprd04.prod.outlook.com (2603:10a6:7:23::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Sun, 13 Sep
 2020 16:17:12 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::c872:d354:7cf7:deb9]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::c872:d354:7cf7:deb9%3]) with mapi id 15.20.3370.018; Sun, 13 Sep 2020
 16:17:12 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "M.h. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>
Subject: RE: [PATCH 1/7] PCI: dwc: Fix a bug of the case dw_pci->ops is NULL
Thread-Topic: [PATCH 1/7] PCI: dwc: Fix a bug of the case dw_pci->ops is NULL
Thread-Index: AQHWhNorf38ULZ61u0GuKdLTkLaVfqlgDX0AgAa7LjA=
Date:   Sun, 13 Sep 2020 16:17:11 +0000
Message-ID: <HE1PR0402MB337146348130CCCEF5D3888284220@HE1PR0402MB3371.eurprd04.prod.outlook.com>
References: <20200907053801.22149-1-Zhiqiang.Hou@nxp.com>
 <20200907053801.22149-2-Zhiqiang.Hou@nxp.com>
 <DM5PR12MB1276C5F2E31AC703C3AB67C0DA260@DM5PR12MB1276.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1276C5F2E31AC703C3AB67C0DA260@DM5PR12MB1276.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1bc5d5e-372f-49cd-0c5c-08d8580078a8
x-ms-traffictypediagnostic: HE1PR04MB3307:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR04MB3307425F119CA3945D8BE0A784220@HE1PR04MB3307.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GWTqHQW+WwEPnSa0S4wMb+4fbL+Fid6ZvpFWaKptQ26Ym4Tjk7Yi886e6pLgq1HX65sbjlW6E9r7znFzrgi0xXumMDbtpv8JTd2b/0LNYu6kwZgzPQOoWi7xzXQ+WTTb9z6iiKtQLaGtuGvNLmDmhaxKzGZmXhi341gjoxhJAxUIp4YUx52knMTNSMmxMhLtrsW3nikKRCHVRLltBQCe0XOjXq8DCwDg90V2aWhCA12jytCGVvCgldkVMdmqSjuGCqXh9GXgGGH8cfym4vFVZkTjDKJzpvL/RLhBuNCWuk3TIlxR+z67R7JJ+GKnZSMw/q34/LGOpN54pM4Y/q3eSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(66946007)(5660300002)(54906003)(26005)(71200400001)(478600001)(8676002)(55016002)(33656002)(8936002)(110136005)(186003)(6506007)(53546011)(83380400001)(86362001)(52536014)(2906002)(64756008)(66446008)(9686003)(66476007)(316002)(66556008)(76116006)(7696005)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: rqcUHkjlrtmGwJy/nPMR+ARm0Lb2/YfBQH4wlEwBPlOjUg5r5/pEBOw24MuYOUO0E40r9GuJwYHjmULTwD1UxVWfud4QE0KxsEJepOQ769rFXyKnVlM6DhXezF0499/Jdq6FFuP38AIAbDXc6PclIFqKdfIclf48L+JOQUwUULSUMn8nzZve3pTBWy5bK5aaCWlchEmxPxAgba1143wKb1Fu++/BXtfpTSC/Zu7JBDr+MC3wY7Ys9doj9o0qvtTfsmBEV2szw99uvr51rZN1IwMETIBLRB+W+7ofhM28MU+9qqXLFl7OVqirFQFgxyK3BOHhyKkjGX8uFepUJ8QTRKyimhcFqcudYrRf7qNP7YPlR0xuXWVdJ9ryRTwYEnEsltBreMBZ7OqN1L8WQbo5dY533xSAjOk3XG79fScjVFudP9pqa5i4G+lNcwymHSYaMnr7Rv3ERsFLdJYbxtYrvldlUN4CwUd2x+i7lDRW6TmUNy9fZlEpMDzZTpEzN53dOC69JUDut17kEhcSvEgcP6Ec5h0KAVaT34VmFkx8Ac3qB+vUA49zHQUtLT9eJAWR9UX6XXrO/MxFdS2Z0BxzGJ44r82+Xk2jhnZJ7oG/axHIev4xtwkscXue6Owv3vxiozKgKC2xQDHYYp/GsGBTaQ==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1bc5d5e-372f-49cd-0c5c-08d8580078a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2020 16:17:11.8389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ekYXC3tx7hqfx4FLlH8AEojIEnVYNrgzOmLF1oO+CrPhyQ8zCKdMXhAgoEKCXbjnh475lSeH7IGyntquhbBQIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3307
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgR3VzdGF2bywNCg0KVGhhbmtzIGEgbG90IGZvciB5b3VyIHJldmlldyBhbmQgYWNrIQ0KDQpS
ZWdhcmRzLA0KWmhpcWlhbmcNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBHdXN0YXZvIFBpbWVudGVsIDxHdXN0YXZvLlBpbWVudGVsQHN5bm9wc3lzLmNvbT4NCj4gU2Vu
dDogMjAyMMTqOdTCOcjVIDE3OjI5DQo+IFRvOiBaLnEuIEhvdSA8emhpcWlhbmcuaG91QG54cC5j
b20+OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNv
bTsgcm9iaCtkdEBrZXJuZWwub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBMZW8gTGkNCj4gPGxl
b3lhbmcubGlAbnhwLmNvbT47IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20NCj4gQ2M6IE0uaC4g
TGlhbiA8bWluZ2h1YW4ubGlhbkBueHAuY29tPjsgTWluZ2thaSBIdQ0KPiA8bWluZ2thaS5odUBu
eHAuY29tPjsgUm95IFphbmcgPHJveS56YW5nQG54cC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFU
Q0ggMS83XSBQQ0k6IGR3YzogRml4IGEgYnVnIG9mIHRoZSBjYXNlIGR3X3BjaS0+b3BzIGlzIE5V
TEwNCj4gDQo+IEhpIEhvdSwNCj4gDQo+IE9uIE1vbiwgU2VwIDcsIDIwMjAgYXQgNjozNzo1NSwg
WmhpcWlhbmcgSG91IDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gd3JvdGU6DQo+IA0KPiA+IEZy
b206IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4NCj4gPiBUaGUgZHdf
cGNpLT5vcHMgbWF5IGJlIGEgTlVMTCwgYW5kIGZpeCBpdCBieSBhZGRpbmcgb25lIG1vcmUgY2hl
Y2suDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBu
eHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRl
c2lnbndhcmUuYyB8IDEyICsrKysrKy0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNl
cnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jDQo+ID4gYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuYw0KPiA+IGluZGV4IGI3MjNlMGNjNDFmYi4u
YmRmODkzOGRhOWNkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaWUtZGVzaWdud2FyZS5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS1kZXNpZ253YXJlLmMNCj4gPiBAQCAtMTQwLDcgKzE0MCw3IEBAIHUzMiBkd19wY2llX3Jl
YWRfZGJpKHN0cnVjdCBkd19wY2llICpwY2ksIHUzMg0KPiByZWcsIHNpemVfdCBzaXplKQ0KPiA+
ICAJaW50IHJldDsNCj4gPiAgCXUzMiB2YWw7DQo+ID4NCj4gPiAtCWlmIChwY2ktPm9wcy0+cmVh
ZF9kYmkpDQo+ID4gKwlpZiAocGNpLT5vcHMgJiYgcGNpLT5vcHMtPnJlYWRfZGJpKQ0KPiA+ICAJ
CXJldHVybiBwY2ktPm9wcy0+cmVhZF9kYmkocGNpLCBwY2ktPmRiaV9iYXNlLCByZWcsIHNpemUp
Ow0KPiA+DQo+ID4gIAlyZXQgPSBkd19wY2llX3JlYWQocGNpLT5kYmlfYmFzZSArIHJlZywgc2l6
ZSwgJnZhbCk7IEBAIC0xNTUsNw0KPiA+ICsxNTUsNyBAQCB2b2lkIGR3X3BjaWVfd3JpdGVfZGJp
KHN0cnVjdCBkd19wY2llICpwY2ksIHUzMiByZWcsIHNpemVfdA0KPiA+IHNpemUsIHUzMiB2YWwp
ICB7DQo+ID4gIAlpbnQgcmV0Ow0KPiA+DQo+ID4gLQlpZiAocGNpLT5vcHMtPndyaXRlX2RiaSkg
ew0KPiA+ICsJaWYgKHBjaS0+b3BzICYmIHBjaS0+b3BzLT53cml0ZV9kYmkpIHsNCj4gPiAgCQlw
Y2ktPm9wcy0+d3JpdGVfZGJpKHBjaSwgcGNpLT5kYmlfYmFzZSwgcmVnLCBzaXplLCB2YWwpOw0K
PiA+ICAJCXJldHVybjsNCj4gPiAgCX0NCj4gPiBAQCAtMjAwLDcgKzIwMCw3IEBAIHUzMiBkd19w
Y2llX3JlYWRfYXR1KHN0cnVjdCBkd19wY2llICpwY2ksIHUzMg0KPiByZWcsIHNpemVfdCBzaXpl
KQ0KPiA+ICAJaW50IHJldDsNCj4gPiAgCXUzMiB2YWw7DQo+ID4NCj4gPiAtCWlmIChwY2ktPm9w
cy0+cmVhZF9kYmkpDQo+ID4gKwlpZiAocGNpLT5vcHMgJiYgcGNpLT5vcHMtPnJlYWRfZGJpKQ0K
PiA+ICAJCXJldHVybiBwY2ktPm9wcy0+cmVhZF9kYmkocGNpLCBwY2ktPmF0dV9iYXNlLCByZWcs
IHNpemUpOw0KPiA+DQo+ID4gIAlyZXQgPSBkd19wY2llX3JlYWQocGNpLT5hdHVfYmFzZSArIHJl
Zywgc2l6ZSwgJnZhbCk7IEBAIC0yMTQsNw0KPiA+ICsyMTQsNyBAQCB2b2lkIGR3X3BjaWVfd3Jp
dGVfYXR1KHN0cnVjdCBkd19wY2llICpwY2ksIHUzMiByZWcsIHNpemVfdA0KPiA+IHNpemUsIHUz
MiB2YWwpICB7DQo+ID4gIAlpbnQgcmV0Ow0KPiA+DQo+ID4gLQlpZiAocGNpLT5vcHMtPndyaXRl
X2RiaSkgew0KPiA+ICsJaWYgKHBjaS0+b3BzICYmIHBjaS0+b3BzLT53cml0ZV9kYmkpIHsNCj4g
PiAgCQlwY2ktPm9wcy0+d3JpdGVfZGJpKHBjaSwgcGNpLT5hdHVfYmFzZSwgcmVnLCBzaXplLCB2
YWwpOw0KPiA+ICAJCXJldHVybjsNCj4gPiAgCX0NCj4gPiBAQCAtMjgzLDcgKzI4Myw3IEBAIHZv
aWQgZHdfcGNpZV9wcm9nX291dGJvdW5kX2F0dShzdHJ1Y3QgZHdfcGNpZQ0KPiA+ICpwY2ksIGlu
dCBpbmRleCwgaW50IHR5cGUsICB7DQo+ID4gIAl1MzIgcmV0cmllcywgdmFsOw0KPiA+DQo+ID4g
LQlpZiAocGNpLT5vcHMtPmNwdV9hZGRyX2ZpeHVwKQ0KPiA+ICsJaWYgKHBjaS0+b3BzICYmIHBj
aS0+b3BzLT5jcHVfYWRkcl9maXh1cCkNCj4gPiAgCQljcHVfYWRkciA9IHBjaS0+b3BzLT5jcHVf
YWRkcl9maXh1cChwY2ksIGNwdV9hZGRyKTsNCj4gPg0KPiA+ICAJaWYgKHBjaS0+aWF0dV91bnJv
bGxfZW5hYmxlZCkgew0KPiA+IEBAIC00NzAsNyArNDcwLDcgQEAgaW50IGR3X3BjaWVfbGlua191
cChzdHJ1Y3QgZHdfcGNpZSAqcGNpKSAgew0KPiA+ICAJdTMyIHZhbDsNCj4gPg0KPiA+IC0JaWYg
KHBjaS0+b3BzLT5saW5rX3VwKQ0KPiA+ICsJaWYgKHBjaS0+b3BzICYmIHBjaS0+b3BzLT5saW5r
X3VwKQ0KPiA+ICAJCXJldHVybiBwY2ktPm9wcy0+bGlua191cChwY2kpOw0KPiA+DQo+ID4gIAl2
YWwgPSByZWFkbChwY2ktPmRiaV9iYXNlICsgUENJRV9QT1JUX0RFQlVHMSk7DQo+ID4gLS0NCj4g
PiAyLjE3LjENCj4gDQo+IExvb2tzIGdvb2QgdG8gbWUuDQo+IA0KPiBBY2tlZC1ieTogR3VzdGF2
byBQaW1lbnRlbCA8Z3VzdGF2by5waW1lbnRlbEBzeW5vcHN5cy5jb20+DQo+IA0KPiANCj4gDQoN
Cg==
