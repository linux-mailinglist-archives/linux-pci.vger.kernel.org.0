Return-Path: <linux-pci+bounces-4680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB2D8769BD
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 18:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4436C1C2096B
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 17:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732124CDE0;
	Fri,  8 Mar 2024 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEPlvztV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E194F213;
	Fri,  8 Mar 2024 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918440; cv=none; b=BvVOYjVhAlqW/nMZVMpVHdjbCLZdW45GjzpRoSKdl9RM3RW4GDQkC3q0qkNrLqnf849xrdt0JPtvEziPeS8KPPXHsfhVGGZUAEIl+dpr0V9asigH6f2PhAK3+KDs11DcvVo4miwOhwSBYWgR8sVZhlMdSeHB5c/xojIn5ezalac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918440; c=relaxed/simple;
	bh=Rr/3morRYf08jSB6i3dJJGHoyF2YTqnFL480a51rHQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/YnCVVxMgAhmyWzCwxncuilTkXtxjUqzR2NU9QLBsOG6iwKPWRmSkQhFw8qtM4gja9zflhgEj+aXV1P4VBdrV2xzhlB5kc052myV+xDzYGHT+Iznz24Mw+k1qhqylbiRulqlpFCxsg1fGk4goLM3cJnnJvlDD56PeE/KBCdhDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEPlvztV; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33e7ae72312so267380f8f.1;
        Fri, 08 Mar 2024 09:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709918437; x=1710523237; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pbCp7DmgJjmAKIHEigoBc3KX7fetXPW58mtVegm0DfI=;
        b=ZEPlvztVZsWrTVGIP2yhI64IZOYio+J8JC82BtDrEJRKVvOxT4DXkCqmrnJYz8ccRR
         r9J+lKOqf/UnTAoua66FutFtIxPn3Jq+ziDdttuQCexwlQ39sVea5MuGqhmdeLiE6J9F
         n7NnmGeASfI3und1g9Oa5KSFY/+Z5JnXo+n5J3LM8+D7dJMqsF//LvwufRzm3EvBK49J
         RUFClfIeJ3ccR2XhyzuBe22izR+Gf1UPiWiFq6vV+Aml/yGvb/lwZZOV4QFOAFiob3Fd
         o8l/aJvZJxu880txy6AfbvvQ7KbBnz5hnmk5IFtIy9i/kHBnMrsnij/ojoRwXcQQ+tp0
         27gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709918437; x=1710523237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pbCp7DmgJjmAKIHEigoBc3KX7fetXPW58mtVegm0DfI=;
        b=OTwhwIaqqokM9cbv++sZ0D/YFHm8shqA5sUXwil6JHRI/PA1wZ7UEXT/puMFDbrbuW
         0J6V6+ym690FgM/Ta/2YRHYAnqaiQ5+3c5XmG1CZGnaooil0zgxGLKeFGjdmIU+2ycw8
         xQ/SnPumiKITcUJ0H8Wf/drWWAd3D1rZeHK+wUWhifM/qU/zm9X7kscHR6uwdAX/taxi
         LILntB68p+JbnOzctLx7o/3RuWEyeNFU8yRv44t07fdfxSujw/ohRHjsrKF78LSvTRfA
         QsMYU2oJ2S/Gb+8Q3jhOOyhCEAGH8yaHJzRqitJptSMyhJv2bv0kQ74Sn2dj70quUywI
         VAIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpaXfM0bqz0MsmAI77yfBGqRYfAQvAy8UrTadzaxRqgkbZL4aD2WKKP9nMbOQST7cLZBNENhdm/b8jpMaFF79X3KNkJANs2F7thhdbtvzf0+nNQZVMPOfj/zR8MuLS
X-Gm-Message-State: AOJu0YxboQBTYB1J6oXJBTLANdmTVjeVEuoZaTCIHm6mzCd2V6x9rhnv
	GWTWTHpKkLGgqX8ppbjq5QYFKeaPC8m659d8OJxe2hwer+CT1z419DWaumhIpinnO8lekId8L5O
	rzGV3BTwsCK53y39CAMwwhj73wVA=
