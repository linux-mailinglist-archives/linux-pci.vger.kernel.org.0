Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30741625BB5
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbiKKN4I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbiKKNzn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:55:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF487BE68;
        Fri, 11 Nov 2022 05:54:47 -0800 (PST)
Message-ID: <20221111122014.696798036@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=5KmJKzZwAqMF//R5CEolBMOEBU8yD776C3UNuDuLpFo=;
        b=aW9aT9GTxHiSQ01KmcKcVAR5Gtgm712AnUUjXcf/UAU+la1n84AAR2UKavCv+FV0EdOi0K
        GE+J5zNuoTimGlHv/TN11mzW0TcFOY96fSWBMrIxXfggJTwyt7FmyztYuREP2otV0Z2jLQ
        IelQtk6sZZ09STPmn+MIp6DLZcrUKcdLoJC25gD9iFwF8u9f1XqLIDyLpy7cr5fGjczJhJ
        T0cZWHq3/mtFCYeSlRoCya3GS0B8WNJMTYLwfLgvdnUTK1rPDUwOOh/5qYA5cT6J2+QM6v
        TVcpvC5MGQKsQcE/3PRdo4upSRBHB9Fu/+qY/awa/RURaoefAG4DEOKwiugMBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=5KmJKzZwAqMF//R5CEolBMOEBU8yD776C3UNuDuLpFo=;
        b=JuaZZ0BRz9HXURKAI+Kmjfz/8OWWG3gRuOmSlo8r2Ql9shwrIORF/7ph03FmrEt4obqVVr
        pkNOSQC7YlHDVyCg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: [patch 19/39] PCI/MSI: Move pci_disable_msi() to api.c
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Fri, 11 Nov 2022 14:54:45 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogQWhtZWQgUy4gRGFyd2lzaCA8ZGFyd2lAbGludXRyb25peC5kZT4KCm1zaS5jIGlzIGEg
bWF6ZSBvZiByYW5kb21seSBzb3J0ZWQgZnVuY3Rpb25zIHdoaWNoIG1ha2VzIHRoZSBjb2RlCnVu
cmVhZGFibGUuIEFzIGEgZmlyc3Qgc3RlcCBzcGxpdCB0aGUgZHJpdmVyIHZpc2libGUgQVBJIGFu
ZCB0aGUgaW50ZXJuYWwKaW1wbGVtZW50YXRpb24gd2hpY2ggYWxzbyBhbGxvd3MgcHJvcGVyIEFQ
SSBkb2N1bWVudGF0aW9uIHZpYSBvbmUgZmlsZS4KCkNyZWF0ZSBkcml2ZXJzL3BjaS9tc2kvYXBp
LmMgdG8gZ3JvdXAgYWxsIGV4cG9ydGVkIGRldmljZS1kcml2ZXIgUENJL01TSQpBUElzIGluIG9u
ZSBDIGZpbGUuCgpCZWdpbiBieSBtb3ZpbmcgcGNpX2Rpc2FibGVfbXNpKCkgdGhlcmUgYW5kIGFk
ZCBrZXJuZWwtZG9jIGZvciB0aGUgZnVuY3Rpb24KYXMgYXBwcm9wcmlhdGUuCgpTdWdnZXN0ZWQt
Ynk6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPgpTaWduZWQtb2ZmLWJ5OiBB
aG1lZCBTLiBEYXJ3aXNoIDxkYXJ3aUBsaW51dHJvbml4LmRlPgpTaWduZWQtb2ZmLWJ5OiBUaG9t
YXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4KCi0tLQogZHJpdmVycy9wY2kvbXNpL01h
a2VmaWxlIHwgIDMgKy0tCiBkcml2ZXJzL3BjaS9tc2kvYXBpLmMgICAgfCAzNyArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrCiBkcml2ZXJzL3BjaS9tc2kvbXNpLmMgICAgfCAy
MiArKysrKy0tLS0tLS0tLS0tLS0tLS0tCiBkcml2ZXJzL3BjaS9tc2kvbXNpLmggICAgfCAgNCAr
KysrCiA0IGZpbGVzIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL21zaS9hcGkuYwotLS0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcGNpL21zaS9NYWtlZmlsZSBiL2RyaXZlcnMvcGNpL21zaS9NYWtlZmlsZQppbmRl
eCA0ZTBhN2UwNzk2NWUuLjgzOWZmNzJkNzJhOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kvbXNp
L01ha2VmaWxlCisrKyBiL2RyaXZlcnMvcGNpL21zaS9NYWtlZmlsZQpAQCAtMiw2ICsyLDUgQEAK
ICMKICMgTWFrZWZpbGUgZm9yIHRoZSBQQ0kvTVNJCiBvYmotJChDT05GSUdfUENJKQkJCSs9IHBj
aWRldl9tc2kubwotb2JqLSQoQ09ORklHX1BDSV9NU0kpCQkJKz0gbXNpLm8KLW9iai0kKENPTkZJ
R19QQ0lfTVNJKQkJCSs9IGlycWRvbWFpbi5vCitvYmotJChDT05GSUdfUENJX01TSSkJCQkrPSBh
cGkubyBtc2kubyBpcnFkb21haW4ubwogb2JqLSQoQ09ORklHX1BDSV9NU0lfQVJDSF9GQUxMQkFD
S1MpCSs9IGxlZ2FjeS5vCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9tc2kvYXBpLmMgYi9kcml2
ZXJzL3BjaS9tc2kvYXBpLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAw
Li43NDg1OTQyY2JlNWQKLS0tIC9kZXYvbnVsbAorKysgYi9kcml2ZXJzL3BjaS9tc2kvYXBpLmMK
QEAgLTAsMCArMSwzNyBAQAorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKKy8q
CisgKiBQQ0kgTVNJL01TSS1YIOKAlCBFeHBvcnRlZCBBUElzIGZvciBkZXZpY2UgZHJpdmVycwor
ICoKKyAqIENvcHlyaWdodCAoQykgMjAwMy0yMDA0IEludGVsCisgKiBDb3B5cmlnaHQgKEMpIFRv
bSBMb25nIE5ndXllbiAodG9tLmwubmd1eWVuQGludGVsLmNvbSkKKyAqIENvcHlyaWdodCAoQykg
MjAxNiBDaHJpc3RvcGggSGVsbHdpZy4KKyAqIENvcHlyaWdodCAoQykgMjAyMiBMaW51dHJvbml4
IEdtYkgKKyAqLworCisjaW5jbHVkZSA8bGludXgvZXhwb3J0Lmg+CisKKyNpbmNsdWRlICJtc2ku
aCIKKworLyoqCisgKiBwY2lfZGlzYWJsZV9tc2koKSAtIERpc2FibGUgTVNJIGludGVycnVwdCBt
b2RlIG9uIGRldmljZQorICogQGRldjogdGhlIFBDSSBkZXZpY2UgdG8gb3BlcmF0ZSBvbgorICoK
KyAqIExlZ2FjeSBkZXZpY2UgZHJpdmVyIEFQSSB0byBkaXNhYmxlIE1TSSBpbnRlcnJ1cHQgbW9k
ZSBvbiBkZXZpY2UsCisgKiBmcmVlIGVhcmxpZXIgYWxsb2NhdGVkIGludGVycnVwdCB2ZWN0b3Jz
LCBhbmQgcmVzdG9yZSBJTlR4IGVtdWxhdGlvbi4KKyAqIFRoZSBQQ0kgZGV2aWNlIExpbnV4IElS
USAoQGRldi0+aXJxKSBpcyByZXN0b3JlZCB0byBpdHMgZGVmYXVsdAorICogcGluLWFzc2VydGlv
biBJUlEuIFRoaXMgaXMgdGhlIGNsZWFudXAgcGFpciBvZiBwY2lfZW5hYmxlX21zaSgpLgorICoK
KyAqIE5PVEU6IFRoZSBuZXdlciBwY2lfYWxsb2NfaXJxX3ZlY3RvcnMoKSAvIHBjaV9mcmVlX2ly
cV92ZWN0b3JzKCkgQVBJCisgKiBwYWlyIHNob3VsZCwgaW4gZ2VuZXJhbCwgYmUgdXNlZCBpbnN0
ZWFkLgorICovCit2b2lkIHBjaV9kaXNhYmxlX21zaShzdHJ1Y3QgcGNpX2RldiAqZGV2KQorewor
CWlmICghcGNpX21zaV9lbmFibGVkKCkgfHwgIWRldiB8fCAhZGV2LT5tc2lfZW5hYmxlZCkKKwkJ
cmV0dXJuOworCisJbXNpX2xvY2tfZGVzY3MoJmRldi0+ZGV2KTsKKwlwY2lfbXNpX3NodXRkb3du
KGRldik7CisJcGNpX2ZyZWVfbXNpX2lycXMoZGV2KTsKKwltc2lfdW5sb2NrX2Rlc2NzKCZkZXYt
PmRldik7Cit9CitFWFBPUlRfU1lNQk9MKHBjaV9kaXNhYmxlX21zaSk7CmRpZmYgLS1naXQgYS9k
cml2ZXJzL3BjaS9tc2kvbXNpLmMgYi9kcml2ZXJzL3BjaS9tc2kvbXNpLmMKaW5kZXggNWMzMTBk
ZjU1ZDBkLi40YTEzMDBiNzQ1MTggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGNpL21zaS9tc2kuYwor
KysgYi9kcml2ZXJzL3BjaS9tc2kvbXNpLmMKQEAgLTE2Myw3ICsxNjMsNyBAQCB2b2lkIHBjaV93
cml0ZV9tc2lfbXNnKHVuc2lnbmVkIGludCBpcnEsIHN0cnVjdCBtc2lfbXNnICptc2cpCiB9CiBF
WFBPUlRfU1lNQk9MX0dQTChwY2lfd3JpdGVfbXNpX21zZyk7CiAKLXN0YXRpYyB2b2lkIGZyZWVf
bXNpX2lycXMoc3RydWN0IHBjaV9kZXYgKmRldikKK3ZvaWQgcGNpX2ZyZWVfbXNpX2lycXMoc3Ry
dWN0IHBjaV9kZXYgKmRldikKIHsKIAlwY2lfbXNpX3RlYXJkb3duX21zaV9pcnFzKGRldik7CiAK
QEAgLTQxMyw3ICs0MTMsNyBAQCBzdGF0aWMgaW50IG1zaV9jYXBhYmlsaXR5X2luaXQoc3RydWN0
IHBjaV9kZXYgKmRldiwgaW50IG52ZWMsCiAKIGVycjoKIAlwY2lfbXNpX3VubWFzayhlbnRyeSwg
bXNpX211bHRpX21hc2soZW50cnkpKTsKLQlmcmVlX21zaV9pcnFzKGRldik7CisJcGNpX2ZyZWVf
bXNpX2lycXMoZGV2KTsKIGZhaWw6CiAJZGV2LT5tc2lfZW5hYmxlZCA9IDA7CiB1bmxvY2s6CkBA
IC01MzEsNyArNTMxLDcgQEAgc3RhdGljIGludCBtc2l4X3NldHVwX2ludGVycnVwdHMoc3RydWN0
IHBjaV9kZXYgKmRldiwgdm9pZCBfX2lvbWVtICpiYXNlLAogCWdvdG8gb3V0X3VubG9jazsKIAog
b3V0X2ZyZWU6Ci0JZnJlZV9tc2lfaXJxcyhkZXYpOworCXBjaV9mcmVlX21zaV9pcnFzKGRldik7
CiBvdXRfdW5sb2NrOgogCW1zaV91bmxvY2tfZGVzY3MoJmRldi0+ZGV2KTsKIAlrZnJlZShtYXNr
cyk7CkBAIC02ODAsNyArNjgwLDcgQEAgaW50IHBjaV9tc2lfdmVjX2NvdW50KHN0cnVjdCBwY2lf
ZGV2ICpkZXYpCiB9CiBFWFBPUlRfU1lNQk9MKHBjaV9tc2lfdmVjX2NvdW50KTsKIAotc3RhdGlj
IHZvaWQgcGNpX21zaV9zaHV0ZG93bihzdHJ1Y3QgcGNpX2RldiAqZGV2KQordm9pZCBwY2lfbXNp
X3NodXRkb3duKHN0cnVjdCBwY2lfZGV2ICpkZXYpCiB7CiAJc3RydWN0IG1zaV9kZXNjICpkZXNj
OwogCkBAIC03MDEsMTggKzcwMSw2IEBAIHN0YXRpYyB2b2lkIHBjaV9tc2lfc2h1dGRvd24oc3Ry
dWN0IHBjaV9kZXYgKmRldikKIAlwY2liaW9zX2FsbG9jX2lycShkZXYpOwogfQogCi12b2lkIHBj
aV9kaXNhYmxlX21zaShzdHJ1Y3QgcGNpX2RldiAqZGV2KQotewotCWlmICghcGNpX21zaV9lbmFi
bGUgfHwgIWRldiB8fCAhZGV2LT5tc2lfZW5hYmxlZCkKLQkJcmV0dXJuOwotCi0JbXNpX2xvY2tf
ZGVzY3MoJmRldi0+ZGV2KTsKLQlwY2lfbXNpX3NodXRkb3duKGRldik7Ci0JZnJlZV9tc2lfaXJx
cyhkZXYpOwotCW1zaV91bmxvY2tfZGVzY3MoJmRldi0+ZGV2KTsKLX0KLUVYUE9SVF9TWU1CT0wo
cGNpX2Rpc2FibGVfbXNpKTsKLQogLyoqCiAgKiBwY2lfbXNpeF92ZWNfY291bnQgLSByZXR1cm4g
dGhlIG51bWJlciBvZiBkZXZpY2UncyBNU0ktWCB0YWJsZSBlbnRyaWVzCiAgKiBAZGV2OiBwb2lu
dGVyIHRvIHRoZSBwY2lfZGV2IGRhdGEgc3RydWN0dXJlIG9mIE1TSS1YIGRldmljZSBmdW5jdGlv
bgpAQCAtNzk3LDcgKzc4NSw3IEBAIHZvaWQgcGNpX2Rpc2FibGVfbXNpeChzdHJ1Y3QgcGNpX2Rl
diAqZGV2KQogCiAJbXNpX2xvY2tfZGVzY3MoJmRldi0+ZGV2KTsKIAlwY2lfbXNpeF9zaHV0ZG93
bihkZXYpOwotCWZyZWVfbXNpX2lycXMoZGV2KTsKKwlwY2lfZnJlZV9tc2lfaXJxcyhkZXYpOwog
CW1zaV91bmxvY2tfZGVzY3MoJmRldi0+ZGV2KTsKIH0KIEVYUE9SVF9TWU1CT0wocGNpX2Rpc2Fi
bGVfbXNpeCk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9tc2kvbXNpLmggYi9kcml2ZXJzL3Bj
aS9tc2kvbXNpLmgKaW5kZXggZDhmNjJkOTExZjA4Li42MzQ4NzkyNzczNDkgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvcGNpL21zaS9tc2kuaAorKysgYi9kcml2ZXJzL3BjaS9tc2kvbXNpLmgKQEAgLTg0
LDYgKzg0LDEwIEBAIHN0YXRpYyBpbmxpbmUgX19hdHRyaWJ1dGVfY29uc3RfXyB1MzIgbXNpX211
bHRpX21hc2soc3RydWN0IG1zaV9kZXNjICpkZXNjKQogCXJldHVybiAoMSA8PCAoMSA8PCBkZXNj
LT5wY2kubXNpX2F0dHJpYi5tdWx0aV9jYXApKSAtIDE7CiB9CiAKKy8qIE1TSSBpbnRlcm5hbCBm
dW5jdGlvbnMgaW52b2tlZCBmcm9tIHRoZSBwdWJsaWMgQVBJcyAqLwordm9pZCBwY2lfbXNpX3No
dXRkb3duKHN0cnVjdCBwY2lfZGV2ICpkZXYpOwordm9pZCBwY2lfZnJlZV9tc2lfaXJxcyhzdHJ1
Y3QgcGNpX2RldiAqZGV2KTsKKwogLyogTGVnYWN5ICghSVJRRE9NQUlOKSBmYWxsYmFja3MgKi8K
ICNpZmRlZiBDT05GSUdfUENJX01TSV9BUkNIX0ZBTExCQUNLUwogaW50IHBjaV9tc2lfbGVnYWN5
X3NldHVwX21zaV9pcnFzKHN0cnVjdCBwY2lfZGV2ICpkZXYsIGludCBudmVjLCBpbnQgdHlwZSk7
Cgo=
