Return-Path: <linux-pci+bounces-30901-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05328AEB1E1
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 11:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F4EB17192A
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 09:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4A228C03B;
	Fri, 27 Jun 2025 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmwFgQ2C"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D890228C036;
	Fri, 27 Jun 2025 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751014923; cv=none; b=MbRiUJALDkA2N1LVwbji4Lol9uQ8oFNznFSjgUawW8b8HZIKACbv/Fa1dfFPr6xmhqAVa9leyjsDQn3C3UfD2WnoXCUjtWZUlW+/LXw6ImyTQb8yMk0+uztOAcNIxqhNcZl1W4dfNALnW9lLcaKo7Vw4zR7yid6ruSJxfZ87MmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751014923; c=relaxed/simple;
	bh=f3aVQTD1fvHDoFJz6BYUdn4YpiDHzFeLA+PwQobS9bc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=In4pRL9/cDvZ8jkS1XLEsOszOjxwicXt8/ii/iz/0+l5uvTOigB5bQn0bm2TZcHcWlPJQbRWJUBwV+1P16bRNJyVIiQ3K1zNq029tNZRsY/OudCytNOUAitnDrwe6hitzcfc+L1RZ7gZOCtASgS8v+coL7l/2DKvjewzOhhbfng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmwFgQ2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A903AC4CEEB;
	Fri, 27 Jun 2025 09:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751014923;
	bh=f3aVQTD1fvHDoFJz6BYUdn4YpiDHzFeLA+PwQobS9bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NmwFgQ2CZcpvV0ROnSPtemkMq+ettLDih5Q9iYDyajNBRYh+W7hwf8ahthkAsqTz7
	 nc/eL9y9NGTCDC8Ik9DSrmA0O0vIKztETv6P3NoFWQKusVBpdPuuAZNgLBlJIbS7No
	 3HHeQSC6zcB6hk9U/fIRaRcNuAmW+mz8YcpjG9mR8vcnXQiHSTv+6PPzDGmQXADQN6
	 s16fcHTo1N5Uyfi6tBOMLKIiNM2fINPBwnalu81M4LCE1VuBou/+8yf5TmCrq+tLkX
	 8fwM8Dl5ZAXI5FMkw30KVtcq/0Ghj2Wrb0U8VDvhA8lm2aATc5zwpJzGZGfMsLDPHF
	 IGwWuZKC80KCA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Jun 2025 11:01:58 +0200
Message-Id: <DAX6ZGG442EA.2C365WV15IC7C@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <kwilczynski@kernel.org>,
 <bhelgaas@google.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] rust: devres: get rid of Devres' inner Arc
X-Mailer: aerc 0.20.1
References: <20250626200054.243480-1-dakr@kernel.org>
 <20250626200054.243480-4-dakr@kernel.org>
 <DAWUWCQCW7WD.29U1POJFXTLXS@kernel.org> <aF3dlfLiy8w4henN@pollux>
In-Reply-To: <aF3dlfLiy8w4henN@pollux>

On Fri Jun 27, 2025 at 1:53 AM CEST, Danilo Krummrich wrote:
> On Fri, Jun 27, 2025 at 01:33:41AM +0200, Benno Lossin wrote:
>> On Thu Jun 26, 2025 at 10:00 PM CEST, Danilo Krummrich wrote:
>> > diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.=
rs
>> > index 60b86f370284..47653c14838b 100644
>> > --- a/drivers/gpu/nova-core/gpu.rs
>> > +++ b/drivers/gpu/nova-core/gpu.rs
>>=20
>> > @@ -161,14 +161,14 @@ fn new(bar: &Bar0) -> Result<Spec> {
>> >  pub(crate) struct Gpu {
>> >      spec: Spec,
>> >      /// MMIO mapping of PCI BAR 0
>> > -    bar: Devres<Bar0>,
>> > +    bar: Arc<Devres<Bar0>>,
>>=20
>> Can't you store it inline, given that you return an `impl PinInit<Self>`
>> below?
>
> I could, but I already know that we'll have to share bar later on.

Ahh, planning ahead :)

How would you have shared it if you didn't do the devres rework? Or is
this one of the reasons to do that?

>> >      fw: Firmware,
>> >  }
>> > =20
>> >  impl Gpu {
>> >      pub(crate) fn new(
>> >          pdev: &pci::Device<device::Bound>,
>> > -        devres_bar: Devres<Bar0>,
>> > +        devres_bar: Arc<Devres<Bar0>>,
>> >      ) -> Result<impl PinInit<Self>> {
>>=20
>> While I see this code, is it really necessary to return `Result`
>> wrapping the initializer here? I think it's probably better to return
>> `impl PinInit<Self, Error>` instead. (of course in a different patch/an
>> issue)
>
> I will double check, but it's rather unlikely it makes sense. There's a l=
ot of
> initialization going on in Gpu::new(), the try_pin_init! call would proba=
bly get
> too crazy.

Makes sense, I don't have too much data on where to place the error,
since I only have had rather simple uses of pin-init. So you could have
a case where it makes sense to put the error outside of the initializer.

>> >  /// # Example
>> >  ///
>> >  /// ```no_run
>>=20
>> > @@ -213,44 +233,63 @@ pub fn new(dev: &Device<Bound>, data: T, flags: =
Flags) -> Result<Self> {
>> >      /// }
>> >      /// ```
>> >      pub fn access<'a>(&'a self, dev: &'a Device<Bound>) -> Result<&'a=
 T> {
>> > -        if self.0.dev.as_raw() !=3D dev.as_raw() {
>> > +        if self.dev.as_raw() !=3D dev.as_raw() {
>> >              return Err(EINVAL);
>> >          }
>> > =20
>> >          // SAFETY: `dev` being the same device as the device this `De=
vres` has been created for
>> > -        // proves that `self.0.data` hasn't been revoked and is guara=
nteed to not be revoked as
>> > -        // long as `dev` lives; `dev` lives at least as long as `self=
`.
>> > -        Ok(unsafe { self.0.data.access() })
>> > +        // proves that `self.data` hasn't been revoked and is guarant=
eed to not be revoked as long
>> > +        // as `dev` lives; `dev` lives at least as long as `self`.
>>=20
>> What if the device has been unbound and a new device has been allocated
>> in the exact same memory?
>
> Unbound doesn't mean freed. Devres holds a reference of the device is was
> created with, so it is impossible that it has been freed.

Ahh right, I thought I was missing something! This also should be
mentioned in the safety comment though! Feel free to do it in some later
patch or create a good-first-issue :)

---
Cheers,
Benno

