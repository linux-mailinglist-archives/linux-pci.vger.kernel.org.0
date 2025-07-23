Return-Path: <linux-pci+bounces-32827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5B4B0F777
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 17:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77040189A055
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 15:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FE81CCEE0;
	Wed, 23 Jul 2025 15:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhcgYZBO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DB8A95C;
	Wed, 23 Jul 2025 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285863; cv=none; b=QP52YjmkECNROOnNMJz/4xPSflmWLESEq/5McYWPrRn+Jymzh01y9JEOsBdig/O1mNYw0zt89JMztO30tG1pK6NrZgEzJvHq1oYjsnF0af8sLe7f5kC9WPILam+pLlx7jeBCVQJLLo//vlZHYekIu+oBv+kGdXj1lgQrOWg6AcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285863; c=relaxed/simple;
	bh=YiLtuvCCnDvKZeIdpHvMNIP0FqdoyAx4dWysjqnljW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQPGYF9KdUoSRL15N16WI8QJmlQs2/mVtClE1WxKfOpjelmaHpWGZjEJ7xBoiUnhxcCu5/zp9pJYZed5IQB6g8dCD6H0Wl8AvZmqewLgpa/XjWOuF7rhjrh0aWdWO56W3KfVggpAlnHtBlyhsE3b7NVqjWj8bjCF90bx6Cn6GTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhcgYZBO; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-70707b268b0so71896d6.0;
        Wed, 23 Jul 2025 08:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753285861; x=1753890661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXd2xVWa9eyoeLH+yVR++EAsVjqxH0vsrSH4AEs3bYk=;
        b=FhcgYZBOOijsRatdraHW2aO4qBtHagdmBNTz1dNLyjI3iTmwf+K7QeojgtRiPzGzC8
         ocD4Jv8EP3vZb8y3zXXn1LWHWoKOO7rdFRCWhbZakZRS1avMKwfhVDtNmQYlrbApEkFJ
         6aSyokMAIgTtUiGa62NR5W8GZhZDQWNhoyQbsEaBhK4uhOkZsItT2fceowJqfaZ13FCp
         reamZmeRqxj5cviDWVEK9xonbWTmYvr9HCmrVXAIzbA367oWh3zlGlJEhx3LNEJLwRvm
         TeNRVmZLYdtIQsPPTGzDhiOOM5I4OtWa+De4JB0csDSkCJARQZNwi6nwb3YKUDuT/Mr+
         Evrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753285861; x=1753890661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXd2xVWa9eyoeLH+yVR++EAsVjqxH0vsrSH4AEs3bYk=;
        b=cqrelupDYYz6CEf2L8tbsHd5Ou6d+XK7uKPMXeXrrpWPlH8t8eP2PpGVtJaPuFJkk4
         7/U2JYR5a+qlC6Dge7w6Kdkre6RcqyeNTWaFi6jhLHWd02swqDbMl96ogr1FeA7Rtxjt
         qFsc6UezxQXD3rfuYyZg5iurx0v0vNelaayyBYdE/NSXqvXb60a0DBAsoW2JglmsckZS
         KkPX1wGMtJPsiFHP7hZ1lEzJKys3u//6qoB3e9Mh+UvfB3qVBI8x2rKniFec7qfUWOns
         SZFKBxtnY6s5u2BlC0ZOOmMS/BgfBFkRff745FMTNQAt/SWq1UYpckMn6FHb+5pe4UfH
         C4Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVZm5KW3OP10wTFRL3nTBk+Vu5zCMeeqgPoCEVWdtlDueiM3O7Ma/dk6nx+IivIb58X4mrtyUIvjlOB@vger.kernel.org, AJvYcCX3OblOaJSf8MSYho6wz/BvXdMCYI9pdPp2vuSIoGp8ky4OQNZnSYly4RM76MgWSqJT0rcZFoIrbkihYiLaVzI=@vger.kernel.org, AJvYcCXq4rP285+Jt/AdKSQzWcNTqnvgYs8wWrv6vFuY8EsCC6wfxpAMsRYGZz4FE1+naPUbpUBTZLOC2rO724c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPGHv/y/fu3utZY93BdTqwBq069n/jAp/d8MH7E2x248Q0Hw8s
	QHKt2JIam3EPi5/esq/D0o/HTPZdcLA0pWA56W8jyPywKrIdqZAnwk2t
