Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE5045FB39
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349357AbhK0BhN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:37:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40742 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346098AbhK0BfN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:35:13 -0500
Message-ID: <20211126233124.618283684@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=db+bEd42/odCLFRuWnqbyMqKNP8CPK8Qgl6k8EnxiD4=;
        b=1JlpTSX4Oy1wxfkRGfi3MFe15urC2p2+OrjfJgRh8RUL+84OSGSciJke659tDU3sGZWAPK
        kl9oaW52ONLaQ3HdTC/tL2eZb0dBKAlCTOBLxqnsHzvTkHnb2zmWh2mf67D0QDpvGh+PDN
        HYafcSl5dWtgEzn6jQ4MFoQ1CykTAYxLJzPL3dhreYF90toQe1lMo8dPAx8l/oXk/4Oe4R
        kAsJxgjoMqD641Zs66b3plcM9681VXaFP2G4W9DXXHvZegFqWPMRjXsdkuu/B4mAqmGsHL
        +nMcmL4XP8tl2H/u4Jfcrn2L2H6APZ9shAZy/iqsDKIBWqfUN22XWDpbzNMYFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=db+bEd42/odCLFRuWnqbyMqKNP8CPK8Qgl6k8EnxiD4=;
        b=aqqfLHlqslFm90N1E+AAibzpkiPNtQQ0MsJBpzh2OzQqLTRDn821RvKr0rjBDdb4IhJ4XQ
        RhGdp4ZZeW3Q1bBQ==
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
Date:   Sat, 27 Nov 2021 02:24:57 +0100 (CET)
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
YWRlCnRoaXMgc2VyaWVzIGV2ZW4gbGFyZ2VyIGFuZCBpcyBhbiBvcnRob2dvbmFsIGlzc3VlLgoK
VGhlIHNlcmllcyBpcyBiYXNlZCBvbjoKCiAgICAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS9saW51eC9rZXJuZWwvZ2l0L3RnbHgvZGV2ZWwuZ2l0IG1zaS12MS1wYXJ0LTMKCmFuZCBhbHNv
IGF2YWlsYWJsZSBmcm9tIGdpdDoKCiAgICAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L3RnbHgvZGV2ZWwuZ2l0IG1zaS12MS1wYXJ0LTQKClRoYW5rcywKCgl0
Z2x4Ci0tLQogYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wc2VyaWVzL21zaS5jIHwgICAgNiArLQog
YXJjaC94ODYva2VybmVsL2FwaWMvbXNpLmMgICAgICAgICAgIHwgICAgNCAtCiBhcmNoL3g4Ni9w
Y2kveGVuLmMgICAgICAgICAgICAgICAgICAgfCAgIDEwICstLQogZHJpdmVycy9iYXNlL3BsYXRm
b3JtLW1zaS5jICAgICAgICAgIHwgICAgMyAtCiBkcml2ZXJzL3BjaS9tc2kvaXJxZG9tYWluLmMg
ICAgICAgICAgfCAgIDM5ICsrKysrKysrKystLS0tCiBkcml2ZXJzL3BjaS9tc2kvbXNpLmMgICAg
ICAgICAgICAgICAgfCAgIDk3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tCiBk
cml2ZXJzL3BjaS9tc2kvbXNpLmggICAgICAgICAgICAgICAgfCAgICA0IC0KIGluY2x1ZGUvbGlu
dXgvbXNpLmggICAgICAgICAgICAgICAgICB8ICAgNDYgKysrKysrKysrKystLS0tLQogaW5jbHVk
ZS9saW51eC9wY2kuaCAgICAgICAgICAgICAgICAgIHwgICAxMyArKysrCiBrZXJuZWwvaXJxL21z
aS5jICAgICAgICAgICAgICAgICAgICAgfCAgIDc1ICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LQogMTAgZmlsZXMgY2hhbmdlZCwgMjA4IGluc2VydGlvbnMoKyksIDg5IGRlbGV0aW9ucygtKQo=
