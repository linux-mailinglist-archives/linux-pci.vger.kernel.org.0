Return-Path: <linux-pci+bounces-30330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD14AE3252
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 23:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A67316BF84
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 21:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89D01E1E16;
	Sun, 22 Jun 2025 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5c8obAH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBCCEAC6;
	Sun, 22 Jun 2025 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750627502; cv=none; b=CnrEz1LjlnK5FeImRbzT0RS4rJriVA6Mjcar0wFQ662Ea4JAmpjeDHF3NTX7if7d3taohgMsgg72qLstW2NdUKE2O9SEM6P1MKCW0HEbV3Xq9LfmO54UgcdEwEbLwQ5HUcgPvA3g+qrOIMzRTGS3yFe8IIe/syh77rGNbQGeuzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750627502; c=relaxed/simple;
	bh=8/2UrdJdL3tI5R3CdY1YLQPUiY26P9svZ/G/GHIcZo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+8OJMMpuxJgbrsDtCh8faYYEVxybvs64lHs7Vwd2Ul5jcJAbCQ6uMNcweEoe0fvcOiwqisUiCmzBaRMy9GTVdwJrzsH+72LfM8snevjVqAfrBxb5dlZF83lq17WzSOBMN+u38n/ejXVDft/8hzAKozRnZn2QBc+2LR8gcP+u1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5c8obAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66112C4CEE3;
	Sun, 22 Jun 2025 21:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750627502;
	bh=8/2UrdJdL3tI5R3CdY1YLQPUiY26P9svZ/G/GHIcZo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a5c8obAHIQVaj7BDwP2o9InZpiRvjolHKCmHuKXcuJ3g1T5qV7mg5zvwc5dzcrhxG
	 oez2qRmkK/C6aZus9Ss2ZzEU5PwHH3IkQUEOrzB0aZHhQTQjtiNqTfooh5sSU1toDZ
	 kOBSmYiq4U14ZLZrfDm3cCcFIuFN/P7gzrCj9P3SfTDECEWYeqeKBsF0wLBswmd+wr
	 Jax2k8si8gCGEnzDbuOMUXy8uY+KNNfC+OzdChhn3lFbZ6SIpwNl+Ze/DtzhNefSZ1
	 xFpYRe7KCyz6ED55QWdUdkupTKwHuOXyiFxIjNhj3iwz+OqK/GU0/DXM3l+umhnsy9
	 WE5CIHO2nUN8g==
Date: Sun, 22 Jun 2025 23:24:55 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <lossin@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, david.m.ertman@intel.com,
	ira.weiny@intel.com, leon@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 4/4] rust: devres: implement register_release()
Message-ID: <aFh0p5p_89025kcg@pollux>
References: <20250622164050.20358-1-dakr@kernel.org>
 <20250622164050.20358-5-dakr@kernel.org>
 <DATCV8XFK7TO.2MYZKKA28JEQV@kernel.org>
 <aFhxtv5tOavHP0N-@pollux>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFhxtv5tOavHP0N-@pollux>

On Sun, Jun 22, 2025 at 11:12:28PM +0200, Danilo Krummrich wrote:
> On Sun, Jun 22, 2025 at 10:47:55PM +0200, Benno Lossin wrote:
> > And maybe a closure design is better, depending on how much code is
> > usually run in `release`, if it's a lot, then we should use the trait
> > design. If it's only 1-5 lines, then a closure would also be fine. I
> > don't have a strong preference, but if it's mostly one liners, then
> > closures would be better.
> 
> It should usually be rather short, so probably makes sense.

Quickly tried how it turns out with a closure: The only way I know to capture
the closure within the

	unsafe extern "C" fn callback<P>(ptr: *mut kernel::ffi::c_void)

is with another dynamic allocation, which isn't worth it.

Unless there's another way I'm not aware of, I'd keep the Release trait.

