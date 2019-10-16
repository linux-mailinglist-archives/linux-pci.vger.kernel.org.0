Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5904D96F5
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 18:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405479AbfJPQUE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 12:20:04 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:44754 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388413AbfJPQUD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Oct 2019 12:20:03 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9GGBmEH007548;
        Wed, 16 Oct 2019 09:19:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=CeBVdXEqUfWDqXrU7/B2svFUGZqLNUraSCAgODrAxk8=;
 b=EU0EGiOPOrp5zREp8NAZWY7Vz0noBaBsyd6zVlx9aOs/7G5z0EwcX6AWDDdmoH/7bWsq
 yXRSP7wDFVyfvr8oZpuQgIp+DSXAA+lQOpBSNUNSvKcyfGjwbm4dof0BePTpGbCRmAi/
 yulNN3R2jg714zuXuGpp2E/lypu2HAiLwxjP+3/EJahQF6FGsuKo4nmbzp7g2NOFuBJu
 CZv5YcsC5+F5MivjkTiD8UInkkE0zlrAQoCuEls171/5abK61QfLu/VP1ZccN1mE7VCi
 z39vugqG36cwlG6nilCsc6XybjeO/PzxY8OnU75anzAg8dJW85jAPZDPievhmEvagP9u lQ== 
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2058.outbound.protection.outlook.com [104.47.34.58])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2vkbd28sjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 16 Oct 2019 09:19:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcntG+UCvWqDLWXGSXYKGM/LosZ7WpYfwTmxGc8RipePhSG6QdDa+EYOtrCKKVqqhIDbJ0YsdpU5sOKC7eM9d6r0cVIjolbmaI0Yvf3dOQHKwBFX1T5hGf7SqyzQJANOpx9ypye4OFtrhy/znTM0znLbPeb8mDzZg4Sx0YpJrb98fzWYfJ1o+SgvHlhbu7H+uDYL6Q3nYQvg5AsIkvBsvDfnvyYONLpMFWwntUni8nIHQJYb5oExJex9DZrJZpWufyCKkN7pMjsW4HcrhaXrAdzn+W2yzUx8pJtc35C882mXJr0QXQmgV5bio8rJDgRDZzuRA5LaGPrqJGpr8rmK2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeBVdXEqUfWDqXrU7/B2svFUGZqLNUraSCAgODrAxk8=;
 b=TVNNctUA7WkCRM6NG79TehUi6vwtcJeFdCWHMIdTlLHi7npSmUlX1WJk2LIhP0kPGtcq+KuPTuhe6bi2HD1/4TfOsP6Yu9WDTl35Ry6lyJ42EFAJYEdIetNPJS3OwURSu+2zvZinSEx6/24rdwQEXgAx27Zb9u0NEPTh2lEE6jxzhi50rGL6BaaOJ1V1NvXVVGL2ukXNzypKRrCae6zjGniUhPHVgX6PBOhmVF42d7/zh1TEgRuiSLHbfWXj96Znh4w/7vd00HFFYlgCs098Nwo5rIbttcGf+PPxEQB9l7JyWPE//3JkKXeU3ETjhttuCt/odmSYs+6K5N12lkeB8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeBVdXEqUfWDqXrU7/B2svFUGZqLNUraSCAgODrAxk8=;
 b=cx4rdHAB9I1qk54/Ppyl+rFdRJdFL9sgEFtpvvDExH6MspZXSMLSHJekLcR6Sp7rylzlzP7kRlCSbuBvVLTTYESnPU0+TnGyPJ6078hG79nn3eBDKblZdtFG305qE+3ZIL4eRt9P/Ye9xp/5wYTOZ3oocRK5V+UnyOOn8qwv1ak=
