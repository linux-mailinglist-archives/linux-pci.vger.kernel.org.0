Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC2C529275
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 23:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349063AbiEPVId (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 17:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349169AbiEPVIM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 17:08:12 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E955A4A3C8;
        Mon, 16 May 2022 13:49:44 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-edf9ddb312so21773769fac.8;
        Mon, 16 May 2022 13:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dJ407RX9rra+MeG41XsuDhxD1nvVBeIHBR/vdQHMxFg=;
        b=uGnV8i7EYk9xkRxbGIAMf418oeQ21KaYhYgowf2A8Vjd1QfUKN0nrw8E6GKqiwZu4Z
         HDq7Q+CkWPNONUBqc5ecbQLl/2TB0k87rKSJsqOGfrK0ILY4Ih7UXk1JodpzHhPMMMEE
         X/ieg0ezp8uETsPc4Xj2JNDoEBXJLvEgjujThQc0jbBFtnXVYY8Vb8claRIFIa172oXt
         2y0DXKRWlFOyB0wav+uxASE0NCpab1+qvwMp92YmyiM4GtvZchi9Lfvh6R+KzS+USEGp
         /kvL4iuBaPlhumU9vVvKTTr7lViMclSWluR7YV1rxd7F8aJnG9BI9HuNT+XzXcCUFLe/
         ZcWg==
X-Gm-Message-State: AOAM533L8IRKnD8E53wXa6Kb9BMPlr1SJYiY4zooFQ6Likc1YShOskbM
        Hgbc8f/m+uCxXbhj4MgJFg==
X-Google-Smtp-Source: ABdhPJwSZjeoTdSCcmGSB5osGq7WGCVKCO9I/IGTjq81+0ENZwa2gjhYxpSHG+AyOhA/zPGQj+g1IQ==
X-Received: by 2002:a05:6870:b527:b0:ed:9cbd:e04a with SMTP id v39-20020a056870b52700b000ed9cbde04amr16246920oap.41.1652734184207;
        Mon, 16 May 2022 13:49:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s124-20020aca5e82000000b00325cda1ffb8sm4158039oib.55.2022.05.16.13.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 13:49:43 -0700 (PDT)
Received: (nullmailer pid 3259375 invoked by uid 1000);
        Mon, 16 May 2022 20:49:42 -0000
Date:   Mon, 16 May 2022 15:49:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/17] PCI: dwc: Drop iATU regions enumeration -
 dw_pcie_region_type
Message-ID: <20220516204942.GG3209795-robh@kernel.org>
References: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
 <20220503214638.1895-11-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503214638.1895-11-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 04, 2022 at 12:46:31AM +0300, Serge Semin wrote:
> There is no point in having the dw_pcie_region_type enumeration for almost
> the same reasons as it was stated for dw_pcie_as_type. First of all it's
> redundant since the driver already has a set of the macros declared which
> describe the possible inbound and outbound iATU regions. Having an
> addition abstraction just needlessly complicates the code. Secondly
> checking the region type passed to the dw_pcie_disable_atu() method for
> validity is pointless since the erroneous situation is just ignored in the
> current method implementation. So to speak let's drop the redundant
> dw_pcie_region_type enumeration replacing it with the direct iATU
> direction macro usage.
> 
> Since the dw_pcie_disable_atu() method now directly accepts the
> in-/outbound iATU region direction instead of the abstract region type we
> need to change the argument name and the arguments order. The later change
> makes the function prototype looking more logical since the passed index
> indicates an iATU window within the regions with the corresponding
> direction.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - Move this patch to being applied before the IB/OB iATU windows setup
>   simplification patch (@Rob).
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   |  4 +--
>  .../pci/controller/dwc/pcie-designware-host.c |  2 +-
>  drivers/pci/controller/dwc/pcie-designware.c  | 28 +++++--------------
>  drivers/pci/controller/dwc/pcie-designware.h  | 13 ++-------
>  4 files changed, 13 insertions(+), 34 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
