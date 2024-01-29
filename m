Return-Path: <linux-pci+bounces-2715-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 474328403C5
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 12:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7B77B212D4
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 11:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42465B5CD;
	Mon, 29 Jan 2024 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AlHukrP0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419B55BACE;
	Mon, 29 Jan 2024 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706527649; cv=none; b=UhaFG2IpXt8X9LIcWADwj1veyAWO77nmaBlnta66vVFWPlyBjHGYJHymLJGRiBk0zKj3alnf/DzSRzuuEXXE6xhUbV+UOhUs6IhrCmP0Pi7RqvxK5Q0by58KchiA68PdHzVkVy+NuEMwGuPIK+QEJwkUsOSVGK7SAVYDtgfL1b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706527649; c=relaxed/simple;
	bh=QjEduxmVVqL7KnO5vm0x6bH4grGRCF1a+Hd2U0PJUFo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=D+TKgorQaFUD41XskuOQ2rHdIzwBRwg2h8iXWdoB0cfzZlEzKyf0ovcScHRQe5G7w9pVtCQGkG3Nhkg8fnZEbF8O0OU1BvgNY2wxj7jvwofYUAbI/6CxA2B1GFsgXmJpA9tUGwFFDGMOvgFygZKtOTytVGPJSJnG/ZV/1LlJMqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AlHukrP0; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706527648; x=1738063648;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QjEduxmVVqL7KnO5vm0x6bH4grGRCF1a+Hd2U0PJUFo=;
  b=AlHukrP0E+sffuUa+K2EK6/hUYQ2zJfrdb28XvSP91sRu26ev9dslJF9
   kYga2fHGR7D/fDMpP9tbcolpf1xzPAjmERZBXVFILVI1+7LJhZtqaN4vh
   Smh0IrDz+/f124irIZVBCVejWFDR2TuQiXQUc1+8M0nPzY5MEDM37lPBQ
   1peD/fZgHTRcCgn5MsuluAjoVJrFQQZVQlzDSNM1JV8CkNdC0uGJGTdai
   +mcT6afdNCOUOpAbPByX0mtKZkDe7Gt5FAwz6ceinOXHugTq1YHERfrh8
   8XNt6lX7mTt9hBt+P0orJ2mayG6yiKI1qOL7mcC0mpbfzlG2ejedk3qci
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="467186852"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="467186852"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 03:27:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="29488541"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.253.213])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 03:27:23 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/2] PCI: Fix disconnect related issues
Date: Mon, 29 Jan 2024 13:27:08 +0200
Message-Id: <20240129112710.2852-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series addresses two PCI suspend related issues Mika Westerberg
reported to occur because of Thunderbolt disconnect.

Ilpo Järvinen (2):
  PCI: Clear LBMS on resume to avoid Target Speed quirk
  PCI: Do not wait for disconnected devices when resuming

 drivers/pci/pci-driver.c | 6 ++++++
 drivers/pci/pci.c        | 5 +++++
 drivers/pci/pci.h        | 4 +++-
 3 files changed, 14 insertions(+), 1 deletion(-)

-- 
2.39.2


