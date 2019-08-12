Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94BB5898B7
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 10:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfHLIeQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 04:34:16 -0400
Received: from foss.arm.com ([217.140.110.172]:45070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbfHLIeQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 04:34:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45E8B15A2;
        Mon, 12 Aug 2019 01:34:15 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5BF93F718;
        Mon, 12 Aug 2019 01:34:14 -0700 (PDT)
Date:   Mon, 12 Aug 2019 09:34:13 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
Subject: Re: [PATCH 2/4] PCI: dwc: Return directly when num-lanes is not found
Message-ID: <20190812083412.GT56241@e119886-lin.cambridge.arm.com>
References: <20190812042435.25102-1-Zhiqiang.Hou@nxp.com>
 <20190812042435.25102-3-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812042435.25102-3-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 12, 2019 at 04:22:22AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The num-lanes is optional, so probably it isn't added
> on some platforms. The subsequent programming is base
> on the num-lanes, hence return when it is not found.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 7d25102c304c..0a89bfd1636e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -423,8 +423,10 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  
>  
>  	ret = of_property_read_u32(np, "num-lanes", &lanes);
> -	if (ret)
> -		lanes = 0;
> +	if (ret) {
> +		dev_dbg(pci->dev, "property num-lanes isn't found\n");
> +		return;
> +	}

The existing code would assign a value of 0 to lanes when num-lanes isn't
specified, however this value isn't supported by the following switch
statement - thus we'd also print an error and return.

Therefore the only and subtle effect effect of this patch is to change
a dev_err to a dev_dbg when num-lanes isn't specified and avoid a read of
PCIE_PORT_LINK_CONTROL.

Given that num-lanes is described as optional this makes perfect sense.
Though the commit message/hunk does give the apperance that this provides
a more functional change.

Anyway:

Reviewed-by: Andrew Murray <andrew.murray@arm.com>


>  
>  	/* Set the number of lanes */
>  	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
> -- 
> 2.17.1
> 
