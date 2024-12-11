Return-Path: <linux-pci+bounces-18170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE799ED4DC
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 19:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958B72820FF
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 18:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045772036FF;
	Wed, 11 Dec 2024 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="motmnIjt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E7D1C3F27;
	Wed, 11 Dec 2024 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733942831; cv=none; b=sDL7rNBOPc5BvMICFKf0JJsnsaGQA7cuQIYOrV2H7TbJwXosXLKwGVs3XcNF+p6DQAImDQzEh8TzFLB9YXTwq1ODINB4fv1shUuLQBZqOROEdAk0Vnf7hEGoacM10fStRsZVumNEFZ5lVbOHlicRXjqB0HC5w5h+yyfzYUmGWSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733942831; c=relaxed/simple;
	bh=gf2Jfhk6boIeLbYywNb2oQLaJgWsitZZ3gdtK/RMV/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkKazj4Ro0V7mVvbRaVsOp2i1AKg8XIFqjAHyEcHkhX0dR5y7nJ+C5c1oNsWETj9TtjPS/gndbNAmjtORTTgBBx1hUH8xXEpLJ7RLYQp7jeZNNkvUp8be4LnYsB6Fra5hxaRQMQDOHRzYUJfYz/OPKbeyBew1oa44BeIhR0HAJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=motmnIjt; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b6f1be1daeso23014785a.0;
        Wed, 11 Dec 2024 10:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733942829; x=1734547629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8uhDPB57MDECRT4Us6R/vXziZ7qkRk18/oYqU3SYYA=;
        b=motmnIjtWC1K/mmAyadqlpfvynSAH898uUoMGB7jp5b1GT2Px3sHxPrhV/QqkwxsXb
         63plefRC0sv+8U2UeaMee8a8IZfiMm6byv/WGrefV1KX2qx0hujUJjr7YF7qS1WrdXQ3
         T/HHG5bCEQVAyqxMeNYDFerngMKnqJj2MMDu+/bEJZowWlPha7uJL6pT6BgLB9p3UXBi
         GE0x7xu6d29YWnFUuYnk64hgLkQjjXO9ePap/xVL3wbexgrIETn1j6wiFCE8bQnVfpRx
         wb0HmgKqSyhDgF/zMe/KWBU3DgWp5KYhFrb7V4utmMnkpj0L2LXPrU4QyhhVLK5i/4mJ
         dV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733942829; x=1734547629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8uhDPB57MDECRT4Us6R/vXziZ7qkRk18/oYqU3SYYA=;
        b=ZoaLQISFpdcHXXhZiRZHrewpn2VdRuCbjth/mpGLR28VaHJyewt3/BpQmqCX4Rnh4K
         YK1VGUaD9fINoSsPFhqA2OSn5wnmj2GSSJjnPs1T9gQgqYTGEV8iUHo8nv44TEmJ/J6J
         krZWfJn6MCw8uM/yILVbJYlhzryVld4W1ixF+Rj9rBMFi122N4uy9Us4CizV3M0nDDuA
         bAOr4SpewJdfEkxyU2udZEEfxJs4powTY7uPLg058VfyEBm60I9NtY2bgPNo4zXDVdop
         MZKb/W5CtfneUjIDAQkX1xtjC71FfaorsdS4BMgeb795ozQQUOKrWIpMw+FRTzOfMC5s
         nBnA==
