Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEF169FE12
	for <lists+linux-pci@lfdr.de>; Wed, 22 Feb 2023 23:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjBVWCY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Feb 2023 17:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjBVWCY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Feb 2023 17:02:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587FE41B6D;
        Wed, 22 Feb 2023 14:02:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C74B66157F;
        Wed, 22 Feb 2023 22:02:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE7AC433D2;
        Wed, 22 Feb 2023 22:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677103342;
        bh=XzoL6AJPYva3eF1pIbrO3aURgSEiWFHCISYaoJoffgw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FdR+QsQtWgojtn2yfU11p2o6Twy2ZZcKen49YhEwA1uFdMnMFs3xfQ4Jg2N7DhNdV
         dW40QlH+EoVfkG9WKToPzubjrjgApQBJc0oHY4YDSNhoMpdfRRmogu0HQ3SNgzM6Xj
         ouVMhAbdw8Bw6u3rZeVSlQ7BAqWLxln5M9IVX2e3dfDzWyS+PMPMyFHcGthKk6E8pO
         fydfdFGpvHe9mNpaPqDllq7i7iQU71eyILVXwlYS81ez1JOlFxifidIf1D7ClY5AE9
         tcJJj0+pj19lYvQesShox/J9vLviYv3COxqA2jpknn1Fd+nHxRU+U+xVfTgPMIcCs0
         Q1VtIegIGxNIg==
Date:   Wed, 22 Feb 2023 16:02:20 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH RESEND] PCI: s390: Fix use-after-free of PCI bus
 resources with s390 per-function hotplug
Message-ID: <20230222220220.GA3804275@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a621a2b836d81d12b6f265f47d93b827e0a82df.camel@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 20, 2023 at 01:53:34PM +0100, Niklas Schnelle wrote:
> On Fri, 2023-02-17 at 17:15 -0600, Bjorn Helgaas wrote:
> > On Tue, Feb 14, 2023 at 10:49:10AM +0100, Niklas Schnelle wrote:
> > > ...

> >     What happens when zpci_bus_release() calls
> >     pci_free_resource_list() on &zbus->resources?  It looks like that
> >     ultimately calls kfree(), which is OK for the
> >     zpci_setup_bus_resources() stuff, but what about the
> >     zbus->bus_resource that was not kalloc'ed?
> 
> As far as I can see pci_free_resource_list() only calls kfree() on the
> entry not on entry->res. The resources set up in
> zpci_setup_bus_resources() are freed in zpci_cleanup_bus_resources()
> explicitly.

So I guess the zbus->resources are allocated in zpci_bus_scan_device()
where zpci_setup_bus_resources() adds a zbus resource for every
zpci_dev BAR, and freed in zpci_bus_release() when the last zpci_dev
is unregistered.

Does that mean that if you add device A, add device B, and remove A,
the zbus retains A's resources even though A is gone?  What if you
then add device C whose resources partially overlap A's?

> > >  static void zpci_cleanup_bus_resources(struct zpci_dev *zdev)
> > >  {
> > > +	struct resource *res;
> > >  	int i;
> > >  
> > > +	pci_lock_rescan_remove();
> > 
> > What exactly is this protecting?  This doesn't seem like quite the
> > right place since we're not adding/removing a pci_dev here.  Is this
> > to protect the bus->resources list in pci_bus_remove_resource()?
> 
> Yes I did not find a lock that is specifically for bus->resources but
> it seemed to me that changes to resources would only affect things
> running under the rescan/remove lock.

Yeah, OK.

> > >  	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> > > -		if (!zdev->bars[i].size || !zdev->bars[i].res)
> > > +		res = zdev->bars[i].res;
> > > +		if (!res)
> > >  			continue;
> > >  
> > > +		release_resource(res);
> > > +		pci_bus_remove_resource(zdev->zbus->bus, res);
> > >  		zpci_free_iomap(zdev, zdev->bars[i].map_idx);
> > > -		release_resource(zdev->bars[i].res);
> > > -		kfree(zdev->bars[i].res);
> > > +		zdev->bars[i].res = NULL;
> > > +		kfree(res);
> > >  	}
> > >  	zdev->has_resources = 0;
> > > +	pci_unlock_rescan_remove();
