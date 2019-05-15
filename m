Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD471FA6B
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2019 21:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfEOT0Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 May 2019 15:26:25 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40007 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfEOT0Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 May 2019 15:26:25 -0400
Received: by mail-io1-f68.google.com with SMTP id s20so526427ioj.7
        for <linux-pci@vger.kernel.org>; Wed, 15 May 2019 12:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=GqGY8+LfaCH2Vr4cHFwojZthP1NA2Vgfu6kJrTHfE+A=;
        b=Ko73wbyLTOjwRmcq8dh8mTCjKeeel/IvkxBE1E81PIJ2MT8Ndvs0+36hePPyf+ecH6
         6BmTFMOwS0U7h4el7K4+AtklUU1w2dTHILbRvBPYXgOf8cxDEc1XDrQx3vCVSKfN4CFU
         Ou08/1yP4eaK+Z9A9LbN0/aqgL+/Up8ET1YFnkRXzvQRNd3/2eiPyjBMjYKQX1xl2MKz
         6Mr7Zhhmy/e+M91MX7Dc4ClUoAIwZE4IwjxnAT+OOr8gvVW6n7J3k4kW+4N8HNVq2V9m
         gpYvSF24oTju3lH7Jwbre4WFSzC6gGJb+j/8eZLtrsyfZLf44hTGwFo4wfcJHlLWQEhm
         R2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=GqGY8+LfaCH2Vr4cHFwojZthP1NA2Vgfu6kJrTHfE+A=;
        b=rSwX0SjcGMySO8bh6emmivuDwyX7GmL2ncf0G2LZsSN/cPMP7c4rSx+r4RMaAZ4yeB
         e6HwD2V7zecy4Mo6h5GDPdSQw7qUCMgqo8H/FxawMd9hsLgxdHZG9b9QhgwYNTvfFSqj
         9zyx4ulOcTyBCnQaDqtsYsFuJfX56f5jXDgSxXWQMfYRIibMiqidMVuQ+E90Vhgykl3h
         UNQ3oBVK2g0tLlECDBXDTNFtSQ4pEXanjUiyj2VtNuHJuLVZVVAagEKNZD+DB2BJvz1u
         QINQ0HpSFgBBULbCVWiw52yjK8DXUcrDwNgsK8o9ddYclxz4p9GI+sY/tFH2HJqL7xT5
         WFBw==
X-Gm-Message-State: APjAAAVTDHfph/AvsceVOawz3Zf8IHMuPMm4mgC7Bdjf9XSNcPnbt62l
        QcAZBlk3Z/9PgCSlvIQS7EjtE/+eRt8Uuwyp1eBHt+Yf
X-Google-Smtp-Source: APXvYqwwCpWdw7PgEjpLD522vmCciFRZnaO1uU6t4k3dMygx3uewtw4644Yk9LH7hSKu9YQ9DF6F3KAXuKjsveP/qII=
X-Received: by 2002:a6b:5814:: with SMTP id m20mr24590643iob.293.1557948384200;
 Wed, 15 May 2019 12:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <bug-203485-193951@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203485-193951@https.bugzilla.kernel.org/>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Wed, 15 May 2019 14:26:13 -0500
Message-ID: <CABhMZUWcS0x+E42T3dqzio72wea32pr2GuULXc=+62T+rLAgmQ@mail.gmail.com>
Subject: Fwd: [Bug 203485] New: PCI can't map correct memory resource if the
 BAR is 64-bit and then leads to system hang during booting up
To:     linux-pci@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        AceLan Kao <acelan@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I should have forwarded this to the list earlier.  Maybe somebody
wants to work on this?

I *think* the problem is:

  - BIOS sets MTRR for 0x40_00000000-0x5f_ffffffff to be write-combining (WC)
  - That covers part of this PCI aperture: root bus resource [mem
0x40_00000000-0x7f_ffffffff window]
  - That aperture includes a frame buffer: pci 0000:00:02.0: reg 0x18:
[mem 0x40_00000000-0x40_0fffffff 64bit pref]
  - Linux assigned an LPSS BAR to the WC area: pci 0000:00:15.0: BAR
0: assigned [mem 0x40_10000000-0x40_10000fff 64bit]
  - The LPSS device doesn't work if MMIO accesses to it are combined via WC

I'm not an x86/MTRR/PAT expert, but I think we should be able to make
this work correctly by changing that MTRR from WC to UC (I don't know
if there are BIOS/OS interface implications with this), or maybe using
PAT to override the MTRR WC setting to be UC for part or all of that
aperture.  The frame buffer driver should be smart enough to request
WC if it wants it.


---------- Forwarded message ---------
From: <bugzilla-daemon@bugzilla.kernel.org>
Date: Fri, May 3, 2019 at 3:31 AM
Subject: [Bug 203485] New: PCI can't map correct memory resource if
the BAR is 64-bit and then leads to system hang during booting up
To: <bugzilla.pci@gmail.com>


https://bugzilla.kernel.org/show_bug.cgi?id=203485

            Bug ID: 203485
           Summary: PCI can't map correct memory resource if the BAR is
                    64-bit and then leads to system hang during booting up
           Product: Drivers
           Version: 2.5
    Kernel Version: v5.1-rc7
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: acelan@gmail.com
        Regression: No

Created attachment 282597
  --> https://bugzilla.kernel.org/attachment.cgi?id=282597&action=edit
dmesg.log

This issue has been found on loading intel-lpss-pci driver, the pdev->resource
passing to its probe function is not correct. And it leads to system hangs
while loading the driver.

This is the memory addresses driver got, the start and end are more like the
region declared in BAR

[    0.718591] pci 0000:00:15.0: BAR 0: assigned [mem 0x4010000000-0x4010000fff
64bit]
[    0.718613] pci 0000:00:15.1: BAR 0: assigned [mem 0x4010001000-0x4010001fff
64bit]
[    0.718626] pci 0000:00:1d.0: BAR 13: assigned [io  0x4000-0x6fff]
[    0.718634] pci 0000:00:1e.0: BAR 0: assigned [mem 0x4010002000-0x4010002fff
64bit]

[  154.417550] [/home/acelan/linux/drivers/mfd/intel-lpss-pci.c:31]
intel_lpss_pci_probe(): 0000:00:15.0 - mem = 0x0000000047753398, mem->start =
0x0000000010000000, mem->end = 0x0000000010000FFF
[  154.417571] [/home/acelan/linux/drivers/mfd/intel-lpss-pci.c:31]
intel_lpss_pci_probe(): 0000:00:15.1 - mem = 0x0000000047754398, mem->start =
0x0000000010001000, mem->end = 0x0000000010001FFF
[  154.417587] [/home/acelan/linux/drivers/mfd/intel-lpss-pci.c:31]
intel_lpss_pci_probe(): 0000:00:1e.0 - mem = 0x000000004775A398, mem->start =
0x0000000010002000, mem->end = 0x0000000010002FFF

Below is the correct one I copy from 32-Bit BAR
[    3.511100] [/home/acelan/bionic/drivers/mfd/intel-lpss-pci.c:47]
intel_lpss_pci_probe(): 0000:00:15.0 - mem = 0x00000000AB282380, mem->start =
0x00000000ED137000, mem->end = 0x00000000ED137FFF

--
You are receiving this mail because:
You are watching the assignee of the bug.
