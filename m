Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA5F4AB1C
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 21:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbfFRToM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 15:44:12 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41771 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730189AbfFRToM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2019 15:44:12 -0400
Received: by mail-ot1-f66.google.com with SMTP id 107so16687215otj.8
        for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2019 12:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lWeoQffD9ULTiTlyWHRUgEl3LLxJ/1SEB3UmhnFdNVc=;
        b=HBM18VPXHIC97mbLA+LtY3CIlBwNWPFZh/XoVx5V3O56HGcLOwYjjgGO1PCDnbVpDc
         WuU8ZDq2UjT5VxR4klcAB/lbVRwJ0Z9ei+7ASbtZTF9eoDvBooNqgG4Cn7b0fuW7CjTF
         tjaPfRs8CiVIRv+lH1b32DeFE6GrR8lZUQVBLu7ROfno0v4YRmMIO57Ecxyn/H1ZBXWv
         x5WqNsR4Y/xpS8+RU0wqIjPMvyzhezRAZFOBqwNX2yAIZCUzqW7J36ZwySrmdeosgciw
         9qQOkEYFUoFGBQz/HfT+wqA9YYfTgjxDdiIQfwbk3QkFIUp0slBDktARnSOPSBIAzdUu
         VMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lWeoQffD9ULTiTlyWHRUgEl3LLxJ/1SEB3UmhnFdNVc=;
        b=hI6M5AwHFlgU+Ud7wBsBZwJxxaDfkYqyl5t/hd5sQXV4V6Sfy8bK+Zwh7Peg7M4vDM
         hbdmjvrpCSZ5LvnnXtjAZb1vPBBbkKSIA//PmPT3G1I1KeDeUZP2S3uNTJoVFp5s5uhu
         oY1P1j6myADVy3QKVj+M4kGKiQ9N63Fljp4nC1FqF9obUvTkuVYtRXPgncwPspE1C4OO
         +GzW4gAutQoXRT0d60ANJd+fN27oH3qNDJi4Ti/bVNaELk87bXsOaXzIPktUCU/xJfq+
         yJlCq1akht4ebebESs6HegDNR9J7rgCR5ab7DVsvF5LEOA4T8XW9amcAB46mnwVWwbA8
         Ip1g==
X-Gm-Message-State: APjAAAXktTltgprMS9WDFgqgcwjtCaPGUsKjT3wmV6vFcAjGHXeMxhpo
        z7TyYRqvL+CjdgGWjHq4n6Tj2sU88D5gWmsIMshKgw==
X-Google-Smtp-Source: APXvYqzvEbAUxmiQsuBWOyCSPoJJ82/NJ4V945yWJ3d7PH0Xyc52nRxuIrMvp5YF3AqD0GfjC1CQKPjmX1N5IlCt5jk=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr817279otn.247.1560887051616;
 Tue, 18 Jun 2019 12:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190617122733.22432-1-hch@lst.de> <20190617122733.22432-16-hch@lst.de>
In-Reply-To: <20190617122733.22432-16-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 18 Jun 2019 12:43:59 -0700
Message-ID: <CAPcyv4iwawKnG4jQtcNWNtXQeH3PYG6iWc6JV59DnyixmwDEcg@mail.gmail.com>
Subject: Re: [PATCH 15/25] device-dax: use the dev_pagemap internal refcount
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, Linux MM <linux-mm@kvack.org>,
        nouveau@lists.freedesktop.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000003f3c23058b9e5615"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--0000000000003f3c23058b9e5615
Content-Type: text/plain; charset="UTF-8"

On Mon, Jun 17, 2019 at 5:28 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The functionality is identical to the one currently open coded in
> device-dax.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/dax/dax-private.h |  4 ----
>  drivers/dax/device.c      | 43 ---------------------------------------
>  2 files changed, 47 deletions(-)

This needs the mock devm_memremap_pages() to setup the common
percpu_ref. Incremental patch attached:

--0000000000003f3c23058b9e5615
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-tools-testing-nvdimm-Support-the-internal-ref-of-dev.patch"
Content-Disposition: attachment; 
	filename="0001-tools-testing-nvdimm-Support-the-internal-ref-of-dev.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jx27u7050>
X-Attachment-Id: f_jx27u7050

