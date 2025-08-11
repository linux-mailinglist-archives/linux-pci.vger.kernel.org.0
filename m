Return-Path: <linux-pci+bounces-33774-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CCFB212EE
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 19:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99FC3621456
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 17:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E6D482FF;
	Mon, 11 Aug 2025 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsSHFWlf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24052D3A74;
	Mon, 11 Aug 2025 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754932295; cv=none; b=U1PjLRTfJl5uMYz84OPw7pKV/uEZnBUawKIswzCTo62zvsuPm72BhjE0IZutTov48xq3UtmTiKd84WPe/Vic1C58oJcYF7pPLdkO1GIptWk6KcOY6d3tZ4unkPk92m8ZayjQGrhLF/5uqzi9Ivxemn+m2MIUyh5Q3iLEm4eWDdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754932295; c=relaxed/simple;
	bh=wVc7rtdKgh4ftRY8mKK68u8nLHsymZqndxQw+3zFRFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZXcs6bYHFxxMgpZLgJu51EaXM2U3nw9M4DLGqBbUNpawQQw3sgRpX/rcplfhxP0NrhzWAxfebALNOHHRvNNqYnUP4olAI4VRqR+PCSfG8puYJsC7cMBfB6CCabtsWsNH9G31cKGrZcPh4ajFhaOtQHYjnsoeWCxoGlpKQTqEbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsSHFWlf; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70736b2ea12so23688166d6.1;
        Mon, 11 Aug 2025 10:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754932292; x=1755537092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEh+hVLSwc8F1JBvdb8QBbaUWYY2ob9KADUt5QO1TRk=;
        b=DsSHFWlfqpKHIvFulNs60hhj0qgTPrseLqbM3v+M0s6jXmx1B3Oa9L/InFGoooO01v
         eavOaIXBhesioBUl4IEqbQ3HT31pY2f1j5bgdjpEwnbvgiYGXA0jzOjtzH1D/ub0UHWK
         RjodAMLlnOFQyJUmLcBvKpjUbSee3nxfEQpCmMVolaIr3A0af4v8LLvOv01FXpfRvke9
         9/J468E4FtgXCXI8BYZsZp3ysvSCOVzJ14FtoM/zxEcKtSWJNW0rRXGWBQADgS6qBeb8
         ZvZq3thQT2ZLq8DWTkQUHGz1Mbydm2B2yz4z52+wsQJ4SkJDvft+lFVIt+B2KppJuPp/
         hEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754932292; x=1755537092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEh+hVLSwc8F1JBvdb8QBbaUWYY2ob9KADUt5QO1TRk=;
        b=YgWxeDGFV8AIXkMxVJPvIcahhJp9a440vKHN2qYI8zQMYNH2sU5qR89j57/kuujyvT
         Jr3tzaa0crxwRFt4KVlLpk4dB66wwVwjxwSv0Av0uUk52hZh5olpJMBGUGkqgl+I3owo
         F9SgSvbPsPg/r7AWN9DWuNIkomBG78VBtZbZlK7iEkSY9R9bCQNo0HQ75V/jef7mFs5q
         xWE/jLzmQn/zpEBT/O94sHRkoeQYnJcjG0OPM0rt5dib27ao0PJQty3vmOIBfdGPGrWs
         cjztqnWKxZCp+sVj/tpzlrz0GmIHGi5y/c/8iSwfvo3QeKkO4rTJrd14FfCf2GGIJ4LN
         c4EA==
X-Forwarded-Encrypted: i=1; AJvYcCUjWSzM0OosqZyKsQQPlVy2YjBs7n+Zbu4SyVLeZhNu8w/I83g1LOo4dXAq2buCoWJQMNQ1K60Snw8M@vger.kernel.org, AJvYcCUoK9+mkSlq4zH6T7/S5RnkmgmMEvzXwlY/81mPFDLocykLZfZ951rwQzvmLuGso0mMThpsoxebZBU5UPoAgBo=@vger.kernel.org, AJvYcCW0Z7khO8rbCvLyuV4OlrBfAQVvp+ZpPWwJEZsMgZ5Gw1XIRfU8frNxhjaXr2H4pjiqdvriWwMi2dObk0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfcAskmm6g+i/QplUDZZrjpYx+pqAINk6xfG/ocuJBz4sUoDzT
	yeTU+8VJWtHmuA5O3hu516jpio+5Pnd4Dzkz4a52gS9GJbfJqclM5+Sm
