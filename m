Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E071B3DAEF0
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 00:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbhG2Weq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 18:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbhG2Weq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jul 2021 18:34:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA0CC061765;
        Thu, 29 Jul 2021 15:34:42 -0700 (PDT)
Message-ID: <20210729215139.889204656@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627598079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=L1MWCB/mi8Eqvn+BCAxR2CLfHh9+meprPU/a+pwdFJI=;
        b=n9wU0n0IwY73C4bhFxrVJ+fQ9oHD8p/CqgAYBIjFv0vifHSlsriOBNs5wFlVahFsdeOygT
        XsmF+axvuuLpw4Rjb5vhvVGwdUofAQPrlCasuhQv+srhgT/T+HMXwBnrzlq1RkyJ+gRLBi
        Nv05CLGIgBA/ujcpaQWqpMiqcAFHDNvyPavcNymfntrqRV8gtV5u8SB/AM2YJ2T6lc1riH
        /E/rVGc94gDsYLGqj7QrvnO4FpmNS2HXLwYCYgiUmx1Xf3avmLkEHVbM+pkIzeXekKPMO+
        mjwbWkDU14dO7AELrDQq4RjPk+8YnWrJPaQ559fyslBi1QNHQXEs1qgZPDPjzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627598079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=L1MWCB/mi8Eqvn+BCAxR2CLfHh9+meprPU/a+pwdFJI=;
        b=VvDQJ9HSE98noTCMfJQ8qDwLaEYDJxTcUgeWpgg4nxyMomFzjmRbYrQerGxKtrhW8N01u6
        MdwcyOuIrbhHOnDg==
Date:   Thu, 29 Jul 2021 23:51:39 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-s390@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [patch V2 00/19] PCI/MSI, x86: Cure a couple of inconsistencies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

QSByZWNlbnQgZGlzY3Vzc2lvbiBhYm91dCB0aGUgUENJL01TSSBtYW5hZ2VtZW50IGZvciB2aXJ0
aW8gdW5lYXJ0aGVkIGEKdmlvbGF0aW9uIG9mIHRoZSBNU0ktWCBzcGVjaWZpY2F0aW9uIHZzLiB3
cml0aW5nIHRoZSBNU0ktWCBtZXNzYWdlOiB1bmRlcgpjZXJ0YWluIGNpcmN1bXN0YW5jZXMgdGhl
IGVudHJ5IGlzIHdyaXR0ZW4gd2l0aG91dCBiZWluZyBtYXNrZWQuCgpXaGlsZSBsb29raW5nIGF0
IHRoYXQgYW5kIHRoZSByZWxhdGVkIHZpb2xhdGlvbiBvZiB0aGUgeDg2IG5vbi1yZW1hcHBlZApp
bnRlcnJ1cHQgYWZmaW5pdHkgbWVjaGFuaXNtIGEgZmV3IG90aGVyIGlzc3VlcyB3ZXJlIGRpc2Nv
dmVyZWQgYnkKaW5zcGVjdGlvbi4KClRoZSBmb2xsb3dpbmcgc2VyaWVzIGFkZHJlc3NlcyB0aGVz
ZS4KCk5vdGUgdGhpcyBkb2VzIG5vdCBmaXggdGhlIHZpcnRpbyBpc3N1ZSwgYnV0IHdoaWxlIHN0
YXJpbmcgYXQgdGhlIGFib3ZlCnByb2JsZW1zIEkgY2FtZSB1cCB3aXRoIGEgcGxhbiB0byBhZGRy
ZXNzIHRoaXMuIEknbSBzdGlsbCB0cnlpbmcgdG8KY29udmluY2UgbXlzZWxmIHRoYXQgSSBjYW4g
Z2V0IGF3YXkgd2l0aG91dCBzcHJpbmtsaW5nIGxvY2tpbmcgYWxsIG92ZXIgdGhlCnBsYWNlLCBz
byBkb24ndCBob2xkIHlvdXIgYnJlYXRoIHRoYXQgdGhpcyB3aWxsIG1hdGVyaWFsaXplIHRvbW9y
cm93LgoKVGhlIHNlcmllcyBpcyBhbHNvIGF2YWlsYWJsZSBmcm9tIGdpdDoKCiAgICBnaXQ6Ly9n
aXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdGdseC9kZXZlbC5naXQgaXJx
L21zaQoKVjEgY2FuIGJlIGZvdW5kIGhlcmU6CgogICBodHRwczovL2xvcmUua2VybmVsLm9yZy9y
LzIwMjEwNzIxMTkxMTI2LjI3NDk0NjI4MEBsaW51dHJvbml4LmRlCgpDaGFuZ2VzIHZzLiBWMToK
CiAgLSBJZGVudGlmaWVkIGFuZCBhZGRyZXNzZWQgbW9yZSBpbmNvbnNpc3RlbmNpZXMsIGVzcGVj
aWFsbHkgdGhlIGxhY2sgb2YKICAgIHNlcmlhbGl6YXRpb24gZm9yIG11bHRpLU1TSSBtYXNraW5n
CiAgICAKICAtIFJlbW92ZWQgdGhlIGV4dHJhIHZlY3RvciBtYXNraW5nIGluIFMzOTAgCgogIC0g
QWRkcmVzc2VkIHJldmlldyBjb21tZW50cyBhbmQgcGlja2VkIHVwIHRhZ3Mgd2hlcmUgYXBwbGlj
YWJsZQoKICAtIENsZWFuIHVwIG9mIHRoZSBuYW1pbmcgb2YgbXNpX2Rlc2M6Om1hc2tlZCBhcyBk
aXNjdXNzZWQgaW4gdGhlIFYxCiAgICB0aHJlYWQKCiAgLSBDb25zb2xpZGF0aW9uIG9mIHRoZSBt
YXNrL3VubWFzayBmdW5jdGlvbnMKClRoYW5rcywKCgl0Z2x4Ci0tLQogYXJjaC9zMzkwL3BjaS9w
Y2lfaXJxLmMgICAgICAgIHwgICAgNCAKIGFyY2gveDg2L2tlcm5lbC9hcGljL2lvX2FwaWMuYyB8
ICAgIDYgCiBhcmNoL3g4Ni9rZXJuZWwvYXBpYy9tc2kuYyAgICAgfCAgIDExICsKIGFyY2gveDg2
L2tlcm5lbC9ocGV0LmMgICAgICAgICB8ICAgIDIgCiBkcml2ZXJzL2Jhc2UvY29yZS5jICAgICAg
ICAgICAgfCAgICAxIAogZHJpdmVycy9wY2kvbXNpLmMgICAgICAgICAgICAgIHwgIDI3NCArKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLQogaW5jbHVkZS9saW51eC9kZXZp
Y2UuaCAgICAgICAgIHwgICAgMSAKIGluY2x1ZGUvbGludXgvaXJxLmggICAgICAgICAgICB8ICAg
IDIgCiBpbmNsdWRlL2xpbnV4L21zaS5oICAgICAgICAgICAgfCAgIDEwIC0KIGtlcm5lbC9pcnEv
Y2hpcC5jICAgICAgICAgICAgICB8ICAgIDUgCiAxMCBmaWxlcyBjaGFuZ2VkLCAxNzggaW5zZXJ0
aW9ucygrKSwgMTM4IGRlbGV0aW9ucygtKQoKCg==
