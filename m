Return-Path: <linux-pci+bounces-36367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ED8B8125F
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 19:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4A494E0FE4
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 17:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8C22F60A6;
	Wed, 17 Sep 2025 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C7xNlPl3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2922534BA44
	for <linux-pci@vger.kernel.org>; Wed, 17 Sep 2025 17:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758129679; cv=none; b=mgfSeDf6ON3UDZUSO7EQ7Bbj5xFbsO7Le+LhAKlqoFItfY8ysPFARq+gXqt5VWjTvkp82pwVMNOZwZpyRGb7uW+CFDlUmkjZ01mhJj+P1OOiSys+Gj9bQtR0xyeYEQDLsrr8wKERuj7cvXw9PDOfrDJN2Khc/3ojedQUmIM3KdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758129679; c=relaxed/simple;
	bh=1aoUAbCzO9b1WkCL1uGdzZ9KLosTf9Mi2eCsOLd4jP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFuZu9YQ2CSjHbl1odnLY7ornvlrpIxFrhfAgwKh6HJVHBsNpbPhsxn1ABxukXD78p8OApBD3R/VqbOaO8uWnv2QprsUYfoytSILkNWydTTxxhg+7icyCsbtYsT5l7EvakB6Mj9jAMZkZ61Gspc06oRfdnD25cmgR7chfP9LKBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C7xNlPl3; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-62f277546abso8836346a12.3
        for <linux-pci@vger.kernel.org>; Wed, 17 Sep 2025 10:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758129675; x=1758734475; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jE5z6SStGstCRNv9ltTlbMEXuvhA93B8hSvu3mrmaPk=;
        b=C7xNlPl3wMA8f5w/dNNhkhoXThE3Z0SfiUA4+LoqR03UzdJ1IQ/7kTuBRTp6K3uuCx
         v3gpARv/B/Ms9w8441V8HRjKRZXkCUDioy46bA+VZDRa/dv4rFarA2i/4+d/YptUrpw3
         3GcD4l4hL0p19S8CPWp01veHbqN41vUj3vKsc5nISh45uCGH1BwWovQxlRz4sdtqWbyL
         Yo9WLmSKaNa7I0PdtJ7/kIXT7wSQoeIrpWAZenxz41j4HWyAfXuXgGIRSP9oXKBMFFYP
         kbcwxKrK5IuXMRv3x7q54Oysq0uDykZ2hU38LlPNpT8C4kX7DBIr31Nl+ull5uFkXUdp
         epuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758129675; x=1758734475;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jE5z6SStGstCRNv9ltTlbMEXuvhA93B8hSvu3mrmaPk=;
        b=Iky/FJ5lwXa1Cpu956plcbLsxWV6lT3/OJg5SlCpHL/vIbSx6/yqQ+qJlTnTvPSvX3
         qusaZXsMfY4ZsN0ZgrFkoznljGwZt1r82+9wyHfbnW3nBGd9d/FfGBlXNtKkXj1HhGXm
         zSnKYsFJOBaZNMotdT/M+fqJsffNm2CPZ1t+N11zAjr1dipa1wC0bEXEylHx9+B/1Tz4
         xqUGb7iy8AtMZq4310aY41R0XHlLGSYDh62jy+4gd6PMTUkMXiaaMbdo0YoVT+Ad9HUJ
         TT6yET/TNnm8QSQrg02zU834jlxh9RJlAw4IMBntbot+95yhr8QvFXsup3qLMZvrhIvJ
         fF6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX41oD9rn3vlr8j+0UCuifUYVbjBAKuwrasux5l6JPvwyGc1Ol3zEkuP4fHyJ1rp0vQR+YEOOQAEDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya/EeB5u9j2ZpUJO2FaflnmgZLh3EanIAaWpIF57k2n6w2q22W
	U2tsFzKewAoOYvCcQfeBSHnov4e70asHFLFJ14M62+iTMRuxsJ0Bo7SVLJGGZ2yLKxON+0n4sGS
	Wc8UrENf74OSqiIR3lrObxkq3Q/enYpQky1p7mpFTaQ==
X-Gm-Gg: ASbGncs1NpCqLg8MSf9ILPLAlExdBnp7zs3+EetpVW318junXXNcc37e2RYKCExgnij
	JKv891aeVOi9YwDTFzM3K0F2xbq2g8jj/qIw9Ud7lzaZd+UKWt8An56LJIU22bH67dmjeMsbalw
	WGbj27PViOlbq8287ct+6LpSAe+QwFttXaxi0u28dw5S/5ANbOnuM391U2KcW7AQdMy9FVK5YU2
	NKIgThX/953RVEU03n4IcDunxK+j44PjIZxvGSaa8NkxJg=
