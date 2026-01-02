Return-Path: <linux-pci+bounces-43929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA45CEE57B
	for <lists+linux-pci@lfdr.de>; Fri, 02 Jan 2026 12:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE8423024E71
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jan 2026 11:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C14B2F12BF;
	Fri,  2 Jan 2026 11:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="quyGjldQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8024B2F12C3
	for <linux-pci@vger.kernel.org>; Fri,  2 Jan 2026 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767353199; cv=none; b=X8bpRjpRxdc162qudng2PlGUey0stF5eEJJhFXJ9+uhobzcSp8KhVX6ZCjs/5jQ17WqSJmEk++K/Bo23oTW+nmt7b9BYs8qp3GuRozMdU0Hpj/J9arXXPEP39TIHs8UNtiL7BKscLZpVgR3gdswMh0AH46eU0VPxE5x7YkREDvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767353199; c=relaxed/simple;
	bh=6gt0lCtYfDrnE8WlSXS1Mph8bJZZDD2O6n9Kjt2/TTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfdpdmKiktwsMvt59Tac94DD3sWoXUGEJe4QIrAncqbQY8c8k7zbgg4z7jgcS1abqKsNQsm8YAgoDR/XoiH7eBifbkywyTDdpWkcLnVQzjWdDUbP1d2FcZzNpNYrbey2MyH+Kz6ynB8Oc20t3r9CuymDMd0kU3X3MxuECXkO/G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=quyGjldQ; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-37a2dced861so122702041fa.1
        for <linux-pci@vger.kernel.org>; Fri, 02 Jan 2026 03:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1767353194; x=1767957994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=poHpaeklp4IY+w+Q9FeQOfXydnUU88YIobaVeAHqVDs=;
        b=quyGjldQ6mQNV2/GSU5cxzFEjOuItZMKwLU6C0YWUTCYXOyrEcY60/DD9xWdjbwr15
         Vj3SdSZzXPO7p1oSNBcg/AXw7y07Qq3o+4BtANAERNfccjlEcvrMydAKnLorin+XN1gS
         W2C/C9B4ETKNuBsOWXjMpIoEQ0e3epwe0J5TvadAVrXf9uBjEnL5vc7+QNwl0vtDs/HP
         hEkZv5v49mndDJAbXDL+CDQKeTOK+vvh7ZebNO8PAYW0jZ1vseboPouKv3lnhyXTCkoI
         sVmxOALAGrpbojMXZ0SKX4qr621xowTMHR4hSvGgjtL3YpiebWvdLxtZ+UJIIDTc+V5S
         w3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767353194; x=1767957994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=poHpaeklp4IY+w+Q9FeQOfXydnUU88YIobaVeAHqVDs=;
        b=q94a02HbD6iQBiQIBod5PpebufqerRJIW+cfFVDzWQO/OJERYgSiAyI8S1aPR6AcyO
         oY+yFOJWLS6x2m0Ch/u+xzeuj/tM1daX/ub+tf3fHTeefgy71+PViB2KrAGsGjTx+tpY
         3XYFH4ajYPlhhCfyzZ4uV5Skz29oeXEPZwD3aL1eGgiaHWPLGB3kmRW3OEF2GYEec/sb
         Qjzjod8XAEslz8fmeyVMAYWeCWqIWUPFi45MEwq6V0xx80lMKnvW02nny3VmG1DzAm5f
         nmLyxp/iLpCoO6Pgz1YjwDOI+hFzvp1pugoFdmXSHqrb3xTXkbc9jl+lod5r0t7b/04F
         oUPg==
X-Forwarded-Encrypted: i=1; AJvYcCV9T7EmhW7sFXWC04N+YNt5crUi4x0+hnlwGIi/td7nxqpXw6Q/nNpBh7tBCoA3xzNxG4OtZ8urvgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsiWsk42u6ru8AChm6zUIx47j+44uPOj7zwfQpVn2kffteo9nx
	K+TJwXvYHsuyuUABmwRnC2fdoPsOVazP0W212Lhoif+B6966VZnEs1IJ8pVhXaSDJi3eUXlzjMO
	rNJPNb62//ntOXBYBwD0O2Gf+ZAz/BFIDpFjoYmOx6w==
