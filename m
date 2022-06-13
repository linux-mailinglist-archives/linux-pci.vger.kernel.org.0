Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DF754A04D
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 22:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351025AbiFMUyo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 16:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352294AbiFMUyW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 16:54:22 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261F82AE21;
        Mon, 13 Jun 2022 13:23:00 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-fe539f9afbso9904269fac.5;
        Mon, 13 Jun 2022 13:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hQtdW3mNzOqqAz0EIGKInm9VroMOpphYtVs06PrJmgg=;
        b=sgWVxLxxBXD+0AClpuxc1bxB4LHbDwNmCNptgoJ+TE2iBMgj58gnu2+moAuzI0j+1b
         9H67WcjRqwFE1si0Kq8C3fCgmPqLZwVG/xDOfjBeSIz5Je+1PcRyeyrWvdQJ4E2fRN6Q
         ZdB0nEFVG5PH0iH0VW/egDcppdTLnVQBmmiozxyuoiT4Z/oKQMyeMECeoXuSdl1Cqk22
         gwfFu/6DV0pHWVfGPZDnIRD/i1QqcRyEVN7/uk+XVle9EWwiXsvQEuz4OtQ6b8kIpzjQ
         a7AITtbtscu11vY+xHVQOfPnxvkhb68hbnIPVhsK3I0ZjxupYWXVPFxx6tdXbdLcywhB
         TmMA==
X-Gm-Message-State: AJIora/l4nlkCUuFDm8x6g1AxwnSbRrQiJmmKngzVDZvTbUApbB7OGU/
        0gRxOhgA+qrcfYmvlHEZxw==
X-Google-Smtp-Source: AGRyM1vrWgRbbtIgkaNRth576iwAsSlwfWEsZWYqAZSEG7WmXUmtS7T2Ef2c7HYaOgH45FwPN+G1dA==
X-Received: by 2002:a05:6870:c38c:b0:f1:ce0b:4dd3 with SMTP id g12-20020a056870c38c00b000f1ce0b4dd3mr349702oao.12.1655151779463;
        Mon, 13 Jun 2022 13:22:59 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:20d2:bb97:4381:7341:60ed:a4a1])
        by smtp.gmail.com with ESMTPSA id e14-20020a056871044e00b000f3347daaa6sm4490557oag.9.2022.06.13.13.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 13:22:59 -0700 (PDT)
Received: (nullmailer pid 4178168 invoked by uid 1000);
        Mon, 13 Jun 2022 20:00:32 -0000
Date:   Mon, 13 Jun 2022 14:00:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/18] PCI: dwc: Add unroll iATU space support to the
 regions disable method
Message-ID: <20220613200032.GA4174748-robh@kernel.org>
References: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
 <20220610082535.12802-3-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610082535.12802-3-Sergey.Semin@baikalelectronics.ru>
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

On Fri, Jun 10, 2022 at 11:25:18AM +0300, Serge Semin wrote:
> The dw_pcie_disable_atu() method was introduced in the commit f8aed6ec624f
> ("PCI: dwc: designware: Add EP mode support"). Since then it hasn't
> changed at all.  For all that time the method has supported the viewport
> version of the iATU CSRs only. Basically it works for the DW PCIe IP-cores
> older than v4.80a since the newer controllers are equipped with the
> unrolled iATU/eDMA space. It means the methods using it like
> pci_epc_ops.clear_bar and pci_epc_ops.unmap_addr callbacks just don't work
> correctly for the DW PCIe controllers with unrolled iATU CSRs. The same
> concerns the dw_pcie_setup_rc() method, which disables the outbound iATU
> entries before re-initializing them.
> 
> So in order to fix the problems denoted above let's convert the
> dw_pcie_disable_atu() method to disabling the iATU inbound and outbound
> regions in the unrolled iATU CSRs in case the DW PCIe controller has been
> synthesized with the ones support. The former semantics will be remained
> for the controller having iATU mapped over the viewport.
> 
> Fixes: f8aed6ec624f ("PCI: dwc: designware: Add EP mode support")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> ---
> 
> Changelog v3:
> - Convert region variable type to u32 in order to fix the implicit type
>   conversion peculiarity. (@kbot)
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
