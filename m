Return-Path: <linux-pci+bounces-20404-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A206A1D878
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 15:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D460F3A302B
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 14:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D57747F;
	Mon, 27 Jan 2025 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vbqyFxMe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69742824A3
	for <linux-pci@vger.kernel.org>; Mon, 27 Jan 2025 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737988347; cv=none; b=S7KnQkUwy58oRMneqv367LWgccj8kes4F0z3d/DS4hpkJ4L3wSU4bbAdepREGzyFAoGtUrXC3414Co0nnAwfaX1eL2ETvFU5fcBLM9fjL1Gw2mLRN+v/iRJc5tOAgdHC2zJ634YUSX6xfWLzTrjKJoYTm59BOezA8FVvHp9AvW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737988347; c=relaxed/simple;
	bh=3U+wlxERzTd4gFnK7jQrkNNuYzZ0sx8jHZtQKz8HwtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TkQNDaTsb7YLvc0TmI5HRlL4okzbLaFI3DTP9+/C6wEA0AFw+bAL03HkDccoH04u2GkPF9B6jXEmUr1ZQoWeGN07KHGe74wViYiQiATOGh0lm8ETslAu4nEX1Kv8BCgIGWwMjy9tXwhIWbKacuVe18FgU8hOXp1s5sm1qUjq3Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vbqyFxMe; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e3a0acba5feso6077214276.2
        for <linux-pci@vger.kernel.org>; Mon, 27 Jan 2025 06:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737988344; x=1738593144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiD54sGKGVL3KpLtkR/LjHneucqmwIVXNUd8n+WxgHk=;
        b=vbqyFxMeZ2jQCiwp7WgJCDm9dyj9Z1RX6chfWR+KzlBJ34oiANA4IsAadDLh/9jGNC
         O20xTF5exF7ued3Jkv3LhIeCqAm+AaNMprRTSt54Z4rr758WzmgNNA9mPHWTagC5wQJH
         wTQQvYlAmpVmxv7acfdq+nzrWXdquRyhGT8zedSE3PWCEFLSHsxRonz8g7vbjmNWG4e5
         6Y9XyHARYmbaTLvsbcwZZjvVx+taq8m3+jlQmORdSDzwJEmyHFAnuPbNspMGTQj7ra7A
         7/EvIcS227YtObYzTatcU5nv5BR26xJDaRZSZnKlecefKvfR2VqxPWzrjCcEcUXt95zu
         etSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737988344; x=1738593144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MiD54sGKGVL3KpLtkR/LjHneucqmwIVXNUd8n+WxgHk=;
        b=anVOmtzRd3u94/hHXMZpERlw68v/fKXhjb07gGFsf+i3/i4FFCrlhs49ACXM23YR+X
         pGdW7Pn3HB0j1oLz5BBaN91Mq8IG0MUgpWA8vL8v+Z74YGVZ3OiCgNlfmAnRh7SrDQFh
         /uJ7gPBPICMjiaWiNoqiWXRAcDGP1nD2v+O2e9mOSctxquY57aHy6GpuQV81JeV+NHE0
         TP+P83XDLKZHQwz2cqxZCQnzndajITvDRSGM3bqqYX2e1Q/HzYWbean5klSzgu3vsqqa
         eOBHVFCFCuqFSDpjBSL3x75a+vBlgmtSH0hufaeF8gJeFJqL5uH7X+fPeLbprizqg2gs
         /rwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqSsiUiDuoi25zKhKdzPK1dF3VFf58DEjaUjWbu3H2RpyTIuiVfXnX1wLd/PZpboz1dwPP6TdWmgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUtfHcM3b/XdrgEOKkYSetBCfiYG2rlN8LJaydPz6magDoeuRA
	T0TkVEnGUFSeklaMg+4l4FoJctZ8KNWDYavjJKuH8aXT7mNbsO1DawRlicCOEc37+e6REdyjd3S
	RgQ1ClzJMSZWu1Z9qGiX7q4QWAYrnIsCvM9fn+Q==
