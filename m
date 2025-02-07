Return-Path: <linux-pci+bounces-20878-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CB9A2BFE2
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 10:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F4647A05F4
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 09:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F60A1CDFCC;
	Fri,  7 Feb 2025 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R0QQ6qqk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7775F32C8B
	for <linux-pci@vger.kernel.org>; Fri,  7 Feb 2025 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921797; cv=none; b=bEx2iN6dq0MkU/f1R8dJf1w39R7c2YTWE8SmstaZim1X3twIH6sTFJpKqVgkNach5x3HztxeL+CuyBc3/5sGY5PuHXSy7BBrumJIGattTovcdma+4w9NOPXLka5RgoChXJM/r2uE9ksoR0nzz1I9zlkWbYRJsVdOddq1UMyM/JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921797; c=relaxed/simple;
	bh=S4p6LLSLOPSpJE9g1forZYx4llbSsosHafGdaXkcLks=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/glBzeC437TaaepTbXnLj3B22EXk1bE9Al8djJHfLgROiUaRR60nSlB2Uo3KkuNqPKfCHWhslQWVpm970Fq70T1Qp5AV7nJiQzs9Ij2Fs8G/UImdp576Wx0uUB0A8+MToiapvbku/Q9r9hdJzZIjXLh/Va6/Rbm4xDqMf8/S/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R0QQ6qqk; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab2c9b8aecaso337789466b.0
        for <linux-pci@vger.kernel.org>; Fri, 07 Feb 2025 01:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738921794; x=1739526594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hHxN1cJYA/N06QjEqFReiwPXLdQZSTCuNsi3b9gHzjE=;
        b=R0QQ6qqkuCHyh/Lspg5x220NQrmp3N6wdbNGoWH7PyXNdhvxz4Jbe7NchDCCV30XOR
         4UrnQQ0BAftdo0xjDtYM/BhzjoxDNhCnK34Yghwjgj4YH3Z24bCg8BkDMUE3cBgRNqoW
         IN/BOoMUZKikliYvQvrQhGKp5soXPZt7bLmqMnjeOaoYU/2tpjpLxYXKJbjHw7zOiTqT
         Jb0g9NZP4p3/v2EQoEOMoMl4ILwB4ZGwXP6h8dqQJOw5YWwV47WyQt2MnRb6xO1swpGW
         M+TB33esmktLN3zuHbZ6n5BvKOB6V9Gwuspyo58dC6FTQjuOuV/zfe3lbKR/zWYucP9I
         CxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738921794; x=1739526594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHxN1cJYA/N06QjEqFReiwPXLdQZSTCuNsi3b9gHzjE=;
        b=jCPbmIXHeSrj0rxqUwtjj9Y82A8wxT+tGi3wsCq9RL6TFszzlfgZqkOqwNzfqCUQxx
         DwvnMufL74FkKR5DvLrtvOBVBek4SYIUSLkAs922XPlUX4Delh6OL0BQdPEV5xVpiwYo
         OaKh7qHeqEypDnoirxjze7Z2ghyGfEIzHo/6rUJSJvFRaCWz9Z//XRG3Z/Z7GCCtrZku
         0uMRX/56WOIzRCGyY9bpjZBh2u8e7iUb3dnP03C4ip7wL+URXt0W5rK/PsrO5X+JqfO7
         k+WOT2CMRgGuPfgYUJBnMM+yRccdphtDpzOwqfTjSbQ+ILQ+Y78IF7WLIpamfDI8O1xx
         65wQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+NBuJoA7K9nL057ObexGD0iy41ztQqGzMgy3LoPR0mjJw6/YIk0jvvC8PS7o0uDb0LUKZgTccbSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKaqIpNQqxdY1gpS+cnxD92li7hOeLac8JoPMtwLU5G+8wiqFA
	D6kdQguf0E0ULtQGj3GZUIIwsyaMfLw7Eczoa2rW97Wyd1Sw+tcfHDQWy9/XAys=
