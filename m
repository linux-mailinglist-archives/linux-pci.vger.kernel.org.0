Return-Path: <linux-pci+bounces-3525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EF5856814
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 16:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076BE1F2EE74
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 15:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E107E13343A;
	Thu, 15 Feb 2024 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dg144ddc"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0E413247C
	for <linux-pci@vger.kernel.org>; Thu, 15 Feb 2024 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011619; cv=none; b=AiZGnvTSBhhB2c+Ha74kNGvHyScWIw1fG2pyM9ixwE4TjxQC9XsSjsxt1KaHCSWnpuewKBLGc9aEU+kWaPyiW8O5Pyepfoji8kbp1opWIH7pM9Dp7Sq9twvLl/ZftXSOgr1YCl4E3fNmzHPSaQHX6o0Q/v9O4PnefridCwBAwps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011619; c=relaxed/simple;
	bh=+yANVhkKBRg6rMKd200NRYNJJEXP2I/1oNYT8u0WSZ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eP7bpMolHGH+B3gtee5BB3y/MSfd3wMHTjWrTR3+t4kfivGekFSQtnwu/6csWtyZgXlFhu9uuXk+f2MLGH1FTcMjvcWBshwG0QkMl8kF5dkEXGx0oUh6dzuvEIjHIgt2uXu4sbRw5CSnZ8onr1Gv0Vdl8bb2tvS6Uo5cccGBDus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dg144ddc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708011617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+yANVhkKBRg6rMKd200NRYNJJEXP2I/1oNYT8u0WSZ8=;
	b=dg144ddckQcOC52Df1fvZJsJ5u+9BRvkmiT2xzEG2juGczijKPs5Xip+vG/7gLO7rjUtyV
	juxFaGoeEWqmlWtLntQjWGTMAh4vchmWxkYahrc06ol91xRJb3RBssluEojOptxEWgik2d
	imyhWU0oqoVhLglk0zTDbVe1PJ0VbaM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-iTWUvAuVMimuMHCE1mXDeg-1; Thu, 15 Feb 2024 10:40:15 -0500
X-MC-Unique: iTWUvAuVMimuMHCE1mXDeg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-68ef09a0d44so694736d6.0
        for <linux-pci@vger.kernel.org>; Thu, 15 Feb 2024 07:40:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708011615; x=1708616415;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+yANVhkKBRg6rMKd200NRYNJJEXP2I/1oNYT8u0WSZ8=;
        b=qvy76H5WFSpPp12wRbOt6g4o1Z7dXAIp482JcHxSKa84FEPA+ZImqHqYoUaieoI8Fs
         kuPkq3Oj9QLlgo72yee+U6GoDa5mZZjcGleEkEK3BCyDHj6xAKEHLI+J4StjoJfq+UYT
         06yGff+FIOLGOt7K6nL9GE+G2QTHXQdy9YR2VaS7es7AbJm9Xkom26lee1VUWyOiG0tI
         2166eBQ5+qnH+rq/yGUrElmv/7Y8t+EPYa2JMEu2uMrbryW4/qqKSTXijsjaYyufpOtW
         4E+N4Hlnb8OYUordFUj0HRv6IpJFQ3NudTHlcwKh7cR7XrddwzjO63Qx5N5I+xlhB29U
         Lruw==
X-Forwarded-Encrypted: i=1; AJvYcCXotLuab9i8Lzn7iz86vprqi5g48klnmfLZd9iKy4K7zheIY1d8Szywx44DDOOKWrZAKLHzWZFNWmYIZA0M/eb4Gkng/QixqY6b
X-Gm-Message-State: AOJu0YykoRHS5V5iPK/piQBiWZc3b74j9dLZbG1etfjGl1QUKoPZ6EFu
	Kx2vfZLLiF1E4ThF80tGytKJY653V520dQAW7pdbvgSOUxbrUpfQ+ptzR18Fgq0Y8L76QOnDMQg
	gzRDJjnvlZMUOfe73y8LbY/4PfDYx3aAs0b2nhIvKfmH2FggtmqZR0Ux6kA==
