Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127121FC9FF
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 11:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgFQJhv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Jun 2020 05:37:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30781 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726798AbgFQJhu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Jun 2020 05:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592386668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7MAdMlImgumCZT3LfGm29F+L+iTUaSnuaS5P4ZPaAz4=;
        b=SuR/U9qPNrwF5QSDM5jfQe+nDE7W+QCFlpvAsqR1FJHdia/AhR/hx/KWWNlyhODi/AUwOs
        /PSUwd6xeQEMKgNN5Dovm+rEbNpNosy5jxOVriby5wg5VK7yAQH6I5ZFGQqtMFzxb/sgix
        Fbkjh8GJqtP1gRnse/frykS2v04pJe8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-oikxqi3UO3CV5AoofoRoFg-1; Wed, 17 Jun 2020 05:37:45 -0400
X-MC-Unique: oikxqi3UO3CV5AoofoRoFg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3D6480B71D;
        Wed, 17 Jun 2020 09:37:43 +0000 (UTC)
Received: from localhost (ovpn-114-151.ams2.redhat.com [10.36.114.151])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7BA5D5C1D2;
        Wed, 17 Jun 2020 09:37:43 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcelo Tosatti <mtosatti@redhat.com>, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC 2/2] genirq/matrix: take NUMA into account for managed IRQs
Date:   Wed, 17 Jun 2020 10:37:25 +0100
Message-Id: <20200617093725.1725569-3-stefanha@redhat.com>
In-Reply-To: <20200617093725.1725569-1-stefanha@redhat.com>
References: <20200617093725.1725569-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

