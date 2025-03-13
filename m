Return-Path: <linux-pci+bounces-23599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF80A5F138
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 11:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999E0188EE9A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 10:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056F61EF097;
	Thu, 13 Mar 2025 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="UL6imIxJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677912E3395
	for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862849; cv=none; b=TWxalA0ludttil8+ZOeHnPCuXnWxqZmJnkxz7uSuvgJregRos8fVly4vsDCXlMDSrtro3rrxPcmqtmeT0fkD/r1j+tV/7/7VS2LSwtj0JeGF9YRnaftdhBw3fSAdK23898zkaHxzWJxD2uY7WDS4zKJ1J2ZpawfU+Fas3+FJsJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862849; c=relaxed/simple;
	bh=SLtSkwQWPnJ1tyVbpdjnonfobNcOyU3hfgLkBFlubkI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ptPGAp5jIbzPPZ+NaWZQfEbgw/xH+XulcL6pEk3Gkq7/Tn5HVSe0/sz6MXsSyV9FpM++Qw9ZzzIUs2Sl9aYjODyYnT8B4KXA9uuumheIyPJXBZNftq3RPLYiLYXjEijcWASAnLLhgi932Bz96xpovydxsNt4OOYrpQZV/y7UMYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=UL6imIxJ; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741862846; x=1742122046;
	bh=SLtSkwQWPnJ1tyVbpdjnonfobNcOyU3hfgLkBFlubkI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=UL6imIxJd1w74nezCNjUzn+aVXKwa9DUIXDvEKAChU9JunuWFpnxMhJjJi83w3goC
	 eCKYzqE0ESAOqqsXXeB9bqHxdU2zL2leCgAe6z8g4O6Avgy9rkFxJOZBMd6Yj1DPLM
	 nOyP2dbMc5HUBip3vaTN5cfFYJL746PghulqNyOykl4eC5Uvzy6KauesZ5csicXIVS
	 QHeLK4pNyUrhnZWrlTKH+4KEc7S5r/S4Smai08cDfg3eFespWWMWlyqHgN6JflboZi
	 PZpOYbg6lm7T383AyCX5D+mUiZsblKDwRsSztttyTfZonTJ5dfpWLUDZg2Vvk5UjGa
	 HrEAARE9Rs3rA==
Date: Thu, 13 Mar 2025 10:47:20 +0000
To: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] rust: device: implement device context marker
Message-ID: <D8F2UB2ZTHOE.JHFXN7W2YEQT@proton.me>
In-Reply-To: <D8F2GQ4WYT7Z.172Z7R7V8BIGR@proton.me>
References: <20250313021550.133041-1-dakr@kernel.org> <20250313021550.133041-3-dakr@kernel.org> <D8F2GQ4WYT7Z.172Z7R7V8BIGR@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 2db073f845423795e7d127fdace01111c6fee6c0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 13, 2025 at 11:29 AM CET, Benno Lossin wrote:
> On Thu Mar 13, 2025 at 3:13 AM CET, Danilo Krummrich wrote:
>> Some bus device functions should only be called from bus callbacks,
>> such as probe(), remove(), resume(), suspend(), etc.
>>
>> To ensure this add device context marker structs, that can be used as
>> generics for bus device implementations.
>>
>> Suggested-by: Benno Lossin <benno.lossin@proton.me>
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>
> I would have folded this into #3, but if you prefer it being split, then
> it's also fine.

Ah I didn't look at patch #4, then I would also keep this separate.

---
Cheers,
Benno


