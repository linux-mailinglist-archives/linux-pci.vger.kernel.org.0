Return-Path: <linux-pci+bounces-12287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50802960CD7
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 16:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED42A1F23EA0
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 14:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324EC1C1725;
	Tue, 27 Aug 2024 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cCa9/KYC"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B4A19CCE7;
	Tue, 27 Aug 2024 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767285; cv=none; b=T2CRHyrD9j34xiCwbOMvtrxktGeFRJNcskZ2rOKMArTOTNaUT4hu9Rl9lUHIOxkgl1UqfJ5YarNiWRAFlkdG1x1IWJdyk3T/tZ7TpUoFjELjfTR/gBFPnJwm6XtynTJ7OEhrKn69xofo7oQ5PjdX3YK64vVbJCwnzpb2qHD1nmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767285; c=relaxed/simple;
	bh=JTFS2PVVJIJrI9zvTKz1C0Bfs/Ut4i1CDsZqM/4JB7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FRnjZ0TIKmRrj9WJ0j8mnr9S4pawtn15MJMoWVcQVR8U2P5e21A96cTzjHqUx2h2Z+7k555SolbnY/ddRVswLWet/B3FhwSysrpL96bhyZA00Pdu3SAJ5YNyKN62tK6Zcj0xJNyP9b3jUXUNYvpYYUkHsUHvuHklnZcyIAeWRYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cCa9/KYC; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47RE0puQ039507;
	Tue, 27 Aug 2024 09:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724767251;
	bh=9ZEIfkkxyG9bAFYtC9wPW17DasVSTlWqXzVbnjgOKhY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=cCa9/KYCU5ZxksszyLamCdcrMtXjwHslW0JHn0OkEWEzAAH47H9zHJ6BNOoL1RwtE
	 32aI6DvEXc2o6BCqhIHIod4XbQr4lvouII8ZAtrVI8010hWpZO5RoAiVU/9sv0ry5M
	 pVnFx2Gpl5nh2FA2aAfasRNodzooMa08NRmmp488=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47RE0p1f108182
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Aug 2024 09:00:51 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Aug 2024 09:00:51 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 Aug 2024 09:00:51 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47RE0kO8115169;
	Tue, 27 Aug 2024 09:00:47 -0500
Message-ID: <6843a1b4-e331-435d-9cc7-9b457955d3cd@ti.com>
Date: Tue, 27 Aug 2024 19:30:45 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: dra7xx: Fix error handling when IRQ request
 fails in probe
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <vigneshr@ti.com>, <kishon@kernel.org>,
        <manivannan.sadhasivam@linaro.org>, <j-keerthy@ti.com>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <stable@vger.kernel.org>, <srk@ti.com>
References: <20240827122422.985547-1-s-vadapalli@ti.com>
 <20240827122422.985547-3-s-vadapalli@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240827122422.985547-3-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 8/27/2024 5:54 PM, Siddharth Vadapalli wrote:
> Commit d4c7d1a089d6 ("PCI: dwc: dra7xx: Push request_irq() call to the
> bottom of probe") moved the IRQ request for "dra7xx-pcie-main" towards
> the end of dra7xx_pcie_probe(). However, the error handling does not take
> into account the initialization performed by either dra7xx_add_pcie_port()
> or dra7xx_add_pcie_ep(), depending on the mode of operation. Fix the error
> handling to address this.
>
> Fixes: d4c7d1a089d6 ("PCI: dwc: dra7xx: Push request_irq() call to the bottom of probe")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>   drivers/pci/controller/dwc/pci-dra7xx.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index 20fb50741f3d..5c62e1a3ba52 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -854,11 +854,17 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
>   					"dra7xx-pcie-main", dra7xx);
>   	if (ret) {
>   		dev_err(dev, "failed to request irq\n");
> -		goto err_gpio;
> +		goto err_deinit;
>   	}
>   
>   	return 0;
>   
> +err_deinit:
> +	if (dra7xx->mode == DW_PCIE_RC_TYPE)
> +		dw_pcie_host_deinit(&dra7xx->pci->pp);
> +	else
> +		dw_pcie_ep_deinit(&dra7xx->pci->ep);


dw_pcie_ep_deinit may not be available in previous kernels

Otherwise
Tested-by: Udit Kumar <u-kumar1@ti.com>

> +
>   err_gpio:
>   err_get_sync:
>   	pm_runtime_put(dev);

