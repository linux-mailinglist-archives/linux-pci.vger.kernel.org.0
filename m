Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D74C1438FB
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 17:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfFMPKd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 11:10:33 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36308 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732310AbfFMNvw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jun 2019 09:51:52 -0400
Received: by mail-oi1-f196.google.com with SMTP id w7so14470953oic.3;
        Thu, 13 Jun 2019 06:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dc/dKuduhOVwVhoCg8l9KHuJjqQCw6oo+xmTEqCWIlI=;
        b=f0IIZ8SVfk2sLpN/4yMqdqPq7g3lNnCUDF8bcHuwA5LFnlq1Oq0fJu3z5HL2/yGLBs
         1GdK8RsgNGQC6ne/ZJaJyKuUF3ybBwHbugjfPBEYBRPHVC2KrQeTL3/39nwzEqiZhtcs
         a23WiouEwHHA0RXvOmexz3m7ry4WKu+DVKnq9eGYwO/+CkLDMbruC6prvty405jKl6/r
         tGZJMO9CHsKn8aOcvClsAAEGyVePKiVw+Jqt8jgR/8UmIAy2uLPV9/V136CV6TN0CiKQ
         EBfekg9eK9/lFFbSKs4TEVYp/tAC3NvBBgkFWGNMrtogxLe5Opt/SMjBL7ZyQji491qz
         wqBA==
X-Gm-Message-State: APjAAAXgSlKUbkOemLsNZb4veNrOccldr7W0KW7M7GPme7QuUbrpWe2R
        3a8wFSz/L0tvtEA7y9OvIEuliMSYHy8h8jV3POM=
X-Google-Smtp-Source: APXvYqyGgVRKq8u/s3LivLC8HWFgdJtAYjO9zAbTqXZIDpN8FlhqtPaMdmwkaovj/0wXTIzo6XSFEGcjGn55obVvr70=
X-Received: by 2002:aca:3256:: with SMTP id y83mr3202950oiy.110.1560433911456;
 Thu, 13 Jun 2019 06:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190605145820.37169-1-mika.westerberg@linux.intel.com>
 <CAJZ5v0gwqMd0W43KQoU80=fdYooLkgPg1n0cbbAWjPqrOepYsg@mail.gmail.com>
 <20190606143606.GN2781@lahna.fi.intel.com> <26924432.Xal58bVLXT@kreacher> <20190613125252.GL2640@lahna.fi.intel.com>
In-Reply-To: <20190613125252.GL2640@lahna.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Jun 2019 15:51:40 +0200
Message-ID: <CAJZ5v0iTEch9DmPOV7uE_ZDGK__GDGO5wSPHNrodkPP+i5sp_g@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI / ACPI: Handle sibling devices sharing power resources
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Thu, Jun 13, 2019 at 2:52 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Thu, Jun 13, 2019 at 12:38:50AM +0200, Rafael J. Wysocki wrote:
> > Basically, at the pci_acpi_setup() time dev and adev need to be passed to a function that
> > will add dev as a "dependent device" for each of the power resources in the adev's D0
> > list.
> >
> > Next whenever a power resource with a list of "dependent devices" goes _ON successfully,
> > pm_request_resume() needs to be called for each device in that list.
> >
> > Finally, at the pci_acpi_cleanup() time, dev needs to be removed from the lists of
> > "dependent devices" for all power resources in its ACPI companion's D0 list.
> >
> > At least that's how I see that.
>
> Thanks for the suggestion. This seems to make it work only for PCI
> devices, though. Is that the intention?

I'm not sure to what extent the D0-uninitialized concept applies to
non-PCI devices.  It may just not be necessary to do this for non-PCI
device in general.

