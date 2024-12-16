Return-Path: <linux-pci+bounces-18516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF179F356E
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 17:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D0D57A2D79
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 16:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D86114AD1A;
	Mon, 16 Dec 2024 16:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D5P7tjg0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D70B14A095;
	Mon, 16 Dec 2024 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365439; cv=none; b=jIS11jjU8MYDH1pJJqjPYaxnCJOYFGKQ581P7bLLBs34ufp9QVfASoxYgfRZ2iqf1/ZQlVSZIKIkGSfOTSRQmAbIKU+tA9R6ONNSf72ieOaF4eXjX0Gl0MdrYCM2dkEyc42VA8E0o0EWUuWpFUfHKaFfnd+2Hjc2eIZ+rytbGxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365439; c=relaxed/simple;
	bh=3hz0/nYgnvrHJgscQWPwOkskKUx41Z8jhLGgWfFgNb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohu/JN4EHvG8XJmVUULBo24tzF4MomAkEsb6jBcrV6sdtpDBxQzCkkvwO00f/NK+Ik2XRbOohvYU5GiUcxIAm0yq8aEw4sM2ZTsddxSB7eaifZiLdCFGNU58CHSkAiPKTdaplBGpXh7PjsF8bwQOGZUJNNVaa7Pnekzc+Qurs84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D5P7tjg0; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734365437; x=1765901437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3hz0/nYgnvrHJgscQWPwOkskKUx41Z8jhLGgWfFgNb4=;
  b=D5P7tjg0bwuGHrGjb6d1aCQJmEy+fiLrvCwcICgAZlNOE8zVbjandQml
   i2o61X/QnPtg+cdLp78NkksSLAT7UpBzAC4n7aUvDqk51t8Ipl+pgvQgF
   ysusgAuVGzsWc3z6rZhySyPpkF8hf8aLmNwUp6EAMYrnv6qVA8HcxHCh5
   1XpfhBePqKVQFiGR+P+ZJiVpKw9kCx4CNV6oKqgtfgMDfRit0g0Df2d8E
   8l1Pgprj4ebPKqhA6UVbMp/JHVsabSDlu8QvMjpQZtookDINghnw4DCOX
   HRCRyXDHIKss6gqFHOrd6s5oNcEhxd8oLlXdmw8/AV7qrMHG1vqP2Uihx
   g==;
X-CSE-ConnectionGUID: p7TU28iVQlScJhPTZ6OJRg==
X-CSE-MsgGUID: uFc+kdIOQrayfpvxASQs3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45761342"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45761342"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 08:10:37 -0800
X-CSE-ConnectionGUID: lowAW4FST+qbUd2YLKLfkw==
X-CSE-MsgGUID: C/7acEIVTPeZUtgaoDRAVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="97015500"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 08:10:34 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/4] PCI: shpchp: Change dbg() -> ctrl_dbg()
Date: Mon, 16 Dec 2024 18:10:10 +0200
Message-Id: <20241216161012.1774-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216161012.1774-1-ilpo.jarvinen@linux.intel.com>
References: <20241216161012.1774-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert the last user of dbg() to use ctrl_dbg().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/hotplug/shpchp_hpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
index 012b9e3fe5b0..bfbec7c1a6b1 100644
--- a/drivers/pci/hotplug/shpchp_hpc.c
+++ b/drivers/pci/hotplug/shpchp_hpc.c
@@ -675,7 +675,7 @@ static int shpc_get_cur_bus_speed(struct controller *ctrl)
 
  out:
 	bus->cur_bus_speed = bus_speed;
-	dbg("Current bus speed = %d\n", bus_speed);
+	ctrl_dbg(ctrl, "Current bus speed = %d\n", bus_speed);
 	return retval;
 }
 
-- 
2.39.5