X-Forwarded-Encrypted: i=1; AJvYcCUArCUgRuQEwjDTOmx7Luon2QdxeiOBz9JkaC1ZJV7+u40FjKfpjwxLdIUi96IsuZLyREh8ExytnIHj@vger.kernel.org, AJvYcCWOHmXFSRhJLWhyXOtHzDAqlJ2DksDMPCjQOR7ltT8LcnTEsjmpIZecBZQkp97ylRFbmeDUbcVxw3FcsDmW@vger.kernel.org, AJvYcCWtR4Fe3nh63LuyIkh7XcD9sQSn7xLrnGk0akrato7YjaQW5CawsdXaq0EH3Zdp2msAr6z3JyNjrdek@vger.kernel.org, AJvYcCXoeJmGuAwcwuJrUbh9R8f2qEKw5L4BNiJe2mdjGUW0jR7+d9Itt1lmDaWk01GiiVlfVvynIKfOvPQ0q21hKg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIbVWFJctn58AhzvvR0cX1VrmWbemOfPuW4Mvq6ll5EA2a9TWE
	UCsDXVDehR9+SfLP1RjKFrx+DOMIh6BJQayTAcHDyEUDXtl0FuWk
X-Gm-Gg: ASbGncvxwol1WHj5VcuTGHYC4+klRwTiVsYpOXzukPzl4RnEJQ6W+3YP38d8iOS5PJC
	Lb633PppaRHD+ZRczISIVypzbRjJydUfmunISBZtUExfsgPZ3HkvuQhaTpOlzH3dM4z60W4i/Td
	svJfxHMZZ6jw3akj09Gw/JrQ1tZdBg4tqsEVtWpwp0ieiI8IkbtjvFUQ4Y0wl3ImVuNIVl3cBZu
	WtPxXg5s1Ckl5NJM6k95zLIksDmS3Ai//CIOccYgbBglpw0r49G/7VAe7Z+KJ2COaGuUUsXnxns
	guMkllVQVaApMXGhJRyy10UaH9k3kGzjm69kbz4eikMz
X-Google-Smtp-Source: AGHT+IEC0+zCA9uHtBnpgUbDy+3CdrD2hT+hX0r+vUykPSyQLC0CPy1wDeGgE7qwNvVmhe1ab9MDzQ==
X-Received: by 2002:a05:620a:2447:b0:7b6:d4df:28a7 with SMTP id af79cd13be357-7b6f2590ce4mr46759585a.38.1733942829100;
        Wed, 11 Dec 2024 10:47:09 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6ec9821aasm80966285a.37.2024.12.11.10.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 10:47:08 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 09AA61200070;
	Wed, 11 Dec 2024 13:47:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 11 Dec 2024 13:47:08 -0500
X-ME-Sender: <xms:K95ZZysFX7b5IpdSfthBeUBKsiowWkVwu1PmZnzfpJ0HDfnpkJJz0A>
    <xme:K95ZZ3fxs1qvdduSYDrJsgdU3Zxi7E0jk8AvgQHxccTTMBIFzci7wXwa8JMN61IO_
    iEEyoxE0YFbjB0AOA>
X-ME-Received: <xmr:K95ZZ9wRowysOH7hI0cGtVdIYKU-VQ6wPZI67bMbiSWH5K16Zft0vUOj9yVx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepfedupdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghp
    thhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegshhgvlhhgrg
    grshesghhoohhglhgvrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtph
    htthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegp
    ghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegsvghnnhhordhlohhssh
    hinhesphhrohhtohhnrdhmvg
X-ME-Proxy: <xmx:K95ZZ9OuLWdFZen6ZcIhS0Y_V47IzmQ1GXw9P1NMhwKEH-0cioAkZw>
    <xmx:K95ZZy_GTFqWk7EVAsy1xHpjRZYp7Kfnlyqzg17LM99MfNqXjtlqRg>
    <xmx:K95ZZ1U4-WLz6ND0t7_IMiiUh7IliVluBvZRrgEZkUDy3NFaYLMb3Q>
    <xmx:K95ZZ7frsiNTGVmN-z46f5yC89mkwL5E_g9zrszIVNONV2y4HFdwlQ>
    <xmx:LN5ZZ8eTWfr9SSAC-yMn2sE3xu1MZ89mcMwE5k74WA-i76jjNPnq1a6j>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Dec 2024 13:47:06 -0500 (EST)
Date: Wed, 11 Dec 2024 10:47:05 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, tmgross@umich.edu,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, saravanak@google.com,
	dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: Re: [PATCH v5 04/16] rust: add rcu abstraction
