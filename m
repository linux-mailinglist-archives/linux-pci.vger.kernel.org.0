Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD1553557A
	for <lists+linux-pci@lfdr.de>; Thu, 26 May 2022 23:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344827AbiEZV3i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 May 2022 17:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243012AbiEZV3f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 May 2022 17:29:35 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A75B8BC2;
        Thu, 26 May 2022 14:29:33 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id s188so3643801oie.4;
        Thu, 26 May 2022 14:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NRb8FQeOXq86dICXOxHNk9gd/5/0BCzLhJinS2O/0rA=;
        b=lE0vumOp3ZgiYZpDcMbyCc9Aa8ZREWY/ex+wVuVXAWDkZOdJjzVCSEOUyhZE3LqGQo
         n/5a1a8d7L+/0fZGE19LsBii+q1bC5cPh1u4ecolQqXuGd/bfw4ie2mc3wFJ40BbuWH/
         eIvyyRgexfcWVNX2CZFfhIimmC95oNPkiVYzgUpSDfK/sKlBejfpl46NtP7NLU/L1G9R
         KkrB5LTl/95oWZIGSDKgzHQTa8fdcI7w2BY5vVdAbQ+tF4yzHnuaCjrjTCHa98BfbgEg
         gwbMPI/xGYuHDky5T2KzGGcf8a+o0ID0jX1JSFFaWMdsUjAOLGLjfKHgYZogj+WXcw0U
         ZAKw==
X-Gm-Message-State: AOAM533Yv3hTdiHm1JWfZAk41VyDKTuoNJLssa1LH/vjH32dt18DDXcu
        alybxUuhYDolBktEoB8gmw==
X-Google-Smtp-Source: ABdhPJwsx2I/+ZW6zUbzKeJSoGYaVPzH3m5q6AwuASPyTULXP92xu2Sc9rl59JOgJ3AYsiMTsh7WKw==
X-Received: by 2002:a05:6808:14d2:b0:32b:9dd:df82 with SMTP id f18-20020a05680814d200b0032b09dddf82mr2273058oiw.158.1653600573066;
        Thu, 26 May 2022 14:29:33 -0700 (PDT)
Received: from robh.at.kernel.org (rrcs-192-154-179-37.sw.biz.rr.com. [192.154.179.37])
        by smtp.gmail.com with ESMTPSA id c8-20020aca1c08000000b00326414c1bb7sm1030818oic.35.2022.05.26.14.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 14:29:32 -0700 (PDT)
Received: (nullmailer pid 294758 invoked by uid 1000);
        Thu, 26 May 2022 21:29:30 -0000
Date:   Thu, 26 May 2022 16:29:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/13] PCI: dwc: Don't use generic IO-ops for
 DBI-space access
Message-ID: <20220526212930.GN54904-robh@kernel.org>
References: <20220517125058.18488-1-Sergey.Semin@baikalelectronics.ru>
 <20220517125058.18488-3-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517125058.18488-3-Sergey.Semin@baikalelectronics.ru>
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

On Tue, May 17, 2022 at 03:50:47PM +0300, Serge Semin wrote:
> Commit c2b0c098fbd1 ("PCI: dwc: Use generic config accessors") replaced
> the locally defined DW PCIe host controller config-space accessors with
> the generic methods pci_generic_config_read() and
> pci_generic_config_write(). It was intended that the corresponding
> bus-mapping callback returned a correct virtual address of the passed PCI
> config-space register. The problem of the proposed solution was that it
> didn't take into account the way the host config-space is accessed on the
> DW PCIe. Depending on the DW PCIe IP-core synthesize parameters different
> interfaces can be used to access the host and peripheral config/memory
> spaces. The former one can be accessed via the DBI interface, while the
> later ones is reached via the AHB/AXI application bus. In case if the DW
> PCIe controller is configured to have a dedicated DBI interface, the way
> it is mapped into the IO-memory turns to be platform-specific. For such
> setups the DWC PCIe driver provides a set of the callbacks
> dw_pcie_ops.{read_dbi,write_dbi} so the platforms glue-drivers would be
> able to take into account the DBI bus IO peculiarities. Since
> commit c2b0c098fbd1 ("PCI: dwc: Use generic config accessors") these
> methods haven't been utilized during the generic host initialization
> performed by the PCIe subsystem code.
> 
> I don't really know how come there have been no problems spotted for the
> Histb/Exynos/Kirin PCIe controllers so far, but in our case with dword

Because they implement their own pci_ops for the root bus. You should 
too.

Who is 'our case'? 

> aligned IO requirement the generic config-space accessors can't be
> utilized for the host config-space. Thus in order to make sure the host
> config-space is properly accessed via the DBI bus let's get back the
> dw_pcie_rd_own_conf() and dw_pcie_wr_own_conf() methods. They are going to
> be just wrappers around the already defined
> dw_pcie_read_dbi()/dw_pcie_write_dbi() functions with proper arguments
> conversion. These methods perform the platform-specific config-space IO if
> the DBI accessors are specified, otherwise they call normal MMIO
> operations.

The idea was for DWC to not define its own way to have different 
read/write for root bus vs. child bus as many PCI host bridges need the 
same thing. So the host bridge struct now has 2 pci_ops pointers. And 
the mess of function pointer indirection is gone.

Rob
