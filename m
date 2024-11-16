Return-Path: <linux-pci+bounces-16977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DE29CFF5F
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 15:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 957CD1F2214E
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 14:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77C3199B8;
	Sat, 16 Nov 2024 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1saYiDhn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B69101E6;
	Sat, 16 Nov 2024 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731768666; cv=none; b=jJWFAT5XQzzsJWMgt1KU+F88t1+rYpszZecC6LvrN0ovBaCCTxvQgnHe7d1EvCWyq16GkL8LFIh23ypNuw+xJCiyoOC3ir81S2yxu6dBKu1DbNTDCgdk1O1RnlpVHBNqzk+cvbghtHtWNX8jZKjBsqBNuSrPvUtX+HorxZYX3ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731768666; c=relaxed/simple;
	bh=49swYbXZyCUFCxRBsY8/lcKTq8X7PXyiOkldN8Pn+GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7Iqd7qO3xedkCZnfzD5J5A1L6RcO1EU3Qo/LrwhIoqe2HL5T5XGumQIMBQ5nkiT/xZean0SXbQJyaIB6VmM7R+ueOlmM3+iMsjUdB+SbSN4guPkRbTHSha4rXAHRmb3Th3SZP5sCV0Wy2Y80+lJ3uZmr8qTPG8UR2hce255L/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1saYiDhn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58604C4CEC3;
	Sat, 16 Nov 2024 14:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731768665;
	bh=49swYbXZyCUFCxRBsY8/lcKTq8X7PXyiOkldN8Pn+GU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1saYiDhnMeah99PwQuyAMKCP3uxNovFduDoB7sHzLKLdLp668trq9+eGI9fR5Ct6L
	 1YlF7vD/y1zf2x9m062yD42XIETcWn3/RqVzv6ZyAAYZICYPnWAtdfX/qfR/SXyqOK
	 2QX1J+X36McH1zCjP0xRmHI8SscHaPMPZ91Oj1t0=
Date: Sat, 16 Nov 2024 15:50:42 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Janne Grunau <j@jannau.net>
Cc: Danilo Krummrich <dakr@kernel.org>, rafael@kernel.org,
	bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, tmgross@umich.edu, a.hindborg@samsung.com,
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com,
	lina@asahilina.net, pstanner@redhat.com, ajanulgu@redhat.com,
	lyude@redhat.com, robh@kernel.org, daniel.almeida@collabora.com,
	saravanak@google.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH v3 00/16] Device / Driver PCI / Platform Rust abstractions
Message-ID: <2024111656-entrust-wincing-0c84@gregkh>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241116143240.GA1490760@robin.jannau.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116143240.GA1490760@robin.jannau.net>

On Sat, Nov 16, 2024 at 03:32:40PM +0100, Janne Grunau wrote:
> On Tue, Oct 22, 2024 at 11:31:37PM +0200, Danilo Krummrich wrote:
> > This patch series implements the necessary Rust abstractions to implement
> > device drivers in Rust.
> > 
> > This includes some basic generalizations for driver registration, handling of ID
> > tables, MMIO operations and device resource handling.
> > 
> > Those generalizations are used to implement device driver support for two
> > busses, the PCI and platfrom bus (with OF IDs) in order to provide some evidence
> > that the generalizations work as intended.
> > 
> > The patch series also includes two patches adding two driver samples, one PCI
> > driver and one platform driver.
> > 
> > The PCI bits are motivated by the Nova driver project [1], but are used by at
> > least one more OOT driver (rnvme [2]).
> > 
> > The platform bits, besides adding some more evidence to the base abstractions,
> > are required by a few more OOT drivers aiming at going upstream, i.e. rvkms [3],
> > cpufreq-dt [4], asahi [5] and the i2c work from Fabien [6].
> 
> A rebase of the asahi driver onto this series still probes the platform
> device and the driver works as expected.
> 
> Feel free to add
> Tested-by: Janne Grunau <j@jannau>
> 
> We plan to import this series for the Asahi Linux downstream kernel
> starting with v6.12 and replace the old rust-for-linux Device/Driver
> abstractions with this.

Great!  I'll wait for the next respin of this as it seems there's been a
lot of review already, and I've taken some of the patches already, so
odds are after 6.13-rc1 is out the series can get a lot smaller.

thanks,

greg k-h