RnJvbSA4NzVlNzE0ODljODQ4NTQ0OGE1YjdkZjJkOGE4YjJlZDc3ZDJiNTU1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNv
bT4KRGF0ZTogVHVlLCAxOCBKdW4gMjAxOSAxMTo1ODoyNCAtMDcwMApTdWJqZWN0OiBbUEFUQ0hd
IHRvb2xzL3Rlc3RpbmcvbnZkaW1tOiBTdXBwb3J0IHRoZSAnaW50ZXJuYWwnIHJlZiBvZgogZGV2
X3BhZ2VtYXAKCkZvciB1c2VycyBvZiB0aGUgY29tbW9uIHBlcmNwdS1yZWYgaW1wbGVtZW50YXRp
b24sIGxpa2UgZGV2aWNlLWRheCwKYXJyYW5nZSBmb3IgbmZpdF90ZXN0IHRvIGluaXRpYWxpemUg
dGhlIGNvbW1vbiBwYXJhbWV0ZXJzLgoKU2lnbmVkLW9mZi1ieTogRGFuIFdpbGxpYW1zIDxkYW4u
ai53aWxsaWFtc0BpbnRlbC5jb20+Ci0tLQogdG9vbHMvdGVzdGluZy9udmRpbW0vdGVzdC9pb21h
cC5jIHwgNDEgKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQs
IDMyIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVz
dGluZy9udmRpbW0vdGVzdC9pb21hcC5jIGIvdG9vbHMvdGVzdGluZy9udmRpbW0vdGVzdC9pb21h
cC5jCmluZGV4IDNiYzFjMTZjNGVmOS4uOTAxOWRkOGFmYmMxIDEwMDY0NAotLS0gYS90b29scy90
ZXN0aW5nL252ZGltbS90ZXN0L2lvbWFwLmMKKysrIGIvdG9vbHMvdGVzdGluZy9udmRpbW0vdGVz
dC9pb21hcC5jCkBAIC0xMDgsOCArMTA4LDYgQEAgc3RhdGljIHZvaWQgbmZpdF90ZXN0X2tpbGwo
dm9pZCAqX3BnbWFwKQogewogCXN0cnVjdCBkZXZfcGFnZW1hcCAqcGdtYXAgPSBfcGdtYXA7CiAK
LQlXQVJOX09OKCFwZ21hcCB8fCAhcGdtYXAtPnJlZik7Ci0KIAlpZiAocGdtYXAtPm9wcyAmJiBw
Z21hcC0+b3BzLT5raWxsKQogCQlwZ21hcC0+b3BzLT5raWxsKHBnbWFwKTsKIAllbHNlCkBAIC0x
MjMsMjAgKzEyMSw0NSBAQCBzdGF0aWMgdm9pZCBuZml0X3Rlc3Rfa2lsbCh2b2lkICpfcGdtYXAp
CiAJfQogfQogCitzdGF0aWMgdm9pZCBkZXZfcGFnZW1hcF9wZXJjcHVfcmVsZWFzZShzdHJ1Y3Qg
cGVyY3B1X3JlZiAqcmVmKQoreworCXN0cnVjdCBkZXZfcGFnZW1hcCAqcGdtYXAgPQorCQljb250
YWluZXJfb2YocmVmLCBzdHJ1Y3QgZGV2X3BhZ2VtYXAsIGludGVybmFsX3JlZik7CisKKwljb21w
bGV0ZSgmcGdtYXAtPmRvbmUpOworfQorCiB2b2lkICpfX3dyYXBfZGV2bV9tZW1yZW1hcF9wYWdl
cyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZfcGFnZW1hcCAqcGdtYXApCiB7CisJaW50
IGVycm9yOwogCXJlc291cmNlX3NpemVfdCBvZmZzZXQgPSBwZ21hcC0+cmVzLnN0YXJ0OwogCXN0
cnVjdCBuZml0X3Rlc3RfcmVzb3VyY2UgKm5maXRfcmVzID0gZ2V0X25maXRfcmVzKG9mZnNldCk7
CiAKLQlpZiAobmZpdF9yZXMpIHsKLQkJaW50IHJjOworCWlmICghbmZpdF9yZXMpCisJCXJldHVy
biBkZXZtX21lbXJlbWFwX3BhZ2VzKGRldiwgcGdtYXApOwogCi0JCXJjID0gZGV2bV9hZGRfYWN0
aW9uX29yX3Jlc2V0KGRldiwgbmZpdF90ZXN0X2tpbGwsIHBnbWFwKTsKLQkJaWYgKHJjKQotCQkJ
cmV0dXJuIEVSUl9QVFIocmMpOwotCQlyZXR1cm4gbmZpdF9yZXMtPmJ1ZiArIG9mZnNldCAtIG5m
aXRfcmVzLT5yZXMuc3RhcnQ7CisJcGdtYXAtPmRldiA9IGRldjsKKwlpZiAoIXBnbWFwLT5yZWYp
IHsKKwkJaWYgKHBnbWFwLT5vcHMgJiYgKHBnbWFwLT5vcHMtPmtpbGwgfHwgcGdtYXAtPm9wcy0+
Y2xlYW51cCkpCisJCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsKKworCQlpbml0X2NvbXBsZXRp
b24oJnBnbWFwLT5kb25lKTsKKwkJZXJyb3IgPSBwZXJjcHVfcmVmX2luaXQoJnBnbWFwLT5pbnRl
cm5hbF9yZWYsCisJCQkJZGV2X3BhZ2VtYXBfcGVyY3B1X3JlbGVhc2UsIDAsIEdGUF9LRVJORUwp
OworCQlpZiAoZXJyb3IpCisJCQlyZXR1cm4gRVJSX1BUUihlcnJvcik7CisJCXBnbWFwLT5yZWYg
PSAmcGdtYXAtPmludGVybmFsX3JlZjsKKwl9IGVsc2UgeworCQlpZiAoIXBnbWFwLT5vcHMgfHwg
IXBnbWFwLT5vcHMtPmtpbGwgfHwgIXBnbWFwLT5vcHMtPmNsZWFudXApIHsKKwkJCVdBUk4oMSwg
Ik1pc3NpbmcgcmVmZXJlbmNlIGNvdW50IHRlYXJkb3duIGRlZmluaXRpb25cbiIpOworCQkJcmV0
dXJuIEVSUl9QVFIoLUVJTlZBTCk7CisJCX0KIAl9Ci0JcmV0dXJuIGRldm1fbWVtcmVtYXBfcGFn
ZXMoZGV2LCBwZ21hcCk7CisKKwllcnJvciA9IGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldChkZXYs
IG5maXRfdGVzdF9raWxsLCBwZ21hcCk7CisJaWYgKGVycm9yKQorCQlyZXR1cm4gRVJSX1BUUihl
cnJvcik7CisJcmV0dXJuIG5maXRfcmVzLT5idWYgKyBvZmZzZXQgLSBuZml0X3Jlcy0+cmVzLnN0
YXJ0OwogfQogRVhQT1JUX1NZTUJPTF9HUEwoX193cmFwX2Rldm1fbWVtcmVtYXBfcGFnZXMpOwog
Ci0tIAoyLjIwLjEKCg==
--0000000000003f3c23058b9e5615--
