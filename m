Return-Path: <linux-pci+bounces-7109-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1560F8BCD7B
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 14:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5BD0280E96
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 12:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DDC143867;
	Mon,  6 May 2024 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jD16USvp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD124F218
	for <linux-pci@vger.kernel.org>; Mon,  6 May 2024 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714997438; cv=none; b=s1e0fCbzZdkeHGSN7u+/eFi5usVTTIqIddVjiiw3PzMyBn58HFehZ7vG0LJvc41c8nsL18RUGX3FQGb3j1ys5NhZzaK3b8S91EgUz71wj1GVtIQg3aLIbv0GbHbOtY5QqZFuJ/VcyrGtJ05GbpaWUT7/PoX8WKSRN+rbGdT7uBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714997438; c=relaxed/simple;
	bh=NpCD5T+l+gGXtsoL7GDErBmJ6/RrNy8hQRbP7mriCTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HbNDGjwEBVYWpk1ExLD79jKaa/djaIw25Oattwjmu+BTy/ATVlRq0Nq7DT6cfhFUisnEq4LJwKW4O0wW+JxbmHodh+l8BG+4BoTkVhGv6NvJDwQy3KTn9RoZ/joOPcyAFEBJSjhDjTTOnsCU57A6AnOiHrUcuUg7WojV2+Soyf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jD16USvp; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6203f553e5fso15477147b3.1
        for <linux-pci@vger.kernel.org>; Mon, 06 May 2024 05:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714997436; x=1715602236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83bq6sZnjWOAj2QjLu2jyQop5vm1yVH5pagOdWkdqQE=;
        b=jD16USvphZ+hFQuuK2fEDANCQqnDoaaVEQVpWzQj5VW66fA8hloBAr3cfWcwpvzZb3
         onMm0sVD6YQZ29cnRrkoO9vx2Q+dS5xv3OSmO/Hk8GS9b7PjxI/DPAT5Z3WpUEGo4Sz9
         JE74lVwr8MNbSRbl3W8+0avV85YquyQmXJgybHbPxfPJo0/JmJwOC5xpkYQat7RvDG4p
         38m9N3pHZF4eFkAnlUf8hKPrKNcV3E+8GC2SVYl9ySF3b6dHh1d/Ue7oGc3sVqgV+88o
         ADmyRzamrJ1rw3oPTJqi8m8vc/Fg8nkwx03RYEWn0v9BdU14p/v7IOYXFo95xnFTdh8R
         sLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714997436; x=1715602236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83bq6sZnjWOAj2QjLu2jyQop5vm1yVH5pagOdWkdqQE=;
        b=A4PwKlA28kkQgHKab2GxPJcx9FmnAh3L4lDc893mCGIV0rGddCtoC9QUFJQ/D4ehnw
         YdM1cKft4/+PfLTDAw91yOFDCLmCthjXRwiLl5m1LCAa8oR2LR1VZc5C6+i6Osk2TZZ5
         RtSaU1EIoAfhOhpRaqXHNDxDYnAv1gbWqHkUSGejQj4BINNh6kxdT32Z6mBRuylrdoiK
         7Mvirsp/qSkigJrI5SCnqVB1b3650pMB61pCy1lpanxOGekySMrwU5mLz+ECoDMztprY
         5E+OYpdwRDhq6mrVQYKq+ZLXWz2VOnjL+fG1jTXDdpNChs6Ksd4lJmJPat2Q1MI0ONk5
         t+UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDBV166Mf6oIA0/WBnz/XCqIX4CEDrcfUCIIE66isv5XJeo/+N4fxJPzbSsk5cS/xJkr+30Hj56SUr0UZvhvemiOdemA7/26Ui
X-Gm-Message-State: AOJu0Yz+/gL3ZRU1Mc1AENx0kog9XF3xQZE8+BG7stTDkJ7GPqt4QCXw
	OKqodaSl6jL4FLNvCbZ6tMHe+QFIuzgKNBLrAvmeBSFHvh+au+jLhU0AgsNlYPppeGov+plVU6d
	c9pKT+Ky1P4sNTBz7PMd2LPmh5FplJUEWlkPr5g==
X-Google-Smtp-Source: AGHT+IER78l+XvV7AsX+dBbOeQ79q3sQzITzxy15JTynwXfGIedBRzHp3Bby/Y/eLvaqRahVeAP4r46dQsP2qbPRE+I=
X-Received: by 2002:a05:6902:2011:b0:dcf:2cfe:c82e with SMTP id
 dh17-20020a056902201100b00dcf2cfec82emr11080008ybb.55.1714997435752; Mon, 06
 May 2024 05:10:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429102510.2665280-1-andriy.shevchenko@linux.intel.com> <20240429102510.2665280-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240429102510.2665280-5-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 6 May 2024 14:10:24 +0200
Message-ID: <CACRpkdZUsA034L5GjF_-XELX9369PwNjONfsDV-_EC564R0QWg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] PCI: imx6: Convert to agnostic GPIO API
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Frank Li <Frank.Li@nxp.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-amlogic@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	Vignesh Raghavendra <vigneshr@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Yue Wang <yue.wang@amlogic.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Xiaowei Song <songxiaowei@hisilicon.com>, Binghui Wang <wangbinghui@hisilicon.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 12:25=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The of_gpio.h is going to be removed. In preparation of that convert
> the driver to the agnostic API.
>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I think there is a bug here, the code is respecting the OF property
"reset-gpio-active-high"
but the code in drivers/gpio/gpiolib-of.h actually has a quirk for
this so you can just
delete all the active high handling and rely on 1 =3D asserted and 0 =3D
deasserted when
using GPIO descriptors.

Just delete this thing:
imx6_pcie->gpio_active_high =3D of_property_read_bool(node,
                                           "reset-gpio-active-high");

Yours,
Linus Walleij

