Return-Path: <linux-pci+bounces-44780-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E14E0D2047D
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 17:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B94B630173AD
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 16:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B55394492;
	Wed, 14 Jan 2026 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azPrhNNp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA2F3933FC;
	Wed, 14 Jan 2026 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409140; cv=none; b=f9WLbIS5/jMuQbOsvIHU88sObt8EzEUv0JMx5IBncgwpPR6UVnvecOzLbfVn2HmBzP5gt71NnPeltA2PpDBc3F3ZLNgfAlNl0MNjhFxyUuD5qB6Z4BxeQykoa2zaqKTuTxhWSkowsU7SCrumTGirtiDBUw0PzBOMv/QqYWeT+GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409140; c=relaxed/simple;
	bh=ZtLzQt5YBwUg6DG6bIwSFawdoa7qArNKtK/7xD+zL0g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BSICV37OXpX/n9QyW9mhn9qkKzDYD0PAjj2Vb2v3nZ9sJs128KDks1DQtsHd5Tj+xzVEALwsEPrbFX2vSu+18+zv7rl/VRebt36uqfcShXnxpoopDvJzpFEHaByV8qgK+xe+u0rirkkX5EBBL3h+jJPR6v+8Gy8uoZ8ZJAqOckU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azPrhNNp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBFAC4CEF7;
	Wed, 14 Jan 2026 16:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768409140;
	bh=ZtLzQt5YBwUg6DG6bIwSFawdoa7qArNKtK/7xD+zL0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=azPrhNNptoYR+pu6N29kqKJMY+m5eXR0VNujXN6qW/T0q/xFfmXR78t8jnqqjY7pr
	 yXHAR+rFu/uNe+IlGnXvMRxPOtzi6fZyMoPA6XNCOe8gFbrKc7AE/AUZ5B7BZbH0uH
	 XxrJFeM4z7rfyUjQlUr1az/F3xbBEdOMmKyx/MOcwxi15ZPbntzTbCdhzgIYA8vx8Y
	 D6IakQxZznXplW0YVQRDbrpE+iCJnaHtuk/kfzVLC7Td9mI82IE4BlJYMhOdBKKAUD
	 ZstS3mzdcVfzSAaLSE+33dWv7774z70++C/3nHyxefXaSQP0jOf5AiaUaNiB1a413p
	 Vc3Qs83/4/ZyQ==
Date: Wed, 14 Jan 2026 10:45:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v4] PCI/PM: Prevent runtime suspend before devices are
 fully initialized
Message-ID: <20260114164538.GA816227@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e35a4e1-894a-47c1-9528-fc5ffbafd9e2@samsung.com>

On Wed, Jan 14, 2026 at 10:46:41AM +0100, Marek Szyprowski wrote:
> On 06.01.2026 23:27, Bjorn Helgaas wrote:
> > On Thu, Oct 23, 2025 at 02:09:01PM -0700, Brian Norris wrote:
> >> Today, it's possible for a PCI device to be created and
> >> runtime-suspended before it is fully initialized. When that happens, the
> >> device will remain in D0, but the suspend process may save an
> >> intermediate version of that device's state -- for example, without
> >> appropriate BAR configuration. When the device later resumes, we'll
> >> restore invalid PCI state and the device may not function.
> ...

> >      Link: https://patch.msgid.link/20251023140901.v4.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid
> 
> This patch landed recently in linux-next as commit c796513dc54e 
> ("PCI/PM: Prevent runtime suspend until devices are fully initialized"). 
> In my tests I found that it sometimes causes the "pci 0000:01:00.0: 
> runtime PM trying to activate child device 0000:01:00.0 but parent 
> (0000:00:00.0) is not active" warning on Qualcomm Robotics RB5 board 
> (arch/arm64/boot/dts/qcom/qrb5165-rb5.dts). This in turn causes a 
> lockdep warning about console lock, but this is just a consequence of 
> the runtime pm warning. Reverting $subject patch on top of current 
> linux-next hides this warning.

I moved this patch from pci/pm to pci/pend to remove it from
linux-next while we figure this out.  Thanks for the report and
debugging!

Bjorn

