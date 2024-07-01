Return-Path: <linux-pci+bounces-9513-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B46E191DD92
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 13:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ABA61F22A4C
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 11:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B6013C68A;
	Mon,  1 Jul 2024 11:10:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CA9376E7;
	Mon,  1 Jul 2024 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719832228; cv=none; b=YanOX0DJ5KwN3G18AOZXroEa8Nt4dybhYFC38PNgu4gCC5lAHuplHBhGoor4xfUf5RhAzE1zk6z5oQKEN0cWU7Y/kVyPJAZvLWFkjrwhEIzXYZApiYCo6x5NeE5bav9eVZOGyx2lHd/0d3DDpvoKC76jlYWD+fpxTDec5Geta/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719832228; c=relaxed/simple;
	bh=hOxo+CCo6ey+uM9xytdRuy1uiZceOijxF9NTXT4DWAY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IULCoNMUbVj9Kv90UAy+DdDdVK1Sq3YVj9wk2lv8peQ8s6Qgplo2SjleCFnmOS5ob50d7ib9yJc5ik4Iy4fMs4x3VCAYME70rQVrhdvTFyTmqfD/bPfpkuY9vgJjqfHaxPMXzzIY9eQdD1mkq/RquHWcXauKpCRA68QAiYJylHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WCNbV2K74z67yMW;
	Mon,  1 Jul 2024 19:09:26 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E90F1400D1;
	Mon,  1 Jul 2024 19:10:23 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 1 Jul
 2024 12:10:22 +0100
Date: Mon, 1 Jul 2024 12:10:21 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shradha Todi <shradha.t@samsung.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<manivannan.sadhasivam@linaro.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<fancer.lancer@gmail.com>, <yoshihiro.shimoda.uh@renesas.com>,
	<conor.dooley@microchip.com>, <pankaj.dubey@samsung.com>,
	<gost.dev@samsung.com>
Subject: Re: [PATCH 3/3] PCI: dwc: Create debugfs files in DWC driver
Message-ID: <20240701121021.00004f0b@Huawei.com>
In-Reply-To: <20240625093813.112555-4-shradha.t@samsung.com>
References: <20240625093813.112555-1-shradha.t@samsung.com>
	<CGME20240625094446epcas5p4e5e864d5f56af0a44e950a426bc9f5f5@epcas5p4.samsung.com>
	<20240625093813.112555-4-shradha.t@samsung.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 25 Jun 2024 15:08:13 +0530
Shradha Todi <shradha.t@samsung.com> wrote:

> Add call to initialize debugfs from DWC driver and create the RASDES
> debugfs hierarchy for each platform driver. Since it can be used for
> both DW HOST controller as well as DW EP controller, add it in the
> common setup function.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>

Squash this with the previous patch given it's so trivial.

> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 2 ++
>  drivers/pci/controller/dwc/pcie-designware.c      | 4 ++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index d15a5c2d5b48..c2e6f8484000 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -537,6 +537,8 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
>  	pci_stop_root_bus(pp->bridge->bus);
>  	pci_remove_root_bus(pp->bridge->bus);
>  
> +	dwc_pcie_rasdes_debugfs_deinit(pci);
> +
>  	dw_pcie_stop_link(pci);
>  
>  	dw_pcie_edma_remove(pci);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index b74e4a97558e..ebb21ba75388 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -1084,4 +1084,8 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
>  
>  	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
> +
> +	val = dwc_pcie_rasdes_debugfs_init(pci);
> +	if (val)
> +		dev_err(pci->dev, "Couldn't create debugfs files\n");
>  }


