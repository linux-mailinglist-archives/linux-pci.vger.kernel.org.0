Return-Path: <linux-pci+bounces-20474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C23A20E05
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 17:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E86F3A5FD0
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 16:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EDA1B2EF2;
	Tue, 28 Jan 2025 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXT5VuPU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41BF1ACED3;
	Tue, 28 Jan 2025 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738080441; cv=none; b=qZJ3cvMwOkvsY1U0c9WltNTSlqc2fVlmkPUKgWEMmg6zqinikJcDAcEmBp6qewm/KWwmQdlfSQq+WRHTeLCR5e9j0ZNr1jIjzpEVKPHl39w2o/t4yti9LZ4vbJsmpkt7raWL6Vx4Qy4yYfJgJ8Dk6Qpbi/uzwgu9dH66yW5Pk/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738080441; c=relaxed/simple;
	bh=KZcE1bukQorwGQCYZJKJZzamF7Is7wgBgtj2gMrFu7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYefy02ifROt+nLpBtqTckZ2nXBVgvS1i7EY6MtFZbuW0p1vze971BCrJDgbd9D1l2YcHWwn0EStUWbt8/GZosHC7aRzI/nZ5JUceoj9QbvoJ3S8ahF4mRs2IvQHFr249dok/a9BXyllfzM4mR7xSTfMvlM0XHVycgNqXfeJWYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXT5VuPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7CDC4CEE8;
	Tue, 28 Jan 2025 16:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738080441;
	bh=KZcE1bukQorwGQCYZJKJZzamF7Is7wgBgtj2gMrFu7U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QXT5VuPUkPFrTNsXMBCgL/4JEjK3LimZ7Cqd8yBIpszco7wflbiRcn0RACxL+AwWv
	 BUAKiyCeysqDqXs8hjID4AUi2fCdrWCVf3JDJQvNy4MgAa1W1+IrmRdyK+lBQzqkLO
	 Fr4hTtHY7OGqWiAGjbKiix4JII/o0UVMLbI+0prt1ccdOPlrfeeAXTYe9FEan3qI6o
	 X/2MhZKfxPM3UHxZFTFilI8hAezvgg7moEifAICCSuc90WFY7Z8WErlFSJgFp9VI6N
	 n89HnJC5mGsuJblsILhO0tWogckgigHTkP1YbJ8XLH15dnPUy45MDlJkr1zijJgULu
	 mJMh1Et54IcJA==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5f321876499so3074440eaf.1;
        Tue, 28 Jan 2025 08:07:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVjONS9uxajHLs7pLpBavQFhezw/gzRkcMZxLYCfOTCITrIf2rh25uircJHwNK9GHHXIT4MQSCVXII=@vger.kernel.org, AJvYcCXcWWiJFjvhpatdNgbh97x9JlvUQC7AL0AdK4G01McgutJ0UrpueOke/JWB/hU1Rr9QwY59yUD7ohRsPzk=@vger.kernel.org, AJvYcCXuzYvkB0gZbXEOj0L6peXKTsuj6pxFD+pqL5NJIx6ryxo1ggVnQa7mf5UjwjdiyWbien4hiUSqiNOs@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe490DjMNKdiaio4HJNotTSJlPco78CrJj4bsqgP2AzAt4YfYs
	ivhT1laBP+NOZveIH5NHYqtjsLa+rcq+v3gjxtGt9nysCVta1i3fEKABG/0YDOSM+MOTuTvNtth
	e8XKUzBNfSFwQO3IhK8BB/a7L4XY=
X-Google-Smtp-Source: AGHT+IFppnrp+e0tvUYXh1qQv3AmDN9KyKq0jV/1mxaQcS7c99bB3bgMMoQyY9H+pYrZo17m5R0do2ONTCA2fS7+yYU=
X-Received: by 2002:a05:6820:503:b0:5fa:3ba7:d27 with SMTP id
 006d021491bc7-5fbf5168bdcmr2118524eaf.4.1738080440777; Tue, 28 Jan 2025
 08:07:20 -0800 (PST)
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
 <CAJZ5v0iAa8r9F8MMt7WhbfSRF5MeWnrDRUTeG5HrY5TBHtfZaw@mail.gmail.com> <20250128155830.xc6y2swqqw5okt32@thinkpad>
