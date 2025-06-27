Return-Path: <linux-pci+bounces-30979-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CCEAEC287
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 00:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377E74A0FEF
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 22:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A494228C852;
	Fri, 27 Jun 2025 22:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkjU+GLi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1665528C5D3;
	Fri, 27 Jun 2025 22:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751062007; cv=none; b=jdMhy8B7NLRQFGmTmjATJ7mEnALhtjufpWSKE1An3DBeCqaYtoRwTq3jvHxEppsceGha4HjlDdR9eH1cYMB3lbWq84ZUBOkA0GH6+AEVTzYJ9SGBIhXjdTYEMU10O8y8lNPMMol+9dNYTf7/kgRIHnHxa4Tr/yvSQBlL1j7u8A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751062007; c=relaxed/simple;
	bh=n6j6dkj1CphCaznpFnavbkMVyqtuQLXWUKghVjF/qoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujESoJqcIw4MuqP81onJqss1YH3AzMYN8yC2quoXhnQIaGU50IeljPvGnJEL8VgfjznvM/y5KmUKtn0TbB0Vw1qRq0LoiEHd4/nCQYxMB/tj8xd6xo9ZQARUG5TF3V2UmPUOuZWmtthgQ+2S4K0PALMoimbs3C2TbfcbC30taCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkjU+GLi; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7d412988b14so265203185a.3;
        Fri, 27 Jun 2025 15:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751062005; x=1751666805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IbJ2vABSGn3+sD97Rc8QtByTLnSKY4cfBMPmkHcn2o=;
        b=EkjU+GLi7zljvesLfwJwwIJ2D4XbGqSpJIGssT+1UtVAdMQDESrzCr8Dad8QSR6pfw
         PEmb92+dWVyN47oNEibOPi8vpYwnIITB3A2bKJaEo6HUQIrcDbcJcmjD8xzptjxwajgV
         XfDENShkVSTyX3WbnugzML5PiX+zgqrK1uWkNpc/t04NlF/TYNcKsnvNkvqYiPiWwFBI
         P2n4sSBGlvLLG7R10gLoTECW1CaEAem/Bj5S3AgZ+zCizEhv0KeUGrQxjTcuinLYFYj1
         M6Yr24m7XcBh/OqWMql9syXvCWYUz8WiW1DMWjeCBE0PXMgUON6kDQMd6DwDz2xgiabP
         j35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751062005; x=1751666805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IbJ2vABSGn3+sD97Rc8QtByTLnSKY4cfBMPmkHcn2o=;
        b=QvMQyPQizkv8Qaj4kID6shSK6cFYAGO5GIk5KxCAUjvt6TK05bBFkf113/7QBk2fO4
         XbVMfmKplvRox5v21e6iC3Ceo5NEMb0vbk9swVzdqVscb9joq/RFHg/ujOmXd9es0w1O
         zuTDGYszSG6VimqwBmZZdiayiCXu229ULQ2XgzCV/WSl3+rqeI5NJwGGcUBxZNZchn85
         OQ71qiuVYx4sKrj3urUGHJ+lrzmrMgpPB9dHDnL69/8fxUf8uJqXPzTOBWWS2i0KKKLL
         +rkV2oUJdm0d4G+dXdMAJhmA/6rPMMz8i4cR0Pp7Ai1COS2+pn9munKhgjXv5JMto56S
         sJBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp5sWcZSAtA7t9GnsLWhRF2iHu5QuQhTC+LKP9i0u4yVjbizAKI5RhRG3veEqRg7G4MEv1U5eQ9ICGJzjh0sQ=@vger.kernel.org, AJvYcCUw5OZLl5o2jYAhL8HGgSOSLfTWmDpigx82nDDDl1DbY3baYtENJDO7KTMbEsmNFFT9uLzEycAWxSgV@vger.kernel.org, AJvYcCW/WUqkIjvuI64bwlwE3U5B335hbY5/TfJbGOnk5UybgEIYGgT7XrBN1T9zFbYhvEQbHBU31ACqadg5ccA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzONju1NX4tztSNTxaNP5a9UOMm+wRo7BnC/Tk6o58hoU9a8l6L
	0cFqU3I/Pr0AQk0dLkpcmmA4KlqOWvyE2keG9MjLt/xLr6jLsUhBK9Q09gpy/Q==
X-Gm-Gg: ASbGncudYEBJr1mHArJSMru1Q/Td4lqzkl3qyUcvLz67KW0onzB/tAVLAlSK2a14GqV
	my3hvJnOxNB/2OMPjK0ctnQo19PKZBzSa3TpP3ZdnFx0mFB8LCNzTVfqccV3Lwr/Ex7cavq9TzX
	1cz7P0K14OQyZ4TF+Vp1BQjdXdFiZ5NuoY9Ages96IxJl8VYeN6DPGyWWAEnC5vcvW1PN514a/w
	d8aZ8Peb0KEa58Iyo+gJY45YflRVC8aoCKK0orKH1duhY4huBHo68ir1hiyz8hr+ItwR7g2mjBt
	7qf2bDywMh5AIC6g7PUoK0DUW8LC118nH1LsPx55FxVlbxINX5O88aDe4DQyL7RzBvzSIiKfd0C
	1qs2JKh4wBr8vDcGEK7j1wxSo6qf8bEoyEEysekh7MMC2/BduFaGf
