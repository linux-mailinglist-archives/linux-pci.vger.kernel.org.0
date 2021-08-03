Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8192B3DF89A
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 01:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbhHCXoC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 19:44:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231651AbhHCXoC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Aug 2021 19:44:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E8D661050;
        Tue,  3 Aug 2021 23:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628034230;
        bh=Qb7Rl5sT8Cpn/3OI3WdXxenXNQaZtsNhc5PZYQ5I6So=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sBD9WALtt+KuOJQP1ABGJDlV91ylu8p5qdRYvIcinu4n/iQEQa6DF1Y/pJJKGcSHA
         FSfuLXslIAD+Yv/kQZdc9g3p/wRIe+5lzjSJypunWGSaj7vTBx/YPDdAMj3Hc2HdIM
         sKiAUz4qJDoO25JrqrdmeGgm/P1z3G0cMzQ6iZ+GwhbabhbJ6sJUZAIVBghiYe920U
         TnpWWFgzWr+3MFV1yMsILmmU/QBShU1m+e1IWR65r1oYb/WKF4Yxpt/cyLRNGjTM/r
         70HuKQpjEw+HvosIAT8xdzgmwKEid0g3Upd7XNbGsXJwB2EYrx1oY9LtjFCDL2OJZH
         o59pMBWJ4vcKg==
Date:   Tue, 3 Aug 2021 18:43:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-pci@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Roman Bacik <roman.bacik@broadcom.com>,
        Bharat Gooty <bharat.gooty@broadcom.com>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 1/2] PCI: of: Don't fail devm_pci_alloc_host_bridge() on
 missing 'ranges'
Message-ID: <20210803234349.GA1587308@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210803215656.3803204-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 03, 2021 at 03:56:55PM -0600, Rob Herring wrote:
> Commit 669cbc708122 ("PCI: Move DT resource setup into
> devm_pci_alloc_host_bridge()") made devm_pci_alloc_host_bridge() fail on
> any DT resource parsing errors, but Broadcom iProc uses
> devm_pci_alloc_host_bridge() on BCMA bus devices that don't have DT
> resources. In particular, there is no 'ranges' property. Fix iProc by
> making 'ranges' optional.
> 
> If 'ranges' is required by a platform, there's going to be more errors
> latter on if it is missing.

s/latter/later/

> Fixes: 669cbc708122 ("PCI: Move DT resource setup into devm_pci_alloc_host_bridge()")
> Reported-by: Rafał Miłecki <zajec5@gmail.com>
> Cc: Srinath Mannam <srinath.mannam@broadcom.com>
> Cc: Roman Bacik <roman.bacik@broadcom.com>
> Cc: Bharat Gooty <bharat.gooty@broadcom.com>
> Cc: Abhishek Shah <abhishek.shah@broadcom.com>
> Cc: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
> Cc: Ray Jui <ray.jui@broadcom.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume Lorenzo will merge this along with the iproc change.

> ---
>  drivers/pci/of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index a143b02b2dcd..d84381ce82b5 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -310,7 +310,7 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
>  	/* Check for ranges property */
>  	err = of_pci_range_parser_init(&parser, dev_node);
>  	if (err)
> -		goto failed;
> +		return 0;
>  
>  	dev_dbg(dev, "Parsing ranges property...\n");
>  	for_each_of_pci_range(&parser, &range) {
> -- 
> 2.30.2
> 
