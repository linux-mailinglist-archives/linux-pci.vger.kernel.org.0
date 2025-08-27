Return-Path: <linux-pci+bounces-34898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5924B37D61
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 10:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC79C18893C3
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 08:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90A0277C94;
	Wed, 27 Aug 2025 08:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fVAvD8bG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360242836A0
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 08:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756282648; cv=none; b=gH3QBG1qt8EKYIZrwEET1Uy4cRSvEy5Nn0i6khqpAc88y597kMjArYzk5C++dj7O+wV9LCrCLl3Evso/8xbaAn8Pbpd2gb0s56cyHNPxdnbtkmD5duZA40RWQyqn8tItjeAOvk4oXq4noYDxXXqL/q6Bq2TXEOxaOGB/W1CZaao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756282648; c=relaxed/simple;
	bh=ini/Dg/qMFzbwNKKWsndLioGgin9QxvTIdp1lM1/knI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hihb4Ku/X8itShFpT1BI82EZnWyxAoFE8CBoxm+rct1Nj8ZhAoDp/g8vdl8aPNdu/oAFcCyYv6nKjU2UpULo+mNA6mV9dWTqF5AmwipO4oZc3T0LtRr4vXKlCxfoX/QejOl3Xl3Y4w70Hfbn2+kQwTAEaG8gj4E3LmT4VwuWYIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fVAvD8bG; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32326e20aadso7571055a91.2
        for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 01:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756282646; x=1756887446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rw6pFx8vb3qCt0eWgbwwuAkBawJ8J17IDZtKMfIRe0c=;
        b=fVAvD8bGXejU/Z2MmG7wpFMW6iIkiLDIz7MFGXomSrTOc1PMYgG+G/YfZW3VlOF9kw
         Rg61+FUrKfhAO0lB+gxBIMCnLiyS956s5ovd+OPhOLQ2XFK/1RZFLnWZuxkdegCGv8aH
         /NIksY7MmE9trBF50sOzpjoCIFPYtF8UV0XQuJco2V5oNIfA1iuXakc9GxReUr2qE3yt
         d6VFxudj9gsBxdO3PLeQL0zm4QwoVIuqQVR8v1y0NRZOfuwljLrSIUXpLn6bJPZCFswu
         JlmqMnUz82Lp59Z/wBV5AJb7AbnA+8gTiD4jVvH/bHm+7v/oGWWLAquBM/d/q1p7tGI5
         HTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756282646; x=1756887446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rw6pFx8vb3qCt0eWgbwwuAkBawJ8J17IDZtKMfIRe0c=;
        b=Q4nxB4Lj9olxyNdGtO0/5ARBwIu/5TG6DUgyEjjRAZK9CbLAaCM16SiJjKHWEWSMKj
         fxN0p58eZcF+zJYgIJfMpiF6VlYSngVB+Nhz7XnVfYGpqyb/oxlkU2o24EmLS/zSGNQ6
         6edcBywpZr0NFJZm1fYyAhm+8JbCWjT45S+yQtarf8M/Izx1DQuhLeAfD/TuDpQZ6gzc
         92Y+1Rs7fVQ1MDBdb9BK0TGjzMLR/vEF2iYTbaKa3d/z9rujQ1CLvMftCT3G/ba3nWhV
         oJ2vtavgIzeA42p4ZHwhwgHS9zybVnCqzKwCr7AL8UjZy6CMt/pz4C+102MnUFtxCekz
         iHjA==
X-Forwarded-Encrypted: i=1; AJvYcCUB6Zyya4UCY69FR9Fa9Zhtig0XRqzEl+cv/5Ikj8Ye3TxxZnm+NJfC3DQVW72cs6CzCyqcDCpoWIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo/+fZcI4xYSLZhK6BlRIyqH70kKkDg/Q39ZLkVJrEMe7adpUg
	nbpbW6tBeX6agg72zK7wMGbv84VrUgEnB8jK1Zp0m2msnsZM0cO6Fi+Y/shVBIbjcSJneZtGXyt
	vrqaRdo3GATGoQ+5huYOD2fw5AipRM0lS6cMbcEewEg==
