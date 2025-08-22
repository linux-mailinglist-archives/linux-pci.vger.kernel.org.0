Return-Path: <linux-pci+bounces-34583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B07B31D6E
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 17:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B9EAE82E7
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 15:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276F031354F;
	Fri, 22 Aug 2025 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UQ2g3OI5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6C33126DE;
	Fri, 22 Aug 2025 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874709; cv=none; b=fCaeHFYBplAN/FHuvzXb0t7A44JBkblYV8vN+8j1apup+MdGqHnxS7tu/AvegL5jQQIDlJOUR2iNFyr7UiTlPl3NJVIaguxWbVJ60VGPqMnAa4Pn/n8a/jJO9KXG+grf3mY4g+3+Y4Eku+jLJ+w6Ir6VDL9X2CRG8xtPVLxPzDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874709; c=relaxed/simple;
	bh=lNB4OF2Frswq8A/Spc0itCO+i13cv1R1+OiD+b5mXBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BqrW6ivImuT8bgHlANePOsALKF3Dbgq+TID5Ye9im0FhGELIX1ZO/Ohmv8/j2qE60kP7PqxzyqtVRADzVC3EmHV+TuIcxkKiAU8GQix0S47ThmwjHqQ0beTrBe8f2dZNHK6ntk4ND+mM0fcIxxZIBpmAEpc/MGIqg07U8q3Y7hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UQ2g3OI5; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755874708; x=1787410708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lNB4OF2Frswq8A/Spc0itCO+i13cv1R1+OiD+b5mXBM=;
  b=UQ2g3OI5t76WN3qsCf5N0NN99laqOKpV5M3XIgB6KZXm26GOYD/Ahz3t
   SQvUdHkB9sWsLInZPHHXWTHRTublYnvWnLs33DnbKgicWdnJIDD0sD6jv
   TAlwAfyw96s+N+SeowWFikS7O/TZJjjUUaDsFXzy6XnO1EK9C5LWiU5VN
   OEL0B5HDS/q4dggcg0b2ScB8bNuFMtqSifeFlT8KZCpy6v6otB0hMb6Em
   uSRT36Bzj4GHXO9lUx0Fxk/9F/h4fzDESesp+sLkcM8C9FPZJxrHr6MpS
   oelgT6okg7D4quKofrucH3MibdMEp29VD1o12MrcNBXYPYU3ktUYpk9Fg
   Q==;
X-CSE-ConnectionGUID: ICnAE8LERrm9gILT8tswDQ==
X-CSE-MsgGUID: 27ze0+0QTVS8G9NNKGsjfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="80780578"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="80780578"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:58:28 -0700
X-CSE-ConnectionGUID: QdpNvnJ4TxqlKStF+Xcarg==
X-CSE-MsgGUID: dx1mT04YSL+qjkrIT85xOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168232435"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.115])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:58:22 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Andreas Larsson <andreas@gaisler.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-pci@vger.kernel.org,
	sparclinux@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Igor Mammedov <imammedo@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 14/24] PCI: Warn if bridge window cannot be released when resizing BAR
Date: Fri, 22 Aug 2025 17:55:55 +0300
Message-Id: <20250822145605.18172-15-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250822145605.18172-1-ilpo.jarvinen@linux.intel.com>
References: <20250822145605.18172-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BAR resizing calls to pci_reassign_bridge_resources() that attempts to
release any upstream bridge window to allow them to accommodate the new
BAR size. The release can only be performed if there are no other child
resources for the bridge window. The code just silently continues when
this condition is detects.

Add pci_warn() to inform user that a bridge window could not be
released because of child resources. As too small bridge window is
often the reason why the BAR resize cannot succeed, this warning will
help to pinpoint to the cause.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 5ef6362b5166..55289cd58e2c 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2556,6 +2556,10 @@ int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *res)
 				goto cleanup;
 
 			pci_release_resource(bridge, i);
+		} else {
+			pci_warn(bridge,
+				 "%s %pR: was not released (still contains assigned resources)\n",
+				 res_name, res);
 		}
 
 		bus = bus->parent;
-- 
2.39.5


