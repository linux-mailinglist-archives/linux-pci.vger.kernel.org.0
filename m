Return-Path: <linux-pci+bounces-34665-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 430E4B3466B
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 17:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22EC161B66
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 15:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B792FDC42;
	Mon, 25 Aug 2025 15:57:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53159259C83
	for <linux-pci@vger.kernel.org>; Mon, 25 Aug 2025 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756137421; cv=none; b=L51SL3KIAO+ehdqAoHgETXtuHCYPZaeGQf0mNW2nXPKFnalsbVzVNiZytEDoDVHRbeFruKAKwIJMJSvkQDVLGUThQO15HWwwFDNli2kxYd7sjAe/vREXyIT1neWR59UkCpWZUpvtkqljsUT0kPKbHHCfc0/3075hzYbfOf37pYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756137421; c=relaxed/simple;
	bh=4cNWv4HsIy+0tAeRLpaonopaZeHAr5GnHLxGFQXG19E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jTPupXpDstx4arWkB7T+yN/B33RIVgsWfhKGsd2xDMXxJ3Q338f5Frv5pecd3lv/7hMTZx4Se87Fv7t3AwBr/HEbyHxuMYfihC1sOVzGBgFFag13gPOgS4peWmbv+fm2wyNO0x5VtjEmqQ+Cpj8iF9Xzt8j/Z64v1MsCASA4ZnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uqZYd-0003lu-Pz; Mon, 25 Aug 2025 17:56:31 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uqZYZ-0025Zy-04;
	Mon, 25 Aug 2025 17:56:27 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uqZYY-000dPY-2w;
	Mon, 25 Aug 2025 17:56:26 +0200
Message-ID: <ca0aabeae81758a64bcad5f8113962e79b06ffd5.camel@pengutronix.de>
Subject: Re: [PATCH v13 04/11] PCI: stm32: Add PCIe host support for
 STM32MP25
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Christian Bruel <christian.bruel@foss.st.com>, lpieralisi@kernel.org, 
 kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
 bhelgaas@google.com,  krzk+dt@kernel.org, conor+dt@kernel.org,
 mcoquelin.stm32@gmail.com,  alexandre.torgue@foss.st.com,
 linus.walleij@linaro.org, corbet@lwn.net,  shradha.t@samsung.com,
 mayank.rana@oss.qualcomm.com, namcao@linutronix.de, 
 qiang.yu@oss.qualcomm.com, thippeswamy.havalige@amd.com,
 inochiama@gmail.com,  quic_schintav@quicinc.com
Cc: johan+linaro@kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org
Date: Mon, 25 Aug 2025 17:56:26 +0200
In-Reply-To: <7378edca-12f4-44a1-9c2a-ea07ebab4ad0@foss.st.com>
References: <20250820075411.1178729-1-christian.bruel@foss.st.com>
	 <20250820075411.1178729-5-christian.bruel@foss.st.com>
	 <e67d5a27fb00040ba87a0b108322747ecca8d05b.camel@pengutronix.de>
	 <7378edca-12f4-44a1-9c2a-ea07ebab4ad0@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org

