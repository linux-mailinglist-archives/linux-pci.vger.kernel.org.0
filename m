Return-Path: <linux-pci+bounces-6758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 745728B5471
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 11:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15F0A1F216EB
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 09:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2041D554;
	Mon, 29 Apr 2024 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mX0vPlXr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7985110A13;
	Mon, 29 Apr 2024 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714384039; cv=none; b=EnJZOC22hou1aJ7nEX0UyJU7bkOMu8+ST/sXHGodD9TTnTGSnHvfJtIDwWhrHNLc+DHfNTyhSEAKIOfYNyIol03BnvQ8Z2Oe13/paP3u58T9paLwALeIzilycLhEHc/atY6v7woINGJOT9sDHCAOts0fVV2A12gbZbw/hkervjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714384039; c=relaxed/simple;
	bh=T07B8FcITBSPGezVMSWE2NrugikmY3RzmLEKiCA9YLw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LJNqZTH73cp0wyfDLN4Z6mmgFcP1guncSPYsTK4obmbO6g8cTTcEnEbQ0rDte22UNPyizkHxd8WAXYoY6UIaViHhbZrFE9z8ZkjeQyBLjhY6Ffej7MiwOD9yH21ABAhCjhsw8Py/yeCTanQJ3w45Fd8kJtsKe8diCD0rFDZdpHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mX0vPlXr; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714384038; x=1745920038;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T07B8FcITBSPGezVMSWE2NrugikmY3RzmLEKiCA9YLw=;
  b=mX0vPlXrEfbEcCJKlGwb+wMvb0DEAWR2Srr77YAlR2ue57tihG+4BwxR
   FjhCQ9OFbvy89Y75rvyPFgzCT93QBCl5Bg/4jXtXvf0zZH25yA9dGddv0
   HvwfbEMNrpzrU/Z1pXWToe8uqX37rjaZUxtF3a/YMgWZFpXJ1RI7D9w7x
   bT3p4SkkV4ZudutvMbgb9+Hn9IYEJZQYKIvKJ4+S3FElqHJRESuLYJuN7
   MDnwADEWecw1QB+9ucC6MI8cBU93/yEhsAqIX0Dm93yYvDw042RTfLuT/
   tDfBUYZlJDIcTnpQmjBJSlQ6FmeR4cf2IWfTcFBwctvhNEd5sq4Ym9o3M
   g==;
X-CSE-ConnectionGUID: i7iUNk6YRGqUrX9L2W+o8w==
X-CSE-MsgGUID: mCIBViWXQQi0C+/Vk04LbQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="13812899"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="13812899"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 02:47:17 -0700
X-CSE-ConnectionGUID: z6OSQ0dYTbe1DPADCmYT5Q==
X-CSE-MsgGUID: AFMEwtDORWKTOYvFQldNVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="30715624"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.45])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 02:47:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/2] PCI/ERR: Cleanup misleading indentation inside if conditions
Date: Mon, 29 Apr 2024 12:47:06 +0300
Message-Id: <20240429094707.2529-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A few if conditions align misleadingly with the following code block.
The checks are really cascading NULL checks that fit into 80 chars so
remove newlines in between and realign to the if condition indent.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/err.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 705893b5f7b0..31090770fffc 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -116,9 +116,7 @@ static int report_mmio_enabled(struct pci_dev *dev, void *data)
 
 	device_lock(&dev->dev);
 	pdrv = dev->driver;
-	if (!pdrv ||
-		!pdrv->err_handler ||
-		!pdrv->err_handler->mmio_enabled)
+	if (!pdrv || !pdrv->err_handler || !pdrv->err_handler->mmio_enabled)
 		goto out;
 
 	err_handler = pdrv->err_handler;
@@ -137,9 +135,7 @@ static int report_slot_reset(struct pci_dev *dev, void *data)
 
 	device_lock(&dev->dev);
 	pdrv = dev->driver;
-	if (!pdrv ||
-		!pdrv->err_handler ||
-		!pdrv->err_handler->slot_reset)
+	if (!pdrv || !pdrv->err_handler || !pdrv->err_handler->slot_reset)
 		goto out;
 
 	err_handler = pdrv->err_handler;
@@ -158,9 +154,7 @@ static int report_resume(struct pci_dev *dev, void *data)
 	device_lock(&dev->dev);
 	pdrv = dev->driver;
 	if (!pci_dev_set_io_state(dev, pci_channel_io_normal) ||
-		!pdrv ||
-		!pdrv->err_handler ||
-		!pdrv->err_handler->resume)
+	    !pdrv || !pdrv->err_handler || !pdrv->err_handler->resume)
 		goto out;
 
 	err_handler = pdrv->err_handler;
-- 
2.39.2


