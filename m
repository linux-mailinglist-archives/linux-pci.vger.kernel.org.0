Return-Path: <linux-pci+bounces-20453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9741EA209EA
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 12:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E58841650E8
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 11:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFBF19F47E;
	Tue, 28 Jan 2025 11:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qboFxA/T"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD3419DF75;
	Tue, 28 Jan 2025 11:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738064842; cv=none; b=TZS8vOztSMuX7oDBnooWIj52PfQn9HNWUan9jeIbcOcFHTpOppR0XiUc2HGC9s+s067JZrFLAyWZytyHsXDbuxA5gcUE4xwB8ls9ARA6uLgIqxiWuZZt3ii0EJq4rkuXif7yElJ5iugyIcHW02TsqzsebP9Bpvlm/W7h4k7S9mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738064842; c=relaxed/simple;
	bh=rptYy/yVNLklWGJOtOgo4Nm5eD+vpHtTzbxAKl+CMfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9UsExkqCsn0ytxCA49Cj/QosXHrFWyE5+Xw6EYiaRMeMfzE4lmftgYlICYnvmup+bgk/UmbSi0NNf6bUO+yJljrKZWev90coMDTN0sIUi2hEdQxW4MjxMaul2J24B6mvNHMXO8GLZTav7jmSy3cI5W+rGJLujeVJFyK5q9WACs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qboFxA/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0472C4CEDF;
	Tue, 28 Jan 2025 11:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738064841;
	bh=rptYy/yVNLklWGJOtOgo4Nm5eD+vpHtTzbxAKl+CMfM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qboFxA/TXut8QXOeGwgcBqKQQcglyvSsWiRRrPKMu7zzqoYO/XIlRUzDrgky1BHac
	 E1M4guBmLU35bhijN7f/f2h+44M2CQdPtdFkF6hobX8DcYtpFtteVJGFbdGaxMzU1X
	 ByWclwQ3dcvLHUaQToW9zjlew88j+A0p/j+ojgReSvrs10K4ew1TxRrui71Fyi99ll
	 tUlcemnW92EuG9prWTjs2PCITLuqpDV1BOPDnJxjY5o8nC8qjrHDFIHOLRSn+Dv9xI
	 RDkUJNEJybw1/gHvyuonMSY7vWA0gpXd2UJK1aw/TdCzK8J1UQVVof3DV9ZE50uT67
	 SgawZaRo7vaiw==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3ebc678b5c9so3046335b6e.3;
        Tue, 28 Jan 2025 03:47:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVSvz8TURF6rUzQc+AR58r9uvabD4HGNT3y5I4IPay/B8OgOnI9lLurgzKTN6W6PdQRRUYPFMG6I3jXHT4=@vger.kernel.org, AJvYcCW5k7lTos0Pr/I69ZukrF+YfR00Y8gkrAjuDzPuOq1tKquRbTELqdy37Ii9UyGoTm5W1pT+DWqhx6k=@vger.kernel.org, AJvYcCWsj7rqe6gGjaMf5AZisHI1aWwgB+BMrRFyClBzyD7lkKqUCljA4myrI+3ELdDFtZTqdzogAaGjrwuU@vger.kernel.org
X-Gm-Message-State: AOJu0YweOEdBgIw+0M6fk0uByxuFLksppRoQnC05bb6Cg/T8OrNSeTMb
	cpo69uXWbbyWApsnGSm2xH8runigvaAAGjwRjmNCdS7o3gGWu48xcFe4wS4GPeCqmGc4Cknrj3d
	VC6E+/qSjPDtZ4MGpcqitVRa1tIU=
X-Google-Smtp-Source: AGHT+IFx9weG4r6KHeKEuZuBCSS1II9XamDA7rOF7wmcDPrTizw92KoO0i13/aQc/mgU+FYwBzNv1iCTeiniKj0IVM4=
X-Received: by 2002:a05:6808:3993:b0:3e7:c466:263 with SMTP id
 5614622812f47-3f19fc3b05cmr29451284b6e.2.1738064840692; Tue, 28 Jan 2025
 03:47:20 -0800 (PST)
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
 <CAJZ5v0h-NrdoAdJ5ZTC1wZhh2BzonSW6ek1ux01-c7L5SLby8A@mail.gmail.com>
