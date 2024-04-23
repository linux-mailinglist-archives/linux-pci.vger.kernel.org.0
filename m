Return-Path: <linux-pci+bounces-6595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A548AF7EB
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 22:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7991A2851B7
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 20:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439C6142E67;
	Tue, 23 Apr 2024 20:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+hDC1OJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7BB142919;
	Tue, 23 Apr 2024 20:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713903760; cv=none; b=uwCaBc24QVdXfgkI3QvUHCzKbyYbiQL/mXwgw1b8XTF7GKYS4YLdEcuTZGRvfmCfhczdBrYeljCtQjqClwE1XJoI8W+5YA7xW13dqa+Gj1OkaX+zVHEmkuikpQvVdJxkIvSLvyn3xRRKYE/xWq/ALBWnZ+TKd0eGsDm0TrPZanM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713903760; c=relaxed/simple;
	bh=ERg1J41d06etnj+H8lues6SdgOvc50LdXU0Ny6V07n8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OF6pATJYJ0i5B6XovwaCkjACM/Jnm502EBjRG14Ce/49Ro8tVM9zarH4uyGv1vY0ktTVemp8PLsSqB/yE+Wj+nXtIGy/2WD/MGjFWiATZUErudoZWtlR3PhcqdYbgUVqBQLPXRkkY+hqxnXEhharTW1wucPzToUxMh8+J1G4wE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+hDC1OJ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ab48c14334so1019611a91.3;
        Tue, 23 Apr 2024 13:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713903758; x=1714508558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERg1J41d06etnj+H8lues6SdgOvc50LdXU0Ny6V07n8=;
        b=H+hDC1OJhXQQWh5Asq00Et7iinm8dPNnaIsBoWcfW1IEypliiouRCwO7XO+YHHajkZ
         Op1A5CHv7RhcQopw0tKsBpYzmuvDXHjfG2tS5Lo7KqZtfuUpM7ELlycU8GCnE0lwK8bm
         IjpSd1SNYeKIxY6ecR13RzRQy6dTQzTAtp2Op+on6qbcLNgLOzKLTJHyf2eTej4NQq8j
         pkSXGLXq/MOEO8yZnrvPRLDryS+PJnC/WIoKDQsRQ441JeJpbxRL2hWuHbJqzlJoHAnM
         Nf7P11tnhOQ9tf+BHLIdZJ+Qi3zyGk0HdkIEWjcEHPAVggpqf/yjkRk9GcjcMiflocNE
         9RoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713903758; x=1714508558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERg1J41d06etnj+H8lues6SdgOvc50LdXU0Ny6V07n8=;
        b=MjYbICvbitEKg8gYZ6pLBBr+fy2LArP+eCu0gRazFXInCj5vUWe3K2UcUhhT+EsW2k
         fym7V8iipagXrUZdfP4NQR4OyQRtq/KHOEdeBgIJaE0U4oM/UCFmXxYlxP1+Rirs5CMd
         JcDmOHEsJ1F+QjU+magdUxNuTeWRJLFbyaZakJRUogz3NQNNW4+PnXHPELAlt4GIygUr
         gLpE1BhTfnUj0zaa9ylrF84AL9jFykc4LssZ2KkJQNAkrFNaIenVUr0Xzvqu1PaNVyk+
         9SzS2nmosCRsLLZnYbLPq27bDBVD05Yy15cAItq3vz5RyJf8QN2b0bP/V6O/R5+JBrT7
         i/tg==
X-Forwarded-Encrypted: i=1; AJvYcCVIFMHTDd9hpFeMjXZrHUD2Cisv0HVKdPPO808Q+izrTZ8asu0lkwqOrh3PXmgWBtfuMJN7frMh+FeBTe5hmorPR6ekfEJIshB5NlTuu35bebbfsreq7MSRwnhWGL1HtyBQCgX1XhZ3thczFm5EuYPZnty3MiEY492BjXjjEFgaLMsIo3ImkeF1kk45w90APvsHJDNgfpaftAxWO4KtOiUK8YPCC0PEvTgFPvARpqp9tF0pVqSL8Sruscbt1UpTwA==
X-Gm-Message-State: AOJu0YwNsJ3ZY/CTj1p1YAYitR4LNJcyGA/fXg7FoQJtb88/lnDE9USh
	/3uTYLh7npnJP/vZLuI5NnghuqzM+fJ8hw/5T+LInjaqYaHdTQu5ff8jTcCSVLs2tUsJnYBdieD
	SHGAzkl5bclpxv2IkvHT7SfJrLI4=
X-Google-Smtp-Source: AGHT+IGueta3RswI0M/FkR9FwKeiGdRf4qn24eyoS2YMfXNjlyVhaYbnUKY9bbwjHMq/YHliJwPYRdqyRkDdJn/L/O0=
X-Received: by 2002:a17:90a:408e:b0:2a5:3f1f:a1d1 with SMTP id
 l14-20020a17090a408e00b002a53f1fa1d1mr521558pjg.0.1713903758085; Tue, 23 Apr
 2024 13:22:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423172208.2723892-1-andriy.shevchenko@linux.intel.com>
 <20240423172208.2723892-4-andriy.shevchenko@linux.intel.com>
 <ZigSiCBIwoEIPYoG@lizhi-Precision-Tower-5810> <ZigUL7exXBSbWDIR@smile.fi.intel.com>
 <ZigXJJj4e+oaANAt@lizhi-Precision-Tower-5810>
In-Reply-To: <ZigXJJj4e+oaANAt@lizhi-Precision-Tower-5810>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 23 Apr 2024 17:22:25 -0300
Message-ID: <CAOMZO5CTiXWMXgi35c4M4XsdZ26-QiArXcBcViYnwTAgd00nDQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] PCI: imx6: Convert to agnostic GPIO API
To: Frank Li <Frank.li@nxp.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
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
	Pengutronix Kernel Team <kernel@pengutronix.de>, Yue Wang <yue.wang@amlogic.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Xiaowei Song <songxiaowei@hisilicon.com>, Binghui Wang <wangbinghui@hisilicon.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 5:16=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:

> if (IS_ERR(imx6_pcie->reset_gpiod)) should be true. then dev_err_probe()
> will run and print "unable to get reset gpio\n" with error code
> -EPROBE_DEFER.

dev_err_probe() will not print an error message when the error code is
-EPROBE_DEFER.

That's exactly the point of using dev_err_probe().

