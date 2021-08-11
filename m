Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6743E9706
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 19:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhHKRvE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 13:51:04 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:42674 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhHKRvD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 13:51:03 -0400
Received: by mail-pj1-f44.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso6328637pjb.1;
        Wed, 11 Aug 2021 10:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uXuZxvmC9dWMxXHamiQ0kCxgDbumKVveKsGWWbzD8PI=;
        b=XD0zdgPOBkocNasvwGoH+G2voAaY6yV8xHCv/LE5HI36J8qVIJT+DSHifb10BUtrFO
         q18qpgzoyceDBwzST528OvHQGP/iHRWXOGORvEJujcfrttQzONCNGbPoHSReYiXpbSym
         Fv+vZB8ZXpJnF7ha3bshPy8tvvE7KS1mCG6tNJjQL5dpHB68bvaIeHsF9IVLu2TK36kT
         8iZ78ORdslXEx8HVayatcHATriWMQjMDRVBa5vWELap+qJLVQtkV7LU6BjicTJjPLD58
         eFxBf0FGuRe1hzPi1wYjbKn7jclb6c2gg6lwf/fNdxnZYwkED052yvyAj6HRqbqa67Xt
         FIow==
X-Gm-Message-State: AOAM533mhTDziTbqWfeunKZmCq52UDxm/IYCl2vGJ2cir60ezg+Ei1ku
        3BjHlbu490Un/8gDD/otVw==
X-Google-Smtp-Source: ABdhPJxuEAsQX2oLcwEObZ00L2Y1HqW/rUDfIiQ9FVgGXV3Y6qIEzhTf4EKv95M02ZNUs+Q2cxypiQ==
X-Received: by 2002:a63:5252:: with SMTP id s18mr65321pgl.94.1628704238944;
        Wed, 11 Aug 2021 10:50:38 -0700 (PDT)
Received: from robh.at.kernel.org ([208.184.162.215])
        by smtp.gmail.com with ESMTPSA id e31sm78977pjk.19.2021.08.11.10.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 10:50:38 -0700 (PDT)
Received: (nullmailer pid 4169078 invoked by uid 1000);
        Wed, 11 Aug 2021 17:50:34 -0000
Date:   Wed, 11 Aug 2021 11:50:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: pci: Add DT binding for Toshiba
 Visconti PCIe controller
Message-ID: <YRQN6paKB1772KJD@robh.at.kernel.org>
References: <20210811083830.784065-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210811083830.784065-2-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811083830.784065-2-nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 11, 2021 at 05:38:28PM +0900, Nobuhiro Iwamatsu wrote:
> This commit adds the Device Tree binding documentation that allows
> to describe the PCIe controller found in Toshiba Visconti SoCs.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> 
> v3 -> v4:
>  - Changed the redundant clock name.
> 
> v2 -> v3:
>  - No update.
> 
> v1 -> v2:
>  - Remove white space.
>  - Drop num-viewport and bus-range from required.
>  - Drop status line from example.
>  - Drop bus-range from required.
>  - Removed lines defined in pci-bus.yaml from required.
> ---
>  .../bindings/pci/toshiba,visconti-pcie.yaml   | 110 ++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml

I already applied this, why are you sending it again?

Rob
