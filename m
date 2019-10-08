Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6C5CD0340
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2019 00:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbfJHWKn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Oct 2019 18:10:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfJHWKn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Oct 2019 18:10:43 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2D3221721;
        Tue,  8 Oct 2019 22:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570572643;
        bh=u1k6M3I2hVu2fQw9TNNRx9GqsPpllewHVqrhfLMAezY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NPJMN8i+daEEMqwPs0cNq73KoMaf0M+oWD5uxFJ90EgKaBQ5I0Nyn+Emrh5FEy4n9
         hr1H0eF1dqE5VAIcxTQLmG29fdF5njqlBuprE422ILsO5gOEbx3nwYXv1RDoda+CTX
         EXpqz4CG5fqQa/+BQbTUrfmzxs6g2Qac0GMhLG6c=
Date:   Tue, 8 Oct 2019 17:10:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v7 0/5] PCI/ASPM: Add sysfs attributes for controlling
 ASPM
Message-ID: <20191008221040.GA236555@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1c28e25-df18-16e1-3e9f-933f613ea858@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 05, 2019 at 02:02:29PM +0200, Heiner Kallweit wrote:
> Background of this extension is a problem with the r8169 network driver.
> Several combinations of board chipsets and network chip versions have
> problems if ASPM is enabled, therefore we have to disable ASPM per
> default. However especially on notebooks ASPM can provide significant
> power-saving, therefore we want to give users the option to enable
> ASPM. With the new sysfs attributes users can control which ASPM
> link-states are disabled.
> 
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
> v6:
> - patch 3: consider several review comments from Bjorn
> - patch 4: add discussion link to commit message
> 
> v7:
> - Move adding pcie_aspm_get_link() to separate patch 3
> - patch 4: change group name from aspm to link_pm
> - patch 4: control visibility of attributes individually
> 
> Heiner Kallweit (5):
>   PCI/ASPM: add L1 sub-state support to pci_disable_link_state
>   PCI/ASPM: allow to re-enable Clock PM
>   PCI/ASPM: Add and use helper pcie_aspm_get_link
>   PCI/ASPM: Add sysfs attributes for controlling ASPM link states
>   PCI/ASPM: Remove Kconfig option PCIEASPM_DEBUG and related code
> 
>  Documentation/ABI/testing/sysfs-bus-pci |  14 ++
>  drivers/pci/pci-sysfs.c                 |   6 +-
>  drivers/pci/pci.h                       |  12 +-
>  drivers/pci/pcie/Kconfig                |   7 -
>  drivers/pci/pcie/aspm.c                 | 252 ++++++++++++++++--------
>  include/linux/pci.h                     |  10 +-
>  6 files changed, 199 insertions(+), 102 deletions(-)

I applied these to pci/aspm for v5.5.  Thank you very much for all the
work you put into this!

There are a couple questions that are still open, but I have no
problem if we want to make minor tweaks before the merge window opens.

Bjorn
