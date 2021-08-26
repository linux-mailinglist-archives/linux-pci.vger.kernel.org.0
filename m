Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A2A3F8EB9
	for <lists+linux-pci@lfdr.de>; Thu, 26 Aug 2021 21:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhHZTbK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Aug 2021 15:31:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230122AbhHZTbK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Aug 2021 15:31:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D5F360FF2;
        Thu, 26 Aug 2021 19:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630006222;
        bh=GRCxB1LxjUi10++Yv2a12D37JrgOyhntwddej3ypRlI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DJrtrJa/WAEdx1BBktwX9vGXWetggsUA5yCX91h+laAhYln8Y7Yx/XjBVLwlnmRUj
         wu6nh9kZTToHOFrndTMy5YKFAsNairNgqUOJeD53IhbT0Xw5Ub6nuEMT/qDjzex/yR
         hbxnOO5w4NNbShn1p1hazPCeLKBbfYlHf6bkpBX7PLHWIiaMel0FZID2gqOxO2/IHL
         Bhw9nAIiVnFyz5gfkSwPj2cEulPpyTzBQOsjFEL2C1UJpvrt74+3s9OEQ0GAOgbcCr
         YURVKsbel7PC8h7seRfyJ0ARs2wpaKG0g4tPvrCGtWaMDW3CJSIWIU/6jcwa+sJZDG
         bMXtDI8EJpUMA==
Date:   Thu, 26 Aug 2021 14:30:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] PCI: Add a quirk to enable SVA for HiSilicon chip
Message-ID: <20210826193020.GA3703737@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626144876-11352-1-git-send-email-zhangfei.gao@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 13, 2021 at 10:54:33AM +0800, Zhangfei Gao wrote:
> HiSilicon KunPeng920 and KunPeng930 have devices appear as PCI but are
> actually on the AMBA bus. These fake PCI devices have PASID capability
> though not supporting TLP.
> 
> Add a quirk to set pasid_no_tlp and dma-can-stall for these devices.
> 
> v5:
> no change, base on 5.14-rc1
> 
> v4: 
> Applied to Linux 5.13-rc2, and build successfully with only these three patches.
> 
> v3:
> https://lore.kernel.org/linux-pci/1615258837-12189-1-git-send-email-zhangfei.gao@linaro.org/
> Rebase to Linux 5.12-rc1
> Change commit msg adding:
> Property dma-can-stall depends on patchset
> https://lore.kernel.org/linux-iommu/20210302092644.2553014-1-jean-philippe@linaro.org/
> 
> By the way the patchset can directly applied on 5.12-rc1 and build successfully though
> without the dependent patchset.
> 
> v2:
> Add a new pci_dev bit: pasid_no_tlp, suggested by Bjorn 
> "Apparently these devices have a PASID capability.  I think you should
> add a new pci_dev bit that is specific to this idea of "PASID works
> without TLP prefixes" and then change pci_enable_pasid() to look at
> that bit as well as eetlp_prefix_path."
> https://lore.kernel.org/linux-pci/20210112170230.GA1838341@bjorn-Precision-5520/
> 
> Zhangfei Gao (3):
>   PCI: PASID can be enabled without TLP prefix
>   PCI: Add a quirk to set pasid_no_tlp for HiSilicon chips
>   PCI: Set dma-can-stall for HiSilicon chips
> 
>  drivers/pci/ats.c    |  2 +-
>  drivers/pci/quirks.c | 27 +++++++++++++++++++++++++++
>  include/linux/pci.h  |  1 +
>  3 files changed, 29 insertions(+), 1 deletion(-)

Applied with Robin's ack to pci/iommu for v5.15, thanks!
