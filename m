Return-Path: <linux-pci+bounces-25842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE91A885C6
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 16:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36AD55613D7
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 14:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1B627FD7A;
	Mon, 14 Apr 2025 14:25:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D9D27F744
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640731; cv=none; b=hySYZNwPeXsPAOKxYRmqcdFDqbJMHB8Wn+4IAzpibOXnCOEkq7roCfXDFPudafGkz942CQRCapTZXvC5q0uA7L9Iduah1Vp24G/KsUA7Fx0fgGQPr2Z95u7cCPW8W7zA5kK9rNXeRZyJgZJCIK9NPzk59IJpy7kaNb9cIg5LluQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640731; c=relaxed/simple;
	bh=6aWmQkbtr0/PqPkn3ZQz0hfhf98gpgWaNTvtlVZ0xSs=;
	h=Message-Id:From:Date:Subject:To:Cc; b=Cyzi+wkL4uqiz5ggyy3fwGmvqVBKIpeq9K0p/4QPsLobN16BVya6u4byqyrbgw9m8jWfCHPUkAu44v27iy8VwLpAFl/nClW71Klauq2fi+ir7IG2Gl0RkE6gLvnQvDldwyDUqBV2kiMoScQ/qk7WQ40hqJ2fC3FTuCy2tHcqaO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id A1A772C0524A;
	Mon, 14 Apr 2025 16:25:15 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 76FAC4D321; Mon, 14 Apr 2025 16:25:25 +0200 (CEST)
Message-Id: <c19e25bf2cefecc14e0822c6a9bb3a7f546258bc.1744640331.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 14 Apr 2025 16:25:21 +0200
Subject: [PATCH] PCI: hotplug: Drop superfluous #include directives
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

In February 2003, historic commit

  https://git.kernel.org/tglx/history/c/280c1c9a0ea4
  ("[PATCH] PCI Hotplug: Replace pcihpfs with sysfs.")

removed all invocations of __get_free_page() and free_page() from the
PCI hotplug core without also removing the #include <linux/pagemap.h>
directive.

It removed all invocations of kern_mount(), mntget() and mntput()
without also removing the #include <linux/mount.h> directive.

It removed all invocations of lookup_hash()
without also removing the #include <linux/namei.h> directive.

It removed all invocations of copy_to_user() and copy_from_user()
without also removing the #include <linux/uaccess.h> directive.

These #include directives are still unnecessary today, so drop them.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pci_hotplug_core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index d8c5856..210f93d 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -20,13 +20,9 @@
 #include <linux/types.h>
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
-#include <linux/pagemap.h>
 #include <linux/init.h>
-#include <linux/mount.h>
-#include <linux/namei.h>
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
-#include <linux/uaccess.h>
 #include "../pci.h"
 #include "cpci_hotplug.h"
 
-- 
2.43.0


