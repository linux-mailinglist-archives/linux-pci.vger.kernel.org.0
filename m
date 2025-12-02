Return-Path: <linux-pci+bounces-42521-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51308C9CB46
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 20:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 391F14E39A8
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 19:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8F22D6400;
	Tue,  2 Dec 2025 19:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1kheNMz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451192D595F
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 19:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764702003; cv=none; b=LrQ7XUyVMCSbGsW669u/mtTFoYOH0eDffXT5yCcdxhsYT9ETdSMNq9JCb0/OqgrLqFPCprQ4eOGesarOj1jzYNb5pGUXBVLky0PtCppamF4Ry0XDpUYF0pvzB8XobyxZFrXKPUdAr0ICOs9TlMwJAsRnoyxRvp7KS4TZANujMHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764702003; c=relaxed/simple;
	bh=+8Kx/RKSMtWNWinBZiYyu99NjKMRNv0M7BAuSI3w5lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHdKsDXP0ebp2DlGkU1ukT+UXt5DJfxxmZ9+jlDsYrMIrAVgcfEsV1mVseMr3ZH4fPVb0XgdLJtaBtg/xrrp2cf6MBoVIp10cmJU48T1O/30K1aSzh6qhDNNVzY+6ioU/OsxsNGi0g2ITQVJz4d1eTNeHtZL4O8594g/5L4VjT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1kheNMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01586C4AF09
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 19:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764702003;
	bh=+8Kx/RKSMtWNWinBZiYyu99NjKMRNv0M7BAuSI3w5lk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f1kheNMzinnAeRsRuLZUDsI17v8fl8+SsartwZ1ExFU9dao9kOfUPcp7BjUyaAndd
	 wrFkscdQhHD3bi9bL4r+Yb36wtdFum3TKR8Xsf7B0VLeqEJ+19+AzgU1XkqA7foaIQ
	 WJb1yI7U3CwHuqv/FjGE/FnE+dnnrYlvqM01M8hENY2NLzHu48jpr7t12Y6GsD6fw8
	 ukkRFdtVVrkpcvwNWRkfxrHEqGcVWuivR+VCHQ96jQ7N1mrlTyc2RpC18WAdsP16eD
	 bgq95x2m+3mtoIDRUKg5pa1d3bWKe9kVmJnAr91OZhXKWx7yzsdv9+1SP4ZvMwEbtc
	 pjZnsMEnz3Asg==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6574d7e451dso2673074eaf.0
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 11:00:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXqk29CeNo+sF4PqxcMw0O7b1oJy+0E5p29MhVXBrdGYzOEPLEa7/JT+YNM7TXDZoGt36sGWNFt8IU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpdx/67is3lhMDx7zRci9xZzayWdHlp91vTMCyx0TxgHAhkq8o
	4C62bc9KO2jO/YJ0QPeu9tQWhfSuAyrwBqQMSInnQ5hfOGJAJ8ZSEqzdvhbw6XuJUCN+XxyY0nl
	bigc7vGrr2TlQgDijQPfqE5FweVk3hBQ=
X-Google-Smtp-Source: AGHT+IEhCqFcFogXA5HjK9wwNUYLHjHQW9N42O9EWpD5onKx8P72+r9ukp7b2fv8+HVHKpkbfrYhHCIcrIYbbzosgOM=
X-Received: by 2002:a05:6820:3083:b0:657:5f31:31b1 with SMTP id
 006d021491bc7-6579086d973mr17943998eaf.0.1764702002069; Tue, 02 Dec 2025
 11:00:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006120944.7880-1-spasswolf@web.de> <8edcc464-c467-4e83-a93b-19b92a2cf193@kernel.org>
 <4903e7c36adf377bcca289dbd3528055dc6cfb32.camel@web.de> <4a8302a0-209f-446a-9825-36cb267c1718@kernel.org>
 <25f36fa7-d1d6-4b81-a42f-64c445d6f065@amd.com> <1853e2af7f70cf726df278137b6d2d89d9d9dc82.camel@web.de>
 <f18bafacbd8316c9623658e2935f8fc3b276af64.camel@web.de> <26bf82303f661cdd34e4e8c16997e33eb21d1ee4.camel@web.de>
 <635b6cb19b5969bed7432dfd1cd651124e63aebb.camel@web.de> <18e472a0489ee5337465d5dc26685cebaf7c4f8d.camel@web.de>
 <3772b8f5-6d1a-403e-ad27-99a711e78902@kernel.org> <0cb75fae3a9cdb8dd82ca82348f4df919d34844d.camel@web.de>
 <ab51bd58919a31107caf8f8753804cb2dbfa791d.camel@web.de> <0719d985-1c09-4039-84c1-8736a1ca5e2d@amd.com>
 <3f790ee59129e5e49dd875526cb308cc4d97b99d.camel@web.de> <CAJZ5v0iRaYBU+1S4rqYR7D6XC+rfQ2+0hgbodweV5JsFr8EEnQ@mail.gmail.com>
 <b1fadb15d1869bde81315be7488c50dbbc9f7dbd.camel@web.de> <CAJZ5v0iAJN4eTdp9S=CKbMnVn78R7UnBKbLjBTdRhHebE0i7dA@mail.gmail.com>
 <8273a7755f90a3e41782f1d820dd9f0c22be78b7.camel@web.de> <CAJZ5v0i2T7HpV4jN6NJk=ruBvjecPRU2PyuYf0_TSPQU6FZ5rg@mail.gmail.com>
 <e807ca71fdef97c931fd9f92eda0f7551aa3ef7b.camel@web.de>
