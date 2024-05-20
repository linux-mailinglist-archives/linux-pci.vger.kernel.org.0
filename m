Return-Path: <linux-pci+bounces-7686-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665938CA1DF
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 20:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95367B2176C
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 18:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB9827452;
	Mon, 20 May 2024 18:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ss3OPUzi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010DE11184;
	Mon, 20 May 2024 18:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716228983; cv=none; b=lKuTqDmvQmLj15e12X6emivVqvVUsiwyNh+q5PZqd/t3P47B+0rIQr7E5pI2aKPDN8PDZzxX6g2SHcApt2E+R+4R89AMu0rANECQedA2rin9QZnBhMmTjtHlUt08RNwcSardWqesP2Grd82jZgdrFy34BYFcoViOtCmtEHeEsDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716228983; c=relaxed/simple;
	bh=p4sW3FSYcxb0a5JZHAPoFzg4ttlD1fzqmc1QoS+UXGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qq+NwXdK0t3dJkW8JVCIK98VHuyg5rokFvgx7BvYsu4/Cwd8wf3KuUFzO3VJ1uhKpHJVfsbgdUhNtzo790OL8q9ijXgUiNtbqsSBM8DiIH3MqsdFO/pCCu0bfRVV/WyYolyOUW2gYVR0EzLixxGZp9T84+mVqnA0BrmkDs0uH9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ss3OPUzi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F09AC2BD10;
	Mon, 20 May 2024 18:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716228982;
	bh=p4sW3FSYcxb0a5JZHAPoFzg4ttlD1fzqmc1QoS+UXGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ss3OPUzi4wO0qCaeaP6vQt8K0VJHemJvHQJX+lBLs6XiqZ4eIHKcub7gEDYDFZ1KB
	 iqi81K0hbLdQuFiNzEApWt3GqoWDDnzLfj8PvL4q0zsqVfCX9QretH3VKp/RtojxH2
	 Eg0T1T/GYVU7C6d2FXHYQM1lhgShbq3HhB9NGEyg=
Date: Mon, 20 May 2024 20:16:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 00/11] [RFC] Device / Driver and PCI Rust abstractions
Message-ID: <2024052020-basket-amuser-222f@gregkh>
References: <20240520172554.182094-1-dakr@redhat.com>
 <2024052029-unbridle-wildcard-fbf8@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024052029-unbridle-wildcard-fbf8@gregkh>

On Mon, May 20, 2024 at 08:14:57PM +0200, Greg KH wrote:
> On Mon, May 20, 2024 at 07:25:37PM +0200, Danilo Krummrich wrote:
> > This patch sereis implements basic generic device / driver Rust abstractions,
> > as well as some basic PCI abstractions.
> > 
> > This patch series is sent in the context of [1], and the corresponding patch
> > series [2], which contains some basic DRM Rust abstractions and a stub
> > implementation of the Nova GPU driver.
> > 
> > Nova is intended to be developed upstream, starting out with just a stub driver
> > to lift some initial required infrastructure upstream. A more detailed
> > explanation can be found in [1].
> > 
> > Some patches, which implement the generic device / driver Rust abstractions have
> > been sent a couple of weeks ago already [3]. For those patches the following
> > changes have been made since then:
> > 
> > - remove RawDevice::name()
> > - remove rust helper for dev_name() and dev_get_drvdata()
> > - use AlwaysRefCounted for struct Device
> > - drop trait RawDevice entirely in favor of AsRef and provide
> >   Device::from_raw(), Device::as_raw() and Device::as_ref() instead
> > - implement RevocableGuard
> > - device::Data, remove resources and replace it with a Devres abstraction
> > - implement Devres abstraction for resources

Ah, here's the difference from the last time, sorry, it wasn't obvious.

Still nothing about proper handling and use of 'remove' in the context
of all of this, that's something you really really really need to get
right if you want to attempt to have a driver in rust interact with the
driver core properly.

thanks,

greg k-h

