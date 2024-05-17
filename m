Return-Path: <linux-pci+bounces-7613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A063F8C857F
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 13:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB9E1F220C2
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 11:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA753D576;
	Fri, 17 May 2024 11:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pnKxv3wR"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B8F3A8EF;
	Fri, 17 May 2024 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715944917; cv=none; b=lyLiXLoRcHXIZ7yFgHlLqCJyaeSVcp2i5hRBAVI829HBVPsRd4bbeReePMCzpDhn9J6xcntonbW1lnZPelyNDDatDCCroCkUcVKd8y3+wCBNe4B96MMe4+Jrkh2OMJts/UN+EcVjDLthSaMA/8NLoUqkhf/nsce7PYnm+gm4PXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715944917; c=relaxed/simple;
	bh=cCiMLIeRQ2EXgfa0YgaB46BmldEjRuND+u8cgoXj8jA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nq54Fkimf1wchCvA/g/E6EFYzJ2L9CkFLF7k/H9SyQRC64Mx5ryyucX39gF7p/knmoWwU5bKtHQIDUwbl+yLLYNEXQs5UCkZyjEHuoutJhFiSYsiYBJFJhrTIC9CwR/8u7PA/WWsFe0V+Y91dUmViKui0iDFc6NlxRSnPo7sM7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pnKxv3wR; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44HBKg9V111437;
	Fri, 17 May 2024 06:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715944842;
	bh=M9gLMIAiDHAcckpBA6eubUaCYcUpTziwh4/Q77XTl20=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=pnKxv3wREjHrW3r0IDs9vWgsr1lVRgaHQZuEryX4lHHhpM8MLY7TQnUzYwVTT3nMY
	 o/xww5ONhLtQyUiudXBPeHrqexHCBRCyEdxllCMkL1NTvEboN89YNDoHVKEsM9qQVr
	 qiIJByQY2KYw1OLVKCf32o+PG6Jx6wS+qmbDIIRU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44HBKgTI067066
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 17 May 2024 06:20:42 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 17
 May 2024 06:20:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 17 May 2024 06:20:42 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44HBKfhh080832;
	Fri, 17 May 2024 06:20:41 -0500
Date: Fri, 17 May 2024 16:50:40 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Onkarnarth <onkarnath.1@samsung.com>
CC: <bhelgaas@google.com>, <vigneshr@ti.com>, <s-vadapalli@ti.com>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <yue.wang@Amlogic.com>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <thomas.petazzoni@bootlin.com>,
        <shawn.guo@linaro.org>, <lchuanhua@maxlinear.com>,
        <srikanth.thokala@intel.com>, <songxiaowei@hisilicon.com>,
        <wangbinghui@hisilicon.com>, <manivannan.sadhasivam@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <hayashi.kunihiko@socionext.com>, <mhiramat@kernel.org>,
        <pali@kernel.org>, <toan@os.amperecomputing.com>,
        <daire.mcnamara@microchip.com>, <conor.dooley@microchip.com>,
        <marek.vasut+renesas@gmail.com>, <shawn.lin@rock-chips.com>,
        <heiko@sntech.de>, <nirmal.patel@linux.intel.com>,
        <jonathan.derrick@linux.dev>, <kishon@kernel.org>, <jdmason@kudzu.us>,
        <dave.jiang@intel.com>, <rafael@kernel.org>, <lenb@kernel.org>,
        <mahesh@linux.ibm.com>, <oohall@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <r.thapliyal@samsung.com>,
        Maninder Singh <maninder1.s@samsung.com>
Subject: Re: [PATCH 1/1] PCI : Refactoring error log prints for better
 readability
Message-ID: <4ec3b167-9324-41d3-a086-74ca001b9042@ti.com>
References: <CGME20240517105941epcas5p3e8dbb97f19c9553bf9942ad146124806@epcas5p3.samsung.com>
 <20240517105923.2406246-1-onkarnath.1@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240517105923.2406246-1-onkarnath.1@samsung.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Fri, May 17, 2024 at 04:29:23PM +0530, Onkarnarth wrote:
> From: Onkarnath <onkarnath.1@samsung.com>

I think that the $subject should be similar to:
https://patchwork.kernel.org/comment/25712288/
rather than the generic "refactoring error log".

