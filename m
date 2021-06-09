Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0636C3A12BC
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jun 2021 13:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238521AbhFILaO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Jun 2021 07:30:14 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3184 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbhFILaN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jun 2021 07:30:13 -0400
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G0PnX0zg1z6K5sc;
        Wed,  9 Jun 2021 19:21:36 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 13:28:17 +0200
Received: from localhost (10.52.124.126) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 9 Jun 2021
 12:28:16 +0100
Date:   Wed, 9 Jun 2021 12:28:14 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
        "Linux ACPI" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v5 4/6] cxl/acpi: Add downstream port data to cxl_port
 instances
Message-ID: <20210609122814.00005ed1@Huawei.com>
In-Reply-To: <CAPcyv4jc07GuoOu8HPwVucj7PcdNjLjE1ScwRBDTyQ788Ot4tw@mail.gmail.com>
References: <162295949351.1109360.10329014558746500142.stgit@dwillia2-desk3.amr.corp.intel.com>
        <162295951736.1109360.12642726343803988356.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20210608124910.0000329e@Huawei.com>
        <CAPcyv4jc07GuoOu8HPwVucj7PcdNjLjE1ScwRBDTyQ788Ot4tw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.124.126]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 8 Jun 2021 16:58:19 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Tue, Jun 8, 2021 at 4:49 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Sat, 5 Jun 2021 23:05:17 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >  
