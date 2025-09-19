Return-Path: <linux-pci+bounces-36502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4EDB89E2D
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740BF3B1FE6
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 14:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19A9313D64;
	Fri, 19 Sep 2025 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mq5XKyfg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3148B314B81
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291772; cv=none; b=TWWpEX13eTK7NttDnwZUkEgvHNMH12zvl5X1QEJFpQVr+4uTDonGYnOwboR2Q7QGcp7qoo3EVdObML5R/YFwSgx9sVW6ZVGhFeAsTjhJjPNnyKA6RYqkluwZElJ4Nfm6fIs2eDWVL+eiZLoidulmzBVWpdLUMYOG2VCn9KuZvJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291772; c=relaxed/simple;
	bh=t4xS4POzAfYHRG2QoOL9x3X0dblERfi5cM6g0JJy2iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bj3uPsoSsHQ0TFEgiWul6I+NJsutu2KPbqctdrhgnAv5Tcd5l2Xt3rTElCBJUyF+zaSUCbEFtBDEa8C1NXx+ouuTB71snRUx3nedtz/jZd87s9/1uUi4lQmThalA1Qgtwgq7RLqWFzlxNluDY8JTzKhpSvhve8vn/V2qMDIu1YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mq5XKyfg; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758291771; x=1789827771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t4xS4POzAfYHRG2QoOL9x3X0dblERfi5cM6g0JJy2iU=;
  b=Mq5XKyfgpNfuqfRfN2DIJrEiXxOeOY2hwFIc3NMYNBL/cLqUgQ9Vn8kx
   5i4ng43oL9we8B8RXNqScOAvwOJBCmioQUIteOAT1O6z3qrqJdle/mRem
   c1bZuGOQjZx7D8Rb84U/TfxdbAU07+9DiDSAfpOnIsiJfX9DjrWHbJcth
   pa+Bofi+ZG4Abdz+upMATdE7H0MqjNAW+AR77AYA82b+yYOhw/zlxvdX7
   NQ9VhM0AIQJq+rfoCt53/AhfGrDCnF7bMJvK+1qjXJSMTVD38Mda4UV8r
   +IOcFstJQPf+XjO8jzgMnzU242QibDMCkSH8f34fPD9MwOBqvwpBKQsXn
   Q==;
X-CSE-ConnectionGUID: qHOcEcQCQUKc3N+eEvs1mA==
X-CSE-MsgGUID: yHykya+ERlSb6z7TgcU09w==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60750575"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60750575"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 07:22:41 -0700
X-CSE-ConnectionGUID: McjDPyQ/Rhe+OK27oqfhwQ==
X-CSE-MsgGUID: jjisDF6TQrKFCkLHVwbNyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176655062"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2025 07:22:41 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: xin@zytor.com,
	chao.gao@intel.com,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [RFC PATCH 23/27] PCI: iov: Export pci_iov_virtfn_bus()
Date: Fri, 19 Sep 2025 07:22:32 -0700
Message-ID: <20250919142237.418648-24-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919142237.418648-1-dan.j.williams@intel.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Yilun <yilun.xu@linux.intel.com>

Export pci_iov_virtfn_bus() for tdx-host module. Use it find all PCIe
VF devices associate to a PF0, then calculate the address ranges for IDE
Address Association Registers.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
[djbw: todo: drop this export and teach drivers/pci/ide.c to do this]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/iov.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index ac4375954c94..d1bd3419e606 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -28,6 +28,7 @@ int pci_iov_virtfn_bus(struct pci_dev *dev, int vf_id)
 	return dev->bus->number + ((dev->devfn + dev->sriov->offset +
 				    dev->sriov->stride * vf_id) >> 8);
 }
+EXPORT_SYMBOL_GPL(pci_iov_virtfn_bus);
 
 int pci_iov_virtfn_devfn(struct pci_dev *dev, int vf_id)
 {
-- 
2.51.0


