Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA3B54A06E
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 22:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346374AbiFMUzo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 16:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352282AbiFMUyU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 16:54:20 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4D52AC7E;
        Mon, 13 Jun 2022 13:22:49 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id k24so9117843oij.2;
        Mon, 13 Jun 2022 13:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=csq1Brwm85wDHHJ8F9+1jbltwVssfeqZqd990Q48SpU=;
        b=qaNg2S95U51E0CwSLWpzmwS/Uv5mpx9Ih6OsImtj7uriLIQKoxlA2qU87E2q6MKf0z
         mfxum0188Ec8lVdeLj1G/GoNG4wDIft9VsGKZzqZ7qHIlFAaIl9GCJQZL+pJYE6NoMgY
         d1mFRtH3Fzvua24fqY7YPa3o1Dto00qh2pwZ9uDYR+/bl5wb+oXXrUZWd3Pf0+GR/fIH
         vk5HPW14wpH9R0T4gfwrcciFC+Bd4EJE530DzAFeCPv3NRIt8zqjOCh74kPw5DP2czRm
         PhuZCEFkB0Ga07ISvZvcr6t2LB2AkqiokQ5+j2iiBMesVYHaJ1WTHtIzqUEiHRAKDNfH
         g4ZA==
X-Gm-Message-State: AOAM530RfvEhJvSbVVw3c5gjrzyMcpnCgkZNuY1B7QutHaoJB5Xe46gd
        dLjgEMOxJQwahlb4/8ZvFw==
X-Google-Smtp-Source: ABdhPJwqh+0nizUXE7cZXmebZZSj3Swb9VgtxqJ6GMc6OwHtSS1GC+AfPk0mzNzWIHxUe0lk4HuWbg==
X-Received: by 2002:aca:1709:0:b0:32e:9220:a7f with SMTP id j9-20020aca1709000000b0032e92200a7fmr289077oii.120.1655151769177;
        Mon, 13 Jun 2022 13:22:49 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:20d2:bb97:4381:7341:60ed:a4a1])
        by smtp.gmail.com with ESMTPSA id b14-20020a4a9bce000000b0041bdf09d95dsm4202116ook.3.2022.06.13.13.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 13:22:48 -0700 (PDT)
Received: (nullmailer pid 19943 invoked by uid 1000);
        Mon, 13 Jun 2022 20:22:23 -0000
Date:   Mon, 13 Jun 2022 14:22:23 -0600
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
Subject: Re: [PATCH v4 10/18] PCI: dwc: Convert Link-up status method to
 using dw_pcie_readl_dbi()
Message-ID: <20220613202223.GF4188875-robh@kernel.org>
References: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
 <20220610082535.12802-11-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610082535.12802-11-Sergey.Semin@baikalelectronics.ru>
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

On Fri, Jun 10, 2022 at 11:25:26AM +0300, Serge Semin wrote:
> While the rest of the generic DWC PCIe code is using the dedicated IO-mem
> accessors, the dw_pcie_link_up() method for some unobvious reason directly
> calls readl() to get PortLogic.DEBUG1 register content. Since the way the
> dbi-bus is accessed can be platform-specific let's replace the direct dbi
> memory space read procedure with the readl-wrapper invocation. Thus we'll
> have a slightly more generic dw_pcie_link_up() method.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