In-Reply-To: <CAJZ5v0h-NrdoAdJ5ZTC1wZhh2BzonSW6ek1ux01-c7L5SLby8A@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 28 Jan 2025 12:47:09 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iAa8r9F8MMt7WhbfSRF5MeWnrDRUTeG5HrY5TBHtfZaw@mail.gmail.com>
X-Gm-Features: AWEUYZnec54n9RYy6Z-07mV28snTagjhb5JX6TpN9-itsDRh7HcN-wmmZLed6uo
Message-ID: <CAJZ5v0iAa8r9F8MMt7WhbfSRF5MeWnrDRUTeG5HrY5TBHtfZaw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] PCI: Enable runtime pm of the host bridge
To: Ulf Hansson <ulf.hansson@linaro.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Johan Hovold <johan@kernel.org>
Cc: rafael@kernel.org, Krishna Chaitanya Chundru <quic_krichai@quicinc.com>, 
	Kevin Xie <kevin.xie@starfivetech.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Markus.Elfring@web.de, 
	quic_mrana@quicinc.com, m.szyprowski@samsung.com, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: multipart/mixed; boundary="0000000000006d436a062cc2c11a"

--0000000000006d436a062cc2c11a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 8:57=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Mon, Jan 27, 2025 at 3:32=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Mon, 13 Jan 2025 at 17:25, Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > + Ulf (for the runtime PM related question)
> > >
> > > On Tue, Jan 07, 2025 at 03:27:59PM +0100, Johan Hovold wrote:
> > > > On Tue, Jan 07, 2025 at 07:40:39PM +0530, Krishna Chaitanya Chundru=
 wrote:
> > > > > On 1/7/2025 6:49 PM, Johan Hovold wrote:
> > > >
> > > > > >> @@ -3106,6 +3106,17 @@ int pci_host_probe(struct pci_host_brid=
ge *bridge)
> > > > > >>                  pcie_bus_configure_settings(child);
> > > > > >>
> > > > > >>          pci_bus_add_devices(bus);
> > > > > >> +
> > > > > >> +        /*
> > > > > >> +         * Ensure pm_runtime_enable() is called for the contr=
oller drivers,
> > > > > >> +         * before calling pci_host_probe() as pm frameworks e=
xpects if the
> > > > > >> +         * parent device supports runtime pm then it needs to=
 enabled before
> > > > > >> +         * child runtime pm.
> > > > > >> +         */
> > > > > >> +        pm_runtime_set_active(&bridge->dev);
> > > > > >> +        pm_runtime_no_callbacks(&bridge->dev);
> > > > > >> +        devm_pm_runtime_enable(&bridge->dev);
> > > > > >> +
> > > > > >>          return 0;
> > > > > >>   }
> > > > > >>   EXPORT_SYMBOL_GPL(pci_host_probe);
> > > > > >
> > > > > > I just noticed that this change in 6.13-rc1 is causing the foll=
owing
> > > > > > warning on resume from suspend on machines like the Lenovo Thin=
kPad
> > > > > > X13s:
> > > >
> > > > > Can you confirm if you are seeing this issue is seen in the boot-=
up
> > > > > case also. As this part of the code executes only at the boot tim=
e and
> > > > > will not have effect in resume from suspend.
> > > >
> > > > No, I only see it during resume. And enabling runtime PM can (and i=
n
> > > > this case, obviously does) impact system suspend as well.
> > > >
> > > > > >   pci0004:00: pcie4: Enabling runtime PM for inactive device wi=
th active children
> > > >
> > > > > I believe this is not causing any functional issues.
> > > >
> > > > It still needs to be fixed.
> > > >
> > > > > > which may have unpopulated ports (this laptop SKU does not have=
 a modem).
