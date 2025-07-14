Return-Path: <linux-pci+bounces-32042-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E715B0374E
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 08:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E97177197
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 06:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C962264D4;
	Mon, 14 Jul 2025 06:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUDqUDmA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1029734CF9;
	Mon, 14 Jul 2025 06:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752475339; cv=none; b=NBzGmw8JqLLXH3Xd+v9QoMeV+4+3UkG4CRiETSfFd/zPkyzOBX2tttZllb/+nj0sarAYp7x9mJVy5OwzLsUEn6OsyXUEokX8A0KL7Sv7HxsiWioCMzH67P9+piVLctXeHwl2BmGCKhoau6DaoGxanUlRxXlmX9mNWnQFBNdjDIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752475339; c=relaxed/simple;
	bh=KM6mwuqBeaoSRvXnz2KtCuL6zDL/q/j27pSTmyW/ftA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cg5OXxX7XEOXcdKhT+/xAS2tprkuxKbJapv37fEKk4a78ma+Rs8M0aujjGk6/8mOH4EznvHbXFtCOlDvZYTd6eVqrKmZkJN05yGqZtyOKbu493US+Bt0vwufDyRk2543EzriHIMCUbNesH8VL2yUFSm3AnJQqvjTt5MiZlYOQ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUDqUDmA; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7de159778d4so208647885a.1;
        Sun, 13 Jul 2025 23:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752475337; x=1753080137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljZkUpq3BqIInH6ftuWagFvHQ9Kk1glVwtkKjme88l8=;
        b=XUDqUDmArmXZ6hk63DmUxcD99Gp0yEJXp/Fthy/xX9sAiZ37PUoFdusUneX4TpKsDz
         TSsRtzGLQS5v67qGbFYscf1wMH26dIKHnx95W8L6lvFKPy+VPMYrIsxXWcqp0TqGbtbf
         eG/dmwqYEERM71ZjkMlw35gBxYgBnEG2zEisozuQGDMx9wBVtdmxgZhgUr3KRZguV8V3
         N+MuvIGmKESP495uKRl6Qi4SbSDtX6MI3to8fB6VLp6QyRBQXfUVDpE+9b77IdZ4w4s9
         CCaL2c2HDEVLwO0Th2O6Bq2lAIcTuxxP4QNuaGUJR9rzLXXCgh+/tTXR1BMQ9Bj/+fDJ
         c0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752475337; x=1753080137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljZkUpq3BqIInH6ftuWagFvHQ9Kk1glVwtkKjme88l8=;
        b=d2Qs5X+FAedVU9/AM9TMjhTwSyIIlpdwng2bQccPS7DPfJvQgLeym/C6J45sjWCjsY
         sjDxOQNK4ZmZplGUtqTKQhzxacm+Y7XE4ouK1/neXaFFbU50BTHe2NJwyP9nesqyVFqW
         63PibJulJ/eTbid3XlCzusIOocRIPGRNBC1MAGcj4OlA/2/RaUCdKqGX/dQY25Dji1rc
         H/BhN9D26qb+GmYl7xqqb9aTwbAMau4IKMBgRHw3I0r/etkXDko14FcZ8vAE/WEHeCw4
         ELFDJkpjt9HLA24R0TWn7UGgBmQ5ML0LPYn9c5anHXRE7kECZ4F7mUObb/PnZsP1bbs5
         u4wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZvtzwxBDha0e+I836GPCKtcCtr4Qg5snLFHLSYWtgO84owiJV7krJqylD2WrSnL+eqIyVJ6Ep/e+c3KARvyQ=@vger.kernel.org, AJvYcCUvHamgs0Tuh85mj5rEqd8kGB4o9LOvdbuxu4t9eIzz4kLYp2DqW3FYxeVRzNKKfLh+Hl4d3cBvuNAe@vger.kernel.org, AJvYcCXTPA0loNKv4ccufZd4m8zWDQJ5FAckuHpPNz7TF6jVnbKKfuFiDlkWBnkspC98bVvLV27Gq6is/K+HzI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjw32SH0uBwIz3MCf9OlBTYIp/De3rHPpAccpyQ61rJ8atuSXA
	ePTHCqObNS6jVyFeYMLRV4evCGRmi/5KnFbR34/3zKH/vImq5AIAaLsEPH+6pw==
X-Gm-Gg: ASbGncstbDp9Hqq79qUlJIrA6cKpU7vFjimD57VaJ1c/cLGFwfbLdKJyej8nRHqy+Ip
	qWzOMeYf4RQTzKgkknqbdV9STjGiYCR5F+LxWtCRWN13y2ulbv6bvWzRe5nViNCcDHZS/gMank7
	sSbaXyhx0SucOTX1r2fFw0nSWMv0bi+ZaNmpENexsP58L9bJSBpLtAuu72xnBg4pdEOJGt7d11X
	P6+q+odrkc4hlRpsIoabqJMJSlXv0XumYDydvXs1qHORE1zceONaoYeAOkwhcaDWaVW/WffvKIL
	x7QFm/H+FBFKaTE9gPcASxWUxFVcjJKf6s9ZlWpX2iMtHnh2TNOeIPdaiu+tLMzr5I9fa6Xuvep
	vgH0oyJNi4OQi8agfZ0gyE6W3jq5vgb/Pidwt9ESsmGlMQS217lF5lH8WzPw45W72inPeNyHkO2
	BhrxXYFS3O1o2l3OAMPBoEMpk=
