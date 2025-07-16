Return-Path: <linux-pci+bounces-32281-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E1DB079BE
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 17:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B1D1C25705
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 15:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4091C2F6F83;
	Wed, 16 Jul 2025 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OS9vTLlE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BC92F5C5C;
	Wed, 16 Jul 2025 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679288; cv=none; b=I9LEqFcBokXCC92vOoVgFmv14qG7RgcfYm5+3QnB8RRaGRVbuXXTnzzg2/jECKl+NFJPlygqcwNNFj0idBKkYb9/x4Kxg2cXSneKFgO8Jb+p7xflGWECeUUxVPEjtQI988xLtPfpRa9WMEIGdZtdOWMOtpt7X0pmT7B9RKiwnFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679288; c=relaxed/simple;
	bh=+5nBuTaHK2eqj8Sbjf7jOgP+gLLgEVm3azLVcfpx7Wk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZhvONk02sE4kniATsLTn5MvS4EPI1XIYShROdJIzEweBwxnVwMlke9HEk7iK7crlcUGr6S+17eefaiVYJi88Tu2Wmj9yyajEANtKzXhTt7aEFMVq3IHkxF5Ja42o7uQby8oog1bxkvVDHxSu+bO+zlFNhODl5ZwUyHTXkSDtSKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OS9vTLlE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D37C4CEFC;
	Wed, 16 Jul 2025 15:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752679287;
	bh=+5nBuTaHK2eqj8Sbjf7jOgP+gLLgEVm3azLVcfpx7Wk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OS9vTLlExI0ev1o7vTPmfJqaiGDqDFdXLIYU/2oNar9+GE0p2sFREnmEPM9tchhJs
	 L1Y2aUgJ4GkDvZyEazbL1L4zjmorIK5QnLjOF5jQ53IdaQ865dzJqVFtTLE1IAo27A
	 RvDAwYt17LRGns6LsX/cnluz58W0pJAFqXqJ7Vr/bV7i/gQg+DN7Sp0ck+1Yd2EW66
	 KAiEFjBbdQKlsYfAto11NOc+gChFKfdj9FN85e4nGDbF2oMyRkkXd2lKBnS4GyIP7N
	 yAaR39a7tCBwUcM5duceF2G1CYskt7SaW0TbDtgxAdJVQX0D5dotcL1wbeoKPl8FH9
	 KBOFS1Hs7+Khg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C64EB383BA33;
	Wed, 16 Jul 2025 15:21:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] PCI: host-generic: Fix driver_data overwriting bugs
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175267930756.1224517.4628176951767870692.git-patchwork-notify@kernel.org>
Date: Wed, 16 Jul 2025 15:21:47 +0000
References: <20250625111806.4153773-1-maz@kernel.org>
In-Reply-To: <20250625111806.4153773-1-maz@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-riscv@lists.infradead.org, bhelgaas@google.com,
 alyssa@rosenzweig.io, robh@kernel.org, mani@kernel.org,
 lpieralisi@kernel.org, kwilczynski@kernel.org, j@jannau.net,
 geert+renesas@glider.be, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Bjorn Helgaas <bhelgaas@google.com>:

On Wed, 25 Jun 2025 12:18:03 +0100 you wrote:
> Geert reports that some drivers do rely on the device driver_data
> field containing a pointer to the bridge structure at the point of
> initialising the root port, while this has been recently changed to
> contain some other data for the benefit of the Apple PCIe driver.
> 
> This small series builds on top of Geert previously posted (and
> included as a prefix for reference) fix for the Microchip driver,
> which breaks the Apple driver. This is basically swapping a regression
> for another, which isn't a massive deal at this stage, as the
> follow-up patch fixes things for the Apple driver by adding extra
> tracking.
> 
> [...]

Here is the summary with links:
  - [1/3] PCI: host-generic: Set driver_data before calling gen_pci_init()
    https://git.kernel.org/riscv/c/bdb32a0f6780
  - [2/3] PCI: apple: Add tracking of probed root ports
    https://git.kernel.org/riscv/c/643c0c9d0496
  - [3/3] Revert "PCI: ecam: Allow cfg->priv to be pre-populated from the root port device"
    https://git.kernel.org/riscv/c/ba74278c638d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



