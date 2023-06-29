Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EE6742EAE
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jun 2023 22:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjF2UnG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 16:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjF2UnE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jun 2023 16:43:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A2F2D4A
        for <linux-pci@vger.kernel.org>; Thu, 29 Jun 2023 13:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688071334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5xLUGx3Pr16QggBwM/nDREyvFR1ZE9/fpWNsWIVXh0E=;
        b=TfsMunBRaU1qczGp2F6sQqJ4I2hFehKELbmTTihAQDDLZbVaScRiG/yFthXllj1wI0l+ax
        uPK2wlIbM2+WaaeX0Gyj7k6OjXsRhqb2TxBgQwzxbuvkGNQSrPiW7RRAkv2kllV2mcxg2h
        MUihpvwg4aBcu13S9EzvTASnFStERQE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-8wrKWaXLN0eh0gVzbFBgdg-1; Thu, 29 Jun 2023 16:42:10 -0400
X-MC-Unique: 8wrKWaXLN0eh0gVzbFBgdg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-763a36c3447so107653085a.3
        for <linux-pci@vger.kernel.org>; Thu, 29 Jun 2023 13:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688071330; x=1690663330;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5xLUGx3Pr16QggBwM/nDREyvFR1ZE9/fpWNsWIVXh0E=;
        b=QaNKgYU86mQyiVp8c2OA1iUCBJ/bKgoQyPXAYEPHedMX2h+ksszUrAjjSaTFkB63UA
         KxaNyKLKktnmdArG88/p7EBtGtFYlZlHNHQf/90VyEKrgUphsTF1GfDfTOI1BIEyhhrK
         fAhgKyGsfpufytBSY/1y1YjOS8QpRpKYKeNJfncVWAnWn7n69pnaxGP69oYkUqrpyVed
         84DjBQTSrXWm0MD6y39ETOIAIoJtRpPbACVkjvI9Wv55vSJje0x8NKu7EuTGL4EkQHLb
         d92y0rmX3SrRCESfuQpom0LMNLTNprT/Cf7YGfP3GFt/oAsnjruZRChPkdZOvF4eRfGA
         UvDA==
X-Gm-Message-State: ABy/qLbpthk4I947Gr5qJg5Omsj+pxgYCXzewJniRzhTohTHE6MxaTXs
        Riig0vTgXnY8YntFCYXPe9oKsISPJ3aCsJydkwFfleib36awaZcVtbNh0OT1S0df9VETxin72wC
        dCQPhO2zKR1sG2I7isGMZ
X-Received: by 2002:a05:620a:4511:b0:767:2412:f269 with SMTP id t17-20020a05620a451100b007672412f269mr483030qkp.61.1688071329916;
        Thu, 29 Jun 2023 13:42:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5dZ99u0FexFz2CLm1Yt25aSRFz1tJwVcnRgmM9Nldf9fXEuZIjNdHPVzzgvFl6GERjW4GRbw==
X-Received: by 2002:a05:620a:4511:b0:767:2412:f269 with SMTP id t17-20020a05620a451100b007672412f269mr483011qkp.61.1688071329586;
        Thu, 29 Jun 2023 13:42:09 -0700 (PDT)
