Return-Path: <linux-pci+bounces-25686-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971D8A864A1
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 19:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC90D8A150C
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 17:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B0E22CBE6;
	Fri, 11 Apr 2025 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWamaEh8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD43621ABDC
	for <linux-pci@vger.kernel.org>; Fri, 11 Apr 2025 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744392094; cv=none; b=KuSO6tzZTkw7+rHVcWCMmqF7ZqNGFrGkJZ6ndqgihSDFan6VcdI5rTAoNT2vVMTn4RrhN6VF+skQqkbm7H4v7UyCHMB1bhn8O0BN2GZXDeA1H81dS2K39rkfC+N3WNovZOoVWis0HG1csLjd/HsrEFzKCD/BIcoovAzCRjui72s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744392094; c=relaxed/simple;
	bh=H8+4VkLbIZ37bxtdO3XRXDhHx7Qt+l4gVeio16wR7/0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OFvi849F9BIleA7XebwtGmtmS9FpOkOT1wooive3HFP7WZYvrZO3m6jHyqiYP+Yq1uHp+tiO1r8Ieg/N03oHFHOCP+y7u0eoTHdlPfn4CSU223jLVCjmVo3Kb4pH67/L4CSef/7aY1EdEnyP6D5Dge5BgEhzFEl5+7k1Rys3ZUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWamaEh8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D23C4CEE2;
	Fri, 11 Apr 2025 17:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744392094;
	bh=H8+4VkLbIZ37bxtdO3XRXDhHx7Qt+l4gVeio16wR7/0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FWamaEh8mlR/rHlkYmbrmabgnf9FfsVHaJTGikvZMuuaDD9F2NY6UujD0i615N0Wy
	 6ZZg0ci3mkEFW6U9NHo3CRYSZ7Gg7JbDsbtItqywnJtQeoaAw5Esw43qY5qHnJA1RG
	 wAioYnzFHjBaHLYKcS4nSWj/lzmxW10aSRUP+JMXtpCiUqWibEwRTu6S/gh/A7woH7
	 H/cxo9FC1temG66EyyO2aCo6TzRlFUaU3KQQH3iW8LEDGNqag9/Ihgq7MqgXspwxz3
	 w31p7vvy41DWYLGIcweqEzOIWHCSJR1w1qeRcudmt5EPJs7ttUKydxIVPmSpYeq4l0
	 pPodR0h9XjxxQ==
Date: Fri, 11 Apr 2025 12:21:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Add system PM support
Message-ID: <20250411172131.GA368959@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1744352048-178994-1-git-send-email-shawn.lin@rock-chips.com>

On Fri, Apr 11, 2025 at 02:14:08PM +0800, Shawn Lin wrote:
> This patch adds system PM support for Rockchip platforms by adding .pme_turn_off
> and .get_ltssm hook and tries to reuse possible exist code.
> 
> It's tested on RK3576 EVB1 board with Some NVMes and PCIe-2-SATA/XHCI devices.
> And check the PCIe protocol analyzer to make sure the L2 process fits the spec.

Sorry I didn't see these before you fixed the 0-day bot issues.

Please wrap the above to fit in 75 columns to it doesn't wrap when
"git log" indents it.

> [    1.541394] nvme nvme0: missing or invalid SUBNQN field.
> [    1.548755] nvme nvme0: allocated 64 MiB host memory buffer (16 segments).
> [    1.562235] nvme nvme0: 8/0/0 default/read/poll queues
> [    1.563930] nvme nvme0: Ignoring bogus Namespace Identifiers
> 
> echo N > /sys/module/printk/parameters/console_suspend
> echo core > /sys/power/pm_test
> echo mem > /sys/power/state
> 
> [   58.443602] PM: suspend entry (deep)
> [   58.444005] Filesystems sync: 0.000 seconds
> [   58.445542] Freezing user space processes
> [   58.447096] Freezing user space processes completed (elapsed 0.001 seconds)
> [   58.447718] OOM killer disabled.
> [   58.448008] Freezing remaining freezable tasks
> [   58.449080] Freezing remaining freezable tasks completed (elapsed 0.000 seconds)
> 
> ...
> 
> [   58.797070] rockchip-dw-pcie 22400000.pcie: PCIe Gen.2 x1 link up
> [   58.835953] OOM killer enabled.
> [   58.836262] Restarting tasks ... done.
> [   58.839241] random: crng reseeded on system resumption
> [   58.840679] PM: suspend exit
> [   59.500036] nvme nvme0: 8/0/0 default/read/poll queues
> [   59.500909] nvme nvme0: Ignoring bogus Namespace Identifiers
> 
> time dd if=/dev/nvme0n1 of=/dev/null bs=1M count=1000
> 1000+0 records in
> 1000+0 records out
> real    0m 5.51s
> user    0m 0.00s
> sys     0m 0.71s

Please remove the timestamps because they are distracting details not
relevant to understanding the issue.

Indent all this quoted material two spaces because it's not part of
the narrative text.

There's no hurry; you can wait a few days to repost in case others
have more substantive comments.

Bjorn

