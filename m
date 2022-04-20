Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D7C508D56
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 18:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354147AbiDTQdV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 12:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355756AbiDTQdR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 12:33:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F300B43EDC;
        Wed, 20 Apr 2022 09:30:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3AE4B82025;
        Wed, 20 Apr 2022 16:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5DFC385A1;
        Wed, 20 Apr 2022 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650472228;
        bh=ACQZOVB/l83rJdkIlMLCLxGx7mGxCiS0d0I8YudmpVw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=brZnXSwWtiJ4r2AyJ7L3IiEV0ri9GiNqNiSiZrKEpdtZwrxVxwZ+KbkbmowBew47w
         jUEGCLr+G9LyYrkgZWHkA2nu7jBX2sWy3c/pf6TbmH1qWkRD0QNdLNjWnDJ4aOvuE7
         1jbR2Uud7rDD7q8bnILGIcoO9IYv4/srR4cszLbu8x3FZtd/0RrsFOA4iZq5fd5KZD
         WMY8X2MZpxrvFbLKkuA8IWC/ETp4ZoHefhFYEukbyrdq3dYyLhuqcLDwYXbRBqDeeq
         SDAwvJO+s9noI8qztkm/ZmS+ejJM/sNWNMUyWFi/d8pDq97ItLeaHaPNBMOdjh5Bjz
         ZnZMQ9eovHgOw==
Date:   Wed, 20 Apr 2022 11:30:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Rajvi Jingar <rajvi.jingar@intel.com>, bhelgaas@google.com,
        david.e.box@linux.intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 1/2] PCI/PM: refactor pci_pm_suspend_noirq()
Message-ID: <20220420163026.GA1304353@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb94e592-0fd8-3274-aeeb-49fbd6f74761@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 14, 2022 at 07:53:25PM +0200, Rafael J. Wysocki wrote:
> On 3/25/2022 8:50 PM, Rajvi Jingar wrote:
> > The state of the device is saved during pci_pm_suspend_noirq(), if it
> > has not already been saved, regardless of the skip_bus_pm flag value. So
> > skip_bus_pm check is removed before saving the device state.
> > 
> > Signed-off-by: Rajvi Jingar <rajvi.jingar@intel.com>
> > Suggested-by: David E. Box <david.e.box@linux.intel.com>
> 
> Sorry for the delay here.
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rajvi, can you post these again?  It looks like they didn't make it to
the linux-pci mailing list, and I can't find them in the lore archives:

  https://lore.kernel.org/all/?q=f%3Arajvi.jingar

Maybe some formatting issue that vger didn't like?  Some possible
issues here:

  http://vger.kernel.org/majordomo-info.html

They should appear on the list so others can comment and so the lore
URL can be included in the commit when applying.

Please incorporate Rafael's reviewed-by when you repost.

> > ---
> >   v1 -> v2: add comments to the changes
> >   v2 -> v3: move changelog after "---" marker
> >   v3 -> v4: add "---" marker after changelog
> > ---
> >   drivers/pci/pci-driver.c | 18 ++++++------------
> >   1 file changed, 6 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index 4ceeb75fc899..8b55a90126a2 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -845,20 +845,14 @@ static int pci_pm_suspend_noirq(struct device *dev)
> >   		}
> >   	}
> > -	if (pci_dev->skip_bus_pm) {
> > +	if (!pci_dev->state_saved) {
> > +		pci_save_state(pci_dev);
> >   		/*
> > -		 * Either the device is a bridge with a child in D0 below it, or
> > -		 * the function is running for the second time in a row without
> > -		 * going through full resume, which is possible only during
> > -		 * suspend-to-idle in a spurious wakeup case.  The device should
> > -		 * be in D0 at this point, but if it is a bridge, it may be
> > -		 * necessary to save its state.
> > +		 * If the device is a bridge with a child in D0 below it, it needs to
> > +		 * stay in D0, so check skip_bus_pm to avoid putting it into a
> > +		 * low-power state in that case.
> >   		 */
> > -		if (!pci_dev->state_saved)
> > -			pci_save_state(pci_dev);
> > -	} else if (!pci_dev->state_saved) {
> > -		pci_save_state(pci_dev);
> > -		if (pci_power_manageable(pci_dev))
> > +		if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev))
> >   			pci_prepare_to_sleep(pci_dev);
> >   	}
> 
> 
