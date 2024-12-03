Return-Path: <linux-pci+bounces-17587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ADE9E2B70
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 19:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A04B1656CC
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 18:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8AC1FDE26;
	Tue,  3 Dec 2024 18:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUSTOJ+T"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF971362;
	Tue,  3 Dec 2024 18:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733252136; cv=none; b=SEOM1izVuTQ2tvX637dXDOag1ypadsR2czuNoKWZ9+4dMvrXkUdH5KYbs82bBZCovRUq5GR4eLpw/Gvz/Hy1FFXU2UTZW4LIRYTdEUs4/R2dP2QGvsL12yPG6bfoyJiTCNfrqNVWyD0+odMMXGVGG3OVty3uOA5xz4Jss1UfsDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733252136; c=relaxed/simple;
	bh=RwT+fnDrboieIPEA7JR3/Pyc460cjUeXQCozuRE4M7w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UnkBQsI7IYe7ws3n67VnAbX3g53fJ6VS39GuBC9/ezQTAcrvPnqIpu6DH/wz3syP5CHyZPej9GxlWIvatPmEjniTWcsa7hYQ70tupNQ2JiZH5uxn6NGWx8b+2INhaLZLARQ6a7VKFfz2xoIUbHPcBepw2fB06sDct0ZlnYgNEsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUSTOJ+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2049C4CECF;
	Tue,  3 Dec 2024 18:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733252135;
	bh=RwT+fnDrboieIPEA7JR3/Pyc460cjUeXQCozuRE4M7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OUSTOJ+TUZ14+u83JYK8GPm8MNxZjF4pBy2zS6YU8mLy38FqQriYaXJOIgpHNy3uW
	 xOpRBv7dGodr3F+vh3BDBQOwaclP272iCxD2XEMphC2uH6quZnzK1qbV9WxG8iE62c
	 yw/NzE4p4UoGhv5aB9biob1bY+rw8GZjEQA7ljD6XxqCNLcpbkdulUR2hdp5y/7SGh
	 8C659+vUqjS0aO6OpD0P3SpjHRwwOIGdzXtA8ytd6oFbJ39B4HtLkFnZ7tILvrmuOu
	 Ib5P/0Iqk7VU13BTariAL1Fw4nJBmr1oKE5sEVBtTCDzkOB4K86nK5V9FEYTtjd8bq
	 CscJnkLfdbHig==
Date: Tue, 3 Dec 2024 12:55:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: cros-qcom-dts-watchers@chromium.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, quic_vbadigan@quicinc.com,
	quic_ramkri@quicinc.com, quic_nitegupt@quicinc.com,
	quic_skananth@quicinc.com, quic_vpernami@quicinc.com,
	quic_mrana@quicinc.com, mmareddy@quicinc.com,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: dwc: Add ECAM support with iATU configuration
Message-ID: <20241203185534.GA2910014@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241117-ecam-v1-2-6059faf38d07@quicinc.com>

On Sun, Nov 17, 2024 at 03:30:19AM +0530, Krishna chaitanya chundru wrote:
> The current implementation requires iATU for every configuration
> space access which increases latency & cpu utilization.
> 
> Configuring iATU in config shift mode enables ECAM feature to access the
> config space, which avoids iATU configuration for every config access.
> 
> Add "ctrl2" into struct dw_pcie_ob_atu_cfg  to enable config shift mode.
> 
> As DBI comes under config space, this avoids remapping of DBI space
> separately. Instead, it uses the mapped config space address returned from
> ECAM initialization. Change the order of dw_pcie_get_resources() execution
> to acheive this.

s/acheive/achieve/

