Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB2214B9B6
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 15:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfFSNU6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 09:20:58 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43639 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfFSNU6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jun 2019 09:20:58 -0400
Received: by mail-oi1-f196.google.com with SMTP id w79so10516840oif.10;
        Wed, 19 Jun 2019 06:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/sbjtq/dDS1OQiER3+MGrQ7JVDrD9M4EcoflQzWHOLs=;
        b=DtP4syrrH8NUgSIYRmsATbunUxolJUYn1d55VbLwQFGXK3ZPFJZDt5bzW3UNAr3vbS
         UVN6GEBdtlnpZxxLZWrcdGlaCOZnZQl0VvUOOutFvsXCjZBLVtLC0lWS+Dfh/Hlyzyct
         zy3eZ35pijr5QPxwNO8iBA3/CDmSVg6cCUg+rXWDzbTcqYowShYzuSPfpDNmAqpW0xGY
         5KnRhSOKSesS+srEYGiFE+9fJWsKgJR0XvwdKhwx7RoQFVpRmG6zleLGA5mgDuBiIWBG
         lemqiQMnhrO8226O9eslVIAt2SQ9WTqXfolsY8c2JLEZpwKNbVI4AP0JV5ydAAsQCZ7n
         BK8Q==
X-Gm-Message-State: APjAAAX/CtQYRh5+V9NkqIhNTPrD3/xuAH+I5U6bF1adYi+UYzaOmq8K
        7sVvzCredy1gpOCd6ZhLSyqAc6s/w7EJhtVNacQ=
X-Google-Smtp-Source: APXvYqzbF/UeO5hojPg8oTn1PzeWovI2nk2mZpqLvsWARoFt/2NgNMTO76UwAw3tqLwjeFcyXs6HIXUF7IcSeMhPFbw=
X-Received: by 2002:aca:4e89:: with SMTP id c131mr2788597oib.57.1560950457106;
 Wed, 19 Jun 2019 06:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190618161858.77834-1-mika.westerberg@linux.intel.com> <20190618161858.77834-3-mika.westerberg@linux.intel.com>
In-Reply-To: <20190618161858.77834-3-mika.westerberg@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Jun 2019 15:20:45 +0200
Message-ID: <CAJZ5v0jaNpgW2=QfTVYcY=2MzTCaxNNSsVT667Lwz8HxvJT8mQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ACPI / PM: Introduce concept of a _PR0 dependent device
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 18, 2019 at 6:19 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> If there are shared power resources between otherwise unrelated devices
> turning them on causes the other devices sharing them to be powered up
> as well. In case of PCI devices go into D0uninitialized state meaning
> that if they were configured to trigger wake that configuration is lost
> at this point.
>
> For this reason introduce a concept of "_PR0 dependent device" that can
> be added to any ACPI device that has power resources. The dependent
> device will be included in a list of dependent devices for all power
> resources returned by the ACPI device's _PR0 (assuming it has one).
> Whenever a power resource having dependent devices is turned physically
> on (its _ON method is called) we runtime resume all of them to allow
> their driver or in case of PCI the PCI core to re-initialize the device
> and its wake configuration.
>
> This adds two functions that can be used to add and remove these
> dependent devices. Note the dependent device does not necessary need
> share power resources so this functionality can be used to add "software
> dependencies" as well if needed.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/acpi/power.c    | 139 ++++++++++++++++++++++++++++++++++++++++
>  include/acpi/acpi_bus.h |   4 ++
>  2 files changed, 143 insertions(+)
>
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index a916417b9e70..76d298192940 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -42,6 +42,11 @@ ACPI_MODULE_NAME("power");
>  #define ACPI_POWER_RESOURCE_STATE_ON   0x01
>  #define ACPI_POWER_RESOURCE_STATE_UNKNOWN 0xFF
>
> +struct acpi_power_dependent_device {
> +       struct device *dev;
> +       struct list_head node;
> +};
> +
>  struct acpi_power_resource {
>         struct acpi_device device;
>         struct list_head list_node;
> @@ -51,6 +56,7 @@ struct acpi_power_resource {
>         unsigned int ref_count;
>         bool wakeup_enabled;
>         struct mutex resource_lock;
> +       struct list_head dependents;
>  };
>
>  struct acpi_power_resource_entry {
> @@ -232,8 +238,125 @@ static int acpi_power_get_list_state(struct list_head *list, int *state)
>         return 0;
>  }
>
> +static int
> +acpi_power_resource_add_dependent(struct acpi_power_resource *resource,
> +                                 struct device *dev)
> +{
> +       struct acpi_power_dependent_device *dep;
> +       int ret = 0;
> +
> +       mutex_lock(&resource->resource_lock);
> +       list_for_each_entry(dep, &resource->dependents, node) {
> +               /* Only add it once */
> +               if (dep->dev == dev)
> +                       goto unlock;
> +       }
> +
> +       dep = kzalloc(sizeof(*dep), GFP_KERNEL);
> +       if (!dep) {
> +               ret = -ENOMEM;
> +               goto unlock;
> +       }
> +
> +       dep->dev = dev;
> +       list_add_tail(&dep->node, &resource->dependents);
> +       dev_dbg(dev, "added power dependency to [%s]\n", resource->name);
> +
> +unlock:
> +       mutex_unlock(&resource->resource_lock);
> +       return ret;
> +}
> +
> +static void
> +acpi_power_resource_remove_dependent(struct acpi_power_resource *resource,
> +                                    struct device *dev)
> +{
> +       struct acpi_power_dependent_device *dep;
> +
> +       mutex_lock(&resource->resource_lock);
> +       list_for_each_entry(dep, &resource->dependents, node) {
> +               if (dep->dev == dev) {
> +                       list_del(&dep->node);
> +                       kfree(dep);
> +                       dev_dbg(dev, "removed power dependency to [%s]\n",
> +                               resource->name);
> +                       break;
> +               }
> +       }
> +       mutex_unlock(&resource->resource_lock);
> +}
> +
> +/**
> + * acpi_device_power_add_dependent - Add dependent device of this ACPI device
> + * @adev: ACPI device pointer
> + * @dev: Dependent device
> + *
> + * If @adev has non-empty _PR0 the @dev is added as dependent device to all
> + * power resources returned by it. This means that whenever these power
> + * resources are turned _ON the dependent devices get runtime resumed. This
> + * is needed for devices such as PCI to allow its driver to re-initialize
> + * it after it went to D0uninitialized.
> + *
> + * If @adev does not have _PR0 this does nothing.
> + *
> + * Returns %0 in case of success and negative errno otherwise.
> + */
> +int acpi_device_power_add_dependent(struct acpi_device *adev,
> +                                   struct device *dev)
> +{
> +       struct acpi_power_resource_entry *entry;
> +       struct list_head *resources;
> +       int ret;
> +
> +       if (!adev->power.flags.power_resources)
> +               return 0;
> +       if (!adev->power.states[ACPI_STATE_D0].flags.valid)
> +               return 0;

The two checks above can be replaced with an
adev->flags.power_manageable one AFAICS (the "valid" flag is always
set for D0 and the list below will be empty if there are no power
resources).

Same for acpi_device_power_remove_dependent(), of course.

Apart from this LGTM.
