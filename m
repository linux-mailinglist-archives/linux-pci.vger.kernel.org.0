Return-Path: <linux-pci+bounces-42974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6206CB6F3F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 19:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADBB83018B92
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 18:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586E1272E45;
	Thu, 11 Dec 2025 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snox+pyC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ADE219E8;
	Thu, 11 Dec 2025 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765478980; cv=none; b=aTscInI4bxvlJdI70CK8X7qUOVK9j03Zycei9B8JAEhcGPsgHkFa41m4d7zcvDHu1+EzZnbHkl4MHm0HRt+wEOYg7WmxjHDSnFlhnoyD4o9Z2Fhbgo8XL321wm6YqrYyRaSIgrwp1zxuOer4tL74lzbAjiSI9FcbcMKg3mccJrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765478980; c=relaxed/simple;
	bh=LqnmPpmNLVWh1KPiT3MBe7zSENMx4TmJOv/2l85PnOk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j5fA1L+fMiTErAA+VkSuxUO14JRYCUUvrQbtK6B3sZiHPmN+2FITUwA1/h/sWp74oI8K16J9hQNd5SUPk50heN5/YJljzJNrTAYQ93fhI1wYREKanJyzaLG314PoXA3EBXr1uJ8FDNSYJgFGZTzBLtJzY+oKSymWEBVMHgbBFe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snox+pyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D4DC4CEF7;
	Thu, 11 Dec 2025 18:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765478979;
	bh=LqnmPpmNLVWh1KPiT3MBe7zSENMx4TmJOv/2l85PnOk=;
	h=Date:From:To:Cc:Subject:From;
	b=snox+pyCyoxjIWcbHdO7n5AcExL02lBl8BnDBSrC16iySd8MjYqoefUc/tIqlISMB
	 Yf6s7o0he+4jm2m2uHbO6CK47AFneKLc/u1f3gXSW4c8LiCoEP4EwSgwmOroFveTnA
	 nla9r0eTcAkkF7Ag4xRsa0JUTo4oIhIYa2on8WEDXUTVGnZGytbw+Lv6ETWodVi3AD
	 wlvpKQZ81TzNa1BYIB4vs7ftG2cGZIGC//qEtlbdCKlmduJhcGpkvNYjUj65fzFq8y
	 X6MUE2cItxVtND8dasRfYv5mRsQiFbQ580+7UZ0Wbei0XXxxlxLG40+eUoGki/rmlK
	 wPy3ZxnW4VSiQ==
Date: Thu, 11 Dec 2025 12:49:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [GIT PULL] PCI fixes for v6.19
Message-ID: <20251211184938.GA3604438@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 43dfc13ca972988e620a6edb72956981b75ab6b0:

  Merge tag 'pci-v6.19-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci (2025-12-04 17:29:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.19-fixes-1

for you to fetch changes up to 94bf74830a977a027042f685c7231c5e07cc3372:

  PCI: rzg3s-host: Initialize MSI status bitmap before use (2025-12-09 12:42:48 -0600)

----------------------------------------------------------------

- Initialize rzg3s_pcie_msi_irq() MSI status bitmap before use (Claudiu
  Beznea)

----------------------------------------------------------------
Claudiu Beznea (1):
      PCI: rzg3s-host: Initialize MSI status bitmap before use

 drivers/pci/controller/pcie-rzg3s-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

