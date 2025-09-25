Return-Path: <linux-pci+bounces-36985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA922BA015C
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 16:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 376577B618B
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 14:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3B22E093B;
	Thu, 25 Sep 2025 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0ikscfs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E7638DDB;
	Thu, 25 Sep 2025 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812060; cv=none; b=grL3cKvqyM50Ux8SHbElu2DuwgXnW0mVEElXClOptZsPv9f6zP96AO7N4zrqXGhG+xTK9PoDJhdE27oHzTmini7fxBpfsh/bp7YTEHog/4v4tnJMeKNXuftd8QjI4YM4/MdUaLCxBaXbsytirkfyk2qFJPo6fzzaBqhgP+ARKnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812060; c=relaxed/simple;
	bh=jPB4xVjcQGBdG5oVew+Lht5SAent64Z1rar77L6+Oek=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GQVc0fSU6nsgIrhhkgrlha1BQA4olwFFgV2+GCcTep/TdCqUlEbBQAtnpX6EGNdnKim4H6BU6vgKXT8Yi7k711t5QtoCSKaox7Uptn+IZdb2vAxJDBl7RNpsKFInHhta785JwPFhPRW86CfYSV2BO5UqHkFzsy/6EiYZol6ePc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0ikscfs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1156C4CEF5;
	Thu, 25 Sep 2025 14:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758812059;
	bh=jPB4xVjcQGBdG5oVew+Lht5SAent64Z1rar77L6+Oek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=u0ikscfs6G31P4bXOTz2TswSzOQR1fdgspn6lZ9NqdIHjbRuPl15mbV861jRpCSKh
	 ONvJHPSdZM0VQeYD6iNJ22uILG6QNWyf/AloAuCz3WEFLN8B5MfTy2fDdP7lJsYS7P
	 vLG4AbgEUPbVVSPUSzdqXrNxu6uMJ6IdN417gD/aevH9gFc1x74tpQuA5LplmbtVfE
	 eD11RHPJKmcJYA71znv9g5U8UfhkdBzU1qOzhnEad5xxWHVkHj8XJYB5pL9rDGZMC8
	 M3QXZyRYhzwSrWnHvXoyvj2oWYw4hsJefjMtK4o65vqycS5pl0o9GTT4tVhEYYb9C0
	 28VOTxnZsP7Pg==
Date: Thu, 25 Sep 2025 09:54:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	chaitanya chundru <quic_krichai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, quic_vbadigan@quicnic.com,
	amitk@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH v6 5/9] PCI: dwc: Implement .start_link(), .stop_link()
 hooks
Message-ID: <20250925145416.GA2164008@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-qps615_v4_1-v6-5-985f90a7dd03@oss.qualcomm.com>

On Thu, Aug 28, 2025 at 05:39:02PM +0530, Krishna Chaitanya Chundru wrote:
> Implement stop_link() and  start_link() function op for dwc drivers.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 952f8594b501254d2b2de5d5e056e16d2aa8d4b7..bcdc4a0e4b4747f2d62e1b67bc1aeda16e35acdd 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -722,10 +722,28 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
>  
> +static int dw_pcie_op_start_link(struct pci_bus *bus)
> +{
> +	struct dw_pcie_rp *pp = bus->sysdata;
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +
> +	return dw_pcie_host_start_link(pci);

This takes a pci_bus *, which could be any PCI bus, but this only
works for root buses because it affects the link from a Root Port.

I know the TC9563 is directly below the Root Port in the current
topology, but it seems like the ability to configure a Switch with I2C
or similar is potentially of general interest, even if the switch is
deeper in the hierarchy.

Is there a generic way to inhibit link training, e.g., with the Link
Disable bit in the Link Control register?  If so, this could
potentially be done in a way that would work for any vendor and for
any Downstream Port, including Root Ports and Switch Downstream Ports.

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
> 
> -- 
> 2.34.1
> 

