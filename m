Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2458C7DFD53
	for <lists+linux-pci@lfdr.de>; Fri,  3 Nov 2023 00:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjKBXmc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Nov 2023 19:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjKBXmb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2023 19:42:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97CB199
        for <linux-pci@vger.kernel.org>; Thu,  2 Nov 2023 16:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698968545; x=1730504545;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rSV+D87DNwki9X3kcxzoZsWLdTKAIfwkFdZFJqhupTE=;
  b=GQYp+LZZAywwvDJwyyX3xjQ2zPSzkvRSuHGObzFKvbAAsn/A4BwhDzwT
   x1vrUxlO/ChxVlVpSxeRH6K5Z6W0TVzKEM0JaMKFM7cql5qUqSuUa5Iji
   IvN7bXIVp24G9TlO5RO3+ENytM0X+SJHqcIRUIEt4jtCAMdbWzP0HFufs
   9Qi+Mkvx/2C+ax4PZNaSOnPPP4Gd4jsKaWSYn4OTSH7EVY7rkIDfCKgae
   5osRBb6yhcnWPvWWaJi+6csD4wITuhXgAhBXEPstli5PEyVtbN2kfvIIE
   jFIKdjT0o7hTn0WliraRSatbQbIHoVF2iQigS15ePt8zxZ/Org0XnS1RQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="388669416"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="388669416"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 16:42:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="1092891364"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="1092891364"
Received: from patelni-ubuntu-dev.ch.intel.com ([10.2.132.59])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 16:42:25 -0700
Message-ID: <f1904829dc2584a6c5f1c230d83e1ba2a7f208bb.camel@linux.intel.com>
Subject: Re: [PATCH] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
From:   Nirmal Patel <nirmal.patel@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 02 Nov 2023 16:49:06 -0700
In-Reply-To: <20231102204101.GA132084@bhelgaas>
References: <20231102204101.GA132084@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2023-11-02 at 15:41 -0500, Bjorn Helgaas wrote:
> [+cc Kai-Heng]
> 
> On Thu, Nov 02, 2023 at 01:07:03PM -0700, Nirmal Patel wrote:
> > On Wed, 2023-11-01 at 17:20 -0500, Bjorn Helgaas wrote:
> > > On Tue, Oct 31, 2023 at 12:59:34PM -0700, Nirmal Patel wrote:
> > > > On Tue, 2023-10-31 at 10:31 -0500, Bjorn Helgaas wrote:
> > > > > On Mon, Oct 30, 2023 at 04:16:54PM -0400, Nirmal Patel wrote:
> > > > > > VMD Hotplug should be enabled or disabled based on VMD
> > > > > > rootports' Hotplug configuration in BIOS. is_hotplug_bridge
> > > > > > is set on each VMD rootport based on Hotplug capable bit in
> > > > > > SltCap in probe.c.  Check is_hotplug_bridge and enable or
> > > > > > disable native_pcie_hotplug based on that value.
> > > > > > 
> > > > > > Currently VMD driver copies ACPI settings or platform
> > > > > > configurations for Hotplug, AER, DPC, PM, etc and enables
> > > > > > or
> > > > > > disables these features on VMD bridge which is not correct
> > > > > > in case of Hotplug.
> > > > > 
> > > > > This needs some background about why it's correct to copy the
> > > > > ACPI settings in the case of AER, DPC, PM, etc, but incorrect
> > > > > for hotplug.
> > > > > 
> > > > > > Also during the Guest boot up, ACPI settings along with VMD
> > > > > > UEFI driver are not present in Guest BIOS which results in
> > > > > > assigning default values to Hotplug, AER, DPC, etc. As a
> > > > > > result Hotplug is disabled on VMD in the Guest OS.
> > > > > > 
> > > > > > This patch will make sure that Hotplug is enabled properly
> > > > > > in Host as well as in VM.
> > > > > 
> > > > > Did we come to some consensus about how or whether _OSC for
> > > > > the host bridge above the VMD device should apply to devices
> > > > > in the separate domain below the VMD?
> > > > 
> > > > We are not able to come to any consensus. Someone suggested to
> > > > copy either all _OSC flags or none. But logic behind that
> > > > assumption is that the VMD is a bridge device which is not
> > > > completely true. VMD is an endpoint device and it owns its
> > > > domain.
> > > 
> > > Do you want to facilitate a discussion in the PCI firmware SIG
> > > about this?  It seems like we may want a little text in the spec
> > > about how to handle this situation so platforms and OSes have the
> > > same expectations.
> > 
> > The patch 04b12ef163d1 broke intel VMD's hotplug capabilities and
> > author did not test in VM environment impact.
> > We can resolve the issue easily by 
> > 
> > #1 Revert the patch which means restoring VMD's original
> > functionality
> > and author provide better fix.
> > 
> > or
> > 
> > #2 Allow the current change to re-enable VMD hotplug inside VMD
> > driver.
> > 
> > There is a significant impact for our customers hotplug use cases
> > which
> > forces us to apply the fix in out-of-box drivers for different OSs.
> 
> I agree 100% that there's a serious problem here and we need to fix
> it, there's no argument there.
> 
> I guess you're saying it's obvious that an _OSC above VMD does not
> apply to devices below VMD, and therefore, no PCI Firmware SIG
> discussion or spec clarification is needed?
Yes. By design VMD is an endpoint device to OS and its domain is
privately owned by VMD only. I believe we should revert back to
original design and not impose _OSC settings on VMD domain which is
also a maintainable solution.
> 
> I'm more interested in a long-term maintainable solution than a quick
> fix.  A maintainable solution requires an explanation for (a) why
> _OSC
> above VMD doesn't apply below VMD, and (b) consistency across
> everything negotiated by _OSC, not just hotplug.
The only reason I suggested to alter Hotplug because VMD has it's own
independent Hotplug platform setting different from _OSC which is not
the case for AER, DPC. So we can honor VMD's Hotplug BIOS settings as
well as _OSC settings for other flags while maintaining functionalities
across Host and Guest OSs.
> 
> Bjorn

