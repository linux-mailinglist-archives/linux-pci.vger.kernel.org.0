Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4E522E9ED
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 12:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgG0KYA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 06:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgG0KX7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jul 2020 06:23:59 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8B6C061794;
        Mon, 27 Jul 2020 03:23:59 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id lw1so1061886pjb.1;
        Mon, 27 Jul 2020 03:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZAJGKAnga8wUpgRoEi+tan8Djz516wktbKcW6mwyua8=;
        b=dhEUeIQw+3R4YXV12HUzPFXyzG8dBLIVThgI+T020YJw5GYKkIcQqV4JDX604Yfeii
         Wx5WwhV3rYUOz9E3FyvYVL1KCuCJ8EUxTYPfToYrUAmKh40P/V1niKtPsDwtJspf0Jar
         L813Dza1IGBUbxuUQiPvRub5sFclmP/orXtWqQHmdxztu59/cWrNqvm8i0QkLYXPerKm
         Y9iuVPZtvdgPiypRfmr1KScp8x9F4zsxu2w5PY73Bn7F7LHwZHbAhPF0E7TZYVeESAvW
         WMXVJMEVc27RRHZRV+4WiP6CZLyoJebsb1AVAv2Qzfe6vaRZ5d9EktUoteIt8usPmsh2
         t8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZAJGKAnga8wUpgRoEi+tan8Djz516wktbKcW6mwyua8=;
        b=r9k1iILusgDWFOE2ICoph67hNyJE3P42qzf94Wv6zDbm79mBVJvjfbp36V3jOvWjdk
         0hKsS/tBlocdVSnJwqq0VkbB3Ugx7ASgyFY5ke3M7aZWSlkrzB06VNSo+fxZbfH6U3j4
         LFzFEKynAR59OwDkyGYP9T+WunB5PUPZ71+TkiSYExJUBwtD7tduIhE5S7t+wVNZ/DwI
         fWc7f7oM3/VhdlTnIje3oIFB/sB2by1a+vhR8JlgQDfrQd/VSP/japwtwNl0gN0hgo7w
         KXQhk2vE/hqfvhDvNgDQJlTyBVqoqSpO2TAz95HPavwocQ4Bv9ykxGPSKQ36Ni4S635y
         rP/A==
X-Gm-Message-State: AOAM531qIzyQlMbppIl1g+O9VTqxT8RWw6jK1xQH6ElNjnNBVPnQ/kX6
        GNVGSbjqp4UbBUeqN7cPEJKFS3rh16HvZBpicLujlRkf
X-Google-Smtp-Source: ABdhPJzH5cBHaWc793+UJPfg3Pf+4+gPEASjJ7Pi4ebUrJ8ymiJ0sAYKFnLBWG/8i+tmrgphKhSIvyHPPcXsch+sPMQ=
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr15795672pjp.228.1595845439142;
 Mon, 27 Jul 2020 03:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200714062323.19990-1-david.e.box@linux.intel.com> <20200717190620.29821-1-david.e.box@linux.intel.com>
In-Reply-To: <20200717190620.29821-1-david.e.box@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 27 Jul 2020 13:23:44 +0300
Message-ID: <CAHp75VftSf8pzSAYMjcKg-MSiy0T4xG=wiKpgY20_ZKOO0Tq0w@mail.gmail.com>
Subject: Re: [PATCH V4 0/3] Intel Platform Monitoring Technology
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 17, 2020 at 10:05 PM David E. Box
<david.e.box@linux.intel.com> wrote:
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

I assume this goes thru MFD tree.

> Changes from V3:
>         - Write out full acronym for DVSEC in PCI patch commit message and
>           add 'Designated' to comments
>         - remove unused variable caught by kernel test robot <lkp@intel.com>
>         - Add required Co-developed-by signoffs, noted by Andy
>         - Allow access using new CAP_PERFMON capability as suggested by
>           Alexey Bundankov
>         - Fix spacing in Kconfig, noted by Randy
>         - Other style changes and fixups suggested by Andy
>
> Changes from V2:
>         - In order to handle certain HW bugs from the telemetry capability
>           driver, create a single platform device per capability instead of
>           a device per entry. Add the entry data as device resources and
>           let the capability driver manage them as a set allowing for
>           cleaner HW bug resolution.
>         - Handle discovery table offset bug in intel_pmt.c
>         - Handle overlapping regions in intel_pmt_telemetry.c
>         - Add description of sysfs class to testing ABI.
>         - Don't check size and count until confirming support for the PMT
>           capability to avoid bailing out when we need to skip it.
>         - Remove unneeded header file. Move code to the intel_pmt.c, the
>           only place where it's needed.
>         - Remove now unused platform data.
>         - Add missing header files types.h, bits.h.
>         - Rename file name and build options from telem to telemetry.
>         - Code cleanup suggested by Andy S.
>         - x86 mailing list added.
>
> Changes from V1:
>         - In the telemetry driver, set the device in device_create() to
>           the parent PCI device (the monitoring device) for clear
>           association in sysfs. Was set before to the platform device
>           created by the PCI parent.
>         - Move telem struct into driver and delete unneeded header file.
>         - Start telem device numbering from 0 instead of 1. 1 was used
>           due to anticipated changes, no longer needed.
>         - Use helper macros suggested by Andy S.
>         - Rename class to pmt_telemetry, spelling out full name
>         - Move monitor device name defines to common header
>         - Coding style, spelling, and Makefile/MAINTAINERS ordering fixes
>
> David E. Box (3):
>   PCI: Add defines for Designated Vendor-Specific Extended Capability
>   mfd: Intel Platform Monitoring Technology support
>   platform/x86: Intel PMT Telemetry capability driver
>
>  .../ABI/testing/sysfs-class-pmt_telemetry     |  46 ++
>  MAINTAINERS                                   |   6 +
>  drivers/mfd/Kconfig                           |  10 +
>  drivers/mfd/Makefile                          |   1 +
>  drivers/mfd/intel_pmt.c                       | 215 +++++++++
>  drivers/platform/x86/Kconfig                  |  10 +
>  drivers/platform/x86/Makefile                 |   1 +
>  drivers/platform/x86/intel_pmt_telemetry.c    | 448 ++++++++++++++++++
>  include/uapi/linux/pci_regs.h                 |   5 +
>  9 files changed, 742 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-pmt_telemetry
>  create mode 100644 drivers/mfd/intel_pmt.c
>  create mode 100644 drivers/platform/x86/intel_pmt_telemetry.c
>
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
