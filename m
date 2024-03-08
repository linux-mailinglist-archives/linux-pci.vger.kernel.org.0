Return-Path: <linux-pci+bounces-4682-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73236876A45
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 18:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29645284E8E
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 17:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62CD28DAB;
	Fri,  8 Mar 2024 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtNPdRn5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309E31E4A9;
	Fri,  8 Mar 2024 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709920445; cv=none; b=FYM6/VnOxF1YHZuZn3CGDipJ74LMZlK988pjOqWHr0482n89WkO2bMhbop18qjm8CypjHxi29uF/ZAghKsOpleDCuZuyOUiUQgRcE/Xr/hG8l1Hxxgpe4/J07vXGpond3NDoJQp5zoAWUsrFDbhmt9sX3rculNkuYpsAqc6y0ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709920445; c=relaxed/simple;
	bh=dM3UyTzXgzvFe8I2m6xOz+egxrzqx1LEIDQEoFEtUeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRBTtpAYza1uxusurQBJyqPOdfnLAanhuA8x358PO/zh2VtQzJhad7MEZ9uyX3pXONiPhHK/GLajFbcShj9ms9hrvzJxl09xNhgT6QJsO5aJuXlLpyzrrodOVgG142KQpv172NMrC/GkSdFH2rKJVV8phNLjBUkZvG7/ZTuM1dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtNPdRn5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41318e93a08so5993795e9.0;
        Fri, 08 Mar 2024 09:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709920442; x=1710525242; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Mw+McdcxFAnpdx/ViHgy9nVmSU2zT8skvfM9vpAu60=;
        b=AtNPdRn5QWpq72J9UtMiok/thxAjCcCg0xsdJCtUJcxMdkz9nJtWmPj1sHxCAflHRv
         ldz7vOXVRRXd8at2DjWy0qhjwwZ6HRBnzO8BZmnkew8tJSqfufTgd7J70xahvMFkhD/Q
         bJKxmDeqmaspdxlHAnGNjp2UZFtQ0oPOXD/Az32nNmCqR7MJmafoooasVXOjW868mShI
         jxlhlvXPwESX0pq4WR4NkGVi7vbKOcQ/KTkJeL4IsNWW9UtZxV8H0bEW783w1n01A3j6
         b9WKC+7ZrdNaW3gtH+GDiiLToj19caCvOpD5kXNPEOC0lXITiROzm3Axurdnwsz5N9t/
         W+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709920442; x=1710525242;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Mw+McdcxFAnpdx/ViHgy9nVmSU2zT8skvfM9vpAu60=;
        b=cYS4TVwTtMF3dUeHHtU38Nbw80JB33gZfClVurragwVw8BHWjwB4Gi/w6hcW4/lfmL
         VIztu/OI9oAe+bDXmrGt6B0+sm90A9/naHXe4rByBBWJRp7asHVUEUzg44JlwCTlbB+E
         z+pqJowT/6mTAA2s/dMKcToTVIzgOLXzlzhRxTRH37KXgkhC9r5ThJdIfD9WXnxlZHsc
         +KRiAVcm8QPyux8a6/0Mxp69aQHs7+K7uzjYvGYYvYZjCo57QbUdzs+R9SniNrwV75Kx
         yGERbilZAkWSQtBuxOXgz46grLl/DmBD5F7I2s0EWSbVZBAlKXO6Q1LsDm+X34oh/Ikb
         BkJw==
X-Forwarded-Encrypted: i=1; AJvYcCWH/x8IvUMDdcSetuuDbKCeYn7UQ/JM/eazsIyK2S/HTn+dpRW47HyMc7y7QNEyTWfr+OmA5Pxtl5GRJHdoE68zuw1tALRD+MhmQrol9XchK7DosItIY4Tei4jwGdIO
X-Gm-Message-State: AOJu0YzbrRS+dZ5gygNbVzOnO9dS+J3SueDiykjFfrpNJKMJXZSmLt6q
	FF3PibClSU1MokK4+Q4ahvLPSqvwwgxmg+Eeql4b1GGD7uET3sPmf7OWVDctcgMAPIc48qn/aDP
	8YI/qXLBCVThw2XuB0mcNo1MxOAI=
