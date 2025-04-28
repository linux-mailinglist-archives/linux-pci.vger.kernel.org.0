Return-Path: <linux-pci+bounces-26949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A710A9F78D
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 19:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46C71888516
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 17:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A390127CCD3;
	Mon, 28 Apr 2025 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkH1lf/X"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEE527A911;
	Mon, 28 Apr 2025 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745861963; cv=none; b=XJjkqA7mDsleLo8pGNXAoQRhagmvxywO6TUN7AW83ozC7ARTjby/5biF+JqJY4PpUYlMbBaxyfOvYLK2O+EMET3hjQfUkuOtezdoegWT0wAeg5khcJw9wI0AW2EPgOi0zOJWRNW2ldHZmx/ZFjSuvrQKBQzGhpFEpf1vbIDqo1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745861963; c=relaxed/simple;
	bh=fQMNSjnB4gVshimuVVYOR1fmCiWCDutclLSx2h4MeLc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smszF5hnSWEYuP7DzwUxLb+jvHVdwvoAPxKrXLjq3y4uIxz1jpmzesCMjfI6nZ9ng6xRENdnoHcuCi6kv7ta/dPnEQusE5/J58M3ZzQNbmVgh+FsfzUhiGNOL54ocvpsrJm9jty5w3D9f91y5ksBmQGcqC3o9YKWq7N0qEpbw+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkH1lf/X; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c08fc20194so1174305185a.2;
        Mon, 28 Apr 2025 10:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745861961; x=1746466761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDDLCOEVMpC0X/vw5gShRSSSgzF0jyB8R6+odx3QnJs=;
        b=IkH1lf/XzAp+1laraHickaotwFBDJJU1TZaDN2urkIE7gL+Cz9DNKGPtQAONqj+3eD
         2RiuVZyJix86JZRxq/kf5zipV9L6EwAARR27ewdjFiJ7/5wasjYLyk9RmgpRwXxurL7Z
         3xOcX3puXhcMfB5qJZP35ihCTKkTdkE3/YdTRMdvrJ+7wT58xuHYvI2yBT6hJ2RiarX0
         AbZu77HpZQOFJREJvwpfDQFv+5CzhWWi6cYdAqaiWDjXMhdD7pYnUR6kj1p7LjRimhVA
         uHhKA6fO8+mbl1W+jtVQ+rsiU8LIA/ruF6C01p2B08zW6gwBh86It6W8HcrYR5Mo4XXa
         hyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745861961; x=1746466761;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDDLCOEVMpC0X/vw5gShRSSSgzF0jyB8R6+odx3QnJs=;
        b=sYDM2BMzBu0Cp6LIcbOUgVxfKWBTUxnY7dBOI3enbs5nIOb4i7y1ofFzTzlZQKLK7p
         MB+PfXOXqztyJ8UHoiZkepMykPyLPEwS1esjlkaBM9vD5UJg3eftklE7DIossgC826iM
         UZFXMcHVG5WYMsQWlNFdo4recn82RusSjp2QpBdBSPtRv/QxyOk4CA/adfZApViQMMAj
         sZl9Etgodw9LWequHZpiZmiQpMYfvMgYOie6739sFdg7ZfBTM94yammsJ7Oe4sigCKsS
         8KYV5zIbYDcY+IBtlzSdLeZqeoqZlq6ZexnbH3f76XZspWHowvxOT2T1htluS6XQz5+o
         Divg==
X-Forwarded-Encrypted: i=1; AJvYcCUl0gmLnU3PiXy1BTlEuUSfmMoNZ9tGFxgBeV1CCC6C/GibR/lhnUbffmt0+KVyJuvKm79fvcr76a+8@vger.kernel.org, AJvYcCWim7TI8xvI1Pbd8x3Yhd9qx2PUmUeoVOKkgxGS7FYjtu4vGJpC35l2BSnfIeMsLQEWXHcmEgy4LEaGDBKekRk=@vger.kernel.org, AJvYcCXmKh9FFtJ2/H5ox0meODEauP5k2bXJTgXrKfm3vPKY4B8+rvm+jquv1xTbUj0JFRAHvQmPIEiPqO2wEsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbAR1hSET0T2fFTOWtH3gYuc6/OtA8Nx3CH3+5ZYjlLp6QtRvD
	k1zzNQt3Dq8iVzvRwfJ+hj+IgNzEyVhfl1QvGDIYOFSHToryl+9q
X-Gm-Gg: ASbGnctIXx6gkEK9K2PJJLgBuQ9wulVl6fO2VSunEJKSj20n7c7PtfM77SPIhEd+z+/
	FXHZ24SxslS5UhkiM7JOgjpyYJCilPNU0Cv2vsB/YYGDhS/K2GuAFBI1KqCm/UDjum1TdE5Ubqd
	GM1riivnOx0mygi6w5pCloGcHucNeWTdhakdEcVENsFeWrCCF4Kqhrry/winqeqqPEj8G188o1i
	Sz/WCIWn4WfVdTE24dEhTUAEUm2r1f/DEBik5Z7OqO3fiZDSNnvsflKfvFX6vmFpeCG6ZLgRtau
	By8JefcXWwb1FmJuq8R6upZrjbMbL/ltlnjMq9Y7lNA3Clz9HB0TayBjKXnjw9YiLLlIyGnJ7Rm
	xQ8Vr3ODDcm3ahFM2DUZcDHOmtyDcJEE=
