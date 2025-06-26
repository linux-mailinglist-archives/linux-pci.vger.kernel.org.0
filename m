Return-Path: <linux-pci+bounces-30818-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB22AEA74C
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 21:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B60188402A
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 19:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBFD1C5F09;
	Thu, 26 Jun 2025 19:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCCLixzm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818E917741;
	Thu, 26 Jun 2025 19:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750967245; cv=none; b=TBzA2aLUIInIQwEY04f+k3+PA6kQGiw3N0NaAuF4UouNp+xA5/iGBRDUMcF2B6eJaQiNtY7Bi1nV9Qf4d35GB0gAmvd5cBFZHF9dya28of3hLXcHSGaJz1HCE7SkxN14AynyVTg3u4Wx+y7zJH6wD4xqpv0uXKUQvADb1XKw+8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750967245; c=relaxed/simple;
	bh=xcu4XaSYK6HDBqeh6tZHA228zdywd97TAlUNU4l9QI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXLjzyi9UTqxq+BIfqSlXiZhDKx++xPUR/bhGwrs5k0YFJ1EcsC9/A8WIFCeYWHb3/9w0I9w7+X+PtRMW7XVxqQ4IHAggw03m8vFllcMe5uLq1XUAx4zrP4BMyL7hGVZXypuVDLRI38yEyAO90YIMwjFceQ6nmBg/cHzlw/VWf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCCLixzm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434B5C4CEEB;
	Thu, 26 Jun 2025 19:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750967245;
	bh=xcu4XaSYK6HDBqeh6tZHA228zdywd97TAlUNU4l9QI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BCCLixzmF4zyH542/Z1FkJHmx+yhyUFoor9ae2xjM+fpctqZHWIEqySD38tbIKgVv
	 ludf3ZMfTHgY0S+pTKlLV+sPwmKEVhys0xDKWyNP2a/5Lz6v3KvKuCdqAMOSvsr5os
	 iMu+cvkA6rPae2umXHHX/MWolqpCwZUcsETfbZMlTwMLp4DJfzxp43UD+zDJxgiAVs
	 LLLgKVxwRfEJbm++vJKLUvORE7vx6Lge+C9e/W5We4/OfC9lqlf3VVhmqn7bPG+a8n
	 iP+Sd8zH413K/ksEDTBiEbuJLcgfdcwWklEAoilkI94wXtam5zKV6IxuhGwgXbzOtQ
	 3GI1xN4iv7l8Q==
Date: Thu, 26 Jun 2025 21:47:18 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, david.m.ertman@intel.com, ira.weiny@intel.com,
	leon@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 3/4] rust: devres: get rid of Devres' inner Arc
Message-ID: <aF2jxp51tvF6SpZR@cassiopeiae>
References: <20250624215600.221167-1-dakr@kernel.org>
 <20250624215600.221167-4-dakr@kernel.org>
 <aFzI5L__OcB9hqdG@Mac.home>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFzI5L__OcB9hqdG@Mac.home>

On Wed, Jun 25, 2025 at 09:13:24PM -0700, Boqun Feng wrote:
> On Tue, Jun 24, 2025 at 11:54:01PM +0200, Danilo Krummrich wrote:
> `T` also need to be `Send` for `Devres<T>` to be `Sync` because that's
> what `Revocable<T>` requires.

I think that's because of Revocable::revoke(), however you can't call
Devres::revoke().

> (Unless we want `T` always being `Send`
> because of the issue I mentioned above)

Yes, we do.

> The rest looks good to me.

Great! :)

