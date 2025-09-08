Return-Path: <linux-pci+bounces-35684-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31080B49861
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 20:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1907168DE7
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 18:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113C231B13E;
	Mon,  8 Sep 2025 18:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQjBvLjK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39C331AF10;
	Mon,  8 Sep 2025 18:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757356409; cv=none; b=OhjSihkzTJ525fIoWqpaIurW96CGNKuKoF8kclrlsR+JSySn1aMuMldgt3DBsEl2hi2p0T5N4HJzTZ6lT7WtKo7+8XmbErqb0DUfkGtoWIOycEU3Nv4QQGXeZaEqAZ0yIhfWqAbcLy2kVJX4AqAWGsLH6VChkwnXAtuvBwwEOeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757356409; c=relaxed/simple;
	bh=ejH/GOe9Mp+BMNiV+zRI9hMfPJDA9yQMvdvKWLFHIu4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mTWGPYGiIIlF0nxnkUt3k6OFBOWxpp6g81QWFRN55gSL4Qt8aNGWK2MRSWK9x9YOwSgDmXzI0utN5atQAVr5rM0iYCFswDRXhYguc3K7uzLFJ1qY0vKJPgCoChYEerFY3oVZFDxHLPGyfhQwsISLD6LYIGJzS+WoPXZFHqKoZsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQjBvLjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B61AC4CEFA;
	Mon,  8 Sep 2025 18:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757356407;
	bh=ejH/GOe9Mp+BMNiV+zRI9hMfPJDA9yQMvdvKWLFHIu4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hQjBvLjKN/9OeE0fQURd4qFcWwXmB8JZ1u9xc224NcPx9FpTzpuEhqxV0vs1B3dA7
	 gh5pVA2TmHTva9sC+gfDXVFKYTjhn7y3zSR8ufDN5GibKQzAdJ6LwvcLiEmSu8j3Ze
	 N/x1jgF2OJ1O1occFYIh7TyD9h8E9gF0XZNA4iqEBxm/MM/hGfzeHQ3OWSxlXkXpWR
	 D/yqCZsqZS/OlX4D72JrVcLJhIWABSAjeBJs4dXgUoVUDbzZYbHf2KpK3ncPjZHI7Q
	 R3bkvMM25FB34Zf5S/qHhbhzdmAwAkshfYRbe0JqDvc16tx9JK1B9/bylkRp+KsthO
	 LxGMqKqyr2pYw==
Date: Mon, 8 Sep 2025 13:33:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com
Subject: Re: [PATCH v5 2/2] PCI: qcom: Add support for multi-root port
Message-ID: <20250908183325.GA1450728@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-perst-v5-2-920b3d1f6ee1@qti.qualcomm.com>

On Wed, Jul 02, 2025 at 04:50:42PM +0530, Krishna Chaitanya Chundru wrote:
> Move phy, PERST# handling to root port and provide a way to have multi-port
> logic.
> 
> Currently, QCOM controllers only support single port, and all properties
> are present in the host bridge node itself. This is incorrect, as
> properties like phys, perst-gpios, etc.. can vary per port and should be
> present in the root port node.
> 
> To maintain DT backwards compatibility, fallback to the legacy method of
> parsing the host bridge node if the port parsing fails.
> 
> pci-bus-common.yaml uses reset-gpios property for representing PERST#, use
> same property instead of perst-gpios.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 178 ++++++++++++++++++++++++++++-----
>  1 file changed, 151 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index f7ed1e010eb6607b2e98a42f0051c47e4de2af93..56d04a15edf8f99f6d3b9bfaa037ff922b521888 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -267,6 +267,12 @@ struct qcom_pcie_cfg {
>  	bool no_l0s;
>  };
>  
> +struct qcom_pcie_port {
> +	struct list_head list;
> +	struct gpio_desc *reset;
> +	struct phy *phy;

This change is already upstream (a2fbecdbbb9d ("PCI: qcom: Add support
for parsing the new Root Port binding")), but it seems wrong to me to
have "phy" and "reset" in both struct qcom_pcie and struct
qcom_pcie_port.  

I know we need *find* those things in different places (either a
per-Root Port DT stanza or the top-level qcom host bridge), but why
can't we always put them in struct qcom_pcie_port and drop them from
struct qcom_pcie?

Having them in both places means all the users need to worry about
that DT difference and look in both places instead of always looking
at qcom_pcie_port.

> +};
> +
>  struct qcom_pcie {
>  	struct dw_pcie *pci;
>  	void __iomem *parf;			/* DT parf */
> @@ -279,24 +285,37 @@ struct qcom_pcie {
>  	struct icc_path *icc_cpu;
>  	const struct qcom_pcie_cfg *cfg;
>  	struct dentry *debugfs;
> +	struct list_head ports;
>  	bool suspended;
>  	bool use_pm_opp;
>  };

> +static void qcom_perst_assert(struct qcom_pcie *pcie, bool assert)
>  {
> -	gpiod_set_value_cansleep(pcie->reset, 1);
> +	struct qcom_pcie_port *port;
> +	int val = assert ? 1 : 0;
> +
> +	if (list_empty(&pcie->ports))
> +		gpiod_set_value_cansleep(pcie->reset, val);
> +	else
> +		list_for_each_entry(port, &pcie->ports, list)
> +			gpiod_set_value_cansleep(port->reset, val);

This is the kind of complication I think we should avoid.

> +static void qcom_pcie_phy_exit(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_port *port;
> +
> +	if (list_empty(&pcie->ports))
> +		phy_exit(pcie->phy);
> +	else
> +		list_for_each_entry(port, &pcie->ports, list)
> +			phy_exit(port->phy);

And this.

> +}
> +
> +static void qcom_pcie_phy_power_off(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_port *port;
> +
> +	if (list_empty(&pcie->ports)) {
> +		phy_power_off(pcie->phy);
> +	} else {
> +		list_for_each_entry(port, &pcie->ports, list)
> +			phy_power_off(port->phy);

And this.  And there's more.

Bjorn

