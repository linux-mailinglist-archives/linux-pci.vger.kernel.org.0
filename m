Return-Path: <linux-pci+bounces-8976-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F062190EABE
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 14:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D66C1C240A6
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 12:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA93C140E47;
	Wed, 19 Jun 2024 12:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cu+jPbtp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9600213F43B;
	Wed, 19 Jun 2024 12:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799481; cv=none; b=aIWwHr8adbzv2TcJ/xP/vfDVOWEQtqSeipKaZ6cKLDhrk3F3xxgx9oNSZ87y8KDPb+y0AYCy9Vz9eKGwuCJgq94H1dyk9XRa6YrdUBqngw5iiqXOp+FimSIWiVI5EwRLrO4f+gJ7AylD9pc1smwNDCcaa8GbOAULyTiPiTW6EOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799481; c=relaxed/simple;
	bh=TWnMaEvCvx0cR2o6SryzwIH73EH/ed79KtcNQbuis34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LD5hOIwkScN7b4TX7OIp4reO5S3MU6+UfJaMNz7EXanyPcnQrs83Wrat4QY/za0Frk2Hei0I9lNMpgWXWK7K2CwUsVsyS21eW5tfXatef431WqyhbZPGvYBdhdtej7QnxPtZYpjYtX9qTbTZgV5sBcyaT6zBc3VErpexrRu+KR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cu+jPbtp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E972C2BBFC;
	Wed, 19 Jun 2024 12:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718799481;
	bh=TWnMaEvCvx0cR2o6SryzwIH73EH/ed79KtcNQbuis34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cu+jPbtpHoi2meRDzKvODYh9ya5iH0Cxunf+1ho54i1DmRo1nvSbH86+B8G8013z9
	 4//wy45SeW7fRqiLVNI5CKstKRTCVwQoIsCYYce0zTSjbg3mPW7wKkyckO7e7Y3fSN
	 WKACsgYJDS5b/pbvYldLJmxcuCuRb3py+6SWFfKE=
Date: Wed, 19 Jun 2024 14:17:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Danilo Krummrich <dakr@redhat.com>, rafael@kernel.org,
	bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com,
	wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 00/10] Device / Driver and PCI Rust abstractions
Message-ID: <2024061929-onstage-mongrel-0c92@gregkh>
References: <20240618234025.15036-1-dakr@redhat.com>
 <20240619120407.o7qh6jlld76j5luu@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619120407.o7qh6jlld76j5luu@vireshk-i7>

On Wed, Jun 19, 2024 at 05:34:07PM +0530, Viresh Kumar wrote:
> On 19-06-24, 01:39, Danilo Krummrich wrote:
> > - move base device ID abstractions to a separate source file (Greg)
> > - remove `DeviceRemoval` trait in favor of using a `Devres` callback to
> >   unregister drivers
> > - remove `device::Data`, we don't need this abstraction anymore now that we
> >   `Devres` to revoke resources and registrations
> 
> Hi Danilo,
> 
> I am working on writing bindings for CPUFreq drivers [1] and was
> looking to rebase over staging/rust-device, and I am not sure how to
> proceed after device::Data is dropped now.

As it should be dropped :)

A struct device does not have a "data" pointer, it has specific other
pointers to hold data in, but they better be accessed by their proper
name if you want rust code to be reviewable by anyone.

Also, you shouldn't be accessing that field directly anyway, that's what
the existing dev_set_drvdata/dev_get_drvdata() calls are for.  Just use
them please.

thanks,

greg k-h

