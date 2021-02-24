Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1DE323667
	for <lists+linux-pci@lfdr.de>; Wed, 24 Feb 2021 05:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbhBXELG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Feb 2021 23:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbhBXELE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Feb 2021 23:11:04 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205BDC06178A
        for <linux-pci@vger.kernel.org>; Tue, 23 Feb 2021 20:10:23 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id n20so803742ejb.5
        for <linux-pci@vger.kernel.org>; Tue, 23 Feb 2021 20:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r0/3ywDnAOQsjA4thisasGEmCGYC07XpqLCZIebqfNw=;
        b=tCz/1aerhGbC2OIOScvpy/jeAp6NooTZ19XXPr4uuVgGRolbLZJx9RW7RLnAMplFZM
         tV/rtPtFj8NkrjKNHoIkdXr0pBCHkPMZot536PLRF2E0v5uzXWteUUm+ug38AP5Y4Tfu
         CFe9VXj0SKJaRmWpejqefdZnUyJKQCoezS67a397L3YsaMlFqsH9cg95kDVFcUxr0GQY
         bMrR2GIozSJIPKKZglc6KVyK2QEdh4N+ywq2nbMh19LhRdYzgF+VG6UrfgfTt1dJzycz
         M8aT9jhHDlRKuZDUmWdwjydWcbNgbRXL/2ePxjSXKXRqw3QObhgxIWT/MhAoEK37WAuE
         kXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r0/3ywDnAOQsjA4thisasGEmCGYC07XpqLCZIebqfNw=;
        b=hZJQ5Ip9WmJsdgATkJYRgdaMJwicMo0HjLLC4wJMV+hTl5zoWQcHP+vQEpUJi7lUww
         /rW0GxftvpEU5MAJCjSRKMPEkVJVbU17jfdQ2XM86XIIOV2VjGR5GaABofy78167y/i9
         ryBoHZbxH1MiljEEsJpfC9X5foJGJlkxK71/vNvtDBnsXPz7v9TS3IPqYdfDYppgTxwS
         iGf+1OgG2v4ZT2espJaDUmrgc3OWg7KXDNxLPwV1RZU0GjM0+BpQGSyR4/oL0+O758+X
         q+aVPZHO8kdfcDtWp2qayik67hjUc1E4E41prbrcRSyQB8qVqSFbiXGsFsOCPBlrDX8L
         JZMw==
X-Gm-Message-State: AOAM531T8w+a0CGjkUozWxTg6PkQ1+xAe5HuTiQHAkql8WMMCb/uraNn
        VTp3DmCglsCa5rvUNdPGZ+Gku1a9UMYdnQWrxY65Kg==
X-Google-Smtp-Source: ABdhPJxZ+n/CL570MXr/0CV7mjfLT6eo6BlYzfvM8j4Qn59L5vWSJUidV1w2V6VvcrdjSxwjx2l1swbyvGPHOB17Hbg=
X-Received: by 2002:a17:906:2818:: with SMTP id r24mr22949127ejc.472.1614139821753;
 Tue, 23 Feb 2021 20:10:21 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4gsXbi6Cc71wW5hob8mGuupXKkL5tHLRaZkdLZ1oAuK8Q@mail.gmail.com>
In-Reply-To: <CAPcyv4gsXbi6Cc71wW5hob8mGuupXKkL5tHLRaZkdLZ1oAuK8Q@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Feb 2021 20:10:17 -0800
Message-ID: <CAPcyv4gBoCWNDtkKRiwwBBHVEvP57mOGBJ6hmhH=oFKjEpDd9Q@mail.gmail.com>
Subject: Re: [GIT PULL] Compute Express Linux (CXL) for v5.12-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As much as I'd love to be working on "Compute Express Linux" the
subject should have read "Compute Express Link".

