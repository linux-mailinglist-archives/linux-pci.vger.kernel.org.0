Return-Path: <linux-pci+bounces-16916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A929CF353
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 18:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48DC1F2374D
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 17:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823D11D5ABF;
	Fri, 15 Nov 2024 17:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PX9jIUTe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC50171658;
	Fri, 15 Nov 2024 17:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731693228; cv=none; b=NfymJ2Pc1TVyMKNHrA9PiH4YTsAJwxJJKxnEb1eVq75ppKISd8Woq0FP3P9Sjwzlp/7tO6z0oLGIz+mOAJMaZ2v2Y3hrpVZYic7ZUgAdpA2DFGWdIvPL7sKwca8G2eyPcvoqQlzyQSDQQK4zdxLU0ic5/EV44YIv+lZvvJbA/T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731693228; c=relaxed/simple;
	bh=rYI8EaYodfdmH37kAApuPQ41T6bd+YLA/SYg6lziQSA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QdPBaMUUMBHn+1IaC4SV5eK/aLv1lBLUVOWxFPRmz4E8sSzBbPkynQGRRU+zBA0lttGvHxvRAiFJ7qimNY4LkjZtE+if2zg1Ct1S6vYRLXTcJGgLZBEtM3BawB02LaRhLLErQdxeYaNr+J/ViDmuDtpy7/9+OKQIxWOLTjykbhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PX9jIUTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF801C4CECF;
	Fri, 15 Nov 2024 17:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731693227;
	bh=rYI8EaYodfdmH37kAApuPQ41T6bd+YLA/SYg6lziQSA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PX9jIUTe7ymC63rKfXezkcocPgtH59QMjSU241aSWkZOl//7yF0Ub7KI6o104yvQw
	 7/wlAdTO6o5bKlKfvNvkaDa39yUEqjr3FkeOin5SybrEn9Y7TPpMpTdOMQG6VSE2pu
	 onij9pAsYR+P5GHw9NtQsMUlP+xAi4qz7axuo9jvWKCJWdlkhktWsSyVfY74xKG0G5
	 jMLhEGgDrUlxNPfAN3DDVWYglgnHtC0+MKPvqvcwetXjUvCXx7HShpZxqnSAmox0az
	 y7XYWiPhipHcJjjMjU1qTOxKbEyJDfzqWCsn9Wn81u1I/WxdWHjvwsAXJ6F37bJOlI
	 uiRQCmiN5rQPg==
Date: Fri, 15 Nov 2024 11:53:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alistair Francis <alistair@alistair23.me>
Cc: lukas@wunner.de, Jonathan.Cameron@huawei.com,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
	bjorn3_gh@protonmail.com, ojeda@kernel.org, tmgross@umich.edu,
	boqun.feng@gmail.com, benno.lossin@proton.me, a.hindborg@kernel.org,
	wilfred.mallawa@wdc.com, alistair23@gmail.com,
	alex.gaynor@gmail.com, gary@garyguo.net, aliceryhl@google.com
Subject: Re: [RFC 1/6] rust: bindings: Support SPDM bindings
Message-ID: <20241115175346.GA2045933@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115054616.1226735-2-alistair@alistair23.me>

On Fri, Nov 15, 2024 at 03:46:11PM +1000, Alistair Francis wrote:
> In preparation for a Rust SPDM library we need to include the SPDM
> functions in the Rust bindings.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  rust/bindings/bindings_helper.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 7847b2b3090b..8283e6a79ac9 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -24,6 +24,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/sched/task.h>
>  #include <linux/slab.h>
> +#include <linux/spdm.h>

Usually an additional #include goes in the same patch that makes use
of the new .h file.  Maybe there's a different convention in rust/?

>  #include <linux/uaccess.h>
>  #include <linux/wait.h>
>  #include <linux/workqueue.h>
> -- 
> 2.47.0
> 

