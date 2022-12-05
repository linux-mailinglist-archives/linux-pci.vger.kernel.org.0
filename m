Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85858642E00
	for <lists+linux-pci@lfdr.de>; Mon,  5 Dec 2022 17:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbiLEQzz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Dec 2022 11:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiLEQzg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2022 11:55:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CBCCE3B
        for <linux-pci@vger.kernel.org>; Mon,  5 Dec 2022 08:53:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B4E4B81183
        for <linux-pci@vger.kernel.org>; Mon,  5 Dec 2022 16:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FF5C433D7;
        Mon,  5 Dec 2022 16:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670259219;
        bh=ap1mfsBv8q3XPZhEzL39o1w74V7H3SYD4rvHgyZ08Wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FFgj1XuQ/wYvo9Rgs6HyOq4WJRvPNp7LQ2XxI7SwHEXlENoYtu2AOKCjMqPqHJm0/
         tWoMAi7IwOo+VoYGMo7UYsY7Tq2954dGHJTaJjvMxv/FglVUYdTURx+A7dh5CobxGk
         Vl7PyKdSbsSkOo7YCu5KZtJfSlOPvJvc8CP3I8zro1CXG3G1SIgxAu3xZTFcsZOrYI
         SCRIqyh8nltloTnI38Vr+b0fquZCNxFD01SS0sMv9ci0qwtqLaEf4kNaLzB0vWpU1+
         9I8jmkWC+S8XwMgz6s2ldgZB3e516fackmqjCWYsJo0umMaKxl58dJTYNAmkqLp6Hg
         LusMBEV6BmG9w==
Date:   Mon, 5 Dec 2022 17:53:33 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     "Munoz Ruiz, Francisco" <francisco.munoz.ruiz@linux.intel.com>
Cc:     helgaas@kernel.org, alex.williamson@redhat.com,
        myron.stowe@redhat.com, lorenzo.pieralisi@arm.com,
        jonathan.derrick@linux.dev, linux-pci@vger.kernel.org,
        Nirmal Patel <nirmal.patel@linux.intel.com>
Subject: Re: [PATCH V3] PCI: vmd: Fix secondary bus reset for Intel bridges
Message-ID: <Y44iDYgQ9h7/UNgM@lpieralisi>
References: <20221103201407.3158-1-francisco.munoz.ruiz@linux.intel.com>
 <ea3fe84c-ec76-86d9-5ec6-22bf73c47756@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea3fe84c-ec76-86d9-5ec6-22bf73c47756@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 28, 2022 at 03:38:24PM -0800, Munoz Ruiz, Francisco wrote:
> On 11/3/2022 1:14 PM, francisco.munoz.ruiz@linux.intel.com wrote:
> > From: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
> > 
> > The reset was never applied in the current implementation because Intel
> > Bridges owned by VMD are parentless. Internally, pci_reset_bus() applies
> > a reset to the parent of the PCI device supplied as argument, but in this
> > case it failed because there wasn't a parent.

Please add a comment in the *code* as well and explain why it is so.

> > In more detail, this change allows the VMD driver to enumerate NVMe devices
> > in pass-through configurations when guest reboots are performed. Commit id
> > 6aab5622296b ("PCI: vmd: Clean up domain before enumeration") attempted to
> > fix this, but later we discovered that the code inside pci_reset_bus() wasn’t
> > triggering secondary bus resets.  Therefore, we updated the parameters passed
> > to it, and now NVMe SSDs attached to VMD bridges are properly enumerated in
> > VT-d pass-through scenarios.

I am not sure this helps much - I'd rather explain why the device
hierarchy in VMD is as it is - when that's explained is rather clear
why the current reset is NOP and this patch is needed.

> > Signed-off-by: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
> > Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> > Reviewed-by: Jonathan Derrick <jonathan.derrick@linux.dev>
> > ---
> > V3:
> >     - Add WARN_ON
> >     - Include Jonathan as reviewer
> >     - Update commit message
> > V2:
> >     - Update commit message
> > 
> >  drivers/pci/controller/vmd.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > index e06e9f4fc50f..2406be6644f3 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -859,8 +859,17 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> >  
> >  	pci_scan_child_bus(vmd->bus);
> >  	vmd_domain_reset(vmd);
> > -	list_for_each_entry(child, &vmd->bus->children, node)
> > -		pci_reset_bus(child->self);
> > +
> > +	list_for_each_entry(child, &vmd->bus->children, node) {
> > +		if (!list_empty(&child->devices)) {
> > +			ret = pci_reset_bus(list_first_entry(&child->devices,
> > +							     struct pci_dev,
> > +							     bus_list));
> > +			WARN_ON(ret);

Technically you are adding a WARN_ON() here to make sure that a failed
reset is detected - I am not sure a backtrace is really required,
a pci_warn() maybe ?

Lorenzo

> > +			break;
> > +		}
> > +	}
> > +
> >  	pci_assign_unassigned_bus_resources(vmd->bus);
> >  
> >  	/*
> 
> 
> Hi,
> 
> Just a gentle reminder for this one
> 
> Best wishes,
> Francisco.
