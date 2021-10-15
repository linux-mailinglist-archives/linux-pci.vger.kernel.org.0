Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9C242FC28
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 21:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242525AbhJOTb2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 15:31:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238200AbhJOTbZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Oct 2021 15:31:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C62861164;
        Fri, 15 Oct 2021 19:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634326158;
        bh=aKjNKv+3YDkNEH3+pLsBvgivP6AFCERFIaeCJiTh1Ao=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=F4gaW0aqGHHKp+lcHfr96dY1NkH3JUnnVQ5ECuBpYkOVyhwDLh/cmj1A98Q3sD1RF
         fKR7PPNbsVuBvuj470QwFGfQ5cLPbq42qSqqrUvICE8q7WL0yi0P1t6v7E7QFNHij8
         lsOKMQY8LYTo/1NBdWIAbsZxZ+fo7Qua3pS+/frq84Xde2zzPMZqlJgv1DQ4XVVLoE
         h8joSyeeK6KLD5/mbp1d8dNO3EVJI4HUJh8AI6/OuSWifZ4eXrxBh9WDk9Ltm5IbWq
         O8FHBbYs7yjRpZ2ggVr08vwcB58S7CO9YB2NorlB1PGrQOhhc0zuNza7tLBnaNdzqa
         4kCQQc0DUXjFg==
Date:   Fri, 15 Oct 2021 14:29:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sinan Kaya <okaya@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-pci@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
        Oliver OHalloran <oohall@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Oza Pawandeep <poza@codeaurora.org>
Subject: Re: [PATCH 0/4] pciehp error recovery fix + cleanups
Message-ID: <20211015192916.GA2150101@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1627638184.git.lukas@wunner.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 31, 2021 at 02:39:00PM +0200, Lukas Wunner wrote:
> One fix for a pciehp error recovery issue spotted by Stuart
> plus three cleanups.  Please review and test.  Thanks!
> 
> Lukas Wunner (4):
>   PCI: pciehp: Ignore Link Down/Up caused by error-induced Hot Reset
>   PCI/portdrv: Remove unused resume err_handler
>   PCI/portdrv: Remove unused pcie_port_bus_{,un}register() declarations
>   PCI/ERR: Reduce compile time for CONFIG_PCIEAER=n
> 
>  drivers/pci/Kconfig               |  3 +++
>  drivers/pci/hotplug/pciehp.h      |  2 ++
>  drivers/pci/hotplug/pciehp_core.c |  4 ++++
>  drivers/pci/hotplug/pciehp_hpc.c  | 28 ++++++++++++++++++++++++++++
>  drivers/pci/pci-driver.c          |  2 +-
>  drivers/pci/pci.c                 |  2 ++
>  drivers/pci/pcie/Makefile         |  4 ++--
>  drivers/pci/pcie/portdrv.h        |  6 ++----
>  drivers/pci/pcie/portdrv_core.c   | 20 ++++++++++----------
>  drivers/pci/pcie/portdrv_pci.c    | 27 +++------------------------
>  10 files changed, 57 insertions(+), 41 deletions(-)

Applied to pci/hotplug for v5.16, thanks!

I split off the pm_iter() to its own patch at the beginning.
