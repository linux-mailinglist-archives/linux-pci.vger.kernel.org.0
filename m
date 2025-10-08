Return-Path: <linux-pci+bounces-37737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD89BC6B47
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 23:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58A0D4E1063
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 21:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAD6258ECF;
	Wed,  8 Oct 2025 21:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXH/hd1n"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064BD15B971
	for <linux-pci@vger.kernel.org>; Wed,  8 Oct 2025 21:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759960276; cv=none; b=I8KeVTA4HBx0GC6wXAqUYwW8FRe0k1n3B7dSxbutIg3xdB0qiKFyebSxqP8n9bMqPFWcQdXEhwJuBLdLpuqwZb/8A4BT2tpygKU3EVhngAPRMcaemJVxLcFGpkbKd3xUBvoffN1td5bPPJW5PqOucQBbR+F2gRkKS/dTobjXrWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759960276; c=relaxed/simple;
	bh=dwMsqnLo/hXqtxU49SA8kAY9hX8V9kAjevYZpKlvr04=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DZsNO7eiEUiEQb+EQXF3I9HF8Zk+UryAYeELZUUgieS3EN5QvU4kR2aONFcyixnxR6fYa5UNJEd0SgZgSsg3BnL0ODIL06kcVZhidjU2p2vvKnLg2eodRhUf1ZvD5LXJIlRZjPL85bBnV4Fa60ijyGKEEWAbbklcbuAgtPe0sgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXH/hd1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F78C4CEE7;
	Wed,  8 Oct 2025 21:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759960275;
	bh=dwMsqnLo/hXqtxU49SA8kAY9hX8V9kAjevYZpKlvr04=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SXH/hd1n33a8EtMpJ8aytjzV1zNNDC1uLkYgmz+2TGrhkmGqdW2PUWCqS3RUE17Zt
	 gP0diIksDtr82+n8Lh1qs52vg29Fcczci81fC64MIirSKtJqhUdivwm0bGoj5aQaq7
	 ap/brXHImETNP6+LriobpCxsmpCo3OpdHWjSnBfKmAUT2zwy9mGIsEvCYPbKs5BYfX
	 ti4bul1wrVDUa+P6xHqaE634mIWuzrVKhnMSVVKHBZTs8KyYtqJNzQ/lFyp0BkoYTP
	 i4sK8ZlgdlMg5O4NmYpOIDWSTU8B1toYaX+4GgTckTdaKu9E0UXQ88gnXwuL151EIn
	 5riYivFuKgpEg==
Date: Wed, 8 Oct 2025 16:51:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kenneth Crudup <kenny@panix.com>
Cc: ilpo.jarvinen@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: Commit 4292a1e45fd4 ("PCI: Refactor distributing available
 memory to use loops") gives errors enumerating TBolt devices behind my TB
 dock
Message-ID: <20251008215114.GA644158@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d82c77b-78a7-4eb8-8940-3d3d2cafc800@panix.com>

On Wed, Oct 08, 2025 at 02:20:40PM -0700, Kenneth Crudup wrote:
> On 10/8/25 13:58, Bjorn Helgaas wrote:
> 
> > This worked for me:
> > 
> >    $ b4 am https://lore.kernel.org/r/tencent_8C54420E1B0FF8D804C1B4651DF970716309@qq.com
> 
> TIL about "b4"! Going to get it now.

Another awesome tool.  I also find lei + mutt indispensable,
pointers:

  https://b4.docs.kernel.org/en/latest/index.html
  https://josefbacik.github.io/kernel/2021/10/18/lei-and-b4.html
  https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started
  https://people.kernel.org/monsieuricon/lore-lei-part-2-now-with-imap
  https://youtu.be/mF10hgVIx9o?t=1474

> > > I just "git remote"ed your tree, do you have a SHA? I'm not seeing it.
> > 
> > Should be 4230b93d836f
> I must be using the wrong remote then, which should I be using?

https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=4230b93d836f

