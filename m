Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086E342223E
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 11:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbhJEJ0q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 05:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232773AbhJEJ0p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 05:26:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9FF1D6154B;
        Tue,  5 Oct 2021 09:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633425895;
        bh=IEdllWxDaEmWx3XyCkSILsBxQd/sSHr6TrZzjfQkKzg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pIXQ5hiu3AwH8jtQRSWFMo3uXgoRqoh3CQm7L/4LRPlO4UA1+bde5S1JNdZnpFMv6
         928AVBioWQDkV95uWuX8yWEkjnAdTACm8zuv+tzajp//n7WTh1qRjAGGnoK4V1MkNP
         vzjOMxZrhgvt/sULIVj/WAr7nx5PihNWAQZj4s/BhBTHdVTVmskDdMUG2kNTwZ11ia
         RZGzxthsaYK11QCuow14kFr6+BCwXkGD5DBy6nFAxYZASw5Ln3Nbe9BEPKOWiY2RP6
         iKwBp7qiB9Sm1Ga7bFf1jJxkqOihHcSOwC/+eoABY/aeYMQ3CMUyk0e8Hs4JGPeN+6
         +0oeKMOSn2lpw==
Date:   Tue, 5 Oct 2021 11:24:48 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Krzysztof =?UTF-8?B?V2ls?= =?UTF-8?B?Y3p5xYRza2k=?= 
        <kw@linux.com>, Binghui Wang <wangbinghui@hisilicon.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v12 00/11] Add support for Hikey 970 PCIe
Message-ID: <20211005112448.2c40dc10@coco.lan>
In-Reply-To: <cover.1632814194.git.mchehab+huawei@kernel.org>
References: <cover.1632814194.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Em Tue, 28 Sep 2021 09:34:10 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> The pcie-kirin PCIe driver contains internally a PHY interface for
> Kirin 960, but it misses support for Kirin 970.
> 
> Patch1 contains a PHY for Kirin 970 PCIe.
> 
> The remaining patches add support for Kirin 970 at the pcie-kirin driver, and
> add the needed logic to compile it as module and to allow to dynamically
> remove the driver in runtime.
> 
> Tested on HiKey970:
> 
>   # lspci -D -PP
>   0000:00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3670 (rev 01)
>   0000:00:00.0/01:00.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
>   0000:00:00.0/01:00.0/02:01.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
>   0000:00:00.0/01:00.0/02:04.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
>   0000:00:00.0/01:00.0/02:05.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
>   0000:00:00.0/01:00.0/02:07.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
>   0000:00:00.0/01:00.0/02:09.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
>   0000:00:00.0/01:00.0/02:01.0/03:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd Device a809
>   0000:00:00.0/01:00.0/02:07.0/06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 07)
> 
> Tested on HiKey960:
> 
>   # lspci -D 
>   0000:00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3660 (rev 01)
> 
> ---
> 
> v12:
>   - Change a comment at patch 1 to not use c99 style.
> 
> v11:
>   - patch 5 changed to use the right PCIe topology
>   - all other patches are identical to v10.
> 
> v10:
>   - patch 1: dropped magic numbers from PHY driver
>   - patch 5: allow pcie child nodes without reset-gpios
>   - all other patches are identical to v9.
> 
> v9:
>   - Did some cleanups at patches 1 and 5
> 

As the DT changes needed by HiKey 970 PCIe support are already upstream:

	commit cfcf126fc6795e843d090d98754391ece55e8b0c
	Author:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
	AuthorDate: Wed Aug 4 09:18:56 2021 +0200
	Commit:     Rob Herring <robh@kernel.org>
	CommitDate: Mon Aug 16 16:00:52 2021 -0500

	    dt-bindings: PCI: kirin: Add support for Kirin970
	    
	    Add a new compatible, plus the new bindings needed by
	    HiKey970 board.
    
	    Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
	    Link: https://lore.kernel.org/r/875a4571e253040d3885ee1f37467b0bade7361b.1628061310.git.mchehab+huawei@kernel.org
	    Signed-off-by: Rob Herring <robh@kernel.org>

> 
> Mauro Carvalho Chehab (11):
>   phy: HiSilicon: Add driver for Kirin 970 PCIe PHY

And the PHY patch was already accepted and merged at today's
linux-next:

	commit 73075011ffff876de8516a1e583dc41869293da9
	Author:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
	AuthorDate: Tue Sep 28 09:34:11 2021 +0200
	Commit:     Vinod Koul <vkoul@kernel.org>
	CommitDate: Fri Oct 1 13:42:18 2021 +0530

	    phy: HiSilicon: Add driver for Kirin 970 PCIe PHY
    
	    The Kirin 970 PHY is somewhat similar to the Kirin 960, but it
	    does a lot more. Add the needed bits for PCIe to start working on
	    HiKey 970 boards.
    
	    Co-developed-by: Manivannan Sadhasivam <mani@kernel.org>
	    Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
	    Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
	    Link: https://lore.kernel.org/r/b7a4ff41b57d861b003f1a00cae81f3d226fbe18.1632814194.git.mchehab+huawei@kernel.org
	    Signed-off-by: Vinod Koul <vkoul@kernel.org>

>   PCI: kirin: Reorganize the PHY logic inside the driver
>   PCI: kirin: Add support for a PHY layer
>   PCI: kirin: Use regmap for APB registers
>   PCI: kirin: Add support for bridge slot DT schema
>   PCI: kirin: Add Kirin 970 compatible
>   PCI: kirin: Add MODULE_* macros
>   PCI: kirin: Allow building it as a module
>   PCI: kirin: Add power_off support for Kirin 960 PHY
>   PCI: kirin: fix poweroff sequence
>   PCI: kirin: Allow removing the driver

I guess everything is already satisfying the review feedbacks.
If so, could you please merge the PCI ones?

> 
>  drivers/pci/controller/dwc/Kconfig      |   2 +-
>  drivers/pci/controller/dwc/pcie-kirin.c | 644 +++++++++++++-----
>  drivers/phy/hisilicon/Kconfig           |  10 +
>  drivers/phy/hisilicon/Makefile          |   1 +
>  drivers/phy/hisilicon/phy-hi3670-pcie.c | 845 ++++++++++++++++++++++++
>  5 files changed, 1354 insertions(+), 148 deletions(-)
>  create mode 100644 drivers/phy/hisilicon/phy-hi3670-pcie.c

Thanks,
Mauro
