Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C105AB988
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 22:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiIBUln (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 16:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIBUlm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 16:41:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED1EFBA40;
        Fri,  2 Sep 2022 13:41:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02F1F61173;
        Fri,  2 Sep 2022 20:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30202C433C1;
        Fri,  2 Sep 2022 20:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662151300;
        bh=6QlO4nz3EjJTiHZOSW3Y1nsOMZEgsGLzRZeWwqrgPwk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=laupyLzJHEyaAM+ILEF68RWgAeBDPfzLOzyKzZy8NKXhw2NeQjo2SGmWbGx0mUj3H
         5nkLFvF0sbm9alfGdetu3nCgvNOqqkC1MwJI45swjOG613hs2kZkIHBqHsBSRjbnlA
         qFIWmNzOQZo2pJ4e/tDe7nqJ3aXU9hRUlL0Q2VpkdW6z9nTVNJIirO/u7IB316MN38
         g+PWfVu0EPvjC+3k80nYvDa/EJdEg2AxdoyhpGRSA8K24QZ/W2BbJt4qYoOaLvIByX
         DOoOQAT4OeQoMOWJtBXxDJ2Ye9N9JzTQHoznKmT7qk/X8P/QplMUbQHjAWl5GfuLPe
         rZuaTwewjAqDg==
Date:   Fri, 2 Sep 2022 15:41:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Koba Ko <koba.ko@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/4] PCI/PTM: Enable PTM when restoring state
Message-ID: <20220902204138.GA357053@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be3a0ed4-c5d0-d4ba-79da-f346d9d7d08b@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 02, 2022 at 10:25:54AM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 9/2/22 7:58 AM, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > The suspend path may disable PTM before saving config state, which means
> > the PCI_PTM_CTRL_ENABLE bit in the saved state may be cleared even though
> > we want PTM to be enabled when resuming.
> 
> If suspend is disabling PTM separately, why not enable it during the resume
> operation? Why club it with PTM state restoration?

The long answer is in my previous reply [1].  The short answer is that
pci_enable_ptm() only works with Endpoints, so if we enable PTM in the
resume path, we need to rework it to handle Root Ports and Switch
Ports as well.

[1] https://lore.kernel.org/r/20220902203848.GA370638@bhelgaas

> > If "dev->ptm_enabled" is set, it means PTM should be enabled, so make sure
> > PCI_PTM_CTRL_ENABLE is set when restoring the PTM state.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/pcie/ptm.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> > index b6a417247ce3..3115601a85ef 100644
> > --- a/drivers/pci/pcie/ptm.c
> > +++ b/drivers/pci/pcie/ptm.c
> > @@ -82,6 +82,14 @@ void pci_restore_ptm_state(struct pci_dev *dev)
> >  		return;
> >  
> >  	cap = (u16 *)&save_state->cap.data[0];
> > +
> > +	/*
> > +	 * The suspend path may disable PTM before saving config state.
> > +	 * Make sure PCI_PTM_CTRL_ENABLE is set if PTM should be enabled.
> > +	 */
> > +	if (dev->ptm_enabled)
> > +		*cap |= PCI_PTM_CTRL_ENABLE;
> > +
> >  	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, *cap);
> >  }
> >  
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
