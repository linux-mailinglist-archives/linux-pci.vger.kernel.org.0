Return-Path: <linux-pci+bounces-27090-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABB0AA756F
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 17:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1390E1C06071
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 15:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0562571AF;
	Fri,  2 May 2025 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzCQfIz7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C152566E9;
	Fri,  2 May 2025 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746198029; cv=none; b=Dqb/quqTaGXL1HqbG9N6LR4qB0OeKtQBi2zh6sQ675oVjlncBgO9SmibwZzhGxwwvdSlbUJ75g02d7OdomPN6r8639C9COR7YvnXQt9U5OtXoNhKlP/F3zFiUZTR6TWzvAQ+ZgjEXMNqel60XIj7Jon0WEaiedFn8lpwCgLvDSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746198029; c=relaxed/simple;
	bh=8aiCnHx6TWw1iE5xKN7o3tAkYwOoStTtmDIkoORe3Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=F4TJsQmlI1XnXveh6uNTxmx70aGa0AAU4i5uLWmtgZQVHGQZqUNIpddY3hhqsrngUJ7UW2P1ahj4KqrkzFTl5PH+muQFpYTPzU23kzb6DHxShlA4C5Sf8My6n38bO7S/pHDIkWenDu8uYzF/IbC6C5Wzgj2C4+1xfhjGkzZKjxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzCQfIz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EC5C4CEE4;
	Fri,  2 May 2025 15:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746198029;
	bh=8aiCnHx6TWw1iE5xKN7o3tAkYwOoStTtmDIkoORe3Zw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dzCQfIz7v1iUmcBwntCNPQxjLJrJREtBsxmKbr9i3UUBx3u/ubcBCcwXfl/6C9UV+
	 0xNYx8a82Z4L44tov8D14FsRRHCjZj8UbIMlElbuGycFH4DcqeArKFccRiMGkONMeM
	 uL9W0AZl8Cu0H+BwlbATo715JqAqMsrL5VrDbpyGVakDzSL0a5cpx1XZILGyglmAxi
	 jPGGTfalfwwzPgdD1cHtQ1VltFOcAewjFDK5C9PNhvebOfGHY1F6esK2QLzwF17mRc
	 RawJLZEpm71wD1BO1DJp8Ja/c8fdheHTzka6OkZI25YL09wqc1zX81FK6k0vb/yvl6
	 8g4USY6yetoWQ==
Date: Fri, 2 May 2025 10:00:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: hans.zhang@cixtech.com
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	manivannan.sadhasivam@linaro.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Fix system hang when ASPM L1 is enabled during
 suspend
Message-ID: <20250502150027.GA818097@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502032051.920990-1-hans.zhang@cixtech.com>

On Fri, May 02, 2025 at 11:20:51AM +0800, hans.zhang@cixtech.com wrote:
> From: Hans Zhang <hans.zhang@cixtech.com>
> 
> When PCIe ASPM L1 is enabled (CONFIG_PCIEASPM_POWERSAVE=y), certain

CONFIG_PCIEASPM_POWERSAVE=y only sets the default.  L1 can be enabled
dynamically regardless of the config.

> NVMe controllers fail to release LPI MSI-X interrupts during system
> suspend, leading to a system hang. This occurs because the driver's
> existing power management path does not fully disable the device
> when ASPM is active.

I have no idea what this has to do with ASPM L1.  I do see that
nvme_suspend() tests pcie_aspm_enabled(pdev) (which seems kind of
janky and racy).  But this doesn't explain anything about what would
cause a system hang.

> The fix adds an explicit device disable and reset preparation step
> in the suspend path after successfully setting the power state.
> This ensures proper cleanup of interrupt resources even when ASPM
> L1 is enabled, preventing the system from hanging during suspend.

Maybe there's a clue in the 600 lines of debug output that I trimmed,
but without some interpretation, I have no idea how to find it.

Unless you see similar problems on other systems, I would suspect an
issue with the SoC or the SoC driver where you do see problems.

Bjorn

