Return-Path: <linux-pci+bounces-31082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B5FAEE09E
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 16:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB733A66E7
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 14:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4307328C01C;
	Mon, 30 Jun 2025 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fnL3xkbd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19C428C00E;
	Mon, 30 Jun 2025 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751293612; cv=none; b=PTm02oouP5BmVCWtf6efXcvuhqCHNmGmsN3QM7spZzBY2hkUlcBAuE91S3BUKMBVEEo/e4C8pkyOwDtCgxLGXTP10pkWeg+pGNnhCKNxMdHnuLy6568t36j61nqbXpiWQKAvrlHTTM+6SbbjFI6yo3aYKK+ohplIP8YQH8fXNnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751293612; c=relaxed/simple;
	bh=sqDx4y1sWT2XwLA9/hvsvksvU+3lik2+g/qBu4GsEf4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NOrr1kQI8BT85ivKxCb/l5REjax/ZIFM05cwb8KEi/q8VD5P3sJM+q3emDjBQqAcE1iYiYjT5kLaSzSqwXRykVMh7+kIJLfdgNn5TRQs3497cPkTO3g8owKwpcUXdTCmMUtgBS1Vb5b4DiL+YjA0gX7InbAAr6fj7BTjM67a4Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fnL3xkbd; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751293611; x=1782829611;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sqDx4y1sWT2XwLA9/hvsvksvU+3lik2+g/qBu4GsEf4=;
  b=fnL3xkbdDmDHBfmoqMPx7n9G16JxylbFubE3EWKvuKAempoz57dtsPlU
   D+Eek3d+9abRmdDcItyjp+NbOjdA7gVXZOJpykpalUB0bOfK9UmvgZs6U
   UIXjRsUwYwZc2zLY+7iUhxTAoasP2s9ego6mQJu26tpa8vo8zdgal0iv+
   dqVAUX/LppQzzulRDFWZ1+0PZpNYmE9QUOwoWW3WwF6fvCnet+Nc9GZQB
   K5I7k99FQxpOGk/goQx6FlH0BSnn00PoCCZ4SAwuJMkWD41cyOAgUKadx
   X5T0xlJ/ZhARn57C4xgb3LQ6hhWK92fB0mQnjQoA7yPuedd6hjFf1mmCu
   g==;
X-CSE-ConnectionGUID: RUMgFDI4TPKOCU6uBNV8ew==
X-CSE-MsgGUID: KTv7jbUDQBWVcG8ct+P7Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="53395820"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="53395820"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 07:26:50 -0700
X-CSE-ConnectionGUID: eykO/U7YQjSRLu2TV+C/eQ==
X-CSE-MsgGUID: voseO+5/RICTq7iQ5gZFcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="152865003"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.65])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 07:26:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Rio <rio@r26.me>,
	D Scott Phillips <scott@os.amperecomputing.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 0/3] PCI: Resource fitting algorith fixes
Date: Mon, 30 Jun 2025 17:26:38 +0300
Message-Id: <20250630142641.3516-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series addresses three issues in the PCI resource fitting and
assignment algorithm.

v2:
- Add fix to resize problem (new patch)

Ilpo Järvinen (3):
  PCI: Relaxed tail alignment should never increase min_align
  PCI: Fix pdev_resources_assignable() disparity
  PCI: Fix failure detection during resource resize

 drivers/pci/setup-bus.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)


base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.39.5


