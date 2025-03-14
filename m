Return-Path: <linux-pci+bounces-23769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 528BDA6179D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 18:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9120616FCDE
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 17:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A4920469B;
	Fri, 14 Mar 2025 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+mVsdSe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A145204694;
	Fri, 14 Mar 2025 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973298; cv=none; b=sLZvrf0osTrAup9J+itHTl4vA4mRYZMggpygYm6Et2RupKqptvVm8vgWyds8v/giHhT2FojcK+Uhmn/eFEZVNSzA25WdPMGMJENGrxf2xLFiGKmw4IOLFspG3XmNxAsYCwMf/Q5aAICkjxyzYW5NZAkj5/7RnYEAqZ1WiX9QQUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973298; c=relaxed/simple;
	bh=mRc6Qzp+fDySnwvcYJlAcal8yjcDJzBh4K2OKc81DgM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTIeFkaVq+ltlVRQF3e3zSyw3BDaBFQyPvPz8s0w4Sr1yCD6BtXE9qY9G4+diRoc/+skcDnqGZe1vxhzBDhLfIaCjlGE7/6rpz1HTlKsqGfbidQT7LpC7eVawPUd4HhsYTDZ83hAT9HtfE0im1LQFqGWUR/aGTkZi7XnLw+xC1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+mVsdSe; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4767e969b94so36910151cf.2;
        Fri, 14 Mar 2025 10:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741973294; x=1742578094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJghd27vPBEu/LGbRtV6LiK050yXADXaFFga3GAq6fg=;
        b=Y+mVsdSeMacyBLhsWHNekr21R4AqDWskzSPb9c+YnmYW/4EEdZ8t0dBm0N4zPFQQXC
         NDpQWjxoDR82PW+SWormp7+d0N2BIgONMJzs2Z4+ENfmrxuB3bRTdsSU+XMD9DJTNRxQ
         2WZFadrb/wkGMFIh2EMkLcUY63yKNfIt0x4gS6Y6pQLpYZ/Jtzrl4jTAdOzQHeXP2ecG
         YDVshHlMhAxt18rJrMGEg6vbb7/804sP8HJD3Un30f8a+xMLpW8tNdg+6nSMIT02X0MU
         CoCaTJJaslRAXatJabKcoZ0H/CKekIJL0xbC2twyClJkceXWD7Z61/pL1jGsKsGdJA37
         aGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741973294; x=1742578094;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJghd27vPBEu/LGbRtV6LiK050yXADXaFFga3GAq6fg=;
        b=ONazWLH7+ukpOTCnCnPjONw9UkFT0j3lK3BQF797HkbcACkCnfNQvu2FN7svGS1FrJ
         /KHYWwiNCJHmEiA14FmigzOHeNy2rFLUV9aQWKx1xHaqzAHhhVC1lge7ltp8dpz5kNvT
         /1qgsomOwlAqxx5fmAL4/ttDcihAqXhF1ay4RC+7r20efk+oJ4y+nluJdSfrw4lJZPCo
         /AwGqOSrVpMP9YvuW0PIqKBowpFfhHwvnx3acsHycIHgQ6ljPHpnwaAzfWQjFbzJszHl
         7rtJS25sipA2cGZQsnQYryVN532tTxXOUTf5KnivaF4N6fU3xQB01iFa4krAee1ApVoE
         CZgA==
X-Forwarded-Encrypted: i=1; AJvYcCUv4X+7wuEMDuqKEEul4hbaYrFZtD2IQv8pBXKlIFbF4GszuEb6f1VE6KCrwwoGKBXLNXwuSbPhp+5ABJE=@vger.kernel.org, AJvYcCV49PDrHCJbDz9GM+mP2LwoNCoINmJub+E8n/f2cE24d1IByYe/8C1EpmEYCHesj6G/H5U2YDs493T1ki98OCQ=@vger.kernel.org, AJvYcCVshgStkbiPQypWRFrz1PuYtUQEdqGhkuqK0KokElVyYGhkHc20dHez1vlw0Ys9SzC7TvHL2i82v8xx@vger.kernel.org
X-Gm-Message-State: AOJu0YzZb7IxrU27cNcbKhjPyM1NWBZ5UixIzDoLEnsBzQrcRz3tHhb+
	EG7i8Dl6DcqSczQWQAEPXuPogTGTc7Sejcd263Ld6N58fnXFLiI/
X-Gm-Gg: ASbGncvT93Z83lTFzwc1uloXOQ5pqjH7uZhT3wVhZNJb4Y+b1yTHAh9Ai3ZYKXVJxab
	ZOSLgbZDCB7UtoSvQDfL2dFJnAoa+95mvcN63eRpD4NcO41B1jhNTEBe0qUCWYBwCw2e8XZ5oQn
	VihmdMoILht44hUeX4rnyFNoTaPNLPIxx8+tVDAoSe2lIVhs6StaIMDapNIi1RitsaACivbbS+q
	aiPPiJFMZxuWY4OHntZKQBXfGFOwtNcIOygF663HQgxHczNUJmlEtyp0Cy0jTMaddWl11jvjqMf
	lCi2EBiyBsqDc8u1ZrtPm4OaBOlNmJzTx1L+DVo6Y4rdiEp8ia3iocgOmtLeXKXzc81fcjga8GT
	D9+jBPL1fN7+Z6Se2uKK3xgLI8J1hm82F/0g=
