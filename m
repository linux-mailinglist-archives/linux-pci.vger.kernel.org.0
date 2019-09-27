Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD48DC0940
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2019 18:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfI0QMb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Sep 2019 12:12:31 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38347 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfI0QMb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Sep 2019 12:12:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id x10so3759449pgi.5;
        Fri, 27 Sep 2019 09:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=BkVG3iqmCYH0eeVp/xh+5XrL/M0KG001eUUCkmNI95A=;
        b=e/COpqTQALXS/QFYGHR1MkEudE13Jo0gu/GoimIqBLcFoQENfvDpbpnGH6rkcPSnRK
         X+0JmFgBGbYt/klH5Zl5tYgSwttlfa07Ae5vQeQOhJ93uslS/kApiYjBJFw9PcZp45QL
         oZsO4N4MwNcWs36Od/VGYu8ZoPZnEE6ceVxX5aYe9U2pDDKNoakb+nlQ+Mf/K+GabJcK
         0H7H9VIYfKPbP2iwwpMCCeHhBVTBYK1aSjwW9QTk7RBopSXucwgbbrSwUGGPKjN36ZeJ
         wAfdO4ExHw2qwAzUOC4diHPm7MvNIXFw0EmQRzt/tu9/PTAXiQEPE0DEhY1bVi8rrLkN
         78oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=BkVG3iqmCYH0eeVp/xh+5XrL/M0KG001eUUCkmNI95A=;
        b=ZaFAqOEXz/PNv9kYeEzDnGYk5MxUXwZDVug9S9li9MS57R87t4jOEHLoU4TWqw1g6J
         Gxwq0m3ilQDnh/rKQ3uC/KKsPgtEGSaCE2X1+VG8wcT4qJmhA2ggghmlcBLBlFo6Ppmz
         6XwBTqMMTG0/HtKrQC5J41VkWhI5Nbtriz+1/wOJEJmtjCuv/D81i7mweHdPNDE1SK/E
         XW1d8+AD2UbvmfY8v1c3Mu43Za276suMECCH43R/v0MaJc8Q7welUh6Zqf044lwpMBiA
         cor53JZA04uShAhSuDdSjGaP2r6ph4i0z39qTGtdiXoY34+WxNGCVDvDx9xJJ/UgAWqS
         w8Ow==
X-Gm-Message-State: APjAAAULbpPzUfUMQCk5BJ7S/FNoejL3+4+DCeIwh8382q0pKKEiSn7C
        5EP3pXnpyVweuFa0quymth0=
X-Google-Smtp-Source: APXvYqzkAgoVkc6rj9y4WlIo7pSMPSSyceNGsbwh/2NjqKHcUSmCCNwo+nge9m/SUn9OJleP/CpFLQ==
X-Received: by 2002:a65:4002:: with SMTP id f2mr10165853pgp.447.1569600749847;
        Fri, 27 Sep 2019 09:12:29 -0700 (PDT)
Received: from SL2P216MB0105.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:22::5])
        by smtp.gmail.com with ESMTPSA id 64sm3894470pfx.31.2019.09.27.09.12.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2019 09:12:28 -0700 (PDT)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Ley Foon Tan <lftan@altera.com>,
        Tom Joseph <tjoseph@cadence.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Simon Horman <horms@verge.net.au>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Michal Simek <michal.simek@xilinx.com>,
        "rfi@lists.rocketboards.org" <rfi@lists.rocketboards.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH 06/11] PCI: of: Add inbound resource parsing to helpers
Thread-Topic: [PATCH 06/11] PCI: of: Add inbound resource parsing to helpers
Thread-Index: AQHVcyGPS+dm5x72Oke0UZO8SHhXHqc/tmMt
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Fri, 27 Sep 2019 16:12:20 +0000
Message-ID: <SL2P216MB0105248CAB7433BEB727E94CAA810@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
References: <20190924214630.12817-1-robh@kernel.org>
 <20190924214630.12817-7-robh@kernel.org>
