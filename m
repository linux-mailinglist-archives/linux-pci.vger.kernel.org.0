Return-Path: <linux-pci+bounces-15336-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99529B0931
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 18:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273471C21B81
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 16:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CF016FF44;
	Fri, 25 Oct 2024 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibV6iOhX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86747A945;
	Fri, 25 Oct 2024 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872509; cv=none; b=u18yoXPNMIVvMrSTOFxJzU84lF/mXrpn1IWDpdRvW92o3Qnr8wvK0Ji8hdv3zTmLVFv2ajFvnsWBlhXiUXU9ddZjOVIub8NK7qaNjXy7vyNNYup4jpjVbEDZ8W/k0JdxQ3Y0FPygd9H0VhbbUM9mLhr78xsb04qIorh/f8WVCnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872509; c=relaxed/simple;
	bh=m8UhqT2D8mXrCfBkPS2cGqIO6xu+2R3YfSp9wUkMwc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K1cRK9Uk2krGzmYXKG9YXzyLUWZL5TL2SvLa9ElSXGbXxdSOC5DqPceyaROo2nyfd7vPD/2dk3BGr12xumD9bQfkZd1ZSWrQ6T8B6XkKGN4kjz+OXYRveLSajqNCQ1jbfGHgPSPfHPcLWjoYdJEYqeLk690FHanRwQXjjbx3Yxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibV6iOhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36A7C4AF0C;
	Fri, 25 Oct 2024 16:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729872509;
	bh=m8UhqT2D8mXrCfBkPS2cGqIO6xu+2R3YfSp9wUkMwc0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ibV6iOhXN0LWHRi8nL73fHlMvPhS6TUhJy8iKgHSKg4siemaRqo4cQ8kwRdA0AEDc
	 XZ2dGX1K4scjvErwi1xBbf4PDKM3Le/CLP5p8+rHfFhU2sagk5g8SdvmrJz5zcBsed
	 wlOKXsoV8j/jqcn8PX5jNNHxGO1BjGq+0Bph/dykP+MqVc99+1Cxsr4TgitTPITehf
	 X8MXcxsksGYKOXSrRKAA+dMz3V+nS4JpYCYklDAjDOyEJtgAr5JyFf6iP+E6aiGXxn
	 ffHutK/z/TFRVvezBvolNfZIo34YTWwAFSgoLwfkpdQBoImmKesEXGXel7x59/vOSZ
	 W67aeKyuWUWOg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53b1fbb8be5so2382586e87.1;
        Fri, 25 Oct 2024 09:08:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU57q6c15PcQdneCq4nB/4Wdu9KVVdDQEjM4jue6fEFSihPnCzHJaLl/R9FwhZAHx8eZJeGoYM5rLlNl25w@vger.kernel.org, AJvYcCW89ZnpZ7I96MJey43u29aeydC2y4xXCb01EbTpfD6UNJtaWzBw8I7LdFchXhAlMiSAwVF6v2MWP36H@vger.kernel.org, AJvYcCWHz7gw04pUDX69G7nNoblvR64UF03E73/yi7utSqUpYRbXBIRaO9WjcmBZQH6/NDEiEdgiYCqCxJej@vger.kernel.org, AJvYcCX6KW3+EsleePC40QyMGYe8YG4CWCwoYP4lkUrptMTpx3R17N3ByqIboHcbTLwalth8A/hDicgBTk7uTFXTEw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg6NvZQILiFP5Z6zTyCTLHhB0oIcJvgPeztNGBFRnfwLWXc5SP
	gOb7o00JjGTQGEsIJJtsKWIj2kFRVPAjXFjOXoOyO8xFTsnhRrlfKoN92wOno4skiPrpb8uUkWI
	bi2udSgDzeLJJTJAI4OyPHSYqWw==
X-Google-Smtp-Source: AGHT+IHljjKv2qhcHHlmzfYbXgiQ90Hr3WJDc2pE/XSMP8L+P9Fb91lskzB2hiKz32t6vMM1/rR3HOboQGzO7wn7kGk=
X-Received: by 2002:a05:6512:12c4:b0:539:fa32:6c84 with SMTP id
 2adb3069b0e04-53b2373720amr1970236e87.18.1729872507229; Fri, 25 Oct 2024
 09:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022213221.2383-1-dakr@kernel.org> <20241022213221.2383-17-dakr@kernel.org>
 <20241023000408.GC1848992-robh@kernel.org> <553bfc07-179e-4ca9-99ac-74b90badb6b0@de.bosch.com>
In-Reply-To: <553bfc07-179e-4ca9-99ac-74b90badb6b0@de.bosch.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 25 Oct 2024 11:08:14 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKmKUxwY3O3m2iYPjN6eODaAzzTj+4CSqBg5RyGKPk_pA@mail.gmail.com>
Message-ID: <CAL_JsqKmKUxwY3O3m2iYPjN6eODaAzzTj+4CSqBg5RyGKPk_pA@mail.gmail.com>
Subject: Re: [PATCH v3 16/16] samples: rust: add Rust platform sample driver
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org, rafael@kernel.org, 
	bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, tmgross@umich.edu, a.hindborg@samsung.com, 
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com, 
	lina@asahilina.net, pstanner@redhat.com, ajanulgu@redhat.com, 
	lyude@redhat.com, daniel.almeida@collabora.com, saravanak@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 5:33=E2=80=AFAM Dirk Behme <dirk.behme@de.bosch.com=
> wrote:
>
> On 23.10.2024 02:04, Rob Herring wrote:
> > On Tue, Oct 22, 2024 at 11:31:53PM +0200, Danilo Krummrich wrote:
> >> Add a sample Rust platform driver illustrating the usage of the platfo=
rm
> >> bus abstractions.
> >>
> >> This driver probes through either a match of device / driver name or a
> >> match within the OF ID table.
> >
> > I know if rust compiles it works, but how does one actually use/test
> > this? (I know ways, but I might be in the minority. :) )
> >
> > The DT unittests already define test platform devices. I'd be happy to
> > add a device node there. Then you don't have to muck with the DT on som=
e
> > device and it even works on x86 or UML.
>
> Assuming being on x86, having CONFIG_OF and CONFIG_OF_UNITTEST enabled,
> seeing the ### dt-test ### running nicely at kernel startup and seeing
> the compiled in test device tree under /proc/device-tree:
>
> Would using a compatible from the test device tree (e.g. "test-device")
> in the Rust Platform driver sample [1] let the probe() of that driver
> sample run?

No, because that binds with the platform driver within the unittest.

Maybe it would work if you manually unbind the unittest driver and
bind the rust sample.

> Or is this a wrong/not sufficient understanding?
>
> I tried that, without success ;)

Did you try the patch I sent in this thread? That works and only
depends on kconfig options to work.

Rob