X-Gm-Gg: AY/fxX4VOyeLFBEX5TtYdagZLkQPCGiC3+l+/Ydyna4uD3K8cj2QmQ0O4cEVYhYXN/6
	ytoolAnsFE/c1KGN4+A6TxRCmgwVcQ4B0HQwub9ZvmydhGp/l8isyFFavthlVNkXMx/RGK9CE++
	JJH7SOaTKA2Z9Q31azAzU5HIMmFYvK44ekG4HoIVtYIg5dpBlVb21fB1Lpu50AEM3iyZeu3Wm+J
	CdusK4fm5wJXfMobMRuMMUfojCwa5jzpxRYtHgy8pI3EDmzoA3HRTDCbtOb1fKq1b7HfLdWt8M+
	4dBpe86FD7XOt+K1s5HeiXuch3w=
X-Google-Smtp-Source: AGHT+IGRZrM9abbdnTN/4+pj5RYHmuLdG4GQWkBYStRVXjpCtIkw40x89qPYTM6dH8OtGtRyYRBI+978SCrSoXEmcA4=
X-Received: by 2002:a05:651c:199e:b0:380:af0:d07 with SMTP id
 38308e7fff4ca-3812025c99fmr122614661fa.0.1767353193614; Fri, 02 Jan 2026
 03:26:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251228-pci-m2-v4-0-5684868b0d5f@oss.qualcomm.com> <20251228-pci-m2-v4-5-5684868b0d5f@oss.qualcomm.com>
