Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99318391CB8
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 18:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbhEZQML (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 12:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbhEZQML (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 12:12:11 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F48C061574
        for <linux-pci@vger.kernel.org>; Wed, 26 May 2021 09:10:38 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id r8so2774562ybb.9
        for <linux-pci@vger.kernel.org>; Wed, 26 May 2021 09:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XukBZKRquKrUKEuDI23lK/s/WgvvMgasI5PPiWpz56E=;
        b=Kot+P7L4XzcTk9z2Z51W3Ghygn8MA6lgBTQT/AGv3L3j4YiLybo4FOudIXdSKNZP3G
         lSywP8hnw49p5BR+TaF+wl5ITsYsFdom4S+/b874qGdHa9QVupNWVpG9SjctN8uBg8h+
         PAiECOvaIjlxX+UAXIsEqvCEfE6YUXHQtTXlFRju1AjmNPk8c11tqNswhH/eDL5wBQiC
         eXG1wyx5AQ+0xk6LI8AoVUrS++iyidTl1mZaz34ZTX/LIz0xOV/EamvKO7vRr55s5XKm
         yQhNmgyBwI2YgHPjMZBvv/oyUpsl8H0C09XVCMrHxFnx0kR/tzdqAqVDcrf4MPwXm+3v
         L3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XukBZKRquKrUKEuDI23lK/s/WgvvMgasI5PPiWpz56E=;
        b=hMW50fTejElw+tHu/kPs9hsaW2Iw7Q2E0+c79yRposdRdtBoUeYq4tuG7cLzdcp+v7
         nTbEfFV+b85C11ymXMvlAgVp07jEsUz3H7KYTmKKgWJsjBYPWhGN7MUVWDsLJrvCGAuO
         DNeVB8nZZfZ/NHsNYod3GQlRqeRRcRbiSDAh2E7uhe2igN+QIKzuCylHGORc7mwOHYQy
         Mz33SXT+RZRRgBYf1lZyeylGo0RBwW7PiJ421esxSCw/ha1c2+wjeIn0X3Ray+gbb59H
         jIPMCIoa8x19ItPsA5aFSaOF19uWPo21sneh23PLgRsxtiSBaExcEDoMQX98nlS+FMDX
         OG2Q==
X-Gm-Message-State: AOAM533P8sZm/ezM8WF3X+nllTgZykVyC2N9rh7cStr+Q9mJvrr78yVP
        FL9Ma0hvKOFWbqq8/KC+J+iNGmXXZvgR5I3RjV7AwzTUQmg=
X-Google-Smtp-Source: ABdhPJz7v35/Nm1n8taTLlK0737T+k8EOInnjcfLRvKICP+yx+94vm0kyzn3xF0EMROVNxfllLP3vYPxNcMCWT1R09w=
X-Received: by 2002:a25:880f:: with SMTP id c15mr52671963ybl.373.1622045437940;
 Wed, 26 May 2021 09:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120055.jl7vkqanv7wzeipq@pali> <CABLWAfQbKy=fpaY6J=gqtJy5L+pqNeqwU6qkVswYaWnVjiwAHw@mail.gmail.com>
 <20210520140529.rczoz3npjoadzfqc@pali> <CABLWAfSct8Kn1etyJtZhFc5A33thE-s6=Cz-Gd6+j04S4pfD_A@mail.gmail.com>
 <4e972ecb-43df-639f-052d-8d1518bae9c0@broadcom.com> <87pmxgwh7o.wl-maz@kernel.org>
 <13a7e409-646d-40a7-17a0-4e4be011efb2@broadcom.com> <874keqvsf2.wl-maz@kernel.org>
In-Reply-To: <874keqvsf2.wl-maz@kernel.org>
From:   Sandor Bodo-Merle <sbodomerle@gmail.com>
Date:   Wed, 26 May 2021 18:10:24 +0200
Message-ID: <CABLWAfSAq50_WvFrqF0+wjqYx3btBrU1kgms3i9dy8GBm4FcdA@mail.gmail.com>
Subject: Re: pcie-iproc-msi.c: Bug in Multi-MSI support?
To:     Marc Zyngier <maz@kernel.org>
Cc:     Ray Jui <ray.jui@broadcom.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Content-Type: multipart/mixed; boundary="00000000000023930105c33de2c8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--00000000000023930105c33de2c8
Content-Type: text/plain; charset="UTF-8"

The following patch addresses the allocation issue - but indeed - wont
fix the atomicity of IRQ affinity in this driver (but the majority of
our product relies on single core SOCs; we also use a dual-core SOC
also - but we don't change the initial the IRQ affinity).

On Wed, May 26, 2021 at 9:57 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 25 May 2021 18:27:54 +0100,
> Ray Jui <ray.jui@broadcom.com> wrote:
> >
> > On 5/24/2021 3:37 AM, Marc Zyngier wrote:
> > > On Thu, 20 May 2021 18:11:32 +0100,
> > > Ray Jui <ray.jui@broadcom.com> wrote:
> > >>
> > >> On 5/20/2021 7:22 AM, Sandor Bodo-Merle wrote:
>
> [...]
>
> > >> I guess I'm not too clear on what you mean by "multi-MSI interrupts
> > >> needs to be aligned to number of requested interrupts.". Would you be
> > >> able to plug this into the above explanation so we can have a more clear
> > >> understanding of what you mean here?
> > >
> > > That's a generic PCI requirement: if you are providing a Multi-MSI
> > > configuration, the base vector number has to be size-aligned
> > > (2-aligned for 2 MSIs, 4 aligned for 4, up to 32), and the end-point
> > > supplies up to 5 bits that are orr-ed into the base vector number,
> > > with a *single* doorbell address. You effectively provide a single MSI
> > > number and a single address, and the device knows how to drive 2^n MSIs.
> > >
> > > This is different from MSI-X, which defines multiple individual
> > > vectors, each with their own doorbell address.
> > >
> > > The main problem you have here (other than the broken allocation
> > > mechanism) is that moving an interrupt from one core to another
> > > implies moving the doorbell address to that of another MSI
> > > group. This isn't possible for Multi-MSI, as all the MSIs must have
> > > the same doorbell address. As far as I can see, there is no way to
> > > support Multi-MSI together with affinity change on this HW, and you
> > > should stop advertising support for this feature.
> > >
> >
> > I was not aware of the fact that multi-MSI needs to use the same
> > doorbell address (aka MSI posted write address?). Thank you for helping
> > to point it out. In this case, yes, like you said, we cannot possibly
> > support both multi-MSI and affinity at the same time, since supporting
> > affinity requires us to move from one to another event queue (and irq)
> > that will have different doorbell address.
> >
> > Do you think it makes sense to do the following by only advertising
> > multi-MSI capability in the single CPU core case (detected runtime via
> > 'num_possible_cpus')? This will at least allow multi-MSI to work in
> > platforms with single CPU core that Sandor and Pali use?
>
> I don't think this makes much sense. Single-CPU machines are an oddity
> these days, and I'd rather you simplify this (already pretty
> complicated) driver.
>
> > > There is also a more general problem here, which is the atomicity of
> > > the update on affinity change. If you are moving an interrupt from one
> > > CPU to the other, it seems you change both the vector number and the
> > > target address. If that is the case, this isn't atomic, and you may
> > > end-up with the device generating a message based on a half-applied
> > > update.
> >
> > Are you referring to the callback in 'irq_set_addinity" and
> > 'irq_compose_msi_msg'? In such case, can you help to recommend a
> > solution for it (or there's no solution based on such architecture)? It
> > does not appear such atomy can be enforced from the irq framework level.
>
> irq_compose_msi_msg() is only one part of the problem. The core of the
> issue is that the programming of the end-point is not atomic (you need
> to update a 32bit payload *and* a 64bit address).
>
> A solution to workaround it would be to rework the way you allocate
> the vectors, making them constant across all CPUs so that only the
> address changes when changing the affinity.
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

--00000000000023930105c33de2c8
Content-Type: text/x-diff; charset="UTF-8"; 
	name="0001-PCI-iproc-fix-the-base-vector-number-allocation-for-.patch"
Content-Disposition: attachment; 
	filename="0001-PCI-iproc-fix-the-base-vector-number-allocation-for-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kp5nxoec0>
X-Attachment-Id: f_kp5nxoec0

RnJvbSBkZjMxYzljMDMzM2NhNDkyMmI3OTc4YjMwNzE5MzQ4ZTM2OGJlYTNjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW5kb3IgQm9kby1NZXJsZSA8c2JvZG9tZXJsZUBnbWFpbC5j
b20+CkRhdGU6IFdlZCwgMjYgTWF5IDIwMjEgMTc6NDg6MTYgKzAyMDAKU3ViamVjdDogW1BBVENI
XSBQQ0k6IGlwcm9jOiBmaXggdGhlIGJhc2UgdmVjdG9yIG51bWJlciBhbGxvY2F0aW9uIGZvciBN
dWx0aQogTVNJCk1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hh
cnNldD1VVEYtOApDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0CgpDb21taXQgZmM1NGJh
ZTI4ODE4ICgiUENJOiBpcHJvYzogQWxsb3cgYWxsb2NhdGlvbiBvZiBtdWx0aXBsZSBNU0lzIikK
ZmFpbGVkIHRvIHJlc2VydmUgdGhlIHByb3BlciBudW1iZXIgb2YgYml0cyBmcm9tIHRoZSBpbm5l
ciBkb21haW4uCk5hdHVyYWwgYWxpZ25tZW50IG9mIHRoZSBiYXNlIHZlY3RvciBudW1iZXIgd2Fz
IGFsc28gbm90IGd1YXJhbnRlZWQuCgpGaXhlczogZmM1NGJhZTI4ODE4ICgiUENJOiBpcHJvYzog
QWxsb3cgYWxsb2NhdGlvbiBvZiBtdWx0aXBsZSBNU0lzIikKUmVwb3J0ZWQtYnk6IFBhbGkgUm9o
w6FyIDxwYWxpQGtlcm5lbC5vcmc+ClNpZ25lZC1vZmYtYnk6IFNhbmRvciBCb2RvLU1lcmxlIDxz
Ym9kb21lcmxlQGdtYWlsLmNvbT4KLS0tCiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtaXBy
b2MtbXNpLmMgfCAxOCArKysrKysrKy0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2Vy
dGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBkcml2ZXJzL3BjaS9jb250cm9s
bGVyL3BjaWUtaXByb2MtbXNpLmMgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLWlwcm9jLW1z
aS5jCmluZGV4IGVlZGU0ZThmM2Y3NS4uZmEyNzM0ZGQ4NDgyIDEwMDY0NAotLS0gZHJpdmVycy9w
Y2kvY29udHJvbGxlci9wY2llLWlwcm9jLW1zaS5jCisrKyBkcml2ZXJzL3BjaS9jb250cm9sbGVy
L3BjaWUtaXByb2MtbXNpLmMKQEAgLTI1MiwxOCArMjUyLDE1IEBAIHN0YXRpYyBpbnQgaXByb2Nf
bXNpX2lycV9kb21haW5fYWxsb2Moc3RydWN0IGlycV9kb21haW4gKmRvbWFpbiwKIAogCW11dGV4
X2xvY2soJm1zaS0+Yml0bWFwX2xvY2spOwogCi0JLyogQWxsb2NhdGUgJ25yX2NwdXMnIG51bWJl
ciBvZiBNU0kgdmVjdG9ycyBlYWNoIHRpbWUgKi8KLQlod2lycSA9IGJpdG1hcF9maW5kX25leHRf
emVyb19hcmVhKG1zaS0+Yml0bWFwLCBtc2ktPm5yX21zaV92ZWNzLCAwLAotCQkJCQkgICBtc2kt
Pm5yX2NwdXMsIDApOwotCWlmIChod2lycSA8IG1zaS0+bnJfbXNpX3ZlY3MpIHsKLQkJYml0bWFw
X3NldChtc2ktPmJpdG1hcCwgaHdpcnEsIG1zaS0+bnJfY3B1cyk7Ci0JfSBlbHNlIHsKLQkJbXV0
ZXhfdW5sb2NrKCZtc2ktPmJpdG1hcF9sb2NrKTsKLQkJcmV0dXJuIC1FTk9TUEM7Ci0JfQorCS8q
IEFsbG9jYXRlICducl9pcnFzJyBtdWx0aXBsaWVkIGJ5ICducl9jcHVzJyBudW1iZXIgb2YgTVNJ
IHZlY3RvcnMgZWFjaCB0aW1lICovCisJaHdpcnEgPSBiaXRtYXBfZmluZF9mcmVlX3JlZ2lvbiht
c2ktPmJpdG1hcCwgbXNpLT5ucl9tc2lfdmVjcywKKwkJCQkJb3JkZXJfYmFzZV8yKG1zaS0+bnJf
Y3B1cyAqIG5yX2lycXMpKTsKIAogCW11dGV4X3VubG9jaygmbXNpLT5iaXRtYXBfbG9jayk7CiAK
KwlpZiAoaHdpcnEgPCAwKQorCQlyZXR1cm4gLUVOT1NQQzsKKwogCWZvciAoaSA9IDA7IGkgPCBu
cl9pcnFzOyBpKyspIHsKIAkJaXJxX2RvbWFpbl9zZXRfaW5mbyhkb21haW4sIHZpcnEgKyBpLCBo
d2lycSArIGksCiAJCQkJICAgICZpcHJvY19tc2lfYm90dG9tX2lycV9jaGlwLApAQCAtMjg0LDcg
KzI4MSw4IEBAIHN0YXRpYyB2b2lkIGlwcm9jX21zaV9pcnFfZG9tYWluX2ZyZWUoc3RydWN0IGly
cV9kb21haW4gKmRvbWFpbiwKIAltdXRleF9sb2NrKCZtc2ktPmJpdG1hcF9sb2NrKTsKIAogCWh3
aXJxID0gaHdpcnFfdG9fY2Fub25pY2FsX2h3aXJxKG1zaSwgZGF0YS0+aHdpcnEpOwotCWJpdG1h
cF9jbGVhcihtc2ktPmJpdG1hcCwgaHdpcnEsIG1zaS0+bnJfY3B1cyk7CisJYml0bWFwX3JlbGVh
c2VfcmVnaW9uKG1zaS0+Yml0bWFwLCBod2lycSwKKwkJCSAgICAgIG9yZGVyX2Jhc2VfMihtc2kt
Pm5yX2NwdXMgKiBucl9pcnFzKSk7CiAKIAltdXRleF91bmxvY2soJm1zaS0+Yml0bWFwX2xvY2sp
OwogCi0tIAoyLjMxLjAKCg==
--00000000000023930105c33de2c8--