X-Gm-Gg: ASbGnctnO8fMBHQ5SRiREH2czPJ9oGzos/WOny5/4QiInbBJi4PHLuCACaOqgIDb+UN
	T8cxOzPIYcY/nxnGZNgPURXm67LNro7qpmdc3+DhxztnAOlqzU/fRWKHFl04J2DWhwxuPp3JQXs
	AOI3MXTj14Y0fDsb1kYIRZGt4A1csnN2sCjNpBNMuCpkc1BYlKKszFkt+3tkI0gSae8/KFc3cGr
	H12zcpeSw0/vwi4JMacv7tZj8H31ipPZ+3yrAE2BJbXQ1kqbm+W+azkrqIDU/OwRmAgOezE8bGm
	wRtfKoIP7T4Uwyo5KgrmLj8vZeVF8MlPBnVunsuFpcyjltUwauWWE0XvGNHcWjOHKZgAcQy7fPY
	dYtbPBHz1WEgpCimcyLpxGCRRrPbrcZC8+NFoE+x7g/WY4ZAUkKUsZ1hlPw2LxgKgw33PvjjE4i
	8/p8HL7PJahy0dFzCY5m8LC12gY5FMGbgCSQ==
X-Google-Smtp-Source: AGHT+IFaL0mWhUrWhMfjB0nn3eILU1Iot3PDvHyYKBmQhv3IrFEoymjnGL3Y/0LvSvp+MZKa+8g8gg==
X-Received: by 2002:a05:6214:dc6:b0:702:d655:f4e9 with SMTP id 6a1803df08f44-7099a2c5410mr159359536d6.18.1754932292183;
        Mon, 11 Aug 2025 10:11:32 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ce39fb3sm158033296d6.82.2025.08.11.10.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 10:11:31 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 11C29F40068;
	Mon, 11 Aug 2025 13:11:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 11 Aug 2025 13:11:31 -0400
X-ME-Sender: <xms:QiSaaFgUhH2okCVIM3lJFIaxNTlRGcsE1rqdTQ9zhPJBnVIMNPdA5g>
    <xme:QiSaaAnDSUJNnNFqpyD5qkszOzkoqjSbpSffkCzIG6g0GtrpEVxjyw_Wx86pbqKar
    Oib-VnBNNpl0O02Yw>
X-ME-Received: <xmr:QiSaaGx-0S3OgGmQAHf6MMZgSMAoxbQ_fNiP4Sc07Q_Lx51ixTN_pNZ2fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeeftddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffei
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepudelpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegurghnihgvlhdrrghlmhgvihgurgestgholhhlrggsohhrrgdrtghomhdprh
    gtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidr
    ghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguh
    hordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgt
    ohhmpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehtmhhg
    rhhoshhssehumhhitghhrdgvughupdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:QiSaaDsuR59-eXq4fNYQ0iiFPG22mp3OImHuCqtZhCOQChUEUFPXmw>
    <xmx:QySaaDvp8bEe118GZ3zAvHhh7arN4DxuQsveCx3SPXxNjzWJEHnUxw>
    <xmx:QySaaJlETmKFcoZic2H0cXHsljJ59qJZVZK_zN2KlKSWlWt7FOhImQ>
    <xmx:QySaaJuC0pRItfR8WSLcRdNBwDfaWxA0KaW7vEQUZNRCzJYpDqq_qA>
    <xmx:QySaaIMmKYPp9nHCjlzAZ90N9R1dQLrxAvfjJBK2JZEOgBj7vzqsTiw_>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 13:11:30 -0400 (EDT)
Date: Mon, 11 Aug 2025 10:11:29 -0700
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
Subject: Re: [PATCH v9 7/7] rust: irq: add &Device<Bound> argument to irq
 callbacks
Message-ID: <aJokQTM97xBMXxVo@Mac.home>
References: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com>
 <20250811-topics-tyr-request_irq2-v9-7-0485dcd9bcbf@collabora.com>
 <32B71539-BF90-4815-9085-2963F5DD69B5@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32B71539-BF90-4815-9085-2963F5DD69B5@collabora.com>

On Mon, Aug 11, 2025 at 02:00:47PM -0300, Daniel Almeida wrote:
> 
> 
> > On 11 Aug 2025, at 13:03, Daniel Almeida <daniel.almeida@collabora.com> wrote:
> > 
> > From: Alice Ryhl <aliceryhl@google.com>
> > 
> > When working with a bus device, many operations are only possible while
> > the device is still bound. The &Device<Bound> type represents a proof in
> > the type system that you are in a scope where the device is guaranteed
> > to still be bound. Since we deregister irq callbacks when unbinding a
> > device, if an irq callback is running, that implies that the device has
> > not yet been unbound.
> > 
> > To allow drivers to take advantage of that, add an additional argument
> > to irq callbacks.
> > 
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> 
> Sorry. I forgot to add my SOB here.
> 
> 
> Perhaps this can be added when the patch is being applied in order to cut down on the
> number of versions, and therefore avoid the extra noise? Otherwise let me know.
> 

I think it's fine to submit with only Alice's SoB, my understanding is
that you won't necessarily need to add your SoB if you are simply
re-submitting a patch (with minor changes). There are changes where your
SoB is needed: 1) you change the code significantly, in which case, you
may also need to add "Co-Developed-by" for Alice as well; 2) you're
submitting the patch as a maintainer, and you have queued that patch
already somewhere in your tree, in this case SoB shows how the patch
flows around. Of course, either case it's better to sync with Alice
first, which I believe you have already done that.

While I'm at it,

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> 
> 

