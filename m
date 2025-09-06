Return-Path: <linux-pci+bounces-35586-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0D7B46811
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 03:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F055C6122
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 01:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E641519A6;
	Sat,  6 Sep 2025 01:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aMPgdkMy"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547051CD2C;
	Sat,  6 Sep 2025 01:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757123284; cv=none; b=QXQR9YcDKz4GFwtssUuZzBZyTsfwc7+o57YL4rZBXwNeoNp3++q+ZovffVffsIOy6WibAZx4lCASpa1ZkcBnrYuTVMHgBNAuKDShVDGzuOHXn4zrgNZ3dvjR/iWsMFPmAyRDSwqbXACCh0JP4tiKxd5IEP0G4tOMUibgWwv3x/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757123284; c=relaxed/simple;
	bh=A2D2aSftdcMZeG+xPlUYbYdg82HvTTXUJvhglE5jKag=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q07W/N2mnofBl8MlopJ4QnQpWZS7MeMn/tCCagUGNBgBlnqMDuIwNa2WY45zR2Tqm7UQEkOfuVVQAG1DPH/VwG9QHaaJCr6UHwzeoqLp/49MPu99aW4oluiA1URKueuTTHha/Dxs8qLd83vmZRSF37MAjdXMlb6rjFuWzhNWjXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aMPgdkMy; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5861lplt3440581;
	Fri, 5 Sep 2025 20:47:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757123271;
	bh=L7F0n7D432kI/8TDM2zzfMQeAXcSFxDGIcCb60S29Ag=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=aMPgdkMyU0tQsAXg6Z67kzB+8r9scFyKT3o5TgOgy+IJrss8I7NQAhNyKI/MWV8vt
	 licxwf4EraFKp2U2gpVfNpe7cAhm/8w4RWzyZsTVqHYGHC1AWqA61xaWzIXMtAef78
	 SPKmKULN0QmAOJ2JKPUMkCzqH6Wj24BMCBoDRzSk=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5861lpko2051501
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 5 Sep 2025 20:47:51 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 20:47:51 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 20:47:51 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5861lnUb1300100;
	Fri, 5 Sep 2025 20:47:50 -0500
Date: Sat, 6 Sep 2025 07:17:49 +0530
From: s-vadapalli <s-vadapalli@ti.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
CC: <vigneshr@ti.com>, <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <mani@kernel.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: j721e: Fix incorrect error message in probe
Message-ID: <22e63c06-ec7f-4afe-8fc2-f90d49004ce9@ti.com>
References: <20250905211436.3048282-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250905211436.3048282-1-alok.a.tiwari@oracle.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Fri, Sep 05, 2025 at 02:14:34PM -0700, Alok Tiwari wrote:
> The probe function printed "pm_runtime_get_sync failed" when
> j721e_pcie_ctrl_init() returned an error. This is misleading since
> the failure was not from pm_runtime but from the controller init
> routine. Update the error message to correctly reflect the source.
> 
> No functional changes.
> 
> Fixes: f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
> Not sure if a Fixes tag is required here
> ---
>  drivers/pci/controller/cadence/pci-j721e.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index 6c93f39d0288..5e445a7bda33 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -549,7 +549,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  
>  	ret = j721e_pcie_ctrl_init(pcie);
>  	if (ret < 0) {
> -		dev_err_probe(dev, ret, "pm_runtime_get_sync failed\n");
> +		dev_err_probe(dev, ret, "j721e_pcie_ctrl_init failed\n");
>  		goto err_get_sync;
>  	}

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.

