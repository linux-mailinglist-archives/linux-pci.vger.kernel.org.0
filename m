Return-Path: <linux-pci+bounces-30527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7827DAE6C5A
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 18:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DA61188B4ED
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 16:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151B621ABCB;
	Tue, 24 Jun 2025 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gw45KlEO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D858B256D;
	Tue, 24 Jun 2025 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750782048; cv=none; b=GDQ0kGuVpKWiEr2u4cupZt7xo3+dnjVa8HYEUas4+JbB7xFOtwTeT6/feOK9wEkLv3LOx7jmIYkZp4B+HgvijbGPOeCefJRoxqX274Wv6cHvCExihoCEYNarJU4egGrRhQLJ/Te51glsN/0KBvV1dJAjk6VYvEliyGw5iuHpieU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750782048; c=relaxed/simple;
	bh=vgXO9YS+euCiMfb3GxJUGStET3NrsENKpSg1ejFRjxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4E6soRutnYYwo9Hv8Z2rltcj1dVl2tYXPwd4P8ljo1pRxxKiMkHaG3m+ebjR0idIpxXt3d4380zho9X0fWWOujnvTaZLqKPp1E70K83JA3A6cxqeSRwehaNFKEOz1Xzj067wWqS2zIL4rJE+/sd3VFX00APJTPL9SI+NGP4cF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gw45KlEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B674C4CEE3;
	Tue, 24 Jun 2025 16:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750782047;
	bh=vgXO9YS+euCiMfb3GxJUGStET3NrsENKpSg1ejFRjxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gw45KlEOsLQIi05juzVr3K7KvHLSak8bwqGzhnwZHvtUVP/z5P0V5rQ5ovNmJHIGj
	 tlN5aC/PaQZ/x9f+q1ci+DqW1R6yLAT2KE9Nbkb2/GUjlbLf4rT7SPvLC40Uu5UHQJ
	 vWiAabJDo5PUBwxu9LWtEjYwzRFo3Ioo+n06pHz4Htz6ZGTgYHP3EumgXo7vnNUcK/
	 DgipRUaaTtHQgND+zcyTKlW464SrVkC8LF/Kc5XxoqISINck8rK2f131ijjhctiPgO
	 Ofl/tMZv1u+9K/yPZJxB6CD/j0vkk2KXtEiFh6YbcI0Omjk8TMfB5moMEaO4NtDW3r
	 7zB567pYGM3Jw==
Date: Tue, 24 Jun 2025 18:20:41 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, david.m.ertman@intel.com, ira.weiny@intel.com,
	leon@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rust: devres: get rid of Devres' inner Arc
Message-ID: <aFrQWQp94ZvFQ3SV@cassiopeiae>
References: <20250622164050.20358-1-dakr@kernel.org>
 <20250622164050.20358-4-dakr@kernel.org>
 <aFizv7suXTADJU3f@Mac.home>
 <aFrBvwFrUGD45TeF@cassiopeiae>
 <aFrIbRA9b9LOxFQ3@Mac.home>
 <aFrPKAxHfAetcQzz@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFrPKAxHfAetcQzz@cassiopeiae>

On Tue, Jun 24, 2025 at 06:15:43PM +0200, Danilo Krummrich wrote:
> Oh, so you meant adding this to the safety comment. Yes, that makes sense. Maybe
> ScopeGuard works too, as you say.

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 2591cacecb7b..afd73a8c6012 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -14,7 +14,7 @@
     prelude::*,
     revocable::{Revocable, RevocableGuard},
     sync::{rcu, Completion},
-    types::{ARef, ForeignOwnable, Opaque},
+    types::{ARef, ForeignOwnable, ScopeGuard, Opaque},
 };
 use core::ops::Deref;

@@ -177,15 +177,15 @@ fn data(&self) -> &Revocable<T> {
         // hence `ptr` must be a valid pointer to `Inner`.
         let inner = unsafe { &*ptr.cast::<Inner<T>>() };

+        // Ensure that `inner` can't be used anymore after we signal completion of this callback.
+        let inner = ScopeGuard::new_with_data(inner, |inner| inner.devm.complete_all());
+
         if !inner.data.revoke() {
             // If `revoke()` returns false, it means that `Devres::drop` already started revoking
             // `data` for us. Hence we have to wait until `Devres::drop` signals that it
             // completed revoking `data`.
             inner.revoke.wait_for_completion();
         }
-
-        // Signal that we're done using `inner`.
-        inner.devm.complete_all();
     }

     fn remove_action(&self) -> bool {

Is this what you thought of?