X-Google-Smtp-Source: AGHT+IFYWh9NNAwSznb00n2bz+DizWEr9n7C6oGg7LjQgfQkMSaO5pJuBPli7Iv5c8DcDoF88oq7Rg==
X-Received: by 2002:a05:622a:180d:b0:476:6215:eaf7 with SMTP id d75a77b69052e-476c813f762mr51629721cf.19.1741973294000;
        Fri, 14 Mar 2025 10:28:14 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb63cb1csm25507461cf.19.2025.03.14.10.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 10:28:13 -0700 (PDT)
Message-ID: <67d4672d.c80a0220.68408.902a@mx.google.com>
X-Google-Original-Message-ID: <Z9RnKWBz92zhhAUc@winterfell.>
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 03E18120007F;
	Fri, 14 Mar 2025 13:28:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 14 Mar 2025 13:28:13 -0400
X-ME-Sender: <xms:LGfUZ3JSA28Qxtl7xetqlKDJhjjl6PMMIOGMkPEkIai3uM7cQjslKA>
    <xme:LGfUZ7KiimWhf9Br8rB0f8oLFStG7KPOhURRCVFwUFnxoJzn3XZWixoYBcUMIQEAI
    _hYkxfw626mRD-bTQ>
X-ME-Received: <xmr:LGfUZ_uJqxn_PdhwEwlCyW1g9i2aCtfjpi_dc6yF34Yfa_thOGQniwDwyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedugedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedv
    teehuddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhi
    nhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgi
    drghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihg
    uhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrd
    gtohhmpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgv
X-ME-Proxy: <xmx:LGfUZwauSC5jiRC3mPD-sOuRoIfdLg7bgzSsyL9IVgIEpnUHNIxdxQ>
    <xmx:LGfUZ-ZAF99Zrt_TgZFrXaeZzMki3pZ9naa2fQ8rKBofBajlnG2jDQ>
    <xmx:LGfUZ0DiI6pz7GVQFQiJv8-HSnoh-5tMf6P4CKYeDDHbJMa7Ky-3jg>
    <xmx:LGfUZ8ZmKjTZAA2robFGRsly6-MJoJ7IJvY8t2FEvXQG8WAcEUV7dA>
    <xmx:LGfUZypznMllDmytb7hJL-pn2gjxQNSYoPy2SwmjU66xUGeUN3QoIzWW>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 13:28:12 -0400 (EDT)
Date: Fri, 14 Mar 2025 10:28:09 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Improve soundness of bus device abstractions
References: <20250314160932.100165-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314160932.100165-1-dakr@kernel.org>

On Fri, Mar 14, 2025 at 05:09:03PM +0100, Danilo Krummrich wrote:
> Currently, when sharing references of bus devices (e.g. ARef<pci::Device>), we
> do not have a way to restrict which functions of a bus device can be called.
> 
> Consequently, it is possible to call all bus device functions concurrently from
> any context. This includes functions, which access fields of the (bus) device,
> which are not protected against concurrent access.
> 
> This is improved by applying an execution context to the bus device in form of a
> generic type.
> 
> For instance, the PCI device reference that is passed to probe() has the type
> pci::Device<Core>, which implements all functions that are only allowed to be
> called from bus callbacks.
> 
> The implementation for the default context (pci::Device) contains all functions
> that are safe to call from any context concurrently.
> 
> The context types can be extended as required, e.g. to limit availability  of
> certain (bus) device functions to probe().
> 
> A branch containing the patches can be found in [1].
> 
> [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/device
> 

Again,

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> Changes in v2:
>   - make `DeviceContext` trait sealed
>   - impl From<&pci::Device<device::Core>> for ARef<pci::Device>
>   - impl From<&platform::Device<device::Core>> for ARef<platform::Device>
>   - rebase onto v6.14-rc6
>   - apply RBs
> 
> Danilo Krummrich (4):
>   rust: pci: use to_result() in enable_device_mem()
>   rust: device: implement device context marker
>   rust: pci: fix unrestricted &mut pci::Device
>   rust: platform: fix unrestricted &mut platform::Device
> 
>  rust/kernel/device.rs                |  26 +++++
>  rust/kernel/pci.rs                   | 137 +++++++++++++++++----------
>  rust/kernel/platform.rs              |  95 +++++++++++++------
>  samples/rust/rust_driver_pci.rs      |   8 +-
>  samples/rust/rust_driver_platform.rs |  11 ++-
>  5 files changed, 187 insertions(+), 90 deletions(-)
> 
> 
> base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
> -- 
> 2.48.1
> 

