Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112484DCEED
	for <lists+linux-pci@lfdr.de>; Thu, 17 Mar 2022 20:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiCQTi4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Mar 2022 15:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiCQTiz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Mar 2022 15:38:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8768F22E953;
        Thu, 17 Mar 2022 12:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647545856; x=1679081856;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qo2D3TN6PoZ9wS60fZKZkGUnHxtz5zLGgEpjwbsjoIA=;
  b=Aat7q+Ua303aWmUlGVX6EFqUr5/znu6J4bwCxsHW2rmyq7ISZFd0v2S3
   T2MGpeP/qX91UaSBs1sE07VHNm2acml6ua93ymG9+rJUk9qSFJfSm8zi2
   VbxpWZEDPotTc9EoYt7SrudtY0KU3fg1BqZyyR1HoPp6YJrabO/tOSpFB
   vlxl6438S4TeFPzGxacDDyeg7qElyI8VgcavgyjOwLauRDL1KRHiWMk0f
   Efx8LfSZ8t+ya8CyMhCZFcNVtOeN95A02aQXKTTZUDJCaS86lGXYQak4X
   /fjI++rnajx/0svcvaoE/Jnalrqpq2ov4figRBY1OxNFIoJcyKhtiEjIk
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="236909725"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="236909725"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 12:37:36 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="635486137"
Received: from mgsalahu-mobl.amr.corp.intel.com (HELO localhost) ([10.212.119.201])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 12:37:36 -0700
Date:   Thu, 17 Mar 2022 12:37:35 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V6 03/10] PCI/DOE: Add Data Object Exchange Aux Driver
Message-ID: <YjON/33+V1iNXnrk@iweiny-desk3>
References: <20220201071952.900068-1-ira.weiny@intel.com>
 <20220201071952.900068-4-ira.weiny@intel.com>
 <CAPcyv4hYAgyf-WcArGvbWHAJgc5+p=OO_6ah_dXJhNM5cXcVTw@mail.gmail.com>
 <YjJpzzKAtV4vgM+H@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjJpzzKAtV4vgM+H@iweiny-desk3>
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 16, 2022 at 03:50:55PM -0700, Ira Weiny wrote:
> On Tue, Feb 08, 2022 at 04:59:39PM -0800, Dan Williams wrote:
> > On Mon, Jan 31, 2022 at 11:20 PM <ira.weiny@intel.com> wrote:

[snip]

> > 
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void pci_doe_remove(struct auxiliary_device *aux_dev)
> > > +{
> > > +       struct pci_doe *doe = dev_get_drvdata(&aux_dev->dev);
> > > +
> > > +       /* First halt the state machine */
> > > +       cancel_delayed_work_sync(&doe->statemachine);
> > > +}
> > > +
> > > +static const struct auxiliary_device_id pci_doe_auxiliary_id_table[] = {
> > > +       {},
> > > +};
> > > +
> > > +MODULE_DEVICE_TABLE(auxiliary, pci_doe_auxiliary_id_table);
> > 
> > Why is this empty table here?
> 
> Filling the id table was done in the next patch.
> 
> The split of the patches may have been a bit arbitrary here.  This patch was
> focused on the state machine and probing of the mailboxes.  The next patch
> provided the helper function to create all the DOE devices for a given
> PCI device; pci_doe_create_doe_devices()
> 
> > 
> > > +
> > > +struct auxiliary_driver pci_doe_auxiliary_drv = {
> > > +       .name = "pci_doe",
> > > +       .id_table = pci_doe_auxiliary_id_table,
> > > +       .probe = pci_doe_probe,
> > > +       .remove = pci_doe_remove
> > > +};
> > 
> > I expect that these helpers would be provided by the PCI core, but
> > then a subsystem like CXL would have code to register their auxiliary
> > devices and drivers that mostly just wrap the PCI core DOE
> > implementation.
> 
> Ah ok, I think I see what you are saying.  That is not quite as straight
> forward a use of the auxiliary bus but I _think_ it will work.  I'll also
> attempt to clarify with documentation how the above probe/remove functions are
> to be used by those defining their own drivers.

Ok looking at this again today I see why I did things the way I did.

The question is:

Is the DOE driver a PCI driver or a driver defined by the subsystems?

The way I have it now the PCI core defines the driver and a couple of very
small helper functions for the subsystems to use.

What I think you are proposing is the PCI core supplies the helper functions to
drive the protocol but the actual driver is defined as part of the subsystem?
Is that correct?

The implications are subtle but one thing about the way I have things is that
subsystems don't really need to learn about auxiliary bus driver stuff.

OTOH pushing the auxiliary bus code into the subsystem allows for a bit more
flexibility around the use of the DOE protocol code within the PCI core.

I'll keep looking.

Ira
