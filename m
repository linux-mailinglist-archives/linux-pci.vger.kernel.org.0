Return-Path: <linux-pci+bounces-3886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A9E8603BE
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 21:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A4F1F27218
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 20:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF0371736;
	Thu, 22 Feb 2024 20:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FBCEBsZO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3480F6AF8D;
	Thu, 22 Feb 2024 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708634453; cv=none; b=gOKJAu/vWxzUh7XhG6YULXvEFVQ36uMC5v/lLSOc4DeMAHZ6gfu4KyrRmUt2oJJ0Ywo57vgMoXcvELeV9v8QO27wPKrp2nK3/FSGz8gzBYb9CyOFnVYX9B6bDyHGtms430BcbgVnVlEcF31gCgfShlcePX/OKgnZWdXZLpTxyeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708634453; c=relaxed/simple;
	bh=jeAQTPQrhXpg49xvZysNAxqhbPsEr5aAB0AbuUICJgI=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=Dt+wWfS9jBCHSp6zo2FOBylK4/IcDWjdWASmsP6jMhya7oRX1ReiICAnIDA+Y4Me1RWlOttL8yl640KJb/PsTZEd95eVJXHzRIDi6ITDCjoQ2fy6iSAYBLCXQEUb4uL2iBYRIzho7ZvlQjMhILswwGpgQYVkqWDNVM6AWIOafbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FBCEBsZO; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708634450; x=1740170450;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jeAQTPQrhXpg49xvZysNAxqhbPsEr5aAB0AbuUICJgI=;
  b=FBCEBsZO2YBkg1tE7Q5bj4p7HcX5XA/KomeEgKgUhB3XRKbdt4vnpCZI
   BWBk+7Iqut+NJ32HlQGiYuF6MdgZEfavKi4KArm25O0Rsk2OaqpNhjs1x
   UaN2opVxzR/YzywA3M6fs+W9ODXoTwWgNlPLj9RVoSTkT86bdiuqhvs93
   /jYr2dru5RGPUYP9FKqMyKLGbmmBQWhwinJZL+VKxTTFHBjhH8AxKl187
   8Ybmk0Qwj+u1J68FPO0QSZS2nqP23T4zDY7rD65iwR5iSUwa+E+YoejtF
   LmWXEs2bWq0zGptVAkJmWOfm+Lo42NuFiyYoA5smpKgMQHIl1SzGspClT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="25358626"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="25358626"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 12:40:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="913585365"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="913585365"
Received: from wyeh-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.77.87])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 12:40:49 -0800
Subject: [PATCH 0/3] sysfs: Group visibility fixups
From: Dan Williams <dan.j.williams@intel.com>
To: gregkh@linuxfoundation.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Marc Herbert <marc.herbert@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-coco@lists.linux.dev, alsa-devel@alsa-project.org
Date: Thu, 22 Feb 2024 12:40:48 -0800
Message-ID: <170863444851.1479840.10249410842428140526.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hey Greg,

Marc was able to get me a backtrace for that bootup hang scenario that
Pierre noted here [1]. A Tested-by is still pending, but I am certain
this is the issue, and it may impact more than just the one platform if
that "empty_attrs" pattern has been repeated anywhere else in the
kernel.

I also took some time to document how to use the helpers a bit better,
and introduce DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE() for cases where all
that matters is group visibility and not per attribute visibility.

[1]: http://lore.kernel.org/r/b93ec9c2-23f5-486b-a3dc-ed9b960df359@linux.intel.com

---

Dan Williams (3):
      sysfs: Fix crash on empty group attributes array
      sysfs: Document new "group visible" helpers
      sysfs: Introduce DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE()


 fs/sysfs/group.c      |    4 +-
 include/linux/sysfs.h |   85 +++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 84 insertions(+), 5 deletions(-)

base-commit: 70317fd24b419091aa0a6dc3ea3ec7bb50c37c32

