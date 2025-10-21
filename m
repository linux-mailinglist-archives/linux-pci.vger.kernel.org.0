Return-Path: <linux-pci+bounces-38932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13522BF7F0F
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 19:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C85063AA9AD
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 17:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC1D34C80A;
	Tue, 21 Oct 2025 17:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnHRPa43"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E59234C806;
	Tue, 21 Oct 2025 17:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068646; cv=none; b=JAc9XlNfRun2cVYTxsTBdvJy5Ph0QB9gkjHlnyM4fWC1I0gtTNL9l/8VevYuRDl3LVZeS6dzXT1viu4mZjPQ21rgwkEOIiJbDegTThByPkVGR1qS0ep+rxpKmQ9Q0cDiF6gcNtEs9yE75PKQN72yX8P8pSkCIW82iqPsiAeGs/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068646; c=relaxed/simple;
	bh=bHNcj1wjfOdU2U4vdwQgraEX91IYvZD0sUGfn4zYsro=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=jU4dy80W2oFn+V0jE7uZuizi4F+TitwBHMEzEVdxvYCsV7YVVMFgxQ+qn04dhs1w8896ZaFxfOEDWiQCdzGGmOqef1+snB61h8ngE6+DcKCCH8ks1GE/6LLkrSy4JHnvUt2yTIpXPa4sC2IXqOoAHXKLGRhJg9hSs0JAsGQlmVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnHRPa43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E238C4CEF1;
	Tue, 21 Oct 2025 17:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761068645;
	bh=bHNcj1wjfOdU2U4vdwQgraEX91IYvZD0sUGfn4zYsro=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=YnHRPa438hTYGZhg9fL0jrPt31M9vKs49W/DgdnAdE7iFZ+j5VZsieEpvyXqZ+z0F
	 EZ5b4QWH2XJdtdTh/5fEyB0KAPwNEfgYZ7FBGGmllt0pq7FkmUCO+qW/hh/ywNNvEW
	 YsBmZTKCQ8ner/3MPqz+TvFo2LK47Ei17tAZtrPNmD88ujHxAwDWd7IJ4eOjnAcdj7
	 ufRY3JWW9DDZkHUaT2CsMWCCaXOtWv34OQ0FwcIw7LDg/9dDIoILU3JUyGzEFo+iIY
	 5T4qk+Ztqz5sTs7RpqQBi5P0qj0R8J6YwzPChhiQWi00pg5pcvg3FeABlZcYZq5aVu
	 JWOwPsaFDIUiQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Oct 2025 19:43:58 +0200
Message-Id: <DDO6QBSWU8MN.3UA0DT8WDUPZT@kernel.org>
Subject: Re: [PATCH] rust: driver: let probe() return impl PinInit<Self,
 Error>
Cc: <viresh.kumar@linaro.org>, <acourbot@nvidia.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <daniel.almeida@collabora.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251016125544.15559-1-dakr@kernel.org>
In-Reply-To: <20251016125544.15559-1-dakr@kernel.org>

On Thu Oct 16, 2025 at 2:55 PM CEST, Danilo Krummrich wrote:
> The driver model defines the lifetime of the private data stored in (and
> owned by) a bus device to be valid from when the driver is bound to a
> device (i.e. from successful probe()) until the driver is unbound from
> the device.
>
> This is already taken care of by the Rust implementation of the driver
> model. However, we still ask drivers to return a Result<Pin<KBox<Self>>>
> from probe().
>
> Unlike in C, where we do not have the concept of initializers, but
> rather deal with uninitialized memory, drivers can just return an
> impl PinInit<Self, Error> instead.
>
> This contributed to more clarity to the fact that a driver returns it's
> device private data in probe() and the Rust driver model owns the data,
> manages the lifetime and - considering the lifetime - provides (safe)
> accessors for the driver.
>
> Hence, let probe() functions return an impl PinInit<Self, Error> instead
> of Result<Pin<KBox<Self>>>.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Applied to driver-core-testing, thanks!

