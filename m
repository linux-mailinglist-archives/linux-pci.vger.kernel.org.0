Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA08A38CE89
	for <lists+linux-pci@lfdr.de>; Fri, 21 May 2021 22:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhEUUGC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 May 2021 16:06:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229780AbhEUUGC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 May 2021 16:06:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7173D61164;
        Fri, 21 May 2021 20:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621627478;
        bh=1k38VJ4yVR9TldPkGo+zwNbR5qRSBtFCx86R1WrERWE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qln9b65tKongqy/tNdm70AHKB7X7CcgcmCRp0PidnAZoR8s0hQPGCLml0bzPGlbvj
         zuKnyTSdCO7Obu992YFIvrz+wKjphvRo+qx5HwlhU2u7+MEFQ7l5o6jrTPYqEcSYKj
         llnf6/XNqwnNQJ6IO56Xk+5Lqog5sfy777gCE1r/BOIltfF8vxTSiz3XwiDY3RKAei
         Px2+0uuBFSpwPisPzcsjQNP+5MMBPK0gKTIfhHXqEXki+Fsejpsl8eYwocfLLg3dVb
         jzeyxSYuNx5xsg7rwAC53JOgT+3XSVxBkWPyGfRXry9vtGM02I+FPEKMWrCdT8JLJm
         yZGo01sRWP48Q==
Date:   Fri, 21 May 2021 15:04:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shradha Todi <shradha.t@samsung.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        pankaj.dubey@samsung.com, p.rajanbabu@samsung.com,
        hari.tv@samsung.com, niyas.ahmed@samsung.com, l.mehra@samsung.com
Subject: Re: [PATCH 3/3] PCI: dwc: Create debugfs files in DWC driver
Message-ID: <20210521200437.GA441141@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518174618.42089-4-shradha.t@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 18, 2021 at 11:16:18PM +0530, Shradha Todi wrote:
> Add call to create_debugfs_files() from DWC driver to create the RASDES
> debugfs structure for each platform driver. Since it can be used for both
> DW HOST controller as well as DW EP controller, let's add it in the common
> setup function.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 348f6f696976..c054f8ba1cf4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -15,6 +15,7 @@
>  
>  #include "../../pci.h"
>  #include "pcie-designware.h"
> +#include "pcie-designware-debugfs.h"
>  
>  /*
>   * These interfaces resemble the pci_find_*capability() interfaces, but these
> @@ -793,4 +794,8 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  		       PCIE_PL_CHK_REG_CHK_REG_START;
>  		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
>  	}
> +
> +	ret = create_debugfs_files(pci);
> +	if (ret)
> +		dev_err(pci->dev, "Couldn't create debugfs files\n");

Was there supposed to be a corresponding remove_debugfs_files() call?
On module unload?

>  }
> -- 
> 2.17.1
> 
