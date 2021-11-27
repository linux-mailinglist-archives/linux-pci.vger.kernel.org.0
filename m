Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF3545FA71
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350142AbhK0BcA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:32:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40502 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350311AbhK0B37 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:29:59 -0500
Message-ID: <20211126230957.239391799@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=D0nbUkdccTCr+2Br2gyXx7cP8vfnCoeXBZSgMbFqpdM=;
        b=TEH82iHayKr/ntaPYYfi30q+zCMZHKxasmVUpcMFsUzBAk6YgBm3YBOTFIVC6RffhkF/Tk
        bwUmRooEMF85FbSUM+o9jdCi6u+6knuAgcavR0gB7dKy2Q/iq3kcQjkIbfjWHKFKnVPbpR
        xIltg0AIgjG0BjA0HRjgpmSAKa9JAmk5F7FfSZAu0vBKn9KBzWaSNl30AxYaaf+ealQWgk
        fgufOWF0E0tVfiWFQ7V4bV0rN6KFodraeUo049MRdidrEH7XWB8C/1Z8OhA6+XouFTwtaE
        WIHKJ533Tz3Fo8jw7nBLGws1Qb94n7NwcnisVd8rgqbYmiwpFesUWoSmTJfj1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=D0nbUkdccTCr+2Br2gyXx7cP8vfnCoeXBZSgMbFqpdM=;
        b=6MlFc/aHe2yyZUJPi9w8j4A1gcK4pI/ykoPIROYyuyct/PJqIaqSJWUIpI3wZ/ETqn93vt
        Dk5vUE+uTfjirbDg==
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
Date:   Sat, 27 Nov 2021 02:22:27 +0100 (CET)
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
YWwgb2YgZHluYW1pYyBleHBhbnNpb24gb2YgdGhlIE1TSS1YIHNwYWNlLgoKVGhpcyB0aGlyZCBz
ZXJpZXMgaXMgYmFzZWQgb246CgogICAgIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC90Z2x4L2RldmVsLmdpdCBtc2ktdjEtcGFydC0yCgphbmQgYWxzbyBhdmFp
bGFibGUgZnJvbSBnaXQ6CgogICAgIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC90Z2x4L2RldmVsLmdpdCBtc2ktdjEtcGFydC0zCgpGb3IgdGhlIGN1cmlvdXMg
d2hvIGNhbid0IHdhaXQgZm9yIHRoZSBuZXh0IHBhcnQgdG8gYXJyaXZlIHRoZSBmdWxsIHNlcmll
cwppcyBhdmFpbGFibGUgdmlhOgoKICAgICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvdGdseC9kZXZlbC5naXQgbXNpLXYxLXBhcnQtNAoKVGhhbmtzLAoKCXRn
bHgKLS0tCiAuY2xhbmctZm9ybWF0ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDEgCiBh
cmNoL3Bvd2VycGMvcGxhdGZvcm1zLzR4eC9oc3RhX21zaS5jICB8ICAgIDcgCiBhcmNoL3Bvd2Vy
cGMvcGxhdGZvcm1zL2NlbGwvYXhvbl9tc2kuYyB8ICAgIDcgCiBhcmNoL3Bvd2VycGMvcGxhdGZv
cm1zL3Bhc2VtaS9tc2kuYyAgICB8ICAgIDkgCiBhcmNoL3Bvd2VycGMvc3lzZGV2L2ZzbF9tc2ku
YyAgICAgICAgICB8ICAgIDggCiBhcmNoL3Bvd2VycGMvc3lzZGV2L21waWNfdTNtc2kuYyAgICAg
ICB8ICAgIDkgCiBhcmNoL3MzOTAvcGNpL3BjaV9pcnEuYyAgICAgICAgICAgICAgICB8ICAgIDYg
CiBhcmNoL3g4Ni9wY2kveGVuLmMgICAgICAgICAgICAgICAgICAgICB8ICAgMTQgCiBkcml2ZXJz
L2Jhc2UvY29yZS5jICAgICAgICAgICAgICAgICAgICB8ICAgIDMgCiBkcml2ZXJzL2Jhc2UvcGxh
dGZvcm0tbXNpLmMgICAgICAgICAgICB8ICAxMTAgLS0tLS0KIGRyaXZlcnMvYnVzL2ZzbC1tYy9m
c2wtbWMtbXNpLmMgICAgICAgIHwgICA2MSAtLQogZHJpdmVycy9udGIvbXNpLmMgICAgICAgICAg
ICAgICAgICAgICAgfCAgIDE5IAogZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaHlwZXJ2LmMg
ICAgfCAgIDE1IAogZHJpdmVycy9wY2kvbXNpL2lycWRvbWFpbi5jICAgICAgICAgICAgfCAgIDEx
IAogZHJpdmVycy9wY2kvbXNpL2xlZ2FjeS5jICAgICAgICAgICAgICAgfCAgIDIwIAogZHJpdmVy
cy9wY2kvbXNpL21zaS5jICAgICAgICAgICAgICAgICAgfCAgMjU1ICsrKysrLS0tLS0tCiBkcml2
ZXJzL3BjaS94ZW4tcGNpZnJvbnQuYyAgICAgICAgICAgICB8ICAgIDIgCiBkcml2ZXJzL3NvYy90
aS90aV9zY2lfaW50YV9tc2kuYyAgICAgICB8ICAgNzcgKy0tCiBpbmNsdWRlL2xpbnV4L2Rldmlj
ZS5oICAgICAgICAgICAgICAgICB8ICAgIDQgCiBpbmNsdWRlL2xpbnV4L21zaS5oICAgICAgICAg
ICAgICAgICAgICB8ICAxMzUgKysrKystCiBpbmNsdWRlL2xpbnV4L3NvYy90aS90aV9zY2lfaW50
YV9tc2kuaCB8ICAgIDEgCiBrZXJuZWwvaXJxL21zaS5jICAgICAgICAgICAgICAgICAgICAgICB8
ICA3MTkgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tCiAyMiBmaWxlcyBjaGFuZ2Vk
LCA4NDEgaW5zZXJ0aW9ucygrKSwgNjUyIGRlbGV0aW9ucygtKQoKCg==
