Return-Path: <linux-pci+bounces-23767-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D37A61774
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 18:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73434201AE
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 17:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED031202F93;
	Fri, 14 Mar 2025 17:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1advImG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF16C1F957;
	Fri, 14 Mar 2025 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741972927; cv=none; b=Ae2z6rGniFYBvEs9Ge+UAqRx89GIMTranOPCdI4q6vKKrBpjY9jCSi7TRL8nVFfS5pbtwal2Chw4S6c+CYUSQSENo9SXQJIsdTOmZEyAmy9Q6IQJ5ELLU/yYpZQMimGu+ZBqa1j/WNT/lRUJSsemGR2Bn7j5BA0rcwCzZWrg1oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741972927; c=relaxed/simple;
	bh=Qpn+bG8c+G44s5nAxOQUaHI/oGNgdPaCr4Uit8/ENoA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dX7y8T2GsH4RCBbC56XMsGDq7Vq1UCwM1PvGEPdemoFIIX8ix1lzKE4JEm4Sn6eeH+eESea9jWO99WOKGVjOxD/+iccpZ/7r0KPumE5QVjw6/gUv9//5vPWC+rrOc1WIsIxOnmxLTNIRR4BYF2ZhXYhnHkvSSARVuf6OUSz5MDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1advImG; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8f7019422so21602636d6.1;
        Fri, 14 Mar 2025 10:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741972924; x=1742577724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDFqyRfHBs3Ib4nK9Y58mYUmJM70ZfAiHj75uNoA7S8=;
        b=J1advImG/gv5S8RC5gUndJ2ECejJsuydOmjUgOwrkc8d+x9sPjzP7eR0pV+c6PR37m
         Wi8K5XNL2cgbDk2Y+yqnj5VU6QiSQERB+F2IKx3mXJZSUH/FJUfA0DVsNPgumbnzPJg/
         nduCVSiAwSCB1MqWTFzEGYtA4KZUmc8JKZIZiFTwHF61TqBN2B484MD0oZ2OamDXHFTK
         ymMnAJ7rorH4yRAVfYAbvWFsE4URD6HRcv4q1toQCdzCbgzIhib49eTM1d5f7UpTpLSQ
         KyEtBtFzjTf+GrHzmsfGQG7SjeJFJhtnYepZ4HrJpeTGgepXiIst1LoFTbT2cdk3rcnz
         HXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741972924; x=1742577724;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDFqyRfHBs3Ib4nK9Y58mYUmJM70ZfAiHj75uNoA7S8=;
        b=kbk/je/0SFttq9vwsbwsNQjnIlhmTDlSEaMp7mNGdMZN5X/+t/nPZNGcCWZ+kh92FM
         txD6uQ/NwOHl5ahjz3F1rTlXmn3Yphg8gjVfpp3UkMvhTWBvkZ0trcz4tp+jPWXmWjzx
         2NTKe74/h8ji+g7eZxCSXwBte3Ujh5AU/SEcOf/5hTx0TJV6YOtjJwJhn/OnlbRBmenS
         5bcegJIXc1v8FlXqxowwCkTvESvwYnbb4oCzd8WR8bay7ZgX5yvMYO0ivDXeGpOeC40Z
         mf7XTj+KaFRzCDYZGh++KYv5YSU2VEBZe8b43SdbZyKl4687j5Y9sY1uUIV6RywpqVGS
         BKCg==
X-Forwarded-Encrypted: i=1; AJvYcCUVaNR4F9L0Fc8kmX7Y455PtDG17GDkoRrp0dP43vh9YxDFrTgcFDWXbxtDcojEJtbrTsjfA/h7kK75bI4dVbI=@vger.kernel.org, AJvYcCWplpmMFE3ClyQMoiM4NR9aGEVL4j+yRNA0bX8uSZ1HYmlCDiNoRwDKxf+v72UcHq33Pe74FW7hM+5f@vger.kernel.org, AJvYcCXf4D4EKKaD8iDtDtGuP9U/mXe5LDMmVZtYaEZ8nbGYCQsVabsKIyAF3RJ1jdwAZ+Fhz/JRnPaI7TYEl9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP7wcXHH6A2hdt0hcN5ilIUP7nNRFqQ1A0HCUOoORUm0Vpjqhj
	zVrpewuqKPBy5l6VoK2/TsfU5UnJrcyzDjX0/l3vUT7H5EZ2Kq4w