Received: from thinkpad-p1.localdomain (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id 20-20020a05620a071400b007671cafbf5csm2266438qkc.85.2023.06.29.13.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 13:42:09 -0700 (PDT)
Message-ID: <425880de38770e059ae4734fc72d6cdc77bf1870.camel@redhat.com>
Subject: Re: [PATCH 1/1] PCI: dwc: Use regular interrupt instead of chained
From:   Radu Rendec <rrendec@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 29 Jun 2023 16:42:07 -0400
In-Reply-To: <20230629195745.GA444039@bhelgaas>
References: <20230629195745.GA444039@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIzLTA2LTI5IGF0IDE0OjU3IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOgo+
IE9uIFRodSwgSnVuIDI5LCAyMDIzIGF0IDAyOjMwOjE5UE0gLTA0MDAsIFJhZHUgUmVuZGVjIHdy
b3RlOgo+ID4gVGhlIERlc2lnbldhcmUgUENJZSBob3N0IGRyaXZlciB1c2VzIGEgY2hhaW5lZCBp
bnRlcnJ1cHQgdG8gZGVtdWx0aXBsZXgKPiA+IHRoZSBkb3duc3RyZWFtIE1TSSBpbnRlcnJ1cHRz
LiBPbiBRdWFsY29tbSBTQTg1NDBQIFJpZGUsIGVuYWJsaW5nIGJvdGgKPiA+IHBjaWUyYSBhbmQg
cGNpZTNhIGF0IHRoZSBzYW1lIHRpbWUgY2FuIGNyZWF0ZSBhbiBpbnRlcnJ1cHQgc3Rvcm0gd2hl
cmUKPiA+IHRoZSBwYXJlbnQgaW50ZXJydXB0IGZpcmVzIGNvbnRpbnVvdXNseSwgZXZlbiB0aG91
Z2ggcmVhZGluZyB0aGUgUENJZQo+ID4gaG9zdCByZWdpc3RlcnMgZG9lc24ndCBpZGVudGlmeSBh
bnkgY2hpbGQgTVNJIGludGVycnVwdCBzb3VyY2UuIFRoaXMKPiA+IGVmZmVjdGl2ZWx5IGxvY2tz
IHVwIENQVTAsIHdoaWNoIHNwZW5kcyBhbGwgdGhlIHRpbWUgc2VydmljaW5nIHRoZXNlCj4gPiBp
bnRlcnJ1cHRzLgo+ID4gCj4gPiBUaGlzIGlzIGEgY2xlYXIgZXhhbXBsZSBvZiBob3cgYnlwYXNz
aW5nIHRoZSBpbnRlcnJ1cHQgY29yZSBieSB1c2luZwo+ID4gY2hhaW5lZCBpbnRlcnJ1cHRzIGNh
biBiZSB2ZXJ5IGRhbmdlcm91cyBpZiB0aGUgaGFyZHdhcmUgbWlzYmVoYXZlcy4KPiA+IAo+ID4g
Q29udmVydCB0aGUgZHJpdmVyIHRvIHVzZSBhIHJlZ3VsYXIgaW50ZXJydXB0IGZvciB0aGUgZGVt
dWx0aXBsZXgKPiA+IGhhbmRsZXIuIFRoaXMgYWxsb3dzIHRoZSBpbnRlcnJ1cHQgc3Rvcm0gZGV0
ZWN0b3IgdG8gZGV0ZWN0IHRoZSBmYXVsdHkKPiA+IGludGVycnVwdCBhbmQgZGlzYWJsZSBpdCwg
YWxsb3dpbmcgdGhlIHN5c3RlbSB0byBydW4gbm9ybWFsbHkuCj4gCj4gVGhlcmUgYXJlIG1hbnkg
b3RoZXIgdXNlcnMgb2YgaXJxX3NldF9jaGFpbmVkX2hhbmRsZXJfYW5kX2RhdGEoKSBpbgo+IGRy
aXZlcnMvcGNpL2NvbnRyb2xsZXIvLsKgIFNob3VsZCB0aGV5IGJlIHNpbWlsYXJseSBjb252ZXJ0
ZWQ/wqAgSWYgbm90LAo+IGhvdyBkbyB3ZSBkZWNpZGUgd2hpY2ggbmVlZCB0byB1c2UgaXJxX3Nl
dF9jaGFpbmVkX2hhbmRsZXJfYW5kX2RhdGEoKQo+IGFuZCB3aGljaCBkbyBub3Q/CgpBY2NvcmRp
bmcgdG8gVGhvbWFzIEdsZWl4bmVyLCB5ZXMuIE9idmlvdXNseSBJIGRvbid0IHdhbnQgdG8gcHV0
IHdvcmRzCmluIGhpcyBtb3V0aCwgYnV0IEkgdGhpbmsgdGhhdCdzIHRoZSBnaXN0IG9mIHdoYXQg
aGUgc2FpZCBpbiBhIHJlcGx5IHRvCmFuIFJGQyBwYXRjaCB0aGF0IEkgc2VudCBhIGZldyB3ZWVr
cyBhZ286Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC84Nzdjc29oY2xsLmZmc0B0Z2x4LwoK
PiA+IFNpZ25lZC1vZmYtYnk6IFJhZHUgUmVuZGVjIDxycmVuZGVjQHJlZGhhdC5jb20+Cj4gPiAt
LS0KPiA+IMKgLi4uL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jIHwg
MzUgKysrKysrKysrLS0tLS0tLS0tLQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9u
cygrKSwgMTggZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jIGIvZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYwo+ID4gaW5kZXggOTk1MjA1N2M4ODE5Yy4u
YjYwMzc5NmQ0MTVkNyAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaWUtZGVzaWdud2FyZS1ob3N0LmMKPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMKPiA+IEBAIC04MywxOCArODMsOSBAQCBpcnFyZXR1
cm5fdCBkd19oYW5kbGVfbXNpX2lycShzdHJ1Y3QgZHdfcGNpZV9ycCAqcHApCj4gPiDCoMKgwqDC
oMKgwqDCoMKgcmV0dXJuIHJldDsKPiA+IMKgfQo+ID4gwqAKPiA+IC0vKiBDaGFpbmVkIE1TSSBp
bnRlcnJ1cHQgc2VydmljZSByb3V0aW5lICovCj4gPiAtc3RhdGljIHZvaWQgZHdfY2hhaW5lZF9t
c2lfaXNyKHN0cnVjdCBpcnFfZGVzYyAqZGVzYykKPiA+ICtzdGF0aWMgaXJxcmV0dXJuX3QgZHdf
cGNpZV9tc2lfaXNyKGludCBpcnEsIHZvaWQgKmRldl9pZCkKPiA+IMKgewo+ID4gLcKgwqDCoMKg
wqDCoMKgc3RydWN0IGlycV9jaGlwICpjaGlwID0gaXJxX2Rlc2NfZ2V0X2NoaXAoZGVzYyk7Cj4g
PiAtwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgZHdfcGNpZV9ycCAqcHA7Cj4gPiAtCj4gPiAtwqDCoMKg
wqDCoMKgwqBjaGFpbmVkX2lycV9lbnRlcihjaGlwLCBkZXNjKTsKPiA+IC0KPiA+IC3CoMKgwqDC
oMKgwqDCoHBwID0gaXJxX2Rlc2NfZ2V0X2hhbmRsZXJfZGF0YShkZXNjKTsKPiA+IC3CoMKgwqDC
oMKgwqDCoGR3X2hhbmRsZV9tc2lfaXJxKHBwKTsKPiA+IC0KPiA+IC3CoMKgwqDCoMKgwqDCoGNo
YWluZWRfaXJxX2V4aXQoY2hpcCwgZGVzYyk7Cj4gPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gZHdf
aGFuZGxlX21zaV9pcnEoZGV2X2lkKTsKPiA+IMKgfQo+ID4gwqAKPiA+IMKgc3RhdGljIHZvaWQg
ZHdfcGNpX3NldHVwX21zaV9tc2coc3RydWN0IGlycV9kYXRhICpkLCBzdHJ1Y3QgbXNpX21zZyAq
bXNnKQo+ID4gQEAgLTI1NCwyMCArMjQ1LDIxIEBAIGludCBkd19wY2llX2FsbG9jYXRlX2RvbWFp
bnMoc3RydWN0IGR3X3BjaWVfcnAgKnBwKQo+ID4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOwo+
ID4gwqB9Cj4gPiDCoAo+ID4gLXN0YXRpYyB2b2lkIGR3X3BjaWVfZnJlZV9tc2koc3RydWN0IGR3
X3BjaWVfcnAgKnBwKQo+ID4gK3N0YXRpYyB2b2lkIF9fZHdfcGNpZV9mcmVlX21zaShzdHJ1Y3Qg
ZHdfcGNpZV9ycCAqcHAsIHUzMiBudW1fY3RybHMpCj4gPiDCoHsKPiA+IMKgwqDCoMKgwqDCoMKg
wqB1MzIgY3RybDsKPiA+IMKgCj4gPiAtwqDCoMKgwqDCoMKgwqBmb3IgKGN0cmwgPSAwOyBjdHJs
IDwgTUFYX01TSV9DVFJMUzsgY3RybCsrKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqBmb3IgKGN0cmwg
PSAwOyBjdHJsIDwgbnVtX2N0cmxzOyBjdHJsKyspIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgaWYgKHBwLT5tc2lfaXJxW2N0cmxdID4gMCkKPiA+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaXJxX3NldF9jaGFpbmVkX2hhbmRsZXJf
YW5kX2RhdGEocHAtPm1zaV9pcnFbY3RybF0sCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTlVMTCwgTlVMTCk7Cj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZyZWVfaXJxKHBwLT5tc2lfaXJx
W2N0cmxdLCBwcCk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgfQo+ID4gwqAKPiA+IMKgwqDCoMKgwqDC
oMKgwqBpcnFfZG9tYWluX3JlbW92ZShwcC0+bXNpX2RvbWFpbik7Cj4gPiDCoMKgwqDCoMKgwqDC
oMKgaXJxX2RvbWFpbl9yZW1vdmUocHAtPmlycV9kb21haW4pOwo+ID4gwqB9Cj4gPiDCoAo+ID4g
KyNkZWZpbmUgZHdfcGNpZV9mcmVlX21zaShwcCkgX19kd19wY2llX2ZyZWVfbXNpKHBwLCBNQVhf
TVNJX0NUUkxTKQo+IAo+IFdoYXQgaXMgdGhlIGJlbmVmaXQgb2YgdGhlIGR3X3BjaWVfZnJlZV9t
c2koKSBtYWNybz8KCkl0IGFsbG93cyBtZSB0byBhZGQgdGhlIG51bV9jdHJscyBwYXJhbWV0ZXIg
dG8gdGhlIGNvcnJlc3BvbmRpbmcKZnVuY3Rpb24gKG5vdyByZW5hbWVkIHRvIF9fZHdfcGNpZV9m
cmVlX21zaSgpKSB3aXRob3V0IGZvcmNpbmcgYWxsIHRoZQpleGlzdGluZyBjYWxsIHNpdGVzIHRv
IHNlbmQgTUFYX01TSV9DVFJMUyBleHBsaWNpdGx5LgoKSSBuZWVkZWQgdGhhdCBleHRyYSBwYXJh
bWV0ZXIgdG8gYXZvaWQgZHVwbGljYXRpbmcgdGhlIHRlYXIgZG93biBjb2RlCm9uIHRoZSAobmV3
KSBlcnJvciBwYXRoIGluIGR3X3BjaWVfbXNpX2luaXQoKSAtIHNlZSBiZWxvdy4KCj4gPiDCoHN0
YXRpYyB2b2lkIGR3X3BjaWVfbXNpX2luaXQoc3RydWN0IGR3X3BjaWVfcnAgKnBwKQo+ID4gwqB7
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGR3X3BjaWUgKnBjaSA9IHRvX2R3X3BjaWVfZnJv
bV9wcChwcCk7Cj4gPiBAQCAtMzYxLDkgKzM1MywxNiBAQCBzdGF0aWMgaW50IGR3X3BjaWVfbXNp
X2hvc3RfaW5pdChzdHJ1Y3QgZHdfcGNpZV9ycCAqcHApCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJldHVybiByZXQ7Cj4gPiDCoAo+ID4gwqDCoMKgwqDCoMKgwqDCoGZvciAo
Y3RybCA9IDA7IGN0cmwgPCBudW1fY3RybHM7IGN0cmwrKykgewo+ID4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGlmIChwcC0+bXNpX2lycVtjdHJsXSA+IDApCj4gPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlycV9zZXRfY2hhaW5lZF9oYW5k
bGVyX2FuZF9kYXRhKHBwLT5tc2lfaXJxW2N0cmxdLAo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZHdfY2hhaW5lZF9tc2lfaXNyLCBwcCk7Cj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHBwLT5tc2lfaXJxW2N0cmxdID4gMCkgewo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXQgPSBy
ZXF1ZXN0X2lycShwcC0+bXNpX2lycVtjdHJsXSwgZHdfcGNpZV9tc2lfaXNyLCAwLAo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl9uYW1lKGRldiksIHBwKTsKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCkgewo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ZGV2X2VycihkZXYsICJGYWlsZWQgdG8gcmVxdWVzdCBpcnEgJWQ6ICVkXG4iLAo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHBwLT5tc2lfaXJxW2N0cmxdLCByZXQpOwo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgX19kd19w
Y2llX2ZyZWVfbXNpKHBwLCBjdHJsKTsKClRoaXMgaXMgd2hlcmUgSSdtIHVzaW5nIHRoZSBleHRy
YSBwYXJhbWV0ZXIuIElmIHdlIGZhaWwgdG8gcmVxdWVzdCBhbgppbnRlcnJ1cHQsIHdlIG5lZWQg
dG8gZnJlZSBhbGwgdGhlIG90aGVyIGludGVycnVwdHMgdGhhdCB3ZSBoYXZlCnJlcXVlc3RlZCBz
byBmYXIsIHRvIGxlYXZlIGV2ZXJ5dGhpbmcgaW4gYSBjbGVhbiBzdGF0ZS4gQnV0IHdlIGNhbid0
CnVzZSBNQVhfTVNJX0NUUkxTIHdpdGggX19kd19wY2llX2ZyZWVfbXNpKCkgYW5kIHJlbHkgb24g
dGhlIGNoZWNrIHRoZXJlCmJlY2F1c2UgdGhlcmUgbWF5IGJlIGV4dHJhIGludGVycnVwdHMgdGhh
dCB3ZSBoYXZlbid0IHJlcXVlc3RlZCAqeWV0KgphbmQgd2Ugd291bGQgYXR0ZW1wdCB0byBmcmVl
IHRoZW0uCgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoH0KPiA+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiDCoAo+ID4gwqDCoMKgwqDCoMKgwqDCoC8q
Cj4gPiAtLSAKPiA+IDIuNDEuMAo+ID4gCj4gCgo=

