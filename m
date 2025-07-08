Return-Path: <linux-pci+bounces-31727-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF9CAFDB19
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 00:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AAA65A04FB
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 22:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5A4259CA4;
	Tue,  8 Jul 2025 22:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NullbJA8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B1F262D27;
	Tue,  8 Jul 2025 22:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013532; cv=none; b=Cqq+FZMiU697Ts10K2fbpaHHqnImIx10MWzUOODmz2k6QUWHcq4RFu/OaIEXamGeDbsTRm/OMChUAvM9K9TsTXkeV3Xh7VduYRAXNEvbYOHCEXvI+eMyJ3ruE8r4MO6Bn7ZGQMO0CmfeJLew7W+iTmkCti6ynnbkVgZM/Ttxtac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013532; c=relaxed/simple;
	bh=tsic+CjllM+OAvPa+Pcmiv6oOA6PXxmjsxkJLhpFgv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3rPwf06GVZIZU8eAo++rroUxcqkikudvUlkRY1zNZzepRvIgNviVZmwac+6sqVll1XZajuBWGjAkLfeUSgx+Z25m6bFLCP+6+Azdb+RulYqFEGMr6I5axouQCTa1XgJY79Z6Wc1qvV7UvJ4n78/ch8vYgA2tjLqfa01iMIP9cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NullbJA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97C2C4CEED;
	Tue,  8 Jul 2025 22:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752013530;
	bh=tsic+CjllM+OAvPa+Pcmiv6oOA6PXxmjsxkJLhpFgv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NullbJA8QNVVrSGAFQ159V6rwJ7T8FnxOAHePU6u0FN0+p+5eR8Kva3Mp4cBk+r4s
	 EW+m0CJVYYOEO9r2jfXAChWbzlCcoWaOBE8fkJfEmWBQL4uDu5FSeLUiPHkIH2Hk9U
	 C0fjdZifRvtbRx5xHimRfy5U1T/KUGM4BIyQ7V+RqSF4qCHOOMJq+EN7RBzPxZqpgr
	 SpXem4pyZtOfDSL1fpj+xBH62HhevDiwEGzRmxHJjOe2iTYG7iu8UBb7n2GU8QzakQ
	 ealjdexhnmKdBQTroKDvliteK8J8XqviOmi4VVTvKIYkCp9u1cF7K112SQ/dzwzPRW
	 Jz1dSiN/Gu7yw==
Date: Wed, 9 Jul 2025 00:25:24 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	david.m.ertman@intel.com, ira.weiny@intel.com, leon@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/8] Device: generic accessors for drvdata +
 Driver::unbind()
Message-ID: <aG2a1CgIOmw5Z16M@cassiopeiae>
References: <20250621195118.124245-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250621195118.124245-1-dakr@kernel.org>

On Sat, Jun 21, 2025 at 09:43:26PM +0200, Danilo Krummrich wrote:
>   rust: device: introduce device::Internal

  [ Rename device::Internal to device::CoreInternal. - Danilo ]

>   rust: device: add drvdata accessors

  [ Improve safety comment as proposed by Benno. - Danilo ]

>   rust: platform: use generic device drvdata accessors
>   rust: pci: use generic device drvdata accessors
>   rust: auxiliary: use generic device drvdata accessors
>   rust: platform: implement Driver::unbind()
>   rust: pci: implement Driver::unbind()
>   samples: rust: pci: reset pci-testdev in unbind()

Applied to driver-core-testing, thanks!

