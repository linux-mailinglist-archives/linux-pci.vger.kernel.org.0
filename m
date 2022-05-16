Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846325292AF
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 23:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiEPVOV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 17:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349324AbiEPVNF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 17:13:05 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AF262E0;
        Mon, 16 May 2022 14:07:06 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so21824727fac.7;
        Mon, 16 May 2022 14:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g5ElK6ZUv3IlTkOKwmbjZBjdyLhiaT+6YPwbkUnt/b0=;
        b=2iHDLlU9nZeRji7Pbzrk6O770InKtsgoDBAnAIKl9zEBiFRUliXjLOhHbTkfJ33qJj
         YgckLFTXW03/q7sihvi55pMvpZtm6lp0QEAZPeW11EA3B1VIAHmhlQ2qSaxy4xa6ytMk
         BrVa3OPYXErd4VJbGy3335s/McJG63mAOd1epehjsrzsJ3tUFVFXfsADS+dPU+svlVhm
         qcna+hlClnqM0Ym5j0UezhG1Y6FiKFQY6ck3VgbBK+Ocf8XMpHi9pJmUe+VH9/jdDOj2
         7uRnKoDLHZsIU6n5aKbeVKL0JLdRuLMgHkX2VyghPD7WCL96ZnUF/EN2uGTNv9g0MJBD
         zDaQ==
X-Gm-Message-State: AOAM532ackb8Q+RWMr9BiBfTZNPt3b60gB5FqOC+oQgM6o/skx4O+6NF
        MPz3vkPT7r9hQw9ugMF67w==
X-Google-Smtp-Source: ABdhPJxR3Ubx3Tir7o7REwxLjWhR3yTYmGWqK+DoK0T4PDk1e6XpCR9M13GY+tw6k+oxgKHfFHxjmg==
X-Received: by 2002:a05:6870:d6aa:b0:f1:8277:3026 with SMTP id z42-20020a056870d6aa00b000f182773026mr6826089oap.200.1652735225844;
        Mon, 16 May 2022 14:07:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r196-20020acaa8cd000000b00325cda1ffa5sm4175145oie.36.2022.05.16.14.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 14:07:05 -0700 (PDT)
Received: (nullmailer pid 3288693 invoked by uid 1000);
        Mon, 16 May 2022 21:07:04 -0000
Date:   Mon, 16 May 2022 16:07:04 -0500
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
Subject: Re: [PATCH v2 13/17] PCI: dwc: Verify in/out regions against iATU
 constraints
Message-ID: <20220516210704.GI3209795-robh@kernel.org>
References: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
 <20220503214638.1895-14-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503214638.1895-14-Sergey.Semin@baikalelectronics.ru>
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

On Wed, May 04, 2022 at 12:46:34AM +0300, Serge Semin wrote:
> Since the DWC PCIe driver private data now contains the iATU inbound and
> outbound regions constraints info like alignment, minimum and maximum
> limits, we can use them to make the in- and outbound iATU regions setup
> methods more strict to the ranges a callee tries to specify.  That will
> give us the safer dw_pcie_prog_outbound_atu(),
> dw_pcie_prog_ep_outbound_atu() and dw_pcie_prog_inbound_atu() functions.
> 
> First of all let's update the outbound ATU entries setup methods to
> returning the operation status. The methods will fail either in case if
> the range is failed to be activated or the passed region doesn't fulfill
> iATU constraints. Secondly the passed to the
> dw_pcie_prog_{ep_}outbound_atu() methods region-related parameters are
> verified against the detected iATU regions constraints. In particular the
> region limit address must not overflow the lower/upper limit CSR RW-fields
> otherwise the specified range will be just silently clamped. That
> verification will also protect the code from having u64 type overflow.
> Secondly let's make sure base address (CPU-address), target address
> (PCI-address) and size are properly aligned. Unaligned ranges will be
> silently aligned down (addresses) and up (limit) on writing the values to
> the corresponding registers, which in it turn may lead to unpredictable
> results like ranges virtual overlap. Finally the CPU-address alignment
> needs to be verified in the dw_pcie_prog_inbound_atu() method too as the
> DWC PCIe RC/EP registers manual demands seeing the lower bits of the in-
> and outbound iATU base address are always zeros.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 39 +++++++++++++-------
>  drivers/pci/controller/dwc/pcie-designware.h | 10 ++---
>  2 files changed, 30 insertions(+), 19 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
