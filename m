Return-Path: <linux-pci+bounces-11461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1DE94B188
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 22:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47672B24159
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 20:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF48145FED;
	Wed,  7 Aug 2024 20:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c5L0MqrI"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4AC145FE1
	for <linux-pci@vger.kernel.org>; Wed,  7 Aug 2024 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723063249; cv=none; b=Nw1t/oS2uRYmu+XdMeFQZpXsD7A4w6as0NFvOtw3j4dORSGwxVx2sy9cNoe80qGQvSNzkyZF5dAZU5usnl4TiNBGBk+DDhcQIhTW8qoT8ZZC2mFtjksX18LEuUiiTSgmDLK3Wr4VsDGkm0NCnw++oTeGCBWb1DZ3NVcrb0yVs+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723063249; c=relaxed/simple;
	bh=55YDRrtOt4tmON+c01+nExQ7zCVLeDHsxIp4g/SLcaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5yNACy2gt72Yi5HsqCVrob+W5/fzUhXSIzd0nXOOfG1Rbs10ux6gUrkU4iakL+H0bXMqCLiz+LeNaACFzX4otqinNWwFyqDG/xUX/DonUXp4X4IjMq5fy1r38+gMeE8+V7u/HHkURcjQxfhbXC4oaaHzkkq4OLCPZmcuU9DWRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c5L0MqrI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723063246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NuT7wPEgPegJMdZEEQjcUmkz4FbQk34dp23i6B4YFbM=;
	b=c5L0MqrI/FAeRZjsqG4lDEgIYqTGHE2ReY/w1WqaO0rBhVziXuftigbAzyBPwPNw4LxzqC
	bty59GAa+A9xSCUGBF1g+EuELX6ktBAJKu+btUIqiqPM8nPrOdChU4/HU9PxoyXecBWuDu
	2b3Mf+0XtNY1exVfWE8FU7o+yE+k1NE=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-4CwmtXF7NLO-BkaR-xe4PA-1; Wed, 07 Aug 2024 16:40:45 -0400
X-MC-Unique: 4CwmtXF7NLO-BkaR-xe4PA-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-69a0536b23aso5160257b3.3
        for <linux-pci@vger.kernel.org>; Wed, 07 Aug 2024 13:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723063245; x=1723668045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NuT7wPEgPegJMdZEEQjcUmkz4FbQk34dp23i6B4YFbM=;
        b=HUkmhSovcmzso01AtAe+EVkrlInIf0POPc6sYTP4SAfnjVookYb1177h9FivdPgNxt
         u0wL5W6L1q1KH/vvZffQ66bKDwlTtcVpv4vao+2wicpqVa3/0JSeXq4m3JfBsQz3eii0
         GpLenxwbbUP6Y8st7S8iCc9iG7byxzOgT2h8E3t99clDiC62IqV82b6oe6rTtmL9B2so
         Ab2dALiDHSRzMYOhtJOBcIjn3hjnsPlw1aWcoCsI0y7VPKLBLmpKVZ/KM8RLJHxwamZ9
         XwcBmPYPwMm20terTaacGfAybRg2WgUmmsPHwSYn/uXRSqrmaaEqN+yWWCaTB4wRzWRg
         kCfg==
X-Forwarded-Encrypted: i=1; AJvYcCVfqmQGrELBSzPHoD3aeGdUjTD+gEuKgY0sW0vhKwx5jBw0/Gt0yb75jBMf+b4k01OGFIgkN4El7hVk+FpZ8zD4oZ+TFoi/E12B
X-Gm-Message-State: AOJu0YwR2Vn6YcAecT6N29VpUHgQC5A78uF74P4dML7fHD6AselCrxsi
	uL0Kp3FlB5rm7oObK/kkQc5who4GWlV9XJU8Ge0diuenObt/hUphmFKHjLbTXwWg5YQa5WyJmZz
	eQ3561bFEZldcPNlv71rNENA9lN9PgyB8sIiNduyulRnwqnJZNbWiP+sllEyfc9FUzhEDOHKMVo
	xUTA1CnWfPqQ/1qjubchbeatLmxpatHo/s
X-Received: by 2002:a05:6902:108f:b0:e0b:e6da:83f2 with SMTP id 3f1490d57ef6-e0be6da8570mr20071283276.22.1723063245076;
        Wed, 07 Aug 2024 13:40:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7o6e1QQzQm+QZaPjztNenu/RRqVV+1JEdYvx5ZzNxvqvMPsnDM1pqizaWMoZmY8u96PT7o6OULbbwhXo7QHM=
