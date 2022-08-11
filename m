Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DA859066B
	for <lists+linux-pci@lfdr.de>; Thu, 11 Aug 2022 20:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbiHKSah (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Aug 2022 14:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbiHKSaf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Aug 2022 14:30:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850E412A86;
        Thu, 11 Aug 2022 11:30:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 142EDB82234;
        Thu, 11 Aug 2022 18:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD89C433C1;
        Thu, 11 Aug 2022 18:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660242631;
        bh=94DJD7V+C6bGwnu8DJVbQ30/aUEg0V152zGsUkHFbsw=;
        h=Date:From:To:Cc:Subject:From;
        b=ZOmsVL3FCFBzTG/V+NjOnFdC3rrjv6KrAknj6LUSBoRAm3sX4lkijverWhWYYm/Sc
         6IPDLHGhLrYHYi3CzxUyZ1yFIzigrRF5wLiJjqHZSMyW0l8Rpy/dLbk4fF2YM8g7gS
         uWvUfFz9OjmES9Xn3yUlZf2ZDxazfm/xIGjmO04t9ziKFy4rzkU/bKM4kyvnA+rRXk
         tasTqDRXsamTJbMtQ08L1Bjq5Jh7uCH64D93Rm8FnlZG3l2vwkiGdP056LnyL9zog1
         twwEKeqJI3P36AAyX44vb8jpJQYRv6AR4V1Z7pdSxXaF0d7xhtTtt5xy6jrsqGgEkb
         Uz8gi06EDsRLw==
Date:   Thu, 11 Aug 2022 13:30:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Myron Stowe <mstowe@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Issues with ACPI _CRS and E820 memory map
Message-ID: <20220811183030.GA1529513@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a heads-up about what I think is a firmware defect in the way
some platforms build _CRS methods.  We've had a Linux workaround for
several years, but the workaround breaks some new machines, so the
workaround will be disabled for 2023 and newer machines.

Machines that depend on the workaround include:

  - Dell Precision T3500
  - Lenovo ThinkPad X1 Gen 2
  - Asus C523NA (Coral) Chromebook
  - Likely any machine using coreboot firmware

The current versions of the machines above work fine, but 2023
versions with similar firmware are likely to break unless the firmware
changes.  Please forward this to any firmware folks who may be able to
help with this issue.  

Bjorn


SUMMARY

  A Linux change will break future platforms that rely on the E820 memory
  map to exclude portions of the PCI host bridge windows reported by ACPI
  _CRS methods.

  Linux discovers PCI host bridge MMIO windows by evaluating the _CRS
  method of the ACPI PNP0A03 device that describes the host bridge.  It
  uses these windows to assign address space to PCI BARs.

  In some cases these _CRS methods are incomplete or incorrect, and it's
  hard for an OS to work around this.

  Below are examples of typical problems with _CRS methods.

PLATFORMS REPORT NON-WINDOW SPACE VIA _CRS

  Sometimes _CRS includes host bridge register space or space assigned to
  hidden PCI devices that are not enumerable by the OS.  When an OS assigns
  this space to PCI devices, it may cause conflicts or devices may not
  work.  This appears to be a firmware defect.

  Many platforms report this non-window space as "reserved" in the E820
  memory map, and since 2010, Linux has worked around the _CRS defect by
  excluding these E820 "reserved" regions from the host bridge MMIO
  windows [4].

  Example 1:

    _CRS includes space that's not usable for PCI devices [1]:

      E820:         [mem 0xdceff000-0xdfa0ffff] reserved
      PNP0A08 _CRS: [mem 0xdfa00000-0xfebfffff]

    Note that [mem 0xdfa00000-0xdfa0ffff] is included in both the E820
    entry and _CRS.

    If Linux assigns [mem 0xdfa00000-0xdfbfffff] to a PCI device, the
    system doesn't resume correctly from suspend.  If Linux avoids the
    [mem 0xdfa00000-0xdfa0ffff] area and instead assigns
    [mem 0xdfb00000-0xdfcfffff], resume works correctly.

  Example 2:

    _CRS includes space assigned to a "hidden" PCI device [2, 5]:

      PCI: 00:0d.0 10 base d0000000 limit d0ffffff mem (fixed)  # BIOS log

      E820:         [mem 0xd0000000-0xd0ffffff]
      PNP0A08 _CRS: [mem 0x80000000-0xe0000000]

    The 00:0d.0 device is assigned the [mem 0xd0000000-0xd0ffffff] space,
    but the device is hidden so the OS cannot enumerate it, so the OS
    doesn't know what space the device consumes.

PLATFORMS SUPPLY E820 ENTRIES COVERING ENTIRE _CRS WINDOWS

  Some recent platforms supply E820 "reserved" regions that cover entire
  PCI host bridge windows.  If Linux excludes these E820 regions from the
  windows, it cannot assign space to PCI BARs, which means hot-added
  devices don't work.

  Example 3:

    E820 has a "reserved" region that completely covers the 32-bit MMIO
    window from _CRS [3]:

      E820:         [mem 0x4bc50000-0xcfffffff] reserved
      PNP0A08 _CRS: [mem 0x65400000-0xbfffffff]

    Historically, Linux has avoided putting PCI devices in E820 reserved
    regions to avoid the problems in examples 1 and 2.  Avoiding those
    regions in this case means Linux can't assign space for hot-added
    devices, so they don't work.

LINUX PLANS

  As far as I know, the ACPI spec does not require an OS to exclude space
  from _CRS resources based on the E820 memory map, and these conflicting
  requirements make it impractical for Linux to do so.

  The "avoid E820 regions" workaround worked for several years, but it no
  longer works because of platforms that advertise E820 regions that cover
  *entire* _CRS windows.

  We plan to make Linux stop excluding E820 regions from _CRS resources for
  platforms with a BIOS date of 2023 or newer, so new platforms or new BIOS
  releases that rely on excluding E820 regions may break [6].

  Linux is likely to be broken on future versions of these platforms unless
  the firmware updates _CRS methods.

  If these platforms do not update _CRS methods to be complete and
  accurate, Linux may not boot.  The user's options are to:

    - Manually boot with a kernel command line option like "pci=use_e820".

    - Wait for an updated kernel with a platform-specific workaround.

WHY DOESN'T THIS AFFECT MICROSOFT WINDOWS?

  Short answer: I suspect it *does*, but it's less likely to be a problem
  on Windows.

  As far as I know, Windows does not exclude MMIO space from _CRS based on
  the E820 memory map.  But Windows allocates PCI BARs from the top down,
  while Linux allocates from the bottom up.  Most of the issues happen with
  space at the bottom of the _CRS MMIO windows, so Linux is more likely to
  trip over them than Windows is.

REFERENCES

  [1] https://bugzilla.redhat.com/show_bug.cgi?id=2029207
  [2] https://lore.kernel.org/linux-pci/4e9fca2f-0af1-3684-6c97-4c35befd5019@redhat.com/#t
  [3] https://bugzilla.kernel.org/show_bug.cgi?id=206459
  [4] https://bugzilla.kernel.org/show_bug.cgi?id=16228
  [5] https://review.coreboot.org/plugins/gitiles/coreboot/+/dbcf7b16219d%5E%21/
  [6] https://git.kernel.org/linus/0ae084d5a674
