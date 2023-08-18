Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D14B78053B
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 06:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357895AbjHRE4e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 00:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348886AbjHRE4P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 00:56:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4603358E;
        Thu, 17 Aug 2023 21:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692334574; x=1723870574;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mR493IMW5AWgA/NvnIZTYMmSMVCq/yaFQLRH0a+q9WA=;
  b=jVzJCLSDclqs52Rn3JRk3NvbN2SPWd4QYB4wlvMGFlhDwzI9CZj4SmFM
   Sg7Sn2vlNq4euJQve7ajysDkWZPxDhzoHnlunjZor/T8Buw0j3x+W7Z2I
   XfquotQX2hGY5IQWfDxeiUecQCSICfuwHFHuqRowmjK8NNAPIMDOjR2cf
   a15tvyRRKMdHc3vECRPf+vfv9T5isGE6uhT/5dM4H81u+a+szfUxOyY/L
   TjjltM5L3TTAol2dievZ3KW02V91o2oaXCGlilQmwsz4rdTUH878ySXsB
   sbJ7sYPFZ1rRLJ8mUeBf04DwHdArmQZ3tSFN9vBBeroMEBFKI+SuJ4DvI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="459367007"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="459367007"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 21:56:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="800329455"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="800329455"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 17 Aug 2023 21:56:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 43E3BDAB; Fri, 18 Aug 2023 07:56:11 +0300 (EEST)
Date:   Fri, 18 Aug 2023 07:56:11 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Sanath S <sanaths2@amd.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: Re: [PATCH] PCI: Allocate maximum available buses to help extending
 the daisy chain
Message-ID: <20230818045611.GE3465@black.fi.intel.com>
References: <20230816051923.2287912-1-Sanath.S@amd.com>
 <ffd5401b-400b-79e2-51f2-e6866251000f@amd.com>
 <20230817102430.GD3465@black.fi.intel.com>
 <0aa6cb16-27af-345d-7e6c-cf985290d1b4@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0aa6cb16-27af-345d-7e6c-cf985290d1b4@amd.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 18, 2023 at 09:01:50AM +0530, Sanath S wrote:
> 
> On 8/17/2023 3:54 PM, Mika Westerberg wrote:
> > On Wed, Aug 16, 2023 at 06:48:35PM +0530, Sanath S wrote:
> > > Adding Mika.
> > Thanks!
> > 
> > > On 8/16/2023 10:49 AM, Sanath S wrote:
> > > > In the case of Thunderbolt, it contains a PCIe switch and one or
> > > > more hotplug-capable PCIe downstream ports where the daisy chain
> > > > can be extended.
> > > > 
> > > > Currently when a Thunderbolt Dock is plugged in during S5/Reboot,
> > > > System BIOS allocates a very minimal number of buses for bridges and
> > > > hot-plug capable PCIe downstream ports to enumerate the dock during
> > > > boot. Because of this, we run out of bus space pretty quickly when
> > > > more PCIe devices are attached to hotplug downstream ports in order
> > > > to extend the chain.
> > > > 
> > > > Before:
> > > >              +-04.0
> > > >              +-04.1-[63-c1]----00.0-[64-69]--+-00.0-[65]--
> > > >              |                               +-01.0-[66]--
> > > >              |                               +-02.0-[67]--
> > > >              |                               +-03.0-[68]--
> > > >              |                               \-04.0-[69]--
> > > >              +-08.0
> > This is something the BIOS should be doing but for some reason it is
> > not on that particular system.
> Yes, BIOS should be doing it. Idea here is if BIOS has not distributed it
> correctly, OS
> can reallocate and distribute it correctly.
> > > > In case of a thunderbolt capable bridge, reconfigure the buses allocated
> > Thunderbolt
> Will correct it.
> > 
> > > > by BIOS to the maximum available buses. So that the hot-plug bridges gets
> > > > maximum buses and chain can be extended to accommodate more PCIe devices.
> > > > This fix is necessary for all the PCIe downstream ports where the daisy
> > > > chain can be extended.
> > This is necessary only when there is no proper BIOS allocation for the
> > resources.
> Yes, will send out a v2 with updated commit message.
> > 
> > > > After:
> > > >              +-04.0
> > > >              +-04.1-[63-c1]----00.0-[64-c1]--+-00.0-[65]--
> > > >              |                               +-01.0-[66-84]--
> > > >              |                               +-02.0-[85-a3]--
> > > >              |                               +-03.0-[a4-c0]--
> > > >              |                               \-04.0-[c1]--
> > > >              +-08.0
> > > > 
> > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=216000
> > Did you get confirmation that this actually solves the issue?
> I've tested this on my setup, it is resolving the issue.

Right, but it would be good to get confirmation from the person who
reported the issue that this actually helps. There is nothing in the
bugzilla whether the patch worked or not.
