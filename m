Return-Path: <linux-pci+bounces-18554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F199F3861
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 19:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EBD9160F51
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138A720765E;
	Mon, 16 Dec 2024 17:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FlaxQlfM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C028207663;
	Mon, 16 Dec 2024 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371961; cv=none; b=jaGPi+I4Tk/CbkItSe3iDoT0tBRfHJr0FIp9WRn+JdJ7k3gtDb+e+07BYZ4+SqTOJqaE1V5dff3N9jyKFiRk+JrKxy46Abwlg1zgdNn+5qv1PCGY54+vLyh8Ld4IB4bNo9D7VpqUGb/dd1ogczCNmpbnnKmUwr/Kfhgf8i3n3Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371961; c=relaxed/simple;
	bh=qP/7E/wEcnYheuAKNjOAYjf30iQeRzyamhuIbSdUl74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rSN/BrHY9Bmgy/bdKuVuOEJw6ki2aD8C4HwN7dJ8qhPPfQU4FY3JcHRC2EmTLjXHqWAbBNYgCzHZa3stE4pIJRqY5OvIlrZJApmwSDgts1/xvZQC1T8UYRlTWBfolrlBtFIxntO3d2bNGrkDJPnegwoG66dz04mLSqoeTpYR+co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FlaxQlfM; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734371960; x=1765907960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qP/7E/wEcnYheuAKNjOAYjf30iQeRzyamhuIbSdUl74=;
  b=FlaxQlfMnwlSqzcD5ukJhfRd0sn0rGDmtmpJm9ZScgUkarTJxsjVF2LG
   geDxsINsY1mDK7yjv5C9u6u0y2RM+CiRpGOfKZzlupf+Q3fFRnFunHVOx
   XDOPCh3ePsFTUA8UrA2JLIfug6YxCM5v5cWDUhYXwhMWr2r+8cxtyNmfL
   mCDmt98A8h1rf1GW3yq89NeCNieHZFVSKH+ptoQwA+R8643SRX9tBzUrg
   2wiuklKIh6Y8aOl692je3+mSVOEQ7SWzcFRnWBvFULMHaVenZnjtJWZhB
   YafV/PDPAm0rwtsLpXmjYuS+XE2KFTB8GBn2ulYtCMVIhFuwfkZtlGUT3
   A==;
X-CSE-ConnectionGUID: DAtmqEvhTVSMEE8Cq3taew==
X-CSE-MsgGUID: j41KBG05S+ahVHbqjLiznw==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="52183812"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="52183812"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:59:19 -0800
X-CSE-ConnectionGUID: ZdTr0kdcTWqXziLrmczXZA==
X-CSE-MsgGUID: 0kwz1wAeRxqR0WE9HgLU6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="128075881"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:59:17 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 19/25] PCI: Extend enable to check for any optional resource
Date: Mon, 16 Dec 2024 19:56:26 +0200
Message-Id: <20241216175632.4175-20-ilpo.jarvinen@linux.intel.com>
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

pci_enable_resources() checks if device's io and mem resources are all
assigned and disallows enable if any resource failed to assign (*) but
makes an exception for the case of disabled extension ROM. There are
other optional resources, however.

Add pci_resource_is_optional() and use it instead of
pci_resource_is_disabled_rom() to cover also IOV resources that are
also optional as per pbus_size_mem().

As there will be more users of pci_resource_is_optional() inside
setup-bus.c in changes coming up after this one, the function is
placed there.

(*) In practice, resource fitting code calls reset_resource() for any
resource it fails to assign which clears resource's ->flags causing
pci_enable_resources() to never detect failed resource assignments.
This seems undesirable internal logic inconsistency, effectively
reset_resource() prevents pci_enable_resources() from functioning as
intended. This is one step of many that will be needed towards removing
reset_resource().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.h       |  1 +
 drivers/pci/setup-bus.c | 12 ++++++++++++
 drivers/pci/setup-res.c |  3 +--
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 0b722d158b6a..efdb9af8e256 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -329,6 +329,7 @@ void pci_walk_bus_locked(struct pci_bus *top,
 			 void *userdata);
 
 const char *pci_resource_name(struct pci_dev *dev, unsigned int i);
+bool pci_resource_is_optional(const struct pci_dev *dev, int resno);
 
 /**
  * pci_resource_num - Reverse lookup resource number from device resources
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index d30e8a5a0311..a4e40916e2fc 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -206,6 +206,18 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 	}
 }
 
+bool pci_resource_is_optional(const struct pci_dev *dev, int resno)
+{
+	const struct resource *res = pci_resource_n(dev, resno);
+
+	if (pci_resource_is_iov(resno))
+		return true;
+	if (resno == PCI_ROM_RESOURCE && !(res->flags & IORESOURCE_ROM_ENABLE))
+		return true;
+
+	return false;
+}
+
 static inline void reset_resource(struct resource *res)
 {
 	res->start = 0;
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index a862b5d769dc..041c881c3c9c 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -494,8 +494,7 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
 
 		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
 			continue;
-		if ((i == PCI_ROM_RESOURCE) &&
-				(!(r->flags & IORESOURCE_ROM_ENABLE)))
+		if (pci_resource_is_optional(dev, i))
 			continue;
 
 		if (r->flags & IORESOURCE_UNSET) {
-- 
2.39.5


