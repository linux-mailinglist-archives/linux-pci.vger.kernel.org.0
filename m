Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5605275C94
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 17:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgIWP5D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Sep 2020 11:57:03 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:38254 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWP5D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2020 11:57:03 -0400
Received: by mail-il1-f194.google.com with SMTP id t18so89912ilp.5;
        Wed, 23 Sep 2020 08:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hprSGRETocdQf78XETYgy258w0hwpUnZV3tfOx1jhyw=;
        b=svIVldVq9lHc5+x5TRugBYQGLkCd1noQWKci2+n/cuJyGhzw0pq1j1pkesuQVb6Iya
         UxN6cGHmRGwMmyJc8VxkkqGFDMijlgyG7kJE5M5YOMvN1Z3uhKq+w7JAfmZuH1+NM0Y/
         //nTmuNm1QbUt2MkOsBW4jEOFycag9PPx+DfOxwFtOJ5SS6MHA/I95pdmgyq4nn6T35s
         Lh3HLJ9CfKunbpTgsmONs56jZXGTPC+nlyjzFDBte2q0oedlm1AvIfdyAteinZ5kHep/
         2bTC7MiswTa1eyDQWC/EIKd3hycL72n400KTzgP9i+JQ88GF8GIpYm7501a5OtukjW+f
         dbkA==
X-Gm-Message-State: AOAM531DnCzwYpJ15E9dr3nHGHWCkXyNTa1jEmuSj3lIUvI+6AC+v/O6
        oR9bz8hvbBIptTcm0UvViA==
X-Google-Smtp-Source: ABdhPJwF7cW7wtVVPFcinJZJ2wi7GujCzMGUvUKlTAUpRG7xH9KI47JiB3sor9fbqqkTDEEEDRoQKQ==
X-Received: by 2002:a92:d8cb:: with SMTP id l11mr371869ilo.271.1600876622055;
        Wed, 23 Sep 2020 08:57:02 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id p5sm18530ilg.32.2020.09.23.08.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 08:57:01 -0700 (PDT)
Received: (nullmailer pid 825904 invoked by uid 1000);
        Wed, 23 Sep 2020 15:57:00 -0000
Date:   Wed, 23 Sep 2020 09:57:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: dwc: Add common iATU register support
Message-ID: <20200923155700.GA820801@bogus>
References: <1599814203-14441-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1599814203-14441-3-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599814203-14441-3-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 11, 2020 at 05:50:02PM +0900, Kunihiko Hayashi wrote:
> This gets iATU register area from reg property that has reg-names "atu".
> In Synopsys DWC version 4.80 or later, since iATU register area is
> separated from core register area, this area is necessary to get from
> DT independently.
> 
> Cc: Murali Karicheri <m-karicheri2@ti.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 4d105ef..4a360bc 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -10,6 +10,7 @@
>  
>  #include <linux/delay.h>
>  #include <linux/of.h>
> +#include <linux/of_platform.h>
>  #include <linux/types.h>
>  
>  #include "../../pci.h"
> @@ -526,11 +527,16 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  	u32 val;
>  	struct device *dev = pci->dev;
>  	struct device_node *np = dev->of_node;
> +	struct platform_device *pdev;
>  
>  	if (pci->version >= 0x480A || (!pci->version &&
>  				       dw_pcie_iatu_unroll_enabled(pci))) {
>  		pci->iatu_unroll_enabled = true;
> -		if (!pci->atu_base)
> +		pdev = of_find_device_by_node(np);

Use to_platform_device(dev) instead. Put that at the beginning as I'm 
going to move 'dbi' in here too.

> +		if (!pci->atu_base && pdev)
> +			pci->atu_base =
> +			    devm_platform_ioremap_resource_byname(pdev, "atu");
> +		if (IS_ERR_OR_NULL(pci->atu_base))
>  			pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
>  	}
>  	dev_dbg(pci->dev, "iATU unroll: %s\n", pci->iatu_unroll_enabled ?
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
