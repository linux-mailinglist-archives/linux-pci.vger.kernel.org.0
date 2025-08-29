Return-Path: <linux-pci+bounces-35121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E07B3BC4A
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 15:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A54A27641
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 13:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB4331B11E;
	Fri, 29 Aug 2025 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lS8w48fq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7397303C88;
	Fri, 29 Aug 2025 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473263; cv=none; b=AQM/8YpAiC0WI+yOBux2ysbw0xctVs6sJ6Th7dA8UaixS2H3RxThxDMxvD6CcA1RJYfgEHTECcxNFQtiZ8GGVqbCJMN1ahZIifqXwXdXPOeht0UrE+bk6E64UODCX7J6sgnJUKKZvGGrYiIMQAPNeEk68KvmsDHaz3ggY+2tuwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473263; c=relaxed/simple;
	bh=HYec1tTg3ijXMRlEMgLn22i78PcCqKdFUvHyu8QuVXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MaCILTNIUK8Jz/Gbc0EjFV4pnTq8GWA1JtgOW6YrG3MrO+6O6magjPjZlNVTmDXtY6etO/j+Vgk9PSXemdWJnS0Ku+5gPyElBTYX5BLvN6FD9cfbEbFKA/mtVyOTttIJ9keNpCq/yUv5KL4Rneg2l94eFcZVNTvgTA7jeXFOT60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lS8w48fq; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756473262; x=1788009262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HYec1tTg3ijXMRlEMgLn22i78PcCqKdFUvHyu8QuVXM=;
  b=lS8w48fqtwLpr+x4U8a5OHfl955TS9yeIDld8eQNPIVYBfk/d9JkiDIa
   KSIaxw19YfeKUHhBc9D44b/2U3INXXZDL6ef3XuVZMafiPD0m+jxEcWB6
   f4b0JPxS1bebBH7jb4eb+5H3KFk+ukGBkMRaUKcOtuhjKtFJnZgZL/TGe
   VSF9FB9WH53L3FeWiEtu3TAaBbeQb21YgBaOxX+6iCPkAiF0mWczGQiy4
   zuBd5Sj7OG/GaVARG3gKN6Wy9rlsrrn3HJWwRiTAdBR3vckfLyiGcZ9lA
   Hd6vjLZM74nIDXW9Dc0NFhQhEWHTZotb7giyD7nOYtMqCBDeS534DtATw
   w==;
X-CSE-ConnectionGUID: KkH6iRb3RGeUE8USvNlY3Q==
X-CSE-MsgGUID: feqbsnuARqm4k4ixNDde0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="57781279"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="57781279"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:14:21 -0700
X-CSE-ConnectionGUID: XJJUOx99SS2EMtJVT48Y3A==
X-CSE-MsgGUID: ngSmRB2UQY6VAhLcVaAyZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="170548409"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:14:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 24/24] PCI: Alter misleading recursion to pci_bus_release_bridge_resources()
Date: Fri, 29 Aug 2025 16:11:13 +0300
Message-Id: <20250829131113.36754-25-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
References: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Recursing into pci_bus_release_bridge_resources() should not alter rel_type
because it makes no sense to change the release type within the recursion
call chain. A literal "whole_subtree" is passed into the recursion instead
of "rel_type" parameter which is misleading as the release type should
remain the same throughout the entire operation.

This is not a correctness issue because of the preceding if () that only
allows the recursion to happen if rel_type is "whole_subtree". Still,
replace the non-intuitive parameter with direct passing of "rel_type".

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 4ce747b5dea3..d264f16772b9 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1855,7 +1855,7 @@ static void pci_bus_release_bridge_resources(struct pci_bus *bus,
 			if (res->parent != b_win)
 				continue;
 
-			pci_bus_release_bridge_resources(b, res, whole_subtree);
+			pci_bus_release_bridge_resources(b, res, rel_type);
 		}
 	}
 
-- 
2.39.5


