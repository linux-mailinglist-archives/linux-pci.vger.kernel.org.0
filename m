Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DF86CF0AC
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 19:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjC2RJl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 13:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjC2RJ0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 13:09:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6E68691;
        Wed, 29 Mar 2023 10:08:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46295B823EB;
        Wed, 29 Mar 2023 17:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D3FC433EF;
        Wed, 29 Mar 2023 17:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680109696;
        bh=3nQ3Rw35o9dHhDUM7vmqb4idgnB+u/V0GsVDJC/63+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gbl1M8eD9gB2IGQLyuHAaoTzCOIM5aJBK4UNA9a129HfqjIgk5OLT00JsW3LrfMwi
         BS3wnvrsuGevSBWjhRFM92KYcTUOxGjXeVHURXAWUv/9mnQDB24FCwZImZH2HsARFK
         IlhvkokEZXN7acrrZk3ygEf1vdRw2NueWhDlGCDj+STh7GnMOqXbmvj5tD1Ysbzyhu
         lp8ABUqSEQpXusl9+/8zrwUDSE0/ZeQhHMVyH/rDOnH/IcmQua1kH2Fn7QmVJi/aJd
         bCPHmVxcvMZcLDMOeqQ7VlKVTHgunp5inST5gQp164syoX8E0DdOxpNBNFwNZndVly
         OgS83RCZj9AFg==
Date:   Wed, 29 Mar 2023 12:08:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Raghavendra, Vignesh" <vigneshr@ti.com>
Cc:     Siddharth Vadapalli <s-vadapalli@ti.com>, tjoseph@cadence.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, nadeem@cadence.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srk@ti.com, nm@ti.com
Subject: Re: [PATCH v2] PCI: cadence: Fix Gen2 Link Retraining process
Message-ID: <20230329170814.GA3067800@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12c89cb8-8cea-df6a-7650-fa3059bf5a5b@ti.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 29, 2023 at 08:11:25PM +0530, Raghavendra, Vignesh wrote:
> Hi Lorenzo, Bjorn,
> 
> On 3/15/2023 12:38 PM, Siddharth Vadapalli wrote:
> > The Link Retraining process is initiated to account for the Gen2 defect in
> > the Cadence PCIe controller in J721E SoC. The errata corresponding to this
> > is i2085, documented at:
> > https://www.ti.com/lit/er/sprz455c/sprz455c.pdf
> > 
> > The existing workaround implemented for the errata waits for the Data Link
> > initialization to complete and assumes that the link retraining process
> > at the Physical Layer has completed. However, it is possible that the
> > Physical Layer training might be ongoing as indicated by the
> > PCI_EXP_LNKSTA_LT bit in the PCI_EXP_LNKSTA register.
> > 
> > Fix the existing workaround, to ensure that the Physical Layer training
> > has also completed, in addition to the Data Link initialization.
> > 
> > Fixes: 4740b969aaf5 ("PCI: cadence: Retrain Link to work around Gen2 training defect")
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
> > ---
> > Changes from v1:
> > 1. Collect Reviewed-by tag from Vignesh Raghavendra.
> > 2. Rebase on next-20230315.
> > 
> > v1:
> > https://lore.kernel.org/r/20230102075656.260333-1-s-vadapalli@ti.com
> > 
> >  .../controller/cadence/pcie-cadence-host.c    | 27 +++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> 
> Wondering do one of you be pulling this patch in? This patch was never
> picked for 6.3-rc1 merge cycle... Just want to make sure
> pcie-cadence*.c and pci-j721e.c patches have a path to reach pci tree.

Yes, Lorenzo or Krzysztof will likely pick this up.  I think Lorenzo
is out of the office this week.

Drive-by comment: the current patch doesn't seem to give any
indication to the user when cdns_pcie_host_training_complete() times
out.  Is that timeout potentially of interest to a user?  Should there
be a log message there?

Bjorn
