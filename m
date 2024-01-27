Return-Path: <linux-pci+bounces-2621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 064B283F0B1
	for <lists+linux-pci@lfdr.de>; Sat, 27 Jan 2024 23:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19D71F257D3
	for <lists+linux-pci@lfdr.de>; Sat, 27 Jan 2024 22:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D321D6AA;
	Sat, 27 Jan 2024 22:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cHleKZ0J"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557461DFCA
	for <linux-pci@vger.kernel.org>; Sat, 27 Jan 2024 22:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706394686; cv=none; b=ZlpPllKCKL/6EnqqKDgdU7xEFG1/O6MiyrIlRXumzW6gPc+0sx++B/h1nxYbaSdPbydoulwvPn8uERFU31aF/U1I/0fcHSefy+jrmxiMDbjEwd8zmJP0V5AhG69p4wvsH1+Hzo4DlwI7qVC3b6AnOwZ/c36x1C8V5KJqNIDC/1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706394686; c=relaxed/simple;
	bh=1dBUeUlto5pgjnZjs4MdTR5SQtmL2Ucvd23RmHx3BTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpNRNxxo3U5fewXimlGO0NKQWCL70qFqNCL+BgX14XJBMGm1CgWLSJ54eKjyDGqs5I37gr18W2v5xyW1B60RXuO8W61MwQLNxOrC5G5y9ZPZyXiih5hHvYz+VGrbZ7FYrPduBLXuDmew1jt12Wbz3hXQhuMnwauKuTwEFYGBEe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cHleKZ0J; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5ffcb478512so10965447b3.0
        for <linux-pci@vger.kernel.org>; Sat, 27 Jan 2024 14:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706394683; x=1706999483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dBUeUlto5pgjnZjs4MdTR5SQtmL2Ucvd23RmHx3BTY=;
        b=cHleKZ0JcJEZlpoUaX9P+Lv8Q1pdXZQBACsRpogl1frJ+eJ+RVKcyfv96ZaVksV7J7
         Kv5vjXHtp+Pe9uj+QBopb3KOXNGx9E0Z0pm3ozUx7Ui2CslZrePd0ZiZUK57Mma6Nzvx
         eHrpLpN/2y+1hNnJL4LMmjkd3mjpgBt30lm72g48mcCcKSpx0MLCadNnMW+G+4Wi36bE
         FEoGgo4+uDR2nSuetbQmPIAiEocp3YFKrZ5zHv0lXbrYJa2Z/xKCCgc/f9YfNtwOJ/g0
         TLoRLqLL4+p3OtromgncIXxLahR7FdlR1IMOMYpHOEUdyG1bZYKP4NCOSjxS6QOlgQlE
         w1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706394683; x=1706999483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dBUeUlto5pgjnZjs4MdTR5SQtmL2Ucvd23RmHx3BTY=;
        b=Fqzv8d0mOSe9OH8ye6HG/+N8CVLV8UmLzlXE0L0uph9XTeyY9iAFppLDfVMpIx/udF
         SBh3kHK9zxoSQyAl9mPlhpy5PTfC4L3wpDnZFI6TKBw0jYHn9rtfqDqXPjemJQ8hjPFz
         cEXcNlioq31Frf9CNQRrW9yiRNC7zADhhKhmeZRbfOFcoKOy/AY3w/xLL0P9JHYqNEnO
         NOzUtQsl5MoEWPIL8WPbG8BK8oEr5MKNXH3payTG+Mbq/dthr0+phL5k/OQUTS+GLPnK
         ddBueoURH9l6tlZSf+e1qNXMg4B7WbWyKllTE5JXVzhJqopxrS780RIH0lRhFMtg0BV9
         cVlg==
X-Gm-Message-State: AOJu0YwBfORBdC89ja3PgoCCVWhGSlJFIn5+Dhk0LImMa4DjjZwrY3qc
	6I9dCYeR3hOM0lxuq6colJ29A6ukw7Q6w/ZzsxVhsoTpDZJ4aJjxnRCy3aT+SdYopYp0sm8P0A9
	pM81cidX26ppXjDn7YZfYVW5NfWb5BvgTXSW9fQ==
X-Google-Smtp-Source: AGHT+IHztRxFG/ccy+YnFlBSRiS8OsDLI+aB8k67iKO1nxm2sl8UZpFQH9rExIgVxfgB6WROcfzh5M2ZahRGH+kk4fo=
X-Received: by 2002:a05:690c:809:b0:5ff:cb36:2219 with SMTP id
 bx9-20020a05690c080900b005ffcb362219mr1863709ywb.35.1706394683112; Sat, 27
 Jan 2024 14:31:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102-j7200-pcie-s2r-v2-0-8e4f7d228ec2@bootlin.com> <20240102-j7200-pcie-s2r-v2-2-8e4f7d228ec2@bootlin.com>
In-Reply-To: <20240102-j7200-pcie-s2r-v2-2-8e4f7d228ec2@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 27 Jan 2024 23:31:11 +0100
Message-ID: <CACRpkdYBnQ6xh2yNsnvquTOq5r7NeDhot6To9myfuNbonKcgzQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/15] pinctrl: pinctrl-single: move suspend()/resume()
 callbacks to noirq
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Haojian Zhuang <haojian.zhuang@linaro.org>, Vignesh R <vigneshr@ti.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Peter Rosin <peda@axentia.se>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Tom Joseph <tjoseph@cadence.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org, 
	gregory.clement@bootlin.com, theo.lebrun@bootlin.com, 
	thomas.petazzoni@bootlin.com, u-kumar1@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 3:37=E2=80=AFPM Thomas Richard
<thomas.richard@bootlin.com> wrote:

> The goal is to extend the active period of pinctrl.
> Some devices may need active pinctrl after suspend() and/or before
> resume().
> So move suspend()/resume() to suspend_noirq()/resume_noirq() in order to
> have active pinctrl until suspend_noirq() (included), and from
> resume_noirq() (included).
>
> The deprecated API has been removed to use the new one (dev_pm_ops struct=
).
>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Do you want to merge this as a series or is this something I
should just apply?

Yours,
Linus Walleij

