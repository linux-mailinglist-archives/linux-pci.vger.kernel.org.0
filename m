Return-Path: <linux-pci+bounces-43139-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B04CC4636
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 17:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 499513031046
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 16:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FA83195F4;
	Tue, 16 Dec 2025 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opuDQwUP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A953191C9;
	Tue, 16 Dec 2025 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765903580; cv=none; b=l6qyPVozutX6mp8PiC5VSV0llItB9Wbd1zLOcV+hwgmewwVxR8toylCgD7C+mhUpeN9Ht4qmQfqFdtW6n/qFTwzVr3Ry3dBXb4MShKvlcR4iQ5dfdVKczI17kB7+6bX3YAAso+KP8JiJupodCGDG7IGA0OTjKMjdxpqGsIKKv28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765903580; c=relaxed/simple;
	bh=fdsOlCqDmuoC8xqnbQE/ACVjDKZxdyqPXG0FiRF1xhk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PKOgY26b25yyFOdOn2BuHAp0ZcIGgVS4cNWD+S13SHAOwhNO+f/4dbgbCscfpB3AJ6ozjGjrJ4TXohuAzKif8w2CeLMW9eTMZOpHrNU86TBifuT0qTOrlQu/UdfFpgFoSjVOXtDZEqfvwSIkn2fknecFf6psXRsrAfbTybjJkp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opuDQwUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352C2C4CEFB;
	Tue, 16 Dec 2025 16:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765903580;
	bh=fdsOlCqDmuoC8xqnbQE/ACVjDKZxdyqPXG0FiRF1xhk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=opuDQwUPFOReBmmQ1y8Ih+R1Cvmv+iSgrCE5VcjSJrUr5X3ldKe9arMmZK4VtzQxV
	 ozjHU5Czv9rNh7QWzL5iC2US7DxP1livhjpkszoD05ubGpWgTNS6GsdK21KeMIDV3+
	 37v+K9ncDsLleInfqHVKKFSBR9jwhtIXZFwKGduFkQyccrxZR9FuG5Ufm1y9FPhBE7
	 v0fOmFrLoSWfvCCbpm8PdTa/7+SDvVOiaUaqffoSEZaVL47hubZ7V14VTjdy/7bAgv
	 KubiqdM9HdaWT4XUFJ8Q90PtQYWeXyPk7/goD6BuUG7/L3MWWA7GtJg2iRYQL54P7k
	 DW5NxOucjBLMA==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>, 
 Cezary Rojewski <cezary.rojewski@intel.com>, 
 =?utf-8?q?Amadeusz_S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Liam Girdwood <liam.r.girdwood@linux.intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Daniel Baluta <daniel.baluta@nxp.com>
In-Reply-To: <20251212181742.3944789-1-andriy.shevchenko@linux.intel.com>
References: <20251212181742.3944789-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] ASoC: Fix acronym for Intel Gemini Lake
Message-Id: <176590357497.182908.10897215642693418711.b4-ty@kernel.org>
Date: Tue, 16 Dec 2025 16:46:14 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Fri, 12 Dec 2025 19:16:20 +0100, Andy Shevchenko wrote:
> While the used GML is consistent with the pattern for other Intel * Lake
> SoCs, the de facto use is GLK. Update the acronym and users accordingly.
> 
> Note, a handful of the drivers for Gemini Lake in the Linux kernel use
> GLK already (LPC, MEI, pin control, SDHCI, ...) and even some in ASoC.
> The only ones in this patch used the inconsistent one.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Fix acronym for Intel Gemini Lake
      commit: a1bcb66209a745c9ca18deae9f1c207b009dee1c

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