X-Gm-Gg: ASbGncuUww5DoHinusKTIt5kybnZDTrAENMzl1K4Mjhgky/Ih+ISRAW2bXNHyrkPv1P
	DOvwkK6zNLevmjALrWEPv5ODzC3z/OKDAwMjMuX7c1EXraxLBZP9onuDn5cqt7gIyviHbsAq6nb
	nG9OARJteVE9Lschv9tlrsPLr1V3Uyp8Tn9TyiNmT0bKxTkQF3YBIhD8hc2q8wZM5xDVBl3V1tM
	XjGPzrvMATMYBvLv5EaKoe89iLe1P7KAQUctIOSsflPU1uuteZfXNDiVd92JFWxCuBMhNorYIRB
	JAA9E7u2s5HzhaHPa8VKWjReqMeK4OO14ZLXMfr5IBgte70JW6FfRhwa1G1qZYbunVK1KeU6f67
	LqdkAjBqpgoYEP+nLx3nfs/2iJ5B9+KaQRAUBKFNNzG6zv17lD2l9c0PRsf0MR5DPoWtFYPU5TP
	8xLyfIQnbdO0YdCPY3Vd8tp1f2MjMLEjSvWQ==
X-Google-Smtp-Source: AGHT+IF1qXPEktdnsOq0BiObW3ERmS11Z3zVFLHUOVKehoJNmI5tle1nAoHwJv6ZuZ6RSXgIUF1tTQ==
X-Received: by 2002:a05:6214:2345:b0:704:8a24:7bb5 with SMTP id 6a1803df08f44-707005ffd0dmr43715186d6.11.1753285860759;
        Wed, 23 Jul 2025 08:51:00 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356cb9d0fsm660566185a.109.2025.07.23.08.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 08:51:00 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9F354F40069;
	Wed, 23 Jul 2025 11:50:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 23 Jul 2025 11:50:59 -0400
X-ME-Sender: <xms:4wSBaAeuxODtesynNkxQsoaRZAhfPsf6BWuiw7ruVZbJrdnGE7aHsA>
    <xme:4wSBaIxsMv7or_yTPoWfnQvANPuGYFsaEEjAnHI52VcrHH6JnaaL5HtPXclrUFErh
    cy0aZK0u4IH3rWjCQ>
X-ME-Received: <xmr:4wSBaDNd8RZav3fOgOzsIHUJ772nX9WzDHgOPGjFD5x8s6gEGWIkOP2dBcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkedukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepjeeihfdtuedvgedvtddufffggeefhefgtdeivdevveelvefhkeehffdtkeeihedv
    necuffhomhgrihhnpehruhhsthdqlhgrnhhgrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphht
    thhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnhhivghlrdgrlh
    hmvghiuggrsegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegs
    jhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegrrdhhih
    hnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlihgtvghrhihhlhes
    ghhoohhglhgvrdgtohhmpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuh
    dprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4wSBaPbSc3VOcFPge6T088XlFu4rHj2xuOd7_mTK9XB5HVMP1d_0PQ>
    <xmx:4wSBaNoOWAXa7qGqYMX2XDYsI9YsBh2eDms4vULd1g6LRa9FCzvfFg>
    <xmx:4wSBaEwjLTtNpBqo8HssUeWeRYjyB4sLV6jx6qlFYDDennZaxWuezQ>
    <xmx:4wSBaNIm0K4W7IaR232FnlpPc4yx2oyq9aKnxXOKa_k6VXkRgXHJ4A>
    <xmx:4wSBaO57ZYrv50hZML2Ggm08UZbuN4IidDsl8FDUpxPNT6477rbXC0aS>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 11:50:59 -0400 (EDT)
