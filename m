Return-Path: <linux-pci+bounces-19189-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15580A001BE
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 00:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1CB7164B85
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 23:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3C11BEF67;
	Thu,  2 Jan 2025 23:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMPfPdZt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21CE1BEF65;
	Thu,  2 Jan 2025 23:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735860376; cv=none; b=esj3gQikcXLq4aM2GU3Zy2GIp2ym0Xf2oFGXNu6JWbm4qHjBW2ndxc4ZJ3kfy/zf1MEyzShHWi59dxZ7Bo0AABen1ooBk9C9sTuYxrBK06WH4/iJroSmrht7D4yR2C4GhuusTJnRwZbAwdjbqGTzrM/fk6pU81whAJNmbJ/nXlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735860376; c=relaxed/simple;
	bh=wG+43w9FbSOlhitQ1PPqyfrpvp5N6QLgb3Fwq4DOy0k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nBT8oi160QecAvMER9EHXtEGAoCPrvyHjkZ9GqWuY/8y2P1ZZMEGrPeJHVD5Ktz24CjRqnE4ulsPV4aVD1cEC02iK+SYkBGkJ7vpz/W2KmF7SqzFqjHHh6YWeLffn6//LWOYAnLZzLcX2GX5TnzCXSEJt+FO0gt6DKROZztHKRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMPfPdZt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB92C4CED0;
	Thu,  2 Jan 2025 23:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735860375;
	bh=wG+43w9FbSOlhitQ1PPqyfrpvp5N6QLgb3Fwq4DOy0k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UMPfPdZt/2rzoFQQJN06c1jrbXhmuShjc7wt7EGdEGYnbnLAjPhDSCMpiRkS4CcLZ
	 dT/oZgHyYKtAjfJU93Kn5lcnPkSkIKJIcI3nT1zROnw66FExiMsEOgO7OKH4aabJvC
	 i3cKM7OWe4zOd7oRQljW05QhERxi6HoUGgxdXhXcE/jAiLBZXWHnsZQNmPnphTlA0L
	 AMA3K+E0CCU0xjjMqXnYH5ASoO9yDbKm/6aR8n/uhdmb/vJFXvTSJeTAHDhd3XHQk+
	 A1DwJx2p2Bv9XJE9D+xkXIuxPkJAz98t3ErFlaat48j83MRqU0GqLLG/cvTE6IuFhg
	 VXcuROVMkcgzw==
Date: Thu, 2 Jan 2025 17:26:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tushar Dave <tdave@nvidia.com>
Cc: corbet@lwn.net, bhelgaas@google.com, paulmck@kernel.org,
	akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
	xiongwei.song@windriver.com, vidyas@nvidia.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com, jgg@nvidia.com,
	sdonthineni@nvidia.com
Subject: Re: [PATCH 1/1] PCI: Fix Extend ACS configurability
Message-ID: <20250102232614.GA4147007@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213202942.44585-1-tdave@nvidia.com>

On Fri, Dec 13, 2024 at 12:29:42PM -0800, Tushar Dave wrote:
> Commit 47c8846a49ba ("PCI: Extend ACS configurability") introduced a
> bug that fails to configure ACS ctrl for multiple PCI devices. It
> affects both 'config_acs' and 'disable_acs_redir'.
> 
> For example, using 'config_acs' to configure ACS ctrl for multiple BDFs
> fails:
> 
> [    0.000000] Kernel command line: pci=config_acs=1111011@0020:02:00.0;101xxxx@0039:00:00.0 "dyndbg=file drivers/pci/pci.c +p" earlycon
> [   12.349875] PCI: Can't parse ACS command line parameter
> [   19.629314] pci 0020:02:00.0: ACS mask  = 0x007f
> [   19.629315] pci 0020:02:00.0: ACS flags = 0x007b
> [   19.629316] pci 0020:02:00.0: Configured ACS to 0x007b

Drop timestamps (unless they contribute to understanding the
problem) and indent the quoted material by a couple spaces.

