Return-Path: <linux-pci+bounces-13580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2065F9879C8
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 21:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91FC2B211AC
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 19:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6892A172BD5;
	Thu, 26 Sep 2024 19:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4OGyDi5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D06215AD9C;
	Thu, 26 Sep 2024 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727380410; cv=none; b=ZzQoPYj9/I7c0URcm4wzphrxhVt9zed3MR3iLN8YV3iVLm35/A5q0FGfyp5K2MQKbPwX5Uy0rTWenkgjkPEm1wpupZSSjWUqdlQ84RBw+fk0kFzgTS9EKhKg6O3709UHlKoJriruOYyoTR8TIrIJfIgImYHW0rwjm3OfCOvYXPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727380410; c=relaxed/simple;
	bh=GBl6AZCiyH0AHpBOXUejSjUQp7awTZ3QRZisiwzCxU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qi9P+8YaVOScr9vqcueHvAKm2zLia95XnXbOkTWHPEp2Yn++gcNrPxNaQ2lwyiAtU8PuB5laSiJaJdubpidUACDdmkKcLDPpewq8UMbyRPPg6A/tBTE5YOO2eS6A7b3BE179K0hcrvdHkqyZSPn1IMeZKHlZWo/HTLHXkvDFGYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4OGyDi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6821C4AF09;
	Thu, 26 Sep 2024 19:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727380409;
	bh=GBl6AZCiyH0AHpBOXUejSjUQp7awTZ3QRZisiwzCxU0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M4OGyDi5cve1pT9SV62/FgEfl98HGc6NUNIbWa5dvAdQMzoa4F0EF9HHN34/4NnwY
	 nnxnm12/+ACr46nFYwEjYdKxo5hzHVrVU+yWxu6g3HgT0Ws8zWMZahnlyA7CScWAcY
	 T3K4M9sTSsKATultqf19P88i0exGwcghSPLUo3Ecy+XbOu5VDOYk7X1VakE0kSYHsS
	 zQqSz48Je3dUSCNacqz9cFZGTC8J3CjJhUTUtkvrDhkncoilNapKGshHIrHJHZuHRE
	 SlhmNz4FA5gGNRImH+7c2kvQOC2/2aGWPLF25Tp+N5pfHUnIl+upKKGcA47pQajL0F
	 pNZ76PIFz/Now==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5e1c63c9822so723920eaf.0;
        Thu, 26 Sep 2024 12:53:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUq0BTAeBLV4D2soJCbK6gUBF3KoZRDAmXIyWKOtTDQjYNx1st7UMv0ifm/FJO7NeV+qdlgVafmma+o@vger.kernel.org, AJvYcCXh/9iacHGe9J1FP8BjZ89KeLjEGWKaUWf0Kdr0dUsmXvclKxuvDa0NngGuYBxY3FAm5Be86v/qh1OT@vger.kernel.org
X-Gm-Message-State: AOJu0YwDl0FuecEYgUkQ7sAbsagSE8mJkh92ENU80TcJnIN7pOJ3zglZ
	VljvWppRv6YrjIHRopGsbhSi2KcTfuT6C+D/H0q79JkkdMOBegD0q0+xGKdInlo214Gqe95LiO5
	rf8Ya07/om4PcVCokDN9g4ZpUX44=
X-Google-Smtp-Source: AGHT+IGfTciu8k8MtMrXi1yerNQVIyGGiGGREp+hRVvZ1R5J9R0WPtodq6tM5z6lm+gxQX1JMXjt5x7QIlaJa60B0/U=
X-Received: by 2002:a05:6820:160c:b0:5e5:7086:ebd8 with SMTP id
 006d021491bc7-5e7725c8c9cmr546877eaf.2.1727380409068; Thu, 26 Sep 2024
 12:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <EqPNlJ6f78UUE-J-5aIWtMWCwa2RUsGoVOePPCp9pMFhWHu9d7hAR0kzJtsLcWwt_RnUQP6Zs_7nUBbaYLPhuBz6I-0iJ_M8AdVGPaDwovA=@protonmail.com>
 <5068b802fb833cda3457e9cdbac7e6a5c82174d3.camel@intel.com>
