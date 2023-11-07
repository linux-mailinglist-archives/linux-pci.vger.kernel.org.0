Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477087E4B13
	for <lists+linux-pci@lfdr.de>; Tue,  7 Nov 2023 22:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbjKGVoU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Nov 2023 16:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbjKGVoU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Nov 2023 16:44:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695BA10D0
        for <linux-pci@vger.kernel.org>; Tue,  7 Nov 2023 13:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699393458; x=1730929458;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=driUsHxkXc3IbLyynUEDS0NNQweu1zDWkMnmkCPrBuc=;
  b=kFwp7mkZkQYJBBX9UBJp8453wc/PksGbFLKU+cJtNm9huj/WrVRDclGe
   1XFDUhkq7zrgdThyAK8TlS8LqSIAzrrybzVis5O0awDT1I3o5WT+dlCcN
   Ey3Cq5XDbxbVbN5mfN5/cUQAj3qu1nCKh0XEPbAaAnwOJuWJ6gRgiDrwL
   EOGKLn+BjERCi+s1BTx5moX8RJcL8IWQrTnCHkoMxP1S8A9uciUHKi1Fw
   btohjag7qe/kwQCxHamVrILnCmu/5/RJ+XC/0bhylnSfeJFrqKIel0CdX
   WxSZKRTqQn54dP9bt+1TWR/obz1xkQaU5Bfr4V54joYqAZd6pZqEHqsCk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="369832614"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="369832614"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 13:44:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="756334087"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="756334087"
Received: from patelni-ubuntu-dev.ch.intel.com ([10.2.132.59])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 13:44:17 -0800
Message-ID: <a623e811037972c7cdf1fe05fcb7ace2b445a323.camel@linux.intel.com>
Subject: Re: [PATCH] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
From:   Nirmal Patel <nirmal.patel@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        orden.e.smith@intel.com, samruddh.dhope@intel.com
Date:   Tue, 07 Nov 2023 14:50:57 -0700
In-Reply-To: <f1904829dc2584a6c5f1c230d83e1ba2a7f208bb.camel@linux.intel.com>
References: <20231102204101.GA132084@bhelgaas>
         <f1904829dc2584a6c5f1c230d83e1ba2a7f208bb.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2023-11-02 at 16:49 -0700, Nirmal Patel wrote:
> On Thu, 2023-11-02 at 15:41 -0500, Bjorn Helgaas wrote:
> > [+cc Kai-Heng]
> > 
> > On Thu, Nov 02, 2023 at 01:07:03PM -0700, Nirmal Patel wrote:
> > > On Wed, 2023-11-01 at 17:20 -0500, Bjorn Helgaas wrote:
> > > > On Tue, Oct 31, 2023 at 12:59:34PM -0700, Nirmal Patel wrote:
> > > > > On Tue, 2023-10-31 at 10:31 -0500, Bjorn Helgaas wrote:
> > > > > > On Mon, Oct 30, 2023 at 04:16:54PM -0400, Nirmal Patel
> > > > > > wrote:
> > > > > > > VMD Hotplug should be enabled or disabled based on VMD
> > > > > > > rootports' Hotplug configuration in BIOS.
> > > > > > > is_hotplug_bridge
> > > > > > > is set on each VMD rootport based on Hotplug capable bit
> > > > > > > in
> > > > > > > SltCap in probe.c.  Check is_hotplug_bridge and enable or
> > > > > > > disable native_pcie_hotplug based on that value.
> > > > > > > 
> > > > > > > Currently VMD driver copies ACPI settings or platform
> > > > > > > configurations for Hotplug, AER, DPC, PM, etc and enables
> > > > > > > or
> > > > > > > disables these features on VMD bridge which is not
> > > > > > > correct
> > > > > > > in case of Hotplug.
> > > > > > 
> > > > > > This needs some background about why it's correct to copy
> > > > > > the
> > > > > > ACPI settings in the case of AER, DPC, PM, etc, but
> > > > > > incorrect
> > > > > > for hotplug.
> > > > > > 
> > > > > > > Also during the Guest boot up, ACPI settings along with
> > > > > > > VMD
> > > > > > > UEFI driver are not present in Guest BIOS which results
> > > > > > > in
> > > > > > > assigning default values to Hotplug, AER, DPC, etc. As a
> > > > > > > result Hotplug is disabled on VMD in the Guest OS.
> > > > > > > 
> > > > > > > This patch will make sure that Hotplug is enabled
> > > > > > > properly
> > > > > > > in Host as well as in VM.
> > > > > > 
> > > > > > Did we come to some consensus about how or whether _OSC for
> > > > > > the host bridge above the VMD device should apply to
> > > > > > devices
> > > > > > in the separate domain below the VMD?
> > > > > 
> > > > > We are not able to come to any consensus. Someone suggested
> > > > > to
> > > > > copy either all _OSC flags or none. But logic behind that
> > > > > assumption is that the VMD is a bridge device which is not
> > > > > completely true. VMD is an endpoint device and it owns its
> > > > > domain.
> > > > 
> > > > Do you want to facilitate a discussion in the PCI firmware SIG
> > > > about this?  It seems like we may want a little text in the
> > > > spec
> > > > about how to handle this situation so platforms and OSes have
> > > > the
> > > > same expectations.
> > > 
> > > The patch 04b12ef163d1 broke intel VMD's hotplug capabilities and
> > > author did not test in VM environment impact.
> > > We can resolve the issue easily by 
> > > 
> > > #1 Revert the patch which means restoring VMD's original
> > > functionality
> > > and author provide better fix.
> > > 
> > > or
> > > 
> > > #2 Allow the current change to re-enable VMD hotplug inside VMD
> > > driver.
> > > 
> > > There is a significant impact for our customers hotplug use cases
> > > which
> > > forces us to apply the fix in out-of-box drivers for different
> > > OSs.
> > 
> > I agree 100% that there's a serious problem here and we need to fix
> > it, there's no argument there.
> > 
> > I guess you're saying it's obvious that an _OSC above VMD does not
> > apply to devices below VMD, and therefore, no PCI Firmware SIG
> > discussion or spec clarification is needed?
> Yes. By design VMD is an endpoint device to OS and its domain is
> privately owned by VMD only. I believe we should revert back to
> original design and not impose _OSC settings on VMD domain which is
> also a maintainable solution.
I will send out revert patch. The _OSC settings shouldn't apply
toprivate VMD domain. 

Even the patch 04b12ef163d1 needs more changes to make sure _OSC
settings are passed on from Host BIOS to Guest BIOS which means
involvement of ESXi, Windows HyperV, KVM.
> > I'm more interested in a long-term maintainable solution than a
> > quick
> > fix.  A maintainable solution requires an explanation for (a) why
> > _OSC
> > above VMD doesn't apply below VMD, and (b) consistency across
> > everything negotiated by _OSC, not just hotplug.
> The only reason I suggested to alter Hotplug because VMD has it's own
> independent Hotplug platform setting different from _OSC which is not
> the case for AER, DPC. So we can honor VMD's Hotplug BIOS settings as
> well as _OSC settings for other flags while maintaining
> functionalities
> across Host and Guest OSs.
> > Bjorn

