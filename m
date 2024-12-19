Return-Path: <linux-pci+bounces-18767-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C969F79DD
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 11:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B0B168ACB
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 10:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE2A22257F;
	Thu, 19 Dec 2024 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+lmQdU2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69706222566;
	Thu, 19 Dec 2024 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734605601; cv=none; b=OI2zqnIsgVpmDq7FK891+pKb/99XXE20w5AjESium8PkEgWhnCEZ8D26zqOU4h3yP9+5NA9tLVlp+OKwtPIbi1T6R7aT2XyB4HXJ0aN9ORSIBkDRqJnvaB4iRBMjQIKPShg5qLJT3KBPGRS6fo7Sm1T3xhjP80xIKr6hEkFChV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734605601; c=relaxed/simple;
	bh=RpuYyr3iEI9pJoKS8TGxrFFOZ8RRcoKwdnKtdEJS7oo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nX/h9FDetJmZyTl4RdZd0DPNfIHlJUIW2/p2ntYMbjZ6Yiql7eEb8aBEdCdGP8wTeU32yWC+nJQtalPGDeUWyyCrs08g5n6KVrLWM4p9ipx96VZg2sux7+vhDaMDQ/POoLvdp+5juKt6Ebe+l/FqRlWwMPaKGF5daaDSqCEX2lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+lmQdU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209F1C4CED0;
	Thu, 19 Dec 2024 10:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734605601;
	bh=RpuYyr3iEI9pJoKS8TGxrFFOZ8RRcoKwdnKtdEJS7oo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=f+lmQdU26+HCxPMf/l7I9BtP0ocP4GNnvWw5cF0TS9JeqY1fMK3mVW2D40SZTJMxl
	 AVODtVJRkw0Slzi/7tmqMdmYortm+Us48c62APa8KinkZtv/tJ7Gi7FRCUvTovigPp
	 2PA1pFaLCg4FenTAHiTVtaGRMwB9TOOhyzwfFoYE435hwimFA7oJjqAjHmrtc5SCPe
	 29xPVCxBXVge9n3W3Jnq4BFDTUa1ms7rJGADEeO8NkLTFp/oisgkl0tMpCOIi+f3Mc
	 cs6Vqmy8j+1fvBC74CTbmGJTd6Qo8JcCCTYpXeQ0H1KS5zOPi+czn9gWb09jkT2MYG
	 17MF4MwySy55w==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org,  rafael@kernel.org,  bhelgaas@google.com,
  ojeda@kernel.org,  alex.gaynor@gmail.com,  boqun.feng@gmail.com,
  gary@garyguo.net,  bjorn3_gh@protonmail.com,  benno.lossin@proton.me,
  tmgross@umich.edu,  a.hindborg@samsung.com,  aliceryhl@google.com,
  airlied@gmail.com,  fujita.tomonori@gmail.com,  lina@asahilina.net,
  pstanner@redhat.com,  ajanulgu@redhat.com,  lyude@redhat.com,
  robh@kernel.org,  daniel.almeida@collabora.com,  saravanak@google.com,
  dirk.behme@de.bosch.com,  j@jannau.net,  fabien.parent@linaro.org,
  chrisi.schrefl@gmail.com,  paulmck@kernel.org,
  rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-pci@vger.kernel.org,  devicetree@vger.kernel.org,
  rcu@vger.kernel.org
Subject: Re: [PATCH v6 13/16] rust: driver: implement `Adapter`
In-Reply-To: <20241212163357.35934-14-dakr@kernel.org> (Danilo Krummrich's
	message of "Thu, 12 Dec 2024 17:33:44 +0100")
References: <20241212163357.35934-1-dakr@kernel.org>
	<20241212163357.35934-14-dakr@kernel.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 19 Dec 2024 11:53:06 +0100
Message-ID: <87r064kkq5.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Danilo,

Danilo Krummrich <dakr@kernel.org> writes:

> In order to not duplicate code in bus specific implementations (e.g.
> platform), implement a generic `driver::Adapter` to represent the
> connection of matched drivers and devices.
>
> Bus specific `Adapter` implementations can simply implement this trait
> to inherit generic functionality, such as matching OF or ACPI device IDs
> and ID table entries.
>
> Suggested-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---

I get some warnings when applying this patch:

>   RUSTC L rust/kernel.o
> warning: unused import: `device_id`
>   --> /home/aeh/src/linux-rust/rnvme-v6.13-rc3/rust/kernel/driver.rs:10:13
>    |
> 10 |     device, device_id, init::PinInit, of, str::CStr, try_pin_init, types::Opaque, ThisModule,
>    |             ^^^^^^^^^
>    |
>    = note: `#[warn(unused_imports)]` on by default
> 
> warning: missing documentation for an associated function
>    --> /home/aeh/src/linux-rust/rnvme-v6.13-rc3/rust/kernel/driver.rs:158:5
>     |
> 158 |     fn of_id_info(_dev: &device::Device) -> Option<&'static Self::IdInfo> {
>     |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     |
>     = note: requested on the command line with `-W missing-docs`
> 
> warning: 2 warnings emitted


Looks like the latter one is from patch 13.


Best regards,
Andreas Hindborg



