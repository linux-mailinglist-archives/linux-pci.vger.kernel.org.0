Return-Path: <linux-pci+bounces-7856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 416978D0552
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 17:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFE59B28CF6
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 15:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DDB16DED5;
	Mon, 27 May 2024 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LGTTqUDh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B872B17B508;
	Mon, 27 May 2024 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716821059; cv=none; b=iFAxqzLJSg8gIHx+6nFSA/PZnQykfMi6BYPXrmpIvjch76vjoqT9B0DPk74+rlnvgijhaRaWixt5zakpRO9T0KVhMA2VmBG9OaCYAeaLk6ifcLXp6tNJDjIqDcd+js+2kEpdIPgCmhy+MVJZSSU+LwJ4jcU+29WsP2IXWRBRSVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716821059; c=relaxed/simple;
	bh=OM1rdnugqBXqPiE3NxXp2O0o31W1IZjSamfYJ/RZelo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pv3mvGwraTA0zkdpQZ3zwOK1koxoajvuTSkVzNfh8SQjZoHVyAO39zzFMN7u0Wdi8bvITIkZHt3fWyVOM4ZJZfrEtRIwwLvjIuPLLSn+OWrA8eZ0RtPl/MgqbAiiTxobcITl/Dxto/6gvNEdccLNeLbVZIyxybquhqzrGjwpraU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LGTTqUDh; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716821058; x=1748357058;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=OM1rdnugqBXqPiE3NxXp2O0o31W1IZjSamfYJ/RZelo=;
  b=LGTTqUDhlQH+XouSlGtYbpPGoifwbRapJ7t3LE6aDzYT5RKvT932IuE8
   ZQig8oBJu6l7XqnIJtWV+mJ6BaNKTarar8/kPpRoH3Sz1Ybkn17fxnAmT
   BamoNbPYpxGcRdAM4+v4wxBnmV/wMEDOYFmc3tziPDPI+74Q8pdVX4JjG
   zv/pOmnqa0YUlpPjuOAfUz6E+PM1Z4KpEjl04Swjz94l1fAemMNeGZqOe
   LXIa3W0QYCIpS/56UA09pJnghOByfNFYsVG/zigUb2F8+GzZdtpt2BVzU
   pw/hsRjN8k6kfJW5xazdF0cRHvC2l0s8f6ARz2hCqvhrGzKLojP54c3lo
   w==;
X-CSE-ConnectionGUID: xWdhJyGUSPiiqRD3eCGmeA==
X-CSE-MsgGUID: /eIB2GJtRhmX8/NcDJl5pg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13269754"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="13269754"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 07:44:17 -0700
X-CSE-ConnectionGUID: biFalGLdRLakTIUquR73OQ==
X-CSE-MsgGUID: /rnoDRQFS3eWMeziXLYCBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="35279795"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.246.214])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 07:44:14 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	"Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH 1/2] ACPI: extlog: Trace CPER Non-standard Section Body
Date: Mon, 27 May 2024 16:43:40 +0200
Message-ID: <20240527144356.246220-2-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527144356.246220-1-fabio.m.de.francesco@linux.intel.com>
References: <20240527144356.246220-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In extlog_print(), trace "Non-standard Section Body" reported by firmware
to the OS via Common Platform Error Record (CPER) (UEFI v2.10 Appendix N
2.3) to add further debug information and so to make ELOG log
consistently with ghes_do_proc() (GHES).

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/acpi/acpi_extlog.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index f055609d4b64..e025ae390737 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -179,6 +179,12 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 			if (gdata->error_data_length >= sizeof(*mem))
 				trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
 						       (u8)gdata->error_severity);
+		} else {
+			void *err = acpi_hest_get_payload(gdata);
+
+			trace_non_standard_event(sec_type, fru_id, fru_text,
+						 gdata->error_severity, err,
+						 gdata->error_data_length);
 		}
 	}
 
-- 
2.45.1


