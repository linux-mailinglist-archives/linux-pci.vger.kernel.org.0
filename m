Return-Path: <linux-pci+bounces-28003-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B2EABC56B
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 19:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F357A2C7A
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 17:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1911A244699;
	Mon, 19 May 2025 17:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IWTEmsmH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC351E5B60;
	Mon, 19 May 2025 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747675069; cv=none; b=RZzQlisyXbpo9cTNgtkxQJMUtXz7mrVWRHw/1F5ZWecvlcVqrxfgqlIJsqMrGvG65tajY3oo+LZHXCeRJT8fsCl3q1MGBpZTLPIWSS+cBJipiYOheDIUrPFu8kAOSoek+uAqBJaK8SRbrCFjap/eBFd5jxFfWlErXZG2jcjOlM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747675069; c=relaxed/simple;
	bh=p9f3mcT/4+f+uVev7KhI+qcZ9qqE31KiQK2qBoEd7BI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pg1tkLDzfuz3ImyDcWD321jea8dUU7BYVjLK+SsCXNPpK8sL0qMTYGYWz+SN2LeAF610saZ6n6xWyHkXUbErxsodMui4pvXnikNlrl7Ve35L/AmVNvccDSTUC+y4oC6csaXY7hMai9gsIUT/U0cQ/2jJKi21H8qlmGsHBbIJl+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IWTEmsmH; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747675067; x=1779211067;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=p9f3mcT/4+f+uVev7KhI+qcZ9qqE31KiQK2qBoEd7BI=;
  b=IWTEmsmHJEFwlAFIObfiOyLhheyF5FbMbacW0vC3/c7fgizNzQNj5KW5
   2/Kiz/eZ/mFFMIhdofsTV1s0v95AIvIXIQ3yNjxuAOcevbNFbQ+baEp5T
   LSPdYPnm3yq0+TGqbBQsCRoUpkUUb8DCi1S1hTR1mjpq7Q9FIIB2dOi/E
   lsuQsr5TsTMxWzYPvW6iXh+iCZbTD2r9ALqSdvogQQox8E5DS8xN5Gsvo
   4g5tAwVQlNyOz3kCtym03gyrIZz1zqh5LRaxQ9rLfx4z3+MTs5BNzobti
   uKzfTkRCg7DZlKZwox1Uxrq9T664V9raJKM3Mggp4MoEv3NEgTvEmDkhJ
   w==;
X-CSE-ConnectionGUID: vOL/txnfTUexIHNtCYn4jQ==
X-CSE-MsgGUID: 8X7lzL3zTHa3+qTr1dFdeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="66998434"
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="66998434"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 10:17:47 -0700
X-CSE-ConnectionGUID: bD9JQKgiRPGommWXpKqc5w==
X-CSE-MsgGUID: E5YbACCETue/oucIXafenA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="139318231"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.35])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 10:17:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Shawn Anastasio <sanastasio@raptorengineering.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 0/2] PCI: Separate reset and link code to separate files
Date: Mon, 19 May 2025 20:17:37 +0300
Message-Id: <20250519171739.3575-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci.c has been catch-all for lots of code which didn't fit elsewhere,
making its footprint large.

Move reset and link related code into own files as they seem
independent enough from the other code and result in reasonably sized
.c files. While some of the code in link.c could have gone into
reset.c, reset.c would have become clearly larger and pcie_retrain_link()
wouldn't really have fit under reset.c so I thought independent link.c
would make sense and keep .c files in more manageable sizes.

The series is based on top of the pci/reset branch. Expected conflicts:
 - reset.c patch with:
   - PCI: Print the actual delay time in pci_bridge_wait_for_secondary_bus()
     (in pci/enumeration)
 - link.c patch with:
   - LBMS reset & update speed changes in the pci/bwctrl branch

There are some conflicts with some pending changes, the most imporant
being Mani's slot reset series:

https://lore.kernel.org/r/20250508-pcie-reset-slot-v4-0-7050093e2b50@linaro.org/


After these moves, the .c file sizes are:

  5295 pci.c
  3332 probe.c
   578 link.c
  1253 reset.c

I've been sit on top of the reset.c patch since the last Fall as there
have been just way too many complex conflicts to handle but currently
the conflict level would be relatively low.

In addition to these moves, I'm considering moving D0/D3 related logic
that is plenty in pci.c into own .c file (probably power.c but
suggestions welcome).

Ilpo Järvinen (2):
  PCI: Move reset and restore related code to reset-restore.c
  PCI: Move link related code into link.c

 drivers/pci/Makefile |    6 +-
 drivers/pci/link.c   |  578 +++++++++++++
 drivers/pci/pci.c    | 1890 ++++--------------------------------------
 drivers/pci/pci.h    |    5 +-
 drivers/pci/probe.c  |  194 -----
 drivers/pci/reset.c  | 1253 ++++++++++++++++++++++++++++
 6 files changed, 1977 insertions(+), 1949 deletions(-)
 create mode 100644 drivers/pci/link.c
 create mode 100644 drivers/pci/reset.c


base-commit: f3efb9569b4a21354ef2caf7ab0608a3e14cc6e4
-- 
2.39.5


