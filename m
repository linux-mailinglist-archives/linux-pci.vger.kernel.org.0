Return-Path: <linux-pci+bounces-20537-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A825A21DE3
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 14:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C84F01882F0E
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 13:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADC11FDD;
	Wed, 29 Jan 2025 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ER6EE5lE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E602EC0;
	Wed, 29 Jan 2025 13:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738157575; cv=none; b=Aqa+yJEHsXKY90VCF014Xh1skQUdPQg/DuN6E1cqLe58vqvteE4DbUwdPOW0kyqyrFOmGCD4s3vbO3H+SISgVJIW1V4iY3PRS4WjoU8iTIufoCJ9ulE/38+S7no6k4/BtfbgEA105Ph59n4ydVMc3PdVzzdivelh+2GpJMV2bJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738157575; c=relaxed/simple;
	bh=Oj1ZVJfnXAYooWc8hOhsJbc/6YWDuBpD07JCgUIgQDI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dsrnsIJulIqxyKaN7Aq2YDuoPu39Dq3nq/oaRzS9dTh2Vgk70f40LtHgmWHRpdltZir+XglZ9Jq5d7jcvMATBfOEF5kFE+F0x1RyaVzoFQJaMsQUfp9nztjv/Vj7ElpBF/vAyEzHDN1pJsLPkQKsbNM4yaeU4bcQqlPg56V/2JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ER6EE5lE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D71C4CED3;
	Wed, 29 Jan 2025 13:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738157574;
	bh=Oj1ZVJfnXAYooWc8hOhsJbc/6YWDuBpD07JCgUIgQDI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ER6EE5lEstGLOFLOhrOEHtH6rntIFrgDIMN1DNORpww68H/ycR4TEz1rI7+79XuIo
	 aHC+ivPaam3BB+Jvaan3QqFydC9knTEJmIUqUbNaHSVvmwe2sdaJ8ySeTyGoWCSsKr
	 SY2LA5gghaI61hwBPoxbHbLbYl1L05Azl+6gom1EZO5+fkinCspr2cO0MR6r3LspIX
	 Q/3e1uqmM1P4t82Og8dij20d3qLF7dEaTSyrxN9B5ql5cuOS22SJvLUR4wsjoMKBhW
	 EqJU97GBj9KeW4UUo6yPiEahGWtwkL2P5/L9fkMwE1/ph2nSooJKL8NMHJbTcUI5Kf
	 V2g2Cc46V6YVg==
Date: Wed, 29 Jan 2025 07:32:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
	Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	xen-devel <xen-devel@lists.xenproject.org>,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>, linux-pci@vger.kernel.org,
	Jan Beulich <jbeulich@suse.com>
Subject: Re: Config space access to Mediatek MT7922 doesn't work after device
 reset in Xen PV dom0 (regression, Linux 6.12)
Message-ID: <20250129133252.GA451735@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5mk0K5xltK6iZXN@mail-itl>

On Wed, Jan 29, 2025 at 04:47:28AM +0100, Marek Marczykowski-Górecki wrote:
> On Tue, Jan 28, 2025 at 09:40:18PM -0600, Bjorn Helgaas wrote:
> > I guess the code at [2] is running in user mode and uses Linux
> > syscalls for config access?  Is it straceable?
> 
> Nope, it's running as the hypervisor and mediates Linux's access to the
> hardware. In fact, Linux PV kernel (which dom0 is by default under Xen)
> is running in ring 3...
> 
> But I can add some more logging there.

So I guess the hypervisor performs the config access on behalf of the
Linux PV kernel?  Obviously Linux thinks CRS/RRS SV is enabled, but I
suppose all the lspci output is similarly based on whatever the
hypervisor does, so how do we know the actual hardware config?

> > > [2] https://xenbits.xen.org/gitweb/?p=xen.git;a=blob;f=xen/arch/x86/pv/emul-priv-op.c;h=70150c27227661baa253af8693ff00f2ab640a98;hb=HEAD#l295

