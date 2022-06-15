Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949EC54CEF5
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 18:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbiFOQqy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 12:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiFOQqx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 12:46:53 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331D64B1C9;
        Wed, 15 Jun 2022 09:46:53 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id y79so13272993iof.2;
        Wed, 15 Jun 2022 09:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xBvRhN4hhFX83OXMF4NgAA9FlGr7rDBn68/8wCjRrII=;
        b=t/vLUzztKJF48voVX5B+0H++ODDYa6XhvO++9TttPzfj12FAT8SPEINm+rxf+UyIC2
         mUuYs3BVYhYp5o4XUmPKDeNTaLPk3R3jBhtHQ2+LMjmRV9EONDkhOl2800LxyUThxlM4
         poeDg1Jkieu2xoTkg81Vbn+RJcM2vRsS51l2IFAcXYv9srafycFuigOm/hGo1zwqonZt
         NwRXsjsD0z1tzt/BVM5ylWsaX4pKvdV5TpN4jn1DHXQAcneCAqeZ8eWV6Jh5uDIVFMNW
         1W73cLIzd3TaCw/v/ZHFhEow4d5ERCRExNAk6pABQHuAjgTItcRqB+V8LIzuuker9TAz
         2Dhw==
X-Gm-Message-State: AJIora/i1S21rhKkdmEC0VtIwultJsbBENH5J1nqx4+7q9kZfbbrsA/0
        Y1Wk93TjJUCNwgDNoo+waA==
X-Google-Smtp-Source: AGRyM1uPuJOa2PWF59xUDXvG3r6jynrcRtBdP9fK4vb90/wisdnYxRIyksMOwQWa1Iy3gpWlncRaHQ==
X-Received: by 2002:a05:6638:140d:b0:331:aaf6:658b with SMTP id k13-20020a056638140d00b00331aaf6658bmr361060jad.21.1655311612484;
        Wed, 15 Jun 2022 09:46:52 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id 9-20020a056e020ca900b002d3cfed7f8fsm7019444ilg.75.2022.06.15.09.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 09:46:52 -0700 (PDT)
Received: (nullmailer pid 1422596 invoked by uid 1000);
        Wed, 15 Jun 2022 16:46:50 -0000
Date:   Wed, 15 Jun 2022 10:46:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 14/17] PCI: dwc: Introduce generic resources getter
Message-ID: <20220615164650.GB1413880-robh@kernel.org>
References: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
 <20220610085706.15741-15-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610085706.15741-15-Sergey.Semin@baikalelectronics.ru>
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

On Fri, Jun 10, 2022 at 11:57:02AM +0300, Serge Semin wrote:
> Currently the DW PCIe Root Port and Endpoint CSR spaces are retrieved in
> the separate parts of the DW PCIe core driver. It doesn't really make
> sense since the both controller types have identical set of the core CSR
> regions: DBI, DBI CS2 and iATU/eDMA. Thus we can simplify the DW PCIe Host
> and EP initialization methods by moving the platform-specific registers
> space getting and mapping into a common method. It gets to be even more
> justified seeing the CSRs base address pointers are preserved in the
> common DW PCIe descriptor. Note all the OF-based common DW PCIe settings
> initialization will be moved to the new method too in order to have a
> single function for all the generic platform properties handling in single
> place.
> 
> A nice side-effect of this change is that the pcie-designware-host.c and
> pcie-designware-ep.c drivers are cleaned up from all the direct dw_pcie
> storage modification, which makes the DW PCIe core, Root Port and Endpoint
> modules more coherent.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v3:
> - This is a new patch created on v3 lap of the series.
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 26 +------
>  .../pci/controller/dwc/pcie-designware-host.c | 15 +---
>  drivers/pci/controller/dwc/pcie-designware.c  | 75 ++++++++++++++-----
>  drivers/pci/controller/dwc/pcie-designware.h  |  3 +
>  4 files changed, 65 insertions(+), 54 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
