Return-Path: <linux-pci+bounces-32715-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4B0B0D7A6
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 13:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F40E1AA73CA
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 11:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C3828B3FD;
	Tue, 22 Jul 2025 11:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QJ21O9vS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3254288CA2
	for <linux-pci@vger.kernel.org>; Tue, 22 Jul 2025 11:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182185; cv=none; b=MeVhMHzf0nJA3Sgfl2PsN8pmjzeFQMJ8kHzCQAksaIGvR+jYEV4/fjbXD0rKynBlDBR9Lac0Y/hQRGZFYCBEyTIVu5BbL7570NQttB2Vt1yFlxQ5gtbnuMuMP+ida8s4kXkgbJcc1oNQD48uylaXH1M2L3ZN0p8NkrEcVLWBYkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182185; c=relaxed/simple;
	bh=7ygXwiazM3DBgoEdnr8EOhrQUBsDYruWMyUnmDnC0PM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cv4FAQy3xzZyafYTnF/7uwvJeCMirH3+YOFhWbPRH3ncOL0Oxi7WKFFOQV3ZucR+2MIoyQxHqguM137Aq2ors4z9dxJjQecYQxajGglj2ix1fMjUf4XnSi1RSfaT02Ud9Jh3x4RRVe1zFjwlCiexc8lsTNj+tmbq1aXjp6M/60k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QJ21O9vS; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-553affea534so870606e87.2
        for <linux-pci@vger.kernel.org>; Tue, 22 Jul 2025 04:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1753182182; x=1753786982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+f5MBjf2c9RdWgl13mFzIEw+8X2xDYkbdrq8cXLh5JU=;
        b=QJ21O9vSekVVMmjdzsaVwJBeXxm5EdehivUUMvHvo6kCN4UrvxQ+2dRytEXZ0kcTOv
         t4u4SzOBmJV1ptkgYL+vIeR/iXLT9aeNQnZNo7/alvtdsZe9SGxJqqrdcqUzLPRYdR8q
         BdVt3DT711fv3eY6L15R5DFJAZ5d2O2eRx3TryO8NX/dkAgGeoSRMtO+RxiX/fwgBw6d
         mSg+4FaZeXLnxoqNi0H7fFo+/GUL2WPP6jn8LfM+JTw1tBFzN+5C07UAKwFxFF8En4xj
         scfLraMU3s8bnxmx0Ci7EHpdYBf3Ag2NQmeeYOOyxhA074EPVH175jGio/+ZoOGPpRoS
         pUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753182182; x=1753786982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+f5MBjf2c9RdWgl13mFzIEw+8X2xDYkbdrq8cXLh5JU=;
        b=VzxmZOChkBlTNgY1DiPEwG//xyQzWqZoNrnYaEn0TaAuesBxo3Wj2vkXdjQS8/ifJo
         9zUQj2IUujGw0F0ssZuVGnRgbYaTO3nWVu2IE9n+ZKFLOQBJ4YG19TuYj3dubuA1VK5o
         H99C+yPgTyd5GRS2th4hzvGzQv838eFMf0JvvhoTiIj8uA3e6MvHdWlTwn/valYN1q1w
         Ow7zHGAnKuRDAAl4suM0FF9zOIvfB8EPehR5Wn1FvjI8cVtGyVEMrDEz6Q/pEKwxlGvy
         DD4cR7ud+5Vd2SRq6rtlvrKyEvfKQVqxhdlT4fKMb/I7gHdmmapTYVcMcooyb+Ydav1a
         Vm/w==
X-Forwarded-Encrypted: i=1; AJvYcCWAtLkqTR4vAtniEj1xaELlfsqCrWBukJroetSuygiwYdvq8sgarorwjmRll7Q/11uvpxLybT7YNgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNlIy7mw9d320GHG66H6Wwyuxlz6lQkZZHBM2Uoun5UgiZMln1
	kTFB7tyTlttuv45G/IWeBrWa8v1lnHfti/iPEhY+BrfPrQ0ouNY3iipk4eRWJngxaJ2UwE5Yt5f
	4+mgmPklfQOr3duNab9sl6zKo/ZhNWBxuSBSEOArdVg==
X-Gm-Gg: ASbGncsTD6LGQTvRFbEsMJ8gGPd9uoqi9aYSmdTEddGDwDxy9X1h5ixou82Hd2ElE6e
	eqRAMxRx1+7bVkIaD46HdL2WHBahrce/CNmviG/QzhYO5NcJ6cHcKmwWMOs1KjJTY0Yr0vuZcoz
	7kDFXhGxyQ8FsmOTtQMT7z5/1MAfEbs/9NI6+ZFVwQFg5l9YT/HGYo5e5EW1issFJaWK27n8n7x
	lR6bfNRBJwbfymBqd42
