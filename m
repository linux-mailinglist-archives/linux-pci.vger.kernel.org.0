Return-Path: <linux-pci+bounces-675-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B0080A065
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 11:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACBD22813F2
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 10:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8412A14266;
	Fri,  8 Dec 2023 10:16:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8208E1708
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 02:16:37 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1rBXuC-0001oc-U3; Fri, 08 Dec 2023 11:16:25 +0100
Message-ID: <0cd40cf388e70b101b3857220fd7a74cf75cfa81.camel@pengutronix.de>
Subject: Re: [PATCH 1/4] PCI: imx6: Add pci host wakeup support on imx
 platforms.
From: Lucas Stach <l.stach@pengutronix.de>
To: Sherry Sun <sherry.sun@nxp.com>, hongxing.zhu@nxp.com, 
 lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 shawnguo@kernel.org,  s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com
Cc: linux-imx@nxp.com, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 08 Dec 2023 11:16:23 +0100
In-Reply-To: <20231208091355.1417292-2-sherry.sun@nxp.com>
References: <20231208091355.1417292-1-sherry.sun@nxp.com>
	 <20231208091355.1417292-2-sherry.sun@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org

Am Freitag, dem 08.12.2023 um 17:13 +0800 schrieb Sherry Sun:
> Add pci host wakeup feature for imx platforms.
> Example of configuring the corresponding dts property under the PCI
> node:
> host-wake-gpio =3D <&gpio5 21 GPIO_ACTIVE_LOW>;
>=20
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 69 +++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>=20
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 74703362aeec..050c9140f4a3 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -72,6 +72,7 @@ struct imx6_pcie_drvdata {
>  struct imx6_pcie {
>  	struct dw_pcie		*pci;
>  	int			reset_gpio;
> +	int			host_wake_irq;
>  	bool			gpio_active_high;
>  	bool			link_is_up;
>  	struct clk		*pcie_bus;
> @@ -1237,11 +1238,46 @@ static int imx6_pcie_resume_noirq(struct device *=
dev)
>  	return 0;
>  }
> =20
> +static int imx6_pcie_suspend(struct device *dev)
> +{
> +	struct imx6_pcie *imx6_pcie =3D dev_get_drvdata(dev);
> +
> +	if (imx6_pcie->host_wake_irq >=3D 0)
> +		enable_irq_wake(imx6_pcie->host_wake_irq);
> +
> +	return 0;
> +}
> +
> +static int imx6_pcie_resume(struct device *dev)
> +{
> +	struct imx6_pcie *imx6_pcie =3D dev_get_drvdata(dev);
> +
> +	if (imx6_pcie->host_wake_irq >=3D 0)
> +		disable_irq_wake(imx6_pcie->host_wake_irq);
> +
> +	return 0;
> +}
> +
>  static const struct dev_pm_ops imx6_pcie_pm_ops =3D {
>  	NOIRQ_SYSTEM_SLEEP_PM_OPS(imx6_pcie_suspend_noirq,
>  				  imx6_pcie_resume_noirq)
> +	SYSTEM_SLEEP_PM_OPS(imx6_pcie_suspend, imx6_pcie_resume)
>  };
> =20
> +irqreturn_t host_wake_irq_handler(int irq, void *priv)
> +{
> +	struct imx6_pcie *imx6_pcie =3D priv;
> +	struct device *dev =3D imx6_pcie->pci->dev;
> +
> +	dev_dbg(dev, "%s: host wakeup by pcie", __func__);
> +
Not sure how much value this debug print carries. If you want to keep
it, drop the __func__. There is no other place in this driver handling
the wakeup, so the function name in the print is pure noise.

> +	/* Notify PM core we are wakeup source */
> +	pm_wakeup_event(dev, 0);
> +	pm_system_wakeup();
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int imx6_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> @@ -1250,6 +1286,7 @@ static int imx6_pcie_probe(struct platform_device *=
pdev)
>  	struct device_node *np;
>  	struct resource *dbi_base;
>  	struct device_node *node =3D dev->of_node;
> +	struct gpio_desc *host_wake_gpio;
>  	int ret;
>  	u16 val;
> =20
> @@ -1457,6 +1494,32 @@ static int imx6_pcie_probe(struct platform_device =
*pdev)
>  			val |=3D PCI_MSI_FLAGS_ENABLE;
>  			dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
>  		}
> +
> +		/* host wakeup support */
> +		imx6_pcie->host_wake_irq =3D -1;
> +		host_wake_gpio =3D devm_gpiod_get_optional(dev, "host-wake", GPIOD_IN)=
;
> +		if (IS_ERR(host_wake_gpio))
> +			return PTR_ERR(host_wake_gpio);
> +
> +		if (host_wake_gpio !=3D NULL) {
> +			imx6_pcie->host_wake_irq =3D gpiod_to_irq(host_wake_gpio);
> +			ret =3D devm_request_threaded_irq(dev, imx6_pcie->host_wake_irq, NULL=
,
> +							host_wake_irq_handler,
> +							IRQF_ONESHOT | IRQF_TRIGGER_FALLING,
> +							"host_wake", imx6_pcie);
> +			if (ret) {
> +				dev_err(dev, "Failed to request host_wake_irq %d (%d)\n",
> +					imx6_pcie->host_wake_irq, ret);
> +				imx6_pcie->host_wake_irq =3D -1;

What's the point of resetting host_wake_irq to -1 in those error paths?
Nobody is going to access this member anymore after the error. Just
drop this.

You could simplify all those error paths to
if (err)
    return dev_err_probe(...);

> +				return ret;
> +			}
> +
> +			if (device_init_wakeup(dev, true)) {
> +				dev_err(dev, "fail to init host_wake_irq\n");
> +				imx6_pcie->host_wake_irq =3D -1;
> +				return ret;
> +			}
> +		}
>  	}
> =20
>  	return 0;
> @@ -1466,6 +1529,12 @@ static void imx6_pcie_shutdown(struct platform_dev=
ice *pdev)
>  {
>  	struct imx6_pcie *imx6_pcie =3D platform_get_drvdata(pdev);
> =20
> +	if (imx6_pcie->host_wake_irq >=3D 0) {
> +		device_init_wakeup(&pdev->dev, false);
> +		disable_irq(imx6_pcie->host_wake_irq);
> +		imx6_pcie->host_wake_irq =3D -1;
> +	}
> +
>  	/* bring down link, so bootloader gets clean state in case of reboot */
>  	imx6_pcie_assert_core_reset(imx6_pcie);
>  }