X-Received: by 2002:ad4:4f46:0:b0:68f:1c80:d78e with SMTP id eu6-20020ad44f46000000b0068f1c80d78emr1490740qvb.0.1708011615189;
        Thu, 15 Feb 2024 07:40:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbtlVC/hGxHqWa+JvIvatJrzEI/QuA/8sl8WvotcGQkSTUkqacb3XlI7fMhv/pLNBSQy8g9w==
X-Received: by 2002:ad4:4f46:0:b0:68f:1c80:d78e with SMTP id eu6-20020ad44f46000000b0068f1c80d78emr1490716qvb.0.1708011614822;
        Thu, 15 Feb 2024 07:40:14 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id oh9-20020a056214438900b00684225ef3a0sm750964qvb.93.2024.02.15.07.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 07:40:14 -0800 (PST)
Message-ID: <1b2ffe636a19faef87b9c48fee6d17bfb9f1a3bf.camel@redhat.com>
Subject: Re: [PATCH v3 00/18] Add suspend to ram support for PCIe on J7200
From: Philipp Stanner <pstanner@redhat.com>
To: Thomas Richard <thomas.richard@bootlin.com>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Andy
 Shevchenko <andy@kernel.org>, Tony Lindgren <tony@atomide.com>, Haojian
 Zhuang <haojian.zhuang@linaro.org>,  Vignesh R <vigneshr@ti.com>, Aaro
 Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>,
 Andi Shyti <andi.shyti@kernel.org>, Peter Rosin <peda@axentia.se>, Vinod
 Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>,  Rob Herring <robh@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-pci@vger.kernel.org, gregory.clement@bootlin.com,
 theo.lebrun@bootlin.com,  thomas.petazzoni@bootlin.com, u-kumar1@ti.com,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Andy Shevchenko
 <andy.shevchenko@gmail.com>
Date: Thu, 15 Feb 2024 16:40:10 +0100
In-Reply-To: <20240102-j7200-pcie-s2r-v3-0-5c2e4a3fac1f@bootlin.com>
References: <20240102-j7200-pcie-s2r-v3-0-5c2e4a3fac1f@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-15 at 16:17 +0100, Thomas Richard wrote:
> This add suspend to ram support for the PCIe (RC mode) on J7200
> platform.
>=20
> In RC mode, the reset pin for endpoints is managed by a gpio expander
> on a
> i2c bus. This pin shall be managed in suspend_noirq() and
> resume_noirq().
> The suspend/resume has been moved to suspend_noirq()/resume_noirq()
> for
> pca953x (expander) and pinctrl-single.
>=20
> To do i2c accesses during suspend_noirq/resume_noirq, we need to
> force the
> wakeup of the i2c controller (which is autosuspended) during suspend
> callback.=20
> It's the only way to wakeup the controller if it's autosuspended, as
> runtime pm is disabled in suspend_noirq and resume_noirq.
>=20
> The main change in this v3 is the removal of the probe boolean for
> the
> functions wiz_clock_probe() and cdns_pcie_host_setup().
> Their contents were split in multiple functions which are called in
> the
> resume_noirq() callbacks.
>=20
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
> Changes in v3:
> - pinctrl-single: split patch in two parts, a first patch to remove
> the
> =C2=A0 dead code, a second to move suspend()/resume() callbacks to noirq.
> - i2c-omap: add a comments above the suspend_noirq() callback.
> - mux: now mux_chip_resume() try to restores all muxes, then return 0
> if
> =C2=A0 all is ok or the first failure.
> - mmio: fix commit message.
> - phy-j721e-wiz: add a patch to use dev_err_probe() instead of
> dev_err() in
> =C2=A0 the wiz_clock_init() function.
> - phy-j721e-wiz: remove probe boolean for the wiz_clock_init(),
> rename the
> =C2=A0 function to wiz_clock_probe(), extract hardware configuration part
> in a
> =C2=A0 new function wiz_clock_init().
> - phy-cadence-torrent: use dev_err_probe() and fix commit messages
> - pcie-cadence-host: remove probe boolean for the
> cdns_pcie_host_setup()
> =C2=A0 function and extract the link setup part in a new function
> =C2=A0 cdns_pcie_host_link_setup().
> - pcie-cadence-host: make cdns_pcie_host_init() global.
> - pci-j721e: use the cdns_pcie_host_link_setup()
> cdns_pcie_host_init()
> =C2=A0 functions in the resume_noirq() callback.
> - Link to v2:
> https://lore.kernel.org/r/20240102-j7200-pcie-s2r-v2-0-8e4f7d228ec2@bootl=
in.com
>=20
> Changes in v2:
> - all: fix commits messages.
> - all: use DEFINE_NOIRQ_DEV_PM_OPS and pm_sleep_ptr macros.
> - all: remove useless #ifdef CONFIG_PM.
> - pinctrl-single: drop dead code
> - mux: add mux_chip_resume() function in mux core.
> - mmio: resume sequence is now a call to mux_chip_resume().
> - phy-cadence-torrent: fix typo in resume sequence
> (reset_control_assert()
> =C2=A0 instead of reset_control_put()).
> - phy-cadence-torrent: use PHY instead of phy.
> - pci-j721e: do not shadow cdns_pcie_host_setup return code in resume
> =C2=A0 sequence.
> - pci-j721e: drop dead code.
> - Link to v1:
> https://lore.kernel.org/r/20240102-j7200-pcie-s2r-v1-0-84e55da52400@bootl=
in.com
>=20
> ---
> Thomas Richard (15):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpio: pca953x: move suspend()/resume() to
> suspend_noirq()/resume_noirq()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl: pinctrl-single: remove dead code =
in suspend() and
> resume() callbacks
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl: pinctrl-single: move suspend()/re=
sume() callbacks to
> noirq
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i2c: omap: wakeup the controller during su=
spend() callback
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mux: add mux_chip_resume() function
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phy: ti: phy-j721e-wiz: use dev_err_probe(=
) instead of
> dev_err()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phy: ti: phy-j721e-wiz: split wiz_clock_in=
it() function
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phy: ti: phy-j721e-wiz: add resume support
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phy: cadence-torrent: extract calls to clk=
_get from
> cdns_torrent_clk
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phy: cadence-torrent: register resets even=
 if the phy is