In-Reply-To: <20250128155830.xc6y2swqqw5okt32@thinkpad>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 28 Jan 2025 17:07:09 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0imDLwgP+d753s5dVG9cybbK+PFiKwoYmsC13AhjWJ8EQ@mail.gmail.com>
X-Gm-Features: AWEUYZnjD4AXkuQo0i_7dvCWA9QyU7OzVrOMlqY1zImHh0g0icCNwlXFK9LDjsc
Message-ID: <CAJZ5v0imDLwgP+d753s5dVG9cybbK+PFiKwoYmsC13AhjWJ8EQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] PCI: Enable runtime pm of the host bridge
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Johan Hovold <johan@kernel.org>, Krishna Chaitanya Chundru <quic_krichai@quicinc.com>, 
	Kevin Xie <kevin.xie@starfivetech.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Markus.Elfring@web.de, 
	quic_mrana@quicinc.com, m.szyprowski@samsung.com, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 4:58=E2=80=AFPM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Tue, Jan 28, 2025 at 12:47:09PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Jan 27, 2025 at 8:57=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > >
> > > On Mon, Jan 27, 2025 at 3:32=E2=80=AFPM Ulf Hansson <ulf.hansson@lina=
ro.org> wrote:
> > > >
> > > > On Mon, 13 Jan 2025 at 17:25, Manivannan Sadhasivam
> > > > <manivannan.sadhasivam@linaro.org> wrote:
> > > > >
> > > > > + Ulf (for the runtime PM related question)
> > > > >
> > > > > On Tue, Jan 07, 2025 at 03:27:59PM +0100, Johan Hovold wrote:
> > > > > > On Tue, Jan 07, 2025 at 07:40:39PM +0530, Krishna Chaitanya Chu=
ndru wrote:
> > > > > > > On 1/7/2025 6:49 PM, Johan Hovold wrote:
> > > > > >
> > > > > > > >> @@ -3106,6 +3106,17 @@ int pci_host_probe(struct pci_host_=
bridge *bridge)
> > > > > > > >>                  pcie_bus_configure_settings(child);
> > > > > > > >>
> > > > > > > >>          pci_bus_add_devices(bus);
> > > > > > > >> +
> > > > > > > >> +        /*
> > > > > > > >> +         * Ensure pm_runtime_enable() is called for the c=
ontroller drivers,
> > > > > > > >> +         * before calling pci_host_probe() as pm framewor=
ks expects if the
> > > > > > > >> +         * parent device supports runtime pm then it need=
s to enabled before
> > > > > > > >> +         * child runtime pm.
> > > > > > > >> +         */
> > > > > > > >> +        pm_runtime_set_active(&bridge->dev);
> > > > > > > >> +        pm_runtime_no_callbacks(&bridge->dev);
> > > > > > > >> +        devm_pm_runtime_enable(&bridge->dev);
> > > > > > > >> +
> > > > > > > >>          return 0;
> > > > > > > >>   }
> > > > > > > >>   EXPORT_SYMBOL_GPL(pci_host_probe);
> > > > > > > >
> > > > > > > > I just noticed that this change in 6.13-rc1 is causing the =
following
> > > > > > > > warning on resume from suspend on machines like the Lenovo =
ThinkPad
> > > > > > > > X13s:
> > > > > >
> > > > > > > Can you confirm if you are seeing this issue is seen in the b=
oot-up
> > > > > > > case also. As this part of the code executes only at the boot=
 time and
> > > > > > > will not have effect in resume from suspend.
> > > > > >
> > > > > > No, I only see it during resume. And enabling runtime PM can (a=
nd in
> > > > > > this case, obviously does) impact system suspend as well.
> > > > > >
> > > > > > > >   pci0004:00: pcie4: Enabling runtime PM for inactive devic=
e with active children
> > > > > >
> > > > > > > I believe this is not causing any functional issues.
> > > > > >
> > > > > > It still needs to be fixed.
> > > > > >
> > > > > > > > which may have unpopulated ports (this laptop SKU does not =
have a modem).
> > > > > >
> > > > > > > Can you confirm if this warning goes away if there is some en=
dpoint
> > > > > > > connected to it.
> > > > > >
> > > > > > I don't have anything to connect to the slot in this machine, b=
ut this
> > > > > > seems to be the case as I do not see this warning for the popul=
ated
> > > > > > slots, nor on the CRD reference design which has a modem on PCI=
e4.
> > > > > >
> > > > >
> > > > > Yes, this is only happening for unpopulated slots and the warning=
 shows up only
