Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745D95394B7
	for <lists+linux-pci@lfdr.de>; Tue, 31 May 2022 18:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243761AbiEaQJL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 12:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbiEaQJK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 12:09:10 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8424957B13;
        Tue, 31 May 2022 09:09:09 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id l84so17983624oif.10;
        Tue, 31 May 2022 09:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=owi/Gcwxdr9vue0GamDel6ZGFIHyHzQ2mIzlv/E3Lww=;
        b=uVIXnIsFjSiAY7ozXkBBU7XK8vwcCNLLWoIFvEW5L2uq7VnxUjOhATYHAytzANWpnS
         D8YzIjAaya5vgOGJvjqszvbjmEEna339GKmpewbeyNyJx9yYuUJpCz+I+9zw44LLPq1k
         BbKn1Mexba8YT12JAUOZXHb62e7w2LOBL2FbOzw0TZHi+UvIcRY8/iCFNTcIKABEZJW5
         Bl4w/A4C6s3SJKBMv0mEqREDW4hULfhbaeVX0Qis0LGtqwsgduv2EZC24RaPK6ZlpWTN
         8ipR1hgEg8GE/hggZsXZis/Sa49cznfB2vg2QYZAlbCaTHHp5vfoXgFwtCKx01SifqlC
         COAg==
X-Gm-Message-State: AOAM532hWP43jDumI7ECoig+GFUdf5XN8ane7ijpzoRSPieT/wSV9gZN
        GBrFQFWgAe30zY5VFYqw1A==
X-Google-Smtp-Source: ABdhPJxXX+YOeEhgcDWKSkfNLXIBWz00prVnd3MLeNlrI+mv3/+H1OMge+TZPd96SZhjA40HbjDmHw==
X-Received: by 2002:a05:6808:199b:b0:329:92c:4a1e with SMTP id bj27-20020a056808199b00b00329092c4a1emr12342956oib.214.1654013348715;
        Tue, 31 May 2022 09:09:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r4-20020acaf304000000b0032c2d342676sm2226835oih.38.2022.05.31.09.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 09:09:08 -0700 (PDT)
Received: (nullmailer pid 1856290 invoked by uid 1000);
        Tue, 31 May 2022 16:09:07 -0000
Date:   Tue, 31 May 2022 11:09:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
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
Message-ID: <20220531160907.GA1808817-robh@kernel.org>
References: <20220517125058.18488-1-Sergey.Semin@baikalelectronics.ru>
 <20220517125058.18488-3-Sergey.Semin@baikalelectronics.ru>
 <20220526212930.GN54904-robh@kernel.org>
 <20220527160551.dh6fb5n6xbmtjpaa@mobilestation>
 <20220527173953.c4aqlw5jz3xfd727@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527173953.c4aqlw5jz3xfd727@mobilestation>
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

