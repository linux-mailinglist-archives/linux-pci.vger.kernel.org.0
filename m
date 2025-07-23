Return-Path: <linux-pci+bounces-32780-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1BDB0E9DB
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 06:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F7777B33F1
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 04:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21852208994;
	Wed, 23 Jul 2025 04:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFpmlqr8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3971DE3C8;
	Wed, 23 Jul 2025 04:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753246660; cv=none; b=t+cIAObip+zNKgztXcIQPHie9Ljd38P8Ev5HCM4k8f4xVNf63LKrewWEdPHLkldt03tj39MsSwiLcXpLrSjyaaO7IsdfyNwnsYCbUR8/IvP8D7/qQxmGIhAo8GGT7n6mW7nYS2rW0Kn3IvtoZhXeBM22jFTXjP69zSGrklLHb5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753246660; c=relaxed/simple;
	bh=HjR3RcvpTtRqG8ETZGVE+pQ31GKFN/clrglW8LAsnkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSApGBKQlQqDcInknfUUcsh2XRd/vLkhtAkjGlsqXFlDvPMj8itNsqCge47CfArKZXvzT+0asTFulrk/Sokk5talI8HPUWsXJixqnuiyYIySn1pzXSXIx5BpJKVhxuHmUrmkwvBDHnEB17hPvIlsz7u41+87/17a7QLzmqFADQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFpmlqr8; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6fafd3cc8f9so79679866d6.3;
        Tue, 22 Jul 2025 21:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753246655; x=1753851455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gs73/yby1TmiWU1BiSU0mL8jDFmmGPnQM7fvFJVB9o8=;
        b=iFpmlqr80JSZBqhcFZjSTSavIf3JVvg8UgyX9b5tGWwigJxx2iXvSxa/z/1TDyXJfc
         KOcHz0Ny6Eb1J5UNALqH91x+bV/vjFjKdLOrx7ZIrvg6XiRzs+qDOmaNS6/m2b4Uj4iw
         QSsaUGeneCShJVKU9w+b0xsu3WILuGGR6E4ZX5wqKrBKpDnhdXH77P2hxdkPF9rPSphG
         As448V4KnM3Q4iym3/RlHPEPGkQBhyEthN0ebQuCknqZTmlMN2+PnJxMGdeJ1BMLC6Ey
         OJuAYlr1wFOt7yqhnr5oZnKSXv+m1DDxP1V8RM7CTynRxCHfX0+bSwsZLmjZaeW/m3Sq
         OwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753246655; x=1753851455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gs73/yby1TmiWU1BiSU0mL8jDFmmGPnQM7fvFJVB9o8=;
        b=V2o7D5qtjXWftVLTMn0y1oGDDKwhP5VTt0YeuMKXybROG8r9yJwzpkbhEGwGAUoIyR
         rks87iPS4jMnaGMPtft6kAG+GhdnrXLpuAKfkceeUllbo5YUcmSu7K6F1ts+8yoYlscp
         Pfzve0eCEOfSOkV0xOgwVxe+tUKX7665MQfwsw2TffyHd5aZ1md+rztMzzdEBkoIvazX
         kQX7AvuF5pJ3Gu1UdVOQBvp4SzBfOfuOoyH2JX+KbM2ctmp6bVPGO88U9CJ35uzfkaQ1
         VvIf74uO8jI1I5VQgPLi3XkxU2vxTq8Zq6mjg7Lks7OEsbqIU9eO/THg3Hvw7kadyAfx
         bmXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+bOEDztN5eLmUqV3myiXi9z2rgbHvR4GVwots1N9f2RSsSXRylQwBlIQ59eU3xkwIypdL9TetjxLMD5F/l8w=@vger.kernel.org, AJvYcCWdqZRFQnU8VowKY7gQdbnZh+ratnxyebID4nKUNOGOnHdQ7SyNBEDl7rGyrJLZjAYF8XIkdpTQvIZR@vger.kernel.org, AJvYcCWkNDIIhfmmNW8wfKy/Jlo8qeBK8Q8aE6Q0JqvnPz1jwWi8klSgluM3nNuCW4jGnoysQ2MsW5jBNi+8MDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwb3eYHZk3KlcdQYJmu+i1J0/0zubzmLQ0yTQzJotO8COXRkky
	GRthkFSX6Yz+wm+N1vMxscvCRezxkaMZATTHfpPO0uKoFA0b/+6MM1vb
