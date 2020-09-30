Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0124627F49D
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 23:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730981AbgI3V6d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 17:58:33 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:53605 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728721AbgI3V6d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 17:58:33 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id DF4B3F96;
        Wed, 30 Sep 2020 17:58:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 30 Sep 2020 17:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=fm1; bh=GonQu7bzXucOg
        tmeM8uBgrCR9M0A7oElOTDsSMc4Qkk=; b=e9S1am6GGtX9KyI2A6H9QfcyGZWnZ
        d6NFvz+EOceWqPrLaPcx0TNgLGfrrNQgQQKFQlz3+63d2auJYuGj9DQxrg9/OgMX
        08zRaKl29jCD2rdKEx6kEJwxWJ1ERcG1D+Nw6flPvbLfF0bqgv1J8HjMXYWipoMX
        yRFrBcApks28Fp8i7jp5joiFx6goG9Kf2He+aLlzjTVZd++9uEtpMAl6A61oFw6X
        PWQTC4mc0LFFWZL138wCRp3ZgUTJAWMIQ19uWRmTlx61u+a4sjnkG1JdDNOaC4o5
        Ms52Z0dAEbH3il+D7cAZxlkUOW0vxivlgGnfpW6CUQ0b+rZuqRfJC//5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=GonQu7bzXucOgtmeM
        8uBgrCR9M0A7oElOTDsSMc4Qkk=; b=ukuByqoA4vJ0ci+TXJXtAn8JD2JvtYWVH
        TK1OYE1W7bDA6ImPd9TUlYZDas6cVdttZgAzCQ7LcAVtsHPG8YQ6ahQYmv3Omc0u
        um7nXLXqbgZRJ2yJWocOXho9CP/vOy8o+zfPKi/CPi8Md7OkhG/0/qWrZAWeUI6n
        6vR+fVvkkRtOTuja2JBwXWESOamFAyxzp0FtjGKh9eZXGMtDmRF4fzWemMkpAa9W
        6jcWJIalaO9xSu6w5U/deOkTA2LyWsreKulIhAY7jeS5pv7QTLaWl52T8oPOGwPK
        G7oQ/T7cMcFYLF3ohNRHy5eTNNBI7hJYCDFDxCudC3+1zPyiFKl5A==
X-ME-Sender: <xms:hv90X5NUvyJgRlFIvjhrcrqNQzY_13ake8YbeH7WB6iBoG9h3hSA2w>
    <xme:hv90X78w7Wpj04zbNsRy3RaGl-pcFdhYytJmxmAoYzPUdgmO8bS8vCP-2MrRXRXGr
    7Si5J9fcgaX1cU0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpefuvggrnhcuggcumfgvlhhlvgihuceoshgvrghnvhhkrdguvghvseho
    rhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepudelleeiteettd
    duteefteejgfekgfdvieeiveejtdffteduheeihefguefhffeinecuffhomhgrihhnpehk
    vghrnhgvlhdrohhrghdptghomhhpuhhtvggvgihprhgvshhslhhinhhkrdhorhhgnecukf
    hppedvgedrvddtrddugeekrdegleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsvggrnhhvkhdruggvvhesohhrvghgohhnthhrrggtkhhsrd
    horhhg
X-ME-Proxy: <xmx:hv90X4SzPSqXm_1SKjNLdFbU26QuIJ8vJThrNcSitVJB6sbF9w3JRQ>
    <xmx:hv90X1tzIaYtRBIFIEB1x0E6-JcGVXH7nnUN1mbJ-rc6UxgZWJ7sHg>
    <xmx:hv90XxekCUizlX974PEBy3JwwlzG7PD6WuRBolkYvTsPtinVr7Semg>
    <xmx:h_90X7tokKlR0-AIWsRO3u-BoB6HjAzEPVEKL6TscaIRpn4R0en9YA>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 779773280063;
        Wed, 30 Sep 2020 17:58:28 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v7 00/13] Add RCEC handling to PCI/AER
Date:   Wed, 30 Sep 2020 14:58:07 -0700
Message-Id: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sean V Kelley <sean.v.kelley@intel.com>

Changes since v6 [1]:

- Remove unused includes in rcec.c.
- Add local variable for dev->rcec_ea.
- If no valid capability version then just fill in nextbusn = 0xff.
- Leave a blank line after pci_rcec_init(dev).
- Reword commit w/ "Attempt to do a function level reset for an RCiEP on fatal error."
- Change An RCiEP found on bus in range -> An RCiEP found on a different bus in range
- Remove special check on capability version if you fill in nextbusn = 0xff.
- Remove blank lines in pcie_link_rcec header.
- Fix indentation aer.c.
(Jonathan Cameron)

