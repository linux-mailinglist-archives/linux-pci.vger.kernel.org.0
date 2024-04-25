Return-Path: <linux-pci+bounces-6661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FCC8B1BF2
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 09:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD83A1C23E07
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 07:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CAD6EB5C;
	Thu, 25 Apr 2024 07:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="K/N2DRIa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036096EB46
	for <linux-pci@vger.kernel.org>; Thu, 25 Apr 2024 07:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714030404; cv=none; b=dWmlrhgpoDPw4VTJXvaRKHtUtKAzbxWq+0MunWf4GVd1yOg9BEXVOEo6mpYt5ZXnGj8fk/VsaqblnrCwGU+JT5cu87y+04JJZ+HsrQJ1UOu2hsTMrEdVaebqy2QihCKqtWRnne850xBkhRQkXsyXb/atNmpGD2U1SfLjYQEY6C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714030404; c=relaxed/simple;
	bh=BcHYLSESJ0hPv7oQYl6LtJ1bX+Ez09LQmP/mQu7Fbac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOMAqEFqrLFpaz4tAWSBDq2OCV5zDa3m8saYEDYJAntw1b4c3ez4k3VDr4K/vLdorEl5mtSjtqaQPBfaqX5BaC8qniCp0rPnfm7Uli7cYW3zCbOkbY+oW7m0P9exwJ4KBfsjLfew0PNpPKffrfvoJPfnUk7rQ4d9ugrTa0mva5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=K/N2DRIa; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 403763F6FD
	for <linux-pci@vger.kernel.org>; Thu, 25 Apr 2024 07:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714030395;
	bh=N49t3AK4kKaDmcRRhdLxt0k+B5LqZexfU9NZVLcAJRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=K/N2DRIaAjRmNok+zH6+pAoU60HS5IhDtlWrvgoAC+5zlde01ji/jFB9aetPrMeeN
	 9pgn7qyz659domxob/FkcKPJfW0/vk6864KnoOLXosCrt26NqEll/LCHjuYSDs/KAK
	 /GwwGVFrS2ib1JkZmgqqi70fNvWJrYPjia0XLMXh/kwHDiN9adj4Szvs+t1ZlomlI4
	 bdGPm7KpPZG1k8Djjtmdbj6XX3BSHM5D9NKVQH2DoGwj29Y3neOyH2rSiX1S1e7N0R
	 WTe0I3dRI8Wklfu4T9wdQXSsC7s5A3dcbFa1Rxfqdq3KulbSK3SGmzfuYMtzFqCF6A
	 fDlP1dnM0ifTg==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ae0abc0b41so869777a91.2
        for <linux-pci@vger.kernel.org>; Thu, 25 Apr 2024 00:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714030394; x=1714635194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N49t3AK4kKaDmcRRhdLxt0k+B5LqZexfU9NZVLcAJRM=;
        b=adb7HMqr+q8R+GclZH80VopnP+VrRFv71rAy9iCKpUC/3mxrsXM+d6sgw151xqrgMJ
         KmeSz4pHaAT+pxBYtTOAjNdhogpsikK0CRPBIx2kRnhdll1dVjXFByVQLNVI6Mjr/BuF
         nNWnDnYJmhzisO/AjumhTW5750FKyVZ5c68S8QZNzh+bBIOj4SpvoZp+upZOHVXk94py
         gyyzeYNldHh0Kj2mCpoX4okGBaxoHi3yFEmQ/+FfKh9fY+FgIXULFzqwvfDq0hSw/Ao6
         UureeiFcJrUXR7dI9zzTEUctBLHzfxofNlZoCZO/c440y+AiL7oz/uacCT686qwe9rDy
         VXIA==
X-Forwarded-Encrypted: i=1; AJvYcCWsgWBGQ35Lun9A/Fb1F5oi07LJjCCbe3OPvZIuDoaQEL1u9YqhYfygTo/fxaNEHySmeVHKcUW2eFfC8rLxpucfz3C9jdKRh1Yr
X-Gm-Message-State: AOJu0YzOqLaASRzWo8HSNnkB7d012NU4lVeIooUky5YWSD2LafnwgP6E
	b4DmTh6Yc65/Mi3aqaXhzsZ0XfpWtQj4+7dnQgD8wKD/KnBgi98URP/T1z0RNrWOOAhaohhxjt2
	5HzRsbbvMgp1z5bD+SU6OCM67a/kdLOe+KnJTGGOl/HrvaZTbUq5ld1ngC3Ql4I4AwXq8Vim2qu
	QjF5mXcnfEjHYiizFnMzoykkNlcCE89a1VCWtLtHdTXGnr2VKe
X-Received: by 2002:a17:90a:f18c:b0:2a2:775:9830 with SMTP id bv12-20020a17090af18c00b002a207759830mr3635614pjb.11.1714030393820;
        Thu, 25 Apr 2024 00:33:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxdkPh6jUQbDypZw6ih5aBEWZ8OaLuVmwkpiSeYBIaD8D8JrEbgl1UlPs5pmFlAQ5PAStLbkRGh+jSeMu9NOg=
