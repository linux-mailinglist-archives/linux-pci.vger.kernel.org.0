Return-Path: <linux-pci+bounces-2898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E1E8449E2
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 22:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E947B26A85
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 21:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B572639AC2;
	Wed, 31 Jan 2024 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfL9KcQo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C4A3987B
	for <linux-pci@vger.kernel.org>; Wed, 31 Jan 2024 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706736011; cv=none; b=Kmq3NjL6g272oGAar5C+kAN7NIuOeLBWuRGiw2Jq82tZawb/vXUP1EunSJ1gAJV//e8wJa0AGvQeol7uJ7eY/eEg3lvVdbfp3v+YB9YXycmpPa6+hY1nndMin0fcrJLRA7xmBw/HQt8FeItp9XOMFYTGhYbd6+N2Sl7NtTMhJEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706736011; c=relaxed/simple;
	bh=VOewfuf6Egf4yLDxZuNT/6PESuXSuVkpKW8fM+ilYRs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JKkJK0kcdg6ZX7Li9FxwuKqeTS/6ERW2UUxn7fNndPafCXKDkoRc5uTplU65DNbagDUGFCq081y1jHewg4O4Htgzu5N6f/6NZkL5hZUU4yke0ffTBNOUvwoF537yrOzuIuL6uL12anX0j4hw8RZOG365HJlMFC0yqDbSSRP0A3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfL9KcQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AF2C433C7;
	Wed, 31 Jan 2024 21:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706736011;
	bh=VOewfuf6Egf4yLDxZuNT/6PESuXSuVkpKW8fM+ilYRs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TfL9KcQoqApJ4VkbmJr4ecc8AqhA97dmcHLiwcO+HgwRoQlHAcOf0L+VzlmO+HIo6
	 t4kVANawp6oVFMWUreSzfMSLHwcaAEw07BnwmBflYZ8PV5jlj6F+efYn/iScVViXmf
	 M9cO8qmibhdZSaU0p6qbzhkx6wJl1N2TtZlJ7BIjbQmBg2HX3CU8CaK3QMn6S26hFX
	 ltwuqvHlSz1T24sjQyXCieaaCqLsRFHKyZQvT1nh/xpTNUcq5HJ6GTOVEKmFh3lJql
	 /YF+7PWbigaiyZzjbmSmkRLt9Zrz4fke8l5A14gK4zJHolA8QjPqiY3HLMJvWe/9YZ
	 S4SIDw/dXJ7jQ==
Date: Wed, 31 Jan 2024 15:20:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: nowicki@posteo.net
Cc: linux-pci@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [Question] Custom MMIO handler - is it possible?
Message-ID: <20240131212009.GA601947@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <981728318a564e6c3d54ca76ee37348b@posteo.net>

On Wed, Jan 31, 2024 at 08:42:18PM +0000, nowicki@posteo.net wrote:
> Hello,
> 
> I'm trying to implement a fake PCIe device and I'm looking for guidance (by
> fake I mean fully software device).
> 
> So far I implemented:
> - fake PCIe bus with custom fake pci_ops.read & pci_ops.write functions
> - fake PCIe switch
> - fake PCIe endpoint
> 
> Fake devices have implemented PCIe registers and are visible in user space
> via lspci tool.
> Registers can be edited via setpci tool.
> 
> Now I'm looking for a way to implement BAR regions with custom memory
> handlers. Is it even possible?
> Basically I'd like to capture each MemoryWrite & MemoryRead targeted for
> PCIe endpoint's BAR region and emulate NVMe registers.
> 
> I'm in dead-end right now and I'm seeing only two options:
> - generate page faults on every access to fake BAR region and execute fake
> PCIe endpoint's callbacks - similar/the same as mmiotrace
> - periodically scan fake BAR region for any changes
> 
> Both solutions have drawbacks.
> Is there other way to implement fake BAR region?

Sounds kind of cool and potentially useful to build kernel test tools.

Is the page fault on access option a problem because you want better
performance?  I assume you really *want* to know about every write and
possibly even every read, so a page fault seems like the way to do
that.

Maybe qemu would have some ideas?  I assume it implements some similar
things.

Bjorn

