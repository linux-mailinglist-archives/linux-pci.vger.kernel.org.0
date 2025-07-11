Return-Path: <linux-pci+bounces-31975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B95FFB027BD
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 01:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0464F583298
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 23:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7CB224225;
	Fri, 11 Jul 2025 23:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cdPgfZBN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6D1223714
	for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 23:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752277372; cv=none; b=nAgdcw70AM34z6Cutc13nq06Xt8VBr3b2yP1mI1SX1wOqpSzXwFkWc8YHtv54WcZQkArUaCRXip75PHX+t08x6Q/X1XSoP3ENwg/BmowZTvm04ID8R7gd88o7+N/xkzHKDP9+drXJU1SvAkCZd9usS2SbnDE+G3dTp+qGWuu0bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752277372; c=relaxed/simple;
	bh=fIaYo9IvNAFNRjsyINEvrozrSFyQvajczRG4Vn4Qhps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIDEmGg2pWcy5PWNm3jdTbQZJ2lFALI3r9UNPoMMg+NerIsgyJm7bE29jRfVBNO6Adp6lhzDHruYL27Y9D0BApIxXE3lyepzOzqjHIWtMg4XZDjNSNi20tKHS9ZiGgp+fevwa1+nGaUgjrA+kkP+hTfZpmzpudrRBoPxr7Vb3xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cdPgfZBN; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74924255af4so2282669b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 16:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752277370; x=1752882170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iW/OsUEq9HXGDSnTvferTBRrSzVm5S3zYb68w57Tadw=;
        b=cdPgfZBNRrlsp2x/1lvC9QlP/HjGfWX/UvwAce1AfuPYFZTJs5jEV0Q0U31YZdN9DJ
         7A5hlqiTyHz508VCAphEOmb263D4ApP5oOaMgzYnDtPTK/XB2JJmhs7IvP3XhYAAuM6D
         Jv8SKc1f3xDs1u9r4X8p/PSHcr6rctnGMevC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752277370; x=1752882170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iW/OsUEq9HXGDSnTvferTBRrSzVm5S3zYb68w57Tadw=;
        b=xMpkkqAoJT6sPMv+lZrj2IjiTB2jMt/yOB/D+qGWGlWvdBrEC18TQrL8IoSvgcxpN8
         7ZaJZTIVzEV2PE3w8wu5LlumjqUWUCdAz13meykacZpyKxRmCTWRfpHXQ6GFZPwPK6c2
         oZn9YxvFFIwPs2qMiMJW6GfUVLu1M4mc4NGfd5UI65mIpaWQZWrHK/lOuuyNITdK0Csx
         M1cusQCRoRl8vcupQqaettE/kB7Libjlrynow1KrRh0j4+1XJLm4BkF7GOQ6BfpfWp+D
         Nw3mH4gN/dKGYGFFIsGrJE5Q2g5h3U1gU2c5dRb3QMCa2nlE4218v9i2Xq88KXXhs/s3
         sUfA==
X-Forwarded-Encrypted: i=1; AJvYcCUp0kp6myOJekMGwnM9juQkQvBCNiuMaQOiJXbOQwcbCDng82Wg4agDLaIyH5EUjHVqhBx/HAZT00c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbwb91Fv4IJw8zijUB8iX2Su1GFWCeXHOP9nWaWq6d11DeqfSC
	qeYVE0ug7nXW433peN98BfTOae+dC3H9aieM0IawoqlE8U7ZJr0Uqc1r7FDb6Y8SuA==
X-Gm-Gg: ASbGnctolJ1m6Roc0Jg47ukvbsWXXXdwBUAmB2MQWzLV2kU1YeQx/lCtoqMVXPwQgMV
	Y9ABQkuQsZEZy1lLeOnnsvzRD14rSokdQtSdxvqymfKzYEKFFKlPzNJAHXGTpdpeX34dU/rB3p9
	XZr6SSQp7JcmFPCL0xoV9Du/DwShmoLFayeD/s9+8YblIVMEBpfUZgtHUlOtdjI0EbclhpD/PDR
	X2vKa7WQ6PeM2cjmg7F6BqM4Sc7QZKgM+hlNe83vjFYCtPPFGohxaCdNWvja2/qGw51b/L2EaT7
	v/OxUvGEgoSy/PRt2Yt3q+GZNwzXmX3B6Yk8pvLmDHXxSsNAn8ZFbgkLJRKE/+UmKuaprOX3Tho
	vWc7VCJCxC93bkQ+UJgAWvlRuZRm6YPa9R8zs+XCJTx+vTlBEibsSBsQnpQ7t556M2n9M+ow=
X-Google-Smtp-Source: AGHT+IFKsEBGAQn8CiUIUFDCBebFRGxcJfzw5dSTFVBl66LbmlgoNt4Lubbnq2etcBTJ+ravhAgV3w==
X-Received: by 2002:a05:6a00:1743:b0:74a:e29c:287d with SMTP id d2e1a72fcca58-74ee244a366mr6972742b3a.11.1752277370191;
        Fri, 11 Jul 2025 16:42:50 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:2386:8bd3:333b:b774])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74eb9f9c0b2sm6371693b3a.179.2025.07.11.16.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 16:42:49 -0700 (PDT)
