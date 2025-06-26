Return-Path: <linux-pci+bounces-30681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56234AE94E5
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 06:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4182176677
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 04:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C1B211A28;
	Thu, 26 Jun 2025 04:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFwpRieB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE87B186E2E;
	Thu, 26 Jun 2025 04:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750911209; cv=none; b=Ph8QdE9PV0vpB+3YNdJpHOTDAyhuznRJKzu2MMRUnx7xZGIZf5we6xbXzOPS1ec8WOkoXpT2K4/zAkbP1wFYN4iSHYCdh3dqTXUjjgtRaBYt7kfjbgOueobxP7+Dv3fR0kRzc6PlyypaebjHchsl3JWFIrKr1lWfxQykuPQnWjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750911209; c=relaxed/simple;
	bh=HBCEEJz/CPA+TBfOtmhfTxmJ2gUIJttlEr9jJMcBJRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dj6BgnIHCDuh8Ovo/mKuXkm1b8+YrvUXwtVca/zOOU1kUW3IL+a3hDVCX6b/wvhr8fuZe1nJWoUhu+C3uOlyiXqBHaWu5Vxp6Hb47hkjjnivM3yFSHlq4Z+VmuX0nbqptn0Qa+hY49bddX2/02mplkGlA76Uag72iCZm10hA1SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFwpRieB; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fd0a3cd326so8458626d6.1;
        Wed, 25 Jun 2025 21:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750911206; x=1751516006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cB89kIOPc2zsNiciblqiuc+ZzwafSNwodC7kwMuppfQ=;
        b=KFwpRieB9N1DxzqFLmRb3R+X1uDQlQ3Z3XX+wOu/nLmSI2HHCsN5IAemZ3CNVVJmeL
         iZJ1AKryqPVa5oxlMtW3+kGKYCANILUDqnDMFITsQilAyylzYOgp5xxun9qwLHM9VGpX
         1pU9NpTmvtuPZQLbfglvpkOuLkc9u1UZZsrlso14Tm+BcIknOSMH7EIzBTB9eWihg9rf
         HFRP7+cCpNsydVrUJRVLmqAj/t4iVpi6izfLk0io/Lu7jGjo64I9JS55JR4kaEZX4P1Y
         8P5RMRERzhLEQDE2IsgGKHalxH8a6oepfyF0y/ptl6yNkp1QPLN2om5VUfbm+hTAdOH6
         RiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750911206; x=1751516006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cB89kIOPc2zsNiciblqiuc+ZzwafSNwodC7kwMuppfQ=;
        b=Guf2NjNIVnxwUKqv21NuXWXJiB7CdNGr2KHP0UjsSRrY/ky8i+7CdcTwmdohxyogWF
         UsIhZci3hf1pK1zYsvzvrvQQQeIP/I7HkyK9ZjSrEGMxLCw4q2m6dZjdabwPLJB7LkZE
         CDPkIAfYw8jSYnw6OcpjPu/wgaNr/kvi7mAG3aiI6CxTMemzDs8srDs8MineVVtESxKH
         GYTv0fxNUzZ4Pf9aGqBz+inlK6boUpKhjv1a67FQ0C8Fj2qQ60n/1DlzJM4X2ur58VQO
         TPBB5Uf46Y7+git+DXCDUMm7ZE6pi8GJyK1180DiKp1flBdmcRk0h+qhbs11FbTWrmz1
         yH3A==
X-Forwarded-Encrypted: i=1; AJvYcCUKE0bKOCfuvhSxvNSOUyzZJSDgiXARTuCZ7NXxezQuPIFFrPDcsH4Ktgtfp9nbNmIWWBP3kweQDEzW@vger.kernel.org, AJvYcCUd6tPJmt+OKs2z2LRKJJ0MFzadjQKq3IzTgBeeBAVXmUJg9a/0aJrCaRugJk81RQRjDPzXXt+/O+MThj8=@vger.kernel.org, AJvYcCW4Vyw6Qb4r//zs2gtKoz+BPXS3dGpqtgVGaLlDUcs90s6nfAq5ep2ryH0+Girm9Y/FlV9+9UKq2o6P77ONjE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV/hH+GvyMzl57Rc9QwmaYbz7JybbHI+Cefwt78bPRKTz9tw/m
	H9NN4SObmT2buHt6QvXka7WJl8qLLFIVySlSuv3vaTFpdyIUfe+0stHu
X-Gm-Gg: ASbGnctTjhuZlLLUR4uHWdKDfjWCmBD1q0/FVx2tgmNMvWY6DGgbaPoWElZixeNX5Kd
	osAcgUP/Kun+bySzDAXaJ5Tcxie6gmki6u3hYSANEJKNahtzpmrK8lf5DV/kcnFu8ukl/FH+s7P
	iAPgRttmx1QVWGMZZuH4tAe/Qdz6RHNcTJmVV8VyVDSYiVg32nqNUYFVikSioWLN0MtjB67sAKb
	/DIRzk8vvgWBmyAzjS1Q477hBvXGIOX+tYv9AYKsA/1UrfCpxJSbhjrz1cxhiE+r3tPoODAQTMN
	IkhaVmiD4dxQnqUetHiyQs4GDgaiy4+NBcpkDdYywdx4ZzPJXOeFQkRH6vAJwFYp2GZPMnlcOPv
	RJdwzwksyIgoU4NH4kpJo63CbGJ7qO0daIsRz6NbeKJ13frJ2GOMW
