Return-Path: <linux-pci+bounces-20422-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 191E6A1DCFC
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 20:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ABEC1882EAE
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 19:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B160C192D77;
	Mon, 27 Jan 2025 19:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMNiz1n8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813A21917F1;
	Mon, 27 Jan 2025 19:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738007860; cv=none; b=YwKRAgmbXEUb93PqUt9zDq/h+ONgq6kz1dke8s6VCrP/gMqHh6VAfI2Gb1ysWfJk3LH/3nET65Zm7UlFDgEdu2Yd+qhmhMN6q3hr0XIeDLTime0tdSwdZ+FqiGx7XaMFHzxB7iZEsUer9ojFlAu1MIlMszmjctdZfqcPvWhQ+7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738007860; c=relaxed/simple;
	bh=0FQQNYJHrCHJeLMJ2LS4Zd/Go9CcRwLyMKTld/I0v8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFH/vk43iAWF+Kbf73WR19o0lpzfK5NnAF0u+tw/28MafJlTYdzhKO6P8RhK9mY4n/s0gM9laVXK/TCOpgG5bJ4JTH0vjm6gPezeEFOJl50tX/1z8AwIc5U3/GdPPmyl4U7nBss/+0MVhC4L4BdqGFYz9ePsL8PoxNfAPUsc6hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMNiz1n8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C73C4CEEA;
	Mon, 27 Jan 2025 19:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738007860;
	bh=0FQQNYJHrCHJeLMJ2LS4Zd/Go9CcRwLyMKTld/I0v8k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sMNiz1n8W2nQsVNhf5uHcq2u5TJGMl7bO5BVwEKNzyyBBcgmveQmEZCSNZWZwfPW3
	 wuGHyMIwpzLONfFyygy7QryAPTWgBBXZG0SZbg8d+1DY5s9amTBUGfHYoxPd/bZMpz
	 Arax0u7lvWXVxgMty1BtN81FrZu932WyKvhaFoevvFV56m/bB6wrXyor8VDbUw+/CX
	 L8VHVVufj4rNMgti+8BY1H/jMDsdPGagUnOx+Iumm8Ra19N/R6ca9csCD1iannB2Rx
	 /GNqpye4rzHKjp1b7z/ewa3w0m9jumtaHqi4Q72RBjQOc2rr4GBGRfMtHBuI/OYX6R
	 VB7koZJIMikYg==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5f2ed0b70d6so2360776eaf.3;
        Mon, 27 Jan 2025 11:57:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVDkYYyzvwiamPdjdMGWNESTz9Icj7V3Q349fqcOk7qfVFV9xoj2wfB8DcL2pCiVVz3RG1kNzoUuhI=@vger.kernel.org, AJvYcCWOxGlLaeJEThnAjm1cAE/akChmnxFuAxm0TG+iujWCjnmEzFYP4ZMVdxc4G3+DV2i4hufv5CR5EMw5@vger.kernel.org, AJvYcCXoSS7+DTgzvT0ZcpYkhMWylSQRcnWLtjEnv7Cg675WNKNx7OiH/ZUFNL63vzZ+zV7JYlrmjMU2xFZtn+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuRShLsHYLyC9eY6y566BubWFFEyhKhWAEgRa1BMDAbxVFF4/J
	yYExz4RIsGOEW3NxUtljtpcSGMBa+7OQzZ1Ngc6QO3HKkX06iKeAvKku6iZCUOS4TSIq4Yk6eyZ
	ofmEn3LAFZCVUGlr1Vr4N/oIJtac=
X-Google-Smtp-Source: AGHT+IEWMTQD0uVdyod+sr7GU7wtPx6+jbF5hXizyEE6NR1yMYaBOq7d3oMmZWolBM3eKha0C7/HuV9ERdARRyyouQ4=
X-Received: by 2002:a05:6820:2710:b0:5f8:a3df:a9b with SMTP id
 006d021491bc7-5fa388a07c8mr24179204eaf.8.1738007858991; Mon, 27 Jan 2025
 11:57:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111-runtime_pm-v7-0-9c164eefcd87@quicinc.com>
 <20241111-runtime_pm-v7-2-9c164eefcd87@quicinc.com> <Z30p2Etwf3F2AUvD@hovoldconsulting.com>
 <7882105f-93a3-fab9-70a2-2dc55d6becfc@quicinc.com> <Z3057yuNjnn0NPqk@hovoldconsulting.com>
 <20250113162549.a2y7dlwnsfetryyw@thinkpad> <CAPDyKFr=iudHra-AESDW3xM4iNqOD-v8wseBEK0NAHYUH0kE7w@mail.gmail.com>