Message-ID: <Z1neKVc3g28bLjee@tardis.local>
References: <20241210224947.23804-1-dakr@kernel.org>
 <20241210224947.23804-5-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210224947.23804-5-dakr@kernel.org>

Hi Danilo,

This looks good so far, could you please Cc RCU maintainers for the next
version (if there is one).

A few nits below, with or without, feel free to add:

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

On Tue, Dec 10, 2024 at 11:46:31PM +0100, Danilo Krummrich wrote:
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> Add a simple abstraction to guard critical code sections with an rcu
> read lock.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/helpers/helpers.c  |  1 +
>  rust/helpers/rcu.c      | 13 ++++++++++++
>  rust/kernel/sync.rs     |  1 +
>  rust/kernel/sync/rcu.rs | 47 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 62 insertions(+)
>  create mode 100644 rust/helpers/rcu.c
>  create mode 100644 rust/kernel/sync/rcu.rs
> 
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index dcf827a61b52..060750af6524 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -20,6 +20,7 @@
>  #include "page.c"
>  #include "pid_namespace.c"
>  #include "rbtree.c"
> +#include "rcu.c"
>  #include "refcount.c"
>  #include "security.c"
>  #include "signal.c"
> diff --git a/rust/helpers/rcu.c b/rust/helpers/rcu.c
> new file mode 100644
> index 000000000000..f1cec6583513
> --- /dev/null
> +++ b/rust/helpers/rcu.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/rcupdate.h>
> +
> +void rust_helper_rcu_read_lock(void)
> +{
> +	rcu_read_lock();
> +}
> +
> +void rust_helper_rcu_read_unlock(void)
> +{
> +	rcu_read_unlock();
> +}
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 1eab7ebf25fd..0654008198b2 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -12,6 +12,7 @@
>  pub mod lock;
>  mod locked_by;
>  pub mod poll;
> +pub mod rcu;
>  
>  pub use arc::{Arc, ArcBorrow, UniqueArc};
>  pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
> diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
> new file mode 100644
> index 000000000000..3beef70d5f34
> --- /dev/null
> +++ b/rust/kernel/sync/rcu.rs
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! RCU support.
> +//!
> +//! C header: [`include/linux/rcupdate.h`](srctree/include/linux/rcupdate.h)
> +
> +use crate::{bindings, types::NotThreadSafe};
> +
> +/// Evidence that the RCU read side lock is held on the current thread/CPU.
> +///
> +/// The type is explicitly not `Send` because this property is per-thread/CPU.
> +///
> +/// # Invariants
> +///
> +/// The RCU read side lock is actually held while instances of this guard exist.
> +pub struct Guard(NotThreadSafe);
> +
> +impl Guard {
> +    /// Acquires the RCU read side lock and returns a guard.
> +    pub fn new() -> Self {
> +        // SAFETY: An FFI call with no additional requirements.
> +        unsafe { bindings::rcu_read_lock() };
> +        // INVARIANT: The RCU read side lock was just acquired above.
> +        Self(NotThreadSafe)
> +    }
> +
> +    /// Explicitly releases the RCU read side lock.
> +    pub fn unlock(self) {}
> +}
> +
> +impl Default for Guard {
> +    fn default() -> Self {
> +        Self::new()
> +    }
> +}
> +
> +impl Drop for Guard {
> +    fn drop(&mut self) {
> +        // SAFETY: By the type invariants, the rcu read side is locked, so it is ok to unlock it.

s/rcu/RCU

when referring the RCU mechanism or the subsystem, it makes sense to use
the capitalized abbreviation.

Regards,
Boqun

> +        unsafe { bindings::rcu_read_unlock() };
> +    }
> +}
> +
> +/// Acquires the RCU read side lock.
> +pub fn read_lock() -> Guard {
> +    Guard::new()
> +}
> -- 
> 2.47.0
> 

