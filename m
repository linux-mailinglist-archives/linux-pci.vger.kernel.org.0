Return-Path: <linux-pci+bounces-30718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5275DAE9B66
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 072417B5EF6
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 10:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142FC26D4C4;
	Thu, 26 Jun 2025 10:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmOV8x9j"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE89325CC7C;
	Thu, 26 Jun 2025 10:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933644; cv=none; b=fa4QLAr1nAUvyTzrrgob+VvlboSnpHkscnk3Fwy3D7Zs7iCkQhr1ZbR29oSu7q4h9vKrfGbC07dDi1ndpaCB3DjroeUsCLHCY899L7tTHu0ZmUIZ7So7lWZThvMaD5xQ8y0I4K8G4QXFow57Le5QG39T9U1vjktZA6OWI6KeP6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933644; c=relaxed/simple;
	bh=p8rBo1Y5Lr+NfYKS+dwWCGs6na8FSui3ve5k7KPDi08=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Mwi+semrzjtQVgQzI0Rscl0b25Aj+zPoXolDMkAnXBKq9905g7MqCqqvnDMzAQsRP58NAP7vUUZlidg+LL80jFA0Wp+yVrq0Zl/RPnjtOARxFSke4hTsaSwY/NSliTGJN4lSzQtrrn4VMhvO4/Lk4JaJmU0y2DYoBIZaSfAk1s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmOV8x9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B035C4CEF4;
	Thu, 26 Jun 2025 10:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750933643;
	bh=p8rBo1Y5Lr+NfYKS+dwWCGs6na8FSui3ve5k7KPDi08=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=pmOV8x9jxpQmesCFhUrzfIZ9xHdzYhnUDhm1qETxFu4Zq2qvZtqrpt4z6KlyJsldZ
	 JGUBnmF4bBGXN0zXTz67Jwb/T/qV9D7w7hfzaohTms6x5GgNqXQhHeHt1fU9FuwZtO
	 xEB6JB8JBIeb/F/D0BDP6nEVKpBpeg2BVWXVP8C1Z5nURvkeqtguzLBLrJlGLW77s2
	 T9W/nxOx1cpYbxI1TTL2wWYid9DFC+JTsqGtBibu887+o0Tp3GX/gIhPtRFJmQY8g2
	 dR8uBamPizT/ZgCcAZsRDoMedJ6wajSCwFiXDMqVK3OTXINRXEK4iyEzaBq2lpYI6U
	 P5YAsSDdOH1tg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Jun 2025 12:27:18 +0200
Message-Id: <DAWE690DWP9A.10I5FIJSZDSR6@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <kwilczynski@kernel.org>, <bhelgaas@google.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] rust: devres: get rid of Devres' inner Arc
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>, "Boqun Feng"
 <boqun.feng@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250624215600.221167-1-dakr@kernel.org>
 <20250624215600.221167-4-dakr@kernel.org> <aFzI5L__OcB9hqdG@Mac.home>
 <aF0aiHhCuHjLFIij@pollux>
In-Reply-To: <aF0aiHhCuHjLFIij@pollux>

On Thu Jun 26, 2025 at 12:01 PM CEST, Danilo Krummrich wrote:
> On Wed, Jun 25, 2025 at 09:13:24PM -0700, Boqun Feng wrote:
>> On Tue, Jun 24, 2025 at 11:54:01PM +0200, Danilo Krummrich wrote:
>> [...]
>> > +#[pin_data(PinnedDrop)]
>> > +pub struct Devres<T> {
>>=20
>> It makes me realize: I think we need to make `T` being `Send`? Because
>> the devm callback can happen on a different thread other than
>> `Devres::new()` and the callback may drop `T` because of revoke(), so we
>> are essientially sending `T`. Alternatively we can make `Devres::new()`
>> and its friend require `T` being `Send`.
>>=20
>> If it's true, we need a separate patch that "Fixes" this.
>
> Indeed, that needs a fix.

Oh and we have no `'static` bound on `T` either... We should require
that as well.

---
Cheers,
Benno

