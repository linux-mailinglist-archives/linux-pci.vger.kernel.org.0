Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4C62DAAD2
	for <lists+linux-pci@lfdr.de>; Tue, 15 Dec 2020 11:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgLOKZc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Dec 2020 05:25:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:41458 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbgLOKZ3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Dec 2020 05:25:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F2B66ACA5;
        Tue, 15 Dec 2020 10:24:47 +0000 (UTC)
Date:   Tue, 15 Dec 2020 11:24:42 +0100
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     lorenzo.pieralisi@arm.com, vidyas@nvidia.com, robh@kernel.org
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: dwc: tegra194: issue with card containing a bridge
Message-ID: <20201215102442.GA20517@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,
I am seeing an issue with next-20201211 with USB3380[1] based PCIe card
(vid:pid 10b5:3380) on Jetson AGX Xavier. Card doesn't show up in the
lspci output.

In non working case (next-20201211):
# lspci
0001:00:00.0 PCI bridge: NVIDIA Corporation Device 1ad2 (rev a1)
0001:01:00.0 SATA controller: Marvell Technology Group Ltd. Device 9171 (rev 13)
0005:00:00.0 PCI bridge: NVIDIA Corporation Device 1ad0 (rev a1)

In working case (v5.10-rc7):
# lspci
0001:00:00.0 PCI bridge: Molex Incorporated Device 1ad2 (rev a1)
0001:01:00.0 SATA controller: Marvell Technology Group Ltd. Device 9171 (rev 13)
0005:00:00.0 PCI bridge: Molex Incorporated Device 1ad0 (rev a1)
0005:01:00.0 PCI bridge: PLX Technology, Inc. Device 3380 (rev ab)
0005:02:02.0 PCI bridge: PLX Technology, Inc. Device 3380 (rev ab)
0005:03:00.0 USB controller: PLX Technology, Inc. Device 3380 (rev ab)
# lspci -t
-+-[0005:00]---00.0-[01-ff]----00.0-[02-03]----02.0-[03]----00.0
 +-[0001:00]---00.0-[01-ff]----00.0
 \-[0000:00]-
#lspci -v
https://paste.opensuse.org/87573209

git-bisect points to commit b9ac0f9dc8ea ("PCI: dwc: Move dw_pcie_setup_rc() to DWC common code").
dw_pcie_setup_rc() is not removed from pcie-tegra194.c in this commit.

Could the failure be caused because dw_pcie_setup_rc() is called twice now in case of tegra194?

BR,
Yousaf

[1]: https://www.broadcom.com/products/pcie-switches-bridges/usb-pci/usb-controllers/usb3380
