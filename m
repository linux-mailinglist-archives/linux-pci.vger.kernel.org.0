Return-Path: <linux-pci+bounces-26821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27299A9DC69
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 19:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E8E3A7ACC
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 17:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5877325C816;
	Sat, 26 Apr 2025 17:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMMSzA9V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDFC256D;
	Sat, 26 Apr 2025 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745687386; cv=none; b=AEjy/jwuiSV2lliy0UOo3Ir4sK4wsfgvyBnJkf9Jv1x/AZjjOVXVqE5xr/u6AZDy767XcAjN7hAuLbMouTfL19fYuAypCtjpytvxBS5kGsuHTnlAcx1h8ekZ2YlcV3ARbEwLfk0MQzPG46GBLEoCl3jQ+ho3Zr3dxns3PfZb2Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745687386; c=relaxed/simple;
	bh=pR41C2n1CJlQvyUisUg92/Xmwdo8WFGO5Y5XieupmBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHHmlGbdcxjTCAtPrDBA/udR6oG39sr9OWcAfi4jw68FavRki1kQOQqROQecEf5eMsM2dXzopjGfbW3nldwvW4HEJAOTwvnIHOV7rtKdwCa7sac1yUtJ24O2cblaVJTixx85xxEXMmi1yY0rWN+y85oaNzxXe7Oa0Qi5O9XJakQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMMSzA9V; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-47690a4ec97so39885861cf.2;
        Sat, 26 Apr 2025 10:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745687383; x=1746292183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqOFcDLwhyw5z+vzHTyqS6iCPqOUxNKFwoTvn3szl3Q=;
        b=XMMSzA9Vg0nkt3p+gCxWGduOcWY7VhFDXrjmT7/lFcBGIm9l0d0fQMgXFko2o5gDE0
         OQgmSeT3O3zz74X1C/ePlmdpPxscJYc4rAbJ7DkY+LVBA7LZ2AUVeGp4Oyu+bX/j/o3b
         5Vqes8+Pu32v1n+JbGWaDtDFwZEoF7jn3LfFop+xUJcQNRsEvvZa8ROmVMqFgvN1cufj
         jLf5K//DNKAjbI2vHfChDc3W8A6w9gTI6KXr19sJhCQcDqrhjLQpY5kaBKIrGY4XY5Gz
         8wsPEUc8kzv/Vlyr4r3uWfHLOcT6bI9zNLteLGsFk/0babBZldgaoaAllKjhfi92E8G5
         n/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745687383; x=1746292183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqOFcDLwhyw5z+vzHTyqS6iCPqOUxNKFwoTvn3szl3Q=;
        b=ubZrCzCduOFswOb0AWN/7o/9s40tBdqs2ihAaqPeJZxgkG8GlPqm2h72P+wBqp/pFz
         6YI2AHYDWhdO88JOApuvQ3X2wvn6GKm4G7jGxlF+yzH+7YeU4l4jgRoPyETnv55os71x
         l+SML9QQKTzAwUv66LiHNXHDt/oFV8yxPZIsIiOCzKbYifz9TWSVZ6Q5vijHJjedXzjP
         oOstOrhVVMsdAh9XJaxDUmdC7hpA5ndYzY2/mCbEMy+MtTA9nVbxpBtScxpYb6S7XM6h
         uj89M8Qj42kyFWWx3FSPJ7aQFqKHk5FQfNacOcGH6Yj1alnDlaJxhqUTLDHH3eebBnks
         ji/g==
X-Forwarded-Encrypted: i=1; AJvYcCVFplvKmrwxlYVY5Np05NioiBCtjjkYxt7RXEsxrEfN1fHtsK7OeUItDxzii0a0M7cN1N3TMBRzt3ru/1s=@vger.kernel.org, AJvYcCVr0odkwcKzc2J5anCHRTe0EdiT6McPaBLz9Ja/pKnANchstqoMTbz/LgibU349k43gJ/medyGjZcM2ngF6Aoc=@vger.kernel.org, AJvYcCWTQuwKkQ4nVqdnpy0a4D8S1oU6I0RD0ZcwXAMigh8x6CWNUX23HrQLVBVPYAXy1FqwIqlzdbn+r4Y9@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvrd+9zojqn/EEiK9dl/cZq+fv0gzijGDk62CSYnDRWgXJ+mxl
	0SXPIiFcr7j782SPi9rUQuO2Dgy9LU3zPrCILB/eqfLho7SUQGo5
