Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08DE281B3A
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 20:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387768AbgJBS4h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 14:56:37 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57941 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388291AbgJBS4h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2020 14:56:37 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id E434E5C0049;
        Fri,  2 Oct 2020 14:47:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 02 Oct 2020 14:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=fm1; bh=RB2m5O3FLxKM8
        kvAcVlLnQhGPdkPQ8GN15FhYZkptp8=; b=Yb3ClpvdCbRN3ZB030FpNIbtHzgKF
        sr74Jo2WuNCv+yYqF49JvGm7Pyb7URcDfbaNEi5Ra/d/uC7Y5ioBK9a8X9jNUAzN
        62Md06gdVpC+CYoG5Ag9wV8EtbjVLsnm1oaGCRB24LhwJ+KoWlHg9fwg0m4EBNk2
        mYeCYkduw2KsCaEa765kzugnYw62Qf4PMmtPNqI9IpBgniyGIvQtVWGUwYFcLKV7
        PMfOR+JpCrJFniC2kQndCb4OrxeVg50A+mg2K4AUUJW2tj7rjFlV7RIpvF6ljiTU
        DETMudkZ5GfvNNSW5sbqLdGHSYYpYY1zFWCr81a8u0AeEliu2jhquqgZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=RB2m5O3FLxKM8kvAc
        VlLnQhGPdkPQ8GN15FhYZkptp8=; b=SsFnX3br8Aaivm8U1jbYgXXBQgSrxbYI6
        hJSH70PR+AYHBjBCM+Gk/V04GvCMAtLbsrU0UdmFbCogz1cmwT0hsmKre1KEKTTe
        R4RND15yb+4hOYAzuf4+9EmuGLczpigDa6xwbGiBDuE7panVJWNARUF5qQuraeeH
        XRXuKEuXcQe5LZALJMsTdKuRftnKqBT17RCf/p2+oRHdLT6d2XMX1lT7Ap1/JAoq
        +FV0PzB8H+7CKb9YcuCCdMOetU8wlfVTyxYBc1aeg/DDRBVi8npSJPBRlG8RQyzW
        /srZYh+pQ++qZ1qC2bQDkqJsqAPCbqQqrCC2Hf0mqEX42HiPs4sFA==
X-ME-Sender: <xms:13V3X2WMgtdkjj1YzAPhYBDFRA4uzVoe3qCUzh3XLiq4_7Mm2spPrg>
    <xme:13V3Xymhylc2IbTCXCFtOP38xFpdkgwhgrkPxoIH0xndmcorXd3R9RAoDiZIzuKu9
    xdKWSmFJEWZGwWs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeeigdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepufgvrghnucggucfmvghllhgvhicuoehsvggrnhhvkhdruggvvhes
    ohhrvghgohhnthhrrggtkhhsrdhorhhgqeenucggtffrrghtthgvrhhnpeduleelieette
    dtudetfeetjefgkefgvdeiieevjedtffetudehieehgfeuhfffieenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgpdgtohhmphhuthgvvgigphhrvghsshhlihhnkhdrohhrghenuc
    fkphepvdegrddvtddrudegkedrgeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepshgvrghnvhhkrdguvghvsehorhgvghhonhhtrhgrtghksh
    drohhrgh
X-ME-Proxy: <xmx:13V3X6bMPYX2p2KygAE0buOO3rwrPOEffK8ZzYrCQqeAD4IeUy_U0Q>
    <xmx:13V3X9WyGCOEFSm2R0oTR-X9XGJRrHpfc_ghvY1L9FhfFIvgPR3iNw>
    <xmx:13V3XwlHz_Ah7i60O0V8SEKkW17O_TLFZ-6EjQ1VeWNxA9amZOnPTg>
    <xmx:13V3X6XHsji_usgt4sNlmvXRz3_E-_hZhLQOeiwtRJ4RRJyqScfy6g>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 17CED3064684;
        Fri,  2 Oct 2020 14:47:48 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v8 00/14] Add RCEC handling to PCI/AER
Date:   Fri,  2 Oct 2020 11:47:21 -0700
Message-Id: <20201002184735.1229220-1-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sean V Kelley <sean.v.kelley@intel.com>

Changes since v7 [1]:

- No functional changes.

- Reword bridge patch.
- Noted testing below for #non-native/no RCEC case
(Jonathan Cameron)

- Separate out pci_walk_bus() into pci_walk_bridge() change.
- Put remaining dev to bridge name changes in the separate patch from v7.
(Bjorn Helgaas)

[1] https://lore.kernel.org/lkml/20200930215820.1113353-1-seanvk.dev@oregontracks.org/

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

Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> #non-native/no RCEC


Jonathan Cameron (1):
  PCI/AER: Extend AER error handling to RCECs

Qiuxu Zhuo (5):
  PCI/RCEC: Add RCEC class code and extended capability
  PCI/RCEC: Bind RCEC devices to the Root Port driver
  PCI/AER: Apply function level reset to RCiEP on fatal error
  PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
  PCI/AER: Add RCEC AER error injection support

Sean V Kelley (8):
  PCI/RCEC: Cache RCEC capabilities in pci_init_capabilities()
  PCI/ERR: Rename reset_link() to reset_subordinate_device()
  PCI/ERR: Use "bridge" for clarity in pcie_do_recovery()
  PCI/ERR: Add pci_walk_bridge() to pcie_do_recovery()
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