On Tue, Feb 23, 2021 at 8:05 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Hi Linus, please pull from:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/cxl-for-5.12
>
> ...to receive an initial driver for CXL 2.0 Memory Devices. Technical
> details are in the tag message and Documentation/. I am taking this
> through nvdimm.git this first cycle until the cxl.git repository and
> maintainer team can be set up on git.kernel.org.
>
> In terms of why merge this initial driver now, it establishes just
> enough functionality to enumerate these devices and issue all
> administrative commands. It sets a v5.12 baseline to develop the more
> complicated higher order functionality like memory device
> interleaving, persistent memory support, and hotplug which entangle
> with ACPI, LIBNVDIMM, and PCI.
>
> The focus of this release is establishing the ioctl UAPI for the
> management commands. Similar to NVME there are a set of standard
> commands as well as the possibility for vendor specific commands.
> Unlike the NVME driver the CXL driver does not enable vendor specific
> command functionality by default. This conservatism is out of concern
> for the fact that CXL interleaves memory across devices and implements
> host memory. The system integrity implications of some commands are
> more severe than NVME and vendor specific functionality is mostly
> unauditable. This will be an ongoing topic of discussion with the
> wider CXL community for next few months.
>
> The driver has been developed in the open since November against a
> work-in-progress QEMU emulation of the CXL device model. That QEMU
> effort has recently attracted contributions from multiple hardware
> vendors.
>
> The driver has appeared in -next. It collected some initial static
> analysis fixes and build-robot reports, but all quiet in -next for the
> past week.
>
> A list of review tags that arrived after the branch for -next was cut
> is appended to the tag message below.
>
> ---
>
> The following changes since commit 1048ba83fb1c00cd24172e23e8263972f6b5d9ac:
>
>   Linux 5.11-rc6 (2021-01-31 13:50:09 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/cxl-for-5.12
>
> for you to fetch changes up to 88ff5d466c0250259818f3153dbdc4af1f8615dd:
>
>   cxl/mem: Fix potential memory leak (2021-02-22 14:44:39 -0800)
>
> ----------------------------------------------------------------
> cxl for 5.12
>
> Introduce an initial driver for CXL 2.0 Type-3 Memory Devices. CXL is
> Compute Express Link which released the 2.0 specification in November.
> The Linux relevant changes in CXL 2.0 are support for an OS to
> dynamically assign address space to memory devices, support for
> switches, persistent memory, and hotplug. A Type-3 Memory Device is a
> PCI enumerated device presenting the CXL Memory Device Class Code and
> implementing the CXL.mem protocol. CXL.mem allows device to advertise
> CPU and I/O coherent memory to the system, i.e. typical "System RAM" and
> "Persistent Memory" in Linux /proc/iomem terms.
>
> In addition to the CXL.mem fast path there is an administrative command
> hardware mailbox interface for maintenance and provisioning. It is this
> command interface that is the focus of the initial driver. With this
> driver a CXL device that is mapped by the BIOS can be administered by
> Linux. Linux support for CXL PMEM and dynamic CXL address space
> management are to be implemented post v5.12.
>
> 4cdadfd5e0a7 cxl/mem: Introduce a driver for CXL-2.0-Type-3 endpoints
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>
> 8adaf747c9f0 cxl/mem: Find device capabilities
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> b39cb1052a5c cxl/mem: Register CXL memX devices
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> 13237183c735 cxl/mem: Add a "RAW" send command
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>
> 472b1ce6e9d6 cxl/mem: Enable commands via CEL
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>
> 57ee605b976c cxl/mem: Add set of informational commands
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>
> ----------------------------------------------------------------
> Ben Widawsky (7):
>       cxl/mem: Find device capabilities
>       cxl/mem: Add basic IOCTL interface
>       cxl/mem: Add a "RAW" send command
>       cxl/mem: Enable commands via CEL
>       cxl/mem: Add set of informational commands
>       MAINTAINERS: Add maintainers of the CXL driver
>       cxl/mem: Fix potential memory leak
>
> Dan Carpenter (1):
>       cxl/mem: Return -EFAULT if copy_to_user() fails
>
> Dan Williams (2):
>       cxl/mem: Introduce a driver for CXL-2.0-Type-3 endpoints
>       cxl/mem: Register CXL memX devices
>
>  .clang-format                                      |    1 +
>  Documentation/ABI/testing/sysfs-bus-cxl            |   26 +
>  Documentation/driver-api/cxl/index.rst             |   12 +
>  Documentation/driver-api/cxl/memory-devices.rst    |   46 +
>  Documentation/driver-api/index.rst                 |    1 +
>  Documentation/userspace-api/ioctl/ioctl-number.rst |    1 +
>  MAINTAINERS                                        |   11 +
>  drivers/Kconfig                                    |    1 +
>  drivers/Makefile                                   |    1 +
>  drivers/cxl/Kconfig                                |   53 +
>  drivers/cxl/Makefile                               |    7 +
>  drivers/cxl/bus.c                                  |   29 +
>  drivers/cxl/cxl.h                                  |   95 ++
>  drivers/cxl/mem.c                                  | 1552 ++++++++++++++++++++
>  drivers/cxl/pci.h                                  |   31 +
>  include/linux/pci_ids.h                            |    1 +
>  include/uapi/linux/cxl_mem.h                       |  172 +++
>  17 files changed, 2040 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-cxl
>  create mode 100644 Documentation/driver-api/cxl/index.rst
>  create mode 100644 Documentation/driver-api/cxl/memory-devices.rst
>  create mode 100644 drivers/cxl/Kconfig
>  create mode 100644 drivers/cxl/Makefile
>  create mode 100644 drivers/cxl/bus.c
>  create mode 100644 drivers/cxl/cxl.h
>  create mode 100644 drivers/cxl/mem.c
>  create mode 100644 drivers/cxl/pci.h
>  create mode 100644 include/uapi/linux/cxl_mem.h
