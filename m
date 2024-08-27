Return-Path: <linux-pci+bounces-12273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FF5960931
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 13:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CDDBB24E18
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 11:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD6D1A0706;
	Tue, 27 Aug 2024 11:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u5QNvds/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFF2140E4D
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 11:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724759064; cv=none; b=fpi8gFhuaJMo23Y/MqLZGMDaYMNTHTirKliEq3sVp6QUN/Qh0415CKaULLdmplEuF0yJULF8611V6E8vPGOmCTZiS2nhscH2EvNwJ0+yUeI9sVwmzOjtMoKri0/OU9a+YzHbEM3o1OvJtXXm/ZqN+UtsquVqPmq5YQYHx8dvD7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724759064; c=relaxed/simple;
	bh=M5U58xavEfJS9Jq3NPUxRrcl06l5is/NdCI503mKL7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSrvaFCh/KgzJR9d92vH7ZWo1JJ3e2N8F7MWkelkJ0V8DXW3Jk/ReaFNs5hnaLL0v/6/2K8+skJ/ytCaSaassm12KuHJzUXZrFwlPDklQxDglrSIL/Ye3Fxxu/MxPpNox8CkkZHhIoyAPtXJZH2V/k8MOE4vclXnGsHKON0T22s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u5QNvds/; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6bada443ffeso40345767b3.0
        for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 04:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724759061; x=1725363861; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HbrPQE8jRD81MclT20thBdKrMQOQNi57XSGQvxTWTS4=;
        b=u5QNvds/XVIi+SZ5jk6z8LK5MUJqbWdLoBza2GyDn8T9Frefwg4uc1Rw56BqGGG6UG
         HY+P+1VqR8gNzCIgE/ac3S6bTYAmCgDcNWNImNQHHYaLm1u1O/UoB/sy8ItlT1zvUqf9
         GK1GIJ5eP1XTWgUYcy23izncuTctjhkdcR65BpHj8JP9hDhiCXz8XK9dGOdMIJltWrQU
         DffhrPxk2aGT7iJNYpD7qqP0H8AI+UW2o2GyxYsSUN4dCLXkHGTsPEGq6StsgRRH/36y
         elb8GBpFocwNlBwzQmeG/myFbhWnkPSC8KMyjeufpbo+RN2O8nb9ltzVHM2cIZicnkIK
         arWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724759061; x=1725363861;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HbrPQE8jRD81MclT20thBdKrMQOQNi57XSGQvxTWTS4=;
        b=LxmljK16CVtKOf5QdD38Bdp0OkZzXm85VcuInTUQ8gW0HrodR1bdi8irYCWPlqNygI
         YrxTOuLrDIuujge37tHmHBWthdPUagQdjy9E9vSg6pP66mVXxknBQAME8S6BQ0AsSu//
         8ehJ5spUIuQcA5s7fA/fJwW1FmgxBkXuKzp194aRbJzxex3483KOF2V6nHXjbGpqkLse
         nAtKGhoQbcI655YATWmhqvNPg3ov69kR3QeUlZOsjspA5Jp2nxIlwffb2VXjpKQPty40
         yieb0oPyXWP9S3/CGwvcf3gGVUpT9eTqABUPOiuV7HGYbKAfgJ3SywVpZq+nXWwvuN0f
         8o8A==
X-Forwarded-Encrypted: i=1; AJvYcCUIWtgl0T0RaeuRy4RCRt1U8SENWrYI4LzT+9pbym1cLmSfcnJ3c544dG6F2Ke3hv5cNBbw/eMK7Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqEM0SL1H8VZ6tAad52FrpK1eKyWZ4Go0MfFyHZ3JARsBnCNVb
	XrQB+raFNlBaVOJxV0YyAmAeiTZvOIfFqn+KeQOursy4Jz8dLP+GKeVUFkHP/iG53chD07khXvu
	MEdVBvtXEAHUGtJXfbNOoRNgh+pxqi8/pjnpj2Q==
X-Google-Smtp-Source: AGHT+IEFbOl3EI7OwCA2RA3WFV/8KK9lP4+cyNXB+PQIqHygNosqXZpSCOmLNbYe18abw+wdIinxpT2b9VOQqGYfq/w=
X-Received: by 2002:a05:690c:6c09:b0:6ad:c9bd:3812 with SMTP id
 00721157ae682-6cfb3fde15cmr20895397b3.17.1724759060653; Tue, 27 Aug 2024
 04:44:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827063631.3932971-1-quic_qianyu@quicinc.com> <20240827063631.3932971-9-quic_qianyu@quicinc.com>
