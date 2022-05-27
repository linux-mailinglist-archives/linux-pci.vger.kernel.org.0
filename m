Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975865366A7
	for <lists+linux-pci@lfdr.de>; Fri, 27 May 2022 19:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242147AbiE0RkB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 May 2022 13:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353522AbiE0RkA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 May 2022 13:40:00 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC48436E24;
        Fri, 27 May 2022 10:39:58 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id p4so7939798lfg.4;
        Fri, 27 May 2022 10:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BVjPLjsoYeaiMWajjoqIC5HKKBEtazU3lpGPAxhhbm8=;
        b=c+dG9kN77/FxyGiUxRrypZ/gbF7cDZ0dJ2QSV6TYDo6IIB7i9yON4G8P1WM4N6zCza
         RpP1hHnmRaetNYIrshBK94wijPPI/tq0aYuy5IEkhK6o7FJgOWwBXyy0NLM3FG+i1hZz
         L597OBUNDbLrz4zi0UH4/9YWOzmAfhGCX2MgROrzBCPI+y5Rw7MA6l/B98tk5BJ9qPUY
         fhlQTe6nbBLefjEIfKMOE6D9bedizkDjE1q9BYfPKMwvk7Bfzxz3mpWhKMADJzyIk/Zq
         gxIDR9wPE/EF4i1vBNVSPJhQudaHRoVKQcGYlNerBpTJL5OkUNPLHOAIOrZojxNZu0H6
         kyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BVjPLjsoYeaiMWajjoqIC5HKKBEtazU3lpGPAxhhbm8=;
        b=dPvgMYx7RejrIxkIhKEFcTqhwc7gHhg4/06QIcgBewtLtigMEqm5FT1cu6lK+XpLT8
         nqhT9Xe2Mq9lj81KKW8SO+PElOK12M3+DbyM+QY9P4q7fNM6P9C47/Hdsc3Bgw0Detoz
         5O4/TDVZrrrg3QiivmZagpYQw2zBCCdFyRrr60eFhtyfeBASNviD7+1S8wH5vFBWdfrA
         GX708Aft6txGDCK6qoroMx+0ZOSlnEQ6z0Pz1fs/A1QrGaZIX1CBeGzINpBsNYmiYDWY
         KWJ68mRINK5/7pgmPe1IQg5FH2PxYOX22qv5lgMJPftkYTSKdwRpi6Bp8RxyevB9grCQ
         rUzw==
X-Gm-Message-State: AOAM532VQlMVh46qtdzrgSenaqwZSLHA7sNwSCUYDGNXcfug4BiV9YpK
        19njRzE48MApGyzfGq8x3+w=
X-Google-Smtp-Source: ABdhPJxB1qGz8PwZWTrXgf558N5qhW03UNWE46GCvRFQvuyaq7D76llFBrwiDrexlms7tHSKv3CnUw==
X-Received: by 2002:a05:6512:2a92:b0:477:bbff:fc3a with SMTP id dt18-20020a0565122a9200b00477bbfffc3amr29927670lfb.544.1653673197011;
        Fri, 27 May 2022 10:39:57 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id p18-20020a2eba12000000b0025076cd5ef9sm1120053lja.128.2022.05.27.10.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 10:39:55 -0700 (PDT)
Date:   Fri, 27 May 2022 20:39:53 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/13] PCI: dwc: Don't use generic IO-ops for
 DBI-space access
Message-ID: <20220527173953.c4aqlw5jz3xfd727@mobilestation>
References: <20220517125058.18488-1-Sergey.Semin@baikalelectronics.ru>
 <20220517125058.18488-3-Sergey.Semin@baikalelectronics.ru>
 <20220526212930.GN54904-robh@kernel.org>
 <20220527160551.dh6fb5n6xbmtjpaa@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527160551.dh6fb5n6xbmtjpaa@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 27, 2022 at 07:05:55PM +0300, Serge Semin wrote:
