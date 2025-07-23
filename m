Return-Path: <linux-pci+bounces-32818-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFE5B0F53E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 16:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44652AC0E0C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 14:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4702EF2B2;
	Wed, 23 Jul 2025 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CB8pn/gA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12052D9EDC;
	Wed, 23 Jul 2025 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753280796; cv=none; b=RxqFmNMklLK+5A6vmqAGGvX8Di/UCeS+qhabEmRzwr0UM7q/Ak2VRoeMO/zouT5PQKMF4MwoLWx8BXGWvrlrk+XRyATcVryxIpbZIjkfktDUQTTgd7Gj4NlvioUiFau4cftn+lExWkkMrhh3z3wr0krKNKZyTC6doIEcJ4HYRVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753280796; c=relaxed/simple;
	bh=u5kcz7+z11ZecDw4BOO0cuxQi4nShrexRctLR1fj8sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTuHRwvWiZ6DUrpYYxOU9GMdpMBHY+9VGkwne3YRguUgeg+Ou3BcVUzCWKCqEAxStytUA7OPtx+FWB+hqZg2hAXZi1vKsiJNjipfiIxYrJ/d3/j8d+cYiYB2wrCsYtrzCV9HvBUNT2SbVSx7uRFoxMAoY/c2Sz/EeYK9ehJmnkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CB8pn/gA; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e33d36491dso921431685a.3;
        Wed, 23 Jul 2025 07:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753280794; x=1753885594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2o2EjZkq+kx8CAy5J/9DD0iXT5RJwEkXNP+TIRG9l2g=;
        b=CB8pn/gAL4GI4chCTzDqMUq/ZsZXjjy6Ah2mdQ7XkMz/ZYrHRp+T9o9ArvQbCvWa8E
         RRIdENLGdvmP4nYSbWVE+dzZjF8STLCsTsILDHsYrTY2tA1eOPNi0axXBoCQxNR/jfWv
         +S0X1EV48Q7qLSxRK0HYg5Pt3SZYubi4ILXVrCkW+nzZUZ/GdKWmDN+2isHEtL/hkgsF
         sSaMYdSxT0cz+oFT7iSJuTaRXbK2NmzoOB+7TwxqE4sqUglGBCp5125Q4SQmtx9oMtqv
         DawwgZO+yw8QAXprS2v+xVvzWy6Dxlwv/k/IeOAI4sIDSXEGMZXxZhLMFjFPSNxgDiOC
         YSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753280794; x=1753885594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2o2EjZkq+kx8CAy5J/9DD0iXT5RJwEkXNP+TIRG9l2g=;
        b=oWNNCGeU5/tZwfdA2vgy3HlKPHaaL93G/apA/O6jMmz3i3m9CZuRY/tL+Y8RFdwUws
         P+psj8L2XcB4fzbMdWLuSue30Jy1lqEt6uoS9NucXr4DM9iOoVCwwvT+ZDoUR10NDGtP
         2GbyGW5bMiV8i01+ih00tJED0BeaH7b/IDnYrIuDl7+9yukzVzQN9pDy0nzM1gbpYTkq
         SWPhvRuCO/YRCqmWhKCcrnW5WAI+ni03Ldj0IWXRWYAOzZM4tq2oHOA/widJjDO87aVH
         H6GrISi5noavqRu1tPTdmM/0QkzMXWrj/E7uFumi9XHUqWkkP3PpUw6pY0C0YlMMaGUc
         PywA==
X-Forwarded-Encrypted: i=1; AJvYcCVgo2VrmzjGGh/uUMtw9pBX2C6HZCsyDZBLp8sLBEVhgBIhmaniehKWHzf6mJxrTkRH2zZ3rm8J7SJlorynmpw=@vger.kernel.org, AJvYcCVi7F4arLGZ27IoUicpMDrqaaKCvEGw6D6u5KQ0xildumYml+nTqbaq0VCigGZnvZOsrPSxrN6EuA6X@vger.kernel.org, AJvYcCWKdlqjzkT7ls4Y0iiMvUDc5y7AmNKtLFimKe2I0arRpLhui9tll9c3jM6GhxRTwfKnihV4O5azKtqOnaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2lFiy/It37zz8OCWumMojJb+wbLCfDdRq59MABLtuOMO0fyys
	pHc9McT8ftAUNRK+owprRcDzxFmslGnTxFmAo8kQlTlvTSYQ1ABkH1/r064FsQ==
X-Gm-Gg: ASbGncvNFl+U+DKJwP7RCWwhfz3+Ygcp/lpjIbCv8ql6SHBMb6u6CgpsutgLN1ouzTB
	xS5xL+SvqPES/gDQ+vIQldVusJWzElmRWze3ft9FOgN/n9VOr/rDl6ZRZpv38p3x4s5BZDx6DYP
	t40hRlCQ9S4hvBHyCUHgTzMiGGHSqQHPb/eHPGpNx3wAoTPgcw8X+FQWax+r8SnJ9ZCxJMk40NS
	zdRHVHA+/IJaQbRnNtzylfB4OryYgQvsxMSjKaEXI9FDlqJR6y0zExEwf9ZY++qk4SoLqUImnmt
	7eqJ/d/EEdrDgD881HcFRJqOvxUdsV6EOIDugsoDASJWBpcacGB9+2NSUZoEYXxoXiRr6nAAHjV
	hXDrBRieXY0/eg253cr+uViqoYN3axjW0CauRiaFutHajwMXBfx5kQqZ7ahvUtRfmwMuP7Ow5+1
	ahQOK4uijvZzmOsROwC+FG3dY=