X-Received: by 2002:a17:90a:f18c:b0:2a2:775:9830 with SMTP id
 bv12-20020a17090af18c00b002a207759830mr3635577pjb.11.1714030393404; Thu, 25
 Apr 2024 00:33:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416043225.1462548-2-kai.heng.feng@canonical.com> <20240418203531.GA251408@bhelgaas>
In-Reply-To: <20240418203531.GA251408@bhelgaas>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 25 Apr 2024 15:33:01 +0800
Message-ID: <CAAd53p7O51mG7LMrEobEgGrD8tsDFO3ZFSPAu02Dk-R0W3mkvg@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] PCI/AER: Disable AER service on suspend
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, bagasdotme@gmail.com, 
	regressions@lists.linux.dev, linux-nvme@lists.infradead.org, kch@nvidia.com, 
	hch@lst.de, gloriouseggroll@gmail.com, kbusch@kernel.org, sagi@grimberg.me, 
	hare@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 4:35=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Tue, Apr 16, 2024 at 12:32:24PM +0800, Kai-Heng Feng wrote:
> > When the power rail gets cut off, the hardware can create some electric
> > noise on the link that triggers AER. If IRQ is shared between AER with
> > PME, such AER noise will cause a spurious wakeup on system suspend.
> >
> > When the power rail gets back, the firmware of the device resets itself
> > and can create unexpected behavior like sending PTM messages. For this
> > case, the driver will always be too late to toggle off features should
> > be disabled.
> >
> > As Per PCIe Base Spec 5.0, section 5.2, titled "Link State Power
> > Management", TLP and DLLP transmission are disabled for a Link in L2/L3
> > Ready (D3hot), L2 (D3cold with aux power) and L3 (D3cold) states. So if
> > the power will be turned off during suspend process, disable AER servic=
e
> > and re-enable it during the resume process. This should not affect the
> > basic functionality.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D209149
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216295
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218090
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> Thanks for reviving this series.  I tried follow the history about
> this, but there are at least two series that were very similar and I
> can't put it all together.
>
> > ---
> > v8:
> >  - Add more bug reports.
> >
> > v7:
> >  - Wording
> >  - Disable AER completely (again) if power will be turned off
> >
> > v6:
> > v5:
> >  - Wording.
> >
> > v4:
> > v3:
> >  - No change.
> >
> > v2:
> >  - Only disable AER IRQ.
> >  - No more check on PME IRQ#.
> >  - Use helper.
> >
> >  drivers/pci/pcie/aer.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index ac6293c24976..bea7818c2d1b 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -28,6 +28,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/kfifo.h>
> >  #include <linux/slab.h>
> > +#include <linux/suspend.h>
> >  #include <acpi/apei.h>
> >  #include <acpi/ghes.h>
> >  #include <ras/ras_event.h>
> > @@ -1497,6 +1498,28 @@ static int aer_probe(struct pcie_device *dev)
> >       return 0;
> >  }
> >
> > +static int aer_suspend(struct pcie_device *dev)
> > +{
> > +     struct aer_rpc *rpc =3D get_service_data(dev);
> > +     struct pci_dev *pdev =3D rpc->rpd;
> > +
> > +     if (pci_ancestor_pr3_present(pdev) || pm_suspend_via_firmware())
> > +             aer_disable_rootport(rpc);
>
> Why do we check pci_ancestor_pr3_present(pdev) and
> pm_suspend_via_firmware()?  I'm getting pretty convinced that we need
> to disable AER interrupts on suspend in general.  I think it will be
> better if we do that consistently on all platforms, not special cases
> based on details of how we suspend.

Sure. Will change in next revision.

>
> Also, why do we use aer_disable_rootport() instead of just
> aer_disable_irq()?  I think it's the interrupt that causes issues on
> suspend.  I see that there *were* some versions that used
> aer_disable_irq(), but I can't find the reason it changed.

Interrupt can cause system wakeup, if it's shared with PME.

The reason why aer_disable_rootport() is used over aer_disable_irq()
is that when the latter is used the error still gets logged during
sleep cycle. Once the pcieport driver resumes, it invokes
aer_root_reset() to reset the hierarchy, while the hierarchy hasn't
resumed yet.

So use aer_disable_rootport() to prevent such issue from happening.

Kai-Heng

>
> > +
> > +     return 0;
> > +}
> > +
> > +static int aer_resume(struct pcie_device *dev)
> > +{
> > +     struct aer_rpc *rpc =3D get_service_data(dev);
> > +     struct pci_dev *pdev =3D rpc->rpd;
> > +
> > +     if (pci_ancestor_pr3_present(pdev) || pm_resume_via_firmware())
> > +             aer_enable_rootport(rpc);
> > +
> > +     return 0;
> > +}
> > +
> >  /**
> >   * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
> >   * @dev: pointer to Root Port, RCEC, or RCiEP
> > @@ -1561,6 +1584,8 @@ static struct pcie_port_service_driver aerdriver =
=3D {
> >       .service        =3D PCIE_PORT_SERVICE_AER,
> >
> >       .probe          =3D aer_probe,
> > +     .suspend        =3D aer_suspend,
> > +     .resume         =3D aer_resume,
> >       .remove         =3D aer_remove,
> >  };
> >
> > --
> > 2.34.1
> >