In-Reply-To: <CAPDyKFr=iudHra-AESDW3xM4iNqOD-v8wseBEK0NAHYUH0kE7w@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 27 Jan 2025 20:57:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h-NrdoAdJ5ZTC1wZhh2BzonSW6ek1ux01-c7L5SLby8A@mail.gmail.com>
X-Gm-Features: AWEUYZnhse4LT7h59hjCPJr-pPx1IdSDJ1ByJ4nwIaHU25iwJKkaWU7LGgCHgts
Message-ID: <CAJZ5v0h-NrdoAdJ5ZTC1wZhh2BzonSW6ek1ux01-c7L5SLby8A@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] PCI: Enable runtime pm of the host bridge
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, rafael@kernel.org, 
	Johan Hovold <johan@kernel.org>, Krishna Chaitanya Chundru <quic_krichai@quicinc.com>, 
	Kevin Xie <kevin.xie@starfivetech.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Markus.Elfring@web.de, 
	quic_mrana@quicinc.com, m.szyprowski@samsung.com, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: multipart/mixed; boundary="0000000000000dbe52062cb57da8"

--0000000000000dbe52062cb57da8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 3:32=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Mon, 13 Jan 2025 at 17:25, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > + Ulf (for the runtime PM related question)
> >
> > On Tue, Jan 07, 2025 at 03:27:59PM +0100, Johan Hovold wrote:
> > > On Tue, Jan 07, 2025 at 07:40:39PM +0530, Krishna Chaitanya Chundru w=
rote:
> > > > On 1/7/2025 6:49 PM, Johan Hovold wrote:
> > >
> > > > >> @@ -3106,6 +3106,17 @@ int pci_host_probe(struct pci_host_bridge=
 *bridge)
> > > > >>                  pcie_bus_configure_settings(child);
> > > > >>
> > > > >>          pci_bus_add_devices(bus);
> > > > >> +
> > > > >> +        /*
> > > > >> +         * Ensure pm_runtime_enable() is called for the control=
ler drivers,
> > > > >> +         * before calling pci_host_probe() as pm frameworks exp=
ects if the
> > > > >> +         * parent device supports runtime pm then it needs to e=
nabled before
> > > > >> +         * child runtime pm.
> > > > >> +         */
> > > > >> +        pm_runtime_set_active(&bridge->dev);
> > > > >> +        pm_runtime_no_callbacks(&bridge->dev);
> > > > >> +        devm_pm_runtime_enable(&bridge->dev);
> > > > >> +
> > > > >>          return 0;
> > > > >>   }
> > > > >>   EXPORT_SYMBOL_GPL(pci_host_probe);
> > > > >
> > > > > I just noticed that this change in 6.13-rc1 is causing the follow=
ing
> > > > > warning on resume from suspend on machines like the Lenovo ThinkP=
ad
> > > > > X13s:
> > >
> > > > Can you confirm if you are seeing this issue is seen in the boot-up
> > > > case also. As this part of the code executes only at the boot time =
and
> > > > will not have effect in resume from suspend.
> > >
> > > No, I only see it during resume. And enabling runtime PM can (and in
> > > this case, obviously does) impact system suspend as well.
> > >
> > > > >   pci0004:00: pcie4: Enabling runtime PM for inactive device with=
 active children
> > >
> > > > I believe this is not causing any functional issues.
> > >
> > > It still needs to be fixed.
> > >
> > > > > which may have unpopulated ports (this laptop SKU does not have a=
 modem).
> > >
> > > > Can you confirm if this warning goes away if there is some endpoint
> > > > connected to it.
> > >
> > > I don't have anything to connect to the slot in this machine, but thi=
s
> > > seems to be the case as I do not see this warning for the populated
> > > slots, nor on the CRD reference design which has a modem on PCIe4.
> > >
> >
> > Yes, this is only happening for unpopulated slots and the warning shows=
 up only
> > if runtime PM is enabled for both PCI bridge and host bridge. This patc=
h enables
> > the runtime PM for host bridge and if the PCI bridge runtime PM is also=
 enabled
> > (only happens now for ACPI/BIOS based platforms), then the warning show=
s up only
> > if the PCI bridge was RPM suspended (mostly happens if there was no dev=
ice
> > connected) during the system wide resume time.
> >
> > For the sake of reference, PCI host bridge is the parent of PCI bridge.
> >
> > Looking at where the warning gets triggered (in pm_runtime_enable()), w=
e have
> > the below checks:
> >
> > dev->power.runtime_status =3D=3D RPM_SUSPENDED
> > !dev->power.ignore_children
> > atomic_read(&dev->power.child_count) > 0
> >
> > When pm_runtime_enable() gets called for PCI host bridge:
> >
> > dev->power.runtime_status =3D RPM_SUSPENDED
> > dev->power.ignore_children =3D 0
> > dev->power.child_count =3D 1
> >
> > First 2 passes seem legit, but the issue is with the 3rd one. Here, the
> > child_count of 1 means that the PCI host bridge has an 'active' child (=
which is
> > the PCI bridge). The PCI bridge was supposed to be RPM_SUSPENDED as the=
 resume
