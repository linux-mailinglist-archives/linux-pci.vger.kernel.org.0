Return-Path: <linux-pci+bounces-30334-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF5FAE336B
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 03:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A323AF09F
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 01:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B02813B298;
	Mon, 23 Jun 2025 01:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L42STwlM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B16C120;
	Mon, 23 Jun 2025 01:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750643653; cv=none; b=lGxvh6xSad3nMYsOpKSV4ES0AwksCllTEvyx+SlPiznlu9xBRP4j7dqVfa8dC6B9gQHSOY1DAfJtfGKdwiz+/jg0x5rAJGFCWLjEhWy95Dc2e1TjVVJ8PW5tnONCwLoAuaQ7cO+9zXicamiSDyVrQQViJgaRwtpSUTkIbhMFwTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750643653; c=relaxed/simple;
	bh=wWJEX0DVPBCbisuNFB9aAnHyDRmsnvdwYFxdfTU994Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgRP7LnpUnQjgNHjgydK71+IqtPI2pb2R5qEj3EY2WdNNxhPYtmPpQ4uEvNkP8LQE3JhizSH8ooSQz8r4AYvj2C6dzAGVlU8CmTlIObSv18wRjDaOtrhXjJXLLIhkpNynI9WNBDjk2QEVjBT8AbXItBmzWSpUB8bU3Bn5auGTLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L42STwlM; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a43972dcd7so47054841cf.3;
        Sun, 22 Jun 2025 18:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750643650; x=1751248450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bO1dHf2WX4GfP4yOH2iZsshs6S9Z5o1yqjaiqASpRX4=;
        b=L42STwlMrmz64AA9SwpskqGLEqg72atrnPBh3kYoVf/LzeC1nEBA8zpCQSJkudiJFZ
         VVHZwlHmTOg2suzr0YV3CdlGUn7RMcszyFvXqoOfmYP742lyy9jFmLjlPR3XGUlExReV
         hrMo/9KoHzE1+NR32hsTSzh9QqRh39WgdvyIL3cHV/nZfq76AG+0M2rv7rXF7SWP9cqu
         IfMxsyZv+T5f6G1AIOKa/8VKrp1s+HT/6K4de9yQEIOIOKKHYDuIg6X/BqAh9foTsDYU
         fkkBayXh2YSYIvK5eD7f8I+YkIS9La3QfZvh3mrJop1K0AjtH/d13iguzDYoSqbaaY/w
         i1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750643650; x=1751248450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bO1dHf2WX4GfP4yOH2iZsshs6S9Z5o1yqjaiqASpRX4=;
        b=buSpELPOX9aKFw7cX4YTHLYTi5FW7KaoXC+xUd6z92VxyhpVnDqseT14jhF8OYgSvy
         wmd0143FH6znpD3jC5Ht8vpNh2ibSXkvKEFCY6F6p1jqZZ4njM8RwF+D8GFTumjeRebQ
         sHcMEEUx8afsb5C5oBApF2etWoDYXXGnpyvv8Lw+fR5ng6evAh/8s5/6rx3wBaMJRb6q
         4VZFeljUnrfNwxaliHjjuWGppSg/1z4akm6p0jU2FuOr3sIf/pIl0Fi/V72qlXbXW6by
         bwlFAfDmkgWGSrvSPZqrFJdxzeGTXML88vaa6oSX8frGxeK8wh0X0j528xqowK3XeXO/
         KaaA==
X-Forwarded-Encrypted: i=1; AJvYcCUadLXzFbC/EkfcXs+oZmLFnzTE1DkFP/wMXqUVxv3HEgewwNqAYDfVTafCvzB93uZsMD7w28HGOniJdb3FSpA=@vger.kernel.org, AJvYcCVbKctc0DLM75Nv67/rSPdmGyGhtFUCCff/cYCVTfFqcCeZqKhWCy4en1CtMdV0dQKWIS3QOKROjCaI@vger.kernel.org, AJvYcCVgz1mLXBs5vEIUbYxdRkofKOoL5XLrtM2M22raDaX+1yrkAhw7QiUAVcGYLpJEPScmYaTZb22ZIRTl+ls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+objLJpQPINaqFm+wcYLrWgafCSKJCJF4zMhEHDqDg6N3OovO
	btgoxiZN+3GyFdf90aFS+j5t+3BDC2GNxazFBl/so+kELrAzxWhFjhkFqalnbA==
X-Gm-Gg: ASbGncuuf62YTNI1XZxltZWE5CJYoAdGhZgFSSjp9+w3GxfZvDy9RSjKai7Tw7COtY2
	l7TmwuLx/NxmaWOUt3faRfWj9yUMI53SJrIpGkIooVriarzLCu6v9L5mMOx8MJpwwca/HrdfNZg
	9KcRgfsklj1APyq3FjVwgettxpDDFi/Lc/mQuxuMFM9QBiuGdJWVcmfwYEwNbr2HkT/2W6WhKu9
	HpPmQnFmjhIyNx44pHJBUPb3i9kL9tQ8Bccgd3chYWAouQZmr/Ua6hVnNdCkDCbvepN4XzWyNpD
	kYuxswfascTcSFqn80uic7sZu38wEHrTtT/QzAUNtJUenJLdDXLDIyHZiPQcPkwLi6IvCs/LUtp
	VVzoqoLl2dc0RTvGOjijf12mFyNW7n1xtYOHsrz1Sh6r8imUfkXMHyN4ducK6rhQ=
