Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C5F4CB016
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 21:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244144AbiCBUl4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 15:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236431AbiCBUly (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 15:41:54 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D0CD5F72;
        Wed,  2 Mar 2022 12:41:10 -0800 (PST)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K85b3013fz67nQH;
        Thu,  3 Mar 2022 04:39:59 +0800 (CST)
Received: from lhreml711-chm.china.huawei.com (10.201.108.62) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 21:41:08 +0100
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml711-chm.china.huawei.com (10.201.108.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 20:41:08 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2308.021; Wed, 2 Mar 2022 20:41:08 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     John Garry <john.garry@huawei.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "mgurtovoy@nvidia.com" <mgurtovoy@nvidia.com>,
        "yishaih@nvidia.com" <yishaih@nvidia.com>,
        Linuxarm <linuxarm@huawei.com>,
        liulongfang <liulongfang@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "Jonathan Cameron" <jonathan.cameron@huawei.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>
Subject: RE: [PATCH v7 02/10] crypto: hisilicon/qm: Move few definitions to
 common header
Thread-Topic: [PATCH v7 02/10] crypto: hisilicon/qm: Move few definitions to
 common header
Thread-Index: AQHYLlsnDzCvtI9Dv0mgaWD21xAp4qyscWeAgAAdXCA=
Date:   Wed, 2 Mar 2022 20:41:07 +0000
Message-ID: <0c222fa133a4451abac6de506105eae9@huawei.com>
References: <20220302172903.1995-1-shameerali.kolothum.thodi@huawei.com>
 <20220302172903.1995-3-shameerali.kolothum.thodi@huawei.com>
 <fb7d9ad2-9767-3f6a-2859-4262c992cc76@huawei.com>
In-Reply-To: <fb7d9ad2-9767-3f6a-2859-4262c992cc76@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.91.128]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9obiBHYXJyeQ0KPiBT
ZW50OiAwMiBNYXJjaCAyMDIyIDE4OjU1DQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2Rp
IDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+Ow0KPiBrdm1Admdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1jcnlwdG9Admdl
ci5rZXJuZWwub3JnDQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBhbGV4LndpbGxp
YW1zb25AcmVkaGF0LmNvbTsgamdnQG52aWRpYS5jb207DQo+IGNvaHVja0ByZWRoYXQuY29tOyBt
Z3VydG92b3lAbnZpZGlhLmNvbTsgeWlzaGFpaEBudmlkaWEuY29tOyBMaW51eGFybQ0KPiA8bGlu
dXhhcm1AaHVhd2VpLmNvbT47IGxpdWxvbmdmYW5nIDxsaXVsb25nZmFuZ0BodWF3ZWkuY29tPjsg
WmVuZ3RhbyAoQikNCj4gPHByaW1lLnplbmdAaGlzaWxpY29uLmNvbT47IEpvbmF0aGFuIENhbWVy
b24NCj4gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47IFdhbmd6aG91IChCKSA8d2FuZ3po
b3UxQGhpc2lsaWNvbi5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMDIvMTBdIGNyeXB0
bzogaGlzaWxpY29uL3FtOiBNb3ZlIGZldyBkZWZpbml0aW9ucyB0bw0KPiBjb21tb24gaGVhZGVy
DQo+IA0KPiBPbiAwMi8wMy8yMDIyIDE3OjI4LCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+
IEZyb206IExvbmdmYW5nIExpdSA8bGl1bG9uZ2ZhbmdAaHVhd2VpLmNvbT4NCj4gPg0KPiA+IE1v
dmUgRG9vcmJlbGwgYW5kIE1haWxib3ggZGVmaW5pdGlvbnMgdG8gY29tbW9uIGhlYWRlcg0KPiA+
IGZpbGUuIEFsc28gZXhwb3J0IFFNIG1haWxib3ggZnVuY3Rpb25zLg0KPiA+DQo+ID4gVGhpcyB3
aWxsIGJlIHVzZWZ1bCB3aGVuIHdlIGludHJvZHVjZSBWRklPIFBDSSBIaVNpbGljb24NCj4gPiBB
Q0MgbGl2ZSBtaWdyYXRpb24gZHJpdmVyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTG9uZ2Zh
bmcgTGl1IDxsaXVsb25nZmFuZ0BodWF3ZWkuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoYW1l
ZXIgS29sb3RodW0NCj4gPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT4NCj4g
PiAtLS0NCj4gPiAgIGRyaXZlcnMvY3J5cHRvL2hpc2lsaWNvbi9xbS5jIHwgMzIgKysrKystLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgIGluY2x1ZGUvbGludXgvaGlzaV9hY2NfcW0uaCAg
IHwgMzgNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIDIgZmls
ZXMgY2hhbmdlZCwgNDMgaW5zZXJ0aW9ucygrKSwgMjcgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9jcnlwdG8vaGlzaWxpY29uL3FtLmMgYi9kcml2ZXJzL2NyeXB0
by9oaXNpbGljb24vcW0uYw0KPiA+IGluZGV4IGVkMjNlMWQzZmEyNy4uOGMyOWY5ZmJhNTczIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY3J5cHRvL2hpc2lsaWNvbi9xbS5jDQo+ID4gKysrIGIv
ZHJpdmVycy9jcnlwdG8vaGlzaWxpY29uL3FtLmMNCj4gPiBAQCAtMzMsMjMgKzMzLDYgQEANCj4g
PiAgICNkZWZpbmUgUU1fQUJOT1JNQUxfRVZFTlRfSVJRX1ZFQ1RPUgkzDQo+ID4NCj4gPiAgIC8q
IG1haWxib3ggKi8NCj4gPiAtI2RlZmluZSBRTV9NQl9DTURfU1FDCQkJMHgwDQo+ID4gLSNkZWZp
bmUgUU1fTUJfQ01EX0NRQwkJCTB4MQ0KPiA+IC0jZGVmaW5lIFFNX01CX0NNRF9FUUMJCQkweDIN
Cj4gPiAtI2RlZmluZSBRTV9NQl9DTURfQUVRQwkJCTB4Mw0KPiA+IC0jZGVmaW5lIFFNX01CX0NN
RF9TUUNfQlQJCTB4NA0KPiA+IC0jZGVmaW5lIFFNX01CX0NNRF9DUUNfQlQJCTB4NQ0KPiA+IC0j
ZGVmaW5lIFFNX01CX0NNRF9TUUNfVkZUX1YyCQkweDYNCj4gPiAtI2RlZmluZSBRTV9NQl9DTURf
U1RPUF9RUAkJMHg4DQo+ID4gLSNkZWZpbmUgUU1fTUJfQ01EX1NSQwkJCTB4Yw0KPiA+IC0jZGVm
aW5lIFFNX01CX0NNRF9EU1QJCQkweGQNCj4gPiAtDQo+ID4gLSNkZWZpbmUgUU1fTUJfQ01EX1NF
TkRfQkFTRQkJMHgzMDANCj4gPiAtI2RlZmluZSBRTV9NQl9FVkVOVF9TSElGVAkJOA0KPiA+IC0j
ZGVmaW5lIFFNX01CX0JVU1lfU0hJRlQJCTEzDQo+ID4gLSNkZWZpbmUgUU1fTUJfT1BfU0hJRlQJ
CQkxNA0KPiA+IC0jZGVmaW5lIFFNX01CX0NNRF9EQVRBX0FERFJfTAkJMHgzMDQNCj4gPiAtI2Rl
ZmluZSBRTV9NQl9DTURfREFUQV9BRERSX0gJCTB4MzA4DQo+ID4gICAjZGVmaW5lIFFNX01CX1BJ
TkdfQUxMX1ZGUwkJMHhmZmZmDQo+ID4gICAjZGVmaW5lIFFNX01CX0NNRF9EQVRBX1NISUZUCQkz
Mg0KPiA+ICAgI2RlZmluZSBRTV9NQl9DTURfREFUQV9NQVNLCQlHRU5NQVNLKDMxLCAwKQ0KPiA+
IEBAIC0xMDMsMTkgKzg2LDEyIEBADQo+ID4gICAjZGVmaW5lIFFNX0RCX0NNRF9TSElGVF9WMQkJ
MTYNCj4gPiAgICNkZWZpbmUgUU1fREJfSU5ERVhfU0hJRlRfVjEJCTMyDQo+ID4gICAjZGVmaW5l
IFFNX0RCX1BSSU9SSVRZX1NISUZUX1YxCQk0OA0KPiA+IC0jZGVmaW5lIFFNX0RPT1JCRUxMX1NR
X0NRX0JBU0VfVjIJMHgxMDAwDQo+ID4gLSNkZWZpbmUgUU1fRE9PUkJFTExfRVFfQUVRX0JBU0Vf
VjIJMHgyMDAwDQo+ID4gICAjZGVmaW5lIFFNX1FVRV9JU09fQ0ZHX1YJCTB4MDAzMA0KPiA+ICAg
I2RlZmluZSBRTV9QQUdFX1NJWkUJCQkweDAwMzQNCj4gPiAgICNkZWZpbmUgUU1fUVVFX0lTT19F
TgkJCTB4MTAwMTU0DQo+ID4gICAjZGVmaW5lIFFNX0NBUEJJTElUWQkJCTB4MTAwMTU4DQo+ID4g
ICAjZGVmaW5lIFFNX1FQX05VTl9NQVNLCQkJR0VOTUFTSygxMCwgMCkNCj4gPiAgICNkZWZpbmUg
UU1fUVBfREJfSU5URVJWQUwJCTB4MTAwMDANCj4gPiAtI2RlZmluZSBRTV9RUF9NQVhfTlVNX1NI
SUZUCQkxMQ0KPiA+IC0jZGVmaW5lIFFNX0RCX0NNRF9TSElGVF9WMgkJMTINCj4gPiAtI2RlZmlu
ZSBRTV9EQl9SQU5EX1NISUZUX1YyCQkxNg0KPiA+IC0jZGVmaW5lIFFNX0RCX0lOREVYX1NISUZU
X1YyCQkzMg0KPiA+IC0jZGVmaW5lIFFNX0RCX1BSSU9SSVRZX1NISUZUX1YyCQk0OA0KPiA+DQo+
ID4gICAjZGVmaW5lIFFNX01FTV9TVEFSVF9JTklUCQkweDEwMDA0MA0KPiA+ICAgI2RlZmluZSBR
TV9NRU1fSU5JVF9ET05FCQkweDEwMDA0NA0KPiA+IEBAIC02OTMsNyArNjY5LDcgQEAgc3RhdGlj
IHZvaWQgcW1fbWJfcHJlX2luaXQoc3RydWN0IHFtX21haWxib3gNCj4gKm1haWxib3gsIHU4IGNt
ZCwNCj4gPiAgIH0NCj4gPg0KPiA+ICAgLyogcmV0dXJuIDAgbWFpbGJveCByZWFkeSwgLUVUSU1F
RE9VVCBoYXJkd2FyZSB0aW1lb3V0ICovDQo+ID4gLXN0YXRpYyBpbnQgcW1fd2FpdF9tYl9yZWFk
eShzdHJ1Y3QgaGlzaV9xbSAqcW0pDQo+ID4gK2ludCBxbV93YWl0X21iX3JlYWR5KHN0cnVjdCBo
aXNpX3FtICpxbSkNCj4gPiAgIHsNCj4gPiAgIAl1MzIgdmFsOw0KPiA+DQo+ID4gQEAgLTcwMSw2
ICs2NzcsNyBAQCBzdGF0aWMgaW50IHFtX3dhaXRfbWJfcmVhZHkoc3RydWN0IGhpc2lfcW0gKnFt
KQ0KPiA+ICAgCQkJCQkgIHZhbCwgISgodmFsID4+IFFNX01CX0JVU1lfU0hJRlQpICYNCj4gPiAg
IAkJCQkJICAweDEpLCBQT0xMX1BFUklPRCwgUE9MTF9USU1FT1VUKTsNCj4gPiAgIH0NCj4gPiAr
RVhQT1JUX1NZTUJPTF9HUEwocW1fd2FpdF9tYl9yZWFkeSk7DQo+IA0KPiBTaW5jZSB0aGVzZSB3
aWxsIGJlIHB1YmxpYyB0aGV5IHJlcXVpcmUgYSBtb3JlIGRpc3RpbmN0aXZlIG5hbWUsIGxpa2UN
Cj4gaGlzaV9xbV93YWl0X21iX3JlYWR5IG9yIGhpc2lfYWNjX3FtX3dhaXRfbWJfcmVhZHkNCj4g
DQo+ID4NCj4gPiAgIC8qIDEyOCBiaXQgc2hvdWxkIGJlIHdyaXR0ZW4gdG8gaGFyZHdhcmUgYXQg
b25lIHRpbWUgdG8gdHJpZ2dlciBhIG1haWxib3gNCj4gKi8NCj4gPiAgIHN0YXRpYyB2b2lkIHFt
X21iX3dyaXRlKHN0cnVjdCBoaXNpX3FtICpxbSwgY29uc3Qgdm9pZCAqc3JjKQ0KPiA+IEBAIC03
NDUsOCArNzIyLDggQEAgc3RhdGljIGludCBxbV9tYl9ub2xvY2soc3RydWN0IGhpc2lfcW0gKnFt
LCBzdHJ1Y3QNCj4gcW1fbWFpbGJveCAqbWFpbGJveCkNCj4gPiAgIAlyZXR1cm4gLUVCVVNZOw0K
PiA+ICAgfQ0KPiA+DQo+ID4gLXN0YXRpYyBpbnQgcW1fbWIoc3RydWN0IGhpc2lfcW0gKnFtLCB1
OCBjbWQsIGRtYV9hZGRyX3QgZG1hX2FkZHIsIHUxNg0KPiBxdWV1ZSwNCj4gPiAtCQkgYm9vbCBv
cCkNCj4gPiAraW50IHFtX21iKHN0cnVjdCBoaXNpX3FtICpxbSwgdTggY21kLCBkbWFfYWRkcl90
IGRtYV9hZGRyLCB1MTYgcXVldWUsDQo+ID4gKwkgIGJvb2wgb3ApDQo+ID4gICB7DQo+ID4gICAJ
c3RydWN0IHFtX21haWxib3ggbWFpbGJveDsNCj4gPiAgIAlpbnQgcmV0Ow0KPiA+IEBAIC03NjIs
NiArNzM5LDcgQEAgc3RhdGljIGludCBxbV9tYihzdHJ1Y3QgaGlzaV9xbSAqcW0sIHU4IGNtZCwN
Cj4gZG1hX2FkZHJfdCBkbWFfYWRkciwgdTE2IHF1ZXVlLA0KPiA+DQo+ID4gICAJcmV0dXJuIHJl
dDsNCj4gPiAgIH0NCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwocW1fbWIpOw0KPiA+DQo+ID4gICBz
dGF0aWMgdm9pZCBxbV9kYl92MShzdHJ1Y3QgaGlzaV9xbSAqcW0sIHUxNiBxbiwgdTggY21kLCB1
MTYgaW5kZXgsIHU4DQo+IHByaW9yaXR5KQ0KPiA+ICAgew0KPiA+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L2hpc2lfYWNjX3FtLmggYi9pbmNsdWRlL2xpbnV4L2hpc2lfYWNjX3FtLmgNCj4g
PiBpbmRleCAzMDY4MDkzMjI5YTUuLjhiZWZiNTljNmZiMyAxMDA2NDQNCj4gPiAtLS0gYS9pbmNs
dWRlL2xpbnV4L2hpc2lfYWNjX3FtLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2hpc2lfYWNj
X3FtLmgNCj4gPiBAQCAtMzQsNiArMzQsNDAgQEANCj4gPiAgICNkZWZpbmUgUU1fV1VTRVJfTV9D
RkdfRU5BQkxFCQkweDEwMDBhOA0KPiA+ICAgI2RlZmluZSBXVVNFUl9NX0NGR19FTkFCTEUJCTB4
ZmZmZmZmZmYNCj4gPg0KPiA+ICsvKiBtYWlsYm94ICovDQo+ID4gKyNkZWZpbmUgUU1fTUJfQ01E
X1NRQyAgICAgICAgICAgICAgICAgICAweDANCj4gPiArI2RlZmluZSBRTV9NQl9DTURfQ1FDICAg
ICAgICAgICAgICAgICAgIDB4MQ0KPiA+ICsjZGVmaW5lIFFNX01CX0NNRF9FUUMgICAgICAgICAg
ICAgICAgICAgMHgyDQo+ID4gKyNkZWZpbmUgUU1fTUJfQ01EX0FFUUMgICAgICAgICAgICAgICAg
ICAweDMNCj4gPiArI2RlZmluZSBRTV9NQl9DTURfU1FDX0JUICAgICAgICAgICAgICAgIDB4NA0K
PiA+ICsjZGVmaW5lIFFNX01CX0NNRF9DUUNfQlQgICAgICAgICAgICAgICAgMHg1DQo+ID4gKyNk
ZWZpbmUgUU1fTUJfQ01EX1NRQ19WRlRfVjIgICAgICAgICAgICAweDYNCj4gPiArI2RlZmluZSBR
TV9NQl9DTURfU1RPUF9RUCAgICAgICAgICAgICAgIDB4OA0KPiA+ICsjZGVmaW5lIFFNX01CX0NN
RF9TUkMgICAgICAgICAgICAgICAgICAgMHhjDQo+ID4gKyNkZWZpbmUgUU1fTUJfQ01EX0RTVCAg
ICAgICAgICAgICAgICAgICAweGQNCj4gPiArDQo+ID4gKyNkZWZpbmUgUU1fTUJfQ01EX1NFTkRf
QkFTRQkJMHgzMDANCj4gPiArI2RlZmluZSBRTV9NQl9FVkVOVF9TSElGVCAgICAgICAgICAgICAg
IDgNCj4gPiArI2RlZmluZSBRTV9NQl9CVVNZX1NISUZUCQkxMw0KPiA+ICsjZGVmaW5lIFFNX01C
X09QX1NISUZUCQkJMTQNCj4gPiArI2RlZmluZSBRTV9NQl9DTURfREFUQV9BRERSX0wJCTB4MzA0
DQo+ID4gKyNkZWZpbmUgUU1fTUJfQ01EX0RBVEFfQUREUl9ICQkweDMwOA0KPiA+ICsjZGVmaW5l
IFFNX01CX01BWF9XQUlUX0NOVAkJNjAwMA0KPiA+ICsNCj4gPiArLyogZG9vcmJlbGwgKi8NCj4g
PiArI2RlZmluZSBRTV9ET09SQkVMTF9DTURfU1EgICAgICAgICAgICAgIDANCj4gPiArI2RlZmlu
ZSBRTV9ET09SQkVMTF9DTURfQ1EgICAgICAgICAgICAgIDENCj4gPiArI2RlZmluZSBRTV9ET09S
QkVMTF9DTURfRVEgICAgICAgICAgICAgIDINCj4gPiArI2RlZmluZSBRTV9ET09SQkVMTF9DTURf
QUVRICAgICAgICAgICAgIDMNCj4gPiArDQo+ID4gKyNkZWZpbmUgUU1fRE9PUkJFTExfU1FfQ1Ff
QkFTRV9WMgkweDEwMDANCj4gPiArI2RlZmluZSBRTV9ET09SQkVMTF9FUV9BRVFfQkFTRV9WMgkw
eDIwMDANCj4gPiArI2RlZmluZSBRTV9RUF9NQVhfTlVNX1NISUZUICAgICAgICAgICAgIDExDQo+
ID4gKyNkZWZpbmUgUU1fREJfQ01EX1NISUZUX1YyCQkxMg0KPiA+ICsjZGVmaW5lIFFNX0RCX1JB
TkRfU0hJRlRfVjIJCTE2DQo+ID4gKyNkZWZpbmUgUU1fREJfSU5ERVhfU0hJRlRfVjIJCTMyDQo+
ID4gKyNkZWZpbmUgUU1fREJfUFJJT1JJVFlfU0hJRlRfVjIJCTQ4DQo+ID4gKw0KPiA+ICAgLyog
cW0gY2FjaGUgKi8NCj4gPiAgICNkZWZpbmUgUU1fQ0FDSEVfQ1RMCQkJMHgxMDAwNTANCj4gPiAg
ICNkZWZpbmUgU1FDX0NBQ0hFX0VOQUJMRQkJQklUKDApDQo+ID4gQEAgLTQxNCw2ICs0NDgsMTAg
QEAgcGNpX2Vyc19yZXN1bHRfdCBoaXNpX3FtX2Rldl9zbG90X3Jlc2V0KHN0cnVjdA0KPiBwY2lf
ZGV2ICpwZGV2KTsNCj4gPiAgIHZvaWQgaGlzaV9xbV9yZXNldF9wcmVwYXJlKHN0cnVjdCBwY2lf
ZGV2ICpwZGV2KTsNCj4gPiAgIHZvaWQgaGlzaV9xbV9yZXNldF9kb25lKHN0cnVjdCBwY2lfZGV2
ICpwZGV2KTsNCj4gPg0KPiA+ICtpbnQgcW1fd2FpdF9tYl9yZWFkeShzdHJ1Y3QgaGlzaV9xbSAq
cW0pOw0KPiA+ICtpbnQgcW1fbWIoc3RydWN0IGhpc2lfcW0gKnFtLCB1OCBjbWQsIGRtYV9hZGRy
X3QgZG1hX2FkZHIsIHUxNiBxdWV1ZSwNCj4gPiArCSAgYm9vbCBvcCk7DQo+IA0KPiBBcyBhYm92
ZSwgcGxlYXNlIG5vdGljZSBob3cgZXZlcnl0aGluZyBlbHNlIGhhcyBhICJoaXNpIiBwcmVmaXgN
Cg0KTWFrZSBzZW5zZS4gV2lsbCBkby4NCg0KVGhhbmtzLA0KU2hhbWVlcg0KDQo+IA0KPiA+ICsN
Cj4gPiAgIHN0cnVjdCBoaXNpX2FjY19zZ2xfcG9vbDsNCj4gPiAgIHN0cnVjdCBoaXNpX2FjY19o
d19zZ2wgKmhpc2lfYWNjX3NnX2J1Zl9tYXBfdG9faHdfc2dsKHN0cnVjdCBkZXZpY2UNCj4gKmRl
diwNCj4gPiAgIAlzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnbCwgc3RydWN0IGhpc2lfYWNjX3NnbF9w
b29sICpwb29sLA0KDQo=
