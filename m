Return-Path: <linux-pci+bounces-40001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DBCC2782A
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 06:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94F61B21263
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 05:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDD623E33D;
	Sat,  1 Nov 2025 05:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Skg1ovcY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBFE128819;
	Sat,  1 Nov 2025 05:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761973619; cv=none; b=bFI2XSaLCB4CncC3/YbYP/vq9A9C1USJXjVDFtcg6nbasYfoH7DE/wgFi3UTSm9e7A5S1D0JTjDbwgzYzhjn/950ICxvxaYYG9ct3Qp89FG49C9gnWoOyhFTZUkWvK3xogcj2ZMAa61gQpZSNVs3BELfK2E35aaz+w0SX2FDH9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761973619; c=relaxed/simple;
	bh=3hnXih81jmJOkxMCNZoUXFBZRFYe1mHmNE4jL+zmcVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMSQABP+mKgmAr9xfQO9jprjtrwPFhrLwW4RKcQfniHMJ6DndPgKHR+5mgk17pd8k2sDsvX+5L7LE0rsYrBlOeVMqNmnP2p39YRjF3CXn9XOPkAe3sNLrbBgst+pZf4drDt9pkGdvZPAhWIe/52vrJz0Zs2gSxxrY4GaKMslt6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Skg1ovcY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9990C4CEF1;
	Sat,  1 Nov 2025 05:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761973618;
	bh=3hnXih81jmJOkxMCNZoUXFBZRFYe1mHmNE4jL+zmcVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Skg1ovcY4cmjoynuJMP75WqnhJI9BmGGjnfrmTQmG6iR5eXlVYmqdlHQ5hHMuiyDj
	 jXhosXHcdlzZILGGn92qIPUu44GJQSTrCTACJmL6kynisZFg5PDQ7KhlaJXagKj5T9
	 6HUZ4Q7AxgK4Viz3W7uDgZQ8z1JFTu5Oixj1oZFQrykGXInmgl3JfXAedJSEstQfQ4
	 zhrdmuuOYfkizjusQNY6mhIwlvTGpEYJU+24RJhWd1zQiEHTVOITNpVwhRRSUq3wFp
	 QWnGjFQ6aCm7o3IsFTcRsivp04iPVnQlUmEnqDgKhIBXm4BoTTyBnhmYpLKoSeUW6O
	 G36wMIi16YOgw==
Date: Sat, 1 Nov 2025 10:36:45 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v9 4/7] PCI: dwc: Implement .assert_perst() hook
Message-ID: <bkromhlltdhbmrmhc6w3knrwrs6pi3nhya7mg6odg6ihkzimza@e2huxtvqajxn>
References: <20251101-tc9563-v9-0-de3429f7787a@oss.qualcomm.com>
 <20251101-tc9563-v9-4-de3429f7787a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251101-tc9563-v9-4-de3429f7787a@oss.qualcomm.com>

On Sat, Nov 01, 2025 at 09:29:35AM +0530, Krishna Chaitanya Chundru wrote:
> Implement assert_perst() function op for dwc drivers.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

This and the previous patch should be squashed. But no need to resend just for
this change, as this could be handled while applying.

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 20c9333bcb1c4812e2fd96047a49944574df1e6f..b56dd1d51fa4f03931942dc9da649bef8859f192 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -842,10 +842,19 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
>  
> +static int dw_pcie_op_assert_perst(struct pci_bus *bus, bool assert)
> +{
> +	struct dw_pcie_rp *pp = bus->sysdata;
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +
> +	return dw_pcie_assert_perst(pci, assert);
> +}
> +
>  static struct pci_ops dw_pcie_ops = {
>  	.map_bus = dw_pcie_own_conf_map_bus,
>  	.read = pci_generic_config_read,
>  	.write = pci_generic_config_write,
> +	.assert_perst = dw_pcie_op_assert_perst,
>  };
>  
>  static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

