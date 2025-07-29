Return-Path: <linux-pci+bounces-33131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C7DB15171
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 18:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62BC27A4057
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 16:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7616F2690E7;
	Tue, 29 Jul 2025 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jg3qzVaC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489F621767A;
	Tue, 29 Jul 2025 16:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753806962; cv=none; b=dx8Qf3Jy9UEmQ9H6372wFndQWKbFmaArWfINVk6/YlAZ6Q5FCT1jhP+MASl/wTHq/OiM2xEPjf13jCgv4n7DiRNv99zXNettekIADgsSuFXYfZfDP2eRlafysTXoVt83pds8AAI8LAaXxK15mQM8hO5ERXF1DmpFhVWcdVSazjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753806962; c=relaxed/simple;
	bh=O+r4SjkFSBxoj37YP4ikCrlULrTJ/NWAQrOlcqCn/js=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OD6DSjVVH9eBEG/z8uuQSbuGDzbsi1j+lby9m8Iacy1GxpkE/8KhSxQaQ7x72uB7H+LRMQOUQKW4BEnOeHVR9vRardEGjtD9rZZiDo0tAnc+JYL+Ys7GoqSRWm6PYWwO0HuK577JQSN1xhyyJA5AVru3ZNpfk7NDYFhUutItrzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jg3qzVaC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFBBC4CEF4;
	Tue, 29 Jul 2025 16:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753806961;
	bh=O+r4SjkFSBxoj37YP4ikCrlULrTJ/NWAQrOlcqCn/js=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Jg3qzVaCPZV7/wy/lndN1g8gcj4o0GVY3IBFUi1rBEIrcFpFteY4Cj/PYD5FToege
	 dP3CyHreo/bv2M+JIpc7yPW5ZqSVJlcro5IP77PFcP+ZvglRlmbuABljukBwBE3Pks
	 vAf+mz0ZNUBmpqdqGT9zxninxpeNA6nAn+XDGZQXIlickluz85OlvuIf7xZdT18hsD
	 tPyhA1w9lbfx3iSTZuw+bDcbY33J5Enss9mRkaCFGk6u4jQXSUvS2YEQPhsrmKwCpC
	 IhooDzuN86bJ5gMNHPCSgoGTY4wNy2lfwXjVeCGAxbJcLIVDaVUUu74SbRDjBUcq+u
	 cninRYZemMl/A==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Jul 2025 18:35:54 +0200
Message-Id: <DBOOOGFNK5YV.1B67YLP2GBD2A@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dakr@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>
Subject: Re: [PATCH v2] rust: pci: Use explicit types in FFI callbacks
From: "Benno Lossin" <lossin@kernel.org>
To: "herculoxz" <abhinav.ogl@gmail.com>, <linux-pci@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250729102953.141412-1-abhinav.ogl@gmail.com>
In-Reply-To: <20250729102953.141412-1-abhinav.ogl@gmail.com>

On Tue Jul 29, 2025 at 12:29 PM CEST, herculoxz wrote:
> From: Abhinav Ananthu <abhinav.ogl@gmail.com>
>
> Update PCI FFI callback signatures to use `c_int` from the prelude,
> instead of accessing it via `kernel::ffi::c_int`.
>
> This follows Rust-for-Linux coding guidelines and improves ABI
> correctness when interfacing with C code.
>
> Signed-off-by: Abhinav Ananthu <abhinav.ogl@gmail.com>

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

> ---
>  rust/kernel/pci.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

