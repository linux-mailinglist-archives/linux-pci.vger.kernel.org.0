Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF9884936
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2019 12:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfHGKOL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Aug 2019 06:14:11 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49060 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfHGKOL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Aug 2019 06:14:11 -0400
Received: from 79.184.254.29.ipv4.supernova.orange.pl (79.184.254.29) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 015a7a6c70140c25; Wed, 7 Aug 2019 12:14:08 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] nvme-pci: Do not prevent PCI bus-level PM from being used
Date:   Wed, 07 Aug 2019 12:14:08 +0200
Message-ID: <2081634.8PS0KMhuBW@kreacher>
In-Reply-To: <1893355.EP2830DdO9@kreacher>
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM> <20190731221956.GB15795@localhost.localdomain> <1893355.EP2830DdO9@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday, August 7, 2019 11:53:44 AM CEST Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> One of the modifications made by commit d916b1be94b6 ("nvme-pci: use
> host managed power state for suspend") was adding a pci_save_state()
> call to nvme_suspend() in order to prevent the PCI bus-level PM from
> being applied to the suspended NVMe devices, but if ASPM is not
> enabled for the target NVMe device, that causes its PCIe link to stay
> up and the platform may not be able to get into its optimum low-power
> state because of that.
> 
> For example, if ASPM is disabled for the NVMe drive (PC401 NVMe SK
> hynix 256GB) in my Dell XPS13 9380, leaving it in D0 during
> suspend-to-idle prevents the SoC from reaching package idle states
> deeper than PC3, which is way insufficient for system suspend.
> 
> To address this shortcoming, make nvme_suspend() check if ASPM is
> enabled for the target device and fall back to full device shutdown
> and PCI bus-level PM if that is not the case.
> 
> Fixes: d916b1be94b6 ("nvme-pci: use host managed power state for suspend")
> Link: https://lore.kernel.org/linux-pm/2763495.NmdaWeg79L@kreacher/T/#t
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

I should have used a better subject for this patch.

I'll resend it with a changed subject later, but for now I would like to collect
opinions about it (if any).

Cheers!



