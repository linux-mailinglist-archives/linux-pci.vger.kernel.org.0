Return-Path: <linux-pci+bounces-31513-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D591CAF8AA3
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 10:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 890907BD9A1
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 08:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88232EBDF5;
	Fri,  4 Jul 2025 07:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mwDLR+nt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF5C2E9EC3;
	Fri,  4 Jul 2025 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615688; cv=none; b=PPfRiFvFdHNsjQqOdhPSB587uwRParRf1iH29IIiUS9bYg14k8oCWXPbmHpLTJ9xPRPJPpmTjxJaRKDlCLmiUTKi71RXW9affewfFt8NAe96MELkuwlSHwF5CsXGN8gu6oHx5xebykSArcqwB6jL7IX/wOGM2BtE8Wf4CMER2Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615688; c=relaxed/simple;
	bh=+8ypEnrOSHNWmYk7TUoUtoXx75kXADyAx4bTfxfHe9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nxLLYqs4+rZcqP6rkLoLhvgjSrkQRCIV3JOA3Mr7Jc29Bj0RaXR18plU8Ip6Sf5lUCza6AlHeqzFYibdq0IZjRDozMFFW2HIKpw28cn81sOCbD+aDsJUkI4qk2q/vhAgF/TQAWRWQv80gv1iRUVNzkgd3c5zMf5oSf80SwGI5YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mwDLR+nt; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615686; x=1783151686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+8ypEnrOSHNWmYk7TUoUtoXx75kXADyAx4bTfxfHe9g=;
  b=mwDLR+ntnXfu7V3x+imtA6qUz78PKD8tokWTbbIVvK07cFl3oO2c9rb+
   TZWX2L30wNTLprOnnwMzZSAuen9/liVAXxhWuNfs9bLZPbaIDBoA2xT9Z
   dYUggLlEPrvwsiCAahuhdX6zwslKOesxTovre539VLXOgFR/m/Jvi3Hnc
   1hsmYZ1DKx0HuG4sumsGLuzq98sWbfeSyXqnx3hl3wqoVxBcpcoZu3eDU
   oQfrOuobLOoHTxMEXcEudUPR3ly1Fi7gg7Nvlo1dAiDB6nP5Gt+6WbDDL
   UhMJc96yZVOSLISnuuye5vVqQjOk2MjaANdbgNbiwfdQF9rQp0+1lcpMY
   A==;
X-CSE-ConnectionGUID: uyRUBKDSSe2h6GPv0fDHaQ==
X-CSE-MsgGUID: uLF+zP8BSxaJ4I3XkTQ37Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="64194164"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="64194164"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:45 -0700
X-CSE-ConnectionGUID: yhWhzgQXS7SKYpJCWSSs3Q==
X-CSE-MsgGUID: jgyy/fS6TJmi2BN+pnLdVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="158616596"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.244])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:42 -0700
Received: from svinhufvud.lan (localhost [IPv6:::1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id 4D1E64488D;
	Fri,  4 Jul 2025 10:54:40 +0300 (EEST)
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonthan.Cameron@huawei.com>,
	Lukas Wunner <lukas@wunner.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 51/80] PCI/portdrv: Remove redundant pm_runtime_mark_last_busy() calls
Date: Fri,  4 Jul 2025 10:54:40 +0300
Message-Id: <20250704075440.3221105-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
pm_runtime_mark_last_busy().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
The cover letter of the set can be found here
<URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@linux.intel.com>.

In brief, this patch depends on PM runtime patches adding marking the last
busy timestamp in autosuspend related functions. The patches are here, on
rc2:

        git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
                pm-runtime-6.17-rc1

 drivers/pci/pcie/portdrv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index e8318fd5f6ed..437e27f63c82 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -714,7 +714,6 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 		 */
 		pm_runtime_set_autosuspend_delay(&dev->dev, 100);
 		pm_runtime_use_autosuspend(&dev->dev);
-		pm_runtime_mark_last_busy(&dev->dev);
 		pm_runtime_put_autosuspend(&dev->dev);
 		pm_runtime_allow(&dev->dev);
 	}
-- 
2.39.5


