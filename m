Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1EA28FBE6
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 02:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733099AbgJPAMR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 20:12:17 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:37951 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733098AbgJPAMQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2020 20:12:16 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 14A6AA18;
        Thu, 15 Oct 2020 20:12:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 15 Oct 2020 20:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=fm1; bh=fMk3RXt00I7CP
        93SecoyZ67f0GRxLC1U/xxMgWPUneM=; b=SuLoxOohw7APENDhHuyez8b+QbkJ/
        ij2FDyqRIYbeOyoBh139UBLl2c4iplxWMnHG7Z8behLWi5bRiRJQePbNlJBcMvhu
        T6WNeRIZFtWKNehuDpkl1ukcXXgBc/tULLMZfrHQsYf9Nf+HYOAA00aPdRqjdr+9
        YgHwtY+pQhP6Jgjg/QIEraUFTIVjV0HUtmfkNd+Cq2hFm+Qrwi9Fmf8znsGt6NQX
        d1g9s8y++ctWJocO1ItwyJ/Gx4jB2jQ7+GcmwcT3qTtzYf1aN2HhT7ZOt/gLjqw/
        TufcdbG3rNxQQ0eZJtQWs7+/4VCsGp4OXK5m676OJQiP6b615EkKkixPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=fMk3RXt00I7CP93Se
        coyZ67f0GRxLC1U/xxMgWPUneM=; b=ZdocyKd4PflKe+Ltw1Hdi33+i/8ACJIbf
        celp0N0FswRu8sKoMurPO4gK+d4WZppgiKU15vLyRfObO3itkVhvjf3NP0fZpFuo
        fIEuWjow9TJDOAMQj2VPWsfpeOoSaaS2ThXleKH6R0vW0J03bW41K8APjwBENRMw
        a9vqmnqjod+HVgo3pW4S7atFA0CFdt/312qyuGrptZYeJOP6sLL2BMd0WqndG3oI
        qDEst2THY2XCTP4GqZcxsLJTI91EaArNPZTwQFq+2l9inUtT9vjKyAs5QLAd6gdr
        2ZlVeiOpyw2iyl43l5d98YYU4vYufWkTrJp7qgI7pY2Za7FclHvYQ==
X-ME-Sender: <xms:XeWIX1quflV0xrbmQsQBgngT5XeLLQrDaEWzEFp5OJSItamKnClM-A>
    <xme:XeWIX3o0g0ag9JBNzpi-mDjI1XNVwL9c2Qa-YmnzS6ZsDBNRM514Xjs1V0P6c7VM9
    44o739lsBoEGfvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrieeggdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpefuvggrnhcuggcumfgvlhhlvgihuceoshgvrghnvhhkrdguvghvseho
    rhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepudelleeiteettd
    duteefteejgfekgfdvieeiveejtdffteduheeihefguefhffeinecuffhomhgrihhnpehk
    vghrnhgvlhdrohhrghdptghomhhpuhhtvggvgihprhgvshhslhhinhhkrdhorhhgnecukf
    hppedvgedrvddtrddugeekrdegleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsvggrnhhvkhdruggvvhesohhrvghgohhnthhrrggtkhhsrd
    horhhg
X-ME-Proxy: <xmx:XeWIXyNM2wr-CC6T5T3KBRQDG6IikKeqPHpXYT6zS_sgfC1HOY_iMw>
    <xmx:XeWIXw5J7nQ3gsahwROZrs4IZEb6tS13UixOfedKJrEYrp1-uGwEaA>
    <xmx:XeWIX05zQ5j9jmNdGLiZ2JsxgKSuecEqEy-L2UQ0npsxYCz9Cv7c7Q>
    <xmx:XuWIXzbRamc2oobeLZhSXemqLFTvEKk2UukcmCPPcUcfEM14s89yiA>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 72AB63064680;
        Thu, 15 Oct 2020 20:12:12 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v9 00/15] Add RCEC handling to PCI/AER
Date:   Thu, 15 Oct 2020 17:10:58 -0700
Message-Id: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sean V Kelley <sean.v.kelley@intel.com>

Changes since v8 [1] and based on discussion [2] and pci/err tree [3]:

- No functional changes. Tested with aer injection.

PCI/AER: Apply function level reset to RCiEP on fatal error
- Remove. Handle with pcie_flr() directly when adding linked RCEC to AER/ERR.

PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
- Just call pcie_flr() and remove need for wrapping with flr_on_rciep(). Note it appears
 that a check on pcie_has_flr() (as also used in flr_on_rciep())relates to hardware specific
 quirks and so I've added it.
- Consolidate AER register setting in aer_root_reset() with a test for the non-native case.
With that change, simplify "state == pci_channel_io_frozen" case by removing tests for the
non-native case. Also simplify pci_walk_bridge().
(Bjorn Helgaas)

[1] https://lore.kernel.org/lkml/20201002184735.1229220-1-seanvk.dev@oregontracks.org/
[2] https://lore.kernel.org/lkml/20201009213011.GA3504871@bjorn-Precision-5520/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/err


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


Qiuxu Zhuo (4):
  PCI/RCEC: Add RCEC class code and extended capability
  PCI/RCEC: Bind RCEC devices to the Root Port driver
  PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
  PCI/AER: Add RCEC AER error injection support

Sean V Kelley (11):
  PCI/RCEC: Cache RCEC capabilities in pci_init_capabilities()
  PCI/ERR: Rename reset_link() to reset_subordinates()
  PCI/ERR: Simplify by using pci_upstream_bridge()
  PCI/ERR: Simplify by computing pci_pcie_type() once
  PCI/ERR: Use "bridge" for clarity in pcie_do_recovery()
  PCI/ERR: Avoid negated conditional for clarity
  PCI/ERR: Add pci_walk_bridge() to pcie_do_recovery()
  PCI/ERR: Limit AER resets in pcie_do_recovery()
  PCI/RCEC: Add pcie_link_rcec() to associate RCiEPs
  PCI/AER: Add pcie_walk_rcec() to RCEC AER handling
  PCI/PME: Add pcie_walk_rcec() to RCEC PME handling

 drivers/pci/pci.h               |  29 ++++-
 drivers/pci/pcie/Makefile       |   2 +-
 drivers/pci/pcie/aer.c          |  82 ++++++++++----
 drivers/pci/pcie/aer_inject.c   |   5 +-
 drivers/pci/pcie/err.c          |  93 +++++++++++-----
 drivers/pci/pcie/pme.c          |  15 ++-
 drivers/pci/pcie/portdrv_core.c |   9 +-
 drivers/pci/pcie/portdrv_pci.c  |   8 +-
 drivers/pci/pcie/rcec.c         | 190 ++++++++++++++++++++++++++++++++
 drivers/pci/probe.c             |   2 +
 include/linux/pci.h             |   5 +
 include/linux/pci_ids.h         |   1 +
 include/uapi/linux/pci_regs.h   |   7 ++
 13 files changed, 384 insertions(+), 64 deletions(-)
 create mode 100644 drivers/pci/pcie/rcec.c

--
2.28.0

