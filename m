Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367E87DF223
	for <lists+linux-pci@lfdr.de>; Thu,  2 Nov 2023 13:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346866AbjKBMRd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Nov 2023 08:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346863AbjKBMR3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2023 08:17:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E35B112;
        Thu,  2 Nov 2023 05:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698927442; x=1730463442;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WKRnkNW/XER8dXSWKZi5aAoaOJTp9xTuNC9BpNIc3/4=;
  b=Upu8vQa8eesss8OOUad5/gQfiZ4N+0O7ZfGtUJ+mdrM2dq6rPJ8UThPF
   uIuybF27d1mjoVmY1OZYvhg9xVp6u2AFHCyMIL4qLgofQJGAEyf8zX3dd
   8+JrIL2sbTu3jgABC4wz9QrtpWr1vHP78Dwo9AY4ATX0aaDju12mhdisW
   z4zMyn5FnKW30JFsxLl7RRGbPIOh7T1dZPMxLLM72xIiFBH9qVfDdmJ7c
   gyEnCJSrBUoz9FsqYqS7OzKCGDN51C8oqewrKuuY5wvjlwd0wkkCZYjq1
   EbrN1XJYDu2KvEpa9YzCoi9DrWy809RtlmFMaMX2MYySXD1S5ronzvzAX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="453000884"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="453000884"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 05:17:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="1092689422"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="1092689422"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 02 Nov 2023 05:17:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 8ACDD54A; Thu,  2 Nov 2023 14:17:17 +0200 (EET)
Date:   Thu, 2 Nov 2023 14:17:17 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>, bhelgaas@google.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Alexander.Deucher@amd.com
Subject: Re: [PATCH 2/2] PCI: Ignore PCIe ports used for tunneling in
 pcie_bandwidth_available()
Message-ID: <20231102121717.GL17433@black.fi.intel.com>
References: <20231102103108.GK17433@black.fi.intel.com>
 <20231102120739.GA114661@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231102120739.GA114661@bhelgaas>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 02, 2023 at 07:07:39AM -0500, Bjorn Helgaas wrote:
> On Thu, Nov 02, 2023 at 12:31:08PM +0200, Mika Westerberg wrote:
> > On Wed, Nov 01, 2023 at 08:14:31PM -0500, Mario Limonciello wrote:
> > > On 11/1/2023 17:52, Bjorn Helgaas wrote:
> 
> > > > Lukas' brief intro in
> > > > https://lore.kernel.org/all/20230925141930.GA21033@wunner.de/ really
> > > > helped me connect a few dots, because things like
> > > > Documentation/admin-guide/thunderbolt.rst assume we already know those
> > > > details.
> > > 
> > > Thanks for sharing that.  If I move the detection mechanism as I suggested
> > > above I'll reference some of that as well in the commit message to explain
> > > what exactly a tunneled port is.
> > 
> > I'm not sure it makes sense to explain from the zero all this stuff that
> > people can easily look up from the corresponding spec, such as PCIe or
> > USB.
> 
> I don't know if it needs to be in the commit log.
> 
> I mentioned thunderbolt.rst because the text at
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/thunderbolt.rst?id=v6.6#n6
> assumes that we know the terms "host router", "host controller",
> "router", "tunnel", "connection manager", and I don't think that's a
> good assumption in that documentation.
> 
> A little bit of introduction based on Lukas' text could improve that.

All these are explained in the USB4 spec, I wonder if we should just
link that in the document rather than expaining all of them there.
Anyway, point taken, thanks for the feedback!