> > process should first resume the parent (PCI host bridge). But this is n=
ot the
> > case here.
> >
> > Then looking at where the child_count gets incremented, it leads to
> > pm_runtime_set_active() of device_resume_noirq(). pm_runtime_set_active=
() is
> > only called for a device if dev_pm_skip_suspend() succeeds, which requi=
res
> > DPM_FLAG_SMART_SUSPEND flag to be set and the device to be runtime susp=
ended.
> >
> > This criteria matches for PCI bridge. So its status was set to 'RPM_ACT=
IVE' even
> > though the parent PCI host bridge was still in the RPM_SUSPENDED state.=
 I don't
> > think this is a valid condition as seen from the warning triggered for =
PCI host
> > bridge when pm_runtime_enable() is called from device_resume_early():
> >
> > pci0004:00: pcie4: Enabling runtime PM for inactive device with active =
children
>
> Thanks for the detailed analysis, much appreciated.
>
> So this seems to boil down to the fact that the PM core calls
> pm_runtime_set_active() for a device, when it really should not. If
> there is a clever way to avoid that, I think we need Rafael's opinion
> on.

Actually, not really.

The status of the child and the child count of the parent have no
meaning until runtime PM is enabled for the parent.  They can be
manipulated freely before this happens with no consequences and all
will be fine as long as those settings are consistent when runtime PM
is enabled for the parent.

Now, they aren't consistent at that point because
dev_pm_skip_suspend() returns false for the parent as it has
DPM_FLAG_SMART_SUSPEND clear.

To me, this looks like a coding mistake because all devices that have
power.must_resume set should also be set to RPM_ACTIVE before
re-enabling runtime PM for them, so the attached patch should work.

--0000000000000dbe52062cb57da8
Content-Type: text/x-patch; charset="US-ASCII"; name="pm-sleep-must_resume.patch"
Content-Disposition: attachment; filename="pm-sleep-must_resume.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m6fgz9y50>
X-Attachment-Id: f_m6fgz9y50

LS0tCiBkcml2ZXJzL2Jhc2UvcG93ZXIvbWFpbi5jIHwgICAgNiArKystLS0KIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgotLS0gYS9kcml2ZXJzL2Jhc2Uv
cG93ZXIvbWFpbi5jCisrKyBiL2RyaXZlcnMvYmFzZS9wb3dlci9tYWluLmMKQEAgLTY1NiwxMiAr
NjU2LDEyIEBACiAJICogc28gY2hhbmdlIGl0cyBzdGF0dXMgYWNjb3JkaW5nbHkuCiAJICoKIAkg
KiBPdGhlcndpc2UsIHRoZSBkZXZpY2UgaXMgZ29pbmcgdG8gYmUgcmVzdW1lZCwgc28gc2V0IGl0
cyBQTS1ydW50aW1lCi0JICogc3RhdHVzIHRvICJhY3RpdmUiLCBidXQgZG8gdGhhdCBvbmx5IGlm
IERQTV9GTEFHX1NNQVJUX1NVU1BFTkQgaXMgc2V0Ci0JICogdG8gYXZvaWQgY29uZnVzaW5nIGRy
aXZlcnMgdGhhdCBkb24ndCB1c2UgaXQuCisJICogc3RhdHVzIHRvICJhY3RpdmUiIHVubGVzcyBp
dHMgcG93ZXIubXVzdF9yZXN1bWUgZmxhZyBpcyBjbGVhciwgaW4KKwkgKiB3aGljaCBjYXNlIGl0
IGlzIG5vdCBuZWNlc3NhcnkgdG8gdXBkYXRlIGl0cyBQTS1ydW50aW1lIHN0YXR1cy4KIAkgKi8K
IAlpZiAoc2tpcF9yZXN1bWUpCiAJCXBtX3J1bnRpbWVfc2V0X3N1c3BlbmRlZChkZXYpOwotCWVs
c2UgaWYgKGRldl9wbV9za2lwX3N1c3BlbmQoZGV2KSkKKwllbHNlIGlmIChkZXYtPnBvd2VyLm11
c3RfcmVzdW1lKQogCQlwbV9ydW50aW1lX3NldF9hY3RpdmUoZGV2KTsKIAogCWlmIChkZXYtPnBt
X2RvbWFpbikgewo=
--0000000000000dbe52062cb57da8--