X-Gm-Gg: ASbGncut+qUj6jl89suAC9jdn2OszC47EyBxo7oiTSjrDzZ+ldnicBViSolO6Rz/9DE
	iOP16HvZxtMOPXlpKA3d35AT+y6Z700/dbkyDJYKZWrWVFhMmudmfR7v7BBpnM9nqC2JUMKGO22
	EQPdTAtFIbDqmVdCsCO+2oJhiZRPDYvkiCHioIP204LcRFQO3kUjKClgjki7RgsTvwSyjm3OIib
	tt99nt/Bf1ZkdqTtLF9TUVBBrLQ4XjAN4dJ0uR2+MKQaGajysP2208w8tMlTIcKsXlK58kyNUCZ
	/exvkiD/kknTKXtmiGV/ygQw1CGY17yUBwRkYOkE6xXiI8m4kTmPy+Dxpjni252XiMQ3hPnvGjt
	AuU7rHenNVbP6JgmF1rwvPn0DSFZi78lXA0iONyGP5Dxkn2q4YL4euGVce6YUPrR9A/jwoDRMaY
	pQ17PX2V5YhkGMZ6IiHxywujQ=
X-Google-Smtp-Source: AGHT+IFhI0UAvNR1e5Edo1et03pwDyvSw2bFUBaKNd5jveq8PRhVethERoKTqzWHfgDfBGMN1yBxQA==
X-Received: by 2002:a05:6214:76e:b0:706:efd3:aabb with SMTP id 6a1803df08f44-707004ad00bmr22236706d6.6.1753246655021;
        Tue, 22 Jul 2025 21:57:35 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051ba91e48sm60606616d6.76.2025.07.22.21.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 21:57:34 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 15D8CF40066;
	Wed, 23 Jul 2025 00:57:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 23 Jul 2025 00:57:34 -0400
X-ME-Sender: <xms:vWuAaP_t7TsUpMTZpWzhysvoUwF02-T3PQ8gky00wkgrXv8rg2Xphg>
    <xme:vWuAaCrNGOYWVVkSUSjVUF_sIQ1JVvc4Q6Zs1r5GOFQtglVAS5uJYiQteytmLaIVB
    xZkBskwyLIug6gwgg>
X-ME-Received: <xmr:vWuAaCFpioFfWA8VGVpa-GycYjMeUSvIX5FBvaDR22nJlQ-frE-I07Na6Wc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejieekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepjeffgeeijedvtdfgkeekhfejgeejveeuudfgheeftdekffejtdelieeuhfdvfeeg
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
X-ME-Proxy: <xmx:vmuAaCmhhC8_chJZO1SZZWqzrTZ64ykOzBKS-7nv1oXvJDuLAW_ofQ>
    <xmx:vmuAaO9obp5ws9ls6pptqgTaWJCNztOCJPl0h8eaXiYgrzYNyjGvVA>
    <xmx:vmuAaDk_byKSBKb9zjj395mxupX2o_jA18P1nf_YtC_D7rKfiyxY_Q>
    <xmx:vmuAaMlpA4aOq5Ro--N2AqgJ0PRZwY43hKyKfdareASsxUJOSe7Cjw>
    <xmx:vmuAaHvvzc8So7FLNZapa7NUGr58iLsMxP1vw-B4PTB9trtn8FnE2TI1>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 00:57:33 -0400 (EDT)
Date: Tue, 22 Jul 2025 21:57:32 -0700
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
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kwilczynski@kernel.org>,
	Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
Message-ID: <aIBrvCebaQSCaQqZ@tardis-2.local>
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
 <20250715-topics-tyr-request_irq2-v7-3-d469c0f37c07@collabora.com>
 <aIBl6JPh4MQq-0gu@tardis-2.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIBl6JPh4MQq-0gu@tardis-2.local>

On Tue, Jul 22, 2025 at 09:32:40PM -0700, Boqun Feng wrote:
[...]
> > +/// A registration of an IRQ handler for a given IRQ line.
> > +///
> > +/// # Examples
> > +///
> > +/// The following is an example of using `Registration`. It uses a
> > +/// [`AtomicU32`](core::sync::AtomicU32) to provide the interior mutability.
> 
> We are going to remove all usage of core::sync::Atomic* when the LKMM
> atomics [1] land. You can probably use `Completion` here (handler does
> complete_all(), and registration uses wait_for_completion()) because
> `Completion` is irq-safe. And this brings my next comment..
> 

Missed the link:

[1]: https://lore.kernel.org/rust-for-linux/20250719030827.61357-1-boqun.feng@gmail.com/

Regards,
Boqun

[..]

