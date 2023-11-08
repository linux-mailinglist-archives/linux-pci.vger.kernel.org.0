Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AC37E5EC4
	for <lists+linux-pci@lfdr.de>; Wed,  8 Nov 2023 20:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjKHThy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Nov 2023 14:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKHThy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2023 14:37:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EF5172E
        for <linux-pci@vger.kernel.org>; Wed,  8 Nov 2023 11:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699472272; x=1731008272;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cG5legNp6CJ7cj63WJFV1bXZ0hmKmLM4hqF8srlF5ys=;
  b=IEKL/1xa2+VZbMve9U0mrwrR/9pMMV6vo60lo3w2kw8EFQeZELh3NdNs
   ZjK0hC1SXQnux9CGzHOZ6cKGIZktvbbyPJcyQVQ8XLAku17jzaCrEvHJc
   i+mN1GheyMSeglUTlB/Fwezyeno1Z/JrocBsHGkPYTtKNZw5dn21se9z4
   phdeHIpkQ8WBpL0bOz94+zheS4hoEIPNYX7TfjNFfrk+wLKb1+hjdadU9
   7CxEEHn3iEsL+2FMl5R/B5L49QOXZMBUjTYlwOjKEtAVg/YzWuHvgWLRX
   94VS4jZ4wPkYKyMkBVtKPYyNHTjVYxJ2cHWo9B/N9PB374mBDJFw1fQ8f
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="454145916"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="454145916"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 11:37:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="766741107"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="766741107"
Received: from patelni-ubuntu-dev.ch.intel.com ([10.2.132.59])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 11:37:50 -0800
Message-ID: <f508d00a6a88251331abcf79ec0265ba2462207b.camel@linux.intel.com>
Subject: Re: [PATCH] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
From:   Nirmal Patel <nirmal.patel@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, orden.e.smith@intel.com,
        samruddh.dhope@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Date:   Wed, 08 Nov 2023 12:44:30 -0700
In-Reply-To: <CAAd53p5CqviDy-Y3FxO2sP2-q+LjHzDOe6x6upuw+V5Jh3k0uQ@mail.gmail.com>
References: <a623e811037972c7cdf1fe05fcb7ace2b445a323.camel@linux.intel.com>
         <20231107223037.GA303668@bhelgaas>
         <CAAd53p5CqviDy-Y3FxO2sP2-q+LjHzDOe6x6upuw+V5Jh3k0uQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2023-11-08 at 16:49 +0200, Kai-Heng Feng wrote:
