Return-Path: <linux-pci+bounces-24434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4259A6C76A
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 04:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62AB3467C4B
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 03:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8804DA04;
	Sat, 22 Mar 2025 03:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QQixpt1p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CEC2AE68;
	Sat, 22 Mar 2025 03:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742614016; cv=none; b=Quilq8kPbysUZKToA4jGARCCOXHPEGaikhh9i37b3oBaJQqGTEI9wyS2BXf5sfPJZXy+9rpput+FQ1kgPt+A67nk0ifKiKCypqyWX8mz/J+PJ8AD70uNKeZr/11YSgXBkFZpw4f3qvUIK8kjgpnC+Ex2pNTYtVqKyLuSW5fa0Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742614016; c=relaxed/simple;
	bh=j/LLCUoHPTXw6oYdSB1Eys5I0Z51vRy6sNGAztxMUVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+NeSDvO3VSDLAwYnHmXt25o8CWr5O2tDlj7uNe58T9Mxu6CpUHPDBOgFFjaFxqEgAZrDtQlRiUWh46Wcewl/Ffri3yLShsJQblZhPIMTFhQH1uR0JLr4FwpxOTCe6b32GommlcdtzpzooPRN/4f/60Eo/fcAQyDUYOnp6PcFj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QQixpt1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039DEC4CEDD;
	Sat, 22 Mar 2025 03:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742614016;
	bh=j/LLCUoHPTXw6oYdSB1Eys5I0Z51vRy6sNGAztxMUVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QQixpt1pTaqRE8oX75cQB/vvVlCL9Oja8tOWjGN9uwR7jMwNuXv/8OIMmwmH+Wcli
	 gtIAh1t+pS99Uws30XLJ29IvO6rQ2l6MdutL6mXeOIOlxSf2WKDMS5wENAb18X78qY
	 4GcuRtnTl3JglbuBJ5tn9SD1/6s2dPih+wPBagW8=
Date: Fri, 21 Mar 2025 20:25:34 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] rust: platform: impl TryFrom<&Device> for
 &platform::Device
Message-ID: <2025032112-defendant-devourer-db5b@gregkh>
References: <20250321214826.140946-1-dakr@kernel.org>
 <20250321214826.140946-4-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321214826.140946-4-dakr@kernel.org>

On Fri, Mar 21, 2025 at 10:47:55PM +0100, Danilo Krummrich wrote:
> Implement TryFrom<&device::Device> for &Device.
> 
> This allows us to get a &platform::Device from a generic &Device in a safe
> way; the conversion fails if the device' bus type does not match with
> the platform bus type.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/platform.rs | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)

Same comment as on the pci one, let's figure out if we really want this
before it gets merged please.

thanks,

greg k-h

