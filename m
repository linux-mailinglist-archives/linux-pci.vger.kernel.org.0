Return-Path: <linux-pci+bounces-39193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42003C030AC
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 20:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0773AE48F
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 18:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189B5286D5D;
	Thu, 23 Oct 2025 18:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gGtEsFMJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD6E283FEE
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244969; cv=none; b=UPfo6UTEsap7xlU0fZER3XTyGL0dun08jIWmATng+JIUoRmZIz4+hCVr36VaAYyp8X7JaqUEoT4yMFqlpiJCkmkfO6dZT99lRyjrYlf+XUySgfWC+ExtCze25+VY/3IunrwQcywT/FdPTzM0F+uPkLFjj+F4U85/FJOZDF1DIiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244969; c=relaxed/simple;
	bh=FtRe/PAeraZj6Yx8Dco8ZPr7yuYAhSzUICWuWmg2yt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPTYy7+ZpMC/vAqjhZTqT0dy3l90io6QMlpeJtfO6+gq2OUjloXqLVN1p+eVLLPZKmHhU8hknG9iXawv9mVVvamsSCcyL3RbgFws1iac94bt5DgFt3MtcwrjInEY8ffztfhkk5i9BXmqEUot1mqcTZtRvWNg0pEhFHYEIPPeCJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gGtEsFMJ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a26dab3a97so721418b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 11:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761244966; x=1761849766; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=umGKUUj9+JIlqDNhv0CSVmxu6ROAp6h4ih4o4n/6F8Y=;
        b=gGtEsFMJtoZLVarNaFaiqheT433m7uePy48ykCaIwAkzGp8rSdkheujR8K8/wizzU9
         u8Fh9Hn+OOCLWqPiRRVmysEZv5MCbs8Uw4N1CxOUqsIlOP17Qdgifkvhe4pGnplZt3Sc
         lhAHEepfcESLzoDSmxpQ9OEyCt+kKxdNb6KVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244966; x=1761849766;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=umGKUUj9+JIlqDNhv0CSVmxu6ROAp6h4ih4o4n/6F8Y=;
        b=qqwUecusJ6nvR/BmHZHMp9KoIBSKUDqSQBT7yZOe/mVWv1cQInXstNyTAHkgyqPc2D
         qY5MV4yBSufn/0MINRmRxpkRRSy/B/lKCb03trBtIbrWGz+37LwhmFqkxnVulmexjFMR
         vxbciZg7X8eNEi+LtiTkgzSqkjg6g7MPplH0hkxS6ww9Wc0Hxv7vlXXUKk8wigu304Mt
         rpxlk9kGWFTB+fWD+Rnshnz/Nhkn89o0jEcC7cOc2/CFDBQDkA5zv5dbwycoQ0doU5DE
         XVnGqa4q45gXZKdMsgi5Th1lOrN2S8MU+aa0qrVCCsjULC1h0qITAsTrVKw6LCv2DLpj
         hkog==
X-Forwarded-Encrypted: i=1; AJvYcCXohLvKBXy9h6NQ8KYT2Xe3J/PQZnbLCR7FdZU5uYNJeKQAKS6IeBNGdlp/XkLrImRwEQdWZgQAWYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTdxxbDtfw+b7+L9Z180APbBpnnCIi4QbQIEgrIlueJhVSZtdb
	6PpGTMzM6Ea+dLDvV4HboM3nkMHdQayIH/oh+YYO149X5F02jgaw/tgT8TkNYTRt+w==