> > > >
> > > > > Can you confirm if this warning goes away if there is some endpoi=
nt
> > > > > connected to it.
> > > >
> > > > I don't have anything to connect to the slot in this machine, but t=
his
> > > > seems to be the case as I do not see this warning for the populated
> > > > slots, nor on the CRD reference design which has a modem on PCIe4.
> > > >
> > >
> > > Yes, this is only happening for unpopulated slots and the warning sho=
ws up only
> > > if runtime PM is enabled for both PCI bridge and host bridge. This pa=
tch enables
> > > the runtime PM for host bridge and if the PCI bridge runtime PM is al=
so enabled
> > > (only happens now for ACPI/BIOS based platforms), then the warning sh=
ows up only
> > > if the PCI bridge was RPM suspended (mostly happens if there was no d=
evice
> > > connected) during the system wide resume time.
> > >
> > > For the sake of reference, PCI host bridge is the parent of PCI bridg=
e.
> > >
> > > Looking at where the warning gets triggered (in pm_runtime_enable()),=
 we have
> > > the below checks:
> > >
> > > dev->power.runtime_status =3D=3D RPM_SUSPENDED
> > > !dev->power.ignore_children
> > > atomic_read(&dev->power.child_count) > 0
> > >
> > > When pm_runtime_enable() gets called for PCI host bridge:
> > >
> > > dev->power.runtime_status =3D RPM_SUSPENDED
> > > dev->power.ignore_children =3D 0
> > > dev->power.child_count =3D 1
> > >
> > > First 2 passes seem legit, but the issue is with the 3rd one. Here, t=
he
> > > child_count of 1 means that the PCI host bridge has an 'active' child=
 (which is
> > > the PCI bridge). The PCI bridge was supposed to be RPM_SUSPENDED as t=
he resume
> > > process should first resume the parent (PCI host bridge). But this is=
 not the
> > > case here.
> > >
> > > Then looking at where the child_count gets incremented, it leads to
> > > pm_runtime_set_active() of device_resume_noirq(). pm_runtime_set_acti=
ve() is
> > > only called for a device if dev_pm_skip_suspend() succeeds, which req=
uires
> > > DPM_FLAG_SMART_SUSPEND flag to be set and the device to be runtime su=
spended.
> > >
> > > This criteria matches for PCI bridge. So its status was set to 'RPM_A=
CTIVE' even
> > > though the parent PCI host bridge was still in the RPM_SUSPENDED stat=
e. I don't
> > > think this is a valid condition as seen from the warning triggered fo=
r PCI host
> > > bridge when pm_runtime_enable() is called from device_resume_early():
> > >
> > > pci0004:00: pcie4: Enabling runtime PM for inactive device with activ=
e children
> >
> > Thanks for the detailed analysis, much appreciated.
> >
> > So this seems to boil down to the fact that the PM core calls
> > pm_runtime_set_active() for a device, when it really should not. If
> > there is a clever way to avoid that, I think we need Rafael's opinion
> > on.
>
> Actually, not really.
>
> The status of the child and the child count of the parent have no
> meaning until runtime PM is enabled for the parent.  They can be
> manipulated freely before this happens with no consequences and all
> will be fine as long as those settings are consistent when runtime PM
> is enabled for the parent.
>
> Now, they aren't consistent at that point because
> dev_pm_skip_suspend() returns false for the parent as it has
> DPM_FLAG_SMART_SUSPEND clear.
>
> To me, this looks like a coding mistake because all devices that have
> power.must_resume set should also be set to RPM_ACTIVE before
> re-enabling runtime PM for them, so the attached patch should work.

Having reflected on it a bit I think that it's better to avoid
changing the existing behavior too much, so attached is a new version
of the patch.

It is along the same lines as before, but it doesn't go as far as the
previous version.  Namely, in addition to what the existing code does,
it will cause the runtime PM status to be set to RPM_ACTIVE for the
devices whose dependents will have it set which should address the
problem at hand if I'm not mistaken.

