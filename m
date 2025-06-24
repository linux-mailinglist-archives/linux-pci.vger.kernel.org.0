Return-Path: <linux-pci+bounces-30529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB417AE6C88
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 18:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0607A5A6095
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 16:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DDA307481;
	Tue, 24 Jun 2025 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtDIKqzz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FD62E2EEC;
	Tue, 24 Jun 2025 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750783027; cv=none; b=S498TXFi6atG5iJdx17GufCIF0EOa9tzs8BiNtoeABbebk/hXljEPalXhEExPcQK9Bgf1ql79naqzI9PXg9ZodVKdGGU4VTNhR6Xc5lBMNpn/MH0ARiRrfO1gPQcDWjoSytpFy7CAFgn5srDNhgTbKrMWXlF7/soCcm2OYwHOSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750783027; c=relaxed/simple;
	bh=NRoFurR9kV6zGdDDahTSMnjYU9FuSfQZM8nZr6O3528=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEciC46jzOtHLwnPnE084VKJJYjsD6Di1VVKqzu/SvMoD0ahuZWrzFwvysGmJPajMXRBCM53+TOt17y+bzd286nsAjR7FMNBgYkBBOUxJmB8R4cD+j3LnKC9MOdGldSx/HdWJzYSsEUmSw/zZIl/YpJg/fXernP1WBJIG0ieL2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtDIKqzz; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a58d95ea53so642431cf.0;
        Tue, 24 Jun 2025 09:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750783024; x=1751387824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrHUOA5cM5tPGA5+OiPMKQrqna+9NnupLRwgpEP5io4=;
        b=UtDIKqzzlOoSZGn9c/IEJ5/1/XBbBf62GxGgBe12CCdzYShI63mByAHFzlHZe3lgby
         sKh9bxqNgob8TixJFJcB/8ZQ3XIKVn8GZciMHQHVVzoNdpMOp6PzPzDeCuq+Ci1dcdlQ
         KTcpPnXHxSG/SHXwTT9J10F7y2PCNxL/6XAdcOHJQNl2fDoK9GnFBn+FygFXvH9r80mQ
         09Kf8VOQSSJHZUMwXO+ZtkFWoKd18wrfHb4nkYJeIb+WmHdSt1Z609m/NjdUdzGpXpnQ
         I8l841G0KTmorX8NVIekI9WRuHjCkfrgXwOn2FA8WOMh0qVxobcAYk1dpsGLZ7ylXMjG
         Fsiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750783024; x=1751387824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wrHUOA5cM5tPGA5+OiPMKQrqna+9NnupLRwgpEP5io4=;
        b=q5f2GftJI68F8SuwlsJ38albUQTVnUid4SH5h0TowypL66+D98xcv++RYISRp5s+cs
         9l+io+EFImXRD5d0FdcpefqoTz6bGfMRQYL3X93rUOKbiSGy3qTzoh5AICqU4OwuysZj
         9kHUggzeZg+dyJ47ij8VLy+tw7cEXmxVlDZMzLX3Uqon8TD+W3ciOfzQUdTRBoo7hNHu
         2J9b7xjgSWDmWp7ej+fUJjPFETPgNTEpHwyoBvxOdy/Z1Ikh5XTfIjPaZglhe5lRZoAx
         p+4GpCBGU2hD0VtxjBBgF8BRUbZCUZjXvFDpU3abYy3tumDtaGDXwWazwqjTbEBON2+p
         ILCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgEC1Cvc87d9+O6cubSlrcZwSobinYO3T2tO6e+r0DVKLpFIpDE35/+QZQA2S0tJGf5Af4f4f9F5sp@vger.kernel.org, AJvYcCUknNOVMKDv5IAiJFcCNl4XtYkhx/jnqzsLY64fcMc0/O7Re5tqKMMnSC7cC3eGaLK19e1i73pApNoDDzwB/k4=@vger.kernel.org, AJvYcCVZJDh4eqgYywK8ggMNRFRsAmPFDmqKzv3SjWxFr4makYCxu1Z6mRc6ik2KgNvw4wO2JgdaWFlH9FEljHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiqZVobr2D8xJFe+uYv4TApQleJYKtAXpBzYF7dRRY4vobTyyV
	Wyj5/uUJp/OPXqZWQ29G+Z6TI2Q4M8TLuOAERSNqAVvk9xMGiiE80wu6
X-Gm-Gg: ASbGncuAYvfbK5H4LExETmcoZOETT3A2otvIKuxPt67e+Yjt/9phyNRoXmpGPRA4XYX
	Y44UauVfA0LNfnU8b6UdzjaepV3YcmGqyNkDg1KI9Je4ymgJTi29B5v37N+g31+hHRW/bhz+lE0
	sDqoJ/OdXWZaCn3L902E8+8BDjfN1KgyQyftLucy5PvvBYtxavLGy/nNPOqXB9khvMjUW/zUSRP
	XwobGNiIFPPTRA7EU3gONDWQAmHLf0sGm3HXc5tcT35nAu2TaRUnxGpKdj+FnxeIKk3Nk7Rljex
	kSJnJUCPDaxel+UvafbAUXjor88lW93zLWrWW1Gc3HBaSdnTYZ4Plv5v5mRyLfI3zdapOp8/KfV
	1cy83eODr1t4purTmOn5spidNsuUC79nUvw0s8d8U+d/7GVazcgMK