X-Google-Smtp-Source: AGHT+IEkd1wU5hGZ/gLYNvwM0MAW/mjMU6QrKeYk8BM4gj6vi/UmJm+Bn6+Gz2aNpC1XRxR9/RFUm05c3RIj8Ydo0XM=
X-Received: by 2002:a05:6402:5205:b0:62f:5968:ae0c with SMTP id
 4fb4d7f45d1cf-62f83a3c874mr3294259a12.16.1758129675198; Wed, 17 Sep 2025
 10:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912141436.2347852-1-vincent.guittot@linaro.org>
 <20250912141436.2347852-2-vincent.guittot@linaro.org> <aMp0hNnBUwTV5cbp@ryzen>
In-Reply-To: <aMp0hNnBUwTV5cbp@ryzen>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 17 Sep 2025 19:21:03 +0200
X-Gm-Features: AS18NWCc9Wuje5i2tQbCh3xBqxRFBZcfMF6Z2ZM58muUKw4hiti-IcbYy-eSg-E
Message-ID: <CAKfTPtDTnzyksa4Om1HgZTJX7dGeM_vYiEV2eQnEi9AmZK7KEw@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: pcie: Add the NXP PCIe controller
To: Niklas Cassel <cassel@kernel.org>
Cc: chester62515@gmail.com, mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, 
	s32@nxp.com, lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com, 
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Niklas,

On Wed, 17 Sept 2025 at 10:42, Niklas Cassel <cassel@kernel.org> wrote:
>
> Hello Vincent,
>
> Nice to see you sending some PCIe patches :)
>
> Quite different from the scheduler and power management patches that you
> usually work on :)

Yeah, It's always interesting to explore different areas

>
> (snip)
>
> > +  nxp,phy-mode:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description: Select PHY mode for PCIe controller
> > +    enum:
> > +      - crns  # Common Reference Clock, No Spread Spectrum
> > +      - crss  # Common Reference Clock, Spread Spectrum
> > +      - srns  # Separate reference Clock, No Spread Spectrum
> > +      - sris  # Separate Reference Clock, Independent Spread Spectrum
>
> This does not seem to be anything NXP specific, so I really think that this
> should be some kind of generic property.

I agree. Thanks for having shared the email threads on the subject.

>
>
> Note that I tried to add a similar property, but for the PCIe endpoint side
> rather that the PCIe root complex side:
> https://lore.kernel.org/linux-pci/20250425092012.95418-2-cassel@kernel.org/
>
> However, due to shifting priorities, I haven't been able to follow up with
> a new version/proposal.
>
> My problem is not exactly the same, but even for a root complex, the PCI
> specification allows the endpoint side to provide the common clock, which
> means that the root complex would source the refclk from the PCIe slot,
> so I would say that our problems are quite similar.

yes, they are all the same

- common or separate clock
- Spread spectrum or not

and finally which clock to use as the reference behind internal or external

In my case, I only need to know the first 2 items


>
> Rob Herring suggested to use the clock binding rather than an enum.
> I can see his point of view, but personally I'm not convinced that his
> suggestion of not having a clock specified means "source the refclock from
> the slot" is better than a simple enum.

Having a clock binding to define where the clock(s) comes from could
be a good way to describe the various ways to provide the ref clock
and an empty "ref" clock can suggest using an internal clock for those
which have one.

But I don't see an easy way to describe common vs separate and with or
without spread spectrum.


>
> To me, it seems way clearer to explicitly specify the mode in device tree,
> rather than the mode implictly being set if a "clk" phandle is there or not.

I tend to agree that getting the common/separate and w/ or w/o spread
spectrum is not straightforward.

> That approach seems way easier to misunderstand, as the user would need to
> know that the clocking mode is inferred from a "clk" phandle being there or
> not.
>
>
> I also note that Rob Herring was not really a fan of having separate spread
> spectrum options. Instead, it seems like he wanted a separate way to define
> if SSC was used or not.
>
> I have seen the following patch merged:
> https://github.com/devicetree-org/dt-schema/pull/154
> https://github.com/devicetree-org/dt-schema/commit/d7c9156d46bd287f21a5ed3303bea8a4d66d452a
>
> So I'm not sure if that is the intended way they want SSC to be defined or
> not.

The above provides much more than what we need as it is mainly a
boolean for pcie than characterizing the spread spectrum itself

>
>
> I apologize for bringing up my own problem in this discussion, but at least
> it is clear to me that we cannot continue with each PCIe driver adding their
> own vendor specific properties (with completely different names) for this.
> Some kind of generic solution is needed, at least for new drivers.

I agree.

Regards,
Vincent

>
>
> Kind regards,
> Niklas

