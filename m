Return-Path: <linux-pci+bounces-37006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91802BA0AE0
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 18:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593A016B6ED
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 16:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C996307ACE;
	Thu, 25 Sep 2025 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1UcREtj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E3422B8AB;
	Thu, 25 Sep 2025 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758818572; cv=none; b=iMtaqlTHgvU7UxhDJIVPyUVQ3nKa/Yev0iPVSQmoeZ/gqES+foAVotvethWl6f6PEagmMrZa43oRKtb+kKuaPrk52N3WB5G0geg6OiVuM5GnrcKCKtUuqtjfockYB/3nW/SuYWNDph3aTVP7PTEHoUBD1cGkHpGRcktiRr3lP3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758818572; c=relaxed/simple;
	bh=5i6ha+N8IEneXDI60JExaJWalQFZv2+fTq6zUyyVfEI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=javXilQF7PsVHnMH0Bp75F91MPTGZ1xdSJrq1uLpvZKeNJilernE5EgGlFLkr4phhdtwu4aLUuFZLWWplNSWFgYOPJrqLhnDR8zMogFx4E4zIRmkbnTECP3zkL1iSaRv4HZV4vnGolMXRBVAdOWb3lvTcOVTN11j3TE2u7Ueg3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1UcREtj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3384BC4CEF0;
	Thu, 25 Sep 2025 16:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758818571;
	bh=5i6ha+N8IEneXDI60JExaJWalQFZv2+fTq6zUyyVfEI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=T1UcREtjMCiQRCxVKqys2FBCPxFP2kBwEpP31NIbI9agCgzAiQDdB61Vq47QCZASe
	 g6ql46VT2P2wPYnPy2H7lCnsx0eZHIdTtRNFRgspXDm6Om152EICwOP0hCsqSNz9ER
	 BiojBWy4Ve3jUwvXlxpdSp3J9/KTKC3tjY2wuwSYOBfezy5NynaxKtzRmYwhqli7l/
	 qh+PLHc3B2o2x1ibgRvopyqXNQH6XJ9dli0MZn96lUOkWYsjlLOCdmD2sgPqWT7n8a
	 /TWiaeLjJovaQmt2Ld29UPijqk/xTOIvIAwxq8mN1FW9o6i8ikbdIlulbhdCyUsdVF
	 ZRu3BaLy/9lLA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: stable@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org
In-Reply-To: <20250922150811.88450-1-marek.vasut+renesas@mailbox.org>
References: <20250922150811.88450-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] PCI: tegra: Convert struct tegra_msi mask_lock into
 raw spinlock
Message-Id: <175881856680.391347.7490964130330685469.b4-ty@kernel.org>
Date: Thu, 25 Sep 2025 22:12:46 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 22 Sep 2025 17:07:48 +0200, Marek Vasut wrote:
> The tegra_msi_irq_unmask() function may be called from a PCI driver
> request_threaded_irq() function. This triggers kernel/irq/manage.c
> __setup_irq() which locks raw spinlock &desc->lock descriptor lock
> and with that descriptor lock held, calls tegra_msi_irq_unmask().
> 
> Since the &desc->lock descriptor lock is a raw spinlock , and the
> tegra_msi .mask_lock is not a raw spinlock, this setup triggers
> 'BUG: Invalid wait context' with CONFIG_PROVE_RAW_LOCK_NESTING=y .
> 
> [...]

Applied, thanks!

[1/1] PCI: tegra: Convert struct tegra_msi mask_lock into raw spinlock
      commit: 39ec28d01d565030aa28d87a212d201c252c072e

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


