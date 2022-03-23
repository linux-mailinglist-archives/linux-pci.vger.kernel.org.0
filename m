Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2C34E4CA4
	for <lists+linux-pci@lfdr.de>; Wed, 23 Mar 2022 07:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241822AbiCWGTA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Mar 2022 02:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbiCWGS7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Mar 2022 02:18:59 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9286C710E4;
        Tue, 22 Mar 2022 23:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648016248; x=1679552248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8vzD92UhHfMzrQ/OOVyGmFmDcRcFc7OySsWTT7LpWT4=;
  b=NPKSS7DoayzTvRCnMWnIdrtpnWUgWstqMFR+IwGnt4P0wNlkkgAEJUI1
   mJGE3rXxuYk/W8RoHw63BD9scav+gkWNrHN/gos0pUyfp/07R33QsijS8
   3IU8nS0vKFfp8dWYPTzA4AJDHzVs8MxVRLXW19GJ5RKqAADpcU3RJ2CnH
   frlyEl/VdMrYHOVEiN6MKWYzSoP6EMyDqQZEznBGJNu7Gl/2k3dNuAIJy
   /Wn3223S9+gKfdTMEWG4nDcJ/kiPQvUp7nFjw0jnk4mC4wjhwCQHI6Yd9
   xzzjouvBD3s3iF1ZT82/5dUcebdlUFXQKq1PLHw4KNnjFXe72lv/YSDuu
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="318741628"
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="318741628"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 23:17:28 -0700
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="692833797"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 23:17:22 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 23 Mar 2022 08:16:15 +0200
Date:   Wed, 23 Mar 2022 08:16:15 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        Oliver O'Halloran <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH v4 1/2] PCI: Rename "pci_dev->untrusted" to
 "pci_dev->poses_dma_risk"
Message-ID: <Yjq7LzdQDIhtxSJM@lahna>
References: <20220320062907.3272903-1-rajatja@google.com>
 <YjmQq1DvWnJwUh6R@infradead.org>
 <CAJZ5v0h9TnUELahzkO59Vqoio1QRHfixk58Yxgffa72rmEBgOA@mail.gmail.com>
 <CACK8Z6Fz-TPW1fMpQB09fw11neq8eyn89XB8vy0ioB5zB0Hb9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6Fz-TPW1fMpQB09fw11neq8eyn89XB8vy0ioB5zB0Hb9Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 22, 2022 at 01:09:55PM -0700, Rajat Jain wrote:
> On Tue, Mar 22, 2022 at 4:12 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Mar 22, 2022 at 10:02 AM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Sat, Mar 19, 2022 at 11:29:05PM -0700, Rajat Jain wrote:
> > > > Rename the field to make it more clear, that the device can execute DMA
> > > > attacks on the system, and thus the system may need protection from
> > > > such attacks from this device.
> > > >
> > > > No functional change intended.
> > > >
> > > > Signed-off-by: Rajat Jain <rajatja@google.com>
> > > > ---
> > > > v4: Initial version, created based on comments on other patch
> > >
> > > What a horrible name.  Why not untrusted_dma which captures the
> > > intent much better?
> >
> > FWIW, I like this one much better too.
> 
> Sure, no problems. I can change the name to "untrusted_dma".
> 
> Mika, can I carry forward your "Reviewed-by" tag with this name change too?

Sure :)