X-Google-Smtp-Source: AGHT+IGzyxTxtdQQikYdjRdTiJkeiOX/DC0V3FgB4xWNuRSQcxY5k8TFZ3R2gStJML4PDC8rme24/Q==
X-Received: by 2002:a05:622a:580e:b0:4a7:8439:796e with SMTP id d75a77b69052e-4a7ae950d6fmr69027831cf.13.1750783024476;
        Tue, 24 Jun 2025 09:37:04 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a779d4e62csm51251191cf.15.2025.06.24.09.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 09:37:04 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 59E111200068;
	Tue, 24 Jun 2025 12:37:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 24 Jun 2025 12:37:03 -0400
X-ME-Sender: <xms:L9RaaCu7D0gu6NNov063q707sxCCZpWBy6TGMkYMxSZ0JvOkpaVNcg>
    <xme:L9RaaHdvde5gaVkFBbR1fLDowr_g9pmr1Lrbess0nBH2ZJEQhYmwcxz9LlO3aWxga
    GphpHe52ztmXhwNiA>
X-ME-Received: <xmr:L9RaaNy3OfUrArk_eeFmpR98dSxtwFt_2GnuQyCGE8FJCETcP0MfKxuDKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvtdefkecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:L9RaaNNcdtCb_3PLYIsoPdQHmRYvB5FatNOG3HTZxwf5xQfxZvPXTQ>
    <xmx:L9RaaC_ckuLCdFXMLQROceAHa6eSPRiWkhj_KyLN2DxXb3RgCno6ug>
    <xmx:L9RaaFWWlKhhnI6lOp1F62KD1iUI-5Rux6EmSnXR1FF4XYptiam_vQ>
    <xmx:L9RaaLfxTQV0fh6pfcOpnx2SAb45UkMETxHF_RTCL5SHCCluL7Gqaw>
    <xmx:L9RaaMchv9hLOQxIsijJrRBQaD99ZAclIWg6FZ1vlxCRBCP3khTY1j1d>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 12:37:02 -0400 (EDT)
Date: Tue, 24 Jun 2025 09:37:02 -0700
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
Message-ID: <aFrULqf7gQgI4T9p@Mac.home>
References: <20250622164050.20358-1-dakr@kernel.org>
 <20250622164050.20358-4-dakr@kernel.org>
 <aFizv7suXTADJU3f@Mac.home>
 <aFrBvwFrUGD45TeF@cassiopeiae>
 <aFrIbRA9b9LOxFQ3@Mac.home>
 <aFrPKAxHfAetcQzz@cassiopeiae>
 <aFrQWQp94ZvFQ3SV@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFrQWQp94ZvFQ3SV@cassiopeiae>

On Tue, Jun 24, 2025 at 06:20:41PM +0200, Danilo Krummrich wrote:
> On Tue, Jun 24, 2025 at 06:15:43PM +0200, Danilo Krummrich wrote:
> > Oh, so you meant adding this to the safety comment. Yes, that makes sense. Maybe
> > ScopeGuard works too, as you say.
> 
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index 2591cacecb7b..afd73a8c6012 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -14,7 +14,7 @@
>      prelude::*,
>      revocable::{Revocable, RevocableGuard},
>      sync::{rcu, Completion},
> -    types::{ARef, ForeignOwnable, Opaque},
> +    types::{ARef, ForeignOwnable, ScopeGuard, Opaque},
>  };
>  use core::ops::Deref;
> 
> @@ -177,15 +177,15 @@ fn data(&self) -> &Revocable<T> {
>          // hence `ptr` must be a valid pointer to `Inner`.
>          let inner = unsafe { &*ptr.cast::<Inner<T>>() };
> 
> +        // Ensure that `inner` can't be used anymore after we signal completion of this callback.
> +        let inner = ScopeGuard::new_with_data(inner, |inner| inner.devm.complete_all());
> +
>          if !inner.data.revoke() {
>              // If `revoke()` returns false, it means that `Devres::drop` already started revoking
>              // `data` for us. Hence we have to wait until `Devres::drop` signals that it
>              // completed revoking `data`.
>              inner.revoke.wait_for_completion();
>          }
> -
> -        // Signal that we're done using `inner`.
> -        inner.devm.complete_all();
>      }
> 
>      fn remove_action(&self) -> bool {
> 
> Is this what you thought of?

Yep, looks good to me. Thanks!

Regards,
Boqun

