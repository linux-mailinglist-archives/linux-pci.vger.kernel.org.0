Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 088A018A90D
	for <lists+linux-pci@lfdr.de>; Thu, 19 Mar 2020 00:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgCRXNw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Mar 2020 19:13:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgCRXNv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Mar 2020 19:13:51 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD2C92076C;
        Wed, 18 Mar 2020 23:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584573231;
        bh=oFy9zaUxFZZJmaRDFLzCKtAEprfj3oqdBpvxcG2rk8k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DzpZj5+8msW57avSvGgNIEAwIntQcyPVC0z0zfdOwSqCS4B8BIynnP/AjLzlVp87e
         WmAel2zgAp0zu8KDdv9CPTxak6CuSCSIAHsuESHXVqryOJB7C5lUAUbPreMfNkpWHE
         HrHEks/wwnAvs2pS0qX4q58qMpUYAEPdtDIps/eY=
Date:   Wed, 18 Mar 2020 18:13:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andrew Maier <andrew.maier@eideticom.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        logang@deltatee.com
Subject: Re: [PATCH v2] PCI/P2PDMA: Add the remaining Intel Sky Lake-E root
 ports to the whitelist
Message-ID: <20200318231349.GA3278@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207221219.4309-1-andrew.maier@eideticom.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 07, 2020 at 03:12:19PM -0700, Andrew Maier wrote:
> Add the three remaining Intel Sky Lake-E host root ports to the
> whitelist of p2pdma.
> 
> P2P has been tested and is working on this system.
> 
> Signed-off-by: Andrew Maier <andrew.maier@eideticom.com>

Applied with Logan's reviewed-by to pci/p2pdma for v5.7, thanks!

> ---
> Resending this as I rebased it onto the latest patches.
>  drivers/pci/p2pdma.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 9a8a38384121..b73b10bce0df 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -291,6 +291,9 @@ static const struct pci_p2pdma_whitelist_entry {
>  	{PCI_VENDOR_ID_INTEL,	0x2f01, REQ_SAME_HOST_BRIDGE},
>  	/* Intel SkyLake-E */
>  	{PCI_VENDOR_ID_INTEL,	0x2030, 0},
> +	{PCI_VENDOR_ID_INTEL,	0x2031, 0},
> +	{PCI_VENDOR_ID_INTEL,	0x2032, 0},
> +	{PCI_VENDOR_ID_INTEL,	0x2033, 0},
>  	{PCI_VENDOR_ID_INTEL,	0x2020, 0},
>  	{}
>  };
> -- 
> 2.17.1
> 