X-Gm-Gg: ASbGncvtyb5fSCNCpUy0ahF8eZfSdfOo9ROK35/lmPvVMF8o8pNKxF07yavZC3GD07D
	Gf+VbAlJQVxrvivdAf01dwhO6B7HfRVch4sl3SnsE0AzO4BI7NvXLjQ5zvxba8/I=
X-Google-Smtp-Source: AGHT+IF2qrhalK8dXiECwjNhaJHAeaiUoKN7zzq1rqCSPzHfhyiJHCMonXt6f6hVNH1MR53EK038D1HbRMWujS1dltY=
X-Received: by 2002:a05:6902:15ca:b0:e58:dbf:ed05 with SMTP id
 3f1490d57ef6-e580dbfefa4mr19756443276.10.1737988344256; Mon, 27 Jan 2025
 06:32:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111-runtime_pm-v7-0-9c164eefcd87@quicinc.com>
 <20241111-runtime_pm-v7-2-9c164eefcd87@quicinc.com> <Z30p2Etwf3F2AUvD@hovoldconsulting.com>
 <7882105f-93a3-fab9-70a2-2dc55d6becfc@quicinc.com> <Z3057yuNjnn0NPqk@hovoldconsulting.com>
 <20250113162549.a2y7dlwnsfetryyw@thinkpad>
In-Reply-To: <20250113162549.a2y7dlwnsfetryyw@thinkpad>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 27 Jan 2025 15:31:48 +0100
X-Gm-Features: AWEUYZkcntMtoxK0sNVjcPqv6JHNvnG4HSn-DiU03ZeCG_vNSYm_EBMz2h3QCfM
Message-ID: <CAPDyKFr=iudHra-AESDW3xM4iNqOD-v8wseBEK0NAHYUH0kE7w@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] PCI: Enable runtime pm of the host bridge
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, rafael@kernel.org
Cc: Johan Hovold <johan@kernel.org>, Krishna Chaitanya Chundru <quic_krichai@quicinc.com>, 
	Kevin Xie <kevin.xie@starfivetech.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Markus.Elfring@web.de, 
	quic_mrana@quicinc.com, m.szyprowski@samsung.com, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Jan 2025 at 17:25, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> + Ulf (for the runtime PM related question)
