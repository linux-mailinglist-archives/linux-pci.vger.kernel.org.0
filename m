Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1A7524F33
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 16:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354921AbiELOBk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 10:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354912AbiELOBf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 10:01:35 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7445418F
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 07:01:33 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id n10so5233223pjh.5
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 07:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LuitxF/LxlyDzAJ6WiMHBPYI6+2/9TqSBGYdKA4Kdbk=;
        b=hXQKiSvErap40hy+dXmzuEfIjSuO7mQ4+LF6SI7ROCaq0cCea+dX7+6p0kYgipc7r7
         fAg178C7ZxY+IqXATlnRL/PWrtggp5bfkNR5xPTvVlNa8oMEWEDqlRGJ9oJMB6ZXe86z
         +ZQrfP6/9HOrmnkiutVcL7IbUW00wvqgViWkgP9Mcuun52KPbP9NdRaRFFz6gO9kwvAS
         V4NwrLQnBi/ClLHsSCYEj+e1J6kqvb3kHPR7cjYWZv1HP/PkLOMnuG8CwLyhC3AxTRzn
         A7NZBi+LXLeFf9kCkxUTUpaFh8abRrajqDJZoLIreRRPDK9m4TUh6DTMkeNw4lt/rXF8
         WQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LuitxF/LxlyDzAJ6WiMHBPYI6+2/9TqSBGYdKA4Kdbk=;
        b=QvTse3pbvK0K3a2a8XGVeGbyu+ogst9ROKhuG4MSPo6g1+WSMZq7OXkRt6gY4AYpqa
         olkzZa7DHT3xNkjC1BvLhbzueDWp3vIV/YHa2q3ogiHdmYZ6A+qfkxSyrT201tsLVfCA
         ZID3xGZHSM8AffDXFCZzo0moHj/MvL6g3ADCbjQI2ROCRENud1040Y8F/R10Xj8mBlIC
         LSWw4TBvg4YBPPm3YZ9HY/T+MYDhvEY0y3mMsxBOkPr87t2Ed1exN0ifHlunZEIYercm
         d2A24scP62q44CvN1LFi0onzbhmiAQLr/5f0bHeRCihnCZJ67W/P5YeBmEgMh00cL45f
         ToCA==
X-Gm-Message-State: AOAM533RT+RJNaNTjGAUeo6icH/0DgCToMTWGYfaoJhBUsVrLmvdVsNA
        d6nB7lw66+QmH6RbmfqJcKEr
X-Google-Smtp-Source: ABdhPJxaAVTBu9QCUOg7jBzjc3IVOzl4NbzJYJxeufqURrOTTpDV1PE/u6pG6jCUU+sYZ0fh/cw2LQ==
X-Received: by 2002:a17:90a:fcb:b0:1dc:f0ce:69fb with SMTP id 69-20020a17090a0fcb00b001dcf0ce69fbmr11084857pjz.198.1652364092878;
        Thu, 12 May 2022 07:01:32 -0700 (PDT)
Received: from thinkpad ([117.202.184.202])
        by smtp.gmail.com with ESMTPSA id ch9-20020a056a00288900b0050dc76281c2sm3683732pfb.156.2022.05.12.07.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 07:01:32 -0700 (PDT)
Date:   Thu, 12 May 2022 19:31:24 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/17] PCI: dwc: Simplify in/outbound iATU setup
 methods
Message-ID: <20220512140124.GD35848@thinkpad>
References: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
 <20220503214638.1895-12-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220503214638.1895-12-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 04, 2022 at 12:46:32AM +0300, Serge Semin wrote:
> From maintainability and scalability points of view it has been wrong to
> use different iATU inbound and outbound regions accessors for the viewport
> and unrolled versions of the iATU CSRs mapping. Seeing the particular iATU
> region-wise registers layout is almost fully compatible for different
> IP-core versions, there were no much points in splitting the code up that
> way since it was possible to implement a common windows setup methods for
> both viewport and unrolled iATU CSRs spaces. While what we can observe in
> the current driver implementation of these methods, is a lot of code
> duplication, which consequently worsen the code readability,
> maintainability and scalability. Note the current implementation is a bit
> more performant than the one suggested in this commit since it implies
> having less MMIO accesses. But the gain just doesn't worth having the
> denoted difficulties especially seeing the iATU setup methods are mainly
> called on the DW PCIe controller and peripheral devices initialization
> stage.
> 
> Here we suggest to move the iATU viewport and unrolled CSR access
> specifics in the dw_pcie_readl_atu() and dw_pcie_writel_atu() method, and
> convert the dw_pcie_prog_outbound_atu() and
> dw_pcie_prog_{ep_}inbound_atu() functions to being generic instead of
> having a different methods for each viewport and unrolled types of iATU
> CSRs mapping. Nothing complex really. First of all the dw_pcie_readl_atu()
> and dw_pcie_writel_atu() are converted to accept relative iATU CSRs
> address together with the iATU region direction (inbound or outbound) and
> region index. If DW PCIe controller doesn't have the unrolled iATU CSRs
> space, then the accessors will need to activate a iATU viewport based on
> the specified direction and index, otherwise a base address for the
> corresponding region CSRs will be calculated by means of the
> PCIE_ATU_UNROLL_BASE() macro. The CSRs macro have been modified in
> accordance with that logic in the pcie-designware.h header file.
> 
> The rest of the changes in this commit just concern converting the iATU
> in-/out-bound setup methods and iATU regions detection procedure to be
> compatible with the new accessors semantics. As a result we've dropped the
> no more required dw_pcie_prog_outbound_atu_unroll(),
> dw_pcie_prog_inbound_atu_unroll() and dw_pcie_iatu_detect_regions_unroll()
> methods.
> 
> Note aside with the denoted code improvements, there is an additional
> positive side effect of this change. If at some point an atomic iATU
> configs setup procedure is required, it will be possible to be done with
> no much effort just by adding the synchronization into the
> dw_pcie_readl_atu() and dw_pcie_writel_atu() accessors.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - Move the iATU region selection procedure into a helper function (@Rob).
> - Simplify the iATU region selection procedure by recalculating the base
>   address only if the space is unrolled. The iATU viewport base address
>   is saved in the pci->atu_base field from now.
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 293 ++++++-------------
>  drivers/pci/controller/dwc/pcie-designware.h |  48 ++-

In this patch, you also need to fix "pcie-tegra194-acpi.c" driver that makes
use of the removed macros.

Thanks,
Mani

-- 
மணிவண்ணன் சதாசிவம்
