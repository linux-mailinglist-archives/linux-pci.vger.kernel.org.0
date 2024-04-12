Return-Path: <linux-pci+bounces-6195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FEF8A36A1
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 21:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830C7287A7C
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 19:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19831509A5;
	Fri, 12 Apr 2024 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGLpNFOb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9585714EC4E;
	Fri, 12 Apr 2024 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712951918; cv=none; b=tUNWqS8kDPD2iSRPXX7ITzIOurlnUJO34qa7H8vSyQcbT4N/FvjH5Ou62Ss4tKQ+GTNoK0dmKZ79E2x2X/De1XROV1vYtQV7u5toFuKbOUPkST2T/i99+IxG8tuWDEO+s3QN3YFx4H2KvzSNGGRkgJgTzpag1USrikgS8yxMewM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712951918; c=relaxed/simple;
	bh=9HYoa2q9zbdAwhkuDRDtehEu+C2d3K7WfVfQ1MwY5ts=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UsMt+tALfGQvR5WojI3kGQuCYNcAgf0jkY0t4zMgTu1sd92HQk1Mh1jQKPWWkdVXFIR7rYzpyds/KIVkKjm+4MwbDW9Fq5P7LKc6xqJTyooB8CefGvDLsDybDzoVCR4oi8twyh38lFfNcgAeboUPaKhVk4ZggKEcYlIxuMLxpG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGLpNFOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFEAC113CC;
	Fri, 12 Apr 2024 19:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712951918;
	bh=9HYoa2q9zbdAwhkuDRDtehEu+C2d3K7WfVfQ1MwY5ts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SGLpNFOblQMeIbaJAa2RR1y9xP1A4VwRPfNvrMemMrQdH7DFIEqXfWjED1/QhvtxO
	 hJwupFe0Zppd9Hx7FQ6sAD9A8zlkGNqxCKL93Lgv+HM/Tlv2ihysEEhBSMme0WU/xZ
	 RmyWk2LZ0EfMI6v7/A50srEd/rQl8GV6TNI7lhloC7ZsNkN79QdcezoDxDudu48TlU
	 6yeJb0nSJDsOMZYNoTJ//yRoBGLYAUywwOLqZRW1kYosaZ/FAmRG8UQ0qWOU9fuvNj
	 MUvOqI6C3if4nm0zgjmb2nXTx/fQpWCIEwE1QW09jgPv9Q7AQOn6hkEUrmUqhOGaI4
	 DTF2TST3dsEgA==
Date: Fri, 12 Apr 2024 14:58:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, Niklas Cassel <cassel@kernel.org>,
	linux-arm-kernel@axis.com, linux-rockchip@lists.infradead.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v12 2/8] PCI: dwc: ep: Add Kernel-doc comments for APIs
Message-ID: <20240412195836.GA13344@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327-pci-dbi-rework-v12-2-082625472414@linaro.org>

On Wed, Mar 27, 2024 at 02:43:31PM +0530, Manivannan Sadhasivam wrote:
> All of the APIs are missing the Kernel-doc comments. Hence, add them.

> + * dw_pcie_ep_reset_bar - Reset endpoint BAR

Apparently this resets @bar for every function of the device, so it's
not just a single BAR?

> + * dw_pcie_ep_raise_intx_irq - Raise INTx IRQ to the host
> + * @ep: DWC EP device
> + * @func_no: Function number of the endpoint
> + *
> + * Return: 0 if success, errono otherwise.

s/errono/errno/ (another instance below)

Bjorn

