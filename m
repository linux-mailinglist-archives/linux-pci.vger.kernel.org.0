Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91C9A9F619
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 00:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfH0W0U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 18:26:20 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35683 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfH0W0U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2019 18:26:20 -0400
Received: by mail-oi1-f195.google.com with SMTP id a127so558674oii.2;
        Tue, 27 Aug 2019 15:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RsXxLyUlV4lqdtFyyPSn3Dwod1DhrS1XN9CvxX7CGqs=;
        b=C8mpG63dWOlEiKu6hilMe9sVJUxe1BkVD7yflVJCwiwOZ92OwZmC38t/375DSC3VyB
         NVt86o1ybhn0H+x0rK4PhoJMxAbtEquzHcw9GbklF2CXCjBOLD5+NsMwhR+/enk65JZw
         NBw+uUtfmNPDsKeGShXzBVMsQGd9zT+gzEqSlrJZsmKw3dAvHk7i+paaLNrcpNDCBVr2
         7nVsui81+vtMOxxvWQmWbJQh+MZ9e04XqwhG1DdZ3YsZkSAMLRAP8hS2TFNN3HA0pJzi
         LMyEoWXs+LymKfYnKsZo9pWeimzQnTckO4ziKansoPTDxgjw1nEDYJSa9bvsrwnU6Yla
         bekg==
X-Gm-Message-State: APjAAAUOlPlmK1o9+zfEtfushrDqWpa3+G+lhua7heuOh322KFRKfbVH
        1hpsZsRtWta+H60vIePpNg==
X-Google-Smtp-Source: APXvYqy3XTy77RRAsfzmCAwhDWWJujML7UeMVZxJl+o+X2Va2w3R8MESfCjhk2TLGcKIC236QGmbgA==
X-Received: by 2002:aca:4b83:: with SMTP id y125mr712264oia.25.1566944779068;
        Tue, 27 Aug 2019 15:26:19 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k12sm170734oij.21.2019.08.27.15.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 15:26:18 -0700 (PDT)
Date:   Tue, 27 Aug 2019 17:26:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     bhelgaas@google.com, mark.rutland@arm.com, shawnguo@kernel.org,
        leoyang.li@nxp.com, kishon@ti.com, lorenzo.pieralisi@arm.co,
        arnd@arndb.de, gregkh@linuxfoundation.org, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, andrew.murray@arm.com
Subject: Re: [PATCH v2 04/10] dt-bindings: pci: layerscape-pci: add
 compatible strings for ls1088a and ls2088a
Message-ID: <20190827222617.GA16361@bogus>
References: <20190822112242.16309-1-xiaowei.bao@nxp.com>
 <20190822112242.16309-4-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822112242.16309-4-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 22, 2019 at 07:22:36PM +0800, Xiaowei Bao wrote:
> Add compatible strings for ls1088a and ls2088a.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
> v2:
>  - No change.
> 
>  Documentation/devicetree/bindings/pci/layerscape-pci.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> index e20ceaa..16f592e 100644
> --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> @@ -22,7 +22,10 @@ Required properties:
>          "fsl,ls1043a-pcie"
>          "fsl,ls1012a-pcie"
>    EP mode:
> -	"fsl,ls1046a-pcie-ep", "fsl,ls-pcie-ep"
> +	"fsl,ls-pcie-ep"

Wasn't this a fallback? Each line should be one valid combination of 
compatible strings.

> +	"fsl,ls1046a-pcie-ep"
> +	"fsl,ls1088a-pcie-ep"
> +	"fsl,ls2088a-pcie-ep"
>  - reg: base addresses and lengths of the PCIe controller register blocks.
>  - interrupts: A list of interrupt outputs of the controller. Must contain an
>    entry for each entry in the interrupt-names property.
> -- 
> 2.9.5
> 
