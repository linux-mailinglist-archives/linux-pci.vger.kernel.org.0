Return-Path: <linux-pci+bounces-39711-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF33C1CB3C
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 19:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EBB94E026D
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 18:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451332E093B;
	Wed, 29 Oct 2025 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0pR2af2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D0F30F804;
	Wed, 29 Oct 2025 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761761434; cv=none; b=Uy4HwYdeSfY4mnjlAbnwHD7Ws2HHeFtJzEDOnjf7wSzwLqr4UMgJG77EuUkYkQaR/juX5Bub4oOSxMuEvN5NwHqrZK+HBlGSZcKzcGvigqzH3YIqytlFLFhKl3///VKuZ6AWEFxesAU36xWoII22gBGHXCyvHg4lXrGK9z/wezM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761761434; c=relaxed/simple;
	bh=74+OE1xL32AvuQq0dCzthnLOebJGx9aO7I8+OqhTme8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=SHci+uf1LdHZI9mIewMNgU0phuzxkuut1oyHSw3TFXSTw3vFsx+AfH8W8eGU8wjceioFt5jHeeniavSEJ5s9n8O2XfLbA5QxmV5AQSMam5pQJqDJ5ZjJsFR+YLxZ9kzBaxGkJ3VxqvFi5w7q6ecI5oQ3MIKYagECvNzE6xeiIF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0pR2af2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC30EC4CEF7;
	Wed, 29 Oct 2025 18:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761761433;
	bh=74+OE1xL32AvuQq0dCzthnLOebJGx9aO7I8+OqhTme8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=l0pR2af2+eTNjUNeK/+V70j4UcNIyzTxBB6UzatnxTQxP3m5FLTvcRUwFT7Ctg9Fu
	 CwWeH1YHUai8aC6GF76VT1dC1l3ZiY1FC7C5dXvcUjivP4xkb7GiCyRRDjRGyVkpEk
	 4IGn8beCrZuxOoCoQI2zVR8+QvGqQrcM753kMIEwgyEJ12pECqu9QK/r6+JyPrGQhb
	 U6xGVGE3PVLYoh/SaJHTT+CLU7opohH4jvtoUR0vU5+PNcoZpLF/AEQAMrqzqKjuc3
	 nRa//LA4UsHIWZFwgx2iprmGnuUZfItHocV5Lse9k+ioEJRj/wXy7LglfgBLdSbMnf
	 Moieps/F1a+cw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 19:10:27 +0100
Message-Id: <DDV0AYWXTCL5.2QDTJI55Q87CJ@kernel.org>
Subject: Re: [PATCH 0/8] Device::drvdata() and driver/driver interaction
 (auxiliary)
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <acourbot@nvidia.com>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <pcolberg@redhat.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251020223516.241050-1-dakr@kernel.org>
In-Reply-To: <20251020223516.241050-1-dakr@kernel.org>

On Tue Oct 21, 2025 at 12:34 AM CEST, Danilo Krummrich wrote:

Applied to driver-core-testing, thanks!

> Danilo Krummrich (8):
>   rust: device: narrow the generic of drvdata_obtain()
>   rust: device: introduce Device::drvdata()

    [ * Remove unnecessary `const _: ()` block,
      * rename type_id_{store,match}() to {set,match}_type_id(),
      * assert size_of::<bindings::driver_type>() >=3D size_of::<TypeId>(),
      * add missing check in case Device::drvdata() is called from probe().

      - Danilo ]

>   rust: auxiliary: consider auxiliary devices always have a parent
>   rust: auxiliary: unregister on parent device unbind
>   rust: auxiliary: move parent() to impl Device
>   rust: auxiliary: implement parent() for Device<Bound>
>   samples: rust: auxiliary: misc cleanup of ParentDriver::connect()
>   samples: rust: auxiliary: illustrate driver interaction

