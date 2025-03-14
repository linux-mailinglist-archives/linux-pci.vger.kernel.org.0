Return-Path: <linux-pci+bounces-23773-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E439A61891
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 18:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E8B887196
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 17:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3663B204684;
	Fri, 14 Mar 2025 17:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heVTl5fY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3A82046B5;
	Fri, 14 Mar 2025 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974542; cv=none; b=Qs/jcs6/w+fCTRW21GgiB0KsRGpPPQXYn1r/ZXei96r9pKsTKBQ1OSaMo3iRPcjAzLq87a4GmWtqYoOr6Uz4XNAbXFCLf3+OPGPzMJMvPRar5OaBcGyx3JdvgebWUn7+wO2HaOHr/QLnJ21Z3H1bC81FyUFRbom7gPHkN7PDCcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974542; c=relaxed/simple;
	bh=5CX0PxqyCR/cXugcODKOqmcWv5REPQUfyw3SdDx6M1k=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUW+kLXCNp2O1B5Ve7O11H8L4NXyYIAxjz1Cay+dR3Uaiap/YShZI0Ah0kJSGQLDjCF5RtwXwB3pxYy7m0CDaHaxPkgxWeID4TEau+QH8XAAgDNOGsdUNkEwDnMZkBZFIwX8DkhWWsh87GCv2LT0QX8rfC7cIozHP3ueHZXmoO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heVTl5fY; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-476ab588f32so31956781cf.2;
        Fri, 14 Mar 2025 10:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741974539; x=1742579339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dixI4ahQHaRBhFTm9g6VyvYe7UeqgOMzNkhyZ63tKIg=;
        b=heVTl5fYLlEzRZnklLysYeGPTdBAscIh2i2ax6AYxN/y+g7Tu4fx4eYCTKvkbQm6tt
         F5ShxFTSALrcbw5Rf739Zbe6cB+/+Kwh8YLdffAP2qCaBIU6no3tohS5UnE6yVSgEvop
         tyQoqer+zieGfzMgt6geb5XWkfNOLVr3fKqkpDt8xmhVHUe7OmXMgTDmDbaFRp61DS1W
         xzwuRUoBeKBtFk1lv4OAwmz/Okp5Ee5+K8q4NIn+W62dycfriJLeTvScHSKTvOlP7Ek6
         UFNgOdOkTZKpL9s8Lym/BY5D7XuWr2ibSKq18bfEPL3Je9ULMCkXdwf3+1YfTvlR3MkW
         VciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741974539; x=1742579339;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dixI4ahQHaRBhFTm9g6VyvYe7UeqgOMzNkhyZ63tKIg=;
        b=mblNAhT8Zl+Rfg5eRtNNO/xtLHEpXB+fyzTTzPCMVLYX5gIha7iUKCfa3VR7cZEQMr
         pFeyORjBGqIgOikMdoJs1b6JhiuMvLGs4QMCeCq6R+9dwI6v26Eiy+f4R+BD9IvnO++X
         II4X5BF9+ZSIIrjzBMzvifsfejyiJHZuIp7380x4/sG2T7M64KgCiTk/od/4IPYmJJgS
         bVIj//hjuVKRMwgO9CMRRfLrgw2GgsrLTBTHgjPz/8lPwrVhskvocphg12F1qmndteuK
         YJuMRQ1YOc9p9FeCPfLRhg0WB65X3psZjatUDSEm1ibd8JSajluJEVZE1JYaFKPWcjSb
         gWXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuC8974j0a7/QoL06HpU1pJ4t/L1pQWUQIBXm6X0GKjv7z2acosadqvjUp+9n5XL8LohWjSxnU+CmhJHkWCds=@vger.kernel.org, AJvYcCWCz58AsWFarlyjhCadaNbrqnfPM56RCWcbeWn1r7xaJt1MtmVUyf1r1L8Qtu9zHQK0xMTtPnokPIbcD8k=@vger.kernel.org, AJvYcCX9TVLR2XVqs61LUK6KWpuVjiesTfYERsOR+MHSzQRa/hDm1NC0cbuZJ0QKI89qZ/Y32Y0kTp/G7OQR@vger.kernel.org
X-Gm-Message-State: AOJu0Yzul3feZ85EFZj7m7AXpRtTGrlGDr6tfnk4lA3mBbGw4Ur/YNs1
	/UppytlBFBnR27dTEGO1j8BMa7NncZEHJjR6R3MfuwLc4AdM3heu
