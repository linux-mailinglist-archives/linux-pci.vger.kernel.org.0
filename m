Return-Path: <linux-pci+bounces-44643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9ECD1A4D2
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 17:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1FC7300CF3D
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 16:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC8E30E84F;
	Tue, 13 Jan 2026 16:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBQIpbWj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2BA280A5A;
	Tue, 13 Jan 2026 16:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768322088; cv=none; b=No1UYvaSuvS7z6kedw/9nm1pRuc8jxMIk9PlpMRsd//6RbIGpRxPOfDDD2KmFPwx+h5KISzlAEezi3lsUnIwPtcAYzsxbASbAgU67PepFuk6ckrxtzXGeNPFvafcXZC3qmEVqmh7aEYgjyXl6kx8AbUxUfYxZLdFCQXCVnvbhXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768322088; c=relaxed/simple;
	bh=h0gckYf/2eQitVs/qpheSug3BpiAFpijfck5eDwbWGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gM/Mo1dGO4rID6nsKrYO4+WeLGLIbMI66OS3Ul6PT/vbLU2KyVGH2EVLiEDDIaEAYkzggZc1Ydu9bGDBi0Gik4kzi1QyWbuui5EGYD6oZjZQc7BMYxxJn975ByHpz0GB+eeGQueCsJ7BJyGjIUGfr/ZQ/ZY0chhzgatoefMdSlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBQIpbWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8B0C116C6;
	Tue, 13 Jan 2026 16:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768322088;
	bh=h0gckYf/2eQitVs/qpheSug3BpiAFpijfck5eDwbWGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FBQIpbWjH24K4Z06fK0wcuB9dT0G7ItXDQ7rKdptW7iiuM/mixJ1Z3/mDBMRMu4W2
	 cZYo/UGeP92toiDT+ZADi1aDiKQdDNsGIx/09uENsNkcdDfllDgrIurJ2qPcix+LUq
	 FhLxuv+gcvmnjabCS2sFd1CmdIiAWVSERAGXfBVOv9cP9C7HKCplH61YFkM7gkpQCX
	 A1sHICLXghk5m6+bUyHsgE4LUehprgZwsn5DlnVHliC/BSPqMnHGNByl5mmsCWJG6M
	 wwIDlTSBsb3jrTdnMgZq6ai1y3+vE65FObQAiypLy4k1ZMe7UNouaKmWIQkIideAqC
	 wSPzt8FE5AddQ==
Date: Tue, 13 Jan 2026 22:04:35 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: manivannan.sadhasivam@oss.qualcomm.com, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 8/9] power: sequencing: pcie-m2: Add support for PCIe
 M.2 Key E connectors
Message-ID: <rxfnx6cq6dqifongrmhanpltacjqdkcn2yor7d7qsrrskmhueo@m3se3iyd4pfy>
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
 <20260112-pci-m2-e-v4-8-eff84d2c6d26@oss.qualcomm.com>
 <2432dafc-4101-4b23-90b2-85ea5459435c@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2432dafc-4101-4b23-90b2-85ea5459435c@linux.dev>

