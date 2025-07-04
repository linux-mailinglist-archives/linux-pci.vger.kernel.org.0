Return-Path: <linux-pci+bounces-31545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB24EAF9914
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 18:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95632541501
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 16:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEDE28DEFC;
	Fri,  4 Jul 2025 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYCMMMm6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D39A2E3718;
	Fri,  4 Jul 2025 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751647146; cv=none; b=K5a7vBbCnaWjmX5ypGESrzrkIyjzHcEVcX1JQyKqgZAtD1DZSXOHtEJT+5AMrGHmkCIK9akPKwB7z5pW9N1EMQhdS3rgtp5AXV1NkecFqHBRB3OtYn/P0g06p9sEU8huxIIP2z/bn4np4vF3GJ3kVKKryOHz0AxO0pAE+bsWtW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751647146; c=relaxed/simple;
	bh=Ow0HHRzj38qhw/tCoa/g9CEBjyrahrDGQCqquPpG/8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2Nr6MIqtCX/whP6gzKTnNAnVlSSovm4iRkYUX1sL8a01GtM66Bq9udaiB9QxTXBim08UKLArng9TDlFx+pSl/YLRHZd0pgfKq82FaVOY90mF63S2/Zg+PUV0ddC6ipE11nTw9H78dzDPEAPrB6S3kqbCRal+3T2AzMpQ/IBJfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYCMMMm6; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d38b84984dso214784785a.0;
        Fri, 04 Jul 2025 09:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751647144; x=1752251944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCv1VK6swGaHy0Lmgvq0D1DapyrwHdxQpmd8O5HxrHU=;
        b=YYCMMMm6Xosz8n4/YYurnfBRfTq1fSggocr2yynvCSk31oeMhQfS7IOPO2vbeOHdJi
         Bw/Vm/PXi5KmfBudTzvBZBTeCE09D8tsRg86Hb9Ux43wfc+OikJYGZ1iiJPI5nMcor9d
         k9W7mIRhzXZz6XXVZdqzvu89uCOiQR62MgJPK0gGx1rQx8wqxQKBzrmwr/yeNnQwizHu
         t8BO6+aM2r+6WuICSL+7+v+/jdBhP2nuw1P4H/0BcI8ixJo4ta3K0M3fgCRLUyVp+pLF
         GKir+skmdi0ngDpsPCT7hO0lKU5XCw5eyOmaOdgpIImiWfKJrPzjZn4A9fy3Ua+cB9Uh
         9EDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751647144; x=1752251944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCv1VK6swGaHy0Lmgvq0D1DapyrwHdxQpmd8O5HxrHU=;
        b=Ri5w+jUF1VCvkvDT4B8HmW53Ehk7fP2Vdp1L8pyTiz9tRdh88I+4JeaIV5erlrfIyU
         N006zOMuHcPrBPv0Z8uBjnkDq8rtnvCqVgHbKi0rxKvnNdaDVsshRSFlOQ8kYL+t+yyl
         m77iiYf9+BVG3HllYGnJ1st5Pw7UpyofilRhwJcmC2TSmV9w1G++dEZqvKs65Q+AD3iR
         j7BWF/MHaOqR3I3ehfgKc1LJT70v4hFI884ZAhqOkWKEObwtMi/OQ/1TeLVWa37arbam
         hbE35bXSL5Z+DcOk+HGX8iT+0OrjyFKw8OWlBCZtFIWXyQW8ySPP4+Q9BCPo8F7HlUjh
         VV8g==
X-Forwarded-Encrypted: i=1; AJvYcCVoh/Kbz6OPWt4XJM8r7i1q//c6L5ZmrmG6fjgXc30j2snFjYYw8Xuw4scgU+xIavBo9ffKZcSurkoDqrk=@vger.kernel.org, AJvYcCW6mqA1mVOwMagGOicKIt/Pjc2GM2sic7J1yGLjFuqe/waluIVEmQcaxIMRdzeMcehGBIztjyMiT5DTk9SWtmw=@vger.kernel.org, AJvYcCX2be30F+DTJeADJcks52u+8u/JTnKrMspC3IFumR72K/U0KrM4tcrFW9/1PHTIVgJQnyZW90NqHbRw@vger.kernel.org
X-Gm-Message-State: AOJu0YwnQljr+3btcvg9a/t2KNFg0ESnaoVaXPyD+PPcWkaNnvdH/cBa
	zepCPyKbVWMqQ0JD6ewz1GRedMaF/nIPa3VRAeNGaN+pRFyF/69RqwLM