I'd appreciated giving it a go on a system where the warning is printed.

Thanks!

--0000000000006d436a062cc2c11a
Content-Type: text/x-patch; charset="US-ASCII"; name="pm-sleep-set_active.patch"
Content-Disposition: attachment; filename="pm-sleep-set_active.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m6geporn0>
X-Attachment-Id: f_m6geporn0

LS0tCiBkcml2ZXJzL2Jhc2UvcG93ZXIvbWFpbi5jIHwgICAyOSArKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLQogaW5jbHVkZS9saW51eC9wbS5oICAgICAgICB8ICAgIDEgKwogMiBmaWxlcyBj
aGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQoKLS0tIGEvZHJpdmVycy9i
YXNlL3Bvd2VyL21haW4uYworKysgYi9kcml2ZXJzL2Jhc2UvcG93ZXIvbWFpbi5jCkBAIC02NTYs
MTMgKzY1NiwxNSBAQAogCSAqIHNvIGNoYW5nZSBpdHMgc3RhdHVzIGFjY29yZGluZ2x5LgogCSAq
CiAJICogT3RoZXJ3aXNlLCB0aGUgZGV2aWNlIGlzIGdvaW5nIHRvIGJlIHJlc3VtZWQsIHNvIHNl
dCBpdHMgUE0tcnVudGltZQotCSAqIHN0YXR1cyB0byAiYWN0aXZlIiwgYnV0IGRvIHRoYXQgb25s
eSBpZiBEUE1fRkxBR19TTUFSVF9TVVNQRU5EIGlzIHNldAotCSAqIHRvIGF2b2lkIGNvbmZ1c2lu
ZyBkcml2ZXJzIHRoYXQgZG9uJ3QgdXNlIGl0LgorCSAqIHN0YXR1cyB0byAiYWN0aXZlIiB1bmxl
c3MgaXRzIHBvd2VyLnNldF9hY3RpdmUgZmxhZyBpcyBjbGVhciwgaW4KKwkgKiB3aGljaCBjYXNl
IGl0IGlzIG5vdCBuZWNlc3NhcnkgdG8gdXBkYXRlIGl0cyBQTS1ydW50aW1lIHN0YXR1cy4KIAkg
Ki8KLQlpZiAoc2tpcF9yZXN1bWUpCisJaWYgKHNraXBfcmVzdW1lKSB7CiAJCXBtX3J1bnRpbWVf
c2V0X3N1c3BlbmRlZChkZXYpOwotCWVsc2UgaWYgKGRldl9wbV9za2lwX3N1c3BlbmQoZGV2KSkK
Kwl9IGVsc2UgaWYgKGRldi0+cG93ZXIuc2V0X2FjdGl2ZSkgewogCQlwbV9ydW50aW1lX3NldF9h
Y3RpdmUoZGV2KTsKKwkJZGV2LT5wb3dlci5zZXRfYWN0aXZlID0gZmFsc2U7CisJfQogCiAJaWYg
KGRldi0+cG1fZG9tYWluKSB7CiAJCWluZm8gPSAibm9pcnEgcG93ZXIgZG9tYWluICI7CkBAIC0x
MTg5LDE4ICsxMTkxLDI0IEBACiAJcmV0dXJuIFBNU0dfT047CiB9CiAKLXN0YXRpYyB2b2lkIGRw
bV9zdXBlcmlvcl9zZXRfbXVzdF9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQorc3RhdGljIHZv
aWQgZHBtX3N1cGVyaW9yX3NldF9tdXN0X3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYsIGJvb2wg
c2V0X2FjdGl2ZSkKIHsKIAlzdHJ1Y3QgZGV2aWNlX2xpbmsgKmxpbms7CiAJaW50IGlkeDsKIAot
CWlmIChkZXYtPnBhcmVudCkKKwlpZiAoZGV2LT5wYXJlbnQpIHsKIAkJZGV2LT5wYXJlbnQtPnBv
d2VyLm11c3RfcmVzdW1lID0gdHJ1ZTsKKwkJaWYgKHNldF9hY3RpdmUpCisJCQlkZXYtPnBhcmVu
dC0+cG93ZXIuc2V0X2FjdGl2ZSA9IHRydWU7CisJfQogCiAJaWR4ID0gZGV2aWNlX2xpbmtzX3Jl
YWRfbG9jaygpOwogCi0JbGlzdF9mb3JfZWFjaF9lbnRyeV9yY3VfbG9ja2VkKGxpbmssICZkZXYt
PmxpbmtzLnN1cHBsaWVycywgY19ub2RlKQorCWxpc3RfZm9yX2VhY2hfZW50cnlfcmN1X2xvY2tl
ZChsaW5rLCAmZGV2LT5saW5rcy5zdXBwbGllcnMsIGNfbm9kZSkgewogCQlsaW5rLT5zdXBwbGll
ci0+cG93ZXIubXVzdF9yZXN1bWUgPSB0cnVlOworCQlpZiAoc2V0X2FjdGl2ZSkKKwkJCWxpbmst
PnN1cHBsaWVyLT5wb3dlci5zZXRfYWN0aXZlID0gdHJ1ZTsKKwl9CiAKIAlkZXZpY2VfbGlua3Nf
cmVhZF91bmxvY2soaWR4KTsKIH0KQEAgLTEyNzgsOCArMTI4NiwxMSBAQAogCSAgICAgIGRldi0+
cG93ZXIubWF5X3NraXBfcmVzdW1lKSkKIAkJZGV2LT5wb3dlci5tdXN0X3Jlc3VtZSA9IHRydWU7
CiAKLQlpZiAoZGV2LT5wb3dlci5tdXN0X3Jlc3VtZSkKLQkJZHBtX3N1cGVyaW9yX3NldF9tdXN0
X3Jlc3VtZShkZXYpOworCWlmIChkZXYtPnBvd2VyLm11c3RfcmVzdW1lKSB7CisJCWRldi0+cG93
ZXIuc2V0X2FjdGl2ZSA9IGRldi0+cG93ZXIuc2V0X2FjdGl2ZSB8fAorCQkJZGV2X3BtX3Rlc3Rf
ZHJpdmVyX2ZsYWdzKGRldiwgRFBNX0ZMQUdfU01BUlRfU1VTUEVORCk7CisJCWRwbV9zdXBlcmlv
cl9zZXRfbXVzdF9yZXN1bWUoZGV2LCBkZXYtPnBvd2VyLnNldF9hY3RpdmUpOworCX0KIAogQ29t
cGxldGU6CiAJY29tcGxldGVfYWxsKCZkZXYtPnBvd2VyLmNvbXBsZXRpb24pOwotLS0gYS9pbmNs
dWRlL2xpbnV4L3BtLmgKKysrIGIvaW5jbHVkZS9saW51eC9wbS5oCkBAIC02ODMsNiArNjgzLDcg
QEAKIAlib29sCQkJbm9fcG1fY2FsbGJhY2tzOjE7CS8qIE93bmVkIGJ5IHRoZSBQTSBjb3JlICov
CiAJYm9vbAkJCWFzeW5jX2luX3Byb2dyZXNzOjE7CS8qIE93bmVkIGJ5IHRoZSBQTSBjb3JlICov
CiAJYm9vbAkJCW11c3RfcmVzdW1lOjE7CQkvKiBPd25lZCBieSB0aGUgUE0gY29yZSAqLworCWJv
b2wJCQlzZXRfYWN0aXZlOjE7CQkvKiBPd25lZCBieSB0aGUgUE0gY29yZSAqLwogCWJvb2wJCQlt
YXlfc2tpcF9yZXN1bWU6MTsJLyogU2V0IGJ5IHN1YnN5c3RlbXMgKi8KICNlbHNlCiAJYm9vbAkJ
CXNob3VsZF93YWtldXA6MTsK
--0000000000006d436a062cc2c11a--

