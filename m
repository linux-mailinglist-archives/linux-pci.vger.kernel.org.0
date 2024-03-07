Return-Path: <linux-pci+bounces-4619-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AB9875872
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 21:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1EF282888
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 20:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54615DF27;
	Thu,  7 Mar 2024 20:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNX5GCMv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9674E51C45;
	Thu,  7 Mar 2024 20:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843565; cv=none; b=inqJJ8lcajPL4/Rv/HGBSrmzlX3zI15Kevl2Ddu19Wvw2Id7SowbFzKFoBw6InXtijAsD1lu0ECsYP31znaG296puzlbK+//nfB4VieUVEedRxNmc+7P1u2DdFUFTNAQW3leQPDiHBnJSHjCP68AeBhU6xlQsI04nWGQmwMV4Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843565; c=relaxed/simple;
	bh=/eQrZoho3Wzd/75riAoruvb3tT+NYdsxycvt61HCYmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4DABe3y7CnsL/JC3tBCXVUsBUEPozNmPl87cRUojRb5EZFsp9jcJlqWvEzGRcGQtVfX2prvVwhLeITAP28CZrLOcOFNVc1Yc5ByoS+3O4qX8jJDASyf0ea/XkZUcwaEDc1CJzKAXlTEuGm7tHKwpwmeM4C6s0ydgbjcQ4xKRPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNX5GCMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8FCC433C7;
	Thu,  7 Mar 2024 20:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709843565;
	bh=/eQrZoho3Wzd/75riAoruvb3tT+NYdsxycvt61HCYmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XNX5GCMvQd5p6SjKBCBDsFaGBKXnIVmmhZvMc1W8pH447n17fUwmEaDyqLyMdbSQY
	 2t/EYdMtL7v6Nl2hsDlwbc9m5lgDCP7fYvhYNJZBZ1dONwb2FB//LuqX/4/7Uk4Jhf
	 BZw+mbfxjqaWkZ4slSudIrtB/RAVrWEZUeRqB4zyd4FhD13s+mPETJg1AQIgvqC07t
	 gFDWnbqkvP5UQr1Pi5SxnaPKw13PzGDvJsIvpdMiKMsyPLRyE2G2Vh+ejhfqw3xCaU
	 16m8UQ+otYlGXUAF+Q0tqKVPdpJ+XnkCyonux+8lyDex7cu5Hq3m6XRAZxkAkNsMje
	 yLa33Z8NVr1PA==
Date: Thu, 7 Mar 2024 21:32:34 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
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
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@axis.com, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v9 05/10] PCI: dwc: ep: Rename dw_pcie_ep_init_complete()
 to dw_pcie_ep_init_registers()
Message-ID: <ZeokYvURBffwERzJ@ryzen>
References: <20240304-pci-dbi-rework-v9-0-29d433d99cda@linaro.org>
 <20240304-pci-dbi-rework-v9-5-29d433d99cda@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-pci-dbi-rework-v9-5-29d433d99cda@linaro.org>

On Mon, Mar 04, 2024 at 02:52:17PM +0530, Manivannan Sadhasivam wrote:
> The goal of the dw_pcie_ep_init_complete() API is to initialize the DWC
> specific registers post registering the controller with the EP framework.
> 
> But the naming doesn't reflect its functionality and causes confusion. So,
> let's rename it to dw_pcie_ep_init_registers() to make it clear that it
> initializes the DWC specific registers.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>

