Return-Path: <linux-pci+bounces-9011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 609D4910238
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 13:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4101F2204F
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 11:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714D51AAE3C;
	Thu, 20 Jun 2024 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2A3TSx9"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB561AAE31
	for <linux-pci@vger.kernel.org>; Thu, 20 Jun 2024 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718881806; cv=none; b=W05qTykdbJzj2IjEQGubOHBr+yuFj21S+twgAMwMekFGKmA+dIKec1reNmvImj+8v48CHxnqn7i7/3uMP7T7f7SOlsBB2LavsovRHQ6uvTKi3x04JVpNYj224QQ37iFQqD7vrpkSOWiaQ1ghnqLK6vQLiHergi5Ld/KiJQ7KsAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718881806; c=relaxed/simple;
	bh=fjIoyLutiqUfKxBUpky93Pe7mU64/kE4jZSsWuFL0cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2ofUm4f56fcsEeymHuCH8owyKeMmLT/AhUu2Q5eVbhb/Bf7k6dyesaaMHIfyxSgYklh9i3DnBVAD/LBmAyzWuNy3+1U/db5M2Gp1m5W8BGXnHk3BBf7wcnJN8jg2z3oYLOVntBc2E3CiLFJuu2LDb84L5lLMo3jz6bNC9PwSko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J2A3TSx9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718881803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j94HKKNLZdh9dITeBbXgdoYL8Fm7iRtd8iIrtfpWm7o=;
	b=J2A3TSx9Ep0H7DOSjpUycUgY83aXh2StmRLgbDIuUuTe84tJxhR0wOcPQkGZLVv1QuA03c
	kTDneaPKTrSMxYVoRneXxGM+9f4j/nke2RMsDjrJ4qAl23pdbyeWqCfA5As81PCEr0oRYq
	jmtXZMASgkOPl9CikL/ho+m/Sb7iMU0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-daDWyVuHPOGNOa5L90x6ug-1; Thu, 20 Jun 2024 07:10:02 -0400
X-MC-Unique: daDWyVuHPOGNOa5L90x6ug-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52c844aec2eso495625e87.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Jun 2024 04:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718881800; x=1719486600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j94HKKNLZdh9dITeBbXgdoYL8Fm7iRtd8iIrtfpWm7o=;
        b=Tg9Saq1W7Oafs9HvIfK2OEjkNg4nV/sWosI8K1jjUIJgAvB3xIP+o2rUk6gdjU3+iJ
         1C2XI7zyWEZNvCEZZsiundSN6XKhQ9kP+ie6G/AGAYXGtUrWjnwp1oiz2Yx7QNA+EX2e
         hUM17hvNzhK7hpCDwQZvG5Kh8gusV4IaCzLbsR7jHU7eebmsnn+4znFVRpsl393qRvmJ
         nBlyPTDUDTdd3HAarCENiYLFxyqiBGsG6zHhAtpTVFBYBWF+t+UE7fXzSFrNTJmCLSr1
         Yi7YSB1oMeUvZclnV/w3pIRJUVr8zkQYPRv65xVl1CMNqv0K16GM59U0SmsT8NfuOYfY
         fa3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0EQ39aiIjTWjxSnZEoU3n9xhwdAQK/zqj59QH/ndrPyB/Wc0R7w8hy4Fwjfn3mvSVpJzVF8XVXRyqHMzooIsNjaqwIE0Z01d4
X-Gm-Message-State: AOJu0Ywo3wBY1+zbiNZ+Pdw7hs1YamDs++iw5podOTTY9j84ohLonyRH
	FsXMHlFl4GB3ial/g5SOAHN+JBPd7MBftuOR5GCn2r/2gJhcx9mUzleC7xOszFbB9HacUV8GLXt
	3qn/FxvN6sbYkeqlum8+6JKArMySqFsxNLgdkFBZN1oMBElM5+/R1YrbUbA==
X-Received: by 2002:a05:6512:2309:b0:52c:9906:fa33 with SMTP id 2adb3069b0e04-52ccaa885ddmr4484209e87.43.1718881800049;
        Thu, 20 Jun 2024 04:10:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKYO/OJsiuoxGtopx4SVBBkDAH3hoecb89O6oPnar7s+vD4vlzD4TqI6QPjh899vPhPykpPQ==
