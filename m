Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82605F6E1D
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 21:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiJFTVy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 15:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiJFTVw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 15:21:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1F4A6C0A
        for <linux-pci@vger.kernel.org>; Thu,  6 Oct 2022 12:21:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C55F0B8210B
        for <linux-pci@vger.kernel.org>; Thu,  6 Oct 2022 19:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A34C433C1;
        Thu,  6 Oct 2022 19:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665084107;
        bh=svyzltLU3oso/5bu6iwu8cpKBvcleVj24YymFsySoxc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uSCDO6zogSdGqhKfEBv0hneDRD2goP7DpRJJ9xSz8LN4bLLym69Bx0eHvJkLQdeI5
         ltkM6hWP9pESGC4An8aCsOnbxELelIA/D58xP653D4C7gBUfso3+ql09/Wja24H0zC
         UWzwxSXnKM3/KzXUYCZ8luZP5bzqoGfxWcjnoBqDFP2d8Y3O8p8+R1fACXkk3vvLqY
         3tBMwnR45cOBpCSStcN9zCIrkTFfaLlK56BNLGurSPH2V5U6kRMtBdEa8IkAx04Xh7
         j8kB+EWvqi6CHj/UdQerSox+fpxGWBDBvcpzYPWfw6DdeNCosJfipyC2U9UcCc5v1G
         3SwiNCuEsc2xA==
Date:   Thu, 6 Oct 2022 14:21:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Munoz Ruiz, Francisco" <francisco.munoz.ruiz@linux.intel.com>
Cc:     lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: Re: [PATCH] PCI: vmd: Fix secondary bus reset for Intel bridges
Message-ID: <20221006192145.GA2559324@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b1e5bc3-78ab-2ad6-58b8-103bc974a833@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 06, 2022 at 11:26:08AM -0700, Munoz Ruiz, Francisco wrote:
> Hi,
> 
> Please let me know if something else is needed.

We're in the merge window now, so it's too late for v6.1, but we'll
start merging v6.2 changes about Oct 17.

> On 9/26/2022 2:07 PM, Jonathan Derrick wrote:
> > On 9/23/2022 2:37 PM, francisco.munoz.ruiz@linux.intel.com wrote:
> > > From: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
> > > 
> > > The reset was never applied in the current implementation because Intel
> > > Bridges owned by VMD are parentless. Internally, the reset API applies
> > > a reset to the parent of the pci device supplied as argument, but in this
> > > case it failed because there wasn't a parent. This change feeds a child
> > > device of an Intel Bridge to the reset API and internally the reset is
> > > applied to its parent.
> > > 
> > > Signed-off-by: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
> > > Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> > Reviewed-by: Jonathan Derrick <jonathan.derrick@linux.dev>
> > 
> > > ---
> > >   drivers/pci/controller/vmd.c | 12 ++++++++++--
> > >   1 file changed, 10 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > > index e06e9f4fc50f..34d6ba675440 100644
> > > --- a/drivers/pci/controller/vmd.c
> > > +++ b/drivers/pci/controller/vmd.c
> > > @@ -859,8 +859,16 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> > >   	pci_scan_child_bus(vmd->bus);
> > >   	vmd_domain_reset(vmd);
> > > -	list_for_each_entry(child, &vmd->bus->children, node)
> > > -		pci_reset_bus(child->self);
> > > +
> > > +	list_for_each_entry(child, &vmd->bus->children, node) {
> > > +		if (!list_empty(&child->devices)) {
> > > +			pci_reset_bus(list_first_entry(&child->devices,
> > > +						       struct pci_dev,
> > > +						       bus_list));
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > >   	pci_assign_unassigned_bus_resources(vmd->bus);
> > >   	/*