>
> On Tue, Jan 07, 2025 at 03:27:59PM +0100, Johan Hovold wrote:
> > On Tue, Jan 07, 2025 at 07:40:39PM +0530, Krishna Chaitanya Chundru wro=
te:
> > > On 1/7/2025 6:49 PM, Johan Hovold wrote:
> >
> > > >> @@ -3106,6 +3106,17 @@ int pci_host_probe(struct pci_host_bridge *=
bridge)
> > > >>                  pcie_bus_configure_settings(child);
> > > >>
> > > >>          pci_bus_add_devices(bus);
> > > >> +
> > > >> +        /*
> > > >> +         * Ensure pm_runtime_enable() is called for the controlle=
r drivers,
> > > >> +         * before calling pci_host_probe() as pm frameworks expec=
ts if the
> > > >> +         * parent device supports runtime pm then it needs to ena=
bled before
> > > >> +         * child runtime pm.
> > > >> +         */
> > > >> +        pm_runtime_set_active(&bridge->dev);
> > > >> +        pm_runtime_no_callbacks(&bridge->dev);
> > > >> +        devm_pm_runtime_enable(&bridge->dev);
> > > >> +
> > > >>          return 0;
> > > >>   }
> > > >>   EXPORT_SYMBOL_GPL(pci_host_probe);
> > > >
> > > > I just noticed that this change in 6.13-rc1 is causing the followin=
g
> > > > warning on resume from suspend on machines like the Lenovo ThinkPad
> > > > X13s:
> >
> > > Can you confirm if you are seeing this issue is seen in the boot-up
> > > case also. As this part of the code executes only at the boot time an=
d
> > > will not have effect in resume from suspend.
> >
> > No, I only see it during resume. And enabling runtime PM can (and in
> > this case, obviously does) impact system suspend as well.
> >
> > > >   pci0004:00: pcie4: Enabling runtime PM for inactive device with a=
ctive children
> >
> > > I believe this is not causing any functional issues.
> >
> > It still needs to be fixed.
> >
> > > > which may have unpopulated ports (this laptop SKU does not have a m=
odem).
> >
> > > Can you confirm if this warning goes away if there is some endpoint
> > > connected to it.
> >
> > I don't have anything to connect to the slot in this machine, but this
> > seems to be the case as I do not see this warning for the populated
> > slots, nor on the CRD reference design which has a modem on PCIe4.
> >
>
> Yes, this is only happening for unpopulated slots and the warning shows u=
p only
> if runtime PM is enabled for both PCI bridge and host bridge. This patch =
enables
> the runtime PM for host bridge and if the PCI bridge runtime PM is also e=
nabled
> (only happens now for ACPI/BIOS based platforms), then the warning shows =
up only
> if the PCI bridge was RPM suspended (mostly happens if there was no devic=
e
> connected) during the system wide resume time.
>
> For the sake of reference, PCI host bridge is the parent of PCI bridge.
>
> Looking at where the warning gets triggered (in pm_runtime_enable()), we =
have
> the below checks:
>
> dev->power.runtime_status =3D=3D RPM_SUSPENDED
> !dev->power.ignore_children
> atomic_read(&dev->power.child_count) > 0
>
> When pm_runtime_enable() gets called for PCI host bridge:
>
> dev->power.runtime_status =3D RPM_SUSPENDED
> dev->power.ignore_children =3D 0
> dev->power.child_count =3D 1
>
> First 2 passes seem legit, but the issue is with the 3rd one. Here, the
> child_count of 1 means that the PCI host bridge has an 'active' child (wh=
ich is
> the PCI bridge). The PCI bridge was supposed to be RPM_SUSPENDED as the r=
esume
> process should first resume the parent (PCI host bridge). But this is not=
 the
> case here.
>
> Then looking at where the child_count gets incremented, it leads to
> pm_runtime_set_active() of device_resume_noirq(). pm_runtime_set_active()=
 is
> only called for a device if dev_pm_skip_suspend() succeeds, which require=
s
> DPM_FLAG_SMART_SUSPEND flag to be set and the device to be runtime suspen=
ded.
>
> This criteria matches for PCI bridge. So its status was set to 'RPM_ACTIV=
E' even
> though the parent PCI host bridge was still in the RPM_SUSPENDED state. I=
 don't
> think this is a valid condition as seen from the warning triggered for PC=
I host
> bridge when pm_runtime_enable() is called from device_resume_early():
>
> pci0004:00: pcie4: Enabling runtime PM for inactive device with active ch=
ildren

Thanks for the detailed analysis, much appreciated.

So this seems to boil down to the fact that the PM core calls
pm_runtime_set_active() for a device, when it really should not. If
there is a clever way to avoid that, I think we need Rafael's opinion
on.

>
> I'm not sure of what the fix is in this case. But removing the
> DPM_FLAG_SMART_SUSPEND flag from PCI bridge driver (portdrv) makes the wa=
rning
> go away. This indicates that something is wrong with the DPM_FLAG_SMART_S=
USPEND
> flag handling in PM core.

As an intermediate step, perhaps the easiest thing here is to remove
the DPM_FLAG_SMART_SUSPEND flag from the PCI bridge? Ideally it should
not break anything, but we probably would lose some optimizations.

Another option would be to use pm_suspend_ignore_children(), but I am
not sure if that would be the correct thing to do here.

>
> Ulf/Rafael, thoughts?
>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

Kind regards
Uffe

