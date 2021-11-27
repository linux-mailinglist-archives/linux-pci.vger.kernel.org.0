Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3632A45FAD7
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349194AbhK0BfC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:35:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40386 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350613AbhK0BdB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:33:01 -0500
Message-ID: <20211126230957.239391799@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vhZzYjX7UMFE1bgre/8Ck07JyEROLh/fen+p3wWukPU=;
        b=L/+m4IsLWlBvSkfDcTn0Gpv5iv/0OtlylnUrMPdc1eVFcpdh6UMN1Wpnrj4/ISwi0vQ1ht
        M5O6NKe1WZT4SXhPlVBaIwQ/WUN0RaHcM7urBu7Xk0UQVVN3zUIGTUNkre8QfMLYdVYw5S
        9KxYQ9OSAcJW++6TouTCYmut5zwSqR6B9gypT632xrQ5JAYYhCXshtIkhoFfivWKRYWsPP
        P8QaISZrWvTHypbGw+pIIQB96FNcpCfQDyic5mLYVW21HpAZS1Gui49YAoMOpHwXLCvrWb
        XS19CN+Kkm7C2Mn7Y7Hm53yXzB1abty3k+/Eb69t4eklQykj9SvFq8XYh0ZUaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vhZzYjX7UMFE1bgre/8Ck07JyEROLh/fen+p3wWukPU=;
        b=XxQa74S1gpSEFC5UOXiGA6wwCCsRmBKK6B3GAwJAeTSkGb5fNEYaF7RBpEWPwZJPZ4tm0H
        AwgGtDEzwDvf96Cw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: [patch 00/32] genirq/msi, PCI/MSI: Spring cleaning - Part 2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Sat, 27 Nov 2021 02:23:28 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VGhpcyBpcyB0aGUgdGhpcmQgcGFydCBvZiBbUENJXU1TSSByZWZhY3RvcmluZyB3aGljaCBhaW1z
