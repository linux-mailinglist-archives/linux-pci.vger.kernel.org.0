Return-Path: <linux-pci+bounces-37215-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD42BAA031
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 18:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058923BFAA5
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 16:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D963730B509;
	Mon, 29 Sep 2025 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQnM7lqH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9A11F5847;
	Mon, 29 Sep 2025 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759163167; cv=none; b=c6rjIWRLt1y6LaRJ6xKWeJP6tUJ4SuyGY+9B5czr6G55BZurmRgAQnMdS9fDqt9VxMMhAvwjQJ8HtMjc/nqoNSzRYR+u65sY60Sl79Spc5EAceAzKtARaqOzUcXp+t7uf3RLiDNQ12x8Q9wI1XTQugEcolok/3LZ1CfP62NxjSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759163167; c=relaxed/simple;
	bh=n0if5/wobIXPyvF3KwqHu1JX8P031jZWEl37VJeix0s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JVrNnRMAlpiVum/AKwQfejFbwB741fYX3fJm9as+6NGawmKV58xd/RxvY9x4rf+iwETdmokUPR4oqYDCeFcKjpK3gFb4uhMyp0y7h17Z/EYK7zdk1D4uvRZNv7LCZuHtOByG99dl2EAkKXZ7aowkmAAb2Ar37craQOXMKCjnhdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQnM7lqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4CAC4CEF4;
	Mon, 29 Sep 2025 16:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759163167;
	bh=n0if5/wobIXPyvF3KwqHu1JX8P031jZWEl37VJeix0s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VQnM7lqH4fBMb/gAQxWR64StlfAtEjOmDPHwjQC5YGdqPLC89jPK3sTi3j7AIqb/3
	 gVrprAr/vMl68WzqYgir1S6jcWc+1pFwccrQek2avmUhyOYrqfUh/EAlL+BXpu18xY
	 pdHF4hIL8zAXLFk7olbgnFcbfwNJWibFN1NGRtPrGAfb6B9AC2YJGtHuQfRbkykS1m
	 flexMNx98LgiGaoKjqat/OneqlffYAd3rTXkO3JBx5v+tvhOEEqv9En3ovlYHACGiA
	 aqWGeLXMCIzrOzgNW12G2jtYbP6Uo6F4nuQkWicHM+EOntV1HEYGyTRnBrnQwtN1Xj
	 x68VuqzZP9MsQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
 bhelgaas@google.com, cassel@kernel.org, kishon@kernel.org, 
 sergio.paracuellos@gmail.com, 18255117159@163.com, jirislaby@kernel.org, 
 m-karicheri2@ti.com, santosh.shilimkar@ti.com, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: stable@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 srk@ti.com
In-Reply-To: <20250912100802.3136121-1-s-vadapalli@ti.com>
References: <20250912100802.3136121-1-s-vadapalli@ti.com>
Subject: Re: [PATCH 0/2] PCI: Keystone: __init and IRQ Fixes
Message-Id: <175916315956.16065.1110296363886173087.b4-ty@kernel.org>
Date: Mon, 29 Sep 2025 21:55:59 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 12 Sep 2025 15:37:57 +0530, Siddharth Vadapalli wrote:
> This series is based on commit
> 320475fbd590 Merge tag 'mtd/fixes-for-6.17-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
> of Mainline Linux.
> 
> The first patch in the series has been posted as a Fix in contrast to
> its predecessor at:
> https://lore.kernel.org/r/20250903124505.365913-10-s-vadapalli@ti.com/
> based on the feedback provided by Jiri Slaby <jirislaby@kernel.org> at:
> https://lore.kernel.org/r/3d3a4b52-e343-42f3-9d69-94c259812143@kernel.org/
> Since the Fix is independent of enabling loadable module support for the
> pci-keystone.c driver, it is being posted as a new patch.
> 
> [...]

Applied, thanks!

[1/2] PCI: keystone: Use devm_request_irq() to free "ks-pcie-error-irq" on exit
      commit: e51d05f523e43ce5d2bad957943a2b14f68078cd
[2/2] PCI: keystone: Remove the __init macro for the ks_pcie_host_init() callback
      commit: 860daf4ba3c034995bafa4c3756942262a9cd32d

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


