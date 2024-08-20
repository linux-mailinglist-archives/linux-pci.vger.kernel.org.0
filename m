Return-Path: <linux-pci+bounces-11896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A305958A9A
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 17:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06BA3284BDA
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 15:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5881917E4;
	Tue, 20 Aug 2024 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDm5YEgt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DA319004D
	for <linux-pci@vger.kernel.org>; Tue, 20 Aug 2024 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166143; cv=none; b=McdVlS404kEE9YY/sND6EP47110iRhbZY9C4cySiQnIkibHYqyo6g8bomUZJkSzIxsats+wbqlzuK5q0Vf/Gr668p6Fu7cUZdwO8ujzf5U/YwnCgokxaqeM6RUeN3qQXBwvupFmPNqLE7hPoBVRMudfeTy01OMt2tiLgzF5uKrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166143; c=relaxed/simple;
	bh=HgtTHIp+9ifd5Ub9jb39eu3TCng8Oy7+IWD4Hk+FkTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcuvT7WaLxbfVXi1zLRM0ZTpePCBqqHnPxfgv+QdtirIzyeNTKYrNcVKd8+Z72uIs3CLKF1mNHTrMcn62RBybTVoYUNrvRogghHIX/pbXmV4uXC1FS8GgmjB4vX+3m3VWGndFmlYf3RUCHHRznr/pouPUhyL3LcF0rn7wv+2YNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDm5YEgt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC39C4AF0C;
	Tue, 20 Aug 2024 15:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724166142;
	bh=HgtTHIp+9ifd5Ub9jb39eu3TCng8Oy7+IWD4Hk+FkTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EDm5YEgtBrDMc7R6KJv2pVipCu0gjJfW+PHFetCU9mH5nBRuh4Wqo2XoNhPdDP3DX
	 xSBshlLKEFMl0ovejpUEybkK3HC/Grp+ct2eVx+W+w1ASwgiz72KoPL5cV7wBe8Jsb
	 CiapdaB+ATJNzYbIW0ukCWVIkTxNUjvjo9RYmp9K6+HuLxYjAvcNhTKAJSjTCtofks
	 2Dea9hASg4XxhlrzTUT3gcpuHxjeLGNspcW1c9NRxhsFP8lwsEr9bjLNZDzeiLNn72
	 7XwlJkM4rQvEiR1PEcLkN5TkJmEARLCJ6YAaai5jPHqkdpjYfVrC5QFTyUdZQqpP7l
	 hdGQVIwTAM9XQ==
Date: Tue, 20 Aug 2024 09:02:20 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, lukas@wunner.de,
	mika.westerberg@linux.intel.com
Subject: Re: [PATCH RFC 1/8] pci: make pci_stop_dev concurrent safe
Message-ID: <ZsSv_KuFfLiwBxZW@kbusch-mbp>
References: <20240722151936.1452299-1-kbusch@meta.com>
 <20240722151936.1452299-2-kbusch@meta.com>
 <20240815151717.00007e7c@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815151717.00007e7c@Huawei.com>

On Thu, Aug 15, 2024 at 03:17:17PM +0100, Jonathan Cameron wrote:
> On Mon, 22 Jul 2024 08:19:29 -0700
> Keith Busch <kbusch@meta.com> wrote:
> 
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Use the atomic ADDED flag to safely ensure concurrent callers can't
> > attempt to stop the device multiple times.
> 
> Maybe mention what concurrent paths exist where this might happen.

I think everyone calling this is holding the pci_rescan_remove_lock, so
it shouldn't be possible today. This series aims to remove that lock
though, so this is more of a prep patch for that. But also, the flag is
already an atomic type, so using those properties makes sense on its own
too.

