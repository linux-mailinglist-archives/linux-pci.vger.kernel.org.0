Return-Path: <linux-pci+bounces-30826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36322AEA7AF
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A06263A355C
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 20:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D3A2063F3;
	Thu, 26 Jun 2025 20:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLW4Tyho"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3C4203706;
	Thu, 26 Jun 2025 20:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750968264; cv=none; b=ixF5FcmmpiZezYRnGMqV0NH91+0DUKjQDPvTuHdwbrjORmLYgH+FK/82vIgUl5cjtAwrxP8epg0LcrwAGBTsBfSEbgWpm57rVOgEjQG5+DZQPQNEQDPeS/gDDm8jxe/tiU5z1g2rKy4ue7/b3wYgsyjT5MYPOqQdeW13YJ8KJF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750968264; c=relaxed/simple;
	bh=4TBsc6xhi+uYVOpE5Pcm2Y1YjnAXFNjO88XqrPPEayg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfWVs8GjeuUNJpXliS1/Qf2UAq9BvWN77BIneU5ELvsx809AodoG0vhAJzMIetWdTcZc8ahUUsb9e9u8JVJ0+cHfl+mM/YjI5s64hacIuB/ABYX0X4vOjKwlU88tZq4jvpE4Y7VIp67B6YVmvcsy7Ja85mKxaH+u+DIVZumZdz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLW4Tyho; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6fafaa60889so10894346d6.3;
        Thu, 26 Jun 2025 13:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750968262; x=1751573062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzA78hvTyN+FKpGbZL5udwfan1aXw4weKy0ixbiLeok=;
        b=aLW4TyhoW+sUGRBOAMLalqDawx+FVYv7hurCEKyUBjk+EVo+yiZfyAar9yCQe/kfpl
         MN/jqzJuvbOO+j1XwLiaMK5OctsE7g3UWAeoFP+9V+wnbxo6WXebI+HVbrELiQALCPzo
         yPMwF2D+oWKVyRbH4oplBkXw02ZP6t/PoLkvdXtNaIQLMOpRe6qzmHL+P28dNdW9CDOO
         QAwui+682HMQcnQEgFjc53Sp6BbHcqWC6KIblucY9a7eXRrGUtLwKgqBFwVWDW9R7jHK
         gsXG1rQbzhGq742PdmoX247EE6CoRmCISHapKKlevrB1a3lWu1BFIqs2QVtbZsmZbzRP
         2BVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750968262; x=1751573062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzA78hvTyN+FKpGbZL5udwfan1aXw4weKy0ixbiLeok=;
        b=w8dHlSWQuVhaaqlnCckgV5orzG2LTz+YJyQ0My+/PiWMf43Eh2f/p9MtxdWQi5UV7x
         nyxZKNr6E+hLBfc3/q9qfxR9oi+0OTwWwRT8WtSzr7esCfDJXOS97xvIWXdtDw2yye6x
         dLvrmU8RYSf1M7TOdCYWdOg1BVYSHQBXpbqrBTM8gxKcoP8iNomMT4sxqeeVlX4o6S6q
         EPWSZYl8lRMcyvwQkX4ot9hGYLDTbOM/rqOEcAIur+9tlwjKIK9I97XROG22Htvs5fuL
         FbBJGvNrkfs9aiDeqx7ybybRInPsXsHvSl2Fc4oAWKETWrV8TjgR0D3ig6k3RBl5bM75
         icBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/IyocM4xpuiUjt89yZ88+DRvjaNH4vLXuNBLdBO0V1zB2yKJLLuM+1Mq5G4StcaZKKNQDQeWAqr/LRc4=@vger.kernel.org, AJvYcCVAewcu5PAEWutjRwuWAV41odG+3PXb964I08cZ2c7+o5Qj9lj6DnJdhsCPLX5sLYUCTJ+7/NWgBcUx@vger.kernel.org, AJvYcCX1ey+7wi0DoGA8qvNW6ME1B+TPbTJiI7ghGC4zoCifN60UVyix1aIVIrK5bT9rS5K3gZhA9Gi2g6L6ET4B0Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9HyMC6N0u7NxiyFdRFvdmFOBybClamuU3QoGheO0bZgvctq9G
	hawQ/Fo6/jKmnDh9jEH6/RM3U/i09/BYkXpAhtAuy9U8/w9A3s295wfk
