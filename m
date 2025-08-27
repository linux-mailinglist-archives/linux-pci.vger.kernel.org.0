Return-Path: <linux-pci+bounces-34928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22560B387D2
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 18:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 322287A3A6E
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 16:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7435A286881;
	Wed, 27 Aug 2025 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="mzNGsLP+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92235218ADD
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756312493; cv=none; b=i2Z5TUYnOLeFxgHV9fA5svui5/DtjQv8+DhDpbnQPricJFrBXRCJWOSJdJofC5tff1hfgsPBdce/hdlvrZ6kSabdt7/dD4OfIwT1bv7dmTjND+ZHl/xQydQZBO4GDNQQBLRmjz73w4juc16e5XbDd0v3g330nCB4irB23JVWcSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756312493; c=relaxed/simple;
	bh=hIdOxF0V/GWmdAeRpodpW7JqSq9MrMJaTYcZSngLWgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dwzSMTSlPWeufo3uJteggmmugB++2Iw9wmIQMF6f8vgn5y2v7U65Kle9lH5X4FcTgyxiM02jc9w6QSYw3Pi7pgeZUFsYzZ2lqDpMcXKRVSX0UKKe0c61WHhyW+mXleT8UBJJZ99uZPOl69TDt742ueL35FuADuMHoQQY8JDGzMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=mzNGsLP+; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3367f35d129so186121fa.1
        for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 09:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756312490; x=1756917290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYJFvxznS9qH/KLo9mNWDlA9h7eslmU7zn/DFqWipOo=;
        b=mzNGsLP+DwTz6zz4mOzVbPvmkTkwaOFWU6JNu0li39PchAkuq2dQwvNisfN8xl6gpr
         6rATK/eTLMpEmEK69WT8/2M+/HK9b4oIblbei2o/POnOBeHcfD+vAa9oR8PKdYEis8PG
         hQvpsQQMasAEU2GPrilzjnbhmgEqb9M+SS9yb4y7pGKOawjtIKuevc39tIVuIP2Cg0PY
         +9pBgOrLYpZ8YCc/yAqDM7lqiLiY3C2+HmXSlWPgYWe9adj9rFRj9Gql+KZ2QFTDe5oi
         Df2c/ZxbjmRRakv1v5/NOzM4inzP9S6vbj6eoqdjEO0oF0WknGPIt7ljLNZZJa5uPUqB
         fQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756312490; x=1756917290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYJFvxznS9qH/KLo9mNWDlA9h7eslmU7zn/DFqWipOo=;
        b=AG8k9AKNMup8ewwB2+vQlu4VIjZFviVTy2unnNtbrBGirJVcv7CDMfMeKXAWeTt9gW
         0/pt+phNqHyksI2bFmT+tdqGH9BoTqfzo7BVYA94TzXLcnCMfFRezVbVryu3MfBrid9D
         kgGhZ4Dq/m9ZA/YJnEEc6a7ZbQEK0mAatPBd0SaMEcPXrXoGRaipN14e1RPjE2dRGrEx
         3L4lasi6AL4xDkJ6/jtJeIxiAj5O0NCrC/SsSUjttk4Q22+7iYllYSeT9iFDvpDnchdd
         GDgkeUnhDud8Ghc9Jcl1Gu7HoNT7jdYixZOEnRowHCjF/r9gRbTLecr2kYfcrfAegATc
         8xlg==
X-Forwarded-Encrypted: i=1; AJvYcCUyZakFtp/kAQNF1sKruvCKP12oM/u30sxwwRJjYRTCxSO+yV5scxY0lOkZBAl3/c2SVpt8YTGjQIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ETDNaPrGRGHJVN7l9XKf6UTpBcsgLY+TWWYD9yUqHuTsXa5X
	lfHBJyMuE9QKPjVGsLuclgAUUe7EM++OxlrOEZJePIMSQIn/XAGsPAofreUWsaSICp97I+rtNae
	Zz39TlaMD9h4HSpqgph1m+fgW3BdObbuacm2zwNpK5A==
X-Gm-Gg: ASbGncvJCpScdpocpqDByG2CM9r9pyH5tUDf62CRiYcsHibq0ZnMnSVLRuLE3AHU+Rh
	EkMLIS4tmmdh5TMi4J9oMfjj3+2YuMDAOUVCKV7DeAPpeZEi0m5xSqTehftSs5TrRJjnV8mbp+x
	p9eyE9qgAWzgIDcQYCejYRv7Yug80URi1wG9eaeLFQaM3PsFR4CiXcc8yO0Qtu1/Xgrw7w3mCX8
	/qDB9qZoslzlOkmpRYb8LC8NJ5WnN2um+Ojyiw=
