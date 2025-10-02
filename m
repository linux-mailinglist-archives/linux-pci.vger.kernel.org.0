Return-Path: <linux-pci+bounces-37419-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D53BB3DA5
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 14:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804CA1C7912
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 12:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415552F4A12;
	Thu,  2 Oct 2025 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ov2s+3Ra"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1652B211472;
	Thu,  2 Oct 2025 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759406914; cv=none; b=p+xx/YSuCCmTlyXe8nWTfa8A788uNNlM6StKkywuvFkYU1S2JnbxdZjjDfSmTwJ+sSqXNykK4zGa6hiKsyzaFlsUc0BdbLS1gsXEJomWgRzS7hWc7dxrNyJEM0SCjQ+FZkkBO/49iMM784P0t5kzNFiZf+mudBE8YITxKx5kLMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759406914; c=relaxed/simple;
	bh=tb+QlM/Ac5Zz+ol4V4q9n2Sx0VeZEGrctLpsPyzSZ/k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Qi+J0dP6/lEWeEQ+2beV66X1fq1IqFeUfxrGNbZzidjpOV8uBVODVPZ7ZkyN8QcWYsyHw1klfuMXQRRaQ2h8mICSsiEY/XPcegb3ryH6XxhcKwmQSvyv8NM7WmCVpGeSFIN0hjyF8qNRGEh9D5ZxCUcDtiFrk5NYTGSAQSSJgx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ov2s+3Ra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A725C4CEF4;
	Thu,  2 Oct 2025 12:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759406913;
	bh=tb+QlM/Ac5Zz+ol4V4q9n2Sx0VeZEGrctLpsPyzSZ/k=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Ov2s+3RamDIsz558ZwAxKFI3wxtJ6RcDcvlPFYTiGQ9OOT7N5Wwed8fMa9Cs4mKIg
	 vdxvGbGnfFaaj1e0SqgftZikY1SH02xYLw5hG0Gb9siGYXDif56X0aoAUfWkKz02Z7
	 VTX2wo8znoNbJKCxfwrP24wiSk341/53Ged48CEbYFnKgH9s5t1LULBiMKF2fu6C31
	 07cqIRRu+z21E/iFXFxjTMRNNBGSA65XB6whdQf7x4Yts4HkxLIHDVhy8HmaZv7x/B
	 5XvOsA76/buhEn3u0OkqePQt7yiE+6y71o0y9IBJHmUMd/HNcF7bHbJ+U5xmoDGLIp
	 SDyeKIaiS0YFw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Oct 2025 14:08:27 +0200
Message-Id: <DD7TP31FEE92.2E0AKAHUOHVVF@kernel.org>
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Surath Mitra" <smitra@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "nouveau@lists.freedesktop.org"
 <nouveau@lists.freedesktop.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>,
 "Alex Williamson" <alex.williamson@redhat.com>
To: "Jason Gunthorpe" <jgg@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <h6jdcfhhf3wuiwwj3bmqp5ohvy7il6sfyp6iufovdswgoz7vul@gjindki2pyeh>
 <e77bbcda-35a3-4ec6-ac24-316ab34a201a@nvidia.com>
 <DD6X0PXA0VAO.101O3FEAHJUH9@kernel.org>
 <f145fd29-e039-4621-b499-17ab55572ea4@nvidia.com>
 <ae48fad0-d40e-4142-87d0-8205abdf42d6@nvidia.com>
 <DD7CREVYE5L7.2FALGBC35L8CN@kernel.org>
 <20251002120149.GC3195801@nvidia.com>
In-Reply-To: <20251002120149.GC3195801@nvidia.com>

On Thu Oct 2, 2025 at 2:01 PM CEST, Jason Gunthorpe wrote:
> On Thu, Oct 02, 2025 at 12:52:10AM +0200, Danilo Krummrich wrote:
>
>> Indicating whether the driver supports VFs through a boolean in struct
>> pci_driver is about the same effort (well, maybe slightly more), but sol=
ves the
>> problem in a cleaner way since it avoids probe() being called in the fir=
st
>> place. Other existing drivers benefit from that as well.
>
> I'm strongly against that idea.
>
> Drivers should not be doing things like this, giving them core code
> helpers to do something they should not do is the wrong direction.
>
> I think this patchset should be simply dropped. Novacore should try to
> boot on a VF and fail if it isn't setup.

Why? What about other upstream drivers that clearly assert that they don't
support VFs? Why would we want to force them to try to boot to a point wher=
e
they "naturally" fail?

I think there's nothing wrong with allowing drivers to "officially" assert =
that
they're intended for PFs only.

Here are a few examples of drivers that have the same requirement:

https://elixir.bootlin.com/linux/v6.17/source/drivers/net/ethernet/realtek/=
rtase/rtase_main.c#L2195
https://elixir.bootlin.com/linux/v6.17/source/drivers/net/ethernet/intel/ic=
e/ice_main.c#L5266
https://elixir.bootlin.com/linux/v6.17/source/drivers/net/ethernet/intel/ig=
b/igb_main.c#L3221

