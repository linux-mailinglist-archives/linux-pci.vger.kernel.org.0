Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF1F5365A7
	for <lists+linux-pci@lfdr.de>; Fri, 27 May 2022 18:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244448AbiE0QGH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 May 2022 12:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354471AbiE0QF6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 May 2022 12:05:58 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F10C149150;
        Fri, 27 May 2022 09:05:57 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y32so7586470lfa.6;
        Fri, 27 May 2022 09:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P54iB7Z7qL7odfNZWCq1BQQ072lsjh56kKz4+mPnLGI=;
        b=e01MKb3qjPMsQKlM76hc8OKrBxfkyHpLrfUCFP3gOzyaf7YxmUYUhIgsVl6QCQaG3F
         pCSUZ67O0VEHUFWMYytcrkaj6OGPa4K39TGrd54W5EV1MLfPaAo8n3t4yE9sfokUeMjX
         hOSiYhSUJ6gYpPNlXp1tzOCez/PeoYFVrHK5Zwk2Tey0msfPlICcsNEVYcgB+zR6KUd2
         naaL5f2o5vUR9bx+uD9MEBWf1KeQrwtbvmIPFz77b13qjInpBgM1vZX06Bj8Wed2AbPu
         CvQxeT/R5KKJA7XlVPk7aAP2mGTzDx1bwSKH4mzA5Nbz4eQ6MZ49T9N6AS5Dx7VuLwRo
         AaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P54iB7Z7qL7odfNZWCq1BQQ072lsjh56kKz4+mPnLGI=;
        b=r8WIr47u4t53q3IWjpzCX+Xq3gf5IWrp2k9LHL4Zr6zMIgRG9U6CQBdOuLkAu3rKZ9
         GEp+8YCvy7T7ZEI4v0345AhEGxUCAf2D6mGG6jSVDg0sJzXD20cLJBefjqF48kv2McCc
         b5uT2xz/U703YUoIjBarTFRYi/9XAL2zv5iEZtzWO8ZQM0agQixyuhv8A/5EKzvJn5WQ
         QlXjYNHNQwI1+1PMfEv7bpoEbxXLrglpBG4H8wZSxsHq9R9xpsKqOfmIjxgrigK6R5E3
         qx/7quh00hWRo8QcuFHGRj7r6IZdIq2cP8fh6WkU0kctw4sBy+Y76FQhE05FHce1sLRl
         5C2Q==
X-Gm-Message-State: AOAM532wkyTvTXh3bGELTH1ze7Io+1odIT4sLmbnDe6cqgomHwYkON0H
        bDI92Xt415A220n9Ro8/7h4=
X-Google-Smtp-Source: ABdhPJzIlyYosjmZD7kVZsk+SOPTmpsmVh2NgrGhteHU9s3q9Jnpe5j+65nWBb7/lvfIH/1mm2jtfA==
X-Received: by 2002:a05:6512:22c4:b0:477:cc26:c729 with SMTP id g4-20020a05651222c400b00477cc26c729mr28169734lfu.315.1653667555160;
        Fri, 27 May 2022 09:05:55 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id v4-20020ac25584000000b00477cdd53190sm924918lfg.74.2022.05.27.09.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 09:05:54 -0700 (PDT)
Date:   Fri, 27 May 2022 19:05:51 +0300
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
Message-ID: <20220527160551.dh6fb5n6xbmtjpaa@mobilestation>
References: <20220517125058.18488-1-Sergey.Semin@baikalelectronics.ru>
 <20220517125058.18488-3-Sergey.Semin@baikalelectronics.ru>
 <20220526212930.GN54904-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526212930.GN54904-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 26, 2022 at 04:29:30PM -0500, Rob Herring wrote:
