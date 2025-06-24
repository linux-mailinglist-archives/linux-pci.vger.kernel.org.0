Return-Path: <linux-pci+bounces-30523-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E92AE6BBF
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 17:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA021883581
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 15:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8F426CE1C;
	Tue, 24 Jun 2025 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jG57DApx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D552B307491;
	Tue, 24 Jun 2025 15:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750780019; cv=none; b=W9Q/g4lox0cRjms4D1eJdqmhABErZKsw5gij8XaTMNwwGqcZ1CrFrgKu8n4f1XZQnT2NcNC0w6S9qm8dBZDKFo+FCW0CyUREeslYFn1BNDdJqzCYsp2RgNz8qyE1QljC6VmTzc6v1vSMVYJqKHw7etz89A53pOR7rGUNZtQrwNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750780019; c=relaxed/simple;
	bh=VV0w8frs3TUUtOcTTxlmDoBNWaoPExvIYNZbS5H5APE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQC5hwezQZHrXiWGrxap66xm4YvNt9uf4Yrcdlg1YIBU9z7tHmflcNRzPdVGLFsfIdeNSj4MFCrz2jmXgM3hiu6a4uOW5iZYjjn7nGrXoujMNbyFgfed8g/MC7pz2sW9hCwHjGfVZpM4Pt7Eg35nGGyk+qWDz8Un9bUAzq2zaho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jG57DApx; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7d3f192a64eso56652085a.2;
        Tue, 24 Jun 2025 08:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750780017; x=1751384817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEkppCMbMJPX/l0pixxRGpqT6O+LXb+bTlJSvsaT7Hk=;
        b=jG57DApxWxOU4Bfb4Bgz2EEc6DWyikZCx/jCXBbhPFiDo4x2trdIjvaR7ATJZWEdc+
         VH9HkUpjp9mMUINaflGDvawC4kLwq+IAo5QF7p1G6t120Y5K7lZ5kYE6SDNib8BAy729
         a5b4BNH1h5WDPxl1MuqqOptn8GjsRz6N62WJ49iCokq/GDSJRYoavgsVVePgR3dsDKyR
         G6c32OXj5NGykCVhQ0oOL0EwYNeEQtCvYnruOZOQCsfUp6y4eyk+y62dPlQTJuZ2qXsx
         FLoa2TPBc48bPjxWhAbKVR0riGA700kvzbVbhzvJoAE8GtBxXJl/HhRyN4hyb3rivq4d
         hBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750780017; x=1751384817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEkppCMbMJPX/l0pixxRGpqT6O+LXb+bTlJSvsaT7Hk=;
        b=chlagcv7phvwE/nNpFeuzSnf0/Y+feZ/YCmoGxnrpcTm1JswgIy4OSiCLo2hIkc2/2
         lczeFyMKncVaRp317GG+tYn8XQRgPC29/qAjr8pwGF9CYcAHjmNBCkPdCEkTH0T132AK
         62z2gN17hD7jjBKQ9VcBvjDcrNPq7SQX/hFN82qh0F2AZtTDHwcLa8ipuIrT4Sd22FJu
         tSyNn9RASPFXhAYsinq/V9a5vK63QPh99zQY+BuknYQm+DiPMOjyWjtrokh9Bd0jrEIw
         UzKfcndFef/h6SbqMkUW/H+jMMWhnHtKURaALuG+nGM//+khYjHhv5u+NkyDG/4HNzIs
         gD/w==
X-Forwarded-Encrypted: i=1; AJvYcCVA2NV6CfecbeJwmMwRbYQs7s8byyQGBC4iuPA67CazdKR1rnGS+B+FlNxICliapu+DUMzBJZHQ8NtU@vger.kernel.org, AJvYcCWH86zvUSvc3X2aO7y++XV78kBFVq5A42JWmTRIOcFOe4ot+8vqV0OdbVX3iCECMFRtSfcUHGcgaSAFaoc=@vger.kernel.org, AJvYcCWzPVQOJJMsRHagslczDNhXkKI+fgNSGRAe7Pwa87AgTbYF/Ewz1kmCxHLPi5vFdvUnURjEjgW0iD2YCAFV+sM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmiCGBOSKT1bKgOFaGBPiZgQQ13ojglyrNJW1/AHjLLZkq5afN
	SK+UldjpyMZ8qzzpqdyD7kEnu1kXapsNF1NBSjP93ZDlwfw7lVfG9YPk
X-Gm-Gg: ASbGncvdnU3izFNo8ciaYqkby7LbJGr6jtCQZUDN5ZDIaicCsN2S8KDguxFwIv/Oj+Z
	mHQpwl5UtPKY1TA72TeKKB1dMVF17kgPiC7n/iQGLyAVxB9PyJ7+Lvhy4Ij7ImhD+hFSZ6VkDJD
	tOSfY6eKc+r0h17pz7muRjZZb5t+jJKfv9vbCkcRYNh/hJN3wLohRMNSQaXlP6lWyiLNsJgObNk
	+9s5zbeSMp2B8XmQwBxNSmA0Dz4nvcr/ZcztZThsrhCw2eUyfwiXSMdrsjz+SS3dncQ9p7oNjOE
	zzViY11R0Z5kqJvIbimt2lSyT8gEFAM9SUEMciqM13alLK47Xv4HUergM5K5QLxfBg193aayiWk
	IJ+7bEsb2BNXa+z2tp9wjNjoUNUlB7Voes3KJ0rXgeojEFlrpokB0