X-Gm-Gg: ASbGncuT0Y9vZXNcwZ1rdMby83MTx3fDkfWauwzEza/wXR1U52LVWgWqoxwrgYwk+f9
	mcsFFqKdkvMRjkwRYQwsjVkxNXcWxKbMz4tDeQ44YNp1OS1Os/f/ZPFcj2tG9TVaLjrz/Wq8gey
	9/5V7UePVXaB51qUo+ifpRH8IVuPr9o2DGt3DrZ0qwfyhwEc7yuyzLUz77edSXx3N+it9wYGhBU
	GTze3abc0gtcS4BEqAP3vcwmdcRf9z9p4Weyi3Bsajcd49hp2Ex4B2uNOARKR6vn6jlL4lxPTSj
	py35wiGtRCJeFFhJwKX2cylpfbRTD25qmwUHfadoOUxVCoIqSvI82vIfwxfPLY3KQpSqG0MOjS+
	YxSFB1NAWg+nngP1ugpiP2Sw1ixmq7fDRaa+8iF0mTnC+C3ggNx5i
X-Google-Smtp-Source: AGHT+IHNvBwL1cE4G9VsyzhQ0wgzN9gnPAwGgVECqrro5aXhGsa4wmExqRbq2SEMZDGxDoF9K8KGOA==
X-Received: by 2002:a05:620a:2709:b0:7d0:a1d2:436 with SMTP id af79cd13be357-7d5ddb8dcd3mr279505185a.33.1751647143993;
        Fri, 04 Jul 2025 09:39:03 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbd958f7sm172074385a.16.2025.07.04.09.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 09:39:03 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 02F55F40069;
	Fri,  4 Jul 2025 12:39:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 04 Jul 2025 12:39:03 -0400
X-ME-Sender: <xms:pgNoaHFD4-AG_GIecdmuUWhWuMBey2k7RrbAz-ViC6GsUE3ycVLQEw>
    <xme:pgNoaEVZfWH4BqlYaLpMYIkzQuGots8H09Qi0VxOke20ZdrWpF66--cP86cHy5CQH
    8A7l6vqou5Rw5xI2w>
X-ME-Received: <xmr:pgNoaJJYjzkh_cpOcP5bXd80ca53sh399BP3PPL_meyEI040SoY6DyhnxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvfeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
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
X-ME-Proxy: <xmx:pgNoaFFOF9MYrZ5tcN2FPBKNA6EFgRGftw-dGC7CJIYHml3wQD9_8g>
    <xmx:pgNoaNXiOH5PoVr1Y23q4qnVotPchgHJJh9DaKhfcuK3_YKAuL4yAA>
    <xmx:pgNoaAOPRi10DONElO_h3pYbzqHVqp94SqI-xQ_MFPDQp_riuzKh7w>
    <xmx:pgNoaM0n6Y5xnqeooIbuAA6ruUgFjJCxxG3yFBlFBf68LlDPzgBlLw>
    <xmx:pgNoaCXttNInk0q3NADD3VU3HpoO3MgT90MlnTv4XZG9tqFzu1du8SlS>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Jul 2025 12:39:02 -0400 (EDT)
Date: Fri, 4 Jul 2025 09:39:01 -0700
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
Message-ID: <aGgDpWkU6xAn5IFN@Mac.home>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
 <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com>

On Thu, Jul 03, 2025 at 04:30:01PM -0300, Daniel Almeida wrote:
[...]
> +#[pin_data]
> +pub struct Registration<T: Handler + 'static> {
> +    #[pin]
> +    inner: Devres<RegistrationInner>,
> +
> +    #[pin]
> +    handler: T,

IIRC, as a certain point, we want this to be a `UnsafePinned<T>`, is
that requirement gone or we still need that but 1) `UnsafePinned` is not
available and 2) we can rely on the whole struct being !Unpin for the
address stability temporarily?

I think it was not a problem until we switched to `try_pin_init!()`
instead of `pin_init_from_closure()` because we then had to pass the
address of `handler` instead of the whole struct.

Since we certainly want to use `try_pin_init!()` and we certainly will
have `UnsafePinned`, I think we should just keep this as it is for now,
and add a TODO so that we can clean it up later when we have
`UnsafePinned`?

Thoughts?

Regards,
Boqun