> On Wed, Nov 8, 2023 at 12:30 AM Bjorn Helgaas <helgaas@kernel.org>
> wrote:
> > [+cc Rafael, just FYI re 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC
> > on PCIe features")]
> > 
> > On Tue, Nov 07, 2023 at 02:50:57PM -0700, Nirmal Patel wrote:
> > > On Thu, 2023-11-02 at 16:49 -0700, Nirmal Patel wrote:
> > > > On Thu, 2023-11-02 at 15:41 -0500, Bjorn Helgaas wrote:
> > > > > On Thu, Nov 02, 2023 at 01:07:03PM -0700, Nirmal Patel wrote:
> > > > > > On Wed, 2023-11-01 at 17:20 -0500, Bjorn Helgaas wrote:
> > > > > > > On Tue, Oct 31, 2023 at 12:59:34PM -0700, Nirmal Patel
> > > > > > > wrote:
> > > > > > > > On Tue, 2023-10-31 at 10:31 -0500, Bjorn Helgaas wrote:
> > > > > > > > > On Mon, Oct 30, 2023 at 04:16:54PM -0400, Nirmal
> > > > > > > > > Patel
> > > > > > > > > wrote:
> > > > > > > > > > VMD Hotplug should be enabled or disabled based on
> > > > > > > > > > VMD
> > > > > > > > > > rootports' Hotplug configuration in BIOS.
> > > > > > > > > > is_hotplug_bridge
> > > > > > > > > > is set on each VMD rootport based on Hotplug
> > > > > > > > > > capable bit
> > > > > > > > > > in
> > > > > > > > > > SltCap in probe.c.  Check is_hotplug_bridge and
> > > > > > > > > > enable or
> > > > > > > > > > disable native_pcie_hotplug based on that value.
> > > > > > > > > > 
> > > > > > > > > > Currently VMD driver copies ACPI settings or
> > > > > > > > > > platform
> > > > > > > > > > configurations for Hotplug, AER, DPC, PM, etc and
> > > > > > > > > > enables
> > > > > > > > > > or
> > > > > > > > > > disables these features on VMD bridge which is not
> > > > > > > > > > correct
> > > > > > > > > > in case of Hotplug.
> > > > > > > > > 
> > > > > > > > > This needs some background about why it's correct to
> > > > > > > > > copy
> > > > > > > > > the
> > > > > > > > > ACPI settings in the case of AER, DPC, PM, etc, but
> > > > > > > > > incorrect
> > > > > > > > > for hotplug.
> > > > > > > > > 
> > > > > > > > > > Also during the Guest boot up, ACPI settings along
> > > > > > > > > > with
> > > > > > > > > > VMD
> > > > > > > > > > UEFI driver are not present in Guest BIOS which
> > > > > > > > > > results
> > > > > > > > > > in
> > > > > > > > > > assigning default values to Hotplug, AER, DPC, etc.
> > > > > > > > > > As a
> > > > > > > > > > result Hotplug is disabled on VMD in the Guest OS.
> > > > > > > > > > 
> > > > > > > > > > This patch will make sure that Hotplug is enabled
> > > > > > > > > > properly
> > > > > > > > > > in Host as well as in VM.
> > > > > > > > > 
> > > > > > > > > Did we come to some consensus about how or whether
> > > > > > > > > _OSC for
> > > > > > > > > the host bridge above the VMD device should apply to
> > > > > > > > > devices
> > > > > > > > > in the separate domain below the VMD?
> > > > > > > > 
> > > > > > > > We are not able to come to any consensus. Someone
> > > > > > > > suggested
> > > > > > > > to
> > > > > > > > copy either all _OSC flags or none. But logic behind
> > > > > > > > that
> > > > > > > > assumption is that the VMD is a bridge device which is
> > > > > > > > not
> > > > > > > > completely true. VMD is an endpoint device and it owns
> > > > > > > > its
> > > > > > > > domain.
> > > > > > > 
> > > > > > > Do you want to facilitate a discussion in the PCI
> > > > > > > firmware SIG
> > > > > > > about this?  It seems like we may want a little text in
> > > > > > > the
> > > > > > > spec
> > > > > > > about how to handle this situation so platforms and OSes
> > > > > > > have
> > > > > > > the
> > > > > > > same expectations.
> > > > > > 
> > > > > > The patch 04b12ef163d1 broke intel VMD's hotplug
> > > > > > capabilities and
> > > > > > author did not test in VM environment impact.
> > > > > > We can resolve the issue easily by
> > > > > > 
> > > > > > #1 Revert the patch which means restoring VMD's original
> > > > > > functionality
> > > > > > and author provide better fix.
> > > > > > 
> > > > > > or
> > > > > > 
> > > > > > #2 Allow the current change to re-enable VMD hotplug inside
> > > > > > VMD
> > > > > > driver.
> > > > > > 
> > > > > > There is a significant impact for our customers hotplug use
> > > > > > cases
> > > > > > which
> > > > > > forces us to apply the fix in out-of-box drivers for
> > > > > > different
> > > > > > OSs.
> > > > > 
> > > > > I agree 100% that there's a serious problem here and we need
> > > > > to fix
> > > > > it, there's no argument there.
> > > > > 
> > > > > I guess you're saying it's obvious that an _OSC above VMD
> > > > > does not
> > > > > apply to devices below VMD, and therefore, no PCI Firmware
> > > > > SIG
> > > > > discussion or spec clarification is needed?
> > > > 
> > > > Yes. By design VMD is an endpoint device to OS and its domain
> > > > is
> > > > privately owned by VMD only. I believe we should revert back to
> > > > original design and not impose _OSC settings on VMD domain
> > > > which is
> > > > also a maintainable solution.
> > > 
> > > I will send out revert patch. The _OSC settings shouldn't apply
> > > to private VMD domain.
> > 
> > I assume you mean to revert 04b12ef163d1 ("PCI: vmd: Honor ACPI
> > _OSC
> > on PCIe features").  That appeared in v5.17, and it fixed (or at
> > least
> > prevented) an AER message flood.  We can't simply revert
> > 04b12ef163d1
> > unless we first prevent that AER message flood in another way.
> 
> The error is "correctable".
> Does masking all correctable AER error by default make any sense? And
> add a sysfs knob to make it optional.
> 
> Kai-Heng
Where does the sysfs knob go? Masking AER errors on VMD domain via VMD
driver?

Another way is to disable AER from VMD driver on VMD domain using sysfs
knob.

nirmal
> 
> > Bjorn
> > 
> > > Even the patch 04b12ef163d1 needs more changes to make sure _OSC
> > > settings are passed on from Host BIOS to Guest BIOS which means
> > > involvement of ESXi, Windows HyperV, KVM.

