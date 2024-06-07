Return-Path: <linux-pci+bounces-8435-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E288FFF29
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 11:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76710B20CB4
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 09:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4FF15B551;
	Fri,  7 Jun 2024 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyfHmQ1w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1DF2209D;
	Fri,  7 Jun 2024 09:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752093; cv=none; b=k9yL/IbfhelGTuc5shhEKilR65BtsW2X80xIlaZwmMg+bAKcytzkOVvWcdmDQHslVvJKeCEX+dCvvE342f4WTumRfICUxKfoM2kXPozoAsD6kHBCoO2gk/5+DfUlUOBmLP5VgOUR3r5pD4BzlDN7m0Zd2rlS7Mw1gO8SsCWlOh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752093; c=relaxed/simple;
	bh=PUBYPlYV+0CEGjbaUressY4P2n0tji7Q+2OKwCAMyuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2By4bljJOZRjRfcCypbHIfRAXrwOM3Bkm/EM3iJNu5ZFX1PjJ+Gd9diR3g4AgSupYwVFojcxleAZ9Ep3utP/rLdBAPu3Qw5pLp3eli0WJTDjMqWzWBtcT4uoX51Zbwb1dpJeveKbago52sVw5VvdorpmWubJk+pXExHvTyVaD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyfHmQ1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12495C32786;
	Fri,  7 Jun 2024 09:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717752092;
	bh=PUBYPlYV+0CEGjbaUressY4P2n0tji7Q+2OKwCAMyuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CyfHmQ1w3+wQAG6AtCTgiWqJMB9O1sIpPf3pIJtRCrDXSX9T1RydsbJjY8P1zFZtG
	 LT/PFHmDHGNRqFIXrBOuJ8v9O6HrOpih1xjYoPW2Znw2MmXr8f9IdaSEynhdON2MY1
	 EHI2RTTuFLW27F8X7An9HqhIAhpeh4AvoX5N1YKluMO1/KzuzrE1UztGokk+7W0i7t
	 MVP1FN3HfXC3zjAn2UOB50naV1ozvIJDXyQP6y+XZRqOL7D1G1/JBztS8I+uV1SDlf
	 RKmIwxJnmMTfvIhAeZ7TIXXZ+jb6AY34kaoxtbvFjg1FY3yQlMZrZhbCIjXSBPaSuQ
	 IsrssWc6AizUg==
Date: Fri, 7 Jun 2024 11:21:22 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@axis.com, linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
	mhi@lists.linux.dev, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 1/5] PCI: dwc: ep: Remove dw_pcie_ep_init_notify() wrapper
Message-ID: <ZmLREhi8_iCDZTP3@ryzen.lan>
References: <20240606-pci-deinit-v1-0-4395534520dc@linaro.org>
 <20240606-pci-deinit-v1-1-4395534520dc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606-pci-deinit-v1-1-4395534520dc@linaro.org>

On Thu, Jun 06, 2024 at 12:56:34PM +0530, Manivannan Sadhasivam wrote:
> Currently dw_pcie_ep_init_notify() wrapper just calls pci_epc_init_notify()
> directly. So this wrapper provides no benefit to the glue drivers.
> 
> So let's remove it and call pci_epc_init_notify() directly from glue
> drivers.
> 
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>

