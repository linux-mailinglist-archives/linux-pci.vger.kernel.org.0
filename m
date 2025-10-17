Return-Path: <linux-pci+bounces-38500-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CF8BEB04B
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 19:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8281E1AE3DE8
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 17:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9842FE570;
	Fri, 17 Oct 2025 17:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="crq1HVv8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6792FD7B2
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760721069; cv=none; b=CsSykl1XoUvnsGYK//a5goEhsUDMluNL1HeTgKmvAiqbyXgNUJ9EOIy3ikGb1Sb/pLpWVyWn8wncfvxwad+iG0dK+wVncKEIk0iCO8TYvRHU4AXYi+ko4HJcnTJs6AlRhV8llJbf5fSLS6NhK9cYmth5r7dyJXAgS/BaGk6zGLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760721069; c=relaxed/simple;
	bh=aBjjIxnkY/FA3VjaRF/v5raEcuHOjy9Oe4kTong4tPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fg2L2U8GmUMhYUgQMYB2DNB5U4k3u4Dm/s8KqsEyHmWyVeslSyBkgnSm+eLOMn8ghKzZL+7LFV1LvnuyzrASC9YEEFlOxzqn6N7Lf69NJb3ldk5j8v0jPa4icWOUTmfkDSQ6f32AZeHKqHaQpE3y1uEPe1zdaCPnmKj4r8VT5Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=crq1HVv8; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3327f8ed081so2723972a91.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 10:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760721064; x=1761325864; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wBM/oeHMFZtatvJ+zW6/cnV/R+5GapNosgNZTWLHrZg=;
        b=crq1HVv8qH695bk3+v5Cz9kS/qrgPWdQ+zJLT3PY0JJ8YKP3aBkrnfiAeOjnylfV70
         a+MQaEhTO7ktQ710/nlibXmsxK9xO8J6PrMcSn6nefbYxkjIzUdwMKR9+6YTj/0hFfn1
         fxIM9WNbdM+YFxjwiu0xcEA9gfklIZ3MJm5MY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760721064; x=1761325864;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBM/oeHMFZtatvJ+zW6/cnV/R+5GapNosgNZTWLHrZg=;
        b=KnbGlsSrJ5Bmlts3O3Y3PeMX4J2HluQUHzo5zPpQKjbyUTuiyTH3UxmwDjA/uO5cLg
         GxNZ9wnwqer6fTgNJtLkeTyjm4ueJ1e5HVqh9n/1uCfnWpfvty4G+/UZBZORD1vPN/dT
         319MvR5sp93m+fTK2iZMROdClT+Jb3c2RoROoyVrzbA/tVRm81p1KZB2wmQxg35/aqEN
         BSmxwTOcNViMqAjAs02/QZc+81cWi8xw50l7I70Y2oNAfuUJutttcU/PJvHCiHzxEiVW
         ySe+vhJZrx0pRUh542p7ugz0SDBP4Ci1ggtkte0kxX0PWwwkWHL6OT8RhGmidZJdG4OQ
         citA==
X-Forwarded-Encrypted: i=1; AJvYcCXyIG/7SrYiEl64jum5JewAb9xDAX6pETjZoaTfE/xmPBAgb1B+zZn0VBiQUDfzZb9aXfM+wU1CozU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI25bntZuBmZgIyfXMQHS0NqJ541I2CgLsSelCrCjKISaiqDW2
	eP6s9u6P9siDQi7qOgbO8+dkDv90+Ok1ccrC3hTLnRL9iGGO0lpDlbUqFtB7jEf/Kg==
X-Gm-Gg: ASbGncvq1mR7HjODZ/ot1vlOdTl3m2s+h+9HWGdOJijX+hRD1kbhno8rNGaJWTnhmgR
	dKKEsF3JSpWmDzx/0u6a+rRjAdyxszfkgECf8RHkbSU2EdYWNSuPQXVf/DXQYiKRhjclG5GUUKw
	kmLV0nExMIfqN3lJBhH5e/im9008uoYbliwqz4B1VUAf20LrfGP0eeDY8qj9TtPcOpMIcRgRuBb
	t01jCpPtinvQLdEg8BS6CqzYcq+J9ZSz2EUUFYwjXZ2wpil0bNFN5LW6HqfzUNJHcXFiuegjsdm
	8IVFGsJUINiT97herXhKSbBD8pH2LFoxjtuF0CHhUGGI5CHNyj0V1xWTdyV1HpaUzr2b7yGXfZN
	wkv+9DoB192sCrcre/m5lvIjAmpw1Xhm81ng+wOxob4QtmlJfxzfdYGoRbFE1hriMoP/kuKOygP
	Th5GP4jah1jBwncUcO07gATqTLkdtsnWIV7TV7eV2Y67qpSsvoHi0mO0DH6UI=
