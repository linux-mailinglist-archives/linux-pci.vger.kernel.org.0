Return-Path: <linux-pci+bounces-4635-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32599875CDE
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 04:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 013F81C20BCB
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 03:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4052C68E;
	Fri,  8 Mar 2024 03:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KR9FmOTt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755F323741;
	Fri,  8 Mar 2024 03:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709869771; cv=none; b=ExrMtbIAJ/wWdupRIq2pgyAPP5dpJd41263L0XBvdoK9yHZ+wuYR/I93EDxoXHfJWWARbz5Hpsrh0IyyOqgTS5lMV2E6sn+U+foGgFaOyF6VwT8PxGdo2wMlKEcLI1uQzhwMBmT+KK7DXp65eiB5ngJbXvvap0eWAQDU1drQbXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709869771; c=relaxed/simple;
	bh=F4zU7D6HPe9hWwYeKpLKioI6WEJUIZuDx2NIFay9Cdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muxmCZaiOe8AxcIv6l7d/TIXgUME2VOdB/YHxqkeEOerGOVOT63quOJxXaZzgsDFPGhgLQZCh5Fzhu/z6eKLt8VotP4fhmkK1MKxY2T/95ECfR9VxWZ4ILgNSpedMpi7TtAD8pEbkk/SxRU3QsiIA8OvJ1yVAyWOM+AquOXRb9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KR9FmOTt; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a45ba1f8e89so217116366b.1;
        Thu, 07 Mar 2024 19:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709869768; x=1710474568; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e8ZzEOeqwXaF+/K/gLza7Lv335pwHs3+S/P5LcnAwfs=;
        b=KR9FmOTt74tYxPazPx+RixafzIaHgqpZ8BCwN9h9LjnlAOYnxHbh7AYiCdXlGOmZHy
         /JX0Lz3gV4cj/J9/mHv4aYzSPDkkngf8wuRgQ72YGYCXxr95WbvR+V3AQUWsgzRXB4PN
         BvOSwBuX7H5jhM8ISQgYEQd3BRD3qD4nDW2pPw1md3a8mmNF8OSKgi8uzUTeiqB//WDw
         /VOR2ozteHD/yY1EPKgghEdQxk97hkuFWDmecepyPySCo52R4sx1dL5SLvkenb3VfJtl
         lbcsHeu6Pk+QtkKU6aRWrGXRUgo3Ko9AWOfYtD+OxqEC/57P1T60tkbLvTOlLD5IVog7
         KagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709869768; x=1710474568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8ZzEOeqwXaF+/K/gLza7Lv335pwHs3+S/P5LcnAwfs=;
        b=mI8lea6eeWXdCR2zhno4/Q7QaCtIx2tsg1zqefznoBZU1I3J1REzspOY5UVDy+Dp69
         bzoDJnMzLwzEIVHUE0khcZuA4/4Q0eAPsaHAgmq1Iu2heww+Owq5z51lXH5UrqsMnwbI
         M/snjRC59lRvH7yyX1ZWpe1nEKA3B/BV+JxZdI7gFU8S7oIZer+l3tuwDmgWvfA8A7ff
         OV2FuedgKDl9XG9p5xwt8rkCU5Rs5gN+psEJI6IPLSGN1t/BMQVZ3yDkWWhNhqUA1uGz
         ONExRT7oKIAe/64WNUI+g85azmd+4Xzpk2DtGV2c2QZb/Tw8BEA0whtP2XNO44q+G9qR
         YHyA==
X-Forwarded-Encrypted: i=1; AJvYcCWmH2tWhVWP2GTl2mya0M/hgTqqRe0hYnVQ7HENlLse+axkUjPwfXol6QYUUPkI6xKTLmTeplqwSC8Ue242C5aLPDMCGqF4co3kUElPHioEY32qJBNgQDS/iYt6Fk7K
X-Gm-Message-State: AOJu0YwkvWa/46Pt9aQAIxVEDL3x3t4Fw200GPFtZmH5EsQGZHUIhNYY
	JUuF3ACBNJKKJO600z/JT2TRIeq9tqheJlyfuslfGgM0i0WUkRpB66cuoL1w3IHapmTAqg50CZ1
	KIEQceqHbBjmZKFN21GHJJh9K62Y=