In-Reply-To: <5068b802fb833cda3457e9cdbac7e6a5c82174d3.camel@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Sep 2024 21:53:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hP7s4YduPZoWpykaUk+dR9AG=bAW9nYpN3qVupqYkmEA@mail.gmail.com>
Message-ID: <CAJZ5v0hP7s4YduPZoWpykaUk+dR9AG=bAW9nYpN3qVupqYkmEA@mail.gmail.com>
Subject: Re: acpiphp module and Asus GA402RJ
To: "athul.krishna.kr@protonmail.com" <athul.krishna.kr@protonmail.com>
Cc: "Accardi, Kristen C" <kristen.c.accardi@intel.com>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Bjorn Helgaas <helgaas@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: multipart/mixed; boundary="000000000000ad149006230b17a7"

--000000000000ad149006230b17a7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC lists.

On Wed, Sep 25, 2024 at 8:36=E2=80=AFPM Accardi, Kristen C
<kristen.c.accardi@intel.com> wrote:
>
> On Wed, 2024-09-25 at 17:52 +0000, Athul Krishna wrote:
> > Device: Asus Zephyrus G14 GA402RJ
> > Kernel: 6.11
> > CPU: R7 67800H
> > GPU: RX 6700S
> >
> > Hello Kristen,
> >
> > I'd like provide feedback on the acpiphp module. My laptop is all
> > AMD(CPU+GPU). So the discrete gpu: \_SB_.PCI0.GPP0.SWUS.SWDS.VGA_,
> > and the hotplug bridge: \_SB_.PCI0.GPP0. And there's two PCI-PCI
> > bridges: SWUS and SWDS.
> >
> > Eject notification on the discrete GPU, will remove the GPU, and the
> > two PCI bridges.
> >
> > The issue I've encountered is, Device check notification cannot reach
> > GPU, as it's hotplug context is lost, with the current implementation
> > of acpiphp(acpiphp_glue.c) module.
> >
> >
> > I hope this helps. Also a small disclaimer: I'm a newbie to Linux
> > kernel internals. So I might be limited in the help I can provide.
> > I can provide dmesg logs or ACPI tables if required.
> >
> > Thanks & Regards,
> > Athul
>
> Hi Athul,
> I think that Rafael might be maintaining this driver these days. I've
> copied him on this reply.

I don't maintain it (Bjorn does that AFAICS), but I may be one of the
developers who have touched it most recently.

In any case, I don't think it is at fault here, but firmware
expectations that go beyond provisions made by the ACPI specification:

https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#dev=
ice-object-notifications

because it seems to really want to trigger a bus rescan starting from
a device that has been discovered already that will lead to a
discovery of a specific "new" device along with its parent.  Sending a
device check notification on a device that has not been discovered yet
and whose parent has not been discovered yet either may reasonably be
regarded as unsuitable for this purpose.

That said, it appears to be possible to adjust the generic ACPI device
notification handling code to take this firmware behavior into account
kind of as expected.  That is, if a device check notification is
received on a device object without a hotplug context, look for its
closest ancestor that has a hotplug context or otherwise can handle
hotplug and trigger a bus check from it as though it got a bus check
notification.

Please check the attached (completely untested) patch.

--000000000000ad149006230b17a7
Content-Type: text/x-patch; charset="US-ASCII"; name="acpi-hotplig-extend.patch"
Content-Disposition: attachment; filename="acpi-hotplig-extend.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m1jozn720>
X-Attachment-Id: f_m1jozn720