X-Gm-Gg: ASbGncuIT9xKfkIXZn6TgZy2+cZFwrJJFUKq8m77kJ0k1zixGXLL0CC7kfp1iMRX8IA
	nnNzYUDJ7QF0GavyOxSafgAFyIqFthv98bZ72fIeIPahUvxabrnHEOrbdQwdYDigTm3z9pQBj31
	k4pBJiqx1rnNcy8LZVZUnPvBJwaJMG/ZObLxmUBysrzjO4vYCszktTlUPo8tu5qUOu5X0hNUJQt
	CrDBpMx9oaSfwsbzdExqH5nMSGyUxGrcHDRgIdllCPMyVz59RAuPlQPL2zqNB+DiANnxhsyM7eV
	jGjWvgRP4nZPAxKtQK3bUsgx9kxeL159ypYjz1jgVjhyKL7fpo2iN3Aklp11kasxo/R+7MkK8ce
	y+MYXAHlt6ARv85eOMITunfT1GWobMnHwZaE=
X-Google-Smtp-Source: AGHT+IETlmM8hWJT8cSsf7LOVEUlZOqkH94DgERsFKpZv0JEfHuxAU2VESE/j8yYxTqEvss5fhNolg==
X-Received: by 2002:a05:622a:5e8b:b0:472:6aa:d6be with SMTP id d75a77b69052e-476c8142d12mr44697011cf.17.1741974539224;
        Fri, 14 Mar 2025 10:48:59 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb82bf45sm25513721cf.75.2025.03.14.10.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 10:48:58 -0700 (PDT)
Message-ID: <67d46c0a.050a0220.30a410.8bef@mx.google.com>
X-Google-Original-Message-ID: <Z9RsBhMj01baL73W@winterfell.>
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6F3E21200043;
	Fri, 14 Mar 2025 13:48:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 14 Mar 2025 13:48:58 -0400
X-ME-Sender: <xms:CmzUZ7HmVt0brZLMe8VBEo-XzmQoPslQEmk5Dc-5jhFwR-GOUoI8PA>
    <xme:CmzUZ4VbZcLSxmf5xWrQthK1PCVg6__haumM21E2kTN7AeyuIUvZnaH0Z4Kn-xEkZ
    3gOj-OvGDHdHXNj9g>
X-ME-Received: <xmr:CmzUZ9LNXYHlBq3miiJBib3Lyt0gzVzlZ5s_2Wkq-x9z7Mb_HRMrLYeKeRY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedugeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfel
    leeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudeipdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhr
    tghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegshhgvlh
    hgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhn
    fegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegsvghnnhhordhloh
    hsshhinhesphhrohhtohhnrdhmvg
X-ME-Proxy: <xmx:CmzUZ5G6Vno3joXRmrPjeZMgbML9Ek7wmKPtIwtMHlbTk7-6zX567w>
    <xmx:CmzUZxV6e_q2vrDx0kaRMx-glG8tBhTNvpN5p23bVfYy3UtJR71zoQ>
    <xmx:CmzUZ0N1hNhPUEz602X6XTBrH8UqE-kT1jyeXrXmVUcte3hPF3zzGw>
    <xmx:CmzUZw2xIdjHIURlTexrvdx32T95ufawrOa_FZ3uCB2FlRgwbAbaVg>
    <xmx:CmzUZ2XdFtJnycZqmTYss5tEeHSu7IBcK-CpJaO-w5mQwASsbJCOLMnH>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 13:48:57 -0400 (EDT)
Date: Fri, 14 Mar 2025 10:48:54 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/4] rust: device: implement device context marker
References: <20250314160932.100165-1-dakr@kernel.org>
 <20250314160932.100165-3-dakr@kernel.org>
 <67d465bb.050a0220.d2e19.8fc9@mx.google.com>
 <Z9RoBMXWsrjg6jjg@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9RoBMXWsrjg6jjg@cassiopeiae>

On Fri, Mar 14, 2025 at 06:31:48PM +0100, Danilo Krummrich wrote:
> On Fri, Mar 14, 2025 at 10:21:58AM -0700, Boqun Feng wrote:
> > On Fri, Mar 14, 2025 at 05:09:05PM +0100, Danilo Krummrich wrote:
> > > Some bus device functions should only be called from bus callbacks,
> > > such as probe(), remove(), resume(), suspend(), etc.
> > > 
> > > To ensure this add device context marker structs, that can be used as
> > > generics for bus device implementations.
> > > 
> > > Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> > > Suggested-by: Benno Lossin <benno.lossin@proton.me>
> > 
> > Try chronological order for the tags? It was suggested first and then
> > reviewed.
> 
> Is that a thing? When I apply patches I usully keep ACKs, RBs and SOBs together
> at the bottom.

I don't think it's a hard requirement, but it makes logical sense to
order the tags except your own SoB based on chronological order when
re-submitting a new version IMO. It's in the same spirit of putting SoBs
in chronological when multiple people handle the patches.

But it's your choice, I just feel it's a bit odd in the current order
;-)

Regards,
Boqun