X-Google-Smtp-Source: AGHT+IEYAM6G7jrQwiVwruO6yosvrhxlh0HPcGpJQY4iz4Lhz2MgtOaLooKmiHE3wnTbkxrjwI2ai0VEsGMyeCbbJ/o=
X-Received: by 2002:a2e:be1c:0:b0:336:7b66:13a1 with SMTP id
 38308e7fff4ca-3367b662564mr27772081fa.0.1756312489551; Wed, 27 Aug 2025
 09:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-pci-pwrctrl-perst-v1-0-4b74978d2007@oss.qualcomm.com> <20250819-pci-pwrctrl-perst-v1-5-4b74978d2007@oss.qualcomm.com>
In-Reply-To: <20250819-pci-pwrctrl-perst-v1-5-4b74978d2007@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 27 Aug 2025 18:34:38 +0200
X-Gm-Features: Ac12FXyDhSf2ewNZkMyp76yle-wH_-s-bfKPLfIcpdEFx6e8RooRgknLS6PhU94
Message-ID: <CAMRc=MdyTOYyeMJa_HBgJVo=ZNxsgdTsw6rhOUmGtNYeSrXLCw@mail.gmail.com>
Subject: Re: [PATCH 5/6] PCI: qcom: Parse PERST# from all PCIe bridge nodes
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Saravana Kannan <saravanak@google.com>, linux-pci@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 9:15=E2=80=AFAM Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> Devicetree schema allows the PERST# GPIO to be present in all PCIe bridge
> nodes, not just in Root Port node. But the current logic parses PERST# on=
ly
> from the Root Port node. Though it is not causing any issue on the curren=
t
> platforms, the upcoming platforms will have PERST# in PCIe switch
> downstream ports also. So this requires parsing all the PCIe bridge nodes
> for the PERST# GPIO.
>
> Hence, rework the parsing logic to extend to all PCIe bridge nodes starti=
ng
> from Root Port node. If the 'reset-gpios' property is found for a node, t=
he
> GPIO descriptor will be stored in IDR structure with node BDF as the ID.
>
> It should be noted that if more than one bridge node has the same GPIO fo=
r
> PERST# (shared PERST#), the driver will error out. This is due to the
> limitation in the GPIOLIB subsystem that allows only exclusive (non-share=
d)
> access to GPIOs from consumers. But this is soon going to get fixed. Once
> that happens, it will get incorporated in this driver.
>
> So for now, PERST# sharing is not supported.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 90 +++++++++++++++++++++++++++-=
------
>  1 file changed, 73 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index bcd080315d70e64eafdefd852740fe07df3dbe75..5d73c46095af3219687ff77e5=
922f08bb41e43a9 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -19,6 +19,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
>  #include <linux/limits.h>
> +#include <linux/idr.h>
>  #include <linux/init.h>
>  #include <linux/of.h>
>  #include <linux/of_pci.h>
> @@ -286,6 +287,7 @@ struct qcom_pcie {
>         const struct qcom_pcie_cfg *cfg;
>         struct dentry *debugfs;
>         struct list_head ports;
> +       struct idr perst;
>         bool suspended;
>         bool use_pm_opp;
>  };
> @@ -294,14 +296,15 @@ struct qcom_pcie {
>
>  static void qcom_perst_assert(struct qcom_pcie *pcie, bool assert)
>  {
> -       struct qcom_pcie_port *port;
>         int val =3D assert ? 1 : 0;
> +       struct gpio_desc *perst;
> +       int bdf;
>
> -       if (list_empty(&pcie->ports))
> +       if (idr_is_empty(&pcie->perst))
>                 gpiod_set_value_cansleep(pcie->reset, val);
> -       else
> -               list_for_each_entry(port, &pcie->ports, list)
> -                       gpiod_set_value_cansleep(port->reset, val);
> +
> +       idr_for_each_entry(&pcie->perst, perst, bdf)
> +               gpiod_set_value_cansleep(perst, val);
>  }
>
>  static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
> @@ -1702,20 +1705,58 @@ static const struct pci_ecam_ops pci_qcom_ecam_op=
s =3D {
>         }
>  };
>
> -static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_no=
de *node)
> +/* Parse PERST# from all nodes in depth first manner starting from @np *=
/
> +static int qcom_pcie_parse_perst(struct qcom_pcie *pcie,
> +                                struct device_node *np)
>  {
>         struct device *dev =3D pcie->pci->dev;
> -       struct qcom_pcie_port *port;
>         struct gpio_desc *reset;
> -       struct phy *phy;
>         int ret;
>
> -       reset =3D devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
> -                                     "reset", GPIOD_OUT_HIGH, "PERST#");
> -       if (IS_ERR(reset))
> +       if (!of_find_property(np, "reset-gpios", NULL))
> +               goto parse_child_node;
> +
> +       ret =3D of_pci_get_bdf(np);
> +       if (ret < 0)
> +               return ret;
> +
> +       reset =3D devm_fwnode_gpiod_get(dev, of_fwnode_handle(np), "reset=
",
> +                                     GPIOD_OUT_HIGH, "PERST#");
> +       if (IS_ERR(reset)) {
> +               /*
> +                * FIXME: GPIOLIB currently supports exclusive GPIO acces=
s only.
> +                * Non exclusive access is broken. But shared PERST# requ=
ires
> +                * non-exclusive access. So once GPIOLIB properly support=
s it,
> +                * implement it here.
> +                */
> +               if (PTR_ERR(reset) =3D=3D -EBUSY)
> +                       dev_err(dev, "Shared PERST# is not supported\n");

