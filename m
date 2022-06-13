Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC0654A069
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 22:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347719AbiFMUzj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 16:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352261AbiFMUyT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 16:54:19 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A5E2A94B;
        Mon, 13 Jun 2022 13:22:35 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id 4-20020a4a1404000000b0041bfe1a4cffso762050ood.0;
        Mon, 13 Jun 2022 13:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0cU1N9A1T1qgBn1lKK9HaI+TY1k8IeUOqJphJj6+O1w=;
        b=WyAHgPnyMiXSovZ+PgOx9TNJBxl0psJAyTOykoAE69UXoRQEdOhXWzCXHHzUPLrC5O
         n3/mq+TsUfV/wufIyQpg3IObdiduNo6dBn1Jak6XyVrLvthI2Wk99qdDH+sL/7f6dk1K
         EFSXQ5BgwFQ3Wx2T6A34RXoaWK9pHiOurGgQMpHoT8WypTlmHK3zL415+Wpk6mXk0Bi8
         DGBa+KNNhffAJ+EZt+AQjrrFAQFp9UmHoep+hb0DJb99cUl0FSR0MzndDPVUf1Te9TTV
         kEnlaKIY6PHk6TW2fDexZxZJhF2225dXZ1vuJQpVlENeaiVWYjSWi95I7qyaSp7RYNnk
         b1+Q==
X-Gm-Message-State: AOAM5330ixY22sdKfUYfnPBe6pLYQf7jtAVjmIUvbLf5gFOCvtE3TyHo
        ADS2G6PS/I4jyDufJtqfVQ==
X-Google-Smtp-Source: ABdhPJwT2XUz5Smcb7K4j/V2wogweq9iNjCOSqWRPw8iUB34ic13DPfDUgWmQ0B2MNr30iIYNLb1mQ==
X-Received: by 2002:a4a:378e:0:b0:41b:8cb6:b7bb with SMTP id r136-20020a4a378e000000b0041b8cb6b7bbmr614495oor.51.1655151754293;
        Mon, 13 Jun 2022 13:22:34 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:20d2:bb97:4381:7341:60ed:a4a1])
        by smtp.gmail.com with ESMTPSA id nl7-20020a056871458700b000f5e89a9c60sm4471001oab.3.2022.06.13.13.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 13:22:33 -0700 (PDT)
Received: (nullmailer pid 17434 invoked by uid 1000);
        Mon, 13 Jun 2022 20:20:47 -0000
Date:   Mon, 13 Jun 2022 14:20:47 -0600
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
Subject: Re: [PATCH v4 09/18] PCI: dwc: Discard IP-core version checking on
 unrolled iATU detection
Message-ID: <20220613202047.GE4188875-robh@kernel.org>
References: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
 <20220610082535.12802-10-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610082535.12802-10-Sergey.Semin@baikalelectronics.ru>
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

On Fri, Jun 10, 2022 at 11:25:25AM +0300, Serge Semin wrote:
> It's pretty much pointless. Even though unrolled version of the internal
> ATU has been indeed available since DWC PCIe v4.80a IP-core, there is no
> guarantee it was enabled during the IP-core configuration (Synopsys
> suggests to contact the Solvnet support for guidance of how to do that for
> the newer IP-cores). So the only reliable way to find out the unrolled
> iATU feature availability is indeed to check the iATU viewport register
> content. In accordance with the reference manual [1] if the register
> doesn't exist (unrolled iATU is enabled) it's content is fixed with
> 0xff-s, otherwise it will contain some zeros. So we can freely drop the
> IP-core version checking in this matter then and use the
> dw_pcie_iatu_unroll_enabled() method only to detect whether iATU/eDMA
> space is unrolled.

Are you sure that pre v4.80a, it is safe to read the register address? 
Seems unlikely that the all 1s guarantee would be valid before the 
feature ever existed. 


> [1] DesignWare Cores, PCI Express Controller, Register Desciptions,
> v.4.90a, December 2016, p.855
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Assuming this works,

Reviewed-by: Rob Herring <robh@kernel.org>