U2VsZWN0IENQVXMgZnJvbSB0aGUgSVJRJ3MgTlVNQSBub2RlIGluIHByZWZlcmVuY2Ugb3ZlciBv
dGhlciBDUFVzLiBUaGlzCmVuc3VyZXMgdGhhdCBtYW5hZ2VkIElSUXMgYXJlIGFzc2lnbmVkIHRv
IHRoZSBzYW1lIE5VTUEgbm9kZSBhcyB0aGUKZGV2aWNlLgoKU2lnbmVkLW9mZi1ieTogU3RlZmFu
IEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIGluY2x1ZGUvbGludXgvaXJxLmgg
ICAgICAgICAgIHwgIDIgKy0KIGFyY2gveDg2L2tlcm5lbC9hcGljL3ZlY3Rvci5jIHwgIDMgKyst
CiBrZXJuZWwvaXJxL21hdHJpeC5jICAgICAgICAgICB8IDE2ICsrKysrKysrKysrKy0tLS0KIDMg
ZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L2lycS5oIGIvaW5jbHVkZS9saW51eC9pcnEuaAppbmRleCA4ZDVi
YzJjMjM3ZDcuLmJkYzNmYWEzYzI4MCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9pcnEuaAor
KysgYi9pbmNsdWRlL2xpbnV4L2lycS5oCkBAIC0xMjAyLDcgKzEyMDIsNyBAQCB2b2lkIGlycV9t
YXRyaXhfYXNzaWduX3N5c3RlbShzdHJ1Y3QgaXJxX21hdHJpeCAqbSwgdW5zaWduZWQgaW50IGJp
dCwgYm9vbCByZXBsYQogaW50IGlycV9tYXRyaXhfcmVzZXJ2ZV9tYW5hZ2VkKHN0cnVjdCBpcnFf
bWF0cml4ICptLCBjb25zdCBzdHJ1Y3QgY3B1bWFzayAqbXNrKTsKIHZvaWQgaXJxX21hdHJpeF9y
ZW1vdmVfbWFuYWdlZChzdHJ1Y3QgaXJxX21hdHJpeCAqbSwgY29uc3Qgc3RydWN0IGNwdW1hc2sg
Km1zayk7CiBpbnQgaXJxX21hdHJpeF9hbGxvY19tYW5hZ2VkKHN0cnVjdCBpcnFfbWF0cml4ICpt
LCBjb25zdCBzdHJ1Y3QgY3B1bWFzayAqbXNrLAotCQkJCXVuc2lnbmVkIGludCAqbWFwcGVkX2Nw
dSk7CisJCQkgICAgIGludCBub2RlLCB1bnNpZ25lZCBpbnQgKm1hcHBlZF9jcHUpOwogdm9pZCBp
cnFfbWF0cml4X3Jlc2VydmUoc3RydWN0IGlycV9tYXRyaXggKm0pOwogdm9pZCBpcnFfbWF0cml4
X3JlbW92ZV9yZXNlcnZlZChzdHJ1Y3QgaXJxX21hdHJpeCAqbSk7CiBpbnQgaXJxX21hdHJpeF9h
bGxvYyhzdHJ1Y3QgaXJxX21hdHJpeCAqbSwgY29uc3Qgc3RydWN0IGNwdW1hc2sgKm1zaywKZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9hcGljL3ZlY3Rvci5jIGIvYXJjaC94ODYva2VybmVs
L2FwaWMvdmVjdG9yLmMKaW5kZXggNjc3NjhlNTQ0MzhiLi44ZWIxMGIwZDk4MWQgMTAwNjQ0Ci0t
LSBhL2FyY2gveDg2L2tlcm5lbC9hcGljL3ZlY3Rvci5jCisrKyBiL2FyY2gveDg2L2tlcm5lbC9h
cGljL3ZlY3Rvci5jCkBAIC0zMDksNiArMzA5LDcgQEAgYXNzaWduX21hbmFnZWRfdmVjdG9yKHN0
cnVjdCBpcnFfZGF0YSAqaXJxZCwgY29uc3Qgc3RydWN0IGNwdW1hc2sgKmRlc3QpCiB7CiAJY29u
c3Qgc3RydWN0IGNwdW1hc2sgKmFmZm1zayA9IGlycV9kYXRhX2dldF9hZmZpbml0eV9tYXNrKGly
cWQpOwogCXN0cnVjdCBhcGljX2NoaXBfZGF0YSAqYXBpY2QgPSBhcGljX2NoaXBfZGF0YShpcnFk
KTsKKwlpbnQgbm9kZSA9IGlycV9kYXRhX2dldF9ub2RlKGlycWQpOwogCWludCB2ZWN0b3IsIGNw
dTsKIAogCWNwdW1hc2tfYW5kKHZlY3Rvcl9zZWFyY2htYXNrLCBkZXN0LCBhZmZtc2spOwpAQCAt
MzE3LDcgKzMxOCw3IEBAIGFzc2lnbl9tYW5hZ2VkX3ZlY3RvcihzdHJ1Y3QgaXJxX2RhdGEgKmly
cWQsIGNvbnN0IHN0cnVjdCBjcHVtYXNrICpkZXN0KQogCWlmIChhcGljZC0+dmVjdG9yICYmIGNw
dW1hc2tfdGVzdF9jcHUoYXBpY2QtPmNwdSwgdmVjdG9yX3NlYXJjaG1hc2spKQogCQlyZXR1cm4g
MDsKIAl2ZWN0b3IgPSBpcnFfbWF0cml4X2FsbG9jX21hbmFnZWQodmVjdG9yX21hdHJpeCwgdmVj
dG9yX3NlYXJjaG1hc2ssCi0JCQkJCSAgJmNwdSk7CisJCQkJCSAgbm9kZSwgJmNwdSk7CiAJdHJh
Y2VfdmVjdG9yX2FsbG9jX21hbmFnZWQoaXJxZC0+aXJxLCB2ZWN0b3IsIHZlY3Rvcik7CiAJaWYg
KHZlY3RvciA8IDApCiAJCXJldHVybiB2ZWN0b3I7CmRpZmYgLS1naXQgYS9rZXJuZWwvaXJxL21h
dHJpeC5jIGIva2VybmVsL2lycS9tYXRyaXguYwppbmRleCAzMGNjMjE3Yjg2MzEuLmVlMzViNjE3
MmI2NCAxMDA2NDQKLS0tIGEva2VybmVsL2lycS9tYXRyaXguYworKysgYi9rZXJuZWwvaXJxL21h
dHJpeC5jCkBAIC0xNDgsNyArMTQ4LDggQEAgc3RhdGljIHVuc2lnbmVkIGludCBtYXRyaXhfZmlu
ZF9iZXN0X2NwdShzdHJ1Y3QgaXJxX21hdHJpeCAqbSwKIAogLyogRmluZCB0aGUgYmVzdCBDUFUg
d2hpY2ggaGFzIHRoZSBsb3dlc3QgbnVtYmVyIG9mIG1hbmFnZWQgSVJRcyBhbGxvY2F0ZWQgKi8K
IHN0YXRpYyB1bnNpZ25lZCBpbnQgbWF0cml4X2ZpbmRfYmVzdF9jcHVfbWFuYWdlZChzdHJ1Y3Qg
aXJxX21hdHJpeCAqbSwKLQkJCQkJCWNvbnN0IHN0cnVjdCBjcHVtYXNrICptc2spCisJCQkJCQkg
Y29uc3Qgc3RydWN0IGNwdW1hc2sgKm1zaywKKwkJCQkJCSBpbnQgbm9kZSkKIHsKIAl1bnNpZ25l
ZCBpbnQgY3B1LCBiZXN0X2NwdSwgYWxsb2NhdGVkID0gVUlOVF9NQVg7CiAJc3RydWN0IGNwdW1h
cCAqY207CkBAIC0xNTYsNiArMTU3LDkgQEAgc3RhdGljIHVuc2lnbmVkIGludCBtYXRyaXhfZmlu
ZF9iZXN0X2NwdV9tYW5hZ2VkKHN0cnVjdCBpcnFfbWF0cml4ICptLAogCWJlc3RfY3B1ID0gVUlO
VF9NQVg7CiAKIAlmb3JfZWFjaF9jcHUoY3B1LCBtc2spIHsKKwkJaWYgKG5vZGUgIT0gTlVNQV9O
T19OT0RFICYmIGNwdV90b19ub2RlKGNwdSkgIT0gbm9kZSkKKwkJCWNvbnRpbnVlOworCiAJCWNt
ID0gcGVyX2NwdV9wdHIobS0+bWFwcywgY3B1KTsKIAogCQlpZiAoIWNtLT5vbmxpbmUgfHwgY20t
Pm1hbmFnZWRfYWxsb2NhdGVkID4gYWxsb2NhdGVkKQpAQCAtMjgwLDEwICsyODQsMTIgQEAgdm9p
ZCBpcnFfbWF0cml4X3JlbW92ZV9tYW5hZ2VkKHN0cnVjdCBpcnFfbWF0cml4ICptLCBjb25zdCBz
dHJ1Y3QgY3B1bWFzayAqbXNrKQogLyoqCiAgKiBpcnFfbWF0cml4X2FsbG9jX21hbmFnZWQgLSBB
bGxvY2F0ZSBhIG1hbmFnZWQgaW50ZXJydXB0IGluIGEgQ1BVIG1hcAogICogQG06CQlNYXRyaXgg
cG9pbnRlcgotICogQGNwdToJT24gd2hpY2ggQ1BVIHRoZSBpbnRlcnJ1cHQgc2hvdWxkIGJlIGFs
bG9jYXRlZAorICogQG1hc2s6CVRoZSBtYXNrIG9mIENQVXMgb24gd2hpY2ggdGhlIGludGVycnVw
dCBjYW4gYmUgYWxsb2NhdGVkCisgKiBAbm9kZToJVGhlIHByZWZlcnJlZCBOVU1BIG5vZGUKKyAq
IEBtYXBwZWRfY3B1OglUaGUgcmVzdWx0aW5nIENQVSBvbiB3aGljaCB0aGUgaW50ZXJydXB0IHNo
b3VsZCBiZSBhbGxvY2F0ZWQKICAqLwogaW50IGlycV9tYXRyaXhfYWxsb2NfbWFuYWdlZChzdHJ1
Y3QgaXJxX21hdHJpeCAqbSwgY29uc3Qgc3RydWN0IGNwdW1hc2sgKm1zaywKLQkJCSAgICAgdW5z
aWduZWQgaW50ICptYXBwZWRfY3B1KQorCQkJICAgICBpbnQgbm9kZSwgdW5zaWduZWQgaW50ICpt
YXBwZWRfY3B1KQogewogCXVuc2lnbmVkIGludCBiaXQsIGNwdSwgZW5kID0gbS0+YWxsb2NfZW5k
OwogCXN0cnVjdCBjcHVtYXAgKmNtOwpAQCAtMjkxLDcgKzI5Nyw5IEBAIGludCBpcnFfbWF0cml4
X2FsbG9jX21hbmFnZWQoc3RydWN0IGlycV9tYXRyaXggKm0sIGNvbnN0IHN0cnVjdCBjcHVtYXNr
ICptc2ssCiAJaWYgKGNwdW1hc2tfZW1wdHkobXNrKSkKIAkJcmV0dXJuIC1FSU5WQUw7CiAKLQlj
cHUgPSBtYXRyaXhfZmluZF9iZXN0X2NwdV9tYW5hZ2VkKG0sIG1zayk7CisJY3B1ID0gbWF0cml4
X2ZpbmRfYmVzdF9jcHVfbWFuYWdlZChtLCBtc2ssIG5vZGUpOworCWlmIChjcHUgPT0gVUlOVF9N
QVgpCisJCWNwdSA9IG1hdHJpeF9maW5kX2Jlc3RfY3B1X21hbmFnZWQobSwgbXNrLCBOVU1BX05P
X05PREUpOwogCWlmIChjcHUgPT0gVUlOVF9NQVgpCiAJCXJldHVybiAtRU5PU1BDOwogCi0tIAoy
LjI2LjIKCg==

