Return-Path: <linux-pci+bounces-7150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3308BDF54
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 12:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E753E281BE1
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 10:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0CA14D6EB;
	Tue,  7 May 2024 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ClqbICPf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1C714E2CD
	for <linux-pci@vger.kernel.org>; Tue,  7 May 2024 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715076244; cv=none; b=PUQHuZiKmcV0ugCprX8XhKLVT09FMdlZzwJJfk34blZxyjdVNA62OYZrfBJAiD30cyMClq4KkRl1K49hEueJr3HUxPq1WvcOJSX666IuAu+Wumq/ZK0DMjETi9IUFgEbb51duFAwh0oBma3+cC/ZqCnUvSOBmWsf/VZPYol5xBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715076244; c=relaxed/simple;
	bh=jnbmoIfEkquEEjiJBAjqdCDBxOD1+Yzt7A7OKiFlJfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+ToFRVU0uv9CJKQ2xtvVSqSwDTYZYhI0lnm8CTuS4VT6R15sHJMtsbUOxM0Tw/KPPj1Fqp5hVkci4XQBf5SloNPNNEtfemAb/zpzZv1hWLjjJD9bkuDs9cBXSXw/YzFZNc2nCnCAoVdCGM8sXGKy2mvDTZUMq3Zc9THRnAgUYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ClqbICPf; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso2884384276.2
        for <linux-pci@vger.kernel.org>; Tue, 07 May 2024 03:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715076241; x=1715681041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENlfgQ3ADPUMWuBuiOLhnFoQNEtfud/j+QDtLaNAUG0=;
        b=ClqbICPfGWs4b3Kil8wr9qUk9sNcSadQx7MKrglRxSUZNtKHMoGjJUbwrtS+2iOZJY
         eadxodiGOSOVLNQMyvANf317P6IFUtwTyUHhLOt7M7tvuVa/fwz9wN/+erbwFLXG2g2y
         1oH8B115XICgrEKBcpZvfl1GSSwX37sXhcPF1RBF2im4pDZLcSScd1kn3Gou6n+G+CNJ
         MDSKhUcbfeueiOci2vFZoYnyvQC5mgekuBzf5piN9ZJrWOwhVArEPla0MNH3XSuSPEQN
         u87VP4F0SjIDS3IEoI6MmIpP0Ep7GIo0z+K7dW7iDrf4EWBDrubFEtAe81yZDOMJhAG1
         LZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715076241; x=1715681041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENlfgQ3ADPUMWuBuiOLhnFoQNEtfud/j+QDtLaNAUG0=;
        b=pj1l72n+LLskauJNf8EiJcKqZFsI1K+Ax0b11gZQX/2jZ2ojmzjpTeM0/Wa9yKaKiB
         2Sid+b/o63V9OeanOwBdGqLO9YGgAEL5mOfehUGRm6Nd+lWZ276WoGd6PoL1HNQNHPoe
         plSVxXAyREBIiMtM0O3EXyLo+jXEs4g/QZvTCqtMJjLcxGAoj2x0a2mJJSjbBmNUXqSt
         EyrpqNnW8ZRKvUtp6p9kGy4lD8O8TQ5q57whc4Zl1rrvOyOOwzM/p4vg5C0xVBOTcaQC
         gh8GymFvrw1BrR8Z8SVQ2J7mtQjEiqOfiAPQjASdVW7S0yYHJ2jmvjSDLyGWCQsOcr4e
         lAJg==
X-Forwarded-Encrypted: i=1; AJvYcCXR1kfScjW1PGkq5yzg0hxo4Hclh5tFYB2fnw5IfHP2z1Q7oUZKLh2a4qNUirJwRGOHIyYpypeYMz3AC4sm2VkAV0yie/G2GyT3
X-Gm-Message-State: AOJu0YwlbJGAGWWLCKJTL3Wc3rXve5g8y7hG4lacZ8DDjFjjP0w8+oZk
	YB3pL0v1/bVFzF2Ie26fY4GShni+dUq7qdr81TAZ+UPeE9gu8vG36BScV0WCLpg3OY1PYQXkEnA
	6frgRwPLthGxOUIEkia2yXUASXmjg1RMSXA2Cpw==
X-Google-Smtp-Source: AGHT+IE6RbboWA6zivUgxElWhiInYBOoZKZxCooBjJtVLVKzpcY065ewr27Om73FjNB7+c1CsbFfoFINBaR1I1fIna4=
X-Received: by 2002:a5b:912:0:b0:de6:3c4:c3a with SMTP id a18-20020a5b0912000000b00de603c40c3amr12223334ybq.10.1715076241415;
 Tue, 07 May 2024 03:04:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506142142.4042810-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240506142142.4042810-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 7 May 2024 12:03:50 +0200
Message-ID: <CACRpkda=a3X=jyZKQoOFrfgzpE2C+rZ9UC1VDnCvGL7QP4x4BA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] PCI: controller: Move to agnostic GPIO API
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Frank Li <Frank.Li@nxp.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
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

On Mon, May 6, 2024 at 4:22=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> In v4:
> - added tag (Mani)
> - fixed a polarity bug in iMX.6 driver (Linus)

Looks good now. The series:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Perhaps the use of  _raw accessors could be avoided in 5/5 by some
elaborart polarity quirk but I'm no perfectionist and it can be fixed later=
.

Yours,
Linus Walleij