IHRvIHByb3ZpZGUgdGhlCmFiaWxpdHkgb2YgZXhwYW5kaW5nIE1TSS1YIHZlY3RvcnMgYWZ0ZXIg
ZW5hYmxpbmcgTVNJLVguCgpUaGUgZmlyc3QgdHdvIHBhcnRzIG9mIHRoaXMgd29yayBjYW4gYmUg
Zm91bmQgaGVyZToKCiAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjExMTI2MjIyNzAw
Ljg2MjQwNzk3N0BsaW51dHJvbml4LmRlCiAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIw
MjExMTI2MjI0MTAwLjMwMzA0Njc0OUBsaW51dHJvbml4LmRlCgpUaGlzIHRoaXJkIHBhcnQgaGFz
IHRoZSBmb2xsb3dpbmcgaW1wb3J0YW50IGNoYW5nZXM6CgogICAxKSBBZGQgbG9ja2luZyB0byBw
cm90ZWN0IHRoZSBNU0kgZGVzY3JpcHRvciBzdG9yYWdlCgogICAgICBSaWdodCBub3cgdGhlIE1T
SSBkZXNjcmlwdG9yIHN0b3JhZ2UgKGxpbmtlZCBsaXN0KSBpcyBub3QgcHJvdGVjdGVkCiAgICAg
IGJ5IGFueXRoaW5nIHVuZGVyIHRoZSBhc3N1bXB0aW9uIHRoYXQgdGhlIGxpc3QgaXMgaW5zdGFs
bGVkIGJlZm9yZQogICAgICB1c2UgYW5kIGRlc3Ryb3llZCBhZnRlciB1c2UuIEFzIHRoaXMgaXMg
YWJvdXQgdG8gY2hhbmdlIHRoZXJlIGhhcyB0bwogICAgICBiZSBwcm90ZWN0aW9uCgogICAyKSBB
IG5ldyBzZXQgb2YgaXRlcmF0b3JzIHdoaWNoIGFsbG93IGZpbHRlcmluZyBvbiB0aGUgc3RhdGUg
b2YgdGhlCiAgICAgIGRlc2NyaXB0b3JzIG5hbWVseSB3aGV0aGVyIGEgZGVzY3JpcHRvciBpcyBh
c3NvY2lhdGVkIHRvIGEgTGludXgKICAgICAgaW50ZXJydXB0IG9yIG5vdC4KCiAgICAgIFRoaXMg
Y2xlYW5zIHVwIGEgbG90IG9mIHVzZSBjYXNlcyB3aGljaCBoYXZlIHRvIGRvIHRoaXMgZmlsdGVy
aW5nCiAgICAgIG1hbnVhbGx5LgoKICAgMykgQSBuZXcgc2V0IG9mIE1TSSBkZXNjcmlwdG9yIGFs
bG9jYXRpb24gZnVuY3Rpb25zIHdoaWNoIG1ha2UgdGhlIHVzYWdlCiAgICAgIHNpdGVzIHNpbXBs
ZXIgYW5kIGNvbmZpbmUgdGhlIHN0b3JhZ2UgaGFuZGxpbmcgdG8gdGhlIGNvcmUgY29kZS4KCiAg
ICAgIFRyaXZpYWwgTVNJIGRlc2NyaXB0b3JzIChub24gUENJKSBhcmUgbm93IGFsbG9jYXRlZCBi
eSB0aGUgY29yZSBjb2RlCiAgICAgIGF1dG9tYXRpY2FsbHkgd2hlbiB0aGUgdW5kZXJseWluZyBp
cnEgZG9tYWluIHJlcXVlc3RzIHRoYXQuCgogICA0KSBSZXdvcmsgb2Ygc3lzZnMgaGFuZGxpbmcg
dG8gcHJlcGFyZSBmb3IgZHluYW1pYyBleHRlbnNpb24gb2YgTVNJLVgKCiAgICAgIFRoZSBjdXJy
ZW50IG1lY2hhbmlzbSB3aGljaCBjcmVhdGVzIHRoZSBkaXJlY3RvcnkgYW5kIHRoZSBhdHRyaWJ1
dGVzCiAgICAgIGZvciBhbGwgTVNJIGRlc2NyaXB0b3JzIGluIG9uZSBnbyBpcyBvYnZpb3VzbHkg
bm90IHN1aXRhYmxlIGZvcgogICAgICBkeW5hbWljIGV4dGVuc2lvbi4gVGhlIHJld29yayBzcGxp
dHMgdGhlIGRpcmVjdG9yeSBjcmVhdGlvbiBvdXQgYW5kCiAgICAgIGxldHMgdGhlIE1TSSBpbnRl
cnJ1cHQgYWxsb2NhdGlvbiBjcmVhdGUgdGhlIHBlciBkZXNjcmlwdG9yCiAgICAgIGF0dHJpYnV0
ZXMuCgogICA1KSBDb252ZXJzaW9uIG9mIHRoZSBNU0kgZGVzY3JpcHRvciBzdG9yYWdlIHRvIHhh
cnJheQoKICAgICAgVGhlIGxpbmtlZCBsaXN0IGJhc2VkIHN0b3JhZ2UgaXMgc3Vib3B0aW1hbCBl
dmVuIHdpdGhvdXQgZHluYW1pYwogICAgICBleHBhbnNpb24gYXMgaXQgcmVxdWlyZXMgZnVsbCBs
aXN0IHdhbGtzIHRvIGdldCB0byBhIHNwZWNpZmljCiAgICAgIGRlc2NyaXB0b3IuIFdpdGggZHlu
YW1pYyBleHBhbnNpb24gdGhpcyBnZXRzIGV2ZW4gbW9yZQogICAgICBjb252b2x1dGVkLiBYYXJy
YXkgaXMgd2F5IG1vcmUgc3VpdGFibGUgYW5kIHNpbXBsaWZpZXMgdGhlCiAgICAgIGZpbmFsIGdv
YWwgb2YgZHluYW1pYyBleHBhbnNpb24gb2YgdGhlIE1TSS1YIHNwYWNlLgoKVGhlIHNlcmllcyBp
cyBiYXNlZCBvbjoKCiAgICAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L3RnbHgvZGV2ZWwuZ2l0IG1zaS12MS1wYXJ0LTIKCmFuZCBhbHNvIGF2YWlsYWJsZSBm
cm9tIGdpdDoKCiAgICAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L3RnbHgvZGV2ZWwuZ2l0IG1zaS12MS1wYXJ0LTMKCkZvciB0aGUgY3VyaW91cyB3aG8gY2Fu
J3Qgd2FpdCBmb3IgdGhlIG5leHQgcGFydCB0byBhcnJpdmUgdGhlIGZ1bGwgc2VyaWVzCmlzIGF2
YWlsYWJsZSB2aWE6CgogICAgIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC90Z2x4L2RldmVsLmdpdCBtc2ktdjEtcGFydC00CgpUaGFua3MsCgoJdGdseAotLS0K
IC5jbGFuZy1mb3JtYXQgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgMSAKIGFyY2gvcG93
ZXJwYy9wbGF0Zm9ybXMvNHh4L2hzdGFfbXNpLmMgIHwgICAgNyAKIGFyY2gvcG93ZXJwYy9wbGF0
Zm9ybXMvY2VsbC9heG9uX21zaS5jIHwgICAgNyAKIGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcGFz
ZW1pL21zaS5jICAgIHwgICAgOSAKIGFyY2gvcG93ZXJwYy9zeXNkZXYvZnNsX21zaS5jICAgICAg
ICAgIHwgICAgOCAKIGFyY2gvcG93ZXJwYy9zeXNkZXYvbXBpY191M21zaS5jICAgICAgIHwgICAg
OSAKIGFyY2gvczM5MC9wY2kvcGNpX2lycS5jICAgICAgICAgICAgICAgIHwgICAgNiAKIGFyY2gv
eDg2L3BjaS94ZW4uYyAgICAgICAgICAgICAgICAgICAgIHwgICAxNCAKIGRyaXZlcnMvYmFzZS9j
b3JlLmMgICAgICAgICAgICAgICAgICAgIHwgICAgMyAKIGRyaXZlcnMvYmFzZS9wbGF0Zm9ybS1t
c2kuYyAgICAgICAgICAgIHwgIDExMCAtLS0tLQogZHJpdmVycy9idXMvZnNsLW1jL2ZzbC1tYy1t
c2kuYyAgICAgICAgfCAgIDYxIC0tCiBkcml2ZXJzL250Yi9tc2kuYyAgICAgICAgICAgICAgICAg
ICAgICB8ICAgMTkgCiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1oeXBlcnYuYyAgICB8ICAg
MTUgCiBkcml2ZXJzL3BjaS9tc2kvaXJxZG9tYWluLmMgICAgICAgICAgICB8ICAgMTEgCiBkcml2
ZXJzL3BjaS9tc2kvbGVnYWN5LmMgICAgICAgICAgICAgICB8ICAgMjAgCiBkcml2ZXJzL3BjaS9t
c2kvbXNpLmMgICAgICAgICAgICAgICAgICB8ICAyNTUgKysrKystLS0tLS0KIGRyaXZlcnMvcGNp
L3hlbi1wY2lmcm9udC5jICAgICAgICAgICAgIHwgICAgMiAKIGRyaXZlcnMvc29jL3RpL3RpX3Nj
aV9pbnRhX21zaS5jICAgICAgIHwgICA3NyArLS0KIGluY2x1ZGUvbGludXgvZGV2aWNlLmggICAg
ICAgICAgICAgICAgIHwgICAgNCAKIGluY2x1ZGUvbGludXgvbXNpLmggICAgICAgICAgICAgICAg
ICAgIHwgIDEzNSArKysrKy0KIGluY2x1ZGUvbGludXgvc29jL3RpL3RpX3NjaV9pbnRhX21zaS5o
IHwgICAgMSAKIGtlcm5lbC9pcnEvbXNpLmMgICAgICAgICAgICAgICAgICAgICAgIHwgIDcxOSAr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0KIDIyIGZpbGVzIGNoYW5nZWQsIDg0MSBp
bnNlcnRpb25zKCspLCA2NTIgZGVsZXRpb25zKC0pCgoK
