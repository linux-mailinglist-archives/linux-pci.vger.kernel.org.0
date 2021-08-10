Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C2B3E5E51
	for <lists+linux-pci@lfdr.de>; Tue, 10 Aug 2021 16:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241847AbhHJOr7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Aug 2021 10:47:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241835AbhHJOr7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Aug 2021 10:47:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 142F660F25;
        Tue, 10 Aug 2021 14:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628606857;
        bh=w2Dz/2K8UpCBs+YfXsHYqixApJ1UabAsDWwqZ5GOGyI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=neYehoZJC+E+pom8FC2YzXkQeIOrdOO7f+qVKzLZmEYJMjBxZ3I6HshcemhSxjCX0
         cn7jNIFb9KFfBgpbsyaoahvkXD5tRe//TyLYS3fduF7Kae1TVR7/Nn0qzkOcT1bv5j
         z7n0j9PQCAEwNrO9ey7gKp0xXVZG77mda8bMx2GNnPJ4W+uEn+npiELJdIw1DAtZHA
         sZfEVEYLU38IupNn9xFdjwo0AJCM0s2F2GFUixswhe0bbNzM2RqtSD4RsU2GjeDsyC
         rJ51mWmnVpa8FE1ERvvXDheCmhObDznChfl1PE+1Vbq3+kdPtRYjZ6NWH019pLN2TK
         dUHAF1oUhnWHw==
Date:   Tue, 10 Aug 2021 09:47:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     George Cherian <george.cherian@marvell.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH] PCI: Add ACS quirk for Cavium multi-function devices
Message-ID: <20210810144735.GA2264304@bjorn-Precision-5520>
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

Is there a plan to add ACS capabilities to future devices, or is
Cavium just resigned to forever adding and backporting quirks?

>  	/* APM X-Gene */
>  	{ PCI_VENDOR_ID_AMCC, 0xE004, pci_quirk_xgene_acs },
>  	/* Ampere Computing */
> -- 
> 2.25.1
> 
