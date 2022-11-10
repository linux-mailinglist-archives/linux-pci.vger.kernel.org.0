Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59109624CA1
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 22:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiKJVKl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 16:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiKJVKk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 16:10:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CD5A1
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 13:10:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57E5F61E57
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 21:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65930C433D6;
        Thu, 10 Nov 2022 21:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668114637;
        bh=SN686j/YswxVXuGnUWa6bGwBPJA3NM3iGYkGG3uoDhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T/SxwzsqQ/sSaYwFG7cnOxh8knktKe/iwBgeSsxz/180rTsEuodSwBCkTu2FRNJIm
         yiOVBj3l+84iS7ekSoXZOTVaQELBoLHDVUYzBjcWUiy+zGUZiKC/yMReJnonwQu5GA
         YkS6FuOsTM9DDVBFnmcK2tHKbx+p4ptbTEQPCZilnT4fLlXCCYC/d4zm6PXEy//d9t
         giLZ3HzkRnTx7uogg845gz7rS2yCwF0Ug3NDRhzjM1V/pXSmYNZEjjg8jbxItjJuLL
         Ie5xpCaZFgJnXnO5JQ2ZkoM6DPo84tJXK6LrnbVuaiPcJptcLX6Tk066pDIhKVO4Fo
         lgMSSgwN3QpqA==
Received: by pali.im (Postfix)
        id 8FD9A856; Thu, 10 Nov 2022 22:10:34 +0100 (CET)
Date:   Thu, 10 Nov 2022 22:10:34 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 1/7] PCI: Allow for indirecting capability registers
Message-ID: <20221110211034.5y2z6ilgiys2jcw2@pali>
References: <20221110195015.207-1-jonathan.derrick@linux.dev>
 <20221110195015.207-2-jonathan.derrick@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110195015.207-2-jonathan.derrick@linux.dev>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 10 November 2022 12:50:09 Jonathan Derrick wrote:
> Allow another driver to provide alternative operations when doing
> capability register reads and writes. The intention is to have
> pcie_bridge_emul provide alternate handlers for the Slot Capabilities, Slot
> Control, and Slot Status registers. Alternate handlers can return > 0 if
> unhandled, errno on error, or 0 on success. This could potentially be
> used to handle quirks in a different manner.

I think that this change should not be needed. Controller drivers
pci-mvebu.c and pci-aardvark.c already provides those alternative
operations when doing capability read and write, and it is working
without need to touch pci/access.c file. They directly register
pci_bridge_emul_init() device and then callbacks of this emulated bridge
either touches config space HW registers or provide some emulation layer
(for capabilities which are not provided by HW config space).

This approach (which is already in use) has one big advantage: There is
no need to touch common pci/access.c code, it only modifies code for
specific HW - controller driver which needs that bridge emulator. All
other HW platforms are unaffected / untouched. Whole emulator code is
separated from the core pci access code.

This is just my opinion, maybe Bjorn has different idea. I just wanted
to show how it is implemented in existing drivers.

> Signed-off-by: Jonathan Derrick <jonathan.derrick@linux.dev>
> ---
>  drivers/pci/access.c | 29 +++++++++++++++++++++++++++++
>  include/linux/pci.h  | 11 +++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 708c7529647f..dbfea6824bd4 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -424,6 +424,17 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
>  		return ret;
>  	}
>  
> +	if (dev->caps_rw_ops) {
> +		u32 reg;
> +		ret = dev->caps_rw_ops->read(dev, pos, 4, &reg);
> +		if (!ret) {
> +			*val = reg & 0xffff;
> +			return ret;
> +		} else if (ret < 0) {
> +			return ret;
> +		}
> +	}
> +
>  	/*
>  	 * For Functions that do not implement the Slot Capabilities,
>  	 * Slot Status, and Slot Control registers, these spaces must
> @@ -459,6 +470,12 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
>  		return ret;
>  	}
>  
> +	if (dev->caps_rw_ops) {
> +		ret = dev->caps_rw_ops->read(dev, pos, 4, val);
> +		if (ret <= 0)
> +			return ret;
> +	}
> +
>  	if (pci_is_pcie(dev) && pcie_downstream_port(dev) &&
>  	    pos == PCI_EXP_SLTSTA)
>  		*val = PCI_EXP_SLTSTA_PDS;
> @@ -475,6 +492,12 @@ int pcie_capability_write_word(struct pci_dev *dev, int pos, u16 val)
>  	if (!pcie_capability_reg_implemented(dev, pos))
>  		return 0;
>  
> +	if (dev->caps_rw_ops) {
> +		int ret = dev->caps_rw_ops->write(dev, pos, 2, val);
> +		if (ret <= 0)
> +			return ret;
> +	}
> +
>  	return pci_write_config_word(dev, pci_pcie_cap(dev) + pos, val);
>  }
>  EXPORT_SYMBOL(pcie_capability_write_word);
> @@ -487,6 +510,12 @@ int pcie_capability_write_dword(struct pci_dev *dev, int pos, u32 val)
>  	if (!pcie_capability_reg_implemented(dev, pos))
>  		return 0;
>  
> +	if (dev->caps_rw_ops) {
> +		int ret = dev->caps_rw_ops->write(dev, pos, 4, val);
> +		if (ret <= 0)
> +			return ret;
> +	}
> +
>  	return pci_write_config_dword(dev, pci_pcie_cap(dev) + pos, val);
>  }
>  EXPORT_SYMBOL(pcie_capability_write_dword);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 2bda4a4e47e8..ff47ef83ab38 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -311,6 +311,15 @@ struct pci_vpd {
>  	u8		cap;
>  };
>  
> +/*
> + * Capability reads/write redirect
> + * Returns 0, errno, or > 0 if unhandled
> + */
> +struct caps_rw_ops {
> +	int (*read)(struct pci_dev *dev, int pos, int len, u32 *val);
> +	int (*write)(struct pci_dev *dev, int pos, int len, u32 val);
> +};
> +
>  struct irq_affinity;
>  struct pcie_link_state;
>  struct pci_sriov;
> @@ -523,6 +532,8 @@ struct pci_dev {
>  
>  	/* These methods index pci_reset_fn_methods[] */
>  	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
> +
> +	struct caps_rw_ops *caps_rw_ops;
>  };
>  
>  static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
> -- 
> 2.30.2
> 