X-Google-Smtp-Source: AGHT+IGYDvdB47Y8Rs120nqK057PR53fuo+u1cmVk9uNC+C1EqOb6zvdLv2QqGMbV19y19G2cLVdYA==
X-Received: by 2002:a05:620a:40cc:b0:7e2:3a27:a117 with SMTP id af79cd13be357-7e23a27a4d6mr626558185a.55.1752475336764;
        Sun, 13 Jul 2025 23:42:16 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcde32bfa7sm477682785a.55.2025.07.13.23.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 23:42:16 -0700 (PDT)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9D186F40068;
	Mon, 14 Jul 2025 02:42:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 14 Jul 2025 02:42:15 -0400
X-ME-Sender: <xms:x6Z0aD1eQuZMuF71xKBnfPlltScJoKVj77bxCfuT7vPKo8wxVzSymA>
    <xme:x6Z0aIr3zobJk1wDgTAXCycIWjI4T2IlHztB2G4bu7PZP9zGfF8CGcTc34PiEaeqT
    4HSKVP2P2Bp1IOPXA>
X-ME-Received: <xmr:x6Z0aFm_oExdZkDAl92jEgG2XYRwdtjHalAFHjCrXgdMxQf0HPQ1ul4sDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehuddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddvhedt
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    udelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghkrheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegurghnihgvlhdrrghlmhgvihgurgestgholhhlrggsohhrrgdrtghomhdprhgtphhtth
    hopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihn
    ohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvg
    htpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhr
    tghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    grlhhitggvrhihhhhlsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:x6Z0aCTBVlKGllwQvwCcFDI_QjTM065HkZyjP57KJTtMe96sySn5vg>
    <xmx:x6Z0aHDMXGqqG1ewDgcIPd2TRZdgTIMC-bMHnXYL57Mt1aZ_Vh-DXQ>
    <xmx:x6Z0aCqgzlp3aXMK3re97ubNH3dS6LRRwAD4AmU9BS6Gzq1xIa-hVA>
    <xmx:x6Z0aFjFad02S6Qq0ymx6wrvGiSEwGP6D2GCN2Dda1qQtbws6HK_RA>
    <xmx:x6Z0aPxewr3ENinA9ysmUcn8SN4Gg8b9er_YicPil1vkHk8RCWL6TlCS>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 02:42:14 -0400 (EDT)
Date: Sun, 13 Jul 2025 23:42:13 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Benno Lossin <lossin@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kwilczynski@kernel.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
Message-ID: <aHSmxWeIy3L-AKIV@Mac.home>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
 <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com>
 <DBAE5TCBT8F8.25XWHTO92R9V4@kernel.org>
 <DAD3292B-2DBF-442A-8B60-A999AE0F6511@collabora.com>
 <DBAURC9BEFI0.1LQCRIDT6ZBV9@kernel.org>
 <DBAVXQTMR38Z.2782EGR84L7OP@kernel.org>
 <DBAWQG1PX5TO.6I2ARFGLX88N@kernel.org>
 <DBAX59YKO0FV.ANLOWRHDDS92@kernel.org>
 <DBAXP68U809C.2G8DMB52M3UZ7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBAXP68U809C.2G8DMB52M3UZ7@kernel.org>

On Sun, Jul 13, 2025 at 02:42:41PM +0200, Danilo Krummrich wrote:
[...]
> If we use container_of!() instead or just pass the address of Self (i.e.
> Registration) to request_irq() instead,
> 
> 	pub fn device(&self) -> &Device
> 
> is absolutely possible to add to Devres, of course.
> 

One thing to notice is that in `Devres::new()`, `inner` is initialized
before `dev`:

        try_pin_init!(&this in Self {
            // INVARIANT: `inner` is properly initialized.
            inner <- Opaque::pin_init(try_pin_init!(Inner {
                data <- Revocable::new(data),
                devm <- Completion::new(),
                revoke <- Completion::new(),
            })),
	    
For `irq::Registration`, request_irq() is called at `inner`
initialization. So now interrupts can happen at any moment, but `dev` is
still uninitialized.

            callback,
            dev: {
                // SAFETY: `this` is a valid pointer to uninitialized memory.
                let inner = unsafe { &raw mut (*this.as_ptr()).inner };

                // SAFETY:
                // - `dev.as_raw()` is a pointer to a valid bound device.
                // - `inner` is guaranteed to be a valid for the duration of the lifetime of `Self`.
                // - `devm_add_action()` is guaranteed not to call `callback` until `this` has been
                //    properly initialized, because we require `dev` (i.e. the *bound* device) to
                //    live at least as long as the returned `impl PinInit<Self, Error>`.
                to_result(unsafe {
                    bindings::devm_add_action(dev.as_raw(), Some(callback), inner.cast())
                })?;

                dev.into()
            },
        })

I think you need to reorder the initialization of `inner` to be after
`dev` for this. And it should be fine, because the whole device is in
bound state while the PinInit being called, so `inner.cast()` being a
pointer to uninitialized memory should be fine (because the `callback`
won't be called).

Regards,
Boqun

> > Depending on how (1) is ensured, we might just need an unsafe function
> > that turns `Device<Normal>` into `Device<Bound>`.
> 
> `&Device<Normal>` in `&Device<Bound>`, yes. I have such a method locally
> already (but haven't sent it yet), because that's going to be a use-case for
> other abstractions as well. One specific example is the PWM Chip abstraction
> [1].
> 
> [1] https://lore.kernel.org/lkml/20250710-rust-next-pwm-working-fan-for-sending-v11-3-93824a16f9ec@samsung.com/