- Relocate enabling of PME for RCECs to later RCEC handling additions to PME.
- Rename rcec_ext to rcec_ea.
- Remove rcec_cap as its use can be handled with rcec_ea.
- Add a forward declaration for struct rcec_ea.
- Rename pci_bridge_walk() to pci_walk_bridge() to match consistency with other usage.
- Separate changes to "reset_subordinate_devices" because it doesn't change the interface.
- Separate the use of "type", rename of "dev" to "bridge", the inversion of the condition and
use of pci_upstream_bridge() instead of dev->bus->self.
- Separate the conditional check (TYPE_ROOT_PORT and TYPE_DOWNSTREAM) for AER resets.
- Consider embedding RCiEP's parent RCEC in the rcec_ea struct. However, the
issue here is that we don't normally allocate the rcec_ea struct for RCiEPs and
the linkage of rcec_ea->rcec is not necessarily more clear.
- Provide more comment on the non-native case for clarity.
(Bjorn Helgaas)

[1] https://lore.kernel.org/linux-pci/20200922213859.108826-1-seanvk.dev@oregontracks.org/

Root Complex Event Collectors (RCEC) provide support for terminating error
and PME messages from Root Complex Integrated Endpoints (RCiEPs).  An RCEC
resides on a Bus in the Root Complex. Multiple RCECs can in fact reside on
a single bus. An RCEC will explicitly declare supported RCiEPs through the
Root Complex Endpoint Association Extended Capability.

(See PCIe 5.0-1, sections 1.3.2.3 (RCiEP), and 7.9.10 (RCEC Ext. Cap.))

The kernel lacks handling for these RCECs and the error messages received
from their respective associated RCiEPs. More recently, a new CPU
interconnect, Compute eXpress Link (CXL) depends on RCEC capabilities for
purposes of error messaging from CXL 1.1 supported RCiEP devices.

DocLink: https://www.computeexpresslink.org/

This use case is not limited to CXL. Existing hardware today includes
support for RCECs, such as the Denverton microserver product
family. Future hardware will be forthcoming.

(See Intel Document, Order number: 33061-003US)

So services such as AER or PME could be associated with an RCEC driver.
In the case of CXL, if an RCiEP (i.e., CXL 1.1 device) is associated with a
platform's RCEC it shall signal PME and AER error conditions through that
RCEC.

Towards the above use cases, add the missing RCEC class and extend the
PCIe Root Port and service drivers to allow association of RCiEPs to their
respective parent RCEC and facilitate handling of terminating error and PME
messages.


Jonathan Cameron (1):
  PCI/AER: Extend AER error handling to RCECs

Qiuxu Zhuo (5):
  PCI/RCEC: Add RCEC class code and extended capability
  PCI/RCEC: Bind RCEC devices to the Root Port driver
  PCI/AER: Apply function level reset to RCiEP on fatal error
  PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
  PCI/AER: Add RCEC AER error injection support

Sean V Kelley (7):
  PCI/RCEC: Cache RCEC capabilities in pci_init_capabilities()
  PCI/ERR: Rename reset_link() to reset_subordinate_device()
  PCI/ERR: Use "bridge" for clarity in pcie_do_recovery()
  PCI/ERR: Limit AER resets in pcie_do_recovery()
  PCI/RCEC: Add pcie_link_rcec() to associate RCiEPs
  PCI/AER: Add pcie_walk_rcec() to RCEC AER handling
  PCI/PME: Add pcie_walk_rcec() to RCEC PME handling

 drivers/pci/pci.h               |  25 ++++-
 drivers/pci/pcie/Makefile       |   2 +-
 drivers/pci/pcie/aer.c          |  36 ++++--
 drivers/pci/pcie/aer_inject.c   |   5 +-
 drivers/pci/pcie/err.c          | 109 +++++++++++++++----
 drivers/pci/pcie/pme.c          |  15 ++-
 drivers/pci/pcie/portdrv_core.c |   8 +-
 drivers/pci/pcie/portdrv_pci.c  |   8 +-
 drivers/pci/pcie/rcec.c         | 187 ++++++++++++++++++++++++++++++++
 drivers/pci/probe.c             |   2 +
 include/linux/pci.h             |   5 +
 include/linux/pci_ids.h         |   1 +
 include/uapi/linux/pci_regs.h   |   7 ++
 13 files changed, 367 insertions(+), 43 deletions(-)
 create mode 100644 drivers/pci/pcie/rcec.c

--
2.28.0

