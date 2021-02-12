Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D4B31A642
	for <lists+linux-pci@lfdr.de>; Fri, 12 Feb 2021 21:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhBLUzJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Feb 2021 15:55:09 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:55698 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230477AbhBLUzJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Feb 2021 15:55:09 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id CBABB4128A;
        Fri, 12 Feb 2021 20:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        mime-version:content-transfer-encoding:content-id:content-type
        :content-type:content-language:accept-language:in-reply-to
        :references:message-id:date:date:subject:subject:from:from
        :received:received:received:received; s=mta-01; t=1613163261; x=
        1614977662; bh=A2h9ZfSLg88FgPBOkhRhm2SzRshmIAsl4uBa6F19fkw=; b=T
        vgtW0SvMIw5wD8P+SLfwMd2WO6Lydi7+EZWp8+4amY0pLjxto02HLQZ63ilXTgeI
        I7pR6BUurC/ldcN3TQbtrcJ06jUWLTS58l6IODjNg91qKkYwDuiz4cLuTblIq5ZH
        /2bA+xEKrbvsUcFteM7oMw8mHH+CKaJKdhatTW1Xh0=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QesUdhETJ-KO; Fri, 12 Feb 2021 23:54:21 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 8423B4126D;
        Fri, 12 Feb 2021 23:54:19 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (172.17.100.103) by
 T-EXCH-04.corp.yadro.com (172.17.100.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Fri, 12 Feb 2021 23:54:18 +0300
Received: from T-EXCH-03.corp.yadro.com ([fe80::39f4:7b05:b1d3:5272]) by
 T-EXCH-03.corp.yadro.com ([fe80::39f4:7b05:b1d3:5272%14]) with mapi id
 15.01.0669.032; Fri, 12 Feb 2021 23:54:19 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
CC:     "David.Laight@aculab.com" <David.Laight@aculab.com>,
        "christian@kellner.me" <christian@kellner.me>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "rajatja@google.com" <rajatja@google.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "mario.limonciello@dell.com" <mario.limonciello@dell.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux@yadro.com" <linux@yadro.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "sr@denx.de" <sr@denx.de>, "lukas@wunner.de" <lukas@wunner.de>,
        "andy.lavr@gmail.com" <andy.lavr@gmail.com>
Subject: Re: [PATCH v9 00/26] PCI: Allow BAR movement during boot and hotplug
Thread-Topic: [PATCH v9 00/26] PCI: Allow BAR movement during boot and hotplug
Thread-Index: AQHW1WT234xzlvvTV0WAimI1cHAduao9LYkAgABgu4CABcepgIADoByAgADzoQCACgJRgIABDByAgABmKICAAUCIgIAAhpoA
Date:   Fri, 12 Feb 2021 20:54:18 +0000
Message-ID: <460947ac479281677cdc42e69fc60dccd19dfe94.camel@yadro.com>
References: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
         <20210128145316.GA3052488@bjorn-Precision-5520>
         <20210128203929.GB6613@wunner.de>
         <20210201125523.GN2542@lahna.fi.intel.com>
         <44ce19d112b97930b1a154740c2e15f3f2d10818.camel@yadro.com>
         <20210204104912.GE2542@lahna.fi.intel.com>
         <afc5d363476d445cfdf04b0ec4db9275db803af3.camel@yadro.com>
         <20210211113941.GF2542@lahna.fi.intel.com>
         <52dd963fc697059d3db39c25eda222f4b7197761.camel@yadro.com>
         <20210212125233.GS2542@lahna.fi.intel.com>
In-Reply-To: <20210212125233.GS2542@lahna.fi.intel.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [172.17.15.136]
Content-Type: text/plain; charset="utf-8"
Content-ID: <46AC30FA8F37C84798556D5DAB655894@yadro.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDIxLTAyLTEyIGF0IDE0OjUyICswMjAwLCBtaWthLndlc3RlcmJlcmdAbGludXgu
aW50ZWwuY29tDQp3cm90ZToNCj4gSGksDQo+IA0KPiBPbiBUaHUsIEZlYiAxMSwgMjAyMSBhdCAw
NTo0NToyMFBNICswMDAwLCBTZXJnZWkgTWlyb3NobmljaGVua28NCj4gd3JvdGU6DQo+ID4gV2hh
dCBhIHBpdHkuIFllcywgcGxlYXNlLCBJIHdvdWxkIG9mIGNvdXJzZSBsaWtlIHRvIHRha2UgYSBs
b29rIHdoeQ0KPiA+IHRoYXQgaGFwcGVuZWQsIGFuZCBjb21wYXJlLCB3aGF0IHdlbnQgd3Jvbmcg
KGJlZm9yZSBhbmQgYWZ0ZXIgdGhlDQo+ID4gaG90cGx1ZzogbHNwY2kgLXR2LCBkbWVzZyAtdCBh
bmQgL3Byb2MvaW9tZW0gd2l0aCAvcHJvYy9pb3BvcnRzLCBpZg0KPiA+IGl0DQo+ID4gd291bGRu
J3QgYmUgdG9vIG11Y2ggdHJvdWJsZSkuDQo+IA0KPiBJIGp1c3Qgc2VudCB0aGVzZSBsb2dzIHRv
IHlvdSBpbiBhIHNlcGFyYXRlIGVtYWlsLiBMZXQgbWUga25vdyBpZiB5b3UNCj4gbmVlZCBtb3Jl
Lg0KDQpUaGFua3MsIGZyb20gdGhlbSBpdCdzIGNsZWFyIHRoYXQgdGhlICJmdWxsIHJlc2NhbiIg
YXBwcmFjaCBjdXJyZW50bHkNCmRvZXNuJ3QgaW52b2x2ZSB0aGUgcGNpX2J1c19kaXN0cmlidXRl
X2F2YWlsYWJsZV9yZXNvdXJjZXMoKSwgdGhhdCdzDQp3aHkgaG90LWFkZGluZyBhIHNlY29uZCBu
ZXN0ZWQgc3dpdGNoIGJyZWFrczogYmVjYXVzZSBvZiBub24tDQpkaXN0cmlidXRlZCBmcmVlIGJ1
cyBudW1iZXJzLiBUaGUgZmlyc3Qgc3dpdGNoIHNlZW1zIHdhcyBob3QtYWRkZWQganVzdA0KZmlu
ZSwgd2l0aCBCQVJzIGJlaW5nIG1vdmVkIGEgYml0Lg0KDQpUaGlzIGlzIHRvIGJlIGZpeGVkIGlu
IHYxMCwgYWxvbmcgd2l0aCB0aGUNCm1wdDNzYXMrcGNpX2Rldl9pc19kaXNjb25uZWN0ZWQoKSBt
b21lbnQgTHVrYXMgaGFkIGZvdW5kICh0aGFua3MNCkx1a2FzISksIENPTkZJR19ERUJVR19MT0NL
X0FMTE9DIG1hY3JvLCBhbmQgYSBtb3JlIHVzZWZ1bCBkZWJ1Zw0KbWVzc2FnZXMuDQoNClNlcmdl
DQo=
