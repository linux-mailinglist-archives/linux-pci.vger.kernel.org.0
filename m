Return-Path: <linux-pci+bounces-2717-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA06D8403D5
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 12:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FCA2285EE0
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 11:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA9C5C5E2;
	Mon, 29 Jan 2024 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YPY9ehdi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED17B5B5B2;
	Mon, 29 Jan 2024 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706527791; cv=none; b=DkG8Qm8CkK2rZzvnAUwBJw8Etb3BciaMpcqEAt8QZu+KS9ntZVY2WCidAQSOk7CHDpWSzZ8D5H47jE93zedpizfcU4B5ECYrXhDN0/p6KvsTchGcxq2tJIJYp/AdRHjoDeVLpg0R4nypOn+3JDmbwk9SljHsDPL98A62CgVxMVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706527791; c=relaxed/simple;
	bh=C1bZO06qv1Eiozo75zTNq7EL0T6h5w//IZNDQaGVD68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ONnMykk2rqbQeP9XbVl/txQ8XXcEMCV+RC4dUXtZF7znEMRhWKD15Pgnj5dyoljHx//CgWagZKQa2kBUmIxgMkdqPvkHU/5G1btmjlzZY9b1I+rWfyttYTmNx+qk+IHyT1kfUISVOSiGpe9TY96q/0QZBCVibS/mjx1BJkHTc9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YPY9ehdi; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706527790; x=1738063790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C1bZO06qv1Eiozo75zTNq7EL0T6h5w//IZNDQaGVD68=;
  b=YPY9ehdi779HyVu/ug4cNFRoALxjw5V+hY3VV8MRtC0KN8fUHppzqCCv
   B4x7iLNGA3XtDUx0PBvj/0roMj80r4i/ECKbiSzfox+McX6tHwjTiZ352
   FisRAyFZL9O0J3mscofoj4BfLGcmvVLq6Sib+VRcom94Onj/mPlPz183R
   CXEJGqbCwtqXpnjQTZCtKFuPpTpkf6lF9FMSgMsRQBdk55Jx028zYSXXQ
   Upi4842QMaCse9mZ4yJK0wR8wjiynnpNXCMh7VjYjdcOA81g29iUb/JnK
   nszDdKiTrX9tnmatsU1SWtZN1Mq0aKlAXDiLvtjdU7JDL89r0sTE5NOwg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="16284307"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="16284307"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 03:29:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="960868400"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="960868400"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.253.213])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 03:29:18 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/2] PCI: Do not wait for disconnected devices when resuming
Date: Mon, 29 Jan 2024 13:27:10 +0200
Message-Id: <20240129112710.2852-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240129112710.2852-1-ilpo.jarvinen@linux.intel.com>
References: <20240129112710.2852-1-ilpo.jarvinen@linux.intel.com>
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

While a device is runtime suspended along with its PCIe hierarchy, the
device could get disconnected. In such case, the link will not come up
no matter how log pci_dev_wait() waits for it.

Besides the above mentioned case, there could be other ways to get the
device disconnected while pci_dev_wait() is waiting for the link to
come up.

Make pci_dev_wait() to exit if the device is already disconnected to
avoid unnecessary delay. As disconnected device is not really even a
failure in the same sense as link failing to come up for whatever
reason, return 0 instead of errno.

Also make sure compiler does not become too clever with
dev->error_state and use READ_ONCE() to force a fetch for the
up-to-date value.

Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.c | 5 +++++
 drivers/pci/pci.h | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d8f11a078924..ec9bf6c90312 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1250,6 +1250,11 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 	for (;;) {
 		u32 id;
 
+		if (pci_dev_is_disconnected(dev)) {
+			pci_dbg(dev, "disconnected; not waiting\n");
+			return 0;
+		}
+
 		pci_read_config_dword(dev, PCI_COMMAND, &id);
 		if (!PCI_POSSIBLE_ERROR(id))
 			break;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2336a8d1edab..563a275dff67 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -4,6 +4,8 @@
 
 #include <linux/pci.h>
 
+#include <asm/rwonce.h>
+
 /* Number of possible devfns: 0.0 to 1f.7 inclusive */
 #define MAX_NR_DEVFNS 256
 
@@ -370,7 +372,7 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
 
 static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
 {
-	return dev->error_state == pci_channel_io_perm_failure;
+	return READ_ONCE(dev->error_state) == pci_channel_io_perm_failure;
 }
 
 /* pci_dev priv_flags */
-- 
2.39.2


