Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B00E46AD36
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 23:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358698AbhLFWye (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 17:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358621AbhLFWyd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 17:54:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F5EC061746;
        Mon,  6 Dec 2021 14:51:04 -0800 (PST)
Message-ID: <20211206210600.123171746@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638831063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zuaVjYRhYaXSnxhOlTO3/+R1NRokr9z15QjTY7nAlqg=;
        b=g/R4QSH9IT1htMarbLNdxFDavRX6bJv4OUQ/T0gt4OQTqWZXzTnEFGfVNGY6u3WarVEX0M
        fO4dKL3Nm1idJ1EHNtMX9r3gv7Aa9o3YXnLoyDUhkVhTcL9wyzfCwA4mRP43jrVG1lBrvk
        ufNL0788SoAA7ns5LdioDLX/09NweJXy7JmQK0sepafvaSdQB0dkUuy9APy8Z+ZZpZRmtZ
        UyO27tAZTKgZE/UHN5p4OPkUXcwgOWtBGytrfD/kqC5Kq+IksH7RiH5qUuZ9fR60c7jrom
        Il+EusOQlF4egTWzDwPjnoc5PCnLeWjJc6hprAFpEnNdSv7BoTX/aaA5Ro+wcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638831063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zuaVjYRhYaXSnxhOlTO3/+R1NRokr9z15QjTY7nAlqg=;
        b=EiJLBZ0I2k31uIESwAuf3JVleODzfA1PUF4FPIFRUFMUdHiPUHwv8yQK8cFPw5MnxUJoi2
        tEyzCBesXZg681CA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: [patch V2 00/31] genirq/msi, PCI/MSI: Spring cleaning - Part 3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Mon,  6 Dec 2021 23:51:02 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VGhpcyBpcyB0aGUgdGhpcmQgcGFydCBvZiBbUENJXU1TSSByZWZhY3RvcmluZyB3aGljaCBhaW1z
IHRvIHByb3ZpZGUgdGhlCmFiaWxpdHkgb2YgZXhwYW5kaW5nIE1TSS1YIHZlY3RvcnMgYWZ0ZXIg
ZW5hYmxpbmcgTVNJLVguCgpUaGUgZmlyc3QgdHdvIHBhcnRzIG9mIHRoaXMgd29yayBjYW4gYmUg
Zm91bmQgaGVyZToKCiAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjExMjA2MjEwMTQ3
Ljg3Mjg2NTgyM0BsaW51dHJvbml4LmRlCiAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIw
MjExMjA2MjEwMzA3LjYyNTExNjI1M0BsaW51dHJvbml4LmRlCgpUaGlzIHRoaXJkIHBhcnQgaGFz
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
YWwgb2YgZHluYW1pYyBleHBhbnNpb24gb2YgdGhlIE1TSS1YIHNwYWNlLgoKVGhpcyB0aGlyZCBz
ZXJpZXMgaXMgYmFzZWQgb246CgogICAgIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC90Z2x4L2RldmVsLmdpdCBtc2ktdjItcGFydC0yCgphbmQgYWxzbyBhdmFp
bGFibGUgZnJvbSBnaXQ6CgogICAgIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC90Z2x4L2RldmVsLmdpdCBtc2ktdjItcGFydC0zCgpWMSBvZiB0aGlzIHNlcmll
cyBjYW4gYmUgZm91bmQgaGVyZToKCiAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjEx
MTI2MjI0MTAwLjMwMzA0Njc0OUBsaW51dHJvbml4LmRlCgpDaGFuZ2VzIHZlcnN1cyBWMToKCiAg
LSBSZW1vdmUgdGhlIGFsbG9jYXRpb24gY291bnRlciBwYXRjaCBhcyBpdCBpcyBub3QgcmVxdWly
ZWQKCiAgLSBGaXggdGhlIHBvd2VycGMgZmFsbG91dCAtIENlZHJpYwoKICAtIEZpeCB0aGUgQ09O
RklHIHR5cG8gLSBOaWtsYXMKCiAgLSBQaWNrZWQgdXAgUmV2aWV3ZWQvVGVzdGVkL0Fja2VkLWJ5
IHRhZ3MgYXMgYXBwcm9wcmlhdGUKCkFzIGEgY29uc2VxdWVuY2Ugb2YgdGhlIGRpc2N1c3Npb24g
dnMuIHRoZSBnZW5lcmFsIGRpcmVjdGlvbiBvZiB0aGVzZQpwYXRjaGVzLCBwYXJ0IDQgaXMgbm90
IGdvaW5nIHRvIGJlIHVwZGF0ZWQgaW4gaXQncyBjdXJyZW50IGZvcm0uCgpUaGUgYXNzdW1wdGlv
biB0aGF0IE1TSVtYXSBhbmQgSU1TIGFyZSBtdXR1YWxseSBleGNsdXNpdmUgYW5kIHRoYXQgSU1T
IGlzCmJhc2ljYWxseSBhbiBleHRlbnNpb24gZm9yIGZpbmVyIGdyYWluZWQgc3BsaXR1cCBvZiB0
aGUgUENJIGRldmljZSBkb2VzIG5vdApob2xkLgoKVGhlcmUgaXMgYSBwbGFuIHRvIHJlZmFjdG9y
IHRoZSBjb2RlIGZ1cnRoZXIgaW4gb3JkZXIgdG8gcHJvdmlkZSB0aGUKZGVzaXJlZCBmdW5jdGlv
bmFsaXR5IG9mIE1TSVtYXS9JTVMgd2hpY2ggd2lsbCBhbHNvIGdhaW4gdGhlIGR5bmFtaWMKZXh0
ZW5zaW9uIG9mIE1TSS1YIHZlY3RvcnM6CgogICAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9y
Lzg3bzg1djN6bmIuZmZzQHRnbHgKClRoYW5rcywKCgl0Z2x4Ci0tLQogLmNsYW5nLWZvcm1hdCAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAxIAogYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy80
eHgvaHN0YV9tc2kuYyAgfCAgICA3IAogYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9jZWxsL2F4b25f
bXNpLmMgfCAgICA3IAogYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wYXNlbWkvbXNpLmMgICAgfCAg
ICA5IAogYXJjaC9wb3dlcnBjL3N5c2Rldi9mc2xfbXNpLmMgICAgICAgICAgfCAgICA4IAogYXJj
aC9wb3dlcnBjL3N5c2Rldi9tcGljX3UzbXNpLmMgICAgICAgfCAgICA5IAogYXJjaC9zMzkwL3Bj
aS9wY2lfaXJxLmMgICAgICAgICAgICAgICAgfCAgICA2IAogYXJjaC94ODYvcGNpL3hlbi5jICAg
ICAgICAgICAgICAgICAgICAgfCAgIDE0IAogZHJpdmVycy9iYXNlL2NvcmUuYyAgICAgICAgICAg
ICAgICAgICAgfCAgICAzIAogZHJpdmVycy9iYXNlL3BsYXRmb3JtLW1zaS5jICAgICAgICAgICAg
fCAgMTEwIC0tLS0tCiBkcml2ZXJzL2J1cy9mc2wtbWMvZnNsLW1jLW1zaS5jICAgICAgICB8ICAg
NjEgLS0KIGRyaXZlcnMvbnRiL21zaS5jICAgICAgICAgICAgICAgICAgICAgIHwgICAxOSAKIGRy
aXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWh5cGVydi5jICAgIHwgICAxNSAKIGRyaXZlcnMvcGNp
L21zaS9pcnFkb21haW4uYyAgICAgICAgICAgIHwgICAxMSAKIGRyaXZlcnMvcGNpL21zaS9sZWdh
Y3kuYyAgICAgICAgICAgICAgIHwgICAyMCAKIGRyaXZlcnMvcGNpL21zaS9tc2kuYyAgICAgICAg
ICAgICAgICAgIHwgIDI1OCArKysrKystLS0tLS0KIGRyaXZlcnMvcGNpL3hlbi1wY2lmcm9udC5j
ICAgICAgICAgICAgIHwgICAgMiAKIGRyaXZlcnMvc29jL3RpL3RpX3NjaV9pbnRhX21zaS5jICAg
ICAgIHwgICA3NyArLS0KIGluY2x1ZGUvbGludXgvZGV2aWNlLmggICAgICAgICAgICAgICAgIHwg
ICAgNCAKIGluY2x1ZGUvbGludXgvbXNpLmggICAgICAgICAgICAgICAgICAgIHwgIDEwNyArKyst
LQogaW5jbHVkZS9saW51eC9zb2MvdGkvdGlfc2NpX2ludGFfbXNpLmggfCAgICAxIAoga2VybmVs
L2lycS9tc2kuYyAgICAgICAgICAgICAgICAgICAgICAgfCAgNzAwICsrKysrKysrKysrKysrKysr
KysrKystLS0tLS0tLS0tLQogMjIgZmlsZXMgY2hhbmdlZCwgNzk0IGluc2VydGlvbnMoKyksIDY1
NSBkZWxldGlvbnMoLSkK
