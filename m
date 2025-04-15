Return-Path: <linux-pci+bounces-25957-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBA7A8A981
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 22:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889141902593
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 20:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510F12561BF;
	Tue, 15 Apr 2025 20:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YORvVi7J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256632550CE;
	Tue, 15 Apr 2025 20:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744749814; cv=none; b=mEY4sjQq/mWL/d+sauvP+y85GFjtj5yBUrH/UG3To7741tTIWP7kdOgWSS5408EfXWWWF5kqJsG1a7itwJKBMzsgaIiZwZKOwM/rD6IUOIJms12qt+9LvJHqxYmd2XgBdLSK1serm7/HbcU3wBt85rsTWfMzqR43XD4HIP686as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744749814; c=relaxed/simple;
	bh=Jnw815GHILnPLJZ3XhDQCBIeNl7fmB7rRpC9IhbMbpM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KDqWgCQX7iOmiEquRtRJtIyRE+7cMf8OxilfB9l01y1nfIg5gtWOKg8rd3BTVbxyQVae5iNj8tOjujyF4b1ILJjKgoe7IMNgAUV+w+8rhzslbtE0IgTrT8qzThiSwmpIm2Q3Ld4kMUGga1EgDHD9Uk0EZXjEkla4YZ4wLN01aEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YORvVi7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1D3C4CEEB;
	Tue, 15 Apr 2025 20:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744749813;
	bh=Jnw815GHILnPLJZ3XhDQCBIeNl7fmB7rRpC9IhbMbpM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YORvVi7Jh0eW2RhfCHGfSde8oGxKf9rlj3Skf+qQuLd/CYu/+Na9AtKDwmpdS+3PU
	 O3wBt9x9VPCr2KJzAOurbd+6BmAF8m84YREfgrvZb7GU6rlaQWHlV/uwHmx+/AmLH/
	 ecwmthgn3Y/MsYaT8wZuI9n2Qz46aQTnDRMQgA130i3cFN+ze/12LoDonJAGEBbQN6
	 OFEWYF95tl9T8NCO3DgFIPtXupE0ax7X4NpBNLfF1iEmsSeMEuOgTy0yjio6/2IV4i
	 R+c/Jn65P3wFMiIwXK+ZtzJYvFB6/nhg/fUXYue4L6K4SgWFe/q4X1wKFYx8+ky07W
	 ce3zWBxP4OoUw==
Date: Tue, 15 Apr 2025 15:43:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, kwilczynski@kernel.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, abdiel.janulgue@gmail.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	daniel.almeida@collabora.com, robin.murphy@arm.com,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/9] rust: pci: move iomap_region() to impl
 Device<Bound>
Message-ID: <20250415204331.GA34889@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250413173758.12068-8-dakr@kernel.org>

On Sun, Apr 13, 2025 at 07:37:02PM +0200, Danilo Krummrich wrote:
> Require the Bound device context to be able to call iomap_region() and
> iomap_region_sized(). Creating I/O mapping requires the device to be
> bound.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/pci.rs | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 1234b0c4a403..3664d35b8e79 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -390,7 +390,9 @@ pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
>          // - by its type invariant `self.as_raw` is always a valid pointer to a `struct pci_dev`.
>          Ok(unsafe { bindings::pci_resource_len(self.as_raw(), bar.try_into()?) })
>      }
> +}
>  
> +impl Device<device::Bound> {
>      /// Mapps an entire PCI-BAR after performing a region-request on it. I/O operation bound checks
>      /// can be performed on compile time for offsets (plus the requested type size) < SIZE.

You didn't add these typos here, but

s/Mapps/Maps/
s/on compile time/at compile time/

>      pub fn iomap_region_sized<const SIZE: usize>(
> -- 
> 2.49.0
> 

