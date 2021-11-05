Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D8A445D3D
	for <lists+linux-pci@lfdr.de>; Fri,  5 Nov 2021 02:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhKEBXp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Nov 2021 21:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbhKEBXo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Nov 2021 21:23:44 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CA2C061714
        for <linux-pci@vger.kernel.org>; Thu,  4 Nov 2021 18:21:05 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gt5so2025490pjb.1
        for <linux-pci@vger.kernel.org>; Thu, 04 Nov 2021 18:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=8BlblZNwkbcKAS2iistnQm3UAf7Ffy7cqWTYNAo60h4=;
        b=GMrUJl1+msSYfMehtGPnWry7jg7iiXw4HoUmUoMjERxr1CqPy8hJ+6ol5Yg02gffwI
         PFAhl2+Z0fggHaE3EQ7WERHF7StmMA5KMS13kEBSYcLwg5cXgxdknznk31v3cncJQ1xg
         DzGQIeh1AeXw5laDFQGCLXCpjpXZklk0+brhz8r4va0fU0bLNgYWWlaLDMhseaZPx6LB
         JluAtn7I9nwuDBtqKocsPD/mOoPhyoph2zjzr/nmFXv3i9hdSpYpmfWAZtK38OfGZD34
         tWUeDvXcxqPKPKqkDgaTowTcaKs+OZtd2ZKDzsfAPtkmB5vf2zG2dAUPJRG/bNhW15ZR
         wrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8BlblZNwkbcKAS2iistnQm3UAf7Ffy7cqWTYNAo60h4=;
        b=W5+v4NwMdlogfuoYCXuBzYuy3p+bk8cWlc9YA/XAr4vaV7qjiHhCyUblis3vXNCbaf
         w/XSj4W+nwt1ZWgMgkwh2NC1Ew3DAS/AyKG2LMqVN2Kidb6NLeA2PY17q8b70Tvp7d1f
         ZCxDLlCsdCdBtAKvA4wivixPPUNTklMuoy42zMk+o543hNUiCaliHidL2+EpOdWzxMPk
         IzxEKrS2jNIhZGVCUA2XfBNM15uuejMBPkGMfXfrUdaZaI45S5eW5lq5LzOpTYC3ZnWI
         OXFr9j5n/If+ITO2e8A8ihSKONrrfJMINXmtn5yYS5eqckyGhsVa2gRUMLRMlRfCCGP7
         xAxA==
X-Gm-Message-State: AOAM5334Ufsko8bR/ERy4xs60KFxtvio9uzfoRqJlPyXpfBANwrWkCKp
        4dM+Go8lxRK0iKYlq4oFBvKNaXTyEN2J3fKJXwMx+CUOsjId2Q==
X-Google-Smtp-Source: ABdhPJx6X4yCBHZUqPm/q0IetQzSKp48gnHuH7S3KIvG/nzBmYkpBQtyF7YVuNddtgFirDmjXpzu9EoUghp9IMOjhnQ=
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr5946350pjb.93.1636075265420;
 Thu, 04 Nov 2021 18:21:05 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 4 Nov 2021 18:20:55 -0700
Message-ID: <CAPcyv4gSGURnUvkvMyfr+SbSZikhBdyCLXVkqn_Sa8PbjtxUXQ@mail.gmail.com>
Subject: [GIT PULL] Compute Express Link update for v5.16
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-cxl@vger.kernel.org, Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-5.16

...to receive more preparation and plumbing work in the CXL subsystem.
From an end user perspective the highlight here is lighting up the CXL
Persistent Memory related commands (label read / write) with the
generic ioctl() front-end in LIBNVDIMM. Otherwise, the ability to
instantiate new persistent and volatile memory regions is still on
track for v5.17. More details in the tag message below. This has
appeared in linux-next with no reported issues.

---

