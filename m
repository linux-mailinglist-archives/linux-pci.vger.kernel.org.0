Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F2E5AB982
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 22:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiIBUiy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 16:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiIBUiy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 16:38:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A13F8FFD;
        Fri,  2 Sep 2022 13:38:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 787F1B82D95;
        Fri,  2 Sep 2022 20:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C16C433C1;
        Fri,  2 Sep 2022 20:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662151130;
        bh=bppvucAj3l5e//PPm3yt+dtiLgpAyTt846A1ijo6y0U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rzkJirI5p1i5UDSZkkxuOW/BHJaWB+TrqKO544osf76U6Vyu0BUenhEXPibeWmuWi
         hL26+RyWXUzN9NGFwhImJomrlu3y+dlco4kkf8DbFnNPwNMEgounc3gm6FAKGFhqSA
         weYyKAeHBiT2XIgnnlkgNovG+X6kJJ0DMBuqkIOMQ5CwfoIHKVh4I7RPSl0gP7ZsnK
         xGJRcHXfealMoir75W+KEhtbOkTiAr9dGIYeT6KZFPADvrm58Lh4KTgp6f2Ueim+rf
         5YLxgdS3kvTYW9Nad3ahKbNK14tTCJp4RYynbqD07Xs9xTG7+EcDVOj75ZHGy3AveD
         lFh5Ke93LM+lg==
Date:   Fri, 2 Sep 2022 15:38:48 -0500
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
Subject: Re: [PATCH 1/4] PCI/PTM: Preserve PTM Root Select
Message-ID: <20220902203848.GA370638@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5618f97-deb6-c38e-2c2c-dbe1e4e1e496@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 02, 2022 at 10:24:05AM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 9/2/22 7:58 AM, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > When disabling PTM, there's no need to clear the Root Select bit.  We
> > disable PTM during suspend, and we want to re-enable it during resume.
> > Clearing Root Select here makes re-enabling more complicated.
> 
> Currently, it looks like we disable PCI_PTM_CTRL_ROOT in pci_disable_ptm(),
> but not enable it in pci_enable_ptm(). Do you know this did not trigger an
> issue?

For Root Ports and Switches, we enable PTM (and set Root Select when
appropriate) during enumeration in pci_ptm_init().  This is based on
the assumption that enabling PTM in Root Ports and Switches is a no-op
unless there's an Endpoint that generates PTM Requests.  (It turns out
that's not quite true, because Kai-Heng's bug report [1] shows the
08:00.0 Switch sending PTM Requests even though no Endpoint even has a
PTM Capability.)

If we didn't enable PTM in Root Ports and Switches during enumeration,
we'd have to walk the whole path and enable them when enabling PTM for
an Endpoint.

pci_enable_ptm() currently only works for Endpoints, which cannot be
PTM Roots, so it never has to set PCI_PTM_CTRL_ROOT.

If we clear PCI_PTM_CTRL_ROOT in pci_disable_ptm(), it will never get
set again unless we re-enumerate the Root Port.

Thanks for asking this, because it reminds me why I didn't add
pci_enable_ptm() calls in the resume paths!  That would make them
parallel with the suspend paths, which would definitely be nice.  But
we would have to rework pci_enable_ptm() to work for Root Ports and
Switch Ports as well.  I think we *could* do that.  What do you think?

Regardless of that question, I think it's unnecessary to clear
PCI_PTM_CTRL_ROOT in pci_disable_ptm(), so we should leave it alone.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=215453

> Also, you mentioned that it is complicated to enable it, can you add some
> details?
> 
> > Per PCIe r6.0, sec 7.9.15.3, "When set, if the PTM Enable bit is also Set,
> > this Time Source is the PTM Root," so if PTM Enable is cleared, the value
> > of Root Select should be irrelevant.
> > 
> > Preserve Root Select to simplify re-enabling PTM.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: David E. Box <david.e.box@linux.intel.com>
> > ---
> >  drivers/pci/pcie/ptm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> > index 368a254e3124..b6a417247ce3 100644
> > --- a/drivers/pci/pcie/ptm.c
> > +++ b/drivers/pci/pcie/ptm.c
> > @@ -42,7 +42,7 @@ void pci_disable_ptm(struct pci_dev *dev)
> >  		return;
> >  
> >  	pci_read_config_word(dev, ptm + PCI_PTM_CTRL, &ctrl);
> > -	ctrl &= ~(PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT);
> > +	ctrl &= ~PCI_PTM_CTRL_ENABLE;
> >  	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
> >  }
> >  
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
