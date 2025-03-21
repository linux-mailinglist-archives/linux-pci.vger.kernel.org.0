Return-Path: <linux-pci+bounces-24385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 155B9A6C1C9
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 18:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7E93ADB93
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 17:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A633C22DFAB;
	Fri, 21 Mar 2025 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCk1oP/y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E9A22DF8A;
	Fri, 21 Mar 2025 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742579069; cv=none; b=WhqrRtHCydQMh43EsTOLtmHRgAwLxzxhmbB9y89nzJGHY5gNrZ/3tJ72YCeRjshhaCyGrCIzfTqZBl8E4iRXr6RglaspDJPiui3peuZySiEfvRsyBRa2LF/zo/QQNeGfwTHc5ld5I30y6nZiogvHXrj5FGXxBjdWvjua9wp3+Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742579069; c=relaxed/simple;
	bh=DjlAGlHjS9GqXLhTgfhRah3yZAUnReyXOR1W3OIyrxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxCgiGo9Npu23KpmbSO7ZPJhRIC1afX93gy5mkWWOEiD3TsCcQ5L7GHCSijW0FnmJGeahkRHIjKk5CGmQhZN0Rcv35GaATut178ikZU0bEPp2e4kz1mHqvJCAaL7jJyx9/DPN7T+NQtkaLdzXn/yzYz1yR4ruc2/dXJkH3yp0Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCk1oP/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF59C4CEE3;
	Fri, 21 Mar 2025 17:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742579068;
	bh=DjlAGlHjS9GqXLhTgfhRah3yZAUnReyXOR1W3OIyrxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nCk1oP/yRnZej5wtJYmlpz3pkfrlu08gHJtwK8Ez6JSDYv1l08/AvMUmXbHzEj5En
	 hwuRgfIzjS0to+VfkTGL+9+8MMpKv+vuqRAHTISwt/aa7YodmycjIPJe+1Fj1smstR
	 xfAmtOJb2ZLw4JWFto7fSrNrO4apTSYnxg/nW4o9BkQLvUgAN7pznvWWqJoWPiiG0/
	 BFItQso3D1ogYUijpNbgQQiO+35ATVTK2ZljZs88c4WMt8/T+PI46Uh8bu5la8ZTP7
	 FchI8JLRXIzDN5eFudIwk8quayaWmLY7TbUkun4aJFw6Ts4fkogjnxQbzUAboJSsgp
	 0RG0wUa+68umA==
Date: Fri, 21 Mar 2025 18:44:22 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rust: pci: impl TryFrom<&Device> for &pci::Device
Message-ID: <Z92ldvI4ihlm0HJd@cassiopeiae>
References: <20250320222823.16509-4-dakr@kernel.org>
 <202503220040.TDePlxma-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503220040.TDePlxma-lkp@intel.com>

On Sat, Mar 22, 2025 at 12:56:58AM +0800, kernel test robot wrote:
> >> error[E0133]: use of extern static is unsafe and requires unsafe block
>    --> rust/kernel/pci.rs:473:43
>    |
>    473 |         if dev.bus_type_raw() != addr_of!(bindings::pci_bus_type) {
>    |                                           ^^^^^^^^^^^^^^^^^^^^^^ use of extern static
>    |
>    = note: extern statics are not controlled by the Rust type system: invalid data, aliasing violations or data races will cause undefined behavior

This requires an unsafe block for compilers < 1.82. For compilers >= 1.82 it
turns into a warning *if* using an unsafe block.

*Not* requiring unsafe for this seems like the correct thing -- was this a
bugfix in the compiler?

I guess to make it work for all compiler versions supported by the kernel we
have to use unsafe and suppress the warning?

