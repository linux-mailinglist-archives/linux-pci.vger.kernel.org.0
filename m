Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C1F52924F
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 23:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348468AbiEPU7V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 16:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348744AbiEPU7L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 16:59:11 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E884E3B8;
        Mon, 16 May 2022 13:33:58 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so21707980fac.7;
        Mon, 16 May 2022 13:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UpweZgNa0hLyc/A6Rf8VvzxtaDPXp6xvIcWgr8Tj7kc=;
        b=a4z52TCSgYOzZ1cPLnaxO5kLPSgVELLjXg+G4Pp9MIV0zYCRQ7nddGrMf7YNGyqsxV
         CyFsWvpilr9ZE6zGdPgTvhoc5pSDpqWGKMe9f0R6xTj5X6HIdrDVi6+odm9yeQkoAoLi
         PBTh6PaUlEevyFd5zTbTbPTt924qc/Ut/QiJPEgfTtN0wnFf+LyLQGbIjOzS9Wk5X16W
         232zvIcYjUy7JuZl/PsUdnroG2ssXAfFkAvunTmQBqLEIj0cm4IpPYODLpMXV0Q7m+OW
         LXpdxq8zr/uaydwuqBna8bYInBbfaBto1Ig1vodzsKathRmLwy+TBCtruDCG3BqGyeXC
         ZBoQ==
X-Gm-Message-State: AOAM530Vkm8J/GqxDEw3S+/j5t2Iyouaz/L1haUBNJ2QP9XHU/rCx4SB
        ZtrekRO8i8iYP/jLjuVgFg==
X-Google-Smtp-Source: ABdhPJzEdV42C2X0YEgqxKDvXZyDgLwO20FOCOruB+PdrGeZ8jFuDL06Jwp6831Kfl8Pr+HgeRuvbg==
X-Received: by 2002:a05:6870:7006:b0:f1:b696:9d90 with SMTP id u6-20020a056870700600b000f1b6969d90mr1270151oae.230.1652733237916;
        Mon, 16 May 2022 13:33:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r129-20020acada87000000b00325d7b6cab8sm4194137oig.16.2022.05.16.13.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 13:33:57 -0700 (PDT)
Received: (nullmailer pid 3232168 invoked by uid 1000);
        Mon, 16 May 2022 20:33:56 -0000
Date:   Mon, 16 May 2022 15:33:56 -0500
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
Subject: Re: [PATCH v2 07/17] PCI: dwc: Introduce Synopsys IP-core
 versions/types interface
Message-ID: <20220516203356.GE3209795-robh@kernel.org>
References: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
 <20220503214638.1895-8-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503214638.1895-8-Sergey.Semin@baikalelectronics.ru>
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

On Wed, May 04, 2022 at 12:46:28AM +0300, Serge Semin wrote:
> Instead of manual DW PCIe data version field comparison let's use a handy
> macro-based interface in order to shorten out the statements, simplify the
> corresponding parts, improve the code readability and maintainability in
> perspective when more complex version-based dependencies need to
> implemented. Similar approaches have already been implemented in the DWC
> USB3 and DW SPI drivers (though with some IP-core evolution specifics).
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c    |  2 +-
>  drivers/pci/controller/dwc/pcie-designware.c |  8 ++++----
>  drivers/pci/controller/dwc/pcie-designware.h | 15 +++++++++++++++
>  3 files changed, 20 insertions(+), 5 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