> > > In preparation for infrastructure that enumerates and configures the CXL
> > > decode mechanism of an upstream port to its downstream ports, add a
> > > representation for a CXL downstream port.
> > >
> > > On ACPI systems the top-most logical downstream ports in the hierarchy
> > > are the host bridges (ACPI0016 devices) that decode the memory windows
> > > described by the CXL Early Discovery Table Fixed Memory Window
> > > Structures (CEDT.CFMWS).
> > >
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-cxl |   13 ++++
> > >  drivers/cxl/acpi.c                      |   44 ++++++++++++++
> > >  drivers/cxl/core.c                      |   95 ++++++++++++++++++++++++++++++-
> > >  drivers/cxl/cxl.h                       |   21 +++++++
> > >  4 files changed, 169 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > > index fb996ced7629..0cb31b7ad17b 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > > @@ -35,3 +35,16 @@ Description:
> > >               CXL component registers. The 'uport' symlink connects the CXL
> > >               portX object to the device that published the CXL port
> > >               capability.
> > > +
> > > +What:                /sys/bus/cxl/devices/portX/dportY
> > > +Date:                June, 2021
> > > +KernelVersion:       v5.14
> > > +Contact:     linux-cxl@vger.kernel.org
> > > +Description:
> > > +             CXL port objects are enumerated from either a platform firmware
> > > +             device (ACPI0017 and ACPI0016) or PCIe switch upstream port with
> > > +             CXL component registers. The 'dportY' symlink identifies one or
> > > +             more downstream ports that the upstream port may target in its
> > > +             decode of CXL memory resources.  The 'Y' integer reflects the
> > > +             hardware port unique-id used in the hardware decoder target
> > > +             list.
> > > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > > index 556d25ab6966..0ae7464b603d 100644
> > > --- a/drivers/cxl/acpi.c
> > > +++ b/drivers/cxl/acpi.c
> > > @@ -5,19 +5,61 @@
> > >  #include <linux/device.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/acpi.h>
> > > +#include <linux/pci.h>  
> >
> > Not immediately seeing why this include is added in this patch.  
> 
> My neither, it belongs in the next patch.
> 
> >  
> > >  #include "cxl.h"
> > >
> > > +static struct acpi_device *to_cxl_host_bridge(struct device *dev)
> > > +{
> > > +     struct acpi_device *adev = to_acpi_device(dev);
> > > +
> > > +     if (strcmp(acpi_device_hid(adev), "ACPI0016") == 0)
> > > +             return adev;
> > > +     return NULL;
> > > +}
> > > +
> > > +static int add_host_bridge_dport(struct device *match, void *arg)
> > > +{
> > > +     int rc;
> > > +     acpi_status status;
> > > +     unsigned long long uid;
> > > +     struct cxl_port *root_port = arg;
> > > +     struct device *host = root_port->dev.parent;
> > > +     struct acpi_device *bridge = to_cxl_host_bridge(match);
> > > +
> > > +     if (!bridge)
> > > +             return 0;
> > > +
> > > +     status = acpi_evaluate_integer(bridge->handle, METHOD_NAME__UID, NULL,
> > > +                                    &uid);
> > > +     if (status != AE_OK) {
> > > +             dev_err(host, "unable to retrieve _UID of %s\n",
> > > +                     dev_name(match));
> > > +             return -ENODEV;
> > > +     }
> > > +
> > > +     rc = cxl_add_dport(root_port, match, uid, CXL_RESOURCE_NONE);
> > > +     if (rc) {
> > > +             dev_err(host, "failed to add downstream port: %s\n",
> > > +                     dev_name(match));
> > > +             return rc;
> > > +     }
> > > +     dev_dbg(host, "add dport%llu: %s\n", uid, dev_name(match));
> > > +     return 0;
> > > +}
> > > +
> > >  static int cxl_acpi_probe(struct platform_device *pdev)
> > >  {
> > >       struct cxl_port *root_port;
> > >       struct device *host = &pdev->dev;
> > > +     struct acpi_device *adev = ACPI_COMPANION(host);
> > >
> > >       root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
> > >       if (IS_ERR(root_port))
> > >               return PTR_ERR(root_port);
> > >       dev_dbg(host, "add: %s\n", dev_name(&root_port->dev));
> > >
> > > -     return 0;
> > > +     return bus_for_each_dev(adev->dev.bus, NULL, root_port,
> > > +                             add_host_bridge_dport);
> > >  }
> > >
> > >  static const struct acpi_device_id cxl_acpi_ids[] = {
> > > diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
> > > index dbbb34618d7d..4418b30cce4f 100644
> > > --- a/drivers/cxl/core.c
> > > +++ b/drivers/cxl/core.c
> > > @@ -33,10 +33,22 @@ static struct attribute_group cxl_base_attribute_group = {
> > >       .attrs = cxl_base_attributes,
> > >  };
> > >
> > > +static void cxl_dport_release(struct cxl_dport *dport)
> > > +{
> > > +     put_device(dport->dport);
> > > +     list_del(&dport->list);  
> > This ordering isn't the reverse of what happens cxl_add_dport()
> > That would be
> >
> > list_del()
> > put_device()
> > kfree()
> >
> > If there is a strong reason for that I'd like to see a comment here.  
> 
> No strong reason, I'll reorder.
> 
> >  
> > > +     kfree(dport);
> > > +}
> > > +
> > >  static void cxl_port_release(struct device *dev)
> > >  {
> > >       struct cxl_port *port = to_cxl_port(dev);
> > > +     struct cxl_dport *dport, *_d;
> > >
> > > +     device_lock(dev);
> > > +     list_for_each_entry_safe(dport, _d, &port->dports, list)
> > > +             cxl_dport_release(dport);
> > > +     device_unlock(dev);
> > >       ida_free(&cxl_port_ida, port->id);
> > >       kfree(port);
> > >  }
> > > @@ -60,9 +72,22 @@ struct cxl_port *to_cxl_port(struct device *dev)
> > >       return container_of(dev, struct cxl_port, dev);
> > >  }
> > >
> > > -static void unregister_dev(void *dev)
> > > +static void unregister_port(void *_port)
> > >  {
> > > -     device_unregister(dev);
> > > +     struct cxl_port *port = _port;
> > > +     struct cxl_dport *dport;
> > > +
> > > +     device_lock(&port->dev);
> > > +     list_for_each_entry(dport, &port->dports, list) {
> > > +             char link_name[CXL_TARGET_STRLEN];
> > > +
> > > +             if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d",
> > > +                          dport->port_id) >= CXL_TARGET_STRLEN)
> > > +                     continue;
> > > +             sysfs_remove_link(&port->dev.kobj, link_name);
> > > +     }
> > > +     device_unlock(&port->dev);
> > > +     device_unregister(&port->dev);
> > >  }
> > >
> > >  static void cxl_unlink_uport(void *_port)
> > > @@ -113,6 +138,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
> > >
> > >       port->uport = uport;
> > >       port->component_reg_phys = component_reg_phys;
> > > +     INIT_LIST_HEAD(&port->dports);
> > >
> > >       device_initialize(dev);
> > >       device_set_pm_not_required(dev);
> > > @@ -157,7 +183,7 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
> > >       if (rc)
> > >               goto err;
> > >
> > > -     rc = devm_add_action_or_reset(host, unregister_dev, dev);
> > > +     rc = devm_add_action_or_reset(host, unregister_port, port);
> > >       if (rc)
> > >               return ERR_PTR(rc);
> > >
> > > @@ -173,6 +199,69 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
> > >  }
> > >  EXPORT_SYMBOL_GPL(devm_cxl_add_port);
> > >
> > > +static int add_dport(struct cxl_port *port, struct cxl_dport *new)
> > > +{
> > > +     struct cxl_dport *dport, *dup = NULL;
> > > +
> > > +     device_lock(&port->dev);
> > > +     list_for_each_entry (dport, &port->dports, list)
> > > +             if (new->port_id == dport->port_id) {
> > > +                     dup = dport;
> > > +                     goto err;
> > > +             }
> > > +     list_add_tail(&new->list, &port->dports);
> > > +     device_unlock(&port->dev);
> > > +
> > > +     return 0;
> > > +
> > > +err:
> > > +     device_unlock(&port->dev);
> > > +     dev_err(&port->dev,
> > > +             "unable to add dport%d-%s non-unique port id (%s)\n",
> > > +             new->port_id, dev_name(new->dport), dev_name(dup->dport));  
> >
> > As there is potential that you might end up with other errors in here long term,
> > why not move this to the point where the error is detected?
> > I think you are fine doing it under the mutex.  Obviously indent will be a deeper
> > than ideal.  
> 
> Hmm, I'll take a look. Might add a dup finder helper to keep the
> indent under control.
> 
> >  
> > > +     return -EEXIST;
> > > +}
> > > +
> > > +/*  
> >
> > This is a bit inconsistent wrt to what functions get full kernel-doc.
> > My personal preference would be all the exported functions + any others
> > where it is particularly useful.  
> 
> I agree with the sentiment for globally exported symbols. In this case
> they are in the "CXL" module namespace and privately defined in
> drivers/cxl/ headers. That said, I did document devm_add_cxl_port(),
> so there's no good reason to skip the documentation on the other
> devm_cxl_add_* routines... will fix.

Maybe we should consider using symbol namespaces for CXL?
EXPORT_SYMBOL_NS_GPL() etc


> 
> > > + * Append downstream port data to a cxl_port, note that all allocations
> > > + * and links are undone by cxl_port deletion and release.
> > > + */
> > > +int cxl_add_dport(struct cxl_port *port, struct device *dport_dev, int port_id,
> > > +               resource_size_t component_reg_phys)
> > > +{
> > > +     char link_name[CXL_TARGET_STRLEN];
> > > +     struct cxl_dport *dport;
> > > +     int rc;
> > > +
> > > +     if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d", port_id) >=
> > > +         CXL_TARGET_STRLEN)
> > > +             return -EINVAL;
> > > +
> > > +     dport = kzalloc(sizeof(*dport), GFP_KERNEL);
> > > +     if (!dport)
> > > +             return -ENOMEM;
> > > +
> > > +     INIT_LIST_HEAD(&dport->list);
> > > +     dport->dport = get_device(dport_dev);
> > > +     dport->port_id = port_id;
> > > +     dport->component_reg_phys = component_reg_phys;
> > > +     dport->port = port;
> > > +
> > > +     rc = add_dport(port, dport);
> > > +     if (rc)  
> >
> > If you get an error here, it's not been added to the list, but
> > in the cxl_dport_release() you remove it from the list. I think you
> > just want to put and free the device here.  
> 
> The delete is innocuous because of the INIT_LIST_HEAD() above. So the
> delete will end up doing the right thing and leaving the entry empty
> again, and that saves the need for custom code to handle that case.

Ah fair enough. I'd missed that INIT.  Not sure I'm keen on that
approach as it's not in the 'obviously correct' category but it's your
code to maintain so I'm not that fussed.

Jonathan


