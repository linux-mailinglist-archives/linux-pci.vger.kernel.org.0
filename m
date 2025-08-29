Return-Path: <linux-pci+bounces-35103-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43436B3BC1C
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 15:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D88627BBFD0
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 13:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E1131AF2B;
	Fri, 29 Aug 2025 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwsuzt2U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD382F49F2;
	Fri, 29 Aug 2025 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473130; cv=none; b=UPxYphTT77sshNMtWB3f8SZm8j1d3PtHhMZPFHd5GMn4wkzNtJ+6lNM53iD6oY3W0B+3GGWrwePdI6JyFIVFKOOI8qo5XjjgqhJKLnIyCujITgAx/5yfRGDvlsQzynBRASPRMpVa3SoY+HWRWz7BQOWTHV7QlFsKufcx70DvhmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473130; c=relaxed/simple;
	bh=I3FGPEn/i7AK7bt+/cpWmKyssU10lHLDyKd8Od9xfOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qN0pM2dn9qr2F/39XQ2wzNN7gNPKwwrPcFqUc7On5PvV56pIjWmScUubBDRmZCsU7BFHWHo3NZiieuwNnXtB+xnAE9YKFOGdeijfVh0II3Rcl37SsxOionY365uNnxpow89dlnRi3VIGb+dnyj8w9o6uPFB2NQ9AcfSQiLpSBfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwsuzt2U; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756473129; x=1788009129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I3FGPEn/i7AK7bt+/cpWmKyssU10lHLDyKd8Od9xfOg=;
  b=iwsuzt2UNPUu4Pb0xFgbi9dfi2PVFGglwU/BGzxBBV8W4ZJEqvnr6Sho
   unKdGK3+f5AbFDbuByy+iY7v4mblYIVLv78qeyXiPghv6kdsBYogVVXPP
   0ozY7c/oZCSq90Zsf/5Q6HwiFRKj1DABWdHMs1h2qImGyKbYhFxUQrnP/
   3tzjaKzy2IpguzMRIJj6AqveVLpE0P4XrchpMuZrw2rNdzMFuhXFwgYg6
   pUe9PJj37JQzo3lhqnLEFh2xWLCjzM1JHVRJyFQ1Ej+wXanEq0n/9/yPH
   tRPMbuH2hVp8hgbUHN3oMGkEnEeNHHdxYKtDhstUZ8DSII7sCv1fhzXJs
   g==;
X-CSE-ConnectionGUID: /PoSBU8gTue6rQXqa86Few==
X-CSE-MsgGUID: 4bwW+RwhSpCIEmqBZYmA/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="62402918"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="62402918"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:12:08 -0700
X-CSE-ConnectionGUID: w7aRY5S4Q3ay3f/yvzLc8Q==
X-CSE-MsgGUID: 5kxbP4nUSdaI/FWDyTcp8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="169946727"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:12:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 06/24] PCI: Always claim bridge window before its setup
Date: Fri, 29 Aug 2025 16:10:55 +0300
Message-Id: <20250829131113.36754-7-ilpo.jarvinen@linux.intel.com>
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

When the claim of a resource fails for the full range in
pci_claim_bridge_resource(), clipping the resource to a smaller size is
attempted. If clipping is successful, the new bridge window is programmed
and only as the last step the code attempts to claim the resource again.
The order of the last two steps is slightly illogical and inconsistent with
the assignment call chains.

If claiming the bridge window after clipping fails, the bridge window that
was set up is left in place.

Rework the logic such that the bridge window is claimed before calling the
relevant bridge setup function. This make the behavior consistent with
resource fitting call chains that always assign the bridge window before
programming it.

If claiming the bridge window fails, the clipped bridge window is no longer
set up but pci_claim_bridge_resource() returns without writing the bridge
window at all.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index c5fc4e2825be..b477f68b236c 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -857,9 +857,16 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
 	if ((bridge->class >> 8) != PCI_CLASS_BRIDGE_PCI)
 		return 0;
 
+	if (i > PCI_BRIDGE_PREF_MEM_WINDOW)
+		return -EINVAL;
+
+	/* Try to clip the resource and claim the smaller window */
 	if (!pci_bus_clip_resource(bridge, i))
 		return -EINVAL;	/* Clipping didn't change anything */
 
+	if (!pci_claim_resource(bridge, i))
+		return -EINVAL;
+
 	switch (i) {
 	case PCI_BRIDGE_IO_WINDOW:
 		pci_setup_bridge_io(bridge);
@@ -874,10 +881,7 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
 		return -EINVAL;
 	}
 
-	if (pci_claim_resource(bridge, i) == 0)
-		return 0;	/* Claimed a smaller window */
-
-	return -EINVAL;
+	return 0;
 }
 
 /*
-- 
2.39.5