On Mo, 2025-08-25 at 16:47 +0200, Christian Bruel wrote:
>=20
> On 8/25/25 11:15, Philipp Zabel wrote:
> > On Mi, 2025-08-20 at 09:54 +0200, Christian Bruel wrote:
> > > Add driver for the STM32MP25 SoC PCIe Gen1 2.5 GT/s and Gen2 5GT/s
> > > controller based on the DesignWare PCIe core.
> > >=20
> > > Supports MSI via GICv2m, Single Virtual Channel, Single Function
> > >=20
> > > Supports WAKE# GPIO.
> > >=20
> > > Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> > > ---
> > >   drivers/pci/controller/dwc/Kconfig      |  12 +
> > >   drivers/pci/controller/dwc/Makefile     |   1 +
> > >   drivers/pci/controller/dwc/pcie-stm32.c | 360 +++++++++++++++++++++=
+++
> > >   drivers/pci/controller/dwc/pcie-stm32.h |  15 +
> > >   4 files changed, 388 insertions(+)
> > >   create mode 100644 drivers/pci/controller/dwc/pcie-stm32.c
> > >   create mode 100644 drivers/pci/controller/dwc/pcie-stm32.h
> > >=20
> > > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/control=
ler/dwc/Kconfig
> > > index deafc512b079..a8174817fd5b 100644
> > > --- a/drivers/pci/controller/dwc/Kconfig
> > > +++ b/drivers/pci/controller/dwc/Kconfig
> > > @@ -423,6 +423,18 @@ config PCIE_SPEAR13XX
> > >   	help
> > >   	  Say Y here if you want PCIe support on SPEAr13XX SoCs.
> > >  =20
> > > +config PCIE_STM32_HOST
> > > +	tristate "STMicroelectronics STM32MP25 PCIe Controller (host mode)"
> > > +	depends on ARCH_STM32 || COMPILE_TEST
> > > +	depends on PCI_MSI
> > > +	select PCIE_DW_HOST
> > > +	help
> > > +	  Enables Root Complex (RC) support for the DesignWare core based P=
CIe
> > > +	  controller found in STM32MP25 SoC.
> > > +
> > > +	  This driver can also be built as a module. If so, the module
> > > +	  will be called pcie-stm32.
> > > +
> > >   config PCI_DRA7XX
> > >   	tristate
> > >  =20
> > > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/contro=
ller/dwc/Makefile
> > > index 6919d27798d1..1307a87b1cf0 100644
> > > --- a/drivers/pci/controller/dwc/Makefile
> > > +++ b/drivers/pci/controller/dwc/Makefile
> > > @@ -31,6 +31,7 @@ obj-$(CONFIG_PCIE_UNIPHIER) +=3D pcie-uniphier.o
> > >   obj-$(CONFIG_PCIE_UNIPHIER_EP) +=3D pcie-uniphier-ep.o
> > >   obj-$(CONFIG_PCIE_VISCONTI_HOST) +=3D pcie-visconti.o
> > >   obj-$(CONFIG_PCIE_RCAR_GEN4) +=3D pcie-rcar-gen4.o
> > > +obj-$(CONFIG_PCIE_STM32_HOST) +=3D pcie-stm32.o
> > >  =20
> > >   # The following drivers are for devices that use the generic ACPI
> > >   # pci_root.c driver but don't support standard ECAM config access.
> > > diff --git a/drivers/pci/controller/dwc/pcie-stm32.c b/drivers/pci/co=
ntroller/dwc/pcie-stm32.c
> > > new file mode 100644
> > > index 000000000000..964fa6f674c8
> > > --- /dev/null
> > > +++ b/drivers/pci/controller/dwc/pcie-stm32.c
> > > @@ -0,0 +1,360 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * STMicroelectronics STM32MP25 PCIe root complex driver.
> > > + *
> > > + * Copyright (C) 2025 STMicroelectronics
> > > + * Author: Christian Bruel <christian.bruel@foss.st.com>
> > > + */
> > > +
> > > +#include <linux/clk.h>
> > > +#include <linux/mfd/syscon.h>
> > > +#include <linux/of_platform.h>
> > > +#include <linux/phy/phy.h>
> > > +#include <linux/pinctrl/consumer.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pm_runtime.h>
> > > +#include <linux/pm_wakeirq.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/reset.h>
> > > +#include "pcie-designware.h"
> > > +#include "pcie-stm32.h"
> > > +#include "../../pci.h"
> > > +
> > > +struct stm32_pcie {
> > > +	struct dw_pcie pci;
> > > +	struct regmap *regmap;
> > > +	struct reset_control *rst;
> >=20
> > This could be a local variable in stm32_pcie_probe().
>
> Thank you for pointing that out.
>=20
> Since we use the same common resources in stm32_pcie for both the host=
=20
> and endpoint drivers, aligning the same fields in the struct stm32_pcie=
=20
> seems more consistent.

I hadn't seen the host driver at that point.

Aligning struct stm32_pcie with another struct in another .c file as an
unwritten rule doesn't make sense to me. If parts of the structs should
be kept aligned between host and endpoint drivers, it would be better
to define a common base struct in a shared header.

> Additionally, we could improve the code by moving regmap, clk, and rst=
=20
> out of probe into a new function, stm32_pcie_resource_get().
>=20
> Which approach do you think is best? Moving rst to stm32_pcie_probe()=20
> offers slight optimization,

This option would be my preference, but it's not a strong one.

Storing a single pointer unnecessarily isn't a big deal.
My mind just went "where is it used? - oh, nowhere", so I thought I'd
point that out.

> while using a new stm32_pcie_resource_get()=20
> provides better modularity.

I think this isn't enough code to warrant sharing
stm32_pcie_resource_get() between host and endpoint drivers in the
absence of other shared code.

Whether splitting this out in each driver improves readability of the
probe functions is a matter of taste. I think it's fine as-is. I
wouldn't argue against the change either.

> Shall I re-spin a v14 with either of these options?

Don't respin just for this.

regards
Philipp

