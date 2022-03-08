Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A3A4D1C37
	for <lists+linux-pci@lfdr.de>; Tue,  8 Mar 2022 16:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347950AbiCHPqr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Mar 2022 10:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347891AbiCHPqr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Mar 2022 10:46:47 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B8D4EF65;
        Tue,  8 Mar 2022 07:45:49 -0800 (PST)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KCfgF3TP2zbbxl;
        Tue,  8 Mar 2022 23:40:57 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 8 Mar 2022 23:45:45 +0800
Received: from kwepeml500003.china.huawei.com (7.221.188.182) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 23:45:45 +0800
Received: from kwepeml500003.china.huawei.com ([7.221.188.182]) by
 kwepeml500003.china.huawei.com ([7.221.188.182]) with mapi id 15.01.2308.021;
 Tue, 8 Mar 2022 23:45:45 +0800
From:   "Zhangjiantao(Kirin,Nanjing)" <water.zhangjiantao@huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zhangjianrong (E)" <zhangjianrong5@huawei.com>
Subject: [PATCH2] PCI: dwc: solve returning success but actually failed
Thread-Topic: [PATCH2] PCI: dwc: solve returning success but actually failed
Thread-Index: AdgzA0SpiPZDE9M0Qv2renDvQbfpDw==
Date:   Tue, 8 Mar 2022 15:45:45 +0000
Message-ID: <0dcdea9c559040509dd443ee75de75a1@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.136.108.160]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

