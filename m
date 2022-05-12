Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8955255A4
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 21:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357977AbiELTWk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 15:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiELTWk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 15:22:40 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF6D6D3BB;
        Thu, 12 May 2022 12:22:38 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id bx33so7696943ljb.12;
        Thu, 12 May 2022 12:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pf8wWHzSaY4Mb0ZLMgAak5YWJzuy/cpG9y80uj1xVZU=;
        b=hr+q7+kMB9jkRmg8H7tezy493qLUTMW7PXQvpX/bwraZB6EJd9BvwCTlCrVKCEoV5m
         NaFR6bHmlui0OjYyv9XNjZHe0W26TVle4eSreAEwEuJcFIIbx/vHOhSxmA3iibKDlCSv
         VvpjBMWH+5sTFoXmXMgcKd1l2NsHi2jCmTEeV/5tjeo5EhwmXRdtKeQpX2w5r/08P4Ci
         +wxsIV6byNLqbjWG42p3TDhV/lYECCup5urtS6NUlyVnN4iTBQEbbwvgteGXnGPLIf9s
         wHIV/+RZdzl43ZZe0MQOLi1RGVKuNS1JfWlnVvPnVuS2mMPuBO2dZwFVgUbXzInVNvbc
         K2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pf8wWHzSaY4Mb0ZLMgAak5YWJzuy/cpG9y80uj1xVZU=;
        b=qRBExr3iHc2RAO4LEFcJpQXE+bKrr0BCEIZk+jMZXirCYLp3l2viIeeS+Mbjlw+xFS
         h7K2xx5OVX2JcRD9R/4Y6xXRBxuDIEFUmD1CCZWWGpZoye62AYNBbm+UsstSg18kQcWi
         T3PWlYp144vOUZvBDrFMt4fjTGZ5Br/xSfiPDl1iI2YDI2gMOh03D4feBugBKlsrdnq6
         E8ts0WsUnvakT//8wPJ7UIMasMx70HlNmgthNU8NU7DT5OWPHd8p1WMPyGjDAA0EZ4CN
         188LyBfDz3IIIl/GKfdqTgquj1mmzHjs/Lbj/Hurqb6aIXFHXHIM4BCGb8yOuvnYrtdH
         EWZQ==
X-Gm-Message-State: AOAM532n7c7LT+zml7uZ9RxtSxnloEnmBPJMKSwZC2QfLnYHObtju2v/
        DsnMEcgHyN0pt0FQoEvAFyo=
X-Google-Smtp-Source: ABdhPJyYfrcH0Mi/nzdU0/MeriKQDMsDwfGy91/mVpM6QQFEaDL1VwDoreBrvt8ZfA4zVQ/kL64G3w==
X-Received: by 2002:a2e:824b:0:b0:24d:c247:c928 with SMTP id j11-20020a2e824b000000b0024dc247c928mr945800ljh.68.1652383356892;
        Thu, 12 May 2022 12:22:36 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id l7-20020a2ea807000000b0024f3d1daed0sm49660ljq.88.2022.05.12.12.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 12:22:36 -0700 (PDT)
Date:   Thu, 12 May 2022 22:22:33 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/17] PCI: dwc: Simplify in/outbound iATU setup
 methods
Message-ID: <20220512192233.4ulfev2l2f6mue62@mobilestation>
References: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
 <20220503214638.1895-12-Sergey.Semin@baikalelectronics.ru>
 <20220512140124.GD35848@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220512140124.GD35848@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 12, 2022 at 07:31:24PM +0530, Manivannan Sadhasivam wrote:
> On Wed, May 04, 2022 at 12:46:32AM +0300, Serge Semin wrote:
> > From maintainability and scalability points of view it has been wrong to
> > use different iATU inbound and outbound regions accessors for the viewport
> > and unrolled versions of the iATU CSRs mapping. Seeing the particular iATU
> > region-wise registers layout is almost fully compatible for different
> > IP-core versions, there were no much points in splitting the code up that
> > way since it was possible to implement a common windows setup methods for
> > both viewport and unrolled iATU CSRs spaces. While what we can observe in
> > the current driver implementation of these methods, is a lot of code
> > duplication, which consequently worsen the code readability,
> > maintainability and scalability. Note the current implementation is a bit
> > more performant than the one suggested in this commit since it implies
> > having less MMIO accesses. But the gain just doesn't worth having the
> > denoted difficulties especially seeing the iATU setup methods are mainly
> > called on the DW PCIe controller and peripheral devices initialization
> > stage.
> > 
> > Here we suggest to move the iATU viewport and unrolled CSR access
> > specifics in the dw_pcie_readl_atu() and dw_pcie_writel_atu() method, and
> > convert the dw_pcie_prog_outbound_atu() and
> > dw_pcie_prog_{ep_}inbound_atu() functions to being generic instead of
> > having a different methods for each viewport and unrolled types of iATU
> > CSRs mapping. Nothing complex really. First of all the dw_pcie_readl_atu()
> > and dw_pcie_writel_atu() are converted to accept relative iATU CSRs
> > address together with the iATU region direction (inbound or outbound) and
> > region index. If DW PCIe controller doesn't have the unrolled iATU CSRs
> > space, then the accessors will need to activate a iATU viewport based on
> > the specified direction and index, otherwise a base address for the
> > corresponding region CSRs will be calculated by means of the
> > PCIE_ATU_UNROLL_BASE() macro. The CSRs macro have been modified in
> > accordance with that logic in the pcie-designware.h header file.
> > 
> > The rest of the changes in this commit just concern converting the iATU
> > in-/out-bound setup methods and iATU regions detection procedure to be
> > compatible with the new accessors semantics. As a result we've dropped the
> > no more required dw_pcie_prog_outbound_atu_unroll(),
> > dw_pcie_prog_inbound_atu_unroll() and dw_pcie_iatu_detect_regions_unroll()
> > methods.
> > 
> > Note aside with the denoted code improvements, there is an additional
> > positive side effect of this change. If at some point an atomic iATU
> > configs setup procedure is required, it will be possible to be done with
> > no much effort just by adding the synchronization into the
> > dw_pcie_readl_atu() and dw_pcie_writel_atu() accessors.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Changelog v2:
> > - Move the iATU region selection procedure into a helper function (@Rob).
> > - Simplify the iATU region selection procedure by recalculating the base
> >   address only if the space is unrolled. The iATU viewport base address
> >   is saved in the pci->atu_base field from now.
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 293 ++++++-------------
> >  drivers/pci/controller/dwc/pcie-designware.h |  48 ++-
> 

> In this patch, you also need to fix "pcie-tegra194-acpi.c" driver that makes
> use of the removed macros.

Right. I've missed the ACPI part since it isn't available on my
platform. Thanks for noticing that.

-Sergey

> 
> Thanks,
> Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்