X-Gm-Gg: ASbGncshwcFwTejTaqZJMo+6czbGqfxjNhJrJNcK/Qttjq52rXoklBu647N4Edt1XhX
	OUX7YBrbz3tXEELWWlaFdJzlnbiv8K6GRScjeg64msdcAQUUmu+51xvXE4o7WrwU0NgQK6XeVlP
	4QlJsX/QckIQMOohYpBGY8AbWTEJGrdDGEz4jKF6KMoIyENOKQ7qgGjT2yRMBOcAenSp0qM3/MZ
	AT2PkjaBpgP1nVT4ctBI1yhKI5acaeAfP5gHpL+iMk7Q9kVhdAlhcELmqXCNIR1J4pcGqP7dQJ/
	qc6z/wffbYpMrK8Mvhib2syOg+UaKj6zRlItp4Iw0R7UOAt01FFkx8nNFHu5nUq8j9axwZXWXGe
	t7qePnHqGb9kkQvZGquIk68C1f3+CImQ=
X-Google-Smtp-Source: AGHT+IFUfcXfKXNceG5YDKqrbXatkaPfhhI8BWxAo9GiCns8i9lY558IU8Gz4FmTiK+y5XfvLqeonQ==
X-Received: by 2002:a05:622a:1889:b0:471:fdf5:3cd7 with SMTP id d75a77b69052e-48024a7f830mr94846631cf.37.1745687383354;
        Sat, 26 Apr 2025 10:09:43 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9f7a820esm41875291cf.41.2025.04.26.10.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 10:09:42 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 49F881200043;
	Sat, 26 Apr 2025 13:09:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sat, 26 Apr 2025 13:09:42 -0400
X-ME-Sender: <xms:VhMNaOGpolCt_OEOZXobFpHUwghKTGw-r5u9UPndVanliga6IQs2Ow>
    <xme:VhMNaPWWRHuA0AEeJgxvC58fQuDKAaPqLl0uweFA_Tju74ruzOuMmebzQpuYCTSiW
    QsS7racwHP52e405A>
X-ME-Received: <xmr:VhMNaIK8ELMVbFNl-TOvXHNIXVIcYqvC2yPEYEdJRhwhDD9ut5Tq7UvJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheehjeeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:VhMNaIF7OBA8hJDoj_jAfo6hiHIbSdJUCKYaF2pS5tDPjYBxtYo-wQ>
    <xmx:VhMNaEVAMpxu6cNfe6VpUig15s7HuNAa9wGmv2Yk39ZyD6hdB0DcUA>
    <xmx:VhMNaLP3pT22eaU67DPi-QqVFofZmMndY_hVLWW_U13SBA9vWpQq6g>
    <xmx:VhMNaL3a1mHYyxzG4Dh-iOY09ny5pRpJEJxrQJNnKTuqCWvS96_r5w>
    <xmx:VhMNaFW97UWu0KtnarvdltWHiSaiGe6Kp-_18sGHRigrokaQ_UHzSB2B>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Apr 2025 13:09:40 -0400 (EDT)
Date: Sat, 26 Apr 2025 10:09:39 -0700
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
Subject: Re: [PATCH 0/3] Devres optimization with bound devices
Message-ID: <aA0TU1Abvm3YxMgS@Mac.home>
References: <20250426133254.61383-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426133254.61383-1-dakr@kernel.org>

On Sat, Apr 26, 2025 at 03:30:38PM +0200, Danilo Krummrich wrote:
> This patch series implements a direct accessor for the data stored within
> a Devres container for cases where we can proof that we own a reference
> to a Device<Bound> (i.e. a bound device) of the same device that was used
> to create the corresponding Devres container.
> 
> Usually, when accessing the data stored within a Devres container, it is
> not clear whether the data has been revoked already due to the device
> being unbound and, hence, we have to try whether the access is possible
> and subsequently keep holding the RCU read lock for the duration of the
> access.
> 
> However, when we can proof that we hold a reference to Device<Bound>
> matching the device the Devres container has been created with, we can
> guarantee that the device is not unbound for the duration of the
> lifetime of the Device<Bound> reference and, hence, it is not possible
> for the data within the Devres container to be revoked.
> 
> Therefore, in this case, we can bypass the atomic check and the RCU read
> lock, which is a great optimization and simplification for drivers.
> 

Nice! However, IIUC, if the users use Devres::new() to create a `Devres`
, they will have a `Devres` they can revoke anytime, which means you can
still revoke the `Devres` even if the device is bound.

Also if a `Devres` belongs to device A, but someone passes device B's
bound reference to `access_with()`, the compiler won't check for that,
and the `Devres` can be being revoked as the same, no? If so the
function is not safe.

Regards,
Boqun

> The patches of this series are also available in [1].
> 
> [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/devres
> 
> Danilo Krummrich (3):
>   rust: revocable: implement Revocable::access()
>   rust: devres: implement Devres::access_with()
>   samples: rust: pci: take advantage of Devres::access_with()
> 
>  rust/kernel/devres.rs           | 35 +++++++++++++++++++++++++++++++++
>  rust/kernel/revocable.rs        | 12 +++++++++++
>  samples/rust/rust_driver_pci.rs | 12 +++++------
>  3 files changed, 53 insertions(+), 6 deletions(-)
> 
> 
> base-commit: b5cb47f81a2857d270cabbbb3a9feec0e483caed
> -- 
> 2.49.0
> 

