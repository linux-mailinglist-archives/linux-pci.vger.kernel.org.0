Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEFCF437F5
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 17:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732525AbfFMPC1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 11:02:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:30027 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732512AbfFMO1H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 10:27:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 07:27:05 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 13 Jun 2019 07:27:02 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 13 Jun 2019 17:27:02 +0300
Date:   Thu, 13 Jun 2019 17:27:01 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/3] PCI / ACPI: Handle sibling devices sharing power
 resources
Message-ID: <20190613142701.GQ2640@lahna.fi.intel.com>
References: <20190605145820.37169-1-mika.westerberg@linux.intel.com>
 <CAJZ5v0gwqMd0W43KQoU80=fdYooLkgPg1n0cbbAWjPqrOepYsg@mail.gmail.com>
 <20190606143606.GN2781@lahna.fi.intel.com>
 <26924432.Xal58bVLXT@kreacher>
 <20190613125252.GL2640@lahna.fi.intel.com>
 <CAJZ5v0iTEch9DmPOV7uE_ZDGK__GDGO5wSPHNrodkPP+i5sp_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iTEch9DmPOV7uE_ZDGK__GDGO5wSPHNrodkPP+i5sp_g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 03:51:40PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jun 13, 2019 at 2:52 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > On Thu, Jun 13, 2019 at 12:38:50AM +0200, Rafael J. Wysocki wrote:
> > > Basically, at the pci_acpi_setup() time dev and adev need to be passed to a function that
> > > will add dev as a "dependent device" for each of the power resources in the adev's D0
> > > list.
> > >
> > > Next whenever a power resource with a list of "dependent devices" goes _ON successfully,
> > > pm_request_resume() needs to be called for each device in that list.
> > >
> > > Finally, at the pci_acpi_cleanup() time, dev needs to be removed from the lists of
> > > "dependent devices" for all power resources in its ACPI companion's D0 list.
> > >
> > > At least that's how I see that.
> >
> > Thanks for the suggestion. This seems to make it work only for PCI
> > devices, though. Is that the intention?
> 
> I'm not sure to what extent the D0-uninitialized concept applies to
> non-PCI devices.  It may just not be necessary to do this for non-PCI
> device in general.

OK, sounds reasonable. We can extend it to apply for other types of
devices later if needed.

