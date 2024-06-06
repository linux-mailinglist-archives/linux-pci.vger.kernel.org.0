Return-Path: <linux-pci+bounces-8398-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 330638FE4B0
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 12:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D32821F261AE
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 10:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9854C188CB4;
	Thu,  6 Jun 2024 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VjgECtmK"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C393C2E639;
	Thu,  6 Jun 2024 10:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717671208; cv=none; b=uVrDZU3QpuEcPwmnA6rxoZG1/Kwc77RH7q6a1ue9KA9nlYiT8PVt1kjR315Y6slAWsleA5iKHKRq/ff7xfw01A4VCz8aEVStS0d+ZQyEU38EWjG2EvVl1H59NzAB1bdwJcrMBSYNjNdbPGCr3b4Y0heAPuCt6O35f5Stk34zOtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717671208; c=relaxed/simple;
	bh=ZpuzNlwMqe4oHu3girJ5a0z9IYHGTkMdZYPNlhM+SdQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lItDjD6IFjyoeQ8YZUHT2DlJwkwNfiS1xkWL6MNj6EE6BMBNWmkcRS3muUDu0si/Lo7/B1rBk+oh/1tm42l7334Yt3zwk7//S0El3wOdj2zeO8Kp3inDTZuu5Wb51xHHvKvgre17M6yKywzZ1SSPNQGC762FsA3FtNlugZhXDKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VjgECtmK; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 456AqZ4k067178;
	Thu, 6 Jun 2024 05:52:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717671155;
	bh=ZHhYe9SXX81VO9UiinRj2/vpq4eEiarfDw7Bhml8Hpc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=VjgECtmKCuhCXw6iZwOgDvXfZncWFe9iL8P5si5yVX3gRYm/GMZXQMhQQuKYOMOsv
	 fKWS8rOLCPNIB8l4894jY5tdDgBTqnqQbbrXnFWAziOcyC52SvpcNcvHVIFre6iBqR
	 VijY43WsvZoGGvEIqkAjZdYup9nrh6S/UUewJDlQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 456AqZLg053435
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Jun 2024 05:52:35 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 6
 Jun 2024 05:52:35 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 6 Jun 2024 05:52:35 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 456AqYOG071819;
	Thu, 6 Jun 2024 05:52:34 -0500
Date: Thu, 6 Jun 2024 16:22:33 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha
 Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team
	<kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Minghuan Lian
	<minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang
	<roy.zang@nxp.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jingoo Han
	<jingoohan1@gmail.com>,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Marek
 Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>,
        Thierry Reding
	<thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko
 Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu
	<mhiramat@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <imx@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <mhi@lists.linux.dev>, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH 3/5] PCI: dwc: ep: Add a generic dw_pcie_ep_linkdown()
 API to handle Link Down event
Message-ID: <bea79de4-b49b-44a5-990e-071d9c35bff4@ti.com>
References: <20240606-pci-deinit-v1-0-4395534520dc@linaro.org>
 <20240606-pci-deinit-v1-3-4395534520dc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240606-pci-deinit-v1-3-4395534520dc@linaro.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Thu, Jun 06, 2024 at 12:56:36PM +0530, Manivannan Sadhasivam wrote:
> As per the PCIe base spec r5.0, section 5.2, Link Down event can happen
> under any of the following circumstances:
> 
> 1. Fundamental/Hot reset
> 2. Link disable transmission by upstream component
> 3. Moving from L2/L3 to L0
> 
> In those cases, Link Down causes some non-sticky DWC registers to loose the
> state (like REBAR, etc...). So the drivers need to reinitialize them to
> function properly once the link comes back again.
> 
> This is not a problem for drivers supporting PERST# IRQ, since they can
> reinitialize the registers in the PERST# IRQ callback. But for the drivers
> not supporting PERST#, there is no way they can reinitialize the registers
> other than relying on Link Down IRQ received when the link goes down. So
> let's add a DWC generic API dw_pcie_ep_linkdown() that reinitializes the
> non-sticky registers and also notifies the EPF drivers about link going
> down.
> 
> This API can also be used by the drivers supporting PERST# to handle the
> scenario (2) mentioned above.
> 
> NOTE: For the sake of code organization, move the dw_pcie_ep_linkup()
> definition just above dw_pcie_ep_linkdown().
> 
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

This patch already seems to be present in linux-next:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=3d2e425263e2674713220379ad04e925efdb731d&h=next

Other patches in this series also seem to be merged.

[...]

Regards,
Siddharth.

