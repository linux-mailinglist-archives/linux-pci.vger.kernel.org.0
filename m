Return-Path: <linux-pci+bounces-44067-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 094ECCF6085
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 00:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0738C3062B37
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 23:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C887B277007;
	Mon,  5 Jan 2026 23:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7RX2XPm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96303221F39;
	Mon,  5 Jan 2026 23:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767657079; cv=none; b=B8JsteOu6JYAefULJ7XUP9AiV/gA1PA6kkeDyhHXIFrsQ+7ngYJ1ME3BPTl9birL98TnWQW2YAgS5oO3tJPBDuQ8aVW3Is0Axfny4KvuYT4g1zpwFh0JexiDRNS7OxAoa7Pft5LY0sbIyZAe008gN4Cxms3iLnW1jz0iy/GY0Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767657079; c=relaxed/simple;
	bh=XJ9eT8cqm1GHWwEU2heyZiCGj7Z4P2U8GtuPK/Nfre8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Goyaat7npe3WuH0d0+udFMQUstcF0uiavthC2IheSIWwVdT9/LOgFsb8F/XbcxS3A8kIdFVQn4sBJ8kvFPRrm26XAOwg6aYFGd9ZMK6/Y3fOlvaq7AZztB2o0A5b1jdwyWcDG7dfWTwumSObk95w0Uai98eK3phKStxvBPEoQpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7RX2XPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F11C116D0;
	Mon,  5 Jan 2026 23:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767657079;
	bh=XJ9eT8cqm1GHWwEU2heyZiCGj7Z4P2U8GtuPK/Nfre8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=e7RX2XPmxqj4f6CbWY9AVg6rRnvsskKfFhb5TFLQGzbKfnCPORmxNF5EMQDlV74nF
	 LPKJzDwWzCHrPhqSflFNsl5R8dfK1JbcHzqhp6sxrDw9FtKRdSgcyt9xW3Kmug0+yx
	 yu8u3mWSDjkiJapdMyzGc/Ym2wCBYFk9sGZSd80MpeFRGOBYXm8ZsqdwBk5c3kVDmh
	 8z7cq/Sot4SsQn8Y7RZCymPFgYkYs/bDNWXMgz0PSzcRK3dVS8HvZ8aMaJRR18OCrj
	 xTMHghvdX94v/geEMdPBPE8ddudD6TdwuCxzEc89LsYjjfHr3fGk6sbUmCHVk6iXbM
	 kgdmfxZr9A40w==
Date: Mon, 5 Jan 2026 17:51:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Brian Norris <briannorris@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Avoid redundant delays on D3hot->D3cold
Message-ID: <20260105235117.GA336996@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003154008.1.I7a21c240b30062c66471329567a96dceb6274358@changeid>

On Fri, Oct 03, 2025 at 03:40:09PM -0700, Brian Norris wrote:
> From: Brian Norris <briannorris@google.com>
> 
> When transitioning to D3cold, __pci_set_power_state() will first
> transition a device to D3hot. If the device was already in D3hot, this
> will add excess work:
> (a) read/modify/write PMCSR; and
> (b) excess delay (pci_dev_d3_sleep()).
> 
> For (b), we already performed the necessary delay on the previous D3hot
> entry; this was extra noticeable when evaluating runtime PM transition
> latency.
> 
> Check whether we're already in the target state before continuing.
> 
> Note that __pci_set_power_state() already does this same check for other
> state transitions, but D3cold is special because __pci_set_power_state()
> converts it to D3hot for the purposes of PMCSR.
> 
> This seems to be an oversight in commit 0aacdc957401 ("PCI/PM: Clean up
> pci_set_low_power_state()").
> 
> Fixes: 0aacdc957401 ("PCI/PM: Clean up pci_set_low_power_state()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Brian Norris <briannorris@google.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Applied to pci/pm for v6.20, thanks!

I reversed the test to match similar tests in
pci_set_low_power_state(), __pci_set_power_state(), etc.

I dropped the stable tag because this is a performance improvement
that I can't quantify and doesn't seem to fit in the categories here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/stable-kernel-rules.rst?id=v6.18#n15

I'm not sure anybody pays attention to that list; lots of things I
don't expect get backported, so likely this will get backported as
well.  But as long as we have the documented list, I try to follow it.

Would be good to have Rafael's ack, but I don't think we need to wait
for it.

> ---
> 
>  drivers/pci/pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b0f4d98036cd..7517f1380201 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1539,6 +1539,9 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool
>  	   || (state == PCI_D2 && !dev->d2_support))
>  		return -EIO;
>  
> +	if (state == dev->current_state)
> +		return 0;
> +
>  	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>  	if (PCI_POSSIBLE_ERROR(pmcsr)) {
>  		pci_err(dev, "Unable to change power state from %s to %s, device inaccessible\n",
> -- 
> 2.51.0.618.g983fd99d29-goog
> 

