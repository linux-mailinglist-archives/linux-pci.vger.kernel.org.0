Return-Path: <linux-pci+bounces-29115-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8CBAD093B
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 23:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97B8A189D948
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 21:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FC6A31;
	Fri,  6 Jun 2025 21:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kgB7CY2A"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F34215F6C
	for <linux-pci@vger.kernel.org>; Fri,  6 Jun 2025 21:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749243789; cv=none; b=OBPZDbF1xnvpSo59gKD4alBGQPlhlx8ruXvFsGEM3Rey3lnNxvSCCejyHgwnr0sWKyjuFihS+VwWslhvCpotn2NnzuJ1UGiGqjbpOO9tbXvjaT5U12+hImOFyO991HMuAO2RdIlZPfFyB50vC55gEr7Z6DQ4J7CcVJ6aNOkhems=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749243789; c=relaxed/simple;
	bh=7Xi/vhxSk4kdVil0qrZV05x5VOK4oBtXmU6hqddMcIk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=agowMZn01JV2HFYfSHrC/rI5+4BQp4cH89n+EK65zBFEc/PgBGZMpYfA25Vfp+LoorXRmymrC772uKX7XDC4/Q5BH6iH1LvXnMSFFuhMfbmPHz0TEB3Z7HZ7zS/EwRtgaU4xxZ6Ld9kzBMjY6Asggq/dX54al2vTgtFeV4XRU8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kgB7CY2A; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749243787; x=1780779787;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7Xi/vhxSk4kdVil0qrZV05x5VOK4oBtXmU6hqddMcIk=;
  b=kgB7CY2AvP6XOZjMS5CY68f3MO2VKDeJYbHEwKnbj/1Kal1bNc9gqLJO
   FNcMDc9Qf6XdRLlnyqemZ+DwQjxmqiiR6XQVKxpjcizGKdIIc3TItOmcB
   0KkDKp2MykfSWpwIvEgz1Lg6RXlZ1qDyH+GYndyrZQXWHxCCZyYC7DYXA
   KMSzE3JNBIcCgAAv/tuXahavOIshQcEsfvWsB7Yl4GrY/TuC4NGBef6Bo
   Nsx4YWtz0Tf5NOba7hikz+Xt9TL1PDrpHAng0E15fkV8hOiPwLwJsL5op
   c8f5eTJw8X8595u4kNJ+SgiD0NPy42MTu4+ITzeR8vRizp5fp0ac241DB
   A==;
X-CSE-ConnectionGUID: aUqvZb5MQXKlueNq+v0P2A==
X-CSE-MsgGUID: DOxkP50FSfmZE6Swq9g1ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="68961609"
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="68961609"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 14:03:07 -0700
X-CSE-ConnectionGUID: RlmA2TNHQEOSh4l97OIrPQ==
X-CSE-MsgGUID: /OIua2mYQoG95Oj0zBpIBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="176872528"
Received: from otc-chromeosbuild-6.ostc.intel.com ([10.165.164.32])
  by orviesa002.jf.intel.com with ESMTP; 06 Jun 2025 14:03:06 -0700
From: george.d.sworo@intel.com
To: nirmal.patel@linux.ntel.com
Cc: linux-pci@vger.kernel.org,
	George D Sworo <george.d.sworo@intel.com>
Subject: [PATCH 0/1] PCI: vmd: Add VMD Device ID Support for PTL
Date: Fri,  6 Jun 2025 14:02:29 -0700
Message-Id: <20250606210230.340803-1-george.d.sworo@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: George D Sworo <george.d.sworo@intel.com>


George D Sworo (1):
  PCI: vmd: Add VMD Device ID Support for PTL-H/P/U

 drivers/pci/controller/vmd.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.34.1


