Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352284EB011
	for <lists+linux-pci@lfdr.de>; Tue, 29 Mar 2022 17:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238400AbiC2PSQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Mar 2022 11:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237045AbiC2PSQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2022 11:18:16 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652232487AB;
        Tue, 29 Mar 2022 08:16:33 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-d6ca46da48so18999423fac.12;
        Tue, 29 Mar 2022 08:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GOmwA8PkXAmEMhCl/eM+BoBmvEJnbfexIfv3dNQaXLc=;
        b=WL8hGxJkggDPXaeNJI6olgykY4Z5x91kAR/RSeovPLQQl8e/4Mb4m7Orl1LXyb0iSb
         ktUi3FkK1YfusdG/pEV/8uEpbGYwJl5qYgg/0cF2XQ0OhikuxxEbGSIHZch8Tl/TeJHB
         bMTN9psQitkwl8JplJqYl7C1mqIbZSK6M58kZ/7J/Os1UY5vMhr2zVqOi1aKM33P9c/+
         0HPLCDeYPg3z6DtFKtVupy/ACOP8OHtRSQUpVFm5U6nfCGukfVQQjXU9n6uAdUI2QiE0
         /Vr2fGktol697DEGkJx8DTGGEMXMXLpkEeXirzH35BmnmHYdrrXGAFvibab3Xgr+c8Zx
         rtQA==
X-Gm-Message-State: AOAM530Hf/uLH4vSD6uY9Q6SW4+JkU56z13fI7Trd/5QGS9zv0QgurqW
        Cc0Mpd9w4gKvTa1WMGT33w==
X-Google-Smtp-Source: ABdhPJwaWGq6nfZnYG0ZXxAfzvvkKN6buxBFEJIOP/mrfJItR0nzfrVGT65ciRrLISmrOWqqNlVlPA==
X-Received: by 2002:a05:6870:6327:b0:df:b6f:4894 with SMTP id s39-20020a056870632700b000df0b6f4894mr85998oao.4.1648566992334;
        Tue, 29 Mar 2022 08:16:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ga14-20020a056870ee0e00b000ddcf36aa56sm8165623oab.48.2022.03.29.08.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 08:16:16 -0700 (PDT)
Received: (nullmailer pid 692700 invoked by uid 1000);
        Tue, 29 Mar 2022 15:16:15 -0000
Date:   Tue, 29 Mar 2022 10:16:15 -0500
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
Subject: Re: [PATCH 08/16] PCI: dwc: Drop inbound iATU types enumeration -
 dw_pcie_as_type
Message-ID: <YkMiv2FmeSXvLHOT@robh.at.kernel.org>
References: <20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru>
 <20220324013734.18234-9-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324013734.18234-9-Sergey.Semin@baikalelectronics.ru>
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

On Thu, Mar 24, 2022 at 04:37:26AM +0300, Serge Semin wrote:
> There is no point in having an enumeration declared in the driver for the
> PCIe end-point. First of all it's redundant since the driver already has a
> set of macro declared which describe the available in/out iATU types, thus
> having an addition abstraction just needlessly complicates the code.
> Secondly checking the passed iATU type for validity within a single driver
> is pointless since the driver is supposed to be consistent by its nature.
> Finally the outbound iATU type isn't encoded by the denoted enumeration,
> thus giving a false impression that the in and out iATU types are
> unrelated while they are the same. So to speak let's drop the redundant
> dw_pcie_as_type enumeration replacing it with the direct iATU type usage.
> 
> While at it, since we are touching the iATU inbound regions config methods
> anyway, let's fix the arguments order so the type would be followed by the
> address-related parameters. Thus the inbound and outbound iATU setup
> methods will look alike. That shall improve the code readability a bit.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 21 +++++------
>  drivers/pci/controller/dwc/pcie-designware.c  | 35 +++----------------
>  drivers/pci/controller/dwc/pcie-designware.h  |  9 +----
>  3 files changed, 15 insertions(+), 50 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
