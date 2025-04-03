Return-Path: <linux-pci+bounces-25227-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F664A7A00C
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 11:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544F23B374F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 09:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B231C84C0;
	Thu,  3 Apr 2025 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fTNE1Hy6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15847347A2;
	Thu,  3 Apr 2025 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743672710; cv=none; b=JYXdZaqsRR7kj0/eM29cpF+IoMvS0Tr5li0M/D4pT+3uuYG8FDt5UHHHDwwIZH+Tv9wc+Ee7NKw9c1ZG0sFVJL6tlHOF9iRxcIHZVCmaxA8TuJxdk01gjz50xGU7uVlyJ6ESxtRvRJ7PjM2t4JUOzko+w/2Zg0tElRFGiq/0Ftg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743672710; c=relaxed/simple;
	bh=sNndO7cE94SxIpOgsMIyRwMp9GIyL84y6xvqMUc0Suc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fZrkDMC83MPwXpXCRK7pjqpJQb6ovU+ijK6ctF23Wrl4PPqr43dRf6srO/OSgfJMviLJM5yGFxcnX3108h3dclUEZnftHqQ3Ay/exxIEiYzHkYQtSTpexAjEag4ApDbImOFMLIkRQyWl3LFNl2bGSyO+oJJA7lop52UlhIuymcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fTNE1Hy6; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743672708; x=1775208708;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sNndO7cE94SxIpOgsMIyRwMp9GIyL84y6xvqMUc0Suc=;
  b=fTNE1Hy6lIje0QI+MaweN/tomb7bXlvLLPimrhkMQuSL4YiRYEdOCDYO
   vgm4JEaN4eLHVEoBJl3jAxJuic15tkACUUE92lUJzFCYRhA2Rmm73ePGK
   C+hB7tQ7Oh946Kq0yYfTmJTEizbBAAJHOSSPbtcZWVd/valoBCZiA1zZK
   /IkMact0i16tvrs9MyIE3g7bn4JZaOJRv8dpzeMF93piPGiBiUAgGngde
   jdBZX4g72GempMf4eXU+7sluwdyKWZiFv2vp65z4IuK6ml+5JN3SKMCPt
   nLoKMrOtZmA3ArzrCILggCY3YqrOvqcD01I0lIZdhAsmjiJkUQZeBw+q0
   w==;
X-CSE-ConnectionGUID: qEnPp2rFS6CQoadc9l0FTw==
X-CSE-MsgGUID: cmjmvE3mT/uekzsdgrgaPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="70438999"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="70438999"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 02:31:47 -0700
X-CSE-ConnectionGUID: M9uV9PaHQN63ifnLL6Nc3w==
X-CSE-MsgGUID: 68G1vPifR0mBTlxQ3yujxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="126757643"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.152])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 02:31:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Igor Mammedov <imammedo@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
Subject: [PATCH 1/1] PCI: Restore assigned resources fully after release
Date: Thu,  3 Apr 2025 12:31:37 +0300
Message-Id: <20250403093137.1481-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PCI resource fitting code in __assign_resources_sorted() runs in
multiple steps. A resource that was successfully assigned may have to
be released before the next step attempts assignment again. The
assign+release cycle is destructive to a start-aligned struct resource
(bridge window or IOV resource) because the start field is overwritten
with the real address when the resource got assigned.

Properly restore the resource after releasing it. The start, end, and
flags fields must be stored into the related struct pci_dev_resource in
order to be able to restore the resource to its original state.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 96336ec70264 ("PCI: Perform reset_resource() and build fail list in sync")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 54d6f4fa3ce1..e994c546422c 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -187,6 +187,9 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 			panic("%s: kzalloc() failed!\n", __func__);
 		tmp->res = r;
 		tmp->dev = dev;
+		tmp->start = r->start;
+		tmp->end = r->end;
+		tmp->flags = r->flags;
 
 		/* Fallback is smallest one or list is empty */
 		n = head;
@@ -545,6 +548,7 @@ static void __assign_resources_sorted(struct list_head *head,
 		pci_dbg(dev, "%s %pR: releasing\n", res_name, res);
 
 		release_resource(res);
+		restore_dev_resource(dev_res);
 	}
 	/* Restore start/end/flags from saved list */
 	list_for_each_entry(save_res, &save_head, list)

base-commit: 7d06015d936c861160803e020f68f413b5c3cd9d
-- 
2.39.5