In-Reply-To: <20240827063631.3932971-9-quic_qianyu@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 27 Aug 2024 14:44:09 +0300
Message-ID: <CAA8EJpq5KergZ8czg4F=EYMLANoOeBsiSVoO-zAgfG0ezQrKCQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] PCI: qcom: Add support to PCIe slot power supplies
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org, 
	robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com, 
	sboyd@kernel.org, abel.vesa@linaro.org, quic_msarkar@quicinc.com, 
	quic_devipriy@quicinc.com, kw@linux.com, lpieralisi@kernel.org, 
	neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Aug 2024 at 09:36, Qiang Yu <quic_qianyu@quicinc.com> wrote:
>
> On platform x1e80100 QCP, PCIe3 is a standard x8 form factor. Hence, add
> support to use 3.3v, 3.3v aux and 12v regulators.

First of all, I don't see corresponding bindings change.

Second, these supplies power up the slot, not the host controller
itself. As such these supplies do not belong to the host controller
entry. Please consider using the pwrseq framework instead.

>
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 52 +++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 6f953e32d990..59fb415dfeeb 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -248,6 +248,8 @@ struct qcom_pcie_cfg {
>         bool no_l0s;
>  };
>
> +#define QCOM_PCIE_SLOT_MAX_SUPPLIES                    3
> +
>  struct qcom_pcie {
>         struct dw_pcie *pci;
>         void __iomem *parf;                     /* DT parf */
> @@ -260,6 +262,7 @@ struct qcom_pcie {
>         struct icc_path *icc_cpu;
>         const struct qcom_pcie_cfg *cfg;
>         struct dentry *debugfs;
> +       struct regulator_bulk_data slot_supplies[QCOM_PCIE_SLOT_MAX_SUPPLIES];
>         bool suspended;
>         bool use_pm_opp;
>  };
> @@ -1174,6 +1177,41 @@ static int qcom_pcie_link_up(struct dw_pcie *pci)
>         return !!(val & PCI_EXP_LNKSTA_DLLLA);
>  }
>
> +static int qcom_pcie_enable_slot_supplies(struct qcom_pcie *pcie)
> +{
> +       struct dw_pcie *pci = pcie->pci;
> +       int ret;
> +
> +       ret = regulator_bulk_enable(ARRAY_SIZE(pcie->slot_supplies),
> +                                   pcie->slot_supplies);
> +       if (ret < 0)
> +               dev_err(pci->dev, "Failed to enable slot regulators\n");
> +
> +       return ret;
> +}
> +
> +static void qcom_pcie_disable_slot_supplies(struct qcom_pcie *pcie)
> +{
> +       regulator_bulk_disable(ARRAY_SIZE(pcie->slot_supplies),
> +                              pcie->slot_supplies);
> +}
> +
> +static int qcom_pcie_get_slot_supplies(struct qcom_pcie *pcie)
> +{
> +       struct dw_pcie *pci = pcie->pci;
> +       int ret;
> +
> +       pcie->slot_supplies[0].supply = "vpcie12v";
> +       pcie->slot_supplies[1].supply = "vpcie3v3";
> +       pcie->slot_supplies[2].supply = "vpcie3v3aux";
> +       ret = devm_regulator_bulk_get(pci->dev, ARRAY_SIZE(pcie->slot_supplies),
> +                                     pcie->slot_supplies);
> +       if (ret < 0)
> +               dev_err(pci->dev, "Failed to get slot regulators\n");
> +
> +       return ret;
> +}
> +
>  static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>  {
>         struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -1182,10 +1220,14 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>
>         qcom_ep_reset_assert(pcie);
>
> -       ret = pcie->cfg->ops->init(pcie);
> +       ret = qcom_pcie_enable_slot_supplies(pcie);
>         if (ret)
>                 return ret;
>
> +       ret = pcie->cfg->ops->init(pcie);
> +       if (ret)
> +               goto err_disable_slot;
> +
>         ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
>         if (ret)
>                 goto err_deinit;
> @@ -1216,7 +1258,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>         phy_power_off(pcie->phy);
>  err_deinit:
>         pcie->cfg->ops->deinit(pcie);
> -
> +err_disable_slot:
> +       qcom_pcie_disable_slot_supplies(pcie);
>         return ret;
>  }
>
> @@ -1228,6 +1271,7 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
>         qcom_ep_reset_assert(pcie);
>         phy_power_off(pcie->phy);
>         pcie->cfg->ops->deinit(pcie);
> +       qcom_pcie_disable_slot_supplies(pcie);
>  }
>
>  static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
> @@ -1602,6 +1646,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>                         goto err_pm_runtime_put;
>         }
>
> +       ret = qcom_pcie_get_slot_supplies(pcie);
> +       if (ret)
> +               goto err_pm_runtime_put;
> +
>         ret = pcie->cfg->ops->get_resources(pcie);
>         if (ret)
>                 goto err_pm_runtime_put;
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