X-Google-Smtp-Source: AGHT+IFRAOYPv4OI49F3Wk1hlCAbGkB8zoS9U0JuwKwZix9Dlwfpy2Yc09KuQcr2Yg3XXDO3eulEJ//C1lEmRk7Mwok=
X-Received: by 2002:adf:9b9a:0:b0:33e:78c2:ce7b with SMTP id
 d26-20020adf9b9a000000b0033e78c2ce7bmr1389011wrc.34.1709920442237; Fri, 08
 Mar 2024 09:54:02 -0800 (PST)
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
 <ZetEkyW1QgIKwfFz@infradead.org> <CAADnVQL4JAUz-p-X9aEggeKNpYUqJZrzQKO7N0dnohE0r7mdpg@mail.gmail.com>
 <ZetJ4xfopatYstPs@infradead.org>
In-Reply-To: <ZetJ4xfopatYstPs@infradead.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Mar 2024 09:53:50 -0800
Message-ID: <CAADnVQJKPa+JUUKpW7gZehbFBYj3GPrbpd0NCj4xwkU2puObEw@mail.gmail.com>
Subject: Re: vm_area at addr ffffffffc0800000 is not marked as VM_IOREMAP
To: Christoph Hellwig <hch@infradead.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000008e05b9061329e067"

--0000000000008e05b9061329e067
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 9:24=E2=80=AFAM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Fri, Mar 08, 2024 at 09:20:24AM -0800, Alexei Starovoitov wrote:
> > ok. Like the attached patch?
>
> Looks sensibe, but I think the powerpc callers of ioremap_page_range
> will need the same treatment.

Good point. Only one of the callers in arch/powerpc needs adjusting.
Found few other similar arch users.
See attached patch.

ioremap_page() in arch/arm/mm/ioremap.c is an interesting case.
It is EXPORT_SYMBOL, but there are no in-tree users.
I think we shouldn't apply checks to it,
since some out-of-tree module may fail.
I have no arm boards to test, I suggest we play safe than sorry.

--0000000000008e05b9061329e067
Content-Type: application/octet-stream; 
	name="0001-mm-Introduce-vmap_page_range-to-map-pages-in-PCI-add.patch"
Content-Disposition: attachment; 
	filename="0001-mm-Introduce-vmap_page_range-to-map-pages-in-PCI-add.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ltiyh1fx0>
X-Attachment-Id: f_ltiyh1fx0