X-Google-Smtp-Source: AGHT+IEYt5oCVKOc/516M6/N/PL+WpfaA2TZVJgo4mdX1mTLcLC6ilJONaUQ9y3KxymHOe4xQKG0/A==
X-Received: by 2002:a05:6214:570a:b0:6ed:19d1:212f with SMTP id 6a1803df08f44-6fd5ef2fdadmr95362836d6.5.1750911206526;
        Wed, 25 Jun 2025 21:13:26 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f99efaa9sm681441585a.58.2025.06.25.21.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 21:13:25 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 60FCFF40068;
	Thu, 26 Jun 2025 00:13:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 26 Jun 2025 00:13:25 -0400
X-ME-Sender: <xms:5chcaCby8GYuawfa1FKNCxUMUEO2uruhr-Qd48ij5KXq7y4_ZsvYvA>
    <xme:5chcaFZaI8WN2AWRNxzTT5KrLND2DsO5q_Rzfo36c1QV3W-kSl07hSw_ulvBD37oW
    TVUdrQI5pzlJF6Myw>
X-ME-Received: <xmr:5chcaM8S34Wi6md5idxSLwHKgzkCVOCGTIY-Tbmuh0MtcXP9xYt9iRVpYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvgeeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslh
    hinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehg
    rghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprh
    hothhonhhmrghilhdrtghomhdprhgtphhtthhopehlohhsshhinheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:5chcaEpomIhvOKx33CWlPv06L5ByMQx72pg_NjEh55rxZrC5QHwGMg>
    <xmx:5chcaNqnEqPlxgQybsDI_WozILenKtnsx4vHmUDJ1s5xxQLRdRmaVg>
    <xmx:5chcaCTwnXuCAAd_U0OghL2mxjiTUhTthUoLE9pXos7z7xeDndVsaw>
    <xmx:5chcaNoozZN9WEUBDaGhtnMhr6-FZIJhVGN9YfpK_xVYWJPHqGHBgQ>
    <xmx:5chcaK4Nt_5Ez4O8fld5_mYv5UQ2jDVxVJ951kKeGTqTxyrAkOmT4uPL>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jun 2025 00:13:24 -0400 (EDT)
Date: Wed, 25 Jun 2025 21:13:24 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, david.m.ertman@intel.com, ira.weiny@intel.com,
	leon@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 3/4] rust: devres: get rid of Devres' inner Arc
Message-ID: <aFzI5L__OcB9hqdG@Mac.home>
References: <20250624215600.221167-1-dakr@kernel.org>
 <20250624215600.221167-4-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624215600.221167-4-dakr@kernel.org>

On Tue, Jun 24, 2025 at 11:54:01PM +0200, Danilo Krummrich wrote:
[...]
> +#[pin_data(PinnedDrop)]
> +pub struct Devres<T> {

It makes me realize: I think we need to make `T` being `Send`? Because
the devm callback can happen on a different thread other than
`Devres::new()` and the callback may drop `T` because of revoke(), so we
are essientially sending `T`. Alternatively we can make `Devres::new()`
and its friend require `T` being `Send`.

If it's true, we need a separate patch that "Fixes" this.

(Imagine a Devres<MutexGuard>)

> +    dev: ARef<Device>,
> +    /// Pointer to [`Self::devres_callback`].
> +    ///
> +    /// Has to be stored, since Rust does not guarantee to always return the same address for a
> +    /// function. However, the C API uses the address as a key.
> +    callback: unsafe extern "C" fn(*mut c_void),
> +    /// Contains all the fields shared with [`Self::callback`].
> +    // TODO: Replace with `UnsafePinned`, once available.

nit: Maybe also reference the `drop_in_place()` in Devres::drop() as
well, because once we use `UnsafePinned`, we don't need that
`drop_in_place()`. But not a big deal, just trying to help the people
who would handle that "TODO" ;-)

> +    #[pin]
> +    inner: Opaque<Inner<T>>,
> +}
> +
[...]
> +// SAFETY: `Devres` can be send to any task, if `T: Send`.
> +unsafe impl<T: Send> Send for Devres<T> {}
> +
> +// SAFETY: `Devres` can be shared with any task, if `T: Sync`.
> +unsafe impl<T: Sync> Sync for Devres<T> {}

`T` also need to be `Send` for `Devres<T>` to be `Sync` because that's
what `Revocable<T>` requires. (Unless we want `T` always being `Send`
because of the issue I mentioned above)

The rest looks good to me.

Regards,
Boqun

> +
> +#[pinned_drop]
> +impl<T> PinnedDrop for Devres<T> {
> +    fn drop(self: Pin<&mut Self>) {
>          // SAFETY: When `drop` runs, it is guaranteed that nobody is accessing the revocable data
>          // anymore, hence it is safe not to wait for the grace period to finish.
> -        if unsafe { self.0.data.revoke_nosync() } {
> -            // We revoked `self.0.data` before the devres action did, hence try to remove it.
> -            if !DevresInner::remove_action(&self.0) {
> +        if unsafe { self.data().revoke_nosync() } {
> +            // We revoked `self.data` before the devres action did, hence try to remove it.
> +            if !self.remove_action() {
>                  // We could not remove the devres action, which means that it now runs concurrently,
> -                // hence signal that `self.0.data` has been revoked successfully.
> -                self.0.revoke.complete_all();
> +                // hence signal that `self.data` has been revoked by us successfully.
> +                self.inner().revoke.complete_all();
> +
> +                // Wait for `Self::devres_callback` to be done using this object.
> +                self.inner().devm.wait_for_completion();
>              }
> +        } else {
> +            // `Self::devres_callback` revokes `self.data` for us, hence wait for it to be done
> +            // using this object.
> +            self.inner().devm.wait_for_completion();
>          }
> +
> +        // INVARIANT: At this point it is guaranteed that `inner` can't be accessed any more.
> +        //
> +        // SAFETY: `inner` is valid for dropping.
> +        unsafe { core::ptr::drop_in_place(self.inner.get()) };
>      }
>  }
>  
[...]

