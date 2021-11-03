Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0544448A4
	for <lists+linux-pci@lfdr.de>; Wed,  3 Nov 2021 19:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhKCSx4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 14:53:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229703AbhKCSx4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Nov 2021 14:53:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C7C260E78;
        Wed,  3 Nov 2021 18:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635965479;
        bh=5Wyfo41wfc8+7QQjlCGba5N4K/YeBUWJKaztSd/LcQ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sTAO2WVbSUG7wvdbqUAfq9RwZjyml8/g7aBok7IYFqxDjwFGYuCwbf0JjoUln/0/M
         3KHKKkrm0YaNNM3qYT1cc4495oyUKpjGCwbOFINBKpl0tdTr8lRN0kkHDUUc08ZzHb
         Z4bX+Qpy3eDedgxmfvhfIT1ryjoddF1ce6/EDJqZhv54yASiO68lXMYDsPG0aHFah9
         mkaHk1bWC3sYlVwOHeBYUyftEVl+DyE2ckmfb2tqSOcZsa9RuRcINiu8G0iPEik/OC
         LO60yM64Pgd4WP+xBzXyrac73W7QVvOErBBfDhc5z4wADMtDGmzur9KHa8bgmoItZM
         LncyQuyykGlUA==
Date:   Wed, 3 Nov 2021 13:51:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Li Chen <lchen@ambarella.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: cadence: Add missing return in
 cdns_plat_pcie_probe()
Message-ID: <20211103185117.GA707490@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR19MB40271B93057D949310F0B0EDA0BF9@DM6PR19MB4027.namprd19.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 21, 2021 at 02:50:19AM +0000, Li Chen wrote:
> When cdns_plat_pcie_probe() succeeds, return success instead of
> falling into the error handling code.
> 
> Signed-off-by: Xuliang Zhang <xlzhanga@ambarella.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Fixes: bd22885aa188 ("PCI: cadence: Refactor driver to use as a core library")
> Cc: stable@vger.kernel.org
> Signed-off-by: Li Chen <lchen@ambarella.com>

This would ordinarily go via Lorenzo's tree, but I picked it up so it
would make v5.16.

> ---
>  drivers/pci/controller/cadence/pcie-cadence-plat.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> index 5fee0f89ab59..a224afadbcc0 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> @@ -127,6 +127,8 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
>  			goto err_init;
>  	}
>  
> +	return 0;
> +
>   err_init:
>   err_get_sync:
>  	pm_runtime_put_sync(dev);
> -- 
> 2.33.0
> 
> **********************************************************************
> This email and attachments contain Ambarella Proprietary and/or Confidential Information and is intended solely for the use of the individual(s) to whom it is addressed. Any unauthorized review, use, disclosure, distribute, copy, or print is prohibited. If you are not an intended recipient, please contact the sender by reply email and destroy all copies of the original message. Thank you.
