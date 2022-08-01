Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828CB586FF6
	for <lists+linux-pci@lfdr.de>; Mon,  1 Aug 2022 19:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbiHAR6W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Aug 2022 13:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbiHAR5x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2022 13:57:53 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BE018E0D;
        Mon,  1 Aug 2022 10:56:57 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id h145so8951429iof.9;
        Mon, 01 Aug 2022 10:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=pXG+lGlXO+8gYYtFStzjQr5se0f0+gkX9e0+xy32FKc=;
        b=AzK800nLL7ZskyZTKpJVS2U8NswuBUL1vQFKwPo4IiyqUgfBhaCDAVGi8pMoKKmsGI
         r88m5gRnllrq5cCW+IAlbekLlxZRu4LhgTPLkqbeKv57yfSaaEhtuOwZSbrVaTZ056nO
         pMHjuhnrPgBh5kk6YDdmGUsMwJv4RAA7G2dX2uCSpoQ7FLzVtWHkgQB+57zgY5AfLQOL
         /N6MLCm+ZOX6BKjgYL1nM7vx8/6e0vjqoTnd/GY1rCsgt2FSsnEQTCXtMcM8Ugv5Q2z/
         oVZJFn7cQqFIuMzpOAXeeCO7EEr8biL1+2CVcylW9cLwb8eC/YSsiFTwAoKmF8QyBeZ3
         uRKA==
X-Gm-Message-State: ACgBeo2/PfPOwS12U905uZuXK5/e/i+JXjHxEojDzEAlbWPbpR6xRcWL
        cG27jSiVjFhSIxj34Uabhg==
X-Google-Smtp-Source: AA6agR6iEjeYVaghayqVwr6+BtbP1cV2+9w6GkG0x/n0NBqNAt+1nAmTgbOvHOrrUTFuV9d0Ayq4Pw==
X-Received: by 2002:a05:6638:1355:b0:342:7281:8e3a with SMTP id u21-20020a056638135500b0034272818e3amr2884519jad.15.1659376616876;
        Mon, 01 Aug 2022 10:56:56 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id y8-20020a027308000000b00339c4e447e2sm5527837jab.151.2022.08.01.10.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 10:56:56 -0700 (PDT)
Received: (nullmailer pid 1257252 invoked by uid 1000);
        Mon, 01 Aug 2022 17:56:54 -0000
Date:   Mon, 1 Aug 2022 11:56:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>, devicetree@vger.kernel.org,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: Re: [PATCH v4 04/17] dt-bindings: PCI: dwc: Add max-link-speed
 common property
Message-ID: <20220801175654.GA1257218-robh@kernel.org>
References: <20220728143427.13617-1-Sergey.Semin@baikalelectronics.ru>
 <20220728143427.13617-5-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728143427.13617-5-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 28 Jul 2022 17:34:14 +0300, Serge Semin wrote:
> In accordance with [1] DW PCIe controllers support up to Gen5 link speed.
> Let's add the max-link-speed property upper bound to 5 then. The DT
> bindings of the particular devices are expected to setup more strict
> constraint on that parameter.
> 
> [1] Synopsys DesignWare Cores PCI Express Controller Databook, Version
> 5.40a, March 2019, p. 27
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v3:
> - This is a new patch unpinned from the next one:
>   https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
>   by the Rob' request. (@Rob)
> ---
>  Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml | 3 +++
>  Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml     | 2 ++
>  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml        | 1 +
>  3 files changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
