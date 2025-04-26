Return-Path: <linux-pci+bounces-26824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 073D5A9DC76
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 19:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF7B1BA2640
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 17:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F6D25C827;
	Sat, 26 Apr 2025 17:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghEXCXXu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BD512E7F;
	Sat, 26 Apr 2025 17:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745687834; cv=none; b=l9mIAU8P1tE8BW5mq4CHgFAsFq/G6do/V0eS6vdkhvBH1Hfy4pF7Qh/D5QS3i3Z6zOOa7GHOc2nNUEqz5D+9AP4I+/9+EVNJgMJ/r1wPOwaVj0Yrlz4Eo9zExifHG/ZWIsqgYQUjx32D7poLwAv7BEaV0gztuJ94iaYgqkifVtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745687834; c=relaxed/simple;
	bh=nINvgcfzpHYElTNd7krpvhje7yc2UERJjm+yLZZuE1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6gpSUZFvYYfRDzurXIMIzSG1M1qccuEmzTWUCE9weKgPBIDHHkq3TGBEj2IThUFDLUPJx75cRwsN/ZzArMfeWdiSDF6FODK1rvet/+imTt8V0ZGuLI69HK2qgnT0s7grWD5B/urCI7FIZMCtHcX5au/EoV6nfbAyOXeX3pXBhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghEXCXXu; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c5ba363f1aso518389885a.0;
        Sat, 26 Apr 2025 10:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745687832; x=1746292632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FFqTW8uAIertJpv4RCA6LRss01yImKxmL7LJL9+Ek8=;
        b=ghEXCXXuJ7bSwQWw35w70ijqNR2ETR4LhD7QBEBW7EerZzmHQDVcE1HBRi71z/7tZk
         ONNPL759ciirUFjnSdbLrToO7vg18dDJZiy5M3o9NMCWL9JVVS9ZeiUUP0EQeJjmeyna
         i9G1IzARtSO9ohC6unpHcXMpkoli1uLdTSi5KslT6c8Paf4DTsHwblK+KM2W3EDuiHC8
         hgcT0dBvWVIGttBaJoKsJp9+aRehT49sgW9MR1iGfvXMOfJAQeme39+U2k/L02MULvCU
         otuMue634W7Q5MQVIgii0hSg4Y0SAXYMBv4dSI5itWAqUBF9u43nZztrSKmZPrl8lWQC
         iKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745687832; x=1746292632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FFqTW8uAIertJpv4RCA6LRss01yImKxmL7LJL9+Ek8=;
        b=LwNa+XpvHwNBrM6SI6olRfjW1237LF//Xa+ICG3eCCG7KraN14BmA/2GUNSbMG0jdK
         OOVugAHTXg/ek9xKpai4h0B0DY2Ckx2RSdYxxmJmYLhVFNexLrPncse8fcmhLorYUKRC
         IIv/0Kt1pFhqgrQWFT/eHmerUAR69hN3K2gmKy36kSJmMXtQMKd+HR1l07ShTchgPWmP
         jBKK4kBm6G47ZzbkqEb8w/H89AIVYdEAltuC1PJoGnLJwc63x0HlrdZzLQCJwn61ULEc
         Ll0JFtDkAJ0DkpN0ZJ6mzgRBzQw4VNecovx96E6y+rVhNufW2cZILs3JGrp4Khc9SQz1
         dA1A==
X-Forwarded-Encrypted: i=1; AJvYcCUY60tkYrLQwtnKr1d4o1Cs8JGUKsbq4WTPIB+MKWhzn5V0sJs6rNEmVcZFVxxahcMaaBXQw2T+XMah0jE=@vger.kernel.org, AJvYcCVTiTQHDPpE98wOjHEmf+3BoUuXPCxr+nX2zBpH2S5YU07ptqtqAv3V4GWfJZEPpV9kz5MUuMNVRjWz@vger.kernel.org, AJvYcCXU36nft9jGXOi3acBb8nJPOc+YVooOW74Rj9juhk6vVVzzu0hS/b2FL8pGfSjFGyE+SG3SoOJSqE2fXh7RAPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQBVPwJ/kKwbULCobw2DGTtduPYy6dIJtjn20dpWbj66thsykX
	B5AIaVaarnuThLEWxRoTJ5IIUhPoCSPKeEPsZBQKgi18OdmIr7sO
X-Gm-Gg: ASbGncsizeVgRhGFbtVCO07x4tEfBpywU1yDOz2GerdEarnA3oY/g3+TYmSlzhi5nHd
	pG6wgLMPFhxz3S1qop6KmoxxR0aR2/YE8fSPziJSXtgX0o/+32zdezX0tO/TU9F/NeuK9sS+lZ6
	ZMVzk31a5sk3zpy/LKI+QBZtn11r3wy/bOuw3zB5Zoyx2MqL98qPtgy/y9PPQl8V9aDHOldtqzy
	ZIgNIrlsg77MkCoW4a7FLONSQ75ePElXqqwvdGS09XTpLnVMU7Pe5Rlwa7w6llPtm0bj9o9usCJ
	ANrVSoFMvHtWtxsBd++IWRE6q36yMcnZJMDYLVum0JtPkrZmJkkR/NUUKdB5P0FNTN7W40dDPHv
	8r5LztA4Emis27pYol12kir9sM8lWgKY=
