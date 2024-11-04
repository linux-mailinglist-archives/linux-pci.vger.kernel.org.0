Return-Path: <linux-pci+bounces-15904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F759BAC36
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 06:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C141F23690
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 05:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE73418BC1C;
	Mon,  4 Nov 2024 05:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O77Z6fJ9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9146114E2FD;
	Mon,  4 Nov 2024 05:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730699305; cv=none; b=hnH1v8W+Etou6Aq2tHxcz0p5nXtwqA6HmlOSV+fwaf3XNpcDIKU4DGZcvv6qMFBo4f/NNqCjMC+inzJt4miegUbTEaUA0WLtIhHvWEesop2QMohIU9wWfRlmV1p2vmBgFBb195Y6HeviOP6vb1+5q5+UbcZPV3N7ubROssYTImA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730699305; c=relaxed/simple;
	bh=B1KH/Bq2gXhpWwNvJdqHlM36GE9xSh5E23+vE+/6SPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aW7q2l+0NRSQ37d/XCW+lWnZKwjWa54hALE64G86gmkPZZcVr9QNErZG3uDyLI4uKxDmQbzJe616jjB7sAtTwELC692x1tUwn0RbMI9xtrrHZN2amizV7gPKcAuvnQf2IRp2VVWtHDlk+J+TvtNXGIz/p/vHBXb7Xhttl5ESAeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O77Z6fJ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96521C4CECE;
	Mon,  4 Nov 2024 05:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730699305;
	bh=B1KH/Bq2gXhpWwNvJdqHlM36GE9xSh5E23+vE+/6SPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O77Z6fJ9RU4Ps6WqWiBppB+u+B8lk9Cn8XA/RZwIqzC9Izp33ERkWP2nEvhbL7s2o
	 JcXFkGnZtlspN1zmaI49XhGmvo0UUz/uRsusY527qXi1ncoutXhcsair879aizQrcb
	 DgpsEgovKCxXrUnLvwdq5Qx0vlWDBfrSpJDek7Yo=
Date: Mon, 4 Nov 2024 01:24:26 +0100
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
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	Wedson Almeida Filho <wedsonaf@google.com>
Subject: Re: [PATCH v3 08/16] rust: add `dev_*` print macros.
Message-ID: <2024110409-speller-blasphemy-2539@gregkh>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-9-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022213221.2383-9-dakr@kernel.org>

On Tue, Oct 22, 2024 at 11:31:45PM +0200, Danilo Krummrich wrote:
> From: Wedson Almeida Filho <wedsonaf@google.com>
> 
> Implement `dev_*` print macros for `device::Device`.
> 
> They behave like the macros with the same names in C, i.e., they print
> messages to the kernel ring buffer with the given level, prefixing the
> messages with corresponding device information.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/device.rs  | 319 ++++++++++++++++++++++++++++++++++++++++-
>  rust/kernel/prelude.rs |   2 +
>  2 files changed, 320 insertions(+), 1 deletion(-)

This is good to grab now, I've added it to my char-misc tree, thanks!

greg k-h