Date: Wed, 23 Jul 2025 08:50:57 -0700
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
Message-ID: <aIEE4Tt7xtaX-9V9@tardis-2.local>
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
 <20250715-topics-tyr-request_irq2-v7-3-d469c0f37c07@collabora.com>
 <aIBl6JPh4MQq-0gu@tardis-2.local>
 <ED19060D-265A-4DEF-A12B-3F5901BBF4F3@collabora.com>
 <aIDxFoQV_fRLjt3h@tardis-2.local>
 <95A7ACD9-8D0D-41FB-A0C0-691B699CBA17@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95A7ACD9-8D0D-41FB-A0C0-691B699CBA17@collabora.com>

On Wed, Jul 23, 2025 at 11:54:09AM -0300, Daniel Almeida wrote:
> 
> 
> > On 23 Jul 2025, at 11:26, Boqun Feng <boqun.feng@gmail.com> wrote:
> > 
> > On Wed, Jul 23, 2025 at 10:55:20AM -0300, Daniel Almeida wrote:
> >> Hi Boqun,
> >> 
> >> [...]
> >> 
> >>>> +        IrqRequest { dev, irq }
> >>>> +    }
> >>>> +
> >>>> +    /// Returns the IRQ number of an [`IrqRequest`].
> >>>> +    pub fn irq(&self) -> u32 {
> >>>> +        self.irq
> >>>> +    }
> >>>> +}
> >>>> +
> >>>> +/// A registration of an IRQ handler for a given IRQ line.
> >>>> +///
> >>>> +/// # Examples
> >>>> +///
> >>>> +/// The following is an example of using `Registration`. It uses a
> >>>> +/// [`AtomicU32`](core::sync::AtomicU32) to provide the interior mutability.
> >>> 
> >>> We are going to remove all usage of core::sync::Atomic* when the LKMM
> >>> atomics [1] land. You can probably use `Completion` here (handler does
> >>> complete_all(), and registration uses wait_for_completion()) because
> >>> `Completion` is irq-safe. And this brings my next comment..
> >> 
> >> How are completions equivalent to atomics? I am trying to highlight interior
> >> mutability in this example.
> >> 
> > 
> > Well, `Completion` also has interior mutability.
> > 
> >> Is the LKMM atomic series getting merged during the upcoming merge window? Because my
> >> understanding was that the IRQ series was ready to go in 6.17, pending a reply
> > 
> > Nope, it's likely to be in 6.18.
> > 
> >> from Thomas and some minor comments that have been mentioned in v7.
> >> 
> >> If the LKMM series is not ready yet, my proposal is to leave the
> >> Atomics->Completion change for a future patch (or really, to just use the new
> >> Atomic types introduced by your series, because again, I don't think Completion
> >> is the right thing to have there).
> >> 
> > 
> > Why? I can find a few examples that an irq handler does a
> > complete_all(), e.g. gpi_process_ch_ctrl_irq() in
> > drivers/dma/qcom/gpi.c. I think it's very normal for a driver thread to
> > use completions to wait for an irq to happen.
> > 
> > But sure, this and the handler pinned initializer thing is not a blocker
> > issue. However, I would like to see them resolved as soon as possible
> > once merged.
> > 
> > Regards,
> > Boqun
> > 
> >> 
> >> - Daniel
> 
> 
> Because it is not as explicit. The main thing we should be conveying to users
> here is how to get a &mut or otherwise mutate the data when running the
> handler. When people see AtomicU32, it's a quick jump to "I can make this work
> by using other locks, like SpinLockIrq". Completions hide this, IMHO.
> 

I understand your argument. However, I'm not sure the example of
`irq::Registration` is the right place to do this. On one hand, it's one
of the usage of interior mutability as you said, but on the other hand,
for people who are familiar with interior mutability, the difference
between `AtomicU32` and `Completion` is not that much. That's kinda my
argument why using `Completion` in the example here is fine.

Sounds reasonable?

> It's totally possible for someone to see this and say "ok, I can call
> complete() on this, but how can I mutate the data in some random T struct?",
> even though these are essentially the same thing from an interior mutability
> point of view.
> 

We probably better assume that interior mutability is commmon knowledge
or we could make an link to some documentation of interior mutability,
for example [1], in the documentation of `handler`. Not saying your
effort and consideration is not valid, but at the project level,
interior mutability should be widely acknowledged IMO.

[1]: https://doc.rust-lang.org/reference/interior-mutability.html

Regards,
Boqun

> -- Daniel
> 
> 