> On Thu, May 26, 2022 at 04:29:30PM -0500, Rob Herring wrote:
> > On Tue, May 17, 2022 at 03:50:47PM +0300, Serge Semin wrote:
> > > Commit c2b0c098fbd1 ("PCI: dwc: Use generic config accessors") replaced
> > > the locally defined DW PCIe host controller config-space accessors with
> > > the generic methods pci_generic_config_read() and
> > > pci_generic_config_write(). It was intended that the corresponding
> > > bus-mapping callback returned a correct virtual address of the passed PCI
> > > config-space register. The problem of the proposed solution was that it
> > > didn't take into account the way the host config-space is accessed on the
> > > DW PCIe. Depending on the DW PCIe IP-core synthesize parameters different
> > > interfaces can be used to access the host and peripheral config/memory
> > > spaces. The former one can be accessed via the DBI interface, while the
> > > later ones is reached via the AHB/AXI application bus. In case if the DW
> > > PCIe controller is configured to have a dedicated DBI interface, the way
> > > it is mapped into the IO-memory turns to be platform-specific. For such
> > > setups the DWC PCIe driver provides a set of the callbacks
> > > dw_pcie_ops.{read_dbi,write_dbi} so the platforms glue-drivers would be
> > > able to take into account the DBI bus IO peculiarities. Since
> > > commit c2b0c098fbd1 ("PCI: dwc: Use generic config accessors") these
> > > methods haven't been utilized during the generic host initialization
> > > performed by the PCIe subsystem code.
> > > 
> > > I don't really know how come there have been no problems spotted for the
> > > Histb/Exynos/Kirin PCIe controllers so far, but in our case with dword
> > 
> 
> > Because they implement their own pci_ops for the root bus. You should 
> > too.
> 
> Right. I should, but I would do that in a more generic way. Please see
> the next comment.
> 
> > 
> > Who is 'our case'? 
> > 
> > > aligned IO requirement the generic config-space accessors can't be
> > > utilized for the host config-space. Thus in order to make sure the host
> > > config-space is properly accessed via the DBI bus let's get back the
> > > dw_pcie_rd_own_conf() and dw_pcie_wr_own_conf() methods. They are going to
> > > be just wrappers around the already defined
> > > dw_pcie_read_dbi()/dw_pcie_write_dbi() functions with proper arguments
> > > conversion. These methods perform the platform-specific config-space IO if
> > > the DBI accessors are specified, otherwise they call normal MMIO
> > > operations.
> > 
> 
> > The idea was for DWC to not define its own way to have different 
> > read/write for root bus vs. child bus as many PCI host bridges need the 
> > same thing. So the host bridge struct now has 2 pci_ops pointers. And 
> > the mess of function pointer indirection is gone.
> 
> Thanks for clarification. I should have investigated the problem more
> thoroughly. Now I see what was the reason of that change.  It was
> indeed wrong to blame the commit c2b0c098fbd1 ("PCI: dwc: Use generic
> config accessors") that something was done incorrectly. After a more
> thorough commit inspection I realized that you just replaced the
> dw_pcie_rd_own_conf() and dw_pcie_wr_own_conf() with the generic
> pci_generic_config_read and pci_generic_config_write() as they had
> been equivalent anyway.  I thought they didn't have the same semantic
> by confusing the dw_pcie_{read,write}() and dw_pcie_{read,write}_dbi()
> methods usage (see the _dbi suffix) in the original own PCI
> config-space accessors. So to speak I'll need to drop the Fixes tag
> with your commit hash from the patch.
> 
> Getting back to the own-bus accessors. DW PCIe RP/EP own-config space
> is accessed over the DBI-bus. If the particular platform is designed
> in a way so the DBI MMIO space access has some non-specific
> peculiarities then that platform implements its own read_dbi/write_dbi
> accessors. In case if these callbacks are defined, the driver must
> use them for all DBI MMIO accesses including for the ones performed
> from the subsystem core in the framework of the host own config-space
> setups. As I mentioned in the patch log currently the only platforms
> with such requirement happen to be Histb, Exynos and Kirin DW PCIe. As
> such we can freely get back the generic dw_pcie_rd_own_conf() and
> dw_pcie_wr_own_conf() methods but use the dw_pcie_{read,write}_dbi()
> methods in there in the same way as it is done in the Histb, Exynos
> and Kirin DW PCIe drivers (see their own PCI config-space accessors
> match). Due to that we can drop the pci_ops redefinition from these
> platforms and just use the own-config space accessors for all such
> platforms as it's suggested in this patch. So this modification can be
> re-qualified to the cleanup one then:
> 1) Create the generic own config-space accessors (more portable as
> the DBI-bus access specifics must be always taken into account) as it
> is suggested in this patch already.
> 2) Drop the Kirin, Exynos, Histb own config-space re-definition.

> 3) Drop the dw_pcie_read_dbi() and dw_pcie_write_dbi() methods exporting.

Alas this can't be implemented. I forgot about the inliners defined in the
pcie-designware.h file. But the rest of the denoted above cleanups still
can be (Kirin under question though).

-Sergey

> 
> What do you think?
> 
> -Sergey
> 
> > 
> > Rob
