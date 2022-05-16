Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD02529229
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 23:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348891AbiEPU50 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 16:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349413AbiEPU4o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 16:56:44 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BC2527FA;
        Mon, 16 May 2022 13:31:25 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id v66so20070151oib.3;
        Mon, 16 May 2022 13:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Y11OEywEfGv3nDOeBHxkbPI6goZUMZWv50I7rxDxBY=;
        b=s3JOwnx9Cg79pcqhJLtneaUvyh4bnX5sj2sZzTyAXj9S3fagAiDQZyevmCQEAaBXGp
         H7xGwmpCNMTRrGpapXuTU9n2vnAxPd0ZLDKkIkrJMvcu6tJGAivghVLfEOGsqCFTd5mq
         BC8jt7bBhOinQUnpqAeEJGw5GiR3Ti3N9jcoTITUiLiZnr/xjPZFaY0dWg9c9zUJvIhq
         jG0NFFIAFV8VoSOJyt3wL8n3ta0LQjAyGwEqYqyp/iYW5Ly33zaPiOGIQEeRyoPLfyXn
         J83nPGWDi4Zy4lVmvyw0oDvrsqGgoKgiAl3j/+NIDWCWTsoXCcnTVadxEH69VzkynOxa
         q22Q==
X-Gm-Message-State: AOAM533RvrUdCFY2n+0+SXPwKao49dmxoveyhsFkN39+4P3HrsMfYleg
        XX0Nc/+mjnvy4vuuiSxkTg==
X-Google-Smtp-Source: ABdhPJyH21xDb83ZxdLPUb4QrXKTNQVc1SF567yW1Z1lFblWz/ZLai5Qekdd6JEQfTWDOfUjGSuV4Q==
X-Received: by 2002:a05:6808:1599:b0:326:dae2:e49d with SMTP id t25-20020a056808159900b00326dae2e49dmr14488496oiw.110.1652733084634;
        Mon, 16 May 2022 13:31:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z7-20020a4ad1a7000000b0035eb4e5a6d2sm4481085oor.40.2022.05.16.13.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 13:31:23 -0700 (PDT)
Received: (nullmailer pid 3227632 invoked by uid 1000);
        Mon, 16 May 2022 20:31:22 -0000
Date:   Mon, 16 May 2022 15:31:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 05/17] PCI: dwc: Convert to using native IP-core
 versions representation
Message-ID: <20220516203122.GC3209795-robh@kernel.org>
References: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
 <20220503214638.1895-6-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503214638.1895-6-Sergey.Semin@baikalelectronics.ru>
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

On Wed, May 04, 2022 at 12:46:26AM +0300, Serge Semin wrote:
> Since DWC PCIe v4.70a the controller version can be read from the
> PORT_LOGIC.PCIE_VERSION_OFF register. Version is represented in the FourCC
> format [1]. It's standard versioning approach for the Synopsys DWC
> IP-cores. Moreover some of the DWC kernel drivers already make use of it
> to fixup version-dependent functionality (See DWC USB3, Stmicro STMMAC or
> recent DW SPI driver). In order to preserve the standard version
> representation and prevent the data conversion back and forth, we suggest
> to preserve the native version representation in the DWC PCIe driver too
> in the same way as it has already been done in the rest of the DWC
> drivers. IP-core version reading from the CSR will be introduced in the
> next commit together with a simple macro-based API to use it.
> 
> [1] https://en.wikipedia.org/wiki/FourCC
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c    | 12 ++++++------
>  drivers/pci/controller/dwc/pcie-designware.c |  8 ++++----
>  drivers/pci/controller/dwc/pcie-designware.h | 10 +++++++++-
>  drivers/pci/controller/dwc/pcie-intel-gw.c   |  4 ++--
>  drivers/pci/controller/dwc/pcie-tegra194.c   |  2 +-
>  5 files changed, 22 insertions(+), 14 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