X-Google-Smtp-Source: AGHT+IFgDE19suabH6fMVD//bfsYW/Nsjq+7z+a3tejRwsoAE8QdtIG8TzkeNcOj+fT9dQWcVRsbkg==
X-Received: by 2002:a05:620a:2888:b0:7d3:a602:6767 with SMTP id af79cd13be357-7d443973e12mr797271285a.40.1751062004786;
        Fri, 27 Jun 2025 15:06:44 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44317195fsm200885085a.38.2025.06.27.15.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 15:06:44 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 70A6CF40068;
	Fri, 27 Jun 2025 18:06:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 27 Jun 2025 18:06:43 -0400
X-ME-Sender: <xms:8xVfaIgJQ25goXNh3q27wqcCVH5xvh_6Mk0xEGbMl2T9c8cFo3yzDg>
    <xme:8xVfaBBbcS7OMZGRSodxl8Iin_l9mdjS-ZCGNgnKVLW-4ZlGpHTDLbofq_9XZuHgd
    AB__iHxmG0fDyaNnw>
X-ME-Received: <xmr:8xVfaAF-NGhUbASkxyat_Qwyyk2jOECuoK-Qgp516GqWFZDEd0InzuzEcEURjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffeivden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquh
    hnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudej
    jeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrd
    hnrghmvgdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehlohhsshhinheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrkhhrsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurght
    ihhonhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhg
    rgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuoh
    drnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtgho
    mhdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:8xVfaJT4XdPFaiHPZCojbIyjsGVGsPUtdnpMsOWe0cCiYLREbHLf_Q>
    <xmx:8xVfaFyTCynCfnekwl3R2e6yN9arZzryuZFHbflEEXynO27wdHdjcw>
    <xmx:8xVfaH4CCQJivcW3thPlUcz1HcEgyS_uRppmyJxQcMGTVzJGIVGiNQ>
    <xmx:8xVfaCzV2PhoxoRUUqGbbYklDVQtI2xeiFqJOtw5DDkWb66gABZ5OA>
    <xmx:8xVfaJgYGXlPOwZBiHOSVKKXnk5ygj5aw4XvI65WKTsJ9M9aoeKkVxO->
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 18:06:42 -0400 (EDT)
Date: Fri, 27 Jun 2025 15:06:42 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org,
	rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, david.m.ertman@intel.com,
	ira.weiny@intel.com, leon@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 5/5] rust: devres: implement register_release()
Message-ID: <aF8V8hqUzjdZMZNe@tardis.local>
References: <20250626200054.243480-1-dakr@kernel.org>
 <20250626200054.243480-6-dakr@kernel.org>
 <aF2vgthQlNA3BsCD@tardis.local>
 <aF2yA9TbeIrTg-XG@cassiopeiae>
 <DAWULS8SIOXS.1O4PLL2WCLX74@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DAWULS8SIOXS.1O4PLL2WCLX74@kernel.org>

On Fri, Jun 27, 2025 at 01:19:53AM +0200, Benno Lossin wrote:
> On Thu Jun 26, 2025 at 10:48 PM CEST, Danilo Krummrich wrote:
> > On Thu, Jun 26, 2025 at 01:37:22PM -0700, Boqun Feng wrote:
> >> On Thu, Jun 26, 2025 at 10:00:43PM +0200, Danilo Krummrich wrote:
> >> > +/// [`Devres`]-releaseable resource.
> >> > +///
> >> > +/// Register an object implementing this trait with [`register_release`]. Its `release`
> >> > +/// function will be called once the device is being unbound.
> >> > +pub trait Release {
> >> > +    /// The [`ForeignOwnable`] pointer type consumed by [`register_release`].
> >> > +    type Ptr: ForeignOwnable;
> >> > +
> >> > +    /// Called once the [`Device`] given to [`register_release`] is unbound.
> >> > +    fn release(this: Self::Ptr);
> >> > +}
> >> > +
> >> 
> >> I would like to point out the limitation of this design, say you have a
> >> `Foo` that can ipml `Release`, with this, I think you could only support
> >> either `Arc<Foo>` or `KBox<Foo>`. You cannot support both as the input
> >> for `register_release()`. Maybe we want:
> >> 
> >>     pub trait Release<Ptr: ForeignOwnable> {
> >>         fn release(this: Ptr);
> >>     }
> >
> > Good catch! I think this wasn't possible without ForeignOwnable::Target.
> 
> Hmm do we really need that? Normally you either store a type in a shared

I think it might be quite common, for example, `Foo` may be a general
watchdog for a subsystem, for one driver, there might be multiple
devices that could feed the dog, for another driver, there might be only
one. For the first case we need Arc<Watchdog> or the second we can do
Box<Watchdog>.

What's the downside?

Regards,
Boqun

> or a non-shared manner and not both...
> 
> ---
> Cheers,
> Benno
> 

