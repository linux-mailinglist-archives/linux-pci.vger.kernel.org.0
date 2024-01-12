Return-Path: <linux-pci+bounces-2081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 535D482BC1C
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 08:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A861F22879
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 07:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45485D737;
	Fri, 12 Jan 2024 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A2uvgJlm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802B35D734;
	Fri, 12 Jan 2024 07:58:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87218C433F1;
	Fri, 12 Jan 2024 07:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705046283;
	bh=bWqyRoGbqZkUMpB07zA4RdTIaZK8BiWqqZtsb6JvOmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A2uvgJlm6fJHwsAGrCgwXIHiRztTcnL/4mogwAWZdzjjJVj1i/bMXHljMqs3dh4wF
	 JcJaL1kgYTz280FgKrHHFyREGCKo5pNpHbfaqKkVHFBpi10NXuHzsttZ7XQ2oPvUH0
	 zVGCGEbe4A4YIVsKbAVEx1XKcbwjKzHMtErgvZ9w=
Date: Fri, 12 Jan 2024 08:57:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Diogo Ivo <diogo.ivo@siemens.com>
Cc: vkoul@kernel.org, kishon@kernel.org, linux-phy@lists.infradead.org,
	tjoseph@cadence.com, linux-pci@vger.kernel.org, ylal@codeaurora.org,
	regressions@lists.linux.dev, jan.kiszka@siemens.com
Subject: Re: [REGRESSION] Keystone PCI driver probing and SerDes PLL timeout
Message-ID: <2024011246-corned-disregard-7123@gregkh>
References: <20240111141331.3715265-1-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111141331.3715265-1-diogo.ivo@siemens.com>

On Thu, Jan 11, 2024 at 02:13:30PM +0000, Diogo Ivo wrote:
> Hello,
> 
> When testing the IOT2050 Advanced M.2 platform with Linux CIP 6.1
> we came across a breakage in the probing of the Keystone PCI driver
> (drivers/phy/ti/pci-keystone.c). This probing was working correctly
> in the previous version we were using, v5.10.
> 
> In order to debug this we changed over to mainline Linux and bissecting
> lead us to find that commit e611f8cd8717 is the culprit, and with it applied
> we get the following messages:
> 
> [   10.954597] phy-am654 910000.serdes: Failed to enable PLL
> [   10.960153] phy phy-910000.serdes.3: phy poweron failed --> -110
> [   10.967485] keystone-pcie 5500000.pcie: failed to enable phy
> [   10.973560] keystone-pcie: probe of 5500000.pcie failed with error -110
> 
> This timeout is occuring in serdes_am654_enable_pll(), called from the 
> phy_ops .power_on() hook.
> 
> Due to the nature of the error messages and the contents of the commit we
> believe that this is due to an unidentified race condition in the probing of
> the Keystone PCI driver when enabling the PHY PLLs, since changes in the
> workqueue the deferred probing runs on should not affect if probing works
> or not. To further support the existence of a race condition, commit
> 86bfbb7ce4f6 (a scheduler commit) fixes probing, most likely unintentionally
> meaning that the problem may arise in the future again.
> 
> One possible explanation is that there are pre-requisites for enabling the PLL
> that are not being met when e611f8cd8717 is applied; to see if this is the case
> help from people more familiar with the hardware details would be useful.
> 
> As official support specifically for the IOT2050 Advanced M.2 platform was
> introduced in Linux v6.3 (so in the middle of the commits mentioned above)
> all of our testing was done with the latest mainline DeviceTree with [1]
> applied on top.
> 
> This is being reported as a regression even though technically things are
> working with the current state of mainline since we believe the current fix
> to be an unintended by-product of other work.
> 
> #regzbot introduced: e611f8cd8717

A "regression" for a commit that was in 5.13, i.e. almost 2 years ago,
is a bit tough, and not something I would consider really a "regression"
as it is core code that everyone runs.  Given you point at scheduler
changes also fixing the issue, this seems like a hint as to what is
wrong with your driver/platform, but is not the root cause of it and
needs to be resolved.  Please look at fixing it in your drivers?  Are
they all in Linus's tree?

thanks,

greg k-h

