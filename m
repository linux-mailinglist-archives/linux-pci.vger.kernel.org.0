Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23FB30E3F5
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 21:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhBCUR7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 15:17:59 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:50390 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231519AbhBCUR6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Feb 2021 15:17:58 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 4054141253;
        Wed,  3 Feb 2021 20:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        mime-version:content-transfer-encoding:content-id:content-type
        :content-type:content-language:accept-language:in-reply-to
        :references:message-id:date:date:subject:subject:from:from
        :received:received:received:received; s=mta-01; t=1612383436; x=
        1614197837; bh=oWfScWNnf5qYPrqLNVkhA1AtrI83+e+5/j7wnrmszHo=; b=a
        V+5uGTyIpvG8tM7kNlp1RB/eernRibfHN8WRv10hpk7hkzeeR4fVYmM3bkjMocAt
        SKHIENtQTM4nbEkjsxA18KzsLouAoNdTDUmNi7G2hGki7BYcuiAhUzcZpJwVP9pb
        XJ0h1LO6R431GIYos/4wvTFlVf/KeEtW82AduLD6Xk=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LcU0K_7rMQr0; Wed,  3 Feb 2021 23:17:16 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 2BA30411FD;
        Wed,  3 Feb 2021 23:17:15 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (172.17.100.103) by
 T-EXCH-04.corp.yadro.com (172.17.100.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Wed, 3 Feb 2021 23:17:14 +0300
Received: from T-EXCH-03.corp.yadro.com ([fe80::39f4:7b05:b1d3:5272]) by
 T-EXCH-03.corp.yadro.com ([fe80::39f4:7b05:b1d3:5272%14]) with mapi id
 15.01.0669.032; Wed, 3 Feb 2021 23:17:14 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "lukas@wunner.de" <lukas@wunner.de>
CC:     "David.Laight@aculab.com" <David.Laight@aculab.com>,
        "christian@kellner.me" <christian@kellner.me>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "rajatja@google.com" <rajatja@google.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "mario.limonciello@dell.com" <mario.limonciello@dell.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux@yadro.com" <linux@yadro.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "sr@denx.de" <sr@denx.de>,
        "andy.lavr@gmail.com" <andy.lavr@gmail.com>
Subject: Re: [PATCH v9 00/26] PCI: Allow BAR movement during boot and hotplug
Thread-Topic: [PATCH v9 00/26] PCI: Allow BAR movement during boot and hotplug
Thread-Index: AQHW1WT234xzlvvTV0WAimI1cHAduao9LYkAgABgu4CABcepgIADoByA
Date:   Wed, 3 Feb 2021 20:17:14 +0000
Message-ID: <44ce19d112b97930b1a154740c2e15f3f2d10818.camel@yadro.com>
References: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
         <20210128145316.GA3052488@bjorn-Precision-5520>
         <20210128203929.GB6613@wunner.de>
         <20210201125523.GN2542@lahna.fi.intel.com>
In-Reply-To: <20210201125523.GN2542@lahna.fi.intel.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [172.17.15.136]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DEF1B31DFFF604C9826A096F016841E@yadro.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTWlrYSwNCg0KT24gTW9uLCAyMDIxLTAyLTAxIGF0IDE0OjU1ICswMjAwLCBNaWthIFdlc3Rl
cmJlcmcgd3JvdGU6DQo+IE9uIFRodSwgSmFuIDI4LCAyMDIxIGF0IDA5OjM5OjI5UE0gKzAxMDAs
IEx1a2FzIFd1bm5lciB3cm90ZToNCj4gPiBPbiBUaHUsIEphbiAyOCwgMjAyMSBhdCAwODo1Mzox
NkFNIC0wNjAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0KPiA+ID4gT24gRnJpLCBEZWMgMTgsIDIw
MjAgYXQgMDg6Mzk6NDVQTSArMDMwMCwgU2VyZ2VpIE1pcm9zaG5pY2hlbmtvDQo+ID4gPiB3cm90
ZToNCj4gPiA+ID4gLi4uDQo+ID4gDQo+ID4gSSBpbnRlbmRlZCB0byByZXZpZXcgYW5kIHRlc3Qg
dGhpcyBpdGVyYXRpb24gb2YgdGhlIHNlcmllcyBtb3JlDQo+ID4gY2xvc2VseSwgYnV0IGhhdmVu
J3QgYmVlbiBhYmxlIHRvIGNhcnZlIG91dCB0aGUgcmVxdWlyZWQgdGltZS4NCj4gPiBJJ20gYWRk
aW5nIHNvbWUgVGh1bmRlcmJvbHQgZm9sa3MgdG8gY2MgaW4gdGhlIGhvcGUgdGhhdCB0aGV5DQo+
ID4gY2FuIGF0IGxlYXN0IHRlc3QgdGhlIHNlcmllcyBvbiB0aGVpciBkZXZlbG9wbWVudCBicmFu
Y2guDQo+ID4gR2V0dGluZyB0aGlzIHVwc3RyZWFtZWQgc2hvdWxkIHJlYWxseSBiZSBpbiB0aGUg
YmVzdCBpbnRlcmVzdA0KPiA+IG9mIEludGVsIGFuZCBvdGhlciBwcm9tdWxnYXRvcnMgb2YgVGh1
bmRlcmJvbHQuDQo+IA0KPiBTdXJlLiBJdCBzZWVtcyB0aGF0IHRoaXMgc2VyaWVzIHdhcyBzdWJt
aXR0ZWQgaW4gRGVjZW1iZXIgc28gcHJvYmFibHkNCj4gbm90IGFwcGxpY2FibGUgdG8gdGhlIHBj
aS5naXQvbmV4dCBhbnltb3JlLiBBbnl3YXlzLCBJIGNhbiBnaXZlIGl0IGENCj4gdHJ5DQo+IG9u
IGEgVEJUIGNhcGFibGUgc3lzdGVtIGlmIHNvbWVvbmUgdGVsbHMgbWUgd2hhdCBleGFjdGx5IHRv
IHRlc3QgOy0pDQo+IFByb2JhYmx5IGF0IGxlYXN0IHRoYXQgdGhlIGV4aXN0aW5nIGZ1bmN0aW9u
YWxpdHkgc3RpbGwgd29ya3MgYnV0DQo+IHNvbWV0aGluZyBlbHNlIG1heWJlIHRvbz8NCg0KRm9y
IHNldHVwcyB0aGF0IHdvcmtlZCBmaW5lLCB0aGUgb25seSBleHBlY3RlZCBjaGFuZ2UgaXMgYSBw
b3NzaWJsZQ0KbGl0dGxlIGRpZmZlcmVudCBCQVIgbGF5b3V0IChpbiAvcHJvYy9pb21lbSksIGFu
ZCB0aGVyZSBzaG91bGQgdGhlIHNhbWUNCnF1YW50aXR5IChvciBtb3JlKSBvZiBCQVJzIGFzc2ln
bmVkIHRoYW4gYmVmb3JlLg0KDQpCdXQgaWYgdGhlcmUgYXJlIGFueSBwcm9ibGVtYXRpYyBzZXR1
cHMsIHdoaWNoIHdlcmVuJ3QgYWJsZSB0byBhcnJhbmdlDQpuZXcgQkFScywgdGhpcyBwYXRjaHNl
dCBtYXkgcHVzaCBhIGJpdCBmdXJ0aGVyLg0KDQpJbiBhIGZldyBkYXlzIEknbGwgcHJvdmlkZSBh
biB1cGRhdGVkIGJyYW5jaCBmb3Igb3VyIG1pcnJvciBvZiB0aGUNCmtlcm5lbCBvbiBHaXRodWIs
IHdpdGggYSBjb21wbGV0ZSBhbmQgYnVtcGVkIHNldCBvZiBwYXRjaGVzLCByZWR1Y2luZw0KdGhl
IHN0ZXBzIHJlcXVpcmVkIHRvIHRlc3QgdGhlbS4NCg0KVGhhbmtzIQ0KDQpTZXJnZQ0K
