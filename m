Return-Path: <linux-pci+bounces-23636-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B8AA5F7D1
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 15:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1096A7ACFB4
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 14:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66100267F42;
	Thu, 13 Mar 2025 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jx6ptHGX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E680267B6A;
	Thu, 13 Mar 2025 14:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875661; cv=none; b=m4Ro2ggTMuMSWua+G9UoLIm30OQGRQQgMzWn7q85Xe7RjBcviNaDqye0omIpy0UaaCjQEPydKkF0nHLUuL1a876QvNJ11mN2kHYo3vX8pX+0IsFhm+ePCgGqlNVD+NQmNtEogvl23SEPZbIFEppHzat9Wl5R625iTCgcpOwb9Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875661; c=relaxed/simple;
	bh=qtijRb/izivAQPCwNvhHbxLAbtlLCtOwMFmoiy22DC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MN+7z7Tribme3FCIpuW9FHb/wT0POT65QjsUL3WZDH7ga5DfMA3YRDqrFpHWEUGGXrJ4Q6gAyuRwq/huibEh372n+AGY3Rp0y6zg3BxwXVyoCHivbTx1CnjpfwdyM8PsgbRwVgU/u4hYmS2wpJ62C5twdyXnXvimK0cAnIOXUvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jx6ptHGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B96C4CEEF;
	Thu, 13 Mar 2025 14:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741875660;
	bh=qtijRb/izivAQPCwNvhHbxLAbtlLCtOwMFmoiy22DC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jx6ptHGXuW5/1vWrLGJbDxVL8Y9eCv7p7M7LJlzsXYLsaa66QnhI5pPokqsgvMBsm
	 SeICjYSi5BIe+9WaGoeJWq5/g1QqsWkX43M3ic6sOwloNy1GCdoCl8wPCUNv0TNHau
	 WQ6Ghk80FDNh+WrAu0CG8i+zAcafQQpwOyW+RCCgBJAgj3NEI9qwAgedAuDZ2n/5/V
	 jMiJXMACWr/3lHfZfaSviii0rE70iPWl/adq53vx9la2eWy+1FWZYamDC7bHLujCYg
	 6gLqSKI/FBcawlWzWjrlnabfEJH3HPv60JJ+66qPv8nEbEuQxWkkndZWkC5RXrLL2W
	 mszw31zQBg4uw==
Date: Thu, 13 Mar 2025 15:20:55 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] rust: device: implement device context marker
Message-ID: <Z9Lpx9K7ThuEqGEM@pollux>
References: <20250313021550.133041-1-dakr@kernel.org>
 <20250313021550.133041-3-dakr@kernel.org>
 <D8F2GQ4WYT7Z.172Z7R7V8BIGR@proton.me>
 <Z9K2PJEoymuhamT-@pollux>
 <D8F2YBFHCTFL.3TH1E0TB11EHU@proton.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8F2YBFHCTFL.3TH1E0TB11EHU@proton.me>

On Thu, Mar 13, 2025 at 10:52:34AM +0000, Benno Lossin wrote:
> On Thu Mar 13, 2025 at 11:41 AM CET, Danilo Krummrich wrote:
> 
> > However, we can always change visibility as needed, so I'm fine making it sealed
> > for now.
> 
> Couldn't you just add them here? Then sealing wouldn't be a problem.

Yes, but I wouldn't want bus specific stuff to reside in device.rs.

