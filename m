Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446BE1EF105
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jun 2020 07:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgFEF6M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jun 2020 01:58:12 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12200 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgFEF6M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jun 2020 01:58:12 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed9dee80000>; Thu, 04 Jun 2020 22:58:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 04 Jun 2020 22:58:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 04 Jun 2020 22:58:12 -0700
Received: from [10.26.75.201] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Jun
 2020 05:58:06 +0000
Subject: Re: [PATCH] PCI: tegra: handle failure case of pm_runtime_get_sync
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <emamd001@umn.edu>, <wu000273@umn.edu>, <kjlu@umn.edu>,
        <smccaman@umn.edu>
References: <20200605031239.6638-1-navid.emamdoost@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <e595b755-ea15-48d6-1f2a-c485f0f365e2@nvidia.com>
Date:   Fri, 5 Jun 2020 06:58:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605031239.6638-1-navid.emamdoost@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591336680; bh=Zxo+XIWDWIDysHCmFEE3tbCGmetg7DRYJxfLrViJhUQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=hveDJFAKrA7r8IOeIGe4ehhOK2mbZtfQY641B3zD5t7OouvmjkCq9exxG+v2xrrT7
         pTP+SBvzrj5vVuPX00upHU8RzekW+rviB/rYJaO/bI/P1q0wjMe0Vtoyv+iag0bsxc
         HtKVbmkZ8ioQqAvlffEDhNbODfHGxZuzA0c610hcbnMvQpD1FICsohSok5n9kxuxLg
         VYOBrrSqSbJ4aAlr8Qwwrg8+6CMv42XU+xO8vvEpC7b6iJXLDhCelobFJXb+7EhvBa
         tEcTa3i6ve4/trfzakTWaI+uh+39KZvXJihLNMNWjil057nhJOWg0IJemosVAh0LSM
         iFZhI2b9LKNtA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 05/06/2020 04:12, Navid Emamdoost wrote:
> Calling pm_runtime_get_sync increments the counter even in case of
> failure, causing incorrect ref count. Call pm_runtime_put if
> pm_runtime_get_sync fails.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 3e64ba6a36a8..3d4b448fd8df 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2712,6 +2712,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>  	err = pm_runtime_get_sync(pcie->dev);
>  	if (err < 0) {
>  		dev_err(dev, "fail to enable pcie controller: %d\n", err);
> +		pm_runtime_put_sync(pcie->dev);
>  		goto teardown_msi;
>  	}

Same thing for this patch, there is already a put in the error path and
so it is not necessary to add the put call here. Just update the goto
label.

Jon

-- 
nvpublic
