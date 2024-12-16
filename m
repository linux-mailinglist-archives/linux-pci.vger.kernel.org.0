Return-Path: <linux-pci+bounces-18544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7459F382E
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6283B16D1C6
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 17:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB872206F22;
	Mon, 16 Dec 2024 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ec6lDe9Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B33F206F14;
	Mon, 16 Dec 2024 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371882; cv=none; b=bCOxgtZ1ZGP+5aHrqyWHEla7Y2yAaJlaz9hOjLtSDOSpjpUab/ub0kwVhe6G6dILJjBMxFXewWVq9wTFKi+LDFcDnIrW8nbiwrvylxHWpVMEenwWvz/FwmoXndycveALWJ72BC3GAIztG8zJJLzMV5EeTyDIt4qNKGDZGTvqPyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371882; c=relaxed/simple;
	bh=LHbPda8IBFOYsXIOtKc2Idk1drPsxsLRJjF50aTUBDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOZ+8nFgXp4dLfqBBvpKtK+8AKSQhwOA02xoiXkdPsU9mFPk1PJ4AXmi6IfrXB4lWJQEOWaR53ZcTDneo9QWsT+1jIDA2AB6R0lAxeXRSNwtyz9F1rBUQtmHBX0sWoYaxU8IQlIv1MnLgSnMwtxPR7Wo0q2GY9SrHsMVVJuIOR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ec6lDe9Z; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734371882; x=1765907882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LHbPda8IBFOYsXIOtKc2Idk1drPsxsLRJjF50aTUBDs=;
  b=ec6lDe9ZbBS+nPZDqSBp9WOwjovQcfHVvxSGzY3E2LcbNEOu8ONugO8a
   kFAbKsvh2ZkfH4vJCFa5G4kXvSDO59+yv5ZL5lRH8+iX1WjpN7fZmuEHH
   a8yZPntRBjsCs7Hlh8pBTpMFQVX6VuqpjV+gaPSyWtDDgAX8LsRA+Mz4U
   sq7KQ9rSB+hdHpAvVUXk3Fhf37anWJ2t6PzHDQ4MJoAs+dLXtxeXj3xBx
   xZw8jLiuYM0q0/ippK7SutKL18o+ahnzUgoD4kbWDJpJrDhDtzoq0QaAj
   sBhtc/eAR1KOMD7T/UyRn/McrvdBwFR0FYhj1s0Jj0kt74K48WtZwizOX
   w==;
X-CSE-ConnectionGUID: vPHRU43IT7mAxsGXQI6YfA==
X-CSE-MsgGUID: X87EiIWKQkiQ+BksueFRsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="38544008"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="38544008"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:58:01 -0800
X-CSE-ConnectionGUID: eJ0dpVb/QfmkzNY+4HdUHw==
X-CSE-MsgGUID: KKtVYauKT+ubojZRl0LnbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="97149708"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:57:57 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 09/25] PCI: Check resource_size() separately
Date: Mon, 16 Dec 2024 19:56:16 +0200
Message-Id: <20241216175632.4175-10-ilpo.jarvinen@linux.intel.com>
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

Instead of chaining logic inside if () condition so that multiple lines
are required, make !resource_size() a separate check and use continue.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 3907930da00d..63c134b087d5 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -285,8 +285,11 @@ static void assign_requested_resources_sorted(struct list_head *head,
 	list_for_each_entry(dev_res, head, list) {
 		res = dev_res->res;
 		idx = res - &dev_res->dev->resource[0];
-		if (resource_size(res) &&
-		    pci_assign_resource(dev_res->dev, idx)) {
+
+		if (!resource_size(res))
+			continue;
+
+		if (pci_assign_resource(dev_res->dev, idx)) {
 			if (fail_head) {
 				/*
 				 * If the failed resource is a ROM BAR and
-- 
2.39.5


