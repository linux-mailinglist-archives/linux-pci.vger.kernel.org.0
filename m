Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411994CD3FA
	for <lists+linux-pci@lfdr.de>; Fri,  4 Mar 2022 13:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbiCDMHB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Mar 2022 07:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbiCDMHB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Mar 2022 07:07:01 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C9E1B309F;
        Fri,  4 Mar 2022 04:06:13 -0800 (PST)
Received: from kwepemi100010.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4K96166pp3z9sjD;
        Fri,  4 Mar 2022 20:02:34 +0800 (CST)
Received: from kwepeml100006.china.huawei.com (7.221.188.192) by
 kwepemi100010.china.huawei.com (7.221.188.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 20:06:10 +0800
Received: from kwepeml500003.china.huawei.com (7.221.188.182) by
 kwepeml100006.china.huawei.com (7.221.188.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 20:06:10 +0800
Received: from kwepeml500003.china.huawei.com ([7.221.188.182]) by
 kwepeml500003.china.huawei.com ([7.221.188.182]) with mapi id 15.01.2308.021;
 Fri, 4 Mar 2022 20:06:10 +0800
From:   "Zhangjiantao(Kirin,Nanjing)" <water.zhangjiantao@huawei.com>
To:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Caiyadong <caiyadong@huawei.com>,
        guhengsheng <guhengsheng@hisilicon.com>,
        "zhangjianrong (E)" <zhangjianrong5@huawei.com>
Subject: [PATCH] PCI: dwc: solve returning success but actually failed
Thread-Topic: [PATCH] PCI: dwc: solve returning success but actually failed
Thread-Index: AdgvwBRDx2FzmehYQAqHeO4j8ZwdwQ==
Date:   Fri, 4 Mar 2022 12:06:10 +0000
Message-ID: <6d26f16646294836b87611f4dc5fe763@huawei.com>
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

V2hlbiBkbWFfbWFwcGluZ19lcnJvciByZXR1cm5zIGVycm9yIGJlY2F1c2Ugb2Ygbm8gZW5vdWdo
IG1lbW9yeSBhdmFpbGFibGUsIGR3X3BjaWVfaG9zdF9pbml0IHdpbGwgcmV0dXJuIHN1Y2Nlc3Ms
IHdoaWNoIHdpbGwgbWlzbGVhZCB0aGUgY2FsbGVycy4NCg0KU2lnbmVkLW9mZi1ieTogemhhbmdq
aWFucm9uZyA8emhhbmdqaWFucm9uZzVAaHVhd2VpLmNvbT4NClNpZ25lZC1vZmYtYnk6IHpoYW5n
amlhbnRhbyA8d2F0ZXIuemhhbmdqaWFudGFvQGh1YXdlaS5jb20+DQoNCi0tLQ0KIMKgZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYyB8IDEgKw0KIMKgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQpiL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCmluZGV4IGY0NzU1ZjNhMDNiZS4uYWM2
OTFkNzMzODQ4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1k
ZXNpZ253YXJlLWhvc3QuYw0KKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1k
ZXNpZ253YXJlLWhvc3QuYw0KQEAgLTM5Myw2ICszOTMsNyBAQCBpbnQgZHdfcGNpZV9ob3N0X2lu
aXQoc3RydWN0IHBjaWVfcG9ydCAqcHApDQogwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCBpZiAoZG1h
X21hcHBpbmdfZXJyb3IocGNpLT5kZXYsIHBwLT5tc2lfZGF0YSkpIHsNCiDCoMKgwqDCoCDCoMKg
wqAgwqDCoMKgIMKgwqDCoCBkZXZfZXJyKHBjaS0+ZGV2LCAiRmFpbGVkIHRvIG1hcCBNU0kgZGF0
YVxuIik7DQogwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgcHAtPm1zaV9kYXRhID0gMDsN
CivCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgcmV0ID0gLTE7DQogwqDCoMKgwqAgwqDCoMKg
IMKgwqDCoCDCoMKgwqAgZ290byBlcnJfZnJlZV9tc2k7DQogwqDCoMKgwqAgwqDCoMKgIMKgwqDC
oCB9DQogwqDCoMKgwqAgwqDCoMKgIH0NCi0tDQoyLjE3LjENCg0K
