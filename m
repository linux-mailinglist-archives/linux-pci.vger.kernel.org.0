Return-Path: <linux-pci+bounces-25808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4058BA87DB6
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 12:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A0B9166E33
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 10:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBDE25FA04;
	Mon, 14 Apr 2025 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Nwua8V1o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDA31EDA23;
	Mon, 14 Apr 2025 10:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744626714; cv=none; b=mOsiJrNBW9kLE6WQUoPerTKqhA8UyVMHEwIs8Tj45osq0cJbYylBNQk33Hq3lT2b2VXqMZg4vt0H8w26UAptuxIeXi/zKUrSU37euvEnMy7Wi4EX32Ipl62HPAhBmyszVaHp026g/U2jT0w7On195iF/msOQyXcRFygkokJj/tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744626714; c=relaxed/simple;
	bh=z2CPQKaifHCbxrA739xLlWAzMBkWsSFBp46KVVoc5V8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RyLaEoT71R+UnSunD2BFsZpEMCNOpQRgNoMDPIi4W3UpsIQhk6pkpiLeVi3G6O8Dzy039QLLpvTj/uiRIBNbSsIvmMWgF3UtTcH+NbGmLa7pJmHuT2p7NkZVgjoSz1r/frmV3twBXjw2YUJ2l5UiZDt6Fc/0DBKhOc8GYGXBQ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Nwua8V1o; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=vamy2jqjoffkzedwrb3wcvl4xa.protonmail; t=1744626700; x=1744885900;
	bh=2T8vJxrpGMvxIuesoiOOyPD7ELpi2BLG5P0TH8fNKtA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Nwua8V1obNeR6iF5TkYpyJmNK4ThQlyz02BDb66m7zF8FtSgw2TEYvmVG3VMlBVxi
	 X2zPQDO3KYN5H4aypVCKWhcLZb/iUpiNgcCc7qPM6u2GT2ta/KSdoaz0KN15uw+AmR
	 ZLXY4Wi+rVkFuR8F1URzFETB7drjXLqySSALcATHU46I/ddIUMvyy7kqTtdFM7UZiv
	 sBuRBQjaLJU+k6BktiP9dIpl1JFHMhApz6SX7fg1t9Up1k0QmXcKi6K329PDuF/W0L
	 UnX19SrYJ3uAkQa3Kkb4AWmI2S77wIZC+Xwv3GaYTx90WraK6LM5nam8nFRbSMIuXV
	 tMGBkLYbjs6nA==
Date: Mon, 14 Apr 2025 10:31:34 +0000
To: Danilo Krummrich <dakr@kernel.org>, bhelgaas@google.com, kwilczynski@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, abdiel.janulgue@gmail.com
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, daniel.almeida@collabora.com, robin.murphy@arm.com, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/9] rust: device: implement device context for Device
Message-ID: <D96AJO1BOHEN.BJEQMT8XJM9Q@proton.me>
In-Reply-To: <20250413173758.12068-4-dakr@kernel.org>
References: <20250413173758.12068-1-dakr@kernel.org> <20250413173758.12068-4-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 1df1d556c34ab263f486366dde7b3761731009ef
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Apr 13, 2025 at 7:36 PM CEST, Danilo Krummrich wrote:
> Analogous to bus specific device, implement the DeviceContext generic
> for generic devices.
>
> This is used for APIs that work with generic devices (such as Devres) to
> evaluate the device' context.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/device.rs | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)


