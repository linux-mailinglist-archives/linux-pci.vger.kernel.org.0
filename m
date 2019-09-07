Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42BCDAC7CD
	for <lists+linux-pci@lfdr.de>; Sat,  7 Sep 2019 18:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395028AbfIGQ6h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 Sep 2019 12:58:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392087AbfIGQ6h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 7 Sep 2019 12:58:37 -0400
Received: from localhost (110.8.30.213.rev.vodafone.pt [213.30.8.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B400D218AF;
        Sat,  7 Sep 2019 16:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567875516;
        bh=h7WrpmXDIMQQcAsF3k54/VtFCroyHOkjUXD7n7pEGmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OIwl0fooudQmlSoEnwVVPMGPVpNyMnDy3vw/2xoHc9MtHtO5BnevIt8CNm2eqUb9G
         vrFwpJsFqdY4EgMCtGNrDrrcyRtLsBPZ0IRwwVTsR/TKy90yYQXOZmlV0zWw8t2398
         cibzgWxcVJQK6u4oWPMPGr5QeQWqndbr1dA8wKfE=
Date:   Sat, 7 Sep 2019 11:58:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v5 0/4] PCI/ASPM: add sysfs attributes for controlling
 ASPM
Message-ID: <20190907165833.GQ103977@google.com>
References: <c63f507f-7f52-7164-dbc5-07fc18e433b8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c63f507f-7f52-7164-dbc5-07fc18e433b8@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 31, 2019 at 10:10:00PM +0200, Heiner Kallweit wrote:
> Background of this extension is a problem with the r8169 network driver.
> Several combinations of board chipsets and network chip versions have
> problems if ASPM is enabled, therefore we have to disable ASPM per
> default. However especially on notebooks ASPM can provide significant
> power-saving, therefore we want to give users the option to enable
> ASPM. With the new sysfs attributes users can control which ASPM
> link-states are disabled.
> 
> Note: Series depends on series "PCI: Make pcie_downstream_port()
> available outside of access.c" from Mika Westerberg that is still
> sitting in the PCI inbox. 
> Alternatively I could prepare a version w/o this dependency, but
> then Mika's series would need to be changed.

It would be better for me if your series applied directly to my
"master" branch (v5.3-rc1).

This v5 depends on Mika's series (which I've since applied), and also
on Krzysztof's linux/pci-aspm.h cleanup.  But neither of them is
essential for your series, and I put them on different topic branches
since Mika's isn't ASPM-related while Krzysztof's is.  That makes it
messy to merge them and apply yours on top (it could certainly be
*done*, but I just avoid that sort git complication).

Both of those *are* cleanups that are relevant to your series, but
it's easier if your series applies directly to my "master" branch, and
I can take care of the merge issues when I merge all the branches
together.

> v2:
> - use a dedicated sysfs attribute per link state
> - allow separate control of ASPM and PCI PM L1 sub-states
> 
> v3:
> - patch 3: statically allocate the attribute group
> - patch 3: replace snprintf with printf
> - add patch 4
> 
> v4:
> - patch 3: add call to sysfs_update_group because is_visible callback
>            returns false always at file creation time
> - patch 3: simplify code a little
> 
> v5:
> - rebased to latest pci/next
> 
> Heiner Kallweit (4):
>   PCI/ASPM: add L1 sub-state support to pci_disable_link_state
>   PCI/ASPM: allow to re-enable Clock PM
>   PCI/ASPM: add sysfs attributes for controlling ASPM link states
>   PCI/ASPM: remove Kconfig option PCIEASPM_DEBUG and related code

Nit here, please capitalize the first word of each subject, e.g.,

  PCI/ASPM: Add L1 PM Substate support to pci_disable_link_state()

and "L1 PM Substate" to match the spec usage, and I like "()" after
function names as a hint.  Also applies to other commit logs.

>  Documentation/ABI/testing/sysfs-bus-pci |  13 ++
>  drivers/pci/pci-sysfs.c                 |  10 +-
>  drivers/pci/pci.h                       |  12 +-
>  drivers/pci/pcie/Kconfig                |   7 -
>  drivers/pci/pcie/aspm.c                 | 236 ++++++++++++++++--------
>  include/linux/pci.h                     |  10 +-
>  6 files changed, 195 insertions(+), 93 deletions(-)
> 
> -- 
> 2.23.0
> 
