Return-Path: <linux-pci+bounces-32284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3094FB07A78
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 17:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99AD13BC910
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 15:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8092F49EF;
	Wed, 16 Jul 2025 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMkcO7y/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB78E1E5701;
	Wed, 16 Jul 2025 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752681488; cv=none; b=tUSw3MC/mAVMd1oZMlEMNboM2RrNIWwzfA/FeVu0ct+LXer5Gcpw+0IjZ2kTQez+/3X8TtsJjs5FrBxOyN/q/7omt3LWQdxyATihfH63TacX+Fe1E3/LXIK8j9PA/61mZ5src2li22b9Hd8FXTLfWihq5WInuG44YOvrxr0H+o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752681488; c=relaxed/simple;
	bh=gMxD2cNh7slWJ9OWR+KLnow/5tGll0CpQ0ou060BuDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUd4jH+u8pwbNF8DP3llMgA1L8W7J8ev59bl+aS63Ndzn5TWXifaCBRK5JuoP5QLKJ3iaYJw3nesXFfzBhVlk3d2790Id3wrwepoUSR5jkQckGzzmJppMYhDEppSQpDw2Kzyb1gwS1Vvb1EUeWnRdFSLOvAms249+E1Bp+wRtQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMkcO7y/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5992BC4CEE7;
	Wed, 16 Jul 2025 15:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752681487;
	bh=gMxD2cNh7slWJ9OWR+KLnow/5tGll0CpQ0ou060BuDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RMkcO7y/gFy/byUU3Ko96z4xcRAMj9wQgPxgwDDWC0pVguGVnnZkur42XlUEVA2/5
	 n+M6B/F3mtyrgurOZGOlsWIrVtGbRkxWloAGteB/cFYUF6Z9OBRI7jY3c4jXnrGR24
	 CkeCFrRfGTcC1r3J6R7E9cglOE+ndeJsJskaz4u3jyq/sxtn2oej7xYx/SyQSBEpOl
	 Ll61W8xYiz+XUMj7MRTpiZ9MgTYKGRvC2qCf4+xXfxLr5DfF7KIWWrG0jEP5POFCse
	 u0zw9HCizhWwbgO7bYwDz/aUMCX3BXICL18Cf32A6HZ/tE/e//+567YylrODx45eLi
	 0lvIudrNkkp/A==
Date: Wed, 16 Jul 2025 21:27:55 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: Only destroy alongside host bridge
Message-ID: <cnbtk5ziotlksmmledv6hyugpn6zpvyrjlogtkg6sspaw5qcas@humkwz6o5xf6>
References: <20250711174332.1.I623f788178c1e4c5b1a41dbfc8c7fa55966373c0@changeid>
 <xg45pqki76l4v7lgdqsnv34agh5hxqscoabrkexnk2zbzewho5@5dmmk46yebua>
 <aHbGax-7CiRmnKs7@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHbGax-7CiRmnKs7@google.com>

On Tue, Jul 15, 2025 at 02:21:47PM GMT, Brian Norris wrote:
> Hi Manivannan,
> 
> Thanks for reviewing.
> 
> On Sat, Jul 12, 2025 at 10:56:38PM +0530, Manivannan Sadhasivam wrote:
> > If you take a look at commit f1536585588b ("PCI: Don't rely on
> > of_platform_depopulate() for reused OF-nodes"), you can realize that the PCI
> > core clears OF_POPULATED flag while removing the PCI device. So
> > of_platform_device_destroy() will do nothing.
> 
> I've looked through that commit several times, and while I think I
> understand its claim, I really haven't been able to validate it. I've
> inspected the code for anything like of_node_clear_flag(nc,
> OF_POPULATED), and the closest I see for any PCI-relevant code is in
> drivers/of/platform.c -- mostly in error paths (undoing device creation)
> or of_platform_device_destroy() or of_platform_depopulate().
> 
> I've also tried quite a bit of tracing / printk'ing, and I can't find
> the OF_POPULATED getting cleared either.
> 
> Is there any chance there's a mistake in the claims in commit
> f1536585588b? e.g., maybe Bartosz was looking at OF_POPULATED_BUS (which
> is different, but also relevant to his change)? Or am I missing
> something obvious in here?
> 

Now, I did look into the OF code and I also couldn't see where exactly the
OF_POPULATED flag is getting cleared by the PCI core :/ So I'll defer the
question to Bartosz.

> OTOH, I also see that part of my change is not really doing quite what I
> thought it was -- so far, I think there may be some kind of resource
> leak (kobj ref), since I'm not seeing pci_release_host_bridge_dev()
> called when I think it should be. If I perform cleanup in
> pci_free_host_bridge() instead, then I do indeed see
> of_platform_device_destroy() tear things down the way I expect.
> 

Oh, that's bad! Which controller it is? I played with making the pcie-qcom
driver modular and I unloaded/loaded multiple times, but never saw any
refcount warning (I really hope if there was any leak, it would've tripped over
during insmod).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

