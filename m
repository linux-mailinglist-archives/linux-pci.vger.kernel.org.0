Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866B361349F
	for <lists+linux-pci@lfdr.de>; Mon, 31 Oct 2022 12:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiJaLjd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Oct 2022 07:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiJaLjb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2022 07:39:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BE9E0C5;
        Mon, 31 Oct 2022 04:39:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8790CB815F0;
        Mon, 31 Oct 2022 11:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C5AC433D6;
        Mon, 31 Oct 2022 11:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667216366;
        bh=HQjPeXhuMJaa8KQ0K5CAMhQSgd66kySqnVI3CnJ4el4=;
        h=Date:From:To:Cc:Subject:From;
        b=m0AePBMIKMtLXG91e5QuTc7jTQQbEIBSwclsWUvc520seRK4+w16BFyc0M/yUT4Ov
         b/K7brNnoGgy/zUu1+dLsJctx6Ao3ykO6+rp8rG8A1j5tdX7UYANxZ21ID6hMnSQME
         X+jJ6qZrddNz1AroVY+eNQrFerJT5SUBT95SiqPhOT3BC75/5Pvwq25FQ8AZpF57b6
         R/XbMMhR4Gh+Z2XeEJs5bV5gFhonLIh+2SiVQaRuU4gwCHBc2PpADcOyT/ziV/YWh0
         o6IoeAzzEwDAuzIl4tS/x3BfNrXNkCjoPlJXV6oaoEx8prtMPveOBnYAIE4OpMFV04
         aDhizHCgpVFOA==
Date:   Mon, 31 Oct 2022 06:39:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>
Cc:     Jon Derrick <jonathan.derrick@linux.dev>,
        Adrian Huang <ahuang12@lenovo.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [bugzilla-daemon@kernel.org: [Bug 216644] New: Host OS hangs when
 enabling VMD in UEFI setup]
Message-ID: <20221031113924.GA1081013@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks, Adrian, for the bisection and detailed debugging!

----- Forwarded message from bugzilla-daemon@kernel.org -----

https://bugzilla.kernel.org/show_bug.cgi?id=216644

           Summary: Host OS hangs when enabling VMD in UEFI setup
    Kernel Version: 6.1-rc2
        Regression: No

Created attachment 303108
  --> https://bugzilla.kernel.org/attachment.cgi?id=303108&action=edit
OS Log (Serial Log)

When enabling VMD in BIOS setup, the host OS cannot boot successfully with the
following error message:

[    8.986310] vmd 0000:64:05.5: PCI host bridge to bus 10000:00
...
[    9.674113] vmd 0000:64:05.5: Bound to PCI domain 10000
...
[   33.592638] DMAR: VT-d detected Invalidation Queue Error: Reason f
[   33.592640] DMAR: VT-d detected Invalidation Time-out Error: SID ffff
[   33.599853] DMAR: VT-d detected Invalidation Completion Error: SID ffff
[   33.607339] DMAR: QI HEAD: UNKNOWN qw0 = 0x0, qw1 = 0x0
[   33.621143] DMAR: QI PRIOR: UNKNOWN qw0 = 0x0, qw1 = 0x0
[   33.627366] DMAR: Invalidation Time-out Error (ITE) cleared


*** Hardware Info ***
Platform: skylake-D purley platform
VMD: 8086:201d
    # lspci -s 0000:64:05.5 -nn
    0000:64:05.5 RAID bus controller [0104]: Intel Corporation Volume
Management 
    Device NVMe RAID Controller [8086:201d] (rev 04)


*** Detail Info ***
`git bisect` points the following offending patch (commit: 6aab5622296b):

commit 6aab5622296b990024ee67dd7efa7d143e7558d0
Author: Nirmal Patel <nirmal.patel@linux.intel.com>
Date:   Tue Nov 16 15:11:36 2021 -0700

    PCI: vmd: Clean up domain before enumeration

    During VT-d pass-through, the VMD driver occasionally fails to
    enumerate underlying NVMe devices when repetitive reboots are
    performed in the guest OS. The issue can be resolved by resetting
    VMD root ports for proper enumeration and triggering secondary bus
    reset which will also propagate reset through downstream bridges.

    Link:
https://lore.kernel.org/r/20211116221136.85134-1-nirmal.patel@linux.intel.com
    Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
    Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
    Reviewed-by: Jon Derrick <jonathan.derrick@linux.dev>


*** Debugging Info ***
1. Reverting 6aab5622296b on top of 6.1-rc2 can fix the issue.

2. Comment out for calling vmd_domain_reset() can also fix the issue. So, it
looks like the function memset_io() causes the issue.

static void vmd_domain_reset(struct vmd_dev *vmd)
{
        ...
        for (bus = 0; bus < max_buses; bus++) {
                for (dev = 0; dev < 32; dev++) {
                                ...

                                memset_io(base + PCI_IO_BASE, 0,
                                          PCI_ROM_ADDRESS1 - PCI_IO_BASE);
                        }
                }
        }
}

3. pci_reset_bus() returns -25 because 'slot' or 'bus->self' is NULL. 

4. We have 4 disks attached to VMD:
# nvme list
Node                  Generic               SN                   Model         
                          Namespace Usage                      Format          
FW Rev
--------------------- --------------------- --------------------
---------------------------------------- --------- --------------------------
---------------- --------
/dev/nvme3n1          /dev/ng3n1            222639A46A39        
Micron_7450_MTFDKBA960TFR                1          11.48  GB / 960.20  GB   
512   B +  0 B   E2MU111
/dev/nvme2n1          /dev/ng2n1            222639A46A30        
Micron_7450_MTFDKBA960TFR                1           4.18  GB / 960.20  GB   
512   B +  0 B   E2MU111
/dev/nvme1n1          /dev/ng1n1            BTLJ849201CE1P0I     SSDPELKX010T8L
                          1           1.00  TB /   1.00  TB    512   B +  0 B  
VCV1LZ37
/dev/nvme0n1          /dev/ng0n1            BTLJ849201BS1P0I     SSDPELKX010T8L
                          1           1.00  TB /   1.00  TB    512   B +  0 B  
VCV1LZ37

Any thoughts? Thanks for the help.

----- End forwarded message -----