X-Gm-Gg: ASbGncszfpZlPPyf4onfx6TixPK8F90McIaty8Duq6LMWS1aW1jblUTEOcoAkzCzJwl
	TXqP34XD9LNlX7kuAf0huDT2Akrf3n+uowAO/vSaQ8n9fDazK77AW3HVl1pTHnL0qqb6NMQzC0o
	byybtTwkW0RWsjyIRvppiQxcPShGOjf6nkiHPxG1dmbHLvuBMzIdfU/ki9ykRFp948i3VD/DA/h
	+mS4JixZICutMaY1muUu68wra/QOmyMHQQcwtiE9HrZQr1I2RWGAWTC+vujNHUzG28NLCXiFnlY
	fimtNLZyc3w454qrbY8kmD2fgNf/8BWDFrrrUFXX51V33yG0BZn4ydXZ7+skFAy5+KW2Nt18T7R
	vz3SV3LvZY2o1es7HQ/Wo5zk5gRgu6bKgvdE=
X-Google-Smtp-Source: AGHT+IE8ZpnVMAoh7J89E4hudMbrOTDQrofqBxlvs7WuNYHLhrTqDEL38lotFkF54kgkqxWMDG9fCw==
X-Received: by 2002:ad4:5d6e:0:b0:6e8:9525:2ac3 with SMTP id 6a1803df08f44-6eaeaae55a0mr57080516d6.34.1741972923714;
        Fri, 14 Mar 2025 10:22:03 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade35028esm26333146d6.117.2025.03.14.10.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 10:22:03 -0700 (PDT)
Message-ID: <67d465bb.050a0220.d2e19.8fc9@mx.google.com>
X-Google-Original-Message-ID: <Z9RlthXHWX3QNM-k@winterfell.>
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 747BA1200080;
	Fri, 14 Mar 2025 13:22:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 14 Mar 2025 13:22:02 -0400
X-ME-Sender: <xms:umXUZ7oAYI9le-lq3ogI-CaxqVBb05c73XozlSpVwoKo_85dBuXPbw>
    <xme:umXUZ1qH9YuRENP3KQkhnGQtduHMyDzuqA9Tjx9Gku20WX9txluxls12dj2201Esk
    QrVBEYcNDquVo-Czg>
X-ME-Received: <xmr:umXUZ4PVffkgopzQGkIPzOdHUjF3wV26fY5_g06wPRqyKwhxVTrBaG6PoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedugeduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:umXUZ-4GD_w9fHPd3Bb4VRK37LD0oPa6uU6U-8WZzv8nLxwcxo50ug>
    <xmx:umXUZ66LS9YKI99zwsSV40eJTTZlpi5-g67SFnUkniu6wIlHNdNwqg>
    <xmx:umXUZ2hp90ZJW0Z7EzzknJnirQn1nJwnQzsJ-KjV63C36MhrhAm25Q>
    <xmx:umXUZ87iiE5d_5ZtffS5J76rSyb1SeD4bYz1vmH9pnTJuX3_4c61jg>
    <xmx:umXUZ5Jypi5F55RLUpsa49BNtRPyGzexARzlpvmYzjzrLlf_lQQg_yEO>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 13:22:01 -0400 (EDT)
Date: Fri, 14 Mar 2025 10:21:58 -0700
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
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314160932.100165-3-dakr@kernel.org>

On Fri, Mar 14, 2025 at 05:09:05PM +0100, Danilo Krummrich wrote:
> Some bus device functions should only be called from bus callbacks,
> such as probe(), remove(), resume(), suspend(), etc.
> 
> To ensure this add device context marker structs, that can be used as
> generics for bus device implementations.
> 
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Suggested-by: Benno Lossin <benno.lossin@proton.me>

Try chronological order for the tags? It was suggested first and then
reviewed.

Regards,
Boqun

> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/device.rs | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index db2d9658ba47..21b343a1dc4d 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -209,6 +209,32 @@ unsafe impl Send for Device {}
>  // synchronization in `struct device`.
>  unsafe impl Sync for Device {}
>  
> +/// Marker trait for the context of a bus specific device.
> +///
> +/// Some functions of a bus specific device should only be called from a certain context, i.e. bus
> +/// callbacks, such as `probe()`.
> +///
> +/// This is the marker trait for structures representing the context of a bus specific device.
> +pub trait DeviceContext: private::Sealed {}
> +
> +/// The [`Normal`] context is the context of a bus specific device when it is not an argument of
> +/// any bus callback.
> +pub struct Normal;
> +
> +/// The [`Core`] context is the context of a bus specific device when it is supplied as argument of
> +/// any of the bus callbacks, such as `probe()`.
> +pub struct Core;
> +
> +mod private {
> +    pub trait Sealed {}
> +
> +    impl Sealed for super::Core {}
> +    impl Sealed for super::Normal {}
> +}
> +
> +impl DeviceContext for Core {}
> +impl DeviceContext for Normal {}
> +
>  #[doc(hidden)]
>  #[macro_export]
>  macro_rules! dev_printk {
> -- 
> 2.48.1
> 

