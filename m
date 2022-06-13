Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FDA54A04B
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 22:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351116AbiFMUyr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 16:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352288AbiFMUyV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 16:54:21 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1561C2AE1B;
        Mon, 13 Jun 2022 13:22:55 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id q11so9063107oih.10;
        Mon, 13 Jun 2022 13:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HdFPErUdOvtHaxHWD760EvrNl0+Q6KIgb8WKCYVLSDM=;
        b=68Shpnsqr11uJsHwsq8NDSQ8FUh4WwCwdrgXyprE6fiRvKE3NAE1plqERjX35KmURh
         DyS2SrKjQyTe5Ac1TCSDpETzoimGodwYMMqT1sjYkDXK0VEQl+5Xef508lYdUi/mdB3K
         MPYm+1KHrnXwtI/tuHOFysk50bseAvKuUIaYT+0vH1GiW4BBEYFsNkImgwS6L1G//WFX
         G8NafxkIEKEUqQphjnMtOqutU4O/jtdp55n2RSXXal8aPhVDmPnQzR0N9PdITFYVzHFM
         HzhDaf5yDJ74zPU3rP66VG6WCGY2FNKzgxxk8WC/eIE3CDN9+XSWkSDgNr979/OYwk0D
         eAWQ==
X-Gm-Message-State: AOAM532CaP2EtGdJ96vYh8M0OEfXnAGnWvWRwMV3dIEO+GainJvO+ZnG
        7f7fOUKrE1GrKPklOJFy/Q==
X-Google-Smtp-Source: ABdhPJwN2SdXLyNXc2+j3VlhyIq9alhHBa16mpg0uVsHAAlEJLQXpJYK57x9p8qL7lq3N7eG4nv6WA==
X-Received: by 2002:a05:6808:30a7:b0:32f:91a:fd87 with SMTP id bl39-20020a05680830a700b0032f091afd87mr254707oib.255.1655151774395;
        Mon, 13 Jun 2022 13:22:54 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:20d2:bb97:4381:7341:60ed:a4a1])
        by smtp.gmail.com with ESMTPSA id p9-20020a4a3649000000b0035eb4e5a6cesm4065897ooe.36.2022.06.13.13.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 13:22:54 -0700 (PDT)
Received: (nullmailer pid 4182919 invoked by uid 1000);
        Mon, 13 Jun 2022 20:03:29 -0000
Date:   Mon, 13 Jun 2022 14:03:29 -0600
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
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/18] PCI: dwc: Disable outbound windows for
 controllers with iATU
Message-ID: <20220613200329.GA4181502-robh@kernel.org>
References: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
 <20220610082535.12802-4-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610082535.12802-4-Sergey.Semin@baikalelectronics.ru>
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

On Fri, Jun 10, 2022 at 11:25:19AM +0300, Serge Semin wrote:
> In accordance with the dw_pcie_setup_rc() method semantics and judging by
> what the comment added in commit dd193929d91e ("PCI: designware: Explain
> why we don't program ATU for some platforms") states there are DWC
> PCIe-available platforms like Keystone (pci-keystone.c) or Amazon's
> Annapurna Labs (pcie-al.c) which don't have the DW PCIe internal ATU
> enabled and use it's own address translation approach implemented. In
> these cases at the very least there is no point in touching the DW PCIe
> iATU CSRs. Moreover depending on the vendor-specific address translation
> implementation it might be even erroneous. So let's move the iATU windows
> disabling procedure to being under the corresponding conditional statement
> clause thus performing that procedure only if the iATU is expected to be
> available on the platform.
> 
> Fixes: 458ad06c4cdd ("PCI: dwc: Ensure all outbound ATU windows are reset")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

