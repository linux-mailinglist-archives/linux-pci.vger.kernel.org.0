Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57F7E44FB2
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 00:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfFMW5X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 18:57:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60506 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727202AbfFMW5X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 18:57:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62426308624A;
        Thu, 13 Jun 2019 22:57:23 +0000 (UTC)
Received: from gimli.home (ovpn-116-190.phx2.redhat.com [10.3.116.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 918061001B17;
        Thu, 13 Jun 2019 22:57:20 +0000 (UTC)
Subject: [PATCH 2/2] PCI/IOV: Assume SR-IOV VFs support extended config
 space.
From:   Alex Williamson <alex.williamson@redhat.com>
To:     linux-pci@vger.kernel.org
Cc:     KarimAllah Ahmed <karahmed@amazon.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Hao Zheng <yinhe@linux.alibaba.com>, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, nanhai.zou@linux.alibaba.com,
        quan.xu0@linux.alibaba.com, ashok.raj@intel.com,
        keith.busch@intel.com, mike.campin@intel.com
Date:   Thu, 13 Jun 2019 16:57:20 -0600
Message-ID: <156046664016.29869.16676461736240878900.stgit@gimli.home>
In-Reply-To: <156046609596.29869.5839964168034189416.stgit@gimli.home>
References: <156046609596.29869.5839964168034189416.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 13 Jun 2019 22:57:23 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The SR-IOV specification requires both PFs and VFs to implement a PCIe
capability.  Generally this is sufficient to assume extended config
space is present, but we generally also perform additional tests to
make sure the extended config space is reachable and not simply an
alias of standard config space.  For a VF to exist extended config
space must be accessible on the PF, therefore we can also assume it to
be accessible on the VF.  This enables a micro performance
optimization previously implemented in commit 975bb8b4dc93 ("PCI/IOV:
Use VF0 cached config space size for other VFs") to speed up probing
of VFs.

Cc: KarimAllah Ahmed <karahmed@amazon.de>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Hao Zheng <yinhe@linux.alibaba.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/probe.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index a3a3c6b28343..439244ff8f09 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1561,6 +1561,21 @@ int pci_cfg_space_size(struct pci_dev *dev)
 	u32 status;
 	u16 class;
 
+#ifdef CONFIG_PCI_IOV
+	/*
+	 * Per the SR-IOV specification (rev 1.1, sec 3.5), VFs are required to
+	 * implement a PCIe capability and therefore must implement extended
+	 * config space.  We can skip the NO_EXTCFG test below and the
+	 * reachability/aliasing test in pci_cfg_space_size_ext() by virtue of
+	 * the fact that the SR-IOV capability on the PF resides in extended
+	 * config space and must be accessible and non-aliased to have enabled
+	 * support for this VF.  This is a micro performance optimization for
+	 * systems supporting many VFs.
+	 */
+	if (dev->is_virtfn)
+		return PCI_CFG_SPACE_EXP_SIZE;
+#endif
+
 	if (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_EXTCFG)
 		return PCI_CFG_SPACE_SIZE;
 

