Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E373F35EB
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 23:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240262AbhHTVPE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 17:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239997AbhHTVPB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Aug 2021 17:15:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6D79610CC;
        Fri, 20 Aug 2021 21:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629494062;
        bh=G6ak4MPoXfP+D+22vDf1POlItZNsAjtB8G/diCkHPtc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ix07Xbqpe7IECD5DacDTXHLh53szEimduCgkTfoa+U4HfSfAmqIBGGdxaiAAZx0PY
         HzBSZoZpWWmDdGEE0Yb7TksVYqCC1mbSekhOrgZ1Y5O4A3k3e1JATd+yW6po3h2iUj
         PN+Xa5uFthnkbiTvbgNJWj5wJdO3jeqhBM0CVRfY3cRSOCSnsVLdpEtp/wAqegvebG
         RSKpcnrIBjcgGjwA1Hm0+RMbrIteydLTY2109V0bD8QnLIYqICDxepNxZReNvuuMCu
         LQv+mmRJ2JodNBr1OwxIe0T+xAI6zrIQPjyt7MZp1iplxRhTOJ0aAe7V8IT3AcyT28
         g8ejx97j+royg==
Date:   Fri, 20 Aug 2021 16:14:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     George Cherian <george.cherian@marvell.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH] PCI: Add ACS quirk for Cavium multi-function devices
Message-ID: <20210820211420.GA3359633@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810122425.1115156-1-george.cherian@marvell.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 10, 2021 at 05:54:25PM +0530, George Cherian wrote:
> Some Cavium endpoints are implemented as multi-function devices
> without ACS capability, but they actually don't support peer-to-peer
> transactions.
> 
> Add ACS quirks to declare DMA isolation.
> 
> Apply te quirk for following devices
> 1. BGX device found on Octeon-TX (8xxx)
> 2. CGX device found on Octeon-TX2 (9xxx)
> 3. RPM device found on Octeon-TX3 (10xxx)
> 
> Signed-off-by: George Cherian <george.cherian@marvell.com>

Applied to pci/virtualization for v5.15, thanks!

> ---
>  drivers/pci/quirks.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 6d74386eadc2..076932018494 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4840,6 +4840,10 @@ static const struct pci_dev_acs_enabled {
>  	{ 0x10df, 0x720, pci_quirk_mf_endpoint_acs }, /* Emulex Skyhawk-R */
>  	/* Cavium ThunderX */
>  	{ PCI_VENDOR_ID_CAVIUM, PCI_ANY_ID, pci_quirk_cavium_acs },
> +	/* Cavium multi-function devices */
> +	{ PCI_VENDOR_ID_CAVIUM, 0xA026, pci_quirk_mf_endpoint_acs },
> +	{ PCI_VENDOR_ID_CAVIUM, 0xA059, pci_quirk_mf_endpoint_acs },
> +	{ PCI_VENDOR_ID_CAVIUM, 0xA060, pci_quirk_mf_endpoint_acs },
>  	/* APM X-Gene */
>  	{ PCI_VENDOR_ID_AMCC, 0xE004, pci_quirk_xgene_acs },
>  	/* Ampere Computing */
> -- 
> 2.25.1
> 
