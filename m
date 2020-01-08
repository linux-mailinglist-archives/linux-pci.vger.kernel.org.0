Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D306133E28
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2020 10:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbgAHJPi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 04:15:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36254 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbgAHJPi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jan 2020 04:15:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bulq+716cexBfsYppdGtDHL94WJyzgWNk4KwK59xVNo=; b=tQc70mbO6zapIeg3SCrwEc3Bl
        CTIgfUZhUD2FtQdZJS0eZvJSs/4aGXFOzeMHw/T07WkMnYYybGs9NOLOmQF2kmJKISKIeY/zrcAtw
        cYQmqqxb1KzyS0FfIyudYlejsX2U+cl0gpLqUeXbpagDtnWh92GN2BRNC+EUVZogOpWGOi4+TFGnG
        bzt96wCK3kfKQCoRkfCmK3+Hv3A/SSlEnKo5rye7oPOf0l9W9PGWanGloiKgwHioQqDgdP3cU/qn/
        2lUc9bYkjff+jQPQIvWmiO2H6CrOcka42mDSnTGjo6WuCtiBogWjvD45aQ0mKx6/ElW8m4cYk6h83
        72GMS+FUA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ip7R7-0001Ev-6f; Wed, 08 Jan 2020 09:15:33 +0000
Date:   Wed, 8 Jan 2020 01:15:33 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Sushma Kalakota <sushmax.kalakota@intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: vmd: Add two VMD Device IDs
Message-ID: <20200108091533.GA31095@infradead.org>
References: <20200107220806.6807-1-sushmax.kalakota@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107220806.6807-1-sushmax.kalakota@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 07, 2020 at 03:08:06PM -0700, Sushma Kalakota wrote:
> Add new VMD device IDs that require the bus restriction mode.
> 
> Signed-off-by: Sushma Kalakota <sushmax.kalakota@intel.com>
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/controller/vmd.c | 4 ++++
>  include/linux/pci_ids.h      | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 212842263f55..9433bd387fdd 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -868,6 +868,10 @@ static const struct pci_device_id vmd_ids[] = {
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
>  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
>  				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_467F),
> +		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_4C3D),
> +		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
>  		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
>  	{0,}
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 2302d133af6f..aac007c60f87 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2957,6 +2957,8 @@
>  #define PCI_DEVICE_ID_INTEL_SBRIDGE_BR		0x3cf5	/* 13.6 */
>  #define PCI_DEVICE_ID_INTEL_SBRIDGE_SAD1	0x3cf6	/* 12.7 */
>  #define PCI_DEVICE_ID_INTEL_IOAT_SNB	0x402f
> +#define PCI_DEVICE_ID_INTEL_VMD_467F	0x467f
> +#define PCI_DEVICE_ID_INTEL_VMD_4C3D	0x4c3d

Please don't add pci_ids.h constants there are only used in a single
driver.  Especially so if they are totally non-descriptive.