X-Google-Smtp-Source: AGHT+IHKYNW+lzSgEoR/ftLOyWk4dENf+z842xkhdFHWXcXQluEhrxtoUMASXE6ncX8JmfeiyZU3fg==
X-Received: by 2002:a17:90b:3dc4:b0:332:8133:b377 with SMTP id 98e67ed59e1d1-33bcf87f8c3mr4875586a91.15.1760721064328;
        Fri, 17 Oct 2025 10:11:04 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5ca9:a8d0:7547:32c6])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-33bb65222a6sm6105739a91.4.2025.10.17.10.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 10:11:03 -0700 (PDT)
Date: Fri, 17 Oct 2025 10:11:01 -0700
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Prevent runtime suspend before devices are fully
 initialized
Message-ID: <aPJ4pZFENCTx9yhy@google.com>
References: <20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
 <CAJZ5v0iFa3_UFkA920Ogn0YAYLq4CjnAD_VjLsmxQxrfm5HEBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iFa3_UFkA920Ogn0YAYLq4CjnAD_VjLsmxQxrfm5HEBw@mail.gmail.com>

Hi Rafael,

On Fri, Oct 17, 2025 at 11:45:14AM +0200, Rafael J. Wysocki wrote:
> On Fri, Oct 17, 2025 at 1:28 AM Brian Norris <briannorris@chromium.org> wrote:
> >
> > PCI devices are created via pci_scan_slot() and similar, and are
> > promptly configured for runtime PM (pci_pm_init()). They are initially
> > prevented from suspending by way of pm_runtime_forbid(); however, it's
> > expected that user space may override this via sysfs [1].
> >
> > Now, sometime after initial scan, a PCI device receives its BAR
> > configuration (pci_assign_unassigned_bus_resources(), etc.).
> >
> > If a PCI device is allowed to suspend between pci_scan_slot() and
> > pci_assign_unassigned_bus_resources(), then pci-driver.c will
> > save/restore incorrect BAR configuration for the device, and the device
> > may cease to function.
> >
> > This behavior races with user space, since user space may enable runtime
> > PM [1] as soon as it sees the device, which may be before BAR
> > configuration.
> >
> > Prevent suspending in this intermediate state by holding a runtime PM
> > reference until the device is fully initialized and ready for probe().
> >
> > [1] echo auto > /sys/bus/pci/devices/.../power/control
> >
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> >
> >  drivers/pci/bus.c | 7 +++++++
> >  drivers/pci/pci.c | 6 ++++++
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index f26aec6ff588..227a8898acac 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/of.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/proc_fs.h>
> >  #include <linux/slab.h>
> >
> > @@ -375,6 +376,12 @@ void pci_bus_add_device(struct pci_dev *dev)
> >                 put_device(&pdev->dev);
> >         }
> >
> > +       /*
> > +        * Now that resources are assigned, drop the reference we grabbed in
> > +        * pci_pm_init().
> > +        */
> > +       pm_runtime_put_noidle(&dev->dev);
> > +
> >         if (!dn || of_device_is_available(dn))
> >                 pci_dev_allow_binding(dev);
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index b14dd064006c..06a901214f2c 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3226,6 +3226,12 @@ void pci_pm_init(struct pci_dev *dev)
> >         pci_pm_power_up_and_verify_state(dev);
> >         pm_runtime_forbid(&dev->dev);
> >         pm_runtime_set_active(&dev->dev);
> > +       /*
> > +        * We cannot allow a device to suspend before its resources are
> > +        * configured. Otherwise, we may allow saving/restoring unexpected BAR
> > +        * configuration.
> > +        */
> > +       pm_runtime_get_noresume(&dev->dev);
> >         pm_runtime_enable(&dev->dev);
> 
> So runtime PM should not be enabled here, should it?

Hmm, I suppose not. Does that imply it would be a better solution to
simply defer pm_runtime_enable() to pci_bus_add_device() or some similar
point? I'll give that a shot, since that seems like a simpler and
cleaner solution.

Thanks,
Brian

> >  }
> >
> > --

