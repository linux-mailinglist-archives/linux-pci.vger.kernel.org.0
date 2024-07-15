Return-Path: <linux-pci+bounces-10246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079DF931246
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 12:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396FD1C21781
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 10:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D50187561;
	Mon, 15 Jul 2024 10:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="POC1uSAU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29376185E75
	for <linux-pci@vger.kernel.org>; Mon, 15 Jul 2024 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721039349; cv=none; b=GcSUEv9jlCVllw4sCdrU8nzhfRqXacRqsZpeJ2D9taPVc7DHehTZerzZohl51eKHvd8dOxJzNZaxUJNp4+6GYJ5zI0AtqcDF9H519L6aYNqcYGKexsEbbIaa2LxFx0NcrQeq638zTeANAByJaXDg8K7r72CGNasi0lgOIABHa3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721039349; c=relaxed/simple;
	bh=k8U5buReyWOccZrzeoY13Q5pLBu8ll0HI2Ua7lDjpgg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d6OV9MRKEG+WpjQ/pLql7JF3NL6aCyS+T6ut0PXTWsPN9aP3cpR0ODp+AE/9sqnQdiTKZvcTfrCJPmrCl8bpEeaWTZDG0gICr2xbKiOP/ctY0XqOGQj6efNAYik+Ni55K490j0VwgMkyjKW1Ir+tmquejp/uXQJVPevT6tCAe+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=POC1uSAU; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721039347; x=1752575347;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k8U5buReyWOccZrzeoY13Q5pLBu8ll0HI2Ua7lDjpgg=;
  b=POC1uSAUKtGn6RJ2bnedf+B4n3WcfOhHSOZ3fRiw1bbQ3/0WMBS8w4l1
   qbWvlcdpRKpFV8LaIocmVPikvacIan9tUyrAzU8wgJzkiYazjI4EQuMZr
   pU8ZFXSH7EIjcLdLslqF3gdhZeFE43pc4EfLVpSoztXgsK5VmTUc5A0Oz
   riADISrSZw69kpYc8xurgrKHl2MQjgEJtNgjBe7z685axnRhkqM9rGJjO
   bXfnLj0zLzuBNN93jlNVdwooL5tmIzKbPKli/v/yJN9KbwTF5FQII6Mma
   9kv5npEwlVW0uxDvp8xkt0t7JuUsSPweeNBI5cOWgYme7glyvBvHbEHX/
   w==;
X-CSE-ConnectionGUID: pqLCRlfVRbu0HtNPidok9A==
X-CSE-MsgGUID: D6RC8aLWTRyfzlr9syOUng==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="35950958"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="35950958"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 03:29:07 -0700
X-CSE-ConnectionGUID: Eefmi0MvSc6VqGFbuiW0UA==
X-CSE-MsgGUID: DwXGXos+R6Od3eZj+yx6DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="49458359"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.94.248.120])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 03:29:05 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-pci@vger.kernel.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: Cleanup SR-IOV state on unsuccessful PF driver probe
Date: Mon, 15 Jul 2024 12:28:35 +0200
Message-Id: <20240715102835.1286-1-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During the probe, the PF driver might call pci_sriov_set_totalvfs()
to reduce the number of supported VFs. This will be restored later
by the PCI layer when the PF driver is detached.

In rare cases, when the PF driver fails the .probe routine after
it reduced the number of supported VFs, the value of TotalVFs will
not be restored automatically. This may impact subsequent probe
attempts as next calls to pci_sriov_get_totalvfs() will return an
already modified value.

To avoid this issue, either we should expect that all PF drivers
will restore TotalVFs on its own before failing the probe, or we
can do some explicit cleanup inside the PCI layer. Since the
latter case seems to be trivial to implement, let's start with it.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
---
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/pci-driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index af2996d0d17f..c949fdd09f26 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -326,6 +326,7 @@ static long local_pci_probe(void *_ddi)
 		return rc;
 	if (rc < 0) {
 		pci_dev->driver = NULL;
+		pci_iov_remove(pci_dev);
 		pm_runtime_put_sync(dev);
 		return rc;
 	}
-- 
2.43.0


