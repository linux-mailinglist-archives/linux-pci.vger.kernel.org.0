Return-Path: <linux-pci+bounces-18558-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A3A9F3879
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 19:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0F21883D87
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9235207665;
	Mon, 16 Dec 2024 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VG9jhGgk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB29B207DFF;
	Mon, 16 Dec 2024 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371994; cv=none; b=NESyE9hahpOXjlMJUa6MFmdblGa0l/S0ZF1fqrbOHSiPcjFcGzXKk3ORGDKF0bKnlVHH4oJ+ZPaYC+LqAKqmHdn3yAVsetS2nxHIDfGIdvB18o6/1f0bCKEyfi/9noig8/f5+c87N3brCSA8a0skgj2C+eNMsaqnKneP4JGz5Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371994; c=relaxed/simple;
	bh=HMi0sojls+I7jfCBT/2gM9PoM9Z2gskyjB4HDnphO0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uu2akpEcMdfzq2OL4NckvS7a4Y2H5LqcRehHAtPo9u/kjZ1giOqn/1aKQEIsh7xH8cu5cFBsIMVYvafHrEnY5NsjmOdIKNFn6x67XW5uXwJGwF38+EKP6UMvsbM4N78vZ3eNJBfZhKoFWbADxVXNfOxZrGmNyvu9Rnmp38eztmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VG9jhGgk; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734371992; x=1765907992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HMi0sojls+I7jfCBT/2gM9PoM9Z2gskyjB4HDnphO0k=;
  b=VG9jhGgk2d7XrHFk3kCHGZ6voD00njKk4NqmqVoV0noXSMqRLLIHsjzP
   sHmaMelX2q8ea9GicdQ43y/1jE6XckgWYGG738AHUuPO9g6EJeiPHGAWL
   +mXv99+cfhT9H4GF9l/KHsZVhISC7k8ZQOY1f2fPtSwROwmwemdl5Ne0X
   1aLonVKd28IaytSYoZEW2aX05yfeAZE3qXioCM98sJexpKUpjrJUxIL+7
   hxUv00n4f0FhWmTprg80Em00EHUpiScIA7bCFUINq2caknFHAycNBjrzr
   2UYLUjAHteIXzJvVOrZI6VJltynecTO4QJxddlRk5nm1SRpG+YOgHrway
   w==;
X-CSE-ConnectionGUID: eqxEBhgSQs+R/sZvOFPsTw==
X-CSE-MsgGUID: Q+sYOYy/R/qqQMZLBMNiYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="52293365"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="52293365"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:59:52 -0800
X-CSE-ConnectionGUID: T69j207PRw+xUf0aTS3vxA==
X-CSE-MsgGUID: wLvASpS4QLOdd04+R3hjRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120532103"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:59:49 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 23/25] PCI: Use res->parent to check is resource is assigned
Date: Mon, 16 Dec 2024 19:56:30 +0200
Message-Id: <20241216175632.4175-24-ilpo.jarvinen@linux.intel.com>
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

reassign_resources_sorted() uses resource_size() to select between
pci_assign_resource() and pci_reassign_resource(). Due to twisted way
bridge window sizing in pbus_size_mem() sets resource sizes to 0, it
works to match into IOV resources but that is going to be changed by
an upcoming change.

Replace resource_size() check with res->parent check that is the true
dividing line in between whether assign or reassign function should be
used for the resource.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 5a3b320f1511..fec7d68fb971 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -271,7 +271,7 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 		res_name = pci_resource_name(dev, idx);
 		add_size = add_res->add_size;
 		align = add_res->min_align;
-		if (!resource_size(res)) {
+		if (!res->parent) {
 			resource_set_range(res, align, add_size);
 			if (pci_assign_resource(dev, idx)) {
 				pci_dbg(dev,
-- 
2.39.5


