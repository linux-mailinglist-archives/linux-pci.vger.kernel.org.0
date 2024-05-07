Return-Path: <linux-pci+bounces-7146-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1298BDD01
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 10:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC3BB285E36
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 08:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCBB13C9C0;
	Tue,  7 May 2024 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WiaqiOs4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CB613C80B
	for <linux-pci@vger.kernel.org>; Tue,  7 May 2024 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715069699; cv=none; b=BemYAeUkLhUP3h6ugMcG1poe/7e0QVt3FYcsulOSbA8XTK44tzdbLuMDJ6Fb8u4/JVDgsAkc1GHn1/goN+GO4Uuzmy0ZWr37cV6xcexAV/lDV6wzn4wCvBCaW1lzczoSrfPe6CBWJP7imfP21vXaYRceeETtZPQoC0C7smI9a1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715069699; c=relaxed/simple;
	bh=aFQgo/ziy0W2y9xqCxx31ymI6sX+uIn9KFqYXFLiQWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEvGuj1sqzZTkJ8XZfAfbErwQETHuX0ZQg7X5+ckhP09YwC04nWP86GJ9RVOD/IgOSKFQE4lMlKYNFgLndRZvMqjAwVCKSKrMuMiBTWU2bp7yWlP8xzNF1x1KKl5C9XwQ+28bWxA9vsY73ziIcHV4z0Jkd+i77uN9w4UXS02Ta0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WiaqiOs4; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f457853950so1812120b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 07 May 2024 01:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715069697; x=1715674497; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GqO/eiCLhjMrDJZ/oHlF6w3tQ/HJRwHOeX5fd3lD2/4=;
        b=WiaqiOs4w0dmyeF0WX0eWphYt4SUnUU4pIl3C2onmoAY8S/2+tHY18nBKQraXLzcIE
         E50OFNdm6XtlUTOrXANbh770kdECAPyJowHDoS4NDH+qyVd8YTwLr/pZoLYe7oTZSe2w
         lGPQ+lxGX+ZrCmk1Rr8mRdBP3lFTYSk3uvXJ9JUQT6VbmXkRLJC70PU3TuwLgZ0drLsJ
         z+uPjIPOtshmkx2yFNu95N8EoiYmdob3eBSQnMED7OXVEAsi8TJ70T41y6GyRcdqNlZ7
         SJmLkGO4BcTi//xa6c/QEhS35bdgK3Fl0h15EM1kKTXXQPXT/8xIfFt9+KSxsyw+MjwT
         jSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715069697; x=1715674497;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GqO/eiCLhjMrDJZ/oHlF6w3tQ/HJRwHOeX5fd3lD2/4=;
        b=UR1P7HdaVlv55tXcQvLl4yN9o7AlP2lRFtTTZxxQZTYrBBKhDENWzCRooqXNwyNUQc
         VMjiw7AjMlkkSvK+X2C4q+6kNXi3xvB0kSNgurvGP/LtVwFobKljZsOvOrSJR8ka/Oua
         wXJUwHgxMqLqii1tdM6h0BoOqh7LLiBldkgy93o6TrPpVOp9L47wLSgAmxHamLDM8Kc9
         4MA4uu8Lg16mWWBvaxXFH1yBi162sH0ZnPT0sr4EvdBYsDzdBQ7N0M5siMGqmNrTcIay
         N/hen0/hTlduuSVqRL/gDKST7EV+5ULz7f8IUraFYodGrEy8fH00+IyqsPCKfb8Xu5uV
         E3Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVLjWw9Pbt1PE+DQPCNdP6y4rYVBnDzz/7f3QdsFIgqD/L7CYslFklLqv9MDiKnyNVTwFXhtP4CrZBN4KNaRKBxG0Mdoq3ciO6V
X-Gm-Message-State: AOJu0YyuTZalNGO4oB2gc7XxDB3BucUEPAiLiSy/J8TH1V3zholI6gEQ
	cACwsaB62Xwym4qIXDWLSlMHeBNCaYDash6Q7piuo07UzxGUFLr34hSxK6929Q==
X-Google-Smtp-Source: AGHT+IHnAZTFdWiXFQwCMQRZCYd4TYAmRcm6JIyFZLn9J3uME67W+T2rImADb2DRfd7XSqJSBOyHVA==
X-Received: by 2002:a05:6a20:3251:b0:1ac:3d3c:c1e7 with SMTP id adf61e73a8af0-1afbdca8a39mr2746431637.12.1715069696505;
        Tue, 07 May 2024 01:14:56 -0700 (PDT)
Received: from thinkpad ([117.213.100.197])
        by smtp.gmail.com with ESMTPSA id u34-20020a631422000000b00600d20da76esm9156572pgl.60.2024.05.07.01.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 01:14:56 -0700 (PDT)
Date: Tue, 7 May 2024 13:44:41 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-amlogic@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Yue Wang <yue.wang@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH v3 4/5] PCI: imx6: Convert to agnostic GPIO API
Message-ID: <20240507081441.GA6025@thinkpad>
References: <20240429102510.2665280-1-andriy.shevchenko@linux.intel.com>
 <20240429102510.2665280-5-andriy.shevchenko@linux.intel.com>
 <CACRpkdZUsA034L5GjF_-XELX9369PwNjONfsDV-_EC564R0QWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZUsA034L5GjF_-XELX9369PwNjONfsDV-_EC564R0QWg@mail.gmail.com>

On Mon, May 06, 2024 at 02:10:24PM +0200, Linus Walleij wrote:
> On Mon, Apr 29, 2024 at 12:25 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > The of_gpio.h is going to be removed. In preparation of that convert
> > the driver to the agnostic API.
> >
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I think there is a bug here, the code is respecting the OF property
> "reset-gpio-active-high"
> but the code in drivers/gpio/gpiolib-of.h actually has a quirk for
> this so you can just
> delete all the active high handling and rely on 1 = asserted and 0 =
> deasserted when
> using GPIO descriptors.
> 

Wow...

So this bug is present even before this series, right?

> Just delete this thing:
> imx6_pcie->gpio_active_high = of_property_read_bool(node,
>                                            "reset-gpio-active-high");

But this is just a bandaid IMO. The flag for the PERST# GPIO should be properly
set in the board dts as per the board design.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

