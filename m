Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6D6629267
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 08:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiKOHXM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 02:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiKOHXL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 02:23:11 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895E7205D8
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2022 23:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668496990; x=1700032990;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hTdzQb336Ir81L1D/pToAoyFaMKbM1P1rv8E6J3+34s=;
  b=bknOgZLbzszVM5mZJTZT3XxQPcB2pO3SRJjFESxSG6v952CfhdSjy0Ds
   5/xMTjat6XBVFPGF1H8oleFV3W1zDWACQL1OPLlcPLgR4T1ZfkbMTkgzR
   A1NbzkNhKBA+qA85wBZJQ57isXFRfLDTCqSnBcgSpZTFM3lgVUvwJt9lT
   DrQmXfAqRw9GgiAcCfQ2jfCYu6Bs+fsde7LI+Oh3jIYKZkduc3ZdGCKPU
   llIbPGTfDFojDQZtASvObyKgX8aS4sJETE+WomENfeXaA4zX/1tiFb5Vp
   atAk7EIjZH6uM1ni18Ec8g2QFc2uwaq31M5gpZrmXC6O5wNAkV5hQ5VwE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="313993054"
X-IronPort-AV: E=Sophos;i="5.96,165,1665471600"; 
   d="scan'208";a="313993054"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 23:23:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="727846535"
X-IronPort-AV: E=Sophos;i="5.96,165,1665471600"; 
   d="scan'208";a="727846535"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Nov 2022 23:23:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5777A2F3; Tue, 15 Nov 2022 09:23:32 +0200 (EET)
Date:   Tue, 15 Nov 2022 09:23:32 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Albert Zhou <albert.zhou.50@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org, lukas@wunner.de
Subject: Re: [PATCH v2 1/2] pci: hotplug: add dependency info to Kconfig
Message-ID: <Y3M+dMJyvnS0uKZ2@black.fi.intel.com>
References: <20221113112811.22266-1-albert.zhou.50@gmail.com>
 <20221113112811.22266-2-albert.zhou.50@gmail.com>
 <Y3IafGm+ewR5LJL9@black.fi.intel.com>
 <213e1035-b3c7-3d4c-5691-fd936a762745@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <213e1035-b3c7-3d4c-5691-fd936a762745@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Tue, Nov 15, 2022 at 12:38:11PM +1100, Albert Zhou wrote:
> On 14/11/22 21:37, Mika Westerberg wrote:
> > > +	default y if USB4
> > >   	help
> > >   	  Say Y here if you have a motherboard with a PCI Hotplug controller.
> > >   	  This allows you to add and remove PCI cards while the machine is
> > > -	  powered up and running.
> > > +	  powered up and running. Thunderbolt and USB4 PCI cards require
> > > +	  Hotplug.
> > I would not say they "require" this. PCIe is completely optional in USB4
> > systems and it is perfectly fine to have host controllers or
> > add-in-cards that don't have a single PCIe adapter.
> > 
> > Not objeting the patch, though. For Linux I guess it makes sense to have
> > this like what you are suggesting. Just perhaps changing the wordirng
> > 😉
> 
> How about “Thunderbolt and USB4 use Hotplug”

Or

"Thunderbolt/USB4 PCIe tunneling needs Native PCIe Hotplug to be enabled"

> Do you agree with the “default y if USB4” for PCIEPORTBUS, HOTPLUG_PCI_PCIE, HOTPLUG_PCI.

Yes, I think for Linux perspective it makes sense to have them enabled
by default.
