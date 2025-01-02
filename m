Return-Path: <linux-pci+bounces-19152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FD09FF798
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 10:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EEE016124D
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 09:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A8B190059;
	Thu,  2 Jan 2025 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gR1z6jgF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A6C189B9C;
	Thu,  2 Jan 2025 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735811070; cv=none; b=jp5V42ks9gt2x86bJkBtpCJLYeGrOB4IIFKgXeHyUFDCbP7vUh8++fzIZs7vpC5YyVxVHJZ/ysiMYrgNsiIMeB6pZPeVqhXqoAnMH7+vsuFn6dHfIb9DCF6KkPmzAEVR0PpNFXToS/4u7FpRxKaRCSxCW1wVMF3lQCTBATNU+d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735811070; c=relaxed/simple;
	bh=hxWnEH8xQveHUbVj8BZY+CdgkxEOLd5OTlXgJppqR7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYM44G7WD/j+bX7mjBi0hc1VEi2j6nhBSAL9N+fBep4OmQP3RPR2PPJdVk6hpuSFc4L0u2Q7s5oxfwAmIoxlfKkVQZymaGH25salf8dehlKup9bKAIKFqJGMkBO4oE2aQ/ALLItQ0Jh3Go6IQjOfT7JrtdmxrUq7LfBemkziTok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gR1z6jgF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE6DC4CED0;
	Thu,  2 Jan 2025 09:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735811069;
	bh=hxWnEH8xQveHUbVj8BZY+CdgkxEOLd5OTlXgJppqR7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gR1z6jgFgINsIIYD7esGa3SE+na7oPd0HtMUE98YZoBB92vgXKi40zzlhSQFafsGg
	 g3Rrav7XwkA+GHZpWH27U7SdcFyN2/gaSSv0aeMhoxmtnQwRPrTmpA0yvxD/q7eHxO
	 14tlaMSxO1T+cpZGHc+wcaea3n9wb5BMN5z+5WDdGjSSDytY+2JMVA1BpcmpYdO9am
	 Km5bgbINI2JIm/41AxTgb253oa6xWt2RTuxOnBPGqEs/PbrGY72XIn8LchtTEoTXTS
	 fhixUtZhhPdECxp8GIeSPqqJnObAAbwOhIJu38IqfVkZahyfTC/x2T7hkO/OSa/F9x
	 mp6wcwcZ2pD7Q==
Date: Thu, 2 Jan 2025 10:44:20 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, tmgross@umich.edu,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, saravanak@google.com,
	dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com, paulmck@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	rcu@vger.kernel.org, Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: Re: [PATCH v7 04/16] rust: add rcu abstraction
Message-ID: <Z3Zf9Dc1RT6Rc7HT@cassiopeiae>
References: <20241219170425.12036-1-dakr@kernel.org>
 <20241219170425.12036-5-dakr@kernel.org>
 <20241224205450.20171869.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241224205450.20171869.gary@garyguo.net>

