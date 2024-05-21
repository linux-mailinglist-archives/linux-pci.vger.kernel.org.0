Return-Path: <linux-pci+bounces-7701-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 471748CA815
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 08:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B6A42829FD
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 06:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3C445BE4;
	Tue, 21 May 2024 06:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NAJbt7a5"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E718941C63;
	Tue, 21 May 2024 06:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716273843; cv=none; b=hByU3+wNTgnJJxYBykBjO7OJM/OcsiThj1fd7HKyiWDDQjvvrh6Z/l1W5dfAPfOy7jTpuh61pXQe9yQgxVe4vbND4L3fllKVGeBpkzgk47rbEGnfU8/V/eWYp2mJ3VW9s2Pg5aLc8JxsewXktdFElm6qRI3l5d7kNgDgfIvkm+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716273843; c=relaxed/simple;
	bh=eck8LkiBmFIk3D6cjAJWmIkNyfD/MCEdYcx9mI2Wz8U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKDve+HkMDHCR1OoFAkwilNEbNfxuKZsxzmqXl4T+BTpQ04CfxFVcTyT1j4O1lfPtI2gyobv61pp3hTDYjLdwJWtyiSlF7kuiG0+D1yz5KOIaHJfuZV9yuSIeJHiGJU2UU2yWd8IIURliE6y422Ngly8gd0fKVogzKttW/79Kdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NAJbt7a5; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44L6gmm0011241;
	Tue, 21 May 2024 01:42:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716273768;
	bh=+ZfOONRU6juW9FS/6TxFdABLBWxqz7rqnKx7hWQStMk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=NAJbt7a5DoTR+zca5xHgtqfKuYpVEVUoncFcDAa9rnhd0cNDBfAjwlhHiy9tha2Vb
	 g+Gb2EgkITFo0mgOhhaULzAGqx7RAEEAtxvOqpq8731MIkkNr26sB2h4ivC48fprL6
	 wDMkTrcTcJlygDX4vsPSR2HaVHGcYvfXEn8aKLKI=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44L6gmJG015907
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 May 2024 01:42:48 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 21
 May 2024 01:42:48 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 21 May 2024 01:42:48 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44L6gldU029813;
	Tue, 21 May 2024 01:42:48 -0500
Date: Tue, 21 May 2024 12:12:46 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Onkarnarth <onkarnath.1@samsung.com>
CC: <bhelgaas@google.com>, <helgaas@kernel.org>, <vigneshr@ti.com>,
        <s-vadapalli@ti.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <yue.wang@Amlogic.com>, <neil.armstrong@linaro.org>,
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
Subject: Re: [PATCH v2 1/1] PCI : Refactoring error log prints for better
 readability
Message-ID: <2227b0ed-a57f-4bca-8f3e-721bc2e2055a@ti.com>
References: <CGME20240521061553epcas5p1c7db70b37a70f599face675bc4dedda9@epcas5p1.samsung.com>
 <20240521061528.3559751-1-onkarnath.1@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240521061528.3559751-1-onkarnath.1@samsung.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Tue, May 21, 2024 at 11:45:28AM +0530, Onkarnarth wrote:
> From: Onkarnath <onkarnath.1@samsung.com>

nitpick: In $subject:
s/Refactoring/Refactor
to follow the convention of using imperative mood.

> 
> As %pe is already introduced, it's better to use it in place of (%ld) or
> (%d) for printing error in logs. It will enhance readability of logs.
> 
> Error print style is more consistent now.
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Co-developed-by: Maninder Singh <maninder1.s@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> Signed-off-by: Onkarnath <onkarnath.1@samsung.com>

Thank you for the patch. LGTM.

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

> ---
> Suggested by Bjorn Helgaas in below discussion
> https://patchwork.kernel.org/comment/25712288/
> 
> v1 -> v2: Added suggested by tag
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

[...]

Regards,
Siddharth.

