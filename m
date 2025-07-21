Return-Path: <linux-pci+bounces-32681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2BFB0CC35
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 23:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 947474E0A37
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 21:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE99221CFF7;
	Mon, 21 Jul 2025 21:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RjkBt0a4"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7072F1EF1D;
	Mon, 21 Jul 2025 21:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753131770; cv=none; b=fNirNFGii+OQH74JhHyzeiTB+uECvoQjFah1ze8B1m+tCNvK7HkyNLH3khZ16Cqrpu8E/NsuwRNTbvcc0BG4KSoniNmduiy3PpVL8J3wSwI60eF3zemssQX+njhDE9SjeF/jo20By0GWguuTgWzySRTrbCCNSh2F4p+5aiJQXRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753131770; c=relaxed/simple;
	bh=lSpQx8D4VoURK3nnjS7TYrRz/CrTJFqHgoyB1zknSXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gpiQiPx1aySO3zaUyw1zVh1sWZJLLYrKbakteIbUOJvDuuHczc31mEqXdGNzYKvo2t7bWyoGg77NbGeA06QLFmTshNxY7ynFJVIxOcr1bBjnHDaRGOkpwphSnFpIE7oZcKIYJXZUOqXAzsTUXknTScSrte2QDp6G+yEl2BlnN/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RjkBt0a4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=3jSH3ed/jUKX8oQ6UVD0EGItdU0umOCgN4agARwNL60=; b=RjkBt0a4Nk5NuO/kHT9njCEMdr
	oB3XwgejdhJdM3aspTS6KNImo3EeuGNDcaUQTdo8ccpS7RN+GfFeMgT6GHqjxnu1iBPmKkjr6YLjx
	2nC5noGW8F4vVD7P4L8KPrdEFeIB9Fh4nfIWtUq3UN0NvYIgXl2v/NOty/35T8fNnAToFovy7f7y0
	p++3CPXCBBe6BI2ERnKfG1PpCiTkfWulCVmFYg51bUwfc0EvZ0tiCJMGw6EIe2DmaQG71RstdUH8a
	Lja5yH8wDIaT5F8gf59bnLpXL3YtRYEU+smhHv0LuzBQRPdX0KhsVx6ZvrHOdopWBj1ZqNaFv3pOn
	46QBpuWQ==;
Received: from [50.53.25.54] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udxeq-00000000gvC-3Edt;
	Mon, 21 Jul 2025 21:02:48 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI/sysfs: hide boot_display definition when VIDEO=n
Date: Mon, 21 Jul 2025 14:02:37 -0700
Message-ID: <20250721210248.267962-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When CONFIG_VIDEO is not set, defining the 'boot_display' attribute
causes build errors/warnings, so hide the declaration as is done with
other code that uses this variable. Bracket unused code inside
#ifdef CONFIG_VIDEO/#endif to prevent other build warnings/errors.

include/linux/device.h:199:33: warning: 'dev_attr_boot_display' defined but not used [-Wunused-variable]
  199 |         struct device_attribute dev_attr_##_name = __ATTR_RO(_name)
drivers/pci/pci-sysfs.c:688:8: note: in expansion of macro 'DEVICE_ATTR_RO'
  688 | static DEVICE_ATTR_RO(boot_display);

drivers/pci/pci-sysfs.c:683:16: warning: ‘boot_display_show’ defined but not used [-Wunused-function]
  683 | static ssize_t boot_display_show(struct device *dev,
      |                ^~~~~~~~~~~~~~~~~

Fixes: c4f2dc1e5293c ("PCI: Add a new 'boot_display' attribute")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org

Also, a question:
What does this do in pci-sysfs.c?
#ifndef ARCH_PCI_DEV_GROUPS
#define ARCH_PCI_DEV_GROUPS
#endif
Is there some hidden macro (probably using string concatenation)
that uses this define value? Thanks.

 drivers/pci/pci-sysfs.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-next-20250721.orig/drivers/pci/pci-sysfs.c
+++ linux-next-20250721/drivers/pci/pci-sysfs.c
@@ -680,12 +680,15 @@ const struct attribute_group *pcibus_gro
 	NULL,
 };
 
+#ifdef CONFIG_VIDEO
 static ssize_t boot_display_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
 	return sysfs_emit(buf, "1\n");
 }
+
 static DEVICE_ATTR_RO(boot_display);
+#endif
 
 static ssize_t boot_vga_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)