X-Google-Smtp-Source: AGHT+IHNYOLGvnD/plZB0uTH+rbzjsRIN7YnkQld5If9zgM8/fDwPdGODJSVQxYRBKNmFt3aBG/7GA==
X-Received: by 2002:a05:620a:4113:b0:7e1:f16c:16d6 with SMTP id af79cd13be357-7e62a0926f1mr355009785a.8.1753280793435;
        Wed, 23 Jul 2025 07:26:33 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356b60cb2sm666903785a.48.2025.07.23.07.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:26:33 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8BA9CF40066;
	Wed, 23 Jul 2025 10:26:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 23 Jul 2025 10:26:32 -0400
X-ME-Sender: <xms:GPGAaOQyU0z_zAH_bkn2B2w1eORDMvtRYEZeKQ9_Sua22ZQcsZ8QUA>
    <xme:GPGAaKWM-_bDGYEetZsm7ETL5JE_m_ehZYfEYnqNJhKNesF8WvLNC-1dckRjedSLF
    PyZ7yiIHztSCoaGLg>
X-ME-Received: <xmr:GPGAaNh9dvy2hv07Qr4MfsyKotP-IJdDFBh6awbB3waNK_Jvoe9AtaNX6l8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddunecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepveehteffvdffteekueduuedukedtgfehtddugfehvdfgtdegudffhfduudfhjeeu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepuggrnhhivghlrdgrlhhmvghiuggrsegtohhllhgrsghorhgrrdgtohhmpdhrtg
    hpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhg
    rgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuoh
    drnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtgho
    mhdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepthhmghhr
    ohhsshesuhhmihgthhdrvgguuhdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:GPGAaDf3kvgrxlMBRwo1V4sT7qRbhU7Hi8NqVxClpU0wdmGMt7saZg>
    <xmx:GPGAaIfkGJ6YVThjZpXXmiRil0lsP6N8BjV1UxI_OLjzPhZnwUSAFg>
    <xmx:GPGAaPWLvYbKX92E2Ad0RwDHSzqlJrfC3gG_2BTQ_pGoH6zmvCXqNQ>
    <xmx:GPGAaMeMIKPtAEbdPjR7W8TjS6PETPWEGnt_Qrh9HwvhhX2XnVpHwg>
    <xmx:GPGAaD8DF0Bw52frFcLuGHp78fMOUq-AGXi3f4IV30D-zWGRl0mPz5ti>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 10:26:31 -0400 (EDT)
Date: Wed, 23 Jul 2025 07:26:30 -0700
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
Message-ID: <aIDxFoQV_fRLjt3h@tardis-2.local>
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
 <20250715-topics-tyr-request_irq2-v7-3-d469c0f37c07@collabora.com>
 <aIBl6JPh4MQq-0gu@tardis-2.local>
 <ED19060D-265A-4DEF-A12B-3F5901BBF4F3@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ED19060D-265A-4DEF-A12B-3F5901BBF4F3@collabora.com>

On Wed, Jul 23, 2025 at 10:55:20AM -0300, Daniel Almeida wrote:
> Hi Boqun,
> 
> [...]
> 
> >> +        IrqRequest { dev, irq }
> >> +    }
> >> +
> >> +    /// Returns the IRQ number of an [`IrqRequest`].
> >> +    pub fn irq(&self) -> u32 {
> >> +        self.irq
> >> +    }
> >> +}
> >> +
> >> +/// A registration of an IRQ handler for a given IRQ line.
> >> +///
> >> +/// # Examples
> >> +///
> >> +/// The following is an example of using `Registration`. It uses a
> >> +/// [`AtomicU32`](core::sync::AtomicU32) to provide the interior mutability.
> > 
> > We are going to remove all usage of core::sync::Atomic* when the LKMM
> > atomics [1] land. You can probably use `Completion` here (handler does
> > complete_all(), and registration uses wait_for_completion()) because
> > `Completion` is irq-safe. And this brings my next comment..
> 
> How are completions equivalent to atomics? I am trying to highlight interior
> mutability in this example.
> 

Well, `Completion` also has interior mutability.

> Is the LKMM atomic series getting merged during the upcoming merge window? Because my
> understanding was that the IRQ series was ready to go in 6.17, pending a reply

Nope, it's likely to be in 6.18.

> from Thomas and some minor comments that have been mentioned in v7.
> 
> If the LKMM series is not ready yet, my proposal is to leave the
> Atomics->Completion change for a future patch (or really, to just use the new
> Atomic types introduced by your series, because again, I don't think Completion
> is the right thing to have there).
> 

Why? I can find a few examples that an irq handler does a
complete_all(), e.g. gpi_process_ch_ctrl_irq() in
drivers/dma/qcom/gpi.c. I think it's very normal for a driver thread to
use completions to wait for an irq to happen.

But sure, this and the handler pinned initializer thing is not a blocker
issue. However, I would like to see them resolved as soon as possible
once merged.

Regards,
Boqun

> 
> - Daniel