X-Google-Smtp-Source: AGHT+IHEyAocoC9+N+chISdLsopzPHdFAe0K730evBmORwJM6yWIHQsZb/nmwlfe88bL3sQ0x/XNwYhYdeZBswTeILk=
X-Received: by 2002:adf:e906:0:b0:33e:73f6:c620 with SMTP id
 f6-20020adfe906000000b0033e73f6c620mr2578060wrm.40.1709918436580; Fri, 08 Mar
 2024 09:20:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72ka4rir+RTN2FQoT=Vvprp_Ao-CvoYEkSNqtSY+RZj+AA@mail.gmail.com>
 <CAADnVQL1Zt5dwFv9HPDKDuPEKa6V7gb5j-D-LPWv47hC6mtwgw@mail.gmail.com>
 <CAADnVQLP=dxBb+RiMGXoaCEuRrbK387J6B+pfzWKF_F=aRgCPQ@mail.gmail.com>
 <Zeso7eNj1sBhH5zY@infradead.org> <CAADnVQKQumV-0AxGLKX0jQEfa8Z2Bxx2yW8k_1OqGBnD-RqrbA@mail.gmail.com>
 <ZetEkyW1QgIKwfFz@infradead.org>
In-Reply-To: <ZetEkyW1QgIKwfFz@infradead.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Mar 2024 09:20:24 -0800
Message-ID: <CAADnVQL4JAUz-p-X9aEggeKNpYUqJZrzQKO7N0dnohE0r7mdpg@mail.gmail.com>
Subject: Re: vm_area at addr ffffffffc0800000 is not marked as VM_IOREMAP
To: Christoph Hellwig <hch@infradead.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000021009061329699e"

--000000000000021009061329699e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 9:02=E2=80=AFAM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Fri, Mar 08, 2024 at 08:33:18AM -0800, Alexei Starovoitov wrote:
> > vmap_range_noflush() is static in mm/vmalloc.c
> > There is vmap_pages_range_noflush() that is in mm/internal.h,
> > but it needs pages instead of phys_addr_t.
> > Newly introduced vm_area_map_pages() needs struct vm_struct *area
> > and struct page **pages.
> > In this PCI case there is no vm_struct and no pages.
> > ioremap_page_range() is the only api that fits. afaict.
>
> Except that we want to enforce a vm_area with the ioremap flag for
> ioremap_page_range, and just adding a NULL check defeats that.
>
> The right long term thing would be to actually create a vm_area
> for the PCI_IOBASE region, but until then we just need a lower level
> API.  That's why I suggest to add a vmap_range() that is basically
> the ioremap_page_range before you added the checks, and make
> ioremap_page_range a wrapper around that that checks the area.

ok. Like the attached patch?

> If/when we get PCI_IOBASE handling converted to the proper
> vmalloc/ioremap areas we can remove that again as well as
> vunmap_range which is just used for PCI_IOBASE and other equivalent
> ISA_IO_BASE in powerpc and somewhat unusual case in arm64 that I
> need to look into a bit more.

The plan makes sense to me.

--000000000000021009061329699e
Content-Type: application/octet-stream; 
	name="0001-mm-Introduce-vmap_page_range-to-be-used-by-PCI.patch"
Content-Disposition: attachment; 
	filename="0001-mm-Introduce-vmap_page_range-to-be-used-by-PCI.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ltix9gg70>
X-Attachment-Id: f_ltix9gg70

