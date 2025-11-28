Return-Path: <linux-pci+bounces-42257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0728AC91DEB
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 12:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E50674E3B6E
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 11:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515A93242C8;
	Fri, 28 Nov 2025 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1UKLG+c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB832F1FD3;
	Fri, 28 Nov 2025 11:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764330634; cv=none; b=tK7eIRTz4pdRWpU+A+O6IlMd4kuRB5ogjZdgt5/EqWeXTXJPUCuRK/egnwyY7rqKnc25+mTe2czMRxi0syBCKNkKv1fCUWMdBJjpZ0yFqjMxcM8RiRECAW7zRbFjzOodh2cdt6RYgjE9zJf0L55sQkWA66LKV0I58zUh2SShAfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764330634; c=relaxed/simple;
	bh=nOWN4SX6niJ5R8woPMBIGBfp1faz/CpMJMtQnB+sHCA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ffROi0lDz3ONcWcQ2Em8nz11RQ/w3b3bE0BH0fN1wdRfMaJcvzROhT32eSrCOJ/du/tVoYtxT/uSEZivar5Rwh4rMzRUhK+ziyUZuP/8B44U4cj3DBZk5qLoCoYfwlkE/P507RWEKvtZk/j8J2eXT22+IJhUbnqwyu2ebdGsqs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1UKLG+c; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764330632; x=1795866632;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nOWN4SX6niJ5R8woPMBIGBfp1faz/CpMJMtQnB+sHCA=;
  b=W1UKLG+cL+gnBYaM0//RTVcNdEtgC4VSl2POgcklr0narPsV6zHeoQ+F
   il9C4vjl0HB27f6h/rS7I73sXaPFsRXVCGloHxV63k8zMG6idme4XN4r9
   QmqRBg9UGIEHdB8DneD7PIXcgTCVTMXtTUkEMCKnaCC22+ViKsEpKJO+Y
   Vy+Wx9DPffobtqw0CGY0qfPA2dgNHJ3MjLU+aeOSmxM8V2QJGgZ0hbsAX
   3Cuc16GUtNf0bQjF9OqxCFOUi7X9kWpXH40RUVkZjzalovfaE91TDtwRe
   /Al+qMa0Gb9vqBqIJ/cxBB6NPohwcCmpyzwg94hUv/JFhVjoDWS73ONr5
   w==;
X-CSE-ConnectionGUID: PzR3UJfFTXi9zgmGeH8ecQ==
X-CSE-MsgGUID: b8dAcUO1Rrmzer2s1cv6WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="77050394"
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="77050394"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 03:50:31 -0800
X-CSE-ConnectionGUID: sHxLhlHeQiC1a8LpuHuNUQ==
X-CSE-MsgGUID: X55wi/0lRQe0EluXCL9FKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="224149128"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.229])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 03:50:28 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	=?UTF-8?q?Malte=20Schr=C3=B6der?= <malte+lkml@tnxip.de>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/4] PCI: Bridge window head alignment fix/rework
Date: Fri, 28 Nov 2025 13:50:17 +0200
Message-Id: <20251128115021.4287-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

First fix one alignment difference bug when handling realloc_head.

Rework bridge window head alignment calculation as the decades old
approach seems to leave gaps in between resources (please don't ask me
how the old approach works, I don't understand the logic behind it).
The old bridge window alignment approach was mostly okay with the gaps
because of gross over-estimation it applies to the tail alignment
(though I'm not entirely convinced there couldn't be corner cases where
things break due to those gaps).

With relaxed tail alignment, no tail alignment overestimation occurs so
gaps in between resources translate immediately to resource assignment
failures.

Apply the new head alignment first only to cases with the relaxed tail
alignment. Then, in a follow-up change, make the new alignment approach
the only one as it has higher regression risk and them being in
different commits allow bisect to differentiate which change is the
culprit in case of a problem.

I was first thinking of changing head alignment only for the relaxed
tail alignment cases. After extensive testing (admittedly, x86 centric)
indicated there are hardly any changes to the bridge window sizes at
all, I thought it might work out to just replace the old approach that
has clearly shown to be subject to resource gap problems with the new
one.


Ilpo Järvinen (4):
  PCI: Fix bridge window alignment with optional resources
  PCI: Rewrite bridge window head alignment function
  PCI: Stop over-estimating bridge window size
  resource: Increase MAX_IORES_LEVEL to 8

 drivers/pci/setup-bus.c | 130 +++++++++++++---------------------------
 kernel/resource.c       |   2 +-
 2 files changed, 41 insertions(+), 91 deletions(-)


base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.39.5