X-Gm-Gg: ASbGnct+fpVUBE4dbaTIGsyt4szh7nrU6q3z/RXDr3vPmdgTx7uhCSktUOZUzSQnCHQ
	lgPuqG3RyHGe6m5Rk2Mdau2JUiwj1tIsqXzmV2KUclDsxtdKROkcwvpxL6akNTZt8JI4HDKwiP+
	oD0E3VTkXbSMSrjtwORAkHZe9qex+ywFesXzFk3WFQql3xOwfPrrJ+3eLoFluSCaqBr6zk5AC80
	/6GIh9dLqBs/vufmDpoFaP9JXdz5X7vmSH4mZmjWxwLegIUUaAJrIrVWfQddZxOWbrfv8Ps6pXq
	rSJAX8GzJYUZ3PcbpaC6+gF5PDNcBqu4ALUclavB22RCFdD1wrt7Rf5dy2jYNl4wdWmBLYw+iwi
	eX4Cuhf61R9qoOh0WP0Sjoep8cMqU8IUk5fp6IeCRThRKNscP3q3lmg1CirU9Teairq10zGAZC2
	IeZutoZ/KJhujX1rZhUBuvX+WfK7HLaP8Qidl2XJ3bGH6U5zyA
X-Google-Smtp-Source: AGHT+IGilDapKBAAPejUjx2X2LtoivP4gPWmynkRRk8nvmFfLFEVrwJLhCugtg1paSqng3MeqQebMA==
X-Received: by 2002:a05:6a00:a15:b0:7a2:7964:64c0 with SMTP id d2e1a72fcca58-7a27964678amr3665701b3a.12.1761244966229;
        Thu, 23 Oct 2025 11:42:46 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:839c:d3ee:bea4:1b90])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7a274a62277sm3306924b3a.8.2025.10.23.11.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 11:42:45 -0700 (PDT)
Date: Thu, 23 Oct 2025 11:42:44 -0700
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3] PCI/PM: Prevent runtime suspend before devices are
 fully initialized
Message-ID: <aPp3JLWtqFMjZheY@google.com>
References: <20251022141434.v3.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
 <CAJZ5v0ieBdfuu_OF5YQsgsgy_L3H-UkVvn+kk45UFDfJSBtj0g@mail.gmail.com>
 <aPp1UWdc2rmafZr-@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPp1UWdc2rmafZr-@google.com>

Hi again,

