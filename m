Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CE02AC77B
	for <lists+linux-pci@lfdr.de>; Mon,  9 Nov 2020 22:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbgKIVnC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Nov 2020 16:43:02 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43926 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbgKIVnC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Nov 2020 16:43:02 -0500
Received: by mail-ot1-f66.google.com with SMTP id y22so10473036oti.10;
        Mon, 09 Nov 2020 13:43:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9QhWZ1oAdheaUIAFyejHHmGrmHQabv1ozXKtHPuilcU=;
        b=qMi9kyY9C9D7BM3y4pWa5IK3S16owkHANeDEKgjFYNAay9YnfqyFkWl5saPSJqQp1a
         a8YHpHBFcOw8T0nIjwpsJ+EQTIoiQQBi8b0d5dk39kND1MQWGfjA8ekqW8CrKOu6Xw12
         VVDaBVfkc1gDN7atuZHIcVMQ9qVPSqxmPsiVYwRBw3LIERk08qm8BEi8Hl2lVRqrK0Kh
         CANgI6sMD5akk/e/TLE//T+FBVgTZGqKdC6HDnw4s1cuWlbDjEtQ1Ky0SaLQN3J4EWJC
         /V75sADfeks4kZehOfn59qOdlc/ytk/oPd5sYViAvBbQ6d/qyePRd4CMcWNvn7F22E2a
         wt8Q==
X-Gm-Message-State: AOAM531x4jlrtiVJSt0b2bRePb7KTDFAH9FjANGUQnYiRRIFoYhkaXsL
        sF4DSc0QUIuKqqoy1gF6XzV92j3Gpw==
X-Google-Smtp-Source: ABdhPJyvHaYAnymWPP7L6XLb4DFX/jEbiQEhOi1OegNQOM/rcIhme7mdalsx5tWauh9DdAlaYqYP3Q==
X-Received: by 2002:a9d:6641:: with SMTP id q1mr12212275otm.190.1604958181041;
        Mon, 09 Nov 2020 13:43:01 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b23sm648845ooa.13.2020.11.09.13.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:43:00 -0800 (PST)
Received: (nullmailer pid 1807522 invoked by uid 1000);
        Mon, 09 Nov 2020 21:42:59 -0000
Date:   Mon, 9 Nov 2020 15:42:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: cadence: Do not error if
 "cdns,max-outbound-regions" is not found
Message-ID: <20201109214259.GA1806607@bogus>
References: <20201106151107.3987-1-kishon@ti.com>
 <20201106151107.3987-3-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106151107.3987-3-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 06, 2020 at 08:41:07PM +0530, Kishon Vijay Abraham I wrote:
> Now that "cdns,max-outbound-regions" is made an optional property, do
> not error out if "cdns,max-outbound-regions" device tree property is
> not found.
> 
> Link: http://lore.kernel.org/r/20201105165331.GA55814@bogus
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-ep.c | 9 +++------
>  drivers/pci/controller/cadence/pcie-cadence.h    | 1 +
>  2 files changed, 4 insertions(+), 6 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index 254a3e1eff50..9a4195af958e 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -531,12 +531,9 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
>  	}
>  	pcie->mem_res = res;
>  
> -	ret = of_property_read_u32(np, "cdns,max-outbound-regions",
> -				   &ep->max_regions);
> -	if (ret < 0) {
> -		dev_err(dev, "missing \"cdns,max-outbound-regions\"\n");
> -		return ret;
> -	}
> +	ep->max_regions = CDNS_PCIE_MAX_OB;
> +	of_property_read_u32(np, "cdns,max-outbound-regions", &ep->max_regions);
> +
>  	ep->ob_addr = devm_kcalloc(dev,
>  				   ep->max_regions, sizeof(*ep->ob_addr),
>  				   GFP_KERNEL);
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index feed1e3038f4..30eba6cafe2c 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -197,6 +197,7 @@ enum cdns_pcie_rp_bar {
>  };
>  
>  #define CDNS_PCIE_RP_MAX_IB	0x3
> +#define CDNS_PCIE_MAX_OB	32
>  
>  struct cdns_pcie_rp_ib_bar {
>  	u64 size;
> -- 
> 2.17.1
> 
