Return-Path: <linux-pci+bounces-45041-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37729D31657
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 13:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC8EB3047428
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 12:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9583321ABC9;
	Fri, 16 Jan 2026 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hzXT4uAq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF41D1F239B;
	Fri, 16 Jan 2026 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768568273; cv=none; b=cywWIcrXM81oZOJaiKV6d/5HMKasfBXpzQvneoak9aJQ7+/N/iuWBFC64kX0RBmrtJnXjmcxhAUwPTH93OnZRjvWYQklg+Utp2zP9WzXQt2wrsj2NDigZAZujzF/hkHyoh1FrOVcYAtVA7AoL6HHrWCkbWBnamTZidAR30xCJ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768568273; c=relaxed/simple;
	bh=o1VnLLAX/X8ncJ1I4n4rYj6f33UTKVs8/P+CiuxGeIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WZJIemucRmPCbXTMgn0hLLWy1wUlCkl24Lhs/C+zGGXTn/zbAHEkgIIQYBXXCKwToFD+9VsHcQuPSDs/Q4IkV/ual/akvtxukPskLRBwQdnRSA8j5HUjG0ObGbt5Yglip6yH+/ROgcSmZMHT9bmpgCsAAMWyYSDNCqUuzUX7b5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hzXT4uAq; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768568272; x=1800104272;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o1VnLLAX/X8ncJ1I4n4rYj6f33UTKVs8/P+CiuxGeIY=;
  b=hzXT4uAq1/6nOI86Zm0lWtXAiPz9Hf6PkTn3KAnMO9Y8YIttBDFYqRMu
   PJCfY1mPFtQafxwLobJ046VQvUF+ujHF6/vKZrPW7SGXfbXSHa64BICle
   pkIm0HuzDBXfNX53eQ+EezHDSeZSZMICxmT7bAJCnxAHXDuRsUA+QjuAu
   kjXZllv88DbB2RzLoKtf9i7sjV50lmzL26idRxV6/Vx5i4BkJ3Q2mSgqp
   LmfHuQHGsFZvdQD9TUtv5SFZwDz3ePcCeWVJ5S3hswJlz67+u1AirzCfB
   I2qx9mGmbCsmsLqWRheOFS5cafPYJopwGugjA+n1NDdiYdZBHYCW6cl7W
   g==;
X-CSE-ConnectionGUID: 74O/23AWQY2KdXa6V1rW2w==
X-CSE-MsgGUID: w1H9iNl9Sg29rlkeMWOEGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="80603115"
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="80603115"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 04:57:51 -0800
X-CSE-ConnectionGUID: +M6+0Sq9Qi2xqHrb2PmEpw==
X-CSE-MsgGUID: dw9+v0ikSeyNNtWN3/edmA==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 04:57:48 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Jinhui Guo" <guojinhui.liam@bytedance.com>,
	Keith Busch <kbusch@kernel.org>,
	"Anthony Pighin (Nokia)" <anthony.pighin@nokia.com>,
	Alex Williamson <alex@shazbot.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/3] PCI: Locking related improvements
Date: Fri, 16 Jan 2026 14:57:39 +0200
Message-Id: <20260116125742.1890-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

Here are a few locking related coding quality improvements, none of
them aims to introduce any function changes. First two convert "must be
asserted" comments into lockdep asserts for easier detection of
violations. The last patch consolidates almost duplicated code in the
bus/slot locking function.

This series based is based on top of the fix (the last change would
obviously conflict with it):

https://patchwork.kernel.org/project/linux-pci/patch/20251212145528.2555-1-guojinhui.liam@bytedance.com/


Ilpo Järvinen (3):
  PCI: Use lockdep_assert_held(pci_bus_sem) to verify lock is held
  PCI: Use device_lock_assert() to verify device lock is held
  PCI: Consolidate pci_bus/slot_lock/unlock/trylock()

 drivers/pci/pci.c | 120 ++++++++++++++++++++++++----------------------
 1 file changed, 63 insertions(+), 57 deletions(-)


base-commit: 270f0a8620a2d8fac3bcab3779df782d85b3b4bf
-- 
2.39.5