RnJvbSBhM2EyNmM4NjE5ZjZlZDZkOGNjYTU4YWMxYjFkNTQ4OTQ4YmZlZTA1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFzdEBrZXJuZWwub3JnPgpE
YXRlOiBGcmksIDggTWFyIDIwMjQgMDk6MTI6NTQgLTA4MDAKU3ViamVjdDogW1BBVENIIGJwZi1u
ZXh0XSBtbTogSW50cm9kdWNlIHZtYXBfcGFnZV9yYW5nZSgpIHRvIGJlIHVzZWQgYnkgUENJCgpp
b3JlbWFwX3BhZ2VfcmFuZ2UoKSBzaG91bGQgYmUgdXNlZCBmb3IgcmFuZ2VzIHdpdGhpbiB2bWFs
bG9jIHJhbmdlIG9ubHkuClRoZSB2bWFsbG9jIHJhbmdlcyBhcmUgYWxsb2NhdGVkIGJ5IGdldF92
bV9hcmVhKCkuIFBDSSBoYXMgInJlc291cmNlIgphbGxvY2F0b3IgdGhhdCBtYW5hZ2VzIFBDSV9J
T0JBU0UsIElPX1NQQUNFX0xJTUlUIGFkZHJlc3MgcmFuZ2UsIGhlbmNlCmludHJvZHVjZSB2bWFw
X3BhZ2VfcmFuZ2UoKSB0byBiZSB1c2VkIGV4Y2x1c2l2ZWx5IGJ5IFBDSS4KClNpZ25lZC1vZmYt
Ynk6IEFsZXhlaSBTdGFyb3ZvaXRvdiA8YXN0QGtlcm5lbC5vcmc+Ci0tLQogZHJpdmVycy9wY2kv
cGNpLmMgIHwgIDQgKystLQogaW5jbHVkZS9saW51eC9pby5oIHwgIDcgKysrKysrKwogbW0vdm1h
bGxvYy5jICAgICAgIHwgMjMgKysrKysrKysrKysrKysrLS0tLS0tLS0KIDMgZmlsZXMgY2hhbmdl
ZCwgMjQgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9wY2kvcGNpLmMgYi9kcml2ZXJzL3BjaS9wY2kuYwppbmRleCBjMzU4NTIyOWMxMmEuLmNjZWU1
NjYxNWY3OCAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kvcGNpLmMKKysrIGIvZHJpdmVycy9wY2kv
cGNpLmMKQEAgLTQzNTMsOCArNDM1Myw4IEBAIGludCBwY2lfcmVtYXBfaW9zcGFjZShjb25zdCBz
dHJ1Y3QgcmVzb3VyY2UgKnJlcywgcGh5c19hZGRyX3QgcGh5c19hZGRyKQogCWlmIChyZXMtPmVu
ZCA+IElPX1NQQUNFX0xJTUlUKQogCQlyZXR1cm4gLUVJTlZBTDsKIAotCXJldHVybiBpb3JlbWFw
X3BhZ2VfcmFuZ2UodmFkZHIsIHZhZGRyICsgcmVzb3VyY2Vfc2l6ZShyZXMpLCBwaHlzX2FkZHIs
Ci0JCQkJICBwZ3Byb3RfZGV2aWNlKFBBR0VfS0VSTkVMKSk7CisJcmV0dXJuIHZtYXBfcGFnZV9y
YW5nZSh2YWRkciwgdmFkZHIgKyByZXNvdXJjZV9zaXplKHJlcyksIHBoeXNfYWRkciwKKwkJCSAg
ICAgICBwZ3Byb3RfZGV2aWNlKFBBR0VfS0VSTkVMKSk7CiAjZWxzZQogCS8qCiAJICogVGhpcyBh
cmNoaXRlY3R1cmUgZG9lcyBub3QgaGF2ZSBtZW1vcnkgbWFwcGVkIEkvTyBzcGFjZSwKZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgvaW8uaCBiL2luY2x1ZGUvbGludXgvaW8uaAppbmRleCA3MzA0
ZjJhNjk5NjAuLjIzNWJhN2Q4MGE4ZiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9pby5oCisr
KyBiL2luY2x1ZGUvbGludXgvaW8uaApAQCAtMjMsMTIgKzIzLDE5IEBAIHZvaWQgX19pb3dyaXRl
NjRfY29weSh2b2lkIF9faW9tZW0gKnRvLCBjb25zdCB2b2lkICpmcm9tLCBzaXplX3QgY291bnQp
OwogI2lmZGVmIENPTkZJR19NTVUKIGludCBpb3JlbWFwX3BhZ2VfcmFuZ2UodW5zaWduZWQgbG9u
ZyBhZGRyLCB1bnNpZ25lZCBsb25nIGVuZCwKIAkJICAgICAgIHBoeXNfYWRkcl90IHBoeXNfYWRk
ciwgcGdwcm90X3QgcHJvdCk7CitpbnQgdm1hcF9wYWdlX3JhbmdlKHVuc2lnbmVkIGxvbmcgYWRk
ciwgdW5zaWduZWQgbG9uZyBlbmQsCisJCSAgICBwaHlzX2FkZHJfdCBwaHlzX2FkZHIsIHBncHJv
dF90IHByb3QpOwogI2Vsc2UKIHN0YXRpYyBpbmxpbmUgaW50IGlvcmVtYXBfcGFnZV9yYW5nZSh1
bnNpZ25lZCBsb25nIGFkZHIsIHVuc2lnbmVkIGxvbmcgZW5kLAogCQkJCSAgICAgcGh5c19hZGRy
X3QgcGh5c19hZGRyLCBwZ3Byb3RfdCBwcm90KQogewogCXJldHVybiAwOwogfQorc3RhdGljIGlu
bGluZSBpbnQgdm1hcF9wYWdlX3JhbmdlKHVuc2lnbmVkIGxvbmcgYWRkciwgdW5zaWduZWQgbG9u
ZyBlbmQsCisJCQkJICBwaHlzX2FkZHJfdCBwaHlzX2FkZHIsIHBncHJvdF90IHByb3QpCit7CisJ
cmV0dXJuIDA7Cit9CiAjZW5kaWYKIAogLyoKZGlmZiAtLWdpdCBhL21tL3ZtYWxsb2MuYyBiL21t
L3ZtYWxsb2MuYwppbmRleCBlNWI4YzcwOTUwYmMuLjFlMzYzMjJkODNkOCAxMDA2NDQKLS0tIGEv
bW0vdm1hbGxvYy5jCisrKyBiL21tL3ZtYWxsb2MuYwpAQCAtMzA0LDExICszMDQsMjQgQEAgc3Rh
dGljIGludCB2bWFwX3JhbmdlX25vZmx1c2godW5zaWduZWQgbG9uZyBhZGRyLCB1bnNpZ25lZCBs
b25nIGVuZCwKIAlyZXR1cm4gZXJyOwogfQogCitpbnQgdm1hcF9wYWdlX3JhbmdlKHVuc2lnbmVk
IGxvbmcgYWRkciwgdW5zaWduZWQgbG9uZyBlbmQsCisJCSAgICBwaHlzX2FkZHJfdCBwaHlzX2Fk
ZHIsIHBncHJvdF90IHByb3QpCit7CisJaW50IGVycjsKKworCWVyciA9IHZtYXBfcmFuZ2Vfbm9m
bHVzaChhZGRyLCBlbmQsIHBoeXNfYWRkciwgcGdwcm90X254KHByb3QpLAorCQkJCSBpb3JlbWFw
X21heF9wYWdlX3NoaWZ0KTsKKwlmbHVzaF9jYWNoZV92bWFwKGFkZHIsIGVuZCk7CisJaWYgKCFl
cnIpCisJCWVyciA9IGttc2FuX2lvcmVtYXBfcGFnZV9yYW5nZShhZGRyLCBlbmQsIHBoeXNfYWRk
ciwgcHJvdCwKKwkJCQkJICAgICAgIGlvcmVtYXBfbWF4X3BhZ2Vfc2hpZnQpOworCXJldHVybiBl
cnI7Cit9CisKIGludCBpb3JlbWFwX3BhZ2VfcmFuZ2UodW5zaWduZWQgbG9uZyBhZGRyLCB1bnNp
Z25lZCBsb25nIGVuZCwKIAkJcGh5c19hZGRyX3QgcGh5c19hZGRyLCBwZ3Byb3RfdCBwcm90KQog
ewogCXN0cnVjdCB2bV9zdHJ1Y3QgKmFyZWE7Ci0JaW50IGVycjsKIAogCWFyZWEgPSBmaW5kX3Zt
X2FyZWEoKHZvaWQgKilhZGRyKTsKIAlpZiAoIWFyZWEgfHwgIShhcmVhLT5mbGFncyAmIFZNX0lP
UkVNQVApKSB7CkBAIC0zMjIsMTMgKzMzNSw3IEBAIGludCBpb3JlbWFwX3BhZ2VfcmFuZ2UodW5z
aWduZWQgbG9uZyBhZGRyLCB1bnNpZ25lZCBsb25nIGVuZCwKIAkJCSAgKGxvbmcpYXJlYS0+YWRk
ciArIGdldF92bV9hcmVhX3NpemUoYXJlYSkpOwogCQlyZXR1cm4gLUVSQU5HRTsKIAl9Ci0JZXJy
ID0gdm1hcF9yYW5nZV9ub2ZsdXNoKGFkZHIsIGVuZCwgcGh5c19hZGRyLCBwZ3Byb3RfbngocHJv
dCksCi0JCQkJIGlvcmVtYXBfbWF4X3BhZ2Vfc2hpZnQpOwotCWZsdXNoX2NhY2hlX3ZtYXAoYWRk
ciwgZW5kKTsKLQlpZiAoIWVycikKLQkJZXJyID0ga21zYW5faW9yZW1hcF9wYWdlX3JhbmdlKGFk
ZHIsIGVuZCwgcGh5c19hZGRyLCBwcm90LAotCQkJCQkgICAgICAgaW9yZW1hcF9tYXhfcGFnZV9z
aGlmdCk7Ci0JcmV0dXJuIGVycjsKKwlyZXR1cm4gdm1hcF9wYWdlX3JhbmdlKGFkZHIsIGVuZCwg
cGh5c19hZGRyLCBwcm90KTsKIH0KIAogc3RhdGljIHZvaWQgdnVubWFwX3B0ZV9yYW5nZShwbWRf
dCAqcG1kLCB1bnNpZ25lZCBsb25nIGFkZHIsIHVuc2lnbmVkIGxvbmcgZW5kLAotLSAKMi40My4w
Cgo=
--000000000000021009061329699e--

