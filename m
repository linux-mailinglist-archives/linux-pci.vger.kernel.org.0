Return-Path: <linux-pci+bounces-18552-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D844A9F3866
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 19:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C695189569B
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38860207A1D;
	Mon, 16 Dec 2024 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="clZXSNbm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8731207A09;
	Mon, 16 Dec 2024 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371945; cv=none; b=nXu3prRN+xyrXXfToKjOBAkVfFwa5h/dkfin/aOH7p9ZEudXBFEeSJV1bGmR2cOG2BrgjcVeO32WxWdQbJ4IiVR49CiljaYjaodCh9fBF4QrtLMz1iAvxihagNFp0S67xeG8o2333Z3bALYKAmNEtH63HVSwNTiX0SZCZgxuwbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371945; c=relaxed/simple;
	bh=pZyqKw1r2FVynB2WCWScfA6sUrAG6S2t2NdeqZap09A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XygvMS6uKtP0JKcOmXAf4DS94xud+apNSX8qulydjz9f+pGtLa7cJGtTBP6M8D/UDK+OFh0Lr4PxhOgs3zLEtYAmIK6KKFZI5IRiu4dEBpbNpdWTFGc0NP9f/4dqLv4iYTuj9I20aNqNjzR2YAPYRhvTT7ZTnspDj0NUDzolqGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=clZXSNbm; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734371944; x=1765907944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pZyqKw1r2FVynB2WCWScfA6sUrAG6S2t2NdeqZap09A=;
  b=clZXSNbmOsv0tNyEs5h/W9PXiq2sj1zUwCxpWgUi/oIAmdK5l7ev5aCD
   3So9DMKVac3VRDE3ovQpiRz6+hbEYBcDxe1n8VvRPGyCs6c6yB0e+uU8Y
   sTznud7UJGiyG5aExw7Wr0e+H3fT7aBNzwEyZYBpAjjaL7C9+9wDn7voy
   slsK6enG/ggWSbUEisTTE1OpU9t7KX8geCl1eOURXCEZUyrfCsGZA4HTP
   LXxAQ8cdddRrjp2OMFA7BLKhWiVXqpHLV0ACDIwZ5rZLCVGe+0FCjsFeT
   gyhZWZNb5L8OtWy6UjKHfkyk7tfay0KvvTjKZdZKGxvxMgTbUBzLSpbTt
   Q==;
X-CSE-ConnectionGUID: S35s4FbcQI2zZpgiFBp3GQ==
X-CSE-MsgGUID: S3gFA0DiS1K75cA3Z0bOWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="52183747"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="52183747"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:59:03 -0800
X-CSE-ConnectionGUID: DRYnoRS5QNOhGeU4zrhOBw==
X-CSE-MsgGUID: r6vStFWIQIass9FssXzEKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="128075848"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:59:00 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 17/25] PCI: Remove wrong comment from pci_reassign_resource()
Date: Mon, 16 Dec 2024 19:56:24 +0200
Message-Id: <20241216175632.4175-18-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The commit a4ac9fea016f ("PCI : Calculate right add_size") removed
including min_align into new_size in pci_reassign_resource() which is
correct thing to do. However, it also added a snakeoil comment that the
resource would already be aligned with min_align which is incorrect.

A resource that is assigned earlier is aligned with the old alignment,
NOT with the new requested alignment (min_align) until later deep
within the reassignment callchain. Thus, remove the incorrect comment.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-res.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 79c7ef349856..a862b5d769dc 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -387,7 +387,6 @@ int pci_reassign_resource(struct pci_dev *dev, int resno,
 		return -EINVAL;
 	}
 
-	/* already aligned with min_align */
 	new_size = resource_size(res) + addsize;
 	ret = _pci_assign_resource(dev, resno, new_size, min_align);
 	if (ret) {
-- 
2.39.5