On Tue, Jan 13, 2026 at 10:26:04AM -0500, Sean Anderson wrote:
> On 1/12/26 11:26, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > Add support for handling the power sequence of the PCIe M.2 Key E
> > connectors. These connectors are used to attach the Wireless Connectivity
> > devices to the host machine including combinations of WiFi, BT, NFC using
> > interfaces such as PCIe/SDIO for WiFi, USB/UART for BT and I2C for NFC.
> > 
> > Currently, this driver supports only the PCIe interface for WiFi and UART
> > interface for BT. The driver also only supports driving the 3.3v/1.8v power
> > supplies and W_DISABLE{1/2}# GPIOs. The optional signals of the Key E
> > connectors are not currently supported.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/power/sequencing/Kconfig          |   1 +
> >  drivers/power/sequencing/pwrseq-pcie-m2.c | 110 ++++++++++++++++++++++++++++--
> >  2 files changed, 104 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
> > index f5fff84566ba..29bd204319cc 100644
> > --- a/drivers/power/sequencing/Kconfig
> > +++ b/drivers/power/sequencing/Kconfig
> > @@ -38,6 +38,7 @@ config POWER_SEQUENCING_TH1520_GPU
> >  config POWER_SEQUENCING_PCIE_M2
> >  	tristate "PCIe M.2 connector power sequencing driver"
> >  	depends on OF || COMPILE_TEST
> > +	depends on PCI
> >  	help
> >  	  Say Y here to enable the power sequencing driver for PCIe M.2
> >  	  connectors. This driver handles the power sequencing for the M.2
> > diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
> > index e01e19123415..4b85a40d7692 100644
> > --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> > +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> > @@ -4,12 +4,16 @@
> >   * Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> >   */
> >  
> > +#include <linux/err.h>
> >  #include <linux/device.h>
> > +#include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/of_graph.h>
> >  #include <linux/of_platform.h>
> > +#include <linux/pci.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pwrseq/provider.h>
> >  #include <linux/regulator/consumer.h>
> > @@ -25,17 +29,19 @@ struct pwrseq_pcie_m2_ctx {
> >  	const struct pwrseq_pcie_m2_pdata *pdata;
> >  	struct regulator_bulk_data *regs;
> >  	size_t num_vregs;
> > -	struct notifier_block nb;
> > +	struct gpio_desc *w_disable1_gpio;
> > +	struct gpio_desc *w_disable2_gpio;
> > +	struct device *dev;
> >  };
> >  
> > -static int pwrseq_pcie_m2_m_vregs_enable(struct pwrseq_device *pwrseq)
> > +static int pwrseq_pcie_m2_vregs_enable(struct pwrseq_device *pwrseq)
> >  {
> >  	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
> >  
> >  	return regulator_bulk_enable(ctx->num_vregs, ctx->regs);
> >  }
> >  
> > -static int pwrseq_pcie_m2_m_vregs_disable(struct pwrseq_device *pwrseq)
> > +static int pwrseq_pcie_m2_vregs_disable(struct pwrseq_device *pwrseq)
> >  {
> >  	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
> >  
> > @@ -44,18 +50,84 @@ static int pwrseq_pcie_m2_m_vregs_disable(struct pwrseq_device *pwrseq)
> >  
> >  static const struct pwrseq_unit_data pwrseq_pcie_m2_vregs_unit_data = {
> >  	.name = "regulators-enable",
> > -	.enable = pwrseq_pcie_m2_m_vregs_enable,
> > -	.disable = pwrseq_pcie_m2_m_vregs_disable,
> > +	.enable = pwrseq_pcie_m2_vregs_enable,
> > +	.disable = pwrseq_pcie_m2_vregs_disable,
> >  };
> >  
> > -static const struct pwrseq_unit_data *pwrseq_pcie_m2_m_unit_deps[] = {
> > +static const struct pwrseq_unit_data *pwrseq_pcie_m2_unit_deps[] = {
> >  	&pwrseq_pcie_m2_vregs_unit_data,
> >  	NULL
> >  };
> >  
> > +static int pwrseq_pci_m2_e_uart_enable(struct pwrseq_device *pwrseq)
> > +{
> > +	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
> > +
> > +	return gpiod_set_value_cansleep(ctx->w_disable2_gpio, 0);
> > +}
> > +
> > +static int pwrseq_pci_m2_e_uart_disable(struct pwrseq_device *pwrseq)
> > +{
> > +	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
> > +
> > +	return gpiod_set_value_cansleep(ctx->w_disable2_gpio, 1);
> > +}
> > +
> > +static const struct pwrseq_unit_data pwrseq_pcie_m2_e_uart_unit_data = {
> > +	.name = "uart-enable",
> > +	.deps = pwrseq_pcie_m2_unit_deps,
> > +	.enable = pwrseq_pci_m2_e_uart_enable,
> > +	.disable = pwrseq_pci_m2_e_uart_disable,
> > +};
> > +
> > +static int pwrseq_pci_m2_e_pcie_enable(struct pwrseq_device *pwrseq)
> > +{
> > +	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
> > +
> > +	return gpiod_set_value_cansleep(ctx->w_disable1_gpio, 0);
> > +}
> > +
> > +static int pwrseq_pci_m2_e_pcie_disable(struct pwrseq_device *pwrseq)
> > +{
> > +	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
> > +
> > +	return gpiod_set_value_cansleep(ctx->w_disable1_gpio, 1);
> > +}
> > +
> > +static const struct pwrseq_unit_data pwrseq_pcie_m2_e_pcie_unit_data = {
> > +	.name = "pcie-enable",
> > +	.deps = pwrseq_pcie_m2_unit_deps,
> > +	.enable = pwrseq_pci_m2_e_pcie_enable,
> > +	.disable = pwrseq_pci_m2_e_pcie_disable,
> > +};
> > +
> >  static const struct pwrseq_unit_data pwrseq_pcie_m2_m_pcie_unit_data = {
> >  	.name = "pcie-enable",
> > -	.deps = pwrseq_pcie_m2_m_unit_deps,
> > +	.deps = pwrseq_pcie_m2_unit_deps,
> > +};
> > +
> > +static int pwrseq_pcie_m2_e_pwup_delay(struct pwrseq_device *pwrseq)
> > +{
> > +	/*
> > +	 * FIXME: This delay is only required for some Qcom WLAN/BT cards like
> > +	 * WCN7850 and not for all devices. But currently, there is no way to
> > +	 * identify the device model before enumeration.
> > +	 */
> > +	msleep(50);
> 
> Section 3.1.4 of the M.2 spec says that "Power Valid to PERST# input
> inactive" (T_PVPGL) is "Implementation specific recommended 50 ms." So I
> think we should delay for at least 50 ms for all M.2 cards.

Yes, this pretty much looks like T_PVPGL, but this delay is already accounted
for in pcie-qcom.c as a part of PERST# deassertion (I believe WCN7850 was tested
with Qcom host). I will check it and get back.

> Additionally, the PCIe CEM specifies that "Power stable to PERST#
> inactive" (T_PVPERL) must be at least 100 ms. So I think we should just
> delay for 100 ms regardless of the slot, perhaps making this
> configurable in the devicetree if e.g. the system integrator knows the
> soldered-down M.2 requires less initialization time. This is exactly
> what I proposed in [1].
> 

I'd love to do it in the pwrctrl/pwrseq driver, but most of the controller
drivers are already handling this delay as a part of their PERST# deassertion.
This was the only reason I didn't add the T_PVPERL delay here. Also, those
controller drivers handle non-pwrctrl design as well (for backwards
compatibility), so they need the delay anyway and it will make them messy if the
delay is only handled in non-pwrctrl case.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

