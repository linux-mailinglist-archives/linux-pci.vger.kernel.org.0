Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1AE1CA7B2
	for <lists+linux-pci@lfdr.de>; Fri,  8 May 2020 11:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgEHJ7e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 May 2020 05:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgEHJ7e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 May 2020 05:59:34 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F9CC05BD43;
        Fri,  8 May 2020 02:59:34 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z1so694278pfn.3;
        Fri, 08 May 2020 02:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S+BJjmZtifOI5jGhDeai3W5Hb7iEmuSquXtaADjE/3w=;
        b=NwY3EyoprWx6jUqNizab8yi7ZowKUuwaV8YsBMlSLo+nw05xEZDmLC5EYprEaGLviB
         AZkR5sSDbN7T8b/GCaagOER9sfzBHvYKOh52GxngyzxTyPkq30Tk2M47ANDCkjDpEn2q
         /UYGlAPjuJLBSu+OqwB77q0l3CL6jEyEADRZiSisukOvD+L5IJTc74kfZpaKZJEqqYLF
         N7rAurzQXV/rrCMuOnXbKxizWSr1DNy8Iwf5MxiyyjIHYHFUkIAjxeTvZOednCC+t1nu
         nEpyJw+3u5XzwlTFgIOgGF7gny5VTYidnDa7OgWWUy4x79bTXyOdF3rAmEqBeYqu8CCk
         UrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S+BJjmZtifOI5jGhDeai3W5Hb7iEmuSquXtaADjE/3w=;
        b=EDHrhi/OFcQIzSC3KQsvNzSgbii5QizQcHztqqbu6oGvBrsZKI7TQm7qVGQ+XE7gjH
         gM7oQIPoXgHtBRvAyd9Lfkt81DE+dJpv/+yfrw8EDiK3TfbHd4CvOiDGnTrSO0RJteXR
         NS71Z0V6BYzyTB2idHAwukBP1v7anqEJ53Ucmaqyad6TPEJYknaf8dG/xXeBTtyC4kKD
         j5oHc8P14FeT4vqWYUcnESeaAY0+qZFAPj7Ri+hbjyE0C3ELYxV/+EgKN/+6MmGP6qws
         8LQCt9uOXGuBubixgYivh4dryltAwj+CvYPPVe45KluDvtwn5n0sTOjsEw8f40IRAHdt
         Og1Q==
X-Gm-Message-State: AGi0PuZ5mLb+Sw0q4pETHSjj2NPcszq+82v+vpI6TrOvQXYCL2yct3na
        7+V7JAC4y+uLQkcOst0lnwO2vHu3kbduIqM4Cf8=
X-Google-Smtp-Source: APiQypKFZTzfECRBxxLzLcaQcOy/X376LZ+Bvw7Lb3Z7Ut10fgtcqR+zmqToo16LQkK9RY8ByuDgO/aCjwkRcJv5sFQ=
X-Received: by 2002:a62:f908:: with SMTP id o8mr2009157pfh.170.1588931973494;
 Fri, 08 May 2020 02:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200505013206.11223-1-david.e.box@linux.intel.com> <20200508021844.6911-1-david.e.box@linux.intel.com>
