Return-Path: <linux-pci+bounces-24342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6CEA6BB60
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 14:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5216C189BD00
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 13:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966BB21CA1D;
	Fri, 21 Mar 2025 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RF5dU4Uk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682DF1E87B;
	Fri, 21 Mar 2025 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742562217; cv=none; b=CF2Wn5G4ch7HdGRuhgNGJqVDukDRPiZmqUiXJeSlsCpP2d/8H5mUhwy+3ZY415FhHXkYP/G5ak2+D+TGHNoWYpbZl7gU6/7iZUQb5yn8HEOTIo+RsBndSSlwtyRBOvYXo5OGG6DBc4lWpOPQdMe6lkG+rC/biuVzkRfMA4yRTz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742562217; c=relaxed/simple;
	bh=k2xJTgHnNugRE2PnfmjVd4Mic9Bg4XqXyk2wp2c0aP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmTIgxHiR3f5FWH0va79zDmXO1u9cuDDAhmfyn3l521ZNrCfF96oQu4PZDgFPr/EaOTnYQvKhguioRmQCenCZTs/QabZIRbgMGGMeW9nSelzHGNxgM2HgU+nLiijpIOotVfIauppPkjWQQ8MLu3LQETVJ4SW+ZjMDWnECKwQFno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RF5dU4Uk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94E6C4CEE3;
	Fri, 21 Mar 2025 13:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742562216;
	bh=k2xJTgHnNugRE2PnfmjVd4Mic9Bg4XqXyk2wp2c0aP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RF5dU4UkKiP32X4oCvEc1gJIQyYatY0pNokMcFNq6bHpvxvoZPJ36v9MntJjKAnpL
	 IsR5C8G8RBBCu7/bpKRwRBFa8f7oJfW39drJnI/kRpg4UpHuCZqzu7WaSbjnfVYkuA
	 zZZu3qjxUY/GJJlF6A8MB8mFQSGVJz17qsLB/P9VAQN9epSVuh+QroE4Fx5HemU2fY
	 NWFD/hbw8WxKHaR97XkwtqLv+0AUSqc5pBMLVL5PUgOP7jlAvpHqczE0GwiVJRmOAB
	 wTkeKXRk6TdXTmVzRvZuvnld8EZl/Mhh6JpF+++K3wkyM95h7zLstbOhlKFudPAvWj
	 qVEg5BWAc2yIA==
Date: Fri, 21 Mar 2025 14:03:30 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: bhelgaas@google.com, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] rust: device: implement Device::parent()
Message-ID: <Z91joggxxBh3e0d8@pollux>
References: <20250320222823.16509-1-dakr@kernel.org>
 <20250320222823.16509-2-dakr@kernel.org>
 <2025032018-perceive-expectant-5c48@gregkh>
 <Z90rlKC_S5WQzO8P@pollux>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z90rlKC_S5WQzO8P@pollux>

On Fri, Mar 21, 2025 at 10:04:26AM +0100, Danilo Krummrich wrote:
> On Thu, Mar 20, 2025 at 06:40:56PM -0700, Greg KH wrote:
> > On Thu, Mar 20, 2025 at 11:27:43PM +0100, Danilo Krummrich wrote:
> > > Device::parent() returns a reference to the device' parent device, if
> > > any.
> > 
> > Ok, but why?  You don't use it in this series, or did I miss it?
> 
> Indeed, it should rather be at the auxbus series.
> 
> > A driver shouldn't care about the parent of a device, as it shouldn't
> > really know what it is.  So what is this needed for?
> 
> Generally, that's true. I use in the auxbus example and in nova-drm [1] (which
> is connected through the auxbus to nova-core) to gather some information about
> the device managed by nova-core.
> 
> Later on, since that's surely not enough, we'll have an interface to nova-core
> that takes the corresponding auxiliary device. nova-core can then check whether
> the given device originates from nova-core, and through the parent find its own
> device.
> 
> [1] https://gitlab.freedesktop.org/drm/nova/-/blob/staging/nova-drm/drivers/gpu/drm/nova/driver.rs

Another category of drivers that came to my mind and seems valid for this is
MFD.

Other than that I found a couple of cases where platform drivers interact with
their corresponding parent devices (mostly embedded platforms where the topology
is known), as well as a couple of HID devices that access their parent to issue
USB transactions etc., which all seems more like an abuse due to a lack of
proper APIs, which may or may not exist at the time the corresponding driver was
written.

So, maybe we should make Device::parent() crate private instead, such that it
can't be accessed by drivers, but only the core abstractions and instead only
provide accessors for the parent device for specific bus devices, where this is
reasonable to be used by drivers, e.g. auxiliary.

