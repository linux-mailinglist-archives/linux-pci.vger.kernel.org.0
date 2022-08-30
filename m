Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6975A6F30
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 23:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiH3Vdb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 17:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiH3Vdb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 17:33:31 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EEA89CD1;
        Tue, 30 Aug 2022 14:33:30 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-11f11d932a8so11544882fac.3;
        Tue, 30 Aug 2022 14:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=GOTFRorBIBX66XRGhGzIOArD4XzR32U93olT+o6d4TA=;
        b=VuJMpl9oAxY06r4R75Gk7VsDfq5b8jBPNia7nHXsPfk7TrFFtA9AlGEyfoZ1HNL2Fa
         0yasx+tStgUwIok13KPxh7GUAv20CUY/jHOaRaoPew9SB5Y04WmKMVtsIlE10+C+Sl35
         QyqTmqkex+YVQMUpw/Zs/xFPUOMRy086sNKLTIkFYkaEGv1AJYHEDy9KNnOWL9bR4yQl
         BC5gIZyjCp0ycarRrbTHrSbs4ky9Kkz/Zpyv2rDj149LKj17F/AG6fSWUIWFtJxdUZFl
         UAfUJ+7nTdjKTS/FeZYtk5FxUsIE42SWRmRz6l1ZXoNaKoJd8YTwVwinBR/c2SHYkm8r
         SpUg==
X-Gm-Message-State: ACgBeo1550/Mv+dNqLG2CoV0SWqnKYHqVyhcvP0XAA3Rg7PnoddFpW3X
        6B1CG+B84SXyla2/WVGaZg==
X-Google-Smtp-Source: AA6agR4k02r9J+x1/GLhvNLKKpUomnGSi6dqOqh4iMGYwbRwkQ6CKz7vjvtcYrTFM+ll8SfyT0J2Wg==
X-Received: by 2002:a05:6808:e8a:b0:337:9846:931a with SMTP id k10-20020a0568080e8a00b003379846931amr78260oil.215.1661895209805;
        Tue, 30 Aug 2022 14:33:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g15-20020a056830160f00b00636eeba9209sm7977462otr.52.2022.08.30.14.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 14:33:29 -0700 (PDT)
Received: (nullmailer pid 2113828 invoked by uid 1000);
        Tue, 30 Aug 2022 21:33:28 -0000
Date:   Tue, 30 Aug 2022 16:33:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 02/20] dt-bindings: visconti-pcie: Fix interrupts
 array max constraints
Message-ID: <20220830213328.GA2112212-robh@kernel.org>
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
 <20220822184701.25246-3-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822184701.25246-3-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 22, 2022 at 09:46:43PM +0300, Serge Semin wrote:
> In accordance with the way the device DT-node is actually defined in
> arch/arm64/boot/dts/toshiba/tmpv7708.dtsi and the way the device is probed
> by the DW PCIe driver there are two IRQs it actually has. It's MSI IRQ the
> DT-bindings lack. Let's extend the interrupts property constraints then
> and fix the schema example so one would be acceptable by the actual device
> DT-bindings.
> 
> Fixes: 17c1b16340f0 ("dt-bindings: pci: Add DT binding for Toshiba Visconti PCIe controller")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v5:
> - This is a new patch added on the v5 release of the patchset.
> ---
>  .../devicetree/bindings/pci/toshiba,visconti-pcie.yaml     | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

No need for this to be in this series.

Acked-by: Rob Herring <robh@kernel.org>
