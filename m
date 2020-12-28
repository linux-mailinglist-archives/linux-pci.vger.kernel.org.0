Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418B82E62FB
	for <lists+linux-pci@lfdr.de>; Mon, 28 Dec 2020 16:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406850AbgL1PiX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Dec 2020 10:38:23 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:41902 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404211AbgL1PiX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Dec 2020 10:38:23 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 6236B4124F
        for <linux-pci@vger.kernel.org>; Mon, 28 Dec 2020 15:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        mime-version:content-transfer-encoding:content-id:content-type
        :content-type:content-language:accept-language:in-reply-to
        :references:message-id:date:date:subject:subject:from:from
        :received:received:received:received; s=mta-01; t=1609169860; x=
        1610984261; bh=5BYU8eq3Qsm6SdPJzNxNmGJ19cJCIAN5d9ErX+/lSmk=; b=H
        kOuq7gyhohd+e2oK6raZ+pugy0GpvHIqbozPQPdIrOr4tzhSjA7jx3r6byfFUmey
        jepWwxPv78XIsHPILvhXh5JL2FFIUxWxur8tbLNq5/wZadkZujaZcp/B2Irsb2p7
        5qMNpOGB6IiqIRj73WHF58BiNKoYeqLu6mv30TIf+0=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GOiq3tw6y4FA for <linux-pci@vger.kernel.org>;
        Mon, 28 Dec 2020 18:37:40 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 44F804120D
        for <linux-pci@vger.kernel.org>; Mon, 28 Dec 2020 18:37:40 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (172.17.100.103) by
 T-EXCH-04.corp.yadro.com (172.17.100.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Mon, 28 Dec 2020 18:37:39 +0300
Received: from T-EXCH-03.corp.yadro.com ([fe80::39f4:7b05:b1d3:5272]) by
 T-EXCH-03.corp.yadro.com ([fe80::39f4:7b05:b1d3:5272%14]) with mapi id
 15.01.0669.032; Mon, 28 Dec 2020 18:37:40 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v9 01/26] PCI: Fix race condition in
 pci_enable/disable_device()
Thread-Topic: [PATCH v9 01/26] PCI: Fix race condition in
 pci_enable/disable_device()
Thread-Index: AQHW1WT41zzrc5lZN02cCmOPtq7cSqoMgakA
Date:   Mon, 28 Dec 2020 15:37:40 +0000
Message-ID: <d7de0403062984c8a8f19dbd135c33b2dc5fc0a3.camel@yadro.com>
References: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
         <20201218174011.340514-2-s.miroshnichenko@yadro.com>
In-Reply-To: <20201218174011.340514-2-s.miroshnichenko@yadro.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [172.17.15.136]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5264EB613537A54ABA66117AA4196E49@yadro.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGksDQoNClRoZSBrYnVpbGQgdGVzdCByb2JvdCBoYXMgcmVwb3J0ZWQgYSBidWlsZCBlcnJvciBv
biBzb21lIGNvbmZpZ3MsDQpwb2ludGluZyBvdXQgdGhhdCBhbm90aGVyICNpZmRlZiBzaG91bGQg
YmUgdXNlZC4gSSd2ZSBjaGVja2VkLCB0aGUNCkRFQlVHX0xPQ0tfQUxMT0Mgc2VlbXMgdG8gc3Vp
dCBiZXR0ZXIgaGVyZToNCg0KT24gRnJpLCAyMDIwLTEyLTE4IGF0IDIwOjM5ICswMzAwLCBTZXJn
ZWkgTWlyb3NobmljaGVua28gd3JvdGU6DQo+IFRoaXMgaXMgYSB5ZXQgYW5vdGhlciBhcHByb2Fj
aCB0byBmaXggYW4gb2xkIFsxLTJdIGNvbmN1cnJlbmN5IGlzc3VlLA0KPiB3aGVuOg0KPiAgLSB0
d28gb3IgbW9yZSBkZXZpY2VzIGFyZSBiZWluZyBob3QtYWRkZWQgaW50byBhIGJyaWRnZSB3aGlj
aCB3YXMNCj4gICAgaW5pdGlhbGx5IGVtcHR5Ow0KPiAgLSBhIGJyaWRnZSB3aXRoIHR3byBvciBt
b3JlIGRldmljZXMgaXMgYmVpbmcgaG90LWFkZGVkOw0KPiAgLSB0aGUgQklPUy9ib290bG9hZGVy
L2Zpcm13YXJlIGRvZXNuJ3QgcHJlLWVuYWJsZSBicmlkZ2VzIGR1cmluZw0KPiBib290Ow0KPiAN
Cj4gLi4uDQo+ICANCj4gKyNpZmRlZiBDT05GSUdfUFJPVkVfTE9DS0lORw0KDQorI2lmZGVmIENP
TkZJR19ERUJVR19MT0NLX0FMTE9DDQoNCj4gK3N0YXRpYyBpbnQgcGNpX2JyaWRnZV9kZXB0aChz
dHJ1Y3QgcGNpX2RldiAqZGV2KQ0KPiArew0KPiArCXN0cnVjdCBwY2lfZGV2ICpicmlkZ2UgPSBw
Y2lfdXBzdHJlYW1fYnJpZGdlKGRldik7DQo+ICsNCj4gKwlpZiAoIWJyaWRnZSkNCj4gKwkJcmV0
dXJuIDA7DQo+ICsNCj4gKwlyZXR1cm4gMSArIHBjaV9icmlkZ2VfZGVwdGgoYnJpZGdlKTsNCj4g
K30NCj4gKyNlbmRpZiAvKiBDT05GSUdfUFJPVkVfTE9DS0lORyAqLw0KDQorI2VuZGlmIC8qIENP
TkZJR19ERUJVR19MT0NLX0FMTE9DICovDQoNCj4gKw0KPiAgc3RhdGljIHZvaWQgcGNpX2VuYWJs
ZV9icmlkZ2Uoc3RydWN0IHBjaV9kZXYgKmRldikNCj4gIHsNCj4gIAlzdHJ1Y3QgcGNpX2RldiAq
YnJpZGdlOw0KPiAgCWludCByZXR2YWw7DQo+ICANCj4gKwltdXRleF9sb2NrX25lc3RlZCgmZGV2
LT5lbmFibGVfbXV0ZXgsIHBjaV9icmlkZ2VfZGVwdGgoZGV2KSk7DQo+ICsNCj4gIAlicmlkZ2Ug
PSBwY2lfdXBzdHJlYW1fYnJpZGdlKGRldik7DQo+ICAJaWYgKGJyaWRnZSkNCj4gIAkJcGNpX2Vu
YWJsZV9icmlkZ2UoYnJpZGdlKTsNCg0KSXMgdGhlcmUgYSBwcm9wZXIgd2F5IHRvIHNlbmQgYSAi
aG90Zml4IiBmb3IgYSBzaW5nbGUgcGF0Y2ggb2YgdGhlDQpzZXJpZXMgb2YgMjYsIHdpdGhvdXQg
cmVzZW5kaW5nIHRoZW0gYWxsPw0KDQpCZXN0IHJlZ2FyZHMsDQpTZXJnZQ0K