> 
> As %pe is already introduced, it's better to use it in place of (%ld) or (%d) for
> printing error in logs. It will enhance readability of logs.
> 
> Error print style is more consistent now.
> 
> Co-developed-by: Maninder Singh <maninder1.s@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
> ---
> Suggested by Bjorn Helgaas in below discussion
> https://patchwork.kernel.org/comment/25712288/

Since you have indicated that Bjorn has suggested it, shouldn't there
also be a "Suggested-by tag" in the commit message?

> 
>  drivers/pci/bus.c                             |   2 +-
>  drivers/pci/controller/dwc/pci-dra7xx.c       |   2 +-
>  drivers/pci/controller/dwc/pci-meson.c        |  16 +--
>  drivers/pci/controller/dwc/pcie-armada8k.c    |   4 +-
>  drivers/pci/controller/dwc/pcie-histb.c       |   6 +-
>  drivers/pci/controller/dwc/pcie-intel-gw.c    |  10 +-
>  drivers/pci/controller/dwc/pcie-keembay.c     |   2 +-
>  drivers/pci/controller/dwc/pcie-kirin.c       |   6 +-
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     |  18 +--
>  drivers/pci/controller/dwc/pcie-qcom.c        |  18 +--
>  drivers/pci/controller/dwc/pcie-tegra194.c    | 132 +++++++++---------
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c |   2 +-
>  drivers/pci/controller/pci-aardvark.c         |   6 +-
>  drivers/pci/controller/pci-ftpci100.c         |   2 +-
>  drivers/pci/controller/pci-tegra.c            |  86 ++++++------
>  drivers/pci/controller/pci-xgene.c            |   4 +-
>  drivers/pci/controller/pcie-microchip-host.c  |   2 +-
>  drivers/pci/controller/pcie-rcar-host.c       |  14 +-
>  drivers/pci/controller/pcie-rockchip.c        |  34 ++---
>  drivers/pci/controller/vmd.c                  |   2 +-
>  drivers/pci/doe.c                             |   4 +-
>  drivers/pci/endpoint/functions/pci-epf-mhi.c  |   8 +-
>  drivers/pci/endpoint/functions/pci-epf-ntb.c  |   2 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c |   4 +-
>  drivers/pci/endpoint/functions/pci-epf-vntb.c |   2 +-
>  drivers/pci/endpoint/pci-ep-cfs.c             |  12 +-
>  drivers/pci/endpoint/pci-epf-core.c           |  16 +--
>  drivers/pci/hotplug/acpiphp_core.c            |   2 +-
>  drivers/pci/hotplug/pciehp_core.c             |   8 +-
>  drivers/pci/hotplug/shpchp_core.c             |   4 +-
>  drivers/pci/of.c                              |   6 +-
>  drivers/pci/pci-driver.c                      |   4 +-
>  drivers/pci/pcie/dpc.c                        |   4 +-
>  drivers/pci/quirks.c                          |   2 +-
>  drivers/pci/setup-bus.c                       |   2 +-
>  drivers/pci/slot.c                            |   4 +-
>  drivers/pci/vgaarb.c                          |   2 +-
>  37 files changed, 227 insertions(+), 227 deletions(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 826b5016a101..dbc16cf5a246 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -351,7 +351,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>  	dev->match_driver = !dn || of_device_is_available(dn);
>  	retval = device_attach(&dev->dev);
>  	if (retval < 0 && retval != -EPROBE_DEFER)
> -		pci_warn(dev, "device attach failed (%d)\n", retval);
> +		pci_warn(dev, "device attach failed: %pe\n", ERR_PTR(retval));

Is there a reason behind dropping the parantheses?

>  
>  	pci_dev_assign_added(dev, true);
>  }
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index d2d17d37d3e0..79b6cc7f0287 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -801,7 +801,7 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
>  	reset = devm_gpiod_get_optional(dev, NULL, GPIOD_OUT_HIGH);
>  	if (IS_ERR(reset)) {
>  		ret = PTR_ERR(reset);
> -		dev_err(&pdev->dev, "gpio request failed, ret %d\n", ret);
> +		dev_err(&pdev->dev, "gpio request failed: %pe\n", ERR_PTR(ret));

Similar question as above regarding converting "failed, ret" to
"failed:". Is this a new convention that is expected to be followed,
where all errors are supposed to have "failed: %pe", rather than custom
statements? Please let me know if this has already been discussed
elsewhere.

[...]

Regards,
Siddharth.

