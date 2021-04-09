Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F94F3591E0
	for <lists+linux-pci@lfdr.de>; Fri,  9 Apr 2021 04:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbhDICOB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 22:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhDICOA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 22:14:00 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7711FC061760
        for <linux-pci@vger.kernel.org>; Thu,  8 Apr 2021 19:13:48 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id m3so4704381edv.5
        for <linux-pci@vger.kernel.org>; Thu, 08 Apr 2021 19:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f2qaiiK1miGaHFDZOcjWpGbeY0G0GNPiEFJnOCok4zM=;
        b=yq7NYbntAfC6ZE5vwPH8NQp6c/9DeWBTAw85Zl/9kTUELym7jNaKZMPofpwWuOyxsJ
         6mJ4tatrCAM9QChJP/npb9QyVmqALziSs6c7fz+iuUmZVNruPf/JiFvbq0g1HpWdlYrL
         S9Qd+pkmOR7AQHG3HJ35aWygLAKS4+dqQhxjd5nqjQKdm2H5VYcFFoYiQ6BXSkp2bdAl
         ryk5rZpGoSACoNx6dG78mU2GzUYrtVKazPdGcCcXymf/Fo+vPSpxo6ak7nfq2r2vDRnZ
         nTiFgCxxIeIkAuJe1VGd39aTB4KIJ2TgwzPa0oNEeA+C65tQx45HtnEsbwdRq9GNyJPc
         bfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f2qaiiK1miGaHFDZOcjWpGbeY0G0GNPiEFJnOCok4zM=;
        b=H7gBWbuasDz39qQj04WyXMKLkoULNMoKTBxYZFcMkkbuIVaATZmsf+YNh94icmRHl0
         udA/kr8xM9suoCqQbaTBtcgWaDfEOBHW0Wj/7wgnx0dD9WQkuIlm4Wn5RacABmWd8+YX
         RED+R1/9NiQ5T4owKWlKO+Qll9aBSV6WjUuhtlY9g5vw6BoKAggyaK47vF5J9x26czbj
         nxrQbK6Rlyq7i6u/i26FJ83azdH2rM8jDAcHtTt1Xps8m9u4L4M6pdMh6rZ6DzlDlTPT
         RPiE9+BnVELYILEnApN6qcqK/BJfOWl9IwEQxYD/Dss9WRVHLOVSq3QkRxptUdRoygte
         GNIw==
X-Gm-Message-State: AOAM530tTM3cDc+jTs729xkTu4uI/SMO9KbBkfAOru5C9IouvKVqa6O1
        HbQb0T/vAm1rfXpHLhhOM+8++gUAPHUgFt788diRijaoiqdtBQ==
X-Google-Smtp-Source: ABdhPJy8T/A/b0CcVSuNgdFN6MQiQW7XBPZq78CD/4+wYIqurY2iw+THk2r3Sw/gRB14TkMR0lGHk1vunwcPz60JRjU=
X-Received: by 2002:a05:6402:30ae:: with SMTP id df14mr14946235edb.97.1617934426999;
 Thu, 08 Apr 2021 19:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <161728748083.2474040.753623311074560290.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210408224215.GA1964510@bjorn-Precision-5520>
In-Reply-To: <20210408224215.GA1964510@bjorn-Precision-5520>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 8 Apr 2021 19:13:38 -0700
Message-ID: <CAPcyv4hAc=DERr1z8kr=V01+NSi74f-kSfMAdeArLmVb112_Dw@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] cxl/port: Introduce cxl_port objects
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn, thanks for taking a look.


On Thu, Apr 8, 2021 at 3:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Greg, Rafael, Matthew: device model questions]
>
> Hi Dan,
>
> On Thu, Apr 01, 2021 at 07:31:20AM -0700, Dan Williams wrote:
> > Once the cxl_root is established then other ports in the hierarchy can
> > be attached. The cxl_port object, unlike cxl_root that is associated
> > with host bridges, is associated with PCIE Root Ports or PCIE Switch
> > Ports. Add cxl_port instances for all PCIE Root Ports in an ACPI0016
> > host bridge.
>
> I'm not a device model expert, but I'm not sure about adding a new
> /sys/bus/cxl/devices hierarchy.  I'm under the impression that CXL
> devices will be enumerated by the PCI core as PCIe devices.

Yes, PCIe is involved, but mostly only for the CXL.io slow path
(configuration and provisioning via mailbox) when we're talking about
memory expander devices (CXL calls these Type-3). So-called "Type-3"
support is the primary driver of this infrastructure.

You might be thinking of CXL accelerator devices that will look like
plain PCIe devices that happen to participate in the CPU cache
hierarchy (CXL calls these Type-1). There will also be accelerator
devices that want to share coherent memory with the system (CXL calls
these Type-2).

The infrastructure being proposed here is primarily for the memory
expander (Type-3) device case where the PCI sysfs hierarchy is wholly
unsuited for modeling it. A single CXL memory region device may span
multiple endpoints, switches, and host bridges. It poses similar
stress to an OS device model as RAID where there is a driver for the
component contributors to an upper level device / driver that exposes
the RAID Volume (CXL memory region interleave set). The CXL memory
decode space (HDM: Host Managed Device Memory) is independent of the
PCIe MMIO BAR space.

That's where the /sys/bus/cxl hierarchy is needed, to manage the HDM
space across the CXL topology in a way that is foreign to PCIE (HDM
Decoder hierarchy).

> Doesn't
> that mean we will have one struct device in the pci_dev, and another
> one in the cxl_port?

Yes, that is the proposal.

> That seems like an issue to me.  More below.

hmm...

>
> > The cxl_port instances for PCIE Switch Ports are not
> > included here as those are to be modeled as another service device
> > registered on the pcie_port_bus_type.
>
> I'm hesitant about the idea of adding more uses of pcie_port_bus_type.
> I really dislike portdrv because it makes a parallel hierarchy:
>
>   /sys/bus/pci
>   /sys/bus/pci_express
>
> for things that really should not be different.  There's a struct
> device in pci_dev, and potentially several pcie_devices, each with
> another struct device.  We make these pcie_device things for AER, DPC,
> hotplug, etc.  E.g.,
>
>   /sys/bus/pci/devices/0000:00:1c.0
>   /sys/bus/pci_express/devices/0000:00:1c.0:pcie002  # AER
>   /sys/bus/pci_express/devices/0000:00:1c.0:pcie010  # BW notification
>
> These are all the same PCI device.  AER is a PCI capability.
> Bandwidth notification is just a feature of all Downstream Ports.  I
> think it makes zero sense to have extra struct devices for them.  From
> a device point of view (enumeration, power management, VM assignment),
> we can't manage them separately from the underlying PCI device.  For
> example, we have three separate "power/" directories, but obviously
> there's only one point of control (00:1c.0):
>
>   /sys/devices/pci0000:00/0000:00:1c.0/power/
>   /sys/devices/pci0000:00/0000:00:1c.0/0000:00:1c.0:pcie002/power/
>   /sys/devices/pci0000:00/0000:00:1c.0/0000:00:1c.0:pcie010/power/

The superfluous power/ issue can be cleaned up with
device_set_pm_not_required().

What are the other problems this poses, because in other areas this
ability to subdivide a device's functionality into sub-drivers is a
useful organization principle? So much so that several device writer
teams came together to create the auxiliary-bus for the purpose of
allowing sub-drivers to be carved off for independent functionality
similar to the portdrv organization.

That said, I'm open to CXL switch support *not* building on the
portdrv model, but I'm not yet on the same page with your concern.
