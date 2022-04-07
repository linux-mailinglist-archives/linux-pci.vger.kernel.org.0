Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1730B4F8478
	for <lists+linux-pci@lfdr.de>; Thu,  7 Apr 2022 18:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbiDGQDY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Apr 2022 12:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiDGQDW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2022 12:03:22 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C161DEA81;
        Thu,  7 Apr 2022 09:01:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B4FBECE27EE;
        Thu,  7 Apr 2022 16:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04483C385A5;
        Thu,  7 Apr 2022 16:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649347278;
        bh=yAnO4c7MDGXcf6Gal/+bTFrLqSTatoGBMYjleu4Ss1Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uM+vZOCA5IzJZCsNSrAwwXCQY5jXsP16RBrgP9QPhmPtbO18pA/p6hfvg/57+7Yso
         eE0k1MYJZtSZua5T9kMskawRJBhAdmofen15mx0p4YcU7F6J2Ate+Uy7U6obPMuizX
         m2T4u2m5a7B+PYlVK1IyT/nwdjwwzJm/Ct1jIJIHitF6YPgUzeacK00CrIh9nxo3uN
         PS2NRkLzeDEzDRqIQOvVqUy1vmMTrdaDUO7N50sT1JNQcV4odlcprUkUB7VXqI5lSy
         WhSDkQAN5baOCzlGDwu+pnIqM8237y8XAV6uijFUXe+9obFohCdduB1rbO6AecohqC
         /pVOZ+QafMZHw==
Date:   Thu, 7 Apr 2022 11:01:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V7 03/10] PCI: Create PCI library functions in support of
 DOE mailboxes.
Message-ID: <20220407160116.GA239672@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk4EvRDd/Kw5rEil@iweiny-desk3>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 06, 2022 at 02:23:09PM -0700, Ira Weiny wrote:
> On Wed, Apr 06, 2022 at 11:11:10AM +0100, Jonathan Cameron wrote:
> > On Tue, 5 Apr 2022 16:22:11 -0700
> > Ira Weiny <ira.weiny@intel.com> wrote:
> > > On Sat, Apr 02, 2022 at 04:48:45PM +0200, Lukas Wunner wrote:
> > > > On Thu, Mar 31, 2022 at 08:19:56AM -0700, Ira Weiny wrote:  
> > > > > On Wed, Mar 30, 2022 at 10:50:31PM -0700, Christoph Hellwig wrote:  
> > > > > > On Wed, Mar 30, 2022 at 04:59:13PM -0700, ira.weiny@intel.com wrote:  
> > > > > > > Introduced in a PCI v6.0[1], DOE provides a config space based mailbox
> > > > > > > with standard protocol discovery.  Each mailbox is accessed through a
> > > > > > > DOE Extended Capability.  
> > > > > > 
> > > > > > I really don't think this should be built unconditionally and bloat
> > > > > > every single kernel built with PCI support.  
> > > > > 
> > > > > I can add a Kconfig.  
> > > > 
> > > > Ideally, that config option should live in the pcie/ subdirectory,
> > > > i.e. in drivers/pci/pcie/Kconfig, alongside drivers/pci/pcie/doe.c,
> > > > as we try to consolidate PCIe-specific features there and reserve
> > > > core code in drivers/pci/*.c for functionality that also applies
> > > > to Conventional PCI.  
> > > 
> > > Thanks for letting me know about this direction.  I was unaware of this.
> > 
> > We had this in the pcie directory, but Bjorn asked us to move it to the pci
> > directory as there isn't anything specific to PCIe about DOE. You could
> > implement it on pci-x (maybe 2.0?) I think even though it's in the PCIe specification.
> > 
> > https://lore.kernel.org/linux-pci/20210413194927.GA2241331@bjorn-Precision-5520/
> 
> :-/
> 
> I'd forgotten that far back.
> 
> Bjorn?

I would still prefer it in drivers/pci because I don't think
there's enough value to justify the pcie/ subdirectory.  We have
ats.c, ecam.c, iov.c, pci-pf-stub.c, and vc.c in drivers/pci even
though they're PCIe-specific.  Other files in drivers/pci like
access.c, pci-acpi.c, pci.c, probe.c, etc also have some PCIe
content.

Bjorn
