Return-Path: <linux-pci+bounces-17810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F2F9E607E
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 23:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D62816A7AE
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 22:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B751BBBF1;
	Thu,  5 Dec 2024 22:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ii1oimL7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93521BD51B
	for <linux-pci@vger.kernel.org>; Thu,  5 Dec 2024 22:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437457; cv=none; b=FRd4ENlXAh8cQ8gVcOzgyjrUIzzlpecNLpk54ds7kzgRYYWYlT2yjyaWAamsQLDR7SKt/WcEccuiaWkd36kJClKXwsRadNoZF384RgzSFAmvtrUHr+wL1Lk50K0tXi0JWlB4AiOTA0A13SAV8txwzLZbPjxwMbYE3/a4nk8/34Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437457; c=relaxed/simple;
	bh=MSQyo461+ACp9WGYclqMonspDGXAxbE8gwEgXJXAzT0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cfUH1aoazTr7v121SKjyWaAZ2LXKe0GkUqnqyHZ8R3QPE3mA1fjEme+gK2bv8KEB/xkUM6AYMPApWRTnRXnXM+s6p7Ia8fLy1QXQPVtLky5jG3/YWXmOnz0/FJKz+HGFds/J/VCm6uKEFA64md0Nzk21xJmFgwYM6P9MeEwTSHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ii1oimL7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733437455; x=1764973455;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MSQyo461+ACp9WGYclqMonspDGXAxbE8gwEgXJXAzT0=;
  b=ii1oimL74P9lno1WQ94MhHO9ZZI00IVMK910VttaPI2hHrasH6S6Qowu
   XwmIV7zcQO3xqpH/s0rJZO6gjW0ikWCzJpc6xqf5933Cifr3oDdwhDzn6
   Qt3gTA+aqHRHSRJ8lD6OhBCEQFIYUyFzb75a29CK08DVu2vyxu/u+NXo8
   tclhAmIsv2oI86k9u73e1F3SLzkwPKwEUNcoQWkfuRa5m9ctYAjn0WAT8
   lliXADqDW2D3RldkDkKlpN2JhtoPiL1pAcGuna4eS/J0GbVsiwXHazSsy
   coNTZpGF4s6lSNxpZ61O8UM0AOpkq/jABWv1RMaMAfQ5K/u1Qy5tH0FCF
   g==;
X-CSE-ConnectionGUID: 3LGgfSGQR9iUu7sjQH3T9g==
X-CSE-MsgGUID: C44q66+FTvicO+yg4TYRSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="44802871"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="44802871"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 14:24:15 -0800
X-CSE-ConnectionGUID: fe0Zbs9ER3exQnvrw2lNMQ==
X-CSE-MsgGUID: rI+TikyZSiCjvWmwZzn4lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="99301861"
Received: from kcaccard-desk.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.108.178])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 14:24:15 -0800
Subject: [PATCH 10/11] PCI/TSM: Report active IDE streams
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev
Cc: aik@amd.com, linux-pci@vger.kernel.org, gregkh@linuxfoundation.org
Date: Thu, 05 Dec 2024 14:24:14 -0800
Message-ID: <173343745420.1074769.13008006909323222504.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Given that the platform TSM owns IDE stream id allocation, report the
active streams via the TSM class device. Establish a symlink from the
class device to the PCI endpoint device consuming the stream, named by
the stream id.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-class-tsm |   10 ++++++++++
 drivers/virt/coco/host/tsm-core.c         |   17 +++++++++++++++++
 include/linux/tsm.h                       |    4 ++++
 3 files changed, 31 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
index 7503f04a9eb9..d6830f5f8628 100644
--- a/Documentation/ABI/testing/sysfs-class-tsm
+++ b/Documentation/ABI/testing/sysfs-class-tsm
@@ -8,3 +8,13 @@ Description:
 		signals when the PCI layer is able to support establishment of
 		link encryption and other device-security features coordinated
 		through the platform tsm.
+
+What:		/sys/class/tsm/tsm0/streamN:DDDDD:BB:DD:F
+Date:		December, 2024
+Contact:	linux-pci@vger.kernel.org
+Description:
+		(RO) When a host-bridge has established a secure connection via
+		the platform TSM, symlink appears. The primary function of this
+		is have a system global review of TSM resource consumption
+		across host bridges. The link points to the endpoint PCI device
+		at domain:DDDDD bus:BB device:DD function:F.
diff --git a/drivers/virt/coco/host/tsm-core.c b/drivers/virt/coco/host/tsm-core.c
index 21270210b03f..d78a9faf507d 100644
--- a/drivers/virt/coco/host/tsm-core.c
+++ b/drivers/virt/coco/host/tsm-core.c
@@ -2,13 +2,16 @@
 /* Copyright(c) 2024 Intel Corporation. All rights reserved. */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#define dev_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/tsm.h>
+#include <linux/pci.h>
 #include <linux/rwsem.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/cleanup.h>
 #include <linux/pci-tsm.h>
+#include <linux/pci-ide.h>
 
 static DECLARE_RWSEM(tsm_core_rwsem);
 static struct class *tsm_class;
@@ -100,6 +103,20 @@ void tsm_unregister(struct tsm_subsys *subsys)
 }
 EXPORT_SYMBOL_GPL(tsm_unregister);
 
+/* must be invoked between tsm_register / tsm_unregister */
+int tsm_register_ide_stream(struct pci_dev *pdev, struct pci_ide *ide)
+{
+	return sysfs_create_link(&tsm_subsys->dev.kobj, &pdev->dev.kobj,
+				 ide->name);
+}
+EXPORT_SYMBOL_GPL(tsm_register_ide_stream);
+
+void tsm_unregister_ide_stream(struct pci_ide *ide)
+{
+	sysfs_remove_link(&tsm_subsys->dev.kobj, ide->name);
+}
+EXPORT_SYMBOL_GPL(tsm_unregister_ide_stream);
+
 static void tsm_release(struct device *dev)
 {
 	struct tsm_subsys *subsys = container_of(dev, typeof(*subsys), dev);
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 46b9a0c6ea4e..ce95e9130436 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -116,4 +116,8 @@ struct tsm_subsys *tsm_register(struct device *parent,
 				const struct attribute_group **groups,
 				const struct pci_tsm_ops *ops);
 void tsm_unregister(struct tsm_subsys *subsys);
+struct pci_dev;
+struct pci_ide;
+int tsm_register_ide_stream(struct pci_dev *pdev, struct pci_ide *ide);
+void tsm_unregister_ide_stream(struct pci_ide *ide);
 #endif /* __TSM_H */


