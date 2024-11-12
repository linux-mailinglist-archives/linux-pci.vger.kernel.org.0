Return-Path: <linux-pci+bounces-16613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50169C6531
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 00:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6521284859
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 23:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C0921A4D2;
	Tue, 12 Nov 2024 23:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYsog4D+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D303F61FD7;
	Tue, 12 Nov 2024 23:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731454325; cv=none; b=LywXE8mwbB4pOyg+q9+PmIC4p7yYnUvV6JIsdRkl3PxlqdjN6wTVUK/fFSwjg1RIN4CjRo6JMc8iyKOQPiE3TBCSqNTlFhHYdSHjZzayy7wMecntXMMMt48UrkXKAiAC6wIl5Ea5mqND6BiaWImaPq0rtLjiJLkm7LDOpXqgA8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731454325; c=relaxed/simple;
	bh=BTvBKA7o2+woAUiRxBLS40rKUjsEcAiQ9VqZLBbUmrE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZylUvgtFaK6jSoppVWcNmkN0qhlfA5sSTAVaeUL6+vpw2vj8E2m7uS2+jpgbzeD6Wi7Bdg5ImBhbfuV2OCWxgCqYPN7aR+c1fXn9LA+4JLJlmT4wNGUKQA00zUJd+Hx8uaaT0DM3X7awMsb9mI93Jl6VfGe26qk0edbcN9nIoNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYsog4D+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4672BC4CECD;
	Tue, 12 Nov 2024 23:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731454324;
	bh=BTvBKA7o2+woAUiRxBLS40rKUjsEcAiQ9VqZLBbUmrE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YYsog4D+277jiwZhlVlCacEoGamSkpVNXWnGtbKRpfna7MnsC8HGrc/uTQCQcPbzP
	 7ADCvdgD3pzncivgfu1/CqIV0s2VFysMw8Ys6ymIKTBdO5e5izvIQqHNqid+aVafFb
	 xOPG1HF7cR3fDsfWgEuUAWa5XySUyhBOVfa3pfVlh7kn7HCfVIhcTXOZrVUz8gtQET
	 SJwb4qyLet69DRVK959P1+9OwEPjNarseYJsxSogiLb8zbyeJID5aVxVlLweqYAeHH
	 73QYm24dVwNBiDE+jCJkO2sJOd9Yk1K6UKjKcSpxvDF6ewuI2Hi86pXvTT2ATR2uNU
	 OEifPxd/OyFNg==
Date: Tue, 12 Nov 2024 17:32:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: andersson@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] PCI: dwc: Add support for new pci function op
Message-ID: <20241112233202.GA1868078@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112-qps615_pwr-v3-4-29a1e98aa2b0@quicinc.com>

On Tue, Nov 12, 2024 at 08:31:36PM +0530, Krishna chaitanya chundru wrote:
> Add the support for stop_link() and  start_link() function op.

When you update the series for the build issue, also update the
subject line here so it's more useful by itself, e.g.,

  PCI: dwc: Implement .start_link(), .stop_link() hooks

Seems like the .host_start_link() bits might be a separate patch?
They're not mentioned in this commit log and don't look directly
related.

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 18 ++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h      | 16 ++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 3e41865c7290..d7e7f782390a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -691,10 +691,28 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
>  
> +static int dw_pcie_op_start_link(struct pci_bus *bus)
> +{
> +	struct dw_pcie_rp *pp = bus->sysdata;
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +
> +	return dw_pcie_host_start_link(pci);
> +}
> +
> +static void dw_pcie_op_stop_link(struct pci_bus *bus)
> +{
> +	struct dw_pcie_rp *pp = bus->sysdata;
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +
> +	dw_pcie_host_stop_link(pci);
> +}
> +
>  static struct pci_ops dw_pcie_ops = {
>  	.map_bus = dw_pcie_own_conf_map_bus,
>  	.read = pci_generic_config_read,
>  	.write = pci_generic_config_write,
> +	.start_link = dw_pcie_op_start_link,
> +	.stop_link = dw_pcie_op_stop_link,
>  };
>  
>  static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 347ab74ac35a..b88b4edafcc3 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -433,6 +433,8 @@ struct dw_pcie_ops {
>  	enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);
>  	int	(*start_link)(struct dw_pcie *pcie);
>  	void	(*stop_link)(struct dw_pcie *pcie);
> +	int	(*host_start_link)(struct dw_pcie *pcie);
> +	void	(*host_stop_link)(struct dw_pcie *pcie);
>  };
>  
>  struct dw_pcie {
> @@ -665,6 +667,20 @@ static inline void dw_pcie_stop_link(struct dw_pcie *pci)
>  		pci->ops->stop_link(pci);
>  }
>  
> +static inline int dw_pcie_host_start_link(struct dw_pcie *pci)
> +{
> +	if (pci->ops && pci->ops->host_start_link)
> +		return pci->ops->host_start_link(pci);
> +
> +	return 0;
> +}
> +
> +static inline void dw_pcie_host_stop_link(struct dw_pcie *pci)
> +{
> +	if (pci->ops && pci->ops->host_stop_link)
> +		pci->ops->host_stop_link(pci);
> +}
> +
>  static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
>  {
>  	u32 val;
> 
> -- 
> 2.34.1
> 

