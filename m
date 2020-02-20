Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08FCF166720
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2020 20:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgBTT3i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Feb 2020 14:29:38 -0500
Received: from mga01.intel.com ([192.55.52.88]:16662 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbgBTT3h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Feb 2020 14:29:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 11:29:37 -0800
X-IronPort-AV: E=Sophos;i="5.70,465,1574150400"; 
   d="scan'208";a="228993647"
Received: from ykim6-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.254.188.97])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Feb 2020 11:29:36 -0800
From:   Sean V Kelley <sean.v.kelley@linux.intel.com>
To:     tglx@linutronix.de, bhelgaas@google.com, corbet@lwn.net,
        mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kar.hin.ong@ni.com, sassmann@kpanic.de,
        Sean V Kelley <sean.v.kelley@linux.intel.com>
Subject: [PATCH v2 0/2] pci: Add boot interrupt quirk mechanism for Xeon chipsets
Date:   Thu, 20 Feb 2020 11:29:28 -0800
Message-Id: <20200220192930.64820-1-sean.v.kelley@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes since v1 [1]:

- Correct Documentation section title for 6300ESB chipset.
(Jonathan Derrick)

- Use consistent abbreviations in comments for IO-APIC and Core IO.
(Andy Shevchenko)

- Retained Reviewed-by tag due to no technical changes.

[1]: https://lore.kernel.org/lkml/20200214213313.66622-1-sean.v.kelley@linux.intel.com/

Bjorn, I'm open for it to go to stable as well.

--

When IRQ lines on secondary or higher IO-APICs are masked (e.g.,
Real-Time threaded interrupts), many chipsets redirect IRQs on
this line to the legacy PCH and in turn the base IO-APIC in the
system. The unhandled interrupts on the base IO-APIC will be
identified by the Linux kernel as Spurious Interrupts and can
lead to disabled IRQ lines.

Disabling this legacy PCI interrupt routing is chipset-specific and
varies in mechanism between chipset vendors and across generations.
In some cases the mechanism is exposed to BIOS but not all BIOS
vendors chose to pick it up. With the increasing usage of RT as it
marches towards mainline, additional issues have been raised with
more recent Xeon chipsets.

This patchset disables the boot interrupt on these Xeon chipsets where
this is possible with an additional mechanism. In addition, this
patchset includes documentation covering the background of this quirk.


Sean V Kelley (2):
  pci: Add boot interrupt quirk mechanism for Xeon chipsets
  Documentation:PCI: Add background on Boot Interrupts

 Documentation/PCI/boot-interrupts.rst | 153 ++++++++++++++++++++++++++
 Documentation/PCI/index.rst           |   1 +
 drivers/pci/quirks.c                  |  80 ++++++++++++--
 3 files changed, 227 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/PCI/boot-interrupts.rst

--
2.25.1