In-Reply-To: <20190924214630.12817-7-robh@kernel.org>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCu+7vz4gT24gOS8yNC8xOSwgNTo0NiBQTSwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+DQo+IEV4
dGVuZCBkZXZtX29mX3BjaV9nZXRfaG9zdF9icmlkZ2VfcmVzb3VyY2VzKCkgYW5kDQo+IHBjaV9w
YXJzZV9yZXF1ZXN0X29mX3BjaV9yYW5nZXMoKSBoZWxwZXJzIHRvIGFsc28gcGFyc2UgdGhlIGlu
Ym91bmQNCj4gYWRkcmVzc2VzIGZyb20gRFQgJ2RtYS1yYW5nZXMnIGFuZCBwb3B1bGF0ZSBhIHJl
c291cmNlIGxpc3Qgd2l0aCB0aGUNCj4gdHJhbnNsYXRlZCBhZGRyZXNzZXMuIFRoaXMgd2lsbCBo
ZWxwIGVuc3VyZSAnZG1hLXJhbmdlcycgaXMgYWx3YXlzDQo+IHBhcnNlZCBpbiBhIGNvbnNpc3Rl
bnQgd2F5Lg0KPg0KPiBDYzogSmluZ29vIEhhbiA8amluZ29vaGFuMUBnbWFpbC5jb20+DQoNCkZv
ciAvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYywNCg0K
QWNrZWQtYnk6IEppbmdvbyBIYW4gPGppbmdvb2hhbjFAZ21haWwuY29tPg0KDQpCZXN0IHJlZ2Fy
ZHMsDQpKaW5nb28gSGFuDQoNCj4gQ2M6IEd1c3Rhdm8gUGltZW50ZWwgPGd1c3Rhdm8ucGltZW50
ZWxAc3lub3BzeXMuY29tPg0KPiBDYzogTG9yZW56byBQaWVyYWxpc2kgPGxvcmVuem8ucGllcmFs
aXNpQGFybS5jb20+DQo+IENjOiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPg0K
PiBDYzogVGhvbWFzIFBldGF6em9uaSA8dGhvbWFzLnBldGF6em9uaUBib290bGluLmNvbT4NCj4g
Q2M6IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+DQo+IENjOiBMaW51cyBXYWxsZWlqIDxs
aW51cy53YWxsZWlqQGxpbmFyby5vcmc+DQo+IENjOiBUb2FuIExlIDx0b2FuQG9zLmFtcGVyZWNv
bXB1dGluZy5jb20+DQo+IENjOiBMZXkgRm9vbiBUYW4gPGxmdGFuQGFsdGVyYS5jb20+DQo+IENj
OiBUb20gSm9zZXBoIDx0am9zZXBoQGNhZGVuY2UuY29tPg0KPiBDYzogUmF5IEp1aSA8cmp1aUBi
cm9hZGNvbS5jb20+DQo+IENjOiBTY290dCBCcmFuZGVuIDxzYnJhbmRlbkBicm9hZGNvbS5jb20+
DQo+IENjOiBiY20ta2VybmVsLWZlZWRiYWNrLWxpc3RAYnJvYWRjb20uY29tDQo+IENjOiBSeWRl
ciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQo+IENjOiBLYXJ0aGlrZXlhbiBNaXRyYW4g
PG0ua2FydGhpa2V5YW5AbW9iaXZlaWwuY28uaW4+DQo+IENjOiBIb3UgWmhpcWlhbmcgPFpoaXFp
YW5nLkhvdUBueHAuY29tPg0KPiBDYzogU2ltb24gSG9ybWFuIDxob3Jtc0B2ZXJnZS5uZXQuYXU+
DQo+IENjOiBTaGF3biBMaW4gPHNoYXduLmxpbkByb2NrLWNoaXBzLmNvbT4NCj4gQ2M6IEhlaWtv
IFN0dWVibmVyIDxoZWlrb0BzbnRlY2guZGU+DQo+IENjOiBNaWNoYWwgU2ltZWsgPG1pY2hhbC5z
aW1la0B4aWxpbnguY29tPg0KPiBDYzogcmZpQGxpc3RzLnJvY2tldGJvYXJkcy5vcmcNCj4gQ2M6
IGxpbnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gQ2M6IGxpbnV4LXJlbmVzYXMt
c29jQHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGludXgtcm9ja2NoaXBAbGlzdHMuaW5mcmFkZWFk
Lm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiAt
LS0NCj4gIC4uLi9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYyB8ICAz
ICstDQoNCi4uLi4NCg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS1kZXNpZ253YXJlLWhvc3QuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUt
ZGVzaWdud2FyZS1ob3N0LmMNCj4gaW5kZXggZjkzMjUyZDBkYTViLi4wNzQzYWU2NGJiMGYgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1o
b3N0LmMNCj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJl
LWhvc3QuYw0KPiBAQCAtMzQyLDcgKzM0Miw4IEBAIGludCBkd19wY2llX2hvc3RfaW5pdChzdHJ1
Y3QgcGNpZV9wb3J0ICpwcCkNCj4gIAkJcmV0dXJuIC1FTk9NRU07DQo+ICANCj4gIAlyZXQgPSBk
ZXZtX29mX3BjaV9nZXRfaG9zdF9icmlkZ2VfcmVzb3VyY2VzKGRldiwgMCwgMHhmZiwNCj4gLQkJ
CQkJJmJyaWRnZS0+d2luZG93cywgJnBwLT5pb19iYXNlKTsNCj4gKwkJCQkJJmJyaWRnZS0+d2lu
ZG93cywgJmJyaWRnZS0+ZG1hX3JhbmdlcywNCj4gKwkJCQkJJnBwLT5pb19iYXNlKTsNCj4gIAlp
ZiAocmV0KQ0KPiAgCQlyZXR1cm4gcmV0Ow0KIA0KLi4uLg0K
