Return-Path: <linux-pci+bounces-11539-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FE994D148
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 15:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120AF1C2196C
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 13:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842CD194C75;
	Fri,  9 Aug 2024 13:30:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5508192B7F;
	Fri,  9 Aug 2024 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723210255; cv=none; b=XeEYsmvvZKKY75yaCh+BfnEZOj8VRE+36a43dcFZKgtpwZpJ6mc/GiSyucIDB3cnDKauKVzgL26fYBQ/TzUd7jkNIbF5j3TqE0MVagXrH/yacYyqZn6p0WxFBsICzGKfzZn1yiwv+UypwsHmUiby6pWsu57/DVvwcRyVVX+72Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723210255; c=relaxed/simple;
	bh=jCfjBIrwzFS5oyFkT/kguttmfSuh2j+vQZx7YLEVmOY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=C1hAVOzcNkGtdvEloNcTTzqxYf+41orjmzFrN/m+MwIsyxq4foOne0Tw0X/KMGo2weCBJhREsKUdsc5BhTCcNCSlxffj8LpHnyIXSUCAeAetq5rdJx71CY1J4W7lJI+tBSkFAlwi8MFr4heRojRpsztRr9YhBLjD494dJ28XjvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 21E5F92009D; Fri,  9 Aug 2024 15:30:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 1BFC792009B;
	Fri,  9 Aug 2024 14:30:52 +0100 (BST)
Date: Fri, 9 Aug 2024 14:30:52 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI: Correct error reporting with PCIe failed link
 retraining
In-Reply-To: <f4eafdbc-b295-a982-fe8e-dbd11b98d56f@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2408091142330.61955@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2402092125070.2376@angie.orcam.me.uk> <alpine.DEB.2.21.2402100045590.2376@angie.orcam.me.uk> <f4eafdbc-b295-a982-fe8e-dbd11b98d56f@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 12 Feb 2024, Ilpo Järvinen wrote:

> > Only return successful completion status from `pcie_failed_link_retrain' 
> > if retraining has actually been done, preventing excessive delays from 
> > being triggered at call sites in a hope that communication will finally 
> > be established with the downstream device where in fact nothing has been 
> > done about the link in question that would justify such a hope.
> > 
> > Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
> > Reported-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Link: https://lore.kernel.org/r/aa2d1c4e-9961-d54a-00c7-ddf8e858a9b0@linux.intel.com/
> > Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> > Cc: stable@vger.kernel.org # v6.5+
> 
> Thanks.
> 
> The original thread might be useful for context if somebody has to look at 
> this change later on from the history, so:
> 
> Link: https://lore.kernel.org/linux-pci/20240129112710.2852-2-ilpo.jarvinen@linux.intel.com/T/#u

 This refers the same thread of discussion as the link already included 
(and also is not a permalink), so I chose not to duplicate it in v2.

> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

 Thank you (also for the other change)!

 New series posted: 
<https://patchwork.kernel.org/project/linux-pci/list/?series=878216>.

  Maciej

