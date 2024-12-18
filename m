Return-Path: <linux-pci+bounces-18716-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C24389F6A96
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 16:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39F21728F4
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 15:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF9B1F03DA;
	Wed, 18 Dec 2024 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eByCo/5T"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE06D1B0422;
	Wed, 18 Dec 2024 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734537477; cv=none; b=sqAf4gwfcR/VzrPaGLF+qvzi36AMA5yA01O/BUPzPxKVCgpCV/vrcBUqLWBU+fOd7D/283xhaKCY1/hLVmQatsmcaPWgIbLyHIvDUwNq3yEdN9EtGjwRS8+9lZ7N4aLjHuuckEc5lqvS6jAXvsGLhSeT5mPOK5AvcHLJk3xSSk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734537477; c=relaxed/simple;
	bh=n/p0QQYF/GXFNOD3acb++4fjWilIWvlaFVWf0mZSiOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OO4HdeR612Hjm8UWZF4JjrxBDIucTY97c5mIHS1jnu8KsAEtS4ZcfNYIEkcm/y03JXnaxnp3KiYf5WlmCke9CZqXok50cx7zJtW4CLDkQzAd4ABpxVLGNRnywR5g8/HitWQHPjOcePbALobfGgazgAkf632vUVulGanypHi4qJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eByCo/5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F95BC4CECE;
	Wed, 18 Dec 2024 15:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734537476;
	bh=n/p0QQYF/GXFNOD3acb++4fjWilIWvlaFVWf0mZSiOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eByCo/5TwCIDzbQC5jr0AB6hLgLXoNtX8gPqC+nhCTcOOTiULP3BGB9nSOZ8/IKvp
	 EYHN67dL94eDdKct0HeXRiL6hN56OtyBWf0muXJylZmhQwJf0evZxXCzLcEU4Ka2RN
	 StYxGo4iMxVmlf2FsbKGsj9sbp8DMg8ZYRK6g1NslfDqUvdBmZf9cEkSSXcXpvZyA9
	 hzyPt3xz7BQbmbQUaFWlVaihm5hjMgK1Fmw1XFn4wkjBjSZ/JaJpiC6q5nzitVjcGF
	 MEAp53vG/8S+y6ci/zzlVWWa6u6dPTn+qRB5OvTy5pXutkkDwfydHi66BpgpaY4KAl
	 3XO/QiZPw6HdQ==
Date: Wed, 18 Dec 2024 08:57:53 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ryo Takakura <ryotkkr98@gmail.com>, lgoncalv@redhat.com,
	bhelgaas@google.com, jonathan.derrick@linux.dev, kw@linux.com,
	lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
	nirmal.patel@linux.intel.com, robh@kernel.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2] PCI: vmd: Fix spinlock usage on config access for RT
 kernel
Message-ID: <Z2LxAU0U_G5wI_2M@kbusch-mbp.dhcp.thefacebook.com>
References: <20241218115951.83062-1-ryotkkr98@gmail.com>
 <Z2LsFoXotl_SHmNk@kbusch-mbp.dhcp.thefacebook.com>
 <20241218154838.xVrjbjeX@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218154838.xVrjbjeX@linutronix.de>

On Wed, Dec 18, 2024 at 04:48:38PM +0100, Sebastian Andrzej Siewior wrote:
> On 2024-12-18 08:36:54 [-0700], Keith Busch wrote:
> > On Wed, Dec 18, 2024 at 08:59:51PM +0900, Ryo Takakura wrote:
> > > PCI config access is locked with pci_lock which serializes
> > > pci_user/bus_write_config*() and pci_user/bus_read_config*().
> > > The subsequently invoked vmd_pci_write() and vmd_pci_read() are also
> > > serialized as they are only invoked by them respectively.
> > > 
> > > Remove cfg_lock which is taken by vmd_pci_write() and vmd_pci_read()
> > > for their serialization as its already serialized by pci_lock.
> > 
> > That's only true if CONFIG_PCI_LOCKLESS_CONFIG isn't set, so pci_lock
> > won't help with concurrent kernel config access in such a setup. I think
> > the previous change to raw lock proposal was the correct approach.
> 
> I overlooked that. Wouldn't it make sense to let the vmd driver select
> that option rather than adding/ having a lock for the same purpose?

The arch/x86/Kconfig always selects PCI_LOCKESS_CONFIG, so I don't think
the vmd driver can require it be turned off. Besides, no need to punish
all PCI access if only this device requires it be serialized.

