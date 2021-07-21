Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596DB3D170F
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 21:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240071AbhGUSro (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 14:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237196AbhGUSrn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jul 2021 14:47:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A520C061575;
        Wed, 21 Jul 2021 12:28:19 -0700 (PDT)
Message-Id: <20210721191126.274946280@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626895698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dPPCs41If+VY2/qjy0QKxbaMgdjt6bNnqmwa5lYy4KM=;
        b=coWNqA4ca7VsXJh5hVoDbN/BR0PFGtxCfdm1T+ut9BCaPumN1KVCi2QX9H56c8PWfNbP/z
        YyP8TiOpWDbUg8AdHSK2E900RN6bLRZlTrLG+KUTd71LrYBmAhwSObh4jlGquvVqBAyujW
        AF44wDCfqBAoObRGcdyQO3wDogQOkLA1Xt6235aL0JIrkMruSpsEuPzElh2tMyiUscRzIN
        OZW3TwiLKqIokeOEXgSveyImkGZcq5xZBwLDX8icpdCk8xAVRSi/7Bix7arheGo2CdluXM
        wTfWDYTeaCJyBXm6peeusx/n7mVRhm473HoFUFNcyqGlJm7pqdr3Bcp109RX4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626895698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dPPCs41If+VY2/qjy0QKxbaMgdjt6bNnqmwa5lYy4KM=;
        b=3G6tiagdiwK1YmDo+isfRZDk4MQlfTdaCrUensxLJJdBPKHkroDbUH6E7Yi3EHH/faXCcm
        F8ehG32/9L665rDQ==
Date:   Wed, 21 Jul 2021 21:11:26 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
Subject: [patch 0/8] PCI/MSI, x86: Cure a couple of inconsistencies
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
L21zaQoKVGhhbmtzLAoKCXRnbHgKLS0tCiBhcmNoL3g4Ni9rZXJuZWwvYXBpYy9pb19hcGljLmMg
fCAgICA2ICstCiBhcmNoL3g4Ni9rZXJuZWwvYXBpYy9tc2kuYyAgICAgfCAgIDExICsrKy0KIGFy
Y2gveDg2L2tlcm5lbC9ocGV0LmMgICAgICAgICB8ICAgIDIgCiBkcml2ZXJzL3BjaS9tc2kuYyAg
ICAgICAgICAgICAgfCAgIDk4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LS0tCiBpbmNsdWRlL2xpbnV4L2lycS5oICAgICAgICAgICAgfCAgICAyIAoga2VybmVsL2lycS9j
aGlwLmMgICAgICAgICAgICAgIHwgICAgNSArLQogNiBmaWxlcyBjaGFuZ2VkLCA4NSBpbnNlcnRp
b25zKCspLCAzOSBkZWxldGlvbnMoLSkK
