Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067692407C1
	for <lists+linux-pci@lfdr.de>; Mon, 10 Aug 2020 16:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgHJOmW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Aug 2020 10:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgHJOmV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Aug 2020 10:42:21 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116C4C061756;
        Mon, 10 Aug 2020 07:42:21 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id g6so9825200ljn.11;
        Mon, 10 Aug 2020 07:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fWkEs1WmcVZE4cGDA+geI3RJmT88csh7VsEAZzHbrIo=;
        b=ROIr5aS0jcS+gqUwH/5SfvTlBgYX0g3JsYtZ7N2j1H+/WfBBmzMGg9b33QhoS5UIPJ
         b2lmsQKNLnR0KZ5UuajkL5uqIn/eZKsO2GedKjiPdISeocYIuZr38Px/yL942R41Gk4f
         0eAVJIQrTiaq5GDvI1i4ZsrWV3A7FO1GnfIBR2vwGlxMwB4b4TSzNyDBJBXw25MxUYI4
         JRknYSXTV9YJhStxcSoYbOeo4aF/+Fa/lkQHEMxVSyG/Uv3qXBlfseuNQqA5JmQ0sykg
         UuW2WT+Lm0/cRIMGohJeUXX9faFiJvwR5YNYkfZYDwNWnmD3Jj4/42T8JxQSXIZ3JC4K
         WDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fWkEs1WmcVZE4cGDA+geI3RJmT88csh7VsEAZzHbrIo=;
        b=lks1o7ItW/C+MwVIgrPJnY0H81toMWybq8D8ftnNuOnJMgfhFEqYRKHkFQ0FoZBYi6
         5zxCR6QyleorL7TKLYViFY/73blANBaNfPTrb2oazzsExl4NgoRPhZJIS9zipbBkDm/f
         KX530tSroqdcvQQTjhhk3XAE4LcL0Sbs5sS5QRk3ytsIOnb1lO6xDogx+W2Bhu30lIPF
         GDFxOYxS9aFEPdQdfybDM2Qvj719red52vgF89LCekmK5gd+GL3o/glkNSUVAQ705oRH
         pn397jbfUketflJWHjXIZBGx0Bvdce7+AU2q6Hn0jmrfdVSpIPY9XwuxDIT/bM73dyrs
         WiJA==
X-Gm-Message-State: AOAM532Q8THohpTfhEZ1VmtgpX9Mql7ugudEgjhNZw2wR9znUhzy6b/k
        gJKRheXlRtabLiFU6L8m1VOCYvSeRCCK5fnmoG8=
X-Google-Smtp-Source: ABdhPJwN5hdXTAKIS+I6qaQJnbbB6NkAGRxJdotRt/2F9CSS+WpcAMsFTp28SCk9dvaDpPx8lYzCs8wObjrLyLui1kY=
X-Received: by 2002:a2e:808f:: with SMTP id i15mr789540ljg.151.1597070538926;
 Mon, 10 Aug 2020 07:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200717190620.29821-1-david.e.box@linux.intel.com>
 <20200729213719.17795-1-david.e.box@linux.intel.com> <74c03fe9fea12f4b056bf694a0d03d5200244231.camel@linux.intel.com>
In-Reply-To: <74c03fe9fea12f4b056bf694a0d03d5200244231.camel@linux.intel.com>
From:   Umesh A <umeshlinux123@gmail.com>
Date:   Mon, 10 Aug 2020 20:12:07 +0530
Message-ID: <CALk=_MjCKo7Kcgaxko1qS_O+r1pDmBHsvSSSM4a=U44CBe8M6g@mail.gmail.com>
Subject: Re: [PATCH V5 0/3] Intel Platform Monitoring Technology
To:     david.e.box@linux.intel.com
Cc:     lee.jones@linaro.org, dvhart@infradead.org, andy@infradead.org,
        bhelgaas@google.com, alexander.h.duyck@linux.intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

MCTP and PLDM are the latest in Platform management Technology. Sw
application and drivers can be implemented on the PCIe platform.
Previously I spent some time on this.

