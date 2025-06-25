Return-Path: <linux-pci+bounces-30648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE34AE8E97
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 21:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1197F4A5710
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 19:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2745C2E11AC;
	Wed, 25 Jun 2025 19:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="i3QAqfwd"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D1D2DECC1;
	Wed, 25 Jun 2025 19:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750879553; cv=none; b=KWv2JfV9Bmeg2hWNq37HiKsp3nn5Bzg3+KRNoG/U80reujLTi5j341NGqLhCtKNy96rkyF13pRYDj59eqOhzwwWJXsOUiMAjSscW5H+1eUvwHxMbJFVwZXgUgEAPIC4/R8kpWbzDbjxDYRyqkp3jOcX53lKTW7HFxwZFhce5zYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750879553; c=relaxed/simple;
	bh=SpYaNoFuLQWANgiDdgqiC3hIWLNrLzZ2Q2sb0dWW+v8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3evVXmlE3jcbLivhEIRG5ff4SRTIJh7nrbbEmme/+N0RZXR2182C+GuCsx7Nq8Jpfoix4Tqg6qpMEsqnLECTBTsWxaUrlSv3cmw+N+xG+l93a30mJp47pBUzaBRG7q6gytIMZabKWAi7pUJVnLlHLBxn70NtEZF6BKVFCabMMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=i3QAqfwd; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 4A01566E7DB;
	Wed, 25 Jun 2025 21:25:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1750879542;
	bh=SpYaNoFuLQWANgiDdgqiC3hIWLNrLzZ2Q2sb0dWW+v8=;
	h=From:Subject:Date;
	b=i3QAqfwdIRe+7cybACpStZSjXvG925LAHKeHnzulci2mUpJ/+6H0LZh/6SEFdgsfb
	 2lVw51du5OS8X7udk8cAg6v1YvNTBFkhqRoTRQNJ4fuOgEOAoResiTLAagIJF3QKNB
	 mCeuwWMJYfBSBA3pB4gswPENHurwQW1pa0xNAqWWrUfwDkYUqjTVcHOGEVhjK2SGNu
	 mlrZc53PlbToUBs3ip725IUUdQRS2qrm69ImRsPjA7sTVVI9IFvdh9hszbWYrxPvUl
	 zwzzF13UU6KqNSHtNTDR9hZUpdZHiDoEG/jxSNaeas0kc0HK4dRKuV5kgEsjsgywv5
	 KmxCCB3dLqVng==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject:
 [PATCH v1 4/9] PM: Move pm_runtime_force_suspend/resume() under
 CONFIG_PM_SLEEP
Date: Wed, 25 Jun 2025 21:19:55 +0200
Message-ID: <2045419.usQuhbGJ8B@rjwysocki.net>
In-Reply-To: <22759968.EfDdHjke4D@rjwysocki.net>
References: <22759968.EfDdHjke4D@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 5.63.189.50
X-CLIENT-HOSTNAME: 5.63.189.50
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: dmFkZTFU16MN1onAmfTggu3iKnPYA/STqEnOhMRWZkwNQSI5OpDf+u5DT2NkIXE+Nhe4mqxr9ks7U05Tnfbp21L5zWLAY+X8uGCUnkPai/a2KG4xxKx6eBqQiVngKpLwnPSZjvR8Q4dQfv5MKNDuphWx1Et6P/rcNTpUFGeZ3Ng1C9/8uA5jpLaNlvEnYZjWpU/0SCP+rHDTsSrswgF9Mks70F5evvoz0a/MhrLqsCe8JTvEOP0IBVuaTh/K6p4bcE/yKwFXFB6GIgqfD+zcy9GvwASdPeWl27ugbAiFeVCNlB4LFehOIpnBvg5juGRVEZAUcpiQXLbFVpM3kyVvpaAi61rFsW+unJZcGgBTdmyVOetKWlTtMutgbcaXpkPNMgzBnLfGD7mQ9IO3ymCfCZn07BA0Eq/PzvhHCwj3omj001bCOx60QP8yGf82zgSGzOndLH1QvyVavoENC7wakB4UuLKu1eCtRUIvwCvvUcDJhHfVV6UduNBjwtO82olAp6HvrCL8b4+0P7KS3INlKAul9rqKQINJRaBT1JQEZ0O1eNnH6q+4l+KP6xqF+IcHNkYFGkuhatZeQrzQpdBTPf36CuGQhwRBtwhtvXqpcZmgpcwe+j+EGQLEAA7mDIwZn+qS6ZqKsNLjfRGtPLinEo5FxAh1xtpQbCxnVh/O01FDP6RWLA
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since pm_runtime_force_suspend/resume() and pm_runtime_need_not_resume()
are only used during system-wide PM transitions, there is no reason to
compile them in if CONFIG_PM_SLEEP is unset.

Accordingly, move them all under CONFIG_PM_SLEEP and make the static
inline stubs for pm_runtime_force_suspend/resume() return an error
to indicate that they should not be used outside CONFIG_PM_SLEEP.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/runtime.c |    4 ++++
 include/linux/pm_runtime.h   |   20 ++++++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1941,6 +1941,8 @@
 	pm_request_idle(link->supplier);
 }
 
+#ifdef CONFIG_PM_SLEEP
+
 bool pm_runtime_need_not_resume(struct device *dev)
 {
 	return atomic_read(&dev->power.usage_count) <= 1 &&
@@ -2063,3 +2065,5 @@
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pm_runtime_force_resume);
+
+#endif /* CONFIG_PM_SLEEP */
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -66,9 +66,6 @@
 
 extern int pm_generic_runtime_suspend(struct device *dev);
 extern int pm_generic_runtime_resume(struct device *dev);
-extern bool pm_runtime_need_not_resume(struct device *dev);
-extern int pm_runtime_force_suspend(struct device *dev);
-extern int pm_runtime_force_resume(struct device *dev);
 
 extern int __pm_runtime_idle(struct device *dev, int rpmflags);
 extern int __pm_runtime_suspend(struct device *dev, int rpmflags);
@@ -257,9 +254,6 @@
 
 static inline int pm_generic_runtime_suspend(struct device *dev) { return 0; }
 static inline int pm_generic_runtime_resume(struct device *dev) { return 0; }
-static inline bool pm_runtime_need_not_resume(struct device *dev) {return true; }
-static inline int pm_runtime_force_suspend(struct device *dev) { return 0; }
-static inline int pm_runtime_force_resume(struct device *dev) { return 0; }
 
 static inline int __pm_runtime_idle(struct device *dev, int rpmflags)
 {
@@ -330,6 +324,20 @@
 
 #endif /* !CONFIG_PM */
 
+#ifdef CONFIG_PM_SLEEP
+
+extern bool pm_runtime_need_not_resume(struct device *dev);
+extern int pm_runtime_force_suspend(struct device *dev);
+extern int pm_runtime_force_resume(struct device *dev);
+
+#else /* !CONFIG_PM_SLEEP */
+
+static inline bool pm_runtime_need_not_resume(struct device *dev) {return true; }
+static inline int pm_runtime_force_suspend(struct device *dev) { return -ENXIO; }
+static inline int pm_runtime_force_resume(struct device *dev) { return -ENXIO; }
+
+#endif /* CONFIG_PM_SLEEP */
+
 /**
  * pm_runtime_idle - Conditionally set up autosuspend of a device or suspend it.
  * @dev: Target device.