X-Received: by 2002:a05:6902:108f:b0:e0b:e6da:83f2 with SMTP id
 3f1490d57ef6-e0be6da8570mr20071263276.22.1723063244750; Wed, 07 Aug 2024
 13:40:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807083018.8734-2-pstanner@redhat.com> <20240807202431.GA110503@bhelgaas>
In-Reply-To: <20240807202431.GA110503@bhelgaas>
From: David Airlie <airlied@redhat.com>
Date: Thu, 8 Aug 2024 06:40:31 +1000
Message-ID: <CAMwc25q+SnSBFfuKcmw8W39CmsLn4V0ZCuuSbkGTc961WRGhoQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: Deprecate pcim_iomap_regions() in favor of pcim_iomap_region()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Philipp Stanner <pstanner@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Bjorn Helgaas <bhelgaas@google.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 6:33=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Wed, Aug 07, 2024 at 10:30:18AM +0200, Philipp Stanner wrote:
> > pcim_iomap_regions() is a complicated function that uses a bit mask to
> > determine the BARs the user wishes to request and ioremap. Almost all
> > users only ever set a single bit in that mask, making that mechanism
> > questionable.
> >
> > pcim_iomap_region() is now available as a more simple replacement.
> >
> > Make pcim_iomap_region() a public function.
> >
> > Mark pcim_iomap_regions() as deprecated.
> >
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>
> The interesting part of this little series is in ast_drv.c, but there
> may be similar conversions for other drivers coming as well.
>
> To avoid races during the merge window, I propose merging this via the
> PCI tree so I can ensure that any other conversions happen after
> pcim_iomap_region() becomes public.
>
> That would require an ack from Dave.  But if you'd rather take this
> yourself, Dave, here's my ack for the PCI piece:
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I'm fine with it going in via pci.

Acked-by: Dave Airlie <airlied@redhat.com>

Dave.

>
> > ---
> >  drivers/pci/devres.c | 8 ++++++--
> >  include/linux/pci.h  | 2 ++
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> > index 3780a9f9ec00..89ec26ea1501 100644
> > --- a/drivers/pci/devres.c
> > +++ b/drivers/pci/devres.c
> > @@ -728,7 +728,7 @@ EXPORT_SYMBOL(pcim_iounmap);
> >   * Mapping and region will get automatically released on driver detach=
. If
> >   * desired, release manually only with pcim_iounmap_region().
> >   */
> > -static void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
> > +void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
> >                                      const char *name)
> >  {
> >       int ret;
> > @@ -761,6 +761,7 @@ static void __iomem *pcim_iomap_region(struct pci_d=
ev *pdev, int bar,
> >
> >       return IOMEM_ERR_PTR(ret);
> >  }
> > +EXPORT_SYMBOL(pcim_iomap_region);
> >
> >  /**
> >   * pcim_iounmap_region - Unmap and release a PCI BAR
> > @@ -783,7 +784,7 @@ static void pcim_iounmap_region(struct pci_dev *pde=
v, int bar)
> >  }
> >
> >  /**
> > - * pcim_iomap_regions - Request and iomap PCI BARs
> > + * pcim_iomap_regions - Request and iomap PCI BARs (DEPRECATED)
> >   * @pdev: PCI device to map IO resources for
> >   * @mask: Mask of BARs to request and iomap
> >   * @name: Name associated with the requests
> > @@ -791,6 +792,9 @@ static void pcim_iounmap_region(struct pci_dev *pde=
v, int bar)
> >   * Returns: 0 on success, negative error code on failure.
> >   *
> >   * Request and iomap regions specified by @mask.
> > + *
> > + * This function is DEPRECATED. Do not use it in new code.
> > + * Use pcim_iomap_region() instead.
> >   */
> >  int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *nam=
e)
> >  {
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 4cf89a4b4cbc..fc30176d28ca 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -2292,6 +2292,8 @@ static inline void pci_fixup_device(enum pci_fixu=
p_pass pass,
> >  void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long =
maxlen);
> >  void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
> >  void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
> > +void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
> > +                                    const char *name);
> >  int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *nam=
e);
> >  int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
> >                                  const char *name);
> > --
> > 2.45.2
> >
>


