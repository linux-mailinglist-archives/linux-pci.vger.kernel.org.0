Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E93152929C
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 23:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349381AbiEPVM4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 17:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350114AbiEPVMM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 17:12:12 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845B9B4B5;
        Mon, 16 May 2022 14:01:57 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id i66so20104892oia.11;
        Mon, 16 May 2022 14:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2Ok8Rgh5k5giQQ7VokGXvCm4kz6pM++MXJZ7vVWW924=;
        b=zbd/5+UhksviBed/Z5QI24T4UajYMZ/ye/ymUTdkryk0iX/V4uPa8f95KXtfxG7Ypg
         pbfQXYWguXlElBsXmQBflqCAH+62KUhrOXxwFf5aftp20wrKUDJ0rTpkwJDxAmNLcFtQ
         l8TP4MlCAV6P8/Wme5Jnt5UGbadoO39B6Ny6owMmX9hId3YCABHqBE2gDOJnYZHU68hK
         i9lcdwgLTWQb8VFAv1nuksBWW5zpd+gItP62U45TmVn1EhQwHMrI8qpat0Hy2FHGGOMW
         52v0wTd4o2veGZysyttzyfG7XZiD+x27u26kHRajDQhqhU6hRqsH3ezhH7t+z008PY3v
         KP9A==
X-Gm-Message-State: AOAM530YqtfptrEgQf1btahxSdm7ve6VF35Nmj1sjg8+sEB14V/BqMdW
        /frHmn/iKb8nr/bqB+UX1g==
X-Google-Smtp-Source: ABdhPJwuZSwvSmcukd4UuOWWaX3nmI7sBx7mXyvnpspGDt9YChZJCyMKliPdy3dTZVnej56J+hT5Qw==
X-Received: by 2002:aca:ac8c:0:b0:326:13f6:5f5c with SMTP id v134-20020acaac8c000000b0032613f65f5cmr9261961oie.287.1652734916537;
        Mon, 16 May 2022 14:01:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f25-20020a0568301c3900b006060322125csm4440786ote.44.2022.05.16.14.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 14:01:55 -0700 (PDT)
Received: (nullmailer pid 3279738 invoked by uid 1000);
        Mon, 16 May 2022 21:01:54 -0000
Date:   Mon, 16 May 2022 16:01:54 -0500
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
Subject: Re: [PATCH v2 12/17] PCI: dwc: Add iATU regions size detection
 procedure
Message-ID: <20220516210154.GH3209795-robh@kernel.org>
References: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
 <20220503214638.1895-13-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503214638.1895-13-Sergey.Semin@baikalelectronics.ru>
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

On Wed, May 04, 2022 at 12:46:33AM +0300, Serge Semin wrote:
> Depending on the DWC PCIe RC/EP/DM IP-core configuration parameters the
> controllers can be equipped not only with various number of inbound and
> outbound iATU windows, but with varied regions settings like alignment
> (which is also the minimum window size), minimum and maximum sizes. So to
> speak if internal ATU is enabled for the denoted IP-cores then the former
> settings will be defined by the CX_ATU_MIN_REGION_SIZE parameter while the
> later one will be determined by the CX_ATU_MAX_REGION_SIZE configuration
> parameter. Anyway having these parameters used in the driver will help to
> verify whether the requested inbound or outbound memory mappings can be
> fully created. Currently the driver doesn't perform any corresponding
> checking.
> 
> Note 1. The extended iATU regions have been supported since DWC PCIe
> v4.60a. There is no need in testing the upper limit register availability
> for the older cores.
> 
> Note 2. The regions alignment is determined with using the fls() method
> since the lower four bits of the ATU Limit register can be occupied with
> the Circular Buffer Increment setting, which can be initialized with
> zeros.
> 
> The (dma-)ranges verification will be added a bit later in one of the next
> commits.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 33 +++++++++++++++++---
>  drivers/pci/controller/dwc/pcie-designware.h |  2 ++
>  2 files changed, 31 insertions(+), 4 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
