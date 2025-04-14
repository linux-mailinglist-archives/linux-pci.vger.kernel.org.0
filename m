Return-Path: <linux-pci+bounces-25820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC84FA87ECC
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 13:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9341897F2F
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 11:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7077729B20B;
	Mon, 14 Apr 2025 11:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYSSq104"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B2629AAF5;
	Mon, 14 Apr 2025 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744629223; cv=none; b=CQxEEU0bLzElx+MZNum33l/8CbkmJNrdaLipBnL/3HFcwcS0bHfp5PNbU0Rcax4WqaHILC4pJwyFMiXRzHZ1WZmAc87O+exjSDgkJi9GzkjiIc2eRwc/YDK+vKXLhAcHZvpiZ6MX2ZTnKtMXZpTKtlZOkA1T863DLJblw6+Kb1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744629223; c=relaxed/simple;
	bh=Aq4OcUKUPQ19rvzBQ0WRaerK10y7gvrVPolRkIzhBxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhiF1Tci+Bmi2Xqdr0WyPDcvJqMv1XHTPgT4exShbeGBPRv3zIosGg7rSPB69Pp4ppiguHu/sBz+uYJ7O1zuBQ52Vu8ELNrTUnlQncs/ib9z4WsrKOK2Q3R+KDacu7Hxyda62Pl+jF07NAayOzndGWGkZ2P14GXdPgiTmxLNPCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYSSq104; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031A9C4AF1D;
	Mon, 14 Apr 2025 11:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744629222;
	bh=Aq4OcUKUPQ19rvzBQ0WRaerK10y7gvrVPolRkIzhBxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NYSSq1044ITBBP6nti0xu62gUMy0Pn3fvS+LkJuWNXEJIBQwvD/vY6vEtSqhmgtWf
	 rV2usU0Fp/hAa5pOubaJXFX/n2Ss9RLLx8rmEywbNr0NL37TbF6mTAyJe/Z5uUX5L9
	 +cAN5dEMSIgQcAqgHWKSEPQlcsx57WrLC6nl/fBIG0LFxC+EvDxQRSvqIR8xjPkhHO
	 wg4WebUih2JmI5z/7WXdJU54QvfwjnTRjC+TiWa+TrE2aL23ovCZH0JzfY0mFDzjiY
	 f+rmlF4ZN8Lk6YAfCxZx+Bn3KO2umggrhgf2dfaKfgSyAF/CSPiPhiOzND/tL8Ck7t
	 JrkEcyM8a6hZw==
Date: Mon, 14 Apr 2025 13:13:36 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: bhelgaas@google.com, kwilczynski@kernel.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, abdiel.janulgue@gmail.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu,
	daniel.almeida@collabora.com, robin.murphy@arm.com,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] rust: device: implement Bound device context
Message-ID: <Z_zt4Cfmn_gWnMot@pollux>
References: <20250413173758.12068-1-dakr@kernel.org>
 <20250413173758.12068-7-dakr@kernel.org>
 <D96ATODOGB6O.2JAJOWXMJG3VC@proton.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D96ATODOGB6O.2JAJOWXMJG3VC@proton.me>

On Mon, Apr 14, 2025 at 10:44:35AM +0000, Benno Lossin wrote:
> On Sun Apr 13, 2025 at 7:37 PM CEST, Danilo Krummrich wrote:
> 
> > +            $device,
> > +            $crate::device::Bound => $crate::device::Normal
> 
> IIUC, all "devices" (so eg `pci::Device`) will use this macro, right? In
> that case, I think we can document this behavior a bit better, possibly
> on the `DeviceContext` context trait and/or on the different type
> states. So on `Core` we could say "The `Core` context is a supercontext
> of the [`Bound`] context and devices also expose operations available in
> that context while in `Core`." and similarly on `Bound` with `Normal`.

Fully agree, I absolutely want to have this documented. I wasn't yet sure where
I want to document this though. device::DeviceContext seems to be a reasonable
place.

Besides that, I think I also want to rename it to device::Context, not sure if
it's worth though.

I will send a subsequent patch for the documentation on DeviceContext.

