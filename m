Return-Path: <linux-pci+bounces-22820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A11C9A4D4A5
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 08:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB338175028
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 07:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD991FC0FC;
	Tue,  4 Mar 2025 07:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SxP1ebBC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A2D1FC7E1
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 07:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072515; cv=none; b=GD6HtzKJTZlzCz85EoNcliaCN3lrNq6H9sui1sFaU5m0ze9TS4GKqwFLgrIyfi90TQBnSettDNcTYXZtCnKhGqiEX3l28DGuF0Q4HO1stT9q9FjA3Uavc5andbF0NbC5S0xaRTavmP7KAx2EA7p5mBN2ibDnNRwMQ67SdPy93rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072515; c=relaxed/simple;
	bh=0nYOb9rBvOvDZ52Sipawfg+Z04xq3rRSZfGlPmWMwLY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKwgyJwHIPpBdoEzhOz6H/N9o/A0pkt50aqtA0Z2OcFdOK81wNep7aigoTNPugQu6kvkTwbFrGmd4UwK9U9CkImc/u/ufj7HAEKx3DXngo8i+Q4AJuEAVwfxSJbpKRuJO8xSohSoX6gvabPWbJvk7Q1PRDhzs4fuBEIxx+mPLYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SxP1ebBC; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741072513; x=1772608513;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0nYOb9rBvOvDZ52Sipawfg+Z04xq3rRSZfGlPmWMwLY=;
  b=SxP1ebBCi1e4MvA+Bw6kSwdZiCUhW+b9pdr0XBFQei0ad8E5+ns6FQx4
   VB1QwMWNMmoVr9vIBHTGuvr7Ygi/lH7gA1DWXw+VzycchX8rZtAFWYmvX
   IJsqH1vimL+icnMWE0Wx/NP9y3eJGRG7OLCwv2IP/Il9xE3Gx6wcxqySX
   qDIZJqmcgNpD69urVThl3UY/2+yTQxg3/ceCwFOu0LS/nOyWcguw/IYJb
   gf6R+wBB0MfDPlmwr+0Ylpqo0kTZUs0Ok3RdSF+OLCDzUKoV3kaV/2m8S
   6chGlrdkAtzXft74UQKUvVOwGACJsMKtYs0fXcZfuk7JUDXjb9etVGfHE
   A==;
X-CSE-ConnectionGUID: I2pdkfR9R5aK43eiSHZxMw==
X-CSE-MsgGUID: Ur8+rEwcTNOmtAVTD9Jevg==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="52181347"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="52181347"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:15:13 -0800
X-CSE-ConnectionGUID: DDQclEn9SBeCcZ+we2Pk8g==
X-CSE-MsgGUID: +YYI8haNTBO0MxMRunKzwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123497947"
Received: from inaky-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.109.47])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:15:13 -0800
Subject: [PATCH v2 10/11] PCI/TSM: Report active IDE streams
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev
Cc: aik@amd.com, gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
 aik@amd.com, lukas@wunner.de
Date: Mon, 03 Mar 2025 23:15:12 -0800
Message-ID: <174107251246.1288555.2482012187220793117.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
References: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Given that the platform TSM owns IDE Stream ID allocation, report the
active streams via the TSM class device. Establish a symlink from the
class device to the PCI endpoint device consuming the stream, named by
the Stream ID.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-class-tsm |   10 ++++++++++
 drivers/virt/coco/host/tsm-core.c         |   17 +++++++++++++++++
 include/linux/tsm.h                       |    4 ++++
 3 files changed, 31 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
index 7503f04a9eb9..75ee2b9bc555 100644
--- a/Documentation/ABI/testing/sysfs-class-tsm
+++ b/Documentation/ABI/testing/sysfs-class-tsm
@@ -8,3 +8,13 @@ Description:
 		signals when the PCI layer is able to support establishment of
 		link encryption and other device-security features coordinated
 		through the platform tsm.
+
+What:		/sys/class/tsm/tsm0/streamN:DDDD:BB:DD:F
+Date:		December, 2024
+Contact:	linux-pci@vger.kernel.org
+Description:
+		(RO) When a host bridge has established a secure connection via
+		the platform TSM, symlink appears. The primary function of this
+		is have a system global review of TSM resource consumption
+		across host bridges. The link points to the endpoint PCI device
+		at domain:DDDD bus:BB device:DD function:F.
diff --git a/drivers/virt/coco/host/tsm-core.c b/drivers/virt/coco/host/tsm-core.c
index 51146f226a64..bd9e09b07412 100644
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
@@ -99,6 +102,20 @@ void tsm_unregister(struct tsm_core_dev *core)
 }
 EXPORT_SYMBOL_GPL(tsm_unregister);
 
+/* must be invoked between tsm_register / tsm_unregister */
+int tsm_ide_stream_register(struct pci_dev *pdev, struct pci_ide *ide)
+{
+	return sysfs_create_link(&tsm_core->dev.kobj, &pdev->dev.kobj,
+				 ide->name);
+}
+EXPORT_SYMBOL_GPL(tsm_ide_stream_register);
+
+void tsm_ide_stream_unregister(struct pci_ide *ide)
+{
+	sysfs_remove_link(&tsm_core->dev.kobj, ide->name);
+}
+EXPORT_SYMBOL_GPL(tsm_ide_stream_unregister);
+
 static void tsm_release(struct device *dev)
 {
 	struct tsm_core_dev *core = container_of(dev, typeof(*core), dev);
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 59d3848404e1..915c4c8b061b 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -116,4 +116,8 @@ struct tsm_core_dev *tsm_register(struct device *parent,
 				  const struct attribute_group **groups,
 				  const struct pci_tsm_ops *ops);
 void tsm_unregister(struct tsm_core_dev *tsm_core);
+struct pci_dev;
+struct pci_ide;
+int tsm_ide_stream_register(struct pci_dev *pdev, struct pci_ide *ide);
+void tsm_ide_stream_unregister(struct pci_ide *ide);
 #endif /* __TSM_H */