X-Google-Smtp-Source: AGHT+IH8kUVfdao2rGXfuoDXWWd+N2vEWt284kqBnLyotdB5n1Qqi+nNZclc699xuoD5NGd26yVfmA==
X-Received: by 2002:a05:620a:1a22:b0:7c5:4f6f:3d13 with SMTP id af79cd13be357-7c9668bfd98mr1472535385a.42.1745861960497;
        Mon, 28 Apr 2025 10:39:20 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958ce3cf6sm647137585a.64.2025.04.28.10.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 10:39:20 -0700 (PDT)
Message-ID: <680fbd48.050a0220.398eb0.7d07@mx.google.com>
X-Google-Original-Message-ID: <aA-9RTcNkmsui4cG@winterfell.>
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1B2541200079;
	Mon, 28 Apr 2025 13:39:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 28 Apr 2025 13:39:19 -0400
X-ME-Sender: <xms:Rr0PaFQ5nGvbTV3pc3MjKAUTmfSu1BWWuBRdWVWFeA2oBZlsx7LkNQ>
    <xme:Rr0PaOz8ayYSoM4e2kF-qy7kb7JU3DceaKtadvJUbphE384YT07fC2gH6V3i9PfUi
    XJQ8WqWSWcJcw5R3w>
X-ME-Received: <xmr:Rr0PaK0QJyptFHZex5-3aOOoy8ypuPN1G0jhxm7SmaKRLe27AOohJffYvEo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieduheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedv
    teehuddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopedvhedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhi
    nhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehkfihilhgtiiihnhhskhhisehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopeiihhhifiesnhhvihguihgrrdgtohhmpdhrtghpthhtoheptghjihgrsehnvhhiughi
    rgdrtghomhdprhgtphhtthhopehjhhhusggsrghrugesnhhvihguihgrrdgtohhmpdhrtg
    hpthhtohepsghskhgvghhgshesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:R70PaNDz_LW0h2wuoWmqE7U-CpV10pVudlDlSwLihi0-bD9gqrJXFg>
    <xmx:R70PaOhzxB84pJLlzFYewW5qa44AEW4yf_sZTiu7bx_C8CgXK8nS0g>
    <xmx:R70PaBpmjpFPnNXMIXreU7sVnOqUn9hSparyilg2eDghC_f-0teTbQ>
    <xmx:R70PaJhm8gdWKE7YnxDg6g4xxmiTYpfxGO69BUr-vN_I9XxuhVYMWw>
    <xmx:R70PaJQLM5dX9cL2ndiyBe_Dha-fNEW0m70566vG9fKbbnAVtwuCagT4>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 13:39:18 -0400 (EDT)
Date: Mon, 28 Apr 2025 10:39:17 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	kwilczynski@kernel.org, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com,
	joelagnelf@nvidia.com, ttabi@nvidia.com, acourbot@nvidia.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Devres optimization with bound devices
References: <20250428140137.468709-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428140137.468709-1-dakr@kernel.org>

On Mon, Apr 28, 2025 at 04:00:26PM +0200, Danilo Krummrich wrote:
> This patch series implements a direct accessor for the data stored within
> a Devres container for cases where we can prove that we own a reference
> to a Device<Bound> (i.e. a bound device) of the same device that was used
> to create the corresponding Devres container.
> 
> Usually, when accessing the data stored within a Devres container, it is
> not clear whether the data has been revoked already due to the device
> being unbound and, hence, we have to try whether the access is possible
> and subsequently keep holding the RCU read lock for the duration of the
> access.
> 
> However, when we can prove that we hold a reference to Device<Bound>
> matching the device the Devres container has been created with, we can
> guarantee that the device is not unbound for the duration of the
> lifetime of the Device<Bound> reference and, hence, it is not possible
> for the data within the Devres container to be revoked.
> 
> Therefore, in this case, we can bypass the atomic check and the RCU read
> lock, which is a great optimization and simplification for drivers.
> 

Acked-by: Boqun Feng <boqun.feng@gmail.com>

You would need to, however, change the titles for patch #2 and #3
because there is no `Devres::access_with()` any more.

Regards,
Boqun

> The patches of this series are also available in [1].
> 
> [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/devres
> 
> Changes in v2:
>   - Revocable::access(): remvoe explicit lifetimes; don't refer to 'a in
>     the safety requirement
>   - Devres::access()
>     - rename Devres::access_with() to Devres::access()
>     - add missing '```' at the end of the example
>     - remove 's lifetime
>     - add # Errors section
> 
> Danilo Krummrich (3):
>   rust: revocable: implement Revocable::access()
>   rust: devres: implement Devres::access_with()
>   samples: rust: pci: take advantage of Devres::access_with()
> 
>  rust/kernel/devres.rs           | 38 +++++++++++++++++++++++++++++++++
>  rust/kernel/revocable.rs        | 12 +++++++++++
>  samples/rust/rust_driver_pci.rs | 12 +++++------
>  3 files changed, 56 insertions(+), 6 deletions(-)
> 
> 
> base-commit: 3be746ebc1e6e32f499a65afe405df9030153a63
> -- 
> 2.49.0
> 