On Fri, May 27, 2022 at 08:39:53PM +0300, Serge Semin wrote:
> On Fri, May 27, 2022 at 07:05:55PM +0300, Serge Semin wrote:
> > On Thu, May 26, 2022 at 04:29:30PM -0500, Rob Herring wrote:
> > > On Tue, May 17, 2022 at 03:50:47PM +0300, Serge Semin wrote:
> > > > Commit c2b0c098fbd1 ("PCI: dwc: Use generic config accessors") replaced
> > > > the locally defined DW PCIe host controller config-space accessors with
> > > > the generic methods pci_generic_config_read() and
> > > > pci_generic_config_write(). It was intended that the corresponding
> > > > bus-mapping callback returned a correct virtual address of the passed PCI
> > > > config-space register. The problem of the proposed solution was that it
> > > > didn't take into account the way the host config-space is accessed on the
> > > > DW PCIe. Depending on the DW PCIe IP-core synthesize parameters different
> > > > interfaces can be used to access the host and peripheral config/memory
> > > > spaces. The former one can be accessed via the DBI interface, while the
> > > > later ones is reached via the AHB/AXI application bus. In case if the DW
> > > > PCIe controller is configured to have a dedicated DBI interface, the way
> > > > it is mapped into the IO-memory turns to be platform-specific. For such
> > > > setups the DWC PCIe driver provides a set of the callbacks
> > > > dw_pcie_ops.{read_dbi,write_dbi} so the platforms glue-drivers would be
> > > > able to take into account the DBI bus IO peculiarities. Since
> > > > commit c2b0c098fbd1 ("PCI: dwc: Use generic config accessors") these
> > > > methods haven't been utilized during the generic host initialization
> > > > performed by the PCIe subsystem code.
> > > > 
> > > > I don't really know how come there have been no problems spotted for the
> > > > Histb/Exynos/Kirin PCIe controllers so far, but in our case with dword
> > > 
> > 
> > > Because they implement their own pci_ops for the root bus. You should 
> > > too.
> > 
> > Right. I should, but I would do that in a more generic way. Please see
> > the next comment.
> > 
> > > 
> > > Who is 'our case'? 
> > > 
> > > > aligned IO requirement the generic config-space accessors can't be
> > > > utilized for the host config-space. Thus in order to make sure the host
> > > > config-space is properly accessed via the DBI bus let's get back the
> > > > dw_pcie_rd_own_conf() and dw_pcie_wr_own_conf() methods. They are going to
> > > > be just wrappers around the already defined
> > > > dw_pcie_read_dbi()/dw_pcie_write_dbi() functions with proper arguments
> > > > conversion. These methods perform the platform-specific config-space IO if
> > > > the DBI accessors are specified, otherwise they call normal MMIO
> > > > operations.
> > > 
> > 
> > > The idea was for DWC to not define its own way to have different 
> > > read/write for root bus vs. child bus as many PCI host bridges need the 
> > > same thing. So the host bridge struct now has 2 pci_ops pointers. And 
> > > the mess of function pointer indirection is gone.
> > 
> > Thanks for clarification. I should have investigated the problem more
> > thoroughly. Now I see what was the reason of that change.  It was
> > indeed wrong to blame the commit c2b0c098fbd1 ("PCI: dwc: Use generic
> > config accessors") that something was done incorrectly. After a more
> > thorough commit inspection I realized that you just replaced the
> > dw_pcie_rd_own_conf() and dw_pcie_wr_own_conf() with the generic
> > pci_generic_config_read and pci_generic_config_write() as they had
> > been equivalent anyway.  I thought they didn't have the same semantic
> > by confusing the dw_pcie_{read,write}() and dw_pcie_{read,write}_dbi()
> > methods usage (see the _dbi suffix) in the original own PCI
> > config-space accessors. So to speak I'll need to drop the Fixes tag
> > with your commit hash from the patch.
> > 
> > Getting back to the own-bus accessors. DW PCIe RP/EP own-config space
> > is accessed over the DBI-bus. If the particular platform is designed
> > in a way so the DBI MMIO space access has some non-specific
> > peculiarities then that platform implements its own read_dbi/write_dbi
> > accessors. In case if these callbacks are defined, the driver must
> > use them for all DBI MMIO accesses including for the ones performed
> > from the subsystem core in the framework of the host own config-space
> > setups. As I mentioned in the patch log currently the only platforms
> > with such requirement happen to be Histb, Exynos and Kirin DW PCIe. As
> > such we can freely get back the generic dw_pcie_rd_own_conf() and
> > dw_pcie_wr_own_conf() methods but use the dw_pcie_{read,write}_dbi()
> > methods in there in the same way as it is done in the Histb, Exynos
> > and Kirin DW PCIe drivers (see their own PCI config-space accessors
> > match). Due to that we can drop the pci_ops redefinition from these
> > platforms and just use the own-config space accessors for all such
> > platforms as it's suggested in this patch. So this modification can be
> > re-qualified to the cleanup one then:
> > 1) Create the generic own config-space accessors (more portable as
> > the DBI-bus access specifics must be always taken into account) as it
> > is suggested in this patch already.

That is the wrong direction IMO. The idea is that well behaved cases 
just use the generic code and avoid any driver specific code. The DWC 
common code is not generic code. It's also keeping with the "don't 
create mid layers" philosophy.

We have generic 32-bit only accessors too (even though that's broken 
h/w, it's broken so often we needed generic accessors), so if that's 
your restriction, then use those. That way, it is very clear which 
drivers (all of them, not just DWC) use generic accessors, have 
alignment restrictions, or something completely custom.

> > 2) Drop the Kirin, Exynos, Histb own config-space re-definition.

Those drivers are special. They get to keep their special code.

> > 3) Drop the dw_pcie_read_dbi() and dw_pcie_write_dbi() methods exporting.
> 
> Alas this can't be implemented. I forgot about the inliners defined in the
> pcie-designware.h file. But the rest of the denoted above cleanups still
> can be (Kirin under question though).
