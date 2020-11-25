Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F7B2C3B94
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 10:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgKYJHi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 04:07:38 -0500
Received: from mga01.intel.com ([192.55.52.88]:35359 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgKYJHh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Nov 2020 04:07:37 -0500
IronPort-SDR: 1tsgFErB55rAfAgLAxleQWTGGc+F/wX2W4E/NQvIShwEfmT2GCCunshObER2v9sRo7LoG/DyX0
 MdBaT4S1NUqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="190232552"
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="190232552"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 01:07:36 -0800
IronPort-SDR: uphSjmss0FpqTYsyXOuLSMrDORa1j2u2mEL8rKRoS5mzno3l3bF8fUT8+uva96xlJhbri//3qg
 qX5VzwY4vrUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="332907488"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 25 Nov 2020 01:07:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 6EDD8133; Wed, 25 Nov 2020 11:07:33 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Lukas Wunner <lukas@wunner.de>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Utkarsh Patel <utkarsh.h.patel@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 1/2] PCI/PM: Do not generate wakeup event when runtime resuming bus
Date:   Wed, 25 Nov 2020 12:07:32 +0300
Message-Id: <20201125090733.77782-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When a PCI bridge is runtime resumed from D3cold the underlying bus is
walked and the attached devices are runtime resumed as well. However, in
addition to that we also generate a wakeup event for these devices even
though this actually is not a real wakeup event coming from the
hardware.

Normally this does not cause problems but when combined with
/sys/power/wakeup_count like using the steps below:

  # count=$(cat /sys/power/wakeup_count)
  # echo $count > /sys/power/wakeup_count
  # echo mem > /sys/power/state

The system suspend cycle might fail at this point if a PCI bridge that
was runtime suspended (D3cold) was runtime resumed for any reason. The
runtime resume calls pci_wakeup_bus() and that generates wakeup event
increasing wakeup_count.

Since this is not a real wakeup event we can prevent the above from
happening by removing the call to pci_wakeup_event() in
pci_wakeup_bus().

Reported-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
Previous version can be found here:

  https://www.spinics.net/lists/linux-pci/msg101083.html

Changes from the previous version:

  - Split the patch in two. The second patch only does the rename.
  - Tried to improve the commit message a bit
  - Added Rafael's reviewed-by tag

 drivers/pci/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e578d34095e9..6f7b33998fbe 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1181,7 +1181,6 @@ EXPORT_SYMBOL_GPL(pci_platform_power_transition);
  */
 static int pci_wakeup(struct pci_dev *pci_dev, void *ign)
 {
-	pci_wakeup_event(pci_dev);
 	pm_request_resume(&pci_dev->dev);
 	return 0;
 }
-- 
2.29.2