The following changes since commit e4e737bb5c170df6135a127739a9e6148ee3da82:

  Linux 5.15-rc2 (2021-09-19 17:28:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-5.16

for you to fetch changes up to c6d7e1341cc99ba49df1384c8c5b3f534a5463b1:

  ocxl: Use pci core's DVSEC functionality (2021-10-29 11:53:52 -0700)

----------------------------------------------------------------
cxl for v5.16

- Fix support for platforms that do not enumerate every ACPI0016 (CXL
  Host Bridge) in the CHBS (ACPI Host Bridge Structure).

- Introduce a common pci_find_dvsec_capability() helper, clean up open
  coded implementations in various drivers.

- Add 'cxl_test' for regression testing CXL subsystem ABIs. 'cxl_test'
  is a module built from tools/testing/cxl/ that mocks up a CXL topology
  to augment the nascent support for emulation of CXL devices in QEMU.

- Convert libnvdimm to use the uuid API.

- Complete the definition of CXL namespace labels in libnvdimm.

- Tunnel libnvdimm label operations from nd_ioctl() back to the CXL
  mailbox driver. Enable 'ndctl {read,write}-labels' for CXL.

- Continue to sort and refactor functionality into distinct driver and
  core-infrastructure buckets. For example, mailbox handling is now a
  generic core capability consumed by the PCI and cxl_test drivers.

----------------------------------------------------------------
Alison Schofield (1):
      cxl/acpi: Do not fail cxl_acpi_probe() based on a missing CHBS

Ben Widawsky (10):
      Documentation/cxl: Add bus internal docs
      cxl/pci: Disambiguate cxl_pci further from cxl_mem
      cxl/pci: Convert register block identifiers to an enum
      cxl/pci: Remove dev_dbg for unknown register blocks
      cxl/pci: Remove pci request/release regions
      cxl/pci: Make more use of cxl_register_map
      cxl/pci: Split cxl_pci_setup_regs()
      PCI: Add pci_find_dvsec_capability to find designated VSEC
      cxl/pci: Use pci core's DVSEC functionality
      ocxl: Use pci core's DVSEC functionality

Dan Williams (23):
      libnvdimm/labels: Add uuid helpers
      libnvdimm/label: Add a helper for nlabel validation
      libnvdimm/labels: Introduce the concept of multi-range namespace labels
      libnvdimm/labels: Fix kernel-doc for label.h
      libnvdimm/label: Define CXL region labels
      libnvdimm/labels: Introduce CXL labels
      cxl/pci: Make 'struct cxl_mem' device type generic
      cxl/pci: Clean up cxl_mem_get_partition_info()
      cxl/mbox: Introduce the mbox_send operation
      cxl/pci: Drop idr.h
      cxl/mbox: Move mailbox and other non-PCI specific infrastructure
to the core
      cxl/pci: Use module_pci_driver
      cxl/mbox: Convert 'enabled_cmds' to DECLARE_BITMAP
      cxl/mbox: Add exclusive kernel command support
      cxl/pmem: Translate NVDIMM label commands to CXL label commands
      cxl/pmem: Add support for multiple nvdimm-bridge objects
      tools/testing/cxl: Introduce a mocked-up CXL port hierarchy
      cxl/bus: Populate the target list at decoder create
      cxl/mbox: Move command definitions to common location
      tools/testing/cxl: Introduce a mock memory device + driver
      cxl/core: Split decoder setup into alloc + add
      cxl/pci: Fix NULL vs ERR_PTR confusion
      cxl/pci: Add @base to cxl_register_map

 Documentation/driver-api/cxl/memory-devices.rst |    6 +
 arch/powerpc/platforms/powernv/ocxl.c           |    3 +-
 drivers/cxl/acpi.c                              |  139 ++-
 drivers/cxl/core/Makefile                       |    1 +
 drivers/cxl/core/bus.c                          |  119 ++-
 drivers/cxl/core/core.h                         |   11 +-
 drivers/cxl/core/mbox.c                         |  787 ++++++++++++++
 drivers/cxl/core/memdev.c                       |  118 ++-
 drivers/cxl/core/pmem.c                         |   39 +-
 drivers/cxl/cxl.h                               |   58 +-
 drivers/cxl/cxlmem.h                            |  202 +++-
 drivers/cxl/pci.c                               | 1240 ++---------------------
 drivers/cxl/pci.h                               |   14 +-
 drivers/cxl/pmem.c                              |  163 ++-
 drivers/misc/ocxl/config.c                      |   13 +-
 drivers/nvdimm/btt.c                            |   11 +-
 drivers/nvdimm/btt_devs.c                       |   14 +-
 drivers/nvdimm/core.c                           |   40 +-
 drivers/nvdimm/label.c                          |  139 ++-
 drivers/nvdimm/label.h                          |   94 +-
 drivers/nvdimm/namespace_devs.c                 |   95 +-
 drivers/nvdimm/nd-core.h                        |    5 +-
 drivers/nvdimm/nd.h                             |  185 +++-
 drivers/nvdimm/pfn_devs.c                       |    2 +-
 drivers/pci/pci.c                               |   32 +
 include/linux/nd.h                              |    4 +-
 include/linux/pci.h                             |    1 +
 tools/testing/cxl/Kbuild                        |   38 +
 tools/testing/cxl/config_check.c                |   13 +
 tools/testing/cxl/mock_acpi.c                   |  109 ++
 tools/testing/cxl/mock_pmem.c                   |   24 +
 tools/testing/cxl/test/Kbuild                   |   10 +
 tools/testing/cxl/test/cxl.c                    |  576 +++++++++++
 tools/testing/cxl/test/mem.c                    |  256 +++++
 tools/testing/cxl/test/mock.c                   |  171 ++++
 tools/testing/cxl/test/mock.h                   |   27 +
 36 files changed, 3269 insertions(+), 1490 deletions(-)
 create mode 100644 drivers/cxl/core/mbox.c
 create mode 100644 tools/testing/cxl/Kbuild
 create mode 100644 tools/testing/cxl/config_check.c
 create mode 100644 tools/testing/cxl/mock_acpi.c
 create mode 100644 tools/testing/cxl/mock_pmem.c
 create mode 100644 tools/testing/cxl/test/Kbuild
 create mode 100644 tools/testing/cxl/test/cxl.c
 create mode 100644 tools/testing/cxl/test/mem.c
 create mode 100644 tools/testing/cxl/test/mock.c
 create mode 100644 tools/testing/cxl/test/mock.h
