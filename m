Return-Path: <linux-pci+bounces-8798-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91754908956
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 12:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14C91C25C02
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 10:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CE112F5A0;
	Fri, 14 Jun 2024 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZXdaY+FV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DD71946A5;
	Fri, 14 Jun 2024 10:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718359625; cv=none; b=dk7U9JmVAuGbQpiIIZva23q/S8GY3yIFKwj+hS03x29/AiLT5kIklfk079F3l5OL5xYhFh2jshaU2HDA6Ttjad8KIkMcG1wRwSO3t70u44IR7eKaWToDAXsBnKjuSZBD8AqWuOa23ZWREZw3YoQ6ceNnpR6EosuwaxhgtwST4c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718359625; c=relaxed/simple;
	bh=5G6fJaJVWMpmbme+Rt8CFcBUcQjzifvZi4qRRIEqHyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=swPECeLgi+S5tHbyFo8zfknOuMbm9R4B6CybXLcCv6G9uhMNEhWorH25E02AJ3LJYwJJXvas38aDfeMUGRX9cpew5/fqHAHIw6qdgu9uxAFafBd/pFyRHWWicWE22dbLzCo3eZeMC/BJs6C83aNfa9qhrFUMtmjwkhpOjfqr4Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZXdaY+FV; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718359625; x=1749895625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5G6fJaJVWMpmbme+Rt8CFcBUcQjzifvZi4qRRIEqHyE=;
  b=ZXdaY+FValKhWkkQLrS/Q7/hCh6Aly9hIBvjz20ix08cKPBhKXYtuQeN
   NCoXhji6bMyLqhlSVNZKvC6adz1K4uKMHmPbO2BJaI03GPv3BnkSe9omN
   zcp/nzS2xbGFIjcBw+dI6EGFG6LVVd0LrbVgv9w9pdgayGFwKwB9jyXx5
   FokHSfcNjqCc+vAYiQ1RXHzq5qO8WAG3jGQY27xbaPp0JND1yIMfEWBjQ
   qbGFkM76CnUOvROCZbRAud1FDLgbmfoozT5eqoNyfIz0IiwU3ewgscsfq
   ypkqebg1I2f5FPyRi+w0WNlyEPkOgefeXY/NAnj6Nxo5pWufT0saXZUyZ
   Q==;
X-CSE-ConnectionGUID: thDtt3cASq2D0TS3Qglerg==
X-CSE-MsgGUID: Qzh1tBhbRa6uLiw0yr2aYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15389004"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="15389004"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 03:07:04 -0700
X-CSE-ConnectionGUID: D5iayefDQtGYL+TTvlaOig==
X-CSE-MsgGUID: bAYFmz4tRPOLHnrKQplGcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="77933772"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.222])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 03:06:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	Robert Richter <rric@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 4/4] PCI: Introduce ALIGN_DOWN_IF_NONZERO() helper locally
Date: Fri, 14 Jun 2024 13:06:06 +0300
Message-Id: <20240614100606.15830-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240614100606.15830-1-ilpo.jarvinen@linux.intel.com>
References: <20240614100606.15830-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_bus_distribute_available_resources() performs alignment in case of
non-zero alignment requirement on 3 occasions. Introduce
ALIGN_DOWN_IF_NONZERO() helper to avoid coding the non-zero check 3
times.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

I tried to look other similar cases for both ALIGN() and ALIGN_DOWN()
kernel-wide but it seems this is not very common so I did not put
ALIGN_DOWN_IF_NONZERO() into the generic header.
---
 drivers/pci/setup-bus.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 004405edf290..39552d1a1793 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1819,6 +1819,9 @@ static void remove_dev_resources(struct pci_dev *dev, struct resource *io,
 	}
 }
 
+#define ALIGN_DOWN_IF_NONZERO(addr, align) \
+			((align) ? ALIGN_DOWN((addr), (align)) : (addr))
+
 /*
  * io, mmio and mmio_pref contain the total amount of bridge window space
  * available. This includes the minimal space needed to cover all the
@@ -1930,8 +1933,7 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 		 * what is available).
 		 */
 		align = pci_resource_alignment(dev, res);
-		resource_set_size(&io, align ? ALIGN_DOWN(io_per_b, align)
-					     : io_per_b);
+		resource_set_size(&io, ALIGN_DOWN_IF_NONZERO(io_per_b, align));
 
 		/*
 		 * The x_per_b holds the extra resource space that can be
@@ -1943,15 +1945,13 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 
 		res = &dev->resource[PCI_BRIDGE_MEM_WINDOW];
 		align = pci_resource_alignment(dev, res);
-		resource_set_size(&mmio, align ? ALIGN_DOWN(mmio_per_b, align)
-					       : mmio_per_b);
+		resource_set_size(&mmio, ALIGN_DOWN_IF_NONZERO(mmio_per_b, align));
 		mmio.start -= resource_size(res);
 
 		res = &dev->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
 		align = pci_resource_alignment(dev, res);
 		resource_set_size(&mmio_pref,
-				  align ? ALIGN_DOWN(mmio_pref_per_b, align)
-					: mmio_pref_per_b);
+				  ALIGN_DOWN_IF_NONZERO(mmio_pref_per_b, align));
 		mmio_pref.start -= resource_size(res);
 
 		pci_bus_distribute_available_resources(b, add_list, io, mmio,
-- 
2.39.2


