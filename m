Return-Path: <linux-pci+bounces-9854-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE598928DAE
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 21:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E661F2249F
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 19:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05CE14374F;
	Fri,  5 Jul 2024 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2pFA3gK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6401132123;
	Fri,  5 Jul 2024 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720206316; cv=none; b=pm/JCbMyuoFKaI3aWkqvbKm/5IVYTfSPCfqHRaslSMIu+V9Ky9qzVOD2xWxJXEifwp2wr+elE/8iD/zYeWoKq9BpsIyfhLClXhJORLpgODEWxxqurGL2DDlQp059YMvGs6LKdjH4hCTT0JUFwsjMC5qBwK6BSS7nq/8nQNABQn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720206316; c=relaxed/simple;
	bh=LMlOvHMoTtCWNHgxApxYlsBCHydkvIY0tqr+FN+Hktw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rerljT2Z0l8ZVuiIqtac/EWQ/7y2W4emQy4LegAr2ri918XsyPwyot+i9E/sqZvGP1SieUyE6QaXo4BbP4Ntc9mkQsN7n/uHcDidvyAMV2CZGP5MepjI7DH2/bAzUYAfCB3HBeYutRfWw/PzztDPLIRlziMjRgp4eP36pSvydJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2pFA3gK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8241C116B1;
	Fri,  5 Jul 2024 19:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720206316;
	bh=LMlOvHMoTtCWNHgxApxYlsBCHydkvIY0tqr+FN+Hktw=;
	h=Date:From:To:Cc:Subject:From;
	b=U2pFA3gKJKRiVUpN/ADWvSJaYN+i/tJTEzFgBI3A61V/wyj63rn4ikP5cxYpHDGiF
	 xhv+W9L6H6/vE5Whsx9ejRzmN3hOgb/XS60Mbf+r+MbdBK2vZvR+x7YSAae1qam2gK
	 HXAN97jxJHzgL5JErY6xrfTC1ZX/Z6yh5Cn7saMJZdARRVGdMFt45ko1SIK/Jz1oUs
	 r7ATjhfJkLGGzpL+JNNNPv/dU8AeNybWNTo0u6ws+eO+e7VPFwanlVHcmTIWxXdm6u
	 Xv8soqhgl6C+dDQGXVQ288ThmztZuXyPiXb98NaISLkHpjTSQcuLjD+tBIJPw0LTao
	 P5JRl+T+RbnEw==
Date: Fri, 5 Jul 2024 14:05:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [GIT PULL] PCI fixes for v6.10
Message-ID: <20240705190513.GA72897@bhelgaas>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-v6.10-fixes-2

for you to fetch changes up to 419d57d429f6e1fbd9024d34b11eb84b3138c60e:

  CREDITS: Add Synopsys DesignWare eDMA driver for Gustavo Pimentel (2024-06-11 10:26:06 -0500)

----------------------------------------------------------------
- Update MAINTAINERS and CREDITS to credit Gustavo Pimentel with the
  Synopsys DesignWare eDMA driver and reflect that he is no longer at
  Synopsys and isn't in a position to maintain the DesignWare xData
  traffic generator (Bjorn Helgaas)

----------------------------------------------------------------
Bjorn Helgaas (2):
      MAINTAINERS: Orphan Synopsys DesignWare xData traffic generator
      CREDITS: Add Synopsys DesignWare eDMA driver for Gustavo Pimentel

 CREDITS     | 4 +++-
 MAINTAINERS | 3 +--
 2 files changed, 4 insertions(+), 3 deletions(-)