X-Google-Smtp-Source: AGHT+IHTXBFJaGH+ZC7IM8wLyOrBGAcTKy/Kq7FhI0aesqYJnj5Jks42mBpF4DGJBuYJlTWCa31qEg==
X-Received: by 2002:a05:620a:4415:b0:7c5:6dc7:7e7c with SMTP id af79cd13be357-7c96687fce0mr476984685a.26.1745687831666;
        Sat, 26 Apr 2025 10:17:11 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958cbe3bfsm368292985a.33.2025.04.26.10.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 10:17:11 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9F0931200043;
	Sat, 26 Apr 2025 13:17:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sat, 26 Apr 2025 13:17:10 -0400
X-ME-Sender: <xms:FhUNaOtpiiYGhstIHGP6GeS0hjAN3Ct4uzqrU--8akuI4RZVsYeSvw>
    <xme:FhUNaDdXsnpRzCvvR7eohoeAC72wdT6ZGCK2nta9Q3GMnecaoPv2A825RAyslrVHv
    OaAvPiRUbOXfMYcvA>
X-ME-Received: <xmr:FhUNaJzkXoiLwklwKze3c3nUrqvzD4L6SE8qlbAJRf7-0QvgntYJ1SNH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheehjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfel
    leeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvdehpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhr
    tghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegshhgvlh
    hgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhifihhltgiihihnshhkihes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepiihhihifsehnvhhiughirgdrtghomhdprh
    gtphhtthhopegtjhhirgesnhhvihguihgrrdgtohhmpdhrtghpthhtohepjhhhuhgssggr
    rhgusehnvhhiughirgdrtghomhdprhgtphhtthhopegsshhkvghgghhssehnvhhiughirg
    drtghomh
X-ME-Proxy: <xmx:FhUNaJPqfp7CrwDhQuUXyqvPSNnmOjYbIoSAqUwcE0LnnbYsKLO7FA>
    <xmx:FhUNaO-2kXgtxLDZA6iuXUffeQeGBgfU5RSd84zswhyeum-VvYxfOw>
    <xmx:FhUNaBU6oKcCZGP0R1-vUmBQPPBzthDlL7uSoi7QoEw0RhB5PzgKOA>
    <xmx:FhUNaHcqYYcv4IFgQDivfJNz9a2se9-SnEykRLcUe5P_QOr3LkkKpg>
    <xmx:FhUNaIfL6lCsD3BDiXMsfen-QbfuNhJmG9jrr5crJgTx5uZfQh6cBJu7>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Apr 2025 13:17:10 -0400 (EDT)
Date: Sat, 26 Apr 2025 10:17:09 -0700
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
Message-ID: <aA0VFRtZmw1It0e2@Mac.home>
References: <20250426133254.61383-1-dakr@kernel.org>
 <aA0TU1Abvm3YxMgS@Mac.home>
 <aA0UjvxV7_VfbR1a@pollux>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aA0UjvxV7_VfbR1a@pollux>

On Sat, Apr 26, 2025 at 07:14:54PM +0200, Danilo Krummrich wrote:
> On Sat, Apr 26, 2025 at 10:09:39AM -0700, Boqun Feng wrote:
> > On Sat, Apr 26, 2025 at 03:30:38PM +0200, Danilo Krummrich wrote:
> > > This patch series implements a direct accessor for the data stored within
> > > a Devres container for cases where we can proof that we own a reference
> > > to a Device<Bound> (i.e. a bound device) of the same device that was used
> > > to create the corresponding Devres container.
> > > 
> > > Usually, when accessing the data stored within a Devres container, it is
> > > not clear whether the data has been revoked already due to the device
> > > being unbound and, hence, we have to try whether the access is possible
> > > and subsequently keep holding the RCU read lock for the duration of the
> > > access.
> > > 
> > > However, when we can proof that we hold a reference to Device<Bound>
> > > matching the device the Devres container has been created with, we can
> > > guarantee that the device is not unbound for the duration of the
> > > lifetime of the Device<Bound> reference and, hence, it is not possible
> > > for the data within the Devres container to be revoked.
> > > 
> > > Therefore, in this case, we can bypass the atomic check and the RCU read
> > > lock, which is a great optimization and simplification for drivers.
> > > 
> > 
> > Nice! However, IIUC, if the users use Devres::new() to create a `Devres`
> > , they will have a `Devres` they can revoke anytime, which means you can
> > still revoke the `Devres` even if the device is bound.
> 
> No, a user of Devres can't revoke the inner Revocable itself. A user can only
> drop the Devres instance, in which case the user also wouldn't be able to call
> access_with() anymore.
> 

Oh, right, because it's a `Devres` not `Revocable` in general.

> > Also if a `Devres` belongs to device A, but someone passes device B's
> > bound reference to `access_with()`, the compiler won't check for that,
> > and the `Devres` can be being revoked as the same, no? If so the
> > function is not safe.
> 
> Devres::access_with() compares the Device<Bound> parameter with its inner
> ARef<Device>, and just fails if they don't match.

I see, I missed that. Thanks!

Regards,
Boqun