V2hlbiBkbWFfbWFwcGluZ19lcnJvcigpIHJldHVybnMgZXJyb3IgYmVjYXVzZSBvZiBubyBlbm91
Z2ggbWVtb3J5IGF2YWlsYWJsZSwgZHdfcGNpZV9ob3N0X2luaXQoKSB3aWxsIHJldHVybiBzdWNj
ZXNzLCB3aGljaCB3aWxsIG1pc2xlYWQgdGhlIGNhbGxlcnMuDQoNCkZpeGVzOiAwNzk0MGMzNjlh
NmIgKCJQQ0k6IGR3YzogRml4IE1TSSBwYWdlIGxlYWthZ2UgaW4gc3VzcGVuZC9yZXN1bWUiKQ0K
DQpTaWduZWQtb2ZmLWJ5OiBKaWFudGFvIFpoYW5nIDx3YXRlci56aGFuZ2ppYW50YW9AaHVhd2Vp
LmNvbT4NClNpZ25lZC1vZmYtYnk6IEppYW5yb25nIFpoYW5nIDx6aGFuZ2ppYW5yb25nNUBodWF3
ZWkuY29tPg0KLS0tDQogwqBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndh
cmUtaG9zdC5jIHwgMyArKy0NCiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZGVzaWdud2FyZS1ob3N0LmMNCmIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1k
ZXNpZ253YXJlLWhvc3QuYw0KaW5kZXggZjQ3NTVmM2EwM2JlLi45ZGNiNTE3MjhkZDEgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5j
DQorKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5j
DQpAQCAtMzkwLDcgKzM5MCw4IEBAIGludCBkd19wY2llX2hvc3RfaW5pdChzdHJ1Y3QgcGNpZV9w
b3J0ICpwcCkNCiDCoMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKg
wqDCoMKgwqAgc2l6ZW9mKHBwLT5tc2lfbXNnKSwNCiDCoMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKg
wqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoMKgwqAgRE1BX0ZST01fREVWSUNFLA0KIMKgwqDCoMKg
IMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgwqDCoCBETUFfQVRUUl9T
S0lQX0NQVV9TWU5DKTsNCi3CoMKgwqAgwqDCoMKgIMKgwqDCoCBpZiAoZG1hX21hcHBpbmdfZXJy
b3IocGNpLT5kZXYsIHBwLT5tc2lfZGF0YSkpIHsNCivCoMKgwqAgwqDCoMKgIMKgwqDCoCByZXQg
PSBkbWFfbWFwcGluZ19lcnJvcihwY2ktPmRldiwgcHAtPm1zaV9kYXRhKTsNCivCoMKgwqAgwqDC
oMKgIMKgwqDCoCBpZiAocmV0KSB7DQogwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgZGV2
X2VycihwY2ktPmRldiwgIkZhaWxlZCB0byBtYXAgTVNJIGRhdGFcbiIpOw0KIMKgwqDCoMKgIMKg
wqDCoCDCoMKgwqAgwqDCoMKgIHBwLT5tc2lfZGF0YSA9IDA7DQogwqDCoMKgwqAgwqDCoMKgIMKg
wqDCoCDCoMKgwqAgZ290byBlcnJfZnJlZV9tc2k7DQotLQ0KMi4xNy4xDQoNCkppYW50YW8gWmhh
bmcNCg0KT24gMjAyMi8zLzUgNTozOSwgQmpvcm4gSGVsZ2FhcyB3cm90ZToNCj4gT24gRnJpLCBN
YXIgMDQsIDIwMjIgYXQgMTI6MDY6MTBQTSArMDAwMCwgWmhhbmdqaWFudGFvKEtpcmluLE5hbmpp
bmcpIHdyb3RlOg0KPj4gV2hlbiBkbWFfbWFwcGluZ19lcnJvciByZXR1cm5zIGVycm9yIGJlY2F1
c2Ugb2Ygbm8gZW5vdWdoIG1lbW9yeSBhdmFpbGFibGUsIGR3X3BjaWVfaG9zdF9pbml0IHdpbGwg
cmV0dXJuIHN1Y2Nlc3MsIHdoaWNoIHdpbGwgbWlzbGVhZCB0aGUgY2FsbGVycy4NCj4gV3JhcCB0
byBmaXQgaW4gNzUgY29sdW1ucywgYWRkICIoKSIgYWZ0ZXIgZnVuY3Rpb24gbmFtZXMuDQo+PiBT
aWduZWQtb2ZmLWJ5OiB6aGFuZ2ppYW5yb25nIDx6aGFuZ2ppYW5yb25nNUBodWF3ZWkuY29tPg0K
Pj4gU2lnbmVkLW9mZi1ieTogemhhbmdqaWFudGFvIDx3YXRlci56aGFuZ2ppYW50YW9AaHVhd2Vp
LmNvbT4NCj4+DQo+PiAtLS0NCj4+ICAgwqBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ll
LWRlc2lnbndhcmUtaG9zdC5jIHwgMSArDQo+PiAgIMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZGVzaWdud2FyZS1ob3N0LmMNCj4+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
ZS1kZXNpZ253YXJlLWhvc3QuYw0KPj4gaW5kZXggZjQ3NTVmM2EwM2JlLi5hYzY5MWQ3MzM4NDgg
MTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndh
cmUtaG9zdC5jDQo+PiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2ln
bndhcmUtaG9zdC5jDQo+PiBAQCAtMzkzLDYgKzM5Myw3IEBAIGludCBkd19wY2llX2hvc3RfaW5p
dChzdHJ1Y3QgcGNpZV9wb3J0ICpwcCkNCj4+ICAgwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCBpZiAo
ZG1hX21hcHBpbmdfZXJyb3IocGNpLT5kZXYsIHBwLT5tc2lfZGF0YSkpIHsNCj4+ICAgwqDCoMKg
wqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgZGV2X2VycihwY2ktPmRldiwgIkZhaWxlZCB0byBtYXAg
TVNJIGRhdGFcbiIpOw0KPj4gICDCoMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCBwcC0+bXNp
X2RhdGEgPSAwOw0KPj4gK8KgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCByZXQgPSAtMTsNCj4g
V2Ugc2hvdWxkIHNhdmUgdGhlIHJldHVybiB2YWx1ZSBmcm9tIGRtYV9tYXBwaW5nX2Vycm9yKCkg
YW5kIHJldHVybiANCj4gKnRoYXQqLCBub3QgLTEuDQo+DQo+IFdoaXRlc3BhY2UgZXJyb3IgKGlu
ZGVudCB3aXRoIHRhYnMsIHNhbWUgYXMgdGhlIHN1cnJvdW5kaW5nIGNvZGUpLg0KPg0KPj4gICDC
oMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCBnb3RvIGVycl9mcmVlX21zaTsNCj4+ICAgwqDC
oMKgwqAgwqDCoMKgIMKgwqDCoCB9DQo+PiAgIMKgwqDCoMKgIMKgwqDCoCB9DQo+PiAtLQ0KPj4g
Mi4xNy4xDQo+Pg0KPiAuDQo=