> > I went for the all ACPI devices path instead where we add all devices
> > sharing the power resource as "consumers" for that resource. I haven't
> > fully tested the approach yet but the draft patch is below. I have no
> > issues doing what you say above, though :)
> >
> > ----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----
> >
> > diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> > index f6157d4d637a..e840299c3293 100644
> > --- a/drivers/acpi/internal.h
> > +++ b/drivers/acpi/internal.h
> > @@ -127,10 +127,10 @@ int __acpi_device_uevent_modalias(struct acpi_device *adev,
> >                                    Power Resource
> >     -------------------------------------------------------------------------- */
> >  int acpi_power_init(void);
> > -void acpi_power_resources_list_free(struct list_head *list);
> > -int acpi_extract_power_resources(union acpi_object *package, unsigned int start,
> > -                                struct list_head *list);
> > -int acpi_add_power_resource(acpi_handle handle);
> > +void acpi_power_resources_list_free(struct acpi_device *device, struct list_head *list);
> > +int acpi_extract_power_resources(struct acpi_device *device,
> > +       union acpi_object *package, unsigned int start, struct list_head *list);
> > +int acpi_add_power_resource(struct acpi_device *adev, acpi_handle handle);
> >  void acpi_power_add_remove_device(struct acpi_device *adev, bool add);
> >  int acpi_power_wakeup_list_init(struct list_head *list, int *system_level);
> >  int acpi_device_sleep_wake(struct acpi_device *dev,
> > diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> > index a916417b9e70..31817f931381 100644
> > --- a/drivers/acpi/power.c
> > +++ b/drivers/acpi/power.c
> > @@ -45,6 +45,8 @@ ACPI_MODULE_NAME("power");
> >  struct acpi_power_resource {
> >         struct acpi_device device;
> >         struct list_head list_node;
> > +       struct list_head consumers;
> > +       struct mutex consumer_lock;
> 
> Why do you need this extra lock?

It is there because we call acpi_power_get_inferred_state() in the
notification path. However, as you point out below the call is not
needed so in that sense resource_lock should be enough.

> 
> >         char *name;
> >         u32 system_level;
> >         u32 order;
> > @@ -58,6 +60,11 @@ struct acpi_power_resource_entry {
> >         struct acpi_power_resource *resource;
> >  };
> >
> > +struct acpi_power_resource_consumer {
> > +       struct list_head node;
> > +       struct acpi_device *consumer;
> 
> I would put the "physical" device pointer here.

OK

> > +};
> > +
> >  static LIST_HEAD(acpi_power_resource_list);
> >  static DEFINE_MUTEX(power_resource_list_lock);
> >
> > @@ -81,6 +88,111 @@ static struct acpi_power_resource *acpi_power_get_context(acpi_handle handle)
> >         return to_power_resource(device);
> >  }
> >
> > +static int acpi_power_add_consumer(struct acpi_power_resource *resource,
> > +                                  struct acpi_device *device)
> > +{
> > +       struct acpi_power_resource_consumer *consumer;
> > +       int ret = 0;
> > +
> > +       if (!device)
> > +               return 0;
> > +
> > +       mutex_lock(&resource->consumer_lock);
> 
> All of this could be done under the resource mutex instead, I think.

Yup

> > +
> > +       list_for_each_entry(consumer, &resource->consumers, node) {
> > +               /* Don't add it twice */
> > +               if (consumer->consumer == device)
> > +                       goto unlock;
> > +       }
> > +
> > +       consumer = kzalloc(sizeof(*consumer), GFP_KERNEL);
> > +       if (!consumer) {
> > +               ret = -ENOMEM;
> > +               goto unlock;
> > +       }
> > +
> > +       consumer->consumer = device;
> > +       list_add_tail(&consumer->node, &resource->consumers);
> > +
> > +       acpi_handle_debug(device->handle, "added dependency to %s\n",
> > +                         resource->name);
> > +
> > +unlock:
> > +       mutex_unlock(&resource->consumer_lock);
> > +       return ret;
> > +}
> > +
> > +static void acpi_power_remove_consumer(struct acpi_power_resource *resource,
> > +                                      struct acpi_device *device)
> > +{
> > +       struct acpi_power_resource_consumer *consumer;
> > +
> > +       mutex_lock(&resource->consumer_lock);
> > +       list_for_each_entry(consumer, &resource->consumers, node) {
> > +               if (consumer->consumer == device) {
> > +                       list_del(&consumer->node);
> > +                       kfree(consumer);
> > +
> > +                       acpi_handle_debug(device->handle,
> > +                                         "removed dependency to %s\n",
> > +                                         resource->name);
> > +                       break;
> > +               }
> > +       }
> > +       mutex_unlock(&resource->consumer_lock);
> > +}
> > +
> > +static void
> > +acpi_power_resume_consumer(const struct acpi_power_resource *resource,
> > +                         struct acpi_device *device)
> > +{
> > +       struct device *dev;
> > +
> > +       /*
> > +        * If the device is prepared to wake we need to resume it now so
> > +        * that the driver can re-program it to do so. For non-wake devices
> > +        * we can leave them as is. The driver then restores the device
> > +        * when it is needed next time.
> > +        */
> > +       if (!acpi_device_can_wakeup(device) || !device->wakeup.prepare_count)
> > +               return;
> 
> Checking prepare_count should not be necessary here.
> 
> Arguably, the power resource cannot go off without suspending all
> devices that depend on it and for PM-runtime wakeup is always enabled.

OK

> > +
> > +       dev = acpi_get_first_physical_node(device);
> 
> And that would be unnecessary if you stored dev in struct
> acpi_power_resource_consumer.

Indeed

> > +       if (dev) {
> > +               acpi_handle_debug(device->handle,
> > +                                 "resuming %s because %s was turned on\n",
> > +                                 dev_name(dev), resource->name);
> > +               pm_runtime_resume(dev);
> 
> pm_request_resume()
> 
> This needs to be asynchronous as it should be done under resource_lock
> (see below).

OK

> > +       }
> > +}
> > +
> > +static int acpi_power_resume_consumers(struct acpi_power_resource *resource,
> > +                                      struct acpi_device *device)
> > +{
> > +       struct acpi_power_resource_consumer *consumer;
> > +       int ret = 0;
> > +
> > +       mutex_lock(&resource->consumer_lock);
> > +
> > +       list_for_each_entry(consumer, &resource->consumers, node) {
> > +               struct acpi_device *adev = consumer->consumer;
> > +               int state, ret;
> > +
> > +               /* Skip the device that originated the power on request */
> > +               if (adev == device)
> > +                       continue;
> > +
> > +               ret = acpi_power_get_inferred_state(consumer->consumer, &state);
> 
> This isn't necessary AFAICS.
> 
> The resource was off previously, so none of its consumers can be in D0.

Makes sense.

> 
> > +               if (!ret && adev->power.state > ACPI_STATE_D0 &&
> > +                   state == ACPI_STATE_D0) {
> > +                       acpi_power_resume_consumer(resource, adev);
> > +               }
> > +       }
> > +
> > +       mutex_unlock(&resource->consumer_lock);
> > +       return ret;
> > +}
> > +
> >  static int acpi_power_resources_list_add(acpi_handle handle,
> >                                          struct list_head *list)
> >  {
> > @@ -108,12 +220,14 @@ static int acpi_power_resources_list_add(acpi_handle handle,
> >         return 0;
> >  }
> >
> > -void acpi_power_resources_list_free(struct list_head *list)
> > +void acpi_power_resources_list_free(struct acpi_device *device, struct list_head *list)
> >  {
> >         struct acpi_power_resource_entry *entry, *e;
> >
> >         list_for_each_entry_safe(entry, e, list, node) {
> >                 list_del(&entry->node);
> > +               if (device)
> > +                       acpi_power_remove_consumer(entry->resource, device);
> >                 kfree(entry);
> >         }
> >  }
> > @@ -135,8 +249,8 @@ static bool acpi_power_resource_is_dup(union acpi_object *package,
> >         return false;
> >  }
> >
> > -int acpi_extract_power_resources(union acpi_object *package, unsigned int start,
> > -                                struct list_head *list)
> > +int acpi_extract_power_resources(struct acpi_device *device,
> > +       union acpi_object *package, unsigned int start, struct list_head *list)
> >  {
> >         unsigned int i;
> >         int err = 0;
> > @@ -159,7 +273,7 @@ int acpi_extract_power_resources(union acpi_object *package, unsigned int start,
> >                 if (acpi_power_resource_is_dup(package, start, i))
> >                         continue;
> >
> > -               err = acpi_add_power_resource(rhandle);
> > +               err = acpi_add_power_resource(device, rhandle);
> >                 if (err)
> >                         break;
> >
> > @@ -168,7 +282,7 @@ int acpi_extract_power_resources(union acpi_object *package, unsigned int start,
> >                         break;
> >         }
> >         if (err)
> > -               acpi_power_resources_list_free(list);
> > +               acpi_power_resources_list_free(device, list);
> >
> >         return err;
> >  }
> > @@ -258,18 +372,33 @@ static int acpi_power_on_unlocked(struct acpi_power_resource *resource)
> >                 result = __acpi_power_on(resource);
> >                 if (result)
> >                         resource->ref_count--;
> > +               else
> > +                       result = 1;
> >         }
> >         return result;
> >  }
> >
> > -static int acpi_power_on(struct acpi_power_resource *resource)
> > +static int acpi_power_on(struct acpi_device *device,
> > +                        struct acpi_power_resource *resource)
> >  {
> >         int result;
> >
> >         mutex_lock(&resource->resource_lock);
> >         result = acpi_power_on_unlocked(resource);
> >         mutex_unlock(&resource->resource_lock);
> > -       return result;
> > +
> > +       if (result <= 0)
> > +               return result;
> > +
> > +       /*
> > +        * The power resource was physically turned on. Because of this
> > +        * some of the devices sharing it may have been transitioned into
> > +        * D0 so we need to runtime resume them to make sure their driver
> > +        * re-initializes them properly. This is important for PCI devices
> > +        * that go into D0uninitialized and lose their wakeup settings
> > +        * otherwise.
> 
> So you only talk about PCI devices here, which is why I think that, at
> least for now, this needs to be done only for PCI devices.

OK. For that we would need to include <linux/pci.h> and then call
dev_is_pci() here. The other alternative is to do this in pci-acpi.c
instead like you suggest which limits this to PCI but then again PCI is
the only one having the D0uninitialized thing so probably makes more
sense to add it there anyway. I'll try that approach next.

> 
> > +        */
> > +       return acpi_power_resume_consumers(resource, device);
> 
> Resuming consumers technically belongs to the "on" operation, so it
> should be done under resource_lock (or there is nothing to prevent the
> resource from going off immediately in a different thread in theory,
> although that is unlikely due to the way device PM code works).

OK

> >  }
> >
> >  static int __acpi_power_off(struct acpi_power_resource *resource)
> > @@ -319,7 +448,7 @@ static int acpi_power_off(struct acpi_power_resource *resource)
> >         return result;
> >  }
> >
> > -static int acpi_power_off_list(struct list_head *list)
> > +static int acpi_power_off_list(struct acpi_device *device, struct list_head *list)
> >  {
> >         struct acpi_power_resource_entry *entry;
> >         int result = 0;
> > @@ -333,18 +462,18 @@ static int acpi_power_off_list(struct list_head *list)
> >
> >   err:
> >         list_for_each_entry_continue(entry, list, node)
> > -               acpi_power_on(entry->resource);
> > +               acpi_power_on(device, entry->resource);
> >
> >         return result;
> >  }
> >
> > -static int acpi_power_on_list(struct list_head *list)
> > +static int acpi_power_on_list(struct acpi_device *device, struct list_head *list)
> >  {
> >         struct acpi_power_resource_entry *entry;
> >         int result = 0;
> >
> >         list_for_each_entry(entry, list, node) {
> > -               result = acpi_power_on(entry->resource);
> > +               result = acpi_power_on(device, entry->resource);
> >                 if (result)
> >                         goto err;
> >         }
> > @@ -582,7 +711,7 @@ int acpi_enable_wakeup_device_power(struct acpi_device *dev, int sleep_state)
> >
> >                 if (!resource->wakeup_enabled) {
> >                         err = acpi_power_on_unlocked(resource);
> > -                       if (!err)
> > +                       if (err >= 0)
> >                                 resource->wakeup_enabled = true;
> >                 }
> >
> > @@ -703,7 +832,7 @@ int acpi_power_on_resources(struct acpi_device *device, int state)
> >         if (!device || state < ACPI_STATE_D0 || state > ACPI_STATE_D3_HOT)
> >                 return -EINVAL;
> >
> > -       return acpi_power_on_list(&device->power.states[state].resources);
> > +       return acpi_power_on_list(device, &device->power.states[state].resources);
> >  }
> >
> >  int acpi_power_transition(struct acpi_device *device, int state)
> > @@ -726,11 +855,11 @@ int acpi_power_transition(struct acpi_device *device, int state)
> >          * we dereference all power resources used in the current list.
> >          */
> >         if (state < ACPI_STATE_D3_COLD)
> > -               result = acpi_power_on_list(
> > +               result = acpi_power_on_list(device,
> >                         &device->power.states[state].resources);
> >
> >         if (!result && device->power.state < ACPI_STATE_D3_COLD)
> > -               acpi_power_off_list(
> > +               acpi_power_off_list(device,
> >                         &device->power.states[device->power.state].resources);
> >
> >         /* We shouldn't change the state unless the above operations succeed. */
> > @@ -788,7 +917,7 @@ static void acpi_power_add_resource_to_list(struct acpi_power_resource *resource
> >         mutex_unlock(&power_resource_list_lock);
> >  }
> >
> > -int acpi_add_power_resource(acpi_handle handle)
> > +int acpi_add_power_resource(struct acpi_device *adev, acpi_handle handle)
> >  {
> >         struct acpi_power_resource *resource;
> >         struct acpi_device *device = NULL;
> > @@ -798,8 +927,10 @@ int acpi_add_power_resource(acpi_handle handle)
> >         int state, result = -ENODEV;
> >
> >         acpi_bus_get_device(handle, &device);
> > -       if (device)
> > -               return 0;
> > +       if (device) {
> > +               resource = to_power_resource(device);
> > +               goto add_consumer;
> > +       }
> >
> >         resource = kzalloc(sizeof(*resource), GFP_KERNEL);
> >         if (!resource)
> > @@ -810,6 +941,8 @@ int acpi_add_power_resource(acpi_handle handle)
> >                                 ACPI_STA_DEFAULT);
> >         mutex_init(&resource->resource_lock);
> >         INIT_LIST_HEAD(&resource->list_node);
> > +       INIT_LIST_HEAD(&resource->consumers);
> > +       mutex_init(&resource->consumer_lock);
> >         resource->name = device->pnp.bus_id;
> >         strcpy(acpi_device_name(device), ACPI_POWER_DEVICE_NAME);
> >         strcpy(acpi_device_class(device), ACPI_POWER_CLASS);
> > @@ -840,7 +973,11 @@ int acpi_add_power_resource(acpi_handle handle)
> >
> >         acpi_power_add_resource_to_list(resource);
> >         acpi_device_add_finalize(device);
> > -       return 0;
> > +
> > + add_consumer:
> 
> Note that this only needs to be done if the device's D0 list contains
> the resource.

Good point.
