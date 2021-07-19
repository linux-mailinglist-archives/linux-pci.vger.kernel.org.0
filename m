Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB3C3CF083
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jul 2021 02:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355109AbhGSX1T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jul 2021 19:27:19 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:40622 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392359AbhGSWGn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jul 2021 18:06:43 -0400
Received: by mail-io1-f44.google.com with SMTP id l5so21934172iok.7;
        Mon, 19 Jul 2021 15:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KvZduHEK4/JPd13AvRj7Dwo91+WDf4ZZkoTysoY/Z8c=;
        b=C8ntqv2VbdZQLR0ghf46So1qeVVs/zRVH8+HvX8ekwXnt61iPsHBB5PdQz+bcMbrcI
         t5CfL+MTiVz8ZEaEU/PCcG5dAOw8oh26hW7i4Ev0QpbdD8nc8We7weivWHB+rQfQqid6
         t8Owmk+m4EwJoGKmugnSgn2HMnOvkT7kDORJedPE05ADZJaXzPLNTGSbYbQvChYrwp5u
         Uck6PPyD/ZjfUEPNLEhO4cT6YjWfRwaEH+CXKvLj7PxzwK2c/2ymEH8vh9WzSk25Lxel
         lid6a+Xrjva1u4IIkwp1x9HB1lz7ZuwxX2lq7zL1rNRFgXhwj/5EXcxQ8JTfDqVS0PJ2
         3asA==
X-Gm-Message-State: AOAM5321Z+feDVh/LHNpMVlc4jxBaLJ6ii/pEjd4E7BGuTQYqLmIAzJ9
        caeKZBCNdHK1CW1TjYbc/w==
X-Google-Smtp-Source: ABdhPJx2z9Xre7CdCLPouoO6dfskCrk/L/I3dMKprr4kx+Phkn3qCMvEw/eDabtuZvzFiQhg1hdthg==
X-Received: by 2002:a6b:fe03:: with SMTP id x3mr1146470ioh.120.1626734842302;
        Mon, 19 Jul 2021 15:47:22 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id w10sm10283737ilo.17.2021.07.19.15.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 15:47:21 -0700 (PDT)
Received: (nullmailer pid 2767559 invoked by uid 1000);
        Mon, 19 Jul 2021 22:47:18 -0000
Date:   Mon, 19 Jul 2021 16:47:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chuanjia Liu <chuanjia.liu@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com,
        jianjun.wang@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, bhelgaas@google.com,
        ryder.lee@mediatek.com, robh+dt@kernel.org, matthias.bgg@gmail.com,
        linux-pci@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>,
        devicetree@vger.kernel.org, yong.wu@mediatek.com
Subject: Re: [PATCH v11 1/4] dt-bindings: PCI: mediatek: Update the Device
 tree bindings
Message-ID: <20210719224718.GA2766057@robh.at.kernel.org>
References: <20210719073456.28666-1-chuanjia.liu@mediatek.com>
 <20210719073456.28666-2-chuanjia.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719073456.28666-2-chuanjia.liu@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 19 Jul 2021 15:34:53 +0800, Chuanjia Liu wrote:
> There are two independent PCIe controllers in MT2712 and MT7622
> platform. Each of them should contain an independent MSI domain.
> 
> In old dts architecture, MSI domain will be inherited from the root
> bridge, and all of the devices will share the same MSI domain.
> Hence that, the PCIe devices will not work properly if the irq number
> which required is more than 32.
> 
> Split the PCIe node for MT2712 and MT7622 platform to comply with
> the hardware design and fix MSI issue.
> 
> Signed-off-by: Chuanjia Liu <chuanjia.liu@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../bindings/pci/mediatek-pcie-cfg.yaml       |  39 ++++
>  .../devicetree/bindings/pci/mediatek-pcie.txt | 206 ++++++++++--------
>  2 files changed, 150 insertions(+), 95 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-cfg.yaml
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

