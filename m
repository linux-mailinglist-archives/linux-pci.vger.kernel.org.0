Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38FF52939D
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 00:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbiEPW30 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 18:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiEPW3Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 18:29:24 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1295B2E0B7;
        Mon, 16 May 2022 15:29:23 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-d39f741ba0so22050574fac.13;
        Mon, 16 May 2022 15:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yh0XlI6sXmeAe5luM19N0LQkxijUinkf8sEAUNmYP3Q=;
        b=qS+ZKHOHLGJ8rP537lfXf64DFns50xjyGJfYspl7ecBhnDC7KX3WUZ4Q6jhp9mCLzc
         naS+Zl1m1VkBAcPRDQVF7Qs7jOAm2exKxQkXGnI51dBTfj0+7m7Xi5PDhgALDe+HESuR
         Cl1n0bKecYHCQ8E9VitYPu7sEgkB5245M1I2OGwK+FfQtDedOi7/z2ooKzkENJHwlgdR
         zVCJkAeTlspycg8tMllFhYMAWXk8sIBvni+ddERjMWE58yNmOt0FUZfHP5JwuMCFSLgL
         Cv7a1xh8PzbVLQODLITLs/VQHLBQdfd9li643BesfeLk6Y8yriCz9VflCZ5QaJo5/K2I
         UWnA==
X-Gm-Message-State: AOAM531Np0hNwpjwfoTP9JLf7IKeBMvmBW7J2rC5PGnAWCsKkU7c0+ha
        wTNoTM8c+9C8SMImsLuU9w==
X-Google-Smtp-Source: ABdhPJzLT9vxyhF1uirDEmBGXBu9ZLZamqOMw/AyDL+VxWaiVJrIVZNyky+QyzXlRh87Yu7ARSgqRw==
X-Received: by 2002:a05:6870:179a:b0:f1:805a:dbec with SMTP id r26-20020a056870179a00b000f1805adbecmr7011164oae.25.1652740162306;
        Mon, 16 May 2022 15:29:22 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e2-20020a056870a60200b000e99b1909d4sm5808505oam.25.2022.05.16.15.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 15:29:21 -0700 (PDT)
Received: (nullmailer pid 3427730 invoked by uid 1000);
        Mon, 16 May 2022 22:29:20 -0000
Date:   Mon, 16 May 2022 17:29:20 -0500
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
Subject: Re: [PATCH v2 16/17] PCI: dwc: Introduce generic platform clocks and
 resets sets
Message-ID: <20220516222920.GC3296584-robh@kernel.org>
References: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
 <20220503214638.1895-17-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503214638.1895-17-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 04, 2022 at 12:46:37AM +0300, Serge Semin wrote:
> Currently almost each platform driver uses its own resets and clocks
> naming in order to get the corresponding descriptors. It makes the code
> harder to maintain and comprehend especially seeing the DWC PCIe core main
> resets and clocks signals set hasn't changed much for about at least one
> major IP-core release. So in order to organize things around these signals
> we suggest to create a generic interface for them in accordance with the
> naming introduced in the DWC PCIe IP-core reference manual:
> 
> Clocks:
> - DBI - data bus interface clock (on some DWC PCIe platforms it's
>   referred as "pclk", "pcie", "sys", "ahb", "cfg", "iface", "gio", "reg",
>   "pcie_apb_sys");
> - MSTR - AXI-bus master interface clock (some DWC PCIe glue drivers refer
>   to this clock as "port", "bus", "pcie_bus",
>   "bus_master/master_bus/axi_m", "pcie_aclk");
> - SLV - AXI-bus slave interface clock (also called as "port", "bus",
>   "pcie_bus", "bus_slave/slave_bus/axi_s", "pcie_aclk",
>   "pcie_inbound_axi");
> - PIPE - Core-PCS PIPE interface clock coming from external PHY (it's
>   normally named by the platform drivers as just "pipe")
> - CORE - primary clock of the controller (none of the platform drivers
>   declare such a clock but in accordance with the ref. manual the devices
>   may have it separately specified);
> - AUX - Auxiliary PMC domain clock (it is named by some platforms as
>   "pcie_aux" and just "aux")
> - REF - Generic reference clock (it is a generic clock source, which can
>   be used as a signal source for multiple interfaces, some platforms call
>   it as "ref", "general", "pcie_phy", "pcie_phy_ref").
> 
> Application resets:
> - DBI - Data-bus interface reset (it's CSR interface clock and is normally
>   called as "apb" though technically it's not APB but DWC PCIe-specific
>   interface);
>   apb, sys,
> - MSTR -AXI-bus master reset (some platforms call it as "port", "apps",
>   "bus", "axi_m");
> - SLV - ABI-bus slave reset (some platforms call it as "port", "apps",
>   "bus", "axi_s").
> 
> Core resets:
> - NON_STICKY - Non-sticky CSR flags reset;
> - STICKY - sticky CSR flags reset;
> - PIPE - PIPE-interface (Core-PCS) logic reset (some platforms call it
>   just "pipe");
> - CORE - controller primary reset (resets everything except PMC module,
>   some platforms refer to this signal as "soft", "pci");
> - PHY - PCS/PHY block reset (strictly speaking it is normally connected to
>   the out of the external block, but the reference manual says it must be
>   available for the PMC working correctly, some existing platforms call it
>   as "pciephy", "phy", "link");
> - HOT - PMC hot reset signal (also called as sleep");
> - PWR - cold reset signal (can be referred as "pwr", "turnoff").
> 
> As you can see each platform uses it's own naming for basically the same
> set of the signals. In the framework of this commit we suggest to add a
> set of the clocks and signals identifiers and corresponding names for each
> denoted entity. The platforms will be able to use them to define local
> mapping tables between the generic identifiers and the available set of
> the clocks and resets. The tables can be then utilized to create the
> corresponding bulk-arrays, which in its turn can be passed to the
> clock/reset-bulk API methods to easily get/enable/disable/put,
> get/reset/assert/deassert/put all the handlers at once or, if it's
> required, manipulate with the handlers individually.

No doubt there is way to much variation here (ummm, Qcom!). Some 
standardization of names in (new) bindings would be good. That's where 
we should be defining names IMO.

On the driver side, I'd like to see the DW core handle clocks/resets/phys 
at least for the easy cases of just turn on/off all the clocks and 
toggle all resets. Perhaps even more minimally, move the clk/reset 
struct pointers to the DWC core.

IOW, I'm not sure this patch is really helpful without some of the above 
happening. 

Rob
