Return-Path: <linux-pci+bounces-39180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9CFC02B85
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 19:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E553A2DAE
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 17:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8AD347BDA;
	Thu, 23 Oct 2025 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSzrOFAd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416AE346E7C;
	Thu, 23 Oct 2025 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761240349; cv=none; b=A2ju6/QZBbOk9yTho3C03ZB628lO803Z7FV/wil7r5IW38XKXoQIxTWgyc6+yjxUsIZwVbn3jI71zi8KK8COrWvJY0pzmVQBch7ueVLVO//jeyfaxdSgPEfsLcvLb3WErKUrqujRkjBUT99Eiw52eG/zPmi/9mVPGv5MNU8YrWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761240349; c=relaxed/simple;
	bh=p/dJ/vApunxA+s6QBIXAzaXcbKhQS7npxWsjnyA0BqE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Gc8hu6zO3wWs/7H+AyDjzWMFa+pkH7sj7AWzDy9ZjHpeCWwuen+I0A+eHANZapKjVDYUm0ktooYUbGCdzXN3C4xb7rgeYJEuoSwci8OD7Mexx6ze2rhKZbAsjRyWfyqltbvZnGu3wTLwjmmk3lFsDECPgAT1EMFID5wh0PC9YjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSzrOFAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3073C4CEE7;
	Thu, 23 Oct 2025 17:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761240349;
	bh=p/dJ/vApunxA+s6QBIXAzaXcbKhQS7npxWsjnyA0BqE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OSzrOFAdUP2+iq21SXDJvO7gcOdJgs7IBoI58rESwucSX/8yODMGX20mkY1IDDj+0
	 i2lYBECfK2uXw0n8gk9gR34ZAuntJK+Flw4POjd+ptdrCFntp5iO68sGdfG/1D8P6Y
	 rbZ9MpUQU7LOaJP/s0c2DvqywAjrpY+j3OS/5Xd87HkZsHaB/nRK4jP4eB97AeR8Hr
	 8zzqsnKUQtUxFRZFXF+oB7l5GD/La2IN5zZs5HmZ2EcpbTrESxx8NAv7K5jWd6PNc7
	 uN33qIZoywxxKVHjqgkfhNju2vKaJrHQo6ePBZgeTHKlEOJUeQBAqCP/WtEUFnJ3sv
	 8se7tyNt+mwQQ==
Date: Thu, 23 Oct 2025 12:25:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Brian Norris <briannorris@google.com>,
	stable@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PCI/PM: Ensure power-up succeeded before restoring MMIO
 state
Message-ID: <20251023172547.GA1301778@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821075812.1.I2dbf483156c328bc4a89085816b453e436c06eb5@changeid>

[+cc Mario, Rafael]

On Thu, Aug 21, 2025 at 07:58:12AM -0700, Brian Norris wrote:
> From: Brian Norris <briannorris@google.com>
> 
> As the comments in pci_pm_thaw_noirq() suggest, pci_restore_state() may
> need to restore MSI-X state in MMIO space. This is only possible if we
> reach D0; if we failed to power up, this might produce a fatal error
> when touching memory space.
> 
> Check for errors (as the "verify" in "pci_pm_power_up_and_verify_state"
> implies), and skip restoring if it fails.
> 
> This mitigates errors seen during resume_noirq, for example, when the
> platform did not resume the link properly.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Brian Norris <briannorris@google.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
>  drivers/pci/pci-driver.c | 12 +++++++++---
>  drivers/pci/pci.c        | 13 +++++++++++--
>  drivers/pci/pci.h        |  2 +-
>  3 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 302d61783f6c..d66d95bd0ca2 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -557,7 +557,13 @@ static void pci_pm_default_resume(struct pci_dev *pci_dev)
>  
>  static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
>  {
> -	pci_pm_power_up_and_verify_state(pci_dev);
> +	/*
> +	 * If we failed to reach D0, we'd better not touch MSI-X state in MMIO
> +	 * space.
> +	 */
> +	if (pci_pm_power_up_and_verify_state(pci_dev))
> +		return;

The MSI-X comment here seems oddly specific.

On most platforms, config/mem/io accesses to a device not in D0 result
in an error being logged, writes being dropped, and reads returning ~0
data.

I don't know the details, but I assume the fatal error is a problem
specific to arm64.

If the device is not in D0, we can avoid the problem here, but it
seems like we're just leaving a landmine for somebody else to hit
later.  The driver will surely access the device after resume, won't
it?  Is it better to wait for a fatal error there?

Even if we avoid errors here, aren't we effectively claiming to have
restored the device state, which is now a lie?

Even on other platforms, if the writes that are supposed to restore
the state are dropped because the device isn't in D0, the result is
also not what we expect, and something is probably broken.

Bjorn

