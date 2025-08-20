Return-Path: <linux-pci+bounces-34410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A65B2E68E
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 22:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BDF61C271A2
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 20:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918E729ACF0;
	Wed, 20 Aug 2025 20:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJ6dOBt1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EAF299954;
	Wed, 20 Aug 2025 20:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755721484; cv=none; b=FNhmPgn1n2KWz1gKuHWmNAKHozPugrzy0+8PRJvol9QPYfYE8p+960kl4Khuwcs5bf0A37s/ahXuN7q2Pzwv0JIA1gNCbWVlq+KKWDltOpReBDM2YogI3DO8h7sqbVrNnBB2JtDa4q4fREaxYPyP/zrNFC+1UFNFbeshj/AJ/oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755721484; c=relaxed/simple;
	bh=C/5m1s50Fyg1uplwgRLOF5gC4bP0ivxYDJ+ilHb4/jI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bpV5WLNKkDexAhBlS0GsedElLfppwD+fS/IhE5DCVJSUDGUKKItSEUjaeH/oj7z5joo46uRJ04C5dyKh0Nr8LOil8vWllmHG8ld7AnEw0mACloaoA0JbzNPWj8FYlSCRNamstP8a7DHQytdKs+/iSrj3qJDSitKqBJpSjm71Y2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJ6dOBt1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63729C4CEE7;
	Wed, 20 Aug 2025 20:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755721483;
	bh=C/5m1s50Fyg1uplwgRLOF5gC4bP0ivxYDJ+ilHb4/jI=;
	h=Date:From:To:Cc:Subject:From;
	b=oJ6dOBt1WFSpmrIQzsEE1PbBrX8PgsMFmA84xEr66fi4S7klN6yKJgQ3WyUtSCEdV
	 UYmCP2h/L/d415xPz9fg4kNuqVfCgzW2mND/GQWzRX/4v6dzcuzz41cRhZ17c0//pI
	 2jL+cI0IMOKAAoMoprY6/LA52xFkQ4xyfEIm96Q6fQakcaOZJGnjGsiIzSWK+Docvm
	 Wroe9nhm7k62oBily+Otd1cmqcrnpeVB77IyWiOMwfJoHiJeN9JCL6Vaz4tPZJqaLq
	 0xUwINYWN5o3w9HvfJ+SvWMTp3A9ZFjreAG2A73Azs1pSKEiMnwkUoGMk9lGNNw9ee
	 sDbdNpTRdyAvQ==
Date: Wed, 20 Aug 2025 15:24:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [GIT PULL] PCI fixes for v6.17
Message-ID: <20250820202441.GA638554@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.17-fixes-2

for you to fetch changes up to 5149bbb56bdcf5c5f72904025fbb502217580b63:

  PCI: vmd: Remove MSI-X check on child devices (2025-08-12 13:45:01 -0500)

Both fixes are for regressions that appeared in v6.17-rc1.
----------------------------------------------------------------

- Remove vmd restriction on children using MSI-X because VMD does in fact
  support both MSI and MSI-X for children (Nam Cao)

- Fix a NULL pointer dereference in the xilinx interrupt handler (Nam Cao)

----------------------------------------------------------------
Nam Cao (2):
      PCI: xilinx: Fix NULL pointer dereference in xilinx_pcie_intr_handler()
      PCI: vmd: Remove MSI-X check on child devices

 drivers/pci/controller/pcie-xilinx.c | 2 +-
 drivers/pci/controller/vmd.c         | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

