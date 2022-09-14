Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EE45B906F
	for <lists+linux-pci@lfdr.de>; Thu, 15 Sep 2022 00:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiINWL6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 18:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiINWL5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 18:11:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16A57549B;
        Wed, 14 Sep 2022 15:11:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B7F161F29;
        Wed, 14 Sep 2022 22:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857A0C433C1;
        Wed, 14 Sep 2022 22:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663193515;
        bh=BnF2TDVtyS4VX+tPuDmdHeBCBzqU3dUaX5kwgHda+aU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ELJbhuqiVk0GA+wGBAYt3n8AAd+xCNeUhE739AZh36lVPK7bpqCrLtnyRAE2ohAXq
         tGaHrDDbi1rvT+6zbfM9eudmCj8Frfv1ixDeEO8LfVaY1oszD+W6iEuBeFz8SpZKk0
         YoaYlodrzKSd/Y5QABchVT3jutLRXR0R806R3t3hgkbFi9Y+K6wtJJ3HCDsBGUyIQ+
         yegosUXNApXlrMwb5Brynz2SGdj2oHh4wlOBZuzNZAbUnZoUx/xeup0N8YSXsLliat
         dBUg3JYsYwUiTPgzUxaRm7Ovpf0gGaDc+4yu5ONzEQ2LRypzF567//Ln4oQpPbCXYc
         R1/6Zf2yj1sJw==
Date:   Wed, 14 Sep 2022 17:11:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Robert Richter <rrichter@amd.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 06/15] PCI/ACPI: Link host bridge to its ACPI fw node
Message-ID: <20220914221154.GA710889@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxsTfVdOgc9sOOVm@rric.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 09, 2022 at 12:20:45PM +0200, Robert Richter wrote:
> On 08.09.22 12:45:16, Dan Williams wrote:
> > Rafael J. Wysocki wrote:
> > > On Thu, Sep 8, 2022 at 8:05 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > > >
> > > > Robert Richter wrote:
> > > > > A lookup of a host bridge's corresponding acpi device (struct
> > > > > acpi_device) is not possible, for example:
> > > > >
> > > > >       adev = ACPI_COMPANION(&host_bridge->dev);
> > > > >
> > > > > This could be useful to find a host bridge's fwnode handle and to
> > > > > determine and call additional host bridge ACPI parameters and methods
> > > > > such as HID/CID or _UID.

> ...
> No, it is x86. And true, it is set. So this series is actually working
> without this patch. It can be dropped.
> 
> Now, I just checked my logs. The reason I was adding this is that
> during code development I modified the code to have bridge->dev.parent
> set. Then, the fwnode is not linked. I later dropped that change but
> kept this patch.

If this patch does the same thing as the ACPI_COMPANION_SET() in
several pcibios_root_bridge_prepare() implementations, I would love to
keep this patch, which does it in a generic place, and drop the
corresponding code from those arch-specific functions.

But I don't understand the fwnode stuff well enough to know if this is
feasible.

Bjorn
