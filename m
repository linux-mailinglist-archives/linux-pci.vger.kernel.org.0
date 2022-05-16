Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A4352930A
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 23:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347745AbiEPVmZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 17:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240045AbiEPVmY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 17:42:24 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B8241FA9;
        Mon, 16 May 2022 14:42:23 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so21937019fac.7;
        Mon, 16 May 2022 14:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=miM/1tXgf+EMfrnuisvw3gl4b5yUK9GRE+3nbD24k6w=;
        b=J2BS1ngDxjlrGHmbE/LPCY9+YtO8oCSwTdW3N+lslWL/66vec8FWgXGnLt/CtBA5R7
         7m9Umn+ScVxiJny0jtxrDgfhDni8E6sDpQFh2KgxMJ018zIzwTVDeTdXOMVHTsvXss9l
         Ssyc5ALkVxXBF22S7ID0gk29gzFDhZSW/EFIy1WErywpE/8jCLoZeUS8K4pHLY06wQAz
         UVn6zUhVLnF4S1pi+YD+Phyjm9gLvfiZ1kZAUTHWaGRPtpXBvd7ZnDturorZ8TP2y9dE
         qyVIodju8b27BtbV7lYIXpo6USDsEqAzEEUJ7sCuO7hXehP0Cw0iVOTMmW9NEOr18p+Y
         y9/A==
X-Gm-Message-State: AOAM5308wzzo/8sxCkZdd+Gj33xdE/eIn5uXcztgDPuww3o9zqMJK7vn
        is+7TYYrxTmTEi3g8QCOKw==
X-Google-Smtp-Source: ABdhPJwlfoPVrO/78d0K4Yx5rMPYvlNVxl1Ly43cRjbP3YvRizhf5gwB83n/72cjgdooIBzjkmASNg==
X-Received: by 2002:a05:6871:1cb:b0:f1:b503:d187 with SMTP id q11-20020a05687101cb00b000f1b503d187mr1673725oad.164.1652737342264;
        Mon, 16 May 2022 14:42:22 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f72-20020a9d03ce000000b0060603221270sm4296518otf.64.2022.05.16.14.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 14:42:21 -0700 (PDT)
Received: (nullmailer pid 3347472 invoked by uid 1000);
        Mon, 16 May 2022 21:42:20 -0000
Date:   Mon, 16 May 2022 16:42:20 -0500
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
Subject: Re: [PATCH v2 15/17] PCI: dwc: Introduce dma-ranges property support
 for RC-host
Message-ID: <20220516214220.GB3296584-robh@kernel.org>
References: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
 <20220503214638.1895-16-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503214638.1895-16-Sergey.Semin@baikalelectronics.ru>
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

On Wed, May 04, 2022 at 12:46:36AM +0300, Serge Semin wrote:
> In accordance with the generic PCIe Root Port DT-bindings the "dma-ranges"
> property has the same format as the "ranges" property. The only difference
> is in their semantics. The "dma-ranges" property describes the PCIe-to-CPU
> memory mapping in opposite to the CPU-to-PCIe mapping of the "ranges"
> property. Even though the DW PCIe controllers are normally equipped with
> internal Address Translation Unit which inbound and outbound tables can be
> used to implement both properties semantics, it was surprise for me to
> discover that the host-related part of the DW PCIe driver currently
> supports the "ranges" property only while the "dma-ranges" windows are
> just ignored. Having the "dma-ranges" supported in the driver would be
> very handy for the platforms, that don't tolerate the 1:1 CPU-PCIe memory
> mapping and require customized the PCIe memory layout. So let's fix that
> by introducing the "dma-ranges" property support.
> 
> First of all we suggest to rename the dw_pcie_prog_inbound_atu() method to
> dw_pcie_prog_ep_inbound_atu() and create a new version of the
> dw_pcie_prog_inbound_atu() function. Thus we'll have two methods for RC
> and EP controllers respectively in the same way as it has been developed
> for the outbound ATU setup methods.
> 
> Secondly aside with the memory window index and type the new
> dw_pcie_prog_inbound_atu() function will accept CPU address, PCIe address
> and size as its arguments. These parameters define the PCIe and CPU memory
> ranges which will be used to setup the respective inbound ATU mapping. The
> passed parameters need to be verified against the ATU ranges constraints
> in the same way as it is done for the outbound ranges.
> 
> Finally the DMA-ranges detected for the PCIe controller need to be
> converted into the inbound ATU entries during the host controller
> initialization procedure. It will be done in the framework of the
> dw_pcie_iatu_setup() method. Note before setting the inbound ranges up we
> need to disable all the inbound ATU entries in order to prevent unexpected
> PCIe TLPs translations defined by some third party software like
> bootloader.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   |  4 +-
>  .../pci/controller/dwc/pcie-designware-host.c | 32 ++++++++++-
>  drivers/pci/controller/dwc/pcie-designware.c  | 57 ++++++++++++++++++-
>  drivers/pci/controller/dwc/pcie-designware.h  |  6 +-
>  4 files changed, 90 insertions(+), 9 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
