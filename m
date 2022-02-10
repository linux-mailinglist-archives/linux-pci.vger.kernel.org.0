Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CDC4B0897
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 09:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237693AbiBJIk5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 03:40:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237619AbiBJIk5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 03:40:57 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D5DF38
        for <linux-pci@vger.kernel.org>; Thu, 10 Feb 2022 00:40:58 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id w20so1220516plq.12
        for <linux-pci@vger.kernel.org>; Thu, 10 Feb 2022 00:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lml04aTETNhbjz5UfbB0wHhW/pmKPxDeqou6P6IhLSE=;
        b=A0FvrNCNOsvejy3SYS0u8eTopBroPKxiAKRLzWoR7Q28Ksz40kCXZnhMIqVG4C5dGJ
         N2AxqvQeANh116uG9ACcxpLt/MXpHKU0OmzQdg6W65n6IdsOkd3jMXCzsg3gIrQu6UfD
         X3oLAT9dzrC/JeXXMrtmLWLbGG3zrTwgcsJ3jqcjQ41tcp0UrrPgQThop5UWGa6JntT8
         h9f/0qA+jQISoCNbLl8tXPHH5i9e8yWCJNBZPfEQ7Ry2aHzoSrrIhGsq/hVg21fxwef8
         yAblay5XgINV6fM14fUOB7l9o109bvPVVxcNF69S5vXpMh6oDZi8CEYL5LcQt4mWeQAi
         CNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lml04aTETNhbjz5UfbB0wHhW/pmKPxDeqou6P6IhLSE=;
        b=c2CDa9wma20cREK+O+/HqF+ERpC5DBPulYvxaxvgUFiKD4+K7NaMXQVCWPLIlGWzWi
         6jZMHqFxKSqcCocMOjsx7phl67u055jooiY28JJhQc+qHU56bAv4vJSk3E2T4yjkqFFP
         pC4C/XBieUrxHjTTuoWgNMOdlsKOkyp4Xo7XfZDam9du6gHxeNaoYw5lz7AmiqcmoDk4
         TyTYE6GJpzzc6QdNmN1hXHYXHXne4XzMvLE/8uYWSaCVhjNS5N08OZ4TQy7RYEeQXqx1
         HiRlgELrAkHPciOBrL/rdTAMJE0QZxYvjRuPUgqk6j0I3ASN4okXj0KzIdeP6lopVW7s
         IAsw==
X-Gm-Message-State: AOAM531cqNFlCf3DASt/2pq8uoASjbMc+UtB0W7tF7sSLbN9MDUEONYL
        Hbz3LxGCPsXzy3TxBPZnu7kN
X-Google-Smtp-Source: ABdhPJwibVMEUZ+/333sxrkxtimACpqZewTBHxq3BPbN16sBUMSks3w0bmHm0yE956PYHRJJ1/EUGQ==
X-Received: by 2002:a17:902:a9c2:: with SMTP id b2mr6411138plr.135.1644482458228;
        Thu, 10 Feb 2022 00:40:58 -0800 (PST)
Received: from thinkpad ([27.111.75.88])
        by smtp.gmail.com with ESMTPSA id rj1sm1590621pjb.49.2022.02.10.00.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 00:40:57 -0800 (PST)
Date:   Thu, 10 Feb 2022 14:10:52 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [RFC PATCH 0/5] PCIe EPF support for internal DMAC handling and
 driver update for R-Car PCIe EP to support DMAC
Message-ID: <20220210084052.GA69529@thinkpad>
References: <20220126195043.28376-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126195043.28376-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Wed, Jan 26, 2022 at 07:50:38PM +0000, Lad Prabhakar wrote:
> Hi All,
> 
> The current PCIe EPF framework supports DMA data transfers using external
> DMA only, this patch series aims to add support for platforms supporting
> internal DMAC on PCIe for data transfers.
> 
> R-Car PCIe supports internal DMAC to transfer data between Internal Bus to
> PCI Express and vice versa. Last patch fills up the required flags and ops
> to support internal DMAC.
> 
> Patches 1-3 are for PCIe EPF core to support internal DMAC handling, patch
> 4/5 is to fix test cases based on the conversation [1].
> 

This looks similar to the Synopsys eDMA IP [1] that goes with the Synopsys PCIe
endpoint IP. Why can't you represent it as a dmaengine driver and use the
existing DMA support?

Thanks,
Mani

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/dma/dw-edma 

> Patches are based on top of [1] next branch.
> 
> [0] https://www.spinics.net/lists/linux-pci/msg92385.html
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
> 
> Cheers,
> Prabhakar
> 
> Lad Prabhakar (5):
>   PCI: endpoint: Add ops and flag to support internal DMAC
>   PCI: endpoint: Add support to data transfer using internal dmac
>   misc: pci_endpoint_test: Add driver data for Renesas RZ/G2{EHMN}
>   misc: pci_endpoint_test: Add support to pass flags for buffer
>     allocation
>   PCI: rcar-ep: Add support for DMAC
> 
>  drivers/misc/pci_endpoint_test.c              |  56 ++++-
>  drivers/pci/controller/pcie-rcar-ep.c         | 227 ++++++++++++++++++
>  drivers/pci/controller/pcie-rcar.h            |  23 ++
>  drivers/pci/endpoint/functions/pci-epf-test.c | 184 ++++++++++----
>  drivers/pci/endpoint/pci-epf-core.c           |  32 +++
>  include/linux/pci-epc.h                       |   8 +
>  include/linux/pci-epf.h                       |   7 +
>  7 files changed, 483 insertions(+), 54 deletions(-)
> 
> -- 
> 2.25.1
> 
