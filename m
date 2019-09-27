Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9611C0943
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2019 18:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfI0QMq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Sep 2019 12:12:46 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43255 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfI0QMq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Sep 2019 12:12:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id a2so1856687pfo.10;
        Fri, 27 Sep 2019 09:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=BkVG3iqmCYH0eeVp/xh+5XrL/M0KG001eUUCkmNI95A=;
        b=Mn2aTSFJcLMbdJ0EDU05EbRCklKYGTviE75JGUm7L85MaO4x0BluxsXTdrT7r/1c5g
         ef7FdH+DK4gBrLK9SP6Ssa3T9eS8g0cnggV2vycqPfoRr4TKzvQ40IcQ0AojCMYKfpni
         UbChhtTqXyzLcsFEF3NUmE0OxKsqw7YDx5RW7fFY5g0Dr2MwIxKwQuAPSh90Hco9QIKL
         /DHVEfFAONO+74Yfae6ckNUID+VmFipdI7Ia2jow0nxIQqbAe3zEq7wiZe2woLlHWHrw
         Xv/8S8YMFuP1l+czE/Byy1e/KRZgB9s6bBPYYWDmzIKpheVtFDMSvnOS4XDOSTXWX0WJ
         gPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=BkVG3iqmCYH0eeVp/xh+5XrL/M0KG001eUUCkmNI95A=;
        b=Tg6Fko16re/xgEzP/RA29zrJ/q9RbZVmY0kBYclOQlR9Shl8ZbtZ8OKzRFDS0VZV3z
         yAfeLtcRpt1hCDN3lzirVwWoxNuCi0C4u7WQUR21LFhgatr73pvX3bTnfTdvQ/WvTERh
         XJrkNqFp8yZ9MxI6pCtutLhXZBwzdayKzbdJx0hUoFYZK/SjMSxwMb5zgvDSxdPku0Z6
         ZH9vEadtD3jW5k66DzgraN4+/elx+HsPPUmlePiFgiBGzNfyXqDNGcoN4+jtEBjK23uK
         LvoxR70hcOd3u5przggstUzCeZbbD2N3lkMu4/56QWVADpC8DhKx8nTCoW/yIj/TnqHV
         21pA==
X-Gm-Message-State: APjAAAWGeJsc9EMjq8Z6km9yIRzlTrnHfP7+t4j8aanpLWlyzMsEYEnu
        EswV5rOI2klymBhPGbeEnu4=
X-Google-Smtp-Source: APXvYqxitbAP3PcPa0X7X2zX+V7jMSsAuljIqXk3oFFlbn7LYzvFIn3W4VY61E9Z7VlJ3Yul0lMOQg==
X-Received: by 2002:a17:90a:e28a:: with SMTP id d10mr9357077pjz.102.1569600764256;
        Fri, 27 Sep 2019 09:12:44 -0700 (PDT)
Received: from SL2P216MB0105.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:22::5])
        by smtp.gmail.com with ESMTPSA id l12sm7805593pgs.44.2019.09.27.09.12.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2019 09:12:43 -0700 (PDT)
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
Thread-Index: AQHVcyGPS+dm5x72Oke0UZO8SHhXHqc/tnKx
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Fri, 27 Sep 2019 16:12:27 +0000
Message-ID: <SL2P216MB0105EF7D414AE054835D25C9AA810@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
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