X-Received: by 2002:a05:6512:2309:b0:52c:9906:fa33 with SMTP id 2adb3069b0e04-52ccaa885ddmr4484200e87.43.1718881799652;
        Thu, 20 Jun 2024 04:09:59 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0ca0afsm21583415e9.25.2024.06.20.04.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 04:09:58 -0700 (PDT)
Date: Thu, 20 Jun 2024 13:09:56 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com,
	lina@asahilina.net, pstanner@redhat.com, ajanulgu@redhat.com,
	lyude@redhat.com, robh@kernel.org, daniel.almeida@collabora.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 00/10] Device / Driver and PCI Rust abstractions
Message-ID: <ZnQOBIQPvB8xQ88r@pollux>
References: <20240618234025.15036-1-dakr@redhat.com>
 <20240619120407.o7qh6jlld76j5luu@vireshk-i7>
 <ZnLQxZjtsmDJb4I1@pollux>
 <20240620100556.xsehtd7ii25rtn7k@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620100556.xsehtd7ii25rtn7k@vireshk-i7>

On Thu, Jun 20, 2024 at 03:35:56PM +0530, Viresh Kumar wrote:
> On 19-06-24, 14:36, Danilo Krummrich wrote:
> > If you want to split `cpufreq::Registration` in `new()` and `register()`, you
> > probably want to pass the registration object to `Devres` in `register()`
> > instead.
> > 
> > However, I wouldn't recommend splitting it up (unless you absolutely have to),
> > it's way cleaner (and probably less racy) if things are registered once the
> > registration is created.
> 
> > The PCI abstraction did not need to change for that, since it uses the
> > generalized `driver::Registration`, which is handled by the `Module` structure
> > instead.
> > 
> > However, staging/dev also contains the `drm::drv::Registration` type [1], which
> > in principle does the same thing as `cpufreq::Registration` just for a DRM
> > device.
> > 
> > If you're looking for an example driver making use of this, please have a look
> > at Nova [1].
> 
> Thanks for the pointers Danilo.
> 
> There is more to it now and I still don't know what's the best way
> forward. :(
> 
> Devres will probably work well with the frameworks that provide a bus,
> where a device and driver are matched and probe/remove are called.
> Obviously Devres needs a struct device, whose probing/removal can
> allocate/free resources.

Indeed, but please note that this was the case before as well. When we had
`device::Data` with a `Revokable<T>` for Registrations this revokable was
revoked through the `DeviceRemoval` trait when the driver was unbound from the
device.

> 
> The CPUFreq framework is a bit different. There is no bus, device or
> driver there. The device for the framework is the CPU device, but we
> don't (can't) really bind a struct driver to it. There are more layers
> in the kernel which use the CPU devices directly, like cpuidle, etc.
> And so the CPU device isn't really private to the cpufreq/cpuidle
> frameworks.

If there is no bus, device or driver, then those abstractions aren't for your
use case. Those are abstractions around the device / driver core.

> 
> Most of the cpufreq drivers register with the cpufreq core from their
> module_init() function, and unregister from module_exit(). There is no
> probe/remove() callbacks available. Some drivers though have a
> platform device/driver model implemented over an imaginary platform
> device, a hack implemented to get them working because of special
> requirements (one of them is to allow defer probing to work). The
> driver I am implementing, cpufreq-dt, also has one such platform
> device which is created at runtime. But there will be others without a
> platform device.
> 
> The point is that the Rust cpufreq core can't do the Devres stuff
> itself and it can't expect a struct device to be made available to it
> by the driver. Some cpufreq drivers will have a platform device, some
> won't.

That seems to be purely a design question for cpufreq drivers then.

What prevents you from always creating a corresponding platform device?

If you really want some drivers to bypass the device / driver model (not sure
if that's a good idea though), you need separate abstractions for that.

> 
> One way to make this whole work is to reintroduce the Data part, just
> for cpufreq core, but I really don't want to do it.

That doesn't help you either. As mentioned above, `device::Data` was supposed to
receive a callback (`DeviceRemoval`) from the underlying driver (platform_driver
in your case) on device detach to revoke the registration.

By using `Devres` instead, nothing changes semantically, but it makes the
resulting code cleaner.

> What else can be done ?

Think about what you want the lifetime of your cpufreq registration to be.

Currently, it seems you want to do both, bind it to probe() / remove(), in case
the driver is implemented as platform_driver, and to module_init() /
module_exit(), in case the device / driver model is bypassed.

> 
> -- 
> viresh
> 


