Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93ED54CEE9
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 18:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241735AbiFOQmp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 12:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345484AbiFOQmZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 12:42:25 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8A54BFF8;
        Wed, 15 Jun 2022 09:42:24 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id y17so9154136ilj.11;
        Wed, 15 Jun 2022 09:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mY4XbSfWdaFFfy3UDag+oGx47P1bR+Hld3oKCNq09XM=;
        b=oomnBEsR16xPR8Eh9RssIeALxsFNdX8rflmj2AsQ/UKvw/U5PCQZIowvi6o5g4hv0X
         BU20hLsTkIgzA2TUdvTeRSXc9xSUKlUbgFoCtbmR7yDe5I+7OByUXCm7UDqsURZkqULV
         EQGcDtd8eCLPArV6TXBLFP833dzF58pP1eFYyRu8Pr7DUbu4xrJrTzpjMaHCTPMod0cb
         zSB8OVDRpwwxDm3a4d9zRyar6ixydtZLlv69yl0nDkaDSEVYI+1owX0zDE0+iIIQ9Xhl
         af26HxpwL+HtoPFBR0v2CoJsWBxqLRpAppFZ+vdO4YgwSQUsH0R+y/Avn/Uq9kvZS9Gk
         PxbA==
X-Gm-Message-State: AJIora95Om6ysnaRzjyPR5RH1ZVzE5vT71JZdzKn5Stj+K140S0rCWWf
        5MxdYzrfLuBOX4+fE1d58A==
X-Google-Smtp-Source: AGRyM1viS9nUzw6OShRYC0s9hfmdebkT2EMNyQT6WMZ5n0VtAe31H5pNs+WTWHA6Ns2yAqG+QohaQg==
X-Received: by 2002:a92:d849:0:b0:2d5:43c0:f9f6 with SMTP id h9-20020a92d849000000b002d543c0f9f6mr408744ilq.25.1655311343706;
        Wed, 15 Jun 2022 09:42:23 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id p22-20020a056638191600b0032b74686763sm6319874jal.76.2022.06.15.09.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 09:42:23 -0700 (PDT)
Received: (nullmailer pid 1415059 invoked by uid 1000);
        Wed, 15 Jun 2022 16:42:21 -0000
Date:   Wed, 15 Jun 2022 10:42:21 -0600
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
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 13/17] PCI: dwc: Introduce generic controller
 capabilities interface
Message-ID: <20220615164221.GA1413880-robh@kernel.org>
References: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
 <20220610085706.15741-14-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610085706.15741-14-Sergey.Semin@baikalelectronics.ru>
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

On Fri, Jun 10, 2022 at 11:57:01AM +0300, Serge Semin wrote:
> Since in addition to the already available iATU unrolled mapping we are
> about to add a few more DW PCIe platform-specific capabilities (CDM-check
> and generic clocks/resets resources) let's add a generic interface to set
> and get the flags indicating their availability. The new interface shall
> improve maintainability of the platform-specific code.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Note the DW_PCIE_CAP_IATU_UNROLL macro is intentionally set to 1 since
> being added afterwards capability will be more suitable to be identified
> with position 0.
> 
> Changelog v3:
> - This is a new patch created on v3 lap of the series.
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 11 ++++++-----
>  drivers/pci/controller/dwc/pcie-designware.h | 12 +++++++++++-
>  2 files changed, 17 insertions(+), 6 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
