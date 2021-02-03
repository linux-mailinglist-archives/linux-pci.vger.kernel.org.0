Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E77030E3B8
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 21:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhBCUBv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 15:01:51 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:49878 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231449AbhBCUBu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Feb 2021 15:01:50 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 49DFA4127E;
        Wed,  3 Feb 2021 20:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        mime-version:content-transfer-encoding:content-id:content-type
        :content-type:content-language:accept-language:in-reply-to
        :references:message-id:date:date:subject:subject:from:from
        :received:received:received:received; s=mta-01; t=1612382467; x=
        1614196868; bh=8+iRDLeyi9HqnpHodQHNdbKBA+Dfq2jXTWY0Pl/UyQ8=; b=o
        G48KhzqRqWA6mTTfOiLVwjwcfRFFlUaDLFu3dpl5Szrtx0V0tuXgzuaKMp2cdvp6
        6qv4ScCBMBgN8g0a2veZeAL0XjlSgJVXESG2mqi7Gi6AUo7znzKEgQaULPds0PpJ
        oFSNb4iXFhtP3MapVRNuAUbEBq+JXWsozu6rXyLOpc=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CTgvsH1L_TgZ; Wed,  3 Feb 2021 23:01:07 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id D63C14120D;
        Wed,  3 Feb 2021 23:01:05 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (172.17.100.103) by
 T-EXCH-04.corp.yadro.com (172.17.100.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Wed, 3 Feb 2021 23:01:05 +0300
Received: from T-EXCH-03.corp.yadro.com ([fe80::39f4:7b05:b1d3:5272]) by
 T-EXCH-03.corp.yadro.com ([fe80::39f4:7b05:b1d3:5272%14]) with mapi id
 15.01.0669.032; Wed, 3 Feb 2021 23:01:05 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     "lukas@wunner.de" <lukas@wunner.de>,
        "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
        "christian@kellner.me" <christian@kellner.me>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "rajatja@google.com" <rajatja@google.com>,
        "andy.lavr@gmail.com" <andy.lavr@gmail.com>,
        "linux@yadro.com" <linux@yadro.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "sr@denx.de" <sr@denx.de>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "mario.limonciello@dell.com" <mario.limonciello@dell.com>
Subject: Re: [PATCH v9 00/26] PCI: Allow BAR movement during boot and hotplug
Thread-Topic: [PATCH v9 00/26] PCI: Allow BAR movement during boot and hotplug
Thread-Index: AQHW1WT234xzlvvTV0WAimI1cHAduao9LYkAgABgu4CACWNCAA==
Date:   Wed, 3 Feb 2021 20:01:05 +0000
Message-ID: <6844b9c79e784c17ff007cab187abb85e5d91608.camel@yadro.com>
References: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
         <20210128145316.GA3052488@bjorn-Precision-5520>
         <20210128203929.GB6613@wunner.de>
In-Reply-To: <20210128203929.GB6613@wunner.de>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [172.17.15.136]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E5986BC8F6B8648B2F0D31D4D21F987@yadro.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIxLTAxLTI4IGF0IDIxOjM5ICswMTAwLCBMdWthcyBXdW5uZXIgd3JvdGU6DQo+
IFdpdGggVGh1bmRlcmJvbHQsIHRoaXMgc2VyaWVzIGlzIHBhcnRpY3VsYXJseSB1c2VmdWwgaWYN
Cj4gKGEpIFBDSWUgY2FyZHMgYXJlIGhvdC1hZGRlZCB3aXRoIGxhcmdlIEJBUnMgKHN1Y2ggYXMg
R1BVcykgYW5kL29yDQo+IChiKSB0aGUgVGh1bmRlcmJvbHQgZGFpc3ktY2hhaW4gaXMgdmVyeSBs
b25nLg0KPiANCj4gVGh1bmRlcmJvbHQgaXMgZXNzZW50aWFsbHkgYSBjYXNjYWRlIG9mIG5lc3Rl
ZCBob3RwbHVnIHBvcnRzLA0KPiBzbyBpZiBtb3JlIGFuZCBtb3JlIGRldmljZXMgYXJlIGFkZGVk
LCBpdCdzIGVhc3kgdG8gc2VlIHRoYXQNCj4gdGhlIHRvcC1sZXZlbCBob3RwbHVnIHBvcnQncyBC
QVIgd2luZG93IG1heSBydW4gb3V0IG9mIHNwYWNlLg0KPiANCj4gTXkgdW5kZXJzdGFuZGluZyBp
cyB0aGF0IFNlcmdlaSdzIHVzZSBjYXNlIGRvZXNuJ3QgaW52b2x2ZQ0KPiBUaHVuZGVyYm9sdCBh
dCBhbGwgYnV0IHJhdGhlciBob3RwbHVnZ2luZyBvZiBHUFVzIGFuZCBuZXR3b3JrDQo+IGNhcmRz
IGluIFBvd2VyUEMgc2VydmVycyBpbiBhIGRhdGFjZW50ZXIsIHdoaWNoIG1heSBoYXZlIHRoZQ0K
PiBzYW1lIGtpbmRzIG9mIGlzc3Vlcy4NCg0KSGkgTHVrYXMsDQoNCkkgaGF2ZSB5ZXQgdG8gZmlu
ZCBzb21lIFRodW5kZXJib2x0IGhhcmR3YXJlIGFuZCB0cnkgaXQuDQoNCkFjdHVhbGx5LCB3ZSBh
cmUgaG90cGx1Z2dpbmcgbm90IG9ubHkgZW5kcG9pbnRzLCBidXQgbmVzdGVkIFBDSWUNCnN3aXRj
aGVzIGFzIHdlbGw6IHRob3NlIGFyZSBQQ0llIEpCT0QgY2hhc3NpcyAod2l0aCBOVk1lcyBhbmQg
U0FTDQpkcml2ZXMpLg0KDQpCdXQgdG8gZGVhbCB3aXRoIHRoZW0gd2UgaGF2ZSB0byB1c2UgYW4g
YWRkaXRpb25hbCBwYXRjaHNldCAiTW92YWJsZQ0KYnVzIG51bWJlcnMiLCB0aGF0IHdhcyBhbHNv
IGRlc2NyaWJlZCBkdXJpbmcgTFBDMjAyMCAoaW5jbHVkaW5nIGl0cw0KcHJvYmxlbWF0aWMgcG9p
bnRzKSwgaGVyZSBpcyBpdHMgUkZDLCBpdCBoYXZlbid0IGNoYW5nZWQgbXVjaCBzaW5jZQ0KdGhl
bjoNCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcGNpLzIwMTkxMDI0MTcyMTU3Ljg3
ODczNS01LXMubWlyb3NobmljaGVua29AeWFkcm8uY29tL1QvDQoNCkNhbiBUaHVuZGVyYm9sdCBo
YXZlIGEgY2hhaW4gb2Ygc3dpdGNoZXMgZGVlcCBlbm91Z2ggdG8gaGF2ZSBwcm9ibGVtcw0Kd2l0
aCBidXMgbnVtYmVycywgd2hlbiByZXNlcnZpbmcgaXMgbm90IHRoZSBiZXN0IG9wdGlvbj8NCg0K
U2VyZ2UNCg0KPiBJIGludGVuZGVkIHRvIHJldmlldyBhbmQgdGVzdCB0aGlzIGl0ZXJhdGlvbiBv
ZiB0aGUgc2VyaWVzIG1vcmUNCj4gY2xvc2VseSwgYnV0IGhhdmVuJ3QgYmVlbiBhYmxlIHRvIGNh
cnZlIG91dCB0aGUgcmVxdWlyZWQgdGltZS4NCj4gSSdtIGFkZGluZyBzb21lIFRodW5kZXJib2x0
IGZvbGtzIHRvIGNjIGluIHRoZSBob3BlIHRoYXQgdGhleQ0KPiBjYW4gYXQgbGVhc3QgdGVzdCB0
aGUgc2VyaWVzIG9uIHRoZWlyIGRldmVsb3BtZW50IGJyYW5jaC4NCj4gR2V0dGluZyB0aGlzIHVw
c3RyZWFtZWQgc2hvdWxkIHJlYWxseSBiZSBpbiB0aGUgYmVzdCBpbnRlcmVzdA0KPiBvZiBJbnRl
bCBhbmQgb3RoZXIgcHJvbXVsZ2F0b3JzIG9mIFRodW5kZXJib2x0Lg0KPiANCj4gVGhhbmtzLA0K
PiANCj4gTHVrYXMNCg==
