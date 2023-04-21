Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316546EA661
	for <lists+linux-pci@lfdr.de>; Fri, 21 Apr 2023 10:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjDUI5t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Apr 2023 04:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjDUI5K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Apr 2023 04:57:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E5FAD2D;
        Fri, 21 Apr 2023 01:57:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F62964F27;
        Fri, 21 Apr 2023 08:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C721C4339B;
        Fri, 21 Apr 2023 08:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682067426;
        bh=t8v8dLRsnYx47vAxdyVg73rNZv8zRUp4UmcnB1X3BgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yk9OzOGpJ1Sr+kvHXFqjf1bbRn20gAXUy543NmXYs0+lDumbj2Mbs3bIO2O9FAVP1
         I6NYHikKX+mSFjKBspgaA02OxtlVyc7SBfbekh73gVvBo576pGmUFO3eX2AK9mlR3r
         +r54aXfA3mqcLp/vDAAR0TzWsBahfRVKEJMSX88hpk0bSvIsop3dNOKgZTOwv8qZPl
         6fCzXElPKTFME9SepeEghD3i4Q0U00Lk7VI5KP5NL4WtsN+jes61B5cjxgcizbx6AR
         hbZOogkTOZ7Ks7mqhUFtwiT7SgYoCudEMAIJHlg//WPNxzliiakJgZRBdaQgK6coy/
         TqoyW1kXnex3Q==
Date:   Fri, 21 Apr 2023 10:57:00 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Siddharth Vadapalli <s-vadapalli@ti.com>, tjoseph@cadence.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        nadeem@cadence.com, "Raghavendra, Vignesh" <vigneshr@ti.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srk@ti.com, nm@ti.com
Subject: Re: [PATCH v2] PCI: cadence: Fix Gen2 Link Retraining process
Message-ID: <ZEJP3NuOlvKyYyEe@lpieralisi>
References: <646f0efe-d2b6-8bda-9629-fb9615cf4b52@ti.com>
 <20230330170218.GA3155390@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330170218.GA3155390@bhelgaas>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 30, 2023 at 12:02:18PM -0500, Bjorn Helgaas wrote:
> On Thu, Mar 30, 2023 at 09:52:06AM +0530, Siddharth Vadapalli wrote:
> > Hello Bjorn,
> > 
> > On 29/03/23 22:38, Bjorn Helgaas wrote:
> > > On Wed, Mar 29, 2023 at 08:11:25PM +0530, Raghavendra, Vignesh wrote:
> > >> Hi Lorenzo, Bjorn,
> > >>
> > >> On 3/15/2023 12:38 PM, Siddharth Vadapalli wrote:
> > >>> The Link Retraining process is initiated to account for the Gen2 defect in
> > >>> the Cadence PCIe controller in J721E SoC. The errata corresponding to this
> > >>> is i2085, documented at:
> > >>> https://www.ti.com/lit/er/sprz455c/sprz455c.pdf
> > >>>
> > >>> The existing workaround implemented for the errata waits for the Data Link
> > >>> initialization to complete and assumes that the link retraining process
> > >>> at the Physical Layer has completed. However, it is possible that the
> > >>> Physical Layer training might be ongoing as indicated by the
> > >>> PCI_EXP_LNKSTA_LT bit in the PCI_EXP_LNKSTA register.
> > >>>
> > >>> Fix the existing workaround, to ensure that the Physical Layer training
> > >>> has also completed, in addition to the Data Link initialization.
> > >>>
> > >>> Fixes: 4740b969aaf5 ("PCI: cadence: Retrain Link to work around Gen2 training defect")
> > >>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > >>> Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
> > >>> ---
> > >>> Changes from v1:
> > >>> 1. Collect Reviewed-by tag from Vignesh Raghavendra.
> > >>> 2. Rebase on next-20230315.
> > >>>
> > >>> v1:
> > >>> https://lore.kernel.org/r/20230102075656.260333-1-s-vadapalli@ti.com
> > >>>
> > >>>  .../controller/cadence/pcie-cadence-host.c    | 27 +++++++++++++++++++
> > >>>  1 file changed, 27 insertions(+)
> > >>
> > >> Wondering do one of you be pulling this patch in? This patch was never
> > >> picked for 6.3-rc1 merge cycle... Just want to make sure
> > >> pcie-cadence*.c and pci-j721e.c patches have a path to reach pci tree.
> > > 
> > > Yes, Lorenzo or Krzysztof will likely pick this up.  I think Lorenzo
> > > is out of the office this week.
> > > 
> > > Drive-by comment: the current patch doesn't seem to give any
> > > indication to the user when cdns_pcie_host_training_complete() times
> > > out.  Is that timeout potentially of interest to a user?  Should there
> > > be a log message there?
> > 
> > Thank you for reviewing the patch. The return value of -ETIMEDOUT from the
> > function cdns_pcie_host_training_complete() added by this patch will be handled
> > similar to the -ETIMEDOUT from the cdns_pcie_host_wait_for_link() function that
> > is already present.
> > 
> > If cdns_pcie_host_training_complete() returns -ETIMEDOUT, it is returned to
> > cdns_pcie_host_start_link() function which is called within
> > cdns_pcie_host_setup() function. In the cdns_pcie_host_setup() function, there
> > is already a dev_dbg() print for handling the case where
> > cdns_pcie_host_wait_for_link() times out. For this reason, I felt that for both
> > cases, the dev_dbg() print can be used to debug without the need for an extra
> > log message. Please let me know if that's fine.
> 
> Sounds good.
> 
> dev_dbg() wouldn't be the right thing if we *expect* the link to come
> up, but ISTR that maybe you can't detect device presence directly.  If
> that's the case, all you can do is try to bring the link up and assume
> the slot is empty if it doesn't come up.  If the usual reason for the
> timeout is that the slot is empty, dev_dbg() should be fine.
> 
> Another drive-by comment, no action needed, seems slightly strange to
> have two "start_link" functions called one after the other:
> 
>   cdns_pcie_host_setup
>     cdns_pcie_start_link
>     cdns_pcie_host_start_link
> 
> I assume both are for the same link, so it's weird to have two
> functions for it.

Side note: I would advise developers to reply to review comments
before nagging us to merge patches, it is not fine to leave
comments unanswered.

Yes, it is weird, the first call is for the platform driver specific
link HW setup and the second for the host *generic* link set-up and I
agree that's confusing, it is not related to this patch - that I am
merging - but should be addressed nonetheless.

Lorenzo
