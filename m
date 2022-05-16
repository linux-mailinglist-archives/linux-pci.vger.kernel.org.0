Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F92D529266
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 23:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348356AbiEPU5a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 16:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348265AbiEPU5V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 16:57:21 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C7012AD5;
        Mon, 16 May 2022 13:32:49 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id a22-20020a9d3e16000000b00606aeb12ab6so10860154otd.7;
        Mon, 16 May 2022 13:32:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ItbgX5Ok3d4mUH83iOjcDBrEskdt5/WbXvEVJ35+nXo=;
        b=xaYBYSu1mqVsWtOOjQVGMTvKlv64PKrzHv8q2kUDbWqXi3H5PkcemQEgm3QaivRchu
         xnOvgPkDK7detLNwX0xGMHWv0TPSez7aU3r3zEaKdLc3u91s4LEi03UKIqAF7cKusKyG
         DpUmhH2E1AOLlN4plBciC1WKyt3n7EFhdpTqrSEdLP+lKvTHfHeX7ReQhuC25ILnKrVP
         rUtfpL4hmpIUDURmlUvHoW1HtFk8XUPIHqWs84byfTL3hoB+P+H7lz6fG8VTrJyz3qOW
         propErmSdD1qbZjhZDkuNcWcJCYfGoT4d7bvnAWQX00qqRiVOsAjY4U+XuoJs3YtKtdP
         RDfQ==
X-Gm-Message-State: AOAM532qS5UXAeFViVzFfrbASKaVy8GgF+8HrCBljiknrH4UmMa5/bE4
        f9XiOKsuT6IeNkP26nooRw==
X-Google-Smtp-Source: ABdhPJxJgbgeKLnSxefstRiJzopz/9sqludvNSTtKzMErkkG18IncBMYmAoKYvxRNiH8ngjIODjZ5A==
X-Received: by 2002:a9d:5888:0:b0:606:10d2:2fc1 with SMTP id x8-20020a9d5888000000b0060610d22fc1mr6770760otg.29.1652733168373;
        Mon, 16 May 2022 13:32:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x28-20020a056830245c00b0060603221253sm4214786otr.35.2022.05.16.13.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 13:32:47 -0700 (PDT)
Received: (nullmailer pid 3229981 invoked by uid 1000);
        Mon, 16 May 2022 20:32:46 -0000
Date:   Mon, 16 May 2022 15:32:46 -0500
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
Subject: Re: [PATCH v2 06/17] PCI: dwc: Add IP-core version detection
 procedure
Message-ID: <20220516203246.GD3209795-robh@kernel.org>
References: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
 <20220503214638.1895-7-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503214638.1895-7-Sergey.Semin@baikalelectronics.ru>
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

On Wed, May 04, 2022 at 12:46:27AM +0300, Serge Semin wrote:
> Since DWC PCIe v4.70a the controller version and version type can be read
> from the PORT_LOGIC.PCIE_VERSION_OFF and PORT_LOGIC.PCIE_VERSION_TYPE_OFF
> registers respectively. Seeing the generic code has got version-dependent
> parts let's use these registers to find out the controller version.  The
> detection procedure is executed for both RC and EP modes right after the
> platform-specific initialization. We can't do that earlier since the
> glue-drivers can perform the DBI-related setups there including the bus
> reference clocks activation, without which the CSRs just can't be read.
> 
> Note the CSRs content is zero on the older DWC PCIe controller. In that
> case we have no choice but to rely on the platform setup.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - Move the IP-core version detection procedure call from
>   dw_pcie_ep_init_complete() to dw_pcie_ep_init().
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   |  2 ++
>  .../pci/controller/dwc/pcie-designware-host.c |  2 ++
>  drivers/pci/controller/dwc/pcie-designware.c  | 24 +++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h  |  6 +++++
>  4 files changed, 34 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