In-Reply-To: <e807ca71fdef97c931fd9f92eda0f7551aa3ef7b.camel@web.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Dec 2025 19:59:50 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0heOKxk8=4kwXcRLFfKhxYBX+ze_Dc2w90xrM14jvCirg@mail.gmail.com>
X-Gm-Features: AWmQ_blQf6Cws6WQHYHF5iTFRkdPJhmJxQN6vHdBwn-J7AI31AHzA8_SA8MDzbI
Message-ID: <CAJZ5v0heOKxk8=4kwXcRLFfKhxYBX+ze_Dc2w90xrM14jvCirg@mail.gmail.com>
Subject: Re: Crash during resume of pcie bridge due to infinite loop in ACPICA
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, regressions@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, acpica-devel@lists.linux.dev, 
	Robert Moore <robert.moore@intel.com>, Saket Dumbre <saket.dumbre@intel.com>
Content-Type: multipart/mixed; boundary="000000000000f7df120644fcb38c"

--000000000000f7df120644fcb38c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 9:47=E2=80=AFPM Bert Karwatzki <spasswolf@web.de> w=
rote:
>
> This is not an ACPICA problem after all:
>
> I did some more monitoring:
> https://gitlab.freedesktop.org/spasswolf/linux-stable/-/commits/amdgpu_su=
spend_resume?ref_type=3Dheads
> and I still get a crash, but perhaps due to the delays the printk()s caus=
ed I actually get a helpful error message in netconsole:
>
> T5971;ACPI BIOS Error (bug): Could not resolve symbol [\x5cM013.VARR], AE=
_NOT_FOUND (20240827/psargs-332)
> T5971;acpi_ps_complete_op returned 0x5
> T5971;acpi_ps_parse_aml_debug: parse loop returned =3D 0x5
> T5971;ACPI Error: Aborting method \x5cM013 due to previous error (AE_NOT_=
FOUND) (20240827/psparse-935)
> T5971;ACPI Error: Aborting method \x5cM017 due to previous error (AE_NOT_=
FOUND) (20240827/psparse-935)
> T5971;ACPI Error: Aborting method \x5cM019 due to previous error (AE_NOT_=
FOUND) (20240827/psparse-935)
> T5971;ACPI Error: Aborting method \x5c_SB.PCI0.GPP0.M439 due to previous =
error (AE_NOT_FOUND) (20240827/psparse-935)
> T5971;ACPI Error: Aborting method \x5c_SB.PCI0.GPP0.M241 due to previous =
error (AE_NOT_FOUND) (20240827/psparse-935)
> T5971;ACPI Error: Aborting method \x5c_SB.PCI0.GPP0.M237._ON due to previ=
ous error (AE_NOT_FOUND) (20240827/psparse-935)
> T5971;acpi_ps_parse_aml_debug: after walk loop
> T5971;acpi_ps_execute_method_debug 331
> T5971;acpi_ns_evaluate_debug 475 METHOD
> T5971;acpi_evaluate_object_debug 255
> T5971;__acpi_power_on_debug 369
> T5971;acpi_power_on_unlocked_debug 442
> T5971;acpi_power_on_unlocked_debug 446
> T5971;acpi_power_on_debug 471
> T5971;acpi_power_on_list_debug 649: result =3D -19
> T5971;pcieport 0000:00:01.1: pci_pm_default_resume_early 568#012 SUBSYSTE=
M=3Dpci#012 DEVICE=3D+pci:0000:00:01.1
> T5971;pcieport 0000:00:01.1: broken device, retraining non-functional dow=
nstream link at 2.5GT/s#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:00:01.1
> T5971;pcieport 0000:00:01.1: retraining failed#012 SUBSYSTEM=3Dpci#012 DE=
VICE=3D+pci:0000:00:01.1
> T5971;pcieport 0000:00:01.1: Data Link Layer Link Active not set in 1000 =
msec#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:00:01.1
> T5971;pcieport 0000:01:00.0: Unable to change power state from D3cold to =
D0, device inaccessible#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:01:00.0
>
> This shows that there seems to be no problem with ACPICA, and acpi_power_=
on_list(_debug)() returns -ENODEV,
> the crash occurs later.
>
> This leaves two question:
> 1. Is this crash avoidable by different error handling in the pci code?
> 2. If the crash is not avoidable, can we at least modify the error handli=
ng in such a way that
> we get an error message through netconsole by default? (perhaps a little =
delay will suffice)

