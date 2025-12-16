Return-Path: <linux-pci+bounces-43138-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27430CC46B7
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 17:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 188303034608
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 16:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727423195E6;
	Tue, 16 Dec 2025 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRquJFYH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D2820ADD6;
	Tue, 16 Dec 2025 16:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765903576; cv=none; b=N2fVO8QC7npCA+lX9LUeO9C4ObWE4hIxKmud5lJdOa3di7tnOelFY/aXATTmHoCVLt0NaoUkaNnuhUJKYycD7WC2HpJYceMV6rvZLcNNJ61a2MWmYDt4+ovxPNmLdfN4vZ+ravYD8YCPv3ZTab3r/ue24EXSyUPqlX2OO5YcCN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765903576; c=relaxed/simple;
	bh=5CwUUexiIQST513DgLigNSF5cGgdMoR7uQc7MySxilU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kYMlpAIbYNnWteXL/aa6dB1921RMjiKwvONHo4p64xnSbFyliKGb4V9Z/TiY5vryYVo2nUNKyN5lafQlH/yh5TtbP+6AGYrwRgSno/wcy6LAqPyDtrnz1VqYwS/Pvzlcn7RPYdDGgw00DLbIMfciD3wRQDWYBFma4pslwCX1NoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRquJFYH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E011AC4CEF1;
	Tue, 16 Dec 2025 16:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765903575;
	bh=5CwUUexiIQST513DgLigNSF5cGgdMoR7uQc7MySxilU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uRquJFYHjxtIlwk4Nt7UsyESHB/0H5RKWskwQGerNxQqo4pA9K9y1cxIbuL/DmodE
	 dhTGBKDzn95vOCv6dpC/1GgGXK6Vnkk8QH7uZOfpZ42dIiVoHWNOPRQxqsRvs3J4pH
	 GiGlPXepF6XWTBnYNPLlMhvGYeEY8BMtytP/k+sw7Z/+wQByMzFJHJT5658yuVu5sy
	 sEnm5TBy+5jRNTDhfwBHf9iMc+oFkSllGEuLU5hP8yfjYxn9zClNebBzkFSK5B//D4
	 yTQBzdxuiHBSJqtDhfhzHDx6zXUl9s12ZaMruFgyv62IPI3rau8Kwm1uoSUqW+WbSd
	 GWlMgeELjmIyA==
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
In-Reply-To: <20251210115545.3028551-1-andriy.shevchenko@linux.intel.com>
References: <20251210115545.3028551-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] ASoC: Fix acronym for Intel Gemini Lake
Message-Id: <176590357062.182908.3190072411951118961.b4-ty@kernel.org>
Date: Tue, 16 Dec 2025 16:46:10 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Wed, 10 Dec 2025 12:55:44 +0100, Andy Shevchenko wrote:
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


