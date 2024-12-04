Return-Path: <linux-pci+bounces-17622-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F2D9E31E4
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 04:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA551674D1
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 03:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A3A1537D7;
	Wed,  4 Dec 2024 03:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y9hG4CMn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F502152E1C;
	Wed,  4 Dec 2024 03:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281883; cv=none; b=bnsHbl+NQ11++SwXsBliEdJ9l6w8GaZkJ9RaSeQj7NgGjvjXFpjh1oIRbdKiCK3xppzWShBEjBsOT+bhBaO6nICsPsQM6HQSLrMSZ/gNSypUjbpebJCLb1WsNpwpHNpqkDt7Y6qVXOApZNLo/fwNNSiSRzAoDNInB8VxQ4KiUpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281883; c=relaxed/simple;
	bh=2a8x/WilW+K0gr8mTUiATl1o00OqMo4SJqS4dl2SzQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mB/CZSk2+UiutNjYQlRpCPBNVKZq8tw/TVLC/UzeUiy2GneNOx5xFCh4f/eorZI+QKzLeWih61+9Eoqv8JmRYMXhbNRbd3WuUJnMOrSMlkWwavVj2FDJVkEMMir0gWgYt0QjM45ezo2SHhatV4BHE6VyG8RLMS0vvGqKZG33290=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y9hG4CMn; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733281882; x=1764817882;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2a8x/WilW+K0gr8mTUiATl1o00OqMo4SJqS4dl2SzQk=;
  b=Y9hG4CMnIz0T7WBSia6MseRknxFwrY5P/hd1g9SdsCoSmgt0WfsQFi/P
   xGb2TeRojF1cJaiTyjpAibjf/l0lSbVGc984vorjtWO0a7GOQFS4crnnM
   sHBvZ2hwvCiMbHbaCvGKaOLDQbDheQdngNzjNw9oBPPUEmYsWqsp3NV/9
   Y1tD6fkkMR7AGFsPlH8KXFWk2J6u90cJd+9bdK4VAYoPHSwC8Gf/vW4cU
   9GP6cIO/TFAD9vSB4L0YNuQtTdM4lDaRPFn/YyfgfvZ3YSeA26CvYwWlo
   dOqh39X3Ts3+hRLdTs+40qdEFvg3l8UrplLiKP5vKtgnGtkffKHBWt/pu
   w==;
X-CSE-ConnectionGUID: N+rGQDlCQ8eB4U/k65EDFA==
X-CSE-MsgGUID: JdLS3ldrQ96SslLF2y+ecg==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33452064"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="33452064"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 19:11:21 -0800
X-CSE-ConnectionGUID: QQwccbW5QkO7/2zJZq67pA==
X-CSE-MsgGUID: WHPwcx2ASlSANx5X+40b9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="124460854"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 03 Dec 2024 19:11:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4FE1C27C; Wed, 04 Dec 2024 05:11:17 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Cameron Williams <cang1@live.co.uk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1 0/2] serial: 8250_pci: Share WCH IDs
Date: Wed,  4 Dec 2024 05:09:20 +0200
Message-ID: <20241204031114.1029882-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a few WCH IDs that are used in two drivers, share them.

Actually share slightly more as it is logical to have group of IDs
related to the same family of the devices to be in one place.

Andy Shevchenko (2):
  serial: 8250_pci: Resolve WCH vendor ID ambiguity
  serial: 8250_pci: Share WCH IDs with parport_serial driver

 drivers/parport/parport_serial.c   | 12 +++--
 drivers/tty/serial/8250/8250_pci.c | 76 ++++++++++++++----------------
 include/linux/pci_ids.h            | 11 +++++
 3 files changed, 54 insertions(+), 45 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


