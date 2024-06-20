Return-Path: <linux-pci+bounces-9008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C2391011A
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 12:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968821C20CF4
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 10:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6961A4F36;
	Thu, 20 Jun 2024 10:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ei2jqAh+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F902BAE2
	for <linux-pci@vger.kernel.org>; Thu, 20 Jun 2024 10:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718877961; cv=none; b=e9asc+jG22rmGSqIXUphhcYKsEFMBVNsfeN1NVJKYEaO+IPA6I/9/ZHlxrP5DIR8YAW7wVq57+45D4YI/+YrFYf/tFSbMxpMPvaAtzmNLQz/1RbDrrY0P+D3LcLyWxb18gPXZfxqo7WicPVzvX7s56DH9WLYFjjGMGC2x9pd3CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718877961; c=relaxed/simple;
	bh=eLn2BPyqwtOsU8OJXbiU6ccNFc9v0T0ok33O1jzeSrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSC+83HzA0qrV4+CTEirRfqvd8Tfz8zTXWKP6zQ8eVA0mx8bDSrzsGyWOBHoGc9Bwm5FopKAVuTTS1mk8rL+GusZnZu3u1irKiDWXq+I07Gi5Wy4H5L+HvyNdov2HJqBUAFYBLk8YDuQoveC3XVxWLNXcOZIXKjQUOWxReOyYPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ei2jqAh+; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70601bcfddcso675509b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 20 Jun 2024 03:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718877959; x=1719482759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NhWu1fk/lCmbQUjWXvQO3v9FYyNWP0Nqdx7mwhkHrbY=;
        b=ei2jqAh+Dw283azot3aTYueuA2c9WNYQRurx099Xo8IsQSZ8ebgJE8W2S1ZjIRfpLm
         t1tIZNHjywvOpY3z7wCXWciMoqjwLLpYlk+4sykm6YO3uNIwYhzQ4IHvgUw2yldjLK61
         KIX7sErrkHKsA7CtMXY68w5ZAFiCNk8up7F6Qj3ygCD0mGZACxooUWgNJxwmV+RdfTra
         kiRI3Q0rW3zdh1Ali9WPQgfYLvIfHmMXbi9+gnQGBQHrLfJE6vDqUkwILgcfvpeiuslW
         6Tsh4t0HsROVt5aBdZLAHJyHVKkW1ttZ9leoIM1kPJg5nSDcPZ0xxziWIl8cYu675X5c
         6pzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718877959; x=1719482759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhWu1fk/lCmbQUjWXvQO3v9FYyNWP0Nqdx7mwhkHrbY=;
        b=ldXBtVSZa29cwKMiJbgQdQb8FJlGUo3d4FdCeywcIEQ7D4dCRDhMhBMUbXnmJayT82
         3ANq6oR38z58eZWY6GALFUt7XZoP5xbLdFIwpZGDRvGeMN5OlNSzvJo3BLFOm7ShnQFZ
         T2WC5MM7YIBqCwnz8PPzrR9pXjkhyWziE62CtWCHO0ALGvtrYbLBfmvNruz27PFmjsFz
         WMSJ+65UawzxK8v/+/k1OUouWgYUlBHkcO/3QUzODas2pdjD/qMWD6RQsBiBP0NSQB67
         A6JOZsklgPXPuxDAVzfWWwgaHNgDL+fTdw6L3TXgxCNTrpUoLw1j/ONsgi5y5DOnlo8k
         zKVA==
X-Forwarded-Encrypted: i=1; AJvYcCUWVUjmoGgbYoGGlmhcc4y5rQrCV8GIqEQia9cuwITnDLjWnCm7Q2BoRmmXkxj0zmzm644hERhfDRKX/po7BsfDA0J48HNBe/K3
X-Gm-Message-State: AOJu0YyhGau5AaVqCkF/x++SUToBdjOHZLB7Dz6vLB0f2tgj9PMdF6p9
	hjjyF92eWt3rqSMO3UfBdVciCX1rzPIgtKlzMWNXAd7QKAeP9/waP5AacC+Ux1c=
X-Google-Smtp-Source: AGHT+IFCjK0hOvRoxLRcYP4hRKS/qRnuD1YRVk3loP8lgbZXBmRWqsOlKdxH+a0aQHsc5stH6MChIg==
X-Received: by 2002:aa7:9291:0:b0:706:337f:1ab7 with SMTP id d2e1a72fcca58-706337f1d69mr4258838b3a.34.1718877959125;
        Thu, 20 Jun 2024 03:05:59 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc91e0fbsm12080981b3a.9.2024.06.20.03.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:05:58 -0700 (PDT)
Date: Thu, 20 Jun 2024 15:35:56 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Danilo Krummrich <dakr@redhat.com>
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
Message-ID: <20240620100556.xsehtd7ii25rtn7k@vireshk-i7>
References: <20240618234025.15036-1-dakr@redhat.com>
 <20240619120407.o7qh6jlld76j5luu@vireshk-i7>
 <ZnLQxZjtsmDJb4I1@pollux>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnLQxZjtsmDJb4I1@pollux>

On 19-06-24, 14:36, Danilo Krummrich wrote:
> If you want to split `cpufreq::Registration` in `new()` and `register()`, you
> probably want to pass the registration object to `Devres` in `register()`
> instead.
> 
> However, I wouldn't recommend splitting it up (unless you absolutely have to),
> it's way cleaner (and probably less racy) if things are registered once the
> registration is created.

> The PCI abstraction did not need to change for that, since it uses the
> generalized `driver::Registration`, which is handled by the `Module` structure
> instead.
> 
> However, staging/dev also contains the `drm::drv::Registration` type [1], which
> in principle does the same thing as `cpufreq::Registration` just for a DRM
> device.
> 
> If you're looking for an example driver making use of this, please have a look
> at Nova [1].

Thanks for the pointers Danilo.

There is more to it now and I still don't know what's the best way
forward. :(

Devres will probably work well with the frameworks that provide a bus,
where a device and driver are matched and probe/remove are called.
Obviously Devres needs a struct device, whose probing/removal can
allocate/free resources.

The CPUFreq framework is a bit different. There is no bus, device or
driver there. The device for the framework is the CPU device, but we
don't (can't) really bind a struct driver to it. There are more layers
in the kernel which use the CPU devices directly, like cpuidle, etc.
And so the CPU device isn't really private to the cpufreq/cpuidle
frameworks.

Most of the cpufreq drivers register with the cpufreq core from their
module_init() function, and unregister from module_exit(). There is no
probe/remove() callbacks available. Some drivers though have a
platform device/driver model implemented over an imaginary platform
device, a hack implemented to get them working because of special
requirements (one of them is to allow defer probing to work). The
driver I am implementing, cpufreq-dt, also has one such platform
device which is created at runtime. But there will be others without a
platform device.

The point is that the Rust cpufreq core can't do the Devres stuff
itself and it can't expect a struct device to be made available to it
by the driver. Some cpufreq drivers will have a platform device, some
won't.

One way to make this whole work is to reintroduce the Data part, just
for cpufreq core, but I really don't want to do it. What else can be
done ?

-- 
viresh

