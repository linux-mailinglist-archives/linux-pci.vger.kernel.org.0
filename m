Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F89706D93
	for <lists+linux-pci@lfdr.de>; Wed, 17 May 2023 18:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjEQQDC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 May 2023 12:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjEQQDB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 May 2023 12:03:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA591706;
        Wed, 17 May 2023 09:03:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1B98644BC;
        Wed, 17 May 2023 16:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BEAC433D2;
        Wed, 17 May 2023 16:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684339379;
        bh=XEUGLjgsvQzAyDLKC/1cWemgrt9p4X70cKwfQqfNFVM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HRIrO/lvsge46jtx3D/H5ni/QHrwKrq+SQbPcWG3gfZaAb0LI4MU0eeaPh8eGezoa
         eKMW44oZXF2MVrmMTK6JEhL9V9WW4TJSa/xrFVwyIeWkTky7xJAvm45RXgQ8Oe5KCr
         eOJZpp4wblXyIhuUksLv/Wp3yP0r5ixHunJzxn02L22Zx+1or1j1ZnFoOf4U9b9q6z
         GxpjHFiKPBj2eRjX0sHjDSdTTaaTQkRmlKCCwPWcTjmxupgYPiO7GtMnP4+HeJjdDP
         lJvPtuzxrv9ZvBtMMHGIj/uMqUhiFh1NyNdHJ2enAlodykiOMNBG2iGtYNPsIQ7QC+
         j4wcboCC7NIaA==
Date:   Wed, 17 May 2023 11:02:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Grant Grundler <grundler@chromium.org>
Cc:     Rajat Jain <rajatja@chromium.org>,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        linux-pci@vger.kernel.org,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Oliver O 'Halloran <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCHv2 pci-next 2/2] PCI/AER: Rate limit the reporting of the
 correctable errors
Message-ID: <ZGT6sTOtk+WY3aYt@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANEJEGsE6KS484iSLkKV8hx2nNThZGfaaz+u+R-A3X5nRev6Gg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 07, 2023 at 04:46:03PM -0700, Grant Grundler wrote:
> On Fri, Apr 7, 2023 at 12:46 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Apr 07, 2023 at 11:53:27AM -0700, Grant Grundler wrote:
> > > On Thu, Apr 6, 2023 at 12:50 PM Bjorn Helgaas <helgaas@kernel.org>
> > wrote:
> > > > On Fri, Mar 17, 2023 at 10:51:09AM -0700, Grant Grundler wrote:
> > > > > From: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> > > > >
> > > > > There are many instances where correctable errors tend to inundate
> > > > > the message buffer. We observe such instances during thunderbolt PCIe
> > > > > tunneling.
> > > ...
> >
> > > > >               if (info->severity == AER_CORRECTABLE)
> > > > > -                     pci_info(dev, "   [%2d] %-22s%s\n", i, errmsg,
> > > > > -                             info->first_error == i ? " (First)" :
> > "");
> > > > > +                     pci_info_ratelimited(dev, "   [%2d]
> > %-22s%s\n", i, errmsg,
> > > > > +                                          info->first_error == i ?
> > " (First)" : "");
> > > >
> > > > I don't think this is going to reliably work the way we want.  We have
> > > > a bunch of pci_info_ratelimited() calls, and each caller has its own
> > > > ratelimit_state data.  Unless we call pci_info_ratelimited() exactly
> > > > the same number of times for each error, the ratelimit counters will
> > > > get out of sync and we'll end up printing fragments from error A mixed
> > > > with fragments from error B.
> > >
> > > Ok - what I'm reading between the lines here is the output should be
> > > emitted in one step, not multiple pci_info_ratelimited() calls. if the
> > > code built an output string (using sprintnf()), and then called
> > > pci_info_ratelimited() exactly once at the bottom, would that be
> > > sufficient?
> > >
> > > > I think we need to explicitly manage the ratelimiting ourselves,
> > > > similar to print_hmi_event_info() or print_extlog_rcd().  Then we can
> > > > have a *single* ratelimit_state, and we can check it once to determine
> > > > whether to log this correctable error.
> > >
> > > Is the rate limiting per call location or per device? From above, I
> > > understood rate limiting is "per call location".  If the code only
> > > has one call location, it should achieve the same goal, right?
> >
> > Rate-limiting is per call location, so yes, if we only have one call
> > location, that would solve it.  It would also have the nice property
> > that all the output would be atomic so it wouldn't get mixed with
> > other stuff, and it might encourage us to be a little less wordy in
> > the output.
> >
> 
> +1 to all of those reasons. Especially reducing the number of lines output.
> 
> I'm going to be out for the next week. If someone else (Rajat Kendalwal
> maybe?) wants to rework this to use one call location it should be fairly
> straight forward. If not, I'll tackle this when I'm back (in 2 weeks
> essentially).

Ping?  Really hoping to merge this for v6.5.

Bjorn