X-Google-Smtp-Source: AGHT+IE8wfhWXG/jzR6FY9KxhXUECpZuE8WMeIi7fiM/52hbCWiBgXWGj1BgvzH2vxMh8d5tCA1q8g==
X-Received: by 2002:a05:622a:1b01:b0:4a6:fa5b:5438 with SMTP id d75a77b69052e-4a77a1a3e6bmr177679461cf.4.1750643650439;
        Sun, 22 Jun 2025 18:54:10 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a77a089ccesm33375951cf.78.2025.06.22.18.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 18:54:09 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 361DE1200043;
	Sun, 22 Jun 2025 21:54:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 22 Jun 2025 21:54:09 -0400
X-ME-Sender: <xms:wbNYaPVoAYbswaNolrMUHoHVkKP0Y3ybvob9Zh8eNetcdskYE6XJNw>
    <xme:wbNYaHnqt9Lhl6Et3D1K14nmRjCo0sf0GuYsaPmQX-X8AFE5R4TxAsaBsJcaM42qc
    lz5OWAmvj8FEoKr1g>
X-ME-Received: <xmr:wbNYaLbj4wFpqu6neNHxRrx_sio7wEpwTyD35fr5nbqj_ZN8sUJF5l-iKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdduheejhecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:wbNYaKXkSJEsRkn9cXrm9uUGN1xd6V_2O8knHShPzXmh1y6j16hbIg>
    <xmx:wbNYaJlc1XM3lFszL52z3VW7ibxLf7oxCiKuMygeC72iDemZnLn5Mg>
    <xmx:wbNYaHd__I6ZPW_fTf6SnC6Sq35f_9R0BSxT6s0AsMXP3Fq7OVAI6Q>
    <xmx:wbNYaDHBWOIMprnjPBtz5kuweQYZWxoVVCxrr2J-_L-dNyPywYgthQ>
    <xmx:wbNYaLkUOb0DiDgzDTtEBsmuvP6ZGqhfPrdrcinRx1LR24EJXu14WaB->
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Jun 2025 21:54:08 -0400 (EDT)
Date: Sun, 22 Jun 2025 18:54:07 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, david.m.ertman@intel.com, ira.weiny@intel.com,
	leon@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rust: devres: get rid of Devres' inner Arc
Message-ID: <aFizv7suXTADJU3f@Mac.home>
References: <20250622164050.20358-1-dakr@kernel.org>
 <20250622164050.20358-4-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250622164050.20358-4-dakr@kernel.org>

On Sun, Jun 22, 2025 at 06:40:40PM +0200, Danilo Krummrich wrote:
> So far Devres uses an inner memory allocation and reference count, i.e.
> an inner Arc, in order to ensure that the devres callback can't run into
> a use-after-free in case where the Devres object is dropped while the
> devres callback runs concurrently.
> 
> Instead, use a completion in order to avoid a potential UAF: In
> Devres::drop(), if we detect that we can't remove the devres action
> anymore, we wait for the completion that is completed from the devres
> callback. If, in turn, we were able to successfully remove the devres
> action, we can just go ahead.
> 
> This, again, allows us to get rid of the internal Arc, and instead let

I like the idea ;-)

> Devres consume an `impl PinInit<T, E>` in order to return an
> `impl PinInit<Devres<T>, E>`, which enables us to get away with less
> memory allocations.
> 
> Additionally, having the resulting explicit synchronization in
> Devres::drop() prevents potential subtle undesired side effects of the
> devres callback dropping the final Arc reference asynchronously within
> the devres callback.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
[...]
> +impl<T> Devres<T> {
[...]
>  
>      #[allow(clippy::missing_safety_doc)]
>      unsafe extern "C" fn devres_callback(ptr: *mut kernel::ffi::c_void) {
> -        let ptr = ptr as *mut DevresInner<T>;
> -        // Devres owned this memory; now that we received the callback, drop the `Arc` and hence the
> -        // reference.
> -        // SAFETY: Safe, since we leaked an `Arc` reference to devm_add_action() in
> -        //         `DevresInner::new`.
> -        let inner = unsafe { Arc::from_raw(ptr) };
> +        // SAFETY: In `Self::new` we've passed a valid pointer to `Inner` to `devm_add_action()`,
> +        // hence `ptr` must be a valid pointer to `Inner`.

I think you also need to mention that `inner` only remains valid until
`inner.devm.complete_all()` unblocks `Devres::drop()`, because after
`Devres::drop()`'s `devm.wait_for_completion()` returns, `inner` may be
dropped or freed.

Regards,
Boqun

> +        let inner = unsafe { &*ptr.cast::<Inner<T>>() };
>  
>          if !inner.data.revoke() {
>              // If `revoke()` returns false, it means that `Devres::drop` already started revoking
> -            // `inner.data` for us. Hence we have to wait until `Devres::drop()` signals that it
> -            // completed revoking `inner.data`.
> +            // `data` for us. Hence we have to wait until `Devres::drop` signals that it
> +            // completed revoking `data`.
>              inner.revoke.wait_for_completion();
>          }
[...]
> +        // Signal that we're done using `inner`.
> +        inner.devm.complete_all();
> +    }
[...]