> > > > > if runtime PM is enabled for both PCI bridge and host bridge. Thi=
s patch enables
> > > > > the runtime PM for host bridge and if the PCI bridge runtime PM i=
s also enabled
> > > > > (only happens now for ACPI/BIOS based platforms), then the warnin=
g shows up only
> > > > > if the PCI bridge was RPM suspended (mostly happens if there was =
no device
> > > > > connected) during the system wide resume time.
> > > > >
> > > > > For the sake of reference, PCI host bridge is the parent of PCI b=
ridge.
> > > > >
> > > > > Looking at where the warning gets triggered (in pm_runtime_enable=
()), we have
> > > > > the below checks:
> > > > >
> > > > > dev->power.runtime_status =3D=3D RPM_SUSPENDED
> > > > > !dev->power.ignore_children
> > > > > atomic_read(&dev->power.child_count) > 0
> > > > >
> > > > > When pm_runtime_enable() gets called for PCI host bridge:
> > > > >
> > > > > dev->power.runtime_status =3D RPM_SUSPENDED
> > > > > dev->power.ignore_children =3D 0
> > > > > dev->power.child_count =3D 1
> > > > >
> > > > > First 2 passes seem legit, but the issue is with the 3rd one. Her=
e, the
> > > > > child_count of 1 means that the PCI host bridge has an 'active' c=
hild (which is
> > > > > the PCI bridge). The PCI bridge was supposed to be RPM_SUSPENDED =
as the resume
> > > > > process should first resume the parent (PCI host bridge). But thi=
s is not the
> > > > > case here.
> > > > >
> > > > > Then looking at where the child_count gets incremented, it leads =
to
> > > > > pm_runtime_set_active() of device_resume_noirq(). pm_runtime_set_=
active() is
> > > > > only called for a device if dev_pm_skip_suspend() succeeds, which=
 requires
> > > > > DPM_FLAG_SMART_SUSPEND flag to be set and the device to be runtim=
e suspended.
> > > > >
> > > > > This criteria matches for PCI bridge. So its status was set to 'R=
PM_ACTIVE' even
> > > > > though the parent PCI host bridge was still in the RPM_SUSPENDED =
state. I don't
> > > > > think this is a valid condition as seen from the warning triggere=
d for PCI host
> > > > > bridge when pm_runtime_enable() is called from device_resume_earl=
y():
> > > > >
> > > > > pci0004:00: pcie4: Enabling runtime PM for inactive device with a=
ctive children
> > > >
> > > > Thanks for the detailed analysis, much appreciated.
> > > >
> > > > So this seems to boil down to the fact that the PM core calls
> > > > pm_runtime_set_active() for a device, when it really should not. If
> > > > there is a clever way to avoid that, I think we need Rafael's opini=
on
> > > > on.
> > >
> > > Actually, not really.
> > >
> > > The status of the child and the child count of the parent have no
> > > meaning until runtime PM is enabled for the parent.  They can be
> > > manipulated freely before this happens with no consequences and all
> > > will be fine as long as those settings are consistent when runtime PM
> > > is enabled for the parent.
> > >
> > > Now, they aren't consistent at that point because
> > > dev_pm_skip_suspend() returns false for the parent as it has
> > > DPM_FLAG_SMART_SUSPEND clear.
> > >
> > > To me, this looks like a coding mistake because all devices that have
> > > power.must_resume set should also be set to RPM_ACTIVE before
> > > re-enabling runtime PM for them, so the attached patch should work.
> >
> > Having reflected on it a bit I think that it's better to avoid
> > changing the existing behavior too much, so attached is a new version
> > of the patch.
> >
> > It is along the same lines as before, but it doesn't go as far as the
> > previous version.  Namely, in addition to what the existing code does,
> > it will cause the runtime PM status to be set to RPM_ACTIVE for the
> > devices whose dependents will have it set which should address the
> > problem at hand if I'm not mistaken.
> >
> > I'd appreciated giving it a go on a system where the warning is printed=
.
> >
>
> This patch indeed makes the warning go away and I don't spot any other is=
sues.
> So you can add my Tested-by tag while submitting the fix.
>
> Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
> Thanks a lot!

Thank you!

