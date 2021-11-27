Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CB945FB2D
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350282AbhK0Bg5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:36:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40718 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348743AbhK0Bez (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:34:55 -0500
Message-ID: <20211126233124.618283684@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cXwN7LAx6ag9HOMQtjLd6VTeK3zX6xCMXFRxvs6U6Qg=;
        b=14q4wOfG/0/SZhjwir+cQHJgN4Eo+aHBwW3N78dcnYHDysV9Oh1NWZqgJ4JuWR/baa9D2Z
        NGYz0nAYpGfPsHFUlg5IrQQTw+vEwwj30OLhvIpllXtuE9HgIXHfbE7EEDVm3GOiGHYHbG
        QKUA3MpESWpx/pP4hwDMPtsbETljzTerGL18EUZQZo3hOmbv8495iEjfmpSrxIhYVTmU9q
        Y+ipEcdCu43SMNRGBKk3j3+5hGIz1q5c7m+vCiYI5CvegGVw6Zpl6rZNHHG7P6my+qeA/L
        PXiEE2W/Cgvup0+A3VLyLKTee/d5AKafHg/Uir8yQD0wfIFbtg/4DTAu6ZhMxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cXwN7LAx6ag9HOMQtjLd6VTeK3zX6xCMXFRxvs6U6Qg=;
        b=KO4VdGK/spEZe2s55ufjJGfc/FG3K9/3AjsE6hAK9UTesq2K2rALdyStZ/xDIu23Rs4Tjf
        UmIDWC9TXBsCnuCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Cooper <amc96@cam.ac.uk>,
        Juergen Gross <jgross@suse.com>, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: [patch 00/10] genirq/msi, PCI/MSI: Support for dynamic MSI-X vector
 expansion - Part 4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Sat, 27 Nov 2021 02:24:30 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VGhpcyBpcyBmaW5hbGx5IHRoZSBwb2ludCB3aGVyZSBkeW5hbWljYWxseSBleHBhbmRpbmcgTVNJ
LVggdmVjdG9ycyBhZnRlcgplbmFibGluZyBNU0ktWCBpcyBpbXBsZW1lbnRlZC4KClRoZSBmaXJz
dCB0aHJlZSBwYXJ0cyBvZiB0aGlzIHdvcmsgY2FuIGJlIGZvdW5kIGhlcmU6CgogICAgaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIxMTEyNjIyMjcwMC44NjI0MDc5NzdAbGludXRyb25peC5k
ZQogICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIxMTEyNjIyNDEwMC4zMDMwNDY3NDlA
bGludXRyb25peC5kZQogICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIxMTEyNjIzMDk1
Ny4yMzkzOTE3OTlAbGludXRyb25peC5kZQoKVGhpcyBsYXN0IGFuZCBzbWFsbGVzdCBwYXJ0IG9m
IHRoZSBvdmVyYWxsIHNlcmllcyBjb250YWlucyB0aGUgZm9sbG93aW5nCmNoYW5nZXM6CgogICAx
KSBQcmVwYXJlIHRoZSBjb3JlIE1TSSBpcnEgZG9tYWluIGNvZGUgdG8gaGFuZGxlIHJhbmdlIGJh
c2VkIGFsbG9jYXRpb24KICAgICAgYW5kIGZyZWUKCiAgIDIpIFByZXBhcmUgdGhlIFBDSS9NU0kg
Y29kZSB0byBoYW5kbGUgcmFuZ2UgYmFzZWQgYWxsb2NhdGlvbiBhbmQgZnJlZQogIAogICAzKSBJ
bXBsZW1lbnQgYSBuZXcgaW50ZXJmYWNlIHdoaWNoIGFsbG93cyB0byBleHBhbmQgdGhlIE1TSS1Y
IHZlY3RvcgogICAgICBzcGFjZSBhZnRlciBpbml0aWFsaXphdGlvbgoKICAgNCkgRW5hYmxlIHN1
cHBvcnQgZm9yIHRoZSBYODYgUENJL01TSSBpcnEgZG9tYWlucwoKICAgICAgVGhpcyBpcyB1bmZv
cnR1bmF0ZSwgYnV0IHNvbWUgUENJL01TSSBpcnEgZG9tYWluIGltcGxlbWVudGF0aW9ucywKICAg
ICAgZS5nLiBwb3dlcnBjIGFuZCB0aGUgeDg2L1hFTiBpcnFkb21haW4gd3JhcHBlcnMgYXJlIG5v
dCByZWFsbHkgcmVhZHkKICAgICAgdG8gc3VwcG9ydCB0aGlzIG91dCBvZiB0aGUgYm94LgoKICAg
ICAgSSBsb29rZWQgYXQgdGhlIDMwIHBsYWNlcyB3aGljaCBpbXBsZW1lbnQgUENJL01TSSBpcnEg
ZG9tYWlucyBhbmQKICAgICAgbWFueSBvZiB0aGVtIGxvb2sgbGlrZSB0aGV5IGNvdWxkIHN1cHBv
cnQgaXQgb3V0IG9mIHRoZSBib3gsIGJ1dCBhcwogICAgICB3ZSBoYXZlIHR3byB3aGljaCBkZWZp
bml0ZWx5IGRvbid0LCBtYWtpbmcgdGhpcyBvcHQtaW4gaXMgdGhlIG9ubHkKICAgICAgc2FmZSBv
cHRpb24uCgpJJ3ZlIHRlc3RlZCB0aGlzIGJ5IGhhY2tpbmcgdXAgdGhlIFhIQ0kgZHJpdmVyIGFu
ZCBpdCB3b3JrcyBsaWtlIGEgY2hhcm0uCgpUaGVyZSBpcyBjZXJ0YWlubHkgc29tZSBtb3JlIHJv
b20gZm9yIGNvbnNvbGlkYXRpbmcgdGhlIFBDSS9NU0ktWCB1c2FnZSBpbgpkcml2ZXJzLCBpLmUu
IGdldHRpbmcgcmlkIG9mIHBjaV9lbmFibGVfbXNpeCooKSwgYnV0IHRoaXMgd291bGQgaGF2ZSBt
YWRlCnRoaXMgb3ZlcmFsbCBzZXJpZXMgZXZlbiBsYXJnZXIgYW5kIGlzIGFuIG9ydGhvZ29uYWwg
aXNzdWUuCgpUaGlzIGZvdXJ0aCBzZXJpZXMgaXMgYmFzZWQgb246CgogICAgIGdpdDovL2dpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90Z2x4L2RldmVsLmdpdCBtc2ktdjEt
cGFydC0zCgphbmQgYWxzbyBhdmFpbGFibGUgZnJvbSBnaXQ6CgogICAgIGdpdDovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90Z2x4L2RldmVsLmdpdCBtc2ktdjEtcGFy
dC00CgpUaGFua3MsCgoJdGdseAotLS0KIGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9t
c2kuYyB8ICAgIDYgKy0KIGFyY2gveDg2L2tlcm5lbC9hcGljL21zaS5jICAgICAgICAgICB8ICAg
IDQgLQogYXJjaC94ODYvcGNpL3hlbi5jICAgICAgICAgICAgICAgICAgIHwgICAxMCArLS0KIGRy
aXZlcnMvYmFzZS9wbGF0Zm9ybS1tc2kuYyAgICAgICAgICB8ICAgIDMgLQogZHJpdmVycy9wY2kv
bXNpL2lycWRvbWFpbi5jICAgICAgICAgIHwgICAzOSArKysrKysrKysrLS0tLQogZHJpdmVycy9w
Y2kvbXNpL21zaS5jICAgICAgICAgICAgICAgIHwgICA5NyArKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0tLS0tLQogZHJpdmVycy9wY2kvbXNpL21zaS5oICAgICAgICAgICAgICAgIHwgICAg
NCAtCiBpbmNsdWRlL2xpbnV4L21zaS5oICAgICAgICAgICAgICAgICAgfCAgIDQ2ICsrKysrKysr
KysrLS0tLS0KIGluY2x1ZGUvbGludXgvcGNpLmggICAgICAgICAgICAgICAgICB8ICAgMTMgKysr
Kwoga2VybmVsL2lycS9tc2kuYyAgICAgICAgICAgICAgICAgICAgIHwgICA3NSArKysrKysrKysr
KysrKystLS0tLS0tLS0tLS0KIDEwIGZpbGVzIGNoYW5nZWQsIDIwOCBpbnNlcnRpb25zKCspLCA4
OSBkZWxldGlvbnMoLSkK
