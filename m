Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28883AAC02
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 21:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731653AbfIETby (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 15:31:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731375AbfIETby (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Sep 2019 15:31:54 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6EC920825;
        Thu,  5 Sep 2019 19:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567711913;
        bh=vpEUxGMHAf/IZKdEnN0AVHGhOIJh13hxhGq6QD32AIA=;
        h=From:To:Cc:Subject:Date:From;
        b=mtmNm4f2C3bDvKw/fOPXkcLy+qSsyhoU9NqZWjS31GG7Ptsq9B2CjabHulSzRZGfv
         H5Iofq355Tn744bFe3o/bBKkN7dPMjsxCM3Ibe8xZxrBdd8LqLqYnYAGGOOTWVsmb4
         A2opSfWJR8YlCIULz+Vf+2De5mz52GjDb5y5mzJM=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v8 0/5] Fix PF/VF dependency issue
Date:   Thu,  5 Sep 2019 14:31:41 -0500
Message-Id: <20190905193146.90250-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The current implementation of ATS, PASID, and PRI does not handle VF
dependencies correctly.  These are essentially Kuppuswamy's patches; I
reordered and tweaked them slightly.

Please treat this as a proposal, not a done deal, and post a v9 with any
changes needed.

Changes since v7:
 * Moved PRI & PASID capability offset caching to last since they're just
   optimizations
 * Cached offsets at first use instead of adding _init() functions
 * Dropped complicated pci_prg_resp_pasid_required() #ifdefs by just
   searching for the capability again
 * Dropped EA/VF validation since it only enforces spec language without
   fixing any known issues

Changes since v6:
 * Removed locking interfaces used in v6.
 * Made necessary changes to PRI/PASID enable/disable calls to allow
   register changes only for PF.

Changes since v5:
 * Created new patches for PRI/PASID capability caching.
 * Removed individual locks (pri_lock, pasid_lock) and added common
   resource lock to synchronize PRI/PASID updates between PF/VF.
 * Addressed comments from Bjorn Helgaas.

Changes since v4:
 * Defined empty functions for pci_pri_init() and pci_pasid_init() for cases
   where CONFIG_PCI_PRI and CONFIG_PCI_PASID are not enabled.

Changes since v3:
 * Fixed critical path (lock context) in pci_restore_*_state functions.

Changes since v2:
 * Added locking mechanism to synchronize accessing PF registers in VF.
 * Removed spec compliance checks in patches.
 * Addressed comments from Bjorn Helgaas.

Changes since v1:
 * Added more details about the patches in commit log.
 * Removed bulk spec check patch.
 * Addressed comments from Bjorn Helgaas.


Link: https://lore.kernel.org/r/cover.1567029860.git.sathyanarayanan.kuppuswamy@linux.intel.com v7

Kuppuswamy Sathyanarayanan (5):
  PCI/ATS: Handle sharing of PF PRI Capability with all VFs
  PCI/ATS: Handle sharing of PF PASID Capability with all VFs
  PCI/ATS: Disable PF/VF ATS service independently
  PCI/ATS: Cache PRI Capability offset
  PCI/ATS: Cache PASID Capability offset

 drivers/pci/ats.c   | 153 +++++++++++++++++++++++++++-----------------
 include/linux/pci.h |   3 +-
 2 files changed, 96 insertions(+), 60 deletions(-)

-- 
2.23.0.187.g17f5b7556c-goog

