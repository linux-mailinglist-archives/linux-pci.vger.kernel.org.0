Return-Path: <linux-pci+bounces-24307-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A00A6B696
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 10:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9F243AC211
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 09:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CCD1E8336;
	Fri, 21 Mar 2025 09:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bomm0v7m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC608BEE;
	Fri, 21 Mar 2025 09:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742547866; cv=none; b=g1KxdX5M0KKWPJKfYlwQQWngtVm5/iGzFkJQzBo3xb/Mg1FcVqVJBs/c11psBM1lWwEjtdOdyrF7ehNzI+BIL0sIyRQqsvbST5cDx/AKtgqNzRXLSImFpCFQeHwRxplk3bjtuqBloxQ5I5EWBG7JK8IkhTeTYkBMUMY+oRFRaEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742547866; c=relaxed/simple;
	bh=gg9hEPqRWjLsC34kOaZebN3D3xciWD7Inmq5RpjuyTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7hYsh2ImjGz6AWzeNVLoZ0ZBp7+kofRgUt5GsVdojA9+/suKn+VGeei95NeZTMh6HGRl16imAyXTDJLxCQ3VCkbgK4dAkeZg/gJythie9EP6DtvTEp4O+KCDXl90EQp13if+pvpC37BceFMf0LAaLy02uCFm7LUYd9vr5QQ9X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bomm0v7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28552C4CEE8;
	Fri, 21 Mar 2025 09:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742547866;
	bh=gg9hEPqRWjLsC34kOaZebN3D3xciWD7Inmq5RpjuyTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bomm0v7m/qiXPg9sp+hvXCAusT7kty5EkAKNLho7jGZPNyaRWKA8VMpsqMEb9EXvu
	 tiGo59MUtpYLLjNwnRJUlV5reWJa59uZKszehT9gaBGaQT+7MZZDJ4yxnyM0r65zDD
	 SF2BR7v6wIbQT+uV9BYXEBz0mzXZAvbG5VEokv8/PmhehYzGM1obqUruvhmU7y6awM
	 VJr2EuLpqc83C0GDCE5aaOx8/MTnoDXTKiyGVqCjDWfIA+qKWbvbquKZIHeZvbLfDk
	 m35l9yyigN12aWBPPRNQIB2vLsPGWdAXsThgb1wIlGVxtAx6toEr1aWRU6zp56FKLg
	 DOBu5SpYqmjgA==
Date: Fri, 21 Mar 2025 10:04:20 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: bhelgaas@google.com, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] rust: device: implement Device::parent()
Message-ID: <Z90rlKC_S5WQzO8P@pollux>
References: <20250320222823.16509-1-dakr@kernel.org>
 <20250320222823.16509-2-dakr@kernel.org>
 <2025032018-perceive-expectant-5c48@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025032018-perceive-expectant-5c48@gregkh>

On Thu, Mar 20, 2025 at 06:40:56PM -0700, Greg KH wrote:
> On Thu, Mar 20, 2025 at 11:27:43PM +0100, Danilo Krummrich wrote:
> > Device::parent() returns a reference to the device' parent device, if
> > any.
> 
> Ok, but why?  You don't use it in this series, or did I miss it?

Indeed, it should rather be at the auxbus series.

> A driver shouldn't care about the parent of a device, as it shouldn't
> really know what it is.  So what is this needed for?

Generally, that's true. I use in the auxbus example and in nova-drm [1] (which
is connected through the auxbus to nova-core) to gather some information about
the device managed by nova-core.

Later on, since that's surely not enough, we'll have an interface to nova-core
that takes the corresponding auxiliary device. nova-core can then check whether
the given device originates from nova-core, and through the parent find its own
device.

[1] https://gitlab.freedesktop.org/drm/nova/-/blob/staging/nova-drm/drivers/gpu/drm/nova/driver.rs