> I went for the all ACPI devices path instead where we add all devices
> sharing the power resource as "consumers" for that resource. I haven't
> fully tested the approach yet but the draft patch is below. I have no
> issues doing what you say above, though :)
>
> ----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----
>
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index f6157d4d637a..e840299c3293 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -127,10 +127,10 @@ int __acpi_device_uevent_modalias(struct acpi_device *adev,
>                                    Power Resource
>     -------------------------------------------------------------------------- */
>  int acpi_power_init(void);
> -void acpi_power_resources_list_free(struct list_head *list);
> -int acpi_extract_power_resources(union acpi_object *package, unsigned int start,
> -                                struct list_head *list);
> -int acpi_add_power_resource(acpi_handle handle);
> +void acpi_power_resources_list_free(struct acpi_device *device, struct list_head *list);
> +int acpi_extract_power_resources(struct acpi_device *device,
> +       union acpi_object *package, unsigned int start, struct list_head *list);
> +int acpi_add_power_resource(struct acpi_device *adev, acpi_handle handle);
>  void acpi_power_add_remove_device(struct acpi_device *adev, bool add);
>  int acpi_power_wakeup_list_init(struct list_head *list, int *system_level);
>  int acpi_device_sleep_wake(struct acpi_device *dev,
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index a916417b9e70..31817f931381 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -45,6 +45,8 @@ ACPI_MODULE_NAME("power");
>  struct acpi_power_resource {
>         struct acpi_device device;
>         struct list_head list_node;
> +       struct list_head consumers;
> +       struct mutex consumer_lock;

Why do you need this extra lock?

>         char *name;
>         u32 system_level;
>         u32 order;
> @@ -58,6 +60,11 @@ struct acpi_power_resource_entry {
>         struct acpi_power_resource *resource;
>  };
>
> +struct acpi_power_resource_consumer {
> +       struct list_head node;
> +       struct acpi_device *consumer;

I would put the "physical" device pointer here.

> +};
> +
>  static LIST_HEAD(acpi_power_resource_list);
>  static DEFINE_MUTEX(power_resource_list_lock);
>
> @@ -81,6 +88,111 @@ static struct acpi_power_resource *acpi_power_get_context(acpi_handle handle)
>         return to_power_resource(device);
>  }
>
> +static int acpi_power_add_consumer(struct acpi_power_resource *resource,
> +                                  struct acpi_device *device)
> +{
> +       struct acpi_power_resource_consumer *consumer;
> +       int ret = 0;
> +
> +       if (!device)
> +               return 0;
> +
> +       mutex_lock(&resource->consumer_lock);

All of this could be done under the resource mutex instead, I think.

> +
> +       list_for_each_entry(consumer, &resource->consumers, node) {
> +               /* Don't add it twice */
> +               if (consumer->consumer == device)
> +                       goto unlock;
> +       }
> +
> +       consumer = kzalloc(sizeof(*consumer), GFP_KERNEL);
> +       if (!consumer) {
> +               ret = -ENOMEM;
> +               goto unlock;
> +       }
> +
> +       consumer->consumer = device;
> +       list_add_tail(&consumer->node, &resource->consumers);
> +
> +       acpi_handle_debug(device->handle, "added dependency to %s\n",
> +                         resource->name);
> +
> +unlock:
> +       mutex_unlock(&resource->consumer_lock);
> +       return ret;
> +}
> +
> +static void acpi_power_remove_consumer(struct acpi_power_resource *resource,
> +                                      struct acpi_device *device)
> +{
> +       struct acpi_power_resource_consumer *consumer;
> +
> +       mutex_lock(&resource->consumer_lock);
> +       list_for_each_entry(consumer, &resource->consumers, node) {
> +               if (consumer->consumer == device) {
> +                       list_del(&consumer->node);
> +                       kfree(consumer);
> +
> +                       acpi_handle_debug(device->handle,
> +                                         "removed dependency to %s\n",
> +                                         resource->name);
> +                       break;
> +               }
> +       }
> +       mutex_unlock(&resource->consumer_lock);
> +}
> +
> +static void
> +acpi_power_resume_consumer(const struct acpi_power_resource *resource,
> +                         struct acpi_device *device)
> +{
> +       struct device *dev;
> +
> +       /*
> +        * If the device is prepared to wake we need to resume it now so
> +        * that the driver can re-program it to do so. For non-wake devices
> +        * we can leave them as is. The driver then restores the device
> +        * when it is needed next time.
> +        */
> +       if (!acpi_device_can_wakeup(device) || !device->wakeup.prepare_count)
> +               return;

Checking prepare_count should not be necessary here.

Arguably, the power resource cannot go off without suspending all
devices that depend on it and for PM-runtime wakeup is always enabled.

> +
> +       dev = acpi_get_first_physical_node(device);

And that would be unnecessary if you stored dev in struct
acpi_power_resource_consumer.

> +       if (dev) {
> +               acpi_handle_debug(device->handle,
> +                                 "resuming %s because %s was turned on\n",
> +                                 dev_name(dev), resource->name);
> +               pm_runtime_resume(dev);

pm_request_resume()

This needs to be asynchronous as it should be done under resource_lock
(see below).

> +       }
> +}
> +
> +static int acpi_power_resume_consumers(struct acpi_power_resource *resource,
> +                                      struct acpi_device *device)
> +{
> +       struct acpi_power_resource_consumer *consumer;
> +       int ret = 0;
> +
> +       mutex_lock(&resource->consumer_lock);
> +
> +       list_for_each_entry(consumer, &resource->consumers, node) {
> +               struct acpi_device *adev = consumer->consumer;
> +               int state, ret;
> +
> +               /* Skip the device that originated the power on request */
> +               if (adev == device)
> +                       continue;
> +
> +               ret = acpi_power_get_inferred_state(consumer->consumer, &state);

This isn't necessary AFAICS.

The resource was off previously, so none of its consumers can be in D0.

> +               if (!ret && adev->power.state > ACPI_STATE_D0 &&
> +                   state == ACPI_STATE_D0) {
> +                       acpi_power_resume_consumer(resource, adev);
> +               }
> +       }
> +
> +       mutex_unlock(&resource->consumer_lock);
> +       return ret;
> +}
> +
>  static int acpi_power_resources_list_add(acpi_handle handle,
>                                          struct list_head *list)
>  {
> @@ -108,12 +220,14 @@ static int acpi_power_resources_list_add(acpi_handle handle,
>         return 0;
>  }
>
> -void acpi_power_resources_list_free(struct list_head *list)
> +void acpi_power_resources_list_free(struct acpi_device *device, struct list_head *list)
>  {
>         struct acpi_power_resource_entry *entry, *e;
>
>         list_for_each_entry_safe(entry, e, list, node) {
>                 list_del(&entry->node);
> +               if (device)
> +                       acpi_power_remove_consumer(entry->resource, device);
>                 kfree(entry);
>         }
>  }
> @@ -135,8 +249,8 @@ static bool acpi_power_resource_is_dup(union acpi_object *package,
>         return false;
>  }
>
> -int acpi_extract_power_resources(union acpi_object *package, unsigned int start,
> -                                struct list_head *list)
> +int acpi_extract_power_resources(struct acpi_device *device,
> +       union acpi_object *package, unsigned int start, struct list_head *list)
>  {
>         unsigned int i;
>         int err = 0;
> @@ -159,7 +273,7 @@ int acpi_extract_power_resources(union acpi_object *package, unsigned int start,
>                 if (acpi_power_resource_is_dup(package, start, i))
>                         continue;
>
> -               err = acpi_add_power_resource(rhandle);
> +               err = acpi_add_power_resource(device, rhandle);
>                 if (err)
>                         break;
>
> @@ -168,7 +282,7 @@ int acpi_extract_power_resources(union acpi_object *package, unsigned int start,
>                         break;
>         }
>         if (err)
> -               acpi_power_resources_list_free(list);
> +               acpi_power_resources_list_free(device, list);
>
>         return err;
>  }
> @@ -258,18 +372,33 @@ static int acpi_power_on_unlocked(struct acpi_power_resource *resource)
>                 result = __acpi_power_on(resource);
>                 if (result)
>                         resource->ref_count--;
> +               else
> +                       result = 1;
>         }
>         return result;
>  }
>
> -static int acpi_power_on(struct acpi_power_resource *resource)
> +static int acpi_power_on(struct acpi_device *device,
> +                        struct acpi_power_resource *resource)
>  {
>         int result;
>
>         mutex_lock(&resource->resource_lock);
>         result = acpi_power_on_unlocked(resource);
>         mutex_unlock(&resource->resource_lock);
> -       return result;
> +
> +       if (result <= 0)
> +               return result;
> +
> +       /*
> +        * The power resource was physically turned on. Because of this
> +        * some of the devices sharing it may have been transitioned into
> +        * D0 so we need to runtime resume them to make sure their driver
> +        * re-initializes them properly. This is important for PCI devices
> +        * that go into D0uninitialized and lose their wakeup settings
> +        * otherwise.

So you only talk about PCI devices here, which is why I think that, at
least for now, this needs to be done only for PCI devices.

> +        */
> +       return acpi_power_resume_consumers(resource, device);

Resuming consumers technically belongs to the "on" operation, so it
should be done under resource_lock (or there is nothing to prevent the
resource from going off immediately in a different thread in theory,
although that is unlikely due to the way device PM code works).

>  }
>
>  static int __acpi_power_off(struct acpi_power_resource *resource)
> @@ -319,7 +448,7 @@ static int acpi_power_off(struct acpi_power_resource *resource)
>         return result;
>  }
>
> -static int acpi_power_off_list(struct list_head *list)
> +static int acpi_power_off_list(struct acpi_device *device, struct list_head *list)
>  {
>         struct acpi_power_resource_entry *entry;
>         int result = 0;
> @@ -333,18 +462,18 @@ static int acpi_power_off_list(struct list_head *list)
>
>   err:
>         list_for_each_entry_continue(entry, list, node)
> -               acpi_power_on(entry->resource);
> +               acpi_power_on(device, entry->resource);
>
>         return result;
>  }
>
> -static int acpi_power_on_list(struct list_head *list)
> +static int acpi_power_on_list(struct acpi_device *device, struct list_head *list)
>  {
>         struct acpi_power_resource_entry *entry;
>         int result = 0;
>
>         list_for_each_entry(entry, list, node) {
> -               result = acpi_power_on(entry->resource);
> +               result = acpi_power_on(device, entry->resource);
>                 if (result)
>                         goto err;
>         }
> @@ -582,7 +711,7 @@ int acpi_enable_wakeup_device_power(struct acpi_device *dev, int sleep_state)
>
>                 if (!resource->wakeup_enabled) {
>                         err = acpi_power_on_unlocked(resource);
> -                       if (!err)
> +                       if (err >= 0)
>                                 resource->wakeup_enabled = true;
>                 }
>
> @@ -703,7 +832,7 @@ int acpi_power_on_resources(struct acpi_device *device, int state)
>         if (!device || state < ACPI_STATE_D0 || state > ACPI_STATE_D3_HOT)
>                 return -EINVAL;
>
> -       return acpi_power_on_list(&device->power.states[state].resources);
> +       return acpi_power_on_list(device, &device->power.states[state].resources);
>  }
>
>  int acpi_power_transition(struct acpi_device *device, int state)
> @@ -726,11 +855,11 @@ int acpi_power_transition(struct acpi_device *device, int state)
>          * we dereference all power resources used in the current list.
>          */
>         if (state < ACPI_STATE_D3_COLD)
> -               result = acpi_power_on_list(
> +               result = acpi_power_on_list(device,
>                         &device->power.states[state].resources);
>
>         if (!result && device->power.state < ACPI_STATE_D3_COLD)
> -               acpi_power_off_list(
> +               acpi_power_off_list(device,
>                         &device->power.states[device->power.state].resources);
>
>         /* We shouldn't change the state unless the above operations succeed. */
> @@ -788,7 +917,7 @@ static void acpi_power_add_resource_to_list(struct acpi_power_resource *resource
>         mutex_unlock(&power_resource_list_lock);
>  }
>
> -int acpi_add_power_resource(acpi_handle handle)
> +int acpi_add_power_resource(struct acpi_device *adev, acpi_handle handle)
>  {
>         struct acpi_power_resource *resource;
>         struct acpi_device *device = NULL;
> @@ -798,8 +927,10 @@ int acpi_add_power_resource(acpi_handle handle)
>         int state, result = -ENODEV;
>
>         acpi_bus_get_device(handle, &device);
> -       if (device)
> -               return 0;
> +       if (device) {
> +               resource = to_power_resource(device);
> +               goto add_consumer;
> +       }
>
>         resource = kzalloc(sizeof(*resource), GFP_KERNEL);
>         if (!resource)
> @@ -810,6 +941,8 @@ int acpi_add_power_resource(acpi_handle handle)
>                                 ACPI_STA_DEFAULT);
>         mutex_init(&resource->resource_lock);
>         INIT_LIST_HEAD(&resource->list_node);
> +       INIT_LIST_HEAD(&resource->consumers);
> +       mutex_init(&resource->consumer_lock);
>         resource->name = device->pnp.bus_id;
>         strcpy(acpi_device_name(device), ACPI_POWER_DEVICE_NAME);
>         strcpy(acpi_device_class(device), ACPI_POWER_CLASS);
> @@ -840,7 +973,11 @@ int acpi_add_power_resource(acpi_handle handle)
>
>         acpi_power_add_resource_to_list(resource);
>         acpi_device_add_finalize(device);
> -       return 0;
> +
> + add_consumer:

Note that this only needs to be done if the device's D0 list contains
the resource.

> +       result = acpi_power_add_consumer(resource, adev);
> +       if (!result)
> +               return 0;
>
>   err:
>         acpi_release_power_resource(&device->dev);
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 6153030451eb..3af0abe5b5e2 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -451,14 +451,14 @@ static void acpi_free_power_resources_lists(struct acpi_device *device)
>         int i;
>
>         if (device->wakeup.flags.valid)
> -               acpi_power_resources_list_free(&device->wakeup.resources);
> +               acpi_power_resources_list_free(NULL, &device->wakeup.resources);
>
>         if (!device->power.flags.power_resources)
>                 return;
>
>         for (i = ACPI_STATE_D0; i <= ACPI_STATE_D3_HOT; i++) {
>                 struct acpi_device_power_state *ps = &device->power.states[i];
> -               acpi_power_resources_list_free(&ps->resources);
> +               acpi_power_resources_list_free(device, &ps->resources);
>         }
>  }
>
> @@ -816,7 +816,7 @@ static int acpi_bus_extract_wakeup_device_power_package(struct acpi_device *dev)
>
>         wakeup->sleep_state = element->integer.value;
>
> -       err = acpi_extract_power_resources(package, 2, &wakeup->resources);
> +       err = acpi_extract_power_resources(NULL, package, 2, &wakeup->resources);
>         if (err)
>                 goto out;
>
> @@ -828,7 +828,7 @@ static int acpi_bus_extract_wakeup_device_power_package(struct acpi_device *dev)
>                 if (err) {
>                         acpi_handle_warn(handle, "Retrieving current states "
>                                          "of wakeup power resources failed\n");
> -                       acpi_power_resources_list_free(&wakeup->resources);
> +                       acpi_power_resources_list_free(NULL, &wakeup->resources);
>                         goto out;
>                 }
>                 if (sleep_state < wakeup->sleep_state) {
> @@ -920,7 +920,7 @@ static void acpi_bus_init_power_state(struct acpi_device *device, int state)
>                 if (buffer.length && package
>                     && package->type == ACPI_TYPE_PACKAGE
>                     && package->package.count) {
> -                       int err = acpi_extract_power_resources(package, 0,
> +                       int err = acpi_extract_power_resources(device, package, 0,
>                                                                &ps->resources);
>                         if (!err)
>                                 device->power.flags.power_resources = 1;
> @@ -1867,7 +1867,7 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, u32 lvl_not_used,
>                 return AE_OK;
>
>         if (type == ACPI_BUS_TYPE_POWER) {
> -               acpi_add_power_resource(handle);
> +               acpi_add_power_resource(NULL, handle);
>                 return AE_OK;
>         }
>
> --
> 2.20.1
>