> On Tue, May 17, 2022 at 03:50:47PM +0300, Serge Semin wrote:
> > Commit c2b0c098fbd1 ("PCI: dwc: Use generic config accessors") replaced
> > the locally defined DW PCIe host controller config-space accessors with
> > the generic methods pci_generic_config_read() and
> > pci_generic_config_write(). It was intended that the corresponding
> > bus-mapping callback returned a correct virtual address of the passed PCI
> > config-space register. The problem of the proposed solution was that it
> > didn't take into account the way the host config-space is accessed on the
> > DW PCIe. Depending on the DW PCIe IP-core synthesize parameters different
> > interfaces can be used to access the host and peripheral config/memory
> > spaces. The former one can be accessed via the DBI interface, while the
> > later ones is reached via the AHB/AXI application bus. In case if the DW
> > PCIe controller is configured to have a dedicated DBI interface, the way
> > it is mapped into the IO-memory turns to be platform-specific. For such
> > setups the DWC PCIe driver provides a set of the callbacks
> > dw_pcie_ops.{read_dbi,write_dbi} so the platforms glue-drivers would be
> > able to take into account the DBI bus IO peculiarities. Since
> > commit c2b0c098fbd1 ("PCI: dwc: Use generic config accessors") these
> > methods haven't been utilized during the generic host initialization
> > performed by the PCIe subsystem code.
> > 
> > I don't really know how come there have been no problems spotted for the
> > Histb/Exynos/Kirin PCIe controllers so far, but in our case with dword
> 

> Because they implement their own pci_ops for the root bus. You should 
> too.

Right. I should, but I would do that in a more generic way. Please see
the next comment.

> 
> Who is 'our case'? 
> 
> > aligned IO requirement the generic config-space accessors can't be
> > utilized for the host config-space. Thus in order to make sure the host
> > config-space is properly accessed via the DBI bus let's get back the
> > dw_pcie_rd_own_conf() and dw_pcie_wr_own_conf() methods. They are going to
> > be just wrappers around the already defined
> > dw_pcie_read_dbi()/dw_pcie_write_dbi() functions with proper arguments
> > conversion. These methods perform the platform-specific config-space IO if
> > the DBI accessors are specified, otherwise they call normal MMIO
> > operations.
> 

> The idea was for DWC to not define its own way to have different 
> read/write for root bus vs. child bus as many PCI host bridges need the 
> same thing. So the host bridge struct now has 2 pci_ops pointers. And 
> the mess of function pointer indirection is gone.

Thanks for clarification. I should have investigated the problem more
thoroughly. Now I see what was the reason of that change.  It was
indeed wrong to blame the commit c2b0c098fbd1 ("PCI: dwc: Use generic
config accessors") that something was done incorrectly. After a more
thorough commit inspection I realized that you just replaced the
dw_pcie_rd_own_conf() and dw_pcie_wr_own_conf() with the generic
pci_generic_config_read and pci_generic_config_write() as they had
been equivalent anyway.  I thought they didn't have the same semantic
by confusing the dw_pcie_{read,write}() and dw_pcie_{read,write}_dbi()
methods usage (see the _dbi suffix) in the original own PCI
config-space accessors. So to speak I'll need to drop the Fixes tag
with your commit hash from the patch.

Getting back to the own-bus accessors. DW PCIe RP/EP own-config space
is accessed over the DBI-bus. If the particular platform is designed
in a way so the DBI MMIO space access has some non-specific
peculiarities then that platform implements its own read_dbi/write_dbi
accessors. In case if these callbacks are defined, the driver must
use them for all DBI MMIO accesses including for the ones performed
from the subsystem core in the framework of the host own config-space
setups. As I mentioned in the patch log currently the only platforms
with such requirement happen to be Histb, Exynos and Kirin DW PCIe. As
such we can freely get back the generic dw_pcie_rd_own_conf() and
dw_pcie_wr_own_conf() methods but use the dw_pcie_{read,write}_dbi()
methods in there in the same way as it is done in the Histb, Exynos
and Kirin DW PCIe drivers (see their own PCI config-space accessors
match). Due to that we can drop the pci_ops redefinition from these
platforms and just use the own-config space accessors for all such
platforms as it's suggested in this patch. So this modification can be
re-qualified to the cleanup one then:
1) Create the generic own config-space accessors (more portable as
the DBI-bus access specifics must be always taken into account) as it
is suggested in this patch already.
2) Drop the Kirin, Exynos, Histb own config-space re-definition.
3) Drop the dw_pcie_read_dbi() and dw_pcie_write_dbi() methods exporting.

What do you think?

-Sergey

> 
> Rob