In-Reply-To: <20200508021844.6911-1-david.e.box@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 May 2020 12:59:27 +0300
Message-ID: <CAHp75VfDzcQeWKHGF9Z=1=j8Tn+BhZJ6mMOrRfuZ1d5J1jsWDw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Intel Platform Monitoring Technology
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 8, 2020 at 5:18 AM David E. Box <david.e.box@linux.intel.com> wrote:
>
> Intel Platform Monitoring Technology (PMT) is an architecture for
> enumerating and accessing hardware monitoring capabilities on a device.
> With customers increasingly asking for hardware telemetry, engineers not
> only have to figure out how to measure and collect data, but also how to
> deliver it and make it discoverable. The latter may be through some device
> specific method requiring device specific tools to collect the data. This
> in turn requires customers to manage a suite of different tools in order to
> collect the differing assortment of monitoring data on their systems.  Even
> when such information can be provided in kernel drivers, they may require
> constant maintenance to update register mappings as they change with
> firmware updates and new versions of hardware. PMT provides a solution for
> discovering and reading telemetry from a device through a hardware agnostic
> framework that allows for updates to systems without requiring patches to
> the kernel or software tools.
>
> PMT defines several capabilities to support collecting monitoring data from
> hardware. All are discoverable as separate instances of the PCIE Designated
> Vendor extended capability (DVSEC) with the Intel vendor code. The DVSEC ID
> field uniquely identifies the capability. Each DVSEC also provides a BAR
> offset to a header that defines capability-specific attributes, including
> GUID, feature type, offset and length, as well as configuration settings
> where applicable. The GUID uniquely identifies the register space of any
> monitor data exposed by the capability. The GUID is associated with an XML
> file from the vendor that describes the mapping of the register space along
> with properties of the monitor data. This allows vendors to perform
> firmware updates that can change the mapping (e.g. add new metrics) without
> requiring any changes to drivers or software tools. The new mapping is
> confirmed by an updated GUID, read from the hardware, which software uses
> with a new XML.
>
> The current capabilities defined by PMT are Telemetry, Watcher, and
> Crashlog.  The Telemetry capability provides access to a continuous block
> of read only data. The Watcher capability provides access to hardware
> sampling and tracing features. Crashlog provides access to device crash
> dumps.  While there is some relationship between capabilities (Watcher can
> be configured to sample from the Telemetry data set) each exists as stand
> alone features with no dependency on any other. The design therefore splits
> them into individual, capability specific drivers. MFD is used to create
> platform devices for each capability so that they may be managed by their
> own driver. The PMT architecture is (for the most part) agnostic to the
> type of device it can collect from. Devices nodes are consequently generic
> in naming, e.g. /dev/telem<n> and /dev/smplr<n>. Each capability driver
> creates a class to manage the list of devices supporting it.  Software can
> determine which devices support a PMT feature by searching through each
> device node entry in the sysfs class folder. It can additionally determine
> if a particular device supports a PMT feature by checking for a PMT class
> folder in the device folder.
>
> This patch set provides support for the PMT framework, along with support
> for Telemetry on Tiger Lake.
>

Some nitpicks per individual patches, also you forgot to send the
series to PDx86 mailing list and its maintainers (only me included).

> Changes from V1:
>
>         - In the telemetry driver, set the device in device_create() to
>           the parent pci device (the monitoring device) for clear
>           association in sysfs. Was set before to the platform device
>           created by the pci parent.
>         - Move telem struct into driver and delete unneeded header file.
>         - Start telem device numbering from 0 instead of 1. 1 was used
>           due to anticipated changes, no longer needed.
>         - Use helper macros suggested by Andy S.
>         - Rename class to pmt_telemetry, spelling out full name
>         - Move monitor device name defines to common header
>         - Coding style, spelling, and Makefile/MAINTAINERS ordering fixes
>
> David E. Box (3):
>   PCI: Add #defines for Designated Vendor-Specific Capability
>   mfd: Intel Platform Monitoring Technology support
>   platform/x86: Intel PMT Telemetry capability driver
>
>  MAINTAINERS                            |   6 +
>  drivers/mfd/Kconfig                    |  10 +
>  drivers/mfd/Makefile                   |   1 +
>  drivers/mfd/intel_pmt.c                | 170 ++++++++++++
>  drivers/platform/x86/Kconfig           |  10 +
>  drivers/platform/x86/Makefile          |   1 +
>  drivers/platform/x86/intel_pmt_telem.c | 362 +++++++++++++++++++++++++
>  include/linux/intel-dvsec.h            |  48 ++++
>  include/uapi/linux/pci_regs.h          |   5 +
>  9 files changed, 613 insertions(+)
>  create mode 100644 drivers/mfd/intel_pmt.c
>  create mode 100644 drivers/platform/x86/intel_pmt_telem.c
>  create mode 100644 include/linux/intel-dvsec.h
>
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