X-Google-Smtp-Source: AGHT+IEz3ttpI0orlvLB4AJ+nczG2zehj++7TffijNDU0t/tCUA5dTFH+dzs38O3DWeWHMtb93KUEZ6RhDCAs5+at2o=
X-Received: by 2002:a17:906:364d:b0:a3e:a712:ba9d with SMTP id
 r13-20020a170906364d00b00a3ea712ba9dmr13521012ejb.4.1709869767603; Thu, 07
 Mar 2024 19:49:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72ka4rir+RTN2FQoT=Vvprp_Ao-CvoYEkSNqtSY+RZj+AA@mail.gmail.com>
 <CAADnVQL1Zt5dwFv9HPDKDuPEKa6V7gb5j-D-LPWv47hC6mtwgw@mail.gmail.com>
In-Reply-To: <CAADnVQL1Zt5dwFv9HPDKDuPEKa6V7gb5j-D-LPWv47hC6mtwgw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 7 Mar 2024 19:49:16 -0800
Message-ID: <CAADnVQLP=dxBb+RiMGXoaCEuRrbK387J6B+pfzWKF_F=aRgCPQ@mail.gmail.com>
Subject: Re: vm_area at addr ffffffffc0800000 is not marked as VM_IOREMAP
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000001c584e06131e1443"

--0000000000001c584e06131e1443
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 9:54=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 7, 2024 at 9:42=E2=80=AFAM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > Hi arm64/bpf/pci,
> >
> > In today's next-20240307 with a defconfig LLVM=3D1 I am seeing [1] unde=
r
> > QEMU virt, i.e. from
> > https://lore.kernel.org/all/20240305030516.41519-2-alexei.starovoitov@g=
mail.com/
> > applied to the bpf-next tree.
> >
> > Cheers,
> > Miguel
> >
> > [1]
> >
> > [    0.425177] pci-host-generic 4010000000.pcie: host bridge
> > /pcie@10000000 ranges:
> > [    0.425886] pci-host-generic 4010000000.pcie:       IO
> > 0x003eff0000..0x003effffff -> 0x0000000000
> > [    0.426534] pci-host-generic 4010000000.pcie:      MEM
> > 0x0010000000..0x003efeffff -> 0x0010000000
> > [    0.426764] pci-host-generic 4010000000.pcie:      MEM
> > 0x8000000000..0xffffffffff -> 0x8000000000
> > [    0.427324] ------------[ cut here ]------------
> > [    0.427456] vm_area at addr ffffffffc0800000 is not marked as VM_IOR=
EMAP
> > [    0.427944] WARNING: CPU: 0 PID: 1 at mm/vmalloc.c:315
> > ioremap_page_range+0x25c/0x2bc
>
> Great. Thanks for flagging.
> Looks like this check found some misuse of ioremap_page_range.
>
> Note that without marking the address range as VM_IOREMAP
> the vread_iter() will be bulk reading over IO and might
> cause hard hangs and what not.
> pci drivers need to mark their range as VM_IOREMAP.
> That was the reason for the warning.
>
> I'll try to figure out which piece of code missed passing
> VM_IOREMAP into vm_area.
> I'm not familiar with pci, so help is greatly appreciated.

Ok. I think I figured it out.
Please try the attached patch.

--0000000000001c584e06131e1443
Content-Type: application/octet-stream; 
	name="0001-mm-Enforce-range-of-ioremap_page_range-when-it-s-ins.patch"
Content-Disposition: attachment; 
	filename="0001-mm-Enforce-range-of-ioremap_page_range-when-it-s-ins.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lti4ahb30>
X-Attachment-Id: f_lti4ahb30