X-Google-Smtp-Source: AGHT+IFpdX3K7daLXSR1sILnc2fqOLC5kxPiWH19yQj9idfgJBH9qxiweLdzjtmQZ2jqZtKPzlRP6g==
X-Received: by 2002:a05:620a:a905:b0:7d4:1dac:9a65 with SMTP id af79cd13be357-7d41dac9a7cmr673393185a.43.1750780016541;
        Tue, 24 Jun 2025 08:46:56 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f99efab4sm518102185a.76.2025.06.24.08.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 08:46:56 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6D7AC1200066;
	Tue, 24 Jun 2025 11:46:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 24 Jun 2025 11:46:55 -0400
X-ME-Sender: <xms:b8haaBM-nlVooUygxkovg37V7nE52XXtpgWy50eg6RhcMvqUrLqwGw>
    <xme:b8haaD-cn5veRASezMnNL2gcKYtFshglIrNoCpWiaZ34_x0oPz7SCvyopGYAFnyLd
    2rb8-jLlTO_R-Gn0w>
X-ME-Received: <xmr:b8haaAR5ykyoz9bUnr_RYFftT5ud1dpnJW4p8ia6rucGKHf0t-71rE95Mg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvtddvlecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:b8haaNuKgufPhe9kI6Rs7Jg-0E5V-E4OZgZfyEpo-T2m8XLl-xj6hg>
    <xmx:b8haaJelfQPjLzFhYHXGqdzR7tQeF37CvULZhO2a0EH6GEj-eE6MDw>
    <xmx:b8haaJ3HX3lnpNRQcdMx9x2RYNvVuhSuLx1zaDmfI5-OARuJElg_zw>
    <xmx:b8haaF-deFjqxXGu6XfTNlJ0mnPPAKu7YzLaVRYkw6gfxPY_e5uUSA>
    <xmx:b8haaE8oA4fku6QZ1rFKCw2_K2Vn8PUkCcEsZlFxrqW2Ffg86R7bO27d>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 11:46:54 -0400 (EDT)
Date: Tue, 24 Jun 2025 08:46:53 -0700
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
Message-ID: <aFrIbRA9b9LOxFQ3@Mac.home>
References: <20250622164050.20358-1-dakr@kernel.org>
 <20250622164050.20358-4-dakr@kernel.org>
 <aFizv7suXTADJU3f@Mac.home>
 <aFrBvwFrUGD45TeF@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFrBvwFrUGD45TeF@cassiopeiae>

On Tue, Jun 24, 2025 at 05:18:23PM +0200, Danilo Krummrich wrote:
> On Sun, Jun 22, 2025 at 06:54:07PM -0700, Boqun Feng wrote:
> > I think you also need to mention that `inner` only remains valid until
> > `inner.devm.complete_all()` unblocks `Devres::drop()`, because after
> > `Devres::drop()`'s `devm.wait_for_completion()` returns, `inner` may be
> > dropped or freed.
> 
> I think of it the other way around: The invariant guarantees that `inner` is
> *always* valid.
> 
> The the `drop_in_place(inner)` call has to justify that it upholds this
> invariant, by ensuring that at the time it is called no other code that accesses
> `inner` can ever run.
> 
> Defining it the other way around would make the `inner()` accessor unsafe.

Maybe I wasn't clear enough, I meant in the following function:

    unsafe extern "C" fn devres_callback(ptr: *mut kernel::ffi::c_void) {
-        let ptr = ptr as *mut DevresInner<T>;
-        // Devres owned this memory; now that we received the callback, drop the `Arc` and hence the
-        // reference.
-        // SAFETY: Safe, since we leaked an `Arc` reference to devm_add_action() in
-        //         `DevresInner::new`.
-        let inner = unsafe { Arc::from_raw(ptr) };
+        // SAFETY: In `Self::new` we've passed a valid pointer to `Inner` to `devm_add_action()`,
+        // hence `ptr` must be a valid pointer to `Inner`.
+        let inner = unsafe { &*ptr.cast::<Inner<T>>() };

^ this `inner` was constructed by reborrowing from `ptr`, but it should
only be used before the following `inner.devm.complete_all()`...

         if !inner.data.revoke() {
             // If `revoke()` returns false, it means that `Devres::drop` already started revoking
-            // `inner.data` for us. Hence we have to wait until `Devres::drop()` signals that it
-            // completed revoking `inner.data`.
+            // `data` for us. Hence we have to wait until `Devres::drop` signals that it
+            // completed revoking `data`.
             inner.revoke.wait_for_completion();
[...]
+        // Signal that we're done using `inner`.
+        inner.devm.complete_all();

... because the `DevresInner` might be freed after we signal the
`Devres::drop()`. And for example, doing a:

    inner.data.try_access();

after the above line would be unsound.

+    }

And I would prefer we document this or use `ScopeGuard`, does it make
sense?

Regards,
Boqun

