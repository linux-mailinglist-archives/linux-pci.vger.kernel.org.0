Return-Path: <linux-pci+bounces-3222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E017B84D578
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 23:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5841C21E07
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 22:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D316312FB28;
	Wed,  7 Feb 2024 21:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sI92Qjji"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DE91384B4;
	Wed,  7 Feb 2024 21:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707342020; cv=none; b=D4/pFEIGQs1HsPapQx3Z/x4KmfQjoGnwY47HHMrietBM8j8L+nlV/1PBo0OggF7Z3iEY3Ktu5/8dr9J4gHR4f5EttM61BZPSvUrpzxPP2jBrXKAPLRxr8b7FEH4OmlZ33jks0dMaGO10u2WY/Zf/0/rS4aozdgcHB+oXPShcSUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707342020; c=relaxed/simple;
	bh=eKNi9/iUHM6VsVGx5Z2q5lCG+YAb9c+WYYd2aydu50A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KxYkuSZVbyQQ23lkHIonAfH/psYuorH0g38s1nwVVh/HVDeGIhuI8uNMx5Lni3Qj35jYfMKfQIGv8rYmx5mf/n/Wrc/KqNEPdV3P3urYxrKDffp7+0Gt40dLTFlDtrCpmo9h6nzhp0o4/nVbBIFC1t/1mFKP4nMShps9tBSUxxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sI92Qjji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87363C433F1;
	Wed,  7 Feb 2024 21:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707342020;
	bh=eKNi9/iUHM6VsVGx5Z2q5lCG+YAb9c+WYYd2aydu50A=;
	h=From:To:Cc:Subject:Date:From;
	b=sI92QjjiqE84gIGr2Ia7Vbv+zr4/keYPJ2Wkxv8HGpT+alOvgvcdBn2/8R167Wkoo
	 5jGHPQwbY5U+9D80DW3UOsAzpDbm1nfvXagZilKh6hWh1RGQMZxdbwV2mnuZxN0Zxa
	 zTJsXek6pJwljIrLo9pWNUrfceXfHetrBI4w7SG467FtncWhfEiURcotEa8z5s/CB0
	 5dql35ISLwwXB8DSr0MuSJv5LxUnQnPRnvQBzLrbvLRRjduG8hqjjSCeQVH9S8NOYE
	 xL/ZgDDvTITfJv6qdWtXqSpzLGVGYXtAG4wSXmd7wN7WrkaDjnQIsBpriUooRMj0FO
	 clxbHMNk3FUSg==
From: Niklas Cassel <cassel@kernel.org>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 0/4] pci_epf_alloc_space() cleanups
Date: Wed,  7 Feb 2024 22:39:13 +0100
Message-ID: <20240207213922.1796533-1-cassel@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello all,

Here comes some cleanups related to pci_epf_alloc_space().

Changes since v1:
-Picked up Reviewed-by tags.
-Fixed kdoc param name to match the actual param name in patch 1/4.
-Split patch "improve pci_epf_alloc_space()" into one patch changing
 pci-epf-core.c (patch 2/4 in V2) and pci-epf-test (patch 3/4 in V2).
-Perform the alignment even for fixed size BARs. We need this since:
 1) Some platforms have fixed_size_bars that are smaller than the
    iATU MIN REGION.
 2) No longer doing so would be a functional change and not a cleanup.


Kind regards,
Niklas


Niklas Cassel (4):
  PCI: endpoint: refactor pci_epf_alloc_space()
  PCI: endpoint: improve pci_epf_alloc_space()
  PCI: endpoint: pci-epf-test: remove superfluous checks
  PCI: endpoint: pci-epf-vntb: remove superfluous checks

 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c | 13 ++-----------
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 15 ++-------------
 drivers/pci/endpoint/pci-epf-core.c           | 15 +++++++++++++--
 include/linux/pci-epf.h                       |  4 +++-
 5 files changed, 21 insertions(+), 28 deletions(-)

-- 
2.43.0