X-Gm-Gg: ASbGnctqpILPGhS/rKxMvVRifAex74BJdLz2yJGg9cezvYc7/zhogcz8zUW9kP/GwwC
	jHtbqaPuKNfN8EyKu5WhwuMDwE1EXpBBitPQDudsN4ZMIUwPb8ELjrv6l7iTUjjst9oqEuiakGf
	XN2a+On8cbc4Gqrjir9o1E26OAFEx9cu814+qemqplsEnWbdOS7Vcefnyf2/OrbYdp5FT0blZ37
	QlCCQUDbqZSIXYGQpIQz+yJr/1InKr6XP2Y9xj7
X-Google-Smtp-Source: AGHT+IHXV0XIJbSOruANIhEDSo4ztOVg47pK0P0Ye2hoQsvKDAy3OuT0JReOys0s//MIC3rIMXgdY/LDTorvaRJkGgc=
X-Received: by 2002:a17:90b:54c3:b0:311:c970:c9c0 with SMTP id
 98e67ed59e1d1-32515ec1313mr22920541a91.22.1756282646397; Wed, 27 Aug 2025
 01:17:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813232835.43458-1-inochiama@gmail.com> <20250813232835.43458-3-inochiama@gmail.com>
 <aK4O7Hl8NCVEMznB@monster> <db2pkcmc7tmaozjjihca6qtixkeiy7hlrg325g3pqkuurkvr6u@oyz62hcymvhi>
 <qe23hkpdr6ui4mgjke2wp2pl3jmgcauzgrdxqq4olgrkbfy25d@avy6c6mg334s> <20250827004719.GA2519033@ax162>
In-Reply-To: <20250827004719.GA2519033@ax162>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 27 Aug 2025 13:47:14 +0530
X-Gm-Features: Ac12FXzvPaHx0Y-UEkNxm_tosSQU8r9fXEo91EwR-5NGfEUW74KCwisELg0mjB0
Message-ID: <CA+G9fYsAxq-RmU7fVSDQ8_B2Hm5NY7Q7=DUnqcpnt8BOtd0dUA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] PCI/MSI: Add startup/shutdown for per device domains
To: Nathan Chancellor <nathan@kernel.org>
Cc: Inochi Amaoto <inochiama@gmail.com>, Anders Roxell <anders.roxell@linaro.org>, 
	regressions@lists.linux.dev, linux-next@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Shradha Gupta <shradhagupta@linux.microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Jonathan Cameron <Jonathan.Cameron@huwei.com>, 
	Juergen Gross <jgross@suse.com>, Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Chen Wang <unicorn_wang@outlook.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>, arnd@arndb.de, dan.carpenter@linaro.org, 
	benjamin.copeland@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Aug 2025 at 06:17, Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Wed, Aug 27, 2025 at 07:28:46AM +0800, Inochi Amaoto wrote:
> > OK, I guess I know why: I have missed one condition for startup.
> >
> > Could you test the following patch? If worked, I will send it as
> > a fix.
>
> Yes, that appears to resolve the issue on one system. I cannot test the
> other at the moment since it is under load.

I have built on top of Linux next-20250826 tag and the qemu-arm64 boot test
pass and LTP smoke test also pass.

>
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

>
> > ---
> > diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
> > index e0a800f918e8..b11b7f63f0d6 100644
> > --- a/drivers/pci/msi/irqdomain.c
> > +++ b/drivers/pci/msi/irqdomain.c
> > @@ -154,6 +154,8 @@ static void cond_shutdown_parent(struct irq_data *data)
> >
> >       if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
> >               irq_chip_shutdown_parent(data);
> > +     else if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
> > +             irq_chip_mask_parent(data);
> >  }
> >
> >  static unsigned int cond_startup_parent(struct irq_data *data)
> > @@ -162,6 +164,9 @@ static unsigned int cond_startup_parent(struct irq_data *data)
> >
> >       if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
> >               return irq_chip_startup_parent(data);
> > +     else if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
> > +             irq_chip_unmask_parent(data);
> > +
> >       return 0;
> >  }
> >

