Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A4B4DDC1D
	for <lists+linux-pci@lfdr.de>; Fri, 18 Mar 2022 15:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237541AbiCROtw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Mar 2022 10:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237735AbiCROtQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Mar 2022 10:49:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61832EA917;
        Fri, 18 Mar 2022 07:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647614870; x=1679150870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NoF7DUUBnepgXUQfSAA2zocvCsU667YxNsq4hF4qw40=;
  b=llzB9zc+Ly0E691IWjQ6Wnfx79r2qWKqgsWA2EVtsNzsANmNqq72cEmy
   /RZDwO8RDrnPHC4wJ7X/jFTEBC6Ar1YQ1UH6UguwsUgMmkIzLdMWggF/t
   VBFaa4bhXefQyEtH6AlcC2Ixnfj3zjs+NqDE9jLhvljmx0YJntq3gPnSR
   fVftSZM2ApQKpiIYKZTc0I9rFZfBajpD51nrLGXit4jJ+jLpGc8zOiY5c
   jJewnXM2QXz3hWBfFVlAEcyxUm5kTC1F+P7TFobq2AddGMfDFUmc74Srq
   83DqgE6h8cSa6GMj1RC/Fubl/LmiMq/r4xGeNq05hwFVqIlQK6eBKf3hb
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="255974221"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="255974221"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 07:47:32 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="647486665"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 07:47:28 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 18 Mar 2022 16:47:25 +0200
Date:   Fri, 18 Mar 2022 16:47:25 +0200
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "michael.jamet@intel.com" <michael.jamet@intel.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] thunderbolt: Make iommu_dma_protection more accurate
Message-ID: <YjSbfScU0Ssuca3y@lahna>
References: <2d01fa50c2650c730b0244929097737918e302e7.1647533152.git.robin.murphy@arm.com>
 <BL1PR12MB515783C0F998169D49D92A55E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
 <BL1PR12MB51573F55B3C2B3922BAAA7F1E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjRvMk1kcbMwJvx+@lahna>
 <65207fdf-c4ab-5165-dbda-8ab55b51adb7@arm.com>
 <YjSCWaq7Ej/2iJPp@lahna>
 <78fc0426-c22a-ec62-f92b-0019bea5947e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78fc0426-c22a-ec62-f92b-0019bea5947e@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 18, 2022 at 02:08:16PM +0000, Robin Murphy wrote:
> On 2022-03-18 13:25, mika.westerberg@linux.intel.com wrote:
> > Hi Robin,
> > 
> > On Fri, Mar 18, 2022 at 12:01:42PM +0000, Robin Murphy wrote:
> > > > This adds quite a lot code and complexity, and honestly I would like to
> > > > keep it as simple as possible (and this is not enough because we need to
> > > > make sure the DMAR bit is there so that none of the possible connected
> > > > devices were able to overwrite our memory already).
> > > 
> > > Shall we forget the standalone sibling check and just make the
> > > pdev->untrusted check directly in tb_acpi_add_link() then?
> > 
> > I think we should leave tb_acpi_add_link() untouched if possible ;-)
> > This is because it is used to add the device links from firmware
> > description that we need for proper power management of the tunneled
> > devices. It has little to do with the identification of the external
> > facing DMA-capable PCIe ports.
> > 
> > Furthermore these links only exists in USB4 software connection manager
> > systems so we do not have those in the existing Thunderbolt 3/4 systems
> > that use firmware based connection manager (pretty much all out there).
> > 
> > > On reflection I guess the DMAR bit makes iommu_dma_protection
> > > functionally dependent on ACPI already, so we don't actually lose
> > > anything (and anyone can come back and revisit firmware-agnostic
> > > methods later if a need appears).
> > 
> > I agree.
> 
> OK, so do we have any realistic options for identifying the correct PCI
> devices, if USB4 PCIe adapters might be anywhere relative to their
> associated NHI? Short of maintaining a list of known IDs, the only thought I
> have left is that if we walk the whole PCI segment looking specifically for
> hotplug-capable Gen1 ports, any system modern enough to have Thunderbolt is
> *probably* not going to have any real PCIe Gen1 hotplug slots, so maybe
> false negatives might be tolerable, but it still feels like a bit of a
> sketchy heuristic.

Indeed.

> I suppose we could just look to see if any device anywhere is marked as
> external-facing, and hope that if firmware's done that much then it's done
> everything right. That's still at least slightly better than what we have
> today, but AFAICS still carries significant risk of a false positive for an
> add-in card that firmware didn't recognise.

The port in this case, that is marked as external facing, is the PCIe
root port that the add-in-card is connected to and that is known for the
firmware in advance. 

> I'm satisfied that we've come round to the right conclusion on the DMAR
> opt-in - I'm in the middle or writing up patches for that now - but even
> Microsoft's spec gives that as a separate requirement from the flagging of
> external ports, with both being necessary for Kernel DMA Protection.

Is the problem that we are here trying to solve the fact that user can
disable the IOMMU protection from the command line? Or the fact that the
firmware might not declare all the ports properly so we may end up in a
situation that some of the ports do not get the full IOMMU protection.

These are Microsoft requirements for the OEMs in order to pass their
firmware test suite so here I would not expect to have issues. Otherwise
they simply cannot ship the thing with Windows installed.

IMHO we should just trust the firmare provided information here
(otherwise we are screwed anyway as there is no way to tell if the
devices connected prior the OS can still do DMA), and use the external
facing port indicator to idenfity the ports that need DMA protection.
