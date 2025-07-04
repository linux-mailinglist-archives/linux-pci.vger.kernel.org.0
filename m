Return-Path: <linux-pci+bounces-31546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DB5AF991B
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 18:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A44548070
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 16:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCE81A38F9;
	Fri,  4 Jul 2025 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgBkm2p3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747CA2D8362;
	Fri,  4 Jul 2025 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751647314; cv=none; b=MmBBvD4KU5wAQk9ewo7LliFSUCsdNXyJ/0UuZGEuIkJffFul7UDPN0pZgMF+O+jBqJQDGXQQ+PXSsYaWQqENgVIVuGDvzaOI81Ad7aIBTPrYsuFR829eWhbne9CpRQcymhqzgBbR0Y75K/5BHH0mLUpsnSfgSTb65RlczBfCf40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751647314; c=relaxed/simple;
	bh=kwRJznPR6BcIiAGHeBEbe0IFPo6eiiDX2nw/NSpaUUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pf78f881B2bAaMNK5pEPeQBj8CQgixzL6KKmZEYXycR/Ufn9xKZFCfqYOSkALRIensp4h45LX5fFAj5clWIQYzjLgHR4avLhLk/JE0Td1VBpY8diXxoQvxdZcCSJRlyGcU8tZl7oC7Jz+zikqJu/52aB28bYle6tx80+Ueb8MaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgBkm2p3; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a58ba6c945so15971851cf.2;
        Fri, 04 Jul 2025 09:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751647312; x=1752252112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m93ggs0equuJxK/njQ0NAI+Sfd41R6Vh2lHTcXlYRA0=;
        b=VgBkm2p3PkwxyZOwHxem0rsJhpk2jD5HvRC5r47D0hl/XeymsysSIDLgMRvlZz58rZ
         RmSWd3oDz1pyGShu4U2iSMvnQb2vHHRMg69HBVLeMjuPddp66GT6CRzmCZEv6hlVjdzZ
         MxcTJZXXOXPTpOf0v2BFcNXYJmU1Badu2yxlBvosWspVYtnM1u8/z2qYAg2UCBgs/Vg6
         7LsDbFwGdQJ8jG/yPgmnMYOp67haIZLhhXX0hJSOC6aMy+k4A8YhQXBX2r33TbEKYMFE
         uDOJyLPWejOr+CXKRHLrHX51yMFL5yRaWR6144Lq8ujOtGJkLgNIHWQ80EKTQFBqUCyV
         24Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751647312; x=1752252112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m93ggs0equuJxK/njQ0NAI+Sfd41R6Vh2lHTcXlYRA0=;
        b=gix7zkH6MB6ytKkzyfxxF+vXLFkWI7UsWt+tf7V/qirDYVBZSonkeCTzMAjIaJWNLh
         4xb/jvUbsyqSHuJQSrBH9erSREDEUakZJsJiA8RyM3DxTroiJRGW3mmtj1lxu3dZkh9q
         LD+d1tm7fIGz/Vr8gLykBPb5jf/hYeo/yat9hzuk6cF5l8ViXcMF1EeFP1YUcV2OO4zq
         fnnT5FEJ85m6V7qSga8R5jv88Y6MhTLVltnsP5RZ9mxztkUQ2VAquV9Mk6InhPADgaCe
         LPWOv6xGY2eaB8ysBmJig+RmHia+loyoBR2nhSl9cKo9RombGYBz+IV1G3czNN+zbBUb
         MUSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7aA58US1GYj2C+eEO2Lc024df5xAuWSYxQzbM+sphinAxZtzhhl/AhKBt4OBxQLGqwv9TA0DdysrT6b5l1Gs=@vger.kernel.org, AJvYcCVfeAFEv4gRvaQeFW5pU9CePkWIlA7K44UJ2sPmgZyI7liDTBsy6vLFnMcLKpPowXIpfDqTVwZfGw7VoJ4=@vger.kernel.org, AJvYcCWU05waEx9a0NY5yQfgvq0V99YPvbi/4q/UAbc2bXpdOzSRt6pY0IHw+gyD4XhI2IJwqXuPloGClh+/@vger.kernel.org
X-Gm-Message-State: AOJu0YxqkD1zNeI6wvox1acUnH8N6duE3iNCuSmOkrZZZKrRT6r0DkNN
	mpgajEd3gFvXSoYN9txB09iLuJq5aoktKRPaGq8bgkiWFSlVoyu1GpRR
