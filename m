Return-Path: <linux-pci+bounces-9125-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B84A913573
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 19:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3539B281350
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 17:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FD9DDD8;
	Sat, 22 Jun 2024 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSs+V+DZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E8EBA39;
	Sat, 22 Jun 2024 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719078727; cv=none; b=HgqmWKf+IYjzKSKHobri4Z3fbu/qLVzD8rFaZrPDl4t8umLW1KMlSgJvS/iWIOjU4AuorcMBm4eDmILCZyqeNBGD/Ol3mPrtChLevhka4EWl78PUXMSDavG/qwSSjG/nWOlobS+WXHJb4vQ5nTufnwDFeNuZQZ3GRcVJCeMvdUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719078727; c=relaxed/simple;
	bh=TgcQO5cI1N99h+gDcZZc8jr7775wxXCMauMmVkr4DYU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Xy4j+5AYG36xxnlJ32NVveQyHGzeO0zZ+sLW+9s5qmL/by1x+6Kxc1rsIrqL+LhuyXCjxzmy/DHXkTfLkQr9GkwaK81qtqHPZ+eU0VRMCEZSfhBAnw4+L6Yg7oOA8whvtnnjN2v5iOnJGMjKOfn9+g7Po7EsakSQDIwcLl5BH+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSs+V+DZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA39C3277B;
	Sat, 22 Jun 2024 17:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719078727;
	bh=TgcQO5cI1N99h+gDcZZc8jr7775wxXCMauMmVkr4DYU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fSs+V+DZS83pyGpwyU8XOItV98rDKi8EQAxj13OsY3oXv4O4LONKnVidDIhcu6Jqy
	 SG21le8JZhXy7ys/2wt2Ig2DFvyS2g5DBEWVoSSbETYb2KnoH1TNfAn5AHHOq82iLq
	 7KHLFS3OXcxBh9bACZWctL5URdqqWB8vnbY7D/trWGqHQLQWaN5XIMKOZ5k/LVk9US
	 FSuOUMWBarcFIYAx3OwoW7eOf4OesKe2gZ2YUW/Hot42mOkThSQK8vXcjH66U8AeO8
	 DUuivg0zbBs223qvftuh+poPP+HfnMNxT0OweC1D8pHGgQkVFfyhYyTXROjEoQGRiM
	 GNAZu7JKEratQ==
Date: Sat, 22 Jun 2024 12:52:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "zhoushengqing@ttyinfo.com" <zhoushengqing@ttyinfo.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] PCI: Enable io space 1k granularity for intel cpu
 root port
Message-ID: <20240622175205.GA1432837@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024062223061743562815@ttyinfo.com>

On Sat, Jun 22, 2024 at 11:06:18PM +0800, zhoushengqing@ttyinfo.com wrote:
> >> This patch add 1k granularity for intel root port bridge.Intel latest
> 
> 
> 
> >> server CPU support 1K granularity,And there is an BIOS setup item named
> 
> 
> 

I don't know what your email agent is doing to add all these extra
blank lines, but it makes it painful to read/reply:
https://lore.kernel.org/all/2024062223061743562815@ttyinfo.com/

> >Can you implement this as a quirk similar to quirk_p64h2_1k_io()?
> >
> >I don't want to clutter the generic code with device-specific
> >things like this.
> 
> I have attempted to implement this patch in quirks.c.But there
> doesn't seem to be a suitable DECLARE_PCI_FIXUP* to do this.because
> the patch is not targeting the device itself, It targets other P2P
> devices with the same bus number.

If I understand the patch correctly, if a [8086:09a2] device on a root
bus has EN1K set, *every* bridge (every Root Port in this case because
I assume this is a PCIe configuration) on the same bus supports 1K
granularity?

That seems like a really broken kind of encapsulation.  I'd be
surprised if there were not a bit in each of those Root Ports that
indicates this.

