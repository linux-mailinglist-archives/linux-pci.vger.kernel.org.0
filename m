Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 082A114F0FA
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2020 17:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgAaQ7u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jan 2020 11:59:50 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:41746 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726252AbgAaQ7t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Jan 2020 11:59:49 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 762B34799F;
        Fri, 31 Jan 2020 16:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        mime-version:content-transfer-encoding:content-id:content-type
        :content-type:content-language:accept-language:in-reply-to
        :references:message-id:date:date:subject:subject:from:from
        :received:received:received:received; s=mta-01; t=1580489985; x=
        1582304386; bh=RF+aNb5W48PxX9pYt/PWbbgyXE64qwW+ONgeU+D4Buk=; b=a
        NarOgVKaBvLaix1UHA2rP1fBbK9VqN6Xtpaefosf/uWEx4XPDi6UaEMp9W15dh4o
        PcvgsyQHLz/dnk5FZwwBAanNa6NG0nUHBtYOnMCS+HibCHgzxbeA20yKc7bp3vHU
        3gXndAZxkO7+5yDy6FJHYoRrr5HgVcz6ZuEAGepfJs=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qvCKXR2B34lJ; Fri, 31 Jan 2020 19:59:45 +0300 (MSK)
Received: from T-EXCH-01.corp.yadro.com (t-exch-01.corp.yadro.com [172.17.10.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 6DABD47998;
        Fri, 31 Jan 2020 19:59:45 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (172.17.10.102) by
 T-EXCH-01.corp.yadro.com (172.17.10.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Fri, 31 Jan 2020 19:59:44 +0300
Received: from T-EXCH-02.corp.yadro.com ([fe80::19dd:9b61:5447:ff23]) by
 T-EXCH-02.corp.yadro.com ([fe80::19dd:9b61:5447:ff23%14]) with mapi id
 15.01.0669.032; Fri, 31 Jan 2020 19:59:44 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux@yadro.com" <linux@yadro.com>, "sr@denx.de" <sr@denx.de>
Subject: Re: [PATCH v7 09/26] PCI: hotplug: Calculate immovable parts of
 bridge windows
Thread-Topic: [PATCH v7 09/26] PCI: hotplug: Calculate immovable parts of
 bridge windows
Thread-Index: AQHV1rj2hqut6rsu3UmdakMtPQf/b6gDiECAgAFHrwA=
Date:   Fri, 31 Jan 2020 16:59:44 +0000
Message-ID: <c9112d99415bdbd626362c63a3c473bafcc5ec26.camel@yadro.com>
References: <20200130212655.GA128349@google.com>
In-Reply-To: <20200130212655.GA128349@google.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [172.17.15.136]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E74EAB7CCD40C4E84605CEF2E0322A9@yadro.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIwLTAxLTMwIGF0IDE1OjI2IC0wNjAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBXZWQsIEphbiAyOSwgMjAyMCBhdCAwNjoyOToyMFBNICswMzAwLCBTZXJnZWkgTWlyb3No
bmljaGVua28NCj4gd3JvdGU6DQo+ID4gV2hlbiBtb3ZhYmxlIEJBUnMgYXJlIGVuYWJsZWQsIGFu
ZCBpZiBhIGJyaWRnZSBjb250YWlucyBhIGRldmljZQ0KPiA+IHdpdGggZml4ZWQNCj4gPiAoSU9S
RVNPVVJDRV9QQ0lfRklYRUQpIG9yIGltbW92YWJsZSBCQVJzLCB0aGUgY29ycmVzcG9uZGluZyB3
aW5kb3dzDQo+ID4gY2FuJ3QNCj4gDQo+IFdoYXQgaXMgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiBm
aXhlZCAoSU9SRVNPVVJDRV9QQ0lfRklYRUQpIGFuZA0KPiBpbW1vdmFibGUgQkFScz8gIEknbSBo
ZXNpdGFudCB0byBhZGQgYSBuZXcgY29uY2VwdCAoImltbW92YWJsZSIpIHdpdGgNCj4gYSBkaWZm
ZXJlbnQgbmFtZSBidXQgdmVyeSBzaW1pbGFyIG1lYW5pbmcuDQo+IA0KPiBJIHVuZGVyc3RhbmQg
dGhhdCBpbiB0aGUgY2FzZSBvZiBicmlkZ2Ugd2luZG93cywgeW91IG1heSBuZWVkIHRvDQo+IHRy
YWNrDQo+IG9ubHkgcGFydCBvZiB0aGUgd2luZG93LCBhcyBvcHBvc2VkIHRvIGEgQkFSIHdoZXJl
IHRoZSBlbnRpcmUgQkFSIGhhcw0KPiB0byBiZSBlaXRoZXIgZml4ZWQgb3IgbW92YWJsZSwgYnV0
IEkgdGhpbmsgYWRkaW5nIGEgbmV3IHRlcm0gd2lsbCBiZQ0KPiBjb25mdXNpbmcuDQo+IA0KDQpJ
IHRob3VnaHQgdGhlIHRlcm0gImZpeGVkIEJBUiIgaGFzIHNvbWUgbGVnYWN5IHNjZW50LCBhbmQg
dGhvc2UgbWFya2VkDQp3aXRoIGZsYWcgSU9SRVNPVVJDRV9QQ0lfRklYRUQgYXJlIGZpeGVkIGZv
cmV2ZXIuIEJ1dCBhIEJBUiBtYXkgYmVjb21lDQptb3ZhYmxlIGFmdGVyIHJtbW9kLWluZyBpdHMg
ZHJpdmVyIHRoYXQgZGlkbid0IHN1cHBvcnQgbW92YWJsZSBCQVJzLg0KDQpTdGlsbCwgdGhlIElP
UkVTT1VSQ0VfUENJX0ZJWEVEIGlzIHVzZWQganVzdCBhIGZldyB0aW1lcyBpbiB0aGUga2VybmVs
LA0Kc28gdGhlICJmaXhlZCBCQVIiIHRlcm0gaXMgcHJvYmFibHkgbm90IHNvIHdlbGwtZXN0YWJs
aXNoZWQsIHNvIEkgZG9uJ3QNCm1pbmQgcmVmZXJyaW5nIGFsbCBub24tbW92YWJsZXMgYXMgImZp
eGVkIjogYm90aCBtYXJrZWQgd2l0aCB0aGUgZmxhZw0KYW5kIG5vdC4gV2lsbCBjaGFuZ2UgYWxs
IG9mIHRoZW0gaW4gdjguDQoNCj4gPiBiZSBtb3ZlZCB0b28gZmFyIGF3YXkgZnJvbSB0aGVpciBv
cmlnaW5hbCBwb3NpdGlvbnMgLSB0aGV5IG11c3QNCj4gPiBzdGlsbA0KPiA+IGNvbnRhaW4gYWxs
IHRoZSBmaXhlZC9pbW1vdmFibGUgQkFScywgbGlrZSB0aGF0Og0KPiA+IA0KPiA+IDEpIFdpbmRv
dyBwb3NpdGlvbiBiZWZvcmUgYSBidXMgcmVzY2FuOg0KPiA+IA0KPiA+ICAgIHwgPC0tICAgICAg
ICAgICAgICAgICAgICByb290IGJyaWRnZQ0KPiA+IHdpbmRvdyAgICAgICAgICAgICAgICAgICAg
ICAgIC0tPiB8DQo+ID4gICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIA0KPiA+ICAgICAgICB8DQo+ID4gICAgfCB8IDwtLSAg
ICAgYnJpZGdlIHdpbmRvdyAgICAtLT4NCj4gPiB8ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwNCj4gPiAgICB8IHwgbW92YWJsZSBCQVJzIHwgKipmaXhlZCBCQVIqKg0KPiA+
IHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiA+ICAgICAgICBeXl5e
Xl5eXl5eXl4NCj4gPiANCj4gPiAyKSBQb3NzaWJsZSB2YWxpZCBvdXRjb21lIGFmdGVyIHJlc2Nh
biBhbmQgbW92ZToNCj4gPiANCj4gPiAgICB8IDwtLSAgICAgICAgICAgICAgICAgICAgcm9vdCBi
cmlkZ2UNCj4gPiB3aW5kb3cgICAgICAgICAgICAgICAgICAgICAgICAtLT4gfA0KPiA+ICAgIHwg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICANCj4gPiAgICAgICAgfA0KPiA+ICAgIHwgICAgICAgICAgICAgICAgfCA8LS0gICAgIGJy
aWRnZSB3aW5kb3cgICAgLS0+DQo+ID4gfCAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4gICAg
fCAgICAgICAgICAgICAgICB8ICoqZml4ZWQgQkFSKiogfCBNb3ZhYmxlIEJBUnMNCj4gPiB8ICAg
ICAgICAgICAgICAgICAgICAgIHwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF5eXl5eXl5eXl5eXg0KPiA+IA0KPiA+IEFuIGltbW92YWJsZSBhcmVhIG9mIGEgYnJp
ZGdlIHdpbmRvdyBpcyBhIHJhbmdlIHRoYXQgY292ZXJzIGFsbCB0aGUNCj4gPiBmaXhlZA0KPiA+
IGFuZCBpbW1vdmFibGUgQkFScyBvZiBkaXJlY3QgY2hpbGRyZW4sIGFuZCBhbGwgdGhlIGZpeGVk
IGFyZWEgb2YNCj4gPiBjaGlsZHJlbg0KPiA+IGJyaWRnZXM6DQo+ID4gDQo+ID4gICAgfCA8LS0g
ICAgICAgICAgICAgICAgICAgIHJvb3QgYnJpZGdlDQo+ID4gd2luZG93ICAgICAgICAgICAgICAg
ICAgICAgICAgLS0+IHwNCj4gPiAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQo+ID4gICAgICAgIHwNCj4gPiAgICB8ICB8
IDwtLSAgICAgICAgICAgICAgICAgIGJyaWRnZSB3aW5kb3cgbGV2ZWwgMSAgICAgICAgICAgICAg
ICAtDQo+ID4gLT4gfCAgIHwNCj4gPiAgICB8ICB8ICoqKioqKioqKioqKioqKioqKioqIGltbW92
YWJsZSBhcmVhDQo+ID4gKioqKioqKioqKioqKioqKioqKiAgICAgICB8ICAgfA0KPiA+ICAgIHwg
IHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICANCj4gPiAgICB8ICAgfA0KPiA+ICAgIHwgIHwgKipmaXhlZCBCQVIqKiB8IDwtLSAgICAg
IGJyaWRnZSB3aW5kb3cgbGV2ZWwgMiAgICAgLS0+IHwNCj4gPiBCQVJzIHwgICB8DQo+ID4gICAg
fCAgfCAgICAgICAgICAgICAgIHwgKioqKioqKioqKiogaW1tb3ZhYmxlIGFyZWEgKioqKioqKioq
KioNCj4gPiB8ICAgICAgfCAgIHwNCj4gPiAgICB8ICB8ICAgICAgICAgICAgICAgfCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgDQo+ID4gICAgfCAgIHwNCj4gPiAg
ICB8ICB8ICAgICAgICAgICAgICAgfCAqKmZpeGVkIEJBUioqIHwgIEJBUnMgIHwgKipmaXhlZCBC
QVIqKg0KPiA+IHwgICAgICB8ICAgfA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXl5eXg0KPiA+IA0KPiA+IFRvIHN0b3JlIHRoZXNlIGFyZWFzLCB0aGUgLmlt
bW92YWJsZV9yYW5nZSBmaWVsZCBoYXMgYmVlbiBhZGRlZCB0bw0KPiA+IHN0cnVjdA0KPiA+IHBj
aV9idXMgZm9yIGV2ZXJ5IGJyaWRnZSB3aW5kb3cgdHlwZTogSU8sIE1FTSBhbmQgUFJFRkVUQ0gu
IEl0IGlzDQo+ID4gZmlsbGVkDQo+ID4gcmVjdXJzaXZlbHkgZnJvbSBsZWF2ZXMgdG8gdGhlIHJv
b3QgYmVmb3JlIGEgcmVzY2FuLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFNlcmdlaSBNaXJv
c2huaWNoZW5rbyA8cy5taXJvc2huaWNoZW5rb0B5YWRyby5jb20+DQo+ID4gLS0tDQo+ID4gIGRy
aXZlcnMvcGNpL3BjaS5oICAgfCAxNCArKysrKysrKw0KPiA+ICBkcml2ZXJzL3BjaS9wcm9iZS5j
IHwgODgNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gPiAgaW5jbHVkZS9saW51eC9wY2kuaCB8ICA2ICsrKysNCj4gPiAgMyBmaWxlcyBjaGFuZ2Vk
LCAxMDggaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9w
Y2kuaCBiL2RyaXZlcnMvcGNpL3BjaS5oDQo+ID4gaW5kZXggM2I0Yzk4Mjc3MmQzLi41ZjIwNTFj
ODUzMWMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvcGNpLmgNCj4gPiArKysgYi9kcml2
ZXJzL3BjaS9wY2kuaA0KPiA+IEBAIC00MDQsNiArNDA0LDIwIEBAIHN0YXRpYyBpbmxpbmUgYm9v
bA0KPiA+IHBjaV9kZXZfaXNfZGlzY29ubmVjdGVkKGNvbnN0IHN0cnVjdCBwY2lfZGV2ICpkZXYp
DQo+ID4gIAlyZXR1cm4gZGV2LT5lcnJvcl9zdGF0ZSA9PSBwY2lfY2hhbm5lbF9pb19wZXJtX2Zh
aWx1cmU7DQo+ID4gIH0NCj4gPiAgDQo+ID4gK3N0YXRpYyBpbmxpbmUgaW50IHBjaV9nZXRfYnJp
ZGdlX3Jlc291cmNlX2lkeChzdHJ1Y3QgcmVzb3VyY2UgKnIpDQo+ID4gK3sNCj4gPiArCWludCBp
ZHggPSAxOw0KPiA+ICsNCj4gPiArCWlmIChyLT5mbGFncyAmIElPUkVTT1VSQ0VfSU8pDQo+ID4g
KwkJaWR4ID0gMDsNCj4gPiArCWVsc2UgaWYgKCEoci0+ZmxhZ3MgJiBJT1JFU09VUkNFX1BSRUZF
VENIKSkNCj4gPiArCQlpZHggPSAxOw0KPiA+ICsJZWxzZSBpZiAoci0+ZmxhZ3MgJiBJT1JFU09V
UkNFX01FTV82NCkNCj4gPiArCQlpZHggPSAyOw0KPiANCj4gUmFuZG9tIG5pdDogTm8gdmFyaWFi
bGVzIG9yIGVsc2VzIHJlcXVpcmVkOg0KPiANCj4gICBpZiAoci0+ZmxhZ3MgJiBJT1JFU09VUkNF
X0lPKQ0KPiAgICAgcmV0dXJuIDA7DQo+ICAgaWYgKCEoci0+ZmxhZ3MgJiBJT1JFU09VUkNFX1BS
RUZFVENIKSkNCj4gICAgIHJldHVybiAxOw0KPiAgIC4uLg0KPiANCg0KVGhhbmsgeW91IQ0KDQpC
ZXN0IHJlZ2FyZHMsDQpTZXJnZQ0KDQo+ID4gKwlyZXR1cm4gaWR4Ow0KPiA+ICt9DQo=
