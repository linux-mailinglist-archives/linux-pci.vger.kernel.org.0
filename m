Return-Path: <linux-pci+bounces-43821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 746D0CE7CC4
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 19:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36F7B301585D
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 18:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05452FAC12;
	Mon, 29 Dec 2025 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHjiblU2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CC51AE877;
	Mon, 29 Dec 2025 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767031738; cv=none; b=KVB+X2NGl6jC534LhwKYEwQ+CaVW7UfMWrw3hRmjgGOMr9fvXKRkwiMym3ENCWEne/S2vxY9L7XIznUowtu1nTwPeZrOJNSpghAgfcVIs3tTVOnwgDKI0XrubWnPwFxhXEreYeTQKGTgmBJxcEbCRiz0cf3JrUmkQdaH1CwFrrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767031738; c=relaxed/simple;
	bh=3wLNUTpCcu+sXfDDN3jEmRjdw02gR7ASkfRJ9Ma07Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRxVBl0vBDzmCEcp1m1bstvkSrnTILL80DWoSIvRUdhlaIJ9SF4kWT7qXM3V+JvRBTbTijYkrfNx0XUL5alwbxA2y26tuj27QavWdSCSlL6l91ASlfRQObTWZeJSTrvfAVgk77Eq4ocLBpkGzTysGlq8qS3yFSC4GDFwfiYeQK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHjiblU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105ECC4CEF7;
	Mon, 29 Dec 2025 18:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767031738;
	bh=3wLNUTpCcu+sXfDDN3jEmRjdw02gR7ASkfRJ9Ma07Bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LHjiblU2DitrdC1DNcnIyLqWGfOjvoEXfIQJdXhFc7D+hREGqXLbGDvFzYnrP2p35
	 VKXSwttfxsxaME/x5uchtKkjPAGW0XHxCzFILLYQOUtbGsXpH/uhFYRaAiTFC12K5K
	 VbA8cSGzw1FMT38UB7f4KszBMFR6oII+bBG30kkyGU0sIKtbisj1WZx5rd5MdNwhWe
	 YIGBE3lp8p7TtiincIZqvOW01dAfpUtHAIXzY+x5wpruo1Xi32XbhOO36lZtXeXcrc
	 1Ww+dsDfcIMd+BMJHqepQjLYOGeU2ZpVQ4W1kJTZDQ6t2IXQWpKGCptRQMpdacK4Hu
	 RNbwZJff4Em2g==
Date: Mon, 29 Dec 2025 08:08:57 -1000
From: Tejun Heo <tj@kernel.org>
To: Jinhui Guo <guojinhui.liam@bytedance.com>
Cc: bhelgaas@google.com, bvanassche@acm.org, dan.j.williams@intel.com,
	alexander.h.duyck@linux.intel.com, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI: Avoid work_on_cpu() in async probe workers
Message-ID: <aVLDuUAHw0egvFfr@slm.duckdns.org>
References: <20251227113326.964-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227113326.964-1-guojinhui.liam@bytedance.com>

On Sat, Dec 27, 2025 at 07:33:26PM +0800, Jinhui Guo wrote:
> To fix the issue, pci_call_probe() must not call work_on_cpu() when it is
> already running inside an unbounded asynchronous worker. Because a driver
> can be probed asynchronously either by probe_type or by the kernel command
> line, we cannot rely on PROBE_PREFER_ASYNCHRONOUS alone. Instead, we test
> the PF_WQ_WORKER flag in current->flags; if it is set, pci_call_probe() is
> executing within an unbounded workqueue worker and should skip the extra
> work_on_cpu() call.

Why not just use queue_work_on() on system_dfl_wq (or any other unbound
workqueue)? Those are soft-affine to cache domain but can overflow to other
CPUs?

Thanks.

-- 
tejun

