Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526C17AD2B3
	for <lists+linux-pci@lfdr.de>; Mon, 25 Sep 2023 10:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjIYIIB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Sep 2023 04:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbjIYIH4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Sep 2023 04:07:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90592AF
        for <linux-pci@vger.kernel.org>; Mon, 25 Sep 2023 01:07:49 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-40-yCHXM_ZnNDeRG6PClZKq0A-1; Mon, 25 Sep 2023 09:07:37 +0100
X-MC-Unique: yCHXM_ZnNDeRG6PClZKq0A-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 25 Sep
 2023 09:07:36 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 25 Sep 2023 09:07:36 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Shuai Xue' <xueshuai@linux.alibaba.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "mahesh@linux.ibm.com" <mahesh@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "lenb@kernel.org" <lenb@kernel.org>
Subject: RE: Questions: Should kernel panic when PCIe fatal error occurs?
Thread-Topic: Questions: Should kernel panic when PCIe fatal error occurs?
Thread-Index: AQHZ7ISwt0MI+BDoAEe5dUPUvfmXNrAlQDAwgAV5fACAAHb74A==
Date:   Mon, 25 Sep 2023 08:07:35 +0000
Message-ID: <acd250505687437b85830a0b2f4d69b0@AcuMS.aculab.com>
References: <20230920230257.GA280837@bhelgaas>
 <d84b6d17-7fe9-222a-c874-798af4d9faea@linux.alibaba.com>
 <2e5870e416f84e8fad8340061ec303e2@AcuMS.aculab.com>
 <f70e93c6-ba5b-a71c-4b82-33b279c76b0e@linux.alibaba.com>