On Tue, Dec 24, 2024 at 08:54:50PM +0000, Gary Guo wrote:
> On Thu, 19 Dec 2024 18:04:06 +0100
> Danilo Krummrich <dakr@kernel.org> wrote:
> 
> > From: Wedson Almeida Filho <wedsonaf@gmail.com>
> > 
> > Add a simple abstraction to guard critical code sections with an rcu
> > read lock.
> > 
> > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Co-developed-by: Danilo Krummrich <dakr@kernel.org>
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  MAINTAINERS             |  1 +
> >  rust/helpers/helpers.c  |  1 +
> >  rust/helpers/rcu.c      | 13 ++++++++++++
> >  rust/kernel/sync.rs     |  1 +
> >  rust/kernel/sync/rcu.rs | 47 +++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 63 insertions(+)
> >  create mode 100644 rust/helpers/rcu.c
> >  create mode 100644 rust/kernel/sync/rcu.rs
> 
> [resend to the list]
> 
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3cfb68650347..0cc69e282889 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19690,6 +19690,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
> >  F:	Documentation/RCU/
> >  F:	include/linux/rcu*
> >  F:	kernel/rcu/
> > +F:	rust/kernel/sync/rcu.rs
> >  X:	Documentation/RCU/torture.rst
> >  X:	include/linux/srcu*.h
> >  X:	kernel/rcu/srcu*.c
> > diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> > index dcf827a61b52..060750af6524 100644
> > --- a/rust/helpers/helpers.c
> > +++ b/rust/helpers/helpers.c
> > @@ -20,6 +20,7 @@
> >  #include "page.c"
> >  #include "pid_namespace.c"
> >  #include "rbtree.c"
> > +#include "rcu.c"
> >  #include "refcount.c"
> >  #include "security.c"
> >  #include "signal.c"
> > diff --git a/rust/helpers/rcu.c b/rust/helpers/rcu.c
> > new file mode 100644
> > index 000000000000..f1cec6583513
> > --- /dev/null
> > +++ b/rust/helpers/rcu.c
> > @@ -0,0 +1,13 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/rcupdate.h>
> > +
> > +void rust_helper_rcu_read_lock(void)
> > +{
> > +	rcu_read_lock();
> > +}
> > +
> > +void rust_helper_rcu_read_unlock(void)
> > +{
> > +	rcu_read_unlock();
> > +}
> > diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> > index 1eab7ebf25fd..0654008198b2 100644
> > --- a/rust/kernel/sync.rs
> > +++ b/rust/kernel/sync.rs
> > @@ -12,6 +12,7 @@
> >  pub mod lock;
> >  mod locked_by;
> >  pub mod poll;
> > +pub mod rcu;
> >  
> >  pub use arc::{Arc, ArcBorrow, UniqueArc};
> >  pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
> > diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
> > new file mode 100644
> > index 000000000000..b51d9150ffe2
> > --- /dev/null
> > +++ b/rust/kernel/sync/rcu.rs
> > @@ -0,0 +1,47 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! RCU support.
> > +//!
> > +//! C header: [`include/linux/rcupdate.h`](srctree/include/linux/rcupdate.h)
> > +
> > +use crate::{bindings, types::NotThreadSafe};
> > +
> > +/// Evidence that the RCU read side lock is held on the current thread/CPU.
> > +///
> > +/// The type is explicitly not `Send` because this property is per-thread/CPU.
> > +///
> > +/// # Invariants
> > +///
> > +/// The RCU read side lock is actually held while instances of this guard exist.
> > +pub struct Guard(NotThreadSafe);
> > +
> > +impl Guard {
> > +    /// Acquires the RCU read side lock and returns a guard.
> > +    pub fn new() -> Self {
> > +        // SAFETY: An FFI call with no additional requirements.
> > +        unsafe { bindings::rcu_read_lock() };
> > +        // INVARIANT: The RCU read side lock was just acquired above.
> > +        Self(NotThreadSafe)
> > +    }
> > +
> > +    /// Explicitly releases the RCU read side lock.
> > +    pub fn unlock(self) {}  
> 
> I don't think there's need for this, `drop(rcu_guard)` is equally
> clear.

I don't mind one or the other, feel free to send a patch to remove it. :)

> 
> There was a debate in Rust community about explicit lock methods, but
> the conclusion was to not have it,
> see https://github.com/rust-lang/rust/issues/81872.
> 
> > +}
> > +
> > +impl Default for Guard {
> > +    fn default() -> Self {
> > +        Self::new()
> > +    }
> > +}  
> 
> I don't think anyone would like to implicit acquire an RCU guard! I
> believe you included this because clippy is yelling, but in this case
> you shouldn't listen to clippy. Either suppress the warning or rename
> `new` to `lock`.

I picked up this patch from Wedson, so I can't tell for sure. I don't see
any other reason for this though, so we could remove it.

> 
> > +
> > +impl Drop for Guard {
> > +    fn drop(&mut self) {
> > +        // SAFETY: By the type invariants, the RCU read side is locked, so it is ok to unlock it.
> > +        unsafe { bindings::rcu_read_unlock() };
> > +    }
> > +}
> > +
> > +/// Acquires the RCU read side lock.
> > +pub fn read_lock() -> Guard {
> > +    Guard::new()
> > +}  
> 

