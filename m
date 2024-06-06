Return-Path: <linux-pci+bounces-8408-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F77F8FF50D
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 20:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D06EBB23026
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 18:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AF24E1D1;
	Thu,  6 Jun 2024 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4Nu8RMt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF2E1BC3C;
	Thu,  6 Jun 2024 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717700367; cv=none; b=r47kWwZu+ElrUblnK1ZGL23Ty2PobgY0/n373V+XNPY0UDBY0iDxAUvWU5kAaC6dlC22N9gEdCogqszq13rl1obh0xRZys69Ze6sD/LiGOKgemy8ZC0wqSeRMn8yvrDjAa0nkuOOuJxQLHaRWjWulrfDxDOOzsqMViwDILg/w8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717700367; c=relaxed/simple;
	bh=FmIcLEU78RYqLgP+RXvK8d/zWUTgBjyUQnlYUUF65ns=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=s5jNcxOpkhF9yNQKO7Wy3C41R2/FnqnMe39erWXxJNILVngfSWVDK0KhhWwgYz39jQZmoLzMG5fLcfSkb1gumeZUeu5hdJqVYviari/ky2rhFOXLB8rHcnMuQ1SLJ3ELLHlSpgCYDJwZOh0XCx6ykiRlQmglAUoPLyWz+XfaQmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4Nu8RMt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C792CC2BD10;
	Thu,  6 Jun 2024 18:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717700367;
	bh=FmIcLEU78RYqLgP+RXvK8d/zWUTgBjyUQnlYUUF65ns=;
	h=Date:From:To:Cc:Subject:From;
	b=R4Nu8RMti0VThshaG+Ipzw7+E2qzgvmApl5iIwyNCSd9uekOQgF4f+sIjbm4SScE0
	 S1hNxxvHh7LYHGdlXotwqZqNCGEjn9Nw07cD77amXwMWElp/5S/AnZzF4UEtf3Mc5Z
	 eOnCtQR8mmfHc2G29WBZrXYQPmrrAbIm4mY0f7vpdDfS3FxK/bN+yn/h/XNsl0JyLS
	 8vNsuIFi/MsV9J8+qZTcC2w11Rt/HCSqABOryC285bag9L2u9vjF8d2c7fCLk03ATc
	 kfmq0xuvH63M5e7HWmSfKH8MhfSPF3dwmFs2SyaxsGjLOtJrY7zWGCyEpLHtIivUXU
	 KB6m+XcrCteIQ==
Date: Thu, 6 Jun 2024 13:59:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Imre Deak <imre.deak@intel.com>,
	Hans de Goede <hdegoede@redhat.com>, Kalle Valo <kvalo@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Jani Saarinen <jani.saarinen@intel.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] PCI fixes for v6.10
Message-ID: <20240606185925.GA810710@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.10-fixes-1

for you to fetch changes up to c9d52fb313d3719d69a040f4ca78a3e2e95fba21:

  PCI: Revert the cfg_access_lock lockdep mechanism (2024-06-04 12:10:05 -0500)

----------------------------------------------------------------
- Revert lockdep checking on locking that protects device resets from
  user-space config accesses; it exposed issues for which fixes are in the
  works but are too risky for this cycle (Dan Williams)

----------------------------------------------------------------
Dan Williams (1):
      PCI: Revert the cfg_access_lock lockdep mechanism

 drivers/pci/access.c    | 4 ----
 drivers/pci/pci.c       | 1 -
 drivers/pci/probe.c     | 3 ---
 include/linux/lockdep.h | 5 -----
 include/linux/pci.h     | 2 --
 5 files changed, 15 deletions(-)