Date: Fri, 11 Jul 2025 16:42:47 -0700
From: Brian Norris <briannorris@chromium.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH RFC 3/3] PCI: qcom: Allow pwrctrl framework to control
 PERST#
Message-ID: <aHGhd3LLg8Dwk1qn@google.com>
References: <20250707-pci-pwrctrl-perst-v1-0-c3c7e513e312@kernel.org>
 <20250707-pci-pwrctrl-perst-v1-3-c3c7e513e312@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707-pci-pwrctrl-perst-v1-3-c3c7e513e312@kernel.org>

Hi,

On Mon, Jul 07, 2025 at 11:48:40PM +0530, Manivannan Sadhasivam wrote:
> Since the Qcom platforms rely on pwrctrl framework to control the power
> supplies, allow it to control PERST# also. PERST# should be toggled during
> the power-on and power-off scenarios.
> 
> But the controller driver still need to assert PERST# during the controller
> initialization. So only skip the deassert if pwrctrl usage is detected. The
> pwrctrl framework will deassert PERST# after turning on the supplies.
> 
> The usage of pwrctrl framework is detected based on the new DT binding
> i.e., with the presence of PERST# and PHY properties in the Root Port node
> instead of the host bridge node.

I just noticed what this paragraph means. IIUC, this implies that in
your new binding, one *must* describe one or more *-supply in the port
or endpoint device(s). Otherwise, no pwrctrl devices will be created,
and no one will deassert PERST# for you. My understanding is that
*-supply is optional, and so this is a poor requirement.

And even if all QCOM device trees manage to have external regulators
described in their device trees, there are certainly other systems where
the driver might (optionally) use pwrctrl for some devices, but others
will establish power on their own (e.g., PCIe tied to some other system
power rail).

I think you either need the PCI core to tell you whether pwrctrl is in
use, or else you need to disconnect this PERST# support from pwrctrl.

> When the legacy binding is used, PERST# is only controlled by the
> controller driver since it is not reliable to detect whether pwrctrl is
> used or not. So the legacy platforms are untouched by this commit.
> 
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c |  1 +
>  drivers/pci/controller/dwc/pcie-designware.h      |  1 +
>  drivers/pci/controller/dwc/pcie-qcom.c            | 26 ++++++++++++++++++++++-
>  3 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index af6c91ec7312bab6c6e5ad35b051d0f452fe7b8d..e45f53bb135a75963318666a479eb6d9582f30eb 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -492,6 +492,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  		return -ENOMEM;
>  
>  	pp->bridge = bridge;
> +	bridge->perst = pp->perst;
>  
>  	ret = dw_pcie_host_get_resources(pp);
>  	if (ret)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 4165c49a0a5059cab92dee3c47f8024af9d840bd..7b28f76ebf6a2de8781746eba43a8e3ad9a5cbb2 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -430,6 +430,7 @@ struct dw_pcie_rp {
>  	struct resource		*msg_res;
>  	bool			use_linkup_irq;
>  	struct pci_eq_presets	presets;
> +	struct gpio_desc	**perst;
>  };
>  
>  struct dw_pcie_ep_ops {
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 620ac7cf09472b84c37e83ee3ce40e94a1d9d878..61e1d0d6469030c549328ab4d8c65d5377d525e3 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -313,6 +313,11 @@ static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
>  
>  static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
>  {
> +	struct dw_pcie_rp *pp = &pcie->pci->pp;
> +
> +	if (pp->perst)

You're doing a non-NULL check here, but you forgot to reinitialize it to
NULL in some cases below (qcom_pcie_parse_ports()).

This is also apparently where you assume |perst| implies pwrctrl. Per
above, I don't think that's a good assumption.

> +		return;
> +
>  	/* Ensure that PERST has been asserted for at least 100 ms */
>  	msleep(PCIE_T_PVPERL_MS);
>  	qcom_perst_assert(pcie, false);
...
>  static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
>  {
> +	struct dw_pcie_rp *pp = &pcie->pci->pp;
>  	struct device *dev = pcie->pci->dev;
>  	struct qcom_pcie_port *port, *tmp;
> +	int child_cnt;
>  	int ret = -ENOENT;
>  
> +	child_cnt = of_get_available_child_count(dev->of_node);
> +	if (!child_cnt)
> +		return ret;
> +
> +	pp->perst = kcalloc(child_cnt, sizeof(struct gpio_desc *), GFP_KERNEL);
> +	if (!pp->perst)
> +		return -ENOMEM;
> +
>  	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
>  		ret = qcom_pcie_parse_port(pcie, of_port);
>  		if (ret)
> @@ -1747,6 +1769,7 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
>  	return ret;
>  
>  err_port_del:
> +	kfree(pp->perst);

You need this too:

	pp->perst = NULL;

Otherwise, you leave a non-NULL (invalid) pointer for cases that
qcom_pcie_parse_legacy_binding() might handle.

Brian

>  	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
>  		list_del(&port->list);
>  