LS0tCiBkcml2ZXJzL2FjcGkvc2Nhbi5jIHwgICA3OSArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNTIgaW5zZXJ0aW9u
cygrKSwgMjcgZGVsZXRpb25zKC0pCgpJbmRleDogbGludXgtcG0vZHJpdmVycy9hY3BpL3NjYW4u
Ywo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09Ci0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvYWNwaS9zY2FuLmMKKysrIGxp
bnV4LXBtL2RyaXZlcnMvYWNwaS9zY2FuLmMKQEAgLTQzNSw0MiArNDM1LDY4IEBAIHN0YXRpYyBp
bnQgYWNwaV9nZW5lcmljX2hvdHBsdWdfZXZlbnQoc3QKIAlyZXR1cm4gLUVJTlZBTDsKIH0KIAot
dm9pZCBhY3BpX2RldmljZV9ob3RwbHVnKHN0cnVjdCBhY3BpX2RldmljZSAqYWRldiwgdTMyIHNy
YykKK3N0YXRpYyBpbnQgYWNwaV9kZXZpY2VfaG90cGx1Z19ub3RpZnkoc3RydWN0IGFjcGlfZGV2
aWNlICphZGV2LCB1MzIgdHlwZSkKIHsKLQl1MzIgb3N0X2NvZGUgPSBBQ1BJX09TVF9TQ19OT05f
U1BFQ0lGSUNfRkFJTFVSRTsKLQlpbnQgZXJyb3IgPSAtRU5PREVWOworCXdoaWxlIChhZGV2KSB7
CisJCS8qCisJCSAqIFRoZSBkZXZpY2Ugb2JqZWN0J3MgQUNQSSBoYW5kbGUgY2Fubm90IGJlY29t
ZSBpbnZhbGlkIGFzIGxvbmcKKwkJICogYXMgYWNwaV9zY2FuX2xvY2sgaXMgYmVpbmcgaGVsZCwg
YnV0IGl0IG1pZ2h0IGhhdmUgYmVjb21lCisJCSAqIGludmFsaWQgYmVmb3JlIHRoYXQgbG9jayB3
YXMgYWNxdWlyZWQuCisJCSAqLworCQlpZiAoYWRldi0+aGFuZGxlID09IElOVkFMSURfQUNQSV9I
QU5ETEUpCisJCQlyZXR1cm4gLUVOT0RFVjsKIAotCWxvY2tfZGV2aWNlX2hvdHBsdWcoKTsKLQlt
dXRleF9sb2NrKCZhY3BpX3NjYW5fbG9jayk7CisJCWlmIChhZGV2LT5mbGFncy5pc19kb2NrX3N0
YXRpb24pCisJCQlyZXR1cm4gZG9ja19ub3RpZnkoYWRldiwgdHlwZSk7CiAKLQkvKgotCSAqIFRo
ZSBkZXZpY2Ugb2JqZWN0J3MgQUNQSSBoYW5kbGUgY2Fubm90IGJlY29tZSBpbnZhbGlkIGFzIGxv
bmcgYXMgd2UKLQkgKiBhcmUgaG9sZGluZyBhY3BpX3NjYW5fbG9jaywgYnV0IGl0IG1pZ2h0IGhh
dmUgYmVjb21lIGludmFsaWQgYmVmb3JlCi0JICogdGhhdCBsb2NrIHdhcyBhY3F1aXJlZC4KLQkg
Ki8KLQlpZiAoYWRldi0+aGFuZGxlID09IElOVkFMSURfQUNQSV9IQU5ETEUpCi0JCWdvdG8gZXJy
X291dDsKLQotCWlmIChhZGV2LT5mbGFncy5pc19kb2NrX3N0YXRpb24pIHsKLQkJZXJyb3IgPSBk
b2NrX25vdGlmeShhZGV2LCBzcmMpOwotCX0gZWxzZSBpZiAoYWRldi0+ZmxhZ3MuaG90cGx1Z19u
b3RpZnkpIHsKLQkJZXJyb3IgPSBhY3BpX2dlbmVyaWNfaG90cGx1Z19ldmVudChhZGV2LCBzcmMp
OwotCX0gZWxzZSB7Ci0JCWFjcGlfaHBfbm90aWZ5IG5vdGlmeTsKKwkJaWYgKGFkZXYtPmZsYWdz
LmhvdHBsdWdfbm90aWZ5KQorCQkJcmV0dXJuIGFjcGlfZ2VuZXJpY19ob3RwbHVnX2V2ZW50KGFk
ZXYsIHR5cGUpOwogCiAJCWFjcGlfbG9ja19ocF9jb250ZXh0KCk7Ci0JCW5vdGlmeSA9IGFkZXYt
PmhwID8gYWRldi0+aHAtPm5vdGlmeSA6IE5VTEw7CisKKwkJaWYgKGFkZXYtPmhwKSB7CisJCQlh
Y3BpX2hwX25vdGlmeSBub3RpZnkgPSBhZGV2LT5ocC0+bm90aWZ5OworCisJCQlhY3BpX3VubG9j
a19ocF9jb250ZXh0KCk7CisKKwkJCWlmIChXQVJOX09OX09OQ0UoIW5vdGlmeSkpCisJCQkJcmV0
dXJuIC1FSU5WQUw7CisKKwkJCXJldHVybiBub3RpZnkoYWRldiwgdHlwZSk7CisJCX0KKwogCQlh
Y3BpX3VubG9ja19ocF9jb250ZXh0KCk7CisKIAkJLyoKIAkJICogVGhlcmUgbWF5IGJlIGFkZGl0
aW9uYWwgbm90aWZ5IGhhbmRsZXJzIGZvciBkZXZpY2Ugb2JqZWN0cwotCQkgKiB3aXRob3V0IHRo
ZSAuZXZlbnQoKSBjYWxsYmFjaywgc28gaWdub3JlIHRoZW0gaGVyZS4KKwkJICogd2l0aG91dCB0
aGUgLmV2ZW50KCkgY2FsbGJhY2ssIHNvIGlnbm9yZSB0aGVtIGhlcmUsIGJ1dCBpZgorCQkgKiB0
aGUgbm90aWZpY2F0aW9uIHR5cGUgaXMgZWl0aGVyIEFDUElfTk9USUZZX0RFVklDRV9DSEVDSyBv
cgorCQkgKiBBQ1BJX05PVElGWV9CVVNfQ0hFQ0ssIHByb3BhZ2F0ZSB0byB0aGUgcGFyZW50IGFu
ZCBhYm92ZSBpdC4KIAkJICovCi0JCWlmIChub3RpZnkpCi0JCQllcnJvciA9IG5vdGlmeShhZGV2
LCBzcmMpOwotCQllbHNlCi0JCQlnb3RvIG91dDsKKwkJaWYgKHR5cGUgPT0gQUNQSV9OT1RJRllf
REVWSUNFX0NIRUNLKQorCQkJdHlwZSA9IEFDUElfTk9USUZZX0JVU19DSEVDSzsKKwkJZWxzZSBp
ZiAodHlwZSAhPSBBQ1BJX05PVElGWV9CVVNfQ0hFQ0spCisJCQlyZXR1cm4gMTsKKworCQlhZGV2
ID0gYWNwaV9kZXZfcGFyZW50KGFkZXYpOwogCX0KLQlzd2l0Y2ggKGVycm9yKSB7CisKKwlyZXR1
cm4gLUVOT0RFVjsKK30KKwordm9pZCBhY3BpX2RldmljZV9ob3RwbHVnKHN0cnVjdCBhY3BpX2Rl
dmljZSAqYWRldiwgdTMyIHNyYykKK3sKKwl1MzIgb3N0X2NvZGUgPSBBQ1BJX09TVF9TQ19OT05f
U1BFQ0lGSUNfRkFJTFVSRTsKKwlpbnQgcmV0OworCisJbG9ja19kZXZpY2VfaG90cGx1ZygpOwor
CW11dGV4X2xvY2soJmFjcGlfc2Nhbl9sb2NrKTsKKworCXJldCA9IGFjcGlfZGV2aWNlX2hvdHBs
dWdfbm90aWZ5KGFkZXYsIHNyYyk7CisJaWYgKHJldCA+IDApCisJCWdvdG8gb3V0OworCisJc3dp
dGNoIChyZXQpIHsKIAljYXNlIDA6CiAJCW9zdF9jb2RlID0gQUNQSV9PU1RfU0NfU1VDQ0VTUzsK
IAkJYnJlYWs7CkBAIC00ODUsNyArNTExLDYgQEAgdm9pZCBhY3BpX2RldmljZV9ob3RwbHVnKHN0
cnVjdCBhY3BpX2RldgogCQlicmVhazsKIAl9CiAKLSBlcnJfb3V0OgogCWFjcGlfZXZhbHVhdGVf
b3N0KGFkZXYtPmhhbmRsZSwgc3JjLCBvc3RfY29kZSwgTlVMTCk7CiAKICBvdXQ6Cg==
--000000000000ad149006230b17a7--