In-Reply-To: <f70e93c6-ba5b-a71c-4b82-33b279c76b0e@linux.alibaba.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogU2h1YWkgWHVlDQo+IFNlbnQ6IDI1IFNlcHRlbWJlciAyMDIzIDAyOjQ0DQo+IA0KPiBP
biAyMDIzLzkvMjEgMjE6MjAsIERhdmlkIExhaWdodCB3cm90ZToNCj4gPiAuLi4NCj4gPiBJJ3Zl
IGdvdCBhIHRhcmdldCB0byBnZW5lcmF0ZSBBRVIgZXJyb3JzIGJ5IGdlbmVyYXRpbmcgcmVhZCBj
eWNsZXMNCj4gPiB0aGF0IGFyZSBpbnNpZGUgdGhlIGFkZHJlc3MgcmFuZ2UgdGhhdCB0aGUgYnJp
ZGdlIGZvcndhcmRzIGJ1dA0KPiA+IG91dHNpZGUgb2YgYW55IEJBUiBiZWNhdXNlIHRoZXJlIGFy
ZSAyIGRpZmZlcmVudCBzaXplZCBCQVJzLg0KPiA+IChQcmV0dHkgZWFzeSB0byBzZXR1cC4pDQo+
ID4gT24gdGhlIHN5c3RlbSBJIHdhcyB1c2luZyB0aGV5IGRpZG4ndCBnZXQgcHJvcGFnYXRlZCBh
bGwgdGhlIHdheQ0KPiA+IHRvIHRoZSByb290IGJyaWRnZSAtIGJ1dCB3ZXJlIHZpc2libGUgaW4g
dGhlIGxvd2VyIGJyaWRnZS4NCj4gDQo+IFNvIGhvdyBkaWQgeW91IG9ic2VydmUgaXQ/IElmIHRo
ZSBlcnJvciBtZXNzYWdlIGRvZXMgbm90IHByb3BhZ2F0ZQ0KPiB0byB0aGUgcm9vdCBicmlkZ2Us
IEkgdGhpbmsgbm8gQUVSIGludGVycnVwdCB3aWxsIGJlIHRyaWdnZXIuDQoNCkkgbG9va2VkIGF0
IHRoZSBpbnRlcm5hbCByZWdpc3RlcnMgKElJUkMgaW4gUENJZSBjb25maWcgc3BhY2UpDQpvZiB0
aGUgaW50ZXJtZWRpYXRlIGJyaWRnZS4NCkkgZG9uJ3QgdGhpbmsgdGhlIHJvb3QgYnJpZGdlIG9u
IHRoYXQgc3lzdGVtIHN1cHBvcnRlZCBBRVIuDQooSSB3YXMgdGVzdGluZyB0aGUgZ2VuZXJhdGlv
biBvZiBBRVIgaW5kaWNhdGlvbnMgYnkgb3VyIGZwZ2EuKQ0KDQo+IA0KPiA+IEl0IHdvdWxkIGJl
IG5pY2UgZm9yIGEgZHJpdmVyIHRvIGJlIGFibGUgdG8gZGV0ZWN0L2NsZWFyIHN1Y2gNCj4gPiBh
IGZsYWcgaWYgaXQgZ2V0cyBhbiB1bmV4cGVjdGVkIH4wdSByZWFkIHZhbHVlLg0KPiA+IChJJ20g
bm90IHN1cmUgYW4gZXJyb3IgY2FsbGJhY2sgaGVscHMuKQ0KPiANCj4gSU1ITywgYSBnZW5lcmFs
IG1vZGVsIGlzIHRoYXQgZXJyb3IgZGV0ZWN0ZWQgYXQgZW5kcG9pbnQgc2hvdWxkIGJlDQo+IHJv
dXRlZCB0byB1cHN0cmVhbSBwb3J0IGZvciBleGFtcGxlOiBSQ2lFUCByb3V0ZSBlcnJvciBtZXNz
YWdlIHRvIFJDRUMsDQo+IHNvIHRoYXQgdGhlIEFFUiBwb3J0IHNlcnZpY2UgY291bGQgaGFuZGxl
IHRoZSBlcnJvciwgdGhlIGRldmljZSBkcml2ZXINCj4gb25seSBoYXZlIHRvIGltcGxlbWVudCBl
cnJvciBoYW5kbGVyIGNhbGxiYWNrLg0KDQpUaGUgcHJvYmxlbSBpcyB0aGF0IHRoYXQgYW5kIGNh
bGxiYWNrIGlzIHRvbyBsYXRlIGZvciBzb21ldGhpbmcNCnRyaWdnZXJlZCBieSBhIFBDSWUgcmVh
ZC4NClRoZSBkcml2ZXIgaGFzIHRvIGRldGVjdCB0aGF0IHRoZSB2YWx1ZSBpcyAnZHViaW91cycg
YW5kIHdhbnRzDQphIG1ldGhvZCBvZiBkZXRlY3Rpbmcgd2hldGhlciB0aGVyZSB3YXMgYW4gYXNz
b2NpYXRlZCBBRVIgKG9yIG90aGVyKQ0KZXJyb3IuDQpJZiB0aGUgQUVSIGluZGljYXRpb24gaXMg
cm91dGVkIHRocm91Z2ggc29tZSBleHRlcm5hbCBlbnRpdHkgKGxpa2UNCmJvYXJkIG1hbmFnZW1l
bnQgaGFyZHdhcmUpIHRoZXJlIHdpbGwgYmUgYWRkaXRpb25hbCBsYXRlbmN5IHRoYXQNCm1lYW5z
IHRoYXQgdGhlIGFzc29jaWF0ZWQgaW50ZXJydXB0IChldmVuIGlmIGFuIE5NSSkgbWF5IG5vdCBo
YXZlDQpiZWVuIHByb2Nlc3NlZCB3aGVuIHRoZSBkcml2ZXIgY29kZSBpcyB0cnlpbmcgdG8gZGV0
ZXJtaW5lIHdoYXQNCmhhcHBlbmVkLg0KVGhpcyBjYW4gb25seSBiZSBtYWRlIHdvcnNlIGJ5IHRo
ZSBpbnRlcnJ1cHQgY29taW5nIGluIG9uIGENCmRpZmZlcmVudCBjcHUuDQoNCj4gPiBPVE9IIGEg
J25lYnMgY29tcGxpYW50JyBzZXJ2ZXIgcm91dGVkIGFueSBraW5kIG9mIFBDSWUgbGluayBlcnJv
cg0KPiA+IHRocm91Z2ggdG8gc29tZSAnc3lzdGVtIG1hbmFnZW1lbnQnIGxvZ2ljIHRoYXQgdGhl
biByYWlzZWQgYW4gTk1JLg0KPiA+IEknbSBub3Qgc3VyZSB3aG8gdGhvdWdodCBhbiBOTUkgd2Fz
IGEgZ29vZCBpZGVhIC0gdGhleSBhcmUgcHJldHR5DQo+ID4gaW1wb3NzaWJsZSB0byBoYW5kbGUg
aW4gdGhlIGtlcm5lbCBhbmQgdG9vIGxhdGUgdG8gYmUgb2YgdXNlIHRvDQo+ID4gdGhlIGNvZGUg
cGVyZm9ybWluZyB0aGUgYWNjZXNzLg0KPiANCj4gSSB0aGluayBpdCBpcyB0aGUgcmVzcG9uc2li
aWxpdHkgb2YgdGhlIGRldmljZSB0byBwcmV2ZW50IHRoZSBzcHJlYWQgb2YNCj4gZXJyb3JzIHdo
aWxlIHJlcG9ydGluZyB0aGF0IGVycm9ycyBoYXZlIGJlZW4gZGV0ZWN0ZWQuIEZvciBleGFtcGxl
LCBkcm9wDQo+IHRoZSBjdXJyZW50LCAoZHJhaW4gc3VibWl0IHF1ZXVlKSBhbmQgcmVwb3J0IGVy
cm9yIGluIGNvbXBsZXRpb24gcmVjb3JkLg0KDQpFaD8NCkkgY2FuIGdlbmVyYXRlIHR3byB0eXBl
cyBvZiBQQ0llIGVycm9yOg0KLSBSZWFkL3dyaXRlIHJlcXVlc3RzIGZvciBhZGRyZXNzZXMgdGhh
dCBhcmVuJ3QgaW5zaWRlIGEgQkFSLg0KLSBMaW5rIGZhaWx1cmVzIHRoYXQgY2F1c2UgcmV0cmFp
bmluZyBhbmQgbWlnaHQgbmVlZCBjb25maWcNCiAgc3BhY2UgcmVjb25maWd1cmluZy4NCg0KPiBC
b3RoIE5NSSBhbmQgTVNJIGFyZSBhc3luY2hyb25vdXMgaW50ZXJydXB0cy4NCg0KSW5kZWVkLCB3
aGljaCBtYWtlcyBuZWl0aGVyIG9mIHRoZW0gc3VpdGFibGUgZm9yIGFueSBpbmRpY2F0aW9uDQpy
ZWxhdGluZyB0byBhIGJ1cyBjeWNsZSBmYWlsdXJlLg0KDQo+ID4gSW4gYW55IGNhc2Ugd2Ugd2Vy
ZSBnZXR0aW5nIG9uZSBhZnRlciAnZWNobyAxID54eHgvcmVtb3ZlJyBhbmQNCj4gPiB0aGVuIHRh
a2luZyB0aGUgUENJZSBsaW5rIGRvd24gYnkgcmVwcm9ncmFtbWluZyB0aGUgZnBnYS4NCj4gPiBT
byB0aGUgbGluayBnb2luZyBkb3duIHdhcyBlbnRpcmVseSBleHBlY3RlZCwgYnV0IHRoZXJlIHNl
ZW1lZA0KPiA+IHRvIGJlIG5vdGhpbmcgd2UgY291bGQgZG8gdG8gc3RvcCB0aGUga2VybmVsIGNy
YXNoaW5nLg0KPiA+DQo+ID4gSSdtIHN1cmUgJ25lYnMgY29tcGxpYW50JyBvdWdodCB0byBjb250
YWluIHNvbWUgcmVxdWlyZW1lbnRzIGZvcg0KPiA+IHJlc2lsaWVuY2UgdG8gaGFyZHdhcmUgZmFp
bHVyZXMhDQo+IA0KPiBIb3cgdGhlIGtlcm5lbCBjcmFzaCBhZnRlciBhIGxpbmsgZG93bj8gRGlk
IHRoZSBzeXN0ZW0gZGV0ZWN0IGEgc3VycHJpc2UNCj4gZG93biBlcnJvcj8NCg0KSXQgd2FzIGEg
Y291cGxlIG9mIHllYXJzIGFnby4uDQpJSVJDIHRoZSAnbGluayBkb3duJyBjYXVzZSB0aGUgaHVi
IHRvIGdlbmVyYXRlIGFuIEFFUiBlcnJvci4NClRoZSByb290IGh1YiBmb3J3YXJkZWQgaXQgdG8g
c29tZSAnYm9hcmQgbWFuYWdlbWVudCBoYXJkd2FyZS9zb2Z0d2FyZScNCnRoYXQgdGhlbiByYWlz
ZWQgYW5kIE5NSS4NClRoZSBrZXJuZWwgY3Jhc2hlZCBiZWNhdXNlIG9mIGFuIHVuZXhwZWN0ZWQg
Tk1JLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5
IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRp
b24gTm86IDEzOTczODYgKFdhbGVzKQ0K

