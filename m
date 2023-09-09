Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6782279951E
	for <lists+linux-pci@lfdr.de>; Sat,  9 Sep 2023 02:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbjIIApd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Sep 2023 20:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238613AbjIIAot (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2023 20:44:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C766A4C0B;
        Fri,  8 Sep 2023 17:42:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B554FC433B9;
        Sat,  9 Sep 2023 00:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219004;
        bh=V0MImz1xAE/TyhOME1EuyZM7y0o7ZCzN2MWLmZPFMtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+R2rJcDnbT5B63IjQfAXafksffg+rF+j39gATniyLwCAOywhXbqswv6ETrtekTYf
         x+B/4JW8r/0Xf4j/djYBFP66Z5JQyKKWL/tiygeexQa4Av9OoQmZTio3rvWShfpmDU
         ZBbpG7By4LQoFumWJKaCGq3UwY9xQa2fnmW8A70J/QHb7hXjJTrwKmFIcLG3DTtlsP
         kAQ3DfeJuErBpxvQZB8dTbO+E2Fu+1JtxSbwvHRs+qJqhYaRbxgZyY1RQXj/6UxM4N
         j3iSvVFQYX/p1V64q5GdzE2bP0urmkblLnPVfKfVYlDY/vr3DSRof2FOeaopKLlb9a
         EJWugFfRF8ssA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nirmal Patel <nirmal.patel@linux.intel.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sasha Levin <sashal@kernel.org>, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 8/9] PCI: vmd: Disable bridge window for domain reset
Date:   Fri,  8 Sep 2023 20:22:59 -0400
Message-Id: <20230909002302.3578361-8-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909002302.3578361-1-sashal@kernel.org>
References: <20230909002302.3578361-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Nirmal Patel <nirmal.patel@linux.intel.com>

[ Upstream commit f73eedc90bf73d48e8368e6b0b4ad76a7fffaef7 ]

During domain reset process vmd_domain_reset() clears PCI
configuration space of VMD root ports. But certain platform
has observed following errors and failed to boot.
  ...
  DMAR: VT-d detected Invalidation Queue Error: Reason f
  DMAR: VT-d detected Invalidation Time-out Error: SID ffff
  DMAR: VT-d detected Invalidation Completion Error: SID ffff
  DMAR: QI HEAD: UNKNOWN qw0 = 0x0, qw1 = 0x0
  DMAR: QI PRIOR: UNKNOWN qw0 = 0x0, qw1 = 0x0
  DMAR: Invalidation Time-out Error (ITE) cleared

The root cause is that memset_io() clears prefetchable memory base/limit
registers and prefetchable base/limit 32 bits registers sequentially.
This seems to be enabling prefetchable memory if the device disabled
prefetchable memory originally.

Here is an example (before memset_io()):

  PCI configuration space for 10000:00:00.0:
  86 80 30 20 06 00 10 00 04 00 04 06 00 00 01 00
  00 00 00 00 00 00 00 00 00 01 01 00 00 00 00 20
  00 00 00 00 01 00 01 00 ff ff ff ff 75 05 00 00
  ...

So, prefetchable memory is ffffffff00000000-575000fffff, which is
disabled. When memset_io() clears prefetchable base 32 bits register,
the prefetchable memory becomes 0000000000000000-575000fffff, which is
enabled and incorrect.

Here is the quote from section 7.5.1.3.9 of PCI Express Base 6.0 spec:

  The Prefetchable Memory Limit register must be programmed to a smaller
  value than the Prefetchable Memory Base register if there is no
  prefetchable memory on the secondary side of the bridge.

This is believed to be the reason for the failure and in addition the
sequence of operation in vmd_domain_reset() is not following the PCIe
specs.

Disable the bridge window by executing a sequence of operations
borrowed from pci_disable_bridge_window() and pci_setup_bridge_io(),
that comply with the PCI specifications.

Link: https://lore.kernel.org/r/20230810215029.1177379-1-nirmal.patel@linux.intel.com
Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/vmd.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index d1eb17e3f1474..d4c9b888a79d7 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -526,8 +526,23 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
 				     PCI_CLASS_BRIDGE_PCI))
 					continue;
 
-				memset_io(base + PCI_IO_BASE, 0,
-					  PCI_ROM_ADDRESS1 - PCI_IO_BASE);
+				/*
+				 * Temporarily disable the I/O range before updating
+				 * PCI_IO_BASE.
+				 */
+				writel(0x0000ffff, base + PCI_IO_BASE_UPPER16);
+				/* Update lower 16 bits of I/O base/limit */
+				writew(0x00f0, base + PCI_IO_BASE);
+				/* Update upper 16 bits of I/O base/limit */
+				writel(0, base + PCI_IO_BASE_UPPER16);
+
+				/* MMIO Base/Limit */
+				writel(0x0000fff0, base + PCI_MEMORY_BASE);
+
+				/* Prefetchable MMIO Base/Limit */
+				writel(0, base + PCI_PREF_LIMIT_UPPER32);
+				writel(0x0000fff0, base + PCI_PREF_MEMORY_BASE);
+				writel(0xffffffff, base + PCI_PREF_BASE_UPPER32);
 			}
 		}
 	}
-- 
2.40.1

