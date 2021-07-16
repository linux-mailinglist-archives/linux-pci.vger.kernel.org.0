Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8873B3CBB3E
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 19:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhGPRgf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jul 2021 13:36:35 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:43572 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbhGPRgd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jul 2021 13:36:33 -0400
Received: by mail-io1-f52.google.com with SMTP id k16so11478327ios.10;
        Fri, 16 Jul 2021 10:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bBjy0/9KrCFc43pikW3DapYBnLJRP7OXLZVYWY+cmRw=;
        b=S3J6w5viE6zDh0lQnxATT8w7C0pRFcI61r6J5UXZbNnlNEr5rkzcIn/NFWPfD7eTgU
         zjssBGhRpnrcRtR3JR+WK59ahDQTMm/juU5PVZ7CpvgnsEJE9KW3nhTOHKqtY8h5YFkr
         A6VPHmdJ+JXmSJtVnUvBr/aBqumLMqizfRM3YtgYUJx6mdqG8qWHSOfv0E/cRceLhMoN
         ygEdlw44+9C6lBvXrhYzTOzzIfLbNGABQ+Hjei/T3jTx2pcVtJjBW27GjCh1FTnGKnQ+
         v1OYlF5/p44WjTJBkM0xnSy9sjnmr01Pz1aA05FClnD39jAcNQv5hiskXflkDi4OAjxr
         ehpQ==
X-Gm-Message-State: AOAM5315WNST4ikd7ilwtZj1hNuANItgjT8Vem3vtlDTrQtntZ71osZz
        CD8OgJlu2nGiLRkJ0JouEw==
X-Google-Smtp-Source: ABdhPJzCbDOWUkZnVdfikQrZKWQIRQPpnK2e+P3EobkMzcpWA9doURsO3jNZdUmZuJQDbGWnD2EtQw==
X-Received: by 2002:a02:a797:: with SMTP id e23mr9901120jaj.121.1626456817576;
        Fri, 16 Jul 2021 10:33:37 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id i14sm4765382ilu.71.2021.07.16.10.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 10:33:36 -0700 (PDT)
Received: (nullmailer pid 3641673 invoked by uid 1000);
        Fri, 16 Jul 2021 17:33:33 -0000
Date:   Fri, 16 Jul 2021 11:33:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, youlin.pei@mediatek.com,
        chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com,
        ot_jieyang@mediatek.com, drinkcat@chromium.org,
        Rex-BC.Chen@mediatek.com, Krzysztof Wilczyski <kw@linux.com>,
        Ryan-JH.Yu@mediatek.com
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: mediatek-gen3: Add property to
 disable dvfsrc voltage request
Message-ID: <20210716173333.GA3632722@robh.at.kernel.org>
References: <20210630024934.18903-1-jianjun.wang@mediatek.com>
 <20210630024934.18903-2-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630024934.18903-2-jianjun.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 30, 2021 at 10:49:33AM +0800, Jianjun Wang wrote:
> Add property to disable dvfsrc voltage request, if this property
> is presented, we assume that the requested voltage is always
> higher enough to keep the PCIe controller active.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>  .../devicetree/bindings/pci/mediatek-pcie-gen3.yaml       | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index e7b1f9892da4..3e26c032cea9 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -96,6 +96,12 @@ properties:
>    phys:
>      maxItems: 1
>  
> +  disable-dvfsrc-vlt-req:
> +    description: Disable dvfsrc voltage request, if this property is presented,
> +      we assume that the requested voltage is always higher enough to keep
> +      the PCIe controller active.
> +    type: boolean

What determines setting this property? Can it be implied by the 
compatible (which should be SoC specific).

Is this property specific to PCIe controller? 

Wouldn't the request be harmless to make the voltage request even if not 
needed?

I think this probably should be addressed in a common way as part of 
other QoS, devfreq, etc. requirements for devices.

Rob
