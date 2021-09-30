Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE5241D0D0
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 03:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344792AbhI3BHL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 21:07:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:24479 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236932AbhI3BHK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Sep 2021 21:07:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="212330099"
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="212330099"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 18:05:28 -0700
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="521027353"
Received: from yzhu3-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.37.25])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 18:05:27 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 0/6] Add device filter support
Date:   Wed, 29 Sep 2021 18:05:05 -0700
Message-Id: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently bus drivers like USB, Thunderbolt implement a custom
version of the device "authorize" support to selectively
allow/dis-allow device driver probing. This is used to avoid
attacks by untrusted devices on unhardened drivers (i.e. drivers that
do not expect malicious hardware). For confidential computing, like
Intel TDX, a similar policy is needed because a confidential guest
doesn't trust the host's devices. This patch kit attempts to unify the
support for both.

In the v1 version, we have submitted a proposal for a driver filter
framework. But Greg asked us not to re-invent the wheel and reuse the
authorized support from USB and Thunderbolt drivers. This patch series
fixes this issue. You can find v1 version and related discussion in the
following link
(https://lore.kernel.org/lkml/YQrXhnHJCsTxiRcP@casper.infradead.org/T/)

Please note that the following patches have dependency on TDX
patches [1] and Confidential Computing support patches  [2] from Tom
Landecky. Mainly, dependency lies in usage of functions like
tdx_early_init(), cc_platform_has(), etc. So they will be merged along
with other TDX patches via x86 tree. But we have included it here for
review and to give the complete picture on how device filter support
is used.

  x86/tdx: Add device filter support for x86 TDX guest platform
  PCI: Initialize authorized attribute for confidential guest
  virtio: Initialize authorized attribute for confidential guest

We are expecting to merge only following patches through the driver core
process.

  driver core: Move the "authorized" attribute from USB/Thunderbolt to
  core
  driver core: Add common support to skip probe for un-authorized
  devices
  driver core: Allow arch to initialize the authorized attribute

[1] - https://lore.kernel.org/lkml/20210916183550.15349-1-sathyanarayanan.kuppuswamy@linux.intel.com/
[2] - https://lkml.org/lkml/2021/9/28/1143

Changes since v1:
 * Unified authorized support in driver core and added support for device
   filter.
 * Included the authorized attribute use case support (TDX device filter support)
   in this patch series.

Kuppuswamy Sathyanarayanan (6):
  driver core: Move the "authorized" attribute from USB/Thunderbolt to
    core
  driver core: Add common support to skip probe for un-authorized
    devices
  driver core: Allow arch to initialize the authorized attribute
  virtio: Initialize authorized attribute for confidential guest
  x86/tdx: Add device filter support for x86 TDX guest platform
  PCI: Initialize authorized attribute for confidential guest

 arch/x86/include/asm/tdx.h      |  9 ++++++
 arch/x86/kernel/Makefile        |  2 +-
 arch/x86/kernel/cc_platform.c   | 20 ++++++++++++
 arch/x86/kernel/cpu/intel.c     |  1 +
 arch/x86/kernel/tdx-filter.c    | 56 +++++++++++++++++++++++++++++++++
 arch/x86/kernel/tdx.c           |  2 ++
 drivers/base/core.c             |  7 +++++
 drivers/base/dd.c               |  5 +++
 drivers/pci/probe.c             |  4 +++
 drivers/thunderbolt/domain.c    |  7 +++--
 drivers/thunderbolt/icm.c       |  9 +++---
 drivers/thunderbolt/switch.c    | 18 +++++------
 drivers/thunderbolt/tb.c        |  2 +-
 drivers/thunderbolt/tb.h        |  2 --
 drivers/usb/core/driver.c       |  3 +-
 drivers/usb/core/generic.c      |  2 +-
 drivers/usb/core/hub.c          |  8 ++---
 drivers/usb/core/message.c      |  2 +-
 drivers/usb/core/sysfs.c        |  3 +-
 drivers/usb/core/usb.c          | 10 +++++-
 drivers/virtio/virtio.c         |  9 ++++++
 include/linux/cc_platform.h     | 10 ++++++
 include/linux/device.h          | 16 +++++++++-
 include/linux/device/bus.h      |  4 +++
 include/linux/usb.h             |  6 ----
 include/uapi/linux/virtio_ids.h |  8 +++++
 26 files changed, 187 insertions(+), 38 deletions(-)
 create mode 100644 arch/x86/kernel/tdx-filter.c

-- 
2.25.1

