Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EEC62118D
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 13:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbiKHM4T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 07:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbiKHM4S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 07:56:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9E2202;
        Tue,  8 Nov 2022 04:56:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6102EB81AC8;
        Tue,  8 Nov 2022 12:56:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D463BC433C1;
        Tue,  8 Nov 2022 12:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667912175;
        bh=XvymLCJnXrNHYFs8X6SUfP/5VXUZ4pXi4sc7TkGbZ30=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ISLmN0DVWouF+XbXafAPUQeKdX2a7QdKnBpH3nY8K+cVITbJ3Lr8S6ulKHuIsxTPJ
         b/wM/9VCEOO7f55HLi432H2ar3hYdU088HdKh+PM157cmOaAaEnK+5JkX5ug13lKiJ
         tveEkvnvX3aGhG34N2ClTeGXRmLdYno5+2Wqo38gIyrzQuQdp/PZ57iflb+CXRRAnd
         XfR16wO1OPGfpZeDKy1lk+6nL09vM+QMV0PM0+aHMRc/2kmoSajWgL0vieg3rf+aRp
         Qp2GrIQUuYm4j5I3YdRbw07PTR2rbJv0HngMp0KvUzrnt5Y7qM/0naWlTtCCostKeN
         WJj2zY5EdEMdQ==
Date:   Tue, 8 Nov 2022 06:56:13 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com
Subject: Re: [PATCH v4 0/5] PCI: endpoint: Rework the EPC to EPF notification
Message-ID: <20221108125613.GA463696@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108121440.GA29115@thinkpad>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 08, 2022 at 05:44:40PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Nov 07, 2022 at 02:28:53PM -0600, Bjorn Helgaas wrote:
> > On Tue, Oct 25, 2022 at 08:20:56PM +0530, Manivannan Sadhasivam wrote:
> > > Hello,
> > > 
> > > During the review of the patch that fixes DBI access in PCI EP, Rob
> > > suggested [1] using a fixed interface for passing the events from EPC to
> > > EPF instead of the in-kernel notifiers.
> > 
> > > Manivannan Sadhasivam (5):
> > >   PCI: dra7xx: Use threaded IRQ handler for "dra7xx-pcie-main" IRQ
> > >   PCI: tegra194: Move dw_pcie_ep_linkup() to threaded IRQ handler
> > >   PCI: endpoint: Use a separate lock for protecting epc->pci_epf list
> > >   PCI: endpoint: Use callback mechanism for passing events from EPC to
> > >     EPF
> > >   PCI: endpoint: Use link_up() callback in place of LINK_UP notifier
> > > 
> > >  drivers/pci/controller/dwc/pci-dra7xx.c       |  2 +-
> > >  drivers/pci/controller/dwc/pcie-tegra194.c    |  9 ++++-
> > >  drivers/pci/endpoint/functions/pci-epf-test.c | 38 ++++++-------------
> > >  drivers/pci/endpoint/pci-epc-core.c           | 32 ++++++++++++----
> > >  include/linux/pci-epc.h                       | 10 +----
> > >  include/linux/pci-epf.h                       | 19 ++++++----
> > >  6 files changed, 59 insertions(+), 51 deletions(-)
> > 
> > Doesn't apply cleanly on v6.1-rc1.  Does it depend on something else?
> 
> Yes, this patch:
> https://lore.kernel.org/linux-pci/20220825090101.20474-1-hayashi.kunihiko@socionext.com/
> 
> Since this patch is already merged by Lorenzo, I based this series on top of
> that. If that's not required, I can send a new version without that patch.

I think it's fine as-is.  

I tried applying it on both v6.1-rc1 and my current "next" branch.
Both failed because I haven't merged Lorenzo's branch into "next" yet.
As long as Lorenzo merges this on the correct branch, there's no
problem.  

Mentioning the dependency or what the patch is based on in the cover
letter is the easiest way to make this smoother.

Bjorn