X-Google-Smtp-Source: AGHT+IHV4G4Ez+6nZ6e+stPh9RxUJddPWLH2a7Nfk7yzsYpFWosqH+zb41u7v0ksvoPYA0RUTzzEURpIh4kKOm//Q5k=
X-Received: by 2002:a05:6512:3e1c:b0:545:2774:4cb0 with SMTP id
 2adb3069b0e04-55a23142880mr2840134e87.0.1753182181468; Tue, 22 Jul 2025
 04:03:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720151551.735348-1-superm1@kernel.org> <aH0MlOshychrsvg9@wunner.de>
 <tvee57irw3xjdcpvikxu63sryxt3admlbtdwgd634in3woxhob@rvq3njadpmie>
In-Reply-To: <tvee57irw3xjdcpvikxu63sryxt3admlbtdwgd634in3woxhob@rvq3njadpmie>
From: Shuan He <heshuan@bytedance.com>
Date: Tue, 22 Jul 2025 19:02:50 +0800
X-Gm-Features: Ac12FXxrpAOXq3BwGvllxv6PQ2BpcrmI0vqc1Ty3tTu14b5BCJhgRjAa7_v3ooU
Message-ID: <CAKmKDKnKikjK+v=mDAYzsWDAV0+3cFs5+449HE01ssOkHKjX2Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] PCI: Adjust visibility of boot_display
 attribute instead of creation
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Mario Limonciello <superm1@kernel.org>, mario.limonciello@amd.com, 
	bhelgaas@google.com, Stephen Rothwell <sfr@canb.auug.org.au>, linux-pci@vger.kernel.org, 
	Sunil V L <sunilvl@ventanamicro.com>, cuiyunhui@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mani,

>Separate question: Do we really need to call pci_create_sysfs_dev_files() =
from
>pci_sysfs_init()? It is already getting called from pci_bus_add_device() a=
nd it
>looks redundant to me. More importantly, it can also lead to a race (thoug=
h
>won't happen practically) [1].

>Same goes for pci_proc_attach_device(). I was tempted to submit a patch re=
moving
>both these calls from pci_sysfs_init() and pci_proc_init(), but wanted to =
check
>first.
Thanks for pointing this out.
Yes, please do this! I was also considering deleting those unprotected call=
s,
pci_proc_attach_device and pci_create_sysfs_dev_files respectively.
Just wondering what needs to be checked before removing them.

Plus, now I am testing the following changes on my developing environment a=
nd
it works well so far.

--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1722,18 +1722,9 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev=
)
 static int __init pci_sysfs_init(void)
 {
-       struct pci_dev *pdev =3D NULL;
        struct pci_bus *pbus =3D NULL;
-       int retval;
        sysfs_initialized =3D 1;
-       for_each_pci_dev(pdev) {
-               retval =3D pci_create_sysfs_dev_files(pdev);
-               if (retval) {
-                       pci_dev_put(pdev);
-                       return retval;
-               }
-       }
        while ((pbus =3D pci_find_next_bus(pbus)))
                pci_create_legacy_files(pbus);
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 9348a0fb8084..b78286afe18e 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -463,13 +463,10 @@ int pci_proc_detach_bus(struct pci_bus *bus)
 static int __init pci_proc_init(void)
 {
-       struct pci_dev *dev =3D NULL;
        proc_bus_pci_dir =3D proc_mkdir("bus/pci", NULL);
        proc_create_seq("devices", 0, proc_bus_pci_dir,
                    &proc_bus_pci_devices_op);
        proc_initialized =3D 1;
-       for_each_pci_dev(dev)
-               pci_proc_attach_device(dev);
        return 0;
 }

Bests,
Shuan


On Mon, Jul 21, 2025 at 3:16=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Sun, Jul 20, 2025 at 05:34:44PM GMT, Lukas Wunner wrote:
> > On Sun, Jul 20, 2025 at 10:15:08AM -0500, Mario Limonciello wrote:
> > > There is a desire to avoid creating new sysfs files late, so instead
> > > of dynamically deciding to create the boot_display attribute, make
> > > it static and use sysfs_update_group() to adjust visibility on the
> > > applicable devices.
> > [...]
> > > @@ -1698,7 +1690,7 @@ int __must_check pci_create_sysfs_dev_files(str=
uct pci_dev *pdev)
> > >     if (!sysfs_initialized)
> > >             return -EACCES;
> > >
> > > -   retval =3D pci_create_boot_display_file(pdev);
> > > +   retval =3D sysfs_update_group(&pdev->dev.kobj, &pci_display_attr_=
group);
> > >     if (retval)
> > >             return retval;
> > >
> >
> > pci_create_sysfs_dev_files() is called from two places, pci_bus_add_dev=
ice()
> > and the late_initcall pci_sysfs_init().
> >
>
> Separate question: Do we really need to call pci_create_sysfs_dev_files()=
 from
> pci_sysfs_init()? It is already getting called from pci_bus_add_device() =
and it
> looks redundant to me. More importantly, it can also lead to a race (thou=
gh
> won't happen practically) [1].
>
> Same goes for pci_proc_attach_device(). I was tempted to submit a patch r=
emoving
> both these calls from pci_sysfs_init() and pci_proc_init(), but wanted to=
 check
> first.
>
> [1] https://lore.kernel.org/linux-pci/r7fgb5xrn6ocstq6ctq4q7r4o2esgh4rqr4=
4c3u234kcep6thk@bge2vzl33ptb/
>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
>

