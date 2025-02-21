Return-Path: <linux-pci+bounces-22010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3510A3FD12
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 18:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63EA57B0979
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 17:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC6624CEDA;
	Fri, 21 Feb 2025 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TCxvA25m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075FD24C67F;
	Fri, 21 Feb 2025 17:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157720; cv=none; b=kox1uLokpRt8hqdrhX56GIkQHFDBMWR75TBeZFZhn9XzoRLj99esFykO7ALqPnAdEgW4/LRMuXod498EMTSp4mUteLblqOfCIWyL21pKN9t3Jh/Bh8RjdTGJeYUOsXx1vD0f/D5kSjZX6tmo1s3zpwN1TTAdgHFeMyPQoXiqOBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157720; c=relaxed/simple;
	bh=2t0668eiteh3f3Iy0ruE97MLBoXovdk0kloMVMvC1YE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GoFlPsBGy5oqqiC3Bg8nAY3DHJ2/4Z75w6VQRFxP4bhFTzBeffSU6kfmFj6yAPzSLe11r6y5RIfJ/GgEURw27VlTfAkfnVwhyavVrWFu5Ij33mzjHaNWSv/FNfJ4VS0SUuXxA0a0zVbIEYoRx6B9kI6P4fjbANk/7Qkqw8XfhA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TCxvA25m; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740157719; x=1771693719;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2t0668eiteh3f3Iy0ruE97MLBoXovdk0kloMVMvC1YE=;
  b=TCxvA25mw0cNOF90wfUX+Z3tnAWNH/UIYKrR1mhCrSw0vljjmKIyV4tD
   NTvYbUGsKQtLSOW1Af9DBQu/2rnDdtb2XaD6i6/CTOU49GvJrFzJ1W6OB
   RK9ykCr1aCpaeFy4Q/CBMiO6/p2qPO8DhhQmbsGFEJl9IolUkyiPFwb07
   XYHRPKTsiJiCkWPkxDQZlAJ2KFaOQh0QznKo0hhfYj9dMxUz9AwCHQcI3
   DSwKQwzh6HQ3yZXR27ydqXFLIZNYFkyTl9u64+9SL4GlrE2wkqxGenp+8
   0MLge+H3mvmFouCG7dJJ9RPDslnRJRFdUix0K+TSBJgyKitW7/GlZus8Q
   Q==;
X-CSE-ConnectionGUID: rkC7VW5jQPy0h8XgeLbVNQ==
X-CSE-MsgGUID: Bz3m75P4Qo2cusF18naNrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="66348133"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="66348133"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 09:08:38 -0800
X-CSE-ConnectionGUID: Jc8ijnaVSgK6s3uQtQ4NXA==
X-CSE-MsgGUID: bC3ASJHhTnWRImYJWSD2Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="120046078"
Received: from test2-linux-lab.an.altera.com ([10.244.157.115])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 09:08:37 -0800
From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joyce.ooi@intel.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: matthew.gerlach@altera.com,
	peter.colberg@altera.com,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v8 0/2] Add PCIe Root Port support for Agilex family of chips
Date: Fri, 21 Feb 2025 11:04:50 -0600
Message-Id: <20250221170452.875419-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set adds PCIe Root Port support for the Agilex family of FPGA chips.

Patch 1:
  Add new compatible strings for the three variants of the Agilex PCIe
  controller IP.

Patch 2:
  Update Altera PCIe controller driver to support the Agilex family of chips.

Previous versions of this patch set contained patches unrelated to PCIe 
Root Port support for Agilex chips. These patches have been removed and
will be resubmitted separately. Patches related to a particular FPGA
design have also been removed.

D M, Sharath Kumar (1):
  PCI: altera: Add Agilex support

Matthew Gerlach (1):
  dt-bindings: PCI: altera: Add binding for Agilex

 .../bindings/pci/altr,pcie-root-port.yaml     |  10 +
 drivers/pci/controller/pcie-altera.c          | 253 +++++++++++++++++-
 2 files changed, 254 insertions(+), 9 deletions(-)

-- 
2.34.1