Received: from MWHPR07MB3853.namprd07.prod.outlook.com (10.172.101.140) by
 MWHPR07MB3855.namprd07.prod.outlook.com (10.172.95.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Wed, 16 Oct 2019 16:19:53 +0000
Received: from MWHPR07MB3853.namprd07.prod.outlook.com
 ([fe80::684c:973d:d098:5c83]) by MWHPR07MB3853.namprd07.prod.outlook.com
 ([fe80::684c:973d:d098:5c83%2]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 16:19:53 +0000
From:   Tom Joseph <tjoseph@cadence.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI:cadence:Driver refactored to use as a core library.
Thread-Topic: [PATCH] PCI:cadence:Driver refactored to use as a core library.
Thread-Index: AQHVd64tW+05SSJVhUuPtpoXMpJoVKdFo8MAgBYCxgCAAeO3YA==
Date:   Wed, 16 Oct 2019 16:19:53 +0000
Message-ID: <MWHPR07MB3853A9429698F1A078BE8B1BA1920@MWHPR07MB3853.namprd07.prod.outlook.com>
References: <1569861768-10109-1-git-send-email-tjoseph@cadence.com>
 <03a8af4b-96bb-48b6-a79b-7db3a2ee59d0@ti.com>
 <ba7cf838-dc20-2007-cbf4-e8fbcd49e69f@ti.com>
In-Reply-To: <ba7cf838-dc20-2007-cbf4-e8fbcd49e69f@ti.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08ad7b38-f5a4-454c-a17c-08d75254ad63
x-ms-traffictypediagnostic: MWHPR07MB3855:
x-microsoft-antispam-prvs: <MWHPR07MB3855C2B6B67E93E06760F0BEA1920@MWHPR07MB3855.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(36092001)(13464003)(199004)(189003)(66066001)(74316002)(5660300002)(33656002)(2501003)(76176011)(256004)(52536014)(71200400001)(71190400001)(14444005)(476003)(7696005)(486006)(26005)(11346002)(446003)(186003)(6506007)(66946007)(76116006)(53546011)(102836004)(25786009)(99286004)(8936002)(86362001)(66476007)(66446008)(64756008)(6436002)(229853002)(66556008)(14454004)(110136005)(316002)(4326008)(305945005)(6246003)(478600001)(81166006)(81156014)(8676002)(54906003)(6116002)(7736002)(3846002)(55016002)(2906002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3855;H:MWHPR07MB3853.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4r0zsy65Qh9+omXwPqeGzXV9xotOfU28gOA2/GSY5d58nblqxpUst8lI3fN5IB16/ZoX4WQqWMKQ+SOCB3gDfHfNBk/LeOs7k2b/SiSWEKHOM6qtXC07U546m65VFU7sXi+qAqfieUDJ1dQkWPR26x6OudQXV3ST/0X6Q1Escx/JHC8csl0r88ICVi2Ft7cepAcMVo7ePC1rwgKLmEXAo8Hk6ZxYXiNsS8T6WiQ8iKwyus3qmLfxEv9HpC2wt4yrqeK8q6gIW1060Ft6aJeT1s1iJb7ir1FtCZrYdH947ZFLWsO7vnIPiDATg2CVIzFSzmTrw/gp5bg7ekSwnjyllpGlPW2T0BRxKux/LOiPhTM9BMdFGuk6jdAvnFNv0yttn04j8hQ2ynWXBCM/S8OtGf4YQ2DYTRT3yE1ELCIHPAI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ad7b38-f5a4-454c-a17c-08d75254ad63
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 16:19:53.4143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eI31zWoO3p3FIL5N5Y86+ePc8xNeekUCq7cRo7rBblEm64T52DNNlrmOCSLRxQEUWnHmKzL7mqcRQCxb7rdxpK66yyLuF6IkZ3+1qhIyIlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3855
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_07:2019-10-16,2019-10-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910160136
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgS2lzaG9uLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtpc2hv
biBWaWpheSBBYnJhaGFtIEkgPGtpc2hvbkB0aS5jb20+DQo+IFNlbnQ6IDE1IE9jdG9iZXIgMjAx
OSAxMjoyMw0KPiBUbzogVG9tIEpvc2VwaCA8dGpvc2VwaEBjYWRlbmNlLmNvbT47IGxpbnV4LXBj
aUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IExvcmVuem8gUGllcmFsaXNpIDxsb3JlbnpvLnBpZXJh
bGlzaUBhcm0uY29tPjsgQmpvcm4gSGVsZ2Fhcw0KPiA8YmhlbGdhYXNAZ29vZ2xlLmNvbT47IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gUENJOmNh
ZGVuY2U6RHJpdmVyIHJlZmFjdG9yZWQgdG8gdXNlIGFzIGEgY29yZSBsaWJyYXJ5Lg0KPiANCj4g
DQo+IEhpIFRvbSwNCj4gDQo+IE9uIDAxLzEwLzE5IDQ6NDUgUE0sIEtpc2hvbiBWaWpheSBBYnJh
aGFtIEkgd3JvdGU6DQo+ID4gSGkgVG9tLA0KPiA+DQo+ID4gT24gMzAvMDkvMTkgMTA6MTIgUE0s
IFRvbSBKb3NlcGggd3JvdGU6DQo+ID4+IEFsbCB0aGUgcGxhdGZvcm0gcmVsYXRlZCBBUElzL1N0
cnVjdHVyZXMgaW4gdGhlIGRyaXZlciBoYXMgYmVlbiBleHRyYWN0ZWQNCj4gPj4gIG91dCB0byBh
IHNlcGFyYXRlIGZpbGUgKHBjaWUtY2FkZW5jZS1wbGF0LmMpLiBUaGlzIHdpbGwgZW5hYmxlIHRo
ZQ0KPiA+PiAgZHJpdmVyIHRvIGJlIHVzZWQgYXMgYSBjb3JlIGxpYnJhcnksIHdoaWNoIGNvdWxk
IGJlIHVzZWQgYnkgb3RoZXINCj4gPj4gIHBsYXRmb3JtIGRyaXZlcnMuVGVzdGluZyB3YXMgZG9u
ZSB1c2luZyBzaW11bGF0aW9uIGVudmlyb25tZW50Lg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5
OiBUb20gSm9zZXBoIDx0am9zZXBoQGNhZGVuY2UuY29tPg0KPiA+PiAtLS0NCj4gPj4gIGRyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvS2NvbmZpZyAgICAgICAgICAgICB8ICAzNSArKysrKysrDQo+ID4+
ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL01ha2VmaWxlICAgICAgICAgICAgfCAgIDEgKw0KPiA+
PiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLWNhZGVuY2UtZXAuYyAgIHwgIDc4ICsrLS0t
LS0tLS0tLS0tLQ0KPiA+PiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLWNhZGVuY2UtaG9z
dC5jIHwgIDc3ICsrKy0tLS0tLS0tLS0tLQ0KPiA+PiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9w
Y2llLWNhZGVuY2UtcGxhdC5jIHwgMTU0DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ID4+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtY2FkZW5jZS5oICAgICAgfCAgNjkg
KysrKysrKysrKysrKw0KPiA+PiAgNiBmaWxlcyBjaGFuZ2VkLCAyNzggaW5zZXJ0aW9ucygrKSwg
MTM2IGRlbGV0aW9ucygtKQ0KPiA+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvcGNpZS1jYWRlbmNlLXBsYXQuYw0KPiA+Pg0KPiANCj4gPHNuaXA+DQo+IA0KPiA+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLWNhZGVuY2UtcGxhdC5j
DQo+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLWNhZGVuY2UtcGxhdC5jDQo+ID4+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4+IGluZGV4IDAwMDAwMDAuLjI3NDYxNWQNCj4gPj4gLS0t
IC9kZXYvbnVsbA0KPiA+PiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtY2FkZW5j
ZS1wbGF0LmMNCj4gPj4gQEAgLTAsMCArMSwxNTQgQEANCj4gPj4gKy8vIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4+ICsvLyBDb3B5cmlnaHQgKGMpIDIwMTkgQ2FkZW5jZQ0K
PiA+PiArLy8gQ2FkZW5jZSBQQ0llIHBsYXRmb3JtICBkcml2ZXIuDQo+ID4+ICsvLyBBdXRob3I6
IFRvbSBKb3NlcGggPHRqb3NlcGhAY2FkZW5jZS5jb20+DQo+ID4+ICsNCj4gPj4gKyNpbmNsdWRl
IDxsaW51eC9rZXJuZWwuaD4NCj4gPj4gKyNpbmNsdWRlIDxsaW51eC9vZl9hZGRyZXNzLmg+DQo+
ID4+ICsjaW5jbHVkZSA8bGludXgvb2ZfcGNpLmg+DQo+ID4+ICsjaW5jbHVkZSA8bGludXgvcGxh
dGZvcm1fZGV2aWNlLmg+DQo+ID4+ICsjaW5jbHVkZSA8bGludXgvcG1fcnVudGltZS5oPg0KPiA+
PiArI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KPiA+PiArI2luY2x1ZGUgInBjaWUtY2Fk
ZW5jZS5oIg0KPiA+PiArDQo+ID4+ICsvKioNCj4gPj4gKyAqIHN0cnVjdCBjZG5zX3BsYXRfcGNp
ZSAtIHByaXZhdGUgZGF0YSBmb3IgdGhpcyBQQ0llIHBsYXRmb3JtIGRyaXZlcg0KPiA+PiArICog
QHBjaWU6IENhZGVuY2UgUENJZSBjb250cm9sbGVyDQo+ID4+ICsgKiBAcmVnbWFwOiBwb2ludGVy
IHRvIFBDSWUgZGV2aWNlDQo+ID4+ICsgKiBAaXNfcmM6IFNldCB0byAxIGluZGljYXRlcyB0aGUg
UENJZSBjb250cm9sbGVyIG1vZGUgaXMgUm9vdCBDb21wbGV4LA0KPiA+PiArICogICAgICAgICBp
ZiAwIGl0IGlzIGluIEVuZHBvaW50IG1vZGUuDQo+ID4+ICsgKi8NCj4gPj4gK3N0cnVjdCBjZG5z
X3BsYXRfcGNpZSB7DQo+ID4+ICsJc3RydWN0IGNkbnNfcGNpZSAgICAgICAgKnBjaWU7DQo+ID4+
ICsJYm9vbCBpc19yYzsNCj4gPj4gK307DQo+ID4+ICsNCj4gPj4gK3N0cnVjdCBjZG5zX3BsYXRf
cGNpZV9vZl9kYXRhIHsNCj4gPj4gKwlib29sIGlzX3JjOw0KPiA+PiArfTsNCj4gPj4gKw0KPiA+
PiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgY2Ruc19wbGF0X3BjaWVfb2ZfbWF0
Y2hbXTsNCj4gPj4gKw0KPiA+PiAraW50IGNkbnNfcGxhdF9wY2llX2xpbmtfY29udHJvbChzdHJ1
Y3QgY2Ruc19wY2llICpwY2llLCBib29sIHN0YXJ0KQ0KPiA+PiArew0KPiA+PiArCXByX2RlYnVn
KCIgJXMgY2FsbGVkXG4iLCBfX2Z1bmNfXyk7DQo+ID4+ICsJcmV0dXJuIDA7DQo+ID4+ICt9DQo+
ID4+ICsNCj4gPj4gK2Jvb2wgY2Ruc19wbGF0X3BjaWVfbGlua19zdGF0dXMoc3RydWN0IGNkbnNf
cGNpZSAqcGNpZSkNCj4gDQo+IEhvdyBkbyB5b3UgZ2V0IGNkbnNfcGxhdF9wY2llIGZyb20gcGNp
ZT8gQ2FkZW5jZSBwbGF0IGRvZXNuJ3QgbmVlZCBpdA0KPiBob3dldmVyDQo+IHRoZSBwbGF0Zm9y
bSBzcGVjaWZpYyBiYXNlIGFkZHJlc3Mgd2lsbCBiZSBzdG9yZWQgaW4gdGhlIHBsYXRmb3JtIHNw
ZWNpZmljDQo+IHN0cnVjdHVyZSAoc3RydWN0IGNkbnNfcGxhdF9wY2llIGhlcmUpIHdoaWNoIHdp
bGwgYmUgdXNlZCBmb3IgcGVyZm9ybWluZw0KPiBjb250cm9sbGVyIGNvbmZpZ3VyYXRpb24uDQo+
IA0KPiBJIHRoaW5rIHlvdSBjYW4ganVzdCBtb3ZlICpkZXYgdG8gc3RydWN0IGNkbnNfcGNpZSBm
cm9tIHN0cnVjdA0KPiBjZG5zX3BjaWVfZXAvc3RydWN0IGNkbnNfcGNpZV9yYyBhbmQgdXNlIGRl
dl9nZXRfZHJ2ZGF0YSBoZXJlIHRvIGdldA0KPiBwbGF0Zm9ybQ0KPiBzcGVjaWZpYyBzdHJ1Y3R1
cmUuDQo+IA0KPiBUaGFua3MNCj4gS2lzaG9uDQoNClRoYW5rcy4gSSB3aWxsIHVwZGF0ZSBpdCBh
cyBzdWdnZXN0ZWQuDQoNClJlZ2FyZHMsDQpUb20NCg==