On Mon, Aug 10, 2020 at 7:49 PM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> Friendly ping.
>
> On Wed, 2020-07-29 at 14:37 -0700, David E. Box wrote:
> > Intel Platform Monitoring Technology (PMT) is an architecture for
> > enumerating and accessing hardware monitoring capabilities on a
> > device.
> > With customers increasingly asking for hardware telemetry, engineers
> > not
> > only have to figure out how to measure and collect data, but also how
> > to
> > deliver it and make it discoverable. The latter may be through some
> > device
> > specific method requiring device specific tools to collect the data.
> > This
> > in turn requires customers to manage a suite of different tools in
> > order to
> > collect the differing assortment of monitoring data on their
> > systems.  Even
> > when such information can be provided in kernel drivers, they may
> > require
> > constant maintenance to update register mappings as they change with
> > firmware updates and new versions of hardware. PMT provides a
> > solution for
> > discovering and reading telemetry from a device through a hardware
> > agnostic
> > framework that allows for updates to systems without requiring
> > patches to
> > the kernel or software tools.
> >
> > PMT defines several capabilities to support collecting monitoring
> > data from
> > hardware. All are discoverable as separate instances of the PCIE
> > Designated
> > Vendor extended capability (DVSEC) with the Intel vendor code. The
> > DVSEC ID
> > field uniquely identifies the capability. Each DVSEC also provides a
> > BAR
> > offset to a header that defines capability-specific attributes,
> > including
> > GUID, feature type, offset and length, as well as configuration
> > settings
> > where applicable. The GUID uniquely identifies the register space of
> > any
> > monitor data exposed by the capability. The GUID is associated with
> > an XML
> > file from the vendor that describes the mapping of the register space
> > along
> > with properties of the monitor data. This allows vendors to perform
> > firmware updates that can change the mapping (e.g. add new metrics)
> > without
> > requiring any changes to drivers or software tools. The new mapping
> > is
> > confirmed by an updated GUID, read from the hardware, which software
> > uses
> > with a new XML.
> >
> > The current capabilities defined by PMT are Telemetry, Watcher, and
> > Crashlog.  The Telemetry capability provides access to a continuous
> > block
> > of read only data. The Watcher capability provides access to hardware
> > sampling and tracing features. Crashlog provides access to device
> > crash
> > dumps.  While there is some relationship between capabilities
> > (Watcher can
> > be configured to sample from the Telemetry data set) each exists as
> > stand
> > alone features with no dependency on any other. The design therefore
> > splits
> > them into individual, capability specific drivers. MFD is used to
> > create
> > platform devices for each capability so that they may be managed by
> > their
> > own driver. The PMT architecture is (for the most part) agnostic to
> > the
> > type of device it can collect from. Devices nodes are consequently
> > generic
> > in naming, e.g. /dev/telem<n> and /dev/smplr<n>. Each capability
> > driver
> > creates a class to manage the list of devices supporting
> > it.  Software can
> > determine which devices support a PMT feature by searching through
> > each
> > device node entry in the sysfs class folder. It can additionally
> > determine
> > if a particular device supports a PMT feature by checking for a PMT
> > class
> > folder in the device folder.
> >
> > This patch set provides support for the PMT framework, along with
> > support
> > for Telemetry on Tiger Lake.
> >
> > Changes from V4:
> >       - Replace MFD with PMT in driver title
> >       - Fix commit tags in chronological order
> >       - Fix includes in alphabetical order
> >       - Use 'raw' string instead of defines for device names
> >       - Add an error message when returning an error code for
> >         unrecognized capability id
> >       - Use dev_err instead of dev_warn for messages when returning
> >         an error
> >       - Change while loop to call pci_find_next_ext_capability once
> >       - Add missing continue in while loop
> >       - Keep PCI platform defines using PCI_DEVICE_DATA magic tied to
> >         the pci_device_id table
> >       - Comment and kernel message cleanup
> >
> > Changes from V3:
> >       - Write out full acronym for DVSEC in PCI patch commit message
> > and
> >         add 'Designated' to comments
> >       - remove unused variable caught by kernel test robot <
> > lkp@intel.com>
> >       - Add required Co-developed-by signoffs, noted by Andy
> >       - Allow access using new CAP_PERFMON capability as suggested by
> >         Alexey Bundankov
> >       - Fix spacing in Kconfig, noted by Randy
> >       - Other style changes and fixups suggested by Andy
> >
> > Changes from V2:
> >       - In order to handle certain HW bugs from the telemetry
> > capability
> >         driver, create a single platform device per capability
> > instead of
> >         a device per entry. Add the entry data as device resources
> > and
> >         let the capability driver manage them as a set allowing for
> >         cleaner HW bug resolution.
> >       - Handle discovery table offset bug in intel_pmt.c
> >       - Handle overlapping regions in intel_pmt_telemetry.c
> >       - Add description of sysfs class to testing ABI.
> >       - Don't check size and count until confirming support for the
> > PMT
> >         capability to avoid bailing out when we need to skip it.
> >       - Remove unneeded header file. Move code to the intel_pmt.c,
> > the
> >         only place where it's needed.
> >       - Remove now unused platform data.
> >       - Add missing header files types.h, bits.h.
> >       - Rename file name and build options from telem to telemetry.
> >       - Code cleanup suggested by Andy S.
> >       - x86 mailing list added.
> >
> > Changes from V1:
> >       - In the telemetry driver, set the device in device_create() to
> >         the parent PCI device (the monitoring device) for clear
> >         association in sysfs. Was set before to the platform device
> >         created by the PCI parent.
> >       - Move telem struct into driver and delete unneeded header
> > file.
> >       - Start telem device numbering from 0 instead of 1. 1 was used
> >         due to anticipated changes, no longer needed.
> >       - Use helper macros suggested by Andy S.
> >       - Rename class to pmt_telemetry, spelling out full name
> >       - Move monitor device name defines to common header
> >       - Coding style, spelling, and Makefile/MAINTAINERS ordering
> > fixes
> >
> > David E. Box (3):
> >   PCI: Add defines for Designated Vendor-Specific Extended Capability
> >   mfd: Intel Platform Monitoring Technology support
> >   platform/x86: Intel PMT Telemetry capability driver
> >
> >  .../ABI/testing/sysfs-class-pmt_telemetry     |  46 ++
> >  MAINTAINERS                                   |   6 +
> >  drivers/mfd/Kconfig                           |  10 +
> >  drivers/mfd/Makefile                          |   1 +
> >  drivers/mfd/intel_pmt.c                       | 220 +++++++++
> >  drivers/platform/x86/Kconfig                  |  10 +
> >  drivers/platform/x86/Makefile                 |   1 +
> >  drivers/platform/x86/intel_pmt_telemetry.c    | 448
> > ++++++++++++++++++
> >  include/uapi/linux/pci_regs.h                 |   5 +
> >  9 files changed, 747 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-
> > pmt_telemetry
> >  create mode 100644 drivers/mfd/intel_pmt.c
> >  create mode 100644 drivers/platform/x86/intel_pmt_telemetry.c
> >
>