On Thu, Oct 23, 2025 at 11:34:57AM -0700, Brian Norris wrote:
> On Thu, Oct 23, 2025 at 11:41:38AM +0200, Rafael J. Wysocki wrote:
> > On Wed, Oct 22, 2025 at 11:15 PM Brian Norris <briannorris@chromium.org> wrote:
> > >
> > > Today, it's possible for a PCI device to be created and
> > > runtime-suspended before it is fully initialized. When that happens, the
> > > device will remain in D0, but the suspend process may save an
> > > intermediate version of that device's state -- for example, without
> > > appropriate BAR configuration. When the device later resumes, we'll
> > > restore invalid PCI state and the device may not function.
> > >
> > > Prevent runtime suspend for PCI devices by deferring pm_runtime_enable()
> > > until we've fully initialized the device.
> > >
> > > More details on how exactly this may occur:
> > >
> > > 1. PCI device is created by pci_scan_slot() or similar
> > > 2. As part of pci_scan_slot(), pci_pm_init() enables runtime PM; the
> > >    device starts "active" and we initially prevent (pm_runtime_forbid())
> > >    suspend -- but see [*] footnote
> > > 3. Underlying 'struct device' is added to the system (device_add());
> > >    runtime PM can now be configured by user space
> > > 4. PCI device receives BAR configuration
> > >    (pci_assign_unassigned_bus_resources(), etc.)
> > > 5. PCI device is added to the system in pci_bus_add_device()
> > >
> > > The device may potentially suspend between #3 and #4.
> > >
> > > [*] By default, pm_runtime_forbid() prevents suspending a device; but by
> > > design [**], this can be overridden by user space policy via
> > >
> > >   echo auto > /sys/bus/pci/devices/.../power/control
> > >
> > > Thus, the above #3/#4 sequence is racy with user space (udev or
> > > similar).
> > >
> > > Notably, many PCI devices are enumerated at subsys_initcall time and so
> > > will not race with user space. However, there are several scenarios
> > > where PCI devices are created later on, such as with hotplug or when
> > > drivers (pwrctrl or controller drivers) are built as modules.
> > >
> > > [**] The relationship between pm_runtime_forbid(), pm_runtime_allow(),
> > > /sys/.../power/control, and the runtime PM usage counter can be subtle.
> > > It appears that the intention of pm_runtime_forbid() /
> > > pm_runtime_allow() is twofold:
> > >
> > > 1. Allow the user to disable runtime_pm (force device to always be
> > >    powered on) through sysfs.
> > > 2. Allow the driver to start with runtime_pm disabled (device forced
> > >    on) and user space could later enable runtime_pm.
> > >
> > > This conclusion comes from reading `Documentation/power/runtime_pm.rst`,
> > > specifically the section starting "The user space can effectively
> > > disallow".
> > >
> > > This means that while pm_runtime_forbid() does technically increase the
> > > runtime PM usage counter, this usage counter is not a guarantee of
> > > functional correctness, because sysfs can decrease that count again.
> > >
> > > Link: https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/
> > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > Cc: <stable@vger.kernel.org>
> > > Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> > > ---
> > >
> > > Changes in v3:
> > >  * Add Link to initial discussion
> > >  * Add Rafael's Reviewed-by
> > >  * Add lengthier footnotes about forbid vs allow vs sysfs
> > >
> > > Changes in v2:
> > >  * Update CC list
> > >  * Rework problem description
> > >  * Update solution: defer pm_runtime_enable(), instead of trying to
> > >    get()/put()
> > >
> > >  drivers/pci/bus.c | 3 +++
> > >  drivers/pci/pci.c | 1 -
> > >  2 files changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > > index f26aec6ff588..fc66b6cb3a54 100644
> > > --- a/drivers/pci/bus.c
> > > +++ b/drivers/pci/bus.c
> > > @@ -14,6 +14,7 @@
> > >  #include <linux/of.h>
> > >  #include <linux/of_platform.h>
> > >  #include <linux/platform_device.h>
> > > +#include <linux/pm_runtime.h>
> > >  #include <linux/proc_fs.h>
> > >  #include <linux/slab.h>
> > >
> > > @@ -375,6 +376,8 @@ void pci_bus_add_device(struct pci_dev *dev)
> > >                 put_device(&pdev->dev);
> > >         }
> > >
> > > +       pm_runtime_enable(&dev->dev);
> > > +
> > >         if (!dn || of_device_is_available(dn))
> > >                 pci_dev_allow_binding(dev);
> > >
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index b14dd064006c..f792164fa297 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -3226,7 +3226,6 @@ void pci_pm_init(struct pci_dev *dev)
> > >         pci_pm_power_up_and_verify_state(dev);
> > >         pm_runtime_forbid(&dev->dev);
> > >         pm_runtime_set_active(&dev->dev);
> > 
> > Actually, I think that the two statements above can be moved too.
> > 
> > The pm_runtime_forbid() call doesn't matter until runtime PM is
> > enabled and it is better to do pm_runtime_set_active() right before
> > enabling runtime PM.
> 
> Ehh, sure, I can do that I suppose. That signs me up for fixing some
> excessive Documentation/ that spells out exactly what goes on in
> pci_pm_init() for some reason, but I can do that too :)

Hmm, never mind, I think I agreed with you too soon.

It should be ok to move pm_runtime_set_active(), but I believe moving
pm_runtime_forbid() would introduce a similar race condition problem to
the bug I'm resolving -- pci_bus_add_device() is run after device_add(),
and so user space might already see the device and try to configure
power/control. If we forbid() after that point, user space would be
confused.

Documentation/power/runtime_pm.rst even calls this out:

  "It should be noted, however, that if the user space has already
  intentionally changed the value of /sys/devices/.../power/control to
  "auto" to allow the driver to power manage the device at run time, the
  driver may confuse it by using pm_runtime_forbid() this way."

So I'd rather not make this change.

Brian

> > > -       pm_runtime_enable(&dev->dev);
> > >  }
> > >
> > >  static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
> > > --
> 