> Introduce new ecam_init() function op for the clients to configure after
> ecam window creation has been done.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 114 ++++++++++++++++++----
>  drivers/pci/controller/dwc/pcie-designware.c      |   2 +-
>  drivers/pci/controller/dwc/pcie-designware.h      |   6 ++
>  3 files changed, 102 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 3e41865c7290..e98cc841a2a9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -418,6 +418,62 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
>  	}
>  }
>  
> +static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct dw_pcie_ob_atu_cfg atu = {0};
> +	struct resource_entry *bus;
> +	int ret, bus_range_max;
> +
> +	bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS);
> +
> +	/*
> +	 * Bus 1 config space needs type 0 atu configuration
> +	 * Remaining buses need type 1 atu configuration

s/atu/ATU/ (initialism, looks like "iATU" might be appropriate here?)

I'm confused about the bus numbering; you refer to "bus 1" and "bus
2".  Is bus 1 the root bus, i.e., the primary bus of a Root Port?

The root bus number would typically be 0, not 1, and is sometimes
programmable.  I don't know how the DesignWare core works, but since
you have "bus" here, referring to "bus 1" and "bus 2" here seems
overly specific.

> +	 */
> +	atu.index = 0;
> +	atu.type = PCIE_ATU_TYPE_CFG0;
> +	atu.cpu_addr = pp->cfg0_base + SZ_1M;
> +	atu.size = SZ_1M;
> +	atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;
> +	ret = dw_pcie_prog_outbound_atu(pci, &atu);
> +	if (ret)
> +		return ret;
> +
> +	bus_range_max = bus->res->end - bus->res->start + 1;
> +
> +	/* Configure for bus 2 - bus_range_max in type 1 */
> +	atu.index = 1;
> +	atu.type = PCIE_ATU_TYPE_CFG1;
> +	atu.cpu_addr = pp->cfg0_base + SZ_2M;
> +	atu.size = (SZ_1M * (bus_range_max - 2));
> +	atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;
> +	return dw_pcie_prog_outbound_atu(pci, &atu);
> +}
> +
> +static int dw_pcie_create_ecam_window(struct dw_pcie_rp *pp, struct resource *res)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct device *dev = pci->dev;
> +	struct resource_entry *bus;
> +
> +	bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS);
> +	if (!bus)
> +		return -ENODEV;
> +
> +	pp->cfg = pci_ecam_create(dev, res, bus->res, &pci_generic_ecam_ops);
> +	if (IS_ERR(pp->cfg))
> +		return PTR_ERR(pp->cfg);
> +
> +	pci->dbi_base = pp->cfg->win;
> +	pci->dbi_phys_addr = res->start;
> +
> +	if (pp->ops->ecam_init)
> +		pp->ops->ecam_init(pci, pp->cfg);

.ecam_init() is defined to return int, but you ignore the return value.
If it's practical, I think it would be nicer if you could manage to:

  - Drop .enable_ecam.

  - Have .ecam_init() return failure if there's not enough ECAM space
    or whatever, i.e., move the qcom_pcie_check_ecam_support() code
    there.

  - Handle .ecam_init() failure here by doing whatever we did before.

If there's no useful return value from .ecam_init(), make it void.

> +	return 0;
> +}

> @@ -454,6 +499,30 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  
>  	pp->bridge = bridge;
>  
> +	pp->cfg0_size = resource_size(res);
> +	pp->cfg0_base = res->start;
> +
> +	if (!pp->enable_ecam) {

If you can't get rid of .enable_ecam, reverse order so this uses
positive logic:

  if (pp->enable_ecam) {
    ...
  } else {
    ...
  }

> +		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
> +		if (IS_ERR(pp->va_cfg0_base))
> +			return PTR_ERR(pp->va_cfg0_base);
> +
> +		/* Set default bus ops */
> +		bridge->ops = &dw_pcie_ops;
> +		bridge->child_ops = &dw_child_pcie_ops;
> +		bridge->sysdata = pp;
> +	} else {
> +		ret = dw_pcie_create_ecam_window(pp, res);
> +		if (ret)
> +			return ret;
> +		bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
> +		pp->bridge->sysdata = pp->cfg;
> +	}


