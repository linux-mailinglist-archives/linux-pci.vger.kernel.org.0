Return-Path: <linux-pci+bounces-17921-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCEC9E9227
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 12:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F1D16400F
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 11:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AE221B195;
	Mon,  9 Dec 2024 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aKOw0c2d"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0C421B194;
	Mon,  9 Dec 2024 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743648; cv=none; b=UkOO7PYz8qIhzPzpVtfqqbvB48EkHeTf45S5ysPU1H4auzkI3bzw5z2SVEti50T37M3QNz5fffHrlukQnJ5fZcvMf3AxbAtxWIomXBEBkx1CbDlbMKBUF3kbiwkMx6jNKY6KngQErWk1UCrxGXCno35o05amvzpFmmB9mJ99k24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743648; c=relaxed/simple;
	bh=q0uuMWNFnloLqki4yTKHY1BeBebOBBJeUsKXYz5dpJc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubjXq7MYg+Mhx8OYnzOaaG/VRC+GJiIlPZTNEVdV32r/9IRy4MTF+J9YWH3IyLiXuKOYyP10GbYwrxIIrlITuDv4MPd7hTnUJCwaIBlwzWW7OV+JGHh8e8+nxxu6QfV138pcaWZLeiAhJ6xIrhaUtnbgCTbPUNppyth2TVWS1bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aKOw0c2d; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B9BQxFv2461834
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 05:26:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733743619;
	bh=/9PmsohwRCXaZ4pTIrE5Tef+6KEfwnYxmCnoO4uaQp0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=aKOw0c2dZPDFVOgfLTAeiyDhSv+9n4zCs/K3iLibr1KUIq7tWL5bGk1Ix712B3m92
	 GxE3DANvLsljIADlimvMPFFih5TdzkUjkdsCcstqyy3n2sjxX0m7c2ubEWQoZB9tJT
	 vDlxr+SJwzaehudaxZ9APPmp05LoRKKHvfQD0Al0=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B9BQxHr108751
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Dec 2024 05:26:59 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Dec 2024 05:26:59 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Dec 2024 05:26:58 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B9BQvZD085644;
	Mon, 9 Dec 2024 05:26:58 -0600
Date: Mon, 9 Dec 2024 16:56:57 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Thomas Richard <thomas.richard@bootlin.com>
CC: <vigneshr@ti.com>, <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <theo.lebrun@bootlin.com>,
        <thomas.petazzoni@bootlin.com>, <kwilczynski@kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <gregory.clement@bootlin.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH] PCI: j721e: In j721e_pcie_suspend_noirq() check
 reset_gpio before to use it
Message-ID: <laghliul4hk7lqzkt6i4ddnvfhyq7q5esgdzx24h5vaougtner@5wcboaak2cxy>
References: <20241209112321.65320-1-thomas.richard@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241209112321.65320-1-thomas.richard@bootlin.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Mon, Dec 09, 2024 at 12:23:21PM +0100, Thomas Richard wrote:
> The reset_gpio is optional, so in j721e_pcie_suspend_noirq() check if it is
> not NULL before to use it.
> 
> Fixes: c538d40f365b ("PCI: j721e: Add suspend and resume support")
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

> ---
>  drivers/pci/controller/cadence/pci-j721e.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index 0341d51d6aed..5bc14dd70811 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -644,7 +644,9 @@ static int j721e_pcie_suspend_noirq(struct device *dev)
>  	struct j721e_pcie *pcie = dev_get_drvdata(dev);
>  
>  	if (pcie->mode == PCI_MODE_RC) {
> -		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> +		if (pcie->reset_gpio)
> +			gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> +
>  		clk_disable_unprepare(pcie->refclk);
>  	}
>  

Regards,
Siddharth.

