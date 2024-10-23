Return-Path: <linux-pci+bounces-15089-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620029ABDAF
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 07:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911801C22E59
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 05:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2C913D2B8;
	Wed, 23 Oct 2024 05:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BOk4yNCl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C993F7482;
	Wed, 23 Oct 2024 05:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729660419; cv=none; b=IrJxXWlVT9qVJ4k9csMpbYr1tIA9t8wFNFAg2H7Egj/69nBYb02ocWDCD1jMB7BqlI6KMEHCSWznJcbIq39Q6tUJD2D4lQUXtjYNpTFHmZlIJgubiDtUr0Bl51WFr29jTUl9xjpYILLtYom2H5nVADlTP3BiOo+HVSCjbW03taI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729660419; c=relaxed/simple;
	bh=m+rPki2tptmN7S7B5MXCF9gSzNRRmnntfBRrd6Hgdfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2bOcT1xBXUSnahWQhyuXAyrv4x1i+BTw2w6WSnOzd1X8N5mUJrn9lbw9AmXVL5yBkM3ZRKN6g1Bga4F8g3r0YH2GZy06bhqKFT75+2jaoKcj2rcpo3IbOKTtRH7Ul1EtIuHBHoM/5akE3Fm79D8pUZexyheffDqlo36N0KTbHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BOk4yNCl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121A5C4CEC6;
	Wed, 23 Oct 2024 05:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729660419;
	bh=m+rPki2tptmN7S7B5MXCF9gSzNRRmnntfBRrd6Hgdfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BOk4yNClyJ3XLpfFa2iOs16JDykqYJZqrLVqoN0faTrZg+xuH1SJecsMl3B9dPYP9
	 rwH0sayzLp3sO+7sUh79SUoKXkNglLyncBoOQ6lBSyx2KqjH372V8Ltszk9nkcaHb1
	 4P0cZmC2/0yC32YCudCniiI+DAS340Yymh/slD3E=
Date: Wed, 23 Oct 2024 07:13:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, tmgross@umich.edu,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, saravanak@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 00/16] Device / Driver PCI / Platform Rust abstractions
Message-ID: <2024102324-giver-scavenger-a295@gregkh>
References: <20241022213221.2383-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022213221.2383-1-dakr@kernel.org>

On Tue, Oct 22, 2024 at 11:31:37PM +0200, Danilo Krummrich wrote:
> This patch series implements the necessary Rust abstractions to implement
> device drivers in Rust.
> 
> This includes some basic generalizations for driver registration, handling of ID
> tables, MMIO operations and device resource handling.
> 
> Those generalizations are used to implement device driver support for two
> busses, the PCI and platfrom bus (with OF IDs) in order to provide some evidence
> that the generalizations work as intended.
> 
> The patch series also includes two patches adding two driver samples, one PCI
> driver and one platform driver.
> 
> The PCI bits are motivated by the Nova driver project [1], but are used by at
> least one more OOT driver (rnvme [2]).
> 
> The platform bits, besides adding some more evidence to the base abstractions,
> are required by a few more OOT drivers aiming at going upstream, i.e. rvkms [3],
> cpufreq-dt [4], asahi [5] and the i2c work from Fabien [6].
> 
> The patches of this series can also be [7], [8] and [9].

Nice!

Thanks for redoing this, at first glance it's much better.  It will be a
few days before I can dive into this, It's conference season and the
travel is rough, so be patient but I will get to this...

thanks,

greg k-h

