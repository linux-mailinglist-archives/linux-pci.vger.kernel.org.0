Return-Path: <linux-pci+bounces-11213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91979465E0
	for <lists+linux-pci@lfdr.de>; Sat,  3 Aug 2024 00:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26AC11C2119F
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 22:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A307849622;
	Fri,  2 Aug 2024 22:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojgRO6N5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0CB1757D;
	Fri,  2 Aug 2024 22:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722637341; cv=none; b=CF39onZfeXnWMvQ7laeug0RMFPP2LELkllh5+12hLfkoYgK/pIXlXvMCLZb/UbExVxvmhNDJY0mff6d+6CPFx+hn+3kwlU/HJDgEoCq+aSF+p+FCE7FQM8Cn60aMdV8jlsVwI+fUvuMwhINgqhWHNo40wveYHJTZ7kcvDFzLN6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722637341; c=relaxed/simple;
	bh=/eVmcksdoa4kQw5S2+wVUPx1PaMX3q1iFd1MtgTYtXM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sxuw9PXjK/O4PnByqZTPa7iyJSm/ccQNAnZQKj5Dg0JYQtShPhe8gG95hQs/Vw14t5QA3R+3hEjbI00cnZef52ChX/HpTwDRYcKBl9hg1/4kV0kYUYHba3hFZNJpnKiU4EwJm9qAE8+H4KZz5y015S0hm5XTPB/IOyKXqkXbhqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojgRO6N5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D828EC32782;
	Fri,  2 Aug 2024 22:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722637341;
	bh=/eVmcksdoa4kQw5S2+wVUPx1PaMX3q1iFd1MtgTYtXM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ojgRO6N5BMItB/nYMai2Kn/KR9U06/FwsCs738VezxjlaQnVp5KZ1XJVsXt0fnSPS
	 +vS3mdb+fhV0K6kjiGEvbgF0hocL4ACGcSOAoeko3wMrfT4LAsofwiTqwMbe9l+MRi
	 uxczxvRrKnfUyW9ocPxkLrqKDIMdMh8SsTrgTYO7Sj3hynmuEBoL4VsUYcJgfttyi0
	 E/eMnUl+ruGlPiRlzvSyYu/q9oZKYDYlLjBzqi+P0lpMxVyMv4tgH0ds1M3GIj5zNu
	 BTZeEXKZeOu68yZgpS+SuQ4Pb24i9YchQP/tiJRuccUsLEYf5n+SQx4sVdA1/Rdp5/
	 pQNkqBmZXm7Iw==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
In-Reply-To: <20240802124011.173820-1-pierre-louis.bossart@linux.intel.com>
References: <20240802124011.173820-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v4 0/5] ASoC/SOF/PCI/Intel: add PantherLake support
Message-Id: <172263733961.144413.228232614375148648.b4-ty@kernel.org>
Date: Fri, 02 Aug 2024 23:22:19 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Fri, 02 Aug 2024 14:40:06 +0200, Pierre-Louis Bossart wrote:
> Add initial support for the PantherLake platform, and initial ACPI
> configurations.
> 
> All the dependencies required in the initial versions are now
> available in ASoc for-next branch.
> 
> v4: topology name simplification for rt722
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: Intel: soc-acpi: add PTL match tables
      commit: 6a965fbaac461564ae74dbfe6d9c9e9de65ea67a
[2/5] ASoC: SOF: Intel: add PTL specific power control register
      commit: 42b4763ab301c5604343aa49774426d5005711a3
[3/5] ASoC: SOF: Intel: add initial support for PTL
      commit: 3f8c8027775901c13d1289b4c54e024d3d5d982a
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