Then maybe just use the GPIOD_FLAGS_BIT_NONEXCLUSIVE flag for now and
don't bail-out - it will make it easier to spot it when converting to
the new solution?

Bart

> +
>                 return PTR_ERR(reset);
> +       }
> +
> +       ret =3D idr_alloc(&pcie->perst, reset, ret, 0, GFP_KERNEL);
> +       if (ret < 0)
> +               return ret;
> +
> +parse_child_node:
> +       for_each_available_child_of_node_scoped(np, child) {
> +               ret =3D qcom_pcie_parse_perst(pcie, child);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
>
> -       phy =3D devm_of_phy_get(dev, node, NULL);
> +static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_no=
de *np)
> +{
> +       struct device *dev =3D pcie->pci->dev;
> +       struct qcom_pcie_port *port;
> +       struct phy *phy;
> +       int ret;
> +
> +       phy =3D devm_of_phy_get(dev, np, NULL);
>         if (IS_ERR(phy))
>                 return PTR_ERR(phy);
>
> @@ -1727,7 +1768,10 @@ static int qcom_pcie_parse_port(struct qcom_pcie *=
pcie, struct device_node *node
>         if (ret)
>                 return ret;
>
> -       port->reset =3D reset;
> +       ret =3D qcom_pcie_parse_perst(pcie, np);
> +       if (ret)
> +               return ret;
> +
>         port->phy =3D phy;
>         INIT_LIST_HEAD(&port->list);
>         list_add_tail(&port->list, &pcie->ports);
> @@ -1739,7 +1783,11 @@ static int qcom_pcie_parse_ports(struct qcom_pcie =
*pcie)
>  {
>         struct device *dev =3D pcie->pci->dev;
>         struct qcom_pcie_port *port, *tmp;
> -       int ret =3D -ENOENT;
> +       struct gpio_desc *perst;
> +       int ret =3D -ENODEV;
> +       int bdf;
> +
> +       idr_init(&pcie->perst);
>
>         for_each_available_child_of_node_scoped(dev->of_node, of_port) {
>                 ret =3D qcom_pcie_parse_port(pcie, of_port);
> @@ -1750,8 +1798,13 @@ static int qcom_pcie_parse_ports(struct qcom_pcie =
*pcie)
>         return ret;
>
>  err_port_del:
> -       list_for_each_entry_safe(port, tmp, &pcie->ports, list)
> +       list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
> +               phy_exit(port->phy);
>                 list_del(&port->list);
> +       }
> +
> +       idr_for_each_entry(&pcie->perst, perst, bdf)
> +               idr_remove(&pcie->perst, bdf);
>
>         return ret;
>  }
> @@ -1782,12 +1835,13 @@ static int qcom_pcie_probe(struct platform_device=
 *pdev)
>         unsigned long max_freq =3D ULONG_MAX;
>         struct qcom_pcie_port *port, *tmp;
>         struct device *dev =3D &pdev->dev;
> +       struct gpio_desc *perst;
>         struct dev_pm_opp *opp;
>         struct qcom_pcie *pcie;
>         struct dw_pcie_rp *pp;
>         struct resource *res;
>         struct dw_pcie *pci;
> -       int ret, irq;
> +       int ret, irq, bdf;
>         char *name;
>
>         pcie_cfg =3D of_device_get_match_data(dev);
> @@ -1927,7 +1981,7 @@ static int qcom_pcie_probe(struct platform_device *=
pdev)
>
>         ret =3D qcom_pcie_parse_ports(pcie);
>         if (ret) {
> -               if (ret !=3D -ENOENT) {
> +               if (ret !=3D -ENODEV) {
>                         dev_err_probe(pci->dev, ret,
>                                       "Failed to parse Root Port: %d\n", =
ret);
>                         goto err_pm_runtime_put;
> @@ -1989,6 +2043,8 @@ static int qcom_pcie_probe(struct platform_device *=
pdev)
>         qcom_pcie_phy_exit(pcie);
>         list_for_each_entry_safe(port, tmp, &pcie->ports, list)
>                 list_del(&port->list);
> +       idr_for_each_entry(&pcie->perst, perst, bdf)
> +               idr_remove(&pcie->perst, bdf);
>  err_pm_runtime_put:
>         pm_runtime_put(dev);
>         pm_runtime_disable(dev);
>
> --
> 2.45.2
>
>