RnJvbSBiZjgyODA2YTI4MDBiNDljNTYyN2JiZjA1NzQwNjI0NWQwNzE3Y2NkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFzdEBrZXJuZWwub3JnPgpE
YXRlOiBGcmksIDggTWFyIDIwMjQgMDk6MTI6NTQgLTA4MDAKU3ViamVjdDogW1BBVENIIGJwZi1u
ZXh0XSBtbTogSW50cm9kdWNlIHZtYXBfcGFnZV9yYW5nZSgpIHRvIG1hcCBwYWdlcyBpbiBQQ0kK
IGFkZHJlc3Mgc3BhY2UKCmlvcmVtYXBfcGFnZV9yYW5nZSgpIHNob3VsZCBiZSB1c2VkIGZvciBy
YW5nZXMgd2l0aGluIHZtYWxsb2MgcmFuZ2Ugb25seS4KVGhlIHZtYWxsb2MgcmFuZ2VzIGFyZSBh
bGxvY2F0ZWQgYnkgZ2V0X3ZtX2FyZWEoKS4gUENJIGhhcyAicmVzb3VyY2UiCmFsbG9jYXRvciB0
aGF0IG1hbmFnZXMgUENJX0lPQkFTRSwgSU9fU1BBQ0VfTElNSVQgYWRkcmVzcyByYW5nZSwgaGVu
Y2UKaW50cm9kdWNlIHZtYXBfcGFnZV9yYW5nZSgpIHRvIGJlIHVzZWQgZXhjbHVzaXZlbHkgdG8g
bWFwIHBhZ2VzCmluIFBDSSBhZGRyZXNzIHNwYWNlLgoKRml4ZXM6IDNlNDlhODY2YzlkYyAoIm1t
OiBFbmZvcmNlIFZNX0lPUkVNQVAgZmxhZyBhbmQgcmFuZ2UgaW4gaW9yZW1hcF9wYWdlX3Jhbmdl
LiIpClNpZ25lZC1vZmYtYnk6IEFsZXhlaSBTdGFyb3ZvaXRvdiA8YXN0QGtlcm5lbC5vcmc+Ci0t
LQogYXJjaC9hcm0vbW0vaW9yZW1hcC5jICAgICAgICAgICAgfCAgOCArKysrLS0tLQogYXJjaC9s
b29uZ2FyY2gva2VybmVsL3NldHVwLmMgICAgfCAgMiArLQogYXJjaC9taXBzL2xvb25nc29uNjQv
aW5pdC5jICAgICAgfCAgMiArLQogYXJjaC9wb3dlcnBjL2tlcm5lbC9pc2EtYnJpZGdlLmMgfCAg
NCArKy0tCiBkcml2ZXJzL3BjaS9wY2kuYyAgICAgICAgICAgICAgICB8ICA0ICsrLS0KIGluY2x1
ZGUvbGludXgvaW8uaCAgICAgICAgICAgICAgIHwgIDcgKysrKysrKwogbW0vdm1hbGxvYy5jICAg
ICAgICAgICAgICAgICAgICAgfCAyMyArKysrKysrKysrKysrKystLS0tLS0tLQogNyBmaWxlcyBj
aGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9h
cmNoL2FybS9tbS9pb3JlbWFwLmMgYi9hcmNoL2FybS9tbS9pb3JlbWFwLmMKaW5kZXggMjEyOTA3
MDA2NWMzLi43OTRjZmVhOWY5ZDQgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21tL2lvcmVtYXAuYwor
KysgYi9hcmNoL2FybS9tbS9pb3JlbWFwLmMKQEAgLTExMCw4ICsxMTAsOCBAQCB2b2lkIF9faW5p
dCBhZGRfc3RhdGljX3ZtX2Vhcmx5KHN0cnVjdCBzdGF0aWNfdm0gKnN2bSkKIGludCBpb3JlbWFw
X3BhZ2UodW5zaWduZWQgbG9uZyB2aXJ0LCB1bnNpZ25lZCBsb25nIHBoeXMsCiAJCSBjb25zdCBz
dHJ1Y3QgbWVtX3R5cGUgKm10eXBlKQogewotCXJldHVybiBpb3JlbWFwX3BhZ2VfcmFuZ2Uodmly
dCwgdmlydCArIFBBR0VfU0laRSwgcGh5cywKLQkJCQkgIF9fcGdwcm90KG10eXBlLT5wcm90X3B0
ZSkpOworCXJldHVybiB2bWFwX3BhZ2VfcmFuZ2UodmlydCwgdmlydCArIFBBR0VfU0laRSwgcGh5
cywKKwkJCSAgICAgICBfX3BncHJvdChtdHlwZS0+cHJvdF9wdGUpKTsKIH0KIEVYUE9SVF9TWU1C
T0woaW9yZW1hcF9wYWdlKTsKIApAQCAtNDY2LDggKzQ2Niw4IEBAIGludCBwY2lfcmVtYXBfaW9z
cGFjZShjb25zdCBzdHJ1Y3QgcmVzb3VyY2UgKnJlcywgcGh5c19hZGRyX3QgcGh5c19hZGRyKQog
CWlmIChyZXMtPmVuZCA+IElPX1NQQUNFX0xJTUlUKQogCQlyZXR1cm4gLUVJTlZBTDsKIAotCXJl
dHVybiBpb3JlbWFwX3BhZ2VfcmFuZ2UodmFkZHIsIHZhZGRyICsgcmVzb3VyY2Vfc2l6ZShyZXMp
LCBwaHlzX2FkZHIsCi0JCQkJICBfX3BncHJvdChnZXRfbWVtX3R5cGUocGNpX2lvcmVtYXBfbWVt
X3R5cGUpLT5wcm90X3B0ZSkpOworCXJldHVybiB2bWFwX3BhZ2VfcmFuZ2UodmFkZHIsIHZhZGRy
ICsgcmVzb3VyY2Vfc2l6ZShyZXMpLCBwaHlzX2FkZHIsCisJCQkgICAgICAgX19wZ3Byb3QoZ2V0
X21lbV90eXBlKHBjaV9pb3JlbWFwX21lbV90eXBlKS0+cHJvdF9wdGUpKTsKIH0KIEVYUE9SVF9T
WU1CT0wocGNpX3JlbWFwX2lvc3BhY2UpOwogCmRpZmYgLS1naXQgYS9hcmNoL2xvb25nYXJjaC9r
ZXJuZWwvc2V0dXAuYyBiL2FyY2gvbG9vbmdhcmNoL2tlcm5lbC9zZXR1cC5jCmluZGV4IDYzNGVm
MTdmZDM4Yi4uZmQ5MTVhZDY5YzA5IDEwMDY0NAotLS0gYS9hcmNoL2xvb25nYXJjaC9rZXJuZWwv
c2V0dXAuYworKysgYi9hcmNoL2xvb25nYXJjaC9rZXJuZWwvc2V0dXAuYwpAQCAtNDkwLDcgKzQ5
MCw3IEBAIHN0YXRpYyBpbnQgX19pbml0IGFkZF9sZWdhY3lfaXNhX2lvKHN0cnVjdCBmd25vZGVf
aGFuZGxlICpmd25vZGUsCiAJfQogCiAJdmFkZHIgPSAodW5zaWduZWQgbG9uZykoUENJX0lPQkFT
RSArIHJhbmdlLT5pb19zdGFydCk7Ci0JaW9yZW1hcF9wYWdlX3JhbmdlKHZhZGRyLCB2YWRkciAr
IHNpemUsIGh3X3N0YXJ0LCBwZ3Byb3RfZGV2aWNlKFBBR0VfS0VSTkVMKSk7CisJdm1hcF9wYWdl
X3JhbmdlKHZhZGRyLCB2YWRkciArIHNpemUsIGh3X3N0YXJ0LCBwZ3Byb3RfZGV2aWNlKFBBR0Vf
S0VSTkVMKSk7CiAKIAlyZXR1cm4gMDsKIH0KZGlmZiAtLWdpdCBhL2FyY2gvbWlwcy9sb29uZ3Nv
bjY0L2luaXQuYyBiL2FyY2gvbWlwcy9sb29uZ3NvbjY0L2luaXQuYwppbmRleCA1NTMxNDJjMWYx
NGYuLmEzNWRkNzMxMTc5NSAxMDA2NDQKLS0tIGEvYXJjaC9taXBzL2xvb25nc29uNjQvaW5pdC5j
CisrKyBiL2FyY2gvbWlwcy9sb29uZ3NvbjY0L2luaXQuYwpAQCAtMTgwLDcgKzE4MCw3IEBAIHN0
YXRpYyBpbnQgX19pbml0IGFkZF9sZWdhY3lfaXNhX2lvKHN0cnVjdCBmd25vZGVfaGFuZGxlICpm
d25vZGUsIHJlc291cmNlX3NpemVfCiAKIAl2YWRkciA9IFBDSV9JT0JBU0UgKyByYW5nZS0+aW9f
c3RhcnQ7CiAKLQlpb3JlbWFwX3BhZ2VfcmFuZ2UodmFkZHIsIHZhZGRyICsgc2l6ZSwgaHdfc3Rh
cnQsIHBncHJvdF9kZXZpY2UoUEFHRV9LRVJORUwpKTsKKwl2bWFwX3BhZ2VfcmFuZ2UodmFkZHIs
IHZhZGRyICsgc2l6ZSwgaHdfc3RhcnQsIHBncHJvdF9kZXZpY2UoUEFHRV9LRVJORUwpKTsKIAog
CXJldHVybiAwOwogfQpkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL2tlcm5lbC9pc2EtYnJpZGdl
LmMgYi9hcmNoL3Bvd2VycGMva2VybmVsL2lzYS1icmlkZ2UuYwppbmRleCA0OGUwZWFmMWFkNjEu
LjVjMDY0NDg1MTk3YSAxMDA2NDQKLS0tIGEvYXJjaC9wb3dlcnBjL2tlcm5lbC9pc2EtYnJpZGdl
LmMKKysrIGIvYXJjaC9wb3dlcnBjL2tlcm5lbC9pc2EtYnJpZGdlLmMKQEAgLTQ2LDggKzQ2LDgg
QEAgc3RhdGljIHZvaWQgcmVtYXBfaXNhX2Jhc2UocGh5c19hZGRyX3QgcGEsIHVuc2lnbmVkIGxv
bmcgc2l6ZSkKIAlXQVJOX09OX09OQ0Uoc2l6ZSAmIH5QQUdFX01BU0spOwogCiAJaWYgKHNsYWJf
aXNfYXZhaWxhYmxlKCkpIHsKLQkJaWYgKGlvcmVtYXBfcGFnZV9yYW5nZShJU0FfSU9fQkFTRSwg
SVNBX0lPX0JBU0UgKyBzaXplLCBwYSwKLQkJCQlwZ3Byb3Rfbm9uY2FjaGVkKFBBR0VfS0VSTkVM
KSkpCisJCWlmICh2bWFwX3BhZ2VfcmFuZ2UoSVNBX0lPX0JBU0UsIElTQV9JT19CQVNFICsgc2l6
ZSwgcGEsCisJCQkJICAgIHBncHJvdF9ub25jYWNoZWQoUEFHRV9LRVJORUwpKSkKIAkJCXZ1bm1h
cF9yYW5nZShJU0FfSU9fQkFTRSwgSVNBX0lPX0JBU0UgKyBzaXplKTsKIAl9IGVsc2UgewogCQll
YXJseV9pb3JlbWFwX3JhbmdlKElTQV9JT19CQVNFLCBwYSwgc2l6ZSwKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGNpL3BjaS5jIGIvZHJpdmVycy9wY2kvcGNpLmMKaW5kZXggYzM1ODUyMjljMTJhLi5j
Y2VlNTY2MTVmNzggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGNpL3BjaS5jCisrKyBiL2RyaXZlcnMv
cGNpL3BjaS5jCkBAIC00MzUzLDggKzQzNTMsOCBAQCBpbnQgcGNpX3JlbWFwX2lvc3BhY2UoY29u
c3Qgc3RydWN0IHJlc291cmNlICpyZXMsIHBoeXNfYWRkcl90IHBoeXNfYWRkcikKIAlpZiAocmVz
LT5lbmQgPiBJT19TUEFDRV9MSU1JVCkKIAkJcmV0dXJuIC1FSU5WQUw7CiAKLQlyZXR1cm4gaW9y
ZW1hcF9wYWdlX3JhbmdlKHZhZGRyLCB2YWRkciArIHJlc291cmNlX3NpemUocmVzKSwgcGh5c19h
ZGRyLAotCQkJCSAgcGdwcm90X2RldmljZShQQUdFX0tFUk5FTCkpOworCXJldHVybiB2bWFwX3Bh
Z2VfcmFuZ2UodmFkZHIsIHZhZGRyICsgcmVzb3VyY2Vfc2l6ZShyZXMpLCBwaHlzX2FkZHIsCisJ
CQkgICAgICAgcGdwcm90X2RldmljZShQQUdFX0tFUk5FTCkpOwogI2Vsc2UKIAkvKgogCSAqIFRo
aXMgYXJjaGl0ZWN0dXJlIGRvZXMgbm90IGhhdmUgbWVtb3J5IG1hcHBlZCBJL08gc3BhY2UsCmRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2lvLmggYi9pbmNsdWRlL2xpbnV4L2lvLmgKaW5kZXgg
NzMwNGYyYTY5OTYwLi4yMzViYTdkODBhOGYgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvaW8u
aAorKysgYi9pbmNsdWRlL2xpbnV4L2lvLmgKQEAgLTIzLDEyICsyMywxOSBAQCB2b2lkIF9faW93
cml0ZTY0X2NvcHkodm9pZCBfX2lvbWVtICp0bywgY29uc3Qgdm9pZCAqZnJvbSwgc2l6ZV90IGNv
dW50KTsKICNpZmRlZiBDT05GSUdfTU1VCiBpbnQgaW9yZW1hcF9wYWdlX3JhbmdlKHVuc2lnbmVk
IGxvbmcgYWRkciwgdW5zaWduZWQgbG9uZyBlbmQsCiAJCSAgICAgICBwaHlzX2FkZHJfdCBwaHlz
X2FkZHIsIHBncHJvdF90IHByb3QpOworaW50IHZtYXBfcGFnZV9yYW5nZSh1bnNpZ25lZCBsb25n
IGFkZHIsIHVuc2lnbmVkIGxvbmcgZW5kLAorCQkgICAgcGh5c19hZGRyX3QgcGh5c19hZGRyLCBw
Z3Byb3RfdCBwcm90KTsKICNlbHNlCiBzdGF0aWMgaW5saW5lIGludCBpb3JlbWFwX3BhZ2VfcmFu
Z2UodW5zaWduZWQgbG9uZyBhZGRyLCB1bnNpZ25lZCBsb25nIGVuZCwKIAkJCQkgICAgIHBoeXNf
YWRkcl90IHBoeXNfYWRkciwgcGdwcm90X3QgcHJvdCkKIHsKIAlyZXR1cm4gMDsKIH0KK3N0YXRp
YyBpbmxpbmUgaW50IHZtYXBfcGFnZV9yYW5nZSh1bnNpZ25lZCBsb25nIGFkZHIsIHVuc2lnbmVk
IGxvbmcgZW5kLAorCQkJCSAgcGh5c19hZGRyX3QgcGh5c19hZGRyLCBwZ3Byb3RfdCBwcm90KQor
eworCXJldHVybiAwOworfQogI2VuZGlmCiAKIC8qCmRpZmYgLS1naXQgYS9tbS92bWFsbG9jLmMg
Yi9tbS92bWFsbG9jLmMKaW5kZXggZTViOGM3MDk1MGJjLi4xZTM2MzIyZDgzZDggMTAwNjQ0Ci0t
LSBhL21tL3ZtYWxsb2MuYworKysgYi9tbS92bWFsbG9jLmMKQEAgLTMwNCwxMSArMzA0LDI0IEBA
IHN0YXRpYyBpbnQgdm1hcF9yYW5nZV9ub2ZsdXNoKHVuc2lnbmVkIGxvbmcgYWRkciwgdW5zaWdu
ZWQgbG9uZyBlbmQsCiAJcmV0dXJuIGVycjsKIH0KIAoraW50IHZtYXBfcGFnZV9yYW5nZSh1bnNp
Z25lZCBsb25nIGFkZHIsIHVuc2lnbmVkIGxvbmcgZW5kLAorCQkgICAgcGh5c19hZGRyX3QgcGh5
c19hZGRyLCBwZ3Byb3RfdCBwcm90KQoreworCWludCBlcnI7CisKKwllcnIgPSB2bWFwX3Jhbmdl
X25vZmx1c2goYWRkciwgZW5kLCBwaHlzX2FkZHIsIHBncHJvdF9ueChwcm90KSwKKwkJCQkgaW9y
ZW1hcF9tYXhfcGFnZV9zaGlmdCk7CisJZmx1c2hfY2FjaGVfdm1hcChhZGRyLCBlbmQpOworCWlm
ICghZXJyKQorCQllcnIgPSBrbXNhbl9pb3JlbWFwX3BhZ2VfcmFuZ2UoYWRkciwgZW5kLCBwaHlz
X2FkZHIsIHByb3QsCisJCQkJCSAgICAgICBpb3JlbWFwX21heF9wYWdlX3NoaWZ0KTsKKwlyZXR1
cm4gZXJyOworfQorCiBpbnQgaW9yZW1hcF9wYWdlX3JhbmdlKHVuc2lnbmVkIGxvbmcgYWRkciwg
dW5zaWduZWQgbG9uZyBlbmQsCiAJCXBoeXNfYWRkcl90IHBoeXNfYWRkciwgcGdwcm90X3QgcHJv
dCkKIHsKIAlzdHJ1Y3Qgdm1fc3RydWN0ICphcmVhOwotCWludCBlcnI7CiAKIAlhcmVhID0gZmlu
ZF92bV9hcmVhKCh2b2lkICopYWRkcik7CiAJaWYgKCFhcmVhIHx8ICEoYXJlYS0+ZmxhZ3MgJiBW
TV9JT1JFTUFQKSkgewpAQCAtMzIyLDEzICszMzUsNyBAQCBpbnQgaW9yZW1hcF9wYWdlX3Jhbmdl
KHVuc2lnbmVkIGxvbmcgYWRkciwgdW5zaWduZWQgbG9uZyBlbmQsCiAJCQkgIChsb25nKWFyZWEt
PmFkZHIgKyBnZXRfdm1fYXJlYV9zaXplKGFyZWEpKTsKIAkJcmV0dXJuIC1FUkFOR0U7CiAJfQot
CWVyciA9IHZtYXBfcmFuZ2Vfbm9mbHVzaChhZGRyLCBlbmQsIHBoeXNfYWRkciwgcGdwcm90X254
KHByb3QpLAotCQkJCSBpb3JlbWFwX21heF9wYWdlX3NoaWZ0KTsKLQlmbHVzaF9jYWNoZV92bWFw
KGFkZHIsIGVuZCk7Ci0JaWYgKCFlcnIpCi0JCWVyciA9IGttc2FuX2lvcmVtYXBfcGFnZV9yYW5n
ZShhZGRyLCBlbmQsIHBoeXNfYWRkciwgcHJvdCwKLQkJCQkJICAgICAgIGlvcmVtYXBfbWF4X3Bh
Z2Vfc2hpZnQpOwotCXJldHVybiBlcnI7CisJcmV0dXJuIHZtYXBfcGFnZV9yYW5nZShhZGRyLCBl
bmQsIHBoeXNfYWRkciwgcHJvdCk7CiB9CiAKIHN0YXRpYyB2b2lkIHZ1bm1hcF9wdGVfcmFuZ2Uo
cG1kX3QgKnBtZCwgdW5zaWduZWQgbG9uZyBhZGRyLCB1bnNpZ25lZCBsb25nIGVuZCwKLS0gCjIu
NDMuMAoK
--0000000000008e05b9061329e067--

