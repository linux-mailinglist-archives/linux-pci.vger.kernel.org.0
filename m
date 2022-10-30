Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38AF612927
	for <lists+linux-pci@lfdr.de>; Sun, 30 Oct 2022 09:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJ3Iip (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 Oct 2022 04:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ3Iio (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Oct 2022 04:38:44 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6DDA0;
        Sun, 30 Oct 2022 01:38:43 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E56E968AFE; Sun, 30 Oct 2022 09:38:38 +0100 (CET)
Date:   Sun, 30 Oct 2022 09:38:38 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>, dave.jiang@intel.com,
        alison.schofield@intel.com, bwidawsk@kernel.org,
        vishal.l.verma@intel.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <20221030083838.GD4949@lst.de>
References: <20221024133633.00000467@huawei.com> <20221025232535.GA579167@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025232535.GA579167@bhelgaas>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 25, 2022 at 06:25:35PM -0500, Bjorn Helgaas wrote:
> Is this cxl code allocating vectors for devices that might also be
> claimed by portdrv?  I assume not because that sounds like a problem.
> 
> Ugh.  I always feel like the portdrv design must be sub-optimal
> because this seems so hard to do cleanly.

Yes, portdrv is a mess.  And I fear we really need to bite the bullet
rather sooner than later to sort much of this out by lifting all the
logic to the core and just keep the "drivers" around for sysfs
pretence.

And I think CXL is trying to run into a similar (but not quiete as bad)
mess with it's overly modular approach.  In either case the right
thing would be to do anough early setup to find the requird number of
interrupts and highest interrupt number and just request that once.