X-Gm-Gg: ASbGncvfxZPwDjLj+GfNbEzTQR7IQnGZoDxyAnMXXooQ0BvoA7SwcXfd53JQaiPKzHF
	G/omLX960u1FUPFxV182MLvGKKcVlID2HGZfNdn8A5Fv7k4z4lel2VtKJgp3EoyOku6yRL62iHF
	pZqf+wPD0S3E3aLP0mJxstYl5qF+AzN5snaW1eFvNwGrH6TJ+bmI+ZGV43B4AF2Y2Kfl7lx17Zn
	8BfEsm8kCJqVnsCs8NtjG29Ag39C6kqjvRA8WYHsS36qyQI6YrOqzsCIGUteb69ECQX1hMB4Kg4
	rXFoTAPV1Zbc45jttYj8+AOO8pV/T8ZvPi2H+uMGdOTNW2zyFIZW2ocF6RE=
X-Google-Smtp-Source: AGHT+IHCzEFvSIhfMGLJjDLN8sAOhYITMeHBywqkNc2QJXqBWAThFj4V/KSvjovgix5IZ8ADaCm//w==
X-Received: by 2002:a17:907:1b27:b0:ab2:f8e9:723c with SMTP id a640c23a62f3a-ab789a9ed0amr257773366b.5.1738921793776;
        Fri, 07 Feb 2025 01:49:53 -0800 (PST)
Received: from localhost (host-79-41-239-37.retail.telecomitalia.it. [79.41.239.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab772fd6ba1sm235401366b.79.2025.02.07.01.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 01:49:53 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 7 Feb 2025 10:50:52 +0100
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v6 05/10] clk: rp1: Add support for clocks provided by RP1
Message-ID: <Z6XXfL1-ER2dLmZI@apocalypse>
References: <b12caa1c8c674a56afa7b2de780d9ae5423159a3.1736776658.git.andrea.porta@suse.com>
 <20250203234443.GA810409@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203234443.GA810409@bhelgaas>

Hi Bjorn,

On 17:44 Mon 03 Feb     , Bjorn Helgaas wrote:
> On Mon, Jan 13, 2025 at 03:58:04PM +0100, Andrea della Porta wrote:
> > RaspberryPi RP1 is an MFD providing, among other peripherals, several
> > clock generators and PLLs that drives the sub-peripherals.
> > Add the driver to support the clock providers.
> 
> > +#define PLL_PRIM_DIV1_SHIFT		16
> > +#define PLL_PRIM_DIV1_WIDTH		3
> > +#define PLL_PRIM_DIV1_MASK		GENMASK(PLL_PRIM_DIV1_SHIFT + \
> > +						PLL_PRIM_DIV1_WIDTH - 1, \
> > +						PLL_PRIM_DIV1_SHIFT)
> > +
> > +#define PLL_PRIM_DIV2_SHIFT          12
> > +#define PLL_PRIM_DIV2_WIDTH          3
> > +#define PLL_PRIM_DIV2_MASK           GENMASK(PLL_PRIM_DIV2_SHIFT + \
> > +                                             PLL_PRIM_DIV2_WIDTH - 1, \
> > +                                             PLL_PRIM_DIV2_SHIFT)
> 
> Maybe this is standard drivers/clk style, but this seems like overkill
> to me.  I think this would be sufficient and easier to read:
> 
>   #define PLL_PRIM_DIV1_MASK   GENMASK(18, 16)
>   #define PLL_PRIM_DIV2_MASK   GENMASK(14, 12)

Ack.

> 
> > +static unsigned long rp1_pll_recalc_rate(struct clk_hw *hw,
> > +					 unsigned long parent_rate)
> > +{
> > +	struct rp1_clk_desc *pll = container_of(hw, struct rp1_clk_desc, hw);
> > +	struct rp1_clockman *clockman = pll->clockman;
> > +	const struct rp1_pll_data *data = pll->data;
> > +	u32 prim, prim_div1, prim_div2;
> > +
> > +	prim = clockman_read(clockman, data->ctrl_reg);
> > +	prim_div1 = (prim & PLL_PRIM_DIV1_MASK) >> PLL_PRIM_DIV1_SHIFT;
> > +	prim_div2 = (prim & PLL_PRIM_DIV2_MASK) >> PLL_PRIM_DIV2_SHIFT;
> 
> And then here, I think you can just use FIELD_GET():
> 
>   prim_div1 = FIELD_GET(PLL_PRIM_DIV1_MASK, prim);
>   prim_div2 = FIELD_GET(PLL_PRIM_DIV2_MASK, prim);
> 
> It looks like the same could be done for PLL_SEC_DIV_MASK,
> PLL_CS_REFDIV_SHIFT, PLL_PH_PHASE_SHIFT, CLK_CTRL_AUXSRC_MASK, etc.

Ack.

Regards,
Andrea

