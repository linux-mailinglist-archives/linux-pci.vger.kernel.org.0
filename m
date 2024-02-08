Return-Path: <linux-pci+bounces-3235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0AE84E1E8
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 14:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613B61C2650F
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 13:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E099F762EE;
	Thu,  8 Feb 2024 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NpZX0UV4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5DE763EC;
	Thu,  8 Feb 2024 13:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707398613; cv=none; b=POK7zLP10BsEvmWstPMJbeaV7cDckPuDlVWVMKE/Cwgc+CXgyXQ9VCUca2HIjxnF0HdvYniUMl7bMlCc6Acxn2NMSCpNgRE+EKaY5R7FenqxlCUFdTNNqpRcOdRLo21SEFAKoqmp2calZyr9gPjqm45F86io1DsRnIlBqw4Vr/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707398613; c=relaxed/simple;
	bh=6GyLDB0Ktv9rLaR9FABPsKSQQBcO299HdLT77EeYMjI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KRR/rfCDtb+nhf55pdPSVqfx2rM2hFwUUzNOFcG3TU1W7pijOMyTByYeHzGHtUQbLKV/iJDECJ2ZWp6vCeLHzZdcIN4RCOAA6FfH8odB9tOsQxIsv8BboR4jQ1PnUOvPPdP+tYMqIZ+SFEyZvX1dj+JdnfocQceMrmk/JpqjpN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NpZX0UV4; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707398612; x=1738934612;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6GyLDB0Ktv9rLaR9FABPsKSQQBcO299HdLT77EeYMjI=;
  b=NpZX0UV4dVJV3uHkK5ZMr3qZinr2SdsXNQNYVziMQvVxu0DKJDyK4Lz8
   F6plFLamQQ9OKHtRHU7L2WvGoDNWlD/zktF6NBTvd/fDL6jnana6DJHuu
   dukEfNHsxBQXcsHHvWZFivfIvyK2N2o6TrqpiD0P6/8isuFdjXWXSMBos
   UjIHV4tiLJDoTCk3dkh9fd5qt/eh4TQ3ztDg1PCWOCg5I4d3Q9wkhnOwM
   aLDO5VDRakZoIO5qqegiV7fGNXryY7CgP1iVsk+2SokhwEuW5xnWNqYwO
   ADvGT56MIrHXXejmQ5brGoLuT1S6xCpmXiyeQjQXfXMeUd3yiDVnGqitE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1083702"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1083702"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 05:23:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="6279804"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.52.95])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 05:23:28 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 1/1] PCI: Do not wait for disconnected devices when resuming
Date: Thu,  8 Feb 2024 15:23:21 +0200
Message-Id: <20240208132322.4811-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On runtime resume, pci_dev_wait() is called:
  pci_pm_runtime_resume()
    pci_pm_bridge_power_up_actions()
      pci_bridge_wait_for_secondary_bus()
        pci_dev_wait()

While a device is runtime suspended along with its PCI hierarchy, the
device could get disconnected. In such case, the link will not come up
no matter how long pci_dev_wait() waits for it.

Besides the above mentioned case, there could be other ways to get the
device disconnected while pci_dev_wait() is waiting for the link to
come up.

Make pci_dev_wait() to exit if the device is already disconnected to
avoid unnecessary delay.

The use cases of pci_dev_wait() boil down to two:
  1. Waiting for the device after reset
  2. pci_bridge_wait_for_secondary_bus()

The callers in both cases seem to benefit from propagating the
disconnection as error even if device disconnection would be more
analoguous to the case where there is no device in the first place
which return 0 from pci_dev_wait(). In the case 2, it results in
unnecessary marking of the devices disconnected again but that is
just harmless extra work.

Also make sure compiler does not become too clever with
dev->error_state and use READ_ONCE() to force a fetch for the
up-to-date value.

Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v2:

Sent independent of the other patch.

Return -ENOTTY instead of 0 because it aligns better with the
expecations of the reset use case and only causes unnecessary
disconnect marking in the pci_bridge_wait_for_secondary_bus()
case for devices that are already marked disconnected.

 drivers/pci/pci.c | 5 +++++
 drivers/pci/pci.h | 9 ++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ca4159472a72..14c57296a0aa 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1250,6 +1250,11 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 	for (;;) {
 		u32 id;
 
+		if (pci_dev_is_disconnected(dev)) {
+			pci_dbg(dev, "disconnected; not waiting\n");
+			return -ENOTTY;
+		}
+
 		pci_read_config_dword(dev, PCI_COMMAND, &id);
 		if (!PCI_POSSIBLE_ERROR(id))
 			break;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2336a8d1edab..58a32d2d2e96 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -4,6 +4,8 @@
 
 #include <linux/pci.h>
 
+#include <asm/rwonce.h>
+
 /* Number of possible devfns: 0.0 to 1f.7 inclusive */
 #define MAX_NR_DEVFNS 256
 
@@ -370,7 +372,12 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
 
 static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
 {
-	return dev->error_state == pci_channel_io_perm_failure;
+	/*
+	 * error_state is set in pci_dev_set_io_state() using xchg/cmpxchg()
+	 * and read w/o common lock. READ_ONCE() ensures compiler cannot cache
+	 * the value (e.g. inside the loop in pci_dev_wait()).
+	 */
+	return READ_ONCE(dev->error_state) == pci_channel_io_perm_failure;
 }
 
 /* pci_dev priv_flags */
-- 
2.39.2