In-Reply-To: <20251228-pci-m2-v4-5-5684868b0d5f@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 2 Jan 2026 12:26:21 +0100
X-Gm-Features: AQt7F2ohvXnGZHdBsT_8cVPDY34uYT-aFVnGJfL69K1cxd16weXDo9rcPY7qXnE
Message-ID: <CAMRc=MfPq7+ZbWTp7+H388hqHoX27qbbHsLHO+xeLaceTwZLVA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] power: sequencing: Add the Power Sequencing driver
 for the PCIe M.2 connectors
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 28, 2025 at 6:01=E2=80=AFPM Manivannan Sadhasivam
<manivannan.sadhasivam@oss.qualcomm.com> wrote:
>
> This driver is used to control the PCIe M.2 connectors of different
> Mechanical Keys attached to the host machines and supporting different
> interfaces like PCIe/SATA, USB/UART etc...
>
> Currently, this driver supports only the Mechanical Key M connectors with
> PCIe interface. The driver also only supports driving the mandatory 3.3v
> and optional 1.8v power supplies. The optional signals of the Key M
> connectors are not currently supported.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---
>  MAINTAINERS                               |   7 ++
>  drivers/power/sequencing/Kconfig          |   8 ++
>  drivers/power/sequencing/Makefile         |   1 +
>  drivers/power/sequencing/pwrseq-pcie-m2.c | 160 ++++++++++++++++++++++++=
++++++
>  4 files changed, 176 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b11839cba9d..2eb7b6d26573 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20791,6 +20791,13 @@ F:     Documentation/driver-api/pwrseq.rst
>  F:     drivers/power/sequencing/
>  F:     include/linux/pwrseq/
>
> +PCIE M.2 POWER SEQUENCING
> +M:     Manivannan Sadhasivam <mani@kernel.org>
> +L:     linux-pci@vger.kernel.org
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/connector/pcie-m2-m-connector.y=
aml
> +F:     drivers/power/sequencing/pwrseq-pcie-m2.c
> +
>  POWER STATE COORDINATION INTERFACE (PSCI)
>  M:     Mark Rutland <mark.rutland@arm.com>
>  M:     Lorenzo Pieralisi <lpieralisi@kernel.org>
> diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/=
Kconfig
> index 280f92beb5d0..f5fff84566ba 100644
> --- a/drivers/power/sequencing/Kconfig
> +++ b/drivers/power/sequencing/Kconfig
> @@ -35,4 +35,12 @@ config POWER_SEQUENCING_TH1520_GPU
>           GPU. This driver handles the complex clock and reset sequence
>           required to power on the Imagination BXM GPU on this platform.
>
> +config POWER_SEQUENCING_PCIE_M2
> +       tristate "PCIe M.2 connector power sequencing driver"
> +       depends on OF || COMPILE_TEST
> +       help
> +         Say Y here to enable the power sequencing driver for PCIe M.2
> +         connectors. This driver handles the power sequencing for the M.=
2
> +         connectors exposing multiple interfaces like PCIe, SATA, UART, =
etc...
> +
>  endif
> diff --git a/drivers/power/sequencing/Makefile b/drivers/power/sequencing=
/Makefile
> index 96c1cf0a98ac..0911d4618298 100644
> --- a/drivers/power/sequencing/Makefile
> +++ b/drivers/power/sequencing/Makefile
> @@ -5,3 +5,4 @@ pwrseq-core-y                           :=3D core.o
>
>  obj-$(CONFIG_POWER_SEQUENCING_QCOM_WCN)        +=3D pwrseq-qcom-wcn.o
>  obj-$(CONFIG_POWER_SEQUENCING_TH1520_GPU) +=3D pwrseq-thead-gpu.o
> +obj-$(CONFIG_POWER_SEQUENCING_PCIE_M2) +=3D pwrseq-pcie-m2.o
> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/se=
quencing/pwrseq-pcie-m2.c
> new file mode 100644
> index 000000000000..4835d099d967
> --- /dev/null
> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> @@ -0,0 +1,160 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com=
>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_graph.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwrseq/provider.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +
> +struct pwrseq_pcie_m2_pdata {
> +       const struct pwrseq_target_data **targets;
> +};
> +
> +struct pwrseq_pcie_m2_ctx {
> +       struct pwrseq_device *pwrseq;
> +       struct device_node *of_node;
> +       const struct pwrseq_pcie_m2_pdata *pdata;
> +       struct regulator_bulk_data *regs;
> +       size_t num_vregs;
> +       struct notifier_block nb;
> +};
> +
> +static int pwrseq_pcie_m2_m_vregs_enable(struct pwrseq_device *pwrseq)
> +{
> +       struct pwrseq_pcie_m2_ctx *ctx =3D pwrseq_device_get_drvdata(pwrs=
eq);
> +
> +       return regulator_bulk_enable(ctx->num_vregs, ctx->regs);
> +}
> +
> +static int pwrseq_pcie_m2_m_vregs_disable(struct pwrseq_device *pwrseq)
> +{
> +       struct pwrseq_pcie_m2_ctx *ctx =3D pwrseq_device_get_drvdata(pwrs=
eq);
> +
> +       return regulator_bulk_disable(ctx->num_vregs, ctx->regs);
> +}
> +
> +static const struct pwrseq_unit_data pwrseq_pcie_m2_vregs_unit_data =3D =
{
> +       .name =3D "regulators-enable",
> +       .enable =3D pwrseq_pcie_m2_m_vregs_enable,
> +       .disable =3D pwrseq_pcie_m2_m_vregs_disable,
> +};
> +
> +static const struct pwrseq_unit_data *pwrseq_pcie_m2_m_unit_deps[] =3D {
> +       &pwrseq_pcie_m2_vregs_unit_data,
> +       NULL
> +};
> +
> +static const struct pwrseq_unit_data pwrseq_pcie_m2_m_pcie_unit_data =3D=
 {
> +       .name =3D "pcie-enable",
> +       .deps =3D pwrseq_pcie_m2_m_unit_deps,
> +};
> +
> +static const struct pwrseq_target_data pwrseq_pcie_m2_m_pcie_target_data=
 =3D {
> +       .name =3D "pcie",
> +       .unit =3D &pwrseq_pcie_m2_m_pcie_unit_data,
> +};
> +
> +static const struct pwrseq_target_data *pwrseq_pcie_m2_m_targets[] =3D {
> +       &pwrseq_pcie_m2_m_pcie_target_data,
> +       NULL
> +};
> +
> +static const struct pwrseq_pcie_m2_pdata pwrseq_pcie_m2_m_of_data =3D {
> +       .targets =3D pwrseq_pcie_m2_m_targets,
> +};
> +
> +static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
> +                                struct device *dev)
> +{
> +       struct pwrseq_pcie_m2_ctx *ctx =3D pwrseq_device_get_drvdata(pwrs=
eq);
> +       struct device_node *endpoint __free(device_node) =3D NULL;
> +
> +       /*
> +        * Traverse the 'remote-endpoint' nodes and check if the remote n=
ode's
> +        * parent matches the OF node of 'dev'.
> +        */
> +       for_each_endpoint_of_node(ctx->of_node, endpoint) {
> +               struct device_node *remote __free(device_node) =3D
> +                               of_graph_get_remote_port_parent(endpoint)=
;
> +               if (remote && (remote =3D=3D dev_of_node(dev)))
> +                       return PWRSEQ_MATCH_OK;
> +       }
> +
> +       return PWRSEQ_NO_MATCH;
> +}
> +
> +static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct pwrseq_pcie_m2_ctx *ctx;
> +       struct pwrseq_config config =3D {};
> +       int ret;
> +
> +       ctx =3D devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +       if (!ctx)
> +               return -ENOMEM;
> +
> +       ctx->of_node =3D dev_of_node(dev);