X-Gm-Gg: ASbGnctesi6dszETq/nnRZMbSkh2xK3qE1WbkvLGnvCWNt8PLuiYV2H4bmG6VlfQNCL
	XpFgQ6NKmpQ887GzXpsmHlZaCGa0jap7MYl0/J6oIU1ihmE1pQBn93SfR2BFn95Z+JsK2ExG6Yu
	d2ftPHOb59EsDep3Jlq//AZykf5s9vT9QXQvMJELSAszPogTqjpSr2dUDxOKr09+G52nbVwwMOe
	K8TgGr69L45x2zGKM49JX++DrU5ghjvcGKthwJgCwV6vIzaJP+llt0rNcbRaHBy9GcfWZn2kTcN
	uR8kvdWzb5tIiE977jtYkif7v98NciP/b+oukUTy+omEQRiztkcGxiWjbOlOZgTPelGKpv5Dp1+
	idSMPYAEdauoiyp1Q25ZCsDOnlWR9OhiiULE5ck3U6tfh230mcoB0MFi18Ynm44s=
X-Google-Smtp-Source: AGHT+IEez5Yn5K1lwCm0IiawOAg5VQ727cDTSQh/PmsoXM7GtxMUs1prRu2UBrN8DxhgR5OQXts8uw==
X-Received: by 2002:ac8:7f49:0:b0:494:5805:c2b9 with SMTP id d75a77b69052e-4a996854acfmr51464411cf.31.1751647311905;
        Fri, 04 Jul 2025 09:41:51 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a994a78bf3sm16669691cf.52.2025.07.04.09.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 09:41:51 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id D4B5FF40069;
	Fri,  4 Jul 2025 12:41:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 04 Jul 2025 12:41:50 -0400
X-ME-Sender: <xms:TgRoaMW8n0fUATnF06HtLxkouSAumt22qfpVE5vBPx2Ja7uLaAeZGw>
    <xme:TgRoaAl6LibZBUbfSrDN__Q5KLuyVbe8gEEWzW7kZI8vgh4gHUoHTg7i1h4XJVB2N
    TTcYMuPX-2LQE_2MA>
X-ME-Received: <xmr:TgRoaAZkGklThrHHYBn3dUjeWoBLgyyvDSkcMph1HxU7m8y4Xp1pjWYuRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvfeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddvhedt
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    udelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghnihgvlhdrrghlmhgvih
    gurgestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhr
    nhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoheprgdrhhhinhgusg
    horhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehtmhhgrhhoshhssehumhhitghhrdgvughupdhrtg
    hpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:TgRoaLVmhYQnUVW8ZAY_MspMr8SQJE0uw4sSZFzoDJeiyN7u-SWkTw>
    <xmx:TgRoaGkdMyjIqNABZh2nRcEWgHx4JTkIx_Q509AWE45bEET4ScW3yQ>
    <xmx:TgRoaAd44rVp7xQJ-TO5pYAJhSjePUiyBB06C3rufsFDc0GwRms0yQ>
    <xmx:TgRoaIH2VBTIirRGRFeURchS85u-3Kfa29nlw70KAC9IbGIqYC-EiA>
    <xmx:TgRoaMmnQSMgOTwVnjLsbu2KonqnuwIa2V84hLL93sjjoj0zusNQNOqj>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Jul 2025 12:41:50 -0400 (EDT)
Date: Fri, 4 Jul 2025 09:41:49 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Benno Lossin <lossin@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kwilczynski@kernel.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
Message-ID: <aGgETV_-MgEiZDHC@Mac.home>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
 <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com>
 <aGgDpWkU6xAn5IFN@Mac.home>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGgDpWkU6xAn5IFN@Mac.home>

On Fri, Jul 04, 2025 at 09:39:01AM -0700, Boqun Feng wrote:
> On Thu, Jul 03, 2025 at 04:30:01PM -0300, Daniel Almeida wrote:
> [...]
> > +#[pin_data]
> > +pub struct Registration<T: Handler + 'static> {
> > +    #[pin]
> > +    inner: Devres<RegistrationInner>,
> > +
> > +    #[pin]
> > +    handler: T,
> 
> IIRC, as a certain point, we want this to be a `UnsafePinned<T>`, is
> that requirement gone or we still need that but 1) `UnsafePinned` is not
> available and 2) we can rely on the whole struct being !Unpin for the
> address stability temporarily?
> 
> I think it was not a problem until we switched to `try_pin_init!()`
> instead of `pin_init_from_closure()` because we then had to pass the
> address of `handler` instead of the whole struct.
> 
> Since we certainly want to use `try_pin_init!()` and we certainly will
> have `UnsafePinned`, I think we should just keep this as it is for now,

Of course the assumption is we want to it in before `UnsafePinned` ;-)
Alternatively we can do what `Devres` did:

	https://lore.kernel.org/rust-for-linux/20250626200054.243480-4-dakr@kernel.org/

using an `Opaque` and manually drop for now.

Regards,
Boqun

> and add a TODO so that we can clean it up later when we have
> `UnsafePinned`?
> 
> Thoughts?
> 
> Regards,
> Boqun

