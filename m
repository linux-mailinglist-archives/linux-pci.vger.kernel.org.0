Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E90E4EB0B0
	for <lists+linux-pci@lfdr.de>; Tue, 29 Mar 2022 17:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238718AbiC2PdF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Mar 2022 11:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238674AbiC2PdD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2022 11:33:03 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF9611629D;
        Tue, 29 Mar 2022 08:31:20 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id w127so19370040oig.10;
        Tue, 29 Mar 2022 08:31:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PvY0F/be7YTKOMJTR8VDW/v15Xk3QY2EesChHl1hKgI=;
        b=BStzDRiObUq4ZNMr+2B8Ft9O2kOEvb0Vh0IRqLw+3/zqJPnsS9zbRak7FfS21RShfy
         xZBeD8gB8rfIHQ9ZA5TiGROio8Gtb5HdW47nWBwt6RRTTOWVvNz/ak5JGO6jcFC3M50Q
         8pxK72udinpfFz3UnCdHVT/E/qJswwnFWijfhsMvTgN6eK2kymuToPhkBLg4SA/JsyPR
         y9zFpW7zszfECnM2AgfKCsmqOahN9IsKPu3C7CdFHdmXHBCewwOUJYC0CLyUu04SYkNu
         LOQCxU5yOMTgSFhsex1zZqdpRoXiDWohPp5MXoeOATaWQwnK+3VkJbgKVORU2gqXbk1b
         uY5Q==
X-Gm-Message-State: AOAM530zmBn48LKMswdB4a0iX8O/WnFvqhP+uYS+GAoTMUz4jXrd4JHu
        dIEAHMtl5TRDa2fgBGt7Iw==
X-Google-Smtp-Source: ABdhPJwjYUE9YiYwrmM3u4QfcBz+PfqHfMHxhsovn8+GB23SpgirybkYplWaog51nuRKzWOnWKyWnw==
X-Received: by 2002:a05:6808:118d:b0:2cc:ef90:3812 with SMTP id j13-20020a056808118d00b002ccef903812mr115228oil.48.1648567879795;
        Tue, 29 Mar 2022 08:31:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 190-20020a4a0dc7000000b003244ae0bbd5sm8659861oob.7.2022.03.29.08.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 08:31:19 -0700 (PDT)
Received: (nullmailer pid 717474 invoked by uid 1000);
        Tue, 29 Mar 2022 15:31:18 -0000
Date:   Tue, 29 Mar 2022 10:31:18 -0500
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
Subject: Re: [PATCH 10/16] PCI: dwc: Drop iATU regions enumeration -
 dw_pcie_region_type
Message-ID: <YkMmRrF0e7WyvKsO@robh.at.kernel.org>
References: <20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru>
 <20220324013734.18234-11-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324013734.18234-11-Sergey.Semin@baikalelectronics.ru>
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

On Thu, Mar 24, 2022 at 04:37:28AM +0300, Serge Semin wrote:
> There is no point in having the dw_pcie_region_type enumeration for almost
> the same reasons as it was stated for dw_pcie_as_type. First of all it's
> redundant since the driver already has a set of macro declared which
> describe the possible inbound and outbound iATU regions. Having an
> addition abstraction just needlessly complicates the code. Secondly
> checking the region index passed to the dw_pcie_disable_atu() method for
> validity is pointless since the erroneous situation will be just
> ignored in the current code implementation. So to speak let's drop the
> redundant dw_pcie_region_type enumeration replacing it with the direct
> iATU direction macro usage.
> 
> While at it we suggest to convert the dw_pcie_disable_atu() method to
> being more consistent with the dw_pcie_readl_atu{_ib}() and
> dw_pcie_readl_atu{_ob}() functions by having the direction parameter
> specified ahead of the region index. Thus the code will be a little bit
> more pleasant to read.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c  |  4 ++--
>  .../pci/controller/dwc/pcie-designware-host.c    |  2 +-
>  drivers/pci/controller/dwc/pcie-designware.c     | 16 +---------------
>  drivers/pci/controller/dwc/pcie-designware.h     |  9 +--------
>  4 files changed, 5 insertions(+), 26 deletions(-)

This answers my question. I would have expected this to come before the 
previous patch, but if it's easier to do it this way it's fine.

Reviewed-by: Rob Herring <robh@kernel.org>
