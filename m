Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2723A43538F
	for <lists+linux-pci@lfdr.de>; Wed, 20 Oct 2021 21:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhJTTPK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Oct 2021 15:15:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231455AbhJTTPJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Oct 2021 15:15:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED3D6611B0;
        Wed, 20 Oct 2021 19:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634757175;
        bh=HUeYEOubLIJowqLZcwwGkc9BEjtPIPaC7kQ8jsRtATU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rmCjhlUA1OEDWQMapi13jzwRQnrM10QmCEHZvW7PQ9Sfhu15HDHr0xBKHkOFIIzHn
         cdnxHLtWh79AlLgrey6P1h9GaysjiQSpdKyZgZnBvBsctbn/sNbwcpE1UqYEqhSeOP
         HOhv52io1y6DiD1hGFdq6et4Ogsv+0hOpzVUcaSkJicg3lPbjzmizPAg4Z1rxr1uIr
         HoUbTiTLYraopbPbKrb10f+mZgIY5ZIIeCPkGI+rGTQds7WivC/7TczHZbvECrqRlu
         0iSTEFxMZEKEMGY74ax6qOrSaLsDalom12y9T4wTolRvFNL9AtlvDXv16AbruT9HlG
         ipLe1wDpHNPTQ==
Date:   Wed, 20 Oct 2021 14:12:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Li Chen <lchen@ambarella.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: cadence: add missing return for plat probe
Message-ID: <20211020191253.GA2631311@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR19MB4024632D33EB6FACF54D3CCAA0BE9@CH2PR19MB4024.namprd19.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 20, 2021 at 11:17:51AM +0000, Li Chen wrote:
> Otherwise, the code will continue to error handle,
> which is not excepted.

In subject and commit log:

  PCI: cadence: Add missing return in cdns_plat_pcie_probe()

  When cdns_plat_pcie_probe() succeeds, return success instead of
  falling into the error handling code.

We should have a Fixes: tag here to show where this bug was
introduced.  Look at previous git history to see the format.  Maybe
also a stable tag so this will get backported to stable kernels.

Interesting that nobody noticed such an obvious bug until now.

> Signed-off-by: Li Chen <lchen@ambarella.com>
> Signed-off-by: Xuliang Zhang <xlzhanga@ambarella.com>

Since the patch was sent by Li, that signoff should be last, per
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v5.14#n365

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks for the patch!

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
