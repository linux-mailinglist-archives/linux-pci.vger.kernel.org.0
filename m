Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82B5309108
	for <lists+linux-pci@lfdr.de>; Sat, 30 Jan 2021 01:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbhA3Afb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Jan 2021 19:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232863AbhA3AcG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jan 2021 19:32:06 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7469FC061574
        for <linux-pci@vger.kernel.org>; Fri, 29 Jan 2021 16:31:18 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ke15so15404903ejc.12
        for <linux-pci@vger.kernel.org>; Fri, 29 Jan 2021 16:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IHqwNfHmdWEcZfyYPR4+sBaYZ3Bn6Age7W/ZhgBDEQU=;
        b=NB6BRSIj0GzX1o6kI9lGeXRyRJGr6RAcJQ+EhSWJ0BC3oc/SvPN8mDWEfixyZfopvl
         BANLs4tolXi9xalwI4vJzTF5OSuXUJsridXoHgYjPKbJiQKeVk5vaBH6mcLY0H4BZRiq
         wfaYlKezDkRFMIrzC/4N3H4PPq5oJdHXV6Q01Q/n5KcCs6Ew+/ZecSW/Ta6Irop56k7U
         Z/DLPpfhWC0iKLTezq/K3cXp9ZKO27xjK0zn3Bqqqi6Zq8pzsnpj7my50SQHQOHfdaJ2
         MbkYoSMosvq8kWvBha1+L8Yc6pwMpH0ki+Tt+yxj6akZwZ5ZXx0qjp88CJKo9ExxxZaR
         IoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IHqwNfHmdWEcZfyYPR4+sBaYZ3Bn6Age7W/ZhgBDEQU=;
        b=EcBnkbOJe2QCtHAU2IpASvO/NiWzvvuj427/4w64A9YiunDTD4JjESolv0WvR227pO
         roHJjh7VCCLQEk21A6konONC/lvnv2OsZvYEuYEQvNmUuEJ5lyuASLkNeLKzAO73zb42
         n5a8vPpaSfMZCfexYKPpi7m9FyzZy6r5gmbbx6OcPJvdfCOA/2IAtzq1TLCM0BIr6Dph
         eC5AASxr8MZm7WAsPW0mP0WVd9mLpgHCTnxnGvnlAXDqWW3we+p0FEDO8+25t5fWcIVX
         7h2bfez3vwjENlHWRz+JGflwyxcqO1zDTo9krRL79STXEOA+n4dl7IOlmPWI19Pkaq8z
         pLtw==
X-Gm-Message-State: AOAM533B/TqTuVeUWjfknlBYvNiVmvn1yL6h5bHWdDyezCLnJZbHvUzi
        walp5gGg5QnQUGgxeovFxmu+NSbzC+9XAQUtMZfiBQ==
X-Google-Smtp-Source: ABdhPJxWORcLeJpILlCiBMkcM8hzzExkJ43LngkFSAc8o5W/IdsfFI1WUl5QRvX2O9IoWQ8K1Y0+8F2KdET67DExNU0=
X-Received: by 2002:a17:906:191b:: with SMTP id a27mr7103895eje.472.1611966677063;
 Fri, 29 Jan 2021 16:31:17 -0800 (PST)
MIME-Version: 1.0
References: <20210130002438.1872527-1-ben.widawsky@intel.com> <20210130002438.1872527-6-ben.widawsky@intel.com>
In-Reply-To: <20210130002438.1872527-6-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 29 Jan 2021 16:31:15 -0800
Message-ID: <CAPcyv4gZvxJxPQr3XwC3=yh8opkz5ThDjy4E-AWzL7ysFeC0Mg@mail.gmail.com>
Subject: Re: [PATCH 05/14] cxl/mem: Register CXL memX devices
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 29, 2021 at 4:25 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> From: Dan Williams <dan.j.williams@intel.com>
>
> Create the /sys/bus/cxl hierarchy to enumerate:
>
> * Memory Devices (per-endpoint control devices)
>
> * Memory Address Space Devices (platform address ranges with
>   interleaving, performance, and persistence attributes)
>
> * Memory Regions (active provisioned memory from an address space device
>   that is in use as System RAM or delegated to libnvdimm as Persistent
>   Memory regions).
>
> For now, only the per-endpoint control devices are registered on the
> 'cxl' bus. However, going forward it will provide a mechanism to
> coordinate cross-device interleave.
>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl       |  26 ++
>  .../driver-api/cxl/memory-devices.rst         |  17 +
>  drivers/base/core.c                           |  14 +
>  drivers/cxl/Makefile                          |   3 +
>  drivers/cxl/bus.c                             |  29 ++
>  drivers/cxl/cxl.h                             |   4 +
>  drivers/cxl/mem.c                             | 308 +++++++++++++++++-
>  include/linux/device.h                        |   1 +
>  8 files changed, 400 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-cxl
>  create mode 100644 drivers/cxl/bus.c
[..]
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 25e08e5f40bd..33432a4cbe23 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3179,6 +3179,20 @@ struct device *get_device(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(get_device);
>
> +/**
> + * get_live_device() - increment reference count for device iff !dead
> + * @dev: device.
> + *
> + * Forward the call to get_device() if the device is still alive. If
> + * this is called with the device_lock() held then the device is
> + * guaranteed to not die until the device_lock() is dropped.
> + */
> +struct device *get_live_device(struct device *dev)
> +{
> +       return dev && !dev->p->dead ? get_device(dev) : NULL;
> +}
> +EXPORT_SYMBOL_GPL(get_live_device);

Disregard this hunk, it's an abandoned idea that I failed to cleanup.