> already configured
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phy: cadence-torrent: add already_configur=
ed to struct
> cdns_torrent_phy
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phy: cadence-torrent: remove noop_ops phy =
operations
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phy: cadence-torrent: add suspend and resu=
me support
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PCI: cadence: extract link setup sequence =
from
> cdns_pcie_host_setup()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PCI: cadence: set cdns_pcie_host_init() gl=
obal
>=20
> Th=C3=A9o Lebrun (3):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mux: mmio: add resume support
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PCI: j721e: add reset GPIO to struct j721e=
_pcie
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PCI: j721e: add suspend and resume support


For the PCI patches Bjorn is most likely going to ask you to adjust
them to PCI's common commit style; see here [1]

In particular, PCI (afaik) has no convention for naming subcomponents
such as j721e and the info following the : is written beginning with an
upper case, e.g.

PCI: Add suspend and resume support for j721e


Regards,
P.

[1] https://lore.kernel.org/linux-pci/20171026223701.GA25649@bhelgaas-glapt=
op.roam.corp.google.com/


>=20
> =C2=A0drivers/gpio/gpio-pca953x.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +-
> =C2=A0drivers/i2c/busses/i2c-omap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 22 ++++
> =C2=A0drivers/mux/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 30 +++++
> =C2=A0drivers/mux/mmio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 12 ++
> =C2=A0drivers/pci/controller/cadence/pci-j721e.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 102
> ++++++++++++++++-
> =C2=A0drivers/pci/controller/cadence/pcie-cadence-host.c |=C2=A0 44 +++++=
---
> =C2=A0drivers/pci/controller/cadence/pcie-cadence.h=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 12 ++
> =C2=A0drivers/phy/cadence/phy-cadence-torrent.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 121
> +++++++++++++++------
> =C2=A0drivers/phy/ti/phy-j721e-wiz.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 119
> +++++++++++++-------
> =C2=A0drivers/pinctrl/pinctrl-single.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 28 ++---
> =C2=A0include/linux/mux/driver.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A011 files changed, 380 insertions(+), 118 deletions(-)
> ---
> base-commit: 00ff0f9ce40db8e64fe16c424a965fd7ab769c42
> change-id: 20240102-j7200-pcie-s2r-ecb1a979e357
>=20
> Best regards,