RnJvbSBiNDQ2NTM0ZjJkYzVjNDhkOGFiMDdjNjhlNzk2NDhmNDIyMzhmZWY4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFzdEBrZXJuZWwub3JnPgpE
YXRlOiBUaHUsIDcgTWFyIDIwMjQgMTk6NDE6NDUgLTA4MDAKU3ViamVjdDogW1BBVENIIGJwZi1u
ZXh0XSBtbTogRW5mb3JjZSByYW5nZSBvZiBpb3JlbWFwX3BhZ2VfcmFuZ2Ugd2hlbiBpdCdzCiBp
bnNpZGUgdm1hbGxvYyByYW5nZQoKUENJIGFkZHJlc3MgcmFuZ2UgaXMgbWFuYWdlZCBpbmRlcGVu
ZGVudGx5IGZyb20gdm1hbGxvYyByYW5nZS4KRW5mb3JjZSBmbGFncyBhbmQgcmFuZ2UgaW4gaW9y
ZW1hcF9wYWdlX3JhbmdlKCkgb25seSB3aGVuCnRoZSBzdGFydCBhZGRyZXNzIGlzIHdpdGhpbiB2
bWFsbG9jIHJhbmdlIGFsbG9jYXRlZCBieSBnZXRfdm1fYXJlYSgpLgoKRml4ZXM6IDNlNDlhODY2
YzlkYyAoIm1tOiBFbmZvcmNlIFZNX0lPUkVNQVAgZmxhZyBhbmQgcmFuZ2UgaW4gaW9yZW1hcF9w
YWdlX3JhbmdlLiIpClNpZ25lZC1vZmYtYnk6IEFsZXhlaSBTdGFyb3ZvaXRvdiA8YXN0QGtlcm5l
bC5vcmc+Ci0tLQogbW0vdm1hbGxvYy5jIHwgMjMgKysrKysrKysrKysrKy0tLS0tLS0tLS0KIDEg
ZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9tbS92bWFsbG9jLmMgYi9tbS92bWFsbG9jLmMKaW5kZXggZTViOGM3MDk1MGJjLi4xN2Vi
MGY5NzRlMGYgMTAwNjQ0Ci0tLSBhL21tL3ZtYWxsb2MuYworKysgYi9tbS92bWFsbG9jLmMKQEAg
LTMxMSwxNiArMzExLDE5IEBAIGludCBpb3JlbWFwX3BhZ2VfcmFuZ2UodW5zaWduZWQgbG9uZyBh
ZGRyLCB1bnNpZ25lZCBsb25nIGVuZCwKIAlpbnQgZXJyOwogCiAJYXJlYSA9IGZpbmRfdm1fYXJl
YSgodm9pZCAqKWFkZHIpOwotCWlmICghYXJlYSB8fCAhKGFyZWEtPmZsYWdzICYgVk1fSU9SRU1B
UCkpIHsKLQkJV0FSTl9PTkNFKDEsICJ2bV9hcmVhIGF0IGFkZHIgJWx4IGlzIG5vdCBtYXJrZWQg
YXMgVk1fSU9SRU1BUFxuIiwgYWRkcik7Ci0JCXJldHVybiAtRUlOVkFMOwotCX0KLQlpZiAoYWRk
ciAhPSAodW5zaWduZWQgbG9uZylhcmVhLT5hZGRyIHx8Ci0JICAgICh2b2lkICopZW5kICE9IGFy
ZWEtPmFkZHIgKyBnZXRfdm1fYXJlYV9zaXplKGFyZWEpKSB7Ci0JCVdBUk5fT05DRSgxLCAiaW9y
ZW1hcCByZXF1ZXN0IFslbHgsJWx4KSBkb2Vzbid0IG1hdGNoIHZtX2FyZWEgWyVseCwgJWx4KVxu
IiwKLQkJCSAgYWRkciwgZW5kLCAobG9uZylhcmVhLT5hZGRyLAotCQkJICAobG9uZylhcmVhLT5h
ZGRyICsgZ2V0X3ZtX2FyZWFfc2l6ZShhcmVhKSk7Ci0JCXJldHVybiAtRVJBTkdFOworCWlmIChh
cmVhKSB7CisJCWlmICghKGFyZWEtPmZsYWdzICYgVk1fSU9SRU1BUCkpIHsKKwkJCVdBUk5fT05D
RSgxLCAidm1fYXJlYSBhdCBhZGRyICVseCBpcyBub3QgbWFya2VkIGFzIFZNX0lPUkVNQVBcbiIs
CisJCQkJICBhZGRyKTsKKwkJCXJldHVybiAtRUlOVkFMOworCQl9CisJCWlmIChhZGRyICE9ICh1
bnNpZ25lZCBsb25nKWFyZWEtPmFkZHIgfHwKKwkJICAgICh2b2lkICopZW5kICE9IGFyZWEtPmFk
ZHIgKyBnZXRfdm1fYXJlYV9zaXplKGFyZWEpKSB7CisJCQlXQVJOX09OQ0UoMSwgImlvcmVtYXAg
cmVxdWVzdCBbJWx4LCVseCkgZG9lc24ndCBtYXRjaCB2bV9hcmVhIFslbHgsICVseClcbiIsCisJ
CQkJICBhZGRyLCBlbmQsIChsb25nKWFyZWEtPmFkZHIsCisJCQkJICAobG9uZylhcmVhLT5hZGRy
ICsgZ2V0X3ZtX2FyZWFfc2l6ZShhcmVhKSk7CisJCQlyZXR1cm4gLUVSQU5HRTsKKwkJfQogCX0K
IAllcnIgPSB2bWFwX3JhbmdlX25vZmx1c2goYWRkciwgZW5kLCBwaHlzX2FkZHIsIHBncHJvdF9u
eChwcm90KSwKIAkJCQkgaW9yZW1hcF9tYXhfcGFnZV9zaGlmdCk7Ci0tIAoyLjQzLjAKCg==
--0000000000001c584e06131e1443--