I'm not sure how far this is going to get you, but you may try the
attached patch.

--000000000000f7df120644fcb38c
Content-Type: text/x-patch; charset="US-ASCII"; name="pci-pm-default-resume-early.patch"
Content-Disposition: attachment; 
	filename="pci-pm-default-resume-early.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mioxywk40>
X-Attachment-Id: f_mioxywk40

LS0tCiBkcml2ZXJzL3BjaS9wY2ktZHJpdmVyLmMgfCAgIDI3ICsrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0p
CgotLS0gYS9kcml2ZXJzL3BjaS9wY2ktZHJpdmVyLmMKKysrIGIvZHJpdmVycy9wY2kvcGNpLWRy
aXZlci5jCkBAIC01NTUsMTEgKzU1NSwxNiBAQCBzdGF0aWMgdm9pZCBwY2lfcG1fZGVmYXVsdF9y
ZXN1bWUoc3RydWN0CiAJcGNpX2VuYWJsZV93YWtlKHBjaV9kZXYsIFBDSV9EMCwgZmFsc2UpOwog
fQogCi1zdGF0aWMgdm9pZCBwY2lfcG1fZGVmYXVsdF9yZXN1bWVfZWFybHkoc3RydWN0IHBjaV9k
ZXYgKnBjaV9kZXYpCitzdGF0aWMgaW50IHBjaV9wbV9kZWZhdWx0X3Jlc3VtZV9lYXJseShzdHJ1
Y3QgcGNpX2RldiAqcGNpX2RldikKIHsKIAlwY2lfcG1fcG93ZXJfdXBfYW5kX3ZlcmlmeV9zdGF0
ZShwY2lfZGV2KTsKKwkvKiBCYWlsIG91dCBpZiB0aGUgZGV2aWNlIGlzIG5vdCBhY2Nlc3NpYmxl
LiAqLworCWlmIChwY2lfZGV2LT5jdXJyZW50X3N0YXRlID09IFBDSV9EM2NvbGQpCisJCXJldHVy
biAtRU5PREVWOworCiAJcGNpX3Jlc3RvcmVfc3RhdGUocGNpX2Rldik7CiAJcGNpX3BtZV9yZXN0
b3JlKHBjaV9kZXYpOworCXJldHVybiAwOwogfQogCiBzdGF0aWMgdm9pZCBwY2lfcG1fYnJpZGdl
X3Bvd2VyX3VwX2FjdGlvbnMoc3RydWN0IHBjaV9kZXYgKnBjaV9kZXYpCkBAIC05NTgsOCArOTYz
LDExIEBAIHN0YXRpYyBpbnQgcGNpX3BtX3Jlc3VtZV9ub2lycShzdHJ1Y3QgZGUKIAkgKiBjb25m
aWd1cmF0aW9uIGhlcmUgYW5kIGF0dGVtcHRpbmcgdG8gcHV0IHRoZW0gaW50byBEMCBhZ2FpbiBp
cwogCSAqIHBvaW50bGVzcywgc28gYXZvaWQgZG9pbmcgdGhhdC4KIAkgKi8KLQlpZiAoIShza2lw
X2J1c19wbSAmJiBwbV9zdXNwZW5kX25vX3BsYXRmb3JtKCkpKQotCQlwY2lfcG1fZGVmYXVsdF9y
ZXN1bWVfZWFybHkocGNpX2Rldik7CisJaWYgKCEoc2tpcF9idXNfcG0gJiYgcG1fc3VzcGVuZF9u
b19wbGF0Zm9ybSgpKSkgeworCQlpbnQgZXJyb3IgPSBwY2lfcG1fZGVmYXVsdF9yZXN1bWVfZWFy
bHkocGNpX2Rldik7CisJCWlmIChlcnJvcikKKwkJCXJldHVybiBlcnJvcjsKKwl9CiAKIAlwY2lf
Zml4dXBfZGV2aWNlKHBjaV9maXh1cF9yZXN1bWVfZWFybHksIHBjaV9kZXYpOwogCXBjaWVfcG1l
X3Jvb3Rfc3RhdHVzX2NsZWFudXAocGNpX2Rldik7CkBAIC0xMjIxLDggKzEyMjksMTIgQEAgc3Rh
dGljIGludCBwY2lfcG1fcmVzdG9yZV9ub2lycShzdHJ1Y3QgZAogewogCXN0cnVjdCBwY2lfZGV2
ICpwY2lfZGV2ID0gdG9fcGNpX2RldihkZXYpOwogCWNvbnN0IHN0cnVjdCBkZXZfcG1fb3BzICpw
bSA9IGRldi0+ZHJpdmVyID8gZGV2LT5kcml2ZXItPnBtIDogTlVMTDsKKwlpbnQgZXJyb3I7CisK
KwllcnJvciA9IHBjaV9wbV9kZWZhdWx0X3Jlc3VtZV9lYXJseShwY2lfZGV2KTsKKwlpZiAoZXJy
b3IpCisJCXJldHVybiBlcnJvcjsKIAotCXBjaV9wbV9kZWZhdWx0X3Jlc3VtZV9lYXJseShwY2lf
ZGV2KTsKIAlwY2lfZml4dXBfZGV2aWNlKHBjaV9maXh1cF9yZXN1bWVfZWFybHksIHBjaV9kZXYp
OwogCiAJaWYgKHBjaV9oYXNfbGVnYWN5X3BtX3N1cHBvcnQocGNpX2RldikpCkBAIC0xMzM5LDE0
ICsxMzUxLDE3IEBAIHN0YXRpYyBpbnQgcGNpX3BtX3J1bnRpbWVfcmVzdW1lKHN0cnVjdAogCXN0
cnVjdCBwY2lfZGV2ICpwY2lfZGV2ID0gdG9fcGNpX2RldihkZXYpOwogCWNvbnN0IHN0cnVjdCBk
ZXZfcG1fb3BzICpwbSA9IGRldi0+ZHJpdmVyID8gZGV2LT5kcml2ZXItPnBtIDogTlVMTDsKIAlw
Y2lfcG93ZXJfdCBwcmV2X3N0YXRlID0gcGNpX2Rldi0+Y3VycmVudF9zdGF0ZTsKLQlpbnQgZXJy
b3IgPSAwOworCWludCBlcnJvcjsKIAogCS8qCiAJICogUmVzdG9yaW5nIGNvbmZpZyBzcGFjZSBp
cyBuZWNlc3NhcnkgZXZlbiBpZiB0aGUgZGV2aWNlIGlzIG5vdCBib3VuZAogCSAqIHRvIGEgZHJp
dmVyIGJlY2F1c2UgYWx0aG91Z2ggd2UgbGVmdCBpdCBpbiBEMCwgaXQgbWF5IGhhdmUgZ29uZSB0
bwogCSAqIEQzY29sZCB3aGVuIHRoZSBicmlkZ2UgYWJvdmUgaXQgcnVudGltZSBzdXNwZW5kZWQu
CiAJICovCi0JcGNpX3BtX2RlZmF1bHRfcmVzdW1lX2Vhcmx5KHBjaV9kZXYpOworCWVycm9yID0g
cGNpX3BtX2RlZmF1bHRfcmVzdW1lX2Vhcmx5KHBjaV9kZXYpOworCWlmIChlcnJvcikKKwkJcmV0
dXJuIGVycm9yOworCiAJcGNpX3Jlc3VtZV9wdG0ocGNpX2Rldik7CiAKIAlpZiAoIXBjaV9kZXYt
PmRyaXZlcikK
--000000000000f7df120644fcb38c--

