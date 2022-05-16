Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B72D5292F3
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 23:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347324AbiEPVfL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 17:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiEPVfK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 17:35:10 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E72403CA;
        Mon, 16 May 2022 14:35:09 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id q10so20236079oia.9;
        Mon, 16 May 2022 14:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QRRTVmbsOznarMBJuHotqu041qdpgdvGYlyrPqo5TcQ=;
        b=6Twa4pjszQmTOk6HhVrTszWOhTVCNF40hi2fL+B3uyA1J/EBDNqtAbk/Ia6PINACaG
         c6eJl9e2HPnEgmwoAGSTOzZ8/VAczv8+vviT9lPjKrCD08PNm3YZmN3LFoWLNSpOnNHB
         9VeV0JFPhULfcOIZqv5OI66hqkdPtesDlKBYzOHcR8NdjvSvEVsIlYhEEVoPWwHWhouY
         +gaqZt/IWOnCF8qrnNXuAdzZwOkAdNQPNcYSlMhpfL15EYt9jfhZK+ah4dwFmsrq0jaq
         pHZ0mo0OnAXYEqxqn9ftkX9nYlwp5acyRqYpCnlYzWEhIQSI9I5n05VrOHFtMSaf0Qf4
         rPIQ==
X-Gm-Message-State: AOAM533woWAr1LYfLRkg44f8tZfzCq1iNKQFxlv2S3rUfgUP63TmO8JB
        si51M8Hqjvi0Je0AZi6y0Q==
X-Google-Smtp-Source: ABdhPJyg/bljvc3L69umiFFD/pWAfJ6St3S1czd9cyg99pTSQijW+nCzk8jOObbUB2RQvhUXn7OvfQ==
X-Received: by 2002:aca:4b95:0:b0:326:1179:5414 with SMTP id y143-20020aca4b95000000b0032611795414mr14718839oia.256.1652736908283;
        Mon, 16 May 2022 14:35:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i20-20020a056870345400b000f17905320esm4356783oah.13.2022.05.16.14.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 14:35:07 -0700 (PDT)
Received: (nullmailer pid 3336000 invoked by uid 1000);
        Mon, 16 May 2022 21:35:06 -0000
Date:   Mon, 16 May 2022 16:35:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/17] PCI: dwc: Check iATU in/outbound ranges setup
 methods status
Message-ID: <20220516213506.GA3296584-robh@kernel.org>
References: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
 <20220503214638.1895-15-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503214638.1895-15-Sergey.Semin@baikalelectronics.ru>
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

On Wed, May 04, 2022 at 12:46:35AM +0300, Serge Semin wrote:
> Let's make the DWC PCIe RC/EP safer and more verbose for the invalid or
> failed inbound and outbound iATU windows setups. Needless to say that
> silently ignoring iATU regions setup errors may cause unpredictable
> errors. For instance if for some reason a cfg or IO window fails to be
> activated, then any CFG/IO requested won't reach target PCIe devices and
> the corresponding accessors will return platform-specific random values.
> 
> First of all we need to convert dw_pcie_ep_outbound_atu() method to check
> whether the specified outbound iATU range is successfully setup. That
> method is called by the pci_epc_ops.map_addr callback. Thus we'll make the
> EP-specific CPU->PCIe memory mappings saver.
> 
> Secondly since the iATU outbound range programming method now returns the
> operation status, it will be handy to take that status into account in the
> pci_ops.{map_bus,read,write} methods. Thus any failed mapping will be
> immediately noticeable by the PCIe CFG operations requesters.
> 
> Finally we need to convert the dw_pcie_setup_rc() method to returning the
> operation status, since the iATU outbound ranges setup procedure may now
> fail. It will be especially handy in case if the DW PCIe RC DT-node has
> invalid/unsupported (dma-)ranges property. Note since the suggested
> modification causes having too wide code indentation, it is reasonable
> from maintainability and readability points of view to move the outbound
> ranges setup procedure in the separate function.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   |   9 +-
>  .../pci/controller/dwc/pcie-designware-host.c | 149 ++++++++++++------
>  drivers/pci/controller/dwc/pcie-designware.h  |   5 +-
>  drivers/pci/controller/dwc/pcie-intel-gw.c    |   6 +-

I worry that this could regress some platforms that happened to work 
before. But only one way to find out...

Reviewed-by: Rob Herring <robh@kernel.org>

