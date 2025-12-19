Return-Path: <linux-pci+bounces-43435-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D30CD14D2
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 19:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B8A930D7001
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9C834AAF9;
	Fri, 19 Dec 2025 17:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QRc/LWu0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B9234A3D0;
	Fri, 19 Dec 2025 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166213; cv=none; b=OvMjjERkKFyIc8rnkmOX7xWI0H0a6MDAysoeqNtCJHLCpwdwtr23OYrOo+VRtspH7POdkSWb+TsnAQ/I3VJ/cSwrU96oElxjbAbjhNSzkYWYE8OBXKrm4HzmGW+Of3ng8DDnky8zoWiS7BKx2v71hK6TWPt0m/i4Y5eDsMGlh+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166213; c=relaxed/simple;
	bh=9OXK7oj9p5RkvtU+sQOiWMUrwzzLE6Ndnnatux4N3+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=puxjdBjhETlhAPHvmEaLlStZiYzJ2aZVjKoyHnzq7AEwX+Hx1cxQwEzt9qbg/mNHGdRsGOjQLyLuYBt8wUuoxj0eBCCwg17R6AlALsOUNs3UXgTc0gGw4LIcTuVPX1G3fM6dl0VAQAn8PuZYqWUNed2aUwixpgetrhyhYFZRQCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QRc/LWu0; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766166211; x=1797702211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9OXK7oj9p5RkvtU+sQOiWMUrwzzLE6Ndnnatux4N3+k=;
  b=QRc/LWu0thSbS1J8fnu6HEQPDT5vXJDSnJ6dGmfc+PD5kOpmFfp1jnwd
   22OWPLMIDhhxYkKhCXM7T/f8wwTPSlsgz4dHMv6TxWwR1+ItvEzBOqrlj
   nxokiUyule0o1MpEydN3090QAdgYezpMEB3SmN0FC4OkjkJozCswtY6Er
   aD+ddEHkOrFdEc+MkTJ97WadUP2CJqIwd+RfL10sWRgbK+Q1OuVwgwPAp
   Zp49qUdJa1Hbenv19rJUhPlBzv9+7vlLTmlu4V6DSLjEnmt4DJCKpECXQ
   77yCGnadAjROD4q+5HHAB6dHZDLaoWjTf23SzvlviSu5T4ZzbWoF45lug
   g==;
X-CSE-ConnectionGUID: r/BZVR7pQKmenu0MvFhAug==
X-CSE-MsgGUID: 4/U4kRTSTc+hlxBzTNJM5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="78764464"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="78764464"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:43:31 -0800
X-CSE-ConnectionGUID: LyhCpZhsRQWSVlMCeeb09w==
X-CSE-MsgGUID: Kl1tojkpTBKXwwGi+7LBig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="198066243"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:43:29 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 20/23] PCI: Add Bus Number + Secondary Latency Timer as dword fields
Date: Fri, 19 Dec 2025 19:40:33 +0200
Message-Id: <20251219174036.16738-21-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
References: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

uapi/linux/pci_regs.h defines Primary/Secondary/Subordinate Bus Numbers
and Secondary Latency Timer (PCIe r7.0, sec. 7.5.1.3) as byte register
offsets but in practice the code may read/write the entire dword. In the
lack of defines to handle the dword fields, the code ends up using
literals which are not as easy to read.

Add dword field masks for the Bus Number and Secondary Latency Timer
fields.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 include/uapi/linux/pci_regs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 3add74ae2594..8be55ece2a21 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -132,6 +132,11 @@
 #define PCI_SECONDARY_BUS	0x19	/* Secondary bus number */
 #define PCI_SUBORDINATE_BUS	0x1a	/* Highest bus number behind the bridge */
 #define PCI_SEC_LATENCY_TIMER	0x1b	/* Latency timer for secondary interface */
+/* Masks for dword-sized processing of Bus Number and Sec Latency Timer fields */
+#define  PCI_PRIMARY_BUS_MASK		0x000000ff
+#define  PCI_SECONDARY_BUS_MASK		0x0000ff00
+#define  PCI_SUBORDINATE_BUS_MASK	0x00ff0000
+#define  PCI_SEC_LATENCY_TIMER_MASK	0xff000000
 #define PCI_IO_BASE		0x1c	/* I/O range behind the bridge */
 #define PCI_IO_LIMIT		0x1d
 #define  PCI_IO_RANGE_TYPE_MASK	0x0fUL	/* I/O bridging type */
-- 
2.39.5