Since you're storing the node address for later, I'd suggest using
of_node_get() to get a real reference.

> +       ctx->pdata =3D device_get_match_data(dev);
> +       if (!ctx->pdata)
> +               return dev_err_probe(dev, -ENODEV,
> +                                    "Failed to obtain platform data\n");
> +
> +       /*
> +        * Currently, of_regulator_bulk_get_all() is the only regulator A=
PI that
> +        * allows to get all supplies in the devicetree node without manu=
ally
> +        * specifying them.
> +        */
> +       ret =3D of_regulator_bulk_get_all(dev, dev_of_node(dev), &ctx->re=
gs);
> +       if (ret < 0)
> +               return dev_err_probe(dev, ret,
> +                                    "Failed to get all regulators\n");
> +
> +       ctx->num_vregs =3D ret;
> +
> +       config.parent =3D dev;
> +       config.owner =3D THIS_MODULE;
> +       config.drvdata =3D ctx;
> +       config.match =3D pwrseq_pcie_m2_match;
> +       config.targets =3D ctx->pdata->targets;
> +
> +       ctx->pwrseq =3D devm_pwrseq_device_register(dev, &config);
> +       if (IS_ERR(ctx->pwrseq)) {
> +               regulator_bulk_free(ctx->num_vregs, ctx->regs);

You're freeing it on error but not on driver detach? Maybe schedule a
devm action if there's no devres variant?

> +               return dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
> +                                    "Failed to register the power sequen=
cer\n");
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id pwrseq_pcie_m2_of_match[] =3D {
> +       {
> +               .compatible =3D "pcie-m2-m-connector",
> +               .data =3D &pwrseq_pcie_m2_m_of_data,
> +       },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, pwrseq_pcie_m2_of_match);
> +
> +static struct platform_driver pwrseq_pcie_m2_driver =3D {
> +       .driver =3D {
> +               .name =3D "pwrseq-pcie-m2",
> +               .of_match_table =3D pwrseq_pcie_m2_of_match,
> +       },
> +       .probe =3D pwrseq_pcie_m2_probe,
> +};
> +module_platform_driver(pwrseq_pcie_m2_driver);
> +
> +MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm=
.com>");
> +MODULE_DESCRIPTION("Power Sequencing driver for PCIe M.2 connector");
> +MODULE_LICENSE("GPL");
>
> --
> 2.48.1
>

Bart

