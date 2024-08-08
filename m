Return-Path: <linux-pci+bounces-11475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E08F394B8AE
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 10:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64758B2721E
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 08:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB251891BB;
	Thu,  8 Aug 2024 08:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+OsZ9bY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A65F18950E
	for <linux-pci@vger.kernel.org>; Thu,  8 Aug 2024 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723104756; cv=none; b=TP+1H6ZMJUHv3ecli253ODcAxAp3ASkapack88zdOYWVtiDQARmbeEdwsVoHdziPz9bM4og7rROEU7IQb3S8LePUxMjpVRem8QrqpRsqOKtjrWrtchuUnDOVfpU6ips0DtE/RMFTxI9PtUf/3m+W8MwzzLeqNSxuYJqL5lh9N88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723104756; c=relaxed/simple;
	bh=jgHwr9Okfk2sRqCjWHFXlZf9bF+lKonWrMQM1FrvR+8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JrngPGIA6XH1jH+yZSbbAe9eVS5StyOWEVbKlB7+BRb3qOp30r8mEnzS0ltON7/kHR3zJK5GXR8Dr6Xe5vhhjwCRzqsbqWQMWYuJGmqhp4qVSOCzk4QygPNSvUm3JPEXn4IeZTJN3/8uJxQTsHqQPAG9sruoBsVRojoFkpzSAco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+OsZ9bY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9DEC32782;
	Thu,  8 Aug 2024 08:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723104755;
	bh=jgHwr9Okfk2sRqCjWHFXlZf9bF+lKonWrMQM1FrvR+8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=s+OsZ9bYS+ihavXQiZLf9Dc+jQe+TFXhg36/Z/BdFzPerYG9dsNFHpRVAUwNK3c8O
	 Up91Xv3MoIAU/RsSrv/5HIEc+BFYn6hHDfgZPC/V0iiMRFWOWF4DddfGhprZtd0K3q
	 ZyUeZj61C9NgEwjCDSf9u1GUu6VjxJJwr3CVSSXtPIzsv+4s/CWJnJTrBTEn2wkhHP
	 0mt4lg38vrfBpw4RabhJ/Xoe6Ko/IIlpc7wF8SXALAkzBnZAitzbvtsDdcshy8+A2K
	 UJCDVEpVu6AUcryzzd6Ze6BlYFCiDo5jS4GtJG40kkjP+bMS2Y1DB8kZfxNY4E+mfm
	 ZbPS3ExzlQ0Qw==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, Bjorn Helgaas <bhelgaas@google.com>, 
 linux-pci@vger.kernel.org
In-Reply-To: <20240612065858.53041-1-pierre-louis.bossart@linux.intel.com>
References: <20240612065858.53041-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/5] ASoC/SOF/PCI/Intel: add PantherLake support
Message-Id: <172310475315.457425.16058679808608700383.b4-ty@kernel.org>
Date: Thu, 08 Aug 2024 09:12:33 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Wed, 12 Jun 2024 08:58:53 +0200, Pierre-Louis Bossart wrote:
> Add initial support for the PantherLake platform, and initial ACPI
> configurations.
> 
> This patchset depends on the first patch of "[PATCH 0/3] ALSA/PCI: add
> PantherLake audio support"
> 
> Bard Liao (2):
>   ASoC: Intel: soc-acpi-intel-ptl-match: add rt711-sdca table
>   ASoC: Intel: soc-acpi-intel-ptl-match: Add rt722 support
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: SOF: Intel: add PTL specific power control register
      commit: 42b4763ab301c5604343aa49774426d5005711a3
[2/5] ASoC: SOF: Intel: add initial support for PTL
      commit: 3f8c8027775901c13d1289b4c54e024d3d5d982a
[3/5] ASoC: Intel: soc-acpi: add PTL match tables
      commit: 6a965fbaac461564ae74dbfe6d9c9e9de65ea67a
[4/5] ASoC: Intel: soc-acpi-intel-ptl-match: add rt711-sdca table
      commit: 77a6869afbbfad0db297e9e4b9233aac209d5385
[5/5] ASoC: Intel: soc-acpi-intel-ptl-match: Add rt722 support
      commit: 2786d3f4943c472c10dd630ec3e0a1a892181562

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


