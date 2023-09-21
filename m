Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A05C7AA0DA
	for <lists+linux-pci@lfdr.de>; Thu, 21 Sep 2023 22:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjIUUst (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Sep 2023 16:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjIUUs2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Sep 2023 16:48:28 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC0B89D96
        for <linux-pci@vger.kernel.org>; Thu, 21 Sep 2023 10:40:20 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-275-3ANp1ejCPpKMCXrfXPnzNA-1; Thu, 21 Sep 2023 14:20:59 +0100
X-MC-Unique: 3ANp1ejCPpKMCXrfXPnzNA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 21 Sep
 2023 14:20:58 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 21 Sep 2023 14:20:58 +0100
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
Thread-Index: AQHZ7ISwt0MI+BDoAEe5dUPUvfmXNrAlQDAw
Date:   Thu, 21 Sep 2023 13:20:58 +0000
Message-ID: <2e5870e416f84e8fad8340061ec303e2@AcuMS.aculab.com>
References: <20230920230257.GA280837@bhelgaas>
 <d84b6d17-7fe9-222a-c874-798af4d9faea@linux.alibaba.com>
In-Reply-To: <d84b6d17-7fe9-222a-c874-798af4d9faea@linux.alibaba.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Li4uDQpJJ3ZlIGdvdCBhIHRhcmdldCB0byBnZW5lcmF0ZSBBRVIgZXJyb3JzIGJ5IGdlbmVyYXRp
bmcgcmVhZCBjeWNsZXMNCnRoYXQgYXJlIGluc2lkZSB0aGUgYWRkcmVzcyByYW5nZSB0aGF0IHRo
ZSBicmlkZ2UgZm9yd2FyZHMgYnV0DQpvdXRzaWRlIG9mIGFueSBCQVIgYmVjYXVzZSB0aGVyZSBh
cmUgMiBkaWZmZXJlbnQgc2l6ZWQgQkFScy4NCihQcmV0dHkgZWFzeSB0byBzZXR1cC4pDQpPbiB0
aGUgc3lzdGVtIEkgd2FzIHVzaW5nIHRoZXkgZGlkbid0IGdldCBwcm9wYWdhdGVkIGFsbCB0aGUg
d2F5DQp0byB0aGUgcm9vdCBicmlkZ2UgLSBidXQgd2VyZSB2aXNpYmxlIGluIHRoZSBsb3dlciBi
cmlkZ2UuDQpJdCB3b3VsZCBiZSBuaWNlIGZvciBhIGRyaXZlciB0byBiZSBhYmxlIHRvIGRldGVj
dC9jbGVhciBzdWNoDQphIGZsYWcgaWYgaXQgZ2V0cyBhbiB1bmV4cGVjdGVkIH4wdSByZWFkIHZh
bHVlLg0KKEknbSBub3Qgc3VyZSBhbiBlcnJvciBjYWxsYmFjayBoZWxwcy4pDQoNCk9UT0ggYSAn
bmVicyBjb21wbGlhbnQnIHNlcnZlciByb3V0ZWQgYW55IGtpbmQgb2YgUENJZSBsaW5rIGVycm9y
DQp0aHJvdWdoIHRvIHNvbWUgJ3N5c3RlbSBtYW5hZ2VtZW50JyBsb2dpYyB0aGF0IHRoZW4gcmFp
c2VkIGFuIE5NSS4NCkknbSBub3Qgc3VyZSB3aG8gdGhvdWdodCBhbiBOTUkgd2FzIGEgZ29vZCBp
ZGVhIC0gdGhleSBhcmUgcHJldHR5DQppbXBvc3NpYmxlIHRvIGhhbmRsZSBpbiB0aGUga2VybmVs
IGFuZCB0b28gbGF0ZSB0byBiZSBvZiB1c2UgdG8NCnRoZSBjb2RlIHBlcmZvcm1pbmcgdGhlIGFj
Y2Vzcy4NCg0KSW4gYW55IGNhc2Ugd2Ugd2VyZSBnZXR0aW5nIG9uZSBhZnRlciAnZWNobyAxID54
eHgvcmVtb3ZlJyBhbmQNCnRoZW4gdGFraW5nIHRoZSBQQ0llIGxpbmsgZG93biBieSByZXByb2dy
YW1taW5nIHRoZSBmcGdhLg0KU28gdGhlIGxpbmsgZ29pbmcgZG93biB3YXMgZW50aXJlbHkgZXhw
ZWN0ZWQsIGJ1dCB0aGVyZSBzZWVtZWQNCnRvIGJlIG5vdGhpbmcgd2UgY291bGQgZG8gdG8gc3Rv
cCB0aGUga2VybmVsIGNyYXNoaW5nLg0KDQpJJ20gc3VyZSAnbmVicyBjb21wbGlhbnQnIG91Z2h0
IHRvIGNvbnRhaW4gc29tZSByZXF1aXJlbWVudHMgZm9yDQpyZXNpbGllbmNlIHRvIGhhcmR3YXJl
IGZhaWx1cmVzIQ0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBC
cmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdp
c3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

