Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E695291E6
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 22:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242600AbiEPUpQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 16:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348190AbiEPUo0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 16:44:26 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34854A923;
        Mon, 16 May 2022 13:21:24 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-e656032735so21755021fac.0;
        Mon, 16 May 2022 13:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7BWSrE/CAz6evwVBMIyCTX6tuP5t5HfKZ2CcvdrLUcg=;
        b=5mb/+I2Z3EDr1DoQus+g7rKSyKQH5yXxif9eZdVusTb6YcdmPmg/EivuYRdR7VIVwM
         wqCmTvyO90BrmdRm73TCqTg0Kwn8F3oSKVQXO2ARgQWOLJ5DPuw4YrT4qxo3Oxnq4rtH
         MVthOVdYmZCSw012cQy9EUDgnCnzUQxdc9ySQ1OnSmEStrxaawdBsojiNhYJeIMON25B
         HeH0zptFjM9eK0afEMb8c/LeREkZL/NC16ass5ncSCIhjyI31o0R691PUJYjkYkqohol
         Pjxw8JoBNMFNKdGx7cx1x00j2nxAlpaZytIrhHedid5vwZOa0K9dxUiDOtBmfn5so69+
         a1eg==
X-Gm-Message-State: AOAM533dGIFgaWGzYynRgmzhv4G0hLbpxOHCmnXYIZuLoCY7Jb8LXlcd
        6uQ00it8RUzhd2SVjgDn0Q==
X-Google-Smtp-Source: ABdhPJx86+zrTLxoRzsaXuUGjynUBidMelaIYYh+bDguzwxBJY8na2tPfh4198gC066v4n4xVCDcSw==
X-Received: by 2002:a05:6870:80ca:b0:f1:8fad:d9d1 with SMTP id r10-20020a05687080ca00b000f18fadd9d1mr5193876oab.125.1652732484033;
        Mon, 16 May 2022 13:21:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z3-20020a05687041c300b000f174840b4fsm4607481oac.17.2022.05.16.13.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 13:21:23 -0700 (PDT)
Received: (nullmailer pid 3210266 invoked by uid 1000);
        Mon, 16 May 2022 20:21:22 -0000
Date:   Mon, 16 May 2022 15:21:22 -0500
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
Subject: Re: [PATCH v2 04/17] PCI: dwc: Detect iATU settings after getting
 "addr_space" resource
Message-ID: <20220516202122.GA3209795-robh@kernel.org>
References: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
 <20220503214638.1895-5-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503214638.1895-5-Sergey.Semin@baikalelectronics.ru>
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

On Wed, May 04, 2022 at 12:46:25AM +0300, Serge Semin wrote:
> The iATU detection procedure was introduced in the commit 281f1f99cf3a
> ("PCI: dwc: Detect number of iATU windows"). A bit later the procedure
> execution was moved to Host/EP-specific methods in the framework of commit
> 8bcca2658558 ("PCI: dwc: Move iATU detection earlier"). The later
> modification wasn't done in the most optimal way since the "addr_space"
> CSR region resource doesn't depend on anything detected in the
> dw_pcie_iatu_detect() method. Thus the detection can be postponed to be
> executed after the resource request which can fail and make the detection
> pointless. It will be also helpful for the dw_pcie_ep_init() method
> readability since we are about to add the IP-core version and eDMA module
> (a bit later) detection procedures.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - This is a new patch added on v2 iteration of the series.
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
