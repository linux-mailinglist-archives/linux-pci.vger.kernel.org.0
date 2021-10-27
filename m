Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE5143C3D6
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 09:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhJ0H1b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 03:27:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238621AbhJ0H1a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Oct 2021 03:27:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67D0060F9B;
        Wed, 27 Oct 2021 07:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635319505;
        bh=taqwB9xndNIP6+ubGThuMvIEjNZA59pVCLQklgOloZA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TOmdoRE/vgrtnhkY0qmVVNGZyI/6uuY5GDQ558z++JjyvNIRMcbzXiAIY/gLu+YOE
         xhxky9vzihMGdq6u50krNTsJFOxbYvzLc5O7Oe95y5HV7INJNDnly+FBRqziA471qZ
         MW6VqOzpbc3Pzl7wx1MhzUq/Plemn9VUWCr7qn/gnyI3qavPhPOWNwPu90/t1rtbZq
         fV/gFvrReuS2QEVvFd0BUdq8XeH7iKsfU2ykAB6/AV6kDTlbV4TPZp1MoLt7xBmncU
         +jdud4OoZjb1TFxX8TIYojLX48FLkYDOsspN66AB67GcgPynNy9vRddeerEhzvHL0G
         u5oVv65XDvOcA==
Date:   Wed, 27 Oct 2021 08:24:59 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Krzysztof =?UTF-8?B?V2ls?= =?UTF-8?B?Y3p5xYRza2k=?= 
        <kw@linux.com>, Binghui Wang <wangbinghui@hisilicon.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v15 00/13] Add support for Hikey 970 PCIe
Message-ID: <20211027082459.61d5b0e5@sal.lan>
In-Reply-To: <20211026171728.GA20609@lpieralisi>
References: <cover.1634812676.git.mchehab+huawei@kernel.org>
        <20211026171728.GA20609@lpieralisi>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Tue, 26 Oct 2021 18:17:28 +0100
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> escreveu:

> On Thu, Oct 21, 2021 at 11:45:07AM +0100, Mauro Carvalho Chehab wrote:
> > Hi Lorenzo,
> > 
> > I split patch 09/10 from v13 into three patches, in order to have one logical
> > change per patch, adding a proper descriptio to each of them. The final
> > code didn change.
> > 
> > The pcie-kirin PCIe driver contains internally a PHY interface for
> > Kirin 960, but it misses support for Kirin 970. A new PHY driver
> > for it was added at drivers/phy/hisilicon/phy-hi3670-pcie.c
> > (already merged via PHY tree).
> > 
> > Add support for Kirin 970 PHY driver at the pcie-kirin.c.
> > 
> > While here, also add the needed logic to compile it as module and
> > to allow to dynamically remove the driver in runtime.
> > 
> > Tested on HiKey970:
> > 
> >   # lspci -D -PP
> >   0000:00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3670 (rev 01)
> >   0000:00:00.0/01:00.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> >   0000:00:00.0/01:00.0/02:01.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> >   0000:00:00.0/01:00.0/02:04.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> >   0000:00:00.0/01:00.0/02:05.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> >   0000:00:00.0/01:00.0/02:07.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> >   0000:00:00.0/01:00.0/02:09.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> >   0000:00:00.0/01:00.0/02:01.0/03:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd Device a809
> >   0000:00:00.0/01:00.0/02:07.0/06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 07)
> > 
> > Tested on HiKey960:
> > 
> >   # lspci -D 
> >   0000:00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3660 (rev 01)
> > 
> > ---
> > 
> > v15:
> >   - The power-off fix patch was split into 3, in order to have one logical change
> >     per patch.
> >   -  Removed Fixes: tag from the poweroff patch;
> >   - Adjusted capitalization of two patch summary lines
> >   - No functional changes. The diff of this series is identical to v14.
> > 
> > v14:
> >   - Split a timeout logic from patch 4, placing it on a separate patch;
> >   - Added fixes: and cc: tags to the power_off fixup patch;
> >   - change a typecast from of_data to long, in order to avoid a warning on
> >     some randconfigs;
> >   - removed uneeded brackets at the power_off patch;
> >   - reordered struct device pointers at kirin_pcie_get_resource();
> >   - added a c/c to kishon at the PHY-related patches.
> > 
> > v13:
> >   - Added Xiaowei's ack for the series.
> > 
> > v12:
> >   - Change a comment at patch 1 to not use c99 style.
> > 
> > v11:
> >   - patch 5 changed to use the right PCIe topology
> >   - all other patches are identical to v10.
> > 
> > v10:
> >   - patch 1: dropped magic numbers from PHY driver
> >   - patch 5: allow pcie child nodes without reset-gpios
> >   - all other patches are identical to v9.
> > 
> > v9:
> >   - Did some cleanups at patches 1 and 5
> > 
> > Mauro Carvalho Chehab (13):
> >   PCI: kirin: Reorganize the PHY logic inside the driver
> >   PCI: kirin: Add support for a PHY layer
> >   PCI: kirin: Use regmap for APB registers
> >   PCI: kirin: Add support for bridge slot DT schema
> >   PCI: kirin: Give more time for PERST# reset to finish
> >   PCI: kirin: Add Kirin 970 compatible
> >   PCI: kirin: Add MODULE_* macros
> >   PCI: kirin: Allow building it as a module
> >   PCI: kirin: Add power_off support for Kirin 960 PHY
> >   PCI: kirin: Move the power-off code to a common routine
> >   PCI: kirin: Disable clkreq during poweroff sequence
> >   PCI: kirin: De-init the dwc driver
> >   PCI: kirin: Allow removing the driver
> > 
> >  drivers/pci/controller/dwc/Kconfig      |   2 +-
> >  drivers/pci/controller/dwc/pcie-kirin.c | 643 ++++++++++++++++++------
> >  2 files changed, 497 insertions(+), 148 deletions(-)  
> 
> Applied to pci/dwc for v5.16, please have a look at the resulting
> branch and commits. 

Thanks!

Everything looks fine to me.

Best regards,
Mauro