X-Gm-Gg: ASbGncuTiBJ0s2Dxd+R9ZIIgk3zYO7ouuyjV8ZmtOKLwwDZp5YDyzjYhbkJGkrSvf7x
	BdQfqw8TITAGoQ2LFMUum+/FLZOPJOrSC9riKHaKMFfEmCPoc7YAvZ93YwmMufCJ7aC3g6q50xS
	+htIACX5kydh0QMZSFWeMv1mn6gln9iq2zUlDxLKTfDCRatgIqLzWILFPYUIxyMm4PuYrTmhhRI
	JBBbf6wuAg8RSRb2csHaEWa42AElWg7yivFcpkZHP6XdTzsI5HKOWzJl/ny5LoE9/hLKcTuYOfr
	VjOOJe3w5wrkRMGBVp8+7Vqm9A/6eIQ9sUYq/9DmG3fJ+GAfJuCA1SvwIxdxziYIZyUdYbcaS2R
	9hFu6oe3Os5zVQ+1awZWxnhY8wcoSljNEGFzYo2+cpHJnH0EV3s4lISqBO8sZdWg=
X-Google-Smtp-Source: AGHT+IFNwrVIC+1OEDyjPamFRwTfRDnxZPff0Z2sSJNbE3rPuIG2Zc8hTYsLuGB/OMtkJ1TD/dbLpw==
X-Received: by 2002:a05:6214:2a84:b0:6fd:1b0f:8b93 with SMTP id 6a1803df08f44-7000233d740mr11774336d6.33.1750968261961;
        Thu, 26 Jun 2025 13:04:21 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd771d940asm11239256d6.46.2025.06.26.13.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 13:04:21 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id DC901F40067;
	Thu, 26 Jun 2025 16:04:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 26 Jun 2025 16:04:20 -0400
X-ME-Sender: <xms:xKddaPJsr_RqX8Yfz_iXH10d0gcMGnCW3nUgCT05eG3lQssEM4DCqA>
    <xme:xKddaDLroF1m5RuU5i_vx5V3HG9rma4_3Nebzta-f5RpH4YWLaLHMFUDFb2-9-iM4
    3h9s2glHJgYQb-ugw>
X-ME-Received: <xmr:xKddaHtoS5YwRcipcnn-rNFWksFwIei6m0Q27QWUOrT8V2ZWhBR7a68VUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffeivden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquh
    hnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudej
    jeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrd
    hnrghmvgdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlih
    hnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgr
    rhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhroh
    htohhnmhgrihhlrdgtohhmpdhrtghpthhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xKddaIZqQf7lfbUxHyOTpH36KUkE1QLWV3mHE4QtMmlPKD1Kqj4P0g>
    <xmx:xKddaGaDWqtkj8UygFk7V2ktF00YiIfHfdRCPUv2r6MPWtkzJhvtJw>
    <xmx:xKddaMAyhl6z0j_LcbAlpGkCoTw3bosGI9DH_SdDiyQ3FBX-ViVaGA>
    <xmx:xKddaEatWYzEWuRwodMdBddPXW0V-agMJGK7DDZoJU-FYwdCAbZudA>
    <xmx:xKddaKp3FM02k90Wsx6_DEdL6A3pCfU7T7yjciK01Kd7wSJoD4hKoJ6k>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jun 2025 16:04:20 -0400 (EDT)
Date: Thu, 26 Jun 2025 13:04:19 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, david.m.ertman@intel.com, ira.weiny@intel.com,
	leon@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 3/4] rust: devres: get rid of Devres' inner Arc
Message-ID: <aF2nwx6fRlhzbdsq@tardis.local>
References: <20250624215600.221167-1-dakr@kernel.org>
 <20250624215600.221167-4-dakr@kernel.org>
 <aFzI5L__OcB9hqdG@Mac.home>
 <aF2jxp51tvF6SpZR@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF2jxp51tvF6SpZR@cassiopeiae>

On Thu, Jun 26, 2025 at 09:47:18PM +0200, Danilo Krummrich wrote:
> On Wed, Jun 25, 2025 at 09:13:24PM -0700, Boqun Feng wrote:
> > On Tue, Jun 24, 2025 at 11:54:01PM +0200, Danilo Krummrich wrote:
> > `T` also need to be `Send` for `Devres<T>` to be `Sync` because that's
> > what `Revocable<T>` requires.
> 
> I think that's because of Revocable::revoke(), however you can't call
> Devres::revoke().

Well, what could happen is we create a `Arc<Devres<T>>` on one thread,
and because it's `Sync`, we can have a clone of it in another thread,
and if that's the last one call `Arc::drop()`, the `Revocable` will be
`revoke()`d in a different thread than it's created.

But with `T` always being `Send`, this is not a problem now.

Regards,
Boqun

> 
> > (Unless we want `T` always being `Send`
> > because of the issue I mentioned above)
> 
> Yes, we do.
> 
> > The rest looks good to me.
> 
> Great! :)

