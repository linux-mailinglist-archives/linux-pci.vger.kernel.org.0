Return-Path: <linux-pci+bounces-30322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA15AE31F1
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 22:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA4C16D1C4
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 20:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80FB19F111;
	Sun, 22 Jun 2025 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQ4Tho1C"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA81823BE;
	Sun, 22 Jun 2025 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750623928; cv=none; b=JVR7vqu2hxWMWh9TSk6672BLCWhT8WX2tJkwoWFRbJb6+ExfqP2HEzwDpVtwWH6nQGKtCxUcNEWpn2mZZW2OEbLZNoPJgxUcKa5/2lYy+Bcr8E6CMSn49pOc7RaFGj7QaTyBQNAPl/oqmIzkVnWXk/vCx7IHpUFj14lkqpbawxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750623928; c=relaxed/simple;
	bh=cUNFPVL2U8mVJ0hDVfYgQe5XcqjJP1OfaLKOocM7dnk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=OoJYB4w1IGevk3DbzqtGbel0nBDeMK22Lg8oQW3xfeKDsEl+2FdQfpxA3tTJrIm4Wn49HhYaRncZEclwMk8YPILOW3WxH85J6e2Ht2iSOBCPdjUXF5Nz+lOpPmVQklBk2eKqodFp0k/4naQnzSW9mxgdtWJs8/K/T3jqJhflxyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQ4Tho1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D86AC4CEE3;
	Sun, 22 Jun 2025 20:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750623928;
	bh=cUNFPVL2U8mVJ0hDVfYgQe5XcqjJP1OfaLKOocM7dnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQ4Tho1Cl/g4ArVW1SZx+KGA1G6UvhYXvY8svBiKdkJcgwG6SkulS0basvIGUySvy
	 KE9iT4ur7vZzRwy14njgTqbgCm/VldBcW3Opoks7HykF3rqePcjrV0rk+wubGPti2E
	 dbIRlvIGzMv5uR7JR3XS4S4FfyT74KOq6rMVqYY4J0D+Y34dBM0hBT4BQkEoZM+FmB
	 GXJj2V1inf0k44r9XIBs3515YrgYCE/8lCw+7d4ZTRi8Ikl3gFw48bdR6uc2tDtSQM
	 ekd8Xz7bDzRF8ItDn+5J/OgjlmNvJpuO2oSieIE9R5h/jnOC3Q0KAozMSieP7i85M6
	 dh4xyozUjFFbA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 22 Jun 2025 22:25:22 +0200
Message-Id: <DATCDZGA43LE.2EZS3N8MXUCD9@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <kwilczynski@kernel.org>, <bhelgaas@google.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, "Dave Airlie" <airlied@redhat.com>, "Simona
 Vetter" <simona.vetter@ffwll.ch>, "Viresh Kumar" <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 2/4] rust: devres: replace
 Devres::new_foreign_owned()
X-Mailer: aerc 0.20.1
References: <20250622164050.20358-1-dakr@kernel.org>
 <20250622164050.20358-3-dakr@kernel.org>
In-Reply-To: <20250622164050.20358-3-dakr@kernel.org>

On Sun Jun 22, 2025 at 6:40 PM CEST, Danilo Krummrich wrote:
> Replace Devres::new_foreign_owned() with devres::register().
>
> The current implementation of Devres::new_foreign_owned() creates a full
> Devres container instance, including the internal Revocable and
> completion.
>
> However, none of that is necessary for the intended use of giving full
> ownership of an object to devres and getting it dropped once the given
> device is unbound.
>
> Hence, implement devres::register(), which is limited to consume the
> given data, wrap it in a KBox and drop the KBox once the given device is
> unbound, without any other synchronization.
>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Simona Vetter <simona.vetter@ffwll.ch>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

>  rust/helpers/device.c     |  7 ++++
>  rust/kernel/cpufreq.rs    | 11 +++---
>  rust/kernel/devres.rs     | 70 +++++++++++++++++++++++++++++++++------
>  rust/kernel/drm/driver.rs | 14 ++++----
>  4 files changed, 82 insertions(+), 20 deletions(-)

